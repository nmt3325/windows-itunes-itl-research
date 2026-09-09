; Original iTunes.exe machine code; base=0x140000000; RVA=0xbfb050; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0xbfb050..0xbfbe20 (exclusive)
00bfb050 mov        qword ptr [rsp + 0x18], rbx
00bfb055 mov        qword ptr [rsp + 0x10], rdx
00bfb05a push       rbp
00bfb05b push       rsi
00bfb05c push       rdi
00bfb05d push       r12
00bfb05f push       r13
00bfb061 push       r14
00bfb063 push       r15
00bfb065 sub        rsp, 0x20
00bfb069 movups     xmm1, xmmword ptr [rcx]
00bfb06c mov        r9d, dword ptr [r8]
00bfb06f mov        r14, qword ptr [rip + 0x14d7c8a]
00bfb076 movdqa     xmm0, xmm1
00bfb07a movd       r15d, xmm1
00bfb07f psrldq     xmm0, 4
00bfb084 lea        eax, [r9*4 + 0x18]
00bfb08c movd       edi, xmm0
00bfb090 xor        r15d, dword ptr [r8 + rax*4 + 4]
00bfb095 lea        edx, [r9*4]
00bfb09d lea        eax, [rdx + 0x19]
00bfb0a0 movdqa     xmm0, xmm1
00bfb0a4 xor        edi, dword ptr [r8 + rax*4 + 4]
00bfb0a9 lea        r13d, [rdx + 0x14]
00bfb0ad lea        eax, [rdx + 0x1a]
00bfb0b0 psrldq     xmm0, 8
00bfb0b5 movd       ebp, xmm0
00bfb0b9 lea        r13, [r13 + 0x41]
00bfb0bd psrldq     xmm1, 0xc
00bfb0c2 lea        r13, [r8 + r13*4]
00bfb0c6 movd       r12d, xmm1
00bfb0cb xor        ebp, dword ptr [r8 + rax*4 + 4]
00bfb0d0 lea        eax, [rdx + 0x1b]
00bfb0d3 xor        r12d, dword ptr [r8 + rax*4 + 4]
00bfb0d8 cmp        r9d, 6
00bfb0dc jbe        0x140bfb2bf
00bfb0e2 mov        ecx, edi
00bfb0e4 mov        eax, r12d
00bfb0e7 shr        eax, 8
00bfb0ea movzx      eax, al
00bfb0ed shr        rcx, 0x18
00bfb0f1 mov        r11d, dword ptr [r14 + rcx*4 + 0xc00]
00bfb0f9 xor        r11d, dword ptr [r14 + rax*4 + 0x400]
00bfb101 mov        eax, ebp
00bfb103 shr        eax, 0x10
00bfb106 movzx      ecx, al
00bfb109 movzx      eax, r15b
00bfb10d xor        r11d, dword ptr [r14 + rcx*4 + 0x800]
00bfb115 xor        r11d, dword ptr [r14 + rax*4]
00bfb119 mov        eax, r12d
00bfb11c xor        r11d, dword ptr [r13]
00bfb120 shr        eax, 0x10
00bfb123 movzx      ecx, al
00bfb126 mov        eax, r15d
00bfb129 shr        eax, 8
00bfb12c movzx      eax, al
00bfb12f mov        r10d, dword ptr [r14 + rcx*4 + 0x800]
00bfb137 mov        ecx, r12d
00bfb13a xor        r10d, dword ptr [r14 + rax*4 + 0x400]
00bfb142 shr        rcx, 0x18
00bfb146 mov        eax, ebp
00bfb148 shr        rax, 0x18
00bfb14c mov        r9d, dword ptr [r14 + rcx*4 + 0xc00]
00bfb154 xor        r10d, dword ptr [r14 + rax*4 + 0xc00]
00bfb15c movzx      eax, dil
00bfb160 xor        r10d, dword ptr [r14 + rax*4]
00bfb164 mov        eax, r15d
00bfb167 xor        r10d, dword ptr [r13 + 4]
00bfb16b shr        eax, 0x10
00bfb16e movzx      eax, al
00bfb171 xor        r9d, dword ptr [r14 + rax*4 + 0x800]
00bfb179 mov        eax, edi
00bfb17b shr        eax, 8
00bfb17e movzx      ecx, al
00bfb181 shr        edi, 0x10
00bfb184 movzx      eax, bpl
00bfb188 shr        ebp, 8
00bfb18b xor        r9d, dword ptr [r14 + rcx*4 + 0x400]
00bfb193 mov        ecx, r15d
00bfb196 xor        r9d, dword ptr [r14 + rax*4]
00bfb19a xor        r9d, dword ptr [r13 + 8]
00bfb19e movzx      eax, dil
00bfb1a2 shr        rcx, 0x18
00bfb1a6 mov        edx, dword ptr [r14 + rcx*4 + 0xc00]
00bfb1ae xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfb1b6 movzx      eax, bpl
00bfb1ba xor        edx, dword ptr [r14 + rax*4 + 0x400]
00bfb1c2 movzx      eax, r12b
00bfb1c6 xor        edx, dword ptr [r14 + rax*4]
00bfb1ca xor        edx, dword ptr [r13 + 0xc]
00bfb1ce mov        eax, edx
00bfb1d0 shr        eax, 8
00bfb1d3 movzx      ecx, al
00bfb1d6 mov        eax, r9d
00bfb1d9 shr        eax, 0x10
00bfb1dc movzx      eax, al
00bfb1df mov        r15d, dword ptr [r14 + rcx*4 + 0x400]
00bfb1e7 xor        r15d, dword ptr [r14 + rax*4 + 0x800]
00bfb1ef mov        eax, r10d
00bfb1f2 shr        rax, 0x18
00bfb1f6 xor        r15d, dword ptr [r14 + rax*4 + 0xc00]
00bfb1fe movzx      eax, r11b
00bfb202 xor        r15d, dword ptr [r14 + rax*4]
00bfb206 mov        eax, edx
00bfb208 xor        r15d, dword ptr [r13 - 0x10]
00bfb20c shr        eax, 0x10
00bfb20f movzx      ecx, al
00bfb212 mov        eax, r9d
00bfb215 shr        rax, 0x18
00bfb219 mov        edi, dword ptr [r14 + rcx*4 + 0x800]
00bfb221 xor        edi, dword ptr [r14 + rax*4 + 0xc00]
00bfb229 mov        eax, r11d
00bfb22c shr        eax, 8
00bfb22f movzx      ecx, al
00bfb232 movzx      eax, r10b
00bfb236 xor        edi, dword ptr [r14 + rcx*4 + 0x400]
00bfb23e xor        edi, dword ptr [r14 + rax*4]
00bfb242 xor        edi, dword ptr [r13 - 0xc]
00bfb246 mov        eax, r10d
00bfb249 shr        eax, 8
00bfb24c movzx      eax, al
00bfb24f shr        r10d, 0x10
00bfb253 mov        ecx, edx
00bfb255 shr        rcx, 0x18
00bfb259 mov        ebp, dword ptr [r14 + rcx*4 + 0xc00]
00bfb261 xor        ebp, dword ptr [r14 + rax*4 + 0x400]
00bfb269 mov        eax, r11d
00bfb26c shr        eax, 0x10
00bfb26f movzx      ecx, al
00bfb272 movzx      eax, r9b
00bfb276 shr        r9d, 8
00bfb27a shr        r11, 0x18
00bfb27e xor        ebp, dword ptr [r14 + rcx*4 + 0x800]
00bfb286 xor        ebp, dword ptr [r14 + rax*4]
00bfb28a xor        ebp, dword ptr [r13 - 8]
00bfb28e movzx      eax, r10b
00bfb292 movzx      ecx, r9b
00bfb296 mov        r12d, dword ptr [r14 + rcx*4 + 0x400]
00bfb29e xor        r12d, dword ptr [r14 + rax*4 + 0x800]
00bfb2a6 xor        r12d, dword ptr [r14 + r11*4 + 0xc00]
00bfb2ae movzx      eax, dl
00bfb2b1 xor        r12d, dword ptr [r14 + rax*4]
00bfb2b5 xor        r12d, dword ptr [r13 - 4]
00bfb2b9 sub        r13, 0x20
00bfb2bd jmp        0x140bfb2da
00bfb2bf mov        dword ptr [rsp + 0xc], r12d
00bfb2c4 mov        dword ptr [rsp + 8], ebp
00bfb2c8 mov        dword ptr [rsp + 4], edi
00bfb2cc mov        dword ptr [rsp], r15d
00bfb2d0 cmp        r9d, 4
00bfb2d4 jbe        0x140bfb4b5
00bfb2da mov        ecx, edi
00bfb2dc mov        eax, ebp
00bfb2de shr        eax, 0x10
00bfb2e1 movzx      eax, al
00bfb2e4 shr        rcx, 0x18
00bfb2e8 mov        r11d, dword ptr [r14 + rcx*4 + 0xc00]
00bfb2f0 xor        r11d, dword ptr [r14 + rax*4 + 0x800]
00bfb2f8 mov        eax, r12d
00bfb2fb shr        eax, 8
00bfb2fe movzx      ecx, al
00bfb301 movzx      eax, r15b
00bfb305 xor        r11d, dword ptr [r14 + rcx*4 + 0x400]
00bfb30d xor        r11d, dword ptr [r14 + rax*4]
00bfb311 mov        eax, r12d
00bfb314 xor        r11d, dword ptr [r13]
00bfb318 shr        eax, 0x10
00bfb31b movzx      eax, al
00bfb31e mov        ecx, ebp
00bfb320 shr        rcx, 0x18
00bfb324 mov        r10d, dword ptr [r14 + rcx*4 + 0xc00]
00bfb32c xor        r10d, dword ptr [r14 + rax*4 + 0x800]
00bfb334 mov        eax, r15d
00bfb337 shr        eax, 8
00bfb33a movzx      ecx, al
00bfb33d movzx      eax, dil
00bfb341 xor        r10d, dword ptr [r14 + rcx*4 + 0x400]
00bfb349 xor        r10d, dword ptr [r14 + rax*4]
00bfb34d mov        eax, r15d
00bfb350 xor        r10d, dword ptr [r13 + 4]
00bfb354 shr        eax, 0x10
00bfb357 movzx      eax, al
00bfb35a mov        ecx, r12d
00bfb35d shr        rcx, 0x18
00bfb361 mov        r9d, dword ptr [r14 + rcx*4 + 0xc00]
00bfb369 xor        r9d, dword ptr [r14 + rax*4 + 0x800]
00bfb371 mov        eax, edi
00bfb373 shr        eax, 8
00bfb376 movzx      ecx, al
00bfb379 shr        edi, 0x10
00bfb37c movzx      eax, bpl
00bfb380 shr        ebp, 8
00bfb383 xor        r9d, dword ptr [r14 + rcx*4 + 0x400]
00bfb38b mov        ecx, r15d
00bfb38e xor        r9d, dword ptr [r14 + rax*4]
00bfb392 xor        r9d, dword ptr [r13 + 8]
00bfb396 movzx      eax, dil
00bfb39a shr        rcx, 0x18
00bfb39e mov        edx, dword ptr [r14 + rcx*4 + 0xc00]
00bfb3a6 xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfb3ae movzx      eax, bpl
00bfb3b2 xor        edx, dword ptr [r14 + rax*4 + 0x400]
00bfb3ba movzx      eax, r12b
00bfb3be xor        edx, dword ptr [r14 + rax*4]
00bfb3c2 xor        edx, dword ptr [r13 + 0xc]
00bfb3c6 mov        eax, edx
00bfb3c8 shr        eax, 8
00bfb3cb movzx      ecx, al
00bfb3ce mov        eax, r9d
00bfb3d1 shr        eax, 0x10
00bfb3d4 movzx      eax, al
00bfb3d7 mov        r15d, dword ptr [r14 + rcx*4 + 0x400]
00bfb3df xor        r15d, dword ptr [r14 + rax*4 + 0x800]
00bfb3e7 mov        eax, r10d
00bfb3ea shr        rax, 0x18
00bfb3ee xor        r15d, dword ptr [r14 + rax*4 + 0xc00]
00bfb3f6 movzx      eax, r11b
00bfb3fa xor        r15d, dword ptr [r14 + rax*4]
00bfb3fe mov        eax, edx
00bfb400 xor        r15d, dword ptr [r13 - 0x10]
00bfb404 shr        eax, 0x10
00bfb407 movzx      ecx, al
00bfb40a mov        eax, r9d
00bfb40d shr        rax, 0x18
00bfb411 mov        edi, dword ptr [r14 + rcx*4 + 0x800]
00bfb419 xor        edi, dword ptr [r14 + rax*4 + 0xc00]
00bfb421 mov        eax, r11d
00bfb424 shr        eax, 8
00bfb427 movzx      ecx, al
00bfb42a movzx      eax, r10b
00bfb42e xor        edi, dword ptr [r14 + rcx*4 + 0x400]
00bfb436 xor        edi, dword ptr [r14 + rax*4]
00bfb43a xor        edi, dword ptr [r13 - 0xc]
00bfb43e mov        eax, r10d
00bfb441 shr        eax, 8
00bfb444 movzx      eax, al
00bfb447 shr        r10d, 0x10
00bfb44b mov        ecx, edx
00bfb44d shr        rcx, 0x18
00bfb451 mov        ebp, dword ptr [r14 + rcx*4 + 0xc00]
00bfb459 xor        ebp, dword ptr [r14 + rax*4 + 0x400]
00bfb461 mov        eax, r11d
00bfb464 shr        eax, 0x10
00bfb467 movzx      ecx, al
00bfb46a movzx      eax, r9b
00bfb46e shr        r9d, 8
00bfb472 shr        r11, 0x18
00bfb476 xor        ebp, dword ptr [r14 + rcx*4 + 0x800]
00bfb47e xor        ebp, dword ptr [r14 + rax*4]
00bfb482 xor        ebp, dword ptr [r13 - 8]
00bfb486 movzx      eax, r10b
00bfb48a movzx      ecx, r9b
00bfb48e mov        r12d, dword ptr [r14 + rcx*4 + 0x400]
00bfb496 xor        r12d, dword ptr [r14 + rax*4 + 0x800]
00bfb49e xor        r12d, dword ptr [r14 + r11*4 + 0xc00]
00bfb4a6 movzx      eax, dl
00bfb4a9 xor        r12d, dword ptr [r14 + rax*4]
00bfb4ad xor        r12d, dword ptr [r13 - 4]
00bfb4b1 sub        r13, 0x20
00bfb4b5 mov        ecx, edi
00bfb4b7 mov        eax, ebp
00bfb4b9 shr        eax, 0x10
00bfb4bc movzx      eax, al
00bfb4bf shr        rcx, 0x18
00bfb4c3 mov        esi, dword ptr [r14 + rcx*4 + 0xc00]
00bfb4cb xor        esi, dword ptr [r14 + rax*4 + 0x800]
00bfb4d3 mov        eax, r12d
00bfb4d6 shr        eax, 8
00bfb4d9 movzx      ecx, al
00bfb4dc movzx      eax, r15b
00bfb4e0 xor        esi, dword ptr [r14 + rcx*4 + 0x400]
00bfb4e8 xor        esi, dword ptr [r14 + rax*4]
00bfb4ec mov        eax, r12d
00bfb4ef xor        esi, dword ptr [r13]
00bfb4f3 shr        eax, 0x10
00bfb4f6 movzx      eax, al
00bfb4f9 mov        ecx, ebp
00bfb4fb shr        rcx, 0x18
00bfb4ff mov        ebx, dword ptr [r14 + rcx*4 + 0xc00]
00bfb507 xor        ebx, dword ptr [r14 + rax*4 + 0x800]
00bfb50f mov        eax, r15d
00bfb512 shr        eax, 8
00bfb515 movzx      ecx, al
00bfb518 movzx      eax, dil
00bfb51c xor        ebx, dword ptr [r14 + rcx*4 + 0x400]
00bfb524 xor        ebx, dword ptr [r14 + rax*4]
00bfb528 mov        eax, r15d
00bfb52b xor        ebx, dword ptr [r13 + 4]
00bfb52f shr        eax, 0x10
00bfb532 movzx      eax, al
00bfb535 mov        ecx, r12d
00bfb538 shr        rcx, 0x18
00bfb53c mov        r10d, dword ptr [r14 + rcx*4 + 0xc00]
00bfb544 xor        r10d, dword ptr [r14 + rax*4 + 0x800]
00bfb54c mov        eax, edi
00bfb54e shr        eax, 8
00bfb551 movzx      ecx, al
00bfb554 shr        edi, 0x10
00bfb557 movzx      eax, bpl
00bfb55b shr        ebp, 8
00bfb55e xor        r10d, dword ptr [r14 + rcx*4 + 0x400]
00bfb566 mov        ecx, r15d
00bfb569 xor        r10d, dword ptr [r14 + rax*4]
00bfb56d xor        r10d, dword ptr [r13 + 8]
00bfb571 movzx      eax, dil
00bfb575 shr        rcx, 0x18
00bfb579 mov        edx, dword ptr [r14 + rcx*4 + 0xc00]
00bfb581 xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfb589 movzx      eax, bpl
00bfb58d xor        edx, dword ptr [r14 + rax*4 + 0x400]
00bfb595 movzx      eax, r12b
00bfb599 xor        edx, dword ptr [r14 + rax*4]
00bfb59d xor        edx, dword ptr [r13 + 0xc]
00bfb5a1 mov        eax, edx
00bfb5a3 mov        r8d, edx
00bfb5a6 shr        eax, 8
00bfb5a9 movzx      ecx, al
00bfb5ac mov        eax, r10d
00bfb5af shr        eax, 0x10
00bfb5b2 movzx      eax, al
00bfb5b5 mov        edi, dword ptr [r14 + rcx*4 + 0x400]
00bfb5bd xor        edi, dword ptr [r14 + rax*4 + 0x800]
00bfb5c5 mov        eax, ebx
00bfb5c7 shr        rax, 0x18
00bfb5cb xor        edi, dword ptr [r14 + rax*4 + 0xc00]
00bfb5d3 movzx      eax, sil
00bfb5d7 xor        edi, dword ptr [r14 + rax*4]
00bfb5db mov        eax, edx
00bfb5dd xor        edi, dword ptr [r13 - 0x10]
00bfb5e1 shr        eax, 0x10
00bfb5e4 movzx      ecx, al
00bfb5e7 mov        eax, r10d
00bfb5ea shr        rax, 0x18
00bfb5ee mov        r11d, dword ptr [r14 + rcx*4 + 0x800]
00bfb5f6 xor        r11d, dword ptr [r14 + rax*4 + 0xc00]
00bfb5fe mov        eax, esi
00bfb600 shr        eax, 8
00bfb603 movzx      ecx, al
00bfb606 movzx      eax, bl
00bfb609 xor        r11d, dword ptr [r14 + rcx*4 + 0x400]
00bfb611 xor        r11d, dword ptr [r14 + rax*4]
00bfb615 mov        eax, ebx
00bfb617 xor        r11d, dword ptr [r13 - 0xc]
00bfb61b shr        eax, 8
00bfb61e movzx      eax, al
00bfb621 mov        ecx, edx
00bfb623 shr        rcx, 0x18
00bfb627 shr        ebx, 0x10
00bfb62a mov        r9d, dword ptr [r14 + rcx*4 + 0xc00]
00bfb632 xor        r9d, dword ptr [r14 + rax*4 + 0x400]
00bfb63a mov        eax, esi
00bfb63c shr        eax, 0x10
00bfb63f movzx      ecx, al
00bfb642 movzx      eax, r10b
00bfb646 shr        r10d, 8
00bfb64a shr        rsi, 0x18
00bfb64e xor        r9d, dword ptr [r14 + rcx*4 + 0x800]
00bfb656 xor        r9d, dword ptr [r14 + rax*4]
00bfb65a xor        r9d, dword ptr [r13 - 8]
00bfb65e movzx      ecx, r10b
00bfb662 movzx      eax, bl
00bfb665 mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfb66d xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfb675 xor        edx, dword ptr [r14 + rsi*4 + 0xc00]
00bfb67d movzx      eax, r8b
00bfb681 xor        edx, dword ptr [r14 + rax*4]
00bfb685 xor        edx, dword ptr [r13 - 4]
00bfb689 mov        eax, edx
00bfb68b mov        r8d, edx
00bfb68e shr        eax, 8
00bfb691 movzx      ecx, al
00bfb694 mov        eax, r9d
00bfb697 shr        eax, 0x10
00bfb69a movzx      eax, al
00bfb69d mov        esi, dword ptr [r14 + rcx*4 + 0x400]
00bfb6a5 xor        esi, dword ptr [r14 + rax*4 + 0x800]
00bfb6ad mov        eax, r11d
00bfb6b0 shr        rax, 0x18
00bfb6b4 xor        esi, dword ptr [r14 + rax*4 + 0xc00]
00bfb6bc movzx      eax, dil
00bfb6c0 xor        esi, dword ptr [r14 + rax*4]
00bfb6c4 mov        eax, edx
00bfb6c6 xor        esi, dword ptr [r13 - 0x20]
00bfb6ca shr        eax, 0x10
00bfb6cd movzx      ecx, al
00bfb6d0 mov        eax, r9d
00bfb6d3 shr        rax, 0x18
00bfb6d7 mov        ebx, dword ptr [r14 + rcx*4 + 0x800]
00bfb6df xor        ebx, dword ptr [r14 + rax*4 + 0xc00]
00bfb6e7 mov        eax, edi
00bfb6e9 shr        eax, 8
00bfb6ec movzx      ecx, al
00bfb6ef movzx      eax, r11b
00bfb6f3 xor        ebx, dword ptr [r14 + rcx*4 + 0x400]
00bfb6fb xor        ebx, dword ptr [r14 + rax*4]
00bfb6ff mov        eax, r11d
00bfb702 xor        ebx, dword ptr [r13 - 0x1c]
00bfb706 shr        eax, 8
00bfb709 mov        ecx, edx
00bfb70b movzx      eax, al
00bfb70e shr        rcx, 0x18
00bfb712 shr        r11d, 0x10
00bfb716 mov        r10d, dword ptr [r14 + rcx*4 + 0xc00]
00bfb71e xor        r10d, dword ptr [r14 + rax*4 + 0x400]
00bfb726 mov        eax, edi
00bfb728 shr        eax, 0x10
00bfb72b movzx      ecx, al
00bfb72e movzx      eax, r9b
00bfb732 shr        r9d, 8
00bfb736 shr        rdi, 0x18
00bfb73a xor        r10d, dword ptr [r14 + rcx*4 + 0x800]
00bfb742 xor        r10d, dword ptr [r14 + rax*4]
00bfb746 xor        r10d, dword ptr [r13 - 0x18]
00bfb74a movzx      eax, r11b
00bfb74e movzx      ecx, r9b
00bfb752 mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfb75a xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfb762 xor        edx, dword ptr [r14 + rdi*4 + 0xc00]
00bfb76a movzx      eax, r8b
00bfb76e xor        edx, dword ptr [r14 + rax*4]
00bfb772 xor        edx, dword ptr [r13 - 0x14]
00bfb776 mov        eax, edx
00bfb778 mov        r8d, edx
00bfb77b shr        eax, 8
00bfb77e movzx      ecx, al
00bfb781 mov        eax, r10d
00bfb784 shr        eax, 0x10
00bfb787 movzx      eax, al
00bfb78a mov        edi, dword ptr [r14 + rcx*4 + 0x400]
00bfb792 xor        edi, dword ptr [r14 + rax*4 + 0x800]
00bfb79a mov        eax, ebx
00bfb79c shr        rax, 0x18
00bfb7a0 xor        edi, dword ptr [r14 + rax*4 + 0xc00]
00bfb7a8 movzx      eax, sil
00bfb7ac xor        edi, dword ptr [r14 + rax*4]
00bfb7b0 mov        eax, edx
00bfb7b2 xor        edi, dword ptr [r13 - 0x30]
00bfb7b6 shr        eax, 0x10
00bfb7b9 movzx      ecx, al
00bfb7bc mov        eax, r10d
00bfb7bf shr        rax, 0x18
00bfb7c3 mov        r11d, dword ptr [r14 + rcx*4 + 0x800]
00bfb7cb xor        r11d, dword ptr [r14 + rax*4 + 0xc00]
00bfb7d3 mov        eax, esi
00bfb7d5 shr        eax, 8
00bfb7d8 movzx      ecx, al
00bfb7db movzx      eax, bl
00bfb7de xor        r11d, dword ptr [r14 + rcx*4 + 0x400]
00bfb7e6 xor        r11d, dword ptr [r14 + rax*4]
00bfb7ea mov        eax, ebx
00bfb7ec xor        r11d, dword ptr [r13 - 0x2c]
00bfb7f0 shr        eax, 8
00bfb7f3 movzx      eax, al
00bfb7f6 mov        ecx, edx
00bfb7f8 shr        rcx, 0x18
00bfb7fc shr        ebx, 0x10
00bfb7ff mov        r9d, dword ptr [r14 + rcx*4 + 0xc00]
00bfb807 xor        r9d, dword ptr [r14 + rax*4 + 0x400]
00bfb80f mov        eax, esi
00bfb811 shr        eax, 0x10
00bfb814 movzx      ecx, al
00bfb817 shr        rsi, 0x18
00bfb81b movzx      eax, r10b
00bfb81f shr        r10d, 8
00bfb823 xor        r9d, dword ptr [r14 + rcx*4 + 0x800]
00bfb82b movzx      ecx, r10b
00bfb82f xor        r9d, dword ptr [r14 + rax*4]
00bfb833 xor        r9d, dword ptr [r13 - 0x28]
00bfb837 movzx      eax, bl
00bfb83a mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfb842 xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfb84a xor        edx, dword ptr [r14 + rsi*4 + 0xc00]
00bfb852 movzx      eax, r8b
00bfb856 xor        edx, dword ptr [r14 + rax*4]
00bfb85a xor        edx, dword ptr [r13 - 0x24]
00bfb85e mov        eax, edx
00bfb860 mov        r8d, edx
00bfb863 shr        eax, 8
00bfb866 movzx      ecx, al
00bfb869 mov        eax, r9d
00bfb86c shr        eax, 0x10
00bfb86f movzx      eax, al
00bfb872 mov        esi, dword ptr [r14 + rcx*4 + 0x400]
00bfb87a xor        esi, dword ptr [r14 + rax*4 + 0x800]
00bfb882 mov        eax, r11d
00bfb885 shr        rax, 0x18
00bfb889 xor        esi, dword ptr [r14 + rax*4 + 0xc00]
00bfb891 movzx      eax, dil
00bfb895 xor        esi, dword ptr [r14 + rax*4]
00bfb899 mov        eax, edx
00bfb89b xor        esi, dword ptr [r13 - 0x40]
00bfb89f shr        eax, 0x10
00bfb8a2 movzx      ecx, al
00bfb8a5 mov        eax, r9d
00bfb8a8 shr        rax, 0x18
00bfb8ac mov        ebx, dword ptr [r14 + rcx*4 + 0x800]
00bfb8b4 xor        ebx, dword ptr [r14 + rax*4 + 0xc00]
00bfb8bc mov        eax, edi
00bfb8be shr        eax, 8
00bfb8c1 movzx      ecx, al
00bfb8c4 movzx      eax, r11b
00bfb8c8 xor        ebx, dword ptr [r14 + rcx*4 + 0x400]
00bfb8d0 xor        ebx, dword ptr [r14 + rax*4]
00bfb8d4 mov        eax, r11d
00bfb8d7 xor        ebx, dword ptr [r13 - 0x3c]
00bfb8db shr        eax, 8
00bfb8de movzx      eax, al
00bfb8e1 mov        ecx, edx
00bfb8e3 shr        rcx, 0x18
00bfb8e7 shr        r11d, 0x10
00bfb8eb mov        r10d, dword ptr [r14 + rcx*4 + 0xc00]
00bfb8f3 xor        r10d, dword ptr [r14 + rax*4 + 0x400]
00bfb8fb mov        eax, edi
00bfb8fd shr        eax, 0x10
00bfb900 movzx      ecx, al
00bfb903 movzx      eax, r9b
00bfb907 shr        r9d, 8
00bfb90b shr        rdi, 0x18
00bfb90f xor        r10d, dword ptr [r14 + rcx*4 + 0x800]
00bfb917 xor        r10d, dword ptr [r14 + rax*4]
00bfb91b xor        r10d, dword ptr [r13 - 0x38]
00bfb91f movzx      ecx, r9b
00bfb923 movzx      eax, r11b
00bfb927 mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfb92f xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfb937 xor        edx, dword ptr [r14 + rdi*4 + 0xc00]
00bfb93f movzx      eax, r8b
00bfb943 xor        edx, dword ptr [r14 + rax*4]
00bfb947 xor        edx, dword ptr [r13 - 0x34]
00bfb94b mov        eax, edx
00bfb94d mov        r8d, edx
00bfb950 shr        eax, 8
00bfb953 movzx      ecx, al
00bfb956 mov        eax, r10d
00bfb959 shr        eax, 0x10
00bfb95c movzx      eax, al
00bfb95f mov        edi, dword ptr [r14 + rcx*4 + 0x400]
00bfb967 xor        edi, dword ptr [r14 + rax*4 + 0x800]
00bfb96f mov        eax, ebx
00bfb971 shr        rax, 0x18
00bfb975 xor        edi, dword ptr [r14 + rax*4 + 0xc00]
00bfb97d movzx      eax, sil
00bfb981 xor        edi, dword ptr [r14 + rax*4]
00bfb985 mov        eax, edx
00bfb987 xor        edi, dword ptr [r13 - 0x50]
00bfb98b shr        eax, 0x10
00bfb98e movzx      ecx, al
00bfb991 mov        eax, r10d
00bfb994 shr        rax, 0x18
00bfb998 mov        r11d, dword ptr [r14 + rcx*4 + 0x800]
00bfb9a0 xor        r11d, dword ptr [r14 + rax*4 + 0xc00]
00bfb9a8 mov        eax, esi
00bfb9aa shr        eax, 8
00bfb9ad movzx      ecx, al
00bfb9b0 movzx      eax, bl
00bfb9b3 xor        r11d, dword ptr [r14 + rcx*4 + 0x400]
00bfb9bb xor        r11d, dword ptr [r14 + rax*4]
00bfb9bf mov        eax, ebx
00bfb9c1 xor        r11d, dword ptr [r13 - 0x4c]
00bfb9c5 shr        eax, 8
00bfb9c8 mov        ecx, edx
00bfb9ca movzx      eax, al
00bfb9cd shr        rcx, 0x18
00bfb9d1 shr        ebx, 0x10
00bfb9d4 mov        r9d, dword ptr [r14 + rcx*4 + 0xc00]
00bfb9dc xor        r9d, dword ptr [r14 + rax*4 + 0x400]
00bfb9e4 mov        eax, esi
00bfb9e6 shr        eax, 0x10
00bfb9e9 movzx      ecx, al
00bfb9ec movzx      eax, r10b
00bfb9f0 shr        r10d, 8
00bfb9f4 shr        rsi, 0x18
00bfb9f8 xor        r9d, dword ptr [r14 + rcx*4 + 0x800]
00bfba00 xor        r9d, dword ptr [r14 + rax*4]
00bfba04 xor        r9d, dword ptr [r13 - 0x48]
00bfba08 movzx      eax, bl
00bfba0b movzx      ecx, r10b
00bfba0f mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfba17 xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfba1f xor        edx, dword ptr [r14 + rsi*4 + 0xc00]
00bfba27 movzx      eax, r8b
00bfba2b xor        edx, dword ptr [r14 + rax*4]
00bfba2f xor        edx, dword ptr [r13 - 0x44]
00bfba33 mov        eax, edx
00bfba35 mov        r8d, edx
00bfba38 shr        eax, 8
00bfba3b movzx      ecx, al
00bfba3e mov        eax, r9d
00bfba41 shr        eax, 0x10
00bfba44 movzx      eax, al
00bfba47 mov        esi, dword ptr [r14 + rcx*4 + 0x400]
00bfba4f xor        esi, dword ptr [r14 + rax*4 + 0x800]
00bfba57 mov        eax, r11d
00bfba5a shr        rax, 0x18
00bfba5e xor        esi, dword ptr [r14 + rax*4 + 0xc00]
00bfba66 movzx      eax, dil
00bfba6a xor        esi, dword ptr [r14 + rax*4]
00bfba6e mov        eax, edx
00bfba70 xor        esi, dword ptr [r13 - 0x60]
00bfba74 shr        eax, 0x10
00bfba77 movzx      ecx, al
00bfba7a mov        eax, r9d
00bfba7d shr        rax, 0x18
00bfba81 mov        ebx, dword ptr [r14 + rcx*4 + 0x800]
00bfba89 xor        ebx, dword ptr [r14 + rax*4 + 0xc00]
00bfba91 mov        eax, edi
00bfba93 shr        eax, 8
00bfba96 movzx      ecx, al
00bfba99 movzx      eax, r11b
00bfba9d xor        ebx, dword ptr [r14 + rcx*4 + 0x400]
00bfbaa5 xor        ebx, dword ptr [r14 + rax*4]
00bfbaa9 mov        eax, r11d
00bfbaac xor        ebx, dword ptr [r13 - 0x5c]
00bfbab0 shr        eax, 8
00bfbab3 movzx      eax, al
00bfbab6 mov        ecx, edx
00bfbab8 shr        rcx, 0x18
00bfbabc shr        r11d, 0x10
00bfbac0 mov        r10d, dword ptr [r14 + rcx*4 + 0xc00]
00bfbac8 xor        r10d, dword ptr [r14 + rax*4 + 0x400]
00bfbad0 mov        eax, edi
00bfbad2 shr        eax, 0x10
00bfbad5 movzx      ecx, al
00bfbad8 shr        rdi, 0x18
00bfbadc movzx      eax, r9b
00bfbae0 shr        r9d, 8
00bfbae4 xor        r10d, dword ptr [r14 + rcx*4 + 0x800]
00bfbaec movzx      ecx, r9b
00bfbaf0 xor        r10d, dword ptr [r14 + rax*4]
00bfbaf4 xor        r10d, dword ptr [r13 - 0x58]
00bfbaf8 movzx      eax, r11b
00bfbafc mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfbb04 xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfbb0c xor        edx, dword ptr [r14 + rdi*4 + 0xc00]
00bfbb14 movzx      eax, r8b
00bfbb18 xor        edx, dword ptr [r14 + rax*4]
00bfbb1c xor        edx, dword ptr [r13 - 0x54]
00bfbb20 mov        eax, edx
00bfbb22 mov        r8d, edx
00bfbb25 shr        eax, 8
00bfbb28 movzx      ecx, al
00bfbb2b mov        eax, r10d
00bfbb2e shr        eax, 0x10
00bfbb31 movzx      eax, al
00bfbb34 mov        ebp, dword ptr [r14 + rcx*4 + 0x400]
00bfbb3c xor        ebp, dword ptr [r14 + rax*4 + 0x800]
00bfbb44 mov        eax, ebx
00bfbb46 shr        rax, 0x18
00bfbb4a xor        ebp, dword ptr [r14 + rax*4 + 0xc00]
00bfbb52 movzx      eax, sil
00bfbb56 xor        ebp, dword ptr [r14 + rax*4]
00bfbb5a mov        eax, edx
00bfbb5c xor        ebp, dword ptr [r13 - 0x70]
00bfbb60 shr        eax, 0x10
00bfbb63 movzx      ecx, al
00bfbb66 mov        eax, r10d
00bfbb69 shr        rax, 0x18
00bfbb6d mov        edi, dword ptr [r14 + rcx*4 + 0x800]
00bfbb75 xor        edi, dword ptr [r14 + rax*4 + 0xc00]
00bfbb7d mov        eax, esi
00bfbb7f shr        eax, 8
00bfbb82 movzx      ecx, al
00bfbb85 movzx      eax, bl
00bfbb88 xor        edi, dword ptr [r14 + rcx*4 + 0x400]
00bfbb90 xor        edi, dword ptr [r14 + rax*4]
00bfbb94 mov        eax, ebx
00bfbb96 xor        edi, dword ptr [r13 - 0x6c]
00bfbb9a shr        eax, 8
00bfbb9d movzx      eax, al
00bfbba0 mov        ecx, edx
00bfbba2 shr        rcx, 0x18
00bfbba6 shr        ebx, 0x10
00bfbba9 mov        r9d, dword ptr [r14 + rcx*4 + 0xc00]
00bfbbb1 xor        r9d, dword ptr [r14 + rax*4 + 0x400]
00bfbbb9 mov        eax, esi
00bfbbbb shr        eax, 0x10
00bfbbbe movzx      ecx, al
00bfbbc1 shr        rsi, 0x18
00bfbbc5 movzx      eax, r10b
00bfbbc9 shr        r10d, 8
00bfbbcd xor        r9d, dword ptr [r14 + rcx*4 + 0x800]
00bfbbd5 movzx      ecx, r10b
00bfbbd9 xor        r9d, dword ptr [r14 + rax*4]
00bfbbdd xor        r9d, dword ptr [r13 - 0x68]
00bfbbe1 movzx      eax, bl
00bfbbe4 mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfbbec xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfbbf4 xor        edx, dword ptr [r14 + rsi*4 + 0xc00]
00bfbbfc movzx      eax, r8b
00bfbc00 xor        edx, dword ptr [r14 + rax*4]
00bfbc04 xor        edx, dword ptr [r13 - 0x64]
00bfbc08 mov        eax, edx
00bfbc0a mov        r8d, edx
00bfbc0d shr        eax, 8
00bfbc10 movzx      ecx, al
00bfbc13 mov        eax, r9d
00bfbc16 shr        eax, 0x10
00bfbc19 movzx      eax, al
00bfbc1c mov        esi, dword ptr [r14 + rcx*4 + 0x400]
00bfbc24 xor        esi, dword ptr [r14 + rax*4 + 0x800]
00bfbc2c mov        eax, edi
00bfbc2e shr        rax, 0x18
00bfbc32 xor        esi, dword ptr [r14 + rax*4 + 0xc00]
00bfbc3a movzx      eax, bpl
00bfbc3e xor        esi, dword ptr [r14 + rax*4]
00bfbc42 mov        eax, edx
00bfbc44 xor        esi, dword ptr [r13 - 0x80]
00bfbc48 shr        eax, 0x10
00bfbc4b movzx      ecx, al
00bfbc4e mov        eax, r9d
00bfbc51 shr        rax, 0x18
00bfbc55 mov        ebx, dword ptr [r14 + rcx*4 + 0x800]
00bfbc5d xor        ebx, dword ptr [r14 + rax*4 + 0xc00]
00bfbc65 mov        eax, ebp
00bfbc67 shr        eax, 8
00bfbc6a movzx      ecx, al
00bfbc6d movzx      eax, dil
00bfbc71 xor        ebx, dword ptr [r14 + rcx*4 + 0x400]
00bfbc79 xor        ebx, dword ptr [r14 + rax*4]
00bfbc7d mov        eax, edi
00bfbc7f xor        ebx, dword ptr [r13 - 0x7c]
00bfbc83 shr        eax, 8
00bfbc86 mov        ecx, edx
00bfbc88 movzx      eax, al
00bfbc8b shr        rcx, 0x18
00bfbc8f shr        edi, 0x10
00bfbc92 mov        r11d, dword ptr [r14 + rcx*4 + 0xc00]
00bfbc9a xor        r11d, dword ptr [r14 + rax*4 + 0x400]
00bfbca2 mov        eax, ebp
00bfbca4 shr        eax, 0x10
00bfbca7 movzx      ecx, al
00bfbcaa movzx      eax, r9b
00bfbcae shr        r9d, 8
00bfbcb2 shr        rbp, 0x18
00bfbcb6 xor        r11d, dword ptr [r14 + rcx*4 + 0x800]
00bfbcbe xor        r11d, dword ptr [r14 + rax*4]
00bfbcc2 xor        r11d, dword ptr [r13 - 0x78]
00bfbcc6 movzx      eax, dil
00bfbcca movzx      ecx, r9b
00bfbcce mov        edx, dword ptr [r14 + rcx*4 + 0x400]
00bfbcd6 xor        edx, dword ptr [r14 + rax*4 + 0x800]
00bfbcde xor        edx, dword ptr [r14 + rbp*4 + 0xc00]
00bfbce6 movzx      eax, r8b
00bfbcea xor        edx, dword ptr [r14 + rax*4]
00bfbcee xor        edx, dword ptr [r13 - 0x74]
00bfbcf2 mov        r9, qword ptr [rip + 0x14d7017]
00bfbcf9 mov        eax, edx
00bfbcfb shr        eax, 8
00bfbcfe mov        r10d, edx
00bfbd01 movzx      edx, al
00bfbd04 mov        eax, r11d
00bfbd07 shr        eax, 0x10
00bfbd0a movzx      ecx, al
00bfbd0d mov        eax, ebx
00bfbd0f shr        rax, 0x18
00bfbd13 mov        r8d, dword ptr [r9 + rdx*4 + 0x400]
00bfbd1b xor        r8d, dword ptr [r9 + rcx*4 + 0x800]
00bfbd23 xor        r8d, dword ptr [r9 + rax*4 + 0xc00]
00bfbd2b movzx      eax, sil
00bfbd2f xor        r8d, dword ptr [r9 + rax*4]
00bfbd33 mov        eax, r10d
00bfbd36 xor        r8d, dword ptr [r13 - 0x90]
00bfbd3d shr        eax, 0x10
00bfbd40 movzx      ecx, al
00bfbd43 mov        eax, r11d
00bfbd46 shr        rax, 0x18
00bfbd4a mov        dword ptr [rsp], r8d
00bfbd4e mov        edx, dword ptr [r9 + rcx*4 + 0x800]
00bfbd56 xor        edx, dword ptr [r9 + rax*4 + 0xc00]
00bfbd5e mov        eax, esi
00bfbd60 shr        eax, 8
00bfbd63 movzx      ecx, al
00bfbd66 movzx      eax, bl
00bfbd69 xor        edx, dword ptr [r9 + rcx*4 + 0x400]
00bfbd71 mov        ecx, r10d
00bfbd74 xor        edx, dword ptr [r9 + rax*4]
00bfbd78 mov        eax, ebx
00bfbd7a xor        edx, dword ptr [r13 - 0x8c]
00bfbd81 mov        dword ptr [rsp + 4], edx
00bfbd85 shr        eax, 8
00bfbd88 movzx      eax, al
00bfbd8b shr        rcx, 0x18
00bfbd8f shr        ebx, 0x10
00bfbd92 mov        edx, dword ptr [r9 + rcx*4 + 0xc00]
00bfbd9a xor        edx, dword ptr [r9 + rax*4 + 0x400]
00bfbda2 mov        eax, esi
00bfbda4 shr        eax, 0x10
00bfbda7 movzx      ecx, al
00bfbdaa movzx      eax, r11b
00bfbdae shr        r11d, 8
00bfbdb2 shr        rsi, 0x18
00bfbdb6 xor        edx, dword ptr [r9 + rcx*4 + 0x800]
00bfbdbe xor        edx, dword ptr [r9 + rax*4]
00bfbdc2 xor        edx, dword ptr [r13 - 0x88]
00bfbdc9 mov        dword ptr [rsp + 8], edx
00bfbdcd movzx      eax, bl
00bfbdd0 mov        rbx, qword ptr [rsp + 0x70]
00bfbdd5 movzx      ecx, r11b
00bfbdd9 mov        edx, dword ptr [r9 + rcx*4 + 0x400]
00bfbde1 xor        edx, dword ptr [r9 + rax*4 + 0x800]
00bfbde9 xor        edx, dword ptr [r9 + rsi*4 + 0xc00]
00bfbdf1 movzx      eax, r10b
00bfbdf5 xor        edx, dword ptr [r9 + rax*4]
00bfbdf9 xor        edx, dword ptr [r13 - 0x84]
00bfbe00 mov        rax, qword ptr [rsp + 0x68]
00bfbe05 mov        dword ptr [rsp + 0xc], edx
00bfbe09 movups     xmm0, xmmword ptr [rsp]
00bfbe0d movups     xmmword ptr [rax], xmm0
00bfbe10 add        rsp, 0x20
00bfbe14 pop        r15
00bfbe16 pop        r14
00bfbe18 pop        r13
00bfbe1a pop        r12
00bfbe1c pop        rdi
00bfbe1d pop        rsi
00bfbe1e pop        rbp
00bfbe1f ret        
