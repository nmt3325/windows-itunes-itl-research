0104ebc0 48895c2420 mov qword ptr [rsp + 0x20], rbx
0104ebc5 55 push rbp
0104ebc6 56 push rsi
0104ebc7 57 push rdi
0104ebc8 4154 push r12
0104ebca 4155 push r13
0104ebcc 4156 push r14
0104ebce 4157 push r15
0104ebd0 488dac2460e9ffff lea rbp, [rsp - 0x16a0]
0104ebd8 b8a0170000 mov eax, 0x17a0
0104ebdd e8be8b8100 call 0x1418677a0
0104ebe2 482be0 sub rsp, rax
0104ebe5 488b055464f800 mov rax, qword ptr [rip + 0xf86454]
0104ebec 4833c4 xor rax, rsp
0104ebef 48898590160000 mov qword ptr [rbp + 0x1690], rax
0104ebf6 4488442453 mov byte ptr [rsp + 0x53], r8b
0104ebfb 488955b0 mov qword ptr [rbp - 0x50], rdx
0104ebff 488bf9 mov rdi, rcx
0104ec02 48894db8 mov qword ptr [rbp - 0x48], rcx
0104ec06 4533f6 xor r14d, r14d
0104ec09 458be6 mov r12d, r14d
0104ec0c 4489742464 mov dword ptr [rsp + 0x64], r14d
0104ec11 4489742468 mov dword ptr [rsp + 0x68], r14d
0104ec16 4885c9 test rcx, rcx
0104ec19 0f84cc0e0000 je 0x14104faeb
0104ec1f 4885d2 test rdx, rdx
0104ec22 0f84c30e0000 je 0x14104faeb
0104ec28 33d2 xor edx, edx
0104ec2a 41b808080000 mov r8d, 0x808
0104ec30 488d4dc0 lea rcx, [rbp - 0x40]
0104ec34 e867e07400 call 0x14179cca0
0104ec39 458bfe mov r15d, r14d
0104ec3c 418bde mov ebx, r14d
0104ec3f 895c2460 mov dword ptr [rsp + 0x60], ebx
0104ec43 32c0 xor al, al
0104ec45 88442452 mov byte ptr [rsp + 0x52], al
0104ec49 88442451 mov byte ptr [rsp + 0x51], al
0104ec4d 4c8975a8 mov qword ptr [rbp - 0x58], r14
0104ec51 4c8975a0 mov qword ptr [rbp - 0x60], r14
0104ec55 813f54534c4f cmp dword ptr [rdi], 0x4f4c5354
0104ec5b 0f853d0d0000 jne 0x14104f99e
0104ec61 395f04 cmp dword ptr [rdi + 4], ebx
0104ec64 0f84340d0000 je 0x14104f99e
0104ec6a 488b7710 mov rsi, qword ptr [rdi + 0x10]
0104ec6e 482b7708 sub rsi, qword ptr [rdi + 8]
0104ec72 48c1fe04 sar rsi, 4
0104ec76 48b8abaaaaaaaaaaaaaa movabs rax, 0xaaaaaaaaaaaaaaab
0104ec80 480faff0 imul rsi, rax
0104ec84 8974245c mov dword ptr [rsp + 0x5c], esi
0104ec88 83fe01 cmp esi, 1
0104ec8b 0f8efb020000 jle 0x14104ef8c
0104ec91 488b0598820501 mov rax, qword ptr [rip + 0x1058298]
0104ec98 4885c0 test rax, rax
0104ec9b 4c8db036020000 lea r14, [rax + 0x236]
0104eca2 7507 jne 0x14104ecab
0104eca4 4c8d35953d0601 lea r14, [rip + 0x1063d95]
0104ecab 8974245c mov dword ptr [rsp + 0x5c], esi
0104ecaf 41389ebe090000 cmp byte ptr [r14 + 0x9be], bl
0104ecb6 0f85cd020000 jne 0x14104ef89
0104ecbc 885c2450 mov byte ptr [rsp + 0x50], bl
0104ecc0 488b0d19100801 mov rcx, qword ptr [rip + 0x1081019]
0104ecc7 4885c9 test rcx, rcx
0104ecca 742f je 0x14104ecfb
0104eccc ba13009400 mov edx, 0x940013
0104ecd1 ff1519a18900 call qword ptr [rip + 0x89a119]
0104ecd7 488bf8 mov rdi, rax
0104ecda 4885c0 test rax, rax
0104ecdd 7417 je 0x14104ecf6
0104ecdf 488bc8 mov rcx, rax
0104ece2 ff15d8a18900 call qword ptr [rip + 0x89a1d8]
0104ece8 488bd8 mov rbx, rax
0104eceb ff158fa28900 call qword ptr [rip + 0x89a28f]
0104ecf1 483bd8 cmp rbx, rax
0104ecf4 7505 jne 0x14104ecfb
0104ecf6 4885ff test rdi, rdi
0104ecf9 7507 jne 0x14104ed02
0104ecfb 488b3df6ee0501 mov rdi, qword ptr [rip + 0x105eef6]
0104ed02 33db xor ebx, ebx
0104ed04 66899d90140000 mov word ptr [rbp + 0x1490], bx
0104ed0b 4885ff test rdi, rdi
0104ed0e 745f je 0x14104ed6f
0104ed10 48899d50130000 mov qword ptr [rbp + 0x1350], rbx
0104ed17 488bcf mov rcx, rdi
0104ed1a ff1570a28900 call qword ptr [rip + 0x89a270]
0104ed20 48898558130000 mov qword ptr [rbp + 0x1358], rax
0104ed27 4885c0 test rax, rax
0104ed2a 743c je 0x14104ed68
0104ed2c 0fb7d8 movzx ebx, ax
0104ed2f 483dff000000 cmp rax, 0xff
0104ed35 7e10 jle 0x14104ed47
0104ed37 48c78558130000ff000000 mov qword ptr [rbp + 0x1358], 0xff
0104ed42 bbff000000 mov ebx, 0xff
0104ed47 0f288550130000 movaps xmm0, xmmword ptr [rbp + 0x1350]
0104ed4e 660f7f442470 movdqa xmmword ptr [rsp + 0x70], xmm0
0104ed54 4c8d8592140000 lea r8, [rbp + 0x1492]
0104ed5b 488d542470 lea rdx, [rsp + 0x70]
0104ed60 488bcf mov rcx, rdi
0104ed63 e8f833b4ff call 0x140b92160
0104ed68 66899d90140000 mov word ptr [rbp + 0x1490], bx
0104ed6f 488d4c2470 lea rcx, [rsp + 0x70]
0104ed74 e88704abff call 0x140aff200
0104ed79 4c8bf8 mov r15, rax
0104ed7c 488d4d80 lea rcx, [rbp - 0x80]
0104ed80 e87b00abff call 0x140afee00
0104ed85 4c8be0 mov r12, rax
0104ed88 488d4d90 lea rcx, [rbp - 0x70]
0104ed8c e8efffaaff call 0x140afed80
0104ed91 4c8be8 mov r13, rax
0104ed94 488b0d450f0801 mov rcx, qword ptr [rip + 0x1080f45]
0104ed9b 4885c9 test rcx, rcx
0104ed9e 742f je 0x14104edcf
0104eda0 ba13009400 mov edx, 0x940013
0104eda5 ff1545a08900 call qword ptr [rip + 0x89a045]
0104edab 488bf8 mov rdi, rax
0104edae 4885c0 test rax, rax
0104edb1 7417 je 0x14104edca
0104edb3 488bc8 mov rcx, rax
0104edb6 ff1504a18900 call qword ptr [rip + 0x89a104]
0104edbc 488bd8 mov rbx, rax
0104edbf ff15bba18900 call qword ptr [rip + 0x89a1bb]
0104edc5 483bd8 cmp rbx, rax
0104edc8 7505 jne 0x14104edcf
0104edca 4885ff test rdi, rdi
0104edcd 7507 jne 0x14104edd6
0104edcf 488b3d22ee0501 mov rdi, qword ptr [rip + 0x105ee22]
0104edd6 488bd7 mov rdx, rdi
0104edd9 488d8d50130000 lea rcx, [rbp + 0x1350]
0104ede0 e8fb74a8ff call 0x140ad62e0
0104ede5 90 nop 
0104ede6 488d442450 lea rax, [rsp + 0x50]
0104edeb 4889442420 mov qword ptr [rsp + 0x20], rax
0104edf0 4d8bcf mov r9, r15
0104edf3 4d8bc4 mov r8, r12
0104edf6 498bd5 mov rdx, r13
0104edf9 488d8d50130000 lea rcx, [rbp + 0x1350]
0104ee00 e88b1babff call 0x140b00990
0104ee05 0fb7d8 movzx ebx, ax
0104ee08 488b8d50130000 mov rcx, qword ptr [rbp + 0x1350]
0104ee0f 4885c9 test rcx, rcx
0104ee12 741b je 0x14104ee2f
0104ee14 b8ffffffff mov eax, 0xffffffff
0104ee19 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0104ee1e 83f801 cmp eax, 1
0104ee21 750c jne 0x14104ee2f
0104ee23 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0104ee2a e8a9cf7400 call 0x14179bdd8
0104ee2f 488b8d58130000 mov rcx, qword ptr [rbp + 0x1358]
0104ee36 4885c9 test rcx, rcx
0104ee39 741c je 0x14104ee57
0104ee3b b8ffffffff mov eax, 0xffffffff
0104ee40 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0104ee45 83f801 cmp eax, 1
0104ee48 750d jne 0x14104ee57
0104ee4a c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0104ee51 e882cf7400 call 0x14179bdd8
0104ee56 90 nop 
0104ee57 488b4d90 mov rcx, qword ptr [rbp - 0x70]
0104ee5b 4885c9 test rcx, rcx
0104ee5e 7423 je 0x14104ee83
0104ee60 b8ffffffff mov eax, 0xffffffff
0104ee65 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0104ee6a 83f801 cmp eax, 1
0104ee6d 750c jne 0x14104ee7b
0104ee6f c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0104ee76 e85dcf7400 call 0x14179bdd8
0104ee7b 33ff xor edi, edi
0104ee7d 48897d90 mov qword ptr [rbp - 0x70], rdi
0104ee81 eb02 jmp 0x14104ee85
0104ee83 33ff xor edi, edi
0104ee85 488b4d98 mov rcx, qword ptr [rbp - 0x68]
0104ee89 4885c9 test rcx, rcx
0104ee8c 741f je 0x14104eead
0104ee8e b8ffffffff mov eax, 0xffffffff
0104ee93 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0104ee98 83f801 cmp eax, 1
0104ee9b 750c jne 0x14104eea9
0104ee9d c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0104eea4 e82fcf7400 call 0x14179bdd8
0104eea9 48897d98 mov qword ptr [rbp - 0x68], rdi
0104eead 488b4d80 mov rcx, qword ptr [rbp - 0x80]
0104eeb1 4885c9 test rcx, rcx
0104eeb4 741f je 0x14104eed5
0104eeb6 b8ffffffff mov eax, 0xffffffff
0104eebb f00fc14108 lock xadd dword ptr [rcx + 8], eax
0104eec0 83f801 cmp eax, 1
0104eec3 750c jne 0x14104eed1
0104eec5 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0104eecc e807cf7400 call 0x14179bdd8
0104eed1 48897d80 mov qword ptr [rbp - 0x80], rdi
0104eed5 488b4d88 mov rcx, qword ptr [rbp - 0x78]
0104eed9 4885c9 test rcx, rcx
0104eedc 741f je 0x14104eefd
0104eede b8ffffffff mov eax, 0xffffffff
0104eee3 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0104eee8 83f801 cmp eax, 1
0104eeeb 750c jne 0x14104eef9
0104eeed c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0104eef4 e8dfce7400 call 0x14179bdd8
0104eef9 48897d88 mov qword ptr [rbp - 0x78], rdi
0104eefd 488b4c2470 mov rcx, qword ptr [rsp + 0x70]
0104ef02 4885c9 test rcx, rcx
0104ef05 7420 je 0x14104ef27
0104ef07 b8ffffffff mov eax, 0xffffffff
0104ef0c f00fc14108 lock xadd dword ptr [rcx + 8], eax
0104ef11 83f801 cmp eax, 1
0104ef14 750c jne 0x14104ef22
0104ef16 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0104ef1d e8b6ce7400 call 0x14179bdd8
0104ef22 48897c2470 mov qword ptr [rsp + 0x70], rdi
0104ef27 488b4c2478 mov rcx, qword ptr [rsp + 0x78]
0104ef2c 4885c9 test rcx, rcx
0104ef2f 741b je 0x14104ef4c
0104ef31 b8ffffffff mov eax, 0xffffffff
0104ef36 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0104ef3b 83f801 cmp eax, 1
0104ef3e 750c jne 0x14104ef4c
0104ef40 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0104ef47 e88cce7400 call 0x14179bdd8
0104ef4c 6683fb65 cmp bx, 0x65
0104ef50 0f85880a0000 jne 0x14104f9de
0104ef56 0fb6442450 movzx eax, byte ptr [rsp + 0x50]
0104ef5b 418886be090000 mov byte ptr [r14 + 0x9be], al
0104ef62 b101 mov cl, 1
0104ef64 e8a7f0ffff call 0x14104e010
0104ef69 4032ff xor dil, dil
0104ef6c 40887c2450 mov byte ptr [rsp + 0x50], dil
0104ef71 4533f6 xor r14d, r14d
0104ef74 458bee mov r13d, r14d
0104ef77 4c897580 mov qword ptr [rbp - 0x80], r14
0104ef7b 8974245c mov dword ptr [rsp + 0x5c], esi
0104ef7f 448b642464 mov r12d, dword ptr [rsp + 0x64]
0104ef84 418bdd mov ebx, r13d
0104ef87 eb25 jmp 0x14104efae
0104ef89 4533f6 xor r14d, r14d
0104ef8c 4032ff xor dil, dil
0104ef8f 40887c2450 mov byte ptr [rsp + 0x50], dil
0104ef94 4d8bee mov r13, r14
0104ef97 4c897580 mov qword ptr [rbp - 0x80], r14
0104ef9b b101 mov cl, 1
0104ef9d e86ef0ffff call 0x14104e010
0104efa2 8b74245c mov esi, dword ptr [rsp + 0x5c]
0104efa6 85f6 test esi, esi
0104efa8 0f8e8a000000 jle 0x14104f038
0104efae 488b059bd60801 mov rax, qword ptr [rip + 0x108d69b]
0104efb5 4885c0 test rax, rax
0104efb8 7416 je 0x14104efd0
0104efba 488b80a0000000 mov rax, qword ptr [rax + 0xa0]
0104efc1 488b4da0 mov rcx, qword ptr [rbp - 0x60]
0104efc5 4885c0 test rax, rax
0104efc8 480f45c8 cmovne rcx, rax
0104efcc 48894da0 mov qword ptr [rbp - 0x60], rcx
0104efd0 4c89b588130000 mov qword ptr [rbp + 0x1388], r14
0104efd7 488d45a8 lea rax, [rbp - 0x58]
0104efdb 4889442440 mov qword ptr [rsp + 0x40], rax
0104efe0 c744243880000000 mov dword ptr [rsp + 0x38], 0x80
0104efe8 4489742430 mov dword ptr [rsp + 0x30], r14d
0104efed 488d8550130000 lea rax, [rbp + 0x1350]
0104eff4 4889442428 mov qword ptr [rsp + 0x28], rax
0104eff9 4c89742420 mov qword ptr [rsp + 0x20], r14
0104effe 4533c9 xor r9d, r9d
0104f001 4533c0 xor r8d, r8d
0104f004 33d2 xor edx, edx
0104f006 488b4db0 mov rcx, qword ptr [rbp - 0x50]
0104f00a e8f10ccaff call 0x140cefd00
0104f00f 448bf8 mov r15d, eax
0104f012 85c0 test eax, eax
0104f014 0f85ad090000 jne 0x14104f9c7
0104f01a 488b0d2fd60801 mov rcx, qword ptr [rip + 0x108d62f]
0104f021 4885c9 test rcx, rcx
0104f024 7412 je 0x14104f038
0104f026 488b45a8 mov rax, qword ptr [rbp - 0x58]
0104f02a 488981a0000000 mov qword ptr [rcx + 0xa0], rax
0104f031 4489742458 mov dword ptr [rsp + 0x58], r14d
0104f036 eb18 jmp 0x14104f050
0104f038 4489742458 mov dword ptr [rsp + 0x58], r14d
0104f03d 85f6 test esi, esi
0104f03f 0f8e63090000 jle 0x14104f9a8
0104f045 6666660f1f840000000000 nop word ptr [rax + rax]
0104f050 4533c0 xor r8d, r8d
0104f053 418bd6 mov edx, r14d
0104f056 488b4db8 mov rcx, qword ptr [rbp - 0x48]
0104f05a e861e928ff call 0x1402dd9c0
0104f05f 4885c0 test rax, rax
0104f062 0f84d3080000 je 0x14104f93b
0104f068 488b08 mov rcx, qword ptr [rax]
0104f06b 4885c9 test rcx, rcx
0104f06e 0f84c7080000 je 0x14104f93b
0104f074 813974736c70 cmp dword ptr [rcx], 0x706c7374
0104f07a 0f85bb080000 jne 0x14104f93b
0104f080 83782800 cmp dword ptr [rax + 0x28], 0
0104f084 0f84b1080000 je 0x14104f93b
0104f08a 488b7030 mov rsi, qword ptr [rax + 0x30]
0104f08e 4885f6 test rsi, rsi
0104f091 0f84a4080000 je 0x14104f93b
0104f097 48837e1000 cmp qword ptr [rsi + 0x10], 0
0104f09c 7504 jne 0x14104f0a2
0104f09e 33f6 xor esi, esi
0104f0a0 eb2f jmp 0x14104f0d1
0104f0a2 488b7658 mov rsi, qword ptr [rsi + 0x58]
0104f0a6 4885f6 test rsi, rsi
0104f0a9 0f848c080000 je 0x14104f93b
0104f0af 90 nop 
0104f0b0 488b4608 mov rax, qword ptr [rsi + 8]
0104f0b4 4885c0 test rax, rax
0104f0b7 7410 je 0x14104f0c9
0104f0b9 4883781000 cmp qword ptr [rax + 0x10], 0
0104f0be 7409 je 0x14104f0c9
0104f0c0 817e3444524853 cmp dword ptr [rsi + 0x34], 0x53485244
0104f0c7 7508 jne 0x14104f0d1
0104f0c9 488b36 mov rsi, qword ptr [rsi]
0104f0cc 4885f6 test rsi, rsi
0104f0cf 75df jne 0x14104f0b0
0104f0d1 4885f6 test rsi, rsi
0104f0d4 0f8461080000 je 0x14104f93b
0104f0da 488b7e08 mov rdi, qword ptr [rsi + 8]
0104f0de 48897d90 mov qword ptr [rbp - 0x70], rdi
0104f0e2 4c8d442454 lea r8, [rsp + 0x54]
0104f0e7 488d95d0070000 lea rdx, [rbp + 0x7d0]
0104f0ee 488bce mov rcx, rsi
0104f0f1 e84af6ffff call 0x14104e740
0104f0f6 448bf8 mov r15d, eax
0104f0f9 85c0 test eax, eax
0104f0fb 0f853a080000 jne 0x14104f93b
0104f101 c644245201 mov byte ptr [rsp + 0x52], 1
0104f106 41b808080000 mov r8d, 0x808
0104f10c 488d95d0070000 lea rdx, [rbp + 0x7d0]
0104f113 488d4dc0 lea rcx, [rbp - 0x40]
0104f117 e878db7400 call 0x14179cc94
0104f11c 85c0 test eax, eax
0104f11e 0f84fe000000 je 0x14104f222
0104f124 8b9dd8070000 mov ebx, dword ptr [rbp + 0x7d8]
0104f12a 4d85ed test r13, r13
0104f12d 741b je 0x14104f14a
0104f12f 395dc8 cmp dword ptr [rbp - 0x38], ebx
0104f132 7416 je 0x14104f14a
0104f134 498bcd mov rcx, r13
0104f137 ff152bd28900 call qword ptr [rip + 0x89d22b]
0104f13d 4533ed xor r13d, r13d
0104f140 4c896d80 mov qword ptr [rbp - 0x80], r13
0104f144 8b9dd8070000 mov ebx, dword ptr [rbp + 0x7d8]
0104f14a 488d4dc0 lea rcx, [rbp - 0x40]
0104f14e 488d95d0070000 lea rdx, [rbp + 0x7d0]
0104f155 41b808080000 mov r8d, 0x808
0104f15b e83adb7400 call 0x14179cc9a
0104f160 85db test ebx, ebx
0104f162 7409 je 0x14104f16d
0104f164 83fb01 cmp ebx, 1
0104f167 7204 jb 0x14104f16d
0104f169 ffcb dec ebx
0104f16b eb02 jmp 0x14104f16f
0104f16d 33db xor ebx, ebx
0104f16f 8bc3 mov eax, ebx
0104f171 4869d848060000 imul rbx, rax, 0x648
0104f178 4d85ed test r13, r13
0104f17b 752b jne 0x14104f1a8
0104f17d 488d8b58140000 lea rcx, [rbx + 0x1458]
0104f184 ba10000000 mov edx, 0x10
0104f189 ff15e1d18900 call qword ptr [rip + 0x89d1e1]
0104f18f 4c8be8 mov r13, rax
0104f192 48894580 mov qword ptr [rbp - 0x80], rax
0104f196 4885c0 test rax, rax
0104f199 750d jne 0x14104f1a8
0104f19b 40b701 mov dil, 1
0104f19e 40887c2450 mov byte ptr [rsp + 0x50], dil
0104f1a3 e9b4070000 jmp 0x14104f95c
0104f1a8 4c8d8358140000 lea r8, [rbx + 0x1458]
0104f1af 33d2 xor edx, edx
0104f1b1 498bcd mov rcx, r13
0104f1b4 e8e7da7400 call 0x14179cca0
0104f1b9 48833d8fd4080100 cmp qword ptr [rip + 0x108d48f], 0
0104f1c1 0f95c3 setne bl
0104f1c4 b101 mov cl, 1
0104f1c6 e8d547ffff call 0x1410439a0
0104f1cb 448bf8 mov r15d, eax
0104f1ce 85c0 test eax, eax
0104f1d0 7411 je 0x14104f1e3
0104f1d2 89442460 mov dword ptr [rsp + 0x60], eax
0104f1d6 40b701 mov dil, 1
0104f1d9 40887c2450 mov byte ptr [rsp + 0x50], dil
0104f1de e95d070000 jmp 0x14104f940
0104f1e3 84db test bl, bl
0104f1e5 7507 jne 0x14104f1ee
0104f1e7 b101 mov cl, 1
0104f1e9 e822eeffff call 0x14104e010
0104f1ee c644242000 mov byte ptr [rsp + 0x20], 0
0104f1f3 4533c9 xor r9d, r9d
0104f1f6 440fb6442453 movzx r8d, byte ptr [rsp + 0x53]
0104f1fc 498bd5 mov rdx, r13
0104f1ff 488d4dc0 lea rcx, [rbp - 0x40]
0104f203 e8f88affff call 0x141047d00
0104f208 448bf8 mov r15d, eax
0104f20b 8bd8 mov ebx, eax
0104f20d 89442460 mov dword ptr [rsp + 0x60], eax
0104f211 85c0 test eax, eax
0104f213 740d je 0x14104f222
0104f215 40b701 mov dil, 1
0104f218 40887c2450 mov byte ptr [rsp + 0x50], dil
0104f21d e91e070000 jmp 0x14104f940
0104f222 448bfb mov r15d, ebx
0104f225 85db test ebx, ebx
0104f227 0f850e070000 jne 0x14104f93b
0104f22d 4d85ed test r13, r13
0104f230 0f8405070000 je 0x14104f93b
0104f236 ba10000000 mov edx, 0x10
0104f23b b9f04a0000 mov ecx, 0x4af0
0104f240 ff152ad18900 call qword ptr [rip + 0x89d12a]
0104f246 488bd8 mov rbx, rax
0104f249 4885c0 test rax, rax
0104f24c 0f84e9060000 je 0x14104f93b
0104f252 33d2 xor edx, edx
0104f254 41b8f04a0000 mov r8d, 0x4af0
0104f25a 488bc8 mov rcx, rax
0104f25d e83eda7400 call 0x14179cca0
0104f262 c7430460160000 mov dword ptr [rbx + 4], 0x1660
0104f269 488d8b08080000 lea rcx, [rbx + 0x808]
0104f270 498d95040a0000 lea rdx, [r13 + 0xa04]
0104f277 41b9ff000000 mov r9d, 0xff
0104f27d 4885d2 test rdx, rdx
0104f280 7444 je 0x14104f2c6
0104f282 4885c9 test rcx, rcx
0104f285 743f je 0x14104f2c6
0104f287 440fb702 movzx r8d, word ptr [rdx]
0104f28b 4883c202 add rdx, 2
0104f28f 453bc1 cmp r8d, r9d
0104f292 7610 jbe 0x14104f2a4
0104f294 66448909 mov word ptr [rcx], r9w
0104f298 4883c102 add rcx, 2
0104f29c 41b8fe000000 mov r8d, 0xfe
0104f2a2 eb0e jmp 0x14104f2b2
0104f2a4 66448901 mov word ptr [rcx], r8w
0104f2a8 4883c102 add rcx, 2
0104f2ac 4183e801 sub r8d, 1
0104f2b0 7814 js 0x14104f2c6
0104f2b2 0fb702 movzx eax, word ptr [rdx]
0104f2b5 488d5202 lea rdx, [rdx + 2]
0104f2b9 668901 mov word ptr [rcx], ax
0104f2bc 488d4902 lea rcx, [rcx + 2]
0104f2c0 4183e801 sub r8d, 1
0104f2c4 79ec jns 0x14104f2b2
0104f2c6 830b10 or dword ptr [rbx], 0x10
0104f2c9 488d8b08040000 lea rcx, [rbx + 0x408]
0104f2d0 498d9504040000 lea rdx, [r13 + 0x404]
0104f2d7 4885d2 test rdx, rdx
0104f2da 7448 je 0x14104f324
0104f2dc 4885c9 test rcx, rcx
0104f2df 7443 je 0x14104f324
0104f2e1 440fb702 movzx r8d, word ptr [rdx]
0104f2e5 4883c202 add rdx, 2
0104f2e9 453bc1 cmp r8d, r9d
0104f2ec 7610 jbe 0x14104f2fe
0104f2ee 66448909 mov word ptr [rcx], r9w
0104f2f2 4883c102 add rcx, 2
0104f2f6 41b8fe000000 mov r8d, 0xfe
0104f2fc eb12 jmp 0x14104f310
0104f2fe 66448901 mov word ptr [rcx], r8w
0104f302 4883c102 add rcx, 2
0104f306 4183e801 sub r8d, 1
0104f30a 7818 js 0x14104f324
0104f30c 0f1f4000 nop dword ptr [rax]
0104f310 0fb702 movzx eax, word ptr [rdx]
0104f313 488d5202 lea rdx, [rdx + 2]
0104f317 668901 mov word ptr [rcx], ax
0104f31a 488d4902 lea rcx, [rcx + 2]
0104f31e 4183e801 sub r8d, 1
0104f322 79ec jns 0x14104f310
0104f324 488d8b40100000 lea rcx, [rbx + 0x1040]
0104f32b 498d95040c0000 lea rdx, [r13 + 0xc04]
0104f332 4885d2 test rdx, rdx
0104f335 744d je 0x14104f384
0104f337 4885c9 test rcx, rcx
0104f33a 7448 je 0x14104f384
0104f33c 440fb702 movzx r8d, word ptr [rdx]
0104f340 4883c202 add rdx, 2
0104f344 453bc1 cmp r8d, r9d
0104f347 7610 jbe 0x14104f359
0104f349 66448909 mov word ptr [rcx], r9w
0104f34d 4883c102 add rcx, 2
0104f351 41b8fe000000 mov r8d, 0xfe
0104f357 eb17 jmp 0x14104f370
0104f359 66448901 mov word ptr [rcx], r8w
0104f35d 4883c102 add rcx, 2
0104f361 4183e801 sub r8d, 1
0104f365 781d js 0x14104f384
0104f367 660f1f840000000000 nop word ptr [rax + rax]
0104f370 0fb702 movzx eax, word ptr [rdx]
0104f373 488d5202 lea rdx, [rdx + 2]
0104f377 668901 mov word ptr [rcx], ax
0104f37a 488d4902 lea rcx, [rcx + 2]
0104f37e 4183e801 sub r8d, 1
0104f382 79ec jns 0x14104f370
0104f384 488d8b08060000 lea rcx, [rbx + 0x608]
0104f38b 498d9504080000 lea rdx, [r13 + 0x804]
0104f392 4885d2 test rdx, rdx
0104f395 744d je 0x14104f3e4
0104f397 4885c9 test rcx, rcx
0104f39a 7448 je 0x14104f3e4
0104f39c 440fb702 movzx r8d, word ptr [rdx]
0104f3a0 4883c202 add rdx, 2
0104f3a4 453bc1 cmp r8d, r9d
0104f3a7 7610 jbe 0x14104f3b9
0104f3a9 66448909 mov word ptr [rcx], r9w
0104f3ad 4883c102 add rcx, 2
0104f3b1 41b8fe000000 mov r8d, 0xfe
0104f3b7 eb17 jmp 0x14104f3d0
0104f3b9 66448901 mov word ptr [rcx], r8w
0104f3bd 4883c102 add rcx, 2
0104f3c1 4183e801 sub r8d, 1
0104f3c5 781d js 0x14104f3e4
0104f3c7 660f1f840000000000 nop word ptr [rax + rax]
0104f3d0 0fb702 movzx eax, word ptr [rdx]
0104f3d3 488d5202 lea rdx, [rdx + 2]
0104f3d7 668901 mov word ptr [rcx], ax
0104f3da 488d4902 lea rcx, [rcx + 2]
0104f3de 4183e801 sub r8d, 1
0104f3e2 79ec jns 0x14104f3d0
0104f3e4 6683bb0806000000 cmp word ptr [rbx + 0x608], 0
0104f3ec 7557 jne 0x14104f445
0104f3ee 488d8b08060000 lea rcx, [rbx + 0x608]
0104f3f5 488d9308040000 lea rdx, [rbx + 0x408]
0104f3fc 4885d2 test rdx, rdx
0104f3ff 7444 je 0x14104f445
0104f401 4885c9 test rcx, rcx
0104f404 743f je 0x14104f445
0104f406 440fb702 movzx r8d, word ptr [rdx]
0104f40a 4883c202 add rdx, 2
0104f40e 453bc1 cmp r8d, r9d
0104f411 7610 jbe 0x14104f423
0104f413 66448909 mov word ptr [rcx], r9w
0104f417 4883c102 add rcx, 2
0104f41b 41b8fe000000 mov r8d, 0xfe
0104f421 eb0e jmp 0x14104f431
0104f423 66448901 mov word ptr [rcx], r8w
0104f427 4883c102 add rcx, 2
0104f42b 4183e801 sub r8d, 1
0104f42f 7814 js 0x14104f445
0104f431 0fb702 movzx eax, word ptr [rdx]
0104f434 488d5202 lea rdx, [rdx + 2]
0104f438 668901 mov word ptr [rcx], ax
0104f43b 488d4902 lea rcx, [rcx + 2]
0104f43f 4183e801 sub r8d, 1
0104f443 79ec jns 0x14104f431
0104f445 810b0c002000 or dword ptr [rbx], 0x20000c
0104f44b 8b03 mov eax, dword ptr [rbx]
0104f44d 498d9504060000 lea rdx, [r13 + 0x604]
0104f454 440fb702 movzx r8d, word ptr [rdx]
0104f458 664585c0 test r8w, r8w
0104f45c 745e je 0x14104f4bc
0104f45e 488d8b58140000 lea rcx, [rbx + 0x1458]
0104f465 4885d2 test rdx, rdx
0104f468 744a je 0x14104f4b4
0104f46a 4885c9 test rcx, rcx
0104f46d 7445 je 0x14104f4b4
0104f46f 4883c202 add rdx, 2
0104f473 453bc1 cmp r8d, r9d
0104f476 7610 jbe 0x14104f488
0104f478 66448909 mov word ptr [rcx], r9w
0104f47c 4883c102 add rcx, 2
0104f480 41b8fe000000 mov r8d, 0xfe
0104f486 eb18 jmp 0x14104f4a0
0104f488 66448901 mov word ptr [rcx], r8w
0104f48c 4883c102 add rcx, 2
0104f490 4183e801 sub r8d, 1
0104f494 781e js 0x14104f4b4
0104f496 66660f1f840000000000 nop word ptr [rax + rax]
0104f4a0 0fb702 movzx eax, word ptr [rdx]
0104f4a3 488d5202 lea rdx, [rdx + 2]
0104f4a7 668901 mov word ptr [rcx], ax
0104f4aa 488d4902 lea rcx, [rcx + 2]
0104f4ae 4183e801 sub r8d, 1
0104f4b2 79ec jns 0x14104f4a0
0104f4b4 810b00000040 or dword ptr [rbx], 0x40000000
0104f4ba 8b03 mov eax, dword ptr [rbx]
0104f4bc 418b4d00 mov ecx, dword ptr [r13]
0104f4c0 85c9 test ecx, ecx
0104f4c2 740d je 0x14104f4d1
0104f4c4 66898b10100000 mov word ptr [rbx + 0x1010], cx
0104f4cb 0fbae807 bts eax, 7
0104f4cf 8903 mov dword ptr [rbx], eax
0104f4d1 440fb6855c050000 movzx r8d, byte ptr [rbp + 0x55c]
0104f4d9 4584c0 test r8b, r8b
0104f4dc 7467 je 0x14104f545
0104f4de 4d8d8d16140000 lea r9, [r13 + 0x1416]
0104f4e5 4d85c9 test r9, r9
0104f4e8 745b je 0x14104f545
0104f4ea 4c8d9d5d050000 lea r11, [rbp + 0x55d]
0104f4f1 410fb611 movzx edx, byte ptr [r9]
0104f4f5 49ffc1 inc r9
0104f4f8 84d2 test dl, dl
0104f4fa 7439 je 0x14104f535
0104f4fc 418d489f lea ecx, [r8 - 0x61]
0104f500 418d40e0 lea eax, [r8 - 0x20]
0104f504 440fb6d0 movzx r10d, al
0104f508 410fb6c0 movzx eax, r8b
0104f50c 80f919 cmp cl, 0x19
0104f50f 440f47d0 cmova r10d, eax
0104f513 8d429f lea eax, [rdx - 0x61]
0104f516 3c19 cmp al, 0x19
0104f518 7703 ja 0x14104f51d
0104f51a 80c2e0 add dl, 0xe0
0104f51d 443ad2 cmp r10b, dl
0104f520 7523 jne 0x14104f545
0104f522 450fb603 movzx r8d, byte ptr [r11]
0104f526 49ffc3 inc r11
0104f529 410fb611 movzx edx, byte ptr [r9]
0104f52d 49ffc1 inc r9
0104f530 4584c0 test r8b, r8b
0104f533 75c3 jne 0x14104f4f8
0104f535 443ac2 cmp r8b, dl
0104f538 750b jne 0x14104f545
0104f53a b801000000 mov eax, 1
0104f53f 89442454 mov dword ptr [rsp + 0x54], eax
0104f543 eb31 jmp 0x14104f576
0104f545 8b442454 mov eax, dword ptr [rsp + 0x54]
0104f549 85c0 test eax, eax
0104f54b 7523 jne 0x14104f570
0104f54d 0fb7870a010000 movzx eax, word ptr [rdi + 0x10a]
0104f554 89442454 mov dword ptr [rsp + 0x54], eax
0104f558 85c0 test eax, eax
0104f55a 7514 jne 0x14104f570
0104f55c 4d8bc5 mov r8, r13
0104f55f 488bd3 mov rdx, rbx
0104f562 488bce mov rcx, rsi
0104f565 e8b6eeffff call 0x14104e420
0104f56a 89442454 mov dword ptr [rsp + 0x54], eax
0104f56e 85c0 test eax, eax
0104f570 0f8eb0030000 jle 0x14104f926
0104f576 413b850c0e0000 cmp eax, dword ptr [r13 + 0xe0c]
0104f57d 0f87a3030000 ja 0x14104f926
0104f583 ffc8 dec eax
0104f585 4863c8 movsxd rcx, eax
0104f588 4c69f148060000 imul r14, rcx, 0x648
0104f58f 4981c6100e0000 add r14, 0xe10
0104f596 488d4b08 lea rcx, [rbx + 8]
0104f59a 4d03f5 add r14, r13
0104f59d 41b9ff000000 mov r9d, 0xff
0104f5a3 744f je 0x14104f5f4
0104f5a5 4885c9 test rcx, rcx
0104f5a8 744a je 0x14104f5f4
0104f5aa 450fb706 movzx r8d, word ptr [r14]
0104f5ae 498d5602 lea rdx, [r14 + 2]
0104f5b2 453bc1 cmp r8d, r9d
0104f5b5 7610 jbe 0x14104f5c7
0104f5b7 66448909 mov word ptr [rcx], r9w
0104f5bb 4883c102 add rcx, 2
0104f5bf 41b8fe000000 mov r8d, 0xfe
0104f5c5 eb19 jmp 0x14104f5e0
0104f5c7 66448901 mov word ptr [rcx], r8w
0104f5cb 4883c102 add rcx, 2
0104f5cf 4183e801 sub r8d, 1
0104f5d3 781f js 0x14104f5f4
0104f5d5 6666660f1f840000000000 nop word ptr [rax + rax]
0104f5e0 0fb702 movzx eax, word ptr [rdx]
0104f5e3 488d5202 lea rdx, [rdx + 2]
0104f5e7 668901 mov word ptr [rcx], ax
0104f5ea 488d4902 lea rcx, [rcx + 2]
0104f5ee 4183e801 sub r8d, 1
0104f5f2 79ec jns 0x14104f5e0
0104f5f4 830b01 or dword ptr [rbx], 1
0104f5f7 498d9600020000 lea rdx, [r14 + 0x200]
0104f5fe 0fb702 movzx eax, word ptr [rdx]
0104f601 6685c0 test ax, ax
0104f604 7451 je 0x14104f657
0104f606 488d8b08040000 lea rcx, [rbx + 0x408]
0104f60d 4885d2 test rdx, rdx
0104f610 7442 je 0x14104f654
0104f612 4885c9 test rcx, rcx
0104f615 743d je 0x14104f654
0104f617 448bc0 mov r8d, eax
0104f61a 4883c202 add rdx, 2
0104f61e 413bc1 cmp eax, r9d
0104f621 7610 jbe 0x14104f633
0104f623 66448909 mov word ptr [rcx], r9w
0104f627 4883c102 add rcx, 2
0104f62b 41b8fe000000 mov r8d, 0xfe
0104f631 eb0d jmp 0x14104f640
0104f633 668901 mov word ptr [rcx], ax
0104f636 4883c102 add rcx, 2
0104f63a 4183e801 sub r8d, 1
0104f63e 7814 js 0x14104f654
0104f640 0fb702 movzx eax, word ptr [rdx]
0104f643 488d5202 lea rdx, [rdx + 2]
0104f647 668901 mov word ptr [rcx], ax
0104f64a 488d4902 lea rcx, [rcx + 2]
0104f64e 4183e801 sub r8d, 1
0104f652 79ec jns 0x14104f640
0104f654 830b04 or dword ptr [rbx], 4
0104f657 498d9600040000 lea rdx, [r14 + 0x400]
0104f65e 0fb702 movzx eax, word ptr [rdx]
0104f661 6685c0 test ax, ax
0104f664 7454 je 0x14104f6ba
0104f666 488d8b40100000 lea rcx, [rbx + 0x1040]
0104f66d 4885d2 test rdx, rdx
0104f670 7442 je 0x14104f6b4
0104f672 4885c9 test rcx, rcx
0104f675 743d je 0x14104f6b4
0104f677 448bc0 mov r8d, eax
0104f67a 4883c202 add rdx, 2
0104f67e 413bc1 cmp eax, r9d
0104f681 7610 jbe 0x14104f693
0104f683 66448909 mov word ptr [rcx], r9w
0104f687 4883c102 add rcx, 2
0104f68b 41b8fe000000 mov r8d, 0xfe
0104f691 eb0d jmp 0x14104f6a0
0104f693 668901 mov word ptr [rcx], ax
0104f696 4883c102 add rcx, 2
0104f69a 4183e801 sub r8d, 1
0104f69e 7814 js 0x14104f6b4
0104f6a0 0fb702 movzx eax, word ptr [rdx]
0104f6a3 488d5202 lea rdx, [rdx + 2]
0104f6a7 668901 mov word ptr [rcx], ax
0104f6aa 488d4902 lea rcx, [rcx + 2]
0104f6ae 4183e801 sub r8d, 1
0104f6b2 79ec jns 0x14104f6a0
0104f6b4 810b00002000 or dword ptr [rbx], 0x200000
0104f6ba 33c0 xor eax, eax
0104f6bc 8944246c mov dword ptr [rsp + 0x6c], eax
0104f6c0 817e3420204443 cmp dword ptr [rsi + 0x34], 0x43442020
0104f6c7 7507 jne 0x14104f6d0
0104f6c9 808f9a00000040 or byte ptr [rdi + 0x9a], 0x40
0104f6d0 4889442438 mov qword ptr [rsp + 0x38], rax
0104f6d5 4889442430 mov qword ptr [rsp + 0x30], rax
0104f6da 488d44246c lea rax, [rsp + 0x6c]
0104f6df 4889442428 mov qword ptr [rsp + 0x28], rax
0104f6e4 c744242001000000 mov dword ptr [rsp + 0x20], 1
0104f6ec 4533c9 xor r9d, r9d
0104f6ef 4533c0 xor r8d, r8d
0104f6f2 488bd3 mov rdx, rbx
0104f6f5 488bce mov rcx, rsi
0104f6f8 e853d8e7ff call 0x140eccf50
0104f6fd 817e34454c4946 cmp dword ptr [rsi + 0x34], 0x46494c45
0104f704 0f85f5010000 jne 0x14104f8ff
0104f70a 0f57c0 xorps xmm0, xmm0
0104f70d f30f7f442470 movdqu xmmword ptr [rsp + 0x70], xmm0
0104f713 f30f7f8550130000 movdqu xmmword ptr [rbp + 0x1350], xmm0
0104f71b 4183cc08 or r12d, 8
0104f71f 4489642468 mov dword ptr [rsp + 0x68], r12d
0104f724 48c744242800000000 mov qword ptr [rsp + 0x28], 0
0104f72d 488d8550130000 lea rax, [rbp + 0x1350]
0104f734 4889442420 mov qword ptr [rsp + 0x20], rax
0104f739 4533c9 xor r9d, r9d
0104f73c 4533c0 xor r8d, r8d
0104f73f ba82000000 mov edx, 0x82
0104f744 488bce mov rcx, rsi
0104f747 e894d234ff call 0x14039c9e0
0104f74c 4183e4f7 and r12d, 0xfffffff7
0104f750 4489642468 mov dword ptr [rsp + 0x68], r12d
0104f755 4183cc07 or r12d, 7
0104f759 4489642464 mov dword ptr [rsp + 0x64], r12d
0104f75e 4c8bbd50130000 mov r15, qword ptr [rbp + 0x1350]
0104f765 488bbd58130000 mov rdi, qword ptr [rbp + 0x1358]
0104f76c 0f57c0 xorps xmm0, xmm0
0104f76f f30f7f8550130000 movdqu xmmword ptr [rbp + 0x1350], xmm0
0104f777 4c897c2470 mov qword ptr [rsp + 0x70], r15
0104f77c 48897c2478 mov qword ptr [rsp + 0x78], rdi
0104f781 4d85ff test r15, r15
0104f784 750b jne 0x14104f791
0104f786 41bfe8030000 mov r15d, 0x3e8
0104f78c e93a010000 jmp 0x14104f8cb
0104f791 488d95e00f0000 lea rdx, [rbp + 0xfe0]
0104f798 488bce mov rcx, rsi
0104f79b e8f088f5ff call 0x140fa8090
0104f7a0 498b07 mov rax, qword ptr [r15]
0104f7a3 488d15ee26a600 lea rdx, [rip + 0xa626ee]
0104f7aa 498bcf mov rcx, r15
0104f7ad ff5060 call qword ptr [rax + 0x60]
0104f7b0 498b07 mov rax, qword ptr [r15]
0104f7b3 488d15ee26a600 lea rdx, [rip + 0xa626ee]
0104f7ba 498bcf mov rcx, r15
0104f7bd ff5060 call qword ptr [rax + 0x60]
0104f7c0 498b07 mov rax, qword ptr [r15]
0104f7c3 488d159e22b100 lea rdx, [rip + 0xb1229e]
0104f7ca 498bcf mov rcx, r15
0104f7cd ff5060 call qword ptr [rax + 0x60]
0104f7d0 498b07 mov rax, qword ptr [r15]
0104f7d3 488d15e622b100 lea rdx, [rip + 0xb122e6]
0104f7da 498bcf mov rcx, r15
0104f7dd ff5060 call qword ptr [rax + 0x60]
0104f7e0 c685501300000f mov byte ptr [rbp + 0x1350], 0xf
0104f7e7 f20f10059226a600 movsd xmm0, qword ptr [rip + 0xa62692]
0104f7ef f20f118551130000 movsd qword ptr [rbp + 0x1351], xmm0
0104f7f7 8b058c26a600 mov eax, dword ptr [rip + 0xa6268c]
0104f7fd 898559130000 mov dword ptr [rbp + 0x1359], eax
0104f803 0fb7058326a600 movzx eax, word ptr [rip + 0xa62683]
0104f80a 6689855d130000 mov word ptr [rbp + 0x135d], ax
0104f811 0fb6057726a600 movzx eax, byte ptr [rip + 0xa62677]
0104f818 88855f130000 mov byte ptr [rbp + 0x135f], al
0104f81e 4c8d8d90130000 lea r9, [rbp + 0x1390]
0104f825 4d8d8504020000 lea r8, [r13 + 0x204]
0104f82c 498d5504 lea rdx, [r13 + 4]
0104f830 488b4d80 mov rcx, qword ptr [rbp - 0x80]
0104f834 8b890c0e0000 mov ecx, dword ptr [rcx + 0xe0c]
0104f83a e8610e0000 call 0x1410506a0
0104f83f 85c0 test eax, eax
0104f841 7524 jne 0x14104f867
0104f843 0fb68d90130000 movzx ecx, byte ptr [rbp + 0x1390]
0104f84a 498b07 mov rax, qword ptr [r15]
0104f84d 894c2420 mov dword ptr [rsp + 0x20], ecx
0104f851 4c8d8d91130000 lea r9, [rbp + 0x1391]
0104f858 4c8d8550130000 lea r8, [rbp + 0x1350]
0104f85f 33d2 xor edx, edx
0104f861 498bcf mov rcx, r15
0104f864 ff5058 call qword ptr [rax + 0x58]
0104f867 49c7c2ffffffff mov r10, 0xffffffffffffffff
0104f86e 6690 nop 
0104f870 49ffc2 inc r10
0104f873 4380bc160606000000 cmp byte ptr [r14 + r10 + 0x606], 0
0104f87c 75f2 jne 0x14104f870
0104f87e 4585d2 test r10d, r10d
0104f881 7e21 jle 0x14104f8a4
0104f883 498b07 mov rax, qword ptr [r15]
0104f886 4489542420 mov dword ptr [rsp + 0x20], r10d
0104f88b 4d8d8e06060000 lea r9, [r14 + 0x606]
0104f892 4c8d05f726a600 lea r8, [rip + 0xa626f7]
0104f899 ba01000000 mov edx, 1
0104f89e 498bcf mov rcx, r15
0104f8a1 ff5070 call qword ptr [rax + 0x70]
0104f8a4 4d8d8e06060000 lea r9, [r14 + 0x606]
0104f8ab 4d8d8504020000 lea r8, [r13 + 0x204]
0104f8b2 498d5504 lea rdx, [r13 + 4]
0104f8b6 488b4d90 mov rcx, qword ptr [rbp - 0x70]
0104f8ba e84154f4ff call 0x140f94d00
0104f8bf 448bf8 mov r15d, eax
0104f8c2 4c8b6d80 mov r13, qword ptr [rbp - 0x80]
0104f8c6 448b642464 mov r12d, dword ptr [rsp + 0x64]
0104f8cb 4885ff test rdi, rdi
0104f8ce 742f je 0x14104f8ff
0104f8d0 b8ffffffff mov eax, 0xffffffff
0104f8d5 f00fc14708 lock xadd dword ptr [rdi + 8], eax
0104f8da 83f801 cmp eax, 1
0104f8dd 7520 jne 0x14104f8ff
0104f8df 488b07 mov rax, qword ptr [rdi]
0104f8e2 488bcf mov rcx, rdi
0104f8e5 ff10 call qword ptr [rax]
0104f8e7 b8ffffffff mov eax, 0xffffffff
0104f8ec f00fc1470c lock xadd dword ptr [rdi + 0xc], eax
0104f8f1 83f801 cmp eax, 1
0104f8f4 7509 jne 0x14104f8ff
0104f8f6 488b07 mov rax, qword ptr [rdi]
0104f8f9 488bcf mov rcx, rdi
0104f8fc ff5008 call qword ptr [rax + 8]
0104f8ff 837c246c00 cmp dword ptr [rsp + 0x6c], 0
0104f904 741b je 0x14104f921
0104f906 0f57c0 xorps xmm0, xmm0
0104f909 f30f7f442470 movdqu xmmword ptr [rsp + 0x70], xmm0
0104f90f 488bd6 mov rdx, rsi
0104f912 488d4c2470 lea rcx, [rsp + 0x70]
0104f917 e874b034ff call 0x14039a990
0104f91c c644245101 mov byte ptr [rsp + 0x51], 1
0104f921 448b742458 mov r14d, dword ptr [rsp + 0x58]
0104f926 488d8b944a0000 lea rcx, [rbx + 0x4a94]
0104f92d e8fe40efff call 0x140f43a30
0104f932 488bcb mov rcx, rbx
0104f935 ff152dca8900 call qword ptr [rip + 0x89ca2d]
0104f93b 0fb67c2450 movzx edi, byte ptr [rsp + 0x50]
0104f940 807c245100 cmp byte ptr [rsp + 0x51], 0
0104f945 740f je 0x14104f956
0104f947 33d2 xor edx, edx
0104f949 488b45b0 mov rax, qword ptr [rbp - 0x50]
0104f94d 488b4808 mov rcx, qword ptr [rax + 8]
0104f951 e8dae9e7ff call 0x140ece330
0104f956 4183ff80 cmp r15d, -0x80
0104f95a 7417 je 0x14104f973
0104f95c 41ffc6 inc r14d
0104f95f 4489742458 mov dword ptr [rsp + 0x58], r14d
0104f964 443b74245c cmp r14d, dword ptr [rsp + 0x5c]
0104f969 8b5c2460 mov ebx, dword ptr [rsp + 0x60]
0104f96d 0f8cddf6ffff jl 0x14104f050
0104f973 4d85ed test r13, r13
0104f976 7409 je 0x14104f981
0104f978 498bcd mov rcx, r13
0104f97b ff15e7c98900 call qword ptr [rip + 0x89c9e7]
0104f981 807c245200 cmp byte ptr [rsp + 0x52], 0
0104f986 752a jne 0x14104f9b2
0104f988 4183ff80 cmp r15d, -0x80
0104f98c 7424 je 0x14104f9b2
0104f98e 4181ff30ffffff cmp r15d, 0xffffff30
0104f995 7511 jne 0x14104f9a8
0104f997 b916009400 mov ecx, 0x940016
0104f99c eb0f jmp 0x14104f9ad
0104f99e b101 mov cl, 1
0104f9a0 e86be6ffff call 0x14104e010
0104f9a5 4032ff xor dil, dil
0104f9a8 b914009400 mov ecx, 0x940014
0104f9ad e85e1babff call 0x140b01510
0104f9b2 4084ff test dil, dil
0104f9b5 7410 je 0x14104f9c7
0104f9b7 4183ff80 cmp r15d, -0x80
0104f9bb 740a je 0x14104f9c7
0104f9bd b915009400 mov ecx, 0x940015
0104f9c2 e8491babff call 0x140b01510
0104f9c7 488b4da0 mov rcx, qword ptr [rbp - 0x60]
0104f9cb 4885c9 test rcx, rcx
0104f9ce 740e je 0x14104f9de
0104f9d0 488b0579cc0801 mov rax, qword ptr [rip + 0x108cc79]
0104f9d7 488988a0000000 mov qword ptr [rax + 0xa0], rcx
0104f9de 33c9 xor ecx, ecx
0104f9e0 e82be6ffff call 0x14104e010
0104f9e5 488b5da8 mov rbx, qword ptr [rbp - 0x58]
0104f9e9 4885db test rbx, rbx
0104f9ec 0f84f2000000 je 0x14104fae4
0104f9f2 817b0862707469 cmp dword ptr [rbx + 8], 0x69747062
0104f9f9 0f85e5000000 jne 0x14104fae4
0104f9ff 488b8b30080000 mov rcx, qword ptr [rbx + 0x830]
0104fa06 4885c9 test rcx, rcx
0104fa09 7409 je 0x14104fa14
0104fa0b 4883c110 add rcx, 0x10
0104fa0f e89cbeadff call 0x140b2b8b0
0104fa14 f20f108b48080000 movsd xmm1, qword ptr [rbx + 0x848]
0104fa1c 0f57c0 xorps xmm0, xmm0
0104fa1f 660f2ec8 ucomisd xmm1, xmm0
0104fa23 7a02 jp 0x14104fa27
0104fa25 742e je 0x14104fa55
0104fa27 488b0502750501 mov rax, qword ptr [rip + 0x1057502]
0104fa2e 33ff xor edi, edi
0104fa30 4885c0 test rax, rax
0104fa33 8bcf mov ecx, edi
0104fa35 7407 je 0x14104fa3e
0104fa37 488d88184c0100 lea rcx, [rax + 0x14c18]
0104fa3e 48897c2420 mov qword ptr [rsp + 0x20], rdi
0104fa43 4533c9 xor r9d, r9d
0104fa46 4c8bc3 mov r8, rbx
0104fa49 ba67727068 mov edx, 0x68707267
0104fa4e e8cd62aaff call 0x140af5d20
0104fa53 eb02 jmp 0x14104fa57
0104fa55 33ff xor edi, edi
0104fa57 488b05d2740501 mov rax, qword ptr [rip + 0x10574d2]
0104fa5e 4885c0 test rax, rax
0104fa61 488bcf mov rcx, rdi
0104fa64 7407 je 0x14104fa6d
0104fa66 488d88184c0100 lea rcx, [rax + 0x14c18]
0104fa6d 48897c2420 mov qword ptr [rsp + 0x20], rdi
0104fa72 4533c9 xor r9d, r9d
0104fa75 4c8bc3 mov r8, rbx
0104fa78 ba67727064 mov edx, 0x64707267
0104fa7d e89e62aaff call 0x140af5d20
0104fa82 488d8b58080000 lea rcx, [rbx + 0x858]
0104fa89 e87265aaff call 0x140af6000
0104fa8e 488b0503830801 mov rax, qword ptr [rip + 0x1088303]
0104fa95 488bcf mov rcx, rdi
0104fa98 4885c0 test rax, rax
0104fa9b 743c je 0x14104fad9
0104fa9d 0f1f00 nop dword ptr [rax]
0104faa0 483bc3 cmp rax, rbx
0104faa3 741d je 0x14104fac2
0104faa5 488bc8 mov rcx, rax
0104faa8 488b00 mov rax, qword ptr [rax]
0104faab 4885c0 test rax, rax
0104faae 75f0 jne 0x14104faa0
0104fab0 897b08 mov dword ptr [rbx + 8], edi
0104fab3 488bcb mov rcx, rbx
0104fab6 e8b508caff call 0x140cf0370
0104fabb 0fb6442451 movzx eax, byte ptr [rsp + 0x51]
0104fac0 eb2b jmp 0x14104faed
0104fac2 488b03 mov rax, qword ptr [rbx]
0104fac5 4885c9 test rcx, rcx
0104fac8 7509 jne 0x14104fad3
0104faca 488905c7820801 mov qword ptr [rip + 0x10882c7], rax
0104fad1 eb03 jmp 0x14104fad6
0104fad3 488901 mov qword ptr [rcx], rax
0104fad6 48893b mov qword ptr [rbx], rdi
0104fad9 897b08 mov dword ptr [rbx + 8], edi
0104fadc 488bcb mov rcx, rbx
0104fadf e88c08caff call 0x140cf0370
0104fae4 0fb6442451 movzx eax, byte ptr [rsp + 0x51]
0104fae9 eb02 jmp 0x14104faed
0104faeb 32c0 xor al, al
0104faed 488b8d90160000 mov rcx, qword ptr [rbp + 0x1690]
0104faf4 4833cc xor rcx, rsp
0104faf7 e8e4bd7400 call 0x14179b8e0
0104fafc 488b9c24f8170000 mov rbx, qword ptr [rsp + 0x17f8]
0104fb04 4881c4a0170000 add rsp, 0x17a0
0104fb0b 415f pop r15
0104fb0d 415e pop r14
0104fb0f 415d pop r13
0104fb11 415c pop r12
0104fb13 5f pop rdi
0104fb14 5e pop rsi
0104fb15 5d pop rbp
0104fb16 c3 ret 