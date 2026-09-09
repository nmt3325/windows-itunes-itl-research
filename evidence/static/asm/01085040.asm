; Original iTunes.exe machine code; base=0x140000000; RVA=0x1085040; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1085040..0x108513c (exclusive)
01085040 push       rbx
01085042 push       rsi
01085043 push       rdi
01085044 sub        rsp, 0xa0
0108504b mov        rax, qword ptr [rip + 0xf4ffee]
01085052 xor        rax, rsp
01085055 mov        qword ptr [rsp + 0x90], rax
0108505d mov        qword ptr [rsp + 0x30], 0
01085066 mov        rsi, rdx
01085069 mov        rdi, rcx
0108506c test       rcx, rcx
0108506f je         0x14108524f
01085075 cmp        qword ptr [rcx + 0x10], 0
0108507a je         0x14108524f
01085080 mov        eax, dword ptr [rcx]
01085082 cmp        eax, 0x41464350
01085087 je         0x141085094
01085089 cmp        eax, 0x57696e50
0108508e jne        0x14108524f
01085094 test       rsi, rsi
01085097 je         0x14108524f
0108509d xorps      xmm0, xmm0
010850a0 movups     xmmword ptr [rdx], xmm0
010850a3 movups     xmmword ptr [rdx + 0x10], xmm0
010850a7 movups     xmmword ptr [rdx + 0x20], xmm0
010850ab movups     xmmword ptr [rdx + 0x30], xmm0
010850af movups     xmmword ptr [rdx + 0x40], xmm0
010850b3 movups     xmmword ptr [rdx + 0x50], xmm0
010850b7 movups     xmmword ptr [rdx + 0x60], xmm0
010850bb movups     xmmword ptr [rdx + 0x70], xmm0
010850bf movups     xmmword ptr [rdx + 0x80], xmm0
010850c6 mov        rcx, qword ptr [rcx + 0x10]
010850ca test       rcx, rcx
010850cd je         0x141085246
010850d3 mov        eax, dword ptr [rdi]
010850d5 cmp        eax, 0x41464350
010850da je         0x1410850e7
010850dc cmp        eax, 0x57696e50
010850e1 jne        0x141085246
010850e7 mov        rax, qword ptr [rcx + 8]
010850eb lea        rdx, [rsp + 0x40]
010850f0 mov        rcx, rdi
010850f3 xor        r8d, r8d
010850f6 call       rax
010850f8 mov        ebx, eax
010850fa test       eax, eax
010850fc jne        0x14108524b
01085102 cmp        byte ptr [rsp + 0x40], al
01085106 je         0x141085114
01085108 mov        ebx, 0xfffffaea
0108510d mov        eax, ebx
0108510f jmp        0x141085254
01085114 lea        r9, [rsp + 0x30]
01085119 mov        edx, 0x64617461
0108511e mov        r8d, 1
01085124 mov        rcx, rdi
01085127 call       0x140b19490
0108512c test       eax, eax
0108512e je         0x141085137
01085130 xor        eax, eax
01085132 jmp        0x141085254
01085137 mov        rdi, qword ptr [rsp + 0x30]
; range 0x108513c..0x1085218 (exclusive)
0108513c mov        qword ptr [rsp + 0xd0], rbp
01085144 test       rdi, rdi
01085147 je         0x141085206
0108514d cmp        dword ptr [rdi + 0x20], 0x66726566
01085154 jne        0x141085206
0108515a mov        rax, qword ptr [rdi + 0x268]
01085161 test       rax, rax
01085164 je         0x141085206
0108516a lea        rdx, [rsp + 0x38]
0108516f mov        rcx, rdi
01085172 call       rax
01085174 mov        ebx, eax
01085176 test       eax, eax
01085178 jne        0x14108520b
0108517e cmp        dword ptr [rdi + 0x20], 0x66726566
01085185 jne        0x141085206
01085187 mov        rax, qword ptr [rdi + 0x298]
0108518e test       rax, rax
01085191 je         0x141085206
01085193 mov        ebp, 0x90
01085198 mov        qword ptr [rsp + 0x20], 0
010851a1 mov        r8d, ebp
010851a4 xor        r9d, r9d
010851a7 mov        rdx, rsi
010851aa mov        rcx, rdi
010851ad call       rax
010851af mov        ebx, eax
010851b1 test       eax, eax
010851b3 jne        0x14108520b
010851b5 mov        rcx, rsi
010851b8 call       0x141068f90
010851bd mov        r9d, dword ptr [rsi]
010851c0 cmp        r9d, 0x6864666d
010851c7 je         0x1410851d9
010851c9 cmp        r9d, 0x6864676d
010851d0 je         0x1410851d9
010851d2 mov        ebx, 0xffffff30
010851d7 jmp        0x14108520b
010851d9 mov        eax, dword ptr [rsi + 8]
010851dc cmp        qword ptr [rsp + 0x38], rax
010851e1 je         0x1410851ea
010851e3 mov        ebx, 0xffffff30
010851e8 jmp        0x14108520b
010851ea mov        edx, dword ptr [rsi + 4]
010851ed cmp        edx, ebp
010851ef jae        0x14108520b
010851f1 mov        ecx, edx
010851f3 add        rcx, rsi
010851f6 je         0x14108520b
010851f8 sub        ebp, edx
010851fa xor        edx, edx
010851fc mov        r8d, ebp
010851ff call       0x14179cca0
01085204 jmp        0x14108520b
01085206 mov        ebx, 0xffffffce
0108520b mov        rbp, qword ptr [rsp + 0xd0]
01085213 test       rdi, rdi
01085216 je         0x14108524b
; range 0x1085218..0x108526f (exclusive)
01085218 cmp        dword ptr [rdi + 0x20], 0x66726566
0108521f jne        0x14108524b
01085221 mov        rax, qword ptr [rdi + 0x260]
01085228 test       rax, rax
0108522b je         0x14108524b
0108522d mov        rcx, rdi
01085230 call       rax
01085232 mov        rcx, rdi
01085235 mov        dword ptr [rdi + 0x20], 0
0108523c call       qword ptr [rip + 0x867126]
01085242 mov        eax, ebx
01085244 jmp        0x141085254
01085246 mov        ebx, 0xffffffce
0108524b mov        eax, ebx
0108524d jmp        0x141085254
0108524f mov        eax, 0xffffffce
01085254 mov        rcx, qword ptr [rsp + 0x90]
0108525c xor        rcx, rsp
0108525f call       0x14179b8e0
01085264 add        rsp, 0xa0
0108526b pop        rdi
0108526c pop        rsi
0108526d pop        rbx
0108526e ret        
