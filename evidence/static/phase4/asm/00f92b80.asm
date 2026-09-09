; Original iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0xf92b80
; Unwind range 0xf92b80..0xf92e62, end exclusive
00f92b80 4c894c2420               mov qword ptr [rsp + 0x20], r9
00f92b85 4c89442418               mov qword ptr [rsp + 0x18], r8
00f92b8a 55                       push rbp
00f92b8b 56                       push rsi
00f92b8c 57                       push rdi
00f92b8d 4156                     push r14
00f92b8f 4883ec28                 sub rsp, 0x28
00f92b93 488bf9                   mov rdi, rcx
00f92b96 33ed                     xor ebp, ebp
00f92b98 8b89a4000000             mov ecx, dword ptr [rcx + 0xa4]
00f92b9e 4d8bf1                   mov r14, r9
00f92ba1 8bf2                     mov esi, edx
00f92ba3 81f9ffffff7f             cmp ecx, 0x7fffffff
00f92ba9 720c                     jb 0x140f92bb7
00f92bab 33c0                     xor eax, eax
00f92bad 4883c428                 add rsp, 0x28
00f92bb1 415e                     pop r14
00f92bb3 5f                       pop rdi
00f92bb4 5e                       pop rsi
00f92bb5 5d                       pop rbp
00f92bb6 c3                       ret 
00f92bb7 b8cdcccccc               mov eax, 0xcccccccd
00f92bbc 48895c2420               mov qword ptr [rsp + 0x20], rbx
00f92bc1 f7e1                     mul ecx
00f92bc3 c1ea03                   shr edx, 3
00f92bc6 83fa64                   cmp edx, 0x64
00f92bc9 7307                     jae 0x140f92bd2
00f92bcb ba64000000               mov edx, 0x64
00f92bd0 eb0a                     jmp 0x140f92bdc
00f92bd2 b8d0070000               mov eax, 0x7d0
00f92bd7 3bd0                     cmp edx, eax
00f92bd9 0f47d0                   cmova edx, eax
00f92bdc 488b8720010000           mov rax, qword ptr [rdi + 0x120]
00f92be3 4885c0                   test rax, rax
00f92be6 740f                     je 0x140f92bf7
00f92be8 813841786946             cmp dword ptr [rax], 0x46697841
00f92bee 7507                     jne 0x140f92bf7
00f92bf0 85d2                     test edx, edx
00f92bf2 7403                     je 0x140f92bf7
00f92bf4 895008                   mov dword ptr [rax + 8], edx
00f92bf7 488b8728010000           mov rax, qword ptr [rdi + 0x128]
00f92bfe 4885c0                   test rax, rax
00f92c01 740f                     je 0x140f92c12
00f92c03 813841786946             cmp dword ptr [rax], 0x46697841
00f92c09 7507                     jne 0x140f92c12
00f92c0b 85d2                     test edx, edx
00f92c0d 7403                     je 0x140f92c12
00f92c0f 895008                   mov dword ptr [rax + 8], edx
00f92c12 488b8730010000           mov rax, qword ptr [rdi + 0x130]
00f92c19 d1ea                     shr edx, 1
00f92c1b 4885c0                   test rax, rax
00f92c1e 740f                     je 0x140f92c2f
00f92c20 813841786946             cmp dword ptr [rax], 0x46697841
00f92c26 7507                     jne 0x140f92c2f
00f92c28 85d2                     test edx, edx
00f92c2a 7403                     je 0x140f92c2f
00f92c2c 895008                   mov dword ptr [rax + 8], edx
00f92c2f 488b8738010000           mov rax, qword ptr [rdi + 0x138]
00f92c36 4885c0                   test rax, rax
00f92c39 740f                     je 0x140f92c4a
00f92c3b 813841786946             cmp dword ptr [rax], 0x46697841
00f92c41 7507                     jne 0x140f92c4a
00f92c43 85d2                     test edx, edx
00f92c45 7403                     je 0x140f92c4a
00f92c47 895008                   mov dword ptr [rax + 8], edx
00f92c4a 488b8f20010000           mov rcx, qword ptr [rdi + 0x120]
00f92c51 e85a36c3ff               call 0x140bc62b0
00f92c56 488bd8                   mov rbx, rax
00f92c59 4885c0                   test rax, rax
00f92c5c 0f84ee010000             je 0x140f92e50
00f92c62 48897810                 mov qword ptr [rax + 0x10], rdi
00f92c66 b801000000               mov eax, 1
00f92c6b f00fc105bd640501         lock xadd dword ptr [rip + 0x10564bd], eax
00f92c73 894308                   mov dword ptr [rbx + 8], eax
00f92c76 488d0593c91101           lea rax, [rip + 0x111c993]
00f92c7d 48894368                 mov qword ptr [rbx + 0x68], rax
00f92c81 488d0598431101           lea rax, [rip + 0x1114398]
00f92c88 48894370                 mov qword ptr [rbx + 0x70], rax
00f92c8c 488d050d441101           lea rax, [rip + 0x111440d]
00f92c93 48894378                 mov qword ptr [rbx + 0x78], rax
00f92c97 488d05c2431101           lea rax, [rip + 0x11143c2]
00f92c9e 48898380000000           mov qword ptr [rbx + 0x80], rax
00f92ca5 488b442478               mov rax, qword ptr [rsp + 0x78]
00f92caa 4885c0                   test rax, rax
00f92cad 7508                     jne 0x140f92cb7
00f92caf 488bcf                   mov rcx, rdi
00f92cb2 e86953f2ff               call 0x140eb8020
00f92cb7 448b442470               mov r8d, dword ptr [rsp + 0x70]
00f92cbc 8bd6                     mov edx, esi
00f92cbe 488903                   mov qword ptr [rbx], rax
00f92cc1 488b0568421101           mov rax, qword ptr [rip + 0x1114268]
00f92cc8 8b8858550100             mov ecx, dword ptr [rax + 0x15558]
00f92cce 898ba8000000             mov dword ptr [rbx + 0xa8], ecx
00f92cd4 488bcb                   mov rcx, rbx
00f92cd7 e8942e0100               call 0x140fa5b70
00f92cdc 4885c0                   test rax, rax
00f92cdf 0f8461010000             je 0x140f92e46
00f92ce5 80bf4120000001           cmp byte ptr [rdi + 0x2041], 1
00f92cec 7507                     jne 0x140f92cf5
00f92cee 4088af41200000           mov byte ptr [rdi + 0x2041], bpl
00f92cf5 488b742460               mov rsi, qword ptr [rsp + 0x60]
00f92cfa 4885f6                   test rsi, rsi
00f92cfd 7530                     jne 0x140f92d2f
00f92cff 488bcf                   mov rcx, rdi
00f92d02 e809cff3ff               call 0x140ecfc10
00f92d07 488bcf                   mov rcx, rdi
00f92d0a 84c0                     test al, al
00f92d0c 740f                     je 0x140f92d1d
00f92d0e e85d830f00               call 0x14108b070
00f92d13 488bf0                   mov rsi, rax
00f92d16 4889442460               mov qword ptr [rsp + 0x60], rax
00f92d1b eb27                     jmp 0x140f92d44
00f92d1d 4c8d4c2460               lea r9, [rsp + 0x60]
00f92d22 41b001                   mov r8b, 1
00f92d25 488bd3                   mov rdx, rbx
00f92d28 e833760f00               call 0x14108a360
00f92d2d eb10                     jmp 0x140f92d3f
00f92d2f ff159b7a9500             call qword ptr [rip + 0x957a9b]
00f92d35 8bc8                     mov ecx, eax
00f92d37 e8a4d3c3ff               call 0x140bd00e0
00f92d3c ff460c                   inc dword ptr [rsi + 0xc]
00f92d3f 488b742460               mov rsi, qword ptr [rsp + 0x60]
00f92d44 4885f6                   test rsi, rsi
00f92d47 745e                     je 0x140f92da7
00f92d49 817e0869626c61           cmp dword ptr [rsi + 8], 0x616c6269
00f92d50 751a                     jne 0x140f92d6c
00f92d52 48396e30                 cmp qword ptr [rsi + 0x30], rbp
00f92d56 7414                     je 0x140f92d6c
00f92d58 488bd3                   mov rdx, rbx
00f92d5b 488bce                   mov rcx, rsi
00f92d5e e87d96fdff               call 0x140f6c3e0
00f92d63 488b742460               mov rsi, qword ptr [rsp + 0x60]
00f92d68 8be8                     mov ebp, eax
00f92d6a eb05                     jmp 0x140f92d71
00f92d6c bdceffffff               mov ebp, 0xffffffce
00f92d71 4885f6                   test rsi, rsi
00f92d74 7429                     je 0x140f92d9f
00f92d76 ff15547a9500             call qword ptr [rip + 0x957a54]
00f92d7c 8bc8                     mov ecx, eax
00f92d7e e85dd3c3ff               call 0x140bd00e0
00f92d83 836e0c01                 sub dword ptr [rsi + 0xc], 1
00f92d87 7516                     jne 0x140f92d9f
00f92d89 488bce                   mov rcx, rsi
00f92d8c e87f65fdff               call 0x140f69310
00f92d91 488b06                   mov rax, qword ptr [rsi]
00f92d94 ba01000000               mov edx, 1
00f92d99 488bce                   mov rcx, rsi
00f92d9c ff5008                   call qword ptr [rax + 8]
00f92d9f 85ed                     test ebp, ebp
00f92da1 0f859f000000             jne 0x140f92e46
00f92da7 4d85f6                   test r14, r14
00f92daa 753c                     jne 0x140f92de8
00f92dac 488bcf                   mov rcx, rdi
00f92daf e85ccef3ff               call 0x140ecfc10
00f92db4 84c0                     test al, al
00f92db6 7523                     jne 0x140f92ddb
00f92db8 f6871401000010           test byte ptr [rdi + 0x114], 0x10
00f92dbf 751a                     jne 0x140f92ddb
00f92dc1 4c8d4c2468               lea r9, [rsp + 0x68]
00f92dc6 4533c0                   xor r8d, r8d
00f92dc9 488bd3                   mov rdx, rbx
00f92dcc 488bcf                   mov rcx, rdi
00f92dcf e83cc3fdff               call 0x140f6f110
00f92dd4 4c8b742468               mov r14, qword ptr [rsp + 0x68]
00f92dd9 eb26                     jmp 0x140f92e01
00f92ddb 488bcf                   mov rcx, rdi
00f92dde e8edf3fdff               call 0x140f721d0
00f92de3 4c8bf0                   mov r14, rax
00f92de6 eb19                     jmp 0x140f92e01
00f92de8 ff15e2799500             call qword ptr [rip + 0x9579e2]
00f92dee 8bc8                     mov ecx, eax
00f92df0 e8ebd2c3ff               call 0x140bd00e0
00f92df5 498b06                   mov rax, qword ptr [r14]
00f92df8 498bce                   mov rcx, r14
00f92dfb ff90c0000000             call qword ptr [rax + 0xc0]
00f92e01 4d85f6                   test r14, r14
00f92e04 742d                     je 0x140f92e33
00f92e06 488bd3                   mov rdx, rbx
00f92e09 498bce                   mov rcx, r14
00f92e0c e8efcbfdff               call 0x140f6fa00
00f92e11 8be8                     mov ebp, eax
00f92e13 ff15b7799500             call qword ptr [rip + 0x9579b7]
00f92e19 8bc8                     mov ecx, eax
00f92e1b e8c0d2c3ff               call 0x140bd00e0
00f92e20 498b0e                   mov rcx, qword ptr [r14]
00f92e23 488b91c8000000           mov rdx, qword ptr [rcx + 0xc8]
00f92e2a 498bce                   mov rcx, r14
00f92e2d ffd2                     call rdx
00f92e2f 85ed                     test ebp, ebp
00f92e31 7513                     jne 0x140f92e46
00f92e33 488bcb                   mov rcx, rbx
00f92e36 e865020000               call 0x140f930a0
00f92e3b 808b9a00000001           or byte ptr [rbx + 0x9a], 1
00f92e42 85ed                     test ebp, ebp
00f92e44 740a                     je 0x140f92e50
00f92e46 488bcb                   mov rcx, rbx
00f92e49 e852e2ffff               call 0x140f910a0
00f92e4e 33db                     xor ebx, ebx
00f92e50 488bc3                   mov rax, rbx
00f92e53 488b5c2420               mov rbx, qword ptr [rsp + 0x20]
00f92e58 4883c428                 add rsp, 0x28
00f92e5c 415e                     pop r14
00f92e5e 5f                       pop rdi
00f92e5f 5e                       pop rsi
00f92e60 5d                       pop rbp
00f92e61 c3                       ret 