0108f6f0 488bc4 mov rax, rsp
0108f6f3 48895810 mov qword ptr [rax + 0x10], rbx
0108f6f7 48897018 mov qword ptr [rax + 0x18], rsi
0108f6fb 48897820 mov qword ptr [rax + 0x20], rdi
0108f6ff 55 push rbp
0108f700 4154 push r12
0108f702 4155 push r13
0108f704 4156 push r14
0108f706 4157 push r15
0108f708 488da848f9ffff lea rbp, [rax - 0x6b8]
0108f70f 4881ec90070000 sub rsp, 0x790
0108f716 0f2970c8 movaps xmmword ptr [rax - 0x38], xmm6
0108f71a 0f2978b8 movaps xmmword ptr [rax - 0x48], xmm7
0108f71e 440f2940a8 movaps xmmword ptr [rax - 0x58], xmm8
0108f723 488b051659f400 mov rax, qword ptr [rip + 0xf45916]
0108f72a 4833c4 xor rax, rsp
0108f72d 48898550060000 mov qword ptr [rbp + 0x650], rax
0108f734 4c8bf9 mov r15, rcx
0108f737 48894c2448 mov qword ptr [rsp + 0x48], rcx
0108f73c 4885c9 test rcx, rcx
0108f73f 0f8405100000 je 0x14109074a
0108f745 488b4170 mov rax, qword ptr [rcx + 0x70]
0108f749 4885c0 test rax, rax
0108f74c 0f84f80f0000 je 0x14109074a
0108f752 8b5864 mov ebx, dword ptr [rax + 0x64]
0108f755 895c2440 mov dword ptr [rsp + 0x40], ebx
0108f759 8d43ff lea eax, [rbx - 1]
0108f75c bffe000000 mov edi, 0xfe
0108f761 3bc7 cmp eax, edi
0108f763 0f87e10f0000 ja 0x14109074a
0108f769 488d542430 lea rdx, [rsp + 0x30]
0108f76e b103 mov cl, 3
0108f770 e8bb930c00 call 0x141158b30
0108f775 85c0 test eax, eax
0108f777 0f85d20f0000 jne 0x14109074f
0108f77d 4d8b7f08 mov r15, qword ptr [r15 + 8]
0108f781 4c897c2450 mov qword ptr [rsp + 0x50], r15
0108f786 4d85ff test r15, r15
0108f789 0f84bb0f0000 je 0x14109074a
0108f78f 4d8b8fe8200000 mov r9, qword ptr [r15 + 0x20e8]
0108f796 498d9160100000 lea rdx, [r9 + 0x1060]
0108f79d 410fb6817a100000 movzx eax, byte ptr [r9 + 0x107a]
0108f7a5 88442428 mov byte ptr [rsp + 0x28], al
0108f7a9 410fb68179100000 movzx eax, byte ptr [r9 + 0x1079]
0108f7b1 88442420 mov byte ptr [rsp + 0x20], al
0108f7b5 450fb68978100000 movzx r9d, byte ptr [r9 + 0x1078]
0108f7bd 440fb6c3 movzx r8d, bl
0108f7c1 4c8b6c2430 mov r13, qword ptr [rsp + 0x30]
0108f7c6 498bcd mov rcx, r13
0108f7c9 e892970c00 call 0x141158f60
0108f7ce 8bd8 mov ebx, eax
0108f7d0 85c0 test eax, eax
0108f7d2 0f852b0f0000 jne 0x141090703
0108f7d8 4d8bbfe8200000 mov r15, qword ptr [r15 + 0x20e8]
0108f7df 4d85ed test r13, r13
0108f7e2 0f84160f0000 je 0x1410906fe
0108f7e8 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108f7f0 0f85080f0000 jne 0x1410906fe
0108f7f6 498bb5b8080000 mov rsi, qword ptr [r13 + 0x8b8]
0108f7fd 33c0 xor eax, eax
0108f7ff 448be0 mov r12d, eax
0108f802 8b5e08 mov ebx, dword ptr [rsi + 8]
0108f805 85db test ebx, ebx
0108f807 7436 je 0x14108f83f
0108f809 0f1f8000000000 nop dword ptr [rax]
0108f810 418bc4 mov eax, r12d
0108f813 488d0c40 lea rcx, [rax + rax*2]
0108f817 488d560c lea rdx, [rsi + 0xc]
0108f81b 488d14ca lea rdx, [rdx + rcx*8]
0108f81f 41b810000000 mov r8d, 0x10
0108f825 498d8f60100000 lea rcx, [r15 + 0x1060]
0108f82c e863d47000 call 0x14179cc94
0108f831 85c0 test eax, eax
0108f833 7414 je 0x14108f849
0108f835 7808 js 0x14108f83f
0108f837 41ffc4 inc r12d
0108f83a 443be3 cmp r12d, ebx
0108f83d 72d1 jb 0x14108f810
0108f83f bbd5ffffff mov ebx, 0xffffffd5
0108f844 e9ba0e0000 jmp 0x141090703
0108f849 498d4f50 lea rcx, [r15 + 0x50]
0108f84d 0fb701 movzx eax, word ptr [rcx]
0108f850 baff000000 mov edx, 0xff
0108f855 6685c0 test ax, ax
0108f858 744b je 0x14108f8a5
0108f85a 4885c9 test rcx, rcx
0108f85d 7460 je 0x14108f8bf
0108f85f 4883c102 add rcx, 2
0108f863 3bc2 cmp eax, edx
0108f865 7610 jbe 0x14108f877
0108f867 66899580010000 mov word ptr [rbp + 0x180], dx
0108f86e 488d9582010000 lea rdx, [rbp + 0x182]
0108f875 eb19 jmp 0x14108f890
0108f877 66898580010000 mov word ptr [rbp + 0x180], ax
0108f87e 488d9582010000 lea rdx, [rbp + 0x182]
0108f885 8d78ff lea edi, [rax - 1]
0108f888 85ff test edi, edi
0108f88a 7833 js 0x14108f8bf
0108f88c 0f1f4000 nop dword ptr [rax]
0108f890 0fb701 movzx eax, word ptr [rcx]
0108f893 488d4902 lea rcx, [rcx + 2]
0108f897 668902 mov word ptr [rdx], ax
0108f89a 488d5202 lea rdx, [rdx + 2]
0108f89e 83ef01 sub edi, 1
0108f8a1 79ed jns 0x14108f890
0108f8a3 eb1a jmp 0x14108f8bf
0108f8a5 498d9780100000 lea rdx, [r15 + 0x1080]
0108f8ac 4c8d8d80010000 lea r9, [rbp + 0x180]
0108f8b3 4c8d8550040000 lea r8, [rbp + 0x450]
0108f8ba e811cedfff call 0x140e8c6d0
0108f8bf 41b96d616e61 mov r9d, 0x616e616d
0108f8c5 4533c0 xor r8d, r8d
0108f8c8 418bd4 mov edx, r12d
0108f8cb 498bcd mov rcx, r13
0108f8ce 6644398580010000 cmp word ptr [rbp + 0x180], r8w
0108f8d6 7413 je 0x14108f8eb
0108f8d8 488d8580010000 lea rax, [rbp + 0x180]
0108f8df 4889442420 mov qword ptr [rsp + 0x20], rax
0108f8e4 e8a7980c00 call 0x141159190
0108f8e9 eb05 jmp 0x14108f8f0
0108f8eb e8c09a0c00 call 0x1411593b0
0108f8f0 8bd8 mov ebx, eax
0108f8f2 85c0 test eax, eax
0108f8f4 0f85090e0000 jne 0x141090703
0108f8fa 488b7c2450 mov rdi, qword ptr [rsp + 0x50]
0108f8ff 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
0108f906 480550020000 add rax, 0x250
0108f90c 41b968747561 mov r9d, 0x61757468
0108f912 4533c0 xor r8d, r8d
0108f915 418bd4 mov edx, r12d
0108f918 498bcd mov rcx, r13
0108f91b 66443900 cmp word ptr [rax], r8w
0108f91f 740c je 0x14108f92d
0108f921 4889442420 mov qword ptr [rsp + 0x20], rax
0108f926 e865980c00 call 0x141159190
0108f92b eb05 jmp 0x14108f932
0108f92d e87e9a0c00 call 0x1411593b0
0108f932 8bd8 mov ebx, eax
0108f934 85c0 test eax, eax
0108f936 0f85c70d0000 jne 0x141090703
0108f93c 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
0108f943 480550060000 add rax, 0x650
0108f949 41b9706d6f63 mov r9d, 0x636f6d70
0108f94f 4533c0 xor r8d, r8d
0108f952 418bd4 mov edx, r12d
0108f955 498bcd mov rcx, r13
0108f958 66443900 cmp word ptr [rax], r8w
0108f95c 740c je 0x14108f96a
0108f95e 4889442420 mov qword ptr [rsp + 0x20], rax
0108f963 e828980c00 call 0x141159190
0108f968 eb05 jmp 0x14108f96f
0108f96a e8419a0c00 call 0x1411593b0
0108f96f 8bd8 mov ebx, eax
0108f971 85c0 test eax, eax
0108f973 0f858a0d0000 jne 0x141090703
0108f979 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
0108f980 480550080000 add rax, 0x850
0108f986 41b965726e67 mov r9d, 0x676e7265
0108f98c 4533c0 xor r8d, r8d
0108f98f 418bd4 mov edx, r12d
0108f992 498bcd mov rcx, r13
0108f995 66443900 cmp word ptr [rax], r8w
0108f999 740c je 0x14108f9a7
0108f99b 4889442420 mov qword ptr [rsp + 0x20], rax
0108f9a0 e8eb970c00 call 0x141159190
0108f9a5 eb05 jmp 0x14108f9ac
0108f9a7 e8049a0c00 call 0x1411593b0
0108f9ac 8bd8 mov ebx, eax
0108f9ae 85c0 test eax, eax
0108f9b0 0f854d0d0000 jne 0x141090703
0108f9b6 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
0108f9bd 8b88500a0000 mov ecx, dword ptr [rax + 0xa50]
0108f9c3 85c9 test ecx, ecx
0108f9c5 7443 je 0x14108fa0a
0108f9c7 4d85ed test r13, r13
0108f9ca 7437 je 0x14108fa03
0108f9cc 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108f9d4 752d jne 0x14108fa03
0108f9d6 0fc9 bswap ecx
0108f9d8 894c2430 mov dword ptr [rsp + 0x30], ecx
0108f9dc c744242004000000 mov dword ptr [rsp + 0x20], 4
0108f9e4 4c8d4c2430 lea r9, [rsp + 0x30]
0108f9e9 41b872616579 mov r8d, 0x79656172
0108f9ef 418bd4 mov edx, r12d
0108f9f2 498bcd mov rcx, r13
0108f9f5 e8d6a10c00 call 0x141159bd0
0108f9fa 418985d4080000 mov dword ptr [r13 + 0x8d4], eax
0108fa01 eb1b jmp 0x14108fa1e
0108fa03 bbceffffff mov ebx, 0xffffffce
0108fa08 eb16 jmp 0x14108fa20
0108fa0a 41b972616579 mov r9d, 0x79656172
0108fa10 4533c0 xor r8d, r8d
0108fa13 418bd4 mov edx, r12d
0108fa16 498bcd mov rcx, r13
0108fa19 e892990c00 call 0x1411593b0
0108fa1e 8bd8 mov ebx, eax
0108fa20 85db test ebx, ebx
0108fa22 0f85db0c0000 jne 0x141090703
0108fa28 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
0108fa2f 0fb78874100000 movzx ecx, word ptr [rax + 0x1074]
0108fa36 85c9 test ecx, ecx
0108fa38 7443 je 0x14108fa7d
0108fa3a 4d85ed test r13, r13
0108fa3d 7437 je 0x14108fa76
0108fa3f 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108fa47 752d jne 0x14108fa76
0108fa49 0fc9 bswap ecx
0108fa4b 894c2430 mov dword ptr [rsp + 0x30], ecx
0108fa4f c744242004000000 mov dword ptr [rsp + 0x20], 4
0108fa57 4c8d4c2430 lea r9, [rsp + 0x30]
0108fa5c 41b86d756e64 mov r8d, 0x646e756d
0108fa62 418bd4 mov edx, r12d
0108fa65 498bcd mov rcx, r13
0108fa68 e863a10c00 call 0x141159bd0
0108fa6d 418985d4080000 mov dword ptr [r13 + 0x8d4], eax
0108fa74 eb1b jmp 0x14108fa91
0108fa76 bbceffffff mov ebx, 0xffffffce
0108fa7b eb16 jmp 0x14108fa93
0108fa7d 41b96d756e64 mov r9d, 0x646e756d
0108fa83 4533c0 xor r8d, r8d
0108fa86 418bd4 mov edx, r12d
0108fa89 498bcd mov rcx, r13
0108fa8c e81f990c00 call 0x1411593b0
0108fa91 8bd8 mov ebx, eax
0108fa93 85db test ebx, ebx
0108fa95 0f85680c0000 jne 0x141090703
0108fa9b 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
0108faa2 0fb78876100000 movzx ecx, word ptr [rax + 0x1076]
0108faa9 85c9 test ecx, ecx
0108faab 7443 je 0x14108faf0
0108faad 4d85ed test r13, r13
0108fab0 7437 je 0x14108fae9
0108fab2 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108faba 752d jne 0x14108fae9
0108fabc 0fc9 bswap ecx
0108fabe 894c2430 mov dword ptr [rsp + 0x30], ecx
0108fac2 c744242004000000 mov dword ptr [rsp + 0x20], 4
0108faca 4c8d4c2430 lea r9, [rsp + 0x30]
0108facf 41b8746e6364 mov r8d, 0x64636e74
0108fad5 418bd4 mov edx, r12d
0108fad8 498bcd mov rcx, r13
0108fadb e8f0a00c00 call 0x141159bd0
0108fae0 418985d4080000 mov dword ptr [r13 + 0x8d4], eax
0108fae7 eb1b jmp 0x14108fb04
0108fae9 bbceffffff mov ebx, 0xffffffce
0108faee eb16 jmp 0x14108fb06
0108faf0 41b9746e6364 mov r9d, 0x64636e74
0108faf6 4533c0 xor r8d, r8d
0108faf9 418bd4 mov edx, r12d
0108fafc 498bcd mov rcx, r13
0108faff e8ac980c00 call 0x1411593b0
0108fb04 8bd8 mov ebx, eax
0108fb06 85db test ebx, ebx
0108fb08 0f85f50b0000 jne 0x141090703
0108fb0e 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
0108fb15 0fb68871100000 movzx ecx, byte ptr [rax + 0x1071]
0108fb1c 4d85ed test r13, r13
0108fb1f 0f84d90b0000 je 0x1410906fe
0108fb25 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108fb2d 0f85cb0b0000 jne 0x1410906fe
0108fb33 0fc9 bswap ecx
0108fb35 894c2430 mov dword ptr [rsp + 0x30], ecx
0108fb39 c744242004000000 mov dword ptr [rsp + 0x20], 4
0108fb41 4c8d4c2430 lea r9, [rsp + 0x30]
0108fb46 41b86c706d63 mov r8d, 0x636d706c
0108fb4c 418bd4 mov edx, r12d
0108fb4f 498bcd mov rcx, r13
0108fb52 e879a00c00 call 0x141159bd0
0108fb57 8bd8 mov ebx, eax
0108fb59 418985d4080000 mov dword ptr [r13 + 0x8d4], eax
0108fb60 85c0 test eax, eax
0108fb62 0f859b0b0000 jne 0x141090703
0108fb68 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
0108fb6f 0fb68872100000 movzx ecx, byte ptr [rax + 0x1072]
0108fb76 4d85ed test r13, r13
0108fb79 0f847f0b0000 je 0x1410906fe
0108fb7f 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108fb87 0f85710b0000 jne 0x1410906fe
0108fb8d 0fc9 bswap ecx
0108fb8f 894c2430 mov dword ptr [rsp + 0x30], ecx
0108fb93 c744242004000000 mov dword ptr [rsp + 0x20], 4
0108fb9b 4c8d4c2430 lea r9, [rsp + 0x30]
0108fba0 41b861706167 mov r8d, 0x67617061
0108fba6 418bd4 mov edx, r12d
0108fba9 498bcd mov rcx, r13
0108fbac e81fa00c00 call 0x141159bd0
0108fbb1 8bd8 mov ebx, eax
0108fbb3 418985d4080000 mov dword ptr [r13 + 0x8d4], eax
0108fbba 85c0 test eax, eax
0108fbbc 0f85410b0000 jne 0x141090703
0108fbc2 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
0108fbc9 48055c0a0000 add rax, 0xa5c
0108fbcf 41b96469656d mov r9d, 0x6d656964
0108fbd5 4533c0 xor r8d, r8d
0108fbd8 418bd4 mov edx, r12d
0108fbdb 498bcd mov rcx, r13
0108fbde 66443900 cmp word ptr [rax], r8w
0108fbe2 740c je 0x14108fbf0
0108fbe4 4889442420 mov qword ptr [rsp + 0x20], rax
0108fbe9 e8a2950c00 call 0x141159190
0108fbee eb05 jmp 0x14108fbf5
0108fbf0 e8bb970c00 call 0x1411593b0
0108fbf5 8bd8 mov ebx, eax
0108fbf7 85c0 test eax, eax
0108fbf9 0f85040b0000 jne 0x141090703
0108fbff 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
0108fc06 48055c0c0000 add rax, 0xc5c
0108fc0c 41b96469756d mov r9d, 0x6d756964
0108fc12 4533c0 xor r8d, r8d
0108fc15 418bd4 mov edx, r12d
0108fc18 498bcd mov rcx, r13
0108fc1b 66443900 cmp word ptr [rax], r8w
0108fc1f 740c je 0x14108fc2d
0108fc21 4889442420 mov qword ptr [rsp + 0x20], rax
0108fc26 e865950c00 call 0x141159190
0108fc2b eb05 jmp 0x14108fc32
0108fc2d e87e970c00 call 0x1411593b0
0108fc32 8bd8 mov ebx, eax
0108fc34 85c0 test eax, eax
0108fc36 0f85c70a0000 jne 0x141090703
0108fc3c bf01000000 mov edi, 1
0108fc41 33f6 xor esi, esi
0108fc43 8bde mov ebx, esi
0108fc45 448b742440 mov r14d, dword ptr [rsp + 0x40]
0108fc4a 4585f6 test r14d, r14d
0108fc4d 0f84e0000000 je 0x14108fd33
0108fc53 4c8b7c2448 mov r15, qword ptr [rsp + 0x48]
0108fc58 0f1f840000000000 nop dword ptr [rax + rax]
0108fc60 448bcb mov r9d, ebx
0108fc63 4533c0 xor r8d, r8d
0108fc66 ba73000000 mov edx, 0x73
0108fc6b 498b8f08040000 mov rcx, qword ptr [r15 + 0x408]
0108fc72 e84972edff call 0x140f66ec0
0108fc77 4885c0 test rax, rax
0108fc7a 7409 je 0x14108fc85
0108fc7c 0fb7cf movzx ecx, di
0108fc7f 66ffc7 inc di
0108fc82 89482c mov dword ptr [rax + 0x2c], ecx
0108fc85 ffc3 inc ebx
0108fc87 413bde cmp ebx, r14d
0108fc8a 72d4 jb 0x14108fc60
0108fc8c 8bfe mov edi, esi
0108fc8e 488db581030000 lea rsi, [rbp + 0x381]
0108fc95 448bcf mov r9d, edi
0108fc98 4533c0 xor r8d, r8d
0108fc9b ba01000000 mov edx, 1
0108fca0 498b8f08040000 mov rcx, qword ptr [r15 + 0x408]
0108fca7 e81472edff call 0x140f66ec0
0108fcac 488bd8 mov rbx, rax
0108fcaf 4885c0 test rax, rax
0108fcb2 7470 je 0x14108fd24
0108fcb4 f6404b01 test byte ptr [rax + 0x4b], 1
0108fcb8 754f jne 0x14108fd09
0108fcba 488b5030 mov rdx, qword ptr [rax + 0x30]
0108fcbe 4885d2 test rdx, rdx
0108fcc1 7446 je 0x14108fd09
0108fcc3 488b08 mov rcx, qword ptr [rax]
0108fcc6 e815dcf2ff call 0x140fbd8e0
0108fccb 84c0 test al, al
0108fccd 743a je 0x14108fd09
0108fccf 48837a1000 cmp qword ptr [rdx + 0x10], 0
0108fcd4 742d je 0x14108fd03
0108fcd6 f6829a00000004 test byte ptr [rdx + 0x9a], 4
0108fcdd 7424 je 0x14108fd03
0108fcdf 488b054a720101 mov rax, qword ptr [rip + 0x101724a]
0108fce6 4885c0 test rax, rax
0108fce9 7409 je 0x14108fcf4
0108fceb 488b8890410100 mov rcx, qword ptr [rax + 0x14190]
0108fcf2 eb02 jmp 0x14108fcf6
0108fcf4 33c9 xor ecx, ecx
0108fcf6 80b98b05000000 cmp byte ptr [rcx + 0x58b], 0
0108fcfd 7504 jne 0x14108fd03
0108fcff b001 mov al, 1
0108fd01 eb02 jmp 0x14108fd05
0108fd03 32c0 xor al, al
0108fd05 84c0 test al, al
0108fd07 7510 jne 0x14108fd19
0108fd09 488bcb mov rcx, rbx
0108fd0c e8afd9f2ff call 0x140fbd6c0
0108fd11 84c0 test al, al
0108fd13 7504 jne 0x14108fd19
0108fd15 b001 mov al, 1
0108fd17 eb02 jmp 0x14108fd1b
0108fd19 32c0 xor al, al
0108fd1b 8846ff mov byte ptr [rsi - 1], al
0108fd1e 0fb6432c movzx eax, byte ptr [rbx + 0x2c]
0108fd22 8806 mov byte ptr [rsi], al
0108fd24 ffc7 inc edi
0108fd26 4883c602 add rsi, 2
0108fd2a 413bfe cmp edi, r14d
0108fd2d 0f8262ffffff jb 0x14108fc95
0108fd33 438d0436 lea eax, [r14 + r14]
0108fd37 89442420 mov dword ptr [rsp + 0x20], eax
0108fd3b 4c8d8d80030000 lea r9, [rbp + 0x380]
0108fd42 41b8676f7270 mov r8d, 0x70726f67
0108fd48 418bd4 mov edx, r12d
0108fd4b 498bcd mov rcx, r13
0108fd4e e87d9e0c00 call 0x141159bd0
0108fd53 8bd8 mov ebx, eax
0108fd55 85c0 test eax, eax
0108fd57 0f85a6090000 jne 0x141090703
0108fd5d 33ff xor edi, edi
0108fd5f 66897c2458 mov word ptr [rsp + 0x58], di
0108fd64 448bff mov r15d, edi
0108fd67 4585f6 test r14d, r14d
0108fd6a 0f8493090000 je 0x141090703
0108fd70 f30f1035e045be00 movss xmm6, dword ptr [rip + 0xbe45e0]
0108fd78 f30f103da834be00 movss xmm7, dword ptr [rip + 0xbe34a8]
0108fd80 f3440f10053b46be00 movss xmm8, dword ptr [rip + 0xbe463b]
0108fd89 0f1f8000000000 nop dword ptr [rax]
0108fd90 458bcf mov r9d, r15d
0108fd93 4533c0 xor r8d, r8d
0108fd96 ba73000000 mov edx, 0x73
0108fd9b 488b442448 mov rax, qword ptr [rsp + 0x48]
0108fda0 488b8808040000 mov rcx, qword ptr [rax + 0x408]
0108fda7 e81471edff call 0x140f66ec0
0108fdac 4c8bf0 mov r14, rax
0108fdaf 4885c0 test rax, rax
0108fdb2 0f842a090000 je 0x1410906e2
0108fdb8 488b08 mov rcx, qword ptr [rax]
0108fdbb 4885c9 test rcx, rcx
0108fdbe 0f841e090000 je 0x1410906e2
0108fdc4 813974736c70 cmp dword ptr [rcx], 0x706c7374
0108fdca 0f8512090000 jne 0x1410906e2
0108fdd0 83782800 cmp dword ptr [rax + 0x28], 0
0108fdd4 0f8408090000 je 0x1410906e2
0108fdda 488bc8 mov rcx, rax
0108fddd e8ded8f2ff call 0x140fbd6c0
0108fde2 84c0 test al, al
0108fde4 0f85f8080000 jne 0x1410906e2
0108fdea 498b06 mov rax, qword ptr [r14]
0108fded 4885c0 test rax, rax
0108fdf0 747b je 0x14108fe6d
0108fdf2 813874736c70 cmp dword ptr [rax], 0x706c7374
0108fdf8 7573 jne 0x14108fe6d
0108fdfa 41837e2800 cmp dword ptr [r14 + 0x28], 0
0108fdff 746c je 0x14108fe6d
0108fe01 498b4630 mov rax, qword ptr [r14 + 0x30]
0108fe05 4885c0 test rax, rax
0108fe08 750f jne 0x14108fe19
0108fe0a 488bf7 mov rsi, rdi
0108fe0d 0fb7c7 movzx eax, di
0108fe10 66894580 mov word ptr [rbp - 0x80], ax
0108fe14 e98a000000 jmp 0x14108fea3
0108fe19 4883781000 cmp qword ptr [rax + 0x10], 0
0108fe1e 750f jne 0x14108fe2f
0108fe20 488bf7 mov rsi, rdi
0108fe23 498b5630 mov rdx, qword ptr [r14 + 0x30]
0108fe27 8bc7 mov eax, edi
0108fe29 66894580 mov word ptr [rbp - 0x80], ax
0108fe2d eb51 jmp 0x14108fe80
0108fe2f 488b7058 mov rsi, qword ptr [rax + 0x58]
0108fe33 4885f6 test rsi, rsi
0108fe36 7429 je 0x14108fe61
0108fe38 0f1f840000000000 nop dword ptr [rax + rax]
0108fe40 488b4608 mov rax, qword ptr [rsi + 8]
0108fe44 4885c0 test rax, rax
0108fe47 7410 je 0x14108fe59
0108fe49 4883781000 cmp qword ptr [rax + 0x10], 0
0108fe4e 7409 je 0x14108fe59
0108fe50 817e3444524853 cmp dword ptr [rsi + 0x34], 0x53485244
0108fe57 7508 jne 0x14108fe61
0108fe59 488b36 mov rsi, qword ptr [rsi]
0108fe5c 4885f6 test rsi, rsi
0108fe5f 75df jne 0x14108fe40
0108fe61 498b5630 mov rdx, qword ptr [r14 + 0x30]
0108fe65 8bc7 mov eax, edi
0108fe67 66894580 mov word ptr [rbp - 0x80], ax
0108fe6b eb13 jmp 0x14108fe80
0108fe6d 498b5630 mov rdx, qword ptr [r14 + 0x30]
0108fe71 0fb7c7 movzx eax, di
0108fe74 66894580 mov word ptr [rbp - 0x80], ax
0108fe78 488bf7 mov rsi, rdi
0108fe7b 4885d2 test rdx, rdx
0108fe7e 7423 je 0x14108fea3
0108fe80 488b4a10 mov rcx, qword ptr [rdx + 0x10]
0108fe84 4885c9 test rcx, rcx
0108fe87 741a je 0x14108fea3
0108fe89 4881c178010000 add rcx, 0x178
0108fe90 4c8d4580 lea r8, [rbp - 0x80]
0108fe94 8b92b0000000 mov edx, dword ptr [rdx + 0xb0]
0108fe9a e8d1f5b6ff call 0x140bff470
0108fe9f 0fb74580 movzx eax, word ptr [rbp - 0x80]
0108fea3 440fb74c2458 movzx r9d, word ptr [rsp + 0x58]
0108fea9 0fb7d0 movzx edx, ax
0108feac 33c0 xor eax, eax
0108feae 89442420 mov dword ptr [rsp + 0x20], eax
0108feb2 4c8d44245a lea r8, [rsp + 0x5a]
0108feb7 488d4d82 lea rcx, [rbp - 0x7e]
0108febb e88050a5ff call 0x140ae4f40
0108fec0 41b96d616e74 mov r9d, 0x746e616d
0108fec6 458d4701 lea r8d, [r15 + 1]
0108feca 418bd4 mov edx, r12d
0108fecd 498bcd mov rcx, r13
0108fed0 84c0 test al, al
0108fed2 7407 je 0x14108fedb
0108fed4 e8d7940c00 call 0x1411593b0
0108fed9 eb0e jmp 0x14108fee9
0108fedb 488d4580 lea rax, [rbp - 0x80]
0108fedf 4889442420 mov qword ptr [rsp + 0x20], rax
0108fee4 e8a7920c00 call 0x141159190
0108fee9 8bd8 mov ebx, eax
0108feeb 85c0 test eax, eax
0108feed 0f8510080000 jne 0x141090703
0108fef3 498b5630 mov rdx, qword ptr [r14 + 0x30]
0108fef7 33db xor ebx, ebx
0108fef9 0fb7c3 movzx eax, bx
0108fefc 66895d80 mov word ptr [rbp - 0x80], bx
0108ff00 4885d2 test rdx, rdx
0108ff03 7423 je 0x14108ff28
0108ff05 488b4a10 mov rcx, qword ptr [rdx + 0x10]
0108ff09 4885c9 test rcx, rcx
0108ff0c 741a je 0x14108ff28
0108ff0e 4881c1c0010000 add rcx, 0x1c0
0108ff15 4c8d4580 lea r8, [rbp - 0x80]
0108ff19 8b92bc000000 mov edx, dword ptr [rdx + 0xbc]
0108ff1f e84cf5b6ff call 0x140bff470
0108ff24 0fb74580 movzx eax, word ptr [rbp - 0x80]
0108ff28 440fb78d80010000 movzx r9d, word ptr [rbp + 0x180]
0108ff30 0fb7d0 movzx edx, ax
0108ff33 895c2420 mov dword ptr [rsp + 0x20], ebx
0108ff37 4c8d8582010000 lea r8, [rbp + 0x182]
0108ff3e 488d4d82 lea rcx, [rbp - 0x7e]
0108ff42 e8f94fa5ff call 0x140ae4f40
0108ff47 41b96d616e61 mov r9d, 0x616e616d
0108ff4d 458d4701 lea r8d, [r15 + 1]
0108ff51 418bd4 mov edx, r12d
0108ff54 498bcd mov rcx, r13
0108ff57 84c0 test al, al
0108ff59 7407 je 0x14108ff62
0108ff5b e850940c00 call 0x1411593b0
0108ff60 eb0e jmp 0x14108ff70
0108ff62 488d4580 lea rax, [rbp - 0x80]
0108ff66 4889442420 mov qword ptr [rsp + 0x20], rax
0108ff6b e820920c00 call 0x141159190
0108ff70 8bd8 mov ebx, eax
0108ff72 85c0 test eax, eax
0108ff74 0f8589070000 jne 0x141090703
0108ff7a 498b5630 mov rdx, qword ptr [r14 + 0x30]
0108ff7e 33ff xor edi, edi
0108ff80 0fb7c7 movzx eax, di
0108ff83 66894580 mov word ptr [rbp - 0x80], ax
0108ff87 4885d2 test rdx, rdx
0108ff8a 7423 je 0x14108ffaf
0108ff8c 488b4a10 mov rcx, qword ptr [rdx + 0x10]
0108ff90 4885c9 test rcx, rcx
0108ff93 741a je 0x14108ffaf
0108ff95 4881c150020000 add rcx, 0x250
0108ff9c 4c8d4580 lea r8, [rbp - 0x80]
0108ffa0 8b92c0000000 mov edx, dword ptr [rdx + 0xc0]
0108ffa6 e8c5f4b6ff call 0x140bff470
0108ffab 0fb74580 movzx eax, word ptr [rbp - 0x80]
0108ffaf 440fb78d80010000 movzx r9d, word ptr [rbp + 0x180]
0108ffb7 0fb7d0 movzx edx, ax
0108ffba 897c2420 mov dword ptr [rsp + 0x20], edi
0108ffbe 4c8d8582010000 lea r8, [rbp + 0x182]
0108ffc5 488d4d82 lea rcx, [rbp - 0x7e]
0108ffc9 e8724fa5ff call 0x140ae4f40
0108ffce 41b970757267 mov r9d, 0x67727570
0108ffd4 458d4701 lea r8d, [r15 + 1]
0108ffd8 418bd4 mov edx, r12d
0108ffdb 498bcd mov rcx, r13
0108ffde 84c0 test al, al
0108ffe0 7407 je 0x14108ffe9
0108ffe2 e8c9930c00 call 0x1411593b0
0108ffe7 eb0e jmp 0x14108fff7
0108ffe9 488d4580 lea rax, [rbp - 0x80]
0108ffed 4889442420 mov qword ptr [rsp + 0x20], rax
0108fff2 e899910c00 call 0x141159190
0108fff7 8bd8 mov ebx, eax
0108fff9 85c0 test eax, eax
0108fffb 0f8502070000 jne 0x141090703
01090001 498b5630 mov rdx, qword ptr [r14 + 0x30]
01090005 0fb7c7 movzx eax, di
01090008 66894580 mov word ptr [rbp - 0x80], ax
0109000c 4885d2 test rdx, rdx
0109000f 7423 je 0x141090034
01090011 488b4a10 mov rcx, qword ptr [rdx + 0x10]
01090015 4885c9 test rcx, rcx
01090018 741a je 0x141090034
0109001a 4881c108020000 add rcx, 0x208
01090021 4c8d4580 lea r8, [rbp - 0x80]
01090025 8b92b4000000 mov edx, dword ptr [rdx + 0xb4]
0109002b e840f4b6ff call 0x140bff470
01090030 0fb74580 movzx eax, word ptr [rbp - 0x80]
01090034 488b7c2450 mov rdi, qword ptr [rsp + 0x50]
01090039 4c8b87e8200000 mov r8, qword ptr [rdi + 0x20e8]
01090040 450fb78850020000 movzx r9d, word ptr [r8 + 0x250]
01090048 4981c052020000 add r8, 0x252
0109004f 0fb7d0 movzx edx, ax
01090052 33c0 xor eax, eax
01090054 89442420 mov dword ptr [rsp + 0x20], eax
01090058 488d4d82 lea rcx, [rbp - 0x7e]
0109005c e8df4ea5ff call 0x140ae4f40
01090061 41b968747561 mov r9d, 0x61757468
01090067 458d4701 lea r8d, [r15 + 1]
0109006b 418bd4 mov edx, r12d
0109006e 498bcd mov rcx, r13
01090071 84c0 test al, al
01090073 7407 je 0x14109007c
01090075 e836930c00 call 0x1411593b0
0109007a eb0e jmp 0x14109008a
0109007c 488d4580 lea rax, [rbp - 0x80]
01090080 4889442420 mov qword ptr [rsp + 0x20], rax
01090085 e806910c00 call 0x141159190
0109008a 8bd8 mov ebx, eax
0109008c 85c0 test eax, eax
0109008e 0f856f060000 jne 0x141090703
01090094 498b5630 mov rdx, qword ptr [r14 + 0x30]
01090098 33c0 xor eax, eax
0109009a 66894580 mov word ptr [rbp - 0x80], ax
0109009e 4885d2 test rdx, rdx
010900a1 7423 je 0x1410900c6
010900a3 488b4a10 mov rcx, qword ptr [rdx + 0x10]
010900a7 4885c9 test rcx, rcx
010900aa 741a je 0x1410900c6
010900ac 4881c108020000 add rcx, 0x208
010900b3 4c8d4580 lea r8, [rbp - 0x80]
010900b7 8b92b8000000 mov edx, dword ptr [rdx + 0xb8]
010900bd e8aef3b6ff call 0x140bff470
010900c2 0fb74580 movzx eax, word ptr [rbp - 0x80]
010900c6 440fb74c2458 movzx r9d, word ptr [rsp + 0x58]
010900cc 0fb7d0 movzx edx, ax
010900cf 33c0 xor eax, eax
010900d1 89442420 mov dword ptr [rsp + 0x20], eax
010900d5 4c8d44245a lea r8, [rsp + 0x5a]
010900da 488d4d82 lea rcx, [rbp - 0x7e]
010900de e85d4ea5ff call 0x140ae4f40
010900e3 41b974756161 mov r9d, 0x61617574
010900e9 458d4701 lea r8d, [r15 + 1]
010900ed 418bd4 mov edx, r12d
010900f0 498bcd mov rcx, r13
010900f3 84c0 test al, al
010900f5 7407 je 0x1410900fe
010900f7 e8b4920c00 call 0x1411593b0
010900fc eb0e jmp 0x14109010c
010900fe 488d4580 lea rax, [rbp - 0x80]
01090102 4889442420 mov qword ptr [rsp + 0x20], rax
01090107 e884900c00 call 0x141159190
0109010c 8bd8 mov ebx, eax
0109010e 85c0 test eax, eax
01090110 0f85ed050000 jne 0x141090703
01090116 498b5630 mov rdx, qword ptr [r14 + 0x30]
0109011a 33c0 xor eax, eax
0109011c 66894580 mov word ptr [rbp - 0x80], ax
01090120 4885d2 test rdx, rdx
01090123 7423 je 0x141090148
01090125 488b4a10 mov rcx, qword ptr [rdx + 0x10]
01090129 4885c9 test rcx, rcx
0109012c 741a je 0x141090148
0109012e 4881c108020000 add rcx, 0x208
01090135 4c8d4580 lea r8, [rbp - 0x80]
01090139 8b92c4000000 mov edx, dword ptr [rdx + 0xc4]
0109013f e82cf3b6ff call 0x140bff470
01090144 0fb74580 movzx eax, word ptr [rbp - 0x80]
01090148 4c8b87e8200000 mov r8, qword ptr [rdi + 0x20e8]
0109014f 450fb78850060000 movzx r9d, word ptr [r8 + 0x650]
01090157 4981c052060000 add r8, 0x652
0109015e 0fb7d0 movzx edx, ax
01090161 33c0 xor eax, eax
01090163 89442420 mov dword ptr [rsp + 0x20], eax
01090167 488d4d82 lea rcx, [rbp - 0x7e]
0109016b e8d04da5ff call 0x140ae4f40
01090170 41b9706d6f63 mov r9d, 0x636f6d70
01090176 458d4701 lea r8d, [r15 + 1]
0109017a 418bd4 mov edx, r12d
0109017d 498bcd mov rcx, r13
01090180 84c0 test al, al
01090182 7407 je 0x14109018b
01090184 e827920c00 call 0x1411593b0
01090189 eb0e jmp 0x141090199
0109018b 488d4580 lea rax, [rbp - 0x80]
0109018f 4889442420 mov qword ptr [rsp + 0x20], rax
01090194 e8f78f0c00 call 0x141159190
01090199 8bd8 mov ebx, eax
0109019b 85c0 test eax, eax
0109019d 0f8560050000 jne 0x141090703
010901a3 498b5630 mov rdx, qword ptr [r14 + 0x30]
010901a7 33c0 xor eax, eax
010901a9 66894580 mov word ptr [rbp - 0x80], ax
010901ad 4885d2 test rdx, rdx
010901b0 7423 je 0x1410901d5
010901b2 488b4a10 mov rcx, qword ptr [rdx + 0x10]
010901b6 4885c9 test rcx, rcx
010901b9 741a je 0x1410901d5
010901bb 4881c128030000 add rcx, 0x328
010901c2 4c8d4580 lea r8, [rbp - 0x80]
010901c6 8b92c8000000 mov edx, dword ptr [rdx + 0xc8]
010901cc e89ff2b6ff call 0x140bff470
010901d1 0fb74580 movzx eax, word ptr [rbp - 0x80]
010901d5 4c8b87e8200000 mov r8, qword ptr [rdi + 0x20e8]
010901dc 450fb78850080000 movzx r9d, word ptr [r8 + 0x850]
010901e4 4981c052080000 add r8, 0x852
010901eb 0fb7d0 movzx edx, ax
010901ee 33c0 xor eax, eax
010901f0 89442420 mov dword ptr [rsp + 0x20], eax
010901f4 488d4d82 lea rcx, [rbp - 0x7e]
010901f8 e8434da5ff call 0x140ae4f40
010901fd 41b965726e67 mov r9d, 0x676e7265
01090203 458d4701 lea r8d, [r15 + 1]
01090207 418bd4 mov edx, r12d
0109020a 498bcd mov rcx, r13
0109020d 84c0 test al, al
0109020f 7407 je 0x141090218
01090211 e89a910c00 call 0x1411593b0
01090216 eb0e jmp 0x141090226
01090218 488d4580 lea rax, [rbp - 0x80]
0109021c 4889442420 mov qword ptr [rsp + 0x20], rax
01090221 e86a8f0c00 call 0x141159190
01090226 8bd8 mov ebx, eax
01090228 85c0 test eax, eax
0109022a 0f85d3040000 jne 0x141090703
01090230 498b5630 mov rdx, qword ptr [r14 + 0x30]
01090234 33c0 xor eax, eax
01090236 66894580 mov word ptr [rbp - 0x80], ax
0109023a 4885d2 test rdx, rdx
0109023d 7423 je 0x141090262
0109023f 488b4a10 mov rcx, qword ptr [rdx + 0x10]
01090243 4885c9 test rcx, rcx
01090246 741a je 0x141090262
01090248 4881c100040000 add rcx, 0x400
0109024f 4c8d4580 lea r8, [rbp - 0x80]
01090253 8b92d4000000 mov edx, dword ptr [rdx + 0xd4]
01090259 e812f2b6ff call 0x140bff470
0109025e 0fb74580 movzx eax, word ptr [rbp - 0x80]
01090262 440fb74c2458 movzx r9d, word ptr [rsp + 0x58]
01090268 0fb7d0 movzx edx, ax
0109026b 33c0 xor eax, eax
0109026d 89442420 mov dword ptr [rsp + 0x20], eax
01090271 4c8d44245a lea r8, [rsp + 0x5a]
01090276 488d4d82 lea rcx, [rbp - 0x7e]
0109027a e8c14ca5ff call 0x140ae4f40
0109027f 41b9746e6d63 mov r9d, 0x636d6e74
01090285 458d4701 lea r8d, [r15 + 1]
01090289 418bd4 mov edx, r12d
0109028c 498bcd mov rcx, r13
0109028f 84c0 test al, al
01090291 7407 je 0x14109029a
01090293 e818910c00 call 0x1411593b0
01090298 eb0e jmp 0x1410902a8
0109029a 488d4580 lea rax, [rbp - 0x80]
0109029e 4889442420 mov qword ptr [rsp + 0x20], rax
010902a3 e8e88e0c00 call 0x141159190
010902a8 8bd8 mov ebx, eax
010902aa 85c0 test eax, eax
010902ac 0f8551040000 jne 0x141090703
010902b2 498b4630 mov rax, qword ptr [r14 + 0x30]
010902b6 4885c0 test rax, rax
010902b9 7428 je 0x1410902e3
010902bb 4883781000 cmp qword ptr [rax + 0x10], 0
010902c0 7421 je 0x1410902e3
010902c2 0fbf8002010000 movsx eax, word ptr [rax + 0x102]
010902c9 660f6ec0 movd xmm0, eax
010902cd 0f5bc0 cvtdq2ps xmm0, xmm0
010902d0 f30f5ec6 divss xmm0, xmm6
010902d4 f30f58c7 addss xmm0, xmm7
010902d8 f3410f59c0 mulss xmm0, xmm8
010902dd f30f2cc0 cvttss2si eax, xmm0
010902e1 eb02 jmp 0x1410902e5
010902e3 33c0 xor eax, eax
010902e5 458d4701 lea r8d, [r15 + 1]
010902e9 89442420 mov dword ptr [rsp + 0x20], eax
010902ed 41b96d6c6f76 mov r9d, 0x766f6c6d
010902f3 418bd4 mov edx, r12d
010902f6 498bcd mov rcx, r13
010902f9 e8f28f0c00 call 0x1411592f0
010902fe 8bd8 mov ebx, eax
01090300 85c0 test eax, eax
01090302 0f85fb030000 jne 0x141090703
01090308 498b4630 mov rax, qword ptr [r14 + 0x30]
0109030c 0fb788a6000000 movzx ecx, word ptr [rax + 0xa6]
01090313 458d4701 lea r8d, [r15 + 1]
01090317 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
0109031e 3b88500a0000 cmp ecx, dword ptr [rax + 0xa50]
01090324 741b je 0x141090341
01090326 85c9 test ecx, ecx
01090328 7417 je 0x141090341
0109032a 894c2420 mov dword ptr [rsp + 0x20], ecx
0109032e 41b972616579 mov r9d, 0x79656172
01090334 418bd4 mov edx, r12d
01090337 498bcd mov rcx, r13
0109033a e8b18f0c00 call 0x1411592f0
0109033f eb11 jmp 0x141090352
01090341 41b972616579 mov r9d, 0x79656172
01090347 418bd4 mov edx, r12d
0109034a 498bcd mov rcx, r13
0109034d e85e900c00 call 0x1411593b0
01090352 8bd8 mov ebx, eax
01090354 85c0 test eax, eax
01090356 0f85a7030000 jne 0x141090703
0109035c 498b4630 mov rax, qword ptr [r14 + 0x30]
01090360 0fb7882c010000 movzx ecx, word ptr [rax + 0x12c]
01090367 458d4701 lea r8d, [r15 + 1]
0109036b 41b974616562 mov r9d, 0x62656174
01090371 418bd4 mov edx, r12d
01090374 85c9 test ecx, ecx
01090376 740e je 0x141090386
01090378 894c2420 mov dword ptr [rsp + 0x20], ecx
0109037c 498bcd mov rcx, r13
0109037f e86c8f0c00 call 0x1411592f0
01090384 eb08 jmp 0x14109038e
01090386 498bcd mov rcx, r13
01090389 e822900c00 call 0x1411593b0
0109038e 8bd8 mov ebx, eax
01090390 85c0 test eax, eax
01090392 0f856b030000 jne 0x141090703
01090398 498b4630 mov rax, qword ptr [r14 + 0x30]
0109039c 488b4878 mov rcx, qword ptr [rax + 0x78]
010903a0 8b4104 mov eax, dword ptr [rcx + 4]
010903a3 458d4701 lea r8d, [r15 + 1]
010903a7 83f8ff cmp eax, -1
010903aa 741b je 0x1410903c7
010903ac 85c0 test eax, eax
010903ae 7417 je 0x1410903c7
010903b0 89442420 mov dword ptr [rsp + 0x20], eax
010903b4 41b974727473 mov r9d, 0x73747274
010903ba 418bd4 mov edx, r12d
010903bd 498bcd mov rcx, r13
010903c0 e82b8f0c00 call 0x1411592f0
010903c5 eb11 jmp 0x1410903d8
010903c7 41b974727473 mov r9d, 0x73747274
010903cd 418bd4 mov edx, r12d
010903d0 498bcd mov rcx, r13
010903d3 e8d88f0c00 call 0x1411593b0
010903d8 8bd8 mov ebx, eax
010903da 85c0 test eax, eax
010903dc 0f8521030000 jne 0x141090703
010903e2 498b4630 mov rax, qword ptr [r14 + 0x30]
010903e6 488b4878 mov rcx, qword ptr [rax + 0x78]
010903ea 8b4108 mov eax, dword ptr [rcx + 8]
010903ed 458d4701 lea r8d, [r15 + 1]
010903f1 83f8ff cmp eax, -1
010903f4 741b je 0x141090411
010903f6 85c0 test eax, eax
010903f8 7417 je 0x141090411
010903fa 89442420 mov dword ptr [rsp + 0x20], eax
010903fe 41b9706f7473 mov r9d, 0x73746f70
01090404 418bd4 mov edx, r12d
01090407 498bcd mov rcx, r13
0109040a e8e18e0c00 call 0x1411592f0
0109040f eb11 jmp 0x141090422
01090411 41b9706f7473 mov r9d, 0x73746f70
01090417 418bd4 mov edx, r12d
0109041a 498bcd mov rcx, r13
0109041d e88e8f0c00 call 0x1411593b0
01090422 8bd8 mov ebx, eax
01090424 85c0 test eax, eax
01090426 0f85d7020000 jne 0x141090703
0109042c 498b4630 mov rax, qword ptr [r14 + 0x30]
01090430 0fb7900e010000 movzx edx, word ptr [rax + 0x10e]
01090437 458d4701 lea r8d, [r15 + 1]
0109043b 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
01090442 0fb78874100000 movzx ecx, word ptr [rax + 0x1074]
01090449 3bd1 cmp edx, ecx
0109044b 741b je 0x141090468
0109044d 85d2 test edx, edx
0109044f 7417 je 0x141090468
01090451 89542420 mov dword ptr [rsp + 0x20], edx
01090455 41b96d756e64 mov r9d, 0x646e756d
0109045b 418bd4 mov edx, r12d
0109045e 498bcd mov rcx, r13
01090461 e88a8e0c00 call 0x1411592f0
01090466 eb11 jmp 0x141090479
01090468 41b96d756e64 mov r9d, 0x646e756d
0109046e 418bd4 mov edx, r12d
01090471 498bcd mov rcx, r13
01090474 e8378f0c00 call 0x1411593b0
01090479 8bd8 mov ebx, eax
0109047b 85c0 test eax, eax
0109047d 0f8580020000 jne 0x141090703
01090483 498b4630 mov rax, qword ptr [r14 + 0x30]
01090487 0fb79010010000 movzx edx, word ptr [rax + 0x110]
0109048e 458d4701 lea r8d, [r15 + 1]
01090492 488b87e8200000 mov rax, qword ptr [rdi + 0x20e8]
01090499 0fb78876100000 movzx ecx, word ptr [rax + 0x1076]
010904a0 3bd1 cmp edx, ecx
010904a2 741b je 0x1410904bf
010904a4 85d2 test edx, edx
010904a6 7417 je 0x1410904bf
010904a8 89542420 mov dword ptr [rsp + 0x20], edx
010904ac 41b9746e6364 mov r9d, 0x64636e74
010904b2 418bd4 mov edx, r12d
010904b5 498bcd mov rcx, r13
010904b8 e8338e0c00 call 0x1411592f0
010904bd eb11 jmp 0x1410904d0
010904bf 41b9746e6364 mov r9d, 0x64636e74
010904c5 418bd4 mov edx, r12d
010904c8 498bcd mov rcx, r13
010904cb e8e08e0c00 call 0x1411593b0
010904d0 8bd8 mov ebx, eax
010904d2 85c0 test eax, eax
010904d4 0f8529020000 jne 0x141090703
010904da 498b4630 mov rax, qword ptr [r14 + 0x30]
010904de 0fb6889b000000 movzx ecx, byte ptr [rax + 0x9b]
010904e5 c1e902 shr ecx, 2
010904e8 83e101 and ecx, 1
010904eb 458d4701 lea r8d, [r15 + 1]
010904ef 894c2420 mov dword ptr [rsp + 0x20], ecx
010904f3 41b96c706d63 mov r9d, 0x636d706c
010904f9 418bd4 mov edx, r12d
010904fc 498bcd mov rcx, r13
010904ff e8ec8d0c00 call 0x1411592f0
01090504 8bd8 mov ebx, eax
01090506 85c0 test eax, eax
01090508 0f85f5010000 jne 0x141090703
0109050e 498b4630 mov rax, qword ptr [r14 + 0x30]
01090512 0fb7882e010000 movzx ecx, word ptr [rax + 0x12e]
01090519 458d4701 lea r8d, [r15 + 1]
0109051d 41b96e696f6a mov r9d, 0x6a6f696e
01090523 418bd4 mov edx, r12d
01090526 85c9 test ecx, ecx
01090528 740e je 0x141090538
0109052a 894c2420 mov dword ptr [rsp + 0x20], ecx
0109052e 498bcd mov rcx, r13
01090531 e8ba8d0c00 call 0x1411592f0
01090536 eb08 jmp 0x141090540
01090538 498bcd mov rcx, r13
0109053b e8708e0c00 call 0x1411593b0
01090540 8bd8 mov ebx, eax
01090542 85c0 test eax, eax
01090544 0f85b9010000 jne 0x141090703
0109054a 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0109054e e85d99e4ff call 0x140ed9eb0
01090553 0fbec8 movsx ecx, al
01090556 458d4701 lea r8d, [r15 + 1]
0109055a 8d4101 lea eax, [rcx + 1]
0109055d 41b974617275 mov r9d, 0x75726174
01090563 418bd4 mov edx, r12d
01090566 83f801 cmp eax, 1
01090569 760e jbe 0x141090579
0109056b 894c2420 mov dword ptr [rsp + 0x20], ecx
0109056f 498bcd mov rcx, r13
01090572 e8798d0c00 call 0x1411592f0
01090577 eb08 jmp 0x141090581
01090579 498bcd mov rcx, r13
0109057c e82f8e0c00 call 0x1411593b0
01090581 8bd8 mov ebx, eax
01090583 85c0 test eax, eax
01090585 0f8578010000 jne 0x141090703
0109058b 498b4630 mov rax, qword ptr [r14 + 0x30]
0109058f 0fb6889c000000 movzx ecx, byte ptr [rax + 0x9c]
01090596 83e101 and ecx, 1
01090599 458d4701 lea r8d, [r15 + 1]
0109059d 894c2420 mov dword ptr [rsp + 0x20], ecx
010905a1 41b961706167 mov r9d, 0x67617061
010905a7 418bd4 mov edx, r12d
010905aa 498bcd mov rcx, r13
010905ad e83e8d0c00 call 0x1411592f0
010905b2 8bd8 mov ebx, eax
010905b4 85c0 test eax, eax
010905b6 0f8547010000 jne 0x141090703
010905bc 0f57c0 xorps xmm0, xmm0
010905bf f30f7f442430 movdqu xmmword ptr [rsp + 0x30], xmm0
010905c5 488d542430 lea rdx, [rsp + 0x30]
010905ca 488bce mov rcx, rsi
010905cd e8fea8f1ff call 0x140faaed0
010905d2 85c0 test eax, eax
010905d4 0f85fc000000 jne 0x1410906d6
010905da 488b4c2438 mov rcx, qword ptr [rsp + 0x38]
010905df 4885c9 test rcx, rcx
010905e2 7523 jne 0x141090607
010905e4 48394c2430 cmp qword ptr [rsp + 0x30], rcx
010905e9 0f84e7000000 je 0x1410906d6
010905ef 488d4c2430 lea rcx, [rsp + 0x30]
010905f4 e8c7cda4ff call 0x140add3c0
010905f9 488b4c2438 mov rcx, qword ptr [rsp + 0x38]
010905fe 4885c9 test rcx, rcx
01090601 0f84cf000000 je 0x1410906d6
01090607 48833900 cmp qword ptr [rcx], 0
0109060b 0f86c5000000 jbe 0x1410906d6
01090611 488b442430 mov rax, qword ptr [rsp + 0x30]
01090616 4885c0 test rax, rax
01090619 751f jne 0x14109063a
0109061b 488d4c2430 lea rcx, [rsp + 0x30]
01090620 e81bcfa4ff call 0x140add540
01090625 488b442430 mov rax, qword ptr [rsp + 0x30]
0109062a 488b4c2438 mov rcx, qword ptr [rsp + 0x38]
0109062f 4885c0 test rax, rax
01090632 7506 jne 0x14109063a
01090634 33f6 xor esi, esi
01090636 8bd6 mov edx, esi
01090638 eb05 jmp 0x14109063f
0109063a 488b10 mov rdx, qword ptr [rax]
0109063d 33f6 xor esi, esi
0109063f 41b8ff000000 mov r8d, 0xff
01090645 493bd0 cmp rdx, r8
01090648 66410f47d0 cmova dx, r8w
0109064d 66895580 mov word ptr [rbp - 0x80], dx
01090651 4885c0 test rax, rax
01090654 7522 jne 0x141090678
01090656 4885c9 test rcx, rcx
01090659 7414 je 0x14109066f
0109065b 488d4c2430 lea rcx, [rsp + 0x30]
01090660 e8dbcea4ff call 0x140add540
01090665 488b442430 mov rax, qword ptr [rsp + 0x30]
0109066a 4885c0 test rax, rax
0109066d 7509 jne 0x141090678
0109066f 488d15d20c9200 lea rdx, [rip + 0x920cd2]
01090676 eb04 jmp 0x14109067c
01090678 488d500c lea rdx, [rax + 0xc]
0109067c 440fb74580 movzx r8d, word ptr [rbp - 0x80]
01090681 4d03c0 add r8, r8
01090684 488d4d82 lea rcx, [rbp - 0x7e]
01090688 e80dc67000 call 0x14179cc9a
0109068d 440fb74c2458 movzx r9d, word ptr [rsp + 0x58]
01090693 0fb75580 movzx edx, word ptr [rbp - 0x80]
01090697 89742420 mov dword ptr [rsp + 0x20], esi
0109069b 4c8d44245a lea r8, [rsp + 0x5a]
010906a0 488d4d82 lea rcx, [rbp - 0x7e]
010906a4 e89748a5ff call 0x140ae4f40
010906a9 41b964697574 mov r9d, 0x74756964
010906af 458d4701 lea r8d, [r15 + 1]
010906b3 418bd4 mov edx, r12d
010906b6 498bcd mov rcx, r13
010906b9 84c0 test al, al
010906bb 7407 je 0x1410906c4
010906bd e8ee8c0c00 call 0x1411593b0
010906c2 eb0e jmp 0x1410906d2
010906c4 488d4580 lea rax, [rbp - 0x80]
010906c8 4889442420 mov qword ptr [rsp + 0x20], rax
010906cd e8be8a0c00 call 0x141159190
010906d2 85c0 test eax, eax
010906d4 751c jne 0x1410906f2
010906d6 488d4c2430 lea rcx, [rsp + 0x30]
010906db e80063a4ff call 0x140ad69e0
010906e0 33ff xor edi, edi
010906e2 41ffc7 inc r15d
010906e5 443b7c2440 cmp r15d, dword ptr [rsp + 0x40]
010906ea 0f82a0f6ffff jb 0x14108fd90
010906f0 eb11 jmp 0x141090703
010906f2 488d4c2430 lea rcx, [rsp + 0x30]
010906f7 e8e462a4ff call 0x140ad69e0
010906fc eb05 jmp 0x141090703
010906fe bbceffffff mov ebx, 0xffffffce
01090703 488b4c2448 mov rcx, qword ptr [rsp + 0x48]
01090708 e8a35ce6ff call 0x140ef63b0
0109070d 4d85ed test r13, r13
01090710 7434 je 0x141090746
01090712 41817d0062646963 cmp dword ptr [r13], 0x63696462
0109071a 752a jne 0x141090746
0109071c 418b95d4080000 mov edx, dword ptr [r13 + 0x8d4]
01090723 498bcd mov rcx, r13
01090726 e835b00c00 call 0x14115b760
0109072b 498b8db8080000 mov rcx, qword ptr [r13 + 0x8b8]
01090732 4885c9 test rcx, rcx
01090735 7406 je 0x14109073d
01090737 ff152bbc8500 call qword ptr [rip + 0x85bc2b]
0109073d 498bcd mov rcx, r13
01090740 ff1522bc8500 call qword ptr [rip + 0x85bc22]
01090746 8bc3 mov eax, ebx
01090748 eb05 jmp 0x14109074f
0109074a b8ceffffff mov eax, 0xffffffce
0109074f 488b8d50060000 mov rcx, qword ptr [rbp + 0x650]
01090756 4833cc xor rcx, rsp
01090759 e882b17000 call 0x14179b8e0
0109075e 4c8d9c2490070000 lea r11, [rsp + 0x790]
01090766 498b5b38 mov rbx, qword ptr [r11 + 0x38]
0109076a 498b7340 mov rsi, qword ptr [r11 + 0x40]
0109076e 498b7b48 mov rdi, qword ptr [r11 + 0x48]
01090772 410f2873f0 movaps xmm6, xmmword ptr [r11 - 0x10]
01090777 410f287be0 movaps xmm7, xmmword ptr [r11 - 0x20]
0109077c 450f2843d0 movaps xmm8, xmmword ptr [r11 - 0x30]
01090781 498be3 mov rsp, r11
01090784 415f pop r15
01090786 415e pop r14
01090788 415d pop r13
0109078a 415c pop r12
0109078c 5d pop rbp
0109078d c3 ret 