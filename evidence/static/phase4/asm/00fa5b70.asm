; Original iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0xfa5b70
; Unwind range 0xfa5b70..0xfa5c8b, end exclusive
00fa5b70 48895c2408               mov qword ptr [rsp + 8], rbx
00fa5b75 48896c2410               mov qword ptr [rsp + 0x10], rbp
00fa5b7a 4889742418               mov qword ptr [rsp + 0x18], rsi
00fa5b7f 57                       push rdi
00fa5b80 4883ec20                 sub rsp, 0x20
00fa5b84 418bf0                   mov esi, r8d
00fa5b87 8bea                     mov ebp, edx
00fa5b89 488bf9                   mov rdi, rcx
00fa5b8c 4885c9                   test rcx, rcx
00fa5b8f 0f84df000000             je 0x140fa5c74
00fa5b95 488b4910                 mov rcx, qword ptr [rcx + 0x10]
00fa5b99 4885c9                   test rcx, rcx
00fa5b9c 0f84d2000000             je 0x140fa5c74
00fa5ba2 488b8928010000           mov rcx, qword ptr [rcx + 0x128]
00fa5ba9 e80207c2ff               call 0x140bc62b0
00fa5bae 488bd8                   mov rbx, rax
00fa5bb1 4885c0                   test rax, rax
00fa5bb4 0f84ba000000             je 0x140fa5c74
00fa5bba b901000000               mov ecx, 1
00fa5bbf f00fc10d69350401         lock xadd dword ptr [rip + 0x1043569], ecx
00fa5bc7 894828                   mov dword ptr [rax + 0x28], ecx
00fa5bca 4533c0                   xor r8d, r8d
00fa5bcd 896834                   mov dword ptr [rax + 0x34], ebp
00fa5bd0 488bd7                   mov rdx, rdi
00fa5bd3 488d0536171001           lea rax, [rip + 0x1101736]
00fa5bda 488bcb                   mov rcx, rbx
00fa5bdd 48894310                 mov qword ptr [rbx + 0x10], rax
00fa5be1 488d05d8141001           lea rax, [rip + 0x11014d8]
00fa5be8 48894318                 mov qword ptr [rbx + 0x18], rax
00fa5bec 488d05d5171001           lea rax, [rip + 0x11017d5]
00fa5bf3 48894320                 mov qword ptr [rbx + 0x20], rax
00fa5bf7 e834f9ffff               call 0x140fa5530
00fa5bfc 488d7b58                 lea rdi, [rbx + 0x58]
00fa5c00 85f6                     test esi, esi
00fa5c02 7524                     jne 0x140fa5c28
00fa5c04 ff15ce319400             call qword ptr [rip + 0x9431ce]
00fa5c0a 488b053f329400           mov rax, qword ptr [rip + 0x94323f]
00fa5c11 f20f5800                 addsd xmm0, qword ptr [rax]
00fa5c15 f2480f2cc8               cvttsd2si rcx, xmm0
00fa5c1a e8a129c2ff               call 0x140bc85c0
00fa5c1f 4885ff                   test rdi, rdi
00fa5c22 7406                     je 0x140fa5c2a
00fa5c24 8907                     mov dword ptr [rdi], eax
00fa5c26 eb02                     jmp 0x140fa5c2a
00fa5c28 8937                     mov dword ptr [rdi], esi
00fa5c2a 488b4308                 mov rax, qword ptr [rbx + 8]
00fa5c2e 4885c0                   test rax, rax
00fa5c31 743c                     je 0x140fa5c6f
00fa5c33 4c8b4010                 mov r8, qword ptr [rax + 0x10]
00fa5c37 4d85c0                   test r8, r8
00fa5c3a 7433                     je 0x140fa5c6f
00fa5c3c 8b0d9e8b1501             mov ecx, dword ptr [rip + 0x1158b9e]
00fa5c42 b81f85eb51               mov eax, 0x51eb851f
00fa5c47 ffc1                     inc ecx
00fa5c49 f7e1                     mul ecx
00fa5c4b 890d8f8b1501             mov dword ptr [rip + 0x1158b8f], ecx
00fa5c51 c1ea04                   shr edx, 4
00fa5c54 6bc232                   imul eax, edx, 0x32
00fa5c57 2bc8                     sub ecx, eax
00fa5c59 488d04cd2b010000         lea rax, [rcx*8 + 0x12b]
00fa5c61 4803c1                   add rax, rcx
00fa5c64 498d04c0                 lea rax, [r8 + rax*8]
00fa5c68 488983c8020000           mov qword ptr [rbx + 0x2c8], rax
00fa5c6f 488bc3                   mov rax, rbx
00fa5c72 eb02                     jmp 0x140fa5c76
00fa5c74 33c0                     xor eax, eax
00fa5c76 488b5c2430               mov rbx, qword ptr [rsp + 0x30]
00fa5c7b 488b6c2438               mov rbp, qword ptr [rsp + 0x38]
00fa5c80 488b742440               mov rsi, qword ptr [rsp + 0x40]
00fa5c85 4883c420                 add rsp, 0x20
00fa5c89 5f                       pop rdi
00fa5c8a c3                       ret 