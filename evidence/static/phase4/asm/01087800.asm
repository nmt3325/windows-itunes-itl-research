; Original iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0x1087800
; Unwind range 0x1087800..0x1087927, end exclusive
01087800 48895c2408               mov qword ptr [rsp + 8], rbx
01087805 48896c2410               mov qword ptr [rsp + 0x10], rbp
0108780a 4889742418               mov qword ptr [rsp + 0x18], rsi
0108780f 48897c2420               mov qword ptr [rsp + 0x20], rdi
01087814 4156                     push r14
01087816 4883ec30                 sub rsp, 0x30
0108781a 448bf2                   mov r14d, edx
0108781d 418be8                   mov ebp, r8d
01087820 4c8b442468               mov r8, qword ptr [rsp + 0x68]
01087825 488bd1                   mov rdx, rcx
01087828 488bf9                   mov rdi, rcx
0108782b 418bf1                   mov esi, r9d
0108782e b902000000               mov ecx, 2
01087833 e87818eeff               call 0x140f690b0
01087838 488bd8                   mov rbx, rax
0108783b 4885c0                   test rax, rax
0108783e 750a                     jne 0x14108784a
01087840 b8ceffffff               mov eax, 0xffffffce
01087845 e9c2000000               jmp 0x14108790c
0108784a 488b842480000000         mov rax, qword ptr [rsp + 0x80]
01087852 488d97c0010000           lea rdx, [rdi + 0x1c0]
01087859 488d8be8000000           lea rcx, [rbx + 0xe8]
01087860 4533c9                   xor r9d, r9d
01087863 458bc6                   mov r8d, r14d
01087866 488918                   mov qword ptr [rax], rbx
01087869 0fb6442470               movzx eax, byte ptr [rsp + 0x70]
0108786e 888390000000             mov byte ptr [rbx + 0x90], al
01087874 488b442478               mov rax, qword ptr [rsp + 0x78]
01087879 48898388000000           mov qword ptr [rbx + 0x88], rax
01087880 e86b87b7ff               call 0x140bffff0
01087885 0fb6442460               movzx eax, byte ptr [rsp + 0x60]
0108788a 33d2                     xor edx, edx
0108788c 817b0869626c61           cmp dword ptr [rbx + 8], 0x616c6269
01087893 89ab00010000             mov dword ptr [rbx + 0x100], ebp
01087899 89b304010000             mov dword ptr [rbx + 0x104], esi
0108789f 888308010000             mov byte ptr [rbx + 0x108], al
010878a5 754a                     jne 0x1410878f1
010878a7 488b4b30                 mov rcx, qword ptr [rbx + 0x30]
010878ab 4885c9                   test rcx, rcx
010878ae 7441                     je 0x1410878f1
010878b0 81b98000000074616474     cmp dword ptr [rcx + 0x80], 0x74646174
010878ba 7535                     jne 0x1410878f1
010878bc 48895338                 mov qword ptr [rbx + 0x38], rdx
010878c0 488b81e8000000           mov rax, qword ptr [rcx + 0xe8]
010878c7 48894340                 mov qword ptr [rbx + 0x40], rax
010878cb 488b81e8000000           mov rax, qword ptr [rcx + 0xe8]
010878d2 4885c0                   test rax, rax
010878d5 7406                     je 0x1410878dd
010878d7 48895838                 mov qword ptr [rax + 0x38], rbx
010878db eb07                     jmp 0x1410878e4
010878dd 488999e0000000           mov qword ptr [rcx + 0xe0], rbx
010878e4 ff81ac000000             inc dword ptr [rcx + 0xac]
010878ea 488999e8000000           mov qword ptr [rcx + 0xe8], rbx
010878f1 488b07                   mov rax, qword ptr [rdi]
010878f4 4c8bcb                   mov r9, rbx
010878f7 4889542420               mov qword ptr [rsp + 0x20], rdx
010878fc 4c8bc7                   mov r8, rdi
010878ff ba61616474               mov edx, 0x74646161
01087904 488bcf                   mov rcx, rdi
01087907 ff5008                   call qword ptr [rax + 8]
0108790a 33c0                     xor eax, eax
0108790c 488b5c2440               mov rbx, qword ptr [rsp + 0x40]
01087911 488b6c2448               mov rbp, qword ptr [rsp + 0x48]
01087916 488b742450               mov rsi, qword ptr [rsp + 0x50]
0108791b 488b7c2458               mov rdi, qword ptr [rsp + 0x58]
01087920 4883c430                 add rsp, 0x30
01087924 415e                     pop r14
01087926 c3                       ret 