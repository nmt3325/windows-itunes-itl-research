; iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0xec75b0
; unwind group range 0xec75b0..0xec75e3 (exclusive)
00ec75b0 4885c9                           test       rcx, rcx
00ec75b3 0f842c040000                     je         0x140ec79e5
00ec75b9 4c8bdc                           mov        r11, rsp
00ec75bc 55                               push       rbp
00ec75bd 57                               push       rdi
00ec75be 4154                             push       r12
00ec75c0 4155                             push       r13
00ec75c2 4157                             push       r15
00ec75c4 498dab48fcffff                   lea        rbp, [r11 - 0x3b8]
00ec75cb 4881ec90040000                   sub        rsp, 0x490
00ec75d2 488b0567da1001                   mov        rax, qword ptr [rip + 0x110da67]
00ec75d9 4833c4                           xor        rax, rsp
00ec75dc 48898560030000                   mov        qword ptr [rbp + 0x360], rax
; unwind group range 0xec75e3..0xec760b (exclusive)
00ec75e3 498973d0                         mov        qword ptr [r11 - 0x30], rsi
00ec75e7 4d8be1                           mov        r12, r9
00ec75ea 488b7108                         mov        rsi, qword ptr [rcx + 8]
00ec75ee 458be8                           mov        r13d, r8d
00ec75f1 4c8bfa                           mov        r15, rdx
00ec75f4 488bf9                           mov        rdi, rcx
00ec75f7 4885f6                           test       rsi, rsi
00ec75fa 0f84bf030000                     je         0x140ec79bf
00ec7600 48837e1000                       cmp        qword ptr [rsi + 0x10], 0
00ec7605 0f84b4030000                     je         0x140ec79bf
; unwind group range 0xec760b..0xec7614 (exclusive)
00ec760b 49895b18                         mov        qword ptr [r11 + 0x18], rbx
00ec760f 0f57c0                           xorps      xmm0, xmm0
00ec7612 33db                             xor        ebx, ebx
; unwind group range 0xec7614..0xec7811 (exclusive)
00ec7614 4d8973c8                         mov        qword ptr [r11 - 0x38], r14
00ec7618 0f11442438                       movups     xmmword ptr [rsp + 0x38], xmm0
00ec761d 0f11442448                       movups     xmmword ptr [rsp + 0x48], xmm0
00ec7622 f6869a00000010                   test       byte ptr [rsi + 0x9a], 0x10
00ec7629 0f84a1010000                     je         0x140ec77d0
00ec762f 483b4e58                         cmp        rcx, qword ptr [rsi + 0x58]
00ec7633 0f8597010000                     jne        0x140ec77d0
00ec7639 488b4e10                         mov        rcx, qword ptr [rsi + 0x10]
00ec763d 66899d60010000                   mov        word ptr [rbp + 0x160], bx
00ec7644 4885c9                           test       rcx, rcx
00ec7647 0f8483010000                     je         0x140ec77d0
00ec764d 8b96b0000000                     mov        edx, dword ptr [rsi + 0xb0]
00ec7653 4c8d8560010000                   lea        r8, [rbp + 0x160]
00ec765a 4881c178010000                   add        rcx, 0x178
00ec7661 e80a7ed3ff                       call       0x140bff470
00ec7666 440fb78d60010000                 movzx      r9d, word ptr [rbp + 0x160]
00ec766e 664585c9                         test       r9w, r9w
00ec7672 0f8458010000                     je         0x140ec77d0
00ec7678 389f98020000                     cmp        byte ptr [rdi + 0x298], bl
00ec767e 0f844c010000                     je         0x140ec77d0
00ec7684 488d4f78                         lea        rcx, [rdi + 0x78]
00ec7688 66895c2460                       mov        word ptr [rsp + 0x60], bx
00ec768d 0fb7d3                           movzx      edx, bx
00ec7690 4885c9                           test       rcx, rcx
00ec7693 7431                             je         0x140ec76c6
00ec7695 4c8b4110                         mov        r8, qword ptr [rcx + 0x10]
00ec7699 4d85c0                           test       r8, r8
00ec769c 7428                             je         0x140ec76c6
00ec769e 8b01                             mov        eax, dword ptr [rcx]
00ec76a0 3d50434641                       cmp        eax, 0x41464350
00ec76a5 7407                             je         0x140ec76ae
00ec76a7 3d506e6957                       cmp        eax, 0x57696e50
00ec76ac 7518                             jne        0x140ec76c6
00ec76ae 498b4010                         mov        rax, qword ptr [r8 + 0x10]
00ec76b2 488d542460                       lea        rdx, [rsp + 0x60]
00ec76b7 ffd0                             call       rax
00ec76b9 440fb78d60010000                 movzx      r9d, word ptr [rbp + 0x160]
00ec76c1 0fb7542460                       movzx      edx, word ptr [rsp + 0x60]
00ec76c6 450fb7c9                         movzx      r9d, r9w
00ec76ca 4c8d8562010000                   lea        r8, [rbp + 0x162]
00ec76d1 0fb7d2                           movzx      edx, dx
00ec76d4 488d4c2462                       lea        rcx, [rsp + 0x62]
00ec76d9 895c2420                         mov        dword ptr [rsp + 0x20], ebx
00ec76dd e85ed8c1ff                       call       0x140ae4f40
00ec76e2 84c0                             test       al, al
00ec76e4 0f85e6000000                     jne        0x140ec77d0
00ec76ea 33d2                             xor        edx, edx
00ec76ec 488d4c2460                       lea        rcx, [rsp + 0x60]
00ec76f1 e8aad1c1ff                       call       0x140ae48a0
00ec76f6 440fb78d60010000                 movzx      r9d, word ptr [rbp + 0x160]
00ec76fe 4c8d8562010000                   lea        r8, [rbp + 0x162]
00ec7705 0fb7542460                       movzx      edx, word ptr [rsp + 0x60]
00ec770a 488d4c2462                       lea        rcx, [rsp + 0x62]
00ec770f 895c2420                         mov        dword ptr [rsp + 0x20], ebx
00ec7713 e828d8c1ff                       call       0x140ae4f40
00ec7718 84c0                             test       al, al
00ec771a 0f85b0000000                     jne        0x140ec77d0
00ec7720 4c8b5610                         mov        r10, qword ptr [rsi + 0x10]
00ec7724 4d85d2                           test       r10, r10
00ec7727 0f849e000000                     je         0x140ec77cb
00ec772d 0fb7442460                       movzx      eax, word ptr [rsp + 0x60]
00ec7732 4981c278010000                   add        r10, 0x178
00ec7739 b9ff000000                       mov        ecx, 0xff
00ec773e 663bc1                           cmp        ax, cx
00ec7741 7608                             jbe        0x140ec774b
00ec7743 899eb0000000                     mov        dword ptr [rsi + 0xb0], ebx
00ec7749 eb76                             jmp        0x140ec77c1
00ec774b 448bc0                           mov        r8d, eax
00ec774e 4503c0                           add        r8d, r8d
00ec7751 4d85d2                           test       r10, r10
00ec7754 746b                             je         0x140ec77c1
00ec7756 41813a63727473                   cmp        dword ptr [r10], 0x73747263
00ec775d 7562                             jne        0x140ec77c1
00ec775f 41395a28                         cmp        dword ptr [r10 + 0x28], ebx
00ec7763 755c                             jne        0x140ec77c1
00ec7765 486386b0000000                   movsxd     rax, dword ptr [rsi + 0xb0]
00ec776c 41395a3c                         cmp        dword ptr [r10 + 0x3c], ebx
00ec7770 754f                             jne        0x140ec77c1
00ec7772 85c0                             test       eax, eax
00ec7774 7437                             je         0x140ec77ad
00ec7776 7e49                             jle        0x140ec77c1
00ec7778 413b422c                         cmp        eax, dword ptr [r10 + 0x2c]
00ec777c 7f43                             jg         0x140ec77c1
00ec777e 41f6420401                       test       byte ptr [r10 + 4], 1
00ec7783 488bd0                           mov        rdx, rax
00ec7786 740e                             je         0x140ec7796
00ec7788 498b4218                         mov        rax, qword ptr [r10 + 0x18]
00ec778c 488b00                           mov        rax, qword ptr [rax]
00ec778f 836c90fc01                       sub        dword ptr [rax + rdx*4 - 4], 1
00ec7794 7517                             jne        0x140ec77ad
00ec7796 498b4210                         mov        rax, qword ptr [r10 + 0x10]
00ec779a 488b08                           mov        rcx, qword ptr [rax]
00ec779d 8b44d1fc                         mov        eax, dword ptr [rcx + rdx*8 - 4]
00ec77a1 41014240                         add        dword ptr [r10 + 0x40], eax
00ec77a5 c744d1f801000080                 mov        dword ptr [rcx + rdx*8 - 8], 0x80000001
00ec77ad 4c8d8eb0000000                   lea        r9, [rsi + 0xb0]
00ec77b4 498bca                           mov        rcx, r10
00ec77b7 488d542462                       lea        rdx, [rsp + 0x62]
00ec77bc e82f6ad3ff                       call       0x140bfe1f0
00ec77c1 33d2                             xor        edx, edx
00ec77c3 488bce                           mov        rcx, rsi
00ec77c6 e8b5030000                       call       0x140ec7b80
00ec77cb 804c243820                       or         byte ptr [rsp + 0x38], 0x20
00ec77d0 807f3c01                         cmp        byte ptr [rdi + 0x3c], 1
00ec77d4 0f8503010000                     jne        0x140ec78dd
00ec77da 488b4610                         mov        rax, qword ptr [rsi + 0x10]
00ec77de 48895c2430                       mov        qword ptr [rsp + 0x30], rbx
00ec77e3 81b88400000069506f64             cmp        dword ptr [rax + 0x84], 0x646f5069
00ec77ed 751e                             jne        0x140ec780d
00ec77ef f680fa20000020                   test       byte ptr [rax + 0x20fa], 0x20
00ec77f6 7415                             je         0x140ec780d
00ec77f8 f30f6f442438                     movdqu     xmm0, xmmword ptr [rsp + 0x38]
00ec77fe 660f73d801                       psrldq     xmm0, 1
00ec7803 660f7ec0                         movd       eax, xmm0
00ec7807 88442439                         mov        byte ptr [rsp + 0x39], al
00ec780b eb60                             jmp        0x140ec786d
00ec780d 418b4708                         mov        eax, dword ptr [r15 + 8]
; unwind group range 0xec7811..0xec7865 (exclusive)
00ec7811 0f29b42470040000                 movaps     xmmword ptr [rsp + 0x470], xmm6
00ec7819 0f57f6                           xorps      xmm6, xmm6
00ec781c f2480f2af0                       cvtsi2sd   xmm6, rax
00ec7821 ff158917a200                     call       qword ptr [rip + 0xa21789]
00ec7827 4c8bf0                           mov        r14, rax
00ec782a 4885c0                           test       rax, rax
00ec782d 7424                             je         0x140ec7853
00ec782f 488b0d1a16a200                   mov        rcx, qword ptr [rip + 0xa2161a]
00ec7836 0f28ce                           movaps     xmm1, xmm6
00ec7839 f20f5c09                         subsd      xmm1, qword ptr [rcx]
00ec783d 488bc8                           mov        rcx, rax
00ec7840 ff15b217a200                     call       qword ptr [rip + 0xa217b2]
00ec7846 498bce                           mov        rcx, r14
00ec7849 f20f58f0                         addsd      xmm6, xmm0
00ec784d ff15cd15a200                     call       qword ptr [rip + 0xa215cd]
00ec7853 f2480f2cc6                       cvttsd2si  rax, xmm6
00ec7858 0f28b42470040000                 movaps     xmm6, xmmword ptr [rsp + 0x470]
00ec7860 394754                           cmp        dword ptr [rdi + 0x54], eax
00ec7863 7408                             je         0x140ec786d
; unwind group range 0xec7865..0xec7903 (exclusive)
00ec7865 804c243920                       or         byte ptr [rsp + 0x39], 0x20
00ec786a 894754                           mov        dword ptr [rdi + 0x54], eax
00ec786d 41381f                           cmp        byte ptr [r15], bl
00ec7870 7454                             je         0x140ec78c6
00ec7872 488b4760                         mov        rax, qword ptr [rdi + 0x60]
00ec7876 4885c0                           test       rax, rax
00ec7879 7553                             jne        0x140ec78ce
00ec787b 385f41                           cmp        byte ptr [rdi + 0x41], bl
00ec787e 7c4e                             jl         0x140ec78ce
00ec7880 e88b89d0ff                       call       0x140bd0210
00ec7885 84c0                             test       al, al
00ec7887 7423                             je         0x140ec78ac
00ec7889 33d2                             xor        edx, edx
00ec788b 488bce                           mov        rcx, rsi
00ec788e e8dd920d00                       call       0x140fa0b70
00ec7893 0fbae016                         bt         eax, 0x16
00ec7897 7313                             jae        0x140ec78ac
00ec7899 488bcf                           mov        rcx, rdi
00ec789c e8effaffff                       call       0x140ec7390
00ec78a1 85c0                             test       eax, eax
00ec78a3 7507                             jne        0x140ec78ac
00ec78a5 488b442430                       mov        rax, qword ptr [rsp + 0x30]
00ec78aa eb22                             jmp        0x140ec78ce
00ec78ac 488d4f78                         lea        rcx, [rdi + 0x78]
00ec78b0 4533c0                           xor        r8d, r8d
00ec78b3 4c8d4c2430                       lea        r9, [rsp + 0x30]
00ec78b8 33d2                             xor        edx, edx
00ec78ba e8c170c5ff                       call       0x140b1e980
00ec78bf 488b442430                       mov        rax, qword ptr [rsp + 0x30]
00ec78c4 eb08                             jmp        0x140ec78ce
00ec78c6 498b4720                         mov        rax, qword ptr [r15 + 0x20]
00ec78ca 49034718                         add        rax, qword ptr [r15 + 0x18]
00ec78ce 48394760                         cmp        qword ptr [rdi + 0x60], rax
00ec78d2 7409                             je         0x140ec78dd
00ec78d4 804c243908                       or         byte ptr [rsp + 0x39], 8
00ec78d9 48894760                         mov        qword ptr [rdi + 0x60], rax
00ec78dd 41381f                           cmp        byte ptr [r15], bl
00ec78e0 b948000000                       mov        ecx, 0x48
00ec78e5 4c8bb42480040000                 mov        r14, qword ptr [rsp + 0x480]
00ec78ed b818000000                       mov        eax, 0x18
00ec78f2 0f44c1                           cmove      eax, ecx
00ec78f5 428b0c38                         mov        ecx, dword ptr [rax + r15]
00ec78f9 8b87a0020000                     mov        eax, dword ptr [rdi + 0x2a0]
00ec78ff 3bc1                             cmp        eax, ecx
00ec7901 740d                             je         0x140ec7910
; unwind group range 0xec7903..0xec79aa (exclusive)
00ec7903 85c0                             test       eax, eax
00ec7905 7403                             je         0x140ec790a
00ec7907 885f3c                           mov        byte ptr [rdi + 0x3c], bl
00ec790a 898fa0020000                     mov        dword ptr [rdi + 0x2a0], ecx
00ec7910 807c1c3800                       cmp        byte ptr [rsp + rbx + 0x38], 0
00ec7915 750b                             jne        0x140ec7922
00ec7917 48ffc3                           inc        rbx
00ec791a 4883fb20                         cmp        rbx, 0x20
00ec791e 7cf0                             jl         0x140ec7910
00ec7920 eb7b                             jmp        0x140ec799d
00ec7922 41f6c502                         test       r13b, 2
00ec7926 7552                             jne        0x140ec797a
00ec7928 4c8d0529fac800                   lea        r8, [rip + 0xc8fa29]
00ec792f b80a000000                       mov        eax, 0xa
00ec7934 3d00010000                       cmp        eax, 0x100
00ec7939 7d16                             jge        0x140ec7951
00ec793b 8bc8                             mov        ecx, eax
00ec793d ba80000000                       mov        edx, 0x80
00ec7942 83e107                           and        ecx, 7
00ec7945 48c1e803                         shr        rax, 3
00ec7949 d3fa                             sar        edx, cl
00ec794b 84540438                         test       byte ptr [rsp + rax + 0x38], dl
00ec794f 750e                             jne        0x140ec795f
00ec7951 418b4004                         mov        eax, dword ptr [r8 + 4]
00ec7955 4983c004                         add        r8, 4
00ec7959 85c0                             test       eax, eax
00ec795b 75d7                             jne        0x140ec7934
00ec795d eb1b                             jmp        0x140ec797a
00ec795f 80bf9802000000                   cmp        byte ptr [rdi + 0x298], 0
00ec7966 7412                             je         0x140ec797a
00ec7968 488d5778                         lea        rdx, [rdi + 0x78]
00ec796c 41b803080000                     mov        r8d, 0x803
00ec7972 488bcf                           mov        rcx, rdi
00ec7975 e89621ffff                       call       0x140eb9b10
00ec797a 41f6c501                         test       r13b, 1
00ec797e 751d                             jne        0x140ec799d
00ec7980 488b4f08                         mov        rcx, qword ptr [rdi + 8]
00ec7984 4885c9                           test       rcx, rcx
00ec7987 7414                             je         0x140ec799d
00ec7989 4883791000                       cmp        qword ptr [rcx + 0x10], 0
00ec798e 740d                             je         0x140ec799d
00ec7990 4c8d442438                       lea        r8, [rsp + 0x38]
00ec7995 488bd7                           mov        rdx, rdi
00ec7998 e8e3c70c00                       call       0x140f94180
00ec799d 488b9c24d0040000                 mov        rbx, qword ptr [rsp + 0x4d0]
00ec79a5 4d85e4                           test       r12, r12
00ec79a8 7415                             je         0x140ec79bf
; unwind group range 0xec79aa..0xec79e5 (exclusive)
00ec79aa 0f10442438                       movups     xmm0, xmmword ptr [rsp + 0x38]
00ec79af 0f104c2448                       movups     xmm1, xmmword ptr [rsp + 0x48]
00ec79b4 410f110424                       movups     xmmword ptr [r12], xmm0
00ec79b9 410f114c2410                     movups     xmmword ptr [r12 + 0x10], xmm1
00ec79bf 488bb42488040000                 mov        rsi, qword ptr [rsp + 0x488]
00ec79c7 488b8d60030000                   mov        rcx, qword ptr [rbp + 0x360]
00ec79ce 4833cc                           xor        rcx, rsp
00ec79d1 e80a3f8d00                       call       0x14179b8e0
00ec79d6 4881c490040000                   add        rsp, 0x490
00ec79dd 415f                             pop        r15
00ec79df 415d                             pop        r13
00ec79e1 415c                             pop        r12
00ec79e3 5f                               pop        rdi
00ec79e4 5d                               pop        rbp
; unwind group range 0xec79e5..0xec79e6 (exclusive)
00ec79e5 c3                               ret        
