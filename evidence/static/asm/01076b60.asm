; Original iTunes.exe machine code; base=0x140000000; RVA=0x1076b60; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1076b60..0x1076bb5 (exclusive)
01076b60 mov        r11, rsp
01076b63 push       rbp
01076b64 push       rbx
01076b65 push       rdi
01076b66 push       r13
01076b68 push       r14
01076b6a push       r15
01076b6c lea        rbp, [r11 - 0x478]
01076b73 sub        rsp, 0x548
01076b7a mov        rax, qword ptr [rip + 0xf5e4bf]
01076b81 xor        rax, rsp
01076b84 mov        qword ptr [rbp + 0x430], rax
01076b8b mov        r15, qword ptr [rbp + 0x4a0]
01076b92 mov        r14, r9
01076b95 mov        rbx, qword ptr [rbp + 0x4a8]
01076b9c movzx      r13d, r8b
01076ba0 mov        rdi, rdx
01076ba3 test       rdx, rdx
01076ba6 je         0x14107707a
01076bac test       rcx, rcx
01076baf je         0x14107707a
; range 0x1076bb5..0x107707a (exclusive)
01076bb5 mov        qword ptr [r11 + 8], rsi
01076bb9 lea        rcx, [rbp - 0x80]
01076bbd xor        edx, edx
01076bbf mov        qword ptr [r11 - 0x38], r12
01076bc3 mov        r8d, 0x2a0
01076bc9 call       0x14179cca0
01076bce mov        r8, qword ptr [rip + 0x103035b]
01076bd5 lea        rcx, [rbp - 0x40]
01076bd9 movzx      r12d, byte ptr [rbp + 0x4b0]
01076be1 mov        esi, 4
01076be6 mov        qword ptr [rbp - 0x50], rdi
01076bea mov        edx, esi
01076bec mov        qword ptr [rbp - 0x68], r14
01076bf0 lea        rax, [r8 + 0x150e0]
01076bf7 mov        qword ptr [rbp - 0x60], r15
01076bfb mov        qword ptr [rbp - 0x58], rbx
01076bff mov        byte ptr [rbp - 0x48], 0
01076c03 mov        byte ptr [rbp - 0x47], r12b
01076c07 nop        word ptr [rax + rax]
01076c10 lea        rcx, [rcx + 0x80]
01076c17 movups     xmm0, xmmword ptr [rax]
01076c1a lea        rax, [rax + 0x80]
01076c21 movups     xmmword ptr [rcx - 0x80], xmm0
01076c25 movups     xmm1, xmmword ptr [rax - 0x70]
01076c29 movups     xmmword ptr [rcx - 0x70], xmm1
01076c2d movups     xmm0, xmmword ptr [rax - 0x60]
01076c31 movups     xmmword ptr [rcx - 0x60], xmm0
01076c35 movups     xmm1, xmmword ptr [rax - 0x50]
01076c39 movups     xmmword ptr [rcx - 0x50], xmm1
01076c3d movups     xmm0, xmmword ptr [rax - 0x40]
01076c41 movups     xmmword ptr [rcx - 0x40], xmm0
01076c45 movups     xmm1, xmmword ptr [rax - 0x30]
01076c49 movups     xmmword ptr [rcx - 0x30], xmm1
01076c4d movups     xmm0, xmmword ptr [rax - 0x20]
01076c51 movups     xmmword ptr [rcx - 0x20], xmm0
01076c55 movups     xmm1, xmmword ptr [rax - 0x10]
01076c59 movups     xmmword ptr [rcx - 0x10], xmm1
01076c5d sub        rdx, 1
01076c61 jne        0x141076c10
01076c63 movups     xmm0, xmmword ptr [rax]
01076c66 movups     xmmword ptr [rcx], xmm0
01076c69 movups     xmm1, xmmword ptr [rax + 0x10]
01076c6d movups     xmm0, xmmword ptr [rip + 0xaece7c]
01076c74 movups     xmmword ptr [rcx + 0x10], xmm1
01076c78 cmp        byte ptr [r8 + 0x15300], dl
01076c7f lea        rcx, [rbp + 0x1e8]
01076c86 mov        edx, 1
01076c8b setne      byte ptr [rbp + 0x1e0]
01076c92 movups     xmmword ptr [rbp + 0x220], xmm0
01076c99 call       0x140bfbe20
01076c9e mov        ebx, eax
01076ca0 test       eax, eax
01076ca2 jne        0x141077066
01076ca8 lea        rax, [rbp + 0x220]
01076caf mov        byte ptr [rbp + 0x200], 0x10
01076cb6 lea        rcx, [rbp + 0x1e8]
01076cbd mov        qword ptr [rbp + 0x1f8], rax
01076cc4 mov        dword ptr [rbp + 0x1f0], 1
01076cce mov        qword ptr [rbp + 0x210], 0
01076cd9 call       0x140bfbf10
01076cde mov        ebx, eax
01076ce0 test       eax, eax
01076ce2 je         0x141076cfa
01076ce4 xor        r8d, r8d
01076ce7 lea        rcx, [rbp + 0x1e8]
01076cee xor        edx, edx
01076cf0 call       0x140bfc0d0
01076cf5 jmp        0x141077066
01076cfa lea        rax, [rbp - 0x7c]
01076cfe test       al, 1
01076d00 je         0x141076d0c
01076d02 mov        ebx, 0xffffffce
01076d07 jmp        0x141077066
01076d0c mov        rax, qword ptr [rip + 0x1036f45]
01076d13 xorps      xmm0, xmm0
01076d16 movups     xmmword ptr [rbp - 0x7c], xmm0
01076d1a test       rax, rax
01076d1d je         0x141077061
01076d23 mov        eax, dword ptr [rax + 0x18]
01076d26 mov        dword ptr [rbp - 0x70], eax
01076d29 test       eax, eax
01076d2b je         0x141077061
01076d31 xor        ecx, ecx
01076d33 mov        qword ptr [rbp - 0x7c], 0x63636d70
01076d3b cmp        byte ptr [rbp + 0x4b8], cl
01076d41 je         0x141076d4e
01076d43 lea        rcx, [rbp - 0x80]
01076d47 call       0x141076780
01076d4c jmp        0x141076d7a
01076d4e mov        qword ptr [rsp + 0x78], rcx
01076d53 lea        r8, [rbp - 0x80]
01076d57 mov        qword ptr [rsp + 0x28], rcx
01076d5c lea        rdx, [rip - 0x5e3]
01076d63 lea        rcx, [rsp + 0x40]
01076d68 xor        r9d, r9d
01076d6b call       0x140bcff50
01076d70 mov        ebx, eax
01076d72 test       eax, eax
01076d74 jne        0x141077026
01076d7a cmp        dword ptr [rbp - 0x7c], 0x63636d70
01076d81 jne        0x141077021
01076d87 movabs     r12, 0xbff0000000000000
01076d91 mov        edx, dword ptr [rbp - 0x74]
01076d94 test       dl, 1
01076d97 jne        0x141076df9
01076d99 nop        dword ptr [rax]
01076da0 mov        ecx, edx
01076da2 mov        eax, edx
01076da4 or         ecx, 2
01076da7 lock cmpxchg dword ptr [rbp - 0x74], ecx
01076dac je         0x141076db6
01076dae mov        edx, dword ptr [rbp - 0x74]
01076db1 test       dl, 1
01076db4 je         0x141076da0
01076db6 test       dl, 1
01076db9 jne        0x141076df9
01076dbb mov        rax, qword ptr [rip + 0x1036e96]
01076dc2 xorps      xmm0, xmm0
01076dc5 mov        qword ptr [rax + 0x48], r12
01076dc9 call       0x140b076d0
01076dce mov        eax, dword ptr [rbp - 0x74]
01076dd1 test       al, 1
01076dd3 jne        0x141076df9
01076dd5 nop        word ptr [rax + rax]
01076de0 mov        eax, dword ptr [rbp - 0x74]
01076de3 mov        ecx, eax
01076de5 and        ecx, 0xfffffffd
01076de8 lock cmpxchg dword ptr [rbp - 0x74], ecx
01076ded jne        0x141076de0
01076def xorps      xmm0, xmm0
01076df2 call       0x140b07800
01076df7 jmp        0x141076d91
01076df9 mov        rax, qword ptr [rip + 0x1030130]
01076e00 lea        rcx, [rbp - 0x40]
01076e04 movzx      r12d, byte ptr [rbp + 0x4b0]
01076e0c add        rax, 0x150e0
01076e12 lea        rax, [rax + 0x80]
01076e19 movups     xmm0, xmmword ptr [rcx]
01076e1c lea        rcx, [rcx + 0x80]
01076e23 movups     xmmword ptr [rax - 0x80], xmm0
01076e27 movups     xmm1, xmmword ptr [rcx - 0x70]
01076e2b movups     xmmword ptr [rax - 0x70], xmm1
01076e2f movups     xmm0, xmmword ptr [rcx - 0x60]
01076e33 movups     xmmword ptr [rax - 0x60], xmm0
01076e37 movups     xmm1, xmmword ptr [rcx - 0x50]
01076e3b movups     xmmword ptr [rax - 0x50], xmm1
01076e3f movups     xmm0, xmmword ptr [rcx - 0x40]
01076e43 movups     xmmword ptr [rax - 0x40], xmm0
01076e47 movups     xmm1, xmmword ptr [rcx - 0x30]
01076e4b movups     xmmword ptr [rax - 0x30], xmm1
01076e4f movups     xmm0, xmmword ptr [rcx - 0x20]
01076e53 movups     xmmword ptr [rax - 0x20], xmm0
01076e57 movups     xmm1, xmmword ptr [rcx - 0x10]
01076e5b movups     xmmword ptr [rax - 0x10], xmm1
01076e5f sub        rsi, 1
01076e63 jne        0x141076e12
01076e65 movups     xmm0, xmmword ptr [rcx]
01076e68 xor        r8d, r8d
01076e6b xor        edx, edx
01076e6d movups     xmmword ptr [rax], xmm0
01076e70 movups     xmm1, xmmword ptr [rcx + 0x10]
01076e74 movups     xmmword ptr [rax + 0x10], xmm1
01076e78 movzx      ecx, byte ptr [rbp + 0x1e0]
01076e7f mov        rax, qword ptr [rip + 0x10300aa]
01076e86 mov        byte ptr [rax + 0x15300], cl
01076e8c lea        rcx, [rbp + 0x1e8]
01076e93 call       0x140bfc0d0
01076e98 mov        ebx, dword ptr [rbp - 0x80]
01076e9b test       r13b, r13b
01076e9e je         0x141076ffd
01076ea4 lea        r8, [rbp + 0x230]
01076eab mov        byte ptr [rbp - 0x48], 1
01076eaf lea        rdx, [rbp + 0x220]
01076eb6 mov        qword ptr [rbp - 0x50], rdi
01076eba mov        rcx, rdi
01076ebd mov        qword ptr [rbp + 0x220], 0x90
01076ec8 call       0x140ba0350
01076ecd test       eax, eax
01076ecf jne        0x141076f2e
01076ed1 lea        rcx, [rbp + 0x230]
01076ed8 call       0x141068f90
01076edd xor        edx, edx
01076edf mov        byte ptr [rbp + 0x271], sil
01076ee6 mov        rcx, rdi
01076ee9 call       0x140ba09a0
01076eee test       eax, eax
01076ef0 jne        0x141076f2e
01076ef2 lea        rcx, [rbp + 0x230]
01076ef9 call       0x141068f90
01076efe lea        r8, [rbp + 0x230]
01076f05 mov        rcx, rdi
01076f08 lea        rdx, [rbp + 0x220]
01076f0f call       0x140ba04c0
01076f14 test       eax, eax
01076f16 jne        0x141076f2e
01076f18 mov        rcx, rdi
01076f1b call       0x140ba0000
01076f20 test       eax, eax
01076f22 jne        0x141076f2e
01076f24 xor        edx, edx
01076f26 mov        rcx, rdi
01076f29 call       0x140ba09a0
01076f2e cmp        dword ptr [rbp - 0x7c], 0x63636d70
01076f35 jne        0x141077021
01076f3b xor        edi, edi
01076f3d nop        dword ptr [rax]
01076f40 mov        eax, dword ptr [rbp - 0x74]
01076f43 lock cmpxchg dword ptr [rbp - 0x74], edi
01076f48 mov        ecx, dword ptr [rbp - 0x74]
01076f4b cmp        eax, ecx
01076f4d jne        0x141076f40
01076f4f xor        r9d, r9d
01076f52 mov        qword ptr [rsp + 0x78], rdi
01076f57 lea        r8, [rbp - 0x80]
01076f5b mov        qword ptr [rsp + 0x28], rdi
01076f60 lea        rdx, [rip - 0x7e7]
01076f67 lea        rcx, [rsp + 0x40]
01076f6c call       0x140bcff50
01076f71 mov        ebx, eax
01076f73 test       eax, eax
01076f75 jne        0x141077026
01076f7b cmp        dword ptr [rbp - 0x7c], 0x63636d70
01076f82 jne        0x141077021
01076f88 movabs     rbx, 0xbff0000000000000
01076f92 mov        edx, dword ptr [rbp - 0x74]
01076f95 test       dl, 1
01076f98 jne        0x141076ff9
01076f9a nop        word ptr [rax + rax]
01076fa0 mov        ecx, edx
01076fa2 mov        eax, edx
01076fa4 or         ecx, 2
01076fa7 lock cmpxchg dword ptr [rbp - 0x74], ecx
01076fac je         0x141076fb6
01076fae mov        edx, dword ptr [rbp - 0x74]
01076fb1 test       dl, 1
01076fb4 je         0x141076fa0
01076fb6 test       dl, 1
01076fb9 jne        0x141076ff9
01076fbb mov        rax, qword ptr [rip + 0x1036c96]
01076fc2 xorps      xmm0, xmm0
01076fc5 mov        qword ptr [rax + 0x48], rbx
01076fc9 call       0x140b076d0
01076fce mov        eax, dword ptr [rbp - 0x74]
01076fd1 test       al, 1
01076fd3 jne        0x141076ff9
01076fd5 nop        word ptr [rax + rax]
01076fe0 mov        eax, dword ptr [rbp - 0x74]
01076fe3 mov        ecx, eax
01076fe5 and        ecx, 0xfffffffd
01076fe8 lock cmpxchg dword ptr [rbp - 0x74], ecx
01076fed jne        0x141076fe0
01076fef xorps      xmm0, xmm0
01076ff2 call       0x140b07800
01076ff7 jmp        0x141076f92
01076ff9 mov        ebx, edi
01076ffb jmp        0x141077026
01076ffd lea        r8, [rbp + 0x230]
01077004 movzx      edx, r12b
01077008 mov        rcx, r15
0107700b call       0x141075f60
01077010 lea        rdx, [rbp + 0x230]
01077017 mov        rcx, r14
0107701a call       0x140b23650
0107701f jmp        0x141077026
01077021 mov        ebx, 0xffffffce
01077026 cmp        dword ptr [rbp - 0x7c], 0x63636d70
0107702d jne        0x141077066
0107702f mov        eax, dword ptr [rbp - 0x74]
01077032 test       al, 1
01077034 jne        0x141077066
01077036 mov        ecx, dword ptr [rbp - 0x70]
01077039 nop        dword ptr [rax]
01077040 mov        r8d, dword ptr [rbp - 0x74]
01077044 mov        edx, r8d
01077047 or         edx, 1
0107704a mov        eax, r8d
0107704d lock cmpxchg dword ptr [rbp - 0x74], edx
01077052 jne        0x141077040
01077054 test       r8b, 2
01077058 je         0x141077066
0107705a call       0x140b07d90
0107705f jmp        0x141077066
01077061 mov        ebx, 0xfffffd96
01077066 mov        r12, qword ptr [rsp + 0x540]
0107706e mov        eax, ebx
01077070 mov        rsi, qword ptr [rsp + 0x580]
01077078 jmp        0x14107707f
; range 0x107707a..0x107709f (exclusive)
0107707a mov        eax, 0xffffffce
0107707f mov        rcx, qword ptr [rbp + 0x430]
01077086 xor        rcx, rsp
01077089 call       0x14179b8e0
0107708e add        rsp, 0x548
01077095 pop        r15
01077097 pop        r14
01077099 pop        r13
0107709b pop        rdi
0107709c pop        rbx
0107709d pop        rbp
0107709e ret        
