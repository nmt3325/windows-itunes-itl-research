010405b0 48895c2418 mov qword ptr [rsp + 0x18], rbx
010405b5 55 push rbp
010405b6 56 push rsi
010405b7 57 push rdi
010405b8 4154 push r12
010405ba 4155 push r13
010405bc 4156 push r14
010405be 4157 push r15
010405c0 488dac2450faffff lea rbp, [rsp - 0x5b0]
010405c8 4881ecb0060000 sub rsp, 0x6b0
010405cf 488b056a4af900 mov rax, qword ptr [rip + 0xf94a6a]
010405d6 4833c4 xor rax, rsp
010405d9 488985a0050000 mov qword ptr [rbp + 0x5a0], rax
010405e0 4c8bea mov r13, rdx
010405e3 4889542450 mov qword ptr [rsp + 0x50], rdx
010405e8 4c8be1 mov r12, rcx
010405eb c644244000 mov byte ptr [rsp + 0x40], 0
010405f0 4533ff xor r15d, r15d
010405f3 4885d2 test rdx, rdx
010405f6 7403 je 0x1410405fb
010405f8 4c893a mov qword ptr [rdx], r15
010405fb 4d85e4 test r12, r12
010405fe 0f84180c0000 je 0x14104121c
01040604 488b09 mov rcx, qword ptr [rcx]
01040607 4885c9 test rcx, rcx
0104060a 0f840c0c0000 je 0x14104121c
01040610 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0104061a 0f85fc0b0000 jne 0x14104121c
01040620 b808000000 mov eax, 8
01040625 41b82a000000 mov r8d, 0x2a
0104062b 45387c242c cmp byte ptr [r12 + 0x2c], r15b
01040630 440f44c0 cmove r8d, eax
01040634 488d442468 lea rax, [rsp + 0x68]
01040639 4889442430 mov qword ptr [rsp + 0x30], rax
0104063e 418b442428 mov eax, dword ptr [r12 + 0x28]
01040643 89442428 mov dword ptr [rsp + 0x28], eax
01040647 498b442420 mov rax, qword ptr [r12 + 0x20]
0104064c 4889442420 mov qword ptr [rsp + 0x20], rax
01040651 4d8b4c2418 mov r9, qword ptr [r12 + 0x18]
01040656 ba656c6966 mov edx, 0x66696c65
0104065b e8407bebff call 0x140ef81a0
01040660 85c0 test eax, eax
01040662 0f85b90b0000 jne 0x141041221
01040668 e853d0eaff call 0x140eed6c0
0104066d 488b742468 mov rsi, qword ptr [rsp + 0x68]
01040672 488d9e10010000 lea rbx, [rsi + 0x110]
01040679 41be20000000 mov r14d, 0x20
0104067f 4885c0 test rax, rax
01040682 741f je 0x1410406a3
01040684 4885db test rbx, rbx
01040687 741a je 0x1410406a3
01040689 458bc6 mov r8d, r14d
0104068c 488bd0 mov rdx, rax
0104068f 488bcb mov rcx, rbx
01040692 e8de718200 call 0x141867875
01040697 4c8bcb mov r9, rbx
0104069a 4c8d05c7af9a00 lea r8, [rip + 0x9aafc7]
010406a1 eb0f jmp 0x1410406b2
010406a3 4c8bcb mov r9, rbx
010406a6 4c8d05bbaf9a00 lea r8, [rip + 0x9aafbb]
010406ad 4885db test rbx, rbx
010406b0 742c je 0x1410406de
010406b2 b937000000 mov ecx, 0x37
010406b7 81f900010000 cmp ecx, 0x100
010406bd 7d14 jge 0x1410406d3
010406bf 8bd1 mov edx, ecx
010406c1 48c1ea03 shr rdx, 3
010406c5 83e107 and ecx, 7
010406c8 b880000000 mov eax, 0x80
010406cd d3f8 sar eax, cl
010406cf 4208040a or byte ptr [rdx + r9], al
010406d3 4983c004 add r8, 4
010406d7 418b08 mov ecx, dword ptr [r8]
010406da 85c9 test ecx, ecx
010406dc 75d9 jne 0x1410406b7
010406de 498b0424 mov rax, qword ptr [r12]
010406e2 f6801401000001 test byte ptr [rax + 0x114], 1
010406e9 7409 je 0x1410406f4
010406eb 4885db test rbx, rbx
010406ee 7404 je 0x1410406f4
010406f0 80630bdf and byte ptr [rbx + 0xb], 0xdf
010406f4 488dbef0000000 lea rdi, [rsi + 0xf0]
010406fb 4885ff test rdi, rdi
010406fe 7479 je 0x141040779
01040700 4885db test rbx, rbx
01040703 7474 je 0x141040779
01040705 488d4f1f lea rcx, [rdi + 0x1f]
01040709 488d431f lea rax, [rbx + 0x1f]
0104070d 483bf8 cmp rdi, rax
01040710 773a ja 0x14104074c
01040712 483bcb cmp rcx, rbx
01040715 7235 jb 0x14104074c
01040717 4a8d0c3f lea rcx, [rdi + r15]
0104071b 488bd3 mov rdx, rbx
0104071e 482bd7 sub rdx, rdi
01040721 4d2bf7 sub r14, r15
01040724 0f1f4000 nop dword ptr [rax]
01040728 0f1f840000000000 nop dword ptr [rax + rax]
01040730 0fb60411 movzx eax, byte ptr [rcx + rdx]
01040734 0801 or byte ptr [rcx], al
01040736 488d4901 lea rcx, [rcx + 1]
0104073a 4983ee01 sub r14, 1
0104073e 75f0 jne 0x141040730
01040740 4c8bcf mov r9, rdi
01040743 4c8d05d6ae9a00 lea r8, [rip + 0x9aaed6]
0104074a eb3c jmp 0x141040788
0104074c f30f6f0f movdqu xmm1, xmmword ptr [rdi]
01040750 f30f6f03 movdqu xmm0, xmmword ptr [rbx]
01040754 0f56c8 orps xmm1, xmm0
01040757 f30f7f0f movdqu xmmword ptr [rdi], xmm1
0104075b f30f6f4b10 movdqu xmm1, xmmword ptr [rbx + 0x10]
01040760 f30f6f4710 movdqu xmm0, xmmword ptr [rdi + 0x10]
01040765 0f56c8 orps xmm1, xmm0
01040768 f30f7f4f10 movdqu xmmword ptr [rdi + 0x10], xmm1
0104076d 4c8bcf mov r9, rdi
01040770 4c8d05a9ae9a00 lea r8, [rip + 0x9aaea9]
01040777 eb0f jmp 0x141040788
01040779 4c8bcf mov r9, rdi
0104077c 4c8d059dae9a00 lea r8, [rip + 0x9aae9d]
01040783 4885ff test rdi, rdi
01040786 742f je 0x1410407b7
01040788 b948000000 mov ecx, 0x48
0104078d 0f1f00 nop dword ptr [rax]
01040790 81f900010000 cmp ecx, 0x100
01040796 7d14 jge 0x1410407ac
01040798 8bd1 mov edx, ecx
0104079a 48c1ea03 shr rdx, 3
0104079e 83e107 and ecx, 7
010407a1 b880000000 mov eax, 0x80
010407a6 d3f8 sar eax, cl
010407a8 4208040a or byte ptr [rdx + r9], al
010407ac 4983c004 add r8, 4
010407b0 418b08 mov ecx, dword ptr [r8]
010407b3 85c9 test ecx, ecx
010407b5 75d9 jne 0x141040790
010407b7 498b0424 mov rax, qword ptr [r12]
010407bb f6801001000001 test byte ptr [rax + 0x110], 1
010407c2 0f84a1000000 je 0x141040869
010407c8 450fb74c2430 movzx r9d, word ptr [r12 + 0x30]
010407ce 410fb7c9 movzx ecx, r9w
010407d2 e8499ef7ff call 0x140fba620
010407d7 84c0 test al, al
010407d9 750d jne 0x1410407e8
010407db 418bc9 mov ecx, r9d
010407de 83e902 sub ecx, 2
010407e1 7405 je 0x1410407e8
010407e3 83f901 cmp ecx, 1
010407e6 7541 jne 0x141040829
010407e8 e8735f5cff call 0x140606760
010407ed 84c0 test al, al
010407ef 7438 je 0x141040829
010407f1 4885db test rbx, rbx
010407f4 7404 je 0x1410407fa
010407f6 804b1020 or byte ptr [rbx + 0x10], 0x20
010407fa 4885ff test rdi, rdi
010407fd 7404 je 0x141040803
010407ff 804f1020 or byte ptr [rdi + 0x10], 0x20
01040803 b101 mov cl, 1
01040805 e8b6775cff call 0x140607fc0
0104080a 84c0 test al, al
0104080c 745b je 0x141040869
0104080e 4885db test rbx, rbx
01040811 7404 je 0x141040817
01040813 804b1002 or byte ptr [rbx + 0x10], 2
01040817 488d86f0000000 lea rax, [rsi + 0xf0]
0104081e 4885c0 test rax, rax
01040821 7446 je 0x141040869
01040823 80481002 or byte ptr [rax + 0x10], 2
01040827 eb40 jmp 0x141040869
01040829 488d8610010000 lea rax, [rsi + 0x110]
01040830 4885c0 test rax, rax
01040833 7404 je 0x141040839
01040835 806010df and byte ptr [rax + 0x10], 0xdf
01040839 488d86f0000000 lea rax, [rsi + 0xf0]
01040840 4885c0 test rax, rax
01040843 7404 je 0x141040849
01040845 806010df and byte ptr [rax + 0x10], 0xdf
01040849 488d8610010000 lea rax, [rsi + 0x110]
01040850 4885c0 test rax, rax
01040853 7404 je 0x141040859
01040855 806010fd and byte ptr [rax + 0x10], 0xfd
01040859 488d86f0000000 lea rax, [rsi + 0xf0]
01040860 4885c0 test rax, rax
01040863 7404 je 0x141040869
01040865 806010fd and byte ptr [rax + 0x10], 0xfd
01040869 410fb7442430 movzx eax, word ptr [r12 + 0x30]
0104086f 66894610 mov word ptr [rsi + 0x10], ax
01040873 0fb686d8010000 movzx eax, byte ptr [rsi + 0x1d8]
0104087a 410fb64c242d movzx ecx, byte ptr [r12 + 0x2d]
01040880 c0e104 shl cl, 4
01040883 32c8 xor cl, al
01040885 80e110 and cl, 0x10
01040888 32c8 xor cl, al
0104088a 888ed8010000 mov byte ptr [rsi + 0x1d8], cl
01040890 f6c108 test cl, 8
01040893 757d jne 0x141040912
01040895 498b1424 mov rdx, qword ptr [r12]
01040899 4885d2 test rdx, rdx
0104089c 7474 je 0x141040912
0104089e 81ba8000000074616474 cmp dword ptr [rdx + 0x80], 0x74646174
010408a8 7568 jne 0x141040912
010408aa 488bca mov rcx, rdx
010408ad e8deb7e9ff call 0x140edc090
010408b2 4885c0 test rax, rax
010408b5 745b je 0x141040912
010408b7 488bca mov rcx, rdx
010408ba e8f166ebff call 0x140ef6fb0
010408bf 488bd8 mov rbx, rax
010408c2 4885c0 test rax, rax
010408c5 744b je 0x141040912
010408c7 483bc6 cmp rax, rsi
010408ca 7446 je 0x141040912
010408cc 41b803000000 mov r8d, 3
010408d2 488bd6 mov rdx, rsi
010408d5 488bc8 mov rcx, rax
010408d8 e81341f7ff call 0x140fb49f0
010408dd 0fb68ecb020000 movzx ecx, byte ptr [rsi + 0x2cb]
010408e4 0fb6d1 movzx edx, cl
010408e7 3293cb020000 xor dl, byte ptr [rbx + 0x2cb]
010408ed 80e201 and dl, 1
010408f0 32d1 xor dl, cl
010408f2 8896cb020000 mov byte ptr [rsi + 0x2cb], dl
010408f8 0fb6c2 movzx eax, dl
010408fb 3283cb020000 xor al, byte ptr [rbx + 0x2cb]
01040901 2402 and al, 2
01040903 32c2 xor al, dl
01040905 8886cb020000 mov byte ptr [rsi + 0x2cb], al
0104090b c644244001 mov byte ptr [rsp + 0x40], 1
01040910 eb08 jmp 0x14104091a
01040912 488bce mov rcx, rsi
01040915 e816f9ffff call 0x141040230
0104091a 0f57c0 xorps xmm0, xmm0
0104091d 33c0 xor eax, eax
0104091f 0f11442470 movups xmmword ptr [rsp + 0x70], xmm0
01040924 0f114580 movups xmmword ptr [rbp - 0x80], xmm0
01040928 66894590 mov word ptr [rbp - 0x70], ax
0104092c c645909d mov byte ptr [rbp - 0x70], 0x9d
01040930 804d9104 or byte ptr [rbp - 0x6f], 4
01040934 488d86f0000000 lea rax, [rsi + 0xf0]
0104093b 4885c0 test rax, rax
0104093e 7410 je 0x141040950
01040940 0f1000 movups xmm0, xmmword ptr [rax]
01040943 0f11442470 movups xmmword ptr [rsp + 0x70], xmm0
01040948 0f104810 movups xmm1, xmmword ptr [rax + 0x10]
0104094c 0f114d80 movups xmmword ptr [rbp - 0x80], xmm1
01040950 e8dbcdeaff call 0x140eed730
01040955 4c8bd0 mov r10, rax
01040958 4885c0 test rax, rax
0104095b 7464 je 0x1410409c1
0104095d 488d481f lea rcx, [rax + 0x1f]
01040961 488d442470 lea rax, [rsp + 0x70]
01040966 483bc1 cmp rax, rcx
01040969 772f ja 0x14104099a
0104096b 488d458f lea rax, [rbp - 0x71]
0104096f 493bc2 cmp rax, r10
01040972 7226 jb 0x14104099a
01040974 33ff xor edi, edi
01040976 8bd7 mov edx, edi
01040978 488d442470 lea rax, [rsp + 0x70]
0104097d 4c2bd0 sub r10, rax
01040980 488d4c2470 lea rcx, [rsp + 0x70]
01040985 4803ca add rcx, rdx
01040988 420fb60411 movzx eax, byte ptr [rcx + r10]
0104098d 2001 and byte ptr [rcx], al
0104098f 48ffc2 inc rdx
01040992 4883fa20 cmp rdx, 0x20
01040996 7ce8 jl 0x141040980
01040998 eb29 jmp 0x1410409c3
0104099a f3410f6f02 movdqu xmm0, xmmword ptr [r10]
0104099f f30f6f4c2470 movdqu xmm1, xmmword ptr [rsp + 0x70]
010409a5 0f54c8 andps xmm1, xmm0
010409a8 f30f7f4c2470 movdqu xmmword ptr [rsp + 0x70], xmm1
010409ae f3410f6f5210 movdqu xmm2, xmmword ptr [r10 + 0x10]
010409b4 f30f6f4580 movdqu xmm0, xmmword ptr [rbp - 0x80]
010409b9 0f54d0 andps xmm2, xmm0
010409bc f30f7f5580 movdqu xmmword ptr [rbp - 0x80], xmm2
010409c1 33ff xor edi, edi
010409c3 498b0424 mov rax, qword ptr [r12]
010409c7 f6801401000002 test byte ptr [rax + 0x114], 2
010409ce 7405 je 0x1410409d5
010409d0 8064247bdf and byte ptr [rsp + 0x7b], 0xdf
010409d5 f6801001000001 test byte ptr [rax + 0x110], 1
010409dc 750c jne 0x1410409ea
010409de 81b88400000069506f64 cmp dword ptr [rax + 0x84], 0x646f5069
010409e8 7530 jne 0x141040a1a
010409ea 33c9 xor ecx, ecx
010409ec e89f922000 call 0x141249c90
010409f1 84c0 test al, al
010409f3 7425 je 0x141040a1a
010409f5 488d8610010000 lea rax, [rsi + 0x110]
010409fc 4885c0 test rax, rax
010409ff 7404 je 0x141040a05
01040a01 80480e08 or byte ptr [rax + 0xe], 8
01040a05 488d86f0000000 lea rax, [rsi + 0xf0]
01040a0c 4885c0 test rax, rax
01040a0f 7404 je 0x141040a15
01040a11 80480e08 or byte ptr [rax + 0xe], 8
01040a15 804c247e08 or byte ptr [rsp + 0x7e], 8
01040a1a f686d801000008 test byte ptr [rsi + 0x1d8], 8
01040a21 7508 jne 0x141040a2b
01040a23 804d9002 or byte ptr [rbp - 0x70], 2
01040a27 804d910a or byte ptr [rbp - 0x6f], 0xa
01040a2b 813e74736c70 cmp dword ptr [rsi], 0x706c7374
01040a31 752c jne 0x141040a5f
01040a33 664439befc010000 cmp word ptr [rsi + 0x1fc], r15w
01040a3b 7522 jne 0x141040a5f
01040a3d 0f10442470 movups xmm0, xmmword ptr [rsp + 0x70]
01040a42 0f11864c040000 movups xmmword ptr [rsi + 0x44c], xmm0
01040a49 0f104d80 movups xmm1, xmmword ptr [rbp - 0x80]
01040a4d 0f118e5c040000 movups xmmword ptr [rsi + 0x45c], xmm1
01040a54 0fb74590 movzx eax, word ptr [rbp - 0x70]
01040a58 6689866c040000 mov word ptr [rsi + 0x46c], ax
01040a5f 498b4c2408 mov rcx, qword ptr [r12 + 8]
01040a64 41bf01000000 mov r15d, 1
01040a6a 4885c9 test rcx, rcx
01040a6d 0f84de020000 je 0x141040d51
01040a73 813974736c70 cmp dword ptr [rcx], 0x706c7374
01040a79 752c jne 0x141040aa7
01040a7b 488b4108 mov rax, qword ptr [rcx + 8]
01040a7f 81b88400000069506f64 cmp dword ptr [rax + 0x84], 0x646f5069
01040a89 751c jne 0x141040aa7
01040a8b 4484b8fa200000 test byte ptr [rax + 0x20fa], r15b
01040a92 7413 je 0x141040aa7
01040a94 488b4608 mov rax, qword ptr [rsi + 8]
01040a98 4484b810010000 test byte ptr [rax + 0x110], r15b
01040a9f 7406 je 0x141040aa7
01040aa1 450fb6ef movzx r13d, r15b
01040aa5 eb03 jmp 0x141040aaa
01040aa7 4532ed xor r13b, r13b
01040aaa 488bd1 mov rdx, rcx
01040aad 8b86f0010000 mov eax, dword ptr [rsi + 0x1f0]
01040ab3 3981f0010000 cmp dword ptr [rcx + 0x1f0], eax
01040ab9 7512 jne 0x141040acd
01040abb 4584ed test r13b, r13b
01040abe 750d jne 0x141040acd
01040ac0 488bd6 mov rdx, rsi
01040ac3 e838f5eaff call 0x140ef0000
01040ac8 498b542408 mov rdx, qword ptr [r12 + 8]
01040acd 458bd7 mov r10d, r15d
01040ad0 b876000000 mov eax, 0x76
01040ad5 41807c242e00 cmp byte ptr [r12 + 0x2e], 0
01040adb 440f44d0 cmove r10d, eax
01040adf 4489542468 mov dword ptr [rsp + 0x68], r10d
01040ae4 4885d2 test rdx, rdx
01040ae7 0f845f020000 je 0x141040d4c
01040aed 488b4270 mov rax, qword ptr [rdx + 0x70]
01040af1 4885c0 test rax, rax
01040af4 0f8452020000 je 0x141040d4c
01040afa 8b4064 mov eax, dword ptr [rax + 0x64]
01040afd 448bf7 mov r14d, edi
01040b00 85c0 test eax, eax
01040b02 0f8444020000 je 0x141040d4c
01040b08 448bf8 mov r15d, eax
01040b0b 0f1f440000 nop dword ptr [rax + rax]
01040b10 498b4c2408 mov rcx, qword ptr [r12 + 8]
01040b15 458bce mov r9d, r14d
01040b18 4533c0 xor r8d, r8d
01040b1b 418bd2 mov edx, r10d
01040b1e 488b8908040000 mov rcx, qword ptr [rcx + 0x408]
01040b25 e89663f2ff call 0x140f66ec0
01040b2a 488bd8 mov rbx, rax
01040b2d 4885c0 test rax, rax
01040b30 0f84ff010000 je 0x141040d35
01040b36 0fb64048 movzx eax, byte ptr [rax + 0x48]
01040b3a 84c0 test al, al
01040b3c 750d jne 0x141040b4b
01040b3e b201 mov dl, 1
01040b40 488bcb mov rcx, rbx
01040b43 e878d0f7ff call 0x140fbdbc0
01040b48 884348 mov byte ptr [rbx + 0x48], al
01040b4b 3c01 cmp al, 1
01040b4d 0f85e2010000 jne 0x141040d35
01040b53 488bcb mov rcx, rbx
01040b56 e865cbf7ff call 0x140fbd6c0
01040b5b 84c0 test al, al
01040b5d 0f85d2010000 jne 0x141040d35
01040b63 488b4330 mov rax, qword ptr [rbx + 0x30]
01040b67 488b7858 mov rdi, qword ptr [rax + 0x58]
01040b6b 488bcf mov rcx, rdi
01040b6e e88d8ff6ff call 0x140fa9b00
01040b73 84c0 test al, al
01040b75 740a je 0x141040b81
01040b77 0fb6473d movzx eax, byte ptr [rdi + 0x3d]
01040b7b 2c06 sub al, 6
01040b7d 3c03 cmp al, 3
01040b7f 7612 jbe 0x141040b93
01040b81 488b4330 mov rax, qword ptr [rbx + 0x30]
01040b85 488b4858 mov rcx, qword ptr [rax + 0x58]
01040b89 80793d00 cmp byte ptr [rcx + 0x3d], 0
01040b8d 0f85a0010000 jne 0x141040d33
01040b93 488b03 mov rax, qword ptr [rbx]
01040b96 4885c0 test rax, rax
01040b99 0f8494010000 je 0x141040d33
01040b9f 813874736c70 cmp dword ptr [rax], 0x706c7374
01040ba5 0f8588010000 jne 0x141040d33
01040bab 837b2800 cmp dword ptr [rbx + 0x28], 0
01040baf 0f847e010000 je 0x141040d33
01040bb5 837b2c00 cmp dword ptr [rbx + 0x2c], 0
01040bb9 7527 jne 0x141040be2
01040bbb 488b4308 mov rax, qword ptr [rbx + 8]
01040bbf 4885c0 test rax, rax
01040bc2 7414 je 0x141040bd8
01040bc4 488b4808 mov rcx, qword ptr [rax + 8]
01040bc8 4885c9 test rcx, rcx
01040bcb 740b je 0x141040bd8
01040bcd 83782c00 cmp dword ptr [rax + 0x2c], 0
01040bd1 750f jne 0x141040be2
01040bd3 488bc1 mov rax, rcx
01040bd6 ebec jmp 0x141040bc4
01040bd8 837b2c00 cmp dword ptr [rbx + 0x2c], 0
01040bdc 0f8451010000 je 0x141040d33
01040be2 488b4330 mov rax, qword ptr [rbx + 0x30]
01040be6 f6809b00000008 test byte ptr [rax + 0x9b], 8
01040bed 740d je 0x141040bfc
01040bef f6809a00000008 test byte ptr [rax + 0x9a], 8
01040bf6 0f8537010000 jne 0x141040d33
01040bfc 4584ed test r13b, r13b
01040bff 0f84f9000000 je 0x141040cfe
01040c05 488b8848010000 mov rcx, qword ptr [rax + 0x148]
01040c0c 48894c2460 mov qword ptr [rsp + 0x60], rcx
01040c11 488b5e08 mov rbx, qword ptr [rsi + 8]
01040c15 4885db test rbx, rbx
01040c18 0f8415010000 je 0x141040d33
01040c1e 81bb8000000074616474 cmp dword ptr [rbx + 0x80], 0x74646174
01040c28 0f8505010000 jne 0x141040d33
01040c2e 4885c9 test rcx, rcx
01040c31 0f84fc000000 je 0x141040d33
01040c37 488bcb mov rcx, rbx
01040c3a e8f111e8ff call 0x140ec1e30
01040c3f 85c0 test eax, eax
01040c41 0f85ec000000 jne 0x141040d33
01040c47 488d542460 lea rdx, [rsp + 0x60]
01040c4c 488b8be0180000 mov rcx, qword ptr [rbx + 0x18e0]
01040c53 e818d23eff call 0x14042de70
01040c58 4885c0 test rax, rax
01040c5b 0f84d2000000 je 0x141040d33
01040c61 488b5008 mov rdx, qword ptr [rax + 8]
01040c65 4885d2 test rdx, rdx
01040c68 0f84c5000000 je 0x141040d33
01040c6e 488b4a10 mov rcx, qword ptr [rdx + 0x10]
01040c72 4885c9 test rcx, rcx
01040c75 0f84b8000000 je 0x141040d33
01040c7b 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
01040c85 0f85a8000000 jne 0x141040d33
01040c8b e800b4e9ff call 0x140edc090
01040c90 4885c0 test rax, rax
01040c93 0f849a000000 je 0x141040d33
01040c99 4c8bc2 mov r8, rdx
01040c9c 813874736c70 cmp dword ptr [rax], 0x706c7374
01040ca2 751f jne 0x141040cc3
01040ca4 488b4a60 mov rcx, qword ptr [rdx + 0x60]
01040ca8 4885c9 test rcx, rcx
01040cab 7416 je 0x141040cc3
01040cad 0f1f00 nop dword ptr [rax]
01040cb0 483901 cmp qword ptr [rcx], rax
01040cb3 7409 je 0x141040cbe
01040cb5 488b4938 mov rcx, qword ptr [rcx + 0x38]
01040cb9 4885c9 test rcx, rcx
01040cbc 75f2 jne 0x141040cb0
01040cbe 4885c9 test rcx, rcx
01040cc1 7509 jne 0x141040ccc
01040cc3 498b4860 mov rcx, qword ptr [r8 + 0x60]
01040cc7 4885c9 test rcx, rcx
01040cca 7467 je 0x141040d33
01040ccc 488b01 mov rax, qword ptr [rcx]
01040ccf 33ff xor edi, edi
01040cd1 4885c0 test rax, rax
01040cd4 745f je 0x141040d35
01040cd6 813874736c70 cmp dword ptr [rax], 0x706c7374
01040cdc 7557 jne 0x141040d35
01040cde 397928 cmp dword ptr [rcx + 0x28], edi
01040ce1 7452 je 0x141040d35
01040ce3 813e74736c70 cmp dword ptr [rsi], 0x706c7374
01040ce9 754a jne 0x141040d35
01040ceb 897c2420 mov dword ptr [rsp + 0x20], edi
01040cef 4533c9 xor r9d, r9d
01040cf2 4c8bc6 mov r8, rsi
01040cf5 33d2 xor edx, edx
01040cf7 e8c4c6f7ff call 0x140fbd3c0
01040cfc eb37 jmp 0x141040d35
01040cfe 488b03 mov rax, qword ptr [rbx]
01040d01 33ff xor edi, edi
01040d03 4885c0 test rax, rax
01040d06 742d je 0x141040d35
01040d08 813874736c70 cmp dword ptr [rax], 0x706c7374
01040d0e 7525 jne 0x141040d35
01040d10 397b28 cmp dword ptr [rbx + 0x28], edi
01040d13 7420 je 0x141040d35
01040d15 813e74736c70 cmp dword ptr [rsi], 0x706c7374
01040d1b 7518 jne 0x141040d35
01040d1d 897c2420 mov dword ptr [rsp + 0x20], edi
01040d21 4533c9 xor r9d, r9d
01040d24 4c8bc6 mov r8, rsi
01040d27 33d2 xor edx, edx
01040d29 488bcb mov rcx, rbx
01040d2c e88fc6f7ff call 0x140fbd3c0
01040d31 eb02 jmp 0x141040d35
01040d33 33ff xor edi, edi
01040d35 41ffc6 inc r14d
01040d38 453bf7 cmp r14d, r15d
01040d3b 448b542468 mov r10d, dword ptr [rsp + 0x68]
01040d40 0f82cafdffff jb 0x141040b10
01040d46 41bf01000000 mov r15d, 1
01040d4c 4c8b6c2450 mov r13, qword ptr [rsp + 0x50]
01040d51 488b4e08 mov rcx, qword ptr [rsi + 8]
01040d55 8b8184000000 mov eax, dword ptr [rcx + 0x84]
01040d5b 3d61756364 cmp eax, 0x64637561
01040d60 0f84b3000000 je 0x141040e19
01040d66 3d69506f64 cmp eax, 0x646f5069
01040d6b 750d jne 0x141040d7a
01040d6d f681fa20000008 test byte ptr [rcx + 0x20fa], 8
01040d74 0f859f000000 jne 0x141040e19
01040d7a 488bce mov rcx, rsi
01040d7d e80e39f7ff call 0x140fb4690
01040d82 4885c0 test rax, rax
01040d85 7442 je 0x141040dc9
01040d87 440fb7c7 movzx r8d, di
01040d8b 440fb708 movzx r9d, word ptr [rax]
01040d8f 66413bf9 cmp di, r9w
01040d93 7d34 jge 0x141040dc9
01040d95 6666660f1f840000000000 nop word ptr [rax + rax]
01040da0 410fb7c8 movzx ecx, r8w
01040da4 486bc91c imul rcx, rcx, 0x1c
01040da8 4803c8 add rcx, rax
01040dab 83790401 cmp dword ptr [rcx + 4], 1
01040daf 740c je 0x141040dbd
01040db1 6641ffc0 inc r8w
01040db5 66453bc1 cmp r8w, r9w
01040db9 7ce5 jl 0x141040da0
01040dbb eb0c jmp 0x141040dc9
01040dbd 41807c242c00 cmp byte ptr [r12 + 0x2c], 0
01040dc3 0f94c0 sete al
01040dc6 88410a mov byte ptr [rcx + 0xa], al
01040dc9 488bce mov rcx, rsi
01040dcc e85f39f7ff call 0x140fb4730
01040dd1 4885c0 test rax, rax
01040dd4 7443 je 0x141040e19
01040dd6 440fb7c7 movzx r8d, di
01040dda 440fb708 movzx r9d, word ptr [rax]
01040dde 66413bf9 cmp di, r9w
01040de2 7d35 jge 0x141040e19
01040de4 0f1f4000 nop dword ptr [rax]
01040de8 0f1f840000000000 nop dword ptr [rax + rax]
01040df0 410fb7c8 movzx ecx, r8w
01040df4 486bc91c imul rcx, rcx, 0x1c
01040df8 4803c8 add rcx, rax
01040dfb 83790401 cmp dword ptr [rcx + 4], 1
01040dff 740c je 0x141040e0d
01040e01 6641ffc0 inc r8w
01040e05 66453bc1 cmp r8w, r9w
01040e09 7ce5 jl 0x141040df0
01040e0b eb0c jmp 0x141040e19
01040e0d 41807c242c00 cmp byte ptr [r12 + 0x2c], 0
01040e13 0f94c0 sete al
01040e16 88410a mov byte ptr [rcx + 0xa], al
01040e19 813e74736c70 cmp dword ptr [rsi], 0x706c7374
01040e1f 0f857d000000 jne 0x141040ea2
01040e25 488d05b4f1ffff lea rax, [rip - 0xe4c]
01040e2c 488986e0010000 mov qword ptr [rsi + 0x1e0], rax
01040e33 4889bee8010000 mov qword ptr [rsi + 0x1e8], rdi
01040e3a 488b9e20040000 mov rbx, qword ptr [rsi + 0x420]
01040e41 807c244000 cmp byte ptr [rsp + 0x40], 0
01040e46 742c je 0x141040e74
01040e48 4885db test rbx, rbx
01040e4b 7455 je 0x141040ea2
01040e4d 0f1f00 nop dword ptr [rax]
01040e50 41b001 mov r8b, 1
01040e53 488bd3 mov rdx, rbx
01040e56 488bce mov rcx, rsi
01040e59 e8d225f7ff call 0x140fb3430
01040e5e 817b0874657363 cmp dword ptr [rbx + 8], 0x63736574
01040e65 753b jne 0x141040ea2
01040e67 488b03 mov rax, qword ptr [rbx]
01040e6a 488bd8 mov rbx, rax
01040e6d 4885c0 test rax, rax
01040e70 75de jne 0x141040e50
01040e72 eb2e jmp 0x141040ea2
01040e74 4885db test rbx, rbx
01040e77 7429 je 0x141040ea2
01040e79 0f1f8000000000 nop dword ptr [rax]
01040e80 4533c0 xor r8d, r8d
01040e83 488bd3 mov rdx, rbx
01040e86 488bce mov rcx, rsi
01040e89 e8a225f7ff call 0x140fb3430
01040e8e 817b0874657363 cmp dword ptr [rbx + 8], 0x63736574
01040e95 750b jne 0x141040ea2
01040e97 488b03 mov rax, qword ptr [rbx]
01040e9a 488bd8 mov rbx, rax
01040e9d 4885c0 test rax, rax
01040ea0 75de jne 0x141040e80
01040ea2 4d8b442410 mov r8, qword ptr [r12 + 0x10]
01040ea7 4d85c0 test r8, r8
01040eaa 0f8419010000 je 0x141040fc9
01040eb0 410fb700 movzx eax, word ptr [r8]
01040eb4 6685c0 test ax, ax
01040eb7 0f840c010000 je 0x141040fc9
01040ebd 8bd0 mov edx, eax
01040ebf bfff000000 mov edi, 0xff
01040ec4 488d4da2 lea rcx, [rbp - 0x5e]
01040ec8 3bc7 cmp eax, edi
01040eca 760b jbe 0x141040ed7
01040ecc 66897da0 mov word ptr [rbp - 0x60], di
01040ed0 bafe000000 mov edx, 0xfe
01040ed5 eb09 jmp 0x141040ee0
01040ed7 668945a0 mov word ptr [rbp - 0x60], ax
01040edb 83ea01 sub edx, 1
01040ede 7822 js 0x141040f02
01040ee0 488d45a2 lea rax, [rbp - 0x5e]
01040ee4 4c2bc0 sub r8, rax
01040ee7 660f1f840000000000 nop word ptr [rax + rax]
01040ef0 410fb7440802 movzx eax, word ptr [r8 + rcx + 2]
01040ef6 668901 mov word ptr [rcx], ax
01040ef9 488d4902 lea rcx, [rcx + 2]
01040efd 83ea01 sub edx, 1
01040f00 79ee jns 0x141040ef0
01040f02 488d55a0 lea rdx, [rbp - 0x60]
01040f06 488bce mov rcx, rsi
01040f09 e812fdeaff call 0x140ef0c20
01040f0e 498b1c24 mov rbx, qword ptr [r12]
01040f12 488bcb mov rcx, rbx
01040f15 e896a0f7ff call 0x140fbafb0
01040f1a 84c0 test al, al
01040f1c 7510 jne 0x141040f2e
01040f1e 488bcb mov rcx, rbx
01040f21 e84aa1f7ff call 0x140fbb070
01040f26 84c0 test al, al
01040f28 0f848b000000 je 0x141040fb9
01040f2e 48833da2df0b01ff cmp qword ptr [rip + 0x10bdfa2], -1
01040f36 7416 je 0x141040f4e
01040f38 4c8d05d15c5bff lea r8, [rip - 0xa4a32f]
01040f3f 33d2 xor edx, edx
01040f41 488d0d90df0b01 lea rcx, [rip + 0x10bdf90]
01040f48 ff15e2bd8a00 call qword ptr [rip + 0x8abde2]
01040f4e 488b1dabdf0801 mov rbx, qword ptr [rip + 0x108dfab]
01040f55 4885db test rbx, rbx
01040f58 740b je 0x141040f65
01040f5a f0ff4308 lock inc dword ptr [rbx + 8]
01040f5e 488b1d9bdf0801 mov rbx, qword ptr [rip + 0x108df9b]
01040f65 0f10058cdf0801 movups xmm0, xmmword ptr [rip + 0x108df8c]
01040f6c 0f11442450 movups xmmword ptr [rsp + 0x50], xmm0
01040f71 66480f7ec1 movq rcx, xmm0
01040f76 4885c9 test rcx, rcx
01040f79 740d je 0x141040f88
01040f7b 488b01 mov rax, qword ptr [rcx]
01040f7e 488bd6 mov rdx, rsi
01040f81 ff9028010000 call qword ptr [rax + 0x128]
01040f87 90 nop 
01040f88 4885db test rbx, rbx
01040f8b 742c je 0x141040fb9
01040f8d bfffffffff mov edi, 0xffffffff
01040f92 8bc7 mov eax, edi
01040f94 f00fc14308 lock xadd dword ptr [rbx + 8], eax
01040f99 83f801 cmp eax, 1
01040f9c 751b jne 0x141040fb9
01040f9e 488b03 mov rax, qword ptr [rbx]
01040fa1 488bcb mov rcx, rbx
01040fa4 ff10 call qword ptr [rax]
01040fa6 f00fc17b0c lock xadd dword ptr [rbx + 0xc], edi
01040fab 83ff01 cmp edi, 1
01040fae 7509 jne 0x141040fb9
01040fb0 488b03 mov rax, qword ptr [rbx]
01040fb3 488bcb mov rcx, rbx
01040fb6 ff5008 call qword ptr [rax + 8]
01040fb9 4d85ed test r13, r13
01040fbc 7404 je 0x141040fc2
01040fbe 49897500 mov qword ptr [r13], rsi
01040fc2 33c0 xor eax, eax
01040fc4 e958020000 jmp 0x141041221
01040fc9 488b0510ed0801 mov rax, qword ptr [rip + 0x108ed10]
01040fd0 4885c0 test rax, rax
01040fd3 7509 jne 0x141040fde
01040fd5 4c8b351ccc0601 mov r14, qword ptr [rip + 0x106cc1c]
01040fdc eb40 jmp 0x14104101e
01040fde ba01002823 mov edx, 0x23280001
01040fe3 488bc8 mov rcx, rax
01040fe6 ff15047e8a00 call qword ptr [rip + 0x8a7e04]
01040fec 4c8bf0 mov r14, rax
01040fef 4885c0 test rax, rax
01040ff2 7417 je 0x14104100b
01040ff4 488bc8 mov rcx, rax
01040ff7 ff15c37e8a00 call qword ptr [rip + 0x8a7ec3]
01040ffd 488bd8 mov rbx, rax
01041000 ff157a7f8a00 call qword ptr [rip + 0x8a7f7a]
01041006 483bd8 cmp rbx, rax
01041009 7505 jne 0x141041010
0104100b 4d85f6 test r14, r14
0104100e 7507 jne 0x141041017
01041010 4c8b35e1cb0601 mov r14, qword ptr [rip + 0x106cbe1]
01041017 488b05c2ec0801 mov rax, qword ptr [rip + 0x108ecc2]
0104101e 0fb7cf movzx ecx, di
01041021 66898da0010000 mov word ptr [rbp + 0x1a0], cx
01041028 bfff000000 mov edi, 0xff
0104102d 4d85f6 test r14, r14
01041030 745e je 0x141041090
01041032 48c744245000000000 mov qword ptr [rsp + 0x50], 0
0104103b 498bce mov rcx, r14
0104103e ff154c7f8a00 call qword ptr [rip + 0x8a7f4c]
01041044 488bd8 mov rbx, rax
01041047 4889442458 mov qword ptr [rsp + 0x58], rax
0104104c 33c9 xor ecx, ecx
0104104e 4885c0 test rax, rax
01041051 742f je 0x141041082
01041053 483bc7 cmp rax, rdi
01041056 7e08 jle 0x141041060
01041058 48897c2458 mov qword ptr [rsp + 0x58], rdi
0104105d 0fb7df movzx ebx, di
01041060 0f28442450 movaps xmm0, xmmword ptr [rsp + 0x50]
01041065 660f7f442450 movdqa xmmword ptr [rsp + 0x50], xmm0
0104106b 4c8d85a2010000 lea r8, [rbp + 0x1a2]
01041072 488d542450 lea rdx, [rsp + 0x50]
01041077 498bce mov rcx, r14
0104107a e8e110b5ff call 0x140b92160
0104107f 0fb7cb movzx ecx, bx
01041082 66898da0010000 mov word ptr [rbp + 0x1a0], cx
01041089 488b0550ec0801 mov rax, qword ptr [rip + 0x108ec50]
01041090 4885c0 test rax, rax
01041093 7509 jne 0x14104109e
01041095 4c8b355ccb0601 mov r14, qword ptr [rip + 0x106cb5c]
0104109c eb40 jmp 0x1410410de
0104109e ba02002823 mov edx, 0x23280002
010410a3 488bc8 mov rcx, rax
010410a6 ff15447d8a00 call qword ptr [rip + 0x8a7d44]
010410ac 4c8bf0 mov r14, rax
010410af 4885c0 test rax, rax
010410b2 7417 je 0x1410410cb
010410b4 488bc8 mov rcx, rax
010410b7 ff15037e8a00 call qword ptr [rip + 0x8a7e03]
010410bd 488bd8 mov rbx, rax
010410c0 ff15ba7e8a00 call qword ptr [rip + 0x8a7eba]
010410c6 483bd8 cmp rbx, rax
010410c9 7505 jne 0x1410410d0
010410cb 4d85f6 test r14, r14
010410ce 7507 jne 0x1410410d7
010410d0 4c8b3521cb0601 mov r14, qword ptr [rip + 0x106cb21]
010410d7 0fb78da0010000 movzx ecx, word ptr [rbp + 0x1a0]
010410de 33c0 xor eax, eax
010410e0 0fb7d0 movzx edx, ax
010410e3 668985a0030000 mov word ptr [rbp + 0x3a0], ax
010410ea 4d85f6 test r14, r14
010410ed 745e je 0x14104114d
010410ef 4889442450 mov qword ptr [rsp + 0x50], rax
010410f4 498bce mov rcx, r14
010410f7 ff15937e8a00 call qword ptr [rip + 0x8a7e93]
010410fd 488bd8 mov rbx, rax
01041100 4889442458 mov qword ptr [rsp + 0x58], rax
01041105 33c0 xor eax, eax
01041107 8bd0 mov edx, eax
01041109 4885db test rbx, rbx
0104110c 7431 je 0x14104113f
0104110e 483bdf cmp rbx, rdi
01041111 7e08 jle 0x14104111b
01041113 48897c2458 mov qword ptr [rsp + 0x58], rdi
01041118 0fb7df movzx ebx, di
0104111b 0f28442450 movaps xmm0, xmmword ptr [rsp + 0x50]
01041120 660f7f442450 movdqa xmmword ptr [rsp + 0x50], xmm0
01041126 4c8d85a2030000 lea r8, [rbp + 0x3a2]
0104112d 488d542450 lea rdx, [rsp + 0x50]
01041132 498bce mov rcx, r14
01041135 e82610b5ff call 0x140b92160
0104113a 0fb7d3 movzx edx, bx
0104113d 33c0 xor eax, eax
0104113f 668995a0030000 mov word ptr [rbp + 0x3a0], dx
01041146 0fb78da0010000 movzx ecx, word ptr [rbp + 0x1a0]
0104114d 498b1c24 mov rbx, qword ptr [r12]
01041151 668945a0 mov word ptr [rbp - 0x60], ax
01041155 4885db test rbx, rbx
01041158 0f84a4fdffff je 0x141040f02
0104115e 81bb8000000074616474 cmp dword ptr [rbx + 0x80], 0x74646174
01041168 0f8594fdffff jne 0x141040f02
0104116e 6685c9 test cx, cx
01041171 0f848bfdffff je 0x141040f02
01041177 6685d2 test dx, dx
0104117a 0f8482fdffff je 0x141040f02
01041180 4183ff01 cmp r15d, 1
01041184 7529 jne 0x1410411af
01041186 0fb7c1 movzx eax, cx
01041189 663bcf cmp cx, di
0104118c 760f jbe 0x14104119d
0104118e 66897da0 mov word ptr [rbp - 0x60], di
01041192 8bc7 mov eax, edi
01041194 488d95a2010000 lea rdx, [rbp + 0x1a2]
0104119b eb32 jmp 0x1410411cf
0104119d 668945a0 mov word ptr [rbp - 0x60], ax
010411a1 83f801 cmp eax, 1
010411a4 7238 jb 0x1410411de
010411a6 488d95a2010000 lea rdx, [rbp + 0x1a2]
010411ad eb20 jmp 0x1410411cf
010411af 0fb7c2 movzx eax, dx
010411b2 663bd7 cmp dx, di
010411b5 7608 jbe 0x1410411bf
010411b7 66897da0 mov word ptr [rbp - 0x60], di
010411bb 8bc7 mov eax, edi
010411bd eb09 jmp 0x1410411c8
010411bf 668945a0 mov word ptr [rbp - 0x60], ax
010411c3 83f801 cmp eax, 1
010411c6 7216 jb 0x1410411de
010411c8 488d95a2030000 lea rdx, [rbp + 0x3a2]
010411cf 448bc0 mov r8d, eax
010411d2 4d03c0 add r8, r8
010411d5 488d4da2 lea rcx, [rbp - 0x5e]
010411d9 e8bcba7500 call 0x14179cc9a
010411de 458bc7 mov r8d, r15d
010411e1 41ffc7 inc r15d
010411e4 488d55a0 lea rdx, [rbp - 0x60]
010411e8 488d4da0 lea rcx, [rbp - 0x60]
010411ec e84f4caaff call 0x140ae5e40
010411f1 41b001 mov r8b, 1
010411f4 488d55a0 lea rdx, [rbp - 0x60]
010411f8 488bcb mov rcx, rbx
010411fb e88059ebff call 0x140ef6b80
01041200 4885c0 test rax, rax
01041203 0f84f9fcffff je 0x141040f02
01041209 0fb78da0010000 movzx ecx, word ptr [rbp + 0x1a0]
01041210 0fb795a0030000 movzx edx, word ptr [rbp + 0x3a0]
01041217 e964ffffff jmp 0x141041180
0104121c b8ceffffff mov eax, 0xffffffce
01041221 488b8da0050000 mov rcx, qword ptr [rbp + 0x5a0]
01041228 4833cc xor rcx, rsp
0104122b e8b0a67500 call 0x14179b8e0
01041230 488b9c2400070000 mov rbx, qword ptr [rsp + 0x700]
01041238 4881c4b0060000 add rsp, 0x6b0
0104123f 415f pop r15
01041241 415e pop r14
01041243 415d pop r13
01041245 415c pop r12
01041247 5f pop rdi
01041248 5e pop rsi
01041249 5d pop rbp
0104124a c3 ret 