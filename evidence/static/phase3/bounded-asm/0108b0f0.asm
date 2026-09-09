0108b0f0 48895c2410 mov qword ptr [rsp + 0x10], rbx
0108b0f5 48896c2418 mov qword ptr [rsp + 0x18], rbp
0108b0fa 56 push rsi
0108b0fb 57 push rdi
0108b0fc 4154 push r12
0108b0fe 4156 push r14
0108b100 4157 push r15
0108b102 4883ec60 sub rsp, 0x60
0108b106 e8c548e4ff call 0x140ecf9d0
0108b10b 4c8bf8 mov r15, rax
0108b10e 4533e4 xor r12d, r12d
0108b111 458bf4 mov r14d, r12d
0108b114 4c89642430 mov qword ptr [rsp + 0x30], r12
0108b119 0f57c0 xorps xmm0, xmm0
0108b11c f30f7f442438 movdqu xmmword ptr [rsp + 0x38], xmm0
0108b122 4885c0 test rax, rax
0108b125 0f8477020000 je 0x14108b3a2
0108b12b 81b88000000074616474 cmp dword ptr [rax + 0x80], 0x74646174
0108b135 0f8567020000 jne 0x14108b3a2
0108b13b 488bb0d8000000 mov rsi, qword ptr [rax + 0xd8]
0108b142 4885f6 test rsi, rsi
0108b145 7412 je 0x14108b159
0108b147 ff1583f68500 call qword ptr [rip + 0x85f683]
0108b14d 8bc8 mov ecx, eax
0108b14f e88c4fb4ff call 0x140bd00e0
0108b154 ff460c inc dword ptr [rsi + 0xc]
0108b157 eb24 jmp 0x14108b17d
0108b159 4533c0 xor r8d, r8d
0108b15c 498bd7 mov rdx, r15
0108b15f b901000000 mov ecx, 1
0108b164 e847dfedff call 0x140f690b0
0108b169 488bf0 mov rsi, rax
0108b16c 4885c0 test rax, rax
0108b16f 7505 jne 0x14108b176
0108b171 498bf4 mov rsi, r12
0108b174 eb07 jmp 0x14108b17d
0108b176 498987d8000000 mov qword ptr [r15 + 0xd8], rax
0108b17d 4181bf8000000074616474 cmp dword ptr [r15 + 0x80], 0x74646174
0108b188 0f8541010000 jne 0x14108b2cf
0108b18e 498b9fe0000000 mov rbx, qword ptr [r15 + 0xe0]
0108b195 4885db test rbx, rbx
0108b198 0f8431010000 je 0x14108b2cf
0108b19e 6690 nop 
0108b1a0 488b6b38 mov rbp, qword ptr [rbx + 0x38]
0108b1a4 483bde cmp rbx, rsi
0108b1a7 0f8411010000 je 0x14108b2be
0108b1ad 837b1002 cmp dword ptr [rbx + 0x10], 2
0108b1b1 0f8507010000 jne 0x14108b2be
0108b1b7 4883bbf000000000 cmp qword ptr [rbx + 0xf0], 0
0108b1bf 740d je 0x14108b1ce
0108b1c1 83bbf800000000 cmp dword ptr [rbx + 0xf8], 0
0108b1c8 0f85f0000000 jne 0x14108b2be
0108b1ce 837b1401 cmp dword ptr [rbx + 0x14], 1
0108b1d2 0f86e6000000 jbe 0x14108b2be
0108b1d8 807b5800 cmp byte ptr [rbx + 0x58], 0
0108b1dc 7508 jne 0x14108b1e6
0108b1de 488bcb mov rcx, rbx
0108b1e1 e8ca940300 call 0x1410c46b0
0108b1e6 488b5b48 mov rbx, qword ptr [rbx + 0x48]
0108b1ea 4885db test rbx, rbx
0108b1ed 0f84cb000000 je 0x14108b2be
0108b1f3 48837b1000 cmp qword ptr [rbx + 0x10], 0
0108b1f8 750d jne 0x14108b207
0108b1fa 418bc4 mov eax, r12d
0108b1fd 4885db test rbx, rbx
0108b200 754b jne 0x14108b24d
0108b202 498bfc mov rdi, r12
0108b205 eb56 jmp 0x14108b25d
0108b207 f6839a00000001 test byte ptr [rbx + 0x9a], 1
0108b20e 7505 jne 0x14108b215
0108b210 418bc4 mov eax, r12d
0108b213 eb38 jmp 0x14108b24d
0108b215 488b4368 mov rax, qword ptr [rbx + 0x68]
0108b219 8b4010 mov eax, dword ptr [rax + 0x10]
0108b21c 85c0 test eax, eax
0108b21e 752d jne 0x14108b24d
0108b220 3983ac000000 cmp dword ptr [rbx + 0xac], eax
0108b226 751f jne 0x14108b247
0108b228 488bcb mov rcx, rbx
0108b22b e81060f0ff call 0x140f91240
0108b230 8983ac000000 mov dword ptr [rbx + 0xac], eax
0108b236 85c0 test eax, eax
0108b238 740d je 0x14108b247
0108b23a ba3c000000 mov edx, 0x3c
0108b23f 488bcb mov rcx, rbx
0108b242 e8b98ef0ff call 0x140f94100
0108b247 8b83ac000000 mov eax, dword ptr [rbx + 0xac]
0108b24d 48837b1000 cmp qword ptr [rbx + 0x10], 0
0108b252 7505 jne 0x14108b259
0108b254 498bfc mov rdi, r12
0108b257 eb04 jmp 0x14108b25d
0108b259 488b7b30 mov rdi, qword ptr [rbx + 0x30]
0108b25d a820 test al, 0x20
0108b25f 7451 je 0x14108b2b2
0108b261 4885db test rbx, rbx
0108b264 7420 je 0x14108b286
0108b266 4885f6 test rsi, rsi
0108b269 741b je 0x14108b286
0108b26b 817e0869626c61 cmp dword ptr [rsi + 8], 0x616c6269
0108b272 7512 jne 0x14108b286
0108b274 48837e3000 cmp qword ptr [rsi + 0x30], 0
0108b279 740b je 0x14108b286
0108b27b 488bd3 mov rdx, rbx
0108b27e 488bce mov rcx, rsi
0108b281 e85a11eeff call 0x140f6c3e0
0108b286 488b5b60 mov rbx, qword ptr [rbx + 0x60]
0108b28a 4885db test rbx, rbx
0108b28d 7423 je 0x14108b2b2
0108b28f 90 nop 
0108b290 4c8b03 mov r8, qword ptr [rbx]
0108b293 4983c048 add r8, 0x48
0108b297 4c8bcb mov r9, rbx
0108b29a 488d542448 lea rdx, [rsp + 0x48]
0108b29f 488d4c2430 lea rcx, [rsp + 0x30]
0108b2a4 e8c78260ff call 0x140693570
0108b2a9 488b5b38 mov rbx, qword ptr [rbx + 0x38]
0108b2ad 4885db test rbx, rbx
0108b2b0 75de jne 0x14108b290
0108b2b2 488bdf mov rbx, rdi
0108b2b5 4885ff test rdi, rdi
0108b2b8 0f8535ffffff jne 0x14108b1f3
0108b2be 488bdd mov rbx, rbp
0108b2c1 4885ed test rbp, rbp
0108b2c4 0f85d6feffff jne 0x14108b1a0
0108b2ca 4c8b742430 mov r14, qword ptr [rsp + 0x30]
0108b2cf 498bcf mov rcx, r15
0108b2d2 e889faffff call 0x14108ad60
0108b2d7 498bde mov rbx, r14
0108b2da 488b4c2438 mov rcx, qword ptr [rsp + 0x38]
0108b2df 4863f9 movsxd rdi, ecx
0108b2e2 48c1e704 shl rdi, 4
0108b2e6 4903fe add rdi, r14
0108b2e9 4c3bf7 cmp r14, rdi
0108b2ec 7416 je 0x14108b304
0108b2ee 6690 nop 
0108b2f0 8b03 mov eax, dword ptr [rbx]
0108b2f2 ffc0 inc eax
0108b2f4 a9feffffff test eax, 0xfffffffe
0108b2f9 7509 jne 0x14108b304
0108b2fb 4883c310 add rbx, 0x10
0108b2ff 483bdf cmp rbx, rdi
0108b302 75ec jne 0x14108b2f0
0108b304 4863c1 movsxd rax, ecx
0108b307 48c1e004 shl rax, 4
0108b30b 4903c6 add rax, r14
0108b30e 483bd8 cmp rbx, rax
0108b311 7460 je 0x14108b373
0108b313 4863e9 movsxd rbp, ecx
0108b316 48c1e504 shl rbp, 4
0108b31a 4903ee add rbp, r14
0108b31d 0f1f00 nop dword ptr [rax]
0108b320 4c8b4308 mov r8, qword ptr [rbx + 8]
0108b324 4d85c0 test r8, r8
0108b327 7422 je 0x14108b34b
0108b329 41813874736c70 cmp dword ptr [r8], 0x706c7374
0108b330 7519 jne 0x14108b34b
0108b332 498d8880000000 lea rcx, [r8 + 0x80]
0108b339 4c89642420 mov qword ptr [rsp + 0x20], r12
0108b33e 4533c9 xor r9d, r9d
0108b341 ba63706472 mov edx, 0x72647063
0108b346 e8d5a9a6ff call 0x140af5d20
0108b34b 4883c310 add rbx, 0x10
0108b34f 483bdf cmp rbx, rdi
0108b352 741a je 0x14108b36e
0108b354 488bcb mov rcx, rbx
0108b357 8b01 mov eax, dword ptr [rcx]
0108b359 85c0 test eax, eax
0108b35b 7405 je 0x14108b362
0108b35d 83f8ff cmp eax, -1
0108b360 750c jne 0x14108b36e
0108b362 488d5910 lea rbx, [rcx + 0x10]
0108b366 488bcb mov rcx, rbx
0108b369 483bdf cmp rbx, rdi
0108b36c 75e9 jne 0x14108b357
0108b36e 483bdd cmp rbx, rbp
0108b371 75ad jne 0x14108b320
0108b373 4885f6 test rsi, rsi
0108b376 742a je 0x14108b3a2
0108b378 ff1552f48500 call qword ptr [rip + 0x85f452]
0108b37e 8bc8 mov ecx, eax
0108b380 e85b4db4ff call 0x140bd00e0
0108b385 836e0c01 sub dword ptr [rsi + 0xc], 1
0108b389 7517 jne 0x14108b3a2
0108b38b 488bce mov rcx, rsi
0108b38e e87ddfedff call 0x140f69310
0108b393 488b06 mov rax, qword ptr [rsi]
0108b396 ba01000000 mov edx, 1
0108b39b 488bce mov rcx, rsi
0108b39e ff5008 call qword ptr [rax + 8]
0108b3a1 90 nop 
0108b3a2 498bce mov rcx, r14
0108b3a5 4c8d5c2460 lea r11, [rsp + 0x60]
0108b3aa 498b5b38 mov rbx, qword ptr [r11 + 0x38]
0108b3ae 498b6b40 mov rbp, qword ptr [r11 + 0x40]
0108b3b2 498be3 mov rsp, r11
0108b3b5 415f pop r15
0108b3b7 415e pop r14
0108b3b9 415c pop r12
0108b3bb 5f pop rdi
0108b3bc 5e pop rsi
0108b3bd 48ff257c0f8600 jmp qword ptr [rip + 0x860f7c]