; iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0xbfe500
; unwind group range 0xbfe500..0xbfe55e (exclusive)
00bfe500 44894c2420                       mov        dword ptr [rsp + 0x20], r9d
00bfe505 4489442418                       mov        dword ptr [rsp + 0x18], r8d
00bfe50a 4889542410                       mov        qword ptr [rsp + 0x10], rdx
00bfe50f 53                               push       rbx
00bfe510 55                               push       rbp
00bfe511 56                               push       rsi
00bfe512 4154                             push       r12
00bfe514 4157                             push       r15
00bfe516 4883ec40                         sub        rsp, 0x40
00bfe51a 4c8bbc2490000000                 mov        r15, qword ptr [rsp + 0x90]
00bfe522 4533e4                           xor        r12d, r12d
00bfe525 4963e9                           movsxd     rbp, r9d
00bfe528 418bf0                           mov        esi, r8d
00bfe52b 488bd9                           mov        rbx, rcx
00bfe52e 4d85ff                           test       r15, r15
00bfe531 7403                             je         0x140bfe536
00bfe533 458927                           mov        dword ptr [r15], r12d
00bfe536 4885db                           test       rbx, rbx
00bfe539 0f848f020000                     je         0x140bfe7ce
00bfe53f 813963727473                     cmp        dword ptr [rcx], 0x73747263
00bfe545 0f8583020000                     jne        0x140bfe7ce
00bfe54b 4439613c                         cmp        dword ptr [rcx + 0x3c], r12d
00bfe54f 0f8579020000                     jne        0x140bfe7ce
00bfe555 4585c9                           test       r9d, r9d
00bfe558 0f8e70020000                     jle        0x140bfe7ce
; unwind group range 0xbfe55e..0xbfe631 (exclusive)
00bfe55e 48897c2438                       mov        qword ptr [rsp + 0x38], rdi
00bfe563 4c896c2430                       mov        qword ptr [rsp + 0x30], r13
00bfe568 4c89742428                       mov        qword ptr [rsp + 0x28], r14
00bfe56d 85f6                             test       esi, esi
00bfe56f 0f8452020000                     je         0x140bfe7c7
00bfe575 0fb64104                         movzx      eax, byte ptr [rcx + 4]
00bfe579 2401                             and        al, 1
00bfe57b 88842490000000                   mov        byte ptr [rsp + 0x90], al
00bfe582 747e                             je         0x140bfe602
00bfe584 8b4128                           mov        eax, dword ptr [rcx + 0x28]
00bfe587 4c8d7108                         lea        r14, [rcx + 8]
00bfe58b 3bc5                             cmp        eax, ebp
00bfe58d 7d24                             jge        0x140bfe5b3
00bfe58f 8bfd                             mov        edi, ebp
00bfe591 498bce                           mov        rcx, r14
00bfe594 2bf8                             sub        edi, eax
00bfe596 b832000000                       mov        eax, 0x32
00bfe59b 3bf8                             cmp        edi, eax
00bfe59d 0f4cf8                           cmovl      edi, eax
00bfe5a0 8d14bd00000000                   lea        edx, [rdi*4]
00bfe5a7 e84481fcff                       call       0x140bc66f0
00bfe5ac 85c0                             test       eax, eax
00bfe5ae 7566                             jne        0x140bfe616
00bfe5b0 017b28                           add        dword ptr [rbx + 0x28], edi
00bfe5b3 498b06                           mov        rax, qword ptr [r14]
00bfe5b6 488b08                           mov        rcx, qword ptr [rax]
00bfe5b9 4c6344a9fc                       movsxd     r8, dword ptr [rcx + rbp*4 - 4]
00bfe5be 4585c0                           test       r8d, r8d
00bfe5c1 743f                             je         0x140bfe602
00bfe5c3 813b63727473                     cmp        dword ptr [rbx], 0x73747263
00bfe5c9 7503                             jne        0x140bfe5ce
00bfe5cb ff433c                           inc        dword ptr [rbx + 0x3c]
00bfe5ce 488b4318                         mov        rax, qword ptr [rbx + 0x18]
00bfe5d2 488b08                           mov        rcx, qword ptr [rax]
00bfe5d5 42ff4481fc                       inc        dword ptr [rcx + r8*4 - 4]
00bfe5da 4d85ff                           test       r15, r15
00bfe5dd 7403                             je         0x140bfe5e2
00bfe5df 458907                           mov        dword ptr [r15], r8d
00bfe5e2 813b63727473                     cmp        dword ptr [rbx], 0x73747263
00bfe5e8 0f85d9010000                     jne        0x140bfe7c7
00bfe5ee 8b433c                           mov        eax, dword ptr [rbx + 0x3c]
00bfe5f1 85c0                             test       eax, eax
00bfe5f3 0f8ece010000                     jle        0x140bfe7c7
00bfe5f9 ffc8                             dec        eax
00bfe5fb 89433c                           mov        dword ptr [rbx + 0x3c], eax
00bfe5fe 33c0                             xor        eax, eax
00bfe600 eb14                             jmp        0x140bfe616
00bfe602 48634330                         movsxd     rax, dword ptr [rbx + 0x30]
00bfe606 85c0                             test       eax, eax
00bfe608 7527                             jne        0x140bfe631
00bfe60a 488bcb                           mov        rcx, rbx
00bfe60d e83ef6ffff                       call       0x140bfdc50
00bfe612 85c0                             test       eax, eax
00bfe614 74ec                             je         0x140bfe602
00bfe616 4c8b6c2430                       mov        r13, qword ptr [rsp + 0x30]
00bfe61b 488b7c2438                       mov        rdi, qword ptr [rsp + 0x38]
00bfe620 4c8b742428                       mov        r14, qword ptr [rsp + 0x28]
00bfe625 4883c440                         add        rsp, 0x40
00bfe629 415f                             pop        r15
00bfe62b 415c                             pop        r12
00bfe62d 5e                               pop        rsi
00bfe62e 5d                               pop        rbp
00bfe62f 5b                               pop        rbx
00bfe630 c3                               ret        
; unwind group range 0xbfe631..0xbfe7ce (exclusive)
00bfe631 488b5310                         mov        rdx, qword ptr [rbx + 0x10]
00bfe635 488d78ff                         lea        rdi, [rax - 1]
00bfe639 488b6b20                         mov        rbp, qword ptr [rbx + 0x20]
00bfe63d 4c8d7320                         lea        r14, [rbx + 0x20]
00bfe641 488b02                           mov        rax, qword ptr [rdx]
00bfe644 488d3cf8                         lea        rdi, [rax + rdi*8]
00bfe648 8b4704                           mov        eax, dword ptr [rdi + 4]
00bfe64b 4c8bcf                           mov        r9, rdi
00bfe64e 894330                           mov        dword ptr [rbx + 0x30], eax
00bfe651 4c2b0a                           sub        r9, qword ptr [rdx]
00bfe654 49c1f903                         sar        r9, 3
00bfe658 4c894c2470                       mov        qword ptr [rsp + 0x70], r9
00bfe65d 4d8d6901                         lea        r13, [r9 + 1]
00bfe661 4885ed                           test       rbp, rbp
00bfe664 7505                             jne        0x140bfe66b
00bfe666 418bec                           mov        ebp, r12d
00bfe669 eb18                             jmp        0x140bfe683
00bfe66b 817d08486d654d                   cmp        dword ptr [rbp + 8], 0x4d656d48
00bfe672 7405                             je         0x140bfe679
00bfe674 418bec                           mov        ebp, r12d
00bfe677 eb03                             jmp        0x140bfe67c
00bfe679 8b6d10                           mov        ebp, dword ptr [rbp + 0x10]
00bfe67c 2b6b34                           sub        ebp, dword ptr [rbx + 0x34]
00bfe67f 4c8d7320                         lea        r14, [rbx + 0x20]
00bfe683 3b7334                           cmp        esi, dword ptr [rbx + 0x34]
00bfe686 0f8ede000000                     jle        0x140bfe76a
00bfe68c 8b4338                           mov        eax, dword ptr [rbx + 0x38]
00bfe68f 8bc8                             mov        ecx, eax
00bfe691 3bc6                             cmp        eax, esi
00bfe693 7306                             jae        0x140bfe69b
00bfe695 8bce                             mov        ecx, esi
00bfe697 4c8d7320                         lea        r14, [rbx + 0x20]
00bfe69b 660f6ec5                         movd       xmm0, ebp
00bfe69f 0f5bc0                           cvtdq2ps   xmm0, xmm0
00bfe6a2 f30f5905ae4b0701                 mulss      xmm0, dword ptr [rip + 0x1074bae]
00bfe6aa f3480f2cf0                       cvttss2si  rsi, xmm0
00bfe6af 3bce                             cmp        ecx, esi
00bfe6b1 0f43f1                           cmovae     esi, ecx
00bfe6b4 3d00200000                       cmp        eax, 0x2000
00bfe6b9 7305                             jae        0x140bfe6c0
00bfe6bb 03c0                             add        eax, eax
00bfe6bd 894338                           mov        dword ptr [rbx + 0x38], eax
00bfe6c0 4d85f6                           test       r14, r14
00bfe6c3 750f                             jne        0x140bfe6d4
00bfe6c5 488b0a                           mov        rcx, qword ptr [rdx]
00bfe6c8 41b8ceffffff                     mov        r8d, 0xffffffce
00bfe6ce 4a8d3cc9                         lea        rdi, [rcx + r9*8]
00bfe6d2 eb70                             jmp        0x140bfe744
00bfe6d4 498b0e                           mov        rcx, qword ptr [r14]
00bfe6d7 4885c9                           test       rcx, rcx
00bfe6da 742f                             je         0x140bfe70b
00bfe6dc 817908486d654d                   cmp        dword ptr [rcx + 8], 0x4d656d48
00bfe6e3 7504                             jne        0x140bfe6e9
00bfe6e5 448b6110                         mov        r12d, dword ptr [rcx + 0x10]
00bfe6e9 85f6                             test       esi, esi
00bfe6eb 7908                             jns        0x140bfe6f5
00bfe6ed 428d0426                         lea        eax, [rsi + r12]
00bfe6f1 85c0                             test       eax, eax
00bfe6f3 78d0                             js         0x140bfe6c5
00bfe6f5 428d0426                         lea        eax, [rsi + r12]
00bfe6f9 4863d0                           movsxd     rdx, eax
00bfe6fc e8bf7efcff                       call       0x140bc65c0
00bfe701 4c8b4c2470                       mov        r9, qword ptr [rsp + 0x70]
00bfe706 448bc0                           mov        r8d, eax
00bfe709 eb29                             jmp        0x140bfe734
00bfe70b 85f6                             test       esi, esi
00bfe70d 781f                             js         0x140bfe72e
00bfe70f 4863ce                           movsxd     rcx, esi
00bfe712 e8797dfcff                       call       0x140bc6490
00bfe717 4c8b4c2470                       mov        r9, qword ptr [rsp + 0x70]
00bfe71c 4885c0                           test       rax, rax
00bfe71f 41b894ffffff                     mov        r8d, 0xffffff94
00bfe725 498906                           mov        qword ptr [r14], rax
00bfe728 450f45c4                         cmovne     r8d, r12d
00bfe72c eb06                             jmp        0x140bfe734
00bfe72e 41b894ffffff                     mov        r8d, 0xffffff94
00bfe734 488b4b10                         mov        rcx, qword ptr [rbx + 0x10]
00bfe738 488b11                           mov        rdx, qword ptr [rcx]
00bfe73b 4a8d3cca                         lea        rdi, [rdx + r9*8]
00bfe73f 4585c0                           test       r8d, r8d
00bfe742 7418                             je         0x140bfe75c
00bfe744 c70700000080                     mov        dword ptr [rdi], 0x80000000
00bfe74a 418bc0                           mov        eax, r8d
00bfe74d 8b4b30                           mov        ecx, dword ptr [rbx + 0x30]
00bfe750 894f04                           mov        dword ptr [rdi + 4], ecx
00bfe753 44896b30                         mov        dword ptr [rbx + 0x30], r13d
00bfe757 e9bafeffff                       jmp        0x140bfe616
00bfe75c 017334                           add        dword ptr [rbx + 0x34], esi
00bfe75f 4c8d7320                         lea        r14, [rbx + 0x20]
00bfe763 8bb42480000000                   mov        esi, dword ptr [rsp + 0x80]
00bfe76a 498b06                           mov        rax, qword ptr [r14]
00bfe76d 4863cd                           movsxd     rcx, ebp
00bfe770 480308                           add        rcx, qword ptr [rax]
00bfe773 488b442478                       mov        rax, qword ptr [rsp + 0x78]
00bfe778 4885c0                           test       rax, rax
00bfe77b 7410                             je         0x140bfe78d
00bfe77d 4885c9                           test       rcx, rcx
00bfe780 740b                             je         0x140bfe78d
00bfe782 4c63c6                           movsxd     r8, esi
00bfe785 488bd0                           mov        rdx, rax
00bfe788 e8e890c600                       call       0x141867875
00bfe78d 297334                           sub        dword ptr [rbx + 0x34], esi
00bfe790 892f                             mov        dword ptr [rdi], ebp
00bfe792 897704                           mov        dword ptr [rdi + 4], esi
00bfe795 4d85ff                           test       r15, r15
00bfe798 7403                             je         0x140bfe79d
00bfe79a 45892f                           mov        dword ptr [r15], r13d
00bfe79d 80bc249000000000                 cmp        byte ptr [rsp + 0x90], 0
00bfe7a5 7420                             je         0x140bfe7c7
00bfe7a7 488b4308                         mov        rax, qword ptr [rbx + 8]
00bfe7ab 48638c2488000000                 movsxd     rcx, dword ptr [rsp + 0x88]
00bfe7b3 488b00                           mov        rax, qword ptr [rax]
00bfe7b6 44896c88fc                       mov        dword ptr [rax + rcx*4 - 4], r13d
00bfe7bb 488b4318                         mov        rax, qword ptr [rbx + 0x18]
00bfe7bf 488b08                           mov        rcx, qword ptr [rax]
00bfe7c2 42ff44a9fc                       inc        dword ptr [rcx + r13*4 - 4]
00bfe7c7 33c0                             xor        eax, eax
00bfe7c9 e948feffff                       jmp        0x140bfe616
; unwind group range 0xbfe7ce..0xbfe7df (exclusive)
00bfe7ce b8ceffffff                       mov        eax, 0xffffffce
00bfe7d3 4883c440                         add        rsp, 0x40
00bfe7d7 415f                             pop        r15
00bfe7d9 415c                             pop        r12
00bfe7db 5e                               pop        rsi
00bfe7dc 5d                               pop        rbp
00bfe7dd 5b                               pop        rbx
00bfe7de c3                               ret        
