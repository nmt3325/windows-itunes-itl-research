; Original iTunes.exe machine code; base=0x140000000; RVA=0x107b460; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x107b460..0x107b4c8 (exclusive)
0107b460 push       rbp
0107b462 push       rsi
0107b463 push       r14
0107b465 push       r15
0107b467 lea        rbp, [rsp - 0x698]
0107b46f sub        rsp, 0x798
0107b476 mov        rax, qword ptr [rip + 0xf59bc3]
0107b47d xor        rax, rsp
0107b480 mov        qword ptr [rbp + 0x5e0], rax
0107b487 mov        r15, qword ptr [rcx + 0x1e00270]
0107b48e xor        eax, eax
0107b490 mov        dword ptr [rsp + 0x48], edx
0107b494 mov        r8d, 8
0107b49a lea        rdx, [rbp + 0x380]
0107b4a1 mov        qword ptr [rsp + 0x38], r15
0107b4a6 mov        qword ptr [rbp], rax
0107b4aa mov        r14, rcx
0107b4ad mov        byte ptr [rsp + 0x30], 0
0107b4b2 call       0x1410770a0
0107b4b7 mov        esi, eax
0107b4b9 test       eax, eax
0107b4bb jne        0x14107e77e
0107b4c1 mov        r10d, dword ptr [rbp + 0x384]
; range 0x107b4c8..0x107b651 (exclusive)
0107b4c8 mov        qword ptr [rsp + 0x7c8], rbx
0107b4d0 mov        ebx, r10d
0107b4d3 mov        qword ptr [rsp + 0x7d0], rdi
0107b4db mov        qword ptr [rsp + 0x7d8], r12
0107b4e3 lea        r12, [r14 + 0x52]
0107b4e7 mov        qword ptr [rsp + 0x790], r13
0107b4ef cmp        byte ptr [r12], al
0107b4f3 jne        0x14107b4f7
0107b4f5 bswap      ebx
0107b4f7 mov        r13d, 0x5c
0107b4fd lea        rcx, [rbp + 0x388]
0107b504 cmp        ebx, r13d
0107b507 mov        edi, r13d
0107b50a cmovb      edi, ebx
0107b50d cmp        edi, 8
0107b510 jbe        0x14107b555
0107b512 lea        eax, [rdi - 8]
0107b515 mov        qword ptr [rsp + 0x58], rax
0107b51a cmp        rax, 0xa00000
0107b520 ja         0x14107b647
0107b526 mov        r8d, eax
0107b529 lea        rdx, [rbp + 0x388]
0107b530 mov        rcx, r14
0107b533 call       0x1410770a0
0107b538 mov        esi, eax
0107b53a test       eax, eax
0107b53c jne        0x14107e75e
0107b542 mov        r10d, dword ptr [rbp + 0x384]
0107b549 lea        rcx, [rbp + 0x388]
0107b550 add        rcx, qword ptr [rsp + 0x58]
0107b555 cmp        edi, r13d
0107b558 jae        0x14107b573
0107b55a test       rcx, rcx
0107b55d je         0x14107b573
0107b55f sub        r13d, edi
0107b562 xor        edx, edx
0107b564 mov        r8d, r13d
0107b567 call       0x14179cca0
0107b56c mov        r10d, dword ptr [rbp + 0x384]
0107b573 cmp        ebx, edi
0107b575 jbe        0x14107b58d
0107b577 sub        ebx, edi
0107b579 mov        rcx, r14
0107b57c mov        edx, ebx
0107b57e call       0x14106a520
0107b583 mov        esi, eax
0107b585 test       eax, eax
0107b587 jne        0x14107e75e
0107b58d xor        r13d, r13d
0107b590 mov        esi, r13d
0107b593 cmp        byte ptr [r12], sil
0107b597 jne        0x14107b632
0107b59d mov        ecx, dword ptr [rbp + 0x380]
0107b5a3 mov        edx, ecx
0107b5a5 mov        eax, ecx
0107b5a7 and        edx, 0xff0000
0107b5ad shr        eax, 0x10
0107b5b0 or         edx, eax
0107b5b2 mov        eax, ecx
0107b5b4 and        eax, 0xff00
0107b5b9 shl        ecx, 0x10
0107b5bc or         eax, ecx
0107b5be shr        edx, 8
0107b5c1 shl        eax, 8
0107b5c4 mov        ecx, r10d
0107b5c7 or         edx, eax
0107b5c9 and        ecx, 0xff0000
0107b5cf mov        eax, r10d
0107b5d2 mov        dword ptr [rbp + 0x380], edx
0107b5d8 shr        eax, 0x10
0107b5db or         ecx, eax
0107b5dd mov        eax, r10d
0107b5e0 shl        eax, 0x10
0107b5e3 and        r10d, 0xff00
0107b5ea or         eax, r10d
0107b5ed shr        ecx, 8
0107b5f0 shl        eax, 8
0107b5f3 or         ecx, eax
0107b5f5 mov        dword ptr [rbp + 0x384], ecx
0107b5fb mov        ecx, dword ptr [rbp + 0x388]
0107b601 mov        r8d, ecx
0107b604 and        r8d, 0xff0000
0107b60b mov        eax, ecx
0107b60d shr        eax, 0x10
0107b610 or         r8d, eax
0107b613 mov        eax, ecx
0107b615 and        eax, 0xff00
0107b61a shl        ecx, 0x10
0107b61d or         eax, ecx
0107b61f shr        r8d, 8
0107b623 shl        eax, 8
0107b626 or         r8d, eax
0107b629 mov        dword ptr [rbp + 0x388], r8d
0107b630 jmp        0x14107b63f
0107b632 mov        r8d, dword ptr [rbp + 0x388]
0107b639 mov        edx, dword ptr [rbp + 0x380]
0107b63f cmp        edx, 0x68746c6d
0107b645 je         0x14107b651
0107b647 mov        esi, 0xffffff30
0107b64c jmp        0x14107e75e
; range 0x107b651..0x107e75e (exclusive)
0107b651 movaps     xmmword ptr [rsp + 0x780], xmm6
0107b659 movaps     xmmword ptr [rsp + 0x770], xmm7
0107b661 movaps     xmmword ptr [rsp + 0x760], xmm8
0107b66a movaps     xmmword ptr [rsp + 0x750], xmm9
0107b673 movaps     xmmword ptr [rsp + 0x740], xmm10
0107b67c movaps     xmmword ptr [rsp + 0x730], xmm11
0107b685 movaps     xmmword ptr [rsp + 0x720], xmm12
0107b68e movaps     xmmword ptr [rsp + 0x710], xmm13
0107b697 movaps     xmmword ptr [rsp + 0x700], xmm14
0107b6a0 movaps     xmmword ptr [rsp + 0x6f0], xmm15
0107b6a9 mov        dword ptr [rbp - 0xc], r13d
0107b6ad test       r8d, r8d
0107b6b0 je         0x14107e699
0107b6b6 movdqa     xmm8, xmmword ptr [rip + 0xbf9691]
0107b6bf xorps      xmm6, xmm6
0107b6c2 movdqa     xmm9, xmmword ptr [rip + 0xbf97d5]
0107b6cb movdqa     xmm10, xmmword ptr [rip + 0xbf976c]
0107b6d4 movdqa     xmm11, xmmword ptr [rip + 0xbf96d3]
0107b6dd movdqa     xmm12, xmmword ptr [rip + 0xbf97aa]
0107b6e6 movdqa     xmm13, xmmword ptr [rip + 0xbf9741]
0107b6ef movdqa     xmm14, xmmword ptr [rip + 0xbf9638]
0107b6f8 movdqa     xmm15, xmmword ptr [rip + 0xbf977f]
0107b701 movss      xmm7, dword ptr [rip + 0xbf78cb]
0107b709 nop        dword ptr [rax]
0107b710 xorps      xmm0, xmm0
0107b713 lea        rdx, [rbp + 0x40]
0107b717 mov        r13b, 1
0107b71a mov        r8d, 8
0107b720 mov        rcx, r14
0107b723 mov        byte ptr [rsp + 0x44], r13b
0107b728 movups     xmmword ptr [rbp + 0x340], xmm0
0107b72f movups     xmmword ptr [rbp + 0x350], xmm0
0107b736 call       0x1410770a0
0107b73b mov        esi, eax
0107b73d test       eax, eax
0107b73f jne        0x14107e706
0107b745 mov        ebx, dword ptr [rbp + 0x44]
0107b748 mov        ecx, ebx
0107b74a cmp        byte ptr [r12], al
0107b74e jne        0x14107b772
0107b750 and        ebx, 0xff0000
0107b756 mov        eax, ecx
0107b758 shr        eax, 0x10
0107b75b or         ebx, eax
0107b75d mov        eax, ecx
0107b75f shl        eax, 0x10
0107b762 and        ecx, 0xff00
0107b768 or         eax, ecx
0107b76a shr        ebx, 8
0107b76d shl        eax, 8
0107b770 or         ebx, eax
0107b772 mov        edi, 0x2f4
0107b777 lea        rcx, [rbp + 0x48]
0107b77b cmp        ebx, edi
0107b77d cmovb      edi, ebx
0107b780 cmp        edi, 8
0107b783 jbe        0x14107b7bc
0107b785 lea        r13d, [rdi - 8]
0107b789 cmp        r13, 0xa00000
0107b790 ja         0x14107e7a7
0107b796 mov        r8d, r13d
0107b799 lea        rdx, [rbp + 0x48]
0107b79d mov        rcx, r14
0107b7a0 call       0x1410770a0
0107b7a5 mov        esi, eax
0107b7a7 test       eax, eax
0107b7a9 jne        0x14107e706
0107b7af lea        rcx, [rbp + 0x48]
0107b7b3 add        rcx, r13
0107b7b6 movzx      r13d, byte ptr [rsp + 0x44]
0107b7bc cmp        edi, 0x2f4
0107b7c2 jae        0x14107b7d9
0107b7c4 test       rcx, rcx
0107b7c7 je         0x14107b7d9
0107b7c9 mov        r8d, 0x2f4
0107b7cf xor        edx, edx
0107b7d1 sub        r8d, edi
0107b7d4 call       0x14179cca0
0107b7d9 cmp        ebx, edi
0107b7db jbe        0x14107b7f3
0107b7dd sub        ebx, edi
0107b7df mov        rcx, r14
0107b7e2 mov        edx, ebx
0107b7e4 call       0x14106a520
0107b7e9 mov        esi, eax
0107b7eb test       eax, eax
0107b7ed jne        0x14107e706
0107b7f3 xor        ecx, ecx
0107b7f5 lea        rdx, [rbp + 0x40]
0107b7f9 mov        esi, ecx
0107b7fb mov        rcx, r14
0107b7fe call       0x141069150
0107b803 cmp        dword ptr [rbp + 0x40], 0x6874696d
0107b80a jne        0x14107e7a7
0107b810 mov        eax, dword ptr [rbp + 0x54]
0107b813 sub        eax, 1
0107b816 je         0x14107b83b
0107b818 sub        eax, 1
0107b81b je         0x14107b834
0107b81d xor        r8d, r8d
0107b820 cmp        eax, 1
0107b823 je         0x14107b82d
0107b825 mov        ebx, r8d
0107b828 xor        r13b, r13b
0107b82b jmp        0x14107b843
0107b82d mov        ebx, 0x53485244
0107b832 jmp        0x14107b843
0107b834 mov        ebx, 0x48545450
0107b839 jmp        0x14107b840
0107b83b mov        ebx, 0x46494c45
0107b840 xor        r8d, r8d
0107b843 cmp        byte ptr [r14 + 0x1e002f2], sil
0107b84a je         0x14107b858
0107b84c cmp        ebx, 0x53485244
0107b852 je         0x14107e63a
0107b858 test       r13b, r13b
0107b85b je         0x14107e63a
0107b861 xorps      xmm0, xmm0
0107b864 xorps      xmm1, xmm1
0107b867 mov        rdi, r8
0107b86a movdqa     xmmword ptr [rbp - 0x50], xmm0
0107b86f mov        r13, r8
0107b872 movdqa     xmmword ptr [rbp - 0x40], xmm1
0107b877 movdqa     xmmword ptr [rbp - 0x30], xmm0
0107b87c mov        dword ptr [rbp - 0x10], r8d
0107b880 cmp        byte ptr [r14 + 0x1e001a8], sil
0107b887 je         0x14107b8aa
0107b889 lea        rcx, [r14 + 0x1e002c0]
0107b890 lea        rdx, [rbp + 0x11c]
0107b897 call       0x140693780
0107b89c test       rax, rax
0107b89f jne        0x14107b8a6
0107b8a1 mov        rdi, rax
0107b8a4 jmp        0x14107b8aa
0107b8a6 mov        rdi, qword ptr [rax + 8]
0107b8aa cmp        byte ptr [r14 + 0x1e001a9], sil
0107b8b1 je         0x14107b8d4
0107b8b3 lea        rcx, [r14 + 0x1e002d8]
0107b8ba lea        rdx, [rbp + 0x220]
0107b8c1 call       0x140693780
0107b8c6 test       rax, rax
0107b8c9 jne        0x14107b8d0
0107b8cb mov        r13, rax
0107b8ce jmp        0x14107b8d4
0107b8d0 mov        r13, qword ptr [rax + 8]
0107b8d4 cmp        dword ptr [rsp + 0x48], 1
0107b8d9 jne        0x14107b911
0107b8db lea        rcx, [r14 + 0x1e00290]
0107b8e2 lea        rdx, [rbp + 0xc0]
0107b8e9 call       0x14042de70
0107b8ee test       rax, rax
0107b8f1 je         0x14107b911
0107b8f3 cmp        qword ptr [rax + 8], rsi
0107b8f7 je         0x14107b911
0107b8f9 xor        ecx, ecx
0107b8fb call       0x140ba5880
0107b900 mov        qword ptr [rbp + 0xc0], rax
0107b907 mov        byte ptr [r14 + 0x1e002f1], 1
0107b90f jmp        0x14107b918
0107b911 mov        rax, qword ptr [rbp + 0xc0]
0107b918 mov        qword ptr [rsp + 0x28], rax
0107b91d mov        r9, r13
0107b920 mov        eax, dword ptr [rbp + 0xb8]
0107b926 mov        r8, rdi
0107b929 mov        edx, ebx
0107b92b mov        dword ptr [rsp + 0x20], eax
0107b92f mov        rcx, r15
0107b932 call       0x140f92b80
0107b937 mov        qword ptr [rsp + 0x50], rax
0107b93c mov        rbx, rax
0107b93f test       rax, rax
0107b942 je         0x14107e79d
0107b948 mov        rdi, qword ptr [rbx + 0x58]
0107b94c mov        rax, qword ptr [rbp]
0107b950 test       rax, rax
0107b953 mov        qword ptr [rbp - 8], rdi
0107b957 cmove      rax, rbx
0107b95b mov        qword ptr [rbp], rax
0107b95f mov        eax, dword ptr [rbp + 0x234]
0107b965 test       eax, eax
0107b967 cmove      eax, dword ptr [rbp + 0x50]
0107b96b mov        dword ptr [rbp + 0x234], eax
0107b971 mov        eax, dword ptr [rbp + 0x60]
0107b974 mov        dword ptr [rdi + 0x54], eax
0107b977 mov        eax, dword ptr [rbp + 0x68]
0107b97a mov        dword ptr [rdi + 0x5c], eax
0107b97d movzx      eax, word ptr [rbp + 0x6c]
0107b981 mov        word ptr [rbx + 0x10a], ax
0107b988 movzx      eax, word ptr [rbp + 0x70]
0107b98c mov        word ptr [rbx + 0x10c], ax
0107b993 movzx      eax, word ptr [rbp + 0xa8]
0107b99a mov        word ptr [rbx + 0x10e], ax
0107b9a1 movzx      eax, word ptr [rbp + 0xaa]
0107b9a8 mov        word ptr [rbx + 0x110], ax
0107b9af movzx      eax, word ptr [rbp + 0x74]
0107b9b3 mov        word ptr [rbx + 0xa6], ax
0107b9ba movzx      eax, byte ptr [rbp + 0xac]
0107b9c1 mov        byte ptr [rbx + 0x104], al
0107b9c7 movzx      eax, byte ptr [rbx + 0x9b]
0107b9ce movzx      ecx, byte ptr [rbp + 0x93]
0107b9d5 and        al, 0xfb
0107b9d7 and        cl, 1
0107b9da shl        cl, 2
0107b9dd or         cl, al
0107b9df mov        byte ptr [rbx + 0x9b], cl
0107b9e5 movzx      eax, byte ptr [rbx + 0x9a]
0107b9ec movzx      ecx, byte ptr [rbp + 0xad]
0107b9f3 and        al, 0xef
0107b9f5 and        cl, 1
0107b9f8 shl        cl, 4
0107b9fb or         cl, al
0107b9fd mov        byte ptr [rbx + 0x9a], cl
0107ba03 movzx      eax, word ptr [rbp + 0x78]
0107ba07 mov        word ptr [rdi + 0x4c], ax
0107ba0b movss      xmm0, dword ptr [rbp + 0xd8]
0107ba13 movss      dword ptr [rdi + 0x48], xmm0
0107ba18 movzx      eax, word ptr [rbp + 0x24a]
0107ba1f mov        word ptr [rdi + 0x4e], ax
0107ba23 movzx      eax, word ptr [rbp + 0x80]
0107ba2a mov        word ptr [rbx + 0x102], ax
0107ba31 mov        eax, dword ptr [rbp + 0xb4]
0107ba37 mov        dword ptr [rbx + 0xfc], eax
0107ba3d movzx      ecx, word ptr [rbp + 0x90]
0107ba44 call       0x14106a990
0107ba49 mov        word ptr [rdi + 0x50], ax
0107ba4d movzx      eax, byte ptr [rbx + 0x9a]
0107ba54 movzx      ecx, byte ptr [rbp + 0xae]
0107ba5b and        al, 0xfb
0107ba5d and        cl, 1
0107ba60 shl        cl, 2
0107ba63 or         cl, al
0107ba65 mov        byte ptr [rbx + 0x9a], cl
0107ba6b movzx      eax, word ptr [rbp + 0xd0]
0107ba72 mov        word ptr [rdi + 0x6c], ax
0107ba76 movzx      eax, word ptr [rbp + 0xd2]
0107ba7d mov        word ptr [rdi + 0x6e], ax
0107ba81 mov        eax, dword ptr [rbp + 0xd4]
0107ba87 mov        dword ptr [rdi + 0x70], eax
0107ba8a movzx      ecx, byte ptr [rbp + 0xe7]
0107ba91 movzx      eax, byte ptr [rbx + 0x9b]
0107ba98 and        cl, 1
0107ba9b and        al, 0xf7
0107ba9d shl        cl, 3
0107baa0 or         cl, al
0107baa2 mov        byte ptr [rbx + 0x9b], cl
0107baa8 and        cl, 0xef
0107baab movzx      eax, byte ptr [rbp + 0x271]
0107bab2 and        al, 1
0107bab4 shl        al, 4
0107bab7 or         al, cl
0107bab9 mov        byte ptr [rbx + 0x9b], al
0107babf movzx      ecx, byte ptr [rbp + 0x109]
0107bac6 and        cl, 1
0107bac9 movzx      eax, byte ptr [rdi + 0x41]
0107bacd and        al, 0xfe
0107bacf or         cl, al
0107bad1 mov        byte ptr [rdi + 0x41], cl
0107bad4 and        cl, 0xf7
0107bad7 movzx      eax, byte ptr [rbp + 0x21d]
0107bade and        al, 1
0107bae0 shl        al, 3
0107bae3 or         al, cl
0107bae5 mov        byte ptr [rdi + 0x41], al
0107bae8 movzx      eax, byte ptr [rbp + 0xaf]
0107baef mov        byte ptr [rdi + 0x44], al
0107baf2 movzx      eax, byte ptr [rbp + 0x168]
0107baf9 mov        byte ptr [rdi + 0x3f], al
0107bafc movzx      eax, word ptr [rbp + 0xe4]
0107bb03 mov        word ptr [rbx + 0x12c], ax
0107bb0a movzx      eax, byte ptr [rbp + 0xe6]
0107bb11 mov        byte ptr [rbx + 0x90], al
0107bb17 movzx      eax, byte ptr [rbx + 0x9c]
0107bb1e movzx      ecx, byte ptr [rbp + 0x108]
0107bb25 and        al, 0xef
0107bb27 and        cl, 1
0107bb2a shl        cl, 4
0107bb2d or         cl, al
0107bb2f mov        byte ptr [rbx + 0x9c], cl
0107bb35 mov        rax, qword ptr [rbp + 0x10c]
0107bb3c mov        qword ptr [rdi + 0x2d8], rax
0107bb43 movzx      eax, byte ptr [rbx + 0x9d]
0107bb4a movzx      ecx, byte ptr [rbp + 0x10a]
0107bb51 and        al, 0xf7
0107bb53 and        cl, 1
0107bb56 shl        cl, 3
0107bb59 or         cl, al
0107bb5b mov        byte ptr [rbx + 0x9d], cl
0107bb61 movzx      eax, byte ptr [rbx + 0x9b]
0107bb68 movzx      ecx, byte ptr [rbp + 0x10b]
0107bb6f and        al, 0xbf
0107bb71 and        cl, 1
0107bb74 shl        cl, 6
0107bb77 or         cl, al
0107bb79 mov        byte ptr [rbx + 0x9b], cl
0107bb7f and        cl, 0x7f
0107bb82 movzx      eax, byte ptr [rbp + 0x128]
0107bb89 shl        al, 7
0107bb8c or         cl, al
0107bb8e mov        byte ptr [rbx + 0x9b], cl
0107bb94 movzx      eax, byte ptr [rbx + 0x9d]
0107bb9b movzx      ecx, byte ptr [rbp + 0x12a]
0107bba2 and        al, 0xfe
0107bba4 and        cl, 1
0107bba7 or         cl, al
0107bba9 mov        byte ptr [rbx + 0x9d], cl
0107bbaf and        cl, 0xfd
0107bbb2 movzx      eax, byte ptr [rbp + 0x12d]
0107bbb9 and        al, 1
0107bbbb add        al, al
0107bbbd or         al, cl
0107bbbf mov        byte ptr [rbx + 0x9d], al
0107bbc5 movzx      eax, byte ptr [rbx + 0x9c]
0107bbcc movzx      ecx, byte ptr [rbp + 0x129]
0107bbd3 and        al, 0xfd
0107bbd5 and        cl, 1
0107bbd8 add        cl, cl
0107bbda or         cl, al
0107bbdc mov        byte ptr [rbx + 0x9c], cl
0107bbe2 mov        eax, dword ptr [rbp + 0x130]
0107bbe8 mov        dword ptr [rdi + 0x2f4], eax
0107bbee mov        eax, dword ptr [rbp + 0x140]
0107bbf4 mov        dword ptr [rdi + 0x2f8], eax
0107bbfa mov        rax, qword ptr [rbp + 0x134]
0107bc01 mov        qword ptr [rdi + 0x2e0], rax
0107bc08 mov        rax, qword ptr [rbp + 0x160]
0107bc0f mov        qword ptr [rdi + 0x2e8], rax
0107bc16 mov        eax, dword ptr [rbp + 0x144]
0107bc1c mov        dword ptr [rdi + 0x2f0], eax
0107bc22 movzx      eax, word ptr [rbp + 0x98]
0107bc29 mov        word ptr [rdi + 0x52], ax
0107bc2d mov        eax, dword ptr [rbp + 0x100]
0107bc33 mov        dword ptr [rdi + 0x68], eax
0107bc36 movzx      eax, word ptr [rbp + 0x104]
0107bc3d mov        word ptr [rbx + 0x100], ax
0107bc44 movzx      eax, byte ptr [rbx + 0x9d]
0107bc4b movzx      ecx, byte ptr [rbp + 0x12b]
0107bc52 and        al, 0xbf
0107bc54 and        cl, 1
0107bc57 shl        cl, 6
0107bc5a or         cl, al
0107bc5c mov        byte ptr [rbx + 0x9d], cl
0107bc62 and        cl, 0xdf
0107bc65 movzx      eax, byte ptr [rbp + 0x254]
0107bc6c and        al, 1
0107bc6e shl        al, 5
0107bc71 or         al, cl
0107bc73 mov        byte ptr [rbx + 0x9d], al
0107bc79 movzx      eax, byte ptr [rbp + 0x255]
0107bc80 movzx      ecx, byte ptr [rbx + 0x9a]
0107bc87 shl        al, 7
0107bc8a and        cl, 0x7f
0107bc8d or         cl, al
0107bc8f mov        byte ptr [rbx + 0x9a], cl
0107bc95 movzx      eax, byte ptr [rbx + 0x9d]
0107bc9c movzx      ecx, byte ptr [rbp + 0x12c]
0107bca3 and        al, 0x7f
0107bca5 shl        cl, 7
0107bca8 or         cl, al
0107bcaa mov        byte ptr [rbx + 0x9d], cl
0107bcb0 movzx      eax, byte ptr [rbx + 0x9e]
0107bcb7 movzx      ecx, byte ptr [rbp + 0x2bd]
0107bcbe and        al, 0xfe
0107bcc0 and        cl, 1
0107bcc3 or         cl, al
0107bcc5 mov        byte ptr [rbx + 0x9e], cl
0107bccb movzx      eax, byte ptr [rbx + 0x9f]
0107bcd2 movzx      ecx, byte ptr [rbp + 0x2be]
0107bcd9 and        al, 0xef
0107bcdb and        cl, 1
0107bcde shl        cl, 4
0107bce1 or         cl, al
0107bce3 mov        byte ptr [rbx + 0x9f], cl
0107bce9 and        cl, 0xdf
0107bcec movzx      eax, byte ptr [rbp + 0x2bf]
0107bcf3 and        al, 1
0107bcf5 shl        al, 5
0107bcf8 or         al, cl
0107bcfa mov        byte ptr [rbx + 0x9f], al
0107bd00 movzx      eax, byte ptr [rbx + 0x9e]
0107bd07 movzx      ecx, byte ptr [rbp + 0x12f]
0107bd0e and        al, 0xfd
0107bd10 and        cl, 1
0107bd13 add        cl, cl
0107bd15 or         cl, al
0107bd17 mov        byte ptr [rbx + 0x9e], cl
0107bd1d and        cl, 0xfb
0107bd20 movzx      eax, byte ptr [rbp + 0x12e]
0107bd27 and        al, 1
0107bd29 shl        al, 2
0107bd2c or         al, cl
0107bd2e mov        byte ptr [rbx + 0x9e], al
0107bd34 mov        eax, dword ptr [rbp + 0x13c]
0107bd3a mov        dword ptr [rdi + 0x74], eax
0107bd3d mov        eax, dword ptr [rbp + 0x2d0]
0107bd43 mov        dword ptr [rbx + 0xe0], eax
0107bd49 mov        eax, dword ptr [rbp + 0x2d4]
0107bd4f mov        dword ptr [rbx + 0xe4], eax
0107bd55 mov        eax, dword ptr [rbp + 0x2d8]
0107bd5b mov        dword ptr [rbx + 0xe8], eax
0107bd61 mov        eax, dword ptr [rbp + 0x2dc]
0107bd67 mov        dword ptr [rbx + 0xec], eax
0107bd6d mov        eax, dword ptr [rbp + 0x2e0]
0107bd73 mov        dword ptr [rbx + 0xf0], eax
0107bd79 mov        eax, dword ptr [rbp + 0x2e4]
0107bd7f mov        dword ptr [rbx + 0xf4], eax
0107bd85 mov        eax, dword ptr [rbp + 0x2e8]
0107bd8b mov        dword ptr [rbx + 0xf8], eax
0107bd91 movzx      ecx, byte ptr [rbp + 0x154]
0107bd98 movzx      eax, byte ptr [rbx + 0x9e]
0107bd9f and        cl, 1
0107bda2 shl        cl, 3
0107bda5 and        al, 0xf7
0107bda7 or         cl, al
0107bda9 mov        byte ptr [rbx + 0x9e], cl
0107bdaf movzx      ecx, byte ptr [rbx + 0x9c]
0107bdb6 movzx      eax, byte ptr [rbp + 0x156]
0107bdbd and        cl, 0xfe
0107bdc0 and        al, 1
0107bdc2 or         cl, al
0107bdc4 mov        byte ptr [rbx + 0x9c], cl
0107bdca mov        rcx, rbx
0107bdcd mov        eax, dword ptr [rbp + 0x118]
0107bdd3 mov        dword ptr [rbx + 0x120], eax
0107bdd9 mov        eax, dword ptr [rbp + 0x158]
0107bddf mov        dword ptr [rbx + 0x124], eax
0107bde5 mov        eax, dword ptr [rbp + 0x15c]
0107bdeb mov        dword ptr [rbx + 0x128], eax
0107bdf1 movzx      edx, byte ptr [rbp + 0x169]
0107bdf8 call       0x140fa2b30
0107bdfd mov        rax, qword ptr [rbp + 0x174]
0107be04 mov        qword ptr [rbx + 0x140], rax
0107be0b mov        rax, qword ptr [rbp + 0x17c]
0107be12 mov        qword ptr [rbx + 0x148], rax
0107be19 movzx      eax, byte ptr [rbx + 0x9c]
0107be20 movzx      ecx, byte ptr [rbp + 0x21f]
0107be27 and        al, 0xf7
0107be29 and        cl, 1
0107be2c shl        cl, 3
0107be2f or         cl, al
0107be31 mov        byte ptr [rbx + 0x9c], cl
0107be37 movzx      eax, byte ptr [rdi + 0x42]
0107be3b movzx      ecx, byte ptr [rbp + 0x2ae]
0107be42 and        al, 0xdf
0107be44 and        cl, 1
0107be47 shl        cl, 5
0107be4a or         cl, al
0107be4c mov        byte ptr [rdi + 0x42], cl
0107be4f movzx      eax, byte ptr [rbx + 0x9f]
0107be56 movzx      ecx, byte ptr [rbp + 0x2af]
0107be5d and        al, 0xfb
0107be5f and        cl, 1
0107be62 shl        cl, 2
0107be65 or         cl, al
0107be67 mov        byte ptr [rbx + 0x9f], cl
0107be6d mov        rax, qword ptr [rbp + 0x224]
0107be74 mov        qword ptr [rbx + 0x150], rax
0107be7b mov        eax, dword ptr [rbp + 0x230]
0107be81 mov        dword ptr [rbx + 0x158], eax
0107be87 mov        eax, dword ptr [rbp + 0x260]
0107be8d mov        dword ptr [rbx + 0x15c], eax
0107be93 mov        rax, qword ptr [rbp + 0x23c]
0107be9a mov        qword ptr [rbx + 0x138], rax
0107bea1 mov        rax, qword ptr [rbp + 0x184]
0107bea8 mov        qword ptr [rdi + 0x60], rax
0107beac cmp        qword ptr [rbp + 0x184], rsi
0107beb3 jne        0x14107bebc
0107beb5 mov        eax, dword ptr [rbp + 0x64]
0107beb8 mov        qword ptr [rdi + 0x60], rax
0107bebc movzx      eax, byte ptr [rdi + 0x40]
0107bec0 movzx      ecx, byte ptr [rbp + 0x157]
0107bec7 and        al, 0xf7
0107bec9 and        cl, 1
0107becc shl        cl, 3
0107becf or         cl, al
0107bed1 mov        byte ptr [rdi + 0x40], cl
0107bed4 movzx      eax, byte ptr [rbp + 0x270]
0107bedb mov        byte ptr [rdi + 0x3e], al
0107bede mov        eax, dword ptr [rbp + 0xcc]
0107bee4 mov        dword ptr [rdi + 0x38], eax
0107bee7 movzx      eax, byte ptr [rdi + 0x41]
0107beeb movzx      ecx, byte ptr [rbp + 0x59]
0107beef and        al, 0xef
0107bef1 and        cl, 1
0107bef4 shl        cl, 4
0107bef7 or         cl, al
0107bef9 mov        byte ptr [rdi + 0x41], cl
0107befc and        cl, 0xdf
0107beff movzx      edx, byte ptr [rbp + 0x256]
0107bf06 and        dl, 1
0107bf09 shl        dl, 5
0107bf0c or         dl, cl
0107bf0e mov        byte ptr [rdi + 0x41], dl
0107bf11 and        dl, 0xbf
0107bf14 movzx      eax, byte ptr [rbp + 0x58]
0107bf18 and        al, 1
0107bf1a shl        al, 6
0107bf1d or         al, dl
0107bf1f mov        byte ptr [rdi + 0x41], al
0107bf22 mov        eax, dword ptr [rbp + 0x26c]
0107bf28 mov        dword ptr [rdi + 0x2c], eax
0107bf2b mov        eax, dword ptr [rbp + 0x2b4]
0107bf31 mov        dword ptr [rbx + 0xac], eax
0107bf37 movzx      eax, byte ptr [rbx + 0x88]
0107bf3e movzx      ecx, byte ptr [rbp + 0x298]
0107bf45 and        al, 0xf7
0107bf47 and        cl, 1
0107bf4a shl        cl, 3
0107bf4d or         cl, al
0107bf4f mov        byte ptr [rbx + 0x88], cl
0107bf55 and        cl, 0xfe
0107bf58 movzx      eax, byte ptr [rbp + 0x29c]
0107bf5f and        al, 1
0107bf61 or         al, cl
0107bf63 mov        byte ptr [rbx + 0x88], al
0107bf69 and        al, 0xfd
0107bf6b movzx      ecx, byte ptr [rbp + 0x29d]
0107bf72 and        cl, 1
0107bf75 add        cl, cl
0107bf77 or         cl, al
0107bf79 mov        byte ptr [rbx + 0x88], cl
0107bf7f and        cl, 0xfb
0107bf82 movzx      eax, byte ptr [rbp + 0x29e]
0107bf89 and        al, 1
0107bf8b shl        al, 2
0107bf8e or         al, cl
0107bf90 mov        byte ptr [rbx + 0x88], al
0107bf96 mov        eax, dword ptr [rbp + 0x2b8]
0107bf9c mov        dword ptr [rbx + 0x8c], eax
0107bfa2 movzx      eax, byte ptr [rbp + 0x322]
0107bfa9 mov        byte ptr [rbx + 0x89], al
0107bfaf cmp        byte ptr [rbp + 0x2a0], sil
0107bfb6 je         0x14107c01a
0107bfb8 test       rdi, rdi
0107bfbb je         0x14107c001
0107bfbd mov        rcx, qword ptr [rdi + 8]
0107bfc1 test       rcx, rcx
0107bfc4 je         0x14107c001
0107bfc6 mov        rcx, qword ptr [rcx + 0x10]
0107bfca test       rcx, rcx
0107bfcd je         0x14107c001
0107bfcf mov        rax, qword ptr [rdi + 0x20]
0107bfd3 test       byte ptr [rax], 1
0107bfd6 jne        0x14107c001
0107bfd8 cmp        dword ptr [rcx + 0x80], 0x74646174
0107bfe2 mov        r13, r12
0107bfe5 jne        0x14107c001
0107bfe7 mov        rcx, qword ptr [rcx + 0x150]
0107bfee call       0x140bc62b0
0107bff3 mov        qword ptr [rdi + 0x20], rax
0107bff7 mov        ecx, esi
0107bff9 test       rax, rax
0107bffc je         0x14107c001
0107bffe or         byte ptr [rax], 1
0107c001 mov        rdx, qword ptr [rdi + 0x20]
0107c005 movzx      ecx, byte ptr [rbp + 0x2a0]
0107c00c and        cl, 1
0107c00f add        cl, cl
0107c011 movzx      eax, byte ptr [rdx]
0107c014 and        al, 0xfd
0107c016 or         cl, al
0107c018 mov        byte ptr [rdx], cl
0107c01a cmp        byte ptr [rbp + 0x2a2], 0
0107c021 je         0x14107c07e
0107c023 mov        rcx, qword ptr [rdi + 8]
0107c027 test       rcx, rcx
0107c02a je         0x14107c064
0107c02c mov        rcx, qword ptr [rcx + 0x10]
0107c030 test       rcx, rcx
0107c033 je         0x14107c064
0107c035 mov        rax, qword ptr [rdi + 0x20]
0107c039 test       byte ptr [rax], 1
0107c03c jne        0x14107c064
0107c03e cmp        dword ptr [rcx + 0x80], 0x74646174
0107c048 jne        0x14107c064
0107c04a mov        rcx, qword ptr [rcx + 0x150]
0107c051 call       0x140bc62b0
0107c056 mov        qword ptr [rdi + 0x20], rax
0107c05a mov        ecx, esi
0107c05c test       rax, rax
0107c05f je         0x14107c064
0107c061 or         byte ptr [rax], 1
0107c064 mov        rdx, qword ptr [rdi + 0x20]
0107c068 movzx      ecx, byte ptr [rbp + 0x2a2]
0107c06f and        cl, 1
0107c072 shl        cl, 3
0107c075 movzx      eax, byte ptr [rdx]
0107c078 and        al, 0xf7
0107c07a or         cl, al
0107c07c mov        byte ptr [rdx], cl
0107c07e cmp        byte ptr [rbp + 0x2a1], 0
0107c085 je         0x14107c0e2
0107c087 mov        rcx, qword ptr [rdi + 8]
0107c08b test       rcx, rcx
0107c08e je         0x14107c0c8
0107c090 mov        rcx, qword ptr [rcx + 0x10]
0107c094 test       rcx, rcx
0107c097 je         0x14107c0c8
0107c099 mov        rax, qword ptr [rdi + 0x20]
0107c09d test       byte ptr [rax], 1
0107c0a0 jne        0x14107c0c8
0107c0a2 cmp        dword ptr [rcx + 0x80], 0x74646174
0107c0ac jne        0x14107c0c8
0107c0ae mov        rcx, qword ptr [rcx + 0x150]
0107c0b5 call       0x140bc62b0
0107c0ba mov        qword ptr [rdi + 0x20], rax
0107c0be mov        ecx, esi
0107c0c0 test       rax, rax
0107c0c3 je         0x14107c0c8
0107c0c5 or         byte ptr [rax], 1
0107c0c8 mov        rdx, qword ptr [rdi + 0x20]
0107c0cc movzx      ecx, byte ptr [rbp + 0x2a1]
0107c0d3 and        cl, 1
0107c0d6 shl        cl, 2
0107c0d9 movzx      eax, byte ptr [rdx]
0107c0dc and        al, 0xfb
0107c0de or         cl, al
0107c0e0 mov        byte ptr [rdx], cl
0107c0e2 cmp        dword ptr [rbp + 0x84], 0
0107c0e9 je         0x14107c100
0107c0eb mov        rcx, rbx
0107c0ee call       0x140f92fd0
0107c0f3 mov        rcx, qword ptr [rbx + 0x78]
0107c0f7 mov        eax, dword ptr [rbp + 0x84]
0107c0fd mov        dword ptr [rcx + 4], eax
0107c100 cmp        dword ptr [rbp + 0x88], 0
0107c107 je         0x14107c11e
0107c109 mov        rcx, rbx
0107c10c call       0x140f92fd0
0107c111 mov        rcx, qword ptr [rbx + 0x78]
0107c115 mov        eax, dword ptr [rbp + 0x88]
0107c11b mov        dword ptr [rcx + 8], eax
0107c11e cmp        dword ptr [rbp + 0xbc], 0
0107c125 je         0x14107c13c
0107c127 mov        rcx, rbx
0107c12a call       0x140f92fd0
0107c12f mov        rcx, qword ptr [rbx + 0x78]
0107c133 mov        eax, dword ptr [rbp + 0xbc]
0107c139 mov        dword ptr [rcx + 0xc], eax
0107c13c cmp        dword ptr [rbp + 0x2b0], 0
0107c143 je         0x14107c15a
0107c145 mov        rcx, rbx
0107c148 call       0x140f92fd0
0107c14d mov        rcx, qword ptr [rbx + 0x78]
0107c151 mov        eax, dword ptr [rbp + 0x2b0]
0107c157 mov        dword ptr [rcx + 0x14], eax
0107c15a movzx      eax, byte ptr [rbp + 0x2bc]
0107c161 mov        ecx, eax
0107c163 test       al, al
0107c165 mov        eax, 2
0107c16a cmove      ecx, eax
0107c16d mov        byte ptr [rbp + 0x2bc], cl
0107c173 test       cl, cl
0107c175 movzx      edx, cl
0107c178 mov        rcx, qword ptr [rbp + 0x274]
0107c17f jne        0x14107c1b1
0107c181 test       rcx, rcx
0107c184 jne        0x14107c1ff
0107c186 mov        r9, qword ptr [rbp + 0x27c]
0107c18d test       r9, r9
0107c190 jne        0x14107c1ff
0107c192 mov        r8, qword ptr [rbp + 0x2c8]
0107c199 test       r8, r8
0107c19c jne        0x14107c1ff
0107c19e mov        rax, qword ptr [rdi + 0x20]
0107c1a2 mov        edx, dword ptr [rax + 4]
0107c1a5 cmp        edx, 2
0107c1a8 je         0x14107c1e2
0107c1aa cmp        edx, 3
0107c1ad jne        0x14107c1ff
0107c1af jmp        0x14107c1dd
0107c1b1 mov        r8, qword ptr [rbp + 0x2c8]
0107c1b8 mov        r9, qword ptr [rbp + 0x27c]
0107c1bf test       rcx, rcx
0107c1c2 je         0x14107c1cb
0107c1c4 test       r9, r9
0107c1c7 jne        0x14107c1d5
0107c1c9 jmp        0x14107c1ff
0107c1cb test       r9, r9
0107c1ce jne        0x14107c1ff
0107c1d0 test       r8, r8
0107c1d3 jne        0x14107c1ff
0107c1d5 lea        eax, [rdx - 2]
0107c1d8 cmp        eax, 1
0107c1db ja         0x14107c1ff
0107c1dd cmp        edx, 2
0107c1e0 jne        0x14107c1ef
0107c1e2 mov        rdx, rcx
0107c1e5 mov        rcx, rdi
0107c1e8 call       0x140faa080
0107c1ed jmp        0x14107c1ff
0107c1ef cmp        edx, 3
0107c1f2 jne        0x14107c1ff
0107c1f4 mov        rdx, rcx
0107c1f7 mov        rcx, rdi
0107c1fa call       0x140fa9ed0
0107c1ff movzx      eax, byte ptr [rbp + 0x29b]
0107c206 test       al, al
0107c208 je         0x14107c210
0107c20a mov        byte ptr [rbx + 0x8a], al
0107c210 cmp        dword ptr [rbp + 0x238], 0
0107c217 je         0x14107c22e
0107c219 mov        rcx, rbx
0107c21c call       0x140f92f00
0107c221 mov        rcx, qword ptr [rbx + 0x68]
0107c225 mov        eax, dword ptr [rbp + 0x238]
0107c22b mov        dword ptr [rcx + 0x10], eax
0107c22e movzx      ecx, byte ptr [rbp + 0x319]
0107c235 movzx      eax, byte ptr [rbx + 0xa0]
0107c23c and        cl, 1
0107c23f shl        cl, 3
0107c242 and        al, 0xf7
0107c244 or         cl, al
0107c246 mov        byte ptr [rbx + 0xa0], cl
0107c24c movzx      ecx, byte ptr [rbp + 0x31a]
0107c253 movzx      eax, byte ptr [rdi + 0x40]
0107c257 and        cl, 1
0107c25a add        cl, cl
0107c25c and        al, 0xfd
0107c25e or         cl, al
0107c260 mov        byte ptr [rdi + 0x40], cl
0107c263 cmp        dword ptr [rbp + 0xe0], 0
0107c26a jne        0x14107c27e
0107c26c cmp        byte ptr [rbp + 0x31b], 0
0107c273 jne        0x14107c27e
0107c275 cmp        dword ptr [rbp + 0x31c], 0
0107c27c je         0x14107c2f4
0107c27e mov        rax, qword ptr [rdi + 0x10]
0107c282 test       byte ptr [rax], 1
0107c285 jne        0x14107c2bd
0107c287 mov        rcx, qword ptr [rdi + 8]
0107c28b test       rcx, rcx
0107c28e je         0x14107c2bd
0107c290 mov        rcx, qword ptr [rcx + 0x10]
0107c294 test       rcx, rcx
0107c297 je         0x14107c2bd
0107c299 cmp        dword ptr [rcx + 0x80], 0x74646174
0107c2a3 jne        0x14107c2bd
0107c2a5 mov        rcx, qword ptr [rcx + 0x138]
0107c2ac call       0x140bc62b0
0107c2b1 mov        qword ptr [rdi + 0x10], rax
0107c2b5 test       rax, rax
0107c2b8 je         0x14107c2bd
0107c2ba or         byte ptr [rax], 1
0107c2bd movzx      ecx, byte ptr [rbp + 0x31b]
0107c2c4 mov        rdx, qword ptr [rdi + 0x10]
0107c2c8 shl        cl, 7
0107c2cb movzx      eax, byte ptr [rdx]
0107c2ce and        al, 0x7f
0107c2d0 or         cl, al
0107c2d2 mov        byte ptr [rdx], cl
0107c2d4 mov        rcx, qword ptr [rdi + 0x10]
0107c2d8 mov        eax, dword ptr [rbp + 0xe0]
0107c2de mov        dword ptr [rcx + 0x8c], eax
0107c2e4 mov        rcx, qword ptr [rdi + 0x10]
0107c2e8 mov        eax, dword ptr [rbp + 0x31c]
0107c2ee mov        dword ptr [rcx + 0x90], eax
0107c2f4 cmp        dword ptr [rbp + 0x14c], 0
0107c2fb je         0x14107c312
0107c2fd mov        rcx, rbx
0107c300 call       0x140f92f70
0107c305 mov        rcx, qword ptr [rbx + 0x70]
0107c309 mov        eax, dword ptr [rbp + 0x14c]
0107c30f mov        dword ptr [rcx + 4], eax
0107c312 cmp        dword ptr [rbp + 0x150], 0
0107c319 je         0x14107c330
0107c31b mov        rcx, rbx
0107c31e call       0x140f92f70
0107c323 mov        rcx, qword ptr [rbx + 0x70]
0107c327 mov        eax, dword ptr [rbp + 0x150]
0107c32d mov        dword ptr [rcx + 8], eax
0107c330 mov        rdx, qword ptr [rbp + 0x1ec]
0107c337 test       rdx, rdx
0107c33a jne        0x14107c349
0107c33c mov        edx, dword ptr [rbp + 0xe8]
0107c342 mov        qword ptr [rbp + 0x1ec], rdx
0107c349 mov        rcx, rdi
0107c34c call       0x140fab080
0107c351 cmp        qword ptr [rbp + 0x1fc], 0
0107c359 jne        0x14107c36d
0107c35b mov        eax, dword ptr [rbp + 0xf0]
0107c361 mov        qword ptr [rbp + 0x1fc], rax
0107c368 test       rax, rax
0107c36b je         0x14107c3bb
0107c36d mov        rax, qword ptr [rdi + 0x10]
0107c371 test       byte ptr [rax], 1
0107c374 jne        0x14107c3ac
0107c376 mov        rcx, qword ptr [rdi + 8]
0107c37a test       rcx, rcx
0107c37d je         0x14107c3ac
0107c37f mov        rcx, qword ptr [rcx + 0x10]
0107c383 test       rcx, rcx
0107c386 je         0x14107c3ac
0107c388 cmp        dword ptr [rcx + 0x80], 0x74646174
0107c392 jne        0x14107c3ac
0107c394 mov        rcx, qword ptr [rcx + 0x138]
0107c39b call       0x140bc62b0
0107c3a0 mov        qword ptr [rdi + 0x10], rax
0107c3a4 test       rax, rax
0107c3a7 je         0x14107c3ac
0107c3a9 or         byte ptr [rax], 1
0107c3ac mov        rcx, qword ptr [rdi + 0x10]
0107c3b0 mov        rax, qword ptr [rbp + 0x1fc]
0107c3b7 mov        qword ptr [rcx + 0x48], rax
0107c3bb cmp        qword ptr [rbp + 0x20c], 0
0107c3c3 jne        0x14107c3d7
0107c3c5 mov        eax, dword ptr [rbp + 0xf8]
0107c3cb mov        qword ptr [rbp + 0x20c], rax
0107c3d2 test       rax, rax
0107c3d5 je         0x14107c3ee
0107c3d7 mov        rcx, rdi
0107c3da call       0x140fa6150
0107c3df mov        rcx, qword ptr [rdi + 0x10]
0107c3e3 mov        rax, qword ptr [rbp + 0x20c]
0107c3ea mov        qword ptr [rcx + 0x58], rax
0107c3ee cmp        qword ptr [rbp + 0x1f4], 0
0107c3f6 jne        0x14107c40a
0107c3f8 mov        eax, dword ptr [rbp + 0xec]
0107c3fe mov        qword ptr [rbp + 0x1f4], rax
0107c405 test       rax, rax
0107c408 je         0x14107c421
0107c40a mov        rcx, rdi
0107c40d call       0x140fa6150
0107c412 mov        rcx, qword ptr [rdi + 0x10]
0107c416 mov        rax, qword ptr [rbp + 0x1f4]
0107c41d mov        qword ptr [rcx + 0x40], rax
0107c421 cmp        qword ptr [rbp + 0x204], 0
0107c429 jne        0x14107c43d
0107c42b mov        eax, dword ptr [rbp + 0xf4]
0107c431 mov        qword ptr [rbp + 0x204], rax
0107c438 test       rax, rax
0107c43b je         0x14107c454
0107c43d mov        rcx, rdi
0107c440 call       0x140fa6150
0107c445 mov        rcx, qword ptr [rdi + 0x10]
0107c449 mov        rax, qword ptr [rbp + 0x204]
0107c450 mov        qword ptr [rcx + 0x50], rax
0107c454 cmp        qword ptr [rbp + 0x214], 0
0107c45c jne        0x14107c470
0107c45e mov        eax, dword ptr [rbp + 0x124]
0107c464 mov        qword ptr [rbp + 0x214], rax
0107c46b test       rax, rax
0107c46e je         0x14107c487
0107c470 mov        rcx, rdi
0107c473 call       0x140fa6150
0107c478 mov        rcx, qword ptr [rdi + 0x10]
0107c47c mov        rax, qword ptr [rbp + 0x214]
0107c483 mov        qword ptr [rcx + 0x60], rax
0107c487 cmp        dword ptr [rbp + 0xdc], 0
0107c48e je         0x14107c4a8
0107c490 mov        rcx, rdi
0107c493 call       0x140fa6150
0107c498 mov        rcx, qword ptr [rdi + 0x10]
0107c49c mov        eax, dword ptr [rbp + 0xdc]
0107c4a2 mov        dword ptr [rcx + 0x88], eax
0107c4a8 cmp        byte ptr [rbp + 0x92], 0
0107c4af je         0x14107c4c7
0107c4b1 mov        rcx, rbx
0107c4b4 call       0x140f92f00
0107c4b9 mov        rcx, qword ptr [rbx + 0x68]
0107c4bd movzx      eax, byte ptr [rbp + 0x92]
0107c4c4 mov        byte ptr [rcx + 1], al
0107c4c7 cmp        dword ptr [rbp + 0xfc], 0
0107c4ce je         0x14107c4e5
0107c4d0 mov        rcx, rbx
0107c4d3 call       0x140f92f00
0107c4d8 mov        rcx, qword ptr [rbx + 0x68]
0107c4dc mov        eax, dword ptr [rbp + 0xfc]
0107c4e2 mov        dword ptr [rcx + 4], eax
0107c4e5 mov        rdx, qword ptr [rbp + 0x16c]
0107c4ec mov        r8, qword ptr [rbp + 0x2a4]
0107c4f3 test       rdx, rdx
0107c4f6 jne        0x14107c4fd
0107c4f8 test       r8, r8
0107c4fb je         0x14107c505
0107c4fd mov        rcx, rbx
0107c500 call       0x140fa2d60
0107c505 cmp        word ptr [rbp + 0x310], 0
0107c50d jne        0x14107c526
0107c50f cmp        word ptr [rbp + 0x312], 0
0107c517 jne        0x14107c526
0107c519 cmp        byte ptr [rbp + 0x314], 0
0107c520 je         0x14107c5a6
0107c526 mov        rax, qword ptr [rbx + 0x68]
0107c52a test       byte ptr [rax], 1
0107c52d jne        0x14107c56e
0107c52f mov        rcx, qword ptr [rbx + 0x10]
0107c533 test       rcx, rcx
0107c536 je         0x14107c56e
0107c538 cmp        dword ptr [rcx + 0x80], 0x74646174
0107c542 jne        0x14107c56e
0107c544 mov        rcx, qword ptr [rcx + 0x130]
0107c54b call       0x140bc62b0
0107c550 test       rax, rax
0107c553 je         0x14107c56e
0107c555 xor        ecx, ecx
0107c557 mov        qword ptr [rax + 0x58], rcx
0107c55b mov        qword ptr [rax + 0x60], rcx
0107c55f mov        qword ptr [rax + 0x68], rcx
0107c563 mov        qword ptr [rax + 0x70], rcx
0107c567 mov        qword ptr [rbx + 0x68], rax
0107c56b or         byte ptr [rax], 1
0107c56e mov        rcx, qword ptr [rbx + 0x68]
0107c572 movzx      eax, word ptr [rbp + 0x310]
0107c579 mov        word ptr [rcx + 0x14], ax
0107c57d mov        rcx, qword ptr [rbx + 0x68]
0107c581 movzx      eax, word ptr [rbp + 0x312]
0107c588 mov        word ptr [rcx + 0x16], ax
0107c58c mov        rdx, qword ptr [rbx + 0x68]
0107c590 movzx      ecx, byte ptr [rbp + 0x314]
0107c597 and        cl, 1
0107c59a shl        cl, 3
0107c59d movzx      eax, byte ptr [rdx]
0107c5a0 and        al, 0xf7
0107c5a2 or         cl, al
0107c5a4 mov        byte ptr [rdx], cl
0107c5a6 cmp        byte ptr [rbp + 0x19c], 0
0107c5ad je         0x14107c5f6
0107c5af mov        rax, qword ptr [rdi + 0x18]
0107c5b3 test       byte ptr [rax], 1
0107c5b6 jne        0x14107c5ee
0107c5b8 mov        rcx, qword ptr [rdi + 8]
0107c5bc test       rcx, rcx
0107c5bf je         0x14107c5ee
0107c5c1 mov        rcx, qword ptr [rcx + 0x10]
0107c5c5 test       rcx, rcx
0107c5c8 je         0x14107c5ee
0107c5ca cmp        dword ptr [rcx + 0x80], 0x74646174
0107c5d4 jne        0x14107c5ee
0107c5d6 mov        rcx, qword ptr [rcx + 0x148]
0107c5dd call       0x140bc62b0
0107c5e2 mov        qword ptr [rdi + 0x18], rax
0107c5e6 test       rax, rax
0107c5e9 je         0x14107c5ee
0107c5eb or         byte ptr [rax], 1
0107c5ee mov        rax, qword ptr [rdi + 0x18]
0107c5f2 mov        byte ptr [rax + 0x18], 1
0107c5f6 cmp        byte ptr [rbp + 0x1b0], 0
0107c5fd je         0x14107c646
0107c5ff mov        rax, qword ptr [rdi + 0x18]
0107c603 test       byte ptr [rax], 1
0107c606 jne        0x14107c63e
0107c608 mov        rcx, qword ptr [rdi + 8]
0107c60c test       rcx, rcx
0107c60f je         0x14107c63e
0107c611 mov        rcx, qword ptr [rcx + 0x10]
0107c615 test       rcx, rcx
0107c618 je         0x14107c63e
0107c61a cmp        dword ptr [rcx + 0x80], 0x74646174
0107c624 jne        0x14107c63e
0107c626 mov        rcx, qword ptr [rcx + 0x148]
0107c62d call       0x140bc62b0
0107c632 mov        qword ptr [rdi + 0x18], rax
0107c636 test       rax, rax
0107c639 je         0x14107c63e
0107c63b or         byte ptr [rax], 1
0107c63e mov        rax, qword ptr [rdi + 0x18]
0107c642 mov        byte ptr [rax + 0x1a], 1
0107c646 cmp        byte ptr [rbp + 0x1b3], 0
0107c64d je         0x14107c695
0107c64f mov        rax, qword ptr [rdi + 0x18]
0107c653 test       byte ptr [rax], 1
0107c656 jne        0x14107c68e
0107c658 mov        rcx, qword ptr [rdi + 8]
0107c65c test       rcx, rcx
0107c65f je         0x14107c68e
0107c661 mov        rcx, qword ptr [rcx + 0x10]
0107c665 test       rcx, rcx
0107c668 je         0x14107c68e
0107c66a cmp        dword ptr [rcx + 0x80], 0x74646174
0107c674 jne        0x14107c68e
0107c676 mov        rcx, qword ptr [rcx + 0x148]
0107c67d call       0x140bc62b0
0107c682 mov        qword ptr [rdi + 0x18], rax
0107c686 test       rax, rax
0107c689 je         0x14107c68e
0107c68b or         byte ptr [rax], 1
0107c68e mov        rax, qword ptr [rdi + 0x18]
0107c692 or         byte ptr [rax], 8
0107c695 cmp        byte ptr [rbp + 0x19d], 0
0107c69c je         0x14107c6e5
0107c69e mov        rax, qword ptr [rdi + 0x18]
0107c6a2 test       byte ptr [rax], 1
0107c6a5 jne        0x14107c6dd
0107c6a7 mov        rcx, qword ptr [rdi + 8]
0107c6ab test       rcx, rcx
0107c6ae je         0x14107c6dd
0107c6b0 mov        rcx, qword ptr [rcx + 0x10]
0107c6b4 test       rcx, rcx
0107c6b7 je         0x14107c6dd
0107c6b9 cmp        dword ptr [rcx + 0x80], 0x74646174
0107c6c3 jne        0x14107c6dd
0107c6c5 mov        rcx, qword ptr [rcx + 0x148]
0107c6cc call       0x140bc62b0
0107c6d1 mov        qword ptr [rdi + 0x18], rax
0107c6d5 test       rax, rax
0107c6d8 je         0x14107c6dd
0107c6da or         byte ptr [rax], 1
0107c6dd mov        rax, qword ptr [rdi + 0x18]
0107c6e1 mov        byte ptr [rax + 0x19], 1
0107c6e5 cmp        byte ptr [rbp + 0x2a3], 0
0107c6ec je         0x14107c750
0107c6ee mov        rax, qword ptr [rdi + 0x18]
0107c6f2 test       byte ptr [rax], 1
0107c6f5 jne        0x14107c72d
0107c6f7 mov        rcx, qword ptr [rdi + 8]
0107c6fb test       rcx, rcx
0107c6fe je         0x14107c72d
0107c700 mov        rcx, qword ptr [rcx + 0x10]
0107c704 test       rcx, rcx
0107c707 je         0x14107c72d
0107c709 cmp        dword ptr [rcx + 0x80], 0x74646174
0107c713 jne        0x14107c72d
0107c715 mov        rcx, qword ptr [rcx + 0x148]
0107c71c call       0x140bc62b0
0107c721 mov        qword ptr [rdi + 0x18], rax
0107c725 test       rax, rax
0107c728 je         0x14107c72d
0107c72a or         byte ptr [rax], 1
0107c72d mov        rax, qword ptr [rdi + 0x18]
0107c731 movzx      ecx, byte ptr [rbp + 0x2a3]
0107c738 mov        word ptr [rax + 0x12], cx
0107c73c mov        rax, qword ptr [rdi + 0x18]
0107c740 movzx      ecx, byte ptr [rbp + 0x320]
0107c747 mov        word ptr [rax + 0x14], cx
0107c74b jmp        0x14107c84c
0107c750 cmp        qword ptr [rbx + 0x10], 0
0107c755 je         0x14107c7fa
0107c75b test       byte ptr [rbx + 0x9c], 2
0107c762 jne        0x14107c7b1
0107c764 test       byte ptr [rbx + 0x9a], 1
0107c76b je         0x14107c7fa
0107c771 mov        rax, qword ptr [rbx + 0x68]
0107c775 mov        ecx, dword ptr [rax + 0x10]
0107c778 test       ecx, ecx
0107c77a jne        0x14107c7a9
0107c77c cmp        dword ptr [rbx + 0xac], ecx
0107c782 jne        0x14107c7a3
0107c784 mov        rcx, rbx
0107c787 call       0x140f91240
0107c78c mov        dword ptr [rbx + 0xac], eax
0107c792 test       eax, eax
0107c794 je         0x14107c7a3
0107c796 mov        edx, 0x3c
0107c79b mov        rcx, rbx
0107c79e call       0x140f94100
0107c7a3 mov        ecx, dword ptr [rbx + 0xac]
0107c7a9 test       ecx, 0xc62
0107c7af je         0x14107c7fa
0107c7b1 mov        rax, qword ptr [rdi + 0x18]
0107c7b5 test       byte ptr [rax], 1
0107c7b8 jne        0x14107c7f0
0107c7ba mov        rcx, qword ptr [rdi + 8]
0107c7be test       rcx, rcx
0107c7c1 je         0x14107c7f0
0107c7c3 mov        rcx, qword ptr [rcx + 0x10]
0107c7c7 test       rcx, rcx
0107c7ca je         0x14107c7f0
0107c7cc cmp        dword ptr [rcx + 0x80], 0x74646174
0107c7d6 jne        0x14107c7f0
0107c7d8 mov        rcx, qword ptr [rcx + 0x148]
0107c7df call       0x140bc62b0
0107c7e4 mov        qword ptr [rdi + 0x18], rax
0107c7e8 test       rax, rax
0107c7eb je         0x14107c7f0
0107c7ed or         byte ptr [rax], 1
0107c7f0 mov        rax, qword ptr [rdi + 0x18]
0107c7f4 xor        ecx, ecx
0107c7f6 mov        word ptr [rax + 0x12], cx
0107c7fa cmp        byte ptr [rbp + 0x21e], 0
0107c801 je         0x14107c84c
0107c803 mov        rax, qword ptr [rdi + 0x18]
0107c807 test       byte ptr [rax], 1
0107c80a jne        0x14107c842
0107c80c mov        rcx, qword ptr [rdi + 8]
0107c810 test       rcx, rcx
0107c813 je         0x14107c842
0107c815 mov        rcx, qword ptr [rcx + 0x10]
0107c819 test       rcx, rcx
0107c81c je         0x14107c842
0107c81e cmp        dword ptr [rcx + 0x80], 0x74646174
0107c828 jne        0x14107c842
0107c82a mov        rcx, qword ptr [rcx + 0x148]
0107c831 call       0x140bc62b0
0107c836 mov        qword ptr [rdi + 0x18], rax
0107c83a test       rax, rax
0107c83d je         0x14107c842
0107c83f or         byte ptr [rax], 1
0107c842 mov        rax, qword ptr [rdi + 0x18]
0107c846 mov        word ptr [rax + 0x12], 1
0107c84c mov        rdx, qword ptr [rbp + 0x1dc]
0107c853 test       rdx, rdx
0107c856 jne        0x14107c865
0107c858 mov        edx, dword ptr [rbp + 0x1a0]
0107c85e mov        qword ptr [rbp + 0x1dc], rdx
0107c865 mov        rcx, qword ptr [rbp + 0x1d4]
0107c86c test       rcx, rcx
0107c86f jne        0x14107c87e
0107c871 mov        ecx, dword ptr [rbp + 0xb0]
0107c877 mov        qword ptr [rbp + 0x1d4], rcx
0107c87e mov        rax, qword ptr [rbp + 0x1e4]
0107c885 test       rax, rax
0107c888 jne        0x14107c897
0107c88a mov        eax, dword ptr [rbp + 0xc8]
0107c890 mov        qword ptr [rbp + 0x1e4], rax
0107c897 test       rdx, rdx
0107c89a jne        0x14107c8c3
0107c89c test       rcx, rcx
0107c89f jne        0x14107c8c3
0107c8a1 test       rax, rax
0107c8a4 jne        0x14107c8c3
0107c8a6 cmp        qword ptr [rbp + 0x24c], rax
0107c8ad jne        0x14107c8c3
0107c8af cmp        dword ptr [rbp + 0x114], eax
0107c8b5 jne        0x14107c8c3
0107c8b7 cmp        dword ptr [rbp + 0x22c], eax
0107c8bd je         0x14107c98f
0107c8c3 mov        rcx, rdi
0107c8c6 call       0x140fa6150
0107c8cb mov        rcx, qword ptr [rdi + 0x10]
0107c8cf mov        rax, qword ptr [rbp + 0x1dc]
0107c8d6 mov        qword ptr [rcx + 0x20], rax
0107c8da mov        rcx, qword ptr [rdi + 0x10]
0107c8de mov        rax, qword ptr [rbp + 0x1d4]
0107c8e5 mov        qword ptr [rcx + 8], rax
0107c8e9 mov        rcx, qword ptr [rdi + 0x10]
0107c8ed mov        rax, qword ptr [rbp + 0x1e4]
0107c8f4 mov        qword ptr [rcx + 0x10], rax
0107c8f8 mov        rax, qword ptr [rbp + 0x24c]
0107c8ff mov        rcx, qword ptr [rdi + 0x10]
0107c903 mov        qword ptr [rcx + 0x18], rax
0107c907 mov        eax, dword ptr [rbp + 0x114]
0107c90d mov        rcx, qword ptr [rdi + 0x10]
0107c911 mov        dword ptr [rcx + 0x84], eax
0107c917 mov        rcx, qword ptr [rdi + 0x10]
0107c91b mov        eax, dword ptr [rbp + 0x22c]
0107c921 mov        dword ptr [rcx + 4], eax
0107c924 mov        rcx, qword ptr [rdi + 0x10]
0107c928 mov        rax, qword ptr [rbp + 0x2ec]
0107c92f mov        qword ptr [rcx + 0x28], rax
0107c933 mov        rcx, qword ptr [rdi + 0x10]
0107c937 mov        rax, qword ptr [rbp + 0x2f4]
0107c93e mov        qword ptr [rcx + 0x30], rax
0107c942 mov        rdx, qword ptr [rdi + 0x10]
0107c946 movzx      ecx, byte ptr [rbp + 0x299]
0107c94d and        cl, 1
0107c950 add        cl, cl
0107c952 movzx      eax, byte ptr [rdx]
0107c955 and        al, 0xfd
0107c957 or         cl, al
0107c959 mov        byte ptr [rdx], cl
0107c95b mov        rdx, qword ptr [rdi + 0x10]
0107c95f movzx      ecx, byte ptr [rbp + 0x29a]
0107c966 and        cl, 1
0107c969 shl        cl, 2
0107c96c movzx      eax, byte ptr [rdx]
0107c96f and        al, 0xfb
0107c971 or         cl, al
0107c973 mov        byte ptr [rdx], cl
0107c975 mov        rdx, qword ptr [rdi + 0x10]
0107c979 movzx      ecx, byte ptr [rbp + 0x2ac]
0107c980 and        cl, 1
0107c983 shl        cl, 5
0107c986 movzx      eax, byte ptr [rdx]
0107c989 and        al, 0xdf
0107c98b or         cl, al
0107c98d mov        byte ptr [rdx], cl
0107c98f movzx      ecx, byte ptr [rbp + 0x2fc]
0107c996 movzx      eax, byte ptr [rdi + 0x42]
0107c99a and        cl, 1
0107c99d shl        cl, 6
0107c9a0 and        al, 0xbf
0107c9a2 or         cl, al
0107c9a4 mov        byte ptr [rdi + 0x42], cl
0107c9a7 and        cl, 0x7f
0107c9aa movzx      eax, byte ptr [rbp + 0x315]
0107c9b1 shl        al, 7
0107c9b4 or         cl, al
0107c9b6 mov        byte ptr [rdi + 0x42], cl
0107c9b9 movzx      ecx, byte ptr [rbp + 0x2fe]
0107c9c0 movzx      eax, byte ptr [rbx + 0x9f]
0107c9c7 and        cl, 1
0107c9ca and        al, 0xbf
0107c9cc shl        cl, 6
0107c9cf or         cl, al
0107c9d1 mov        byte ptr [rbx + 0x9f], cl
0107c9d7 movzx      ecx, byte ptr [rbx + 0xa0]
0107c9de movzx      eax, byte ptr [rbp + 0x30c]
0107c9e5 and        cl, 0xfe
0107c9e8 and        al, 1
0107c9ea or         cl, al
0107c9ec mov        byte ptr [rbx + 0xa0], cl
0107c9f2 and        cl, 0xfd
0107c9f5 movzx      eax, byte ptr [rbp + 0x30d]
0107c9fc and        al, 1
0107c9fe add        al, al
0107ca00 or         al, cl
0107ca02 mov        byte ptr [rbx + 0xa0], al
0107ca08 movzx      eax, byte ptr [rbp + 0x2ff]
0107ca0f mov        byte ptr [rbx + 0x107], al
0107ca15 movzx      ecx, byte ptr [rbp + 0x30e]
0107ca1c movzx      eax, byte ptr [rbx + 0xa0]
0107ca23 and        cl, 1
0107ca26 shl        cl, 2
0107ca29 and        al, 0xfb
0107ca2b or         cl, al
0107ca2d mov        byte ptr [rbx + 0xa0], cl
0107ca33 movzx      eax, byte ptr [rbp + 0x321]
0107ca3a mov        byte ptr [rdi + 0x45], al
0107ca3d movzx      ecx, byte ptr [rbp + 0x323]
0107ca44 movzx      eax, byte ptr [rdi + 0x43]
0107ca48 and        cl, 1
0107ca4b and        al, 0xfe
0107ca4d or         cl, al
0107ca4f mov        byte ptr [rdi + 0x43], cl
0107ca52 cmp        qword ptr [rbp + 0x304], 0
0107ca5a jne        0x14107ca8d
0107ca5c cmp        byte ptr [rbp + 0x2fd], 0
0107ca63 jne        0x14107ca8d
0107ca65 cmp        byte ptr [rbp + 0x300], 0
0107ca6c jne        0x14107ca8d
0107ca6e cmp        byte ptr [rbp + 0x301], 0
0107ca75 jne        0x14107ca8d
0107ca77 cmp        byte ptr [rbp + 0x302], 0
0107ca7e jne        0x14107ca8d
0107ca80 cmp        byte ptr [rbp + 0x303], 0
0107ca87 je         0x14107cb2f
0107ca8d mov        rcx, qword ptr [rdi + 8]
0107ca91 test       rcx, rcx
0107ca94 je         0x14107cace
0107ca96 mov        rcx, qword ptr [rcx + 0x10]
0107ca9a test       rcx, rcx
0107ca9d je         0x14107cace
0107ca9f mov        rax, qword ptr [rdi + 0x20]
0107caa3 test       byte ptr [rax], 1
0107caa6 jne        0x14107cace
0107caa8 cmp        dword ptr [rcx + 0x80], 0x74646174
0107cab2 jne        0x14107cace
0107cab4 mov        rcx, qword ptr [rcx + 0x150]
0107cabb call       0x140bc62b0
0107cac0 mov        qword ptr [rdi + 0x20], rax
0107cac4 mov        ecx, esi
0107cac6 test       rax, rax
0107cac9 je         0x14107cace
0107cacb or         byte ptr [rax], 1
0107cace mov        rcx, qword ptr [rdi + 0x20]
0107cad2 mov        rax, qword ptr [rbp + 0x304]
0107cad9 mov        qword ptr [rcx + 0x20], rax
0107cadd movzx      ecx, byte ptr [rbp + 0x2fd]
0107cae4 mov        rdx, qword ptr [rdi + 0x20]
0107cae8 and        cl, 1
0107caeb shl        cl, 4
0107caee movzx      eax, byte ptr [rdx]
0107caf1 and        al, 0xef
0107caf3 or         cl, al
0107caf5 mov        byte ptr [rdx], cl
0107caf7 mov        rcx, qword ptr [rdi + 0x20]
0107cafb movzx      eax, byte ptr [rbp + 0x300]
0107cb02 mov        byte ptr [rcx + 0x28], al
0107cb05 mov        rcx, qword ptr [rdi + 0x20]
0107cb09 movzx      eax, byte ptr [rbp + 0x301]
0107cb10 mov        byte ptr [rcx + 0x29], al
0107cb13 mov        rcx, qword ptr [rdi + 0x20]
0107cb17 movzx      eax, byte ptr [rbp + 0x302]
0107cb1e mov        byte ptr [rcx + 0x2a], al
0107cb21 mov        rcx, qword ptr [rdi + 0x20]
0107cb25 movzx      eax, byte ptr [rbp + 0x303]
0107cb2c mov        byte ptr [rcx + 0x2b], al
0107cb2f movss      xmm0, dword ptr [rdi + 0x48]
0107cb34 ucomiss    xmm0, xmm6
0107cb37 jp         0x14107cb4f
0107cb39 jne        0x14107cb4f
0107cb3b mov        eax, dword ptr [rbp + 0x7c]
0107cb3e xorps      xmm0, xmm0
0107cb41 cvtsi2ss   xmm0, rax
0107cb46 mulss      xmm0, xmm7
0107cb4a movss      dword ptr [rdi + 0x48], xmm0
0107cb4f cmp        dword ptr [r14 + 0x3c], 1
0107cb54 jb         0x14107cb7a
0107cb56 mov        eax, dword ptr [rbp + 0xa4]
0107cb5c mov        dword ptr [rbx + 0x11c], eax
0107cb62 mov        eax, dword ptr [rbp + 0x8c]
0107cb68 mov        dword ptr [rbx + 0x114], eax
0107cb6e mov        eax, dword ptr [rbp + 0xa0]
0107cb74 mov        dword ptr [rbx + 0x118], eax
0107cb7a mov        eax, dword ptr [rdi + 0x34]
0107cb7d cmp        eax, 0x46494c45
0107cb82 jne        0x14107cbae
0107cb84 mov        eax, dword ptr [rbp + 0x5c]
0107cb87 mov        dword ptr [rdi + 0x2bc], eax
0107cb8d movzx      eax, word ptr [rbp + 0x9c]
0107cb94 mov        word ptr [rdi + 0x2c4], ax
0107cb9b movzx      eax, word ptr [rbp + 0x9e]
0107cba2 mov        word ptr [rdi + 0x2c6], ax
0107cba9 jmp        0x14107cc55
0107cbae cmp        eax, 0x53485244
0107cbb3 jne        0x14107cc55
0107cbb9 cmp        qword ptr [rbp + 0x2c0], 0
0107cbc1 jne        0x14107cbd0
0107cbc3 mov        eax, dword ptr [rbp + 0x28c]
0107cbc9 mov        qword ptr [rbp + 0x2c0], rax
0107cbd0 movzx      eax, byte ptr [rbp + 0x2ad]
0107cbd7 test       al, al
0107cbd9 mov        ecx, eax
0107cbdb mov        eax, 2
0107cbe0 cmove      ecx, eax
0107cbe3 mov        rax, qword ptr [rbp + 0x2c8]
0107cbea mov        byte ptr [rbp + 0x2ad], cl
0107cbf0 mov        qword ptr [rdi + 0x88], rax
0107cbf7 mov        rax, qword ptr [rbp + 0x2c0]
0107cbfe mov        qword ptr [rdi + 0x80], rax
0107cc05 movzx      eax, byte ptr [rbp + 0x2ad]
0107cc0c mov        dword ptr [rdi + 0x90], eax
0107cc12 mov        eax, dword ptr [rbp + 0x290]
0107cc18 mov        dword ptr [rdi + 0x98], eax
0107cc1e mov        eax, dword ptr [rbp + 0x294]
0107cc24 mov        dword ptr [rdi + 0x9c], eax
0107cc2a movzx      eax, byte ptr [rbp + 0x272]
0107cc31 mov        byte ptr [rdi + 0x94], al
0107cc37 movzx      eax, byte ptr [rbp + 0x273]
0107cc3e mov        byte ptr [rdi + 0x95], al
0107cc44 mov        byte ptr [rdi + 0x3c], 1
0107cc48 cmp        byte ptr [rbp + 0x29f], 0
0107cc4f je         0x14107cc55
0107cc51 mov        byte ptr [rdi + 0x3d], 1
0107cc55 cmp        byte ptr [rbp + 0x16b], 0
0107cc5c je         0x14107cc6d
0107cc5e mov        rcx, rdi
0107cc61 call       0x140fa61c0
0107cc66 mov        rax, qword ptr [rdi + 0x18]
0107cc6a or         byte ptr [rax], 0x10
0107cc6d mov        edx, dword ptr [rbp + 0x1cc]
0107cc73 mov        r8d, dword ptr [rbp + 0x1ac]
0107cc7a test       edx, edx
0107cc7c jne        0x14107cc9f
0107cc7e test       r8d, r8d
0107cc81 jne        0x14107cc9f
0107cc83 cmp        dword ptr [rbp + 0x1d0], edx
0107cc89 jne        0x14107cc9f
0107cc8b cmp        dword ptr [rbp + 0x1c4], edx
0107cc91 jne        0x14107cc9f
0107cc93 cmp        dword ptr [rbp + 0x1c8], edx
0107cc99 je         0x14107cd34
0107cc9f mov        rax, qword ptr [rbx + 0x70]
0107cca3 test       byte ptr [rax], 1
0107cca6 jne        0x14107cce2
0107cca8 mov        rcx, qword ptr [rbx + 0x10]
0107ccac test       rcx, rcx
0107ccaf je         0x14107cce2
0107ccb1 cmp        dword ptr [rcx + 0x80], 0x74646174
0107ccbb jne        0x14107cce2
0107ccbd mov        rcx, qword ptr [rcx + 0x140]
0107ccc4 call       0x140bc62b0
0107ccc9 mov        qword ptr [rbx + 0x70], rax
0107cccd test       rax, rax
0107ccd0 je         0x14107ccd5
0107ccd2 or         byte ptr [rax], 1
0107ccd5 mov        r8d, dword ptr [rbp + 0x1ac]
0107ccdc mov        edx, dword ptr [rbp + 0x1cc]
0107cce2 test       edx, edx
0107cce4 jne        0x14107cd06
0107cce6 cmp        r8d, 0x278d01
0107cced jb         0x14107cd06
0107ccef lea        edx, [r8 - 0x278d00]
0107ccf6 mov        dword ptr [rbp + 0x1d0], 0x278d00
0107cd00 mov        dword ptr [rbp + 0x1cc], edx
0107cd06 mov        rax, qword ptr [rbx + 0x70]
0107cd0a mov        dword ptr [rax + 0xc], edx
0107cd0d mov        rcx, qword ptr [rbx + 0x70]
0107cd11 mov        eax, dword ptr [rbp + 0x1d0]
0107cd17 mov        dword ptr [rcx + 0x10], eax
0107cd1a mov        rcx, qword ptr [rbx + 0x70]
0107cd1e mov        eax, dword ptr [rbp + 0x1c4]
0107cd24 mov        dword ptr [rcx + 0x14], eax
0107cd27 mov        rcx, qword ptr [rbx + 0x70]
0107cd2b mov        eax, dword ptr [rbp + 0x1c8]
0107cd31 mov        dword ptr [rcx + 0x18], eax
0107cd34 cmp        byte ptr [rbp + 0x316], 0
0107cd3b jne        0x14107cd4f
0107cd3d cmp        byte ptr [rbp + 0x317], 0
0107cd44 jne        0x14107cd4f
0107cd46 cmp        byte ptr [rbp + 0x318], 0
0107cd4d je         0x14107cdaf
0107cd4f mov        rax, qword ptr [rbx + 0x70]
0107cd53 test       byte ptr [rax], 1
0107cd56 jne        0x14107cd85
0107cd58 mov        rcx, qword ptr [rbx + 0x10]
0107cd5c test       rcx, rcx
0107cd5f je         0x14107cd85
0107cd61 cmp        dword ptr [rcx + 0x80], 0x74646174
0107cd6b jne        0x14107cd85
0107cd6d mov        rcx, qword ptr [rcx + 0x140]
0107cd74 call       0x140bc62b0
0107cd79 mov        qword ptr [rbx + 0x70], rax
0107cd7d test       rax, rax
0107cd80 je         0x14107cd85
0107cd82 or         byte ptr [rax], 1
0107cd85 mov        rcx, qword ptr [rbx + 0x70]
0107cd89 movzx      eax, byte ptr [rbp + 0x316]
0107cd90 mov        byte ptr [rcx + 0x20], al
0107cd93 mov        rcx, qword ptr [rbx + 0x70]
0107cd97 movzx      eax, byte ptr [rbp + 0x317]
0107cd9e mov        byte ptr [rcx + 0x21], al
0107cda1 mov        rcx, qword ptr [rbx + 0x70]
0107cda5 movzx      eax, byte ptr [rbp + 0x318]
0107cdac mov        byte ptr [rcx + 0x22], al
0107cdaf cmp        byte ptr [rbp + 0x1b1], 0
0107cdb6 jne        0x14107cdff
0107cdb8 cmp        byte ptr [rbp + 0x1b2], 0
0107cdbf jne        0x14107cdff
0107cdc1 cmp        word ptr [rbp + 0x1b4], 0
0107cdc9 jne        0x14107cdff
0107cdcb cmp        word ptr [rbp + 0x1b6], 0
0107cdd3 jne        0x14107cdff
0107cdd5 cmp        dword ptr [rbp + 0x1b8], 0
0107cddc jne        0x14107cdff
0107cdde cmp        word ptr [rbp + 0x1bc], 0
0107cde6 jne        0x14107cdff
0107cde8 cmp        word ptr [rbp + 0x1be], 0
0107cdf0 jne        0x14107cdff
0107cdf2 cmp        dword ptr [rbp + 0x1c0], 0
0107cdf9 je         0x14107ce90
0107cdff mov        rcx, rdi
0107ce02 call       0x140fa61c0
0107ce07 mov        rdx, qword ptr [rdi + 0x18]
0107ce0b movzx      ecx, byte ptr [rbp + 0x1b1]
0107ce12 and        cl, 1
0107ce15 add        cl, cl
0107ce17 movzx      eax, byte ptr [rdx]
0107ce1a and        al, 0xfd
0107ce1c or         cl, al
0107ce1e mov        byte ptr [rdx], cl
0107ce20 movzx      ecx, byte ptr [rbp + 0x1b2]
0107ce27 mov        rdx, qword ptr [rdi + 0x18]
0107ce2b and        cl, 1
0107ce2e shl        cl, 2
0107ce31 movzx      eax, byte ptr [rdx]
0107ce34 and        al, 0xfb
0107ce36 or         cl, al
0107ce38 mov        byte ptr [rdx], cl
0107ce3a movzx      eax, word ptr [rbp + 0x1b4]
0107ce41 mov        rcx, qword ptr [rdi + 0x18]
0107ce45 mov        word ptr [rcx + 2], ax
0107ce49 mov        rcx, qword ptr [rdi + 0x18]
0107ce4d movzx      eax, word ptr [rbp + 0x1b6]
0107ce54 mov        word ptr [rcx + 0xc], ax
0107ce58 mov        eax, dword ptr [rbp + 0x1b8]
0107ce5e mov        rcx, qword ptr [rdi + 0x18]
0107ce62 mov        dword ptr [rcx + 4], eax
0107ce65 movzx      eax, word ptr [rbp + 0x1bc]
0107ce6c mov        rcx, qword ptr [rdi + 0x18]
0107ce70 mov        word ptr [rcx + 0xe], ax
0107ce74 mov        rcx, qword ptr [rdi + 0x18]
0107ce78 movzx      eax, word ptr [rbp + 0x1be]
0107ce7f mov        word ptr [rcx + 0x10], ax
0107ce83 mov        rcx, qword ptr [rdi + 0x18]
0107ce87 mov        eax, dword ptr [rbp + 0x1c0]
0107ce8d mov        dword ptr [rcx + 8], eax
0107ce90 movzx      eax, byte ptr [rbx + 0x9d]
0107ce97 test       al, al
0107ce99 jns        0x14107ceaa
0107ce9b and        al, 0xf7
0107ce9d mov        byte ptr [rbx + 0x9d], al
0107cea3 and        byte ptr [rbx + 0x9a], 0xfd
0107ceaa movzx      eax, byte ptr [rbp + 0x18c]
0107ceb1 test       al, al
0107ceb3 je         0x14107cebd
0107ceb5 mov        byte ptr [rbx + 0x92], al
0107cebb jmp        0x14107cec2
0107cebd mov        byte ptr [rsp + 0x30], 1
0107cec2 movzx      eax, byte ptr [rbp + 0x18d]
0107cec9 test       al, al
0107cecb je         0x14107ced5
0107cecd mov        byte ptr [rbx + 0x93], al
0107ced3 jmp        0x14107ceda
0107ced5 mov        byte ptr [rsp + 0x30], 1
0107ceda movzx      eax, byte ptr [rbp + 0x18e]
0107cee1 test       al, al
0107cee3 je         0x14107ceed
0107cee5 mov        byte ptr [rbx + 0x94], al
0107ceeb jmp        0x14107cef2
0107ceed mov        byte ptr [rsp + 0x30], 1
0107cef2 movzx      eax, byte ptr [rbp + 0x18f]
0107cef9 test       al, al
0107cefb je         0x14107cf05
0107cefd mov        byte ptr [rbx + 0x95], al
0107cf03 jmp        0x14107cf0a
0107cf05 mov        byte ptr [rsp + 0x30], 1
0107cf0a movzx      eax, byte ptr [rbp + 0x190]
0107cf11 test       al, al
0107cf13 je         0x14107cf1d
0107cf15 mov        byte ptr [rbx + 0x96], al
0107cf1b jmp        0x14107cf22
0107cf1d mov        byte ptr [rsp + 0x30], 1
0107cf22 movzx      eax, byte ptr [rbp + 0x191]
0107cf29 test       al, al
0107cf2b je         0x14107cf35
0107cf2d mov        byte ptr [rbx + 0x97], al
0107cf33 jmp        0x14107cf3a
0107cf35 mov        byte ptr [rsp + 0x30], 1
0107cf3a lea        rcx, [r14 + 0x1e002a8]
0107cf41 lea        r9, [rbp - 8]
0107cf45 lea        r8, [rbp + 0x234]
0107cf4c lea        rdx, [rbp + 8]
0107cf50 call       0x140693570
0107cf55 cmp        dword ptr [rsp + 0x48], 1
0107cf5a jne        0x14107cf94
0107cf5c lea        rcx, [r14 + 0x1e00278]
0107cf63 lea        r9, [rsp + 0x50]
0107cf68 lea        r8, [rbp + 0x50]
0107cf6c lea        rdx, [rbp + 0x360]
0107cf73 call       0x140693570
0107cf78 lea        rcx, [r14 + 0x1e00290]
0107cf7f lea        r9, [rsp + 0x50]
0107cf84 lea        r8, [rbp + 0xc0]
0107cf8b lea        rdx, [rbp + 0x20]
0107cf8f call       0x140af68f0
0107cf94 xor        eax, eax
0107cf96 mov        dword ptr [rsp + 0x40], eax
0107cf9a cmp        dword ptr [rbp + 0x4c], eax
0107cf9d jbe        0x14107e513
0107cfa3 mov        r8d, 8
0107cfa9 mov        qword ptr [rbp - 8], r12
0107cfad lea        rdx, [rbp + 0x360]
0107cfb4 mov        rcx, r14
0107cfb7 call       0x1410770a0
0107cfbc mov        esi, eax
0107cfbe test       eax, eax
0107cfc0 jne        0x14107e706
0107cfc6 mov        r10d, dword ptr [rbp + 0x364]
0107cfcd mov        r15d, r10d
0107cfd0 cmp        byte ptr [r12], al
0107cfd4 jne        0x14107cfd9
0107cfd6 bswap      r15d
0107cfd9 mov        r13d, 0x18
0107cfdf lea        rcx, [rbp + 0x368]
0107cfe6 cmp        r15d, r13d
0107cfe9 cmovb      r13d, r15d
0107cfed cmp        r13d, 8
0107cff1 jbe        0x14107d031
0107cff3 lea        r12d, [r13 - 8]
0107cff7 cmp        r12, 0xa00000
0107cffe ja         0x14107e7a7
0107d004 mov        r8d, r12d
0107d007 lea        rdx, [rbp + 0x368]
0107d00e mov        rcx, r14
0107d011 call       0x1410770a0
0107d016 mov        esi, eax
0107d018 test       eax, eax
0107d01a jne        0x14107e706
0107d020 mov        r10d, dword ptr [rbp + 0x364]
0107d027 lea        rcx, [rbp + 0x368]
0107d02e add        rcx, r12
0107d031 cmp        r13d, 0x18
0107d035 jae        0x14107d053
0107d037 test       rcx, rcx
0107d03a je         0x14107d053
0107d03c mov        r8d, 0x18
0107d042 xor        edx, edx
0107d044 sub        r8d, r13d
0107d047 call       0x14179cca0
0107d04c mov        r10d, dword ptr [rbp + 0x364]
0107d053 cmp        r15d, r13d
0107d056 jbe        0x14107d070
0107d058 sub        r15d, r13d
0107d05b mov        rcx, r14
0107d05e mov        edx, r15d
0107d061 call       0x14106a520
0107d066 mov        esi, eax
0107d068 test       eax, eax
0107d06a jne        0x14107e706
0107d070 mov        rax, qword ptr [rbp - 8]
0107d074 mov        r12, rax
0107d077 cmp        byte ptr [rax], 0
0107d07a jne        0x14107d188
0107d080 mov        ecx, dword ptr [rbp + 0x360]
0107d086 mov        edx, ecx
0107d088 mov        eax, ecx
0107d08a and        edx, 0xff0000
0107d090 shr        eax, 0x10
0107d093 or         edx, eax
0107d095 mov        eax, ecx
0107d097 shl        eax, 0x10
0107d09a and        ecx, 0xff00
0107d0a0 or         eax, ecx
0107d0a2 shr        edx, 8
0107d0a5 shl        eax, 8
0107d0a8 mov        ecx, r10d
0107d0ab or         edx, eax
0107d0ad and        ecx, 0xff0000
0107d0b3 mov        eax, r10d
0107d0b6 mov        dword ptr [rbp + 0x360], edx
0107d0bc shr        eax, 0x10
0107d0bf or         ecx, eax
0107d0c1 mov        eax, r10d
0107d0c4 shl        eax, 0x10
0107d0c7 and        r10d, 0xff00
0107d0ce or         eax, r10d
0107d0d1 shr        ecx, 8
0107d0d4 shl        eax, 8
0107d0d7 mov        r10d, ecx
0107d0da mov        ecx, dword ptr [rbp + 0x368]
0107d0e0 or         r10d, eax
0107d0e3 mov        eax, ecx
0107d0e5 mov        dword ptr [rbp + 0x364], r10d
0107d0ec shr        eax, 0x10
0107d0ef mov        r15d, ecx
0107d0f2 and        r15d, 0xff0000
0107d0f9 or         r15d, eax
0107d0fc mov        eax, ecx
0107d0fe shl        eax, 0x10
0107d101 and        ecx, 0xff00
0107d107 or         eax, ecx
0107d109 shr        r15d, 8
0107d10d mov        ecx, dword ptr [rbp + 0x36c]
0107d113 mov        r8d, ecx
0107d116 shl        eax, 8
0107d119 and        r8d, 0xff0000
0107d120 or         r15d, eax
0107d123 mov        eax, ecx
0107d125 shr        eax, 0x10
0107d128 or         r8d, eax
0107d12b mov        dword ptr [rbp + 0x368], r15d
0107d132 mov        eax, ecx
0107d134 shr        r8d, 8
0107d138 shl        eax, 0x10
0107d13b and        ecx, 0xff00
0107d141 or         eax, ecx
0107d143 mov        ecx, dword ptr [rbp + 0x370]
0107d149 shl        eax, 8
0107d14c mov        r9d, ecx
0107d14f or         r8d, eax
0107d152 and        r9d, 0xff0000
0107d159 mov        eax, ecx
0107d15b mov        dword ptr [rbp + 0x36c], r8d
0107d162 shr        eax, 0x10
0107d165 or         r9d, eax
0107d168 mov        eax, ecx
0107d16a shl        eax, 0x10
0107d16d and        ecx, 0xff00
0107d173 or         eax, ecx
0107d175 shr        r9d, 8
0107d179 shl        eax, 8
0107d17c or         r9d, eax
0107d17f mov        dword ptr [rbp + 0x370], r9d
0107d186 jmp        0x14107d1a3
0107d188 mov        r9d, dword ptr [rbp + 0x370]
0107d18f mov        r8d, dword ptr [rbp + 0x36c]
0107d196 mov        r15d, dword ptr [rbp + 0x368]
0107d19d mov        edx, dword ptr [rbp + 0x360]
0107d1a3 cmp        edx, 0x686f686d
0107d1a9 jne        0x14107e7a7
0107d1af xor        r13d, r13d
0107d1b2 sub        r15d, r10d
0107d1b5 dec        r8d
0107d1b8 mov        esi, r13d
0107d1bb cmp        r8d, 0x41
0107d1bf ja         0x14107e4c7
0107d1c5 lea        rdx, [rip - 0x107d1cc]
0107d1cc mov        ecx, dword ptr [rdx + r8*4 + 0x107e7b4]
0107d1d4 add        rcx, rdx
0107d1d7 jmp        rcx
0107d1d9 mov        r8, qword ptr [rdi + 0x2c8]
0107d1e0 lea        rax, [rdi + 0x2b8]
0107d1e7 mov        dword ptr [rsp + 0x28], r13d
0107d1ec xor        r9d, r9d
0107d1ef mov        edx, 1
0107d1f4 mov        qword ptr [rsp + 0x20], rax
0107d1f9 mov        rcx, r14
0107d1fc call       0x1410773d0
0107d201 jmp        0x14107e3e1
0107d206 mov        r8, qword ptr [rsp + 0x38]
0107d20b lea        rax, [rbx + 0xb0]
0107d212 add        r8, 0x178
0107d219 mov        dword ptr [rsp + 0x28], r13d
0107d21e mov        edx, 1
0107d223 mov        qword ptr [rsp + 0x20], rax
0107d228 mov        rcx, r14
0107d22b call       0x1410773d0
0107d230 or         byte ptr [rbp + 0x340], 0x20
0107d237 jmp        0x14107e3e1
0107d23c mov        r8, qword ptr [rsp + 0x38]
0107d241 lea        rax, [rbx + 0xbc]
0107d248 add        r8, 0x1c0
0107d24f mov        dword ptr [rsp + 0x28], r13d
0107d254 mov        edx, 1
0107d259 mov        qword ptr [rsp + 0x20], rax
0107d25e mov        rcx, r14
0107d261 call       0x1410773d0
0107d266 or         byte ptr [rbp + 0x340], 0x10
0107d26d jmp        0x14107e3e1
0107d272 mov        r8, qword ptr [rsp + 0x38]
0107d277 lea        rax, [rbx + 0xc0]
0107d27e add        r8, 0x250
0107d285 mov        dword ptr [rsp + 0x28], r13d
0107d28a mov        edx, 1
0107d28f mov        qword ptr [rsp + 0x20], rax
0107d294 mov        rcx, r14
0107d297 call       0x1410773d0
0107d29c or         byte ptr [rbp + 0x344], 1
0107d2a3 jmp        0x14107e3e1
0107d2a8 mov        r8, qword ptr [rsp + 0x38]
0107d2ad lea        rax, [rbx + 0xb4]
0107d2b4 add        r8, 0x208
0107d2bb mov        dword ptr [rsp + 0x28], r13d
0107d2c0 mov        edx, 1
0107d2c5 mov        qword ptr [rsp + 0x20], rax
0107d2ca mov        rcx, r14
0107d2cd call       0x1410773d0
0107d2d2 or         byte ptr [rbp + 0x340], 8
0107d2d9 jmp        0x14107e3e1
0107d2de mov        r8, qword ptr [rsp + 0x38]
0107d2e3 lea        rax, [rbx + 0xb8]
0107d2ea add        r8, 0x208
0107d2f1 mov        dword ptr [rsp + 0x28], r13d
0107d2f6 mov        edx, 1
0107d2fb mov        qword ptr [rsp + 0x20], rax
0107d300 mov        rcx, r14
0107d303 call       0x1410773d0
0107d308 or         byte ptr [rbp + 0x348], 1
0107d30f jmp        0x14107e3e1
0107d314 mov        r8, qword ptr [rsp + 0x38]
0107d319 lea        rax, [rbx + 0xc4]
0107d320 add        r8, 0x208
0107d327 mov        dword ptr [rsp + 0x28], r13d
0107d32c mov        edx, 1
0107d331 mov        qword ptr [rsp + 0x20], rax
0107d336 mov        rcx, r14
0107d339 call       0x1410773d0
0107d33e or         byte ptr [rbp + 0x342], 0x20
0107d345 jmp        0x14107e3e1
0107d34a mov        r8, qword ptr [rsp + 0x38]
0107d34f lea        rax, [rbx + 0xc8]
0107d356 add        r8, 0x328
0107d35d mov        dword ptr [rsp + 0x28], r13d
0107d362 mov        edx, 1
0107d367 mov        qword ptr [rsp + 0x20], rax
0107d36c mov        rcx, r14
0107d36f call       0x1410773d0
0107d374 or         byte ptr [rbp + 0x341], 0x80
0107d37b jmp        0x14107e3e1
0107d380 mov        r8, qword ptr [rsp + 0x38]
0107d385 lea        rax, [rbx + 0xcc]
0107d38c add        r8, 0x370
0107d393 mov        dword ptr [rsp + 0x28], r13d
0107d398 mov        edx, 1
0107d39d mov        qword ptr [rsp + 0x20], rax
0107d3a2 mov        rcx, r14
0107d3a5 call       0x1410773d0
0107d3aa or         byte ptr [rbp + 0x341], 0x40
0107d3b1 jmp        0x14107e3e1
0107d3b6 mov        r13, qword ptr [rsp + 0x38]
0107d3bb lea        r15, [rbx + 0xd0]
0107d3c2 xor        eax, eax
0107d3c4 add        r13, 0x3b8
0107d3cb mov        dword ptr [rsp + 0x28], eax
0107d3cf mov        r8, r13
0107d3d2 xor        r9d, r9d
0107d3d5 mov        qword ptr [rsp + 0x20], r15
0107d3da mov        edx, 1
0107d3df mov        rcx, r14
0107d3e2 call       0x1410773d0
0107d3e7 mov        esi, eax
0107d3e9 test       eax, eax
0107d3eb jne        0x14107e706
0107d3f1 mov        edx, dword ptr [r15]
0107d3f4 lea        r8, [rbp + 0x3e0]
0107d3fb mov        rcx, r13
0107d3fe call       0x140bff470
0107d403 lea        rdx, [rbp + 0x3e0]
0107d40a lea        rcx, [rbp + 0x3e0]
0107d411 call       0x140eaa0b0
0107d416 test       al, al
0107d418 je         0x14107e4f7
0107d41e mov        r8, r15
0107d421 lea        rdx, [rbp + 0x3e0]
0107d428 mov        rcx, r13
0107d42b call       0x140bfed40
0107d430 or         byte ptr [rbp + 0x342], 0x40
0107d437 jmp        0x14107e3e1
0107d43c mov        r8, qword ptr [rsp + 0x38]
0107d441 lea        rax, [rbx + 0xd4]
0107d448 add        r8, 0x400
0107d44f mov        dword ptr [rsp + 0x28], r13d
0107d454 mov        edx, 1
0107d459 mov        qword ptr [rsp + 0x20], rax
0107d45e mov        rcx, r14
0107d461 call       0x1410773d0
0107d466 or         byte ptr [rbp + 0x341], 2
0107d46d jmp        0x14107e3e1
0107d472 mov        r8, qword ptr [rsp + 0x38]
0107d477 lea        rax, [rbx + 0xd8]
0107d47e add        r8, 0x448
0107d485 mov        dword ptr [rsp + 0x28], r13d
0107d48a mov        edx, 1
0107d48f mov        qword ptr [rsp + 0x20], rax
0107d494 mov        rcx, r14
0107d497 call       0x1410773d0
0107d49c or         byte ptr [rbp + 0x346], 1
0107d4a3 jmp        0x14107e3e1
0107d4a8 mov        r8, qword ptr [rsp + 0x38]
0107d4ad lea        rax, [rbx + 0xdc]
0107d4b4 add        r8, 0x490
0107d4bb mov        dword ptr [rsp + 0x28], r13d
0107d4c0 mov        edx, 1
0107d4c5 mov        qword ptr [rsp + 0x20], rax
0107d4ca mov        rcx, r14
0107d4cd call       0x1410773d0
0107d4d2 or         byte ptr [rbp + 0x342], 4
0107d4d9 jmp        0x14107e3e1
0107d4de mov        rcx, rbx
0107d4e1 call       0x140f92f00
0107d4e6 mov        rax, qword ptr [rbx + 0x68]
0107d4ea mov        edx, 1
0107d4ef mov        r8, qword ptr [rsp + 0x38]
0107d4f4 add        rax, 0x34
0107d4f8 mov        r9d, dword ptr [rbp + 0x370]
0107d4ff add        r8, 0x520
0107d506 mov        dword ptr [rsp + 0x28], r13d
0107d50b mov        rcx, r14
0107d50e mov        qword ptr [rsp + 0x20], rax
0107d513 call       0x1410773d0
0107d518 or         byte ptr [rbp + 0x346], 2
0107d51f jmp        0x14107e3e1
0107d524 mov        rcx, rbx
0107d527 call       0x140f92f00
0107d52c mov        rax, qword ptr [rbx + 0x68]
0107d530 mov        edx, 1
0107d535 mov        r8, qword ptr [rsp + 0x38]
0107d53a add        rax, 0x38
0107d53e mov        r9d, dword ptr [rbp + 0x370]
0107d545 add        r8, 0x520
0107d54c mov        dword ptr [rsp + 0x28], r13d
0107d551 mov        rcx, r14
0107d554 mov        qword ptr [rsp + 0x20], rax
0107d559 call       0x1410773d0
0107d55e or         byte ptr [rbp + 0x34a], 2
0107d565 jmp        0x14107e3e1
0107d56a mov        rcx, rbx
0107d56d call       0x140f92f00
0107d572 mov        rax, qword ptr [rbx + 0x68]
0107d576 mov        edx, 1
0107d57b mov        r8, qword ptr [rsp + 0x38]
0107d580 add        rax, 0x3c
0107d584 mov        r9d, dword ptr [rbp + 0x370]
0107d58b add        r8, 0x520
0107d592 mov        dword ptr [rsp + 0x28], r13d
0107d597 mov        rcx, r14
0107d59a mov        qword ptr [rsp + 0x20], rax
0107d59f call       0x1410773d0
0107d5a4 or         byte ptr [rbp + 0x34f], 1
0107d5ab jmp        0x14107e3e1
0107d5b0 mov        rcx, rbx
0107d5b3 call       0x140f92f70
0107d5b8 mov        rax, qword ptr [rbx + 0x70]
0107d5bc mov        edx, 1
0107d5c1 mov        r8, qword ptr [rsp + 0x38]
0107d5c6 add        rax, 0x28
0107d5ca mov        r9d, dword ptr [rbp + 0x370]
0107d5d1 add        r8, 0x640
0107d5d8 mov        dword ptr [rsp + 0x28], r13d
0107d5dd mov        rcx, r14
0107d5e0 mov        qword ptr [rsp + 0x20], rax
0107d5e5 call       0x1410773d0
0107d5ea or         byte ptr [rbp + 0x347], 2
0107d5f1 jmp        0x14107e3e1
0107d5f6 mov        rcx, rbx
0107d5f9 call       0x140f92f70
0107d5fe mov        rax, qword ptr [rbx + 0x70]
0107d602 mov        edx, 1
0107d607 mov        r8, qword ptr [rsp + 0x38]
0107d60c add        rax, 0x2c
0107d610 mov        r9d, dword ptr [rbp + 0x370]
0107d617 add        r8, 0x6d0
0107d61e mov        dword ptr [rsp + 0x28], r13d
0107d623 mov        rcx, r14
0107d626 mov        qword ptr [rsp + 0x20], rax
0107d62b call       0x1410773d0
0107d630 or         byte ptr [rbp + 0x348], 0x80
0107d637 jmp        0x14107e3e1
0107d63c mov        rcx, rbx
0107d63f call       0x140f92f70
0107d644 mov        rax, qword ptr [rbx + 0x70]
0107d648 mov        edx, 1
0107d64d mov        r8, qword ptr [rsp + 0x38]
0107d652 add        rax, 0x30
0107d656 mov        r9d, dword ptr [rbp + 0x370]
0107d65d add        r8, 0x6d0
0107d664 mov        dword ptr [rsp + 0x28], r13d
0107d669 mov        rcx, r14
0107d66c mov        qword ptr [rsp + 0x20], rax
0107d671 call       0x1410773d0
0107d676 or         byte ptr [rbp + 0x355], 0x80
0107d67d jmp        0x14107e3e1
0107d682 mov        rcx, rbx
0107d685 call       0x140f92f00
0107d68a cmp        r15d, 0xa00000
0107d691 ja         0x14107e7a7
0107d697 mov        r8d, r15d
0107d69a lea        rdx, [r14 + 0xa00128]
0107d6a1 mov        rcx, r14
0107d6a4 call       0x1410770a0
0107d6a9 mov        esi, eax
0107d6ab test       eax, eax
0107d6ad jne        0x14107e706
0107d6b3 mov        r9, qword ptr [rbx + 0x68]
0107d6b7 lea        rdx, [r14 + 0xa00128]
0107d6be mov        rcx, qword ptr [rsp + 0x38]
0107d6c3 add        r9, 0x20
0107d6c7 add        rcx, 0x568
0107d6ce mov        r8d, r15d
0107d6d1 call       0x140bfe1f0
0107d6d6 mov        esi, eax
0107d6d8 test       eax, eax
0107d6da jne        0x14107e706
0107d6e0 or         byte ptr [rbp + 0x34a], 1
0107d6e7 jmp        0x14107e4f7
0107d6ec mov        rcx, rbx
0107d6ef call       0x140f92f00
0107d6f4 mov        rax, qword ptr [rbx + 0x68]
0107d6f8 xor        edx, edx
0107d6fa mov        r8, qword ptr [rsp + 0x38]
0107d6ff add        rax, 0x24
0107d703 mov        r9d, dword ptr [rbp + 0x370]
0107d70a add        r8, 0x5b0
0107d711 mov        dword ptr [rsp + 0x28], 1
0107d719 mov        rcx, r14
0107d71c mov        qword ptr [rsp + 0x20], rax
0107d721 call       0x1410773d0
0107d726 or         byte ptr [rbp + 0x34a], 4
0107d72d jmp        0x14107e3e1
0107d732 mov        rcx, rbx
0107d735 call       0x140f92f00
0107d73a mov        rax, qword ptr [rbx + 0x68]
0107d73e xor        edx, edx
0107d740 mov        r8, qword ptr [rsp + 0x38]
0107d745 add        rax, 0x28
0107d749 mov        r9d, dword ptr [rbp + 0x370]
0107d750 add        r8, 0x5b0
0107d757 mov        dword ptr [rsp + 0x28], r13d
0107d75c mov        rcx, r14
0107d75f mov        qword ptr [rsp + 0x20], rax
0107d764 call       0x1410773d0
0107d769 or         byte ptr [rbp + 0x34a], 4
0107d770 jmp        0x14107e3e1
0107d775 mov        rcx, rbx
0107d778 call       0x140f92f00
0107d77d mov        rax, qword ptr [rbx + 0x68]
0107d781 xor        edx, edx
0107d783 mov        r8, qword ptr [rsp + 0x38]
0107d788 add        rax, 0x2c
0107d78c mov        r9d, dword ptr [rbp + 0x370]
0107d793 add        r8, 0x5f8
0107d79a mov        dword ptr [rsp + 0x28], 1
0107d7a2 mov        rcx, r14
0107d7a5 mov        qword ptr [rsp + 0x20], rax
0107d7aa call       0x1410773d0
0107d7af jmp        0x14107e3e1
0107d7b4 mov        rcx, rbx
0107d7b7 call       0x140f92f00
0107d7bc mov        r8, qword ptr [rsp + 0x38]
0107d7c1 lea        rax, [rbp - 0x10]
0107d7c5 mov        r9d, dword ptr [rbp + 0x370]
0107d7cc add        r8, 0x5b0
0107d7d3 mov        dword ptr [rsp + 0x28], r13d
0107d7d8 xor        edx, edx
0107d7da mov        rcx, r14
0107d7dd mov        qword ptr [rsp + 0x20], rax
0107d7e2 call       0x1410773d0
0107d7e7 jmp        0x14107e3e1
0107d7ec mov        rcx, rbx
0107d7ef call       0x140f92f70
0107d7f4 mov        rax, qword ptr [rbx + 0x70]
0107d7f8 mov        edx, 2
0107d7fd mov        r8, qword ptr [rsp + 0x38]
0107d802 add        rax, 0x24
0107d806 mov        r9d, dword ptr [rbp + 0x370]
0107d80d add        r8, 0x760
0107d814 mov        dword ptr [rsp + 0x28], r13d
0107d819 mov        rcx, r14
0107d81c mov        qword ptr [rsp + 0x20], rax
0107d821 call       0x1410773d0
0107d826 or         byte ptr [rbp + 0x34a], 8
0107d82d jmp        0x14107e3e1
0107d832 mov        rcx, qword ptr [rbx + 0x10]
0107d836 lea        rdx, [rbx + 0x160]
0107d83d xor        eax, eax
0107d83f mov        dword ptr [rsp + 0x60], r13d
0107d844 mov        qword ptr [rbp - 0x80], rax
0107d848 xorps      xmm0, xmm0
0107d84b mov        dword ptr [rbp - 0x54], eax
0107d84e xor        r8d, r8d
0107d851 mov        qword ptr [rbp - 0x20], rax
0107d855 lea        rax, [rip - 0x1c57bc]
0107d85c movaps     xmmword ptr [rbp - 0x70], xmm0
0107d860 movdqa     xmm0, xmmword ptr [rip + 0xbf7598]
0107d868 mov        qword ptr [rsp + 0x70], rax
0107d86d lea        rax, [rbx + 0x92]
0107d874 movdqa     xmmword ptr [rbp - 0x50], xmm0
0107d879 movdqa     xmm0, xmmword ptr [rip + 0xbf75df]
0107d881 mov        qword ptr [rbp - 0x78], rax
0107d885 mov        eax, dword ptr [rdx]
0107d887 mov        dword ptr [rbp - 0x58], eax
0107d88a mov        eax, 2
0107d88f movdqa     xmmword ptr [rbp - 0x40], xmm0
0107d894 movdqa     xmm0, xmmword ptr [rip + 0xbf7484]
0107d89c mov        dword ptr [rsp + 0x64], eax
0107d8a0 mov        qword ptr [rbp - 0x60], r8
0107d8a4 mov        qword ptr [rsp + 0x78], rbx
0107d8a9 mov        dword ptr [rsp + 0x68], 0x4e
0107d8b1 mov        dword ptr [rsp + 0x6c], 0x1e
0107d8b9 movdqa     xmmword ptr [rbp - 0x30], xmm0
0107d8be test       rcx, rcx
0107d8c1 je         0x14107d8ef
0107d8c3 lea        rax, [rbx + 0xa1]
0107d8ca mov        qword ptr [rbp - 0x80], rax
0107d8ce lea        r8, [rcx + 0x1768]
0107d8d5 lea        rax, [rcx + 0x178]
0107d8dc mov        qword ptr [rbp - 0x60], r8
0107d8e0 mov        qword ptr [rbp - 0x70], rax
0107d8e4 lea        rax, [rbx + 0xb0]
0107d8eb mov        qword ptr [rbp - 0x68], rax
0107d8ef mov        dword ptr [rsp + 0x28], r13d
0107d8f4 mov        rcx, r14
0107d8f7 mov        qword ptr [rsp + 0x20], rdx
0107d8fc mov        edx, 1
0107d901 call       0x1410773d0
0107d906 or         byte ptr [rbp + 0x349], 2
0107d90d jmp        0x14107e3e1
0107d912 mov        rcx, qword ptr [rbx + 0x10]
0107d916 lea        rdx, [rbx + 0x164]
0107d91d xor        eax, eax
0107d91f mov        qword ptr [rsp + 0x78], rbx
0107d924 xorps      xmm0, xmm0
0107d927 mov        qword ptr [rbp - 0x80], rax
0107d92b movaps     xmmword ptr [rbp - 0x70], xmm0
0107d92f xor        r8d, r8d
0107d932 movdqa     xmm0, xmmword ptr [rip + 0xbf74d6]
0107d93a mov        r10d, 1
0107d940 mov        dword ptr [rbp - 0x54], eax
0107d943 mov        qword ptr [rbp - 0x20], rax
0107d947 lea        rax, [rip - 0x1c58ae]
0107d94e movdqa     xmmword ptr [rbp - 0x50], xmm0
0107d953 movdqa     xmm0, xmmword ptr [rip + 0xbf7515]
0107d95b mov        qword ptr [rsp + 0x70], rax
0107d960 lea        rax, [rbx + 0x93]
0107d967 movdqa     xmmword ptr [rbp - 0x40], xmm0
0107d96c movdqa     xmm0, xmmword ptr [rip + 0xbf73cc]
0107d974 mov        qword ptr [rbp - 0x78], rax
0107d978 mov        eax, dword ptr [rdx]
0107d97a movdqa     xmmword ptr [rbp - 0x30], xmm0
0107d97f mov        qword ptr [rbp - 0x60], r8
0107d983 mov        dword ptr [rsp + 0x60], r10d
0107d988 mov        dword ptr [rbp - 0x58], eax
0107d98b mov        dword ptr [rsp + 0x64], 3
0107d993 mov        dword ptr [rsp + 0x68], 0x4f
0107d99b mov        dword ptr [rsp + 0x6c], 0x1f
0107d9a3 test       rcx, rcx
0107d9a6 je         0x14107d9d4
0107d9a8 lea        rax, [rbx + 0xa3]
0107d9af mov        qword ptr [rbp - 0x80], rax
0107d9b3 lea        r8, [rcx + 0x17b0]
0107d9ba lea        rax, [rcx + 0x1c0]
0107d9c1 mov        qword ptr [rbp - 0x60], r8
0107d9c5 mov        qword ptr [rbp - 0x70], rax
0107d9c9 lea        rax, [rbx + 0xbc]
0107d9d0 mov        qword ptr [rbp - 0x68], rax
0107d9d4 mov        dword ptr [rsp + 0x28], r13d
0107d9d9 mov        rcx, r14
0107d9dc mov        qword ptr [rsp + 0x20], rdx
0107d9e1 mov        edx, r10d
0107d9e4 call       0x1410773d0
0107d9e9 or         byte ptr [rbp + 0x349], 1
0107d9f0 jmp        0x14107e3e1
0107d9f5 mov        rcx, qword ptr [rbx + 0x10]
0107d9f9 lea        rdx, [rbx + 0x168]
0107da00 xor        eax, eax
0107da02 mov        qword ptr [rsp + 0x78], rbx
0107da07 mov        qword ptr [rbp - 0x80], rax
0107da0b xorps      xmm0, xmm0
0107da0e mov        dword ptr [rbp - 0x54], eax
0107da11 xor        r8d, r8d
0107da14 mov        qword ptr [rbp - 0x20], rax
0107da18 mov        eax, 2
0107da1d mov        dword ptr [rsp + 0x60], eax
0107da21 lea        rax, [rip - 0x1c5988]
0107da28 mov        qword ptr [rsp + 0x70], rax
0107da2d lea        rax, [rbx + 0x94]
0107da34 movaps     xmmword ptr [rbp - 0x70], xmm0
0107da38 movdqa     xmm0, xmmword ptr [rip + 0xbf73e0]
0107da40 mov        qword ptr [rbp - 0x78], rax
0107da44 mov        eax, dword ptr [rdx]
0107da46 mov        dword ptr [rbp - 0x58], eax
0107da49 mov        qword ptr [rbp - 0x60], r8
0107da4d mov        dword ptr [rsp + 0x64], 4
0107da55 mov        dword ptr [rsp + 0x68], 0x50
0107da5d mov        dword ptr [rsp + 0x6c], 0x20
0107da65 movdqa     xmmword ptr [rbp - 0x50], xmm0
0107da6a movdqa     xmmword ptr [rbp - 0x40], xmm15
0107da70 movdqa     xmmword ptr [rbp - 0x30], xmm14
0107da76 test       rcx, rcx
0107da79 je         0x14107daa7
0107da7b lea        rax, [rbx + 0xa2]
0107da82 mov        qword ptr [rbp - 0x80], rax
0107da86 lea        r8, [rcx + 0x17f8]
0107da8d lea        rax, [rcx + 0x208]
0107da94 mov        qword ptr [rbp - 0x60], r8
0107da98 mov        qword ptr [rbp - 0x70], rax
0107da9c lea        rax, [rbx + 0xb4]
0107daa3 mov        qword ptr [rbp - 0x68], rax
0107daa7 mov        dword ptr [rsp + 0x28], r13d
0107daac mov        rcx, r14
0107daaf mov        qword ptr [rsp + 0x20], rdx
0107dab4 mov        edx, 1
0107dab9 call       0x1410773d0
0107dabe or         byte ptr [rbp + 0x34a], 0x80
0107dac5 jmp        0x14107e3e1
0107daca mov        rcx, qword ptr [rbx + 0x10]
0107dace lea        rdx, [rbx + 0x16c]
0107dad5 xor        eax, eax
0107dad7 mov        dword ptr [rsp + 0x60], 3
0107dadf mov        qword ptr [rbp - 0x80], rax
0107dae3 xor        r8d, r8d
0107dae6 mov        dword ptr [rbp - 0x54], eax
0107dae9 xorps      xmm0, xmm0
0107daec mov        qword ptr [rbp - 0x20], rax
0107daf0 lea        rax, [rip - 0x1c5a57]
0107daf7 mov        qword ptr [rsp + 0x70], rax
0107dafc lea        rax, [rbx + 0x95]
0107db03 mov        qword ptr [rbp - 0x78], rax
0107db07 mov        eax, dword ptr [rdx]
0107db09 mov        dword ptr [rbp - 0x58], eax
0107db0c movaps     xmmword ptr [rbp - 0x70], xmm0
0107db10 mov        qword ptr [rbp - 0x60], r8
0107db14 mov        qword ptr [rsp + 0x78], rbx
0107db19 mov        dword ptr [rsp + 0x64], 0x47
0107db21 mov        dword ptr [rsp + 0x68], 0x51
0107db29 mov        dword ptr [rsp + 0x6c], 0x21
0107db31 movdqa     xmmword ptr [rbp - 0x50], xmm13
0107db37 movdqa     xmmword ptr [rbp - 0x40], xmm12
0107db3d movdqa     xmmword ptr [rbp - 0x30], xmm11
0107db43 test       rcx, rcx
0107db46 je         0x14107db69
0107db48 lea        rax, [rcx + 0x208]
0107db4f mov        qword ptr [rbp - 0x70], rax
0107db53 lea        r8, [rcx + 0x17f8]
0107db5a lea        rax, [rbx + 0xb8]
0107db61 mov        qword ptr [rbp - 0x60], r8
0107db65 mov        qword ptr [rbp - 0x68], rax
0107db69 mov        dword ptr [rsp + 0x28], r13d
0107db6e mov        rcx, r14
0107db71 mov        qword ptr [rsp + 0x20], rdx
0107db76 mov        edx, 1
0107db7b call       0x1410773d0
0107db80 or         byte ptr [rbp + 0x34a], 0x40
0107db87 jmp        0x14107e3e1
0107db8c mov        rcx, qword ptr [rbx + 0x10]
0107db90 lea        rdx, [rbx + 0x170]
0107db97 xor        eax, eax
0107db99 mov        dword ptr [rsp + 0x60], 4
0107dba1 mov        qword ptr [rbp - 0x80], rax
0107dba5 xor        r8d, r8d
0107dba8 mov        dword ptr [rbp - 0x54], eax
0107dbab xorps      xmm0, xmm0
0107dbae mov        qword ptr [rbp - 0x20], rax
0107dbb2 lea        rax, [rip - 0x1c5b19]
0107dbb9 mov        qword ptr [rsp + 0x70], rax
0107dbbe lea        rax, [rbx + 0x96]
0107dbc5 mov        qword ptr [rbp - 0x78], rax
0107dbc9 mov        eax, dword ptr [rdx]
0107dbcb mov        dword ptr [rbp - 0x58], eax
0107dbce movaps     xmmword ptr [rbp - 0x70], xmm0
0107dbd2 mov        qword ptr [rbp - 0x60], r8
0107dbd6 mov        qword ptr [rsp + 0x78], rbx
0107dbdb mov        dword ptr [rsp + 0x64], 0x12
0107dbe3 mov        dword ptr [rsp + 0x68], 0x52
0107dbeb mov        dword ptr [rsp + 0x6c], 0x22
0107dbf3 movdqa     xmmword ptr [rbp - 0x50], xmm10
0107dbf9 movdqa     xmmword ptr [rbp - 0x40], xmm9
0107dbff movdqa     xmmword ptr [rbp - 0x30], xmm8
0107dc05 test       rcx, rcx
0107dc08 je         0x14107dc2b
0107dc0a lea        rax, [rcx + 0x208]
0107dc11 mov        qword ptr [rbp - 0x70], rax
0107dc15 lea        r8, [rcx + 0x17f8]
0107dc1c lea        rax, [rbx + 0xc4]
0107dc23 mov        qword ptr [rbp - 0x60], r8
0107dc27 mov        qword ptr [rbp - 0x68], rax
0107dc2b mov        dword ptr [rsp + 0x28], r13d
0107dc30 mov        rcx, r14
0107dc33 mov        qword ptr [rsp + 0x20], rdx
0107dc38 mov        edx, 1
0107dc3d call       0x1410773d0
0107dc42 or         byte ptr [rbp + 0x34a], 0x20
0107dc49 jmp        0x14107e3e1
0107dc4e lea        r8, [rsp + 0x60]
0107dc53 mov        edx, 5
0107dc58 mov        rcx, rbx
0107dc5b call       0x140eb8130
0107dc60 mov        r8d, dword ptr [rsp + 0x60]
0107dc65 mov        edx, 1
0107dc6a mov        r9d, dword ptr [rbp + 0x370]
0107dc71 add        r8, 0x58
0107dc75 mov        dword ptr [rsp + 0x28], r13d
0107dc7a mov        rcx, r14
0107dc7d lea        rax, [rbx + r8*4]
0107dc81 mov        r8, qword ptr [rbp - 0x60]
0107dc85 mov        qword ptr [rsp + 0x20], rax
0107dc8a call       0x1410773d0
0107dc8f mov        ecx, dword ptr [rsp + 0x68]
0107dc93 mov        esi, eax
0107dc95 cmp        ecx, 0x100
0107dc9b jge        0x14107e3e3
0107dca1 test       ecx, ecx
0107dca3 je         0x14107e3e3
0107dca9 mov        edx, ecx
0107dcab mov        eax, 0x80
0107dcb0 and        ecx, 7
0107dcb3 shr        rdx, 3
0107dcb7 sar        eax, cl
0107dcb9 or         byte ptr [rbp + rdx + 0x340], al
0107dcc0 jmp        0x14107e3e3
0107dcc5 xor        eax, eax
0107dcc7 mov        rcx, rbx
0107dcca mov        qword ptr [rsp + 0x58], rax
0107dccf call       0x140f92f00
0107dcd4 cmp        r15d, 0xa00000
0107dcdb jbe        0x14107dcf9
0107dcdd mov        ecx, r15d
0107dce0 mov        edx, 0x10
0107dce5 call       qword ptr [rip + 0x86e685]
0107dceb mov        r13, rax
0107dcee test       rax, rax
0107dcf1 je         0x14107e4f7
0107dcf7 jmp        0x14107dd00
0107dcf9 lea        rax, [r14 + 0xa00128]
0107dd00 mov        r8d, r15d
0107dd03 mov        rdx, rax
0107dd06 mov        rcx, r14
0107dd09 mov        qword ptr [rsp + 0x50], rax
0107dd0e call       0x1410770a0
0107dd13 mov        esi, eax
0107dd15 test       eax, eax
0107dd17 jne        0x14107e706
0107dd1d mov        rdx, qword ptr [rsp + 0x50]
0107dd22 lea        r8, [rsp + 0x58]
0107dd27 mov        ecx, r15d
0107dd2a call       0x140bdde70
0107dd2f mov        esi, eax
0107dd31 test       r13, r13
0107dd34 je         0x14107dd3f
0107dd36 mov        rcx, r13
0107dd39 call       qword ptr [rip + 0x86e629]
0107dd3f test       esi, esi
0107dd41 jne        0x14107ddd5
0107dd47 mov        rsi, qword ptr [rsp + 0x58]
0107dd4c mov        rcx, rdi
0107dd4f mov        rdx, rsi
0107dd52 call       0x140fa9260
0107dd57 test       rsi, rsi
0107dd5a je         0x14107ddce
0107dd5c cmp        dword ptr [rsi], 0x63687064
0107dd62 jne        0x14107ddce
0107dd64 sub        dword ptr [rsi + 4], 1
0107dd68 jne        0x14107ddce
0107dd6a mov        rcx, qword ptr [rsi + 0x20]
0107dd6e call       0x140bde1f0
0107dd73 mov        rcx, qword ptr [rsi + 0x18]
0107dd77 call       0x140bf78c0
0107dd7c mov        rcx, qword ptr [rsi + 0x20]
0107dd80 call       0x140bf78c0
0107dd85 mov        rcx, qword ptr [rsi + 0x28]
0107dd89 test       rcx, rcx
0107dd8c je         0x14107dd94
0107dd8e call       qword ptr [rip + 0x86e5d4]
0107dd94 mov        rcx, qword ptr [rsi + 0x30]
0107dd98 test       rcx, rcx
0107dd9b je         0x14107dda3
0107dd9d call       qword ptr [rip + 0x86e5c5]
0107dda3 mov        rcx, qword ptr [rsi + 0x38]
0107dda7 test       rcx, rcx
0107ddaa je         0x14107ddb2
0107ddac call       qword ptr [rip + 0x86e5b6]
0107ddb2 mov        rcx, qword ptr [rsi + 0x58]
0107ddb6 test       rcx, rcx
0107ddb9 je         0x14107ddc1
0107ddbb call       qword ptr [rip + 0x86b05f]
0107ddc1 xor        eax, eax
0107ddc3 mov        rcx, rsi
0107ddc6 mov        dword ptr [rsi], eax
0107ddc8 call       qword ptr [rip + 0x86e59a]
0107ddce or         byte ptr [rbp + 0x34b], 0x80
0107ddd5 xor        eax, eax
0107ddd7 mov        esi, eax
0107ddd9 jmp        0x14107e4f7
0107ddde test       byte ptr [rbx + 0x9b], 8
0107dde5 jne        0x14107de4b
0107dde7 cmp        byte ptr [rbx + 0x9d], sil
0107ddee jge        0x14107de98
0107ddf4 cmp        qword ptr [rbx + 0x10], rsi
0107ddf8 je         0x14107de98
0107ddfe test       byte ptr [rbx + 0x9a], 1
0107de05 je         0x14107de98
0107de0b mov        rax, qword ptr [rbx + 0x68]
0107de0f mov        ecx, dword ptr [rax + 0x10]
0107de12 test       ecx, ecx
0107de14 jne        0x14107de43
0107de16 cmp        dword ptr [rbx + 0xac], esi
0107de1c jne        0x14107de3d
0107de1e mov        rcx, rbx
0107de21 call       0x140f91240
0107de26 mov        dword ptr [rbx + 0xac], eax
0107de2c test       eax, eax
0107de2e je         0x14107de3d
0107de30 mov        edx, 0x3c
0107de35 mov        rcx, rbx
0107de38 call       0x140f94100
0107de3d mov        ecx, dword ptr [rbx + 0xac]
0107de43 test       ecx, 0x200004
0107de49 je         0x14107de98
0107de4b cmp        dword ptr [rdi + 0x34], 0x48545450
0107de52 jne        0x14107de98
0107de54 mov        rcx, rbx
0107de57 call       0x140f92f00
0107de5c mov        rax, qword ptr [rbx + 0x68]
0107de60 xor        r9d, r9d
0107de63 mov        r8, qword ptr [rsp + 0x38]
0107de68 add        rax, 0x48
0107de6c add        r8, 0x4d8
0107de73 mov        dword ptr [rsp + 0x28], r13d
0107de78 mov        edx, 1
0107de7d mov        qword ptr [rsp + 0x20], rax
0107de82 mov        rcx, r14
0107de85 call       0x1410773d0
0107de8a or         byte ptr [rbp + 0x343], 0x20
0107de91 mov        esi, eax
0107de93 jmp        0x14107e3e3
0107de98 mov        rcx, qword ptr [r14 + 0x1e00178]
0107de9f movsxd     rdx, r15d
0107dea2 add        rdx, qword ptr [r14 + 0x1e00170]
0107dea9 mov        qword ptr [r14 + 0x1e00170], rdx
0107deb0 cmp        rdx, rcx
0107deb3 jb         0x14107dec1
0107deb5 add        rcx, qword ptr [r14 + 0x1e00180]
0107debc cmp        rdx, rcx
0107debf jb         0x14107dec8
0107dec1 mov        qword ptr [r14 + 0x1e00180], r13
0107dec8 or         byte ptr [rbp + 0x343], 0x20
0107decf jmp        0x14107e3e3
0107ded4 test       byte ptr [rbx + 0x9b], 8
0107dedb je         0x14107e4c7
0107dee1 mov        rcx, rbx
0107dee4 call       0x140f92f00
0107dee9 mov        rax, qword ptr [rbx + 0x68]
0107deed xor        r9d, r9d
0107def0 mov        r8, qword ptr [rsp + 0x38]
0107def5 add        rax, 0x44
0107def9 add        r8, 0x4d8
0107df00 mov        dword ptr [rsp + 0x28], r13d
0107df05 mov        edx, 1
0107df0a mov        qword ptr [rsp + 0x20], rax
0107df0f mov        rcx, r14
0107df12 call       0x1410773d0
0107df17 jmp        0x14107e3e1
0107df1c mov        eax, dword ptr [rdi + 0x34]
0107df1f cmp        eax, 0x46494c45
0107df24 jne        0x14107df5c
0107df26 mov        r8, qword ptr [rdi + 0x2c8]
0107df2d lea        rax, [rdi + 0x2c0]
0107df34 mov        dword ptr [rsp + 0x28], r13d
0107df39 xor        r9d, r9d
0107df3c mov        edx, 5
0107df41 mov        qword ptr [rsp + 0x20], rax
0107df46 mov        rcx, r14
0107df49 call       0x1410773d0
0107df4e or         byte ptr [rbp + 0x341], 1
0107df55 mov        esi, eax
0107df57 jmp        0x14107e3e3
0107df5c cmp        eax, 0x48545450
0107df61 jne        0x14107df96
0107df63 mov        r8, qword ptr [rdi + 0x2c8]
0107df6a lea        rax, [rdi + 0x2b8]
0107df71 mov        dword ptr [rsp + 0x28], r13d
0107df76 xor        r9d, r9d
0107df79 xor        edx, edx
0107df7b mov        qword ptr [rsp + 0x20], rax
0107df80 mov        rcx, r14
0107df83 call       0x1410773d0
0107df88 or         byte ptr [rbp + 0x341], 1
0107df8f mov        esi, eax
0107df91 jmp        0x14107e3e3
0107df96 mov        rcx, qword ptr [r14 + 0x1e00178]
0107df9d movsxd     rdx, r15d
0107dfa0 add        rdx, qword ptr [r14 + 0x1e00170]
0107dfa7 mov        qword ptr [r14 + 0x1e00170], rdx
0107dfae cmp        rdx, rcx
0107dfb1 jb         0x14107dfbf
0107dfb3 add        rcx, qword ptr [r14 + 0x1e00180]
0107dfba cmp        rdx, rcx
0107dfbd jb         0x14107dfc6
0107dfbf mov        qword ptr [r14 + 0x1e00180], r13
0107dfc6 or         byte ptr [rbp + 0x341], 1
0107dfcd jmp        0x14107e3e3
0107dfd2 cmp        dword ptr [rdi + 0x34], 0x48545450
0107dfd9 jne        0x14107e4c7
0107dfdf mov        r8, qword ptr [rdi + 0x2c8]
0107dfe6 lea        rax, [rdi + 0x2bc]
0107dfed mov        dword ptr [rsp + 0x28], r13d
0107dff2 xor        r9d, r9d
0107dff5 xor        edx, edx
0107dff7 mov        qword ptr [rsp + 0x20], rax
0107dffc mov        rcx, r14
0107dfff call       0x1410773d0
0107e004 or         byte ptr [rbp + 0x341], 1
0107e00b jmp        0x14107e3e1
0107e010 mov        rcx, rbx
0107e013 call       0x140f92f00
0107e018 mov        rax, qword ptr [rbx + 0x68]
0107e01c mov        edx, 1
0107e021 mov        r8, qword ptr [rsp + 0x38]
0107e026 add        rax, 0x30
0107e02a mov        r9d, dword ptr [rbp + 0x370]
0107e031 add        r8, 0x718
0107e038 mov        dword ptr [rsp + 0x28], r13d
0107e03d mov        rcx, r14
0107e040 mov        qword ptr [rsp + 0x20], rax
0107e045 call       0x1410773d0
0107e04a or         byte ptr [rbp + 0x34b], 0x40
0107e051 jmp        0x14107e3e1
0107e056 lea        r13, [r14 + 0xa00128]
0107e05d test       r13, r13
0107e060 je         0x14107e084
0107e062 xorps      xmm0, xmm0
0107e065 xor        eax, eax
0107e067 movups     xmmword ptr [r13], xmm0
0107e06c movups     xmmword ptr [r13 + 0x10], xmm0
0107e071 movups     xmmword ptr [r13 + 0x20], xmm0
0107e076 movups     xmmword ptr [r13 + 0x30], xmm0
0107e07b movups     xmmword ptr [r13 + 0x40], xmm0
0107e080 mov        dword ptr [r13 + 0x50], eax
0107e084 cmp        r15d, 0xa00000
0107e08b jbe        0x14107e097
0107e08d mov        esi, 0xffffff30
0107e092 jmp        0x14107e3e3
0107e097 mov        r8d, r15d
0107e09a mov        rdx, r13
0107e09d mov        rcx, r14
0107e0a0 call       0x1410770a0
0107e0a5 mov        esi, eax
0107e0a7 test       eax, eax
0107e0a9 jne        0x14107e3e3
0107e0af mov        rdx, r13
0107e0b2 mov        rcx, r14
0107e0b5 call       0x1410690d0
0107e0ba mov        rdx, rdi
0107e0bd mov        rcx, r13
0107e0c0 call       0x141079810
0107e0c5 jmp        0x14107e3e1
0107e0ca mov        rcx, rbx
0107e0cd call       0x140f92f00
0107e0d2 mov        rax, qword ptr [rbx + 0x68]
0107e0d6 xor        edx, edx
0107e0d8 mov        r8, qword ptr [rsp + 0x38]
0107e0dd add        rax, 0x4c
0107e0e1 mov        r9d, dword ptr [rbp + 0x370]
0107e0e8 add        r8, 0x1888
0107e0ef mov        dword ptr [rsp + 0x28], r13d
0107e0f4 mov        rcx, r14
0107e0f7 mov        qword ptr [rsp + 0x20], rax
0107e0fc call       0x1410773d0
0107e101 or         byte ptr [rbp + 0x34e], 8
0107e108 jmp        0x14107e3e1
0107e10d mov        rcx, rdi
0107e110 call       0x140fa6150
0107e115 mov        rax, qword ptr [rdi + 0x10]
0107e119 mov        edx, 1
0107e11e mov        r8, qword ptr [rsp + 0x38]
0107e123 add        rax, 0x68
0107e127 mov        r9d, dword ptr [rbp + 0x370]
0107e12e add        r8, 0x7a8
0107e135 mov        dword ptr [rsp + 0x28], r13d
0107e13a mov        rcx, r14
0107e13d mov        qword ptr [rsp + 0x20], rax
0107e142 call       0x1410773d0
0107e147 or         byte ptr [rbp + 0x34e], 1
0107e14e jmp        0x14107e3e1
0107e153 mov        rcx, rdi
0107e156 call       0x140fa6150
0107e15b mov        rax, qword ptr [rdi + 0x10]
0107e15f mov        edx, 2
0107e164 mov        r8, qword ptr [rsp + 0x38]
0107e169 add        rax, 0x6c
0107e16d mov        r9d, dword ptr [rbp + 0x370]
0107e174 add        r8, 0x7f0
0107e17b mov        dword ptr [rsp + 0x28], r13d
0107e180 mov        rcx, r14
0107e183 mov        qword ptr [rsp + 0x20], rax
0107e188 call       0x1410773d0
0107e18d or         byte ptr [rbp + 0x34f], 0x10
0107e194 jmp        0x14107e3e1
0107e199 mov        rcx, rbx
0107e19c call       0x140f92f00
0107e1a1 mov        rax, qword ptr [rbx + 0x68]
0107e1a5 mov        edx, 1
0107e1aa mov        r8, qword ptr [rsp + 0x38]
0107e1af add        rax, 0x40
0107e1b3 mov        r9d, dword ptr [rbp + 0x370]
0107e1ba add        r8, 0x880
0107e1c1 mov        dword ptr [rsp + 0x28], r13d
0107e1c6 mov        rcx, r14
0107e1c9 mov        qword ptr [rsp + 0x20], rax
0107e1ce call       0x1410773d0
0107e1d3 or         byte ptr [rbp + 0x34f], 8
0107e1da jmp        0x14107e3e1
0107e1df mov        rcx, rdi
0107e1e2 call       0x140fa6150
0107e1e7 mov        rax, qword ptr [rdi + 0x10]
0107e1eb mov        edx, 1
0107e1f0 mov        r8, qword ptr [rsp + 0x38]
0107e1f5 add        rax, 0x74
0107e1f9 mov        r9d, dword ptr [rbp + 0x370]
0107e200 add        r8, 0x8c8
0107e207 mov        dword ptr [rsp + 0x28], r13d
0107e20c mov        rcx, r14
0107e20f mov        qword ptr [rsp + 0x20], rax
0107e214 call       0x1410773d0
0107e219 or         byte ptr [rbp + 0x352], 0x80
0107e220 jmp        0x14107e3e1
0107e225 mov        rcx, rdi
0107e228 call       0x140fa6150
0107e22d mov        rax, qword ptr [rdi + 0x10]
0107e231 mov        edx, 1
0107e236 mov        r8, qword ptr [rsp + 0x38]
0107e23b add        rax, 0x78
0107e23f mov        r9d, dword ptr [rbp + 0x370]
0107e246 add        r8, 0x910
0107e24d mov        dword ptr [rsp + 0x28], r13d
0107e252 mov        rcx, r14
0107e255 mov        qword ptr [rsp + 0x20], rax
0107e25a call       0x1410773d0
0107e25f or         byte ptr [rbp + 0x352], 0x40
0107e266 jmp        0x14107e3e1
0107e26b mov        rcx, rdi
0107e26e call       0x140fa6150
0107e273 mov        rax, qword ptr [rdi + 0x10]
0107e277 mov        edx, 1
0107e27c mov        r8, qword ptr [rsp + 0x38]
0107e281 add        rax, 0x7c
0107e285 mov        r9d, dword ptr [rbp + 0x370]
0107e28c add        r8, 0x8c8
0107e293 mov        dword ptr [rsp + 0x28], r13d
0107e298 mov        rcx, r14
0107e29b mov        qword ptr [rsp + 0x20], rax
0107e2a0 call       0x1410773d0
0107e2a5 or         byte ptr [rbp + 0x352], 8
0107e2ac jmp        0x14107e3e1
0107e2b1 mov        rcx, rdi
0107e2b4 call       0x140fa6150
0107e2b9 mov        rax, qword ptr [rdi + 0x10]
0107e2bd mov        edx, 1
0107e2c2 mov        r8, qword ptr [rsp + 0x38]
0107e2c7 sub        rax, -0x80
0107e2cb mov        r9d, dword ptr [rbp + 0x370]
0107e2d2 add        r8, 0x910
0107e2d9 mov        dword ptr [rsp + 0x28], r13d
0107e2de mov        rcx, r14
0107e2e1 mov        qword ptr [rsp + 0x20], rax
0107e2e6 call       0x1410773d0
0107e2eb or         byte ptr [rbp + 0x352], 4
0107e2f2 jmp        0x14107e3e1
0107e2f7 mov        rcx, rbx
0107e2fa call       0x140f92f00
0107e2ff mov        rax, qword ptr [rbx + 0x68]
0107e303 mov        edx, 1
0107e308 mov        r8, qword ptr [rsp + 0x38]
0107e30d add        rax, 0x18
0107e311 mov        r9d, dword ptr [rbp + 0x370]
0107e318 add        r8, 0x298
0107e31f mov        dword ptr [rsp + 0x28], r13d
0107e324 mov        rcx, r14
0107e327 mov        qword ptr [rsp + 0x20], rax
0107e32c call       0x1410773d0
0107e331 or         byte ptr [rbp + 0x353], 1
0107e338 jmp        0x14107e3e1
0107e33d mov        rcx, rbx
0107e340 call       0x140f92f00
0107e345 mov        rax, qword ptr [rbx + 0x68]
0107e349 mov        edx, 1
0107e34e mov        r8, qword ptr [rsp + 0x38]
0107e353 add        rax, 0x1c
0107e357 mov        r9d, dword ptr [rbp + 0x370]
0107e35e add        r8, 0x2e0
0107e365 mov        dword ptr [rsp + 0x28], r13d
0107e36a mov        rcx, r14
0107e36d mov        qword ptr [rsp + 0x20], rax
0107e372 call       0x1410773d0
0107e377 or         byte ptr [rbp + 0x354], 0x80
0107e37e jmp        0x14107e3e1
0107e380 mov        rcx, rdi
0107e383 call       0x140fa6150
0107e388 mov        r8, qword ptr [rdi + 0x10]
0107e38c mov        edx, r15d
0107e38f add        r8, 0x98
0107e396 mov        rcx, r14
0107e399 call       0x141077ee0
0107e39e jmp        0x14107e3e1
0107e3a0 mov        rcx, rdi
0107e3a3 call       0x140fa6150
0107e3a8 mov        rax, qword ptr [rdi + 0x10]
0107e3ac mov        edx, 1
0107e3b1 mov        r8, qword ptr [rsp + 0x38]
0107e3b6 add        rax, 0x70
0107e3ba mov        r9d, dword ptr [rbp + 0x370]
0107e3c1 add        r8, 0x838
0107e3c8 mov        dword ptr [rsp + 0x28], r13d
0107e3cd mov        rcx, r14
0107e3d0 mov        qword ptr [rsp + 0x20], rax
0107e3d5 call       0x1410773d0
0107e3da or         byte ptr [rbp + 0x350], 0x80
0107e3e1 mov        esi, eax
0107e3e3 test       esi, esi
0107e3e5 jne        0x14107e706
0107e3eb jmp        0x14107e4f7
0107e3f0 mov        dl, 1
0107e3f2 mov        rcx, rbx
0107e3f5 call       0x140fa1a50
0107e3fa test       rax, rax
0107e3fd je         0x14107e424
0107e3ff mov        r8d, r15d
0107e402 mov        rdx, rax
0107e405 mov        rcx, r14
0107e408 call       0x141077ff0
0107e40d mov        esi, eax
0107e40f test       eax, eax
0107e411 jne        0x14107e706
0107e417 mov        rcx, rbx
0107e41a call       0x141079920
0107e41f jmp        0x14107e4f7
0107e424 mov        rcx, qword ptr [r14 + 0x1e00178]
0107e42b movsxd     rdx, r15d
0107e42e add        rdx, qword ptr [r14 + 0x1e00170]
0107e435 mov        qword ptr [r14 + 0x1e00170], rdx
0107e43c cmp        rdx, rcx
0107e43f jb         0x14107e44d
0107e441 add        rcx, qword ptr [r14 + 0x1e00180]
0107e448 cmp        rdx, rcx
0107e44b jb         0x14107e454
0107e44d mov        qword ptr [r14 + 0x1e00180], r13
0107e454 mov        rcx, rbx
0107e457 call       0x141079920
0107e45c jmp        0x14107e4f7
0107e461 mov        rax, qword ptr [rdi + 8]
0107e465 test       rax, rax
0107e468 je         0x14107e4f7
0107e46e cmp        qword ptr [rax + 0x10], rsi
0107e472 je         0x14107e4f7
0107e478 mov        rax, qword ptr [rdi + 0x2d0]
0107e47f test       rax, rax
0107e482 jne        0x14107e4ad
0107e484 mov        r9, qword ptr [rip + 0x86a9b5]
0107e48b xor        edx, edx
0107e48d mov        r8, qword ptr [rip + 0x86a954]
0107e494 mov        rcx, qword ptr [rip + 0x1027bf5]
0107e49b call       qword ptr [rip + 0x86ae17]
0107e4a1 mov        qword ptr [rdi + 0x2d0], rax
0107e4a8 test       rax, rax
0107e4ab je         0x14107e4bd
0107e4ad mov        r8d, r15d
0107e4b0 mov        rdx, rax
0107e4b3 mov        rcx, r14
0107e4b6 call       0x141077ff0
0107e4bb mov        esi, eax
0107e4bd test       esi, esi
0107e4bf jne        0x14107e706
0107e4c5 jmp        0x14107e4f7
0107e4c7 mov        rcx, qword ptr [r14 + 0x1e00178]
0107e4ce movsxd     rdx, r15d
0107e4d1 add        rdx, qword ptr [r14 + 0x1e00170]
0107e4d8 mov        qword ptr [r14 + 0x1e00170], rdx
0107e4df cmp        rdx, rcx
0107e4e2 jb         0x14107e4f0
0107e4e4 add        rcx, qword ptr [r14 + 0x1e00180]
0107e4eb cmp        rdx, rcx
0107e4ee jb         0x14107e4f7
0107e4f0 mov        qword ptr [r14 + 0x1e00180], r13
0107e4f7 mov        r13d, dword ptr [rsp + 0x40]
0107e4fc inc        r13d
0107e4ff mov        dword ptr [rsp + 0x40], r13d
0107e504 cmp        r13d, dword ptr [rbp + 0x4c]
0107e508 jb         0x14107cfa3
0107e50e mov        r15, qword ptr [rsp + 0x38]
0107e513 cmp        byte ptr [r14 + 0x1e002f2], 0
0107e51b je         0x14107e5ab
0107e521 mov        rax, qword ptr [rdi + 0x20]
0107e525 cmp        qword ptr [rax + 8], 0
0107e52a jne        0x14107e535
0107e52c cmp        byte ptr [rbx + 0x8a], 0
0107e533 je         0x14107e5ab
0107e535 cmp        qword ptr [rbx + 0x10], 0
0107e53a je         0x14107e5ab
0107e53c test       byte ptr [rbx + 0x9a], 1
0107e543 je         0x14107e5ab
0107e545 mov        rax, qword ptr [rbx + 0x68]
0107e549 mov        ecx, dword ptr [rax + 0x10]
0107e54c test       ecx, ecx
0107e54e jne        0x14107e57d
0107e550 cmp        dword ptr [rbx + 0xac], ecx
0107e556 jne        0x14107e577
0107e558 mov        rcx, rbx
0107e55b call       0x140f91240
0107e560 mov        dword ptr [rbx + 0xac], eax
0107e566 test       eax, eax
0107e568 je         0x14107e577
0107e56a mov        edx, 0x3c
0107e56f mov        rcx, rbx
0107e572 call       0x140f94100
0107e577 mov        ecx, dword ptr [rbx + 0xac]
0107e57d sub        ecx, 1
0107e580 je         0x14107e594
0107e582 sub        ecx, 0xf
0107e585 je         0x14107e594
0107e587 sub        ecx, 0x10
0107e58a je         0x14107e594
0107e58c cmp        ecx, 0xffe1
0107e592 jne        0x14107e5ab
0107e594 xor        r9d, r9d
0107e597 xor        r8d, r8d
0107e59a xor        edx, edx
0107e59c mov        rcx, rdi
0107e59f call       0x140faa080
0107e5a4 mov        byte ptr [rbx + 0x8a], 0
0107e5ab movsxd     rdi, dword ptr [rbp - 0x10]
0107e5af test       edi, edi
0107e5b1 je         0x14107e623
0107e5b3 mov        rcx, rbx
0107e5b6 call       0x140f92f00
0107e5bb mov        rax, qword ptr [rbx + 0x68]
0107e5bf cmp        dword ptr [rax + 0x24], 0
0107e5c3 je         0x14107e619
0107e5c5 lea        r8, [r15 + 0x5b0]
0107e5cc test       r8, r8
0107e5cf je         0x14107e623
0107e5d1 cmp        dword ptr [r8], 0x73747263
0107e5d8 jne        0x14107e623
0107e5da cmp        dword ptr [r8 + 0x3c], 0
0107e5df jne        0x14107e623
0107e5e1 test       edi, edi
0107e5e3 jle        0x14107e623
0107e5e5 cmp        edi, dword ptr [r8 + 0x2c]
0107e5e9 jg         0x14107e623
0107e5eb test       byte ptr [r8 + 4], 1
0107e5f0 je         0x14107e600
0107e5f2 mov        rax, qword ptr [r8 + 0x18]
0107e5f6 mov        rax, qword ptr [rax]
0107e5f9 sub        dword ptr [rax + rdi*4 - 4], 1
0107e5fe jne        0x14107e623
0107e600 mov        rax, qword ptr [r8 + 0x10]
0107e604 mov        rcx, qword ptr [rax]
0107e607 mov        eax, dword ptr [rcx + rdi*8 - 4]
0107e60b add        dword ptr [r8 + 0x40], eax
0107e60f mov        dword ptr [rcx + rdi*8 - 8], 0x80000001
0107e617 jmp        0x14107e623
0107e619 or         byte ptr [rbp + 0x34a], 4
0107e620 mov        dword ptr [rax + 0x24], edi
0107e623 mov        r8d, 6
0107e629 lea        rdx, [rbp + 0x340]
0107e630 mov        rcx, rbx
0107e633 call       0x140ed6940
0107e638 jmp        0x14107e673
0107e63a mov        eax, dword ptr [rbp + 0x48]
0107e63d sub        eax, dword ptr [rbp + 0x44]
0107e640 mov        rcx, qword ptr [r14 + 0x1e00178]
0107e647 movsxd     rdx, eax
0107e64a add        rdx, qword ptr [r14 + 0x1e00170]
0107e651 mov        qword ptr [r14 + 0x1e00170], rdx
0107e658 cmp        rdx, rcx
0107e65b jb         0x14107e669
0107e65d add        rcx, qword ptr [r14 + 0x1e00180]
0107e664 cmp        rdx, rcx
0107e667 jb         0x14107e670
0107e669 mov        qword ptr [r14 + 0x1e00180], r8
0107e670 mov        esi, r8d
0107e673 inc        qword ptr [r14 + 0x1e00190]
0107e67a mov        rcx, r14
0107e67d call       0x141077340
0107e682 mov        ebx, dword ptr [rbp - 0xc]
0107e685 inc        ebx
0107e687 mov        dword ptr [rbp - 0xc], ebx
0107e68a cmp        ebx, dword ptr [rbp + 0x388]
0107e690 jb         0x14107b710
0107e696 xor        r13d, r13d
0107e699 cmp        byte ptr [rsp + 0x30], 0
0107e69e je         0x14107e6a8
0107e6a0 mov        rcx, r15
0107e6a3 call       0x140eb8cd0
0107e6a8 test       esi, esi
0107e6aa jne        0x14107e706
0107e6ac cmp        dword ptr [rsp + 0x48], 0xd
0107e6b1 jne        0x14107e706
0107e6b3 mov        rdi, qword ptr [rbp]
0107e6b7 test       rdi, rdi
0107e6ba je         0x14107e706
0107e6bc mov        rbx, rdi
0107e6bf mov        rax, rdi
0107e6c2 cmp        qword ptr [rbx + 0x10], 0
0107e6c7 mov        rbx, r13
0107e6ca je         0x14107e6d0
0107e6cc mov        rbx, qword ptr [rax + 0x18]
0107e6d0 mov        rdx, rdi
0107e6d3 lea        rcx, [r14 + 0x1e00290]
0107e6da call       0x14042de70
0107e6df test       rax, rax
0107e6e2 je         0x14107e6fb
0107e6e4 mov        rdx, qword ptr [rax + 8]
0107e6e8 test       rdx, rdx
0107e6eb je         0x14107e6fb
0107e6ed cmp        rdx, rdi
0107e6f0 je         0x14107e6fb
0107e6f2 mov        rcx, qword ptr [rdi + 0x58]
0107e6f6 call       0x140fa10a0
0107e6fb mov        rdi, rbx
0107e6fe mov        rax, rbx
0107e701 test       rbx, rbx
0107e704 jne        0x14107e6c2
0107e706 movaps     xmm14, xmmword ptr [rsp + 0x700]
0107e70f movaps     xmm13, xmmword ptr [rsp + 0x710]
0107e718 movaps     xmm12, xmmword ptr [rsp + 0x720]
0107e721 movaps     xmm11, xmmword ptr [rsp + 0x730]
0107e72a movaps     xmm10, xmmword ptr [rsp + 0x740]
0107e733 movaps     xmm9, xmmword ptr [rsp + 0x750]
0107e73c movaps     xmm8, xmmword ptr [rsp + 0x760]
0107e745 movaps     xmm7, xmmword ptr [rsp + 0x770]
0107e74d movaps     xmm6, xmmword ptr [rsp + 0x780]
0107e755 movaps     xmm15, xmmword ptr [rsp + 0x6f0]
; range 0x107e75e..0x107e77e (exclusive)
0107e75e mov        r12, qword ptr [rsp + 0x7d8]
0107e766 mov        rdi, qword ptr [rsp + 0x7d0]
0107e76e mov        rbx, qword ptr [rsp + 0x7c8]
0107e776 mov        r13, qword ptr [rsp + 0x790]
; range 0x107e77e..0x107e79d (exclusive)
0107e77e mov        eax, esi
0107e780 mov        rcx, qword ptr [rbp + 0x5e0]
0107e787 xor        rcx, rsp
0107e78a call       0x14179b8e0
0107e78f add        rsp, 0x798
0107e796 pop        r15
0107e798 pop        r14
0107e79a pop        rsi
0107e79b pop        rbp
0107e79c ret        
; range 0x107e79d..0x107e8bc (exclusive)
0107e79d mov        esi, 0xffffff94
0107e7a2 jmp        0x14107e706
0107e7a7 mov        esi, 0xffffff30
0107e7ac jmp        0x14107e706
0107e7b1 nop        dword ptr [rax]
