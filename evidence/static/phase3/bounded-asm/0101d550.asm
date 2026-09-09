0101d550 48895c2418 mov qword ptr [rsp + 0x18], rbx
0101d555 55 push rbp
0101d556 56 push rsi
0101d557 57 push rdi
0101d558 4154 push r12
0101d55a 4155 push r13
0101d55c 4156 push r14
0101d55e 4157 push r15
0101d560 488dac24f0f1ffff lea rbp, [rsp - 0xe10]
0101d568 4881ec100f0000 sub rsp, 0xf10
0101d56f 488b05ca7afb00 mov rax, qword ptr [rip + 0xfb7aca]
0101d576 4833c4 xor rax, rsp
0101d579 488985000e0000 mov qword ptr [rbp + 0xe00], rax
0101d580 488bfa mov rdi, rdx
0101d583 4889542438 mov qword ptr [rsp + 0x38], rdx
0101d588 4c8be1 mov r12, rcx
0101d58b c644243400 mov byte ptr [rsp + 0x34], 0
0101d590 33f6 xor esi, esi
0101d592 488b0597990801 mov rax, qword ptr [rip + 0x1089997]
0101d599 4885c0 test rax, rax
0101d59c 7409 je 0x14101d5a7
0101d59e 4c8ba890410100 mov r13, qword ptr [rax + 0x14190]
0101d5a5 eb03 jmp 0x14101d5aa
0101d5a7 4c8bee mov r13, rsi
0101d5aa 4c896c2460 mov qword ptr [rsp + 0x60], r13
0101d5af 488b01 mov rax, qword ptr [rcx]
0101d5b2 4c8b30 mov r14, qword ptr [rax]
0101d5b5 4d8b7e08 mov r15, qword ptr [r14 + 8]
0101d5b9 41f686d801000008 test byte ptr [r14 + 0x1d8], 8
0101d5c1 740f je 0x14101d5d2
0101d5c3 41f6871001000001 test byte ptr [r15 + 0x110], 1
0101d5cb 7405 je 0x14101d5d2
0101d5cd 41b001 mov r8b, 1
0101d5d0 eb03 jmp 0x14101d5d5
0101d5d2 4532c0 xor r8b, r8b
0101d5d5 41813e74736c70 cmp dword ptr [r14], 0x706c7374
0101d5dc 0fb7ce movzx ecx, si
0101d5df 7505 jne 0x14101d5e6
0101d5e1 410fb74e10 movzx ecx, word ptr [r14 + 0x10]
0101d5e6 e8b59aedff call 0x140ef70a0
0101d5eb 4584c0 test r8b, r8b
0101d5ee 7509 jne 0x14101d5f9
0101d5f0 84c0 test al, al
0101d5f2 4088742432 mov byte ptr [rsp + 0x32], sil
0101d5f7 7405 je 0x14101d5fe
0101d5f9 c644243201 mov byte ptr [rsp + 0x32], 1
0101d5fe 410fb6859a000000 movzx eax, byte ptr [r13 + 0x9a]
0101d606 88442430 mov byte ptr [rsp + 0x30], al
0101d60a b9a4000000 mov ecx, 0xa4
0101d60f ff159be88c00 call qword ptr [rip + 0x8ce89b]
0101d615 0fbae00f bt eax, 0xf
0101d619 0f92c1 setb cl
0101d61c 0fbae00f bt eax, 0xf
0101d620 7212 jb 0x14101d634
0101d622 b9a5000000 mov ecx, 0xa5
0101d627 ff1583e88c00 call qword ptr [rip + 0x8ce883]
0101d62d 0fb7c8 movzx ecx, ax
0101d630 66c1e90f shr cx, 0xf
0101d634 84c9 test cl, cl
0101d636 7411 je 0x14101d649
0101d638 4138b59a000000 cmp byte ptr [r13 + 0x9a], sil
0101d63f 0f94c0 sete al
0101d642 4188859a000000 mov byte ptr [r13 + 0x9a], al
0101d649 4c8d4580 lea r8, [rbp - 0x80]
0101d64d 498bd4 mov rdx, r12
0101d650 b101 mov cl, 1
0101d652 e81951e8ff call 0x140ea2770
0101d657 41813e74736c70 cmp dword ptr [r14], 0x706c7374
0101d65e 7543 jne 0x14101d6a3
0101d660 41f686d801000008 test byte ptr [r14 + 0x1d8], 8
0101d668 7539 jne 0x14101d6a3
0101d66a b101 mov cl, 1
0101d66c e84fa95eff call 0x140607fc0
0101d671 84c0 test al, al
0101d673 742e je 0x14101d6a3
0101d675 498b8688010000 mov rax, qword ptr [r14 + 0x188]
0101d67c 4883f8fd cmp rax, -3
0101d680 740a je 0x14101d68c
0101d682 7708 ja 0x14101d68c
0101d684 4885c0 test rax, rax
0101d687 0f95c0 setne al
0101d68a eb02 jmp 0x14101d68e
0101d68c 32c0 xor al, al
0101d68e 84c0 test al, al
0101d690 7411 je 0x14101d6a3
0101d692 c644243401 mov byte ptr [rsp + 0x34], 1
0101d697 498bce mov rcx, r14
0101d69a e871eeffff call 0x14101c510
0101d69f 84c0 test al, al
0101d6a1 745b je 0x14101d6fe
0101d6a3 b301 mov bl, 1
0101d6a5 488bd7 mov rdx, rdi
0101d6a8 498bcc mov rcx, r12
0101d6ab e890e7ffff call 0x14101be40
0101d6b0 84c0 test al, al
0101d6b2 741b je 0x14101d6cf
0101d6b4 e8e7140000 call 0x14101eba0
0101d6b9 6683f865 cmp ax, 0x65
0101d6bd 7410 je 0x14101d6cf
0101d6bf 6683f866 cmp ax, 0x66
0101d6c3 7439 je 0x14101d6fe
0101d6c5 0fb6db movzx ebx, bl
0101d6c8 6683f867 cmp ax, 0x67
0101d6cc 0f44de cmove ebx, esi
0101d6cf 885d9d mov byte ptr [rbp - 0x63], bl
0101d6d2 488b45b0 mov rax, qword ptr [rbp - 0x50]
0101d6d6 48c7c6ffffffff mov rsi, 0xffffffffffffffff
0101d6dd 33db xor ebx, ebx
0101d6df 4885c0 test rax, rax
0101d6e2 7423 je 0x14101d707
0101d6e4 48895c2420 mov qword ptr [rsp + 0x20], rbx
0101d6e9 4c8bce mov r9, rsi
0101d6ec 4533c0 xor r8d, r8d
0101d6ef ba6d727063 mov edx, 0x6370726d
0101d6f4 488d4db0 lea rcx, [rbp - 0x50]
0101d6f8 ffd0 call rax
0101d6fa 85c0 test eax, eax
0101d6fc 7409 je 0x14101d707
0101d6fe 488b5d90 mov rbx, qword ptr [rbp - 0x70]
0101d702 e9e20a0000 jmp 0x14101e1e9
0101d707 4d85ff test r15, r15
0101d70a 7438 je 0x14101d744
0101d70c 4181bf8000000074616474 cmp dword ptr [r15 + 0x80], 0x74646174
0101d717 752b jne 0x14101d744
0101d719 4180bf1801000004 cmp byte ptr [r15 + 0x118], 4
0101d721 7421 je 0x14101d744
0101d723 41c6871801000004 mov byte ptr [r15 + 0x118], 4
0101d72b 498b07 mov rax, qword ptr [r15]
0101d72e 48895c2420 mov qword ptr [rsp + 0x20], rbx
0101d733 4533c9 xor r9d, r9d
0101d736 4d8bc7 mov r8, r15
0101d739 ba6f6c6474 mov edx, 0x74646c6f
0101d73e 498bcf mov rcx, r15
0101d741 ff5008 call qword ptr [rax + 8]
0101d744 448beb mov r13d, ebx
0101d747 663b5f04 cmp bx, word ptr [rdi + 4]
0101d74b 0f8314030000 jae 0x14101da65
0101d751 33d2 xor edx, edx
0101d753 41b840020000 mov r8d, 0x240
0101d759 488d8d10030000 lea rcx, [rbp + 0x310]
0101d760 e83bf57700 call 0x14179cca0
0101d765 418bc5 mov eax, r13d
0101d768 4869d830020000 imul rbx, rax, 0x230
0101d76f 807c3b5800 cmp byte ptr [rbx + rdi + 0x58], 0
0101d774 0f8427040000 je 0x14101dba1
0101d77a 498b0424 mov rax, qword ptr [r12]
0101d77e 4885c0 test rax, rax
0101d781 0f84cc020000 je 0x14101da53
0101d787 488b08 mov rcx, qword ptr [rax]
0101d78a 4885c9 test rcx, rcx
0101d78d 0f84c0020000 je 0x14101da53
0101d793 813974736c70 cmp dword ptr [rcx], 0x706c7374
0101d799 0f85b4020000 jne 0x14101da53
0101d79f 83782800 cmp dword ptr [rax + 0x28], 0
0101d7a3 0f84aa020000 je 0x14101da53
0101d7a9 33c0 xor eax, eax
0101d7ab 48c744244850545448 mov qword ptr [rsp + 0x48], 0x48545450
0101d7b4 4889442458 mov qword ptr [rsp + 0x58], rax
0101d7b9 4c89642440 mov qword ptr [rsp + 0x40], r12
0101d7be 488d8510030000 lea rax, [rbp + 0x310]
0101d7c5 4889442450 mov qword ptr [rsp + 0x50], rax
0101d7ca 4c8d442440 lea r8, [rsp + 0x40]
0101d7cf ba69616c70 mov edx, 0x706c6169
0101d7d4 e8a76dedff call 0x140ef4580
0101d7d9 85c0 test eax, eax
0101d7db 0f8572020000 jne 0x14101da53
0101d7e1 88442431 mov byte ptr [rsp + 0x31], al
0101d7e5 c644243301 mov byte ptr [rsp + 0x33], 1
0101d7ea 4863443b60 movsxd rax, dword ptr [rbx + rdi + 0x60]
0101d7ef 488d5f10 lea rbx, [rdi + 0x10]
0101d7f3 33c9 xor ecx, ecx
0101d7f5 8bf9 mov edi, ecx
0101d7f7 8bf1 mov esi, ecx
0101d7f9 4885db test rbx, rbx
0101d7fc 7472 je 0x14101d870
0101d7fe 813b63727473 cmp dword ptr [rbx], 0x73747263
0101d804 756a jne 0x14101d870
0101d806 83f801 cmp eax, 1
0101d809 7c65 jl 0x14101d870
0101d80b 3b432c cmp eax, dword ptr [rbx + 0x2c]
0101d80e 7f60 jg 0x14101d870
0101d810 ff433c inc dword ptr [rbx + 0x3c]
0101d813 488bd0 mov rdx, rax
0101d816 488b4310 mov rax, qword ptr [rbx + 0x10]
0101d81a 488b08 mov rcx, qword ptr [rax]
0101d81d 488d42ff lea rax, [rdx - 1]
0101d821 488d04c1 lea rax, [rcx + rax*8]
0101d825 4885c0 test rax, rax
0101d828 7438 je 0x14101d862
0101d82a 486310 movsxd rdx, dword ptr [rax]
0101d82d 85d2 test edx, edx
0101d82f 7831 js 0x14101d862
0101d831 8b4804 mov ecx, dword ptr [rax + 4]
0101d834 85c9 test ecx, ecx
0101d836 7e2a jle 0x14101d862
0101d838 8bf9 mov edi, ecx
0101d83a b820030000 mov eax, 0x320
0101d83f 3bc8 cmp ecx, eax
0101d841 0f4ff8 cmovg edi, eax
0101d844 488b4320 mov rax, qword ptr [rbx + 0x20]
0101d848 488bca mov rcx, rdx
0101d84b 488b10 mov rdx, qword ptr [rax]
0101d84e 4803d1 add rdx, rcx
0101d851 740f je 0x14101d862
0101d853 448bc7 mov r8d, edi
0101d856 488d8de00a0000 lea rcx, [rbp + 0xae0]
0101d85d e813a08400 call 0x141867875
0101d862 8b433c mov eax, dword ptr [rbx + 0x3c]
0101d865 85c0 test eax, eax
0101d867 7e05 jle 0x14101d86e
0101d869 ffc8 dec eax
0101d86b 89433c mov dword ptr [rbx + 0x3c], eax
0101d86e 8bf7 mov esi, edi
0101d870 41813e74736c70 cmp dword ptr [r14], 0x706c7374
0101d877 752f jne 0x14101d8a8
0101d879 498b4608 mov rax, qword ptr [r14 + 8]
0101d87d f6801001000001 test byte ptr [rax + 0x110], 1
0101d884 750c jne 0x14101d892
0101d886 81b88400000074657374 cmp dword ptr [rax + 0x84], 0x74736574
0101d890 7516 jne 0x14101d8a8
0101d892 410fb74610 movzx eax, word ptr [r14 + 0x10]
0101d897 6683f80a cmp ax, 0xa
0101d89b 7406 je 0x14101d8a3
0101d89d 6683f81f cmp ax, 0x1f
0101d8a1 7505 jne 0x14101d8a8
0101d8a3 c644243101 mov byte ptr [rsp + 0x31], 1
0101d8a8 807c243200 cmp byte ptr [rsp + 0x32], 0
0101d8ad 0f858d000000 jne 0x14101d940
0101d8b3 807d9d00 cmp byte ptr [rbp - 0x63], 0
0101d8b7 0f8583000000 jne 0x14101d940
0101d8bd 89b594070000 mov dword ptr [rbp + 0x794], esi
0101d8c3 4c63c6 movsxd r8, esi
0101d8c6 488d95e00a0000 lea rdx, [rbp + 0xae0]
0101d8cd 488d8d98070000 lea rcx, [rbp + 0x798]
0101d8d4 e8c1f37700 call 0x14179cc9a
0101d8d9 4c8d8570070000 lea r8, [rbp + 0x770]
0101d8e0 ba50545448 mov edx, 0x48545450
0101d8e5 498b4e08 mov rcx, qword ptr [r14 + 8]
0101d8e9 e88217eaff call 0x140ebf070
0101d8ee 4885c0 test rax, rax
0101d8f1 744d je 0x14101d940
0101d8f3 488b4808 mov rcx, qword ptr [rax + 8]
0101d8f7 498b5670 mov rdx, qword ptr [r14 + 0x70]
0101d8fb 4885c9 test rcx, rcx
0101d8fe 7440 je 0x14101d940
0101d900 f6424b01 test byte ptr [rdx + 0x4b], 1
0101d904 743a je 0x14101d940
0101d906 488b4960 mov rcx, qword ptr [rcx + 0x60]
0101d90a 4885c9 test rcx, rcx
0101d90d 7431 je 0x14101d940
0101d90f 4c8b02 mov r8, qword ptr [rdx]
0101d912 4c3901 cmp qword ptr [rcx], r8
0101d915 7517 jne 0x14101d92e
0101d917 488b4108 mov rax, qword ptr [rcx + 8]
0101d91b 4885c0 test rax, rax
0101d91e 740e je 0x14101d92e
0101d920 483bc2 cmp rax, rdx
0101d923 7412 je 0x14101d937
0101d925 488b4008 mov rax, qword ptr [rax + 8]
0101d929 4885c0 test rax, rax
0101d92c 75f2 jne 0x14101d920
0101d92e 488b4938 mov rcx, qword ptr [rcx + 0x38]
0101d932 4885c9 test rcx, rcx
0101d935 75db jne 0x14101d912
0101d937 4885c9 test rcx, rcx
0101d93a 0f8507010000 jne 0x14101da47
0101d940 4c8d442433 lea r8, [rsp + 0x33]
0101d945 488d542431 lea rdx, [rsp + 0x31]
0101d94a 488d8de00a0000 lea rcx, [rbp + 0xae0]
0101d951 e8aad9adff call 0x140afb300
0101d956 807c243300 cmp byte ptr [rsp + 0x33], 0
0101d95b 0f84c7000000 je 0x14101da28
0101d961 807c243100 cmp byte ptr [rsp + 0x31], 0
0101d966 0f85bc000000 jne 0x14101da28
0101d96c 4863d6 movsxd rdx, esi
0101d96f 0f57c0 xorps xmm0, xmm0
0101d972 f30f7f442440 movdqu xmmword ptr [rsp + 0x40], xmm0
0101d978 c744242850545448 mov dword ptr [rsp + 0x28], 0x48545450
0101d980 33db xor ebx, ebx
0101d982 895c2420 mov dword ptr [rsp + 0x20], ebx
0101d986 4c8d4c2440 lea r9, [rsp + 0x40]
0101d98b 4c8d85e00a0000 lea r8, [rbp + 0xae0]
0101d992 498b4e08 mov rcx, qword ptr [r14 + 8]
0101d996 e8b574eaff call 0x140ec4e50
0101d99b 4885c0 test rax, rax
0101d99e 7431 je 0x14101d9d1
0101d9a0 488b5008 mov rdx, qword ptr [rax + 8]
0101d9a4 4885d2 test rdx, rdx
0101d9a7 7428 je 0x14101d9d1
0101d9a9 48395a10 cmp qword ptr [rdx + 0x10], rbx
0101d9ad 7422 je 0x14101d9d1
0101d9af 0f57c0 xorps xmm0, xmm0
0101d9b2 f30f7f442468 movdqu xmmword ptr [rsp + 0x68], xmm0
0101d9b8 488d442468 lea rax, [rsp + 0x68]
0101d9bd 4889442420 mov qword ptr [rsp + 0x20], rax
0101d9c2 4533c9 xor r9d, r9d
0101d9c5 4d8bc4 mov r8, r12
0101d9c8 498bce mov rcx, r14
0101d9cb e8b067edff call 0x140ef4180
0101d9d0 90 nop 
0101d9d1 488b4c2440 mov rcx, qword ptr [rsp + 0x40]
0101d9d6 48c7c6ffffffff mov rsi, 0xffffffffffffffff
0101d9dd 4885c9 test rcx, rcx
0101d9e0 741d je 0x14101d9ff
0101d9e2 8bc6 mov eax, esi
0101d9e4 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0101d9e9 83f801 cmp eax, 1
0101d9ec 750c jne 0x14101d9fa
0101d9ee c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0101d9f5 e8dee37700 call 0x14179bdd8
0101d9fa 48895c2440 mov qword ptr [rsp + 0x40], rbx
0101d9ff 488b4c2448 mov rcx, qword ptr [rsp + 0x48]
0101da04 4885c9 test rcx, rcx
0101da07 7445 je 0x14101da4e
0101da09 8bc6 mov eax, esi
0101da0b f00fc14108 lock xadd dword ptr [rcx + 8], eax
0101da10 83f801 cmp eax, 1
0101da13 750c jne 0x14101da21
0101da15 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0101da1c e8b7e37700 call 0x14179bdd8
0101da21 48895c2448 mov qword ptr [rsp + 0x48], rbx
0101da26 eb26 jmp 0x14101da4e
0101da28 c744242007000000 mov dword ptr [rsp + 0x20], 7
0101da30 448bce mov r9d, esi
0101da33 4c8d85e00a0000 lea r8, [rbp + 0xae0]
0101da3a 410fb75610 movzx edx, word ptr [r14 + 0x10]
0101da3f 498bcf mov rcx, r15
0101da42 e8e9b1fdff call 0x140ff8c30
0101da47 48c7c6ffffffff mov rsi, 0xffffffffffffffff
0101da4e 488b7c2438 mov rdi, qword ptr [rsp + 0x38]
0101da53 41ffc5 inc r13d
0101da56 0fb74704 movzx eax, word ptr [rdi + 4]
0101da5a 443be8 cmp r13d, eax
0101da5d 0f82eefcffff jb 0x14101d751
0101da63 33db xor ebx, ebx
0101da65 4d85ff test r15, r15
0101da68 7438 je 0x14101daa2
0101da6a 4181bf8000000074616474 cmp dword ptr [r15 + 0x80], 0x74646174
0101da75 752b jne 0x14101daa2
0101da77 4180bf1801000005 cmp byte ptr [r15 + 0x118], 5
0101da7f 7421 je 0x14101daa2
0101da81 41c6871801000005 mov byte ptr [r15 + 0x118], 5
0101da89 498b07 mov rax, qword ptr [r15]
0101da8c 48895c2420 mov qword ptr [rsp + 0x20], rbx
0101da91 4533c9 xor r9d, r9d
0101da94 4d8bc7 mov r8, r15
0101da97 ba70706474 mov edx, 0x74647070
0101da9c 498bcf mov rcx, r15
0101da9f ff5008 call qword ptr [rax + 8]
0101daa2 498bcf mov rcx, r15
0101daa5 e8b6d20600 call 0x14108ad60
0101daaa 498bcf mov rcx, r15
0101daad e80e3cf5ff call 0x140f716c0
0101dab2 488b45b0 mov rax, qword ptr [rbp - 0x50]
0101dab6 4885c0 test rax, rax
0101dab9 7416 je 0x14101dad1
0101dabb 48895c2420 mov qword ptr [rsp + 0x20], rbx
0101dac0 4533c9 xor r9d, r9d
0101dac3 4533c0 xor r8d, r8d
0101dac6 ba6d727064 mov edx, 0x6470726d
0101dacb 488d4db0 lea rcx, [rbp - 0x50]
0101dacf ffd0 call rax
0101dad1 4d85ff test r15, r15
0101dad4 7438 je 0x14101db0e
0101dad6 4181bf8000000074616474 cmp dword ptr [r15 + 0x80], 0x74646174
0101dae1 752b jne 0x14101db0e
0101dae3 4180bf1801000006 cmp byte ptr [r15 + 0x118], 6
0101daeb 7421 je 0x14101db0e
0101daed 41c6871801000006 mov byte ptr [r15 + 0x118], 6
0101daf5 498b07 mov rax, qword ptr [r15]
0101daf8 48895c2420 mov qword ptr [rsp + 0x20], rbx
0101dafd 4533c9 xor r9d, r9d
0101db00 4d8bc7 mov r8, r15
0101db03 ba646c6474 mov edx, 0x74646c64
0101db08 498bcf mov rcx, r15
0101db0b ff5008 call qword ptr [rax + 8]
0101db0e 807c243400 cmp byte ptr [rsp + 0x34], 0
0101db13 0f84d4050000 je 0x14101e0ed
0101db19 e842ab5dff call 0x1405f8660
0101db1e 0fb6f8 movzx edi, al
0101db21 488b1d08940801 mov rbx, qword ptr [rip + 0x1089408]
0101db28 4885db test rbx, rbx
0101db2b 0f84bc050000 je 0x14101e0ed
0101db31 488b9b90410100 mov rbx, qword ptr [rbx + 0x14190]
0101db38 4885db test rbx, rbx
0101db3b 0f84ac050000 je 0x14101e0ed
0101db41 e86aa35eff call 0x140607eb0
0101db46 84c0 test al, al
0101db48 0f849f050000 je 0x14101e0ed
0101db4e 488b4342 mov rax, qword ptr [rbx + 0x42]
0101db52 4885c0 test rax, rax
0101db55 7406 je 0x14101db5d
0101db57 48833800 cmp qword ptr [rax], 0
0101db5b 7517 jne 0x14101db74
0101db5d 488b434a mov rax, qword ptr [rbx + 0x4a]
0101db61 4885c0 test rax, rax
0101db64 0f8483050000 je 0x14101e0ed
0101db6a 48833800 cmp qword ptr [rax], 0
0101db6e 0f8479050000 je 0x14101e0ed
0101db74 8bcf mov ecx, edi
0101db76 4084ff test dil, dil
0101db79 0f84de040000 je 0x14101e05d
0101db7f 83e901 sub ecx, 1
0101db82 0f84d5040000 je 0x14101e05d
0101db88 83e901 sub ecx, 1
0101db8b 0f84cc040000 je 0x14101e05d
0101db91 83f905 cmp ecx, 5
0101db94 0f84c3040000 je 0x14101e05d
0101db9a b001 mov al, 1
0101db9c e9be040000 jmp 0x14101e05f
0101dba1 4c8d8570070000 lea r8, [rbp + 0x770]
0101dba8 418bd5 mov edx, r13d
0101dbab 488bcf mov rcx, rdi
0101dbae e84ddcffff call 0x14101b800
0101dbb3 488b8d80070000 mov rcx, qword ptr [rbp + 0x780]
0101dbba 4885c9 test rcx, rcx
0101dbbd 0f8490feffff je 0x14101da53
0101dbc3 8b8570070000 mov eax, dword ptr [rbp + 0x770]
0101dbc9 3d50434641 cmp eax, 0x41464350
0101dbce 740b je 0x14101dbdb
0101dbd0 3d506e6957 cmp eax, 0x57696e50
0101dbd5 0f8578feffff jne 0x14101da53
0101dbdb 488b81f0000000 mov rax, qword ptr [rcx + 0xf0]
0101dbe2 4885c0 test rax, rax
0101dbe5 0f8468feffff je 0x14101da53
0101dbeb 4c8d8dc0020000 lea r9, [rbp + 0x2c0]
0101dbf2 41b001 mov r8b, 1
0101dbf5 488d9510030000 lea rdx, [rbp + 0x310]
0101dbfc 488d8d70070000 lea rcx, [rbp + 0x770]
0101dc03 ffd0 call rax
0101dc05 85c0 test eax, eax
0101dc07 0f8546feffff jne 0x14101da53
0101dc0d c6853005000001 mov byte ptr [rbp + 0x530], 1
0101dc14 3885c0020000 cmp byte ptr [rbp + 0x2c0], al
0101dc1a 7449 je 0x14101dc65
0101dc1c 488d8d10030000 lea rcx, [rbp + 0x310]
0101dc23 e8580ae8ff call 0x140e9e680
0101dc28 84c0 test al, al
0101dc2a 7539 jne 0x14101dc65
0101dc2c 88459f mov byte ptr [rbp - 0x61], al
0101dc2f ba01000000 mov edx, 1
0101dc34 488d4580 lea rax, [rbp - 0x80]
0101dc38 4889442420 mov qword ptr [rsp + 0x20], rax
0101dc3d 4c8d0decdeffff lea r9, [rip - 0x2114]
0101dc44 448bc2 mov r8d, edx
0101dc47 488d8d10030000 lea rcx, [rbp + 0x310]
0101dc4e e89d09b0ff call 0x140b1e5f0
0101dc53 83f880 cmp eax, -0x80
0101dc56 0f8407feffff je 0x14101da63
0101dc5c c6459f01 mov byte ptr [rbp - 0x61], 1
0101dc60 e9eefdffff jmp 0x14101da53
0101dc65 488b8d20030000 mov rcx, qword ptr [rbp + 0x320]
0101dc6c 4885c9 test rcx, rcx
0101dc6f 744a je 0x14101dcbb
0101dc71 8b8510030000 mov eax, dword ptr [rbp + 0x310]
0101dc77 3d50434641 cmp eax, 0x41464350
0101dc7c 7407 je 0x14101dc85
0101dc7e 3d506e6957 cmp eax, 0x57696e50
0101dc83 7536 jne 0x14101dcbb
0101dc85 488b4108 mov rax, qword ptr [rcx + 8]
0101dc89 4533c0 xor r8d, r8d
0101dc8c 488d9570020000 lea rdx, [rbp + 0x270]
0101dc93 488d8d10030000 lea rcx, [rbp + 0x310]
0101dc9a ffd0 call rax
0101dc9c 85c0 test eax, eax
0101dc9e 751b jne 0x14101dcbb
0101dca0 8b8598020000 mov eax, dword ptr [rbp + 0x298]
0101dca6 80bd7002000000 cmp byte ptr [rbp + 0x270], 0
0101dcad b9646c6f66 mov ecx, 0x666f6c64
0101dcb2 0f45c1 cmovne eax, ecx
0101dcb5 898534050000 mov dword ptr [rbp + 0x534], eax
0101dcbb 807c243200 cmp byte ptr [rsp + 0x32], 0
0101dcc0 751d jne 0x14101dcdf
0101dcc2 807d9d00 cmp byte ptr [rbp - 0x63], 0
0101dcc6 7517 jne 0x14101dcdf
0101dcc8 488d9510030000 lea rdx, [rbp + 0x310]
0101dccf 498bce mov rcx, r14
0101dcd2 e8f921edff call 0x140eefed0
0101dcd7 84c0 test al, al
0101dcd9 0f8574fdffff jne 0x14101da53
0101dcdf 498b0424 mov rax, qword ptr [r12]
0101dce3 4885c0 test rax, rax
0101dce6 0f8467fdffff je 0x14101da53
0101dcec 488b08 mov rcx, qword ptr [rax]
0101dcef 4885c9 test rcx, rcx
0101dcf2 0f845bfdffff je 0x14101da53
0101dcf8 813974736c70 cmp dword ptr [rcx], 0x706c7374
0101dcfe 0f854ffdffff jne 0x14101da53
0101dd04 83782800 cmp dword ptr [rax + 0x28], 0
0101dd08 0f8445fdffff je 0x14101da53
0101dd0e 33c0 xor eax, eax
0101dd10 48c7442448454c4946 mov qword ptr [rsp + 0x48], 0x46494c45
0101dd19 4889442458 mov qword ptr [rsp + 0x58], rax
0101dd1e 4c89642440 mov qword ptr [rsp + 0x40], r12
0101dd23 488d8510030000 lea rax, [rbp + 0x310]
0101dd2a 4889442450 mov qword ptr [rsp + 0x50], rax
0101dd2f 4c8d442440 lea r8, [rsp + 0x40]
0101dd34 ba69616c70 mov edx, 0x706c6169
0101dd39 e84268edff call 0x140ef4580
0101dd3e 85c0 test eax, eax
0101dd40 0f850dfdffff jne 0x14101da53
0101dd46 0f57c0 xorps xmm0, xmm0
0101dd49 33c0 xor eax, eax
0101dd4b 0f1145e4 movups xmmword ptr [rbp - 0x1c], xmm0
0101dd4f 0f1145f4 movups xmmword ptr [rbp - 0xc], xmm0
0101dd53 894504 mov dword ptr [rbp + 4], eax
0101dd56 488d5580 lea rdx, [rbp - 0x80]
0101dd5a 488d8d10030000 lea rcx, [rbp + 0x310]
0101dd61 e8fa9ee8ff call 0x140ea7c60
0101dd66 83f880 cmp eax, -0x80
0101dd69 0f84f4fcffff je 0x14101da63
0101dd6f 85c0 test eax, eax
0101dd71 0f85dcfcffff jne 0x14101da53
0101dd77 38843b84020000 cmp byte ptr [rbx + rdi + 0x284], al
0101dd7e 0f84cffcffff je 0x14101da53
0101dd84 3945f4 cmp dword ptr [rbp - 0xc], eax
0101dd87 0f84c6fcffff je 0x14101da53
0101dd8d 3945f0 cmp dword ptr [rbp - 0x10], eax
0101dd90 7466 je 0x14101ddf8
0101dd92 8b5de4 mov ebx, dword ptr [rbp - 0x1c]
0101dd95 85db test ebx, ebx
0101dd97 0f84b6fcffff je 0x14101da53
0101dd9d ff152dca8c00 call qword ptr [rip + 0x8cca2d]
0101dda3 8bc8 mov ecx, eax
0101dda5 e83623bbff call 0x140bd00e0
0101ddaa 84c0 test al, al
0101ddac 7432 je 0x14101dde0
0101ddae 488b0ddbe60b01 mov rcx, qword ptr [rip + 0x10be6db]
0101ddb5 4885c9 test rcx, rcx
0101ddb8 7426 je 0x14101dde0
0101ddba 660f1f440000 nop word ptr [rax + rax]
0101ddc0 399990000000 cmp dword ptr [rcx + 0x90], ebx
0101ddc6 741a je 0x14101dde2
0101ddc8 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0101ddd2 750c jne 0x14101dde0
0101ddd4 488b4178 mov rax, qword ptr [rcx + 0x78]
0101ddd8 488bc8 mov rcx, rax
0101dddb 4885c0 test rax, rax
0101ddde 75e0 jne 0x14101ddc0
0101dde0 33c9 xor ecx, ecx
0101dde2 4885c9 test rcx, rcx
0101dde5 0f8468fcffff je 0x14101da53
0101ddeb 8b55f0 mov edx, dword ptr [rbp - 0x10]
0101ddee e8ad88edff call 0x140ef66a0
0101ddf3 e9b0000000 jmp 0x14101dea8
0101ddf8 8b7de4 mov edi, dword ptr [rbp - 0x1c]
0101ddfb 85ff test edi, edi
0101ddfd 0f844bfcffff je 0x14101da4e
0101de03 ff15c7c98c00 call qword ptr [rip + 0x8cc9c7]
0101de09 8bc8 mov ecx, eax
0101de0b e8d022bbff call 0x140bd00e0
0101de10 84c0 test al, al
0101de12 742c je 0x14101de40
0101de14 488b1d75e60b01 mov rbx, qword ptr [rip + 0x10be675]
0101de1b 4885db test rbx, rbx
0101de1e 7420 je 0x14101de40
0101de20 39bb90000000 cmp dword ptr [rbx + 0x90], edi
0101de26 741a je 0x14101de42
0101de28 81bb8000000074616474 cmp dword ptr [rbx + 0x80], 0x74646174
0101de32 750c jne 0x14101de40
0101de34 488b4378 mov rax, qword ptr [rbx + 0x78]
0101de38 488bd8 mov rbx, rax
0101de3b 4885c0 test rax, rax
0101de3e 75e0 jne 0x14101de20
0101de40 33db xor ebx, ebx
0101de42 4885db test rbx, rbx
0101de45 0f8403fcffff je 0x14101da4e
0101de4b 8b55f0 mov edx, dword ptr [rbp - 0x10]
0101de4e 85d2 test edx, edx
0101de50 7421 je 0x14101de73
0101de52 488bcb mov rcx, rbx
0101de55 e84688edff call 0x140ef66a0
0101de5a 4885c0 test rax, rax
0101de5d 7414 je 0x14101de73
0101de5f 8b55f4 mov edx, dword ptr [rbp - 0xc]
0101de62 85d2 test edx, edx
0101de64 740d je 0x14101de73
0101de66 488bc8 mov rcx, rax
0101de69 e8d267edff call 0x140ef4640
0101de6e 4885c0 test rax, rax
0101de71 752d jne 0x14101dea0
0101de73 8b55e8 mov edx, dword ptr [rbp - 0x18]
0101de76 85d2 test edx, edx
0101de78 0f84d0fbffff je 0x14101da4e
0101de7e 488bcb mov rcx, rbx
0101de81 e85a9ee9ff call 0x140eb7ce0
0101de86 4885c0 test rax, rax
0101de89 0f84bffbffff je 0x14101da4e
0101de8f 488bc8 mov rcx, rax
0101de92 e87994edff call 0x140ef7310
0101de97 4885c0 test rax, rax
0101de9a 0f84aefbffff je 0x14101da4e
0101dea0 488b00 mov rax, qword ptr [rax]
0101dea3 488b7c2438 mov rdi, qword ptr [rsp + 0x38]
0101dea8 4885c0 test rax, rax
0101deab 0f84a2fbffff je 0x14101da53
0101deb1 8b55f4 mov edx, dword ptr [rbp - 0xc]
0101deb4 488bc8 mov rcx, rax
0101deb7 e88467edff call 0x140ef4640
0101debc 4885c0 test rax, rax
0101debf 0f848efbffff je 0x14101da53
0101dec5 488b5830 mov rbx, qword ptr [rax + 0x30]
0101dec9 488b7b58 mov rdi, qword ptr [rbx + 0x58]
0101decd 488d9550050000 lea rdx, [rbp + 0x550]
0101ded4 488bcf mov rcx, rdi
0101ded7 e8e4a6f8ff call 0x140fa85c0
0101dedc 85c0 test eax, eax
0101dede 0f856afbffff jne 0x14101da4e
0101dee4 4c8d85e00a0000 lea r8, [rbp + 0xae0]
0101deeb 488bd7 mov rdx, rdi
0101deee 488b4b10 mov rcx, qword ptr [rbx + 0x10]
0101def2 e88921ebff call 0x140ed0080
0101def7 85c0 test eax, eax
0101def9 0f854ffbffff jne 0x14101da4e
0101deff 488b8d60050000 mov rcx, qword ptr [rbp + 0x560]
0101df06 4885c9 test rcx, rcx
0101df09 0f843ffbffff je 0x14101da4e
0101df0f 8b8550050000 mov eax, dword ptr [rbp + 0x550]
0101df15 3d50434641 cmp eax, 0x41464350
0101df1a 740b je 0x14101df27
0101df1c 3d506e6957 cmp eax, 0x57696e50
0101df21 0f8527fbffff jne 0x14101da4e
0101df27 4883bdf00a000000 cmp qword ptr [rbp + 0xaf0], 0
0101df2f 0f8419fbffff je 0x14101da4e
0101df35 8b85e00a0000 mov eax, dword ptr [rbp + 0xae0]
0101df3b 3d50434641 cmp eax, 0x41464350
0101df40 740b je 0x14101df4d
0101df42 3d506e6957 cmp eax, 0x57696e50
0101df47 0f8501fbffff jne 0x14101da4e
0101df4d 488b8188000000 mov rax, qword ptr [rcx + 0x88]
0101df54 4885c0 test rax, rax
0101df57 0f84f1faffff je 0x14101da4e
0101df5d 4c8d8550050000 lea r8, [rbp + 0x550]
0101df64 488d95e00a0000 lea rdx, [rbp + 0xae0]
0101df6b 488d8d50050000 lea rcx, [rbp + 0x550]
0101df72 ffd0 call rax
0101df74 85c0 test eax, eax
0101df76 0f85d2faffff jne 0x14101da4e
0101df7c 4885ff test rdi, rdi
0101df7f 0f84cb000000 je 0x14101e050
0101df85 488b4708 mov rax, qword ptr [rdi + 8]
0101df89 4885c0 test rax, rax
0101df8c 0f84be000000 je 0x14101e050
0101df92 4883781000 cmp qword ptr [rax + 0x10], 0
0101df97 0f84b3000000 je 0x14101e050
0101df9d 488d4778 lea rax, [rdi + 0x78]
0101dfa1 488d8d50050000 lea rcx, [rbp + 0x550]
0101dfa8 ba04000000 mov edx, 4
0101dfad 0f1f00 nop dword ptr [rax]
0101dfb0 0f1001 movups xmm0, xmmword ptr [rcx]
0101dfb3 0f1100 movups xmmword ptr [rax], xmm0
0101dfb6 0f104910 movups xmm1, xmmword ptr [rcx + 0x10]
0101dfba 0f114810 movups xmmword ptr [rax + 0x10], xmm1
0101dfbe 0f104120 movups xmm0, xmmword ptr [rcx + 0x20]
0101dfc2 0f114020 movups xmmword ptr [rax + 0x20], xmm0
0101dfc6 0f104930 movups xmm1, xmmword ptr [rcx + 0x30]
0101dfca 0f114830 movups xmmword ptr [rax + 0x30], xmm1
0101dfce 0f104140 movups xmm0, xmmword ptr [rcx + 0x40]
0101dfd2 0f114040 movups xmmword ptr [rax + 0x40], xmm0
0101dfd6 0f104950 movups xmm1, xmmword ptr [rcx + 0x50]
0101dfda 0f114850 movups xmmword ptr [rax + 0x50], xmm1
0101dfde 0f104160 movups xmm0, xmmword ptr [rcx + 0x60]
0101dfe2 0f114060 movups xmmword ptr [rax + 0x60], xmm0
0101dfe6 488d8080000000 lea rax, [rax + 0x80]
0101dfed 0f104970 movups xmm1, xmmword ptr [rcx + 0x70]
0101dff1 0f1148f0 movups xmmword ptr [rax - 0x10], xmm1
0101dff5 488d8980000000 lea rcx, [rcx + 0x80]
0101dffc 4883ea01 sub rdx, 1
0101e000 75ae jne 0x14101dfb0
0101e002 0f1001 movups xmm0, xmmword ptr [rcx]
0101e005 0f1100 movups xmmword ptr [rax], xmm0
0101e008 0f104910 movups xmm1, xmmword ptr [rcx + 0x10]
0101e00c 0f114810 movups xmmword ptr [rax + 0x10], xmm1
0101e010 c6879802000001 mov byte ptr [rdi + 0x298], 1
0101e017 33db xor ebx, ebx
0101e019 48399d60050000 cmp qword ptr [rbp + 0x560], rbx
0101e020 7428 je 0x14101e04a
0101e022 8b8550050000 mov eax, dword ptr [rbp + 0x550]
0101e028 3d50434641 cmp eax, 0x41464350
0101e02d 7407 je 0x14101e036
0101e02f 3d506e6957 cmp eax, 0x57696e50
0101e034 7514 jne 0x14101e04a
0101e036 488d8d50050000 lea rcx, [rbp + 0x550]
0101e03d e80ef7afff call 0x140b1d750
0101e042 4885c0 test rax, rax
0101e045 7403 je 0x14101e04a
0101e047 8b5814 mov ebx, dword ptr [rax + 0x14]
0101e04a 899fa4020000 mov dword ptr [rdi + 0x2a4], ebx
0101e050 488bcf mov rcx, rdi
0101e053 e888bde9ff call 0x140eb9de0
0101e058 e9f1f9ffff jmp 0x14101da4e
0101e05d 32c0 xor al, al
0101e05f 84c0 test al, al
0101e061 0f8486000000 je 0x14101e0ed
0101e067 48833d690e0e01ff cmp qword ptr [rip + 0x10e0e69], -1
0101e06f 7416 je 0x14101e087
0101e071 4c8d05988b5dff lea r8, [rip - 0xa27468]
0101e078 33d2 xor edx, edx
0101e07a 488d0d570e0e01 lea rcx, [rip + 0x10e0e57]
0101e081 ff15a9ec8c00 call qword ptr [rip + 0x8ceca9]
0101e087 488b1d720e0b01 mov rbx, qword ptr [rip + 0x10b0e72]
0101e08e 4885db test rbx, rbx
0101e091 740b je 0x14101e09e
0101e093 f0ff4308 lock inc dword ptr [rbx + 8]
0101e097 488b1d620e0b01 mov rbx, qword ptr [rip + 0x10b0e62]
0101e09e 0f1005530e0b01 movups xmm0, xmmword ptr [rip + 0x10b0e53]
0101e0a5 0f11442440 movups xmmword ptr [rsp + 0x40], xmm0
0101e0aa 66480f7ec1 movq rcx, xmm0
0101e0af 4885c9 test rcx, rcx
0101e0b2 740d je 0x14101e0c1
0101e0b4 488b01 mov rax, qword ptr [rcx]
0101e0b7 498bd6 mov rdx, r14
0101e0ba ff9048010000 call qword ptr [rax + 0x148]
0101e0c0 90 nop 
0101e0c1 4885db test rbx, rbx
0101e0c4 7427 je 0x14101e0ed
0101e0c6 8bc6 mov eax, esi
0101e0c8 f00fc14308 lock xadd dword ptr [rbx + 8], eax
0101e0cd 83f801 cmp eax, 1
0101e0d0 751b jne 0x14101e0ed
0101e0d2 488b03 mov rax, qword ptr [rbx]
0101e0d5 488bcb mov rcx, rbx
0101e0d8 ff10 call qword ptr [rax]
0101e0da f00fc1730c lock xadd dword ptr [rbx + 0xc], esi
0101e0df 83fe01 cmp esi, 1
0101e0e2 7509 jne 0x14101e0ed
0101e0e4 488b03 mov rax, qword ptr [rbx]
0101e0e7 488bcb mov rcx, rbx
0101e0ea ff5008 call qword ptr [rax + 8]
0101e0ed 488d4d80 lea rcx, [rbp - 0x80]
0101e0f1 e81a4be8ff call 0x140ea2c10
0101e0f6 488b5d90 mov rbx, qword ptr [rbp - 0x70]
0101e0fa 4885db test rbx, rbx
0101e0fd 0f84e1000000 je 0x14101e1e4
0101e103 41b801000000 mov r8d, 1
0101e109 488bd3 mov rdx, rbx
0101e10c 498bce mov rcx, r14
0101e10f e81c93edff call 0x140ef7430
0101e114 4032ff xor dil, dil
0101e117 4983bee001000000 cmp qword ptr [r14 + 0x1e0], 0
0101e11f 7436 je 0x14101e157
0101e121 49833c2400 cmp qword ptr [r12], 0
0101e126 742f je 0x14101e157
0101e128 0f57c0 xorps xmm0, xmm0
0101e12b f30f7f442448 movdqu xmmword ptr [rsp + 0x48], xmm0
0101e131 48c744245800000000 mov qword ptr [rsp + 0x58], 0
0101e13a 4c89642440 mov qword ptr [rsp + 0x40], r12
0101e13f 4c8d442440 lea r8, [rsp + 0x40]
0101e144 ba74726c70 mov edx, 0x706c7274
0101e149 498bce mov rcx, r14
0101e14c e82f64edff call 0x140ef4580
0101e151 85c0 test eax, eax
0101e153 400f94c7 sete dil
0101e157 4533c0 xor r8d, r8d
0101e15a ba6d616c70 mov edx, 0x706c616d
0101e15f 498bce mov rcx, r14
0101e162 e81964edff call 0x140ef4580
0101e167 41813e74736c70 cmp dword ptr [r14], 0x706c7374
0101e16e 754e jne 0x14101e1be
0101e170 498b5e70 mov rbx, qword ptr [r14 + 0x70]
0101e174 4885db test rbx, rbx
0101e177 7445 je 0x14101e1be
0101e179 488b03 mov rax, qword ptr [rbx]
0101e17c 4885c0 test rax, rax
0101e17f 743d je 0x14101e1be
0101e181 813874736c70 cmp dword ptr [rax], 0x706c7374
0101e187 7535 jne 0x14101e1be
0101e189 837b2800 cmp dword ptr [rbx + 0x28], 0
0101e18d 742f je 0x14101e1be
0101e18f f6434b01 test byte ptr [rbx + 0x4b], 1
0101e193 7422 je 0x14101e1b7
0101e195 c7432c00000000 mov dword ptr [rbx + 0x2c], 0
0101e19c 4533c0 xor r8d, r8d
0101e19f 488d15fa81edff lea rdx, [rip - 0x127e06]
0101e1a6 488bcb mov rcx, rbx
0101e1a9 e86212edff call 0x140eef410
0101e1ae 488b03 mov rax, qword ptr [rbx]
0101e1b1 483b5870 cmp rbx, qword ptr [rax + 0x70]
0101e1b5 7507 jne 0x14101e1be
0101e1b7 c7432c00000000 mov dword ptr [rbx + 0x2c], 0
0101e1be 4084ff test dil, dil
0101e1c1 7415 je 0x14101e1d8
0101e1c3 41813e74736c70 cmp dword ptr [r14], 0x706c7374
0101e1ca 750c jne 0x14101e1d8
0101e1cc 498b8e08040000 mov rcx, qword ptr [r14 + 0x408]
0101e1d3 e80853f4ff call 0x140f634e0
0101e1d8 498bce mov rcx, r14
0101e1db e87009edff call 0x140eeeb50
0101e1e0 488b5d90 mov rbx, qword ptr [rbp - 0x70]
0101e1e4 4c8b6c2460 mov r13, qword ptr [rsp + 0x60]
0101e1e9 4885db test rbx, rbx
0101e1ec 742d je 0x14101e21b
0101e1ee 813b54534c4f cmp dword ptr [rbx], 0x4f4c5354
0101e1f4 7525 jne 0x14101e21b
0101e1f6 8b4304 mov eax, dword ptr [rbx + 4]
0101e1f9 85c0 test eax, eax
0101e1fb 741e je 0x14101e21b
0101e1fd 83e801 sub eax, 1
0101e200 894304 mov dword ptr [rbx + 4], eax
0101e203 7516 jne 0x14101e21b
0101e205 488d4b08 lea rcx, [rbx + 8]
0101e209 e8f2042cff call 0x1402de700
0101e20e ba20000000 mov edx, 0x20
0101e213 488bcb mov rcx, rbx
0101e216 e80588baff call 0x140bc6a20
0101e21b 488b8d50020000 mov rcx, qword ptr [rbp + 0x250]
0101e222 4885c9 test rcx, rcx
0101e225 7406 je 0x14101e22d
0101e227 ff153be18c00 call qword ptr [rip + 0x8ce13b]
0101e22d 488b8d38020000 mov rcx, qword ptr [rbp + 0x238]
0101e234 4885c9 test rcx, rcx
0101e237 741e je 0x14101e257
0101e239 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0101e243 7512 jne 0x14101e257
0101e245 8b8180200000 mov eax, dword ptr [rcx + 0x2080]
0101e24b 85c0 test eax, eax
0101e24d 7408 je 0x14101e257
0101e24f ffc8 dec eax
0101e251 898180200000 mov dword ptr [rcx + 0x2080], eax
0101e257 0fb6442430 movzx eax, byte ptr [rsp + 0x30]
0101e25c 4188859a000000 mov byte ptr [r13 + 0x9a], al
0101e263 488b8d000e0000 mov rcx, qword ptr [rbp + 0xe00]
0101e26a 4833cc xor rcx, rsp
0101e26d e86ed67700 call 0x14179b8e0
0101e272 488b9c24600f0000 mov rbx, qword ptr [rsp + 0xf60]
0101e27a 4881c4100f0000 add rsp, 0xf10
0101e281 415f pop r15
0101e283 415e pop r14
0101e285 415d pop r13
0101e287 415c pop r12
0101e289 5f pop rdi
0101e28a 5e pop rsi
0101e28b 5d pop rbp
0101e28c c3 ret 