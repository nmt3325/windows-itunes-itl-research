; Original iTunes.exe machine code; base=0x140000000; RVA=0x10c6970; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x10c6970..0x10c69a7 (exclusive)
010c6970 push       rbx
010c6972 sub        rsp, 0x40
010c6976 mov        rax, qword ptr [rip + 0xf0e6c3]
010c697d xor        rax, rsp
010c6980 mov        qword ptr [rsp + 0x30], rax
010c6985 movups     xmm0, xmmword ptr [rip + 0xa9d164]
010c698c mov        edx, 2
010c6991 mov        rbx, rcx
010c6994 movups     xmmword ptr [rsp + 0x20], xmm0
010c6999 call       0x140bfbe20
010c699e test       eax, eax
010c69a0 jne        0x1410c69e9
010c69a2 lea        rax, [rsp + 0x20]
; range 0x10c69a7..0x10c69e9 (exclusive)
010c69a7 mov        qword ptr [rsp + 0x58], rdi
010c69ac mov        rcx, rbx
010c69af mov        qword ptr [rbx + 0x10], rax
010c69b3 mov        byte ptr [rbx + 0x18], 0x10
010c69b7 mov        dword ptr [rbx + 8], 1
010c69be mov        qword ptr [rbx + 0x28], 0
010c69c6 call       0x140bfbf10
010c69cb mov        edi, eax
010c69cd test       eax, eax
010c69cf je         0x1410c69e2
010c69d1 xor        r8d, r8d
010c69d4 xor        edx, edx
010c69d6 mov        rcx, rbx
010c69d9 call       0x140bfc0d0
010c69de mov        eax, edi
010c69e0 jmp        0x1410c69e4
010c69e2 xor        eax, eax
010c69e4 mov        rdi, qword ptr [rsp + 0x58]
; range 0x10c69e9..0x10c69fc (exclusive)
010c69e9 mov        rcx, qword ptr [rsp + 0x30]
010c69ee xor        rcx, rsp
010c69f1 call       0x14179b8e0
010c69f6 add        rsp, 0x40
010c69fa pop        rbx
010c69fb ret        
