; Original iTunes.exe machine code; base=0x140000000; RVA=0x106a3a0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x106a3a0..0x106a3d9 (exclusive)
0106a3a0 push       rbx
0106a3a2 sub        rsp, 0x40
0106a3a6 mov        rax, qword ptr [rip + 0xf6ac93]
0106a3ad xor        rax, rsp
0106a3b0 mov        qword ptr [rsp + 0x30], rax
0106a3b5 movups     xmm0, xmmword ptr [rip + 0xaf9734]
0106a3bc neg        dl
0106a3be mov        rbx, rcx
0106a3c1 sbb        edx, edx
0106a3c3 add        edx, 2
0106a3c6 movups     xmmword ptr [rsp + 0x20], xmm0
0106a3cb call       0x140bfbe20
0106a3d0 test       eax, eax
0106a3d2 jne        0x14106a41b
0106a3d4 lea        rax, [rsp + 0x20]
; range 0x106a3d9..0x106a41b (exclusive)
0106a3d9 mov        qword ptr [rsp + 0x58], rdi
0106a3de mov        rcx, rbx
0106a3e1 mov        qword ptr [rbx + 0x10], rax
0106a3e5 mov        byte ptr [rbx + 0x18], 0x10
0106a3e9 mov        dword ptr [rbx + 8], 1
0106a3f0 mov        qword ptr [rbx + 0x28], 0
0106a3f8 call       0x140bfbf10
0106a3fd mov        edi, eax
0106a3ff test       eax, eax
0106a401 je         0x14106a414
0106a403 xor        r8d, r8d
0106a406 xor        edx, edx
0106a408 mov        rcx, rbx
0106a40b call       0x140bfc0d0
0106a410 mov        eax, edi
0106a412 jmp        0x14106a416
0106a414 xor        eax, eax
0106a416 mov        rdi, qword ptr [rsp + 0x58]
; range 0x106a41b..0x106a42e (exclusive)
0106a41b mov        rcx, qword ptr [rsp + 0x30]
0106a420 xor        rcx, rsp
0106a423 call       0x14179b8e0
0106a428 add        rsp, 0x40
0106a42c pop        rbx
0106a42d ret        
