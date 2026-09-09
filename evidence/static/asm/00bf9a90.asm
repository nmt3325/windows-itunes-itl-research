; Original iTunes.exe machine code; base=0x140000000; RVA=0xbf9a90; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0xbf9a90..0xbf9a9d (exclusive)
00bf9a90 mov        dword ptr [rsp + 0x18], r8d
00bf9a95 push       r12
00bf9a97 push       r13
00bf9a99 sub        rsp, 0x28
; range 0xbf9a9d..0xbfa1f0 (exclusive)
00bf9a9d mov        qword ptr [rsp + 0x40], rbx
00bf9aa2 mov        r12d, 4
00bf9aa8 mov        dword ptr [r9], r12d
00bf9aab mov        r13, r9
00bf9aae mov        qword ptr [rsp + 0x20], rbp
00bf9ab3 mov        qword ptr [rsp + 0x18], rsi
00bf9ab8 mov        qword ptr [rsp + 0x10], rdi
00bf9abd mov        qword ptr [rsp + 8], r14
00bf9ac2 mov        qword ptr [rsp], r15
00bf9ac6 xor        r15d, r15d
00bf9ac9 mov        qword ptr [r9 + 0x1c], r15
00bf9acd mov        qword ptr [r9 + 0x14], r15
00bf9ad1 mov        eax, dword ptr [rdx]
00bf9ad3 mov        dword ptr [r9 + 4], eax
00bf9ad7 mov        eax, dword ptr [rdx + 4]
00bf9ada mov        dword ptr [r9 + 8], eax
00bf9ade mov        eax, dword ptr [rdx + 8]
00bf9ae1 mov        dword ptr [r9 + 0xc], eax
00bf9ae5 mov        ebp, dword ptr [rdx + 0xc]
00bf9ae8 mov        dword ptr [r9 + 0x10], ebp
00bf9aec mov        eax, dword ptr [r9]
00bf9aef cmp        eax, r12d
00bf9af2 je         0x140bf9ef0
00bf9af8 cmp        eax, 6
00bf9afb je         0x140bf9c46
00bf9b01 cmp        eax, 8
00bf9b04 jne        0x140bfa18a
00bf9b0a mov        r11, qword ptr [rip + 0x14d91df]
00bf9b11 mov        r8d, r15d
00bf9b14 mov        r10, qword ptr [rip + 0x14d91ed]
00bf9b1b nop        dword ptr [rax + rax]
00bf9b20 ror        r8d, 8
00bf9b24 lea        r9d, [r15*8]
00bf9b2c mov        edx, r8d
00bf9b2f lea        r11, [r11 + 4]
00bf9b33 mov        eax, r8d
00bf9b36 mov        ecx, r8d
00bf9b39 shr        eax, 0x10
00bf9b3c inc        r15d
00bf9b3f movzx      eax, al
00bf9b42 shr        rcx, 0x18
00bf9b46 mov        r8d, dword ptr [r10 + rcx*4 + 0xc00]
00bf9b4e xor        r8d, dword ptr [r10 + rax*4 + 0x800]
00bf9b56 mov        eax, edx
00bf9b58 shr        eax, 8
00bf9b5b movzx      ecx, al
00bf9b5e movzx      eax, dl
00bf9b61 xor        r8d, dword ptr [r10 + rcx*4 + 0x400]
00bf9b69 xor        r8d, dword ptr [r10 + rax*4]
00bf9b6d lea        eax, [r9 + 8]
00bf9b71 xor        r8d, dword ptr [r13 + r9*4 + 4]
00bf9b76 xor        r8d, dword ptr [r11 - 4]
00bf9b7a mov        dword ptr [r13 + rax*4 + 4], r8d
00bf9b7f lea        eax, [r9 + 1]
00bf9b83 xor        r8d, dword ptr [r13 + rax*4 + 4]
00bf9b88 lea        eax, [r9 + 9]
00bf9b8c mov        dword ptr [r13 + rax*4 + 4], r8d
00bf9b91 lea        eax, [r9 + 2]
00bf9b95 xor        r8d, dword ptr [r13 + rax*4 + 4]
00bf9b9a lea        eax, [r9 + 0xa]
00bf9b9e mov        dword ptr [r13 + rax*4 + 4], r8d
00bf9ba3 lea        eax, [r9 + 3]
00bf9ba7 xor        r8d, dword ptr [r13 + rax*4 + 4]
00bf9bac lea        eax, [r9 + 0xb]
00bf9bb0 mov        edx, r8d
00bf9bb3 mov        dword ptr [r13 + rax*4 + 4], edx
00bf9bb8 mov        eax, r8d
00bf9bbb shr        eax, 0x10
00bf9bbe movzx      eax, al
00bf9bc1 mov        ecx, r8d
00bf9bc4 shr        rcx, 0x18
00bf9bc8 mov        r8d, dword ptr [r10 + rcx*4 + 0xc00]
00bf9bd0 xor        r8d, dword ptr [r10 + rax*4 + 0x800]
00bf9bd8 mov        eax, edx
00bf9bda shr        eax, 8
00bf9bdd movzx      ecx, al
00bf9be0 lea        eax, [r9 + 4]
00bf9be4 xor        r8d, dword ptr [r10 + rcx*4 + 0x400]
00bf9bec xor        r8d, dword ptr [r13 + rax*4 + 4]
00bf9bf1 movzx      eax, dl
00bf9bf4 xor        r8d, dword ptr [r10 + rax*4]
00bf9bf8 lea        eax, [r9 + 0xc]
00bf9bfc mov        dword ptr [r13 + rax*4 + 4], r8d
00bf9c01 lea        eax, [r9 + 5]
00bf9c05 xor        r8d, dword ptr [r13 + rax*4 + 4]
00bf9c0a lea        eax, [r9 + 0xd]
00bf9c0e mov        dword ptr [r13 + rax*4 + 4], r8d
00bf9c13 lea        eax, [r9 + 6]
00bf9c17 xor        r8d, dword ptr [r13 + rax*4 + 4]
00bf9c1c lea        eax, [r9 + 0xe]
00bf9c20 mov        dword ptr [r13 + rax*4 + 4], r8d
00bf9c25 lea        eax, [r9 + 7]
00bf9c29 xor        r8d, dword ptr [r13 + rax*4 + 4]
00bf9c2e lea        eax, [r9 + 0xf]
00bf9c32 mov        dword ptr [r13 + rax*4 + 4], r8d
00bf9c37 cmp        r15d, 7
00bf9c3b jb         0x140bf9b20
00bf9c41 jmp        0x140bfa18a
00bf9c46 mov        rsi, qword ptr [rip + 0x14d90a3]
00bf9c4d mov        ebx, r15d
00bf9c50 mov        r12, qword ptr [rip + 0x14d90b1]
00bf9c57 add        rsi, 8
00bf9c5b mov        qword ptr [rsp + 0x58], rsi
00bf9c60 ror        ebx, 8
00bf9c63 lea        eax, [r15 + r15*2]
00bf9c67 lea        r14d, [rax + rax]
00bf9c6b mov        ecx, ebx
00bf9c6d mov        eax, ebx
00bf9c6f shr        rcx, 0x18
00bf9c73 shr        eax, 0x10
00bf9c76 movzx      eax, al
00bf9c79 mov        edi, dword ptr [r12 + rcx*4 + 0xc00]
00bf9c81 xor        edi, dword ptr [r12 + rax*4 + 0x800]
00bf9c89 mov        eax, ebx
00bf9c8b shr        eax, 8
00bf9c8e movzx      ecx, al
00bf9c91 movzx      eax, bl
00bf9c94 xor        edi, dword ptr [r12 + rcx*4 + 0x400]
00bf9c9c xor        edi, dword ptr [r12 + rax*4]
00bf9ca0 lea        eax, [r14 + 6]
00bf9ca4 xor        edi, dword ptr [r13 + r14*4 + 4]
00bf9ca9 xor        edi, dword ptr [rsi - 8]
00bf9cac mov        dword ptr [r13 + rax*4 + 4], edi
00bf9cb1 mov        ebp, edi
00bf9cb3 lea        eax, [r14 + 1]
00bf9cb7 xor        ebp, dword ptr [r13 + rax*4 + 4]
00bf9cbc lea        eax, [r14 + 7]
00bf9cc0 mov        dword ptr [r13 + rax*4 + 4], ebp
00bf9cc5 mov        r11d, ebp
00bf9cc8 lea        eax, [r14 + 2]
00bf9ccc xor        r11d, dword ptr [r13 + rax*4 + 4]
00bf9cd1 lea        eax, [r14 + 8]
00bf9cd5 mov        dword ptr [r13 + rax*4 + 4], r11d
00bf9cda mov        r10d, r11d
00bf9cdd lea        eax, [r14 + 3]
00bf9ce1 xor        r10d, dword ptr [r13 + rax*4 + 4]
00bf9ce6 lea        eax, [r14 + 9]
00bf9cea mov        dword ptr [r13 + rax*4 + 4], r10d
00bf9cef mov        r9d, r10d
00bf9cf2 lea        eax, [r14 + 4]
00bf9cf6 xor        r9d, dword ptr [r13 + rax*4 + 4]
00bf9cfb lea        eax, [r14 + 0xa]
00bf9cff mov        dword ptr [r13 + rax*4 + 4], r9d
00bf9d04 mov        r8d, r9d
00bf9d07 lea        eax, [r14 + 5]
00bf9d0b xor        r8d, dword ptr [r13 + rax*4 + 4]
00bf9d10 lea        eax, [r14 + 0xb]
00bf9d14 mov        dword ptr [r13 + rax*4 + 4], r8d
00bf9d19 mov        eax, r8d
00bf9d1c ror        eax, 8
00bf9d1f mov        ecx, eax
00bf9d21 mov        edx, eax
00bf9d23 shr        eax, 0x10
00bf9d26 movzx      eax, al
00bf9d29 shr        rcx, 0x18
00bf9d2d mov        ebx, dword ptr [r12 + rcx*4 + 0xc00]
00bf9d35 xor        ebx, dword ptr [r12 + rax*4 + 0x800]
00bf9d3d mov        eax, edx
00bf9d3f shr        eax, 8
00bf9d42 movzx      ecx, al
00bf9d45 movzx      eax, dl
00bf9d48 xor        ebx, dword ptr [r12 + rcx*4 + 0x400]
00bf9d50 xor        ebx, dword ptr [r12 + rax*4]
00bf9d54 xor        ebx, dword ptr [rsi - 4]
00bf9d57 xor        ebx, edi
00bf9d59 lea        edi, [r15 + 3]
00bf9d5d lea        eax, [rdi - 1]
00bf9d60 xor        ebp, ebx
00bf9d62 lea        ecx, [rax + rax*2]
00bf9d65 mov        esi, ebp
00bf9d67 lea        eax, [r14 + 0xd]
00bf9d6b xor        esi, r11d
00bf9d6e mov        dword ptr [r13 + rax*4 + 4], ebp
00bf9d73 add        ecx, ecx
00bf9d75 lea        eax, [r14 + 0xe]
00bf9d79 mov        edx, esi
00bf9d7b xor        edx, r10d
00bf9d7e mov        dword ptr [r13 + rax*4 + 4], esi
00bf9d83 lea        eax, [r14 + 0xf]
00bf9d87 mov        dword ptr [rsp + 0x50], edx
00bf9d8b mov        r10d, edx
00bf9d8e mov        dword ptr [r13 + rax*4 + 4], edx
00bf9d93 xor        r10d, r9d
00bf9d96 mov        dword ptr [r13 + rcx*4 + 4], ebx
00bf9d9b lea        eax, [r14 + 0x10]
00bf9d9f mov        r11d, r10d
00bf9da2 mov        dword ptr [r13 + rax*4 + 4], r10d
00bf9da7 xor        r11d, r8d
00bf9daa lea        eax, [r14 + 0x11]
00bf9dae mov        dword ptr [r13 + rax*4 + 4], r11d
00bf9db3 mov        eax, r11d
00bf9db6 ror        eax, 8
00bf9db9 mov        ecx, eax
00bf9dbb mov        edx, eax
00bf9dbd shr        eax, 0x10
00bf9dc0 movzx      eax, al
00bf9dc3 shr        rcx, 0x18
00bf9dc7 mov        r9d, dword ptr [r12 + rcx*4 + 0xc00]
00bf9dcf xor        r9d, dword ptr [r12 + rax*4 + 0x800]
00bf9dd7 mov        eax, edx
00bf9dd9 shr        eax, 8
00bf9ddc movzx      ecx, al
00bf9ddf movzx      eax, dl
00bf9de2 xor        r9d, dword ptr [r12 + rcx*4 + 0x400]
00bf9dea xor        r9d, dword ptr [r12 + rax*4]
00bf9dee mov        rax, qword ptr [rsp + 0x58]
00bf9df3 xor        r9d, dword ptr [rax]
00bf9df6 lea        eax, [rdi + rdi*2]
00bf9df9 add        eax, eax
00bf9dfb xor        r9d, ebx
00bf9dfe mov        ebx, dword ptr [rsp + 0x50]
00bf9e02 xor        ebp, r9d
00bf9e05 xor        esi, ebp
00bf9e07 xor        ebx, esi
00bf9e09 mov        dword ptr [r13 + rax*4 + 4], r9d
00bf9e0e xor        r10d, ebx
00bf9e11 lea        eax, [r14 + 0x13]
00bf9e15 xor        r11d, r10d
00bf9e18 mov        dword ptr [r13 + rax*4 + 4], ebp
00bf9e1d lea        eax, [r14 + 0x14]
00bf9e21 mov        dword ptr [r13 + rax*4 + 4], esi
00bf9e26 lea        eax, [r14 + 0x15]
00bf9e2a mov        dword ptr [r13 + rax*4 + 4], ebx
00bf9e2f lea        eax, [r14 + 0x16]
00bf9e33 mov        dword ptr [r13 + rax*4 + 4], r10d
00bf9e38 lea        eax, [r14 + 0x17]
00bf9e3c mov        dword ptr [r13 + rax*4 + 4], r11d
00bf9e41 mov        eax, r11d
00bf9e44 ror        eax, 8
00bf9e47 mov        ecx, eax
00bf9e49 mov        edx, eax
00bf9e4b shr        eax, 0x10
00bf9e4e movzx      eax, al
00bf9e51 shr        rcx, 0x18
00bf9e55 mov        r8d, dword ptr [r12 + rcx*4 + 0xc00]
00bf9e5d xor        r8d, dword ptr [r12 + rax*4 + 0x800]
00bf9e65 mov        eax, edx
00bf9e67 shr        eax, 8
00bf9e6a movzx      ecx, al
00bf9e6d movzx      eax, dl
00bf9e70 xor        r8d, dword ptr [r12 + rcx*4 + 0x400]
00bf9e78 xor        r8d, dword ptr [r12 + rax*4]
00bf9e7c mov        rax, qword ptr [rsp + 0x58]
00bf9e81 xor        r8d, dword ptr [rax + 4]
00bf9e85 lea        eax, [rdi + 1]
00bf9e88 lea        ecx, [rax + rax*2]
00bf9e8b xor        r8d, r9d
00bf9e8e lea        eax, [r14 + 0x19]
00bf9e92 xor        ebp, r8d
00bf9e95 mov        dword ptr [r13 + rax*4 + 4], ebp
00bf9e9a xor        esi, ebp
00bf9e9c lea        eax, [r14 + 0x1a]
00bf9ea0 xor        ebx, esi
00bf9ea2 mov        dword ptr [r13 + rax*4 + 4], esi
00bf9ea7 add        ecx, ecx
00bf9ea9 lea        eax, [r14 + 0x1b]
00bf9ead mov        dword ptr [r13 + rax*4 + 4], ebx
00bf9eb2 xor        ebx, r10d
00bf9eb5 lea        eax, [r14 + 0x1c]
00bf9eb9 mov        dword ptr [r13 + rax*4 + 4], ebx
00bf9ebe xor        ebx, r11d
00bf9ec1 lea        eax, [r14 + 0x1d]
00bf9ec5 mov        dword ptr [r13 + rcx*4 + 4], r8d
00bf9eca mov        dword ptr [r13 + rax*4 + 4], ebx
00bf9ecf add        r15d, 4
00bf9ed3 mov        rsi, qword ptr [rsp + 0x58]
00bf9ed8 add        rsi, 0x10
00bf9edc mov        qword ptr [rsp + 0x58], rsi
00bf9ee1 cmp        r15d, 8
00bf9ee5 jb         0x140bf9c60
00bf9eeb jmp        0x140bfa184
00bf9ef0 mov        r12, qword ptr [rip + 0x14d8df9]
00bf9ef7 mov        r14, qword ptr [rip + 0x14d8e0a]
00bf9efe add        r12, 8
00bf9f02 nop        dword ptr [rax]
00bf9f06 nop        word ptr [rax + rax]
00bf9f10 lea        esi, [r15*4]
00bf9f18 ror        ebp, 8
00bf9f1b mov        eax, ebp
00bf9f1d mov        ecx, ebp
00bf9f1f shr        eax, 0x10
00bf9f22 movzx      eax, al
00bf9f25 shr        rcx, 0x18
00bf9f29 mov        r8d, dword ptr [r14 + rcx*4 + 0xc00]
00bf9f31 xor        r8d, dword ptr [r14 + rax*4 + 0x800]
00bf9f39 mov        eax, ebp
00bf9f3b shr        eax, 8
00bf9f3e movzx      ecx, al
00bf9f41 movzx      eax, bpl
00bf9f45 xor        r8d, dword ptr [r14 + rcx*4 + 0x400]
00bf9f4d xor        r8d, dword ptr [r13 + rsi*4 + 4]
00bf9f52 xor        r8d, dword ptr [r14 + rax*4]
00bf9f56 lea        eax, [rsi + 4]
00bf9f59 xor        r8d, dword ptr [r12 - 8]
00bf9f5e mov        dword ptr [r13 + rax*4 + 4], r8d
00bf9f63 mov        r9d, r8d
00bf9f66 lea        eax, [rsi + 1]
00bf9f69 xor        r9d, dword ptr [r13 + rax*4 + 4]
00bf9f6e lea        eax, [rsi + 5]
00bf9f71 mov        dword ptr [r13 + rax*4 + 4], r9d
00bf9f76 mov        r10d, r9d
00bf9f79 lea        eax, [rsi + 2]
00bf9f7c xor        r10d, dword ptr [r13 + rax*4 + 4]
00bf9f81 lea        eax, [rsi + 6]
00bf9f84 mov        dword ptr [r13 + rax*4 + 4], r10d
00bf9f89 mov        r11d, r10d
00bf9f8c lea        eax, [rsi + 3]
00bf9f8f xor        r11d, dword ptr [r13 + rax*4 + 4]
00bf9f94 lea        eax, [rsi + 7]
00bf9f97 mov        dword ptr [r13 + rax*4 + 4], r11d
00bf9f9c mov        eax, r11d
00bf9f9f ror        eax, 8
00bf9fa2 mov        ecx, eax
00bf9fa4 mov        edx, eax
00bf9fa6 shr        eax, 0x10
00bf9fa9 movzx      eax, al
00bf9fac shr        rcx, 0x18
00bf9fb0 mov        ebx, dword ptr [r14 + rcx*4 + 0xc00]
00bf9fb8 xor        ebx, dword ptr [r14 + rax*4 + 0x800]
00bf9fc0 mov        eax, edx
00bf9fc2 shr        eax, 8
00bf9fc5 movzx      ecx, al
00bf9fc8 movzx      eax, dl
00bf9fcb xor        ebx, dword ptr [r14 + rcx*4 + 0x400]
00bf9fd3 xor        ebx, dword ptr [r14 + rax*4]
00bf9fd7 lea        eax, [r15*4 + 8]
00bf9fdf xor        ebx, dword ptr [r12 - 4]
00bf9fe4 xor        ebx, r8d
00bf9fe7 mov        dword ptr [r13 + rax*4 + 4], ebx
00bf9fec mov        r8d, ebx
00bf9fef lea        eax, [rsi + 9]
00bf9ff2 xor        r8d, r9d
00bf9ff5 mov        dword ptr [r13 + rax*4 + 4], r8d
00bf9ffa mov        r9d, r8d
00bf9ffd xor        r9d, r10d
00bfa000 lea        eax, [rsi + 0xa]
00bfa003 mov        dword ptr [r13 + rax*4 + 4], r9d
00bfa008 mov        r10d, r9d
00bfa00b xor        r10d, r11d
00bfa00e lea        eax, [rsi + 0xb]
00bfa011 mov        dword ptr [r13 + rax*4 + 4], r10d
00bfa016 mov        eax, r10d
00bfa019 ror        eax, 8
00bfa01c mov        ecx, eax
00bfa01e mov        edx, eax
00bfa020 shr        eax, 0x10
00bfa023 movzx      eax, al
00bfa026 shr        rcx, 0x18
00bfa02a mov        r11d, dword ptr [r14 + rcx*4 + 0xc00]
00bfa032 xor        r11d, dword ptr [r14 + rax*4 + 0x800]
00bfa03a mov        eax, edx
00bfa03c shr        eax, 8
00bfa03f movzx      ecx, al
00bfa042 movzx      eax, dl
00bfa045 xor        r11d, dword ptr [r14 + rcx*4 + 0x400]
00bfa04d xor        r11d, dword ptr [r14 + rax*4]
00bfa051 xor        r11d, ebx
00bfa054 xor        r11d, dword ptr [r12]
00bfa058 lea        eax, [r15*4 + 0xc]
00bfa060 mov        dword ptr [r13 + rax*4 + 4], r11d
00bfa065 lea        r12, [r12 + 0x14]
00bfa06a lea        eax, [rsi + 0xd]
00bfa06d mov        ebp, r11d
00bfa070 xor        ebp, r8d
00bfa073 mov        dword ptr [r13 + rax*4 + 4], ebp
00bfa078 mov        r8d, ebp
00bfa07b xor        r8d, r9d
00bfa07e lea        eax, [rsi + 0xe]
00bfa081 mov        dword ptr [r13 + rax*4 + 4], r8d
00bfa086 mov        ebx, r8d
00bfa089 xor        ebx, r10d
00bfa08c lea        eax, [rsi + 0xf]
00bfa08f mov        dword ptr [r13 + rax*4 + 4], ebx
00bfa094 mov        eax, ebx
00bfa096 ror        eax, 8
00bfa099 mov        ecx, eax
00bfa09b mov        edx, eax
00bfa09d shr        eax, 0x10
00bfa0a0 movzx      eax, al
00bfa0a3 shr        rcx, 0x18
00bfa0a7 mov        r10d, dword ptr [r14 + rcx*4 + 0xc00]
00bfa0af xor        r10d, dword ptr [r14 + rax*4 + 0x800]
00bfa0b7 mov        eax, edx
00bfa0b9 shr        eax, 8
00bfa0bc movzx      ecx, al
00bfa0bf movzx      eax, dl
00bfa0c2 xor        r10d, dword ptr [r14 + rcx*4 + 0x400]
00bfa0ca xor        r10d, dword ptr [r14 + rax*4]
00bfa0ce lea        eax, [r15*4 + 0x10]
00bfa0d6 xor        r10d, dword ptr [r12 - 0x10]
00bfa0db xor        r10d, r11d
00bfa0de mov        dword ptr [r13 + rax*4 + 4], r10d
00bfa0e3 xor        ebp, r10d
00bfa0e6 lea        eax, [rsi + 0x11]
00bfa0e9 mov        r9d, ebp
00bfa0ec mov        dword ptr [r13 + rax*4 + 4], ebp
00bfa0f1 xor        r9d, r8d
00bfa0f4 lea        eax, [rsi + 0x12]
00bfa0f7 xor        ebx, r9d
00bfa0fa mov        dword ptr [r13 + rax*4 + 4], r9d
00bfa0ff lea        eax, [rsi + 0x13]
00bfa102 mov        dword ptr [r13 + rax*4 + 4], ebx
00bfa107 mov        eax, ebx
00bfa109 ror        eax, 8
00bfa10c mov        ecx, eax
00bfa10e mov        edx, eax
00bfa110 shr        eax, 0x10
00bfa113 movzx      eax, al
00bfa116 shr        rcx, 0x18
00bfa11a mov        r8d, dword ptr [r14 + rcx*4 + 0xc00]
00bfa122 xor        r8d, dword ptr [r14 + rax*4 + 0x800]
00bfa12a mov        eax, edx
00bfa12c shr        eax, 8
00bfa12f movzx      ecx, al
00bfa132 movzx      eax, dl
00bfa135 xor        r8d, dword ptr [r14 + rcx*4 + 0x400]
00bfa13d xor        r8d, dword ptr [r14 + rax*4]
00bfa141 lea        eax, [r15*4 + 0x14]
00bfa149 xor        r8d, dword ptr [r12 - 0xc]
00bfa14e add        r15d, 5
00bfa152 xor        r8d, r10d
00bfa155 xor        ebp, r8d
00bfa158 mov        dword ptr [r13 + rax*4 + 4], r8d
00bfa15d lea        eax, [rsi + 0x15]
00bfa160 mov        dword ptr [r13 + rax*4 + 4], ebp
00bfa165 xor        ebp, r9d
00bfa168 lea        eax, [rsi + 0x16]
00bfa16b mov        dword ptr [r13 + rax*4 + 4], ebp
00bfa170 xor        ebp, ebx
00bfa172 lea        eax, [rsi + 0x17]
00bfa175 mov        dword ptr [r13 + rax*4 + 4], ebp
00bfa17a cmp        r15d, 0xa
00bfa17e jb         0x140bf9f10
00bfa184 mov        r12d, 4
00bfa18a mov        eax, dword ptr [r13 + 4]
00bfa18e mov        r15, qword ptr [rsp]
00bfa192 mov        r14, qword ptr [rsp + 8]
00bfa197 mov        rdi, qword ptr [rsp + 0x10]
00bfa19c mov        rsi, qword ptr [rsp + 0x18]
00bfa1a1 mov        rbp, qword ptr [rsp + 0x20]
00bfa1a6 mov        rbx, qword ptr [rsp + 0x40]
00bfa1ab mov        dword ptr [r13 + 0x104], eax
00bfa1b2 mov        eax, dword ptr [r13 + 8]
00bfa1b6 mov        dword ptr [r13 + 0x108], eax
00bfa1bd mov        eax, dword ptr [r13 + 0xc]
00bfa1c1 mov        dword ptr [r13 + 0x10c], eax
00bfa1c8 mov        eax, dword ptr [r13 + 0x10]
00bfa1cc mov        dword ptr [r13 + 0x110], eax
00bfa1d3 mov        eax, dword ptr [r13]
00bfa1d7 lea        eax, [rax*4 + 0x18]
00bfa1de cmp        eax, 4
00bfa1e1 jbe        0x140bfa297
00bfa1e7 nop        word ptr [rax + rax]
; range 0xbfa1f0..0xbfa2a0 (exclusive)
00bfa1f0 mov        eax, r12d
00bfa1f3 inc        r12d
00bfa1f6 lea        r11, [rax*4]
00bfa1fe mov        r9d, dword ptr [r11 + r13 + 4]
00bfa203 mov        eax, r9d
00bfa206 shr        eax, 7
00bfa209 and        eax, 0x1010101
00bfa20e imul       r10d, eax, 0x1b
00bfa212 mov        eax, r9d
00bfa215 and        eax, 0xff7f7f7f
00bfa21a add        eax, eax
00bfa21c xor        r10d, eax
00bfa21f mov        eax, r10d
00bfa222 shr        eax, 7
00bfa225 and        eax, 0x1010101
00bfa22a imul       r8d, eax, 0x1b
00bfa22e mov        eax, r10d
00bfa231 and        eax, 0xff7f7f7f
00bfa236 add        eax, eax
00bfa238 xor        r8d, eax
00bfa23b mov        eax, r8d
00bfa23e shr        eax, 7
00bfa241 and        eax, 0x1010101
00bfa246 imul       edx, eax, 0x1b
00bfa249 mov        eax, r8d
00bfa24c and        eax, 0xff7f7f7f
00bfa251 add        eax, eax
00bfa253 xor        edx, eax
00bfa255 xor        r9d, edx
00bfa258 mov        ecx, r9d
00bfa25b mov        eax, r9d
00bfa25e xor        ecx, r8d
00bfa261 ror        r9d, 0x18
00bfa265 ror        ecx, 0x10
00bfa268 xor        eax, r10d
00bfa26b ror        eax, 8
00bfa26e xor        ecx, eax
00bfa270 xor        ecx, r9d
00bfa273 xor        ecx, edx
00bfa275 xor        ecx, r8d
00bfa278 xor        ecx, r10d
00bfa27b mov        dword ptr [r11 + r13 + 0x104], ecx
00bfa283 mov        eax, dword ptr [r13]
00bfa287 lea        eax, [rax*4 + 0x18]
00bfa28e cmp        r12d, eax
00bfa291 jb         0x140bfa1f0
00bfa297 add        rsp, 0x28
00bfa29b pop        r13
00bfa29d pop        r12
00bfa29f ret        
