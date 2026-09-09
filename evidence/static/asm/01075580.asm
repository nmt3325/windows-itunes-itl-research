; Original iTunes.exe machine code; base=0x140000000; RVA=0x1075580; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1075580..0x1075670 (exclusive)
01075580 push       rbp
01075582 push       rbx
01075583 push       rsi
01075584 push       r15
01075586 lea        rbp, [rsp - 0x3f]
0107558b sub        rsp, 0x88
01075592 xorps      xmm0, xmm0
01075595 mov        r15, rdx
01075598 mov        rsi, rcx
0107559b lea        rdx, [rbp + 0x67]
0107559f mov        rcx, qword ptr [rcx + 8]
010755a3 xor        eax, eax
010755a5 movups     xmmword ptr [rbp - 0x29], xmm0
010755a9 mov        qword ptr [rbp + 0x27], rax
010755ad movups     xmmword ptr [rbp - 0x19], xmm0
010755b1 movups     xmmword ptr [rbp - 9], xmm0
010755b5 movups     xmmword ptr [rbp + 7], xmm0
010755b9 movups     xmmword ptr [rbp + 0x17], xmm0
010755bd call       0x140bd67d0
010755c2 mov        ebx, eax
010755c4 test       eax, eax
010755c6 jne        0x141075613
010755c8 cmp        byte ptr [rsi + 5], al
010755cb jne        0x141075613
010755cd mov        rcx, qword ptr [rsi + 8]
010755d1 lea        rdx, [rbp + 0x7f]
010755d5 call       0x140bd6640
010755da mov        ebx, eax
010755dc test       eax, eax
010755de jne        0x141075613
010755e0 cmp        byte ptr [rsi + 5], al
010755e3 je         0x1410755fc
010755e5 mov        rax, qword ptr [rsi + 0x38]
010755e9 mov        rcx, qword ptr [rsi + 0x20]
010755ed cmp        rcx, rax
010755f0 jbe        0x1410755f6
010755f2 xor        eax, eax
010755f4 jmp        0x141075602
010755f6 sub        eax, ecx
010755f8 inc        eax
010755fa jmp        0x141075602
010755fc mov        eax, dword ptr [rsi + 0x20]
010755ff sub        eax, dword ptr [rsi + 0x30]
01075602 movsxd     rdx, eax
01075605 add        rdx, qword ptr [rbp + 0x7f]
01075609 cmp        rdx, qword ptr [rbp + 0x67]
0107560d jbe        0x141075613
0107560f mov        qword ptr [rbp + 0x67], rdx
01075613 cmp        byte ptr [rsi + 5], 0
01075617 mov        qword ptr [rbp + 0x77], 0
0107561f je         0x141075627
01075621 mov        rcx, qword ptr [rsi + 0x40]
01075625 jmp        0x14107563c
01075627 mov        rcx, qword ptr [rsi + 8]
0107562b lea        rdx, [rbp + 0x77]
0107562f call       0x140bd6640
01075634 mov        rcx, qword ptr [rbp + 0x77]
01075638 test       eax, eax
0107563a jne        0x14107565a
0107563c cmp        byte ptr [rsi + 5], 0
01075640 mov        rax, qword ptr [rsi + 0x20]
01075644 je         0x14107564f
01075646 sub        rax, qword ptr [rsi + 0x38]
0107564a dec        rax
0107564d jmp        0x141075653
0107564f sub        rax, qword ptr [rsi + 0x30]
01075653 add        rcx, rax
01075656 mov        qword ptr [rbp + 0x77], rcx
0107565a test       ebx, ebx
0107565c jne        0x1410757f3
01075662 sub        qword ptr [rbp + 0x67], rcx
01075666 mov        edx, 0x10
0107566b mov        ecx, 0x100000
; range 0x1075670..0x1075695 (exclusive)
01075670 mov        qword ptr [rsp + 0x80], r14
01075678 call       qword ptr [rip + 0x876cf2]
0107567e mov        r14, rax
01075681 test       rax, rax
01075684 jne        0x141075690
01075686 mov        ebx, 0xffffff94
0107568b jmp        0x1410757eb
01075690 mov        edx, 0x10
; range 0x1075695..0x10757eb (exclusive)
01075695 mov        qword ptr [rsp + 0xb8], rdi
0107569d mov        ecx, 0x200000
010756a2 call       qword ptr [rip + 0x876cc8]
010756a8 mov        rdi, rax
010756ab test       rax, rax
010756ae jne        0x1410756bd
010756b0 mov        ebx, 0xffffff94
010756b5 mov        rcx, r14
010756b8 jmp        0x1410757dd
010756bd mov        r9d, 0x58
010756c3 lea        r8, [rip + 0xa52882]
010756ca mov        edx, 1
010756cf lea        rcx, [rbp - 0x29]
010756d3 call       qword ptr [rip + 0x877877]
010756d9 test       eax, eax
010756db je         0x1410756e7
010756dd mov        ebx, 0xffffffce
010756e2 jmp        0x1410757d1
010756e7 mov        rcx, qword ptr [rbp + 0x67]
010756eb test       rcx, rcx
010756ee je         0x141075790
010756f4 nop        dword ptr [rax]
010756f8 nop        dword ptr [rax + rax]
01075700 mov        eax, 0x100000
01075705 lea        rdx, [rbp + 0x7f]
01075709 cmp        rcx, rax
0107570c mov        r8, r14
0107570f cmovb      rax, rcx
01075713 mov        rcx, rsi
01075716 mov        qword ptr [rbp + 0x7f], rax
0107571a call       0x140ba0350
0107571f mov        ebx, eax
01075721 test       eax, eax
01075723 jne        0x1410757d1
01075729 mov        rax, qword ptr [rbp + 0x7f]
0107572d sub        qword ptr [rbp + 0x67], rax
01075731 mov        dword ptr [rbp - 0x21], eax
01075734 mov        qword ptr [rbp - 0x29], r14
01075738 nop        dword ptr [rax + rax]
01075740 xor        edx, edx
01075742 mov        qword ptr [rbp - 0x19], rdi
01075746 lea        rcx, [rbp - 0x29]
0107574a mov        dword ptr [rbp - 0x11], 0x200000
01075751 call       qword ptr [rip + 0x877801]
01075757 mov        eax, 0x200000
0107575c lea        rdx, [rbp + 0x7f]
01075760 sub        eax, dword ptr [rbp - 0x11]
01075763 mov        r8, rdi
01075766 mov        rcx, r15
01075769 mov        qword ptr [rbp + 0x7f], rax
0107576d call       0x140ba04c0
01075772 mov        ebx, eax
01075774 test       eax, eax
01075776 jne        0x1410757d1
01075778 cmp        dword ptr [rbp - 0x21], eax
0107577b jne        0x141075740
0107577d mov        rcx, qword ptr [rbp + 0x67]
01075781 test       rcx, rcx
01075784 jne        0x141075700
0107578a nop        word ptr [rax + rax]
01075790 mov        edx, 4
01075795 mov        qword ptr [rbp - 0x19], rdi
01075799 lea        rcx, [rbp - 0x29]
0107579d mov        dword ptr [rbp - 0x11], 0x200000
010757a4 call       qword ptr [rip + 0x8777ae]
010757aa mov        ecx, 0x200000
010757af lea        rdx, [rbp + 0x7f]
010757b3 sub        ecx, dword ptr [rbp - 0x11]
010757b6 mov        r8, rdi
010757b9 mov        qword ptr [rbp + 0x7f], rcx
010757bd mov        esi, eax
010757bf mov        rcx, r15
010757c2 call       0x140ba04c0
010757c7 mov        ebx, eax
010757c9 test       eax, eax
010757cb jne        0x1410757d1
010757cd test       esi, esi
010757cf je         0x141075790
010757d1 mov        rcx, r14
010757d4 call       qword ptr [rip + 0x876b8e]
010757da mov        rcx, rdi
010757dd call       qword ptr [rip + 0x876b85]
010757e3 mov        rdi, qword ptr [rsp + 0xb8]
; range 0x10757eb..0x10757f3 (exclusive)
010757eb mov        r14, qword ptr [rsp + 0x80]
; range 0x10757f3..0x107580c (exclusive)
010757f3 lea        rcx, [rbp - 0x29]
010757f7 call       qword ptr [rip + 0x87776b]
010757fd mov        eax, ebx
010757ff add        rsp, 0x88
01075806 pop        r15
01075808 pop        rsi
01075809 pop        rbx
0107580a pop        rbp
0107580b ret        
