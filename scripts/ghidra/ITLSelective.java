// Targeted static disassembly and decompilation. Does not execute the sample.
// @category ITL
import ghidra.app.script.GhidraScript;
import ghidra.app.cmd.disassemble.DisassembleCommand;
import ghidra.app.decompiler.*;
import ghidra.program.model.address.*;
import ghidra.program.model.listing.*;
import ghidra.program.model.symbol.*;
import java.nio.file.*;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.io.*;
public class ITLSelective extends GhidraScript {
 public void run() throws Exception {
  String[] args=getScriptArgs(); Path root=Path.of(args[0]);
  String targetsFile=args.length>1?args[1]:"targets1.txt";
  String outName=args.length>2?args[2]:"decompiled1";
  Path out=root.resolve(outName);Files.createDirectories(out);
  long base=currentProgram.getImageBase().getOffset();
  Map<Long,AddressSet> groups=new TreeMap<>();
  for(String line:Files.readAllLines(root.resolve("function_groups.tsv"))){
   String[] p=line.trim().split("\\s+");long o=Long.parseLong(p[0],16);long s=Long.parseLong(p[1],16);long e=Long.parseLong(p[2],16);
   groups.computeIfAbsent(o,k->new AddressSet()).add(toAddr(base+s),toAddr(base+e-1));
  }
  List<Long> targets=new ArrayList<>();
  for(String line:Files.readAllLines(root.resolve(targetsFile))){if(!line.isBlank())targets.add(Long.parseLong(line.trim(),16));}
  for(long rva:targets){
   Address a=toAddr(base+rva);AddressSet body=groups.get(rva);
   if(body==null){println("MISSING GROUP "+Long.toHexString(rva));continue;}
   println("DEFINE "+Long.toHexString(rva)+" bytes="+body.getNumAddresses());
   DisassembleCommand cmd=new DisassembleCommand(a,body,true);cmd.applyTo(currentProgram,monitor);
   // Include all chained-unwind fragments even if their only entry is through an exception edge.
   for(AddressRange range:body.getAddressRanges()){
    if(getInstructionAt(range.getMinAddress())==null)new DisassembleCommand(range.getMinAddress(),body,true).applyTo(currentProgram,monitor);
   }
   Function f=getFunctionAt(a);
   if(f==null)f=currentProgram.getFunctionManager().createFunction("itl_"+Long.toHexString(rva),a,body,SourceType.USER_DEFINED);
   else f.setBody(body);
  }
  Set<Long> callees=new TreeSet<>();
  for(long rva:targets){AddressSet body=groups.get(rva);if(body==null)continue;
   for(Instruction ins:currentProgram.getListing().getInstructions(body,true)){
    if(!ins.getFlowType().isCall())continue;
    for(Address dst:ins.getFlows())if(groups.containsKey(dst.getOffset()-base))callees.add(dst.getOffset()-base);
   }
  }
  for(long rva:callees){Address a=toAddr(base+rva);if(getFunctionAt(a)==null){
   try{currentProgram.getFunctionManager().createFunction("sub_"+Long.toHexString(rva),a,groups.get(rva),SourceType.ANALYSIS);}catch(Exception ex){println("CALLEE WARNING "+Long.toHexString(rva)+" "+ex.getMessage());}
  }}
  // Verified MSVC /GS helper preserves RAX on success. Model it using Ghidra's shipped fixup,
  // otherwise the unanalysed call hides native status returns in caller decompilation.
  String cookieRvaArg=args.length>3?args[3]:"179b8e0";
  if(!cookieRvaArg.equalsIgnoreCase("none")){
   long cookieRva=Long.parseLong(cookieRvaArg,16);
   Function cookie=getFunctionAt(toAddr(base+cookieRva));
   if(cookie==null)throw new IllegalStateException("Verified security cookie function missing at RVA 0x"+cookieRvaArg);
   cookie.setName("__security_check_cookie",SourceType.USER_DEFINED);
   cookie.setReturnType(ghidra.program.model.data.VoidDataType.dataType,SourceType.USER_DEFINED);
   cookie.setCallFixup("security_check_cookie");
   println("Applied verified MSVC cookie fixup at "+currentProgram.getName()+"+0x"+cookieRvaArg);
  }else println("Skipped iTunes-specific security cookie fixup by explicit request");
  DecompInterface di=new DecompInterface();DecompileOptions opts=new DecompileOptions();di.setOptions(opts);
  di.toggleCCode(true);di.toggleSyntaxTree(true);di.setSimplificationStyle("decompile");di.openProgram(currentProgram);
  int ok=0,failed=0;
  try(PrintWriter summary=new PrintWriter(Files.newBufferedWriter(out.resolve("summary.tsv"),StandardCharsets.UTF_8))){
   summary.println("module\trva\tname\tbytes\tcompleted\terror");
   for(long rva:targets){monitor.checkCancelled();Function f=getFunctionAt(toAddr(base+rva));if(f==null){failed++;continue;}
    DecompileResults result=di.decompileFunction(f,60,monitor);
    boolean success=result.decompileCompleted()&&result.getDecompiledFunction()!=null;
    summary.println(currentProgram.getName()+"\t0x"+Long.toHexString(rva)+"\t"+f.getName()+"\t"+f.getBody().getNumAddresses()+"\t"+success+"\t"+result.getErrorMessage().replace('\n',' '));summary.flush();
    if(success){String c="/* Actual Ghidra 12.1.3 decompilation; module="+currentProgram.getName()+"; image_base=0x"+Long.toHexString(base)+"; RVA=0x"+Long.toHexString(rva)+"; SHA256="+currentProgram.getExecutableSHA256()+" */\n"+result.getDecompiledFunction().getC();Files.writeString(out.resolve(String.format("%08x.c",rva)),c);ok++;}else failed++;
    println("DECOMPILE "+Long.toHexString(rva)+" success="+success+" "+result.getErrorMessage());
   }
  }finally{di.dispose();}
  println("ITL_SELECTIVE_DONE success="+ok+" failed="+failed);
 }
}
