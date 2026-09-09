; Original iTunes.exe machine code; base=0x140000000; RVA=0x10773d0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x10773d0..0x1077428 (exclusive)
010773d0 push       rbp
010773d2 push       rbx
010773d3 push       r12
010773d5 push       r13
010773d7 push       r15
010773d9 lea        rbp, [rsp - 0x280]
010773e1 sub        rsp, 0x380
010773e8 mov        rax, qword ptr [rip + 0xf5dc51]
010773ef xor        rax, rsp
010773f2 mov        qword ptr [rbp + 0x260], rax
010773f9 mov        r15, qword ptr [rbp + 0x2d0]
01077400 mov        rbx, r8
01077403 mov        dword ptr [rsp + 0x44], edx
01077407 mov        r8d, 0x10
0107740d lea        rdx, [rsp + 0x50]
01077412 movsxd     r12, r9d
01077415 mov        r13, rcx
01077418 call       0x1410770a0
0107741d mov        r8d, eax
01077420 test       eax, eax
01077422 jne        0x141077cf3
; range 0x1077428..0x1077cf3 (exclusive)
01077428 mov        qword ptr [rsp + 0x3b8], rsi
01077430 mov        qword ptr [rsp + 0x378], rdi
01077438 mov        qword ptr [rsp + 0x370], r14
01077440 cmp        byte ptr [r13 + 0x52], al
01077444 jne        0x14107749b
01077446 mov        ecx, dword ptr [rsp + 0x50]
0107744a mov        r14d, ecx
0107744d mov        eax, ecx
0107744f and        r14d, 0xff0000
01077456 shr        eax, 0x10
01077459 or         r14d, eax
0107745c mov        eax, ecx
0107745e and        eax, 0xff00
01077463 shl        ecx, 0x10
01077466 or         eax, ecx
01077468 shr        r14d, 8
0107746c mov        ecx, dword ptr [rsp + 0x54]
01077470 mov        edi, ecx
01077472 shl        eax, 8
01077475 and        edi, 0xff0000
0107747b or         r14d, eax
0107747e mov        eax, ecx
01077480 shr        eax, 0x10
01077483 or         edi, eax
01077485 mov        eax, ecx
01077487 and        eax, 0xff00
0107748c shl        ecx, 0x10
0107748f or         eax, ecx
01077491 shr        edi, 8
01077494 shl        eax, 8
01077497 or         edi, eax
01077499 jmp        0x1410774a4
0107749b mov        edi, dword ptr [rsp + 0x54]
0107749f mov        r14d, dword ptr [rsp + 0x50]
010774a4 mov        eax, edi
010774a6 lea        rsi, [r13 + 0xa00128]
010774ad mov        qword ptr [rsp + 0x50], rax
010774b2 cmp        rax, 0xa00000
010774b8 jbe        0x1410774c5
010774ba mov        r8d, 0xffffff30
010774c0 jmp        0x141077cdb
010774c5 mov        r8, rax
010774c8 mov        rdx, rsi
010774cb mov        rcx, r13
010774ce call       0x1410770a0
010774d3 mov        r8d, eax
010774d6 test       eax, eax
010774d8 jne        0x141077cdb
010774de test       byte ptr [rbp + 0x2d8], 1
010774e5 je         0x1410774f6
010774e7 mov        edx, edi
010774e9 mov        rcx, rsi
010774ec call       0x140ff7670
010774f1 jmp        0x1410775b6
010774f6 cmp        r14d, 1
010774fa jne        0x1410775ad
01077500 mov        eax, edi
01077502 shr        eax, 1
01077504 cmp        byte ptr [r13 + 0x52], 0
01077509 mov        qword ptr [rsp + 0x48], rax
0107750e jne        0x141077535
01077510 test       eax, eax
01077512 je         0x141077535
01077514 mov        rcx, rsi
01077517 mov        r8d, eax
0107751a nop        word ptr [rax + rax]
01077520 movzx      eax, word ptr [rcx]
01077523 lea        rcx, [rcx + 2]
01077527 ror        ax, 8
0107752b mov        word ptr [rcx - 2], ax
0107752f sub        r8, 1
01077533 jne        0x141077520
01077535 cmp        byte ptr [r13 + 0x40], 2
0107753a je         0x14107764e
01077540 mov        rdi, qword ptr [rsp + 0x50]
01077545 mov        edx, 0x10
0107754a mov        rcx, rdi
0107754d call       qword ptr [rip + 0x874e1d]
01077553 mov        r14, rax
01077556 test       rax, rax
01077559 jne        0x141077566
0107755b mov        r8d, 0xffffff94
01077561 jmp        0x141077cdb
01077566 mov        rcx, r14
01077569 test       rsi, rsi
0107756c je         0x14107759c
0107756e mov        r8, rdi
01077571 mov        rdx, rsi
01077574 call       0x141867875
01077579 mov        edx, dword ptr [rsp + 0x48]
0107757d mov        rcx, r14
01077580 call       0x140b9f570
01077585 add        eax, eax
01077587 mov        rdx, r14
0107758a mov        r8d, eax
0107758d mov        rcx, rsi
01077590 mov        edi, eax
01077592 call       0x141867875
01077597 jmp        0x14107764e
0107759c mov        edx, dword ptr [rsp + 0x48]
010775a0 call       0x140b9f570
010775a5 lea        edi, [rax + rax]
010775a8 jmp        0x14107764e
010775ad test       r14d, r14d
010775b0 jne        0x141077644
010775b6 cmp        dword ptr [rsp + 0x44], 1
010775bb jne        0x141077cc1
010775c1 mov        r14d, 0xff
010775c7 cmp        edi, r14d
010775ca cmova      edi, r14d
010775ce mov        byte ptr [rsp + 0x60], dil
010775d3 test       rsi, rsi
010775d6 je         0x1410775ee
010775d8 movzx      r8d, dil
010775dc lea        rcx, [rsp + 0x61]
010775e1 mov        rdx, rsi
010775e4 call       0x14179cc9a
010775e9 movzx      edi, byte ptr [rsp + 0x60]
010775ee xor        esi, esi
010775f0 movzx      edx, dil
010775f4 lea        rax, [rsp + 0x44]
010775f9 mov        word ptr [rbp + 0x60], si
010775fd mov        r9d, r14d
01077600 mov        qword ptr [rsp + 0x20], rax
01077605 lea        r8, [rbp + 0x62]
01077609 lea        rcx, [rsp + 0x61]
0107760e call       0x140b9eac0
01077613 mov        eax, dword ptr [rsp + 0x44]
01077617 mov        word ptr [rbp + 0x60], ax
0107761b movzx      r8d, ax
0107761f add        r8d, r8d
01077622 lea        rdx, [rbp + 0x62]
01077626 mov        rcx, rbx
01077629 test       r12d, r12d
0107762c je         0x141077cd0
01077632 mov        r9d, r12d
01077635 mov        qword ptr [rsp + 0x20], r15
0107763a call       0x140bfe500
0107763f jmp        0x141077cd8
01077644 cmp        r14d, 1
01077648 jne        0x141077c68
0107764e cmp        dword ptr [rsp + 0x44], 0
01077653 jne        0x141077cc1
01077659 mov        eax, 0x1fe
0107765e cmp        edi, eax
01077660 cmova      edi, eax
01077663 mov        eax, edi
01077665 shr        eax, 1
01077667 mov        word ptr [rbp + 0x60], ax
0107766b test       rsi, rsi
0107766e je         0x141077683
01077670 mov        r8d, edi
01077673 lea        rcx, [rbp + 0x62]
01077677 mov        rdx, rsi
0107767a call       0x14179cc9a
0107767f movzx      eax, word ptr [rbp + 0x60]
01077683 xor        esi, esi
01077685 movzx      r13d, ax
01077689 mov        byte ptr [rsp + 0x60], 0
0107768e mov        edi, esi
01077690 test       r13d, r13d
01077693 je         0x1410776e9
01077695 call       qword ptr [rip + 0x87341d]
0107769b mov        qword ptr [rsp + 0x38], rsi
010776a0 lea        r8, [rbp + 0x62]
010776a4 mov        ecx, eax
010776a6 mov        qword ptr [rsp + 0x30], rsi
010776ab lea        rax, [rsp + 0x61]
010776b0 mov        r14d, 0xff
010776b6 mov        dword ptr [rsp + 0x28], r14d
010776bb mov        r9d, r13d
010776be xor        edx, edx
010776c0 mov        qword ptr [rsp + 0x20], rax
010776c5 call       qword ptr [rip + 0x873495]
010776cb movsxd     rdi, eax
010776ce test       eax, eax
010776d0 jne        0x1410776e9
010776d2 call       qword ptr [rip + 0x873110]
010776d8 cmp        eax, 0x7a
010776db jne        0x1410776e2
010776dd mov        edi, r14d
010776e0 jmp        0x1410776e9
010776e2 mov        ecx, eax
010776e4 call       0x140ad2900
010776e9 movzx      edi, dil
010776ed mov        byte ptr [rsp + 0x60], dil
010776f2 test       r12d, r12d
010776f5 je         0x14107798b
010776fb test       r15, r15
010776fe je         0x141077703
01077700 mov        dword ptr [r15], esi
01077703 test       rbx, rbx
01077706 je         0x141077c60
0107770c cmp        dword ptr [rbx], 0x73747263
01077712 jne        0x141077c60
01077718 cmp        dword ptr [rbx + 0x3c], esi
0107771b jne        0x141077c60
01077721 test       r12d, r12d
01077724 jle        0x141077c60
0107772a test       edi, edi
0107772c je         0x141077983
01077732 movzx      eax, byte ptr [rbx + 4]
01077736 and        al, 1
01077738 mov        byte ptr [rsp + 0x40], al
0107773c je         0x1410777d0
01077742 mov        eax, dword ptr [rbx + 0x28]
01077745 cmp        eax, r12d
01077748 jge        0x14107777c
0107774a mov        r14d, r12d
0107774d lea        rcx, [rbx + 8]
01077751 sub        r14d, eax
01077754 mov        eax, 0x32
01077759 cmp        r14d, eax
0107775c cmovl      r14d, eax
01077760 lea        edx, [r14*4]
01077768 call       0x140bc66f0
0107776d mov        r8d, eax
01077770 test       eax, eax
01077772 jne        0x141077cdb
01077778 add        dword ptr [rbx + 0x28], r14d
0107777c mov        rax, qword ptr [rbx + 8]
01077780 mov        rax, qword ptr [rax]
01077783 movsxd     r8, dword ptr [rax + r12*4 - 4]
01077788 test       r8d, r8d
0107778b je         0x1410777d0
0107778d cmp        dword ptr [rbx], 0x73747263
01077793 jne        0x141077798
01077795 inc        dword ptr [rbx + 0x3c]
01077798 mov        rax, qword ptr [rbx + 0x18]
0107779c mov        rcx, qword ptr [rax]
0107779f inc        dword ptr [rcx + r8*4 - 4]
010777a4 test       r15, r15
010777a7 je         0x1410777ac
010777a9 mov        dword ptr [r15], r8d
010777ac cmp        dword ptr [rbx], 0x73747263
010777b2 jne        0x141077983
010777b8 mov        eax, dword ptr [rbx + 0x3c]
010777bb test       eax, eax
010777bd jle        0x141077983
010777c3 dec        eax
010777c5 mov        r8d, esi
010777c8 mov        dword ptr [rbx + 0x3c], eax
010777cb jmp        0x141077cdb
010777d0 movsxd     rax, dword ptr [rbx + 0x30]
010777d4 test       eax, eax
010777d6 jne        0x1410777ec
010777d8 mov        rcx, rbx
010777db call       0x140bfdc50
010777e0 mov        r8d, eax
010777e3 test       eax, eax
010777e5 je         0x1410777d0
010777e7 jmp        0x141077cdb
010777ec mov        rdx, qword ptr [rbx + 0x10]
010777f0 lea        r14, [rax - 1]
010777f4 mov        rax, qword ptr [rdx]
010777f7 lea        r14, [rax + r14*8]
010777fb mov        eax, dword ptr [r14 + 4]
010777ff mov        r9, r14
01077802 mov        dword ptr [rbx + 0x30], eax
01077805 sub        r9, qword ptr [rdx]
01077808 mov        rdx, qword ptr [rbx + 0x20]
0107780c sar        r9, 3
01077810 mov        qword ptr [rsp + 0x48], r9
01077815 lea        r13, [r9 + 1]
01077819 mov        qword ptr [rsp + 0x50], r13
0107781e test       rdx, rdx
01077821 jne        0x141077827
01077823 mov        edx, esi
01077825 jmp        0x14107783a
01077827 cmp        dword ptr [rdx + 8], 0x4d656d48
0107782e je         0x141077834
01077830 mov        edx, esi
01077832 jmp        0x141077837
01077834 mov        edx, dword ptr [rdx + 0x10]
01077837 sub        edx, dword ptr [rbx + 0x34]
0107783a mov        dword ptr [rsp + 0x44], edx
0107783e cmp        edi, dword ptr [rbx + 0x34]
01077841 jle        0x141077935
01077847 mov        ecx, dword ptr [rbx + 0x38]
0107784a mov        eax, ecx
0107784c cmp        ecx, edi
0107784e movd       xmm0, edx
01077852 cvtdq2ps   xmm0, xmm0
01077855 cmovb      eax, edi
01077858 mulss      xmm0, dword ptr [rip + 0xbfb9f8]
01077860 cvttss2si  r13, xmm0
01077865 cmp        eax, r13d
01077868 cmovae     r13d, eax
0107786c cmp        ecx, 0x2000
01077872 jae        0x14107787a
01077874 lea        eax, [rcx + rcx]
01077877 mov        dword ptr [rbx + 0x38], eax
0107787a lea        r14, [rbx + 0x20]
0107787e test       r14, r14
01077881 jne        0x141077896
01077883 mov        rax, qword ptr [rbx + 0x10]
01077887 mov        r8d, 0xffffffce
0107788d mov        rcx, qword ptr [rax]
01077890 lea        r14, [rcx + r9*8]
01077894 jmp        0x141077911
01077896 mov        rcx, qword ptr [r14]
01077899 test       rcx, rcx
0107789c je         0x1410778d3
0107789e cmp        dword ptr [rcx + 8], 0x4d656d48
010778a5 mov        edx, esi
010778a7 jne        0x1410778ac
010778a9 mov        edx, dword ptr [rcx + 0x10]
010778ac test       r13d, r13d
010778af jns        0x1410778b9
010778b1 lea        eax, [rdx + r13]
010778b5 test       eax, eax
010778b7 js         0x141077883
010778b9 lea        eax, [rdx + r13]
010778bd movsxd     rdx, eax
010778c0 call       0x140bc65c0
010778c5 mov        edx, dword ptr [rsp + 0x44]
010778c9 mov        r8d, eax
010778cc mov        r9, qword ptr [rsp + 0x48]
010778d1 jmp        0x141077901
010778d3 test       r13d, r13d
010778d6 js         0x1410778fb
010778d8 movsxd     rcx, r13d
010778db call       0x140bc6490
010778e0 mov        edx, dword ptr [rsp + 0x44]
010778e4 test       rax, rax
010778e7 mov        r9, qword ptr [rsp + 0x48]
010778ec mov        r8d, 0xffffff94
010778f2 cmovne     r8d, esi
010778f6 mov        qword ptr [r14], rax
010778f9 jmp        0x141077901
010778fb mov        r8d, 0xffffff94
01077901 mov        rax, qword ptr [rbx + 0x10]
01077905 mov        rcx, qword ptr [rax]
01077908 lea        r14, [rcx + r9*8]
0107790c test       r8d, r8d
0107790f je         0x14107792c
01077911 mov        dword ptr [r14], 0x80000000
01077918 mov        eax, dword ptr [rbx + 0x30]
0107791b mov        dword ptr [r14 + 4], eax
0107791f mov        rax, qword ptr [rsp + 0x50]
01077924 mov        dword ptr [rbx + 0x30], eax
01077927 jmp        0x141077cdb
0107792c add        dword ptr [rbx + 0x34], r13d
01077930 mov        r13, qword ptr [rsp + 0x50]
01077935 mov        rax, qword ptr [rbx + 0x20]
01077939 movsxd     rcx, edx
0107793c add        rcx, qword ptr [rax]
0107793f je         0x141077952
01077941 movsxd     r8, edi
01077944 lea        rdx, [rsp + 0x61]
01077949 call       0x141867875
0107794e mov        edx, dword ptr [rsp + 0x44]
01077952 sub        dword ptr [rbx + 0x34], edi
01077955 mov        dword ptr [r14], edx
01077958 mov        dword ptr [r14 + 4], edi
0107795c test       r15, r15
0107795f je         0x141077964
01077961 mov        dword ptr [r15], r13d
01077964 cmp        byte ptr [rsp + 0x40], sil
01077969 je         0x141077983
0107796b mov        rax, qword ptr [rbx + 8]
0107796f mov        rax, qword ptr [rax]
01077972 mov        dword ptr [rax + r12*4 - 4], r13d
01077977 mov        rax, qword ptr [rbx + 0x18]
0107797b mov        rcx, qword ptr [rax]
0107797e inc        dword ptr [rcx + r13*4 - 4]
01077983 mov        r8d, esi
01077986 jmp        0x141077cdb
0107798b test       r15, r15
0107798e je         0x141077993
01077990 mov        dword ptr [r15], esi
01077993 test       rbx, rbx
01077996 je         0x141077c60
0107799c cmp        dword ptr [rbx], 0x73747263
010779a2 jne        0x141077c60
010779a8 cmp        dword ptr [rbx + 0x3c], esi
010779ab jne        0x141077c60
010779b1 test       edi, edi
010779b3 je         0x141077983
010779b5 cmp        dword ptr [rbx + 0x28], esi
010779b8 jne        0x141077c60
010779be movzx      eax, byte ptr [rbx + 4]
010779c2 and        al, 1
010779c4 mov        byte ptr [rsp + 0x40], al
010779c8 je         0x141077a72
010779ce mov        r8, qword ptr [rbx + 0x10]
010779d2 test       r8, r8
010779d5 je         0x141077a72
010779db mov        rax, qword ptr [rbx + 0x20]
010779df test       rax, rax
010779e2 je         0x141077a72
010779e8 movsxd     rdx, dword ptr [rbx + 0x2c]
010779ec mov        dword ptr [rbx + 0x3c], 1
010779f3 mov        r9, qword ptr [rax]
010779f6 mov        rax, qword ptr [rbx + 0x18]
010779fa lea        r13d, [rdx - 1]
010779fe mov        qword ptr [rsp + 0x50], r9
01077a03 lea        r14, [rdx - 1]
01077a07 mov        rax, qword ptr [rax]
01077a0a mov        qword ptr [rsp + 0x48], rax
01077a0f mov        rax, qword ptr [r8]
01077a12 lea        r14, [rax + r14*8]
01077a16 test       r13d, r13d
01077a19 js         0x141077a5e
01077a1b movzx      r12d, byte ptr [rsp + 0x61]
01077a21 mov        eax, dword ptr [r14 + 4]
01077a25 cmp        eax, edi
01077a27 jne        0x141077a54
01077a29 movsxd     rcx, dword ptr [r14]
01077a2c test       ecx, ecx
01077a2e js         0x141077a54
01077a30 test       eax, eax
01077a32 jle        0x141077a54
01077a34 cmp        r12b, byte ptr [r9 + rcx]
01077a38 lea        rdx, [r9 + rcx]
01077a3c jne        0x141077a54
01077a3e movsxd     r8, edi
01077a41 lea        rcx, [rsp + 0x61]
01077a46 call       0x14179cc94
01077a4b test       eax, eax
01077a4d je         0x141077a96
01077a4f mov        r9, qword ptr [rsp + 0x50]
01077a54 sub        r14, 8
01077a58 sub        r13d, 1
01077a5c jns        0x141077a21
01077a5e cmp        dword ptr [rbx], 0x73747263
01077a64 jne        0x141077a72
01077a66 mov        eax, dword ptr [rbx + 0x3c]
01077a69 test       eax, eax
01077a6b jle        0x141077a72
01077a6d dec        eax
01077a6f mov        dword ptr [rbx + 0x3c], eax
01077a72 mov        rcx, rbx
01077a75 call       0x140bfde40
01077a7a movsxd     rax, dword ptr [rbx + 0x30]
01077a7e test       eax, eax
01077a80 jne        0x141077ac9
01077a82 mov        rcx, rbx
01077a85 call       0x140bfdc50
01077a8a mov        r8d, eax
01077a8d test       eax, eax
01077a8f je         0x141077a72
01077a91 jmp        0x141077cdb
01077a96 mov        rcx, qword ptr [rsp + 0x48]
01077a9b movsxd     rax, r13d
01077a9e inc        dword ptr [rcx + rax*4]
01077aa1 test       r15, r15
01077aa4 je         0x141077aad
01077aa6 lea        eax, [r13 + 1]
01077aaa mov        dword ptr [r15], eax
01077aad cmp        dword ptr [rbx], 0x73747263
01077ab3 jne        0x141077ac1
01077ab5 mov        eax, dword ptr [rbx + 0x3c]
01077ab8 test       eax, eax
01077aba jle        0x141077ac1
01077abc dec        eax
01077abe mov        dword ptr [rbx + 0x3c], eax
01077ac1 mov        r8d, esi
01077ac4 jmp        0x141077cdb
01077ac9 mov        rdx, qword ptr [rbx + 0x10]
01077acd lea        r14, [rax - 1]
01077ad1 mov        r13, qword ptr [rbx + 0x20]
01077ad5 mov        rax, qword ptr [rdx]
01077ad8 lea        r14, [rax + r14*8]
01077adc mov        eax, dword ptr [r14 + 4]
01077ae0 mov        r12, r14
01077ae3 mov        dword ptr [rbx + 0x30], eax
01077ae6 sub        r12, qword ptr [rdx]
01077ae9 sar        r12, 3
01077aed inc        r12d
01077af0 movsxd     r9, r12d
01077af3 mov        qword ptr [rsp + 0x50], r9
01077af8 mov        dword ptr [rsp + 0x44], r12d
01077afd test       r13, r13
01077b00 jne        0x141077b07
01077b02 mov        r13d, esi
01077b05 jmp        0x141077b1e
01077b07 cmp        dword ptr [r13 + 8], 0x4d656d48
01077b0f je         0x141077b16
01077b11 mov        r13d, esi
01077b14 jmp        0x141077b1a
01077b16 mov        r13d, dword ptr [r13 + 0x10]
01077b1a sub        r13d, dword ptr [rbx + 0x34]
01077b1e cmp        edi, dword ptr [rbx + 0x34]
01077b21 jle        0x141077c18
01077b27 mov        ecx, dword ptr [rbx + 0x38]
01077b2a mov        eax, ecx
01077b2c cmp        ecx, edi
01077b2e movd       xmm0, r13d
01077b33 cvtdq2ps   xmm0, xmm0
01077b36 cmovb      eax, edi
01077b39 mulss      xmm0, dword ptr [rip + 0xbfb717]
01077b41 cvttss2si  r12, xmm0
01077b46 cmp        eax, r12d
01077b49 cmovae     r12d, eax
01077b4d cmp        ecx, 0x2000
01077b53 jae        0x141077b5b
01077b55 lea        eax, [rcx + rcx]
01077b58 mov        dword ptr [rbx + 0x38], eax
01077b5b lea        r14, [rbx + 0x20]
01077b5f test       r14, r14
01077b62 jne        0x141077b7b
01077b64 mov        rax, qword ptr [rbx + 0x10]
01077b68 mov        r8d, 0xffffffce
01077b6e mov        rcx, qword ptr [rax]
01077b71 sub        rcx, 8
01077b75 lea        r14, [rcx + r9*8]
01077b79 jmp        0x141077bf5
01077b7b mov        rcx, qword ptr [r14]
01077b7e test       rcx, rcx
01077b81 je         0x141077bb4
01077b83 cmp        dword ptr [rcx + 8], 0x4d656d48
01077b8a mov        edx, esi
01077b8c jne        0x141077b91
01077b8e mov        edx, dword ptr [rcx + 0x10]
01077b91 test       r12d, r12d
01077b94 jns        0x141077b9e
01077b96 lea        eax, [r12 + rdx]
01077b9a test       eax, eax
01077b9c js         0x141077b64
01077b9e lea        eax, [r12 + rdx]
01077ba2 movsxd     rdx, eax
01077ba5 call       0x140bc65c0
01077baa mov        r9, qword ptr [rsp + 0x50]
01077baf mov        r8d, eax
01077bb2 jmp        0x141077bde
01077bb4 test       r12d, r12d
01077bb7 js         0x141077bd8
01077bb9 movsxd     rcx, r12d
01077bbc call       0x140bc6490
01077bc1 mov        r9, qword ptr [rsp + 0x50]
01077bc6 test       rax, rax
01077bc9 mov        r8d, 0xffffff94
01077bcf mov        qword ptr [r14], rax
01077bd2 cmovne     r8d, esi
01077bd6 jmp        0x141077bde
01077bd8 mov        r8d, 0xffffff94
01077bde mov        rax, qword ptr [rbx + 0x10]
01077be2 movsxd     r14, r9d
01077be5 mov        rcx, qword ptr [rax]
01077be8 sub        rcx, 8
01077bec lea        r14, [rcx + r14*8]
01077bf0 test       r8d, r8d
01077bf3 je         0x141077c0f
01077bf5 mov        dword ptr [r14], 0x80000000
01077bfc mov        eax, dword ptr [rbx + 0x30]
01077bff mov        dword ptr [r14 + 4], eax
01077c03 mov        eax, dword ptr [rsp + 0x44]
01077c07 mov        dword ptr [rbx + 0x30], eax
01077c0a jmp        0x141077cdb
01077c0f add        dword ptr [rbx + 0x34], r12d
01077c13 mov        r12d, dword ptr [rsp + 0x44]
01077c18 mov        rax, qword ptr [rbx + 0x20]
01077c1c movsxd     rcx, r13d
01077c1f add        rcx, qword ptr [rax]
01077c22 je         0x141077c31
01077c24 mov        r8, rdi
01077c27 lea        rdx, [rsp + 0x61]
01077c2c call       0x141867875
01077c31 sub        dword ptr [rbx + 0x34], edi
01077c34 mov        dword ptr [r14], r13d
01077c37 mov        dword ptr [r14 + 4], edi
01077c3b test       r15, r15
01077c3e je         0x141077c43
01077c40 mov        dword ptr [r15], r12d
01077c43 cmp        byte ptr [rsp + 0x40], sil
01077c48 je         0x141077c58
01077c4a mov        rax, qword ptr [rbx + 0x18]
01077c4e movsxd     rdx, r12d
01077c51 mov        rcx, qword ptr [rax]
01077c54 inc        dword ptr [rcx + rdx*4 - 4]
01077c58 mov        r8d, esi
01077c5b jmp        0x141077cdb
01077c60 mov        r8d, 0xffffffce
01077c66 jmp        0x141077cdb
01077c68 cmp        r14d, 3
01077c6c jne        0x141077cc1
01077c6e cmp        dword ptr [rsp + 0x44], 1
01077c73 jne        0x141077cc1
01077c75 mov        r14d, 0xff
01077c7b cmp        edi, r14d
01077c7e cmova      edi, r14d
01077c82 mov        word ptr [rbp + 0x60], di
01077c86 test       edi, edi
01077c88 je         0x141077cb8
01077c8a lea        rcx, [r13 + 0xa00128]
01077c91 mov        r8d, edi
01077c94 lea        rdx, [rbp + 0x62]
01077c98 nop        dword ptr [rax + rax]
01077ca0 movzx      eax, byte ptr [rcx]
01077ca3 lea        rcx, [rcx + 1]
01077ca7 mov        word ptr [rdx], ax
01077caa lea        rdx, [rdx + 2]
01077cae sub        r8, 1
01077cb2 jne        0x141077ca0
01077cb4 movzx      edi, word ptr [rbp + 0x60]
01077cb8 movzx      r8d, di
01077cbc jmp        0x14107761f
01077cc1 lea        rdx, [r13 + 0xa00128]
01077cc8 mov        r8d, edi
01077ccb jmp        0x141077626
01077cd0 mov        r9, r15
01077cd3 call       0x140bfe1f0
01077cd8 mov        r8d, eax
01077cdb mov        r14, qword ptr [rsp + 0x370]
01077ce3 mov        rsi, qword ptr [rsp + 0x3b8]
01077ceb mov        rdi, qword ptr [rsp + 0x378]
; range 0x1077cf3..0x1077d15 (exclusive)
01077cf3 mov        eax, r8d
01077cf6 mov        rcx, qword ptr [rbp + 0x260]
01077cfd xor        rcx, rsp
01077d00 call       0x14179b8e0
01077d05 add        rsp, 0x380
01077d0c pop        r15
01077d0e pop        r13
01077d10 pop        r12
01077d12 pop        rbx
01077d13 pop        rbp
01077d14 ret        
