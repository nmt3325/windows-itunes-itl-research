; Original iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0xf6e110
; Unwind range 0xf6e110..0xf6e1ed, end exclusive
00f6e110 48895c2408               mov qword ptr [rsp + 8], rbx
00f6e115 48896c2410               mov qword ptr [rsp + 0x10], rbp
00f6e11a 4889742418               mov qword ptr [rsp + 0x18], rsi
00f6e11f 57                       push rdi
00f6e120 4883ec20                 sub rsp, 0x20
00f6e124 488bf2                   mov rsi, rdx
00f6e127 488bf9                   mov rdi, rcx
00f6e12a 488d15cf4a9a00           lea rdx, [rip + 0x9a4acf]
00f6e131 b950010000               mov ecx, 0x150
00f6e136 418be8                   mov ebp, r8d
00f6e139 e8aedd8200               call 0x14179beec
00f6e13e 4889442448               mov qword ptr [rsp + 0x48], rax
00f6e143 4885c0                   test rax, rax
00f6e146 0f848a000000             je 0x140f6e1d6
00f6e14c 488bc8                   mov rcx, rax
00f6e14f e89c000000               call 0x140f6e1f0
00f6e154 488bd8                   mov rbx, rax
00f6e157 4885c0                   test rax, rax
00f6e15a 747a                     je 0x140f6e1d6
00f6e15c 4885ff                   test rdi, rdi
00f6e15f 7462                     je 0x140f6e1c3
00f6e161 81bf8000000074616474     cmp dword ptr [rdi + 0x80], 0x74646174
00f6e16b 7556                     jne 0x140f6e1c3
00f6e16d ba01000000               mov edx, 1
00f6e172 48897830                 mov qword ptr [rax + 0x30], rdi
00f6e176 895038                   mov dword ptr [rax + 0x38], edx
00f6e179 f00fc115afaf0701         lock xadd dword ptr [rip + 0x107afaf], edx
00f6e181 89503c                   mov dword ptr [rax + 0x3c], edx
00f6e184 48897040                 mov qword ptr [rax + 0x40], rsi
00f6e188 4885f6                   test rsi, rsi
00f6e18b 750c                     jne 0x140f6e199
00f6e18d 488bcf                   mov rcx, rdi
00f6e190 e88b9ef4ff               call 0x140eb8020
00f6e195 48894340                 mov qword ptr [rbx + 0x40], rax
00f6e199 488b03                   mov rax, qword ptr [rbx]
00f6e19c 488bcb                   mov rcx, rbx
00f6e19f ff90b8000000             call qword ptr [rax + 0xb8]
00f6e1a5 806370fe                 and byte ptr [rbx + 0x70], 0xfe
00f6e1a9 0fb64370                 movzx eax, byte ptr [rbx + 0x70]
00f6e1ad 0c02                     or al, 2
00f6e1af 89ab90000000             mov dword ptr [rbx + 0x90], ebp
00f6e1b5 0c04                     or al, 4
00f6e1b7 0c08                     or al, 8
00f6e1b9 0c10                     or al, 0x10
00f6e1bb 884370                   mov byte ptr [rbx + 0x70], al
00f6e1be 488bc3                   mov rax, rbx
00f6e1c1 eb15                     jmp 0x140f6e1d8
00f6e1c3 488b00                   mov rax, qword ptr [rax]
00f6e1c6 ba01000000               mov edx, 1
00f6e1cb 488bcb                   mov rcx, rbx
00f6e1ce ff10                     call qword ptr [rax]
00f6e1d0 33db                     xor ebx, ebx
00f6e1d2 8bc3                     mov eax, ebx
00f6e1d4 eb02                     jmp 0x140f6e1d8
00f6e1d6 33c0                     xor eax, eax
00f6e1d8 488b5c2430               mov rbx, qword ptr [rsp + 0x30]
00f6e1dd 488b6c2438               mov rbp, qword ptr [rsp + 0x38]
00f6e1e2 488b742440               mov rsi, qword ptr [rsp + 0x40]
00f6e1e7 4883c420                 add rsp, 0x20
00f6e1eb 5f                       pop rdi
00f6e1ec c3                       ret 