; Original iTunes.exe machine code; base=0x140000000; RVA=0xbfc320; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0xbfc320..0xbfc3cb (exclusive)
00bfc320 push       rbx
00bfc322 push       rbp
00bfc323 push       rsi
00bfc324 push       rdi
00bfc325 push       r13
00bfc327 push       r15
00bfc329 sub        rsp, 0x88
00bfc330 movaps     xmmword ptr [rsp + 0x60], xmm6
00bfc335 mov        rax, qword ptr [rip + 0x13d8d04]
00bfc33c xor        rax, rsp
00bfc33f mov        qword ptr [rsp + 0x50], rax
00bfc344 mov        r15, qword ptr [rsp + 0xe0]
00bfc34c mov        ebx, r8d
00bfc34f and        ebx, 0xf
00bfc352 mov        r13, r9
00bfc355 cmp        dword ptr [rcx + 0xc], 2
00bfc359 mov        edi, r8d
00bfc35c mov        rsi, rdx
00bfc35f mov        rbp, rcx
00bfc362 movd       xmm6, ebx
00bfc366 pshufd     xmm6, xmm6, 0
00bfc36b jne        0x140bfc37b
00bfc36d test       ebx, ebx
00bfc36f je         0x140bfc37b
00bfc371 mov        eax, 0x206e
00bfc376 jmp        0x140bfc55d
00bfc37b mov        qword ptr [rsp + 0x20], r15
00bfc380 call       0x140bfc1e0
00bfc385 test       eax, eax
00bfc387 jne        0x140bfc55d
00bfc38d cmp        dword ptr [rbp + 0xc], 1
00bfc391 jne        0x140bfc3a4
00bfc393 mov        eax, dword ptr [r15]
00bfc396 test       eax, eax
00bfc398 je         0x140bfc3c0
00bfc39a add        eax, -0x10
00bfc39d mov        edx, eax
00bfc39f add        rdx, r13
00bfc3a2 jmp        0x140bfc3aa
00bfc3a4 lea        edx, [rdi - 0x10]
00bfc3a7 add        rdx, rsi
00bfc3aa je         0x140bfc3c0
00bfc3ac mov        rcx, qword ptr [rbp + 0x28]
00bfc3b0 test       rcx, rcx
00bfc3b3 je         0x140bfc3c0
00bfc3b5 mov        r8d, 0x10
00bfc3bb call       0x141867875
00bfc3c0 test       ebx, ebx
00bfc3c2 je         0x140bfc55b
00bfc3c8 mov        edi, dword ptr [r15]
; range 0xbfc3cb..0xbfc543 (exclusive)
00bfc3cb mov        qword ptr [rsp + 0x80], r12
00bfc3d3 mov        qword ptr [rsp + 0x78], r14
00bfc3d8 lea        rdx, [rdi + rsi]
00bfc3dc test       rdx, rdx
00bfc3df je         0x140bfc3ee
00bfc3e1 mov        r8d, ebx
00bfc3e4 lea        rcx, [rsp + 0x40]
00bfc3e9 call       0x141867875
00bfc3ee mov        eax, 0x10
00bfc3f3 mov        edx, ebx
00bfc3f5 sub        eax, ebx
00bfc3f7 cmp        eax, 0x10
00bfc3fa jb         0x140bfc45c
00bfc3fc andps      xmm6, xmmword ptr [rip + 0x1078fad]
00bfc403 lea        r8d, [rbx + 8]
00bfc407 movdqa     xmm0, xmmword ptr [rip + 0x1079271]
00bfc40f and        eax, 0xf
00bfc412 packuswb   xmm6, xmm6
00bfc416 mov        r10d, 0x10
00bfc41c packuswb   xmm6, xmm6
00bfc420 sub        r10d, eax
00bfc423 psubb      xmm0, xmm6
00bfc427 movdqa     xmmword ptr [rsp + 0x30], xmm0
00bfc42d mov        r9d, dword ptr [rsp + 0x30]
00bfc432 mov        eax, edx
00bfc434 add        edx, 0x10
00bfc437 mov        dword ptr [rsp + rax + 0x40], r9d
00bfc43c lea        eax, [r8 - 4]
00bfc440 mov        dword ptr [rsp + rax + 0x40], r9d
00bfc445 lea        eax, [r8 + 4]
00bfc449 mov        dword ptr [rsp + r8 + 0x40], r9d
00bfc44e lea        r8d, [r8 + 0x10]
00bfc452 mov        dword ptr [rsp + rax + 0x40], r9d
00bfc457 cmp        edx, r10d
00bfc45a jb         0x140bfc432
00bfc45c cmp        edx, 0x10
00bfc45f jae        0x140bfc480
00bfc461 mov        ecx, edx
00bfc463 lea        rax, [rsp + 0x40]
00bfc468 mov        r8d, 0x10
00bfc46e add        rcx, rax
00bfc471 sub        r8d, edx
00bfc474 mov        edx, 0x10
00bfc479 sub        dl, bl
00bfc47b call       0x14179cca0
00bfc480 lea        r12, [rdi + r13]
00bfc484 xor        ebx, ebx
00bfc486 mov        rdi, qword ptr [rbp + 0x28]
00bfc48a nop        word ptr [rax + rax]
00bfc490 mov        r8, qword ptr [rbp + 0x20]
00bfc494 lea        r14, [rsp + 0x40]
00bfc499 mov        esi, ebx
00bfc49b add        r14, rsi
00bfc49e cmp        dword ptr [rbp + 0xc], 1
00bfc4a2 jne        0x140bfc4e1
00bfc4a4 mov        eax, dword ptr [r14]
00bfc4a7 lea        rcx, [rsp + 0x30]
00bfc4ac xor        eax, dword ptr [rdi]
00bfc4ae mov        dword ptr [rsp + 0x30], eax
00bfc4b2 mov        eax, dword ptr [rsp + rbx + 0x44]
00bfc4b6 xor        eax, dword ptr [rdi + 4]
00bfc4b9 mov        dword ptr [rsp + 0x34], eax
00bfc4bd mov        eax, dword ptr [rsp + rbx + 0x48]
00bfc4c1 xor        eax, dword ptr [rdi + 8]
00bfc4c4 mov        dword ptr [rsp + 0x38], eax
00bfc4c8 mov        eax, dword ptr [rsp + rbx + 0x4c]
00bfc4cc xor        eax, dword ptr [rdi + 0xc]
00bfc4cf lea        rdi, [rbx + r12]
00bfc4d3 mov        rdx, rdi
00bfc4d6 mov        dword ptr [rsp + 0x3c], eax
00bfc4da call       0x140bfa2a0
00bfc4df jmp        0x140bfc51f
00bfc4e1 lea        rdx, [rsp + 0x30]
00bfc4e6 mov        rcx, r14
00bfc4e9 call       0x140bfb050
00bfc4ee mov        eax, dword ptr [rsp + 0x30]
00bfc4f2 xor        eax, dword ptr [rdi]
00bfc4f4 mov        dword ptr [rbx + r12], eax
00bfc4f8 mov        eax, dword ptr [rsp + 0x34]
00bfc4fc xor        eax, dword ptr [rdi + 4]
00bfc4ff mov        dword ptr [rbx + r12 + 4], eax
00bfc504 mov        eax, dword ptr [rsp + 0x38]
00bfc508 xor        eax, dword ptr [rdi + 8]
00bfc50b mov        dword ptr [rbx + r12 + 8], eax
00bfc510 mov        eax, dword ptr [rsp + 0x3c]
00bfc514 xor        eax, dword ptr [rdi + 0xc]
00bfc517 mov        rdi, r14
00bfc51a mov        dword ptr [rbx + r12 + 0xc], eax
00bfc51f add        ebx, 0x10
00bfc522 lea        eax, [rbx + 0x10]
00bfc525 cmp        eax, 0x10
00bfc528 jbe        0x140bfc490
00bfc52e mov        edx, dword ptr [r15]
00bfc531 mov        r14, qword ptr [rsp + 0x78]
00bfc536 mov        r12, qword ptr [rsp + 0x80]
00bfc53e add        rdx, r13
00bfc541 je         0x140bfc557
; range 0xbfc543..0xbfc57f (exclusive)
00bfc543 mov        rcx, qword ptr [rbp + 0x28]
00bfc547 test       rcx, rcx
00bfc54a je         0x140bfc557
00bfc54c mov        r8d, 0x10
00bfc552 call       0x141867875
00bfc557 add        dword ptr [r15], 0x10
00bfc55b xor        eax, eax
00bfc55d mov        rcx, qword ptr [rsp + 0x50]
00bfc562 xor        rcx, rsp
00bfc565 call       0x14179b8e0
00bfc56a movaps     xmm6, xmmword ptr [rsp + 0x60]
00bfc56f add        rsp, 0x88
00bfc576 pop        r15
00bfc578 pop        r13
00bfc57a pop        rdi
00bfc57b pop        rsi
00bfc57c pop        rbp
00bfc57d pop        rbx
00bfc57e ret        
