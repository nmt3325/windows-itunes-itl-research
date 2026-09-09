; Original iTunes.exe machine code; base=0x140000000; RVA=0x1075810; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1075810..0x1075871 (exclusive)
01075810 push       rbp
01075812 push       rsi
01075813 push       rdi
01075814 push       r15
01075816 lea        rbp, [rsp - 8]
0107581b sub        rsp, 0x108
01075822 mov        rax, qword ptr [rip + 0xf5f817]
01075829 xor        rax, rsp
0107582c mov        qword ptr [rbp - 0x10], rax
01075830 xorps      xmm0, xmm0
01075833 mov        rsi, rdx
01075836 mov        r15, rcx
01075839 xor        eax, eax
0107583b mov        edx, 0x10
01075840 mov        qword ptr [rbp - 0x80], rax
01075844 mov        ecx, 0x1e00308
01075849 movups     xmmword ptr [rsp + 0x40], xmm0
0107584e movups     xmmword ptr [rsp + 0x50], xmm0
01075853 movups     xmmword ptr [rsp + 0x60], xmm0
01075858 movups     xmmword ptr [rsp + 0x70], xmm0
0107585d call       qword ptr [rip + 0x876b0d]
01075863 mov        rdi, rax
01075866 test       rax, rax
01075869 je         0x141075f3e
0107586f xor        edx, edx
; range 0x1075871..0x10758dc (exclusive)
01075871 mov        qword ptr [rsp + 0x140], rbx
01075879 mov        r8d, 0x1e00308
0107587f mov        rcx, rax
01075882 call       0x14179cca0
01075887 xor        edx, edx
01075889 mov        qword ptr [rdi + 0x1e00270], r15
01075890 mov        rcx, rsi
01075893 call       0x140ba0910
01075898 mov        ebx, eax
0107589a test       eax, eax
0107589c jne        0x141075f29
010758a2 mov        rcx, rdi
010758a5 mov        qword ptr [rdi + 0x120], rsi
010758ac call       0x14106a430
010758b1 call       0x140bc83c0
010758b6 mov        r8, rdi
010758b9 mov        dword ptr [rdi + 0x64], eax
010758bc lea        rdx, [rsp + 0x28]
010758c1 mov        qword ptr [rsp + 0x28], 0x90
010758ca mov        rcx, rsi
010758cd call       0x140ba04c0
010758d2 mov        ebx, eax
010758d4 test       eax, eax
010758d6 jne        0x141075f29
; range 0x10758dc..0x1075f29 (exclusive)
010758dc mov        qword ptr [rsp + 0x100], r14
010758e4 xor        r14d, r14d
010758e7 mov        qword ptr [rsp + 0x30], r14
010758ec cmp        byte ptr [rsi + 5], r14b
010758f0 je         0x1410758f8
010758f2 mov        rcx, qword ptr [rsi + 0x40]
010758f6 jmp        0x141075915
010758f8 mov        rcx, qword ptr [rsi + 8]
010758fc lea        rdx, [rsp + 0x30]
01075901 call       0x140bd6640
01075906 mov        ebx, eax
01075908 test       eax, eax
0107590a jne        0x141075f21
01075910 mov        rcx, qword ptr [rsp + 0x30]
01075915 mov        rax, qword ptr [rsi + 0x20]
01075919 cmp        byte ptr [rsi + 5], r14b
0107591d je         0x141075928
0107591f sub        rax, qword ptr [rsi + 0x38]
01075923 dec        rax
01075926 jmp        0x14107592c
01075928 sub        rax, qword ptr [rsi + 0x30]
0107592c add        rax, rcx
0107592f mov        rcx, rdi
01075932 mov        qword ptr [rsp + 0x30], rax
01075937 call       0x14106cba0
0107593c mov        ebx, eax
0107593e test       eax, eax
01075940 jne        0x141075f21
01075946 mov        rdx, qword ptr [rip + 0x10315e3]
0107594d mov        rcx, rdi
01075950 inc        dword ptr [rdi + 0x30]
01075953 mov        rdx, qword ptr [rdx + 0x14190]
0107595a call       0x14106cce0
0107595f mov        ebx, eax
01075961 test       eax, eax
01075963 jne        0x141075f21
01075969 inc        dword ptr [rdi + 0x30]
0107596c lea        r8, [rdi + 0x4c]
01075970 mov        rdx, r15
01075973 mov        rcx, rdi
01075976 call       0x14106bcf0
0107597b mov        ebx, eax
0107597d test       eax, eax
0107597f jne        0x141075f21
01075985 inc        dword ptr [rdi + 0x30]
01075988 lea        r8, [rdi + 0x54]
0107598c mov        rdx, r15
0107598f mov        rcx, rdi
01075992 call       0x14106c500
01075997 mov        ebx, eax
01075999 test       eax, eax
0107599b jne        0x141075f21
010759a1 inc        dword ptr [rdi + 0x30]
010759a4 lea        r9, [rdi + 0x44]
010759a8 mov        r8d, 1
010759ae mov        rdx, r15
010759b1 mov        rcx, rdi
010759b4 call       0x141070370
010759b9 mov        ebx, eax
010759bb test       eax, eax
010759bd jne        0x141075f21
010759c3 inc        dword ptr [rdi + 0x30]
010759c6 lea        r9, [rsp + 0x28]
010759cb mov        r8d, 0xd
010759d1 mov        rdx, r15
010759d4 mov        rcx, rdi
010759d7 call       0x141070370
010759dc mov        ebx, eax
010759de test       eax, eax
010759e0 jne        0x141075f21
010759e6 inc        dword ptr [rdi + 0x30]
010759e9 lea        rdx, [rsp + 0x20]
010759ee mov        rcx, rdi
010759f1 call       0x141074060
010759f6 mov        ebx, eax
010759f8 test       eax, eax
010759fa jne        0x141075f21
01075a00 cmp        byte ptr [rsp + 0x20], r14b
01075a05 je         0x141075a0a
01075a07 inc        dword ptr [rdi + 0x30]
01075a0a lea        rdx, [rsp + 0x20]
01075a0f mov        rcx, rdi
01075a12 call       0x141075000
01075a17 mov        ebx, eax
01075a19 test       eax, eax
01075a1b jne        0x141075f21
01075a21 cmp        byte ptr [rsp + 0x20], r14b
01075a26 je         0x141075a2b
01075a28 inc        dword ptr [rdi + 0x30]
01075a2b xor        r9d, r9d
01075a2e xor        r8d, r8d
01075a31 mov        edx, 2
01075a36 mov        rcx, rdi
01075a39 call       0x1410725a0
01075a3e mov        ebx, eax
01075a40 test       eax, eax
01075a42 jne        0x141075f21
01075a48 inc        dword ptr [rdi + 0x30]
01075a4b xor        r9d, r9d
01075a4e xor        r8d, r8d
01075a51 mov        edx, 0xe
01075a56 mov        rcx, rdi
01075a59 call       0x1410725a0
01075a5e mov        ebx, eax
01075a60 test       eax, eax
01075a62 jne        0x141075f21
01075a68 inc        dword ptr [rdi + 0x30]
01075a6b mov        rax, qword ptr [rip + 0x10314be]
01075a72 mov        byte ptr [rsp + 0x20], r14b
01075a77 mov        rcx, qword ptr [rax + 0x166e8]
01075a7e test       rcx, rcx
01075a81 je         0x141075b86
01075a87 mov        rax, qword ptr [rdi + 0x1e00270]
01075a8e test       byte ptr [rax + 0x110], 1
01075a95 je         0x141075b86
01075a9b xorps      xmm0, xmm0
01075a9e mov        dword ptr [rbp - 0x70], 0x6864736d
01075aa5 movaps     xmmword ptr [rbp - 0x60], xmm0
01075aa9 mov        eax, r14d
01075aac movaps     xmmword ptr [rbp - 0x50], xmm0
01075ab0 movaps     xmmword ptr [rbp - 0x40], xmm0
01075ab4 movaps     xmmword ptr [rbp - 0x30], xmm0
01075ab8 movaps     xmmword ptr [rbp - 0x20], xmm0
01075abc mov        dword ptr [rbp - 0x6c], 0x60
01075ac3 mov        dword ptr [rbp - 0x64], 3
01075aca cmp        dword ptr [rcx + 8], 0x4d656d48
01075ad1 jne        0x141075ad6
01075ad3 mov        eax, dword ptr [rcx + 0x10]
01075ad6 add        eax, 0x60
01075ad9 mov        dword ptr [rbp - 0x68], eax
01075adc cmp        byte ptr [rdi + 0x52], r14b
01075ae0 jne        0x141075afc
01075ae2 bswap      eax
01075ae4 mov        dword ptr [rbp - 0x68], eax
01075ae7 mov        dword ptr [rbp - 0x70], 0x6d736468
01075aee mov        dword ptr [rbp - 0x6c], 0x60000000
01075af5 mov        dword ptr [rbp - 0x64], 0x3000000
01075afc mov        rcx, qword ptr [rdi + 0x120]
01075b03 lea        r8, [rbp - 0x70]
01075b07 lea        rdx, [rsp + 0x28]
01075b0c mov        qword ptr [rsp + 0x28], 0x60
01075b15 call       0x140ba04c0
01075b1a mov        ebx, eax
01075b1c test       eax, eax
01075b1e jne        0x141075f21
01075b24 mov        rax, qword ptr [rip + 0x1031405]
01075b2b mov        rcx, qword ptr [rax + 0x166e8]
01075b32 test       rcx, rcx
01075b35 je         0x141075b48
01075b37 cmp        dword ptr [rcx + 8], 0x4d656d48
01075b3e jne        0x141075b48
01075b40 mov        edx, dword ptr [rcx + 0x10]
01075b43 mov        r8, qword ptr [rcx]
01075b46 jmp        0x141075b61
01075b48 mov        edx, r14d
01075b4b test       rcx, rcx
01075b4e je         0x141075b5e
01075b50 cmp        dword ptr [rcx + 8], 0x4d656d48
01075b57 jne        0x141075b5e
01075b59 mov        r8, qword ptr [rcx]
01075b5c jmp        0x141075b61
01075b5e mov        r8, r14
01075b61 mov        rcx, qword ptr [rdi + 0x120]
01075b68 mov        eax, edx
01075b6a lea        rdx, [rsp + 0x28]
01075b6f mov        qword ptr [rsp + 0x28], rax
01075b74 call       0x140ba04c0
01075b79 mov        ebx, eax
01075b7b test       eax, eax
01075b7d jne        0x141075f21
01075b83 inc        dword ptr [rdi + 0x30]
01075b86 mov        rax, qword ptr [rip + 0x10313a3]
01075b8d mov        byte ptr [rsp + 0x20], r14b
01075b92 mov        rcx, qword ptr [rax + 0x166f0]
01075b99 test       rcx, rcx
01075b9c je         0x141075ca0
01075ba2 mov        rax, qword ptr [rdi + 0x1e00270]
01075ba9 test       byte ptr [rax + 0x110], 1
01075bb0 je         0x141075ca0
01075bb6 xorps      xmm0, xmm0
01075bb9 mov        dword ptr [rbp - 0x70], 0x6864736d
01075bc0 movaps     xmmword ptr [rbp - 0x60], xmm0
01075bc4 mov        eax, r14d
01075bc7 movaps     xmmword ptr [rbp - 0x50], xmm0
01075bcb movaps     xmmword ptr [rbp - 0x40], xmm0
01075bcf movaps     xmmword ptr [rbp - 0x30], xmm0
01075bd3 movaps     xmmword ptr [rbp - 0x20], xmm0
01075bd7 mov        dword ptr [rbp - 0x6c], 0x60
01075bde mov        dword ptr [rbp - 0x64], 0xa
01075be5 cmp        dword ptr [rcx + 8], 0x4d656d48
01075bec jne        0x141075bf1
01075bee mov        eax, dword ptr [rcx + 0x10]
01075bf1 add        eax, 0x60
01075bf4 mov        dword ptr [rbp - 0x68], eax
01075bf7 cmp        byte ptr [rdi + 0x52], r14b
01075bfb jne        0x141075c17
01075bfd bswap      eax
01075bff mov        dword ptr [rbp - 0x68], eax
01075c02 mov        dword ptr [rbp - 0x70], 0x6d736468
01075c09 mov        dword ptr [rbp - 0x6c], 0x60000000
01075c10 mov        dword ptr [rbp - 0x64], 0xa000000
01075c17 mov        rcx, qword ptr [rdi + 0x120]
01075c1e lea        r8, [rbp - 0x70]
01075c22 lea        rdx, [rsp + 0x28]
01075c27 mov        qword ptr [rsp + 0x28], 0x60
01075c30 call       0x140ba04c0
01075c35 mov        ebx, eax
01075c37 test       eax, eax
01075c39 jne        0x141075f21
01075c3f mov        rax, qword ptr [rip + 0x10312ea]
01075c46 mov        rcx, qword ptr [rax + 0x166f0]
01075c4d test       rcx, rcx
01075c50 je         0x141075c77
01075c52 cmp        dword ptr [rcx + 8], 0x4d656d48
01075c59 jne        0x141075c64
01075c5b mov        r14d, dword ptr [rcx + 0x10]
01075c5f mov        r8, qword ptr [rcx]
01075c62 jmp        0x141075c7a
01075c64 test       rcx, rcx
01075c67 je         0x141075c77
01075c69 cmp        dword ptr [rcx + 8], 0x4d656d48
01075c70 jne        0x141075c77
01075c72 mov        r8, qword ptr [rcx]
01075c75 jmp        0x141075c7a
01075c77 mov        r8, r14
01075c7a mov        rcx, qword ptr [rdi + 0x120]
01075c81 lea        rdx, [rsp + 0x28]
01075c86 mov        eax, r14d
01075c89 mov        qword ptr [rsp + 0x28], rax
01075c8e call       0x140ba04c0
01075c93 mov        ebx, eax
01075c95 test       eax, eax
01075c97 jne        0x141075f21
01075c9d inc        dword ptr [rdi + 0x30]
01075ca0 mov        rax, qword ptr [rdi + 0x1e00270]
01075ca7 mov        byte ptr [rsp + 0x20], 0
01075cac test       byte ptr [rax + 0x110], 1
01075cb3 je         0x141075dfe
01075cb9 mov        r14, qword ptr [rip + 0x102f2a0]
01075cc0 test       r14, r14
01075cc3 je         0x141075dfe
01075cc9 xorps      xmm0, xmm0
01075ccc mov        dword ptr [rbp - 0x70], 0x6864736d
01075cd3 mov        rcx, r14
01075cd6 movaps     xmmword ptr [rbp - 0x60], xmm0
01075cda movaps     xmmword ptr [rbp - 0x50], xmm0
01075cde movaps     xmmword ptr [rbp - 0x40], xmm0
01075ce2 movaps     xmmword ptr [rbp - 0x30], xmm0
01075ce6 movaps     xmmword ptr [rbp - 0x20], xmm0
01075cea mov        dword ptr [rbp - 0x6c], 0x60
01075cf1 mov        dword ptr [rbp - 0x64], 0x16
01075cf8 call       qword ptr [rip + 0x873272]
01075cfe cmp        byte ptr [rdi + 0x52], 0
01075d02 lea        r8d, [rax + 0x60]
01075d06 mov        dword ptr [rbp - 0x68], r8d
01075d0a jne        0x141075d95
01075d10 mov        ecx, dword ptr [rbp - 0x70]
01075d13 mov        edx, ecx
01075d15 and        edx, 0xff0000
01075d1b mov        eax, ecx
01075d1d shr        eax, 0x10
01075d20 or         edx, eax
01075d22 mov        eax, ecx
01075d24 shl        eax, 0x10
01075d27 and        ecx, 0xff00
01075d2d or         eax, ecx
01075d2f shr        edx, 8
01075d32 mov        ecx, dword ptr [rbp - 0x6c]
01075d35 shl        eax, 8
01075d38 or         edx, eax
01075d3a mov        eax, ecx
01075d3c shr        eax, 0x10
01075d3f mov        dword ptr [rbp - 0x70], edx
01075d42 mov        edx, ecx
01075d44 and        edx, 0xff0000
01075d4a or         edx, eax
01075d4c mov        eax, ecx
01075d4e shl        eax, 0x10
01075d51 and        ecx, 0xff00
01075d57 or         eax, ecx
01075d59 shr        edx, 8
01075d5c mov        ecx, dword ptr [rbp - 0x64]
01075d5f shl        eax, 8
01075d62 or         edx, eax
01075d64 mov        eax, ecx
01075d66 shr        eax, 0x10
01075d69 mov        dword ptr [rbp - 0x6c], edx
01075d6c mov        edx, ecx
01075d6e and        edx, 0xff0000
01075d74 or         edx, eax
01075d76 mov        eax, ecx
01075d78 shl        eax, 0x10
01075d7b and        ecx, 0xff00
01075d81 or         eax, ecx
01075d83 shr        edx, 8
01075d86 shl        eax, 8
01075d89 or         edx, eax
01075d8b bswap      r8d
01075d8e mov        dword ptr [rbp - 0x64], edx
01075d91 mov        dword ptr [rbp - 0x68], r8d
01075d95 mov        rcx, qword ptr [rdi + 0x120]
01075d9c lea        r8, [rbp - 0x70]
01075da0 lea        rdx, [rsp + 0x28]
01075da5 mov        qword ptr [rsp + 0x28], 0x60
01075dae call       0x140ba04c0
01075db3 mov        ebx, eax
01075db5 test       eax, eax
01075db7 jne        0x141075f21
01075dbd mov        rcx, r14
01075dc0 call       qword ptr [rip + 0x8731aa]
01075dc6 mov        rcx, r14
01075dc9 mov        rbx, rax
01075dcc call       qword ptr [rip + 0x8731a6]
01075dd2 mov        rcx, qword ptr [rdi + 0x120]
01075dd9 lea        rdx, [rsp + 0x28]
01075dde mov        r8, rax
01075de1 mov        qword ptr [rsp + 0x28], rbx
01075de6 call       0x140ba04c0
01075deb mov        ebx, eax
01075ded test       eax, eax
01075def jne        0x141075f21
01075df5 inc        dword ptr [rdi + 0x30]
01075df8 mov        al, 1
01075dfa mov        byte ptr [rsp + 0x20], al
01075dfe lea        rdx, [rsp + 0x20]
01075e03 mov        rcx, rdi
01075e06 call       0x141072aa0
01075e0b mov        ebx, eax
01075e0d test       eax, eax
01075e0f jne        0x141075f21
01075e15 cmp        byte ptr [rsp + 0x20], al
01075e19 je         0x141075e1e
01075e1b inc        dword ptr [rdi + 0x30]
01075e1e lea        rdx, [rsp + 0x20]
01075e23 mov        rcx, rdi
01075e26 call       0x141073040
01075e2b mov        ebx, eax
01075e2d test       eax, eax
01075e2f jne        0x141075f21
01075e35 cmp        byte ptr [rsp + 0x20], al
01075e39 je         0x141075e3e
01075e3b inc        dword ptr [rdi + 0x30]
01075e3e mov        rcx, rdi
01075e41 call       0x141073490
01075e46 mov        ebx, eax
01075e48 test       eax, eax
01075e4a jne        0x141075f21
01075e50 inc        dword ptr [rdi + 0x30]
01075e53 lea        rdx, [rsp + 0x20]
01075e58 mov        rcx, rdi
01075e5b call       0x141073680
01075e60 mov        ebx, eax
01075e62 test       eax, eax
01075e64 jne        0x141075f21
01075e6a cmp        byte ptr [rsp + 0x20], al
01075e6e je         0x141075e73
01075e70 inc        dword ptr [rdi + 0x30]
01075e73 lea        rdx, [rsp + 0x20]
01075e78 mov        rcx, rdi
01075e7b call       0x141073bb0
01075e80 mov        ebx, eax
01075e82 test       eax, eax
01075e84 jne        0x141075f21
01075e8a cmp        byte ptr [rsp + 0x20], al
01075e8e je         0x141075e93
01075e90 inc        dword ptr [rdi + 0x30]
01075e93 mov        rcx, qword ptr [rdi + 0x120]
01075e9a call       0x140ba0000
01075e9f mov        ebx, eax
01075ea1 test       eax, eax
01075ea3 jne        0x141075f21
01075ea5 lea        rdx, [rsp + 0x38]
01075eaa mov        rcx, rsi
01075ead call       0x140ba0890
01075eb2 mov        ebx, eax
01075eb4 test       eax, eax
01075eb6 jne        0x141075f21
01075eb8 mov        eax, dword ptr [rsp + 0x38]
01075ebc mov        rcx, rsi
01075ebf mov        rdx, qword ptr [rsp + 0x30]
01075ec4 mov        dword ptr [rdi + 8], eax
01075ec7 call       0x140ba09a0
01075ecc mov        ebx, eax
01075ece test       eax, eax
01075ed0 jne        0x141075f21
01075ed2 mov        rcx, rdi
01075ed5 call       0x14106cba0
01075eda mov        ebx, eax
01075edc test       eax, eax
01075ede jne        0x141075f21
01075ee0 xor        edx, edx
01075ee2 mov        rcx, rsi
01075ee5 call       0x140ba09a0
01075eea mov        ebx, eax
01075eec test       eax, eax
01075eee jne        0x141075f21
01075ef0 mov        rcx, rdi
01075ef3 call       0x141068f90
01075ef8 mov        r8, rdi
01075efb mov        qword ptr [rsp + 0x28], 0x90
01075f04 lea        rdx, [rsp + 0x28]
01075f09 mov        rcx, rsi
01075f0c call       0x140ba04c0
01075f11 mov        ebx, eax
01075f13 test       eax, eax
01075f15 jne        0x141075f21
01075f17 mov        rcx, rsi
01075f1a call       0x140ba0000
01075f1f mov        ebx, eax
01075f21 mov        r14, qword ptr [rsp + 0x100]
; range 0x1075f29..0x1075f3e (exclusive)
01075f29 mov        rcx, rdi
01075f2c call       qword ptr [rip + 0x876436]
01075f32 mov        eax, ebx
01075f34 mov        rbx, qword ptr [rsp + 0x140]
01075f3c jmp        0x141075f43
; range 0x1075f3e..0x1075f5c (exclusive)
01075f3e mov        eax, 0xffffff94
01075f43 mov        rcx, qword ptr [rbp - 0x10]
01075f47 xor        rcx, rsp
01075f4a call       0x14179b8e0
01075f4f add        rsp, 0x108
01075f56 pop        r15
01075f58 pop        rdi
01075f59 pop        rsi
01075f5a pop        rbp
01075f5b ret        
