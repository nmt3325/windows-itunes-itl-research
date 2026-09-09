; Original iTunes.exe machine code; base=0x140000000; RVA=0x106b290; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x106b290..0x106b2f2 (exclusive)
0106b290 mov        qword ptr [rsp + 0x20], rsi
0106b295 push       rdi
0106b296 sub        rsp, 0x50
0106b29a mov        rax, qword ptr [rip + 0xf69d9f]
0106b2a1 xor        rax, rsp
0106b2a4 mov        qword ptr [rsp + 0x40], rax
0106b2a9 mov        qword ptr [rsp + 0x38], 0
0106b2b2 mov        rsi, rcx
0106b2b5 mov        dword ptr [rsp + 0x28], 0x686f686d
0106b2bd mov        dword ptr [rsp + 0x2c], 0x18
0106b2c5 mov        dword ptr [rsp + 0x34], 0x6d
0106b2cd test       rdx, rdx
0106b2d0 je         0x14106b432
0106b2d6 mov        rcx, qword ptr [rip + 0x103adb3]
0106b2dd call       qword ptr [rip + 0x87e0dd]
0106b2e3 mov        rdi, rax
0106b2e6 test       rax, rax
0106b2e9 je         0x14106b432
0106b2ef mov        rcx, rax
; range 0x106b2f2..0x106b432 (exclusive)
0106b2f2 mov        qword ptr [rsp + 0x70], rbx
0106b2f7 call       qword ptr [rip + 0x87dc73]
0106b2fd cmp        byte ptr [rsi + 0x52], 0
0106b301 mov        r8d, dword ptr [rsp + 0x2c]
0106b306 lea        r9d, [rax + r8]
0106b30a mov        dword ptr [rsp + 0x30], r9d
0106b30f jne        0x14106b3cb
0106b315 mov        ecx, dword ptr [rsp + 0x28]
0106b319 mov        edx, ecx
0106b31b and        edx, 0xff0000
0106b321 mov        eax, ecx
0106b323 shr        eax, 0x10
0106b326 or         edx, eax
0106b328 mov        eax, ecx
0106b32a and        eax, 0xff00
0106b32f shl        ecx, 0x10
0106b332 or         eax, ecx
0106b334 shr        edx, 8
0106b337 shl        eax, 8
0106b33a mov        ecx, r8d
0106b33d or         edx, eax
0106b33f and        ecx, 0xff0000
0106b345 mov        dword ptr [rsp + 0x28], edx
0106b349 mov        eax, r8d
0106b34c shr        eax, 0x10
0106b34f or         ecx, eax
0106b351 mov        eax, r8d
0106b354 and        eax, 0xff00
0106b359 shr        ecx, 8
0106b35c shl        r8d, 0x10
0106b360 or         eax, r8d
0106b363 shl        eax, 8
0106b366 or         ecx, eax
0106b368 mov        dword ptr [rsp + 0x2c], ecx
0106b36c mov        ecx, dword ptr [rsp + 0x34]
0106b370 mov        edx, ecx
0106b372 and        edx, 0xff0000
0106b378 mov        eax, ecx
0106b37a shr        eax, 0x10
0106b37d or         edx, eax
0106b37f mov        eax, ecx
0106b381 and        eax, 0xff00
0106b386 shr        edx, 8
0106b389 shl        ecx, 0x10
0106b38c or         eax, ecx
0106b38e mov        ecx, dword ptr [rsp + 0x38]
0106b392 shl        eax, 8
0106b395 or         edx, eax
0106b397 mov        eax, ecx
0106b399 shr        eax, 0x10
0106b39c mov        dword ptr [rsp + 0x34], edx
0106b3a0 mov        edx, ecx
0106b3a2 and        edx, 0xff0000
0106b3a8 or         edx, eax
0106b3aa mov        eax, ecx
0106b3ac shl        eax, 0x10
0106b3af and        ecx, 0xff00
0106b3b5 or         eax, ecx
0106b3b7 shr        edx, 8
0106b3ba shl        eax, 8
0106b3bd or         edx, eax
0106b3bf bswap      r9d
0106b3c2 mov        dword ptr [rsp + 0x38], edx
0106b3c6 mov        dword ptr [rsp + 0x30], r9d
0106b3cb mov        rcx, qword ptr [rsi + 0x120]
0106b3d2 lea        r8, [rsp + 0x28]
0106b3d7 lea        rdx, [rsp + 0x20]
0106b3dc mov        qword ptr [rsp + 0x20], 0x18
0106b3e5 call       0x140ba04c0
0106b3ea mov        ebx, eax
0106b3ec test       eax, eax
0106b3ee jne        0x14106b420
0106b3f0 mov        rcx, rdi
0106b3f3 call       qword ptr [rip + 0x87db77]
0106b3f9 mov        rcx, rdi
0106b3fc mov        rbx, rax
0106b3ff call       qword ptr [rip + 0x87db73]
0106b405 mov        rcx, qword ptr [rsi + 0x120]
0106b40c lea        rdx, [rsp + 0x20]
0106b411 mov        r8, rax
0106b414 mov        qword ptr [rsp + 0x20], rbx
0106b419 call       0x140ba04c0
0106b41e mov        ebx, eax
0106b420 mov        rcx, rdi
0106b423 call       qword ptr [rip + 0x87d9f7]
0106b429 mov        eax, ebx
0106b42b mov        rbx, qword ptr [rsp + 0x70]
0106b430 jmp        0x14106b437
; range 0x106b432..0x106b44f (exclusive)
0106b432 mov        eax, 0xffffffce
0106b437 mov        rcx, qword ptr [rsp + 0x40]
0106b43c xor        rcx, rsp
0106b43f call       0x14179b8e0
0106b444 mov        rsi, qword ptr [rsp + 0x78]
0106b449 add        rsp, 0x50
0106b44d pop        rdi
0106b44e ret        
