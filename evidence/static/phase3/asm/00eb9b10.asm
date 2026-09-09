; iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0xeb9b10
; unwind group range 0xeb9b10..0xeb9dd5 (exclusive)
00eb9b10 4053                             push       rbx
00eb9b12 55                               push       rbp
00eb9b13 56                               push       rsi
00eb9b14 57                               push       rdi
00eb9b15 4156                             push       r14
00eb9b17 4881ec80040000                   sub        rsp, 0x480
00eb9b1e 0f29b42470040000                 movaps     xmmword ptr [rsp + 0x470], xmm6
00eb9b26 488b0513b51101                   mov        rax, qword ptr [rip + 0x111b513]
00eb9b2d 4833c4                           xor        rax, rsp
00eb9b30 4889842460040000                 mov        qword ptr [rsp + 0x460], rax
00eb9b38 418bc0                           mov        eax, r8d
00eb9b3b 488bfa                           mov        rdi, rdx
00eb9b3e 488bf1                           mov        rsi, rcx
00eb9b41 4533f6                           xor        r14d, r14d
00eb9b44 4489742430                       mov        dword ptr [rsp + 0x30], r14d
00eb9b49 4c89742428                       mov        qword ptr [rsp + 0x28], r14
00eb9b4e 4c89742420                       mov        qword ptr [rsp + 0x20], r14
00eb9b53 4533c9                           xor        r9d, r9d
00eb9b56 4533c0                           xor        r8d, r8d
00eb9b59 8bd0                             mov        edx, eax
00eb9b5b e890a65dff                       call       0x1404941f0
00eb9b60 8bd8                             mov        ebx, eax
00eb9b62 85c0                             test       eax, eax
00eb9b64 0f8545020000                     jne        0x140eb9daf
00eb9b6a 4885f6                           test       rsi, rsi
00eb9b6d 0f8437020000                     je         0x140eb9daa
00eb9b73 488b4608                         mov        rax, qword ptr [rsi + 8]
00eb9b77 4885c0                           test       rax, rax
00eb9b7a 0f842a020000                     je         0x140eb9daa
00eb9b80 488b4810                         mov        rcx, qword ptr [rax + 0x10]
00eb9b84 4885c9                           test       rcx, rcx
00eb9b87 0f841d020000                     je         0x140eb9daa
00eb9b8d 4439b0b0000000                   cmp        dword ptr [rax + 0xb0], r14d
00eb9b94 0f8570010000                     jne        0x140eb9d0a
00eb9b9a 81b98000000074616474             cmp        dword ptr [rcx + 0x80], 0x74646174
00eb9ba4 7513                             jne        0x140eb9bb9
00eb9ba6 81b98400000069506f64             cmp        dword ptr [rcx + 0x84], 0x646f5069
00eb9bb0 7407                             je         0x140eb9bb9
00eb9bb2 80889a00000010                   or         byte ptr [rax + 0x9a], 0x10
00eb9bb9 664489b42460020000               mov        word ptr [rsp + 0x260], r14w
00eb9bc2 4885ff                           test       rdi, rdi
00eb9bc5 742a                             je         0x140eb9bf1
00eb9bc7 488b4f10                         mov        rcx, qword ptr [rdi + 0x10]
00eb9bcb 4885c9                           test       rcx, rcx
00eb9bce 7421                             je         0x140eb9bf1
00eb9bd0 8b07                             mov        eax, dword ptr [rdi]
00eb9bd2 3d50434641                       cmp        eax, 0x41464350
00eb9bd7 7407                             je         0x140eb9be0
00eb9bd9 3d506e6957                       cmp        eax, 0x57696e50
00eb9bde 7511                             jne        0x140eb9bf1
00eb9be0 488b4110                         mov        rax, qword ptr [rcx + 0x10]
00eb9be4 488d942460020000                 lea        rdx, [rsp + 0x260]
00eb9bec 488bcf                           mov        rcx, rdi
00eb9bef ffd0                             call       rax
00eb9bf1 0f57c0                           xorps      xmm0, xmm0
00eb9bf4 660f7f442450                     movdqa     xmmword ptr [rsp + 0x50], xmm0
00eb9bfa 660f7f442440                     movdqa     xmmword ptr [rsp + 0x40], xmm0
00eb9c00 c744243008000000                 mov        dword ptr [rsp + 0x30], 8
00eb9c08 4c89742428                       mov        qword ptr [rsp + 0x28], r14
00eb9c0d 488d442440                       lea        rax, [rsp + 0x40]
00eb9c12 4889442420                       mov        qword ptr [rsp + 0x20], rax
00eb9c17 4533c9                           xor        r9d, r9d
00eb9c1a 4533c0                           xor        r8d, r8d
00eb9c1d ba82000000                       mov        edx, 0x82
00eb9c22 488bce                           mov        rcx, rsi
00eb9c25 e8b62d4eff                       call       0x14039c9e0
00eb9c2a 90                               nop        
00eb9c2b 660f6f742440                     movdqa     xmm6, xmmword ptr [rsp + 0x40]
00eb9c31 660f7f742450                     movdqa     xmmword ptr [rsp + 0x50], xmm6
00eb9c37 bdff000000                       mov        ebp, 0xff
00eb9c3c 66480f7ef1                       movq       rcx, xmm6
00eb9c41 4885c9                           test       rcx, rcx
00eb9c44 7418                             je         0x140eb9c5e
00eb9c46 488b01                           mov        rax, qword ptr [rcx]
00eb9c49 4c8d442460                       lea        r8, [rsp + 0x60]
00eb9c4e 488d942460020000                 lea        rdx, [rsp + 0x260]
00eb9c56 ff90e8000000                     call       qword ptr [rax + 0xe8]
00eb9c5c eb38                             jmp        0x140eb9c96
00eb9c5e 0fb7842460020000                 movzx      eax, word ptr [rsp + 0x260]
00eb9c66 3bc5                             cmp        eax, ebp
00eb9c68 7609                             jbe        0x140eb9c73
00eb9c6a 66896c2460                       mov        word ptr [rsp + 0x60], bp
00eb9c6f 8bc5                             mov        eax, ebp
00eb9c71 eb0a                             jmp        0x140eb9c7d
00eb9c73 6689442460                       mov        word ptr [rsp + 0x60], ax
00eb9c78 83f801                           cmp        eax, 1
00eb9c7b 7219                             jb         0x140eb9c96
00eb9c7d 448bc0                           mov        r8d, eax
00eb9c80 4d03c0                           add        r8, r8
00eb9c83 488d942462020000                 lea        rdx, [rsp + 0x262]
00eb9c8b 488d4c2462                       lea        rcx, [rsp + 0x62]
00eb9c90 e805308e00                       call       0x14179cc9a
00eb9c95 90                               nop        
00eb9c96 660f73de08                       psrldq     xmm6, 8
00eb9c9b 66480f7ef3                       movq       rbx, xmm6
00eb9ca0 4885db                           test       rbx, rbx
00eb9ca3 742c                             je         0x140eb9cd1
00eb9ca5 bfffffffff                       mov        edi, 0xffffffff
00eb9caa 8bc7                             mov        eax, edi
00eb9cac f00fc14308                       lock xadd  dword ptr [rbx + 8], eax
00eb9cb1 83f801                           cmp        eax, 1
00eb9cb4 751b                             jne        0x140eb9cd1
00eb9cb6 488b03                           mov        rax, qword ptr [rbx]
00eb9cb9 488bcb                           mov        rcx, rbx
00eb9cbc ff10                             call       qword ptr [rax]
00eb9cbe f00fc17b0c                       lock xadd  dword ptr [rbx + 0xc], edi
00eb9cc3 83ff01                           cmp        edi, 1
00eb9cc6 7509                             jne        0x140eb9cd1
00eb9cc8 488b03                           mov        rax, qword ptr [rbx]
00eb9ccb 488bcb                           mov        rcx, rbx
00eb9cce ff5008                           call       qword ptr [rax + 8]
00eb9cd1 488b7e08                         mov        rdi, qword ptr [rsi + 8]
00eb9cd5 4885ff                           test       rdi, rdi
00eb9cd8 742b                             je         0x140eb9d05
00eb9cda 4c8b5710                         mov        r10, qword ptr [rdi + 0x10]
00eb9cde 4d85d2                           test       r10, r10
00eb9ce1 7422                             je         0x140eb9d05
00eb9ce3 4c8d8fb0000000                   lea        r9, [rdi + 0xb0]
00eb9cea 4981c278010000                   add        r10, 0x178
00eb9cf1 66396c2460                       cmp        word ptr [rsp + 0x60], bp
00eb9cf6 7619                             jbe        0x140eb9d11
00eb9cf8 458931                           mov        dword ptr [r9], r14d
00eb9cfb 33d2                             xor        edx, edx
00eb9cfd 488bcf                           mov        rcx, rdi
00eb9d00 e87bde0000                       call       0x140ec7b80
00eb9d05 bbceffffff                       mov        ebx, 0xffffffce
00eb9d0a 8bc3                             mov        eax, ebx
00eb9d0c e99e000000                       jmp        0x140eb9daf
00eb9d11 440fb75c2460                     movzx      r11d, word ptr [rsp + 0x60]
00eb9d17 4503db                           add        r11d, r11d
00eb9d1a 4d85d2                           test       r10, r10
00eb9d1d 7478                             je         0x140eb9d97
00eb9d1f 41813a63727473                   cmp        dword ptr [r10], 0x73747263
00eb9d26 756f                             jne        0x140eb9d97
00eb9d28 41837a2800                       cmp        dword ptr [r10 + 0x28], 0
00eb9d2d 7568                             jne        0x140eb9d97
00eb9d2f 496301                           movsxd     rax, dword ptr [r9]
00eb9d32 41837a3c00                       cmp        dword ptr [r10 + 0x3c], 0
00eb9d37 755e                             jne        0x140eb9d97
00eb9d39 85c0                             test       eax, eax
00eb9d3b 743a                             je         0x140eb9d77
00eb9d3d 7e58                             jle        0x140eb9d97
00eb9d3f 413b422c                         cmp        eax, dword ptr [r10 + 0x2c]
00eb9d43 7f52                             jg         0x140eb9d97
00eb9d45 4c8bc0                           mov        r8, rax
00eb9d48 41f6420401                       test       byte ptr [r10 + 4], 1
00eb9d4d 740f                             je         0x140eb9d5e
00eb9d4f 498b4218                         mov        rax, qword ptr [r10 + 0x18]
00eb9d53 488b08                           mov        rcx, qword ptr [rax]
00eb9d56 42836c81fc01                     sub        dword ptr [rcx + r8*4 - 4], 1
00eb9d5c 7519                             jne        0x140eb9d77
00eb9d5e 498b4210                         mov        rax, qword ptr [r10 + 0x10]
00eb9d62 488b10                           mov        rdx, qword ptr [rax]
00eb9d65 428b44c2fc                       mov        eax, dword ptr [rdx + r8*8 - 4]
00eb9d6a 41014240                         add        dword ptr [r10 + 0x40], eax
00eb9d6e 42c744c2f801000080               mov        dword ptr [rdx + r8*8 - 8], 0x80000001
00eb9d77 458bc3                           mov        r8d, r11d
00eb9d7a 488d542462                       lea        rdx, [rsp + 0x62]
00eb9d7f 498bca                           mov        rcx, r10
00eb9d82 e86944d4ff                       call       0x140bfe1f0
00eb9d87 8bd8                             mov        ebx, eax
00eb9d89 33d2                             xor        edx, edx
00eb9d8b 488bcf                           mov        rcx, rdi
00eb9d8e e8eddd0000                       call       0x140ec7b80
00eb9d93 8bc3                             mov        eax, ebx
00eb9d95 eb18                             jmp        0x140eb9daf
00eb9d97 bbceffffff                       mov        ebx, 0xffffffce
00eb9d9c 33d2                             xor        edx, edx
00eb9d9e 488bcf                           mov        rcx, rdi
00eb9da1 e8dadd0000                       call       0x140ec7b80
00eb9da6 8bc3                             mov        eax, ebx
00eb9da8 eb05                             jmp        0x140eb9daf
00eb9daa b8ceffffff                       mov        eax, 0xffffffce
00eb9daf 488b8c2460040000                 mov        rcx, qword ptr [rsp + 0x460]
00eb9db7 4833cc                           xor        rcx, rsp
00eb9dba e8211b8e00                       call       0x14179b8e0
00eb9dbf 0f28b42470040000                 movaps     xmm6, xmmword ptr [rsp + 0x470]
00eb9dc7 4881c480040000                   add        rsp, 0x480
00eb9dce 415e                             pop        r14
00eb9dd0 5f                               pop        rdi
00eb9dd1 5e                               pop        rsi
00eb9dd2 5d                               pop        rbp
00eb9dd3 5b                               pop        rbx
00eb9dd4 c3                               ret        
