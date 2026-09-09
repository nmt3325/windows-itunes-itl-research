00fbf560 48895c2410 mov qword ptr [rsp + 0x10], rbx
00fbf565 4889742418 mov qword ptr [rsp + 0x18], rsi
00fbf56a 55 push rbp
00fbf56b 57 push rdi
00fbf56c 4154 push r12
00fbf56e 4156 push r14
00fbf570 4157 push r15
00fbf572 488bec mov rbp, rsp
00fbf575 4883ec50 sub rsp, 0x50
00fbf579 488bc2 mov rax, rdx
00fbf57c 4c8bf9 mov r15, rcx
00fbf57f 4533e4 xor r12d, r12d
00fbf582 418bdc mov ebx, r12d
00fbf585 0f57c0 xorps xmm0, xmm0
00fbf588 f30f7f45e0 movdqu xmmword ptr [rbp - 0x20], xmm0
00fbf58d bfffffffff mov edi, 0xffffffff
00fbf592 4885c9 test rcx, rcx
00fbf595 0f8455030000 je 0x140fbf8f0
00fbf59b 4885d2 test rdx, rdx
00fbf59e 0f844c030000 je 0x140fbf8f0
00fbf5a4 4c89642428 mov qword ptr [rsp + 0x28], r12
00fbf5a9 4489642420 mov dword ptr [rsp + 0x20], r12d
00fbf5ae 4533c9 xor r9d, r9d
00fbf5b1 4533c0 xor r8d, r8d
00fbf5b4 ba50545448 mov edx, 0x48545450
00fbf5b9 488bc8 mov rcx, rax
00fbf5bc e8bf35fdff call 0x140f92b80
00fbf5c1 488bd8 mov rbx, rax
00fbf5c4 4885c0 test rax, rax
00fbf5c7 0f8423030000 je 0x140fbf8f0
00fbf5cd 488bc8 mov rcx, rax
00fbf5d0 e85b3afdff call 0x140f93030
00fbf5d5 808b9a00000008 or byte ptr [rbx + 0x9a], 8
00fbf5dc 808b9b00000020 or byte ptr [rbx + 0x9b], 0x20
00fbf5e3 c783ac00000001000000 mov dword ptr [rbx + 0xac], 1
00fbf5ed 808b9f00000008 or byte ptr [rbx + 0x9f], 8
00fbf5f4 488b4358 mov rax, qword ptr [rbx + 0x58]
00fbf5f8 4488603d mov byte ptr [rax + 0x3d], r12b
00fbf5fc 4c396310 cmp qword ptr [rbx + 0x10], r12
00fbf600 7432 je 0x140fbf634
00fbf602 488bcb mov rcx, rbx
00fbf605 e8263afdff call 0x140f93030
00fbf60a 84c0 test al, al
00fbf60c 7426 je 0x140fbf634
00fbf60e 488bb380000000 mov rsi, qword ptr [rbx + 0x80]
00fbf615 498bcf mov rcx, r15
00fbf618 ff15fa979200 call qword ptr [rip + 0x9297fa]
00fbf61e 4c8bf0 mov r14, rax
00fbf621 488b4e20 mov rcx, qword ptr [rsi + 0x20]
00fbf625 4885c9 test rcx, rcx
00fbf628 7406 je 0x140fbf630
00fbf62a ff15f0979200 call qword ptr [rip + 0x9297f0]
00fbf630 4c897620 mov qword ptr [rsi + 0x20], r14
00fbf634 488b15d5070f01 mov rdx, qword ptr [rip + 0x10f07d5]
00fbf63b 44896530 mov dword ptr [rbp + 0x30], r12d
00fbf63f 4885d2 test rdx, rdx
00fbf642 0f8485000000 je 0x140fbf6cd
00fbf648 498bcf mov rcx, r15
00fbf64b ff159f979200 call qword ptr [rip + 0x92979f]
00fbf651 4885c0 test rax, rax
00fbf654 7477 je 0x140fbf6cd
00fbf656 488d5530 lea rdx, [rbp + 0x30]
00fbf65a 488bc8 mov rcx, rax
00fbf65d e88ed3bfff call 0x140bbc9f0
00fbf662 84c0 test al, al
00fbf664 7467 je 0x140fbf6cd
00fbf666 8b4d30 mov ecx, dword ptr [rbp + 0x30]
00fbf669 83e901 sub ecx, 1
00fbf66c 745f je 0x140fbf6cd
00fbf66e 83f901 cmp ecx, 1
00fbf671 755a jne 0x140fbf6cd
00fbf673 488b157e050f01 mov rdx, qword ptr [rip + 0x10f057e]
00fbf67a 4c896530 mov qword ptr [rbp + 0x30], r12
00fbf67e 4885d2 test rdx, rdx
00fbf681 7422 je 0x140fbf6a5
00fbf683 498bcf mov rcx, r15
00fbf686 ff1564979200 call qword ptr [rip + 0x929764]
00fbf68c 4885c0 test rax, rax
00fbf68f 7414 je 0x140fbf6a5
00fbf691 488d5530 lea rdx, [rbp + 0x30]
00fbf695 488bc8 mov rcx, rax
00fbf698 e8f3d5bfff call 0x140bbcc90
00fbf69d 84c0 test al, al
00fbf69f 488b7530 mov rsi, qword ptr [rbp + 0x30]
00fbf6a3 7503 jne 0x140fbf6a8
00fbf6a5 498bf4 mov rsi, r12
00fbf6a8 488b4b58 mov rcx, qword ptr [rbx + 0x58]
00fbf6ac e89f6afeff call 0x140fa6150
00fbf6b1 488b4358 mov rax, qword ptr [rbx + 0x58]
00fbf6b5 488b4810 mov rcx, qword ptr [rax + 0x10]
00fbf6b9 48897140 mov qword ptr [rcx + 0x40], rsi
00fbf6bd 488b8380000000 mov rax, qword ptr [rbx + 0x80]
00fbf6c4 c7400466000000 mov dword ptr [rax + 4], 0x66
00fbf6cb eb4b jmp 0x140fbf718
00fbf6cd 488b1524050f01 mov rdx, qword ptr [rip + 0x10f0524]
00fbf6d4 4c896530 mov qword ptr [rbp + 0x30], r12
00fbf6d8 4885d2 test rdx, rdx
00fbf6db 7422 je 0x140fbf6ff
00fbf6dd 498bcf mov rcx, r15
00fbf6e0 ff150a979200 call qword ptr [rip + 0x92970a]
00fbf6e6 4885c0 test rax, rax
00fbf6e9 7414 je 0x140fbf6ff
00fbf6eb 488d5530 lea rdx, [rbp + 0x30]
00fbf6ef 488bc8 mov rcx, rax
00fbf6f2 e899d5bfff call 0x140bbcc90
00fbf6f7 84c0 test al, al
00fbf6f9 488b5530 mov rdx, qword ptr [rbp + 0x30]
00fbf6fd 7503 jne 0x140fbf702
00fbf6ff 498bd4 mov rdx, r12
00fbf702 488bcb mov rcx, rbx
00fbf705 e8b60bfeff call 0x140fa02c0
00fbf70a 488b8380000000 mov rax, qword ptr [rbx + 0x80]
00fbf711 c7400465000000 mov dword ptr [rax + 4], 0x65
00fbf718 488b15b1050f01 mov rdx, qword ptr [rip + 0x10f05b1]
00fbf71f 4885d2 test rdx, rdx
00fbf722 740b je 0x140fbf72f
00fbf724 498bcf mov rcx, r15
00fbf727 ff15c3969200 call qword ptr [rip + 0x9296c3]
00fbf72d eb03 jmp 0x140fbf732
00fbf72f 498bc4 mov rax, r12
00fbf732 0f57c0 xorps xmm0, xmm0
00fbf735 f30f7f45f0 movdqu xmmword ptr [rbp - 0x10], xmm0
00fbf73a 488d55f0 lea rdx, [rbp - 0x10]
00fbf73e 488bc8 mov rcx, rax
00fbf741 e8cacebfff call 0x140bbc610
00fbf746 488b4de0 mov rcx, qword ptr [rbp - 0x20]
00fbf74a 4885c9 test rcx, rcx
00fbf74d 7418 je 0x140fbf767
00fbf74f 8bc7 mov eax, edi
00fbf751 f00fc14108 lock xadd dword ptr [rcx + 8], eax
00fbf756 83f801 cmp eax, 1
00fbf759 750c jne 0x140fbf767
00fbf75b c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00fbf762 e871c67d00 call 0x14179bdd8
00fbf767 488b4de8 mov rcx, qword ptr [rbp - 0x18]
00fbf76b 4885c9 test rcx, rcx
00fbf76e 7418 je 0x140fbf788
00fbf770 8bc7 mov eax, edi
00fbf772 f00fc14108 lock xadd dword ptr [rcx + 8], eax
00fbf777 83f801 cmp eax, 1
00fbf77a 750c jne 0x140fbf788
00fbf77c c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00fbf783 e850c67d00 call 0x14179bdd8
00fbf788 488b4df0 mov rcx, qword ptr [rbp - 0x10]
00fbf78c 48894de0 mov qword ptr [rbp - 0x20], rcx
00fbf790 488b45f8 mov rax, qword ptr [rbp - 8]
00fbf794 488945e8 mov qword ptr [rbp - 0x18], rax
00fbf798 4885c9 test rcx, rcx
00fbf79b 7406 je 0x140fbf7a3
00fbf79d 48833900 cmp qword ptr [rcx], 0
00fbf7a1 750b jne 0x140fbf7ae
00fbf7a3 4885c0 test rax, rax
00fbf7a6 7412 je 0x140fbf7ba
00fbf7a8 48833800 cmp qword ptr [rax], 0
00fbf7ac 740c je 0x140fbf7ba
00fbf7ae 488d55e0 lea rdx, [rbp - 0x20]
00fbf7b2 488bcb mov rcx, rbx
00fbf7b5 e8966efdff call 0x140f96650
00fbf7ba 498bd7 mov rdx, r15
00fbf7bd 488d4df0 lea rcx, [rbp - 0x10]
00fbf7c1 e8aafbffff call 0x140fbf370
00fbf7c6 488bf0 mov rsi, rax
00fbf7c9 488d45e0 lea rax, [rbp - 0x20]
00fbf7cd 483bf0 cmp rsi, rax
00fbf7d0 7458 je 0x140fbf82a
00fbf7d2 488b4de0 mov rcx, qword ptr [rbp - 0x20]
00fbf7d6 4885c9 test rcx, rcx
00fbf7d9 7418 je 0x140fbf7f3
00fbf7db 8bd7 mov edx, edi
00fbf7dd f00fc15108 lock xadd dword ptr [rcx + 8], edx
00fbf7e2 83fa01 cmp edx, 1
00fbf7e5 750c jne 0x140fbf7f3
00fbf7e7 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00fbf7ee e8e5c57d00 call 0x14179bdd8
00fbf7f3 488b4de8 mov rcx, qword ptr [rbp - 0x18]
00fbf7f7 4885c9 test rcx, rcx
00fbf7fa 7418 je 0x140fbf814
00fbf7fc 8bc7 mov eax, edi
00fbf7fe f00fc14108 lock xadd dword ptr [rcx + 8], eax
00fbf803 83f801 cmp eax, 1
00fbf806 750c jne 0x140fbf814
00fbf808 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00fbf80f e8c4c57d00 call 0x14179bdd8
00fbf814 488b06 mov rax, qword ptr [rsi]
00fbf817 488945e0 mov qword ptr [rbp - 0x20], rax
00fbf81b 488b4608 mov rax, qword ptr [rsi + 8]
00fbf81f 488945e8 mov qword ptr [rbp - 0x18], rax
00fbf823 4c8926 mov qword ptr [rsi], r12
00fbf826 4c896608 mov qword ptr [rsi + 8], r12
00fbf82a 488b4df0 mov rcx, qword ptr [rbp - 0x10]
00fbf82e 4885c9 test rcx, rcx
00fbf831 741c je 0x140fbf84f
00fbf833 8bc7 mov eax, edi
00fbf835 f00fc14108 lock xadd dword ptr [rcx + 8], eax
00fbf83a 83f801 cmp eax, 1
00fbf83d 750c jne 0x140fbf84b
00fbf83f c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00fbf846 e88dc57d00 call 0x14179bdd8
00fbf84b 4c8965f0 mov qword ptr [rbp - 0x10], r12
00fbf84f 488b4df8 mov rcx, qword ptr [rbp - 8]
00fbf853 4885c9 test rcx, rcx
00fbf856 741c je 0x140fbf874
00fbf858 8bc7 mov eax, edi
00fbf85a f00fc14108 lock xadd dword ptr [rcx + 8], eax
00fbf85f 83f801 cmp eax, 1
00fbf862 750c jne 0x140fbf870
00fbf864 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00fbf86b e868c57d00 call 0x14179bdd8
00fbf870 4c8965f8 mov qword ptr [rbp - 8], r12
00fbf874 488b4de0 mov rcx, qword ptr [rbp - 0x20]
00fbf878 4885c9 test rcx, rcx
00fbf87b 7406 je 0x140fbf883
00fbf87d 48833900 cmp qword ptr [rcx], 0
00fbf881 750f jne 0x140fbf892
00fbf883 488b4de8 mov rcx, qword ptr [rbp - 0x18]
00fbf887 4885c9 test rcx, rcx
00fbf88a 7418 je 0x140fbf8a4
00fbf88c 48833900 cmp qword ptr [rcx], 0
00fbf890 7412 je 0x140fbf8a4
00fbf892 4533c9 xor r9d, r9d
00fbf895 4533c0 xor r8d, r8d
00fbf898 488d55e0 lea rdx, [rbp - 0x20]
00fbf89c 488bcb mov rcx, rbx
00fbf89f e81c2dfeff call 0x140fa25c0
00fbf8a4 488b153d020f01 mov rdx, qword ptr [rip + 0x10f023d]
00fbf8ab 4c896530 mov qword ptr [rbp + 0x30], r12
00fbf8af 4885d2 test rdx, rdx
00fbf8b2 743c je 0x140fbf8f0
00fbf8b4 498bcf mov rcx, r15
00fbf8b7 ff1533959200 call qword ptr [rip + 0x929533]
00fbf8bd 4885c0 test rax, rax
00fbf8c0 742e je 0x140fbf8f0
00fbf8c2 488d5530 lea rdx, [rbp + 0x30]
00fbf8c6 488bc8 mov rcx, rax
00fbf8c9 e8c2d3bfff call 0x140bbcc90
00fbf8ce 84c0 test al, al
00fbf8d0 741e je 0x140fbf8f0
00fbf8d2 488b7530 mov rsi, qword ptr [rbp + 0x30]
00fbf8d6 4885f6 test rsi, rsi
00fbf8d9 7415 je 0x140fbf8f0
00fbf8db 488b4b58 mov rcx, qword ptr [rbx + 0x58]
00fbf8df e86c68feff call 0x140fa6150
00fbf8e4 488b4358 mov rax, qword ptr [rbx + 0x58]
00fbf8e8 488b4810 mov rcx, qword ptr [rax + 0x10]
00fbf8ec 48897158 mov qword ptr [rcx + 0x58], rsi
00fbf8f0 488b4de0 mov rcx, qword ptr [rbp - 0x20]
00fbf8f4 4885c9 test rcx, rcx
00fbf8f7 741c je 0x140fbf915
00fbf8f9 8bc7 mov eax, edi
00fbf8fb f00fc14108 lock xadd dword ptr [rcx + 8], eax
00fbf900 83f801 cmp eax, 1
00fbf903 750c jne 0x140fbf911
00fbf905 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00fbf90c e8c7c47d00 call 0x14179bdd8
00fbf911 4c8965e0 mov qword ptr [rbp - 0x20], r12
00fbf915 488b4de8 mov rcx, qword ptr [rbp - 0x18]
00fbf919 4885c9 test rcx, rcx
00fbf91c 7416 je 0x140fbf934
00fbf91e f00fc17908 lock xadd dword ptr [rcx + 8], edi
00fbf923 83ff01 cmp edi, 1
00fbf926 750c jne 0x140fbf934
00fbf928 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00fbf92f e8a4c47d00 call 0x14179bdd8
00fbf934 488bc3 mov rax, rbx
00fbf937 4c8d5c2450 lea r11, [rsp + 0x50]
00fbf93c 498b5b38 mov rbx, qword ptr [r11 + 0x38]
00fbf940 498b7340 mov rsi, qword ptr [r11 + 0x40]
00fbf944 498be3 mov rsp, r11
00fbf947 415f pop r15
00fbf949 415e pop r14
00fbf94b 415c pop r12
00fbf94d 5f pop rdi
00fbf94e 5d pop rbp
00fbf94f c3 ret 