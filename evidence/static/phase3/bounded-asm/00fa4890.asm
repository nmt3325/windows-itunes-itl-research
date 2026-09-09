00fa4890 4053 push rbx
00fa4892 4883ec20 sub rsp, 0x20
00fa4896 488bd9 mov rbx, rcx
00fa4899 4885c9 test rcx, rcx
00fa489c 7461 je 0x140fa48ff
00fa489e 488b5110 mov rdx, qword ptr [rcx + 0x10]
00fa48a2 4885d2 test rdx, rdx
00fa48a5 7458 je 0x140fa48ff
00fa48a7 81ba8000000074616474 cmp dword ptr [rdx + 0x80], 0x74646174
00fa48b1 754c jne 0x140fa48ff
00fa48b3 488bca mov rcx, rdx
00fa48b6 e8d577f3ff call 0x140edc090
00fa48bb 4885c0 test rax, rax
00fa48be 743f je 0x140fa48ff
00fa48c0 813874736c70 cmp dword ptr [rax], 0x706c7374
00fa48c6 7537 jne 0x140fa48ff
00fa48c8 440fb74010 movzx r8d, word ptr [rax + 0x10]
00fa48cd 4c8bca mov r9, rdx
00fa48d0 418bc0 mov eax, r8d
00fa48d3 4183f83e cmp r8d, 0x3e
00fa48d7 772e ja 0x140fa4907
00fa48d9 4c8d1520b705ff lea r10, [rip - 0xfa48e0]
00fa48e0 410fb684028849fa00 movzx eax, byte ptr [r10 + rax + 0xfa4988]
00fa48e9 418b8c827c49fa00 mov ecx, dword ptr [r10 + rax*4 + 0xfa497c]
00fa48f1 4903ca add rcx, r10
00fa48f4 ffe1 jmp rcx
00fa48f6 f6839b00000018 test byte ptr [rbx + 0x9b], 0x18
00fa48fd 7418 je 0x140fa4917
00fa48ff 32c0 xor al, al
00fa4901 4883c420 add rsp, 0x20
00fa4905 5b pop rbx
00fa4906 c3 ret 
00fa4907 b8c8000000 mov eax, 0xc8
00fa490c 66442bc0 sub r8w, ax
00fa4910 664183f806 cmp r8w, 6
00fa4915 77e8 ja 0x140fa48ff
00fa4917 418b8184000000 mov eax, dword ptr [r9 + 0x84]
00fa491e 3d74756e65 cmp eax, 0x656e7574
00fa4923 74da je 0x140fa48ff
00fa4925 3d72616469 cmp eax, 0x69646172
00fa492a 74d3 je 0x140fa48ff
00fa492c f6839a00000001 test byte ptr [rbx + 0x9a], 1
00fa4933 74ca je 0x140fa48ff
00fa4935 488b4368 mov rax, qword ptr [rbx + 0x68]
00fa4939 8b4810 mov ecx, dword ptr [rax + 0x10]
00fa493c 85c9 test ecx, ecx
00fa493e 752d jne 0x140fa496d
00fa4940 398bac000000 cmp dword ptr [rbx + 0xac], ecx
00fa4946 751f jne 0x140fa4967
00fa4948 488bcb mov rcx, rbx
00fa494b e8f0c8feff call 0x140f91240
00fa4950 8983ac000000 mov dword ptr [rbx + 0xac], eax
00fa4956 85c0 test eax, eax
00fa4958 740d je 0x140fa4967
00fa495a ba3c000000 mov edx, 0x3c
00fa495f 488bcb mov rcx, rbx
00fa4962 e899f7feff call 0x140f94100
00fa4967 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
00fa496d f6c121 test cl, 0x21
00fa4970 748d je 0x140fa48ff
00fa4972 b001 mov al, 1
00fa4974 4883c420 add rsp, 0x20
00fa4978 5b pop rbx
00fa4979 c3 ret 
00fa497a 6690 nop 