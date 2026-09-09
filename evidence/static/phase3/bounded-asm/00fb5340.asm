00fb5340 4055 push rbp
00fb5342 56 push rsi
00fb5343 4156 push r14
00fb5345 4883ec20 sub rsp, 0x20
00fb5349 4032ed xor bpl, bpl
00fb534c 440fb6f2 movzx r14d, dl
00fb5350 488bf1 mov rsi, rcx
00fb5353 4885c9 test rcx, rcx
00fb5356 750b jne 0x140fb5363
00fb5358 32c0 xor al, al
00fb535a 4883c420 add rsp, 0x20
00fb535e 415e pop r14
00fb5360 5e pop rsi
00fb5361 5d pop rbp
00fb5362 c3 ret 
00fb5363 488b05c61b0f01 mov rax, qword ptr [rip + 0x10f1bc6]
00fb536a 4885c0 test rax, rax
00fb536d 7409 je 0x140fb5378
00fb536f 488b8890410100 mov rcx, qword ptr [rax + 0x14190]
00fb5376 eb02 jmp 0x140fb537a
00fb5378 33c9 xor ecx, ecx
00fb537a 4038a98b050000 cmp byte ptr [rcx + 0x58b], bpl
00fb5381 0f857b010000 jne 0x140fb5502
00fb5387 813e54534c4f cmp dword ptr [rsi], 0x4f4c5354
00fb538d 0f856f010000 jne 0x140fb5502
00fb5393 837e0400 cmp dword ptr [rsi + 4], 0
00fb5397 0f8465010000 je 0x140fb5502
00fb539d 48895c2448 mov qword ptr [rsp + 0x48], rbx
00fb53a2 48b8abaaaaaaaaaaaaaa movabs rax, 0xaaaaaaaaaaaaaaab
00fb53ac 488b5e10 mov rbx, qword ptr [rsi + 0x10]
00fb53b0 482b5e08 sub rbx, qword ptr [rsi + 8]
00fb53b4 48c1fb04 sar rbx, 4
00fb53b8 480fafd8 imul rbx, rax
00fb53bc 48897c2450 mov qword ptr [rsp + 0x50], rdi
00fb53c1 33ff xor edi, edi
00fb53c3 85db test ebx, ebx
00fb53c5 0f842d010000 je 0x140fb54f8
00fb53cb 0f1f440000 nop dword ptr [rax + rax]
00fb53d0 8bd7 mov edx, edi
00fb53d2 488bce mov rcx, rsi
00fb53d5 e8e68732ff call 0x1402ddbc0
00fb53da 488bd0 mov rdx, rax
00fb53dd 4885c0 test rax, rax
00fb53e0 0f8403010000 je 0x140fb54e9
00fb53e6 4c8b00 mov r8, qword ptr [rax]
00fb53e9 4d85c0 test r8, r8
00fb53ec 7443 je 0x140fb5431
00fb53ee 41813874736c70 cmp dword ptr [r8], 0x706c7374
00fb53f5 753a jne 0x140fb5431
00fb53f7 83782800 cmp dword ptr [rax + 0x28], 0
00fb53fb 7434 je 0x140fb5431
00fb53fd 488b4830 mov rcx, qword ptr [rax + 0x30]
00fb5401 4883c030 add rax, 0x30
00fb5405 4885c9 test rcx, rcx
00fb5408 742b je 0x140fb5435
00fb540a 488b4910 mov rcx, qword ptr [rcx + 0x10]
00fb540e 4885c9 test rcx, rcx
00fb5411 7422 je 0x140fb5435
00fb5413 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
00fb541d 7516 jne 0x140fb5435
00fb541f 81b9840000006d656472 cmp dword ptr [rcx + 0x84], 0x7264656d
00fb5429 0f84ba000000 je 0x140fb54e9
00fb542f eb04 jmp 0x140fb5435
00fb5431 4883c030 add rax, 0x30
00fb5435 0fb6524b movzx edx, byte ptr [rdx + 0x4b]
00fb5439 80e201 and dl, 1
00fb543c 4584f6 test r14b, r14b
00fb543f 7460 je 0x140fb54a1
00fb5441 84d2 test dl, dl
00fb5443 0f85a0000000 jne 0x140fb54e9
00fb5449 488b10 mov rdx, qword ptr [rax]
00fb544c 4885d2 test rdx, rdx
00fb544f 0f8494000000 je 0x140fb54e9
00fb5455 498bc8 mov rcx, r8
00fb5458 e883840000 call 0x140fbd8e0
00fb545d 84c0 test al, al
00fb545f 0f8484000000 je 0x140fb54e9
00fb5465 48837a1000 cmp qword ptr [rdx + 0x10], 0
00fb546a 742f je 0x140fb549b
00fb546c f6829a00000004 test byte ptr [rdx + 0x9a], 4
00fb5473 7426 je 0x140fb549b
00fb5475 488b05b41a0f01 mov rax, qword ptr [rip + 0x10f1ab4]
00fb547c 4885c0 test rax, rax
00fb547f 7409 je 0x140fb548a
00fb5481 488b8890410100 mov rcx, qword ptr [rax + 0x14190]
00fb5488 eb02 jmp 0x140fb548c
00fb548a 33c9 xor ecx, ecx
00fb548c 4038a98b050000 cmp byte ptr [rcx + 0x58b], bpl
00fb5493 7506 jne 0x140fb549b
00fb5495 b001 mov al, 1
00fb5497 84c0 test al, al
00fb5499 eb4c jmp 0x140fb54e7
00fb549b 32c0 xor al, al
00fb549d 84c0 test al, al
00fb549f eb46 jmp 0x140fb54e7
00fb54a1 84d2 test dl, dl
00fb54a3 7550 jne 0x140fb54f5
00fb54a5 488b10 mov rdx, qword ptr [rax]
00fb54a8 4885d2 test rdx, rdx
00fb54ab 7448 je 0x140fb54f5
00fb54ad 498bc8 mov rcx, r8
00fb54b0 e82b840000 call 0x140fbd8e0
00fb54b5 84c0 test al, al
00fb54b7 743c je 0x140fb54f5
00fb54b9 48837a1000 cmp qword ptr [rdx + 0x10], 0
00fb54be 7435 je 0x140fb54f5
00fb54c0 f6829a00000004 test byte ptr [rdx + 0x9a], 4
00fb54c7 742c je 0x140fb54f5
00fb54c9 488b05601a0f01 mov rax, qword ptr [rip + 0x10f1a60]
00fb54d0 4885c0 test rax, rax
00fb54d3 7409 je 0x140fb54de
00fb54d5 488b8890410100 mov rcx, qword ptr [rax + 0x14190]
00fb54dc eb02 jmp 0x140fb54e0
00fb54de 33c9 xor ecx, ecx
00fb54e0 4038a98b050000 cmp byte ptr [rcx + 0x58b], bpl
00fb54e7 750c jne 0x140fb54f5
00fb54e9 ffc7 inc edi
00fb54eb 3bfb cmp edi, ebx
00fb54ed 0f82ddfeffff jb 0x140fb53d0
00fb54f3 eb03 jmp 0x140fb54f8
00fb54f5 40b501 mov bpl, 1
00fb54f8 488b5c2448 mov rbx, qword ptr [rsp + 0x48]
00fb54fd 488b7c2450 mov rdi, qword ptr [rsp + 0x50]
00fb5502 400fb6c5 movzx eax, bpl
00fb5506 4883c420 add rsp, 0x20
00fb550a 415e pop r14
00fb550c 5e pop rsi
00fb550d 5d pop rbp
00fb550e c3 ret 