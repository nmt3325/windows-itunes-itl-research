00fb84a0 48895c2410 mov qword ptr [rsp + 0x10], rbx
00fb84a5 48896c2418 mov qword ptr [rsp + 0x18], rbp
00fb84aa 57 push rdi
00fb84ab 4881ec60020000 sub rsp, 0x260
00fb84b2 488bd9 mov rbx, rcx
00fb84b5 0fb6ea movzx ebp, dl
00fb84b8 488b4908 mov rcx, qword ptr [rcx + 8]
00fb84bc 807b4400 cmp byte ptr [rbx + 0x44], 0
00fb84c0 0f8599000000 jne 0x140fb855f
00fb84c6 8b4334 mov eax, dword ptr [rbx + 0x34]
00fb84c9 3d454c4946 cmp eax, 0x46494c45
00fb84ce 7552 jne 0x140fb8522
00fb84d0 33d2 xor edx, edx
00fb84d2 c6434401 mov byte ptr [rbx + 0x44], 1
00fb84d6 e89586feff call 0x140fa0b70
00fb84db a9620c0000 test eax, 0xc62
00fb84e0 747d je 0x140fb855f
00fb84e2 488b4308 mov rax, qword ptr [rbx + 8]
00fb84e6 40b701 mov dil, 1
00fb84e9 4885c0 test rax, rax
00fb84ec 742e je 0x140fb851c
00fb84ee 4883781000 cmp qword ptr [rax + 0x10], 0
00fb84f3 7427 je 0x140fb851c
00fb84f5 817b34454c4946 cmp dword ptr [rbx + 0x34], 0x46494c45
00fb84fc 751e jne 0x140fb851c
00fb84fe 488d542420 lea rdx, [rsp + 0x20]
00fb8503 488bcb mov rcx, rbx
00fb8506 e875a2f1ff call 0x140ed2780
00fb850b 85c0 test eax, eax
00fb850d 7508 jne 0x140fb8517
00fb850f 38442420 cmp byte ptr [rsp + 0x20], al
00fb8513 400f94c7 sete dil
00fb8517 4084ff test dil, dil
00fb851a 753f jne 0x140fb855b
00fb851c c6434402 mov byte ptr [rbx + 0x44], 2
00fb8520 eb3d jmp 0x140fb855f
00fb8522 3d50545448 cmp eax, 0x48545450
00fb8527 7511 jne 0x140fb853a
00fb8529 f6819b00000008 test byte ptr [rcx + 0x9b], 8
00fb8530 0f95c0 setne al
00fb8533 fec0 inc al
00fb8535 884344 mov byte ptr [rbx + 0x44], al
00fb8538 eb25 jmp 0x140fb855f
00fb853a 3d4c4e5744 cmp eax, 0x44574e4c
00fb853f 7506 jne 0x140fb8547
00fb8541 c6434400 mov byte ptr [rbx + 0x44], 0
00fb8545 eb18 jmp 0x140fb855f
00fb8547 3d44524853 cmp eax, 0x53485244
00fb854c 740d je 0x140fb855b
00fb854e 3d464d4552 cmp eax, 0x52454d46
00fb8553 7406 je 0x140fb855b
00fb8555 c6434402 mov byte ptr [rbx + 0x44], 2
00fb8559 eb04 jmp 0x140fb855f
00fb855b c6434401 mov byte ptr [rbx + 0x44], 1
00fb855f 807b4401 cmp byte ptr [rbx + 0x44], 1
00fb8563 757f jne 0x140fb85e4
00fb8565 4889b42470020000 mov qword ptr [rsp + 0x270], rsi
00fb856d 40b701 mov dil, 1
00fb8570 488b7308 mov rsi, qword ptr [rbx + 8]
00fb8574 4885f6 test rsi, rsi
00fb8577 745a je 0x140fb85d3
00fb8579 48837e1000 cmp qword ptr [rsi + 0x10], 0
00fb857e 7453 je 0x140fb85d3
00fb8580 33d2 xor edx, edx
00fb8582 488bce mov rcx, rsi
00fb8585 e8e685feff call 0x140fa0b70
00fb858a 8bc8 mov ecx, eax
00fb858c e82fdafdff call 0x140f95fc0
00fb8591 84c0 test al, al
00fb8593 753e jne 0x140fb85d3
00fb8595 f6869f00000004 test byte ptr [rsi + 0x9f], 4
00fb859c 7535 jne 0x140fb85d3
00fb859e f6869a00000002 test byte ptr [rsi + 0x9a], 2
00fb85a5 752c jne 0x140fb85d3
00fb85a7 f6434240 test byte ptr [rbx + 0x42], 0x40
00fb85ab 7405 je 0x140fb85b2
00fb85ad 4084ed test bpl, bpl
00fb85b0 7421 je 0x140fb85d3
00fb85b2 80be9d00000000 cmp byte ptr [rsi + 0x9d], 0
00fb85b9 7c18 jl 0x140fb85d3
00fb85bb 488bcb mov rcx, rbx
00fb85be e88dfeffff call 0x140fb8450
00fb85c3 84c0 test al, al
00fb85c5 740c je 0x140fb85d3
00fb85c7 0fb6433c movzx eax, byte ptr [rbx + 0x3c]
00fb85cb 3c02 cmp al, 2
00fb85cd 7404 je 0x140fb85d3
00fb85cf 3c03 cmp al, 3
00fb85d1 7503 jne 0x140fb85d6
00fb85d3 4032ff xor dil, dil
00fb85d6 488bb42470020000 mov rsi, qword ptr [rsp + 0x270]
00fb85de 400fb6c7 movzx eax, dil
00fb85e2 eb02 jmp 0x140fb85e6
00fb85e4 32c0 xor al, al
00fb85e6 4c8d9c2460020000 lea r11, [rsp + 0x260]
00fb85ee 498b5b18 mov rbx, qword ptr [r11 + 0x18]
00fb85f2 498b6b20 mov rbp, qword ptr [r11 + 0x20]
00fb85f6 498be3 mov rsp, r11
00fb85f9 5f pop rdi
00fb85fa c3 ret 