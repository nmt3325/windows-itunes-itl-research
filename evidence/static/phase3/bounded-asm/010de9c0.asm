010de9c0 48895c2408 mov qword ptr [rsp + 8], rbx
010de9c5 48896c2410 mov qword ptr [rsp + 0x10], rbp
010de9ca 4889742418 mov qword ptr [rsp + 0x18], rsi
010de9cf 57 push rdi
010de9d0 4883ec20 sub rsp, 0x20
010de9d4 410fb6f1 movzx esi, r9b
010de9d8 488bfa mov rdi, rdx
010de9db 488be9 mov rbp, rcx
010de9de 41f6c004 test r8b, 4
010de9e2 7478 je 0x1410dea5c
010de9e4 4885d2 test rdx, rdx
010de9e7 7473 je 0x1410dea5c
010de9e9 488b02 mov rax, qword ptr [rdx]
010de9ec 4885c0 test rax, rax
010de9ef 746b je 0x1410dea5c
010de9f1 813874736c70 cmp dword ptr [rax], 0x706c7374
010de9f7 7563 jne 0x1410dea5c
010de9f9 837a2800 cmp dword ptr [rdx + 0x28], 0
010de9fd 745d je 0x1410dea5c
010de9ff 488b5a30 mov rbx, qword ptr [rdx + 0x30]
010dea03 4885db test rbx, rbx
010dea06 7454 je 0x1410dea5c
010dea08 48837b1000 cmp qword ptr [rbx + 0x10], 0
010dea0d 744d je 0x1410dea5c
010dea0f f6839a00000001 test byte ptr [rbx + 0x9a], 1
010dea16 7444 je 0x1410dea5c
010dea18 488b4368 mov rax, qword ptr [rbx + 0x68]
010dea1c 8b4810 mov ecx, dword ptr [rax + 0x10]
010dea1f 85c9 test ecx, ecx
010dea21 752d jne 0x1410dea50
010dea23 398bac000000 cmp dword ptr [rbx + 0xac], ecx
010dea29 751f jne 0x1410dea4a
010dea2b 488bcb mov rcx, rbx
010dea2e e80d28ebff call 0x140f91240
010dea33 8983ac000000 mov dword ptr [rbx + 0xac], eax
010dea39 85c0 test eax, eax
010dea3b 740d je 0x1410dea4a
010dea3d ba3c000000 mov edx, 0x3c
010dea42 488bcb mov rcx, rbx
010dea45 e8b656ebff call 0x140f94100
010dea4a 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
010dea50 f7c190000100 test ecx, 0x10090
010dea56 7404 je 0x1410dea5c
010dea58 32c0 xor al, al
010dea5a eb14 jmp 0x1410dea70
010dea5c 440fb6c6 movzx r8d, sil
010dea60 488bd7 mov rdx, rdi
010dea63 488bcd mov rcx, rbp
010dea66 e8b58de1ff call 0x140ef7820
010dea6b 84c0 test al, al
010dea6d 0f95c0 setne al
010dea70 488b5c2430 mov rbx, qword ptr [rsp + 0x30]
010dea75 488b6c2438 mov rbp, qword ptr [rsp + 0x38]
010dea7a 488b742440 mov rsi, qword ptr [rsp + 0x40]
010dea7f 4883c420 add rsp, 0x20
010dea83 5f pop rdi
010dea84 c3 ret 