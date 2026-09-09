00fda1e0 4c894c2420 mov qword ptr [rsp + 0x20], r9
00fda1e5 48894c2408 mov qword ptr [rsp + 8], rcx
00fda1ea 55 push rbp
00fda1eb 57 push rdi
00fda1ec 4883ec58 sub rsp, 0x58
00fda1f0 498be8 mov rbp, r8
00fda1f3 4c8bd2 mov r10, rdx
00fda1f6 4885c9 test rcx, rcx
00fda1f9 0f84b5020000 je 0x140fda4b4
00fda1ff f6410401 test byte ptr [rcx + 4], 1
00fda203 0f84ab020000 je 0x140fda4b4
00fda209 4885d2 test rdx, rdx
00fda20c 0f84a2020000 je 0x140fda4b4
00fda212 4d85c0 test r8, r8
00fda215 0f8499020000 je 0x140fda4b4
00fda21b 4d85c9 test r9, r9
00fda21e 0f8490020000 je 0x140fda4b4
00fda224 33ff xor edi, edi
00fda226 4c89642448 mov qword ptr [rsp + 0x48], r12
00fda22b 448be7 mov r12d, edi
00fda22e 4c896c2440 mov qword ptr [rsp + 0x40], r13
00fda233 448bef mov r13d, edi
00fda236 4c89742438 mov qword ptr [rsp + 0x38], r14
00fda23b 448bf7 mov r14d, edi
00fda23e 49397820 cmp qword ptr [r8 + 0x20], rdi
00fda242 750a jne 0x140fda24e
00fda244 bfceffffff mov edi, 0xffffffce
00fda249 e94e020000 jmp 0x140fda49c
00fda24e 418839 mov byte ptr [r9], dil
00fda251 41897834 mov dword ptr [r8 + 0x34], edi
00fda255 40387908 cmp byte ptr [rcx + 8], dil
00fda259 75e9 jne 0x140fda244
00fda25b 488b5118 mov rdx, qword ptr [rcx + 0x18]
00fda25f 4885d2 test rdx, rdx
00fda262 74e0 je 0x140fda244
00fda264 83792044 cmp dword ptr [rcx + 0x20], 0x44
00fda268 75da jne 0x140fda244
00fda26a 8b12 mov edx, dword ptr [rdx]
00fda26c 4c8d05ad880101 lea r8, [rip + 0x10188ad]
00fda273 498bc8 mov rcx, r8
00fda276 4c897c2430 mov qword ptr [rsp + 0x30], r15
00fda27b 8bc7 mov eax, edi
00fda27d 0f1f00 nop dword ptr [rax]
00fda280 8511 test dword ptr [rcx], edx
00fda282 750d jne 0x140fda291
00fda284 ffc0 inc eax
00fda286 4883c10c add rcx, 0xc
00fda28a 83f808 cmp eax, 8
00fda28d 72f1 jb 0x140fda280
00fda28f eb4a jmp 0x140fda2db
00fda291 488d0c40 lea rcx, [rax + rax*2]
00fda295 498d0488 lea rax, [r8 + rcx*4]
00fda299 4885c0 test rax, rax
00fda29c 743d je 0x140fda2db
00fda29e 8b08 mov ecx, dword ptr [rax]
00fda2a0 448b6004 mov r12d, dword ptr [rax + 4]
00fda2a4 448b6808 mov r13d, dword ptr [rax + 8]
00fda2a8 83f902 cmp ecx, 2
00fda2ab 750d jne 0x140fda2ba
00fda2ad 40387d09 cmp byte ptr [rbp + 9], dil
00fda2b1 741a je 0x140fda2cd
00fda2b3 410fbaec0a bts r12d, 0xa
00fda2b8 eb13 jmp 0x140fda2cd
00fda2ba 83f901 cmp ecx, 1
00fda2bd 750e jne 0x140fda2cd
00fda2bf 0fbae21e bt edx, 0x1e
00fda2c3 7308 jae 0x140fda2cd
00fda2c5 4183cc08 or r12d, 8
00fda2c9 4183e5f7 and r13d, 0xfffffff7
00fda2cd 85d2 test edx, edx
00fda2cf 790a jns 0x140fda2db
00fda2d1 410fbaec10 bts r12d, 0x10
00fda2d6 410fbaf510 btr r13d, 0x10
00fda2db 498bca mov rcx, r10
00fda2de e8ed55f1ff call 0x140eef8d0
00fda2e3 4889442420 mov qword ptr [rsp + 0x20], rax
00fda2e8 4c8bf8 mov r15, rax
00fda2eb 4885c0 test rax, rax
00fda2ee 0f8480010000 je 0x140fda474
00fda2f4 48895c2478 mov qword ptr [rsp + 0x78], rbx
00fda2f9 ba20000000 mov edx, 0x20
00fda2fe 4889742450 mov qword ptr [rsp + 0x50], rsi
00fda303 41b810000000 mov r8d, 0x10
00fda309 41b908000000 mov r9d, 8
00fda30f 41bb02000000 mov r11d, 2
00fda315 6666660f1f840000000000 nop word ptr [rax + rax]
00fda320 498b07 mov rax, qword ptr [r15]
00fda323 4885c0 test rax, rax
00fda326 0f8418010000 je 0x140fda444
00fda32c 813874736c70 cmp dword ptr [rax], 0x706c7374
00fda332 0f850c010000 jne 0x140fda444
00fda338 41397f28 cmp dword ptr [r15 + 0x28], edi
00fda33c 0f8402010000 je 0x140fda444
00fda342 498b5f30 mov rbx, qword ptr [r15 + 0x30]
00fda346 4885db test rbx, rbx
00fda349 0f84f5000000 je 0x140fda444
00fda34f 488b7358 mov rsi, qword ptr [rbx + 0x58]
00fda353 4885f6 test rsi, rsi
00fda356 0f84e8000000 je 0x140fda444
00fda35c 41bf01000000 mov r15d, 1
00fda362 488b4d20 mov rcx, qword ptr [rbp + 0x20]
00fda366 488b01 mov rax, qword ptr [rcx]
00fda369 4c8b9048020000 mov r10, qword ptr [rax + 0x248]
00fda370 8b4528 mov eax, dword ptr [rbp + 0x28]
00fda373 83e802 sub eax, 2
00fda376 743a je 0x140fda3b2
00fda378 412bc7 sub eax, r15d
00fda37b 7423 je 0x140fda3a0
00fda37d 412bc7 sub eax, r15d
00fda380 7434 je 0x140fda3b6
00fda382 412bc7 sub eax, r15d
00fda385 7413 je 0x140fda39a
00fda387 413bc7 cmp eax, r15d
00fda38a 7406 je 0x140fda392
00fda38c 450fb7c7 movzx r8d, r15w
00fda390 eb24 jmp 0x140fda3b6
00fda392 41b840000000 mov r8d, 0x40
00fda398 eb1c jmp 0x140fda3b6
00fda39a 440fb7c2 movzx r8d, dx
00fda39e eb16 jmp 0x140fda3b6
00fda3a0 837d2c05 cmp dword ptr [rbp + 0x2c], 5
00fda3a4 7506 jne 0x140fda3ac
00fda3a6 450fb7c7 movzx r8d, r15w
00fda3aa eb0a jmp 0x140fda3b6
00fda3ac 450fb7c1 movzx r8d, r9w
00fda3b0 eb04 jmp 0x140fda3b6
00fda3b2 450fb7c3 movzx r8d, r11w
00fda3b6 448b4d30 mov r9d, dword ptr [rbp + 0x30]
00fda3ba 488bd6 mov rdx, rsi
00fda3bd 41ffd2 call r10
00fda3c0 84c0 test al, al
00fda3c2 7458 je 0x140fda41c
00fda3c4 48397b10 cmp qword ptr [rbx + 0x10], rdi
00fda3c8 7443 je 0x140fda40d
00fda3ca 4484bb9a000000 test byte ptr [rbx + 0x9a], r15b
00fda3d1 743a je 0x140fda40d
00fda3d3 488b4368 mov rax, qword ptr [rbx + 0x68]
00fda3d7 8b4010 mov eax, dword ptr [rax + 0x10]
00fda3da 85c0 test eax, eax
00fda3dc 7531 jne 0x140fda40f
00fda3de 39bbac000000 cmp dword ptr [rbx + 0xac], edi
00fda3e4 751f jne 0x140fda405
00fda3e6 488bcb mov rcx, rbx
00fda3e9 e8526efbff call 0x140f91240
00fda3ee 8983ac000000 mov dword ptr [rbx + 0xac], eax
00fda3f4 85c0 test eax, eax
00fda3f6 740d je 0x140fda405
00fda3f8 ba3c000000 mov edx, 0x3c
00fda3fd 488bcb mov rcx, rbx
00fda400 e8fb9cfbff call 0x140f94100
00fda405 8b83ac000000 mov eax, dword ptr [rbx + 0xac]
00fda40b eb02 jmp 0x140fda40f
00fda40d 8bc7 mov eax, edi
00fda40f 4185c4 test r12d, eax
00fda412 7408 je 0x140fda41c
00fda414 4185c5 test r13d, eax
00fda417 7503 jne 0x140fda41c
00fda419 41ffc6 inc r14d
00fda41c 488b36 mov rsi, qword ptr [rsi]
00fda41f ba20000000 mov edx, 0x20
00fda424 41b810000000 mov r8d, 0x10
00fda42a 41b908000000 mov r9d, 8
00fda430 41bb02000000 mov r11d, 2
00fda436 4885f6 test rsi, rsi
00fda439 0f8523ffffff jne 0x140fda362
00fda43f 4c8b7c2420 mov r15, qword ptr [rsp + 0x20]
00fda444 498bcf mov rcx, r15
00fda447 e80455f1ff call 0x140eef950
00fda44c 4889442420 mov qword ptr [rsp + 0x20], rax
00fda451 4c8bf8 mov r15, rax
00fda454 ba20000000 mov edx, 0x20
00fda459 4885c0 test rax, rax
00fda45c 0f85befeffff jne 0x140fda320
00fda462 488b742450 mov rsi, qword ptr [rsp + 0x50]
00fda467 488b5c2478 mov rbx, qword ptr [rsp + 0x78]
00fda46c 4c8b8c2488000000 mov r9, qword ptr [rsp + 0x88]
00fda474 488b4c2470 mov rcx, qword ptr [rsp + 0x70]
00fda479 4585f6 test r14d, r14d
00fda47c 4c8b7c2430 mov r15, qword ptr [rsp + 0x30]
00fda481 0f95c2 setne dl
00fda484 44897534 mov dword ptr [rbp + 0x34], r14d
00fda488 8b4904 mov ecx, dword ptr [rcx + 4]
00fda48b c1e919 shr ecx, 0x19
00fda48e f6c101 test cl, 1
00fda491 7406 je 0x140fda499
00fda493 4585f6 test r14d, r14d
00fda496 0f94c2 sete dl
00fda499 418811 mov byte ptr [r9], dl
00fda49c 4c8b742438 mov r14, qword ptr [rsp + 0x38]
00fda4a1 8bc7 mov eax, edi
00fda4a3 4c8b6c2440 mov r13, qword ptr [rsp + 0x40]
00fda4a8 4c8b642448 mov r12, qword ptr [rsp + 0x48]
00fda4ad 4883c458 add rsp, 0x58
00fda4b1 5f pop rdi
00fda4b2 5d pop rbp
00fda4b3 c3 ret 
00fda4b4 b8ceffffff mov eax, 0xffffffce
00fda4b9 4883c458 add rsp, 0x58
00fda4bd 5f pop rdi
00fda4be 5d pop rbp
00fda4bf c3 ret 