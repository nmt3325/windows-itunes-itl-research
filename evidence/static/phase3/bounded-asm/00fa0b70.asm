00fa0b70 4053 push rbx
00fa0b72 4883ec20 sub rsp, 0x20
00fa0b76 488bd9 mov rbx, rcx
00fa0b79 4885c9 test rcx, rcx
00fa0b7c 7450 je 0x140fa0bce
00fa0b7e 4883791000 cmp qword ptr [rcx + 0x10], 0
00fa0b83 7449 je 0x140fa0bce
00fa0b85 f6819a00000001 test byte ptr [rcx + 0x9a], 1
00fa0b8c 7440 je 0x140fa0bce
00fa0b8e 488b4168 mov rax, qword ptr [rcx + 0x68]
00fa0b92 8b4010 mov eax, dword ptr [rax + 0x10]
00fa0b95 85c0 test eax, eax
00fa0b97 7404 je 0x140fa0b9d
00fa0b99 84d2 test dl, dl
00fa0b9b 7433 je 0x140fa0bd0
00fa0b9d 83b9ac00000000 cmp dword ptr [rcx + 0xac], 0
00fa0ba4 751c jne 0x140fa0bc2
00fa0ba6 e89506ffff call 0x140f91240
00fa0bab 8983ac000000 mov dword ptr [rbx + 0xac], eax
00fa0bb1 85c0 test eax, eax
00fa0bb3 740d je 0x140fa0bc2
00fa0bb5 ba3c000000 mov edx, 0x3c
00fa0bba 488bcb mov rcx, rbx
00fa0bbd e83e35ffff call 0x140f94100
00fa0bc2 8b83ac000000 mov eax, dword ptr [rbx + 0xac]
00fa0bc8 4883c420 add rsp, 0x20
00fa0bcc 5b pop rbx
00fa0bcd c3 ret 
00fa0bce 33c0 xor eax, eax
00fa0bd0 4883c420 add rsp, 0x20
00fa0bd4 5b pop rbx
00fa0bd5 c3 ret 