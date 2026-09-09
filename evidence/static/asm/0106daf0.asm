; Original iTunes.exe machine code; base=0x140000000; RVA=0x106daf0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x106daf0..0x106db3f (exclusive)
0106daf0 mov        r11, rsp
0106daf3 push       rbp
0106daf4 push       rsi
0106daf5 push       r14
0106daf7 push       r15
0106daf9 lea        rbp, [r11 - 0x238]
0106db00 sub        rsp, 0x318
0106db07 mov        rax, qword ptr [rip + 0xf67532]
0106db0e xor        rax, rsp
0106db11 mov        qword ptr [rbp + 0x1f0], rax
0106db18 mov        rsi, rdx
0106db1b mov        r15, rcx
0106db1e test       rdx, rdx
0106db21 je         0x14107027c
0106db27 mov        r14, qword ptr [rdx + 8]
0106db2b test       r14, r14
0106db2e je         0x14107027c
0106db34 cmp        qword ptr [r14 + 0x10], 0
0106db39 je         0x14107027c
; range 0x106db3f..0x107027c (exclusive)
0106db3f mov        qword ptr [r11 + 0x18], rbx
0106db43 lea        rax, [rcx + 0xa0041c]
0106db4a mov        qword ptr [r11 - 0x28], rdi
0106db4e lea        rdi, [rcx + 0xa00128]
0106db55 mov        qword ptr [r11 - 0x30], r12
0106db59 mov        qword ptr [r11 - 0x38], r13
0106db5d mov        r13, qword ptr [rcx + 0x1e00270]
0106db64 mov        qword ptr [rsp + 0x48], rax
0106db69 test       rdi, rdi
0106db6c je         0x14106db82
0106db6e add        rcx, 0xa00130
0106db75 xor        edx, edx
0106db77 mov        r8d, 0x2ec
0106db7d call       0x14179cca0
0106db82 mov        dword ptr [rdi], 0x6874696d
0106db88 xor        r12d, r12d
0106db8b mov        dword ptr [rdi + 4], 0x2f4
0106db92 mov        eax, dword ptr [r14 + 8]
0106db96 mov        dword ptr [rdi + 0x10], eax
0106db99 mov        eax, dword ptr [rsi + 0x28]
0106db9c mov        dword ptr [rdi + 0x1f4], eax
0106dba2 mov        eax, dword ptr [rsi + 0x54]
0106dba5 mov        dword ptr [rdi + 0x20], eax
0106dba8 mov        eax, dword ptr [rsi + 0x58]
0106dbab mov        dword ptr [rdi + 0x78], eax
0106dbae mov        rax, qword ptr [rsi + 0x60]
0106dbb2 mov        qword ptr [rdi + 0x144], rax
0106dbb9 mov        eax, dword ptr [rsi + 0x5c]
0106dbbc mov        dword ptr [rdi + 0x28], eax
0106dbbf movzx      eax, word ptr [r14 + 0x10a]
0106dbc7 mov        dword ptr [rdi + 0x2c], eax
0106dbca movzx      eax, word ptr [r14 + 0x10c]
0106dbd2 mov        dword ptr [rdi + 0x30], eax
0106dbd5 movzx      eax, word ptr [r14 + 0x10e]
0106dbdd mov        word ptr [rdi + 0x68], ax
0106dbe1 movzx      eax, word ptr [r14 + 0x110]
0106dbe9 mov        word ptr [rdi + 0x6a], ax
0106dbed movzx      eax, byte ptr [r14 + 0x9a]
0106dbf5 shr        al, 4
0106dbf8 and        al, 1
0106dbfa mov        byte ptr [rdi + 0x6d], al
0106dbfd movsx      eax, word ptr [r14 + 0xa6]
0106dc05 mov        dword ptr [rdi + 0x34], eax
0106dc08 movzx      eax, byte ptr [r14 + 0x9b]
0106dc10 shr        al, 2
0106dc13 and        al, 1
0106dc15 mov        byte ptr [rdi + 0x53], al
0106dc18 movzx      eax, word ptr [rsi + 0x4c]
0106dc1c mov        dword ptr [rdi + 0x38], eax
0106dc1f mov        eax, dword ptr [rsi + 0x48]
0106dc22 mov        dword ptr [rdi + 0x98], eax
0106dc28 movzx      eax, word ptr [rsi + 0x4e]
0106dc2c mov        word ptr [rdi + 0x20a], ax
0106dc33 movsx      eax, word ptr [r14 + 0x102]
0106dc3b mov        dword ptr [rdi + 0x40], eax
0106dc3e mov        rax, qword ptr [r14 + 0x78]
0106dc42 mov        ecx, dword ptr [rax + 4]
0106dc45 mov        dword ptr [rdi + 0x44], ecx
0106dc48 mov        rax, qword ptr [r14 + 0x78]
0106dc4c mov        ecx, dword ptr [rax + 8]
0106dc4f mov        dword ptr [rdi + 0x48], ecx
0106dc52 mov        eax, dword ptr [r14 + 0x114]
0106dc59 mov        dword ptr [rdi + 0x4c], eax
0106dc5c mov        eax, dword ptr [r14 + 0x118]
0106dc63 mov        dword ptr [rdi + 0x60], eax
0106dc66 mov        eax, dword ptr [r14 + 0x11c]
0106dc6d mov        dword ptr [rdi + 0x64], eax
0106dc70 mov        eax, dword ptr [r14 + 0x120]
0106dc77 mov        dword ptr [rdi + 0xd8], eax
0106dc7d mov        eax, dword ptr [r14 + 0x124]
0106dc84 mov        dword ptr [rdi + 0x118], eax
0106dc8a mov        eax, dword ptr [r14 + 0x128]
0106dc91 mov        dword ptr [rdi + 0x11c], eax
0106dc97 mov        rax, qword ptr [rsi + 0x10]
0106dc9b mov        rcx, qword ptr [rax + 0x20]
0106dc9f mov        qword ptr [rdi + 0x19c], rcx
0106dca6 mov        rax, qword ptr [rsi + 0x10]
0106dcaa mov        rcx, qword ptr [rax + 8]
0106dcae mov        qword ptr [rdi + 0x194], rcx
0106dcb5 mov        rax, qword ptr [rsi + 0x10]
0106dcb9 mov        rcx, qword ptr [rax + 0x10]
0106dcbd mov        qword ptr [rdi + 0x1a4], rcx
0106dcc4 mov        rax, qword ptr [rsi + 0x10]
0106dcc8 mov        rcx, qword ptr [rax + 0x18]
0106dccc mov        qword ptr [rdi + 0x20c], rcx
0106dcd3 mov        rax, qword ptr [rsi + 8]
0106dcd7 test       rax, rax
0106dcda je         0x14106dcec
0106dcdc cmp        qword ptr [rax + 0x10], r12
0106dce0 je         0x14106dcec
0106dce2 mov        rax, qword ptr [rsi + 0x10]
0106dce6 mov        rcx, qword ptr [rax + 0x38]
0106dcea jmp        0x14106dcef
0106dcec mov        rcx, r12
0106dcef mov        qword ptr [rdi + 0x1ac], rcx
0106dcf6 mov        rax, qword ptr [rsi + 0x10]
0106dcfa mov        rcx, qword ptr [rax + 0x48]
0106dcfe mov        qword ptr [rdi + 0x1bc], rcx
0106dd05 mov        rax, qword ptr [rsi + 0x10]
0106dd09 mov        rcx, qword ptr [rax + 0x58]
0106dd0d mov        qword ptr [rdi + 0x1cc], rcx
0106dd14 mov        rax, qword ptr [rsi + 0x10]
0106dd18 mov        rcx, qword ptr [rax + 0x40]
0106dd1c mov        qword ptr [rdi + 0x1b4], rcx
0106dd23 mov        rax, qword ptr [rsi + 0x10]
0106dd27 mov        rcx, qword ptr [rax + 0x50]
0106dd2b mov        qword ptr [rdi + 0x1c4], rcx
0106dd32 mov        rax, qword ptr [rsi + 0x10]
0106dd36 mov        rcx, qword ptr [rax + 0x60]
0106dd3a mov        qword ptr [rdi + 0x1d4], rcx
0106dd41 mov        rax, qword ptr [rsi + 0x10]
0106dd45 mov        ecx, dword ptr [rax + 0x20]
0106dd48 mov        dword ptr [rdi + 0x160], ecx
0106dd4e mov        rax, qword ptr [rsi + 0x10]
0106dd52 mov        ecx, dword ptr [rax + 8]
0106dd55 mov        dword ptr [rdi + 0x70], ecx
0106dd58 mov        rax, qword ptr [rsi + 0x10]
0106dd5c mov        ecx, dword ptr [rax + 0x10]
0106dd5f mov        dword ptr [rdi + 0x88], ecx
0106dd65 mov        rax, qword ptr [rsi + 8]
0106dd69 test       rax, rax
0106dd6c je         0x14106dd7e
0106dd6e cmp        qword ptr [rax + 0x10], r12
0106dd72 je         0x14106dd7e
0106dd74 mov        rax, qword ptr [rsi + 0x10]
0106dd78 mov        rcx, qword ptr [rax + 0x38]
0106dd7c jmp        0x14106dd81
0106dd7e mov        rcx, r12
0106dd81 mov        dword ptr [rdi + 0xa8], ecx
0106dd87 mov        rax, qword ptr [rsi + 0x10]
0106dd8b mov        ecx, dword ptr [rax + 0x48]
0106dd8e mov        dword ptr [rdi + 0xb0], ecx
0106dd94 mov        rax, qword ptr [rsi + 0x10]
0106dd98 mov        ecx, dword ptr [rax + 0x58]
0106dd9b mov        dword ptr [rdi + 0xb8], ecx
0106dda1 mov        rax, qword ptr [rsi + 0x10]
0106dda5 mov        ecx, dword ptr [rax + 0x40]
0106dda8 mov        dword ptr [rdi + 0xac], ecx
0106ddae mov        rax, qword ptr [rsi + 0x10]
0106ddb2 mov        ecx, dword ptr [rax + 0x50]
0106ddb5 mov        dword ptr [rdi + 0xb4], ecx
0106ddbb mov        rax, qword ptr [rsi + 0x10]
0106ddbf mov        ecx, dword ptr [rax + 0x60]
0106ddc2 mov        dword ptr [rdi + 0xe4], ecx
0106ddc8 mov        rax, qword ptr [rsi + 0x10]
0106ddcc mov        ecx, dword ptr [rax + 0x88]
0106ddd2 mov        dword ptr [rdi + 0x9c], ecx
0106ddd8 mov        rax, qword ptr [r14 + 0x68]
0106dddc movzx      ecx, byte ptr [rax + 1]
0106dde0 mov        byte ptr [rdi + 0x52], cl
0106dde3 mov        rax, qword ptr [r14 + 0x68]
0106dde7 mov        ecx, dword ptr [rax + 4]
0106ddea mov        dword ptr [rdi + 0xbc], ecx
0106ddf0 mov        eax, dword ptr [r14 + 0xfc]
0106ddf7 mov        dword ptr [rdi + 0x74], eax
0106ddfa movzx      eax, word ptr [rsi + 0x52]
0106ddfe mov        dword ptr [rdi + 0x58], eax
0106de01 mov        eax, dword ptr [rsi + 0x2f4]
0106de07 mov        dword ptr [rdi + 0xf0], eax
0106de0d mov        eax, dword ptr [rsi + 0x2f8]
0106de13 mov        dword ptr [rdi + 0x100], eax
0106de19 mov        rax, qword ptr [rsi + 0x2e0]
0106de20 mov        qword ptr [rdi + 0xf4], rax
0106de27 mov        rax, qword ptr [rsi + 0x2e8]
0106de2e mov        qword ptr [rdi + 0x120], rax
0106de35 mov        eax, dword ptr [rsi + 0x2f0]
0106de3b mov        dword ptr [rdi + 0x104], eax
0106de41 mov        rcx, qword ptr [r14 + 0x10]
0106de45 movzx      eax, byte ptr [r14 + 0x105]
0106de4d test       rcx, rcx
0106de50 je         0x14106e22c
0106de56 test       byte ptr [rcx + 0x114], 8
0106de5d je         0x14106e22c
0106de63 cmp        al, 0x20
0106de65 jae        0x14106e241
0106de6b movzx      eax, byte ptr [r14 + 0x104]
0106de73 mov        byte ptr [rdi + 0x6c], al
0106de76 mov        rax, qword ptr [r14 + 0x78]
0106de7a mov        ecx, dword ptr [rax + 0xc]
0106de7d mov        dword ptr [rdi + 0x7c], ecx
0106de80 mov        rax, qword ptr [r14 + 0x78]
0106de84 mov        ecx, dword ptr [rax + 0x14]
0106de87 mov        dword ptr [rdi + 0x270], ecx
0106de8d mov        rax, qword ptr [r14]
0106de90 mov        qword ptr [rdi + 0x80], rax
0106de97 mov        eax, dword ptr [rsi + 0x38]
0106de9a mov        dword ptr [rdi + 0x8c], eax
0106dea0 movzx      eax, byte ptr [r14 + 0x9a]
0106dea8 shr        al, 2
0106deab and        al, 1
0106dead mov        byte ptr [rdi + 0x6e], al
0106deb0 movzx      eax, word ptr [rsi + 0x6c]
0106deb4 mov        word ptr [rdi + 0x90], ax
0106debb movzx      eax, word ptr [rsi + 0x6e]
0106debf mov        word ptr [rdi + 0x92], ax
0106dec6 mov        eax, dword ptr [rsi + 0x70]
0106dec9 mov        dword ptr [rdi + 0x94], eax
0106decf movzx      eax, byte ptr [r14 + 0x9b]
0106ded7 shr        al, 3
0106deda and        al, 1
0106dedc mov        byte ptr [rdi + 0xa7], al
0106dee2 movzx      eax, byte ptr [r14 + 0x9b]
0106deea shr        al, 4
0106deed and        al, 1
0106deef mov        byte ptr [rdi + 0x231], al
0106def5 movzx      eax, byte ptr [rsi + 0x44]
0106def9 mov        byte ptr [rdi + 0x6f], al
0106defc movzx      eax, byte ptr [rsi + 0x3f]
0106df00 mov        byte ptr [rdi + 0x128], al
0106df06 mov        rax, qword ptr [rsi + 0x10]
0106df0a mov        ecx, dword ptr [rax + 0x8c]
0106df10 mov        dword ptr [rdi + 0xa0], ecx
0106df16 movzx      eax, word ptr [r14 + 0x12c]
0106df1e mov        word ptr [rdi + 0xa4], ax
0106df25 movzx      eax, byte ptr [r14 + 0x90]
0106df2d mov        byte ptr [rdi + 0xa6], al
0106df33 movzx      eax, byte ptr [r14 + 0x9c]
0106df3b shr        al, 4
0106df3e and        al, 1
0106df40 mov        byte ptr [rdi + 0xc8], al
0106df46 mov        rax, qword ptr [rsi + 0x2d8]
0106df4d mov        qword ptr [rdi + 0xcc], rax
0106df54 mov        rax, qword ptr [rsi + 0x10]
0106df58 mov        ecx, dword ptr [rax + 0x84]
0106df5e mov        dword ptr [rdi + 0xd4], ecx
0106df64 movzx      eax, byte ptr [rsi + 0x41]
0106df68 and        al, 1
0106df6a mov        byte ptr [rdi + 0xc9], al
0106df70 mov        rax, qword ptr [rsi + 0x10]
0106df74 mov        ecx, dword ptr [rax + 4]
0106df77 mov        dword ptr [rdi + 0x1ec], ecx
0106df7d movzx      eax, byte ptr [rsi + 0x41]
0106df81 shr        al, 3
0106df84 and        al, 1
0106df86 mov        byte ptr [rdi + 0x1dd], al
0106df8c movzx      eax, byte ptr [r14 + 0x9d]
0106df94 shr        al, 3
0106df97 and        al, 1
0106df99 mov        byte ptr [rdi + 0xca], al
0106df9f movzx      eax, byte ptr [r14 + 0x9b]
0106dfa7 shr        al, 6
0106dfaa and        al, 1
0106dfac mov        byte ptr [rdi + 0xcb], al
0106dfb2 movzx      eax, byte ptr [r14 + 0x9b]
0106dfba shr        al, 7
0106dfbd mov        byte ptr [rdi + 0xe8], al
0106dfc3 movzx      eax, byte ptr [r14 + 0x9d]
0106dfcb and        al, 1
0106dfcd mov        byte ptr [rdi + 0xea], al
0106dfd3 movzx      eax, byte ptr [r14 + 0x9d]
0106dfdb shr        al, 1
0106dfdd and        al, 1
0106dfdf mov        byte ptr [rdi + 0xed], al
0106dfe5 mov        eax, dword ptr [rsi + 0x74]
0106dfe8 mov        dword ptr [rdi + 0xfc], eax
0106dfee mov        eax, dword ptr [r14 + 0xe0]
0106dff5 mov        dword ptr [rdi + 0x290], eax
0106dffb mov        eax, dword ptr [r14 + 0xe4]
0106e002 mov        dword ptr [rdi + 0x294], eax
0106e008 mov        eax, dword ptr [r14 + 0xe8]
0106e00f mov        dword ptr [rdi + 0x298], eax
0106e015 mov        eax, dword ptr [r14 + 0xec]
0106e01c mov        dword ptr [rdi + 0x29c], eax
0106e022 mov        eax, dword ptr [r14 + 0xf0]
0106e029 mov        dword ptr [rdi + 0x2a0], eax
0106e02f mov        eax, dword ptr [r14 + 0xf4]
0106e036 mov        dword ptr [rdi + 0x2a4], eax
0106e03c mov        eax, dword ptr [r14 + 0xf8]
0106e043 mov        dword ptr [rdi + 0x2a8], eax
0106e049 mov        eax, dword ptr [rsi + 0x68]
0106e04c mov        dword ptr [rdi + 0xc0], eax
0106e052 movzx      eax, word ptr [r14 + 0x100]
0106e05a mov        dword ptr [rdi + 0xc4], eax
0106e060 movzx      eax, byte ptr [r14 + 0x9d]
0106e068 shr        al, 6
0106e06b and        al, 1
0106e06d mov        byte ptr [rdi + 0xeb], al
0106e073 movzx      eax, byte ptr [r14 + 0x9d]
0106e07b shr        al, 5
0106e07e and        al, 1
0106e080 mov        byte ptr [rdi + 0x214], al
0106e086 movzx      eax, byte ptr [r14 + 0x9a]
0106e08e shr        al, 7
0106e091 mov        byte ptr [rdi + 0x215], al
0106e097 movzx      eax, byte ptr [r14 + 0x9d]
0106e09f shr        al, 7
0106e0a2 mov        byte ptr [rdi + 0xec], al
0106e0a8 movzx      eax, byte ptr [r14 + 0x9e]
0106e0b0 and        al, 1
0106e0b2 mov        byte ptr [rdi + 0x27d], al
0106e0b8 movzx      eax, byte ptr [r14 + 0x9f]
0106e0c0 shr        al, 4
0106e0c3 and        al, 1
0106e0c5 mov        byte ptr [rdi + 0x27e], al
0106e0cb movzx      eax, byte ptr [r14 + 0x9f]
0106e0d3 shr        al, 5
0106e0d6 and        al, 1
0106e0d8 mov        byte ptr [rdi + 0x27f], al
0106e0de movzx      eax, byte ptr [r14 + 0x9e]
0106e0e6 shr        al, 1
0106e0e8 and        al, 1
0106e0ea mov        byte ptr [rdi + 0xef], al
0106e0f0 movzx      eax, byte ptr [r14 + 0x9e]
0106e0f8 shr        al, 2
0106e0fb and        al, 1
0106e0fd mov        byte ptr [rdi + 0xee], al
0106e103 mov        rax, qword ptr [r14 + 0x70]
0106e107 mov        ecx, dword ptr [rax + 8]
0106e10a mov        dword ptr [rdi + 0x110], ecx
0106e110 mov        rax, qword ptr [r14 + 0x70]
0106e114 mov        ecx, dword ptr [rax + 4]
0106e117 mov        dword ptr [rdi + 0x10c], ecx
0106e11d mov        eax, dword ptr [r14 + 0xac]
0106e124 mov        dword ptr [rdi + 0x274], eax
0106e12a mov        rax, qword ptr [r14 + 0x68]
0106e12e mov        ecx, dword ptr [rax + 0x10]
0106e131 mov        dword ptr [rdi + 0x1f8], ecx
0106e137 mov        rcx, r14
0106e13a movzx      eax, byte ptr [r14 + 0x9e]
0106e142 shr        al, 3
0106e145 and        al, 1
0106e147 mov        byte ptr [rdi + 0x114], al
0106e14d movzx      eax, byte ptr [r14 + 0x9c]
0106e155 and        al, 1
0106e157 mov        byte ptr [rdi + 0x116], al
0106e15d movzx      eax, byte ptr [rsi + 0x40]
0106e161 shr        al, 3
0106e164 and        al, 1
0106e166 mov        byte ptr [rdi + 0x117], al
0106e16c call       0x140fa2c40
0106e171 mov        rcx, r14
0106e174 mov        qword ptr [rdi + 0x12c], rax
0106e17b call       0x140fa2cd0
0106e180 mov        rcx, r14
0106e183 mov        qword ptr [rdi + 0x264], rax
0106e18a call       0x140fa2aa0
0106e18f mov        byte ptr [rdi + 0x129], al
0106e195 cmp        al, 0xc
0106e197 jb         0x14106e1a0
0106e199 mov        byte ptr [rdi + 0x129], r12b
0106e1a0 movzx      eax, byte ptr [rsi + 0x3e]
0106e1a4 mov        byte ptr [rdi + 0x230], al
0106e1aa movzx      eax, byte ptr [rsi + 0x41]
0106e1ae shr        al, 4
0106e1b1 and        al, 1
0106e1b3 mov        byte ptr [rdi + 0x19], al
0106e1b6 movzx      eax, byte ptr [rsi + 0x41]
0106e1ba shr        al, 5
0106e1bd and        al, 1
0106e1bf mov        byte ptr [rdi + 0x216], al
0106e1c5 movzx      eax, byte ptr [rsi + 0x41]
0106e1c9 shr        al, 6
0106e1cc and        al, 1
0106e1ce mov        byte ptr [rdi + 0x18], al
0106e1d1 movzx      eax, byte ptr [r14 + 0x9c]
0106e1d9 shr        al, 1
0106e1db and        al, 1
0106e1dd mov        byte ptr [rdi + 0xe9], al
0106e1e3 mov        rax, qword ptr [r14 + 0x140]
0106e1ea mov        qword ptr [rdi + 0x134], rax
0106e1f1 mov        rax, qword ptr [r14 + 0x148]
0106e1f8 mov        qword ptr [rdi + 0x13c], rax
0106e1ff movzx      eax, byte ptr [rsi + 0x42]
0106e203 shr        al, 5
0106e206 and        al, 1
0106e208 mov        byte ptr [rdi + 0x26e], al
0106e20e movzx      eax, byte ptr [r14 + 0x9f]
0106e216 shr        al, 2
0106e219 and        al, 1
0106e21b mov        byte ptr [rdi + 0x26f], al
0106e221 cmp        qword ptr [r14 + 0x10], r12
0106e225 jne        0x14106e248
0106e227 mov        edx, r12d
0106e22a jmp        0x14106e26b
0106e22c test       al, al
0106e22e jne        0x14106de6b
0106e234 cmp        byte ptr [r14 + 0x104], r12b
0106e23b jne        0x14106de6b
0106e241 xor        al, al
0106e243 jmp        0x14106de73
0106e248 mov        rax, qword ptr [r14 + 0x70]
0106e24c test       rax, rax
0106e24f jne        0x14106e256
0106e251 mov        edx, r12d
0106e254 jmp        0x14106e26b
0106e256 mov        edx, dword ptr [rax + 0x10]
0106e259 add        edx, dword ptr [rax + 0xc]
0106e25c mov        ecx, dword ptr [rax + 0x14]
0106e25f test       ecx, ecx
0106e261 je         0x14106e26b
0106e263 add        ecx, dword ptr [rax + 0x18]
0106e266 cmp        edx, ecx
0106e268 cmova      edx, ecx
0106e26b mov        dword ptr [rdi + 0x16c], edx
0106e271 mov        rax, qword ptr [r14 + 0x70]
0106e275 mov        ecx, dword ptr [rax + 0xc]
0106e278 mov        dword ptr [rdi + 0x18c], ecx
0106e27e mov        rax, qword ptr [r14 + 0x70]
0106e282 mov        ecx, dword ptr [rax + 0x10]
0106e285 mov        dword ptr [rdi + 0x190], ecx
0106e28b mov        rax, qword ptr [r14 + 0x70]
0106e28f mov        ecx, dword ptr [rax + 0x14]
0106e292 mov        dword ptr [rdi + 0x184], ecx
0106e298 mov        rax, qword ptr [r14 + 0x70]
0106e29c mov        ecx, dword ptr [rax + 0x18]
0106e29f mov        dword ptr [rdi + 0x188], ecx
0106e2a5 mov        rax, qword ptr [rsi + 0x18]
0106e2a9 movzx      ecx, byte ptr [rax]
0106e2ac shr        cl, 1
0106e2ae and        cl, 1
0106e2b1 mov        byte ptr [r15 + 0xa00299], cl
0106e2b8 mov        rax, qword ptr [rsi + 0x18]
0106e2bc movzx      ecx, byte ptr [rax]
0106e2bf shr        cl, 2
0106e2c2 and        cl, 1
0106e2c5 mov        byte ptr [rdi + 0x172], cl
0106e2cb mov        rax, qword ptr [rsi + 0x18]
0106e2cf movzx      ecx, byte ptr [rax]
0106e2d2 shr        cl, 4
0106e2d5 and        cl, 1
0106e2d8 mov        byte ptr [rdi + 0x12b], cl
0106e2de mov        rax, qword ptr [rsi + 0x18]
0106e2e2 movzx      ecx, word ptr [rax + 2]
0106e2e6 mov        word ptr [rdi + 0x174], cx
0106e2ed mov        rax, qword ptr [rsi + 0x18]
0106e2f1 movzx      ecx, word ptr [rax + 0xc]
0106e2f5 mov        word ptr [rdi + 0x176], cx
0106e2fc mov        rax, qword ptr [rsi + 0x18]
0106e300 mov        ecx, dword ptr [rax + 4]
0106e303 mov        dword ptr [rdi + 0x178], ecx
0106e309 mov        rax, qword ptr [rsi + 0x18]
0106e30d movzx      ecx, word ptr [rax + 0xe]
0106e311 mov        word ptr [rdi + 0x17c], cx
0106e318 mov        rax, qword ptr [rsi + 0x18]
0106e31c movzx      ecx, word ptr [rax + 0x10]
0106e320 mov        word ptr [rdi + 0x17e], cx
0106e327 mov        rax, qword ptr [rsi + 0x18]
0106e32b mov        ecx, dword ptr [rax + 8]
0106e32e mov        dword ptr [rdi + 0x180], ecx
0106e334 mov        eax, dword ptr [rsi + 0x2c]
0106e337 mov        dword ptr [rdi + 0x22c], eax
0106e33d movzx      ecx, word ptr [rsi + 0x50]
0106e341 call       0x14106a560
0106e346 mov        word ptr [rdi + 0x50], ax
0106e34a mov        rax, qword ptr [rsi + 0x20]
0106e34e mov        rcx, qword ptr [rax + 8]
0106e352 mov        qword ptr [rdi + 0x234], rcx
0106e359 mov        rax, qword ptr [rsi + 0x20]
0106e35d mov        rcx, qword ptr [rax + 0x10]
0106e361 mov        qword ptr [rdi + 0x288], rcx
0106e368 mov        rax, qword ptr [rsi + 0x20]
0106e36c mov        rcx, qword ptr [rax + 0x18]
0106e370 mov        qword ptr [rdi + 0x23c], rcx
0106e377 mov        rax, qword ptr [rsi + 0x20]
0106e37b movzx      ecx, byte ptr [rax + 4]
0106e37f mov        byte ptr [rdi + 0x27c], cl
0106e385 movzx      eax, byte ptr [r14 + 0x8a]
0106e38d mov        byte ptr [rdi + 0x25b], al
0106e393 movzx      eax, byte ptr [r14 + 0x88]
0106e39b shr        al, 3
0106e39e and        al, 1
0106e3a0 mov        byte ptr [rdi + 0x258], al
0106e3a6 mov        eax, dword ptr [r14 + 0x8c]
0106e3ad mov        dword ptr [rdi + 0x278], eax
0106e3b3 movzx      eax, byte ptr [r14 + 0x89]
0106e3bb mov        byte ptr [rdi + 0x2e2], al
0106e3c1 cmp        al, 1
0106e3c3 jne        0x14106e3d8
0106e3c5 mov        rcx, r14
0106e3c8 call       0x140f93610
0106e3cd test       al, al
0106e3cf jne        0x14106e3d8
0106e3d1 mov        byte ptr [rdi + 0x2e2], r12b
0106e3d8 mov        rax, qword ptr [rsi + 0x20]
0106e3dc mov        rcx, qword ptr [rax + 8]
0106e3e0 cmp        rcx, -3
0106e3e4 je         0x14106e41e
0106e3e6 ja         0x14106e41e
0106e3e8 test       rcx, rcx
0106e3eb je         0x14106e41e
0106e3ed movzx      eax, byte ptr [r14 + 0x88]
0106e3f5 and        al, 1
0106e3f7 mov        byte ptr [rdi + 0x25c], al
0106e3fd movzx      eax, byte ptr [r14 + 0x88]
0106e405 shr        al, 1
0106e407 and        al, 1
0106e409 mov        byte ptr [rdi + 0x25d], al
0106e40f movzx      eax, byte ptr [r14 + 0x88]
0106e417 shr        al, 2
0106e41a and        al, 1
0106e41c jmp        0x14106e428
0106e41e mov        word ptr [rdi + 0x25c], r12w
0106e426 xor        al, al
0106e428 mov        byte ptr [rdi + 0x25e], al
0106e42e mov        rax, qword ptr [rsi + 0x20]
0106e432 movzx      ecx, byte ptr [rax]
0106e435 shr        cl, 1
0106e437 and        cl, 1
0106e43a mov        byte ptr [rdi + 0x260], cl
0106e440 mov        rax, qword ptr [rsi + 0x20]
0106e444 movzx      ecx, byte ptr [rax]
0106e447 shr        cl, 2
0106e44a and        cl, 1
0106e44d mov        byte ptr [rdi + 0x261], cl
0106e453 mov        rax, qword ptr [rsi + 0x20]
0106e457 movzx      ecx, byte ptr [rax]
0106e45a shr        cl, 3
0106e45d and        cl, 1
0106e460 mov        byte ptr [rdi + 0x262], cl
0106e466 mov        rax, qword ptr [rsi + 0x10]
0106e46a movzx      ecx, byte ptr [rax]
0106e46d shr        cl, 1
0106e46f and        cl, 1
0106e472 mov        byte ptr [r15 + 0xa00381], cl
0106e479 mov        rax, qword ptr [rsi + 0x10]
0106e47d movzx      ecx, byte ptr [rax]
0106e480 shr        cl, 2
0106e483 and        cl, 1
0106e486 mov        byte ptr [rdi + 0x25a], cl
0106e48c mov        rax, qword ptr [rsi + 0x10]
0106e490 movzx      ecx, byte ptr [rax]
0106e493 shr        cl, 5
0106e496 and        cl, 1
0106e499 mov        byte ptr [rdi + 0x26c], cl
0106e49f mov        rax, qword ptr [r14 + 0x150]
0106e4a6 mov        qword ptr [rdi + 0x1e4], rax
0106e4ad mov        eax, dword ptr [r14 + 0x158]
0106e4b4 mov        dword ptr [rdi + 0x1f0], eax
0106e4ba mov        eax, dword ptr [r14 + 0x15c]
0106e4c1 mov        dword ptr [rdi + 0x220], eax
0106e4c7 mov        rax, qword ptr [r14 + 0x138]
0106e4ce mov        qword ptr [rdi + 0x1fc], rax
0106e4d5 mov        rax, qword ptr [rsi + 0x10]
0106e4d9 mov        rcx, qword ptr [rax + 0x28]
0106e4dd mov        qword ptr [rdi + 0x2ac], rcx
0106e4e4 mov        rax, qword ptr [rsi + 0x10]
0106e4e8 mov        rcx, qword ptr [rax + 0x30]
0106e4ec mov        qword ptr [rdi + 0x2b4], rcx
0106e4f3 mov        rax, qword ptr [r14 + 0x68]
0106e4f7 movzx      ecx, word ptr [rax + 0x14]
0106e4fb mov        word ptr [rdi + 0x2d0], cx
0106e502 mov        rax, qword ptr [r14 + 0x68]
0106e506 movzx      ecx, word ptr [rax + 0x16]
0106e50a mov        word ptr [rdi + 0x2d2], cx
0106e511 mov        rax, qword ptr [r14 + 0x68]
0106e515 movzx      ecx, byte ptr [rax]
0106e518 shr        cl, 3
0106e51b and        cl, 1
0106e51e mov        byte ptr [rdi + 0x2d4], cl
0106e524 movzx      eax, byte ptr [rsi + 0x42]
0106e528 shr        al, 6
0106e52b and        al, 1
0106e52d mov        byte ptr [rdi + 0x2bc], al
0106e533 movzx      eax, byte ptr [rsi + 0x42]
0106e537 shr        al, 7
0106e53a mov        byte ptr [rdi + 0x2d5], al
0106e540 movzx      eax, byte ptr [r14 + 0x9f]
0106e548 shr        al, 6
0106e54b and        al, 1
0106e54d mov        byte ptr [rdi + 0x2be], al
0106e553 movzx      eax, byte ptr [r14 + 0xa0]
0106e55b and        al, 1
0106e55d mov        byte ptr [rdi + 0x2cc], al
0106e563 movzx      eax, byte ptr [r14 + 0xa0]
0106e56b shr        al, 1
0106e56d and        al, 1
0106e56f mov        byte ptr [rdi + 0x2cd], al
0106e575 movzx      eax, byte ptr [r14 + 0x107]
0106e57d mov        byte ptr [rdi + 0x2bf], al
0106e583 movzx      eax, byte ptr [r14 + 0xa0]
0106e58b shr        al, 2
0106e58e and        al, 1
0106e590 mov        byte ptr [rdi + 0x2ce], al
0106e596 mov        rax, qword ptr [rsi + 0x20]
0106e59a mov        rcx, qword ptr [rax + 0x20]
0106e59e mov        qword ptr [rdi + 0x2c4], rcx
0106e5a5 mov        rax, qword ptr [rsi + 0x20]
0106e5a9 movzx      ecx, byte ptr [rax]
0106e5ac shr        cl, 4
0106e5af and        cl, 1
0106e5b2 mov        byte ptr [rdi + 0x2bd], cl
0106e5b8 mov        rax, qword ptr [rsi + 0x20]
0106e5bc movzx      ecx, byte ptr [rax + 0x28]
0106e5c0 mov        byte ptr [r15 + 0xa003e8], cl
0106e5c7 mov        rax, qword ptr [rsi + 0x20]
0106e5cb movzx      ecx, byte ptr [rax + 0x29]
0106e5cf mov        byte ptr [rdi + 0x2c1], cl
0106e5d5 mov        rax, qword ptr [rsi + 0x20]
0106e5d9 movzx      ecx, byte ptr [rax + 0x2a]
0106e5dd mov        byte ptr [rdi + 0x2c2], cl
0106e5e3 mov        rax, qword ptr [rsi + 0x20]
0106e5e7 movzx      ecx, byte ptr [rax + 0x2b]
0106e5eb mov        byte ptr [rdi + 0x2c3], cl
0106e5f1 test       byte ptr [r14 + 0x9b], 8
0106e5f9 je         0x14106e5ff
0106e5fb mov        al, 1
0106e5fd jmp        0x14106e62f
0106e5ff xor        edx, edx
0106e601 mov        rcx, r14
0106e604 call       0x140fa0b70
0106e609 test       eax, 0x10090
0106e60e je         0x14106e614
0106e610 mov        al, 1
0106e612 jmp        0x14106e62f
0106e614 test       byte ptr [r14 + 0x9d], 8
0106e61c je         0x14106e622
0106e61e mov        al, 1
0106e620 jmp        0x14106e62f
0106e622 mov        rcx, r14
0106e625 call       0x140f938a0
0106e62a test       al, al
0106e62c setne      al
0106e62f mov        byte ptr [rdi + 0x2cf], al
0106e635 mov        rax, qword ptr [r14 + 0x70]
0106e639 movzx      ecx, byte ptr [rax + 0x20]
0106e63d mov        byte ptr [rdi + 0x2d6], cl
0106e643 mov        rax, qword ptr [r14 + 0x70]
0106e647 movzx      ecx, byte ptr [rax + 0x21]
0106e64b mov        byte ptr [rdi + 0x2d7], cl
0106e651 mov        rax, qword ptr [r14 + 0x70]
0106e655 movzx      ecx, byte ptr [rax + 0x22]
0106e659 mov        byte ptr [rdi + 0x2d8], cl
0106e65f movzx      eax, byte ptr [r14 + 0xa0]
0106e667 shr        al, 3
0106e66a and        al, 1
0106e66c mov        byte ptr [rdi + 0x2d9], al
0106e672 movzx      eax, byte ptr [rsi + 0x40]
0106e676 shr        al, 1
0106e678 and        al, 1
0106e67a mov        byte ptr [rdi + 0x2da], al
0106e680 mov        rax, qword ptr [rsi + 0x10]
0106e684 movzx      ecx, byte ptr [rax]
0106e687 shr        cl, 7
0106e68a mov        byte ptr [rdi + 0x2db], cl
0106e690 mov        rax, qword ptr [rsi + 0x10]
0106e694 mov        ecx, dword ptr [rax + 0x90]
0106e69a mov        dword ptr [rdi + 0x2dc], ecx
0106e6a0 movzx      eax, byte ptr [rsi + 0x45]
0106e6a4 mov        byte ptr [rdi + 0x2e1], al
0106e6aa movzx      eax, byte ptr [rsi + 0x43]
0106e6ae and        al, 1
0106e6b0 mov        byte ptr [rdi + 0x2e3], al
0106e6b6 test       byte ptr [r14 + 0x9c], 4
0106e6be je         0x14106e6df
0106e6c0 and        dword ptr [rdi + 0x274], 0xffff7fff
0106e6ca mov        dword ptr [rdi + 0x16c], r12d
0106e6d1 mov        qword ptr [rdi + 0x18c], r12
0106e6d8 mov        qword ptr [rdi + 0x184], r12
0106e6df mov        rax, qword ptr [rsi + 0x60]
0106e6e3 mov        ecx, 0xffffffff
0106e6e8 cmp        rax, rcx
0106e6eb cmovbe     ecx, eax
0106e6ee mov        dword ptr [rdi + 0x24], ecx
0106e6f1 mov        rax, qword ptr [r14 + 0x28]
0106e6f5 test       rax, rax
0106e6f8 je         0x14106e703
0106e6fa mov        eax, dword ptr [rax + 0x18]
0106e6fd mov        dword ptr [rdi + 0xdc], eax
0106e703 mov        rax, qword ptr [r14 + 0x40]
0106e707 test       rax, rax
0106e70a je         0x14106e715
0106e70c mov        eax, dword ptr [rax + 0x3c]
0106e70f mov        dword ptr [rdi + 0x1e0], eax
0106e715 mov        eax, dword ptr [rsi + 0x34]
0106e718 cmp        eax, 0x46494c45
0106e71d je         0x14106e7ad
0106e723 cmp        eax, 0x48545450
0106e728 je         0x14106e7a4
0106e72a cmp        eax, 0x53485244
0106e72f jne        0x14106e7d3
0106e735 mov        dword ptr [rdi + 0x14], 3
0106e73c mov        rcx, rsi
0106e73f mov        rax, qword ptr [rsi + 0x80]
0106e746 mov        qword ptr [rdi + 0x280], rax
0106e74d movzx      eax, byte ptr [rsi + 0x90]
0106e754 mov        byte ptr [rdi + 0x26d], al
0106e75a mov        eax, dword ptr [rsi + 0x98]
0106e760 mov        dword ptr [rdi + 0x250], eax
0106e766 mov        eax, dword ptr [rsi + 0x9c]
0106e76c mov        dword ptr [rdi + 0x254], eax
0106e772 movzx      eax, byte ptr [rsi + 0x94]
0106e779 mov        byte ptr [rdi + 0x232], al
0106e77f movzx      eax, byte ptr [rsi + 0x95]
0106e786 mov        byte ptr [rdi + 0x233], al
0106e78c call       0x140fa9b00
0106e791 test       al, al
0106e793 je         0x14106e7d3
0106e795 cmp        byte ptr [rsi + 0x3d], 1
0106e799 jne        0x14106e7d3
0106e79b mov        byte ptr [rdi + 0x25f], 1
0106e7a2 jmp        0x14106e7d3
0106e7a4 mov        dword ptr [rdi + 0x14], 2
0106e7ab jmp        0x14106e7d3
0106e7ad mov        dword ptr [rdi + 0x14], 1
0106e7b4 mov        eax, dword ptr [rsi + 0x2bc]
0106e7ba mov        dword ptr [rdi + 0x1c], eax
0106e7bd movzx      eax, word ptr [rsi + 0x2c4]
0106e7c4 mov        word ptr [rdi + 0x5c], ax
0106e7c8 movzx      eax, word ptr [rsi + 0x2c6]
0106e7cf mov        word ptr [rdi + 0x5e], ax
0106e7d3 movsxd     r9, dword ptr [r14 + 0xb0]
0106e7da lea        rdx, [r13 + 0x178]
0106e7e1 mov        ebx, r12d
0106e7e4 test       r9d, r9d
0106e7e7 je         0x14106e89c
0106e7ed mov        r11d, r12d
0106e7f0 mov        r10, r12
0106e7f3 test       rdx, rdx
0106e7f6 je         0x14106f4d8
0106e7fc cmp        dword ptr [rdx], 0x73747263
0106e802 jne        0x14106f4d8
0106e808 cmp        dword ptr [rdx + 0x3c], ebx
0106e80b je         0x14106f4d8
0106e811 test       r9d, r9d
0106e814 jle        0x14106f4d8
0106e81a cmp        r9d, dword ptr [rdx + 0x2c]
0106e81e jg         0x14106f4d8
0106e824 mov        rax, qword ptr [rdx + 0x10]
0106e828 lea        r8, [r9 - 1]
0106e82c mov        rax, qword ptr [rax]
0106e82f lea        r8, [rax + r8*8]
0106e833 test       r8, r8
0106e836 je         0x14106e857
0106e838 movsxd     r12, dword ptr [r8]
0106e83b test       r12d, r12d
0106e83e js         0x14106e857
0106e840 mov        ecx, dword ptr [r8 + 4]
0106e844 test       ecx, ecx
0106e846 jle        0x14106e857
0106e848 mov        rax, qword ptr [rdx + 0x20]
0106e84c mov        r10, r12
0106e84f mov        r11d, ecx
0106e852 add        r10, qword ptr [rax]
0106e855 jmp        0x14106e85c
0106e857 mov        ebx, 0xffffffce
0106e85c test       ebx, ebx
0106e85e jne        0x141070258
0106e864 test       r11d, r11d
0106e867 je         0x14106e89c
0106e869 lea        rax, [rsp + 0x48]
0106e86e mov        r8d, r11d
0106e871 mov        qword ptr [rsp + 0x30], rax
0106e876 mov        rdx, r10
0106e879 mov        dword ptr [rsp + 0x28], 1
0106e881 mov        rcx, r15
0106e884 mov        dword ptr [rsp + 0x20], 2
0106e88c call       0x14106ac80
0106e891 mov        ebx, eax
0106e893 test       eax, eax
0106e895 jne        0x14106e89c
0106e897 inc        dword ptr [rdi + 0xc]
0106e89a jmp        0x14106e8a4
0106e89c test       ebx, ebx
0106e89e jne        0x141070258
0106e8a4 movsxd     r9, dword ptr [r14 + 0xb4]
0106e8ab lea        r12, [r13 + 0x208]
0106e8b2 xor        ebx, ebx
0106e8b4 test       r9d, r9d
0106e8b7 je         0x14106e96f
0106e8bd xor        r10d, r10d
0106e8c0 xor        edx, edx
0106e8c2 test       r12, r12
0106e8c5 je         0x14106f4d8
0106e8cb cmp        dword ptr [r12], 0x73747263
0106e8d3 jne        0x14106f4d8
0106e8d9 cmp        dword ptr [r12 + 0x3c], edx
0106e8de je         0x14106f4d8
0106e8e4 test       r9d, r9d
0106e8e7 jle        0x14106f4d8
0106e8ed cmp        r9d, dword ptr [r12 + 0x2c]
0106e8f2 jg         0x14106f4d8
0106e8f8 mov        rax, qword ptr [r12 + 0x10]
0106e8fd lea        r8, [r9 - 1]
0106e901 mov        rax, qword ptr [rax]
0106e904 lea        r8, [rax + r8*8]
0106e908 test       r8, r8
0106e90b je         0x14106e92d
0106e90d movsxd     r11, dword ptr [r8]
0106e910 test       r11d, r11d
0106e913 js         0x14106e92d
0106e915 mov        ecx, dword ptr [r8 + 4]
0106e919 test       ecx, ecx
0106e91b jle        0x14106e92d
0106e91d mov        rax, qword ptr [r12 + 0x20]
0106e922 mov        rdx, r11
0106e925 mov        r10d, ecx
0106e928 add        rdx, qword ptr [rax]
0106e92b jmp        0x14106e932
0106e92d mov        ebx, 0xffffffce
0106e932 test       ebx, ebx
0106e934 jne        0x141070258
0106e93a test       r10d, r10d
0106e93d je         0x14106e96f
0106e93f lea        rax, [rsp + 0x48]
0106e944 mov        r8d, r10d
0106e947 mov        qword ptr [rsp + 0x30], rax
0106e94c mov        rcx, r15
0106e94f mov        dword ptr [rsp + 0x28], 1
0106e957 mov        dword ptr [rsp + 0x20], 4
0106e95f call       0x14106ac80
0106e964 mov        ebx, eax
0106e966 test       eax, eax
0106e968 jne        0x14106e96f
0106e96a inc        dword ptr [rdi + 0xc]
0106e96d jmp        0x14106e977
0106e96f test       ebx, ebx
0106e971 jne        0x141070258
0106e977 movsxd     r9, dword ptr [r14 + 0xb8]
0106e97e xor        ebx, ebx
0106e980 test       r9d, r9d
0106e983 je         0x14106ea3b
0106e989 xor        r10d, r10d
0106e98c xor        edx, edx
0106e98e test       r12, r12
0106e991 je         0x14106f4d8
0106e997 cmp        dword ptr [r12], 0x73747263
0106e99f jne        0x14106f4d8
0106e9a5 cmp        dword ptr [r12 + 0x3c], edx
0106e9aa je         0x14106f4d8
0106e9b0 test       r9d, r9d
0106e9b3 jle        0x14106f4d8
0106e9b9 cmp        r9d, dword ptr [r12 + 0x2c]
0106e9be jg         0x14106f4d8
0106e9c4 mov        rax, qword ptr [r12 + 0x10]
0106e9c9 lea        r8, [r9 - 1]
0106e9cd mov        rax, qword ptr [rax]
0106e9d0 lea        r8, [rax + r8*8]
0106e9d4 test       r8, r8
0106e9d7 je         0x14106e9f9
0106e9d9 movsxd     r11, dword ptr [r8]
0106e9dc test       r11d, r11d
0106e9df js         0x14106e9f9
0106e9e1 mov        ecx, dword ptr [r8 + 4]
0106e9e5 test       ecx, ecx
0106e9e7 jle        0x14106e9f9
0106e9e9 mov        rax, qword ptr [r12 + 0x20]
0106e9ee mov        rdx, r11
0106e9f1 mov        r10d, ecx
0106e9f4 add        rdx, qword ptr [rax]
0106e9f7 jmp        0x14106e9fe
0106e9f9 mov        ebx, 0xffffffce
0106e9fe test       ebx, ebx
0106ea00 jne        0x141070258
0106ea06 test       r10d, r10d
0106ea09 je         0x14106ea3b
0106ea0b lea        rax, [rsp + 0x48]
0106ea10 mov        r8d, r10d
0106ea13 mov        qword ptr [rsp + 0x30], rax
0106ea18 mov        rcx, r15
0106ea1b mov        dword ptr [rsp + 0x28], 1
0106ea23 mov        dword ptr [rsp + 0x20], 0x1b
0106ea2b call       0x14106ac80
0106ea30 mov        ebx, eax
0106ea32 test       eax, eax
0106ea34 jne        0x14106ea3b
0106ea36 inc        dword ptr [rdi + 0xc]
0106ea39 jmp        0x14106ea43
0106ea3b test       ebx, ebx
0106ea3d jne        0x141070258
0106ea43 movsxd     r9, dword ptr [r14 + 0xc4]
0106ea4a lea        r8, [r13 + 0x208]
0106ea51 xor        ebx, ebx
0106ea53 test       r9d, r9d
0106ea56 je         0x14106eb0b
0106ea5c xor        r11d, r11d
0106ea5f xor        r10d, r10d
0106ea62 test       r8, r8
0106ea65 je         0x14106f4d8
0106ea6b cmp        dword ptr [r8], 0x73747263
0106ea72 jne        0x14106f4d8
0106ea78 cmp        dword ptr [r8 + 0x3c], ebx
0106ea7c je         0x14106f4d8
0106ea82 test       r9d, r9d
0106ea85 jle        0x14106f4d8
0106ea8b cmp        r9d, dword ptr [r8 + 0x2c]
0106ea8f jg         0x14106f4d8
0106ea95 mov        rax, qword ptr [r8 + 0x10]
0106ea99 mov        rcx, qword ptr [rax]
0106ea9c lea        rax, [r9 - 1]
0106eaa0 lea        rax, [rcx + rax*8]
0106eaa4 test       rax, rax
0106eaa7 je         0x14106eac6
0106eaa9 movsxd     rdx, dword ptr [rax]
0106eaac test       edx, edx
0106eaae js         0x14106eac6
0106eab0 mov        ecx, dword ptr [rax + 4]
0106eab3 test       ecx, ecx
0106eab5 jle        0x14106eac6
0106eab7 mov        rax, qword ptr [r8 + 0x20]
0106eabb mov        r10, rdx
0106eabe mov        r11d, ecx
0106eac1 add        r10, qword ptr [rax]
0106eac4 jmp        0x14106eacb
0106eac6 mov        ebx, 0xffffffce
0106eacb test       ebx, ebx
0106eacd jne        0x141070258
0106ead3 test       r11d, r11d
0106ead6 je         0x14106eb0b
0106ead8 lea        rax, [rsp + 0x48]
0106eadd mov        r8d, r11d
0106eae0 mov        qword ptr [rsp + 0x30], rax
0106eae5 mov        rdx, r10
0106eae8 mov        dword ptr [rsp + 0x28], 1
0106eaf0 mov        rcx, r15
0106eaf3 mov        dword ptr [rsp + 0x20], 0xc
0106eafb call       0x14106ac80
0106eb00 mov        ebx, eax
0106eb02 test       eax, eax
0106eb04 jne        0x14106eb0b
0106eb06 inc        dword ptr [rdi + 0xc]
0106eb09 jmp        0x14106eb13
0106eb0b test       ebx, ebx
0106eb0d jne        0x141070258
0106eb13 movsxd     r9, dword ptr [r14 + 0xbc]
0106eb1a lea        r8, [r13 + 0x1c0]
0106eb21 xor        ebx, ebx
0106eb23 test       r9d, r9d
0106eb26 je         0x14106ebdb
0106eb2c xor        r11d, r11d
0106eb2f xor        r10d, r10d
0106eb32 test       r8, r8
0106eb35 je         0x14106f4d8
0106eb3b cmp        dword ptr [r8], 0x73747263
0106eb42 jne        0x14106f4d8
0106eb48 cmp        dword ptr [r8 + 0x3c], ebx
0106eb4c je         0x14106f4d8
0106eb52 test       r9d, r9d
0106eb55 jle        0x14106f4d8
0106eb5b cmp        r9d, dword ptr [r8 + 0x2c]
0106eb5f jg         0x14106f4d8
0106eb65 mov        rax, qword ptr [r8 + 0x10]
0106eb69 mov        rcx, qword ptr [rax]
0106eb6c lea        rax, [r9 - 1]
0106eb70 lea        rax, [rcx + rax*8]
0106eb74 test       rax, rax
0106eb77 je         0x14106eb96
0106eb79 movsxd     rdx, dword ptr [rax]
0106eb7c test       edx, edx
0106eb7e js         0x14106eb96
0106eb80 mov        ecx, dword ptr [rax + 4]
0106eb83 test       ecx, ecx
0106eb85 jle        0x14106eb96
0106eb87 mov        rax, qword ptr [r8 + 0x20]
0106eb8b mov        r10, rdx
0106eb8e mov        r11d, ecx
0106eb91 add        r10, qword ptr [rax]
0106eb94 jmp        0x14106eb9b
0106eb96 mov        ebx, 0xffffffce
0106eb9b test       ebx, ebx
0106eb9d jne        0x141070258
0106eba3 test       r11d, r11d
0106eba6 je         0x14106ebdb
0106eba8 lea        rax, [rsp + 0x48]
0106ebad mov        r8d, r11d
0106ebb0 mov        qword ptr [rsp + 0x30], rax
0106ebb5 mov        rdx, r10
0106ebb8 mov        dword ptr [rsp + 0x28], 1
0106ebc0 mov        rcx, r15
0106ebc3 mov        dword ptr [rsp + 0x20], 3
0106ebcb call       0x14106ac80
0106ebd0 mov        ebx, eax
0106ebd2 test       eax, eax
0106ebd4 jne        0x14106ebdb
0106ebd6 inc        dword ptr [rdi + 0xc]
0106ebd9 jmp        0x14106ebe3
0106ebdb test       ebx, ebx
0106ebdd jne        0x141070258
0106ebe3 movsxd     r9, dword ptr [r14 + 0xc0]
0106ebea lea        r8, [r13 + 0x250]
0106ebf1 xor        ebx, ebx
0106ebf3 test       r9d, r9d
0106ebf6 je         0x14106ecab
0106ebfc xor        r11d, r11d
0106ebff xor        r10d, r10d
0106ec02 test       r8, r8
0106ec05 je         0x14106f4d8
0106ec0b cmp        dword ptr [r8], 0x73747263
0106ec12 jne        0x14106f4d8
0106ec18 cmp        dword ptr [r8 + 0x3c], ebx
0106ec1c je         0x14106f4d8
0106ec22 test       r9d, r9d
0106ec25 jle        0x14106f4d8
0106ec2b cmp        r9d, dword ptr [r8 + 0x2c]
0106ec2f jg         0x14106f4d8
0106ec35 mov        rax, qword ptr [r8 + 0x10]
0106ec39 mov        rcx, qword ptr [rax]
0106ec3c lea        rax, [r9 - 1]
0106ec40 lea        rax, [rcx + rax*8]
0106ec44 test       rax, rax
0106ec47 je         0x14106ec66
0106ec49 movsxd     rdx, dword ptr [rax]
0106ec4c test       edx, edx
0106ec4e js         0x14106ec66
0106ec50 mov        ecx, dword ptr [rax + 4]
0106ec53 test       ecx, ecx
0106ec55 jle        0x14106ec66
0106ec57 mov        rax, qword ptr [r8 + 0x20]
0106ec5b mov        r10, rdx
0106ec5e mov        r11d, ecx
0106ec61 add        r10, qword ptr [rax]
0106ec64 jmp        0x14106ec6b
0106ec66 mov        ebx, 0xffffffce
0106ec6b test       ebx, ebx
0106ec6d jne        0x141070258
0106ec73 test       r11d, r11d
0106ec76 je         0x14106ecab
0106ec78 lea        rax, [rsp + 0x48]
0106ec7d mov        r8d, r11d
0106ec80 mov        qword ptr [rsp + 0x30], rax
0106ec85 mov        rdx, r10
0106ec88 mov        dword ptr [rsp + 0x28], 1
0106ec90 mov        rcx, r15
0106ec93 mov        dword ptr [rsp + 0x20], 0xe
0106ec9b call       0x14106ac80
0106eca0 mov        ebx, eax
0106eca2 test       eax, eax
0106eca4 jne        0x14106ecab
0106eca6 inc        dword ptr [rdi + 0xc]
0106eca9 jmp        0x14106ecb3
0106ecab test       ebx, ebx
0106ecad jne        0x141070258
0106ecb3 movsxd     r9, dword ptr [r14 + 0xc8]
0106ecba lea        r8, [r13 + 0x328]
0106ecc1 xor        ebx, ebx
0106ecc3 test       r9d, r9d
0106ecc6 je         0x14106ed7b
0106eccc xor        r11d, r11d
0106eccf xor        r10d, r10d
0106ecd2 test       r8, r8
0106ecd5 je         0x14106f4d8
0106ecdb cmp        dword ptr [r8], 0x73747263
0106ece2 jne        0x14106f4d8
0106ece8 cmp        dword ptr [r8 + 0x3c], ebx
0106ecec je         0x14106f4d8
0106ecf2 test       r9d, r9d
0106ecf5 jle        0x14106f4d8
0106ecfb cmp        r9d, dword ptr [r8 + 0x2c]
0106ecff jg         0x14106f4d8
0106ed05 mov        rax, qword ptr [r8 + 0x10]
0106ed09 mov        rcx, qword ptr [rax]
0106ed0c lea        rax, [r9 - 1]
0106ed10 lea        rax, [rcx + rax*8]
0106ed14 test       rax, rax
0106ed17 je         0x14106ed36
0106ed19 movsxd     rdx, dword ptr [rax]
0106ed1c test       edx, edx
0106ed1e js         0x14106ed36
0106ed20 mov        ecx, dword ptr [rax + 4]
0106ed23 test       ecx, ecx
0106ed25 jle        0x14106ed36
0106ed27 mov        rax, qword ptr [r8 + 0x20]
0106ed2b mov        r10, rdx
0106ed2e mov        r11d, ecx
0106ed31 add        r10, qword ptr [rax]
0106ed34 jmp        0x14106ed3b
0106ed36 mov        ebx, 0xffffffce
0106ed3b test       ebx, ebx
0106ed3d jne        0x141070258
0106ed43 test       r11d, r11d
0106ed46 je         0x14106ed7b
0106ed48 lea        rax, [rsp + 0x48]
0106ed4d mov        r8d, r11d
0106ed50 mov        qword ptr [rsp + 0x30], rax
0106ed55 mov        rdx, r10
0106ed58 mov        dword ptr [rsp + 0x28], 1
0106ed60 mov        rcx, r15
0106ed63 mov        dword ptr [rsp + 0x20], 5
0106ed6b call       0x14106ac80
0106ed70 mov        ebx, eax
0106ed72 test       eax, eax
0106ed74 jne        0x14106ed7b
0106ed76 inc        dword ptr [rdi + 0xc]
0106ed79 jmp        0x14106ed83
0106ed7b test       ebx, ebx
0106ed7d jne        0x141070258
0106ed83 movsxd     r9, dword ptr [r14 + 0xcc]
0106ed8a lea        r8, [r13 + 0x370]
0106ed91 xor        ebx, ebx
0106ed93 test       r9d, r9d
0106ed96 je         0x14106ee4b
0106ed9c xor        r11d, r11d
0106ed9f xor        r10d, r10d
0106eda2 test       r8, r8
0106eda5 je         0x14106f4d8
0106edab cmp        dword ptr [r8], 0x73747263
0106edb2 jne        0x14106f4d8
0106edb8 cmp        dword ptr [r8 + 0x3c], ebx
0106edbc je         0x14106f4d8
0106edc2 test       r9d, r9d
0106edc5 jle        0x14106f4d8
0106edcb cmp        r9d, dword ptr [r8 + 0x2c]
0106edcf jg         0x14106f4d8
0106edd5 mov        rax, qword ptr [r8 + 0x10]
0106edd9 mov        rcx, qword ptr [rax]
0106eddc lea        rax, [r9 - 1]
0106ede0 lea        rax, [rcx + rax*8]
0106ede4 test       rax, rax
0106ede7 je         0x14106ee06
0106ede9 movsxd     rdx, dword ptr [rax]
0106edec test       edx, edx
0106edee js         0x14106ee06
0106edf0 mov        ecx, dword ptr [rax + 4]
0106edf3 test       ecx, ecx
0106edf5 jle        0x14106ee06
0106edf7 mov        rax, qword ptr [r8 + 0x20]
0106edfb mov        r10, rdx
0106edfe mov        r11d, ecx
0106ee01 add        r10, qword ptr [rax]
0106ee04 jmp        0x14106ee0b
0106ee06 mov        ebx, 0xffffffce
0106ee0b test       ebx, ebx
0106ee0d jne        0x141070258
0106ee13 test       r11d, r11d
0106ee16 je         0x14106ee4b
0106ee18 lea        rax, [rsp + 0x48]
0106ee1d mov        r8d, r11d
0106ee20 mov        qword ptr [rsp + 0x30], rax
0106ee25 mov        rdx, r10
0106ee28 mov        dword ptr [rsp + 0x28], 1
0106ee30 mov        rcx, r15
0106ee33 mov        dword ptr [rsp + 0x20], 6
0106ee3b call       0x14106ac80
0106ee40 mov        ebx, eax
0106ee42 test       eax, eax
0106ee44 jne        0x14106ee4b
0106ee46 inc        dword ptr [rdi + 0xc]
0106ee49 jmp        0x14106ee53
0106ee4b test       ebx, ebx
0106ee4d jne        0x141070258
0106ee53 mov        edx, dword ptr [r14 + 0xd0]
0106ee5a xor        ebx, ebx
0106ee5c test       edx, edx
0106ee5e je         0x14106eed0
0106ee60 mov        rcx, qword ptr [r15 + 0x1e00270]
0106ee67 lea        r8, [rbp - 0x10]
0106ee6b add        rcx, 0x3b8
0106ee72 call       0x140bff470
0106ee77 mov        ebx, eax
0106ee79 test       eax, eax
0106ee7b jne        0x14106eed0
0106ee7d cmp        word ptr [rbp - 0x10], ax
0106ee81 je         0x14106eed0
0106ee83 lea        rdx, [rbp - 0x10]
0106ee87 lea        rcx, [rbp - 0x10]
0106ee8b call       0x140ea9f50
0106ee90 movzx      r8d, word ptr [rbp - 0x10]
0106ee95 lea        rax, [rsp + 0x48]
0106ee9a mov        r9d, dword ptr [r14 + 0xd0]
0106eea1 lea        rdx, [rbp - 0xe]
0106eea5 mov        qword ptr [rsp + 0x30], rax
0106eeaa add        r8d, r8d
0106eead mov        dword ptr [rsp + 0x28], 1
0106eeb5 mov        rcx, r15
0106eeb8 mov        dword ptr [rsp + 0x20], 7
0106eec0 call       0x14106ac80
0106eec5 mov        ebx, eax
0106eec7 test       eax, eax
0106eec9 jne        0x14106eed0
0106eecb inc        dword ptr [rdi + 0xc]
0106eece jmp        0x14106eed8
0106eed0 test       ebx, ebx
0106eed2 jne        0x141070258
0106eed8 movsxd     r9, dword ptr [r14 + 0xd0]
0106eedf lea        rdx, [r13 + 0x3b8]
0106eee6 xor        ebx, ebx
0106eee8 test       r9d, r9d
0106eeeb je         0x14106efa0
0106eef1 xor        r11d, r11d
0106eef4 xor        r10d, r10d
0106eef7 test       rdx, rdx
0106eefa je         0x14106f4d8
0106ef00 cmp        dword ptr [rdx], 0x73747263
0106ef06 jne        0x14106f4d8
0106ef0c cmp        dword ptr [rdx + 0x3c], ebx
0106ef0f je         0x14106f4d8
0106ef15 test       r9d, r9d
0106ef18 jle        0x14106f4d8
0106ef1e cmp        r9d, dword ptr [rdx + 0x2c]
0106ef22 jg         0x14106f4d8
0106ef28 mov        rax, qword ptr [rdx + 0x10]
0106ef2c lea        r8, [r9 - 1]
0106ef30 mov        rax, qword ptr [rax]
0106ef33 lea        r8, [rax + r8*8]
0106ef37 test       r8, r8
0106ef3a je         0x14106ef5b
0106ef3c movsxd     r12, dword ptr [r8]
0106ef3f test       r12d, r12d
0106ef42 js         0x14106ef5b
0106ef44 mov        ecx, dword ptr [r8 + 4]
0106ef48 test       ecx, ecx
0106ef4a jle        0x14106ef5b
0106ef4c mov        rax, qword ptr [rdx + 0x20]
0106ef50 mov        r10, r12
0106ef53 mov        r11d, ecx
0106ef56 add        r10, qword ptr [rax]
0106ef59 jmp        0x14106ef60
0106ef5b mov        ebx, 0xffffffce
0106ef60 test       ebx, ebx
0106ef62 jne        0x141070258
0106ef68 test       r11d, r11d
0106ef6b je         0x14106efa0
0106ef6d lea        rax, [rsp + 0x48]
0106ef72 mov        r8d, r11d
0106ef75 mov        qword ptr [rsp + 0x30], rax
0106ef7a mov        rdx, r10
0106ef7d mov        dword ptr [rsp + 0x28], 1
0106ef85 mov        rcx, r15
0106ef88 mov        dword ptr [rsp + 0x20], 7
0106ef90 call       0x14106ac80
0106ef95 mov        ebx, eax
0106ef97 test       eax, eax
0106ef99 jne        0x14106efa0
0106ef9b inc        dword ptr [rdi + 0xc]
0106ef9e jmp        0x14106efa8
0106efa0 test       ebx, ebx
0106efa2 jne        0x141070258
0106efa8 movsxd     r9, dword ptr [r14 + 0xd4]
0106efaf lea        rdx, [r13 + 0x400]
0106efb6 xor        ebx, ebx
0106efb8 test       r9d, r9d
0106efbb je         0x14106f070
0106efc1 xor        r11d, r11d
0106efc4 xor        r10d, r10d
0106efc7 test       rdx, rdx
0106efca je         0x14106f4d8
0106efd0 cmp        dword ptr [rdx], 0x73747263
0106efd6 jne        0x14106f4d8
0106efdc cmp        dword ptr [rdx + 0x3c], ebx
0106efdf je         0x14106f4d8
0106efe5 test       r9d, r9d
0106efe8 jle        0x14106f4d8
0106efee cmp        r9d, dword ptr [rdx + 0x2c]
0106eff2 jg         0x14106f4d8
0106eff8 mov        rax, qword ptr [rdx + 0x10]
0106effc lea        r8, [r9 - 1]
0106f000 mov        rax, qword ptr [rax]
0106f003 lea        r8, [rax + r8*8]
0106f007 test       r8, r8
0106f00a je         0x14106f02b
0106f00c movsxd     r12, dword ptr [r8]
0106f00f test       r12d, r12d
0106f012 js         0x14106f02b
0106f014 mov        ecx, dword ptr [r8 + 4]
0106f018 test       ecx, ecx
0106f01a jle        0x14106f02b
0106f01c mov        rax, qword ptr [rdx + 0x20]
0106f020 mov        r10, r12
0106f023 mov        r11d, ecx
0106f026 add        r10, qword ptr [rax]
0106f029 jmp        0x14106f030
0106f02b mov        ebx, 0xffffffce
0106f030 test       ebx, ebx
0106f032 jne        0x141070258
0106f038 test       r11d, r11d
0106f03b je         0x14106f070
0106f03d lea        rax, [rsp + 0x48]
0106f042 mov        r8d, r11d
0106f045 mov        qword ptr [rsp + 0x30], rax
0106f04a mov        rdx, r10
0106f04d mov        dword ptr [rsp + 0x28], 1
0106f055 mov        rcx, r15
0106f058 mov        dword ptr [rsp + 0x20], 8
0106f060 call       0x14106ac80
0106f065 mov        ebx, eax
0106f067 test       eax, eax
0106f069 jne        0x14106f070
0106f06b inc        dword ptr [rdi + 0xc]
0106f06e jmp        0x14106f078
0106f070 test       ebx, ebx
0106f072 jne        0x141070258
0106f078 movsxd     r9, dword ptr [r14 + 0xd8]
0106f07f lea        rdx, [r13 + 0x448]
0106f086 xor        ebx, ebx
0106f088 test       r9d, r9d
0106f08b je         0x14106f140
0106f091 xor        r11d, r11d
0106f094 xor        r10d, r10d
0106f097 test       rdx, rdx
0106f09a je         0x14106f4d8
0106f0a0 cmp        dword ptr [rdx], 0x73747263
0106f0a6 jne        0x14106f4d8
0106f0ac cmp        dword ptr [rdx + 0x3c], ebx
0106f0af je         0x14106f4d8
0106f0b5 test       r9d, r9d
0106f0b8 jle        0x14106f4d8
0106f0be cmp        r9d, dword ptr [rdx + 0x2c]
0106f0c2 jg         0x14106f4d8
0106f0c8 mov        rax, qword ptr [rdx + 0x10]
0106f0cc lea        r8, [r9 - 1]
0106f0d0 mov        rax, qword ptr [rax]
0106f0d3 lea        r8, [rax + r8*8]
0106f0d7 test       r8, r8
0106f0da je         0x14106f0fb
0106f0dc movsxd     r12, dword ptr [r8]
0106f0df test       r12d, r12d
0106f0e2 js         0x14106f0fb
0106f0e4 mov        ecx, dword ptr [r8 + 4]
0106f0e8 test       ecx, ecx
0106f0ea jle        0x14106f0fb
0106f0ec mov        rax, qword ptr [rdx + 0x20]
0106f0f0 mov        r10, r12
0106f0f3 mov        r11d, ecx
0106f0f6 add        r10, qword ptr [rax]
0106f0f9 jmp        0x14106f100
0106f0fb mov        ebx, 0xffffffce
0106f100 test       ebx, ebx
0106f102 jne        0x141070258
0106f108 test       r11d, r11d
0106f10b je         0x14106f140
0106f10d lea        rax, [rsp + 0x48]
0106f112 mov        r8d, r11d
0106f115 mov        qword ptr [rsp + 0x30], rax
0106f11a mov        rdx, r10
0106f11d mov        dword ptr [rsp + 0x28], 1
0106f125 mov        rcx, r15
0106f128 mov        dword ptr [rsp + 0x20], 9
0106f130 call       0x14106ac80
0106f135 mov        ebx, eax
0106f137 test       eax, eax
0106f139 jne        0x14106f140
0106f13b inc        dword ptr [rdi + 0xc]
0106f13e jmp        0x14106f148
0106f140 test       ebx, ebx
0106f142 jne        0x141070258
0106f148 movsxd     r9, dword ptr [r14 + 0xdc]
0106f14f lea        rdx, [r13 + 0x490]
0106f156 xor        ebx, ebx
0106f158 test       r9d, r9d
0106f15b je         0x14106f210
0106f161 xor        r11d, r11d
0106f164 xor        r10d, r10d
0106f167 test       rdx, rdx
0106f16a je         0x14106f4d8
0106f170 cmp        dword ptr [rdx], 0x73747263
0106f176 jne        0x14106f4d8
0106f17c cmp        dword ptr [rdx + 0x3c], ebx
0106f17f je         0x14106f4d8
0106f185 test       r9d, r9d
0106f188 jle        0x14106f4d8
0106f18e cmp        r9d, dword ptr [rdx + 0x2c]
0106f192 jg         0x14106f4d8
0106f198 mov        rax, qword ptr [rdx + 0x10]
0106f19c lea        r8, [r9 - 1]
0106f1a0 mov        rax, qword ptr [rax]
0106f1a3 lea        r8, [rax + r8*8]
0106f1a7 test       r8, r8
0106f1aa je         0x14106f1cb
0106f1ac movsxd     r12, dword ptr [r8]
0106f1af test       r12d, r12d
0106f1b2 js         0x14106f1cb
0106f1b4 mov        ecx, dword ptr [r8 + 4]
0106f1b8 test       ecx, ecx
0106f1ba jle        0x14106f1cb
0106f1bc mov        rax, qword ptr [rdx + 0x20]
0106f1c0 mov        r10, r12
0106f1c3 mov        r11d, ecx
0106f1c6 add        r10, qword ptr [rax]
0106f1c9 jmp        0x14106f1d0
0106f1cb mov        ebx, 0xffffffce
0106f1d0 test       ebx, ebx
0106f1d2 jne        0x141070258
0106f1d8 test       r11d, r11d
0106f1db je         0x14106f210
0106f1dd lea        rax, [rsp + 0x48]
0106f1e2 mov        r8d, r11d
0106f1e5 mov        qword ptr [rsp + 0x30], rax
0106f1ea mov        rdx, r10
0106f1ed mov        dword ptr [rsp + 0x28], 1
0106f1f5 mov        rcx, r15
0106f1f8 mov        dword ptr [rsp + 0x20], 0xa
0106f200 call       0x14106ac80
0106f205 mov        ebx, eax
0106f207 test       eax, eax
0106f209 jne        0x14106f210
0106f20b inc        dword ptr [rdi + 0xc]
0106f20e jmp        0x14106f218
0106f210 test       ebx, ebx
0106f212 jne        0x141070258
0106f218 xor        r12d, r12d
0106f21b nop        dword ptr [rax + rax]
0106f220 xorps      xmm0, xmm0
0106f223 lea        r8, [rsp + 0x60]
0106f228 xorps      xmm1, xmm1
0106f22b movdqa     xmmword ptr [rbp - 0x50], xmm0
0106f230 mov        edx, r12d
0106f233 movdqa     xmmword ptr [rbp - 0x40], xmm1
0106f238 mov        rcx, r14
0106f23b movdqa     xmmword ptr [rbp - 0x30], xmm0
0106f240 call       0x140eb8130
0106f245 cmp        dword ptr [rsp + 0x6c], 0
0106f24a je         0x14106f32f
0106f250 movsxd     r9, dword ptr [r14 + r12*4 + 0x160]
0106f258 xor        ebx, ebx
0106f25a test       r9d, r9d
0106f25d je         0x14106f316
0106f263 mov        r8, qword ptr [rbp - 0x60]
0106f267 xor        r11d, r11d
0106f26a xor        r10d, r10d
0106f26d test       r8, r8
0106f270 je         0x14106f4d8
0106f276 cmp        dword ptr [r8], 0x73747263
0106f27d jne        0x14106f4d8
0106f283 cmp        dword ptr [r8 + 0x3c], ebx
0106f287 je         0x14106f4d8
0106f28d test       r9d, r9d
0106f290 jle        0x14106f4d8
0106f296 cmp        r9d, dword ptr [r8 + 0x2c]
0106f29a jg         0x14106f4d8
0106f2a0 mov        rax, qword ptr [r8 + 0x10]
0106f2a4 mov        rax, qword ptr [rax]
0106f2a7 add        rax, -8
0106f2ab lea        rax, [rax + r9*8]
0106f2af test       rax, rax
0106f2b2 je         0x14106f2d1
0106f2b4 movsxd     rdx, dword ptr [rax]
0106f2b7 test       edx, edx
0106f2b9 js         0x14106f2d1
0106f2bb mov        ecx, dword ptr [rax + 4]
0106f2be test       ecx, ecx
0106f2c0 jle        0x14106f2d1
0106f2c2 mov        rax, qword ptr [r8 + 0x20]
0106f2c6 mov        r10, rdx
0106f2c9 mov        r11d, ecx
0106f2cc add        r10, qword ptr [rax]
0106f2cf jmp        0x14106f2d6
0106f2d1 mov        ebx, 0xffffffce
0106f2d6 test       ebx, ebx
0106f2d8 jne        0x141070258
0106f2de test       r11d, r11d
0106f2e1 je         0x14106f316
0106f2e3 lea        rax, [rsp + 0x48]
0106f2e8 mov        r8d, r11d
0106f2eb mov        qword ptr [rsp + 0x30], rax
0106f2f0 mov        rdx, r10
0106f2f3 mov        eax, dword ptr [rsp + 0x6c]
0106f2f7 mov        rcx, r15
0106f2fa mov        dword ptr [rsp + 0x28], 1
0106f302 mov        dword ptr [rsp + 0x20], eax
0106f306 call       0x14106ac80
0106f30b mov        ebx, eax
0106f30d test       eax, eax
0106f30f jne        0x14106f316
0106f311 inc        dword ptr [rdi + 0xc]
0106f314 jmp        0x14106f31e
0106f316 test       ebx, ebx
0106f318 jne        0x141070258
0106f31e movzx      eax, byte ptr [r12 + r14 + 0x92]
0106f327 mov        byte ptr [r12 + rdi + 0x14c], al
0106f32f inc        r12d
0106f332 cmp        r12d, 6
0106f336 jb         0x14106f220
0106f33c mov        r9, qword ptr [r14 + 0x68]
0106f340 test       byte ptr [r9], 1
0106f344 je         0x14106f846
0106f34a movsxd     r9, dword ptr [r9 + 0x18]
0106f34e lea        rdx, [r13 + 0x298]
0106f355 xor        ebx, ebx
0106f357 test       r9d, r9d
0106f35a je         0x14106f40f
0106f360 xor        r11d, r11d
0106f363 xor        r10d, r10d
0106f366 test       rdx, rdx
0106f369 je         0x14106f4d8
0106f36f cmp        dword ptr [rdx], 0x73747263
0106f375 jne        0x14106f4d8
0106f37b cmp        dword ptr [rdx + 0x3c], ebx
0106f37e je         0x14106f4d8
0106f384 test       r9d, r9d
0106f387 jle        0x14106f4d8
0106f38d cmp        r9d, dword ptr [rdx + 0x2c]
0106f391 jg         0x14106f4d8
0106f397 mov        rax, qword ptr [rdx + 0x10]
0106f39b lea        r8, [r9 - 1]
0106f39f mov        rax, qword ptr [rax]
0106f3a2 lea        r8, [rax + r8*8]
0106f3a6 test       r8, r8
0106f3a9 je         0x14106f3ca
0106f3ab movsxd     r12, dword ptr [r8]
0106f3ae test       r12d, r12d
0106f3b1 js         0x14106f3ca
0106f3b3 mov        ecx, dword ptr [r8 + 4]
0106f3b7 test       ecx, ecx
0106f3b9 jle        0x14106f3ca
0106f3bb mov        rax, qword ptr [rdx + 0x20]
0106f3bf mov        r10, r12
0106f3c2 mov        r11d, ecx
0106f3c5 add        r10, qword ptr [rax]
0106f3c8 jmp        0x14106f3cf
0106f3ca mov        ebx, 0xffffffce
0106f3cf test       ebx, ebx
0106f3d1 jne        0x141070258
0106f3d7 test       r11d, r11d
0106f3da je         0x14106f40f
0106f3dc lea        rax, [rsp + 0x48]
0106f3e1 mov        r8d, r11d
0106f3e4 mov        qword ptr [rsp + 0x30], rax
0106f3e9 mov        rdx, r10
0106f3ec mov        dword ptr [rsp + 0x28], 1
0106f3f4 mov        rcx, r15
0106f3f7 mov        dword ptr [rsp + 0x20], 0x3f
0106f3ff call       0x14106ac80
0106f404 mov        ebx, eax
0106f406 test       eax, eax
0106f408 jne        0x14106f40f
0106f40a inc        dword ptr [rdi + 0xc]
0106f40d jmp        0x14106f417
0106f40f test       ebx, ebx
0106f411 jne        0x141070258
0106f417 mov        rax, qword ptr [r14 + 0x68]
0106f41b lea        rdx, [r13 + 0x2e0]
0106f422 xor        ebx, ebx
0106f424 movsxd     r9, dword ptr [rax + 0x1c]
0106f428 test       r9d, r9d
0106f42b je         0x14106f4e2
0106f431 xor        r11d, r11d
0106f434 xor        r10d, r10d
0106f437 test       rdx, rdx
0106f43a je         0x14106f4d8
0106f440 cmp        dword ptr [rdx], 0x73747263
0106f446 jne        0x14106f4d8
0106f44c cmp        dword ptr [rdx + 0x3c], ebx
0106f44f je         0x14106f4d8
0106f455 test       r9d, r9d
0106f458 jle        0x14106f4d8
0106f45a cmp        r9d, dword ptr [rdx + 0x2c]
0106f45e jg         0x14106f4d8
0106f460 mov        rax, qword ptr [rdx + 0x10]
0106f464 lea        r8, [r9 - 1]
0106f468 mov        rax, qword ptr [rax]
0106f46b lea        r8, [rax + r8*8]
0106f46f test       r8, r8
0106f472 je         0x14106f493
0106f474 movsxd     r12, dword ptr [r8]
0106f477 test       r12d, r12d
0106f47a js         0x14106f493
0106f47c mov        ecx, dword ptr [r8 + 4]
0106f480 test       ecx, ecx
0106f482 jle        0x14106f493
0106f484 mov        rax, qword ptr [rdx + 0x20]
0106f488 mov        r10, r12
0106f48b mov        r11d, ecx
0106f48e add        r10, qword ptr [rax]
0106f491 jmp        0x14106f498
0106f493 mov        ebx, 0xffffffce
0106f498 test       ebx, ebx
0106f49a jne        0x141070258
0106f4a0 test       r11d, r11d
0106f4a3 je         0x14106f4e2
0106f4a5 lea        rax, [rsp + 0x48]
0106f4aa mov        r8d, r11d
0106f4ad mov        qword ptr [rsp + 0x30], rax
0106f4b2 mov        rdx, r10
0106f4b5 mov        dword ptr [rsp + 0x28], 1
0106f4bd mov        rcx, r15
0106f4c0 mov        dword ptr [rsp + 0x20], 0x40
0106f4c8 call       0x14106ac80
0106f4cd mov        ebx, eax
0106f4cf test       eax, eax
0106f4d1 jne        0x14106f4e2
0106f4d3 inc        dword ptr [rdi + 0xc]
0106f4d6 jmp        0x14106f4ea
0106f4d8 mov        ebx, 0xffffffce
0106f4dd jmp        0x141070258
0106f4e2 test       ebx, ebx
0106f4e4 jne        0x141070258
0106f4ea mov        r8, qword ptr [r14 + 0x68]
0106f4ee lea        rax, [rsp + 0x40]
0106f4f3 mov        qword ptr [rsp + 0x30], rax
0106f4f8 lea        rdx, [r13 + 0x520]
0106f4ff lea        rax, [rsp + 0x48]
0106f504 mov        r9d, 0x12
0106f50a mov        qword ptr [rsp + 0x28], rax
0106f50f mov        rcx, r15
0106f512 mov        r8d, dword ptr [r8 + 0x34]
0106f516 mov        dword ptr [rsp + 0x20], 1
0106f51e call       0x14106b030
0106f523 mov        ebx, eax
0106f525 test       eax, eax
0106f527 jne        0x141070258
0106f52d cmp        byte ptr [rsp + 0x40], al
0106f531 je         0x14106f538
0106f533 inc        dword ptr [rdi + 0xc]
0106f536 jmp        0x14106f540
0106f538 test       eax, eax
0106f53a jne        0x141070258
0106f540 mov        r8, qword ptr [r14 + 0x68]
0106f544 lea        rax, [rsp + 0x40]
0106f549 mov        qword ptr [rsp + 0x30], rax
0106f54e lea        rdx, [r13 + 0x520]
0106f555 lea        rax, [rsp + 0x48]
0106f55a mov        r9d, 0x16
0106f560 mov        qword ptr [rsp + 0x28], rax
0106f565 mov        rcx, r15
0106f568 mov        r8d, dword ptr [r8 + 0x38]
0106f56c mov        dword ptr [rsp + 0x20], 1
0106f574 call       0x14106b030
0106f579 mov        ebx, eax
0106f57b test       eax, eax
0106f57d jne        0x141070258
0106f583 cmp        byte ptr [rsp + 0x40], al
0106f587 je         0x14106f58e
0106f589 inc        dword ptr [rdi + 0xc]
0106f58c jmp        0x14106f596
0106f58e test       eax, eax
0106f590 jne        0x141070258
0106f596 mov        r8, qword ptr [r14 + 0x68]
0106f59a lea        rax, [rsp + 0x40]
0106f59f mov        qword ptr [rsp + 0x30], rax
0106f5a4 lea        rdx, [r13 + 0x520]
0106f5ab lea        rax, [rsp + 0x48]
0106f5b0 mov        r9d, 0x33
0106f5b6 mov        qword ptr [rsp + 0x28], rax
0106f5bb mov        rcx, r15
0106f5be mov        r8d, dword ptr [r8 + 0x3c]
0106f5c2 mov        dword ptr [rsp + 0x20], 1
0106f5ca call       0x14106b030
0106f5cf mov        ebx, eax
0106f5d1 test       eax, eax
0106f5d3 jne        0x141070258
0106f5d9 cmp        byte ptr [rsp + 0x40], al
0106f5dd je         0x14106f5e4
0106f5df inc        dword ptr [rdi + 0xc]
0106f5e2 jmp        0x14106f5ec
0106f5e4 test       eax, eax
0106f5e6 jne        0x141070258
0106f5ec mov        r8, qword ptr [r14 + 0x68]
0106f5f0 lea        rax, [rsp + 0x40]
0106f5f5 mov        qword ptr [rsp + 0x30], rax
0106f5fa lea        rdx, [r13 + 0x880]
0106f601 lea        rax, [rsp + 0x48]
0106f606 mov        r9d, 0x2e
0106f60c mov        qword ptr [rsp + 0x28], rax
0106f611 mov        rcx, r15
0106f614 mov        r8d, dword ptr [r8 + 0x40]
0106f618 mov        dword ptr [rsp + 0x20], 1
0106f620 call       0x14106b030
0106f625 mov        ebx, eax
0106f627 test       eax, eax
0106f629 jne        0x141070258
0106f62f cmp        byte ptr [rsp + 0x40], al
0106f633 je         0x14106f63a
0106f635 inc        dword ptr [rdi + 0xc]
0106f638 jmp        0x14106f642
0106f63a test       eax, eax
0106f63c jne        0x141070258
0106f642 mov        r8, qword ptr [r14 + 0x68]
0106f646 lea        rax, [rsp + 0x40]
0106f64b mov        qword ptr [rsp + 0x30], rax
0106f650 lea        rdx, [r13 + 0x568]
0106f657 lea        rax, [rsp + 0x48]
0106f65c mov        r9d, 0x13
0106f662 mov        qword ptr [rsp + 0x28], rax
0106f667 mov        rcx, r15
0106f66a mov        r8d, dword ptr [r8 + 0x20]
0106f66e mov        dword ptr [rsp + 0x20], 0
0106f676 call       0x14106b030
0106f67b mov        ebx, eax
0106f67d test       eax, eax
0106f67f jne        0x141070258
0106f685 cmp        byte ptr [rsp + 0x40], al
0106f689 je         0x14106f690
0106f68b inc        dword ptr [rdi + 0xc]
0106f68e jmp        0x14106f698
0106f690 test       eax, eax
0106f692 jne        0x141070258
0106f698 mov        r8, qword ptr [r14 + 0x68]
0106f69c lea        rax, [rsp + 0x40]
0106f6a1 mov        qword ptr [rsp + 0x30], rax
0106f6a6 lea        rdx, [r13 + 0x5b0]
0106f6ad lea        rax, [rsp + 0x48]
0106f6b2 mov        r9d, 0x25
0106f6b8 mov        qword ptr [rsp + 0x28], rax
0106f6bd mov        rcx, r15
0106f6c0 mov        r8d, dword ptr [r8 + 0x24]
0106f6c4 mov        dword ptr [rsp + 0x20], 0
0106f6cc call       0x14106b030
0106f6d1 mov        ebx, eax
0106f6d3 test       eax, eax
0106f6d5 jne        0x141070258
0106f6db cmp        byte ptr [rsp + 0x40], al
0106f6df je         0x14106f6e6
0106f6e1 inc        dword ptr [rdi + 0xc]
0106f6e4 jmp        0x14106f6ee
0106f6e6 test       eax, eax
0106f6e8 jne        0x141070258
0106f6ee mov        r8, qword ptr [r14 + 0x68]
0106f6f2 lea        rax, [rsp + 0x40]
0106f6f7 mov        qword ptr [rsp + 0x30], rax
0106f6fc lea        rdx, [r13 + 0x5b0]
0106f703 lea        rax, [rsp + 0x48]
0106f708 mov        r9d, 0x3a
0106f70e mov        qword ptr [rsp + 0x28], rax
0106f713 mov        rcx, r15
0106f716 mov        r8d, dword ptr [r8 + 0x28]
0106f71a mov        dword ptr [rsp + 0x20], 0
0106f722 call       0x14106b030
0106f727 mov        ebx, eax
0106f729 test       eax, eax
0106f72b jne        0x141070258
0106f731 cmp        byte ptr [rsp + 0x40], al
0106f735 je         0x14106f73c
0106f737 inc        dword ptr [rdi + 0xc]
0106f73a jmp        0x14106f744
0106f73c test       eax, eax
0106f73e jne        0x141070258
0106f744 mov        r8, qword ptr [r14 + 0x68]
0106f748 lea        rax, [rsp + 0x40]
0106f74d mov        qword ptr [rsp + 0x30], rax
0106f752 lea        rdx, [r13 + 0x5f8]
0106f759 lea        rax, [rsp + 0x48]
0106f75e xor        r12d, r12d
0106f761 mov        qword ptr [rsp + 0x28], rax
0106f766 mov        r9d, 0x39
0106f76c mov        r8d, dword ptr [r8 + 0x2c]
0106f770 mov        rcx, r15
0106f773 mov        dword ptr [rsp + 0x20], r12d
0106f778 call       0x14106b030
0106f77d mov        ebx, eax
0106f77f test       eax, eax
0106f781 jne        0x141070258
0106f787 cmp        byte ptr [rsp + 0x40], r12b
0106f78c je         0x14106f793
0106f78e inc        dword ptr [rdi + 0xc]
0106f791 jmp        0x14106f79b
0106f793 test       eax, eax
0106f795 jne        0x141070258
0106f79b mov        r8, qword ptr [r14 + 0x68]
0106f79f lea        rax, [rsp + 0x40]
0106f7a4 mov        qword ptr [rsp + 0x30], rax
0106f7a9 lea        rdx, [r13 + 0x718]
0106f7b0 lea        rax, [rsp + 0x48]
0106f7b5 mov        r9d, 0x1c
0106f7bb mov        qword ptr [rsp + 0x28], rax
0106f7c0 mov        rcx, r15
0106f7c3 mov        r8d, dword ptr [r8 + 0x30]
0106f7c7 mov        dword ptr [rsp + 0x20], 1
0106f7cf call       0x14106b030
0106f7d4 mov        ebx, eax
0106f7d6 test       eax, eax
0106f7d8 jne        0x141070258
0106f7de cmp        byte ptr [rsp + 0x40], r12b
0106f7e3 je         0x14106f7ea
0106f7e5 inc        dword ptr [rdi + 0xc]
0106f7e8 jmp        0x14106f7f2
0106f7ea test       eax, eax
0106f7ec jne        0x141070258
0106f7f2 mov        r8, qword ptr [r14 + 0x68]
0106f7f6 lea        rax, [rsp + 0x40]
0106f7fb mov        qword ptr [rsp + 0x30], rax
0106f800 lea        rdx, [r13 + 0x1888]
0106f807 lea        rax, [rsp + 0x48]
0106f80c mov        r9d, 0x2a
0106f812 mov        qword ptr [rsp + 0x28], rax
0106f817 mov        rcx, r15
0106f81a mov        r8d, dword ptr [r8 + 0x4c]
0106f81e mov        dword ptr [rsp + 0x20], r12d
0106f823 call       0x14106b030
0106f828 mov        ebx, eax
0106f82a test       eax, eax
0106f82c jne        0x141070258
0106f832 cmp        byte ptr [rsp + 0x40], r12b
0106f837 je         0x14106f83e
0106f839 inc        dword ptr [rdi + 0xc]
0106f83c jmp        0x14106f846
0106f83e test       eax, eax
0106f840 jne        0x141070258
0106f846 mov        r8, qword ptr [rsi + 0x10]
0106f84a test       byte ptr [r8], 1
0106f84e je         0x14106fbb2
0106f854 mov        r8d, dword ptr [r8 + 0x68]
0106f858 lea        rax, [rsp + 0x40]
0106f85d mov        qword ptr [rsp + 0x30], rax
0106f862 lea        rdx, [r13 + 0x7a8]
0106f869 lea        rax, [rsp + 0x48]
0106f86e mov        r9d, 0x2b
0106f874 mov        qword ptr [rsp + 0x28], rax
0106f879 mov        rcx, r15
0106f87c mov        dword ptr [rsp + 0x20], 1
0106f884 call       0x14106b030
0106f889 mov        ebx, eax
0106f88b test       eax, eax
0106f88d jne        0x141070258
0106f893 cmp        byte ptr [rsp + 0x40], al
0106f897 je         0x14106f89e
0106f899 inc        dword ptr [rdi + 0xc]
0106f89c jmp        0x14106f8a6
0106f89e test       eax, eax
0106f8a0 jne        0x141070258
0106f8a6 mov        r8, qword ptr [rsi + 0x10]
0106f8aa lea        rax, [rsp + 0x40]
0106f8af mov        qword ptr [rsp + 0x30], rax
0106f8b4 lea        rdx, [r13 + 0x7f0]
0106f8bb lea        rax, [rsp + 0x48]
0106f8c0 mov        r9d, 0x2d
0106f8c6 mov        qword ptr [rsp + 0x28], rax
0106f8cb mov        rcx, r15
0106f8ce mov        r8d, dword ptr [r8 + 0x6c]
0106f8d2 mov        dword ptr [rsp + 0x20], 2
0106f8da call       0x14106b030
0106f8df mov        ebx, eax
0106f8e1 test       eax, eax
0106f8e3 jne        0x141070258
0106f8e9 cmp        byte ptr [rsp + 0x40], al
0106f8ed je         0x14106f8f4
0106f8ef inc        dword ptr [rdi + 0xc]
0106f8f2 jmp        0x14106f8fc
0106f8f4 test       eax, eax
0106f8f6 jne        0x141070258
0106f8fc mov        r8, qword ptr [rsi + 0x10]
0106f900 lea        rax, [rsp + 0x40]
0106f905 mov        qword ptr [rsp + 0x30], rax
0106f90a lea        rdx, [r13 + 0x838]
0106f911 lea        rax, [rsp + 0x48]
0106f916 mov        r9d, 0x34
0106f91c mov        qword ptr [rsp + 0x28], rax
0106f921 mov        rcx, r15
0106f924 mov        r8d, dword ptr [r8 + 0x70]
0106f928 mov        dword ptr [rsp + 0x20], 1
0106f930 call       0x14106b030
0106f935 mov        ebx, eax
0106f937 test       eax, eax
0106f939 jne        0x141070258
0106f93f cmp        byte ptr [rsp + 0x40], al
0106f943 je         0x14106f94a
0106f945 inc        dword ptr [rdi + 0xc]
0106f948 jmp        0x14106f952
0106f94a test       eax, eax
0106f94c jne        0x141070258
0106f952 mov        r8, qword ptr [rsi + 0x10]
0106f956 lea        rax, [rsp + 0x40]
0106f95b mov        qword ptr [rsp + 0x30], rax
0106f960 lea        rdx, [r13 + 0x8c8]
0106f967 lea        rax, [rsp + 0x48]
0106f96c mov        r9d, 0x3b
0106f972 mov        qword ptr [rsp + 0x28], rax
0106f977 mov        rcx, r15
0106f97a mov        r8d, dword ptr [r8 + 0x74]
0106f97e mov        dword ptr [rsp + 0x20], 1
0106f986 call       0x14106b030
0106f98b mov        ebx, eax
0106f98d test       eax, eax
0106f98f jne        0x141070258
0106f995 cmp        byte ptr [rsp + 0x40], al
0106f999 je         0x14106f9a0
0106f99b inc        dword ptr [rdi + 0xc]
0106f99e jmp        0x14106f9a8
0106f9a0 test       eax, eax
0106f9a2 jne        0x141070258
0106f9a8 mov        r8, qword ptr [rsi + 0x10]
0106f9ac lea        rax, [rsp + 0x40]
0106f9b1 mov        qword ptr [rsp + 0x30], rax
0106f9b6 lea        rdx, [r13 + 0x910]
0106f9bd lea        rax, [rsp + 0x48]
0106f9c2 mov        r9d, 0x3c
0106f9c8 mov        qword ptr [rsp + 0x28], rax
0106f9cd mov        rcx, r15
0106f9d0 mov        r8d, dword ptr [r8 + 0x78]
0106f9d4 mov        dword ptr [rsp + 0x20], 1
0106f9dc call       0x14106b030
0106f9e1 mov        ebx, eax
0106f9e3 test       eax, eax
0106f9e5 jne        0x141070258
0106f9eb cmp        byte ptr [rsp + 0x40], al
0106f9ef je         0x14106f9f6
0106f9f1 inc        dword ptr [rdi + 0xc]
0106f9f4 jmp        0x14106f9fe
0106f9f6 test       eax, eax
0106f9f8 jne        0x141070258
0106f9fe mov        r8, qword ptr [rsi + 0x10]
0106fa02 lea        rax, [rsp + 0x40]
0106fa07 mov        qword ptr [rsp + 0x30], rax
0106fa0c lea        rdx, [r13 + 0x8c8]
0106fa13 lea        rax, [rsp + 0x48]
0106fa18 mov        r9d, 0x3d
0106fa1e mov        qword ptr [rsp + 0x28], rax
0106fa23 mov        rcx, r15
0106fa26 mov        r8d, dword ptr [r8 + 0x7c]
0106fa2a mov        dword ptr [rsp + 0x20], 1
0106fa32 call       0x14106b030
0106fa37 mov        ebx, eax
0106fa39 test       eax, eax
0106fa3b jne        0x141070258
0106fa41 cmp        byte ptr [rsp + 0x40], al
0106fa45 je         0x14106fa4c
0106fa47 inc        dword ptr [rdi + 0xc]
0106fa4a jmp        0x14106fa54
0106fa4c test       eax, eax
0106fa4e jne        0x141070258
0106fa54 mov        r8, qword ptr [rsi + 0x10]
0106fa58 lea        rax, [rsp + 0x40]
0106fa5d mov        qword ptr [rsp + 0x30], rax
0106fa62 lea        rdx, [r13 + 0x910]
0106fa69 lea        rax, [rsp + 0x48]
0106fa6e mov        r9d, 0x3e
0106fa74 mov        qword ptr [rsp + 0x28], rax
0106fa79 mov        rcx, r15
0106fa7c mov        r8d, dword ptr [r8 + 0x80]
0106fa83 mov        dword ptr [rsp + 0x20], 1
0106fa8b call       0x14106b030
0106fa90 mov        ebx, eax
0106fa92 test       eax, eax
0106fa94 jne        0x141070258
0106fa9a cmp        byte ptr [rsp + 0x40], al
0106fa9e je         0x14106faa5
0106faa0 inc        dword ptr [rdi + 0xc]
0106faa3 jmp        0x14106faad
0106faa5 test       eax, eax
0106faa7 jne        0x141070258
0106faad test       byte ptr [rsi + 0x40], 0x20
0106fab1 je         0x14106fb82
0106fab7 mov        rcx, rsi
0106faba call       0x140fa9220
0106fabf mov        r12, rax
0106fac2 test       rax, rax
0106fac5 je         0x14106fb82
0106facb lea        rdx, [rsp + 0x50]
0106fad0 mov        qword ptr [rsp + 0x50], 0
0106fad9 mov        rcx, rax
0106fadc call       0x140bde130
0106fae1 mov        ebx, eax
0106fae3 mov        rax, qword ptr [rsp + 0x50]
0106fae8 test       ebx, ebx
0106faea jne        0x14106fc0a
0106faf0 test       rax, rax
0106faf3 je         0x14106fb2b
0106faf5 mov        rcx, rax
0106faf8 call       qword ptr [rip + 0x879472]
0106fafe cmp        rax, 0x500000
0106fb04 ja         0x14106fb4d
0106fb06 mov        rcx, qword ptr [rsp + 0x50]
0106fb0b call       qword ptr [rip + 0x87945f]
0106fb11 mov        rcx, qword ptr [rsp + 0x50]
0106fb16 mov        qword ptr [rsp + 0x58], rax
0106fb1b call       qword ptr [rip + 0x879457]
0106fb21 mov        rdx, rax
0106fb24 mov        rax, qword ptr [rsp + 0x58]
0106fb29 jmp        0x14106fb2d
0106fb2b xor        edx, edx
0106fb2d lea        rcx, [rsp + 0x48]
0106fb32 mov        r9d, 0x15
0106fb38 mov        qword ptr [rsp + 0x20], rcx
0106fb3d mov        r8d, eax
0106fb40 mov        rcx, r15
0106fb43 call       0x14106af90
0106fb48 inc        dword ptr [rdi + 0xc]
0106fb4b mov        ebx, eax
0106fb4d mov        rax, qword ptr [rsp + 0x50]
0106fb52 test       rax, rax
0106fb55 je         0x14106fb60
0106fb57 mov        rcx, rax
0106fb5a call       qword ptr [rip + 0x8792c0]
0106fb60 cmp        dword ptr [r12], 0x63687064
0106fb68 jne        0x14106fb7a
0106fb6a sub        dword ptr [r12 + 4], 1
0106fb70 jne        0x14106fb7a
0106fb72 mov        rcx, r12
0106fb75 call       0x140bde340
0106fb7a test       ebx, ebx
0106fb7c jne        0x141070258
0106fb82 mov        rax, qword ptr [rsi + 0x10]
0106fb86 mov        rdx, qword ptr [rax + 0x98]
0106fb8d test       rdx, rdx
0106fb90 je         0x14106fbb2
0106fb92 lea        r9, [rsp + 0x48]
0106fb97 mov        r8d, 0x30
0106fb9d mov        rcx, r15
0106fba0 call       0x14106b140
0106fba5 mov        ebx, eax
0106fba7 test       eax, eax
0106fba9 jne        0x141070258
0106fbaf inc        dword ptr [rdi + 0xc]
0106fbb2 mov        r8, qword ptr [r14 + 0x70]
0106fbb6 test       byte ptr [r8], 1
0106fbba je         0x14106fd1b
0106fbc0 mov        r8d, dword ptr [r8 + 0x28]
0106fbc4 lea        rax, [rsp + 0x40]
0106fbc9 mov        qword ptr [rsp + 0x30], rax
0106fbce lea        rdx, [r13 + 0x640]
0106fbd5 lea        rax, [rsp + 0x48]
0106fbda mov        r9d, 0x18
0106fbe0 mov        qword ptr [rsp + 0x28], rax
0106fbe5 mov        rcx, r15
0106fbe8 mov        dword ptr [rsp + 0x20], 1
0106fbf0 call       0x14106b030
0106fbf5 mov        ebx, eax
0106fbf7 test       eax, eax
0106fbf9 jne        0x141070258
0106fbff cmp        byte ptr [rsp + 0x40], al
0106fc03 je         0x14106fc11
0106fc05 inc        dword ptr [rdi + 0xc]
0106fc08 jmp        0x14106fc19
0106fc0a xor        ebx, ebx
0106fc0c jmp        0x14106fb52
0106fc11 test       eax, eax
0106fc13 jne        0x141070258
0106fc19 mov        r8, qword ptr [r14 + 0x70]
0106fc1d lea        rax, [rsp + 0x40]
0106fc22 mov        qword ptr [rsp + 0x30], rax
0106fc27 lea        rdx, [r13 + 0x6d0]
0106fc2e lea        rax, [rsp + 0x48]
0106fc33 mov        r9d, 0x19
0106fc39 mov        qword ptr [rsp + 0x28], rax
0106fc3e mov        rcx, r15
0106fc41 mov        r8d, dword ptr [r8 + 0x2c]
0106fc45 mov        dword ptr [rsp + 0x20], 1
0106fc4d call       0x14106b030
0106fc52 mov        ebx, eax
0106fc54 test       eax, eax
0106fc56 jne        0x141070258
0106fc5c cmp        byte ptr [rsp + 0x40], al
0106fc60 je         0x14106fc67
0106fc62 inc        dword ptr [rdi + 0xc]
0106fc65 jmp        0x14106fc6f
0106fc67 test       eax, eax
0106fc69 jne        0x141070258
0106fc6f mov        r8, qword ptr [r14 + 0x70]
0106fc73 lea        rax, [rsp + 0x40]
0106fc78 mov        qword ptr [rsp + 0x30], rax
0106fc7d lea        rdx, [r13 + 0x760]
0106fc84 lea        rax, [rsp + 0x48]
0106fc89 mov        r9d, 0x1d
0106fc8f mov        qword ptr [rsp + 0x28], rax
0106fc94 mov        rcx, r15
0106fc97 mov        r8d, dword ptr [r8 + 0x24]
0106fc9b mov        dword ptr [rsp + 0x20], 2
0106fca3 call       0x14106b030
0106fca8 mov        ebx, eax
0106fcaa test       eax, eax
0106fcac jne        0x141070258
0106fcb2 cmp        byte ptr [rsp + 0x40], al
0106fcb6 je         0x14106fcbd
0106fcb8 inc        dword ptr [rdi + 0xc]
0106fcbb jmp        0x14106fcc5
0106fcbd test       eax, eax
0106fcbf jne        0x141070258
0106fcc5 mov        r8, qword ptr [r14 + 0x70]
0106fcc9 lea        rax, [rsp + 0x40]
0106fcce mov        qword ptr [rsp + 0x30], rax
0106fcd3 lea        rdx, [r13 + 0x6d0]
0106fcda lea        rax, [rsp + 0x48]
0106fcdf mov        r9d, 0x41
0106fce5 mov        qword ptr [rsp + 0x28], rax
0106fcea mov        rcx, r15
0106fced mov        r8d, dword ptr [r8 + 0x30]
0106fcf1 mov        dword ptr [rsp + 0x20], 1
0106fcf9 call       0x14106b030
0106fcfe mov        ebx, eax
0106fd00 test       eax, eax
0106fd02 jne        0x141070258
0106fd08 cmp        byte ptr [rsp + 0x40], al
0106fd0c je         0x14106fd13
0106fd0e inc        dword ptr [rdi + 0xc]
0106fd11 jmp        0x14106fd1b
0106fd13 test       eax, eax
0106fd15 jne        0x141070258
0106fd1b mov        rdx, qword ptr [rsi + 0x18]
0106fd1f test       byte ptr [rdx], 1
0106fd22 je         0x14106fdef
0106fd28 xor        r12d, r12d
0106fd2b cmp        dword ptr [rdx + 0x1c], r12d
0106fd2f jbe        0x14106fd75
0106fd31 nop        dword ptr [rax]
0106fd35 nop        word ptr [rax + rax]
0106fd40 lea        r8, [rdx + 0x20]
0106fd44 mov        eax, r12d
0106fd47 imul       rcx, rax, 0x38
0106fd4b lea        r9, [rsp + 0x48]
0106fd50 mov        rdx, rdi
0106fd53 add        r8, rcx
0106fd56 mov        rcx, r15
0106fd59 call       0x14106c980
0106fd5e mov        ebx, eax
0106fd60 test       eax, eax
0106fd62 jne        0x141070258
0106fd68 mov        rdx, qword ptr [rsi + 0x18]
0106fd6c inc        r12d
0106fd6f cmp        r12d, dword ptr [rdx + 0x1c]
0106fd73 jb         0x14106fd40
0106fd75 movzx      eax, byte ptr [rdx + 0x18]
0106fd79 mov        byte ptr [r15 + 0xa00284], al
0106fd80 mov        rax, qword ptr [rsi + 0x18]
0106fd84 movzx      ecx, byte ptr [rax + 0x19]
0106fd88 mov        byte ptr [rdi + 0x15d], cl
0106fd8e mov        rax, qword ptr [rsi + 0x18]
0106fd92 movzx      ecx, byte ptr [rax + 0x1a]
0106fd96 mov        byte ptr [rdi + 0x170], cl
0106fd9c mov        rax, qword ptr [rsi + 0x18]
0106fda0 movzx      ecx, byte ptr [rax]
0106fda3 shr        cl, 3
0106fda6 and        cl, 1
0106fda9 mov        byte ptr [rdi + 0x173], cl
0106fdaf mov        rax, qword ptr [rsi + 0x18]
0106fdb3 movzx      ecx, byte ptr [rax + 0x12]
0106fdb7 mov        byte ptr [rdi + 0x263], cl
0106fdbd mov        rax, qword ptr [rsi + 0x18]
0106fdc1 movzx      ecx, byte ptr [rax + 0x14]
0106fdc5 mov        byte ptr [rdi + 0x2e0], cl
0106fdcb mov        rax, qword ptr [rsi + 0x18]
0106fdcf movzx      ecx, word ptr [rax + 0x12]
0106fdd3 cmp        cx, 1
0106fdd7 je         0x14106fde7
0106fdd9 sub        cx, 2
0106fddd cmp        cx, 1
0106fde1 jbe        0x14106fde7
0106fde3 xor        al, al
0106fde5 jmp        0x14106fde9
0106fde7 mov        al, 1
0106fde9 mov        byte ptr [rdi + 0x1de], al
0106fdef test       byte ptr [r14 + 0x9b], 8
0106fdf7 jne        0x14106fe1c
0106fdf9 cmp        byte ptr [r14 + 0x9d], 0
0106fe01 jge        0x14106fed5
0106fe07 xor        edx, edx
0106fe09 mov        rcx, r14
0106fe0c call       0x140fa0b70
0106fe11 test       eax, 0x200004
0106fe16 je         0x14106fed5
0106fe1c cmp        dword ptr [rsi + 0x34], 0x48545450
0106fe23 jne        0x14106fed5
0106fe29 mov        r8, qword ptr [r14 + 0x68]
0106fe2d lea        rax, [rsp + 0x40]
0106fe32 mov        qword ptr [rsp + 0x30], rax
0106fe37 lea        rdx, [r13 + 0x4d8]
0106fe3e lea        rax, [rsp + 0x48]
0106fe43 mov        r9d, 0xf
0106fe49 mov        qword ptr [rsp + 0x28], rax
0106fe4e mov        rcx, r15
0106fe51 mov        r8d, dword ptr [r8 + 0x48]
0106fe55 mov        dword ptr [rsp + 0x20], 1
0106fe5d call       0x14106b030
0106fe62 mov        ebx, eax
0106fe64 test       eax, eax
0106fe66 jne        0x141070258
0106fe6c cmp        byte ptr [rsp + 0x40], al
0106fe70 je         0x14106fe77
0106fe72 inc        dword ptr [rdi + 0xc]
0106fe75 jmp        0x14106fe7f
0106fe77 test       eax, eax
0106fe79 jne        0x141070258
0106fe7f mov        r8, qword ptr [r14 + 0x68]
0106fe83 lea        rax, [rsp + 0x40]
0106fe88 mov        qword ptr [rsp + 0x30], rax
0106fe8d lea        rdx, [r13 + 0x4d8]
0106fe94 lea        rax, [rsp + 0x48]
0106fe99 mov        r9d, 0x10
0106fe9f mov        qword ptr [rsp + 0x28], rax
0106fea4 mov        rcx, r15
0106fea7 mov        r8d, dword ptr [r8 + 0x44]
0106feab mov        dword ptr [rsp + 0x20], 1
0106feb3 call       0x14106b030
0106feb8 mov        ebx, eax
0106feba test       eax, eax
0106febc jne        0x141070258
0106fec2 cmp        byte ptr [rsp + 0x40], al
0106fec6 je         0x14106fecd
0106fec8 inc        dword ptr [rdi + 0xc]
0106fecb jmp        0x14106fed5
0106fecd test       eax, eax
0106fecf jne        0x141070258
0106fed5 cmp        qword ptr [rsi + 0x2d0], 0
0106fedd mov        r13d, 8
0106fee3 je         0x14106ffce
0106fee9 mov        rax, qword ptr gs:[0x58]
0106fef2 xor        ebx, ebx
0106fef4 xor        r12d, r12d
0106fef7 mov        rcx, qword ptr [rax]
0106fefa mov        eax, dword ptr [r13 + rcx]
0106feff cmp        dword ptr [rip + 0x109dd4f], eax
0106ff05 jg         0x14107031c
0106ff0b xor        r13d, r13d
0106ff0e lea        rcx, [rip + 0x108e903]
0106ff15 mov        rax, qword ptr [rcx + r13*8]
0106ff19 mov        rcx, qword ptr [rsi + 0x2d0]
0106ff20 mov        qword ptr [rsp + 0x50], rax
0106ff25 test       rcx, rcx
0106ff28 je         0x14106ff86
0106ff2a test       rax, rax
0106ff2d je         0x14106ff86
0106ff2f mov        rdx, rax
0106ff32 call       qword ptr [rip + 0x878eb8]
0106ff38 mov        qword ptr [rsp + 0x58], rax
0106ff3d test       rax, rax
0106ff40 je         0x14106ff86
0106ff42 test       r12, r12
0106ff45 jne        0x14106ff75
0106ff47 mov        r9, qword ptr [rip + 0x878ef2]
0106ff4e xor        edx, edx
0106ff50 mov        r8, qword ptr [rip + 0x878e91]
0106ff57 mov        rcx, qword ptr [rip + 0x1036132]
0106ff5e call       qword ptr [rip + 0x879354]
0106ff64 mov        r12, rax
0106ff67 test       rax, rax
0106ff6a je         0x141070141
0106ff70 mov        rax, qword ptr [rsp + 0x58]
0106ff75 mov        rdx, qword ptr [rsp + 0x50]
0106ff7a mov        r8, rax
0106ff7d mov        rcx, r12
0106ff80 call       qword ptr [rip + 0x87910a]
0106ff86 inc        r13d
0106ff89 cmp        r13d, 3
0106ff8d jb         0x14106ff0e
0106ff93 test       r12, r12
0106ff96 je         0x14106ffc0
0106ff98 lea        r9, [rsp + 0x48]
0106ff9d mov        r8d, 0x38
0106ffa3 mov        rdx, r12
0106ffa6 mov        rcx, r15
0106ffa9 call       0x14106b140
0106ffae mov        ebx, eax
0106ffb0 test       eax, eax
0106ffb2 jne        0x14106ffb7
0106ffb4 inc        dword ptr [rdi + 0xc]
0106ffb7 mov        rcx, r12
0106ffba call       qword ptr [rip + 0x878e60]
0106ffc0 test       ebx, ebx
0106ffc2 jne        0x141070258
0106ffc8 mov        r13d, 8
0106ffce mov        rax, qword ptr [r14 + 0x68]
0106ffd2 cmp        qword ptr [rax + 0x58], 0
0106ffd7 je         0x1410700e8
0106ffdd xor        edx, edx
0106ffdf mov        rcx, r14
0106ffe2 xor        ebx, ebx
0106ffe4 call       0x140fa1a50
0106ffe9 mov        r12, rax
0106ffec test       rax, rax
0106ffef je         0x1410700e0
0106fff5 mov        rcx, rax
0106fff8 call       qword ptr [rip + 0x8792c2]
0106fffe test       rax, rax
01070001 jle        0x1410700b3
01070007 mov        rcx, r14
0107000a call       0x140fbba60
0107000f test       al, al
01070011 jne        0x1410700b3
01070017 mov        rax, qword ptr gs:[0x58]
01070020 mov        edx, r13d
01070023 mov        rcx, qword ptr [rax]
01070026 mov        eax, dword ptr [rdx + rcx]
01070029 cmp        dword ptr [rip + 0x109dc29], eax
0107002f jg         0x14107029e
01070035 mov        rdx, qword ptr [rip + 0x108e7ac]
0107003c test       rdx, rdx
0107003f je         0x14107004a
01070041 mov        rcx, r12
01070044 call       qword ptr [rip + 0x8792b6]
0107004a mov        rdx, qword ptr [rip + 0x108e79f]
01070051 test       rdx, rdx
01070054 je         0x14107005f
01070056 mov        rcx, r12
01070059 call       qword ptr [rip + 0x8792a1]
0107005f mov        rdx, qword ptr [rip + 0x108e792]
01070066 test       rdx, rdx
01070069 je         0x141070074
0107006b mov        rcx, r12
0107006e call       qword ptr [rip + 0x87928c]
01070074 mov        rdx, qword ptr [rip + 0x108e785]
0107007b test       rdx, rdx
0107007e je         0x141070089
01070080 mov        rcx, r12
01070083 call       qword ptr [rip + 0x879277]
01070089 mov        rdx, qword ptr [rip + 0x108e778]
01070090 test       rdx, rdx
01070093 je         0x14107009e
01070095 mov        rcx, r12
01070098 call       qword ptr [rip + 0x879262]
0107009e mov        rdx, qword ptr [rip + 0x108e76b]
010700a5 test       rdx, rdx
010700a8 je         0x1410700b3
010700aa mov        rcx, r12
010700ad call       qword ptr [rip + 0x87924d]
010700b3 mov        rcx, r12
010700b6 call       qword ptr [rip + 0x879204]
010700bc test       rax, rax
010700bf jle        0x1410700e0
010700c1 lea        r9, [rsp + 0x48]
010700c6 mov        r8d, 0x36
010700cc mov        rdx, r12
010700cf mov        rcx, r15
010700d2 call       0x14106b140
010700d7 mov        ebx, eax
010700d9 test       eax, eax
010700db jne        0x1410700e0
010700dd inc        dword ptr [rdi + 0xc]
010700e0 test       ebx, ebx
010700e2 jne        0x141070258
010700e8 mov        eax, dword ptr [rdi + 0x14]
010700eb cmp        eax, 1
010700ee jne        0x141070181
010700f4 mov        r8d, dword ptr [rsi + 0x2b8]
010700fb lea        rax, [rsp + 0x40]
01070100 mov        rdx, qword ptr [rsi + 0x2c8]
01070107 mov        r9d, 0xd
0107010d mov        qword ptr [rsp + 0x30], rax
01070112 mov        rcx, r15
01070115 lea        rax, [rsp + 0x48]
0107011a mov        qword ptr [rsp + 0x28], rax
0107011f mov        dword ptr [rsp + 0x20], 1
01070127 call       0x14106b030
0107012c mov        ebx, eax
0107012e test       eax, eax
01070130 jne        0x141070258
01070136 cmp        byte ptr [rsp + 0x40], al
0107013a je         0x14107014b
0107013c inc        dword ptr [rdi + 0xc]
0107013f jmp        0x141070153
01070141 mov        ebx, 0xffffff94
01070146 jmp        0x141070258
0107014b test       eax, eax
0107014d jne        0x141070258
01070153 mov        r8d, dword ptr [rsi + 0x2c0]
0107015a lea        rax, [rsp + 0x40]
0107015f mov        qword ptr [rsp + 0x30], rax
01070164 mov        r9d, 0xb
0107016a lea        rax, [rsp + 0x48]
0107016f mov        qword ptr [rsp + 0x28], rax
01070174 mov        dword ptr [rsp + 0x20], 2
0107017c jmp        0x141070204
01070181 cmp        eax, 2
01070184 jne        0x141070229
0107018a mov        r8d, dword ptr [rsi + 0x2b8]
01070191 lea        rax, [rsp + 0x40]
01070196 mov        rdx, qword ptr [rsi + 0x2c8]
0107019d mov        r9d, 0xb
010701a3 mov        qword ptr [rsp + 0x30], rax
010701a8 mov        rcx, r15
010701ab lea        rax, [rsp + 0x48]
010701b0 mov        qword ptr [rsp + 0x28], rax
010701b5 mov        dword ptr [rsp + 0x20], 0
010701bd call       0x14106b030
010701c2 mov        ebx, eax
010701c4 test       eax, eax
010701c6 jne        0x141070258
010701cc cmp        byte ptr [rsp + 0x40], al
010701d0 je         0x1410701d7
010701d2 inc        dword ptr [rdi + 0xc]
010701d5 jmp        0x1410701db
010701d7 test       eax, eax
010701d9 jne        0x141070258
010701db mov        r8d, dword ptr [rsi + 0x2bc]
010701e2 lea        rax, [rsp + 0x40]
010701e7 mov        qword ptr [rsp + 0x30], rax
010701ec mov        r9d, 0x11
010701f2 lea        rax, [rsp + 0x48]
010701f7 mov        qword ptr [rsp + 0x28], rax
010701fc mov        dword ptr [rsp + 0x20], 0
01070204 mov        rdx, qword ptr [rsi + 0x2c8]
0107020b mov        rcx, r15
0107020e call       0x14106b030
01070213 mov        ebx, eax
01070215 test       eax, eax
01070217 jne        0x141070258
01070219 cmp        byte ptr [rsp + 0x40], 0
0107021e je         0x141070225
01070220 inc        dword ptr [rdi + 0xc]
01070223 jmp        0x141070229
01070225 test       eax, eax
01070227 jne        0x141070258
01070229 mov        ebx, dword ptr [rsp + 0x48]
0107022d mov        rdx, rdi
01070230 sub        ebx, r15d
01070233 mov        rcx, r15
01070236 add        ebx, 0xff5ffed8
0107023c mov        dword ptr [rdi + 8], ebx
0107023f call       0x141069150
01070244 mov        r8d, ebx
01070247 lea        rdx, [r15 + 0xa00128]
0107024e mov        rcx, r15
01070251 call       0x14106ab70
01070256 mov        ebx, eax
01070258 mov        r13, qword ptr [rsp + 0x300]
01070260 mov        eax, ebx
01070262 mov        rbx, qword ptr [rsp + 0x350]
0107026a mov        r12, qword ptr [rsp + 0x308]
01070272 mov        rdi, qword ptr [rsp + 0x310]
0107027a jmp        0x141070281
; range 0x107027c..0x107029e (exclusive)
0107027c mov        eax, 0xffffffce
01070281 mov        rcx, qword ptr [rbp + 0x1f0]
01070288 xor        rcx, rsp
0107028b call       0x14179b8e0
01070290 add        rsp, 0x318
01070297 pop        r15
01070299 pop        r14
0107029b pop        rsi
0107029c pop        rbp
0107029d ret        
; range 0x107029e..0x1070370 (exclusive)
0107029e lea        rcx, [rip + 0x109d9b3]
010702a5 call       0x14179c258
010702aa cmp        dword ptr [rip + 0x109d9a7], -1
010702b1 jne        0x141070035
010702b7 mov        rax, qword ptr [rip + 0x103f442]
010702be lea        rcx, [rip + 0x109d993]
010702c5 mov        qword ptr [rip + 0x108e51c], rax
010702cc mov        rax, qword ptr [rip + 0x103f435]
010702d3 mov        qword ptr [rip + 0x108e516], rax
010702da mov        rax, qword ptr [rip + 0x103f42f]
010702e1 mov        qword ptr [rip + 0x108e510], rax
010702e8 mov        rax, qword ptr [rip + 0x103f429]
010702ef mov        qword ptr [rip + 0x108e50a], rax
010702f6 mov        rax, qword ptr [rip + 0x103f423]
010702fd mov        qword ptr [rip + 0x108e504], rax
01070304 mov        rax, qword ptr [rip + 0x103f41d]
0107030b mov        qword ptr [rip + 0x108e4fe], rax
01070312 call       0x14179c1ec
01070317 jmp        0x141070035
0107031c lea        rcx, [rip + 0x109d931]
01070323 call       0x14179c258
01070328 cmp        dword ptr [rip + 0x109d925], -1
0107032f jne        0x14106ff0b
01070335 mov        rax, qword ptr [rip + 0x103f404]
0107033c lea        rcx, [rip + 0x109d911]
01070343 mov        qword ptr [rip + 0x108e4ce], rax
0107034a mov        rax, qword ptr [rip + 0x103f3f7]
01070351 mov        qword ptr [rip + 0x108e4c8], rax
01070358 mov        rax, qword ptr [rip + 0x103f3f1]
0107035f mov        qword ptr [rip + 0x108e4c2], rax
01070366 call       0x14179c1ec
0107036b jmp        0x14106ff0b
