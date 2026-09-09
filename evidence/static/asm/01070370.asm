; Original iTunes.exe machine code; base=0x140000000; RVA=0x1070370; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1070370..0x107076a (exclusive)
01070370 push       rbp
01070372 push       rbx
01070373 push       rsi
01070374 push       rdi
01070375 push       r14
01070377 push       r15
01070379 lea        rbp, [rsp - 0x18]
0107037e sub        rsp, 0x118
01070385 mov        rax, qword ptr [rip + 0xf64cb4]
0107038c xor        rax, rsp
0107038f mov        qword ptr [rbp], rax
01070393 mov        rdi, rcx
01070396 mov        r15, r9
01070399 mov        rcx, rdx
0107039c mov        r14d, r8d
0107039f mov        rsi, rdx
010703a2 call       0x140ed2bb0
010703a7 mov        rbx, qword ptr [rdi + 0x120]
010703ae xorps      xmm0, xmm0
010703b1 movups     xmmword ptr [rbp - 0x60], xmm0
010703b5 mov        dword ptr [rbp - 0x60], 0x6864736d
010703bc movups     xmmword ptr [rbp - 0x50], xmm0
010703c0 mov        dword ptr [rbp - 0x5c], 0x60
010703c7 movups     xmmword ptr [rbp - 0x40], xmm0
010703cb mov        dword ptr [rbp - 0x54], r8d
010703cf movups     xmmword ptr [rbp - 0x30], xmm0
010703d3 mov        qword ptr [rsp + 0x20], 0
010703dc movups     xmmword ptr [rbp - 0x20], xmm0
010703e0 movups     xmmword ptr [rbp - 0x10], xmm0
010703e4 cmp        byte ptr [rbx + 5], 0
010703e8 je         0x1410703f5
010703ea mov        rax, qword ptr [rbx + 0x40]
010703ee mov        qword ptr [rsp + 0x20], rax
010703f3 jmp        0x141070413
010703f5 mov        rcx, qword ptr [rbx + 8]
010703f9 lea        rdx, [rsp + 0x20]
010703fe call       0x140bd6640
01070403 mov        r8d, eax
01070406 test       eax, eax
01070408 jne        0x141070743
0107040e mov        rax, qword ptr [rsp + 0x20]
01070413 cmp        byte ptr [rbx + 5], 0
01070417 mov        rcx, qword ptr [rbx + 0x20]
0107041b je         0x141070426
0107041d sub        rcx, qword ptr [rbx + 0x38]
01070421 dec        rcx
01070424 jmp        0x14107042a
01070426 sub        rcx, qword ptr [rbx + 0x30]
0107042a add        rax, rcx
0107042d mov        qword ptr [rsp + 0x30], 0x60
01070436 mov        rcx, qword ptr [rdi + 0x120]
0107043d lea        r8, [rbp - 0x60]
01070441 lea        rdx, [rsp + 0x30]
01070446 mov        qword ptr [rsp + 0x20], rax
0107044b call       0x140ba04c0
01070450 mov        r8d, eax
01070453 test       eax, eax
01070455 jne        0x141070743
0107045b mov        rbx, qword ptr [rdi + 0x120]
01070462 xorps      xmm0, xmm0
01070465 xor        eax, eax
01070467 mov        dword ptr [rsp + 0x40], 0x68746c6d
0107046f movups     xmmword ptr [rsp + 0x48], xmm0
01070474 mov        dword ptr [rbp - 0x68], eax
01070477 movups     xmmword ptr [rsp + 0x58], xmm0
0107047c mov        dword ptr [rsp + 0x44], 0x5c
01070484 movups     xmmword ptr [rsp + 0x68], xmm0
01070489 mov        qword ptr [rsp + 0x28], rax
0107048e movups     xmmword ptr [rsp + 0x78], xmm0
01070493 movups     xmmword ptr [rbp - 0x78], xmm0
01070497 cmp        byte ptr [rbx + 5], al
0107049a je         0x1410704a7
0107049c mov        rcx, qword ptr [rbx + 0x40]
010704a0 mov        qword ptr [rsp + 0x28], rcx
010704a5 jmp        0x1410704c5
010704a7 mov        rcx, qword ptr [rbx + 8]
010704ab lea        rdx, [rsp + 0x28]
010704b0 call       0x140bd6640
010704b5 mov        r8d, eax
010704b8 test       eax, eax
010704ba jne        0x141070743
010704c0 mov        rcx, qword ptr [rsp + 0x28]
010704c5 cmp        byte ptr [rbx + 5], 0
010704c9 mov        rax, qword ptr [rbx + 0x20]
010704cd je         0x1410704d8
010704cf sub        rax, qword ptr [rbx + 0x38]
010704d3 dec        rax
010704d6 jmp        0x1410704dc
010704d8 sub        rax, qword ptr [rbx + 0x30]
010704dc add        rax, rcx
010704df mov        qword ptr [rsp + 0x30], 0x5c
010704e8 mov        rcx, qword ptr [rdi + 0x120]
010704ef lea        r8, [rsp + 0x40]
010704f4 lea        rdx, [rsp + 0x30]
010704f9 mov        qword ptr [rsp + 0x28], rax
010704fe call       0x140ba04c0
01070503 mov        r8d, eax
01070506 test       eax, eax
01070508 jne        0x141070743
0107050e test       rsi, rsi
01070511 je         0x1410705b0
01070517 cmp        dword ptr [rsi + 0x80], 0x74646174
01070521 jne        0x1410705b0
01070527 mov        rbx, qword ptr [rsi + 0xc8]
0107052e test       rbx, rbx
01070531 je         0x1410705b0
01070533 mov        rbx, qword ptr [rbx + 0x58]
01070537 test       rbx, rbx
0107053a je         0x1410705b0
0107053c nop        dword ptr [rax]
01070540 mov        edx, r14d
01070543 mov        rcx, rbx
01070546 call       0x14106b450
0107054b test       al, al
0107054d je         0x141070569
0107054f mov        rdx, rbx
01070552 mov        rcx, rdi
01070555 call       0x14106daf0
0107055a mov        r8d, eax
0107055d test       eax, eax
0107055f jne        0x141070743
01070565 inc        dword ptr [rsp + 0x48]
01070569 mov        rcx, qword ptr [rbx + 8]
0107056d test       rcx, rcx
01070570 je         0x1410705b0
01070572 cmp        qword ptr [rcx + 0x10], 0
01070577 je         0x1410705b0
01070579 mov        rax, qword ptr [rbx]
0107057c mov        rbx, rax
0107057f test       rax, rax
01070582 jne        0x1410705ab
01070584 mov        rax, qword ptr [rcx + 0x18]
01070588 test       rax, rax
0107058b je         0x1410705ab
0107058d nop        dword ptr [rax]
01070590 mov        rbx, qword ptr [rax + 0x58]
01070594 test       rbx, rbx
01070597 jne        0x141070540
01070599 cmp        qword ptr [rax + 0x10], rbx
0107059d je         0x1410705ab
0107059f mov        rcx, qword ptr [rax + 0x18]
010705a3 mov        rax, rcx
010705a6 test       rcx, rcx
010705a9 jne        0x141070590
010705ab test       rbx, rbx
010705ae jne        0x141070540
010705b0 mov        eax, dword ptr [rsp + 0x48]
010705b4 lea        rdx, [rsp + 0x38]
010705b9 mov        dword ptr [r15], eax
010705bc mov        rcx, qword ptr [rdi + 0x120]
010705c3 call       0x140b9ff80
010705c8 mov        r8d, eax
010705cb test       eax, eax
010705cd jne        0x141070743
010705d3 mov        r8d, dword ptr [rsp + 0x38]
010705d8 mov        r10, qword ptr [rsp + 0x20]
010705dd sub        r8d, r10d
010705e0 mov        dword ptr [rbp - 0x58], r8d
010705e4 cmp        byte ptr [rdi + 0x52], al
010705e7 jne        0x141070675
010705ed mov        ecx, dword ptr [rbp - 0x60]
010705f0 mov        edx, ecx
010705f2 and        edx, 0xff0000
010705f8 mov        eax, ecx
010705fa shr        eax, 0x10
010705fd or         edx, eax
010705ff mov        eax, ecx
01070601 and        eax, 0xff00
01070606 shr        edx, 8
01070609 shl        ecx, 0x10
0107060c or         eax, ecx
0107060e mov        ecx, dword ptr [rbp - 0x5c]
01070611 shl        eax, 8
01070614 or         edx, eax
01070616 mov        eax, ecx
01070618 shr        eax, 0x10
0107061b bswap      r8d
0107061e mov        dword ptr [rbp - 0x60], edx
01070621 mov        edx, ecx
01070623 mov        dword ptr [rbp - 0x58], r8d
01070627 and        edx, 0xff0000
0107062d or         edx, eax
0107062f mov        eax, ecx
01070631 and        eax, 0xff00
01070636 shl        ecx, 0x10
01070639 or         eax, ecx
0107063b shr        edx, 8
0107063e mov        ecx, dword ptr [rbp - 0x54]
01070641 mov        r8d, ecx
01070644 shl        eax, 8
01070647 and        r8d, 0xff0000
0107064e or         edx, eax
01070650 mov        eax, ecx
01070652 shr        eax, 0x10
01070655 or         r8d, eax
01070658 mov        dword ptr [rbp - 0x5c], edx
0107065b mov        eax, ecx
0107065d shr        r8d, 8
01070661 and        eax, 0xff00
01070666 shl        ecx, 0x10
01070669 or         eax, ecx
0107066b shl        eax, 8
0107066e or         r8d, eax
01070671 mov        dword ptr [rbp - 0x54], r8d
01070675 mov        r9d, 0x60
0107067b lea        r8, [rbp - 0x60]
0107067f mov        rdx, r10
01070682 mov        rcx, rdi
01070685 call       0x14106aba0
0107068a mov        r8d, eax
0107068d test       eax, eax
0107068f jne        0x141070743
01070695 cmp        byte ptr [rdi + 0x52], al
01070698 jne        0x141070728
0107069e mov        ecx, dword ptr [rsp + 0x40]
010706a2 mov        edx, ecx
010706a4 and        edx, 0xff0000
010706aa mov        eax, ecx
010706ac shr        eax, 0x10
010706af or         edx, eax
010706b1 mov        eax, ecx
010706b3 shl        eax, 0x10
010706b6 and        ecx, 0xff00
010706bc or         eax, ecx
010706be shr        edx, 8
010706c1 mov        ecx, dword ptr [rsp + 0x44]
010706c5 shl        eax, 8
010706c8 or         edx, eax
010706ca mov        eax, ecx
010706cc shr        eax, 0x10
010706cf mov        dword ptr [rsp + 0x40], edx
010706d3 mov        edx, ecx
010706d5 and        edx, 0xff0000
010706db or         edx, eax
010706dd mov        eax, ecx
010706df shl        eax, 0x10
010706e2 and        ecx, 0xff00
010706e8 or         eax, ecx
010706ea shr        edx, 8
010706ed shl        eax, 8
010706f0 or         edx, eax
010706f2 mov        dword ptr [rsp + 0x44], edx
010706f6 mov        edx, dword ptr [rsp + 0x48]
010706fa mov        r8d, edx
010706fd and        r8d, 0xff0000
01070704 mov        eax, edx
01070706 shr        eax, 0x10
01070709 or         r8d, eax
0107070c mov        eax, edx
0107070e shl        eax, 0x10
01070711 and        edx, 0xff00
01070717 or         eax, edx
01070719 shr        r8d, 8
0107071d shl        eax, 8
01070720 or         r8d, eax
01070723 mov        dword ptr [rsp + 0x48], r8d
01070728 mov        rdx, qword ptr [rsp + 0x28]
0107072d lea        r8, [rsp + 0x40]
01070732 mov        r9d, 0x5c
01070738 mov        rcx, rdi
0107073b call       0x14106aba0
01070740 mov        r8d, eax
01070743 mov        rcx, rsi
01070746 call       0x140ed2fe0
0107074b mov        eax, r8d
0107074e mov        rcx, qword ptr [rbp]
01070752 xor        rcx, rsp
01070755 call       0x14179b8e0
0107075a add        rsp, 0x118
01070761 pop        r15
01070763 pop        r14
01070765 pop        rdi
01070766 pop        rsi
01070767 pop        rbx
01070768 pop        rbp
01070769 ret        
