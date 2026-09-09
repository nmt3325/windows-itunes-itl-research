00ff9a30 88542410 mov byte ptr [rsp + 0x10], dl
00ff9a34 55 push rbp
00ff9a35 53 push rbx
00ff9a36 56 push rsi
00ff9a37 57 push rdi
00ff9a38 4154 push r12
00ff9a3a 4155 push r13
00ff9a3c 4156 push r14
00ff9a3e 4157 push r15
00ff9a40 488bec mov rbp, rsp
00ff9a43 4883ec78 sub rsp, 0x78
00ff9a47 0f29742460 movaps xmmword ptr [rsp + 0x60], xmm6
00ff9a4c 440fb6e2 movzx r12d, dl
00ff9a50 4533ed xor r13d, r13d
00ff9a53 458bfd mov r15d, r13d
00ff9a56 0f57c0 xorps xmm0, xmm0
00ff9a59 f30f7f45d8 movdqu xmmword ptr [rbp - 0x28], xmm0
00ff9a5e 4032ff xor dil, dil
00ff9a61 beffffffff mov esi, 0xffffffff
00ff9a66 4885c9 test rcx, rcx
00ff9a69 0f844d070000 je 0x140ffa1bc
00ff9a6f 4c8b7130 mov r14, qword ptr [rcx + 0x30]
00ff9a73 4c897560 mov qword ptr [rbp + 0x60], r14
00ff9a77 33d2 xor edx, edx
00ff9a79 498bce mov rcx, r14
00ff9a7c e8ef70faff call 0x140fa0b70
00ff9a81 a904002000 test eax, 0x200004
00ff9a86 0f8430070000 je 0x140ffa1bc
00ff9a8c 4138be9d000000 cmp byte ptr [r14 + 0x9d], dil
00ff9a93 0f8c23070000 jl 0x140ffa1bc
00ff9a99 498bd6 mov rdx, r14
00ff9a9c 488d4dc0 lea rcx, [rbp - 0x40]
00ff9aa0 e8ab55faff call 0x140f9f050
00ff9aa5 488bd8 mov rbx, rax
00ff9aa8 488d45d8 lea rax, [rbp - 0x28]
00ff9aac 483bd8 cmp rbx, rax
00ff9aaf 7458 je 0x140ff9b09
00ff9ab1 488b4dd8 mov rcx, qword ptr [rbp - 0x28]
00ff9ab5 4885c9 test rcx, rcx
00ff9ab8 7418 je 0x140ff9ad2
00ff9aba 8bd6 mov edx, esi
00ff9abc f00fc15108 lock xadd dword ptr [rcx + 8], edx
00ff9ac1 83fa01 cmp edx, 1
00ff9ac4 750c jne 0x140ff9ad2
00ff9ac6 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00ff9acd e806237a00 call 0x14179bdd8
00ff9ad2 488b4de0 mov rcx, qword ptr [rbp - 0x20]
00ff9ad6 4885c9 test rcx, rcx
00ff9ad9 7418 je 0x140ff9af3
00ff9adb 8bc6 mov eax, esi
00ff9add f00fc14108 lock xadd dword ptr [rcx + 8], eax
00ff9ae2 83f801 cmp eax, 1
00ff9ae5 750c jne 0x140ff9af3
00ff9ae7 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00ff9aee e8e5227a00 call 0x14179bdd8
00ff9af3 488b03 mov rax, qword ptr [rbx]
00ff9af6 488945d8 mov qword ptr [rbp - 0x28], rax
00ff9afa 488b4308 mov rax, qword ptr [rbx + 8]
00ff9afe 488945e0 mov qword ptr [rbp - 0x20], rax
00ff9b02 4c892b mov qword ptr [rbx], r13
00ff9b05 4c896b08 mov qword ptr [rbx + 8], r13
00ff9b09 488b4dc0 mov rcx, qword ptr [rbp - 0x40]
00ff9b0d 4885c9 test rcx, rcx
00ff9b10 7420 je 0x140ff9b32
00ff9b12 8bc6 mov eax, esi
00ff9b14 f00fc14108 lock xadd dword ptr [rcx + 8], eax
00ff9b19 83f801 cmp eax, 1
00ff9b1c 750c jne 0x140ff9b2a
00ff9b1e c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00ff9b25 e8ae227a00 call 0x14179bdd8
00ff9b2a 33db xor ebx, ebx
00ff9b2c 48895dc0 mov qword ptr [rbp - 0x40], rbx
00ff9b30 eb02 jmp 0x140ff9b34
00ff9b32 33db xor ebx, ebx
00ff9b34 488b4dc8 mov rcx, qword ptr [rbp - 0x38]
00ff9b38 4885c9 test rcx, rcx
00ff9b3b 7418 je 0x140ff9b55
00ff9b3d 8bc6 mov eax, esi
00ff9b3f f00fc14108 lock xadd dword ptr [rcx + 8], eax
00ff9b44 83f801 cmp eax, 1
00ff9b47 750c jne 0x140ff9b55
00ff9b49 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00ff9b50 e883227a00 call 0x14179bdd8
00ff9b55 488b4de0 mov rcx, qword ptr [rbp - 0x20]
00ff9b59 488b55d8 mov rdx, qword ptr [rbp - 0x28]
00ff9b5d 4885d2 test rdx, rdx
00ff9b60 7406 je 0x140ff9b68
00ff9b62 48833a00 cmp qword ptr [rdx], 0
00ff9b66 7513 jne 0x140ff9b7b
00ff9b68 4885c9 test rcx, rcx
00ff9b6b 0f8453060000 je 0x140ffa1c4
00ff9b71 48833900 cmp qword ptr [rcx], 0
00ff9b75 0f8449060000 je 0x140ffa1c4
00ff9b7b 49837e1000 cmp qword ptr [r14 + 0x10], 0
00ff9b80 0f843e060000 je 0x140ffa1c4
00ff9b86 41f6869f00000010 test byte ptr [r14 + 0x9f], 0x10
00ff9b8e 0f8530060000 jne 0x140ffa1c4
00ff9b94 488d4dc0 lea rcx, [rbp - 0x40]
00ff9b98 e813693cff call 0x1403c04b0
00ff9b9d 498bd6 mov rdx, r14
00ff9ba0 488d4dc0 lea rcx, [rbp - 0x40]
00ff9ba4 e897a139ff call 0x140393d40
00ff9ba9 84c0 test al, al
00ff9bab 7412 je 0x140ff9bbf
00ff9bad 488d4dc0 lea rcx, [rbp - 0x40]
00ff9bb1 e8fa683cff call 0x1403c04b0
00ff9bb6 488d4dc0 lea rcx, [rbp - 0x40]
00ff9bba e8b19e39ff call 0x140393a70
00ff9bbf 33d2 xor edx, edx
00ff9bc1 498bce mov rcx, r14
00ff9bc4 e8a76ffaff call 0x140fa0b70
00ff9bc9 a804 test al, 4
00ff9bcb 740a je 0x140ff9bd7
00ff9bcd b201 mov dl, 1
00ff9bcf 498bce mov rcx, r14
00ff9bd2 e8196ffaff call 0x140fa0af0
00ff9bd7 498b7658 mov rsi, qword ptr [r14 + 0x58]
00ff9bdb 488975b8 mov qword ptr [rbp - 0x48], rsi
00ff9bdf 4885f6 test rsi, rsi
00ff9be2 0f84c5050000 je 0x140ffa1ad
00ff9be8 f30f10356896c700 movss xmm6, dword ptr [rip + 0xc79668]
00ff9bf0 817e34454c4946 cmp dword ptr [rsi + 0x34], 0x46494c45
00ff9bf7 0f8568050000 jne 0x140ffa165
00ff9bfd 410fb6d4 movzx edx, r12b
00ff9c01 03d2 add edx, edx
00ff9c03 83ca05 or edx, 5
00ff9c06 488bce mov rcx, rsi
00ff9c09 e8c239f0ff call 0x140efd5d0
00ff9c0e 448bf8 mov r15d, eax
00ff9c11 894558 mov dword ptr [rbp + 0x58], eax
00ff9c14 85c0 test eax, eax
00ff9c16 7409 je 0x140ff9c21
00ff9c18 83f8d5 cmp eax, -0x2b
00ff9c1b 0f8544050000 jne 0x140ffa165
00ff9c21 c7463450545448 mov dword ptr [rsi + 0x34], 0x48545450
00ff9c28 4c8da6b8020000 lea r12, [rsi + 0x2b8]
00ff9c2f 4d85e4 test r12, r12
00ff9c32 7408 je 0x140ff9c3c
00ff9c34 0f57c0 xorps xmm0, xmm0
00ff9c37 410f110424 movups xmmword ptr [r12], xmm0
00ff9c3c 488b45e0 mov rax, qword ptr [rbp - 0x20]
00ff9c40 4885c0 test rax, rax
00ff9c43 0f8563010000 jne 0x140ff9dac
00ff9c49 488b4dd8 mov rcx, qword ptr [rbp - 0x28]
00ff9c4d 4885c9 test rcx, rcx
00ff9c50 741a je 0x140ff9c6c
00ff9c52 488d4dd8 lea rcx, [rbp - 0x28]
00ff9c56 e86537aeff call 0x140add3c0
00ff9c5b 488b45e0 mov rax, qword ptr [rbp - 0x20]
00ff9c5f 4885c0 test rax, rax
00ff9c62 0f8544010000 jne 0x140ff9dac
00ff9c68 488b4dd8 mov rcx, qword ptr [rbp - 0x28]
00ff9c6c 4c8beb mov r13, rbx
00ff9c6f 4885c9 test rcx, rcx
00ff9c72 0f842b010000 je 0x140ff9da3
00ff9c78 4c8b31 mov r14, qword ptr [rcx]
00ff9c7b 4d85f6 test r14, r14
00ff9c7e 0f841b010000 je 0x140ff9d9f
00ff9c84 4a8d34b500000000 lea rsi, [r14*4]
00ff9c8c 0f57c0 xorps xmm0, xmm0
00ff9c8f f30f7f45c0 movdqu xmmword ptr [rbp - 0x40], xmm0
00ff9c94 488bfb mov rdi, rbx
00ff9c97 48895dd0 mov qword ptr [rbp - 0x30], rbx
00ff9c9b 4885f6 test rsi, rsi
00ff9c9e 7448 je 0x140ff9ce8
00ff9ca0 48b8ffffffffffffff7f movabs rax, 0x7fffffffffffffff
00ff9caa 483bf0 cmp rsi, rax
00ff9cad 0f8775050000 ja 0x140ffa228
00ff9cb3 488bce mov rcx, rsi
00ff9cb6 e8c58225ff call 0x140251f80
00ff9cbb 488bd8 mov rbx, rax
00ff9cbe 4c8bf8 mov r15, rax
00ff9cc1 488945c0 mov qword ptr [rbp - 0x40], rax
00ff9cc5 488d3c06 lea rdi, [rsi + rax]
00ff9cc9 48897dd0 mov qword ptr [rbp - 0x30], rdi
00ff9ccd 4c8bc6 mov r8, rsi
00ff9cd0 33d2 xor edx, edx
00ff9cd2 488bc8 mov rcx, rax
00ff9cd5 e8c62f7a00 call 0x14179cca0
00ff9cda 48897dc8 mov qword ptr [rbp - 0x38], rdi
00ff9cde 488b45e0 mov rax, qword ptr [rbp - 0x20]
00ff9ce2 488b4dd8 mov rcx, qword ptr [rbp - 0x28]
00ff9ce6 eb04 jmp 0x140ff9cec
00ff9ce8 4c8b7dc0 mov r15, qword ptr [rbp - 0x40]
00ff9cec 33d2 xor edx, edx
00ff9cee 48895548 mov qword ptr [rbp + 0x48], rdx
00ff9cf2 4885c9 test rcx, rcx
00ff9cf5 7520 jne 0x140ff9d17
00ff9cf7 4885c0 test rax, rax
00ff9cfa 7412 je 0x140ff9d0e
00ff9cfc 488d4dd8 lea rcx, [rbp - 0x28]
00ff9d00 e83b38aeff call 0x140add540
00ff9d05 488b4dd8 mov rcx, qword ptr [rbp - 0x28]
00ff9d09 4885c9 test rcx, rcx
00ff9d0c 7509 jne 0x140ff9d17
00ff9d0e 488d0d33769b00 lea rcx, [rip + 0x9b7633]
00ff9d15 eb04 jmp 0x140ff9d1b
00ff9d17 4883c10c add rcx, 0xc
00ff9d1b 488d4548 lea rax, [rbp + 0x48]
00ff9d1f 4889442420 mov qword ptr [rsp + 0x20], rax
00ff9d24 4c8bce mov r9, rsi
00ff9d27 4c8bc3 mov r8, rbx
00ff9d2a 498bd6 mov rdx, r14
00ff9d2d e81e23aeff call 0x140adc050
00ff9d32 488b5548 mov rdx, qword ptr [rbp + 0x48]
00ff9d36 4885d2 test rdx, rdx
00ff9d39 740e je 0x140ff9d49
00ff9d3b 498bcf mov rcx, r15
00ff9d3e e8cd3eaeff call 0x140addc10
00ff9d43 488945e0 mov qword ptr [rbp - 0x20], rax
00ff9d47 eb04 jmp 0x140ff9d4d
00ff9d49 488b45e0 mov rax, qword ptr [rbp - 0x20]
00ff9d4d 4885db test rbx, rbx
00ff9d50 7437 je 0x140ff9d89
00ff9d52 482bfb sub rdi, rbx
00ff9d55 4881ff00100000 cmp rdi, 0x1000
00ff9d5c 721c jb 0x140ff9d7a
00ff9d5e 4883c727 add rdi, 0x27
00ff9d62 488b43f8 mov rax, qword ptr [rbx - 8]
00ff9d66 482bd8 sub rbx, rax
00ff9d69 4883eb08 sub rbx, 8
00ff9d6d 4883fb1f cmp rbx, 0x1f
00ff9d71 0f8701040000 ja 0x140ffa178
00ff9d77 488bd8 mov rbx, rax
00ff9d7a 488bd7 mov rdx, rdi
00ff9d7d 488bcb mov rcx, rbx
00ff9d80 e89bccbcff call 0x140bc6a20
00ff9d85 488b45e0 mov rax, qword ptr [rbp - 0x20]
00ff9d89 488b75b8 mov rsi, qword ptr [rbp - 0x48]
00ff9d8d 4c8b7560 mov r14, qword ptr [rbp + 0x60]
00ff9d91 4885c0 test rax, rax
00ff9d94 7519 jne 0x140ff9daf
00ff9d96 4c8d15f08a9a00 lea r10, [rip + 0x9a8af0]
00ff9d9d eb14 jmp 0x140ff9db3
00ff9d9f 4c8b7560 mov r14, qword ptr [rbp + 0x60]
00ff9da3 4c8d15e38a9a00 lea r10, [rip + 0x9a8ae3]
00ff9daa eb07 jmp 0x140ff9db3
00ff9dac 4c8b28 mov r13, qword ptr [rax]
00ff9daf 4c8d500c lea r10, [rax + 0xc]
00ff9db3 4c8955c0 mov qword ptr [rbp - 0x40], r10
00ff9db7 488b4608 mov rax, qword ptr [rsi + 8]
00ff9dbb 4885c0 test rax, rax
00ff9dbe 0f8485030000 je 0x140ffa149
00ff9dc4 4883781000 cmp qword ptr [rax + 0x10], 0
00ff9dc9 0f847a030000 je 0x140ffa149
00ff9dcf 4181fd20030000 cmp r13d, 0x320
00ff9dd6 0f876d030000 ja 0x140ffa149
00ff9ddc 4d85d2 test r10, r10
00ff9ddf 41b800000000 mov r8d, 0
00ff9de5 450f44e8 cmove r13d, r8d
00ff9de9 8b4634 mov eax, dword ptr [rsi + 0x34]
00ff9dec 3d454c4946 cmp eax, 0x46494c45
00ff9df1 7432 je 0x140ff9e25
00ff9df3 3d50545448 cmp eax, 0x48545450
00ff9df8 7411 je 0x140ff9e0b
00ff9dfa 3d44524853 cmp eax, 0x53485244
00ff9dff 0f8544030000 jne 0x140ffa149
00ff9e05 4c8d4e78 lea r9, [rsi + 0x78]
00ff9e09 eb03 jmp 0x140ff9e0e
00ff9e0b 4d8bcc mov r9, r12
00ff9e0e 458bc5 mov r8d, r13d
00ff9e11 498bd2 mov rdx, r10
00ff9e14 488b8ec8020000 mov rcx, qword ptr [rsi + 0x2c8]
00ff9e1b e8b04ec0ff call 0x140bfecd0
00ff9e20 e924030000 jmp 0x140ffa149
00ff9e25 488b9ec8020000 mov rbx, qword ptr [rsi + 0x2c8]
00ff9e2c 4885db test rbx, rbx
00ff9e2f 0f8414030000 je 0x140ffa149
00ff9e35 813b63727473 cmp dword ptr [rbx], 0x73747263
00ff9e3b 0f8508030000 jne 0x140ffa149
00ff9e41 44394328 cmp dword ptr [rbx + 0x28], r8d
00ff9e45 0f85fe020000 jne 0x140ffa149
00ff9e4b 486386c0020000 movsxd rax, dword ptr [rsi + 0x2c0]
00ff9e52 4439433c cmp dword ptr [rbx + 0x3c], r8d
00ff9e56 0f85ed020000 jne 0x140ffa149
00ff9e5c 85c0 test eax, eax
00ff9e5e 7442 je 0x140ff9ea2
00ff9e60 8b4b04 mov ecx, dword ptr [rbx + 4]
00ff9e63 83e101 and ecx, 1
00ff9e66 85c0 test eax, eax
00ff9e68 0f8edb020000 jle 0x140ffa149
00ff9e6e 3b432c cmp eax, dword ptr [rbx + 0x2c]
00ff9e71 0f8fd2020000 jg 0x140ffa149
00ff9e77 488bd0 mov rdx, rax
00ff9e7a 84c9 test cl, cl
00ff9e7c 740e je 0x140ff9e8c
00ff9e7e 488b4318 mov rax, qword ptr [rbx + 0x18]
00ff9e82 488b00 mov rax, qword ptr [rax]
00ff9e85 836c90fc01 sub dword ptr [rax + rdx*4 - 4], 1
00ff9e8a 7516 jne 0x140ff9ea2
00ff9e8c 488b4310 mov rax, qword ptr [rbx + 0x10]
00ff9e90 488b08 mov rcx, qword ptr [rax]
00ff9e93 8b44d1fc mov eax, dword ptr [rcx + rdx*8 - 4]
00ff9e97 014340 add dword ptr [rbx + 0x40], eax
00ff9e9a c744d1f801000080 mov dword ptr [rcx + rdx*8 - 8], 0x80000001
00ff9ea2 448986c0020000 mov dword ptr [rsi + 0x2c0], r8d
00ff9ea9 813b63727473 cmp dword ptr [rbx], 0x73747263
00ff9eaf 0f8594020000 jne 0x140ffa149
00ff9eb5 4439433c cmp dword ptr [rbx + 0x3c], r8d
00ff9eb9 0f858a020000 jne 0x140ffa149
00ff9ebf 4585ed test r13d, r13d
00ff9ec2 0f8481020000 je 0x140ffa149
00ff9ec8 44394328 cmp dword ptr [rbx + 0x28], r8d
00ff9ecc 0f8577020000 jne 0x140ffa149
00ff9ed2 0fb64304 movzx eax, byte ptr [rbx + 4]
00ff9ed6 2401 and al, 1
00ff9ed8 884548 mov byte ptr [rbp + 0x48], al
00ff9edb 0f8492000000 je 0x140ff9f73
00ff9ee1 4c8b4310 mov r8, qword ptr [rbx + 0x10]
00ff9ee5 4d85c0 test r8, r8
00ff9ee8 0f8485000000 je 0x140ff9f73
00ff9eee 488b4320 mov rax, qword ptr [rbx + 0x20]
00ff9ef2 4885c0 test rax, rax
00ff9ef5 747c je 0x140ff9f73
00ff9ef7 c7433c01000000 mov dword ptr [rbx + 0x3c], 1
00ff9efe 4c8b30 mov r14, qword ptr [rax]
00ff9f01 488b4318 mov rax, qword ptr [rbx + 0x18]
00ff9f05 4c8b38 mov r15, qword ptr [rax]
00ff9f08 4863532c movsxd rdx, dword ptr [rbx + 0x2c]
00ff9f0c 498b00 mov rax, qword ptr [r8]
00ff9f0f 488d7aff lea rdi, [rdx - 1]
00ff9f13 488d3cf8 lea rdi, [rax + rdi*8]
00ff9f17 8d72ff lea esi, [rdx - 1]
00ff9f1a 85f6 test esi, esi
00ff9f1c 783d js 0x140ff9f5b
00ff9f1e 6690 nop 
00ff9f20 8b4704 mov eax, dword ptr [rdi + 4]
00ff9f23 413bc5 cmp eax, r13d
00ff9f26 752a jne 0x140ff9f52
00ff9f28 48630f movsxd rcx, dword ptr [rdi]
00ff9f2b 85c9 test ecx, ecx
00ff9f2d 7823 js 0x140ff9f52
00ff9f2f 85c0 test eax, eax
00ff9f31 7e1f jle 0x140ff9f52
00ff9f33 498d140e lea rdx, [r14 + rcx]
00ff9f37 0fb602 movzx eax, byte ptr [rdx]
00ff9f3a 413802 cmp byte ptr [r10], al
00ff9f3d 7513 jne 0x140ff9f52
00ff9f3f 4d63c5 movsxd r8, r13d
00ff9f42 498bca mov rcx, r10
00ff9f45 e84a2d7a00 call 0x14179cc94
00ff9f4a 85c0 test eax, eax
00ff9f4c 7446 je 0x140ff9f94
00ff9f4e 4c8b55c0 mov r10, qword ptr [rbp - 0x40]
00ff9f52 4883ef08 sub rdi, 8
00ff9f56 83ee01 sub esi, 1
00ff9f59 79c5 jns 0x140ff9f20
00ff9f5b 488b75b8 mov rsi, qword ptr [rbp - 0x48]
00ff9f5f 813b63727473 cmp dword ptr [rbx], 0x73747263
00ff9f65 750c jne 0x140ff9f73
00ff9f67 8b433c mov eax, dword ptr [rbx + 0x3c]
00ff9f6a 85c0 test eax, eax
00ff9f6c 7e05 jle 0x140ff9f73
00ff9f6e ffc8 dec eax
00ff9f70 89433c mov dword ptr [rbx + 0x3c], eax
00ff9f73 488bcb mov rcx, rbx
00ff9f76 e8c53ec0ff call 0x140bfde40
00ff9f7b 48634330 movsxd rax, dword ptr [rbx + 0x30]
00ff9f7f 85c0 test eax, eax
00ff9f81 754a jne 0x140ff9fcd
00ff9f83 488bcb mov rcx, rbx
00ff9f86 e8c53cc0ff call 0x140bfdc50
00ff9f8b 85c0 test eax, eax
00ff9f8d 74e4 je 0x140ff9f73
00ff9f8f e9b1010000 jmp 0x140ffa145
00ff9f94 4863c6 movsxd rax, esi
00ff9f97 41ff0487 inc dword ptr [r15 + rax*4]
00ff9f9b 8d4601 lea eax, [rsi + 1]
00ff9f9e 488b75b8 mov rsi, qword ptr [rbp - 0x48]
00ff9fa2 8986c0020000 mov dword ptr [rsi + 0x2c0], eax
00ff9fa8 813b63727473 cmp dword ptr [rbx], 0x73747263
00ff9fae 0f8591010000 jne 0x140ffa145
00ff9fb4 8b433c mov eax, dword ptr [rbx + 0x3c]
00ff9fb7 4c8b7560 mov r14, qword ptr [rbp + 0x60]
00ff9fbb 85c0 test eax, eax
00ff9fbd 0f8e86010000 jle 0x140ffa149
00ff9fc3 ffc8 dec eax
00ff9fc5 89433c mov dword ptr [rbx + 0x3c], eax
00ff9fc8 e97c010000 jmp 0x140ffa149
00ff9fcd 488b5310 mov rdx, qword ptr [rbx + 0x10]
00ff9fd1 488d78ff lea rdi, [rax - 1]
00ff9fd5 488b02 mov rax, qword ptr [rdx]
00ff9fd8 488d3cf8 lea rdi, [rax + rdi*8]
00ff9fdc 8b4704 mov eax, dword ptr [rdi + 4]
00ff9fdf 894330 mov dword ptr [rbx + 0x30], eax
00ff9fe2 4c8be7 mov r12, rdi
00ff9fe5 4c2b22 sub r12, qword ptr [rdx]
00ff9fe8 49c1fc03 sar r12, 3
00ff9fec 41ffc4 inc r12d
00ff9fef 4d63fc movsxd r15, r12d
00ff9ff2 488b4320 mov rax, qword ptr [rbx + 0x20]
00ff9ff6 33d2 xor edx, edx
00ff9ff8 448bf2 mov r14d, edx
00ff9ffb 4885c0 test rax, rax
00ff9ffe 7411 je 0x140ffa011
00ffa000 817808486d654d cmp dword ptr [rax + 8], 0x4d656d48
00ffa007 7504 jne 0x140ffa00d
00ffa009 448b7010 mov r14d, dword ptr [rax + 0x10]
00ffa00d 442b7334 sub r14d, dword ptr [rbx + 0x34]
00ffa011 443b6b34 cmp r13d, dword ptr [rbx + 0x34]
00ffa015 0f8ee0000000 jle 0x140ffa0fb
00ffa01b 8b4b38 mov ecx, dword ptr [rbx + 0x38]
00ffa01e 8bc1 mov eax, ecx
00ffa020 413bcd cmp ecx, r13d
00ffa023 410f42c5 cmovb eax, r13d
00ffa027 66410f6ec6 movd xmm0, r14d
00ffa02c 0f5bc0 cvtdq2ps xmm0, xmm0
00ffa02f f30f59c6 mulss xmm0, xmm6
00ffa033 f3480f2cf0 cvttss2si rsi, xmm0
00ffa038 3bc6 cmp eax, esi
00ffa03a 0f43f0 cmovae esi, eax
00ffa03d 81f900200000 cmp ecx, 0x2000
00ffa043 7306 jae 0x140ffa04b
00ffa045 8d0409 lea eax, [rcx + rcx]
00ffa048 894338 mov dword ptr [rbx + 0x38], eax
00ffa04b 488d7b20 lea rdi, [rbx + 0x20]
00ffa04f 4885ff test rdi, rdi
00ffa052 7511 jne 0x140ffa065
00ffa054 488b4310 mov rax, qword ptr [rbx + 0x10]
00ffa058 488b08 mov rcx, qword ptr [rax]
00ffa05b 498d7fff lea rdi, [r15 - 1]
00ffa05f 488d3cf9 lea rdi, [rcx + rdi*8]
00ffa063 eb7d jmp 0x140ffa0e2
00ffa065 488b0f mov rcx, qword ptr [rdi]
00ffa068 4885c9 test rcx, rcx
00ffa06b 7438 je 0x140ffa0a5
00ffa06d 817908486d654d cmp dword ptr [rcx + 8], 0x4d656d48
00ffa074 7503 jne 0x140ffa079
00ffa076 8b5110 mov edx, dword ptr [rcx + 0x10]
00ffa079 85f6 test esi, esi
00ffa07b 7918 jns 0x140ffa095
00ffa07d 8d0432 lea eax, [rdx + rsi]
00ffa080 85c0 test eax, eax
00ffa082 7911 jns 0x140ffa095
00ffa084 488b4310 mov rax, qword ptr [rbx + 0x10]
00ffa088 488b08 mov rcx, qword ptr [rax]
00ffa08b 498d7fff lea rdi, [r15 - 1]
00ffa08f 488d3cf9 lea rdi, [rcx + rdi*8]
00ffa093 eb4d jmp 0x140ffa0e2
00ffa095 8d0432 lea eax, [rdx + rsi]
00ffa098 4863d0 movsxd rdx, eax
00ffa09b e820c5bcff call 0x140bc65c0
00ffa0a0 448bc0 mov r8d, eax
00ffa0a3 eb29 jmp 0x140ffa0ce
00ffa0a5 85f6 test esi, esi
00ffa0a7 781f js 0x140ffa0c8
00ffa0a9 4863ce movsxd rcx, esi
00ffa0ac e8dfc3bcff call 0x140bc6490
00ffa0b1 488907 mov qword ptr [rdi], rax
00ffa0b4 41b894ffffff mov r8d, 0xffffff94
00ffa0ba 4885c0 test rax, rax
00ffa0bd ba00000000 mov edx, 0
00ffa0c2 440f45c2 cmovne r8d, edx
00ffa0c6 eb06 jmp 0x140ffa0ce
00ffa0c8 41b894ffffff mov r8d, 0xffffff94
00ffa0ce 488b4310 mov rax, qword ptr [rbx + 0x10]
00ffa0d2 488b08 mov rcx, qword ptr [rax]
00ffa0d5 498d7fff lea rdi, [r15 - 1]
00ffa0d9 488d3cf9 lea rdi, [rcx + rdi*8]
00ffa0dd 4585c0 test r8d, r8d
00ffa0e0 7416 je 0x140ffa0f8
00ffa0e2 c70700000080 mov dword ptr [rdi], 0x80000000
00ffa0e8 8b4330 mov eax, dword ptr [rbx + 0x30]
00ffa0eb 894704 mov dword ptr [rdi + 4], eax
00ffa0ee 44896330 mov dword ptr [rbx + 0x30], r12d
00ffa0f2 488b75b8 mov rsi, qword ptr [rbp - 0x48]
00ffa0f6 eb4d jmp 0x140ffa145
00ffa0f8 017334 add dword ptr [rbx + 0x34], esi
00ffa0fb 4d63c5 movsxd r8, r13d
00ffa0fe 488b4320 mov rax, qword ptr [rbx + 0x20]
00ffa102 4963ce movsxd rcx, r14d
00ffa105 480308 add rcx, qword ptr [rax]
00ffa108 488b55c0 mov rdx, qword ptr [rbp - 0x40]
00ffa10c 4885d2 test rdx, rdx
00ffa10f 740a je 0x140ffa11b
00ffa111 4885c9 test rcx, rcx
00ffa114 7405 je 0x140ffa11b
00ffa116 e85ad78600 call 0x141867875
00ffa11b 44296b34 sub dword ptr [rbx + 0x34], r13d
00ffa11f 448937 mov dword ptr [rdi], r14d
00ffa122 44896f04 mov dword ptr [rdi + 4], r13d
00ffa126 488b75b8 mov rsi, qword ptr [rbp - 0x48]
00ffa12a 4489a6c0020000 mov dword ptr [rsi + 0x2c0], r12d
00ffa131 807d4800 cmp byte ptr [rbp + 0x48], 0
00ffa135 740e je 0x140ffa145
00ffa137 4963d4 movsxd rdx, r12d
00ffa13a 488b4318 mov rax, qword ptr [rbx + 0x18]
00ffa13e 488b08 mov rcx, qword ptr [rax]
00ffa141 ff4491fc inc dword ptr [rcx + rdx*4 - 4]
00ffa145 4c8b7560 mov r14, qword ptr [rbp + 0x60]
00ffa149 41808e9d00000080 or byte ptr [r14 + 0x9d], 0x80
00ffa151 4180a69a000000fd and byte ptr [r14 + 0x9a], 0xfd
00ffa159 40b701 mov dil, 1
00ffa15c 448b7d58 mov r15d, dword ptr [rbp + 0x58]
00ffa160 440fb66550 movzx r12d, byte ptr [rbp + 0x50]
00ffa165 488b36 mov rsi, qword ptr [rsi]
00ffa168 488975b8 mov qword ptr [rbp - 0x48], rsi
00ffa16c 4885f6 test rsi, rsi
00ffa16f 741f je 0x140ffa190
00ffa171 33db xor ebx, ebx
00ffa173 e978faffff jmp 0x140ff9bf0
00ffa178 33c0 xor eax, eax
00ffa17a 4889442420 mov qword ptr [rsp + 0x20], rax
00ffa17f 4533c9 xor r9d, r9d
00ffa182 4533c0 xor r8d, r8d
00ffa185 33d2 xor edx, edx
00ffa187 33c9 xor ecx, ecx
00ffa189 ff1551238f00 call qword ptr [rip + 0x8f2351]
00ffa18f cc int3 
00ffa190 4084ff test dil, dil
00ffa193 7418 je 0x140ffa1ad
00ffa195 ba0f000000 mov edx, 0xf
00ffa19a 498bce mov rcx, r14
00ffa19d e85e9ff9ff call 0x140f94100
00ffa1a2 33d2 xor edx, edx
00ffa1a4 498b4e10 mov rcx, qword ptr [r14 + 0x10]
00ffa1a8 e88341edff call 0x140ece330
00ffa1ad 488b4de0 mov rcx, qword ptr [rbp - 0x20]
00ffa1b1 488b55d8 mov rdx, qword ptr [rbp - 0x28]
00ffa1b5 beffffffff mov esi, 0xffffffff
00ffa1ba eb0e jmp 0x140ffa1ca
00ffa1bc 488b4de0 mov rcx, qword ptr [rbp - 0x20]
00ffa1c0 488b55d8 mov rdx, qword ptr [rbp - 0x28]
00ffa1c4 41bfceffffff mov r15d, 0xffffffce
00ffa1ca 4885d2 test rdx, rdx
00ffa1cd 7425 je 0x140ffa1f4
00ffa1cf 8bc6 mov eax, esi
00ffa1d1 f00fc14208 lock xadd dword ptr [rdx + 8], eax
00ffa1d6 83f801 cmp eax, 1
00ffa1d9 750f jne 0x140ffa1ea
00ffa1db c74208003665c4 mov dword ptr [rdx + 8], 0xc4653600
00ffa1e2 488bca mov rcx, rdx
00ffa1e5 e8ee1b7a00 call 0x14179bdd8
00ffa1ea 33c0 xor eax, eax
00ffa1ec 488945d8 mov qword ptr [rbp - 0x28], rax
00ffa1f0 488b4de0 mov rcx, qword ptr [rbp - 0x20]
00ffa1f4 4885c9 test rcx, rcx
00ffa1f7 7416 je 0x140ffa20f
00ffa1f9 f00fc17108 lock xadd dword ptr [rcx + 8], esi
00ffa1fe 83fe01 cmp esi, 1
00ffa201 750c jne 0x140ffa20f
00ffa203 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00ffa20a e8c91b7a00 call 0x14179bdd8
00ffa20f 418bc7 mov eax, r15d
00ffa212 0f28742460 movaps xmm6, xmmword ptr [rsp + 0x60]
00ffa217 4883c478 add rsp, 0x78
00ffa21b 415f pop r15
00ffa21d 415e pop r14
00ffa21f 415d pop r13
00ffa221 415c pop r12
00ffa223 5f pop rdi
00ffa224 5e pop rsi
00ffa225 5b pop rbx
00ffa226 5d pop rbp
00ffa227 c3 ret 
00ffa228 e883c727ff call 0x1402769b0
00ffa22d 90 nop 