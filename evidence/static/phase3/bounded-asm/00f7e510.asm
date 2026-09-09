00f7e510 4053 push rbx
00f7e512 4883ec20 sub rsp, 0x20
00f7e516 488b01 mov rax, qword ptr [rcx]
00f7e519 ff5078 call qword ptr [rax + 0x78]
00f7e51c 488bd8 mov rbx, rax
00f7e51f 4885c0 test rax, rax
00f7e522 0f8495000000 je 0x140f7e5bd
00f7e528 81780869626c61 cmp dword ptr [rax + 8], 0x616c6269
00f7e52f 0f8588000000 jne 0x140f7e5bd
00f7e535 4883783000 cmp qword ptr [rax + 0x30], 0
00f7e53a 0f847d000000 je 0x140f7e5bd
00f7e540 80785800 cmp byte ptr [rax + 0x58], 0
00f7e544 7508 jne 0x140f7e54e
00f7e546 488bc8 mov rcx, rax
00f7e549 e862611400 call 0x1410c46b0
00f7e54e 488b5b48 mov rbx, qword ptr [rbx + 0x48]
00f7e552 4885db test rbx, rbx
00f7e555 7466 je 0x140f7e5bd
00f7e557 48837b1000 cmp qword ptr [rbx + 0x10], 0
00f7e55c 7447 je 0x140f7e5a5
00f7e55e f6839a00000001 test byte ptr [rbx + 0x9a], 1
00f7e565 7443 je 0x140f7e5aa
00f7e567 488b4368 mov rax, qword ptr [rbx + 0x68]
00f7e56b 8b4810 mov ecx, dword ptr [rax + 0x10]
00f7e56e 85c9 test ecx, ecx
00f7e570 752d jne 0x140f7e59f
00f7e572 398bac000000 cmp dword ptr [rbx + 0xac], ecx
00f7e578 751f jne 0x140f7e599
00f7e57a 488bcb mov rcx, rbx
00f7e57d e8be2c0100 call 0x140f91240
00f7e582 8983ac000000 mov dword ptr [rbx + 0xac], eax
00f7e588 85c0 test eax, eax
00f7e58a 740d je 0x140f7e599
00f7e58c ba3c000000 mov edx, 0x3c
00f7e591 488bcb mov rcx, rbx
00f7e594 e8675b0100 call 0x140f94100
00f7e599 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
00f7e59f 0fbae110 bt ecx, 0x10
00f7e5a3 7220 jb 0x140f7e5c5
00f7e5a5 4885db test rbx, rbx
00f7e5a8 7413 je 0x140f7e5bd
00f7e5aa 48837b1000 cmp qword ptr [rbx + 0x10], 0
00f7e5af 740c je 0x140f7e5bd
00f7e5b1 488b4330 mov rax, qword ptr [rbx + 0x30]
00f7e5b5 488bd8 mov rbx, rax
00f7e5b8 4885c0 test rax, rax
00f7e5bb 759a jne 0x140f7e557
00f7e5bd 33c0 xor eax, eax
00f7e5bf 4883c420 add rsp, 0x20
00f7e5c3 5b pop rbx
00f7e5c4 c3 ret 
00f7e5c5 488bcb mov rcx, rbx
00f7e5c8 4883c420 add rsp, 0x20
00f7e5cc 5b pop rbx
00f7e5cd e93e8df7ff jmp 0x140ef7310