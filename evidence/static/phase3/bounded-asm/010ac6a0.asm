010ac6a0 4053 push rbx
010ac6a2 4883ec20 sub rsp, 0x20
010ac6a6 488bd9 mov rbx, rcx
010ac6a9 4885c9 test rcx, rcx
010ac6ac 0f840b010000 je 0x1410ac7bd
010ac6b2 4883791000 cmp qword ptr [rcx + 0x10], 0
010ac6b7 0f8400010000 je 0x1410ac7bd
010ac6bd 488b056ca8ff00 mov rax, qword ptr [rip + 0xffa86c]
010ac6c4 4885c0 test rax, rax
010ac6c7 0f8485000000 je 0x1410ac752
010ac6cd 80780200 cmp byte ptr [rax + 2], 0
010ac6d1 740a je 0x1410ac6dd
010ac6d3 48833dd52c020100 cmp qword ptr [rip + 0x1022cd5], 0
010ac6db 7475 je 0x1410ac752
010ac6dd 488b8890410100 mov rcx, qword ptr [rax + 0x14190]
010ac6e4 4885c9 test rcx, rcx
010ac6e7 7469 je 0x1410ac752
010ac6e9 80b8e155010000 cmp byte ptr [rax + 0x155e1], 0
010ac6f0 7560 jne 0x1410ac752
010ac6f2 80790101 cmp byte ptr [rcx + 1], 1
010ac6f6 755a jne 0x1410ac752
010ac6f8 f6839d00000008 test byte ptr [rbx + 0x9d], 8
010ac6ff 7551 jne 0x1410ac752
010ac701 488b4b58 mov rcx, qword ptr [rbx + 0x58]
010ac705 4885c9 test rcx, rcx
010ac708 742c je 0x1410ac736
010ac70a 660f1f440000 nop word ptr [rax + rax]
010ac710 488b4108 mov rax, qword ptr [rcx + 8]
010ac714 4885c0 test rax, rax
010ac717 7410 je 0x1410ac729
010ac719 4883781000 cmp qword ptr [rax + 0x10], 0
010ac71e 7409 je 0x1410ac729
010ac720 81793444524853 cmp dword ptr [rcx + 0x34], 0x53485244
010ac727 7508 jne 0x1410ac731
010ac729 488b09 mov rcx, qword ptr [rcx]
010ac72c 4885c9 test rcx, rcx
010ac72f 75df jne 0x1410ac710
010ac731 4885c9 test rcx, rcx
010ac734 7509 jne 0x1410ac73f
010ac736 488b4b58 mov rcx, qword ptr [rbx + 0x58]
010ac73a 4885c9 test rcx, rcx
010ac73d 7413 je 0x1410ac752
010ac73f 8b4134 mov eax, dword ptr [rcx + 0x34]
010ac742 3d44524853 cmp eax, 0x53485244
010ac747 7511 jne 0x1410ac75a
010ac749 e8b2d3efff call 0x140fa9b00
010ac74e 84c0 test al, al
010ac750 750f jne 0x1410ac761
010ac752 33c0 xor eax, eax
010ac754 4883c420 add rsp, 0x20
010ac758 5b pop rbx
010ac759 c3 ret 
010ac75a 3d454c4946 cmp eax, 0x46494c45
010ac75f 75f1 jne 0x1410ac752
010ac761 48837b1000 cmp qword ptr [rbx + 0x10], 0
010ac766 74ea je 0x1410ac752
010ac768 f6839a00000001 test byte ptr [rbx + 0x9a], 1
010ac76f 74e1 je 0x1410ac752
010ac771 488b4368 mov rax, qword ptr [rbx + 0x68]
010ac775 8b4810 mov ecx, dword ptr [rax + 0x10]
010ac778 85c9 test ecx, ecx
010ac77a 752d jne 0x1410ac7a9
010ac77c 398bac000000 cmp dword ptr [rbx + 0xac], ecx
010ac782 751f jne 0x1410ac7a3
010ac784 488bcb mov rcx, rbx
010ac787 e8b44aeeff call 0x140f91240
010ac78c 8983ac000000 mov dword ptr [rbx + 0xac], eax
010ac792 85c0 test eax, eax
010ac794 740d je 0x1410ac7a3
010ac796 ba3c000000 mov edx, 0x3c
010ac79b 488bcb mov rcx, rbx
010ac79e e85d79eeff call 0x140f94100
010ac7a3 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
010ac7a9 81e105a02100 and ecx, 0x21a005
010ac7af 83f901 cmp ecx, 1
010ac7b2 759e jne 0x1410ac752
010ac7b4 0fb6c1 movzx eax, cl
010ac7b7 4883c420 add rsp, 0x20
010ac7bb 5b pop rbx
010ac7bc c3 ret 
010ac7bd 32c0 xor al, al
010ac7bf 4883c420 add rsp, 0x20
010ac7c3 5b pop rbx
010ac7c4 c3 ret 