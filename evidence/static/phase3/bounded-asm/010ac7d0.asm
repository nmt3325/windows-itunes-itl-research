010ac7d0 488bc4 mov rax, rsp
010ac7d3 48895808 mov qword ptr [rax + 8], rbx
010ac7d7 48896818 mov qword ptr [rax + 0x18], rbp
010ac7db 48897020 mov qword ptr [rax + 0x20], rsi
010ac7df 57 push rdi
010ac7e0 4154 push r12
010ac7e2 4155 push r13
010ac7e4 4156 push r14
010ac7e6 4157 push r15
010ac7e8 4883ec30 sub rsp, 0x30
010ac7ec 410fb6f9 movzx edi, r9b
010ac7f0 458bf8 mov r15d, r8d
010ac7f3 4c8bf2 mov r14, rdx
010ac7f6 488bf1 mov rsi, rcx
010ac7f9 4885d2 test rdx, rdx
010ac7fc 0f84f1010000 je 0x1410ac9f3
010ac802 48837a1000 cmp qword ptr [rdx + 0x10], 0
010ac807 0f84e6010000 je 0x1410ac9f3
010ac80d 488b9250010000 mov rdx, qword ptr [rdx + 0x150]
010ac814 4889542468 mov qword ptr [rsp + 0x68], rdx
010ac819 4885d2 test rdx, rdx
010ac81c 0f84d1010000 je 0x1410ac9f3
010ac822 4c8b6828 mov r13, qword ptr [rax + 0x28]
010ac826 4885c9 test rcx, rcx
010ac829 0f84ba010000 je 0x1410ac9e9
010ac82f 813974736c70 cmp dword ptr [rcx], 0x706c7374
010ac835 0f85ae010000 jne 0x1410ac9e9
010ac83b 49837d0000 cmp qword ptr [r13], 0
010ac840 0f84a3010000 je 0x1410ac9e9
010ac846 33ed xor ebp, ebp
010ac848 488b4108 mov rax, qword ptr [rcx + 8]
010ac84c 488b8888200000 mov rcx, qword ptr [rax + 0x2088]
010ac853 4885c9 test rcx, rcx
010ac856 0f847b010000 je 0x1410ac9d7
010ac85c 498b5e60 mov rbx, qword ptr [r14 + 0x60]
010ac860 4885db test rbx, rbx
010ac863 0f846e010000 je 0x1410ac9d7
010ac869 0f1f8000000000 nop dword ptr [rax]
010ac870 483933 cmp qword ptr [rbx], rsi
010ac873 7409 je 0x1410ac87e
010ac875 488b5b38 mov rbx, qword ptr [rbx + 0x38]
010ac879 4885db test rbx, rbx
010ac87c 75f2 jne 0x1410ac870
010ac87e 4885db test rbx, rbx
010ac881 0f8450010000 je 0x1410ac9d7
010ac887 e894640800 call 0x141132d20
010ac88c 4c8be0 mov r12, rax
010ac88f 4885c0 test rax, rax
010ac892 0f843f010000 je 0x1410ac9d7
010ac898 4084ff test dil, dil
010ac89b 7411 je 0x1410ac8ae
010ac89d bd01000000 mov ebp, 1
010ac8a2 488bd3 mov rdx, rbx
010ac8a5 498b4d00 mov rcx, qword ptr [r13]
010ac8a9 e88262ebff call 0x140f62b30
010ac8ae 498bcc mov rcx, r12
010ac8b1 e87a6a0800 call 0x141133330
010ac8b6 488bf8 mov rdi, rax
010ac8b9 4885c0 test rax, rax
010ac8bc 0f8400010000 je 0x1410ac9c2
010ac8c2 483b7c2468 cmp rdi, qword ptr [rsp + 0x68]
010ac8c7 0f84e1000000 je 0x1410ac9ae
010ac8cd 488b5e08 mov rbx, qword ptr [rsi + 8]
010ac8d1 4885db test rbx, rbx
010ac8d4 0f84d4000000 je 0x1410ac9ae
010ac8da 81bb8000000074616474 cmp dword ptr [rbx + 0x80], 0x74646174
010ac8e4 0f85c4000000 jne 0x1410ac9ae
010ac8ea 488bcb mov rcx, rbx
010ac8ed e81e61e1ff call 0x140ec2a10
010ac8f2 85c0 test eax, eax
010ac8f4 0f85b4000000 jne 0x1410ac9ae
010ac8fa 4533c0 xor r8d, r8d
010ac8fd 488bd7 mov rdx, rdi
010ac900 488bcb mov rcx, rbx
010ac903 e8c862e1ff call 0x140ec2bd0
010ac908 4885c0 test rax, rax
010ac90b 0f849d000000 je 0x1410ac9ae
010ac911 4c8b4010 mov r8, qword ptr [rax + 0x10]
010ac915 4d85c0 test r8, r8
010ac918 742e je 0x1410ac948
010ac91a f6809a00000004 test byte ptr [rax + 0x9a], 4
010ac921 7425 je 0x1410ac948
010ac923 488b0d06a6ff00 mov rcx, qword ptr [rip + 0xffa606]
010ac92a 4885c9 test rcx, rcx
010ac92d 7409 je 0x1410ac938
010ac92f 488b9190410100 mov rdx, qword ptr [rcx + 0x14190]
010ac936 eb02 jmp 0x1410ac93a
010ac938 33d2 xor edx, edx
010ac93a 80ba8b05000000 cmp byte ptr [rdx + 0x58b], 0
010ac941 7505 jne 0x1410ac948
010ac943 4c3bf0 cmp r14, rax
010ac946 7566 jne 0x1410ac9ae
010ac948 f6809b00000040 test byte ptr [rax + 0x9b], 0x40
010ac94f 755d jne 0x1410ac9ae
010ac951 813e74736c70 cmp dword ptr [rsi], 0x706c7374
010ac957 7555 jne 0x1410ac9ae
010ac959 4d85c0 test r8, r8
010ac95c 7450 je 0x1410ac9ae
010ac95e 488b4060 mov rax, qword ptr [rax + 0x60]
010ac962 4885c0 test rax, rax
010ac965 7447 je 0x1410ac9ae
010ac967 483930 cmp qword ptr [rax], rsi
010ac96a 740b je 0x1410ac977
010ac96c 488b4038 mov rax, qword ptr [rax + 0x38]
010ac970 4885c0 test rax, rax
010ac973 75f2 jne 0x1410ac967
010ac975 eb37 jmp 0x1410ac9ae
010ac977 ffc5 inc ebp
010ac979 4889442420 mov qword ptr [rsp + 0x20], rax
010ac97e 498b4d00 mov rcx, qword ptr [r13]
010ac982 4883c110 add rcx, 0x10
010ac986 488b5108 mov rdx, qword ptr [rcx + 8]
010ac98a 483b5110 cmp rdx, qword ptr [rcx + 0x10]
010ac98e 740a je 0x1410ac99a
010ac990 488902 mov qword ptr [rdx], rax
010ac993 4883410808 add qword ptr [rcx + 8], 8
010ac998 eb0a jmp 0x1410ac9a4
010ac99a 4c8d442420 lea r8, [rsp + 0x20]
010ac99f e88c7c21ff call 0x1402c4630
010ac9a4 4585ff test r15d, r15d
010ac9a7 7405 je 0x1410ac9ae
010ac9a9 413bef cmp ebp, r15d
010ac9ac 7314 jae 0x1410ac9c2
010ac9ae 498bcc mov rcx, r12
010ac9b1 e87a690800 call 0x141133330
010ac9b6 488bf8 mov rdi, rax
010ac9b9 4885c0 test rax, rax
010ac9bc 0f8500ffffff jne 0x1410ac8c2
010ac9c2 498bcc mov rcx, r12
010ac9c5 e8c6660800 call 0x141133090
010ac9ca bac8000000 mov edx, 0xc8
010ac9cf 498bcc mov rcx, r12
010ac9d2 e849a0b1ff call 0x140bc6a20
010ac9d7 85ed test ebp, ebp
010ac9d9 0f95c3 setne bl
010ac9dc 498bcd mov rcx, r13
010ac9df e82c531aff call 0x140251d10
010ac9e4 0fb6c3 movzx eax, bl
010ac9e7 eb49 jmp 0x1410aca32
010ac9e9 498bcd mov rcx, r13
010ac9ec e81f531aff call 0x140251d10
010ac9f1 eb3d jmp 0x1410aca30
010ac9f3 488b842480000000 mov rax, qword ptr [rsp + 0x80]
010ac9fb 488b5808 mov rbx, qword ptr [rax + 8]
010ac9ff 4885db test rbx, rbx
010aca02 742c je 0x1410aca30
010aca04 bfffffffff mov edi, 0xffffffff
010aca09 8bc7 mov eax, edi
010aca0b f00fc14308 lock xadd dword ptr [rbx + 8], eax
010aca10 83f801 cmp eax, 1
010aca13 751b jne 0x1410aca30
010aca15 488b03 mov rax, qword ptr [rbx]
010aca18 488bcb mov rcx, rbx
010aca1b ff10 call qword ptr [rax]
010aca1d f00fc17b0c lock xadd dword ptr [rbx + 0xc], edi
010aca22 83ff01 cmp edi, 1
010aca25 7509 jne 0x1410aca30
010aca27 488b03 mov rax, qword ptr [rbx]
010aca2a 488bcb mov rcx, rbx
010aca2d ff5008 call qword ptr [rax + 8]
010aca30 32c0 xor al, al
010aca32 488b5c2460 mov rbx, qword ptr [rsp + 0x60]
010aca37 488b6c2470 mov rbp, qword ptr [rsp + 0x70]
010aca3c 488b742478 mov rsi, qword ptr [rsp + 0x78]
010aca41 4883c430 add rsp, 0x30
010aca45 415f pop r15
010aca47 415e pop r14
010aca49 415d pop r13
010aca4b 415c pop r12
010aca4d 5f pop rdi
010aca4e c3 ret 