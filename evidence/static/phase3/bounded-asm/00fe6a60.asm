00fe6a60 48895c2418 mov qword ptr [rsp + 0x18], rbx
00fe6a65 55 push rbp
00fe6a66 56 push rsi
00fe6a67 57 push rdi
00fe6a68 4154 push r12
00fe6a6a 4155 push r13
00fe6a6c 4156 push r14
00fe6a6e 4157 push r15
00fe6a70 488dac2440feffff lea rbp, [rsp - 0x1c0]
00fe6a78 4881ecc0020000 sub rsp, 0x2c0
00fe6a7f 488b05bae5fe00 mov rax, qword ptr [rip + 0xfee5ba]
00fe6a86 4833c4 xor rax, rsp
00fe6a89 488985b0010000 mov qword ptr [rbp + 0x1b0], rax
00fe6a90 4d8bf9 mov r15, r9
00fe6a93 410fb6d8 movzx ebx, r8b
00fe6a97 488bfa mov rdi, rdx
00fe6a9a 48894c2478 mov qword ptr [rsp + 0x78], rcx
00fe6a9f 33d2 xor edx, edx
00fe6aa1 448be2 mov r12d, edx
00fe6aa4 488955a8 mov qword ptr [rbp - 0x58], rdx
00fe6aa8 448bf2 mov r14d, edx
00fe6aab 4889542450 mov qword ptr [rsp + 0x50], rdx
00fe6ab0 88542440 mov byte ptr [rsp + 0x40], dl
00fe6ab4 8bf2 mov esi, edx
00fe6ab6 4d85c9 test r9, r9
00fe6ab9 7403 je 0x140fe6abe
00fe6abb 498911 mov qword ptr [r9], rdx
00fe6abe 4885ff test rdi, rdi
00fe6ac1 7406 je 0x140fe6ac9
00fe6ac3 488b4710 mov rax, qword ptr [rdi + 0x10]
00fe6ac7 eb03 jmp 0x140fe6acc
00fe6ac9 488bc2 mov rax, rdx
00fe6acc 488b4910 mov rcx, qword ptr [rcx + 0x10]
00fe6ad0 4c8b4108 mov r8, qword ptr [rcx + 8]
00fe6ad4 4c3bc0 cmp r8, rax
00fe6ad7 744d je 0x140fe6b26
00fe6ad9 4885ff test rdi, rdi
00fe6adc 743a je 0x140fe6b18
00fe6ade 48395710 cmp qword ptr [rdi + 0x10], rdx
00fe6ae2 7434 je 0x140fe6b18
00fe6ae4 4533c9 xor r9d, r9d
00fe6ae7 488bcf mov rcx, rdi
00fe6aea e8115bedff call 0x140ebc600
00fe6aef 4885c0 test rax, rax
00fe6af2 750e jne 0x140fe6b02
00fe6af4 4533ed xor r13d, r13d
00fe6af7 41bc94ffffff mov r12d, 0xffffff94
00fe6afd e913050000 jmp 0x140fe7015
00fe6b02 4c8b6808 mov r13, qword ptr [rax + 8]
00fe6b06 4d85ed test r13, r13
00fe6b09 7410 je 0x140fe6b1b
00fe6b0b 488b4c2478 mov rcx, qword ptr [rsp + 0x78]
00fe6b10 488b4910 mov rcx, qword ptr [rcx + 0x10]
00fe6b14 33d2 xor edx, edx
00fe6b16 eb11 jmp 0x140fe6b29
00fe6b18 4c8bea mov r13, rdx
00fe6b1b 41bc94ffffff mov r12d, 0xffffff94
00fe6b21 e9ef040000 jmp 0x140fe7015
00fe6b26 4c8bef mov r13, rdi
00fe6b29 84db test bl, bl
00fe6b2b 7518 jne 0x140fe6b45
00fe6b2d 4885ff test rdi, rdi
00fe6b30 7406 je 0x140fe6b38
00fe6b32 488b4710 mov rax, qword ptr [rdi + 0x10]
00fe6b36 eb03 jmp 0x140fe6b3b
00fe6b38 488bc2 mov rax, rdx
00fe6b3b 48394108 cmp qword ptr [rcx + 8], rax
00fe6b3f 0f8435010000 je 0x140fe6c7a
00fe6b45 808f9d00000040 or byte ptr [rdi + 0x9d], 0x40
00fe6b4c 8b87ac000000 mov eax, dword ptr [rdi + 0xac]
00fe6b52 85c0 test eax, eax
00fe6b54 740d je 0x140fe6b63
00fe6b56 0fbaf015 btr eax, 0x15
00fe6b5a 83c804 or eax, 4
00fe6b5d 8987ac000000 mov dword ptr [rdi + 0xac], eax
00fe6b63 498bcd mov rcx, r13
00fe6b66 e895c3faff call 0x140f92f00
00fe6b6b 84db test bl, bl
00fe6b6d 752e jne 0x140fe6b9d
00fe6b6f 488b4758 mov rax, qword ptr [rdi + 0x58]
00fe6b73 4885c0 test rax, rax
00fe6b76 0f84fe000000 je 0x140fe6c7a
00fe6b7c 81783450545448 cmp dword ptr [rax + 0x34], 0x48545450
00fe6b83 0f85f1000000 jne 0x140fe6c7a
00fe6b89 488b4710 mov rax, qword ptr [rdi + 0x10]
00fe6b8d 81b8840000006d757369 cmp dword ptr [rax + 0x84], 0x6973756d
00fe6b97 0f85dd000000 jne 0x140fe6c7a
00fe6b9d 4180a59b000000f7 and byte ptr [r13 + 0x9b], 0xf7
00fe6ba5 33db xor ebx, ebx
00fe6ba7 6641899d00010000 mov word ptr [r13 + 0x100], bx
00fe6baf 498b4558 mov rax, qword ptr [r13 + 0x58]
00fe6bb3 89585c mov dword ptr [rax + 0x5c], ebx
00fe6bb6 498b4578 mov rax, qword ptr [r13 + 0x78]
00fe6bba 895808 mov dword ptr [rax + 8], ebx
00fe6bbd 498b4568 mov rax, qword ptr [r13 + 0x68]
00fe6bc1 885801 mov byte ptr [rax + 1], bl
00fe6bc4 41808d9d00000008 or byte ptr [r13 + 0x9d], 8
00fe6bcc 4180a59a000000fd and byte ptr [r13 + 0x9a], 0xfd
00fe6bd4 488b4f10 mov rcx, qword ptr [rdi + 0x10]
00fe6bd8 488b4768 mov rax, qword ptr [rdi + 0x68]
00fe6bdc 8b5044 mov edx, dword ptr [rax + 0x44]
00fe6bdf 85d2 test edx, edx
00fe6be1 0f8493000000 je 0x140fe6c7a
00fe6be7 4d8b4558 mov r8, qword ptr [r13 + 0x58]
00fe6beb 4d8d88b8020000 lea r9, [r8 + 0x2b8]
00fe6bf2 4881c1d8040000 add rcx, 0x4d8
00fe6bf9 4d8b80c8020000 mov r8, qword ptr [r8 + 0x2c8]
00fe6c00 e8eb8dc1ff call 0x140bff9f0
00fe6c05 4d8b4d68 mov r9, qword ptr [r13 + 0x68]
00fe6c09 488b442478 mov rax, qword ptr [rsp + 0x78]
00fe6c0e 488b4010 mov rax, qword ptr [rax + 0x10]
00fe6c12 4c8b4008 mov r8, qword ptr [rax + 8]
00fe6c16 4981c0d8040000 add r8, 0x4d8
00fe6c1d 745b je 0x140fe6c7a
00fe6c1f 41813863727473 cmp dword ptr [r8], 0x73747263
00fe6c26 7552 jne 0x140fe6c7a
00fe6c28 41395828 cmp dword ptr [r8 + 0x28], ebx
00fe6c2c 754c jne 0x140fe6c7a
00fe6c2e 49635144 movsxd rdx, dword ptr [r9 + 0x44]
00fe6c32 4139583c cmp dword ptr [r8 + 0x3c], ebx
00fe6c36 7542 jne 0x140fe6c7a
00fe6c38 85d2 test edx, edx
00fe6c3a 743a je 0x140fe6c76
00fe6c3c 410fb64004 movzx eax, byte ptr [r8 + 4]
00fe6c41 2401 and al, 1
00fe6c43 85d2 test edx, edx
00fe6c45 7e33 jle 0x140fe6c7a
00fe6c47 413b502c cmp edx, dword ptr [r8 + 0x2c]
00fe6c4b 7f2d jg 0x140fe6c7a
00fe6c4d 84c0 test al, al
00fe6c4f 740e je 0x140fe6c5f
00fe6c51 498b4018 mov rax, qword ptr [r8 + 0x18]
00fe6c55 488b00 mov rax, qword ptr [rax]
00fe6c58 836c90fc01 sub dword ptr [rax + rdx*4 - 4], 1
00fe6c5d 7517 jne 0x140fe6c76
00fe6c5f 498b4010 mov rax, qword ptr [r8 + 0x10]
00fe6c63 488b08 mov rcx, qword ptr [rax]
00fe6c66 8b44d1fc mov eax, dword ptr [rcx + rdx*8 - 4]
00fe6c6a 41014040 add dword ptr [r8 + 0x40], eax
00fe6c6e c744d1f801000080 mov dword ptr [rcx + rdx*8 - 8], 0x80000001
00fe6c76 41895944 mov dword ptr [r9 + 0x44], ebx
00fe6c7a 488b442478 mov rax, qword ptr [rsp + 0x78]
00fe6c7f 488b4010 mov rax, qword ptr [rax + 0x10]
00fe6c83 498b5d60 mov rbx, qword ptr [r13 + 0x60]
00fe6c87 4885db test rbx, rbx
00fe6c8a 7418 je 0x140fe6ca4
00fe6c8c 0f1f4000 nop dword ptr [rax]
00fe6c90 483903 cmp qword ptr [rbx], rax
00fe6c93 742f je 0x140fe6cc4
00fe6c95 f6434b01 test byte ptr [rbx + 0x4b], 1
00fe6c99 7509 jne 0x140fe6ca4
00fe6c9b 488b5b38 mov rbx, qword ptr [rbx + 0x38]
00fe6c9f 4885db test rbx, rbx
00fe6ca2 75ec jne 0x140fe6c90
00fe6ca4 498bcd mov rcx, r13
00fe6ca7 e8c4260100 call 0x140ff9370
00fe6cac 488945a8 mov qword ptr [rbp - 0x58], rax
00fe6cb0 4885c0 test rax, rax
00fe6cb3 0f8524020000 jne 0x140fe6edd
00fe6cb9 41bcceffffff mov r12d, 0xffffffce
00fe6cbf e951030000 jmp 0x140fe7015
00fe6cc4 4d85ff test r15, r15
00fe6cc7 7403 je 0x140fe6ccc
00fe6cc9 49891f mov qword ptr [r15], rbx
00fe6ccc 488b7b30 mov rdi, qword ptr [rbx + 0x30]
00fe6cd0 4885ff test rdi, rdi
00fe6cd3 7428 je 0x140fe6cfd
00fe6cd5 48397710 cmp qword ptr [rdi + 0x10], rsi
00fe6cd9 7422 je 0x140fe6cfd
00fe6cdb 33d2 xor edx, edx
00fe6cdd 488bcf mov rcx, rdi
00fe6ce0 e88b9efbff call 0x140fa0b70
00fe6ce5 8bc8 mov ecx, eax
00fe6ce7 e8d4f2faff call 0x140f95fc0
00fe6cec 84c0 test al, al
00fe6cee 750d jne 0x140fe6cfd
00fe6cf0 f6879f00000004 test byte ptr [rdi + 0x9f], 4
00fe6cf7 0f8418030000 je 0x140fe7015
00fe6cfd 4889742468 mov qword ptr [rsp + 0x68], rsi
00fe6d02 4889742470 mov qword ptr [rsp + 0x70], rsi
00fe6d07 b928000000 mov ecx, 0x28
00fe6d0c e89f517b00 call 0x14179beb0
00fe6d11 488bf8 mov rdi, rax
00fe6d14 488900 mov qword ptr [rax], rax
00fe6d17 48894008 mov qword ptr [rax + 8], rax
00fe6d1b 48894010 mov qword ptr [rax + 0x10], rax
00fe6d1f 66c740180101 mov word ptr [rax + 0x18], 0x101
00fe6d25 4889442468 mov qword ptr [rsp + 0x68], rax
00fe6d2a 48894580 mov qword ptr [rbp - 0x80], rax
00fe6d2e 897588 mov dword ptr [rbp - 0x78], esi
00fe6d31 8b458c mov eax, dword ptr [rbp - 0x74]
00fe6d34 89458c mov dword ptr [rbp - 0x74], eax
00fe6d37 807f1900 cmp byte ptr [rdi + 0x19], 0
00fe6d3b 7506 jne 0x140fe6d43
00fe6d3d 483b5f20 cmp rbx, qword ptr [rdi + 0x20]
00fe6d41 735f jae 0x140fe6da2
00fe6d43 48b86666666666666606 movabs rax, 0x666666666666666
00fe6d4d 4839442470 cmp qword ptr [rsp + 0x70], rax
00fe6d52 0f847a070000 je 0x140fe74d2
00fe6d58 488d442468 lea rax, [rsp + 0x68]
00fe6d5d 4889442450 mov qword ptr [rsp + 0x50], rax
00fe6d62 4889742458 mov qword ptr [rsp + 0x58], rsi
00fe6d67 b928000000 mov ecx, 0x28
00fe6d6c e83f517b00 call 0x14179beb0
00fe6d71 90 nop 
00fe6d72 48895820 mov qword ptr [rax + 0x20], rbx
00fe6d76 488938 mov qword ptr [rax], rdi
00fe6d79 48897808 mov qword ptr [rax + 8], rdi
00fe6d7d 48897810 mov qword ptr [rax + 0x10], rdi
00fe6d81 66c740180000 mov word ptr [rax + 0x18], 0
00fe6d87 0f104580 movups xmm0, xmmword ptr [rbp - 0x80]
00fe6d8b 0f29442450 movaps xmmword ptr [rsp + 0x50], xmm0
00fe6d90 4c8bc0 mov r8, rax
00fe6d93 488d542450 lea rdx, [rsp + 0x50]
00fe6d98 488d4c2468 lea rcx, [rsp + 0x68]
00fe6d9d e8ced927ff call 0x140264770
00fe6da2 4889742450 mov qword ptr [rsp + 0x50], rsi
00fe6da7 4889742458 mov qword ptr [rsp + 0x58], rsi
00fe6dac 488d442450 lea rax, [rsp + 0x50]
00fe6db1 48894580 mov qword ptr [rbp - 0x80], rax
00fe6db5 488d442450 lea rax, [rsp + 0x50]
00fe6dba 48894588 mov qword ptr [rbp - 0x78], rax
00fe6dbe b928000000 mov ecx, 0x28
00fe6dc3 e8e8507b00 call 0x14179beb0
00fe6dc8 488900 mov qword ptr [rax], rax
00fe6dcb 48894008 mov qword ptr [rax + 8], rax
00fe6dcf 48894010 mov qword ptr [rax + 0x10], rax
00fe6dd3 66c740180101 mov word ptr [rax + 0x18], 0x101
00fe6dd9 4889442450 mov qword ptr [rsp + 0x50], rax
00fe6dde 4c8bc0 mov r8, rax
00fe6de1 488b542468 mov rdx, qword ptr [rsp + 0x68]
00fe6de6 488b5208 mov rdx, qword ptr [rdx + 8]
00fe6dea 488d4c2450 lea rcx, [rsp + 0x50]
00fe6def e82c662eff call 0x1402cd420
00fe6df4 488bc8 mov rcx, rax
00fe6df7 488b442450 mov rax, qword ptr [rsp + 0x50]
00fe6dfc 48894808 mov qword ptr [rax + 8], rcx
00fe6e00 488b442470 mov rax, qword ptr [rsp + 0x70]
00fe6e05 4889442458 mov qword ptr [rsp + 0x58], rax
00fe6e0a 4c8b442450 mov r8, qword ptr [rsp + 0x50]
00fe6e0f 498b5008 mov rdx, qword ptr [r8 + 8]
00fe6e13 807a1900 cmp byte ptr [rdx + 0x19], 0
00fe6e17 755a jne 0x140fe6e73
00fe6e19 488b0a mov rcx, qword ptr [rdx]
00fe6e1c 80791900 cmp byte ptr [rcx + 0x19], 0
00fe6e20 751d jne 0x140fe6e3f
00fe6e22 0f1f4000 nop dword ptr [rax]
00fe6e26 66660f1f840000000000 nop word ptr [rax + rax]
00fe6e30 488bd1 mov rdx, rcx
00fe6e33 488b01 mov rax, qword ptr [rcx]
00fe6e36 488bc8 mov rcx, rax
00fe6e39 80781900 cmp byte ptr [rax + 0x19], 0
00fe6e3d 74f1 je 0x140fe6e30
00fe6e3f 498910 mov qword ptr [r8], rdx
00fe6e42 488b542450 mov rdx, qword ptr [rsp + 0x50]
00fe6e47 488b4a08 mov rcx, qword ptr [rdx + 8]
00fe6e4b 488b4110 mov rax, qword ptr [rcx + 0x10]
00fe6e4f 80781900 cmp byte ptr [rax + 0x19], 0
00fe6e53 7518 jne 0x140fe6e6d
00fe6e55 6666660f1f840000000000 nop word ptr [rax + rax]
00fe6e60 488bc8 mov rcx, rax
00fe6e63 488b4010 mov rax, qword ptr [rax + 0x10]
00fe6e67 80781900 cmp byte ptr [rax + 0x19], 0
00fe6e6b 74f3 je 0x140fe6e60
00fe6e6d 48894a10 mov qword ptr [rdx + 0x10], rcx
00fe6e71 eb0c jmp 0x140fe6e7f
00fe6e73 4d8900 mov qword ptr [r8], r8
00fe6e76 488b442450 mov rax, qword ptr [rsp + 0x50]
00fe6e7b 48894010 mov qword ptr [rax + 0x10], rax
00fe6e7f 488d542450 lea rdx, [rsp + 0x50]
00fe6e84 e817dc0000 call 0x140ff4aa0
00fe6e89 90 nop 
00fe6e8a 488b4c2468 mov rcx, qword ptr [rsp + 0x68]
00fe6e8f 488b5908 mov rbx, qword ptr [rcx + 8]
00fe6e93 807b1900 cmp byte ptr [rbx + 0x19], 0
00fe6e97 7535 jne 0x140fe6ece
00fe6e99 0f1f8000000000 nop dword ptr [rax]
00fe6ea0 4c8b4310 mov r8, qword ptr [rbx + 0x10]
00fe6ea4 488d542468 lea rdx, [rsp + 0x68]
00fe6ea9 488d4c2468 lea rcx, [rsp + 0x68]
00fe6eae e8ed642eff call 0x1402cd3a0
00fe6eb3 488bcb mov rcx, rbx
00fe6eb6 488b1b mov rbx, qword ptr [rbx]
00fe6eb9 ba28000000 mov edx, 0x28
00fe6ebe e85dfbbdff call 0x140bc6a20
00fe6ec3 807b1900 cmp byte ptr [rbx + 0x19], 0
00fe6ec7 74d7 je 0x140fe6ea0
00fe6ec9 488b4c2468 mov rcx, qword ptr [rsp + 0x68]
00fe6ece ba28000000 mov edx, 0x28
00fe6ed3 e848fbbdff call 0x140bc6a20
00fe6ed8 e938010000 jmp 0x140fe7015
00fe6edd 33db xor ebx, ebx
00fe6edf 66895db0 mov word ptr [rbp - 0x50], bx
00fe6ee3 498b4d10 mov rcx, qword ptr [r13 + 0x10]
00fe6ee7 4885c9 test rcx, rcx
00fe6eea 741b je 0x140fe6f07
00fe6eec 4881c1c0010000 add rcx, 0x1c0
00fe6ef3 4c8d45b0 lea r8, [rbp - 0x50]
00fe6ef7 418b95bc000000 mov edx, dword ptr [r13 + 0xbc]
00fe6efe e86d85c1ff call 0x140bff470
00fe6f03 488b45a8 mov rax, qword ptr [rbp - 0x58]
00fe6f07 49c7c0ffffffff mov r8, 0xffffffffffffffff
00fe6f0e 6690 nop 
00fe6f10 49ffc0 inc r8
00fe6f13 42381c00 cmp byte ptr [rax + r8], bl
00fe6f17 75f7 jne 0x140fe6f10
00fe6f19 488d4c2440 lea rcx, [rsp + 0x40]
00fe6f1e 48894c2438 mov qword ptr [rsp + 0x38], rcx
00fe6f23 488d4c2450 lea rcx, [rsp + 0x50]
00fe6f28 48894c2430 mov qword ptr [rsp + 0x30], rcx
00fe6f2d 48895c2428 mov qword ptr [rsp + 0x28], rbx
00fe6f32 c7442420000000c0 mov dword ptr [rsp + 0x20], 0xc0000000
00fe6f3a 4c8d4db0 lea r9, [rbp - 0x50]
00fe6f3e 488bd0 mov rdx, rax
00fe6f41 488b4c2478 mov rcx, qword ptr [rsp + 0x78]
00fe6f46 e8f5e4ffff call 0x140fe5440
00fe6f4b 448be0 mov r12d, eax
00fe6f4e 4c8b742450 mov r14, qword ptr [rsp + 0x50]
00fe6f53 85c0 test eax, eax
00fe6f55 0f85ba000000 jne 0x140fe7015
00fe6f5b 4d85f6 test r14, r14
00fe6f5e 750b jne 0x140fe6f6b
00fe6f60 41bcceffffff mov r12d, 0xffffffce
00fe6f66 e9aa000000 jmp 0x140fe7015
00fe6f6b 41389ee8000000 cmp byte ptr [r14 + 0xe8], bl
00fe6f72 0f859d000000 jne 0x140fe7015
00fe6f78 385c2440 cmp byte ptr [rsp + 0x40], bl
00fe6f7c 0f84b3020000 je 0x140fe7235
00fe6f82 498b4e28 mov rcx, qword ptr [r14 + 0x28]
00fe6f86 e895b15fff call 0x1405e2120
00fe6f8b 488bd8 mov rbx, rax
00fe6f8e 4885c0 test rax, rax
00fe6f91 741c je 0x140fe6faf
00fe6f93 488bc8 mov rcx, rax
00fe6f96 e8b5f1fbff call 0x140fa6150
00fe6f9b 488b4f58 mov rcx, qword ptr [rdi + 0x58]
00fe6f9f 488b4110 mov rax, qword ptr [rcx + 0x10]
00fe6fa3 488b4b10 mov rcx, qword ptr [rbx + 0x10]
00fe6fa7 488b4058 mov rax, qword ptr [rax + 0x58]
00fe6fab 48894158 mov qword ptr [rcx + 0x58], rax
00fe6faf 498b4628 mov rax, qword ptr [r14 + 0x28]
00fe6fb3 4889442468 mov qword ptr [rsp + 0x68], rax
00fe6fb8 488b4058 mov rax, qword ptr [rax + 0x58]
00fe6fbc 4889442470 mov qword ptr [rsp + 0x70], rax
00fe6fc1 0f57c0 xorps xmm0, xmm0
00fe6fc4 f30f7f442450 movdqu xmmword ptr [rsp + 0x50], xmm0
00fe6fca 488d442450 lea rax, [rsp + 0x50]
00fe6fcf 4889442420 mov qword ptr [rsp + 0x20], rax
00fe6fd4 4533c9 xor r9d, r9d
00fe6fd7 4c8d442468 lea r8, [rsp + 0x68]
00fe6fdc 498bd5 mov rdx, r13
00fe6fdf 498b4e20 mov rcx, qword ptr [r14 + 0x20]
00fe6fe3 e898d1f0ff call 0x140ef4180
00fe6fe8 488bd8 mov rbx, rax
00fe6feb 4885f6 test rsi, rsi
00fe6fee 741d je 0x140fe700d
00fe6ff0 488b4e30 mov rcx, qword ptr [rsi + 0x30]
00fe6ff4 e867f0faff call 0x140f96060
00fe6ff9 84c0 test al, al
00fe6ffb 7408 je 0x140fe7005
00fe6ffd 498bce mov rcx, r14
00fe7000 e82bf9ffff call 0x140fe6930
00fe7005 488bce mov rcx, rsi
00fe7008 e8735ffdff call 0x140fbcf80
00fe700d 4d85ff test r15, r15
00fe7010 7403 je 0x140fe7015
00fe7012 49891f mov qword ptr [r15], rbx
00fe7015 488b4c2478 mov rcx, qword ptr [rsp + 0x78]
00fe701a e8712b0000 call 0x140fe9b90
00fe701f 4d85f6 test r14, r14
00fe7022 0f84a5010000 je 0x140fe71cd
00fe7028 41836e0c01 sub dword ptr [r14 + 0xc], 1
00fe702d 0f859a010000 jne 0x140fe71cd
00fe7033 41817e0864636370 cmp dword ptr [r14 + 8], 0x70636364
00fe703b 0f858c010000 jne 0x140fe71cd
00fe7041 41807e1800 cmp byte ptr [r14 + 0x18], 0
00fe7046 0f8581010000 jne 0x140fe71cd
00fe704c ba02000000 mov edx, 2
00fe7051 498bce mov rcx, r14
00fe7054 e897d60000 call 0x140ff46f0
00fe7059 49bf157c4a7fb979379e movabs r15, 0x9e3779b97f4a7c15
00fe7063 4d03fe add r15, r14
00fe7066 0f84c5000000 je 0x140fe7131
00fe706c e81f18b0ff call 0x140ae8890
00fe7071 488d5820 lea rbx, [rax + 0x20]
00fe7075 4885db test rbx, rbx
00fe7078 7426 je 0x140fe70a0
00fe707a 813b6b636f6c cmp dword ptr [rbx], 0x6c6f636b
00fe7080 751e jne 0x140fe70a0
00fe7082 ff1548379000 call qword ptr [rip + 0x903748]
00fe7088 8bf8 mov edi, eax
00fe708a 488d4b10 lea rcx, [rbx + 0x10]
00fe708e ff15143d9000 call qword ptr [rip + 0x903d14]
00fe7094 837b0800 cmp dword ptr [rbx + 8], 0
00fe7098 7503 jne 0x140fe709d
00fe709a 897b04 mov dword ptr [rbx + 4], edi
00fe709d ff4308 inc dword ptr [rbx + 8]
00fe70a0 e8eb17b0ff call 0x140ae8890
00fe70a5 488b7808 mov rdi, qword ptr [rax + 8]
00fe70a9 e8e217b0ff call 0x140ae8890
00fe70ae 488b30 mov rsi, qword ptr [rax]
00fe70b1 483bf7 cmp rsi, rdi
00fe70b4 7412 je 0x140fe70c8
00fe70b6 488b06 mov rax, qword ptr [rsi]
00fe70b9 4c3b7858 cmp r15, qword ptr [rax + 0x58]
00fe70bd 7409 je 0x140fe70c8
00fe70bf 4883c608 add rsi, 8
00fe70c3 483bf7 cmp rsi, rdi
00fe70c6 75ee jne 0x140fe70b6
00fe70c8 e8c317b0ff call 0x140ae8890
00fe70cd 483b7008 cmp rsi, qword ptr [rax + 8]
00fe70d1 742d je 0x140fe7100
00fe70d3 488b0e mov rcx, qword ptr [rsi]
00fe70d6 4885c9 test rcx, rcx
00fe70d9 7405 je 0x140fe70e0
00fe70db e85017b0ff call 0x140ae8830
00fe70e0 e8ab17b0ff call 0x140ae8890
00fe70e5 488bf8 mov rdi, rax
00fe70e8 488d5608 lea rdx, [rsi + 8]
00fe70ec 4c8b4008 mov r8, qword ptr [rax + 8]
00fe70f0 4c2bc2 sub r8, rdx
00fe70f3 488bce mov rcx, rsi
00fe70f6 e87a078800 call 0x141867875
00fe70fb 48834708f8 add qword ptr [rdi + 8], -8
00fe7100 4885db test rbx, rbx
00fe7103 742c je 0x140fe7131
00fe7105 813b6b636f6c cmp dword ptr [rbx], 0x6c6f636b
00fe710b 7524 jne 0x140fe7131
00fe710d ff15bd369000 call qword ptr [rip + 0x9036bd]
00fe7113 8b4b04 mov ecx, dword ptr [rbx + 4]
00fe7116 3bc8 cmp ecx, eax
00fe7118 7517 jne 0x140fe7131
00fe711a 834308ff add dword ptr [rbx + 8], -1
00fe711e 7507 jne 0x140fe7127
00fe7120 c74304ffffffff mov dword ptr [rbx + 4], 0xffffffff
00fe7127 488d4b10 lea rcx, [rbx + 0x10]
00fe712b ff157f3c9000 call qword ptr [rip + 0x903c7f]
00fe7131 498b4e38 mov rcx, qword ptr [r14 + 0x38]
00fe7135 4885c9 test rcx, rcx
00fe7138 7406 je 0x140fe7140
00fe713a ff1528529000 call qword ptr [rip + 0x905228]
00fe7140 498b4e70 mov rcx, qword ptr [r14 + 0x70]
00fe7144 4885c9 test rcx, rcx
00fe7147 7406 je 0x140fe714f
00fe7149 ff1519529000 call qword ptr [rip + 0x905219]
00fe714f 498b4e78 mov rcx, qword ptr [r14 + 0x78]
00fe7153 4885c9 test rcx, rcx
00fe7156 7406 je 0x140fe715e
00fe7158 ff150a529000 call qword ptr [rip + 0x90520a]
00fe715e 498b8e80000000 mov rcx, qword ptr [r14 + 0x80]
00fe7165 4885c9 test rcx, rcx
00fe7168 7406 je 0x140fe7170
00fe716a ff15f8519000 call qword ptr [rip + 0x9051f8]
00fe7170 498b8e88000000 mov rcx, qword ptr [r14 + 0x88]
00fe7177 4885c9 test rcx, rcx
00fe717a 7406 je 0x140fe7182
00fe717c ff15e6519000 call qword ptr [rip + 0x9051e6]
00fe7182 498b9ed0000000 mov rbx, qword ptr [r14 + 0xd0]
00fe7189 4885db test rbx, rbx
00fe718c 7420 je 0x140fe71ae
00fe718e 836b0401 sub dword ptr [rbx + 4], 1
00fe7192 751a jne 0x140fe71ae
00fe7194 488b4b18 mov rcx, qword ptr [rbx + 0x18]
00fe7198 e82307c1ff call 0x140bf78c0
00fe719d 33c0 xor eax, eax
00fe719f 8903 mov dword ptr [rbx], eax
00fe71a1 ba20000000 mov edx, 0x20
00fe71a6 488bcb mov rcx, rbx
00fe71a9 e872f8bdff call 0x140bc6a20
00fe71ae 33c0 xor eax, eax
00fe71b0 41894608 mov dword ptr [r14 + 8], eax
00fe71b4 498d8ea0000000 lea rcx, [r14 + 0xa0]
00fe71bb e8304874ff call 0x14072b9f0
00fe71c0 ba08010000 mov edx, 0x108
00fe71c5 498bce mov rcx, r14
00fe71c8 e853f8bdff call 0x140bc6a20
00fe71cd 488b45a8 mov rax, qword ptr [rbp - 0x58]
00fe71d1 4885c0 test rax, rax
00fe71d4 7409 je 0x140fe71df
00fe71d6 488bc8 mov rcx, rax
00fe71d9 ff1589519000 call qword ptr [rip + 0x905189]
00fe71df 4585e4 test r12d, r12d
00fe71e2 7424 je 0x140fe7208
00fe71e4 4d85ed test r13, r13
00fe71e7 741f je 0x140fe7208
00fe71e9 4180a59d000000bf and byte ptr [r13 + 0x9d], 0xbf
00fe71f1 418b85ac000000 mov eax, dword ptr [r13 + 0xac]
00fe71f8 85c0 test eax, eax
00fe71fa 740c je 0x140fe7208
00fe71fc 25fbffdfff and eax, 0xffdffffb
00fe7201 418985ac000000 mov dword ptr [r13 + 0xac], eax
00fe7208 418bc4 mov eax, r12d
00fe720b 488b8db0010000 mov rcx, qword ptr [rbp + 0x1b0]
00fe7212 4833cc xor rcx, rsp
00fe7215 e8c6467b00 call 0x14179b8e0
00fe721a 488b9c2410030000 mov rbx, qword ptr [rsp + 0x310]
00fe7222 4881c4c0020000 add rsp, 0x2c0
00fe7229 415f pop r15
00fe722b 415e pop r14
00fe722d 415d pop r13
00fe722f 415c pop r12
00fe7231 5f pop rdi
00fe7232 5e pop rsi
00fe7233 5d pop rbp
00fe7234 c3 ret 
00fe7235 498b4e20 mov rcx, qword ptr [r14 + 0x20]
00fe7239 4885c9 test rcx, rcx
00fe723c 7428 je 0x140fe7266
00fe723e 813974736c70 cmp dword ptr [rcx], 0x706c7374
00fe7244 7520 jne 0x140fe7266
00fe7246 488d8130010000 lea rax, [rcx + 0x130]
00fe724d 4885c0 test rax, rax
00fe7250 740b je 0x140fe725d
00fe7252 813863727473 cmp dword ptr [rax], 0x73747263
00fe7258 7503 jne 0x140fe725d
00fe725a ff403c inc dword ptr [rax + 0x3c]
00fe725d 488b4908 mov rcx, qword ptr [rcx + 8]
00fe7261 e84ab9eeff call 0x140ed2bb0
00fe7266 0f57c0 xorps xmm0, xmm0
00fe7269 33c0 xor eax, eax
00fe726b 0f114580 movups xmmword ptr [rbp - 0x80], xmm0
00fe726f 0f114590 movups xmmword ptr [rbp - 0x70], xmm0
00fe7273 488945a0 mov qword ptr [rbp - 0x60], rax
00fe7277 c6458001 mov byte ptr [rbp - 0x80], 1
00fe727b 498b4558 mov rax, qword ptr [r13 + 0x58]
00fe727f 4885c0 test rax, rax
00fe7282 0f84a0000000 je 0x140fe7328
00fe7288 488b4808 mov rcx, qword ptr [rax + 8]
00fe728c 4885c9 test rcx, rcx
00fe728f 0f8493000000 je 0x140fe7328
00fe7295 48395910 cmp qword ptr [rcx + 0x10], rbx
00fe7299 0f8489000000 je 0x140fe7328
00fe729f 48895d88 mov qword ptr [rbp - 0x78], rbx
00fe72a3 895d84 mov dword ptr [rbp - 0x7c], ebx
00fe72a6 8b4834 mov ecx, dword ptr [rax + 0x34]
00fe72a9 81f9454c4946 cmp ecx, 0x46494c45
00fe72af 741f je 0x140fe72d0
00fe72b1 81f950545448 cmp ecx, 0x48545450
00fe72b7 740e je 0x140fe72c7
00fe72b9 81f944524853 cmp ecx, 0x53485244
00fe72bf 7567 jne 0x140fe7328
00fe72c1 48634878 movsxd rcx, dword ptr [rax + 0x78]
00fe72c5 eb10 jmp 0x140fe72d7
00fe72c7 486388b8020000 movsxd rcx, dword ptr [rax + 0x2b8]
00fe72ce eb07 jmp 0x140fe72d7
00fe72d0 486388c0020000 movsxd rcx, dword ptr [rax + 0x2c0]
00fe72d7 488b90c8020000 mov rdx, qword ptr [rax + 0x2c8]
00fe72de 4885d2 test rdx, rdx
00fe72e1 7445 je 0x140fe7328
00fe72e3 813a63727473 cmp dword ptr [rdx], 0x73747263
00fe72e9 753d jne 0x140fe7328
00fe72eb 83f901 cmp ecx, 1
00fe72ee 7c38 jl 0x140fe7328
00fe72f0 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
00fe72f3 7f33 jg 0x140fe7328
00fe72f5 488b4210 mov rax, qword ptr [rdx + 0x10]
00fe72f9 4c8d41ff lea r8, [rcx - 1]
00fe72fd 488b00 mov rax, qword ptr [rax]
00fe7300 4e8d04c0 lea r8, [rax + r8*8]
00fe7304 4d85c0 test r8, r8
00fe7307 741f je 0x140fe7328
00fe7309 496308 movsxd rcx, dword ptr [r8]
00fe730c 85c9 test ecx, ecx
00fe730e 7818 js 0x140fe7328
00fe7310 41395804 cmp dword ptr [r8 + 4], ebx
00fe7314 7e12 jle 0x140fe7328
00fe7316 488b4220 mov rax, qword ptr [rdx + 0x20]
00fe731a 480308 add rcx, qword ptr [rax]
00fe731d 48894d88 mov qword ptr [rbp - 0x78], rcx
00fe7321 418b4004 mov eax, dword ptr [r8 + 4]
00fe7325 894584 mov dword ptr [rbp - 0x7c], eax
00fe7328 498b5510 mov rdx, qword ptr [r13 + 0x10]
00fe732c 4885d2 test rdx, rdx
00fe732f 7462 je 0x140fe7393
00fe7331 498b4568 mov rax, qword ptr [r13 + 0x68]
00fe7335 48634820 movsxd rcx, dword ptr [rax + 0x20]
00fe7339 4881c268050000 add rdx, 0x568
00fe7340 895d90 mov dword ptr [rbp - 0x70], ebx
00fe7343 48895d98 mov qword ptr [rbp - 0x68], rbx
00fe7347 744a je 0x140fe7393
00fe7349 813a63727473 cmp dword ptr [rdx], 0x73747263
00fe734f 7542 jne 0x140fe7393
00fe7351 395a3c cmp dword ptr [rdx + 0x3c], ebx
00fe7354 743d je 0x140fe7393
00fe7356 83f901 cmp ecx, 1
00fe7359 7c38 jl 0x140fe7393
00fe735b 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
00fe735e 7f33 jg 0x140fe7393
00fe7360 488b4210 mov rax, qword ptr [rdx + 0x10]
00fe7364 488b00 mov rax, qword ptr [rax]
00fe7367 4c8d41ff lea r8, [rcx - 1]
00fe736b 4e8d04c0 lea r8, [rax + r8*8]
00fe736f 4d85c0 test r8, r8
00fe7372 741f je 0x140fe7393
00fe7374 496308 movsxd rcx, dword ptr [r8]
00fe7377 85c9 test ecx, ecx
00fe7379 7818 js 0x140fe7393
00fe737b 41395804 cmp dword ptr [r8 + 4], ebx
00fe737f 7e12 jle 0x140fe7393
00fe7381 488b4220 mov rax, qword ptr [rdx + 0x20]
00fe7385 480308 add rcx, qword ptr [rax]
00fe7388 48894d98 mov qword ptr [rbp - 0x68], rcx
00fe738c 418b4004 mov eax, dword ptr [r8 + 4]
00fe7390 894590 mov dword ptr [rbp - 0x70], eax
00fe7393 498b7e28 mov rdi, qword ptr [r14 + 0x28]
00fe7397 4885ff test rdi, rdi
00fe739a 0f84d8000000 je 0x140fe7478
00fe73a0 488b07 mov rax, qword ptr [rdi]
00fe73a3 4885c0 test rax, rax
00fe73a6 0f84cc000000 je 0x140fe7478
00fe73ac 813874736c70 cmp dword ptr [rax], 0x706c7374
00fe73b2 0f85c0000000 jne 0x140fe7478
00fe73b8 395f28 cmp dword ptr [rdi + 0x28], ebx
00fe73bb 0f84b7000000 je 0x140fe7478
00fe73c1 4c8d4580 lea r8, [rbp - 0x80]
00fe73c5 33d2 xor edx, edx
00fe73c7 488bcf mov rcx, rdi
00fe73ca e801f4ffff call 0x140fe67d0
00fe73cf 85c0 test eax, eax
00fe73d1 0f85a1000000 jne 0x140fe7478
00fe73d7 f6474b01 test byte ptr [rdi + 0x4b], 1
00fe73db 0f8486000000 je 0x140fe7467
00fe73e1 488b07 mov rax, qword ptr [rdi]
00fe73e4 4885c0 test rax, rax
00fe73e7 747e je 0x140fe7467
00fe73e9 813874736c70 cmp dword ptr [rax], 0x706c7374
00fe73ef 7576 jne 0x140fe7467
00fe73f1 395f28 cmp dword ptr [rdi + 0x28], ebx
00fe73f4 7471 je 0x140fe7467
00fe73f6 4c8d4580 lea r8, [rbp - 0x80]
00fe73fa ba01000000 mov edx, 1
00fe73ff 488bcf mov rcx, rdi
00fe7402 e8c9f3ffff call 0x140fe67d0
00fe7407 85c0 test eax, eax
00fe7409 755c jne 0x140fe7467
00fe740b 488b5f50 mov rbx, qword ptr [rdi + 0x50]
00fe740f 4885db test rbx, rbx
00fe7412 7442 je 0x140fe7456
00fe7414 4c8d4580 lea r8, [rbp - 0x80]
00fe7418 ba02000000 mov edx, 2
00fe741d 488bcb mov rcx, rbx
00fe7420 e8abf3ffff call 0x140fe67d0
00fe7425 f6434b01 test byte ptr [rbx + 0x4b], 1
00fe7429 741e je 0x140fe7449
00fe742b 3d581b0000 cmp eax, 0x1b58
00fe7430 741b je 0x140fe744d
00fe7432 85c0 test eax, eax
00fe7434 7520 jne 0x140fe7456
00fe7436 4c8d4580 lea r8, [rbp - 0x80]
00fe743a 488d158ff3ffff lea rdx, [rip - 0xc71]
00fe7441 488bcb mov rcx, rbx
00fe7444 e8c77ff0ff call 0x140eef410
00fe7449 85c0 test eax, eax
00fe744b 7509 jne 0x140fe7456
00fe744d 488b5b10 mov rbx, qword ptr [rbx + 0x10]
00fe7451 4885db test rbx, rbx
00fe7454 75be jne 0x140fe7414
00fe7456 4c8d4580 lea r8, [rbp - 0x80]
00fe745a ba03000000 mov edx, 3
00fe745f 488bcf mov rcx, rdi
00fe7462 e869f3ffff call 0x140fe67d0
00fe7467 4c8d4580 lea r8, [rbp - 0x80]
00fe746b ba04000000 mov edx, 4
00fe7470 488bcf mov rcx, rdi
00fe7473 e858f3ffff call 0x140fe67d0
00fe7478 498b5620 mov rdx, qword ptr [r14 + 0x20]
00fe747c 4885d2 test rdx, rdx
00fe747f 7431 je 0x140fe74b2
00fe7481 813a74736c70 cmp dword ptr [rdx], 0x706c7374
00fe7487 7529 jne 0x140fe74b2
00fe7489 488d8a30010000 lea rcx, [rdx + 0x130]
00fe7490 4885c9 test rcx, rcx
00fe7493 7414 je 0x140fe74a9
00fe7495 813963727473 cmp dword ptr [rcx], 0x73747263
00fe749b 750c jne 0x140fe74a9
00fe749d 8b413c mov eax, dword ptr [rcx + 0x3c]
00fe74a0 85c0 test eax, eax
00fe74a2 7e05 jle 0x140fe74a9
00fe74a4 ffc8 dec eax
00fe74a6 89413c mov dword ptr [rcx + 0x3c], eax
00fe74a9 488b4a08 mov rcx, qword ptr [rdx + 8]
00fe74ad e82ebbeeff call 0x140ed2fe0
00fe74b2 488b75a0 mov rsi, qword ptr [rbp - 0x60]
00fe74b6 498b4628 mov rax, qword ptr [r14 + 0x28]
00fe74ba 4889442468 mov qword ptr [rsp + 0x68], rax
00fe74bf 4885f6 test rsi, rsi
00fe74c2 0f84f0faffff je 0x140fe6fb8
00fe74c8 4889742470 mov qword ptr [rsp + 0x70], rsi
00fe74cd e9effaffff jmp 0x140fe6fc1
00fe74d2 e869d627ff call 0x140264b40
00fe74d7 90 nop 