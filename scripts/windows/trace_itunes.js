'use strict';
// z_stream follows Windows LLP64: pointers 8, uLong/uInt 4 (not Unix LP64).
const offsets = Process.pointerSize === 8 ? {ni:0, ai:8, ti:12, no:16, ao:24, to:28} : {ni:0,ai:4,ti:8,no:12,ao:16,to:20};
let callId=0;
const installed=new Set(); const files=new Map();
function stack(ctx) {return Thread.backtrace(ctx, Backtracer.ACCURATE).slice(0,12).map(p=> {const m=Process.findModuleByAddress(p);return m ? m.name+'+0x'+p.sub(m.base).toString(16) : p.toString();});}
function emit(o,p,n){ if(n>0 && n<=4194304){try{send(o,p.readByteArray(n));}catch(e){send({...o,capture_error:String(e)});}}else send({...o,capture_skipped:n>0}); }
function hookZlib(m){
 if(installed.has(m.base.toString()) || !/zlib/i.test(m.name))return; installed.add(m.base.toString());
 send({kind:'module',name:m.name,path:m.path,base:m.base.toString(),size:m.size,exports:m.enumerateExports().map(x=>x.name)});
 for(const name of ['inflate','deflate']){
  const p=m.findExportByName(name); if(!p)continue;
  Interceptor.attach(p,{onEnter(args){this.id=++callId;this.s=args[0];this.flush=args[1].toInt32();this.ni=this.s.add(offsets.ni).readPointer();this.no=this.s.add(offsets.no).readPointer();this.ai=this.s.add(offsets.ai).readU32();this.ao=this.s.add(offsets.ao).readU32();this.stack=stack(this.context);},onLeave(ret){
   const ci=this.ai-this.s.add(offsets.ai).readU32(),co=this.ao-this.s.add(offsets.ao).readU32();
   const meta={kind:'zlib',fn:name,id:this.id,stream:this.s.toString(),flush:this.flush,ret:ret.toInt32(),consumed:ci,produced:co,total_in:this.s.add(offsets.ti).readU32(),total_out:this.s.add(offsets.to).readU32(),stack:this.stack};
   emit({...meta,side:'input'},this.ni,ci);emit({...meta,side:'output'},this.no,co);
  }});
 }
}
Process.attachModuleObserver({onAdded:hookZlib});
const kernel=Process.getModuleByName('KERNELBASE.dll');
const create=kernel.findExportByName('CreateFileW');
if(create)Interceptor.attach(create,{onEnter(a){try{this.path=a[0].readUtf16String();}catch(e){}},onLeave(r){if(this.path&&(/\.itl$/i.test(this.path)||/fixtures\\dynamic\\live/i.test(this.path))){files.set(r.toString(),this.path);send({kind:'file_open',handle:r.toString(),path:this.path});}}});
for(const fn of ['ReadFile','WriteFile']){
 const p=kernel.findExportByName(fn);if(!p)continue;
 Interceptor.attach(p,{onEnter(a){this.path=files.get(a[0].toString());if(!this.path)return;this.buf=a[1];this.n=a[2].toUInt32();this.done=a[3];this.stack=stack(this.context);this.id=++callId;},onLeave(r){if(!this.path)return;let n=0;try{if(!this.done.isNull())n=this.done.readU32();}catch(e){} emit({kind:'file_io',fn,id:this.id,path:this.path,requested:this.n,transferred:n,ok:r.toInt32(),stack:this.stack},this.buf,n);}});
}
const close=kernel.findExportByName('CloseHandle');if(close)Interceptor.attach(close,{onEnter(a){files.delete(a[0].toString());}});
send({kind:'ready',pid:Process.id,arch:Process.arch,platform:Process.platform,zstream:offsets});
