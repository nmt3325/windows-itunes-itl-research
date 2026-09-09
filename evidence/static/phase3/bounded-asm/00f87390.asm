00f87390 48895c2410 mov qword ptr [rsp + 0x10], rbx
00f87395 48894c2408 mov qword ptr [rsp + 8], rcx
00f8739a 57 push rdi
00f8739b 4883ec20 sub rsp, 0x20
00f8739f 488bd9 mov rbx, rcx
00f873a2 488b09 mov rcx, qword ptr [rcx]
00f873a5 4885c9 test rcx, rcx
00f873a8 7542 jne 0x140f873ec
00f873aa 488b5b08 mov rbx, qword ptr [rbx + 8]
00f873ae 4885db test rbx, rbx
00f873b1 742c je 0x140f873df
00f873b3 bfffffffff mov edi, 0xffffffff
00f873b8 8bc7 mov eax, edi
00f873ba f00fc14308 lock xadd dword ptr [rbx + 8], eax
00f873bf 83f801 cmp eax, 1
00f873c2 751b jne 0x140f873df
00f873c4 488b03 mov rax, qword ptr [rbx]
00f873c7 488bcb mov rcx, rbx
00f873ca ff10 call qword ptr [rax]
00f873cc f00fc17b0c lock xadd dword ptr [rbx + 0xc], edi
00f873d1 83ff01 cmp edi, 1
00f873d4 7509 jne 0x140f873df
00f873d6 488b03 mov rax, qword ptr [rbx]
00f873d9 488bcb mov rcx, rbx
00f873dc ff5008 call qword ptr [rax + 8]
00f873df 32c0 xor al, al
00f873e1 488b5c2438 mov rbx, qword ptr [rsp + 0x38]
00f873e6 4883c420 add rsp, 0x20
00f873ea 5f pop rdi
00f873eb c3 ret 
00f873ec 488b01 mov rax, qword ptr [rcx]
00f873ef ff5050 call qword ptr [rax + 0x50]
00f873f2 488bd0 mov rdx, rax
00f873f5 4885c0 test rax, rax
00f873f8 0f8484000000 je 0x140f87482
00f873fe f6404b01 test byte ptr [rax + 0x4b], 1
00f87402 755c jne 0x140f87460
00f87404 4c8b4030 mov r8, qword ptr [rax + 0x30]
00f87408 4d85c0 test r8, r8
00f8740b 7453 je 0x140f87460
00f8740d 488b08 mov rcx, qword ptr [rax]
00f87410 e8cb640300 call 0x140fbd8e0
00f87415 84c0 test al, al
00f87417 7447 je 0x140f87460
00f87419 4983781000 cmp qword ptr [r8 + 0x10], 0
00f8741e 742e je 0x140f8744e
00f87420 41f6809a00000004 test byte ptr [r8 + 0x9a], 4
00f87428 7424 je 0x140f8744e
00f8742a 488b05fffa1101 mov rax, qword ptr [rip + 0x111faff]
00f87431 4885c0 test rax, rax
00f87434 7409 je 0x140f8743f
00f87436 488b8890410100 mov rcx, qword ptr [rax + 0x14190]
00f8743d eb02 jmp 0x140f87441
00f8743f 33c9 xor ecx, ecx
00f87441 80b98b05000000 cmp byte ptr [rcx + 0x58b], 0
00f87448 7504 jne 0x140f8744e
00f8744a b001 mov al, 1
00f8744c eb02 jmp 0x140f87450
00f8744e 32c0 xor al, al
00f87450 84c0 test al, al
00f87452 740c je 0x140f87460
00f87454 488bca mov rcx, rdx
00f87457 e864620300 call 0x140fbd6c0
00f8745c 84c0 test al, al
00f8745e 740d je 0x140f8746d
00f87460 488b0b mov rcx, qword ptr [rbx]
00f87463 488b01 mov rax, qword ptr [rcx]
00f87466 ff5040 call qword ptr [rax + 0x40]
00f87469 84c0 test al, al
00f8746b 7515 jne 0x140f87482
00f8746d 488bcb mov rcx, rbx
00f87470 e89ba82cff call 0x140251d10
00f87475 32c0 xor al, al
00f87477 488b5c2438 mov rbx, qword ptr [rsp + 0x38]
00f8747c 4883c420 add rsp, 0x20
00f87480 5f pop rdi
00f87481 c3 ret 
00f87482 488bcb mov rcx, rbx
00f87485 e886a82cff call 0x140251d10
00f8748a b001 mov al, 1
00f8748c 488b5c2438 mov rbx, qword ptr [rsp + 0x38]
00f87491 4883c420 add rsp, 0x20
00f87495 5f pop rdi
00f87496 c3 ret 