; Original iTunes.exe machine code; base=0x140000000; RVA=0x106b030; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x106b030..0x106b05c (exclusive)
0106b030 mov        qword ptr [rsp + 0x10], rbp
0106b035 mov        qword ptr [rsp + 0x18], rsi
0106b03a push       rdi
0106b03b sub        rsp, 0x40
0106b03f mov        rdi, qword ptr [rsp + 0x80]
0106b047 xor        r10d, r10d
0106b04a mov        esi, r9d
0106b04d mov        rbp, rcx
0106b050 mov        byte ptr [rdi], r10b
0106b053 test       r8d, r8d
0106b056 je         0x14106b127
; range 0x106b05c..0x106b11b (exclusive)
0106b05c mov        qword ptr [rsp + 0x50], rbx
0106b061 mov        ebx, r10d
0106b064 mov        r11d, r10d
0106b067 test       rdx, rdx
0106b06a je         0x14106b120
0106b070 cmp        dword ptr [rdx], 0x73747263
0106b076 jne        0x14106b120
0106b07c cmp        dword ptr [rdx + 0x3c], ebx
0106b07f je         0x14106b120
0106b085 test       r8d, r8d
0106b088 jle        0x14106b120
0106b08e cmp        r8d, dword ptr [rdx + 0x2c]
0106b092 jg         0x14106b120
0106b098 mov        rax, qword ptr [rdx + 0x10]
0106b09c movsxd     r9, r8d
0106b09f dec        r9
0106b0a2 mov        rax, qword ptr [rax]
0106b0a5 lea        r9, [rax + r9*8]
0106b0a9 test       r9, r9
0106b0ac je         0x14106b0cd
0106b0ae movsxd     rcx, dword ptr [r9]
0106b0b1 test       ecx, ecx
0106b0b3 js         0x14106b0cd
0106b0b5 mov        r9d, dword ptr [r9 + 4]
0106b0b9 test       r9d, r9d
0106b0bc jle        0x14106b0cd
0106b0be mov        rax, qword ptr [rdx + 0x20]
0106b0c2 mov        r11, rcx
0106b0c5 mov        ebx, r9d
0106b0c8 add        r11, qword ptr [rax]
0106b0cb jmp        0x14106b0d3
0106b0cd mov        r10d, 0xffffffce
0106b0d3 test       r10d, r10d
0106b0d6 jne        0x14106b11b
0106b0d8 test       ebx, ebx
0106b0da je         0x14106b11b
0106b0dc mov        rax, qword ptr [rsp + 0x78]
0106b0e1 mov        r9d, r8d
0106b0e4 mov        qword ptr [rsp + 0x30], rax
0106b0e9 mov        r8d, ebx
0106b0ec mov        eax, dword ptr [rsp + 0x70]
0106b0f0 mov        rdx, r11
0106b0f3 mov        dword ptr [rsp + 0x28], eax
0106b0f7 mov        rcx, rbp
0106b0fa mov        dword ptr [rsp + 0x20], esi
0106b0fe call       0x14106ac80
0106b103 mov        byte ptr [rdi], 1
0106b106 mov        rbx, qword ptr [rsp + 0x50]
0106b10b mov        rbp, qword ptr [rsp + 0x58]
0106b110 mov        rsi, qword ptr [rsp + 0x60]
0106b115 add        rsp, 0x40
0106b119 pop        rdi
0106b11a ret        
; range 0x106b11b..0x106b127 (exclusive)
0106b11b mov        eax, r10d
0106b11e jmp        0x14106b106
0106b120 mov        eax, 0xffffffce
0106b125 jmp        0x14106b106
; range 0x106b127..0x106b13a (exclusive)
0106b127 mov        rbp, qword ptr [rsp + 0x58]
0106b12c mov        eax, r10d
0106b12f mov        rsi, qword ptr [rsp + 0x60]
0106b134 add        rsp, 0x40
0106b138 pop        rdi
0106b139 ret        
