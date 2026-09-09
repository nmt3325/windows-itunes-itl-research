; Original iTunes.exe machine code; base=0x140000000; RVA=0xba0ac0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0xba0ac0..0xba0b32 (exclusive)
00ba0ac0 mov        r11, rsp
00ba0ac3 push       rbp
00ba0ac4 push       rbx
00ba0ac5 push       rsi
00ba0ac6 push       r14
00ba0ac8 push       r15
00ba0aca lea        rbp, [r11 - 0x878]
00ba0ad1 sub        rsp, 0x950
00ba0ad8 mov        rax, qword ptr [rip + 0x1434561]
00ba0adf xor        rax, rsp
00ba0ae2 mov        qword ptr [rbp + 0x840], rax
00ba0ae9 xor        esi, esi
00ba0aeb mov        r15, rcx
00ba0aee mov        qword ptr [rsp + 0x38], rsi
00ba0af3 mov        r14d, esi
00ba0af6 test       rcx, rcx
00ba0af9 je         0x140ba1742
00ba0aff cmp        dword ptr [rcx], 0x62776266
00ba0b05 jne        0x140ba1742
00ba0b0b mov        rcx, qword ptr [rcx + 0x18]
00ba0b0f test       rcx, rcx
00ba0b12 je         0x140ba1742
00ba0b18 mov        rdx, qword ptr [r15 + 0x28]
00ba0b1c test       rdx, rdx
00ba0b1f je         0x140ba1742
00ba0b25 cmp        word ptr [rdx], si
00ba0b28 je         0x140ba1742
00ba0b2e mov        r8, qword ptr [rcx + 0x10]
; range 0xba0b32..0xba0c94 (exclusive)
00ba0b32 mov        qword ptr [r11 + 0x18], r12
00ba0b36 mov        r12d, dword ptr [r15 + 0x10]
00ba0b3a movzx      ebx, r12b
00ba0b3e shr        r12d, 1
00ba0b41 and        bl, 1
00ba0b44 and        r12b, 1
00ba0b48 mov        qword ptr [r11 + 0x20], r13
00ba0b4c mov        qword ptr [r11 + 0x10], rdi
00ba0b50 mov        r13d, 4
00ba0b56 mov        byte ptr [rsp + 0x31], bl
00ba0b5a mov        dword ptr [rsp + 0x34], r12d
00ba0b5f test       r8, r8
00ba0b62 je         0x140ba0b9b
00ba0b64 mov        eax, dword ptr [rcx]
00ba0b66 cmp        eax, 0x41464350
00ba0b6b je         0x140ba0b74
00ba0b6d cmp        eax, 0x57696e50
00ba0b72 jne        0x140ba0b9b
00ba0b74 mov        rax, qword ptr [r8 + 0x38]
00ba0b78 test       rax, rax
00ba0b7b je         0x140ba0b9b
00ba0b7d lea        r9, [rbp + 0x3f0]
00ba0b84 lea        r8, [rbp + 0x1d0]
00ba0b8b call       rax
00ba0b8d test       eax, eax
00ba0b8f je         0x140ba0c6e
00ba0b95 mov        dword ptr [rbp + 0x1d0], esi
00ba0b9b xor        dil, dil
00ba0b9e mov        byte ptr [rsp + 0x30], dil
00ba0ba3 test       bl, bl
00ba0ba5 je         0x140ba0e4e
00ba0bab test       byte ptr [r15 + 0x10], r13b
00ba0baf je         0x140ba0eec
00ba0bb5 mov        rbx, qword ptr [r15 + 0x28]
00ba0bb9 lea        r8, [rbp + 0x640]
00ba0bc0 mov        edx, 3
00ba0bc5 mov        word ptr [rbp + 0x640], si
00ba0bcc lea        rcx, [rip + 0xf12af5]
00ba0bd3 call       0x140ae5fa0
00ba0bd8 lea        rax, [rbp + 0x640]
00ba0bdf mov        qword ptr [rsp + 0x60], rbx
00ba0be4 mov        qword ptr [rsp + 0x68], rax
00ba0be9 lea        rcx, [rsp + 0x60]
00ba0bee lea        rax, [rbp + 0x440]
00ba0bf5 xorps      xmm0, xmm0
00ba0bf8 xorps      xmm1, xmm1
00ba0bfb mov        qword ptr [rbp - 0x70], rax
00ba0bff movdqu     xmmword ptr [rsp + 0x70], xmm0
00ba0c05 movdqu     xmmword ptr [rbp - 0x80], xmm1
00ba0c0a call       0x140b1a610
00ba0c0f test       eax, eax
00ba0c11 jne        0x140ba0c7c
00ba0c13 mov        rcx, qword ptr [r15 + 0x18]
00ba0c17 test       rcx, rcx
00ba0c1a je         0x140ba0f12
00ba0c20 mov        rdx, qword ptr [rcx + 0x10]
00ba0c24 test       rdx, rdx
00ba0c27 je         0x140ba0f12
00ba0c2d mov        eax, dword ptr [rcx]
00ba0c2f cmp        eax, 0x41464350
00ba0c34 je         0x140ba0c41
00ba0c36 cmp        eax, 0x57696e50
00ba0c3b jne        0x140ba0f12
00ba0c41 mov        rax, qword ptr [rdx + 0x38]
00ba0c45 test       rax, rax
00ba0c48 je         0x140ba0f12
00ba0c4e xor        r9d, r9d
00ba0c51 lea        r8, [rbp - 0x50]
00ba0c55 lea        rdx, [rbp + 0x440]
00ba0c5c call       rax
00ba0c5e test       eax, eax
00ba0c60 je         0x140ba0eab
00ba0c66 mov        dword ptr [rbp - 0x50], esi
00ba0c69 jmp        0x140ba0f12
00ba0c6e cmp        byte ptr [rbp + 0x3f0], sil
00ba0c75 je         0x140ba0cb2
00ba0c77 mov        eax, 0xfffffaea
00ba0c7c mov        rdi, qword ptr [rsp + 0x988]
00ba0c84 mov        r12, qword ptr [rsp + 0x990]
00ba0c8c mov        r13, qword ptr [rsp + 0x998]
; range 0xba0c94..0xba0cb2 (exclusive)
00ba0c94 mov        rcx, qword ptr [rbp + 0x840]
00ba0c9b xor        rcx, rsp
00ba0c9e call       0x14179b8e0
00ba0ca3 add        rsp, 0x950
00ba0caa pop        r15
00ba0cac pop        r14
00ba0cae pop        rsi
00ba0caf pop        rbx
00ba0cb0 pop        rbp
00ba0cb1 ret        
; range 0xba0cb2..0xba1742 (exclusive)
00ba0cb2 cmp        byte ptr [rbp + 0x3f3], sil
00ba0cb9 je         0x140ba0cc2
00ba0cbb mov        eax, 0xffffffd3
00ba0cc0 jmp        0x140ba0c7c
00ba0cc2 mov        rcx, qword ptr [rbp + 0x1e0]
00ba0cc9 test       bl, bl
00ba0ccb je         0x140ba0e0c
00ba0cd1 test       rcx, rcx
00ba0cd4 je         0x140ba1736
00ba0cda mov        eax, dword ptr [rbp + 0x1d0]
00ba0ce0 cmp        eax, 0x41464350
00ba0ce5 je         0x140ba0cf2
00ba0ce7 cmp        eax, 0x57696e50
00ba0cec jne        0x140ba1736
00ba0cf2 cmp        qword ptr [rcx], rsi
00ba0cf5 je         0x140ba1736
00ba0cfb mov        ecx, 0x340
00ba0d00 call       0x140b930a0
00ba0d05 mov        rdi, rax
00ba0d08 test       rax, rax
00ba0d0b jne        0x140ba0d19
00ba0d0d mov        ebx, 0xffffff94
00ba0d12 mov        eax, ebx
00ba0d14 jmp        0x140ba0c7c
00ba0d19 mov        dword ptr [rax + 0x20], 0x66726566
00ba0d20 lea        rcx, [rbp + 0x1d0]
00ba0d27 mov        dword ptr [rax + 0x24], 3
00ba0d2e mov        rdx, r13
00ba0d31 mov        dword ptr [rax + 0x28], 0x64617461
00ba0d38 add        rax, 0x38
00ba0d3c nop        dword ptr [rax]
00ba0d40 lea        rax, [rax + 0x80]
00ba0d47 movups     xmm0, xmmword ptr [rcx]
00ba0d4a movups     xmm1, xmmword ptr [rcx + 0x10]
00ba0d4e lea        rcx, [rcx + 0x80]
00ba0d55 movups     xmmword ptr [rax - 0x80], xmm0
00ba0d59 movups     xmm0, xmmword ptr [rcx - 0x60]
00ba0d5d movups     xmmword ptr [rax - 0x70], xmm1
00ba0d61 movups     xmm1, xmmword ptr [rcx - 0x50]
00ba0d65 movups     xmmword ptr [rax - 0x60], xmm0
00ba0d69 movups     xmm0, xmmword ptr [rcx - 0x40]
00ba0d6d movups     xmmword ptr [rax - 0x50], xmm1
00ba0d71 movups     xmm1, xmmword ptr [rcx - 0x30]
00ba0d75 movups     xmmword ptr [rax - 0x40], xmm0
00ba0d79 movups     xmm0, xmmword ptr [rcx - 0x20]
00ba0d7d movups     xmmword ptr [rax - 0x30], xmm1
00ba0d81 movups     xmm1, xmmword ptr [rcx - 0x10]
00ba0d85 movups     xmmword ptr [rax - 0x20], xmm0
00ba0d89 movups     xmmword ptr [rax - 0x10], xmm1
00ba0d8d sub        rdx, 1
00ba0d91 jne        0x140ba0d40
00ba0d93 movups     xmm0, xmmword ptr [rcx]
00ba0d96 movups     xmm1, xmmword ptr [rcx + 0x10]
00ba0d9a movups     xmmword ptr [rax], xmm0
00ba0d9d movups     xmmword ptr [rax + 0x10], xmm1
00ba0da1 mov        eax, 1
00ba0da6 lock xadd  dword ptr [rip + 0x147230a], eax
00ba0dae mov        dword ptr [rdi + 0x258], eax
00ba0db4 mov        rcx, rdi
00ba0db7 mov        rax, qword ptr [rbp + 0x1e0]
00ba0dbe mov        rdx, qword ptr [rax]
00ba0dc1 call       rdx
00ba0dc3 mov        ebx, eax
00ba0dc5 test       eax, eax
00ba0dc7 je         0x140ba0dd9
00ba0dc9 mov        rcx, rdi
00ba0dcc call       qword ptr [rip + 0xd4b596]
00ba0dd2 mov        eax, ebx
00ba0dd4 jmp        0x140ba0c7c
00ba0dd9 cmp        dword ptr [rdi + 0x20], 0x66726566
00ba0de0 jne        0x140ba0dff
00ba0de2 mov        rax, qword ptr [rdi + 0x260]
00ba0de9 test       rax, rax
00ba0dec je         0x140ba0dff
00ba0dee mov        rcx, rdi
00ba0df1 call       rax
00ba0df3 mov        rcx, rdi
00ba0df6 mov        dword ptr [rdi + 0x20], esi
00ba0df9 call       qword ptr [rip + 0xd4b569]
00ba0dff mov        dil, 1
00ba0e02 mov        byte ptr [rsp + 0x30], dil
00ba0e07 jmp        0x140ba0bab
00ba0e0c test       rcx, rcx
00ba0e0f je         0x140ba1736
00ba0e15 mov        eax, dword ptr [rbp + 0x1d0]
00ba0e1b cmp        eax, 0x41464350
00ba0e20 je         0x140ba0e2d
00ba0e22 cmp        eax, 0x57696e50
00ba0e27 jne        0x140ba1736
00ba0e2d mov        rax, qword ptr [rcx + 0x78]
00ba0e31 test       rax, rax
00ba0e34 je         0x140ba0e9f
00ba0e36 lea        rcx, [rbp + 0x1d0]
00ba0e3d call       rax
00ba0e3f mov        ebx, eax
00ba0e41 test       eax, eax
00ba0e43 jne        0x140ba173b
00ba0e49 mov        byte ptr [rsp + 0x30], sil
00ba0e4e mov        rcx, qword ptr [r15 + 0x18]
00ba0e52 mov        rdx, qword ptr [r15 + 0x28]
00ba0e56 test       rcx, rcx
00ba0e59 je         0x140ba1736
00ba0e5f mov        r8, qword ptr [rcx + 0x10]
00ba0e63 test       r8, r8
00ba0e66 je         0x140ba1736
00ba0e6c mov        eax, dword ptr [rcx]
00ba0e6e cmp        eax, 0x41464350
00ba0e73 je         0x140ba0e80
00ba0e75 cmp        eax, 0x57696e50
00ba0e7a jne        0x140ba1736
00ba0e80 test       rdx, rdx
00ba0e83 je         0x140ba1736
00ba0e89 cmp        word ptr [rdx], si
00ba0e8c je         0x140ba1736
00ba0e92 mov        rax, qword ptr [r8 + 0x70]
00ba0e96 test       rax, rax
00ba0e99 jne        0x140ba0f89
00ba0e9f mov        ebx, 0xfffffffc
00ba0ea4 mov        eax, ebx
00ba0ea6 jmp        0x140ba0c7c
00ba0eab mov        rcx, qword ptr [rbp - 0x40]
00ba0eaf test       rcx, rcx
00ba0eb2 je         0x140ba1736
00ba0eb8 mov        eax, dword ptr [rbp - 0x50]
00ba0ebb cmp        eax, 0x41464350
00ba0ec0 je         0x140ba0ecd
00ba0ec2 cmp        eax, 0x57696e50
00ba0ec7 jne        0x140ba1736
00ba0ecd mov        rax, qword ptr [rcx + 0x78]
00ba0ed1 test       rax, rax
00ba0ed4 je         0x140ba0e9f
00ba0ed6 lea        rcx, [rbp - 0x50]
00ba0eda call       rax
00ba0edc mov        byte ptr [rsp + 0x30], dil
00ba0ee1 mov        ebx, eax
00ba0ee3 test       eax, eax
00ba0ee5 je         0x140ba0f12
00ba0ee7 jmp        0x140ba0c7c
00ba0eec mov        rcx, qword ptr [r15 + 0x18]
00ba0ef0 lea        r9, [rbp + 0x440]
00ba0ef7 lea        r8, [rip + 0xf127ca]
00ba0efe lea        rdx, [rip + 0xf834fb]
00ba0f05 call       0x140b202c0
00ba0f0a test       eax, eax
00ba0f0c jne        0x140ba0c7c
00ba0f12 mov        rcx, qword ptr [r15 + 0x18]
00ba0f16 test       rcx, rcx
00ba0f19 je         0x140ba1736
00ba0f1f mov        rdx, qword ptr [rcx + 0x10]
00ba0f23 test       rdx, rdx
00ba0f26 je         0x140ba1736
00ba0f2c mov        eax, dword ptr [rcx]
00ba0f2e cmp        eax, 0x41464350
00ba0f33 je         0x140ba0f40
00ba0f35 cmp        eax, 0x57696e50
00ba0f3a jne        0x140ba1736
00ba0f40 cmp        word ptr [rbp + 0x440], si
00ba0f47 je         0x140ba1736
00ba0f4d mov        rax, qword ptr [rdx + 0x70]
00ba0f51 test       rax, rax
00ba0f54 je         0x140ba0e9f
00ba0f5a mov        r9d, dword ptr [r15 + 0x24]
00ba0f5e lea        rdx, [rbp - 0x50]
00ba0f62 mov        r8d, dword ptr [r15 + 0x20]
00ba0f66 mov        qword ptr [rsp + 0x20], rdx
00ba0f6b lea        rdx, [rbp + 0x440]
00ba0f72 call       rax
00ba0f74 mov        ebx, eax
00ba0f76 test       eax, eax
00ba0f78 jne        0x140ba173b
00ba0f7e test       r12b, r12b
00ba0f81 je         0x140ba0fba
00ba0f83 lea        rcx, [rbp - 0x50]
00ba0f87 jmp        0x140ba0fb5
00ba0f89 mov        r9d, dword ptr [r15 + 0x24]
00ba0f8d lea        r8, [rbp + 0x1d0]
00ba0f94 mov        qword ptr [rsp + 0x20], r8
00ba0f99 mov        r8d, dword ptr [r15 + 0x20]
00ba0f9d call       rax
00ba0f9f mov        ebx, eax
00ba0fa1 test       eax, eax
00ba0fa3 jne        0x140ba173b
00ba0fa9 test       r12b, r12b
00ba0fac je         0x140ba0fba
00ba0fae lea        rcx, [rbp + 0x1d0]
00ba0fb5 call       0x140aee0b0
00ba0fba mov        edx, 0x10
00ba0fbf mov        ecx, 0x100000
00ba0fc4 call       qword ptr [rip + 0xd4b3a6]
00ba0fca mov        qword ptr [rsp + 0x48], rax
00ba0fcf mov        rsi, rax
00ba0fd2 test       rax, rax
00ba0fd5 jne        0x140ba0fe1
00ba0fd7 mov        edi, 0xffffff94
00ba0fdc jmp        0x140ba146d
00ba0fe1 cmp        qword ptr [r15 + 0x40], r14
00ba0fe5 je         0x140ba100e
00ba0fe7 mov        edx, 0x10
00ba0fec mov        ecx, 0x100000
00ba0ff1 call       qword ptr [rip + 0xd4b379]
00ba0ff7 mov        qword ptr [rsp + 0x38], rax
00ba0ffc mov        r14, rax
00ba0fff test       rax, rax
00ba1002 jne        0x140ba100e
00ba1004 mov        edi, 0xffffff94
00ba1009 jmp        0x140ba1464
00ba100e cmp        byte ptr [rsp + 0x31], 0
00ba1013 je         0x140ba10fe
00ba1019 mov        rcx, qword ptr [rbp - 0x40]
00ba101d test       rcx, rcx
00ba1020 je         0x140ba1039
00ba1022 mov        eax, dword ptr [rbp - 0x50]
00ba1025 cmp        eax, 0x41464350
00ba102a je         0x140ba1033
00ba102c cmp        eax, 0x57696e50
00ba1031 jne        0x140ba1039
00ba1033 cmp        qword ptr [rcx], 0
00ba1037 jne        0x140ba1045
00ba1039 xor        esi, esi
00ba103b mov        edi, 0xffffffce
00ba1040 jmp        0x140ba1425
00ba1045 mov        ecx, 0x340
00ba104a call       0x140b930a0
00ba104f mov        rsi, rax
00ba1052 test       rax, rax
00ba1055 jne        0x140ba1061
00ba1057 mov        edi, 0xffffff94
00ba105c jmp        0x140ba1425
00ba1061 mov        dword ptr [rax + 0x20], 0x66726566
00ba1068 lea        rcx, [rbp - 0x50]
00ba106c mov        dword ptr [rax + 0x24], 0x103
00ba1073 mov        rdx, r13
00ba1076 mov        dword ptr [rax + 0x28], 0x64617461
00ba107d add        rax, 0x38
00ba1081 lea        rax, [rax + 0x80]
00ba1088 movups     xmm0, xmmword ptr [rcx]
00ba108b movups     xmm1, xmmword ptr [rcx + 0x10]
00ba108f lea        rcx, [rcx + 0x80]
00ba1096 movups     xmmword ptr [rax - 0x80], xmm0
00ba109a movups     xmm0, xmmword ptr [rcx - 0x60]
00ba109e movups     xmmword ptr [rax - 0x70], xmm1
00ba10a2 movups     xmm1, xmmword ptr [rcx - 0x50]
00ba10a6 movups     xmmword ptr [rax - 0x60], xmm0
00ba10aa movups     xmm0, xmmword ptr [rcx - 0x40]
00ba10ae movups     xmmword ptr [rax - 0x50], xmm1
00ba10b2 movups     xmm1, xmmword ptr [rcx - 0x30]
00ba10b6 movups     xmmword ptr [rax - 0x40], xmm0
00ba10ba movups     xmm0, xmmword ptr [rcx - 0x20]
00ba10be movups     xmmword ptr [rax - 0x30], xmm1
00ba10c2 movups     xmm1, xmmword ptr [rcx - 0x10]
00ba10c6 movups     xmmword ptr [rax - 0x20], xmm0
00ba10ca movups     xmmword ptr [rax - 0x10], xmm1
00ba10ce sub        rdx, 1
00ba10d2 jne        0x140ba1081
00ba10d4 movups     xmm0, xmmword ptr [rcx]
00ba10d7 movups     xmm1, xmmword ptr [rcx + 0x10]
00ba10db movups     xmmword ptr [rax], xmm0
00ba10de movups     xmmword ptr [rax + 0x10], xmm1
00ba10e2 mov        eax, 1
00ba10e7 lock xadd  dword ptr [rip + 0x1471fc9], eax
00ba10ef mov        dword ptr [rsi + 0x258], eax
00ba10f5 mov        rax, qword ptr [rbp - 0x40]
00ba10f9 jmp        0x140ba11fb
00ba10fe mov        rcx, qword ptr [rbp + 0x1e0]
00ba1105 test       rcx, rcx
00ba1108 je         0x140ba1039
00ba110e mov        eax, dword ptr [rbp + 0x1d0]
00ba1114 cmp        eax, 0x41464350
00ba1119 je         0x140ba1126
00ba111b cmp        eax, 0x57696e50
00ba1120 jne        0x140ba1039
00ba1126 cmp        qword ptr [rcx], 0
00ba112a jne        0x140ba1138
00ba112c xor        esi, esi
00ba112e mov        edi, 0xffffffce
00ba1133 jmp        0x140ba1425
00ba1138 mov        ecx, 0x340
00ba113d call       0x140b930a0
00ba1142 mov        rsi, rax
00ba1145 test       rax, rax
00ba1148 jne        0x140ba1154
00ba114a mov        edi, 0xffffff94
00ba114f jmp        0x140ba1425
00ba1154 mov        dword ptr [rax + 0x20], 0x66726566
00ba115b lea        rcx, [rbp + 0x1d0]
00ba1162 mov        dword ptr [rax + 0x24], 0x103
00ba1169 mov        rdx, r13
00ba116c mov        dword ptr [rax + 0x28], 0x64617461
00ba1173 add        rax, 0x38
00ba1177 nop        word ptr [rax + rax]
00ba1180 lea        rax, [rax + 0x80]
00ba1187 movups     xmm0, xmmword ptr [rcx]
00ba118a movups     xmm1, xmmword ptr [rcx + 0x10]
00ba118e lea        rcx, [rcx + 0x80]
00ba1195 movups     xmmword ptr [rax - 0x80], xmm0
00ba1199 movups     xmm0, xmmword ptr [rcx - 0x60]
00ba119d movups     xmmword ptr [rax - 0x70], xmm1
00ba11a1 movups     xmm1, xmmword ptr [rcx - 0x50]
00ba11a5 movups     xmmword ptr [rax - 0x60], xmm0
00ba11a9 movups     xmm0, xmmword ptr [rcx - 0x40]
00ba11ad movups     xmmword ptr [rax - 0x50], xmm1
00ba11b1 movups     xmm1, xmmword ptr [rcx - 0x30]
00ba11b5 movups     xmmword ptr [rax - 0x40], xmm0
00ba11b9 movups     xmm0, xmmword ptr [rcx - 0x20]
00ba11bd movups     xmmword ptr [rax - 0x30], xmm1
00ba11c1 movups     xmm1, xmmword ptr [rcx - 0x10]
00ba11c5 movups     xmmword ptr [rax - 0x20], xmm0
00ba11c9 movups     xmmword ptr [rax - 0x10], xmm1
00ba11cd sub        rdx, 1
00ba11d1 jne        0x140ba1180
00ba11d3 movups     xmm0, xmmword ptr [rcx]
00ba11d6 movups     xmm1, xmmword ptr [rcx + 0x10]
00ba11da movups     xmmword ptr [rax], xmm0
00ba11dd movups     xmmword ptr [rax + 0x10], xmm1
00ba11e1 mov        eax, 1
00ba11e6 lock xadd  dword ptr [rip + 0x1471eca], eax
00ba11ee mov        dword ptr [rsi + 0x258], eax
00ba11f4 mov        rax, qword ptr [rbp + 0x1e0]
00ba11fb mov        rdx, qword ptr [rax]
00ba11fe mov        rcx, rsi
00ba1201 call       rdx
00ba1203 mov        edi, eax
00ba1205 test       eax, eax
00ba1207 je         0x140ba1219
00ba1209 mov        rcx, rsi
00ba120c call       qword ptr [rip + 0xd4b156]
00ba1212 xor        esi, esi
00ba1214 jmp        0x140ba1425
00ba1219 mov        rcx, qword ptr [r15 + 8]
00ba121d call       0x140ba0000
00ba1222 mov        edi, eax
00ba1224 test       eax, eax
00ba1226 jne        0x140ba1425
00ba122c mov        rcx, qword ptr [r15 + 8]
00ba1230 xor        edx, edx
00ba1232 call       0x140ba09a0
00ba1237 mov        edi, eax
00ba1239 test       eax, eax
00ba123b jne        0x140ba1425
00ba1241 mov        rcx, qword ptr [r15 + 8]
00ba1245 lea        rdx, [rsp + 0x58]
00ba124a xor        r12d, r12d
00ba124d call       0x140ba0890
00ba1252 mov        edi, eax
00ba1254 test       eax, eax
00ba1256 jne        0x140ba1420
00ba125c mov        rcx, qword ptr [rsp + 0x58]
00ba1261 mov        ebx, 0xffffffce
00ba1266 test       rcx, rcx
00ba1269 je         0x140ba13d8
00ba126f nop        
00ba1270 mov        rdx, qword ptr [r15 + 0x30]
00ba1274 cmp        r12, rdx
00ba1277 jae        0x140ba1339
00ba127d sub        rdx, r12
00ba1280 cmp        rdx, rcx
00ba1283 cmovb      rcx, rdx
00ba1287 xor        r14b, r14b
00ba128a mov        r8, qword ptr [rsp + 0x48]
00ba128f lea        rdx, [rsp + 0x40]
00ba1294 mov        eax, 0x100000
00ba1299 cmp        rcx, rax
00ba129c cmovb      rax, rcx
00ba12a0 mov        rcx, qword ptr [r15 + 8]
00ba12a4 mov        qword ptr [rsp + 0x40], rax
00ba12a9 call       0x140ba0350
00ba12ae mov        edi, eax
00ba12b0 test       eax, eax
00ba12b2 jne        0x140ba141b
00ba12b8 test       r14b, r14b
00ba12bb je         0x140ba136d
00ba12c1 mov        rcx, qword ptr [r15 + 0x40]
00ba12c5 test       rcx, rcx
00ba12c8 je         0x140ba136d
00ba12ce mov        r14, qword ptr [rsp + 0x40]
00ba12d3 lea        rax, [rsp + 0x40]
00ba12d8 mov        rdi, qword ptr [rsp + 0x38]
00ba12dd mov        r8d, r14d
00ba12e0 mov        rdx, qword ptr [rsp + 0x48]
00ba12e5 mov        r9, rdi
00ba12e8 mov        dword ptr [rsp + 0x40], r14d
00ba12ed mov        qword ptr [rsp + 0x20], rax
00ba12f2 call       0x140bfc580
00ba12f7 mov        eax, dword ptr [rsp + 0x40]
00ba12fb cmp        rax, r14
00ba12fe jne        0x140ba1416
00ba1304 mov        qword ptr [rsp + 0x50], rax
00ba1309 test       rsi, rsi
00ba130c je         0x140ba13ad
00ba1312 cmp        dword ptr [rsi + 0x20], 0x66726566
00ba1319 jne        0x140ba13ad
00ba131f test       rdi, rdi
00ba1322 je         0x140ba13ad
00ba1328 mov        rax, qword ptr [rsi + 0x2b8]
00ba132f test       rax, rax
00ba1332 je         0x140ba13ad
00ba1334 mov        rdx, rdi
00ba1337 jmp        0x140ba1391
00ba1339 mov        r8, qword ptr [r15 + 0x38]
00ba133d test       r8, r8
00ba1340 jne        0x140ba134a
00ba1342 mov        r14b, 1
00ba1345 jmp        0x140ba128a
00ba134a lea        rax, [rdx + r8]
00ba134e cmp        r12, rax
00ba1351 jae        0x140ba1287
00ba1357 sub        rdx, r12
00ba135a mov        r14b, 1
00ba135d lea        rax, [rdx + r8]
00ba1361 cmp        rax, rcx
00ba1364 cmovb      rcx, rax
00ba1368 jmp        0x140ba128a
00ba136d mov        r14, qword ptr [rsp + 0x40]
00ba1372 test       rsi, rsi
00ba1375 je         0x140ba13ad
00ba1377 cmp        dword ptr [rsi + 0x20], 0x66726566
00ba137e jne        0x140ba13ad
00ba1380 mov        rax, qword ptr [rsi + 0x2b8]
00ba1387 test       rax, rax
00ba138a je         0x140ba13ad
00ba138c mov        rdx, qword ptr [rsp + 0x48]
00ba1391 lea        rcx, [rsp + 0x50]
00ba1396 mov        r9d, 1
00ba139c mov        qword ptr [rsp + 0x20], rcx
00ba13a1 mov        r8, r14
00ba13a4 mov        rcx, rsi
00ba13a7 call       rax
00ba13a9 mov        edi, eax
00ba13ab jmp        0x140ba13af
00ba13ad mov        edi, ebx
00ba13af test       edi, edi
00ba13b1 jne        0x140ba141b
00ba13b3 cmp        qword ptr [rsp + 0x50], r14
00ba13b8 jne        0x140ba1416
00ba13ba mov        rcx, qword ptr [rsp + 0x58]
00ba13bf add        r12, r14
00ba13c2 sub        rcx, r14
00ba13c5 mov        qword ptr [rsp + 0x58], rcx
00ba13ca test       rcx, rcx
00ba13cd jne        0x140ba1270
00ba13d3 mov        r14, qword ptr [rsp + 0x38]
00ba13d8 cmp        dword ptr [rbp + 0x1d0], 0x41464350
00ba13e2 jne        0x140ba1420
00ba13e4 test       rsi, rsi
00ba13e7 je         0x140ba1522
00ba13ed cmp        dword ptr [rsi + 0x20], 0x66726566
00ba13f4 jne        0x140ba1522
00ba13fa mov        rax, qword ptr [rsi + 0x270]
00ba1401 test       rax, rax
00ba1404 je         0x140ba1522
00ba140a mov        rdx, r12
00ba140d mov        rcx, rsi
00ba1410 call       rax
00ba1412 mov        edi, eax
00ba1414 jmp        0x140ba1420
00ba1416 mov        edi, 0xffffffdc
00ba141b mov        r14, qword ptr [rsp + 0x38]
00ba1420 mov        r12d, dword ptr [rsp + 0x34]
00ba1425 mov        rcx, qword ptr [rsp + 0x48]
00ba142a call       qword ptr [rip + 0xd4af38]
00ba1430 test       r14, r14
00ba1433 je         0x140ba143e
00ba1435 mov        rcx, r14
00ba1438 call       qword ptr [rip + 0xd4af2a]
00ba143e test       rsi, rsi
00ba1441 je         0x140ba146d
00ba1443 cmp        dword ptr [rsi + 0x20], 0x66726566
00ba144a jne        0x140ba146d
00ba144c mov        rax, qword ptr [rsi + 0x260]
00ba1453 test       rax, rax
00ba1456 je         0x140ba146d
00ba1458 mov        rcx, rsi
00ba145b call       rax
00ba145d mov        dword ptr [rsi + 0x20], 0
00ba1464 mov        rcx, rsi
00ba1467 call       qword ptr [rip + 0xd4aefb]
00ba146d cmp        byte ptr [rsp + 0x31], 0
00ba1472 je         0x140ba1677
00ba1478 test       edi, edi
00ba147a jne        0x140ba1639
00ba1480 cmp        byte ptr [rsp + 0x30], dil
00ba1485 je         0x140ba1581
00ba148b mov        r8, qword ptr [rbp + 0x1e0]
00ba1492 test       r8, r8
00ba1495 je         0x140ba1529
00ba149b mov        edx, dword ptr [rbp + 0x1d0]
00ba14a1 cmp        edx, 0x41464350
00ba14a7 je         0x140ba14b1
00ba14a9 cmp        edx, 0x57696e50
00ba14af jne        0x140ba1529
00ba14b1 mov        rcx, qword ptr [rbp - 0x40]
00ba14b5 mov        eax, dword ptr [rbp - 0x50]
00ba14b8 test       rcx, rcx
00ba14bb je         0x140ba15bd
00ba14c1 cmp        eax, 0x41464350
00ba14c6 je         0x140ba14cf
00ba14c8 cmp        eax, 0x57696e50
00ba14cd jne        0x140ba1530
00ba14cf mov        r9, qword ptr [r8 + 0xb8]
00ba14d6 test       r9, r9
00ba14d9 je         0x140ba1530
00ba14db cmp        edx, eax
00ba14dd jne        0x140ba1530
00ba14df lea        rdx, [rbp - 0x50]
00ba14e3 lea        rcx, [rbp + 0x1d0]
00ba14ea call       r9
00ba14ed test       eax, eax
00ba14ef jne        0x140ba1529
00ba14f1 test       r12b, r12b
00ba14f4 je         0x140ba1502
00ba14f6 lea        rcx, [rbp + 0x1d0]
00ba14fd call       0x140aee0b0
00ba1502 xor        r9d, r9d
00ba1505 mov        qword ptr [rsp + 0x20], 0
00ba150e xor        r8d, r8d
00ba1511 lea        rcx, [rbp - 0x50]
00ba1515 xorps      xmm1, xmm1
00ba1518 call       0x140b23e10
00ba151d jmp        0x140ba15bd
00ba1522 mov        edi, ebx
00ba1524 jmp        0x140ba1420
00ba1529 mov        eax, dword ptr [rbp - 0x50]
00ba152c mov        rcx, qword ptr [rbp - 0x40]
00ba1530 test       rcx, rcx
00ba1533 je         0x140ba15bd
00ba1539 cmp        eax, 0x41464350
00ba153e je         0x140ba1547
00ba1540 cmp        eax, 0x57696e50
00ba1545 jne        0x140ba15bd
00ba1547 mov        rax, qword ptr [rcx + 8]
00ba154b lea        rdx, [rsp + 0x60]
00ba1550 lea        rcx, [rbp - 0x50]
00ba1554 xor        r8d, r8d
00ba1557 call       rax
00ba1559 test       eax, eax
00ba155b jne        0x140ba15bd
00ba155d cmp        byte ptr [rsp + 0x60], al
00ba1561 jne        0x140ba15bd
00ba1563 xor        r9d, r9d
00ba1566 mov        qword ptr [rsp + 0x20], 0
00ba156f xor        r8d, r8d
00ba1572 lea        rcx, [rbp + 0x1d0]
00ba1579 xorps      xmm1, xmm1
00ba157c call       0x140b23e10
00ba1581 mov        rcx, qword ptr [rbp - 0x40]
00ba1585 mov        rdx, qword ptr [r15 + 0x28]
00ba1589 test       rcx, rcx
00ba158c je         0x140ba15bd
00ba158e mov        eax, dword ptr [rbp - 0x50]
00ba1591 cmp        eax, 0x41464350
00ba1596 je         0x140ba159f
00ba1598 cmp        eax, 0x57696e50
00ba159d jne        0x140ba15bd
00ba159f test       rdx, rdx
00ba15a2 je         0x140ba15bd
00ba15a4 mov        rax, qword ptr [rcx + 0x90]
00ba15ab test       rax, rax
00ba15ae je         0x140ba15bd
00ba15b0 lea        r8, [rbp + 0x1d0]
00ba15b7 lea        rcx, [rbp - 0x50]
00ba15bb call       rax
00ba15bd mov        rax, qword ptr [r15 + 0x48]
00ba15c1 test       rax, rax
00ba15c4 je         0x140ba172f
00ba15ca lea        rcx, [rbp + 0x1d0]
00ba15d1 lea        rax, [rax + 0x80]
00ba15d8 movups     xmm0, xmmword ptr [rcx]
00ba15db lea        rcx, [rcx + 0x80]
00ba15e2 movups     xmmword ptr [rax - 0x80], xmm0
00ba15e6 movups     xmm1, xmmword ptr [rcx - 0x70]
00ba15ea movups     xmmword ptr [rax - 0x70], xmm1
00ba15ee movups     xmm0, xmmword ptr [rcx - 0x60]
00ba15f2 movups     xmmword ptr [rax - 0x60], xmm0
00ba15f6 movups     xmm1, xmmword ptr [rcx - 0x50]
00ba15fa movups     xmmword ptr [rax - 0x50], xmm1
00ba15fe movups     xmm0, xmmword ptr [rcx - 0x40]
00ba1602 movups     xmmword ptr [rax - 0x40], xmm0
00ba1606 movups     xmm1, xmmword ptr [rcx - 0x30]
00ba160a movups     xmmword ptr [rax - 0x30], xmm1
00ba160e movups     xmm0, xmmword ptr [rcx - 0x20]
00ba1612 movups     xmmword ptr [rax - 0x20], xmm0
00ba1616 movups     xmm1, xmmword ptr [rcx - 0x10]
00ba161a movups     xmmword ptr [rax - 0x10], xmm1
00ba161e sub        r13, 1
00ba1622 jne        0x140ba15d1
00ba1624 movups     xmm0, xmmword ptr [rcx]
00ba1627 movups     xmmword ptr [rax], xmm0
00ba162a movups     xmm1, xmmword ptr [rcx + 0x10]
00ba162e movups     xmmword ptr [rax + 0x10], xmm1
00ba1632 mov        eax, edi
00ba1634 jmp        0x140ba0c7c
00ba1639 mov        rax, qword ptr [rbp - 0x40]
00ba163d test       rax, rax
00ba1640 je         0x140ba172f
00ba1646 mov        ecx, dword ptr [rbp - 0x50]
00ba1649 cmp        ecx, 0x41464350
00ba164f je         0x140ba165d
00ba1651 cmp        ecx, 0x57696e50
00ba1657 jne        0x140ba172f
00ba165d mov        rax, qword ptr [rax + 0x78]
00ba1661 test       rax, rax
00ba1664 je         0x140ba172f
00ba166a lea        rcx, [rbp - 0x50]
00ba166e call       rax
00ba1670 mov        eax, edi
00ba1672 jmp        0x140ba0c7c
00ba1677 test       edi, edi
00ba1679 jne        0x140ba16fb
00ba167f mov        rax, qword ptr [r15 + 0x48]
00ba1683 test       rax, rax
00ba1686 je         0x140ba172f
00ba168c lea        rcx, [rbp + 0x1d0]
00ba1693 lea        rax, [rax + 0x80]
00ba169a movups     xmm0, xmmword ptr [rcx]
00ba169d lea        rcx, [rcx + 0x80]
00ba16a4 movups     xmmword ptr [rax - 0x80], xmm0
00ba16a8 movups     xmm1, xmmword ptr [rcx - 0x70]
00ba16ac movups     xmmword ptr [rax - 0x70], xmm1
00ba16b0 movups     xmm0, xmmword ptr [rcx - 0x60]
00ba16b4 movups     xmmword ptr [rax - 0x60], xmm0
00ba16b8 movups     xmm1, xmmword ptr [rcx - 0x50]
00ba16bc movups     xmmword ptr [rax - 0x50], xmm1
00ba16c0 movups     xmm0, xmmword ptr [rcx - 0x40]
00ba16c4 movups     xmmword ptr [rax - 0x40], xmm0
00ba16c8 movups     xmm1, xmmword ptr [rcx - 0x30]
00ba16cc movups     xmmword ptr [rax - 0x30], xmm1
00ba16d0 movups     xmm0, xmmword ptr [rcx - 0x20]
00ba16d4 movups     xmmword ptr [rax - 0x20], xmm0
00ba16d8 movups     xmm1, xmmword ptr [rcx - 0x10]
00ba16dc movups     xmmword ptr [rax - 0x10], xmm1
00ba16e0 sub        r13, 1
00ba16e4 jne        0x140ba1693
00ba16e6 movups     xmm0, xmmword ptr [rcx]
00ba16e9 movups     xmmword ptr [rax], xmm0
00ba16ec movups     xmm1, xmmword ptr [rcx + 0x10]
00ba16f0 movups     xmmword ptr [rax + 0x10], xmm1
00ba16f4 mov        eax, edi
00ba16f6 jmp        0x140ba0c7c
00ba16fb mov        rax, qword ptr [rbp + 0x1e0]
00ba1702 test       rax, rax
00ba1705 je         0x140ba172f
00ba1707 mov        ecx, dword ptr [rbp + 0x1d0]
00ba170d cmp        ecx, 0x41464350
00ba1713 je         0x140ba171d
00ba1715 cmp        ecx, 0x57696e50
00ba171b jne        0x140ba172f
00ba171d mov        rax, qword ptr [rax + 0x78]
00ba1721 test       rax, rax
00ba1724 je         0x140ba172f
00ba1726 lea        rcx, [rbp + 0x1d0]
00ba172d call       rax
00ba172f mov        eax, edi
00ba1731 jmp        0x140ba0c7c
00ba1736 mov        ebx, 0xffffffce
00ba173b mov        eax, ebx
00ba173d jmp        0x140ba0c7c
; range 0xba1742..0xba174c (exclusive)
00ba1742 mov        eax, 0xffffffce
00ba1747 jmp        0x140ba0c94
