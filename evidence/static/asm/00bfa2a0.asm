; Original iTunes.exe machine code; base=0x140000000; RVA=0xbfa2a0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0xbfa2a0..0xbfb04b (exclusive)
00bfa2a0 mov        qword ptr [rsp + 0x18], rbx
00bfa2a5 mov        qword ptr [rsp + 0x10], rdx
00bfa2aa push       rbp
00bfa2ab push       rsi
00bfa2ac push       rdi
00bfa2ad push       r12
00bfa2af push       r13
00bfa2b1 push       r14
00bfa2b3 push       r15
00bfa2b5 sub        rsp, 0x20
00bfa2b9 movups     xmm1, xmmword ptr [rcx]
00bfa2bc mov        r15d, dword ptr [rcx + 8]
00bfa2c0 lea        r13, [r8 + 0x14]
00bfa2c4 xor        r15d, dword ptr [r8 + 0xc]
00bfa2c8 mov        eax, dword ptr [r8]
00bfa2cb movdqa     xmm0, xmm1
00bfa2cf mov        r14, qword ptr [rip + 0x14d8a22]
00bfa2d6 movd       edi, xmm1
00bfa2da psrldq     xmm0, 4
00bfa2df psrldq     xmm1, 0xc
00bfa2e4 xor        edi, dword ptr [r8 + 4]
00bfa2e8 movd       ebp, xmm0
00bfa2ec movd       r12d, xmm1
00bfa2f1 xor        ebp, dword ptr [r8 + 8]
00bfa2f5 xor        r12d, dword ptr [r8 + 0x10]
00bfa2f9 cmp        eax, 6
00bfa2fc jbe        0x140bfa4df
00bfa302 mov        eax, ebp
00bfa304 mov        ecx, r12d
00bfa307 shr        eax, 8
00bfa30a movzx      eax, al
00bfa30d shr        rcx, 0x18
00bfa311 mov        r11d, dword ptr [r14 + rcx*4 + 0xc00]
00bfa319 xor        r11d, dword ptr [r14 + rax*4 + 0x400]
00bfa321 mov        eax, r15d
00bfa324 shr        eax, 0x10
00bfa327 movzx      ecx, al
00bfa32a movzx      eax, dil
00bfa32e xor        r11d, dword ptr [r14 + rcx*4 + 0x800]
00bfa336 xor        r11d, dword ptr [r14 + rax*4]
00bfa33a mov        eax, r12d
00bfa33d xor        r11d, dword ptr [r13]
00bfa341 shr        eax, 0x10
00bfa344 movzx      ecx, al
00bfa347 mov        eax, edi
00bfa349 shr        rax, 0x18
00bfa34d mov        r10d, dword ptr [r14 + rcx*4 + 0x800]
00bfa355 xor        r10d, dword ptr [r14 + rax*4 + 0xc00]
00bfa35d mov        eax, r15d
00bfa360 shr        eax, 8
00bfa363 movzx      ecx, al
00bfa366 movzx      eax, bpl
00bfa36a xor        r10d, dword ptr [r14 + rcx*4 + 0x400]
00bfa372 xor        r10d, dword ptr [r14 + rax*4]
00bfa376 mov        eax, r12d
00bfa379 xor        r10d, dword ptr [r13 + 4]
00bfa37d shr        eax, 8
00bfa380 movzx      ecx, al
00bfa383 mov        eax, ebp
00bfa385 shr        rax, 0x18
00bfa389 shr        ebp, 0x10
00bfa38c mov        r9d, dword ptr [r14 + rcx*4 + 0x400]
00bfa394 xor        r9d, dword ptr [r14 + rax*4 + 0xc00]
00bfa39c mov        eax, edi
00bfa39e shr        eax, 0x10
00bfa3a1 movzx      ecx, al
00bfa3a4 shr        edi, 8
00bfa3a7 movzx      eax, r15b
00bfa3ab xor        r9d, dword ptr [r14 + rcx*4 + 0x800]
00bfa3b3 movzx      ecx, bpl
00bfa3b7 xor        r9d, dword ptr [r14 + rax*4]
00bfa3bb xor        r9d, dword ptr [r13 + 8]
00bfa3bf movzx      eax, dil
00bfa3c3 mov        edx, dword ptr [r14 + rcx*4 + 0x800]
00bfa3cb xor        edx, dword ptr [r14 + rax*4 + 0x400]
00bfa3d3 mov        eax, r15d
00bfa3d6 shr        rax, 0x18
00bfa3da xor        edx, dword ptr [r14 + rax*4 + 0xc00]
00bfa3e2 movzx      eax, r12b
00bfa3e6 xor        edx, dword ptr [r14 + rax*4]
00bfa3ea mov        eax, r9d
00bfa3ed xor        edx, dword ptr [r13 + 0xc]
00bfa3f1 shr        eax, 0x10
00bfa3f4 movzx      eax, al
00bfa3f7 mov        ecx, edx
00bfa3f9 shr        rcx, 0x18
00bfa3fd mov        edi, dword ptr [r14 + rcx*4 + 0xc00]
00bfa405 xor        edi, dword ptr [r14 + rax*4 + 0x800]
00bfa40d mov        eax, r10d
00bfa410 shr        eax, 8
00bfa413 movzx      ecx, al
00bfa416 movzx      eax, r11b
00bfa41a xor        edi, dword ptr [r14 + rcx*4 + 0x400]
00bfa422 xor        edi, dword ptr [r14 + rax*4]
00bfa426 mov        eax, edx
00bfa428 xor        edi, dword ptr [r13 + 0x10]
00bfa42c shr        eax, 0x10
00bfa42f movzx      ecx, al
00bfa432 mov        eax, r9d
00bfa435 shr        eax, 8
00bfa438 movzx      eax, al
00bfa43b mov        ebp, dword ptr [r14 + rcx*4 + 0x800]
00bfa443 xor        ebp, dword ptr [r14 + rax*4 + 0x400]
00bfa44b mov        eax, r11d
00bfa44e shr        rax, 0x18
00bfa452 xor        ebp, dword ptr [r14 + rax*4 + 0xc00]
00bfa45a movzx      eax, r10b
00bfa45e xor        ebp, dword ptr [r14 + rax*4]
00bfa462 xor        ebp, dword ptr [r13 + 0x14]
00bfa466 mov        eax, edx
00bfa468 shr        eax, 8
00bfa46b movzx      ecx, al
00bfa46e mov        eax, r10d
00bfa471 shr        rax, 0x18
00bfa475 shr        r10d, 0x10
00bfa479 mov        r15d, dword ptr [r14 + rcx*4 + 0x400]
00bfa481 xor        r15d, dword ptr [r14 + rax*4 + 0xc00]
00bfa489 mov        eax, r11d
00bfa48c shr        eax, 0x10
00bfa48f movzx      ecx, al
00bfa492 movzx      eax, r9b
00bfa496 shr        r9, 0x18
00bfa49a shr        r11d, 8
00bfa49e xor        r15d, dword ptr [r14 + rcx*4 + 0x800]
00bfa4a6 xor        r15d, dword ptr [r14 + rax*4]
00bfa4aa mov        r12d, dword ptr [r14 + r9*4 + 0xc00]
00bfa4b2 xor        r15d, dword ptr [r13 + 0x18]
00bfa4b6 movzx      eax, r10b
00bfa4ba xor        r12d, dword ptr [r14 + rax*4 + 0x800]
00bfa4c2 movzx      eax, r11b
00bfa4c6 xor        r12d, dword ptr [r14 + rax*4 + 0x400]
00bfa4ce movzx      eax, dl
00bfa4d1 xor        r12d, dword ptr [r14 + rax*4]
00bfa4d5 xor        r12d, dword ptr [r13 + 0x1c]
00bfa4d9 add        r13, 0x20
00bfa4dd jmp        0x140bfa4f9
00bfa4df mov        dword ptr [rsp + 0xc], r12d
00bfa4e4 mov        dword ptr [rsp + 8], r15d
00bfa4e9 mov        dword ptr [rsp + 4], ebp
00bfa4ed mov        dword ptr [rsp], edi
00bfa4f0 cmp        eax, 4
00bfa4f3 jbe        0x140bfa6d4
00bfa4f9 mov        eax, r15d
00bfa4fc mov        ecx, r12d
00bfa4ff shr        eax, 0x10
00bfa502 movzx      eax, al
00bfa505 shr        rcx, 0x18
00bfa509 mov        r11d, dword ptr [r14 + rcx*4 + 0xc00]
00bfa511 xor        r11d, dword ptr [r14 + rax*4 + 0x800]
00bfa519 mov        eax, ebp
00bfa51b shr        eax, 8
00bfa51e movzx      ecx, al
00bfa521 movzx      eax, dil
00bfa525 xor        r11d, dword ptr [r14 + rcx*4 + 0x400]
00bfa52d xor        r11d, dword ptr [r14 + rax*4]
00bfa531 mov        eax, r12d
00bfa534 xor        r11d, dword ptr [r13]
00bfa538 shr        eax, 0x10
00bfa53b movzx      eax, al
00bfa53e mov        ecx, edi
00bfa540 shr        rcx, 0x18
00bfa544 mov        r10d, dword ptr [r14 + rcx*4 + 0xc00]
00bfa54c xor        r10d, dword ptr [r14 + rax*4 + 0x800]
00bfa554 mov        eax, r15d
00bfa557 shr        eax, 8
00bfa55a movzx      ecx, al
00bfa55d movzx      eax, bpl
00bfa561 xor        r10d, dword ptr [r14 + rcx*4 + 0x400]
00bfa569 xor        r10d, dword ptr [r14 + rax*4]
00bfa56d mov        eax, edi
00bfa56f xor        r10d, dword ptr [r13 + 4]
00bfa573 shr        eax, 0x10
00bfa576 movzx      eax, al
00bfa579 shr        edi, 8
00bfa57c mov        ecx, ebp
00bfa57e shr        rcx, 0x18
00bfa582 shr        ebp, 0x10
00bfa585 mov        r9d, dword ptr [r14 + rcx*4 + 0xc00]
00bfa58d xor        r9d, dword ptr [r14 + rax*4 + 0x800]
00bfa595 mov        eax, r12d
00bfa598 shr        eax, 8
00bfa59b movzx      ecx, al
00bfa59e movzx      eax, r15b
00bfa5a2 xor        r9d, dword ptr [r14 + rcx*4 + 0x400]
00bfa5aa xor        r9d, dword ptr [r14 + rax*4]
00bfa5ae xor        r9d, dword ptr [r13 + 8]
00bfa5b2 movzx      eax, bpl
00bfa5b6 mov        ecx, r15d
00bfa5b9 shr        rcx, 0x18
00bfa5bd mov        edx, dword ptr [r14 + rcx*4 + 0xc00]
00bfa5c5 xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfa5cd movzx      eax, dil
00bfa5d1 xor        edx, dword ptr [r14 + rax*4 + 0x400]
00bfa5d9 movzx      eax, r12b
00bfa5dd xor        edx, dword ptr [r14 + rax*4]
00bfa5e1 mov        eax, r9d
00bfa5e4 xor        edx, dword ptr [r13 + 0xc]
00bfa5e8 shr        eax, 0x10
00bfa5eb movzx      eax, al
00bfa5ee mov        ecx, edx
00bfa5f0 shr        rcx, 0x18
00bfa5f4 mov        edi, dword ptr [r14 + rcx*4 + 0xc00]
00bfa5fc xor        edi, dword ptr [r14 + rax*4 + 0x800]
00bfa604 mov        eax, r10d
00bfa607 shr        eax, 8
00bfa60a movzx      ecx, al
00bfa60d movzx      eax, r11b
00bfa611 xor        edi, dword ptr [r14 + rcx*4 + 0x400]
00bfa619 xor        edi, dword ptr [r14 + rax*4]
00bfa61d mov        eax, edx
00bfa61f xor        edi, dword ptr [r13 + 0x10]
00bfa623 shr        eax, 0x10
00bfa626 movzx      ecx, al
00bfa629 mov        eax, r9d
00bfa62c shr        eax, 8
00bfa62f movzx      eax, al
00bfa632 mov        ebp, dword ptr [r14 + rcx*4 + 0x800]
00bfa63a xor        ebp, dword ptr [r14 + rax*4 + 0x400]
00bfa642 mov        eax, r11d
00bfa645 shr        rax, 0x18
00bfa649 xor        ebp, dword ptr [r14 + rax*4 + 0xc00]
00bfa651 movzx      eax, r10b
00bfa655 xor        ebp, dword ptr [r14 + rax*4]
00bfa659 xor        ebp, dword ptr [r13 + 0x14]
00bfa65d mov        eax, edx
00bfa65f shr        eax, 8
00bfa662 movzx      ecx, al
00bfa665 mov        eax, r10d
00bfa668 shr        rax, 0x18
00bfa66c shr        r10d, 0x10
00bfa670 mov        r15d, dword ptr [r14 + rcx*4 + 0x400]
00bfa678 xor        r15d, dword ptr [r14 + rax*4 + 0xc00]
00bfa680 mov        eax, r11d
00bfa683 shr        eax, 0x10
00bfa686 movzx      ecx, al
00bfa689 movzx      eax, r9b
00bfa68d shr        r9, 0x18
00bfa691 shr        r11d, 8
00bfa695 xor        r15d, dword ptr [r14 + rcx*4 + 0x800]
00bfa69d xor        r15d, dword ptr [r14 + rax*4]
00bfa6a1 mov        r12d, dword ptr [r14 + r9*4 + 0xc00]
00bfa6a9 xor        r15d, dword ptr [r13 + 0x18]
00bfa6ad movzx      eax, r10b
00bfa6b1 xor        r12d, dword ptr [r14 + rax*4 + 0x800]
00bfa6b9 movzx      eax, r11b
00bfa6bd xor        r12d, dword ptr [r14 + rax*4 + 0x400]
00bfa6c5 movzx      eax, dl
00bfa6c8 xor        r12d, dword ptr [r14 + rax*4]
00bfa6cc xor        r12d, dword ptr [r13 + 0x1c]
00bfa6d0 add        r13, 0x20
00bfa6d4 mov        eax, r15d
00bfa6d7 mov        ecx, r12d
00bfa6da shr        eax, 0x10
00bfa6dd movzx      eax, al
00bfa6e0 shr        rcx, 0x18
00bfa6e4 mov        esi, dword ptr [r14 + rcx*4 + 0xc00]
00bfa6ec xor        esi, dword ptr [r14 + rax*4 + 0x800]
00bfa6f4 mov        eax, ebp
00bfa6f6 shr        eax, 8
00bfa6f9 movzx      ecx, al
00bfa6fc movzx      eax, dil
00bfa700 xor        esi, dword ptr [r14 + rcx*4 + 0x400]
00bfa708 xor        esi, dword ptr [r14 + rax*4]
00bfa70c mov        eax, r12d
00bfa70f xor        esi, dword ptr [r13]
00bfa713 shr        eax, 0x10
00bfa716 movzx      eax, al
00bfa719 mov        ecx, edi
00bfa71b shr        rcx, 0x18
00bfa71f mov        ebx, dword ptr [r14 + rcx*4 + 0xc00]
00bfa727 xor        ebx, dword ptr [r14 + rax*4 + 0x800]
00bfa72f mov        eax, r15d
00bfa732 shr        eax, 8
00bfa735 movzx      ecx, al
00bfa738 movzx      eax, bpl
00bfa73c xor        ebx, dword ptr [r14 + rcx*4 + 0x400]
00bfa744 xor        ebx, dword ptr [r14 + rax*4]
00bfa748 mov        eax, edi
00bfa74a xor        ebx, dword ptr [r13 + 4]
00bfa74e shr        eax, 0x10
00bfa751 movzx      eax, al
00bfa754 shr        edi, 8
00bfa757 mov        ecx, ebp
00bfa759 shr        rcx, 0x18
00bfa75d shr        ebp, 0x10
00bfa760 mov        r10d, dword ptr [r14 + rcx*4 + 0xc00]
00bfa768 xor        r10d, dword ptr [r14 + rax*4 + 0x800]
00bfa770 mov        eax, r12d
00bfa773 shr        eax, 8
00bfa776 movzx      ecx, al
00bfa779 movzx      eax, r15b
00bfa77d xor        r10d, dword ptr [r14 + rcx*4 + 0x400]
00bfa785 xor        r10d, dword ptr [r14 + rax*4]
00bfa789 xor        r10d, dword ptr [r13 + 8]
00bfa78d movzx      eax, bpl
00bfa791 mov        ecx, r15d
00bfa794 shr        rcx, 0x18
00bfa798 mov        edx, dword ptr [r14 + rcx*4 + 0xc00]
00bfa7a0 xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfa7a8 movzx      eax, dil
00bfa7ac xor        edx, dword ptr [r14 + rax*4 + 0x400]
00bfa7b4 movzx      eax, r12b
00bfa7b8 xor        edx, dword ptr [r14 + rax*4]
00bfa7bc mov        eax, r10d
00bfa7bf xor        edx, dword ptr [r13 + 0xc]
00bfa7c3 shr        eax, 0x10
00bfa7c6 movzx      eax, al
00bfa7c9 mov        ecx, edx
00bfa7cb shr        rcx, 0x18
00bfa7cf mov        r8d, edx
00bfa7d2 mov        edi, dword ptr [r14 + rcx*4 + 0xc00]
00bfa7da xor        edi, dword ptr [r14 + rax*4 + 0x800]
00bfa7e2 mov        eax, ebx
00bfa7e4 shr        eax, 8
00bfa7e7 movzx      ecx, al
00bfa7ea movzx      eax, sil
00bfa7ee xor        edi, dword ptr [r14 + rcx*4 + 0x400]
00bfa7f6 xor        edi, dword ptr [r14 + rax*4]
00bfa7fa mov        eax, edx
00bfa7fc xor        edi, dword ptr [r13 + 0x10]
00bfa800 shr        eax, 0x10
00bfa803 movzx      ecx, al
00bfa806 mov        eax, r10d
00bfa809 shr        eax, 8
00bfa80c movzx      eax, al
00bfa80f mov        r11d, dword ptr [r14 + rcx*4 + 0x800]
00bfa817 xor        r11d, dword ptr [r14 + rax*4 + 0x400]
00bfa81f mov        eax, esi
00bfa821 shr        rax, 0x18
00bfa825 xor        r11d, dword ptr [r14 + rax*4 + 0xc00]
00bfa82d movzx      eax, bl
00bfa830 xor        r11d, dword ptr [r14 + rax*4]
00bfa834 mov        eax, edx
00bfa836 xor        r11d, dword ptr [r13 + 0x14]
00bfa83a shr        eax, 8
00bfa83d movzx      ecx, al
00bfa840 mov        eax, ebx
00bfa842 shr        rax, 0x18
00bfa846 shr        ebx, 0x10
00bfa849 mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfa851 xor        edx, dword ptr [r14 + rax*4 + 0xc00]
00bfa859 mov        eax, esi
00bfa85b shr        eax, 0x10
00bfa85e movzx      ecx, al
00bfa861 shr        esi, 8
00bfa864 movzx      eax, r10b
00bfa868 shr        r10, 0x18
00bfa86c xor        edx, dword ptr [r14 + rcx*4 + 0x800]
00bfa874 xor        edx, dword ptr [r14 + rax*4]
00bfa878 xor        edx, dword ptr [r13 + 0x18]
00bfa87c mov        ecx, dword ptr [r14 + r10*4 + 0xc00]
00bfa884 movzx      eax, bl
00bfa887 mov        r9d, edx
00bfa88a xor        ecx, dword ptr [r14 + rax*4 + 0x800]
00bfa892 movzx      eax, sil
00bfa896 xor        ecx, dword ptr [r14 + rax*4 + 0x400]
00bfa89e movzx      eax, r8b
00bfa8a2 xor        ecx, dword ptr [r14 + rax*4]
00bfa8a6 mov        eax, edx
00bfa8a8 xor        ecx, dword ptr [r13 + 0x1c]
00bfa8ac shr        eax, 0x10
00bfa8af movzx      eax, al
00bfa8b2 mov        r8d, ecx
00bfa8b5 shr        rcx, 0x18
00bfa8b9 mov        esi, dword ptr [r14 + rcx*4 + 0xc00]
00bfa8c1 xor        esi, dword ptr [r14 + rax*4 + 0x800]
00bfa8c9 mov        eax, r11d
00bfa8cc shr        eax, 8
00bfa8cf movzx      ecx, al
00bfa8d2 movzx      eax, dil
00bfa8d6 xor        esi, dword ptr [r14 + rcx*4 + 0x400]
00bfa8de xor        esi, dword ptr [r14 + rax*4]
00bfa8e2 mov        eax, r8d
00bfa8e5 xor        esi, dword ptr [r13 + 0x20]
00bfa8e9 shr        eax, 0x10
00bfa8ec movzx      ecx, al
00bfa8ef mov        eax, edx
00bfa8f1 shr        eax, 8
00bfa8f4 movzx      eax, al
00bfa8f7 mov        ebx, dword ptr [r14 + rcx*4 + 0x800]
00bfa8ff xor        ebx, dword ptr [r14 + rax*4 + 0x400]
00bfa907 mov        eax, edi
00bfa909 shr        rax, 0x18
00bfa90d xor        ebx, dword ptr [r14 + rax*4 + 0xc00]
00bfa915 movzx      eax, r11b
00bfa919 xor        ebx, dword ptr [r14 + rax*4]
00bfa91d mov        eax, r8d
00bfa920 xor        ebx, dword ptr [r13 + 0x24]
00bfa924 shr        eax, 8
00bfa927 movzx      ecx, al
00bfa92a mov        eax, r11d
00bfa92d shr        rax, 0x18
00bfa931 shr        r11d, 0x10
00bfa935 mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfa93d xor        edx, dword ptr [r14 + rax*4 + 0xc00]
00bfa945 mov        eax, edi
00bfa947 shr        eax, 0x10
00bfa94a movzx      ecx, al
00bfa94d movzx      eax, r9b
00bfa951 shr        r9, 0x18
00bfa955 shr        edi, 8
00bfa958 xor        edx, dword ptr [r14 + rcx*4 + 0x800]
00bfa960 xor        edx, dword ptr [r14 + rax*4]
00bfa964 xor        edx, dword ptr [r13 + 0x28]
00bfa968 mov        ecx, dword ptr [r14 + r9*4 + 0xc00]
00bfa970 movzx      eax, r11b
00bfa974 mov        r10d, edx
00bfa977 xor        ecx, dword ptr [r14 + rax*4 + 0x800]
00bfa97f movzx      eax, dil
00bfa983 xor        ecx, dword ptr [r14 + rax*4 + 0x400]
00bfa98b movzx      eax, r8b
00bfa98f xor        ecx, dword ptr [r14 + rax*4]
00bfa993 xor        ecx, dword ptr [r13 + 0x2c]
00bfa997 mov        eax, edx
00bfa999 shr        eax, 0x10
00bfa99c movzx      eax, al
00bfa99f mov        r8d, ecx
00bfa9a2 shr        rcx, 0x18
00bfa9a6 mov        ebp, dword ptr [r14 + rcx*4 + 0xc00]
00bfa9ae xor        ebp, dword ptr [r14 + rax*4 + 0x800]
00bfa9b6 mov        eax, ebx
00bfa9b8 shr        eax, 8
00bfa9bb movzx      ecx, al
00bfa9be movzx      eax, sil
00bfa9c2 xor        ebp, dword ptr [r14 + rcx*4 + 0x400]
00bfa9ca xor        ebp, dword ptr [r14 + rax*4]
00bfa9ce mov        eax, r8d
00bfa9d1 xor        ebp, dword ptr [r13 + 0x30]
00bfa9d5 shr        eax, 0x10
00bfa9d8 movzx      ecx, al
00bfa9db mov        eax, edx
00bfa9dd shr        eax, 8
00bfa9e0 movzx      eax, al
00bfa9e3 mov        edi, dword ptr [r14 + rcx*4 + 0x800]
00bfa9eb xor        edi, dword ptr [r14 + rax*4 + 0x400]
00bfa9f3 mov        eax, esi
00bfa9f5 shr        rax, 0x18
00bfa9f9 xor        edi, dword ptr [r14 + rax*4 + 0xc00]
00bfaa01 movzx      eax, bl
00bfaa04 xor        edi, dword ptr [r14 + rax*4]
00bfaa08 mov        eax, r8d
00bfaa0b xor        edi, dword ptr [r13 + 0x34]
00bfaa0f shr        eax, 8
00bfaa12 movzx      ecx, al
00bfaa15 mov        eax, ebx
00bfaa17 shr        rax, 0x18
00bfaa1b shr        ebx, 0x10
00bfaa1e mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfaa26 xor        edx, dword ptr [r14 + rax*4 + 0xc00]
00bfaa2e mov        eax, esi
00bfaa30 shr        eax, 0x10
00bfaa33 movzx      ecx, al
00bfaa36 shr        esi, 8
00bfaa39 movzx      eax, r10b
00bfaa3d shr        r10, 0x18
00bfaa41 xor        edx, dword ptr [r14 + rcx*4 + 0x800]
00bfaa49 xor        edx, dword ptr [r14 + rax*4]
00bfaa4d xor        edx, dword ptr [r13 + 0x38]
00bfaa51 mov        ecx, dword ptr [r14 + r10*4 + 0xc00]
00bfaa59 movzx      eax, bl
00bfaa5c mov        r9d, edx
00bfaa5f xor        ecx, dword ptr [r14 + rax*4 + 0x800]
00bfaa67 movzx      eax, sil
00bfaa6b xor        ecx, dword ptr [r14 + rax*4 + 0x400]
00bfaa73 movzx      eax, r8b
00bfaa77 xor        ecx, dword ptr [r14 + rax*4]
00bfaa7b mov        eax, edx
00bfaa7d xor        ecx, dword ptr [r13 + 0x3c]
00bfaa81 shr        eax, 0x10
00bfaa84 movzx      eax, al
00bfaa87 mov        r8d, ecx
00bfaa8a shr        rcx, 0x18
00bfaa8e mov        esi, dword ptr [r14 + rcx*4 + 0xc00]
00bfaa96 xor        esi, dword ptr [r14 + rax*4 + 0x800]
00bfaa9e mov        eax, edi
00bfaaa0 shr        eax, 8
00bfaaa3 movzx      ecx, al
00bfaaa6 movzx      eax, bpl
00bfaaaa xor        esi, dword ptr [r14 + rcx*4 + 0x400]
00bfaab2 xor        esi, dword ptr [r14 + rax*4]
00bfaab6 mov        eax, r8d
00bfaab9 xor        esi, dword ptr [r13 + 0x40]
00bfaabd shr        eax, 0x10
00bfaac0 movzx      ecx, al
00bfaac3 mov        eax, edx
00bfaac5 shr        eax, 8
00bfaac8 movzx      eax, al
00bfaacb mov        r11d, dword ptr [r14 + rcx*4 + 0x800]
00bfaad3 xor        r11d, dword ptr [r14 + rax*4 + 0x400]
00bfaadb mov        eax, ebp
00bfaadd shr        rax, 0x18
00bfaae1 xor        r11d, dword ptr [r14 + rax*4 + 0xc00]
00bfaae9 movzx      eax, dil
00bfaaed xor        r11d, dword ptr [r14 + rax*4]
00bfaaf1 mov        eax, r8d
00bfaaf4 xor        r11d, dword ptr [r13 + 0x44]
00bfaaf8 shr        eax, 8
00bfaafb movzx      ecx, al
00bfaafe mov        eax, edi
00bfab00 shr        rax, 0x18
00bfab04 shr        edi, 0x10
00bfab07 mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfab0f xor        edx, dword ptr [r14 + rax*4 + 0xc00]
00bfab17 mov        eax, ebp
00bfab19 shr        eax, 0x10
00bfab1c movzx      ecx, al
00bfab1f movzx      eax, r9b
00bfab23 shr        r9, 0x18
00bfab27 shr        ebp, 8
00bfab2a xor        edx, dword ptr [r14 + rcx*4 + 0x800]
00bfab32 xor        edx, dword ptr [r14 + rax*4]
00bfab36 xor        edx, dword ptr [r13 + 0x48]
00bfab3a mov        ecx, dword ptr [r14 + r9*4 + 0xc00]
00bfab42 movzx      eax, dil
00bfab46 mov        r10d, edx
00bfab49 shr        r10, 0x18
00bfab4d xor        ecx, dword ptr [r14 + rax*4 + 0x800]
00bfab55 movzx      eax, bpl
00bfab59 xor        ecx, dword ptr [r14 + rax*4 + 0x400]
00bfab61 movzx      eax, r8b
00bfab65 xor        ecx, dword ptr [r14 + rax*4]
00bfab69 mov        eax, r11d
00bfab6c xor        ecx, dword ptr [r13 + 0x4c]
00bfab70 shr        eax, 8
00bfab73 mov        r8d, ecx
00bfab76 movzx      ecx, al
00bfab79 mov        eax, r8d
00bfab7c shr        rax, 0x18
00bfab80 mov        edi, dword ptr [r14 + rcx*4 + 0x400]
00bfab88 xor        edi, dword ptr [r14 + rax*4 + 0xc00]
00bfab90 mov        eax, edx
00bfab92 shr        eax, 0x10
00bfab95 movzx      ecx, al
00bfab98 movzx      eax, sil
00bfab9c xor        edi, dword ptr [r14 + rcx*4 + 0x800]
00bfaba4 xor        edi, dword ptr [r14 + rax*4]
00bfaba8 mov        eax, edx
00bfabaa xor        edi, dword ptr [r13 + 0x50]
00bfabae shr        eax, 8
00bfabb1 movzx      ecx, al
00bfabb4 mov        eax, esi
00bfabb6 shr        rax, 0x18
00bfabba mov        ebx, dword ptr [r14 + rcx*4 + 0x400]
00bfabc2 xor        ebx, dword ptr [r14 + rax*4 + 0xc00]
00bfabca mov        eax, r8d
00bfabcd shr        eax, 0x10
00bfabd0 movzx      ecx, al
00bfabd3 movzx      eax, r11b
00bfabd7 xor        ebx, dword ptr [r14 + rcx*4 + 0x800]
00bfabdf mov        ecx, r11d
00bfabe2 xor        ebx, dword ptr [r14 + rax*4]
00bfabe6 mov        eax, esi
00bfabe8 xor        ebx, dword ptr [r13 + 0x54]
00bfabec shr        eax, 0x10
00bfabef movzx      eax, al
00bfabf2 shr        rcx, 0x18
00bfabf6 shr        r11d, 0x10
00bfabfa shr        esi, 8
00bfabfd mov        r9d, dword ptr [r14 + rcx*4 + 0xc00]
00bfac05 xor        r9d, dword ptr [r14 + rax*4 + 0x800]
00bfac0d mov        eax, r8d
00bfac10 shr        eax, 8
00bfac13 movzx      ecx, al
00bfac16 movzx      eax, dl
00bfac19 xor        r9d, dword ptr [r14 + rcx*4 + 0x400]
00bfac21 xor        r9d, dword ptr [r14 + rax*4]
00bfac25 xor        r9d, dword ptr [r13 + 0x58]
00bfac29 movzx      eax, sil
00bfac2d movzx      ecx, r11b
00bfac31 mov        edx, dword ptr [r14 + rcx*4 + 0x800]
00bfac39 xor        edx, dword ptr [r14 + rax*4 + 0x400]
00bfac41 xor        edx, dword ptr [r14 + r10*4 + 0xc00]
00bfac49 movzx      eax, r8b
00bfac4d xor        edx, dword ptr [r14 + rax*4]
00bfac51 xor        edx, dword ptr [r13 + 0x5c]
00bfac55 mov        eax, r9d
00bfac58 shr        eax, 0x10
00bfac5b movzx      eax, al
00bfac5e mov        ecx, edx
00bfac60 shr        rcx, 0x18
00bfac64 mov        r8d, edx
00bfac67 mov        esi, dword ptr [r14 + rcx*4 + 0xc00]
00bfac6f xor        esi, dword ptr [r14 + rax*4 + 0x800]
00bfac77 mov        eax, ebx
00bfac79 shr        eax, 8
00bfac7c movzx      ecx, al
00bfac7f movzx      eax, dil
00bfac83 xor        esi, dword ptr [r14 + rcx*4 + 0x400]
00bfac8b xor        esi, dword ptr [r14 + rax*4]
00bfac8f mov        eax, edx
00bfac91 xor        esi, dword ptr [r13 + 0x60]
00bfac95 shr        eax, 0x10
00bfac98 movzx      ecx, al
00bfac9b mov        eax, r9d
00bfac9e shr        eax, 8
00bfaca1 movzx      eax, al
00bfaca4 mov        r11d, dword ptr [r14 + rcx*4 + 0x800]
00bfacac xor        r11d, dword ptr [r14 + rax*4 + 0x400]
00bfacb4 mov        eax, edi
00bfacb6 shr        rax, 0x18
00bfacba xor        r11d, dword ptr [r14 + rax*4 + 0xc00]
00bfacc2 movzx      eax, bl
00bfacc5 xor        r11d, dword ptr [r14 + rax*4]
00bfacc9 mov        eax, edx
00bfaccb xor        r11d, dword ptr [r13 + 0x64]
00bfaccf shr        eax, 8
00bfacd2 movzx      ecx, al
00bfacd5 mov        eax, ebx
00bfacd7 shr        rax, 0x18
00bfacdb shr        ebx, 0x10
00bfacde mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bface6 xor        edx, dword ptr [r14 + rax*4 + 0xc00]
00bfacee mov        eax, edi
00bfacf0 shr        eax, 0x10
00bfacf3 movzx      ecx, al
00bfacf6 movzx      eax, r9b
00bfacfa shr        r9, 0x18
00bfacfe shr        edi, 8
00bfad01 xor        edx, dword ptr [r14 + rcx*4 + 0x800]
00bfad09 xor        edx, dword ptr [r14 + rax*4]
00bfad0d xor        edx, dword ptr [r13 + 0x68]
00bfad11 mov        ecx, dword ptr [r14 + r9*4 + 0xc00]
00bfad19 movzx      eax, bl
00bfad1c mov        r10d, edx
00bfad1f xor        ecx, dword ptr [r14 + rax*4 + 0x800]
00bfad27 movzx      eax, dil
00bfad2b xor        ecx, dword ptr [r14 + rax*4 + 0x400]
00bfad33 movzx      eax, r8b
00bfad37 xor        ecx, dword ptr [r14 + rax*4]
00bfad3b mov        eax, edx
00bfad3d xor        ecx, dword ptr [r13 + 0x6c]
00bfad41 shr        eax, 0x10
00bfad44 movzx      eax, al
00bfad47 mov        r8d, ecx
00bfad4a shr        rcx, 0x18
00bfad4e mov        ebp, dword ptr [r14 + rcx*4 + 0xc00]
00bfad56 xor        ebp, dword ptr [r14 + rax*4 + 0x800]
00bfad5e mov        eax, r11d
00bfad61 shr        eax, 8
00bfad64 movzx      ecx, al
00bfad67 movzx      eax, sil
00bfad6b xor        ebp, dword ptr [r14 + rcx*4 + 0x400]
00bfad73 xor        ebp, dword ptr [r14 + rax*4]
00bfad77 mov        eax, r8d
00bfad7a xor        ebp, dword ptr [r13 + 0x70]
00bfad7e shr        eax, 0x10
00bfad81 movzx      ecx, al
00bfad84 mov        eax, edx
00bfad86 shr        eax, 8
00bfad89 movzx      eax, al
00bfad8c mov        ebx, dword ptr [r14 + rcx*4 + 0x800]
00bfad94 xor        ebx, dword ptr [r14 + rax*4 + 0x400]
00bfad9c mov        eax, esi
00bfad9e shr        rax, 0x18
00bfada2 xor        ebx, dword ptr [r14 + rax*4 + 0xc00]
00bfadaa movzx      eax, r11b
00bfadae xor        ebx, dword ptr [r14 + rax*4]
00bfadb2 mov        eax, r8d
00bfadb5 xor        ebx, dword ptr [r13 + 0x74]
00bfadb9 shr        eax, 8
00bfadbc movzx      ecx, al
00bfadbf mov        eax, r11d
00bfadc2 shr        rax, 0x18
00bfadc6 shr        r11d, 0x10
00bfadca mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfadd2 xor        edx, dword ptr [r14 + rax*4 + 0xc00]
00bfadda mov        eax, esi
00bfaddc shr        eax, 0x10
00bfaddf movzx      ecx, al
00bfade2 shr        esi, 8
00bfade5 movzx      eax, r10b
00bfade9 shr        r10, 0x18
00bfaded xor        edx, dword ptr [r14 + rcx*4 + 0x800]
00bfadf5 xor        edx, dword ptr [r14 + rax*4]
00bfadf9 xor        edx, dword ptr [r13 + 0x78]
00bfadfd mov        ecx, dword ptr [r14 + r10*4 + 0xc00]
00bfae05 movzx      eax, r11b
00bfae09 mov        r9d, edx
00bfae0c shr        r9, 0x18
00bfae10 xor        ecx, dword ptr [r14 + rax*4 + 0x800]
00bfae18 movzx      eax, sil
00bfae1c xor        ecx, dword ptr [r14 + rax*4 + 0x400]
00bfae24 movzx      eax, r8b
00bfae28 xor        ecx, dword ptr [r14 + rax*4]
00bfae2c mov        eax, edx
00bfae2e xor        ecx, dword ptr [r13 + 0x7c]
00bfae32 shr        eax, 0x10
00bfae35 movzx      eax, al
00bfae38 mov        r8d, ecx
00bfae3b shr        rcx, 0x18
00bfae3f mov        esi, dword ptr [r14 + rcx*4 + 0xc00]
00bfae47 xor        esi, dword ptr [r14 + rax*4 + 0x800]
00bfae4f mov        eax, ebx
00bfae51 shr        eax, 8
00bfae54 movzx      ecx, al
00bfae57 movzx      eax, bpl
00bfae5b xor        esi, dword ptr [r14 + rcx*4 + 0x400]
00bfae63 xor        esi, dword ptr [r14 + rax*4]
00bfae67 mov        eax, r8d
00bfae6a xor        esi, dword ptr [r13 + 0x80]
00bfae71 shr        eax, 0x10
00bfae74 movzx      ecx, al
00bfae77 mov        eax, edx
00bfae79 shr        eax, 8
00bfae7c movzx      eax, al
00bfae7f mov        edi, dword ptr [r14 + rcx*4 + 0x800]
00bfae87 xor        edi, dword ptr [r14 + rax*4 + 0x400]
00bfae8f mov        eax, ebp
00bfae91 shr        rax, 0x18
00bfae95 xor        edi, dword ptr [r14 + rax*4 + 0xc00]
00bfae9d movzx      eax, bl
00bfaea0 xor        edi, dword ptr [r14 + rax*4]
00bfaea4 mov        eax, r8d
00bfaea7 xor        edi, dword ptr [r13 + 0x84]
00bfaeae shr        eax, 8
00bfaeb1 movzx      ecx, al
00bfaeb4 mov        eax, ebx
00bfaeb6 shr        rax, 0x18
00bfaeba shr        ebx, 0x10
00bfaebd mov        r11d, dword ptr [r14 + rcx*4 + 0x400]
00bfaec5 xor        r11d, dword ptr [r14 + rax*4 + 0xc00]
00bfaecd mov        eax, ebp
00bfaecf shr        eax, 0x10
00bfaed2 movzx      ecx, al
00bfaed5 movzx      eax, dl
00bfaed8 shr        ebp, 8
00bfaedb xor        r11d, dword ptr [r14 + rcx*4 + 0x800]
00bfaee3 xor        r11d, dword ptr [r14 + rax*4]
00bfaee7 mov        ecx, dword ptr [r14 + r9*4 + 0xc00]
00bfaeef xor        r11d, dword ptr [r13 + 0x88]
00bfaef6 movzx      eax, bl
00bfaef9 xor        ecx, dword ptr [r14 + rax*4 + 0x800]
00bfaf01 movzx      eax, bpl
00bfaf05 xor        ecx, dword ptr [r14 + rax*4 + 0x400]
00bfaf0d movzx      eax, r8b
00bfaf11 xor        ecx, dword ptr [r14 + rax*4]
00bfaf15 mov        r9, qword ptr [rip + 0x14d7dec]
00bfaf1c mov        eax, r11d
00bfaf1f xor        ecx, dword ptr [r13 + 0x8c]
00bfaf26 mov        rbx, qword ptr [rsp + 0x70]
00bfaf2b shr        eax, 0x10
00bfaf2e mov        r10d, ecx
00bfaf31 mov        edx, ecx
00bfaf33 movzx      ecx, al
00bfaf36 mov        eax, edi
00bfaf38 shr        eax, 8
00bfaf3b shr        rdx, 0x18
00bfaf3f mov        r8d, dword ptr [r9 + rdx*4 + 0xc00]
00bfaf47 xor        r8d, dword ptr [r9 + rcx*4 + 0x800]
00bfaf4f movzx      ecx, al
00bfaf52 movzx      eax, sil
00bfaf56 xor        r8d, dword ptr [r9 + rcx*4 + 0x400]
00bfaf5e xor        r8d, dword ptr [r9 + rax*4]
00bfaf62 mov        eax, r10d
00bfaf65 xor        r8d, dword ptr [r13 + 0x90]
00bfaf6c shr        eax, 0x10
00bfaf6f movzx      ecx, al
00bfaf72 mov        eax, r11d
00bfaf75 shr        eax, 8
00bfaf78 movzx      eax, al
00bfaf7b mov        dword ptr [rsp], r8d
00bfaf7f mov        edx, dword ptr [r9 + rcx*4 + 0x800]
00bfaf87 xor        edx, dword ptr [r9 + rax*4 + 0x400]
00bfaf8f mov        eax, esi
00bfaf91 shr        rax, 0x18
00bfaf95 xor        edx, dword ptr [r9 + rax*4 + 0xc00]
00bfaf9d movzx      eax, dil
00bfafa1 xor        edx, dword ptr [r9 + rax*4]
00bfafa5 mov        eax, r10d
00bfafa8 xor        edx, dword ptr [r13 + 0x94]
00bfafaf shr        eax, 8
00bfafb2 movzx      ecx, al
00bfafb5 mov        eax, edi
00bfafb7 shr        rax, 0x18
00bfafbb mov        dword ptr [rsp + 4], edx
00bfafbf shr        edi, 0x10
00bfafc2 mov        edx, dword ptr [r9 + rcx*4 + 0x400]
00bfafca xor        edx, dword ptr [r9 + rax*4 + 0xc00]
00bfafd2 mov        eax, esi
00bfafd4 shr        eax, 0x10
00bfafd7 movzx      ecx, al
00bfafda movzx      eax, r11b
00bfafde shr        r11, 0x18
00bfafe2 shr        esi, 8
00bfafe5 xor        edx, dword ptr [r9 + rcx*4 + 0x800]
00bfafed xor        edx, dword ptr [r9 + rax*4]
00bfaff1 xor        edx, dword ptr [r13 + 0x98]
00bfaff8 mov        ecx, dword ptr [r9 + r11*4 + 0xc00]
00bfb000 movzx      eax, dil
00bfb004 mov        dword ptr [rsp + 8], edx
00bfb008 xor        ecx, dword ptr [r9 + rax*4 + 0x800]
00bfb010 movzx      eax, sil
00bfb014 xor        ecx, dword ptr [r9 + rax*4 + 0x400]
00bfb01c movzx      eax, r10b
00bfb020 xor        ecx, dword ptr [r9 + rax*4]
00bfb024 xor        ecx, dword ptr [r13 + 0x9c]
00bfb02b mov        rax, qword ptr [rsp + 0x68]
00bfb030 mov        dword ptr [rsp + 0xc], ecx
00bfb034 movups     xmm0, xmmword ptr [rsp]
00bfb038 movups     xmmword ptr [rax], xmm0
00bfb03b add        rsp, 0x20
00bfb03f pop        r15
00bfb041 pop        r14
00bfb043 pop        r13
00bfb045 pop        r12
00bfb047 pop        rdi
00bfb048 pop        rsi
00bfb049 pop        rbp
00bfb04a ret        
