010234b0 488bc4 mov rax, rsp
010234b3 55 push rbp
010234b4 53 push rbx
010234b5 56 push rsi
010234b6 57 push rdi
010234b7 4154 push r12
010234b9 4155 push r13
010234bb 4156 push r14
010234bd 4157 push r15
010234bf 488da888feffff lea rbp, [rax - 0x178]
010234c6 4881ec38020000 sub rsp, 0x238
010234cd 0f2970a8 movaps xmmword ptr [rax - 0x58], xmm6
010234d1 0f297898 movaps xmmword ptr [rax - 0x68], xmm7
010234d5 440f294088 movaps xmmword ptr [rax - 0x78], xmm8
010234da 4c894c2470 mov qword ptr [rsp + 0x70], r9
010234df 4c8945a8 mov qword ptr [rbp - 0x58], r8
010234e3 488955e8 mov qword ptr [rbp - 0x18], rdx
010234e7 488bd1 mov rdx, rcx
010234ea 48894db0 mov qword ptr [rbp - 0x50], rcx
010234ee 4c8bada0010000 mov r13, qword ptr [rbp + 0x1a0]
010234f5 4c896c2468 mov qword ptr [rsp + 0x68], r13
010234fa 4c8bb5b0010000 mov r14, qword ptr [rbp + 0x1b0]
01023501 4c89742448 mov qword ptr [rsp + 0x48], r14
01023506 4c8975a0 mov qword ptr [rbp - 0x60], r14
0102350a 48b8abaaaaaaaaaaaaaa movabs rax, 0xaaaaaaaaaaaaaaab
01023514 4533e4 xor r12d, r12d
01023517 4d85c0 test r8, r8
0102351a 7421 je 0x14102353d
0102351c 41813854534c4f cmp dword ptr [r8], 0x4f4c5354
01023523 7518 jne 0x14102353d
01023525 45396004 cmp dword ptr [r8 + 4], r12d
01023529 7412 je 0x14102353d
0102352b 498b7010 mov rsi, qword ptr [r8 + 0x10]
0102352f 492b7008 sub rsi, qword ptr [r8 + 8]
01023533 48c1fe04 sar rsi, 4
01023537 480faff0 imul rsi, rax
0102353b eb03 jmp 0x141023540
0102353d 418bf4 mov esi, r12d
01023540 41bfffffffff mov r15d, 0xffffffff
01023546 4439bda8010000 cmp dword ptr [rbp + 0x1a8], r15d
0102354d 0f84fd010000 je 0x141023750
01023553 80bdb801000000 cmp byte ptr [rbp + 0x1b8], 0
0102355a 0f84f0010000 je 0x141023750
01023560 b930000000 mov ecx, 0x30
01023565 ff153d848c00 call qword ptr [rip + 0x8c843d]
0102356b 488b0d6ec70a01 mov rcx, qword ptr [rip + 0x10ac76e]
01023572 4885c9 test rcx, rcx
01023575 742f je 0x1410235a6
01023577 ba0400b35d mov edx, 0x5db30004
0102357c ff156e588c00 call qword ptr [rip + 0x8c586e]
01023582 488bf8 mov rdi, rax
01023585 4885c0 test rax, rax
01023588 7417 je 0x1410235a1
0102358a 488bc8 mov rcx, rax
0102358d ff152d598c00 call qword ptr [rip + 0x8c592d]
01023593 488bd8 mov rbx, rax
01023596 ff15e4598c00 call qword ptr [rip + 0x8c59e4]
0102359c 483bd8 cmp rbx, rax
0102359f 7505 jne 0x1410235a6
010235a1 4885ff test rdi, rdi
010235a4 7507 jne 0x1410235ad
010235a6 488b3d4ba60801 mov rdi, qword ptr [rip + 0x108a64b]
010235ad 488bd7 mov rdx, rdi
010235b0 488d4dc8 lea rcx, [rbp - 0x38]
010235b4 e8272dabff call 0x140ad62e0
010235b9 90 nop 
010235ba 488b0d1fc70a01 mov rcx, qword ptr [rip + 0x10ac71f]
010235c1 4885c9 test rcx, rcx
010235c4 742f je 0x1410235f5
010235c6 ba0100b35d mov edx, 0x5db30001
010235cb ff151f588c00 call qword ptr [rip + 0x8c581f]
010235d1 488bf8 mov rdi, rax
010235d4 4885c0 test rax, rax
010235d7 7417 je 0x1410235f0
010235d9 488bc8 mov rcx, rax
010235dc ff15de588c00 call qword ptr [rip + 0x8c58de]
010235e2 488bd8 mov rbx, rax
010235e5 ff1595598c00 call qword ptr [rip + 0x8c5995]
010235eb 483bd8 cmp rbx, rax
010235ee 7505 jne 0x1410235f5
010235f0 4885ff test rdi, rdi
010235f3 7507 jne 0x1410235fc
010235f5 488b3dfca50801 mov rdi, qword ptr [rip + 0x108a5fc]
010235fc 488bd7 mov rdx, rdi
010235ff 488d4dd8 lea rcx, [rbp - 0x28]
01023603 e8d82cabff call 0x140ad62e0
01023608 90 nop 
01023609 488b0dd0c60a01 mov rcx, qword ptr [rip + 0x10ac6d0]
01023610 4885c9 test rcx, rcx
01023613 742f je 0x141023644
01023615 ba0e003023 mov edx, 0x2330000e
0102361a ff15d0578c00 call qword ptr [rip + 0x8c57d0]
01023620 488bf8 mov rdi, rax
01023623 4885c0 test rax, rax
01023626 7417 je 0x14102363f
01023628 488bc8 mov rcx, rax
0102362b ff158f588c00 call qword ptr [rip + 0x8c588f]
01023631 488bd8 mov rbx, rax
01023634 ff1546598c00 call qword ptr [rip + 0x8c5946]
0102363a 483bd8 cmp rbx, rax
0102363d 7505 jne 0x141023644
0102363f 4885ff test rdi, rdi
01023642 7507 jne 0x14102364b
01023644 488b3dada50801 mov rdi, qword ptr [rip + 0x108a5ad]
0102364b 488bd7 mov rdx, rdi
0102364e 488d4d88 lea rcx, [rbp - 0x78]
01023652 e8892cabff call 0x140ad62e0
01023657 90 nop 
01023658 4533c9 xor r9d, r9d
0102365b 4c8d45c8 lea r8, [rbp - 0x38]
0102365f 488d55d8 lea rdx, [rbp - 0x28]
01023663 488d4d88 lea rcx, [rbp - 0x78]
01023667 e884ceadff call 0x140b004f0
0102366c 0fb7d8 movzx ebx, ax
0102366f 488b4d88 mov rcx, qword ptr [rbp - 0x78]
01023673 4885c9 test rcx, rcx
01023676 7419 je 0x141023691
01023678 418bd7 mov edx, r15d
0102367b f00fc15108 lock xadd dword ptr [rcx + 8], edx
01023680 83fa01 cmp edx, 1
01023683 750c jne 0x141023691
01023685 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0102368c e847877700 call 0x14179bdd8
01023691 488b4d90 mov rcx, qword ptr [rbp - 0x70]
01023695 4885c9 test rcx, rcx
01023698 741a je 0x1410236b4
0102369a 418bc7 mov eax, r15d
0102369d f00fc14108 lock xadd dword ptr [rcx + 8], eax
010236a2 83f801 cmp eax, 1
010236a5 750d jne 0x1410236b4
010236a7 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
010236ae e825877700 call 0x14179bdd8
010236b3 90 nop 
010236b4 488b4dd8 mov rcx, qword ptr [rbp - 0x28]
010236b8 4885c9 test rcx, rcx
010236bb 7419 je 0x1410236d6
010236bd 418bc7 mov eax, r15d
010236c0 f00fc14108 lock xadd dword ptr [rcx + 8], eax
010236c5 83f801 cmp eax, 1
010236c8 750c jne 0x1410236d6
010236ca c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
010236d1 e802877700 call 0x14179bdd8
010236d6 488b4de0 mov rcx, qword ptr [rbp - 0x20]
010236da 4885c9 test rcx, rcx
010236dd 741a je 0x1410236f9
010236df 418bc7 mov eax, r15d
010236e2 f00fc14108 lock xadd dword ptr [rcx + 8], eax
010236e7 83f801 cmp eax, 1
010236ea 750d jne 0x1410236f9
010236ec c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
010236f3 e8e0867700 call 0x14179bdd8
010236f8 90 nop 
010236f9 488b4dc8 mov rcx, qword ptr [rbp - 0x38]
010236fd 4885c9 test rcx, rcx
01023700 7419 je 0x14102371b
01023702 418bc7 mov eax, r15d
01023705 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102370a 83f801 cmp eax, 1
0102370d 750c jne 0x14102371b
0102370f c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01023716 e8bd867700 call 0x14179bdd8
0102371b 488b4dd0 mov rcx, qword ptr [rbp - 0x30]
0102371f 4885c9 test rcx, rcx
01023722 7419 je 0x14102373d
01023724 418bc7 mov eax, r15d
01023727 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102372c 83f801 cmp eax, 1
0102372f 750c jne 0x14102373d
01023731 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01023738 e89b867700 call 0x14179bdd8
0102373d 6683fb65 cmp bx, 0x65
01023741 0f85320e0000 jne 0x141024579
01023747 4c8b4c2470 mov r9, qword ptr [rsp + 0x70]
0102374c 488b55b0 mov rdx, qword ptr [rbp - 0x50]
01023750 0f57ff xorps xmm7, xmm7
01023753 c644244000 mov byte ptr [rsp + 0x40], 0
01023758 c644244300 mov byte ptr [rsp + 0x43], 0
0102375d c644244100 mov byte ptr [rsp + 0x41], 0
01023762 c644244400 mov byte ptr [rsp + 0x44], 0
01023767 c644244200 mov byte ptr [rsp + 0x42], 0
0102376c c644244500 mov byte ptr [rsp + 0x45], 0
01023771 c644244600 mov byte ptr [rsp + 0x46], 0
01023776 4489642454 mov dword ptr [rsp + 0x54], r12d
0102377b 418b01 mov eax, dword ptr [r9]
0102377e 41b8ffff0000 mov r8d, 0xffff
01023784 a840 test al, 0x40
01023786 7420 je 0x1410237a8
01023788 45398108100000 cmp dword ptr [r9 + 0x1008], r8d
0102378f 0f94c1 sete cl
01023792 884c2440 mov byte ptr [rsp + 0x40], cl
01023796 4539810c100000 cmp dword ptr [r9 + 0x100c], r8d
0102379d 7509 jne 0x1410237a8
0102379f c644244301 mov byte ptr [rsp + 0x43], 1
010237a4 884c2440 mov byte ptr [rsp + 0x40], cl
010237a8 0fbae017 bt eax, 0x17
010237ac 7322 jae 0x1410237d0
010237ae 6645398144120000 cmp word ptr [r9 + 0x1244], r8w
010237b6 0f94c1 sete cl
010237b9 884c2441 mov byte ptr [rsp + 0x41], cl
010237bd 6645398146120000 cmp word ptr [r9 + 0x1246], r8w
010237c5 7509 jne 0x1410237d0
010237c7 c644244401 mov byte ptr [rsp + 0x44], 1
010237cc 884c2441 mov byte ptr [rsp + 0x41], cl
010237d0 418b4508 mov eax, dword ptr [r13 + 8]
010237d4 480fbae00c bt rax, 0xc
010237d9 7322 jae 0x1410237fd
010237db 664539852c320000 cmp word ptr [r13 + 0x322c], r8w
010237e3 0f94c1 sete cl
010237e6 884c2442 mov byte ptr [rsp + 0x42], cl
010237ea 664539852e320000 cmp word ptr [r13 + 0x322e], r8w
010237f2 7509 jne 0x1410237fd
010237f4 c644244501 mov byte ptr [rsp + 0x45], 1
010237f9 884c2442 mov byte ptr [rsp + 0x42], cl
010237fd 48b80000000040000000 movabs rax, 0x4000000000
01023807 49854500 test qword ptr [r13], rax
0102380b 7419 je 0x141023826
0102380d c644244601 mov byte ptr [rsp + 0x46], 1
01023812 418b4520 mov eax, dword ptr [r13 + 0x20]
01023816 89442454 mov dword ptr [rsp + 0x54], eax
0102381a 85c0 test eax, eax
0102381c 7508 jne 0x141023826
0102381e 418b451c mov eax, dword ptr [r13 + 0x1c]
01023822 89442454 mov dword ptr [rsp + 0x54], eax
01023826 32c0 xor al, al
01023828 89442450 mov dword ptr [rsp + 0x50], eax
0102382c 488b4208 mov rax, qword ptr [rdx + 8]
01023830 4885c0 test rax, rax
01023833 7412 je 0x141023847
01023835 81b88000000074616474 cmp dword ptr [rax + 0x80], 0x74646174
0102383f 7506 jne 0x141023847
01023841 ff8080200000 inc dword ptr [rax + 0x2080]
01023847 488b0d92c40a01 mov rcx, qword ptr [rip + 0x10ac492]
0102384e 4885c9 test rcx, rcx
01023851 742f je 0x141023882
01023853 ba0b008200 mov edx, 0x82000b
01023858 ff1592558c00 call qword ptr [rip + 0x8c5592]
0102385e 488bf8 mov rdi, rax
01023861 4885c0 test rax, rax
01023864 7417 je 0x14102387d
01023866 488bc8 mov rcx, rax
01023869 ff1551568c00 call qword ptr [rip + 0x8c5651]
0102386f 488bd8 mov rbx, rax
01023872 ff1508578c00 call qword ptr [rip + 0x8c5708]
01023878 483bd8 cmp rbx, rax
0102387b 7505 jne 0x141023882
0102387d 4885ff test rdi, rdi
01023880 7507 jne 0x141023889
01023882 488b3d6fa30801 mov rdi, qword ptr [rip + 0x108a36f]
01023889 488bd7 mov rdx, rdi
0102388c 488d4df0 lea rcx, [rbp - 0x10]
01023890 e84b2aabff call 0x140ad62e0
01023895 90 nop 
01023896 4863fe movsxd rdi, esi
01023899 48897dd8 mov qword ptr [rbp - 0x28], rdi
0102389d 4533c9 xor r9d, r9d
010238a0 f20f101588fdc400 movsd xmm2, qword ptr [rip + 0xc4fd88]
010238a8 488bd7 mov rdx, rdi
010238ab 488d4df0 lea rcx, [rbp - 0x10]
010238af e85cd2b4ff call 0x140b70b10
010238b4 488bd8 mov rbx, rax
010238b7 4889442478 mov qword ptr [rsp + 0x78], rax
010238bc 458bec mov r13d, r12d
010238bf 448964245c mov dword ptr [rsp + 0x5c], r12d
010238c4 ba01000000 mov edx, 1
010238c9 85f6 test esi, esi
010238cb 0f8eed0b0000 jle 0x1410244be
010238d1 498bfc mov rdi, r12
010238d4 4c896598 mov qword ptr [rbp - 0x68], r12
010238d8 f2440f10054ffac400 movsd xmm8, qword ptr [rip + 0xc4fa4f]
010238e1 4c8b75a8 mov r14, qword ptr [rbp - 0x58]
010238e5 6666660f1f840000000000 nop word ptr [rax + rax]
010238f0 4489642458 mov dword ptr [rsp + 0x58], r12d
010238f5 4c896588 mov qword ptr [rbp - 0x78], r12
010238f9 4c896590 mov qword ptr [rbp - 0x70], r12
010238fd 4533c0 xor r8d, r8d
01023900 418bd5 mov edx, r13d
01023903 498bce mov rcx, r14
01023906 e8b5a02bff call 0x1402dd9c0
0102390b 488bf0 mov rsi, rax
0102390e 488945b8 mov qword ptr [rbp - 0x48], rax
01023912 4885c0 test rax, rax
01023915 7439 je 0x141023950
01023917 488b08 mov rcx, qword ptr [rax]
0102391a 4885c9 test rcx, rcx
0102391d 0f84370b0000 je 0x14102445a
01023923 813974736c70 cmp dword ptr [rcx], 0x706c7374
01023929 0f852b0b0000 jne 0x14102445a
0102392f 83782800 cmp dword ptr [rax + 0x28], 0
01023933 0f84210b0000 je 0x14102445a
01023939 488b4830 mov rcx, qword ptr [rax + 0x30]
0102393d 4885c9 test rcx, rcx
01023940 0f84140b0000 je 0x14102445a
01023946 e8f52136ff call 0x140385b40
0102394b e9df000000 jmp 0x141023a2f
01023950 4d85f6 test r14, r14
01023953 0f84010b0000 je 0x14102445a
01023959 41813e54534c4f cmp dword ptr [r14], 0x4f4c5354
01023960 0f85f40a0000 jne 0x14102445a
01023966 41837e0400 cmp dword ptr [r14 + 4], 0
0102396b 0f84e90a0000 je 0x14102445a
01023971 498b5608 mov rdx, qword ptr [r14 + 8]
01023975 498b4e10 mov rcx, qword ptr [r14 + 0x10]
01023979 482bca sub rcx, rdx
0102397c 48c1f904 sar rcx, 4
01023980 48b8abaaaaaaaaaaaaaa movabs rax, 0xaaaaaaaaaaaaaaab
0102398a 480fafc8 imul rcx, rax
0102398e 418bc5 mov eax, r13d
01023991 483bc1 cmp rax, rcx
01023994 0f83c00a0000 jae 0x14102445a
0102399a 488d047f lea rax, [rdi + rdi*2]
0102399e 4803c0 add rax, rax
010239a1 0f1034c2 movups xmm6, xmmword ptr [rdx + rax*8]
010239a5 498bfc mov rdi, r12
010239a8 66480f7ef3 movq rbx, xmm6
010239ad 488bc3 mov rax, rbx
010239b0 48c1e820 shr rax, 0x20
010239b4 85c0 test eax, eax
010239b6 7461 je 0x141023a19
010239b8 85db test ebx, ebx
010239ba 745d je 0x141023a19
010239bc ff150e6e8c00 call qword ptr [rip + 0x8c6e0e]
010239c2 8bc8 mov ecx, eax
010239c4 e817c7baff call 0x140bd00e0
010239c9 84c0 test al, al
010239cb 7433 je 0x141023a00
010239cd 488b0dbc8a0b01 mov rcx, qword ptr [rip + 0x10b8abc]
010239d4 4885c9 test rcx, rcx
010239d7 7427 je 0x141023a00
010239d9 0f1f8000000000 nop dword ptr [rax]
010239e0 399990000000 cmp dword ptr [rcx + 0x90], ebx
010239e6 741b je 0x141023a03
010239e8 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
010239f2 750c jne 0x141023a00
010239f4 488b4178 mov rax, qword ptr [rcx + 0x78]
010239f8 488bc8 mov rcx, rax
010239fb 4885c0 test rax, rax
010239fe 75e0 jne 0x1410239e0
01023a00 498bcc mov rcx, r12
01023a03 4885c9 test rcx, rcx
01023a06 7411 je 0x141023a19
01023a08 660f73de04 psrldq xmm6, 4
01023a0d 660f7ef2 movd edx, xmm6
01023a11 e8ca42e9ff call 0x140eb7ce0
01023a16 488bf8 mov rdi, rax
01023a19 4885ff test rdi, rdi
01023a1c 0f84330a0000 je 0x141024455
01023a22 488bcf mov rcx, rdi
01023a25 e8162136ff call 0x140385b40
01023a2a 488b5c2478 mov rbx, qword ptr [rsp + 0x78]
01023a2f 488bf8 mov rdi, rax
01023a32 4885c0 test rax, rax
01023a35 48894580 mov qword ptr [rbp - 0x80], rax
01023a39 0f841b0a0000 je 0x14102445a
01023a3f b201 mov dl, 1
01023a41 488bc8 mov rcx, rax
01023a44 e8772cf8ff call 0x140fa66c0
01023a49 84c0 test al, al
01023a4b 0f85090a0000 jne 0x14102445a
01023a51 4c8b6f08 mov r13, qword ptr [rdi + 8]
01023a55 488b4c2470 mov rcx, qword ptr [rsp + 0x70]
01023a5a 38442440 cmp byte ptr [rsp + 0x40], al
01023a5e 740e je 0x141023a6e
01023a60 410fb7850a010000 movzx eax, word ptr [r13 + 0x10a]
01023a68 898108100000 mov dword ptr [rcx + 0x1008], eax
01023a6e 807c244300 cmp byte ptr [rsp + 0x43], 0
01023a73 740e je 0x141023a83
01023a75 410fb7850c010000 movzx eax, word ptr [r13 + 0x10c]
01023a7d 89810c100000 mov dword ptr [rcx + 0x100c], eax
01023a83 807c244100 cmp byte ptr [rsp + 0x41], 0
01023a88 740f je 0x141023a99
01023a8a 410fb7850e010000 movzx eax, word ptr [r13 + 0x10e]
01023a92 66898144120000 mov word ptr [rcx + 0x1244], ax
01023a99 807c244400 cmp byte ptr [rsp + 0x44], 0
01023a9e 740f je 0x141023aaf
01023aa0 410fb78510010000 movzx eax, word ptr [r13 + 0x110]
01023aa8 66898146120000 mov word ptr [rcx + 0x1246], ax
01023aaf 488b542468 mov rdx, qword ptr [rsp + 0x68]
01023ab4 807c244200 cmp byte ptr [rsp + 0x42], 0
01023ab9 740f je 0x141023aca
01023abb 498b4568 mov rax, qword ptr [r13 + 0x68]
01023abf 0fb74814 movzx ecx, word ptr [rax + 0x14]
01023ac3 66898a2c320000 mov word ptr [rdx + 0x322c], cx
01023aca 807c244500 cmp byte ptr [rsp + 0x45], 0
01023acf 740f je 0x141023ae0
01023ad1 498b4568 mov rax, qword ptr [r13 + 0x68]
01023ad5 0fb74816 movzx ecx, word ptr [rax + 0x16]
01023ad9 66898a2e320000 mov word ptr [rdx + 0x322e], cx
01023ae0 83bda8010000ff cmp dword ptr [rbp + 0x1a8], -1
01023ae7 0f84dc060000 je 0x1410241c9
01023aed 488b7c2448 mov rdi, qword ptr [rsp + 0x48]
01023af2 4885ff test rdi, rdi
01023af5 751d jne 0x141023b14
01023af7 4c8d45a0 lea r8, [rbp - 0x60]
01023afb 33c9 xor ecx, ecx
01023afd e84e6b0100 call 0x14103a650
01023b02 488b7da0 mov rdi, qword ptr [rbp - 0x60]
01023b06 48897c2448 mov qword ptr [rsp + 0x48], rdi
01023b0b 4885ff test rdi, rdi
01023b0e 0f84b1060000 je 0x1410241c5
01023b14 813f61747261 cmp dword ptr [rdi], 0x61727461
01023b1a 0f85a5060000 jne 0x1410241c5
01023b20 837f4800 cmp dword ptr [rdi + 0x48], 0
01023b24 7e45 jle 0x141023b6b
01023b26 488b5f40 mov rbx, qword ptr [rdi + 0x40]
01023b2a 4885db test rbx, rbx
01023b2d 7504 jne 0x141023b33
01023b2f b001 mov al, 1
01023b31 eb30 jmp 0x141023b63
01023b33 488bcb mov rcx, rbx
01023b36 ff15cc528c00 call qword ptr [rip + 0x8c52cc]
01023b3c 4885c0 test rax, rax
01023b3f 7f04 jg 0x141023b45
01023b41 b001 mov al, 1
01023b43 eb1e jmp 0x141023b63
01023b45 33d2 xor edx, edx
01023b47 488bcb mov rcx, rbx
01023b4a ff15c0528c00 call qword ptr [rip + 0x8c52c0]
01023b50 488bc8 mov rcx, rax
01023b53 b001 mov al, 1
01023b55 4885c9 test rcx, rcx
01023b58 7409 je 0x141023b63
01023b5a 8b4110 mov eax, dword ptr [rcx + 0x10]
01023b5d d1e8 shr eax, 1
01023b5f f6d0 not al
01023b61 2401 and al, 1
01023b63 84c0 test al, al
01023b65 0f8431010000 je 0x141023c9c
01023b6b 4d85ed test r13, r13
01023b6e 0f8428010000 je 0x141023c9c
01023b74 498b4510 mov rax, qword ptr [r13 + 0x10]
01023b78 4885c0 test rax, rax
01023b7b 0f841b010000 je 0x141023c9c
01023b81 8b8084000000 mov eax, dword ptr [rax + 0x84]
01023b87 3d6c696220 cmp eax, 0x2062696c
01023b8c 7427 je 0x141023bb5
01023b8e 3d73727672 cmp eax, 0x72767273
01023b93 7420 je 0x141023bb5
01023b95 3d72616469 cmp eax, 0x69646172
01023b9a 7419 je 0x141023bb5
01023b9c 3d6d757369 cmp eax, 0x6973756d
01023ba1 7412 je 0x141023bb5
01023ba3 3d636e7470 cmp eax, 0x70746e63
01023ba8 740b je 0x141023bb5
01023baa 3d6d656472 cmp eax, 0x7264656d
01023baf 0f85e7000000 jne 0x141023c9c
01023bb5 498bcd mov rcx, r13
01023bb8 e8f3eff7ff call 0x140fa2bb0
01023bbd 84c0 test al, al
01023bbf 0f84d7000000 je 0x141023c9c
01023bc5 498bcd mov rcx, r13
01023bc8 e8d3eef7ff call 0x140fa2aa0
01023bcd 3c04 cmp al, 4
01023bcf 0f84c7000000 je 0x141023c9c
01023bd5 41b101 mov r9b, 1
01023bd8 4533c0 xor r8d, r8d
01023bdb 33d2 xor edx, edx
01023bdd 498bcd mov rcx, r13
01023be0 e87b420100 call 0x141037e60
01023be5 498b4510 mov rax, qword ptr [r13 + 0x10]
01023be9 4885c0 test rax, rax
01023bec 0f84aa000000 je 0x141023c9c
01023bf2 8b8084000000 mov eax, dword ptr [rax + 0x84]
01023bf8 3d6c696220 cmp eax, 0x2062696c
01023bfd 7423 je 0x141023c22
01023bff 3d73727672 cmp eax, 0x72767273
01023c04 741c je 0x141023c22
01023c06 3d72616469 cmp eax, 0x69646172
01023c0b 7415 je 0x141023c22
01023c0d 3d6d757369 cmp eax, 0x6973756d
01023c12 740e je 0x141023c22
01023c14 3d636e7470 cmp eax, 0x70746e63
01023c19 7407 je 0x141023c22
01023c1b 3d6d656472 cmp eax, 0x7264656d
01023c20 757a jne 0x141023c9c
01023c22 498bcd mov rcx, r13
01023c25 e876eef7ff call 0x140fa2aa0
01023c2a 3c04 cmp al, 4
01023c2c 750c jne 0x141023c3a
01023c2e 498bcd mov rcx, r13
01023c31 e87aeff7ff call 0x140fa2bb0
01023c36 84c0 test al, al
01023c38 7562 jne 0x141023c9c
01023c3a 4533c0 xor r8d, r8d
01023c3d 498bd5 mov rdx, r13
01023c40 488d8d90000000 lea rcx, [rbp + 0x90]
01023c47 e884ecf7ff call 0x140fa28d0
01023c4c 90 nop 
01023c4d 488b8d90000000 mov rcx, qword ptr [rbp + 0x90]
01023c54 4885c9 test rcx, rcx
01023c57 740c je 0x141023c65
01023c59 488b01 mov rax, qword ptr [rcx]
01023c5c 33d2 xor edx, edx
01023c5e ff9098000000 call qword ptr [rax + 0x98]
01023c64 90 nop 
01023c65 488b9d98000000 mov rbx, qword ptr [rbp + 0x98]
01023c6c 4885db test rbx, rbx
01023c6f 742b je 0x141023c9c
01023c71 418bc7 mov eax, r15d
01023c74 f00fc14308 lock xadd dword ptr [rbx + 8], eax
01023c79 83f801 cmp eax, 1
01023c7c 751e jne 0x141023c9c
01023c7e 488b03 mov rax, qword ptr [rbx]
01023c81 488bcb mov rcx, rbx
01023c84 ff10 call qword ptr [rax]
01023c86 418bc7 mov eax, r15d
01023c89 f00fc1430c lock xadd dword ptr [rbx + 0xc], eax
01023c8e 83f801 cmp eax, 1
01023c91 7509 jne 0x141023c9c
01023c93 488b03 mov rax, qword ptr [rbx]
01023c96 488bcb mov rcx, rbx
01023c99 ff5008 call qword ptr [rax + 8]
01023c9c 4d8bf4 mov r14, r12
01023c9f 4c89642460 mov qword ptr [rsp + 0x60], r12
01023ca4 837f4800 cmp dword ptr [rdi + 0x48], 0
01023ca8 0f8e34010000 jle 0x141023de2
01023cae 4c8d442460 lea r8, [rsp + 0x60]
01023cb3 33c9 xor ecx, ecx
01023cb5 e896690100 call 0x14103a650
01023cba 448bf8 mov r15d, eax
01023cbd 85c0 test eax, eax
01023cbf 0f85db010000 jne 0x141023ea0
01023cc5 448b7f48 mov r15d, dword ptr [rdi + 0x48]
01023cc9 418bf4 mov esi, r12d
01023ccc 4c8b742460 mov r14, qword ptr [rsp + 0x60]
01023cd1 4585ff test r15d, r15d
01023cd4 0f84cf000000 je 0x141023da9
01023cda 660f1f440000 nop word ptr [rax + rax]
01023ce0 813f61747261 cmp dword ptr [rdi], 0x61727461
01023ce6 0f85b2000000 jne 0x141023d9e
01023cec 8b4748 mov eax, dword ptr [rdi + 0x48]
01023cef 85c0 test eax, eax
01023cf1 0f8ea7000000 jle 0x141023d9e
01023cf7 3bc6 cmp eax, esi
01023cf9 0f8e9f000000 jle 0x141023d9e
01023cff 488b5f40 mov rbx, qword ptr [rdi + 0x40]
01023d03 4885db test rbx, rbx
01023d06 0f8492000000 je 0x141023d9e
01023d0c 85f6 test esi, esi
01023d0e 0f888a000000 js 0x141023d9e
01023d14 4863fe movsxd rdi, esi
01023d17 488bcb mov rcx, rbx
01023d1a ff15e8508c00 call qword ptr [rip + 0x8c50e8]
01023d20 483bf8 cmp rdi, rax
01023d23 7d74 jge 0x141023d99
01023d25 488bd7 mov rdx, rdi
01023d28 488bcb mov rcx, rbx
01023d2b ff15df508c00 call qword ptr [rip + 0x8c50df]
01023d31 488bd8 mov rbx, rax
01023d34 4885c0 test rax, rax
01023d37 7460 je 0x141023d99
01023d39 813877747261 cmp dword ptr [rax], 0x61727477
01023d3f 7558 jne 0x141023d99
01023d41 8b480c mov ecx, dword ptr [rax + 0xc]
01023d44 85c9 test ecx, ecx
01023d46 7504 jne 0x141023d4c
01023d48 b101 mov cl, 1
01023d4a eb08 jmp 0x141023d54
01023d4c c1e902 shr ecx, 2
01023d4f f6d1 not cl
01023d51 80e101 and cl, 1
01023d54 84c9 test cl, cl
01023d56 7441 je 0x141023d99
01023d58 4d85f6 test r14, r14
01023d5b 743c je 0x141023d99
01023d5d 41813e61747261 cmp dword ptr [r14], 0x61727461
01023d64 7533 jne 0x141023d99
01023d66 498b4e40 mov rcx, qword ptr [r14 + 0x40]
01023d6a 4885c9 test rcx, rcx
01023d6d 742a je 0x141023d99
01023d6f 488bd3 mov rdx, rbx
01023d72 ff1588508c00 call qword ptr [rip + 0x8c5088]
01023d78 41ff4648 inc dword ptr [r14 + 0x48]
01023d7c 41807e1800 cmp byte ptr [r14 + 0x18], 0
01023d81 7416 je 0x141023d99
01023d83 418b4614 mov eax, dword ptr [r14 + 0x14]
01023d87 488b7c2448 mov rdi, qword ptr [rsp + 0x48]
01023d8c 813b77747261 cmp dword ptr [rbx], 0x61727477
01023d92 750a jne 0x141023d9e
01023d94 09430c or dword ptr [rbx + 0xc], eax
01023d97 eb05 jmp 0x141023d9e
01023d99 488b7c2448 mov rdi, qword ptr [rsp + 0x48]
01023d9e ffc6 inc esi
01023da0 413bf7 cmp esi, r15d
01023da3 0f8237ffffff jb 0x141023ce0
01023da9 41837e4800 cmp dword ptr [r14 + 0x48], 0
01023dae 7532 jne 0x141023de2
01023db0 41836e0401 sub dword ptr [r14 + 4], 1
01023db5 7528 jne 0x141023ddf
01023db7 41813e61747261 cmp dword ptr [r14], 0x61727461
01023dbe 751f jne 0x141023ddf
01023dc0 498b4e40 mov rcx, qword ptr [r14 + 0x40]
01023dc4 4885c9 test rcx, rcx
01023dc7 7406 je 0x141023dcf
01023dc9 ff1551508c00 call qword ptr [rip + 0x8c5051]
01023dcf 4d896640 mov qword ptr [r14 + 0x40], r12
01023dd3 458926 mov dword ptr [r14], r12d
01023dd6 498bce mov rcx, r14
01023dd9 ff1589858c00 call qword ptr [rip + 0x8c8589]
01023ddf 4d8bf4 mov r14, r12
01023de2 41b803000000 mov r8d, 3
01023de8 498bd6 mov rdx, r14
01023deb 498bcd mov rcx, r13
01023dee e85d7d0100 call 0x14103bb50
01023df3 448bf8 mov r15d, eax
01023df6 83f8fc cmp eax, -4
01023df9 0f856e030000 jne 0x14102416d
01023dff 33d2 xor edx, edx
01023e01 498bcd mov rcx, r13
01023e04 e8973b0100 call 0x1410379a0
01023e09 84c0 test al, al
01023e0b 0f845c030000 je 0x14102416d
01023e11 498b4d58 mov rcx, qword ptr [r13 + 0x58]
01023e15 817934454c4946 cmp dword ptr [rcx + 0x34], 0x46494c45
01023e1c 0f854b030000 jne 0x14102416d
01023e22 e8b94cf8ff call 0x140fa8ae0
01023e27 3d20204141 cmp eax, 0x41412020
01023e2c 0f853b030000 jne 0x14102416d
01023e32 4c896518 mov qword ptr [rbp + 0x18], r12
01023e36 4c896520 mov qword ptr [rbp + 0x20], r12
01023e3a 4c896548 mov qword ptr [rbp + 0x48], r12
01023e3e 4c896550 mov qword ptr [rbp + 0x50], r12
01023e42 4c896500 mov qword ptr [rbp], r12
01023e46 4c896508 mov qword ptr [rbp + 8], r12
01023e4a 4c896510 mov qword ptr [rbp + 0x10], r12
01023e4e 48c74528656e6f6e mov qword ptr [rbp + 0x28], 0x6e6f6e65
01023e56 c6453000 mov byte ptr [rbp + 0x30], 0
01023e5a 48c7453400000000 mov qword ptr [rbp + 0x34], 0
01023e62 c7453c00000000 mov dword ptr [rbp + 0x3c], 0
01023e69 c6454000 mov byte ptr [rbp + 0x40], 0
01023e6d c6858400000000 mov byte ptr [rbp + 0x84], 0
01023e74 c6455800 mov byte ptr [rbp + 0x58], 0
01023e78 c6457800 mov byte ptr [rbp + 0x78], 0
01023e7c c6457c00 mov byte ptr [rbp + 0x7c], 0
01023e80 c6858000000000 mov byte ptr [rbp + 0x80], 0
01023e87 458bfc mov r15d, r12d
01023e8a 498b7d10 mov rdi, qword ptr [r13 + 0x10]
01023e8e 488b5c2448 mov rbx, qword ptr [rsp + 0x48]
01023e93 813b61747261 cmp dword ptr [rbx], 0x61727461
01023e99 7444 je 0x141023edf
01023e9b 498bc4 mov rax, r12
01023e9e eb76 jmp 0x141023f16
01023ea0 488b5c2460 mov rbx, qword ptr [rsp + 0x60]
01023ea5 4885db test rbx, rbx
01023ea8 742d je 0x141023ed7
01023eaa 836b0401 sub dword ptr [rbx + 4], 1
01023eae 7527 jne 0x141023ed7
01023eb0 813b61747261 cmp dword ptr [rbx], 0x61727461
01023eb6 751f jne 0x141023ed7
01023eb8 488b4b40 mov rcx, qword ptr [rbx + 0x40]
01023ebc 4885c9 test rcx, rcx
01023ebf 7406 je 0x141023ec7
01023ec1 ff15594f8c00 call qword ptr [rip + 0x8c4f59]
01023ec7 4c896340 mov qword ptr [rbx + 0x40], r12
01023ecb 448923 mov dword ptr [rbx], r12d
01023ece 488bcb mov rcx, rbx
01023ed1 ff1591848c00 call qword ptr [rip + 0x8c8491]
01023ed7 4d8bf4 mov r14, r12
01023eda e98e020000 jmp 0x14102416d
01023edf 837b4800 cmp dword ptr [rbx + 0x48], 0
01023ee3 7f05 jg 0x141023eea
01023ee5 498bc4 mov rax, r12
01023ee8 eb2c jmp 0x141023f16
01023eea 488b5b40 mov rbx, qword ptr [rbx + 0x40]
01023eee 4885db test rbx, rbx
01023ef1 7505 jne 0x141023ef8
01023ef3 498bc4 mov rax, r12
01023ef6 eb1e jmp 0x141023f16
01023ef8 488bcb mov rcx, rbx
01023efb ff15074f8c00 call qword ptr [rip + 0x8c4f07]
01023f01 4885c0 test rax, rax
01023f04 7f05 jg 0x141023f0b
01023f06 498bc4 mov rax, r12
01023f09 eb0b jmp 0x141023f16
01023f0b 33d2 xor edx, edx
01023f0d 488bcb mov rcx, rbx
01023f10 ff15fa4e8c00 call qword ptr [rip + 0x8c4efa]
01023f16 488d4d00 lea rcx, [rbp]
01023f1a 48894c2428 mov qword ptr [rsp + 0x28], rcx
01023f1f 488bd0 mov rdx, rax
01023f22 488bcf mov rcx, rdi
01023f25 e8a6380100 call 0x1410377d0
01023f2a 8b7d38 mov edi, dword ptr [rbp + 0x38]
01023f2d 488b7508 mov rsi, qword ptr [rbp + 8]
01023f31 85ff test edi, edi
01023f33 7405 je 0x141023f3a
01023f35 83ff01 cmp edi, 1
01023f38 7509 jne 0x141023f43
01023f3a 4885f6 test rsi, rsi
01023f3d 0f849b010000 je 0x1410240de
01023f43 498b4510 mov rax, qword ptr [r13 + 0x10]
01023f47 4885c0 test rax, rax
01023f4a 0f8494010000 je 0x1410240e4
01023f50 8b8084000000 mov eax, dword ptr [rax + 0x84]
01023f56 3d6c696220 cmp eax, 0x2062696c
01023f5b 7427 je 0x141023f84
01023f5d 3d73727672 cmp eax, 0x72767273
01023f62 7420 je 0x141023f84
01023f64 3d72616469 cmp eax, 0x69646172
01023f69 7419 je 0x141023f84
01023f6b 3d6d757369 cmp eax, 0x6973756d
01023f70 7412 je 0x141023f84
01023f72 3d636e7470 cmp eax, 0x70746e63
01023f77 740b je 0x141023f84
01023f79 3d6d656472 cmp eax, 0x7264656d
01023f7e 0f8560010000 jne 0x1410240e4
01023f84 498bcd mov rcx, r13
01023f87 e814ebf7ff call 0x140fa2aa0
01023f8c 0fb6c8 movzx ecx, al
01023f8f 83e903 sub ecx, 3
01023f92 7405 je 0x141023f99
01023f94 83f901 cmp ecx, 1
01023f97 750a jne 0x141023fa3
01023f99 33d2 xor edx, edx
01023f9b 498bcd mov rcx, r13
01023f9e e8dd410100 call 0x141038180
01023fa3 498bcd mov rcx, r13
01023fa6 e805ecf7ff call 0x140fa2bb0
01023fab 84c0 test al, al
01023fad 740a je 0x141023fb9
01023faf 33d2 xor edx, edx
01023fb1 498bcd mov rcx, r13
01023fb4 e8c7410100 call 0x141038180
01023fb9 41b001 mov r8b, 1
01023fbc 498bd5 mov rdx, r13
01023fbf 488d8da0000000 lea rcx, [rbp + 0xa0]
01023fc6 e805e9f7ff call 0x140fa28d0
01023fcb 90 nop 
01023fcc 488b8da0000000 mov rcx, qword ptr [rbp + 0xa0]
01023fd3 4885c9 test rcx, rcx
01023fd6 740c je 0x141023fe4
01023fd8 488b01 mov rax, qword ptr [rcx]
01023fdb b204 mov dl, 4
01023fdd ff9098000000 call qword ptr [rax + 0x98]
01023fe3 90 nop 
01023fe4 488b9da8000000 mov rbx, qword ptr [rbp + 0xa8]
01023feb 4885db test rbx, rbx
01023fee 742f je 0x14102401f
01023ff0 b8ffffffff mov eax, 0xffffffff
01023ff5 f00fc14308 lock xadd dword ptr [rbx + 8], eax
01023ffa 83f801 cmp eax, 1
01023ffd 7520 jne 0x14102401f
01023fff 488b03 mov rax, qword ptr [rbx]
01024002 488bcb mov rcx, rbx
01024005 ff10 call qword ptr [rax]
01024007 b8ffffffff mov eax, 0xffffffff
0102400c f00fc1430c lock xadd dword ptr [rbx + 0xc], eax
01024011 83f801 cmp eax, 1
01024014 7509 jne 0x14102401f
01024016 488b03 mov rax, qword ptr [rbx]
01024019 488bcb mov rcx, rbx
0102401c ff5008 call qword ptr [rax + 8]
0102401f 49837d1000 cmp qword ptr [r13 + 0x10], 0
01024024 0f84a5000000 je 0x1410240cf
0102402a 85ff test edi, edi
0102402c 7405 je 0x141024033
0102402e 83ff01 cmp edi, 1
01024031 7509 jne 0x14102403c
01024033 4885f6 test rsi, rsi
01024036 0f8493000000 je 0x1410240cf
0102403c 498bcd mov rcx, r13
0102403f e8bceef6ff call 0x140f92f00
01024044 488b7d10 mov rdi, qword ptr [rbp + 0x10]
01024048 4885f6 test rsi, rsi
0102404b 750a jne 0x141024057
0102404d 4885ff test rdi, rdi
01024050 7505 jne 0x141024057
01024052 4532c0 xor r8b, r8b
01024055 eb03 jmp 0x14102405a
01024057 41b001 mov r8b, 1
0102405a 498bd5 mov rdx, r13
0102405d 488d8db0000000 lea rcx, [rbp + 0xb0]
01024064 e867e8f7ff call 0x140fa28d0
01024069 90 nop 
0102406a 488b9db0000000 mov rbx, qword ptr [rbp + 0xb0]
01024071 4885db test rbx, rbx
01024074 741f je 0x141024095
01024076 488b03 mov rax, qword ptr [rbx]
01024079 488bd6 mov rdx, rsi
0102407c 488bcb mov rcx, rbx
0102407f ff90c0000000 call qword ptr [rax + 0xc0]
01024085 488b03 mov rax, qword ptr [rbx]
01024088 488bd7 mov rdx, rdi
0102408b 488bcb mov rcx, rbx
0102408e ff9028020000 call qword ptr [rax + 0x228]
01024094 90 nop 
01024095 488b9db8000000 mov rbx, qword ptr [rbp + 0xb8]
0102409c 4885db test rbx, rbx
0102409f 742e je 0x1410240cf
010240a1 bfffffffff mov edi, 0xffffffff
010240a6 8bc7 mov eax, edi
010240a8 f00fc14308 lock xadd dword ptr [rbx + 8], eax
010240ad 83f801 cmp eax, 1
010240b0 751d jne 0x1410240cf
010240b2 488b03 mov rax, qword ptr [rbx]
010240b5 488bcb mov rcx, rbx
010240b8 ff10 call qword ptr [rax]
010240ba 8bc7 mov eax, edi
010240bc f00fc1430c lock xadd dword ptr [rbx + 0xc], eax
010240c1 83f801 cmp eax, 1
010240c4 7509 jne 0x1410240cf
010240c6 488b03 mov rax, qword ptr [rbx]
010240c9 488bcb mov rcx, rbx
010240cc ff5008 call qword ptr [rax + 8]
010240cf ba25000000 mov edx, 0x25
010240d4 498bcd mov rcx, r13
010240d7 e82400f7ff call 0x140f94100
010240dc eb06 jmp 0x1410240e4
010240de 41bfceffffff mov r15d, 0xffffffce
010240e4 488b4d48 mov rcx, qword ptr [rbp + 0x48]
010240e8 4885c9 test rcx, rcx
010240eb bbffffffff mov ebx, 0xffffffff
010240f0 7418 je 0x14102410a
010240f2 8bc3 mov eax, ebx
010240f4 f00fc14108 lock xadd dword ptr [rcx + 8], eax
010240f9 83f801 cmp eax, 1
010240fc 750c jne 0x14102410a
010240fe c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01024105 e8ce7c7700 call 0x14179bdd8
0102410a 488b4d50 mov rcx, qword ptr [rbp + 0x50]
0102410e 4885c9 test rcx, rcx
01024111 7418 je 0x14102412b
01024113 8bc3 mov eax, ebx
01024115 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102411a 83f801 cmp eax, 1
0102411d 750c jne 0x14102412b
0102411f c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01024126 e8ad7c7700 call 0x14179bdd8
0102412b 488b4d18 mov rcx, qword ptr [rbp + 0x18]
0102412f 4885c9 test rcx, rcx
01024132 7418 je 0x14102414c
01024134 8bc3 mov eax, ebx
01024136 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102413b 83f801 cmp eax, 1
0102413e 750c jne 0x14102414c
01024140 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01024147 e88c7c7700 call 0x14179bdd8
0102414c 488b4d20 mov rcx, qword ptr [rbp + 0x20]
01024150 4885c9 test rcx, rcx
01024153 7418 je 0x14102416d
01024155 8bc3 mov eax, ebx
01024157 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0102415c 83f801 cmp eax, 1
0102415f 750c jne 0x14102416d
01024161 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01024168 e86b7c7700 call 0x14179bdd8
0102416d 4d85f6 test r14, r14
01024170 742f je 0x1410241a1
01024172 41836e0401 sub dword ptr [r14 + 4], 1
01024177 7528 jne 0x1410241a1
01024179 41813e61747261 cmp dword ptr [r14], 0x61727461
01024180 751f jne 0x1410241a1
01024182 498b4e40 mov rcx, qword ptr [r14 + 0x40]
01024186 4885c9 test rcx, rcx
01024189 7406 je 0x141024191
0102418b ff158f4c8c00 call qword ptr [rip + 0x8c4c8f]
01024191 4d896640 mov qword ptr [r14 + 0x40], r12
01024195 458926 mov dword ptr [r14], r12d
01024198 498bce mov rcx, r14
0102419b ff15c7818c00 call qword ptr [rip + 0x8c81c7]
010241a1 8b442450 mov eax, dword ptr [rsp + 0x50]
010241a5 0fb6c0 movzx eax, al
010241a8 4585ff test r15d, r15d
010241ab b901000000 mov ecx, 1
010241b0 0f44c1 cmove eax, ecx
010241b3 89442450 mov dword ptr [rsp + 0x50], eax
010241b7 488b75b8 mov rsi, qword ptr [rbp - 0x48]
010241bb 41bfffffffff mov r15d, 0xffffffff
010241c1 4c8b75a8 mov r14, qword ptr [rbp - 0x58]
010241c5 488b7d80 mov rdi, qword ptr [rbp - 0x80]
010241c9 807c244600 cmp byte ptr [rsp + 0x46], 0
010241ce 0f840e010000 je 0x1410242e2
010241d4 4885f6 test rsi, rsi
010241d7 740a je 0x1410241e3
010241d9 f6464b01 test byte ptr [rsi + 0x4b], 1
010241dd 0f85e2000000 jne 0x1410242c5
010241e3 4d85ed test r13, r13
010241e6 0f848d000000 je 0x141024279
010241ec 49837d1000 cmp qword ptr [r13 + 0x10], 0
010241f1 0f8482000000 je 0x141024279
010241f7 41f6859a00000001 test byte ptr [r13 + 0x9a], 1
010241ff 7434 je 0x141024235
01024201 498b4568 mov rax, qword ptr [r13 + 0x68]
01024205 83781000 cmp dword ptr [rax + 0x10], 0
01024209 752a jne 0x141024235
0102420b 4183bdac00000000 cmp dword ptr [r13 + 0xac], 0
01024213 7520 jne 0x141024235
01024215 498bcd mov rcx, r13
01024218 e823d0f6ff call 0x140f91240
0102421d 418985ac000000 mov dword ptr [r13 + 0xac], eax
01024224 85c0 test eax, eax
01024226 740d je 0x141024235
01024228 ba3c000000 mov edx, 0x3c
0102422d 498bcd mov rcx, r13
01024230 e8cbfef6ff call 0x140f94100
01024235 49837d1000 cmp qword ptr [r13 + 0x10], 0
0102423a 743d je 0x141024279
0102423c 41f6859a00000001 test byte ptr [r13 + 0x9a], 1
01024244 7433 je 0x141024279
01024246 4183bdac00000000 cmp dword ptr [r13 + 0xac], 0
0102424e 7520 jne 0x141024270
01024250 498bcd mov rcx, r13
01024253 e8e8cff6ff call 0x140f91240
01024258 418985ac000000 mov dword ptr [r13 + 0xac], eax
0102425f 85c0 test eax, eax
01024261 740d je 0x141024270
01024263 ba3c000000 mov edx, 0x3c
01024268 498bcd mov rcx, r13
0102426b e890fef6ff call 0x140f94100
01024270 418b8dac000000 mov ecx, dword ptr [r13 + 0xac]
01024277 eb03 jmp 0x14102427c
01024279 418bcc mov ecx, r12d
0102427c e87f106200 call 0x141645300
01024281 8b4c2454 mov ecx, dword ptr [rsp + 0x54]
01024285 85c1 test ecx, eax
01024287 743c je 0x1410242c5
01024289 4180bd9d00000000 cmp byte ptr [r13 + 0x9d], 0
01024291 7d08 jge 0x14102429b
01024293 f7c104002000 test ecx, 0x200004
01024299 742a je 0x1410242c5
0102429b 448bc1 mov r8d, ecx
0102429e 33d2 xor edx, edx
010242a0 4c8b6c2468 mov r13, qword ptr [rsp + 0x68]
010242a5 498bcd mov rcx, r13
010242a8 e89325ebff call 0x140ed6840
010242ad 48b82000001040000000 movabs rax, 0x4010000020
010242b7 49094500 or qword ptr [r13], rax
010242bb 498b4508 mov rax, qword ptr [r13 + 8]
010242bf 49894508 mov qword ptr [r13 + 8], rax
010242c3 eb22 jmp 0x1410242e7
010242c5 4c8b6c2468 mov r13, qword ptr [rsp + 0x68]
010242ca 48b8dfffffefbfffffff movabs rax, 0xffffffbfefffffdf
010242d4 49214500 and qword ptr [r13], rax
010242d8 498b4508 mov rax, qword ptr [r13 + 8]
010242dc 49894508 mov qword ptr [r13 + 8], rax
010242e0 eb05 jmp 0x1410242e7
010242e2 4c8b6c2468 mov r13, qword ptr [rsp + 0x68]
010242e7 488b4708 mov rax, qword ptr [rdi + 8]
010242eb 4885c0 test rax, rax
010242ee 0f849b000000 je 0x14102438f
010242f4 4883781000 cmp qword ptr [rax + 0x10], 0
010242f9 0f8490000000 je 0x14102438f
010242ff 488b5858 mov rbx, qword ptr [rax + 0x58]
01024303 4c89642438 mov qword ptr [rsp + 0x38], r12
01024308 488d4588 lea rax, [rbp - 0x78]
0102430c 4533c9 xor r9d, r9d
0102430f 4d8bc5 mov r8, r13
01024312 4889442430 mov qword ptr [rsp + 0x30], rax
01024317 488d442458 lea rax, [rsp + 0x58]
0102431c 4889442428 mov qword ptr [rsp + 0x28], rax
01024321 c744242001020000 mov dword ptr [rsp + 0x20], 0x201
01024329 483bfb cmp rdi, rbx
0102432c 7554 jne 0x141024382
0102432e 488b742470 mov rsi, qword ptr [rsp + 0x70]
01024333 488bd6 mov rdx, rsi
01024336 488bcb mov rcx, rbx
01024339 e82280eaff call 0x140ecc360
0102433e 488b1b mov rbx, qword ptr [rbx]
01024341 4885db test rbx, rbx
01024344 7449 je 0x14102438f
01024346 66660f1f840000000000 nop word ptr [rax + rax]
01024350 4c89642438 mov qword ptr [rsp + 0x38], r12
01024355 4c89642430 mov qword ptr [rsp + 0x30], r12
0102435a 4c89642428 mov qword ptr [rsp + 0x28], r12
0102435f c744242009020000 mov dword ptr [rsp + 0x20], 0x209
01024367 4533c9 xor r9d, r9d
0102436a 4d8bc5 mov r8, r13
0102436d 488bd6 mov rdx, rsi
01024370 488bcb mov rcx, rbx
01024373 e8e87feaff call 0x140ecc360
01024378 488b1b mov rbx, qword ptr [rbx]
0102437b 4885db test rbx, rbx
0102437e 75d0 jne 0x141024350
01024380 eb0d jmp 0x14102438f
01024382 488b542470 mov rdx, qword ptr [rsp + 0x70]
01024387 488bcf mov rcx, rdi
0102438a e8d17feaff call 0x140ecc360
0102438f 837c245800 cmp dword ptr [rsp + 0x58], 0
01024394 750e jne 0x1410243a4
01024396 48837d8800 cmp qword ptr [rbp - 0x78], 0
0102439b 7507 jne 0x1410243a4
0102439d 48837d9000 cmp qword ptr [rbp - 0x70], 0
010243a2 7419 je 0x1410243bd
010243a4 0f57c0 xorps xmm0, xmm0
010243a7 f30f7f45b8 movdqu xmmword ptr [rbp - 0x48], xmm0
010243ac 488bd7 mov rdx, rdi
010243af 488d4db8 lea rcx, [rbp - 0x48]
010243b3 e8d86537ff call 0x14039a990
010243b8 c644245001 mov byte ptr [rsp + 0x50], 1
010243bd 488d4dc8 lea rcx, [rbp - 0x38]
010243c1 ff15c1678c00 call qword ptr [rip + 0x8c67c1]
010243c7 0f57c9 xorps xmm1, xmm1
010243ca f2480f2a4dc8 cvtsi2sd xmm1, qword ptr [rbp - 0x38]
010243d0 f20f590df0b50a01 mulsd xmm1, qword ptr [rip + 0x10ab5f0]
010243d8 0f28c1 movaps xmm0, xmm1
010243db f20f5cc7 subsd xmm0, xmm7
010243df 488b5c2478 mov rbx, qword ptr [rsp + 0x78]
010243e4 66410f2fc0 comisd xmm0, xmm8
010243e9 7263 jb 0x14102444e
010243eb 0f28f9 movaps xmm7, xmm1
010243ee 0f57c9 xorps xmm1, xmm1
010243f1 488bcb mov rcx, rbx
010243f4 e867d2b4ff call 0x140b71660
010243f9 84c0 test al, al
010243fb 757d jne 0x14102447a
010243fd 4533c0 xor r8d, r8d
01024400 4c636c245c movsxd r13, dword ptr [rsp + 0x5c]
01024405 418bd5 mov edx, r13d
01024408 498bce mov rcx, r14
0102440b e8b0952bff call 0x1402dd9c0
01024410 4885c0 test rax, rax
01024413 742c je 0x141024441
01024415 488bd0 mov rdx, rax
01024418 488d8dc0000000 lea rcx, [rbp + 0xc0]
0102441f e81cc0ecff call 0x140ef0440
01024424 90 nop 
01024425 488d95c0000000 lea rdx, [rbp + 0xc0]
0102442c 488bcb mov rcx, rbx
0102442f e8ecd9b4ff call 0x140b71e20
01024434 90 nop 
01024435 488d8dc0000000 lea rcx, [rbp + 0xc0]
0102443c e89f25abff call 0x140ad69e0
01024441 498bd5 mov rdx, r13
01024444 488bcb mov rcx, rbx
01024447 e8f4d8b4ff call 0x140b71d40
0102444c eb0c jmp 0x14102445a
0102444e 448b6c245c mov r13d, dword ptr [rsp + 0x5c]
01024453 eb05 jmp 0x14102445a
01024455 488b5c2478 mov rbx, qword ptr [rsp + 0x78]
0102445a 41ffc5 inc r13d
0102445d 44896c245c mov dword ptr [rsp + 0x5c], r13d
01024462 488b4598 mov rax, qword ptr [rbp - 0x68]
01024466 48ffc0 inc rax
01024469 48894598 mov qword ptr [rbp - 0x68], rax
0102446d 483b45d8 cmp rax, qword ptr [rbp - 0x28]
01024471 488bf8 mov rdi, rax
01024474 0f8c76f4ffff jl 0x1410238f0
0102447a 807c245000 cmp byte ptr [rsp + 0x50], 0
0102447f 7433 je 0x1410244b4
01024481 488b45e8 mov rax, qword ptr [rbp - 0x18]
01024485 4885c0 test rax, rax
01024488 742a je 0x1410244b4
0102448a 81b88000000074616474 cmp dword ptr [rax + 0x80], 0x74646174
01024494 751e jne 0x1410244b4
01024496 ff889c000000 dec dword ptr [rax + 0x9c]
0102449c 83b89c00000000 cmp dword ptr [rax + 0x9c], 0
010244a3 7f0f jg 0x1410244b4
010244a5 4489a09c000000 mov dword ptr [rax + 0x9c], r12d
010244ac 488bc8 mov rcx, rax
010244af e89c9beaff call 0x140ece050
010244b4 4c8b742448 mov r14, qword ptr [rsp + 0x48]
010244b9 ba01000000 mov edx, 1
010244be 488b4db0 mov rcx, qword ptr [rbp - 0x50]
010244c2 488b4908 mov rcx, qword ptr [rcx + 8]
010244c6 4885c9 test rcx, rcx
010244c9 741e je 0x1410244e9
010244cb 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
010244d5 7512 jne 0x1410244e9
010244d7 8b8180200000 mov eax, dword ptr [rcx + 0x2080]
010244dd 85c0 test eax, eax
010244df 7408 je 0x1410244e9
010244e1 ffc8 dec eax
010244e3 898180200000 mov dword ptr [rcx + 0x2080], eax
010244e9 4885db test rbx, rbx
010244ec 7408 je 0x1410244f6
010244ee 488b03 mov rax, qword ptr [rbx]
010244f1 488bcb mov rcx, rbx
010244f4 ff10 call qword ptr [rax]
010244f6 803d7f07080100 cmp byte ptr [rip + 0x108077f], 0
010244fd 751d jne 0x14102451c
010244ff 33d2 xor edx, edx
01024501 488d0d50aaaf00 lea rcx, [rip + 0xafaa50]
01024508 e843faadff call 0x140b03f50
0102450d 89056d190801 mov dword ptr [rip + 0x108196d], eax
01024513 c6056207080101 mov byte ptr [rip + 0x1080762], 1
0102451a eb06 jmp 0x141024522
0102451c 8b055e190801 mov eax, dword ptr [rip + 0x108195e]
01024522 83f801 cmp eax, 1
01024525 740f je 0x141024536
01024527 803d8106080101 cmp byte ptr [rip + 0x1080681], 1
0102452e 7506 jne 0x141024536
01024530 e8bb8decff call 0x140eed2f0
01024535 90 nop 
01024536 488b4df0 mov rcx, qword ptr [rbp - 0x10]
0102453a 4885c9 test rcx, rcx
0102453d 7419 je 0x141024558
0102453f 418bc7 mov eax, r15d
01024542 f00fc14108 lock xadd dword ptr [rcx + 8], eax
01024547 83f801 cmp eax, 1
0102454a 750c jne 0x141024558
0102454c c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01024553 e880787700 call 0x14179bdd8
01024558 488b4df8 mov rcx, qword ptr [rbp - 8]
0102455c 4885c9 test rcx, rcx
0102455f 7418 je 0x141024579
01024561 f0440fc17908 lock xadd dword ptr [rcx + 8], r15d
01024567 4183ff01 cmp r15d, 1
0102456b 750c jne 0x141024579
0102456d c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01024574 e85f787700 call 0x14179bdd8
01024579 4d85f6 test r14, r14
0102457c 742f je 0x1410245ad
0102457e 41836e0401 sub dword ptr [r14 + 4], 1
01024583 7528 jne 0x1410245ad
01024585 41813e61747261 cmp dword ptr [r14], 0x61727461
0102458c 751f jne 0x1410245ad
0102458e 498b4e40 mov rcx, qword ptr [r14 + 0x40]
01024592 4885c9 test rcx, rcx
01024595 7406 je 0x14102459d
01024597 ff1583488c00 call qword ptr [rip + 0x8c4883]
0102459d 4d896640 mov qword ptr [r14 + 0x40], r12
010245a1 458926 mov dword ptr [r14], r12d
010245a4 498bce mov rcx, r14
010245a7 ff15bb7d8c00 call qword ptr [rip + 0x8c7dbb]
010245ad 4c8d9c2438020000 lea r11, [rsp + 0x238]
010245b5 410f2873e8 movaps xmm6, xmmword ptr [r11 - 0x18]
010245ba 410f287bd8 movaps xmm7, xmmword ptr [r11 - 0x28]
010245bf 450f2843c8 movaps xmm8, xmmword ptr [r11 - 0x38]
010245c4 498be3 mov rsp, r11
010245c7 415f pop r15
010245c9 415e pop r14
010245cb 415d pop r13
010245cd 415c pop r12
010245cf 5f pop rdi
010245d0 5e pop rsi
010245d1 5b pop rbx
010245d2 5d pop rbp
010245d3 c3 ret 