; Original iTunes.exe machine code; base=0x140000000; RVA=0x1075000; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1075000..0x107557a (exclusive)
01075000 mov        qword ptr [rsp + 0x18], rbx
01075005 mov        qword ptr [rsp + 0x20], rsi
0107500a push       rbp
0107500b push       rdi
0107500c push       r12
0107500e push       r14
01075010 push       r15
01075012 lea        rbp, [rsp - 0x20]
01075017 sub        rsp, 0x120
0107501e mov        rax, qword ptr [rip + 0xf6001b]
01075025 xor        rax, rsp
01075028 mov        qword ptr [rbp + 0x10], rax
0107502c mov        r12, rdx
0107502f mov        rdi, rcx
01075032 xor        r15d, r15d
01075035 mov        byte ptr [rdx], r15b
01075038 mov        rbx, qword ptr [rip + 0x105a3c1]
0107503f test       rbx, rbx
01075042 je         0x14107504f
01075044 lock inc   dword ptr [rbx + 8]
01075048 mov        rbx, qword ptr [rip + 0x105a3b1]
0107504f mov        rcx, qword ptr [rip + 0x105a3a2]
01075056 mov        qword ptr [rsp + 0x20], rcx
0107505b mov        qword ptr [rsp + 0x28], rbx
01075060 test       rcx, rcx
01075063 jne        0x14107509d
01075065 mov        esi, 0xffffffff
0107506a test       rbx, rbx
0107506d je         0x141075098
0107506f mov        eax, esi
01075071 lock xadd  dword ptr [rbx + 8], eax
01075076 cmp        eax, 1
01075079 jne        0x141075098
0107507b mov        rax, qword ptr [rbx]
0107507e mov        rcx, rbx
01075081 call       qword ptr [rax]
01075083 mov        eax, esi
01075085 lock xadd  dword ptr [rbx + 0xc], eax
0107508a cmp        eax, 1
0107508d jne        0x141075098
0107508f mov        rax, qword ptr [rbx]
01075092 mov        rcx, rbx
01075095 call       qword ptr [rax + 8]
01075098 xor        r14d, r14d
0107509b jmp        0x1410750dc
0107509d mov        rax, qword ptr [rcx]
010750a0 call       qword ptr [rax + 0xe0]
010750a6 mov        r14, rax
010750a9 mov        esi, 0xffffffff
010750ae test       rbx, rbx
010750b1 je         0x1410750dc
010750b3 mov        eax, esi
010750b5 lock xadd  dword ptr [rbx + 8], eax
010750ba cmp        eax, 1
010750bd jne        0x1410750dc
010750bf mov        rax, qword ptr [rbx]
010750c2 mov        rcx, rbx
010750c5 call       qword ptr [rax]
010750c7 mov        eax, esi
010750c9 lock xadd  dword ptr [rbx + 0xc], eax
010750ce cmp        eax, 1
010750d1 jne        0x1410750dc
010750d3 mov        rax, qword ptr [rbx]
010750d6 mov        rcx, rbx
010750d9 call       qword ptr [rax + 8]
010750dc mov        rbx, qword ptr [rip + 0x105a32d]
010750e3 test       rbx, rbx
010750e6 je         0x1410750f3
010750e8 lock inc   dword ptr [rbx + 8]
010750ec mov        rbx, qword ptr [rip + 0x105a31d]
010750f3 mov        rcx, qword ptr [rip + 0x105a30e]
010750fa mov        qword ptr [rsp + 0x20], rcx
010750ff mov        qword ptr [rsp + 0x28], rbx
01075104 test       rcx, rcx
01075107 je         0x141075115
01075109 mov        rax, qword ptr [rcx]
0107510c call       qword ptr [rax + 0xc8]
01075112 mov        r15, rax
01075115 test       rbx, rbx
01075118 je         0x141075144
0107511a mov        ecx, esi
0107511c lock xadd  dword ptr [rbx + 8], ecx
01075121 cmp        ecx, 1
01075124 jne        0x141075144
01075126 mov        rcx, qword ptr [rbx]
01075129 mov        rdx, qword ptr [rcx]
0107512c mov        rcx, rbx
0107512f call       rdx
01075131 lock xadd  dword ptr [rbx + 0xc], esi
01075136 cmp        esi, 1
01075139 jne        0x141075144
0107513b mov        rax, qword ptr [rbx]
0107513e mov        rcx, rbx
01075141 call       qword ptr [rax + 8]
01075144 mov        rcx, qword ptr [rdi + 0x1e00270]
0107514b call       0x140ed2bb0
01075150 xorps      xmm0, xmm0
01075153 movups     xmmword ptr [rbp - 0x50], xmm0
01075157 movups     xmmword ptr [rbp - 0x40], xmm0
0107515b movups     xmmword ptr [rbp - 0x30], xmm0
0107515f movups     xmmword ptr [rbp - 0x20], xmm0
01075163 movups     xmmword ptr [rbp - 0x10], xmm0
01075167 movups     xmmword ptr [rbp], xmm0
0107516b mov        dword ptr [rbp - 0x50], 0x6864736d
01075172 mov        dword ptr [rbp - 0x4c], 0x60
01075179 mov        dword ptr [rbp - 0x44], 0x17
01075180 mov        rsi, qword ptr [rdi + 0x120]
01075187 mov        qword ptr [rsp + 0x30], 0
01075190 cmp        byte ptr [rsi + 5], 0
01075194 je         0x1410751a1
01075196 mov        rcx, qword ptr [rsi + 0x40]
0107519a mov        qword ptr [rsp + 0x30], rcx
0107519f jmp        0x1410751be
010751a1 lea        rdx, [rsp + 0x30]
010751a6 mov        rcx, qword ptr [rsi + 8]
010751aa call       0x140bd6640
010751af mov        ebx, eax
010751b1 test       eax, eax
010751b3 jne        0x141075528
010751b9 mov        rcx, qword ptr [rsp + 0x30]
010751be mov        rax, qword ptr [rsi + 0x20]
010751c2 cmp        byte ptr [rsi + 5], 0
010751c6 je         0x1410751d9
010751c8 sub        rax, qword ptr [rsi + 0x38]
010751cc dec        rax
010751cf add        rax, rcx
010751d2 mov        qword ptr [rsp + 0x30], rax
010751d7 jmp        0x1410751e5
010751d9 sub        rax, qword ptr [rsi + 0x30]
010751dd add        rcx, rax
010751e0 mov        qword ptr [rsp + 0x30], rcx
010751e5 mov        qword ptr [rsp + 0x20], 0x60
010751ee lea        r8, [rbp - 0x50]
010751f2 lea        rdx, [rsp + 0x20]
010751f7 mov        rcx, qword ptr [rdi + 0x120]
010751fe call       0x140ba04c0
01075203 mov        ebx, eax
01075205 test       eax, eax
01075207 jne        0x141075528
0107520d xorps      xmm0, xmm0
01075210 xor        eax, eax
01075212 movups     xmmword ptr [rsp + 0x58], xmm0
01075217 movups     xmmword ptr [rsp + 0x68], xmm0
0107521c movups     xmmword ptr [rsp + 0x78], xmm0
01075221 movups     xmmword ptr [rbp - 0x78], xmm0
01075225 movups     xmmword ptr [rbp - 0x68], xmm0
01075229 mov        qword ptr [rbp - 0x58], rax
0107522d mov        dword ptr [rsp + 0x50], 0x68737473
01075235 mov        dword ptr [rsp + 0x54], 0x60
0107523d mov        rsi, qword ptr [rdi + 0x120]
01075244 mov        qword ptr [rsp + 0x38], rax
01075249 cmp        byte ptr [rsi + 5], al
0107524c je         0x141075259
0107524e mov        rcx, qword ptr [rsi + 0x40]
01075252 mov        qword ptr [rsp + 0x38], rcx
01075257 jmp        0x141075276
01075259 lea        rdx, [rsp + 0x38]
0107525e mov        rcx, qword ptr [rsi + 8]
01075262 call       0x140bd6640
01075267 mov        ebx, eax
01075269 test       eax, eax
0107526b jne        0x141075528
01075271 mov        rcx, qword ptr [rsp + 0x38]
01075276 mov        rax, qword ptr [rsi + 0x20]
0107527a cmp        byte ptr [rsi + 5], 0
0107527e je         0x141075289
01075280 sub        rax, qword ptr [rsi + 0x38]
01075284 dec        rax
01075287 jmp        0x14107528d
01075289 sub        rax, qword ptr [rsi + 0x30]
0107528d add        rax, rcx
01075290 mov        qword ptr [rsp + 0x38], rax
01075295 mov        qword ptr [rsp + 0x20], 0x60
0107529e lea        r8, [rsp + 0x50]
010752a3 lea        rdx, [rsp + 0x20]
010752a8 mov        rcx, qword ptr [rdi + 0x120]
010752af call       0x140ba04c0
010752b4 mov        ebx, eax
010752b6 test       eax, eax
010752b8 jne        0x141075528
010752be test       r14, r14
010752c1 je         0x141075317
010752c3 lea        rbx, [rdi + 0xa00128]
010752ca mov        qword ptr [rsp + 0x20], rbx
010752cf lea        r9, [rsp + 0x20]
010752d4 mov        r8d, 0x385
010752da mov        rdx, r14
010752dd mov        rcx, rdi
010752e0 call       0x14106b140
010752e5 mov        eax, dword ptr [rsp + 0x20]
010752e9 sub        eax, edi
010752eb sub        eax, 0xa00128
010752f0 mov        qword ptr [rsp + 0x20], rax
010752f5 mov        r8, rbx
010752f8 lea        rdx, [rsp + 0x20]
010752fd mov        rcx, qword ptr [rdi + 0x120]
01075304 call       0x140ba04c0
01075309 mov        ebx, eax
0107530b test       eax, eax
0107530d jne        0x141075528
01075313 inc        dword ptr [rsp + 0x5c]
01075317 test       r15, r15
0107531a je         0x141075370
0107531c lea        rbx, [rdi + 0xa00128]
01075323 mov        qword ptr [rsp + 0x20], rbx
01075328 lea        r9, [rsp + 0x20]
0107532d mov        r8d, 0x384
01075333 mov        rdx, r15
01075336 mov        rcx, rdi
01075339 call       0x14106b140
0107533e mov        eax, dword ptr [rsp + 0x20]
01075342 sub        eax, edi
01075344 sub        eax, 0xa00128
01075349 mov        qword ptr [rsp + 0x20], rax
0107534e mov        r8, rbx
01075351 lea        rdx, [rsp + 0x20]
01075356 mov        rcx, qword ptr [rdi + 0x120]
0107535d call       0x140ba04c0
01075362 mov        ebx, eax
01075364 test       eax, eax
01075366 jne        0x141075528
0107536c inc        dword ptr [rsp + 0x5c]
01075370 lea        rdx, [rsp + 0x40]
01075375 mov        rcx, qword ptr [rdi + 0x120]
0107537c call       0x140b9ff80
01075381 mov        ebx, eax
01075383 test       eax, eax
01075385 jne        0x141075528
0107538b mov        r8d, dword ptr [rsp + 0x40]
01075390 mov        r10, qword ptr [rsp + 0x30]
01075395 sub        r8d, r10d
01075398 mov        dword ptr [rbp - 0x48], r8d
0107539c cmp        byte ptr [rdi + 0x52], al
0107539f jne        0x14107542d
010753a5 mov        ecx, dword ptr [rbp - 0x50]
010753a8 mov        edx, ecx
010753aa and        edx, 0xff0000
010753b0 mov        eax, ecx
010753b2 shr        eax, 0x10
010753b5 or         edx, eax
010753b7 shr        edx, 8
010753ba mov        eax, ecx
010753bc and        eax, 0xff00
010753c1 shl        ecx, 0x10
010753c4 or         eax, ecx
010753c6 shl        eax, 8
010753c9 or         edx, eax
010753cb mov        dword ptr [rbp - 0x50], edx
010753ce mov        ecx, dword ptr [rbp - 0x4c]
010753d1 mov        edx, ecx
010753d3 and        edx, 0xff0000
010753d9 mov        eax, ecx
010753db shr        eax, 0x10
010753de or         edx, eax
010753e0 shr        edx, 8
010753e3 mov        eax, ecx
010753e5 and        eax, 0xff00
010753ea shl        ecx, 0x10
010753ed or         eax, ecx
010753ef shl        eax, 8
010753f2 or         edx, eax
010753f4 mov        dword ptr [rbp - 0x4c], edx
010753f7 bswap      r8d
010753fa mov        dword ptr [rbp - 0x48], r8d
010753fe mov        ecx, dword ptr [rbp - 0x44]
01075401 mov        r8d, ecx
01075404 and        r8d, 0xff0000
0107540b mov        eax, ecx
0107540d shr        eax, 0x10
01075410 or         r8d, eax
01075413 shr        r8d, 8
01075417 mov        eax, ecx
01075419 and        eax, 0xff00
0107541e shl        ecx, 0x10
01075421 or         eax, ecx
01075423 shl        eax, 8
01075426 or         r8d, eax
01075429 mov        dword ptr [rbp - 0x44], r8d
0107542d mov        r9d, 0x60
01075433 lea        r8, [rbp - 0x50]
01075437 mov        rdx, r10
0107543a mov        rcx, rdi
0107543d call       0x14106aba0
01075442 mov        ebx, eax
01075444 test       eax, eax
01075446 jne        0x141075528
0107544c cmp        byte ptr [rdi + 0x52], al
0107544f jne        0x141075505
01075455 mov        ecx, dword ptr [rsp + 0x50]
01075459 mov        edx, ecx
0107545b and        edx, 0xff0000
01075461 mov        eax, ecx
01075463 shr        eax, 0x10
01075466 or         edx, eax
01075468 shr        edx, 8
0107546b mov        eax, ecx
0107546d shl        eax, 0x10
01075470 and        ecx, 0xff00
01075476 or         eax, ecx
01075478 shl        eax, 8
0107547b or         edx, eax
0107547d mov        dword ptr [rsp + 0x50], edx
01075481 mov        ecx, dword ptr [rsp + 0x54]
01075485 mov        edx, ecx
01075487 and        edx, 0xff0000
0107548d mov        eax, ecx
0107548f shr        eax, 0x10
01075492 or         edx, eax
01075494 shr        edx, 8
01075497 mov        eax, ecx
01075499 shl        eax, 0x10
0107549c and        ecx, 0xff00
010754a2 or         eax, ecx
010754a4 shl        eax, 8
010754a7 or         edx, eax
010754a9 mov        dword ptr [rsp + 0x54], edx
010754ad mov        ecx, dword ptr [rsp + 0x58]
010754b1 mov        edx, ecx
010754b3 and        edx, 0xff0000
010754b9 mov        eax, ecx
010754bb shr        eax, 0x10
010754be or         edx, eax
010754c0 shr        edx, 8
010754c3 mov        eax, ecx
010754c5 shl        eax, 0x10
010754c8 and        ecx, 0xff00
010754ce or         eax, ecx
010754d0 shl        eax, 8
010754d3 or         edx, eax
010754d5 mov        dword ptr [rsp + 0x58], edx
010754d9 mov        ecx, dword ptr [rsp + 0x5c]
010754dd mov        edx, ecx
010754df and        edx, 0xff0000
010754e5 mov        eax, ecx
010754e7 shr        eax, 0x10
010754ea or         edx, eax
010754ec shr        edx, 8
010754ef mov        eax, ecx
010754f1 shl        eax, 0x10
010754f4 and        ecx, 0xff00
010754fa or         eax, ecx
010754fc shl        eax, 8
010754ff or         edx, eax
01075501 mov        dword ptr [rsp + 0x5c], edx
01075505 mov        r9d, 0x60
0107550b lea        r8, [rsp + 0x50]
01075510 mov        rdx, qword ptr [rsp + 0x38]
01075515 mov        rcx, rdi
01075518 call       0x14106aba0
0107551d mov        ebx, eax
0107551f test       eax, eax
01075521 jne        0x141075528
01075523 mov        byte ptr [r12], 1
01075528 mov        rcx, qword ptr [rdi + 0x1e00270]
0107552f call       0x140ed2fe0
01075534 test       r14, r14
01075537 je         0x141075542
01075539 mov        rcx, r14
0107553c call       qword ptr [rip + 0x8738de]
01075542 test       r15, r15
01075545 je         0x141075550
01075547 mov        rcx, r15
0107554a call       qword ptr [rip + 0x8738d0]
01075550 mov        eax, ebx
01075552 mov        rcx, qword ptr [rbp + 0x10]
01075556 xor        rcx, rsp
01075559 call       0x14179b8e0
0107555e lea        r11, [rsp + 0x120]
01075566 mov        rbx, qword ptr [r11 + 0x40]
0107556a mov        rsi, qword ptr [r11 + 0x48]
0107556e mov        rsp, r11
01075571 pop        r15
01075573 pop        r14
01075575 pop        r12
01075577 pop        rdi
01075578 pop        rbp
01075579 ret        
