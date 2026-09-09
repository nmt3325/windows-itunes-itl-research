; Original iTunes.exe machine code; base=0x140000000; RVA=0x106b140; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x106b140..0x106b1a9 (exclusive)
0106b140 mov        qword ptr [rsp + 0x18], rbx
0106b145 mov        qword ptr [rsp + 0x20], rbp
0106b14a push       rsi
0106b14b push       r12
0106b14d push       r15
0106b14f sub        rsp, 0x30
0106b153 mov        rbx, qword ptr [r9]
0106b156 xor        esi, esi
0106b158 mov        r15, r9
0106b15b mov        r12, rcx
0106b15e lea        rbp, [rbx + 0x18]
0106b162 test       rbx, rbx
0106b165 je         0x14106b16e
0106b167 mov        dword ptr [rbx + 8], esi
0106b16a mov        qword ptr [rbx + 0x10], rsi
0106b16e mov        qword ptr [rsp + 0x50], rdi
0106b173 mov        dword ptr [rbx], 0x686f686d
0106b179 mov        dword ptr [rbx + 4], 0x18
0106b180 mov        dword ptr [rbx + 0xc], r8d
0106b184 test       rdx, rdx
0106b187 je         0x14106b264
0106b18d mov        rcx, qword ptr [rip + 0x103aefc]
0106b194 call       qword ptr [rip + 0x87e226]
0106b19a mov        rdi, rax
0106b19d test       rax, rax
0106b1a0 je         0x14106b264
0106b1a6 mov        rcx, rax
; range 0x106b1a9..0x106b234 (exclusive)
0106b1a9 mov        qword ptr [rsp + 0x58], r14
0106b1ae call       qword ptr [rip + 0x87ddbc]
0106b1b4 mov        rcx, rdi
0106b1b7 mov        r14, rax
0106b1ba call       qword ptr [rip + 0x87ddb0]
0106b1c0 mov        rdx, rax
0106b1c3 test       r14, r14
0106b1c6 jne        0x14106b1cd
0106b1c8 mov        rcx, r14
0106b1cb jmp        0x14106b200
0106b1cd test       r14, r14
0106b1d0 mov        rax, rsi
0106b1d3 mov        rcx, rsi
0106b1d6 cmovns     rax, r14
0106b1da test       rdx, rdx
0106b1dd cmovg      rcx, rax
0106b1e1 lea        rax, [rdx - 1]
0106b1e5 cmovg      rax, rsi
0106b1e9 mov        rsi, rax
0106b1ec add        rax, rcx
0106b1ef cmp        rax, rdx
0106b1f2 jle        0x14106b200
0106b1f4 test       rdx, rdx
0106b1f7 mov        ecx, 1
0106b1fc cmovg      rcx, rdx
0106b200 mov        qword ptr [rsp + 0x28], rcx
0106b205 lea        rdx, [rsp + 0x20]
0106b20a mov        rcx, rdi
0106b20d mov        qword ptr [rsp + 0x20], rsi
0106b212 mov        r8, rbp
0106b215 call       qword ptr [rip + 0x87e03d]
0106b21b lea        rcx, [r14 + rbp]
0106b21f mov        r14, qword ptr [rsp + 0x58]
0106b224 mov        qword ptr [r15], rcx
0106b227 sub        ecx, ebx
0106b229 mov        dword ptr [rbx + 8], ecx
0106b22c cmp        byte ptr [r12 + 0x52], 0
0106b232 jne        0x14106b257
; range 0x106b234..0x106b282 (exclusive)
0106b234 mov        eax, dword ptr [rbx]
0106b236 bswap      eax
0106b238 mov        dword ptr [rbx], eax
0106b23a mov        eax, dword ptr [rbx + 4]
0106b23d bswap      eax
0106b23f mov        dword ptr [rbx + 4], eax
0106b242 bswap      ecx
0106b244 mov        dword ptr [rbx + 8], ecx
0106b247 mov        eax, dword ptr [rbx + 0xc]
0106b24a bswap      eax
0106b24c mov        dword ptr [rbx + 0xc], eax
0106b24f mov        eax, dword ptr [rbx + 0x10]
0106b252 bswap      eax
0106b254 mov        dword ptr [rbx + 0x10], eax
0106b257 mov        rcx, rdi
0106b25a call       qword ptr [rip + 0x87dbc0]
0106b260 xor        eax, eax
0106b262 jmp        0x14106b269
0106b264 mov        eax, 0xffffffce
0106b269 mov        rdi, qword ptr [rsp + 0x50]
0106b26e mov        rbx, qword ptr [rsp + 0x60]
0106b273 mov        rbp, qword ptr [rsp + 0x68]
0106b278 add        rsp, 0x30
0106b27c pop        r15
0106b27e pop        r12
0106b280 pop        rsi
0106b281 ret        
