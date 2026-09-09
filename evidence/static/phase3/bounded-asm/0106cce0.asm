0106cce0 48895c2418 mov qword ptr [rsp + 0x18], rbx
0106cce5 55 push rbp
0106cce6 56 push rsi
0106cce7 57 push rdi
0106cce8 4154 push r12
0106ccea 4155 push r13
0106ccec 4156 push r14
0106ccee 4157 push r15
0106ccf0 488dac2490feffff lea rbp, [rsp - 0x170]
0106ccf8 4881ec70020000 sub rsp, 0x270
0106ccff 488b053a83f600 mov rax, qword ptr [rip + 0xf6833a]
0106cd06 4833c4 xor rax, rsp
0106cd09 48898560010000 mov qword ptr [rbp + 0x160], rax
0106cd10 488bda mov rbx, rdx
0106cd13 488bf1 mov rsi, rcx
0106cd16 0f57c0 xorps xmm0, xmm0
0106cd19 0f118500010000 movups xmmword ptr [rbp + 0x100], xmm0
0106cd20 0f118510010000 movups xmmword ptr [rbp + 0x110], xmm0
0106cd27 0f118520010000 movups xmmword ptr [rbp + 0x120], xmm0
0106cd2e 0f118530010000 movups xmmword ptr [rbp + 0x130], xmm0
0106cd35 0f118540010000 movups xmmword ptr [rbp + 0x140], xmm0
0106cd3c 0f118550010000 movups xmmword ptr [rbp + 0x150], xmm0
0106cd43 c785000100006d736468 mov dword ptr [rbp + 0x100], 0x6864736d
0106cd4d c7850401000060000000 mov dword ptr [rbp + 0x104], 0x60
0106cd57 c7850c0100000c000000 mov dword ptr [rbp + 0x10c], 0xc
0106cd61 488bb920010000 mov rdi, qword ptr [rcx + 0x120]
0106cd68 4533e4 xor r12d, r12d
0106cd6b 4c89642438 mov qword ptr [rsp + 0x38], r12
0106cd70 44386705 cmp byte ptr [rdi + 5], r12b
0106cd74 740b je 0x14106cd81
0106cd76 488b4740 mov rax, qword ptr [rdi + 0x40]
0106cd7a 4889442438 mov qword ptr [rsp + 0x38], rax
0106cd7f eb1b jmp 0x14106cd9c
0106cd81 488d542438 lea rdx, [rsp + 0x38]
0106cd86 488b4f08 mov rcx, qword ptr [rdi + 8]
0106cd8a e8b198b6ff call 0x140bd6640
0106cd8f 85c0 test eax, eax
0106cd91 0f8586090000 jne 0x14106d71d
0106cd97 488b442438 mov rax, qword ptr [rsp + 0x38]
0106cd9c 488b4f20 mov rcx, qword ptr [rdi + 0x20]
0106cda0 44386705 cmp byte ptr [rdi + 5], r12b
0106cda4 7409 je 0x14106cdaf
0106cda6 482b4f38 sub rcx, qword ptr [rdi + 0x38]
0106cdaa 48ffc9 dec rcx
0106cdad eb04 jmp 0x14106cdb3
0106cdaf 482b4f30 sub rcx, qword ptr [rdi + 0x30]
0106cdb3 4803c1 add rax, rcx
0106cdb6 4889442438 mov qword ptr [rsp + 0x38], rax
0106cdbb 48c744242060000000 mov qword ptr [rsp + 0x20], 0x60
0106cdc4 4c8d8500010000 lea r8, [rbp + 0x100]
0106cdcb 488d542420 lea rdx, [rsp + 0x20]
0106cdd0 488b8e20010000 mov rcx, qword ptr [rsi + 0x120]
0106cdd7 e8e436b3ff call 0x140ba04c0
0106cddc 85c0 test eax, eax
0106cdde 0f8539090000 jne 0x14106d71d
0106cde4 33d2 xor edx, edx
0106cde6 41b818010000 mov r8d, 0x118
0106cdec 488d4de0 lea rcx, [rbp - 0x20]
0106cdf0 e8abfe7200 call 0x14179cca0
0106cdf5 c745e06d686768 mov dword ptr [rbp - 0x20], 0x6867686d
0106cdfc c745e418010000 mov dword ptr [rbp - 0x1c], 0x118
0106ce03 c645ee2c mov byte ptr [rbp - 0x12], 0x2c
0106ce07 0fb64377 movzx eax, byte ptr [rbx + 0x77]
0106ce0b 884519 mov byte ptr [rbp + 0x19], al
0106ce0e 0fb64378 movzx eax, byte ptr [rbx + 0x78]
0106ce12 88451a mov byte ptr [rbp + 0x1a], al
0106ce15 0fb64379 movzx eax, byte ptr [rbx + 0x79]
0106ce19 88451b mov byte ptr [rbp + 0x1b], al
0106ce1c 48833dec800301ff cmp qword ptr [rip + 0x10380ec], -1
0106ce24 7416 je 0x14106ce3c
0106ce26 4c8d0593d06bff lea r8, [rip - 0x942f6d]
0106ce2d 33d2 xor edx, edx
0106ce2f 488d0dda800301 lea rcx, [rip + 0x10380da]
0106ce36 ff15f4fe8700 call qword ptr [rip + 0x87fef4]
0106ce3c ff15d6e18700 call qword ptr [rip + 0x87e1d6]
0106ce42 4c8b355f250601 mov r14, qword ptr [rip + 0x106255f]
0106ce49 4d85f6 test r14, r14
0106ce4c 740c je 0x14106ce5a
0106ce4e f041ff4608 lock inc dword ptr [r14 + 8]
0106ce53 4c8b354e250601 mov r14, qword ptr [rip + 0x106254e]
0106ce5a 4c8b3d3f250601 mov r15, qword ptr [rip + 0x106253f]
0106ce61 4c897c2448 mov qword ptr [rsp + 0x48], r15
0106ce66 ff15b4e18700 call qword ptr [rip + 0x87e1b4]
0106ce6c 4c897dc8 mov qword ptr [rbp - 0x38], r15
0106ce70 4c8975d0 mov qword ptr [rbp - 0x30], r14
0106ce74 498b07 mov rax, qword ptr [r15]
0106ce77 33d2 xor edx, edx
0106ce79 498bcf mov rcx, r15
0106ce7c ff5020 call qword ptr [rax + 0x20]
0106ce7f 84c0 test al, al
0106ce81 740d je 0x14106ce90
0106ce83 498b07 mov rax, qword ptr [r15]
0106ce86 498bcf mov rcx, r15
0106ce89 ff5050 call qword ptr [rax + 0x50]
0106ce8c 48894550 mov qword ptr [rbp + 0x50], rax
0106ce90 0fb6839a000000 movzx eax, byte ptr [rbx + 0x9a]
0106ce97 88451d mov byte ptr [rbp + 0x1d], al
0106ce9a 0fb6839b000000 movzx eax, byte ptr [rbx + 0x9b]
0106cea1 88451e mov byte ptr [rbp + 0x1e], al
0106cea4 488b430c mov rax, qword ptr [rbx + 0xc]
0106cea8 48894548 mov qword ptr [rbp + 0x48], rax
0106ceac 0fb64301 movzx eax, byte ptr [rbx + 1]
0106ceb0 8845ec mov byte ptr [rbp - 0x14], al
0106ceb3 0fb64302 movzx eax, byte ptr [rbx + 2]
0106ceb7 884529 mov byte ptr [rbp + 0x29], al
0106ceba 0fb64303 movzx eax, byte ptr [rbx + 3]
0106cebe 8845ed mov byte ptr [rbp - 0x13], al
0106cec1 8b4304 mov eax, dword ptr [rbx + 4]
0106cec4 8945f0 mov dword ptr [rbp - 0x10], eax
0106cec7 8b4308 mov eax, dword ptr [rbx + 8]
0106ceca 8945f4 mov dword ptr [rbp - 0xc], eax
0106cecd 488b433a mov rax, qword ptr [rbx + 0x3a]
0106ced1 48894520 mov qword ptr [rbp + 0x20], rax
0106ced5 0fb64338 movzx eax, byte ptr [rbx + 0x38]
0106ced9 884528 mov byte ptr [rbp + 0x28], al
0106cedc 488b4352 mov rax, qword ptr [rbx + 0x52]
0106cee0 48894538 mov qword ptr [rbp + 0x38], rax
0106cee4 8b435a mov eax, dword ptr [rbx + 0x5a]
0106cee7 894534 mov dword ptr [rbp + 0x34], eax
0106ceea 8b4334 mov eax, dword ptr [rbx + 0x34]
0106ceed 894568 mov dword ptr [rbp + 0x68], eax
0106cef0 c6452a00 mov byte ptr [rbp + 0x2a], 0
0106cef4 0fb6435e movzx eax, byte ptr [rbx + 0x5e]
0106cef8 88452b mov byte ptr [rbp + 0x2b], al
0106cefb 0fb6435f movzx eax, byte ptr [rbx + 0x5f]
0106ceff 884540 mov byte ptr [rbp + 0x40], al
0106cf02 0fb64360 movzx eax, byte ptr [rbx + 0x60]
0106cf06 884541 mov byte ptr [rbp + 0x41], al
0106cf09 0fb64361 movzx eax, byte ptr [rbx + 0x61]
0106cf0d 884542 mov byte ptr [rbp + 0x42], al
0106cf10 0fb64362 movzx eax, byte ptr [rbx + 0x62]
0106cf14 884543 mov byte ptr [rbp + 0x43], al
0106cf17 8b4366 mov eax, dword ptr [rbx + 0x66]
0106cf1a 894564 mov dword ptr [rbp + 0x64], eax
0106cf1d 8b436a mov eax, dword ptr [rbx + 0x6a]
0106cf20 89456c mov dword ptr [rbp + 0x6c], eax
0106cf23 488b436e mov rax, qword ptr [rbx + 0x6e]
0106cf27 4889455c mov qword ptr [rbp + 0x5c], rax
0106cf2b 0fb64376 movzx eax, byte ptr [rbx + 0x76]
0106cf2f 884558 mov byte ptr [rbp + 0x58], al
0106cf32 488b839c000000 mov rax, qword ptr [rbx + 0x9c]
0106cf39 488945f8 mov qword ptr [rbp - 8], rax
0106cf3d 0fb683b4000000 movzx eax, byte ptr [rbx + 0xb4]
0106cf44 884500 mov byte ptr [rbp], al
0106cf47 0fb683d6000000 movzx eax, byte ptr [rbx + 0xd6]
0106cf4e 884501 mov byte ptr [rbp + 1], al
0106cf51 0fb68380050000 movzx eax, byte ptr [rbx + 0x580]
0106cf58 884502 mov byte ptr [rbp + 2], al
0106cf5b 0fb68381050000 movzx eax, byte ptr [rbx + 0x581]
0106cf62 884503 mov byte ptr [rbp + 3], al
0106cf65 0fb68382050000 movzx eax, byte ptr [rbx + 0x582]
0106cf6c 884509 mov byte ptr [rbp + 9], al
0106cf6f 80bb8305000002 cmp byte ptr [rbx + 0x583], 2
0106cf76 0f944504 sete byte ptr [rbp + 4]
0106cf7a 80bb8405000002 cmp byte ptr [rbx + 0x584], 2
0106cf81 0f944505 sete byte ptr [rbp + 5]
0106cf85 80bb8505000002 cmp byte ptr [rbx + 0x585], 2
0106cf8c 0f944506 sete byte ptr [rbp + 6]
0106cf90 c6450a01 mov byte ptr [rbp + 0xa], 1
0106cf94 80bb8605000002 cmp byte ptr [rbx + 0x586], 2
0106cf9b 0f9445ef sete byte ptr [rbp - 0x11]
0106cf9f 80bb8705000002 cmp byte ptr [rbx + 0x587], 2
0106cfa6 0f944512 sete byte ptr [rbp + 0x12]
0106cfaa 0fb6838b050000 movzx eax, byte ptr [rbx + 0x58b]
0106cfb1 884515 mov byte ptr [rbp + 0x15], al
0106cfb4 0fb68b8e050000 movzx ecx, byte ptr [rbx + 0x58e]
0106cfbb 884d17 mov byte ptr [rbp + 0x17], cl
0106cfbe 0fb6838d050000 movzx eax, byte ptr [rbx + 0x58d]
0106cfc5 88451f mov byte ptr [rbp + 0x1f], al
0106cfc8 0fb683b4050000 movzx eax, byte ptr [rbx + 0x5b4]
0106cfcf 88455b mov byte ptr [rbp + 0x5b], al
0106cfd2 80f901 cmp cl, 1
0106cfd5 7205 jb 0x14106cfdc
0106cfd7 80f903 cmp cl, 3
0106cfda 7604 jbe 0x14106cfe0
0106cfdc c6451703 mov byte ptr [rbp + 0x17], 3
0106cfe0 0fb68388050000 movzx eax, byte ptr [rbx + 0x588]
0106cfe7 88450c mov byte ptr [rbp + 0xc], al
0106cfea 0fb68389050000 movzx eax, byte ptr [rbx + 0x589]
0106cff1 88450d mov byte ptr [rbp + 0xd], al
0106cff4 0fb6838a050000 movzx eax, byte ptr [rbx + 0x58a]
0106cffb 88450e mov byte ptr [rbp + 0xe], al
0106cffe 0fb683a5050000 movzx eax, byte ptr [rbx + 0x5a5]
0106d005 8885b1000000 mov byte ptr [rbp + 0xb1], al
0106d00b 0fb683a6050000 movzx eax, byte ptr [rbx + 0x5a6]
0106d012 8885b2000000 mov byte ptr [rbp + 0xb2], al
0106d018 0fb683aa050000 movzx eax, byte ptr [rbx + 0x5aa]
0106d01f 8885b3000000 mov byte ptr [rbp + 0xb3], al
0106d025 0fb683a2050000 movzx eax, byte ptr [rbx + 0x5a2]
0106d02c 884574 mov byte ptr [rbp + 0x74], al
0106d02f 0fb683a3050000 movzx eax, byte ptr [rbx + 0x5a3]
0106d036 884575 mov byte ptr [rbp + 0x75], al
0106d039 c6457601 mov byte ptr [rbp + 0x76], 1
0106d03d 0fb683ae050000 movzx eax, byte ptr [rbx + 0x5ae]
0106d044 888580000000 mov byte ptr [rbp + 0x80], al
0106d04a 0fb683af050000 movzx eax, byte ptr [rbx + 0x5af]
0106d051 888582000000 mov byte ptr [rbp + 0x82], al
0106d057 0fb683ec050000 movzx eax, byte ptr [rbx + 0x5ec]
0106d05e 8885c8000000 mov byte ptr [rbp + 0xc8], al
0106d064 0fb683b0050000 movzx eax, byte ptr [rbx + 0x5b0]
0106d06b 888583000000 mov byte ptr [rbp + 0x83], al
0106d071 0fb683b1050000 movzx eax, byte ptr [rbx + 0x5b1]
0106d078 884577 mov byte ptr [rbp + 0x77], al
0106d07b 0fb683b2050000 movzx eax, byte ptr [rbx + 0x5b2]
0106d082 884559 mov byte ptr [rbp + 0x59], al
0106d085 0fb683b3050000 movzx eax, byte ptr [rbx + 0x5b3]
0106d08c 884544 mov byte ptr [rbp + 0x44], al
0106d08f 0fb683b8050000 movzx eax, byte ptr [rbx + 0x5b8]
0106d096 884547 mov byte ptr [rbp + 0x47], al
0106d099 8b83bc050000 mov eax, dword ptr [rbx + 0x5bc]
0106d09f 898588000000 mov dword ptr [rbp + 0x88], eax
0106d0a5 8b83c0050000 mov eax, dword ptr [rbx + 0x5c0]
0106d0ab 89858c000000 mov dword ptr [rbp + 0x8c], eax
0106d0b1 8b83c4050000 mov eax, dword ptr [rbx + 0x5c4]
0106d0b7 898590000000 mov dword ptr [rbp + 0x90], eax
0106d0bd 8b83c8050000 mov eax, dword ptr [rbx + 0x5c8]
0106d0c3 898594000000 mov dword ptr [rbp + 0x94], eax
0106d0c9 0fb783ba050000 movzx eax, word ptr [rbx + 0x5ba]
0106d0d0 66898586000000 mov word ptr [rbp + 0x86], ax
0106d0d7 0fb683cc050000 movzx eax, byte ptr [rbx + 0x5cc]
0106d0de 8885bc000000 mov byte ptr [rbp + 0xbc], al
0106d0e4 0fb683d0050000 movzx eax, byte ptr [rbx + 0x5d0]
0106d0eb 8885bd000000 mov byte ptr [rbp + 0xbd], al
0106d0f1 488b83d2050000 mov rax, qword ptr [rbx + 0x5d2]
0106d0f8 488985a8000000 mov qword ptr [rbp + 0xa8], rax
0106d0ff 0fb683da050000 movzx eax, byte ptr [rbx + 0x5da]
0106d106 8885b0000000 mov byte ptr [rbp + 0xb0], al
0106d10c 488b83dc050000 mov rax, qword ptr [rbx + 0x5dc]
0106d113 488985b4000000 mov qword ptr [rbp + 0xb4], rax
0106d11a 0fb683e4050000 movzx eax, byte ptr [rbx + 0x5e4]
0106d121 8885be000000 mov byte ptr [rbp + 0xbe], al
0106d127 0fb64363 movzx eax, byte ptr [rbx + 0x63]
0106d12b 8885bf000000 mov byte ptr [rbp + 0xbf], al
0106d131 8b83e6050000 mov eax, dword ptr [rbx + 0x5e6]
0106d137 8985c0000000 mov dword ptr [rbp + 0xc0], eax
0106d13d 440fb6838f050000 movzx r8d, byte ptr [rbx + 0x58f]
0106d145 448885c4000000 mov byte ptr [rbp + 0xc4], r8b
0106d14c 0fb68390050000 movzx eax, byte ptr [rbx + 0x590]
0106d153 8885c6000000 mov byte ptr [rbp + 0xc6], al
0106d159 0fb683eb050000 movzx eax, byte ptr [rbx + 0x5eb]
0106d160 8885c7000000 mov byte ptr [rbp + 0xc7], al
0106d166 0fb683ed050000 movzx eax, byte ptr [rbx + 0x5ed]
0106d16d 8885c9000000 mov byte ptr [rbp + 0xc9], al
0106d173 0fb683fb050000 movzx eax, byte ptr [rbx + 0x5fb]
0106d17a 8885cb000000 mov byte ptr [rbp + 0xcb], al
0106d180 8b83ee050000 mov eax, dword ptr [rbx + 0x5ee]
0106d186 8985cc000000 mov dword ptr [rbp + 0xcc], eax
0106d18c 8b83f2050000 mov eax, dword ptr [rbx + 0x5f2]
0106d192 8985d0000000 mov dword ptr [rbp + 0xd0], eax
0106d198 8b83f6050000 mov eax, dword ptr [rbx + 0x5f6]
0106d19e 8985d4000000 mov dword ptr [rbp + 0xd4], eax
0106d1a4 0fb64364 movzx eax, byte ptr [rbx + 0x64]
0106d1a8 8885d8000000 mov byte ptr [rbp + 0xd8], al
0106d1ae 0fb683fa050000 movzx eax, byte ptr [rbx + 0x5fa]
0106d1b5 8885ca000000 mov byte ptr [rbp + 0xca], al
0106d1bb 0fb683fc050000 movzx eax, byte ptr [rbx + 0x5fc]
0106d1c2 8885d9000000 mov byte ptr [rbp + 0xd9], al
0106d1c8 0fb6838c050000 movzx eax, byte ptr [rbx + 0x58c]
0106d1cf 8885da000000 mov byte ptr [rbp + 0xda], al
0106d1d5 8b83fe050000 mov eax, dword ptr [rbx + 0x5fe]
0106d1db 8985dc000000 mov dword ptr [rbp + 0xdc], eax
0106d1e1 0fb68302060000 movzx eax, byte ptr [rbx + 0x602]
0106d1e8 8885db000000 mov byte ptr [rbp + 0xdb], al
0106d1ee 0fb68bea050000 movzx ecx, byte ptr [rbx + 0x5ea]
0106d1f5 e8760ed0ff call 0x140d6e070
0106d1fa 8885c5000000 mov byte ptr [rbp + 0xc5], al
0106d200 4180f801 cmp r8b, 1
0106d204 7206 jb 0x14106d20c
0106d206 4180f803 cmp r8b, 3
0106d20a 7607 jbe 0x14106d213
0106d20c c685c400000002 mov byte ptr [rbp + 0xc4], 2
0106d213 488bbe20010000 mov rdi, qword ptr [rsi + 0x120]
0106d21a 4c89642440 mov qword ptr [rsp + 0x40], r12
0106d21f 807f0500 cmp byte ptr [rdi + 5], 0
0106d223 740b je 0x14106d230
0106d225 488b4f40 mov rcx, qword ptr [rdi + 0x40]
0106d229 48894c2440 mov qword ptr [rsp + 0x40], rcx
0106d22e eb1b jmp 0x14106d24b
0106d230 488d542440 lea rdx, [rsp + 0x40]
0106d235 488b4f08 mov rcx, qword ptr [rdi + 8]
0106d239 e80294b6ff call 0x140bd6640
0106d23e 85c0 test eax, eax
0106d240 0f85a0040000 jne 0x14106d6e6
0106d246 488b4c2440 mov rcx, qword ptr [rsp + 0x40]
0106d24b 488b4720 mov rax, qword ptr [rdi + 0x20]
0106d24f 807f0500 cmp byte ptr [rdi + 5], 0
0106d253 7409 je 0x14106d25e
0106d255 482b4738 sub rax, qword ptr [rdi + 0x38]
0106d259 48ffc8 dec rax
0106d25c eb04 jmp 0x14106d262
0106d25e 482b4730 sub rax, qword ptr [rdi + 0x30]
0106d262 4803c1 add rax, rcx
0106d265 4889442440 mov qword ptr [rsp + 0x40], rax
0106d26a 48c744242018010000 mov qword ptr [rsp + 0x20], 0x118
0106d273 4c8d45e0 lea r8, [rbp - 0x20]
0106d277 488d542420 lea rdx, [rsp + 0x20]
0106d27c 488b8e20010000 mov rcx, qword ptr [rsi + 0x120]
0106d283 e83832b3ff call 0x140ba04c0
0106d288 85c0 test eax, eax
0106d28a 0f8556040000 jne 0x14106d6e6
0106d290 488dbe2801a000 lea rdi, [rsi + 0xa00128]
0106d297 48897c2420 mov qword ptr [rsp + 0x20], rdi
0106d29c 488b4314 mov rax, qword ptr [rbx + 0x14]
0106d2a0 4885c0 test rax, rax
0106d2a3 7406 je 0x14106d2ab
0106d2a5 48833800 cmp qword ptr [rax], 0
0106d2a9 750f jne 0x14106d2ba
0106d2ab 488b4b1c mov rcx, qword ptr [rbx + 0x1c]
0106d2af 4885c9 test rcx, rcx
0106d2b2 744b je 0x14106d2ff
0106d2b4 48833900 cmp qword ptr [rcx], 0
0106d2b8 7445 je 0x14106d2ff
0106d2ba 4889442450 mov qword ptr [rsp + 0x50], rax
0106d2bf 488b4b1c mov rcx, qword ptr [rbx + 0x1c]
0106d2c3 48894c2458 mov qword ptr [rsp + 0x58], rcx
0106d2c8 4885c0 test rax, rax
0106d2cb 7409 je 0x14106d2d6
0106d2cd f0ff4008 lock inc dword ptr [rax + 8]
0106d2d1 488b4c2458 mov rcx, qword ptr [rsp + 0x58]
0106d2d6 4885c9 test rcx, rcx
0106d2d9 7404 je 0x14106d2df
0106d2db f0ff4108 lock inc dword ptr [rcx + 8]
0106d2df 4c8d4c2420 lea r9, [rsp + 0x20]
0106d2e4 41b8f4010000 mov r8d, 0x1f4
0106d2ea 488d542450 lea rdx, [rsp + 0x50]
0106d2ef 488bce mov rcx, rsi
0106d2f2 e8d9dbffff call 0x14106aed0
0106d2f7 ff45e8 inc dword ptr [rbp - 0x18]
0106d2fa 488b7c2420 mov rdi, qword ptr [rsp + 0x20]
0106d2ff 488b4324 mov rax, qword ptr [rbx + 0x24]
0106d303 4885c0 test rax, rax
0106d306 7406 je 0x14106d30e
0106d308 48833800 cmp qword ptr [rax], 0
0106d30c 750f jne 0x14106d31d
0106d30e 488b4b2c mov rcx, qword ptr [rbx + 0x2c]
0106d312 4885c9 test rcx, rcx
0106d315 744b je 0x14106d362
0106d317 48833900 cmp qword ptr [rcx], 0
0106d31b 7445 je 0x14106d362
0106d31d 4889442460 mov qword ptr [rsp + 0x60], rax
0106d322 488b4b2c mov rcx, qword ptr [rbx + 0x2c]
0106d326 48894c2468 mov qword ptr [rsp + 0x68], rcx
0106d32b 4885c0 test rax, rax
0106d32e 7409 je 0x14106d339
0106d330 f0ff4008 lock inc dword ptr [rax + 8]
0106d334 488b4c2468 mov rcx, qword ptr [rsp + 0x68]
0106d339 4885c9 test rcx, rcx
0106d33c 7404 je 0x14106d342
0106d33e f0ff4108 lock inc dword ptr [rcx + 8]
0106d342 4c8d4c2420 lea r9, [rsp + 0x20]
0106d347 41b8f5010000 mov r8d, 0x1f5
0106d34d 488d542460 lea rdx, [rsp + 0x60]
0106d352 488bce mov rcx, rsi
0106d355 e876dbffff call 0x14106aed0
0106d35a ff45e8 inc dword ptr [rbp - 0x18]
0106d35d 488b7c2420 mov rdi, qword ptr [rsp + 0x20]
0106d362 488b867002e001 mov rax, qword ptr [rsi + 0x1e00270]
0106d369 488b8890200000 mov rcx, qword ptr [rax + 0x2090]
0106d370 4885c9 test rcx, rcx
0106d373 0f84ca000000 je 0x14106d443
0106d379 ff15f1bb8700 call qword ptr [rip + 0x87bbf1]
0106d37f 4c8be8 mov r13, rax
0106d382 488b867002e001 mov rax, qword ptr [rsi + 0x1e00270]
0106d389 488b8890200000 mov rcx, qword ptr [rax + 0x2090]
0106d390 4885c9 test rcx, rcx
0106d393 7505 jne 0x14106d39a
0106d395 498bd4 mov rdx, r12
0106d398 eb09 jmp 0x14106d3a3
0106d39a ff15d8bb8700 call qword ptr [rip + 0x87bbd8]
0106d3a0 488bd0 mov rdx, rax
0106d3a3 4c8d6718 lea r12, [rdi + 0x18]
0106d3a7 4885ff test rdi, rdi
0106d3aa 740c je 0x14106d3b8
0106d3ac 0f57c0 xorps xmm0, xmm0
0106d3af 33c0 xor eax, eax
0106d3b1 0f1107 movups xmmword ptr [rdi], xmm0
0106d3b4 48894710 mov qword ptr [rdi + 0x10], rax
0106d3b8 c7076d686f68 mov dword ptr [rdi], 0x686f686d
0106d3be c7470418000000 mov dword ptr [rdi + 4], 0x18
0106d3c5 c7470cf7010000 mov dword ptr [rdi + 0xc], 0x1f7
0106d3cc 418d4518 lea eax, [r13 + 0x18]
0106d3d0 894708 mov dword ptr [rdi + 8], eax
0106d3d3 807e5200 cmp byte ptr [rsi + 0x52], 0
0106d3d7 7547 jne 0x14106d420
0106d3d9 f30f6f0f movdqu xmm1, xmmword ptr [rdi]
0106d3dd 660f6fd9 movdqa xmm3, xmm1
0106d3e1 0f541d9880c000 andps xmm3, xmmword ptr [rip + 0xc08098]
0106d3e8 660f6fc1 movdqa xmm0, xmm1
0106d3ec 660f72f010 pslld xmm0, 0x10
0106d3f1 0f56d8 orps xmm3, xmm0
0106d3f4 660f72f308 pslld xmm3, 8
0106d3f9 660f6fc1 movdqa xmm0, xmm1
0106d3fd 660f72d018 psrld xmm0, 0x18
0106d402 0f56d8 orps xmm3, xmm0
0106d405 660f72d108 psrld xmm1, 8
0106d40a 0f540d6f80c000 andps xmm1, xmmword ptr [rip + 0xc0806f]
0106d411 0f56d9 orps xmm3, xmm1
0106d414 f30f7f1f movdqu xmmword ptr [rdi], xmm3
0106d418 8b4710 mov eax, dword ptr [rdi + 0x10]
0106d41b 0fc8 bswap eax
0106d41d 894710 mov dword ptr [rdi + 0x10], eax
0106d420 418bfd mov edi, r13d
0106d423 4885d2 test rdx, rdx
0106d426 7410 je 0x14106d438
0106d428 4d85e4 test r12, r12
0106d42b 740b je 0x14106d438
0106d42d 448bc7 mov r8d, edi
0106d430 498bcc mov rcx, r12
0106d433 e83da47f00 call 0x141867875
0106d438 4903fc add rdi, r12
0106d43b 48897c2420 mov qword ptr [rsp + 0x20], rdi
0106d440 ff45e8 inc dword ptr [rbp - 0x18]
0106d443 488b4342 mov rax, qword ptr [rbx + 0x42]
0106d447 4885c0 test rax, rax
0106d44a 7406 je 0x14106d452
0106d44c 48833800 cmp qword ptr [rax], 0
0106d450 750f jne 0x14106d461
0106d452 488b4b4a mov rcx, qword ptr [rbx + 0x4a]
0106d456 4885c9 test rcx, rcx
0106d459 744b je 0x14106d4a6
0106d45b 48833900 cmp qword ptr [rcx], 0
0106d45f 7445 je 0x14106d4a6
0106d461 4889442470 mov qword ptr [rsp + 0x70], rax
0106d466 488b4b4a mov rcx, qword ptr [rbx + 0x4a]
0106d46a 48894c2478 mov qword ptr [rsp + 0x78], rcx
0106d46f 4885c0 test rax, rax
0106d472 7409 je 0x14106d47d
0106d474 f0ff4008 lock inc dword ptr [rax + 8]
0106d478 488b4c2478 mov rcx, qword ptr [rsp + 0x78]
0106d47d 4885c9 test rcx, rcx
0106d480 7404 je 0x14106d486
0106d482 f0ff4108 lock inc dword ptr [rcx + 8]
0106d486 4c8d4c2420 lea r9, [rsp + 0x20]
0106d48b 41b800020000 mov r8d, 0x200
0106d491 488d542470 lea rdx, [rsp + 0x70]
0106d496 488bce mov rcx, rsi
0106d499 e832daffff call 0x14106aed0
0106d49e ff45e8 inc dword ptr [rbp - 0x18]
0106d4a1 488b7c2420 mov rdi, qword ptr [rsp + 0x20]
0106d4a6 488b437a mov rax, qword ptr [rbx + 0x7a]
0106d4aa 4885c0 test rax, rax
0106d4ad 7406 je 0x14106d4b5
0106d4af 48833800 cmp qword ptr [rax], 0
0106d4b3 7512 jne 0x14106d4c7
0106d4b5 488b8b82000000 mov rcx, qword ptr [rbx + 0x82]
0106d4bc 4885c9 test rcx, rcx
0106d4bf 744a je 0x14106d50b
0106d4c1 48833900 cmp qword ptr [rcx], 0
0106d4c5 7444 je 0x14106d50b
0106d4c7 48894580 mov qword ptr [rbp - 0x80], rax
0106d4cb 488b8b82000000 mov rcx, qword ptr [rbx + 0x82]
0106d4d2 48894d88 mov qword ptr [rbp - 0x78], rcx
0106d4d6 4885c0 test rax, rax
0106d4d9 7408 je 0x14106d4e3
0106d4db f0ff4008 lock inc dword ptr [rax + 8]
0106d4df 488b4d88 mov rcx, qword ptr [rbp - 0x78]
0106d4e3 4885c9 test rcx, rcx
0106d4e6 7404 je 0x14106d4ec
0106d4e8 f0ff4108 lock inc dword ptr [rcx + 8]
0106d4ec 4c8d4c2420 lea r9, [rsp + 0x20]
0106d4f1 41b8fc010000 mov r8d, 0x1fc
0106d4f7 488d5580 lea rdx, [rbp - 0x80]
0106d4fb 488bce mov rcx, rsi
0106d4fe e8cdd9ffff call 0x14106aed0
0106d503 ff45e8 inc dword ptr [rbp - 0x18]
0106d506 488b7c2420 mov rdi, qword ptr [rsp + 0x20]
0106d50b 488b838a000000 mov rax, qword ptr [rbx + 0x8a]
0106d512 4885c0 test rax, rax
0106d515 7406 je 0x14106d51d
0106d517 48833800 cmp qword ptr [rax], 0
0106d51b 7512 jne 0x14106d52f
0106d51d 488b8b92000000 mov rcx, qword ptr [rbx + 0x92]
0106d524 4885c9 test rcx, rcx
0106d527 744a je 0x14106d573
0106d529 48833900 cmp qword ptr [rcx], 0
0106d52d 7444 je 0x14106d573
0106d52f 48894590 mov qword ptr [rbp - 0x70], rax
0106d533 488b8b92000000 mov rcx, qword ptr [rbx + 0x92]
0106d53a 48894d98 mov qword ptr [rbp - 0x68], rcx
0106d53e 4885c0 test rax, rax
0106d541 7408 je 0x14106d54b
0106d543 f0ff4008 lock inc dword ptr [rax + 8]
0106d547 488b4d98 mov rcx, qword ptr [rbp - 0x68]
0106d54b 4885c9 test rcx, rcx
0106d54e 7404 je 0x14106d554
0106d550 f0ff4108 lock inc dword ptr [rcx + 8]
0106d554 4c8d4c2420 lea r9, [rsp + 0x20]
0106d559 41b8fd010000 mov r8d, 0x1fd
0106d55f 488d5590 lea rdx, [rbp - 0x70]
0106d563 488bce mov rcx, rsi
0106d566 e865d9ffff call 0x14106aed0
0106d56b ff45e8 inc dword ptr [rbp - 0x18]
0106d56e 488b7c2420 mov rdi, qword ptr [rsp + 0x20]
0106d573 488b83c6000000 mov rax, qword ptr [rbx + 0xc6]
0106d57a 4885c0 test rax, rax
0106d57d 7406 je 0x14106d585
0106d57f 48833800 cmp qword ptr [rax], 0
0106d583 7512 jne 0x14106d597
0106d585 488b8bce000000 mov rcx, qword ptr [rbx + 0xce]
0106d58c 4885c9 test rcx, rcx
0106d58f 744a je 0x14106d5db
0106d591 48833900 cmp qword ptr [rcx], 0
0106d595 7444 je 0x14106d5db
0106d597 488945a0 mov qword ptr [rbp - 0x60], rax
0106d59b 488b8bce000000 mov rcx, qword ptr [rbx + 0xce]
0106d5a2 48894da8 mov qword ptr [rbp - 0x58], rcx
0106d5a6 4885c0 test rax, rax
0106d5a9 7408 je 0x14106d5b3
0106d5ab f0ff4008 lock inc dword ptr [rax + 8]
0106d5af 488b4da8 mov rcx, qword ptr [rbp - 0x58]
0106d5b3 4885c9 test rcx, rcx
0106d5b6 7404 je 0x14106d5bc
0106d5b8 f0ff4108 lock inc dword ptr [rcx + 8]
0106d5bc 4c8d4c2420 lea r9, [rsp + 0x20]
0106d5c1 41b8f8010000 mov r8d, 0x1f8
0106d5c7 488d55a0 lea rdx, [rbp - 0x60]
0106d5cb 488bce mov rcx, rsi
0106d5ce e8fdd8ffff call 0x14106aed0
0106d5d3 ff45e8 inc dword ptr [rbp - 0x18]
0106d5d6 488b7c2420 mov rdi, qword ptr [rsp + 0x20]
0106d5db 488b83b6000000 mov rax, qword ptr [rbx + 0xb6]
0106d5e2 4885c0 test rax, rax
0106d5e5 7406 je 0x14106d5ed
0106d5e7 48833800 cmp qword ptr [rax], 0
0106d5eb 7512 jne 0x14106d5ff
0106d5ed 488b8bbe000000 mov rcx, qword ptr [rbx + 0xbe]
0106d5f4 4885c9 test rcx, rcx
0106d5f7 744a je 0x14106d643
0106d5f9 48833900 cmp qword ptr [rcx], 0
0106d5fd 7444 je 0x14106d643
0106d5ff 488945b0 mov qword ptr [rbp - 0x50], rax
0106d603 488b8bbe000000 mov rcx, qword ptr [rbx + 0xbe]
0106d60a 48894db8 mov qword ptr [rbp - 0x48], rcx
0106d60e 4885c0 test rax, rax
0106d611 7408 je 0x14106d61b
0106d613 f0ff4008 lock inc dword ptr [rax + 8]
0106d617 488b4db8 mov rcx, qword ptr [rbp - 0x48]
0106d61b 4885c9 test rcx, rcx
0106d61e 7404 je 0x14106d624
0106d620 f0ff4108 lock inc dword ptr [rcx + 8]
0106d624 4c8d4c2420 lea r9, [rsp + 0x20]
0106d629 41b8f9010000 mov r8d, 0x1f9
0106d62f 488d55b0 lea rdx, [rbp - 0x50]
0106d633 488bce mov rcx, rsi
0106d636 e895d8ffff call 0x14106aed0
0106d63b ff45e8 inc dword ptr [rbp - 0x18]
0106d63e 488b7c2420 mov rdi, qword ptr [rsp + 0x20]
0106d643 488b83a4000000 mov rax, qword ptr [rbx + 0xa4]
0106d64a 4885c0 test rax, rax
0106d64d 7406 je 0x14106d655
0106d64f 48833800 cmp qword ptr [rax], 0
0106d653 7512 jne 0x14106d667
0106d655 488b8bac000000 mov rcx, qword ptr [rbx + 0xac]
0106d65c 4885c9 test rcx, rcx
0106d65f 744e je 0x14106d6af
0106d661 48833900 cmp qword ptr [rcx], 0
0106d665 7448 je 0x14106d6af
0106d667 4889442428 mov qword ptr [rsp + 0x28], rax
0106d66c 488b8bac000000 mov rcx, qword ptr [rbx + 0xac]
0106d673 48894c2430 mov qword ptr [rsp + 0x30], rcx
0106d678 4885c0 test rax, rax
0106d67b 7409 je 0x14106d686
0106d67d f0ff4008 lock inc dword ptr [rax + 8]
0106d681 488b4c2430 mov rcx, qword ptr [rsp + 0x30]
0106d686 4885c9 test rcx, rcx
0106d689 7404 je 0x14106d68f
0106d68b f0ff4108 lock inc dword ptr [rcx + 8]
0106d68f 4c8d4c2420 lea r9, [rsp + 0x20]
0106d694 41b8fa010000 mov r8d, 0x1fa
0106d69a 488d542428 lea rdx, [rsp + 0x28]
0106d69f 488bce mov rcx, rsi
0106d6a2 e829d8ffff call 0x14106aed0
0106d6a7 ff45e8 inc dword ptr [rbp - 0x18]
0106d6aa 488b7c2420 mov rdi, qword ptr [rsp + 0x20]
0106d6af 80bbd600000000 cmp byte ptr [rbx + 0xd6], 0
0106d6b6 0f84f1000000 je 0x14106d7ad
0106d6bc 4c8b0d7db78700 mov r9, qword ptr [rip + 0x87b77d]
0106d6c3 4c8b051eb78700 mov r8, qword ptr [rip + 0x87b71e]
0106d6ca 33d2 xor edx, edx
0106d6cc 488b0dbd890301 mov rcx, qword ptr [rip + 0x10389bd]
0106d6d3 ff15dfbb8700 call qword ptr [rip + 0x87bbdf]
0106d6d9 4c8be0 mov r12, rax
0106d6dc 4885c0 test rax, rax
0106d6df 7566 jne 0x14106d747
0106d6e1 b894ffffff mov eax, 0xffffff94
0106d6e6 8bf8 mov edi, eax
0106d6e8 4d85f6 test r14, r14
0106d6eb 742e je 0x14106d71b
0106d6ed bbffffffff mov ebx, 0xffffffff
0106d6f2 8bc3 mov eax, ebx
0106d6f4 f0410fc14608 lock xadd dword ptr [r14 + 8], eax
0106d6fa 83f801 cmp eax, 1
0106d6fd 751c jne 0x14106d71b
0106d6ff 498b06 mov rax, qword ptr [r14]
0106d702 498bce mov rcx, r14
0106d705 ff10 call qword ptr [rax]
0106d707 f0410fc15e0c lock xadd dword ptr [r14 + 0xc], ebx
0106d70d 83fb01 cmp ebx, 1
0106d710 7509 jne 0x14106d71b
0106d712 498b16 mov rdx, qword ptr [r14]
0106d715 498bce mov rcx, r14
0106d718 ff5208 call qword ptr [rdx + 8]
0106d71b 8bc7 mov eax, edi
0106d71d 488b8d60010000 mov rcx, qword ptr [rbp + 0x160]
0106d724 4833cc xor rcx, rsp
0106d727 e8b4e17200 call 0x14179b8e0
0106d72c 488b9c24c0020000 mov rbx, qword ptr [rsp + 0x2c0]
0106d734 4881c470020000 add rsp, 0x270
0106d73b 415f pop r15
0106d73d 415e pop r14
0106d73f 415d pop r13
0106d741 415c pop r12
0106d743 5f pop rdi
0106d744 5e pop rsi
0106d745 5d pop rbp
0106d746 c3 ret 
0106d747 4c8dabd8000000 lea r13, [rbx + 0xd8]
0106d74e 4d85ed test r13, r13
0106d751 7433 je 0x14106d786
0106d753 488d3d560d0601 lea rdi, [rip + 0x1060d56]
0106d75a 41bf34000000 mov r15d, 0x34
0106d760 4c8b47f8 mov r8, qword ptr [rdi - 8]
0106d764 4d03c5 add r8, r13
0106d767 488b4718 mov rax, qword ptr [rdi + 0x18]
0106d76b 4c8b0f mov r9, qword ptr [rdi]
0106d76e 488b57f0 mov rdx, qword ptr [rdi - 0x10]
0106d772 498bcc mov rcx, r12
0106d775 ffd0 call rax
0106d777 488d7f30 lea rdi, [rdi + 0x30]
0106d77b 4983ef01 sub r15, 1
0106d77f 75df jne 0x14106d760
0106d781 4c8b7c2448 mov r15, qword ptr [rsp + 0x48]
0106d786 4c8d4c2420 lea r9, [rsp + 0x20]
0106d78b 41b8fb010000 mov r8d, 0x1fb
0106d791 498bd4 mov rdx, r12
0106d794 488bce mov rcx, rsi
0106d797 e8a4d9ffff call 0x14106b140
0106d79c 498bcc mov rcx, r12
0106d79f ff157bb68700 call qword ptr [rip + 0x87b67b]
0106d7a5 ff45e8 inc dword ptr [rbp - 0x18]
0106d7a8 488b7c2420 mov rdi, qword ptr [rsp + 0x20]
0106d7ad 488b8b92050000 mov rcx, qword ptr [rbx + 0x592]
0106d7b4 4885c9 test rcx, rcx
0106d7b7 0f84e2000000 je 0x14106d89f
0106d7bd ff15adb78700 call qword ptr [rip + 0x87b7ad]
0106d7c3 4885c0 test rax, rax
0106d7c6 0f84d3000000 je 0x14106d89f
0106d7cc 488b8b92050000 mov rcx, qword ptr [rbx + 0x592]
0106d7d3 4885c9 test rcx, rcx
0106d7d6 740b je 0x14106d7e3
0106d7d8 ff1592b78700 call qword ptr [rip + 0x87b792]
0106d7de 4c8be8 mov r13, rax
0106d7e1 eb03 jmp 0x14106d7e6
0106d7e3 4533ed xor r13d, r13d
0106d7e6 488b8b92050000 mov rcx, qword ptr [rbx + 0x592]
0106d7ed 4885c9 test rcx, rcx
0106d7f0 740b je 0x14106d7fd
0106d7f2 ff1580b78700 call qword ptr [rip + 0x87b780]
0106d7f8 488bd0 mov rdx, rax
0106d7fb eb02 jmp 0x14106d7ff
0106d7fd 33d2 xor edx, edx
0106d7ff 4c8d6718 lea r12, [rdi + 0x18]
0106d803 4885ff test rdi, rdi
0106d806 740c je 0x14106d814
0106d808 0f57c0 xorps xmm0, xmm0
0106d80b 33c0 xor eax, eax
0106d80d 0f1107 movups xmmword ptr [rdi], xmm0
0106d810 48894710 mov qword ptr [rdi + 0x10], rax
0106d814 c7076d686f68 mov dword ptr [rdi], 0x686f686d
0106d81a c7470418000000 mov dword ptr [rdi + 4], 0x18
0106d821 c7470cff010000 mov dword ptr [rdi + 0xc], 0x1ff
0106d828 418d4518 lea eax, [r13 + 0x18]
0106d82c 894708 mov dword ptr [rdi + 8], eax
0106d82f 807e5200 cmp byte ptr [rsi + 0x52], 0
0106d833 7547 jne 0x14106d87c
0106d835 f30f6f0f movdqu xmm1, xmmword ptr [rdi]
0106d839 660f6fd9 movdqa xmm3, xmm1
0106d83d 0f541d3c7cc000 andps xmm3, xmmword ptr [rip + 0xc07c3c]
0106d844 660f6fc1 movdqa xmm0, xmm1
0106d848 660f72f010 pslld xmm0, 0x10
0106d84d 0f56d8 orps xmm3, xmm0
0106d850 660f72f308 pslld xmm3, 8
0106d855 660f6fc1 movdqa xmm0, xmm1
0106d859 660f72d018 psrld xmm0, 0x18
0106d85e 0f56d8 orps xmm3, xmm0
0106d861 660f72d108 psrld xmm1, 8
0106d866 0f540d137cc000 andps xmm1, xmmword ptr [rip + 0xc07c13]
0106d86d 0f56d9 orps xmm3, xmm1
0106d870 f30f7f1f movdqu xmmword ptr [rdi], xmm3
0106d874 8b4710 mov eax, dword ptr [rdi + 0x10]
0106d877 0fc8 bswap eax
0106d879 894710 mov dword ptr [rdi + 0x10], eax
0106d87c 418bfd mov edi, r13d
0106d87f 4885d2 test rdx, rdx
0106d882 7410 je 0x14106d894
0106d884 4d85e4 test r12, r12
0106d887 740b je 0x14106d894
0106d889 448bc7 mov r8d, edi
0106d88c 498bcc mov rcx, r12
0106d88f e8e19f7f00 call 0x141867875
0106d894 4903fc add rdi, r12
0106d897 48897c2420 mov qword ptr [rsp + 0x20], rdi
0106d89c ff45e8 inc dword ptr [rbp - 0x18]
0106d89f 498b07 mov rax, qword ptr [r15]
0106d8a2 33d2 xor edx, edx
0106d8a4 498bcf mov rcx, r15
0106d8a7 ff5020 call qword ptr [rax + 0x20]
0106d8aa 84c0 test al, al
0106d8ac 7427 je 0x14106d8d5
0106d8ae 498b07 mov rax, qword ptr [r15]
0106d8b1 498bcf mov rcx, r15
0106d8b4 ff5028 call qword ptr [rax + 0x28]
0106d8b7 488bd0 mov rdx, rax
0106d8ba 4c8d4c2420 lea r9, [rsp + 0x20]
0106d8bf 41b802020000 mov r8d, 0x202
0106d8c5 488bce mov rcx, rsi
0106d8c8 e873d8ffff call 0x14106b140
0106d8cd ff45e8 inc dword ptr [rbp - 0x18]
0106d8d0 488b7c2420 mov rdi, qword ptr [rsp + 0x20]
0106d8d5 0f57c0 xorps xmm0, xmm0
0106d8d8 0f11442428 movups xmmword ptr [rsp + 0x28], xmm0
0106d8dd 0fb68383050000 movzx eax, byte ptr [rbx + 0x583]
0106d8e4 88442428 mov byte ptr [rsp + 0x28], al
0106d8e8 0fb68384050000 movzx eax, byte ptr [rbx + 0x584]
0106d8ef 88442429 mov byte ptr [rsp + 0x29], al
0106d8f3 0fb68385050000 movzx eax, byte ptr [rbx + 0x585]
0106d8fa 8844242a mov byte ptr [rsp + 0x2a], al
0106d8fe 0fb68386050000 movzx eax, byte ptr [rbx + 0x586]
0106d905 8844242e mov byte ptr [rsp + 0x2e], al
0106d909 0fb68387050000 movzx eax, byte ptr [rbx + 0x587]
0106d910 8844242f mov byte ptr [rsp + 0x2f], al
0106d914 488d4f18 lea rcx, [rdi + 0x18]
0106d918 4885ff test rdi, rdi
0106d91b 7409 je 0x14106d926
0106d91d 33c0 xor eax, eax
0106d91f 0f1107 movups xmmword ptr [rdi], xmm0
0106d922 48894710 mov qword ptr [rdi + 0x10], rax
0106d926 c7076d686f68 mov dword ptr [rdi], 0x686f686d
0106d92c c7470418000000 mov dword ptr [rdi + 4], 0x18
0106d933 c7470c05020000 mov dword ptr [rdi + 0xc], 0x205
0106d93a c7470828000000 mov dword ptr [rdi + 8], 0x28
0106d941 807e5200 cmp byte ptr [rsi + 0x52], 0
0106d945 7547 jne 0x14106d98e
0106d947 f30f6f0f movdqu xmm1, xmmword ptr [rdi]
0106d94b 660f6fd9 movdqa xmm3, xmm1
0106d94f 0f541d2a7bc000 andps xmm3, xmmword ptr [rip + 0xc07b2a]
0106d956 660f6fc1 movdqa xmm0, xmm1
0106d95a 660f72f010 pslld xmm0, 0x10
0106d95f 0f56d8 orps xmm3, xmm0
0106d962 660f72f308 pslld xmm3, 8
0106d967 660f6fc1 movdqa xmm0, xmm1
0106d96b 660f72d018 psrld xmm0, 0x18
0106d970 0f56d8 orps xmm3, xmm0
0106d973 660f72d108 psrld xmm1, 8
0106d978 0f540d017bc000 andps xmm1, xmmword ptr [rip + 0xc07b01]
0106d97f 0f56d9 orps xmm3, xmm1
0106d982 f30f7f1f movdqu xmmword ptr [rdi], xmm3
0106d986 8b4710 mov eax, dword ptr [rdi + 0x10]
0106d989 0fc8 bswap eax
0106d98b 894710 mov dword ptr [rdi + 0x10], eax
0106d98e 4885c9 test rcx, rcx
0106d991 7408 je 0x14106d99b
0106d993 0f10442428 movups xmm0, xmmword ptr [rsp + 0x28]
0106d998 0f1101 movups xmmword ptr [rcx], xmm0
0106d99b ff45e8 inc dword ptr [rbp - 0x18]
0106d99e 2bce sub ecx, esi
0106d9a0 8d81e8fe5fff lea eax, [rcx - 0xa00118]
0106d9a6 4889442448 mov qword ptr [rsp + 0x48], rax
0106d9ab 4c8d862801a000 lea r8, [rsi + 0xa00128]
0106d9b2 488d542448 lea rdx, [rsp + 0x48]
0106d9b7 488b8e20010000 mov rcx, qword ptr [rsi + 0x120]
0106d9be e8fd2ab3ff call 0x140ba04c0
0106d9c3 85c0 test eax, eax
0106d9c5 0f851bfdffff jne 0x14106d6e6
0106d9cb 488d55c0 lea rdx, [rbp - 0x40]
0106d9cf 488b8e20010000 mov rcx, qword ptr [rsi + 0x120]
0106d9d6 e8a525b3ff call 0x140b9ff80
0106d9db 85c0 test eax, eax
0106d9dd 0f8503fdffff jne 0x14106d6e6
0106d9e3 448b45c0 mov r8d, dword ptr [rbp - 0x40]
0106d9e7 4c8b542438 mov r10, qword ptr [rsp + 0x38]
0106d9ec 452bc2 sub r8d, r10d
0106d9ef 44898508010000 mov dword ptr [rbp + 0x108], r8d
0106d9f6 384652 cmp byte ptr [rsi + 0x52], al
0106d9f9 0f859d000000 jne 0x14106da9c
0106d9ff 8b8d00010000 mov ecx, dword ptr [rbp + 0x100]
0106da05 8bd1 mov edx, ecx
0106da07 81e20000ff00 and edx, 0xff0000
0106da0d 8bc1 mov eax, ecx
0106da0f c1e810 shr eax, 0x10
0106da12 0bd0 or edx, eax
0106da14 c1ea08 shr edx, 8
0106da17 8bc1 mov eax, ecx
0106da19 2500ff0000 and eax, 0xff00
0106da1e c1e110 shl ecx, 0x10
0106da21 0bc1 or eax, ecx
0106da23 c1e008 shl eax, 8
0106da26 0bd0 or edx, eax
0106da28 899500010000 mov dword ptr [rbp + 0x100], edx
0106da2e 8b8d04010000 mov ecx, dword ptr [rbp + 0x104]
0106da34 8bd1 mov edx, ecx
0106da36 81e20000ff00 and edx, 0xff0000
0106da3c 8bc1 mov eax, ecx
0106da3e c1e810 shr eax, 0x10
0106da41 0bd0 or edx, eax
0106da43 c1ea08 shr edx, 8
0106da46 8bc1 mov eax, ecx
0106da48 2500ff0000 and eax, 0xff00
0106da4d c1e110 shl ecx, 0x10
0106da50 0bc1 or eax, ecx
0106da52 c1e008 shl eax, 8
0106da55 0bd0 or edx, eax
0106da57 899504010000 mov dword ptr [rbp + 0x104], edx
0106da5d 410fc8 bswap r8d
0106da60 44898508010000 mov dword ptr [rbp + 0x108], r8d
0106da67 8b8d0c010000 mov ecx, dword ptr [rbp + 0x10c]
0106da6d 448bc1 mov r8d, ecx
0106da70 4181e00000ff00 and r8d, 0xff0000
0106da77 8bc1 mov eax, ecx
0106da79 c1e810 shr eax, 0x10
0106da7c 440bc0 or r8d, eax
0106da7f 41c1e808 shr r8d, 8
0106da83 8bc1 mov eax, ecx
0106da85 2500ff0000 and eax, 0xff00
0106da8a c1e110 shl ecx, 0x10
0106da8d 0bc1 or eax, ecx
0106da8f c1e008 shl eax, 8
0106da92 440bc0 or r8d, eax
0106da95 4489850c010000 mov dword ptr [rbp + 0x10c], r8d
0106da9c 41b960000000 mov r9d, 0x60
0106daa2 4c8d8500010000 lea r8, [rbp + 0x100]
0106daa9 498bd2 mov rdx, r10
0106daac 488bce mov rcx, rsi
0106daaf e8ecd0ffff call 0x14106aba0
0106dab4 85c0 test eax, eax
0106dab6 0f852afcffff jne 0x14106d6e6
0106dabc 488d55e0 lea rdx, [rbp - 0x20]
0106dac0 488bce mov rcx, rsi
0106dac3 e828c6ffff call 0x14106a0f0
0106dac8 41b918010000 mov r9d, 0x118
0106dace 4c8d45e0 lea r8, [rbp - 0x20]
0106dad2 488b542440 mov rdx, qword ptr [rsp + 0x40]
0106dad7 488bce mov rcx, rsi
0106dada e8c1d0ffff call 0x14106aba0
0106dadf 85c0 test eax, eax
0106dae1 0f85fffbffff jne 0x14106d6e6
0106dae7 33ff xor edi, edi
0106dae9 e9fafbffff jmp 0x14106d6e8
0106daee cc int3 