; Original iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0xf930a0
; Unwind range 0xf930a0..0xf932a4, end exclusive
00f930a0 48895c2410               mov qword ptr [rsp + 0x10], rbx
00f930a5 48896c2418               mov qword ptr [rsp + 0x18], rbp
00f930aa 4889742420               mov qword ptr [rsp + 0x20], rsi
00f930af 48894c2408               mov qword ptr [rsp + 8], rcx
00f930b4 57                       push rdi
00f930b5 4883ec40                 sub rsp, 0x40
00f930b9 33ed                     xor ebp, ebp
00f930bb 488bf9                   mov rdi, rcx
00f930be 4885c9                   test rcx, rcx
00f930c1 7406                     je 0x140f930c9
00f930c3 488b5910                 mov rbx, qword ptr [rcx + 0x10]
00f930c7 eb03                     jmp 0x140f930cc
00f930c9 488bdd                   mov rbx, rbp
00f930cc 48896918                 mov qword ptr [rcx + 0x18], rbp
00f930d0 488b83d0000000           mov rax, qword ptr [rbx + 0xd0]
00f930d7 48894120                 mov qword ptr [rcx + 0x20], rax
00f930db 488b83d0000000           mov rax, qword ptr [rbx + 0xd0]
00f930e2 4885c0                   test rax, rax
00f930e5 7406                     je 0x140f930ed
00f930e7 48897818                 mov qword ptr [rax + 0x18], rdi
00f930eb eb07                     jmp 0x140f930f4
00f930ed 4889bbc8000000           mov qword ptr [rbx + 0xc8], rdi
00f930f4 ff83a4000000             inc dword ptr [rbx + 0xa4]
00f930fa 808b1001000010           or byte ptr [rbx + 0x110], 0x10
00f93101 4889bbd0000000           mov qword ptr [rbx + 0xd0], rdi
00f93108 488b4910                 mov rcx, qword ptr [rcx + 0x10]
00f9310c 4885c9                   test rcx, rcx
00f9310f 7467                     je 0x140f93178
00f93111 81b98000000074616474     cmp dword ptr [rcx + 0x80], 0x74646174
00f9311b 755b                     jne 0x140f93178
00f9311d 488b050c3e1101           mov rax, qword ptr [rip + 0x1113e0c]
00f93124 8b9058550100             mov edx, dword ptr [rax + 0x15558]
00f9312a 8997a8000000             mov dword ptr [rdi + 0xa8], edx
00f93130 899148200000             mov dword ptr [rcx + 0x2048], edx
00f93136 488b4f60                 mov rcx, qword ptr [rdi + 0x60]
00f9313a 4885c9                   test rcx, rcx
00f9313d 7416                     je 0x140f93155
00f9313f 90                       nop 
00f93140 488b01                   mov rax, qword ptr [rcx]
00f93143 895144                   mov dword ptr [rcx + 0x44], edx
00f93146 899004040000             mov dword ptr [rax + 0x404], edx
00f9314c 488b4938                 mov rcx, qword ptr [rcx + 0x38]
00f93150 4885c9                   test rcx, rcx
00f93153 75eb                     jne 0x140f93140
00f93155 488b5728                 mov rdx, qword ptr [rdi + 0x28]
00f93159 4885d2                   test rdx, rdx
00f9315c 741a                     je 0x140f93178
00f9315e 488b05cb3d1101           mov rax, qword ptr [rip + 0x1113dcb]
00f93165 8b8858550100             mov ecx, dword ptr [rax + 0x15558]
00f9316b 488b4230                 mov rax, qword ptr [rdx + 0x30]
00f9316f 894a1c                   mov dword ptr [rdx + 0x1c], ecx
00f93172 898848200000             mov dword ptr [rax + 0x2048], ecx
00f93178 488b8bd8180000           mov rcx, qword ptr [rbx + 0x18d8]
00f9317f 4885c9                   test rcx, rcx
00f93182 7418                     je 0x140f9319c
00f93184 396f08                   cmp dword ptr [rdi + 8], ebp
00f93187 4c8d4708                 lea r8, [rdi + 8]
00f9318b 740f                     je 0x140f9319c
00f9318d 4c8d4c2450               lea r9, [rsp + 0x50]
00f93192 488d542420               lea rdx, [rsp + 0x20]
00f93197 e8d40370ff               call 0x140693570
00f9319c 488b8be0180000           mov rcx, qword ptr [rbx + 0x18e0]
00f931a3 4885c9                   test rcx, rcx
00f931a6 7417                     je 0x140f931bf
00f931a8 48392f                   cmp qword ptr [rdi], rbp
00f931ab 7412                     je 0x140f931bf
00f931ad 4c8d4c2450               lea r9, [rsp + 0x50]
00f931b2 4c8bc7                   mov r8, rdi
00f931b5 488d542420               lea rdx, [rsp + 0x20]
00f931ba e83137b6ff               call 0x140af68f0
00f931bf 488bb3e8180000           mov rsi, qword ptr [rbx + 0x18e8]
00f931c6 4885f6                   test rsi, rsi
00f931c9 743d                     je 0x140f93208
00f931cb 4c8d8748010000           lea r8, [rdi + 0x148]
00f931d2 493928                   cmp qword ptr [r8], rbp
00f931d5 7414                     je 0x140f931eb
00f931d7 4c8d4c2450               lea r9, [rsp + 0x50]
00f931dc 488bce                   mov rcx, rsi
00f931df 488d542420               lea rdx, [rsp + 0x20]
00f931e4 e80737b6ff               call 0x140af68f0
00f931e9 eb1d                     jmp 0x140f93208
00f931eb 488b0e                   mov rcx, qword ptr [rsi]
00f931ee ff154c919500             call qword ptr [rip + 0x95914c]
00f931f4 ba18000000               mov edx, 0x18
00f931f9 488bce                   mov rcx, rsi
00f931fc e81f38c3ff               call 0x140bc6a20
00f93201 4889abe8180000           mov qword ptr [rbx + 0x18e8], rbp
00f93208 488b8b50190000           mov rcx, qword ptr [rbx + 0x1950]
00f9320f 4885c9                   test rcx, rcx
00f93212 7406                     je 0x140f9321a
00f93214 ff154e919500             call qword ptr [rip + 0x95914e]
00f9321a 488bbb60190000           mov rdi, qword ptr [rbx + 0x1960]
00f93221 4889ab50190000           mov qword ptr [rbx + 0x1950], rbp
00f93228 4889ab58190000           mov qword ptr [rbx + 0x1958], rbp
00f9322f 4889ab60190000           mov qword ptr [rbx + 0x1960], rbp
00f93236 4885ff                   test rdi, rdi
00f93239 742c                     je 0x140f93267
00f9323b beffffffff               mov esi, 0xffffffff
00f93240 8bc6                     mov eax, esi
00f93242 f00fc14708               lock xadd dword ptr [rdi + 8], eax
00f93247 83f801                   cmp eax, 1
00f9324a 751b                     jne 0x140f93267
00f9324c 488b07                   mov rax, qword ptr [rdi]
00f9324f 488bcf                   mov rcx, rdi
00f93252 ff10                     call qword ptr [rax]
00f93254 f00fc1770c               lock xadd dword ptr [rdi + 0xc], esi
00f93259 83fe01                   cmp esi, 1
00f9325c 7509                     jne 0x140f93267
00f9325e 488b07                   mov rax, qword ptr [rdi]
00f93261 488bcf                   mov rcx, rdi
00f93264 ff5008                   call qword ptr [rax + 8]
00f93267 488bbb38190000           mov rdi, qword ptr [rbx + 0x1938]
00f9326e 4885ff                   test rdi, rdi
00f93271 7415                     je 0x140f93288
00f93273 488bcf                   mov rcx, rdi
00f93276 e8056736ff               call 0x1402f9980
00f9327b ba10000000               mov edx, 0x10
00f93280 488bcf                   mov rcx, rdi
00f93283 e89837c3ff               call 0x140bc6a20
00f93288 488b742468               mov rsi, qword ptr [rsp + 0x68]
00f9328d 4889ab38190000           mov qword ptr [rbx + 0x1938], rbp
00f93294 488b5c2458               mov rbx, qword ptr [rsp + 0x58]
00f93299 488b6c2460               mov rbp, qword ptr [rsp + 0x60]
00f9329e 4883c440                 add rsp, 0x40
00f932a2 5f                       pop rdi
00f932a3 c3                       ret 