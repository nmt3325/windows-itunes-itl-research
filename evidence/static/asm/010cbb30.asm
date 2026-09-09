; Original iTunes.exe machine code; base=0x140000000; RVA=0x10cbb30; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x10cbb30..0x10cbb98 (exclusive)
010cbb30 push       rbp
010cbb32 push       rbx
010cbb33 push       rsi
010cbb34 push       rdi
010cbb35 push       r12
010cbb37 lea        rbp, [rsp - 0x30]
010cbb3c sub        rsp, 0x130
010cbb43 mov        rax, qword ptr [rip + 0xf094f6]
010cbb4a xor        rax, rsp
010cbb4d mov        qword ptr [rbp + 0x10], rax
010cbb51 xorps      xmm0, xmm0
010cbb54 mov        dword ptr [rsp + 0x30], r9d
010cbb59 mov        r12, rdx
010cbb5c mov        rdi, rcx
010cbb5f xor        eax, eax
010cbb61 lea        rdx, [rip + 0x847098]
010cbb68 mov        ecx, 0x1e00308
010cbb6d mov        qword ptr [rbp - 0x70], rax
010cbb71 movups     xmmword ptr [rsp + 0x50], xmm0
010cbb76 mov        esi, r9d
010cbb79 movups     xmmword ptr [rsp + 0x60], xmm0
010cbb7e movups     xmmword ptr [rsp + 0x70], xmm0
010cbb83 movups     xmmword ptr [rbp - 0x80], xmm0
010cbb87 call       0x14179beec
010cbb8c mov        rbx, rax
010cbb8f test       rax, rax
010cbb92 je         0x1410cc39d
; range 0x10cbb98..0x10cc383 (exclusive)
010cbb98 mov        qword ptr [rsp + 0x160], r13
010cbba0 xor        edx, edx
010cbba2 mov        qword ptr [rsp + 0x128], r14
010cbbaa mov        r8d, 0x1e00278
010cbbb0 mov        rcx, rax
010cbbb3 mov        qword ptr [rsp + 0x120], r15
010cbbbb call       0x14179cca0
010cbbc0 xor        r13d, r13d
010cbbc3 lea        rcx, [rsp + 0x48]
010cbbc8 xorps      xmm0, xmm0
010cbbcb xor        eax, eax
010cbbcd movups     xmmword ptr [rbx + 0x1e002f0], xmm0
010cbbd4 mov        qword ptr [rbx + 0x1e00300], rax
010cbbdb mov        qword ptr [rbx + 0x1e00278], r13
010cbbe2 mov        qword ptr [rbx + 0x1e00280], r13
010cbbe9 mov        qword ptr [rbx + 0x1e00288], r13
010cbbf0 mov        qword ptr [rbx + 0x1e00290], r13
010cbbf7 mov        qword ptr [rbx + 0x1e00298], r13
010cbbfe mov        qword ptr [rbx + 0x1e002a0], r13
010cbc05 mov        qword ptr [rbx + 0x1e002a8], r13
010cbc0c mov        qword ptr [rbx + 0x1e002b0], r13
010cbc13 mov        qword ptr [rbx + 0x1e002b8], r13
010cbc1a mov        qword ptr [rbx + 0x1e002c0], r13
010cbc21 mov        qword ptr [rbx + 0x1e002c8], r13
010cbc28 mov        qword ptr [rbx + 0x1e002d0], r13
010cbc2f mov        qword ptr [rbx + 0x1e002d8], r13
010cbc36 mov        qword ptr [rbx + 0x1e002e0], r13
010cbc3d mov        qword ptr [rbx + 0x1e002e8], r13
010cbc44 call       qword ptr [rip + 0x81ef3e]
010cbc4a mov        rax, qword ptr [rsp + 0x48]
010cbc4f lea        r15, [rbx + 0x1e001b0]
010cbc56 mov        r8d, 0x90
010cbc5c mov        qword ptr [r15], rax
010cbc5f mov        rdx, rbx
010cbc62 mov        qword ptr [rsp + 0x38], r15
010cbc67 mov        rcx, rbx
010cbc6a mov        qword ptr [rbx + 0x120], rdi
010cbc71 mov        qword ptr [rbx + 0x1e00188], r13
010cbc78 mov        qword ptr [rbx + 0x1e00160], 0xffffffffffffffff
010cbc83 mov        qword ptr [rbx + 0x1e00168], 0xffffffffffffffff
010cbc8e call       0x1410770a0
010cbc93 mov        edi, eax
010cbc95 mov        r14, rbx
010cbc98 test       eax, eax
010cbc9a jne        0x1410cc2e5
010cbca0 mov        rcx, rbx
010cbca3 call       0x1410c6130
010cbca8 mov        r9d, dword ptr [rbx]
010cbcab cmp        r9d, 0x6864666d
010cbcb2 je         0x1410cbcc7
010cbcb4 cmp        r9d, 0x6864676d
010cbcbb je         0x1410cbcc7
010cbcbd mov        edi, 0xffffff30
010cbcc2 jmp        0x1410cc28e
010cbcc7 bt         esi, 0x1e
010cbccb jae        0x1410cbcde
010cbccd cmp        word ptr [rbx + 0x50], 0x38
010cbcd2 jbe        0x1410cbcef
010cbcd4 mov        edi, 0xfffffc94
010cbcd9 jmp        0x1410cc28e
010cbcde cmp        word ptr [rbx + 0xc], 0x43
010cbce3 jbe        0x1410cbcef
010cbce5 mov        edi, 0xfffffc94
010cbcea jmp        0x1410cc28e
010cbcef cmp        dword ptr [rbx + 0x30], r13d
010cbcf3 jne        0x1410cbcff
010cbcf5 mov        edi, 0xffffff30
010cbcfa jmp        0x1410cc28e
010cbcff movzx      eax, byte ptr [rbx + 0x41]
010cbd03 test       al, al
010cbd05 je         0x1410cbd17
010cbd07 dec        al
010cbd09 cmp        al, 1
010cbd0b jbe        0x1410cbd17
010cbd0d mov        edi, 0xfffffc94
010cbd12 jmp        0x1410cc28e
010cbd17 mov        edx, dword ptr [rbx + 4]
010cbd1a cmp        edx, 0x90
010cbd20 jae        0x1410cbd39
010cbd22 mov        ecx, edx
010cbd24 add        rcx, rbx
010cbd27 je         0x1410cbd39
010cbd29 mov        r8d, 0x90
010cbd2f sub        r8d, edx
010cbd32 xor        edx, edx
010cbd34 call       0x14179cca0
010cbd39 cmp        byte ptr [rbx + 0x52], r13b
010cbd3d mov        rdx, rbx
010cbd40 mov        rax, qword ptr [r12]
010cbd44 mov        rcx, r12
010cbd47 sete       r8b
010cbd4b call       qword ptr [rax]
010cbd4d mov        edi, eax
010cbd4f test       eax, eax
010cbd51 jne        0x1410cc28e
010cbd57 mov        r9d, dword ptr [rbx + 0x54]
010cbd5b add        r9d, dword ptr [rbx + 0x4c]
010cbd5f add        r9d, dword ptr [rbx + 0x48]
010cbd63 add        r9d, dword ptr [rbx + 0x44]
010cbd67 mov        qword ptr [rbx + 0x1e00198], r9
010cbd6e jne        0x1410cbd82
010cbd70 mov        qword ptr [rbx + 0x1e00198], 0xffffffffffffffff
010cbd7b mov        r9, 0xffffffffffffffff
010cbd82 mov        rcx, qword ptr [rbx + 0x1e00188]
010cbd89 test       rcx, rcx
010cbd8c je         0x1410cbda5
010cbd8e mov        rax, qword ptr [rcx]
010cbd91 test       rax, rax
010cbd94 je         0x1410cbda5
010cbd96 xor        r8d, r8d
010cbd99 mov        qword ptr [rsp + 0x20], r13
010cbd9e mov        edx, 0x6370726d
010cbda3 call       rax
010cbda5 mov        qword ptr [rbx + 0x1e00160], 0xffffffffffffffff
010cbdb0 mov        qword ptr [rbx + 0x1e00168], 0xffffffffffffffff
010cbdbb cmp        byte ptr [rbx + 0x43], r13b
010cbdbf je         0x1410cbe8b
010cbdc5 mov        edx, 0xa00000
010cbdca lea        rcx, [rsp + 0x50]
010cbdcf call       0x140b9fe10
010cbdd4 test       eax, eax
010cbdd6 jne        0x1410cc36b
010cbddc mov        edx, dword ptr [rbx + 4]
010cbddf mov        rcx, qword ptr [rbx + 0x120]
010cbde6 call       0x140ba09a0
010cbdeb movzx      eax, byte ptr [rbx + 0x41]
010cbdef mov        ecx, dword ptr [rbx + 4]
010cbdf2 mov        qword ptr [rbx + 0x1e00170], rcx
010cbdf9 test       al, al
010cbdfb je         0x1410cbe32
010cbdfd mov        qword ptr [rbx + 0x1e00160], rcx
010cbe04 cmp        al, 2
010cbe06 jne        0x1410cbe15
010cbe08 mov        eax, dword ptr [rbx + 0x5c]
010cbe0b add        rax, rcx
010cbe0e mov        qword ptr [rbx + 0x1e00168], rax
010cbe15 lea        rcx, [rbx + 0x1e00128]
010cbe1c call       0x1410c6970
010cbe21 mov        edi, eax
010cbe23 test       eax, eax
010cbe25 jne        0x1410cc28e
010cbe2b mov        qword ptr [rbx + 0x1e00180], r13
010cbe32 lea        rdx, [rsp + 0x50]
010cbe37 mov        rcx, rbx
010cbe3a call       0x141084190
010cbe3f mov        edi, eax
010cbe41 mov        r14, rbx
010cbe44 test       eax, eax
010cbe46 jne        0x1410cc28e
010cbe4c xor        edx, edx
010cbe4e lea        rcx, [rsp + 0x50]
010cbe53 call       0x140ba09a0
010cbe58 lea        rax, [rsp + 0x50]
010cbe5d mov        byte ptr [rbx + 0x41], r13b
010cbe61 mov        qword ptr [rbx + 0x120], rax
010cbe68 mov        byte ptr [rbx + 0x43], r13b
010cbe6c mov        qword ptr [rbx + 0x1e00160], 0xffffffffffffffff
010cbe77 mov        qword ptr [rbx + 0x1e00168], 0xffffffffffffffff
010cbe82 mov        qword ptr [rbx + 0x1e00170], r13
010cbe89 jmp        0x1410cbec4
010cbe8b movzx      eax, byte ptr [rbx + 0x41]
010cbe8f test       al, al
010cbe91 je         0x1410cbecb
010cbe93 mov        ecx, dword ptr [rbx + 4]
010cbe96 mov        qword ptr [rbx + 0x1e00160], rcx
010cbe9d cmp        al, 2
010cbe9f jne        0x1410cbeae
010cbea1 mov        eax, dword ptr [rbx + 0x5c]
010cbea4 add        rax, rcx
010cbea7 mov        qword ptr [rbx + 0x1e00168], rax
010cbeae lea        rcx, [rbx + 0x1e00128]
010cbeb5 call       0x1410c6970
010cbeba mov        edi, eax
010cbebc test       eax, eax
010cbebe jne        0x1410cc28e
010cbec4 mov        qword ptr [rbx + 0x1e00180], r13
010cbecb mov        edx, dword ptr [rbx + 4]
010cbece cmp        edx, 0x90
010cbed4 jae        0x1410cbeed
010cbed6 mov        ecx, edx
010cbed8 add        rcx, rbx
010cbedb je         0x1410cbeed
010cbedd mov        r8d, 0x90
010cbee3 sub        r8d, edx
010cbee6 xor        edx, edx
010cbee8 call       0x14179cca0
010cbeed mov        edx, dword ptr [rbx + 4]
010cbef0 mov        rcx, rbx
010cbef3 sub        edx, 0x90
010cbef9 call       0x14106a520
010cbefe mov        edi, eax
010cbf00 mov        r14, rbx
010cbf03 test       eax, eax
010cbf05 jne        0x1410cc28e
010cbf0b mov        dword ptr [rsp + 0x48], r13d
010cbf10 cmp        dword ptr [rbx + 0x30], r13d
010cbf14 jbe        0x1410cc28e
010cbf1a nop        word ptr [rax + rax]
010cbf20 lea        rcx, [rsp + 0x40]
010cbf25 call       qword ptr [rip + 0x81ec5d]
010cbf2b mov        r8d, 8
010cbf31 lea        rdx, [rbp - 0x50]
010cbf35 mov        rcx, r14
010cbf38 call       0x1410770a0
010cbf3d mov        edi, eax
010cbf3f test       eax, eax
010cbf41 jne        0x1410cc289
010cbf47 mov        r10d, dword ptr [rbp - 0x4c]
010cbf4b mov        r15d, r10d
010cbf4e cmp        byte ptr [rbx + 0x52], al
010cbf51 jne        0x1410cbf56
010cbf53 bswap      r15d
010cbf56 mov        r13d, 0x60
010cbf5c lea        rcx, [rbp - 0x48]
010cbf60 cmp        r15d, r13d
010cbf63 cmovb      r13d, r15d
010cbf67 cmp        r13d, 8
010cbf6b jbe        0x1410cbfa2
010cbf6d lea        esi, [r13 - 8]
010cbf71 cmp        rsi, 0xa00000
010cbf78 ja         0x1410cc281
010cbf7e mov        r8d, esi
010cbf81 lea        rdx, [rbp - 0x48]
010cbf85 mov        rcx, r14
010cbf88 call       0x1410770a0
010cbf8d mov        edi, eax
010cbf8f test       eax, eax
010cbf91 jne        0x1410cc286
010cbf97 mov        r10d, dword ptr [rbp - 0x4c]
010cbf9b lea        rcx, [rbp - 0x48]
010cbf9f add        rcx, rsi
010cbfa2 cmp        r13d, 0x60
010cbfa6 jae        0x1410cbfc1
010cbfa8 test       rcx, rcx
010cbfab je         0x1410cbfc1
010cbfad mov        r8d, 0x60
010cbfb3 xor        edx, edx
010cbfb5 sub        r8d, r13d
010cbfb8 call       0x14179cca0
010cbfbd mov        r10d, dword ptr [rbp - 0x4c]
010cbfc1 cmp        r15d, r13d
010cbfc4 jbe        0x1410cbfde
010cbfc6 sub        r15d, r13d
010cbfc9 mov        rcx, r14
010cbfcc mov        edx, r15d
010cbfcf call       0x14106a520
010cbfd4 mov        edi, eax
010cbfd6 test       eax, eax
010cbfd8 jne        0x1410cc286
010cbfde cmp        byte ptr [rbx + 0x52], 0
010cbfe2 jne        0x1410cc0a5
010cbfe8 mov        ecx, dword ptr [rbp - 0x50]
010cbfeb mov        r9d, ecx
010cbfee mov        eax, ecx
010cbff0 and        r9d, 0xff0000
010cbff7 shr        eax, 0x10
010cbffa or         r9d, eax
010cbffd mov        eax, ecx
010cbfff shl        eax, 0x10
010cc002 and        ecx, 0xff00
010cc008 or         eax, ecx
010cc00a shr        r9d, 8
010cc00e shl        eax, 8
010cc011 mov        ecx, r10d
010cc014 or         r9d, eax
010cc017 and        ecx, 0xff0000
010cc01d mov        eax, r10d
010cc020 mov        dword ptr [rbp - 0x50], r9d
010cc024 shr        eax, 0x10
010cc027 or         ecx, eax
010cc029 mov        eax, r10d
010cc02c shl        eax, 0x10
010cc02f and        r10d, 0xff00
010cc036 or         eax, r10d
010cc039 shr        ecx, 8
010cc03c shl        eax, 8
010cc03f mov        r10d, ecx
010cc042 mov        ecx, dword ptr [rbp - 0x48]
010cc045 or         r10d, eax
010cc048 mov        eax, ecx
010cc04a mov        dword ptr [rbp - 0x4c], r10d
010cc04e shr        eax, 0x10
010cc051 mov        edx, ecx
010cc053 and        edx, 0xff0000
010cc059 or         edx, eax
010cc05b mov        eax, ecx
010cc05d shl        eax, 0x10
010cc060 and        ecx, 0xff00
010cc066 or         eax, ecx
010cc068 shr        edx, 8
010cc06b mov        ecx, dword ptr [rbp - 0x44]
010cc06e mov        r8d, ecx
010cc071 shl        eax, 8
010cc074 and        r8d, 0xff0000
010cc07b or         edx, eax
010cc07d mov        eax, ecx
010cc07f shr        eax, 0x10
010cc082 or         r8d, eax
010cc085 mov        dword ptr [rbp - 0x48], edx
010cc088 mov        eax, ecx
010cc08a shr        r8d, 8
010cc08e shl        eax, 0x10
010cc091 and        ecx, 0xff00
010cc097 or         eax, ecx
010cc099 shl        eax, 8
010cc09c or         r8d, eax
010cc09f mov        dword ptr [rbp - 0x44], r8d
010cc0a3 jmp        0x1410cc0b0
010cc0a5 mov        r8d, dword ptr [rbp - 0x44]
010cc0a9 mov        edx, dword ptr [rbp - 0x48]
010cc0ac mov        r9d, dword ptr [rbp - 0x50]
010cc0b0 cmp        r9d, 0x6864736d
010cc0b7 jne        0x1410cc281
010cc0bd sub        edx, r10d
010cc0c0 lea        eax, [r8 - 1]
010cc0c4 cmp        eax, 0x16
010cc0c7 ja         0x1410cc209
010cc0cd lea        r9, [rip - 0x10cc0d4]
010cc0d4 mov        ecx, dword ptr [r9 + rax*4 + 0x10cc3a4]
010cc0dc add        rcx, r9
010cc0df jmp        rcx
010cc0e1 test       dword ptr [rsp + 0x30], 0x4000
010cc0e9 jne        0x1410cc209
010cc0ef mov        rdx, r12
010cc0f2 mov        rcx, r14
010cc0f5 call       0x1410c6f70
010cc0fa jmp        0x1410cc1eb
010cc0ff test       dword ptr [rsp + 0x30], 0x2000
010cc107 jne        0x1410cc209
010cc10d mov        rdx, r12
010cc110 mov        rcx, r14
010cc113 call       0x1410c7850
010cc118 jmp        0x1410cc1eb
010cc11d mov        r9d, dword ptr [rsp + 0x30]
010cc122 cmp        r8d, 1
010cc126 mov        rdx, r12
010cc129 mov        rcx, r14
010cc12c sete       r8b
010cc130 call       0x1410c8290
010cc135 jmp        0x1410cc1eb
010cc13a mov        eax, dword ptr [rsp + 0x30]
010cc13e bt         eax, 0xa
010cc142 jb         0x1410cc209
010cc148 cmp        r8d, 0xe
010cc14c mov        rdx, r12
010cc14f mov        r8d, eax
010cc152 mov        rcx, r14
010cc155 setne      r9b
010cc159 call       0x1410c8a00
010cc15e jmp        0x1410cc1eb
010cc163 test       dword ptr [rsp + 0x30], 0x1000
010cc16b jne        0x1410cc209
010cc171 mov        rdx, r12
010cc174 mov        rcx, r14
010cc177 call       0x1410ca1f0
010cc17c jmp        0x1410cc1eb
010cc17e mov        rdx, r12
010cc181 mov        rcx, r14
010cc184 call       0x1410c9900
010cc189 jmp        0x1410cc1eb
010cc18b mov        rdx, r12
010cc18e mov        rcx, r14
010cc191 call       0x1410c9da0
010cc196 jmp        0x1410cc1eb
010cc198 test       dword ptr [rsp + 0x30], 0x8000
010cc1a0 jne        0x1410cc209
010cc1a2 mov        rdx, r12
010cc1a5 mov        rcx, r14
010cc1a8 call       0x1410cab80
010cc1ad jmp        0x1410cc1eb
010cc1af test       dword ptr [rsp + 0x30], 0x10000
010cc1b7 jne        0x1410cc209
010cc1b9 mov        rdx, r12
010cc1bc mov        rcx, r14
010cc1bf call       0x1410cb420
010cc1c4 jmp        0x1410cc1eb
010cc1c6 test       dword ptr [rsp + 0x30], 0x20000
010cc1ce jne        0x1410cc209
010cc1d0 mov        rdx, r12
010cc1d3 mov        rcx, r14
010cc1d6 call       0x1410cafe0
010cc1db jmp        0x1410cc1eb
010cc1dd mov        r9d, edx
010cc1e0 mov        rcx, r14
010cc1e3 mov        rdx, r12
010cc1e6 call       0x1410c6eb0
010cc1eb xor        r13d, r13d
010cc1ee mov        edi, eax
010cc1f0 cmp        eax, 0x2349
010cc1f5 je         0x1410cc289
010cc1fb test       eax, eax
010cc1fd jne        0x1410cc289
010cc203 mov        r8d, dword ptr [rbp - 0x44]
010cc207 jmp        0x1410cc244
010cc209 mov        rcx, qword ptr [r14 + 0x1e00178]
010cc210 movsxd     rdx, edx
010cc213 add        rdx, qword ptr [r14 + 0x1e00170]
010cc21a mov        qword ptr [r14 + 0x1e00170], rdx
010cc221 cmp        rdx, rcx
010cc224 jb         0x1410cc232
010cc226 add        rcx, qword ptr [r14 + 0x1e00180]
010cc22d cmp        rdx, rcx
010cc230 jb         0x1410cc23e
010cc232 xor        r13d, r13d
010cc235 mov        qword ptr [r14 + 0x1e00180], r13
010cc23c jmp        0x1410cc241
010cc23e xor        r13d, r13d
010cc241 mov        edi, r13d
010cc244 cmp        r8d, 0x18
010cc248 jae        0x1410cc268
010cc24a lea        rcx, [rbp - 0x60]
010cc24e call       qword ptr [rip + 0x81e934]
010cc254 mov        eax, dword ptr [rbp - 0x44]
010cc257 mov        rcx, qword ptr [rbp - 0x60]
010cc25b sub        rcx, qword ptr [rsp + 0x40]
010cc260 mov        qword ptr [r14 + rax*8 + 0x1e001b0], rcx
010cc268 mov        r15d, dword ptr [rsp + 0x48]
010cc26d inc        r15d
010cc270 mov        dword ptr [rsp + 0x48], r15d
010cc275 cmp        r15d, dword ptr [rbx + 0x30]
010cc279 jb         0x1410cbf20
010cc27f jmp        0x1410cc289
010cc281 mov        edi, 0xffffff30
010cc286 xor        r13d, r13d
010cc289 mov        r15, qword ptr [rsp + 0x38]
010cc28e mov        rcx, qword ptr [r14 + 0x1e00188]
010cc295 test       rcx, rcx
010cc298 je         0x1410cc2b8
010cc29a mov        rax, qword ptr [rcx]
010cc29d test       rax, rax
010cc2a0 je         0x1410cc2b8
010cc2a2 mov        r8, qword ptr [r14 + 0x1e00198]
010cc2a9 mov        edx, 0x6470726d
010cc2ae mov        r9, r8
010cc2b1 mov        qword ptr [rsp + 0x20], r13
010cc2b6 call       rax
010cc2b8 lea        rcx, [rsp + 0x40]
010cc2bd call       qword ptr [rip + 0x81e8c5]
010cc2c3 mov        rax, qword ptr [rsp + 0x40]
010cc2c8 mov        r8, r15
010cc2cb sub        rax, qword ptr [r14 + 0x1e001b0]
010cc2d2 mov        edx, edi
010cc2d4 mov        qword ptr [r14 + 0x1e001b0], rax
010cc2db mov        rcx, r12
010cc2de mov        rax, qword ptr [r12]
010cc2e2 call       qword ptr [rax + 8]
010cc2e5 cmp        byte ptr [r14 + 0x41], 0
010cc2ea je         0x1410cc2fd
010cc2ec lea        rcx, [r14 + 0x1e00128]
010cc2f3 xor        r8d, r8d
010cc2f6 xor        edx, edx
010cc2f8 call       0x140bfc0d0
010cc2fd cmp        dword ptr [rsp + 0x50], 0x62756666
010cc305 jne        0x1410cc361
010cc307 cmp        byte ptr [rsp + 0x55], 0
010cc30c mov        byte ptr [rsp + 0x54], 1
010cc311 jne        0x1410cc31d
010cc313 lea        rcx, [rsp + 0x50]
010cc318 call       0x140ba0000
010cc31d mov        rcx, qword ptr [rsp + 0x58]
010cc322 call       0x140bd5150
010cc327 mov        rcx, qword ptr [rsp + 0x60]
010cc32c test       rcx, rcx
010cc32f je         0x1410cc336
010cc331 call       0x140bd7440
010cc336 mov        rcx, qword ptr [rbp - 0x80]
010cc33a test       rcx, rcx
010cc33d je         0x1410cc345
010cc33f call       qword ptr [rip + 0x820023]
010cc345 xorps      xmm0, xmm0
010cc348 xor        eax, eax
010cc34a movups     xmmword ptr [rsp + 0x50], xmm0
010cc34f mov        qword ptr [rbp - 0x70], rax
010cc353 movups     xmmword ptr [rsp + 0x60], xmm0
010cc358 movups     xmmword ptr [rsp + 0x70], xmm0
010cc35d movups     xmmword ptr [rbp - 0x80], xmm0
010cc361 mov        rcx, r14
010cc364 call       0x141086700
010cc369 mov        eax, edi
010cc36b mov        r14, qword ptr [rsp + 0x128]
010cc373 mov        r13, qword ptr [rsp + 0x160]
010cc37b mov        r15, qword ptr [rsp + 0x120]
; range 0x10cc383..0x10cc400 (exclusive)
010cc383 mov        rcx, qword ptr [rbp + 0x10]
010cc387 xor        rcx, rsp
010cc38a call       0x14179b8e0
010cc38f add        rsp, 0x130
010cc396 pop        r12
010cc398 pop        rdi
010cc399 pop        rsi
010cc39a pop        rbx
010cc39b pop        rbp
010cc39c ret        
010cc39d mov        eax, 0xffffff94
010cc3a2 jmp        0x1410cc383
010cc3a4 sbb        eax, 0x3a010cc1
010cc3a9 ror        dword ptr [rcx + rax], 0xdd
010cc3ad ror        dword ptr [rcx + rax], 0xdd
010cc3b1 ror        dword ptr [rcx + rax], 9
010cc3b5 ret        0x10c
010cc3b8 or         edx, eax
010cc3ba or         al, 1
010cc3bc or         edx, eax
010cc3be or         al, 1
010cc3c0 or         edx, eax
010cc3c2 or         al, 1
010cc3c4 loope      0x1410cc386
010cc3c6 or         al, 1
010cc3c8 ffree      st(1)
010cc3ca or         al, 1
010cc3cc inc        eax
010cc3ce or         al, 1
010cc3d0 mov        eax, ecx
010cc3d2 or         al, 1
010cc3d4 sbb        eax, 0x3a010cc1
010cc3d9 ror        dword ptr [rcx + rax], 0x7e
010cc3dd ror        dword ptr [rcx + rax], 0xdd
010cc3e1 ror        dword ptr [rcx + rax], 9
010cc3e5 ret        0x10c
010cc3e8 cwde       
010cc3e9 ror        dword ptr [rcx + rax], 0xdd
010cc3ed ror        dword ptr [rcx + rax], 0x63
010cc3f1 ror        dword ptr [rcx + rax], 0xaf
010cc3f5 ror        dword ptr [rcx + rax], 0xdd
010cc3f9 ror        dword ptr [rcx + rax], 0xc6
