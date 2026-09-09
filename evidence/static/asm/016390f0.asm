; Original iTunes.exe machine code; base=0x140000000; RVA=0x16390f0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x16390f0..0x1639899 (exclusive)
016390f0 mov        rax, rsp
016390f3 mov        qword ptr [rax + 0x10], rbx
016390f7 mov        qword ptr [rax + 0x18], rsi
016390fb mov        qword ptr [rax + 0x20], rdi
016390ff push       rbp
01639100 push       r12
01639102 push       r13
01639104 push       r14
01639106 push       r15
01639108 lea        rbp, [rax - 0x48]
0163910c sub        rsp, 0x120
01639113 movaps     xmmword ptr [rax - 0x38], xmm6
01639117 movaps     xmmword ptr [rax - 0x48], xmm7
0163911b movaps     xmmword ptr [rax - 0x58], xmm8
01639120 movaps     xmmword ptr [rax - 0x68], xmm9
01639125 movaps     xmmword ptr [rax - 0x78], xmm10
0163912a movaps     xmmword ptr [rax - 0x88], xmm11
01639132 mov        rsi, rdx
01639135 mov        r13, rcx
01639138 xor        r12d, r12d
0163913b xorps      xmm0, xmm0
0163913e movdqu     xmmword ptr [rsp + 0x30], xmm0
01639144 mov        byte ptr [rcx + 0xf0], r12b
0163914b mov        r8d, 8
01639151 call       0x1416374e0
01639156 mov        edi, eax
01639158 mov        r14d, 0xffffffff
0163915e test       eax, eax
01639160 jne        0x14163980e
01639166 xor        edx, edx
01639168 lea        rcx, [rsp + 0x70]
0163916d call       0x140b9fe10
01639172 mov        edi, eax
01639174 test       eax, eax
01639176 jne        0x14163980e
0163917c mov        rdx, rsi
0163917f lea        rcx, [rsp + 0x40]
01639184 call       0x140ef0a40
01639189 mov        rbx, rax
0163918c lea        rax, [rsp + 0x30]
01639191 cmp        rbx, rax
01639194 je         0x1416391f4
01639196 mov        rcx, qword ptr [rsp + 0x30]
0163919b test       rcx, rcx
0163919e je         0x1416391b9
016391a0 mov        edx, r14d
016391a3 lock xadd  dword ptr [rcx + 8], edx
016391a8 cmp        edx, 1
016391ab jne        0x1416391b9
016391ad mov        dword ptr [rcx + 8], 0xc4653600
016391b4 call       0x14179bdd8
016391b9 mov        rcx, qword ptr [rsp + 0x38]
016391be test       rcx, rcx
016391c1 je         0x1416391dc
016391c3 mov        eax, r14d
016391c6 lock xadd  dword ptr [rcx + 8], eax
016391cb cmp        eax, 1
016391ce jne        0x1416391dc
016391d0 mov        dword ptr [rcx + 8], 0xc4653600
016391d7 call       0x14179bdd8
016391dc mov        rax, qword ptr [rbx]
016391df mov        qword ptr [rsp + 0x30], rax
016391e4 mov        rax, qword ptr [rbx + 8]
016391e8 mov        qword ptr [rsp + 0x38], rax
016391ed mov        qword ptr [rbx], r12
016391f0 mov        qword ptr [rbx + 8], r12
016391f4 mov        rcx, qword ptr [rsp + 0x40]
016391f9 test       rcx, rcx
016391fc je         0x14163921c
016391fe mov        eax, r14d
01639201 lock xadd  dword ptr [rcx + 8], eax
01639206 cmp        eax, 1
01639209 jne        0x141639217
0163920b mov        dword ptr [rcx + 8], 0xc4653600
01639212 call       0x14179bdd8
01639217 mov        qword ptr [rsp + 0x40], r12
0163921c mov        rcx, qword ptr [rsp + 0x48]
01639221 test       rcx, rcx
01639224 je         0x141639244
01639226 mov        eax, r14d
01639229 lock xadd  dword ptr [rcx + 8], eax
0163922e cmp        eax, 1
01639231 jne        0x14163923f
01639233 mov        dword ptr [rcx + 8], 0xc4653600
0163923a call       0x14179bdd8
0163923f mov        qword ptr [rsp + 0x48], r12
01639244 movups     xmm7, xmmword ptr [rsi + 0x180]
0163924b movups     xmm8, xmmword ptr [rsi + 0x190]
01639253 movups     xmm9, xmmword ptr [rsi + 0x1a0]
0163925b movups     xmm10, xmmword ptr [rsi + 0x1b0]
01639263 movups     xmm11, xmmword ptr [rsi + 0x1c0]
0163926b mov        qword ptr [rsi + 0x188], r12
01639272 mov        qword ptr [rsi + 0x190], r12
01639279 mov        byte ptr [rsi + 0x180], 0
01639280 mov        byte ptr [rsi + 0x198], 0
01639287 mov        dword ptr [rsi + 0x19c], r12d
0163928e mov        word ptr [rsi + 0x182], 0
01639297 mov        rcx, qword ptr [rip + 0xa96a42]
0163929e test       rcx, rcx
016392a1 je         0x1416392d2
016392a3 mov        edx, 0xbf0003
016392a8 call       qword ptr [rip + 0x2afb42]
016392ae mov        rdi, rax
016392b1 test       rax, rax
016392b4 je         0x1416392cd
016392b6 mov        rcx, rax
016392b9 call       qword ptr [rip + 0x2afc01]
016392bf mov        rbx, rax
016392c2 call       qword ptr [rip + 0x2afcb8]
016392c8 cmp        rbx, rax
016392cb jne        0x1416392d2
016392cd test       rdi, rdi
016392d0 jne        0x1416392d9
016392d2 mov        rdi, qword ptr [rip + 0xa7491f]
016392d9 mov        rdx, rdi
016392dc lea        rcx, [rsp + 0x60]
016392e1 call       0x140ad62e0
016392e6 nop        
016392e7 lea        r15, [rip + 0x37805a]
016392ee mov        rax, qword ptr [rsp + 0x30]
016392f3 test       rax, rax
016392f6 jne        0x141639318
016392f8 cmp        qword ptr [rsp + 0x38], rax
016392fd je         0x141639313
016392ff lea        rcx, [rsp + 0x30]
01639304 call       0x140add540
01639309 mov        rax, qword ptr [rsp + 0x30]
0163930e test       rax, rax
01639311 jne        0x141639318
01639313 mov        r8, r15
01639316 jmp        0x14163931c
01639318 lea        r8, [rax + 0xc]
0163931c movaps     xmm6, xmmword ptr [rsp + 0x60]
01639321 movdqa     xmmword ptr [rsp + 0x40], xmm6
01639327 movq       rbx, xmm6
0163932c test       rbx, rbx
0163932f je         0x141639335
01639331 lock inc   dword ptr [rbx + 8]
01639335 mov        rax, qword ptr [rsp + 0x48]
0163933a test       rax, rax
0163933d je         0x141639343
0163933f lock inc   dword ptr [rax + 8]
01639343 lea        rdx, [rsp + 0x40]
01639348 lea        rcx, [rsp + 0x50]
0163934d call       0x140ada420
01639352 lea        rcx, [r13 + 0x70]
01639356 lea        rdx, [rsp + 0x50]
0163935b call       0x140ad6630
01639360 mov        rcx, qword ptr [rsp + 0x50]
01639365 test       rcx, rcx
01639368 je         0x141639388
0163936a mov        eax, r14d
0163936d lock xadd  dword ptr [rcx + 8], eax
01639372 cmp        eax, 1
01639375 jne        0x141639383
01639377 mov        dword ptr [rcx + 8], 0xc4653600
0163937e call       0x14179bdd8
01639383 mov        qword ptr [rsp + 0x50], r12
01639388 mov        rcx, qword ptr [rsp + 0x58]
0163938d test       rcx, rcx
01639390 je         0x1416393b0
01639392 mov        eax, r14d
01639395 lock xadd  dword ptr [rcx + 8], eax
0163939a cmp        eax, 1
0163939d jne        0x1416393ab
0163939f mov        dword ptr [rcx + 8], 0xc4653600
016393a6 call       0x14179bdd8
016393ab mov        qword ptr [rsp + 0x58], r12
016393b0 test       rbx, rbx
016393b3 je         0x1416393d1
016393b5 mov        eax, r14d
016393b8 lock xadd  dword ptr [rbx + 8], eax
016393bd cmp        eax, 1
016393c0 jne        0x1416393d1
016393c2 mov        dword ptr [rbx + 8], 0xc4653600
016393c9 mov        rcx, rbx
016393cc call       0x14179bdd8
016393d1 psrldq     xmm6, 8
016393d6 movq       rcx, xmm6
016393db test       rcx, rcx
016393de je         0x1416393f9
016393e0 mov        eax, r14d
016393e3 lock xadd  dword ptr [rcx + 8], eax
016393e8 cmp        eax, 1
016393eb jne        0x1416393f9
016393ed mov        dword ptr [rcx + 8], 0xc4653600
016393f4 call       0x14179bdd8
016393f9 mov        rcx, qword ptr [rip + 0xa968e0]
01639400 test       rcx, rcx
01639403 je         0x141639434
01639405 mov        edx, 0xbf0004
0163940a call       qword ptr [rip + 0x2af9e0]
01639410 mov        rdi, rax
01639413 test       rax, rax
01639416 je         0x14163942f
01639418 mov        rcx, rax
0163941b call       qword ptr [rip + 0x2afa9f]
01639421 mov        rbx, rax
01639424 call       qword ptr [rip + 0x2afb56]
0163942a cmp        rbx, rax
0163942d jne        0x141639434
0163942f test       rdi, rdi
01639432 jne        0x14163943b
01639434 mov        rdi, qword ptr [rip + 0xa747bd]
0163943b mov        rdx, rdi
0163943e lea        rcx, [rsp + 0x60]
01639443 call       0x140ad62e0
01639448 nop        
01639449 mov        rax, qword ptr [rsp + 0x30]
0163944e test       rax, rax
01639451 jne        0x14163946e
01639453 cmp        qword ptr [rsp + 0x38], rax
01639458 je         0x141639472
0163945a lea        rcx, [rsp + 0x30]
0163945f call       0x140add540
01639464 mov        rax, qword ptr [rsp + 0x30]
01639469 test       rax, rax
0163946c je         0x141639472
0163946e lea        r15, [rax + 0xc]
01639472 movaps     xmm6, xmmword ptr [rsp + 0x60]
01639477 movdqa     xmmword ptr [rsp + 0x50], xmm6
0163947d movq       rbx, xmm6
01639482 test       rbx, rbx
01639485 je         0x14163948b
01639487 lock inc   dword ptr [rbx + 8]
0163948b mov        rax, qword ptr [rsp + 0x58]
01639490 test       rax, rax
01639493 je         0x141639499
01639495 lock inc   dword ptr [rax + 8]
01639499 mov        r8, r15
0163949c lea        rdx, [rsp + 0x50]
016394a1 lea        rcx, [rsp + 0x40]
016394a6 call       0x140ada420
016394ab lea        rcx, [r13 + 0x98]
016394b2 lea        rdx, [rsp + 0x40]
016394b7 call       0x140ad6630
016394bc mov        rcx, qword ptr [rsp + 0x40]
016394c1 test       rcx, rcx
016394c4 je         0x1416394e4
016394c6 mov        eax, r14d
016394c9 lock xadd  dword ptr [rcx + 8], eax
016394ce cmp        eax, 1
016394d1 jne        0x1416394df
016394d3 mov        dword ptr [rcx + 8], 0xc4653600
016394da call       0x14179bdd8
016394df mov        qword ptr [rsp + 0x40], r12
016394e4 mov        rcx, qword ptr [rsp + 0x48]
016394e9 test       rcx, rcx
016394ec je         0x14163950c
016394ee mov        eax, r14d
016394f1 lock xadd  dword ptr [rcx + 8], eax
016394f6 cmp        eax, 1
016394f9 jne        0x141639507
016394fb mov        dword ptr [rcx + 8], 0xc4653600
01639502 call       0x14179bdd8
01639507 mov        qword ptr [rsp + 0x48], r12
0163950c test       rbx, rbx
0163950f je         0x14163952d
01639511 mov        eax, r14d
01639514 lock xadd  dword ptr [rbx + 8], eax
01639519 cmp        eax, 1
0163951c jne        0x14163952d
0163951e mov        dword ptr [rbx + 8], 0xc4653600
01639525 mov        rcx, rbx
01639528 call       0x14179bdd8
0163952d psrldq     xmm6, 8
01639532 movq       rcx, xmm6
01639537 test       rcx, rcx
0163953a je         0x141639555
0163953c mov        eax, r14d
0163953f lock xadd  dword ptr [rcx + 8], eax
01639544 cmp        eax, 1
01639547 jne        0x141639555
01639549 mov        dword ptr [rcx + 8], 0xc4653600
01639550 call       0x14179bdd8
01639555 mov        rdi, qword ptr [rsi + 8]
01639559 mov        edx, 0x10
0163955e mov        ecx, 0x1e00308
01639563 call       qword ptr [rip + 0x2b2e07]
01639569 mov        rbx, rax
0163956c test       rax, rax
0163956f je         0x1416397d7
01639575 xor        edx, edx
01639577 mov        r8d, 0x120
0163957d mov        rcx, rax
01639580 call       0x14179cca0
01639585 lea        rcx, [rbx + 0x128]
0163958c xor        edx, edx
0163958e mov        r8d, 0x1e00148
01639594 call       0x14179cca0
01639599 xorps      xmm0, xmm0
0163959c movups     xmmword ptr [rbx + 0x1e00278], xmm0
016395a3 movups     xmmword ptr [rbx + 0x1e00288], xmm0
016395aa movups     xmmword ptr [rbx + 0x1e00298], xmm0
016395b1 movups     xmmword ptr [rbx + 0x1e002a8], xmm0
016395b8 movups     xmmword ptr [rbx + 0x1e002b8], xmm0
016395bf movups     xmmword ptr [rbx + 0x1e002c8], xmm0
016395c6 movups     xmmword ptr [rbx + 0x1e002d8], xmm0
016395cd movups     xmmword ptr [rbx + 0x1e002e8], xmm0
016395d4 movups     xmmword ptr [rbx + 0x1e002f8], xmm0
016395db mov        qword ptr [rbx + 0x1e00270], rdi
016395e2 lea        rax, [rsp + 0x70]
016395e7 mov        qword ptr [rbx + 0x120], rax
016395ee mov        rcx, rbx
016395f1 call       0x14106a430
016395f6 mov        r9, rsi
016395f9 lea        r8, [rip - 0x530]
01639600 mov        edx, 2
01639605 mov        rcx, rbx
01639608 call       0x1410725a0
0163960d mov        edi, eax
0163960f mov        rcx, rbx
01639612 call       qword ptr [rip + 0x2b2d50]
01639618 movups     xmmword ptr [rsi + 0x180], xmm7
0163961f movups     xmmword ptr [rsi + 0x190], xmm8
01639627 movups     xmmword ptr [rsi + 0x1a0], xmm9
0163962f movups     xmmword ptr [rsi + 0x1b0], xmm10
01639637 movups     xmmword ptr [rsi + 0x1c0], xmm11
0163963f test       edi, edi
01639641 jne        0x141639803
01639647 lea        rdx, [rsp + 0x70]
0163964c call       0x140ba1750
01639651 mov        qword ptr [r13 + 0xf8], rax
01639658 test       rax, rax
0163965b je         0x1416397fe
01639661 test       byte ptr [rsi + 0x228], 2
01639668 jne        0x141639721
0163966e lea        rdx, [rbp + 0x50]
01639672 mov        rcx, rsi
01639675 call       0x1402dc9a0
0163967a mov        edi, eax
0163967c test       eax, eax
0163967e jne        0x141639803
01639684 xorps      xmm0, xmm0
01639687 movdqu     xmmword ptr [rsp + 0x60], xmm0
0163968d mov        byte ptr [rsp + 0x28], al
01639691 mov        rbx, qword ptr [rbp + 0x50]
01639695 mov        r9, rbx
01639698 mov        r8, rbx
0163969b mov        edx, 4
016396a0 mov        rcx, rsi
016396a3 call       0x141639d60
016396a8 mov        r15, rax
016396ab test       rbx, rbx
016396ae je         0x1416396dd
016396b0 cmp        dword ptr [rbx], 0x4f4c5354
016396b6 jne        0x1416396dd
016396b8 mov        eax, dword ptr [rbx + 4]
016396bb test       eax, eax
016396bd je         0x1416396dd
016396bf sub        eax, 1
016396c2 mov        dword ptr [rbx + 4], eax
016396c5 jne        0x1416396dd
016396c7 lea        rcx, [rbx + 8]
016396cb call       0x1402de700
016396d0 mov        edx, 0x20
016396d5 mov        rcx, rbx
016396d8 call       0x140bc6a20
016396dd test       r15, r15
016396e0 jne        0x1416396ec
016396e2 mov        edi, 0xffffffce
016396e7 jmp        0x141639803
016396ec lea        rcx, [r15 + 8]
016396f0 lea        rdx, [r13 + 0x80]
016396f7 test       rdx, rdx
016396fa je         0x141639721
016396fc test       rcx, rcx
016396ff je         0x141639721
01639701 mov        qword ptr [rcx], r12
01639704 mov        rax, qword ptr [rdx + 8]
01639708 mov        qword ptr [rcx + 8], rax
0163970c mov        rax, qword ptr [rdx + 8]
01639710 test       rax, rax
01639713 je         0x14163971a
01639715 mov        qword ptr [rax], rcx
01639718 jmp        0x14163971d
0163971a mov        qword ptr [rdx], rcx
0163971d mov        qword ptr [rdx + 8], rcx
01639721 mov        rsi, qword ptr [rsi + 0x38]
01639725 test       rsi, rsi
01639728 je         0x141639803
0163972e lea        r15, [rip + 0x608c83]
01639735 nop        word ptr [rax + rax]
01639740 lea        rdx, [rip + 0x2d94b9]
01639747 mov        ecx, 0x100
0163974c call       0x14179beec
01639751 mov        rbx, rax
01639754 mov        qword ptr [rbp + 0x50], rax
01639758 test       rax, rax
0163975b je         0x1416397fe
01639761 mov        rcx, rax
01639764 call       0x141637350
01639769 mov        qword ptr [rbx], r15
0163976c mov        qword ptr [rbx + 0xf8], r12
01639773 mov        rdx, rsi
01639776 mov        rcx, rbx
01639779 call       0x1416390f0
0163977e mov        edi, eax
01639780 test       eax, eax
01639782 jne        0x1416397c8
01639784 add        rbx, 8
01639788 lea        rcx, [r13 + 0x80]
0163978f test       rcx, rcx
01639792 je         0x1416397b9
01639794 test       rbx, rbx
01639797 je         0x1416397b9
01639799 mov        qword ptr [rbx], r12
0163979c mov        rax, qword ptr [rcx + 8]
016397a0 mov        qword ptr [rbx + 8], rax
016397a4 mov        rax, qword ptr [rcx + 8]
016397a8 test       rax, rax
016397ab je         0x1416397b2
016397ad mov        qword ptr [rax], rbx
016397b0 jmp        0x1416397b5
016397b2 mov        qword ptr [rcx], rbx
016397b5 mov        qword ptr [rcx + 8], rbx
016397b9 mov        rsi, qword ptr [rsi + 0x20]
016397bd test       rsi, rsi
016397c0 jne        0x141639740
016397c6 jmp        0x141639803
016397c8 mov        rax, qword ptr [rbx]
016397cb mov        edx, 1
016397d0 mov        rcx, rbx
016397d3 call       qword ptr [rax]
016397d5 jmp        0x141639803
016397d7 movups     xmmword ptr [rsi + 0x180], xmm7
016397de movups     xmmword ptr [rsi + 0x190], xmm8
016397e6 movups     xmmword ptr [rsi + 0x1a0], xmm9
016397ee movups     xmmword ptr [rsi + 0x1b0], xmm10
016397f6 movups     xmmword ptr [rsi + 0x1c0], xmm11
016397fe mov        edi, 0xffffff94
01639803 lea        rcx, [rsp + 0x70]
01639808 call       0x140ba02c0
0163980d nop        
0163980e mov        rcx, qword ptr [rsp + 0x30]
01639813 test       rcx, rcx
01639816 je         0x141639836
01639818 mov        eax, r14d
0163981b lock xadd  dword ptr [rcx + 8], eax
01639820 cmp        eax, 1
01639823 jne        0x141639831
01639825 mov        dword ptr [rcx + 8], 0xc4653600
0163982c call       0x14179bdd8
01639831 mov        qword ptr [rsp + 0x30], r12
01639836 mov        rcx, qword ptr [rsp + 0x38]
0163983b test       rcx, rcx
0163983e je         0x141639858
01639840 lock xadd  dword ptr [rcx + 8], r14d
01639846 cmp        r14d, 1
0163984a jne        0x141639858
0163984c mov        dword ptr [rcx + 8], 0xc4653600
01639853 call       0x14179bdd8
01639858 mov        eax, edi
0163985a lea        r11, [rsp + 0x120]
01639862 mov        rbx, qword ptr [r11 + 0x38]
01639866 mov        rsi, qword ptr [r11 + 0x40]
0163986a mov        rdi, qword ptr [r11 + 0x48]
0163986e movaps     xmm6, xmmword ptr [r11 - 0x10]
01639873 movaps     xmm7, xmmword ptr [r11 - 0x20]
01639878 movaps     xmm8, xmmword ptr [r11 - 0x30]
0163987d movaps     xmm9, xmmword ptr [r11 - 0x40]
01639882 movaps     xmm10, xmmword ptr [r11 - 0x50]
01639887 movaps     xmm11, xmmword ptr [r11 - 0x60]
0163988c mov        rsp, r11
0163988f pop        r15
01639891 pop        r14
01639893 pop        r13
01639895 pop        r12
01639897 pop        rbp
01639898 ret        
