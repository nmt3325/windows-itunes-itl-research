; iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; RVA 0xfa5530
00fa5530 4885d2                   test rdx, rdx
00fa5533 0f8406020000             je 0x140fa573f
00fa5539 488bc4                   mov rax, rsp
00fa553c 48894808                 mov qword ptr [rax + 8], rcx
00fa5540 53                       push rbx
00fa5541 57                       push rdi
00fa5542 4883ec58                 sub rsp, 0x58
00fa5546 48837a1000               cmp qword ptr [rdx + 0x10], 0
00fa554b 488bfa                   mov rdi, rdx
00fa554e 488bd9                   mov rbx, rcx
00fa5551 0f84e2010000             je 0x140fa5739
00fa5557 48896818                 mov qword ptr [rax + 0x18], rbp
00fa555b 33ed                     xor ebp, ebp
00fa555d 48895108                 mov qword ptr [rcx + 8], rdx
00fa5561 488b5258                 mov rdx, qword ptr [rdx + 0x58]
00fa5565 48897020                 mov qword ptr [rax + 0x20], rsi
00fa5569 4c8970e8                 mov qword ptr [rax - 0x18], r14
00fa556d 4885d2                   test rdx, rdx
00fa5570 7424                     je 0x140fa5596
00fa5572 4584c0                   test r8b, r8b
00fa5575 751f                     jne 0x140fa5596
00fa5577 488b0a                   mov rcx, qword ptr [rdx]
00fa557a 4885c9                   test rcx, rcx
00fa557d 740f                     je 0x140fa558e
00fa557f 90                       nop 
00fa5580 488b01                   mov rax, qword ptr [rcx]
00fa5583 488bd1                   mov rdx, rcx
00fa5586 488bc8                   mov rcx, rax
00fa5589 4885c0                   test rax, rax
00fa558c 75f2                     jne 0x140fa5580
00fa558e 48891a                   mov qword ptr [rdx], rbx
00fa5591 48892b                   mov qword ptr [rbx], rbp
00fa5594 eb07                     jmp 0x140fa559d
00fa5596 488911                   mov qword ptr [rcx], rdx
00fa5599 48895f58                 mov qword ptr [rdi + 0x58], rbx
00fa559d 488b4710                 mov rax, qword ptr [rdi + 0x10]
00fa55a1 4c8d4328                 lea r8, [rbx + 0x28]
00fa55a5 ff80a8000000             inc dword ptr [rax + 0xa8]
00fa55ab 488b7710                 mov rsi, qword ptr [rdi + 0x10]
00fa55af 413928                   cmp dword ptr [r8], ebp
00fa55b2 741b                     je 0x140fa55cf
00fa55b4 488b8ef0180000           mov rcx, qword ptr [rsi + 0x18f0]
00fa55bb 4885c9                   test rcx, rcx
00fa55be 740f                     je 0x140fa55cf
00fa55c0 4c8d4c2470               lea r9, [rsp + 0x70]
00fa55c5 488d542430               lea rdx, [rsp + 0x30]
00fa55ca e8a1df6eff               call 0x140693570
00fa55cf 817b3444524853           cmp dword ptr [rbx + 0x34], 0x53485244
00fa55d6 7526                     jne 0x140fa55fe
00fa55d8 4c8b8380000000           mov r8, qword ptr [rbx + 0x80]
00fa55df 4d85c0                   test r8, r8
00fa55e2 741a                     je 0x140fa55fe
00fa55e4 4c8b8b88000000           mov r9, qword ptr [rbx + 0x88]
00fa55eb 488bce                   mov rcx, rsi
00fa55ee 8b9390000000             mov edx, dword ptr [rbx + 0x90]
00fa55f4 48895c2420               mov qword ptr [rsp + 0x20], rbx
00fa55f9 e862580100               call 0x140fbae60
00fa55fe 488b8ef8180000           mov rcx, qword ptr [rsi + 0x18f8]
00fa5605 4885c9                   test rcx, rcx
00fa5608 7435                     je 0x140fa563f
00fa560a 488b4308                 mov rax, qword ptr [rbx + 8]
00fa560e 4885c0                   test rax, rax
00fa5611 742c                     je 0x140fa563f
00fa5613 48396810                 cmp qword ptr [rax + 0x10], rbp
00fa5617 7426                     je 0x140fa563f
00fa5619 488b4310                 mov rax, qword ptr [rbx + 0x10]
00fa561d 488b5038                 mov rdx, qword ptr [rax + 0x38]
00fa5621 4885d2                   test rdx, rdx
00fa5624 7419                     je 0x140fa563f
00fa5626 4889542430               mov qword ptr [rsp + 0x30], rdx
00fa562b 4c8d442430               lea r8, [rsp + 0x30]
00fa5630 488d542478               lea rdx, [rsp + 0x78]
00fa5635 48895c2438               mov qword ptr [rsp + 0x38], rbx
00fa563a e8618169ff               call 0x14063d7a0
00fa563f 4c8bb600190000           mov r14, qword ptr [rsi + 0x1900]
00fa5646 4d85f6                   test r14, r14
00fa5649 742d                     je 0x140fa5678
00fa564b 488b4310                 mov rax, qword ptr [rbx + 0x10]
00fa564f 396868                   cmp dword ptr [rax + 0x68], ebp
00fa5652 7424                     je 0x140fa5678
00fa5654 488bcb                   mov rcx, rbx
00fa5657 e834feffff               call 0x140fa5490
00fa565c 4c8d442430               lea r8, [rsp + 0x30]
00fa5661 4889442430               mov qword ptr [rsp + 0x30], rax
00fa5666 488d542478               lea rdx, [rsp + 0x78]
00fa566b 48895c2438               mov qword ptr [rsp + 0x38], rbx
00fa5670 498bce                   mov rcx, r14
00fa5673 e8288169ff               call 0x14063d7a0
00fa5678 488b8e08190000           mov rcx, qword ptr [rsi + 0x1908]
00fa567f 4c8b742450               mov r14, qword ptr [rsp + 0x50]
00fa5684 4885c9                   test rcx, rcx
00fa5687 7439                     je 0x140fa56c2
00fa5689 488b4320                 mov rax, qword ptr [rbx + 0x20]
00fa568d 83780402                 cmp dword ptr [rax + 4], 2
00fa5691 7405                     je 0x140fa5698
00fa5693 488bc5                   mov rax, rbp
00fa5696 eb0c                     jmp 0x140fa56a4
00fa5698 488b4008                 mov rax, qword ptr [rax + 8]
00fa569c 4883f8fd                 cmp rax, -3
00fa56a0 7420                     je 0x140fa56c2
00fa56a2 771e                     ja 0x140fa56c2
00fa56a4 4885c0                   test rax, rax
00fa56a7 7419                     je 0x140fa56c2
00fa56a9 4c8d442430               lea r8, [rsp + 0x30]
00fa56ae 4889442430               mov qword ptr [rsp + 0x30], rax
00fa56b3 488d542478               lea rdx, [rsp + 0x78]
00fa56b8 48895c2438               mov qword ptr [rsp + 0x38], rbx
00fa56bd e8de8069ff               call 0x14063d7a0
00fa56c2 488b8e10190000           mov rcx, qword ptr [rsi + 0x1910]
00fa56c9 488bb42488000000         mov rsi, qword ptr [rsp + 0x88]
00fa56d1 4885c9                   test rcx, rcx
00fa56d4 7434                     je 0x140fa570a
00fa56d6 488b4320                 mov rax, qword ptr [rbx + 0x20]
00fa56da 83780403                 cmp dword ptr [rax + 4], 3
00fa56de 750c                     jne 0x140fa56ec
00fa56e0 488b6808                 mov rbp, qword ptr [rax + 8]
00fa56e4 4883fdfd                 cmp rbp, -3
00fa56e8 7420                     je 0x140fa570a
00fa56ea 771e                     ja 0x140fa570a
00fa56ec 4885ed                   test rbp, rbp
00fa56ef 7419                     je 0x140fa570a
00fa56f1 4c8d442430               lea r8, [rsp + 0x30]
00fa56f6 48896c2430               mov qword ptr [rsp + 0x30], rbp
00fa56fb 488d542478               lea rdx, [rsp + 0x78]
00fa5700 48895c2438               mov qword ptr [rsp + 0x38], rbx
00fa5705 e8968069ff               call 0x14063d7a0
00fa570a b201                     mov dl, 1
00fa570c 488bcf                   mov rcx, rdi
00fa570f e87cfefeff               call 0x140f95590
00fa5714 80bf9800000000           cmp byte ptr [rdi + 0x98], 0
00fa571b 488bac2480000000         mov rbp, qword ptr [rsp + 0x80]
00fa5723 7414                     je 0x140fa5739
00fa5725 ba85000000               mov edx, 0x85
00fa572a c6879800000000           mov byte ptr [rdi + 0x98], 0
00fa5731 488bcf                   mov rcx, rdi
00fa5734 e8c7e9feff               call 0x140f94100
00fa5739 4883c458                 add rsp, 0x58
00fa573d 5f                       pop rdi
00fa573e 5b                       pop rbx
00fa573f c3                       ret 