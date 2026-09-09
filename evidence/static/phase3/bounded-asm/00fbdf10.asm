00fbdf10 4883ec38 sub rsp, 0x38
00fbdf14 33c0 xor eax, eax
00fbdf16 4885c9 test rcx, rcx
00fbdf19 745d je 0x140fbdf78
00fbdf1b 4889442428 mov qword ptr [rsp + 0x28], rax
00fbdf20 4533c9 xor r9d, r9d
00fbdf23 4533c0 xor r8d, r8d
00fbdf26 89442420 mov dword ptr [rsp + 0x20], eax
00fbdf2a ba50545448 mov edx, 0x48545450
00fbdf2f 48895c2430 mov qword ptr [rsp + 0x30], rbx
00fbdf34 e8474cfdff call 0x140f92b80
00fbdf39 488bd8 mov rbx, rax
00fbdf3c 4885c0 test rax, rax
00fbdf3f 7432 je 0x140fbdf73
00fbdf41 488bc8 mov rcx, rax
00fbdf44 e8e750fdff call 0x140f93030
00fbdf49 488b4358 mov rax, qword ptr [rbx + 0x58]
00fbdf4d 808b9a00000008 or byte ptr [rbx + 0x9a], 8
00fbdf54 808b9b00000020 or byte ptr [rbx + 0x9b], 0x20
00fbdf5b 808b9f00000008 or byte ptr [rbx + 0x9f], 8
00fbdf62 c783ac00000001000000 mov dword ptr [rbx + 0xac], 1
00fbdf6c c6403d00 mov byte ptr [rax + 0x3d], 0
00fbdf70 488bc3 mov rax, rbx
00fbdf73 488b5c2430 mov rbx, qword ptr [rsp + 0x30]
00fbdf78 4883c438 add rsp, 0x38
00fbdf7c c3 ret 