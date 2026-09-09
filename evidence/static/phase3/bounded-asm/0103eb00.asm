0103eb00 4056 push rsi
0103eb02 4883ec20 sub rsp, 0x20
0103eb06 498bf0 mov rsi, r8
0103eb09 83fa02 cmp edx, 2
0103eb0c 0f8526010000 jne 0x14103ec38
0103eb12 4d85c0 test r8, r8
0103eb15 0f841d010000 je 0x14103ec38
0103eb1b f6414b01 test byte ptr [rcx + 0x4b], 1
0103eb1f 0f8513010000 jne 0x14103ec38
0103eb25 488b01 mov rax, qword ptr [rcx]
0103eb28 4885c0 test rax, rax
0103eb2b 0f8407010000 je 0x14103ec38
0103eb31 813874736c70 cmp dword ptr [rax], 0x706c7374
0103eb37 0f85fb000000 jne 0x14103ec38
0103eb3d 83792800 cmp dword ptr [rcx + 0x28], 0
0103eb41 0f84f1000000 je 0x14103ec38
0103eb47 488b5130 mov rdx, qword ptr [rcx + 0x30]
0103eb4b 4885d2 test rdx, rdx
0103eb4e 0f84e4000000 je 0x14103ec38
0103eb54 48837a1000 cmp qword ptr [rdx + 0x10], 0
0103eb59 48895c2430 mov qword ptr [rsp + 0x30], rbx
0103eb5e 7436 je 0x14103eb96
0103eb60 488b5a58 mov rbx, qword ptr [rdx + 0x58]
0103eb64 4885db test rbx, rbx
0103eb67 742d je 0x14103eb96
0103eb69 0f1f8000000000 nop dword ptr [rax]
0103eb70 488b4308 mov rax, qword ptr [rbx + 8]
0103eb74 4885c0 test rax, rax
0103eb77 7410 je 0x14103eb89
0103eb79 4883781000 cmp qword ptr [rax + 0x10], 0
0103eb7e 7409 je 0x14103eb89
0103eb80 817b3444524853 cmp dword ptr [rbx + 0x34], 0x53485244
0103eb87 7508 jne 0x14103eb91
0103eb89 488b1b mov rbx, qword ptr [rbx]
0103eb8c 4885db test rbx, rbx
0103eb8f 75df jne 0x14103eb70
0103eb91 4885db test rbx, rbx
0103eb94 750d jne 0x14103eba3
0103eb96 488b5a58 mov rbx, qword ptr [rdx + 0x58]
0103eb9a 4885db test rbx, rbx
0103eb9d 0f8490000000 je 0x14103ec33
0103eba3 48897c2438 mov qword ptr [rsp + 0x38], rdi
0103eba8 488b7b08 mov rdi, qword ptr [rbx + 8]
0103ebac 4885ff test rdi, rdi
0103ebaf 747d je 0x14103ec2e
0103ebb1 48837f1000 cmp qword ptr [rdi + 0x10], 0
0103ebb6 7476 je 0x14103ec2e
0103ebb8 488b4310 mov rax, qword ptr [rbx + 0x10]
0103ebbc 4883783800 cmp qword ptr [rax + 0x38], 0
0103ebc1 746b je 0x14103ec2e
0103ebc3 4883780800 cmp qword ptr [rax + 8], 0
0103ebc8 7464 je 0x14103ec2e
0103ebca f6879a00000001 test byte ptr [rdi + 0x9a], 1
0103ebd1 745b je 0x14103ec2e
0103ebd3 488b4768 mov rax, qword ptr [rdi + 0x68]
0103ebd7 8b4810 mov ecx, dword ptr [rax + 0x10]
0103ebda 85c9 test ecx, ecx
0103ebdc 752d jne 0x14103ec0b
0103ebde 398fac000000 cmp dword ptr [rdi + 0xac], ecx
0103ebe4 751f jne 0x14103ec05
0103ebe6 488bcf mov rcx, rdi
0103ebe9 e85226f5ff call 0x140f91240
0103ebee 8987ac000000 mov dword ptr [rdi + 0xac], eax
0103ebf4 85c0 test eax, eax
0103ebf6 740d je 0x14103ec05
0103ebf8 ba3c000000 mov edx, 0x3c
0103ebfd 488bcf mov rcx, rdi
0103ec00 e8fb54f5ff call 0x140f94100
0103ec05 8b8fac000000 mov ecx, dword ptr [rdi + 0xac]
0103ec0b f6c120 test cl, 0x20
0103ec0e 741e je 0x14103ec2e
0103ec10 488b06 mov rax, qword ptr [rsi]
0103ec13 4533c0 xor r8d, r8d
0103ec16 488b5308 mov rdx, qword ptr [rbx + 8]
0103ec1a 488bce mov rcx, rsi
0103ec1d ff5018 call qword ptr [rax + 0x18]
0103ec20 488b4b08 mov rcx, qword ptr [rbx + 8]
0103ec24 ba25000000 mov edx, 0x25
0103ec29 e8d254f5ff call 0x140f94100
0103ec2e 488b7c2438 mov rdi, qword ptr [rsp + 0x38]
0103ec33 488b5c2430 mov rbx, qword ptr [rsp + 0x30]
0103ec38 33c0 xor eax, eax
0103ec3a 4883c420 add rsp, 0x20
0103ec3e 5e pop rsi
0103ec3f c3 ret 