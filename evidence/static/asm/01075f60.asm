; Original iTunes.exe machine code; base=0x140000000; RVA=0x1075f60; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1075f60..0x1076092 (exclusive)
01075f60 mov        qword ptr [rsp + 8], rbx
01075f65 push       rdi
01075f66 sub        rsp, 0xb0
01075f6d mov        rax, qword ptr [rip + 0xf5f0cc]
01075f74 xor        rax, rsp
01075f77 mov        qword ptr [rsp + 0xa0], rax
01075f7f xor        edi, edi
01075f81 mov        rbx, r8
01075f84 mov        r9, rcx
01075f87 test       dl, dl
01075f89 je         0x14107600c
01075f8f test       rcx, rcx
01075f92 je         0x141075fe2
01075f94 test       rbx, rbx
01075f97 je         0x141075fe2
01075f99 movzx      edx, word ptr [rcx]
01075f9c mov        eax, 0xff
01075fa1 cmp        edx, eax
01075fa3 jbe        0x141075fb7
01075fa5 mov        word ptr [r8], ax
01075fa9 mov        edx, 0xfe
01075fae lea        rax, [r8 + 2]
01075fb2 mov        rcx, rax
01075fb5 jmp        0x141075fc7
01075fb7 mov        word ptr [r8], dx
01075fbb lea        rax, [r8 + 2]
01075fbf sub        edx, 1
01075fc2 mov        rcx, rax
01075fc5 js         0x141075fe2
01075fc7 sub        r9, rax
01075fca nop        word ptr [rax + rax]
01075fd0 sub        edx, 1
01075fd3 movzx      eax, word ptr [r9 + rcx + 2]
01075fd9 mov        word ptr [rcx], ax
01075fdc lea        rcx, [rcx + 2]
01075fe0 jns        0x141075fd0
01075fe2 lea        r8, [rsp + 0x60]
01075fe7 mov        word ptr [rsp + 0x60], di
01075fec mov        edx, 3
01075ff1 lea        rcx, [rip + 0xa3b8d8]
01075ff8 call       0x140ae5fa0
01075ffd lea        rdx, [rsp + 0x60]
01076002 mov        rcx, rbx
01076005 call       0x140ae48a0
0107600a jmp        0x141076026
0107600c test       rbx, rbx
0107600f je         0x141076026
01076011 mov        edx, 0x14
01076016 mov        word ptr [r8], di
0107601a lea        rcx, [rip + 0xa3bae7]
01076021 call       0x140ae5fa0
01076026 lea        r8, [rsp + 0x60]
0107602b mov        word ptr [rsp + 0x60], di
01076030 mov        edx, 3
01076035 lea        rcx, [rip + 0xa3bb20]
0107603c call       0x140ae5fa0
01076041 xorps      xmm0, xmm0
01076044 mov        qword ptr [rsp + 0x20], rbx
01076049 xorps      xmm1, xmm1
0107604c mov        qword ptr [rsp + 0x50], rbx
01076051 lea        rax, [rsp + 0x60]
01076056 lea        rcx, [rsp + 0x20]
0107605b mov        qword ptr [rsp + 0x28], rax
01076060 movdqu     xmmword ptr [rsp + 0x30], xmm0
01076066 movdqu     xmmword ptr [rsp + 0x40], xmm1
0107606c call       0x140b1a610
01076071 mov        rcx, qword ptr [rsp + 0xa0]
01076079 xor        rcx, rsp
0107607c call       0x14179b8e0
01076081 mov        rbx, qword ptr [rsp + 0xc0]
01076089 add        rsp, 0xb0
01076090 pop        rdi
01076091 ret        
