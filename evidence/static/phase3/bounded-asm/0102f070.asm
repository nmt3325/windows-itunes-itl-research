0102f070 48896c2418 mov qword ptr [rsp + 0x18], rbp
0102f075 57 push rdi
0102f076 4156 push r14
0102f078 4157 push r15
0102f07a 4883ec20 sub rsp, 0x20
0102f07e 4532ff xor r15b, r15b
0102f081 410fb6e8 movzx ebp, r8b
0102f085 488bfa mov rdi, rdx
0102f088 4c8bf1 mov r14, rcx
0102f08b 4885c9 test rcx, rcx
0102f08e 0f84a3010000 je 0x14102f237
0102f094 813974736c70 cmp dword ptr [rcx], 0x706c7374
0102f09a 0f8597010000 jne 0x14102f237
0102f0a0 4885d2 test rdx, rdx
0102f0a3 0f848e010000 je 0x14102f237
0102f0a9 488b02 mov rax, qword ptr [rdx]
0102f0ac 4885c0 test rax, rax
0102f0af 0f8482010000 je 0x14102f237
0102f0b5 813874736c70 cmp dword ptr [rax], 0x706c7374
0102f0bb 0f8576010000 jne 0x14102f237
0102f0c1 837a2800 cmp dword ptr [rdx + 0x28], 0
0102f0c5 0f846c010000 je 0x14102f237
0102f0cb 488b4230 mov rax, qword ptr [rdx + 0x30]
0102f0cf 4885c0 test rax, rax
0102f0d2 7425 je 0x14102f0f9
0102f0d4 488b4010 mov rax, qword ptr [rax + 0x10]
0102f0d8 4885c0 test rax, rax
0102f0db 741c je 0x14102f0f9
0102f0dd 81b88000000074616474 cmp dword ptr [rax + 0x80], 0x74646174
0102f0e7 7510 jne 0x14102f0f9
0102f0e9 81b8840000006d656472 cmp dword ptr [rax + 0x84], 0x7264656d
0102f0f3 0f843e010000 je 0x14102f237
0102f0f9 48895c2440 mov qword ptr [rsp + 0x40], rbx
0102f0fe 488b5a30 mov rbx, qword ptr [rdx + 0x30]
0102f102 4889742448 mov qword ptr [rsp + 0x48], rsi
0102f107 4885db test rbx, rbx
0102f10a 744a je 0x14102f156
0102f10c 48837b1000 cmp qword ptr [rbx + 0x10], 0
0102f111 7443 je 0x14102f156
0102f113 f6839a00000001 test byte ptr [rbx + 0x9a], 1
0102f11a 743a je 0x14102f156
0102f11c 488b4368 mov rax, qword ptr [rbx + 0x68]
0102f120 8b7010 mov esi, dword ptr [rax + 0x10]
0102f123 85f6 test esi, esi
0102f125 7531 jne 0x14102f158
0102f127 39b3ac000000 cmp dword ptr [rbx + 0xac], esi
0102f12d 751f jne 0x14102f14e
0102f12f 488bcb mov rcx, rbx
0102f132 e80921f6ff call 0x140f91240
0102f137 8983ac000000 mov dword ptr [rbx + 0xac], eax
0102f13d 85c0 test eax, eax
0102f13f 740d je 0x14102f14e
0102f141 ba3c000000 mov edx, 0x3c
0102f146 488bcb mov rcx, rbx
0102f149 e8b24ff6ff call 0x140f94100
0102f14e 8bb3ac000000 mov esi, dword ptr [rbx + 0xac]
0102f154 eb02 jmp 0x14102f158
0102f156 33f6 xor esi, esi
0102f158 488bd7 mov rdx, rdi
0102f15b 498bce mov rcx, r14
0102f15e e83d351200 call 0x1411526a0
0102f163 84c0 test al, al
0102f165 0f84af000000 je 0x14102f21a
0102f16b 4084ed test bpl, bpl
0102f16e 0f85a3000000 jne 0x14102f217
0102f174 498b5e08 mov rbx, qword ptr [r14 + 8]
0102f178 4885db test rbx, rbx
0102f17b 0f8499000000 je 0x14102f21a
0102f181 81bb8000000074616474 cmp dword ptr [rbx + 0x80], 0x74646174
0102f18b 0f8589000000 jne 0x14102f21a
0102f191 488b9bb8000000 mov rbx, qword ptr [rbx + 0xb8]
0102f198 4885db test rbx, rbx
0102f19b 747d je 0x14102f21a
0102f19d 0f1f00 nop dword ptr [rax]
0102f1a0 493bde cmp rbx, r14
0102f1a3 740e je 0x14102f1b3
0102f1a5 8bd6 mov edx, esi
0102f1a7 488bcb mov rcx, rbx
0102f1aa e881c1cfff call 0x140d2b330
0102f1af 84c0 test al, al
0102f1b1 7564 jne 0x14102f217
0102f1b3 813b74736c70 cmp dword ptr [rbx], 0x706c7374
0102f1b9 755f jne 0x14102f21a
0102f1bb 488b4b38 mov rcx, qword ptr [rbx + 0x38]
0102f1bf 4885c9 test rcx, rcx
0102f1c2 752e jne 0x14102f1f2
0102f1c4 488b4b20 mov rcx, qword ptr [rbx + 0x20]
0102f1c8 4885c9 test rcx, rcx
0102f1cb 7525 jne 0x14102f1f2
0102f1cd 488b4318 mov rax, qword ptr [rbx + 0x18]
0102f1d1 4885c0 test rax, rax
0102f1d4 741c je 0x14102f1f2
0102f1d6 488b4820 mov rcx, qword ptr [rax + 0x20]
0102f1da 4885c9 test rcx, rcx
0102f1dd 7513 jne 0x14102f1f2
0102f1df 90 nop 
0102f1e0 488b4018 mov rax, qword ptr [rax + 0x18]
0102f1e4 4885c0 test rax, rax
0102f1e7 7409 je 0x14102f1f2
0102f1e9 488b4820 mov rcx, qword ptr [rax + 0x20]
0102f1ed 4885c9 test rcx, rcx
0102f1f0 74ee je 0x14102f1e0
0102f1f2 488bd9 mov rbx, rcx
0102f1f5 4885c9 test rcx, rcx
0102f1f8 75a6 jne 0x14102f1a0
0102f1fa 488b742448 mov rsi, qword ptr [rsp + 0x48]
0102f1ff 410fb6c7 movzx eax, r15b
0102f203 488b5c2440 mov rbx, qword ptr [rsp + 0x40]
0102f208 488b6c2450 mov rbp, qword ptr [rsp + 0x50]
0102f20d 4883c420 add rsp, 0x20
0102f211 415f pop r15
0102f213 415e pop r14
0102f215 5f pop rdi
0102f216 c3 ret 
0102f217 41b701 mov r15b, 1
0102f21a 488b742448 mov rsi, qword ptr [rsp + 0x48]
0102f21f 410fb6c7 movzx eax, r15b
0102f223 488b5c2440 mov rbx, qword ptr [rsp + 0x40]
0102f228 488b6c2450 mov rbp, qword ptr [rsp + 0x50]
0102f22d 4883c420 add rsp, 0x20
0102f231 415f pop r15
0102f233 415e pop r14
0102f235 5f pop rdi
0102f236 c3 ret 
0102f237 488b6c2450 mov rbp, qword ptr [rsp + 0x50]
0102f23c 32c0 xor al, al
0102f23e 4883c420 add rsp, 0x20
0102f242 415f pop r15
0102f244 415e pop r14
0102f246 5f pop rdi
0102f247 c3 ret 