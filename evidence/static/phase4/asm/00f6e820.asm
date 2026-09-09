; Original iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0xf6e820
; Unwind range 0xf6e820..0xf6e972, end exclusive
00f6e820 48895c2408               mov qword ptr [rsp + 8], rbx
00f6e825 48896c2410               mov qword ptr [rsp + 0x10], rbp
00f6e82a 4889742418               mov qword ptr [rsp + 0x18], rsi
00f6e82f 57                       push rdi
00f6e830 4156                     push r14
00f6e832 4157                     push r15
00f6e834 4883ec40                 sub rsp, 0x40
00f6e838 418be8                   mov ebp, r8d
00f6e83b 448bfa                   mov r15d, edx
00f6e83e 4c8bf1                   mov r14, rcx
00f6e841 41b802000000             mov r8d, 2
00f6e847 498bd1                   mov rdx, r9
00f6e84a e8c1f8ffff               call 0x140f6e110
00f6e84f 488bf8                   mov rdi, rax
00f6e852 4885c0                   test rax, rax
00f6e855 0f84fc000000             je 0x140f6e957
00f6e85b 488b842490000000         mov rax, qword ptr [rsp + 0x90]
00f6e863 4885c0                   test rax, rax
00f6e866 740e                     je 0x140f6e876
00f6e868 48898780000000           mov qword ptr [rdi + 0x80], rax
00f6e86f 80a78c000000fe           and byte ptr [rdi + 0x8c], 0xfe
00f6e876 488b07                   mov rax, qword ptr [rdi]
00f6e879 0fb6942480000000         movzx edx, byte ptr [rsp + 0x80]
00f6e881 488bcf                   mov rcx, rdi
00f6e884 ff90a8000000             call qword ptr [rax + 0xa8]
00f6e88a 488b9c2488000000         mov rbx, qword ptr [rsp + 0x88]
00f6e892 4885db                   test rbx, rbx
00f6e895 745b                     je 0x140f6e8f2
00f6e897 488d542430               lea rdx, [rsp + 0x30]
00f6e89c 488bcf                   mov rcx, rdi
00f6e89f e85c220000               call 0x140f70b00
00f6e8a4 90                       nop 
00f6e8a5 488b4c2430               mov rcx, qword ptr [rsp + 0x30]
00f6e8aa 4885c9                   test rcx, rcx
00f6e8ad 740d                     je 0x140f6e8bc
00f6e8af 488b01                   mov rax, qword ptr [rcx]
00f6e8b2 488bd3                   mov rdx, rbx
00f6e8b5 ff9020020000             call qword ptr [rax + 0x220]
00f6e8bb 90                       nop 
00f6e8bc 488b5c2438               mov rbx, qword ptr [rsp + 0x38]
00f6e8c1 4885db                   test rbx, rbx
00f6e8c4 742c                     je 0x140f6e8f2
00f6e8c6 beffffffff               mov esi, 0xffffffff
00f6e8cb 8bc6                     mov eax, esi
00f6e8cd f00fc14308               lock xadd dword ptr [rbx + 8], eax
00f6e8d2 83f801                   cmp eax, 1
00f6e8d5 751b                     jne 0x140f6e8f2
00f6e8d7 488b03                   mov rax, qword ptr [rbx]
00f6e8da 488bcb                   mov rcx, rbx
00f6e8dd ff10                     call qword ptr [rax]
00f6e8df f00fc1730c               lock xadd dword ptr [rbx + 0xc], esi
00f6e8e4 83fe01                   cmp esi, 1
00f6e8e7 7509                     jne 0x140f6e8f2
00f6e8e9 488b03                   mov rax, qword ptr [rbx]
00f6e8ec 488bcb                   mov rcx, rbx
00f6e8ef ff5008                   call qword ptr [rax + 8]
00f6e8f2 498d9608020000           lea rdx, [r14 + 0x208]
00f6e8f9 488d8ff8000000           lea rcx, [rdi + 0xf8]
00f6e900 4533c9                   xor r9d, r9d
00f6e903 458bc7                   mov r8d, r15d
00f6e906 e8e516c9ff               call 0x140bffff0
00f6e90b 498d96f8170000           lea rdx, [r14 + 0x17f8]
00f6e912 488d8f10010000           lea rcx, [rdi + 0x110]
00f6e919 4533c9                   xor r9d, r9d
00f6e91c 448bc5                   mov r8d, ebp
00f6e91f e8cc16c9ff               call 0x140bffff0
00f6e924 488bcf                   mov rcx, rdi
00f6e927 e884feffff               call 0x140f6e7b0
00f6e92c 498b0e                   mov rcx, qword ptr [r14]
00f6e92f 488b4108                 mov rax, qword ptr [rcx + 8]
00f6e933 48c744242000000000       mov qword ptr [rsp + 0x20], 0
00f6e93c 4c8bcf                   mov r9, rdi
00f6e93f 4d8bc6                   mov r8, r14
00f6e942 ba61613274               mov edx, 0x74326161
00f6e947 498bce                   mov rcx, r14
00f6e94a ffd0                     call rax
00f6e94c 488b842498000000         mov rax, qword ptr [rsp + 0x98]
00f6e954 488938                   mov qword ptr [rax], rdi
00f6e957 33c0                     xor eax, eax
00f6e959 488b5c2460               mov rbx, qword ptr [rsp + 0x60]
00f6e95e 488b6c2468               mov rbp, qword ptr [rsp + 0x68]
00f6e963 488b742470               mov rsi, qword ptr [rsp + 0x70]
00f6e968 4883c440                 add rsp, 0x40
00f6e96c 415f                     pop r15
00f6e96e 415e                     pop r14
00f6e970 5f                       pop rdi
00f6e971 c3                       ret 