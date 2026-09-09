; Original iTunes.exe machine code; base=0x140000000; RVA=0xbfc0d0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0xbfc0d0..0xbfc0f8 (exclusive)
00bfc0d0 mov        qword ptr [rsp + 0x20], rbx
00bfc0d5 push       rdi
00bfc0d6 sub        rsp, 0x20
00bfc0da mov        rdi, r8
00bfc0dd mov        r9, rdx
00bfc0e0 mov        rbx, rcx
00bfc0e3 test       rcx, rcx
00bfc0e6 je         0x140bfc1c9
00bfc0ec cmp        byte ptr [rcx], 0
00bfc0ef je         0x140bfc1c9
00bfc0f5 mov        ecx, dword ptr [rcx + 4]
; range 0xbfc0f8..0xbfc1c9 (exclusive)
00bfc0f8 mov        qword ptr [rsp + 0x38], rbp
00bfc0fd xor        ebp, ebp
00bfc0ff mov        qword ptr [rsp + 0x40], rsi
00bfc104 mov        esi, ebp
00bfc106 sub        ecx, 1
00bfc109 je         0x140bfc195
00bfc10f cmp        ecx, 1
00bfc112 jne        0x140bfc1ab
00bfc118 test       r8, r8
00bfc11b je         0x140bfc17a
00bfc11d test       rdx, rdx
00bfc120 je         0x140bfc177
00bfc122 mov        ecx, dword ptr [rbx + 0xc]
00bfc125 mov        edx, ebp
00bfc127 mov        eax, dword ptr [r8]
00bfc12a mov        dword ptr [rsp + 0x30], eax
00bfc12e sub        ecx, 1
00bfc131 je         0x140bfc14e
00bfc133 cmp        ecx, 1
00bfc136 jne        0x140bfc164
00bfc138 mov        rcx, qword ptr [rbx + 0x20]
00bfc13c lea        r8, [rsp + 0x30]
00bfc141 mov        rdx, r9
00bfc144 mov        rcx, qword ptr [rcx]
00bfc147 call       0x1417e91b0
00bfc14c jmp        0x140bfc162
00bfc14e mov        rcx, qword ptr [rbx + 0x20]
00bfc152 lea        r8, [rsp + 0x30]
00bfc157 mov        rdx, r9
00bfc15a mov        rcx, qword ptr [rcx]
00bfc15d call       0x1417e9510
00bfc162 mov        edx, eax
00bfc164 mov        eax, dword ptr [rsp + 0x30]
00bfc168 cmp        edx, 1
00bfc16b mov        esi, 0x20a7
00bfc170 mov        dword ptr [rdi], eax
00bfc172 cmove      esi, ebp
00bfc175 jmp        0x140bfc17a
00bfc177 mov        dword ptr [r8], ebp
00bfc17a mov        rdi, qword ptr [rbx + 0x20]
00bfc17e test       rdi, rdi
00bfc181 je         0x140bfc1ab
00bfc183 mov        rcx, qword ptr [rdi]
00bfc186 call       0x1417e8b80
00bfc18b mov        edx, 8
00bfc190 mov        rcx, rdi
00bfc193 jmp        0x140bfc1a6
00bfc195 test       rdi, rdi
00bfc198 je         0x140bfc19d
00bfc19a mov        dword ptr [r8], ebp
00bfc19d mov        rcx, qword ptr [rbx + 0x20]
00bfc1a1 mov        edx, 0x204
00bfc1a6 call       0x140bc6a20
00bfc1ab mov        qword ptr [rbx + 0x20], rbp
00bfc1af mov        eax, esi
00bfc1b1 mov        rsi, qword ptr [rsp + 0x40]
00bfc1b6 mov        byte ptr [rbx], bpl
00bfc1b9 mov        rbp, qword ptr [rsp + 0x38]
00bfc1be mov        rbx, qword ptr [rsp + 0x48]
00bfc1c3 add        rsp, 0x20
00bfc1c7 pop        rdi
00bfc1c8 ret        
; range 0xbfc1c9..0xbfc1d9 (exclusive)
00bfc1c9 mov        rbx, qword ptr [rsp + 0x48]
00bfc1ce mov        eax, 0x206f
00bfc1d3 add        rsp, 0x20
00bfc1d7 pop        rdi
00bfc1d8 ret        
