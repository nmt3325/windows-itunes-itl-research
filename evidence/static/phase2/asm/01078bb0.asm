; iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0x1078bb0
; unwind group range 0x1078bb0..0x1079805 (exclusive)
01078bb0 48895c2410                       mov        qword ptr [rsp + 0x10], rbx
01078bb5 4889742418                       mov        qword ptr [rsp + 0x18], rsi
01078bba 48897c2420                       mov        qword ptr [rsp + 0x20], rdi
01078bbf 55                               push       rbp
01078bc0 4154                             push       r12
01078bc2 4155                             push       r13
01078bc4 4156                             push       r14
01078bc6 4157                             push       r15
01078bc8 488dac2440ffffff                 lea        rbp, [rsp - 0xc0]
01078bd0 4881ecc0010000                   sub        rsp, 0x1c0
01078bd7 488b0562c4f500                   mov        rax, qword ptr [rip + 0xf5c462]
01078bde 4833c4                           xor        rax, rsp
01078be1 488985b0000000                   mov        qword ptr [rbp + 0xb0], rax
01078be8 4c8bf1                           mov        r14, rcx
01078beb 4c8ba97002e001                   mov        r13, qword ptr [rcx + 0x1e00270]
01078bf2 4c896c2458                       mov        qword ptr [rsp + 0x58], r13
01078bf7 41b808000000                     mov        r8d, 8
01078bfd 488d5540                         lea        rdx, [rbp + 0x40]
01078c01 e89ae4ffff                       call       0x1410770a0
01078c06 8bf0                             mov        esi, eax
01078c08 85c0                             test       eax, eax
01078c0a 0f85c30b0000                     jne        0x1410797d3
01078c10 448b5544                         mov        r10d, dword ptr [rbp + 0x44]
01078c14 418bda                           mov        ebx, r10d
01078c17 4d8d7e52                         lea        r15, [r14 + 0x52]
01078c1b 413807                           cmp        byte ptr [r15], al
01078c1e 7502                             jne        0x141078c22
01078c20 0fcb                             bswap      ebx
01078c22 488d4d48                         lea        rcx, [rbp + 0x48]
01078c26 bf64000000                       mov        edi, 0x64
01078c2b 3bdf                             cmp        ebx, edi
01078c2d 0f42fb                           cmovb      edi, ebx
01078c30 83ff08                           cmp        edi, 8
01078c33 7635                             jbe        0x141078c6a
01078c35 448d67f8                         lea        r12d, [rdi - 8]
01078c39 4981fc0000a000                   cmp        r12, 0xa00000
01078c40 0f8794010000                     ja         0x141078dda
01078c46 458bc4                           mov        r8d, r12d
01078c49 488d5548                         lea        rdx, [rbp + 0x48]
01078c4d 498bce                           mov        rcx, r14
01078c50 e84be4ffff                       call       0x1410770a0
01078c55 8bf0                             mov        esi, eax
01078c57 85c0                             test       eax, eax
01078c59 0f85740b0000                     jne        0x1410797d3
01078c5f 488d4d48                         lea        rcx, [rbp + 0x48]
01078c63 4903cc                           add        rcx, r12
01078c66 448b5544                         mov        r10d, dword ptr [rbp + 0x44]
01078c6a 83ff64                           cmp        edi, 0x64
01078c6d 7319                             jae        0x141078c88
01078c6f 4885c9                           test       rcx, rcx
01078c72 7414                             je         0x141078c88
01078c74 41b864000000                     mov        r8d, 0x64
01078c7a 442bc7                           sub        r8d, edi
01078c7d 33d2                             xor        edx, edx
01078c7f e81c407200                       call       0x14179cca0
01078c84 448b5544                         mov        r10d, dword ptr [rbp + 0x44]
01078c88 3bdf                             cmp        ebx, edi
01078c8a 7616                             jbe        0x141078ca2
01078c8c 2bdf                             sub        ebx, edi
01078c8e 8bd3                             mov        edx, ebx
01078c90 498bce                           mov        rcx, r14
01078c93 e88818ffff                       call       0x14106a520
01078c98 8bf0                             mov        esi, eax
01078c9a 85c0                             test       eax, eax
01078c9c 0f85310b0000                     jne        0x1410797d3
01078ca2 33c0                             xor        eax, eax
01078ca4 8bf0                             mov        esi, eax
01078ca6 48bb0000000000ff0000             movabs     rbx, 0xff0000000000
01078cb0 48bf00000000ff000000             movabs     rdi, 0xff00000000
01078cba 49bb000000000000ff00             movabs     r11, 0xff000000000000
01078cc4 41bc000000ff                     mov        r12d, 0xff000000
01078cca 413807                           cmp        byte ptr [r15], al
01078ccd 0f85f6000000                     jne        0x141078dc9
01078cd3 8b4d40                           mov        ecx, dword ptr [rbp + 0x40]
01078cd6 448bc9                           mov        r9d, ecx
01078cd9 4181e10000ff00                   and        r9d, 0xff0000
01078ce0 8bc1                             mov        eax, ecx
01078ce2 c1e810                           shr        eax, 0x10
01078ce5 440bc8                           or         r9d, eax
01078ce8 41c1e908                         shr        r9d, 8
01078cec 8bc1                             mov        eax, ecx
01078cee 2500ff0000                       and        eax, 0xff00
01078cf3 c1e110                           shl        ecx, 0x10
01078cf6 0bc1                             or         eax, ecx
01078cf8 c1e008                           shl        eax, 8
01078cfb 440bc8                           or         r9d, eax
01078cfe 44894d40                         mov        dword ptr [rbp + 0x40], r9d
01078d02 418bca                           mov        ecx, r10d
01078d05 81e10000ff00                     and        ecx, 0xff0000
01078d0b 418bc2                           mov        eax, r10d
01078d0e c1e810                           shr        eax, 0x10
01078d11 0bc8                             or         ecx, eax
01078d13 c1e908                           shr        ecx, 8
01078d16 418bc2                           mov        eax, r10d
01078d19 c1e010                           shl        eax, 0x10
01078d1c 4181e200ff0000                   and        r10d, 0xff00
01078d23 410bc2                           or         eax, r10d
01078d26 c1e008                           shl        eax, 8
01078d29 0bc8                             or         ecx, eax
01078d2b 894d44                           mov        dword ptr [rbp + 0x44], ecx
01078d2e 8b4d48                           mov        ecx, dword ptr [rbp + 0x48]
01078d31 448bd1                           mov        r10d, ecx
01078d34 4181e20000ff00                   and        r10d, 0xff0000
01078d3b 8bc1                             mov        eax, ecx
01078d3d c1e810                           shr        eax, 0x10
01078d40 440bd0                           or         r10d, eax
01078d43 41c1ea08                         shr        r10d, 8
01078d47 8bc1                             mov        eax, ecx
01078d49 2500ff0000                       and        eax, 0xff00
01078d4e c1e110                           shl        ecx, 0x10
01078d51 0bc1                             or         eax, ecx
01078d53 c1e008                           shl        eax, 8
01078d56 440bd0                           or         r10d, eax
01078d59 44895548                         mov        dword ptr [rbp + 0x48], r10d
01078d5d 488b554c                         mov        rdx, qword ptr [rbp + 0x4c]
01078d61 4c8bc2                           mov        r8, rdx
01078d64 4d23c3                           and        r8, r11
01078d67 488bc2                           mov        rax, rdx
01078d6a 48c1e810                         shr        rax, 0x10
01078d6e 4c0bc0                           or         r8, rax
01078d71 49c1e810                         shr        r8, 0x10
01078d75 488bc2                           mov        rax, rdx
01078d78 4823c3                           and        rax, rbx
01078d7b 4c0bc0                           or         r8, rax
01078d7e 49c1e810                         shr        r8, 0x10
01078d82 488bc2                           mov        rax, rdx
01078d85 4823c7                           and        rax, rdi
01078d88 4c0bc0                           or         r8, rax
01078d8b 49c1e808                         shr        r8, 8
01078d8f 488bca                           mov        rcx, rdx
01078d92 48c1e110                         shl        rcx, 0x10
01078d96 8bc2                             mov        eax, edx
01078d98 2500ff0000                       and        eax, 0xff00
01078d9d 480bc8                           or         rcx, rax
01078da0 48c1e110                         shl        rcx, 0x10
01078da4 8bc2                             mov        eax, edx
01078da6 250000ff00                       and        eax, 0xff0000
01078dab 480bc8                           or         rcx, rax
01078dae 48c1e110                         shl        rcx, 0x10
01078db2 8bc2                             mov        eax, edx
01078db4 4923c4                           and        rax, r12
01078db7 480bc8                           or         rcx, rax
01078dba 48c1e108                         shl        rcx, 8
01078dbe 4c0bc1                           or         r8, rcx
01078dc1 4c89454c                         mov        qword ptr [rbp + 0x4c], r8
01078dc5 33c0                             xor        eax, eax
01078dc7 eb08                             jmp        0x141078dd1
01078dc9 448b5548                         mov        r10d, dword ptr [rbp + 0x48]
01078dcd 448b4d40                         mov        r9d, dword ptr [rbp + 0x40]
01078dd1 4181f96d6c6968                   cmp        r9d, 0x68696c6d
01078dd8 740a                             je         0x141078de4
01078dda be30ffffff                       mov        esi, 0xffffff30
01078ddf e9ef090000                       jmp        0x1410797d3
01078de4 8944244c                         mov        dword ptr [rsp + 0x4c], eax
01078de8 4585d2                           test       r10d, r10d
01078deb 0f8442090000                     je         0x141079733
01078df1 4d8be7                           mov        r12, r15
01078df4 4c897c2450                       mov        qword ptr [rsp + 0x50], r15
01078df9 4889442460                       mov        qword ptr [rsp + 0x60], rax
01078dfe 89442448                         mov        dword ptr [rsp + 0x48], eax
01078e02 488bd8                           mov        rbx, rax
01078e05 4889442468                       mov        qword ptr [rsp + 0x68], rax
01078e0a 41b808000000                     mov        r8d, 8
01078e10 488d55d0                         lea        rdx, [rbp - 0x30]
01078e14 498bce                           mov        rcx, r14
01078e17 e884e2ffff                       call       0x1410770a0
01078e1c 8bf0                             mov        esi, eax
01078e1e 85c0                             test       eax, eax
01078e20 0f8508090000                     jne        0x14107972e
01078e26 448b55d4                         mov        r10d, dword ptr [rbp - 0x2c]
01078e2a 418bfa                           mov        edi, r10d
01078e2d 418bca                           mov        ecx, r10d
01078e30 413807                           cmp        byte ptr [r15], al
01078e33 7522                             jne        0x141078e57
01078e35 81e70000ff00                     and        edi, 0xff0000
01078e3b 8bc1                             mov        eax, ecx
01078e3d c1e810                           shr        eax, 0x10
01078e40 0bf8                             or         edi, eax
01078e42 c1ef08                           shr        edi, 8
01078e45 8bc1                             mov        eax, ecx
01078e47 c1e010                           shl        eax, 0x10
01078e4a 81e100ff0000                     and        ecx, 0xff00
01078e50 0bc1                             or         eax, ecx
01078e52 c1e008                           shl        eax, 8
01078e55 0bf8                             or         edi, eax
01078e57 488d4dd8                         lea        rcx, [rbp - 0x28]
01078e5b 41bf64000000                     mov        r15d, 0x64
01078e61 413bff                           cmp        edi, r15d
01078e64 440f42ff                         cmovb      r15d, edi
01078e68 4183ff08                         cmp        r15d, 8
01078e6c 763a                             jbe        0x141078ea8
01078e6e 458d67f8                         lea        r12d, [r15 - 8]
01078e72 4981fc0000a000                   cmp        r12, 0xa00000
01078e79 0f87aa080000                     ja         0x141079729
01078e7f 458bc4                           mov        r8d, r12d
01078e82 488d55d8                         lea        rdx, [rbp - 0x28]
01078e86 498bce                           mov        rcx, r14
01078e89 e812e2ffff                       call       0x1410770a0
01078e8e 8bf0                             mov        esi, eax
01078e90 85c0                             test       eax, eax
01078e92 0f8596080000                     jne        0x14107972e
01078e98 488d4dd8                         lea        rcx, [rbp - 0x28]
01078e9c 4903cc                           add        rcx, r12
01078e9f 448b55d4                         mov        r10d, dword ptr [rbp - 0x2c]
01078ea3 4c8b642450                       mov        r12, qword ptr [rsp + 0x50]
01078ea8 4183ff64                         cmp        r15d, 0x64
01078eac 7319                             jae        0x141078ec7
01078eae 4885c9                           test       rcx, rcx
01078eb1 7414                             je         0x141078ec7
01078eb3 41b864000000                     mov        r8d, 0x64
01078eb9 452bc7                           sub        r8d, r15d
01078ebc 33d2                             xor        edx, edx
01078ebe e8dd3d7200                       call       0x14179cca0
01078ec3 448b55d4                         mov        r10d, dword ptr [rbp - 0x2c]
01078ec7 413bff                           cmp        edi, r15d
01078eca 7617                             jbe        0x141078ee3
01078ecc 412bff                           sub        edi, r15d
01078ecf 8bd7                             mov        edx, edi
01078ed1 498bce                           mov        rcx, r14
01078ed4 e84716ffff                       call       0x14106a520
01078ed9 8bf0                             mov        esi, eax
01078edb 85c0                             test       eax, eax
01078edd 0f854b080000                     jne        0x14107972e
01078ee3 33f6                             xor        esi, esi
01078ee5 4d8bfc                           mov        r15, r12
01078ee8 41383424                         cmp        byte ptr [r12], sil
01078eec 0f85e1020000                     jne        0x1410791d3
01078ef2 8b4dd0                           mov        ecx, dword ptr [rbp - 0x30]
01078ef5 448bc9                           mov        r9d, ecx
01078ef8 4181e10000ff00                   and        r9d, 0xff0000
01078eff 8bc1                             mov        eax, ecx
01078f01 c1e810                           shr        eax, 0x10
01078f04 440bc8                           or         r9d, eax
01078f07 41c1e908                         shr        r9d, 8
01078f0b 8bc1                             mov        eax, ecx
01078f0d c1e010                           shl        eax, 0x10
01078f10 81e100ff0000                     and        ecx, 0xff00
01078f16 0bc1                             or         eax, ecx
01078f18 c1e008                           shl        eax, 8
01078f1b 440bc8                           or         r9d, eax
01078f1e 44894dd0                         mov        dword ptr [rbp - 0x30], r9d
01078f22 418bca                           mov        ecx, r10d
01078f25 81e10000ff00                     and        ecx, 0xff0000
01078f2b 418bc2                           mov        eax, r10d
01078f2e c1e810                           shr        eax, 0x10
01078f31 0bc8                             or         ecx, eax
01078f33 c1e908                           shr        ecx, 8
01078f36 418bc2                           mov        eax, r10d
01078f39 c1e010                           shl        eax, 0x10
01078f3c 4181e200ff0000                   and        r10d, 0xff00
01078f43 410bc2                           or         eax, r10d
01078f46 c1e008                           shl        eax, 8
01078f49 0bc8                             or         ecx, eax
01078f4b 894dd4                           mov        dword ptr [rbp - 0x2c], ecx
01078f4e 8b4dd8                           mov        ecx, dword ptr [rbp - 0x28]
01078f51 8bd1                             mov        edx, ecx
01078f53 81e20000ff00                     and        edx, 0xff0000
01078f59 8bc1                             mov        eax, ecx
01078f5b c1e810                           shr        eax, 0x10
01078f5e 0bd0                             or         edx, eax
01078f60 c1ea08                           shr        edx, 8
01078f63 8bc1                             mov        eax, ecx
01078f65 c1e010                           shl        eax, 0x10
01078f68 81e100ff0000                     and        ecx, 0xff00
01078f6e 0bc1                             or         eax, ecx
01078f70 c1e008                           shl        eax, 8
01078f73 0bd0                             or         edx, eax
01078f75 8955d8                           mov        dword ptr [rbp - 0x28], edx
01078f78 8b4ddc                           mov        ecx, dword ptr [rbp - 0x24]
01078f7b 448bd1                           mov        r10d, ecx
01078f7e 4181e20000ff00                   and        r10d, 0xff0000
01078f85 8bc1                             mov        eax, ecx
01078f87 c1e810                           shr        eax, 0x10
01078f8a 440bd0                           or         r10d, eax
01078f8d 41c1ea08                         shr        r10d, 8
01078f91 8bc1                             mov        eax, ecx
01078f93 c1e010                           shl        eax, 0x10
01078f96 81e100ff0000                     and        ecx, 0xff00
01078f9c 0bc1                             or         eax, ecx
01078f9e c1e008                           shl        eax, 8
01078fa1 440bd0                           or         r10d, eax
01078fa4 448955dc                         mov        dword ptr [rbp - 0x24], r10d
01078fa8 8b4de0                           mov        ecx, dword ptr [rbp - 0x20]
01078fab 8bd1                             mov        edx, ecx
01078fad 81e20000ff00                     and        edx, 0xff0000
01078fb3 8bc1                             mov        eax, ecx
01078fb5 c1e810                           shr        eax, 0x10
01078fb8 0bd0                             or         edx, eax
01078fba c1ea08                           shr        edx, 8
01078fbd 8bc1                             mov        eax, ecx
01078fbf c1e010                           shl        eax, 0x10
01078fc2 81e100ff0000                     and        ecx, 0xff00
01078fc8 0bc1                             or         eax, ecx
01078fca c1e008                           shl        eax, 8
01078fcd 0bd0                             or         edx, eax
01078fcf 8955e0                           mov        dword ptr [rbp - 0x20], edx
01078fd2 488b55e4                         mov        rdx, qword ptr [rbp - 0x1c]
01078fd6 4c8bc2                           mov        r8, rdx
01078fd9 49bb000000000000ff00             movabs     r11, 0xff000000000000
01078fe3 4d23c3                           and        r8, r11
01078fe6 488bc2                           mov        rax, rdx
01078fe9 48c1e810                         shr        rax, 0x10
01078fed 4c0bc0                           or         r8, rax
01078ff0 49c1e810                         shr        r8, 0x10
01078ff4 488bc2                           mov        rax, rdx
01078ff7 48bf0000000000ff0000             movabs     rdi, 0xff0000000000
01079001 4823c7                           and        rax, rdi
01079004 4c0bc0                           or         r8, rax
01079007 49c1e810                         shr        r8, 0x10
0107900b 488bc2                           mov        rax, rdx
0107900e 49bf00000000ff000000             movabs     r15, 0xff00000000
01079018 4923c7                           and        rax, r15
0107901b 4c0bc0                           or         r8, rax
0107901e 49c1e808                         shr        r8, 8
01079022 488bca                           mov        rcx, rdx
01079025 48c1e110                         shl        rcx, 0x10
01079029 8bc2                             mov        eax, edx
0107902b 2500ff0000                       and        eax, 0xff00
01079030 480bc8                           or         rcx, rax
01079033 48c1e110                         shl        rcx, 0x10
01079037 8bc2                             mov        eax, edx
01079039 250000ff00                       and        eax, 0xff0000
0107903e 480bc8                           or         rcx, rax
01079041 48c1e110                         shl        rcx, 0x10
01079045 8bc2                             mov        eax, edx
01079047 ba000000ff                       mov        edx, 0xff000000
0107904c 4823c2                           and        rax, rdx
0107904f 480bc8                           or         rcx, rax
01079052 48c1e108                         shl        rcx, 8
01079056 4c0bc1                           or         r8, rcx
01079059 4c8945e4                         mov        qword ptr [rbp - 0x1c], r8
0107905d 488b55f0                         mov        rdx, qword ptr [rbp - 0x10]
01079061 4c8bc2                           mov        r8, rdx
01079064 4d23c3                           and        r8, r11
01079067 488bc2                           mov        rax, rdx
0107906a 48c1e810                         shr        rax, 0x10
0107906e 4c0bc0                           or         r8, rax
01079071 49c1e810                         shr        r8, 0x10
01079075 488bc2                           mov        rax, rdx
01079078 4823c7                           and        rax, rdi
0107907b 4c0bc0                           or         r8, rax
0107907e 49c1e810                         shr        r8, 0x10
01079082 488bc2                           mov        rax, rdx
01079085 4923c7                           and        rax, r15
01079088 4c0bc0                           or         r8, rax
0107908b 49c1e808                         shr        r8, 8
0107908f 488bca                           mov        rcx, rdx
01079092 48c1e110                         shl        rcx, 0x10
01079096 488bc2                           mov        rax, rdx
01079099 2500ff0000                       and        eax, 0xff00
0107909e 480bc8                           or         rcx, rax
010790a1 48c1e110                         shl        rcx, 0x10
010790a5 488bc2                           mov        rax, rdx
010790a8 250000ff00                       and        eax, 0xff0000
010790ad 480bc8                           or         rcx, rax
010790b0 48c1e110                         shl        rcx, 0x10
010790b4 b8000000ff                       mov        eax, 0xff000000
010790b9 4823d0                           and        rdx, rax
010790bc 480bca                           or         rcx, rdx
010790bf 48c1e108                         shl        rcx, 8
010790c3 4c0bc1                           or         r8, rcx
010790c6 4c8945f0                         mov        qword ptr [rbp - 0x10], r8
010790ca 488b5500                         mov        rdx, qword ptr [rbp]
010790ce 4c8bc2                           mov        r8, rdx
010790d1 4d23c3                           and        r8, r11
010790d4 488bc2                           mov        rax, rdx
010790d7 48c1e810                         shr        rax, 0x10
010790db 4c0bc0                           or         r8, rax
010790de 49c1e810                         shr        r8, 0x10
010790e2 488bc2                           mov        rax, rdx
010790e5 4823c7                           and        rax, rdi
010790e8 4c0bc0                           or         r8, rax
010790eb 49c1e810                         shr        r8, 0x10
010790ef 488bc2                           mov        rax, rdx
010790f2 4923c7                           and        rax, r15
010790f5 4c0bc0                           or         r8, rax
010790f8 49c1e808                         shr        r8, 8
010790fc 488bca                           mov        rcx, rdx
010790ff 48c1e110                         shl        rcx, 0x10
01079103 488bc2                           mov        rax, rdx
01079106 2500ff0000                       and        eax, 0xff00
0107910b 480bc8                           or         rcx, rax
0107910e 48c1e110                         shl        rcx, 0x10
01079112 488bc2                           mov        rax, rdx
01079115 250000ff00                       and        eax, 0xff0000
0107911a 480bc8                           or         rcx, rax
0107911d 48c1e110                         shl        rcx, 0x10
01079121 b8000000ff                       mov        eax, 0xff000000
01079126 4823d0                           and        rdx, rax
01079129 480bca                           or         rcx, rdx
0107912c 48c1e108                         shl        rcx, 8
01079130 4c0bc1                           or         r8, rcx
01079133 4c894500                         mov        qword ptr [rbp], r8
01079137 8b4d08                           mov        ecx, dword ptr [rbp + 8]
0107913a 8bd1                             mov        edx, ecx
0107913c 81e20000ff00                     and        edx, 0xff0000
01079142 8bc1                             mov        eax, ecx
01079144 c1e810                           shr        eax, 0x10
01079147 0bd0                             or         edx, eax
01079149 c1ea08                           shr        edx, 8
0107914c 8bc1                             mov        eax, ecx
0107914e c1e010                           shl        eax, 0x10
01079151 81e100ff0000                     and        ecx, 0xff00
01079157 0bc1                             or         eax, ecx
01079159 c1e008                           shl        eax, 8
0107915c 0bd0                             or         edx, eax
0107915e 895508                           mov        dword ptr [rbp + 8], edx
01079161 488b550c                         mov        rdx, qword ptr [rbp + 0xc]
01079165 4c8bc2                           mov        r8, rdx
01079168 4d23c3                           and        r8, r11
0107916b 488bc2                           mov        rax, rdx
0107916e 48c1e810                         shr        rax, 0x10
01079172 4c0bc0                           or         r8, rax
01079175 49c1e810                         shr        r8, 0x10
01079179 488bc2                           mov        rax, rdx
0107917c 4823c7                           and        rax, rdi
0107917f 4c0bc0                           or         r8, rax
01079182 49c1e810                         shr        r8, 0x10
01079186 488bc2                           mov        rax, rdx
01079189 4923c7                           and        rax, r15
0107918c 4c0bc0                           or         r8, rax
0107918f 49c1e808                         shr        r8, 8
01079193 488bca                           mov        rcx, rdx
01079196 48c1e110                         shl        rcx, 0x10
0107919a 8bc2                             mov        eax, edx
0107919c 2500ff0000                       and        eax, 0xff00
010791a1 480bc8                           or         rcx, rax
010791a4 48c1e110                         shl        rcx, 0x10
010791a8 8bc2                             mov        eax, edx
010791aa 250000ff00                       and        eax, 0xff0000
010791af 480bc8                           or         rcx, rax
010791b2 48c1e110                         shl        rcx, 0x10
010791b6 8bc2                             mov        eax, edx
010791b8 ba000000ff                       mov        edx, 0xff000000
010791bd 4823c2                           and        rax, rdx
010791c0 480bc8                           or         rcx, rax
010791c3 48c1e108                         shl        rcx, 8
010791c7 4c0bc1                           or         r8, rcx
010791ca 4c89450c                         mov        qword ptr [rbp + 0xc], r8
010791ce 4d8bfc                           mov        r15, r12
010791d1 eb08                             jmp        0x1410791db
010791d3 448b55dc                         mov        r10d, dword ptr [rbp - 0x24]
010791d7 448b4dd0                         mov        r9d, dword ptr [rbp - 0x30]
010791db 4181f96d696968                   cmp        r9d, 0x6869696d
010791e2 0f8541050000                     jne        0x141079729
010791e8 33d2                             xor        edx, edx
010791ea 89542450                         mov        dword ptr [rsp + 0x50], edx
010791ee 4533e4                           xor        r12d, r12d
010791f1 4489642440                       mov        dword ptr [rsp + 0x40], r12d
010791f6 4585d2                           test       r10d, r10d
010791f9 0f84ef020000                     je         0x1410794ee
010791ff 90                               nop        
01079200 4d8bef                           mov        r13, r15
01079203 41b808000000                     mov        r8d, 8
01079209 488d55b0                         lea        rdx, [rbp - 0x50]
0107920d 498bce                           mov        rcx, r14
01079210 e88bdeffff                       call       0x1410770a0
01079215 8bf0                             mov        esi, eax
01079217 85c0                             test       eax, eax
01079219 0f85f3040000                     jne        0x141079712
0107921f 448b55b4                         mov        r10d, dword ptr [rbp - 0x4c]
01079223 418bfa                           mov        edi, r10d
01079226 418bca                           mov        ecx, r10d
01079229 413807                           cmp        byte ptr [r15], al
0107922c 7522                             jne        0x141079250
0107922e 81e70000ff00                     and        edi, 0xff0000
01079234 8bc1                             mov        eax, ecx
01079236 c1e810                           shr        eax, 0x10
01079239 0bf8                             or         edi, eax
0107923b c1ef08                           shr        edi, 8
0107923e 8bc1                             mov        eax, ecx
01079240 c1e010                           shl        eax, 0x10
01079243 81e100ff0000                     and        ecx, 0xff00
01079249 0bc1                             or         eax, ecx
0107924b c1e008                           shl        eax, 8
0107924e 0bf8                             or         edi, eax
01079250 488d4db8                         lea        rcx, [rbp - 0x48]
01079254 41bf18000000                     mov        r15d, 0x18
0107925a 413bff                           cmp        edi, r15d
0107925d 440f42ff                         cmovb      r15d, edi
01079261 4183ff08                         cmp        r15d, 8
01079265 763a                             jbe        0x1410792a1
01079267 458d67f8                         lea        r12d, [r15 - 8]
0107926b 4981fc0000a000                   cmp        r12, 0xa00000
01079272 0f8795040000                     ja         0x14107970d
01079278 458bc4                           mov        r8d, r12d
0107927b 488d55b8                         lea        rdx, [rbp - 0x48]
0107927f 498bce                           mov        rcx, r14
01079282 e819deffff                       call       0x1410770a0
01079287 8bf0                             mov        esi, eax
01079289 85c0                             test       eax, eax
0107928b 0f8581040000                     jne        0x141079712
01079291 488d4db8                         lea        rcx, [rbp - 0x48]
01079295 4903cc                           add        rcx, r12
01079298 448b55b4                         mov        r10d, dword ptr [rbp - 0x4c]
0107929c 448b642440                       mov        r12d, dword ptr [rsp + 0x40]
010792a1 4183ff18                         cmp        r15d, 0x18
010792a5 7319                             jae        0x1410792c0
010792a7 4885c9                           test       rcx, rcx
010792aa 7414                             je         0x1410792c0
010792ac 41b818000000                     mov        r8d, 0x18
010792b2 452bc7                           sub        r8d, r15d
010792b5 33d2                             xor        edx, edx
010792b7 e8e4397200                       call       0x14179cca0
010792bc 448b55b4                         mov        r10d, dword ptr [rbp - 0x4c]
010792c0 413bff                           cmp        edi, r15d
010792c3 7617                             jbe        0x1410792dc
010792c5 412bff                           sub        edi, r15d
010792c8 8bd7                             mov        edx, edi
010792ca 498bce                           mov        rcx, r14
010792cd e84e12ffff                       call       0x14106a520
010792d2 8bf0                             mov        esi, eax
010792d4 85c0                             test       eax, eax
010792d6 0f8536040000                     jne        0x141079712
010792dc 4d8bfd                           mov        r15, r13
010792df 41807d0000                       cmp        byte ptr [r13], 0
010792e4 0f85ed000000                     jne        0x1410793d7
010792ea 8b4db0                           mov        ecx, dword ptr [rbp - 0x50]
010792ed 448bc1                           mov        r8d, ecx
010792f0 4181e00000ff00                   and        r8d, 0xff0000
010792f7 8bc1                             mov        eax, ecx
010792f9 c1e810                           shr        eax, 0x10
010792fc 440bc0                           or         r8d, eax
010792ff 41c1e808                         shr        r8d, 8
01079303 8bc1                             mov        eax, ecx
01079305 c1e010                           shl        eax, 0x10
01079308 81e100ff0000                     and        ecx, 0xff00
0107930e 0bc1                             or         eax, ecx
01079310 c1e008                           shl        eax, 8
01079313 440bc0                           or         r8d, eax
01079316 448945b0                         mov        dword ptr [rbp - 0x50], r8d
0107931a 418bca                           mov        ecx, r10d
0107931d 81e10000ff00                     and        ecx, 0xff0000
01079323 418bc2                           mov        eax, r10d
01079326 c1e810                           shr        eax, 0x10
01079329 0bc8                             or         ecx, eax
0107932b c1e908                           shr        ecx, 8
0107932e 418bc2                           mov        eax, r10d
01079331 c1e010                           shl        eax, 0x10
01079334 4181e200ff0000                   and        r10d, 0xff00
0107933b 410bc2                           or         eax, r10d
0107933e c1e008                           shl        eax, 8
01079341 448bd1                           mov        r10d, ecx
01079344 440bd0                           or         r10d, eax
01079347 448955b4                         mov        dword ptr [rbp - 0x4c], r10d
0107934b 8b4db8                           mov        ecx, dword ptr [rbp - 0x48]
0107934e 448bc9                           mov        r9d, ecx
01079351 4181e10000ff00                   and        r9d, 0xff0000
01079358 8bc1                             mov        eax, ecx
0107935a c1e810                           shr        eax, 0x10
0107935d 440bc8                           or         r9d, eax
01079360 41c1e908                         shr        r9d, 8
01079364 8bc1                             mov        eax, ecx
01079366 c1e010                           shl        eax, 0x10
01079369 81e100ff0000                     and        ecx, 0xff00
0107936f 0bc1                             or         eax, ecx
01079371 c1e008                           shl        eax, 8
01079374 440bc8                           or         r9d, eax
01079377 44894db8                         mov        dword ptr [rbp - 0x48], r9d
0107937b 8b4dbc                           mov        ecx, dword ptr [rbp - 0x44]
0107937e 8bd1                             mov        edx, ecx
01079380 81e20000ff00                     and        edx, 0xff0000
01079386 8bc1                             mov        eax, ecx
01079388 c1e810                           shr        eax, 0x10
0107938b 0bd0                             or         edx, eax
0107938d c1ea08                           shr        edx, 8
01079390 8bc1                             mov        eax, ecx
01079392 c1e010                           shl        eax, 0x10
01079395 81e100ff0000                     and        ecx, 0xff00
0107939b 0bc1                             or         eax, ecx
0107939d c1e008                           shl        eax, 8
010793a0 0bd0                             or         edx, eax
010793a2 8955bc                           mov        dword ptr [rbp - 0x44], edx
010793a5 8b4dc0                           mov        ecx, dword ptr [rbp - 0x40]
010793a8 448bd9                           mov        r11d, ecx
010793ab 4181e30000ff00                   and        r11d, 0xff0000
010793b2 8bc1                             mov        eax, ecx
010793b4 c1e810                           shr        eax, 0x10
010793b7 440bd8                           or         r11d, eax
010793ba 41c1eb08                         shr        r11d, 8
010793be 8bc1                             mov        eax, ecx
010793c0 c1e010                           shl        eax, 0x10
010793c3 81e100ff0000                     and        ecx, 0xff00
010793c9 0bc1                             or         eax, ecx
010793cb c1e008                           shl        eax, 8
010793ce 440bd8                           or         r11d, eax
010793d1 44895dc0                         mov        dword ptr [rbp - 0x40], r11d
010793d5 eb0f                             jmp        0x1410793e6
010793d7 448b5dc0                         mov        r11d, dword ptr [rbp - 0x40]
010793db 8b55bc                           mov        edx, dword ptr [rbp - 0x44]
010793de 448b4db8                         mov        r9d, dword ptr [rbp - 0x48]
010793e2 448b45b0                         mov        r8d, dword ptr [rbp - 0x50]
010793e6 4181f86d686f68                   cmp        r8d, 0x686f686d
010793ed 0f851a030000                     jne        0x14107970d
010793f3 81ea90010000                     sub        edx, 0x190
010793f9 0f849c000000                     je         0x14107949b
010793ff 83ea01                           sub        edx, 1
01079402 0f8480000000                     je         0x141079488
01079408 452bca                           sub        r9d, r10d
0107940b 83fa01                           cmp        edx, 1
0107940e 743b                             je         0x14107944b
01079410 4963d1                           movsxd     rdx, r9d
01079413 4903967001e001                   add        rdx, qword ptr [r14 + 0x1e00170]
0107941a 4989967001e001                   mov        qword ptr [r14 + 0x1e00170], rdx
01079421 498b8e7801e001                   mov        rcx, qword ptr [r14 + 0x1e00178]
01079428 483bd1                           cmp        rdx, rcx
0107942b 720c                             jb         0x141079439
0107942d 49038e8001e001                   add        rcx, qword ptr [r14 + 0x1e00180]
01079434 483bd1                           cmp        rdx, rcx
01079437 720b                             jb         0x141079444
01079439 49c7868001e00100000000           mov        qword ptr [r14 + 0x1e00180], 0
01079444 33f6                             xor        esi, esi
01079446 e988000000                       jmp        0x1410794d3
0107944b 48c744244000000000               mov        qword ptr [rsp + 0x40], 0
01079454 4c8d442440                       lea        r8, [rsp + 0x40]
01079459 418bd1                           mov        edx, r9d
0107945c 498bce                           mov        rcx, r14
0107945f e87ceaffff                       call       0x141077ee0
01079464 8bf0                             mov        esi, eax
01079466 488b442440                       mov        rax, qword ptr [rsp + 0x40]
0107946b 4885c0                           test       rax, rax
0107946e 745b                             je         0x1410794cb
01079470 488bcb                           mov        rcx, rbx
01079473 488bd8                           mov        rbx, rax
01079476 4889442468                       mov        qword ptr [rsp + 0x68], rax
0107947b 4885c9                           test       rcx, rcx
0107947e 744b                             je         0x1410794cb
01079480 ff159af98600                     call       qword ptr [rip + 0x86f99a]
01079486 eb43                             jmp        0x1410794cb
01079488 4c8b442458                       mov        r8, qword ptr [rsp + 0x58]
0107948d 4981c0f8170000                   add        r8, 0x17f8
01079494 488d442448                       lea        rax, [rsp + 0x48]
01079499 eb11                             jmp        0x1410794ac
0107949b 4c8b442458                       mov        r8, qword ptr [rsp + 0x58]
010794a0 4981c008020000                   add        r8, 0x208
010794a7 488d442450                       lea        rax, [rsp + 0x50]
010794ac c744242800000000                 mov        dword ptr [rsp + 0x28], 0
010794b4 4889442420                       mov        qword ptr [rsp + 0x20], rax
010794b9 458bcb                           mov        r9d, r11d
010794bc ba01000000                       mov        edx, 1
010794c1 498bce                           mov        rcx, r14
010794c4 e807dfffff                       call       0x1410773d0
010794c9 8bf0                             mov        esi, eax
010794cb 85f6                             test       esi, esi
010794cd 0f853f020000                     jne        0x141079712
010794d3 41ffc4                           inc        r12d
010794d6 4489642440                       mov        dword ptr [rsp + 0x40], r12d
010794db 443b65dc                         cmp        r12d, dword ptr [rbp - 0x24]
010794df 0f821bfdffff                     jb         0x141079200
010794e5 8b542450                         mov        edx, dword ptr [rsp + 0x50]
010794e9 4c8b6c2458                       mov        r13, qword ptr [rsp + 0x58]
010794ee 807dec02                         cmp        byte ptr [rbp - 0x14], 2
010794f2 0f85f1010000                     jne        0x1410796e9
010794f8 488d442460                       lea        rax, [rsp + 0x60]
010794fd 4889442438                       mov        qword ptr [rsp + 0x38], rax
01079502 488b450c                         mov        rax, qword ptr [rbp + 0xc]
01079506 4889442430                       mov        qword ptr [rsp + 0x30], rax
0107950b 488b45f0                         mov        rax, qword ptr [rbp - 0x10]
0107950f 4889442428                       mov        qword ptr [rsp + 0x28], rax
01079514 0fb645ed                         movzx      eax, byte ptr [rbp - 0x13]
01079518 88442420                         mov        byte ptr [rsp + 0x20], al
0107951c 4c8b4de4                         mov        r9, qword ptr [rbp - 0x1c]
01079520 448b442448                       mov        r8d, dword ptr [rsp + 0x48]
01079525 498bcd                           mov        rcx, r13
01079528 e8f352efff                       call       0x140f6e820
0107952d 8bf0                             mov        esi, eax
0107952f 85c0                             test       eax, eax
01079531 0f85db010000                     jne        0x141079712
01079537 488b7c2460                       mov        rdi, qword ptr [rsp + 0x60]
0107953c 4885db                           test       rbx, rbx
0107953f 0f84a1000000                     je         0x1410795e6
01079545 488b07                           mov        rax, qword ptr [rdi]
01079548 41b001                           mov        r8b, 1
0107954b 488d542470                       lea        rdx, [rsp + 0x70]
01079550 488bcf                           mov        rcx, rdi
01079553 ff9090000000                     call       qword ptr [rax + 0x90]
01079559 4c8b642470                       mov        r12, qword ptr [rsp + 0x70]
0107955e 4d85e4                           test       r12, r12
01079561 7444                             je         0x1410795a7
01079563 498b442418                       mov        rax, qword ptr [r12 + 0x18]
01079568 4885c0                           test       rax, rax
0107956b 7527                             jne        0x141079594
0107956d 4c8b0dccf88600                   mov        r9, qword ptr [rip + 0x86f8cc]
01079574 4c8b056df88600                   mov        r8, qword ptr [rip + 0x86f86d]
0107957b 33d2                             xor        edx, edx
0107957d 488b0d0ccb0201                   mov        rcx, qword ptr [rip + 0x102cb0c]
01079584 ff152efd8600                     call       qword ptr [rip + 0x86fd2e]
0107958a 4989442418                       mov        qword ptr [r12 + 0x18], rax
0107958f 4885c0                           test       rax, rax
01079592 7413                             je         0x1410795a7
01079594 4c8bc0                           mov        r8, rax
01079597 488d15022bb4ff                   lea        rdx, [rip - 0x4bd4fe]
0107959e 488bcb                           mov        rcx, rbx
010795a1 ff1549fd8600                     call       qword ptr [rip + 0x86fd49]
010795a7 4c8b642478                       mov        r12, qword ptr [rsp + 0x78]
010795ac 4d85e4                           test       r12, r12
010795af 7435                             je         0x1410795e6
010795b1 b8ffffffff                       mov        eax, 0xffffffff
010795b6 f0410fc1442408                   lock xadd  dword ptr [r12 + 8], eax
010795bd 83f801                           cmp        eax, 1
010795c0 7524                             jne        0x1410795e6
010795c2 498b0424                         mov        rax, qword ptr [r12]
010795c6 498bcc                           mov        rcx, r12
010795c9 ff10                             call       qword ptr [rax]
010795cb b8ffffffff                       mov        eax, 0xffffffff
010795d0 f0410fc144240c                   lock xadd  dword ptr [r12 + 0xc], eax
010795d7 83f801                           cmp        eax, 1
010795da 750a                             jne        0x1410795e6
010795dc 498b0424                         mov        rax, qword ptr [r12]
010795e0 498bcc                           mov        rcx, r12
010795e3 ff5008                           call       qword ptr [rax + 8]
010795e6 48837d0000                       cmp        qword ptr [rbp], 0
010795eb 746b                             je         0x141079658
010795ed 488b07                           mov        rax, qword ptr [rdi]
010795f0 41b001                           mov        r8b, 1
010795f3 488d5580                         lea        rdx, [rbp - 0x80]
010795f7 488bcf                           mov        rcx, rdi
010795fa ff9098000000                     call       qword ptr [rax + 0x98]
01079600 90                               nop        
01079601 488b4d80                         mov        rcx, qword ptr [rbp - 0x80]
01079605 4885c9                           test       rcx, rcx
01079608 7410                             je         0x14107961a
0107960a 488b01                           mov        rax, qword ptr [rcx]
0107960d 4c8b4500                         mov        r8, qword ptr [rbp]
01079611 ba05000000                       mov        edx, 5
01079616 ff5060                           call       qword ptr [rax + 0x60]
01079619 90                               nop        
0107961a 4c8b6588                         mov        r12, qword ptr [rbp - 0x78]
0107961e 4d85e4                           test       r12, r12
01079621 7435                             je         0x141079658
01079623 b8ffffffff                       mov        eax, 0xffffffff
01079628 f0410fc1442408                   lock xadd  dword ptr [r12 + 8], eax
0107962f 83f801                           cmp        eax, 1
01079632 7524                             jne        0x141079658
01079634 498b0424                         mov        rax, qword ptr [r12]
01079638 498bcc                           mov        rcx, r12
0107963b ff10                             call       qword ptr [rax]
0107963d b8ffffffff                       mov        eax, 0xffffffff
01079642 f0410fc144240c                   lock xadd  dword ptr [r12 + 0xc], eax
01079649 83f801                           cmp        eax, 1
0107964c 750a                             jne        0x141079658
0107964e 498b0424                         mov        rax, qword ptr [r12]
01079652 498bcc                           mov        rcx, r12
01079655 ff5008                           call       qword ptr [rax + 8]
01079658 488b55f0                         mov        rdx, qword ptr [rbp - 0x10]
0107965c 4885d2                           test       rdx, rdx
0107965f 7408                             je         0x141079669
01079661 488bcf                           mov        rcx, rdi
01079664 e8e775efff                       call       0x140f70c50
01079669 807dee00                         cmp        byte ptr [rbp - 0x12], 0
0107966d 0f95c1                           setne      cl
01079670 0fb6978c000000                   movzx      edx, byte ptr [rdi + 0x8c]
01079677 0fb6c2                           movzx      eax, dl
0107967a c0e804                           shr        al, 4
0107967d 2401                             and        al, 1
0107967f 3ac1                             cmp        al, cl
01079681 7415                             je         0x141079698
01079683 c0e104                           shl        cl, 4
01079686 80e2ef                           and        dl, 0xef
01079689 0aca                             or         cl, dl
0107968b 888f8c000000                     mov        byte ptr [rdi + 0x8c], cl
01079691 838fc000000008                   or         dword ptr [rdi + 0xc0], 8
01079698 0fb645ef                         movzx      eax, byte ptr [rbp - 0x11]
0107969c 3887c4000000                     cmp        byte ptr [rdi + 0xc4], al
010796a2 740d                             je         0x1410796b1
010796a4 8887c4000000                     mov        byte ptr [rdi + 0xc4], al
010796aa 838fc000000010                   or         dword ptr [rdi + 0xc0], 0x10
010796b1 8b4508                           mov        eax, dword ptr [rbp + 8]
010796b4 8987c8000000                     mov        dword ptr [rdi + 0xc8], eax
010796ba 837de000                         cmp        dword ptr [rbp - 0x20], 0
010796be 7419                             je         0x1410796d9
010796c0 498d8ed802e001                   lea        rcx, [r14 + 0x1e002d8]
010796c7 4c8d4c2460                       lea        r9, [rsp + 0x60]
010796cc 4c8d45e0                         lea        r8, [rbp - 0x20]
010796d0 488d5598                         lea        rdx, [rbp - 0x68]
010796d4 e8979e61ff                       call       0x140693570
010796d9 49ff869001e001                   inc        qword ptr [r14 + 0x1e00190]
010796e0 498bce                           mov        rcx, r14
010796e3 e858dcffff                       call       0x141077340
010796e8 90                               nop        
010796e9 4885db                           test       rbx, rbx
010796ec 7409                             je         0x1410796f7
010796ee 488bcb                           mov        rcx, rbx
010796f1 ff1529f78600                     call       qword ptr [rip + 0x86f729]
010796f7 8b7c244c                         mov        edi, dword ptr [rsp + 0x4c]
010796fb ffc7                             inc        edi
010796fd 897c244c                         mov        dword ptr [rsp + 0x4c], edi
01079701 3b7d48                           cmp        edi, dword ptr [rbp + 0x48]
01079704 732d                             jae        0x141079733
01079706 33c0                             xor        eax, eax
01079708 e9e4f6ffff                       jmp        0x141078df1
0107970d be30ffffff                       mov        esi, 0xffffff30
01079712 4885db                           test       rbx, rbx
01079715 0f84b8000000                     je         0x1410797d3
0107971b 488bcb                           mov        rcx, rbx
0107971e ff15fcf68600                     call       qword ptr [rip + 0x86f6fc]
01079724 e9aa000000                       jmp        0x1410797d3
01079729 be30ffffff                       mov        esi, 0xffffff30
0107972e e9a0000000                       jmp        0x1410797d3
01079733 48837d4c00                       cmp        qword ptr [rbp + 0x4c], 0
01079738 0f848d000000                     je         0x1410797cb
0107973e 4d85ed                           test       r13, r13
01079741 0f8484000000                     je         0x1410797cb
01079747 4181bd8000000074616474           cmp        dword ptr [r13 + 0x80], 0x74646174
01079752 7577                             jne        0x1410797cb
01079754 498b9df8000000                   mov        rbx, qword ptr [r13 + 0xf8]
0107975b 4885db                           test       rbx, rbx
0107975e 751f                             jne        0x14107977f
01079760 33d2                             xor        edx, edx
01079762 41b8e8030000                     mov        r8d, 0x3e8
01079768 498bcd                           mov        rcx, r13
0107976b e8a049efff                       call       0x140f6e110
01079770 488bd8                           mov        rbx, rax
01079773 4885c0                           test       rax, rax
01079776 7453                             je         0x1410797cb
01079778 498985f8000000                   mov        qword ptr [r13 + 0xf8], rax
0107977f ff154b108700                     call       qword ptr [rip + 0x87104b]
01079785 8bc8                             mov        ecx, eax
01079787 e85469b5ff                       call       0x140bd00e0
0107978c 488b03                           mov        rax, qword ptr [rbx]
0107978f 488bcb                           mov        rcx, rbx
01079792 ff90c0000000                     call       qword ptr [rax + 0xc0]
01079798 488b554c                         mov        rdx, qword ptr [rbp + 0x4c]
0107979c 488bcb                           mov        rcx, rbx
0107979f e8ac74efff                       call       0x140f70c50
010797a4 488b03                           mov        rax, qword ptr [rbx]
010797a7 b205                             mov        dl, 5
010797a9 488bcb                           mov        rcx, rbx
010797ac ff90a8000000                     call       qword ptr [rax + 0xa8]
010797b2 ff1518108700                     call       qword ptr [rip + 0x871018]
010797b8 8bc8                             mov        ecx, eax
010797ba e82169b5ff                       call       0x140bd00e0
010797bf 488b03                           mov        rax, qword ptr [rbx]
010797c2 488bcb                           mov        rcx, rbx
010797c5 ff90c8000000                     call       qword ptr [rax + 0xc8]
010797cb 41c686a901e00101                 mov        byte ptr [r14 + 0x1e001a9], 1
010797d3 8bc6                             mov        eax, esi
010797d5 488b8db0000000                   mov        rcx, qword ptr [rbp + 0xb0]
010797dc 4833cc                           xor        rcx, rsp
010797df e8fc207200                       call       0x14179b8e0
010797e4 4c8d9c24c0010000                 lea        r11, [rsp + 0x1c0]
010797ec 498b5b38                         mov        rbx, qword ptr [r11 + 0x38]
010797f0 498b7340                         mov        rsi, qword ptr [r11 + 0x40]
010797f4 498b7b48                         mov        rdi, qword ptr [r11 + 0x48]
010797f8 498be3                           mov        rsp, r11
010797fb 415f                             pop        r15
010797fd 415e                             pop        r14
010797ff 415d                             pop        r13
01079801 415c                             pop        r12
01079803 5d                               pop        rbp
01079804 c3                               ret        
