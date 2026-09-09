00f79610 4053 push rbx
00f79612 57 push rdi
00f79613 4883ec28 sub rsp, 0x28
00f79617 488bda mov rbx, rdx
00f7961a 488bf9 mov rdi, rcx
00f7961d 4885d2 test rdx, rdx
00f79620 750c jne 0x140f7962e
00f79622 b8ceffffff mov eax, 0xffffffce
00f79627 4883c428 add rsp, 0x28
00f7962b 5f pop rdi
00f7962c 5b pop rbx
00f7962d c3 ret 
00f7962e 488b01 mov rax, qword ptr [rcx]
00f79631 ba6b617274 mov edx, 0x7472616b
00f79636 4c897c2420 mov qword ptr [rsp + 0x20], r15
00f7963b ff90c8040000 call qword ptr [rax + 0x4c8]
00f79641 448bf8 mov r15d, eax
00f79644 85c0 test eax, eax
00f79646 0f85c1030000 jne 0x140f79a0d
00f7964c 4889742448 mov qword ptr [rsp + 0x48], rsi
00f79651 4c89742450 mov qword ptr [rsp + 0x50], r14
00f79656 4c8db7c0000000 lea r14, [rdi + 0xc0]
00f7965d 4d85f6 test r14, r14
00f79660 745e je 0x140f796c0
00f79662 0f57c0 xorps xmm0, xmm0
00f79665 410f1106 movups xmmword ptr [r14], xmm0
00f79669 410f114610 movups xmmword ptr [r14 + 0x10], xmm0
00f7966e 410f114620 movups xmmword ptr [r14 + 0x20], xmm0
00f79673 410f114630 movups xmmword ptr [r14 + 0x30], xmm0
00f79678 488b03 mov rax, qword ptr [rbx]
00f7967b 4885c0 test rax, rax
00f7967e 7440 je 0x140f796c0
00f79680 813874736c70 cmp dword ptr [rax], 0x706c7374
00f79686 7538 jne 0x140f796c0
00f79688 44397b28 cmp dword ptr [rbx + 0x28], r15d
00f7968c 7432 je 0x140f796c0
00f7968e 488b4008 mov rax, qword ptr [rax + 8]
00f79692 488b8888000000 mov rcx, qword ptr [rax + 0x88]
00f79699 49890e mov qword ptr [r14], rcx
00f7969c 488b03 mov rax, qword ptr [rbx]
00f7969f 488b4850 mov rcx, qword ptr [rax + 0x50]
00f796a3 49894e10 mov qword ptr [r14 + 0x10], rcx
00f796a7 488b4320 mov rax, qword ptr [rbx + 0x20]
00f796ab 49894618 mov qword ptr [r14 + 0x18], rax
00f796af f6434b01 test byte ptr [rbx + 0x4b], 1
00f796b3 750b jne 0x140f796c0
00f796b5 488b4330 mov rax, qword ptr [rbx + 0x30]
00f796b9 488b08 mov rcx, qword ptr [rax]
00f796bc 49894e08 mov qword ptr [r14 + 8], rcx
00f796c0 488db700010000 lea rsi, [rdi + 0x100]
00f796c7 4885f6 test rsi, rsi
00f796ca 747f je 0x140f7974b
00f796cc 33c0 xor eax, eax
00f796ce 0f57c0 xorps xmm0, xmm0
00f796d1 0f1106 movups xmmword ptr [rsi], xmm0
00f796d4 0f114610 movups xmmword ptr [rsi + 0x10], xmm0
00f796d8 894620 mov dword ptr [rsi + 0x20], eax
00f796db 488b03 mov rax, qword ptr [rbx]
00f796de 4885c0 test rax, rax
00f796e1 7468 je 0x140f7974b
00f796e3 813874736c70 cmp dword ptr [rax], 0x706c7374
00f796e9 7560 jne 0x140f7974b
00f796eb 837b2800 cmp dword ptr [rbx + 0x28], 0
00f796ef 745a je 0x140f7974b
00f796f1 488b4008 mov rax, qword ptr [rax + 8]
00f796f5 8b8890000000 mov ecx, dword ptr [rax + 0x90]
00f796fb 890e mov dword ptr [rsi], ecx
00f796fd 488b03 mov rax, qword ptr [rbx]
00f79700 8b4848 mov ecx, dword ptr [rax + 0x48]
00f79703 894e0c mov dword ptr [rsi + 0xc], ecx
00f79706 8b4328 mov eax, dword ptr [rbx + 0x28]
00f79709 894610 mov dword ptr [rsi + 0x10], eax
00f7970c f6434b01 test byte ptr [rbx + 0x4b], 1
00f79710 7539 jne 0x140f7974b
00f79712 488b4330 mov rax, qword ptr [rbx + 0x30]
00f79716 8b4808 mov ecx, dword ptr [rax + 8]
00f79719 894e04 mov dword ptr [rsi + 4], ecx
00f7971c 488b03 mov rax, qword ptr [rbx]
00f7971f 4885c0 test rax, rax
00f79722 7427 je 0x140f7974b
00f79724 813874736c70 cmp dword ptr [rax], 0x706c7374
00f7972a 751f jne 0x140f7974b
00f7972c 837b2800 cmp dword ptr [rbx + 0x28], 0
00f79730 7419 je 0x140f7974b
00f79732 488b4b30 mov rcx, qword ptr [rbx + 0x30]
00f79736 4885c9 test rcx, rcx
00f79739 7410 je 0x140f7974b
00f7973b e800c440ff call 0x140385b40
00f79740 4885c0 test rax, rax
00f79743 7406 je 0x140f7974b
00f79745 8b4028 mov eax, dword ptr [rax + 0x28]
00f79748 894608 mov dword ptr [rsi + 8], eax
00f7974b 808fb001000001 or byte ptr [rdi + 0x1b0], 1
00f79752 0fb687b0010000 movzx eax, byte ptr [rdi + 0x1b0]
00f79759 0fb6534b movzx edx, byte ptr [rbx + 0x4b]
00f7975d 02d2 add dl, dl
00f7975f 32d0 xor dl, al
00f79761 80e202 and dl, 2
00f79764 32d0 xor dl, al
00f79766 8897b0010000 mov byte ptr [rdi + 0x1b0], dl
00f7976c 4c8b4330 mov r8, qword ptr [rbx + 0x30]
00f79770 4d85c0 test r8, r8
00f79773 7463 je 0x140f797d8
00f79775 4983781000 cmp qword ptr [r8 + 0x10], 0
00f7977a 745c je 0x140f797d8
00f7977c 41f6809a00000008 test byte ptr [r8 + 0x9a], 8
00f79784 7452 je 0x140f797d8
00f79786 498b4058 mov rax, qword ptr [r8 + 0x58]
00f7978a 4885c0 test rax, rax
00f7978d 7427 je 0x140f797b6
00f7978f 90 nop 
00f79790 488b4808 mov rcx, qword ptr [rax + 8]
00f79794 4885c9 test rcx, rcx
00f79797 7410 je 0x140f797a9
00f79799 4883791000 cmp qword ptr [rcx + 0x10], 0
00f7979e 7409 je 0x140f797a9
00f797a0 81783444524853 cmp dword ptr [rax + 0x34], 0x53485244
00f797a7 7508 jne 0x140f797b1
00f797a9 488b00 mov rax, qword ptr [rax]
00f797ac 4885c0 test rax, rax
00f797af 75df jne 0x140f79790
00f797b1 4885c0 test rax, rax
00f797b4 7509 jne 0x140f797bf
00f797b6 498b4058 mov rax, qword ptr [r8 + 0x58]
00f797ba 4885c0 test rax, rax
00f797bd 7419 je 0x140f797d8
00f797bf 488b4808 mov rcx, qword ptr [rax + 8]
00f797c3 4885c9 test rcx, rcx
00f797c6 7410 je 0x140f797d8
00f797c8 4883791000 cmp qword ptr [rcx + 0x10], 0
00f797cd 7409 je 0x140f797d8
00f797cf 0fb64042 movzx eax, byte ptr [rax + 0x42]
00f797d3 c0e806 shr al, 6
00f797d6 eb02 jmp 0x140f797da
00f797d8 32c0 xor al, al
00f797da c0e003 shl al, 3
00f797dd 32c2 xor al, dl
00f797df 2408 and al, 8
00f797e1 32c2 xor al, dl
00f797e3 8887b0010000 mov byte ptr [rdi + 0x1b0], al
00f797e9 488b03 mov rax, qword ptr [rbx]
00f797ec 488b4808 mov rcx, qword ptr [rax + 8]
00f797f0 8b8184000000 mov eax, dword ptr [rcx + 0x84]
00f797f6 488bcf mov rcx, rdi
00f797f9 894750 mov dword ptr [rdi + 0x50], eax
00f797fc 488b07 mov rax, qword ptr [rdi]
00f797ff 488b13 mov rdx, qword ptr [rbx]
00f79802 ff90d8010000 call qword ptr [rax + 0x1d8]
00f79808 488b4b30 mov rcx, qword ptr [rbx + 0x30]
00f7980c 4885c9 test rcx, rcx
00f7980f 0f84eb010000 je 0x140f79a00
00f79815 0fb6899b000000 movzx ecx, byte ptr [rcx + 0x9b]
00f7981c 0fb687b8000000 movzx eax, byte ptr [rdi + 0xb8]
00f79823 c0e904 shr cl, 4
00f79826 32c8 xor cl, al
00f79828 48896c2440 mov qword ptr [rsp + 0x40], rbp
00f7982d 80e102 and cl, 2
00f79830 32c8 xor cl, al
00f79832 888fb8000000 mov byte ptr [rdi + 0xb8], cl
00f79838 488b4330 mov rax, qword ptr [rbx + 0x30]
00f7983c 4885c0 test rax, rax
00f7983f 7418 je 0x140f79859
00f79841 4883781000 cmp qword ptr [rax + 0x10], 0
00f79846 7411 je 0x140f79859
00f79848 488b8080000000 mov rax, qword ptr [rax + 0x80]
00f7984f 440fb600 movzx r8d, byte ptr [rax]
00f79853 41c0e802 shr r8b, 2
00f79857 eb03 jmp 0x140f7985c
00f79859 4532c0 xor r8b, r8b
00f7985c 41c0e002 shl r8b, 2
00f79860 33f6 xor esi, esi
00f79862 4432c1 xor r8b, cl
00f79865 4180e004 and r8b, 4
00f79869 4432c1 xor r8b, cl
00f7986c 448887b8000000 mov byte ptr [rdi + 0xb8], r8b
00f79873 488b4330 mov rax, qword ptr [rbx + 0x30]
00f79877 488b8880000000 mov rcx, qword ptr [rax + 0x80]
00f7987e 0fb611 movzx edx, byte ptr [rcx]
00f79881 c0e202 shl dl, 2
00f79884 4132d0 xor dl, r8b
00f79887 80e208 and dl, 8
00f7988a 4132d0 xor dl, r8b
00f7988d 8897b8000000 mov byte ptr [rdi + 0xb8], dl
00f79893 488b4330 mov rax, qword ptr [rbx + 0x30]
00f79897 0fb6889b000000 movzx ecx, byte ptr [rax + 0x9b]
00f7989e 02c9 add cl, cl
00f798a0 32ca xor cl, dl
00f798a2 80e110 and cl, 0x10
00f798a5 32ca xor cl, dl
00f798a7 888fb8000000 mov byte ptr [rdi + 0xb8], cl
00f798ad 488b6b30 mov rbp, qword ptr [rbx + 0x30]
00f798b1 4885ed test rbp, rbp
00f798b4 747d je 0x140f79933
00f798b6 48397510 cmp qword ptr [rbp + 0x10], rsi
00f798ba 7477 je 0x140f79933
00f798bc f6859a00000001 test byte ptr [rbp + 0x9a], 1
00f798c3 746e je 0x140f79933
00f798c5 488b4568 mov rax, qword ptr [rbp + 0x68]
00f798c9 8b4810 mov ecx, dword ptr [rax + 0x10]
00f798cc 85c9 test ecx, ecx
00f798ce 752d jne 0x140f798fd
00f798d0 39b5ac000000 cmp dword ptr [rbp + 0xac], esi
00f798d6 751f jne 0x140f798f7
00f798d8 488bcd mov rcx, rbp
00f798db e860790100 call 0x140f91240
00f798e0 8985ac000000 mov dword ptr [rbp + 0xac], eax
00f798e6 85c0 test eax, eax
00f798e8 740d je 0x140f798f7
00f798ea ba3c000000 mov edx, 0x3c
00f798ef 488bcd mov rcx, rbp
00f798f2 e809a80100 call 0x140f94100
00f798f7 8b8dac000000 mov ecx, dword ptr [rbp + 0xac]
00f798fd 898f80000000 mov dword ptr [rdi + 0x80], ecx
00f79903 0fbae110 bt ecx, 0x10
00f79907 7330 jae 0x140f79939
00f79909 488d8f24010000 lea rcx, [rdi + 0x124]
00f79910 4d85f6 test r14, r14
00f79913 7413 je 0x140f79928
00f79915 4885c9 test rcx, rcx
00f79918 740e je 0x140f79928
00f7991a 41b840000000 mov r8d, 0x40
00f79920 498bd6 mov rdx, r14
00f79923 e84ddf8e00 call 0x141867875
00f79928 8b4328 mov eax, dword ptr [rbx + 0x28]
00f7992b 898764010000 mov dword ptr [rdi + 0x164], eax
00f79931 eb06 jmp 0x140f79939
00f79933 89b780000000 mov dword ptr [rdi + 0x80], esi
00f79939 488b4330 mov rax, qword ptr [rbx + 0x30]
00f7993d 488b6c2440 mov rbp, qword ptr [rsp + 0x40]
00f79942 4885c0 test rax, rax
00f79945 742b je 0x140f79972
00f79947 48397010 cmp qword ptr [rax + 0x10], rsi
00f7994b 7425 je 0x140f79972
00f7994d 488b4858 mov rcx, qword ptr [rax + 0x58]
00f79951 4885c9 test rcx, rcx
00f79954 741c je 0x140f79972
00f79956 488b4108 mov rax, qword ptr [rcx + 8]
00f7995a 4885c0 test rax, rax
00f7995d 7413 je 0x140f79972
00f7995f 48397010 cmp qword ptr [rax + 0x10], rsi
00f79963 740d je 0x140f79972
00f79965 488b4110 mov rax, qword ptr [rcx + 0x10]
00f79969 f60001 test byte ptr [rax], 1
00f7996c 7404 je 0x140f79972
00f7996e 488b7038 mov rsi, qword ptr [rax + 0x38]
00f79972 80a7b8000000df and byte ptr [rdi + 0xb8], 0xdf
00f79979 0fb68fb0010000 movzx ecx, byte ptr [rdi + 0x1b0]
00f79980 4889b768010000 mov qword ptr [rdi + 0x168], rsi
00f79987 48f7de neg rsi
00f7998a 1ac0 sbb al, al
00f7998c 2420 and al, 0x20
00f7998e 0887b8000000 or byte ptr [rdi + 0xb8], al
00f79994 488b4330 mov rax, qword ptr [rbx + 0x30]
00f79998 440fb680a0000000 movzx r8d, byte ptr [rax + 0xa0]
00f799a0 41c0e004 shl r8b, 4
00f799a4 4432c1 xor r8b, cl
00f799a7 4180e010 and r8b, 0x10
00f799ab 4432c1 xor r8b, cl
00f799ae 448887b0010000 mov byte ptr [rdi + 0x1b0], r8b
00f799b5 488b5330 mov rdx, qword ptr [rbx + 0x30]
00f799b9 4885d2 test rdx, rdx
00f799bc 7413 je 0x140f799d1
00f799be 48837a1000 cmp qword ptr [rdx + 0x10], 0
00f799c3 740c je 0x140f799d1
00f799c5 0fb692a0000000 movzx edx, byte ptr [rdx + 0xa0]
00f799cc c0ea02 shr dl, 2
00f799cf eb02 jmp 0x140f799d3
00f799d1 32d2 xor dl, dl
00f799d3 c0e205 shl dl, 5
00f799d6 4132d0 xor dl, r8b
00f799d9 80e220 and dl, 0x20
00f799dc 4132d0 xor dl, r8b
00f799df 8897b0010000 mov byte ptr [rdi + 0x1b0], dl
00f799e5 488b4330 mov rax, qword ptr [rbx + 0x30]
00f799e9 0fb6889f000000 movzx ecx, byte ptr [rax + 0x9f]
00f799f0 c0e904 shr cl, 4
00f799f3 32ca xor cl, dl
00f799f5 80e104 and cl, 4
00f799f8 32ca xor cl, dl
00f799fa 888fb0010000 mov byte ptr [rdi + 0x1b0], cl
00f79a00 4c8b742450 mov r14, qword ptr [rsp + 0x50]
00f79a05 418bc7 mov eax, r15d
00f79a08 488b742448 mov rsi, qword ptr [rsp + 0x48]
00f79a0d 4c8b7c2420 mov r15, qword ptr [rsp + 0x20]
00f79a12 4883c428 add rsp, 0x28
00f79a16 5f pop rdi
00f79a17 5b pop rbx
00f79a18 c3 ret 