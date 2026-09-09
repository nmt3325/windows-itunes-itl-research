; Original iTunes.exe machine code; base=0x140000000; RVA=0x107ea60; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x107ea60..0x107ee8c (exclusive)
0107ea60 mov        qword ptr [rsp + 0x10], rbx
0107ea65 mov        qword ptr [rsp + 0x18], rsi
0107ea6a mov        qword ptr [rsp + 0x20], rdi
0107ea6f push       rbp
0107ea70 push       r12
0107ea72 push       r13
0107ea74 push       r14
0107ea76 push       r15
0107ea78 lea        rbp, [rsp - 0x37]
0107ea7d sub        rsp, 0xb0
0107ea84 mov        rax, qword ptr [rip + 0xf565b5]
0107ea8b xor        rax, rsp
0107ea8e mov        qword ptr [rbp + 0x27], rax
0107ea92 xor        r13d, r13d
0107ea95 mov        r12, rdx
0107ea98 mov        rbx, rcx
0107ea9b mov        r15d, r13d
0107ea9e cmp        dword ptr [rdx + 0xc], r13d
0107eaa2 jbe        0x14107ec9a
0107eaa8 nop        dword ptr [rax + rax]
0107eab0 mov        r8d, 8
0107eab6 lea        rdx, [rbp - 0x59]
0107eaba mov        rcx, rbx
0107eabd call       0x1410770a0
0107eac2 test       eax, eax
0107eac4 jne        0x14107ee5f
0107eaca mov        r10d, dword ptr [rbp - 0x55]
0107eace mov        edi, r10d
0107ead1 cmp        byte ptr [rbx + 0x52], r13b
0107ead5 jne        0x14107ead9
0107ead7 bswap      edi
0107ead9 mov        esi, 0x18
0107eade lea        rcx, [rbp - 0x51]
0107eae2 cmp        edi, esi
0107eae4 cmovb      esi, edi
0107eae7 cmp        esi, 8
0107eaea jbe        0x14107eb1f
0107eaec lea        r14d, [rsi - 8]
0107eaf0 cmp        r14, 0xa00000
0107eaf7 ja         0x14107ee04
0107eafd mov        r8d, r14d
0107eb00 lea        rdx, [rbp - 0x51]
0107eb04 mov        rcx, rbx
0107eb07 call       0x1410770a0
0107eb0c test       eax, eax
0107eb0e jne        0x14107ee5f
0107eb14 mov        r10d, dword ptr [rbp - 0x55]
0107eb18 lea        rcx, [rbp - 0x51]
0107eb1c add        rcx, r14
0107eb1f cmp        esi, 0x18
0107eb22 jae        0x14107eb3d
0107eb24 test       rcx, rcx
0107eb27 je         0x14107eb3d
0107eb29 mov        r8d, 0x18
0107eb2f xor        edx, edx
0107eb31 sub        r8d, esi
0107eb34 call       0x14179cca0
0107eb39 mov        r10d, dword ptr [rbp - 0x55]
0107eb3d cmp        edi, esi
0107eb3f jbe        0x14107eb55
0107eb41 sub        edi, esi
0107eb43 mov        rcx, rbx
0107eb46 mov        edx, edi
0107eb48 call       0x14106a520
0107eb4d test       eax, eax
0107eb4f jne        0x14107ee5f
0107eb55 cmp        byte ptr [rbx + 0x52], r13b
0107eb59 jne        0x14107ec44
0107eb5f mov        ecx, dword ptr [rbp - 0x59]
0107eb62 mov        r9d, ecx
0107eb65 mov        eax, ecx
0107eb67 and        r9d, 0xff0000
0107eb6e shr        eax, 0x10
0107eb71 or         r9d, eax
0107eb74 mov        eax, ecx
0107eb76 shl        eax, 0x10
0107eb79 and        ecx, 0xff00
0107eb7f or         eax, ecx
0107eb81 shr        r9d, 8
0107eb85 shl        eax, 8
0107eb88 mov        ecx, r10d
0107eb8b or         r9d, eax
0107eb8e and        ecx, 0xff0000
0107eb94 mov        eax, r10d
0107eb97 mov        dword ptr [rbp - 0x59], r9d
0107eb9b shr        eax, 0x10
0107eb9e or         ecx, eax
0107eba0 mov        eax, r10d
0107eba3 and        eax, 0xff00
0107eba8 shr        ecx, 8
0107ebab shl        r10d, 0x10
0107ebaf or         eax, r10d
0107ebb2 mov        r10d, ecx
0107ebb5 mov        ecx, dword ptr [rbp - 0x51]
0107ebb8 mov        r8d, ecx
0107ebbb shl        eax, 8
0107ebbe and        r8d, 0xff0000
0107ebc5 or         r10d, eax
0107ebc8 mov        eax, ecx
0107ebca shr        eax, 0x10
0107ebcd or         r8d, eax
0107ebd0 mov        dword ptr [rbp - 0x55], r10d
0107ebd4 mov        eax, ecx
0107ebd6 shr        r8d, 8
0107ebda and        eax, 0xff00
0107ebdf shl        ecx, 0x10
0107ebe2 or         eax, ecx
0107ebe4 mov        ecx, dword ptr [rbp - 0x4d]
0107ebe7 shl        eax, 8
0107ebea mov        edx, ecx
0107ebec or         r8d, eax
0107ebef and        edx, 0xff0000
0107ebf5 mov        eax, ecx
0107ebf7 mov        dword ptr [rbp - 0x51], r8d
0107ebfb shr        eax, 0x10
0107ebfe or         edx, eax
0107ec00 mov        eax, ecx
0107ec02 shl        eax, 0x10
0107ec05 and        ecx, 0xff00
0107ec0b or         eax, ecx
0107ec0d shr        edx, 8
0107ec10 mov        ecx, dword ptr [rbp - 0x49]
0107ec13 shl        eax, 8
0107ec16 or         edx, eax
0107ec18 mov        eax, ecx
0107ec1a shr        eax, 0x10
0107ec1d mov        dword ptr [rbp - 0x4d], edx
0107ec20 mov        edx, ecx
0107ec22 and        edx, 0xff0000
0107ec28 or         edx, eax
0107ec2a mov        eax, ecx
0107ec2c shl        eax, 0x10
0107ec2f and        ecx, 0xff00
0107ec35 or         eax, ecx
0107ec37 shr        edx, 8
0107ec3a shl        eax, 8
0107ec3d or         edx, eax
0107ec3f mov        dword ptr [rbp - 0x49], edx
0107ec42 jmp        0x14107ec4c
0107ec44 mov        r8d, dword ptr [rbp - 0x51]
0107ec48 mov        r9d, dword ptr [rbp - 0x59]
0107ec4c cmp        r9d, 0x686f686d
0107ec53 jne        0x14107ee04
0107ec59 mov        rcx, qword ptr [rbx + 0x1e00178]
0107ec60 sub        r8d, r10d
0107ec63 movsxd     rdx, r8d
0107ec66 add        rdx, qword ptr [rbx + 0x1e00170]
0107ec6d mov        qword ptr [rbx + 0x1e00170], rdx
0107ec74 cmp        rdx, rcx
0107ec77 jb         0x14107ec85
0107ec79 add        rcx, qword ptr [rbx + 0x1e00180]
0107ec80 cmp        rdx, rcx
0107ec83 jb         0x14107ec8c
0107ec85 mov        qword ptr [rbx + 0x1e00180], r13
0107ec8c inc        r15d
0107ec8f cmp        r15d, dword ptr [r12 + 0xc]
0107ec94 jb         0x14107eab0
0107ec9a mov        r15d, r13d
0107ec9d cmp        dword ptr [r12 + 0x10], r13d
0107eca2 jbe        0x14107ee5c
0107eca8 nop        dword ptr [rax + rax]
0107ecb0 mov        r8d, 8
0107ecb6 lea        rdx, [rbp - 0x39]
0107ecba mov        rcx, rbx
0107ecbd call       0x1410770a0
0107ecc2 test       eax, eax
0107ecc4 jne        0x14107ee5f
0107ecca mov        r10d, dword ptr [rbp - 0x35]
0107ecce mov        edi, r10d
0107ecd1 mov        ecx, r10d
0107ecd4 cmp        byte ptr [rbx + 0x52], r13b
0107ecd8 jne        0x14107ecfc
0107ecda and        edi, 0xff0000
0107ece0 mov        eax, ecx
0107ece2 shr        eax, 0x10
0107ece5 or         edi, eax
0107ece7 mov        eax, ecx
0107ece9 shl        eax, 0x10
0107ecec and        ecx, 0xff00
0107ecf2 or         eax, ecx
0107ecf4 shr        edi, 8
0107ecf7 shl        eax, 8
0107ecfa or         edi, eax
0107ecfc mov        esi, 0x54
0107ed01 lea        rcx, [rbp - 0x31]
0107ed05 cmp        edi, esi
0107ed07 cmovb      esi, edi
0107ed0a cmp        esi, 8
0107ed0d jbe        0x14107ed42
0107ed0f lea        r14d, [rsi - 8]
0107ed13 cmp        r14, 0xa00000
0107ed1a ja         0x14107ee04
0107ed20 mov        r8d, r14d
0107ed23 lea        rdx, [rbp - 0x31]
0107ed27 mov        rcx, rbx
0107ed2a call       0x1410770a0
0107ed2f test       eax, eax
0107ed31 jne        0x14107ee5f
0107ed37 mov        r10d, dword ptr [rbp - 0x35]
0107ed3b lea        rcx, [rbp - 0x31]
0107ed3f add        rcx, r14
0107ed42 cmp        esi, 0x54
0107ed45 jae        0x14107ed60
0107ed47 test       rcx, rcx
0107ed4a je         0x14107ed60
0107ed4c mov        r8d, 0x54
0107ed52 xor        edx, edx
0107ed54 sub        r8d, esi
0107ed57 call       0x14179cca0
0107ed5c mov        r10d, dword ptr [rbp - 0x35]
0107ed60 cmp        edi, esi
0107ed62 jbe        0x14107ed78
0107ed64 sub        edi, esi
0107ed66 mov        rcx, rbx
0107ed69 mov        edx, edi
0107ed6b call       0x14106a520
0107ed70 test       eax, eax
0107ed72 jne        0x14107ee5f
0107ed78 cmp        byte ptr [rbx + 0x52], r13b
0107ed7c jne        0x14107ee0b
0107ed82 mov        ecx, dword ptr [rbp - 0x39]
0107ed85 mov        r8d, ecx
0107ed88 mov        eax, ecx
0107ed8a and        r8d, 0xff0000
0107ed91 shr        eax, 0x10
0107ed94 or         r8d, eax
0107ed97 mov        eax, ecx
0107ed99 shl        eax, 0x10
0107ed9c and        ecx, 0xff00
0107eda2 or         eax, ecx
0107eda4 shr        r8d, 8
0107eda8 shl        eax, 8
0107edab mov        ecx, r10d
0107edae or         r8d, eax
0107edb1 and        ecx, 0xff0000
0107edb7 mov        eax, r10d
0107edba shr        eax, 0x10
0107edbd or         ecx, eax
0107edbf mov        eax, r10d
0107edc2 shl        eax, 0x10
0107edc5 and        r10d, 0xff00
0107edcc or         eax, r10d
0107edcf shr        ecx, 8
0107edd2 shl        eax, 8
0107edd5 mov        r10d, ecx
0107edd8 mov        ecx, dword ptr [rbp - 0x31]
0107eddb or         r10d, eax
0107edde mov        eax, ecx
0107ede0 mov        edx, ecx
0107ede2 shr        eax, 0x10
0107ede5 and        edx, 0xff0000
0107edeb or         edx, eax
0107eded mov        eax, ecx
0107edef shl        eax, 0x10
0107edf2 and        ecx, 0xff00
0107edf8 or         eax, ecx
0107edfa shr        edx, 8
0107edfd shl        eax, 8
0107ee00 or         edx, eax
0107ee02 jmp        0x14107ee12
0107ee04 mov        eax, 0xffffff30
0107ee09 jmp        0x14107ee5f
0107ee0b mov        edx, dword ptr [rbp - 0x31]
0107ee0e mov        r8d, dword ptr [rbp - 0x39]
0107ee12 cmp        r8d, 0x6870746d
0107ee19 jne        0x14107ee04
0107ee1b mov        rcx, qword ptr [rbx + 0x1e00178]
0107ee22 sub        edx, r10d
0107ee25 movsxd     rdx, edx
0107ee28 add        rdx, qword ptr [rbx + 0x1e00170]
0107ee2f mov        qword ptr [rbx + 0x1e00170], rdx
0107ee36 cmp        rdx, rcx
0107ee39 jb         0x14107ee47
0107ee3b add        rcx, qword ptr [rbx + 0x1e00180]
0107ee42 cmp        rdx, rcx
0107ee45 jb         0x14107ee4e
0107ee47 mov        qword ptr [rbx + 0x1e00180], r13
0107ee4e inc        r15d
0107ee51 cmp        r15d, dword ptr [r12 + 0x10]
0107ee56 jb         0x14107ecb0
0107ee5c mov        eax, r13d
0107ee5f mov        rcx, qword ptr [rbp + 0x27]
0107ee63 xor        rcx, rsp
0107ee66 call       0x14179b8e0
0107ee6b lea        r11, [rsp + 0xb0]
0107ee73 mov        rbx, qword ptr [r11 + 0x38]
0107ee77 mov        rsi, qword ptr [r11 + 0x40]
0107ee7b mov        rdi, qword ptr [r11 + 0x48]
0107ee7f mov        rsp, r11
0107ee82 pop        r15
0107ee84 pop        r14
0107ee86 pop        r13
0107ee88 pop        r12
0107ee8a pop        rbp
0107ee8b ret        
