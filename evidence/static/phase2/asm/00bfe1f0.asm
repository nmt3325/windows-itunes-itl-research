; iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0xbfe1f0
; unwind group range 0xbfe1f0..0xbfe4fb (exclusive)
00bfe1f0 4c894c2420                       mov        qword ptr [rsp + 0x20], r9
00bfe1f5 53                               push       rbx
00bfe1f6 55                               push       rbp
00bfe1f7 56                               push       rsi
00bfe1f8 4154                             push       r12
00bfe1fa 4156                             push       r14
00bfe1fc 4883ec30                         sub        rsp, 0x30
00bfe200 33f6                             xor        esi, esi
00bfe202 4963e8                           movsxd     rbp, r8d
00bfe205 4d8bf1                           mov        r14, r9
00bfe208 4c8be2                           mov        r12, rdx
00bfe20b 488bd9                           mov        rbx, rcx
00bfe20e 4d85c9                           test       r9, r9
00bfe211 7403                             je         0x140bfe216
00bfe213 418931                           mov        dword ptr [r9], esi
00bfe216 48897c2468                       mov        qword ptr [rsp + 0x68], rdi
00bfe21b 4c896c2428                       mov        qword ptr [rsp + 0x28], r13
00bfe220 4c897c2420                       mov        qword ptr [rsp + 0x20], r15
00bfe225 4885db                           test       rbx, rbx
00bfe228 0f84ad020000                     je         0x140bfe4db
00bfe22e 813963727473                     cmp        dword ptr [rcx], 0x73747263
00bfe234 0f85a1020000                     jne        0x140bfe4db
00bfe23a 39713c                           cmp        dword ptr [rcx + 0x3c], esi
00bfe23d 0f8598020000                     jne        0x140bfe4db
00bfe243 4585c0                           test       r8d, r8d
00bfe246 0f848b020000                     je         0x140bfe4d7
00bfe24c 397128                           cmp        dword ptr [rcx + 0x28], esi
00bfe24f 0f8586020000                     jne        0x140bfe4db
00bfe255 0fb64104                         movzx      eax, byte ptr [rcx + 4]
00bfe259 2401                             and        al, 1
00bfe25b 88442460                         mov        byte ptr [rsp + 0x60], al
00bfe25f 0f8482000000                     je         0x140bfe2e7
00bfe265 4c8b4110                         mov        r8, qword ptr [rcx + 0x10]
00bfe269 4d85c0                           test       r8, r8
00bfe26c 7479                             je         0x140bfe2e7
00bfe26e 488b4120                         mov        rax, qword ptr [rcx + 0x20]
00bfe272 4885c0                           test       rax, rax
00bfe275 7470                             je         0x140bfe2e7
00bfe277 4863512c                         movsxd     rdx, dword ptr [rcx + 0x2c]
00bfe27b c7413c01000000                   mov        dword ptr [rcx + 0x3c], 1
00bfe282 4c8b38                           mov        r15, qword ptr [rax]
00bfe285 488b4118                         mov        rax, qword ptr [rcx + 0x18]
00bfe289 8d72ff                           lea        esi, [rdx - 1]
00bfe28c 488d7aff                         lea        rdi, [rdx - 1]
00bfe290 4c8b28                           mov        r13, qword ptr [rax]
00bfe293 498b00                           mov        rax, qword ptr [r8]
00bfe296 488d3cf8                         lea        rdi, [rax + rdi*8]
00bfe29a 85f6                             test       esi, esi
00bfe29c 783b                             js         0x140bfe2d9
00bfe29e 6690                             nop        
00bfe2a0 8b4704                           mov        eax, dword ptr [rdi + 4]
00bfe2a3 3bc5                             cmp        eax, ebp
00bfe2a5 7529                             jne        0x140bfe2d0
00bfe2a7 48630f                           movsxd     rcx, dword ptr [rdi]
00bfe2aa 85c9                             test       ecx, ecx
00bfe2ac 7822                             js         0x140bfe2d0
00bfe2ae 85c0                             test       eax, eax
00bfe2b0 7e1e                             jle        0x140bfe2d0
00bfe2b2 410fb6040f                       movzx      eax, byte ptr [r15 + rcx]
00bfe2b7 498d140f                         lea        rdx, [r15 + rcx]
00bfe2bb 41380424                         cmp        byte ptr [r12], al
00bfe2bf 750f                             jne        0x140bfe2d0
00bfe2c1 4c8bc5                           mov        r8, rbp
00bfe2c4 498bcc                           mov        rcx, r12
00bfe2c7 e8c8e9b900                       call       0x14179cc94
00bfe2cc 85c0                             test       eax, eax
00bfe2ce 7438                             je         0x140bfe308
00bfe2d0 4883ef08                         sub        rdi, 8
00bfe2d4 83ee01                           sub        esi, 1
00bfe2d7 79c7                             jns        0x140bfe2a0
00bfe2d9 8b433c                           mov        eax, dword ptr [rbx + 0x3c]
00bfe2dc 85c0                             test       eax, eax
00bfe2de 7e05                             jle        0x140bfe2e5
00bfe2e0 ffc8                             dec        eax
00bfe2e2 89433c                           mov        dword ptr [rbx + 0x3c], eax
00bfe2e5 33f6                             xor        esi, esi
00bfe2e7 488bcb                           mov        rcx, rbx
00bfe2ea e851fbffff                       call       0x140bfde40
00bfe2ef 48634330                         movsxd     rax, dword ptr [rbx + 0x30]
00bfe2f3 85c0                             test       eax, eax
00bfe2f5 7547                             jne        0x140bfe33e
00bfe2f7 488bcb                           mov        rcx, rbx
00bfe2fa e851f9ffff                       call       0x140bfdc50
00bfe2ff 85c0                             test       eax, eax
00bfe301 74e4                             je         0x140bfe2e7
00bfe303 e9d8010000                       jmp        0x140bfe4e0
00bfe308 4863c6                           movsxd     rax, esi
00bfe30b 41ff448500                       inc        dword ptr [r13 + rax*4]
00bfe310 4d85f6                           test       r14, r14
00bfe313 7406                             je         0x140bfe31b
00bfe315 8d4601                           lea        eax, [rsi + 1]
00bfe318 418906                           mov        dword ptr [r14], eax
00bfe31b 813b63727473                     cmp        dword ptr [rbx], 0x73747263
00bfe321 0f85b0010000                     jne        0x140bfe4d7
00bfe327 8b433c                           mov        eax, dword ptr [rbx + 0x3c]
00bfe32a 85c0                             test       eax, eax
00bfe32c 0f8ea5010000                     jle        0x140bfe4d7
00bfe332 ffc8                             dec        eax
00bfe334 89433c                           mov        dword ptr [rbx + 0x3c], eax
00bfe337 33c0                             xor        eax, eax
00bfe339 e9a2010000                       jmp        0x140bfe4e0
00bfe33e 488b5310                         mov        rdx, qword ptr [rbx + 0x10]
00bfe342 488d78ff                         lea        rdi, [rax - 1]
00bfe346 4c8b7320                         mov        r14, qword ptr [rbx + 0x20]
00bfe34a 4c8d7b20                         lea        r15, [rbx + 0x20]
00bfe34e 488b02                           mov        rax, qword ptr [rdx]
00bfe351 488d3cf8                         lea        rdi, [rax + rdi*8]
00bfe355 8b4704                           mov        eax, dword ptr [rdi + 4]
00bfe358 4c8bef                           mov        r13, rdi
00bfe35b 894330                           mov        dword ptr [rbx + 0x30], eax
00bfe35e 4c2b2a                           sub        r13, qword ptr [rdx]
00bfe361 49c1fd03                         sar        r13, 3
00bfe365 41ffc5                           inc        r13d
00bfe368 4d63c5                           movsxd     r8, r13d
00bfe36b 4d85f6                           test       r14, r14
00bfe36e 7505                             jne        0x140bfe375
00bfe370 448bf6                           mov        r14d, esi
00bfe373 eb17                             jmp        0x140bfe38c
00bfe375 41817e08486d654d                 cmp        dword ptr [r14 + 8], 0x4d656d48
00bfe37d 7506                             jne        0x140bfe385
00bfe37f 458b7610                         mov        r14d, dword ptr [r14 + 0x10]
00bfe383 eb03                             jmp        0x140bfe388
00bfe385 448bf6                           mov        r14d, esi
00bfe388 442b7334                         sub        r14d, dword ptr [rbx + 0x34]
00bfe38c 3b6b34                           cmp        ebp, dword ptr [rbx + 0x34]
00bfe38f 0f8ef9000000                     jle        0x140bfe48e
00bfe395 8b4b38                           mov        ecx, dword ptr [rbx + 0x38]
00bfe398 8bc1                             mov        eax, ecx
00bfe39a 3bcd                             cmp        ecx, ebp
00bfe39c 66410f6ec6                       movd       xmm0, r14d
00bfe3a1 0f5bc0                           cvtdq2ps   xmm0, xmm0
00bfe3a4 0f42c5                           cmovb      eax, ebp
00bfe3a7 f30f5905a94e0701                 mulss      xmm0, dword ptr [rip + 0x1074ea9]
00bfe3af f3480f2cf0                       cvttss2si  rsi, xmm0
00bfe3b4 3bc6                             cmp        eax, esi
00bfe3b6 0f43f0                           cmovae     esi, eax
00bfe3b9 81f900200000                     cmp        ecx, 0x2000
00bfe3bf 7306                             jae        0x140bfe3c7
00bfe3c1 8d0409                           lea        eax, [rcx + rcx]
00bfe3c4 894338                           mov        dword ptr [rbx + 0x38], eax
00bfe3c7 4d85ff                           test       r15, r15
00bfe3ca 7516                             jne        0x140bfe3e2
00bfe3cc 488b02                           mov        rax, qword ptr [rdx]
00bfe3cf 41b9ceffffff                     mov        r9d, 0xffffffce
00bfe3d5 4883e808                         sub        rax, 8
00bfe3d9 4a8d3cc0                         lea        rdi, [rax + r8*8]
00bfe3dd e990000000                       jmp        0x140bfe472
00bfe3e2 498b0f                           mov        rcx, qword ptr [r15]
00bfe3e5 4885c9                           test       rcx, rcx
00bfe3e8 7445                             je         0x140bfe42f
00bfe3ea 817908486d654d                   cmp        dword ptr [rcx + 8], 0x4d656d48
00bfe3f1 7505                             jne        0x140bfe3f8
00bfe3f3 8b5110                           mov        edx, dword ptr [rcx + 0x10]
00bfe3f6 eb02                             jmp        0x140bfe3fa
00bfe3f8 33d2                             xor        edx, edx
00bfe3fa 85f6                             test       esi, esi
00bfe3fc 791e                             jns        0x140bfe41c
00bfe3fe 8d0416                           lea        eax, [rsi + rdx]
00bfe401 85c0                             test       eax, eax
00bfe403 7917                             jns        0x140bfe41c
00bfe405 488b4310                         mov        rax, qword ptr [rbx + 0x10]
00bfe409 41b9ceffffff                     mov        r9d, 0xffffffce
00bfe40f 488b00                           mov        rax, qword ptr [rax]
00bfe412 4883e808                         sub        rax, 8
00bfe416 4a8d3cc0                         lea        rdi, [rax + r8*8]
00bfe41a eb56                             jmp        0x140bfe472
00bfe41c 8d0416                           lea        eax, [rsi + rdx]
00bfe41f 4863d0                           movsxd     rdx, eax
00bfe422 e89981fcff                       call       0x140bc65c0
00bfe427 448bc8                           mov        r9d, eax
00bfe42a 458bc5                           mov        r8d, r13d
00bfe42d eb2c                             jmp        0x140bfe45b
00bfe42f 85f6                             test       esi, esi
00bfe431 7822                             js         0x140bfe455
00bfe433 4863ce                           movsxd     rcx, esi
00bfe436 e85580fcff                       call       0x140bc6490
00bfe43b 4885c0                           test       rax, rax
00bfe43e 498907                           mov        qword ptr [r15], rax
00bfe441 41b994ffffff                     mov        r9d, 0xffffff94
00bfe447 ba00000000                       mov        edx, 0
00bfe44c 440f45ca                         cmovne     r9d, edx
00bfe450 458bc5                           mov        r8d, r13d
00bfe453 eb06                             jmp        0x140bfe45b
00bfe455 41b994ffffff                     mov        r9d, 0xffffff94
00bfe45b 488b4b10                         mov        rcx, qword ptr [rbx + 0x10]
00bfe45f 4963f8                           movsxd     rdi, r8d
00bfe462 488b11                           mov        rdx, qword ptr [rcx]
00bfe465 4883ea08                         sub        rdx, 8
00bfe469 488d3cfa                         lea        rdi, [rdx + rdi*8]
00bfe46d 4585c9                           test       r9d, r9d
00bfe470 7415                             je         0x140bfe487
00bfe472 c70700000080                     mov        dword ptr [rdi], 0x80000000
00bfe478 418bc1                           mov        eax, r9d
00bfe47b 8b4b30                           mov        ecx, dword ptr [rbx + 0x30]
00bfe47e 894f04                           mov        dword ptr [rdi + 4], ecx
00bfe481 44896b30                         mov        dword ptr [rbx + 0x30], r13d
00bfe485 eb59                             jmp        0x140bfe4e0
00bfe487 017334                           add        dword ptr [rbx + 0x34], esi
00bfe48a 4c8d7b20                         lea        r15, [rbx + 0x20]
00bfe48e 498b07                           mov        rax, qword ptr [r15]
00bfe491 4963ce                           movsxd     rcx, r14d
00bfe494 480308                           add        rcx, qword ptr [rax]
00bfe497 4d85e4                           test       r12, r12
00bfe49a 7410                             je         0x140bfe4ac
00bfe49c 4885c9                           test       rcx, rcx
00bfe49f 740b                             je         0x140bfe4ac
00bfe4a1 4c8bc5                           mov        r8, rbp
00bfe4a4 498bd4                           mov        rdx, r12
00bfe4a7 e8c993c600                       call       0x141867875
00bfe4ac 296b34                           sub        dword ptr [rbx + 0x34], ebp
00bfe4af 488b442478                       mov        rax, qword ptr [rsp + 0x78]
00bfe4b4 448937                           mov        dword ptr [rdi], r14d
00bfe4b7 896f04                           mov        dword ptr [rdi + 4], ebp
00bfe4ba 4885c0                           test       rax, rax
00bfe4bd 7403                             je         0x140bfe4c2
00bfe4bf 448928                           mov        dword ptr [rax], r13d
00bfe4c2 807c246000                       cmp        byte ptr [rsp + 0x60], 0
00bfe4c7 740e                             je         0x140bfe4d7
00bfe4c9 488b4318                         mov        rax, qword ptr [rbx + 0x18]
00bfe4cd 4963d5                           movsxd     rdx, r13d
00bfe4d0 488b08                           mov        rcx, qword ptr [rax]
00bfe4d3 ff4491fc                         inc        dword ptr [rcx + rdx*4 - 4]
00bfe4d7 33c0                             xor        eax, eax
00bfe4d9 eb05                             jmp        0x140bfe4e0
00bfe4db b8ceffffff                       mov        eax, 0xffffffce
00bfe4e0 4c8b7c2420                       mov        r15, qword ptr [rsp + 0x20]
00bfe4e5 4c8b6c2428                       mov        r13, qword ptr [rsp + 0x28]
00bfe4ea 488b7c2468                       mov        rdi, qword ptr [rsp + 0x68]
00bfe4ef 4883c430                         add        rsp, 0x30
00bfe4f3 415e                             pop        r14
00bfe4f5 415c                             pop        r12
00bfe4f7 5e                               pop        rsi
00bfe4f8 5d                               pop        rbp
00bfe4f9 5b                               pop        rbx
00bfe4fa c3                               ret        
