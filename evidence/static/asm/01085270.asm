; Original iTunes.exe machine code; base=0x140000000; RVA=0x1085270; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1085270..0x10866f4 (exclusive)
01085270 push       rbp
01085272 push       rbx
01085273 push       rsi
01085274 push       rdi
01085275 push       r12
01085277 push       r13
01085279 push       r14
0108527b push       r15
0108527d lea        rbp, [rsp - 0x6d8]
01085285 sub        rsp, 0x7d8
0108528c mov        rax, qword ptr [rip + 0xf4fdad]
01085293 xor        rax, rsp
01085296 mov        qword ptr [rbp + 0x6c0], rax
0108529d mov        qword ptr [rbp + 0x28], r9
010852a1 mov        qword ptr [rbp + 0x10], r8
010852a5 mov        rbx, rdx
010852a8 mov        r15, rcx
010852ab mov        qword ptr [rbp + 0x30], rcx
010852af mov        r12, qword ptr [rbp + 0x758]
010852b6 mov        qword ptr [rbp + 0x18], r12
010852ba mov        rax, qword ptr [rbp + 0x740]
010852c1 mov        qword ptr [rbp + 0x38], rax
010852c5 mov        rax, qword ptr [rbp + 0x748]
010852cc mov        qword ptr [rbp + 0x40], rax
010852d0 mov        rax, qword ptr [rbp + 0x750]
010852d7 mov        qword ptr [rbp + 0x48], rax
010852db xorps      xmm0, xmm0
010852de xor        eax, eax
010852e0 movups     xmmword ptr [rsp + 0x60], xmm0
010852e5 movups     xmmword ptr [rsp + 0x70], xmm0
010852ea movups     xmmword ptr [rbp - 0x80], xmm0
010852ee movups     xmmword ptr [rbp - 0x70], xmm0
010852f2 mov        qword ptr [rbp - 0x60], rax
010852f6 xorps      xmm1, xmm1
010852f9 movups     xmmword ptr [rbp - 0x40], xmm1
010852fd movups     xmmword ptr [rbp - 0x30], xmm1
01085301 movups     xmmword ptr [rbp - 0x20], xmm1
01085305 movups     xmmword ptr [rbp - 0x10], xmm1
01085309 mov        qword ptr [rbp], rax
0108530d test       rcx, rcx
01085310 je         0x14108666d
01085316 cmp        dword ptr [rcx + 0xa4], eax
0108531c jne        0x14108666d
01085322 cmp        dword ptr [rcx + 0x80], 0x74646174
0108532c jne        0x14108533b
0108532e cmp        qword ptr [rcx + 0xb8], rax
01085335 jne        0x14108666d
0108533b mov        ecx, 0x1e00308
01085340 call       0x140bc69e0
01085345 mov        rsi, rax
01085348 mov        qword ptr [rbp - 0x50], rax
0108534c test       rax, rax
0108534f je         0x141086666
01085355 xor        r14d, r14d
01085358 mov        qword ptr [rax + 0x1e00278], r14
0108535f mov        qword ptr [rax + 0x1e00280], r14
01085366 mov        qword ptr [rax + 0x1e00288], r14
0108536d mov        qword ptr [rax + 0x1e00290], r14
01085374 mov        qword ptr [rax + 0x1e00298], r14
0108537b mov        qword ptr [rax + 0x1e002a0], r14
01085382 mov        qword ptr [rax + 0x1e002a8], r14
01085389 mov        qword ptr [rax + 0x1e002b0], r14
01085390 mov        qword ptr [rax + 0x1e002b8], r14
01085397 mov        qword ptr [rax + 0x1e002c0], r14
0108539e mov        qword ptr [rax + 0x1e002c8], r14
010853a5 mov        qword ptr [rax + 0x1e002d0], r14
010853ac mov        qword ptr [rax + 0x1e002d8], r14
010853b3 mov        qword ptr [rax + 0x1e002e0], r14
010853ba mov        qword ptr [rax + 0x1e002e8], r14
010853c1 mov        qword ptr [rsp + 0x30], rax
010853c6 mov        r13, rax
010853c9 test       rax, rax
010853cc je         0x141086666
010853d2 mov        qword ptr [rax + 0x1e00270], r15
010853d9 mov        rdx, rax
010853dc mov        rcx, rbx
010853df call       0x141085040
010853e4 test       eax, eax
010853e6 je         0x1410853fa
010853e8 mov        rcx, r13
010853eb call       0x141086700
010853f0 mov        eax, 0xffffff30
010853f5 jmp        0x141086672
010853fa mov        eax, dword ptr [rbp + 0x760]
01085400 bt         eax, 0x1d
01085404 jae        0x14108540d
01085406 mov        byte ptr [rsi + 0x1e002f2], 1
0108540d mov        qword ptr [rsi + 0x1e00188], r12
01085414 mov        qword ptr [rsi + 0x1e00198], 0xffffffffffffffff
0108541f movzx      ecx, word ptr [rsi + 0xc]
01085423 cmp        cx, 0x43
01085427 ja         0x14108621f
0108542d cmp        dword ptr [rsi + 0x30], r14d
01085431 jne        0x14108543d
01085433 mov        ebx, 0xffffff30
01085438 jmp        0x141086224
0108543d bt         eax, 9
01085441 jb         0x14108546a
01085443 test       byte ptr [r15 + 0x110], 1
0108544b jne        0x14108546a
0108544d cmp        dword ptr [r15 + 0x84], 0x706d6574
01085458 je         0x14108546a
0108545a cmp        cx, 0x43
0108545e je         0x14108546a
01085460 mov        ebx, 0xffffff30
01085465 jmp        0x141086224
0108546a movzx      eax, byte ptr [rsi + 0x41]
0108546e test       al, al
01085470 je         0x14108547c
01085472 dec        al
01085474 cmp        al, 1
01085476 ja         0x14108621f
0108547c cmp        cx, 0x43
01085480 jne        0x141085489
01085482 cmp        word ptr [rsi + 0xe], 1
01085487 je         0x141085498
01085489 or         byte ptr [r15 + 0x113], 1
01085491 mov        byte ptr [rsi + 0x1e002f1], 1
01085498 test       r12, r12
0108549b je         0x1410854bf
0108549d mov        rax, qword ptr [r12]
010854a1 test       rax, rax
010854a4 je         0x1410854bf
010854a6 mov        qword ptr [rsp + 0x20], r14
010854ab mov        r9, 0xffffffffffffffff
010854b2 xor        r8d, r8d
010854b5 mov        edx, 0x6370726d
010854ba mov        rcx, r12
010854bd call       rax
010854bf mov        qword ptr [rsi + 0x1e00160], 0xffffffffffffffff
010854ca mov        qword ptr [rsi + 0x1e00168], 0xffffffffffffffff
010854d5 xor        r9d, r9d
010854d8 mov        r8b, 1
010854db mov        rdx, rbx
010854de lea        rcx, [rsp + 0x40]
010854e3 cmp        byte ptr [rsi + 0x43], r14b
010854e7 je         0x1410856ec
010854ed call       0x140bd4f30
010854f2 mov        r14d, eax
010854f5 test       eax, eax
010854f7 jne        0x1410856e4
010854fd mov        ebx, 0x500000
01085502 xor        ecx, ecx
01085504 mov        r14d, ecx
01085507 mov        dword ptr [rbp - 0x40], 0x62756666
0108550e mov        word ptr [rbp - 0x3b], 0x101
01085514 mov        rax, qword ptr [rsp + 0x40]
01085519 mov        qword ptr [rbp - 0x38], rax
0108551d mov        rdi, rsi
01085520 test       r14d, r14d
01085523 jne        0x14108565f
01085529 mov        edx, 0x10
0108552e mov        rcx, rbx
01085531 call       qword ptr [rip + 0x866e39]
01085537 mov        rcx, rax
0108553a test       rax, rax
0108553d jne        0x141085555
0108553f cmp        rbx, 0x1000
01085546 jae        0x141085550
01085548 mov        r14d, 0xffffff94
0108554e jmp        0x141085520
01085550 shr        rbx, 1
01085553 jmp        0x141085520
01085555 mov        qword ptr [rbp - 0x10], rcx
01085559 mov        qword ptr [rbp - 0x28], rbx
0108555d cmp        byte ptr [rbp - 0x3b], 0
01085561 je         0x141085570
01085563 inc        rax
01085566 mov        qword ptr [rbp - 0x20], rax
0108556a mov        qword ptr [rbp - 8], rcx
0108556e jmp        0x14108557f
01085570 mov        qword ptr [rbp - 0x20], rcx
01085574 lea        rax, [rbx - 1]
01085578 add        rax, rcx
0108557b mov        qword ptr [rbp - 8], rax
0108557f lea        rax, [rbp - 0x40]
01085583 mov        qword ptr [rsi + 0x120], rax
0108558a mov        edx, dword ptr [rsi + 4]
0108558d lea        rcx, [rbp - 0x40]
01085591 call       0x140ba09a0
01085596 mov        eax, dword ptr [rsi + 4]
01085599 mov        qword ptr [rsi + 0x1e00170], rax
010855a0 mov        edx, 0xa00000
010855a5 lea        rcx, [rsp + 0x60]
010855aa call       0x140b9fe10
010855af test       eax, eax
010855b1 jne        0x141086672
010855b7 movzx      eax, byte ptr [rsi + 0x41]
010855bb test       al, al
010855bd je         0x1410855fe
010855bf mov        ecx, dword ptr [rsi + 4]
010855c2 mov        qword ptr [rsi + 0x1e00160], rcx
010855c9 cmp        al, 2
010855cb jne        0x1410855da
010855cd mov        eax, dword ptr [rsi + 0x5c]
010855d0 add        rax, rcx
010855d3 mov        qword ptr [rsi + 0x1e00168], rax
010855da lea        rcx, [rsi + 0x1e00128]
010855e1 xor        edx, edx
010855e3 call       0x14106a3a0
010855e8 mov        ebx, eax
010855ea test       eax, eax
010855ec jne        0x141086227
010855f2 xor        r14d, r14d
010855f5 mov        qword ptr [rsi + 0x1e00180], r14
010855fc jmp        0x141085601
010855fe xor        r14d, r14d
01085601 lea        rdx, [rsp + 0x60]
01085606 mov        rcx, rsi
01085609 call       0x141084190
0108560e mov        ebx, eax
01085610 test       eax, eax
01085612 jne        0x141086227
01085618 xor        edx, edx
0108561a lea        rcx, [rsp + 0x60]
0108561f call       0x140ba09a0
01085624 lea        rax, [rsp + 0x60]
01085629 mov        qword ptr [rsi + 0x120], rax
01085630 mov        byte ptr [rsi + 0x41], bl
01085633 mov        byte ptr [rsi + 0x43], bl
01085636 mov        qword ptr [rsi + 0x1e00160], 0xffffffffffffffff
01085641 mov        qword ptr [rsi + 0x1e00168], 0xffffffffffffffff
0108564c mov        qword ptr [rsi + 0x1e00180], r14
01085653 mov        qword ptr [rsi + 0x1e00170], r14
0108565a jmp        0x1410857de
0108565f cmp        dword ptr [rbp - 0x40], 0x62756666
01085666 jne        0x1410856e4
01085668 mov        byte ptr [rbp - 0x3c], 1
0108566c cmp        byte ptr [rbp - 0x3b], 0
01085670 jne        0x1410856be
01085672 mov        rax, qword ptr [rbp - 0x20]
01085676 mov        rcx, qword ptr [rbp - 0x10]
0108567a sub        rax, rcx
0108567d je         0x1410856ac
0108567f mov        qword ptr [rsp + 0x40], rax
01085684 xor        r9d, r9d
01085687 mov        r8, rcx
0108568a lea        rdx, [rsp + 0x40]
0108568f mov        rcx, qword ptr [rbp - 0x38]
01085693 call       0x140bd62d0
01085698 mov        rcx, qword ptr [rbp - 0x10]
0108569c cmp        byte ptr [rbp - 0x3b], 0
010856a0 je         0x1410856ac
010856a2 lea        rax, [rcx + 1]
010856a6 mov        qword ptr [rbp - 0x20], rax
010856aa jmp        0x1410856ba
010856ac mov        qword ptr [rbp - 0x20], rcx
010856b0 mov        rax, qword ptr [rbp - 0x28]
010856b4 dec        rax
010856b7 add        rcx, rax
010856ba mov        qword ptr [rbp - 8], rcx
010856be mov        rcx, qword ptr [rbp - 0x38]
010856c2 call       0x140bd5150
010856c7 mov        rcx, qword ptr [rbp - 0x30]
010856cb test       rcx, rcx
010856ce je         0x1410856d5
010856d0 call       0x140bd7440
010856d5 mov        rcx, qword ptr [rbp - 0x10]
010856d9 test       rcx, rcx
010856dc je         0x1410856e4
010856de call       qword ptr [rip + 0x866c84]
010856e4 mov        eax, r14d
010856e7 jmp        0x141086672
010856ec call       0x140bd4f30
010856f1 mov        ebx, eax
010856f3 test       eax, eax
010856f5 jne        0x141086662
010856fb xor        ecx, ecx
010856fd mov        r14d, 0xa00000
01085703 mov        ebx, ecx
01085705 mov        dword ptr [rsp + 0x60], 0x62756666
0108570d mov        word ptr [rsp + 0x65], 0x101
01085714 mov        rax, qword ptr [rsp + 0x40]
01085719 mov        qword ptr [rsp + 0x68], rax
0108571e mov        rdi, rsi
01085721 test       ebx, ebx
01085723 jne        0x1410865d3
01085729 mov        edx, 0x10
0108572e mov        rcx, r14
01085731 call       qword ptr [rip + 0x866c39]
01085737 mov        rcx, rax
0108573a test       rax, rax
0108573d jne        0x141085754
0108573f cmp        r14, 0x1000
01085746 jae        0x14108574f
01085748 mov        ebx, 0xffffff94
0108574d jmp        0x141085721
0108574f shr        r14, 1
01085752 jmp        0x141085721
01085754 mov        qword ptr [rbp - 0x70], rcx
01085758 mov        qword ptr [rsp + 0x78], r14
0108575d cmp        byte ptr [rsp + 0x65], 0
01085762 je         0x141085771
01085764 inc        rax
01085767 mov        qword ptr [rbp - 0x80], rax
0108576b mov        qword ptr [rbp - 0x68], rcx
0108576f jmp        0x141085780
01085771 mov        qword ptr [rbp - 0x80], rcx
01085775 lea        rax, [r14 - 1]
01085779 add        rax, rcx
0108577c mov        qword ptr [rbp - 0x68], rax
01085780 lea        rax, [rsp + 0x60]
01085785 mov        qword ptr [rsi + 0x120], rax
0108578c mov        edx, dword ptr [rsi + 4]
0108578f lea        rcx, [rsp + 0x60]
01085794 call       0x140ba09a0
01085799 mov        ecx, dword ptr [rsi + 4]
0108579c mov        qword ptr [rsi + 0x1e00170], rcx
010857a3 movzx      eax, byte ptr [rsi + 0x41]
010857a7 test       al, al
010857a9 je         0x1410857db
010857ab mov        qword ptr [rsi + 0x1e00160], rcx
010857b2 cmp        al, 2
010857b4 jne        0x1410857c3
010857b6 mov        eax, dword ptr [rsi + 0x5c]
010857b9 add        rax, rcx
010857bc mov        qword ptr [rsi + 0x1e00168], rax
010857c3 lea        rcx, [rsi + 0x1e00128]
010857ca xor        edx, edx
010857cc call       0x14106a3a0
010857d1 mov        ebx, eax
010857d3 test       eax, eax
010857d5 jne        0x141086227
010857db xor        r14d, r14d
010857de cmp        dword ptr [r15 + 0x80], 0x74646174
010857e9 jne        0x141085816
010857eb cmp        byte ptr [r15 + 0x118], 4
010857f3 je         0x141085816
010857f5 mov        byte ptr [r15 + 0x118], 4
010857fd mov        rax, qword ptr [r15]
01085800 mov        qword ptr [rsp + 0x20], r14
01085805 xor        r9d, r9d
01085808 mov        r8, r15
0108580b mov        edx, 0x74646c6f
01085810 mov        rcx, r15
01085813 call       qword ptr [rax + 8]
01085816 cmp        qword ptr [rdi + 0x1e00188], 0
0108581e je         0x141085859
01085820 mov        r9d, dword ptr [rdi + 0x54]
01085824 add        r9d, dword ptr [rdi + 0x4c]
01085828 add        r9d, dword ptr [rdi + 0x48]
0108582c add        r9d, dword ptr [rdi + 0x44]
01085830 je         0x141085859
01085832 mov        qword ptr [rdi + 0x1e00198], r9
01085839 test       r12, r12
0108583c je         0x141085859
0108583e mov        rax, qword ptr [r12]
01085842 test       rax, rax
01085845 je         0x141085859
01085847 mov        qword ptr [rsp + 0x20], r14
0108584c xor        r8d, r8d
0108584f mov        edx, 0x7570726d
01085854 mov        rcx, r12
01085857 call       rax
01085859 mov        rax, qword ptr [rdi + 0x34]
0108585d mov        qword ptr [r15 + 0x88], rax
01085864 test       rax, rax
01085867 jne        0x141085877
01085869 xor        ecx, ecx
0108586b call       0x140ba5880
01085870 mov        qword ptr [r15 + 0x88], rax
01085877 cmp        byte ptr [rdi + 0x42], 0
0108587b je         0x141085895
0108587d mov        rax, qword ptr [rip + 0x10216ac]
01085884 cmp        byte ptr [rax + 0x14157], 0
0108588b je         0x141085895
0108588d mov        word ptr [rax + 0x14090], r14w
01085895 mov        eax, dword ptr [rdi + 0x58]
01085898 test       eax, eax
0108589a je         0x1410858a3
0108589c mov        dword ptr [r15 + 0x94], eax
010858a3 lea        rdx, [rip + 0x88d356]
010858aa mov        ecx, 0x18
010858af call       0x14179beec
010858b4 mov        qword ptr [rbp - 0x50], rax
010858b8 test       rax, rax
010858bb je         0x1410858d2
010858bd mov        qword ptr [rax], r14
010858c0 mov        qword ptr [rax + 8], 0
010858c8 mov        qword ptr [rax + 0x10], 0
010858d0 jmp        0x1410858d5
010858d2 mov        rax, r14
010858d5 mov        qword ptr [r15 + 0x1918], rax
010858dc lea        rdx, [rip + 0x88d31d]
010858e3 mov        ecx, 0x18
010858e8 call       0x14179beec
010858ed mov        qword ptr [rbp - 0x50], rax
010858f1 test       rax, rax
010858f4 je         0x14108590b
010858f6 mov        qword ptr [rax], r14
010858f9 mov        qword ptr [rax + 8], 0
01085901 mov        qword ptr [rax + 0x10], 0
01085909 jmp        0x14108590e
0108590b mov        rax, r14
0108590e mov        qword ptr [r15 + 0x1920], rax
01085915 mov        dword ptr [rsp + 0x50], r14d
0108591a cmp        dword ptr [rdi + 0x30], 0
0108591e jbe        0x1410861e3
01085924 lea        rax, [rdi + 0x1e00270]
0108592b mov        qword ptr [rsp + 0x48], rax
01085930 lea        rax, [rdi + 0x1e00170]
01085937 mov        qword ptr [rsp + 0x38], rax
0108593c lea        rax, [rdi + 0x30]
01085940 mov        qword ptr [rbp - 0x50], rax
01085944 nop        dword ptr [rax]
01085948 nop        dword ptr [rax + rax]
01085950 mov        r12, r13
01085953 mov        qword ptr [rsp + 0x58], rsi
01085958 mov        r8d, 8
0108595e lea        rdx, [rbp + 0x50]
01085962 mov        rcx, rdi
01085965 call       0x1410770a0
0108596a mov        ebx, eax
0108596c test       eax, eax
0108596e jne        0x1410861d4
01085974 mov        r10d, dword ptr [rbp + 0x54]
01085978 mov        esi, r10d
0108597b cmp        byte ptr [r13 + 0x52], al
0108597f jne        0x141085983
01085981 bswap      esi
01085983 lea        rcx, [rbp + 0x58]
01085987 mov        r13d, 0x60
0108598d cmp        esi, r13d
01085990 cmovb      r13d, esi
01085994 cmp        r13d, 8
01085998 jbe        0x1410859cf
0108599a lea        r14d, [r13 - 8]
0108599e cmp        r14, 0xa00000
010859a5 ja         0x1410861cf
010859ab mov        r8d, r14d
010859ae lea        rdx, [rbp + 0x58]
010859b2 mov        rcx, rdi
010859b5 call       0x1410770a0
010859ba mov        ebx, eax
010859bc test       eax, eax
010859be jne        0x1410861d4
010859c4 lea        rcx, [rbp + 0x58]
010859c8 add        rcx, r14
010859cb mov        r10d, dword ptr [rbp + 0x54]
010859cf cmp        r13d, 0x60
010859d3 jae        0x1410859ee
010859d5 test       rcx, rcx
010859d8 je         0x1410859ee
010859da mov        r8d, 0x60
010859e0 sub        r8d, r13d
010859e3 xor        edx, edx
010859e5 call       0x14179cca0
010859ea mov        r10d, dword ptr [rbp + 0x54]
010859ee mov        r11, qword ptr [rsp + 0x30]
010859f3 mov        qword ptr [rsp + 0x40], r11
010859f8 mov        r14, rdi
010859fb cmp        esi, r13d
010859fe jbe        0x141085a17
01085a00 sub        esi, r13d
01085a03 mov        edx, esi
01085a05 mov        rcx, rdi
01085a08 call       0x14106a520
01085a0d mov        ebx, eax
01085a0f test       eax, eax
01085a11 jne        0x14108621a
01085a17 mov        r9, qword ptr [rsp + 0x58]
01085a1c mov        rsi, r9
01085a1f mov        r13, r12
01085a22 mov        qword ptr [rsp + 0x58], r12
01085a27 cmp        byte ptr [r12 + 0x52], 0
01085a2d jne        0x141085af8
01085a33 mov        ecx, dword ptr [rbp + 0x50]
01085a36 mov        edx, ecx
01085a38 and        edx, 0xff0000
01085a3e mov        eax, ecx
01085a40 shr        eax, 0x10
01085a43 or         edx, eax
01085a45 shr        edx, 8
01085a48 mov        eax, ecx
01085a4a shl        eax, 0x10
01085a4d and        ecx, 0xff00
01085a53 or         eax, ecx
01085a55 shl        eax, 8
01085a58 or         edx, eax
01085a5a mov        dword ptr [rbp + 0x50], edx
01085a5d mov        ecx, r10d
01085a60 and        ecx, 0xff0000
01085a66 mov        eax, r10d
01085a69 shr        eax, 0x10
01085a6c or         ecx, eax
01085a6e shr        ecx, 8
01085a71 mov        eax, r10d
01085a74 shl        eax, 0x10
01085a77 and        r10d, 0xff00
01085a7e or         eax, r10d
01085a81 shl        eax, 8
01085a84 mov        r10d, ecx
01085a87 or         r10d, eax
01085a8a mov        dword ptr [rbp + 0x54], r10d
01085a8e mov        ecx, dword ptr [rbp + 0x58]
01085a91 mov        r12d, ecx
01085a94 and        r12d, 0xff0000
01085a9b mov        eax, ecx
01085a9d shr        eax, 0x10
01085aa0 or         r12d, eax
01085aa3 shr        r12d, 8
01085aa7 mov        eax, ecx
01085aa9 shl        eax, 0x10
01085aac and        ecx, 0xff00
01085ab2 or         eax, ecx
01085ab4 shl        eax, 8
01085ab7 or         r12d, eax
01085aba mov        dword ptr [rbp + 0x58], r12d
01085abe mov        ecx, dword ptr [rbp + 0x5c]
01085ac1 mov        r8d, ecx
01085ac4 and        r8d, 0xff0000
01085acb mov        eax, ecx
01085acd shr        eax, 0x10
01085ad0 or         r8d, eax
01085ad3 shr        r8d, 8
01085ad7 mov        eax, ecx
01085ad9 shl        eax, 0x10
01085adc and        ecx, 0xff00
01085ae2 or         eax, ecx
01085ae4 shl        eax, 8
01085ae7 or         r8d, eax
01085aea mov        dword ptr [rbp + 0x5c], r8d
01085aee mov        rdi, r13
01085af1 mov        qword ptr [rsp + 0x58], r13
01085af6 jmp        0x141085b06
01085af8 mov        r8d, dword ptr [rbp + 0x5c]
01085afc mov        r12d, dword ptr [rbp + 0x58]
01085b00 mov        edx, dword ptr [rbp + 0x50]
01085b03 mov        rdi, r13
01085b06 cmp        edx, 0x6864736d
01085b0c jne        0x141086212
01085b12 sub        r12d, r10d
01085b15 lea        eax, [r8 - 1]
01085b19 cmp        eax, 0x16
01085b1c ja         0x141086167
01085b22 lea        rdx, [rip - 0x1085b29]
01085b29 mov        ecx, dword ptr [rdx + rax*4 + 0x1086698]
01085b30 add        rcx, rdx
01085b33 jmp        rcx
01085b35 test       dword ptr [rbp + 0x760], 0x4000
01085b3f jne        0x141085b4e
01085b41 mov        rcx, r14
01085b44 call       0x141078140
01085b49 jmp        0x14108614c
01085b4e movsxd     rdx, r12d
01085b51 mov        rdi, qword ptr [rsp + 0x38]
01085b56 add        rdx, qword ptr [rdi]
01085b59 mov        qword ptr [rdi], rdx
01085b5c mov        rcx, qword ptr [r14 + 0x1e00178]
01085b63 cmp        rdx, rcx
01085b66 jb         0x141085b74
01085b68 add        rcx, qword ptr [r14 + 0x1e00180]
01085b6f cmp        rdx, rcx
01085b72 jb         0x141085b82
01085b74 xor        eax, eax
01085b76 mov        qword ptr [r14 + 0x1e00180], rax
01085b7d jmp        0x14108614c
01085b82 xor        eax, eax
01085b84 jmp        0x14108614c
01085b89 test       dword ptr [rbp + 0x760], 0x2000
01085b93 jne        0x141085b4e
01085b95 mov        rcx, r14
01085b98 call       0x141078bb0
01085b9d jmp        0x14108614c
01085ba2 movzx      edi, byte ptr [r15 + 0x110]
01085baa movzx      eax, dil
01085bae or         al, 2
01085bb0 mov        byte ptr [r15 + 0x110], al
01085bb7 mov        edx, r8d
01085bba mov        rcx, r14
01085bbd call       0x14107b460
01085bc2 mov        ebx, eax
01085bc4 movzx      eax, byte ptr [r15 + 0x110]
01085bcc xor        dil, al
01085bcf and        dil, 2
01085bd3 xor        dil, al
01085bd6 mov        byte ptr [r15 + 0x110], dil
01085bdd jmp        0x14108614e
01085be2 mov        eax, dword ptr [rbp + 0x760]
01085be8 bt         eax, 0xa
01085bec jb         0x141085b4e
01085bf2 mov        edx, eax
01085bf4 mov        rcx, r14
01085bf7 call       0x14107ee90
01085bfc jmp        0x14108614c
01085c01 mov        rax, qword ptr [rsp + 0x48]
01085c06 mov        rax, qword ptr [rax]
01085c09 test       byte ptr [rax + 0x110], 1
01085c10 je         0x141085c97
01085c16 xor        eax, eax
01085c18 mov        r13d, eax
01085c1b test       r12d, r12d
01085c1e je         0x141085c73
01085c20 mov        ebx, r12d
01085c23 mov        edx, 0x10
01085c28 mov        ecx, r12d
01085c2b call       qword ptr [rip + 0x86673f]
01085c31 mov        r13, rax
01085c34 test       rax, rax
01085c37 jne        0x141085c43
01085c39 mov        ebx, 0xffffff94
01085c3e jmp        0x14108614e
01085c43 cmp        rbx, 0xa00000
01085c4a jbe        0x141085c5f
01085c4c mov        ebx, 0xffffff30
01085c51 mov        rcx, r13
01085c54 call       qword ptr [rip + 0x86670e]
01085c5a jmp        0x14108614e
01085c5f mov        r8, rbx
01085c62 mov        rdx, rax
01085c65 mov        rcx, r14
01085c68 call       0x1410770a0
01085c6d mov        ebx, eax
01085c6f test       eax, eax
01085c71 jne        0x141085c89
01085c73 mov        r8d, r12d
01085c76 mov        rdx, r13
01085c79 call       0x141082110
01085c7e mov        ebx, eax
01085c80 test       r13, r13
01085c83 je         0x14108614e
01085c89 mov        rcx, r13
01085c8c call       qword ptr [rip + 0x8666d6]
01085c92 jmp        0x14108614e
01085c97 movsxd     rdx, r12d
01085c9a mov        r8, qword ptr [rsp + 0x38]
01085c9f add        rdx, qword ptr [r8]
01085ca2 mov        qword ptr [r8], rdx
01085ca5 jmp        0x141085b5c
01085caa test       dword ptr [rbp + 0x760], 0x1000
01085cb4 jne        0x141085b4e
01085cba mov        rcx, r14
01085cbd call       0x141082f60
01085cc2 jmp        0x14108614c
01085cc7 mov        rcx, r14
01085cca call       0x141083c60
01085ccf jmp        0x14108614c
01085cd4 mov        rax, qword ptr [rsp + 0x48]
01085cd9 mov        rax, qword ptr [rax]
01085cdc test       byte ptr [rax + 0x110], 1
01085ce3 je         0x141085c97
01085ce5 xor        eax, eax
01085ce7 mov        r13d, eax
01085cea test       r12d, r12d
01085ced je         0x141085d42
01085cef mov        ebx, r12d
01085cf2 mov        edx, 0x10
01085cf7 mov        ecx, r12d
01085cfa call       qword ptr [rip + 0x866670]
01085d00 mov        r13, rax
01085d03 test       rax, rax
01085d06 jne        0x141085d12
01085d08 mov        ebx, 0xffffff94
01085d0d jmp        0x14108614e
01085d12 cmp        rbx, 0xa00000
01085d19 jbe        0x141085d2e
01085d1b mov        ebx, 0xffffff30
01085d20 mov        rcx, r13
01085d23 call       qword ptr [rip + 0x86663f]
01085d29 jmp        0x14108614e
01085d2e mov        r8, rbx
01085d31 mov        rdx, rax
01085d34 mov        rcx, r14
01085d37 call       0x1410770a0
01085d3c mov        ebx, eax
01085d3e test       eax, eax
01085d40 jne        0x141085d58
01085d42 mov        r8d, r12d
01085d45 mov        rdx, r13
01085d48 call       0x1410823f0
01085d4d mov        ebx, eax
01085d4f test       r13, r13
01085d52 je         0x14108614e
01085d58 mov        rcx, r13
01085d5b call       qword ptr [rip + 0x866607]
01085d61 jmp        0x14108614e
01085d66 xor        r9d, r9d
01085d69 mov        ebx, r9d
01085d6c mov        r13d, r9d
01085d6f mov        rax, qword ptr [rsp + 0x48]
01085d74 mov        rax, qword ptr [rax]
01085d77 test       byte ptr [rax + 0x110], 1
01085d7e je         0x141085e0b
01085d84 test       r12d, r12d
01085d87 je         0x141085dec
01085d89 xor        edx, edx
01085d8b mov        rcx, qword ptr [rip + 0x10202fe]
01085d92 call       qword ptr [rip + 0x8634a8]
01085d98 mov        r13, rax
01085d9b test       rax, rax
01085d9e je         0x14108614e
01085da4 mov        ebx, r12d
01085da7 mov        edx, r12d
01085daa mov        rcx, rax
01085dad call       qword ptr [rip + 0x8634ad]
01085db3 mov        rcx, r13
01085db6 call       qword ptr [rip + 0x863494]
01085dbc cmp        r12d, 0xa00000
01085dc3 jbe        0x141085dd8
01085dc5 mov        ebx, 0xffffff30
01085dca mov        rcx, r13
01085dcd call       qword ptr [rip + 0x86304d]
01085dd3 jmp        0x14108614e
01085dd8 mov        r8, rbx
01085ddb mov        rdx, rax
01085dde mov        rcx, r14
01085de1 call       0x1410770a0
01085de6 mov        ebx, eax
01085de8 test       eax, eax
01085dea jne        0x141085dfd
01085dec mov        rcx, r13
01085def call       0x1407f6ec0
01085df4 test       r13, r13
01085df7 je         0x14108614e
01085dfd mov        rcx, r13
01085e00 call       qword ptr [rip + 0x86301a]
01085e06 jmp        0x14108614e
01085e0b movsxd     rdx, r12d
01085e0e mov        r8, qword ptr [rsp + 0x38]
01085e13 add        rdx, qword ptr [r8]
01085e16 mov        qword ptr [r8], rdx
01085e19 mov        rcx, qword ptr [r14 + 0x1e00178]
01085e20 cmp        rdx, rcx
01085e23 jb         0x141085e35
01085e25 add        rcx, qword ptr [r14 + 0x1e00180]
01085e2c cmp        rdx, rcx
01085e2f jb         0x14108614e
01085e35 mov        qword ptr [r14 + 0x1e00180], r9
01085e3c jmp        0x14108614e
01085e41 cmp        byte ptr [r14 + 0x1e002f0], 0
01085e49 je         0x141085e8e
01085e4b movsxd     rdx, r12d
01085e4e mov        r13, qword ptr [rsp + 0x38]
01085e53 add        rdx, qword ptr [r13]
01085e57 mov        qword ptr [r13], rdx
01085e5b mov        rcx, qword ptr [r14 + 0x1e00178]
01085e62 cmp        rdx, rcx
01085e65 jb         0x141085e73
01085e67 add        rcx, qword ptr [r14 + 0x1e00180]
01085e6e cmp        rdx, rcx
01085e71 jb         0x141085e84
01085e73 xor        eax, eax
01085e75 mov        qword ptr [r14 + 0x1e00180], rax
01085e7c mov        rcx, r14
01085e7f jmp        0x14108619f
01085e84 xor        eax, eax
01085e86 mov        rcx, r14
01085e89 jmp        0x14108619f
01085e8e xor        eax, eax
01085e90 mov        ebx, eax
01085e92 test       r12d, r12d
01085e95 je         0x14108614e
01085e9b mov        edi, r12d
01085e9e mov        edx, 0x10
01085ea3 mov        ecx, r12d
01085ea6 call       qword ptr [rip + 0x8664c4]
01085eac mov        r12, rax
01085eaf test       rax, rax
01085eb2 jne        0x141085ebe
01085eb4 mov        ebx, 0xffffff94
01085eb9 jmp        0x14108614e
01085ebe cmp        rdi, 0xa00000
01085ec5 jbe        0x141085eda
01085ec7 mov        ebx, 0xffffff30
01085ecc mov        rcx, r12
01085ecf call       qword ptr [rip + 0x866493]
01085ed5 jmp        0x14108614e
01085eda mov        r8, rdi
01085edd mov        rdx, r12
01085ee0 mov        rcx, r14
01085ee3 call       0x1410770a0
01085ee8 mov        ebx, eax
01085eea test       eax, eax
01085eec jne        0x141085f03
01085eee mov        r8, rdi
01085ef1 mov        rdx, r12
01085ef4 mov        rax, qword ptr [rsp + 0x48]
01085ef9 mov        rcx, qword ptr [rax]
01085efc call       0x1410824c0
01085f01 mov        ebx, eax
01085f03 mov        rcx, r12
01085f06 call       qword ptr [rip + 0x86645c]
01085f0c jmp        0x14108614e
01085f11 mov        rax, qword ptr [rsp + 0x48]
01085f16 mov        rax, qword ptr [rax]
01085f19 test       byte ptr [rax + 0x110], 1
01085f20 jne        0x141085f2d
01085f22 cmp        qword ptr [rbp + 0x10], 0
01085f27 je         0x141085e4b
01085f2d lea        rcx, [rbp + 0xb0]
01085f34 call       0x1405ab560
01085f39 nop        
01085f3a lea        rdx, [rbp + 0xb0]
01085f41 mov        rax, qword ptr [rbp + 0x10]
01085f45 test       rax, rax
01085f48 cmovne     rdx, rax
01085f4c mov        rcx, r14
01085f4f call       0x14107abe0
01085f54 mov        ebx, eax
01085f56 lea        rcx, [rbp + 0x188]
01085f5d call       0x1405b4f30
01085f62 mov        rcx, qword ptr [rbp + 0x642]
01085f69 test       rcx, rcx
01085f6c je         0x141085f74
01085f6e call       qword ptr [rip + 0x862eac]
01085f74 lea        rcx, [rbp + 0x176]
01085f7b call       0x140ad69e0
01085f80 lea        rcx, [rbp + 0x166]
01085f87 call       0x140ad69e0
01085f8c lea        rcx, [rbp + 0x154]
01085f93 call       0x140ad69e0
01085f98 lea        rcx, [rbp + 0x13a]
01085f9f call       0x140ad69e0
01085fa4 lea        rcx, [rbp + 0x12a]
01085fab call       0x140ad69e0
01085fb0 lea        rcx, [rbp + 0xf2]
01085fb7 call       0x140ad69e0
01085fbc lea        rcx, [rbp + 0xd4]
01085fc3 call       0x140ad69e0
01085fc8 lea        rcx, [rbp + 0xc4]
01085fcf call       0x140ad69e0
01085fd4 jmp        0x14108614e
01085fd9 mov        rcx, r14
01085fdc call       0x141082570
01085fe1 jmp        0x14108614c
01085fe6 mov        r8d, 0x90
01085fec lea        rdx, [r14 + 0x90]
01085ff3 mov        rcx, r14
01085ff6 call       0x141077270
01085ffb mov        ebx, eax
01085ffd test       eax, eax
01085fff jne        0x14108614e
01086005 cmp        byte ptr [rdi + 0x52], al
01086008 jne        0x141086016
0108600a lea        rcx, [r14 + 0x90]
01086011 call       0x141068f90
01086016 cmp        dword ptr [r14 + 0x90], 0x6864666d
01086021 mov        eax, 0xffffff30
01086026 cmovne     ebx, eax
01086029 mov        rcx, qword ptr [r13 + 0xc4]
01086030 test       rcx, rcx
01086033 je         0x14108614e
01086039 mov        rax, qword ptr [rsp + 0x48]
0108603e mov        rax, qword ptr [rax]
01086041 mov        qword ptr [rax + 0x88], rcx
01086048 jmp        0x14108614e
0108604d mov        rcx, r14
01086050 call       0x141082ac0
01086055 jmp        0x14108614c
0108605a mov        rax, qword ptr [rip + 0x1020ecf]
01086061 test       rax, rax
01086064 je         0x141085c97
0108606a mov        rcx, qword ptr [rax + 0xf4fc]
01086071 test       rcx, rcx
01086074 je         0x141085c97
0108607a cmp        qword ptr [r13 + 0x68], rcx
0108607e jne        0x141085c97
01086084 mov        rax, qword ptr [rsp + 0x48]
01086089 mov        r13, qword ptr [rax]
0108608c mov        edi, r12d
0108608f mov        edx, 0x10
01086094 mov        ecx, r12d
01086097 call       qword ptr [rip + 0x8662d3]
0108609d mov        r12, rax
010860a0 test       rax, rax
010860a3 jne        0x1410860af
010860a5 mov        ebx, 0xffffff94
010860aa jmp        0x14108614e
010860af cmp        rdi, 0xa00000
010860b6 jbe        0x1410860cb
010860b8 mov        ebx, 0xffffff30
010860bd mov        rcx, r12
010860c0 call       qword ptr [rip + 0x8662a2]
010860c6 jmp        0x14108614e
010860cb mov        r8, rdi
010860ce mov        rdx, r12
010860d1 mov        rcx, r14
010860d4 call       0x1410770a0
010860d9 mov        ebx, eax
010860db test       eax, eax
010860dd jne        0x141086139
010860df mov        rcx, qword ptr [r13 + 0x20d8]
010860e6 test       rcx, rcx
010860e9 je         0x1410860f1
010860eb call       qword ptr [rip + 0x862d2f]
010860f1 xor        eax, eax
010860f3 mov        qword ptr [r13 + 0x20d8], rax
010860fa mov        r8, rdi
010860fd mov        rdx, r12
01086100 mov        rcx, qword ptr [rip + 0x101ff89]
01086107 call       qword ptr [rip + 0x86312b]
0108610d mov        qword ptr [r13 + 0x20d8], rax
01086114 test       rax, rax
01086117 jne        0x141086129
01086119 mov        ebx, 0xffffffce
0108611e mov        rcx, r12
01086121 call       qword ptr [rip + 0x866241]
01086127 jmp        0x14108614e
01086129 mov        rax, qword ptr [rsp + 0x58]
0108612e mov        rax, qword ptr [rax + 0x68]
01086132 mov        qword ptr [r13 + 0x20e0], rax
01086139 mov        rcx, r12
0108613c call       qword ptr [rip + 0x866226]
01086142 jmp        0x14108614e
01086144 mov        rcx, r14
01086147 call       0x141081a70
0108614c mov        ebx, eax
0108614e mov        rcx, r14
01086151 call       0x141077340
01086156 test       ebx, ebx
01086158 je         0x1410861a6
0108615a mov        rdi, r14
0108615d mov        r13, qword ptr [rsp + 0x40]
01086162 jmp        0x14108622a
01086167 movsxd     rdx, r12d
0108616a mov        r13, qword ptr [rsp + 0x38]
0108616f add        rdx, qword ptr [r13]
01086173 mov        qword ptr [r13], rdx
01086177 mov        rcx, qword ptr [r14 + 0x1e00178]
0108617e cmp        rdx, rcx
01086181 jb         0x14108618f
01086183 add        rcx, qword ptr [r14 + 0x1e00180]
0108618a cmp        rdx, rcx
0108618d jb         0x14108619a
0108618f xor        eax, eax
01086191 mov        qword ptr [r14 + 0x1e00180], rax
01086198 jmp        0x14108619c
0108619a xor        eax, eax
0108619c mov        rcx, rsi
0108619f mov        ebx, eax
010861a1 call       0x141077340
010861a6 mov        ecx, dword ptr [rsp + 0x50]
010861aa inc        ecx
010861ac mov        dword ptr [rsp + 0x50], ecx
010861b0 mov        rdi, r14
010861b3 mov        rax, qword ptr [rsp + 0x40]
010861b8 mov        qword ptr [rsp + 0x30], rax
010861bd mov        rdx, qword ptr [rbp - 0x50]
010861c1 cmp        ecx, dword ptr [rdx]
010861c3 jae        0x1410861db
010861c5 mov        r13, qword ptr [rsp + 0x58]
010861ca jmp        0x141085950
010861cf mov        ebx, 0xffffff30
010861d4 mov        r13, qword ptr [rsp + 0x30]
010861d9 jmp        0x14108622a
010861db mov        rdi, r14
010861de mov        qword ptr [rsp + 0x30], rax
010861e3 lea        rcx, [rdi + 0x1e00128]
010861ea xor        r8d, r8d
010861ed xor        edx, edx
010861ef call       0x140bfc0d0
010861f4 mov        rcx, r15
010861f7 call       0x140ed3a30
010861fc movzx      edx, byte ptr [rdi + 0x1e002f1]
01086203 mov        rcx, r15
01086206 call       0x140ecf8f0
0108620b mov        r13, qword ptr [rsp + 0x30]
01086210 jmp        0x14108622a
01086212 mov        ebx, 0xffffff30
01086217 mov        rdi, r14
0108621a mov        r13, r11
0108621d jmp        0x14108622a
0108621f mov        ebx, 0xfffffc94
01086224 mov        rdi, rsi
01086227 mov        r13, rsi
0108622a cmp        dword ptr [rsp + 0x60], 0x62756666
01086232 jne        0x14108623e
01086234 lea        rcx, [rsp + 0x60]
01086239 call       0x140ba02c0
0108623e cmp        dword ptr [rbp - 0x40], 0x62756666
01086245 jne        0x141086250
01086247 lea        rcx, [rbp - 0x40]
0108624b call       0x140ba02c0
01086250 lea        rcx, [r15 + 0x178]
01086257 call       0x140bfe110
0108625c lea        rcx, [r15 + 0x208]
01086263 call       0x140bfe110
01086268 lea        rcx, [r15 + 0x1c0]
0108626f call       0x140bfe110
01086274 lea        rcx, [r15 + 0x250]
0108627b call       0x140bfe110
01086280 lea        rcx, [r15 + 0x328]
01086287 call       0x140bfe110
0108628c lea        rcx, [r15 + 0x370]
01086293 call       0x140bfe110
01086298 lea        rcx, [r15 + 0x3b8]
0108629f call       0x140bfe110
010862a4 lea        rcx, [r15 + 0x400]
010862ab call       0x140bfe110
010862b0 lea        rcx, [r15 + 0x880]
010862b7 call       0x140bfe110
010862bc lea        rcx, [r15 + 0x448]
010862c3 call       0x140bfe110
010862c8 lea        rcx, [r15 + 0x490]
010862cf call       0x140bfe110
010862d4 lea        rcx, [r15 + 0x4d8]
010862db call       0x140bfe110
010862e0 lea        rcx, [r15 + 0x520]
010862e7 call       0x140bfe110
010862ec lea        rcx, [r15 + 0x568]
010862f3 call       0x140bfe110
010862f8 lea        rcx, [r15 + 0x5b0]
010862ff call       0x140bfe110
01086304 lea        rcx, [r15 + 0x5f8]
0108630b call       0x140bfe110
01086310 lea        rcx, [r15 + 0x640]
01086317 call       0x140bfe110
0108631c lea        rcx, [r15 + 0x688]
01086323 call       0x140bfe110
01086328 lea        rcx, [r15 + 0x6d0]
0108632f call       0x140bfe110
01086334 lea        rcx, [r15 + 0x718]
0108633b call       0x140bfe110
01086340 lea        rcx, [r15 + 0x760]
01086347 call       0x140bfe110
0108634c lea        rcx, [r15 + 0x1768]
01086353 call       0x140bfe110
01086358 lea        rcx, [r15 + 0x17b0]
0108635f call       0x140bfe110
01086364 lea        rcx, [r15 + 0x17f8]
0108636b call       0x140bfe110
01086370 lea        rcx, [r15 + 0x1840]
01086377 call       0x140bfe110
0108637c lea        rcx, [r15 + 0x7a8]
01086383 call       0x140bfe110
01086388 lea        rcx, [r15 + 0x7f0]
0108638f call       0x140bfe110
01086394 lea        rcx, [r15 + 0x838]
0108639b call       0x140bfe110
010863a0 lea        rcx, [r15 + 0x8c8]
010863a7 call       0x140bfe110
010863ac lea        rcx, [r15 + 0x910]
010863b3 call       0x140bfe110
010863b8 lea        rcx, [r15 + 0x1888]
010863bf call       0x140bfe110
010863c4 lea        rcx, [r15 + 0x298]
010863cb call       0x140bfe110
010863d0 lea        rcx, [r15 + 0x2e0]
010863d7 call       0x140bfe110
010863dc lea        r14, [r15 + 0x960]
010863e3 mov        r12d, 0x32
010863e9 xor        r15d, r15d
010863ec nop        dword ptr [rax]
010863f0 lea        rax, [r14 - 8]
010863f4 test       rax, rax
010863f7 je         0x14108643f
010863f9 cmp        dword ptr [rax], 0x73747263
010863ff jne        0x14108643f
01086401 mov        rsi, qword ptr [r14]
01086404 test       rsi, rsi
01086407 je         0x14108643b
01086409 cmp        dword ptr [rsi + 8], 0x4d656d48
01086410 jne        0x141086438
01086412 mov        rcx, qword ptr [rsi]
01086415 test       rcx, rcx
01086418 je         0x141086423
0108641a call       qword ptr [rip + 0x865f48]
01086420 mov        qword ptr [rsi], r15
01086423 mov        dword ptr [rsi + 8], r15d
01086427 mov        qword ptr [rsi + 0x10], r15
0108642b mov        qword ptr [rsi + 0x18], r15
0108642f mov        rcx, rsi
01086432 call       qword ptr [rip + 0x865f30]
01086438 mov        qword ptr [r14], r15
0108643b mov        dword ptr [r14 + 0x20], r15d
0108643f add        r14, 0x48
01086443 sub        r12, 1
01086447 jne        0x1410863f0
01086449 mov        rcx, qword ptr [rbp + 0x28]
0108644d test       rcx, rcx
01086450 mov        r15, qword ptr [rbp + 0x30]
01086454 je         0x14108645d
01086456 movzx      eax, word ptr [r13 + 0xc]
0108645b mov        dword ptr [rcx], eax
0108645d mov        rcx, qword ptr [rbp + 0x38]
01086461 test       rcx, rcx
01086464 je         0x14108646d
01086466 movzx      eax, word ptr [r13 + 0xe]
0108646b mov        dword ptr [rcx], eax
0108646d mov        rcx, qword ptr [rbp + 0x40]
01086471 test       rcx, rcx
01086474 je         0x14108647c
01086476 mov        eax, dword ptr [r13 + 0x3c]
0108647a mov        dword ptr [rcx], eax
0108647c mov        rcx, qword ptr [rbp + 0x48]
01086480 test       rcx, rcx
01086483 je         0x14108648f
01086485 cmp        byte ptr [r13 + 0x40], 2
0108648a setne      al
0108648d mov        byte ptr [rcx], al
0108648f mov        eax, dword ptr [r15 + 0x80]
01086496 test       ebx, ebx
01086498 jne        0x1410865a0
0108649e cmp        eax, 0x74646174
010864a3 jne        0x1410864d2
010864a5 cmp        byte ptr [r15 + 0x118], 6
010864ad je         0x1410864d2
010864af mov        byte ptr [r15 + 0x118], 6
010864b7 mov        rax, qword ptr [r15]
010864ba xor        ecx, ecx
010864bc mov        qword ptr [rsp + 0x20], rcx
010864c1 xor        r9d, r9d
010864c4 mov        r8, r15
010864c7 mov        edx, 0x74646c64
010864cc mov        rcx, r15
010864cf call       qword ptr [rax + 8]
010864d2 mov        rax, qword ptr [rbp + 0x10]
010864d6 test       rax, rax
010864d9 je         0x1410864e9
010864db xor        r8d, r8d
010864de mov        rdx, rax
010864e1 mov        rcx, rdi
010864e4 call       0x14107a150
010864e9 cmp        dword ptr [r15 + 0x84], 0x2062696c
010864f4 jne        0x1410864fe
010864f6 mov        rcx, rdi
010864f9 call       0x141084d50
010864fe xor        r14d, r14d
01086501 mov        rsi, qword ptr [rdi + 0x1e002f8]
01086508 test       rsi, rsi
0108650b je         0x141086529
0108650d mov        rcx, rsi
01086510 call       0x141068f00
01086515 mov        edx, 0x30
0108651a mov        rcx, rsi
0108651d call       0x140bc6a20
01086522 mov        qword ptr [rdi + 0x1e002f8], r14
01086529 mov        rsi, qword ptr [rdi + 0x1e00300]
01086530 test       rsi, rsi
01086533 je         0x141086566
01086535 mov        rcx, qword ptr [rsi + 8]
01086539 test       rcx, rcx
0108653c je         0x141086544
0108653e call       qword ptr [rip + 0x8628dc]
01086544 mov        rcx, qword ptr [rsi]
01086547 test       rcx, rcx
0108654a je         0x141086552
0108654c call       qword ptr [rip + 0x8628ce]
01086552 mov        edx, 0x10
01086557 mov        rcx, rsi
0108655a call       0x140bc6a20
0108655f mov        qword ptr [rdi + 0x1e00300], r14
01086566 mov        rcx, rdi
01086569 call       0x141086700
0108656e mov        rcx, qword ptr [rbp + 0x18]
01086572 test       rcx, rcx
01086575 je         0x141086662
0108657b mov        rax, qword ptr [rcx]
0108657e test       rax, rax
01086581 je         0x141086662
01086587 mov        qword ptr [rsp + 0x20], r14
0108658c xor        r9d, r9d
0108658f xor        r8d, r8d
01086592 mov        edx, 0x6470726d
01086597 call       rax
01086599 mov        eax, ebx
0108659b jmp        0x141086672
010865a0 xor        r14d, r14d
010865a3 cmp        eax, 0x74646174
010865a8 jne        0x141086501
010865ae mov        byte ptr [r15 + 0x118], r14b
010865b5 movsxd     r9, ebx
010865b8 mov        rax, qword ptr [r15]
010865bb mov        qword ptr [rsp + 0x20], r14
010865c0 mov        r8, r15
010865c3 mov        edx, 0x74646c66
010865c8 mov        rcx, r15
010865cb call       qword ptr [rax + 8]
010865ce jmp        0x141086501
010865d3 cmp        dword ptr [rsp + 0x60], 0x62756666
010865db jne        0x141086662
010865e1 mov        byte ptr [rsp + 0x64], 1
010865e6 cmp        byte ptr [rsp + 0x65], 0
010865eb jne        0x14108663a
010865ed mov        rax, qword ptr [rbp - 0x80]
010865f1 mov        rcx, qword ptr [rbp - 0x70]
010865f5 sub        rax, rcx
010865f8 je         0x141086627
010865fa mov        qword ptr [rbp + 0x18], rax
010865fe xor        r9d, r9d
01086601 mov        r8, rcx
01086604 lea        rdx, [rbp + 0x18]
01086608 mov        rcx, qword ptr [rsp + 0x68]
0108660d call       0x140bd62d0
01086612 mov        rcx, qword ptr [rbp - 0x70]
01086616 cmp        byte ptr [rsp + 0x65], 0
0108661b je         0x141086627
0108661d lea        rax, [rcx + 1]
01086621 mov        qword ptr [rbp - 0x80], rax
01086625 jmp        0x141086636
01086627 mov        qword ptr [rbp - 0x80], rcx
0108662b mov        rax, qword ptr [rsp + 0x78]
01086630 dec        rax
01086633 add        rcx, rax
01086636 mov        qword ptr [rbp - 0x68], rcx
0108663a mov        rcx, qword ptr [rsp + 0x68]
0108663f call       0x140bd5150
01086644 mov        rcx, qword ptr [rsp + 0x70]
01086649 test       rcx, rcx
0108664c je         0x141086653
0108664e call       0x140bd7440
01086653 mov        rcx, qword ptr [rbp - 0x70]
01086657 test       rcx, rcx
0108665a je         0x141086662
0108665c call       qword ptr [rip + 0x865d06]
01086662 mov        eax, ebx
01086664 jmp        0x141086672
01086666 mov        eax, 0xffffff94
0108666b jmp        0x141086672
0108666d mov        eax, 0xffffffce
01086672 mov        rcx, qword ptr [rbp + 0x6c0]
01086679 xor        rcx, rsp
0108667c call       0x14179b8e0
01086681 add        rsp, 0x7d8
01086688 pop        r15
0108668a pop        r14
0108668c pop        r13
0108668e pop        r12
01086690 pop        rdi
01086691 pop        rsi
01086692 pop        rbx
01086693 pop        rbp
01086694 ret        
01086695 nop        dword ptr [rax]
01086698 movabs     byte ptr [0x101085be201085b], al
010866a1 pop        rsp
010866a2 or         byte ptr [rcx], al
010866a4 pop        r14
010866a6 or         byte ptr [rcx], al
