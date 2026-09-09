0102e980 488bc4 mov rax, rsp
0102e983 4c894820 mov qword ptr [rax + 0x20], r9
0102e987 44894018 mov dword ptr [rax + 0x18], r8d
0102e98b 48894808 mov qword ptr [rax + 8], rcx
0102e98f 55 push rbp
0102e990 53 push rbx
0102e991 56 push rsi
0102e992 57 push rdi
0102e993 4154 push r12
0102e995 4155 push r13
0102e997 4156 push r14
0102e999 4157 push r15
0102e99b 488d68b9 lea rbp, [rax - 0x47]
0102e99f 4881eca8000000 sub rsp, 0xa8
0102e9a6 0f2970a8 movaps xmmword ptr [rax - 0x58], xmm6
0102e9aa 4c8bea mov r13, rdx
0102e9ad 33db xor ebx, ebx
0102e9af 8bfb mov edi, ebx
0102e9b1 895d57 mov dword ptr [rbp + 0x57], ebx
0102e9b4 48b8abaaaaaaaaaaaaaa movabs rax, 0xaaaaaaaaaaaaaaab
0102e9be 4885d2 test rdx, rdx
0102e9c1 741f je 0x14102e9e2
0102e9c3 813a54534c4f cmp dword ptr [rdx], 0x4f4c5354
0102e9c9 7517 jne 0x14102e9e2
0102e9cb 395a04 cmp dword ptr [rdx + 4], ebx
0102e9ce 7412 je 0x14102e9e2
0102e9d0 4c8b6210 mov r12, qword ptr [rdx + 0x10]
0102e9d4 4c2b6208 sub r12, qword ptr [rdx + 8]
0102e9d8 49c1fc04 sar r12, 4
0102e9dc 4c0fafe0 imul r12, rax
0102e9e0 eb03 jmp 0x14102e9e5
0102e9e2 448be3 mov r12d, ebx
0102e9e5 4c896577 mov qword ptr [rbp + 0x77], r12
0102e9e9 8bf3 mov esi, ebx
0102e9eb 4d63fc movsxd r15, r12d
0102e9ee 4585e4 test r12d, r12d
0102e9f1 0f8e87010000 jle 0x14102eb7e
0102e9f7 4c8bf3 mov r14, rbx
0102e9fa 4c8be0 mov r12, rax
0102e9fd 0f1f00 nop dword ptr [rax]
0102ea00 4533c0 xor r8d, r8d
0102ea03 8bd6 mov edx, esi
0102ea05 498bcd mov rcx, r13
0102ea08 e8b3ef2aff call 0x1402dd9c0
0102ea0d 4885c0 test rax, rax
0102ea10 742b je 0x14102ea3d
0102ea12 488b08 mov rcx, qword ptr [rax]
0102ea15 4885c9 test rcx, rcx
0102ea18 0f84e2000000 je 0x14102eb00
0102ea1e 813974736c70 cmp dword ptr [rcx], 0x706c7374
0102ea24 0f85d6000000 jne 0x14102eb00
0102ea2a 83782800 cmp dword ptr [rax + 0x28], 0
0102ea2e 0f84cc000000 je 0x14102eb00
0102ea34 488b5830 mov rbx, qword ptr [rax + 0x30]
0102ea38 e9c3000000 jmp 0x14102eb00
0102ea3d 4d85ed test r13, r13
0102ea40 0f84ba000000 je 0x14102eb00
0102ea46 41817d0054534c4f cmp dword ptr [r13], 0x4f4c5354
0102ea4e 0f85ac000000 jne 0x14102eb00
0102ea54 41837d0400 cmp dword ptr [r13 + 4], 0
0102ea59 0f84a1000000 je 0x14102eb00
0102ea5f 498b5508 mov rdx, qword ptr [r13 + 8]
0102ea63 498b4d10 mov rcx, qword ptr [r13 + 0x10]
0102ea67 482bca sub rcx, rdx
0102ea6a 48c1f904 sar rcx, 4
0102ea6e 490fafcc imul rcx, r12
0102ea72 8bc6 mov eax, esi
0102ea74 483bc1 cmp rax, rcx
0102ea77 0f8383000000 jae 0x14102eb00
0102ea7d 420f103432 movups xmm6, xmmword ptr [rdx + r14]
0102ea82 420f10443210 movups xmm0, xmmword ptr [rdx + r14 + 0x10]
0102ea88 0f1145cf movups xmmword ptr [rbp - 0x31], xmm0
0102ea8c 428b443220 mov eax, dword ptr [rdx + r14 + 0x20]
0102ea91 8945df mov dword ptr [rbp - 0x21], eax
0102ea94 66480f7ef7 movq rdi, xmm6
0102ea99 488bc7 mov rax, rdi
0102ea9c 48c1e820 shr rax, 0x20
0102eaa0 85c0 test eax, eax
0102eaa2 7459 je 0x14102eafd
0102eaa4 85ff test edi, edi
0102eaa6 7455 je 0x14102eafd
0102eaa8 ff1522bd8b00 call qword ptr [rip + 0x8bbd22]
0102eaae 8bc8 mov ecx, eax
0102eab0 e82b16baff call 0x140bd00e0
0102eab5 84c0 test al, al
0102eab7 742c je 0x14102eae5
0102eab9 488b0dd0d90a01 mov rcx, qword ptr [rip + 0x10ad9d0]
0102eac0 4885c9 test rcx, rcx
0102eac3 7420 je 0x14102eae5
0102eac5 39b990000000 cmp dword ptr [rcx + 0x90], edi
0102eacb 741a je 0x14102eae7
0102eacd 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0102ead7 750c jne 0x14102eae5
0102ead9 488b4178 mov rax, qword ptr [rcx + 0x78]
0102eadd 488bc8 mov rcx, rax
0102eae0 4885c0 test rax, rax
0102eae3 75e0 jne 0x14102eac5
0102eae5 33c9 xor ecx, ecx
0102eae7 4885c9 test rcx, rcx
0102eaea 7411 je 0x14102eafd
0102eaec 660f73de04 psrldq xmm6, 4
0102eaf1 660f7ef2 movd edx, xmm6
0102eaf5 e8e691e8ff call 0x140eb7ce0
0102eafa 488bd8 mov rbx, rax
0102eafd 8b7d57 mov edi, dword ptr [rbp + 0x57]
0102eb00 4885db test rbx, rbx
0102eb03 7460 je 0x14102eb65
0102eb05 48837b1000 cmp qword ptr [rbx + 0x10], 0
0102eb0a 7504 jne 0x14102eb10
0102eb0c 33c9 xor ecx, ecx
0102eb0e eb45 jmp 0x14102eb55
0102eb10 f6839a00000001 test byte ptr [rbx + 0x9a], 1
0102eb17 7504 jne 0x14102eb1d
0102eb19 33c9 xor ecx, ecx
0102eb1b eb38 jmp 0x14102eb55
0102eb1d 488b4368 mov rax, qword ptr [rbx + 0x68]
0102eb21 8b4810 mov ecx, dword ptr [rax + 0x10]
0102eb24 85c9 test ecx, ecx
0102eb26 752d jne 0x14102eb55
0102eb28 398bac000000 cmp dword ptr [rbx + 0xac], ecx
0102eb2e 751f jne 0x14102eb4f
0102eb30 488bcb mov rcx, rbx
0102eb33 e80827f6ff call 0x140f91240
0102eb38 8983ac000000 mov dword ptr [rbx + 0xac], eax
0102eb3e 85c0 test eax, eax
0102eb40 740d je 0x14102eb4f
0102eb42 ba3c000000 mov edx, 0x3c
0102eb47 488bcb mov rcx, rbx
0102eb4a e8b155f6ff call 0x140f94100
0102eb4f 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
0102eb55 b823040000 mov eax, 0x423
0102eb5a 83f920 cmp ecx, 0x20
0102eb5d 0f45c1 cmovne eax, ecx
0102eb60 0bf8 or edi, eax
0102eb62 897d57 mov dword ptr [rbp + 0x57], edi
0102eb65 ffc6 inc esi
0102eb67 4983c630 add r14, 0x30
0102eb6b 4983ef01 sub r15, 1
0102eb6f bb00000000 mov ebx, 0
0102eb74 0f8586feffff jne 0x14102ea00
0102eb7a 4c8b6577 mov r12, qword ptr [rbp + 0x77]
0102eb7e 49c7c6ffffffff mov r14, 0xffffffffffffffff
0102eb85 488b756f mov rsi, qword ptr [rbp + 0x6f]
0102eb89 4885f6 test rsi, rsi
0102eb8c 0f844b030000 je 0x14102eedd
0102eb92 81be90000000756e656d cmp dword ptr [rsi + 0x90], 0x6d656e75
0102eb9c 750f jne 0x14102ebad
0102eb9e 488b8ea8000000 mov rcx, qword ptr [rsi + 0xa8]
0102eba5 ff153dcd8b00 call qword ptr [rip + 0x8bcd3d]
0102ebab 8bd8 mov ebx, eax
0102ebad 6685db test bx, bx
0102ebb0 7e17 jle 0x14102ebc9
0102ebb2 0fb7d3 movzx edx, bx
0102ebb5 488bce mov rcx, rsi
0102ebb8 e8f3aeb3ff call 0x140b69ab0
0102ebbd 85c0 test eax, eax
0102ebbf 7508 jne 0x14102ebc9
0102ebc1 66ffcb dec bx
0102ebc4 6685db test bx, bx
0102ebc7 7fe9 jg 0x14102ebb2
0102ebc9 33db xor ebx, ebx
0102ebcb 48c7459f6d6c6c70 mov qword ptr [rbp - 0x61], 0x706c6c6d
0102ebd3 48895da7 mov qword ptr [rbp - 0x59], rbx
0102ebd7 ff15f3bb8b00 call qword ptr [rip + 0x8bbbf3]
0102ebdd 8bc8 mov ecx, eax
0102ebdf e8fc14baff call 0x140bd00e0
0102ebe4 84c0 test al, al
0102ebe6 0f8492000000 je 0x14102ec7e
0102ebec 488b1d9dd80a01 mov rbx, qword ptr [rip + 0x10ad89d]
0102ebf3 4885db test rbx, rbx
0102ebf6 0f8480000000 je 0x14102ec7c
0102ebfc 0f1f4000 nop dword ptr [rax]
0102ec00 81bb8400000069506f64 cmp dword ptr [rbx + 0x84], 0x646f5069
0102ec0a 7409 je 0x14102ec15
0102ec0c 488b5b78 mov rbx, qword ptr [rbx + 0x78]
0102ec10 4885db test rbx, rbx
0102ec13 75eb jne 0x14102ec00
0102ec15 4885db test rbx, rbx
0102ec18 7462 je 0x14102ec7c
0102ec1a 660f1f440000 nop word ptr [rax + rax]
0102ec20 81bb8000000074616474 cmp dword ptr [rbx + 0x80], 0x74646174
0102ec2a 751c jne 0x14102ec48
0102ec2c 488bcb mov rcx, rbx
0102ec2f e85cd4eaff call 0x140edc090
0102ec34 4885c0 test rax, rax
0102ec37 740f je 0x14102ec48
0102ec39 4533c0 xor r8d, r8d
0102ec3c 488d55a7 lea rdx, [rbp - 0x59]
0102ec40 488bc8 mov rcx, rax
0102ec43 e8a8fcecff call 0x140efe8f0
0102ec48 4885db test rbx, rbx
0102ec4b 742f je 0x14102ec7c
0102ec4d 81bb8000000074616474 cmp dword ptr [rbx + 0x80], 0x74646174
0102ec57 7523 jne 0x14102ec7c
0102ec59 488b5b78 mov rbx, qword ptr [rbx + 0x78]
0102ec5d 4885db test rbx, rbx
0102ec60 741a je 0x14102ec7c
0102ec62 81bb8400000069506f64 cmp dword ptr [rbx + 0x84], 0x646f5069
0102ec6c 7409 je 0x14102ec77
0102ec6e 488b5b78 mov rbx, qword ptr [rbx + 0x78]
0102ec72 4885db test rbx, rbx
0102ec75 75eb jne 0x14102ec62
0102ec77 4885db test rbx, rbx
0102ec7a 75a4 jne 0x14102ec20
0102ec7c 33db xor ebx, ebx
0102ec7e 488d158bfaecff lea rdx, [rip - 0x130575]
0102ec85 488d4da7 lea rcx, [rbp - 0x59]
0102ec89 e8328fb7ff call 0x140ba7bc0
0102ec8e 817d9f6d6c6c70 cmp dword ptr [rbp - 0x61], 0x706c6c6d
0102ec95 0f8542020000 jne 0x14102eedd
0102ec9b 488b7da7 mov rdi, qword ptr [rbp - 0x59]
0102ec9f 4885ff test rdi, rdi
0102eca2 0f84e5010000 je 0x14102ee8d
0102eca8 448b7d57 mov r15d, dword ptr [rbp + 0x57]
0102ecac eb04 jmp 0x14102ecb2
0102ecae 6690 nop 
0102ecb0 33db xor ebx, ebx
0102ecb2 4d85ed test r13, r13
0102ecb5 0f8407010000 je 0x14102edc2
0102ecbb 4585e4 test r12d, r12d
0102ecbe 0f8e82010000 jle 0x14102ee46
0102ecc4 0f1f4000 nop dword ptr [rax]
0102ecc8 0f1f840000000000 nop dword ptr [rax + rax]
0102ecd0 4533c0 xor r8d, r8d
0102ecd3 8bd3 mov edx, ebx
0102ecd5 498bcd mov rcx, r13
0102ecd8 e8e3ec2aff call 0x1402dd9c0
0102ecdd 4885c0 test rax, rax
0102ece0 745b je 0x14102ed3d
0102ece2 488b08 mov rcx, qword ptr [rax]
0102ece5 4885c9 test rcx, rcx
0102ece8 7453 je 0x14102ed3d
0102ecea 813974736c70 cmp dword ptr [rcx], 0x706c7374
0102ecf0 754b jne 0x14102ed3d
0102ecf2 83782800 cmp dword ptr [rax + 0x28], 0
0102ecf6 7445 je 0x14102ed3d
0102ecf8 488b5030 mov rdx, qword ptr [rax + 0x30]
0102ecfc 4885d2 test rdx, rdx
0102ecff 743c je 0x14102ed3d
0102ed01 48837a1000 cmp qword ptr [rdx + 0x10], 0
0102ed06 742f je 0x14102ed37
0102ed08 488b4a58 mov rcx, qword ptr [rdx + 0x58]
0102ed0c 4885c9 test rcx, rcx
0102ed0f 7426 je 0x14102ed37
0102ed11 488b4108 mov rax, qword ptr [rcx + 8]
0102ed15 4885c0 test rax, rax
0102ed18 7410 je 0x14102ed2a
0102ed1a 4883781000 cmp qword ptr [rax + 0x10], 0
0102ed1f 7409 je 0x14102ed2a
0102ed21 81793444524853 cmp dword ptr [rcx + 0x34], 0x53485244
0102ed28 7508 jne 0x14102ed32
0102ed2a 488b09 mov rcx, qword ptr [rcx]
0102ed2d 4885c9 test rcx, rcx
0102ed30 75df jne 0x14102ed11
0102ed32 4885c9 test rcx, rcx
0102ed35 750a jne 0x14102ed41
0102ed37 488b4a58 mov rcx, qword ptr [rdx + 0x58]
0102ed3b eb04 jmp 0x14102ed41
0102ed3d 33c0 xor eax, eax
0102ed3f 8bc8 mov ecx, eax
0102ed41 488b4718 mov rax, qword ptr [rdi + 0x18]
0102ed45 488b5070 mov rdx, qword ptr [rax + 0x70]
0102ed49 488955af mov qword ptr [rbp - 0x51], rdx
0102ed4d 4c8975b7 mov qword ptr [rbp - 0x49], r14
0102ed51 4885d2 test rdx, rdx
0102ed54 745c je 0x14102edb2
0102ed56 4c8b0a mov r9, qword ptr [rdx]
0102ed59 4d85c9 test r9, r9
0102ed5c 7454 je 0x14102edb2
0102ed5e 41813974736c70 cmp dword ptr [r9], 0x706c7374
0102ed65 754b jne 0x14102edb2
0102ed67 837a2800 cmp dword ptr [rdx + 0x28], 0
0102ed6b 7445 je 0x14102edb2
0102ed6d 4885c9 test rcx, rcx
0102ed70 7440 je 0x14102edb2
0102ed72 488b4108 mov rax, qword ptr [rcx + 8]
0102ed76 4885c0 test rax, rax
0102ed79 7437 je 0x14102edb2
0102ed7b 4883781000 cmp qword ptr [rax + 0x10], 0
0102ed80 7430 je 0x14102edb2
0102ed82 0f57c0 xorps xmm0, xmm0
0102ed85 0f1145bf movups xmmword ptr [rbp - 0x41], xmm0
0102ed89 0f1145cf movups xmmword ptr [rbp - 0x31], xmm0
0102ed8d 488d45af lea rax, [rbp - 0x51]
0102ed91 488945bf mov qword ptr [rbp - 0x41], rax
0102ed95 48894dc7 mov qword ptr [rbp - 0x39], rcx
0102ed99 c645d301 mov byte ptr [rbp - 0x2d], 1
0102ed9d 4c8d45bf lea r8, [rbp - 0x41]
0102eda1 ba6c616c70 mov edx, 0x706c616c
0102eda6 498bc9 mov rcx, r9
0102eda9 e8d257ecff call 0x140ef4580
0102edae 85c0 test eax, eax
0102edb0 7410 je 0x14102edc2
0102edb2 ffc3 inc ebx
0102edb4 413bdc cmp ebx, r12d
0102edb7 0f8c13ffffff jl 0x14102ecd0
0102edbd e984000000 jmp 0x14102ee46
0102edc2 488b454f mov rax, qword ptr [rbp + 0x4f]
0102edc6 8b5d5f mov ebx, dword ptr [rbp + 0x5f]
0102edc9 48394718 cmp qword ptr [rdi + 0x18], rax
0102edcd 7435 je 0x14102ee04
0102edcf c7876402000065787463 mov dword ptr [rdi + 0x264], 0x63747865
0102edd9 c7877802000001000000 mov dword ptr [rdi + 0x278], 1
0102ede3 33c0 xor eax, eax
0102ede5 4889442430 mov qword ptr [rsp + 0x30], rax
0102edea 895c2420 mov dword ptr [rsp + 0x20], ebx
0102edee 4c8bc6 mov r8, rsi
0102edf1 33d2 xor edx, edx
0102edf3 488d4d9f lea rcx, [rbp - 0x61]
0102edf7 e88493e7ff call 0x140ea8180
0102edfc 33c0 xor eax, eax
0102edfe 898778020000 mov dword ptr [rdi + 0x278], eax
0102ee04 488b4f18 mov rcx, qword ptr [rdi + 0x18]
0102ee08 4885c9 test rcx, rcx
0102ee0b 7439 je 0x14102ee46
0102ee0d 488b4108 mov rax, qword ptr [rcx + 8]
0102ee11 4885c0 test rax, rax
0102ee14 7430 je 0x14102ee46
0102ee16 81b88000000074616474 cmp dword ptr [rax + 0x80], 0x74646174
0102ee20 7524 jne 0x14102ee46
0102ee22 81b88400000069506f64 cmp dword ptr [rax + 0x84], 0x646f5069
0102ee2c 7518 jne 0x14102ee46
0102ee2e f680fa20000010 test byte ptr [rax + 0x20fa], 0x10
0102ee35 750f jne 0x14102ee46
0102ee37 895c2420 mov dword ptr [rsp + 0x20], ebx
0102ee3b 4c8bc6 mov r8, rsi
0102ee3e 418bd7 mov edx, r15d
0102ee41 e8daf8ffff call 0x14102e720
0102ee46 4885ff test rdi, rdi
0102ee49 7442 je 0x14102ee8d
0102ee4b 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0102ee4f 4885c9 test rcx, rcx
0102ee52 752d jne 0x14102ee81
0102ee54 488b0f mov rcx, qword ptr [rdi]
0102ee57 4885c9 test rcx, rcx
0102ee5a 7525 jne 0x14102ee81
0102ee5c 488b4708 mov rax, qword ptr [rdi + 8]
0102ee60 4885c0 test rax, rax
0102ee63 741c je 0x14102ee81
0102ee65 488b08 mov rcx, qword ptr [rax]
0102ee68 4885c9 test rcx, rcx
0102ee6b 7514 jne 0x14102ee81
0102ee6d 0f1f00 nop dword ptr [rax]
0102ee70 488b4008 mov rax, qword ptr [rax + 8]
0102ee74 4885c0 test rax, rax
0102ee77 7408 je 0x14102ee81
0102ee79 488b08 mov rcx, qword ptr [rax]
0102ee7c 4885c9 test rcx, rcx
0102ee7f 74ef je 0x14102ee70
0102ee81 488bf9 mov rdi, rcx
0102ee84 4885c9 test rcx, rcx
0102ee87 0f8523feffff jne 0x14102ecb0
0102ee8d 817d9f6d6c6c70 cmp dword ptr [rbp - 0x61], 0x706c6c6d
0102ee94 7547 jne 0x14102eedd
0102ee96 488b7da7 mov rdi, qword ptr [rbp - 0x59]
0102ee9a 4533e4 xor r12d, r12d
0102ee9d 4885ff test rdi, rdi
0102eea0 743e je 0x14102eee0
0102eea2 488bc7 mov rax, rdi
0102eea5 6666660f1f840000000000 nop word ptr [rax + rax]
0102eeb0 488b18 mov rbx, qword ptr [rax]
0102eeb3 4c8920 mov qword ptr [rax], r12
0102eeb6 488d4f10 lea rcx, [rdi + 0x10]
0102eeba e8e1f7ecff call 0x140efe6a0
0102eebf 488bc3 mov rax, rbx
0102eec2 4885ff test rdi, rdi
0102eec5 740c je 0x14102eed3
0102eec7 488bcf mov rcx, rdi
0102eeca ff1598d48b00 call qword ptr [rip + 0x8bd498]
0102eed0 488bc3 mov rax, rbx
0102eed3 488bfb mov rdi, rbx
0102eed6 4885db test rbx, rbx
0102eed9 75d5 jne 0x14102eeb0
0102eedb eb03 jmp 0x14102eee0
0102eedd 4533e4 xor r12d, r12d
0102eee0 4c8b7d67 mov r15, qword ptr [rbp + 0x67]
0102eee4 4d85ff test r15, r15
0102eee7 0f8467010000 je 0x14102f054
0102eeed 410fb7dc movzx ebx, r12w
0102eef1 4181bf90000000756e656d cmp dword ptr [r15 + 0x90], 0x6d656e75
0102eefc 750f jne 0x14102ef0d
0102eefe 498b8fa8000000 mov rcx, qword ptr [r15 + 0xa8]
0102ef05 ff15ddc98b00 call qword ptr [rip + 0x8bc9dd]
0102ef0b 8bd8 mov ebx, eax
0102ef0d 6685db test bx, bx
0102ef10 7e17 jle 0x14102ef29
0102ef12 0fb7d3 movzx edx, bx
0102ef15 498bcf mov rcx, r15
0102ef18 e893abb3ff call 0x140b69ab0
0102ef1d 85c0 test eax, eax
0102ef1f 7508 jne 0x14102ef29
0102ef21 66ffcb dec bx
0102ef24 6685db test bx, bx
0102ef27 7fe9 jg 0x14102ef12
0102ef29 0fb6757f movzx esi, byte ptr [rbp + 0x7f]
0102ef2d 4084f6 test sil, sil
0102ef30 0f84d3000000 je 0x14102f009
0102ef36 488b0da30d0a01 mov rcx, qword ptr [rip + 0x10a0da3]
0102ef3d 4885c9 test rcx, rcx
0102ef40 742f je 0x14102ef71
0102ef42 ba0b002c7e mov edx, 0x7e2c000b
0102ef47 ff15a39e8b00 call qword ptr [rip + 0x8b9ea3]
0102ef4d 488bf8 mov rdi, rax
0102ef50 4885c0 test rax, rax
0102ef53 7417 je 0x14102ef6c
0102ef55 488bc8 mov rcx, rax
0102ef58 ff15629f8b00 call qword ptr [rip + 0x8b9f62]
0102ef5e 488bd8 mov rbx, rax
0102ef61 ff1519a08b00 call qword ptr [rip + 0x8ba019]
0102ef67 483bd8 cmp rbx, rax
0102ef6a 7505 jne 0x14102ef71
0102ef6c 4885ff test rdi, rdi
0102ef6f 7507 jne 0x14102ef78
0102ef71 488b3d80ec0701 mov rdi, qword ptr [rip + 0x107ec80]
0102ef78 488bd7 mov rdx, rdi
0102ef7b 488d4d9f lea rcx, [rbp - 0x61]
0102ef7f e85c73aaff call 0x140ad62e0
0102ef84 90 nop 
0102ef85 4c89642430 mov qword ptr [rsp + 0x30], r12
0102ef8a c744242800010000 mov dword ptr [rsp + 0x28], 0x100
0102ef92 664489642420 mov word ptr [rsp + 0x20], r12w
0102ef98 4533c9 xor r9d, r9d
0102ef9b 41b8736c706e mov r8d, 0x6e706c73
0102efa1 488d559f lea rdx, [rbp - 0x61]
0102efa5 498bcf mov rcx, r15
0102efa8 e8036ab6ff call 0x140b959b0
0102efad 90 nop 
0102efae 488b4d9f mov rcx, qword ptr [rbp - 0x61]
0102efb2 4885c9 test rcx, rcx
0102efb5 7419 je 0x14102efd0
0102efb7 418bc6 mov eax, r14d
0102efba f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102efbf 83f801 cmp eax, 1
0102efc2 750c jne 0x14102efd0
0102efc4 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102efcb e808ce7600 call 0x14179bdd8
0102efd0 488b4da7 mov rcx, qword ptr [rbp - 0x59]
0102efd4 4885c9 test rcx, rcx
0102efd7 7430 je 0x14102f009
0102efd9 f0440fc17108 lock xadd dword ptr [rcx + 8], r14d
0102efdf 4183fe01 cmp r14d, 1
0102efe3 7524 jne 0x14102f009
0102efe5 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102efec e8e7cd7600 call 0x14179bdd8
0102eff1 8b455f mov eax, dword ptr [rbp + 0x5f]
0102eff4 89442420 mov dword ptr [rsp + 0x20], eax
0102eff8 4d8bc7 mov r8, r15
0102effb 8b5557 mov edx, dword ptr [rbp + 0x57]
0102effe 488b4d4f mov rcx, qword ptr [rbp + 0x4f]
0102f002 e819f7ffff call 0x14102e720
0102f007 eb1b jmp 0x14102f024
0102f009 8b455f mov eax, dword ptr [rbp + 0x5f]
0102f00c 89442420 mov dword ptr [rsp + 0x20], eax
0102f010 4d8bc7 mov r8, r15
0102f013 8b5557 mov edx, dword ptr [rbp + 0x57]
0102f016 488b4d4f mov rcx, qword ptr [rbp + 0x4f]
0102f01a e801f7ffff call 0x14102e720
0102f01f 4084f6 test sil, sil
0102f022 7430 je 0x14102f054
0102f024 4181bf90000000756e656d cmp dword ptr [r15 + 0x90], 0x6d656e75
0102f02f 7523 jne 0x14102f054
0102f031 498b8fa8000000 mov rcx, qword ptr [r15 + 0xa8]
0102f038 ff15aac88b00 call qword ptr [rip + 0x8bc8aa]
0102f03e 6683f801 cmp ax, 1
0102f042 7e10 jle 0x14102f054
0102f044 ba01000000 mov edx, 1
0102f049 4533c0 xor r8d, r8d
0102f04c 498bcf mov rcx, r15
0102f04f e80ca7b3ff call 0x140b69760
0102f054 0f28b42490000000 movaps xmm6, xmmword ptr [rsp + 0x90]
0102f05c 4881c4a8000000 add rsp, 0xa8
0102f063 415f pop r15
0102f065 415e pop r14
0102f067 415d pop r13
0102f069 415c pop r12
0102f06b 5f pop rdi
0102f06c 5e pop rsi
0102f06d 5b pop rbx
0102f06e 5d pop rbp
0102f06f c3 ret 