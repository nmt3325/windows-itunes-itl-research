00fbd6c0 48895c2408 mov qword ptr [rsp + 8], rbx
00fbd6c5 57 push rdi
00fbd6c6 4883ec20 sub rsp, 0x20
00fbd6ca 4885c9 test rcx, rcx
00fbd6cd 0f84c8000000 je 0x140fbd79b
00fbd6d3 488b01 mov rax, qword ptr [rcx]
00fbd6d6 4885c0 test rax, rax
00fbd6d9 0f84bc000000 je 0x140fbd79b
00fbd6df 813874736c70 cmp dword ptr [rax], 0x706c7374
00fbd6e5 0f85b0000000 jne 0x140fbd79b
00fbd6eb 83792800 cmp dword ptr [rcx + 0x28], 0
00fbd6ef 0f84a6000000 je 0x140fbd79b
00fbd6f5 0fb6514b movzx edx, byte ptr [rcx + 0x4b]
00fbd6f9 f6c202 test dl, 2
00fbd6fc 0f8599000000 jne 0x140fbd79b
00fbd702 f6c201 test dl, 1
00fbd705 0f8583000000 jne 0x140fbd78e
00fbd70b 488b5930 mov rbx, qword ptr [rcx + 0x30]
00fbd70f 4885db test rbx, rbx
00fbd712 747a je 0x140fbd78e
00fbd714 488b4008 mov rax, qword ptr [rax + 8]
00fbd718 80b81201000000 cmp byte ptr [rax + 0x112], 0
00fbd71f 7c25 jl 0x140fbd746
00fbd721 488bcb mov rcx, rbx
00fbd724 e87760fdff call 0x140f937a0
00fbd729 84c0 test al, al
00fbd72b 7519 jne 0x140fbd746
00fbd72d 38839d000000 cmp byte ptr [rbx + 0x9d], al
00fbd733 7d1d jge 0x140fbd752
00fbd735 33d2 xor edx, edx
00fbd737 488bcb mov rcx, rbx
00fbd73a e83134feff call 0x140fa0b70
00fbd73f a904002000 test eax, 0x200004
00fbd744 740c je 0x140fbd752
00fbd746 488bcb mov rcx, rbx
00fbd749 e89265fdff call 0x140f93ce0
00fbd74e 84c0 test al, al
00fbd750 7549 jne 0x140fbd79b
00fbd752 f6839b00000008 test byte ptr [rbx + 0x9b], 8
00fbd759 488dbb9a000000 lea rdi, [rbx + 0x9a]
00fbd760 7411 je 0x140fbd773
00fbd762 f60708 test byte ptr [rdi], 8
00fbd765 740c je 0x140fbd773
00fbd767 488bcb mov rcx, rbx
00fbd76a e87165fdff call 0x140f93ce0
00fbd76f 84c0 test al, al
00fbd771 7528 jne 0x140fbd79b
00fbd773 f683a000000002 test byte ptr [rbx + 0xa0], 2
00fbd77a 751f jne 0x140fbd79b
00fbd77c 0fb607 movzx eax, byte ptr [rdi]
00fbd77f d0e8 shr al, 1
00fbd781 2401 and al, 1
00fbd783 488b5c2430 mov rbx, qword ptr [rsp + 0x30]
00fbd788 4883c420 add rsp, 0x20
00fbd78c 5f pop rdi
00fbd78d c3 ret 
00fbd78e 32c0 xor al, al
00fbd790 488b5c2430 mov rbx, qword ptr [rsp + 0x30]
00fbd795 4883c420 add rsp, 0x20
00fbd799 5f pop rdi
00fbd79a c3 ret 
00fbd79b 488b5c2430 mov rbx, qword ptr [rsp + 0x30]
00fbd7a0 b001 mov al, 1
00fbd7a2 4883c420 add rsp, 0x20
00fbd7a6 5f pop rdi
00fbd7a7 c3 ret 