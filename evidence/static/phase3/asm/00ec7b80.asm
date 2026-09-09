; iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0xec7b80
; unwind group range 0xec7b80..0xec7c65 (exclusive)
00ec7b80 4c8bdc                           mov        r11, rsp
00ec7b83 4881ecb8000000                   sub        rsp, 0xb8
00ec7b8a 4c8b4110                         mov        r8, qword ptr [rcx + 0x10]
00ec7b8e 4c8d89a1000000                   lea        r9, [rcx + 0xa1]
00ec7b95 660f6f0dc3d2da00                 movdqa     xmm1, xmmword ptr [rip + 0xdad2c3]
00ec7b9d 33c0                             xor        eax, eax
00ec7b9f 49894388                         mov        qword ptr [r11 - 0x78], rax
00ec7ba3 0f57c0                           xorps      xmm0, xmm0
00ec7ba6 0f29442450                       movaps     xmmword ptr [rsp + 0x50], xmm0
00ec7bab 4533d2                           xor        r10d, r10d
00ec7bae 660f6f054ad2da00                 movdqa     xmm0, xmmword ptr [rip + 0xdad24a]
00ec7bb6 498943a8                         mov        qword ptr [r11 - 0x58], rax
00ec7bba 8944246c                         mov        dword ptr [rsp + 0x6c], eax
00ec7bbe 498943e8                         mov        qword ptr [r11 - 0x18], rax
00ec7bc2 488d05d704ffff                   lea        rax, [rip - 0xfb29]
00ec7bc9 4889442430                       mov        qword ptr [rsp + 0x30], rax
00ec7bce 488d8192000000                   lea        rax, [rcx + 0x92]
00ec7bd5 4489542420                       mov        dword ptr [rsp + 0x20], r10d
00ec7bda 49894390                         mov        qword ptr [r11 - 0x70], rax
00ec7bde 49894b80                         mov        qword ptr [r11 - 0x80], rcx
00ec7be2 660f7f442470                     movdqa     xmmword ptr [rsp + 0x70], xmm0
00ec7be8 660f6f0530d1da00                 movdqa     xmm0, xmmword ptr [rip + 0xdad130]
00ec7bf0 c744242402000000                 mov        dword ptr [rsp + 0x24], 2
00ec7bf8 c74424284e000000                 mov        dword ptr [rsp + 0x28], 0x4e
00ec7c00 c744242c1e000000                 mov        dword ptr [rsp + 0x2c], 0x1e
00ec7c08 41c60100                         mov        byte ptr [r9], 0
00ec7c0c 448991e0000000                   mov        dword ptr [rcx + 0xe0], r10d
00ec7c13 8b8160010000                     mov        eax, dword ptr [rcx + 0x160]
00ec7c19 89442468                         mov        dword ptr [rsp + 0x68], eax
00ec7c1d 66410f7f43d8                     movdqa     xmmword ptr [r11 - 0x28], xmm0
00ec7c23 66410f7f4bc8                     movdqa     xmmword ptr [r11 - 0x38], xmm1
00ec7c29 4d85c0                           test       r8, r8
00ec7c2c 7425                             je         0x140ec7c53
00ec7c2e 498d8068170000                   lea        rax, [r8 + 0x1768]
00ec7c35 4d894b88                         mov        qword ptr [r11 - 0x78], r9
00ec7c39 498943a8                         mov        qword ptr [r11 - 0x58], rax
00ec7c3d 498d8078010000                   lea        rax, [r8 + 0x178]
00ec7c44 49894398                         mov        qword ptr [r11 - 0x68], rax
00ec7c48 488d81b0000000                   lea        rax, [rcx + 0xb0]
00ec7c4f 498943a0                         mov        qword ptr [r11 - 0x60], rax
00ec7c53 488d4c2420                       lea        rcx, [rsp + 0x20]
00ec7c58 e8d309ffff                       call       0x140eb8630
00ec7c5d 4881c4b8000000                   add        rsp, 0xb8
00ec7c64 c3                               ret        
