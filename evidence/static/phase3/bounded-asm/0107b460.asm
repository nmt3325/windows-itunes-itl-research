0107b460 4055 push rbp
0107b462 56 push rsi
0107b463 4156 push r14
0107b465 4157 push r15
0107b467 488dac2468f9ffff lea rbp, [rsp - 0x698]
0107b46f 4881ec98070000 sub rsp, 0x798
0107b476 488b05c39bf500 mov rax, qword ptr [rip + 0xf59bc3]
0107b47d 4833c4 xor rax, rsp
0107b480 488985e0050000 mov qword ptr [rbp + 0x5e0], rax
0107b487 4c8bb97002e001 mov r15, qword ptr [rcx + 0x1e00270]
0107b48e 33c0 xor eax, eax
0107b490 89542448 mov dword ptr [rsp + 0x48], edx
0107b494 41b808000000 mov r8d, 8
0107b49a 488d9580030000 lea rdx, [rbp + 0x380]
0107b4a1 4c897c2438 mov qword ptr [rsp + 0x38], r15
0107b4a6 48894500 mov qword ptr [rbp], rax
0107b4aa 4c8bf1 mov r14, rcx
0107b4ad c644243000 mov byte ptr [rsp + 0x30], 0
0107b4b2 e8e9bbffff call 0x1410770a0
0107b4b7 8bf0 mov esi, eax
0107b4b9 85c0 test eax, eax
0107b4bb 0f85bd320000 jne 0x14107e77e
0107b4c1 448b9584030000 mov r10d, dword ptr [rbp + 0x384]
0107b4c8 48899c24c8070000 mov qword ptr [rsp + 0x7c8], rbx
0107b4d0 418bda mov ebx, r10d
0107b4d3 4889bc24d0070000 mov qword ptr [rsp + 0x7d0], rdi
0107b4db 4c89a424d8070000 mov qword ptr [rsp + 0x7d8], r12
0107b4e3 4d8d6652 lea r12, [r14 + 0x52]
0107b4e7 4c89ac2490070000 mov qword ptr [rsp + 0x790], r13
0107b4ef 41380424 cmp byte ptr [r12], al
0107b4f3 7502 jne 0x14107b4f7
0107b4f5 0fcb bswap ebx
0107b4f7 41bd5c000000 mov r13d, 0x5c
0107b4fd 488d8d88030000 lea rcx, [rbp + 0x388]
0107b504 413bdd cmp ebx, r13d
0107b507 418bfd mov edi, r13d
0107b50a 0f42fb cmovb edi, ebx
0107b50d 83ff08 cmp edi, 8
0107b510 7643 jbe 0x14107b555
0107b512 8d47f8 lea eax, [rdi - 8]
0107b515 4889442458 mov qword ptr [rsp + 0x58], rax
0107b51a 483d0000a000 cmp rax, 0xa00000
0107b520 0f8721010000 ja 0x14107b647
0107b526 448bc0 mov r8d, eax
0107b529 488d9588030000 lea rdx, [rbp + 0x388]
0107b530 498bce mov rcx, r14
0107b533 e868bbffff call 0x1410770a0
0107b538 8bf0 mov esi, eax
0107b53a 85c0 test eax, eax
0107b53c 0f851c320000 jne 0x14107e75e
0107b542 448b9584030000 mov r10d, dword ptr [rbp + 0x384]
0107b549 488d8d88030000 lea rcx, [rbp + 0x388]
0107b550 48034c2458 add rcx, qword ptr [rsp + 0x58]
0107b555 413bfd cmp edi, r13d
0107b558 7319 jae 0x14107b573
0107b55a 4885c9 test rcx, rcx
0107b55d 7414 je 0x14107b573
0107b55f 442bef sub r13d, edi
0107b562 33d2 xor edx, edx
0107b564 458bc5 mov r8d, r13d
0107b567 e834177200 call 0x14179cca0
0107b56c 448b9584030000 mov r10d, dword ptr [rbp + 0x384]
0107b573 3bdf cmp ebx, edi
0107b575 7616 jbe 0x14107b58d
0107b577 2bdf sub ebx, edi
0107b579 498bce mov rcx, r14
0107b57c 8bd3 mov edx, ebx
0107b57e e89deffeff call 0x14106a520
0107b583 8bf0 mov esi, eax
0107b585 85c0 test eax, eax
0107b587 0f85d1310000 jne 0x14107e75e
0107b58d 4533ed xor r13d, r13d
0107b590 418bf5 mov esi, r13d
0107b593 41383424 cmp byte ptr [r12], sil
0107b597 0f8595000000 jne 0x14107b632
0107b59d 8b8d80030000 mov ecx, dword ptr [rbp + 0x380]
0107b5a3 8bd1 mov edx, ecx
0107b5a5 8bc1 mov eax, ecx
0107b5a7 81e20000ff00 and edx, 0xff0000
0107b5ad c1e810 shr eax, 0x10
0107b5b0 0bd0 or edx, eax
0107b5b2 8bc1 mov eax, ecx
0107b5b4 2500ff0000 and eax, 0xff00
0107b5b9 c1e110 shl ecx, 0x10
0107b5bc 0bc1 or eax, ecx
0107b5be c1ea08 shr edx, 8
0107b5c1 c1e008 shl eax, 8
0107b5c4 418bca mov ecx, r10d
0107b5c7 0bd0 or edx, eax
0107b5c9 81e10000ff00 and ecx, 0xff0000
0107b5cf 418bc2 mov eax, r10d
0107b5d2 899580030000 mov dword ptr [rbp + 0x380], edx
0107b5d8 c1e810 shr eax, 0x10
0107b5db 0bc8 or ecx, eax
0107b5dd 418bc2 mov eax, r10d
0107b5e0 c1e010 shl eax, 0x10
0107b5e3 4181e200ff0000 and r10d, 0xff00
0107b5ea 410bc2 or eax, r10d
0107b5ed c1e908 shr ecx, 8
0107b5f0 c1e008 shl eax, 8
0107b5f3 0bc8 or ecx, eax
0107b5f5 898d84030000 mov dword ptr [rbp + 0x384], ecx
0107b5fb 8b8d88030000 mov ecx, dword ptr [rbp + 0x388]
0107b601 448bc1 mov r8d, ecx
0107b604 4181e00000ff00 and r8d, 0xff0000
0107b60b 8bc1 mov eax, ecx
0107b60d c1e810 shr eax, 0x10
0107b610 440bc0 or r8d, eax
0107b613 8bc1 mov eax, ecx
0107b615 2500ff0000 and eax, 0xff00
0107b61a c1e110 shl ecx, 0x10
0107b61d 0bc1 or eax, ecx
0107b61f 41c1e808 shr r8d, 8
0107b623 c1e008 shl eax, 8
0107b626 440bc0 or r8d, eax
0107b629 44898588030000 mov dword ptr [rbp + 0x388], r8d
0107b630 eb0d jmp 0x14107b63f
0107b632 448b8588030000 mov r8d, dword ptr [rbp + 0x388]
0107b639 8b9580030000 mov edx, dword ptr [rbp + 0x380]
0107b63f 81fa6d6c7468 cmp edx, 0x68746c6d
0107b645 740a je 0x14107b651
0107b647 be30ffffff mov esi, 0xffffff30
0107b64c e90d310000 jmp 0x14107e75e
0107b651 0f29b42480070000 movaps xmmword ptr [rsp + 0x780], xmm6
0107b659 0f29bc2470070000 movaps xmmword ptr [rsp + 0x770], xmm7
0107b661 440f29842460070000 movaps xmmword ptr [rsp + 0x760], xmm8
0107b66a 440f298c2450070000 movaps xmmword ptr [rsp + 0x750], xmm9
0107b673 440f29942440070000 movaps xmmword ptr [rsp + 0x740], xmm10
0107b67c 440f299c2430070000 movaps xmmword ptr [rsp + 0x730], xmm11
0107b685 440f29a42420070000 movaps xmmword ptr [rsp + 0x720], xmm12
0107b68e 440f29ac2410070000 movaps xmmword ptr [rsp + 0x710], xmm13
0107b697 440f29b42400070000 movaps xmmword ptr [rsp + 0x700], xmm14
0107b6a0 440f29bc24f0060000 movaps xmmword ptr [rsp + 0x6f0], xmm15
0107b6a9 44896df4 mov dword ptr [rbp - 0xc], r13d
0107b6ad 4585c0 test r8d, r8d
0107b6b0 0f84e32f0000 je 0x14107e699
0107b6b6 66440f6f059196bf00 movdqa xmm8, xmmword ptr [rip + 0xbf9691]
0107b6bf 0f57f6 xorps xmm6, xmm6
0107b6c2 66440f6f0dd597bf00 movdqa xmm9, xmmword ptr [rip + 0xbf97d5]
0107b6cb 66440f6f156c97bf00 movdqa xmm10, xmmword ptr [rip + 0xbf976c]
0107b6d4 66440f6f1dd396bf00 movdqa xmm11, xmmword ptr [rip + 0xbf96d3]
0107b6dd 66440f6f25aa97bf00 movdqa xmm12, xmmword ptr [rip + 0xbf97aa]
0107b6e6 66440f6f2d4197bf00 movdqa xmm13, xmmword ptr [rip + 0xbf9741]
0107b6ef 66440f6f353896bf00 movdqa xmm14, xmmword ptr [rip + 0xbf9638]
0107b6f8 66440f6f3d7f97bf00 movdqa xmm15, xmmword ptr [rip + 0xbf977f]
0107b701 f30f103dcb78bf00 movss xmm7, dword ptr [rip + 0xbf78cb]
0107b709 0f1f8000000000 nop dword ptr [rax]
0107b710 0f57c0 xorps xmm0, xmm0
0107b713 488d5540 lea rdx, [rbp + 0x40]
0107b717 41b501 mov r13b, 1
0107b71a 41b808000000 mov r8d, 8
0107b720 498bce mov rcx, r14
0107b723 44886c2444 mov byte ptr [rsp + 0x44], r13b
0107b728 0f118540030000 movups xmmword ptr [rbp + 0x340], xmm0
0107b72f 0f118550030000 movups xmmword ptr [rbp + 0x350], xmm0
0107b736 e865b9ffff call 0x1410770a0
0107b73b 8bf0 mov esi, eax
0107b73d 85c0 test eax, eax
0107b73f 0f85c12f0000 jne 0x14107e706
0107b745 8b5d44 mov ebx, dword ptr [rbp + 0x44]
0107b748 8bcb mov ecx, ebx
0107b74a 41380424 cmp byte ptr [r12], al
0107b74e 7522 jne 0x14107b772
0107b750 81e30000ff00 and ebx, 0xff0000
0107b756 8bc1 mov eax, ecx
0107b758 c1e810 shr eax, 0x10
0107b75b 0bd8 or ebx, eax
0107b75d 8bc1 mov eax, ecx
0107b75f c1e010 shl eax, 0x10
0107b762 81e100ff0000 and ecx, 0xff00
0107b768 0bc1 or eax, ecx
0107b76a c1eb08 shr ebx, 8
0107b76d c1e008 shl eax, 8
0107b770 0bd8 or ebx, eax
0107b772 bff4020000 mov edi, 0x2f4
0107b777 488d4d48 lea rcx, [rbp + 0x48]
0107b77b 3bdf cmp ebx, edi
0107b77d 0f42fb cmovb edi, ebx
0107b780 83ff08 cmp edi, 8
0107b783 7637 jbe 0x14107b7bc
0107b785 448d6ff8 lea r13d, [rdi - 8]
0107b789 4981fd0000a000 cmp r13, 0xa00000
0107b790 0f8711300000 ja 0x14107e7a7
0107b796 458bc5 mov r8d, r13d
0107b799 488d5548 lea rdx, [rbp + 0x48]
0107b79d 498bce mov rcx, r14
0107b7a0 e8fbb8ffff call 0x1410770a0
0107b7a5 8bf0 mov esi, eax
0107b7a7 85c0 test eax, eax
0107b7a9 0f85572f0000 jne 0x14107e706
0107b7af 488d4d48 lea rcx, [rbp + 0x48]
0107b7b3 4903cd add rcx, r13
0107b7b6 440fb66c2444 movzx r13d, byte ptr [rsp + 0x44]
0107b7bc 81fff4020000 cmp edi, 0x2f4
0107b7c2 7315 jae 0x14107b7d9
0107b7c4 4885c9 test rcx, rcx
0107b7c7 7410 je 0x14107b7d9
0107b7c9 41b8f4020000 mov r8d, 0x2f4
0107b7cf 33d2 xor edx, edx
0107b7d1 442bc7 sub r8d, edi
0107b7d4 e8c7147200 call 0x14179cca0
0107b7d9 3bdf cmp ebx, edi
0107b7db 7616 jbe 0x14107b7f3
0107b7dd 2bdf sub ebx, edi
0107b7df 498bce mov rcx, r14
0107b7e2 8bd3 mov edx, ebx
0107b7e4 e837edfeff call 0x14106a520
0107b7e9 8bf0 mov esi, eax
0107b7eb 85c0 test eax, eax
0107b7ed 0f85132f0000 jne 0x14107e706
0107b7f3 33c9 xor ecx, ecx
0107b7f5 488d5540 lea rdx, [rbp + 0x40]
0107b7f9 8bf1 mov esi, ecx
0107b7fb 498bce mov rcx, r14
0107b7fe e84dd9feff call 0x141069150
0107b803 817d406d697468 cmp dword ptr [rbp + 0x40], 0x6874696d
0107b80a 0f85972f0000 jne 0x14107e7a7
0107b810 8b4554 mov eax, dword ptr [rbp + 0x54]
0107b813 83e801 sub eax, 1
0107b816 7423 je 0x14107b83b
0107b818 83e801 sub eax, 1
0107b81b 7417 je 0x14107b834
0107b81d 4533c0 xor r8d, r8d
0107b820 83f801 cmp eax, 1
0107b823 7408 je 0x14107b82d
0107b825 418bd8 mov ebx, r8d
0107b828 4532ed xor r13b, r13b
0107b82b eb16 jmp 0x14107b843
0107b82d bb44524853 mov ebx, 0x53485244
0107b832 eb0f jmp 0x14107b843
0107b834 bb50545448 mov ebx, 0x48545450
0107b839 eb05 jmp 0x14107b840
0107b83b bb454c4946 mov ebx, 0x46494c45
0107b840 4533c0 xor r8d, r8d
0107b843 4138b6f202e001 cmp byte ptr [r14 + 0x1e002f2], sil
0107b84a 740c je 0x14107b858
0107b84c 81fb44524853 cmp ebx, 0x53485244
0107b852 0f84e22d0000 je 0x14107e63a
0107b858 4584ed test r13b, r13b
0107b85b 0f84d92d0000 je 0x14107e63a
0107b861 0f57c0 xorps xmm0, xmm0
0107b864 0f57c9 xorps xmm1, xmm1
0107b867 498bf8 mov rdi, r8
0107b86a 660f7f45b0 movdqa xmmword ptr [rbp - 0x50], xmm0
0107b86f 4d8be8 mov r13, r8
0107b872 660f7f4dc0 movdqa xmmword ptr [rbp - 0x40], xmm1
0107b877 660f7f45d0 movdqa xmmword ptr [rbp - 0x30], xmm0
0107b87c 448945f0 mov dword ptr [rbp - 0x10], r8d
0107b880 4138b6a801e001 cmp byte ptr [r14 + 0x1e001a8], sil
0107b887 7421 je 0x14107b8aa
0107b889 498d8ec002e001 lea rcx, [r14 + 0x1e002c0]
0107b890 488d951c010000 lea rdx, [rbp + 0x11c]
0107b897 e8e47e61ff call 0x140693780
0107b89c 4885c0 test rax, rax
0107b89f 7505 jne 0x14107b8a6
0107b8a1 488bf8 mov rdi, rax
0107b8a4 eb04 jmp 0x14107b8aa
0107b8a6 488b7808 mov rdi, qword ptr [rax + 8]
0107b8aa 4138b6a901e001 cmp byte ptr [r14 + 0x1e001a9], sil
0107b8b1 7421 je 0x14107b8d4
0107b8b3 498d8ed802e001 lea rcx, [r14 + 0x1e002d8]
0107b8ba 488d9520020000 lea rdx, [rbp + 0x220]
0107b8c1 e8ba7e61ff call 0x140693780
0107b8c6 4885c0 test rax, rax
0107b8c9 7505 jne 0x14107b8d0
0107b8cb 4c8be8 mov r13, rax
0107b8ce eb04 jmp 0x14107b8d4
0107b8d0 4c8b6808 mov r13, qword ptr [rax + 8]
0107b8d4 837c244801 cmp dword ptr [rsp + 0x48], 1
0107b8d9 7536 jne 0x14107b911
0107b8db 498d8e9002e001 lea rcx, [r14 + 0x1e00290]
0107b8e2 488d95c0000000 lea rdx, [rbp + 0xc0]
0107b8e9 e882253bff call 0x14042de70
0107b8ee 4885c0 test rax, rax
0107b8f1 741e je 0x14107b911
0107b8f3 48397008 cmp qword ptr [rax + 8], rsi
0107b8f7 7418 je 0x14107b911
0107b8f9 33c9 xor ecx, ecx
0107b8fb e8809fb2ff call 0x140ba5880
0107b900 488985c0000000 mov qword ptr [rbp + 0xc0], rax
0107b907 41c686f102e00101 mov byte ptr [r14 + 0x1e002f1], 1
0107b90f eb07 jmp 0x14107b918
0107b911 488b85c0000000 mov rax, qword ptr [rbp + 0xc0]
0107b918 4889442428 mov qword ptr [rsp + 0x28], rax
0107b91d 4d8bcd mov r9, r13
0107b920 8b85b8000000 mov eax, dword ptr [rbp + 0xb8]
0107b926 4c8bc7 mov r8, rdi
0107b929 8bd3 mov edx, ebx
0107b92b 89442420 mov dword ptr [rsp + 0x20], eax
0107b92f 498bcf mov rcx, r15
0107b932 e84972f1ff call 0x140f92b80
0107b937 4889442450 mov qword ptr [rsp + 0x50], rax
0107b93c 488bd8 mov rbx, rax
0107b93f 4885c0 test rax, rax
0107b942 0f84552e0000 je 0x14107e79d
0107b948 488b7b58 mov rdi, qword ptr [rbx + 0x58]
0107b94c 488b4500 mov rax, qword ptr [rbp]
0107b950 4885c0 test rax, rax
0107b953 48897df8 mov qword ptr [rbp - 8], rdi
0107b957 480f44c3 cmove rax, rbx
0107b95b 48894500 mov qword ptr [rbp], rax
0107b95f 8b8534020000 mov eax, dword ptr [rbp + 0x234]
0107b965 85c0 test eax, eax
0107b967 0f444550 cmove eax, dword ptr [rbp + 0x50]
0107b96b 898534020000 mov dword ptr [rbp + 0x234], eax
0107b971 8b4560 mov eax, dword ptr [rbp + 0x60]
0107b974 894754 mov dword ptr [rdi + 0x54], eax
0107b977 8b4568 mov eax, dword ptr [rbp + 0x68]
0107b97a 89475c mov dword ptr [rdi + 0x5c], eax
0107b97d 0fb7456c movzx eax, word ptr [rbp + 0x6c]
0107b981 6689830a010000 mov word ptr [rbx + 0x10a], ax
0107b988 0fb74570 movzx eax, word ptr [rbp + 0x70]
0107b98c 6689830c010000 mov word ptr [rbx + 0x10c], ax
0107b993 0fb785a8000000 movzx eax, word ptr [rbp + 0xa8]
0107b99a 6689830e010000 mov word ptr [rbx + 0x10e], ax
0107b9a1 0fb785aa000000 movzx eax, word ptr [rbp + 0xaa]
0107b9a8 66898310010000 mov word ptr [rbx + 0x110], ax
0107b9af 0fb74574 movzx eax, word ptr [rbp + 0x74]
0107b9b3 668983a6000000 mov word ptr [rbx + 0xa6], ax
0107b9ba 0fb685ac000000 movzx eax, byte ptr [rbp + 0xac]
0107b9c1 888304010000 mov byte ptr [rbx + 0x104], al
0107b9c7 0fb6839b000000 movzx eax, byte ptr [rbx + 0x9b]
0107b9ce 0fb68d93000000 movzx ecx, byte ptr [rbp + 0x93]
0107b9d5 24fb and al, 0xfb
0107b9d7 80e101 and cl, 1
0107b9da c0e102 shl cl, 2
0107b9dd 0ac8 or cl, al
0107b9df 888b9b000000 mov byte ptr [rbx + 0x9b], cl
0107b9e5 0fb6839a000000 movzx eax, byte ptr [rbx + 0x9a]
0107b9ec 0fb68dad000000 movzx ecx, byte ptr [rbp + 0xad]
0107b9f3 24ef and al, 0xef
0107b9f5 80e101 and cl, 1
0107b9f8 c0e104 shl cl, 4
0107b9fb 0ac8 or cl, al
0107b9fd 888b9a000000 mov byte ptr [rbx + 0x9a], cl
0107ba03 0fb74578 movzx eax, word ptr [rbp + 0x78]
0107ba07 6689474c mov word ptr [rdi + 0x4c], ax
0107ba0b f30f1085d8000000 movss xmm0, dword ptr [rbp + 0xd8]
0107ba13 f30f114748 movss dword ptr [rdi + 0x48], xmm0
0107ba18 0fb7854a020000 movzx eax, word ptr [rbp + 0x24a]
0107ba1f 6689474e mov word ptr [rdi + 0x4e], ax
0107ba23 0fb78580000000 movzx eax, word ptr [rbp + 0x80]
0107ba2a 66898302010000 mov word ptr [rbx + 0x102], ax
0107ba31 8b85b4000000 mov eax, dword ptr [rbp + 0xb4]
0107ba37 8983fc000000 mov dword ptr [rbx + 0xfc], eax
0107ba3d 0fb78d90000000 movzx ecx, word ptr [rbp + 0x90]
0107ba44 e847effeff call 0x14106a990
0107ba49 66894750 mov word ptr [rdi + 0x50], ax
0107ba4d 0fb6839a000000 movzx eax, byte ptr [rbx + 0x9a]
0107ba54 0fb68dae000000 movzx ecx, byte ptr [rbp + 0xae]
0107ba5b 24fb and al, 0xfb
0107ba5d 80e101 and cl, 1
0107ba60 c0e102 shl cl, 2
0107ba63 0ac8 or cl, al
0107ba65 888b9a000000 mov byte ptr [rbx + 0x9a], cl
0107ba6b 0fb785d0000000 movzx eax, word ptr [rbp + 0xd0]
0107ba72 6689476c mov word ptr [rdi + 0x6c], ax
0107ba76 0fb785d2000000 movzx eax, word ptr [rbp + 0xd2]
0107ba7d 6689476e mov word ptr [rdi + 0x6e], ax
0107ba81 8b85d4000000 mov eax, dword ptr [rbp + 0xd4]
0107ba87 894770 mov dword ptr [rdi + 0x70], eax
0107ba8a 0fb68de7000000 movzx ecx, byte ptr [rbp + 0xe7]
0107ba91 0fb6839b000000 movzx eax, byte ptr [rbx + 0x9b]
0107ba98 80e101 and cl, 1
0107ba9b 24f7 and al, 0xf7
0107ba9d c0e103 shl cl, 3
0107baa0 0ac8 or cl, al
0107baa2 888b9b000000 mov byte ptr [rbx + 0x9b], cl
0107baa8 80e1ef and cl, 0xef
0107baab 0fb68571020000 movzx eax, byte ptr [rbp + 0x271]
0107bab2 2401 and al, 1
0107bab4 c0e004 shl al, 4
0107bab7 0ac1 or al, cl
0107bab9 88839b000000 mov byte ptr [rbx + 0x9b], al
0107babf 0fb68d09010000 movzx ecx, byte ptr [rbp + 0x109]
0107bac6 80e101 and cl, 1
0107bac9 0fb64741 movzx eax, byte ptr [rdi + 0x41]
0107bacd 24fe and al, 0xfe
0107bacf 0ac8 or cl, al
0107bad1 884f41 mov byte ptr [rdi + 0x41], cl
0107bad4 80e1f7 and cl, 0xf7
0107bad7 0fb6851d020000 movzx eax, byte ptr [rbp + 0x21d]
0107bade 2401 and al, 1
0107bae0 c0e003 shl al, 3
0107bae3 0ac1 or al, cl
0107bae5 884741 mov byte ptr [rdi + 0x41], al
0107bae8 0fb685af000000 movzx eax, byte ptr [rbp + 0xaf]
0107baef 884744 mov byte ptr [rdi + 0x44], al
0107baf2 0fb68568010000 movzx eax, byte ptr [rbp + 0x168]
0107baf9 88473f mov byte ptr [rdi + 0x3f], al
0107bafc 0fb785e4000000 movzx eax, word ptr [rbp + 0xe4]
0107bb03 6689832c010000 mov word ptr [rbx + 0x12c], ax
0107bb0a 0fb685e6000000 movzx eax, byte ptr [rbp + 0xe6]
0107bb11 888390000000 mov byte ptr [rbx + 0x90], al
0107bb17 0fb6839c000000 movzx eax, byte ptr [rbx + 0x9c]
0107bb1e 0fb68d08010000 movzx ecx, byte ptr [rbp + 0x108]
0107bb25 24ef and al, 0xef
0107bb27 80e101 and cl, 1
0107bb2a c0e104 shl cl, 4
0107bb2d 0ac8 or cl, al
0107bb2f 888b9c000000 mov byte ptr [rbx + 0x9c], cl
0107bb35 488b850c010000 mov rax, qword ptr [rbp + 0x10c]
0107bb3c 488987d8020000 mov qword ptr [rdi + 0x2d8], rax
0107bb43 0fb6839d000000 movzx eax, byte ptr [rbx + 0x9d]
0107bb4a 0fb68d0a010000 movzx ecx, byte ptr [rbp + 0x10a]
0107bb51 24f7 and al, 0xf7
0107bb53 80e101 and cl, 1
0107bb56 c0e103 shl cl, 3
0107bb59 0ac8 or cl, al
0107bb5b 888b9d000000 mov byte ptr [rbx + 0x9d], cl
0107bb61 0fb6839b000000 movzx eax, byte ptr [rbx + 0x9b]
0107bb68 0fb68d0b010000 movzx ecx, byte ptr [rbp + 0x10b]
0107bb6f 24bf and al, 0xbf
0107bb71 80e101 and cl, 1
0107bb74 c0e106 shl cl, 6
0107bb77 0ac8 or cl, al
0107bb79 888b9b000000 mov byte ptr [rbx + 0x9b], cl
0107bb7f 80e17f and cl, 0x7f
0107bb82 0fb68528010000 movzx eax, byte ptr [rbp + 0x128]
0107bb89 c0e007 shl al, 7
0107bb8c 0ac8 or cl, al
0107bb8e 888b9b000000 mov byte ptr [rbx + 0x9b], cl
0107bb94 0fb6839d000000 movzx eax, byte ptr [rbx + 0x9d]
0107bb9b 0fb68d2a010000 movzx ecx, byte ptr [rbp + 0x12a]
0107bba2 24fe and al, 0xfe
0107bba4 80e101 and cl, 1
0107bba7 0ac8 or cl, al
0107bba9 888b9d000000 mov byte ptr [rbx + 0x9d], cl
0107bbaf 80e1fd and cl, 0xfd
0107bbb2 0fb6852d010000 movzx eax, byte ptr [rbp + 0x12d]
0107bbb9 2401 and al, 1
0107bbbb 02c0 add al, al
0107bbbd 0ac1 or al, cl
0107bbbf 88839d000000 mov byte ptr [rbx + 0x9d], al
0107bbc5 0fb6839c000000 movzx eax, byte ptr [rbx + 0x9c]
0107bbcc 0fb68d29010000 movzx ecx, byte ptr [rbp + 0x129]
0107bbd3 24fd and al, 0xfd
0107bbd5 80e101 and cl, 1
0107bbd8 02c9 add cl, cl
0107bbda 0ac8 or cl, al
0107bbdc 888b9c000000 mov byte ptr [rbx + 0x9c], cl
0107bbe2 8b8530010000 mov eax, dword ptr [rbp + 0x130]
0107bbe8 8987f4020000 mov dword ptr [rdi + 0x2f4], eax
0107bbee 8b8540010000 mov eax, dword ptr [rbp + 0x140]
0107bbf4 8987f8020000 mov dword ptr [rdi + 0x2f8], eax
0107bbfa 488b8534010000 mov rax, qword ptr [rbp + 0x134]
0107bc01 488987e0020000 mov qword ptr [rdi + 0x2e0], rax
0107bc08 488b8560010000 mov rax, qword ptr [rbp + 0x160]
0107bc0f 488987e8020000 mov qword ptr [rdi + 0x2e8], rax
0107bc16 8b8544010000 mov eax, dword ptr [rbp + 0x144]
0107bc1c 8987f0020000 mov dword ptr [rdi + 0x2f0], eax
0107bc22 0fb78598000000 movzx eax, word ptr [rbp + 0x98]
0107bc29 66894752 mov word ptr [rdi + 0x52], ax
0107bc2d 8b8500010000 mov eax, dword ptr [rbp + 0x100]
0107bc33 894768 mov dword ptr [rdi + 0x68], eax
0107bc36 0fb78504010000 movzx eax, word ptr [rbp + 0x104]
0107bc3d 66898300010000 mov word ptr [rbx + 0x100], ax
0107bc44 0fb6839d000000 movzx eax, byte ptr [rbx + 0x9d]
0107bc4b 0fb68d2b010000 movzx ecx, byte ptr [rbp + 0x12b]
0107bc52 24bf and al, 0xbf
0107bc54 80e101 and cl, 1
0107bc57 c0e106 shl cl, 6
0107bc5a 0ac8 or cl, al
0107bc5c 888b9d000000 mov byte ptr [rbx + 0x9d], cl
0107bc62 80e1df and cl, 0xdf
0107bc65 0fb68554020000 movzx eax, byte ptr [rbp + 0x254]
0107bc6c 2401 and al, 1
0107bc6e c0e005 shl al, 5
0107bc71 0ac1 or al, cl
0107bc73 88839d000000 mov byte ptr [rbx + 0x9d], al
0107bc79 0fb68555020000 movzx eax, byte ptr [rbp + 0x255]
0107bc80 0fb68b9a000000 movzx ecx, byte ptr [rbx + 0x9a]
0107bc87 c0e007 shl al, 7
0107bc8a 80e17f and cl, 0x7f
0107bc8d 0ac8 or cl, al
0107bc8f 888b9a000000 mov byte ptr [rbx + 0x9a], cl
0107bc95 0fb6839d000000 movzx eax, byte ptr [rbx + 0x9d]
0107bc9c 0fb68d2c010000 movzx ecx, byte ptr [rbp + 0x12c]
0107bca3 247f and al, 0x7f
0107bca5 c0e107 shl cl, 7
0107bca8 0ac8 or cl, al
0107bcaa 888b9d000000 mov byte ptr [rbx + 0x9d], cl
0107bcb0 0fb6839e000000 movzx eax, byte ptr [rbx + 0x9e]
0107bcb7 0fb68dbd020000 movzx ecx, byte ptr [rbp + 0x2bd]
0107bcbe 24fe and al, 0xfe
0107bcc0 80e101 and cl, 1
0107bcc3 0ac8 or cl, al
0107bcc5 888b9e000000 mov byte ptr [rbx + 0x9e], cl
0107bccb 0fb6839f000000 movzx eax, byte ptr [rbx + 0x9f]
0107bcd2 0fb68dbe020000 movzx ecx, byte ptr [rbp + 0x2be]
0107bcd9 24ef and al, 0xef
0107bcdb 80e101 and cl, 1
0107bcde c0e104 shl cl, 4
0107bce1 0ac8 or cl, al
0107bce3 888b9f000000 mov byte ptr [rbx + 0x9f], cl
0107bce9 80e1df and cl, 0xdf
0107bcec 0fb685bf020000 movzx eax, byte ptr [rbp + 0x2bf]
0107bcf3 2401 and al, 1
0107bcf5 c0e005 shl al, 5
0107bcf8 0ac1 or al, cl
0107bcfa 88839f000000 mov byte ptr [rbx + 0x9f], al
0107bd00 0fb6839e000000 movzx eax, byte ptr [rbx + 0x9e]
0107bd07 0fb68d2f010000 movzx ecx, byte ptr [rbp + 0x12f]
0107bd0e 24fd and al, 0xfd
0107bd10 80e101 and cl, 1
0107bd13 02c9 add cl, cl
0107bd15 0ac8 or cl, al
0107bd17 888b9e000000 mov byte ptr [rbx + 0x9e], cl
0107bd1d 80e1fb and cl, 0xfb
0107bd20 0fb6852e010000 movzx eax, byte ptr [rbp + 0x12e]
0107bd27 2401 and al, 1
0107bd29 c0e002 shl al, 2
0107bd2c 0ac1 or al, cl
0107bd2e 88839e000000 mov byte ptr [rbx + 0x9e], al
0107bd34 8b853c010000 mov eax, dword ptr [rbp + 0x13c]
0107bd3a 894774 mov dword ptr [rdi + 0x74], eax
0107bd3d 8b85d0020000 mov eax, dword ptr [rbp + 0x2d0]
0107bd43 8983e0000000 mov dword ptr [rbx + 0xe0], eax
0107bd49 8b85d4020000 mov eax, dword ptr [rbp + 0x2d4]
0107bd4f 8983e4000000 mov dword ptr [rbx + 0xe4], eax
0107bd55 8b85d8020000 mov eax, dword ptr [rbp + 0x2d8]
0107bd5b 8983e8000000 mov dword ptr [rbx + 0xe8], eax
0107bd61 8b85dc020000 mov eax, dword ptr [rbp + 0x2dc]
0107bd67 8983ec000000 mov dword ptr [rbx + 0xec], eax
0107bd6d 8b85e0020000 mov eax, dword ptr [rbp + 0x2e0]
0107bd73 8983f0000000 mov dword ptr [rbx + 0xf0], eax
0107bd79 8b85e4020000 mov eax, dword ptr [rbp + 0x2e4]
0107bd7f 8983f4000000 mov dword ptr [rbx + 0xf4], eax
0107bd85 8b85e8020000 mov eax, dword ptr [rbp + 0x2e8]
0107bd8b 8983f8000000 mov dword ptr [rbx + 0xf8], eax
0107bd91 0fb68d54010000 movzx ecx, byte ptr [rbp + 0x154]
0107bd98 0fb6839e000000 movzx eax, byte ptr [rbx + 0x9e]
0107bd9f 80e101 and cl, 1
0107bda2 c0e103 shl cl, 3
0107bda5 24f7 and al, 0xf7
0107bda7 0ac8 or cl, al
0107bda9 888b9e000000 mov byte ptr [rbx + 0x9e], cl
0107bdaf 0fb68b9c000000 movzx ecx, byte ptr [rbx + 0x9c]
0107bdb6 0fb68556010000 movzx eax, byte ptr [rbp + 0x156]
0107bdbd 80e1fe and cl, 0xfe
0107bdc0 2401 and al, 1
0107bdc2 0ac8 or cl, al
0107bdc4 888b9c000000 mov byte ptr [rbx + 0x9c], cl
0107bdca 488bcb mov rcx, rbx
0107bdcd 8b8518010000 mov eax, dword ptr [rbp + 0x118]
0107bdd3 898320010000 mov dword ptr [rbx + 0x120], eax
0107bdd9 8b8558010000 mov eax, dword ptr [rbp + 0x158]
0107bddf 898324010000 mov dword ptr [rbx + 0x124], eax
0107bde5 8b855c010000 mov eax, dword ptr [rbp + 0x15c]
0107bdeb 898328010000 mov dword ptr [rbx + 0x128], eax
0107bdf1 0fb69569010000 movzx edx, byte ptr [rbp + 0x169]
0107bdf8 e8336df2ff call 0x140fa2b30
0107bdfd 488b8574010000 mov rax, qword ptr [rbp + 0x174]
0107be04 48898340010000 mov qword ptr [rbx + 0x140], rax
0107be0b 488b857c010000 mov rax, qword ptr [rbp + 0x17c]
0107be12 48898348010000 mov qword ptr [rbx + 0x148], rax
0107be19 0fb6839c000000 movzx eax, byte ptr [rbx + 0x9c]
0107be20 0fb68d1f020000 movzx ecx, byte ptr [rbp + 0x21f]
0107be27 24f7 and al, 0xf7
0107be29 80e101 and cl, 1
0107be2c c0e103 shl cl, 3
0107be2f 0ac8 or cl, al
0107be31 888b9c000000 mov byte ptr [rbx + 0x9c], cl
0107be37 0fb64742 movzx eax, byte ptr [rdi + 0x42]
0107be3b 0fb68dae020000 movzx ecx, byte ptr [rbp + 0x2ae]
0107be42 24df and al, 0xdf
0107be44 80e101 and cl, 1
0107be47 c0e105 shl cl, 5
0107be4a 0ac8 or cl, al
0107be4c 884f42 mov byte ptr [rdi + 0x42], cl
0107be4f 0fb6839f000000 movzx eax, byte ptr [rbx + 0x9f]
0107be56 0fb68daf020000 movzx ecx, byte ptr [rbp + 0x2af]
0107be5d 24fb and al, 0xfb
0107be5f 80e101 and cl, 1
0107be62 c0e102 shl cl, 2
0107be65 0ac8 or cl, al
0107be67 888b9f000000 mov byte ptr [rbx + 0x9f], cl
0107be6d 488b8524020000 mov rax, qword ptr [rbp + 0x224]
0107be74 48898350010000 mov qword ptr [rbx + 0x150], rax
0107be7b 8b8530020000 mov eax, dword ptr [rbp + 0x230]
0107be81 898358010000 mov dword ptr [rbx + 0x158], eax
0107be87 8b8560020000 mov eax, dword ptr [rbp + 0x260]
0107be8d 89835c010000 mov dword ptr [rbx + 0x15c], eax
0107be93 488b853c020000 mov rax, qword ptr [rbp + 0x23c]
0107be9a 48898338010000 mov qword ptr [rbx + 0x138], rax
0107bea1 488b8584010000 mov rax, qword ptr [rbp + 0x184]
0107bea8 48894760 mov qword ptr [rdi + 0x60], rax
0107beac 4839b584010000 cmp qword ptr [rbp + 0x184], rsi
0107beb3 7507 jne 0x14107bebc
0107beb5 8b4564 mov eax, dword ptr [rbp + 0x64]
0107beb8 48894760 mov qword ptr [rdi + 0x60], rax
0107bebc 0fb64740 movzx eax, byte ptr [rdi + 0x40]
0107bec0 0fb68d57010000 movzx ecx, byte ptr [rbp + 0x157]
0107bec7 24f7 and al, 0xf7
0107bec9 80e101 and cl, 1
0107becc c0e103 shl cl, 3
0107becf 0ac8 or cl, al
0107bed1 884f40 mov byte ptr [rdi + 0x40], cl
0107bed4 0fb68570020000 movzx eax, byte ptr [rbp + 0x270]
0107bedb 88473e mov byte ptr [rdi + 0x3e], al
0107bede 8b85cc000000 mov eax, dword ptr [rbp + 0xcc]
0107bee4 894738 mov dword ptr [rdi + 0x38], eax
0107bee7 0fb64741 movzx eax, byte ptr [rdi + 0x41]
0107beeb 0fb64d59 movzx ecx, byte ptr [rbp + 0x59]
0107beef 24ef and al, 0xef
0107bef1 80e101 and cl, 1
0107bef4 c0e104 shl cl, 4
0107bef7 0ac8 or cl, al
0107bef9 884f41 mov byte ptr [rdi + 0x41], cl
0107befc 80e1df and cl, 0xdf
0107beff 0fb69556020000 movzx edx, byte ptr [rbp + 0x256]
0107bf06 80e201 and dl, 1
0107bf09 c0e205 shl dl, 5
0107bf0c 0ad1 or dl, cl
0107bf0e 885741 mov byte ptr [rdi + 0x41], dl
0107bf11 80e2bf and dl, 0xbf
0107bf14 0fb64558 movzx eax, byte ptr [rbp + 0x58]
0107bf18 2401 and al, 1
0107bf1a c0e006 shl al, 6
0107bf1d 0ac2 or al, dl
0107bf1f 884741 mov byte ptr [rdi + 0x41], al
0107bf22 8b856c020000 mov eax, dword ptr [rbp + 0x26c]
0107bf28 89472c mov dword ptr [rdi + 0x2c], eax
0107bf2b 8b85b4020000 mov eax, dword ptr [rbp + 0x2b4]
0107bf31 8983ac000000 mov dword ptr [rbx + 0xac], eax
0107bf37 0fb68388000000 movzx eax, byte ptr [rbx + 0x88]
0107bf3e 0fb68d98020000 movzx ecx, byte ptr [rbp + 0x298]
0107bf45 24f7 and al, 0xf7
0107bf47 80e101 and cl, 1
0107bf4a c0e103 shl cl, 3
0107bf4d 0ac8 or cl, al
0107bf4f 888b88000000 mov byte ptr [rbx + 0x88], cl
0107bf55 80e1fe and cl, 0xfe
0107bf58 0fb6859c020000 movzx eax, byte ptr [rbp + 0x29c]
0107bf5f 2401 and al, 1
0107bf61 0ac1 or al, cl
0107bf63 888388000000 mov byte ptr [rbx + 0x88], al
0107bf69 24fd and al, 0xfd
0107bf6b 0fb68d9d020000 movzx ecx, byte ptr [rbp + 0x29d]
0107bf72 80e101 and cl, 1
0107bf75 02c9 add cl, cl
0107bf77 0ac8 or cl, al
0107bf79 888b88000000 mov byte ptr [rbx + 0x88], cl
0107bf7f 80e1fb and cl, 0xfb
0107bf82 0fb6859e020000 movzx eax, byte ptr [rbp + 0x29e]
0107bf89 2401 and al, 1
0107bf8b c0e002 shl al, 2
0107bf8e 0ac1 or al, cl
0107bf90 888388000000 mov byte ptr [rbx + 0x88], al
0107bf96 8b85b8020000 mov eax, dword ptr [rbp + 0x2b8]
0107bf9c 89838c000000 mov dword ptr [rbx + 0x8c], eax
0107bfa2 0fb68522030000 movzx eax, byte ptr [rbp + 0x322]
0107bfa9 888389000000 mov byte ptr [rbx + 0x89], al
0107bfaf 4038b5a0020000 cmp byte ptr [rbp + 0x2a0], sil
0107bfb6 7462 je 0x14107c01a
0107bfb8 4885ff test rdi, rdi
0107bfbb 7444 je 0x14107c001
0107bfbd 488b4f08 mov rcx, qword ptr [rdi + 8]
0107bfc1 4885c9 test rcx, rcx
0107bfc4 743b je 0x14107c001
0107bfc6 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107bfca 4885c9 test rcx, rcx
0107bfcd 7432 je 0x14107c001
0107bfcf 488b4720 mov rax, qword ptr [rdi + 0x20]
0107bfd3 f60001 test byte ptr [rax], 1
0107bfd6 7529 jne 0x14107c001
0107bfd8 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107bfe2 4d8bec mov r13, r12
0107bfe5 751a jne 0x14107c001
0107bfe7 488b8950010000 mov rcx, qword ptr [rcx + 0x150]
0107bfee e8bda2b4ff call 0x140bc62b0
0107bff3 48894720 mov qword ptr [rdi + 0x20], rax
0107bff7 8bce mov ecx, esi
0107bff9 4885c0 test rax, rax
0107bffc 7403 je 0x14107c001
0107bffe 800801 or byte ptr [rax], 1
0107c001 488b5720 mov rdx, qword ptr [rdi + 0x20]
0107c005 0fb68da0020000 movzx ecx, byte ptr [rbp + 0x2a0]
0107c00c 80e101 and cl, 1
0107c00f 02c9 add cl, cl
0107c011 0fb602 movzx eax, byte ptr [rdx]
0107c014 24fd and al, 0xfd
0107c016 0ac8 or cl, al
0107c018 880a mov byte ptr [rdx], cl
0107c01a 80bda202000000 cmp byte ptr [rbp + 0x2a2], 0
0107c021 745b je 0x14107c07e
0107c023 488b4f08 mov rcx, qword ptr [rdi + 8]
0107c027 4885c9 test rcx, rcx
0107c02a 7438 je 0x14107c064
0107c02c 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107c030 4885c9 test rcx, rcx
0107c033 742f je 0x14107c064
0107c035 488b4720 mov rax, qword ptr [rdi + 0x20]
0107c039 f60001 test byte ptr [rax], 1
0107c03c 7526 jne 0x14107c064
0107c03e 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107c048 751a jne 0x14107c064
0107c04a 488b8950010000 mov rcx, qword ptr [rcx + 0x150]
0107c051 e85aa2b4ff call 0x140bc62b0
0107c056 48894720 mov qword ptr [rdi + 0x20], rax
0107c05a 8bce mov ecx, esi
0107c05c 4885c0 test rax, rax
0107c05f 7403 je 0x14107c064
0107c061 800801 or byte ptr [rax], 1
0107c064 488b5720 mov rdx, qword ptr [rdi + 0x20]
0107c068 0fb68da2020000 movzx ecx, byte ptr [rbp + 0x2a2]
0107c06f 80e101 and cl, 1
0107c072 c0e103 shl cl, 3
0107c075 0fb602 movzx eax, byte ptr [rdx]
0107c078 24f7 and al, 0xf7
0107c07a 0ac8 or cl, al
0107c07c 880a mov byte ptr [rdx], cl
0107c07e 80bda102000000 cmp byte ptr [rbp + 0x2a1], 0
0107c085 745b je 0x14107c0e2
0107c087 488b4f08 mov rcx, qword ptr [rdi + 8]
0107c08b 4885c9 test rcx, rcx
0107c08e 7438 je 0x14107c0c8
0107c090 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107c094 4885c9 test rcx, rcx
0107c097 742f je 0x14107c0c8
0107c099 488b4720 mov rax, qword ptr [rdi + 0x20]
0107c09d f60001 test byte ptr [rax], 1
0107c0a0 7526 jne 0x14107c0c8
0107c0a2 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107c0ac 751a jne 0x14107c0c8
0107c0ae 488b8950010000 mov rcx, qword ptr [rcx + 0x150]
0107c0b5 e8f6a1b4ff call 0x140bc62b0
0107c0ba 48894720 mov qword ptr [rdi + 0x20], rax
0107c0be 8bce mov ecx, esi
0107c0c0 4885c0 test rax, rax
0107c0c3 7403 je 0x14107c0c8
0107c0c5 800801 or byte ptr [rax], 1
0107c0c8 488b5720 mov rdx, qword ptr [rdi + 0x20]
0107c0cc 0fb68da1020000 movzx ecx, byte ptr [rbp + 0x2a1]
0107c0d3 80e101 and cl, 1
0107c0d6 c0e102 shl cl, 2
0107c0d9 0fb602 movzx eax, byte ptr [rdx]
0107c0dc 24fb and al, 0xfb
0107c0de 0ac8 or cl, al
0107c0e0 880a mov byte ptr [rdx], cl
0107c0e2 83bd8400000000 cmp dword ptr [rbp + 0x84], 0
0107c0e9 7415 je 0x14107c100
0107c0eb 488bcb mov rcx, rbx
0107c0ee e8dd6ef1ff call 0x140f92fd0
0107c0f3 488b4b78 mov rcx, qword ptr [rbx + 0x78]
0107c0f7 8b8584000000 mov eax, dword ptr [rbp + 0x84]
0107c0fd 894104 mov dword ptr [rcx + 4], eax
0107c100 83bd8800000000 cmp dword ptr [rbp + 0x88], 0
0107c107 7415 je 0x14107c11e
0107c109 488bcb mov rcx, rbx
0107c10c e8bf6ef1ff call 0x140f92fd0
0107c111 488b4b78 mov rcx, qword ptr [rbx + 0x78]
0107c115 8b8588000000 mov eax, dword ptr [rbp + 0x88]
0107c11b 894108 mov dword ptr [rcx + 8], eax
0107c11e 83bdbc00000000 cmp dword ptr [rbp + 0xbc], 0
0107c125 7415 je 0x14107c13c
0107c127 488bcb mov rcx, rbx
0107c12a e8a16ef1ff call 0x140f92fd0
0107c12f 488b4b78 mov rcx, qword ptr [rbx + 0x78]
0107c133 8b85bc000000 mov eax, dword ptr [rbp + 0xbc]
0107c139 89410c mov dword ptr [rcx + 0xc], eax
0107c13c 83bdb002000000 cmp dword ptr [rbp + 0x2b0], 0
0107c143 7415 je 0x14107c15a
0107c145 488bcb mov rcx, rbx
0107c148 e8836ef1ff call 0x140f92fd0
0107c14d 488b4b78 mov rcx, qword ptr [rbx + 0x78]
0107c151 8b85b0020000 mov eax, dword ptr [rbp + 0x2b0]
0107c157 894114 mov dword ptr [rcx + 0x14], eax
0107c15a 0fb685bc020000 movzx eax, byte ptr [rbp + 0x2bc]
0107c161 8bc8 mov ecx, eax
0107c163 84c0 test al, al
0107c165 b802000000 mov eax, 2
0107c16a 0f44c8 cmove ecx, eax
0107c16d 888dbc020000 mov byte ptr [rbp + 0x2bc], cl
0107c173 84c9 test cl, cl
0107c175 0fb6d1 movzx edx, cl
0107c178 488b8d74020000 mov rcx, qword ptr [rbp + 0x274]
0107c17f 7530 jne 0x14107c1b1
0107c181 4885c9 test rcx, rcx
0107c184 7579 jne 0x14107c1ff
0107c186 4c8b8d7c020000 mov r9, qword ptr [rbp + 0x27c]
0107c18d 4d85c9 test r9, r9
0107c190 756d jne 0x14107c1ff
0107c192 4c8b85c8020000 mov r8, qword ptr [rbp + 0x2c8]
0107c199 4d85c0 test r8, r8
0107c19c 7561 jne 0x14107c1ff
0107c19e 488b4720 mov rax, qword ptr [rdi + 0x20]
0107c1a2 8b5004 mov edx, dword ptr [rax + 4]
0107c1a5 83fa02 cmp edx, 2
0107c1a8 7438 je 0x14107c1e2
0107c1aa 83fa03 cmp edx, 3
0107c1ad 7550 jne 0x14107c1ff
0107c1af eb2c jmp 0x14107c1dd
0107c1b1 4c8b85c8020000 mov r8, qword ptr [rbp + 0x2c8]
0107c1b8 4c8b8d7c020000 mov r9, qword ptr [rbp + 0x27c]
0107c1bf 4885c9 test rcx, rcx
0107c1c2 7407 je 0x14107c1cb
0107c1c4 4d85c9 test r9, r9
0107c1c7 750c jne 0x14107c1d5
0107c1c9 eb34 jmp 0x14107c1ff
0107c1cb 4d85c9 test r9, r9
0107c1ce 752f jne 0x14107c1ff
0107c1d0 4d85c0 test r8, r8
0107c1d3 752a jne 0x14107c1ff
0107c1d5 8d42fe lea eax, [rdx - 2]
0107c1d8 83f801 cmp eax, 1
0107c1db 7722 ja 0x14107c1ff
0107c1dd 83fa02 cmp edx, 2
0107c1e0 750d jne 0x14107c1ef
0107c1e2 488bd1 mov rdx, rcx
0107c1e5 488bcf mov rcx, rdi
0107c1e8 e893def2ff call 0x140faa080
0107c1ed eb10 jmp 0x14107c1ff
0107c1ef 83fa03 cmp edx, 3
0107c1f2 750b jne 0x14107c1ff
0107c1f4 488bd1 mov rdx, rcx
0107c1f7 488bcf mov rcx, rdi
0107c1fa e8d1dcf2ff call 0x140fa9ed0
0107c1ff 0fb6859b020000 movzx eax, byte ptr [rbp + 0x29b]
0107c206 84c0 test al, al
0107c208 7406 je 0x14107c210
0107c20a 88838a000000 mov byte ptr [rbx + 0x8a], al
0107c210 83bd3802000000 cmp dword ptr [rbp + 0x238], 0
0107c217 7415 je 0x14107c22e
0107c219 488bcb mov rcx, rbx
0107c21c e8df6cf1ff call 0x140f92f00
0107c221 488b4b68 mov rcx, qword ptr [rbx + 0x68]
0107c225 8b8538020000 mov eax, dword ptr [rbp + 0x238]
0107c22b 894110 mov dword ptr [rcx + 0x10], eax
0107c22e 0fb68d19030000 movzx ecx, byte ptr [rbp + 0x319]
0107c235 0fb683a0000000 movzx eax, byte ptr [rbx + 0xa0]
0107c23c 80e101 and cl, 1
0107c23f c0e103 shl cl, 3
0107c242 24f7 and al, 0xf7
0107c244 0ac8 or cl, al
0107c246 888ba0000000 mov byte ptr [rbx + 0xa0], cl
0107c24c 0fb68d1a030000 movzx ecx, byte ptr [rbp + 0x31a]
0107c253 0fb64740 movzx eax, byte ptr [rdi + 0x40]
0107c257 80e101 and cl, 1
0107c25a 02c9 add cl, cl
0107c25c 24fd and al, 0xfd
0107c25e 0ac8 or cl, al
0107c260 884f40 mov byte ptr [rdi + 0x40], cl
0107c263 83bde000000000 cmp dword ptr [rbp + 0xe0], 0
0107c26a 7512 jne 0x14107c27e
0107c26c 80bd1b03000000 cmp byte ptr [rbp + 0x31b], 0
0107c273 7509 jne 0x14107c27e
0107c275 83bd1c03000000 cmp dword ptr [rbp + 0x31c], 0
0107c27c 7476 je 0x14107c2f4
0107c27e 488b4710 mov rax, qword ptr [rdi + 0x10]
0107c282 f60001 test byte ptr [rax], 1
0107c285 7536 jne 0x14107c2bd
0107c287 488b4f08 mov rcx, qword ptr [rdi + 8]
0107c28b 4885c9 test rcx, rcx
0107c28e 742d je 0x14107c2bd
0107c290 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107c294 4885c9 test rcx, rcx
0107c297 7424 je 0x14107c2bd
0107c299 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107c2a3 7518 jne 0x14107c2bd
0107c2a5 488b8938010000 mov rcx, qword ptr [rcx + 0x138]
0107c2ac e8ff9fb4ff call 0x140bc62b0
0107c2b1 48894710 mov qword ptr [rdi + 0x10], rax
0107c2b5 4885c0 test rax, rax
0107c2b8 7403 je 0x14107c2bd
0107c2ba 800801 or byte ptr [rax], 1
0107c2bd 0fb68d1b030000 movzx ecx, byte ptr [rbp + 0x31b]
0107c2c4 488b5710 mov rdx, qword ptr [rdi + 0x10]
0107c2c8 c0e107 shl cl, 7
0107c2cb 0fb602 movzx eax, byte ptr [rdx]
0107c2ce 247f and al, 0x7f
0107c2d0 0ac8 or cl, al
0107c2d2 880a mov byte ptr [rdx], cl
0107c2d4 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c2d8 8b85e0000000 mov eax, dword ptr [rbp + 0xe0]
0107c2de 89818c000000 mov dword ptr [rcx + 0x8c], eax
0107c2e4 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c2e8 8b851c030000 mov eax, dword ptr [rbp + 0x31c]
0107c2ee 898190000000 mov dword ptr [rcx + 0x90], eax
0107c2f4 83bd4c01000000 cmp dword ptr [rbp + 0x14c], 0
0107c2fb 7415 je 0x14107c312
0107c2fd 488bcb mov rcx, rbx
0107c300 e86b6cf1ff call 0x140f92f70
0107c305 488b4b70 mov rcx, qword ptr [rbx + 0x70]
0107c309 8b854c010000 mov eax, dword ptr [rbp + 0x14c]
0107c30f 894104 mov dword ptr [rcx + 4], eax
0107c312 83bd5001000000 cmp dword ptr [rbp + 0x150], 0
0107c319 7415 je 0x14107c330
0107c31b 488bcb mov rcx, rbx
0107c31e e84d6cf1ff call 0x140f92f70
0107c323 488b4b70 mov rcx, qword ptr [rbx + 0x70]
0107c327 8b8550010000 mov eax, dword ptr [rbp + 0x150]
0107c32d 894108 mov dword ptr [rcx + 8], eax
0107c330 488b95ec010000 mov rdx, qword ptr [rbp + 0x1ec]
0107c337 4885d2 test rdx, rdx
0107c33a 750d jne 0x14107c349
0107c33c 8b95e8000000 mov edx, dword ptr [rbp + 0xe8]
0107c342 488995ec010000 mov qword ptr [rbp + 0x1ec], rdx
0107c349 488bcf mov rcx, rdi
0107c34c e82fedf2ff call 0x140fab080
0107c351 4883bdfc01000000 cmp qword ptr [rbp + 0x1fc], 0
0107c359 7512 jne 0x14107c36d
0107c35b 8b85f0000000 mov eax, dword ptr [rbp + 0xf0]
0107c361 488985fc010000 mov qword ptr [rbp + 0x1fc], rax
0107c368 4885c0 test rax, rax
0107c36b 744e je 0x14107c3bb
0107c36d 488b4710 mov rax, qword ptr [rdi + 0x10]
0107c371 f60001 test byte ptr [rax], 1
0107c374 7536 jne 0x14107c3ac
0107c376 488b4f08 mov rcx, qword ptr [rdi + 8]
0107c37a 4885c9 test rcx, rcx
0107c37d 742d je 0x14107c3ac
0107c37f 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107c383 4885c9 test rcx, rcx
0107c386 7424 je 0x14107c3ac
0107c388 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107c392 7518 jne 0x14107c3ac
0107c394 488b8938010000 mov rcx, qword ptr [rcx + 0x138]
0107c39b e8109fb4ff call 0x140bc62b0
0107c3a0 48894710 mov qword ptr [rdi + 0x10], rax
0107c3a4 4885c0 test rax, rax
0107c3a7 7403 je 0x14107c3ac
0107c3a9 800801 or byte ptr [rax], 1
0107c3ac 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c3b0 488b85fc010000 mov rax, qword ptr [rbp + 0x1fc]
0107c3b7 48894148 mov qword ptr [rcx + 0x48], rax
0107c3bb 4883bd0c02000000 cmp qword ptr [rbp + 0x20c], 0
0107c3c3 7512 jne 0x14107c3d7
0107c3c5 8b85f8000000 mov eax, dword ptr [rbp + 0xf8]
0107c3cb 4889850c020000 mov qword ptr [rbp + 0x20c], rax
0107c3d2 4885c0 test rax, rax
0107c3d5 7417 je 0x14107c3ee
0107c3d7 488bcf mov rcx, rdi
0107c3da e8719df2ff call 0x140fa6150
0107c3df 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c3e3 488b850c020000 mov rax, qword ptr [rbp + 0x20c]
0107c3ea 48894158 mov qword ptr [rcx + 0x58], rax
0107c3ee 4883bdf401000000 cmp qword ptr [rbp + 0x1f4], 0
0107c3f6 7512 jne 0x14107c40a
0107c3f8 8b85ec000000 mov eax, dword ptr [rbp + 0xec]
0107c3fe 488985f4010000 mov qword ptr [rbp + 0x1f4], rax
0107c405 4885c0 test rax, rax
0107c408 7417 je 0x14107c421
0107c40a 488bcf mov rcx, rdi
0107c40d e83e9df2ff call 0x140fa6150
0107c412 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c416 488b85f4010000 mov rax, qword ptr [rbp + 0x1f4]
0107c41d 48894140 mov qword ptr [rcx + 0x40], rax
0107c421 4883bd0402000000 cmp qword ptr [rbp + 0x204], 0
0107c429 7512 jne 0x14107c43d
0107c42b 8b85f4000000 mov eax, dword ptr [rbp + 0xf4]
0107c431 48898504020000 mov qword ptr [rbp + 0x204], rax
0107c438 4885c0 test rax, rax
0107c43b 7417 je 0x14107c454
0107c43d 488bcf mov rcx, rdi
0107c440 e80b9df2ff call 0x140fa6150
0107c445 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c449 488b8504020000 mov rax, qword ptr [rbp + 0x204]
0107c450 48894150 mov qword ptr [rcx + 0x50], rax
0107c454 4883bd1402000000 cmp qword ptr [rbp + 0x214], 0
0107c45c 7512 jne 0x14107c470
0107c45e 8b8524010000 mov eax, dword ptr [rbp + 0x124]
0107c464 48898514020000 mov qword ptr [rbp + 0x214], rax
0107c46b 4885c0 test rax, rax
0107c46e 7417 je 0x14107c487
0107c470 488bcf mov rcx, rdi
0107c473 e8d89cf2ff call 0x140fa6150
0107c478 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c47c 488b8514020000 mov rax, qword ptr [rbp + 0x214]
0107c483 48894160 mov qword ptr [rcx + 0x60], rax
0107c487 83bddc00000000 cmp dword ptr [rbp + 0xdc], 0
0107c48e 7418 je 0x14107c4a8
0107c490 488bcf mov rcx, rdi
0107c493 e8b89cf2ff call 0x140fa6150
0107c498 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c49c 8b85dc000000 mov eax, dword ptr [rbp + 0xdc]
0107c4a2 898188000000 mov dword ptr [rcx + 0x88], eax
0107c4a8 80bd9200000000 cmp byte ptr [rbp + 0x92], 0
0107c4af 7416 je 0x14107c4c7
0107c4b1 488bcb mov rcx, rbx
0107c4b4 e8476af1ff call 0x140f92f00
0107c4b9 488b4b68 mov rcx, qword ptr [rbx + 0x68]
0107c4bd 0fb68592000000 movzx eax, byte ptr [rbp + 0x92]
0107c4c4 884101 mov byte ptr [rcx + 1], al
0107c4c7 83bdfc00000000 cmp dword ptr [rbp + 0xfc], 0
0107c4ce 7415 je 0x14107c4e5
0107c4d0 488bcb mov rcx, rbx
0107c4d3 e8286af1ff call 0x140f92f00
0107c4d8 488b4b68 mov rcx, qword ptr [rbx + 0x68]
0107c4dc 8b85fc000000 mov eax, dword ptr [rbp + 0xfc]
0107c4e2 894104 mov dword ptr [rcx + 4], eax
0107c4e5 488b956c010000 mov rdx, qword ptr [rbp + 0x16c]
0107c4ec 4c8b85a4020000 mov r8, qword ptr [rbp + 0x2a4]
0107c4f3 4885d2 test rdx, rdx
0107c4f6 7505 jne 0x14107c4fd
0107c4f8 4d85c0 test r8, r8
0107c4fb 7408 je 0x14107c505
0107c4fd 488bcb mov rcx, rbx
0107c500 e85b68f2ff call 0x140fa2d60
0107c505 6683bd1003000000 cmp word ptr [rbp + 0x310], 0
0107c50d 7517 jne 0x14107c526
0107c50f 6683bd1203000000 cmp word ptr [rbp + 0x312], 0
0107c517 750d jne 0x14107c526
0107c519 80bd1403000000 cmp byte ptr [rbp + 0x314], 0
0107c520 0f8480000000 je 0x14107c5a6
0107c526 488b4368 mov rax, qword ptr [rbx + 0x68]
0107c52a f60001 test byte ptr [rax], 1
0107c52d 753f jne 0x14107c56e
0107c52f 488b4b10 mov rcx, qword ptr [rbx + 0x10]
0107c533 4885c9 test rcx, rcx
0107c536 7436 je 0x14107c56e
0107c538 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107c542 752a jne 0x14107c56e
0107c544 488b8930010000 mov rcx, qword ptr [rcx + 0x130]
0107c54b e8609db4ff call 0x140bc62b0
0107c550 4885c0 test rax, rax
0107c553 7419 je 0x14107c56e
0107c555 33c9 xor ecx, ecx
0107c557 48894858 mov qword ptr [rax + 0x58], rcx
0107c55b 48894860 mov qword ptr [rax + 0x60], rcx
0107c55f 48894868 mov qword ptr [rax + 0x68], rcx
0107c563 48894870 mov qword ptr [rax + 0x70], rcx
0107c567 48894368 mov qword ptr [rbx + 0x68], rax
0107c56b 800801 or byte ptr [rax], 1
0107c56e 488b4b68 mov rcx, qword ptr [rbx + 0x68]
0107c572 0fb78510030000 movzx eax, word ptr [rbp + 0x310]
0107c579 66894114 mov word ptr [rcx + 0x14], ax
0107c57d 488b4b68 mov rcx, qword ptr [rbx + 0x68]
0107c581 0fb78512030000 movzx eax, word ptr [rbp + 0x312]
0107c588 66894116 mov word ptr [rcx + 0x16], ax
0107c58c 488b5368 mov rdx, qword ptr [rbx + 0x68]
0107c590 0fb68d14030000 movzx ecx, byte ptr [rbp + 0x314]
0107c597 80e101 and cl, 1
0107c59a c0e103 shl cl, 3
0107c59d 0fb602 movzx eax, byte ptr [rdx]
0107c5a0 24f7 and al, 0xf7
0107c5a2 0ac8 or cl, al
0107c5a4 880a mov byte ptr [rdx], cl
0107c5a6 80bd9c01000000 cmp byte ptr [rbp + 0x19c], 0
0107c5ad 7447 je 0x14107c5f6
0107c5af 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c5b3 f60001 test byte ptr [rax], 1
0107c5b6 7536 jne 0x14107c5ee
0107c5b8 488b4f08 mov rcx, qword ptr [rdi + 8]
0107c5bc 4885c9 test rcx, rcx
0107c5bf 742d je 0x14107c5ee
0107c5c1 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107c5c5 4885c9 test rcx, rcx
0107c5c8 7424 je 0x14107c5ee
0107c5ca 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107c5d4 7518 jne 0x14107c5ee
0107c5d6 488b8948010000 mov rcx, qword ptr [rcx + 0x148]
0107c5dd e8ce9cb4ff call 0x140bc62b0
0107c5e2 48894718 mov qword ptr [rdi + 0x18], rax
0107c5e6 4885c0 test rax, rax
0107c5e9 7403 je 0x14107c5ee
0107c5eb 800801 or byte ptr [rax], 1
0107c5ee 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c5f2 c6401801 mov byte ptr [rax + 0x18], 1
0107c5f6 80bdb001000000 cmp byte ptr [rbp + 0x1b0], 0
0107c5fd 7447 je 0x14107c646
0107c5ff 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c603 f60001 test byte ptr [rax], 1
0107c606 7536 jne 0x14107c63e
0107c608 488b4f08 mov rcx, qword ptr [rdi + 8]
0107c60c 4885c9 test rcx, rcx
0107c60f 742d je 0x14107c63e
0107c611 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107c615 4885c9 test rcx, rcx
0107c618 7424 je 0x14107c63e
0107c61a 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107c624 7518 jne 0x14107c63e
0107c626 488b8948010000 mov rcx, qword ptr [rcx + 0x148]
0107c62d e87e9cb4ff call 0x140bc62b0
0107c632 48894718 mov qword ptr [rdi + 0x18], rax
0107c636 4885c0 test rax, rax
0107c639 7403 je 0x14107c63e
0107c63b 800801 or byte ptr [rax], 1
0107c63e 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c642 c6401a01 mov byte ptr [rax + 0x1a], 1
0107c646 80bdb301000000 cmp byte ptr [rbp + 0x1b3], 0
0107c64d 7446 je 0x14107c695
0107c64f 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c653 f60001 test byte ptr [rax], 1
0107c656 7536 jne 0x14107c68e
0107c658 488b4f08 mov rcx, qword ptr [rdi + 8]
0107c65c 4885c9 test rcx, rcx
0107c65f 742d je 0x14107c68e
0107c661 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107c665 4885c9 test rcx, rcx
0107c668 7424 je 0x14107c68e
0107c66a 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107c674 7518 jne 0x14107c68e
0107c676 488b8948010000 mov rcx, qword ptr [rcx + 0x148]
0107c67d e82e9cb4ff call 0x140bc62b0
0107c682 48894718 mov qword ptr [rdi + 0x18], rax
0107c686 4885c0 test rax, rax
0107c689 7403 je 0x14107c68e
0107c68b 800801 or byte ptr [rax], 1
0107c68e 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c692 800808 or byte ptr [rax], 8
0107c695 80bd9d01000000 cmp byte ptr [rbp + 0x19d], 0
0107c69c 7447 je 0x14107c6e5
0107c69e 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c6a2 f60001 test byte ptr [rax], 1
0107c6a5 7536 jne 0x14107c6dd
0107c6a7 488b4f08 mov rcx, qword ptr [rdi + 8]
0107c6ab 4885c9 test rcx, rcx
0107c6ae 742d je 0x14107c6dd
0107c6b0 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107c6b4 4885c9 test rcx, rcx
0107c6b7 7424 je 0x14107c6dd
0107c6b9 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107c6c3 7518 jne 0x14107c6dd
0107c6c5 488b8948010000 mov rcx, qword ptr [rcx + 0x148]
0107c6cc e8df9bb4ff call 0x140bc62b0
0107c6d1 48894718 mov qword ptr [rdi + 0x18], rax
0107c6d5 4885c0 test rax, rax
0107c6d8 7403 je 0x14107c6dd
0107c6da 800801 or byte ptr [rax], 1
0107c6dd 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c6e1 c6401901 mov byte ptr [rax + 0x19], 1
0107c6e5 80bda302000000 cmp byte ptr [rbp + 0x2a3], 0
0107c6ec 7462 je 0x14107c750
0107c6ee 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c6f2 f60001 test byte ptr [rax], 1
0107c6f5 7536 jne 0x14107c72d
0107c6f7 488b4f08 mov rcx, qword ptr [rdi + 8]
0107c6fb 4885c9 test rcx, rcx
0107c6fe 742d je 0x14107c72d
0107c700 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107c704 4885c9 test rcx, rcx
0107c707 7424 je 0x14107c72d
0107c709 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107c713 7518 jne 0x14107c72d
0107c715 488b8948010000 mov rcx, qword ptr [rcx + 0x148]
0107c71c e88f9bb4ff call 0x140bc62b0
0107c721 48894718 mov qword ptr [rdi + 0x18], rax
0107c725 4885c0 test rax, rax
0107c728 7403 je 0x14107c72d
0107c72a 800801 or byte ptr [rax], 1
0107c72d 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c731 0fb68da3020000 movzx ecx, byte ptr [rbp + 0x2a3]
0107c738 66894812 mov word ptr [rax + 0x12], cx
0107c73c 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c740 0fb68d20030000 movzx ecx, byte ptr [rbp + 0x320]
0107c747 66894814 mov word ptr [rax + 0x14], cx
0107c74b e9fc000000 jmp 0x14107c84c
0107c750 48837b1000 cmp qword ptr [rbx + 0x10], 0
0107c755 0f849f000000 je 0x14107c7fa
0107c75b f6839c00000002 test byte ptr [rbx + 0x9c], 2
0107c762 754d jne 0x14107c7b1
0107c764 f6839a00000001 test byte ptr [rbx + 0x9a], 1
0107c76b 0f8489000000 je 0x14107c7fa
0107c771 488b4368 mov rax, qword ptr [rbx + 0x68]
0107c775 8b4810 mov ecx, dword ptr [rax + 0x10]
0107c778 85c9 test ecx, ecx
0107c77a 752d jne 0x14107c7a9
0107c77c 398bac000000 cmp dword ptr [rbx + 0xac], ecx
0107c782 751f jne 0x14107c7a3
0107c784 488bcb mov rcx, rbx
0107c787 e8b44af1ff call 0x140f91240
0107c78c 8983ac000000 mov dword ptr [rbx + 0xac], eax
0107c792 85c0 test eax, eax
0107c794 740d je 0x14107c7a3
0107c796 ba3c000000 mov edx, 0x3c
0107c79b 488bcb mov rcx, rbx
0107c79e e85d79f1ff call 0x140f94100
0107c7a3 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
0107c7a9 f7c1620c0000 test ecx, 0xc62
0107c7af 7449 je 0x14107c7fa
0107c7b1 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c7b5 f60001 test byte ptr [rax], 1
0107c7b8 7536 jne 0x14107c7f0
0107c7ba 488b4f08 mov rcx, qword ptr [rdi + 8]
0107c7be 4885c9 test rcx, rcx
0107c7c1 742d je 0x14107c7f0
0107c7c3 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107c7c7 4885c9 test rcx, rcx
0107c7ca 7424 je 0x14107c7f0
0107c7cc 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107c7d6 7518 jne 0x14107c7f0
0107c7d8 488b8948010000 mov rcx, qword ptr [rcx + 0x148]
0107c7df e8cc9ab4ff call 0x140bc62b0
0107c7e4 48894718 mov qword ptr [rdi + 0x18], rax
0107c7e8 4885c0 test rax, rax
0107c7eb 7403 je 0x14107c7f0
0107c7ed 800801 or byte ptr [rax], 1
0107c7f0 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c7f4 33c9 xor ecx, ecx
0107c7f6 66894812 mov word ptr [rax + 0x12], cx
0107c7fa 80bd1e02000000 cmp byte ptr [rbp + 0x21e], 0
0107c801 7449 je 0x14107c84c
0107c803 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c807 f60001 test byte ptr [rax], 1
0107c80a 7536 jne 0x14107c842
0107c80c 488b4f08 mov rcx, qword ptr [rdi + 8]
0107c810 4885c9 test rcx, rcx
0107c813 742d je 0x14107c842
0107c815 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107c819 4885c9 test rcx, rcx
0107c81c 7424 je 0x14107c842
0107c81e 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107c828 7518 jne 0x14107c842
0107c82a 488b8948010000 mov rcx, qword ptr [rcx + 0x148]
0107c831 e87a9ab4ff call 0x140bc62b0
0107c836 48894718 mov qword ptr [rdi + 0x18], rax
0107c83a 4885c0 test rax, rax
0107c83d 7403 je 0x14107c842
0107c83f 800801 or byte ptr [rax], 1
0107c842 488b4718 mov rax, qword ptr [rdi + 0x18]
0107c846 66c740120100 mov word ptr [rax + 0x12], 1
0107c84c 488b95dc010000 mov rdx, qword ptr [rbp + 0x1dc]
0107c853 4885d2 test rdx, rdx
0107c856 750d jne 0x14107c865
0107c858 8b95a0010000 mov edx, dword ptr [rbp + 0x1a0]
0107c85e 488995dc010000 mov qword ptr [rbp + 0x1dc], rdx
0107c865 488b8dd4010000 mov rcx, qword ptr [rbp + 0x1d4]
0107c86c 4885c9 test rcx, rcx
0107c86f 750d jne 0x14107c87e
0107c871 8b8db0000000 mov ecx, dword ptr [rbp + 0xb0]
0107c877 48898dd4010000 mov qword ptr [rbp + 0x1d4], rcx
0107c87e 488b85e4010000 mov rax, qword ptr [rbp + 0x1e4]
0107c885 4885c0 test rax, rax
0107c888 750d jne 0x14107c897
0107c88a 8b85c8000000 mov eax, dword ptr [rbp + 0xc8]
0107c890 488985e4010000 mov qword ptr [rbp + 0x1e4], rax
0107c897 4885d2 test rdx, rdx
0107c89a 7527 jne 0x14107c8c3
0107c89c 4885c9 test rcx, rcx
0107c89f 7522 jne 0x14107c8c3
0107c8a1 4885c0 test rax, rax
0107c8a4 751d jne 0x14107c8c3
0107c8a6 4839854c020000 cmp qword ptr [rbp + 0x24c], rax
0107c8ad 7514 jne 0x14107c8c3
0107c8af 398514010000 cmp dword ptr [rbp + 0x114], eax
0107c8b5 750c jne 0x14107c8c3
0107c8b7 39852c020000 cmp dword ptr [rbp + 0x22c], eax
0107c8bd 0f84cc000000 je 0x14107c98f
0107c8c3 488bcf mov rcx, rdi
0107c8c6 e88598f2ff call 0x140fa6150
0107c8cb 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c8cf 488b85dc010000 mov rax, qword ptr [rbp + 0x1dc]
0107c8d6 48894120 mov qword ptr [rcx + 0x20], rax
0107c8da 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c8de 488b85d4010000 mov rax, qword ptr [rbp + 0x1d4]
0107c8e5 48894108 mov qword ptr [rcx + 8], rax
0107c8e9 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c8ed 488b85e4010000 mov rax, qword ptr [rbp + 0x1e4]
0107c8f4 48894110 mov qword ptr [rcx + 0x10], rax
0107c8f8 488b854c020000 mov rax, qword ptr [rbp + 0x24c]
0107c8ff 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c903 48894118 mov qword ptr [rcx + 0x18], rax
0107c907 8b8514010000 mov eax, dword ptr [rbp + 0x114]
0107c90d 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c911 898184000000 mov dword ptr [rcx + 0x84], eax
0107c917 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c91b 8b852c020000 mov eax, dword ptr [rbp + 0x22c]
0107c921 894104 mov dword ptr [rcx + 4], eax
0107c924 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c928 488b85ec020000 mov rax, qword ptr [rbp + 0x2ec]
0107c92f 48894128 mov qword ptr [rcx + 0x28], rax
0107c933 488b4f10 mov rcx, qword ptr [rdi + 0x10]
0107c937 488b85f4020000 mov rax, qword ptr [rbp + 0x2f4]
0107c93e 48894130 mov qword ptr [rcx + 0x30], rax
0107c942 488b5710 mov rdx, qword ptr [rdi + 0x10]
0107c946 0fb68d99020000 movzx ecx, byte ptr [rbp + 0x299]
0107c94d 80e101 and cl, 1
0107c950 02c9 add cl, cl
0107c952 0fb602 movzx eax, byte ptr [rdx]
0107c955 24fd and al, 0xfd
0107c957 0ac8 or cl, al
0107c959 880a mov byte ptr [rdx], cl
0107c95b 488b5710 mov rdx, qword ptr [rdi + 0x10]
0107c95f 0fb68d9a020000 movzx ecx, byte ptr [rbp + 0x29a]
0107c966 80e101 and cl, 1
0107c969 c0e102 shl cl, 2
0107c96c 0fb602 movzx eax, byte ptr [rdx]
0107c96f 24fb and al, 0xfb
0107c971 0ac8 or cl, al
0107c973 880a mov byte ptr [rdx], cl
0107c975 488b5710 mov rdx, qword ptr [rdi + 0x10]
0107c979 0fb68dac020000 movzx ecx, byte ptr [rbp + 0x2ac]
0107c980 80e101 and cl, 1
0107c983 c0e105 shl cl, 5
0107c986 0fb602 movzx eax, byte ptr [rdx]
0107c989 24df and al, 0xdf
0107c98b 0ac8 or cl, al
0107c98d 880a mov byte ptr [rdx], cl
0107c98f 0fb68dfc020000 movzx ecx, byte ptr [rbp + 0x2fc]
0107c996 0fb64742 movzx eax, byte ptr [rdi + 0x42]
0107c99a 80e101 and cl, 1
0107c99d c0e106 shl cl, 6
0107c9a0 24bf and al, 0xbf
0107c9a2 0ac8 or cl, al
0107c9a4 884f42 mov byte ptr [rdi + 0x42], cl
0107c9a7 80e17f and cl, 0x7f
0107c9aa 0fb68515030000 movzx eax, byte ptr [rbp + 0x315]
0107c9b1 c0e007 shl al, 7
0107c9b4 0ac8 or cl, al
0107c9b6 884f42 mov byte ptr [rdi + 0x42], cl
0107c9b9 0fb68dfe020000 movzx ecx, byte ptr [rbp + 0x2fe]
0107c9c0 0fb6839f000000 movzx eax, byte ptr [rbx + 0x9f]
0107c9c7 80e101 and cl, 1
0107c9ca 24bf and al, 0xbf
0107c9cc c0e106 shl cl, 6
0107c9cf 0ac8 or cl, al
0107c9d1 888b9f000000 mov byte ptr [rbx + 0x9f], cl
0107c9d7 0fb68ba0000000 movzx ecx, byte ptr [rbx + 0xa0]
0107c9de 0fb6850c030000 movzx eax, byte ptr [rbp + 0x30c]
0107c9e5 80e1fe and cl, 0xfe
0107c9e8 2401 and al, 1
0107c9ea 0ac8 or cl, al
0107c9ec 888ba0000000 mov byte ptr [rbx + 0xa0], cl
0107c9f2 80e1fd and cl, 0xfd
0107c9f5 0fb6850d030000 movzx eax, byte ptr [rbp + 0x30d]
0107c9fc 2401 and al, 1
0107c9fe 02c0 add al, al
0107ca00 0ac1 or al, cl
0107ca02 8883a0000000 mov byte ptr [rbx + 0xa0], al
0107ca08 0fb685ff020000 movzx eax, byte ptr [rbp + 0x2ff]
0107ca0f 888307010000 mov byte ptr [rbx + 0x107], al
0107ca15 0fb68d0e030000 movzx ecx, byte ptr [rbp + 0x30e]
0107ca1c 0fb683a0000000 movzx eax, byte ptr [rbx + 0xa0]
0107ca23 80e101 and cl, 1
0107ca26 c0e102 shl cl, 2
0107ca29 24fb and al, 0xfb
0107ca2b 0ac8 or cl, al
0107ca2d 888ba0000000 mov byte ptr [rbx + 0xa0], cl
0107ca33 0fb68521030000 movzx eax, byte ptr [rbp + 0x321]
0107ca3a 884745 mov byte ptr [rdi + 0x45], al
0107ca3d 0fb68d23030000 movzx ecx, byte ptr [rbp + 0x323]
0107ca44 0fb64743 movzx eax, byte ptr [rdi + 0x43]
0107ca48 80e101 and cl, 1
0107ca4b 24fe and al, 0xfe
0107ca4d 0ac8 or cl, al
0107ca4f 884f43 mov byte ptr [rdi + 0x43], cl
0107ca52 4883bd0403000000 cmp qword ptr [rbp + 0x304], 0
0107ca5a 7531 jne 0x14107ca8d
0107ca5c 80bdfd02000000 cmp byte ptr [rbp + 0x2fd], 0
0107ca63 7528 jne 0x14107ca8d
0107ca65 80bd0003000000 cmp byte ptr [rbp + 0x300], 0
0107ca6c 751f jne 0x14107ca8d
0107ca6e 80bd0103000000 cmp byte ptr [rbp + 0x301], 0
0107ca75 7516 jne 0x14107ca8d
0107ca77 80bd0203000000 cmp byte ptr [rbp + 0x302], 0
0107ca7e 750d jne 0x14107ca8d
0107ca80 80bd0303000000 cmp byte ptr [rbp + 0x303], 0
0107ca87 0f84a2000000 je 0x14107cb2f
0107ca8d 488b4f08 mov rcx, qword ptr [rdi + 8]
0107ca91 4885c9 test rcx, rcx
0107ca94 7438 je 0x14107cace
0107ca96 488b4910 mov rcx, qword ptr [rcx + 0x10]
0107ca9a 4885c9 test rcx, rcx
0107ca9d 742f je 0x14107cace
0107ca9f 488b4720 mov rax, qword ptr [rdi + 0x20]
0107caa3 f60001 test byte ptr [rax], 1
0107caa6 7526 jne 0x14107cace
0107caa8 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107cab2 751a jne 0x14107cace
0107cab4 488b8950010000 mov rcx, qword ptr [rcx + 0x150]
0107cabb e8f097b4ff call 0x140bc62b0
0107cac0 48894720 mov qword ptr [rdi + 0x20], rax
0107cac4 8bce mov ecx, esi
0107cac6 4885c0 test rax, rax
0107cac9 7403 je 0x14107cace
0107cacb 800801 or byte ptr [rax], 1
0107cace 488b4f20 mov rcx, qword ptr [rdi + 0x20]
0107cad2 488b8504030000 mov rax, qword ptr [rbp + 0x304]
0107cad9 48894120 mov qword ptr [rcx + 0x20], rax
0107cadd 0fb68dfd020000 movzx ecx, byte ptr [rbp + 0x2fd]
0107cae4 488b5720 mov rdx, qword ptr [rdi + 0x20]
0107cae8 80e101 and cl, 1
0107caeb c0e104 shl cl, 4
0107caee 0fb602 movzx eax, byte ptr [rdx]
0107caf1 24ef and al, 0xef
0107caf3 0ac8 or cl, al
0107caf5 880a mov byte ptr [rdx], cl
0107caf7 488b4f20 mov rcx, qword ptr [rdi + 0x20]
0107cafb 0fb68500030000 movzx eax, byte ptr [rbp + 0x300]
0107cb02 884128 mov byte ptr [rcx + 0x28], al
0107cb05 488b4f20 mov rcx, qword ptr [rdi + 0x20]
0107cb09 0fb68501030000 movzx eax, byte ptr [rbp + 0x301]
0107cb10 884129 mov byte ptr [rcx + 0x29], al
0107cb13 488b4f20 mov rcx, qword ptr [rdi + 0x20]
0107cb17 0fb68502030000 movzx eax, byte ptr [rbp + 0x302]
0107cb1e 88412a mov byte ptr [rcx + 0x2a], al
0107cb21 488b4f20 mov rcx, qword ptr [rdi + 0x20]
0107cb25 0fb68503030000 movzx eax, byte ptr [rbp + 0x303]
0107cb2c 88412b mov byte ptr [rcx + 0x2b], al
0107cb2f f30f104748 movss xmm0, dword ptr [rdi + 0x48]
0107cb34 0f2ec6 ucomiss xmm0, xmm6
0107cb37 7a16 jp 0x14107cb4f
0107cb39 7514 jne 0x14107cb4f
0107cb3b 8b457c mov eax, dword ptr [rbp + 0x7c]
0107cb3e 0f57c0 xorps xmm0, xmm0
0107cb41 f3480f2ac0 cvtsi2ss xmm0, rax
0107cb46 f30f59c7 mulss xmm0, xmm7
0107cb4a f30f114748 movss dword ptr [rdi + 0x48], xmm0
0107cb4f 41837e3c01 cmp dword ptr [r14 + 0x3c], 1
0107cb54 7224 jb 0x14107cb7a
0107cb56 8b85a4000000 mov eax, dword ptr [rbp + 0xa4]
0107cb5c 89831c010000 mov dword ptr [rbx + 0x11c], eax
0107cb62 8b858c000000 mov eax, dword ptr [rbp + 0x8c]
0107cb68 898314010000 mov dword ptr [rbx + 0x114], eax
0107cb6e 8b85a0000000 mov eax, dword ptr [rbp + 0xa0]
0107cb74 898318010000 mov dword ptr [rbx + 0x118], eax
0107cb7a 8b4734 mov eax, dword ptr [rdi + 0x34]
0107cb7d 3d454c4946 cmp eax, 0x46494c45
0107cb82 752a jne 0x14107cbae
0107cb84 8b455c mov eax, dword ptr [rbp + 0x5c]
0107cb87 8987bc020000 mov dword ptr [rdi + 0x2bc], eax
0107cb8d 0fb7859c000000 movzx eax, word ptr [rbp + 0x9c]
0107cb94 668987c4020000 mov word ptr [rdi + 0x2c4], ax
0107cb9b 0fb7859e000000 movzx eax, word ptr [rbp + 0x9e]
0107cba2 668987c6020000 mov word ptr [rdi + 0x2c6], ax
0107cba9 e9a7000000 jmp 0x14107cc55
0107cbae 3d44524853 cmp eax, 0x53485244
0107cbb3 0f859c000000 jne 0x14107cc55
0107cbb9 4883bdc002000000 cmp qword ptr [rbp + 0x2c0], 0
0107cbc1 750d jne 0x14107cbd0
0107cbc3 8b858c020000 mov eax, dword ptr [rbp + 0x28c]
0107cbc9 488985c0020000 mov qword ptr [rbp + 0x2c0], rax
0107cbd0 0fb685ad020000 movzx eax, byte ptr [rbp + 0x2ad]
0107cbd7 84c0 test al, al
0107cbd9 8bc8 mov ecx, eax
0107cbdb b802000000 mov eax, 2
0107cbe0 0f44c8 cmove ecx, eax
0107cbe3 488b85c8020000 mov rax, qword ptr [rbp + 0x2c8]
0107cbea 888dad020000 mov byte ptr [rbp + 0x2ad], cl
0107cbf0 48898788000000 mov qword ptr [rdi + 0x88], rax
0107cbf7 488b85c0020000 mov rax, qword ptr [rbp + 0x2c0]
0107cbfe 48898780000000 mov qword ptr [rdi + 0x80], rax
0107cc05 0fb685ad020000 movzx eax, byte ptr [rbp + 0x2ad]
0107cc0c 898790000000 mov dword ptr [rdi + 0x90], eax
0107cc12 8b8590020000 mov eax, dword ptr [rbp + 0x290]
0107cc18 898798000000 mov dword ptr [rdi + 0x98], eax
0107cc1e 8b8594020000 mov eax, dword ptr [rbp + 0x294]
0107cc24 89879c000000 mov dword ptr [rdi + 0x9c], eax
0107cc2a 0fb68572020000 movzx eax, byte ptr [rbp + 0x272]
0107cc31 888794000000 mov byte ptr [rdi + 0x94], al
0107cc37 0fb68573020000 movzx eax, byte ptr [rbp + 0x273]
0107cc3e 888795000000 mov byte ptr [rdi + 0x95], al
0107cc44 c6473c01 mov byte ptr [rdi + 0x3c], 1
0107cc48 80bd9f02000000 cmp byte ptr [rbp + 0x29f], 0
0107cc4f 7404 je 0x14107cc55
0107cc51 c6473d01 mov byte ptr [rdi + 0x3d], 1
0107cc55 80bd6b01000000 cmp byte ptr [rbp + 0x16b], 0
0107cc5c 740f je 0x14107cc6d
0107cc5e 488bcf mov rcx, rdi
0107cc61 e85a95f2ff call 0x140fa61c0
0107cc66 488b4718 mov rax, qword ptr [rdi + 0x18]
0107cc6a 800810 or byte ptr [rax], 0x10
0107cc6d 8b95cc010000 mov edx, dword ptr [rbp + 0x1cc]
0107cc73 448b85ac010000 mov r8d, dword ptr [rbp + 0x1ac]
0107cc7a 85d2 test edx, edx
0107cc7c 7521 jne 0x14107cc9f
0107cc7e 4585c0 test r8d, r8d
0107cc81 751c jne 0x14107cc9f
0107cc83 3995d0010000 cmp dword ptr [rbp + 0x1d0], edx
0107cc89 7514 jne 0x14107cc9f
0107cc8b 3995c4010000 cmp dword ptr [rbp + 0x1c4], edx
0107cc91 750c jne 0x14107cc9f
0107cc93 3995c8010000 cmp dword ptr [rbp + 0x1c8], edx
0107cc99 0f8495000000 je 0x14107cd34
0107cc9f 488b4370 mov rax, qword ptr [rbx + 0x70]
0107cca3 f60001 test byte ptr [rax], 1
0107cca6 753a jne 0x14107cce2
0107cca8 488b4b10 mov rcx, qword ptr [rbx + 0x10]
0107ccac 4885c9 test rcx, rcx
0107ccaf 7431 je 0x14107cce2
0107ccb1 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107ccbb 7525 jne 0x14107cce2
0107ccbd 488b8940010000 mov rcx, qword ptr [rcx + 0x140]
0107ccc4 e8e795b4ff call 0x140bc62b0
0107ccc9 48894370 mov qword ptr [rbx + 0x70], rax
0107cccd 4885c0 test rax, rax
0107ccd0 7403 je 0x14107ccd5
0107ccd2 800801 or byte ptr [rax], 1
0107ccd5 448b85ac010000 mov r8d, dword ptr [rbp + 0x1ac]
0107ccdc 8b95cc010000 mov edx, dword ptr [rbp + 0x1cc]
0107cce2 85d2 test edx, edx
0107cce4 7520 jne 0x14107cd06
0107cce6 4181f8018d2700 cmp r8d, 0x278d01
0107cced 7217 jb 0x14107cd06
0107ccef 418d900073d8ff lea edx, [r8 - 0x278d00]
0107ccf6 c785d0010000008d2700 mov dword ptr [rbp + 0x1d0], 0x278d00
0107cd00 8995cc010000 mov dword ptr [rbp + 0x1cc], edx
0107cd06 488b4370 mov rax, qword ptr [rbx + 0x70]
0107cd0a 89500c mov dword ptr [rax + 0xc], edx
0107cd0d 488b4b70 mov rcx, qword ptr [rbx + 0x70]
0107cd11 8b85d0010000 mov eax, dword ptr [rbp + 0x1d0]
0107cd17 894110 mov dword ptr [rcx + 0x10], eax
0107cd1a 488b4b70 mov rcx, qword ptr [rbx + 0x70]
0107cd1e 8b85c4010000 mov eax, dword ptr [rbp + 0x1c4]
0107cd24 894114 mov dword ptr [rcx + 0x14], eax
0107cd27 488b4b70 mov rcx, qword ptr [rbx + 0x70]
0107cd2b 8b85c8010000 mov eax, dword ptr [rbp + 0x1c8]
0107cd31 894118 mov dword ptr [rcx + 0x18], eax
0107cd34 80bd1603000000 cmp byte ptr [rbp + 0x316], 0
0107cd3b 7512 jne 0x14107cd4f
0107cd3d 80bd1703000000 cmp byte ptr [rbp + 0x317], 0
0107cd44 7509 jne 0x14107cd4f
0107cd46 80bd1803000000 cmp byte ptr [rbp + 0x318], 0
0107cd4d 7460 je 0x14107cdaf
0107cd4f 488b4370 mov rax, qword ptr [rbx + 0x70]
0107cd53 f60001 test byte ptr [rax], 1
0107cd56 752d jne 0x14107cd85
0107cd58 488b4b10 mov rcx, qword ptr [rbx + 0x10]
0107cd5c 4885c9 test rcx, rcx
0107cd5f 7424 je 0x14107cd85
0107cd61 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0107cd6b 7518 jne 0x14107cd85
0107cd6d 488b8940010000 mov rcx, qword ptr [rcx + 0x140]
0107cd74 e83795b4ff call 0x140bc62b0
0107cd79 48894370 mov qword ptr [rbx + 0x70], rax
0107cd7d 4885c0 test rax, rax
0107cd80 7403 je 0x14107cd85
0107cd82 800801 or byte ptr [rax], 1
0107cd85 488b4b70 mov rcx, qword ptr [rbx + 0x70]
0107cd89 0fb68516030000 movzx eax, byte ptr [rbp + 0x316]
0107cd90 884120 mov byte ptr [rcx + 0x20], al
0107cd93 488b4b70 mov rcx, qword ptr [rbx + 0x70]
0107cd97 0fb68517030000 movzx eax, byte ptr [rbp + 0x317]
0107cd9e 884121 mov byte ptr [rcx + 0x21], al
0107cda1 488b4b70 mov rcx, qword ptr [rbx + 0x70]
0107cda5 0fb68518030000 movzx eax, byte ptr [rbp + 0x318]
0107cdac 884122 mov byte ptr [rcx + 0x22], al
0107cdaf 80bdb101000000 cmp byte ptr [rbp + 0x1b1], 0
0107cdb6 7547 jne 0x14107cdff
0107cdb8 80bdb201000000 cmp byte ptr [rbp + 0x1b2], 0
0107cdbf 753e jne 0x14107cdff
0107cdc1 6683bdb401000000 cmp word ptr [rbp + 0x1b4], 0
0107cdc9 7534 jne 0x14107cdff
0107cdcb 6683bdb601000000 cmp word ptr [rbp + 0x1b6], 0
0107cdd3 752a jne 0x14107cdff
0107cdd5 83bdb801000000 cmp dword ptr [rbp + 0x1b8], 0
0107cddc 7521 jne 0x14107cdff
0107cdde 6683bdbc01000000 cmp word ptr [rbp + 0x1bc], 0
0107cde6 7517 jne 0x14107cdff
0107cde8 6683bdbe01000000 cmp word ptr [rbp + 0x1be], 0
0107cdf0 750d jne 0x14107cdff
0107cdf2 83bdc001000000 cmp dword ptr [rbp + 0x1c0], 0
0107cdf9 0f8491000000 je 0x14107ce90
0107cdff 488bcf mov rcx, rdi
0107ce02 e8b993f2ff call 0x140fa61c0
0107ce07 488b5718 mov rdx, qword ptr [rdi + 0x18]
0107ce0b 0fb68db1010000 movzx ecx, byte ptr [rbp + 0x1b1]
0107ce12 80e101 and cl, 1
0107ce15 02c9 add cl, cl
0107ce17 0fb602 movzx eax, byte ptr [rdx]
0107ce1a 24fd and al, 0xfd
0107ce1c 0ac8 or cl, al
0107ce1e 880a mov byte ptr [rdx], cl
0107ce20 0fb68db2010000 movzx ecx, byte ptr [rbp + 0x1b2]
0107ce27 488b5718 mov rdx, qword ptr [rdi + 0x18]
0107ce2b 80e101 and cl, 1
0107ce2e c0e102 shl cl, 2
0107ce31 0fb602 movzx eax, byte ptr [rdx]
0107ce34 24fb and al, 0xfb
0107ce36 0ac8 or cl, al
0107ce38 880a mov byte ptr [rdx], cl
0107ce3a 0fb785b4010000 movzx eax, word ptr [rbp + 0x1b4]
0107ce41 488b4f18 mov rcx, qword ptr [rdi + 0x18]
0107ce45 66894102 mov word ptr [rcx + 2], ax
0107ce49 488b4f18 mov rcx, qword ptr [rdi + 0x18]
0107ce4d 0fb785b6010000 movzx eax, word ptr [rbp + 0x1b6]
0107ce54 6689410c mov word ptr [rcx + 0xc], ax
0107ce58 8b85b8010000 mov eax, dword ptr [rbp + 0x1b8]
0107ce5e 488b4f18 mov rcx, qword ptr [rdi + 0x18]
0107ce62 894104 mov dword ptr [rcx + 4], eax
0107ce65 0fb785bc010000 movzx eax, word ptr [rbp + 0x1bc]
0107ce6c 488b4f18 mov rcx, qword ptr [rdi + 0x18]
0107ce70 6689410e mov word ptr [rcx + 0xe], ax
0107ce74 488b4f18 mov rcx, qword ptr [rdi + 0x18]
0107ce78 0fb785be010000 movzx eax, word ptr [rbp + 0x1be]
0107ce7f 66894110 mov word ptr [rcx + 0x10], ax
0107ce83 488b4f18 mov rcx, qword ptr [rdi + 0x18]
0107ce87 8b85c0010000 mov eax, dword ptr [rbp + 0x1c0]
0107ce8d 894108 mov dword ptr [rcx + 8], eax
0107ce90 0fb6839d000000 movzx eax, byte ptr [rbx + 0x9d]
0107ce97 84c0 test al, al
0107ce99 790f jns 0x14107ceaa
0107ce9b 24f7 and al, 0xf7
0107ce9d 88839d000000 mov byte ptr [rbx + 0x9d], al
0107cea3 80a39a000000fd and byte ptr [rbx + 0x9a], 0xfd
0107ceaa 0fb6858c010000 movzx eax, byte ptr [rbp + 0x18c]
0107ceb1 84c0 test al, al
0107ceb3 7408 je 0x14107cebd
0107ceb5 888392000000 mov byte ptr [rbx + 0x92], al
0107cebb eb05 jmp 0x14107cec2
0107cebd c644243001 mov byte ptr [rsp + 0x30], 1
0107cec2 0fb6858d010000 movzx eax, byte ptr [rbp + 0x18d]
0107cec9 84c0 test al, al
0107cecb 7408 je 0x14107ced5
0107cecd 888393000000 mov byte ptr [rbx + 0x93], al
0107ced3 eb05 jmp 0x14107ceda
0107ced5 c644243001 mov byte ptr [rsp + 0x30], 1
0107ceda 0fb6858e010000 movzx eax, byte ptr [rbp + 0x18e]
0107cee1 84c0 test al, al
0107cee3 7408 je 0x14107ceed
0107cee5 888394000000 mov byte ptr [rbx + 0x94], al
0107ceeb eb05 jmp 0x14107cef2
0107ceed c644243001 mov byte ptr [rsp + 0x30], 1
0107cef2 0fb6858f010000 movzx eax, byte ptr [rbp + 0x18f]
0107cef9 84c0 test al, al
0107cefb 7408 je 0x14107cf05
0107cefd 888395000000 mov byte ptr [rbx + 0x95], al
0107cf03 eb05 jmp 0x14107cf0a
0107cf05 c644243001 mov byte ptr [rsp + 0x30], 1
0107cf0a 0fb68590010000 movzx eax, byte ptr [rbp + 0x190]
0107cf11 84c0 test al, al
0107cf13 7408 je 0x14107cf1d
0107cf15 888396000000 mov byte ptr [rbx + 0x96], al
0107cf1b eb05 jmp 0x14107cf22
0107cf1d c644243001 mov byte ptr [rsp + 0x30], 1
0107cf22 0fb68591010000 movzx eax, byte ptr [rbp + 0x191]
0107cf29 84c0 test al, al
0107cf2b 7408 je 0x14107cf35
0107cf2d 888397000000 mov byte ptr [rbx + 0x97], al
0107cf33 eb05 jmp 0x14107cf3a
0107cf35 c644243001 mov byte ptr [rsp + 0x30], 1
0107cf3a 498d8ea802e001 lea rcx, [r14 + 0x1e002a8]
0107cf41 4c8d4df8 lea r9, [rbp - 8]
0107cf45 4c8d8534020000 lea r8, [rbp + 0x234]
0107cf4c 488d5508 lea rdx, [rbp + 8]
0107cf50 e81b6661ff call 0x140693570
0107cf55 837c244801 cmp dword ptr [rsp + 0x48], 1
0107cf5a 7538 jne 0x14107cf94
0107cf5c 498d8e7802e001 lea rcx, [r14 + 0x1e00278]
0107cf63 4c8d4c2450 lea r9, [rsp + 0x50]
0107cf68 4c8d4550 lea r8, [rbp + 0x50]
0107cf6c 488d9560030000 lea rdx, [rbp + 0x360]
0107cf73 e8f86561ff call 0x140693570
0107cf78 498d8e9002e001 lea rcx, [r14 + 0x1e00290]
0107cf7f 4c8d4c2450 lea r9, [rsp + 0x50]
0107cf84 4c8d85c0000000 lea r8, [rbp + 0xc0]
0107cf8b 488d5520 lea rdx, [rbp + 0x20]
0107cf8f e85c99a7ff call 0x140af68f0
0107cf94 33c0 xor eax, eax
0107cf96 89442440 mov dword ptr [rsp + 0x40], eax
0107cf9a 39454c cmp dword ptr [rbp + 0x4c], eax
0107cf9d 0f8670150000 jbe 0x14107e513
0107cfa3 41b808000000 mov r8d, 8
0107cfa9 4c8965f8 mov qword ptr [rbp - 8], r12
0107cfad 488d9560030000 lea rdx, [rbp + 0x360]
0107cfb4 498bce mov rcx, r14
0107cfb7 e8e4a0ffff call 0x1410770a0
0107cfbc 8bf0 mov esi, eax
0107cfbe 85c0 test eax, eax
0107cfc0 0f8540170000 jne 0x14107e706
0107cfc6 448b9564030000 mov r10d, dword ptr [rbp + 0x364]
0107cfcd 458bfa mov r15d, r10d
0107cfd0 41380424 cmp byte ptr [r12], al
0107cfd4 7503 jne 0x14107cfd9
0107cfd6 410fcf bswap r15d
0107cfd9 41bd18000000 mov r13d, 0x18
0107cfdf 488d8d68030000 lea rcx, [rbp + 0x368]
0107cfe6 453bfd cmp r15d, r13d
0107cfe9 450f42ef cmovb r13d, r15d
0107cfed 4183fd08 cmp r13d, 8
0107cff1 763e jbe 0x14107d031
0107cff3 458d65f8 lea r12d, [r13 - 8]
0107cff7 4981fc0000a000 cmp r12, 0xa00000
0107cffe 0f87a3170000 ja 0x14107e7a7
0107d004 458bc4 mov r8d, r12d
0107d007 488d9568030000 lea rdx, [rbp + 0x368]
0107d00e 498bce mov rcx, r14
0107d011 e88aa0ffff call 0x1410770a0
0107d016 8bf0 mov esi, eax
0107d018 85c0 test eax, eax
0107d01a 0f85e6160000 jne 0x14107e706
0107d020 448b9564030000 mov r10d, dword ptr [rbp + 0x364]
0107d027 488d8d68030000 lea rcx, [rbp + 0x368]
0107d02e 4903cc add rcx, r12
0107d031 4183fd18 cmp r13d, 0x18
0107d035 731c jae 0x14107d053
0107d037 4885c9 test rcx, rcx
0107d03a 7417 je 0x14107d053
0107d03c 41b818000000 mov r8d, 0x18
0107d042 33d2 xor edx, edx
0107d044 452bc5 sub r8d, r13d
0107d047 e854fc7100 call 0x14179cca0
0107d04c 448b9564030000 mov r10d, dword ptr [rbp + 0x364]
0107d053 453bfd cmp r15d, r13d
0107d056 7618 jbe 0x14107d070
0107d058 452bfd sub r15d, r13d
0107d05b 498bce mov rcx, r14
0107d05e 418bd7 mov edx, r15d
0107d061 e8bad4feff call 0x14106a520
0107d066 8bf0 mov esi, eax
0107d068 85c0 test eax, eax
0107d06a 0f8596160000 jne 0x14107e706
0107d070 488b45f8 mov rax, qword ptr [rbp - 8]
0107d074 4c8be0 mov r12, rax
0107d077 803800 cmp byte ptr [rax], 0
0107d07a 0f8508010000 jne 0x14107d188
0107d080 8b8d60030000 mov ecx, dword ptr [rbp + 0x360]
0107d086 8bd1 mov edx, ecx
0107d088 8bc1 mov eax, ecx
0107d08a 81e20000ff00 and edx, 0xff0000
0107d090 c1e810 shr eax, 0x10
0107d093 0bd0 or edx, eax
0107d095 8bc1 mov eax, ecx
0107d097 c1e010 shl eax, 0x10
0107d09a 81e100ff0000 and ecx, 0xff00
0107d0a0 0bc1 or eax, ecx
0107d0a2 c1ea08 shr edx, 8
0107d0a5 c1e008 shl eax, 8
0107d0a8 418bca mov ecx, r10d
0107d0ab 0bd0 or edx, eax
0107d0ad 81e10000ff00 and ecx, 0xff0000
0107d0b3 418bc2 mov eax, r10d
0107d0b6 899560030000 mov dword ptr [rbp + 0x360], edx
0107d0bc c1e810 shr eax, 0x10
0107d0bf 0bc8 or ecx, eax
0107d0c1 418bc2 mov eax, r10d
0107d0c4 c1e010 shl eax, 0x10
0107d0c7 4181e200ff0000 and r10d, 0xff00
0107d0ce 410bc2 or eax, r10d
0107d0d1 c1e908 shr ecx, 8
0107d0d4 c1e008 shl eax, 8
0107d0d7 448bd1 mov r10d, ecx
0107d0da 8b8d68030000 mov ecx, dword ptr [rbp + 0x368]
0107d0e0 440bd0 or r10d, eax
0107d0e3 8bc1 mov eax, ecx
0107d0e5 44899564030000 mov dword ptr [rbp + 0x364], r10d
0107d0ec c1e810 shr eax, 0x10
0107d0ef 448bf9 mov r15d, ecx
0107d0f2 4181e70000ff00 and r15d, 0xff0000
0107d0f9 440bf8 or r15d, eax
0107d0fc 8bc1 mov eax, ecx
0107d0fe c1e010 shl eax, 0x10
0107d101 81e100ff0000 and ecx, 0xff00
0107d107 0bc1 or eax, ecx
0107d109 41c1ef08 shr r15d, 8
0107d10d 8b8d6c030000 mov ecx, dword ptr [rbp + 0x36c]
0107d113 448bc1 mov r8d, ecx
0107d116 c1e008 shl eax, 8
0107d119 4181e00000ff00 and r8d, 0xff0000
0107d120 440bf8 or r15d, eax
0107d123 8bc1 mov eax, ecx
0107d125 c1e810 shr eax, 0x10
0107d128 440bc0 or r8d, eax
0107d12b 4489bd68030000 mov dword ptr [rbp + 0x368], r15d
0107d132 8bc1 mov eax, ecx
0107d134 41c1e808 shr r8d, 8
0107d138 c1e010 shl eax, 0x10
0107d13b 81e100ff0000 and ecx, 0xff00
0107d141 0bc1 or eax, ecx
0107d143 8b8d70030000 mov ecx, dword ptr [rbp + 0x370]
0107d149 c1e008 shl eax, 8
0107d14c 448bc9 mov r9d, ecx
0107d14f 440bc0 or r8d, eax
0107d152 4181e10000ff00 and r9d, 0xff0000
0107d159 8bc1 mov eax, ecx
0107d15b 4489856c030000 mov dword ptr [rbp + 0x36c], r8d
0107d162 c1e810 shr eax, 0x10
0107d165 440bc8 or r9d, eax
0107d168 8bc1 mov eax, ecx
0107d16a c1e010 shl eax, 0x10
0107d16d 81e100ff0000 and ecx, 0xff00
0107d173 0bc1 or eax, ecx
0107d175 41c1e908 shr r9d, 8
0107d179 c1e008 shl eax, 8
0107d17c 440bc8 or r9d, eax
0107d17f 44898d70030000 mov dword ptr [rbp + 0x370], r9d
0107d186 eb1b jmp 0x14107d1a3
0107d188 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107d18f 448b856c030000 mov r8d, dword ptr [rbp + 0x36c]
0107d196 448bbd68030000 mov r15d, dword ptr [rbp + 0x368]
0107d19d 8b9560030000 mov edx, dword ptr [rbp + 0x360]
0107d1a3 81fa6d686f68 cmp edx, 0x686f686d
0107d1a9 0f85f8150000 jne 0x14107e7a7
0107d1af 4533ed xor r13d, r13d
0107d1b2 452bfa sub r15d, r10d
0107d1b5 41ffc8 dec r8d
0107d1b8 418bf5 mov esi, r13d
0107d1bb 4183f841 cmp r8d, 0x41
0107d1bf 0f8702130000 ja 0x14107e4c7
0107d1c5 488d15342ef8fe lea rdx, [rip - 0x107d1cc]
0107d1cc 428b8c82b4e70701 mov ecx, dword ptr [rdx + r8*4 + 0x107e7b4]
0107d1d4 4803ca add rcx, rdx
0107d1d7 ffe1 jmp rcx
0107d1d9 4c8b87c8020000 mov r8, qword ptr [rdi + 0x2c8]
0107d1e0 488d87b8020000 lea rax, [rdi + 0x2b8]
0107d1e7 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d1ec 4533c9 xor r9d, r9d
0107d1ef ba01000000 mov edx, 1
0107d1f4 4889442420 mov qword ptr [rsp + 0x20], rax
0107d1f9 498bce mov rcx, r14
0107d1fc e8cfa1ffff call 0x1410773d0
0107d201 e9db110000 jmp 0x14107e3e1
0107d206 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d20b 488d83b0000000 lea rax, [rbx + 0xb0]
0107d212 4981c078010000 add r8, 0x178
0107d219 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d21e ba01000000 mov edx, 1
0107d223 4889442420 mov qword ptr [rsp + 0x20], rax
0107d228 498bce mov rcx, r14
0107d22b e8a0a1ffff call 0x1410773d0
0107d230 808d4003000020 or byte ptr [rbp + 0x340], 0x20
0107d237 e9a5110000 jmp 0x14107e3e1
0107d23c 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d241 488d83bc000000 lea rax, [rbx + 0xbc]
0107d248 4981c0c0010000 add r8, 0x1c0
0107d24f 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d254 ba01000000 mov edx, 1
0107d259 4889442420 mov qword ptr [rsp + 0x20], rax
0107d25e 498bce mov rcx, r14
0107d261 e86aa1ffff call 0x1410773d0
0107d266 808d4003000010 or byte ptr [rbp + 0x340], 0x10
0107d26d e96f110000 jmp 0x14107e3e1
0107d272 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d277 488d83c0000000 lea rax, [rbx + 0xc0]
0107d27e 4981c050020000 add r8, 0x250
0107d285 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d28a ba01000000 mov edx, 1
0107d28f 4889442420 mov qword ptr [rsp + 0x20], rax
0107d294 498bce mov rcx, r14
0107d297 e834a1ffff call 0x1410773d0
0107d29c 808d4403000001 or byte ptr [rbp + 0x344], 1
0107d2a3 e939110000 jmp 0x14107e3e1
0107d2a8 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d2ad 488d83b4000000 lea rax, [rbx + 0xb4]
0107d2b4 4981c008020000 add r8, 0x208
0107d2bb 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d2c0 ba01000000 mov edx, 1
0107d2c5 4889442420 mov qword ptr [rsp + 0x20], rax
0107d2ca 498bce mov rcx, r14
0107d2cd e8fea0ffff call 0x1410773d0
0107d2d2 808d4003000008 or byte ptr [rbp + 0x340], 8
0107d2d9 e903110000 jmp 0x14107e3e1
0107d2de 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d2e3 488d83b8000000 lea rax, [rbx + 0xb8]
0107d2ea 4981c008020000 add r8, 0x208
0107d2f1 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d2f6 ba01000000 mov edx, 1
0107d2fb 4889442420 mov qword ptr [rsp + 0x20], rax
0107d300 498bce mov rcx, r14
0107d303 e8c8a0ffff call 0x1410773d0
0107d308 808d4803000001 or byte ptr [rbp + 0x348], 1
0107d30f e9cd100000 jmp 0x14107e3e1
0107d314 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d319 488d83c4000000 lea rax, [rbx + 0xc4]
0107d320 4981c008020000 add r8, 0x208
0107d327 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d32c ba01000000 mov edx, 1
0107d331 4889442420 mov qword ptr [rsp + 0x20], rax
0107d336 498bce mov rcx, r14
0107d339 e892a0ffff call 0x1410773d0
0107d33e 808d4203000020 or byte ptr [rbp + 0x342], 0x20
0107d345 e997100000 jmp 0x14107e3e1
0107d34a 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d34f 488d83c8000000 lea rax, [rbx + 0xc8]
0107d356 4981c028030000 add r8, 0x328
0107d35d 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d362 ba01000000 mov edx, 1
0107d367 4889442420 mov qword ptr [rsp + 0x20], rax
0107d36c 498bce mov rcx, r14
0107d36f e85ca0ffff call 0x1410773d0
0107d374 808d4103000080 or byte ptr [rbp + 0x341], 0x80
0107d37b e961100000 jmp 0x14107e3e1
0107d380 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d385 488d83cc000000 lea rax, [rbx + 0xcc]
0107d38c 4981c070030000 add r8, 0x370
0107d393 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d398 ba01000000 mov edx, 1
0107d39d 4889442420 mov qword ptr [rsp + 0x20], rax
0107d3a2 498bce mov rcx, r14
0107d3a5 e826a0ffff call 0x1410773d0
0107d3aa 808d4103000040 or byte ptr [rbp + 0x341], 0x40
0107d3b1 e92b100000 jmp 0x14107e3e1
0107d3b6 4c8b6c2438 mov r13, qword ptr [rsp + 0x38]
0107d3bb 4c8dbbd0000000 lea r15, [rbx + 0xd0]
0107d3c2 33c0 xor eax, eax
0107d3c4 4981c5b8030000 add r13, 0x3b8
0107d3cb 89442428 mov dword ptr [rsp + 0x28], eax
0107d3cf 4d8bc5 mov r8, r13
0107d3d2 4533c9 xor r9d, r9d
0107d3d5 4c897c2420 mov qword ptr [rsp + 0x20], r15
0107d3da ba01000000 mov edx, 1
0107d3df 498bce mov rcx, r14
0107d3e2 e8e99fffff call 0x1410773d0
0107d3e7 8bf0 mov esi, eax
0107d3e9 85c0 test eax, eax
0107d3eb 0f8515130000 jne 0x14107e706
0107d3f1 418b17 mov edx, dword ptr [r15]
0107d3f4 4c8d85e0030000 lea r8, [rbp + 0x3e0]
0107d3fb 498bcd mov rcx, r13
0107d3fe e86d20b8ff call 0x140bff470
0107d403 488d95e0030000 lea rdx, [rbp + 0x3e0]
0107d40a 488d8de0030000 lea rcx, [rbp + 0x3e0]
0107d411 e89acce2ff call 0x140eaa0b0
0107d416 84c0 test al, al
0107d418 0f84d9100000 je 0x14107e4f7
0107d41e 4d8bc7 mov r8, r15
0107d421 488d95e0030000 lea rdx, [rbp + 0x3e0]
0107d428 498bcd mov rcx, r13
0107d42b e81019b8ff call 0x140bfed40
0107d430 808d4203000040 or byte ptr [rbp + 0x342], 0x40
0107d437 e9a50f0000 jmp 0x14107e3e1
0107d43c 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d441 488d83d4000000 lea rax, [rbx + 0xd4]
0107d448 4981c000040000 add r8, 0x400
0107d44f 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d454 ba01000000 mov edx, 1
0107d459 4889442420 mov qword ptr [rsp + 0x20], rax
0107d45e 498bce mov rcx, r14
0107d461 e86a9fffff call 0x1410773d0
0107d466 808d4103000002 or byte ptr [rbp + 0x341], 2
0107d46d e96f0f0000 jmp 0x14107e3e1
0107d472 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d477 488d83d8000000 lea rax, [rbx + 0xd8]
0107d47e 4981c048040000 add r8, 0x448
0107d485 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d48a ba01000000 mov edx, 1
0107d48f 4889442420 mov qword ptr [rsp + 0x20], rax
0107d494 498bce mov rcx, r14
0107d497 e8349fffff call 0x1410773d0
0107d49c 808d4603000001 or byte ptr [rbp + 0x346], 1
0107d4a3 e9390f0000 jmp 0x14107e3e1
0107d4a8 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d4ad 488d83dc000000 lea rax, [rbx + 0xdc]
0107d4b4 4981c090040000 add r8, 0x490
0107d4bb 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d4c0 ba01000000 mov edx, 1
0107d4c5 4889442420 mov qword ptr [rsp + 0x20], rax
0107d4ca 498bce mov rcx, r14
0107d4cd e8fe9effff call 0x1410773d0
0107d4d2 808d4203000004 or byte ptr [rbp + 0x342], 4
0107d4d9 e9030f0000 jmp 0x14107e3e1
0107d4de 488bcb mov rcx, rbx
0107d4e1 e81a5af1ff call 0x140f92f00
0107d4e6 488b4368 mov rax, qword ptr [rbx + 0x68]
0107d4ea ba01000000 mov edx, 1
0107d4ef 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d4f4 4883c034 add rax, 0x34
0107d4f8 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107d4ff 4981c020050000 add r8, 0x520
0107d506 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d50b 498bce mov rcx, r14
0107d50e 4889442420 mov qword ptr [rsp + 0x20], rax
0107d513 e8b89effff call 0x1410773d0
0107d518 808d4603000002 or byte ptr [rbp + 0x346], 2
0107d51f e9bd0e0000 jmp 0x14107e3e1
0107d524 488bcb mov rcx, rbx
0107d527 e8d459f1ff call 0x140f92f00
0107d52c 488b4368 mov rax, qword ptr [rbx + 0x68]
0107d530 ba01000000 mov edx, 1
0107d535 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d53a 4883c038 add rax, 0x38
0107d53e 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107d545 4981c020050000 add r8, 0x520
0107d54c 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d551 498bce mov rcx, r14
0107d554 4889442420 mov qword ptr [rsp + 0x20], rax
0107d559 e8729effff call 0x1410773d0
0107d55e 808d4a03000002 or byte ptr [rbp + 0x34a], 2
0107d565 e9770e0000 jmp 0x14107e3e1
0107d56a 488bcb mov rcx, rbx
0107d56d e88e59f1ff call 0x140f92f00
0107d572 488b4368 mov rax, qword ptr [rbx + 0x68]
0107d576 ba01000000 mov edx, 1
0107d57b 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d580 4883c03c add rax, 0x3c
0107d584 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107d58b 4981c020050000 add r8, 0x520
0107d592 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d597 498bce mov rcx, r14
0107d59a 4889442420 mov qword ptr [rsp + 0x20], rax
0107d59f e82c9effff call 0x1410773d0
0107d5a4 808d4f03000001 or byte ptr [rbp + 0x34f], 1
0107d5ab e9310e0000 jmp 0x14107e3e1
0107d5b0 488bcb mov rcx, rbx
0107d5b3 e8b859f1ff call 0x140f92f70
0107d5b8 488b4370 mov rax, qword ptr [rbx + 0x70]
0107d5bc ba01000000 mov edx, 1
0107d5c1 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d5c6 4883c028 add rax, 0x28
0107d5ca 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107d5d1 4981c040060000 add r8, 0x640
0107d5d8 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d5dd 498bce mov rcx, r14
0107d5e0 4889442420 mov qword ptr [rsp + 0x20], rax
0107d5e5 e8e69dffff call 0x1410773d0
0107d5ea 808d4703000002 or byte ptr [rbp + 0x347], 2
0107d5f1 e9eb0d0000 jmp 0x14107e3e1
0107d5f6 488bcb mov rcx, rbx
0107d5f9 e87259f1ff call 0x140f92f70
0107d5fe 488b4370 mov rax, qword ptr [rbx + 0x70]
0107d602 ba01000000 mov edx, 1
0107d607 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d60c 4883c02c add rax, 0x2c
0107d610 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107d617 4981c0d0060000 add r8, 0x6d0
0107d61e 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d623 498bce mov rcx, r14
0107d626 4889442420 mov qword ptr [rsp + 0x20], rax
0107d62b e8a09dffff call 0x1410773d0
0107d630 808d4803000080 or byte ptr [rbp + 0x348], 0x80
0107d637 e9a50d0000 jmp 0x14107e3e1
0107d63c 488bcb mov rcx, rbx
0107d63f e82c59f1ff call 0x140f92f70
0107d644 488b4370 mov rax, qword ptr [rbx + 0x70]
0107d648 ba01000000 mov edx, 1
0107d64d 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d652 4883c030 add rax, 0x30
0107d656 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107d65d 4981c0d0060000 add r8, 0x6d0
0107d664 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d669 498bce mov rcx, r14
0107d66c 4889442420 mov qword ptr [rsp + 0x20], rax
0107d671 e85a9dffff call 0x1410773d0
0107d676 808d5503000080 or byte ptr [rbp + 0x355], 0x80
0107d67d e95f0d0000 jmp 0x14107e3e1
0107d682 488bcb mov rcx, rbx
0107d685 e87658f1ff call 0x140f92f00
0107d68a 4181ff0000a000 cmp r15d, 0xa00000
0107d691 0f8710110000 ja 0x14107e7a7
0107d697 458bc7 mov r8d, r15d
0107d69a 498d962801a000 lea rdx, [r14 + 0xa00128]
0107d6a1 498bce mov rcx, r14
0107d6a4 e8f799ffff call 0x1410770a0
0107d6a9 8bf0 mov esi, eax
0107d6ab 85c0 test eax, eax
0107d6ad 0f8553100000 jne 0x14107e706
0107d6b3 4c8b4b68 mov r9, qword ptr [rbx + 0x68]
0107d6b7 498d962801a000 lea rdx, [r14 + 0xa00128]
0107d6be 488b4c2438 mov rcx, qword ptr [rsp + 0x38]
0107d6c3 4983c120 add r9, 0x20
0107d6c7 4881c168050000 add rcx, 0x568
0107d6ce 458bc7 mov r8d, r15d
0107d6d1 e81a0bb8ff call 0x140bfe1f0
0107d6d6 8bf0 mov esi, eax
0107d6d8 85c0 test eax, eax
0107d6da 0f8526100000 jne 0x14107e706
0107d6e0 808d4a03000001 or byte ptr [rbp + 0x34a], 1
0107d6e7 e90b0e0000 jmp 0x14107e4f7
0107d6ec 488bcb mov rcx, rbx
0107d6ef e80c58f1ff call 0x140f92f00
0107d6f4 488b4368 mov rax, qword ptr [rbx + 0x68]
0107d6f8 33d2 xor edx, edx
0107d6fa 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d6ff 4883c024 add rax, 0x24
0107d703 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107d70a 4981c0b0050000 add r8, 0x5b0
0107d711 c744242801000000 mov dword ptr [rsp + 0x28], 1
0107d719 498bce mov rcx, r14
0107d71c 4889442420 mov qword ptr [rsp + 0x20], rax
0107d721 e8aa9cffff call 0x1410773d0
0107d726 808d4a03000004 or byte ptr [rbp + 0x34a], 4
0107d72d e9af0c0000 jmp 0x14107e3e1
0107d732 488bcb mov rcx, rbx
0107d735 e8c657f1ff call 0x140f92f00
0107d73a 488b4368 mov rax, qword ptr [rbx + 0x68]
0107d73e 33d2 xor edx, edx
0107d740 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d745 4883c028 add rax, 0x28
0107d749 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107d750 4981c0b0050000 add r8, 0x5b0
0107d757 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d75c 498bce mov rcx, r14
0107d75f 4889442420 mov qword ptr [rsp + 0x20], rax
0107d764 e8679cffff call 0x1410773d0
0107d769 808d4a03000004 or byte ptr [rbp + 0x34a], 4
0107d770 e96c0c0000 jmp 0x14107e3e1
0107d775 488bcb mov rcx, rbx
0107d778 e88357f1ff call 0x140f92f00
0107d77d 488b4368 mov rax, qword ptr [rbx + 0x68]
0107d781 33d2 xor edx, edx
0107d783 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d788 4883c02c add rax, 0x2c
0107d78c 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107d793 4981c0f8050000 add r8, 0x5f8
0107d79a c744242801000000 mov dword ptr [rsp + 0x28], 1
0107d7a2 498bce mov rcx, r14
0107d7a5 4889442420 mov qword ptr [rsp + 0x20], rax
0107d7aa e8219cffff call 0x1410773d0
0107d7af e92d0c0000 jmp 0x14107e3e1
0107d7b4 488bcb mov rcx, rbx
0107d7b7 e84457f1ff call 0x140f92f00
0107d7bc 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d7c1 488d45f0 lea rax, [rbp - 0x10]
0107d7c5 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107d7cc 4981c0b0050000 add r8, 0x5b0
0107d7d3 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d7d8 33d2 xor edx, edx
0107d7da 498bce mov rcx, r14
0107d7dd 4889442420 mov qword ptr [rsp + 0x20], rax
0107d7e2 e8e99bffff call 0x1410773d0
0107d7e7 e9f50b0000 jmp 0x14107e3e1
0107d7ec 488bcb mov rcx, rbx
0107d7ef e87c57f1ff call 0x140f92f70
0107d7f4 488b4370 mov rax, qword ptr [rbx + 0x70]
0107d7f8 ba02000000 mov edx, 2
0107d7fd 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107d802 4883c024 add rax, 0x24
0107d806 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107d80d 4981c060070000 add r8, 0x760
0107d814 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d819 498bce mov rcx, r14
0107d81c 4889442420 mov qword ptr [rsp + 0x20], rax
0107d821 e8aa9bffff call 0x1410773d0
0107d826 808d4a03000008 or byte ptr [rbp + 0x34a], 8
0107d82d e9af0b0000 jmp 0x14107e3e1
0107d832 488b4b10 mov rcx, qword ptr [rbx + 0x10]
0107d836 488d9360010000 lea rdx, [rbx + 0x160]
0107d83d 33c0 xor eax, eax
0107d83f 44896c2460 mov dword ptr [rsp + 0x60], r13d
0107d844 48894580 mov qword ptr [rbp - 0x80], rax
0107d848 0f57c0 xorps xmm0, xmm0
0107d84b 8945ac mov dword ptr [rbp - 0x54], eax
0107d84e 4533c0 xor r8d, r8d
0107d851 488945e0 mov qword ptr [rbp - 0x20], rax
0107d855 488d0544a8e3ff lea rax, [rip - 0x1c57bc]
0107d85c 0f294590 movaps xmmword ptr [rbp - 0x70], xmm0
0107d860 660f6f059875bf00 movdqa xmm0, xmmword ptr [rip + 0xbf7598]
0107d868 4889442470 mov qword ptr [rsp + 0x70], rax
0107d86d 488d8392000000 lea rax, [rbx + 0x92]
0107d874 660f7f45b0 movdqa xmmword ptr [rbp - 0x50], xmm0
0107d879 660f6f05df75bf00 movdqa xmm0, xmmword ptr [rip + 0xbf75df]
0107d881 48894588 mov qword ptr [rbp - 0x78], rax
0107d885 8b02 mov eax, dword ptr [rdx]
0107d887 8945a8 mov dword ptr [rbp - 0x58], eax
0107d88a b802000000 mov eax, 2
0107d88f 660f7f45c0 movdqa xmmword ptr [rbp - 0x40], xmm0
0107d894 660f6f058474bf00 movdqa xmm0, xmmword ptr [rip + 0xbf7484]
0107d89c 89442464 mov dword ptr [rsp + 0x64], eax
0107d8a0 4c8945a0 mov qword ptr [rbp - 0x60], r8
0107d8a4 48895c2478 mov qword ptr [rsp + 0x78], rbx
0107d8a9 c74424684e000000 mov dword ptr [rsp + 0x68], 0x4e
0107d8b1 c744246c1e000000 mov dword ptr [rsp + 0x6c], 0x1e
0107d8b9 660f7f45d0 movdqa xmmword ptr [rbp - 0x30], xmm0
0107d8be 4885c9 test rcx, rcx
0107d8c1 742c je 0x14107d8ef
0107d8c3 488d83a1000000 lea rax, [rbx + 0xa1]
0107d8ca 48894580 mov qword ptr [rbp - 0x80], rax
0107d8ce 4c8d8168170000 lea r8, [rcx + 0x1768]
0107d8d5 488d8178010000 lea rax, [rcx + 0x178]
0107d8dc 4c8945a0 mov qword ptr [rbp - 0x60], r8
0107d8e0 48894590 mov qword ptr [rbp - 0x70], rax
0107d8e4 488d83b0000000 lea rax, [rbx + 0xb0]
0107d8eb 48894598 mov qword ptr [rbp - 0x68], rax
0107d8ef 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d8f4 498bce mov rcx, r14
0107d8f7 4889542420 mov qword ptr [rsp + 0x20], rdx
0107d8fc ba01000000 mov edx, 1
0107d901 e8ca9affff call 0x1410773d0
0107d906 808d4903000002 or byte ptr [rbp + 0x349], 2
0107d90d e9cf0a0000 jmp 0x14107e3e1
0107d912 488b4b10 mov rcx, qword ptr [rbx + 0x10]
0107d916 488d9364010000 lea rdx, [rbx + 0x164]
0107d91d 33c0 xor eax, eax
0107d91f 48895c2478 mov qword ptr [rsp + 0x78], rbx
0107d924 0f57c0 xorps xmm0, xmm0
0107d927 48894580 mov qword ptr [rbp - 0x80], rax
0107d92b 0f294590 movaps xmmword ptr [rbp - 0x70], xmm0
0107d92f 4533c0 xor r8d, r8d
0107d932 660f6f05d674bf00 movdqa xmm0, xmmword ptr [rip + 0xbf74d6]
0107d93a 41ba01000000 mov r10d, 1
0107d940 8945ac mov dword ptr [rbp - 0x54], eax
0107d943 488945e0 mov qword ptr [rbp - 0x20], rax
0107d947 488d0552a7e3ff lea rax, [rip - 0x1c58ae]
0107d94e 660f7f45b0 movdqa xmmword ptr [rbp - 0x50], xmm0
0107d953 660f6f051575bf00 movdqa xmm0, xmmword ptr [rip + 0xbf7515]
0107d95b 4889442470 mov qword ptr [rsp + 0x70], rax
0107d960 488d8393000000 lea rax, [rbx + 0x93]
0107d967 660f7f45c0 movdqa xmmword ptr [rbp - 0x40], xmm0
0107d96c 660f6f05cc73bf00 movdqa xmm0, xmmword ptr [rip + 0xbf73cc]
0107d974 48894588 mov qword ptr [rbp - 0x78], rax
0107d978 8b02 mov eax, dword ptr [rdx]
0107d97a 660f7f45d0 movdqa xmmword ptr [rbp - 0x30], xmm0
0107d97f 4c8945a0 mov qword ptr [rbp - 0x60], r8
0107d983 4489542460 mov dword ptr [rsp + 0x60], r10d
0107d988 8945a8 mov dword ptr [rbp - 0x58], eax
0107d98b c744246403000000 mov dword ptr [rsp + 0x64], 3
0107d993 c74424684f000000 mov dword ptr [rsp + 0x68], 0x4f
0107d99b c744246c1f000000 mov dword ptr [rsp + 0x6c], 0x1f
0107d9a3 4885c9 test rcx, rcx
0107d9a6 742c je 0x14107d9d4
0107d9a8 488d83a3000000 lea rax, [rbx + 0xa3]
0107d9af 48894580 mov qword ptr [rbp - 0x80], rax
0107d9b3 4c8d81b0170000 lea r8, [rcx + 0x17b0]
0107d9ba 488d81c0010000 lea rax, [rcx + 0x1c0]
0107d9c1 4c8945a0 mov qword ptr [rbp - 0x60], r8
0107d9c5 48894590 mov qword ptr [rbp - 0x70], rax
0107d9c9 488d83bc000000 lea rax, [rbx + 0xbc]
0107d9d0 48894598 mov qword ptr [rbp - 0x68], rax
0107d9d4 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107d9d9 498bce mov rcx, r14
0107d9dc 4889542420 mov qword ptr [rsp + 0x20], rdx
0107d9e1 418bd2 mov edx, r10d
0107d9e4 e8e799ffff call 0x1410773d0
0107d9e9 808d4903000001 or byte ptr [rbp + 0x349], 1
0107d9f0 e9ec090000 jmp 0x14107e3e1
0107d9f5 488b4b10 mov rcx, qword ptr [rbx + 0x10]
0107d9f9 488d9368010000 lea rdx, [rbx + 0x168]
0107da00 33c0 xor eax, eax
0107da02 48895c2478 mov qword ptr [rsp + 0x78], rbx
0107da07 48894580 mov qword ptr [rbp - 0x80], rax
0107da0b 0f57c0 xorps xmm0, xmm0
0107da0e 8945ac mov dword ptr [rbp - 0x54], eax
0107da11 4533c0 xor r8d, r8d
0107da14 488945e0 mov qword ptr [rbp - 0x20], rax
0107da18 b802000000 mov eax, 2
0107da1d 89442460 mov dword ptr [rsp + 0x60], eax
0107da21 488d0578a6e3ff lea rax, [rip - 0x1c5988]
0107da28 4889442470 mov qword ptr [rsp + 0x70], rax
0107da2d 488d8394000000 lea rax, [rbx + 0x94]
0107da34 0f294590 movaps xmmword ptr [rbp - 0x70], xmm0
0107da38 660f6f05e073bf00 movdqa xmm0, xmmword ptr [rip + 0xbf73e0]
0107da40 48894588 mov qword ptr [rbp - 0x78], rax
0107da44 8b02 mov eax, dword ptr [rdx]
0107da46 8945a8 mov dword ptr [rbp - 0x58], eax
0107da49 4c8945a0 mov qword ptr [rbp - 0x60], r8
0107da4d c744246404000000 mov dword ptr [rsp + 0x64], 4
0107da55 c744246850000000 mov dword ptr [rsp + 0x68], 0x50
0107da5d c744246c20000000 mov dword ptr [rsp + 0x6c], 0x20
0107da65 660f7f45b0 movdqa xmmword ptr [rbp - 0x50], xmm0
0107da6a 66440f7f7dc0 movdqa xmmword ptr [rbp - 0x40], xmm15
0107da70 66440f7f75d0 movdqa xmmword ptr [rbp - 0x30], xmm14
0107da76 4885c9 test rcx, rcx
0107da79 742c je 0x14107daa7
0107da7b 488d83a2000000 lea rax, [rbx + 0xa2]
0107da82 48894580 mov qword ptr [rbp - 0x80], rax
0107da86 4c8d81f8170000 lea r8, [rcx + 0x17f8]
0107da8d 488d8108020000 lea rax, [rcx + 0x208]
0107da94 4c8945a0 mov qword ptr [rbp - 0x60], r8
0107da98 48894590 mov qword ptr [rbp - 0x70], rax
0107da9c 488d83b4000000 lea rax, [rbx + 0xb4]
0107daa3 48894598 mov qword ptr [rbp - 0x68], rax
0107daa7 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107daac 498bce mov rcx, r14
0107daaf 4889542420 mov qword ptr [rsp + 0x20], rdx
0107dab4 ba01000000 mov edx, 1
0107dab9 e81299ffff call 0x1410773d0
0107dabe 808d4a03000080 or byte ptr [rbp + 0x34a], 0x80
0107dac5 e917090000 jmp 0x14107e3e1
0107daca 488b4b10 mov rcx, qword ptr [rbx + 0x10]
0107dace 488d936c010000 lea rdx, [rbx + 0x16c]
0107dad5 33c0 xor eax, eax
0107dad7 c744246003000000 mov dword ptr [rsp + 0x60], 3
0107dadf 48894580 mov qword ptr [rbp - 0x80], rax
0107dae3 4533c0 xor r8d, r8d
0107dae6 8945ac mov dword ptr [rbp - 0x54], eax
0107dae9 0f57c0 xorps xmm0, xmm0
0107daec 488945e0 mov qword ptr [rbp - 0x20], rax
0107daf0 488d05a9a5e3ff lea rax, [rip - 0x1c5a57]
0107daf7 4889442470 mov qword ptr [rsp + 0x70], rax
0107dafc 488d8395000000 lea rax, [rbx + 0x95]
0107db03 48894588 mov qword ptr [rbp - 0x78], rax
0107db07 8b02 mov eax, dword ptr [rdx]
0107db09 8945a8 mov dword ptr [rbp - 0x58], eax
0107db0c 0f294590 movaps xmmword ptr [rbp - 0x70], xmm0
0107db10 4c8945a0 mov qword ptr [rbp - 0x60], r8
0107db14 48895c2478 mov qword ptr [rsp + 0x78], rbx
0107db19 c744246447000000 mov dword ptr [rsp + 0x64], 0x47
0107db21 c744246851000000 mov dword ptr [rsp + 0x68], 0x51
0107db29 c744246c21000000 mov dword ptr [rsp + 0x6c], 0x21
0107db31 66440f7f6db0 movdqa xmmword ptr [rbp - 0x50], xmm13
0107db37 66440f7f65c0 movdqa xmmword ptr [rbp - 0x40], xmm12
0107db3d 66440f7f5dd0 movdqa xmmword ptr [rbp - 0x30], xmm11
0107db43 4885c9 test rcx, rcx
0107db46 7421 je 0x14107db69
0107db48 488d8108020000 lea rax, [rcx + 0x208]
0107db4f 48894590 mov qword ptr [rbp - 0x70], rax
0107db53 4c8d81f8170000 lea r8, [rcx + 0x17f8]
0107db5a 488d83b8000000 lea rax, [rbx + 0xb8]
0107db61 4c8945a0 mov qword ptr [rbp - 0x60], r8
0107db65 48894598 mov qword ptr [rbp - 0x68], rax
0107db69 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107db6e 498bce mov rcx, r14
0107db71 4889542420 mov qword ptr [rsp + 0x20], rdx
0107db76 ba01000000 mov edx, 1
0107db7b e85098ffff call 0x1410773d0
0107db80 808d4a03000040 or byte ptr [rbp + 0x34a], 0x40
0107db87 e955080000 jmp 0x14107e3e1
0107db8c 488b4b10 mov rcx, qword ptr [rbx + 0x10]
0107db90 488d9370010000 lea rdx, [rbx + 0x170]
0107db97 33c0 xor eax, eax
0107db99 c744246004000000 mov dword ptr [rsp + 0x60], 4
0107dba1 48894580 mov qword ptr [rbp - 0x80], rax
0107dba5 4533c0 xor r8d, r8d
0107dba8 8945ac mov dword ptr [rbp - 0x54], eax
0107dbab 0f57c0 xorps xmm0, xmm0
0107dbae 488945e0 mov qword ptr [rbp - 0x20], rax
0107dbb2 488d05e7a4e3ff lea rax, [rip - 0x1c5b19]
0107dbb9 4889442470 mov qword ptr [rsp + 0x70], rax
0107dbbe 488d8396000000 lea rax, [rbx + 0x96]
0107dbc5 48894588 mov qword ptr [rbp - 0x78], rax
0107dbc9 8b02 mov eax, dword ptr [rdx]
0107dbcb 8945a8 mov dword ptr [rbp - 0x58], eax
0107dbce 0f294590 movaps xmmword ptr [rbp - 0x70], xmm0
0107dbd2 4c8945a0 mov qword ptr [rbp - 0x60], r8
0107dbd6 48895c2478 mov qword ptr [rsp + 0x78], rbx
0107dbdb c744246412000000 mov dword ptr [rsp + 0x64], 0x12
0107dbe3 c744246852000000 mov dword ptr [rsp + 0x68], 0x52
0107dbeb c744246c22000000 mov dword ptr [rsp + 0x6c], 0x22
0107dbf3 66440f7f55b0 movdqa xmmword ptr [rbp - 0x50], xmm10
0107dbf9 66440f7f4dc0 movdqa xmmword ptr [rbp - 0x40], xmm9
0107dbff 66440f7f45d0 movdqa xmmword ptr [rbp - 0x30], xmm8
0107dc05 4885c9 test rcx, rcx
0107dc08 7421 je 0x14107dc2b
0107dc0a 488d8108020000 lea rax, [rcx + 0x208]
0107dc11 48894590 mov qword ptr [rbp - 0x70], rax
0107dc15 4c8d81f8170000 lea r8, [rcx + 0x17f8]
0107dc1c 488d83c4000000 lea rax, [rbx + 0xc4]
0107dc23 4c8945a0 mov qword ptr [rbp - 0x60], r8
0107dc27 48894598 mov qword ptr [rbp - 0x68], rax
0107dc2b 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107dc30 498bce mov rcx, r14
0107dc33 4889542420 mov qword ptr [rsp + 0x20], rdx
0107dc38 ba01000000 mov edx, 1
0107dc3d e88e97ffff call 0x1410773d0
0107dc42 808d4a03000020 or byte ptr [rbp + 0x34a], 0x20
0107dc49 e993070000 jmp 0x14107e3e1
0107dc4e 4c8d442460 lea r8, [rsp + 0x60]
0107dc53 ba05000000 mov edx, 5
0107dc58 488bcb mov rcx, rbx
0107dc5b e8d0a4e3ff call 0x140eb8130
0107dc60 448b442460 mov r8d, dword ptr [rsp + 0x60]
0107dc65 ba01000000 mov edx, 1
0107dc6a 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107dc71 4983c058 add r8, 0x58
0107dc75 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107dc7a 498bce mov rcx, r14
0107dc7d 4a8d0483 lea rax, [rbx + r8*4]
0107dc81 4c8b45a0 mov r8, qword ptr [rbp - 0x60]
0107dc85 4889442420 mov qword ptr [rsp + 0x20], rax
0107dc8a e84197ffff call 0x1410773d0
0107dc8f 8b4c2468 mov ecx, dword ptr [rsp + 0x68]
0107dc93 8bf0 mov esi, eax
0107dc95 81f900010000 cmp ecx, 0x100
0107dc9b 0f8d42070000 jge 0x14107e3e3
0107dca1 85c9 test ecx, ecx
0107dca3 0f843a070000 je 0x14107e3e3
0107dca9 8bd1 mov edx, ecx
0107dcab b880000000 mov eax, 0x80
0107dcb0 83e107 and ecx, 7
0107dcb3 48c1ea03 shr rdx, 3
0107dcb7 d3f8 sar eax, cl
0107dcb9 08841540030000 or byte ptr [rbp + rdx + 0x340], al
0107dcc0 e91e070000 jmp 0x14107e3e3
0107dcc5 33c0 xor eax, eax
0107dcc7 488bcb mov rcx, rbx
0107dcca 4889442458 mov qword ptr [rsp + 0x58], rax
0107dccf e82c52f1ff call 0x140f92f00
0107dcd4 4181ff0000a000 cmp r15d, 0xa00000
0107dcdb 761c jbe 0x14107dcf9
0107dcdd 418bcf mov ecx, r15d
0107dce0 ba10000000 mov edx, 0x10
0107dce5 ff1585e68600 call qword ptr [rip + 0x86e685]
0107dceb 4c8be8 mov r13, rax
0107dcee 4885c0 test rax, rax
0107dcf1 0f8400080000 je 0x14107e4f7
0107dcf7 eb07 jmp 0x14107dd00
0107dcf9 498d862801a000 lea rax, [r14 + 0xa00128]
0107dd00 458bc7 mov r8d, r15d
0107dd03 488bd0 mov rdx, rax
0107dd06 498bce mov rcx, r14
0107dd09 4889442450 mov qword ptr [rsp + 0x50], rax
0107dd0e e88d93ffff call 0x1410770a0
0107dd13 8bf0 mov esi, eax
0107dd15 85c0 test eax, eax
0107dd17 0f85e9090000 jne 0x14107e706
0107dd1d 488b542450 mov rdx, qword ptr [rsp + 0x50]
0107dd22 4c8d442458 lea r8, [rsp + 0x58]
0107dd27 418bcf mov ecx, r15d
0107dd2a e84101b6ff call 0x140bdde70
0107dd2f 8bf0 mov esi, eax
0107dd31 4d85ed test r13, r13
0107dd34 7409 je 0x14107dd3f
0107dd36 498bcd mov rcx, r13
0107dd39 ff1529e68600 call qword ptr [rip + 0x86e629]
0107dd3f 85f6 test esi, esi
0107dd41 0f858e000000 jne 0x14107ddd5
0107dd47 488b742458 mov rsi, qword ptr [rsp + 0x58]
0107dd4c 488bcf mov rcx, rdi
0107dd4f 488bd6 mov rdx, rsi
0107dd52 e809b5f2ff call 0x140fa9260
0107dd57 4885f6 test rsi, rsi
0107dd5a 7472 je 0x14107ddce
0107dd5c 813e64706863 cmp dword ptr [rsi], 0x63687064
0107dd62 756a jne 0x14107ddce
0107dd64 836e0401 sub dword ptr [rsi + 4], 1
0107dd68 7564 jne 0x14107ddce
0107dd6a 488b4e20 mov rcx, qword ptr [rsi + 0x20]
0107dd6e e87d04b6ff call 0x140bde1f0
0107dd73 488b4e18 mov rcx, qword ptr [rsi + 0x18]
0107dd77 e8449bb7ff call 0x140bf78c0
0107dd7c 488b4e20 mov rcx, qword ptr [rsi + 0x20]
0107dd80 e83b9bb7ff call 0x140bf78c0
0107dd85 488b4e28 mov rcx, qword ptr [rsi + 0x28]
0107dd89 4885c9 test rcx, rcx
0107dd8c 7406 je 0x14107dd94
0107dd8e ff15d4e58600 call qword ptr [rip + 0x86e5d4]
0107dd94 488b4e30 mov rcx, qword ptr [rsi + 0x30]
0107dd98 4885c9 test rcx, rcx
0107dd9b 7406 je 0x14107dda3
0107dd9d ff15c5e58600 call qword ptr [rip + 0x86e5c5]
0107dda3 488b4e38 mov rcx, qword ptr [rsi + 0x38]
0107dda7 4885c9 test rcx, rcx
0107ddaa 7406 je 0x14107ddb2
0107ddac ff15b6e58600 call qword ptr [rip + 0x86e5b6]
0107ddb2 488b4e58 mov rcx, qword ptr [rsi + 0x58]
0107ddb6 4885c9 test rcx, rcx
0107ddb9 7406 je 0x14107ddc1
0107ddbb ff155fb08600 call qword ptr [rip + 0x86b05f]
0107ddc1 33c0 xor eax, eax
0107ddc3 488bce mov rcx, rsi
0107ddc6 8906 mov dword ptr [rsi], eax
0107ddc8 ff159ae58600 call qword ptr [rip + 0x86e59a]
0107ddce 808d4b03000080 or byte ptr [rbp + 0x34b], 0x80
0107ddd5 33c0 xor eax, eax
0107ddd7 8bf0 mov esi, eax
0107ddd9 e919070000 jmp 0x14107e4f7
0107ddde f6839b00000008 test byte ptr [rbx + 0x9b], 8
0107dde5 7564 jne 0x14107de4b
0107dde7 4038b39d000000 cmp byte ptr [rbx + 0x9d], sil
0107ddee 0f8da4000000 jge 0x14107de98
0107ddf4 48397310 cmp qword ptr [rbx + 0x10], rsi
0107ddf8 0f849a000000 je 0x14107de98
0107ddfe f6839a00000001 test byte ptr [rbx + 0x9a], 1
0107de05 0f848d000000 je 0x14107de98
0107de0b 488b4368 mov rax, qword ptr [rbx + 0x68]
0107de0f 8b4810 mov ecx, dword ptr [rax + 0x10]
0107de12 85c9 test ecx, ecx
0107de14 752d jne 0x14107de43
0107de16 39b3ac000000 cmp dword ptr [rbx + 0xac], esi
0107de1c 751f jne 0x14107de3d
0107de1e 488bcb mov rcx, rbx
0107de21 e81a34f1ff call 0x140f91240
0107de26 8983ac000000 mov dword ptr [rbx + 0xac], eax
0107de2c 85c0 test eax, eax
0107de2e 740d je 0x14107de3d
0107de30 ba3c000000 mov edx, 0x3c
0107de35 488bcb mov rcx, rbx
0107de38 e8c362f1ff call 0x140f94100
0107de3d 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
0107de43 f7c104002000 test ecx, 0x200004
0107de49 744d je 0x14107de98
0107de4b 817f3450545448 cmp dword ptr [rdi + 0x34], 0x48545450
0107de52 7544 jne 0x14107de98
0107de54 488bcb mov rcx, rbx
0107de57 e8a450f1ff call 0x140f92f00
0107de5c 488b4368 mov rax, qword ptr [rbx + 0x68]
0107de60 4533c9 xor r9d, r9d
0107de63 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107de68 4883c048 add rax, 0x48
0107de6c 4981c0d8040000 add r8, 0x4d8
0107de73 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107de78 ba01000000 mov edx, 1
0107de7d 4889442420 mov qword ptr [rsp + 0x20], rax
0107de82 498bce mov rcx, r14
0107de85 e84695ffff call 0x1410773d0
0107de8a 808d4303000020 or byte ptr [rbp + 0x343], 0x20
0107de91 8bf0 mov esi, eax
0107de93 e94b050000 jmp 0x14107e3e3
0107de98 498b8e7801e001 mov rcx, qword ptr [r14 + 0x1e00178]
0107de9f 4963d7 movsxd rdx, r15d
0107dea2 4903967001e001 add rdx, qword ptr [r14 + 0x1e00170]
0107dea9 4989967001e001 mov qword ptr [r14 + 0x1e00170], rdx
0107deb0 483bd1 cmp rdx, rcx
0107deb3 720c jb 0x14107dec1
0107deb5 49038e8001e001 add rcx, qword ptr [r14 + 0x1e00180]
0107debc 483bd1 cmp rdx, rcx
0107debf 7207 jb 0x14107dec8
0107dec1 4d89ae8001e001 mov qword ptr [r14 + 0x1e00180], r13
0107dec8 808d4303000020 or byte ptr [rbp + 0x343], 0x20
0107decf e90f050000 jmp 0x14107e3e3
0107ded4 f6839b00000008 test byte ptr [rbx + 0x9b], 8
0107dedb 0f84e6050000 je 0x14107e4c7
0107dee1 488bcb mov rcx, rbx
0107dee4 e81750f1ff call 0x140f92f00
0107dee9 488b4368 mov rax, qword ptr [rbx + 0x68]
0107deed 4533c9 xor r9d, r9d
0107def0 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107def5 4883c044 add rax, 0x44
0107def9 4981c0d8040000 add r8, 0x4d8
0107df00 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107df05 ba01000000 mov edx, 1
0107df0a 4889442420 mov qword ptr [rsp + 0x20], rax
0107df0f 498bce mov rcx, r14
0107df12 e8b994ffff call 0x1410773d0
0107df17 e9c5040000 jmp 0x14107e3e1
0107df1c 8b4734 mov eax, dword ptr [rdi + 0x34]
0107df1f 3d454c4946 cmp eax, 0x46494c45
0107df24 7536 jne 0x14107df5c
0107df26 4c8b87c8020000 mov r8, qword ptr [rdi + 0x2c8]
0107df2d 488d87c0020000 lea rax, [rdi + 0x2c0]
0107df34 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107df39 4533c9 xor r9d, r9d
0107df3c ba05000000 mov edx, 5
0107df41 4889442420 mov qword ptr [rsp + 0x20], rax
0107df46 498bce mov rcx, r14
0107df49 e88294ffff call 0x1410773d0
0107df4e 808d4103000001 or byte ptr [rbp + 0x341], 1
0107df55 8bf0 mov esi, eax
0107df57 e987040000 jmp 0x14107e3e3
0107df5c 3d50545448 cmp eax, 0x48545450
0107df61 7533 jne 0x14107df96
0107df63 4c8b87c8020000 mov r8, qword ptr [rdi + 0x2c8]
0107df6a 488d87b8020000 lea rax, [rdi + 0x2b8]
0107df71 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107df76 4533c9 xor r9d, r9d
0107df79 33d2 xor edx, edx
0107df7b 4889442420 mov qword ptr [rsp + 0x20], rax
0107df80 498bce mov rcx, r14
0107df83 e84894ffff call 0x1410773d0
0107df88 808d4103000001 or byte ptr [rbp + 0x341], 1
0107df8f 8bf0 mov esi, eax
0107df91 e94d040000 jmp 0x14107e3e3
0107df96 498b8e7801e001 mov rcx, qword ptr [r14 + 0x1e00178]
0107df9d 4963d7 movsxd rdx, r15d
0107dfa0 4903967001e001 add rdx, qword ptr [r14 + 0x1e00170]
0107dfa7 4989967001e001 mov qword ptr [r14 + 0x1e00170], rdx
0107dfae 483bd1 cmp rdx, rcx
0107dfb1 720c jb 0x14107dfbf
0107dfb3 49038e8001e001 add rcx, qword ptr [r14 + 0x1e00180]
0107dfba 483bd1 cmp rdx, rcx
0107dfbd 7207 jb 0x14107dfc6
0107dfbf 4d89ae8001e001 mov qword ptr [r14 + 0x1e00180], r13
0107dfc6 808d4103000001 or byte ptr [rbp + 0x341], 1
0107dfcd e911040000 jmp 0x14107e3e3
0107dfd2 817f3450545448 cmp dword ptr [rdi + 0x34], 0x48545450
0107dfd9 0f85e8040000 jne 0x14107e4c7
0107dfdf 4c8b87c8020000 mov r8, qword ptr [rdi + 0x2c8]
0107dfe6 488d87bc020000 lea rax, [rdi + 0x2bc]
0107dfed 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107dff2 4533c9 xor r9d, r9d
0107dff5 33d2 xor edx, edx
0107dff7 4889442420 mov qword ptr [rsp + 0x20], rax
0107dffc 498bce mov rcx, r14
0107dfff e8cc93ffff call 0x1410773d0
0107e004 808d4103000001 or byte ptr [rbp + 0x341], 1
0107e00b e9d1030000 jmp 0x14107e3e1
0107e010 488bcb mov rcx, rbx
0107e013 e8e84ef1ff call 0x140f92f00
0107e018 488b4368 mov rax, qword ptr [rbx + 0x68]
0107e01c ba01000000 mov edx, 1
0107e021 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107e026 4883c030 add rax, 0x30
0107e02a 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107e031 4981c018070000 add r8, 0x718
0107e038 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107e03d 498bce mov rcx, r14
0107e040 4889442420 mov qword ptr [rsp + 0x20], rax
0107e045 e88693ffff call 0x1410773d0
0107e04a 808d4b03000040 or byte ptr [rbp + 0x34b], 0x40
0107e051 e98b030000 jmp 0x14107e3e1
0107e056 4d8dae2801a000 lea r13, [r14 + 0xa00128]
0107e05d 4d85ed test r13, r13
0107e060 7422 je 0x14107e084
0107e062 0f57c0 xorps xmm0, xmm0
0107e065 33c0 xor eax, eax
0107e067 410f114500 movups xmmword ptr [r13], xmm0
0107e06c 410f114510 movups xmmword ptr [r13 + 0x10], xmm0
0107e071 410f114520 movups xmmword ptr [r13 + 0x20], xmm0
0107e076 410f114530 movups xmmword ptr [r13 + 0x30], xmm0
0107e07b 410f114540 movups xmmword ptr [r13 + 0x40], xmm0
0107e080 41894550 mov dword ptr [r13 + 0x50], eax
0107e084 4181ff0000a000 cmp r15d, 0xa00000
0107e08b 760a jbe 0x14107e097
0107e08d be30ffffff mov esi, 0xffffff30
0107e092 e94c030000 jmp 0x14107e3e3
0107e097 458bc7 mov r8d, r15d
0107e09a 498bd5 mov rdx, r13
0107e09d 498bce mov rcx, r14
0107e0a0 e8fb8fffff call 0x1410770a0
0107e0a5 8bf0 mov esi, eax
0107e0a7 85c0 test eax, eax
0107e0a9 0f8534030000 jne 0x14107e3e3
0107e0af 498bd5 mov rdx, r13
0107e0b2 498bce mov rcx, r14
0107e0b5 e816b0feff call 0x1410690d0
0107e0ba 488bd7 mov rdx, rdi
0107e0bd 498bcd mov rcx, r13
0107e0c0 e84bb7ffff call 0x141079810
0107e0c5 e917030000 jmp 0x14107e3e1
0107e0ca 488bcb mov rcx, rbx
0107e0cd e82e4ef1ff call 0x140f92f00
0107e0d2 488b4368 mov rax, qword ptr [rbx + 0x68]
0107e0d6 33d2 xor edx, edx
0107e0d8 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107e0dd 4883c04c add rax, 0x4c
0107e0e1 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107e0e8 4981c088180000 add r8, 0x1888
0107e0ef 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107e0f4 498bce mov rcx, r14
0107e0f7 4889442420 mov qword ptr [rsp + 0x20], rax
0107e0fc e8cf92ffff call 0x1410773d0
0107e101 808d4e03000008 or byte ptr [rbp + 0x34e], 8
0107e108 e9d4020000 jmp 0x14107e3e1
0107e10d 488bcf mov rcx, rdi
0107e110 e83b80f2ff call 0x140fa6150
0107e115 488b4710 mov rax, qword ptr [rdi + 0x10]
0107e119 ba01000000 mov edx, 1
0107e11e 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107e123 4883c068 add rax, 0x68
0107e127 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107e12e 4981c0a8070000 add r8, 0x7a8
0107e135 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107e13a 498bce mov rcx, r14
0107e13d 4889442420 mov qword ptr [rsp + 0x20], rax
0107e142 e88992ffff call 0x1410773d0
0107e147 808d4e03000001 or byte ptr [rbp + 0x34e], 1
0107e14e e98e020000 jmp 0x14107e3e1
0107e153 488bcf mov rcx, rdi
0107e156 e8f57ff2ff call 0x140fa6150
0107e15b 488b4710 mov rax, qword ptr [rdi + 0x10]
0107e15f ba02000000 mov edx, 2
0107e164 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107e169 4883c06c add rax, 0x6c
0107e16d 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107e174 4981c0f0070000 add r8, 0x7f0
0107e17b 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107e180 498bce mov rcx, r14
0107e183 4889442420 mov qword ptr [rsp + 0x20], rax
0107e188 e84392ffff call 0x1410773d0
0107e18d 808d4f03000010 or byte ptr [rbp + 0x34f], 0x10
0107e194 e948020000 jmp 0x14107e3e1
0107e199 488bcb mov rcx, rbx
0107e19c e85f4df1ff call 0x140f92f00
0107e1a1 488b4368 mov rax, qword ptr [rbx + 0x68]
0107e1a5 ba01000000 mov edx, 1
0107e1aa 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107e1af 4883c040 add rax, 0x40
0107e1b3 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107e1ba 4981c080080000 add r8, 0x880
0107e1c1 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107e1c6 498bce mov rcx, r14
0107e1c9 4889442420 mov qword ptr [rsp + 0x20], rax
0107e1ce e8fd91ffff call 0x1410773d0
0107e1d3 808d4f03000008 or byte ptr [rbp + 0x34f], 8
0107e1da e902020000 jmp 0x14107e3e1
0107e1df 488bcf mov rcx, rdi
0107e1e2 e8697ff2ff call 0x140fa6150
0107e1e7 488b4710 mov rax, qword ptr [rdi + 0x10]
0107e1eb ba01000000 mov edx, 1
0107e1f0 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107e1f5 4883c074 add rax, 0x74
0107e1f9 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107e200 4981c0c8080000 add r8, 0x8c8
0107e207 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107e20c 498bce mov rcx, r14
0107e20f 4889442420 mov qword ptr [rsp + 0x20], rax
0107e214 e8b791ffff call 0x1410773d0
0107e219 808d5203000080 or byte ptr [rbp + 0x352], 0x80
0107e220 e9bc010000 jmp 0x14107e3e1
0107e225 488bcf mov rcx, rdi
0107e228 e8237ff2ff call 0x140fa6150
0107e22d 488b4710 mov rax, qword ptr [rdi + 0x10]
0107e231 ba01000000 mov edx, 1
0107e236 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107e23b 4883c078 add rax, 0x78
0107e23f 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107e246 4981c010090000 add r8, 0x910
0107e24d 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107e252 498bce mov rcx, r14
0107e255 4889442420 mov qword ptr [rsp + 0x20], rax
0107e25a e87191ffff call 0x1410773d0
0107e25f 808d5203000040 or byte ptr [rbp + 0x352], 0x40
0107e266 e976010000 jmp 0x14107e3e1
0107e26b 488bcf mov rcx, rdi
0107e26e e8dd7ef2ff call 0x140fa6150
0107e273 488b4710 mov rax, qword ptr [rdi + 0x10]
0107e277 ba01000000 mov edx, 1
0107e27c 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107e281 4883c07c add rax, 0x7c
0107e285 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107e28c 4981c0c8080000 add r8, 0x8c8
0107e293 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107e298 498bce mov rcx, r14
0107e29b 4889442420 mov qword ptr [rsp + 0x20], rax
0107e2a0 e82b91ffff call 0x1410773d0
0107e2a5 808d5203000008 or byte ptr [rbp + 0x352], 8
0107e2ac e930010000 jmp 0x14107e3e1
0107e2b1 488bcf mov rcx, rdi
0107e2b4 e8977ef2ff call 0x140fa6150
0107e2b9 488b4710 mov rax, qword ptr [rdi + 0x10]
0107e2bd ba01000000 mov edx, 1
0107e2c2 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107e2c7 4883e880 sub rax, -0x80
0107e2cb 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107e2d2 4981c010090000 add r8, 0x910
0107e2d9 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107e2de 498bce mov rcx, r14
0107e2e1 4889442420 mov qword ptr [rsp + 0x20], rax
0107e2e6 e8e590ffff call 0x1410773d0
0107e2eb 808d5203000004 or byte ptr [rbp + 0x352], 4
0107e2f2 e9ea000000 jmp 0x14107e3e1
0107e2f7 488bcb mov rcx, rbx
0107e2fa e8014cf1ff call 0x140f92f00
0107e2ff 488b4368 mov rax, qword ptr [rbx + 0x68]
0107e303 ba01000000 mov edx, 1
0107e308 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107e30d 4883c018 add rax, 0x18
0107e311 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107e318 4981c098020000 add r8, 0x298
0107e31f 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107e324 498bce mov rcx, r14
0107e327 4889442420 mov qword ptr [rsp + 0x20], rax
0107e32c e89f90ffff call 0x1410773d0
0107e331 808d5303000001 or byte ptr [rbp + 0x353], 1
0107e338 e9a4000000 jmp 0x14107e3e1
0107e33d 488bcb mov rcx, rbx
0107e340 e8bb4bf1ff call 0x140f92f00
0107e345 488b4368 mov rax, qword ptr [rbx + 0x68]
0107e349 ba01000000 mov edx, 1
0107e34e 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107e353 4883c01c add rax, 0x1c
0107e357 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107e35e 4981c0e0020000 add r8, 0x2e0
0107e365 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107e36a 498bce mov rcx, r14
0107e36d 4889442420 mov qword ptr [rsp + 0x20], rax
0107e372 e85990ffff call 0x1410773d0
0107e377 808d5403000080 or byte ptr [rbp + 0x354], 0x80
0107e37e eb61 jmp 0x14107e3e1
0107e380 488bcf mov rcx, rdi
0107e383 e8c87df2ff call 0x140fa6150
0107e388 4c8b4710 mov r8, qword ptr [rdi + 0x10]
0107e38c 418bd7 mov edx, r15d
0107e38f 4981c098000000 add r8, 0x98
0107e396 498bce mov rcx, r14
0107e399 e8429bffff call 0x141077ee0
0107e39e eb41 jmp 0x14107e3e1
0107e3a0 488bcf mov rcx, rdi
0107e3a3 e8a87df2ff call 0x140fa6150
0107e3a8 488b4710 mov rax, qword ptr [rdi + 0x10]
0107e3ac ba01000000 mov edx, 1
0107e3b1 4c8b442438 mov r8, qword ptr [rsp + 0x38]
0107e3b6 4883c070 add rax, 0x70
0107e3ba 448b8d70030000 mov r9d, dword ptr [rbp + 0x370]
0107e3c1 4981c038080000 add r8, 0x838
0107e3c8 44896c2428 mov dword ptr [rsp + 0x28], r13d
0107e3cd 498bce mov rcx, r14
0107e3d0 4889442420 mov qword ptr [rsp + 0x20], rax
0107e3d5 e8f68fffff call 0x1410773d0
0107e3da 808d5003000080 or byte ptr [rbp + 0x350], 0x80
0107e3e1 8bf0 mov esi, eax
0107e3e3 85f6 test esi, esi
0107e3e5 0f851b030000 jne 0x14107e706
0107e3eb e907010000 jmp 0x14107e4f7
0107e3f0 b201 mov dl, 1
0107e3f2 488bcb mov rcx, rbx
0107e3f5 e85636f2ff call 0x140fa1a50
0107e3fa 4885c0 test rax, rax
0107e3fd 7425 je 0x14107e424
0107e3ff 458bc7 mov r8d, r15d
0107e402 488bd0 mov rdx, rax
0107e405 498bce mov rcx, r14
0107e408 e8e39bffff call 0x141077ff0
0107e40d 8bf0 mov esi, eax
0107e40f 85c0 test eax, eax
0107e411 0f85ef020000 jne 0x14107e706
0107e417 488bcb mov rcx, rbx
0107e41a e801b5ffff call 0x141079920
0107e41f e9d3000000 jmp 0x14107e4f7
0107e424 498b8e7801e001 mov rcx, qword ptr [r14 + 0x1e00178]
0107e42b 4963d7 movsxd rdx, r15d
0107e42e 4903967001e001 add rdx, qword ptr [r14 + 0x1e00170]
0107e435 4989967001e001 mov qword ptr [r14 + 0x1e00170], rdx
0107e43c 483bd1 cmp rdx, rcx
0107e43f 720c jb 0x14107e44d
0107e441 49038e8001e001 add rcx, qword ptr [r14 + 0x1e00180]
0107e448 483bd1 cmp rdx, rcx
0107e44b 7207 jb 0x14107e454
0107e44d 4d89ae8001e001 mov qword ptr [r14 + 0x1e00180], r13
0107e454 488bcb mov rcx, rbx
0107e457 e8c4b4ffff call 0x141079920
0107e45c e996000000 jmp 0x14107e4f7
0107e461 488b4708 mov rax, qword ptr [rdi + 8]
0107e465 4885c0 test rax, rax
0107e468 0f8489000000 je 0x14107e4f7
0107e46e 48397010 cmp qword ptr [rax + 0x10], rsi
0107e472 0f847f000000 je 0x14107e4f7
0107e478 488b87d0020000 mov rax, qword ptr [rdi + 0x2d0]
0107e47f 4885c0 test rax, rax
0107e482 7529 jne 0x14107e4ad
0107e484 4c8b0db5a98600 mov r9, qword ptr [rip + 0x86a9b5]
0107e48b 33d2 xor edx, edx
0107e48d 4c8b0554a98600 mov r8, qword ptr [rip + 0x86a954]
0107e494 488b0df57b0201 mov rcx, qword ptr [rip + 0x1027bf5]
0107e49b ff1517ae8600 call qword ptr [rip + 0x86ae17]
0107e4a1 488987d0020000 mov qword ptr [rdi + 0x2d0], rax
0107e4a8 4885c0 test rax, rax
0107e4ab 7410 je 0x14107e4bd
0107e4ad 458bc7 mov r8d, r15d
0107e4b0 488bd0 mov rdx, rax
0107e4b3 498bce mov rcx, r14
0107e4b6 e8359bffff call 0x141077ff0
0107e4bb 8bf0 mov esi, eax
0107e4bd 85f6 test esi, esi
0107e4bf 0f8541020000 jne 0x14107e706
0107e4c5 eb30 jmp 0x14107e4f7
0107e4c7 498b8e7801e001 mov rcx, qword ptr [r14 + 0x1e00178]
0107e4ce 4963d7 movsxd rdx, r15d
0107e4d1 4903967001e001 add rdx, qword ptr [r14 + 0x1e00170]
0107e4d8 4989967001e001 mov qword ptr [r14 + 0x1e00170], rdx
0107e4df 483bd1 cmp rdx, rcx
0107e4e2 720c jb 0x14107e4f0
0107e4e4 49038e8001e001 add rcx, qword ptr [r14 + 0x1e00180]
0107e4eb 483bd1 cmp rdx, rcx
0107e4ee 7207 jb 0x14107e4f7
0107e4f0 4d89ae8001e001 mov qword ptr [r14 + 0x1e00180], r13
0107e4f7 448b6c2440 mov r13d, dword ptr [rsp + 0x40]
0107e4fc 41ffc5 inc r13d
0107e4ff 44896c2440 mov dword ptr [rsp + 0x40], r13d
0107e504 443b6d4c cmp r13d, dword ptr [rbp + 0x4c]
0107e508 0f8295eaffff jb 0x14107cfa3
0107e50e 4c8b7c2438 mov r15, qword ptr [rsp + 0x38]
0107e513 4180bef202e00100 cmp byte ptr [r14 + 0x1e002f2], 0
0107e51b 0f848a000000 je 0x14107e5ab
0107e521 488b4720 mov rax, qword ptr [rdi + 0x20]
0107e525 4883780800 cmp qword ptr [rax + 8], 0
0107e52a 7509 jne 0x14107e535
0107e52c 80bb8a00000000 cmp byte ptr [rbx + 0x8a], 0
0107e533 7476 je 0x14107e5ab
0107e535 48837b1000 cmp qword ptr [rbx + 0x10], 0
0107e53a 746f je 0x14107e5ab
0107e53c f6839a00000001 test byte ptr [rbx + 0x9a], 1
0107e543 7466 je 0x14107e5ab
0107e545 488b4368 mov rax, qword ptr [rbx + 0x68]
0107e549 8b4810 mov ecx, dword ptr [rax + 0x10]
0107e54c 85c9 test ecx, ecx
0107e54e 752d jne 0x14107e57d
0107e550 398bac000000 cmp dword ptr [rbx + 0xac], ecx
0107e556 751f jne 0x14107e577
0107e558 488bcb mov rcx, rbx
0107e55b e8e02cf1ff call 0x140f91240
0107e560 8983ac000000 mov dword ptr [rbx + 0xac], eax
0107e566 85c0 test eax, eax
0107e568 740d je 0x14107e577
0107e56a ba3c000000 mov edx, 0x3c
0107e56f 488bcb mov rcx, rbx
0107e572 e8895bf1ff call 0x140f94100
0107e577 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
0107e57d 83e901 sub ecx, 1
0107e580 7412 je 0x14107e594
0107e582 83e90f sub ecx, 0xf
0107e585 740d je 0x14107e594
0107e587 83e910 sub ecx, 0x10
0107e58a 7408 je 0x14107e594
0107e58c 81f9e1ff0000 cmp ecx, 0xffe1
0107e592 7517 jne 0x14107e5ab
0107e594 4533c9 xor r9d, r9d
0107e597 4533c0 xor r8d, r8d
0107e59a 33d2 xor edx, edx
0107e59c 488bcf mov rcx, rdi
0107e59f e8dcbaf2ff call 0x140faa080
0107e5a4 c6838a00000000 mov byte ptr [rbx + 0x8a], 0
0107e5ab 48637df0 movsxd rdi, dword ptr [rbp - 0x10]
0107e5af 85ff test edi, edi
0107e5b1 7470 je 0x14107e623
0107e5b3 488bcb mov rcx, rbx
0107e5b6 e84549f1ff call 0x140f92f00
0107e5bb 488b4368 mov rax, qword ptr [rbx + 0x68]
0107e5bf 83782400 cmp dword ptr [rax + 0x24], 0
0107e5c3 7454 je 0x14107e619
0107e5c5 4d8d87b0050000 lea r8, [r15 + 0x5b0]
0107e5cc 4d85c0 test r8, r8
0107e5cf 7452 je 0x14107e623
0107e5d1 41813863727473 cmp dword ptr [r8], 0x73747263
0107e5d8 7549 jne 0x14107e623
0107e5da 4183783c00 cmp dword ptr [r8 + 0x3c], 0
0107e5df 7542 jne 0x14107e623
0107e5e1 85ff test edi, edi
0107e5e3 7e3e jle 0x14107e623
0107e5e5 413b782c cmp edi, dword ptr [r8 + 0x2c]
0107e5e9 7f38 jg 0x14107e623
0107e5eb 41f6400401 test byte ptr [r8 + 4], 1
0107e5f0 740e je 0x14107e600
0107e5f2 498b4018 mov rax, qword ptr [r8 + 0x18]
0107e5f6 488b00 mov rax, qword ptr [rax]
0107e5f9 836cb8fc01 sub dword ptr [rax + rdi*4 - 4], 1
0107e5fe 7523 jne 0x14107e623
0107e600 498b4010 mov rax, qword ptr [r8 + 0x10]
0107e604 488b08 mov rcx, qword ptr [rax]
0107e607 8b44f9fc mov eax, dword ptr [rcx + rdi*8 - 4]
0107e60b 41014040 add dword ptr [r8 + 0x40], eax
0107e60f c744f9f801000080 mov dword ptr [rcx + rdi*8 - 8], 0x80000001
0107e617 eb0a jmp 0x14107e623
0107e619 808d4a03000004 or byte ptr [rbp + 0x34a], 4
0107e620 897824 mov dword ptr [rax + 0x24], edi
0107e623 41b806000000 mov r8d, 6
0107e629 488d9540030000 lea rdx, [rbp + 0x340]
0107e630 488bcb mov rcx, rbx
0107e633 e80883e5ff call 0x140ed6940
0107e638 eb39 jmp 0x14107e673
0107e63a 8b4548 mov eax, dword ptr [rbp + 0x48]
0107e63d 2b4544 sub eax, dword ptr [rbp + 0x44]
0107e640 498b8e7801e001 mov rcx, qword ptr [r14 + 0x1e00178]
0107e647 4863d0 movsxd rdx, eax
0107e64a 4903967001e001 add rdx, qword ptr [r14 + 0x1e00170]
0107e651 4989967001e001 mov qword ptr [r14 + 0x1e00170], rdx
0107e658 483bd1 cmp rdx, rcx
0107e65b 720c jb 0x14107e669
0107e65d 49038e8001e001 add rcx, qword ptr [r14 + 0x1e00180]
0107e664 483bd1 cmp rdx, rcx
0107e667 7207 jb 0x14107e670
0107e669 4d89868001e001 mov qword ptr [r14 + 0x1e00180], r8
0107e670 418bf0 mov esi, r8d
0107e673 49ff869001e001 inc qword ptr [r14 + 0x1e00190]
0107e67a 498bce mov rcx, r14
0107e67d e8be8cffff call 0x141077340
0107e682 8b5df4 mov ebx, dword ptr [rbp - 0xc]
0107e685 ffc3 inc ebx
0107e687 895df4 mov dword ptr [rbp - 0xc], ebx
0107e68a 3b9d88030000 cmp ebx, dword ptr [rbp + 0x388]
0107e690 0f827ad0ffff jb 0x14107b710
0107e696 4533ed xor r13d, r13d
0107e699 807c243000 cmp byte ptr [rsp + 0x30], 0
0107e69e 7408 je 0x14107e6a8
0107e6a0 498bcf mov rcx, r15
0107e6a3 e828a6e3ff call 0x140eb8cd0
0107e6a8 85f6 test esi, esi
0107e6aa 755a jne 0x14107e706
0107e6ac 837c24480d cmp dword ptr [rsp + 0x48], 0xd
0107e6b1 7553 jne 0x14107e706
0107e6b3 488b7d00 mov rdi, qword ptr [rbp]
0107e6b7 4885ff test rdi, rdi
0107e6ba 744a je 0x14107e706
0107e6bc 488bdf mov rbx, rdi
0107e6bf 488bc7 mov rax, rdi
0107e6c2 48837b1000 cmp qword ptr [rbx + 0x10], 0
0107e6c7 498bdd mov rbx, r13
0107e6ca 7404 je 0x14107e6d0
0107e6cc 488b5818 mov rbx, qword ptr [rax + 0x18]
0107e6d0 488bd7 mov rdx, rdi
0107e6d3 498d8e9002e001 lea rcx, [r14 + 0x1e00290]
0107e6da e891f73aff call 0x14042de70
0107e6df 4885c0 test rax, rax
0107e6e2 7417 je 0x14107e6fb
0107e6e4 488b5008 mov rdx, qword ptr [rax + 8]
0107e6e8 4885d2 test rdx, rdx
0107e6eb 740e je 0x14107e6fb
0107e6ed 483bd7 cmp rdx, rdi
0107e6f0 7409 je 0x14107e6fb
0107e6f2 488b4f58 mov rcx, qword ptr [rdi + 0x58]
0107e6f6 e8a529f2ff call 0x140fa10a0
0107e6fb 488bfb mov rdi, rbx
0107e6fe 488bc3 mov rax, rbx
0107e701 4885db test rbx, rbx
0107e704 75bc jne 0x14107e6c2
0107e706 440f28b42400070000 movaps xmm14, xmmword ptr [rsp + 0x700]
0107e70f 440f28ac2410070000 movaps xmm13, xmmword ptr [rsp + 0x710]
0107e718 440f28a42420070000 movaps xmm12, xmmword ptr [rsp + 0x720]
0107e721 440f289c2430070000 movaps xmm11, xmmword ptr [rsp + 0x730]
0107e72a 440f28942440070000 movaps xmm10, xmmword ptr [rsp + 0x740]
0107e733 440f288c2450070000 movaps xmm9, xmmword ptr [rsp + 0x750]
0107e73c 440f28842460070000 movaps xmm8, xmmword ptr [rsp + 0x760]
0107e745 0f28bc2470070000 movaps xmm7, xmmword ptr [rsp + 0x770]
0107e74d 0f28b42480070000 movaps xmm6, xmmword ptr [rsp + 0x780]
0107e755 440f28bc24f0060000 movaps xmm15, xmmword ptr [rsp + 0x6f0]
0107e75e 4c8ba424d8070000 mov r12, qword ptr [rsp + 0x7d8]
0107e766 488bbc24d0070000 mov rdi, qword ptr [rsp + 0x7d0]
0107e76e 488b9c24c8070000 mov rbx, qword ptr [rsp + 0x7c8]
0107e776 4c8bac2490070000 mov r13, qword ptr [rsp + 0x790]
0107e77e 8bc6 mov eax, esi
0107e780 488b8de0050000 mov rcx, qword ptr [rbp + 0x5e0]
0107e787 4833cc xor rcx, rsp
0107e78a e851d17100 call 0x14179b8e0
0107e78f 4881c498070000 add rsp, 0x798
0107e796 415f pop r15
0107e798 415e pop r14
0107e79a 5e pop rsi
0107e79b 5d pop rbp
0107e79c c3 ret 
0107e79d be94ffffff mov esi, 0xffffff94
0107e7a2 e95fffffff jmp 0x14107e706
0107e7a7 be30ffffff mov esi, 0xffffff30
0107e7ac e955ffffff jmp 0x14107e706
0107e7b1 0f1f00 nop dword ptr [rax]