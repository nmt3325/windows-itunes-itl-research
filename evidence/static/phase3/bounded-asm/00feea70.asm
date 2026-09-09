00feea70 4055 push rbp
00feea72 53 push rbx
00feea73 56 push rsi
00feea74 57 push rdi
00feea75 4154 push r12
00feea77 4155 push r13
00feea79 4156 push r14
00feea7b 4157 push r15
00feea7d 488dac24e8fcffff lea rbp, [rsp - 0x318]
00feea85 4881ec18040000 sub rsp, 0x418
00feea8c 488b05ad65fe00 mov rax, qword ptr [rip + 0xfe65ad]
00feea93 4833c4 xor rax, rsp
00feea96 48898500030000 mov qword ptr [rbp + 0x300], rax
00feea9d 4c8be9 mov r13, rcx
00feeaa0 4c89442438 mov qword ptr [rsp + 0x38], r8
00feeaa5 488b4920 mov rcx, qword ptr [rcx + 0x20]
00feeaa9 4533ff xor r15d, r15d
00feeaac 4d8be1 mov r12, r9
00feeaaf 4c897c2428 mov qword ptr [rsp + 0x28], r15
00feeab4 488bf2 mov rsi, rdx
00feeab7 44897c2420 mov dword ptr [rsp + 0x20], r15d
00feeabc 4533c9 xor r9d, r9d
00feeabf 4533c0 xor r8d, r8d
00feeac2 488b4908 mov rcx, qword ptr [rcx + 8]
00feeac6 ba50545448 mov edx, 0x48545450
00feeacb e8b040faff call 0x140f92b80
00feead0 4c8bf0 mov r14, rax
00feead3 4885c0 test rax, rax
00feead6 750a jne 0x140feeae2
00feead8 bf94ffffff mov edi, 0xffffff94
00feeadd e91f060000 jmp 0x140fef101
00feeae2 80889d00000080 or byte ptr [rax + 0x9d], 0x80
00feeae9 80a09a000000fd and byte ptr [rax + 0x9a], 0xfd
00feeaf0 4c8b7858 mov r15, qword ptr [rax + 0x58]
00feeaf4 41c6473d00 mov byte ptr [r15 + 0x3d], 0
00feeaf9 80889d00000040 or byte ptr [rax + 0x9d], 0x40
00feeb00 8b80ac000000 mov eax, dword ptr [rax + 0xac]
00feeb06 85c0 test eax, eax
00feeb08 740e je 0x140feeb18
00feeb0a 0fbaf015 btr eax, 0x15
00feeb0e 83c804 or eax, 4
00feeb11 418986ac000000 mov dword ptr [r14 + 0xac], eax
00feeb18 488b0dc1110e01 mov rcx, qword ptr [rip + 0x10e11c1]
00feeb1f 4885c9 test rcx, rcx
00feeb22 742f je 0x140feeb53
00feeb24 ba08007f00 mov edx, 0x7f0008
00feeb29 ff15c1a28f00 call qword ptr [rip + 0x8fa2c1]
00feeb2f 488bf8 mov rdi, rax
00feeb32 4885c0 test rax, rax
00feeb35 7417 je 0x140feeb4e
00feeb37 488bc8 mov rcx, rax
00feeb3a ff1580a38f00 call qword ptr [rip + 0x8fa380]
00feeb40 488bd8 mov rbx, rax
00feeb43 ff1537a48f00 call qword ptr [rip + 0x8fa437]
00feeb49 483bd8 cmp rbx, rax
00feeb4c 7505 jne 0x140feeb53
00feeb4e 4885ff test rdi, rdi
00feeb51 7507 jne 0x140feeb5a
00feeb53 488b3d9ef00b01 mov rdi, qword ptr [rip + 0x10bf09e]
00feeb5a 33db xor ebx, ebx
00feeb5c 66899d00010000 mov word ptr [rbp + 0x100], bx
00feeb63 4885ff test rdi, rdi
00feeb66 745e je 0x140feebc6
00feeb68 488bcf mov rcx, rdi
00feeb6b 48899de0000000 mov qword ptr [rbp + 0xe0], rbx
00feeb72 ff1518a48f00 call qword ptr [rip + 0x8fa418]
00feeb78 488985e8000000 mov qword ptr [rbp + 0xe8], rax
00feeb7f 4885c0 test rax, rax
00feeb82 743b je 0x140feebbf
00feeb84 b9ff000000 mov ecx, 0xff
00feeb89 0fb7d8 movzx ebx, ax
00feeb8c 483bc1 cmp rax, rcx
00feeb8f 7e09 jle 0x140feeb9a
00feeb91 48898de8000000 mov qword ptr [rbp + 0xe8], rcx
00feeb98 8bd9 mov ebx, ecx
00feeb9a 0f2885e0000000 movaps xmm0, xmmword ptr [rbp + 0xe0]
00feeba1 4c8d8502010000 lea r8, [rbp + 0x102]
00feeba8 488d95e0000000 lea rdx, [rbp + 0xe0]
00feebaf 660f7f85e0000000 movdqa xmmword ptr [rbp + 0xe0], xmm0
00feebb7 488bcf mov rcx, rdi
00feebba e8a135baff call 0x140b92160
00feebbf 66899d00010000 mov word ptr [rbp + 0x100], bx
00feebc6 498bce mov rcx, r14
00feebc9 e83243faff call 0x140f92f00
00feebce 84c0 test al, al
00feebd0 0f841b050000 je 0x140fef0f1
00feebd6 498bcf mov rcx, r15
00feebd9 e87275fbff call 0x140fa6150
00feebde 84c0 test al, al
00feebe0 0f840b050000 je 0x140fef0f1
00feebe6 498b4528 mov rax, qword ptr [r13 + 0x28]
00feebea 4885c0 test rax, rax
00feebed 7433 je 0x140feec22
00feebef 488b08 mov rcx, qword ptr [rax]
00feebf2 4885c9 test rcx, rcx
00feebf5 742b je 0x140feec22
00feebf7 813974736c70 cmp dword ptr [rcx], 0x706c7374
00feebfd 7523 jne 0x140feec22
00feebff 83782800 cmp dword ptr [rax + 0x28], 0
00feec03 741d je 0x140feec22
00feec05 488b4030 mov rax, qword ptr [rax + 0x30]
00feec09 4885c0 test rax, rax
00feec0c 7414 je 0x140feec22
00feec0e 488b4058 mov rax, qword ptr [rax + 0x58]
00feec12 498b4f10 mov rcx, qword ptr [r15 + 0x10]
00feec16 488b4010 mov rax, qword ptr [rax + 0x10]
00feec1a 488b4058 mov rax, qword ptr [rax + 0x58]
00feec1e 48894158 mov qword ptr [rcx + 0x58], rax
00feec22 48c7c3ffffffff mov rbx, 0xffffffffffffffff
00feec29 4c8bc3 mov r8, rbx
00feec2c 0f1f4000 nop dword ptr [rax]
00feec30 49ffc0 inc r8
00feec33 42803c0600 cmp byte ptr [rsi + r8], 0
00feec38 75f6 jne 0x140feec30
00feec3a 488bd6 mov rdx, rsi
00feec3d 498bcf mov rcx, r15
00feec40 e8ebeaedff call 0x140ecd730
00feec45 8bf8 mov edi, eax
00feec47 85c0 test eax, eax
00feec49 0f85a7040000 jne 0x140fef0f6
00feec4f 90 nop 
00feec50 48ffc3 inc rbx
00feec53 803c1e00 cmp byte ptr [rsi + rbx], 0
00feec57 75f7 jne 0x140feec50
00feec59 448bc3 mov r8d, ebx
00feec5c 488bd6 mov rdx, rsi
00feec5f 498bce mov rcx, r14
00feec62 e8e905fbff call 0x140f9f250
00feec67 8bf8 mov edi, eax
00feec69 85c0 test eax, eax
00feec6b 0f8585040000 jne 0x140fef0f6
00feec71 32db xor bl, bl
00feec73 488d542440 lea rdx, [rsp + 0x40]
00feec78 488bce mov rcx, rsi
00feec7b 889de0000000 mov byte ptr [rbp + 0xe0], bl
00feec81 e88ab4b0ff call 0x140afa110
00feec86 488b55a0 mov rdx, qword ptr [rbp - 0x60]
00feec8a 4885d2 test rdx, rdx
00feec8d 742b je 0x140feecba
00feec8f 8b4da8 mov ecx, dword ptr [rbp - 0x58]
00feec92 8d41ff lea eax, [rcx - 1]
00feec95 83f81e cmp eax, 0x1e
00feec98 7720 ja 0x140feecba
00feec9a 8bd9 mov ebx, ecx
00feec9c 448bc1 mov r8d, ecx
00feec9f 488d8de0000000 lea rcx, [rbp + 0xe0]
00feeca6 e8efdf7a00 call 0x14179cc9a
00feecab 4088bc1de0000000 mov byte ptr [rbp + rbx + 0xe0], dil
00feecb3 0fb69de0000000 movzx ebx, byte ptr [rbp + 0xe0]
00feecba 4533ff xor r15d, r15d
00feecbd 488d3d3c1301ff lea rdi, [rip - 0xfeecc4]
00feecc4 458bcf mov r9d, r15d
00feecc7 41b070 mov r8b, 0x70
00feecca 0fb6d3 movzx edx, bl
00feeccd 0f1f00 nop dword ptr [rax]
00feecd0 4d8bd9 mov r11, r9
00feecd3 84d2 test dl, dl
00feecd5 7440 je 0x140feed17
00feecd7 418d40e0 lea eax, [r8 - 0x20]
00feecdb 440fb6d0 movzx r10d, al
00feecdf 418d489f lea ecx, [r8 - 0x61]
00feece3 80f919 cmp cl, 0x19
00feece6 410fb6c0 movzx eax, r8b
00feecea 440f47d0 cmova r10d, eax
00feecee 8d429f lea eax, [rdx - 0x61]
00feecf1 3c19 cmp al, 0x19
00feecf3 7703 ja 0x140feecf8
00feecf5 80c2e0 add dl, 0xe0
00feecf8 443ad2 cmp r10b, dl
00feecfb 7526 jne 0x140feed23
00feecfd 450fb684398123ab01 movzx r8d, byte ptr [r9 + rdi + 0x1ab2381]
00feed06 49ffc1 inc r9
00feed09 420fb6941de1000000 movzx edx, byte ptr [rbp + r11 + 0xe1]
00feed12 4584c0 test r8b, r8b
00feed15 75b9 jne 0x140feecd0
00feed17 443ac2 cmp r8b, dl
00feed1a 7507 jne 0x140feed23
00feed1c b800008000 mov eax, 0x800000
00feed21 eb17 jmp 0x140feed3a
00feed23 488bce mov rcx, rsi
00feed26 e885ec0000 call 0x140ffd9b0
00feed2b 84c0 test al, al
00feed2d 7415 je 0x140feed44
00feed2f 418b86ac000000 mov eax, dword ptr [r14 + 0xac]
00feed36 0fbae810 bts eax, 0x10
00feed3a 83c804 or eax, 4
00feed3d 418986ac000000 mov dword ptr [r14 + 0xac], eax
00feed44 41b06d mov r8b, 0x6d
00feed47 0fb6d3 movzx edx, bl
00feed4a 4d8bcf mov r9, r15
00feed4d 0f1f00 nop dword ptr [rax]
00feed50 4d8bd9 mov r11, r9
00feed53 84d2 test dl, dl
00feed55 7440 je 0x140feed97
00feed57 418d40e0 lea eax, [r8 - 0x20]
00feed5b 440fb6d0 movzx r10d, al
00feed5f 418d489f lea ecx, [r8 - 0x61]
00feed63 80f919 cmp cl, 0x19
00feed66 410fb6c0 movzx eax, r8b
00feed6a 440f47d0 cmova r10d, eax
00feed6e 8d429f lea eax, [rdx - 0x61]
00feed71 3c19 cmp al, 0x19
00feed73 7703 ja 0x140feed78
00feed75 80c2e0 add dl, 0xe0
00feed78 443ad2 cmp r10b, dl
00feed7b 7523 jne 0x140feeda0
00feed7d 450fb6843925ecb101 movzx r8d, byte ptr [r9 + rdi + 0x1b1ec25]
00feed86 49ffc1 inc r9
00feed89 420fb6941de1000000 movzx edx, byte ptr [rbp + r11 + 0xe1]
00feed92 4584c0 test r8b, r8b
00feed95 75b9 jne 0x140feed50
00feed97 443ac2 cmp r8b, dl
00feed9a 0f84b7000000 je 0x140feee57
00feeda0 41b06d mov r8b, 0x6d
00feeda3 0fb6d3 movzx edx, bl
00feeda6 4d8bcf mov r9, r15
00feeda9 0f1f8000000000 nop dword ptr [rax]
00feedb0 4d8bd9 mov r11, r9
00feedb3 84d2 test dl, dl
00feedb5 7440 je 0x140feedf7
00feedb7 418d40e0 lea eax, [r8 - 0x20]
00feedbb 440fb6d0 movzx r10d, al
00feedbf 418d489f lea ecx, [r8 - 0x61]
00feedc3 80f919 cmp cl, 0x19
00feedc6 410fb6c0 movzx eax, r8b
00feedca 440f47d0 cmova r10d, eax
00feedce 8d429f lea eax, [rdx - 0x61]
00feedd1 3c19 cmp al, 0x19
00feedd3 7703 ja 0x140feedd8
00feedd5 80c2e0 add dl, 0xe0
00feedd8 443ad2 cmp r10b, dl
00feeddb 751f jne 0x140feedfc
00feeddd 450fb68439fdebb101 movzx r8d, byte ptr [r9 + rdi + 0x1b1ebfd]
00feede6 49ffc1 inc r9
00feede9 420fb6941de1000000 movzx edx, byte ptr [rbp + r11 + 0xe1]
00feedf2 4584c0 test r8b, r8b
00feedf5 75b9 jne 0x140feedb0
00feedf7 443ac2 cmp r8b, dl
00feedfa 745b je 0x140feee57
00feedfc 488b057519aa00 mov rax, qword ptr [rip + 0xaa1975]
00feee03 84c0 test al, al
00feee05 744c je 0x140feee53
00feee07 4d8bc7 mov r8, r15
00feee0a 660f1f440000 nop word ptr [rax + rax]
00feee10 4d8bd0 mov r10, r8
00feee13 84db test bl, bl
00feee15 743c je 0x140feee53
00feee17 8d48e0 lea ecx, [rax - 0x20]
00feee1a 8d509f lea edx, [rax - 0x61]
00feee1d 440fb6c9 movzx r9d, cl
00feee21 80fa19 cmp dl, 0x19
00feee24 0fb6c8 movzx ecx, al
00feee27 8d439f lea eax, [rbx - 0x61]
00feee2a 440f47c9 cmova r9d, ecx
00feee2e 3c19 cmp al, 0x19
00feee30 7703 ja 0x140feee35
00feee32 80c3e0 add bl, 0xe0
00feee35 443acb cmp r9b, bl
00feee38 7525 jne 0x140feee5f
00feee3a 410fb684387907a901 movzx eax, byte ptr [r8 + rdi + 0x1a90779]
00feee43 49ffc0 inc r8
00feee46 420fb69c15e1000000 movzx ebx, byte ptr [rbp + r10 + 0xe1]
00feee4f 84c0 test al, al
00feee51 75bd jne 0x140feee10
00feee53 3ac3 cmp al, bl
00feee55 7508 jne 0x140feee5f
00feee57 41808e9c00000002 or byte ptr [r14 + 0x9c], 2
00feee5f 458b4540 mov r8d, dword ptr [r13 + 0x40]
00feee63 498bce mov rcx, r14
00feee66 498b5538 mov rdx, qword ptr [r13 + 0x38]
00feee6a e8d1fefaff call 0x140f9ed40
00feee6f 8bf8 mov edi, eax
00feee71 85c0 test eax, eax
00feee73 0f8580020000 jne 0x140fef0f9
00feee79 498b4528 mov rax, qword ptr [r13 + 0x28]
00feee7d 4885c0 test rax, rax
00feee80 7469 je 0x140feeeeb
00feee82 488b08 mov rcx, qword ptr [rax]
00feee85 4885c9 test rcx, rcx
00feee88 7461 je 0x140feeeeb
00feee8a 813974736c70 cmp dword ptr [rcx], 0x706c7374
00feee90 7559 jne 0x140feeeeb
00feee92 44397828 cmp dword ptr [rax + 0x28], r15d
00feee96 7453 je 0x140feeeeb
00feee98 f6404b01 test byte ptr [rax + 0x4b], 1
00feee9c 7418 je 0x140feeeb6
00feee9e 8b5068 mov edx, dword ptr [rax + 0x68]
00feeea1 4c8d8500010000 lea r8, [rbp + 0x100]
00feeea8 4881c130010000 add rcx, 0x130
00feeeaf e8bc05c1ff call 0x140bff470
00feeeb4 eb3d jmp 0x140feeef3
00feeeb6 488b5030 mov rdx, qword ptr [rax + 0x30]
00feeeba 664489bd00010000 mov word ptr [rbp + 0x100], r15w
00feeec2 4885d2 test rdx, rdx
00feeec5 742c je 0x140feeef3
00feeec7 488b4a10 mov rcx, qword ptr [rdx + 0x10]
00feeecb 4885c9 test rcx, rcx
00feeece 7423 je 0x140feeef3
00feeed0 8b92b0000000 mov edx, dword ptr [rdx + 0xb0]
00feeed6 4c8d8500010000 lea r8, [rbp + 0x100]
00feeedd 4881c178010000 add rcx, 0x178
00feeee4 e88705c1ff call 0x140bff470
00feeee9 eb08 jmp 0x140feeef3
00feeeeb 664489bd00010000 mov word ptr [rbp + 0x100], r15w
00feeef3 4d397e10 cmp qword ptr [r14 + 0x10], r15
00feeef7 0f84ad000000 je 0x140feefaa
00feeefd 498b4628 mov rax, qword ptr [r14 + 0x28]
00feef01 4885c0 test rax, rax
00feef04 7404 je 0x140feef0a
00feef06 806075fe and byte ptr [rax + 0x75], 0xfe
00feef0a 498b4e10 mov rcx, qword ptr [r14 + 0x10]
00feef0e 4d8d8ebc000000 lea r9, [r14 + 0xbc]
00feef15 4881c1c0010000 add rcx, 0x1c0
00feef1c b8ff000000 mov eax, 0xff
00feef21 66398500010000 cmp word ptr [rbp + 0x100], ax
00feef28 7605 jbe 0x140feef2f
00feef2a 458939 mov dword ptr [r9], r15d
00feef2d eb71 jmp 0x140feefa0
00feef2f 440fb79500010000 movzx r10d, word ptr [rbp + 0x100]
00feef37 4503d2 add r10d, r10d
00feef3a 4885c9 test rcx, rcx
00feef3d 7461 je 0x140feefa0
00feef3f 813963727473 cmp dword ptr [rcx], 0x73747263
00feef45 7559 jne 0x140feefa0
00feef47 44397928 cmp dword ptr [rcx + 0x28], r15d
00feef4b 7553 jne 0x140feefa0
00feef4d 496301 movsxd rax, dword ptr [r9]
00feef50 4439793c cmp dword ptr [rcx + 0x3c], r15d
00feef54 754a jne 0x140feefa0
00feef56 85c0 test eax, eax
00feef58 7437 je 0x140feef91
00feef5a 7e44 jle 0x140feefa0
00feef5c 3b412c cmp eax, dword ptr [rcx + 0x2c]
00feef5f 7f3f jg 0x140feefa0
00feef61 f6410401 test byte ptr [rcx + 4], 1
00feef65 4c8bc0 mov r8, rax
00feef68 740f je 0x140feef79
00feef6a 488b4118 mov rax, qword ptr [rcx + 0x18]
00feef6e 488b00 mov rax, qword ptr [rax]
00feef71 42836c80fc01 sub dword ptr [rax + r8*4 - 4], 1
00feef77 7518 jne 0x140feef91
00feef79 488b4110 mov rax, qword ptr [rcx + 0x10]
00feef7d 488b10 mov rdx, qword ptr [rax]
00feef80 428b44c2fc mov eax, dword ptr [rdx + r8*8 - 4]
00feef85 014140 add dword ptr [rcx + 0x40], eax
00feef88 42c744c2f801000080 mov dword ptr [rdx + r8*8 - 8], 0x80000001
00feef91 458bc2 mov r8d, r10d
00feef94 488d9502010000 lea rdx, [rbp + 0x102]
00feef9b e850f2c0ff call 0x140bfe1f0
00feefa0 33d2 xor edx, edx
00feefa2 498bce mov rcx, r14
00feefa5 e8f68dedff call 0x140ec7da0
00feefaa 0f57c0 xorps xmm0, xmm0
00feefad 4c8d85c0000000 lea r8, [rbp + 0xc0]
00feefb4 0f1185c0000000 movups xmmword ptr [rbp + 0xc0], xmm0
00feefbb 808dc900000001 or byte ptr [rbp + 0xc9], 1
00feefc2 33d2 xor edx, edx
00feefc4 498bce mov rcx, r14
00feefc7 c685c000000010 mov byte ptr [rbp + 0xc0], 0x10
00feefce 0f1185d0000000 movups xmmword ptr [rbp + 0xd0], xmm0
00feefd5 e8a651faff call 0x140f94180
00feefda 488b0dff0c0e01 mov rcx, qword ptr [rip + 0x10e0cff]
00feefe1 4885c9 test rcx, rcx
00feefe4 742f je 0x140fef015
00feefe6 ba08007f00 mov edx, 0x7f0008
00feefeb ff15ff9d8f00 call qword ptr [rip + 0x8f9dff]
00feeff1 488bf0 mov rsi, rax
00feeff4 4885c0 test rax, rax
00feeff7 7417 je 0x140fef010
00feeff9 488bc8 mov rcx, rax
00feeffc ff15be9e8f00 call qword ptr [rip + 0x8f9ebe]
00fef002 488bd8 mov rbx, rax
00fef005 ff15759f8f00 call qword ptr [rip + 0x8f9f75]
00fef00b 483bd8 cmp rbx, rax
00fef00e 7505 jne 0x140fef015
00fef010 4885f6 test rsi, rsi
00fef013 7507 jne 0x140fef01c
00fef015 488b35dceb0b01 mov rsi, qword ptr [rip + 0x10bebdc]
00fef01c 664489bd00010000 mov word ptr [rbp + 0x100], r15w
00fef024 4885f6 test rsi, rsi
00fef027 7462 je 0x140fef08b
00fef029 488bce mov rcx, rsi
00fef02c 4c89bde0000000 mov qword ptr [rbp + 0xe0], r15
00fef033 ff15579f8f00 call qword ptr [rip + 0x8f9f57]
00fef039 488985e8000000 mov qword ptr [rbp + 0xe8], rax
00fef040 410fb7df movzx ebx, r15w
00fef044 4885c0 test rax, rax
00fef047 743b je 0x140fef084
00fef049 b9ff000000 mov ecx, 0xff
00fef04e 0fb7d8 movzx ebx, ax
00fef051 483bc1 cmp rax, rcx
00fef054 7e09 jle 0x140fef05f
00fef056 48898de8000000 mov qword ptr [rbp + 0xe8], rcx
00fef05d 8bd9 mov ebx, ecx
00fef05f 0f2885e0000000 movaps xmm0, xmmword ptr [rbp + 0xe0]
00fef066 4c8d8502010000 lea r8, [rbp + 0x102]
00fef06d 488d95e0000000 lea rdx, [rbp + 0xe0]
00fef074 660f7f85e0000000 movdqa xmmword ptr [rbp + 0xe0], xmm0
00fef07c 488bce mov rcx, rsi
00fef07f e8dc30baff call 0x140b92160
00fef084 66899d00010000 mov word ptr [rbp + 0x100], bx
00fef08b 41b001 mov r8b, 1
00fef08e 488d9500010000 lea rdx, [rbp + 0x100]
00fef095 498bce mov rcx, r14
00fef098 e8b3defaff call 0x140f9cf50
00fef09d 488b442438 mov rax, qword ptr [rsp + 0x38]
00fef0a2 4885c0 test rax, rax
00fef0a5 7415 je 0x140fef0bc
00fef0a7 488b151a060c01 mov rdx, qword ptr [rip + 0x10c061a]
00fef0ae 4533c9 xor r9d, r9d
00fef0b1 4c8bc0 mov r8, rax
00fef0b4 498bce mov rcx, r14
00fef0b7 e8042bfbff call 0x140fa1bc0
00fef0bc 33d2 xor edx, edx
00fef0be 498bce mov rcx, r14
00fef0c1 e81a4afaff call 0x140f93ae0
00fef0c6 498b4520 mov rax, qword ptr [r13 + 0x20]
00fef0ca 4533c9 xor r9d, r9d
00fef0cd 4d8bc6 mov r8, r14
00fef0d0 4c897c2420 mov qword ptr [rsp + 0x20], r15
00fef0d5 ba69727461 mov edx, 0x61747269
00fef0da 488b4808 mov rcx, qword ptr [rax + 8]
00fef0de 488b01 mov rax, qword ptr [rcx]
00fef0e1 ff5008 call qword ptr [rax + 8]
00fef0e4 8bc7 mov eax, edi
00fef0e6 4d85e4 test r12, r12
00fef0e9 7421 je 0x140fef10c
00fef0eb 4d893424 mov qword ptr [r12], r14
00fef0ef eb1b jmp 0x140fef10c
00fef0f1 bf94ffffff mov edi, 0xffffff94
00fef0f6 4533ff xor r15d, r15d
00fef0f9 498bce mov rcx, r14
00fef0fc e86f3dfaff call 0x140f92e70
00fef101 8bc7 mov eax, edi
00fef103 4d85e4 test r12, r12
00fef106 7404 je 0x140fef10c
00fef108 4d893c24 mov qword ptr [r12], r15
00fef10c 488b8d00030000 mov rcx, qword ptr [rbp + 0x300]
00fef113 4833cc xor rcx, rsp
00fef116 e8c5c77a00 call 0x14179b8e0
00fef11b 4881c418040000 add rsp, 0x418
00fef122 415f pop r15
00fef124 415e pop r14
00fef126 415d pop r13
00fef128 415c pop r12
00fef12a 5f pop rdi
00fef12b 5e pop rsi
00fef12c 5b pop rbx
00fef12d 5d pop rbp
00fef12e c3 ret 