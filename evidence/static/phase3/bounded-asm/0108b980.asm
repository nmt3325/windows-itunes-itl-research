0108b980 48895c2418 mov qword ptr [rsp + 0x18], rbx
0108b985 55 push rbp
0108b986 56 push rsi
0108b987 57 push rdi
0108b988 4154 push r12
0108b98a 4155 push r13
0108b98c 4156 push r14
0108b98e 4157 push r15
0108b990 488dac24a0fdffff lea rbp, [rsp - 0x260]
0108b998 4881ec60030000 sub rsp, 0x360
0108b99f 0f29b42450030000 movaps xmmword ptr [rsp + 0x350], xmm6
0108b9a7 488b059296f400 mov rax, qword ptr [rip + 0xf49692]
0108b9ae 4833c4 xor rax, rsp
0108b9b1 48898540020000 mov qword ptr [rbp + 0x240], rax
0108b9b8 488955a8 mov qword ptr [rbp - 0x58], rdx
0108b9bc 4c8bf9 mov r15, rcx
0108b9bf 48894da0 mov qword ptr [rbp - 0x60], rcx
0108b9c3 33f6 xor esi, esi
0108b9c5 8bc6 mov eax, esi
0108b9c7 89442464 mov dword ptr [rsp + 0x64], eax
0108b9cb 8945b4 mov dword ptr [rbp - 0x4c], eax
0108b9ce 0f57f6 xorps xmm6, xmm6
0108b9d1 41bcffffffff mov r12d, 0xffffffff
0108b9d7 4885c9 test rcx, rcx
0108b9da 0f848c0e0000 je 0x14108c86c
0108b9e0 4885d2 test rdx, rdx
0108b9e3 0f84830e0000 je 0x14108c86c
0108b9e9 488d8178100000 lea rax, [rcx + 0x1078]
0108b9f0 4885c0 test rax, rax
0108b9f3 7408 je 0x14108b9fd
0108b9f5 33c9 xor ecx, ecx
0108b9f7 668908 mov word ptr [rax], cx
0108b9fa 884802 mov byte ptr [rax + 2], cl
0108b9fd 41c6877010000000 mov byte ptr [r15 + 0x1070], 0
0108ba05 488b0dd4420401 mov rcx, qword ptr [rip + 0x10442d4]
0108ba0c 4885c9 test rcx, rcx
0108ba0f 742f je 0x14108ba40
0108ba11 ba06002823 mov edx, 0x23280006
0108ba16 ff15d4d38500 call qword ptr [rip + 0x85d3d4]
0108ba1c 488bf8 mov rdi, rax
0108ba1f 4885c0 test rax, rax
0108ba22 7417 je 0x14108ba3b
0108ba24 488bc8 mov rcx, rax
0108ba27 ff1593d48500 call qword ptr [rip + 0x85d493]
0108ba2d 488bd8 mov rbx, rax
0108ba30 ff154ad58500 call qword ptr [rip + 0x85d54a]
0108ba36 483bd8 cmp rbx, rax
0108ba39 7505 jne 0x14108ba40
0108ba3b 4885ff test rdi, rdi
0108ba3e 7507 jne 0x14108ba47
0108ba40 488b3db1210201 mov rdi, qword ptr [rip + 0x10221b1]
0108ba47 488bd7 mov rdx, rdi
0108ba4a 488d4df0 lea rcx, [rbp - 0x10]
0108ba4e e88da8a4ff call 0x140ad62e0
0108ba53 0f2875f0 movaps xmm6, xmmword ptr [rbp - 0x10]
0108ba57 660f7f7530 movdqa xmmword ptr [rbp + 0x30], xmm6
0108ba5c 89742468 mov dword ptr [rsp + 0x68], esi
0108ba60 89742460 mov dword ptr [rsp + 0x60], esi
0108ba64 498dbf640e0000 lea rdi, [r15 + 0xe64]
0108ba6b ff1567d38500 call qword ptr [rip + 0x85d367]
0108ba71 488b05d8d38500 mov rax, qword ptr [rip + 0x85d3d8]
0108ba78 f20f5800 addsd xmm0, qword ptr [rax]
0108ba7c f2480f2cc8 cvttsd2si rcx, xmm0
0108ba81 e83acbb3ff call 0x140bc85c0
0108ba86 8945b0 mov dword ptr [rbp - 0x50], eax
0108ba89 c644243101 mov byte ptr [rsp + 0x31], 1
0108ba8e 8b1f mov ebx, dword ptr [rdi]
0108ba90 448bd6 mov r10d, esi
0108ba93 85db test ebx, ebx
0108ba95 7457 je 0x14108baee
0108ba97 4c8d4f09 lea r9, [rdi + 9]
0108ba9b 448bdb mov r11d, ebx
0108ba9e 6690 nop 
0108baa0 410fb641ff movzx eax, byte ptr [r9 - 1]
0108baa5 6bc83c imul ecx, eax, 0x3c
0108baa8 410fb601 movzx eax, byte ptr [r9]
0108baac 03c8 add ecx, eax
0108baae 448bc6 mov r8d, esi
0108bab1 742e je 0x14108bae1
0108bab3 0f1f4000 nop dword ptr [rax]
0108bab7 660f1f840000000000 nop word ptr [rax + rax]
0108bac0 b867666666 mov eax, 0x66666667
0108bac5 f7e9 imul ecx
0108bac7 c1fa02 sar edx, 2
0108baca 8bc2 mov eax, edx
0108bacc c1e81f shr eax, 0x1f
0108bacf 03d0 add edx, eax
0108bad1 8d0492 lea eax, [rdx + rdx*4]
0108bad4 03c0 add eax, eax
0108bad6 2bc8 sub ecx, eax
0108bad8 4403c1 add r8d, ecx
0108badb 8bca mov ecx, edx
0108badd 85d2 test edx, edx
0108badf 7fdf jg 0x14108bac0
0108bae1 4503d0 add r10d, r8d
0108bae4 4983c105 add r9, 5
0108bae8 4983eb01 sub r11, 1
0108baec 75b2 jne 0x14108baa0
0108baee 488bd3 mov rdx, rbx
0108baf1 4c8d6f08 lea r13, [rdi + 8]
0108baf5 488d0c9f lea rcx, [rdi + rbx*4]
0108baf9 440fb6440b09 movzx r8d, byte ptr [rbx + rcx + 9]
0108baff 41c1e008 shl r8d, 8
0108bb03 410fb64501 movzx eax, byte ptr [r13 + 1]
0108bb08 c1e008 shl eax, 8
0108bb0b 442bc0 sub r8d, eax
0108bb0e 0fb6440b08 movzx eax, byte ptr [rbx + rcx + 8]
0108bb13 69c8003c0000 imul ecx, eax, 0x3c00
0108bb19 4403c1 add r8d, ecx
0108bb1c 410fb64500 movzx eax, byte ptr [r13]
0108bb21 69c8003c0000 imul ecx, eax, 0x3c00
0108bb27 442bc1 sub r8d, ecx
0108bb2a b881808080 mov eax, 0x80808081
0108bb2f 41f7ea imul r10d
0108bb32 4103d2 add edx, r10d
0108bb35 c1fa07 sar edx, 7
0108bb38 8bc2 mov eax, edx
0108bb3a c1e81f shr eax, 0x1f
0108bb3d 03d0 add edx, eax
0108bb3f c1e218 shl edx, 0x18
0108bb42 41c1e218 shl r10d, 0x18
0108bb46 4103d2 add edx, r10d
0108bb49 440bc2 or r8d, edx
0108bb4c 440bc3 or r8d, ebx
0108bb4f 458987540a0000 mov dword ptr [r15 + 0xa54], r8d
0108bb56 498d9760100000 lea rdx, [r15 + 0x1060]
0108bb5d 488bcf mov rcx, rdi
0108bb60 e84b6db7ff call 0x140c028b0
0108bb65 807f0400 cmp byte ptr [rdi + 4], 0
0108bb69 0f95c0 setne al
0108bb6c 4188877e100000 mov byte ptr [r15 + 0x107e], al
0108bb73 448b17 mov r10d, dword ptr [rdi]
0108bb76 448955b8 mov dword ptr [rbp - 0x48], r10d
0108bb7a 66480f7ef6 movq rsi, xmm6
0108bb7f 48897590 mov qword ptr [rbp - 0x70], rsi
0108bb83 4585d2 test r10d, r10d
0108bb86 0f84d60c0000 je 0x14108c862
0108bb8c 4e8d0497 lea r8, [rdi + r10*4]
0108bb90 430fb6540209 movzx edx, byte ptr [r10 + r8 + 9]
0108bb96 430fb6440208 movzx eax, byte ptr [r10 + r8 + 8]
0108bb9c 6bc83c imul ecx, eax, 0x3c
0108bb9f 03d1 add edx, ecx
0108bba1 6bca4b imul ecx, edx, 0x4b
0108bba4 430fb644020a movzx eax, byte ptr [r10 + r8 + 0xa]
0108bbaa 03c8 add ecx, eax
0108bbac 41898f580a0000 mov dword ptr [r15 + 0xa58], ecx
0108bbb3 410fb64500 movzx eax, byte ptr [r13]
0108bbb8 6bc83c imul ecx, eax, 0x3c
0108bbbb 410fb64501 movzx eax, byte ptr [r13 + 1]
0108bbc0 03c8 add ecx, eax
0108bbc2 446bf14b imul r14d, ecx, 0x4b
0108bbc6 410fb64502 movzx eax, byte ptr [r13 + 2]
0108bbcb 4403f0 add r14d, eax
0108bbce 418b7500 mov esi, dword ptr [r13]
0108bbd2 8974246c mov dword ptr [rsp + 0x6c], esi
0108bbd6 410fb67d04 movzx edi, byte ptr [r13 + 4]
0108bbdb c644243001 mov byte ptr [rsp + 0x30], 1
0108bbe0 4180fa01 cmp r10b, 1
0108bbe4 0f82f00b0000 jb 0x14108c7da
0108bbea 660f1f440000 nop word ptr [rax + rax]
0108bbf0 450fb67d03 movzx r15d, byte ptr [r13 + 3]
0108bbf5 4983c505 add r13, 5
0108bbf9 4c896dd8 mov qword ptr [rbp - 0x28], r13
0108bbfd 410fb64500 movzx eax, byte ptr [r13]
0108bc02 6bc83c imul ecx, eax, 0x3c
0108bc05 410fb64501 movzx eax, byte ptr [r13 + 1]
0108bc0a 03c8 add ecx, eax
0108bc0c 6bc94b imul ecx, ecx, 0x4b
0108bc0f 410fb64502 movzx eax, byte ptr [r13 + 2]
0108bc14 03c8 add ecx, eax
0108bc16 894c2474 mov dword ptr [rsp + 0x74], ecx
0108bc1a 33db xor ebx, ebx
0108bc1c 48895c2428 mov qword ptr [rsp + 0x28], rbx
0108bc21 8b45b0 mov eax, dword ptr [rbp - 0x50]
0108bc24 89442420 mov dword ptr [rsp + 0x20], eax
0108bc28 4533c9 xor r9d, r9d
0108bc2b 4533c0 xor r8d, r8d
0108bc2e ba20204443 mov edx, 0x43442020
0108bc33 488b4da8 mov rcx, qword ptr [rbp - 0x58]
0108bc37 488b4908 mov rcx, qword ptr [rcx + 8]
0108bc3b e8406ff0ff call 0x140f92b80
0108bc40 4c8be8 mov r13, rax
0108bc43 488945c0 mov qword ptr [rbp - 0x40], rax
0108bc47 4885c0 test rax, rax
0108bc4a 0f847c0b0000 je 0x14108c7cc
0108bc50 488b5858 mov rbx, qword ptr [rax + 0x58]
0108bc54 e8e7cde1ff call 0x140ea8a40
0108bc59 84c0 test al, al
0108bc5b 7413 je 0x14108bc70
0108bc5d 498bcd mov rcx, r13
0108bc60 e89b72f0ff call 0x140f92f00
0108bc65 498b4d68 mov rcx, qword ptr [r13 + 0x68]
0108bc69 c7411008000000 mov dword ptr [rcx + 0x10], 8
0108bc70 400fb6cf movzx ecx, dil
0108bc74 83e10d and ecx, 0xd
0108bc77 7438 je 0x14108bcb1
0108bc79 83e901 sub ecx, 1
0108bc7c 742f je 0x14108bcad
0108bc7e 83e903 sub ecx, 3
0108bc81 741e je 0x14108bca1
0108bc83 83e904 sub ecx, 4
0108bc86 7415 je 0x14108bc9d
0108bc88 83f901 cmp ecx, 1
0108bc8b 740c je 0x14108bc99
0108bc8d 32c0 xor al, al
0108bc8f 41808d9a00000002 or byte ptr [r13 + 0x9a], 2
0108bc97 eb1e jmp 0x14108bcb7
0108bc99 b004 mov al, 4
0108bc9b eb16 jmp 0x14108bcb3
0108bc9d b003 mov al, 3
0108bc9f eb12 jmp 0x14108bcb3
0108bca1 b005 mov al, 5
0108bca3 41808d9a00000002 or byte ptr [r13 + 0x9a], 2
0108bcab eb0a jmp 0x14108bcb7
0108bcad b002 mov al, 2
0108bcaf eb02 jmp 0x14108bcb3
0108bcb1 b001 mov al, 1
0108bcb3 ff442468 inc dword ptr [rsp + 0x68]
0108bcb7 2c02 sub al, 2
0108bcb9 a8fd test al, 0xfd
0108bcbb 7508 jne 0x14108bcc5
0108bcbd 41808d9c00000020 or byte ptr [r13 + 0x9c], 0x20
0108bcc5 488b45a8 mov rax, qword ptr [rbp - 0x58]
0108bcc9 488b4008 mov rax, qword ptr [rax + 8]
0108bccd 488d8b80000000 lea rcx, [rbx + 0x80]
0108bcd4 480570190000 add rax, 0x1970
0108bcda ba04000000 mov edx, 4
0108bcdf 90 nop 
0108bce0 0f1000 movups xmm0, xmmword ptr [rax]
0108bce3 0f1101 movups xmmword ptr [rcx], xmm0
0108bce6 0f104810 movups xmm1, xmmword ptr [rax + 0x10]
0108bcea 0f114910 movups xmmword ptr [rcx + 0x10], xmm1
0108bcee 0f104020 movups xmm0, xmmword ptr [rax + 0x20]
0108bcf2 0f114120 movups xmmword ptr [rcx + 0x20], xmm0
0108bcf6 0f104830 movups xmm1, xmmword ptr [rax + 0x30]
0108bcfa 0f114930 movups xmmword ptr [rcx + 0x30], xmm1
0108bcfe 0f104040 movups xmm0, xmmword ptr [rax + 0x40]
0108bd02 0f114140 movups xmmword ptr [rcx + 0x40], xmm0
0108bd06 0f104850 movups xmm1, xmmword ptr [rax + 0x50]
0108bd0a 0f114950 movups xmmword ptr [rcx + 0x50], xmm1
0108bd0e 0f104060 movups xmm0, xmmword ptr [rax + 0x60]
0108bd12 0f114160 movups xmmword ptr [rcx + 0x60], xmm0
0108bd16 488d8980000000 lea rcx, [rcx + 0x80]
0108bd1d 0f104870 movups xmm1, xmmword ptr [rax + 0x70]
0108bd21 0f1149f0 movups xmmword ptr [rcx - 0x10], xmm1
0108bd25 488d8080000000 lea rax, [rax + 0x80]
0108bd2c 4883ea01 sub rdx, 1
0108bd30 75ae jne 0x14108bce0
0108bd32 0f1000 movups xmm0, xmmword ptr [rax]
0108bd35 0f1101 movups xmmword ptr [rcx], xmm0
0108bd38 0f104810 movups xmm1, xmmword ptr [rax + 0x10]
0108bd3c 0f114910 movups xmmword ptr [rcx + 0x10], xmm1
0108bd40 0fb6442430 movzx eax, byte ptr [rsp + 0x30]
0108bd45 668983a8020000 mov word ptr [rbx + 0x2a8], ax
0108bd4c 664489bbaa020000 mov word ptr [rbx + 0x2aa], r15w
0108bd54 440fb6442431 movzx r8d, byte ptr [rsp + 0x31]
0108bd5a 664589850a010000 mov word ptr [r13 + 0x10a], r8w
0108bd62 4088b3ac020000 mov byte ptr [rbx + 0x2ac], sil
0108bd69 0fb644246d movzx eax, byte ptr [rsp + 0x6d]
0108bd6e 8883ad020000 mov byte ptr [rbx + 0x2ad], al
0108bd74 0fb644246e movzx eax, byte ptr [rsp + 0x6e]
0108bd79 8883ae020000 mov byte ptr [rbx + 0x2ae], al
0108bd7f 488b55d8 mov rdx, qword ptr [rbp - 0x28]
0108bd83 0fb60a movzx ecx, byte ptr [rdx]
0108bd86 888baf020000 mov byte ptr [rbx + 0x2af], cl
0108bd8c 0fb64201 movzx eax, byte ptr [rdx + 1]
0108bd90 8883b0020000 mov byte ptr [rbx + 0x2b0], al
0108bd96 0fb64202 movzx eax, byte ptr [rdx + 2]
0108bd9a 8883b1020000 mov byte ptr [rbx + 0x2b1], al
0108bda0 488b55a0 mov rdx, qword ptr [rbp - 0x60]
0108bda4 888a78100000 mov byte ptr [rdx + 0x1078], cl
0108bdaa 0fb683b0020000 movzx eax, byte ptr [rbx + 0x2b0]
0108bdb1 888279100000 mov byte ptr [rdx + 0x1079], al
0108bdb7 0fb683b1020000 movzx eax, byte ptr [rbx + 0x2b1]
0108bdbe 88827a100000 mov byte ptr [rdx + 0x107a], al
0108bdc4 41fec0 inc r8b
0108bdc7 4488442431 mov byte ptr [rsp + 0x31], r8b
0108bdcc fe8270100000 inc byte ptr [rdx + 0x1070]
0108bdd2 0fb683b1020000 movzx eax, byte ptr [rbx + 0x2b1]
0108bdd9 84c0 test al, al
0108bddb 740a je 0x14108bde7
0108bddd fec8 dec al
0108bddf 8883b1020000 mov byte ptr [rbx + 0x2b1], al
0108bde5 eb29 jmp 0x14108be10
0108bde7 c683b10200004a mov byte ptr [rbx + 0x2b1], 0x4a
0108bdee 0fb683b0020000 movzx eax, byte ptr [rbx + 0x2b0]
0108bdf5 84c0 test al, al
0108bdf7 740a je 0x14108be03
0108bdf9 fec8 dec al
0108bdfb 8883b0020000 mov byte ptr [rbx + 0x2b0], al
0108be01 eb0d jmp 0x14108be10
0108be03 c683b00200003b mov byte ptr [rbx + 0x2b0], 0x3b
0108be0a fe8baf020000 dec byte ptr [rbx + 0x2af]
0108be10 4169cee8030000 imul ecx, r14d, 0x3e8
0108be17 b8b5814e1b mov eax, 0x1b4e81b5
0108be1c f7e1 mul ecx
0108be1e c1ea03 shr edx, 3
0108be21 8993a4020000 mov dword ptr [rbx + 0x2a4], edx
0108be27 448b442474 mov r8d, dword ptr [rsp + 0x74]
0108be2c 452bc6 sub r8d, r14d
0108be2f 448983a0020000 mov dword ptr [rbx + 0x2a0], r8d
0108be36 c6433c01 mov byte ptr [rbx + 0x3c], 1
0108be3a 4169c8e8030000 imul ecx, r8d, 0x3e8
0108be41 b8b5814e1b mov eax, 0x1b4e81b5
0108be46 f7e1 mul ecx
0108be48 c1ea03 shr edx, 3
0108be4b 89535c mov dword ptr [rbx + 0x5c], edx
0108be4e 4169c830090000 imul ecx, r8d, 0x930
0108be55 48894b60 mov qword ptr [rbx + 0x60], rcx
0108be59 66c7434c8305 mov word ptr [rbx + 0x4c], 0x583
0108be5f c7434800442c47 mov dword ptr [rbx + 0x48], 0x472c4400
0108be66 ff156ccf8500 call qword ptr [rip + 0x85cf6c]
0108be6c 488b05ddcf8500 mov rax, qword ptr [rip + 0x85cfdd]
0108be73 f20f5800 addsd xmm0, qword ptr [rax]
0108be77 f2480f2cc8 cvttsd2si rcx, xmm0
0108be7c e83fc7b3ff call 0x140bc85c0
0108be81 4883c354 add rbx, 0x54
0108be85 7402 je 0x14108be89
0108be87 8903 mov dword ptr [rbx], eax
0108be89 440fb67c2430 movzx r15d, byte ptr [rsp + 0x30]
0108be8f 458bc7 mov r8d, r15d
0108be92 488d15bf61a200 lea rdx, [rip + 0xa261bf]
0108be99 488d4c2440 lea rcx, [rsp + 0x40]
0108be9e e82de7a4ff call 0x140ada5d0
0108bea3 90 nop 
0108bea4 4180ff0a cmp r15b, 0xa
0108bea8 0f83fd050000 jae 0x14108c4ab
0108beae 4533ff xor r15d, r15d
0108beb1 4c897d00 mov qword ptr [rbp], r15
0108beb5 ba01000000 mov edx, 1
0108beba 488d0dbb65a000 lea rcx, [rip + 0xa065bb]
0108bec1 e84a1da5ff call 0x140addc10
0108bec6 4c8be8 mov r13, rax
0108bec9 48894508 mov qword ptr [rbp + 8], rax
0108becd 418bf7 mov esi, r15d
0108bed0 4c897c2450 mov qword ptr [rsp + 0x50], r15
0108bed5 488bf8 mov rdi, rax
0108bed8 4889442458 mov qword ptr [rsp + 0x58], rax
0108bedd 4885c0 test rax, rax
0108bee0 740e je 0x14108bef0
0108bee2 f0ff4008 lock inc dword ptr [rax + 8]
0108bee6 488b7c2458 mov rdi, qword ptr [rsp + 0x58]
0108beeb 488b742450 mov rsi, qword ptr [rsp + 0x50]
0108bef0 8b442464 mov eax, dword ptr [rsp + 0x64]
0108bef4 83c802 or eax, 2
0108bef7 89442464 mov dword ptr [rsp + 0x64], eax
0108befb 8945b4 mov dword ptr [rbp - 0x4c], eax
0108befe 4885f6 test rsi, rsi
0108bf01 0f84cb010000 je 0x14108c0d2
0108bf07 488b5c2440 mov rbx, qword ptr [rsp + 0x40]
0108bf0c 4885db test rbx, rbx
0108bf0f 0f848f000000 je 0x14108bfa4
0108bf15 4c8b36 mov r14, qword ptr [rsi]
0108bf18 4c0333 add r14, qword ptr [rbx]
0108bf1b 4a8d0c7510000000 lea rcx, [r14*2 + 0x10]
0108bf23 488d15d66c8800 lea rdx, [rip + 0x886cd6]
0108bf2a e8bdff7000 call 0x14179beec
0108bf2f 488bf8 mov rdi, rax
0108bf32 4885c0 test rax, rax
0108bf35 743f je 0x14108bf76
0108bf37 4c8930 mov qword ptr [rax], r14
0108bf3a c7400801000000 mov dword ptr [rax + 8], 1
0108bf41 6646897c700c mov word ptr [rax + r14*2 + 0xc], r15w
0108bf47 4c8b06 mov r8, qword ptr [rsi]
0108bf4a 4d03c0 add r8, r8
0108bf4d 488d560c lea rdx, [rsi + 0xc]
0108bf51 488d480c lea rcx, [rax + 0xc]
0108bf55 e8400d7100 call 0x14179cc9a
0108bf5a 4c8b03 mov r8, qword ptr [rbx]
0108bf5d 4d03c0 add r8, r8
0108bf60 488d530c lea rdx, [rbx + 0xc]
0108bf64 488b06 mov rax, qword ptr [rsi]
0108bf67 4883c006 add rax, 6
0108bf6b 488d0c47 lea rcx, [rdi + rax*2]
0108bf6f e8260d7100 call 0x14179cc9a
0108bf74 eb03 jmp 0x14108bf79
0108bf76 498bff mov rdi, r15
0108bf79 488b4c2450 mov rcx, qword ptr [rsp + 0x50]
0108bf7e 4885c9 test rcx, rcx
0108bf81 0f8419010000 je 0x14108c0a0
0108bf87 418bc4 mov eax, r12d
0108bf8a f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108bf8f 83f801 cmp eax, 1
0108bf92 0f8503010000 jne 0x14108c09b
0108bf98 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108bf9f e9f2000000 jmp 0x14108c096
0108bfa4 48837c244800 cmp qword ptr [rsp + 0x48], 0
0108bfaa 0f8467040000 je 0x14108c417
0108bfb0 488d4c2440 lea rcx, [rsp + 0x40]
0108bfb5 e88615a5ff call 0x140add540
0108bfba 488b5c2440 mov rbx, qword ptr [rsp + 0x40]
0108bfbf 4885db test rbx, rbx
0108bfc2 7405 je 0x14108bfc9
0108bfc4 4c8b3b mov r15, qword ptr [rbx]
0108bfc7 eb12 jmp 0x14108bfdb
0108bfc9 48837c244800 cmp qword ptr [rsp + 0x48], 0
0108bfcf 740a je 0x14108bfdb
0108bfd1 488d4c2440 lea rcx, [rsp + 0x40]
0108bfd6 e86515a5ff call 0x140add540
0108bfdb 488b5c2440 mov rbx, qword ptr [rsp + 0x40]
0108bfe0 4885db test rbx, rbx
0108bfe3 488d730c lea rsi, [rbx + 0xc]
0108bfe7 7507 jne 0x14108bff0
0108bfe9 488d3558539200 lea rsi, [rip + 0x925358]
0108bff0 488b5c2450 mov rbx, qword ptr [rsp + 0x50]
0108bff5 4885db test rbx, rbx
0108bff8 747a je 0x14108c074
0108bffa 4885f6 test rsi, rsi
0108bffd 7475 je 0x14108c074
0108bfff 4c8b33 mov r14, qword ptr [rbx]
0108c002 4d03f7 add r14, r15
0108c005 4a8d0c7510000000 lea rcx, [r14*2 + 0x10]
0108c00d 488d15ec6b8800 lea rdx, [rip + 0x886bec]
0108c014 e8d3fe7000 call 0x14179beec
0108c019 488bf8 mov rdi, rax
0108c01c 4885c0 test rax, rax
0108c01f 7446 je 0x14108c067
0108c021 4c8930 mov qword ptr [rax], r14
0108c024 c7400801000000 mov dword ptr [rax + 8], 1
0108c02b 33c0 xor eax, eax
0108c02d 66428944770c mov word ptr [rdi + r14*2 + 0xc], ax
0108c033 4c8b03 mov r8, qword ptr [rbx]
0108c036 4d03c0 add r8, r8
0108c039 488d530c lea rdx, [rbx + 0xc]
0108c03d 488d4f0c lea rcx, [rdi + 0xc]
0108c041 e8540c7100 call 0x14179cc9a
0108c046 4f8d043f lea r8, [r15 + r15]
0108c04a 488b03 mov rax, qword ptr [rbx]
0108c04d 4883c006 add rax, 6
0108c051 488d0c47 lea rcx, [rdi + rax*2]
0108c055 488bd6 mov rdx, rsi
0108c058 e83d0c7100 call 0x14179cc9a
0108c05d 4533ff xor r15d, r15d
0108c060 488b5c2450 mov rbx, qword ptr [rsp + 0x50]
0108c065 eb13 jmp 0x14108c07a
0108c067 4533ff xor r15d, r15d
0108c06a 418bff mov edi, r15d
0108c06d 488b5c2450 mov rbx, qword ptr [rsp + 0x50]
0108c072 eb06 jmp 0x14108c07a
0108c074 4533ff xor r15d, r15d
0108c077 418bff mov edi, r15d
0108c07a 4885db test rbx, rbx
0108c07d 7421 je 0x14108c0a0
0108c07f 418bc4 mov eax, r12d
0108c082 f00fc14308 lock xadd dword ptr [rbx + 8], eax
0108c087 83f801 cmp eax, 1
0108c08a 750f jne 0x14108c09b
0108c08c c74308003665c4 mov dword ptr [rbx + 8], 0xc4653600
0108c093 488bcb mov rcx, rbx
0108c096 e83dfd7000 call 0x14179bdd8
0108c09b 4c897c2450 mov qword ptr [rsp + 0x50], r15
0108c0a0 488b4c2458 mov rcx, qword ptr [rsp + 0x58]
0108c0a5 4885c9 test rcx, rcx
0108c0a8 741e je 0x14108c0c8
0108c0aa 418bc4 mov eax, r12d
0108c0ad f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108c0b2 83f801 cmp eax, 1
0108c0b5 750c jne 0x14108c0c3
0108c0b7 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108c0be e815fd7000 call 0x14179bdd8
0108c0c3 4c897c2458 mov qword ptr [rsp + 0x58], r15
0108c0c8 48897c2450 mov qword ptr [rsp + 0x50], rdi
0108c0cd e945030000 jmp 0x14108c417
0108c0d2 4885ff test rdi, rdi
0108c0d5 0f84e9020000 je 0x14108c3c4
0108c0db 488b5c2448 mov rbx, qword ptr [rsp + 0x48]
0108c0e0 4885db test rbx, rbx
0108c0e3 0f84ae000000 je 0x14108c197
0108c0e9 4c8b37 mov r14, qword ptr [rdi]
0108c0ec 4c0333 add r14, qword ptr [rbx]
0108c0ef 498d4e10 lea rcx, [r14 + 0x10]
0108c0f3 488d15066b8800 lea rdx, [rip + 0x886b06]
0108c0fa e8edfd7000 call 0x14179beec
0108c0ff 488bf0 mov rsi, rax
0108c102 4885c0 test rax, rax
0108c105 7438 je 0x14108c13f
0108c107 4c8930 mov qword ptr [rax], r14
0108c10a c7400801000000 mov dword ptr [rax + 8], 1
0108c111 41c644060c00 mov byte ptr [r14 + rax + 0xc], 0
0108c117 488d570c lea rdx, [rdi + 0xc]
0108c11b 488d480c lea rcx, [rax + 0xc]
0108c11f 4c8b07 mov r8, qword ptr [rdi]
0108c122 e8730b7100 call 0x14179cc9a
0108c127 488d530c lea rdx, [rbx + 0xc]
0108c12b 488b0f mov rcx, qword ptr [rdi]
0108c12e 4883c10c add rcx, 0xc
0108c132 4803ce add rcx, rsi
0108c135 4c8b03 mov r8, qword ptr [rbx]
0108c138 e85d0b7100 call 0x14179cc9a
0108c13d eb03 jmp 0x14108c142
0108c13f 498bf7 mov rsi, r15
0108c142 488b4c2450 mov rcx, qword ptr [rsp + 0x50]
0108c147 4885c9 test rcx, rcx
0108c14a 741e je 0x14108c16a
0108c14c 418bc4 mov eax, r12d
0108c14f f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108c154 83f801 cmp eax, 1
0108c157 750c jne 0x14108c165
0108c159 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108c160 e873fc7000 call 0x14179bdd8
0108c165 4c897c2450 mov qword ptr [rsp + 0x50], r15
0108c16a 488b4c2458 mov rcx, qword ptr [rsp + 0x58]
0108c16f 4885c9 test rcx, rcx
0108c172 7419 je 0x14108c18d
0108c174 418bc4 mov eax, r12d
0108c177 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108c17c 83f801 cmp eax, 1
0108c17f 750c jne 0x14108c18d
0108c181 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108c188 e84bfc7000 call 0x14179bdd8
0108c18d 4889742458 mov qword ptr [rsp + 0x58], rsi
0108c192 e980020000 jmp 0x14108c417
0108c197 48837c244000 cmp qword ptr [rsp + 0x40], 0
0108c19d 0f8474020000 je 0x14108c417
0108c1a3 488d4c2440 lea rcx, [rsp + 0x40]
0108c1a8 e81312a5ff call 0x140add3c0
0108c1ad 488b5c2448 mov rbx, qword ptr [rsp + 0x48]
0108c1b2 4885db test rbx, rbx
0108c1b5 7408 je 0x14108c1bf
0108c1b7 4c8b2b mov r13, qword ptr [rbx]
0108c1ba e921010000 jmp 0x14108c2e0
0108c1bf 4d8bef mov r13, r15
0108c1c2 488b5c2440 mov rbx, qword ptr [rsp + 0x40]
0108c1c7 4885db test rbx, rbx
0108c1ca 0f8410010000 je 0x14108c2e0
0108c1d0 4c8b23 mov r12, qword ptr [rbx]
0108c1d3 4d85e4 test r12, r12
0108c1d6 0f84fe000000 je 0x14108c2da
0108c1dc 4e8d34a500000000 lea r14, [r12*4]
0108c1e4 0f57c0 xorps xmm0, xmm0
0108c1e7 f30f7f4510 movdqu xmmword ptr [rbp + 0x10], xmm0
0108c1ec 498bf7 mov rsi, r15
0108c1ef 4c897d20 mov qword ptr [rbp + 0x20], r15
0108c1f3 498bff mov rdi, r15
0108c1f6 4d85f6 test r14, r14
0108c1f9 7440 je 0x14108c23b
0108c1fb 48b8ffffffffffffff7f movabs rax, 0x7fffffffffffffff
0108c205 4c3bf0 cmp r14, rax
0108c208 0f87e9060000 ja 0x14108c8f7
0108c20e 498bce mov rcx, r14
0108c211 e86a5d1cff call 0x140251f80
0108c216 488bf8 mov rdi, rax
0108c219 4c8bf8 mov r15, rax
0108c21c 48894510 mov qword ptr [rbp + 0x10], rax
0108c220 498d3406 lea rsi, [r14 + rax]
0108c224 48897520 mov qword ptr [rbp + 0x20], rsi
0108c228 4d8bc6 mov r8, r14
0108c22b 33d2 xor edx, edx
0108c22d 488bc8 mov rcx, rax
0108c230 e86b0a7100 call 0x14179cca0
0108c235 48897518 mov qword ptr [rbp + 0x18], rsi
0108c239 eb04 jmp 0x14108c23f
0108c23b 4c8b7d10 mov r15, qword ptr [rbp + 0x10]
0108c23f 33c0 xor eax, eax
0108c241 488945d0 mov qword ptr [rbp - 0x30], rax
0108c245 4839442440 cmp qword ptr [rsp + 0x40], rax
0108c24a 7511 jne 0x14108c25d
0108c24c 4839442448 cmp qword ptr [rsp + 0x48], rax
0108c251 740a je 0x14108c25d
0108c253 488d4c2440 lea rcx, [rsp + 0x40]
0108c258 e8e312a5ff call 0x140add540
0108c25d 488b5c2440 mov rbx, qword ptr [rsp + 0x40]
0108c262 4885db test rbx, rbx
0108c265 488d4b0c lea rcx, [rbx + 0xc]
0108c269 7507 jne 0x14108c272
0108c26b 488d0dd6509200 lea rcx, [rip + 0x9250d6]
0108c272 488d45d0 lea rax, [rbp - 0x30]
0108c276 4889442420 mov qword ptr [rsp + 0x20], rax
0108c27b 4d8bce mov r9, r14
0108c27e 4c8bc7 mov r8, rdi
0108c281 498bd4 mov rdx, r12
0108c284 e8c7fda4ff call 0x140adc050
0108c289 488b55d0 mov rdx, qword ptr [rbp - 0x30]
0108c28d 4885d2 test rdx, rdx
0108c290 740d je 0x14108c29f
0108c292 498bcf mov rcx, r15
0108c295 e87619a5ff call 0x140addc10
0108c29a 4889442448 mov qword ptr [rsp + 0x48], rax
0108c29f 4885ff test rdi, rdi
0108c2a2 7433 je 0x14108c2d7
0108c2a4 482bf7 sub rsi, rdi
0108c2a7 4881fe00100000 cmp rsi, 0x1000
0108c2ae 721c jb 0x14108c2cc
0108c2b0 4883c627 add rsi, 0x27
0108c2b4 488b47f8 mov rax, qword ptr [rdi - 8]
0108c2b8 482bf8 sub rdi, rax
0108c2bb 4883ef08 sub rdi, 8
0108c2bf 4883ff1f cmp rdi, 0x1f
0108c2c3 0f87eb040000 ja 0x14108c7b4
0108c2c9 488bf8 mov rdi, rax
0108c2cc 488bd6 mov rdx, rsi
0108c2cf 488bcf mov rcx, rdi
0108c2d2 e849a7b3ff call 0x140bc6a20
0108c2d7 4533ff xor r15d, r15d
0108c2da 41bcffffffff mov r12d, 0xffffffff
0108c2e0 488b5c2448 mov rbx, qword ptr [rsp + 0x48]
0108c2e5 4885db test rbx, rbx
0108c2e8 488d730c lea rsi, [rbx + 0xc]
0108c2ec 7507 jne 0x14108c2f5
0108c2ee 488d3598659100 lea rsi, [rip + 0x916598]
0108c2f5 488b5c2458 mov rbx, qword ptr [rsp + 0x58]
0108c2fa 4885db test rbx, rbx
0108c2fd 7469 je 0x14108c368
0108c2ff 4885f6 test rsi, rsi
0108c302 7464 je 0x14108c368
0108c304 4c8b33 mov r14, qword ptr [rbx]
0108c307 4d03f5 add r14, r13
0108c30a 498d4e10 lea rcx, [r14 + 0x10]
0108c30e 488d15eb688800 lea rdx, [rip + 0x8868eb]
0108c315 e8d2fb7000 call 0x14179beec
0108c31a 488bf8 mov rdi, rax
0108c31d 4885c0 test rax, rax
0108c320 743c je 0x14108c35e
0108c322 4c8930 mov qword ptr [rax], r14
0108c325 c7400801000000 mov dword ptr [rax + 8], 1
0108c32c 42c644300c00 mov byte ptr [rax + r14 + 0xc], 0
0108c332 488d530c lea rdx, [rbx + 0xc]
0108c336 488d480c lea rcx, [rax + 0xc]
0108c33a 4c8b03 mov r8, qword ptr [rbx]
0108c33d e858097100 call 0x14179cc9a
0108c342 488b0b mov rcx, qword ptr [rbx]
0108c345 4883c10c add rcx, 0xc
0108c349 4803cf add rcx, rdi
0108c34c 4d8bc5 mov r8, r13
0108c34f 488bd6 mov rdx, rsi
0108c352 e843097100 call 0x14179cc9a
0108c357 488b5c2458 mov rbx, qword ptr [rsp + 0x58]
0108c35c eb0d jmp 0x14108c36b
0108c35e 498bff mov rdi, r15
0108c361 488b5c2458 mov rbx, qword ptr [rsp + 0x58]
0108c366 eb03 jmp 0x14108c36b
0108c368 498bff mov rdi, r15
0108c36b 488b4c2450 mov rcx, qword ptr [rsp + 0x50]
0108c370 4885c9 test rcx, rcx
0108c373 7423 je 0x14108c398
0108c375 418bc4 mov eax, r12d
0108c378 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108c37d 83f801 cmp eax, 1
0108c380 750c jne 0x14108c38e
0108c382 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108c389 e84afa7000 call 0x14179bdd8
0108c38e 4c897c2450 mov qword ptr [rsp + 0x50], r15
0108c393 488b5c2458 mov rbx, qword ptr [rsp + 0x58]
0108c398 4885db test rbx, rbx
0108c39b 741c je 0x14108c3b9
0108c39d 418bc4 mov eax, r12d
0108c3a0 f00fc14308 lock xadd dword ptr [rbx + 8], eax
0108c3a5 83f801 cmp eax, 1
0108c3a8 750f jne 0x14108c3b9
0108c3aa c74308003665c4 mov dword ptr [rbx + 8], 0xc4653600
0108c3b1 488bcb mov rcx, rbx
0108c3b4 e81ffa7000 call 0x14179bdd8
0108c3b9 48897c2458 mov qword ptr [rsp + 0x58], rdi
0108c3be 4c8b6d08 mov r13, qword ptr [rbp + 8]
0108c3c2 eb53 jmp 0x14108c417
0108c3c4 488b5c2440 mov rbx, qword ptr [rsp + 0x40]
0108c3c9 4885db test rbx, rbx
0108c3cc 740e je 0x14108c3dc
0108c3ce 48895c2450 mov qword ptr [rsp + 0x50], rbx
0108c3d3 f0ff4308 lock inc dword ptr [rbx + 8]
0108c3d7 488b7c2458 mov rdi, qword ptr [rsp + 0x58]
0108c3dc 483b7c2448 cmp rdi, qword ptr [rsp + 0x48]
0108c3e1 7434 je 0x14108c417
0108c3e3 4885ff test rdi, rdi
0108c3e6 741c je 0x14108c404
0108c3e8 418bc4 mov eax, r12d
0108c3eb f00fc14708 lock xadd dword ptr [rdi + 8], eax
0108c3f0 83f801 cmp eax, 1
0108c3f3 750f jne 0x14108c404
0108c3f5 c74708003665c4 mov dword ptr [rdi + 8], 0xc4653600
0108c3fc 488bcf mov rcx, rdi
0108c3ff e8d4f97000 call 0x14179bdd8
0108c404 488b5c2448 mov rbx, qword ptr [rsp + 0x48]
0108c409 48895c2458 mov qword ptr [rsp + 0x58], rbx
0108c40e 4885db test rbx, rbx
0108c411 7404 je 0x14108c417
0108c413 f0ff4308 lock inc dword ptr [rbx + 8]
0108c417 488b4c2440 mov rcx, qword ptr [rsp + 0x40]
0108c41c 4885c9 test rcx, rcx
0108c41f 7419 je 0x14108c43a
0108c421 418bc4 mov eax, r12d
0108c424 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108c429 83f801 cmp eax, 1
0108c42c 750c jne 0x14108c43a
0108c42e c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108c435 e89ef97000 call 0x14179bdd8
0108c43a 488b4c2448 mov rcx, qword ptr [rsp + 0x48]
0108c43f 4885c9 test rcx, rcx
0108c442 7419 je 0x14108c45d
0108c444 418bc4 mov eax, r12d
0108c447 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108c44c 83f801 cmp eax, 1
0108c44f 750c jne 0x14108c45d
0108c451 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108c458 e87bf97000 call 0x14179bdd8
0108c45d 0f28442450 movaps xmm0, xmmword ptr [rsp + 0x50]
0108c462 660f7f442440 movdqa xmmword ptr [rsp + 0x40], xmm0
0108c468 0f57c9 xorps xmm1, xmm1
0108c46b 660f7f4c2450 movdqa xmmword ptr [rsp + 0x50], xmm1
0108c471 8b5c2464 mov ebx, dword ptr [rsp + 0x64]
0108c475 83e3fd and ebx, 0xfffffffd
0108c478 4d85ed test r13, r13
0108c47b 7422 je 0x14108c49f
0108c47d 418bc4 mov eax, r12d
0108c480 f0410fc14508 lock xadd dword ptr [r13 + 8], eax
0108c486 83f801 cmp eax, 1
0108c489 7510 jne 0x14108c49b
0108c48b 41c74508003665c4 mov dword ptr [r13 + 8], 0xc4653600
0108c493 498bcd mov rcx, r13
0108c496 e83df97000 call 0x14179bdd8
0108c49b 4c897d08 mov qword ptr [rbp + 8], r15
0108c49f 4c8b6dc0 mov r13, qword ptr [rbp - 0x40]
0108c4a3 440fb67c2430 movzx r15d, byte ptr [rsp + 0x30]
0108c4a9 eb04 jmp 0x14108c4af
0108c4ab 8b5c2464 mov ebx, dword ptr [rsp + 0x64]
0108c4af 488b442440 mov rax, qword ptr [rsp + 0x40]
0108c4b4 4885c0 test rax, rax
0108c4b7 7524 jne 0x14108c4dd
0108c4b9 4839442448 cmp qword ptr [rsp + 0x48], rax
0108c4be 7414 je 0x14108c4d4
0108c4c0 488d4c2440 lea rcx, [rsp + 0x40]
0108c4c5 e87610a5ff call 0x140add540
0108c4ca 488b442440 mov rax, qword ptr [rsp + 0x40]
0108c4cf 4885c0 test rax, rax
0108c4d2 7509 jne 0x14108c4dd
0108c4d4 4c8d056d4e9200 lea r8, [rip + 0x924e6d]
0108c4db eb04 jmp 0x14108c4e1
0108c4dd 4c8d400c lea r8, [rax + 0xc]
0108c4e1 660f7f75f0 movdqa xmmword ptr [rbp - 0x10], xmm6
0108c4e6 488b7590 mov rsi, qword ptr [rbp - 0x70]
0108c4ea 4885f6 test rsi, rsi
0108c4ed 7404 je 0x14108c4f3
0108c4ef f0ff4608 lock inc dword ptr [rsi + 8]
0108c4f3 488b45f8 mov rax, qword ptr [rbp - 8]
0108c4f7 4885c0 test rax, rax
0108c4fa 7404 je 0x14108c500
0108c4fc f0ff4008 lock inc dword ptr [rax + 8]
0108c500 488d55f0 lea rdx, [rbp - 0x10]
0108c504 488d4de0 lea rcx, [rbp - 0x20]
0108c508 e813dfa4ff call 0x140ada420
0108c50d 83cb01 or ebx, 1
0108c510 895c2464 mov dword ptr [rsp + 0x64], ebx
0108c514 488d55e0 lea rdx, [rbp - 0x20]
0108c518 498bcd mov rcx, r13
0108c51b e830a1f0ff call 0x140f96650
0108c520 488b0db9370401 mov rcx, qword ptr [rip + 0x10437b9]
0108c527 4885c9 test rcx, rcx
0108c52a 742f je 0x14108c55b
0108c52c ba05002823 mov edx, 0x23280005
0108c531 ff15b9c88500 call qword ptr [rip + 0x85c8b9]
0108c537 488bf8 mov rdi, rax
0108c53a 4885c0 test rax, rax
0108c53d 7417 je 0x14108c556
0108c53f 488bc8 mov rcx, rax
0108c542 ff1578c98500 call qword ptr [rip + 0x85c978]
0108c548 488bd8 mov rbx, rax
0108c54b ff152fca8500 call qword ptr [rip + 0x85ca2f]
0108c551 483bd8 cmp rbx, rax
0108c554 7505 jne 0x14108c55b
0108c556 4885ff test rdi, rdi
0108c559 7507 jne 0x14108c562
0108c55b 488b3d96160201 mov rdi, qword ptr [rip + 0x1021696]
0108c562 488bd7 mov rdx, rdi
0108c565 488d4c2478 lea rcx, [rsp + 0x78]
0108c56a e8719da4ff call 0x140ad62e0
0108c56f 90 nop 
0108c570 488b5c2478 mov rbx, qword ptr [rsp + 0x78]
0108c575 4885db test rbx, rbx
0108c578 751a jne 0x14108c594
0108c57a 48395d80 cmp qword ptr [rbp - 0x80], rbx
0108c57e 740f je 0x14108c58f
0108c580 488d4c2478 lea rcx, [rsp + 0x78]
0108c585 e8b60fa5ff call 0x140add540
0108c58a 488b5c2478 mov rbx, qword ptr [rsp + 0x78]
0108c58f 4885db test rbx, rbx
0108c592 741d je 0x14108c5b1
0108c594 488b03 mov rax, qword ptr [rbx]
0108c597 b9ff000000 mov ecx, 0xff
0108c59c 483bc1 cmp rax, rcx
0108c59f 660f47c1 cmova ax, cx
0108c5a3 0fb7f8 movzx edi, ax
0108c5a6 66894540 mov word ptr [rbp + 0x40], ax
0108c5aa 4885db test rbx, rbx
0108c5ad 7525 jne 0x14108c5d4
0108c5af eb08 jmp 0x14108c5b9
0108c5b1 33c0 xor eax, eax
0108c5b3 66894540 mov word ptr [rbp + 0x40], ax
0108c5b7 8bf8 mov edi, eax
0108c5b9 48837d8000 cmp qword ptr [rbp - 0x80], 0
0108c5be 740f je 0x14108c5cf
0108c5c0 488d4c2478 lea rcx, [rsp + 0x78]
0108c5c5 e8760fa5ff call 0x140add540
0108c5ca 488b5c2478 mov rbx, qword ptr [rsp + 0x78]
0108c5cf 4885db test rbx, rbx
0108c5d2 7406 je 0x14108c5da
0108c5d4 488d530c lea rdx, [rbx + 0xc]
0108c5d8 eb07 jmp 0x14108c5e1
0108c5da 488d15674d9200 lea rdx, [rip + 0x924d67]
0108c5e1 440fb7c7 movzx r8d, di
0108c5e5 4d03c0 add r8, r8
0108c5e8 488d4d42 lea rcx, [rbp + 0x42]
0108c5ec e8a9067100 call 0x14179cc9a
0108c5f1 90 nop 
0108c5f2 4885db test rbx, rbx
0108c5f5 7425 je 0x14108c61c
0108c5f7 418bc4 mov eax, r12d
0108c5fa f00fc14308 lock xadd dword ptr [rbx + 8], eax
0108c5ff 83f801 cmp eax, 1
0108c602 750f jne 0x14108c613
0108c604 c74308003665c4 mov dword ptr [rbx + 8], 0xc4653600
0108c60b 488bcb mov rcx, rbx
0108c60e e8c5f77000 call 0x14179bdd8
0108c613 33ff xor edi, edi
0108c615 48897c2478 mov qword ptr [rsp + 0x78], rdi
0108c61a eb02 jmp 0x14108c61e
0108c61c 33ff xor edi, edi
0108c61e 488b4d80 mov rcx, qword ptr [rbp - 0x80]
0108c622 4885c9 test rcx, rcx
0108c625 741d je 0x14108c644
0108c627 418bc4 mov eax, r12d
0108c62a f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108c62f 83f801 cmp eax, 1
0108c632 750c jne 0x14108c640
0108c634 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108c63b e898f77000 call 0x14179bdd8
0108c640 48897d80 mov qword ptr [rbp - 0x80], rdi
0108c644 4d8d8dcc000000 lea r9, [r13 + 0xcc]
0108c64b 440fb74540 movzx r8d, word ptr [rbp + 0x40]
0108c650 4503c0 add r8d, r8d
0108c653 498b4d10 mov rcx, qword ptr [r13 + 0x10]
0108c657 4881c170030000 add rcx, 0x370
0108c65e 488d5542 lea rdx, [rbp + 0x42]
0108c662 e8891bb7ff call 0x140bfe1f0
0108c667 0f57c0 xorps xmm0, xmm0
0108c66a f30f7f45c0 movdqu xmmword ptr [rbp - 0x40], xmm0
0108c66f 488d45c0 lea rax, [rbp - 0x40]
0108c673 4889442420 mov qword ptr [rsp + 0x20], rax
0108c678 4533c9 xor r9d, r9d
0108c67b 4533c0 xor r8d, r8d
0108c67e 498bd5 mov rdx, r13
0108c681 488b4da8 mov rcx, qword ptr [rbp - 0x58]
0108c685 e8f67ae6ff call 0x140ef4180
0108c68a 8b5c2460 mov ebx, dword ptr [rsp + 0x60]
0108c68e 4885c0 test rax, rax
0108c691 b894ffffff mov eax, 0xffffff94
0108c696 0f44d8 cmove ebx, eax
0108c699 895c2460 mov dword ptr [rsp + 0x60], ebx
0108c69d 488b4de0 mov rcx, qword ptr [rbp - 0x20]
0108c6a1 4885c9 test rcx, rcx
0108c6a4 741d je 0x14108c6c3
0108c6a6 418bc4 mov eax, r12d
0108c6a9 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108c6ae 83f801 cmp eax, 1
0108c6b1 750c jne 0x14108c6bf
0108c6b3 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108c6ba e819f77000 call 0x14179bdd8
0108c6bf 48897de0 mov qword ptr [rbp - 0x20], rdi
0108c6c3 488b4de8 mov rcx, qword ptr [rbp - 0x18]
0108c6c7 4885c9 test rcx, rcx
0108c6ca 741d je 0x14108c6e9
0108c6cc 418bc4 mov eax, r12d
0108c6cf f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108c6d4 83f801 cmp eax, 1
0108c6d7 750c jne 0x14108c6e5
0108c6d9 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108c6e0 e8f3f67000 call 0x14179bdd8
0108c6e5 48897de8 mov qword ptr [rbp - 0x18], rdi
0108c6e9 488b4c2440 mov rcx, qword ptr [rsp + 0x40]
0108c6ee 4885c9 test rcx, rcx
0108c6f1 741e je 0x14108c711
0108c6f3 418bc4 mov eax, r12d
0108c6f6 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108c6fb 83f801 cmp eax, 1
0108c6fe 750c jne 0x14108c70c
0108c700 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108c707 e8ccf67000 call 0x14179bdd8
0108c70c 48897c2440 mov qword ptr [rsp + 0x40], rdi
0108c711 488b4c2448 mov rcx, qword ptr [rsp + 0x48]
0108c716 4885c9 test rcx, rcx
0108c719 741e je 0x14108c739
0108c71b 418bc4 mov eax, r12d
0108c71e f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108c723 83f801 cmp eax, 1
0108c726 750c jne 0x14108c734
0108c728 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108c72f e8a4f67000 call 0x14179bdd8
0108c734 48897c2448 mov qword ptr [rsp + 0x48], rdi
0108c739 85db test ebx, ebx
0108c73b 752c jne 0x14108c769
0108c73d 448b742474 mov r14d, dword ptr [rsp + 0x74]
0108c742 4c8b6dd8 mov r13, qword ptr [rbp - 0x28]
0108c746 418b7500 mov esi, dword ptr [r13]
0108c74a 8974246c mov dword ptr [rsp + 0x6c], esi
0108c74e 410fb67d04 movzx edi, byte ptr [r13 + 4]
0108c753 41fec7 inc r15b
0108c756 44887c2430 mov byte ptr [rsp + 0x30], r15b
0108c75b 443a7db8 cmp r15b, byte ptr [rbp - 0x48]
0108c75f 0f868bf4ffff jbe 0x14108bbf0
0108c765 488b7590 mov rsi, qword ptr [rbp - 0x70]
0108c769 33db xor ebx, ebx
0108c76b 4c8b7da0 mov r15, qword ptr [rbp - 0x60]
0108c76f 488b45a8 mov rax, qword ptr [rbp - 0x58]
0108c773 813874736c70 cmp dword ptr [rax], 0x706c7374
0108c779 0f85dc000000 jne 0x14108c85b
0108c77f 488b4870 mov rcx, qword ptr [rax + 0x70]
0108c783 4885c9 test rcx, rcx
0108c786 0f848a000000 je 0x14108c816
0108c78c 488b4950 mov rcx, qword ptr [rcx + 0x50]
0108c790 4885c9 test rcx, rcx
0108c793 0f84c2000000 je 0x14108c85b
0108c799 0f1f8000000000 nop dword ptr [rax]
0108c7a0 f6414b01 test byte ptr [rcx + 0x4b], 1
0108c7a4 7473 je 0x14108c819
0108c7a6 488b4150 mov rax, qword ptr [rcx + 0x50]
0108c7aa 4885c0 test rax, rax
0108c7ad 7433 je 0x14108c7e2
0108c7af 488bc8 mov rcx, rax
0108c7b2 ebec jmp 0x14108c7a0
0108c7b4 33c0 xor eax, eax
0108c7b6 4889442420 mov qword ptr [rsp + 0x20], rax
0108c7bb 4533c9 xor r9d, r9d
0108c7be 4533c0 xor r8d, r8d
0108c7c1 33d2 xor edx, edx
0108c7c3 33c9 xor ecx, ecx
0108c7c5 ff1515fd8500 call qword ptr [rip + 0x85fd15]
0108c7cb 90 nop 
0108c7cc c744246094ffffff mov dword ptr [rsp + 0x60], 0xffffff94
0108c7d4 488b7590 mov rsi, qword ptr [rbp - 0x70]
0108c7d8 eb91 jmp 0x14108c76b
0108c7da 488b7590 mov rsi, qword ptr [rbp - 0x70]
0108c7de 33db xor ebx, ebx
0108c7e0 eb8d jmp 0x14108c76f
0108c7e2 488b4110 mov rax, qword ptr [rcx + 0x10]
0108c7e6 4885c0 test rax, rax
0108c7e9 7405 je 0x14108c7f0
0108c7eb 488bc8 mov rcx, rax
0108c7ee ebb0 jmp 0x14108c7a0
0108c7f0 488b4108 mov rax, qword ptr [rcx + 8]
0108c7f4 4885c0 test rax, rax
0108c7f7 741d je 0x14108c816
0108c7f9 488b4810 mov rcx, qword ptr [rax + 0x10]
0108c7fd 4885c9 test rcx, rcx
0108c800 759e jne 0x14108c7a0
0108c802 488b4008 mov rax, qword ptr [rax + 8]
0108c806 4885c0 test rax, rax
0108c809 740b je 0x14108c816
0108c80b 488b4810 mov rcx, qword ptr [rax + 0x10]
0108c80f 4885c9 test rcx, rcx
0108c812 74ee je 0x14108c802
0108c814 eb8a jmp 0x14108c7a0
0108c816 488bcb mov rcx, rbx
0108c819 4885c9 test rcx, rcx
0108c81c 743d je 0x14108c85b
0108c81e 6690 nop 
0108c820 488b01 mov rax, qword ptr [rcx]
0108c823 4885c0 test rax, rax
0108c826 7426 je 0x14108c84e
0108c828 813874736c70 cmp dword ptr [rax], 0x706c7374
0108c82e 751e jne 0x14108c84e
0108c830 83792800 cmp dword ptr [rcx + 0x28], 0
0108c834 7418 je 0x14108c84e
0108c836 488b5130 mov rdx, qword ptr [rcx + 0x30]
0108c83a 4885d2 test rdx, rdx
0108c83d 740f je 0x14108c84e
0108c83f 410fb68770100000 movzx eax, byte ptr [r15 + 0x1070]
0108c847 6689820c010000 mov word ptr [rdx + 0x10c], ax
0108c84e e8fd30e6ff call 0x140eef950
0108c853 488bc8 mov rcx, rax
0108c856 4885c0 test rax, rax
0108c859 75c5 jne 0x14108c820
0108c85b 837c246800 cmp dword ptr [rsp + 0x68], 0
0108c860 7517 jne 0x14108c879
0108c862 c7442460d5ffffff mov dword ptr [rsp + 0x60], 0xffffffd5
0108c86a eb0d jmp 0x14108c879
0108c86c c7442460ceffffff mov dword ptr [rsp + 0x60], 0xffffffce
0108c874 66480f7ef6 movq rsi, xmm6
0108c879 4885f6 test rsi, rsi
0108c87c 741c je 0x14108c89a
0108c87e 418bc4 mov eax, r12d
0108c881 f00fc14608 lock xadd dword ptr [rsi + 8], eax
0108c886 83f801 cmp eax, 1
0108c889 750f jne 0x14108c89a
0108c88b c74608003665c4 mov dword ptr [rsi + 8], 0xc4653600
0108c892 488bce mov rcx, rsi
0108c895 e83ef57000 call 0x14179bdd8
0108c89a 660f73de08 psrldq xmm6, 8
0108c89f 66480f7ef1 movq rcx, xmm6
0108c8a4 4885c9 test rcx, rcx
0108c8a7 7418 je 0x14108c8c1
0108c8a9 f0440fc16108 lock xadd dword ptr [rcx + 8], r12d
0108c8af 4183fc01 cmp r12d, 1
0108c8b3 750c jne 0x14108c8c1
0108c8b5 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108c8bc e817f57000 call 0x14179bdd8
0108c8c1 8b442460 mov eax, dword ptr [rsp + 0x60]
0108c8c5 488b8d40020000 mov rcx, qword ptr [rbp + 0x240]
0108c8cc 4833cc xor rcx, rsp
0108c8cf e80cf07000 call 0x14179b8e0
0108c8d4 488b9c24b0030000 mov rbx, qword ptr [rsp + 0x3b0]
0108c8dc 0f28b42450030000 movaps xmm6, xmmword ptr [rsp + 0x350]
0108c8e4 4881c460030000 add rsp, 0x360
0108c8eb 415f pop r15
0108c8ed 415e pop r14
0108c8ef 415d pop r13
0108c8f1 415c pop r12
0108c8f3 5f pop rdi
0108c8f4 5e pop rsi
0108c8f5 5d pop rbp
0108c8f6 c3 ret 
0108c8f7 e8b4a01eff call 0x1402769b0
0108c8fc 90 nop 