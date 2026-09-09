; Original iTunes.exe machine code; base=0x140000000; RVA=0x1081790; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1081790..0x108189e (exclusive)
01081790 push       rbx
01081792 push       rsi
01081793 push       rdi
01081794 sub        rsp, 0x90
0108179b mov        rax, qword ptr [rip + 0xf5389e]
010817a2 xor        rax, rsp
010817a5 mov        qword ptr [rsp + 0x80], rax
010817ad mov        rsi, rcx
010817b0 mov        edx, 0x10
010817b5 mov        ecx, 0x1e00308
010817ba mov        rdi, r8
010817bd call       qword ptr [rip + 0x86abad]
010817c3 mov        rbx, rax
010817c6 test       rax, rax
010817c9 je         0x141081a4f
010817cf xor        edx, edx
010817d1 mov        r8d, 0x120
010817d7 mov        rcx, rax
010817da call       0x14179cca0
010817df lea        rcx, [rbx + 0x128]
010817e6 xor        edx, edx
010817e8 mov        r8d, 0x1e00038
010817ee call       0x14179cca0
010817f3 lea        rcx, [rbx + 0x1e00170]
010817fa xor        edx, edx
010817fc mov        r8d, 0x100
01081802 call       0x14179cca0
01081807 xorps      xmm0, xmm0
0108180a mov        rcx, rbx
0108180d movups     xmmword ptr [rbx + 0x1e00278], xmm0
01081814 movups     xmmword ptr [rbx + 0x1e00288], xmm0
0108181b movups     xmmword ptr [rbx + 0x1e00298], xmm0
01081822 movups     xmmword ptr [rbx + 0x1e002a8], xmm0
01081829 movups     xmmword ptr [rbx + 0x1e002b8], xmm0
01081830 movups     xmmword ptr [rbx + 0x1e002c8], xmm0
01081837 movups     xmmword ptr [rbx + 0x1e002d8], xmm0
0108183e movups     xmmword ptr [rbx + 0x1e002e8], xmm0
01081845 movups     xmmword ptr [rbx + 0x1e002f8], xmm0
0108184c mov        qword ptr [rbx + 0x1e00270], rsi
01081853 mov        qword ptr [rbx + 0x120], rdi
0108185a mov        qword ptr [rbx + 0x1e00160], 0xffffffffffffffff
01081865 mov        qword ptr [rbx + 0x1e00168], 0xffffffffffffffff
01081870 call       0x14106a430
01081875 mov        r8d, 8
0108187b mov        byte ptr [rbx + 0x41], 0
0108187f lea        rdx, [rsp + 0x20]
01081884 mov        rcx, rbx
01081887 call       0x1410770a0
0108188c mov        edi, eax
0108188e test       eax, eax
01081890 jne        0x141081a42
01081896 mov        r10d, dword ptr [rsp + 0x24]
0108189b mov        esi, r10d
; range 0x108189e..0x1081a42 (exclusive)
0108189e mov        qword ptr [rsp + 0xb0], rbp
010818a6 mov        qword ptr [rsp + 0xb8], r14
010818ae cmp        byte ptr [rbx + 0x52], al
010818b1 jne        0x1410818b5
010818b3 bswap      esi
010818b5 mov        r14d, 0x60
010818bb mov        qword ptr [rsp + 0xc0], r15
010818c3 cmp        esi, r14d
010818c6 lea        rcx, [rsp + 0x28]
010818cb mov        ebp, r14d
010818ce cmovb      ebp, esi
010818d1 cmp        ebp, 8
010818d4 jbe        0x14108190e
010818d6 lea        r15d, [rbp - 8]
010818da cmp        r15, 0xa00000
010818e1 ja         0x141081a14
010818e7 mov        r8d, r15d
010818ea lea        rdx, [rsp + 0x28]
010818ef mov        rcx, rbx
010818f2 call       0x1410770a0
010818f7 mov        edi, eax
010818f9 test       eax, eax
010818fb jne        0x141081a2a
01081901 mov        r10d, dword ptr [rsp + 0x24]
01081906 lea        rcx, [rsp + 0x28]
0108190b add        rcx, r15
0108190e cmp        ebp, r14d
01081911 jae        0x14108192a
01081913 test       rcx, rcx
01081916 je         0x14108192a
01081918 sub        r14d, ebp
0108191b xor        edx, edx
0108191d mov        r8d, r14d
01081920 call       0x14179cca0
01081925 mov        r10d, dword ptr [rsp + 0x24]
0108192a cmp        esi, ebp
0108192c jbe        0x141081944
0108192e sub        esi, ebp
01081930 mov        rcx, rbx
01081933 mov        edx, esi
01081935 call       0x14106a520
0108193a mov        edi, eax
0108193c test       eax, eax
0108193e jne        0x141081a2a
01081944 cmp        byte ptr [rbx + 0x52], 0
01081948 jne        0x141081a06
0108194e mov        ecx, dword ptr [rsp + 0x20]
01081952 mov        r8d, ecx
01081955 mov        eax, ecx
01081957 and        r8d, 0xff0000
0108195e shr        eax, 0x10
01081961 or         r8d, eax
01081964 mov        eax, ecx
01081966 and        eax, 0xff00
0108196b shl        ecx, 0x10
0108196e or         eax, ecx
01081970 shr        r8d, 8
01081974 shl        eax, 8
01081977 mov        ecx, r10d
0108197a or         r8d, eax
0108197d and        ecx, 0xff0000
01081983 mov        eax, r10d
01081986 mov        dword ptr [rsp + 0x20], r8d
0108198b shr        eax, 0x10
0108198e or         ecx, eax
01081990 mov        eax, r10d
01081993 shl        eax, 0x10
01081996 and        r10d, 0xff00
0108199d or         eax, r10d
010819a0 shr        ecx, 8
010819a3 shl        eax, 8
010819a6 or         ecx, eax
010819a8 mov        dword ptr [rsp + 0x24], ecx
010819ac mov        ecx, dword ptr [rsp + 0x28]
010819b0 mov        edx, ecx
010819b2 and        edx, 0xff0000
010819b8 mov        eax, ecx
010819ba shr        eax, 0x10
010819bd or         edx, eax
010819bf mov        eax, ecx
010819c1 shl        eax, 0x10
010819c4 and        ecx, 0xff00
010819ca or         eax, ecx
010819cc shr        edx, 8
010819cf mov        ecx, dword ptr [rsp + 0x2c]
010819d3 shl        eax, 8
010819d6 or         edx, eax
010819d8 mov        eax, ecx
010819da shr        eax, 0x10
010819dd mov        dword ptr [rsp + 0x28], edx
010819e1 mov        edx, ecx
010819e3 and        edx, 0xff0000
010819e9 or         edx, eax
010819eb mov        eax, ecx
010819ed shl        eax, 0x10
010819f0 and        ecx, 0xff00
010819f6 or         eax, ecx
010819f8 shr        edx, 8
010819fb shl        eax, 8
010819fe or         edx, eax
01081a00 mov        dword ptr [rsp + 0x2c], edx
01081a04 jmp        0x141081a0b
01081a06 mov        r8d, dword ptr [rsp + 0x20]
01081a0b cmp        r8d, 0x6864736d
01081a12 je         0x141081a1b
01081a14 mov        edi, 0xffffff30
01081a19 jmp        0x141081a2a
01081a1b mov        edx, 0x80000000
01081a20 mov        rcx, rbx
01081a23 call       0x14107ee90
01081a28 mov        edi, eax
01081a2a mov        r15, qword ptr [rsp + 0xc0]
01081a32 mov        rbp, qword ptr [rsp + 0xb0]
01081a3a mov        r14, qword ptr [rsp + 0xb8]
; range 0x1081a42..0x1081a6f (exclusive)
01081a42 mov        rcx, rbx
01081a45 call       qword ptr [rip + 0x86a91d]
01081a4b mov        eax, edi
01081a4d jmp        0x141081a54
01081a4f mov        eax, 0xffffff94
01081a54 mov        rcx, qword ptr [rsp + 0x80]
01081a5c xor        rcx, rsp
01081a5f call       0x14179b8e0
01081a64 add        rsp, 0x90
01081a6b pop        rdi
01081a6c pop        rsi
01081a6d pop        rbx
01081a6e ret        
