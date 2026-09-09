0104d700 4885c9 test rcx, rcx
0104d703 0f843e050000 je 0x14104dc47
0104d709 48895c2410 mov qword ptr [rsp + 0x10], rbx
0104d70e 4889742418 mov qword ptr [rsp + 0x18], rsi
0104d713 48897c2420 mov qword ptr [rsp + 0x20], rdi
0104d718 55 push rbp
0104d719 4154 push r12
0104d71b 4155 push r13
0104d71d 4156 push r14
0104d71f 4157 push r15
0104d721 488d6c24f0 lea rbp, [rsp - 0x10]
0104d726 4881ec10010000 sub rsp, 0x110
0104d72d 488b050c79f800 mov rax, qword ptr [rip + 0xf8790c]
0104d734 4833c4 xor rax, rsp
0104d737 48894500 mov qword ptr [rbp], rax
0104d73b 8bda mov ebx, edx
0104d73d 488bf9 mov rdi, rcx
0104d740 48894d80 mov qword ptr [rbp - 0x80], rcx
0104d744 4c8b7920 mov r15, qword ptr [rcx + 0x20]
0104d748 4d85ff test r15, r15
0104d74b 0f84b2040000 je 0x14104dc03
0104d751 8b4914 mov ecx, dword ptr [rcx + 0x14]
0104d754 e80754e8ff call 0x140ed2b60
0104d759 4c8be8 mov r13, rax
0104d75c 4885c0 test rax, rax
0104d75f 0f849e040000 je 0x14104dc03
0104d765 4533f6 xor r14d, r14d
0104d768 48c7c6ffffffff mov rsi, 0xffffffffffffffff
0104d76f 81b88000000074616474 cmp dword ptr [rax + 0x80], 0x74646174
0104d779 0f85e3030000 jne 0x14104db62
0104d77f 488bc8 mov rcx, rax
0104d782 e809e9e8ff call 0x140edc090
0104d787 4885c0 test rax, rax
0104d78a 0f84d2030000 je 0x14104db62
0104d790 488b4808 mov rcx, qword ptr [rax + 8]
0104d794 4c8b91e8200000 mov r10, qword ptr [rcx + 0x20e8]
0104d79b 41899a5c0e0000 mov dword ptr [r10 + 0xe5c], ebx
0104d7a2 85db test ebx, ebx
0104d7a4 0f85b8030000 jne 0x14104db62
0104d7aa 498d8a5c0a0000 lea rcx, [r10 + 0xa5c]
0104d7b1 498d5704 lea rdx, [r15 + 4]
0104d7b5 488bd8 mov rbx, rax
0104d7b8 4889442468 mov qword ptr [rsp + 0x68], rax
0104d7bd 41bbff000000 mov r11d, 0xff
0104d7c3 41b8fe000000 mov r8d, 0xfe
0104d7c9 4885d2 test rdx, rdx
0104d7cc 7456 je 0x14104d824
0104d7ce 4889442468 mov qword ptr [rsp + 0x68], rax
0104d7d3 4885c9 test rcx, rcx
0104d7d6 744c je 0x14104d824
0104d7d8 440fb70a movzx r9d, word ptr [rdx]
0104d7dc 4883c202 add rdx, 2
0104d7e0 453bcb cmp r9d, r11d
0104d7e3 760d jbe 0x14104d7f2
0104d7e5 66448919 mov word ptr [rcx], r11w
0104d7e9 4883c102 add rcx, 2
0104d7ed 458bc8 mov r9d, r8d
0104d7f0 eb13 jmp 0x14104d805
0104d7f2 66448909 mov word ptr [rcx], r9w
0104d7f6 4883c102 add rcx, 2
0104d7fa 4183e901 sub r9d, 1
0104d7fe 4889442468 mov qword ptr [rsp + 0x68], rax
0104d803 781f js 0x14104d824
0104d805 488bd8 mov rbx, rax
0104d808 4889442468 mov qword ptr [rsp + 0x68], rax
0104d80d 0f1f00 nop dword ptr [rax]
0104d810 0fb702 movzx eax, word ptr [rdx]
0104d813 488d5202 lea rdx, [rdx + 2]
0104d817 668901 mov word ptr [rcx], ax
0104d81a 488d4902 lea rcx, [rcx + 2]
0104d81e 4183e901 sub r9d, 1
0104d822 79ec jns 0x14104d810
0104d824 498d8a5c0c0000 lea rcx, [r10 + 0xc5c]
0104d82b 498d9704020000 lea rdx, [r15 + 0x204]
0104d832 4885d2 test rdx, rdx
0104d835 743f je 0x14104d876
0104d837 4885c9 test rcx, rcx
0104d83a 743a je 0x14104d876
0104d83c 0fb702 movzx eax, word ptr [rdx]
0104d83f 4883c202 add rdx, 2
0104d843 413bc3 cmp eax, r11d
0104d846 760a jbe 0x14104d852
0104d848 66448919 mov word ptr [rcx], r11w
0104d84c 4883c102 add rcx, 2
0104d850 eb10 jmp 0x14104d862
0104d852 668901 mov word ptr [rcx], ax
0104d855 4883c102 add rcx, 2
0104d859 448d40ff lea r8d, [rax - 1]
0104d85d 4585c0 test r8d, r8d
0104d860 7814 js 0x14104d876
0104d862 0fb702 movzx eax, word ptr [rdx]
0104d865 488d5202 lea rdx, [rdx + 2]
0104d869 668901 mov word ptr [rcx], ax
0104d86c 488d4902 lea rcx, [rcx + 2]
0104d870 4183e801 sub r8d, 1
0104d874 79ec jns 0x14104d862
0104d876 410fb787040e0000 movzx eax, word ptr [r15 + 0xe04]
0104d87e 6689442464 mov word ptr [rsp + 0x64], ax
0104d883 410fb787060e0000 movzx eax, word ptr [r15 + 0xe06]
0104d88b 6689442460 mov word ptr [rsp + 0x60], ax
0104d890 4181bd8000000074616474 cmp dword ptr [r13 + 0x80], 0x74646174
0104d89b 752b jne 0x14104d8c8
0104d89d 41ff859c000000 inc dword ptr [r13 + 0x9c]
0104d8a4 4183bd9c00000001 cmp dword ptr [r13 + 0x9c], 1
0104d8ac 751a jne 0x14104d8c8
0104d8ae 498b4500 mov rax, qword ptr [r13]
0104d8b2 4c89742420 mov qword ptr [rsp + 0x20], r14
0104d8b7 4533c9 xor r9d, r9d
0104d8ba 4d8bc5 mov r8, r13
0104d8bd ba43426474 mov edx, 0x74644243
0104d8c2 498bcd mov rcx, r13
0104d8c5 ff5008 call qword ptr [rax + 8]
0104d8c8 498d87080e0000 lea rax, [r15 + 0xe08]
0104d8cf 498d8f040a0000 lea rcx, [r15 + 0xa04]
0104d8d6 4d8d9704080000 lea r10, [r15 + 0x804]
0104d8dd 4d8d8f040c0000 lea r9, [r15 + 0xc04]
0104d8e4 4d8d8704060000 lea r8, [r15 + 0x604]
0104d8eb 498d9704040000 lea rdx, [r15 + 0x404]
0104d8f2 c644245801 mov byte ptr [rsp + 0x58], 1
0104d8f7 4c8d5c2460 lea r11, [rsp + 0x60]
0104d8fc 4c895c2450 mov qword ptr [rsp + 0x50], r11
0104d901 4c8d5c2464 lea r11, [rsp + 0x64]
0104d906 4c895c2448 mov qword ptr [rsp + 0x48], r11
0104d90b 4889442438 mov qword ptr [rsp + 0x38], rax
0104d910 4c897c2430 mov qword ptr [rsp + 0x30], r15
0104d915 48894c2428 mov qword ptr [rsp + 0x28], rcx
0104d91a 4c89542420 mov qword ptr [rsp + 0x20], r10
0104d91f 488bcb mov rcx, rbx
0104d922 e8d9ef0300 call 0x14108c900
0104d927 458be6 mov r12d, r14d
0104d92a 44397730 cmp dword ptr [rdi + 0x30], r14d
0104d92e 0f8605020000 jbe 0x14104db39
0104d934 458bcc mov r9d, r12d
0104d937 4533c0 xor r8d, r8d
0104d93a ba73000000 mov edx, 0x73
0104d93f 488b8b08040000 mov rcx, qword ptr [rbx + 0x408]
0104d946 e87595f1ff call 0x140f66ec0
0104d94b 4c8bf0 mov r14, rax
0104d94e 4885c0 test rax, rax
0104d951 0f84d2010000 je 0x14104db29
0104d957 488b08 mov rcx, qword ptr [rax]
0104d95a 4885c9 test rcx, rcx
0104d95d 0f84c6010000 je 0x14104db29
0104d963 813974736c70 cmp dword ptr [rcx], 0x706c7374
0104d969 0f85ba010000 jne 0x14104db29
0104d96f 83782800 cmp dword ptr [rax + 0x28], 0
0104d973 0f84b0010000 je 0x14104db29
0104d979 488b4830 mov rcx, qword ptr [rax + 0x30]
0104d97d 4885c9 test rcx, rcx
0104d980 0f84a3010000 je 0x14104db29
0104d986 4883791000 cmp qword ptr [rcx + 0x10], 0
0104d98b 0f8498010000 je 0x14104db29
0104d991 488b5958 mov rbx, qword ptr [rcx + 0x58]
0104d995 4885db test rbx, rbx
0104d998 0f8486010000 je 0x14104db24
0104d99e 6690 nop 
0104d9a0 488b4308 mov rax, qword ptr [rbx + 8]
0104d9a4 4885c0 test rax, rax
0104d9a7 7410 je 0x14104d9b9
0104d9a9 4883781000 cmp qword ptr [rax + 0x10], 0
0104d9ae 7409 je 0x14104d9b9
0104d9b0 817b3444524853 cmp dword ptr [rbx + 0x34], 0x53485244
0104d9b7 7508 jne 0x14104d9c1
0104d9b9 488b1b mov rbx, qword ptr [rbx]
0104d9bc 4885db test rbx, rbx
0104d9bf 75df jne 0x14104d9a0
0104d9c1 4885db test rbx, rbx
0104d9c4 0f845a010000 je 0x14104db24
0104d9ca 418bc4 mov eax, r12d
0104d9cd 4869f048060000 imul rsi, rax, 0x648
0104d9d4 4a8d3c3e lea rdi, [rsi + r15]
0104d9d8 6683bf100e000000 cmp word ptr [rdi + 0xe10], 0
0104d9e0 740c je 0x14104d9ee
0104d9e2 488d97100e0000 lea rdx, [rdi + 0xe10]
0104d9e9 e8128ef4ff call 0x140f96800
0104d9ee 488d9710100000 lea rdx, [rdi + 0x1010]
0104d9f5 66833a00 cmp word ptr [rdx], 0
0104d9f9 7409 je 0x14104da04
0104d9fb 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0104d9ff e83c9ff4ff call 0x140f97940
0104da04 488d9710120000 lea rdx, [rdi + 0x1210]
0104da0b 66833a00 cmp word ptr [rdx], 0
0104da0f 7409 je 0x14104da1a
0104da11 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0104da15 e826edf4ff call 0x140f9c740
0104da1a 420fb78c3e14140000 movzx ecx, word ptr [rsi + r15 + 0x1414]
0104da23 6685c9 test cx, cx
0104da26 740b je 0x14104da33
0104da28 498b4630 mov rax, qword ptr [r14 + 0x30]
0104da2c 6689882c010000 mov word ptr [rax + 0x12c], cx
0104da33 428b843e10140000 mov eax, dword ptr [rsi + r15 + 0x1410]
0104da3b 85c0 test eax, eax
0104da3d 7507 jne 0x14104da46
0104da3f 418b07 mov eax, dword ptr [r15]
0104da42 85c0 test eax, eax
0104da44 7415 je 0x14104da5b
0104da46 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0104da4a 668981a6000000 mov word ptr [rcx + 0xa6], ax
0104da51 ba07000000 mov edx, 7
0104da56 e8a566f4ff call 0x140f94100
0104da5b 488d8f16140000 lea rcx, [rdi + 0x1416]
0104da62 48c7c6ffffffff mov rsi, 0xffffffffffffffff
0104da69 803900 cmp byte ptr [rcx], 0
0104da6c 0f8488000000 je 0x14104dafa
0104da72 488bd6 mov rdx, rsi
0104da75 48ffc2 inc rdx
0104da78 803c1100 cmp byte ptr [rcx + rdx], 0
0104da7c 75f7 jne 0x14104da75
0104da7e 0f57c0 xorps xmm0, xmm0
0104da81 f30f7f442470 movdqu xmmword ptr [rsp + 0x70], xmm0
0104da87 4885d2 test rdx, rdx
0104da8a 740a je 0x14104da96
0104da8c e87f01a9ff call 0x140addc10
0104da91 4889442478 mov qword ptr [rsp + 0x78], rax
0104da96 488d542470 lea rdx, [rsp + 0x70]
0104da9b 488bcb mov rcx, rbx
0104da9e e8edd2f5ff call 0x140faad90
0104daa3 90 nop 
0104daa4 488b4c2470 mov rcx, qword ptr [rsp + 0x70]
0104daa9 4885c9 test rcx, rcx
0104daac 7421 je 0x14104dacf
0104daae 8bc6 mov eax, esi
0104dab0 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0104dab5 83f801 cmp eax, 1
0104dab8 750c jne 0x14104dac6
0104daba c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0104dac1 e812e37400 call 0x14179bdd8
0104dac6 48c744247000000000 mov qword ptr [rsp + 0x70], 0
0104dacf 488b4c2478 mov rcx, qword ptr [rsp + 0x78]
0104dad4 4885c9 test rcx, rcx
0104dad7 7421 je 0x14104dafa
0104dad9 8bc6 mov eax, esi
0104dadb f00fc14108 lock xadd dword ptr [rcx + 8], eax
0104dae0 83f801 cmp eax, 1
0104dae3 750c jne 0x14104daf1
0104dae5 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0104daec e8e7e27400 call 0x14179bdd8
0104daf1 48c744247800000000 mov qword ptr [rsp + 0x78], 0
0104dafa 498b4630 mov rax, qword ptr [r14 + 0x30]
0104dafe 4885c0 test rax, rax
0104db01 7407 je 0x14104db0a
0104db03 80889a00000040 or byte ptr [rax + 0x9a], 0x40
0104db0a 0f57c0 xorps xmm0, xmm0
0104db0d f30f7f442470 movdqu xmmword ptr [rsp + 0x70], xmm0
0104db13 488bd3 mov rdx, rbx
0104db16 488d4c2470 lea rcx, [rsp + 0x70]
0104db1b e870ce34ff call 0x14039a990
0104db20 488b7d80 mov rdi, qword ptr [rbp - 0x80]
0104db24 488b5c2468 mov rbx, qword ptr [rsp + 0x68]
0104db29 41ffc4 inc r12d
0104db2c 443b6730 cmp r12d, dword ptr [rdi + 0x30]
0104db30 0f82fefdffff jb 0x14104d934
0104db36 4533f6 xor r14d, r14d
0104db39 33d2 xor edx, edx
0104db3b 498bcd mov rcx, r13
0104db3e e8ed07e8ff call 0x140ece330
0104db43 4533c0 xor r8d, r8d
0104db46 33d2 xor edx, edx
0104db48 498bcd mov rcx, r13
0104db4b e8501fe8ff call 0x140ecfaa0
0104db50 85c0 test eax, eax
0104db52 740e je 0x14104db62
0104db54 498b85e8200000 mov rax, qword ptr [r13 + 0x20e8]
0104db5b c680600e000001 mov byte ptr [rax + 0xe60], 1
0104db62 488d05a7f4ad00 lea rax, [rip + 0xadf4a7]
0104db69 48894590 mov qword ptr [rbp - 0x70], rax
0104db6d 488d05acfaffff lea rax, [rip - 0x554]
0104db74 48894598 mov qword ptr [rbp - 0x68], rax
0104db78 0fb6471a movzx eax, byte ptr [rdi + 0x1a]
0104db7c 8845a0 mov byte ptr [rbp - 0x60], al
0104db7f 8b4714 mov eax, dword ptr [rdi + 0x14]
0104db82 8945a4 mov dword ptr [rbp - 0x5c], eax
0104db85 488d4590 lea rax, [rbp - 0x70]
0104db89 488945c8 mov qword ptr [rbp - 0x38], rax
0104db8d 48c745d000000000 mov qword ptr [rbp - 0x30], 0
0104db95 0f57c0 xorps xmm0, xmm0
0104db98 f20f1145d8 movsd qword ptr [rbp - 0x28], xmm0
0104db9d 66c745e00000 mov word ptr [rbp - 0x20], 0
0104dba3 c645e200 mov byte ptr [rbp - 0x1e], 0
0104dba7 4c8975e8 mov qword ptr [rbp - 0x18], r14
0104dbab 660f7f45f0 movdqa xmmword ptr [rbp - 0x10], xmm0
0104dbb0 488d4d90 lea rcx, [rbp - 0x70]
0104dbb4 e8e7ada9ff call 0x140ae89a0
0104dbb9 90 nop 
0104dbba 488b5df8 mov rbx, qword ptr [rbp - 8]
0104dbbe 4885db test rbx, rbx
0104dbc1 7427 je 0x14104dbea
0104dbc3 8bc6 mov eax, esi
0104dbc5 f00fc14308 lock xadd dword ptr [rbx + 8], eax
0104dbca 83f801 cmp eax, 1
0104dbcd 751b jne 0x14104dbea
0104dbcf 488b03 mov rax, qword ptr [rbx]
0104dbd2 488bcb mov rcx, rbx
0104dbd5 ff10 call qword ptr [rax]
0104dbd7 f00fc1730c lock xadd dword ptr [rbx + 0xc], esi
0104dbdc 83fe01 cmp esi, 1
0104dbdf 7509 jne 0x14104dbea
0104dbe1 488b03 mov rax, qword ptr [rbx]
0104dbe4 488bcb mov rcx, rbx
0104dbe7 ff5008 call qword ptr [rax + 8]
0104dbea 488b4dc8 mov rcx, qword ptr [rbp - 0x38]
0104dbee 4885c9 test rcx, rcx
0104dbf1 7410 je 0x14104dc03
0104dbf3 488d4590 lea rax, [rbp - 0x70]
0104dbf7 483bc8 cmp rcx, rax
0104dbfa 0f95c2 setne dl
0104dbfd 488b01 mov rax, qword ptr [rcx]
0104dc00 ff5020 call qword ptr [rax + 0x20]
0104dc03 488b4f20 mov rcx, qword ptr [rdi + 0x20]
0104dc07 4885c9 test rcx, rcx
0104dc0a 7406 je 0x14104dc12
0104dc0c ff1556e78900 call qword ptr [rip + 0x89e756]
0104dc12 488bcf mov rcx, rdi
0104dc15 ff154de78900 call qword ptr [rip + 0x89e74d]
0104dc1b 488b4d00 mov rcx, qword ptr [rbp]
0104dc1f 4833cc xor rcx, rsp
0104dc22 e8b9dc7400 call 0x14179b8e0
0104dc27 4c8d9c2410010000 lea r11, [rsp + 0x110]
0104dc2f 498b5b38 mov rbx, qword ptr [r11 + 0x38]
0104dc33 498b7340 mov rsi, qword ptr [r11 + 0x40]
0104dc37 498b7b48 mov rdi, qword ptr [r11 + 0x48]
0104dc3b 498be3 mov rsp, r11
0104dc3e 415f pop r15
0104dc40 415e pop r14
0104dc42 415d pop r13
0104dc44 415c pop r12
0104dc46 5d pop rbp
0104dc47 c3 ret 