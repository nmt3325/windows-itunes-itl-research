; Original iTunes.exe machine code; base=0x140000000; RVA=0x1081a70; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1081a70..0x108210d (exclusive)
01081a70 mov        qword ptr [rsp + 0x10], rbx
01081a75 mov        qword ptr [rsp + 0x18], rsi
01081a7a mov        qword ptr [rsp + 0x20], rdi
01081a7f push       rbp
01081a80 push       r12
01081a82 push       r13
01081a84 push       r14
01081a86 push       r15
01081a88 lea        rbp, [rsp - 0x37]
01081a8d sub        rsp, 0xd0
01081a94 mov        rax, qword ptr [rip + 0xf535a5]
01081a9b xor        rax, rsp
01081a9e mov        qword ptr [rbp + 0x2f], rax
01081aa2 mov        r14, rcx
01081aa5 mov        r8d, 8
01081aab lea        rdx, [rbp - 1]
01081aaf call       0x1410770a0
01081ab4 mov        edi, eax
01081ab6 test       eax, eax
01081ab8 jne        0x1410820de
01081abe mov        r10d, dword ptr [rbp + 3]
01081ac2 mov        ebx, r10d
01081ac5 lea        r12, [r14 + 0x52]
01081ac9 cmp        byte ptr [r12], al
01081acd jne        0x141081ad1
01081acf bswap      ebx
01081ad1 lea        rcx, [rbp + 7]
01081ad5 mov        r15d, 0x2c
01081adb mov        esi, r15d
01081ade cmp        ebx, r15d
01081ae1 cmovb      esi, ebx
01081ae4 cmp        esi, 8
01081ae7 jbe        0x141081b1e
01081ae9 lea        r13d, [rsi - 8]
01081aed cmp        r13, 0xa00000
01081af4 ja         0x1410820d9
01081afa mov        r8d, r13d
01081afd lea        rdx, [rbp + 7]
01081b01 mov        rcx, r14
01081b04 call       0x1410770a0
01081b09 mov        edi, eax
01081b0b test       eax, eax
01081b0d jne        0x1410820de
01081b13 lea        rcx, [rbp + 7]
01081b17 add        rcx, r13
01081b1a mov        r10d, dword ptr [rbp + 3]
01081b1e cmp        esi, r15d
01081b21 jae        0x141081b39
01081b23 test       rcx, rcx
01081b26 je         0x141081b39
01081b28 sub        r15d, esi
01081b2b mov        r8d, r15d
01081b2e xor        edx, edx
01081b30 call       0x14179cca0
01081b35 mov        r10d, dword ptr [rbp + 3]
01081b39 cmp        ebx, esi
01081b3b jbe        0x141081b53
01081b3d sub        ebx, esi
01081b3f mov        edx, ebx
01081b41 mov        rcx, r14
01081b44 call       0x14106a520
01081b49 mov        edi, eax
01081b4b test       eax, eax
01081b4d jne        0x1410820de
01081b53 xor        edi, edi
01081b55 cmp        byte ptr [r12], dil
01081b59 jne        0x141081be5
01081b5f mov        ecx, dword ptr [rbp - 1]
01081b62 mov        edx, ecx
01081b64 and        edx, 0xff0000
01081b6a mov        eax, ecx
01081b6c shr        eax, 0x10
01081b6f or         edx, eax
01081b71 shr        edx, 8
01081b74 mov        eax, ecx
01081b76 and        eax, 0xff00
01081b7b shl        ecx, 0x10
01081b7e or         eax, ecx
01081b80 shl        eax, 8
01081b83 or         edx, eax
01081b85 mov        dword ptr [rbp - 1], edx
01081b88 mov        ecx, r10d
01081b8b and        ecx, 0xff0000
01081b91 mov        eax, r10d
01081b94 shr        eax, 0x10
01081b97 or         ecx, eax
01081b99 shr        ecx, 8
01081b9c mov        eax, r10d
01081b9f shl        eax, 0x10
01081ba2 and        r10d, 0xff00
01081ba9 or         eax, r10d
01081bac shl        eax, 8
01081baf or         ecx, eax
01081bb1 mov        dword ptr [rbp + 3], ecx
01081bb4 mov        ecx, dword ptr [rbp + 7]
01081bb7 mov        r8d, ecx
01081bba and        r8d, 0xff0000
01081bc1 mov        eax, ecx
01081bc3 shr        eax, 0x10
01081bc6 or         r8d, eax
01081bc9 shr        r8d, 8
01081bcd mov        eax, ecx
01081bcf and        eax, 0xff00
01081bd4 shl        ecx, 0x10
01081bd7 or         eax, ecx
01081bd9 shl        eax, 8
01081bdc or         r8d, eax
01081bdf mov        dword ptr [rbp + 7], r8d
01081be3 jmp        0x141081bec
01081be5 mov        r8d, dword ptr [rbp + 7]
01081be9 mov        edx, dword ptr [rbp - 1]
01081bec cmp        edx, 0x68736c6d
01081bf2 jne        0x1410820d9
01081bf8 mov        dword ptr [rbp - 0x75], edi
01081bfb test       r8d, r8d
01081bfe je         0x1410820de
01081c04 nop        dword ptr [rax]
01081c08 nop        dword ptr [rax + rax]
01081c10 mov        r8d, 8
01081c16 lea        rdx, [rbp - 0x31]
01081c1a mov        rcx, r14
01081c1d call       0x1410770a0
01081c22 mov        edi, eax
01081c24 test       eax, eax
01081c26 jne        0x1410820de
01081c2c mov        r10d, dword ptr [rbp - 0x2d]
01081c30 mov        ebx, r10d
01081c33 mov        ecx, r10d
01081c36 cmp        byte ptr [r12], al
01081c3a jne        0x141081c5e
01081c3c and        ebx, 0xff0000
01081c42 mov        eax, ecx
01081c44 shr        eax, 0x10
01081c47 or         ebx, eax
01081c49 shr        ebx, 8
01081c4c mov        eax, ecx
01081c4e shl        eax, 0x10
01081c51 and        ecx, 0xff00
01081c57 or         eax, ecx
01081c59 shl        eax, 8
01081c5c or         ebx, eax
01081c5e lea        rcx, [rbp - 0x29]
01081c62 mov        esi, 0x30
01081c67 cmp        ebx, esi
01081c69 cmovb      esi, ebx
01081c6c cmp        esi, 8
01081c6f jbe        0x141081ca6
01081c71 lea        r15d, [rsi - 8]
01081c75 cmp        r15, 0xa00000
01081c7c ja         0x1410820d9
01081c82 mov        r8d, r15d
01081c85 lea        rdx, [rbp - 0x29]
01081c89 mov        rcx, r14
01081c8c call       0x1410770a0
01081c91 mov        edi, eax
01081c93 test       eax, eax
01081c95 jne        0x1410820de
01081c9b lea        rcx, [rbp - 0x29]
01081c9f add        rcx, r15
01081ca2 mov        r10d, dword ptr [rbp - 0x2d]
01081ca6 cmp        esi, 0x30
01081ca9 jae        0x141081cc4
01081cab test       rcx, rcx
01081cae je         0x141081cc4
01081cb0 mov        r8d, 0x30
01081cb6 sub        r8d, esi
01081cb9 xor        edx, edx
01081cbb call       0x14179cca0
01081cc0 mov        r10d, dword ptr [rbp - 0x2d]
01081cc4 cmp        ebx, esi
01081cc6 jbe        0x141081cde
01081cc8 sub        ebx, esi
01081cca mov        edx, ebx
01081ccc mov        rcx, r14
01081ccf call       0x14106a520
01081cd4 mov        edi, eax
01081cd6 test       eax, eax
01081cd8 jne        0x1410820de
01081cde xor        edi, edi
01081ce0 cmp        byte ptr [r12], dil
01081ce4 jne        0x141081d9b
01081cea mov        ecx, dword ptr [rbp - 0x31]
01081ced mov        r8d, ecx
01081cf0 and        r8d, 0xff0000
01081cf7 mov        eax, ecx
01081cf9 shr        eax, 0x10
01081cfc or         r8d, eax
01081cff shr        r8d, 8
01081d03 mov        eax, ecx
01081d05 and        eax, 0xff00
01081d0a shl        ecx, 0x10
01081d0d or         eax, ecx
01081d0f shl        eax, 8
01081d12 or         r8d, eax
01081d15 mov        dword ptr [rbp - 0x31], r8d
01081d19 mov        ecx, r10d
01081d1c and        ecx, 0xff0000
01081d22 mov        eax, r10d
01081d25 shr        eax, 0x10
01081d28 or         ecx, eax
01081d2a shr        ecx, 8
01081d2d mov        eax, r10d
01081d30 shl        eax, 0x10
01081d33 and        r10d, 0xff00
01081d3a or         eax, r10d
01081d3d shl        eax, 8
01081d40 or         ecx, eax
01081d42 mov        dword ptr [rbp - 0x2d], ecx
01081d45 mov        ecx, dword ptr [rbp - 0x29]
01081d48 mov        edx, ecx
01081d4a and        edx, 0xff0000
01081d50 mov        eax, ecx
01081d52 shr        eax, 0x10
01081d55 or         edx, eax
01081d57 shr        edx, 8
01081d5a mov        eax, ecx
01081d5c shl        eax, 0x10
01081d5f and        ecx, 0xff00
01081d65 or         eax, ecx
01081d67 shl        eax, 8
01081d6a or         edx, eax
01081d6c mov        dword ptr [rbp - 0x29], edx
01081d6f mov        ecx, dword ptr [rbp - 0x25]
01081d72 mov        edx, ecx
01081d74 and        edx, 0xff0000
01081d7a mov        eax, ecx
01081d7c shr        eax, 0x10
01081d7f or         edx, eax
01081d81 shr        edx, 8
01081d84 mov        eax, ecx
01081d86 shl        eax, 0x10
01081d89 and        ecx, 0xff00
01081d8f or         eax, ecx
01081d91 shl        eax, 8
01081d94 or         edx, eax
01081d96 mov        dword ptr [rbp - 0x25], edx
01081d99 jmp        0x141081da2
01081d9b mov        edx, dword ptr [rbp - 0x25]
01081d9e mov        r8d, dword ptr [rbp - 0x31]
01081da2 cmp        r8d, 0x6870736d
01081da9 jne        0x1410820d9
01081daf mov        dword ptr [rbp - 0x79], edi
01081db2 test       edx, edx
01081db4 je         0x1410820c4
01081dba nop        word ptr [rax + rax]
01081dc0 mov        r8d, 8
01081dc6 lea        rdx, [rbp - 0x49]
01081dca mov        rcx, r14
01081dcd call       0x1410770a0
01081dd2 mov        edi, eax
01081dd4 test       eax, eax
01081dd6 jne        0x1410820de
01081ddc mov        r10d, dword ptr [rbp - 0x45]
01081de0 mov        ebx, r10d
01081de3 mov        ecx, r10d
01081de6 cmp        byte ptr [r12], al
01081dea jne        0x141081e0e
01081dec and        ebx, 0xff0000
01081df2 mov        eax, ecx
01081df4 shr        eax, 0x10
01081df7 or         ebx, eax
01081df9 shr        ebx, 8
01081dfc mov        eax, ecx
01081dfe shl        eax, 0x10
01081e01 and        ecx, 0xff00
01081e07 or         eax, ecx
01081e09 shl        eax, 8
01081e0c or         ebx, eax
01081e0e lea        rcx, [rbp - 0x41]
01081e12 mov        esi, 0x18
01081e17 cmp        ebx, esi
01081e19 cmovb      esi, ebx
01081e1c cmp        esi, 8
01081e1f jbe        0x141081e56
01081e21 lea        r15d, [rsi - 8]
01081e25 cmp        r15, 0xa00000
01081e2c ja         0x1410820d9
01081e32 mov        r8d, r15d
01081e35 lea        rdx, [rbp - 0x41]
01081e39 mov        rcx, r14
01081e3c call       0x1410770a0
01081e41 mov        edi, eax
01081e43 test       eax, eax
01081e45 jne        0x1410820de
01081e4b lea        rcx, [rbp - 0x41]
01081e4f add        rcx, r15
01081e52 mov        r10d, dword ptr [rbp - 0x45]
01081e56 cmp        esi, 0x18
01081e59 jae        0x141081e74
01081e5b test       rcx, rcx
01081e5e je         0x141081e74
01081e60 mov        r8d, 0x18
01081e66 sub        r8d, esi
01081e69 xor        edx, edx
01081e6b call       0x14179cca0
01081e70 mov        r10d, dword ptr [rbp - 0x45]
01081e74 cmp        ebx, esi
01081e76 jbe        0x141081e8e
01081e78 sub        ebx, esi
01081e7a mov        edx, ebx
01081e7c mov        rcx, r14
01081e7f call       0x14106a520
01081e84 mov        edi, eax
01081e86 test       eax, eax
01081e88 jne        0x1410820de
01081e8e cmp        byte ptr [r12], 0
01081e93 jne        0x141081f86
01081e99 mov        ecx, dword ptr [rbp - 0x49]
01081e9c mov        r8d, ecx
01081e9f and        r8d, 0xff0000
01081ea6 mov        eax, ecx
01081ea8 shr        eax, 0x10
01081eab or         r8d, eax
01081eae shr        r8d, 8
01081eb2 mov        eax, ecx
01081eb4 shl        eax, 0x10
01081eb7 and        ecx, 0xff00
01081ebd or         eax, ecx
01081ebf shl        eax, 8
01081ec2 or         r8d, eax
01081ec5 mov        dword ptr [rbp - 0x49], r8d
01081ec9 mov        ecx, r10d
01081ecc and        ecx, 0xff0000
01081ed2 mov        eax, r10d
01081ed5 shr        eax, 0x10
01081ed8 or         ecx, eax
01081eda shr        ecx, 8
01081edd mov        eax, r10d
01081ee0 shl        eax, 0x10
01081ee3 and        r10d, 0xff00
01081eea or         eax, r10d
01081eed shl        eax, 8
01081ef0 mov        r10d, ecx
01081ef3 or         r10d, eax
01081ef6 mov        dword ptr [rbp - 0x45], r10d
01081efa mov        ecx, dword ptr [rbp - 0x41]
01081efd mov        r9d, ecx
01081f00 and        r9d, 0xff0000
01081f07 mov        eax, ecx
01081f09 shr        eax, 0x10
01081f0c or         r9d, eax
01081f0f shr        r9d, 8
01081f13 mov        eax, ecx
01081f15 shl        eax, 0x10
01081f18 and        ecx, 0xff00
01081f1e or         eax, ecx
01081f20 shl        eax, 8
01081f23 or         r9d, eax
01081f26 mov        dword ptr [rbp - 0x41], r9d
01081f2a mov        ecx, dword ptr [rbp - 0x3d]
01081f2d mov        r11d, ecx
01081f30 and        r11d, 0xff0000
01081f37 mov        eax, ecx
01081f39 shr        eax, 0x10
01081f3c or         r11d, eax
01081f3f shr        r11d, 8
01081f43 mov        eax, ecx
01081f45 shl        eax, 0x10
01081f48 and        ecx, 0xff00
01081f4e or         eax, ecx
01081f50 shl        eax, 8
01081f53 or         r11d, eax
01081f56 mov        dword ptr [rbp - 0x3d], r11d
01081f5a mov        ecx, dword ptr [rbp - 0x39]
01081f5d mov        edx, ecx
01081f5f and        edx, 0xff0000
01081f65 mov        eax, ecx
01081f67 shr        eax, 0x10
01081f6a or         edx, eax
01081f6c shr        edx, 8
01081f6f mov        eax, ecx
01081f71 shl        eax, 0x10
01081f74 and        ecx, 0xff00
01081f7a or         eax, ecx
01081f7c shl        eax, 8
01081f7f or         edx, eax
01081f81 mov        dword ptr [rbp - 0x39], edx
01081f84 jmp        0x141081f92
01081f86 mov        r11d, dword ptr [rbp - 0x3d]
01081f8a mov        r9d, dword ptr [rbp - 0x41]
01081f8e mov        r8d, dword ptr [rbp - 0x49]
01081f92 cmp        r8d, 0x686f686d
01081f99 jne        0x1410820d9
01081f9f cmp        r11d, 0x320
01081fa6 je         0x141081fe6
01081fa8 sub        r9d, r10d
01081fab movsxd     rdx, r9d
01081fae add        rdx, qword ptr [r14 + 0x1e00170]
01081fb5 mov        qword ptr [r14 + 0x1e00170], rdx
01081fbc mov        rcx, qword ptr [r14 + 0x1e00178]
01081fc3 cmp        rdx, rcx
01081fc6 jb         0x141081fd4
01081fc8 add        rcx, qword ptr [r14 + 0x1e00180]
01081fcf cmp        rdx, rcx
01081fd2 jb         0x141081fdf
01081fd4 mov        qword ptr [r14 + 0x1e00180], 0
01081fdf xor        edi, edi
01081fe1 jmp        0x1410820b3
01081fe6 xorps      xmm0, xmm0
01081fe9 movdqu     xmmword ptr [rbp - 0x69], xmm0
01081fee sub        r9d, r10d
01081ff1 lea        r8, [rbp - 0x71]
01081ff5 mov        edx, r9d
01081ff8 mov        rcx, r14
01081ffb call       0x141077ee0
01082000 mov        edi, eax
01082002 test       eax, eax
01082004 jne        0x1410820d7
0108200a xor        r9d, r9d
0108200d mov        r15, qword ptr [rbp - 0x71]
01082011 mov        r8, r15
01082014 mov        rdx, qword ptr [r14 + 0x1e00270]
0108201b lea        rcx, [rbp - 0x59]
0108201f call       0x1410128e0
01082024 mov        rcx, qword ptr [rax]
01082027 mov        rbx, qword ptr [rax + 8]
0108202b xor        edx, edx
0108202d mov        qword ptr [rax], rdx
01082030 mov        qword ptr [rax + 8], rdx
01082034 mov        qword ptr [rbp - 0x69], rcx
01082038 mov        rsi, qword ptr [rbp - 0x51]
0108203c test       rsi, rsi
0108203f je         0x141082070
01082041 mov        eax, 0xffffffff
01082046 lock xadd  dword ptr [rsi + 8], eax
0108204b cmp        eax, 1
0108204e jne        0x141082070
01082050 mov        rax, qword ptr [rsi]
01082053 mov        rcx, rsi
01082056 call       qword ptr [rax]
01082058 mov        eax, 0xffffffff
0108205d lock xadd  dword ptr [rsi + 0xc], eax
01082062 cmp        eax, 1
01082065 jne        0x141082070
01082067 mov        rax, qword ptr [rsi]
0108206a mov        rcx, rsi
0108206d call       qword ptr [rax + 8]
01082070 test       r15, r15
01082073 je         0x14108207f
01082075 mov        rcx, r15
01082078 call       qword ptr [rip + 0x866da2]
0108207e nop        
0108207f test       rbx, rbx
01082082 je         0x1410820b3
01082084 mov        eax, 0xffffffff
01082089 lock xadd  dword ptr [rbx + 8], eax
0108208e cmp        eax, 1
01082091 jne        0x1410820b3
01082093 mov        rax, qword ptr [rbx]
01082096 mov        rcx, rbx
01082099 call       qword ptr [rax]
0108209b mov        eax, 0xffffffff
010820a0 lock xadd  dword ptr [rbx + 0xc], eax
010820a5 cmp        eax, 1
010820a8 jne        0x1410820b3
010820aa mov        rax, qword ptr [rbx]
010820ad mov        rcx, rbx
010820b0 call       qword ptr [rax + 8]
010820b3 mov        ebx, dword ptr [rbp - 0x79]
010820b6 inc        ebx
010820b8 mov        dword ptr [rbp - 0x79], ebx
010820bb cmp        ebx, dword ptr [rbp - 0x25]
010820be jb         0x141081dc0
010820c4 mov        ebx, dword ptr [rbp - 0x75]
010820c7 inc        ebx
010820c9 mov        dword ptr [rbp - 0x75], ebx
010820cc cmp        ebx, dword ptr [rbp + 7]
010820cf jb         0x141081c10
010820d5 jmp        0x1410820de
010820d7 jmp        0x1410820de
010820d9 mov        edi, 0xffffff30
010820de mov        eax, edi
010820e0 mov        rcx, qword ptr [rbp + 0x2f]
010820e4 xor        rcx, rsp
010820e7 call       0x14179b8e0
010820ec lea        r11, [rsp + 0xd0]
010820f4 mov        rbx, qword ptr [r11 + 0x38]
010820f8 mov        rsi, qword ptr [r11 + 0x40]
010820fc mov        rdi, qword ptr [r11 + 0x48]
01082100 mov        rsp, r11
01082103 pop        r15
01082105 pop        r14
01082107 pop        r13
01082109 pop        r12
0108210b pop        rbp
0108210c ret        
