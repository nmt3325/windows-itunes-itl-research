; Original iTunes.exe machine code; base=0x140000000; RVA=0x1070770; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1070770..0x107079c (exclusive)
01070770 mov        qword ptr [rsp + 0x20], rbp
01070775 push       rsi
01070776 push       rdi
01070777 push       r12
01070779 push       r13
0107077b push       r15
0107077d sub        rsp, 0x40
01070781 mov        rsi, qword ptr [r8 + 0x50]
01070785 xor        edi, edi
01070787 mov        r12, r9
0107078a mov        r13, r8
0107078d mov        r15, rdx
01070790 mov        rbp, rcx
01070793 test       rsi, rsi
01070796 je         0x141070b49
; range 0x107079c..0x1070b49 (exclusive)
0107079c mov        qword ptr [rsp + 0x70], rbx
010707a1 mov        qword ptr [rsp + 0x78], r14
010707a6 test       byte ptr [rsi + 0x4b], 1
010707aa jne        0x1410707e0
010707ac mov        rbx, qword ptr [rsi + 0x30]
010707b0 mov        edx, 1
010707b5 mov        rbx, qword ptr [rbx + 0x58]
010707b9 test       rbx, rbx
010707bc je         0x141070b2b
010707c2 mov        rcx, rbx
010707c5 call       0x14106b450
010707ca test       al, al
010707cc jne        0x1410707e0
010707ce mov        rbx, qword ptr [rbx]
010707d1 mov        edx, 0xd
010707d6 test       rbx, rbx
010707d9 jne        0x1410707c2
010707db jmp        0x141070b2b
010707e0 test       r12, r12
010707e3 je         0x141070800
010707e5 mov        r8, qword ptr [rsp + 0x90]
010707ed mov        rdx, rsi
010707f0 mov        ecx, 3
010707f5 call       r12
010707f8 test       al, al
010707fa je         0x141070b2b
01070800 lea        rbx, [rbp + 0xa00128]
01070807 lea        rax, [rbp + 0xa0017c]
0107080e mov        qword ptr [rsp + 0x80], rax
01070816 test       rbx, rbx
01070819 je         0x141070849
0107081b xorps      xmm0, xmm0
0107081e xor        eax, eax
01070820 movups     xmmword ptr [rbp + 0xa00130], xmm0
01070827 movups     xmmword ptr [rbp + 0xa00140], xmm0
0107082e movups     xmmword ptr [rbp + 0xa00150], xmm0
01070835 movups     xmmword ptr [rbp + 0xa00160], xmm0
0107083c mov        qword ptr [rbp + 0xa00170], rax
01070843 mov        dword ptr [rbp + 0xa00178], eax
01070849 mov        dword ptr [rbx], 0x6870746d
0107084f mov        dword ptr [rbx + 4], 0x54
01070856 mov        eax, dword ptr [rsi + 0x28]
01070859 mov        dword ptr [rbx + 0x10], eax
0107085c mov        rax, qword ptr [rsi + 0x20]
01070860 mov        qword ptr [rbx + 0x44], rax
01070864 movzx      eax, byte ptr [rsi + 0x4b]
01070868 and        al, 1
0107086a mov        byte ptr [rbx + 0x1c], al
0107086d movzx      eax, byte ptr [rsi + 0x4b]
01070871 shr        al, 5
01070874 and        al, 1
01070876 mov        byte ptr [rbx + 0x28], al
01070879 cmp        qword ptr [r13 + 8], 0
0107087e je         0x141070887
01070880 mov        eax, dword ptr [r13 + 0x28]
01070884 mov        dword ptr [rbx + 0x14], eax
01070887 movzx      eax, byte ptr [rsi + 0x4b]
0107088b test       al, 1
0107088d je         0x141070a57
01070893 shr        al, 7
01070896 xor        edi, edi
01070898 mov        byte ptr [rbx + 0x1d], al
0107089b movzx      eax, byte ptr [rsi + 0x70]
0107089f mov        byte ptr [rbx + 0x2a], al
010708a2 mov        rdx, qword ptr [rsi]
010708a5 movsxd     r9, dword ptr [rsi + 0x68]
010708a9 add        rdx, 0x130
010708b0 test       r9d, r9d
010708b3 je         0x14107096b
010708b9 xor        r14d, r14d
010708bc xor        r11d, r11d
010708bf test       rdx, rdx
010708c2 je         0x141070b3a
010708c8 cmp        dword ptr [rdx], 0x73747263
010708ce jne        0x141070b3a
010708d4 cmp        dword ptr [rdx + 0x3c], edi
010708d7 je         0x141070b3a
010708dd test       r9d, r9d
010708e0 jle        0x141070b3a
010708e6 cmp        r9d, dword ptr [rdx + 0x2c]
010708ea jg         0x141070b3a
010708f0 mov        rax, qword ptr [rdx + 0x10]
010708f4 lea        r8, [r9 - 1]
010708f8 mov        rax, qword ptr [rax]
010708fb lea        r8, [rax + r8*8]
010708ff test       r8, r8
01070902 je         0x141070923
01070904 movsxd     r10, dword ptr [r8]
01070907 test       r10d, r10d
0107090a js         0x141070923
0107090c mov        ecx, dword ptr [r8 + 4]
01070910 test       ecx, ecx
01070912 jle        0x141070923
01070914 mov        rax, qword ptr [rdx + 0x20]
01070918 mov        r11, r10
0107091b mov        r14d, ecx
0107091e add        r11, qword ptr [rax]
01070921 jmp        0x141070928
01070923 mov        edi, 0xffffffce
01070928 test       edi, edi
0107092a jne        0x141070b3f
01070930 test       r14d, r14d
01070933 je         0x14107096b
01070935 lea        rax, [rsp + 0x80]
0107093d mov        r8d, r14d
01070940 mov        qword ptr [rsp + 0x30], rax
01070945 mov        rdx, r11
01070948 mov        dword ptr [rsp + 0x28], 1
01070950 mov        rcx, rbp
01070953 mov        dword ptr [rsp + 0x20], 0xc8
0107095b call       0x14106ac80
01070960 mov        edi, eax
01070962 test       eax, eax
01070964 jne        0x14107096b
01070966 inc        dword ptr [rbx + 0xc]
01070969 jmp        0x141070973
0107096b test       edi, edi
0107096d jne        0x141070b3f
01070973 mov        rdx, qword ptr [rsi]
01070976 xor        edi, edi
01070978 movsxd     r9, dword ptr [rsi + 0x6c]
0107097c add        rdx, 0x130
01070983 test       r9d, r9d
01070986 je         0x141070a3e
0107098c xor        r14d, r14d
0107098f xor        r11d, r11d
01070992 test       rdx, rdx
01070995 je         0x141070b3a
0107099b cmp        dword ptr [rdx], 0x73747263
010709a1 jne        0x141070b3a
010709a7 cmp        dword ptr [rdx + 0x3c], edi
010709aa je         0x141070b3a
010709b0 test       r9d, r9d
010709b3 jle        0x141070b3a
010709b9 cmp        r9d, dword ptr [rdx + 0x2c]
010709bd jg         0x141070b3a
010709c3 mov        rax, qword ptr [rdx + 0x10]
010709c7 lea        r8, [r9 - 1]
010709cb mov        rax, qword ptr [rax]
010709ce lea        r8, [rax + r8*8]
010709d2 test       r8, r8
010709d5 je         0x1410709f6
010709d7 movsxd     r10, dword ptr [r8]
010709da test       r10d, r10d
010709dd js         0x1410709f6
010709df mov        ecx, dword ptr [r8 + 4]
010709e3 test       ecx, ecx
010709e5 jle        0x1410709f6
010709e7 mov        rax, qword ptr [rdx + 0x20]
010709eb mov        r11, r10
010709ee mov        r14d, ecx
010709f1 add        r11, qword ptr [rax]
010709f4 jmp        0x1410709fb
010709f6 mov        edi, 0xffffffce
010709fb test       edi, edi
010709fd jne        0x141070b3f
01070a03 test       r14d, r14d
01070a06 je         0x141070a3e
01070a08 lea        rax, [rsp + 0x80]
01070a10 mov        r8d, r14d
01070a13 mov        qword ptr [rsp + 0x30], rax
01070a18 mov        rdx, r11
01070a1b mov        dword ptr [rsp + 0x28], 1
01070a23 mov        rcx, rbp
01070a26 mov        dword ptr [rsp + 0x20], 0xc9
01070a2e call       0x14106ac80
01070a33 mov        edi, eax
01070a35 test       eax, eax
01070a37 jne        0x141070a3e
01070a39 inc        dword ptr [rbx + 0xc]
01070a3c jmp        0x141070a46
01070a3e test       edi, edi
01070a40 jne        0x141070b3f
01070a46 mov        rax, qword ptr [rsi + 0x30]
01070a4a test       rax, rax
01070a4d je         0x141070a67
01070a4f mov        eax, dword ptr [rax + 8]
01070a52 mov        dword ptr [rbx + 0x18], eax
01070a55 jmp        0x141070a67
01070a57 mov        eax, dword ptr [rsi + 0x58]
01070a5a mov        dword ptr [rbx + 0x20], eax
01070a5d mov        rax, qword ptr [rsi + 0x30]
01070a61 mov        ecx, dword ptr [rax + 8]
01070a64 mov        dword ptr [rbx + 0x18], ecx
01070a67 mov        ecx, dword ptr [rsp + 0x80]
01070a6e sub        ecx, ebp
01070a70 add        ecx, 0xff5ffed8
01070a76 mov        dword ptr [rbx + 8], ecx
01070a79 cmp        byte ptr [rbp + 0x52], 0
01070a7d jne        0x141070ad2
01070a7f mov        eax, dword ptr [rbx]
01070a81 bswap      eax
01070a83 mov        dword ptr [rbx], eax
01070a85 mov        eax, dword ptr [rbx + 4]
01070a88 bswap      eax
01070a8a mov        dword ptr [rbx + 4], eax
01070a8d mov        eax, ecx
01070a8f bswap      eax
01070a91 mov        dword ptr [rbx + 8], eax
01070a94 mov        eax, dword ptr [rbx + 0xc]
01070a97 bswap      eax
01070a99 mov        dword ptr [rbx + 0xc], eax
01070a9c mov        eax, dword ptr [rbx + 0x10]
01070a9f bswap      eax
01070aa1 mov        dword ptr [rbx + 0x10], eax
01070aa4 mov        eax, dword ptr [rbx + 0x14]
01070aa7 bswap      eax
01070aa9 mov        dword ptr [rbx + 0x14], eax
01070aac mov        eax, dword ptr [rbx + 0x18]
01070aaf bswap      eax
01070ab1 mov        dword ptr [rbx + 0x18], eax
01070ab4 mov        eax, dword ptr [rbx + 0x20]
01070ab7 bswap      eax
01070ab9 mov        dword ptr [rbx + 0x20], eax
01070abc mov        rax, qword ptr [rbx + 0x3c]
01070ac0 bswap      rax
01070ac3 mov        qword ptr [rbx + 0x3c], rax
01070ac7 mov        rax, qword ptr [rbx + 0x44]
01070acb bswap      rax
01070ace mov        qword ptr [rbx + 0x44], rax
01070ad2 mov        eax, ecx
01070ad4 lea        r8, [rbp + 0xa00128]
01070adb mov        rcx, qword ptr [rbp + 0x120]
01070ae2 lea        rdx, [rsp + 0x80]
01070aea mov        qword ptr [rsp + 0x80], rax
01070af2 call       0x140ba04c0
01070af7 mov        edi, eax
01070af9 test       eax, eax
01070afb jne        0x141070b3f
01070afd test       byte ptr [rsi + 0x4b], 1
01070b01 je         0x141070b27
01070b03 mov        rax, qword ptr [rsp + 0x90]
01070b0b mov        r9, r12
01070b0e mov        r8, rsi
01070b11 mov        qword ptr [rsp + 0x20], rax
01070b16 mov        rdx, r15
01070b19 mov        rcx, rbp
01070b1c call       0x141070770
01070b21 mov        edi, eax
01070b23 test       eax, eax
01070b25 jne        0x141070b3f
01070b27 inc        dword ptr [r15 + 0x10]
01070b2b mov        rsi, qword ptr [rsi + 0x10]
01070b2f test       rsi, rsi
01070b32 jne        0x1410707a6
01070b38 jmp        0x141070b3f
01070b3a mov        edi, 0xffffffce
01070b3f mov        r14, qword ptr [rsp + 0x78]
01070b44 mov        rbx, qword ptr [rsp + 0x70]
; range 0x1070b49..0x1070b60 (exclusive)
01070b49 mov        rbp, qword ptr [rsp + 0x88]
01070b51 mov        eax, edi
01070b53 add        rsp, 0x40
01070b57 pop        r15
01070b59 pop        r13
01070b5b pop        r12
01070b5d pop        rdi
01070b5e pop        rsi
01070b5f ret        
