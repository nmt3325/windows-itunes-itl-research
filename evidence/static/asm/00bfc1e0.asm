; Original iTunes.exe machine code; base=0x140000000; RVA=0xbfc1e0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0xbfc1e0..0xbfc201 (exclusive)
00bfc1e0 mov        r11, rsp
00bfc1e3 push       rbx
00bfc1e4 sub        rsp, 0x70
00bfc1e8 mov        rax, qword ptr [rip + 0x13d8e51]
00bfc1ef xor        rax, rsp
00bfc1f2 mov        qword ptr [rsp + 0x38], rax
00bfc1f7 mov        rax, qword ptr [rsp + 0xa0]
00bfc1ff xor        ebx, ebx
; range 0xbfc201..0xbfc234 (exclusive)
00bfc201 mov        qword ptr [r11 + 0x18], rbp
00bfc205 mov        rbp, rcx
00bfc208 mov        qword ptr [r11 - 0x18], rdi
00bfc20c mov        rdi, qword ptr [rcx + 0x28]
00bfc210 mov        qword ptr [r11 - 0x20], r12
00bfc214 mov        r12, r9
00bfc217 mov        qword ptr [r11 - 0x28], r13
00bfc21b mov        r13, rdx
00bfc21e mov        qword ptr [r11 - 0x38], r15
00bfc222 mov        r15d, r8d
00bfc225 mov        qword ptr [rsp + 0x20], rax
00bfc22a cmp        r8d, 0x10
00bfc22e jb         0x140bfc2e3
; range 0xbfc234..0xbfc2e3 (exclusive)
00bfc234 mov        qword ptr [r11 - 0x10], rsi
00bfc238 mov        qword ptr [r11 - 0x30], r14
00bfc23c nop        dword ptr [rax]
00bfc240 cmp        dword ptr [rbp + 0xc], 1
00bfc244 lea        rsi, [rbx + r13]
00bfc248 mov        r8, qword ptr [rbp + 0x20]
00bfc24c jne        0x140bfc287
00bfc24e mov        eax, dword ptr [rdi]
00bfc250 lea        rcx, [rsp + 0x28]
00bfc255 xor        eax, dword ptr [rsi]
00bfc257 mov        dword ptr [rsp + 0x28], eax
00bfc25b mov        eax, dword ptr [rsi + 4]
00bfc25e xor        eax, dword ptr [rdi + 4]
00bfc261 mov        dword ptr [rsp + 0x2c], eax
00bfc265 mov        eax, dword ptr [rsi + 8]
00bfc268 xor        eax, dword ptr [rdi + 8]
00bfc26b mov        dword ptr [rsp + 0x30], eax
00bfc26f mov        eax, dword ptr [rsi + 0xc]
00bfc272 xor        eax, dword ptr [rdi + 0xc]
00bfc275 lea        rdi, [rbx + r12]
00bfc279 mov        rdx, rdi
00bfc27c mov        dword ptr [rsp + 0x34], eax
00bfc280 call       0x140bfa2a0
00bfc285 jmp        0x140bfc2c5
00bfc287 lea        rdx, [rsp + 0x28]
00bfc28c mov        rcx, rsi
00bfc28f call       0x140bfb050
00bfc294 mov        eax, dword ptr [rsp + 0x28]
00bfc298 xor        eax, dword ptr [rdi]
00bfc29a mov        dword ptr [rbx + r12], eax
00bfc29e mov        eax, dword ptr [rsp + 0x2c]
00bfc2a2 xor        eax, dword ptr [rdi + 4]
00bfc2a5 mov        dword ptr [rbx + r12 + 4], eax
00bfc2aa mov        eax, dword ptr [rsp + 0x30]
00bfc2ae xor        eax, dword ptr [rdi + 8]
00bfc2b1 mov        dword ptr [rbx + r12 + 8], eax
00bfc2b6 mov        eax, dword ptr [rsp + 0x34]
00bfc2ba xor        eax, dword ptr [rdi + 0xc]
00bfc2bd mov        rdi, rsi
00bfc2c0 mov        dword ptr [rbx + r12 + 0xc], eax
00bfc2c5 add        ebx, 0x10
00bfc2c8 lea        eax, [rbx + 0x10]
00bfc2cb cmp        eax, r15d
00bfc2ce jbe        0x140bfc240
00bfc2d4 mov        r14, qword ptr [rsp + 0x48]
00bfc2d9 mov        rsi, qword ptr [rsp + 0x68]
00bfc2de mov        rax, qword ptr [rsp + 0x20]
; range 0xbfc2e3..0xbfc304 (exclusive)
00bfc2e3 mov        r15, qword ptr [rsp + 0x40]
00bfc2e8 mov        r13, qword ptr [rsp + 0x50]
00bfc2ed mov        r12, qword ptr [rsp + 0x58]
00bfc2f2 mov        rdi, qword ptr [rsp + 0x60]
00bfc2f7 mov        rbp, qword ptr [rsp + 0x90]
00bfc2ff test       rax, rax
00bfc302 je         0x140bfc306
; range 0xbfc304..0xbfc31b (exclusive)
00bfc304 mov        dword ptr [rax], ebx
00bfc306 xor        eax, eax
00bfc308 mov        rcx, qword ptr [rsp + 0x38]
00bfc30d xor        rcx, rsp
00bfc310 call       0x14179b8e0
00bfc315 add        rsp, 0x70
00bfc319 pop        rbx
00bfc31a ret        
