010dea90 48895c2418 mov qword ptr [rsp + 0x18], rbx
010dea95 48894c2408 mov qword ptr [rsp + 8], rcx
010dea9a 55 push rbp
010dea9b 56 push rsi
010dea9c 57 push rdi
010dea9d 4154 push r12
010dea9f 4155 push r13
010deaa1 4156 push r14
010deaa3 4157 push r15
010deaa5 4883ec60 sub rsp, 0x60
010deaa9 498bf1 mov rsi, r9
010deaac 458bf0 mov r14d, r8d
010deaaf 8b02 mov eax, dword ptr [rdx]
010deab1 c1e81f shr eax, 0x1f
010deab4 84c0 test al, al
010deab6 7407 je 0x1410deabf
010deab8 32c0 xor al, al
010deaba e9a8030000 jmp 0x1410dee67
010deabf 4885f6 test rsi, rsi
010deac2 7417 je 0x1410deadb
010deac4 0f57c0 xorps xmm0, xmm0
010deac7 33c0 xor eax, eax
010deac9 410f1101 movups xmmword ptr [r9], xmm0
010deacd 410f114110 movups xmmword ptr [r9 + 0x10], xmm0
010dead2 410f114120 movups xmmword ptr [r9 + 0x20], xmm0
010dead7 49894130 mov qword ptr [r9 + 0x30], rax
010deadb 41b101 mov r9b, 1
010deade 4c8bc2 mov r8, rdx
010deae1 488d542448 lea rdx, [rsp + 0x48]
010deae6 e8b5b8ffff call 0x1410da3a0
010deaeb 90 nop 
010deaec 41bfffffffff mov r15d, 0xffffffff
010deaf2 488b4c2448 mov rcx, qword ptr [rsp + 0x48]
010deaf7 4885c9 test rcx, rcx
010deafa 7508 jne 0x1410deb04
010deafc 4032ff xor dil, dil
010deaff e92b030000 jmp 0x1410dee2f
010deb04 41b001 mov r8b, 1
010deb07 488d542438 lea rdx, [rsp + 0x38]
010deb0c e8ef7cffff call 0x1410d6800
010deb11 90 nop 
010deb12 4c8b6c2438 mov r13, qword ptr [rsp + 0x38]
010deb17 4d85ed test r13, r13
010deb1a 7508 jne 0x1410deb24
010deb1c 4032ff xor dil, dil
010deb1f e9d5020000 jmp 0x1410dedf9
010deb24 498b4500 mov rax, qword ptr [r13]
010deb28 498bcd mov rcx, r13
010deb2b ff5028 call qword ptr [rax + 0x28]
010deb2e 488be8 mov rbp, rax
010deb31 48898424a8000000 mov qword ptr [rsp + 0xa8], rax
010deb39 4533e4 xor r12d, r12d
010deb3c 85c0 test eax, eax
010deb3e 0f8e4f020000 jle 0x1410ded93
010deb44 33ff xor edi, edi
010deb46 48897c2420 mov qword ptr [rsp + 0x20], rdi
010deb4b 0f1f440000 nop dword ptr [rax + rax]
010deb50 498b4500 mov rax, qword ptr [r13]
010deb54 4c8bc7 mov r8, rdi
010deb57 488d542428 lea rdx, [rsp + 0x28]
010deb5c 498bcd mov rcx, r13
010deb5f ff5060 call qword ptr [rax + 0x60]
010deb62 90 nop 
010deb63 4c8b442428 mov r8, qword ptr [rsp + 0x28]
010deb68 4d85c0 test r8, r8
010deb6b 0f84d9010000 je 0x1410ded4a
010deb71 418bd4 mov edx, r12d
010deb74 c1ea03 shr edx, 3
010deb77 410fb6cc movzx ecx, r12b
010deb7b 83e107 and ecx, 7
010deb7e 41b901000000 mov r9d, 1
010deb84 41d2e1 shl r9b, cl
010deb87 4d8b95f0010000 mov r10, qword ptr [r13 + 0x1f0]
010deb8e 8d4a01 lea ecx, [rdx + 1]
010deb91 49394a10 cmp qword ptr [r10 + 0x10], rcx
010deb95 7214 jb 0x1410debab
010deb97 498b4a08 mov rcx, qword ptr [r10 + 8]
010deb9b 4885c9 test rcx, rcx
010deb9e 740b je 0x1410debab
010deba0 44840c0a test byte ptr [rdx + rcx], r9b
010deba4 7405 je 0x1410debab
010deba6 40b501 mov bpl, 1
010deba9 eb03 jmp 0x1410debae
010debab 4032ed xor bpl, bpl
010debae 498b00 mov rax, qword ptr [r8]
010debb1 498bc8 mov rcx, r8
010debb4 ff5030 call qword ptr [rax + 0x30]
010debb7 3d6d626c61 cmp eax, 0x616c626d
010debbc 0f84b4000000 je 0x1410dec76
010debc2 3d646c6966 cmp eax, 0x66696c64
010debc7 0f84a9000000 je 0x1410dec76
010debcd 3d6b617274 cmp eax, 0x7472616b
010debd2 0f856a010000 jne 0x1410ded42
010debd8 488b4c2428 mov rcx, qword ptr [rsp + 0x28]
010debdd 488b01 mov rax, qword ptr [rcx]
010debe0 ff5050 call qword ptr [rax + 0x50]
010debe3 488bd8 mov rbx, rax
010debe6 4885c0 test rax, rax
010debe9 0f8453010000 je 0x1410ded42
010debef 440fb6cd movzx r9d, bpl
010debf3 458bc6 mov r8d, r14d
010debf6 488bd0 mov rdx, rax
010debf9 488bce mov rcx, rsi
010debfc e8bffdffff call 0x1410de9c0
010dec01 84c0 test al, al
010dec03 0f8439010000 je 0x1410ded42
010dec09 41f6c602 test r14b, 2
010dec0d 0f842f010000 je 0x1410ded42
010dec13 488b5b30 mov rbx, qword ptr [rbx + 0x30]
010dec17 4885db test rbx, rbx
010dec1a 7450 je 0x1410dec6c
010dec1c 48837b1000 cmp qword ptr [rbx + 0x10], 0
010dec21 7449 je 0x1410dec6c
010dec23 f6839a00000001 test byte ptr [rbx + 0x9a], 1
010dec2a 7440 je 0x1410dec6c
010dec2c 488b4368 mov rax, qword ptr [rbx + 0x68]
010dec30 8b4010 mov eax, dword ptr [rax + 0x10]
010dec33 85c0 test eax, eax
010dec35 7537 jne 0x1410dec6e
010dec37 3983ac000000 cmp dword ptr [rbx + 0xac], eax
010dec3d 751f jne 0x1410dec5e
010dec3f 488bcb mov rcx, rbx
010dec42 e8f925ebff call 0x140f91240
010dec47 8983ac000000 mov dword ptr [rbx + 0xac], eax
010dec4d 85c0 test eax, eax
010dec4f 740d je 0x1410dec5e
010dec51 ba3c000000 mov edx, 0x3c
010dec56 488bcb mov rcx, rbx
010dec59 e8a254ebff call 0x140f94100
010dec5e 8b83ac000000 mov eax, dword ptr [rbx + 0xac]
010dec64 094604 or dword ptr [rsi + 4], eax
010dec67 e9d6000000 jmp 0x1410ded42
010dec6c 33c0 xor eax, eax
010dec6e 094604 or dword ptr [rsi + 4], eax
010dec71 e9cc000000 jmp 0x1410ded42
010dec76 488b4c2428 mov rcx, qword ptr [rsp + 0x28]
010dec7b 488b01 mov rax, qword ptr [rcx]
010dec7e ff5078 call qword ptr [rax + 0x78]
010dec81 488bd8 mov rbx, rax
010dec84 488b4c2428 mov rcx, qword ptr [rsp + 0x28]
010dec89 488b01 mov rax, qword ptr [rcx]
010dec8c ff5058 call qword ptr [rax + 0x58]
010dec8f 488bf8 mov rdi, rax
010dec92 4885db test rbx, rbx
010dec95 0f84a2000000 je 0x1410ded3d
010dec9b 817b0869626c61 cmp dword ptr [rbx + 8], 0x616c6269
010deca2 0f8595000000 jne 0x1410ded3d
010deca8 48837b3000 cmp qword ptr [rbx + 0x30], 0
010decad 0f848a000000 je 0x1410ded3d
010decb3 807b5800 cmp byte ptr [rbx + 0x58], 0
010decb7 7508 jne 0x1410decc1
010decb9 488bcb mov rcx, rbx
010decbc e8ef59feff call 0x1410c46b0
010decc1 488b5b48 mov rbx, qword ptr [rbx + 0x48]
010decc5 4885db test rbx, rbx
010decc8 7473 je 0x1410ded3d
010decca 660f1f440000 nop word ptr [rax + rax]
010decd0 4885ff test rdi, rdi
010decd3 7431 je 0x1410ded06
010decd5 813f74736c70 cmp dword ptr [rdi], 0x706c7374
010decdb 7525 jne 0x1410ded02
010decdd 4885db test rbx, rbx
010dece0 7420 je 0x1410ded02
010dece2 48837b1000 cmp qword ptr [rbx + 0x10], 0
010dece7 7419 je 0x1410ded02
010dece9 488b4360 mov rax, qword ptr [rbx + 0x60]
010deced 4885c0 test rax, rax
010decf0 7433 je 0x1410ded25
010decf2 483938 cmp qword ptr [rax], rdi
010decf5 7417 je 0x1410ded0e
010decf7 488b4038 mov rax, qword ptr [rax + 0x38]
010decfb 4885c0 test rax, rax
010decfe 75f2 jne 0x1410decf2
010ded00 eb0c jmp 0x1410ded0e
010ded02 33c0 xor eax, eax
010ded04 eb08 jmp 0x1410ded0e
010ded06 488bcb mov rcx, rbx
010ded09 e80286e1ff call 0x140ef7310
010ded0e 4885c0 test rax, rax
010ded11 7412 je 0x1410ded25
010ded13 440fb6cd movzx r9d, bpl
010ded17 458bc6 mov r8d, r14d
010ded1a 488bd0 mov rdx, rax
010ded1d 488bce mov rcx, rsi
010ded20 e89bfcffff call 0x1410de9c0
010ded25 4885db test rbx, rbx
010ded28 7413 je 0x1410ded3d
010ded2a 48837b1000 cmp qword ptr [rbx + 0x10], 0
010ded2f 740c je 0x1410ded3d
010ded31 488b4330 mov rax, qword ptr [rbx + 0x30]
010ded35 488bd8 mov rbx, rax
010ded38 4885c0 test rax, rax
010ded3b 7593 jne 0x1410decd0
010ded3d 488b7c2420 mov rdi, qword ptr [rsp + 0x20]
010ded42 488bac24a8000000 mov rbp, qword ptr [rsp + 0xa8]
010ded4a 488b5c2430 mov rbx, qword ptr [rsp + 0x30]
010ded4f 4885db test rbx, rbx
010ded52 742b je 0x1410ded7f
010ded54 418bc7 mov eax, r15d
010ded57 f00fc14308 lock xadd dword ptr [rbx + 8], eax
010ded5c 83f801 cmp eax, 1
010ded5f 751e jne 0x1410ded7f
010ded61 488b03 mov rax, qword ptr [rbx]
010ded64 488bcb mov rcx, rbx
010ded67 ff10 call qword ptr [rax]
010ded69 418bc7 mov eax, r15d
010ded6c f00fc1430c lock xadd dword ptr [rbx + 0xc], eax
010ded71 83f801 cmp eax, 1
010ded74 7509 jne 0x1410ded7f
010ded76 488b03 mov rax, qword ptr [rbx]
010ded79 488bcb mov rcx, rbx
010ded7c ff5008 call qword ptr [rax + 8]
010ded7f 41ffc4 inc r12d
010ded82 48ffc7 inc rdi
010ded85 48897c2420 mov qword ptr [rsp + 0x20], rdi
010ded8a 443be5 cmp r12d, ebp
010ded8d 0f8cbdfdffff jl 0x1410deb50
010ded93 488b9c24a0000000 mov rbx, qword ptr [rsp + 0xa0]
010ded9b 488b5b70 mov rbx, qword ptr [rbx + 0x70]
010ded9f 4885db test rbx, rbx
010deda2 743a je 0x1410dedde
010deda4 41f6c601 test r14b, 1
010deda8 7522 jne 0x1410dedcc
010dedaa 41f6c602 test r14b, 2
010dedae 750d jne 0x1410dedbd
010dedb0 33d2 xor edx, edx
010dedb2 488bcb mov rcx, rbx
010dedb5 e8b6dfe1ff call 0x140efcd70
010dedba 894604 mov dword ptr [rsi + 4], eax
010dedbd 8b4604 mov eax, dword ptr [rsi + 4]
010dedc0 85c0 test eax, eax
010dedc2 7408 je 0x1410dedcc
010dedc4 83f801 cmp eax, 1
010dedc7 7403 je 0x1410dedcc
010dedc9 830e02 or dword ptr [rsi], 2
010dedcc 81bbf0010000656e7574 cmp dword ptr [rbx + 0x1f0], 0x74756e65
010dedd6 7503 jne 0x1410deddb
010dedd8 830e01 or dword ptr [rsi], 1
010deddb 830e10 or dword ptr [rsi], 0x10
010dedde 41f6c608 test r14b, 8
010dede2 7412 je 0x1410dedf6
010dede4 8b4e04 mov ecx, dword ptr [rsi + 4]
010dede7 8bc1 mov eax, ecx
010dede9 83e021 and eax, 0x21
010dedec 3c21 cmp al, 0x21
010dedee 7506 jne 0x1410dedf6
010dedf0 83e1df and ecx, 0xffffffdf
010dedf3 894e04 mov dword ptr [rsi + 4], ecx
010dedf6 40b701 mov dil, 1
010dedf9 488b5c2440 mov rbx, qword ptr [rsp + 0x40]
010dedfe 4885db test rbx, rbx
010dee01 742c je 0x1410dee2f
010dee03 418bc7 mov eax, r15d
010dee06 f00fc14308 lock xadd dword ptr [rbx + 8], eax
010dee0b 83f801 cmp eax, 1
010dee0e 751f jne 0x1410dee2f
010dee10 488b03 mov rax, qword ptr [rbx]
010dee13 488bcb mov rcx, rbx
010dee16 ff10 call qword ptr [rax]
010dee18 418bc7 mov eax, r15d
010dee1b f00fc1430c lock xadd dword ptr [rbx + 0xc], eax
010dee20 83f801 cmp eax, 1
010dee23 750a jne 0x1410dee2f
010dee25 488b03 mov rax, qword ptr [rbx]
010dee28 488bcb mov rcx, rbx
010dee2b ff5008 call qword ptr [rax + 8]
010dee2e 90 nop 
010dee2f 488b5c2450 mov rbx, qword ptr [rsp + 0x50]
010dee34 4885db test rbx, rbx
010dee37 742a je 0x1410dee63
010dee39 418bc7 mov eax, r15d
010dee3c f00fc14308 lock xadd dword ptr [rbx + 8], eax
010dee41 83f801 cmp eax, 1
010dee44 751d jne 0x1410dee63
010dee46 488b03 mov rax, qword ptr [rbx]
010dee49 488bcb mov rcx, rbx
010dee4c ff10 call qword ptr [rax]
010dee4e f0440fc17b0c lock xadd dword ptr [rbx + 0xc], r15d
010dee54 4183ff01 cmp r15d, 1
010dee58 7509 jne 0x1410dee63
010dee5a 488b13 mov rdx, qword ptr [rbx]
010dee5d 488bcb mov rcx, rbx
010dee60 ff5208 call qword ptr [rdx + 8]
010dee63 400fb6c7 movzx eax, dil
010dee67 488b9c24b0000000 mov rbx, qword ptr [rsp + 0xb0]
010dee6f 4883c460 add rsp, 0x60
010dee73 415f pop r15
010dee75 415e pop r14
010dee77 415d pop r13
010dee79 415c pop r12
010dee7b 5f pop rdi
010dee7c 5e pop rsi
010dee7d 5d pop rbp
010dee7e c3 ret 