; iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0xec8180
; unwind group range 0xec8180..0xec81ee (exclusive)
00ec8180 4c8bdc                           mov        r11, rsp
00ec8183 55                               push       rbp
00ec8184 53                               push       rbx
00ec8185 4154                             push       r12
00ec8187 4156                             push       r14
00ec8189 4157                             push       r15
00ec818b 498dab18feffff                   lea        rbp, [r11 - 0x1e8]
00ec8192 4881ecc0020000                   sub        rsp, 0x2c0
00ec8199 488b05a0ce1001                   mov        rax, qword ptr [rip + 0x110cea0]
00ec81a0 4833c4                           xor        rax, rsp
00ec81a3 48898590010000                   mov        qword ptr [rbp + 0x190], rax
00ec81aa 4c8bbd10020000                   mov        r15, qword ptr [rbp + 0x210]
00ec81b1 458be0                           mov        r12d, r8d
00ec81b4 41d1ec                           shr        r12d, 1
00ec81b7 450fb6f0                         movzx      r14d, r8b
00ec81bb 41f6d4                           not        r12b
00ec81be 4c894d80                         mov        qword ptr [rbp - 0x80], r9
00ec81c2 4180e401                         and        r12b, 1
00ec81c6 4889542468                       mov        qword ptr [rsp + 0x68], rdx
00ec81cb 4180e601                         and        r14b, 1
00ec81cf 4c897c2478                       mov        qword ptr [rsp + 0x78], r15
00ec81d4 4489642434                       mov        dword ptr [rsp + 0x34], r12d
00ec81d9 488bd9                           mov        rbx, rcx
00ec81dc 4885d2                           test       rdx, rdx
00ec81df 0f84220e0000                     je         0x140ec9007
00ec81e5 4885c9                           test       rcx, rcx
00ec81e8 0f84190e0000                     je         0x140ec9007
; unwind group range 0xec81ee..0xec81ff (exclusive)
00ec81ee 49897bd0                         mov        qword ptr [r11 - 0x30], rdi
00ec81f2 488b7a08                         mov        rdi, qword ptr [rdx + 8]
00ec81f6 4885ff                           test       rdi, rdi
00ec81f9 0f84000e0000                     je         0x140ec8fff
; unwind group range 0xec81ff..0xec822a (exclusive)
00ec81ff 4d896bc8                         mov        qword ptr [r11 - 0x38], r13
00ec8203 4c8b6f10                         mov        r13, qword ptr [rdi + 0x10]
00ec8207 4c896c2460                       mov        qword ptr [rsp + 0x60], r13
00ec820c 4d85ed                           test       r13, r13
00ec820f 0f84e20d0000                     je         0x140ec8ff7
00ec8215 4181bd8000000074616474           cmp        dword ptr [r13 + 0x80], 0x74646174
00ec8220 0f85d10d0000                     jne        0x140ec8ff7
00ec8226 8b03                             mov        eax, dword ptr [rbx]
00ec8228 33c9                             xor        ecx, ecx
; unwind group range 0xec822a..0xec8230 (exclusive)
00ec822a 49897318                         mov        qword ptr [r11 + 0x18], rsi
00ec822e 8bf1                             mov        esi, ecx
; unwind group range 0xec8230..0xec8fec (exclusive)
00ec8230 410f2973b8                       movaps     xmmword ptr [r11 - 0x48], xmm6
00ec8235 0f57f6                           xorps      xmm6, xmm6
00ec8238 0f11742440                       movups     xmmword ptr [rsp + 0x40], xmm6
00ec823d 0f11742450                       movups     xmmword ptr [rsp + 0x50], xmm6
00ec8242 85c0                             test       eax, eax
00ec8244 0f845e0d0000                     je         0x140ec8fa8
00ec824a a801                             test       al, 1
00ec824c 0f8492000000                     je         0x140ec82e4
00ec8252 66394b08                         cmp        word ptr [rbx + 8], cx
00ec8256 4c8d7b08                         lea        r15, [rbx + 8]
00ec825a 0f8484000000                     je         0x140ec82e4
00ec8260 f6879a00000020                   test       byte ptr [rdi + 0x9a], 0x20
00ec8267 757b                             jne        0x140ec82e4
00ec8269 4584f6                           test       r14b, r14b
00ec826c 754b                             jne        0x140ec82b9
00ec826e 0fb7c1                           movzx      eax, cx
00ec8271 66894d90                         mov        word ptr [rbp - 0x70], cx
00ec8275 488b4f10                         mov        rcx, qword ptr [rdi + 0x10]
00ec8279 4885c9                           test       rcx, rcx
00ec827c 741a                             je         0x140ec8298
00ec827e 8b97b0000000                     mov        edx, dword ptr [rdi + 0xb0]
00ec8284 4c8d4590                         lea        r8, [rbp - 0x70]
00ec8288 4881c178010000                   add        rcx, 0x178
00ec828f e8dc71d3ff                       call       0x140bff470
00ec8294 0fb74590                         movzx      eax, word ptr [rbp - 0x70]
00ec8298 410fb717                         movzx      edx, word ptr [r15]
00ec829c 498d4f02                         lea        rcx, [r15 + 2]
00ec82a0 440fb7c8                         movzx      r9d, ax
00ec82a4 4c8d4592                         lea        r8, [rbp - 0x6e]
00ec82a8 c744242020000000                 mov        dword ptr [rsp + 0x20], 0x20
00ec82b0 e88bccc1ff                       call       0x140ae4f40
00ec82b5 84c0                             test       al, al
00ec82b7 752b                             jne        0x140ec82e4
00ec82b9 4533c0                           xor        r8d, r8d
00ec82bc 498bd7                           mov        rdx, r15
00ec82bf 488bcf                           mov        rcx, rdi
00ec82c2 e8b9930c00                       call       0x140f91680
00ec82c7 440fb67c2440                     movzx      r15d, byte ptr [rsp + 0x40]
00ec82cd be01000000                       mov        esi, 1
00ec82d2 4180cf20                         or         r15b, 0x20
00ec82d6 80a79a000000ef                   and        byte ptr [rdi + 0x9a], 0xef
00ec82dd 44887c2440                       mov        byte ptr [rsp + 0x40], r15b
00ec82e2 eb05                             jmp        0x140ec82e9
00ec82e4 448b7c2440                       mov        r15d, dword ptr [rsp + 0x40]
00ec82e9 f60304                           test       byte ptr [rbx], 4
00ec82ec 44897c2438                       mov        dword ptr [rsp + 0x38], r15d
00ec82f1 0f848a000000                     je         0x140ec8381
00ec82f7 4584f6                           test       r14b, r14b
00ec82fa 7562                             jne        0x140ec835e
00ec82fc 6683bb0804000000                 cmp        word ptr [rbx + 0x408], 0
00ec8304 7505                             jne        0x140ec830b
00ec8306 4584e4                           test       r12b, r12b
00ec8309 7476                             je         0x140ec8381
00ec830b 33c9                             xor        ecx, ecx
00ec830d 0fb7c1                           movzx      eax, cx
00ec8310 66894d90                         mov        word ptr [rbp - 0x70], cx
00ec8314 488b4f10                         mov        rcx, qword ptr [rdi + 0x10]
00ec8318 4885c9                           test       rcx, rcx
00ec831b 741a                             je         0x140ec8337
00ec831d 8b97b4000000                     mov        edx, dword ptr [rdi + 0xb4]
00ec8323 4c8d4590                         lea        r8, [rbp - 0x70]
00ec8327 4881c108020000                   add        rcx, 0x208
00ec832e e83d71d3ff                       call       0x140bff470
00ec8333 0fb74590                         movzx      eax, word ptr [rbp - 0x70]
00ec8337 0fb79308040000                   movzx      edx, word ptr [rbx + 0x408]
00ec833e 488d8b0a040000                   lea        rcx, [rbx + 0x40a]
00ec8345 440fb7c8                         movzx      r9d, ax
00ec8349 4c8d4592                         lea        r8, [rbp - 0x6e]
00ec834d c744242020000000                 mov        dword ptr [rsp + 0x20], 0x20
00ec8355 e8e6cbc1ff                       call       0x140ae4f40
00ec835a 84c0                             test       al, al
00ec835c 7523                             jne        0x140ec8381
00ec835e 488d9308040000                   lea        rdx, [rbx + 0x408]
00ec8365 4533c0                           xor        r8d, r8d
00ec8368 488bcf                           mov        rcx, rdi
00ec836b e8c0940c00                       call       0x140f91830
00ec8370 83ce04                           or         esi, 4
00ec8373 4180cf08                         or         r15b, 8
00ec8377 44897c2438                       mov        dword ptr [rsp + 0x38], r15d
00ec837c 44887c2440                       mov        byte ptr [rsp + 0x40], r15b
00ec8381 f70300000040                     test       dword ptr [rbx], 0x40000000
00ec8387 0f8499000000                     je         0x140ec8426
00ec838d 4584f6                           test       r14b, r14b
00ec8390 756a                             jne        0x140ec83fc
00ec8392 6683bb5814000000                 cmp        word ptr [rbx + 0x1458], 0
00ec839a 7509                             jne        0x140ec83a5
00ec839c 4584e4                           test       r12b, r12b
00ec839f 0f8481000000                     je         0x140ec8426
00ec83a5 4533ff                           xor        r15d, r15d
00ec83a8 410fb7c7                         movzx      eax, r15w
00ec83ac 66894590                         mov        word ptr [rbp - 0x70], ax
00ec83b0 488b4f10                         mov        rcx, qword ptr [rdi + 0x10]
00ec83b4 4885c9                           test       rcx, rcx
00ec83b7 741a                             je         0x140ec83d3
00ec83b9 8b97b8000000                     mov        edx, dword ptr [rdi + 0xb8]
00ec83bf 4c8d4590                         lea        r8, [rbp - 0x70]
00ec83c3 4881c108020000                   add        rcx, 0x208
00ec83ca e8a170d3ff                       call       0x140bff470
00ec83cf 0fb74590                         movzx      eax, word ptr [rbp - 0x70]
00ec83d3 0fb79358140000                   movzx      edx, word ptr [rbx + 0x1458]
00ec83da 488d8b5a140000                   lea        rcx, [rbx + 0x145a]
00ec83e1 440fb7c8                         movzx      r9d, ax
00ec83e5 4c8d4592                         lea        r8, [rbp - 0x6e]
00ec83e9 c744242020000000                 mov        dword ptr [rsp + 0x20], 0x20
00ec83f1 e84acbc1ff                       call       0x140ae4f40
00ec83f6 84c0                             test       al, al
00ec83f8 752f                             jne        0x140ec8429
00ec83fa eb03                             jmp        0x140ec83ff
00ec83fc 4533ff                           xor        r15d, r15d
00ec83ff 488d9358140000                   lea        rdx, [rbx + 0x1458]
00ec8406 4533c0                           xor        r8d, r8d
00ec8409 488bcf                           mov        rcx, rdi
00ec840c e8df950c00                       call       0x140f919f0
00ec8411 0fb6442448                       movzx      eax, byte ptr [rsp + 0x48]
00ec8416 0fbaee1e                         bts        esi, 0x1e
00ec841a 0c01                             or         al, 1
00ec841c 89442470                         mov        dword ptr [rsp + 0x70], eax
00ec8420 88442448                         mov        byte ptr [rsp + 0x48], al
00ec8424 eb14                             jmp        0x140ec843a
00ec8426 4533ff                           xor        r15d, r15d
00ec8429 f30f6f442440                     movdqu     xmm0, xmmword ptr [rsp + 0x40]
00ec842f 660f73d808                       psrldq     xmm0, 8
00ec8434 660f7e442470                     movd       dword ptr [rsp + 0x70], xmm0
00ec843a f70300002000                     test       dword ptr [rbx], 0x200000
00ec8440 0f848d000000                     je         0x140ec84d3
00ec8446 4584f6                           test       r14b, r14b
00ec8449 7561                             jne        0x140ec84ac
00ec844b 6683bb4010000000                 cmp        word ptr [rbx + 0x1040], 0
00ec8453 7505                             jne        0x140ec845a
00ec8455 4584e4                           test       r12b, r12b
00ec8458 7479                             je         0x140ec84d3
00ec845a 410fb7c7                         movzx      eax, r15w
00ec845e 66894590                         mov        word ptr [rbp - 0x70], ax
00ec8462 488b4f10                         mov        rcx, qword ptr [rdi + 0x10]
00ec8466 4885c9                           test       rcx, rcx
00ec8469 741a                             je         0x140ec8485
00ec846b 8b97c4000000                     mov        edx, dword ptr [rdi + 0xc4]
00ec8471 4c8d4590                         lea        r8, [rbp - 0x70]
00ec8475 4881c108020000                   add        rcx, 0x208
00ec847c e8ef6fd3ff                       call       0x140bff470
00ec8481 0fb74590                         movzx      eax, word ptr [rbp - 0x70]
00ec8485 0fb79340100000                   movzx      edx, word ptr [rbx + 0x1040]
00ec848c 488d8b42100000                   lea        rcx, [rbx + 0x1042]
00ec8493 440fb7c8                         movzx      r9d, ax
00ec8497 4c8d4592                         lea        r8, [rbp - 0x6e]
00ec849b c744242020000000                 mov        dword ptr [rsp + 0x20], 0x20
00ec84a3 e898cac1ff                       call       0x140ae4f40
00ec84a8 84c0                             test       al, al
00ec84aa 7527                             jne        0x140ec84d3
00ec84ac 488d9340100000                   lea        rdx, [rbx + 0x1040]
00ec84b3 4533c0                           xor        r8d, r8d
00ec84b6 488bcf                           mov        rcx, rdi
00ec84b9 e8229d0c00                       call       0x140f921e0
00ec84be 0fb6442442                       movzx      eax, byte ptr [rsp + 0x42]
00ec84c3 0fbaee15                         bts        esi, 0x15
00ec84c7 0c20                             or         al, 0x20
00ec84c9 8944243c                         mov        dword ptr [rsp + 0x3c], eax
00ec84cd 88442442                         mov        byte ptr [rsp + 0x42], al
00ec84d1 eb11                             jmp        0x140ec84e4
00ec84d3 f30f6f442440                     movdqu     xmm0, xmmword ptr [rsp + 0x40]
00ec84d9 660f73d802                       psrldq     xmm0, 2
00ec84de 660f7e44243c                     movd       dword ptr [rsp + 0x3c], xmm0
00ec84e4 f60308                           test       byte ptr [rbx], 8
00ec84e7 0f8489000000                     je         0x140ec8576
00ec84ed 4584f6                           test       r14b, r14b
00ec84f0 7561                             jne        0x140ec8553
00ec84f2 6683bb0806000000                 cmp        word ptr [rbx + 0x608], 0
00ec84fa 7505                             jne        0x140ec8501
00ec84fc 4584e4                           test       r12b, r12b
00ec84ff 7475                             je         0x140ec8576
00ec8501 410fb7c7                         movzx      eax, r15w
00ec8505 66894590                         mov        word ptr [rbp - 0x70], ax
00ec8509 488b4f10                         mov        rcx, qword ptr [rdi + 0x10]
00ec850d 4885c9                           test       rcx, rcx
00ec8510 741a                             je         0x140ec852c
00ec8512 8b97bc000000                     mov        edx, dword ptr [rdi + 0xbc]
00ec8518 4c8d4590                         lea        r8, [rbp - 0x70]
00ec851c 4881c1c0010000                   add        rcx, 0x1c0
00ec8523 e8486fd3ff                       call       0x140bff470
00ec8528 0fb74590                         movzx      eax, word ptr [rbp - 0x70]
00ec852c 0fb79308060000                   movzx      edx, word ptr [rbx + 0x608]
00ec8533 488d8b0a060000                   lea        rcx, [rbx + 0x60a]
00ec853a 440fb7c8                         movzx      r9d, ax
00ec853e 4c8d4592                         lea        r8, [rbp - 0x6e]
00ec8542 c744242020000000                 mov        dword ptr [rsp + 0x20], 0x20
00ec854a e8f1c9c1ff                       call       0x140ae4f40
00ec854f 84c0                             test       al, al
00ec8551 7523                             jne        0x140ec8576
00ec8553 488d9308060000                   lea        rdx, [rbx + 0x608]
00ec855a 4533c0                           xor        r8d, r8d
00ec855d 488bcf                           mov        rcx, rdi
00ec8560 e84b960c00                       call       0x140f91bb0
00ec8565 8b442438                         mov        eax, dword ptr [rsp + 0x38]
00ec8569 83ce08                           or         esi, 8
00ec856c 0c10                             or         al, 0x10
00ec856e 89442438                         mov        dword ptr [rsp + 0x38], eax
00ec8572 88442440                         mov        byte ptr [rsp + 0x40], al
00ec8576 f70300000010                     test       dword ptr [rbx], 0x10000000
00ec857c 0f8499000000                     je         0x140ec861b
00ec8582 4584f6                           test       r14b, r14b
00ec8585 7565                             jne        0x140ec85ec
00ec8587 6683bb5412000000                 cmp        word ptr [rbx + 0x1254], 0
00ec858f 7509                             jne        0x140ec859a
00ec8591 4584e4                           test       r12b, r12b
00ec8594 0f8481000000                     je         0x140ec861b
00ec859a 410fb7c7                         movzx      eax, r15w
00ec859e 66894590                         mov        word ptr [rbp - 0x70], ax
00ec85a2 488b4f10                         mov        rcx, qword ptr [rdi + 0x10]
00ec85a6 4885c9                           test       rcx, rcx
00ec85a9 741a                             je         0x140ec85c5
00ec85ab 8b97c0000000                     mov        edx, dword ptr [rdi + 0xc0]
00ec85b1 4c8d4590                         lea        r8, [rbp - 0x70]
00ec85b5 4881c150020000                   add        rcx, 0x250
00ec85bc e8af6ed3ff                       call       0x140bff470
00ec85c1 0fb74590                         movzx      eax, word ptr [rbp - 0x70]
00ec85c5 0fb79354120000                   movzx      edx, word ptr [rbx + 0x1254]
00ec85cc 488d8b56120000                   lea        rcx, [rbx + 0x1256]
00ec85d3 440fb7c8                         movzx      r9d, ax
00ec85d7 4c8d4592                         lea        r8, [rbp - 0x6e]
00ec85db c744242020000000                 mov        dword ptr [rsp + 0x20], 0x20
00ec85e3 e858c9c1ff                       call       0x140ae4f40
00ec85e8 84c0                             test       al, al
00ec85ea 752f                             jne        0x140ec861b
00ec85ec 4c8d87c0000000                   lea        r8, [rdi + 0xc0]
00ec85f3 488d9354120000                   lea        rdx, [rbx + 0x1254]
00ec85fa 498d8d50020000                   lea        rcx, [r13 + 0x250]
00ec8601 e83a67d3ff                       call       0x140bfed40
00ec8606 440fb67c2444                     movzx      r15d, byte ptr [rsp + 0x44]
00ec860c 0fbaee1c                         bts        esi, 0x1c
00ec8610 4180cf01                         or         r15b, 1
00ec8614 44887c2444                       mov        byte ptr [rsp + 0x44], r15b
00ec8619 eb10                             jmp        0x140ec862b
00ec861b f30f6f442440                     movdqu     xmm0, xmmword ptr [rsp + 0x40]
00ec8621 660f73d804                       psrldq     xmm0, 4
00ec8626 66410f7ec7                       movd       r15d, xmm0
00ec862b f60310                           test       byte ptr [rbx], 0x10
00ec862e 0f848d000000                     je         0x140ec86c1
00ec8634 4584f6                           test       r14b, r14b
00ec8637 7562                             jne        0x140ec869b
00ec8639 6683bb0808000000                 cmp        word ptr [rbx + 0x808], 0
00ec8641 7505                             jne        0x140ec8648
00ec8643 4584e4                           test       r12b, r12b
00ec8646 7479                             je         0x140ec86c1
00ec8648 33c9                             xor        ecx, ecx
00ec864a 0fb7c1                           movzx      eax, cx
00ec864d 66894d90                         mov        word ptr [rbp - 0x70], cx
00ec8651 488b4f10                         mov        rcx, qword ptr [rdi + 0x10]
00ec8655 4885c9                           test       rcx, rcx
00ec8658 741a                             je         0x140ec8674
00ec865a 8b97c8000000                     mov        edx, dword ptr [rdi + 0xc8]
00ec8660 4c8d4590                         lea        r8, [rbp - 0x70]
00ec8664 4881c128030000                   add        rcx, 0x328
00ec866b e8006ed3ff                       call       0x140bff470
00ec8670 0fb74590                         movzx      eax, word ptr [rbp - 0x70]
00ec8674 0fb79308080000                   movzx      edx, word ptr [rbx + 0x808]
00ec867b 488d8b0a080000                   lea        rcx, [rbx + 0x80a]
00ec8682 440fb7c8                         movzx      r9d, ax
00ec8686 4c8d4592                         lea        r8, [rbp - 0x6e]
00ec868a c744242020000000                 mov        dword ptr [rsp + 0x20], 0x20
00ec8692 e8a9c8c1ff                       call       0x140ae4f40
00ec8697 84c0                             test       al, al
00ec8699 7526                             jne        0x140ec86c1
00ec869b 488d9308080000                   lea        rdx, [rbx + 0x808]
00ec86a2 4533c0                           xor        r8d, r8d
00ec86a5 488bcf                           mov        rcx, rdi
00ec86a8 e8a3480d00                       call       0x140f9cf50
00ec86ad 440fb66c2441                     movzx      r13d, byte ptr [rsp + 0x41]
00ec86b3 83ce10                           or         esi, 0x10
00ec86b6 4180cd80                         or         r13b, 0x80
00ec86ba 44886c2441                       mov        byte ptr [rsp + 0x41], r13b
00ec86bf eb10                             jmp        0x140ec86d1
00ec86c1 f30f6f442440                     movdqu     xmm0, xmmword ptr [rsp + 0x40]
00ec86c7 660f73d801                       psrldq     xmm0, 1
00ec86cc 66410f7ec5                       movd       r13d, xmm0
00ec86d1 f60320                           test       byte ptr [rbx], 0x20
00ec86d4 44896c2430                       mov        dword ptr [rsp + 0x30], r13d
00ec86d9 0f84a5000000                     je         0x140ec8784
00ec86df 80bf9a00000000                   cmp        byte ptr [rdi + 0x9a], 0
00ec86e6 0f8c98000000                     jl         0x140ec8784
00ec86ec 4584f6                           test       r14b, r14b
00ec86ef 7563                             jne        0x140ec8754
00ec86f1 6683bb080a000000                 cmp        word ptr [rbx + 0xa08], 0
00ec86f9 7509                             jne        0x140ec8704
00ec86fb 4584e4                           test       r12b, r12b
00ec86fe 0f8480000000                     je         0x140ec8784
00ec8704 33c0                             xor        eax, eax
00ec8706 66894590                         mov        word ptr [rbp - 0x70], ax
00ec870a 488b4f10                         mov        rcx, qword ptr [rdi + 0x10]
00ec870e 4885c9                           test       rcx, rcx
00ec8711 741a                             je         0x140ec872d
00ec8713 8b97cc000000                     mov        edx, dword ptr [rdi + 0xcc]
00ec8719 4c8d4590                         lea        r8, [rbp - 0x70]
00ec871d 4881c170030000                   add        rcx, 0x370
00ec8724 e8476dd3ff                       call       0x140bff470
00ec8729 0fb74590                         movzx      eax, word ptr [rbp - 0x70]
00ec872d 0fb793080a0000                   movzx      edx, word ptr [rbx + 0xa08]
00ec8734 488d8b0a0a0000                   lea        rcx, [rbx + 0xa0a]
00ec873b 440fb7c8                         movzx      r9d, ax
00ec873f 4c8d4592                         lea        r8, [rbp - 0x6e]
00ec8743 c744242020000000                 mov        dword ptr [rsp + 0x20], 0x20
00ec874b e8f0c7c1ff                       call       0x140ae4f40
00ec8750 84c0                             test       al, al
00ec8752 7530                             jne        0x140ec8784
00ec8754 488b4c2460                       mov        rcx, qword ptr [rsp + 0x60]
00ec8759 4c8d87cc000000                   lea        r8, [rdi + 0xcc]
00ec8760 4881c170030000                   add        rcx, 0x370
00ec8767 488d93080a0000                   lea        rdx, [rbx + 0xa08]
00ec876e e8cd65d3ff                       call       0x140bfed40
00ec8773 83ce20                           or         esi, 0x20
00ec8776 4180cd40                         or         r13b, 0x40
00ec877a 44896c2430                       mov        dword ptr [rsp + 0x30], r13d
00ec877f 44886c2441                       mov        byte ptr [rsp + 0x41], r13b
00ec8784 f70300020000                     test       dword ptr [rbx], 0x200
00ec878a 0f8499000000                     je         0x140ec8829
00ec8790 4584f6                           test       r14b, r14b
00ec8793 7563                             jne        0x140ec87f8
00ec8795 6683bb080c000000                 cmp        word ptr [rbx + 0xc08], 0
00ec879d 7509                             jne        0x140ec87a8
00ec879f 4584e4                           test       r12b, r12b
00ec87a2 0f8481000000                     je         0x140ec8829
00ec87a8 33c0                             xor        eax, eax
00ec87aa 66894590                         mov        word ptr [rbp - 0x70], ax
00ec87ae 488b4f10                         mov        rcx, qword ptr [rdi + 0x10]
00ec87b2 4885c9                           test       rcx, rcx
00ec87b5 741a                             je         0x140ec87d1
00ec87b7 8b97d0000000                     mov        edx, dword ptr [rdi + 0xd0]
00ec87bd 4c8d4590                         lea        r8, [rbp - 0x70]
00ec87c1 4881c1b8030000                   add        rcx, 0x3b8
00ec87c8 e8a36cd3ff                       call       0x140bff470
00ec87cd 0fb74590                         movzx      eax, word ptr [rbp - 0x70]
00ec87d1 0fb793080c0000                   movzx      edx, word ptr [rbx + 0xc08]
00ec87d8 488d8b0a0c0000                   lea        rcx, [rbx + 0xc0a]
00ec87df 440fb7c8                         movzx      r9d, ax
00ec87e3 4c8d4592                         lea        r8, [rbp - 0x6e]
00ec87e7 c744242020000000                 mov        dword ptr [rsp + 0x20], 0x20
00ec87ef e84cc7c1ff                       call       0x140ae4f40
00ec87f4 84c0                             test       al, al
00ec87f6 7531                             jne        0x140ec8829
00ec87f8 488b4c2460                       mov        rcx, qword ptr [rsp + 0x60]
00ec87fd 4c8d87d0000000                   lea        r8, [rdi + 0xd0]
00ec8804 4881c1b8030000                   add        rcx, 0x3b8
00ec880b 488d93080c0000                   lea        rdx, [rbx + 0xc08]
00ec8812 e82965d3ff                       call       0x140bfed40
00ec8817 8b44243c                         mov        eax, dword ptr [rsp + 0x3c]
00ec881b 0fbaee09                         bts        esi, 9
00ec881f 0c40                             or         al, 0x40
00ec8821 8944243c                         mov        dword ptr [rsp + 0x3c], eax
00ec8825 88442442                         mov        byte ptr [rsp + 0x42], al
00ec8829 f70300040000                     test       dword ptr [rbx], 0x400
00ec882f 0f8499000000                     je         0x140ec88ce
00ec8835 4584f6                           test       r14b, r14b
00ec8838 7563                             jne        0x140ec889d
00ec883a 6683bb080e000000                 cmp        word ptr [rbx + 0xe08], 0
00ec8842 7509                             jne        0x140ec884d
00ec8844 4584e4                           test       r12b, r12b
00ec8847 0f8481000000                     je         0x140ec88ce
00ec884d 33c0                             xor        eax, eax
00ec884f 66894590                         mov        word ptr [rbp - 0x70], ax
00ec8853 488b4f10                         mov        rcx, qword ptr [rdi + 0x10]
00ec8857 4885c9                           test       rcx, rcx
00ec885a 741a                             je         0x140ec8876
00ec885c 8b97d4000000                     mov        edx, dword ptr [rdi + 0xd4]
00ec8862 4c8d4590                         lea        r8, [rbp - 0x70]
00ec8866 4881c100040000                   add        rcx, 0x400
00ec886d e8fe6bd3ff                       call       0x140bff470
00ec8872 0fb74590                         movzx      eax, word ptr [rbp - 0x70]
00ec8876 0fb793080e0000                   movzx      edx, word ptr [rbx + 0xe08]
00ec887d 488d8b0a0e0000                   lea        rcx, [rbx + 0xe0a]
00ec8884 440fb7c8                         movzx      r9d, ax
00ec8888 4c8d4592                         lea        r8, [rbp - 0x6e]
00ec888c c744242020000000                 mov        dword ptr [rsp + 0x20], 0x20
00ec8894 e8a7c6c1ff                       call       0x140ae4f40
00ec8899 84c0                             test       al, al
00ec889b 7531                             jne        0x140ec88ce
00ec889d 488b4c2460                       mov        rcx, qword ptr [rsp + 0x60]
00ec88a2 4c8d87d4000000                   lea        r8, [rdi + 0xd4]
00ec88a9 4881c100040000                   add        rcx, 0x400
00ec88b0 488d93080e0000                   lea        rdx, [rbx + 0xe08]
00ec88b7 e88464d3ff                       call       0x140bfed40
00ec88bc 0fbaee0a                         bts        esi, 0xa
00ec88c0 4180cd02                         or         r13b, 2
00ec88c4 44896c2430                       mov        dword ptr [rsp + 0x30], r13d
00ec88c9 44886c2441                       mov        byte ptr [rsp + 0x41], r13b
00ec88ce f60340                           test       byte ptr [rbx], 0x40
00ec88d1 0f8488000000                     je         0x140ec895f
00ec88d7 4584f6                           test       r14b, r14b
00ec88da 7517                             jne        0x140ec88f3
00ec88dc 4584e4                           test       r12b, r12b
00ec88df 7512                             jne        0x140ec88f3
00ec88e1 83bb0810000000                   cmp        dword ptr [rbx + 0x1008], 0
00ec88e8 7509                             jne        0x140ec88f3
00ec88ea 83bb0c10000000                   cmp        dword ptr [rbx + 0x100c], 0
00ec88f1 746c                             je         0x140ec895f
00ec88f3 8b8b08100000                     mov        ecx, dword ptr [rbx + 0x1008]
00ec88f9 0fb7d1                           movzx      edx, cx
00ec88fc 0fb7870a010000                   movzx      eax, word ptr [rdi + 0x10a]
00ec8903 3bc1                             cmp        eax, ecx
00ec8905 7514                             jne        0x140ec891b
00ec8907 0fb7870c010000                   movzx      eax, word ptr [rdi + 0x10c]
00ec890e 3b830c100000                     cmp        eax, dword ptr [rbx + 0x100c]
00ec8914 7505                             jne        0x140ec891b
00ec8916 4584f6                           test       r14b, r14b
00ec8919 7444                             je         0x140ec895f
00ec891b 6689970a010000                   mov        word ptr [rdi + 0x10a], dx
00ec8922 8b8b0c100000                     mov        ecx, dword ptr [rbx + 0x100c]
00ec8928 0fb7c2                           movzx      eax, dx
00ec892b ba00000000                       mov        edx, 0
00ec8930 3bc8                             cmp        ecx, eax
00ec8932 660f42ca                         cmovb      cx, dx
00ec8936 4180cd10                         or         r13b, 0x10
00ec893a 66898f0c010000                   mov        word ptr [rdi + 0x10c], cx
00ec8941 83ce40                           or         esi, 0x40
00ec8944 44896c2430                       mov        dword ptr [rsp + 0x30], r13d
00ec8949 44886c2441                       mov        byte ptr [rsp + 0x41], r13b
00ec894e 440fb66c2446                     movzx      r13d, byte ptr [rsp + 0x46]
00ec8954 4180cd08                         or         r13b, 8
00ec8958 44886c2446                       mov        byte ptr [rsp + 0x46], r13b
00ec895d eb12                             jmp        0x140ec8971
00ec895f f30f6f442440                     movdqu     xmm0, xmmword ptr [rsp + 0x40]
00ec8965 33d2                             xor        edx, edx
00ec8967 660f73d806                       psrldq     xmm0, 6
00ec896c 66410f7ec5                       movd       r13d, xmm0
00ec8971 f70300008000                     test       dword ptr [rbx], 0x800000
00ec8977 747d                             je         0x140ec89f6
00ec8979 4584f6                           test       r14b, r14b
00ec897c 7519                             jne        0x140ec8997
00ec897e 4584e4                           test       r12b, r12b
00ec8981 7514                             jne        0x140ec8997
00ec8983 6683bb4412000000                 cmp        word ptr [rbx + 0x1244], 0
00ec898b 750a                             jne        0x140ec8997
00ec898d 6683bb4612000000                 cmp        word ptr [rbx + 0x1246], 0
00ec8995 745f                             je         0x140ec89f6
00ec8997 0fb78b44120000                   movzx      ecx, word ptr [rbx + 0x1244]
00ec899e 66398f0e010000                   cmp        word ptr [rdi + 0x10e], cx
00ec89a5 7515                             jne        0x140ec89bc
00ec89a7 0fb78346120000                   movzx      eax, word ptr [rbx + 0x1246]
00ec89ae 66398710010000                   cmp        word ptr [rdi + 0x110], ax
00ec89b5 7505                             jne        0x140ec89bc
00ec89b7 4584f6                           test       r14b, r14b
00ec89ba 743a                             je         0x140ec89f6
00ec89bc 66898f0e010000                   mov        word ptr [rdi + 0x10e], cx
00ec89c3 0fb78346120000                   movzx      eax, word ptr [rbx + 0x1246]
00ec89ca 663bc1                           cmp        ax, cx
00ec89cd 660f42c2                         cmovb      ax, dx
00ec89d1 0fbaee17                         bts        esi, 0x17
00ec89d5 66898710010000                   mov        word ptr [rdi + 0x110], ax
00ec89dc 0fb6442443                       movzx      eax, byte ptr [rsp + 0x43]
00ec89e1 0c80                             or         al, 0x80
00ec89e3 4180cd40                         or         r13b, 0x40
00ec89e7 89442460                         mov        dword ptr [rsp + 0x60], eax
00ec89eb 44886c2446                       mov        byte ptr [rsp + 0x46], r13b
00ec89f0 88442443                         mov        byte ptr [rsp + 0x43], al
00ec89f4 eb11                             jmp        0x140ec8a07
00ec89f6 f30f6f442440                     movdqu     xmm0, xmmword ptr [rsp + 0x40]
00ec89fc 660f73d803                       psrldq     xmm0, 3
00ec8a01 660f7e442460                     movd       dword ptr [rsp + 0x60], xmm0
00ec8a07 f60380                           test       byte ptr [rbx], 0x80
00ec8a0a 7442                             je         0x140ec8a4e
00ec8a0c 4584f6                           test       r14b, r14b
00ec8a0f 750f                             jne        0x140ec8a20
00ec8a11 4584e4                           test       r12b, r12b
00ec8a14 750a                             jne        0x140ec8a20
00ec8a16 6683bb1010000000                 cmp        word ptr [rbx + 0x1010], 0
00ec8a1e 742e                             je         0x140ec8a4e
00ec8a20 0fb78310100000                   movzx      eax, word ptr [rbx + 0x1010]
00ec8a27 663987a6000000                   cmp        word ptr [rdi + 0xa6], ax
00ec8a2e 7505                             jne        0x140ec8a35
00ec8a30 4584f6                           test       r14b, r14b
00ec8a33 7419                             je         0x140ec8a4e
00ec8a35 668987a6000000                   mov        word ptr [rdi + 0xa6], ax
00ec8a3c 0fbaee07                         bts        esi, 7
00ec8a40 8b442438                         mov        eax, dword ptr [rsp + 0x38]
00ec8a44 0c01                             or         al, 1
00ec8a46 89442438                         mov        dword ptr [rsp + 0x38], eax
00ec8a4a 88442440                         mov        byte ptr [rsp + 0x40], al
00ec8a4e f70300000008                     test       dword ptr [rbx], 0x8000000
00ec8a54 743d                             je         0x140ec8a93
00ec8a56 4584f6                           test       r14b, r14b
00ec8a59 750f                             jne        0x140ec8a6a
00ec8a5b 4584e4                           test       r12b, r12b
00ec8a5e 750a                             jne        0x140ec8a6a
00ec8a60 6683bb5012000000                 cmp        word ptr [rbx + 0x1250], 0
00ec8a68 7429                             je         0x140ec8a93
00ec8a6a 0fb78350120000                   movzx      eax, word ptr [rbx + 0x1250]
00ec8a71 6639872c010000                   cmp        word ptr [rdi + 0x12c], ax
00ec8a78 7505                             jne        0x140ec8a7f
00ec8a7a 4584f6                           test       r14b, r14b
00ec8a7d 7414                             je         0x140ec8a93
00ec8a7f 0fbaee1b                         bts        esi, 0x1b
00ec8a83 6689872c010000                   mov        word ptr [rdi + 0x12c], ax
00ec8a8a 4180cf10                         or         r15b, 0x10
00ec8a8e 44887c2444                       mov        byte ptr [rsp + 0x44], r15b
00ec8a93 f70300000002                     test       dword ptr [rbx], 0x2000000
00ec8a99 743d                             je         0x140ec8ad8
00ec8a9b 4584f6                           test       r14b, r14b
00ec8a9e 750e                             jne        0x140ec8aae
00ec8aa0 4584e4                           test       r12b, r12b
00ec8aa3 7509                             jne        0x140ec8aae
00ec8aa5 83bb4812000000                   cmp        dword ptr [rbx + 0x1248], 0
00ec8aac 742a                             je         0x140ec8ad8
00ec8aae 8b8348120000                     mov        eax, dword ptr [rbx + 0x1248]
00ec8ab4 398714010000                     cmp        dword ptr [rdi + 0x114], eax
00ec8aba 7505                             jne        0x140ec8ac1
00ec8abc 4584f6                           test       r14b, r14b
00ec8abf 7417                             je         0x140ec8ad8
00ec8ac1 8b4c243c                         mov        ecx, dword ptr [rsp + 0x3c]
00ec8ac5 0fbaee19                         bts        esi, 0x19
00ec8ac9 80c902                           or         cl, 2
00ec8acc 898714010000                     mov        dword ptr [rdi + 0x114], eax
00ec8ad2 884c2442                         mov        byte ptr [rsp + 0x42], cl
00ec8ad6 eb04                             jmp        0x140ec8adc
00ec8ad8 8b4c243c                         mov        ecx, dword ptr [rsp + 0x3c]
00ec8adc f70300000004                     test       dword ptr [rbx], 0x4000000
00ec8ae2 7437                             je         0x140ec8b1b
00ec8ae4 4584f6                           test       r14b, r14b
00ec8ae7 750e                             jne        0x140ec8af7
00ec8ae9 4584e4                           test       r12b, r12b
00ec8aec 7509                             jne        0x140ec8af7
00ec8aee 83bb4c12000000                   cmp        dword ptr [rbx + 0x124c], 0
00ec8af5 7424                             je         0x140ec8b1b
00ec8af7 8b834c120000                     mov        eax, dword ptr [rbx + 0x124c]
00ec8afd 39871c010000                     cmp        dword ptr [rdi + 0x11c], eax
00ec8b03 7505                             jne        0x140ec8b0a
00ec8b05 4584f6                           test       r14b, r14b
00ec8b08 7411                             je         0x140ec8b1b
00ec8b0a 0fbaee1a                         bts        esi, 0x1a
00ec8b0e 89871c010000                     mov        dword ptr [rdi + 0x11c], eax
00ec8b14 80c901                           or         cl, 1
00ec8b17 884c2442                         mov        byte ptr [rsp + 0x42], cl
00ec8b1b f70300000800                     test       dword ptr [rbx], 0x80000
00ec8b21 7440                             je         0x140ec8b63
00ec8b23 4584f6                           test       r14b, r14b
00ec8b26 750e                             jne        0x140ec8b36
00ec8b28 4584e4                           test       r12b, r12b
00ec8b2b 7509                             jne        0x140ec8b36
00ec8b2d 83bb2010000000                   cmp        dword ptr [rbx + 0x1020], 0
00ec8b34 742d                             je         0x140ec8b63
00ec8b36 488b542468                       mov        rdx, qword ptr [rsp + 0x68]
00ec8b3b 8b8320100000                     mov        eax, dword ptr [rbx + 0x1020]
00ec8b41 394254                           cmp        dword ptr [rdx + 0x54], eax
00ec8b44 7505                             jne        0x140ec8b4b
00ec8b46 4584f6                           test       r14b, r14b
00ec8b49 741d                             je         0x140ec8b68
00ec8b4b 8b4c2430                         mov        ecx, dword ptr [rsp + 0x30]
00ec8b4f 0fbaee13                         bts        esi, 0x13
00ec8b53 80c920                           or         cl, 0x20
00ec8b56 894254                           mov        dword ptr [rdx + 0x54], eax
00ec8b59 894c2430                         mov        dword ptr [rsp + 0x30], ecx
00ec8b5d 884c2441                         mov        byte ptr [rsp + 0x41], cl
00ec8b61 eb09                             jmp        0x140ec8b6c
00ec8b63 488b542468                       mov        rdx, qword ptr [rsp + 0x68]
00ec8b68 8b4c2430                         mov        ecx, dword ptr [rsp + 0x30]
00ec8b6c f70300010000                     test       dword ptr [rbx], 0x100
00ec8b72 7445                             je         0x140ec8bb9
00ec8b74 4584f6                           test       r14b, r14b
00ec8b77 750f                             jne        0x140ec8b88
00ec8b79 4584e4                           test       r12b, r12b
00ec8b7c 750a                             jne        0x140ec8b88
00ec8b7e 6683bb1210000000                 cmp        word ptr [rbx + 0x1012], 0
00ec8b86 7431                             je         0x140ec8bb9
00ec8b88 0fb78312100000                   movzx      eax, word ptr [rbx + 0x1012]
00ec8b8f 66398702010000                   cmp        word ptr [rdi + 0x102], ax
00ec8b96 7505                             jne        0x140ec8b9d
00ec8b98 4584f6                           test       r14b, r14b
00ec8b9b 741c                             je         0x140ec8bb9
00ec8b9d 440fb6642449                     movzx      r12d, byte ptr [rsp + 0x49]
00ec8ba3 0fbaee08                         bts        esi, 8
00ec8ba7 4180cc20                         or         r12b, 0x20
00ec8bab 66898702010000                   mov        word ptr [rdi + 0x102], ax
00ec8bb2 4488642449                       mov        byte ptr [rsp + 0x49], r12b
00ec8bb7 eb10                             jmp        0x140ec8bc9
00ec8bb9 f30f6f442440                     movdqu     xmm0, xmmword ptr [rsp + 0x40]
00ec8bbf 660f73d809                       psrldq     xmm0, 9
00ec8bc4 66410f7ec4                       movd       r12d, xmm0
00ec8bc9 f70300080000                     test       dword ptr [rbx], 0x800
00ec8bcf 7437                             je         0x140ec8c08
00ec8bd1 4584f6                           test       r14b, r14b
00ec8bd4 7510                             jne        0x140ec8be6
00ec8bd6 4438742434                       cmp        byte ptr [rsp + 0x34], r14b
00ec8bdb 7509                             jne        0x140ec8be6
00ec8bdd 83bb1410000000                   cmp        dword ptr [rbx + 0x1014], 0
00ec8be4 7422                             je         0x140ec8c08
00ec8be6 8b8314100000                     mov        eax, dword ptr [rbx + 0x1014]
00ec8bec 39425c                           cmp        dword ptr [rdx + 0x5c], eax
00ec8bef 7505                             jne        0x140ec8bf6
00ec8bf1 4584f6                           test       r14b, r14b
00ec8bf4 7412                             je         0x140ec8c08
00ec8bf6 0fbaee0b                         bts        esi, 0xb
00ec8bfa 89425c                           mov        dword ptr [rdx + 0x5c], eax
00ec8bfd 80c904                           or         cl, 4
00ec8c00 894c2430                         mov        dword ptr [rsp + 0x30], ecx
00ec8c04 884c2441                         mov        byte ptr [rsp + 0x41], cl
00ec8c08 33c9                             xor        ecx, ecx
00ec8c0a f70300100000                     test       dword ptr [rbx], 0x1000
00ec8c10 744e                             je         0x140ec8c60
00ec8c12 8b8318100000                     mov        eax, dword ptr [rbx + 0x1018]
00ec8c18 448bf9                           mov        r15d, ecx
00ec8c1b 3b425c                           cmp        eax, dword ptr [rdx + 0x5c]
00ec8c1e 440f46f8                         cmovbe     r15d, eax
00ec8c22 4584f6                           test       r14b, r14b
00ec8c25 750b                             jne        0x140ec8c32
00ec8c27 384c2434                         cmp        byte ptr [rsp + 0x34], cl
00ec8c2b 7505                             jne        0x140ec8c32
00ec8c2d 4585ff                           test       r15d, r15d
00ec8c30 742e                             je         0x140ec8c60
00ec8c32 488b4778                         mov        rax, qword ptr [rdi + 0x78]
00ec8c36 44397804                         cmp        dword ptr [rax + 4], r15d
00ec8c3a 7505                             jne        0x140ec8c41
00ec8c3c 4584f6                           test       r14b, r14b
00ec8c3f 741f                             je         0x140ec8c60
00ec8c41 488bcf                           mov        rcx, rdi
00ec8c44 e887a30c00                       call       0x140f92fd0
00ec8c49 488b4778                         mov        rax, qword ptr [rdi + 0x78]
00ec8c4d 4180cd20                         or         r13b, 0x20
00ec8c51 0fbaee0c                         bts        esi, 0xc
00ec8c55 44886c2446                       mov        byte ptr [rsp + 0x46], r13b
00ec8c5a 33c9                             xor        ecx, ecx
00ec8c5c 44897804                         mov        dword ptr [rax + 4], r15d
00ec8c60 f70300200000                     test       dword ptr [rbx], 0x2000
00ec8c66 4c8b442468                       mov        r8, qword ptr [rsp + 0x68]
00ec8c6b 7454                             je         0x140ec8cc1
00ec8c6d 8b831c100000                     mov        eax, dword ptr [rbx + 0x101c]
00ec8c73 413b405c                         cmp        eax, dword ptr [r8 + 0x5c]
00ec8c77 0f46c8                           cmovbe     ecx, eax
00ec8c7a 894c243c                         mov        dword ptr [rsp + 0x3c], ecx
00ec8c7e 4584f6                           test       r14b, r14b
00ec8c81 750b                             jne        0x140ec8c8e
00ec8c83 4438742434                       cmp        byte ptr [rsp + 0x34], r14b
00ec8c88 7504                             jne        0x140ec8c8e
00ec8c8a 85c9                             test       ecx, ecx
00ec8c8c 7433                             je         0x140ec8cc1
00ec8c8e 488b4778                         mov        rax, qword ptr [rdi + 0x78]
00ec8c92 394808                           cmp        dword ptr [rax + 8], ecx
00ec8c95 7505                             jne        0x140ec8c9c
00ec8c97 4584f6                           test       r14b, r14b
00ec8c9a 7425                             je         0x140ec8cc1
00ec8c9c 488bcf                           mov        rcx, rdi
00ec8c9f e82ca30c00                       call       0x140f92fd0
00ec8ca4 488b4778                         mov        rax, qword ptr [rdi + 0x78]
00ec8ca8 0fbaee0d                         bts        esi, 0xd
00ec8cac 8b4c243c                         mov        ecx, dword ptr [rsp + 0x3c]
00ec8cb0 4180cd10                         or         r13b, 0x10
00ec8cb4 4c8b442468                       mov        r8, qword ptr [rsp + 0x68]
00ec8cb9 44886c2446                       mov        byte ptr [rsp + 0x46], r13b
00ec8cbe 894808                           mov        dword ptr [rax + 8], ecx
00ec8cc1 f70300400000                     test       dword ptr [rbx], 0x4000
00ec8cc7 7446                             je         0x140ec8d0f
00ec8cc9 488b8358160000                   mov        rax, qword ptr [rbx + 0x1658]
00ec8cd0 4885c0                           test       rax, rax
00ec8cd3 7506                             jne        0x140ec8cdb
00ec8cd5 8b8324100000                     mov        eax, dword ptr [rbx + 0x1024]
00ec8cdb 4584f6                           test       r14b, r14b
00ec8cde 750c                             jne        0x140ec8cec
00ec8ce0 4438742434                       cmp        byte ptr [rsp + 0x34], r14b
00ec8ce5 7505                             jne        0x140ec8cec
00ec8ce7 4885c0                           test       rax, rax
00ec8cea 7423                             je         0x140ec8d0f
00ec8cec 49394060                         cmp        qword ptr [r8 + 0x60], rax
00ec8cf0 7505                             jne        0x140ec8cf7
00ec8cf2 4584f6                           test       r14b, r14b
00ec8cf5 7418                             je         0x140ec8d0f
00ec8cf7 448b6c2430                       mov        r13d, dword ptr [rsp + 0x30]
00ec8cfc 0fbaee0e                         bts        esi, 0xe
00ec8d00 4180cd08                         or         r13b, 8
00ec8d04 49894060                         mov        qword ptr [r8 + 0x60], rax
00ec8d08 44886c2441                       mov        byte ptr [rsp + 0x41], r13b
00ec8d0d eb05                             jmp        0x140ec8d14
00ec8d0f 448b6c2430                       mov        r13d, dword ptr [rsp + 0x30]
00ec8d14 f70300800000                     test       dword ptr [rbx], 0x8000
00ec8d1a 7444                             je         0x140ec8d60
00ec8d1c 4584f6                           test       r14b, r14b
00ec8d1f 7511                             jne        0x140ec8d32
00ec8d21 8b4c2434                         mov        ecx, dword ptr [rsp + 0x34]
00ec8d25 84c9                             test       cl, cl
00ec8d27 7509                             jne        0x140ec8d32
00ec8d29 83bb2810000000                   cmp        dword ptr [rbx + 0x1028], 0
00ec8d30 7432                             je         0x140ec8d64
00ec8d32 410fb7404c                       movzx      eax, word ptr [r8 + 0x4c]
00ec8d37 8b8b28100000                     mov        ecx, dword ptr [rbx + 0x1028]
00ec8d3d 3bc1                             cmp        eax, ecx
00ec8d3f 7505                             jne        0x140ec8d46
00ec8d41 4584f6                           test       r14b, r14b
00ec8d44 741a                             je         0x140ec8d60
00ec8d46 8b542438                         mov        edx, dword ptr [rsp + 0x38]
00ec8d4a 0fbaee0f                         bts        esi, 0xf
00ec8d4e 80ca04                           or         dl, 4
00ec8d51 664189484c                       mov        word ptr [r8 + 0x4c], cx
00ec8d56 8b4c2434                         mov        ecx, dword ptr [rsp + 0x34]
00ec8d5a 88542440                         mov        byte ptr [rsp + 0x40], dl
00ec8d5e eb08                             jmp        0x140ec8d68
00ec8d60 8b4c2434                         mov        ecx, dword ptr [rsp + 0x34]
00ec8d64 8b542438                         mov        edx, dword ptr [rsp + 0x38]
00ec8d68 f70300000100                     test       dword ptr [rbx], 0x10000
00ec8d6e 745b                             je         0x140ec8dcb
00ec8d70 f30f108b54140000                 movss      xmm1, dword ptr [rbx + 0x1454]
00ec8d78 0f57c0                           xorps      xmm0, xmm0
00ec8d7b 0f2ec8                           ucomiss    xmm1, xmm0
00ec8d7e 7a18                             jp         0x140ec8d98
00ec8d80 7516                             jne        0x140ec8d98
00ec8d82 8b832c100000                     mov        eax, dword ptr [rbx + 0x102c]
00ec8d88 0f57c9                           xorps      xmm1, xmm1
00ec8d8b f3480f2ac8                       cvtsi2ss   xmm1, rax
00ec8d90 f30f590d3ca2da00                 mulss      xmm1, dword ptr [rip + 0xdaa23c]
00ec8d98 4584f6                           test       r14b, r14b
00ec8d9b 750b                             jne        0x140ec8da8
00ec8d9d 84c9                             test       cl, cl
00ec8d9f 7507                             jne        0x140ec8da8
00ec8da1 0f2ec8                           ucomiss    xmm1, xmm0
00ec8da4 7a02                             jp         0x140ec8da8
00ec8da6 7423                             je         0x140ec8dcb
00ec8da8 f3410f104048                     movss      xmm0, dword ptr [r8 + 0x48]
00ec8dae 0f2ec1                           ucomiss    xmm0, xmm1
00ec8db1 7a07                             jp         0x140ec8dba
00ec8db3 7505                             jne        0x140ec8dba
00ec8db5 4584f6                           test       r14b, r14b
00ec8db8 7411                             je         0x140ec8dcb
00ec8dba 0fbaee10                         bts        esi, 0x10
00ec8dbe f3410f114848                     movss      dword ptr [r8 + 0x48], xmm1
00ec8dc4 80ca02                           or         dl, 2
00ec8dc7 88542440                         mov        byte ptr [rsp + 0x40], dl
00ec8dcb f70300000200                     test       dword ptr [rbx], 0x20000
00ec8dd1 7455                             je         0x140ec8e28
00ec8dd3 448b9b3c100000                   mov        r11d, dword ptr [rbx + 0x103c]
00ec8dda 498bc8                           mov        rcx, r8
00ec8ddd e81e020e00                       call       0x140fa9000
00ec8de2 8b9338100000                     mov        edx, dword ptr [rbx + 0x1038]
00ec8de8 4123c3                           and        eax, r11d
00ec8deb 448b7c2434                       mov        r15d, dword ptr [rsp + 0x34]
00ec8df0 8bca                             mov        ecx, edx
00ec8df2 4123cb                           and        ecx, r11d
00ec8df5 4584f6                           test       r14b, r14b
00ec8df8 7509                             jne        0x140ec8e03
00ec8dfa 4584ff                           test       r15b, r15b
00ec8dfd 7504                             jne        0x140ec8e03
00ec8dff 85c9                             test       ecx, ecx
00ec8e01 742a                             je         0x140ec8e2d
00ec8e03 3bc1                             cmp        eax, ecx
00ec8e05 7505                             jne        0x140ec8e0c
00ec8e07 4584f6                           test       r14b, r14b
00ec8e0a 7421                             je         0x140ec8e2d
00ec8e0c 488b4c2468                       mov        rcx, qword ptr [rsp + 0x68]
00ec8e11 458bc3                           mov        r8d, r11d
00ec8e14 e8a7020e00                       call       0x140fa90c0
00ec8e19 0fbaee11                         bts        esi, 0x11
00ec8e1d 4180cc10                         or         r12b, 0x10
00ec8e21 4488642449                       mov        byte ptr [rsp + 0x49], r12b
00ec8e26 eb05                             jmp        0x140ec8e2d
00ec8e28 448b7c2434                       mov        r15d, dword ptr [rsp + 0x34]
00ec8e2d f70300000400                     test       dword ptr [rbx], 0x40000
00ec8e33 746c                             je         0x140ec8ea1
00ec8e35 488b4c2468                       mov        rcx, qword ptr [rsp + 0x68]
00ec8e3a 8b4134                           mov        eax, dword ptr [rcx + 0x34]
00ec8e3d 3d4c4e5744                       cmp        eax, 0x44574e4c
00ec8e42 7417                             je         0x140ec8e5b
00ec8e44 3d454c4946                       cmp        eax, 0x46494c45
00ec8e49 7407                             je         0x140ec8e52
00ec8e4b 3d4c49464d                       cmp        eax, 0x4d46494c
00ec8e50 754f                             jne        0x140ec8ea1
00ec8e52 488d819c020000                   lea        rax, [rcx + 0x29c]
00ec8e59 eb14                             jmp        0x140ec8e6f
00ec8e5b 4883c178                         add        rcx, 0x78
00ec8e5f e8acee0300                       call       0x140f07d10
00ec8e64 4885c0                           test       rax, rax
00ec8e67 7438                             je         0x140ec8ea1
00ec8e69 480520020000                     add        rax, 0x220
00ec8e6f 4885c0                           test       rax, rax
00ec8e72 742d                             je         0x140ec8ea1
00ec8e74 4584f6                           test       r14b, r14b
00ec8e77 750a                             jne        0x140ec8e83
00ec8e79 4584ff                           test       r15b, r15b
00ec8e7c 7505                             jne        0x140ec8e83
00ec8e7e 833800                           cmp        dword ptr [rax], 0
00ec8e81 741e                             je         0x140ec8ea1
00ec8e83 8b8b30100000                     mov        ecx, dword ptr [rbx + 0x1030]
00ec8e89 3908                             cmp        dword ptr [rax], ecx
00ec8e8b 7505                             jne        0x140ec8e92
00ec8e8d 4584f6                           test       r14b, r14b
00ec8e90 740f                             je         0x140ec8ea1
00ec8e92 0fbaee12                         bts        esi, 0x12
00ec8e96 8908                             mov        dword ptr [rax], ecx
00ec8e98 4180cd01                         or         r13b, 1
00ec8e9c 44886c2441                       mov        byte ptr [rsp + 0x41], r13b
00ec8ea1 f70300004000                     test       dword ptr [rbx], 0x400000
00ec8ea7 7443                             je         0x140ec8eec
00ec8ea9 0fb6979b000000                   movzx      edx, byte ptr [rdi + 0x9b]
00ec8eb0 0fb68b40120000                   movzx      ecx, byte ptr [rbx + 0x1240]
00ec8eb7 0fb6c2                           movzx      eax, dl
00ec8eba c0e802                           shr        al, 2
00ec8ebd 2401                             and        al, 1
00ec8ebf 3ac1                             cmp        al, cl
00ec8ec1 7505                             jne        0x140ec8ec8
00ec8ec3 4584f6                           test       r14b, r14b
00ec8ec6 7424                             je         0x140ec8eec
00ec8ec8 448b7c2460                       mov        r15d, dword ptr [rsp + 0x60]
00ec8ecd 0fbaee16                         bts        esi, 0x16
00ec8ed1 c0e102                           shl        cl, 2
00ec8ed4 32ca                             xor        cl, dl
00ec8ed6 80e104                           and        cl, 4
00ec8ed9 32ca                             xor        cl, dl
00ec8edb 4180cf01                         or         r15b, 1
00ec8edf 888f9b000000                     mov        byte ptr [rdi + 0x9b], cl
00ec8ee5 44887c2443                       mov        byte ptr [rsp + 0x43], r15b
00ec8eea eb05                             jmp        0x140ec8ef1
00ec8eec 448b7c2460                       mov        r15d, dword ptr [rsp + 0x60]
00ec8ef1 f70300000020                     test       dword ptr [rbx], 0x20000000
00ec8ef7 7439                             je         0x140ec8f32
00ec8ef9 0fb68f9c000000                   movzx      ecx, byte ptr [rdi + 0x9c]
00ec8f00 0fb69341120000                   movzx      edx, byte ptr [rbx + 0x1241]
00ec8f07 0fb6c1                           movzx      eax, cl
00ec8f0a 2401                             and        al, 1
00ec8f0c 3ac2                             cmp        al, dl
00ec8f0e 7505                             jne        0x140ec8f15
00ec8f10 4584f6                           test       r14b, r14b
00ec8f13 741d                             je         0x140ec8f32
00ec8f15 0fb6c1                           movzx      eax, cl
00ec8f18 0fbaee1d                         bts        esi, 0x1d
00ec8f1c 32c2                             xor        al, dl
00ec8f1e 2401                             and        al, 1
00ec8f20 32c1                             xor        al, cl
00ec8f22 88879c000000                     mov        byte ptr [rdi + 0x9c], al
00ec8f28 8b442470                         mov        eax, dword ptr [rsp + 0x70]
00ec8f2c 0c02                             or         al, 2
00ec8f2e 88442448                         mov        byte ptr [rsp + 0x48], al
00ec8f32 f70300000001                     test       dword ptr [rbx], 0x1000000
00ec8f38 7469                             je         0x140ec8fa3
00ec8f3a 0fb79342120000                   movzx      edx, word ptr [rbx + 0x1242]
00ec8f41 b864000000                       mov        eax, 0x64
00ec8f46 3bd0                             cmp        edx, eax
00ec8f48 0f47d0                           cmova      edx, eax
00ec8f4b 4584f6                           test       r14b, r14b
00ec8f4e 750b                             jne        0x140ec8f5b
00ec8f50 4438742434                       cmp        byte ptr [rsp + 0x34], r14b
00ec8f55 7504                             jne        0x140ec8f5b
00ec8f57 85d2                             test       edx, edx
00ec8f59 7448                             je         0x140ec8fa3
00ec8f5b 488b4f10                         mov        rcx, qword ptr [rdi + 0x10]
00ec8f5f 0fb68705010000                   movzx      eax, byte ptr [rdi + 0x105]
00ec8f66 4885c9                           test       rcx, rcx
00ec8f69 7454                             je         0x140ec8fbf
00ec8f6b f6811401000008                   test       byte ptr [rcx + 0x114], 8
00ec8f72 744b                             je         0x140ec8fbf
00ec8f74 3c20                             cmp        al, 0x20
00ec8f76 7353                             jae        0x140ec8fcb
00ec8f78 0fb68704010000                   movzx      eax, byte ptr [rdi + 0x104]
00ec8f7f 0fbec0                           movsx      eax, al
00ec8f82 3bc2                             cmp        eax, edx
00ec8f84 7505                             jne        0x140ec8f8b
00ec8f86 4584f6                           test       r14b, r14b
00ec8f89 7418                             je         0x140ec8fa3
00ec8f8b 4533c0                           xor        r8d, r8d
00ec8f8e 488bcf                           mov        rcx, rdi
00ec8f91 e8da100100                       call       0x140eda070
00ec8f96 0fbaee18                         bts        esi, 0x18
00ec8f9a 4180cf40                         or         r15b, 0x40
00ec8f9e 44887c2443                       mov        byte ptr [rsp + 0x43], r15b
00ec8fa3 4c8b7c2478                       mov        r15, qword ptr [rsp + 0x78]
00ec8fa8 488b4580                         mov        rax, qword ptr [rbp - 0x80]
00ec8fac 4885c0                           test       rax, rax
00ec8faf 741e                             je         0x140ec8fcf
00ec8fb1 0f10442440                       movups     xmm0, xmmword ptr [rsp + 0x40]
00ec8fb6 0f1100                           movups     xmmword ptr [rax], xmm0
00ec8fb9 0f117010                         movups     xmmword ptr [rax + 0x10], xmm6
00ec8fbd eb20                             jmp        0x140ec8fdf
00ec8fbf 84c0                             test       al, al
00ec8fc1 75b5                             jne        0x140ec8f78
00ec8fc3 388704010000                     cmp        byte ptr [rdi + 0x104], al
00ec8fc9 75ad                             jne        0x140ec8f78
00ec8fcb 32c0                             xor        al, al
00ec8fcd ebb0                             jmp        0x140ec8f7f
00ec8fcf 4533c0                           xor        r8d, r8d
00ec8fd2 488d542440                       lea        rdx, [rsp + 0x40]
00ec8fd7 488bcf                           mov        rcx, rdi
00ec8fda e861d90000                       call       0x140ed6940
00ec8fdf 0f28b424a0020000                 movaps     xmm6, xmmword ptr [rsp + 0x2a0]
00ec8fe7 4d85ff                           test       r15, r15
00ec8fea 7403                             je         0x140ec8fef
; unwind group range 0xec8fec..0xec8ff7 (exclusive)
00ec8fec 418937                           mov        dword ptr [r15], esi
00ec8fef 488bb42400030000                 mov        rsi, qword ptr [rsp + 0x300]
; unwind group range 0xec8ff7..0xec8fff (exclusive)
00ec8ff7 4c8bac24b0020000                 mov        r13, qword ptr [rsp + 0x2b0]
; unwind group range 0xec8fff..0xec9007 (exclusive)
00ec8fff 488bbc24b8020000                 mov        rdi, qword ptr [rsp + 0x2b8]
; unwind group range 0xec9007..0xec9026 (exclusive)
00ec9007 488b8d90010000                   mov        rcx, qword ptr [rbp + 0x190]
00ec900e 4833cc                           xor        rcx, rsp
00ec9011 e8ca288d00                       call       0x14179b8e0
00ec9016 4881c4c0020000                   add        rsp, 0x2c0
00ec901d 415f                             pop        r15
00ec901f 415e                             pop        r14
00ec9021 415c                             pop        r12
00ec9023 5b                               pop        rbx
00ec9024 5d                               pop        rbp
00ec9025 c3                               ret        
