00fb5510 48895c2420 mov qword ptr [rsp + 0x20], rbx
00fb5515 55 push rbp
00fb5516 56 push rsi
00fb5517 57 push rdi
00fb5518 4154 push r12
00fb551a 4155 push r13
00fb551c 4156 push r14
00fb551e 4157 push r15
00fb5520 4883ec40 sub rsp, 0x40
00fb5524 410fb6d9 movzx ebx, r9b
00fb5528 450fb6f8 movzx r15d, r8b
00fb552c 488bf2 mov rsi, rdx
00fb552f 4c8be9 mov r13, rcx
00fb5532 4533e4 xor r12d, r12d
00fb5535 418bfc mov edi, r12d
00fb5538 4c89642430 mov qword ptr [rsp + 0x30], r12
00fb553d 4c89642438 mov qword ptr [rsp + 0x38], r12
00fb5542 4885c9 test rcx, rcx
00fb5545 0f84ab020000 je 0x140fb57f6
00fb554b 813974736c70 cmp dword ptr [rcx], 0x706c7374
00fb5551 0f859f020000 jne 0x140fb57f6
00fb5557 4885d2 test rdx, rdx
00fb555a 0f8496020000 je 0x140fb57f6
00fb5560 488d542438 lea rdx, [rsp + 0x38]
00fb5565 488bce mov rcx, rsi
00fb5568 e8138d32ff call 0x1402de280
00fb556d 85c0 test eax, eax
00fb556f 7416 je 0x140fb5587
00fb5571 813e54534c4f cmp dword ptr [rsi], 0x4f4c5354
00fb5577 7513 jne 0x140fb558c
00fb5579 8b4604 mov eax, dword ptr [rsi + 4]
00fb557c 85c0 test eax, eax
00fb557e 740c je 0x140fb558c
00fb5580 ffc0 inc eax
00fb5582 894604 mov dword ptr [rsi + 4], eax
00fb5585 eb05 jmp 0x140fb558c
00fb5587 488b742438 mov rsi, qword ptr [rsp + 0x38]
00fb558c 84db test bl, bl
00fb558e 7411 je 0x140fb55a1
00fb5590 33d2 xor edx, edx
00fb5592 488d4c2430 lea rcx, [rsp + 0x30]
00fb5597 e8047032ff call 0x1402dc5a0
00fb559c 488b7c2430 mov rdi, qword ptr [rsp + 0x30]
00fb55a1 48bbabaaaaaaaaaaaaaa movabs rbx, 0xaaaaaaaaaaaaaaab
00fb55ab 4885f6 test rsi, rsi
00fb55ae 7420 je 0x140fb55d0
00fb55b0 813e54534c4f cmp dword ptr [rsi], 0x4f4c5354
00fb55b6 7518 jne 0x140fb55d0
00fb55b8 44396604 cmp dword ptr [rsi + 4], r12d
00fb55bc 7412 je 0x140fb55d0
00fb55be 4c8b7610 mov r14, qword ptr [rsi + 0x10]
00fb55c2 4c2b7608 sub r14, qword ptr [rsi + 8]
00fb55c6 49c1fe04 sar r14, 4
00fb55ca 4c0faff3 imul r14, rbx
00fb55ce eb03 jmp 0x140fb55d3
00fb55d0 458bf4 mov r14d, r12d
00fb55d3 498b4d08 mov rcx, qword ptr [r13 + 8]
00fb55d7 4885c9 test rcx, rcx
00fb55da 7431 je 0x140fb560d
00fb55dc 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
00fb55e6 7525 jne 0x140fb560d
00fb55e8 ff819c000000 inc dword ptr [rcx + 0x9c]
00fb55ee 83b99c00000001 cmp dword ptr [rcx + 0x9c], 1
00fb55f5 7516 jne 0x140fb560d
00fb55f7 488b01 mov rax, qword ptr [rcx]
00fb55fa 4c89642420 mov qword ptr [rsp + 0x20], r12
00fb55ff 4533c9 xor r9d, r9d
00fb5602 4c8bc1 mov r8, rcx
00fb5605 ba43426474 mov edx, 0x74644243
00fb560a ff5008 call qword ptr [rax + 8]
00fb560d 418bec mov ebp, r12d
00fb5610 4585f6 test r14d, r14d
00fb5613 0f84a8000000 je 0x140fb56c1
00fb5619 0f1f8000000000 nop dword ptr [rax]
00fb5620 8bd5 mov edx, ebp
00fb5622 488bce mov rcx, rsi
00fb5625 e8968532ff call 0x1402ddbc0
00fb562a 488bd8 mov rbx, rax
00fb562d 4885c0 test rax, rax
00fb5630 747a je 0x140fb56ac
00fb5632 f6404b01 test byte ptr [rax + 0x4b], 1
00fb5636 7549 jne 0x140fb5681
00fb5638 488b5030 mov rdx, qword ptr [rax + 0x30]
00fb563c 4885d2 test rdx, rdx
00fb563f 7440 je 0x140fb5681
00fb5641 488b08 mov rcx, qword ptr [rax]
00fb5644 e897820000 call 0x140fbd8e0
00fb5649 84c0 test al, al
00fb564b 7434 je 0x140fb5681
00fb564d 4c396210 cmp qword ptr [rdx + 0x10], r12
00fb5651 742e je 0x140fb5681
00fb5653 f6829a00000004 test byte ptr [rdx + 0x9a], 4
00fb565a 7425 je 0x140fb5681
00fb565c 488b05cd180f01 mov rax, qword ptr [rip + 0x10f18cd]
00fb5663 4885c0 test rax, rax
00fb5666 7409 je 0x140fb5671
00fb5668 488b8890410100 mov rcx, qword ptr [rax + 0x14190]
00fb566f eb03 jmp 0x140fb5674
00fb5671 498bcc mov rcx, r12
00fb5674 4438a18b050000 cmp byte ptr [rcx + 0x58b], r12b
00fb567b 7504 jne 0x140fb5681
00fb567d b001 mov al, 1
00fb567f eb02 jmp 0x140fb5683
00fb5681 32c0 xor al, al
00fb5683 413ac7 cmp al, r15b
00fb5686 7524 jne 0x140fb56ac
00fb5688 4584ff test r15b, r15b
00fb568b 0f94c2 sete dl
00fb568e 488bcb mov rcx, rbx
00fb5691 e80a5cd7ff call 0x140d2b2a0
00fb5696 4885ff test rdi, rdi
00fb5699 7411 je 0x140fb56ac
00fb569b 4533c9 xor r9d, r9d
00fb569e 41b001 mov r8b, 1
00fb56a1 488bd3 mov rdx, rbx
00fb56a4 488bcf mov rcx, rdi
00fb56a7 e8247d32ff call 0x1402dd3d0
00fb56ac ffc5 inc ebp
00fb56ae 413bee cmp ebp, r14d
00fb56b1 0f8269ffffff jb 0x140fb5620
00fb56b7 48bbabaaaaaaaaaaaaaa movabs rbx, 0xaaaaaaaaaaaaaaab
00fb56c1 4885ff test rdi, rdi
00fb56c4 0f84b1000000 je 0x140fb577b
00fb56ca 41817d0074736c70 cmp dword ptr [r13], 0x706c7374
00fb56d2 0f85a3000000 jne 0x140fb577b
00fb56d8 813f54534c4f cmp dword ptr [rdi], 0x4f4c5354
00fb56de 0f8597000000 jne 0x140fb577b
00fb56e4 44396704 cmp dword ptr [rdi + 4], r12d
00fb56e8 0f848d000000 je 0x140fb577b
00fb56ee 488b4710 mov rax, qword ptr [rdi + 0x10]
00fb56f2 482b4708 sub rax, qword ptr [rdi + 8]
00fb56f6 48c1f804 sar rax, 4
00fb56fa 480fafc3 imul rax, rbx
00fb56fe 85c0 test eax, eax
00fb5700 7479 je 0x140fb577b
00fb5702 488b2d1fb90f01 mov rbp, qword ptr [rip + 0x10fb91f]
00fb5709 4885ed test rbp, rbp
00fb570c 746d je 0x140fb577b
00fb570e 488d15ebd49500 lea rdx, [rip + 0x95d4eb]
00fb5715 b900010000 mov ecx, 0x100
00fb571a e8cd677e00 call 0x14179beec
00fb571f 488bd8 mov rbx, rax
00fb5722 4889442430 mov qword ptr [rsp + 0x30], rax
00fb5727 4885c0 test rax, rax
00fb572a 744f je 0x140fb577b
00fb572c 488bc8 mov rcx, rax
00fb572f e81c1c6800 call 0x141637350
00fb5734 488d0575cbc800 lea rax, [rip + 0xc8cb75]
00fb573b 488903 mov qword ptr [rbx], rax
00fb573e 4c89a3f8000000 mov qword ptr [rbx + 0xf8], r12
00fb5745 41f6df neg r15b
00fb5748 451bc0 sbb r8d, r8d
00fb574b 4183c007 add r8d, 7
00fb574f 4c8bcf mov r9, rdi
00fb5752 498bd5 mov rdx, r13
00fb5755 488bcb mov rcx, rbx
00fb5758 e843216800 call 0x1416378a0
00fb575d 85c0 test eax, eax
00fb575f 750d jne 0x140fb576e
00fb5761 488bd3 mov rdx, rbx
00fb5764 488bcd mov rcx, rbp
00fb5767 e804f72aff call 0x140264e70
00fb576c eb0d jmp 0x140fb577b
00fb576e 488b03 mov rax, qword ptr [rbx]
00fb5771 ba01000000 mov edx, 1
00fb5776 488bcb mov rcx, rbx
00fb5779 ff10 call qword ptr [rax]
00fb577b 498b4d08 mov rcx, qword ptr [r13 + 8]
00fb577f 4885c9 test rcx, rcx
00fb5782 7427 je 0x140fb57ab
00fb5784 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
00fb578e 751b jne 0x140fb57ab
00fb5790 ff899c000000 dec dword ptr [rcx + 0x9c]
00fb5796 4439a19c000000 cmp dword ptr [rcx + 0x9c], r12d
00fb579d 7f0c jg 0x140fb57ab
00fb579f 4489a19c000000 mov dword ptr [rcx + 0x9c], r12d
00fb57a6 e8a588f1ff call 0x140ece050
00fb57ab 4885f6 test rsi, rsi
00fb57ae 7414 je 0x140fb57c4
00fb57b0 813e54534c4f cmp dword ptr [rsi], 0x4f4c5354
00fb57b6 750c jne 0x140fb57c4
00fb57b8 8b4604 mov eax, dword ptr [rsi + 4]
00fb57bb 85c0 test eax, eax
00fb57bd 7405 je 0x140fb57c4
00fb57bf ffc0 inc eax
00fb57c1 894604 mov dword ptr [rsi + 4], eax
00fb57c4 4885ff test rdi, rdi
00fb57c7 742d je 0x140fb57f6
00fb57c9 813f54534c4f cmp dword ptr [rdi], 0x4f4c5354
00fb57cf 7525 jne 0x140fb57f6
00fb57d1 8b4704 mov eax, dword ptr [rdi + 4]
00fb57d4 85c0 test eax, eax
00fb57d6 741e je 0x140fb57f6
00fb57d8 83e801 sub eax, 1
00fb57db 894704 mov dword ptr [rdi + 4], eax
00fb57de 7516 jne 0x140fb57f6
00fb57e0 488d4f08 lea rcx, [rdi + 8]
00fb57e4 e8178f32ff call 0x1402de700
00fb57e9 ba20000000 mov edx, 0x20
00fb57ee 488bcf mov rcx, rdi
00fb57f1 e82a12c1ff call 0x140bc6a20
00fb57f6 488b9c2498000000 mov rbx, qword ptr [rsp + 0x98]
00fb57fe 4883c440 add rsp, 0x40
00fb5802 415f pop r15
00fb5804 415e pop r14
00fb5806 415d pop r13
00fb5808 415c pop r12
00fb580a 5f pop rdi
00fb580b 5e pop rsi
00fb580c 5d pop rbp
00fb580d c3 ret 