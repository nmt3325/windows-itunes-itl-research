01028a60 488bc4 mov rax, rsp
01028a63 48895820 mov qword ptr [rax + 0x20], rbx
01028a67 55 push rbp
01028a68 56 push rsi
01028a69 57 push rdi
01028a6a 4154 push r12
01028a6c 4155 push r13
01028a6e 4156 push r14
01028a70 4157 push r15
01028a72 488da8b8faffff lea rbp, [rax - 0x548]
01028a79 4881ec10060000 sub rsp, 0x610
01028a80 0f2970b8 movaps xmmword ptr [rax - 0x48], xmm6
01028a84 0f2978a8 movaps xmmword ptr [rax - 0x58], xmm7
01028a88 488b05b1c5fa00 mov rax, qword ptr [rip + 0xfac5b1]
01028a8f 4833c4 xor rax, rsp
01028a92 488985e0040000 mov qword ptr [rbp + 0x4e0], rax
01028a99 44894520 mov dword ptr [rbp + 0x20], r8d
01028a9d 488bda mov rbx, rdx
01028aa0 4889542460 mov qword ptr [rsp + 0x60], rdx
01028aa5 4c8be9 mov r13, rcx
01028aa8 48894d88 mov qword ptr [rbp - 0x78], rcx
01028aac 4533c9 xor r9d, r9d
01028aaf 488b057ae40701 mov rax, qword ptr [rip + 0x107e47a]
01028ab6 4885c0 test rax, rax
01028ab9 7408 je 0x141028ac3
01028abb 480536020000 add rax, 0x236
01028ac1 eb07 jmp 0x141028aca
01028ac3 488d05769f0801 lea rax, [rip + 0x1089f76]
01028aca 48894580 mov qword ptr [rbp - 0x80], rax
01028ace c644243701 mov byte ptr [rsp + 0x37], 1
01028ad3 44884dc0 mov byte ptr [rbp - 0x40], r9b
01028ad7 44894c243c mov dword ptr [rsp + 0x3c], r9d
01028adc 4c894c2450 mov qword ptr [rsp + 0x50], r9
01028ae1 4c894df0 mov qword ptr [rbp - 0x10], r9
01028ae5 4c894c2448 mov qword ptr [rsp + 0x48], r9
01028aea 4d8bf9 mov r15, r9
01028aed 4c894c2478 mov qword ptr [rsp + 0x78], r9
01028af2 44884c2435 mov byte ptr [rsp + 0x35], r9b
01028af7 4532f6 xor r14b, r14b
01028afa 4488742434 mov byte ptr [rsp + 0x34], r14b
01028aff 44884c2431 mov byte ptr [rsp + 0x31], r9b
01028b04 44884c2441 mov byte ptr [rsp + 0x41], r9b
01028b09 44884c2472 mov byte ptr [rsp + 0x72], r9b
01028b0e 44884c2432 mov byte ptr [rsp + 0x32], r9b
01028b13 0f57c0 xorps xmm0, xmm0
01028b16 660f7f45d0 movdqa xmmword ptr [rbp - 0x30], xmm0
01028b1b 660f7f45b0 movdqa xmmword ptr [rbp - 0x50], xmm0
01028b20 4488742470 mov byte ptr [rsp + 0x70], r14b
01028b25 4488742442 mov byte ptr [rsp + 0x42], r14b
01028b2a 448875a0 mov byte ptr [rbp - 0x60], r14b
01028b2e 448875e8 mov byte ptr [rbp - 0x18], r14b
01028b32 4488742433 mov byte ptr [rsp + 0x33], r14b
01028b37 4032ff xor dil, dil
01028b3a 897d9c mov dword ptr [rbp - 0x64], edi
01028b3d 40887c2443 mov byte ptr [rsp + 0x43], dil
01028b42 4d85ed test r13, r13
01028b45 0f8434290000 je 0x14102b47f
01028b4b 813974736c70 cmp dword ptr [rcx], 0x706c7374
01028b51 0f8528290000 jne 0x14102b47f
01028b57 4885db test rbx, rbx
01028b5a 0f841f290000 je 0x14102b47f
01028b60 410fb6d0 movzx edx, r8b
01028b64 80e201 and dl, 1
01028b67 418bf0 mov esi, r8d
01028b6a 83e602 and esi, 2
01028b6d 897598 mov dword ptr [rbp - 0x68], esi
01028b70 0f95442436 setne byte ptr [rsp + 0x36]
01028b75 418bc0 mov eax, r8d
01028b78 83e006 and eax, 6
01028b7b 3c06 cmp al, 6
01028b7d 0f94c0 sete al
01028b80 89442438 mov dword ptr [rsp + 0x38], eax
01028b84 458be0 mov r12d, r8d
01028b87 41c1ec03 shr r12d, 3
01028b8b 4180e401 and r12b, 1
01028b8f 448965ec mov dword ptr [rbp - 0x14], r12d
01028b93 418bc0 mov eax, r8d
01028b96 83e018 and eax, 0x18
01028b99 3c18 cmp al, 0x18
01028b9b 0f94442440 sete byte ptr [rsp + 0x40]
01028ba0 4d8be5 mov r12, r13
01028ba3 4c896d90 mov qword ptr [rbp - 0x70], r13
01028ba7 0fb681d8010000 movzx eax, byte ptr [rcx + 0x1d8]
01028bae 2408 and al, 8
01028bb0 7420 je 0x141028bd2
01028bb2 488b4908 mov rcx, qword ptr [rcx + 8]
01028bb6 f6811001000001 test byte ptr [rcx + 0x110], 1
01028bbd 750c jne 0x141028bcb
01028bbf 81b98400000069506f64 cmp dword ptr [rcx + 0x84], 0x646f5069
01028bc9 7507 jne 0x141028bd2
01028bcb c644243001 mov byte ptr [rsp + 0x30], 1
01028bd0 eb05 jmp 0x141028bd7
01028bd2 c644243000 mov byte ptr [rsp + 0x30], 0
01028bd7 41f685d901000020 test byte ptr [r13 + 0x1d9], 0x20
01028bdf 0fb6ca movzx ecx, dl
01028be2 ba01000000 mov edx, 1
01028be7 0f45ca cmovne ecx, edx
01028bea 894c2444 mov dword ptr [rsp + 0x44], ecx
01028bee 6641837d1007 cmp word ptr [r13 + 0x10], 7
01028bf4 7507 jne 0x141028bfd
01028bf6 8855ec mov byte ptr [rbp - 0x14], dl
01028bf9 88542440 mov byte ptr [rsp + 0x40], dl
01028bfd 84c9 test cl, cl
01028bff 0f8483000000 je 0x141028c88
01028c05 84c0 test al, al
01028c07 740a je 0x141028c13
01028c09 c644244400 mov byte ptr [rsp + 0x44], 0
01028c0e e997000000 jmp 0x141028caa
01028c13 33c0 xor eax, eax
01028c15 0f114578 movups xmmword ptr [rbp + 0x78], xmm0
01028c19 0f118588000000 movups xmmword ptr [rbp + 0x88], xmm0
01028c20 66898598000000 mov word ptr [rbp + 0x98], ax
01028c27 f30f7f4558 movdqu xmmword ptr [rbp + 0x58], xmm0
01028c2c 4c894d68 mov qword ptr [rbp + 0x68], r9
01028c30 488d4578 lea rax, [rbp + 0x78]
01028c34 48894550 mov qword ptr [rbp + 0x50], rax
01028c38 4c8d4550 lea r8, [rbp + 0x50]
01028c3c ba6d707067 mov edx, 0x6770706d
01028c41 498bcd mov rcx, r13
01028c44 e837b9ecff call 0x140ef4580
01028c49 f6859900000002 test byte ptr [rbp + 0x99], 2
01028c50 0f8429280000 je 0x14102b47f
01028c56 498b4d08 mov rcx, qword ptr [r13 + 8]
01028c5a 4885c9 test rcx, rcx
01028c5d 741d je 0x141028c7c
01028c5f 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
01028c69 7511 jne 0x141028c7c
01028c6b e82034ebff call 0x140edc090
01028c70 4c8be0 mov r12, rax
01028c73 48894590 mov qword ptr [rbp - 0x70], rax
01028c77 4533c9 xor r9d, r9d
01028c7a eb2e jmp 0x141028caa
01028c7c 4533c9 xor r9d, r9d
01028c7f 458be1 mov r12d, r9d
01028c82 4c894d90 mov qword ptr [rbp - 0x70], r9
01028c86 eb22 jmp 0x141028caa
01028c88 84c0 test al, al
01028c8a 751e jne 0x141028caa
01028c8c 498b4508 mov rax, qword ptr [r13 + 8]
01028c90 8b8884000000 mov ecx, dword ptr [rax + 0x84]
01028c96 81f96c696220 cmp ecx, 0x2062696c
01028c9c 7408 je 0x141028ca6
01028c9e 81f969506f64 cmp ecx, 0x646f5069
01028ca4 7504 jne 0x141028caa
01028ca6 88542472 mov byte ptr [rsp + 0x72], dl
01028caa 0f57c0 xorps xmm0, xmm0
01028cad 33c0 xor eax, eax
01028caf 0f114578 movups xmmword ptr [rbp + 0x78], xmm0
01028cb3 0f118588000000 movups xmmword ptr [rbp + 0x88], xmm0
01028cba 66898598000000 mov word ptr [rbp + 0x98], ax
01028cc1 4d85e4 test r12, r12
01028cc4 742c je 0x141028cf2
01028cc6 41813c2474736c70 cmp dword ptr [r12], 0x706c7374
01028cce 7522 jne 0x141028cf2
01028cd0 f30f7f4558 movdqu xmmword ptr [rbp + 0x58], xmm0
01028cd5 4c894d68 mov qword ptr [rbp + 0x68], r9
01028cd9 488d4578 lea rax, [rbp + 0x78]
01028cdd 48894550 mov qword ptr [rbp + 0x50], rax
01028ce1 4c8d4550 lea r8, [rbp + 0x50]
01028ce5 ba6d707067 mov edx, 0x6770706d
01028cea 498bcc mov rcx, r12
01028ced e88eb8ecff call 0x140ef4580
01028cf2 f6859800000080 test byte ptr [rbp + 0x98], 0x80
01028cf9 0f8480270000 je 0x14102b47f
01028cff 41f68424d801000008 test byte ptr [r12 + 0x1d8], 8
01028d08 740e je 0x141028d18
01028d0a 498b4c2408 mov rcx, qword ptr [r12 + 8]
01028d0f e81c24f9ff call 0x140fbb130
01028d14 84c0 test al, al
01028d16 751a jne 0x141028d32
01028d18 498bcc mov rcx, r12
01028d1b e8b0df7eff call 0x140816cd0
01028d20 84c0 test al, al
01028d22 7413 je 0x141028d37
01028d24 c644244201 mov byte ptr [rsp + 0x42], 1
01028d29 c645ec01 mov byte ptr [rbp - 0x14], 1
01028d2d c644244001 mov byte ptr [rsp + 0x40], 1
01028d32 c644243201 mov byte ptr [rsp + 0x32], 1
01028d37 33d2 xor edx, edx
01028d39 488d4df0 lea rcx, [rbp - 0x10]
01028d3d e85e382bff call 0x1402dc5a0
01028d42 85c0 test eax, eax
01028d44 7408 je 0x141028d4e
01028d46 4032f6 xor sil, sil
01028d49 e9a0250000 jmp 0x14102b2ee
01028d4e 33d2 xor edx, edx
01028d50 488d4c2450 lea rcx, [rsp + 0x50]
01028d55 e846382bff call 0x1402dc5a0
01028d5a 85c0 test eax, eax
01028d5c 7408 je 0x141028d66
01028d5e 4032f6 xor sil, sil
01028d61 e988250000 jmp 0x14102b2ee
01028d66 33d2 xor edx, edx
01028d68 488d4c2448 lea rcx, [rsp + 0x48]
01028d6d e82e382bff call 0x1402dc5a0
01028d72 85c0 test eax, eax
01028d74 7408 je 0x141028d7e
01028d76 4032f6 xor sil, sil
01028d79 e970250000 jmp 0x14102b2ee
01028d7e 33d2 xor edx, edx
01028d80 488d4c2478 lea rcx, [rsp + 0x78]
01028d85 e816382bff call 0x1402dc5a0
01028d8a 85c0 test eax, eax
01028d8c 7408 je 0x141028d96
01028d8e 4032f6 xor sil, sil
01028d91 e953250000 jmp 0x14102b2e9
01028d96 49baabaaaaaaaaaaaaaa movabs r10, 0xaaaaaaaaaaaaaaab
01028da0 813b54534c4f cmp dword ptr [rbx], 0x4f4c5354
01028da6 7518 jne 0x141028dc0
01028da8 837b0400 cmp dword ptr [rbx + 4], 0
01028dac 7412 je 0x141028dc0
01028dae 4c8b6b10 mov r13, qword ptr [rbx + 0x10]
01028db2 4c2b6b08 sub r13, qword ptr [rbx + 8]
01028db6 49c1fd04 sar r13, 4
01028dba 4d0fafea imul r13, r10
01028dbe eb03 jmp 0x141028dc3
01028dc0 4533ed xor r13d, r13d
01028dc3 4533e4 xor r12d, r12d
01028dc6 4585ed test r13d, r13d
01028dc9 0f84b7040000 je 0x141029286
01028dcf 33ff xor edi, edi
01028dd1 48897de0 mov qword ptr [rbp - 0x20], rdi
01028dd5 41b8bfff0000 mov r8d, 0xffbf
01028ddb 0f1f440000 nop dword ptr [rax + rax]
01028de0 813b54534c4f cmp dword ptr [rbx], 0x4f4c5354
01028de6 0f8576040000 jne 0x141029262
01028dec 837b0400 cmp dword ptr [rbx + 4], 0
01028df0 0f846c040000 je 0x141029262
01028df6 488b5308 mov rdx, qword ptr [rbx + 8]
01028dfa 488b4b10 mov rcx, qword ptr [rbx + 0x10]
01028dfe 482bca sub rcx, rdx
01028e01 48c1f904 sar rcx, 4
01028e05 490fafca imul rcx, r10
01028e09 418bc4 mov eax, r12d
01028e0c 483bc1 cmp rax, rcx
01028e0f 0f834d040000 jae 0x141029262
01028e15 488d047f lea rax, [rdi + rdi*2]
01028e19 4803c0 add rax, rax
01028e1c 0f1004c2 movups xmm0, xmmword ptr [rdx + rax*8]
01028e20 0f114550 movups xmmword ptr [rbp + 0x50], xmm0
01028e24 0f104cc210 movups xmm1, xmmword ptr [rdx + rax*8 + 0x10]
01028e29 0f114d60 movups xmmword ptr [rbp + 0x60], xmm1
01028e2d 8b44c220 mov eax, dword ptr [rdx + rax*8 + 0x20]
01028e31 894570 mov dword ptr [rbp + 0x70], eax
01028e34 488d4d50 lea rcx, [rbp + 0x50]
01028e38 e8d3562bff call 0x1402de510
01028e3d 83f804 cmp eax, 4
01028e40 7547 jne 0x141028e89
01028e42 488b4588 mov rax, qword ptr [rbp - 0x78]
01028e46 0fb74010 movzx eax, word ptr [rax + 0x10]
01028e4a 6683f80a cmp ax, 0xa
01028e4e 7417 je 0x141028e67
01028e50 6683f80b cmp ax, 0xb
01028e54 7411 je 0x141028e67
01028e56 6683e803 sub ax, 3
01028e5a 664185c0 test r8w, ax
01028e5e 750c jne 0x141028e6c
01028e60 c644243401 mov byte ptr [rsp + 0x34], 1
01028e65 eb05 jmp 0x141028e6c
01028e67 c644243501 mov byte ptr [rsp + 0x35], 1
01028e6c 4533c9 xor r9d, r9d
01028e6f 4533c0 xor r8d, r8d
01028e72 488d5550 lea rdx, [rbp + 0x50]
01028e76 488b4df0 mov rcx, qword ptr [rbp - 0x10]
01028e7a e841422bff call 0x1402dd0c0
01028e7f c644247001 mov byte ptr [rsp + 0x70], 1
01028e84 e9c9030000 jmp 0x141029252
01028e89 8b5554 mov edx, dword ptr [rbp + 0x54]
01028e8c 488b4590 mov rax, qword ptr [rbp - 0x70]
01028e90 488b4808 mov rcx, qword ptr [rax + 8]
01028e94 e847eee8ff call 0x140eb7ce0
01028e99 4c8bf0 mov r14, rax
01028e9c 4885c0 test rax, rax
01028e9f 0f84ad030000 je 0x141029252
01028ea5 4883781000 cmp qword ptr [rax + 0x10], 0
01028eaa 7504 jne 0x141028eb0
01028eac 33f6 xor esi, esi
01028eae eb31 jmp 0x141028ee1
01028eb0 488b7058 mov rsi, qword ptr [rax + 0x58]
01028eb4 4885f6 test rsi, rsi
01028eb7 7428 je 0x141028ee1
01028eb9 0f1f8000000000 nop dword ptr [rax]
01028ec0 488b4608 mov rax, qword ptr [rsi + 8]
01028ec4 4885c0 test rax, rax
01028ec7 7410 je 0x141028ed9
01028ec9 4883781000 cmp qword ptr [rax + 0x10], 0
01028ece 7409 je 0x141028ed9
01028ed0 817e3444524853 cmp dword ptr [rsi + 0x34], 0x53485244
01028ed7 7508 jne 0x141028ee1
01028ed9 488b36 mov rsi, qword ptr [rsi]
01028edc 4885f6 test rsi, rsi
01028edf 75df jne 0x141028ec0
01028ee1 4532ff xor r15b, r15b
01028ee4 41f6869f00000040 test byte ptr [r14 + 0x9f], 0x40
01028eec 0f847d000000 je 0x141028f6f
01028ef2 488d4d50 lea rcx, [rbp + 0x50]
01028ef6 e8152fedff call 0x140efbe10
01028efb 488bf8 mov rdi, rax
01028efe 4885c0 test rax, rax
01028f01 7468 je 0x141028f6b
01028f03 4883783800 cmp qword ptr [rax + 0x38], 0
01028f08 750a jne 0x141028f14
01028f0a 488b4830 mov rcx, qword ptr [rax + 0x30]
01028f0e 48394160 cmp qword ptr [rcx + 0x60], rax
01028f12 744f je 0x141028f63
01028f14 488b4830 mov rcx, qword ptr [rax + 0x30]
01028f18 e873a5f6ff call 0x140f93490
01028f1d 440fb6c0 movzx r8d, al
01028f21 488b4f30 mov rcx, qword ptr [rdi + 0x30]
01028f25 488b5160 mov rdx, qword ptr [rcx + 0x60]
01028f29 4885d2 test rdx, rdx
01028f2c 7435 je 0x141028f63
01028f2e 6690 nop 
01028f30 483bd7 cmp rdx, rdi
01028f33 7425 je 0x141028f5a
01028f35 488b02 mov rax, qword ptr [rdx]
01028f38 4584c0 test r8b, r8b
01028f3b 7407 je 0x141028f44
01028f3d 668378103f cmp word ptr [rax + 0x10], 0x3f
01028f42 7416 je 0x141028f5a
01028f44 f680d801000008 test byte ptr [rax + 0x1d8], 8
01028f4b 751e jne 0x141028f6b
01028f4d 0fb68028020000 movzx eax, byte ptr [rax + 0x228]
01028f54 2403 and al, 3
01028f56 3c03 cmp al, 3
01028f58 7511 jne 0x141028f6b
01028f5a 488b5238 mov rdx, qword ptr [rdx + 0x38]
01028f5e 4885d2 test rdx, rdx
01028f61 75cd jne 0x141028f30
01028f63 41b701 mov r15b, 1
01028f66 44887c2444 mov byte ptr [rsp + 0x44], r15b
01028f6b 488b7de0 mov rdi, qword ptr [rbp - 0x20]
01028f6f 8b5c243c mov ebx, dword ptr [rsp + 0x3c]
01028f73 8d43ff lea eax, [rbx - 1]
01028f76 85c3 test ebx, eax
01028f78 7537 jne 0x141028fb1
01028f7a 33d2 xor edx, edx
01028f7c 498bce mov rcx, r14
01028f7f e8ec7bf7ff call 0x140fa0b70
01028f84 8bc8 mov ecx, eax
01028f86 e825e5f8ff call 0x140fb74b0
01028f8b 0bc3 or eax, ebx
01028f8d 8bd8 mov ebx, eax
01028f8f 8944243c mov dword ptr [rsp + 0x3c], eax
01028f93 8bc8 mov ecx, eax
01028f95 81e1f0000000 and ecx, 0xf0
01028f9b 7414 je 0x141028fb1
01028f9d 8d41ff lea eax, [rcx - 1]
01028fa0 85c1 test ecx, eax
01028fa2 740d je 0x141028fb1
01028fa4 81e31fffffff and ebx, 0xffffff1f
01028faa 83cb10 or ebx, 0x10
01028fad 895c243c mov dword ptr [rsp + 0x3c], ebx
01028fb1 4885f6 test rsi, rsi
01028fb4 0f84db010000 je 0x141029195
01028fba 4180be9900000000 cmp byte ptr [r14 + 0x99], 0
01028fc2 0f8591010000 jne 0x141029159
01028fc8 0fb6463d movzx eax, byte ptr [rsi + 0x3d]
01028fcc 3c03 cmp al, 3
01028fce 0f8485010000 je 0x141029159
01028fd4 3c0b cmp al, 0xb
01028fd6 770e ja 0x141028fe6
01028fd8 b950080000 mov ecx, 0x850
01028fdd 0fa3c1 bt ecx, eax
01028fe0 0f8273010000 jb 0x141029159
01028fe6 41f6869b00000008 test byte ptr [r14 + 0x9b], 8
01028fee 740e je 0x141028ffe
01028ff0 41f6869a00000008 test byte ptr [r14 + 0x9a], 8
01028ff8 0f855b010000 jne 0x141029159
01028ffe 49837e1000 cmp qword ptr [r14 + 0x10], 0
01029003 7504 jne 0x141029009
01029005 33db xor ebx, ebx
01029007 eb2a jmp 0x141029033
01029009 498b5e58 mov rbx, qword ptr [r14 + 0x58]
0102900d 4885db test rbx, rbx
01029010 7421 je 0x141029033
01029012 488b4308 mov rax, qword ptr [rbx + 8]
01029016 4885c0 test rax, rax
01029019 7410 je 0x14102902b
0102901b 4883781000 cmp qword ptr [rax + 0x10], 0
01029020 7409 je 0x14102902b
01029022 817b3444524853 cmp dword ptr [rbx + 0x34], 0x53485244
01029029 7408 je 0x141029033
0102902b 488b1b mov rbx, qword ptr [rbx]
0102902e 4885db test rbx, rbx
01029031 75df jne 0x141029012
01029033 488b4588 mov rax, qword ptr [rbp - 0x78]
01029037 0fb74010 movzx eax, word ptr [rax + 0x10]
0102903b 6683f80a cmp ax, 0xa
0102903f 741b je 0x14102905c
01029041 6683f80b cmp ax, 0xb
01029045 7415 je 0x14102905c
01029047 6683e803 sub ax, 3
0102904b b9bfff0000 mov ecx, 0xffbf
01029050 6685c1 test cx, ax
01029053 750c jne 0x141029061
01029055 c644244101 mov byte ptr [rsp + 0x41], 1
0102905a eb05 jmp 0x141029061
0102905c c644243101 mov byte ptr [rsp + 0x31], 1
01029061 410fb6869e000000 movzx eax, byte ptr [r14 + 0x9e]
01029069 2430 and al, 0x30
0102906b 3c10 cmp al, 0x10
0102906d 7524 jne 0x141029093
0102906f 33d2 xor edx, edx
01029071 498bce mov rcx, r14
01029074 e8f77af7ff call 0x140fa0b70
01029079 a904002000 test eax, 0x200004
0102907e 448b75e8 mov r14d, dword ptr [rbp - 0x18]
01029082 450fb6f6 movzx r14d, r14b
01029086 b801000000 mov eax, 1
0102908b 440f44f0 cmove r14d, eax
0102908f 448975e8 mov dword ptr [rbp - 0x18], r14d
01029093 807c243200 cmp byte ptr [rsp + 0x32], 0
01029098 7509 jne 0x1410290a3
0102909a 4584ff test r15b, r15b
0102909d 0f84da000000 je 0x14102917d
010290a3 4885db test rbx, rbx
010290a6 0f84d1000000 je 0x14102917d
010290ac 4533c9 xor r9d, r9d
010290af 4533c0 xor r8d, r8d
010290b2 488d5550 lea rdx, [rbp + 0x50]
010290b6 488b4c2450 mov rcx, qword ptr [rsp + 0x50]
010290bb e800402bff call 0x1402dd0c0
010290c0 ba02000000 mov edx, 2
010290c5 488bcb mov rcx, rbx
010290c8 e8130bf8ff call 0x140fa9be0
010290cd 84c0 test al, al
010290cf 7412 je 0x1410290e3
010290d1 488b4320 mov rax, qword ptr [rbx + 0x20]
010290d5 48837808fd cmp qword ptr [rax + 8], -3
010290da 7407 je 0x1410290e3
010290dc c644243301 mov byte ptr [rsp + 0x33], 1
010290e1 eb20 jmp 0x141029103
010290e3 ba03000000 mov edx, 3
010290e8 488bcb mov rcx, rbx
010290eb e8f00af8ff call 0x140fa9be0
010290f0 8b4d9c mov ecx, dword ptr [rbp - 0x64]
010290f3 0fb6c9 movzx ecx, cl
010290f6 84c0 test al, al
010290f8 b801000000 mov eax, 1
010290fd 0f45c8 cmovne ecx, eax
01029100 894d9c mov dword ptr [rbp - 0x64], ecx
01029103 488b4308 mov rax, qword ptr [rbx + 8]
01029107 4885c0 test rax, rax
0102910a 0f8442010000 je 0x141029252
01029110 4883781000 cmp qword ptr [rax + 0x10], 0
01029115 0f8437010000 je 0x141029252
0102911b f6434240 test byte ptr [rbx + 0x42], 0x40
0102911f 0f842d010000 je 0x141029252
01029125 488b4608 mov rax, qword ptr [rsi + 8]
01029129 4885c0 test rax, rax
0102912c 7421 je 0x14102914f
0102912e 4883781000 cmp qword ptr [rax + 0x10], 0
01029133 741a je 0x14102914f
01029135 488b4610 mov rax, qword ptr [rsi + 0x10]
01029139 4883780800 cmp qword ptr [rax + 8], 0
0102913e 0f850e010000 jne 0x141029252
01029144 4883782000 cmp qword ptr [rax + 0x20], 0
01029149 0f8503010000 jne 0x141029252
0102914f c644244301 mov byte ptr [rsp + 0x43], 1
01029154 e9f9000000 jmp 0x141029252
01029159 488b4588 mov rax, qword ptr [rbp - 0x78]
0102915d 668378100a cmp word ptr [rax + 0x10], 0xa
01029162 0f85ea000000 jne 0x141029252
01029168 8b45a0 mov eax, dword ptr [rbp - 0x60]
0102916b 0fb6c0 movzx eax, al
0102916e 807e3d07 cmp byte ptr [rsi + 0x3d], 7
01029172 b901000000 mov ecx, 1
01029177 0f44c1 cmove eax, ecx
0102917a 8945a0 mov dword ptr [rbp - 0x60], eax
0102917d 4533c9 xor r9d, r9d
01029180 4533c0 xor r8d, r8d
01029183 488d5550 lea rdx, [rbp + 0x50]
01029187 488b4df0 mov rcx, qword ptr [rbp - 0x10]
0102918b e8303f2bff call 0x1402dd0c0
01029190 e9bd000000 jmp 0x141029252
01029195 f6859900000001 test byte ptr [rbp + 0x99], 1
0102919c 0f85b0000000 jne 0x141029252
010291a2 41f6869b00000008 test byte ptr [r14 + 0x9b], 8
010291aa 740e je 0x1410291ba
010291ac 41f6869a00000008 test byte ptr [r14 + 0x9a], 8
010291b4 0f8598000000 jne 0x141029252
010291ba 807c243200 cmp byte ptr [rsp + 0x32], 0
010291bf 7505 jne 0x1410291c6
010291c1 4584ff test r15b, r15b
010291c4 74b7 je 0x14102917d
010291c6 4533c9 xor r9d, r9d
010291c9 4533c0 xor r8d, r8d
010291cc 488d5550 lea rdx, [rbp + 0x50]
010291d0 488b4c2448 mov rcx, qword ptr [rsp + 0x48]
010291d5 e8e63e2bff call 0x1402dd0c0
010291da 49837e1000 cmp qword ptr [r14 + 0x10], 0
010291df 7504 jne 0x1410291e5
010291e1 33db xor ebx, ebx
010291e3 eb2c jmp 0x141029211
010291e5 498b5e58 mov rbx, qword ptr [r14 + 0x58]
010291e9 4885db test rbx, rbx
010291ec 7423 je 0x141029211
010291ee 6690 nop 
010291f0 488b4308 mov rax, qword ptr [rbx + 8]
010291f4 4885c0 test rax, rax
010291f7 7410 je 0x141029209
010291f9 4883781000 cmp qword ptr [rax + 0x10], 0
010291fe 7409 je 0x141029209
01029200 817b3444524853 cmp dword ptr [rbx + 0x34], 0x53485244
01029207 7408 je 0x141029211
01029209 488b1b mov rbx, qword ptr [rbx]
0102920c 4885db test rbx, rbx
0102920f 75df jne 0x1410291f0
01029211 ba02000000 mov edx, 2
01029216 488bcb mov rcx, rbx
01029219 e8c209f8ff call 0x140fa9be0
0102921e 84c0 test al, al
01029220 7412 je 0x141029234
01029222 488b4320 mov rax, qword ptr [rbx + 0x20]
01029226 48837808fd cmp qword ptr [rax + 8], -3
0102922b 7407 je 0x141029234
0102922d c644243301 mov byte ptr [rsp + 0x33], 1
01029232 eb1e jmp 0x141029252
01029234 ba03000000 mov edx, 3
01029239 488bcb mov rcx, rbx
0102923c e89f09f8ff call 0x140fa9be0
01029241 0fb64d9c movzx ecx, byte ptr [rbp - 0x64]
01029245 84c0 test al, al
01029247 b801000000 mov eax, 1
0102924c 0f45c8 cmovne ecx, eax
0102924f 884d9c mov byte ptr [rbp - 0x64], cl
01029252 49baabaaaaaaaaaaaaaa movabs r10, 0xaaaaaaaaaaaaaaab
0102925c 41b8bfff0000 mov r8d, 0xffbf
01029262 41ffc4 inc r12d
01029265 48ffc7 inc rdi
01029268 48897de0 mov qword ptr [rbp - 0x20], rdi
0102926c 453be5 cmp r12d, r13d
0102926f 488b5c2460 mov rbx, qword ptr [rsp + 0x60]
01029274 0f8266fbffff jb 0x141028de0
0102927a 8b7598 mov esi, dword ptr [rbp - 0x68]
0102927d 440fb6742434 movzx r14d, byte ptr [rsp + 0x34]
01029283 8b7d9c mov edi, dword ptr [rbp - 0x64]
01029286 448b6c2444 mov r13d, dword ptr [rsp + 0x44]
0102928b 448b7c243c mov r15d, dword ptr [rsp + 0x3c]
01029290 4584ed test r13b, r13b
01029293 742b je 0x1410292c0
01029295 488b4d88 mov rcx, qword ptr [rbp - 0x78]
01029299 f681d901000020 test byte ptr [rcx + 0x1d9], 0x20
010292a0 751e jne 0x1410292c0
010292a2 41f6c708 test r15b, 8
010292a6 7418 je 0x1410292c0
010292a8 448b4520 mov r8d, dword ptr [rbp + 0x20]
010292ac 4183e0fe and r8d, 0xfffffffe
010292b0 488bd3 mov rdx, rbx
010292b3 e8a8f7ffff call 0x141028a60
010292b8 4032f6 xor sil, sil
010292bb e929200000 jmp 0x14102b2e9
010292c0 807c243300 cmp byte ptr [rsp + 0x33], 0
010292c5 750a jne 0x1410292d1
010292c7 4084ff test dil, dil
010292ca 7505 jne 0x1410292d1
010292cc 4532c0 xor r8b, r8b
010292cf eb03 jmp 0x1410292d4
010292d1 41b001 mov r8b, 1
010292d4 4488442432 mov byte ptr [rsp + 0x32], r8b
010292d9 4c8b642448 mov r12, qword ptr [rsp + 0x48]
010292de 4d85e4 test r12, r12
010292e1 7426 je 0x141029309
010292e3 41813c2454534c4f cmp dword ptr [r12], 0x4f4c5354
010292eb 751c jne 0x141029309
010292ed 41837c240400 cmp dword ptr [r12 + 4], 0
010292f3 7414 je 0x141029309
010292f5 498b542410 mov rdx, qword ptr [r12 + 0x10]
010292fa 492b542408 sub rdx, qword ptr [r12 + 8]
010292ff 48c1fa04 sar rdx, 4
01029303 490fafd2 imul rdx, r10
01029307 eb02 jmp 0x14102930b
01029309 33d2 xor edx, edx
0102930b 488b5c2450 mov rbx, qword ptr [rsp + 0x50]
01029310 4885db test rbx, rbx
01029313 7420 je 0x141029335
01029315 813b54534c4f cmp dword ptr [rbx], 0x4f4c5354
0102931b 7518 jne 0x141029335
0102931d 837b0400 cmp dword ptr [rbx + 4], 0
01029321 7412 je 0x141029335
01029323 488b4b10 mov rcx, qword ptr [rbx + 0x10]
01029327 482b4b08 sub rcx, qword ptr [rbx + 8]
0102932b 48c1f904 sar rcx, 4
0102932f 490fafca imul rcx, r10
01029333 eb02 jmp 0x141029337
01029335 33c9 xor ecx, ecx
01029337 4c8b4df0 mov r9, qword ptr [rbp - 0x10]
0102933b 4d85c9 test r9, r9
0102933e 7422 je 0x141029362
01029340 41813954534c4f cmp dword ptr [r9], 0x4f4c5354
01029347 7519 jne 0x141029362
01029349 4183790400 cmp dword ptr [r9 + 4], 0
0102934e 7412 je 0x141029362
01029350 498b4110 mov rax, qword ptr [r9 + 0x10]
01029354 492b4108 sub rax, qword ptr [r9 + 8]
01029358 48c1f804 sar rax, 4
0102935c 490fafc2 imul rax, r10
01029360 eb02 jmp 0x141029364
01029362 33c0 xor eax, eax
01029364 8d3c01 lea edi, [rcx + rax]
01029367 03fa add edi, edx
01029369 897de0 mov dword ptr [rbp - 0x20], edi
0102936c 750d jne 0x14102937b
0102936e 4032f6 xor sil, sil
01029371 4c8b7c2478 mov r15, qword ptr [rsp + 0x78]
01029376 e97d1f0000 jmp 0x14102b2f8
0102937b 8b4c2438 mov ecx, dword ptr [rsp + 0x38]
0102937f 4584c0 test r8b, r8b
01029382 7413 je 0x141029397
01029384 f6452020 test byte ptr [rbp + 0x20], 0x20
01029388 0fb6c9 movzx ecx, cl
0102938b b801000000 mov eax, 1
01029390 0f44c8 cmove ecx, eax
01029393 894c2438 mov dword ptr [rsp + 0x38], ecx
01029397 440fb6642431 movzx r12d, byte ptr [rsp + 0x31]
0102939d 85f6 test esi, esi
0102939f 740c je 0x1410293ad
010293a1 807c243500 cmp byte ptr [rsp + 0x35], 0
010293a6 7569 jne 0x141029411
010293a8 4584e4 test r12b, r12b
010293ab 7569 jne 0x141029416
010293ad 0fb6442436 movzx eax, byte ptr [rsp + 0x36]
010293b2 84c0 test al, al
010293b4 7508 jne 0x1410293be
010293b6 84c9 test cl, cl
010293b8 0f84090c0000 je 0x141029fc7
010293be 488d4d10 lea rcx, [rbp + 0x10]
010293c2 e8b95badff call 0x140afef80
010293c7 90 nop 
010293c8 0f57c0 xorps xmm0, xmm0
010293cb f30f7f4530 movdqu xmmword ptr [rbp + 0x30], xmm0
010293d0 f30f7f45f8 movdqu xmmword ptr [rbp - 8], xmm0
010293d5 807c243800 cmp byte ptr [rsp + 0x38], 0
010293da 7578 jne 0x141029454
010293dc 488d4d50 lea rcx, [rbp + 0x50]
010293e0 e89b5dadff call 0x140aff180
010293e5 488d4df8 lea rcx, [rbp - 8]
010293e9 483bc1 cmp rax, rcx
010293ec 7453 je 0x141029441
010293ee 488b18 mov rbx, qword ptr [rax]
010293f1 48895df8 mov qword ptr [rbp - 8], rbx
010293f5 488b7008 mov rsi, qword ptr [rax + 8]
010293f9 48897500 mov qword ptr [rbp], rsi
010293fd 33c9 xor ecx, ecx
010293ff 488908 mov qword ptr [rax], rcx
01029402 48894808 mov qword ptr [rax + 8], rcx
01029406 488d4d50 lea rcx, [rbp + 0x50]
0102940a e8d1d5aaff call 0x140ad69e0
0102940f eb4b jmp 0x14102945c
01029411 4584e4 test r12b, r12b
01029414 7414 je 0x14102942a
01029416 488b4580 mov rax, qword ptr [rbp - 0x80]
0102941a 80b8f630000000 cmp byte ptr [rax + 0x30f6], 0
01029421 0f94c0 sete al
01029424 88442436 mov byte ptr [rsp + 0x36], al
01029428 eb88 jmp 0x1410293b2
0102942a 488b4580 mov rax, qword ptr [rbp - 0x80]
0102942e 80b8f530000000 cmp byte ptr [rax + 0x30f5], 0
01029435 0f94c0 sete al
01029438 88442436 mov byte ptr [rsp + 0x36], al
0102943c e971ffffff jmp 0x1410293b2
01029441 488b7500 mov rsi, qword ptr [rbp]
01029445 488b5df8 mov rbx, qword ptr [rbp - 8]
01029449 488d4d50 lea rcx, [rbp + 0x50]
0102944d e88ed5aaff call 0x140ad69e0
01029452 eb08 jmp 0x14102945c
01029454 488b7500 mov rsi, qword ptr [rbp]
01029458 488b5df8 mov rbx, qword ptr [rbp - 8]
0102945c b930000000 mov ecx, 0x30
01029461 ff1541258c00 call qword ptr [rip + 0x8c2541]
01029467 4585ff test r15d, r15d
0102946a b801000000 mov eax, 1
0102946f 440f44f8 cmove r15d, eax
01029473 44897c243c mov dword ptr [rsp + 0x3c], r15d
01029478 0fb6542441 movzx edx, byte ptr [rsp + 0x41]
0102947d 4584f6 test r14b, r14b
01029480 7541 jne 0x1410294c3
01029482 84d2 test dl, dl
01029484 753d jne 0x1410294c3
01029486 0fb6442435 movzx eax, byte ptr [rsp + 0x35]
0102948b 84c0 test al, al
0102948d 7509 jne 0x141029498
0102948f 4584e4 test r12b, r12b
01029492 0f840a030000 je 0x1410297a2
01029498 b930003023 mov ecx, 0x23300030
0102949d bf31003023 mov edi, 0x23300031
010294a2 41bd2e003023 mov r13d, 0x2330002e
010294a8 41bc2c003023 mov r12d, 0x2330002c
010294ae 41bf2d003023 mov r15d, 0x2330002d
010294b4 c745982a003023 mov dword ptr [rbp - 0x68], 0x2330002a
010294bb 41be2b003023 mov r14d, 0x2330002b
010294c1 eb25 jmp 0x1410294e8
010294c3 b938003023 mov ecx, 0x23300038
010294c8 33ff xor edi, edi
010294ca 41bd36003023 mov r13d, 0x23300036
010294d0 41bc34003023 mov r12d, 0x23300034
010294d6 4533ff xor r15d, r15d
010294d9 c7459832003023 mov dword ptr [rbp - 0x68], 0x23300032
010294e0 4533f6 xor r14d, r14d
010294e3 0fb6442435 movzx eax, byte ptr [rsp + 0x35]
010294e8 84c0 test al, al
010294ea 0f84a2000000 je 0x141029592
010294f0 488b4590 mov rax, qword ptr [rbp - 0x70]
010294f4 488b4008 mov rax, qword ptr [rax + 8]
010294f8 81b88400000069506f64 cmp dword ptr [rax + 0x84], 0x646f5069
01029502 0f85d6070000 jne 0x141029cde
01029508 8b88e8200000 mov ecx, dword ptr [rax + 0x20e8]
0102950e 0fb65c2431 movzx ebx, byte ptr [rsp + 0x31]
01029513 84db test bl, bl
01029515 7463 je 0x14102957a
01029517 ba8002cc10 mov edx, 0x10cc0280
0102951c e84f062200 call 0x141249b70
01029521 488bd0 mov rdx, rax
01029524 488d4dd0 lea rcx, [rbp - 0x30]
01029528 e893d1aaff call 0x140ad66c0
0102952d b929003023 mov ecx, 0x23300029
01029532 e89954adff call 0x140afe9d0
01029537 488bd0 mov rdx, rax
0102953a 488d4c2460 lea rcx, [rsp + 0x60]
0102953f e89ccdaaff call 0x140ad62e0
01029544 0f28442460 movaps xmm0, xmmword ptr [rsp + 0x60]
01029549 660f7f45b0 movdqa xmmword ptr [rbp - 0x50], xmm0
0102954e 0f57c9 xorps xmm1, xmm1
01029551 660f7f4c2460 movdqa xmmword ptr [rsp + 0x60], xmm1
01029557 488d4c2460 lea rcx, [rsp + 0x60]
0102955c e87fd4aaff call 0x140ad69e0
01029561 448b7c243c mov r15d, dword ptr [rsp + 0x3c]
01029566 448b742444 mov r14d, dword ptr [rsp + 0x44]
0102956b 440fb6642430 movzx r12d, byte ptr [rsp + 0x30]
01029571 4c8b6d88 mov r13, qword ptr [rbp - 0x78]
01029575 e985030000 jmp 0x1410298ff
0102957a ba7f02cc10 mov edx, 0x10cc027f
0102957f e8ec052200 call 0x141249b70
01029584 488bd0 mov rdx, rax
01029587 488d4dd0 lea rcx, [rbp - 0x30]
0102958b e830d1aaff call 0x140ad66c0
01029590 ebcf jmp 0x141029561
01029592 807c243400 cmp byte ptr [rsp + 0x34], 0
01029597 0f8541070000 jne 0x141029cde
0102959d 807c243100 cmp byte ptr [rsp + 0x31], 0
010295a2 7508 jne 0x1410295ac
010295a4 84d2 test dl, dl
010295a6 0f84ee010000 je 0x14102979a
010295ac 488b4d90 mov rcx, qword ptr [rbp - 0x70]
010295b0 488b4108 mov rax, qword ptr [rcx + 8]
010295b4 81b88400000069506f64 cmp dword ptr [rax + 0x84], 0x646f5069
010295be 0f84cc010000 je 0x141029790
010295c4 8b7de0 mov edi, dword ptr [rbp - 0x20]
010295c7 83ff01 cmp edi, 1
010295ca 0f86e9000000 jbe 0x1410296b9
010295d0 448bc7 mov r8d, edi
010295d3 488d157e8aa800 lea rdx, [rip + 0xa88a7e]
010295da 488d4d40 lea rcx, [rbp + 0x40]
010295de e8ed0fabff call 0x140ada5d0
010295e3 90 nop 
010295e4 418bcc mov ecx, r12d
010295e7 e8e453adff call 0x140afe9d0
010295ec 488bd0 mov rdx, rax
010295ef 488d4c2460 lea rcx, [rsp + 0x60]
010295f4 e8e7ccaaff call 0x140ad62e0
010295f9 90 nop 
010295fa 4c8d4540 lea r8, [rbp + 0x40]
010295fe 488d542460 lea rdx, [rsp + 0x60]
01029603 488d4d50 lea rcx, [rbp + 0x50]
01029607 e80412abff call 0x140ada810
0102960c 488d4dd0 lea rcx, [rbp - 0x30]
01029610 33db xor ebx, ebx
01029612 483bc1 cmp rax, rcx
01029615 7416 je 0x14102962d
01029617 488b08 mov rcx, qword ptr [rax]
0102961a 48894dd0 mov qword ptr [rbp - 0x30], rcx
0102961e 488b4808 mov rcx, qword ptr [rax + 8]
01029622 48894dd8 mov qword ptr [rbp - 0x28], rcx
01029626 488918 mov qword ptr [rax], rbx
01029629 48895808 mov qword ptr [rax + 8], rbx
0102962d 488d4d50 lea rcx, [rbp + 0x50]
01029631 e8aad3aaff call 0x140ad69e0
01029636 90 nop 
01029637 488d4c2460 lea rcx, [rsp + 0x60]
0102963c e89fd3aaff call 0x140ad69e0
01029641 90 nop 
01029642 488d4d40 lea rcx, [rbp + 0x40]
01029646 e895d3aaff call 0x140ad69e0
0102964b 4585ff test r15d, r15d
0102964e 7453 je 0x1410296a3
01029650 418bcf mov ecx, r15d
01029653 e87853adff call 0x140afe9d0
01029658 488bd0 mov rdx, rax
0102965b 488d4c2460 lea rcx, [rsp + 0x60]
01029660 e87bccaaff call 0x140ad62e0
01029665 488b442460 mov rax, qword ptr [rsp + 0x60]
0102966a 488945b0 mov qword ptr [rbp - 0x50], rax
0102966e 488b442468 mov rax, qword ptr [rsp + 0x68]
01029673 488945b8 mov qword ptr [rbp - 0x48], rax
01029677 0f57c0 xorps xmm0, xmm0
0102967a f30f7f442460 movdqu xmmword ptr [rsp + 0x60], xmm0
01029680 488d4c2460 lea rcx, [rsp + 0x60]
01029685 e856d3aaff call 0x140ad69e0
0102968a 448b7c243c mov r15d, dword ptr [rsp + 0x3c]
0102968f 448b742444 mov r14d, dword ptr [rsp + 0x44]
01029694 440fb6642430 movzx r12d, byte ptr [rsp + 0x30]
0102969a 4c8b6d88 mov r13, qword ptr [rbp - 0x78]
0102969e e957020000 jmp 0x1410298fa
010296a3 48895db0 mov qword ptr [rbp - 0x50], rbx
010296a7 48895db8 mov qword ptr [rbp - 0x48], rbx
010296ab 0f57c0 xorps xmm0, xmm0
010296ae f30f7f4550 movdqu xmmword ptr [rbp + 0x50], xmm0
010296b3 488d4d50 lea rcx, [rbp + 0x50]
010296b7 ebcc jmp 0x141029685
010296b9 4533c0 xor r8d, r8d
010296bc 33d2 xor edx, edx
010296be 488b4c2460 mov rcx, qword ptr [rsp + 0x60]
010296c3 e8f8422bff call 0x1402dd9c0
010296c8 488bd0 mov rdx, rax
010296cb 488d4d50 lea rcx, [rbp + 0x50]
010296cf e86c6decff call 0x140ef0440
010296d4 90 nop 
010296d5 8b4d98 mov ecx, dword ptr [rbp - 0x68]
010296d8 e8f352adff call 0x140afe9d0
010296dd 488bd0 mov rdx, rax
010296e0 488d4d40 lea rcx, [rbp + 0x40]
010296e4 e8f7cbaaff call 0x140ad62e0
010296e9 90 nop 
010296ea 4c8d4550 lea r8, [rbp + 0x50]
010296ee 488d5540 lea rdx, [rbp + 0x40]
010296f2 488d4c2460 lea rcx, [rsp + 0x60]
010296f7 e81411abff call 0x140ada810
010296fc 488d4dd0 lea rcx, [rbp - 0x30]
01029700 33db xor ebx, ebx
01029702 483bc1 cmp rax, rcx
01029705 7416 je 0x14102971d
01029707 488b08 mov rcx, qword ptr [rax]
0102970a 48894dd0 mov qword ptr [rbp - 0x30], rcx
0102970e 488b5008 mov rdx, qword ptr [rax + 8]
01029712 488955d8 mov qword ptr [rbp - 0x28], rdx
01029716 488918 mov qword ptr [rax], rbx
01029719 48895808 mov qword ptr [rax + 8], rbx
0102971d 488d4c2460 lea rcx, [rsp + 0x60]
01029722 e8b9d2aaff call 0x140ad69e0
01029727 90 nop 
01029728 488d4d40 lea rcx, [rbp + 0x40]
0102972c e8afd2aaff call 0x140ad69e0
01029731 4585f6 test r14d, r14d
01029734 7437 je 0x14102976d
01029736 418bce mov ecx, r14d
01029739 e89252adff call 0x140afe9d0
0102973e 488bd0 mov rdx, rax
01029741 488d4c2460 lea rcx, [rsp + 0x60]
01029746 e895cbaaff call 0x140ad62e0
0102974b 488b442460 mov rax, qword ptr [rsp + 0x60]
01029750 488945b0 mov qword ptr [rbp - 0x50], rax
01029754 488b442468 mov rax, qword ptr [rsp + 0x68]
01029759 488945b8 mov qword ptr [rbp - 0x48], rax
0102975d 0f57c0 xorps xmm0, xmm0
01029760 f30f7f442460 movdqu xmmword ptr [rsp + 0x60], xmm0
01029766 488d4c2460 lea rcx, [rsp + 0x60]
0102976b eb14 jmp 0x141029781
0102976d 48895db0 mov qword ptr [rbp - 0x50], rbx
01029771 48895db8 mov qword ptr [rbp - 0x48], rbx
01029775 0f57c0 xorps xmm0, xmm0
01029778 f30f7f4540 movdqu xmmword ptr [rbp + 0x40], xmm0
0102977d 488d4d40 lea rcx, [rbp + 0x40]
01029781 e85ad2aaff call 0x140ad69e0
01029786 90 nop 
01029787 488d4d50 lea rcx, [rbp + 0x50]
0102978b e9f5feffff jmp 0x141029685
01029790 8b7de0 mov edi, dword ptr [rbp - 0x20]
01029793 448b7c243c mov r15d, dword ptr [rsp + 0x3c]
01029798 eb0c jmp 0x1410297a6
0102979a 8b7de0 mov edi, dword ptr [rbp - 0x20]
0102979d 448b7c243c mov r15d, dword ptr [rsp + 0x3c]
010297a2 488b4d90 mov rcx, qword ptr [rbp - 0x70]
010297a6 448b742444 mov r14d, dword ptr [rsp + 0x44]
010297ab 440fb6642430 movzx r12d, byte ptr [rsp + 0x30]
010297b1 4584f6 test r14b, r14b
010297b4 755f jne 0x141029815
010297b6 4584e4 test r12b, r12b
010297b9 755a jne 0x141029815
010297bb 4438742442 cmp byte ptr [rsp + 0x42], r14b
010297c0 7553 jne 0x141029815
010297c2 33d2 xor edx, edx
010297c4 83ff01 cmp edi, 1
010297c7 0f95c2 setne dl
010297ca 81c22d00f401 add edx, 0x1f4002d
010297d0 4533c0 xor r8d, r8d
010297d3 418bcf mov ecx, r15d
010297d6 e8a5dcf8ff call 0x140fb7480
010297db 488bd0 mov rdx, rax
010297de 488d4dd0 lea rcx, [rbp - 0x30]
010297e2 e8d9ceaaff call 0x140ad66c0
010297e7 33d2 xor edx, edx
010297e9 83ff01 cmp edi, 1
010297ec 0f95c2 setne dl
010297ef 81c20300f401 add edx, 0x1f40003
010297f5 4533c0 xor r8d, r8d
010297f8 418bcf mov ecx, r15d
010297fb e880dcf8ff call 0x140fb7480
01029800 488bd0 mov rdx, rax
01029803 488d4d10 lea rcx, [rbp + 0x10]
01029807 e8b4ceaaff call 0x140ad66c0
0102980c 4c8b6d88 mov r13, qword ptr [rbp - 0x78]
01029810 e9e5000000 jmp 0x1410298fa
01029815 488b4908 mov rcx, qword ptr [rcx + 8]
01029819 81b98400000069506f64 cmp dword ptr [rcx + 0x84], 0x646f5069
01029823 7556 jne 0x14102987b
01029825 83ff01 cmp edi, 1
01029828 750d jne 0x141029837
0102982a b80300d610 mov eax, 0x10d60003
0102982f 41b80100d610 mov r8d, 0x10d60001
01029835 eb0b jmp 0x141029842
01029837 b80400d610 mov eax, 0x10d60004
0102983c 41b80200d610 mov r8d, 0x10d60002
01029842 807de800 cmp byte ptr [rbp - 0x18], 0
01029846 440f45c0 cmovne r8d, eax
0102984a 418bd7 mov edx, r15d
0102984d 8b89e8200000 mov ecx, dword ptr [rcx + 0x20e8]
01029853 e8b8002200 call 0x141249910
01029858 0fb7c8 movzx ecx, ax
0102985b c1e110 shl ecx, 0x10
0102985e 410fb7c0 movzx eax, r8w
01029862 0bc8 or ecx, eax
01029864 e86751adff call 0x140afe9d0
01029869 488bd0 mov rdx, rax
0102986c 488d4dd0 lea rcx, [rbp - 0x30]
01029870 e84bceaaff call 0x140ad66c0
01029875 4c8b6d88 mov r13, qword ptr [rbp - 0x78]
01029879 eb7f jmp 0x1410298fa
0102987b 4c8b6d88 mov r13, qword ptr [rbp - 0x78]
0102987f 33d2 xor edx, edx
01029881 418bcf mov ecx, r15d
01029884 6641837d1007 cmp word ptr [r13 + 0x10], 7
0102988a 0f85cb000000 jne 0x14102995b
01029890 83ff01 cmp edi, 1
01029893 0f95c2 setne dl
01029896 81c22f00f401 add edx, 0x1f4002f
0102989c 4533c0 xor r8d, r8d
0102989f e8dcdbf8ff call 0x140fb7480
010298a4 488bd0 mov rdx, rax
010298a7 488d4dd0 lea rcx, [rbp - 0x30]
010298ab e810ceaaff call 0x140ad66c0
010298b0 33d2 xor edx, edx
010298b2 83ff01 cmp edi, 1
010298b5 0f95c2 setne dl
010298b8 81c25900f401 add edx, 0x1f40059
010298be 4533c0 xor r8d, r8d
010298c1 418bcf mov ecx, r15d
010298c4 e8b7dbf8ff call 0x140fb7480
010298c9 488bd0 mov rdx, rax
010298cc 488d4db0 lea rcx, [rbp - 0x50]
010298d0 e8ebcdaaff call 0x140ad66c0
010298d5 33d2 xor edx, edx
010298d7 83ff01 cmp edi, 1
010298da 0f95c2 setne dl
010298dd 81c20100f401 add edx, 0x1f40001
010298e3 4533c0 xor r8d, r8d
010298e6 418bcf mov ecx, r15d
010298e9 e892dbf8ff call 0x140fb7480
010298ee 488bd0 mov rdx, rax
010298f1 488d4d10 lea rcx, [rbp + 0x10]
010298f5 e8c6cdaaff call 0x140ad66c0
010298fa 0fb65c2431 movzx ebx, byte ptr [rsp + 0x31]
010298ff 4032f6 xor sil, sil
01029902 8b7c2438 mov edi, dword ptr [rsp + 0x38]
01029906 c644243000 mov byte ptr [rsp + 0x30], 0
0102990b 488d442430 lea rax, [rsp + 0x30]
01029910 4889442428 mov qword ptr [rsp + 0x28], rax
01029915 488d45f8 lea rax, [rbp - 8]
01029919 4889442420 mov qword ptr [rsp + 0x20], rax
0102991e 4c8d4d30 lea r9, [rbp + 0x30]
01029922 4c8d4510 lea r8, [rbp + 0x10]
01029926 488d55b0 lea rdx, [rbp - 0x50]
0102992a 488d4dd0 lea rcx, [rbp - 0x30]
0102992e e83decffff call 0x141028570
01029933 6683f865 cmp ax, 0x65
01029937 0f85a61a0000 jne 0x14102b3e3
0102993d 807c243200 cmp byte ptr [rsp + 0x32], 0
01029942 0f8452050000 je 0x141029e9a
01029948 807c243000 cmp byte ptr [rsp + 0x30], 0
0102994d 0f84d0050000 je 0x141029f23
01029953 40b601 mov sil, 1
01029956 e9c8050000 jmp 0x141029f23
0102995b 83ff01 cmp edi, 1
0102995e 0f95c2 setne dl
01029961 81c20100f401 add edx, 0x1f40001
01029967 4533c0 xor r8d, r8d
0102996a e811dbf8ff call 0x140fb7480
0102996f 488bd0 mov rdx, rax
01029972 488d4d10 lea rcx, [rbp + 0x10]
01029976 e845cdaaff call 0x140ad66c0
0102997b 488b45f0 mov rax, qword ptr [rbp - 0x10]
0102997f 4885c0 test rax, rax
01029982 742a je 0x1410299ae
01029984 813854534c4f cmp dword ptr [rax], 0x4f4c5354
0102998a 7522 jne 0x1410299ae
0102998c 83780400 cmp dword ptr [rax + 4], 0
01029990 741c je 0x1410299ae
01029992 488b4810 mov rcx, qword ptr [rax + 0x10]
01029996 482b4808 sub rcx, qword ptr [rax + 8]
0102999a 48c1f904 sar rcx, 4
0102999e 49b8abaaaaaaaaaaaaaa movabs r8, 0xaaaaaaaaaaaaaaab
010299a8 490fafc8 imul rcx, r8
010299ac eb0c jmp 0x1410299ba
010299ae 33c9 xor ecx, ecx
010299b0 49b8abaaaaaaaaaaaaaa movabs r8, 0xaaaaaaaaaaaaaaab
010299ba 488b542450 mov rdx, qword ptr [rsp + 0x50]
010299bf 4885d2 test rdx, rdx
010299c2 7420 je 0x1410299e4
010299c4 813a54534c4f cmp dword ptr [rdx], 0x4f4c5354
010299ca 7518 jne 0x1410299e4
010299cc 837a0400 cmp dword ptr [rdx + 4], 0
010299d0 7412 je 0x1410299e4
010299d2 488b4210 mov rax, qword ptr [rdx + 0x10]
010299d6 482b4208 sub rax, qword ptr [rdx + 8]
010299da 48c1f804 sar rax, 4
010299de 490fafc0 imul rax, r8
010299e2 eb02 jmp 0x1410299e6
010299e4 33c0 xor eax, eax
010299e6 03c1 add eax, ecx
010299e8 0f850e010000 jne 0x141029afc
010299ee 33d2 xor edx, edx
010299f0 418bcf mov ecx, r15d
010299f3 38542433 cmp byte ptr [rsp + 0x33], dl
010299f7 7430 je 0x141029a29
010299f9 83ff01 cmp edi, 1
010299fc 0f95c2 setne dl
010299ff 81c27800f401 add edx, 0x1f40078
01029a05 4533c0 xor r8d, r8d
01029a08 e873daf8ff call 0x140fb7480
01029a0d 488bd0 mov rdx, rax
01029a10 488d4dd0 lea rcx, [rbp - 0x30]
01029a14 e8a7ccaaff call 0x140ad66c0
01029a19 33d2 xor edx, edx
01029a1b 83ff01 cmp edi, 1
01029a1e 0f95c2 setne dl
01029a21 81c27a00f401 add edx, 0x1f4007a
01029a27 eb59 jmp 0x141029a82
01029a29 83ff01 cmp edi, 1
01029a2c 0f95c2 setne dl
01029a2f 81c27600f401 add edx, 0x1f40076
01029a35 4533c0 xor r8d, r8d
01029a38 e843daf8ff call 0x140fb7480
01029a3d 488bd0 mov rdx, rax
01029a40 488d4dd0 lea rcx, [rbp - 0x30]
01029a44 e877ccaaff call 0x140ad66c0
01029a49 33d2 xor edx, edx
01029a4b 83ff01 cmp edi, 1
01029a4e 0f95c2 setne dl
01029a51 81c20500f401 add edx, 0x1f40005
01029a57 4533c0 xor r8d, r8d
01029a5a 418bcf mov ecx, r15d
01029a5d e81edaf8ff call 0x140fb7480
01029a62 488bd0 mov rdx, rax
01029a65 488d4d10 lea rcx, [rbp + 0x10]
01029a69 e852ccaaff call 0x140ad66c0
01029a6e 807d9c00 cmp byte ptr [rbp - 0x64], 0
01029a72 7425 je 0x141029a99
01029a74 33d2 xor edx, edx
01029a76 83ff01 cmp edi, 1
01029a79 0f95c2 setne dl
01029a7c 81c27c00f401 add edx, 0x1f4007c
01029a82 4533c0 xor r8d, r8d
01029a85 418bcf mov ecx, r15d
01029a88 e8f3d9f8ff call 0x140fb7480
01029a8d 488bd0 mov rdx, rax
01029a90 488d4db0 lea rcx, [rbp - 0x50]
01029a94 e827ccaaff call 0x140ad66c0
01029a99 4885db test rbx, rbx
01029a9c 7426 je 0x141029ac4
01029a9e b8ffffffff mov eax, 0xffffffff
01029aa3 f00fc14308 lock xadd dword ptr [rbx + 8], eax
01029aa8 83f801 cmp eax, 1
01029aab 750f jne 0x141029abc
01029aad c74308003665c4 mov dword ptr [rbx + 8], 0xc4653600
01029ab4 488bcb mov rcx, rbx
01029ab7 e81c237700 call 0x14179bdd8
01029abc 48c745f800000000 mov qword ptr [rbp - 8], 0
01029ac4 4885f6 test rsi, rsi
01029ac7 7426 je 0x141029aef
01029ac9 b8ffffffff mov eax, 0xffffffff
01029ace f00fc14608 lock xadd dword ptr [rsi + 8], eax
01029ad3 83f801 cmp eax, 1
01029ad6 750f jne 0x141029ae7
01029ad8 c74608003665c4 mov dword ptr [rsi + 8], 0xc4653600
01029adf 488bce mov rcx, rsi
01029ae2 e8f1227700 call 0x14179bdd8
01029ae7 48c7450000000000 mov qword ptr [rbp], 0
01029aef 40b601 mov sil, 1
01029af2 0fb65c2431 movzx ebx, byte ptr [rsp + 0x31]
01029af7 e906feffff jmp 0x141029902
01029afc 4885d2 test rdx, rdx
01029aff 7420 je 0x141029b21
01029b01 813a54534c4f cmp dword ptr [rdx], 0x4f4c5354
01029b07 7518 jne 0x141029b21
01029b09 837a0400 cmp dword ptr [rdx + 4], 0
01029b0d 7412 je 0x141029b21
01029b0f 488b4a10 mov rcx, qword ptr [rdx + 0x10]
01029b13 482b4a08 sub rcx, qword ptr [rdx + 8]
01029b17 48c1f904 sar rcx, 4
01029b1b 490fafc8 imul rcx, r8
01029b1f eb02 jmp 0x141029b23
01029b21 33c9 xor ecx, ecx
01029b23 488b542448 mov rdx, qword ptr [rsp + 0x48]
01029b28 4885d2 test rdx, rdx
01029b2b 7420 je 0x141029b4d
01029b2d 813a54534c4f cmp dword ptr [rdx], 0x4f4c5354
01029b33 7518 jne 0x141029b4d
01029b35 837a0400 cmp dword ptr [rdx + 4], 0
01029b39 7412 je 0x141029b4d
01029b3b 488b4210 mov rax, qword ptr [rdx + 0x10]
01029b3f 482b4208 sub rax, qword ptr [rdx + 8]
01029b43 48c1f804 sar rax, 4
01029b47 490fafc0 imul rax, r8
01029b4b eb02 jmp 0x141029b4f
01029b4d 33c0 xor eax, eax
01029b4f 03c1 add eax, ecx
01029b51 418bcf mov ecx, r15d
01029b54 0f843d010000 je 0x141029c97
01029b5a 33d2 xor edx, edx
01029b5c 38542433 cmp byte ptr [rsp + 0x33], dl
01029b60 0f84bd000000 je 0x141029c23
01029b66 83ff01 cmp edi, 1
01029b69 0f95c2 setne dl
01029b6c 81c27800f401 add edx, 0x1f40078
01029b72 4533c0 xor r8d, r8d
01029b75 e806d9f8ff call 0x140fb7480
01029b7a 488bd0 mov rdx, rax
01029b7d 488d4dd0 lea rcx, [rbp - 0x30]
01029b81 e83acbaaff call 0x140ad66c0
01029b86 33d2 xor edx, edx
01029b88 83ff01 cmp edi, 1
01029b8b 0f95c2 setne dl
01029b8e 81c27a00f401 add edx, 0x1f4007a
01029b94 4533c0 xor r8d, r8d
01029b97 418bcf mov ecx, r15d
01029b9a e8e1d8f8ff call 0x140fb7480
01029b9f 488bd0 mov rdx, rax
01029ba2 488d4db0 lea rcx, [rbp - 0x50]
01029ba6 e815cbaaff call 0x140ad66c0
01029bab 4885db test rbx, rbx
01029bae 7426 je 0x141029bd6
01029bb0 b8ffffffff mov eax, 0xffffffff
01029bb5 f00fc14308 lock xadd dword ptr [rbx + 8], eax
01029bba 83f801 cmp eax, 1
01029bbd 750f jne 0x141029bce
01029bbf c74308003665c4 mov dword ptr [rbx + 8], 0xc4653600
01029bc6 488bcb mov rcx, rbx
01029bc9 e80a227700 call 0x14179bdd8
01029bce 48c745f800000000 mov qword ptr [rbp - 8], 0
01029bd6 4885f6 test rsi, rsi
01029bd9 7426 je 0x141029c01
01029bdb b8ffffffff mov eax, 0xffffffff
01029be0 f00fc14608 lock xadd dword ptr [rsi + 8], eax
01029be5 83f801 cmp eax, 1
01029be8 750f jne 0x141029bf9
01029bea c74608003665c4 mov dword ptr [rsi + 8], 0xc4653600
01029bf1 488bce mov rcx, rsi
01029bf4 e8df217700 call 0x14179bdd8
01029bf9 48c7450000000000 mov qword ptr [rbp], 0
01029c01 40b601 mov sil, 1
01029c04 4032ff xor dil, dil
01029c07 897c2438 mov dword ptr [rsp + 0x38], edi
01029c0b 40387c2443 cmp byte ptr [rsp + 0x43], dil
01029c10 0f9445ec sete byte ptr [rbp - 0x14]
01029c14 4088742440 mov byte ptr [rsp + 0x40], sil
01029c19 0fb65c2431 movzx ebx, byte ptr [rsp + 0x31]
01029c1e e9e3fcffff jmp 0x141029906
01029c23 83ff01 cmp edi, 1
01029c26 0f95c2 setne dl
01029c29 81c27000f401 add edx, 0x1f40070
01029c2f 4533c0 xor r8d, r8d
01029c32 e849d8f8ff call 0x140fb7480
01029c37 488bd0 mov rdx, rax
01029c3a 488d4dd0 lea rcx, [rbp - 0x30]
01029c3e e87dcaaaff call 0x140ad66c0
01029c43 33d2 xor edx, edx
01029c45 83ff01 cmp edi, 1
01029c48 0f95c2 setne dl
01029c4b 81c27200f401 add edx, 0x1f40072
01029c51 4533c0 xor r8d, r8d
01029c54 418bcf mov ecx, r15d
01029c57 e824d8f8ff call 0x140fb7480
01029c5c 488bd0 mov rdx, rax
01029c5f 488d4db0 lea rcx, [rbp - 0x50]
01029c63 e858caaaff call 0x140ad66c0
01029c68 807d9c00 cmp byte ptr [rbp - 0x64], 0
01029c6c 0f8488fcffff je 0x1410298fa
01029c72 33d2 xor edx, edx
01029c74 83ff01 cmp edi, 1
01029c77 0f95c2 setne dl
01029c7a 81c27400f401 add edx, 0x1f40074
01029c80 4533c0 xor r8d, r8d
01029c83 418bcf mov ecx, r15d
01029c86 e8f5d7f8ff call 0x140fb7480
01029c8b 488bd0 mov rdx, rax
01029c8e 488d4df8 lea rcx, [rbp - 8]
01029c92 e95efcffff jmp 0x1410298f5
01029c97 33d2 xor edx, edx
01029c99 83ff01 cmp edi, 1
01029c9c 0f95c2 setne dl
01029c9f 81c22f00f401 add edx, 0x1f4002f
01029ca5 4533c0 xor r8d, r8d
01029ca8 e8d3d7f8ff call 0x140fb7480
01029cad 488bd0 mov rdx, rax
01029cb0 488d4dd0 lea rcx, [rbp - 0x30]
01029cb4 e807caaaff call 0x140ad66c0
01029cb9 33d2 xor edx, edx
01029cbb 83ff01 cmp edi, 1
01029cbe 0f95c2 setne dl
01029cc1 81c23100f401 add edx, 0x1f40031
01029cc7 4533c0 xor r8d, r8d
01029cca 418bcf mov ecx, r15d
01029ccd e8aed7f8ff call 0x140fb7480
01029cd2 488bd0 mov rdx, rax
01029cd5 488d4db0 lea rcx, [rbp - 0x50]
01029cd9 e917fcffff jmp 0x1410298f5
01029cde 0fb65c2431 movzx ebx, byte ptr [rsp + 0x31]
01029ce3 84db test bl, bl
01029ce5 0f852d010000 jne 0x141029e18
01029ceb 84d2 test dl, dl
01029ced 0f8525010000 jne 0x141029e18
01029cf3 837de001 cmp dword ptr [rbp - 0x20], 1
01029cf7 0f871b010000 ja 0x141029e18
01029cfd 4533c0 xor r8d, r8d
01029d00 33d2 xor edx, edx
01029d02 488b4c2460 mov rcx, qword ptr [rsp + 0x60]
01029d07 e8b43c2bff call 0x1402dd9c0
01029d0c 488bd0 mov rdx, rax
01029d0f 488d4d40 lea rcx, [rbp + 0x40]
01029d13 e82867ecff call 0x140ef0440
01029d18 90 nop 
01029d19 418bcd mov ecx, r13d
01029d1c e8af4cadff call 0x140afe9d0
01029d21 488bd0 mov rdx, rax
01029d24 488d4d50 lea rcx, [rbp + 0x50]
01029d28 e8b3c5aaff call 0x140ad62e0
01029d2d 90 nop 
01029d2e 4c8d4540 lea r8, [rbp + 0x40]
01029d32 488d5550 lea rdx, [rbp + 0x50]
01029d36 488d4c2460 lea rcx, [rsp + 0x60]
01029d3b e8d00aabff call 0x140ada810
01029d40 488d4dd0 lea rcx, [rbp - 0x30]
01029d44 33f6 xor esi, esi
01029d46 483bc1 cmp rax, rcx
01029d49 7416 je 0x141029d61
01029d4b 488b08 mov rcx, qword ptr [rax]
01029d4e 48894dd0 mov qword ptr [rbp - 0x30], rcx
01029d52 488b5008 mov rdx, qword ptr [rax + 8]
01029d56 488955d8 mov qword ptr [rbp - 0x28], rdx
01029d5a 488930 mov qword ptr [rax], rsi
01029d5d 48897008 mov qword ptr [rax + 8], rsi
01029d61 488d4c2460 lea rcx, [rsp + 0x60]
01029d66 e875ccaaff call 0x140ad69e0
01029d6b 90 nop 
01029d6c 488d4d50 lea rcx, [rbp + 0x50]
01029d70 e86bccaaff call 0x140ad69e0
01029d75 85ff test edi, edi
01029d77 743b je 0x141029db4
01029d79 8bcf mov ecx, edi
01029d7b e8504cadff call 0x140afe9d0
01029d80 488bd0 mov rdx, rax
01029d83 488d4c2460 lea rcx, [rsp + 0x60]
01029d88 e853c5aaff call 0x140ad62e0
01029d8d 488b442460 mov rax, qword ptr [rsp + 0x60]
01029d92 488945b0 mov qword ptr [rbp - 0x50], rax
01029d96 488b442468 mov rax, qword ptr [rsp + 0x68]
01029d9b 488945b8 mov qword ptr [rbp - 0x48], rax
01029d9f 0f57c0 xorps xmm0, xmm0
01029da2 f30f7f442460 movdqu xmmword ptr [rsp + 0x60], xmm0
01029da8 488d4c2460 lea rcx, [rsp + 0x60]
01029dad e82eccaaff call 0x140ad69e0
01029db2 eb5b jmp 0x141029e0f
01029db4 488975b0 mov qword ptr [rbp - 0x50], rsi
01029db8 488975b8 mov qword ptr [rbp - 0x48], rsi
01029dbc 0f57f6 xorps xmm6, xmm6
01029dbf 66480f7ef1 movq rcx, xmm6
01029dc4 4885c9 test rcx, rcx
01029dc7 741b je 0x141029de4
01029dc9 b8ffffffff mov eax, 0xffffffff
01029dce f00fc14108 lock xadd dword ptr [rcx + 8], eax
01029dd3 83f801 cmp eax, 1
01029dd6 750c jne 0x141029de4
01029dd8 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01029ddf e8f41f7700 call 0x14179bdd8
01029de4 660f73de08 psrldq xmm6, 8
01029de9 66480f7ef1 movq rcx, xmm6
01029dee 4885c9 test rcx, rcx
01029df1 741c je 0x141029e0f
01029df3 b8ffffffff mov eax, 0xffffffff
01029df8 f00fc14108 lock xadd dword ptr [rcx + 8], eax
01029dfd 83f801 cmp eax, 1
01029e00 750d jne 0x141029e0f
01029e02 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01029e09 e8ca1f7700 call 0x14179bdd8
01029e0e 90 nop 
01029e0f 488d4d40 lea rcx, [rbp + 0x40]
01029e13 e944f7ffff jmp 0x14102955c
01029e18 e8b34badff call 0x140afe9d0
01029e1d 488bd0 mov rdx, rax
01029e20 488d4c2460 lea rcx, [rsp + 0x60]
01029e25 e8b6c4aaff call 0x140ad62e0
01029e2a 0f28442460 movaps xmm0, xmmword ptr [rsp + 0x60]
01029e2f 660f7f45d0 movdqa xmmword ptr [rbp - 0x30], xmm0
01029e34 0f57c9 xorps xmm1, xmm1
01029e37 660f7f4c2460 movdqa xmmword ptr [rsp + 0x60], xmm1
01029e3d 488d4c2460 lea rcx, [rsp + 0x60]
01029e42 e899cbaaff call 0x140ad69e0
01029e47 85ff test edi, edi
01029e49 7434 je 0x141029e7f
01029e4b 8bcf mov ecx, edi
01029e4d e87e4badff call 0x140afe9d0
01029e52 488bd0 mov rdx, rax
01029e55 488d4c2460 lea rcx, [rsp + 0x60]
01029e5a e881c4aaff call 0x140ad62e0
01029e5f 488b442460 mov rax, qword ptr [rsp + 0x60]
01029e64 488945b0 mov qword ptr [rbp - 0x50], rax
01029e68 488b442468 mov rax, qword ptr [rsp + 0x68]
01029e6d 488945b8 mov qword ptr [rbp - 0x48], rax
01029e71 0f57c0 xorps xmm0, xmm0
01029e74 f30f7f442460 movdqu xmmword ptr [rsp + 0x60], xmm0
01029e7a e9d8f6ffff jmp 0x141029557
01029e7f 33c0 xor eax, eax
01029e81 488945b0 mov qword ptr [rbp - 0x50], rax
01029e85 488945b8 mov qword ptr [rbp - 0x48], rax
01029e89 0f57c0 xorps xmm0, xmm0
01029e8c f30f7f4550 movdqu xmmword ptr [rbp + 0x50], xmm0
01029e91 488d4d50 lea rcx, [rbp + 0x50]
01029e95 e9c2f6ffff jmp 0x14102955c
01029e9a 4084ff test dil, dil
01029e9d 0f8580000000 jne 0x141029f23
01029ea3 6641837d1007 cmp word ptr [r13 + 0x10], 7
01029ea9 7511 jne 0x141029ebc
01029eab 0fb6442430 movzx eax, byte ptr [rsp + 0x30]
01029eb0 488b4d80 mov rcx, qword ptr [rbp - 0x80]
01029eb4 8881a5f20000 mov byte ptr [rcx + 0xf2a5], al
01029eba eb67 jmp 0x141029f23
01029ebc 807c243500 cmp byte ptr [rsp + 0x35], 0
01029ec1 741d je 0x141029ee0
01029ec3 0fb6442430 movzx eax, byte ptr [rsp + 0x30]
01029ec8 488b4d80 mov rcx, qword ptr [rbp - 0x80]
01029ecc 84db test bl, bl
01029ece 7408 je 0x141029ed8
01029ed0 8881f6300000 mov byte ptr [rcx + 0x30f6], al
01029ed6 eb4b jmp 0x141029f23
01029ed8 8881f5300000 mov byte ptr [rcx + 0x30f5], al
01029ede eb43 jmp 0x141029f23
01029ee0 4584f6 test r14b, r14b
01029ee3 7513 jne 0x141029ef8
01029ee5 4584e4 test r12b, r12b
01029ee8 750e jne 0x141029ef8
01029eea 0fb6442430 movzx eax, byte ptr [rsp + 0x30]
01029eef 488b4d80 mov rcx, qword ptr [rbp - 0x80]
01029ef3 884155 mov byte ptr [rcx + 0x55], al
01029ef6 eb2b jmp 0x141029f23
01029ef8 488b4590 mov rax, qword ptr [rbp - 0x70]
01029efc 488b4008 mov rax, qword ptr [rax + 8]
01029f00 488b4d80 mov rcx, qword ptr [rbp - 0x80]
01029f04 81b88400000069506f64 cmp dword ptr [rax + 0x84], 0x646f5069
01029f0e 0fb6442430 movzx eax, byte ptr [rsp + 0x30]
01029f13 7508 jne 0x141029f1d
01029f15 8881df530000 mov byte ptr [rcx + 0x53df], al
01029f1b eb06 jmp 0x141029f23
01029f1d 8881bf090000 mov byte ptr [rcx + 0x9bf], al
01029f23 488b4df8 mov rcx, qword ptr [rbp - 8]
01029f27 bbffffffff mov ebx, 0xffffffff
01029f2c 4885c9 test rcx, rcx
01029f2f 7418 je 0x141029f49
01029f31 8bc3 mov eax, ebx
01029f33 f00fc14108 lock xadd dword ptr [rcx + 8], eax
01029f38 83f801 cmp eax, 1
01029f3b 750c jne 0x141029f49
01029f3d c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01029f44 e88f1e7700 call 0x14179bdd8
01029f49 488b4d00 mov rcx, qword ptr [rbp]
01029f4d 4885c9 test rcx, rcx
01029f50 7419 je 0x141029f6b
01029f52 8bc3 mov eax, ebx
01029f54 f00fc14108 lock xadd dword ptr [rcx + 8], eax
01029f59 83f801 cmp eax, 1
01029f5c 750d jne 0x141029f6b
01029f5e c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01029f65 e86e1e7700 call 0x14179bdd8
01029f6a 90 nop 
01029f6b 488b4d30 mov rcx, qword ptr [rbp + 0x30]
01029f6f 4885c9 test rcx, rcx
01029f72 7418 je 0x141029f8c
01029f74 8bc3 mov eax, ebx
01029f76 f00fc14108 lock xadd dword ptr [rcx + 8], eax
01029f7b 83f801 cmp eax, 1
01029f7e 750c jne 0x141029f8c
01029f80 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01029f87 e84c1e7700 call 0x14179bdd8
01029f8c 488b4d38 mov rcx, qword ptr [rbp + 0x38]
01029f90 4885c9 test rcx, rcx
01029f93 7419 je 0x141029fae
01029f95 8bc3 mov eax, ebx
01029f97 f00fc14108 lock xadd dword ptr [rcx + 8], eax
01029f9c 83f801 cmp eax, 1
01029f9f 750d jne 0x141029fae
01029fa1 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01029fa8 e82b1e7700 call 0x14179bdd8
01029fad 90 nop 
01029fae 488d4d10 lea rcx, [rbp + 0x10]
01029fb2 e829caaaff call 0x140ad69e0
01029fb7 448b6c2444 mov r13d, dword ptr [rsp + 0x44]
01029fbc 8b4c2438 mov ecx, dword ptr [rsp + 0x38]
01029fc0 0fb6442436 movzx eax, byte ptr [rsp + 0x36]
01029fc5 eb03 jmp 0x141029fca
01029fc7 4032f6 xor sil, sil
01029fca 458bf7 mov r14d, r15d
01029fcd 807da000 cmp byte ptr [rbp - 0x60], 0
01029fd1 744c je 0x14102a01f
01029fd3 488b5d80 mov rbx, qword ptr [rbp - 0x80]
01029fd7 84c0 test al, al
01029fd9 7409 je 0x141029fe4
01029fdb 80bbfa56000000 cmp byte ptr [rbx + 0x56fa], 0
01029fe2 7404 je 0x141029fe8
01029fe4 84c9 test cl, cl
01029fe6 7437 je 0x14102a01f
01029fe8 b930000000 mov ecx, 0x30
01029fed ff15b5198c00 call qword ptr [rip + 0x8c19b5]
01029ff3 c644243400 mov byte ptr [rsp + 0x34], 0
01029ff8 4c8d442434 lea r8, [rsp + 0x34]
01029ffd 8b542438 mov edx, dword ptr [rsp + 0x38]
0102a001 488d4dd0 lea rcx, [rbp - 0x30]
0102a005 e8c6e2ffff call 0x1410282d0
0102a00a 6683f865 cmp ax, 0x65
0102a00e 0f857aedffff jne 0x141028d8e
0102a014 0fb6442434 movzx eax, byte ptr [rsp + 0x34]
0102a019 8883fa560000 mov byte ptr [rbx + 0x56fa], al
0102a01f 4c8b6588 mov r12, qword ptr [rbp - 0x78]
0102a023 498b4c2408 mov rcx, qword ptr [r12 + 8]
0102a028 e8039aeaff call 0x140ed3a30
0102a02d 41b801000000 mov r8d, 1
0102a033 488b7df0 mov rdi, qword ptr [rbp - 0x10]
0102a037 488bd7 mov rdx, rdi
0102a03a 498bcc mov rcx, r12
0102a03d e8eed3ecff call 0x140ef7430
0102a042 400fb6c6 movzx eax, sil
0102a046 f6d8 neg al
0102a048 1bdb sbb ebx, ebx
0102a04a 448d4302 lea r8d, [rbx + 2]
0102a04e 4c8b7c2450 mov r15, qword ptr [rsp + 0x50]
0102a053 498bd7 mov rdx, r15
0102a056 498bcc mov rcx, r12
0102a059 e8d2d3ecff call 0x140ef7430
0102a05e 4084f6 test sil, sil
0102a061 7413 je 0x14102a076
0102a063 41b801000000 mov r8d, 1
0102a069 488b542448 mov rdx, qword ptr [rsp + 0x48]
0102a06e 498bcc mov rcx, r12
0102a071 e8bad3ecff call 0x140ef7430
0102a076 e8d5a1aaff call 0x140ad4250
0102a07b 0f28f8 movaps xmm7, xmm0
0102a07e 4584ed test r13b, r13b
0102a081 0f84e9000000 je 0x14102a170
0102a087 807c247000 cmp byte ptr [rsp + 0x70], 0
0102a08c 7465 je 0x14102a0f3
0102a08e 48c744246000000000 mov qword ptr [rsp + 0x60], 0
0102a097 488d542460 lea rdx, [rsp + 0x60]
0102a09c 488bcf mov rcx, rdi
0102a09f e8dc412bff call 0x1402de280
0102a0a4 41b801000000 mov r8d, 1
0102a0aa 488b5c2460 mov rbx, qword ptr [rsp + 0x60]
0102a0af 488bd3 mov rdx, rbx
0102a0b2 488b7d90 mov rdi, qword ptr [rbp - 0x70]
0102a0b6 488b4f08 mov rcx, qword ptr [rdi + 8]
0102a0ba e81198eaff call 0x140ed38d0
0102a0bf 4885db test rbx, rbx
0102a0c2 746e je 0x14102a132
0102a0c4 813b54534c4f cmp dword ptr [rbx], 0x4f4c5354
0102a0ca 7566 jne 0x14102a132
0102a0cc 8b4304 mov eax, dword ptr [rbx + 4]
0102a0cf 85c0 test eax, eax
0102a0d1 745f je 0x14102a132
0102a0d3 83e801 sub eax, 1
0102a0d6 894304 mov dword ptr [rbx + 4], eax
0102a0d9 7557 jne 0x14102a132
0102a0db 488d4b08 lea rcx, [rbx + 8]
0102a0df e81c462bff call 0x1402de700
0102a0e4 ba20000000 mov edx, 0x20
0102a0e9 488bcb mov rcx, rbx
0102a0ec e82fc9b9ff call 0x140bc6a20
0102a0f1 eb3f jmp 0x14102a132
0102a0f3 41bd01000000 mov r13d, 1
0102a0f9 458bc5 mov r8d, r13d
0102a0fc 488bd7 mov rdx, rdi
0102a0ff 488b7d90 mov rdi, qword ptr [rbp - 0x70]
0102a103 488b4f08 mov rcx, qword ptr [rdi + 8]
0102a107 e8c497eaff call 0x140ed38d0
0102a10c 448d4302 lea r8d, [rbx + 2]
0102a110 498bd7 mov rdx, r15
0102a113 488b4f08 mov rcx, qword ptr [rdi + 8]
0102a117 e8b497eaff call 0x140ed38d0
0102a11c 4084f6 test sil, sil
0102a11f 7411 je 0x14102a132
0102a121 458bc5 mov r8d, r13d
0102a124 488b542448 mov rdx, qword ptr [rsp + 0x48]
0102a129 488b4f08 mov rcx, qword ptr [rdi + 8]
0102a12d e89e97eaff call 0x140ed38d0
0102a132 488bcf mov rcx, rdi
0102a135 e89657ecff call 0x140eef8d0
0102a13a 488bd8 mov rbx, rax
0102a13d 4885c0 test rax, rax
0102a140 7423 je 0x14102a165
0102a142 488b4b30 mov rcx, qword ptr [rbx + 0x30]
0102a146 8b510c mov edx, dword ptr [rcx + 0xc]
0102a149 85d2 test edx, edx
0102a14b 7408 je 0x14102a155
0102a14d 488bcb mov rcx, rbx
0102a150 e8cbc2ecff call 0x140ef6420
0102a155 488bcb mov rcx, rbx
0102a158 e8f357ecff call 0x140eef950
0102a15d 488bd8 mov rbx, rax
0102a160 4885c0 test rax, rax
0102a163 75dd jne 0x14102a142
0102a165 488b4f08 mov rcx, qword ptr [rdi + 8]
0102a169 e86298eaff call 0x140ed39d0
0102a16e eb04 jmp 0x14102a174
0102a170 488b7d90 mov rdi, qword ptr [rbp - 0x70]
0102a174 f687d801000008 test byte ptr [rdi + 0x1d8], 8
0102a17b 740d je 0x14102a18a
0102a17d 488b4708 mov rax, qword ptr [rdi + 8]
0102a181 f6801001000001 test byte ptr [rax + 0x110], 1
0102a188 7522 jne 0x14102a1ac
0102a18a 66837f100a cmp word ptr [rdi + 0x10], 0xa
0102a18f 741b je 0x14102a1ac
0102a191 807c244200 cmp byte ptr [rsp + 0x42], 0
0102a196 7514 jne 0x14102a1ac
0102a198 4084f6 test sil, sil
0102a19b 0f85c50e0000 jne 0x14102b066
0102a1a1 807c243301 cmp byte ptr [rsp + 0x33], 1
0102a1a6 0f85ba0e0000 jne 0x14102b066
0102a1ac 4532e4 xor r12b, r12b
0102a1af 4488642432 mov byte ptr [rsp + 0x32], r12b
0102a1b4 4c8d85a0000000 lea r8, [rbp + 0xa0]
0102a1bb 33d2 xor edx, edx
0102a1bd b907000000 mov ecx, 7
0102a1c2 e889c81000 call 0x141136a50
0102a1c7 8bd8 mov ebx, eax
0102a1c9 8945a0 mov dword ptr [rbp - 0x60], eax
0102a1cc 488d95c0020000 lea rdx, [rbp + 0x2c0]
0102a1d3 488b4f08 mov rcx, qword ptr [rdi + 8]
0102a1d7 e854f3eaff call 0x140ed9530
0102a1dc 85c0 test eax, eax
0102a1de 0f857e000000 jne 0x14102a262
0102a1e4 41b401 mov r12b, 1
0102a1e7 4488642432 mov byte ptr [rsp + 0x32], r12b
0102a1ec 85db test ebx, ebx
0102a1ee 757a jne 0x14102a26a
0102a1f0 4c8b8db0000000 mov r9, qword ptr [rbp + 0xb0]
0102a1f7 4d85c9 test r9, r9
0102a1fa 746e je 0x14102a26a
0102a1fc 8b8da0000000 mov ecx, dword ptr [rbp + 0xa0]
0102a202 81f950434641 cmp ecx, 0x41464350
0102a208 7408 je 0x14102a212
0102a20a 81f9506e6957 cmp ecx, 0x57696e50
0102a210 7558 jne 0x14102a26a
0102a212 4883bdd002000000 cmp qword ptr [rbp + 0x2d0], 0
0102a21a 744e je 0x14102a26a
0102a21c 8b85c0020000 mov eax, dword ptr [rbp + 0x2c0]
0102a222 3d50434641 cmp eax, 0x41464350
0102a227 7407 je 0x14102a230
0102a229 3d506e6957 cmp eax, 0x57696e50
0102a22e 753a jne 0x14102a26a
0102a230 4d8b89b0000000 mov r9, qword ptr [r9 + 0xb0]
0102a237 4d85c9 test r9, r9
0102a23a 742e je 0x14102a26a
0102a23c 3bc8 cmp ecx, eax
0102a23e 752a jne 0x14102a26a
0102a240 4533c0 xor r8d, r8d
0102a243 488d95c0020000 lea rdx, [rbp + 0x2c0]
0102a24a 488d8da0000000 lea rcx, [rbp + 0xa0]
0102a251 41ffd1 call r9
0102a254 84c0 test al, al
0102a256 7412 je 0x14102a26a
0102a258 4532e4 xor r12b, r12b
0102a25b 4488642432 mov byte ptr [rsp + 0x32], r12b
0102a260 eb08 jmp 0x14102a26a
0102a262 85db test ebx, ebx
0102a264 0f85930b0000 jne 0x14102adfd
0102a26a 0fb74710 movzx eax, word ptr [rdi + 0x10]
0102a26e 6689442470 mov word ptr [rsp + 0x70], ax
0102a273 41b501 mov r13b, 1
0102a276 488b4770 mov rax, qword ptr [rdi + 0x70]
0102a27a 4885c0 test rax, rax
0102a27d 7405 je 0x14102a284
0102a27f 8b7064 mov esi, dword ptr [rax + 0x64]
0102a282 eb02 jmp 0x14102a286
0102a284 33f6 xor esi, esi
0102a286 488b4588 mov rax, qword ptr [rbp - 0x78]
0102a28a 488b4008 mov rax, qword ptr [rax + 8]
0102a28e 4885c0 test rax, rax
0102a291 7407 je 0x14102a29a
0102a293 8088981b000008 or byte ptr [rax + 0x1b98], 8
0102a29a 33ff xor edi, edi
0102a29c 85f6 test esi, esi
0102a29e 0f8492000000 je 0x14102a336
0102a2a4 4c8b7c2478 mov r15, qword ptr [rsp + 0x78]
0102a2a9 4c8b6590 mov r12, qword ptr [rbp - 0x70]
0102a2ad 0f1f00 nop dword ptr [rax]
0102a2b0 448bcf mov r9d, edi
0102a2b3 4533c0 xor r8d, r8d
0102a2b6 ba77000000 mov edx, 0x77
0102a2bb 498b8c2408040000 mov rcx, qword ptr [r12 + 0x408]
0102a2c3 e8f8cbf3ff call 0x140f66ec0
0102a2c8 488bd8 mov rbx, rax
0102a2cb 4885c0 test rax, rax
0102a2ce 745a je 0x14102a32a
0102a2d0 488b00 mov rax, qword ptr [rax]
0102a2d3 4885c0 test rax, rax
0102a2d6 7452 je 0x14102a32a
0102a2d8 813874736c70 cmp dword ptr [rax], 0x706c7374
0102a2de 754a jne 0x14102a32a
0102a2e0 837b2800 cmp dword ptr [rbx + 0x28], 0
0102a2e4 7444 je 0x14102a32a
0102a2e6 837b2c00 cmp dword ptr [rbx + 0x2c], 0
0102a2ea 751e jne 0x14102a30a
0102a2ec 488b4308 mov rax, qword ptr [rbx + 8]
0102a2f0 4885c0 test rax, rax
0102a2f3 7415 je 0x14102a30a
0102a2f5 488b4808 mov rcx, qword ptr [rax + 8]
0102a2f9 4885c9 test rcx, rcx
0102a2fc 740c je 0x14102a30a
0102a2fe 8b502c mov edx, dword ptr [rax + 0x2c]
0102a301 85d2 test edx, edx
0102a303 750c jne 0x14102a311
0102a305 488bc1 mov rax, rcx
0102a308 ebeb jmp 0x14102a2f5
0102a30a 8b532c mov edx, dword ptr [rbx + 0x2c]
0102a30d 85d2 test edx, edx
0102a30f 7419 je 0x14102a32a
0102a311 448bca mov r9d, edx
0102a314 4533c0 xor r8d, r8d
0102a317 488bd3 mov rdx, rbx
0102a31a 498bcf mov rcx, r15
0102a31d e8ae302bff call 0x1402dd3d0
0102a322 488bcb mov rcx, rbx
0102a325 e816c3ecff call 0x140ef6640
0102a32a ffc7 inc edi
0102a32c 3bfe cmp edi, esi
0102a32e 7280 jb 0x14102a2b0
0102a330 440fb6642432 movzx r12d, byte ptr [rsp + 0x32]
0102a336 4c8b7c2478 mov r15, qword ptr [rsp + 0x78]
0102a33b 4d85ff test r15, r15
0102a33e 742c je 0x14102a36c
0102a340 41813f54534c4f cmp dword ptr [r15], 0x4f4c5354
0102a347 7523 jne 0x14102a36c
0102a349 41837f0400 cmp dword ptr [r15 + 4], 0
0102a34e 741c je 0x14102a36c
0102a350 498b5f10 mov rbx, qword ptr [r15 + 0x10]
0102a354 492b5f08 sub rbx, qword ptr [r15 + 8]
0102a358 48c1fb04 sar rbx, 4
0102a35c 48b8abaaaaaaaaaaaaaa movabs rax, 0xaaaaaaaaaaaaaaab
0102a366 480fafd8 imul rbx, rax
0102a36a eb02 jmp 0x14102a36e
0102a36c 33db xor ebx, ebx
0102a36e 0f57c0 xorps xmm0, xmm0
0102a371 f30f7f4550 movdqu xmmword ptr [rbp + 0x50], xmm0
0102a376 8bd3 mov edx, ebx
0102a378 41b901000000 mov r9d, 1
0102a37e f20f1015aa92c400 movsd xmm2, qword ptr [rip + 0xc492aa]
0102a386 488d4d50 lea rcx, [rbp + 0x50]
0102a38a e88167b4ff call 0x140b70b10
0102a38f 488bf8 mov rdi, rax
0102a392 488d4d50 lea rcx, [rbp + 0x50]
0102a396 e845c6aaff call 0x140ad69e0
0102a39b b90f003023 mov ecx, 0x2330000f
0102a3a0 e82b46adff call 0x140afe9d0
0102a3a5 488bd0 mov rdx, rax
0102a3a8 488d4d10 lea rcx, [rbp + 0x10]
0102a3ac e82fbfaaff call 0x140ad62e0
0102a3b1 90 nop 
0102a3b2 488d5510 lea rdx, [rbp + 0x10]
0102a3b6 488bcf mov rcx, rdi
0102a3b9 e8627ab4ff call 0x140b71e20
0102a3be 8d73ff lea esi, [rbx - 1]
0102a3c1 f20f1035678fc400 movsd xmm6, qword ptr [rip + 0xc48f67]
0102a3c9 85f6 test esi, esi
0102a3cb 0f88b1010000 js 0x14102a582
0102a3d1 448b6da0 mov r13d, dword ptr [rbp - 0x60]
0102a3d5 6666660f1f840000000000 nop word ptr [rax + rax]
0102a3e0 4533c0 xor r8d, r8d
0102a3e3 8bd6 mov edx, esi
0102a3e5 498bcf mov rcx, r15
0102a3e8 e8d3352bff call 0x1402dd9c0
0102a3ed 4885c0 test rax, rax
0102a3f0 0f8480010000 je 0x14102a576
0102a3f6 488b08 mov rcx, qword ptr [rax]
0102a3f9 4885c9 test rcx, rcx
0102a3fc 0f8474010000 je 0x14102a576
0102a402 813974736c70 cmp dword ptr [rcx], 0x706c7374
0102a408 0f8568010000 jne 0x14102a576
0102a40e 83782800 cmp dword ptr [rax + 0x28], 0
0102a412 0f845e010000 je 0x14102a576
0102a418 488b5830 mov rbx, qword ptr [rax + 0x30]
0102a41c 4885db test rbx, rbx
0102a41f 0f8451010000 je 0x14102a576
0102a425 48837b1000 cmp qword ptr [rbx + 0x10], 0
0102a42a 0f8446010000 je 0x14102a576
0102a430 488b5b58 mov rbx, qword ptr [rbx + 0x58]
0102a434 4885db test rbx, rbx
0102a437 0f8439010000 je 0x14102a576
0102a43d 0f1f00 nop dword ptr [rax]
0102a440 817b34454c4946 cmp dword ptr [rbx + 0x34], 0x46494c45
0102a447 7408 je 0x14102a451
0102a449 488b1b mov rbx, qword ptr [rbx]
0102a44c 4885db test rbx, rbx
0102a44f 75ef jne 0x14102a440
0102a451 4885db test rbx, rbx
0102a454 0f841c010000 je 0x14102a576
0102a45a ba02000000 mov edx, 2
0102a45f 488bcb mov rcx, rbx
0102a462 e859dbf7ff call 0x140fa7fc0
0102a467 85c0 test eax, eax
0102a469 0f8507010000 jne 0x14102a576
0102a46f 66837c24700a cmp word ptr [rsp + 0x70], 0xa
0102a475 7513 jne 0x14102a48a
0102a477 488b4308 mov rax, qword ptr [rbx + 8]
0102a47b 488b4860 mov rcx, qword ptr [rax + 0x60]
0102a47f 4883793800 cmp qword ptr [rcx + 0x38], 0
0102a484 0f85ec000000 jne 0x14102a576
0102a48a 8b4dc0 mov ecx, dword ptr [rbp - 0x40]
0102a48d 84c9 test cl, cl
0102a48f 754e jne 0x14102a4df
0102a491 4585ed test r13d, r13d
0102a494 7523 jne 0x14102a4b9
0102a496 488d5378 lea rdx, [rbx + 0x78]
0102a49a 488d8da0000000 lea rcx, [rbp + 0xa0]
0102a4a1 e80a95afff call 0x140b239b0
0102a4a6 8b4dc0 mov ecx, dword ptr [rbp - 0x40]
0102a4a9 0fb6c9 movzx ecx, cl
0102a4ac 84c0 test al, al
0102a4ae b801000000 mov eax, 1
0102a4b3 0f45c8 cmovne ecx, eax
0102a4b6 894dc0 mov dword ptr [rbp - 0x40], ecx
0102a4b9 4584e4 test r12b, r12b
0102a4bc 741d je 0x14102a4db
0102a4be 488d5378 lea rdx, [rbx + 0x78]
0102a4c2 488d8dc0020000 lea rcx, [rbp + 0x2c0]
0102a4c9 e8e294afff call 0x140b239b0
0102a4ce 84c0 test al, al
0102a4d0 7406 je 0x14102a4d8
0102a4d2 c645c001 mov byte ptr [rbp - 0x40], 1
0102a4d6 eb07 jmp 0x14102a4df
0102a4d8 8b4dc0 mov ecx, dword ptr [rbp - 0x40]
0102a4db 84c9 test cl, cl
0102a4dd 744c je 0x14102a52b
0102a4df 4585f6 test r14d, r14d
0102a4e2 753c jne 0x14102a520
0102a4e4 33d2 xor edx, edx
0102a4e6 488b4b08 mov rcx, qword ptr [rbx + 8]
0102a4ea e88166f7ff call 0x140fa0b70
0102a4ef 8bc8 mov ecx, eax
0102a4f1 e8bacff8ff call 0x140fb74b0
0102a4f6 0b44243c or eax, dword ptr [rsp + 0x3c]
0102a4fa 8bd0 mov edx, eax
0102a4fc 8944243c mov dword ptr [rsp + 0x3c], eax
0102a500 8bc8 mov ecx, eax
0102a502 81e1f0000000 and ecx, 0xf0
0102a508 741a je 0x14102a524
0102a50a 8d41ff lea eax, [rcx - 1]
0102a50d 85c1 test ecx, eax
0102a50f 7413 je 0x14102a524
0102a511 81e21fffffff and edx, 0xffffff1f
0102a517 83ca10 or edx, 0x10
0102a51a 8954243c mov dword ptr [rsp + 0x3c], edx
0102a51e eb04 jmp 0x14102a524
0102a520 8b54243c mov edx, dword ptr [rsp + 0x3c]
0102a524 8d42ff lea eax, [rdx - 1]
0102a527 85c2 test edx, eax
0102a529 7554 jne 0x14102a57f
0102a52b 488d4c2460 lea rcx, [rsp + 0x60]
0102a530 ff1552068c00 call qword ptr [rip + 0x8c0652]
0102a536 0f57c9 xorps xmm1, xmm1
0102a539 f2480f2a4c2460 cvtsi2sd xmm1, qword ptr [rsp + 0x60]
0102a540 f20f590d80540a01 mulsd xmm1, qword ptr [rip + 0x10a5480]
0102a548 0f28c1 movaps xmm0, xmm1
0102a54b f20f5cc7 subsd xmm0, xmm7
0102a54f 660f2fc6 comisd xmm0, xmm6
0102a553 7221 jb 0x14102a576
0102a555 0f28f9 movaps xmm7, xmm1
0102a558 0f57c9 xorps xmm1, xmm1
0102a55b 488bcf mov rcx, rdi
0102a55e e8fd70b4ff call 0x140b71660
0102a563 488b4770 mov rax, qword ptr [rdi + 0x70]
0102a567 488b5018 mov rdx, qword ptr [rax + 0x18]
0102a56b 48ffc2 inc rdx
0102a56e 488bcf mov rcx, rdi
0102a571 e8ca77b4ff call 0x140b71d40
0102a576 83ee01 sub esi, 1
0102a579 0f8961feffff jns 0x14102a3e0
0102a57f 41b501 mov r13b, 1
0102a582 be01000000 mov esi, 1
0102a587 4885ff test rdi, rdi
0102a58a 740a je 0x14102a596
0102a58c 488b07 mov rax, qword ptr [rdi]
0102a58f 8bd6 mov edx, esi
0102a591 488bcf mov rcx, rdi
0102a594 ff10 call qword ptr [rax]
0102a596 e8359fe6ff call 0x140e944d0
0102a59b 84c0 test al, al
0102a59d 0f85b9040000 jne 0x14102aa5c
0102a5a3 3845c0 cmp byte ptr [rbp - 0x40], al
0102a5a6 0f84b0040000 je 0x14102aa5c
0102a5ac 837da000 cmp dword ptr [rbp - 0x60], 0
0102a5b0 7527 jne 0x14102a5d9
0102a5b2 488d8da0000000 lea rcx, [rbp + 0xa0]
0102a5b9 e8329cafff call 0x140b241f0
0102a5be 4885c0 test rax, rax
0102a5c1 7416 je 0x14102a5d9
0102a5c3 488b5040 mov rdx, qword ptr [rax + 0x40]
0102a5c7 4885d2 test rdx, rdx
0102a5ca 7439 je 0x14102a605
0102a5cc 488d8da0000000 lea rcx, [rbp + 0xa0]
0102a5d3 ffd2 call rdx
0102a5d5 84c0 test al, al
0102a5d7 742c je 0x14102a605
0102a5d9 4584e4 test r12b, r12b
0102a5dc 742a je 0x14102a608
0102a5de 488d8dc0020000 lea rcx, [rbp + 0x2c0]
0102a5e5 e8069cafff call 0x140b241f0
0102a5ea 4885c0 test rax, rax
0102a5ed 7419 je 0x14102a608
0102a5ef 488b5040 mov rdx, qword ptr [rax + 0x40]
0102a5f3 4885d2 test rdx, rdx
0102a5f6 740d je 0x14102a605
0102a5f8 488d8dc0020000 lea rcx, [rbp + 0x2c0]
0102a5ff ffd2 call rdx
0102a601 84c0 test al, al
0102a603 7503 jne 0x14102a608
0102a605 4532ed xor r13b, r13b
0102a608 8b7de0 mov edi, dword ptr [rbp - 0x20]
0102a60b 807c244300 cmp byte ptr [rsp + 0x43], 0
0102a610 741e je 0x14102a630
0102a612 33d2 xor edx, edx
0102a614 83ff01 cmp edi, 1
0102a617 0f95c2 setne dl
0102a61a 81c28d00f401 add edx, 0x1f4008d
0102a620 33db xor ebx, ebx
0102a622 83ff01 cmp edi, 1
0102a625 0f95c3 setne bl
0102a628 81c38f00f401 add ebx, 0x1f4008f
0102a62e eb2f jmp 0x14102a65f
0102a630 83ff01 cmp edi, 1
0102a633 750c jne 0x14102a641
0102a635 ba3300f401 mov edx, 0x1f40033
0102a63a b84000f401 mov eax, 0x1f40040
0102a63f eb0a jmp 0x14102a64b
0102a641 ba3400f401 mov edx, 0x1f40034
0102a646 b84100f401 mov eax, 0x1f40041
0102a64b 4584ed test r13b, r13b
0102a64e 0f45d0 cmovne edx, eax
0102a651 410fb6c5 movzx eax, r13b
0102a655 83f001 xor eax, 1
0102a658 8d1c450b003023 lea ebx, [rax*2 + 0x2330000b]
0102a65f 807dec00 cmp byte ptr [rbp - 0x14], 0
0102a663 0f85bc000000 jne 0x14102a725
0102a669 4533c0 xor r8d, r8d
0102a66c 8b4c243c mov ecx, dword ptr [rsp + 0x3c]
0102a670 e80bcef8ff call 0x140fb7480
0102a675 488bd0 mov rdx, rax
0102a678 488d4dd0 lea rcx, [rbp - 0x30]
0102a67c e83fc0aaff call 0x140ad66c0
0102a681 8bcb mov ecx, ebx
0102a683 e84843adff call 0x140afe9d0
0102a688 488bd0 mov rdx, rax
0102a68b 488d4d30 lea rcx, [rbp + 0x30]
0102a68f e84cbcaaff call 0x140ad62e0
0102a694 488b4db0 mov rcx, qword ptr [rbp - 0x50]
0102a698 4885c9 test rcx, rcx
0102a69b 741b je 0x14102a6b8
0102a69d b8ffffffff mov eax, 0xffffffff
0102a6a2 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102a6a7 83f801 cmp eax, 1
0102a6aa 750c jne 0x14102a6b8
0102a6ac c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102a6b3 e820177700 call 0x14179bdd8
0102a6b8 488b4db8 mov rcx, qword ptr [rbp - 0x48]
0102a6bc 4885c9 test rcx, rcx
0102a6bf 741b je 0x14102a6dc
0102a6c1 b8ffffffff mov eax, 0xffffffff
0102a6c6 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102a6cb 83f801 cmp eax, 1
0102a6ce 750c jne 0x14102a6dc
0102a6d0 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102a6d7 e8fc167700 call 0x14179bdd8
0102a6dc 0f284530 movaps xmm0, xmmword ptr [rbp + 0x30]
0102a6e0 660f7f45b0 movdqa xmmword ptr [rbp - 0x50], xmm0
0102a6e5 0f57c9 xorps xmm1, xmm1
0102a6e8 660f7f4d30 movdqa xmmword ptr [rbp + 0x30], xmm1
0102a6ed 488d4d30 lea rcx, [rbp + 0x30]
0102a6f1 e8eac2aaff call 0x140ad69e0
0102a6f6 448bcf mov r9d, edi
0102a6f9 450fb6c5 movzx r8d, r13b
0102a6fd 488d55b0 lea rdx, [rbp - 0x50]
0102a701 488d4dd0 lea rcx, [rbp - 0x30]
0102a705 e876e0ffff call 0x141028780
0102a70a 6683f865 cmp ax, 0x65
0102a70e 7420 je 0x14102a730
0102a710 6683f867 cmp ax, 0x67
0102a714 0f8542030000 jne 0x14102aa5c
0102a71a 32c0 xor al, al
0102a71c 88442437 mov byte ptr [rsp + 0x37], al
0102a720 e937030000 jmp 0x14102aa5c
0102a725 807c244000 cmp byte ptr [rsp + 0x40], 0
0102a72a 0f842c030000 je 0x14102aa5c
0102a730 4d85ff test r15, r15
0102a733 742c je 0x14102a761
0102a735 41813f54534c4f cmp dword ptr [r15], 0x4f4c5354
0102a73c 7523 jne 0x14102a761
0102a73e 41837f0400 cmp dword ptr [r15 + 4], 0
0102a743 741c je 0x14102a761
0102a745 498b5f10 mov rbx, qword ptr [r15 + 0x10]
0102a749 492b5f08 sub rbx, qword ptr [r15 + 8]
0102a74d 48c1fb04 sar rbx, 4
0102a751 48bfabaaaaaaaaaaaaaa movabs rdi, 0xaaaaaaaaaaaaaaab
0102a75b 480fafdf imul rbx, rdi
0102a75f eb0c jmp 0x14102a76d
0102a761 33db xor ebx, ebx
0102a763 48bfabaaaaaaaaaaaaaa movabs rdi, 0xaaaaaaaaaaaaaaab
0102a76d 0f57c0 xorps xmm0, xmm0
0102a770 f30f7f4550 movdqu xmmword ptr [rbp + 0x50], xmm0
0102a775 8bd3 mov edx, ebx
0102a777 448bce mov r9d, esi
0102a77a f20f1015ae8ec400 movsd xmm2, qword ptr [rip + 0xc48eae]
0102a782 488d4d50 lea rcx, [rbp + 0x50]
0102a786 e88563b4ff call 0x140b70b10
0102a78b 4c8be0 mov r12, rax
0102a78e 4889442460 mov qword ptr [rsp + 0x60], rax
0102a793 b910003023 mov ecx, 0x23300010
0102a798 e83342adff call 0x140afe9d0
0102a79d 488bd0 mov rdx, rax
0102a7a0 488d4d30 lea rcx, [rbp + 0x30]
0102a7a4 e837bbaaff call 0x140ad62e0
0102a7a9 488b4d10 mov rcx, qword ptr [rbp + 0x10]
0102a7ad 4885c9 test rcx, rcx
0102a7b0 741b je 0x14102a7cd
0102a7b2 baffffffff mov edx, 0xffffffff
0102a7b7 f00fc15108 lock xadd dword ptr [rcx + 8], edx
0102a7bc 83fa01 cmp edx, 1
0102a7bf 750c jne 0x14102a7cd
0102a7c1 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102a7c8 e80b167700 call 0x14179bdd8
0102a7cd 488b4d18 mov rcx, qword ptr [rbp + 0x18]
0102a7d1 4885c9 test rcx, rcx
0102a7d4 741b je 0x14102a7f1
0102a7d6 b8ffffffff mov eax, 0xffffffff
0102a7db f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102a7e0 83f801 cmp eax, 1
0102a7e3 750c jne 0x14102a7f1
0102a7e5 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102a7ec e8e7157700 call 0x14179bdd8
0102a7f1 0f284530 movaps xmm0, xmmword ptr [rbp + 0x30]
0102a7f5 660f7f4510 movdqa xmmword ptr [rbp + 0x10], xmm0
0102a7fa 0f57c9 xorps xmm1, xmm1
0102a7fd 660f7f4d30 movdqa xmmword ptr [rbp + 0x30], xmm1
0102a802 488d4d30 lea rcx, [rbp + 0x30]
0102a806 e8d5c1aaff call 0x140ad69e0
0102a80b 488d5510 lea rdx, [rbp + 0x10]
0102a80f 498bcc mov rcx, r12
0102a812 e80976b4ff call 0x140b71e20
0102a817 448d7bff lea r15d, [rbx - 1]
0102a81b 44897d98 mov dword ptr [rbp - 0x68], r15d
0102a81f 4585ff test r15d, r15d
0102a822 0f881f020000 js 0x14102aa47
0102a828 488b5c2478 mov rbx, qword ptr [rsp + 0x78]
0102a82d 0f1f00 nop dword ptr [rax]
0102a830 4533c0 xor r8d, r8d
0102a833 418bd7 mov edx, r15d
0102a836 488bcb mov rcx, rbx
0102a839 e882312bff call 0x1402dd9c0
0102a83e 4c8bc0 mov r8, rax
0102a841 4885c0 test rax, rax
0102a844 0f8496010000 je 0x14102a9e0
0102a84a 488b7030 mov rsi, qword ptr [rax + 0x30]
0102a84e 66837c24700a cmp word ptr [rsp + 0x70], 0xa
0102a854 750f jne 0x14102a865
0102a856 488b4e60 mov rcx, qword ptr [rsi + 0x60]
0102a85a 4883793800 cmp qword ptr [rcx + 0x38], 0
0102a85f 0f85c5010000 jne 0x14102aa2a
0102a865 488b4588 mov rax, qword ptr [rbp - 0x78]
0102a869 813874736c70 cmp dword ptr [rax], 0x706c7374
0102a86f 0f85c7000000 jne 0x14102a93c
0102a875 0fb74810 movzx ecx, word ptr [rax + 0x10]
0102a879 83e90a sub ecx, 0xa
0102a87c 7418 je 0x14102a896
0102a87e 83e901 sub ecx, 1
0102a881 7413 je 0x14102a896
0102a883 83e914 sub ecx, 0x14
0102a886 740e je 0x14102a896
0102a888 83e903 sub ecx, 3
0102a88b 7409 je 0x14102a896
0102a88d 83f915 cmp ecx, 0x15
0102a890 0f85a6000000 jne 0x14102a93c
0102a896 4885f6 test rsi, rsi
0102a899 0f849d000000 je 0x14102a93c
0102a89f 48837e1000 cmp qword ptr [rsi + 0x10], 0
0102a8a4 0f8492000000 je 0x14102a93c
0102a8aa f6869f00000010 test byte ptr [rsi + 0x9f], 0x10
0102a8b1 0f8585000000 jne 0x14102a93c
0102a8b7 80be9d00000000 cmp byte ptr [rsi + 0x9d], 0
0102a8be 7c7c jl 0x14102a93c
0102a8c0 b201 mov dl, 1
0102a8c2 498bc8 mov rcx, r8
0102a8c5 e866f1fcff call 0x140ff9a30
0102a8ca f6452040 test byte ptr [rbp + 0x20], 0x40
0102a8ce 740a je 0x14102a8da
0102a8d0 b201 mov dl, 1
0102a8d2 488bce mov rcx, rsi
0102a8d5 e81662f7ff call 0x140fa0af0
0102a8da 4885db test rbx, rbx
0102a8dd 0f8447010000 je 0x14102aa2a
0102a8e3 813b54534c4f cmp dword ptr [rbx], 0x4f4c5354
0102a8e9 0f853b010000 jne 0x14102aa2a
0102a8ef 837b0400 cmp dword ptr [rbx + 4], 0
0102a8f3 0f8431010000 je 0x14102aa2a
0102a8f9 488b5308 mov rdx, qword ptr [rbx + 8]
0102a8fd 4c8b4310 mov r8, qword ptr [rbx + 0x10]
0102a901 418bcf mov ecx, r15d
0102a904 498bc0 mov rax, r8
0102a907 482bc2 sub rax, rdx
0102a90a 48c1f804 sar rax, 4
0102a90e 480fafc7 imul rax, rdi
0102a912 483bc8 cmp rcx, rax
0102a915 0f830f010000 jae 0x14102aa2a
0102a91b 4b8d0c7f lea rcx, [r15 + r15*2]
0102a91f 48c1e104 shl rcx, 4
0102a923 4803ca add rcx, rdx
0102a926 488d5130 lea rdx, [rcx + 0x30]
0102a92a 4c2bc2 sub r8, rdx
0102a92d e843cf8300 call 0x141867875
0102a932 48834310d0 add qword ptr [rbx + 0x10], -0x30
0102a937 e9ee000000 jmp 0x14102aa2a
0102a93c 488b5e58 mov rbx, qword ptr [rsi + 0x58]
0102a940 4885db test rbx, rbx
0102a943 0f8492000000 je 0x14102a9db
0102a949 440fb6642432 movzx r12d, byte ptr [rsp + 0x32]
0102a94f 448b7da0 mov r15d, dword ptr [rbp - 0x60]
0102a953 4c8b33 mov r14, qword ptr [rbx]
0102a956 817b34454c4946 cmp dword ptr [rbx + 0x34], 0x46494c45
0102a95d 756b jne 0x14102a9ca
0102a95f ba02000000 mov edx, 2
0102a964 488bcb mov rcx, rbx
0102a967 e854d6f7ff call 0x140fa7fc0
0102a96c 85c0 test eax, eax
0102a96e 755a jne 0x14102a9ca
0102a970 4585ff test r15d, r15d
0102a973 751d jne 0x14102a992
0102a975 488d5378 lea rdx, [rbx + 0x78]
0102a979 488d8da0000000 lea rcx, [rbp + 0xa0]
0102a980 e82b90afff call 0x140b239b0
0102a985 84c0 test al, al
0102a987 7409 je 0x14102a992
0102a989 488d95a0000000 lea rdx, [rbp + 0xa0]
0102a990 eb20 jmp 0x14102a9b2
0102a992 4584e4 test r12b, r12b
0102a995 7433 je 0x14102a9ca
0102a997 488d5378 lea rdx, [rbx + 0x78]
0102a99b 488d8dc0020000 lea rcx, [rbp + 0x2c0]
0102a9a2 e80990afff call 0x140b239b0
0102a9a7 84c0 test al, al
0102a9a9 741f je 0x14102a9ca
0102a9ab 488d95c0020000 lea rdx, [rbp + 0x2c0]
0102a9b2 450fb6cd movzx r9d, r13b
0102a9b6 4c8d4378 lea r8, [rbx + 0x78]
0102a9ba 488b4e10 mov rcx, qword ptr [rsi + 0x10]
0102a9be e89d4ae6ff call 0x140e8f460
0102a9c3 c6839802000000 mov byte ptr [rbx + 0x298], 0
0102a9ca 498bde mov rbx, r14
0102a9cd 4d85f6 test r14, r14
0102a9d0 7581 jne 0x14102a953
0102a9d2 448b7d98 mov r15d, dword ptr [rbp - 0x68]
0102a9d6 4c8b642460 mov r12, qword ptr [rsp + 0x60]
0102a9db 488b5c2478 mov rbx, qword ptr [rsp + 0x78]
0102a9e0 488d4d80 lea rcx, [rbp - 0x80]
0102a9e4 ff159e018c00 call qword ptr [rip + 0x8c019e]
0102a9ea 0f57c9 xorps xmm1, xmm1
0102a9ed f2480f2a4d80 cvtsi2sd xmm1, qword ptr [rbp - 0x80]
0102a9f3 f20f590dcd4f0a01 mulsd xmm1, qword ptr [rip + 0x10a4fcd]
0102a9fb 0f28c1 movaps xmm0, xmm1
0102a9fe f20f5cc7 subsd xmm0, xmm7
0102aa02 660f2fc6 comisd xmm0, xmm6
0102aa06 7222 jb 0x14102aa2a
0102aa08 0f28f9 movaps xmm7, xmm1
0102aa0b 0f57c9 xorps xmm1, xmm1
0102aa0e 498bcc mov rcx, r12
0102aa11 e84a6cb4ff call 0x140b71660
0102aa16 498b442470 mov rax, qword ptr [r12 + 0x70]
0102aa1b 488b5018 mov rdx, qword ptr [rax + 0x18]
0102aa1f 48ffc2 inc rdx
0102aa22 498bcc mov rcx, r12
0102aa25 e81673b4ff call 0x140b71d40
0102aa2a 4183ef01 sub r15d, 1
0102aa2e 44897d98 mov dword ptr [rbp - 0x68], r15d
0102aa32 48bfabaaaaaaaaaaaaaa movabs rdi, 0xaaaaaaaaaaaaaaab
0102aa3c 0f89eefdffff jns 0x14102a830
0102aa42 be01000000 mov esi, 1
0102aa47 4d85e4 test r12, r12
0102aa4a 740b je 0x14102aa57
0102aa4c 498b0424 mov rax, qword ptr [r12]
0102aa50 8bd6 mov edx, esi
0102aa52 498bcc mov rcx, r12
0102aa55 ff10 call qword ptr [rax]
0102aa57 4c8b7c2478 mov r15, qword ptr [rsp + 0x78]
0102aa5c 4d85ff test r15, r15
0102aa5f 0f845a020000 je 0x14102acbf
0102aa65 41813f54534c4f cmp dword ptr [r15], 0x4f4c5354
0102aa6c 0f854d020000 jne 0x14102acbf
0102aa72 41837f0400 cmp dword ptr [r15 + 4], 0
0102aa77 0f8442020000 je 0x14102acbf
0102aa7d 498b4710 mov rax, qword ptr [r15 + 0x10]
0102aa81 492b4708 sub rax, qword ptr [r15 + 8]
0102aa85 48c1f804 sar rax, 4
0102aa89 48baabaaaaaaaaaaaaaa movabs rdx, 0xaaaaaaaaaaaaaaab
0102aa93 480fafc2 imul rax, rdx
0102aa97 85c0 test eax, eax
0102aa99 0f8420020000 je 0x14102acbf
0102aa9f 4533f6 xor r14d, r14d
0102aaa2 4533ed xor r13d, r13d
0102aaa5 8bd8 mov ebx, eax
0102aaa7 48895d80 mov qword ptr [rbp - 0x80], rbx
0102aaab 0f1f440000 nop dword ptr [rax + rax]
0102aab0 4d85ff test r15, r15
0102aab3 0f84e7010000 je 0x14102aca0
0102aab9 41813f54534c4f cmp dword ptr [r15], 0x4f4c5354
0102aac0 0f85da010000 jne 0x14102aca0
0102aac6 41837f0400 cmp dword ptr [r15 + 4], 0
0102aacb 0f84cf010000 je 0x14102aca0
0102aad1 498b4f08 mov rcx, qword ptr [r15 + 8]
0102aad5 498b4710 mov rax, qword ptr [r15 + 0x10]
0102aad9 482bc1 sub rax, rcx
0102aadc 48c1f804 sar rax, 4
0102aae0 480fafc2 imul rax, rdx
0102aae4 4c3be8 cmp r13, rax
0102aae7 0f83b3010000 jae 0x14102aca0
0102aaed 410f10340e movups xmm6, xmmword ptr [r14 + rcx]
0102aaf2 418b440e20 mov eax, dword ptr [r14 + rcx + 0x20]
0102aaf7 894570 mov dword ptr [rbp + 0x70], eax
0102aafa 4d8b640e28 mov r12, qword ptr [r14 + rcx + 0x28]
0102aaff 33ff xor edi, edi
0102ab01 458b7c0e10 mov r15d, dword ptr [r14 + rcx + 0x10]
0102ab06 4585ff test r15d, r15d
0102ab09 0f843e010000 je 0x14102ac4d
0102ab0f 660f6fc6 movdqa xmm0, xmm6
0102ab13 660f73d808 psrldq xmm0, 8
0102ab18 66480f7ec0 movq rax, xmm0
0102ab1d 48c1e820 shr rax, 0x20
0102ab21 85c0 test eax, eax
0102ab23 7469 je 0x14102ab8e
0102ab25 660f7ef3 movd ebx, xmm6
0102ab29 85db test ebx, ebx
0102ab2b 0f8418010000 je 0x14102ac49
0102ab31 ff1599fc8b00 call qword ptr [rip + 0x8bfc99]
0102ab37 8bc8 mov ecx, eax
0102ab39 e8a255baff call 0x140bd00e0
0102ab3e 84c0 test al, al
0102ab40 742e je 0x14102ab70
0102ab42 488b0d47190b01 mov rcx, qword ptr [rip + 0x10b1947]
0102ab49 4885c9 test rcx, rcx
0102ab4c 7422 je 0x14102ab70
0102ab4e 6690 nop 
0102ab50 399990000000 cmp dword ptr [rcx + 0x90], ebx
0102ab56 741a je 0x14102ab72
0102ab58 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0102ab62 750c jne 0x14102ab70
0102ab64 488b4178 mov rax, qword ptr [rcx + 0x78]
0102ab68 488bc8 mov rcx, rax
0102ab6b 4885c0 test rax, rax
0102ab6e 75e0 jne 0x14102ab50
0102ab70 33c9 xor ecx, ecx
0102ab72 4885c9 test rcx, rcx
0102ab75 0f84ce000000 je 0x14102ac49
0102ab7b 660f73de0c psrldq xmm6, 0xc
0102ab80 660f7ef2 movd edx, xmm6
0102ab84 e817bbecff call 0x140ef66a0
0102ab89 e9a8000000 jmp 0x14102ac36
0102ab8e 660f7ef6 movd esi, xmm6
0102ab92 85f6 test esi, esi
0102ab94 0f84b3000000 je 0x14102ac4d
0102ab9a ff1530fc8b00 call qword ptr [rip + 0x8bfc30]
0102aba0 8bc8 mov ecx, eax
0102aba2 e83955baff call 0x140bd00e0
0102aba7 84c0 test al, al
0102aba9 742c je 0x14102abd7
0102abab 488b1dde180b01 mov rbx, qword ptr [rip + 0x10b18de]
0102abb2 4885db test rbx, rbx
0102abb5 7420 je 0x14102abd7
0102abb7 39b390000000 cmp dword ptr [rbx + 0x90], esi
0102abbd 741a je 0x14102abd9
0102abbf 81bb8000000074616474 cmp dword ptr [rbx + 0x80], 0x74646174
0102abc9 750c jne 0x14102abd7
0102abcb 488b4378 mov rax, qword ptr [rbx + 0x78]
0102abcf 488bd8 mov rbx, rax
0102abd2 4885c0 test rax, rax
0102abd5 75e0 jne 0x14102abb7
0102abd7 33db xor ebx, ebx
0102abd9 4885db test rbx, rbx
0102abdc 746b je 0x14102ac49
0102abde 660f6fc6 movdqa xmm0, xmm6
0102abe2 660f73d80c psrldq xmm0, 0xc
0102abe7 660f7ec2 movd edx, xmm0
0102abeb 85d2 test edx, edx
0102abed 741d je 0x14102ac0c
0102abef 488bcb mov rcx, rbx
0102abf2 e8a9baecff call 0x140ef66a0
0102abf7 4885c0 test rax, rax
0102abfa 7410 je 0x14102ac0c
0102abfc 418bd7 mov edx, r15d
0102abff 488bc8 mov rcx, rax
0102ac02 e8399aecff call 0x140ef4640
0102ac07 4885c0 test rax, rax
0102ac0a 7527 jne 0x14102ac33
0102ac0c 660f73de04 psrldq xmm6, 4
0102ac11 660f7ef2 movd edx, xmm6
0102ac15 85d2 test edx, edx
0102ac17 7430 je 0x14102ac49
0102ac19 488bcb mov rcx, rbx
0102ac1c e8bfd0e8ff call 0x140eb7ce0
0102ac21 4885c0 test rax, rax
0102ac24 7423 je 0x14102ac49
0102ac26 488bc8 mov rcx, rax
0102ac29 e8e2c6ecff call 0x140ef7310
0102ac2e 4885c0 test rax, rax
0102ac31 7416 je 0x14102ac49
0102ac33 488b00 mov rax, qword ptr [rax]
0102ac36 4885c0 test rax, rax
0102ac39 740e je 0x14102ac49
0102ac3b 418bd7 mov edx, r15d
0102ac3e 488bc8 mov rcx, rax
0102ac41 e8fa99ecff call 0x140ef4640
0102ac46 488bf8 mov rdi, rax
0102ac49 488b5d80 mov rbx, qword ptr [rbp - 0x80]
0102ac4d 4885ff test rdi, rdi
0102ac50 7449 je 0x14102ac9b
0102ac52 488b07 mov rax, qword ptr [rdi]
0102ac55 4885c0 test rax, rax
0102ac58 7441 je 0x14102ac9b
0102ac5a 813874736c70 cmp dword ptr [rax], 0x706c7374
0102ac60 7539 jne 0x14102ac9b
0102ac62 837f2800 cmp dword ptr [rdi + 0x28], 0
0102ac66 7433 je 0x14102ac9b
0102ac68 4489672c mov dword ptr [rdi + 0x2c], r12d
0102ac6c f6474b01 test byte ptr [rdi + 0x4b], 1
0102ac70 7429 je 0x14102ac9b
0102ac72 458bc4 mov r8d, r12d
0102ac75 488d1524b7ecff lea rdx, [rip - 0x1348dc]
0102ac7c 488bcf mov rcx, rdi
0102ac7f e88c47ecff call 0x140eef410
0102ac84 488b07 mov rax, qword ptr [rdi]
0102ac87 4c8b7c2478 mov r15, qword ptr [rsp + 0x78]
0102ac8c 483b7870 cmp rdi, qword ptr [rax + 0x70]
0102ac90 750e jne 0x14102aca0
0102ac92 c7472c00000000 mov dword ptr [rdi + 0x2c], 0
0102ac99 eb05 jmp 0x14102aca0
0102ac9b 4c8b7c2478 mov r15, qword ptr [rsp + 0x78]
0102aca0 49ffc5 inc r13
0102aca3 4983c630 add r14, 0x30
0102aca7 4883eb01 sub rbx, 1
0102acab 48895d80 mov qword ptr [rbp - 0x80], rbx
0102acaf 48baabaaaaaaaaaaaaaa movabs rdx, 0xaaaaaaaaaaaaaaab
0102acb9 0f85f1fdffff jne 0x14102aab0
0102acbf 4c8b6588 mov r12, qword ptr [rbp - 0x78]
0102acc3 498b442408 mov rax, qword ptr [r12 + 8]
0102acc8 4885c0 test rax, rax
0102accb 7407 je 0x14102acd4
0102accd 80a0981b0000f7 and byte ptr [rax + 0x1b98], 0xf7
0102acd4 488b4d10 mov rcx, qword ptr [rbp + 0x10]
0102acd8 4885c9 test rcx, rcx
0102acdb 7423 je 0x14102ad00
0102acdd b8ffffffff mov eax, 0xffffffff
0102ace2 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102ace7 83f801 cmp eax, 1
0102acea 750c jne 0x14102acf8
0102acec c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102acf3 e8e0107700 call 0x14179bdd8
0102acf8 33ff xor edi, edi
0102acfa 48897d10 mov qword ptr [rbp + 0x10], rdi
0102acfe eb02 jmp 0x14102ad02
0102ad00 33ff xor edi, edi
0102ad02 488b4d18 mov rcx, qword ptr [rbp + 0x18]
0102ad06 4885c9 test rcx, rcx
0102ad09 741b je 0x14102ad26
0102ad0b b8ffffffff mov eax, 0xffffffff
0102ad10 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102ad15 83f801 cmp eax, 1
0102ad18 750c jne 0x14102ad26
0102ad1a c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102ad21 e8b2107700 call 0x14179bdd8
0102ad26 0fb6742437 movzx esi, byte ptr [rsp + 0x37]
0102ad2b 4084f6 test sil, sil
0102ad2e 0f85cf000000 jne 0x14102ae03
0102ad34 488b4590 mov rax, qword ptr [rbp - 0x70]
0102ad38 813874736c70 cmp dword ptr [rax], 0x706c7374
0102ad3e 7546 jne 0x14102ad86
0102ad40 488b5870 mov rbx, qword ptr [rax + 0x70]
0102ad44 4885db test rbx, rbx
0102ad47 743d je 0x14102ad86
0102ad49 488b03 mov rax, qword ptr [rbx]
0102ad4c 4885c0 test rax, rax
0102ad4f 7435 je 0x14102ad86
0102ad51 813874736c70 cmp dword ptr [rax], 0x706c7374
0102ad57 752d jne 0x14102ad86
0102ad59 837b2800 cmp dword ptr [rbx + 0x28], 0
0102ad5d 7427 je 0x14102ad86
0102ad5f f6434b01 test byte ptr [rbx + 0x4b], 1
0102ad63 741e je 0x14102ad83
0102ad65 897b2c mov dword ptr [rbx + 0x2c], edi
0102ad68 4533c0 xor r8d, r8d
0102ad6b 488d152eb6ecff lea rdx, [rip - 0x1349d2]
0102ad72 488bcb mov rcx, rbx
0102ad75 e89646ecff call 0x140eef410
0102ad7a 488b03 mov rax, qword ptr [rbx]
0102ad7d 483b5870 cmp rbx, qword ptr [rax + 0x70]
0102ad81 7503 jne 0x14102ad86
0102ad83 897b2c mov dword ptr [rbx + 0x2c], edi
0102ad86 41813c2474736c70 cmp dword ptr [r12], 0x706c7374
0102ad8e 0f855a050000 jne 0x14102b2ee
0102ad94 498b5c2470 mov rbx, qword ptr [r12 + 0x70]
0102ad99 4885db test rbx, rbx
0102ad9c 0f844c050000 je 0x14102b2ee
0102ada2 488b03 mov rax, qword ptr [rbx]
0102ada5 4885c0 test rax, rax
0102ada8 0f8440050000 je 0x14102b2ee
0102adae 813874736c70 cmp dword ptr [rax], 0x706c7374
0102adb4 0f8534050000 jne 0x14102b2ee
0102adba 837b2800 cmp dword ptr [rbx + 0x28], 0
0102adbe 0f842a050000 je 0x14102b2ee
0102adc4 897b2c mov dword ptr [rbx + 0x2c], edi
0102adc7 f6434b01 test byte ptr [rbx + 0x4b], 1
0102adcb 0f841d050000 je 0x14102b2ee
0102add1 4533c0 xor r8d, r8d
0102add4 488d15c5b5ecff lea rdx, [rip - 0x134a3b]
0102addb 488bcb mov rcx, rbx
0102adde e82d46ecff call 0x140eef410
0102ade3 488b03 mov rax, qword ptr [rbx]
0102ade6 4c8b642448 mov r12, qword ptr [rsp + 0x48]
0102adeb 483b5870 cmp rbx, qword ptr [rax + 0x70]
0102adef 0f85fe040000 jne 0x14102b2f3
0102adf5 897b2c mov dword ptr [rbx + 0x2c], edi
0102adf8 e9f6040000 jmp 0x14102b2f3
0102adfd 4c8b6588 mov r12, qword ptr [rbp - 0x78]
0102ae01 eb09 jmp 0x14102ae0c
0102ae03 488b7d90 mov rdi, qword ptr [rbp - 0x70]
0102ae07 4c8b7c2450 mov r15, qword ptr [rsp + 0x50]
0102ae0c 488b442448 mov rax, qword ptr [rsp + 0x48]
0102ae11 4885c0 test rax, rax
0102ae14 742d je 0x14102ae43
0102ae16 813854534c4f cmp dword ptr [rax], 0x4f4c5354
0102ae1c 7525 jne 0x14102ae43
0102ae1e 83780400 cmp dword ptr [rax + 4], 0
0102ae22 741f je 0x14102ae43
0102ae24 488b4810 mov rcx, qword ptr [rax + 0x10]
0102ae28 482b4808 sub rcx, qword ptr [rax + 8]
0102ae2c 48c1f904 sar rcx, 4
0102ae30 48baabaaaaaaaaaaaaaa movabs rdx, 0xaaaaaaaaaaaaaaab
0102ae3a 480fafca imul rcx, rdx
0102ae3e 4533ed xor r13d, r13d
0102ae41 eb10 jmp 0x14102ae53
0102ae43 4533ed xor r13d, r13d
0102ae46 418bcd mov ecx, r13d
0102ae49 48baabaaaaaaaaaaaaaa movabs rdx, 0xaaaaaaaaaaaaaaab
0102ae53 4d85ff test r15, r15
0102ae56 7422 je 0x14102ae7a
0102ae58 41813f54534c4f cmp dword ptr [r15], 0x4f4c5354
0102ae5f 7519 jne 0x14102ae7a
0102ae61 41837f0400 cmp dword ptr [r15 + 4], 0
0102ae66 7412 je 0x14102ae7a
0102ae68 498b4710 mov rax, qword ptr [r15 + 0x10]
0102ae6c 492b4708 sub rax, qword ptr [r15 + 8]
0102ae70 48c1f804 sar rax, 4
0102ae74 480fafc2 imul rax, rdx
0102ae78 eb03 jmp 0x14102ae7d
0102ae7a 418bc5 mov eax, r13d
0102ae7d 03c1 add eax, ecx
0102ae7f 0f84e1010000 je 0x14102b066
0102ae85 813f74736c70 cmp dword ptr [rdi], 0x706c7374
0102ae8b 0f8533010000 jne 0x14102afc4
0102ae91 488b5f70 mov rbx, qword ptr [rdi + 0x70]
0102ae95 4885db test rbx, rbx
0102ae98 745a je 0x14102aef4
0102ae9a 488b5b50 mov rbx, qword ptr [rbx + 0x50]
0102ae9e 4885db test rbx, rbx
0102aea1 0f841d010000 je 0x14102afc4
0102aea7 f6434b01 test byte ptr [rbx + 0x4b], 1
0102aeab 744a je 0x14102aef7
0102aead 488b4350 mov rax, qword ptr [rbx + 0x50]
0102aeb1 4885c0 test rax, rax
0102aeb4 7405 je 0x14102aebb
0102aeb6 488bd8 mov rbx, rax
0102aeb9 ebec jmp 0x14102aea7
0102aebb 488b4310 mov rax, qword ptr [rbx + 0x10]
0102aebf 4885c0 test rax, rax
0102aec2 7405 je 0x14102aec9
0102aec4 488bd8 mov rbx, rax
0102aec7 ebde jmp 0x14102aea7
0102aec9 488b4308 mov rax, qword ptr [rbx + 8]
0102aecd 4885c0 test rax, rax
0102aed0 7422 je 0x14102aef4
0102aed2 488b5810 mov rbx, qword ptr [rax + 0x10]
0102aed6 4885db test rbx, rbx
0102aed9 75cc jne 0x14102aea7
0102aedb 0f1f440000 nop dword ptr [rax + rax]
0102aee0 488b4008 mov rax, qword ptr [rax + 8]
0102aee4 4885c0 test rax, rax
0102aee7 740b je 0x14102aef4
0102aee9 488b5810 mov rbx, qword ptr [rax + 0x10]
0102aeed 4885db test rbx, rbx
0102aef0 74ee je 0x14102aee0
0102aef2 ebb3 jmp 0x14102aea7
0102aef4 498bdd mov rbx, r13
0102aef7 4885db test rbx, rbx
0102aefa 0f84c4000000 je 0x14102afc4
0102af00 488bcb mov rcx, rbx
0102af03 e8484aecff call 0x140eef950
0102af08 4c8bf0 mov r14, rax
0102af0b 837b2c02 cmp dword ptr [rbx + 0x2c], 2
0102af0f 0f859f000000 jne 0x14102afb4
0102af15 4032f6 xor sil, sil
0102af18 488b7b30 mov rdi, qword ptr [rbx + 0x30]
0102af1c 4885ff test rdi, rdi
0102af1f 7454 je 0x14102af75
0102af21 488b7f58 mov rdi, qword ptr [rdi + 0x58]
0102af25 4885ff test rdi, rdi
0102af28 744b je 0x14102af75
0102af2a 660f1f440000 nop word ptr [rax + rax]
0102af30 488bcf mov rcx, rdi
0102af33 488b3f mov rdi, qword ptr [rdi]
0102af36 488b4108 mov rax, qword ptr [rcx + 8]
0102af3a 4885c0 test rax, rax
0102af3d 7421 je 0x14102af60
0102af3f 4883781000 cmp qword ptr [rax + 0x10], 0
0102af44 741a je 0x14102af60
0102af46 81793444524853 cmp dword ptr [rcx + 0x34], 0x53485244
0102af4d 7411 je 0x14102af60
0102af4f 488b4058 mov rax, qword ptr [rax + 0x58]
0102af53 48833800 cmp qword ptr [rax], 0
0102af57 400f95c6 setne sil
0102af5b e810b1f7ff call 0x140fa6070
0102af60 4885ff test rdi, rdi
0102af63 75cb jne 0x14102af30
0102af65 4084f6 test sil, sil
0102af68 740b je 0x14102af75
0102af6a b201 mov dl, 1
0102af6c 488b4b30 mov rcx, qword ptr [rbx + 0x30]
0102af70 e85b24f7ff call 0x140f9d3d0
0102af75 488b03 mov rax, qword ptr [rbx]
0102af78 4885c0 test rax, rax
0102af7b 7437 je 0x14102afb4
0102af7d 813874736c70 cmp dword ptr [rax], 0x706c7374
0102af83 752f jne 0x14102afb4
0102af85 837b2800 cmp dword ptr [rbx + 0x28], 0
0102af89 7429 je 0x14102afb4
0102af8b f6434b01 test byte ptr [rbx + 0x4b], 1
0102af8f 741f je 0x14102afb0
0102af91 44896b2c mov dword ptr [rbx + 0x2c], r13d
0102af95 4533c0 xor r8d, r8d
0102af98 488d1501b4ecff lea rdx, [rip - 0x134bff]
0102af9f 488bcb mov rcx, rbx
0102afa2 e86944ecff call 0x140eef410
0102afa7 488b03 mov rax, qword ptr [rbx]
0102afaa 483b5870 cmp rbx, qword ptr [rax + 0x70]
0102afae 7504 jne 0x14102afb4
0102afb0 44896b2c mov dword ptr [rbx + 0x2c], r13d
0102afb4 498bde mov rbx, r14
0102afb7 4d85f6 test r14, r14
0102afba 0f8540ffffff jne 0x14102af00
0102afc0 488b7d90 mov rdi, qword ptr [rbp - 0x70]
0102afc4 41813c2474736c70 cmp dword ptr [r12], 0x706c7374
0102afcc 0f8594000000 jne 0x14102b066
0102afd2 41f684242802000001 test byte ptr [r12 + 0x228], 1
0102afdb 0f8485000000 je 0x14102b066
0102afe1 450fb7442410 movzx r8d, word ptr [r12 + 0x10]
0102afe7 664585c0 test r8w, r8w
0102afeb 7479 je 0x14102b066
0102afed 410fb7c8 movzx ecx, r8w
0102aff1 e89ad2ebff call 0x140ee8290
0102aff6 84c0 test al, al
0102aff8 746c je 0x14102b066
0102affa 664183f81a cmp r8w, 0x1a
0102afff 7465 je 0x14102b066
0102b001 498bcc mov rcx, r12
0102b004 e8c748ecff call 0x140eef8d0
0102b009 488bd8 mov rbx, rax
0102b00c 4885c0 test rax, rax
0102b00f 7455 je 0x14102b066
0102b011 837b2c02 cmp dword ptr [rbx + 0x2c], 2
0102b015 753f jne 0x14102b056
0102b017 488b03 mov rax, qword ptr [rbx]
0102b01a 4885c0 test rax, rax
0102b01d 7437 je 0x14102b056
0102b01f 813874736c70 cmp dword ptr [rax], 0x706c7374
0102b025 752f jne 0x14102b056
0102b027 837b2800 cmp dword ptr [rbx + 0x28], 0
0102b02b 7429 je 0x14102b056
0102b02d 44896b2c mov dword ptr [rbx + 0x2c], r13d
0102b031 f6434b01 test byte ptr [rbx + 0x4b], 1
0102b035 741f je 0x14102b056
0102b037 4533c0 xor r8d, r8d
0102b03a 488d155fb3ecff lea rdx, [rip - 0x134ca1]
0102b041 488bcb mov rcx, rbx
0102b044 e8c743ecff call 0x140eef410
0102b049 488b03 mov rax, qword ptr [rbx]
0102b04c 483b5870 cmp rbx, qword ptr [rax + 0x70]
0102b050 7504 jne 0x14102b056
0102b052 44896b2c mov dword ptr [rbx + 0x2c], r13d
0102b056 488bcb mov rcx, rbx
0102b059 e8f248ecff call 0x140eef950
0102b05e 488bd8 mov rbx, rax
0102b061 4885c0 test rax, rax
0102b064 75ab jne 0x14102b011
0102b066 488b4f08 mov rcx, qword ptr [rdi + 8]
0102b06a 4533f6 xor r14d, r14d
0102b06d 4885c9 test rcx, rcx
0102b070 7431 je 0x14102b0a3
0102b072 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0102b07c 7525 jne 0x14102b0a3
0102b07e ff819c000000 inc dword ptr [rcx + 0x9c]
0102b084 83b99c00000001 cmp dword ptr [rcx + 0x9c], 1
0102b08b 7516 jne 0x14102b0a3
0102b08d 488b01 mov rax, qword ptr [rcx]
0102b090 4c89742420 mov qword ptr [rsp + 0x20], r14
0102b095 4533c9 xor r9d, r9d
0102b098 4c8bc1 mov r8, rcx
0102b09b ba43426474 mov edx, 0x74644243
0102b0a0 ff5008 call qword ptr [rax + 8]
0102b0a3 488b4f08 mov rcx, qword ptr [rdi + 8]
0102b0a7 4885c9 test rcx, rcx
0102b0aa 7424 je 0x14102b0d0
0102b0ac 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0102b0b6 7518 jne 0x14102b0d0
0102b0b8 488b8168010000 mov rax, qword ptr [rcx + 0x168]
0102b0bf 4c8b8970010000 mov r9, qword ptr [rcx + 0x170]
0102b0c6 4533c0 xor r8d, r8d
0102b0c9 ba64626474 mov edx, 0x74646264
0102b0ce ffd0 call rax
0102b0d0 41813c2474736c70 cmp dword ptr [r12], 0x706c7374
0102b0d8 0f8545010000 jne 0x14102b223
0102b0de 410fb74c2410 movzx ecx, word ptr [r12 + 0x10]
0102b0e4 83e90a sub ecx, 0xa
0102b0e7 7418 je 0x14102b101
0102b0e9 83e901 sub ecx, 1
0102b0ec 7413 je 0x14102b101
0102b0ee 83e914 sub ecx, 0x14
0102b0f1 740e je 0x14102b101
0102b0f3 83e903 sub ecx, 3
0102b0f6 7409 je 0x14102b101
0102b0f8 83f915 cmp ecx, 0x15
0102b0fb 0f8522010000 jne 0x14102b223
0102b101 498b7c2470 mov rdi, qword ptr [r12 + 0x70]
0102b106 4885ff test rdi, rdi
0102b109 0f8410010000 je 0x14102b21f
0102b10f 8b7f64 mov edi, dword ptr [rdi + 0x64]
0102b112 418bf6 mov esi, r14d
0102b115 85ff test edi, edi
0102b117 0f8402010000 je 0x14102b21f
0102b11d 0f1f00 nop dword ptr [rax]
0102b120 448bce mov r9d, esi
0102b123 4533c0 xor r8d, r8d
0102b126 ba77000000 mov edx, 0x77
0102b12b 498b8c2408040000 mov rcx, qword ptr [r12 + 0x408]
0102b133 e888bdf3ff call 0x140f66ec0
0102b138 488bd8 mov rbx, rax
0102b13b 4885c0 test rax, rax
0102b13e 0f84d1000000 je 0x14102b215
0102b144 488b00 mov rax, qword ptr [rax]
0102b147 4885c0 test rax, rax
0102b14a 0f84c5000000 je 0x14102b215
0102b150 813874736c70 cmp dword ptr [rax], 0x706c7374
0102b156 0f85b9000000 jne 0x14102b215
0102b15c 837b2800 cmp dword ptr [rbx + 0x28], 0
0102b160 0f84af000000 je 0x14102b215
0102b166 837b2c00 cmp dword ptr [rbx + 0x2c], 0
0102b16a 7527 jne 0x14102b193
0102b16c 488b4308 mov rax, qword ptr [rbx + 8]
0102b170 4885c0 test rax, rax
0102b173 7414 je 0x14102b189
0102b175 488b4808 mov rcx, qword ptr [rax + 8]
0102b179 4885c9 test rcx, rcx
0102b17c 740b je 0x14102b189
0102b17e 83782c00 cmp dword ptr [rax + 0x2c], 0
0102b182 750f jne 0x14102b193
0102b184 488bc1 mov rax, rcx
0102b187 ebec jmp 0x14102b175
0102b189 837b2c00 cmp dword ptr [rbx + 0x2c], 0
0102b18d 0f8482000000 je 0x14102b215
0102b193 488b4b30 mov rcx, qword ptr [rbx + 0x30]
0102b197 4885c9 test rcx, rcx
0102b19a 7479 je 0x14102b215
0102b19c 4883791000 cmp qword ptr [rcx + 0x10], 0
0102b1a1 7472 je 0x14102b215
0102b1a3 f6819f00000010 test byte ptr [rcx + 0x9f], 0x10
0102b1aa 7569 jne 0x14102b215
0102b1ac 41813c2474736c70 cmp dword ptr [r12], 0x706c7374
0102b1b4 7520 jne 0x14102b1d6
0102b1b6 410fb7542410 movzx edx, word ptr [r12 + 0x10]
0102b1bc 83ea0a sub edx, 0xa
0102b1bf 7415 je 0x14102b1d6
0102b1c1 83fa01 cmp edx, 1
0102b1c4 7510 jne 0x14102b1d6
0102b1c6 e8e5aef6ff call 0x140f960b0
0102b1cb b201 mov dl, 1
0102b1cd 488b4b30 mov rcx, qword ptr [rbx + 0x30]
0102b1d1 e81a59f7ff call 0x140fa0af0
0102b1d6 488b03 mov rax, qword ptr [rbx]
0102b1d9 4885c0 test rax, rax
0102b1dc 7437 je 0x14102b215
0102b1de 813874736c70 cmp dword ptr [rax], 0x706c7374
0102b1e4 752f jne 0x14102b215
0102b1e6 837b2800 cmp dword ptr [rbx + 0x28], 0
0102b1ea 7429 je 0x14102b215
0102b1ec 4489732c mov dword ptr [rbx + 0x2c], r14d
0102b1f0 f6434b01 test byte ptr [rbx + 0x4b], 1
0102b1f4 741f je 0x14102b215
0102b1f6 4533c0 xor r8d, r8d
0102b1f9 488d15a0b1ecff lea rdx, [rip - 0x134e60]
0102b200 488bcb mov rcx, rbx
0102b203 e80842ecff call 0x140eef410
0102b208 488b03 mov rax, qword ptr [rbx]
0102b20b 483b5870 cmp rbx, qword ptr [rax + 0x70]
0102b20f 7504 jne 0x14102b215
0102b211 4489732c mov dword ptr [rbx + 0x2c], r14d
0102b215 ffc6 inc esi
0102b217 3bf7 cmp esi, edi
0102b219 0f8201ffffff jb 0x14102b120
0102b21f 488b7d90 mov rdi, qword ptr [rbp - 0x70]
0102b223 0fb6542472 movzx edx, byte ptr [rsp + 0x72]
0102b228 498bcc mov rcx, r12
0102b22b e8c0b0ecff call 0x140ef62f0
0102b230 41813c2474736c70 cmp dword ptr [r12], 0x706c7374
0102b238 7568 jne 0x14102b2a2
0102b23a 498bcc mov rcx, r12
0102b23d e8ee37ecff call 0x140eeea30
0102b242 41f68424d801000008 test byte ptr [r12 + 0x1d8], 8
0102b24b 751b jne 0x14102b268
0102b24d 498b4c2408 mov rcx, qword ptr [r12 + 8]
0102b252 488b01 mov rax, qword ptr [rcx]
0102b255 4c89742420 mov qword ptr [rsp + 0x20], r14
0102b25a 4d8bcc mov r9, r12
0102b25d 4c8bc1 mov r8, rcx
0102b260 ba64706474 mov edx, 0x74647064
0102b265 ff5008 call qword ptr [rax + 8]
0102b268 488d4c2460 lea rcx, [rsp + 0x60]
0102b26d ff1515f98b00 call qword ptr [rip + 0x8bf915]
0102b273 0f57c0 xorps xmm0, xmm0
0102b276 f2480f2a442460 cvtsi2sd xmm0, qword ptr [rsp + 0x60]
0102b27d f20f590543470a01 mulsd xmm0, qword ptr [rip + 0x10a4743]
0102b285 f20f5c05a3ab0701 subsd xmm0, qword ptr [rip + 0x107aba3]
0102b28d f2480f2cc8 cvttsd2si rcx, xmm0
0102b292 83c10a add ecx, 0xa
0102b295 488b0594bc0701 mov rax, qword ptr [rip + 0x107bc94]
0102b29c 898804530100 mov dword ptr [rax + 0x15304], ecx
0102b2a2 33d2 xor edx, edx
0102b2a4 488bcf mov rcx, rdi
0102b2a7 e844b0ecff call 0x140ef62f0
0102b2ac 33d2 xor edx, edx
0102b2ae 488b4f08 mov rcx, qword ptr [rdi + 8]
0102b2b2 e87930eaff call 0x140ece330
0102b2b7 488b4f08 mov rcx, qword ptr [rdi + 8]
0102b2bb 4885c9 test rcx, rcx
0102b2be 7424 je 0x14102b2e4
0102b2c0 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0102b2ca 7518 jne 0x14102b2e4
0102b2cc 488b8168010000 mov rax, qword ptr [rcx + 0x168]
0102b2d3 4c8b8970010000 mov r9, qword ptr [rcx + 0x170]
0102b2da 4533c0 xor r8d, r8d
0102b2dd ba64646474 mov edx, 0x74646464
0102b2e2 ffd0 call rax
0102b2e4 0fb6742437 movzx esi, byte ptr [rsp + 0x37]
0102b2e9 4c8b7c2478 mov r15, qword ptr [rsp + 0x78]
0102b2ee 4c8b642448 mov r12, qword ptr [rsp + 0x48]
0102b2f3 488b5c2450 mov rbx, qword ptr [rsp + 0x50]
0102b2f8 488b7df0 mov rdi, qword ptr [rbp - 0x10]
0102b2fc 4885ff test rdi, rdi
0102b2ff 742d je 0x14102b32e
0102b301 813f54534c4f cmp dword ptr [rdi], 0x4f4c5354
0102b307 7525 jne 0x14102b32e
0102b309 8b4704 mov eax, dword ptr [rdi + 4]
0102b30c 85c0 test eax, eax
0102b30e 741e je 0x14102b32e
0102b310 83e801 sub eax, 1
0102b313 894704 mov dword ptr [rdi + 4], eax
0102b316 7516 jne 0x14102b32e
0102b318 488d4f08 lea rcx, [rdi + 8]
0102b31c e8df332bff call 0x1402de700
0102b321 ba20000000 mov edx, 0x20
0102b326 488bcf mov rcx, rdi
0102b329 e8f2b6b9ff call 0x140bc6a20
0102b32e 4885db test rbx, rbx
0102b331 742d je 0x14102b360
0102b333 813b54534c4f cmp dword ptr [rbx], 0x4f4c5354
0102b339 7525 jne 0x14102b360
0102b33b 8b4304 mov eax, dword ptr [rbx + 4]
0102b33e 85c0 test eax, eax
0102b340 741e je 0x14102b360
0102b342 83e801 sub eax, 1
0102b345 894304 mov dword ptr [rbx + 4], eax
0102b348 7516 jne 0x14102b360
0102b34a 488d4b08 lea rcx, [rbx + 8]
0102b34e e8ad332bff call 0x1402de700
0102b353 ba20000000 mov edx, 0x20
0102b358 488bcb mov rcx, rbx
0102b35b e8c0b6b9ff call 0x140bc6a20
0102b360 4d85e4 test r12, r12
0102b363 7434 je 0x14102b399
0102b365 41813c2454534c4f cmp dword ptr [r12], 0x4f4c5354
0102b36d 752a jne 0x14102b399
0102b36f 418b442404 mov eax, dword ptr [r12 + 4]
0102b374 85c0 test eax, eax
0102b376 7421 je 0x14102b399
0102b378 83e801 sub eax, 1
0102b37b 4189442404 mov dword ptr [r12 + 4], eax
0102b380 7517 jne 0x14102b399
0102b382 498d4c2408 lea rcx, [r12 + 8]
0102b387 e874332bff call 0x1402de700
0102b38c ba20000000 mov edx, 0x20
0102b391 498bcc mov rcx, r12
0102b394 e887b6b9ff call 0x140bc6a20
0102b399 4d85ff test r15, r15
0102b39c 0f84e0000000 je 0x14102b482
0102b3a2 41813f54534c4f cmp dword ptr [r15], 0x4f4c5354
0102b3a9 0f85d3000000 jne 0x14102b482
0102b3af 418b4704 mov eax, dword ptr [r15 + 4]
0102b3b3 85c0 test eax, eax
0102b3b5 0f84c7000000 je 0x14102b482
0102b3bb 83e801 sub eax, 1
0102b3be 41894704 mov dword ptr [r15 + 4], eax
0102b3c2 0f85ba000000 jne 0x14102b482
0102b3c8 498d4f08 lea rcx, [r15 + 8]
0102b3cc e82f332bff call 0x1402de700
0102b3d1 ba20000000 mov edx, 0x20
0102b3d6 498bcf mov rcx, r15
0102b3d9 e842b6b9ff call 0x140bc6a20
0102b3de e99f000000 jmp 0x14102b482
0102b3e3 4032f6 xor sil, sil
0102b3e6 488b4df8 mov rcx, qword ptr [rbp - 8]
0102b3ea bbffffffff mov ebx, 0xffffffff
0102b3ef 4885c9 test rcx, rcx
0102b3f2 7418 je 0x14102b40c
0102b3f4 8bc3 mov eax, ebx
0102b3f6 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102b3fb 83f801 cmp eax, 1
0102b3fe 750c jne 0x14102b40c
0102b400 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102b407 e8cc097700 call 0x14179bdd8
0102b40c 488b4d00 mov rcx, qword ptr [rbp]
0102b410 4885c9 test rcx, rcx
0102b413 7419 je 0x14102b42e
0102b415 8bc3 mov eax, ebx
0102b417 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102b41c 83f801 cmp eax, 1
0102b41f 750d jne 0x14102b42e
0102b421 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102b428 e8ab097700 call 0x14179bdd8
0102b42d 90 nop 
0102b42e 488b4d30 mov rcx, qword ptr [rbp + 0x30]
0102b432 4885c9 test rcx, rcx
0102b435 7418 je 0x14102b44f
0102b437 8bc3 mov eax, ebx
0102b439 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102b43e 83f801 cmp eax, 1
0102b441 750c jne 0x14102b44f
0102b443 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102b44a e889097700 call 0x14179bdd8
0102b44f 488b4d38 mov rcx, qword ptr [rbp + 0x38]
0102b453 4885c9 test rcx, rcx
0102b456 7419 je 0x14102b471
0102b458 8bc3 mov eax, ebx
0102b45a f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102b45f 83f801 cmp eax, 1
0102b462 750d jne 0x14102b471
0102b464 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102b46b e868097700 call 0x14179bdd8
0102b470 90 nop 
0102b471 488d4d10 lea rcx, [rbp + 0x10]
0102b475 e866b5aaff call 0x140ad69e0
0102b47a e96afeffff jmp 0x14102b2e9
0102b47f 4032f6 xor sil, sil
0102b482 488b4db0 mov rcx, qword ptr [rbp - 0x50]
0102b486 bbffffffff mov ebx, 0xffffffff
0102b48b 4885c9 test rcx, rcx
0102b48e 7418 je 0x14102b4a8
0102b490 8bc3 mov eax, ebx
0102b492 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102b497 83f801 cmp eax, 1
0102b49a 750c jne 0x14102b4a8
0102b49c c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102b4a3 e830097700 call 0x14179bdd8
0102b4a8 488b4db8 mov rcx, qword ptr [rbp - 0x48]
0102b4ac 4885c9 test rcx, rcx
0102b4af 7419 je 0x14102b4ca
0102b4b1 8bc3 mov eax, ebx
0102b4b3 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102b4b8 83f801 cmp eax, 1
0102b4bb 750d jne 0x14102b4ca
0102b4bd c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102b4c4 e80f097700 call 0x14179bdd8
0102b4c9 90 nop 
0102b4ca 488b4dd0 mov rcx, qword ptr [rbp - 0x30]
0102b4ce 4885c9 test rcx, rcx
0102b4d1 7418 je 0x14102b4eb
0102b4d3 8bc3 mov eax, ebx
0102b4d5 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102b4da 83f801 cmp eax, 1
0102b4dd 750c jne 0x14102b4eb
0102b4df c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102b4e6 e8ed087700 call 0x14179bdd8
0102b4eb 488b4dd8 mov rcx, qword ptr [rbp - 0x28]
0102b4ef 4885c9 test rcx, rcx
0102b4f2 7416 je 0x14102b50a
0102b4f4 f00fc15908 lock xadd dword ptr [rcx + 8], ebx
0102b4f9 83fb01 cmp ebx, 1
0102b4fc 750c jne 0x14102b50a
0102b4fe c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102b505 e8ce087700 call 0x14179bdd8
0102b50a 400fb6c6 movzx eax, sil
0102b50e 488b8de0040000 mov rcx, qword ptr [rbp + 0x4e0]
0102b515 4833cc xor rcx, rsp
0102b518 e8c3037700 call 0x14179b8e0
0102b51d 4c8d9c2410060000 lea r11, [rsp + 0x610]
0102b525 498b5b58 mov rbx, qword ptr [r11 + 0x58]
0102b529 410f2873f0 movaps xmm6, xmmword ptr [r11 - 0x10]
0102b52e 410f287be0 movaps xmm7, xmmword ptr [r11 - 0x20]
0102b533 498be3 mov rsp, r11
0102b536 415f pop r15
0102b538 415e pop r14
0102b53a 415d pop r13
0102b53c 415c pop r12
0102b53e 5f pop rdi
0102b53f 5e pop rsi
0102b540 5d pop rbp
0102b541 c3 ret 