00fbd920 4883ec28 sub rsp, 0x28
00fbd924 4885c9 test rcx, rcx
00fbd927 7452 je 0x140fbd97b
00fbd929 f6414b01 test byte ptr [rcx + 0x4b], 1
00fbd92d 754c jne 0x140fbd97b
00fbd92f 488b5130 mov rdx, qword ptr [rcx + 0x30]
00fbd933 4885d2 test rdx, rdx
00fbd936 7443 je 0x140fbd97b
00fbd938 488b09 mov rcx, qword ptr [rcx]
00fbd93b e8a0ffffff call 0x140fbd8e0
00fbd940 84c0 test al, al
00fbd942 7437 je 0x140fbd97b
00fbd944 48837a1000 cmp qword ptr [rdx + 0x10], 0
00fbd949 7430 je 0x140fbd97b
00fbd94b f6829a00000004 test byte ptr [rdx + 0x9a], 4
00fbd952 7427 je 0x140fbd97b
00fbd954 488b05d5950e01 mov rax, qword ptr [rip + 0x10e95d5]
00fbd95b 4885c0 test rax, rax
00fbd95e 7409 je 0x140fbd969
00fbd960 488b8890410100 mov rcx, qword ptr [rax + 0x14190]
00fbd967 eb02 jmp 0x140fbd96b
00fbd969 33c9 xor ecx, ecx
00fbd96b 80b98b05000000 cmp byte ptr [rcx + 0x58b], 0
00fbd972 7507 jne 0x140fbd97b
00fbd974 b001 mov al, 1
00fbd976 4883c428 add rsp, 0x28
00fbd97a c3 ret 
00fbd97b 32c0 xor al, al
00fbd97d 4883c428 add rsp, 0x28
00fbd981 c3 ret 