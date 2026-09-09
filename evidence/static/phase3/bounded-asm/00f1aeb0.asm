00f1aeb0 4c8bdc mov r11, rsp
00f1aeb3 53 push rbx
00f1aeb4 55 push rbp
00f1aeb5 57 push rdi
00f1aeb6 4881ec60020000 sub rsp, 0x260
00f1aebd 410fb6e8 movzx ebp, r8b
00f1aec1 488bda mov rbx, rdx
00f1aec4 488bf9 mov rdi, rcx
00f1aec7 4885c9 test rcx, rcx
00f1aeca 0f847a030000 je 0x140f1b24a
00f1aed0 81791074696e64 cmp dword ptr [rcx + 0x10], 0x646e6974
00f1aed7 0f856d030000 jne 0x140f1b24a
00f1aedd 4d897320 mov qword ptr [r11 + 0x20], r14
00f1aee1 4885d2 test rdx, rdx
00f1aee4 7518 jne 0x140f1aefe
00f1aee6 41beceffffff mov r14d, 0xffffffce
00f1aeec 418bc6 mov eax, r14d
00f1aeef 4d8b7320 mov r14, qword ptr [r11 + 0x20]
00f1aef3 4881c460020000 add rsp, 0x260
00f1aefa 5f pop rdi
00f1aefb 5d pop rbp
00f1aefc 5b pop rbx
00f1aefd c3 ret 
00f1aefe c74234454c4946 mov dword ptr [rdx + 0x34], 0x46494c45
00f1af05 4c8d442420 lea r8, [rsp + 0x20]
00f1af0a 4889b42490020000 mov qword ptr [rsp + 0x290], rsi
00f1af12 488b7208 mov rsi, qword ptr [rdx + 8]
00f1af16 ba454c4946 mov edx, 0x46494c45
00f1af1b e8b0fdffff call 0x140f1acd0
00f1af20 448bf0 mov r14d, eax
00f1af23 85c0 test eax, eax
00f1af25 0f8501030000 jne 0x140f1b22c
00f1af2b 488d4b78 lea rcx, [rbx + 0x78]
00f1af2f 4885c9 test rcx, rcx
00f1af32 0f8489000000 je 0x140f1afc1
00f1af38 488d542420 lea rdx, [rsp + 0x20]
00f1af3d 41b804000000 mov r8d, 4
00f1af43 0f1f4000 nop dword ptr [rax]
00f1af47 660f1f840000000000 nop word ptr [rax + rax]
00f1af50 488d8980000000 lea rcx, [rcx + 0x80]
00f1af57 0f1002 movups xmm0, xmmword ptr [rdx]
00f1af5a 0f104a10 movups xmm1, xmmword ptr [rdx + 0x10]
00f1af5e 488d9280000000 lea rdx, [rdx + 0x80]
00f1af65 0f114180 movups xmmword ptr [rcx - 0x80], xmm0
00f1af69 0f1042a0 movups xmm0, xmmword ptr [rdx - 0x60]
00f1af6d 0f114990 movups xmmword ptr [rcx - 0x70], xmm1
00f1af71 0f104ab0 movups xmm1, xmmword ptr [rdx - 0x50]
00f1af75 0f1141a0 movups xmmword ptr [rcx - 0x60], xmm0
00f1af79 0f1042c0 movups xmm0, xmmword ptr [rdx - 0x40]
00f1af7d 0f1149b0 movups xmmword ptr [rcx - 0x50], xmm1
00f1af81 0f104ad0 movups xmm1, xmmword ptr [rdx - 0x30]
00f1af85 0f1141c0 movups xmmword ptr [rcx - 0x40], xmm0
00f1af89 0f1042e0 movups xmm0, xmmword ptr [rdx - 0x20]
00f1af8d 0f1149d0 movups xmmword ptr [rcx - 0x30], xmm1
00f1af91 0f104af0 movups xmm1, xmmword ptr [rdx - 0x10]
00f1af95 0f1141e0 movups xmmword ptr [rcx - 0x20], xmm0
00f1af99 0f1149f0 movups xmmword ptr [rcx - 0x10], xmm1
00f1af9d 4983e801 sub r8, 1
00f1afa1 75ad jne 0x140f1af50
00f1afa3 0f1002 movups xmm0, xmmword ptr [rdx]
00f1afa6 0f104a10 movups xmm1, xmmword ptr [rdx + 0x10]
00f1afaa 0f1101 movups xmmword ptr [rcx], xmm0
00f1afad 0f104220 movups xmm0, xmmword ptr [rdx + 0x20]
00f1afb1 0f114910 movups xmmword ptr [rcx + 0x10], xmm1
00f1afb5 0f104a30 movups xmm1, xmmword ptr [rdx + 0x30]
00f1afb9 0f114120 movups xmmword ptr [rcx + 0x20], xmm0
00f1afbd 0f114930 movups xmmword ptr [rcx + 0x30], xmm1
00f1afc1 4883bbc802000000 cmp qword ptr [rbx + 0x2c8], 0
00f1afc9 c6433c01 mov byte ptr [rbx + 0x3c], 1
00f1afcd 754a jne 0x140f1b019
00f1afcf 488b4308 mov rax, qword ptr [rbx + 8]
00f1afd3 4885c0 test rax, rax
00f1afd6 7441 je 0x140f1b019
00f1afd8 488b4810 mov rcx, qword ptr [rax + 0x10]
00f1afdc 4885c9 test rcx, rcx
00f1afdf 7438 je 0x140f1b019
00f1afe1 448b05f8371e01 mov r8d, dword ptr [rip + 0x11e37f8]
00f1afe8 b81f85eb51 mov eax, 0x51eb851f
00f1afed 41ffc0 inc r8d
00f1aff0 41f7e0 mul r8d
00f1aff3 448905e6371e01 mov dword ptr [rip + 0x11e37e6], r8d
00f1affa c1ea04 shr edx, 4
00f1affd 6bc232 imul eax, edx, 0x32
00f1b000 442bc0 sub r8d, eax
00f1b003 4a8d04c52b010000 lea rax, [r8*8 + 0x12b]
00f1b00b 4903c0 add rax, r8
00f1b00e 488d04c1 lea rax, [rcx + rax*8]
00f1b012 488983c8020000 mov qword ptr [rbx + 0x2c8], rax
00f1b019 488bcf mov rcx, rdi
00f1b01c e8ef90ffff call 0x140f14110
00f1b021 488bcb mov rcx, rbx
00f1b024 e8b7edf9ff call 0x140eb9de0
00f1b029 80a69d000000f7 and byte ptr [rsi + 0x9d], 0xf7
00f1b030 80a69a000000fd and byte ptr [rsi + 0x9a], 0xfd
00f1b037 4084ed test bpl, bpl
00f1b03a 0f84ec010000 je 0x140f1b22c
00f1b040 488b7b08 mov rdi, qword ptr [rbx + 8]
00f1b044 4885ff test rdi, rdi
00f1b047 0f84df010000 je 0x140f1b22c
00f1b04d 488b7f10 mov rdi, qword ptr [rdi + 0x10]
00f1b051 4885ff test rdi, rdi
00f1b054 0f84d2010000 je 0x140f1b22c
00f1b05a f6871301000004 test byte ptr [rdi + 0x113], 4
00f1b061 0f84c5010000 je 0x140f1b22c
00f1b067 488b4320 mov rax, qword ptr [rbx + 0x20]
00f1b06b 488b4808 mov rcx, qword ptr [rax + 8]
00f1b06f 4883f9fd cmp rcx, -3
00f1b073 7438 je 0x140f1b0ad
00f1b075 7736 ja 0x140f1b0ad
00f1b077 4885c9 test rcx, rcx
00f1b07a 7431 je 0x140f1b0ad
00f1b07c 488bcf mov rcx, rdi
00f1b07f e82cff0900 call 0x140fbafb0
00f1b084 84c0 test al, al
00f1b086 750c jne 0x140f1b094
00f1b088 488bcf mov rcx, rdi
00f1b08b e8e0ff0900 call 0x140fbb070
00f1b090 84c0 test al, al
00f1b092 7419 je 0x140f1b0ad
00f1b094 81bf8400000073727672 cmp dword ptr [rdi + 0x84], 0x72767273
00f1b09e 740d je 0x140f1b0ad
00f1b0a0 488bcb mov rcx, rbx
00f1b0a3 e83888faff call 0x140ec38e0
00f1b0a8 e951010000 jmp 0x140f1b1fe
00f1b0ad 488b4b08 mov rcx, qword ptr [rbx + 8]
00f1b0b1 32d2 xor dl, dl
00f1b0b3 4885c9 test rcx, rcx
00f1b0b6 747a je 0x140f1b132
00f1b0b8 4883791000 cmp qword ptr [rcx + 0x10], 0
00f1b0bd 7473 je 0x140f1b132
00f1b0bf 488b4310 mov rax, qword ptr [rbx + 0x10]
00f1b0c3 4883783800 cmp qword ptr [rax + 0x38], 0
00f1b0c8 7468 je 0x140f1b132
00f1b0ca 8b4334 mov eax, dword ptr [rbx + 0x34]
00f1b0cd 3d454c4946 cmp eax, 0x46494c45
00f1b0d2 7436 je 0x140f1b10a
00f1b0d4 3d4c4e5744 cmp eax, 0x44574e4c
00f1b0d9 742f je 0x140f1b10a
00f1b0db 3d44524853 cmp eax, 0x53485244
00f1b0e0 7546 jne 0x140f1b128
00f1b0e2 33d2 xor edx, edx
00f1b0e4 e8875a0800 call 0x140fa0b70
00f1b0e9 8d48fe lea ecx, [rax - 2]
00f1b0ec 83f93e cmp ecx, 0x3e
00f1b0ef 7710 ja 0x140f1b101
00f1b0f1 48ba0100004000000040 movabs rdx, 0x4000000040000001
00f1b0fb 480fa3ca bt rdx, rcx
00f1b0ff 7225 jb 0x140f1b126
00f1b101 3d02800000 cmp eax, 0x8002
00f1b106 756f jne 0x140f1b177
00f1b108 eb1c jmp 0x140f1b126
00f1b10a 488b4168 mov rax, qword ptr [rcx + 0x68]
00f1b10e 0fb64801 movzx ecx, byte ptr [rax + 1]
00f1b112 80f909 cmp cl, 9
00f1b115 740f je 0x140f1b126
00f1b117 80f90f cmp cl, 0xf
00f1b11a 775b ja 0x140f1b177
00f1b11c b840840000 mov eax, 0x8440
00f1b121 0fa3c8 bt eax, ecx
00f1b124 7351 jae 0x140f1b177
00f1b126 b201 mov dl, 1
00f1b128 84d2 test dl, dl
00f1b12a 0f85c6000000 jne 0x140f1b1f6
00f1b130 eb45 jmp 0x140f1b177
00f1b132 488b4310 mov rax, qword ptr [rbx + 0x10]
00f1b136 83786800 cmp dword ptr [rax + 0x68], 0
00f1b13a 743b je 0x140f1b177
00f1b13c 8b4334 mov eax, dword ptr [rbx + 0x34]
00f1b13f 3d454c4946 cmp eax, 0x46494c45
00f1b144 7407 je 0x140f1b14d
00f1b146 3d44524853 cmp eax, 0x53485244
00f1b14b 752a jne 0x140f1b177
00f1b14d 33d2 xor edx, edx
00f1b14f e81c5a0800 call 0x140fa0b70
00f1b154 8d48fe lea ecx, [rax - 2]
00f1b157 83f93e cmp ecx, 0x3e
00f1b15a 7714 ja 0x140f1b170
00f1b15c 48ba0100004000000040 movabs rdx, 0x4000000040000001
00f1b166 480fa3ca bt rdx, rcx
00f1b16a 0f8286000000 jb 0x140f1b1f6
00f1b170 3d02800000 cmp eax, 0x8002
00f1b175 747f je 0x140f1b1f6
00f1b177 488b4b08 mov rcx, qword ptr [rbx + 8]
00f1b17b 4885c9 test rcx, rcx
00f1b17e 7440 je 0x140f1b1c0
00f1b180 4883791000 cmp qword ptr [rcx + 0x10], 0
00f1b185 7439 je 0x140f1b1c0
00f1b187 488b4310 mov rax, qword ptr [rbx + 0x10]
00f1b18b 4883783800 cmp qword ptr [rax + 0x38], 0
00f1b190 742e je 0x140f1b1c0
00f1b192 8b4334 mov eax, dword ptr [rbx + 0x34]
00f1b195 3d454c4946 cmp eax, 0x46494c45
00f1b19a 750a jne 0x140f1b1a6
00f1b19c 488b4168 mov rax, qword ptr [rcx + 0x68]
00f1b1a0 80780119 cmp byte ptr [rax + 1], 0x19
00f1b1a4 eb13 jmp 0x140f1b1b9
00f1b1a6 3d44524853 cmp eax, 0x53485244
00f1b1ab 7513 jne 0x140f1b1c0
00f1b1ad 33d2 xor edx, edx
00f1b1af e8bc590800 call 0x140fa0b70
00f1b1b4 3d00004000 cmp eax, 0x400000
00f1b1b9 0f94c0 sete al
00f1b1bc 84c0 test al, al
00f1b1be 7536 jne 0x140f1b1f6
00f1b1c0 8b4334 mov eax, dword ptr [rbx + 0x34]
00f1b1c3 3d454c4946 cmp eax, 0x46494c45
00f1b1c8 7407 je 0x140f1b1d1
00f1b1ca 3d44524853 cmp eax, 0x53485244
00f1b1cf 755b jne 0x140f1b22c
00f1b1d1 488b4308 mov rax, qword ptr [rbx + 8]
00f1b1d5 4885c0 test rax, rax
00f1b1d8 7412 je 0x140f1b1ec
00f1b1da 4883781000 cmp qword ptr [rax + 0x10], 0
00f1b1df 740b je 0x140f1b1ec
00f1b1e1 488b4310 mov rax, qword ptr [rbx + 0x10]
00f1b1e5 4883783800 cmp qword ptr [rax + 0x38], 0
00f1b1ea 750a jne 0x140f1b1f6
00f1b1ec 488b4310 mov rax, qword ptr [rbx + 0x10]
00f1b1f0 83786800 cmp dword ptr [rax + 0x68], 0
00f1b1f4 7436 je 0x140f1b22c
00f1b1f6 488bcb mov rcx, rbx
00f1b1f9 e80284faff call 0x140ec3600
00f1b1fe 488bf8 mov rdi, rax
00f1b201 4885c0 test rax, rax
00f1b204 7426 je 0x140f1b22c
00f1b206 488b4b08 mov rcx, qword ptr [rbx + 8]
00f1b20a 33d2 xor edx, edx
00f1b20c e81ff347ff call 0x14039a530
00f1b211 488b4b08 mov rcx, qword ptr [rbx + 8]
00f1b215 4533c0 xor r8d, r8d
00f1b218 84c0 test al, al
00f1b21a 7408 je 0x140f1b224
00f1b21c 488bd1 mov rdx, rcx
00f1b21f 488bcf mov rcx, rdi
00f1b222 eb03 jmp 0x140f1b227
00f1b224 488bd7 mov rdx, rdi
00f1b227 e8a45b0800 call 0x140fa0dd0
00f1b22c 488bb42490020000 mov rsi, qword ptr [rsp + 0x290]
00f1b234 418bc6 mov eax, r14d
00f1b237 4c8bb42498020000 mov r14, qword ptr [rsp + 0x298]
00f1b23f 4881c460020000 add rsp, 0x260
00f1b246 5f pop rdi
00f1b247 5d pop rbp
00f1b248 5b pop rbx
00f1b249 c3 ret 
00f1b24a b8491f0000 mov eax, 0x1f49
00f1b24f 4881c460020000 add rsp, 0x260
00f1b256 5f pop rdi
00f1b257 5d pop rbp
00f1b258 5b pop rbx
00f1b259 c3 ret 