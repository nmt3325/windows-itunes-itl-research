; Original iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0xf690b0
; Unwind range 0xf690b0..0xf69289, end exclusive
00f690b0 48895c2408               mov qword ptr [rsp + 8], rbx
00f690b5 48896c2410               mov qword ptr [rsp + 0x10], rbp
00f690ba 56                       push rsi
00f690bb 57                       push rdi
00f690bc 4156                     push r14
00f690be 4883ec20                 sub rsp, 0x20
00f690c2 488bfa                   mov rdi, rdx
00f690c5 8be9                     mov ebp, ecx
00f690c7 488d15329b9a00           lea rdx, [rip + 0x9a9b32]
00f690ce b910010000               mov ecx, 0x110
00f690d3 498bf0                   mov rsi, r8
00f690d6 e8112e8300               call 0x14179beec
00f690db 4889442458               mov qword ptr [rsp + 0x58], rax
00f690e0 488bd8                   mov rbx, rax
00f690e3 4885c0                   test rax, rax
00f690e6 0f8488010000             je 0x140f69274
00f690ec 806375e0                 and byte ptr [rbx + 0x75], 0xe0
00f690f0 488d054909bf00           lea rax, [rip + 0xbf0949]
00f690f7 4533f6                   xor r14d, r14d
00f690fa 488903                   mov qword ptr [rbx], rax
00f690fd 4c897308                 mov qword ptr [rbx + 8], r14
00f69101 488d05e00fbc00           lea rax, [rip + 0xbc0fe0]
00f69108 4c897310                 mov qword ptr [rbx + 0x10], r14
00f6910c 4c897318                 mov qword ptr [rbx + 0x18], r14
00f69110 4c897320                 mov qword ptr [rbx + 0x20], r14
00f69114 4c897328                 mov qword ptr [rbx + 0x28], r14
00f69118 4c897330                 mov qword ptr [rbx + 0x30], r14
00f6911c 4c897338                 mov qword ptr [rbx + 0x38], r14
00f69120 4c897340                 mov qword ptr [rbx + 0x40], r14
00f69124 4c897348                 mov qword ptr [rbx + 0x48], r14
00f69128 4c897350                 mov qword ptr [rbx + 0x50], r14
00f6912c 6644897358               mov word ptr [rbx + 0x58], r14w
00f69131 4489735c                 mov dword ptr [rbx + 0x5c], r14d
00f69135 6644897360               mov word ptr [rbx + 0x60], r14w
00f6913a 44887362                 mov byte ptr [rbx + 0x62], r14b
00f6913e 4c897368                 mov qword ptr [rbx + 0x68], r14
00f69142 c7437001000000           mov dword ptr [rbx + 0x70], 1
00f69149 44887374                 mov byte ptr [rbx + 0x74], r14b
00f6914d 44897378                 mov dword ptr [rbx + 0x78], r14d
00f69151 664489737c               mov word ptr [rbx + 0x7c], r14w
00f69156 4489b380000000           mov dword ptr [rbx + 0x80], r14d
00f6915d 4488b384000000           mov byte ptr [rbx + 0x84], r14b
00f69164 4c89b388000000           mov qword ptr [rbx + 0x88], r14
00f6916b 4488b390000000           mov byte ptr [rbx + 0x90], r14b
00f69172 4488b3b8000000           mov byte ptr [rbx + 0xb8], r14b
00f69179 488983c0000000           mov qword ptr [rbx + 0xc0], rax
00f69180 4c89b3c8000000           mov qword ptr [rbx + 0xc8], r14
00f69187 4489b3d0000000           mov dword ptr [rbx + 0xd0], r14d
00f6918e 4c89b3d8000000           mov qword ptr [rbx + 0xd8], r14
00f69195 4c89b3e0000000           mov qword ptr [rbx + 0xe0], r14
00f6919c 488983e8000000           mov qword ptr [rbx + 0xe8], rax
00f691a3 488d8300010000           lea rax, [rbx + 0x100]
00f691aa 4c89b3f0000000           mov qword ptr [rbx + 0xf0], r14
00f691b1 4489b3f8000000           mov dword ptr [rbx + 0xf8], r14d
00f691b8 4885c0                   test rax, rax
00f691bb 7408                     je 0x140f691c5
00f691bd 33c9                     xor ecx, ecx
00f691bf 488908                   mov qword ptr [rax], rcx
00f691c2 894808                   mov dword ptr [rax + 8], ecx
00f691c5 488d8394000000           lea rax, [rbx + 0x94]
00f691cc 4885c0                   test rax, rax
00f691cf 740f                     je 0x140f691e0
00f691d1 0f57c0                   xorps xmm0, xmm0
00f691d4 33c9                     xor ecx, ecx
00f691d6 0f1100                   movups xmmword ptr [rax], xmm0
00f691d9 0f114010                 movups xmmword ptr [rax + 0x10], xmm0
00f691dd 894820                   mov dword ptr [rax + 0x20], ecx
00f691e0 4885db                   test rbx, rbx
00f691e3 0f848b000000             je 0x140f69274
00f691e9 85ed                     test ebp, ebp
00f691eb 7471                     je 0x140f6925e
00f691ed 4885ff                   test rdi, rdi
00f691f0 746c                     je 0x140f6925e
00f691f2 81bf8000000074616474     cmp dword ptr [rdi + 0x80], 0x74646174
00f691fc 7560                     jne 0x140f6925e
00f691fe 81bfac000000ffffff7f     cmp dword ptr [rdi + 0xac], 0x7fffffff
00f69208 7354                     jae 0x140f6925e
00f6920a ba01000000               mov edx, 1
00f6920f c7430869626c61           mov dword ptr [rbx + 8], 0x616c6269
00f69216 89530c                   mov dword ptr [rbx + 0xc], edx
00f69219 48897b30                 mov qword ptr [rbx + 0x30], rdi
00f6921d 896b10                   mov dword ptr [rbx + 0x10], ebp
00f69220 f00fc11508ff0701         lock xadd dword ptr [rip + 0x107ff08], edx
00f69228 895318                   mov dword ptr [rbx + 0x18], edx
00f6922b 4885f6                   test rsi, rsi
00f6922e 750b                     jne 0x140f6923b
00f69230 488bcf                   mov rcx, rdi
00f69233 e8e8edf4ff               call 0x140eb8020
00f69238 488bf0                   mov rsi, rax
00f6923b 48897320                 mov qword ptr [rbx + 0x20], rsi
00f6923f 488b05eadc1301           mov rax, qword ptr [rip + 0x113dcea]
00f69246 8b8858550100             mov ecx, dword ptr [rax + 0x15558]
00f6924c 488b4330                 mov rax, qword ptr [rbx + 0x30]
00f69250 894b1c                   mov dword ptr [rbx + 0x1c], ecx
00f69253 898848200000             mov dword ptr [rax + 0x2048], ecx
00f69259 488bc3                   mov rax, rbx
00f6925c eb18                     jmp 0x140f69276
00f6925e 488b03                   mov rax, qword ptr [rbx]
00f69261 ba01000000               mov edx, 1
00f69266 488bcb                   mov rcx, rbx
00f69269 ff5008                   call qword ptr [rax + 8]
00f6926c 498bde                   mov rbx, r14
00f6926f 488bc3                   mov rax, rbx
00f69272 eb02                     jmp 0x140f69276
00f69274 33c0                     xor eax, eax
00f69276 488b5c2440               mov rbx, qword ptr [rsp + 0x40]
00f6927b 488b6c2448               mov rbp, qword ptr [rsp + 0x48]
00f69280 4883c420                 add rsp, 0x20
00f69284 415e                     pop r14
00f69286 5f                       pop rdi
00f69287 5e                       pop rsi
00f69288 c3                       ret 