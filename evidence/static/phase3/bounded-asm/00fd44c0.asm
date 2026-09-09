00fd44c0 48895c2410 mov qword ptr [rsp + 0x10], rbx
00fd44c5 57 push rdi
00fd44c6 4881ec30020000 sub rsp, 0x230
00fd44cd 488b056c0b0001 mov rax, qword ptr [rip + 0x1000b6c]
00fd44d4 4833c4 xor rax, rsp
00fd44d7 4889842420020000 mov qword ptr [rsp + 0x220], rax
00fd44df 33ff xor edi, edi
00fd44e1 488bd9 mov rbx, rcx
00fd44e4 4885c9 test rcx, rcx
00fd44e7 0f840d010000 je 0x140fd45fa
00fd44ed 48397910 cmp qword ptr [rcx + 0x10], rdi
00fd44f1 744d je 0x140fd4540
00fd44f3 f6819a00000001 test byte ptr [rcx + 0x9a], 1
00fd44fa 7444 je 0x140fd4540
00fd44fc 488b4168 mov rax, qword ptr [rcx + 0x68]
00fd4500 8b4810 mov ecx, dword ptr [rax + 0x10]
00fd4503 85c9 test ecx, ecx
00fd4505 752d jne 0x140fd4534
00fd4507 39bbac000000 cmp dword ptr [rbx + 0xac], edi
00fd450d 751f jne 0x140fd452e
00fd450f 488bcb mov rcx, rbx
00fd4512 e829cdfbff call 0x140f91240
00fd4517 8983ac000000 mov dword ptr [rbx + 0xac], eax
00fd451d 85c0 test eax, eax
00fd451f 740d je 0x140fd452e
00fd4521 ba3c000000 mov edx, 0x3c
00fd4526 488bcb mov rcx, rbx
00fd4529 e8d2fbfbff call 0x140f94100
00fd452e 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
00fd4534 f7c10800c000 test ecx, 0xc00008
00fd453a 0f85ba000000 jne 0x140fd45fa
00fd4540 488b4368 mov rax, qword ptr [rbx + 0x68]
00fd4544 8b5030 mov edx, dword ptr [rax + 0x30]
00fd4547 85d2 test edx, edx
00fd4549 7469 je 0x140fd45b4
00fd454b 488b4b10 mov rcx, qword ptr [rbx + 0x10]
00fd454f 66897c2420 mov word ptr [rsp + 0x20], di
00fd4554 4885c9 test rcx, rcx
00fd4557 7411 je 0x140fd456a
00fd4559 4881c118070000 add rcx, 0x718
00fd4560 4c8d442420 lea r8, [rsp + 0x20]
00fd4565 e806afc2ff call 0x140bff470
00fd456a ba02000000 mov edx, 2
00fd456f 488d4c2420 lea rcx, [rsp + 0x20]
00fd4574 448bc2 mov r8d, edx
00fd4577 4533c9 xor r9d, r9d
00fd457a e8b10e0d00 call 0x1410a5430
00fd457f 84c0 test al, al
00fd4581 7407 je 0x140fd458a
00fd4583 bfc8000000 mov edi, 0xc8
00fd4588 eb70 jmp 0x140fd45fa
00fd458a 4533c9 xor r9d, r9d
00fd458d 488d4c2420 lea rcx, [rsp + 0x20]
00fd4592 ba09000000 mov edx, 9
00fd4597 41b802000000 mov r8d, 2
00fd459d e88e0e0d00 call 0x1410a5430
00fd45a2 84c0 test al, al
00fd45a4 7407 je 0x140fd45ad
00fd45a6 bfb3000000 mov edi, 0xb3
00fd45ab eb4d jmp 0x140fd45fa
00fd45ad bfe6000000 mov edi, 0xe6
00fd45b2 eb46 jmp 0x140fd45fa
00fd45b4 0fb68390000000 movzx eax, byte ptr [rbx + 0x90]
00fd45bb 84c0 test al, al
00fd45bd 743b je 0x140fd45fa
00fd45bf 3c02 cmp al, 2
00fd45c1 7507 jne 0x140fd45ca
00fd45c3 bfb4000000 mov edi, 0xb4
00fd45c8 eb30 jmp 0x140fd45fa
00fd45ca 488b055f290d01 mov rax, qword ptr [rip + 0x10d295f]
00fd45d1 4885c0 test rax, rax
00fd45d4 7408 je 0x140fd45de
00fd45d6 4805a0470100 add rax, 0x147a0
00fd45dc eb07 jmp 0x140fd45e5
00fd45de 488d05bb230f01 lea rax, [rip + 0x10f23bb]
00fd45e5 80b83c02000001 cmp byte ptr [rax + 0x23c], 1
00fd45ec b9b5000000 mov ecx, 0xb5
00fd45f1 bfb3000000 mov edi, 0xb3
00fd45f6 660f44f9 cmove di, cx
00fd45fa 0fb7c7 movzx eax, di
00fd45fd 488b8c2420020000 mov rcx, qword ptr [rsp + 0x220]
00fd4605 4833cc xor rcx, rsp
00fd4608 e8d3727c00 call 0x14179b8e0
00fd460d 488b9c2448020000 mov rbx, qword ptr [rsp + 0x248]
00fd4615 4881c430020000 add rsp, 0x230
00fd461c 5f pop rdi
00fd461d c3 ret 