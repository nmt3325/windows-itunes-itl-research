; Original iTunes.exe machine code; base=0x140000000; RVA=0x1071260; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1071260..0x1072598 (exclusive)
01071260 push       rbp
01071262 push       rbx
01071263 push       rsi
01071264 push       rdi
01071265 push       r12
01071267 push       r13
01071269 push       r14
0107126b push       r15
0107126d lea        rbp, [rsp - 0x1468]
01071275 mov        eax, 0x1568
0107127a call       0x1418677a0
0107127f sub        rsp, rax
01071282 movaps     xmmword ptr [rsp + 0x1550], xmm6
0107128a movaps     xmmword ptr [rsp + 0x1540], xmm7
01071292 movaps     xmmword ptr [rsp + 0x1530], xmm8
0107129b mov        rax, qword ptr [rip + 0xf63d9e]
010712a2 xor        rax, rsp
010712a5 mov        qword ptr [rbp + 0x1420], rax
010712ac mov        qword ptr [rbp - 0x80], r9
010712b0 mov        qword ptr [rbp - 0x78], r8
010712b4 mov        rdi, rdx
010712b7 mov        qword ptr [rsp + 0x58], rdx
010712bc mov        rsi, rcx
010712bf xor        r13d, r13d
010712c2 lea        r14, [rdx + 0x130]
010712c9 test       r14, r14
010712cc je         0x1410712db
010712ce cmp        dword ptr [r14], 0x73747263
010712d5 jne        0x1410712db
010712d7 inc        dword ptr [r14 + 0x3c]
010712db mov        r15, qword ptr [rcx + 0x120]
010712e2 mov        qword ptr [rsp + 0x50], r13
010712e7 cmp        byte ptr [r15 + 5], r13b
010712eb je         0x1410712f8
010712ed mov        rax, qword ptr [r15 + 0x40]
010712f1 mov        qword ptr [rsp + 0x50], rax
010712f6 jmp        0x141071315
010712f8 lea        rdx, [rsp + 0x50]
010712fd mov        rcx, qword ptr [r15 + 8]
01071301 call       0x140bd6640
01071306 mov        ebx, eax
01071308 test       eax, eax
0107130a jne        0x141072543
01071310 mov        rax, qword ptr [rsp + 0x50]
01071315 mov        rcx, qword ptr [r15 + 0x20]
01071319 cmp        byte ptr [r15 + 5], r13b
0107131d je         0x141071328
0107131f sub        rcx, qword ptr [r15 + 0x38]
01071323 dec        rcx
01071326 jmp        0x14107132c
01071328 sub        rcx, qword ptr [r15 + 0x30]
0107132c add        rax, rcx
0107132f mov        qword ptr [rsp + 0x50], rax
01071334 xor        edx, edx
01071336 mov        r8d, 0xdac
0107133c lea        rcx, [rbp - 0x60]
01071340 call       0x14179cca0
01071345 mov        dword ptr [rbp - 0x60], 0x6870696d
0107134c mov        dword ptr [rbp - 0x5c], 0xdac
01071353 mov        word ptr [rbp - 0x4c], r13w
01071358 movzx      eax, byte ptr [rdi + 0x1d8]
0107135f shr        al, 3
01071362 and        al, 1
01071364 mov        byte ptr [rbp - 0x4a], al
01071367 mov        eax, dword ptr [rdi + 0x1f4]
0107136d mov        dword ptr [rbp - 0x44], eax
01071370 mov        eax, dword ptr [rdi + 0x1f8]
01071376 mov        dword ptr [rbp + 0x214], eax
0107137c movzx      ecx, byte ptr [rdi + 0x2ca]
01071383 movzx      eax, cl
01071386 shr        al, 4
01071389 and        al, 1
0107138b mov        byte ptr [rbp + 0x16d], al
01071391 movzx      eax, cl
01071394 shr        al, 5
01071397 and        al, 1
01071399 mov        byte ptr [rbp + 0x16e], al
0107139f movzx      eax, byte ptr [rdi + 0x2cd]
010713a6 mov        byte ptr [rbp + 0x6d0], al
010713ac movzx      eax, byte ptr [rdi + 0x2cc]
010713b3 mov        byte ptr [rbp + 0x1ba], al
010713b9 shr        cl, 7
010713bc mov        byte ptr [rbp + 0x160], cl
010713c2 movzx      ecx, byte ptr [rdi + 0x2cb]
010713c9 movzx      eax, cl
010713cc and        al, 1
010713ce mov        byte ptr [rbp + 0x6d5], al
010713d4 shr        cl, 1
010713d6 and        cl, 1
010713d9 mov        byte ptr [rbp + 0x6d7], cl
010713df movzx      eax, word ptr [rdi + 0x2dc]
010713e6 mov        word ptr [rbp - 0x40], ax
010713ea movzx      eax, word ptr [rdi + 0x2de]
010713f1 mov        word ptr [rbp - 0x3e], ax
010713f5 movzx      eax, word ptr [rdi + 0x2e0]
010713fc mov        word ptr [rbp - 0x3c], ax
01071400 movzx      eax, word ptr [rdi + 0x2e2]
01071407 mov        word ptr [rbp - 0x3a], ax
0107140b movzx      eax, word ptr [rdi + 0x2e4]
01071412 mov        word ptr [rbp + 0x156], ax
01071419 movzx      eax, word ptr [rdi + 0x2e6]
01071420 mov        word ptr [rbp + 0xc38], ax
01071427 movzx      eax, word ptr [rdi + 0x2e8]
0107142e mov        word ptr [rbp + 0xc3a], ax
01071435 movzx      eax, word ptr [rdi + 0x2ea]
0107143c mov        word ptr [rbp + 0xc3c], ax
01071443 movzx      eax, word ptr [rdi + 0x2ec]
0107144a mov        word ptr [rbp + 0xc3e], ax
01071451 mov        ecx, dword ptr [rdi + 0x470]
01071457 sub        ecx, 0x34
0107145a je         0x14107146d
0107145c cmp        ecx, 1
0107145f je         0x141071466
01071461 mov        eax, r13d
01071464 jmp        0x141071472
01071466 mov        eax, 0x34
0107146b jmp        0x141071472
0107146d mov        eax, 0x33
01071472 mov        dword ptr [rbp + 0x1c4], eax
01071478 mov        ecx, dword ptr [rdi + 0x474]
0107147e test       ecx, ecx
01071480 je         0x14107148d
01071482 call       0x141070b60
01071487 mov        dword ptr [rbp + 0xc18], eax
0107148d movzx      eax, byte ptr [rdi + 0x47a]
01071494 mov        byte ptr [rbp + 0xc16], al
0107149a mov        rcx, rdi
0107149d call       0x140fb4370
010714a2 mov        rcx, rax
010714a5 mov        r12d, 1
010714ab test       rax, rax
010714ae je         0x1410714d3
010714b0 movzx      ebx, byte ptr [rax + 0x1c]
010714b4 mov        r15d, dword ptr [rax + 0x18]
010714b8 sub        dword ptr [rax + 0xc], r12d
010714bc jne        0x1410714e8
010714be cmp        dword ptr [rcx + 8], 0x63736574
010714c5 jne        0x1410714e8
010714c7 mov        dword ptr [rcx + 8], r13d
010714cb call       qword ptr [rip + 0x87ae97]
010714d1 jmp        0x1410714e8
010714d3 mov        rcx, rdi
010714d6 call       0x140fb4290
010714db mov        rcx, rax
010714de test       rax, rax
010714e1 jne        0x1410714b0
010714e3 mov        r15d, r12d
010714e6 xor        bl, bl
010714e8 mov        ecx, r15d
010714eb call       0x141070b60
010714f0 mov        word ptr [rbp - 0x48], ax
010714f4 mov        byte ptr [rbp + 0x1d8], bl
010714fa mov        rax, qword ptr [rdi + 0x188]
01071501 mov        qword ptr [rbp + 0xc1c], rax
01071508 mov        rax, qword ptr [rdi + 0x190]
0107150f mov        qword ptr [rbp + 0xc24], rax
01071516 movzx      eax, byte ptr [rdi + 0x183]
0107151d mov        byte ptr [rbp + 0xc2d], al
01071523 movzx      ecx, byte ptr [rdi + 0x180]
0107152a movzx      eax, cl
0107152d shr        al, 2
01071530 and        al, r12b
01071533 mov        byte ptr [rbp + 0xc2c], al
01071539 movzx      eax, cl
0107153c shr        al, 6
0107153f and        al, r12b
01071542 mov        byte ptr [rbp + 0xc33], al
01071548 movzx      eax, cl
0107154b shr        al, 1
0107154d and        al, r12b
01071550 mov        byte ptr [rbp + 0xc17], al
01071556 and        cl, r12b
01071559 mov        byte ptr [rbp + 0xc30], cl
0107155f mov        rax, qword ptr [rdi + 0x50]
01071563 mov        qword ptr [rbp + 0x158], rax
0107156a mov        eax, dword ptr [rdi + 0x48]
0107156d mov        dword ptr [rbp + 0xce0], eax
01071573 movzx      eax, byte ptr [rdi + 0x47b]
0107157a mov        byte ptr [rbp + 0xc2e], al
01071580 movzx      eax, byte ptr [rdi + 0x47c]
01071587 mov        byte ptr [rbp + 0xc31], al
0107158d movzx      eax, byte ptr [rdi + 0x2c8]
01071594 and        al, r12b
01071597 mov        byte ptr [rbp + 0x171], al
0107159d movzx      ecx, word ptr [rdi + 0x10]
010715a1 mov        edx, 0xc8
010715a6 movzx      eax, cx
010715a9 sub        ax, dx
010715ac cmp        ax, 6
010715b0 ja         0x1410715ba
010715b2 mov        byte ptr [rbp + 0x1da], cl
010715b8 jmp        0x1410715c0
010715ba mov        byte ptr [rbp + 0x1d9], cl
010715c0 movzx      ecx, byte ptr [rdi + 0x2c9]
010715c7 movzx      eax, cl
010715ca shr        al, 5
010715cd and        al, r12b
010715d0 mov        byte ptr [rbp + 0xc14], al
010715d6 shr        cl, 7
010715d9 mov        byte ptr [rbp + 0xc15], cl
010715df mov        eax, dword ptr [rdi + 0x400]
010715e5 mov        dword ptr [rbp + 0xc34], eax
010715eb movzx      eax, byte ptr [rdi + 0x3f0]
010715f2 and        al, r12b
010715f5 mov        byte ptr [rbp + 0x162], al
010715fb movzx      eax, byte ptr [rdi + 0x360]
01071602 mov        byte ptr [rbp + 0x163], al
01071608 mov        rax, qword ptr [rdi + 0x358]
0107160f mov        qword ptr [rbp + 0x164], rax
01071616 mov        rax, qword ptr [rdi + 0x368]
0107161d mov        qword ptr [rbp + 0x174], rax
01071624 movzx      eax, byte ptr [rdi + 0x1d9]
0107162b shr        al, 3
0107162e and        al, r12b
01071631 mov        byte ptr [rbp + 0x1a8], al
01071637 mov        rax, qword ptr [rdi + 0x18]
0107163b test       rax, rax
0107163e je         0x14107164b
01071640 mov        rax, qword ptr [rax + 0x50]
01071644 mov        qword ptr [rbp + 0x1b0], rax
0107164b mov        rax, qword ptr [rdi + 0x218]
01071652 mov        qword ptr [rbp + 0x1c8], rax
01071659 mov        rax, qword ptr [rdi + 0x220]
01071660 mov        qword ptr [rbp + 0x1d0], rax
01071667 mov        eax, dword ptr [rdi + 0x378]
0107166d mov        dword ptr [rbp + 0xc08], eax
01071673 mov        eax, dword ptr [rdi + 0x37c]
01071679 mov        dword ptr [rbp + 0xc0c], eax
0107167f mov        eax, dword ptr [rdi + 0x380]
01071685 mov        dword ptr [rbp + 0xc10], eax
0107168b movzx      ecx, byte ptr [rdi + 0x181]
01071692 movzx      eax, cl
01071695 shr        al, 1
01071697 and        al, r12b
0107169a mov        byte ptr [rbp + 0xcf4], al
010716a0 movzx      eax, cl
010716a3 shr        al, 2
010716a6 and        al, r12b
010716a9 mov        byte ptr [rbp + 0xcf5], al
010716af shr        cl, 3
010716b2 and        cl, r12b
010716b5 mov        byte ptr [rbp + 0xcf6], cl
010716bb movzx      eax, byte ptr [rdi + 0x478]
010716c2 mov        byte ptr [rbp + 0xcf7], al
010716c8 mov        rax, qword ptr [rdi + 0x1c8]
010716cf mov        qword ptr [rbp + 0xcf8], rax
010716d6 mov        rax, qword ptr [rdi + 0x1b0]
010716dd mov        qword ptr [rbp + 0xd00], rax
010716e4 mov        rax, qword ptr [rdi + 0x1b8]
010716eb mov        qword ptr [rbp + 0xd08], rax
010716f2 mov        rax, qword ptr [rdi + 0x1c0]
010716f9 mov        qword ptr [rbp + 0xd10], rax
01071700 mov        eax, dword ptr [rdi + 0x1a0]
01071706 mov        dword ptr [rbp + 0xd18], eax
0107170c movzx      ecx, byte ptr [rdi + 0x1da]
01071713 movzx      eax, cl
01071716 shr        al, 4
01071719 and        al, r12b
0107171c mov        byte ptr [rbp + 0xd28], al
01071722 shr        cl, 7
01071725 mov        byte ptr [rbp + 0xd29], cl
0107172b movzx      eax, byte ptr [rdi + 0x1db]
01071732 and        al, r12b
01071735 mov        byte ptr [rbp + 0xd2a], al
0107173b test       byte ptr [rdi + 0x1d8], 8
01071742 je         0x141071748
01071744 xor        al, al
01071746 jmp        0x141071781
01071748 lea        rdx, [rsp + 0x60]
0107174d mov        rcx, rdi
01071750 call       0x140efe3e0
01071755 test       eax, eax
01071757 je         0x14107175f
01071759 movzx      eax, r12b
0107175d jmp        0x141071781
0107175f cmp        byte ptr [rsp + 0x60], r13b
01071764 je         0x14107176c
01071766 movzx      eax, r12b
0107176a jmp        0x141071781
0107176c cmp        byte ptr [rsp + 0x66], r13b
01071771 je         0x141071779
01071773 movzx      eax, r12b
01071777 jmp        0x141071781
01071779 cmp        byte ptr [rsp + 0x61], r13b
0107177e setne      al
01071781 mov        byte ptr [rbp + 0xd2b], al
01071787 cmp        dword ptr [rdi], 0x706c7374
0107178d je         0x141071797
0107178f mov        rbx, r13
01071792 mov        rcx, r13
01071795 jmp        0x1410717b5
01071797 mov        rax, qword ptr [rdi + 0x4c8]
0107179e test       rax, rax
010717a1 je         0x1410717a7
010717a3 lock inc   dword ptr [rax + 8]
010717a7 mov        rbx, qword ptr [rdi + 0x4c8]
010717ae mov        rcx, qword ptr [rdi + 0x4c0]
010717b5 mov        qword ptr [rsp + 0x60], rcx
010717ba mov        qword ptr [rsp + 0x68], rbx
010717bf test       rcx, rcx
010717c2 je         0x1410717dc
010717c4 mov        rax, qword ptr [rcx]
010717c7 call       qword ptr [rax + 0x90]
010717cd movzx      ecx, al
010717d0 cmp        al, 0xc
010717d2 cmovae     ecx, r13d
010717d6 mov        byte ptr [rbp + 0xc32], cl
010717dc test       rbx, rbx
010717df je         0x141071811
010717e1 mov        r15d, 0xffffffff
010717e7 mov        eax, r15d
010717ea lock xadd  dword ptr [rbx + 8], eax
010717ef cmp        eax, 1
010717f2 jne        0x141071811
010717f4 mov        rax, qword ptr [rbx]
010717f7 mov        rcx, rbx
010717fa call       qword ptr [rax]
010717fc lock xadd  dword ptr [rbx + 0xc], r15d
01071802 cmp        r15d, 1
01071806 jne        0x141071811
01071808 mov        rax, qword ptr [rbx]
0107180b mov        rcx, rbx
0107180e call       qword ptr [rax + 8]
01071811 movzx      eax, word ptr [rdi + 0x10]
01071815 cmp        ax, 0x14
01071819 je         0x141071821
0107181b cmp        ax, 0x27
0107181f jne        0x14107182f
01071821 mov        rax, qword ptr [rdi + 0x4e0]
01071828 mov        qword ptr [rbp + 0x1dc], rax
0107182f mov        rax, qword ptr [rdi + 0x398]
01071836 mov        qword ptr [rbp + 0x1e4], rax
0107183d mov        rax, qword ptr [rdi + 0x3a0]
01071844 mov        qword ptr [rbp + 0x1ec], rax
0107184b mov        rax, qword ptr [rdi + 0x3a8]
01071852 mov        qword ptr [rbp + 0x1f4], rax
01071859 mov        rax, qword ptr [rdi + 0x3b0]
01071860 mov        qword ptr [rbp + 0x1fc], rax
01071867 mov        rax, qword ptr [rdi + 0x3b8]
0107186e mov        qword ptr [rbp + 0x204], rax
01071875 mov        rax, qword ptr [rdi + 0x3c0]
0107187c mov        qword ptr [rbp + 0x20c], rax
01071883 mov        rax, qword ptr [rdi + 0x3c8]
0107188a mov        qword ptr [rbp + 0xbe8], rax
01071891 mov        rax, qword ptr [rdi + 0x3d0]
01071898 mov        qword ptr [rbp + 0xbf0], rax
0107189f mov        rax, qword ptr [rdi + 0x3d8]
010718a6 mov        qword ptr [rbp + 0xbf8], rax
010718ad mov        rax, qword ptr [rdi + 0x3e0]
010718b4 mov        qword ptr [rbp + 0xc00], rax
010718bb mov        word ptr [rbp - 0x46], r12w
010718c0 mov        qword ptr [rsp + 0x40], 0xdac
010718c9 lea        r8, [rbp - 0x60]
010718cd lea        rdx, [rsp + 0x40]
010718d2 mov        rcx, qword ptr [rsi + 0x120]
010718d9 call       0x140ba04c0
010718de mov        ebx, eax
010718e0 test       eax, eax
010718e2 jne        0x141072543
010718e8 lea        rax, [rsi + 0xa00128]
010718ef mov        qword ptr [rsp + 0x40], rax
010718f4 test       byte ptr [rdi + 0x1d8], 8
010718fb je         0x141071a5b
01071901 mov        word ptr [rbp + 0xd50], r13w
01071909 cmp        dword ptr [rdi], 0x706c7374
0107190f jne        0x141071926
01071911 lea        r8, [rbp + 0xd50]
01071918 mov        edx, dword ptr [rdi + 0x178]
0107191e mov        rcx, r14
01071921 call       0x140bff470
01071926 mov        rcx, qword ptr [rip + 0x105e3b3]
0107192d test       rcx, rcx
01071930 je         0x141071961
01071932 mov        edx, 0x7f0001
01071937 call       qword ptr [rip + 0x8774b3]
0107193d mov        r15, rax
01071940 test       rax, rax
01071943 je         0x14107195c
01071945 mov        rcx, rax
01071948 call       qword ptr [rip + 0x877572]
0107194e mov        rbx, rax
01071951 call       qword ptr [rip + 0x877629]
01071957 cmp        rbx, rax
0107195a jne        0x141071961
0107195c test       r15, r15
0107195f jne        0x141071968
01071961 mov        r15, qword ptr [rip + 0x103c290]
01071968 movzx      eax, r13w
0107196c mov        word ptr [rbp + 0x1220], ax
01071973 test       r15, r15
01071976 je         0x1410719d1
01071978 mov        qword ptr [rsp + 0x60], r13
0107197d mov        rcx, r15
01071980 call       qword ptr [rip + 0x87760a]
01071986 mov        rbx, rax
01071989 mov        qword ptr [rsp + 0x68], rax
0107198e mov        eax, r13d
01071991 test       rbx, rbx
01071994 je         0x1410719ca
01071996 mov        eax, 0xff
0107199b cmp        rbx, rax
0107199e jle        0x1410719a8
010719a0 mov        qword ptr [rsp + 0x68], rax
010719a5 movzx      ebx, ax
010719a8 movaps     xmm0, xmmword ptr [rsp + 0x60]
010719ad movdqa     xmmword ptr [rsp + 0x60], xmm0
010719b3 lea        r8, [rbp + 0x1222]
010719ba lea        rdx, [rsp + 0x60]
010719bf mov        rcx, r15
010719c2 call       0x140b92160
010719c7 movzx      eax, bx
010719ca mov        word ptr [rbp + 0x1220], ax
010719d1 movzx      r9d, ax
010719d5 movzx      edx, word ptr [rbp + 0xd50]
010719dc mov        dword ptr [rsp + 0x20], r13d
010719e1 lea        r8, [rbp + 0x1222]
010719e8 lea        rcx, [rbp + 0xd52]
010719ef call       0x140ae4f40
010719f4 test       al, al
010719f6 je         0x141071a0b
010719f8 lea        rdx, [rbp + 0xd50]
010719ff mov        rcx, qword ptr [rip + 0x103e5a2]
01071a06 call       0x140ae6430
01071a0b movzx      r8d, word ptr [rbp + 0xd50]
01071a13 add        r8d, r8d
01071a16 je         0x141071a53
01071a18 xor        r9d, r9d
01071a1b lea        rdx, [rbp + 0xd52]
01071a22 lea        rax, [rsp + 0x40]
01071a27 mov        qword ptr [rsp + 0x30], rax
01071a2c mov        dword ptr [rsp + 0x28], r12d
01071a31 mov        dword ptr [rsp + 0x20], 0x64
01071a39 mov        rcx, rsi
01071a3c call       0x14106ac80
01071a41 mov        ebx, eax
01071a43 test       eax, eax
01071a45 jne        0x141071adf
01071a4b inc        dword ptr [rbp - 0x54]
01071a4e jmp        0x141071adf
01071a53 mov        ebx, r13d
01071a56 jmp        0x141071adf
01071a5b movsxd     r9, dword ptr [rdi + 0x178]
01071a62 mov        ebx, r13d
01071a65 test       r9d, r9d
01071a68 je         0x141071adf
01071a6a mov        r8d, r13d
01071a6d mov        r10, r13
01071a70 test       r14, r14
01071a73 je         0x141071ada
01071a75 cmp        dword ptr [r14], 0x73747263
01071a7c jne        0x141071ada
01071a7e cmp        dword ptr [r14 + 0x3c], ebx
01071a82 je         0x141071ada
01071a84 test       r9d, r9d
01071a87 jle        0x141071ada
01071a89 cmp        r9d, dword ptr [r14 + 0x2c]
01071a8d jg         0x141071ada
01071a8f mov        rax, qword ptr [r14 + 0x10]
01071a93 mov        rcx, qword ptr [rax]
01071a96 lea        rax, [r9 - 1]
01071a9a lea        rax, [rcx + rax*8]
01071a9e test       rax, rax
01071aa1 je         0x141071ac0
01071aa3 movsxd     rdx, dword ptr [rax]
01071aa6 test       edx, edx
01071aa8 js         0x141071ac0
01071aaa mov        ecx, dword ptr [rax + 4]
01071aad test       ecx, ecx
01071aaf jle        0x141071ac0
01071ab1 mov        rax, qword ptr [r14 + 0x20]
01071ab5 mov        r10, rdx
01071ab8 add        r10, qword ptr [rax]
01071abb mov        r8d, ecx
01071abe jmp        0x141071ac5
01071ac0 mov        ebx, 0xffffffce
01071ac5 test       ebx, ebx
01071ac7 jne        0x141072543
01071acd test       r8d, r8d
01071ad0 je         0x141071adf
01071ad2 mov        rdx, r10
01071ad5 jmp        0x141071a22
01071ada mov        ebx, 0xffffffce
01071adf test       ebx, ebx
01071ae1 jne        0x141072543
01071ae7 movsxd     r9, dword ptr [rdi + 0x17c]
01071aee mov        ebx, r13d
01071af1 test       r9d, r9d
01071af4 je         0x141071bb2
01071afa mov        r8d, r13d
01071afd mov        r10, r13
01071b00 test       r14, r14
01071b03 je         0x141071ba8
01071b09 cmp        dword ptr [r14], 0x73747263
01071b10 jne        0x141071ba8
01071b16 cmp        dword ptr [r14 + 0x3c], ebx
01071b1a jne        0x141071b2d
01071b1c mov        ebx, 0xffffffce
01071b21 add        rdi, 0x130
01071b28 jmp        0x14107254c
01071b2d test       r9d, r9d
01071b30 jle        0x141071b1c
01071b32 cmp        r9d, dword ptr [r14 + 0x2c]
01071b36 jg         0x141071b1c
01071b38 mov        rax, qword ptr [r14 + 0x10]
01071b3c mov        rcx, qword ptr [rax]
01071b3f lea        rax, [r9 - 1]
01071b43 lea        rax, [rcx + rax*8]
01071b47 test       rax, rax
01071b4a je         0x141071b69
01071b4c movsxd     rdx, dword ptr [rax]
01071b4f test       edx, edx
01071b51 js         0x141071b69
01071b53 mov        ecx, dword ptr [rax + 4]
01071b56 test       ecx, ecx
01071b58 jle        0x141071b69
01071b5a mov        rax, qword ptr [r14 + 0x20]
01071b5e mov        r10, rdx
01071b61 add        r10, qword ptr [rax]
01071b64 mov        r8d, ecx
01071b67 jmp        0x141071b6e
01071b69 mov        ebx, 0xffffffce
01071b6e test       ebx, ebx
01071b70 jne        0x141072543
01071b76 test       r8d, r8d
01071b79 je         0x141071bb2
01071b7b lea        rax, [rsp + 0x40]
01071b80 mov        qword ptr [rsp + 0x30], rax
01071b85 mov        dword ptr [rsp + 0x28], r12d
01071b8a mov        dword ptr [rsp + 0x20], 0x6a
01071b92 mov        rdx, r10
01071b95 mov        rcx, rsi
01071b98 call       0x14106ac80
01071b9d mov        ebx, eax
01071b9f test       eax, eax
01071ba1 jne        0x141071bb2
01071ba3 inc        dword ptr [rbp - 0x54]
01071ba6 jmp        0x141071bba
01071ba8 mov        ebx, 0xffffffce
01071bad jmp        0x141072543
01071bb2 test       ebx, ebx
01071bb4 jne        0x141072543
01071bba lea        rax, [rsi + 0xa00128]
01071bc1 mov        rcx, qword ptr [rsp + 0x40]
01071bc6 cmp        rcx, rax
01071bc9 je         0x141071bfc
01071bcb sub        rcx, rsi
01071bce sub        rcx, 0xa00128
01071bd5 mov        qword ptr [rsp + 0x40], rcx
01071bda lea        r8, [rsi + 0xa00128]
01071be1 lea        rdx, [rsp + 0x40]
01071be6 mov        rcx, qword ptr [rsi + 0x120]
01071bed call       0x140ba04c0
01071bf2 mov        ebx, eax
01071bf4 test       eax, eax
01071bf6 jne        0x141072543
01071bfc movzx      eax, byte ptr [rdi + 0x228]
01071c03 movdqa     xmm8, xmmword ptr [rip + 0xc03874]
01071c0c test       al, 1
01071c0e je         0x141071f8d
01071c14 shr        al, 1
01071c16 and        al, 1
01071c18 mov        byte ptr [rbp + 0x1aa], al
01071c1e lea        rcx, [rdi + 0x230]
01071c25 lea        r8, [rbp + 0xd50]
01071c2c mov        dl, 1
01071c2e call       0x1410710d0
01071c33 mov        ebx, eax
01071c35 test       eax, eax
01071c37 jne        0x141072543
01071c3d lea        rcx, [rsi + 0xa00128]
01071c44 lea        rbx, [rcx + 0x18]
01071c48 test       rcx, rcx
01071c4b je         0x141071c54
01071c4d mov        qword ptr [rsi + 0xa00138], r13
01071c54 mov        dword ptr [rcx], 0x686f686d
01071c5a mov        dword ptr [rcx + 4], 0x18
01071c61 mov        dword ptr [rcx + 0xc], 0x66
01071c68 mov        dword ptr [rcx + 8], 0x88
01071c6f cmp        byte ptr [rsi + 0x52], 0
01071c73 jne        0x141071cb6
01071c75 movdqu     xmm1, xmmword ptr [rcx]
01071c79 movdqa     xmm2, xmm8
01071c7e andps      xmm2, xmm1
01071c81 movdqa     xmm0, xmm1
01071c85 pslld      xmm0, 0x10
01071c8a orps       xmm2, xmm0
01071c8d pslld      xmm2, 8
01071c92 movdqa     xmm0, xmm1
01071c96 psrld      xmm0, 0x18
01071c9b orps       xmm2, xmm0
01071c9e psrld      xmm1, 8
01071ca3 andps      xmm1, xmm8
01071ca7 orps       xmm2, xmm1
01071caa movdqu     xmmword ptr [rcx], xmm2
01071cae mov        eax, dword ptr [rcx + 0x10]
01071cb1 bswap      eax
01071cb3 mov        dword ptr [rcx + 0x10], eax
01071cb6 test       rbx, rbx
01071cb9 je         0x141071d07
01071cbb movups     xmm0, xmmword ptr [rbp + 0xd50]
01071cc2 movups     xmmword ptr [rbx], xmm0
01071cc5 movups     xmm1, xmmword ptr [rbp + 0xd60]
01071ccc movups     xmmword ptr [rbx + 0x10], xmm1
01071cd0 movups     xmm0, xmmword ptr [rbp + 0xd70]
01071cd7 movups     xmmword ptr [rbx + 0x20], xmm0
01071cdb movups     xmm1, xmmword ptr [rbp + 0xd80]
01071ce2 movups     xmmword ptr [rbx + 0x30], xmm1
01071ce6 movups     xmm0, xmmword ptr [rbp + 0xd90]
01071ced movups     xmmword ptr [rbx + 0x40], xmm0
01071cf1 movups     xmm1, xmmword ptr [rbp + 0xda0]
01071cf8 movups     xmmword ptr [rbx + 0x50], xmm1
01071cfc movups     xmm0, xmmword ptr [rbp + 0xdb0]
01071d03 movups     xmmword ptr [rbx + 0x60], xmm0
01071d07 add        rbx, 0x70
01071d0b mov        r12, rbx
01071d0e inc        dword ptr [rbp - 0x54]
01071d11 cmp        qword ptr [rdi + 0x240], 0
01071d19 je         0x141071dc7
01071d1f lea        r14, [rbx + 0x18]
01071d23 test       rbx, rbx
01071d26 je         0x141071d36
01071d28 mov        dword ptr [rsi + 0xa001b8], r13d
01071d2f mov        qword ptr [rsi + 0xa001c0], r13
01071d36 mov        dword ptr [rbx], 0x686f686d
01071d3c mov        dword ptr [rbx + 4], 0x18
01071d43 mov        dword ptr [rbx + 0xc], 0x65
01071d4a lea        rax, [rsp + 0x40]
01071d4f mov        qword ptr [rsp + 0x28], rax
01071d54 mov        r8d, 0x9fffe8
01071d5a mov        rdx, r14
01071d5d mov        rcx, qword ptr [rdi + 0x240]
01071d64 call       0x140bf0a80
01071d69 test       eax, eax
01071d6b jne        0x141071dc7
01071d6d mov        r12d, dword ptr [rsp + 0x40]
01071d72 add        r12, r14
01071d75 mov        eax, r12d
01071d78 sub        eax, ebx
01071d7a mov        dword ptr [rbx + 8], eax
01071d7d cmp        byte ptr [rsi + 0x52], 0
01071d81 jne        0x141071dc4
01071d83 movdqu     xmm1, xmmword ptr [rbx]
01071d87 movdqa     xmm2, xmm8
01071d8c andps      xmm2, xmm1
01071d8f movdqa     xmm0, xmm1
01071d93 pslld      xmm0, 0x10
01071d98 orps       xmm2, xmm0
01071d9b pslld      xmm2, 8
01071da0 movdqa     xmm0, xmm1
01071da4 psrld      xmm0, 0x18
01071da9 orps       xmm2, xmm0
01071dac psrld      xmm1, 8
01071db1 andps      xmm1, xmm8
01071db5 orps       xmm2, xmm1
01071db8 movdqu     xmmword ptr [rbx], xmm2
01071dbc mov        eax, dword ptr [rbx + 0x10]
01071dbf bswap      eax
01071dc1 mov        dword ptr [rbx + 0x10], eax
01071dc4 inc        dword ptr [rbp - 0x54]
01071dc7 mov        rax, qword ptr [rdi + 0x248]
01071dce test       rax, rax
01071dd1 je         0x141071f5c
01071dd7 cmp        dword ptr [rax], 0x4f4c5354
01071ddd jne        0x141071f5c
01071de3 cmp        dword ptr [rax + 4], 0
01071de7 je         0x141071f5c
01071ded mov        r15, qword ptr [rax + 0x10]
01071df1 sub        r15, qword ptr [rax + 8]
01071df5 sar        r15, 4
01071df9 movabs     rax, 0xaaaaaaaaaaaaaaab
01071e03 imul       r15, rax
01071e07 test       r15d, r15d
01071e0a je         0x141071f5c
01071e10 mov        ecx, r15d
01071e13 shl        rcx, 3
01071e17 call       0x140b930a0
01071e1c mov        qword ptr [rsp + 0x40], rax
01071e21 test       rax, rax
01071e24 jne        0x141071e30
01071e26 mov        ebx, 0xffffff94
01071e2b jmp        0x141072543
01071e30 mov        r14d, r13d
01071e33 mov        ebx, r13d
01071e36 test       r15d, r15d
01071e39 je         0x141071f50
01071e3f mov        r13, rax
01071e42 xor        r8d, r8d
01071e45 mov        edx, ebx
01071e47 mov        rcx, qword ptr [rdi + 0x248]
01071e4e call       0x1402ddd10
01071e53 test       rax, rax
01071e56 je         0x141071e66
01071e58 mov        ecx, r14d
01071e5b mov        rax, qword ptr [rax]
01071e5e mov        qword ptr [r13 + rcx*8], rax
01071e63 inc        r14d
01071e66 inc        ebx
01071e68 cmp        ebx, r15d
01071e6b jb         0x141071e42
01071e6d test       r14d, r14d
01071e70 mov        r13d, 0
01071e76 mov        r15, qword ptr [rsp + 0x40]
01071e7b je         0x141071f53
01071e81 cmp        byte ptr [rsi + 0x52], r13b
01071e85 jne        0x141071ea5
01071e87 test       r14d, r14d
01071e8a je         0x141071ea5
01071e8c mov        rcx, r15
01071e8f mov        edx, r14d
01071e92 mov        rax, qword ptr [rcx]
01071e95 bswap      rax
01071e98 mov        qword ptr [rcx], rax
01071e9b lea        rcx, [rcx + 8]
01071e9f sub        rdx, 1
01071ea3 jne        0x141071e92
01071ea5 mov        rbx, r12
01071ea8 lea        rcx, [r12 + 0x18]
01071ead test       r12, r12
01071eb0 je         0x141071ec1
01071eb2 xorps      xmm0, xmm0
01071eb5 xor        eax, eax
01071eb7 movups     xmmword ptr [r12], xmm0
01071ebc mov        qword ptr [r12 + 0x10], rax
01071ec1 mov        dword ptr [r12], 0x686f686d
01071ec9 mov        dword ptr [r12 + 4], 0x18
01071ed2 mov        dword ptr [r12 + 0xc], 0x68
01071edb lea        r14d, [r14*8]
01071ee3 test       rcx, rcx
01071ee6 je         0x141071ef8
01071ee8 mov        r8d, r14d
01071eeb mov        rdx, r15
01071eee call       0x14179cc9a
01071ef3 lea        rcx, [r12 + 0x18]
01071ef8 lea        r12, [rcx + r14]
01071efc mov        eax, r12d
01071eff sub        eax, ebx
01071f01 mov        dword ptr [rbx + 8], eax
01071f04 cmp        byte ptr [rsi + 0x52], r13b
01071f08 jne        0x141071f4b
01071f0a movdqu     xmm1, xmmword ptr [rbx]
01071f0e movdqa     xmm2, xmm8
01071f13 andps      xmm2, xmm1
01071f16 movdqa     xmm0, xmm1
01071f1a pslld      xmm0, 0x10
01071f1f orps       xmm2, xmm0
01071f22 pslld      xmm2, 8
01071f27 movdqa     xmm0, xmm1
01071f2b psrld      xmm0, 0x18
01071f30 orps       xmm2, xmm0
01071f33 psrld      xmm1, 8
01071f38 andps      xmm1, xmm8
01071f3c orps       xmm2, xmm1
01071f3f movdqu     xmmword ptr [rbx], xmm2
01071f43 mov        eax, dword ptr [rbx + 0x10]
01071f46 bswap      eax
01071f48 mov        dword ptr [rbx + 0x10], eax
01071f4b inc        dword ptr [rbp - 0x54]
01071f4e jmp        0x141071f53
01071f50 mov        r15, rax
01071f53 mov        rcx, r15
01071f56 call       qword ptr [rip + 0x87a40c]
01071f5c sub        r12, rsi
01071f5f sub        r12, 0xa00128
01071f66 mov        qword ptr [rsp + 0x40], r12
01071f6b lea        r8, [rsi + 0xa00128]
01071f72 lea        rdx, [rsp + 0x40]
01071f77 mov        rcx, qword ptr [rsi + 0x120]
01071f7e call       0x140ba04c0
01071f83 mov        ebx, eax
01071f85 test       eax, eax
01071f87 jne        0x141072543
01071f8d cmp        dword ptr [rdi], 0x706c7374
01071f93 jne        0x141072137
01071f99 mov        rcx, qword ptr [rdi + 8]
01071f9d movzx      edx, byte ptr [rcx + 0x110]
01071fa4 test       dl, 1
01071fa7 jne        0x141071fb9
01071fa9 cmp        dword ptr [rcx + 0x84], 0x74736574
01071fb3 jne        0x141072137
01071fb9 movzx      eax, word ptr [rdi + 0x10]
01071fbd cmp        ax, 0xa
01071fc1 je         0x141071fcd
01071fc3 cmp        ax, 0x1f
01071fc7 jne        0x141072137
01071fcd mov        qword ptr [rsp + 0x40], r13
01071fd2 test       dl, 1
01071fd5 jne        0x141071fe7
01071fd7 cmp        dword ptr [rcx + 0x84], 0x74736574
01071fe1 jne        0x141072137
01071fe7 cmp        ax, 0xa
01071feb je         0x141071ff7
01071fed cmp        ax, 0x1f
01071ff1 jne        0x141072137
01071ff7 mov        rcx, qword ptr [rdi + 0x1e8]
01071ffe test       rcx, rcx
01072001 je         0x141072137
01072007 lea        r8, [rsp + 0x40]
0107200c call       0x140fe20c0
01072011 test       eax, eax
01072013 jne        0x141072137
01072019 mov        r14, qword ptr [rsp + 0x40]
0107201e test       r14, r14
01072021 je         0x141072137
01072027 mov        rcx, r14
0107202a call       qword ptr [rip + 0x876f40]
01072030 test       rax, rax
01072033 jle        0x141072137
01072039 mov        dword ptr [rsi + 0xa00128], 0x686f686d
01072043 mov        dword ptr [rsi + 0xa0012c], 0x18
0107204d mov        dword ptr [rsi + 0xa00134], 0x67
01072057 mov        rcx, r14
0107205a call       qword ptr [rip + 0x876f10]
01072060 add        eax, dword ptr [rsi + 0xa0012c]
01072066 mov        dword ptr [rsi + 0xa00130], eax
0107206c cmp        byte ptr [rsi + 0x52], 0
01072070 jne        0x1410720c1
01072072 movdqu     xmm1, xmmword ptr [rsi + 0xa00128]
0107207a movdqa     xmm2, xmm8
0107207f andps      xmm2, xmm1
01072082 movdqa     xmm0, xmm1
01072086 pslld      xmm0, 0x10
0107208b orps       xmm2, xmm0
0107208e pslld      xmm2, 8
01072093 movdqa     xmm0, xmm1
01072097 psrld      xmm0, 0x18
0107209c orps       xmm2, xmm0
0107209f psrld      xmm1, 8
010720a4 andps      xmm1, xmm8
010720a8 orps       xmm2, xmm1
010720ab movdqu     xmmword ptr [rsi + 0xa00128], xmm2
010720b3 mov        eax, dword ptr [rsi + 0xa00138]
010720b9 bswap      eax
010720bb mov        dword ptr [rsi + 0xa00138], eax
010720c1 mov        qword ptr [rsp + 0x40], 0x18
010720ca lea        r8, [rsi + 0xa00128]
010720d1 lea        rdx, [rsp + 0x40]
010720d6 mov        rcx, qword ptr [rsi + 0x120]
010720dd call       0x140ba04c0
010720e2 mov        ebx, eax
010720e4 mov        rcx, r14
010720e7 test       eax, eax
010720e9 je         0x1410720f6
010720eb call       qword ptr [rip + 0x876d2f]
010720f1 jmp        0x141072543
010720f6 call       qword ptr [rip + 0x876e74]
010720fc mov        rbx, rax
010720ff mov        rcx, r14
01072102 call       qword ptr [rip + 0x876e70]
01072108 mov        qword ptr [rsp + 0x40], rbx
0107210d mov        r8, rax
01072110 lea        rdx, [rsp + 0x40]
01072115 mov        rcx, qword ptr [rsi + 0x120]
0107211c call       0x140ba04c0
01072121 mov        ebx, eax
01072123 mov        rcx, r14
01072126 call       qword ptr [rip + 0x876cf4]
0107212c test       ebx, ebx
0107212e jne        0x141072543
01072134 inc        dword ptr [rbp - 0x54]
01072137 mov        r14, qword ptr [rdi + 0x420]
0107213e test       r14, r14
01072141 je         0x141072377
01072147 lea        r12, [rsi + 0xa00128]
0107214e movsd      xmm7, qword ptr [rip + 0xc01312]
01072156 nop        word ptr [rax + rax]
01072160 xor        edx, edx
01072162 mov        r8d, 0x4c4
01072168 lea        rcx, [rbp + 0xd50]
0107216f call       0x14179cca0
01072174 mov        eax, dword ptr [r14 + 0x10]
01072178 mov        dword ptr [rbp + 0xd50], eax
0107217e movzx      eax, byte ptr [r14 + 0x14]
01072183 mov        byte ptr [rbp + 0xd54], al
01072189 movzx      eax, byte ptr [r14 + 0x15]
0107218e mov        byte ptr [rbp + 0xd55], al
01072194 movzx      eax, byte ptr [r14 + 0x1c]
01072199 mov        byte ptr [rbp + 0xd56], al
0107219f mov        eax, dword ptr [r14 + 0x18]
010721a3 mov        dword ptr [rbp + 0xd58], eax
010721a9 movzx      eax, byte ptr [r14 + 0x1d]
010721ae mov        byte ptr [rbp + 0xd57], al
010721b4 mov        edx, r13d
010721b7 mov        dword ptr [rsp + 0x40], edx
010721bb mov        eax, r13d
010721be lea        rbx, [r14 + 0x22]
010721c2 mov        r15d, r13d
010721c5 cmp        r13w, word ptr [r14 + 0x1e]
010721ca jae        0x14107227c
010721d0 lea        r12, [rbp + 0xd65]
010721d7 mov        edi, eax
010721d9 nop        dword ptr [rax]
010721e0 mov        eax, dword ptr [rbx]
010721e2 mov        dword ptr [rsp + 0x48], eax
010721e6 test       eax, eax
010721e8 je         0x141072253
010721ea movsx      eax, word ptr [rbx + 8]
010721ee movd       xmm6, eax
010721f2 cvtdq2pd   xmm6, xmm6
010721f6 xorps      xmm0, xmm0
010721f9 movdqu     xmmword ptr [rsp + 0x60], xmm0
010721ff lea        rcx, [rsp + 0x60]
01072204 call       0x140ba5e10
01072209 divsd      xmm6, xmm0
0107220d addsd      xmm6, xmm7
01072211 cvttsd2si  eax, xmm6
01072215 mov        word ptr [r12 + 1], ax
0107221b movzx      eax, byte ptr [rbx + 7]
0107221f mov        byte ptr [r12], al
01072223 mov        eax, dword ptr [rsp + 0x48]
01072227 mov        dword ptr [r12 + 3], eax
0107222c mov        byte ptr [r12 - 1], al
01072231 movsx      eax, word ptr [r14 + 0x20]
01072236 mov        edx, dword ptr [rsp + 0x40]
0107223a mov        ecx, edx
0107223c cmp        r15d, eax
0107223f cmovne     ecx, edi
01072242 mov        edi, ecx
01072244 inc        edx
01072246 mov        dword ptr [rsp + 0x40], edx
0107224a cmp        edx, 0x64
0107224d je         0x141072268
0107224f add        r12, 0xc
01072253 add        rbx, 0x1c
01072257 inc        r15d
0107225a movsx      eax, word ptr [r14 + 0x1e]
0107225f cmp        r15d, eax
01072262 jb         0x1410721e0
01072268 mov        dword ptr [rsp + 0x48], edi
0107226c mov        rdi, qword ptr [rsp + 0x58]
01072271 mov        eax, dword ptr [rsp + 0x48]
01072275 lea        r12, [rsi + 0xa00128]
0107227c mov        dword ptr [rbp + 0xd5c], edx
01072282 mov        dword ptr [rbp + 0xd60], eax
01072288 lea        rdx, [rbp + 0xd50]
0107228f mov        rcx, rsi
01072292 call       0x141069e20
01072297 mov        dword ptr [r12], 0x686f686d
0107229f mov        dword ptr [r12 + 4], 0x18
010722a8 mov        dword ptr [r12 + 0xc], 0x69
010722b1 mov        dword ptr [r12 + 8], 0x4dc
010722ba cmp        byte ptr [rsi + 0x52], 0
010722be jne        0x141072309
010722c0 movdqu     xmm1, xmmword ptr [r12]
010722c6 movdqa     xmm2, xmm8
010722cb andps      xmm2, xmm1
010722ce movdqa     xmm0, xmm1
010722d2 pslld      xmm0, 0x10
010722d7 orps       xmm2, xmm0
010722da pslld      xmm2, 8
010722df movdqa     xmm0, xmm1
010722e3 psrld      xmm0, 0x18
010722e8 orps       xmm2, xmm0
010722eb psrld      xmm1, 8
010722f0 andps      xmm1, xmm8
010722f4 orps       xmm2, xmm1
010722f7 movdqu     xmmword ptr [r12], xmm2
010722fd mov        eax, dword ptr [r12 + 0x10]
01072302 bswap      eax
01072304 mov        dword ptr [r12 + 0x10], eax
01072309 mov        qword ptr [rsp + 0x40], 0x18
01072312 mov        r8, r12
01072315 lea        rdx, [rsp + 0x40]
0107231a mov        rcx, qword ptr [rsi + 0x120]
01072321 call       0x140ba04c0
01072326 mov        ebx, eax
01072328 test       eax, eax
0107232a jne        0x141072543
01072330 mov        qword ptr [rsp + 0x40], 0x4c4
01072339 lea        r8, [rbp + 0xd50]
01072340 lea        rdx, [rsp + 0x40]
01072345 mov        rcx, qword ptr [rsi + 0x120]
0107234c call       0x140ba04c0
01072351 mov        ebx, eax
01072353 test       eax, eax
01072355 jne        0x141072543
0107235b inc        dword ptr [rbp - 0x54]
0107235e cmp        dword ptr [r14 + 8], 0x63736574
01072366 jne        0x141072377
01072368 mov        rax, qword ptr [r14]
0107236b mov        r14, rax
0107236e test       rax, rax
01072371 jne        0x141072160
01072377 xor        edx, edx
01072379 mov        r8d, 0xc4
0107237f lea        rcx, [rbp + 0xd50]
01072386 call       0x14179cca0
0107238b mov        eax, dword ptr [rdi + 0x430]
01072391 mov        ecx, 0x10
01072396 cmp        eax, ecx
01072398 cmova      eax, ecx
0107239b mov        dword ptr [rbp + 0xd50], eax
010723a1 test       eax, eax
010723a3 je         0x1410723c2
010723a5 mov        ecx, r13d
010723a8 mov        eax, dword ptr [rdi + rcx*4 + 0x434]
010723af mov        dword ptr [rbp + rcx*4 + 0xd54], eax
010723b6 inc        r13d
010723b9 cmp        r13d, dword ptr [rbp + 0xd50]
010723c0 jb         0x1410723a5
010723c2 lea        rdx, [rbp + 0xd50]
010723c9 mov        rcx, rsi
010723cc call       0x141069f90
010723d1 mov        dword ptr [rsi + 0xa00128], 0x686f686d
010723db mov        dword ptr [rsi + 0xa0012c], 0x18
010723e5 mov        dword ptr [rsi + 0xa00134], 0x6c
010723ef mov        dword ptr [rsi + 0xa00130], 0xdc
010723f9 cmp        byte ptr [rsi + 0x52], 0
010723fd jne        0x14107244e
010723ff movdqu     xmm1, xmmword ptr [rsi + 0xa00128]
01072407 movdqa     xmm2, xmm8
0107240c andps      xmm2, xmm1
0107240f movdqa     xmm0, xmm1
01072413 pslld      xmm0, 0x10
01072418 orps       xmm2, xmm0
0107241b pslld      xmm2, 8
01072420 movdqa     xmm0, xmm1
01072424 psrld      xmm0, 0x18
01072429 orps       xmm2, xmm0
0107242c psrld      xmm1, 8
01072431 andps      xmm1, xmm8
01072435 orps       xmm2, xmm1
01072438 movdqu     xmmword ptr [rsi + 0xa00128], xmm2
01072440 mov        eax, dword ptr [rsi + 0xa00138]
01072446 bswap      eax
01072448 mov        dword ptr [rsi + 0xa00138], eax
0107244e mov        qword ptr [rsp + 0x58], 0x18
01072457 lea        r8, [rsi + 0xa00128]
0107245e lea        rdx, [rsp + 0x58]
01072463 mov        rcx, qword ptr [rsi + 0x120]
0107246a call       0x140ba04c0
0107246f mov        ebx, eax
01072471 test       eax, eax
01072473 jne        0x141072543
01072479 mov        qword ptr [rsp + 0x58], 0xc4
01072482 lea        r8, [rbp + 0xd50]
01072489 lea        rdx, [rsp + 0x58]
0107248e mov        rcx, qword ptr [rsi + 0x120]
01072495 call       0x140ba04c0
0107249a mov        ebx, eax
0107249c test       eax, eax
0107249e jne        0x141072543
010724a4 inc        dword ptr [rbp - 0x54]
010724a7 xor        edx, edx
010724a9 mov        rcx, rdi
010724ac call       0x140f00720
010724b1 mov        rbx, rax
010724b4 test       rax, rax
010724b7 je         0x1410724db
010724b9 mov        rcx, rax
010724bc call       qword ptr [rip + 0x876dfe]
010724c2 test       rax, rax
010724c5 jle        0x1410724db
010724c7 mov        rdx, rbx
010724ca mov        rcx, rsi
010724cd call       0x14106b290
010724d2 mov        ebx, eax
010724d4 test       eax, eax
010724d6 jne        0x141072543
010724d8 inc        dword ptr [rbp - 0x54]
010724db mov        rax, qword ptr [rbp - 0x80]
010724df mov        qword ptr [rsp + 0x20], rax
010724e4 mov        r9, qword ptr [rbp - 0x78]
010724e8 mov        r8, qword ptr [rdi + 0x70]
010724ec lea        rdx, [rbp - 0x60]
010724f0 mov        rcx, rsi
010724f3 call       0x141070770
010724f8 mov        ebx, eax
010724fa test       eax, eax
010724fc jne        0x141072543
010724fe lea        rdx, [rbp - 0x70]
01072502 mov        rcx, qword ptr [rsi + 0x120]
01072509 call       0x140b9ff80
0107250e mov        ebx, eax
01072510 test       eax, eax
01072512 jne        0x141072543
01072514 mov        eax, dword ptr [rbp - 0x70]
01072517 sub        eax, dword ptr [rsp + 0x50]
0107251b mov        dword ptr [rbp - 0x58], eax
0107251e lea        rdx, [rbp - 0x60]
01072522 mov        rcx, rsi
01072525 call       0x141069860
0107252a mov        r9d, 0xdac
01072530 lea        r8, [rbp - 0x60]
01072534 mov        rdx, qword ptr [rsp + 0x50]
01072539 mov        rcx, rsi
0107253c call       0x14106aba0
01072541 mov        ebx, eax
01072543 add        rdi, 0x130
0107254a je         0x141072560
0107254c cmp        dword ptr [rdi], 0x73747263
01072552 jne        0x141072560
01072554 mov        eax, dword ptr [rdi + 0x3c]
01072557 test       eax, eax
01072559 jle        0x141072560
0107255b dec        eax
0107255d mov        dword ptr [rdi + 0x3c], eax
01072560 mov        eax, ebx
01072562 mov        rcx, qword ptr [rbp + 0x1420]
01072569 xor        rcx, rsp
0107256c call       0x14179b8e0
01072571 lea        r11, [rsp + 0x1568]
01072579 movaps     xmm6, xmmword ptr [r11 - 0x18]
0107257e movaps     xmm7, xmmword ptr [r11 - 0x28]
01072583 movaps     xmm8, xmmword ptr [r11 - 0x38]
01072588 mov        rsp, r11
0107258b pop        r15
0107258d pop        r14
0107258f pop        r13
01072591 pop        r12
01072593 pop        rdi
01072594 pop        rsi
01072595 pop        rbx
01072596 pop        rbp
01072597 ret        
