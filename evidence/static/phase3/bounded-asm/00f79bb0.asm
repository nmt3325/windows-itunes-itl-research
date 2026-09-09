00f79bb0 4053 push rbx
00f79bb2 4883ec20 sub rsp, 0x20
00f79bb6 8179586b617274 cmp dword ptr [rcx + 0x58], 0x7472616b
00f79bbd 488bd9 mov rbx, rcx
00f79bc0 0f85a8010000 jne 0x140f79d6e
00f79bc6 0f1002 movups xmm0, xmmword ptr [rdx]
00f79bc9 48896c2430 mov qword ptr [rsp + 0x30], rbp
00f79bce 488da9c0000000 lea rbp, [rcx + 0xc0]
00f79bd5 488bca mov rcx, rdx
00f79bd8 4889742438 mov qword ptr [rsp + 0x38], rsi
00f79bdd 0f114500 movups xmmword ptr [rbp], xmm0
00f79be1 0f104a10 movups xmm1, xmmword ptr [rdx + 0x10]
00f79be5 0f114d10 movups xmmword ptr [rbp + 0x10], xmm1
00f79be9 0f104220 movups xmm0, xmmword ptr [rdx + 0x20]
00f79bed 0f114520 movups xmmword ptr [rbp + 0x20], xmm0
00f79bf1 0f104a30 movups xmm1, xmmword ptr [rdx + 0x30]
00f79bf5 0f114d30 movups xmmword ptr [rbp + 0x30], xmm1
00f79bf9 e86223f8ff call 0x140efbf60
00f79bfe 488bf0 mov rsi, rax
00f79c01 4885c0 test rax, rax
00f79c04 0f845a010000 je 0x140f79d64
00f79c0a 48897c2440 mov qword ptr [rsp + 0x40], rdi
00f79c0f 488dbb00010000 lea rdi, [rbx + 0x100]
00f79c16 4885ff test rdi, rdi
00f79c19 747f je 0x140f79c9a
00f79c1b 33c0 xor eax, eax
00f79c1d 0f57c0 xorps xmm0, xmm0
00f79c20 0f1107 movups xmmword ptr [rdi], xmm0
00f79c23 0f114710 movups xmmword ptr [rdi + 0x10], xmm0
00f79c27 894720 mov dword ptr [rdi + 0x20], eax
00f79c2a 488b06 mov rax, qword ptr [rsi]
00f79c2d 4885c0 test rax, rax
00f79c30 7468 je 0x140f79c9a
00f79c32 813874736c70 cmp dword ptr [rax], 0x706c7374
00f79c38 7560 jne 0x140f79c9a
00f79c3a 837e2800 cmp dword ptr [rsi + 0x28], 0
00f79c3e 745a je 0x140f79c9a
00f79c40 488b4008 mov rax, qword ptr [rax + 8]
00f79c44 8b8890000000 mov ecx, dword ptr [rax + 0x90]
00f79c4a 890f mov dword ptr [rdi], ecx
00f79c4c 488b06 mov rax, qword ptr [rsi]
00f79c4f 8b4848 mov ecx, dword ptr [rax + 0x48]
00f79c52 894f0c mov dword ptr [rdi + 0xc], ecx
00f79c55 8b4628 mov eax, dword ptr [rsi + 0x28]
00f79c58 894710 mov dword ptr [rdi + 0x10], eax
00f79c5b f6464b01 test byte ptr [rsi + 0x4b], 1
00f79c5f 7539 jne 0x140f79c9a
00f79c61 488b4630 mov rax, qword ptr [rsi + 0x30]
00f79c65 8b4808 mov ecx, dword ptr [rax + 8]
00f79c68 894f04 mov dword ptr [rdi + 4], ecx
00f79c6b 488b06 mov rax, qword ptr [rsi]
00f79c6e 4885c0 test rax, rax
00f79c71 7427 je 0x140f79c9a
00f79c73 813874736c70 cmp dword ptr [rax], 0x706c7374
00f79c79 751f jne 0x140f79c9a
00f79c7b 837e2800 cmp dword ptr [rsi + 0x28], 0
00f79c7f 7419 je 0x140f79c9a
00f79c81 488b4e30 mov rcx, qword ptr [rsi + 0x30]
00f79c85 4885c9 test rcx, rcx
00f79c88 7410 je 0x140f79c9a
00f79c8a e8b1be40ff call 0x140385b40
00f79c8f 4885c0 test rax, rax
00f79c92 7406 je 0x140f79c9a
00f79c94 8b4028 mov eax, dword ptr [rax + 0x28]
00f79c97 894708 mov dword ptr [rdi + 8], eax
00f79c9a 808bb001000001 or byte ptr [rbx + 0x1b0], 1
00f79ca1 0fb683b0010000 movzx eax, byte ptr [rbx + 0x1b0]
00f79ca8 0fb64e4b movzx ecx, byte ptr [rsi + 0x4b]
00f79cac 02c9 add cl, cl
00f79cae 32c8 xor cl, al
00f79cb0 80e102 and cl, 2
00f79cb3 32c8 xor cl, al
00f79cb5 488b03 mov rax, qword ptr [rbx]
00f79cb8 888bb0010000 mov byte ptr [rbx + 0x1b0], cl
00f79cbe 488bcb mov rcx, rbx
00f79cc1 488b16 mov rdx, qword ptr [rsi]
00f79cc4 ff90d8010000 call qword ptr [rax + 0x1d8]
00f79cca 488b7e30 mov rdi, qword ptr [rsi + 0x30]
00f79cce 4885ff test rdi, rdi
00f79cd1 0f8488000000 je 0x140f79d5f
00f79cd7 48837f1000 cmp qword ptr [rdi + 0x10], 0
00f79cdc 7409 je 0x140f79ce7
00f79cde f6879a00000001 test byte ptr [rdi + 0x9a], 1
00f79ce5 750c jne 0x140f79cf3
00f79ce7 c7838000000000000000 mov dword ptr [rbx + 0x80], 0
00f79cf1 eb6c jmp 0x140f79d5f
00f79cf3 488b4768 mov rax, qword ptr [rdi + 0x68]
00f79cf7 8b4810 mov ecx, dword ptr [rax + 0x10]
00f79cfa 85c9 test ecx, ecx
00f79cfc 752d jne 0x140f79d2b
00f79cfe 398fac000000 cmp dword ptr [rdi + 0xac], ecx
00f79d04 751f jne 0x140f79d25
00f79d06 488bcf mov rcx, rdi
00f79d09 e832750100 call 0x140f91240
00f79d0e 8987ac000000 mov dword ptr [rdi + 0xac], eax
00f79d14 85c0 test eax, eax
00f79d16 740d je 0x140f79d25
00f79d18 ba3c000000 mov edx, 0x3c
00f79d1d 488bcf mov rcx, rdi
00f79d20 e8dba30100 call 0x140f94100
00f79d25 8b8fac000000 mov ecx, dword ptr [rdi + 0xac]
00f79d2b 898b80000000 mov dword ptr [rbx + 0x80], ecx
00f79d31 0fbae110 bt ecx, 0x10
00f79d35 7328 jae 0x140f79d5f
00f79d37 488d8b24010000 lea rcx, [rbx + 0x124]
00f79d3e 4885ed test rbp, rbp
00f79d41 7413 je 0x140f79d56
00f79d43 4885c9 test rcx, rcx
00f79d46 740e je 0x140f79d56
00f79d48 41b840000000 mov r8d, 0x40
00f79d4e 488bd5 mov rdx, rbp
00f79d51 e81fdb8e00 call 0x141867875
00f79d56 8b4628 mov eax, dword ptr [rsi + 0x28]
00f79d59 898364010000 mov dword ptr [rbx + 0x164], eax
00f79d5f 488b7c2440 mov rdi, qword ptr [rsp + 0x40]
00f79d64 488b6c2430 mov rbp, qword ptr [rsp + 0x30]
00f79d69 488b742438 mov rsi, qword ptr [rsp + 0x38]
00f79d6e 4883c420 add rsp, 0x20
00f79d72 5b pop rbx
00f79d73 c3 ret 