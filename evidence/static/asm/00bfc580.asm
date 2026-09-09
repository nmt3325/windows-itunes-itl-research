; Original iTunes.exe machine code; base=0x140000000; RVA=0xbfc580; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0xbfc580..0xbfc5ed (exclusive)
00bfc580 push       rsi
00bfc582 push       rdi
00bfc583 push       r12
00bfc585 push       r13
00bfc587 push       r15
00bfc589 sub        rsp, 0x70
00bfc58d mov        rax, qword ptr [rip + 0x13d8aac]
00bfc594 xor        rax, rsp
00bfc597 mov        qword ptr [rsp + 0x48], rax
00bfc59c mov        r13, qword ptr [rsp + 0xc0]
00bfc5a4 mov        r12, r9
00bfc5a7 mov        edi, r8d
00bfc5aa mov        r15, rdx
00bfc5ad mov        rsi, rcx
00bfc5b0 test       rcx, rcx
00bfc5b3 je         0x140bfc870
00bfc5b9 cmp        byte ptr [rcx], 0
00bfc5bc je         0x140bfc870
00bfc5c2 test       rdx, rdx
00bfc5c5 je         0x140bfc869
00bfc5cb test       r8d, r8d
00bfc5ce je         0x140bfc869
00bfc5d4 test       r9, r9
00bfc5d7 je         0x140bfc862
00bfc5dd mov        r10d, dword ptr [r13]
00bfc5e1 cmp        r10d, r8d
00bfc5e4 jb         0x140bfc862
00bfc5ea mov        ecx, dword ptr [rcx + 4]
; range 0xbfc5ed..0xbfc678 (exclusive)
00bfc5ed mov        qword ptr [rsp + 0x58], r14
00bfc5f2 xor        r14d, r14d
00bfc5f5 sub        ecx, 1
00bfc5f8 je         0x140bfc678
00bfc5fa cmp        ecx, 1
00bfc5fd jne        0x140bfc858
00bfc603 mov        ecx, dword ptr [rsi + 0xc]
00bfc606 mov        r8d, r14d
00bfc609 mov        dword ptr [rsp + 0x34], r10d
00bfc60e sub        ecx, 1
00bfc611 je         0x140bfc635
00bfc613 cmp        ecx, 1
00bfc616 jne        0x140bfc653
00bfc618 mov        rcx, qword ptr [rsi + 0x20]
00bfc61c lea        r8, [rsp + 0x34]
00bfc621 mov        r9, rdx
00bfc624 mov        dword ptr [rsp + 0x20], edi
00bfc628 mov        rdx, r12
00bfc62b mov        rcx, qword ptr [rcx]
00bfc62e call       0x1417e9380
00bfc633 jmp        0x140bfc650
00bfc635 mov        rcx, qword ptr [rsi + 0x20]
00bfc639 lea        r8, [rsp + 0x34]
00bfc63e mov        r9, r15
00bfc641 mov        dword ptr [rsp + 0x20], edi
00bfc645 mov        rdx, r12
00bfc648 mov        rcx, qword ptr [rcx]
00bfc64b call       0x1417e9660
00bfc650 mov        r8d, eax
00bfc653 mov        eax, dword ptr [rsp + 0x34]
00bfc657 mov        dword ptr [r13], eax
00bfc65b cmp        r8d, 1
00bfc65f je         0x140bfc858
00bfc665 mov        r14d, 0x20a5
00bfc66b mov        eax, r14d
00bfc66e mov        r14, qword ptr [rsp + 0x58]
00bfc673 jmp        0x140bfc875
; range 0xbfc678..0xbfc6be (exclusive)
00bfc678 mov        edx, dword ptr [rsi + 8]
00bfc67b mov        qword ptr [rsp + 0x68], rbx
00bfc680 sub        edx, 1
00bfc683 je         0x140bfc7e7
00bfc689 sub        edx, 1
00bfc68c je         0x140bfc70a
00bfc68e sub        edx, 1
00bfc691 je         0x140bfc6be
00bfc693 cmp        edx, 1
00bfc696 jne        0x140bfc853
00bfc69c mov        rdx, r15
00bfc69f mov        qword ptr [rsp + 0x20], r13
00bfc6a4 mov        rcx, rsi
00bfc6a7 call       0x140bfc320
00bfc6ac mov        rbx, qword ptr [rsp + 0x68]
00bfc6b1 mov        r14d, eax
00bfc6b4 mov        r14, qword ptr [rsp + 0x58]
00bfc6b9 jmp        0x140bfc875
; range 0xbfc6be..0xbfc7e7 (exclusive)
00bfc6be mov        ebx, edi
00bfc6c0 mov        qword ptr [rsp + 0x20], r13
00bfc6c5 mov        rdx, r15
00bfc6c8 mov        rcx, rsi
00bfc6cb and        ebx, 0xf
00bfc6ce call       0x140bfc1e0
00bfc6d3 test       eax, eax
00bfc6d5 jne        0x140bfc6ac
00bfc6d7 test       ebx, ebx
00bfc6d9 je         0x140bfc853
00bfc6df mov        eax, dword ptr [r13]
00bfc6e3 lea        rdx, [rax + r15]
00bfc6e7 lea        rcx, [rax + r12]
00bfc6eb test       rdx, rdx
00bfc6ee je         0x140bfc84f
00bfc6f4 test       rcx, rcx
00bfc6f7 je         0x140bfc84f
00bfc6fd mov        r8d, ebx
00bfc700 call       0x141867875
00bfc705 jmp        0x140bfc84f
00bfc70a mov        ebx, r14d
00bfc70d test       edi, edi
00bfc70f je         0x140bfc84f
00bfc715 nop        word ptr [rax + rax]
00bfc720 mov        r8, qword ptr [rsi + 0x20]
00bfc724 lea        rdx, [rsp + 0x38]
00bfc729 mov        rcx, qword ptr [rsi + 0x30]
00bfc72d call       0x140bfa2a0
00bfc732 mov        rcx, qword ptr [rsi + 0x30]
00bfc736 mov        edx, 2
00bfc73b sub        rdx, rcx
00bfc73e lea        rax, [rcx + 0xd]
00bfc742 add        byte ptr [rax + 2], 1
00bfc746 jne        0x140bfc766
00bfc748 add        byte ptr [rax + 1], 1
00bfc74c jne        0x140bfc766
00bfc74e add        byte ptr [rax], 1
00bfc751 jne        0x140bfc766
00bfc753 add        byte ptr [rax - 1], 1
00bfc757 jne        0x140bfc766
00bfc759 sub        rax, 4
00bfc75d lea        rcx, [rdx + rax]
00bfc761 test       rcx, rcx
00bfc764 jns        0x140bfc742
00bfc766 lea        r8d, [rbx + 0x10]
00bfc76a cmp        r8d, edi
00bfc76d ja         0x140bfc7b0
00bfc76f mov        eax, ebx
00bfc771 mov        ebx, r8d
00bfc774 lea        rdx, [rax + r12]
00bfc778 lea        rcx, [rax + r15]
00bfc77c mov        eax, dword ptr [rsp + 0x38]
00bfc780 xor        eax, dword ptr [rcx]
00bfc782 mov        dword ptr [rdx], eax
00bfc784 mov        eax, dword ptr [rsp + 0x3c]
00bfc788 xor        eax, dword ptr [rcx + 4]
00bfc78b mov        dword ptr [rdx + 4], eax
00bfc78e mov        eax, dword ptr [rsp + 0x40]
00bfc792 xor        eax, dword ptr [rcx + 8]
00bfc795 mov        dword ptr [rdx + 8], eax
00bfc798 mov        eax, dword ptr [rsp + 0x44]
00bfc79c xor        eax, dword ptr [rcx + 0xc]
00bfc79f mov        dword ptr [rdx + 0xc], eax
00bfc7a2 cmp        r8d, edi
00bfc7a5 jb         0x140bfc720
00bfc7ab jmp        0x140bfc84f
00bfc7b0 mov        edx, edi
00bfc7b2 sub        edx, ebx
00bfc7b4 je         0x140bfc84f
00bfc7ba mov        eax, ebx
00bfc7bc lea        r8, [rsp + 0x38]
00bfc7c1 sub        r15, r12
00bfc7c4 sub        r8, rax
00bfc7c7 sub        r8, r12
00bfc7ca lea        rcx, [rax + r12]
00bfc7ce nop        
00bfc7d0 movzx      eax, byte ptr [r8 + rcx]
00bfc7d5 xor        al, byte ptr [r15 + rcx]
00bfc7d9 mov        byte ptr [rcx], al
00bfc7db lea        rcx, [rcx + 1]
00bfc7df sub        rdx, 1
00bfc7e3 jne        0x140bfc7d0
00bfc7e5 jmp        0x140bfc84f
; range 0xbfc7e7..0xbfc84f (exclusive)
00bfc7e7 mov        qword ptr [rsp + 0x60], rbp
00bfc7ec mov        ebx, r14d
00bfc7ef mov        ebp, edi
00bfc7f1 and        ebp, 0xf
00bfc7f4 cmp        edi, 0x10
00bfc7f7 jb         0x140bfc82a
00bfc7f9 nop        dword ptr [rax]
00bfc800 cmp        dword ptr [rsi + 0xc], 1
00bfc804 mov        r8, qword ptr [rsi + 0x20]
00bfc808 mov        eax, ebx
00bfc80a lea        rdx, [rax + r12]
00bfc80e lea        rcx, [rax + r15]
00bfc812 jne        0x140bfc81b
00bfc814 call       0x140bfa2a0
00bfc819 jmp        0x140bfc820
00bfc81b call       0x140bfb050
00bfc820 add        ebx, 0x10
00bfc823 lea        eax, [rbx + 0x10]
00bfc826 cmp        eax, edi
00bfc828 jbe        0x140bfc800
00bfc82a test       ebp, ebp
00bfc82c je         0x140bfc84a
00bfc82e mov        eax, ebx
00bfc830 lea        rdx, [rax + r15]
00bfc834 lea        rcx, [rax + r12]
00bfc838 test       rdx, rdx
00bfc83b je         0x140bfc84a
00bfc83d test       rcx, rcx
00bfc840 je         0x140bfc84a
00bfc842 mov        r8d, ebp
00bfc845 call       0x141867875
00bfc84a mov        rbp, qword ptr [rsp + 0x60]
; range 0xbfc84f..0xbfc858 (exclusive)
00bfc84f mov        dword ptr [r13], edi
00bfc853 mov        rbx, qword ptr [rsp + 0x68]
; range 0xbfc858..0xbfc862 (exclusive)
00bfc858 mov        eax, r14d
00bfc85b mov        r14, qword ptr [rsp + 0x58]
00bfc860 jmp        0x140bfc875
; range 0xbfc862..0xbfc88f (exclusive)
00bfc862 mov        eax, 0x2071
00bfc867 jmp        0x140bfc875
00bfc869 mov        eax, 0x2070
00bfc86e jmp        0x140bfc875
00bfc870 mov        eax, 0x206f
00bfc875 mov        rcx, qword ptr [rsp + 0x48]
00bfc87a xor        rcx, rsp
00bfc87d call       0x14179b8e0
00bfc882 add        rsp, 0x70
00bfc886 pop        r15
00bfc888 pop        r13
00bfc88a pop        r12
00bfc88c pop        rdi
00bfc88d pop        rsi
00bfc88e ret        
