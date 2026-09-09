0107ee90 48895c2410 mov qword ptr [rsp + 0x10], rbx
0107ee95 4889742418 mov qword ptr [rsp + 0x18], rsi
0107ee9a 48897c2420 mov qword ptr [rsp + 0x20], rdi
0107ee9f 55 push rbp
0107eea0 4154 push r12
0107eea2 4155 push r13
0107eea4 4156 push r14
0107eea6 4157 push r15
0107eea8 488dac2490e9ffff lea rbp, [rsp - 0x1670]
0107eeb0 b870170000 mov eax, 0x1770
0107eeb5 e8e6887e00 call 0x1418677a0
0107eeba 482be0 sub rsp, rax
0107eebd 0f29b42460170000 movaps xmmword ptr [rsp + 0x1760], xmm6
0107eec5 0f29bc2450170000 movaps xmmword ptr [rsp + 0x1750], xmm7
0107eecd 488b056c61f500 mov rax, qword ptr [rip + 0xf5616c]
0107eed4 4833c4 xor rax, rsp
0107eed7 48898540160000 mov qword ptr [rbp + 0x1640], rax
0107eede 89542440 mov dword ptr [rsp + 0x40], edx
0107eee2 488bf9 mov rdi, rcx
0107eee5 488b817002e001 mov rax, qword ptr [rcx + 0x1e00270]
0107eeec 4889442460 mov qword ptr [rsp + 0x60], rax
0107eef1 41b808000000 mov r8d, 8
0107eef7 488d95100f0000 lea rdx, [rbp + 0xf10]
0107eefe e89d81ffff call 0x1410770a0
0107ef03 8bd8 mov ebx, eax
0107ef05 85c0 test eax, eax
0107ef07 0f85da270000 jne 0x1410816e7
0107ef0d 448b95140f0000 mov r10d, dword ptr [rbp + 0xf14]
0107ef14 418bf2 mov esi, r10d
0107ef17 4c8d6f52 lea r13, [rdi + 0x52]
0107ef1b 41384500 cmp byte ptr [r13], al
0107ef1f 7502 jne 0x14107ef23
0107ef21 0fce bswap esi
0107ef23 488d8d180f0000 lea rcx, [rbp + 0xf18]
0107ef2a 41bf5c000000 mov r15d, 0x5c
0107ef30 458bf7 mov r14d, r15d
0107ef33 413bf7 cmp esi, r15d
0107ef36 440f42f6 cmovb r14d, esi
0107ef3a 4183fe08 cmp r14d, 8
0107ef3e 763e jbe 0x14107ef7e
0107ef40 458d66f8 lea r12d, [r14 - 8]
0107ef44 4981fc0000a000 cmp r12, 0xa00000
0107ef4b 0f8791270000 ja 0x1410816e2
0107ef51 458bc4 mov r8d, r12d
0107ef54 488d95180f0000 lea rdx, [rbp + 0xf18]
0107ef5b 488bcf mov rcx, rdi
0107ef5e e83d81ffff call 0x1410770a0
0107ef63 8bd8 mov ebx, eax
0107ef65 85c0 test eax, eax
0107ef67 0f857a270000 jne 0x1410816e7
0107ef6d 488d8d180f0000 lea rcx, [rbp + 0xf18]
0107ef74 4903cc add rcx, r12
0107ef77 448b95140f0000 mov r10d, dword ptr [rbp + 0xf14]
0107ef7e 453bf7 cmp r14d, r15d
0107ef81 7319 jae 0x14107ef9c
0107ef83 4885c9 test rcx, rcx
0107ef86 7414 je 0x14107ef9c
0107ef88 452bfe sub r15d, r14d
0107ef8b 458bc7 mov r8d, r15d
0107ef8e 33d2 xor edx, edx
0107ef90 e80bdd7100 call 0x14179cca0
0107ef95 448b95140f0000 mov r10d, dword ptr [rbp + 0xf14]
0107ef9c 413bf6 cmp esi, r14d
0107ef9f 7617 jbe 0x14107efb8
0107efa1 412bf6 sub esi, r14d
0107efa4 8bd6 mov edx, esi
0107efa6 488bcf mov rcx, rdi
0107efa9 e872b5feff call 0x14106a520
0107efae 8bd8 mov ebx, eax
0107efb0 85c0 test eax, eax
0107efb2 0f852f270000 jne 0x1410816e7
0107efb8 4533ff xor r15d, r15d
0107efbb 418bdf mov ebx, r15d
0107efbe 45387d00 cmp byte ptr [r13], r15b
0107efc2 0f8595000000 jne 0x14107f05d
0107efc8 8b8d100f0000 mov ecx, dword ptr [rbp + 0xf10]
0107efce 8bd1 mov edx, ecx
0107efd0 81e20000ff00 and edx, 0xff0000
0107efd6 8bc1 mov eax, ecx
0107efd8 c1e810 shr eax, 0x10
0107efdb 0bd0 or edx, eax
0107efdd c1ea08 shr edx, 8
0107efe0 8bc1 mov eax, ecx
0107efe2 2500ff0000 and eax, 0xff00
0107efe7 c1e110 shl ecx, 0x10
0107efea 0bc1 or eax, ecx
0107efec c1e008 shl eax, 8
0107efef 0bd0 or edx, eax
0107eff1 8995100f0000 mov dword ptr [rbp + 0xf10], edx
0107eff7 418bca mov ecx, r10d
0107effa 81e10000ff00 and ecx, 0xff0000
0107f000 418bc2 mov eax, r10d
0107f003 c1e810 shr eax, 0x10
0107f006 0bc8 or ecx, eax
0107f008 c1e908 shr ecx, 8
0107f00b 418bc2 mov eax, r10d
0107f00e c1e010 shl eax, 0x10
0107f011 4181e200ff0000 and r10d, 0xff00
0107f018 410bc2 or eax, r10d
0107f01b c1e008 shl eax, 8
0107f01e 0bc8 or ecx, eax
0107f020 898d140f0000 mov dword ptr [rbp + 0xf14], ecx
0107f026 8b8d180f0000 mov ecx, dword ptr [rbp + 0xf18]
0107f02c 448bc1 mov r8d, ecx
0107f02f 4181e00000ff00 and r8d, 0xff0000
0107f036 8bc1 mov eax, ecx
0107f038 c1e810 shr eax, 0x10
0107f03b 440bc0 or r8d, eax
0107f03e 41c1e808 shr r8d, 8
0107f042 8bc1 mov eax, ecx
0107f044 2500ff0000 and eax, 0xff00
0107f049 c1e110 shl ecx, 0x10
0107f04c 0bc1 or eax, ecx
0107f04e c1e008 shl eax, 8
0107f051 440bc0 or r8d, eax
0107f054 448985180f0000 mov dword ptr [rbp + 0xf18], r8d
0107f05b eb0d jmp 0x14107f06a
0107f05d 448b85180f0000 mov r8d, dword ptr [rbp + 0xf18]
0107f064 8b95100f0000 mov edx, dword ptr [rbp + 0xf10]
0107f06a 81fa6d6c7068 cmp edx, 0x68706c6d
0107f070 0f856c260000 jne 0x1410816e2
0107f076 44897c2470 mov dword ptr [rsp + 0x70], r15d
0107f07b 4585c0 test r8d, r8d
0107f07e 0f8463260000 je 0x1410816e7
0107f084 f20f1035bc41bf00 movsd xmm6, qword ptr [rip + 0xbf41bc]
0107f08c f30f103d0854bf00 movss xmm7, dword ptr [rip + 0xbf5408]
0107f094 0f1f4000 nop dword ptr [rax]
0107f098 0f1f840000000000 nop dword ptr [rax + rax]
0107f0a0 4c897de8 mov qword ptr [rbp - 0x18], r15
0107f0a4 4c897c2478 mov qword ptr [rsp + 0x78], r15
0107f0a9 c644243400 mov byte ptr [rsp + 0x34], 0
0107f0ae c644243500 mov byte ptr [rsp + 0x35], 0
0107f0b3 4c897c2448 mov qword ptr [rsp + 0x48], r15
0107f0b8 41b808000000 mov r8d, 8
0107f0be 488d9520010000 lea rdx, [rbp + 0x120]
0107f0c5 488bcf mov rcx, rdi
0107f0c8 e8d37fffff call 0x1410770a0
0107f0cd 8bd8 mov ebx, eax
0107f0cf 85c0 test eax, eax
0107f0d1 0f8510260000 jne 0x1410816e7
0107f0d7 8bb524010000 mov esi, dword ptr [rbp + 0x124]
0107f0dd 8bce mov ecx, esi
0107f0df 41384500 cmp byte ptr [r13], al
0107f0e3 7522 jne 0x14107f107
0107f0e5 81e60000ff00 and esi, 0xff0000
0107f0eb 8bc1 mov eax, ecx
0107f0ed c1e810 shr eax, 0x10
0107f0f0 0bf0 or esi, eax
0107f0f2 c1ee08 shr esi, 8
0107f0f5 8bc1 mov eax, ecx
0107f0f7 c1e010 shl eax, 0x10
0107f0fa 81e100ff0000 and ecx, 0xff00
0107f100 0bc1 or eax, ecx
0107f102 c1e008 shl eax, 8
0107f105 0bf0 or esi, eax
0107f107 488d8d28010000 lea rcx, [rbp + 0x128]
0107f10e 41bfac0d0000 mov r15d, 0xdac
0107f114 413bf7 cmp esi, r15d
0107f117 440f42fe cmovb r15d, esi
0107f11b 4183ff08 cmp r15d, 8
0107f11f 7637 jbe 0x14107f158
0107f121 458d67f8 lea r12d, [r15 - 8]
0107f125 4981fc0000a000 cmp r12, 0xa00000
0107f12c 0f87b0250000 ja 0x1410816e2
0107f132 458bc4 mov r8d, r12d
0107f135 488d9528010000 lea rdx, [rbp + 0x128]
0107f13c 488bcf mov rcx, rdi
0107f13f e85c7fffff call 0x1410770a0
0107f144 8bd8 mov ebx, eax
0107f146 85c0 test eax, eax
0107f148 0f8599250000 jne 0x1410816e7
0107f14e 488d8d28010000 lea rcx, [rbp + 0x128]
0107f155 4903cc add rcx, r12
0107f158 4181ffac0d0000 cmp r15d, 0xdac
0107f15f 7315 jae 0x14107f176
0107f161 4885c9 test rcx, rcx
0107f164 7410 je 0x14107f176
0107f166 41b8ac0d0000 mov r8d, 0xdac
0107f16c 452bc7 sub r8d, r15d
0107f16f 33d2 xor edx, edx
0107f171 e82adb7100 call 0x14179cca0
0107f176 413bf7 cmp esi, r15d
0107f179 7617 jbe 0x14107f192
0107f17b 412bf7 sub esi, r15d
0107f17e 8bd6 mov edx, esi
0107f180 488bcf mov rcx, rdi
0107f183 e898b3feff call 0x14106a520
0107f188 8bd8 mov ebx, eax
0107f18a 85c0 test eax, eax
0107f18c 0f8555250000 jne 0x1410816e7
0107f192 4533ff xor r15d, r15d
0107f195 418bdf mov ebx, r15d
0107f198 488d9520010000 lea rdx, [rbp + 0x120]
0107f19f 488bcf mov rcx, rdi
0107f1a2 e8b9a6feff call 0x141069860
0107f1a7 81bd200100006d697068 cmp dword ptr [rbp + 0x120], 0x6870696d
0107f1b1 0f852b250000 jne 0x1410816e2
0107f1b7 0fb6855a030000 movzx eax, byte ptr [rbp + 0x35a]
0107f1be 84c0 test al, al
0107f1c0 7548 jne 0x14107f20a
0107f1c2 0fb6b559030000 movzx esi, byte ptr [rbp + 0x359]
0107f1c9 6685f6 test si, si
0107f1cc 753f jne 0x14107f20d
0107f1ce 0fb68538030000 movzx eax, byte ptr [rbp + 0x338]
0107f1d5 84c0 test al, al
0107f1d7 7531 jne 0x14107f20a
0107f1d9 389dec020000 cmp byte ptr [rbp + 0x2ec], bl
0107f1df 7407 je 0x14107f1e8
0107f1e1 be11000000 mov esi, 0x11
0107f1e6 eb47 jmp 0x14107f22f
0107f1e8 389de1020000 cmp byte ptr [rbp + 0x2e1], bl
0107f1ee 7407 je 0x14107f1f7
0107f1f0 be13000000 mov esi, 0x13
0107f1f5 eb38 jmp 0x14107f22f
0107f1f7 389d29030000 cmp byte ptr [rbp + 0x329], bl
0107f1fd 0f84aa000000 je 0x14107f2ad
0107f203 be0a000000 mov esi, 0xa
0107f208 eb25 jmp 0x14107f22f
0107f20a 0fb7f0 movzx esi, ax
0107f20d 6683fe16 cmp si, 0x16
0107f211 7437 je 0x14107f24a
0107f213 0fb7c6 movzx eax, si
0107f216 6683fe34 cmp si, 0x34
0107f21a 742e je 0x14107f24a
0107f21c 6685c0 test ax, ax
0107f21f 741a je 0x14107f23b
0107f221 b9c8000000 mov ecx, 0xc8
0107f226 662bc1 sub ax, cx
0107f229 6683f806 cmp ax, 6
0107f22d 760c jbe 0x14107f23b
0107f22f 8b4c2440 mov ecx, dword ptr [rsp + 0x40]
0107f233 0fbae10b bt ecx, 0xb
0107f237 7211 jb 0x14107f24a
0107f239 eb04 jmp 0x14107f23f
0107f23b 8b4c2440 mov ecx, dword ptr [rsp + 0x40]
0107f23f 6683fe0a cmp si, 0xa
0107f243 7536 jne 0x14107f27b
0107f245 f6c102 test cl, 2
0107f248 7467 je 0x14107f2b1
0107f24a 488d9520010000 lea rdx, [rbp + 0x120]
0107f251 488bcf mov rcx, rdi
0107f254 e807f8ffff call 0x14107ea60
0107f259 48ff879001e001 inc qword ptr [rdi + 0x1e00190]
0107f260 8b742470 mov esi, dword ptr [rsp + 0x70]
0107f264 ffc6 inc esi
0107f266 89742470 mov dword ptr [rsp + 0x70], esi
0107f26a 3bb5180f0000 cmp esi, dword ptr [rbp + 0xf18]
0107f270 0f8371240000 jae 0x1410816e7
0107f276 e925feffff jmp 0x14107f0a0
0107f27b 6683fe1f cmp si, 0x1f
0107f27f 7505 jne 0x14107f286
0107f281 f6c101 test cl, 1
0107f284 ebc2 jmp 0x14107f248
0107f286 6683fe13 cmp si, 0x13
0107f28a 7505 jne 0x14107f291
0107f28c f6c104 test cl, 4
0107f28f ebb7 jmp 0x14107f248
0107f291 6683fe06 cmp si, 6
0107f295 74b3 je 0x14107f24a
0107f297 6683fe07 cmp si, 7
0107f29b 750a jne 0x14107f2a7
0107f29d 8b4c2440 mov ecx, dword ptr [rsp + 0x40]
0107f2a1 84c9 test cl, cl
0107f2a3 790c jns 0x14107f2b1
0107f2a5 eba3 jmp 0x14107f24a
0107f2a7 6683fe12 cmp si, 0x12
0107f2ab 749d je 0x14107f24a
0107f2ad 8b4c2440 mov ecx, dword ptr [rsp + 0x40]
0107f2b1 48399dfc020000 cmp qword ptr [rbp + 0x2fc], rbx
0107f2b8 7405 je 0x14107f2bf
0107f2ba f6c108 test cl, 8
0107f2bd 758b jne 0x14107f24a
0107f2bf 0fb7ce movzx ecx, si
0107f2c2 e8c98fe6ff call 0x140ee8290
0107f2c7 448b742440 mov r14d, dword ptr [rsp + 0x40]
0107f2cc 84c0 test al, al
0107f2ce 740a je 0x14107f2da
0107f2d0 41f6c610 test r14b, 0x10
0107f2d4 0f8570ffffff jne 0x14107f24a
0107f2da 389d36010000 cmp byte ptr [rbp + 0x136], bl
0107f2e0 740a je 0x14107f2ec
0107f2e2 41f6c620 test r14b, 0x20
0107f2e6 0f855effffff jne 0x14107f24a
0107f2ec c7854014000001002000 mov dword ptr [rbp + 0x1440], 0x200001
0107f2f6 488b9530030000 mov rdx, qword ptr [rbp + 0x330]
0107f2fd 4c8b642460 mov r12, qword ptr [rsp + 0x60]
0107f302 4885d2 test rdx, rdx
0107f305 7420 je 0x14107f327
0107f307 498bcc mov rcx, r12
0107f30a e8c175e7ff call 0x140ef68d0
0107f30f 48894510 mov qword ptr [rbp + 0x10], rax
0107f313 4885c0 test rax, rax
0107f316 740f je 0x14107f327
0107f318 48c7c0ffffffff mov rax, 0xffffffffffffffff
0107f31f 48894518 mov qword ptr [rbp + 0x18], rax
0107f323 488d5d10 lea rbx, [rbp + 0x10]
0107f327 4c897d98 mov qword ptr [rbp - 0x68], r15
0107f32b 4c897dbd mov qword ptr [rbp - 0x43], r15
0107f32f 6644897dc5 mov word ptr [rbp - 0x3b], r15w
0107f334 44887dc7 mov byte ptr [rbp - 0x39], r15b
0107f338 4c896590 mov qword ptr [rbp - 0x70], r12
0107f33c 488d8540140000 lea rax, [rbp + 0x1440]
0107f343 488945a0 mov qword ptr [rbp - 0x60], rax
0107f347 48895da8 mov qword ptr [rbp - 0x58], rbx
0107f34b 0fb68536010000 movzx eax, byte ptr [rbp + 0x136]
0107f352 8845bc mov byte ptr [rbp - 0x44], al
0107f355 488b85d8020000 mov rax, qword ptr [rbp + 0x2d8]
0107f35c 488945b0 mov qword ptr [rbp - 0x50], rax
0107f360 418bc7 mov eax, r15d
0107f363 4585f6 test r14d, r14d
0107f366 0f4885600e0000 cmovs eax, dword ptr [rbp + 0xe60]
0107f36d 8945b8 mov dword ptr [rbp - 0x48], eax
0107f370 488d542448 lea rdx, [rsp + 0x48]
0107f375 488d4d90 lea rcx, [rbp - 0x70]
0107f379 e83212fcff call 0x1410405b0
0107f37e 8bd8 mov ebx, eax
0107f380 85c0 test eax, eax
0107f382 0f855f230000 jne 0x1410816e7
0107f388 4c8b7c2448 mov r15, qword ptr [rsp + 0x48]
0107f38d 8b8d3c010000 mov ecx, dword ptr [rbp + 0x13c]
0107f393 41898ff4010000 mov dword ptr [r15 + 0x1f4], ecx
0107f39a 8b8d94030000 mov ecx, dword ptr [rbp + 0x394]
0107f3a0 41898ff8010000 mov dword ptr [r15 + 0x1f8], ecx
0107f3a7 0fb695ed020000 movzx edx, byte ptr [rbp + 0x2ed]
0107f3ae 80e201 and dl, 1
0107f3b1 c0e204 shl dl, 4
0107f3b4 410fb68fca020000 movzx ecx, byte ptr [r15 + 0x2ca]
0107f3bc 80e1ef and cl, 0xef
0107f3bf 0ad1 or dl, cl
0107f3c1 418897ca020000 mov byte ptr [r15 + 0x2ca], dl
0107f3c8 0fb685ee020000 movzx eax, byte ptr [rbp + 0x2ee]
0107f3cf 2401 and al, 1
0107f3d1 c0e005 shl al, 5
0107f3d4 80e2df and dl, 0xdf
0107f3d7 0ac2 or al, dl
0107f3d9 418887ca020000 mov byte ptr [r15 + 0x2ca], al
0107f3e0 0fb68550080000 movzx eax, byte ptr [rbp + 0x850]
0107f3e7 418887cd020000 mov byte ptr [r15 + 0x2cd], al
0107f3ee 0fb6853a030000 movzx eax, byte ptr [rbp + 0x33a]
0107f3f5 418887cc020000 mov byte ptr [r15 + 0x2cc], al
0107f3fc 410fb68fca020000 movzx ecx, byte ptr [r15 + 0x2ca]
0107f404 80e17f and cl, 0x7f
0107f407 0fb685e0020000 movzx eax, byte ptr [rbp + 0x2e0]
0107f40e c0e007 shl al, 7
0107f411 0ac8 or cl, al
0107f413 41888fca020000 mov byte ptr [r15 + 0x2ca], cl
0107f41a 410fb68fcb020000 movzx ecx, byte ptr [r15 + 0x2cb]
0107f422 80e1fe and cl, 0xfe
0107f425 0fb68555080000 movzx eax, byte ptr [rbp + 0x855]
0107f42c 2401 and al, 1
0107f42e 0ac8 or cl, al
0107f430 41888fcb020000 mov byte ptr [r15 + 0x2cb], cl
0107f437 0fb68557080000 movzx eax, byte ptr [rbp + 0x857]
0107f43e 2401 and al, 1
0107f440 02c0 add al, al
0107f442 80e1fd and cl, 0xfd
0107f445 0ac1 or al, cl
0107f447 418887cb020000 mov byte ptr [r15 + 0x2cb], al
0107f44e 0fb78540010000 movzx eax, word ptr [rbp + 0x140]
0107f455 66418987dc020000 mov word ptr [r15 + 0x2dc], ax
0107f45d 0fb78542010000 movzx eax, word ptr [rbp + 0x142]
0107f464 66418987de020000 mov word ptr [r15 + 0x2de], ax
0107f46c 0fb78544010000 movzx eax, word ptr [rbp + 0x144]
0107f473 66418987e0020000 mov word ptr [r15 + 0x2e0], ax
0107f47b 0fb78546010000 movzx eax, word ptr [rbp + 0x146]
0107f482 66418987e2020000 mov word ptr [r15 + 0x2e2], ax
0107f48a 0fb785d6020000 movzx eax, word ptr [rbp + 0x2d6]
0107f491 66418987e4020000 mov word ptr [r15 + 0x2e4], ax
0107f499 0fb785b80d0000 movzx eax, word ptr [rbp + 0xdb8]
0107f4a0 66418987e6020000 mov word ptr [r15 + 0x2e6], ax
0107f4a8 0fb785ba0d0000 movzx eax, word ptr [rbp + 0xdba]
0107f4af 66418987e8020000 mov word ptr [r15 + 0x2e8], ax
0107f4b7 0fb785bc0d0000 movzx eax, word ptr [rbp + 0xdbc]
0107f4be 66418987ea020000 mov word ptr [r15 + 0x2ea], ax
0107f4c6 0fb785be0d0000 movzx eax, word ptr [rbp + 0xdbe]
0107f4cd 66418987ec020000 mov word ptr [r15 + 0x2ec], ax
0107f4d5 8b8544030000 mov eax, dword ptr [rbp + 0x344]
0107f4db 83e82d sub eax, 0x2d
0107f4de 741a je 0x14107f4fa
0107f4e0 83e801 sub eax, 1
0107f4e3 740e je 0x14107f4f3
0107f4e5 83e805 sub eax, 5
0107f4e8 7410 je 0x14107f4fa
0107f4ea 83f801 cmp eax, 1
0107f4ed 7404 je 0x14107f4f3
0107f4ef 33c0 xor eax, eax
0107f4f1 eb0c jmp 0x14107f4ff
0107f4f3 b835000000 mov eax, 0x35
0107f4f8 eb05 jmp 0x14107f4ff
0107f4fa b834000000 mov eax, 0x34
0107f4ff 41898770040000 mov dword ptr [r15 + 0x470], eax
0107f506 8b8d980d0000 mov ecx, dword ptr [rbp + 0xd98]
0107f50c 85c9 test ecx, ecx
0107f50e 740c je 0x14107f51c
0107f510 e8eb740400 call 0x1410c6a00
0107f515 41898774040000 mov dword ptr [r15 + 0x474], eax
0107f51c 0fb685960d0000 movzx eax, byte ptr [rbp + 0xd96]
0107f523 4188877a040000 mov byte ptr [r15 + 0x47a], al
0107f52a 488b859c0d0000 mov rax, qword ptr [rbp + 0xd9c]
0107f531 49898788010000 mov qword ptr [r15 + 0x188], rax
0107f538 488b85a40d0000 mov rax, qword ptr [rbp + 0xda4]
0107f53f 49898790010000 mov qword ptr [r15 + 0x190], rax
0107f546 0fb685ad0d0000 movzx eax, byte ptr [rbp + 0xdad]
0107f54d 41888783010000 mov byte ptr [r15 + 0x183], al
0107f554 0fb68dac0d0000 movzx ecx, byte ptr [rbp + 0xdac]
0107f55b 80e101 and cl, 1
0107f55e c0e102 shl cl, 2
0107f561 410fb68780010000 movzx eax, byte ptr [r15 + 0x180]
0107f569 24fb and al, 0xfb
0107f56b 0ac8 or cl, al
0107f56d 41888f80010000 mov byte ptr [r15 + 0x180], cl
0107f574 0fb685b30d0000 movzx eax, byte ptr [rbp + 0xdb3]
0107f57b 2401 and al, 1
0107f57d c0e006 shl al, 6
0107f580 80e1bf and cl, 0xbf
0107f583 0ac1 or al, cl
0107f585 41888780010000 mov byte ptr [r15 + 0x180], al
0107f58c 0fb68d970d0000 movzx ecx, byte ptr [rbp + 0xd97]
0107f593 80e101 and cl, 1
0107f596 02c9 add cl, cl
0107f598 24fd and al, 0xfd
0107f59a 0ac8 or cl, al
0107f59c 41888f80010000 mov byte ptr [r15 + 0x180], cl
0107f5a3 0fb685b00d0000 movzx eax, byte ptr [rbp + 0xdb0]
0107f5aa 2401 and al, 1
0107f5ac 80e1fe and cl, 0xfe
0107f5af 0ac1 or al, cl
0107f5b1 41888780010000 mov byte ptr [r15 + 0x180], al
0107f5b8 0fb68d740e0000 movzx ecx, byte ptr [rbp + 0xe74]
0107f5bf 80e101 and cl, 1
0107f5c2 02c9 add cl, cl
0107f5c4 410fb68781010000 movzx eax, byte ptr [r15 + 0x181]
0107f5cc 24fd and al, 0xfd
0107f5ce 0ac8 or cl, al
0107f5d0 41888f81010000 mov byte ptr [r15 + 0x181], cl
0107f5d7 0fb695750e0000 movzx edx, byte ptr [rbp + 0xe75]
0107f5de 80e201 and dl, 1
0107f5e1 c0e202 shl dl, 2
0107f5e4 80e1fb and cl, 0xfb
0107f5e7 0ad1 or dl, cl
0107f5e9 41889781010000 mov byte ptr [r15 + 0x181], dl
0107f5f0 0fb685760e0000 movzx eax, byte ptr [rbp + 0xe76]
0107f5f7 2401 and al, 1
0107f5f9 c0e003 shl al, 3
0107f5fc 80e2f7 and dl, 0xf7
0107f5ff 0ac2 or al, dl
0107f601 41888781010000 mov byte ptr [r15 + 0x181], al
0107f608 0fb685770e0000 movzx eax, byte ptr [rbp + 0xe77]
0107f60f 41888778040000 mov byte ptr [r15 + 0x478], al
0107f616 488b85780e0000 mov rax, qword ptr [rbp + 0xe78]
0107f61d 498987c8010000 mov qword ptr [r15 + 0x1c8], rax
0107f624 488b85800e0000 mov rax, qword ptr [rbp + 0xe80]
0107f62b 498987b0010000 mov qword ptr [r15 + 0x1b0], rax
0107f632 488b85880e0000 mov rax, qword ptr [rbp + 0xe88]
0107f639 498987b8010000 mov qword ptr [r15 + 0x1b8], rax
0107f640 488b85900e0000 mov rax, qword ptr [rbp + 0xe90]
0107f647 498987c0010000 mov qword ptr [r15 + 0x1c0], rax
0107f64e 8b85980e0000 mov eax, dword ptr [rbp + 0xe98]
0107f654 418987a0010000 mov dword ptr [r15 + 0x1a0], eax
0107f65b 0fb68da80e0000 movzx ecx, byte ptr [rbp + 0xea8]
0107f662 80e101 and cl, 1
0107f665 c0e104 shl cl, 4
0107f668 410fb687da010000 movzx eax, byte ptr [r15 + 0x1da]
0107f670 24ef and al, 0xef
0107f672 0ac8 or cl, al
0107f674 41888fda010000 mov byte ptr [r15 + 0x1da], cl
0107f67b 80e17f and cl, 0x7f
0107f67e 0fb685a90e0000 movzx eax, byte ptr [rbp + 0xea9]
0107f685 c0e007 shl al, 7
0107f688 0ac8 or cl, al
0107f68a 41888fda010000 mov byte ptr [r15 + 0x1da], cl
0107f691 0fb68daa0e0000 movzx ecx, byte ptr [rbp + 0xeaa]
0107f698 80e101 and cl, 1
0107f69b 410fb687db010000 movzx eax, byte ptr [r15 + 0x1db]
0107f6a3 24fe and al, 0xfe
0107f6a5 0ac8 or cl, al
0107f6a7 41888fdb010000 mov byte ptr [r15 + 0x1db], cl
0107f6ae 80bdb20d000000 cmp byte ptr [rbp + 0xdb2], 0
0107f6b5 746c je 0x14107f723
0107f6b7 41b001 mov r8b, 1
0107f6ba 498bd7 mov rdx, r15
0107f6bd 488d8db0000000 lea rcx, [rbp + 0xb0]
0107f6c4 e8870ae8ff call 0x140f00150
0107f6c9 4c8b30 mov r14, qword ptr [rax]
0107f6cc 4c89b5a0000000 mov qword ptr [rbp + 0xa0], r14
0107f6d3 4c8b6008 mov r12, qword ptr [rax + 8]
0107f6d7 4c89a5a8000000 mov qword ptr [rbp + 0xa8], r12
0107f6de 33c9 xor ecx, ecx
0107f6e0 488908 mov qword ptr [rax], rcx
0107f6e3 48894808 mov qword ptr [rax + 8], rcx
0107f6e7 488b8db8000000 mov rcx, qword ptr [rbp + 0xb8]
0107f6ee 4885c9 test rcx, rcx
0107f6f1 7405 je 0x14107f6f8
0107f6f3 e8f8281dff call 0x140251ff0
0107f6f8 4d85f6 test r14, r14
0107f6fb 7414 je 0x14107f711
0107f6fd 498b06 mov rax, qword ptr [r14]
0107f700 0fb695b20d0000 movzx edx, byte ptr [rbp + 0xdb2]
0107f707 498bce mov rcx, r14
0107f70a ff9098000000 call qword ptr [rax + 0x98]
0107f710 90 nop 
0107f711 4d85e4 test r12, r12
0107f714 7408 je 0x14107f71e
0107f716 498bcc mov rcx, r12
0107f719 e8d2281dff call 0x140251ff0
0107f71e 4c8b642460 mov r12, qword ptr [rsp + 0x60]
0107f723 0fb685ae0d0000 movzx eax, byte ptr [rbp + 0xdae]
0107f72a 4188877b040000 mov byte ptr [r15 + 0x47b], al
0107f731 0fb685b10d0000 movzx eax, byte ptr [rbp + 0xdb1]
0107f738 4188877c040000 mov byte ptr [r15 + 0x47c], al
0107f73f 0fb68df1020000 movzx ecx, byte ptr [rbp + 0x2f1]
0107f746 80e101 and cl, 1
0107f749 410fb687c8020000 movzx eax, byte ptr [r15 + 0x2c8]
0107f751 24fe and al, 0xfe
0107f753 0ac8 or cl, al
0107f755 41888fc8020000 mov byte ptr [r15 + 0x2c8], cl
0107f75c 8b85b40d0000 mov eax, dword ptr [rbp + 0xdb4]
0107f762 41898700040000 mov dword ptr [r15 + 0x400], eax
0107f769 0fb68de2020000 movzx ecx, byte ptr [rbp + 0x2e2]
0107f770 80e101 and cl, 1
0107f773 410fb687f0030000 movzx eax, byte ptr [r15 + 0x3f0]
0107f77b 24fe and al, 0xfe
0107f77d 0ac8 or cl, al
0107f77f 41888ff0030000 mov byte ptr [r15 + 0x3f0], cl
0107f786 0fb685e3020000 movzx eax, byte ptr [rbp + 0x2e3]
0107f78d 41888760030000 mov byte ptr [r15 + 0x360], al
0107f794 488b85e4020000 mov rax, qword ptr [rbp + 0x2e4]
0107f79b 49898758030000 mov qword ptr [r15 + 0x358], rax
0107f7a2 488b85f4020000 mov rax, qword ptr [rbp + 0x2f4]
0107f7a9 49898768030000 mov qword ptr [r15 + 0x368], rax
0107f7b0 6641897710 mov word ptr [r15 + 0x10], si
0107f7b5 0fb68d28030000 movzx ecx, byte ptr [rbp + 0x328]
0107f7bc 80e101 and cl, 1
0107f7bf c0e103 shl cl, 3
0107f7c2 410fb687d9010000 movzx eax, byte ptr [r15 + 0x1d9]
0107f7ca 24f7 and al, 0xf7
0107f7cc 0ac8 or cl, al
0107f7ce 41888fd9010000 mov byte ptr [r15 + 0x1d9], cl
0107f7d5 0fb68d940d0000 movzx ecx, byte ptr [rbp + 0xd94]
0107f7dc 80e101 and cl, 1
0107f7df c0e105 shl cl, 5
0107f7e2 410fb687c9020000 movzx eax, byte ptr [r15 + 0x2c9]
0107f7ea 24df and al, 0xdf
0107f7ec 0ac8 or cl, al
0107f7ee 41888fc9020000 mov byte ptr [r15 + 0x2c9], cl
0107f7f5 0fb685950d0000 movzx eax, byte ptr [rbp + 0xd95]
0107f7fc c0e007 shl al, 7
0107f7ff 80e17f and cl, 0x7f
0107f802 0ac1 or al, cl
0107f804 418887c9020000 mov byte ptr [r15 + 0x2c9], al
0107f80b 6683fe01 cmp si, 1
0107f80f 0f94442444 sete byte ptr [rsp + 0x44]
0107f814 49837f5000 cmp qword ptr [r15 + 0x50], 0
0107f819 750b jne 0x14107f826
0107f81b 33c9 xor ecx, ecx
0107f81d e85e60b2ff call 0x140ba5880
0107f822 49894750 mov qword ptr [r15 + 0x50], rax
0107f826 488b8548030000 mov rax, qword ptr [rbp + 0x348]
0107f82d 49898718020000 mov qword ptr [r15 + 0x218], rax
0107f834 488b8550030000 mov rax, qword ptr [rbp + 0x350]
0107f83b 49898720020000 mov qword ptr [r15 + 0x220], rax
0107f842 8b85880d0000 mov eax, dword ptr [rbp + 0xd88]
0107f848 41898778030000 mov dword ptr [r15 + 0x378], eax
0107f84f 8b858c0d0000 mov eax, dword ptr [rbp + 0xd8c]
0107f855 4189877c030000 mov dword ptr [r15 + 0x37c], eax
0107f85c 8b85900d0000 mov eax, dword ptr [rbp + 0xd90]
0107f862 41898780030000 mov dword ptr [r15 + 0x380], eax
0107f869 488b8564030000 mov rax, qword ptr [rbp + 0x364]
0107f870 49898798030000 mov qword ptr [r15 + 0x398], rax
0107f877 488b856c030000 mov rax, qword ptr [rbp + 0x36c]
0107f87e 498987a0030000 mov qword ptr [r15 + 0x3a0], rax
0107f885 488b8574030000 mov rax, qword ptr [rbp + 0x374]
0107f88c 498987a8030000 mov qword ptr [r15 + 0x3a8], rax
0107f893 488b857c030000 mov rax, qword ptr [rbp + 0x37c]
0107f89a 498987b0030000 mov qword ptr [r15 + 0x3b0], rax
0107f8a1 488b8584030000 mov rax, qword ptr [rbp + 0x384]
0107f8a8 498987b8030000 mov qword ptr [r15 + 0x3b8], rax
0107f8af 488b858c030000 mov rax, qword ptr [rbp + 0x38c]
0107f8b6 498987c0030000 mov qword ptr [r15 + 0x3c0], rax
0107f8bd 488b85680d0000 mov rax, qword ptr [rbp + 0xd68]
0107f8c4 498987c8030000 mov qword ptr [r15 + 0x3c8], rax
0107f8cb 488b85700d0000 mov rax, qword ptr [rbp + 0xd70]
0107f8d2 498987d0030000 mov qword ptr [r15 + 0x3d0], rax
0107f8d9 488b85780d0000 mov rax, qword ptr [rbp + 0xd78]
0107f8e0 498987d8030000 mov qword ptr [r15 + 0x3d8], rax
0107f8e7 488b85800d0000 mov rax, qword ptr [rbp + 0xd80]
0107f8ee 498987e0030000 mov qword ptr [r15 + 0x3e0], rax
0107f8f5 6641837f100f cmp word ptr [r15 + 0x10], 0xf
0107f8fb 7510 jne 0x14107f90d
0107f8fd 498d8710010000 lea rax, [r15 + 0x110]
0107f904 4885c0 test rax, rax
0107f907 7404 je 0x14107f90d
0107f909 80480320 or byte ptr [rax + 3], 0x20
0107f90d 66837f0c3c cmp word ptr [rdi + 0xc], 0x3c
0107f912 0f8386000000 jae 0x14107f99e
0107f918 498bcf mov rcx, r15
0107f91b e8504af3ff call 0x140fb4370
0107f920 488bf0 mov rsi, rax
0107f923 4885c0 test rax, rax
0107f926 7476 je 0x14107f99e
0107f928 4883c01e add rax, 0x1e
0107f92c 7441 je 0x14107f96f
0107f92e 8b9598030000 mov edx, dword ptr [rbp + 0x398]
0107f934 8d4aff lea ecx, [rdx - 1]
0107f937 83f963 cmp ecx, 0x63
0107f93a 7710 ja 0x14107f94c
0107f93c 448b8d9c030000 mov r9d, dword ptr [rbp + 0x39c]
0107f943 4c8d85a0030000 lea r8, [rbp + 0x3a0]
0107f94a eb19 jmp 0x14107f965
0107f94c 8b9548010000 mov edx, dword ptr [rbp + 0x148]
0107f952 83fa20 cmp edx, 0x20
0107f955 7718 ja 0x14107f96f
0107f957 448b8d4c010000 mov r9d, dword ptr [rbp + 0x14c]
0107f95e 4c8d8550010000 lea r8, [rbp + 0x150]
0107f965 4889442420 mov qword ptr [rsp + 0x20], rax
0107f96a e851efffff call 0x14107e8c0
0107f96f 4533c0 xor r8d, r8d
0107f972 488bd6 mov rdx, rsi
0107f975 498bcf mov rcx, r15
0107f978 e8b33af3ff call 0x140fb3430
0107f97d 836e0c01 sub dword ptr [rsi + 0xc], 1
0107f981 751b jne 0x14107f99e
0107f983 4533f6 xor r14d, r14d
0107f986 817e0874657363 cmp dword ptr [rsi + 8], 0x63736574
0107f98d 7512 jne 0x14107f9a1
0107f98f 44897608 mov dword ptr [rsi + 8], r14d
0107f993 488bce mov rcx, rsi
0107f996 ff15ccc98600 call qword ptr [rip + 0x86c9cc]
0107f99c eb03 jmp 0x14107f9a1
0107f99e 4533f6 xor r14d, r14d
0107f9a1 0f57c0 xorps xmm0, xmm0
0107f9a4 33c0 xor eax, eax
0107f9a6 0f1185e80e0000 movups xmmword ptr [rbp + 0xee8], xmm0
0107f9ad 0f1185f80e0000 movups xmmword ptr [rbp + 0xef8], xmm0
0107f9b4 668985080f0000 mov word ptr [rbp + 0xf08], ax
0107f9bb 41813f74736c70 cmp dword ptr [r15], 0x706c7374
0107f9c2 7525 jne 0x14107f9e9
0107f9c4 f30f7f4598 movdqu xmmword ptr [rbp - 0x68], xmm0
0107f9c9 4c8975a8 mov qword ptr [rbp - 0x58], r14
0107f9cd 488d85e80e0000 lea rax, [rbp + 0xee8]
0107f9d4 48894590 mov qword ptr [rbp - 0x70], rax
0107f9d8 4c8d4590 lea r8, [rbp - 0x70]
0107f9dc ba6d707067 mov edx, 0x6770706d
0107f9e1 498bcf mov rcx, r15
0107f9e4 e8974be7ff call 0x140ef4580
0107f9e9 410fb74710 movzx eax, word ptr [r15 + 0x10]
0107f9ee 83c0f6 add eax, -0xa
0107f9f1 83f81d cmp eax, 0x1d
0107f9f4 7724 ja 0x14107fa1a
0107f9f6 4898 cdqe 
0107f9f8 488d150106f8fe lea rdx, [rip - 0x107f9ff]
0107f9ff 0fb6840248170801 movzx eax, byte ptr [rdx + rax + 0x1081748]
0107fa07 8b8c8224170801 mov ecx, dword ptr [rdx + rax*4 + 0x1081724]
0107fa0e 4803ca add rcx, rdx
0107fa11 ffe1 jmp rcx
0107fa13 80a5080f0000fe and byte ptr [rbp + 0xf08], 0xfe
0107fa1a 41813f74736c70 cmp dword ptr [r15], 0x706c7374
0107fa21 7538 jne 0x14107fa5b
0107fa23 664183bffc01000000 cmp word ptr [r15 + 0x1fc], 0
0107fa2c 752d jne 0x14107fa5b
0107fa2e 0f1085e80e0000 movups xmm0, xmmword ptr [rbp + 0xee8]
0107fa35 410f11874c040000 movups xmmword ptr [r15 + 0x44c], xmm0
0107fa3d 0f108df80e0000 movups xmm1, xmmword ptr [rbp + 0xef8]
0107fa44 410f118f5c040000 movups xmmword ptr [r15 + 0x45c], xmm1
0107fa4c 0fb785080f0000 movzx eax, word ptr [rbp + 0xf08]
0107fa53 664189876c040000 mov word ptr [r15 + 0x46c], ax
0107fa5b 418bf6 mov esi, r14d
0107fa5e 4489742430 mov dword ptr [rsp + 0x30], r14d
0107fa63 83bd2c01000000 cmp dword ptr [rbp + 0x12c], 0
0107fa6a 0f8624050000 jbe 0x14107ff94
0107fa70 41b818000000 mov r8d, 0x18
0107fa76 488d95d00e0000 lea rdx, [rbp + 0xed0]
0107fa7d 488bcf mov rcx, rdi
0107fa80 e8eb77ffff call 0x141077270
0107fa85 8bd8 mov ebx, eax
0107fa87 85c0 test eax, eax
0107fa89 0f84bf000000 je 0x14107fb4e
0107fa8f 3d30ffffff cmp eax, 0xffffff30
0107fa94 0f854d1c0000 jne 0x1410816e7
0107fa9a 448b85d40e0000 mov r8d, dword ptr [rbp + 0xed4]
0107faa1 448b8dd00e0000 mov r9d, dword ptr [rbp + 0xed0]
0107faa8 e9dd010000 jmp 0x14107fc8a
0107faad 41808fca02000008 or byte ptr [r15 + 0x2ca], 8
0107fab5 80a5080f0000e6 and byte ptr [rbp + 0xf08], 0xe6
0107fabc 808d090f000004 or byte ptr [rbp + 0xf09], 4
0107fac3 e952ffffff jmp 0x14107fa1a
0107fac8 48833de0f8040100 cmp qword ptr [rip + 0x104f8e0], 0
0107fad0 7415 je 0x14107fae7
0107fad2 e84915e8ff call 0x140f01020
0107fad7 4885c0 test rax, rax
0107fada 740b je 0x14107fae7
0107fadc 8b4058 mov eax, dword ptr [rax + 0x58]
0107fadf 85c0 test eax, eax
0107fae1 7404 je 0x14107fae7
0107fae3 41894758 mov dword ptr [r15 + 0x58], eax
0107fae7 808d080f000018 or byte ptr [rbp + 0xf08], 0x18
0107faee e927ffffff jmp 0x14107fa1a
0107faf3 488b855c030000 mov rax, qword ptr [rbp + 0x35c]
0107fafa 498987e0040000 mov qword ptr [r15 + 0x4e0], rax
0107fb01 80a5080f0000e7 and byte ptr [rbp + 0xf08], 0xe7
0107fb08 e90dffffff jmp 0x14107fa1a
0107fb0d 488b855c030000 mov rax, qword ptr [rbp + 0x35c]
0107fb14 498987e0040000 mov qword ptr [r15 + 0x4e0], rax
0107fb1b e9fafeffff jmp 0x14107fa1a
0107fb20 6645897710 mov word ptr [r15 + 0x10], r14w
0107fb25 e9f0feffff jmp 0x14107fa1a
0107fb2a 498bcf mov rcx, r15
0107fb2d e8ce80f7ff call 0x140ff7c00
0107fb32 8bd8 mov ebx, eax
0107fb34 85c0 test eax, eax
0107fb36 0f85ab1b0000 jne 0x1410816e7
0107fb3c e9d9feffff jmp 0x14107fa1a
0107fb41 498bcf mov rcx, r15
0107fb44 e85794f8ff call 0x141008fa0
0107fb49 e90dffffff jmp 0x14107fa5b
0107fb4e 41807d0000 cmp byte ptr [r13], 0
0107fb53 0f8504010000 jne 0x14107fc5d
0107fb59 8b8dd00e0000 mov ecx, dword ptr [rbp + 0xed0]
0107fb5f 448bc9 mov r9d, ecx
0107fb62 4181e10000ff00 and r9d, 0xff0000
0107fb69 8bc1 mov eax, ecx
0107fb6b c1e810 shr eax, 0x10
0107fb6e 440bc8 or r9d, eax
0107fb71 41c1e908 shr r9d, 8
0107fb75 8bc1 mov eax, ecx
0107fb77 c1e010 shl eax, 0x10
0107fb7a 81e100ff0000 and ecx, 0xff00
0107fb80 0bc1 or eax, ecx
0107fb82 c1e008 shl eax, 8
0107fb85 440bc8 or r9d, eax
0107fb88 44898dd00e0000 mov dword ptr [rbp + 0xed0], r9d
0107fb8f 8b8dd40e0000 mov ecx, dword ptr [rbp + 0xed4]
0107fb95 448bc1 mov r8d, ecx
0107fb98 4181e00000ff00 and r8d, 0xff0000
0107fb9f 8bc1 mov eax, ecx
0107fba1 c1e810 shr eax, 0x10
0107fba4 440bc0 or r8d, eax
0107fba7 41c1e808 shr r8d, 8
0107fbab 8bc1 mov eax, ecx
0107fbad c1e010 shl eax, 0x10
0107fbb0 81e100ff0000 and ecx, 0xff00
0107fbb6 0bc1 or eax, ecx
0107fbb8 c1e008 shl eax, 8
0107fbbb 440bc0 or r8d, eax
0107fbbe 448985d40e0000 mov dword ptr [rbp + 0xed4], r8d
0107fbc5 8b8dd80e0000 mov ecx, dword ptr [rbp + 0xed8]
0107fbcb 8bf1 mov esi, ecx
0107fbcd 81e60000ff00 and esi, 0xff0000
0107fbd3 8bc1 mov eax, ecx
0107fbd5 c1e810 shr eax, 0x10
0107fbd8 0bf0 or esi, eax
0107fbda c1ee08 shr esi, 8
0107fbdd 8bc1 mov eax, ecx
0107fbdf c1e010 shl eax, 0x10
0107fbe2 81e100ff0000 and ecx, 0xff00
0107fbe8 0bc1 or eax, ecx
0107fbea c1e008 shl eax, 8
0107fbed 0bf0 or esi, eax
0107fbef 89b5d80e0000 mov dword ptr [rbp + 0xed8], esi
0107fbf5 8b8ddc0e0000 mov ecx, dword ptr [rbp + 0xedc]
0107fbfb 448bd1 mov r10d, ecx
0107fbfe 4181e20000ff00 and r10d, 0xff0000
0107fc05 8bc1 mov eax, ecx
0107fc07 c1e810 shr eax, 0x10
0107fc0a 440bd0 or r10d, eax
0107fc0d 41c1ea08 shr r10d, 8
0107fc11 8bc1 mov eax, ecx
0107fc13 c1e010 shl eax, 0x10
0107fc16 81e100ff0000 and ecx, 0xff00
0107fc1c 0bc1 or eax, ecx
0107fc1e c1e008 shl eax, 8
0107fc21 440bd0 or r10d, eax
0107fc24 448995dc0e0000 mov dword ptr [rbp + 0xedc], r10d
0107fc2b 8b8de00e0000 mov ecx, dword ptr [rbp + 0xee0]
0107fc31 8bd1 mov edx, ecx
0107fc33 81e20000ff00 and edx, 0xff0000
0107fc39 8bc1 mov eax, ecx
0107fc3b c1e810 shr eax, 0x10
0107fc3e 0bd0 or edx, eax
0107fc40 c1ea08 shr edx, 8
0107fc43 8bc1 mov eax, ecx
0107fc45 c1e010 shl eax, 0x10
0107fc48 81e100ff0000 and ecx, 0xff00
0107fc4e 0bc1 or eax, ecx
0107fc50 c1e008 shl eax, 8
0107fc53 0bd0 or edx, eax
0107fc55 8995e00e0000 mov dword ptr [rbp + 0xee0], edx
0107fc5b eb1b jmp 0x14107fc78
0107fc5d 448b95dc0e0000 mov r10d, dword ptr [rbp + 0xedc]
0107fc64 8bb5d80e0000 mov esi, dword ptr [rbp + 0xed8]
0107fc6a 448b85d40e0000 mov r8d, dword ptr [rbp + 0xed4]
0107fc71 448b8dd00e0000 mov r9d, dword ptr [rbp + 0xed0]
0107fc78 4181f96d686f68 cmp r9d, 0x686f686d
0107fc7f 7451 je 0x14107fcd2
0107fc81 bb30ffffff mov ebx, 0xffffff30
0107fc86 8b742430 mov esi, dword ptr [rsp + 0x30]
0107fc8a 4181f96d747068 cmp r9d, 0x6870746d
0107fc91 0f85501a0000 jne 0x1410816e7
0107fc97 41f7d8 neg r8d
0107fc9a 4963d0 movsxd rdx, r8d
0107fc9d 4803977001e001 add rdx, qword ptr [rdi + 0x1e00170]
0107fca4 4889977001e001 mov qword ptr [rdi + 0x1e00170], rdx
0107fcab 488b8f7801e001 mov rcx, qword ptr [rdi + 0x1e00178]
0107fcb2 483bd1 cmp rdx, rcx
0107fcb5 720c jb 0x14107fcc3
0107fcb7 48038f8001e001 add rcx, qword ptr [rdi + 0x1e00180]
0107fcbe 483bd1 cmp rdx, rcx
0107fcc1 7207 jb 0x14107fcca
0107fcc3 4c89b78001e001 mov qword ptr [rdi + 0x1e00180], r14
0107fcca 418bde mov ebx, r14d
0107fccd e9ab020000 jmp 0x14107ff7d
0107fcd2 4183c29c add r10d, -0x64
0107fcd6 4183fa09 cmp r10d, 9
0107fcda 7770 ja 0x14107fd4c
0107fcdc 488d151d03f8fe lea rdx, [rip - 0x107fce3]
0107fce3 428b8c9268170801 mov ecx, dword ptr [rdx + r10*4 + 0x1081768]
0107fceb 4803ca add rcx, rdx
0107fcee ffe1 jmp rcx
0107fcf0 6641837f1023 cmp word ptr [r15 + 0x10], 0x23
0107fcf6 7454 je 0x14107fd4c
0107fcf8 498d8778010000 lea rax, [r15 + 0x178]
0107fcff 4d8d8730010000 lea r8, [r15 + 0x130]
0107fd06 4489742428 mov dword ptr [rsp + 0x28], r14d
0107fd0b 4889442420 mov qword ptr [rsp + 0x20], rax
0107fd10 4533c9 xor r9d, r9d
0107fd13 ba01000000 mov edx, 1
0107fd18 488bcf mov rcx, rdi
0107fd1b e8b076ffff call 0x1410773d0
0107fd20 8bd8 mov ebx, eax
0107fd22 85c0 test eax, eax
0107fd24 7514 jne 0x14107fd3a
0107fd26 41f687d801000008 test byte ptr [r15 + 0x1d8], 8
0107fd2e 740a je 0x14107fd3a
0107fd30 c644243501 mov byte ptr [rsp + 0x35], 1
0107fd35 e93f020000 jmp 0x14107ff79
0107fd3a c644243500 mov byte ptr [rsp + 0x35], 0
0107fd3f 85c0 test eax, eax
0107fd41 0f85a0190000 jne 0x1410816e7
0107fd47 e92d020000 jmp 0x14107ff79
0107fd4c 412bf0 sub esi, r8d
0107fd4f 4863d6 movsxd rdx, esi
0107fd52 4803977001e001 add rdx, qword ptr [rdi + 0x1e00170]
0107fd59 4889977001e001 mov qword ptr [rdi + 0x1e00170], rdx
0107fd60 488b8f7801e001 mov rcx, qword ptr [rdi + 0x1e00178]
0107fd67 483bd1 cmp rdx, rcx
0107fd6a 720c jb 0x14107fd78
0107fd6c 48038f8001e001 add rcx, qword ptr [rdi + 0x1e00180]
0107fd73 483bd1 cmp rdx, rcx
0107fd76 7207 jb 0x14107fd7f
0107fd78 4c89b78001e001 mov qword ptr [rdi + 0x1e00180], r14
0107fd7f 418bde mov ebx, r14d
0107fd82 e9f2010000 jmp 0x14107ff79
0107fd87 412bf0 sub esi, r8d
0107fd8a 448bc6 mov r8d, esi
0107fd8d 4981f80000a000 cmp r8, 0xa00000
0107fd94 0f8748190000 ja 0x1410816e2
0107fd9a 488d972801a000 lea rdx, [rdi + 0xa00128]
0107fda1 488bcf mov rcx, rdi
0107fda4 e8f772ffff call 0x1410770a0
0107fda9 8bd8 mov ebx, eax
0107fdab 85c0 test eax, eax
0107fdad 0f8534190000 jne 0x1410816e7
0107fdb3 8b95d80e0000 mov edx, dword ptr [rbp + 0xed8]
0107fdb9 2b95d40e0000 sub edx, dword ptr [rbp + 0xed4]
0107fdbf 488d45e8 lea rax, [rbp - 0x18]
0107fdc3 4889442420 mov qword ptr [rsp + 0x20], rax
0107fdc8 488d8f2801a000 lea rcx, [rdi + 0xa00128]
0107fdcf e8fc0fb7ff call 0x140bf0dd0
0107fdd4 e9a0010000 jmp 0x14107ff79
0107fdd9 412bf0 sub esi, r8d
0107fddc 448bc6 mov r8d, esi
0107fddf 4981f80000a000 cmp r8, 0xa00000
0107fde6 0f87f6180000 ja 0x1410816e2
0107fdec 488db72801a000 lea rsi, [rdi + 0xa00128]
0107fdf3 488bd6 mov rdx, rsi
0107fdf6 488bcf mov rcx, rdi
0107fdf9 e8a272ffff call 0x1410770a0
0107fdfe 8bd8 mov ebx, eax
0107fe00 85c0 test eax, eax
0107fe02 0f85df180000 jne 0x1410816e7
0107fe08 0f57c0 xorps xmm0, xmm0
0107fe0b 0f114530 movups xmmword ptr [rbp + 0x30], xmm0
0107fe0f 0f114540 movups xmmword ptr [rbp + 0x40], xmm0
0107fe13 0f114550 movups xmmword ptr [rbp + 0x50], xmm0
0107fe17 0f114560 movups xmmword ptr [rbp + 0x60], xmm0
0107fe1b 0f114570 movups xmmword ptr [rbp + 0x70], xmm0
0107fe1f 0f118580000000 movups xmmword ptr [rbp + 0x80], xmm0
0107fe26 0f118590000000 movups xmmword ptr [rbp + 0x90], xmm0
0107fe2d 4885f6 test rsi, rsi
0107fe30 743d je 0x14107fe6f
0107fe32 0f1006 movups xmm0, xmmword ptr [rsi]
0107fe35 0f294530 movaps xmmword ptr [rbp + 0x30], xmm0
0107fe39 0f104e10 movups xmm1, xmmword ptr [rsi + 0x10]
0107fe3d 0f294d40 movaps xmmword ptr [rbp + 0x40], xmm1
0107fe41 0f104620 movups xmm0, xmmword ptr [rsi + 0x20]
0107fe45 0f294550 movaps xmmword ptr [rbp + 0x50], xmm0
0107fe49 0f104e30 movups xmm1, xmmword ptr [rsi + 0x30]
0107fe4d 0f294d60 movaps xmmword ptr [rbp + 0x60], xmm1
0107fe51 0f104640 movups xmm0, xmmword ptr [rsi + 0x40]
0107fe55 0f294570 movaps xmmword ptr [rbp + 0x70], xmm0
0107fe59 0f104e50 movups xmm1, xmmword ptr [rsi + 0x50]
0107fe5d 0f298d80000000 movaps xmmword ptr [rbp + 0x80], xmm1
0107fe64 0f104660 movups xmm0, xmmword ptr [rsi + 0x60]
0107fe68 0f298590000000 movaps xmmword ptr [rbp + 0x90], xmm0
0107fe6f c644243401 mov byte ptr [rsp + 0x34], 1
0107fe74 e900010000 jmp 0x14107ff79
0107fe79 412bf0 sub esi, r8d
0107fe7c 448bc6 mov r8d, esi
0107fe7f 4981f80000a000 cmp r8, 0xa00000
0107fe86 0f8756180000 ja 0x1410816e2
0107fe8c 488db72801a000 lea rsi, [rdi + 0xa00128]
0107fe93 488bd6 mov rdx, rsi
0107fe96 488bcf mov rcx, rdi
0107fe99 e80272ffff call 0x1410770a0
0107fe9e 8bd8 mov ebx, eax
0107fea0 85c0 test eax, eax
0107fea2 0f853f180000 jne 0x1410816e7
0107fea8 448bb5d80e0000 mov r14d, dword ptr [rbp + 0xed8]
0107feaf 442bb5d40e0000 sub r14d, dword ptr [rbp + 0xed4]
0107feb6 41c1ee03 shr r14d, 3
0107feba 4585f6 test r14d, r14d
0107febd 0f84b3000000 je 0x14107ff76
0107fec3 418bd6 mov edx, r14d
0107fec6 488d4c2478 lea rcx, [rsp + 0x78]
0107fecb e8d0c625ff call 0x1402dc5a0
0107fed0 8bd8 mov ebx, eax
0107fed2 85c0 test eax, eax
0107fed4 0f850d180000 jne 0x1410816e7
0107feda 41384500 cmp byte ptr [r13], al
0107fede 7525 jne 0x14107ff05
0107fee0 4585f6 test r14d, r14d
0107fee3 0f848d000000 je 0x14107ff76
0107fee9 488bce mov rcx, rsi
0107feec 418bd6 mov edx, r14d
0107feef 90 nop 
0107fef0 488b01 mov rax, qword ptr [rcx]
0107fef3 480fc8 bswap rax
0107fef6 488901 mov qword ptr [rcx], rax
0107fef9 488d4908 lea rcx, [rcx + 8]
0107fefd 4883ea01 sub rdx, 1
0107ff01 75ed jne 0x14107fef0
0107ff03 eb05 jmp 0x14107ff0a
0107ff05 4585f6 test r14d, r14d
0107ff08 746c je 0x14107ff76
0107ff0a 4c8b7c2478 mov r15, qword ptr [rsp + 0x78]
0107ff0f 90 nop 
0107ff10 488b06 mov rax, qword ptr [rsi]
0107ff13 4889442438 mov qword ptr [rsp + 0x38], rax
0107ff18 4d85e4 test r12, r12
0107ff1b 744a je 0x14107ff67
0107ff1d 4181bc248000000074616474 cmp dword ptr [r12 + 0x80], 0x74646174
0107ff29 753c jne 0x14107ff67
0107ff2b 4885c0 test rax, rax
0107ff2e 7437 je 0x14107ff67
0107ff30 498bcc mov rcx, r12
0107ff33 e8f81ee4ff call 0x140ec1e30
0107ff38 85c0 test eax, eax
0107ff3a 752b jne 0x14107ff67
0107ff3c 488d542438 lea rdx, [rsp + 0x38]
0107ff41 498b8c24e0180000 mov rcx, qword ptr [r12 + 0x18e0]
0107ff49 e822df3aff call 0x14042de70
0107ff4e 4885c0 test rax, rax
0107ff51 7414 je 0x14107ff67
0107ff53 488b5008 mov rdx, qword ptr [rax + 8]
0107ff57 4885d2 test rdx, rdx
0107ff5a 740b je 0x14107ff67
0107ff5c 4533c0 xor r8d, r8d
0107ff5f 498bcf mov rcx, r15
0107ff62 e859d525ff call 0x1402dd4c0
0107ff67 4883c608 add rsi, 8
0107ff6b 4983ee01 sub r14, 1
0107ff6f 759f jne 0x14107ff10
0107ff71 4c8b7c2448 mov r15, qword ptr [rsp + 0x48]
0107ff76 4533f6 xor r14d, r14d
0107ff79 8b742430 mov esi, dword ptr [rsp + 0x30]
0107ff7d ffc6 inc esi
0107ff7f 89742430 mov dword ptr [rsp + 0x30], esi
0107ff83 3bb52c010000 cmp esi, dword ptr [rbp + 0x12c]
0107ff89 4c8b642460 mov r12, qword ptr [rsp + 0x60]
0107ff8e 0f82dcfaffff jb 0x14107fa70
0107ff94 498bcf mov rcx, r15
0107ff97 e8346d79ff call 0x140816cd0
0107ff9c 84c0 test al, al
0107ff9e 7408 je 0x14107ffa8
0107ffa0 498bcf mov rcx, r15
0107ffa3 e8386e79ff call 0x140816de0
0107ffa8 498b7770 mov rsi, qword ptr [r15 + 0x70]
0107ffac 4889742448 mov qword ptr [rsp + 0x48], rsi
0107ffb1 4533db xor r11d, r11d
0107ffb4 44895c246c mov dword ptr [rsp + 0x6c], r11d
0107ffb9 44399d30010000 cmp dword ptr [rbp + 0x130], r11d
0107ffc0 0f86ad0e0000 jbe 0x141080e73
0107ffc6 66660f1f840000000000 nop word ptr [rax + rax]
0107ffd0 4c896c2458 mov qword ptr [rsp + 0x58], r13
0107ffd5 41b808000000 mov r8d, 8
0107ffdb 488d95c0000000 lea rdx, [rbp + 0xc0]
0107ffe2 488bcf mov rcx, rdi
0107ffe5 e8b670ffff call 0x1410770a0
0107ffea 8bd8 mov ebx, eax
0107ffec 85c0 test eax, eax
0107ffee 0f85f3160000 jne 0x1410816e7
0107fff4 448b8dc4000000 mov r9d, dword ptr [rbp + 0xc4]
0107fffb 44894c2430 mov dword ptr [rsp + 0x30], r9d
01080000 458be1 mov r12d, r9d
01080003 41384500 cmp byte ptr [r13], al
01080007 7503 jne 0x14108000c
01080009 410fcc bswap r12d
0108000c 488d8dc8000000 lea rcx, [rbp + 0xc8]
01080013 41bd54000000 mov r13d, 0x54
01080019 453be5 cmp r12d, r13d
0108001c 450f42ec cmovb r13d, r12d
01080020 4183fd08 cmp r13d, 8
01080024 7649 jbe 0x14108006f
01080026 418d45f8 lea eax, [r13 - 8]
0108002a 4889442438 mov qword ptr [rsp + 0x38], rax
0108002f 483d0000a000 cmp rax, 0xa00000
01080035 0f87a7160000 ja 0x1410816e2
0108003b 448bc0 mov r8d, eax
0108003e 488d95c8000000 lea rdx, [rbp + 0xc8]
01080045 488bcf mov rcx, rdi
01080048 e85370ffff call 0x1410770a0
0108004d 8bd8 mov ebx, eax
0108004f 85c0 test eax, eax
01080051 0f8590160000 jne 0x1410816e7
01080057 488d8dc8000000 lea rcx, [rbp + 0xc8]
0108005e 48034c2438 add rcx, qword ptr [rsp + 0x38]
01080063 448b8dc4000000 mov r9d, dword ptr [rbp + 0xc4]
0108006a 44894c2430 mov dword ptr [rsp + 0x30], r9d
0108006f 4183fd54 cmp r13d, 0x54
01080073 7321 jae 0x141080096
01080075 4885c9 test rcx, rcx
01080078 741c je 0x141080096
0108007a 41b854000000 mov r8d, 0x54
01080080 452bc5 sub r8d, r13d
01080083 33d2 xor edx, edx
01080085 e816cc7100 call 0x14179cca0
0108008a 448b8dc4000000 mov r9d, dword ptr [rbp + 0xc4]
01080091 44894c2430 mov dword ptr [rsp + 0x30], r9d
01080096 453be5 cmp r12d, r13d
01080099 761d jbe 0x1410800b8
0108009b 452be5 sub r12d, r13d
0108009e 418bd4 mov edx, r12d
010800a1 488bcf mov rcx, rdi
010800a4 e877a4feff call 0x14106a520
010800a9 8bd8 mov ebx, eax
010800ab 85c0 test eax, eax
010800ad 0f8534160000 jne 0x1410816e7
010800b3 448b4c2430 mov r9d, dword ptr [rsp + 0x30]
010800b8 488b442458 mov rax, qword ptr [rsp + 0x58]
010800bd 4c8be8 mov r13, rax
010800c0 803800 cmp byte ptr [rax], 0
010800c3 0f8581070000 jne 0x14108084a
010800c9 8b8dc0000000 mov ecx, dword ptr [rbp + 0xc0]
010800cf 448bd9 mov r11d, ecx
010800d2 4181e30000ff00 and r11d, 0xff0000
010800d9 8bc1 mov eax, ecx
010800db c1e810 shr eax, 0x10
010800de 440bd8 or r11d, eax
010800e1 41c1eb08 shr r11d, 8
010800e5 8bc1 mov eax, ecx
010800e7 c1e010 shl eax, 0x10
010800ea 81e100ff0000 and ecx, 0xff00
010800f0 0bc1 or eax, ecx
010800f2 c1e008 shl eax, 8
010800f5 440bd8 or r11d, eax
010800f8 44899dc0000000 mov dword ptr [rbp + 0xc0], r11d
010800ff 418bc9 mov ecx, r9d
01080102 81e10000ff00 and ecx, 0xff0000
01080108 418bc1 mov eax, r9d
0108010b c1e810 shr eax, 0x10
0108010e 0bc8 or ecx, eax
01080110 c1e908 shr ecx, 8
01080113 418bc1 mov eax, r9d
01080116 c1e010 shl eax, 0x10
01080119 4181e100ff0000 and r9d, 0xff00
01080120 410bc1 or eax, r9d
01080123 c1e008 shl eax, 8
01080126 448bc9 mov r9d, ecx
01080129 440bc8 or r9d, eax
0108012c 44894c2430 mov dword ptr [rsp + 0x30], r9d
01080131 44898dc4000000 mov dword ptr [rbp + 0xc4], r9d
01080138 8b8dc8000000 mov ecx, dword ptr [rbp + 0xc8]
0108013e 8bd1 mov edx, ecx
01080140 81e20000ff00 and edx, 0xff0000
01080146 8bc1 mov eax, ecx
01080148 c1e810 shr eax, 0x10
0108014b 0bd0 or edx, eax
0108014d c1ea08 shr edx, 8
01080150 8bc1 mov eax, ecx
01080152 c1e010 shl eax, 0x10
01080155 81e100ff0000 and ecx, 0xff00
0108015b 0bc1 or eax, ecx
0108015d c1e008 shl eax, 8
01080160 0bd0 or edx, eax
01080162 8995c8000000 mov dword ptr [rbp + 0xc8], edx
01080168 8b8dcc000000 mov ecx, dword ptr [rbp + 0xcc]
0108016e 8bd1 mov edx, ecx
01080170 81e20000ff00 and edx, 0xff0000
01080176 8bc1 mov eax, ecx
01080178 c1e810 shr eax, 0x10
0108017b 0bd0 or edx, eax
0108017d c1ea08 shr edx, 8
01080180 8bc1 mov eax, ecx
01080182 c1e010 shl eax, 0x10
01080185 81e100ff0000 and ecx, 0xff00
0108018b 0bc1 or eax, ecx
0108018d c1e008 shl eax, 8
01080190 0bd0 or edx, eax
01080192 8995cc000000 mov dword ptr [rbp + 0xcc], edx
01080198 8b8dd0000000 mov ecx, dword ptr [rbp + 0xd0]
0108019e 8bd1 mov edx, ecx
010801a0 81e20000ff00 and edx, 0xff0000
010801a6 8bc1 mov eax, ecx
010801a8 c1e810 shr eax, 0x10
010801ab 0bd0 or edx, eax
010801ad c1ea08 shr edx, 8
010801b0 8bc1 mov eax, ecx
010801b2 c1e010 shl eax, 0x10
010801b5 81e100ff0000 and ecx, 0xff00
010801bb 0bc1 or eax, ecx
010801bd c1e008 shl eax, 8
010801c0 0bd0 or edx, eax
010801c2 8995d0000000 mov dword ptr [rbp + 0xd0], edx
010801c8 8b8dd4000000 mov ecx, dword ptr [rbp + 0xd4]
010801ce 448bd1 mov r10d, ecx
010801d1 4181e20000ff00 and r10d, 0xff0000
010801d8 8bc1 mov eax, ecx
010801da c1e810 shr eax, 0x10
010801dd 440bd0 or r10d, eax
010801e0 41c1ea08 shr r10d, 8
010801e4 8bc1 mov eax, ecx
010801e6 c1e010 shl eax, 0x10
010801e9 81e100ff0000 and ecx, 0xff00
010801ef 0bc1 or eax, ecx
010801f1 c1e008 shl eax, 8
010801f4 440bd0 or r10d, eax
010801f7 448995d4000000 mov dword ptr [rbp + 0xd4], r10d
010801fe 8b8dd8000000 mov ecx, dword ptr [rbp + 0xd8]
01080204 8bd1 mov edx, ecx
01080206 81e20000ff00 and edx, 0xff0000
0108020c 8bc1 mov eax, ecx
0108020e c1e810 shr eax, 0x10
01080211 0bd0 or edx, eax
01080213 c1ea08 shr edx, 8
01080216 8bc1 mov eax, ecx
01080218 c1e010 shl eax, 0x10
0108021b 81e100ff0000 and ecx, 0xff00
01080221 0bc1 or eax, ecx
01080223 c1e008 shl eax, 8
01080226 0bd0 or edx, eax
01080228 8995d8000000 mov dword ptr [rbp + 0xd8], edx
0108022e 8b8de0000000 mov ecx, dword ptr [rbp + 0xe0]
01080234 8bd1 mov edx, ecx
01080236 81e20000ff00 and edx, 0xff0000
0108023c 8bc1 mov eax, ecx
0108023e c1e810 shr eax, 0x10
01080241 0bd0 or edx, eax
01080243 c1ea08 shr edx, 8
01080246 8bc1 mov eax, ecx
01080248 c1e010 shl eax, 0x10
0108024b 81e100ff0000 and ecx, 0xff00
01080251 0bc1 or eax, ecx
01080253 c1e008 shl eax, 8
01080256 0bd0 or edx, eax
01080258 8995e0000000 mov dword ptr [rbp + 0xe0], edx
0108025e 488b95fc000000 mov rdx, qword ptr [rbp + 0xfc]
01080265 4c8bc2 mov r8, rdx
01080268 48bb000000000000ff00 movabs rbx, 0xff000000000000
01080272 4c23c3 and r8, rbx
01080275 488bc2 mov rax, rdx
01080278 48c1e810 shr rax, 0x10
0108027c 4c0bc0 or r8, rax
0108027f 49c1e810 shr r8, 0x10
01080283 488bc2 mov rax, rdx
01080286 49bc0000000000ff0000 movabs r12, 0xff0000000000
01080290 4923c4 and rax, r12
01080293 4c0bc0 or r8, rax
01080296 49c1e810 shr r8, 0x10
0108029a 488bc2 mov rax, rdx
0108029d 48b900000000ff000000 movabs rcx, 0xff00000000
010802a7 4823c1 and rax, rcx
010802aa 4c0bc0 or r8, rax
010802ad 49c1e808 shr r8, 8
010802b1 488bca mov rcx, rdx
010802b4 48c1e110 shl rcx, 0x10
010802b8 8bc2 mov eax, edx
010802ba 2500ff0000 and eax, 0xff00
010802bf 480bc8 or rcx, rax
010802c2 48c1e110 shl rcx, 0x10
010802c6 8bc2 mov eax, edx
010802c8 250000ff00 and eax, 0xff0000
010802cd 480bc8 or rcx, rax
010802d0 48c1e110 shl rcx, 0x10
010802d4 8bc2 mov eax, edx
010802d6 ba000000ff mov edx, 0xff000000
010802db 4823c2 and rax, rdx
010802de 480bc8 or rcx, rax
010802e1 48c1e108 shl rcx, 8
010802e5 4c0bc1 or r8, rcx
010802e8 4c8985fc000000 mov qword ptr [rbp + 0xfc], r8
010802ef 488b9504010000 mov rdx, qword ptr [rbp + 0x104]
010802f6 4c8bc2 mov r8, rdx
010802f9 4c23c3 and r8, rbx
010802fc 488bc2 mov rax, rdx
010802ff 48c1e810 shr rax, 0x10
01080303 4c0bc0 or r8, rax
01080306 49c1e810 shr r8, 0x10
0108030a 488bc2 mov rax, rdx
0108030d 4923c4 and rax, r12
01080310 4c0bc0 or r8, rax
01080313 49c1e810 shr r8, 0x10
01080317 488bc2 mov rax, rdx
0108031a 48b900000000ff000000 movabs rcx, 0xff00000000
01080324 4823c1 and rax, rcx
01080327 4c0bc0 or r8, rax
0108032a 49c1e808 shr r8, 8
0108032e 488bca mov rcx, rdx
01080331 48c1e110 shl rcx, 0x10
01080335 8bc2 mov eax, edx
01080337 2500ff0000 and eax, 0xff00
0108033c 480bc8 or rcx, rax
0108033f 48c1e110 shl rcx, 0x10
01080343 8bc2 mov eax, edx
01080345 250000ff00 and eax, 0xff0000
0108034a 480bc8 or rcx, rax
0108034d 48c1e110 shl rcx, 0x10
01080351 8bc2 mov eax, edx
01080353 ba000000ff mov edx, 0xff000000
01080358 4823c2 and rax, rdx
0108035b 480bc8 or rcx, rax
0108035e 48c1e108 shl rcx, 8
01080362 4c0bc1 or r8, rcx
01080365 4c898504010000 mov qword ptr [rbp + 0x104], r8
0108036c e9ee040000 jmp 0x14108085f
01080371 412bf0 sub esi, r8d
01080374 448bc6 mov r8d, esi
01080377 4981f80000a000 cmp r8, 0xa00000
0108037e 0f875e130000 ja 0x1410816e2
01080384 488db72801a000 lea rsi, [rdi + 0xa00128]
0108038b 488bd6 mov rdx, rsi
0108038e 488bcf mov rcx, rdi
01080391 e80a6dffff call 0x1410770a0
01080396 8bd8 mov ebx, eax
01080398 85c0 test eax, eax
0108039a 0f8547130000 jne 0x1410816e7
010803a0 8b85d80e0000 mov eax, dword ptr [rbp + 0xed8]
010803a6 2b85d40e0000 sub eax, dword ptr [rbp + 0xed4]
010803ac 3dc4040000 cmp eax, 0x4c4
010803b1 0f85c2fbffff jne 0x14107ff79
010803b7 4885f6 test rsi, rsi
010803ba 0f8486000000 je 0x141080446
010803c0 488d8d700f0000 lea rcx, [rbp + 0xf70]
010803c7 b809000000 mov eax, 9
010803cc 0f1f4000 nop dword ptr [rax]
010803d0 0f1006 movups xmm0, xmmword ptr [rsi]
010803d3 0f1101 movups xmmword ptr [rcx], xmm0
010803d6 0f104e10 movups xmm1, xmmword ptr [rsi + 0x10]
010803da 0f114910 movups xmmword ptr [rcx + 0x10], xmm1
010803de 0f104620 movups xmm0, xmmword ptr [rsi + 0x20]
010803e2 0f114120 movups xmmword ptr [rcx + 0x20], xmm0
010803e6 0f104e30 movups xmm1, xmmword ptr [rsi + 0x30]
010803ea 0f114930 movups xmmword ptr [rcx + 0x30], xmm1
010803ee 0f104640 movups xmm0, xmmword ptr [rsi + 0x40]
010803f2 0f114140 movups xmmword ptr [rcx + 0x40], xmm0
010803f6 0f104e50 movups xmm1, xmmword ptr [rsi + 0x50]
010803fa 0f114950 movups xmmword ptr [rcx + 0x50], xmm1
010803fe 0f104660 movups xmm0, xmmword ptr [rsi + 0x60]
01080402 0f114160 movups xmmword ptr [rcx + 0x60], xmm0
01080406 488d8980000000 lea rcx, [rcx + 0x80]
0108040d 0f104e70 movups xmm1, xmmword ptr [rsi + 0x70]
01080411 0f1149f0 movups xmmword ptr [rcx - 0x10], xmm1
01080415 488db680000000 lea rsi, [rsi + 0x80]
0108041c 4883e801 sub rax, 1
01080420 75ae jne 0x1410803d0
01080422 0f1006 movups xmm0, xmmword ptr [rsi]
01080425 0f1101 movups xmmword ptr [rcx], xmm0
01080428 0f104e10 movups xmm1, xmmword ptr [rsi + 0x10]
0108042c 0f114910 movups xmmword ptr [rcx + 0x10], xmm1
01080430 0f104620 movups xmm0, xmmword ptr [rsi + 0x20]
01080434 0f114120 movups xmmword ptr [rcx + 0x20], xmm0
01080438 0f104e30 movups xmm1, xmmword ptr [rsi + 0x30]
0108043c 0f114930 movups xmmword ptr [rcx + 0x30], xmm1
01080440 8b4640 mov eax, dword ptr [rsi + 0x40]
01080443 894140 mov dword ptr [rcx + 0x40], eax
01080446 488d95700f0000 lea rdx, [rbp + 0xf70]
0108044d 488bcf mov rcx, rdi
01080450 e8cb99feff call 0x141069e20
01080455 440fb68d740f0000 movzx r9d, byte ptr [rbp + 0xf74]
0108045d 418bc9 mov ecx, r9d
01080460 4584c9 test r9b, r9b
01080463 741e je 0x141080483
01080465 83e903 sub ecx, 3
01080468 7419 je 0x141080483
0108046a 83e901 sub ecx, 1
0108046d 7414 je 0x141080483
0108046f 83f901 cmp ecx, 1
01080472 0f8501fbffff jne 0x14107ff79
01080478 66837f0c2a cmp word ptr [rdi + 0xc], 0x2a
0108047d 0f82f6faffff jb 0x14107ff79
01080483 4c89742438 mov qword ptr [rsp + 0x38], r14
01080488 44884c2450 mov byte ptr [rsp + 0x50], r9b
0108048d 0fb685750f0000 movzx eax, byte ptr [rbp + 0xf75]
01080494 88442451 mov byte ptr [rsp + 0x51], al
01080498 4c8d442438 lea r8, [rsp + 0x38]
0108049d 8b95700f0000 mov edx, dword ptr [rbp + 0xf70]
010804a3 488d4c2450 lea rcx, [rsp + 0x50]
010804a8 e84332f3ff call 0x140fb36f0
010804ad 85c0 test eax, eax
010804af 0f85c4faffff jne 0x14107ff79
010804b5 488b742438 mov rsi, qword ptr [rsp + 0x38]
010804ba 0fb685760f0000 movzx eax, byte ptr [rbp + 0xf76]
010804c1 88461c mov byte ptr [rsi + 0x1c], al
010804c4 8b85780f0000 mov eax, dword ptr [rbp + 0xf78]
010804ca 894618 mov dword ptr [rsi + 0x18], eax
010804cd 0fb685770f0000 movzx eax, byte ptr [rbp + 0xf77]
010804d4 88461d mov byte ptr [rsi + 0x1d], al
010804d7 488d461e lea rax, [rsi + 0x1e]
010804db 4889442420 mov qword ptr [rsp + 0x20], rax
010804e0 448b8d800f0000 mov r9d, dword ptr [rbp + 0xf80]
010804e7 4c8d85840f0000 lea r8, [rbp + 0xf84]
010804ee 8b957c0f0000 mov edx, dword ptr [rbp + 0xf7c]
010804f4 e8c7e3ffff call 0x14107e8c0
010804f9 4533c0 xor r8d, r8d
010804fc 488bd6 mov rdx, rsi
010804ff 498bcf mov rcx, r15
01080502 e8292ff3ff call 0x140fb3430
01080507 0fb685760f0000 movzx eax, byte ptr [rbp + 0xf76]
0108050e 88461c mov byte ptr [rsi + 0x1c], al
01080511 4d8da718040000 lea r12, [r15 + 0x418]
01080518 488d5614 lea rdx, [rsi + 0x14]
0108051c 498bcc mov rcx, r12
0108051f e86c32f3ff call 0x140fb3790
01080524 4c8bf0 mov r14, rax
01080527 4885c0 test rax, rax
0108052a 7554 jne 0x141080580
0108052c 4d85e4 test r12, r12
0108052f 0f849c000000 je 0x1410805d1
01080535 41813c2468747363 cmp dword ptr [r12], 0x63737468
0108053d 0f8591000000 jne 0x1410805d4
01080543 ff460c inc dword ptr [rsi + 0xc]
01080546 488bc8 mov rcx, rax
01080549 498b442408 mov rax, qword ptr [r12 + 8]
0108054e 4885c0 test rax, rax
01080551 740b je 0x14108055e
01080553 488bc8 mov rcx, rax
01080556 488b00 mov rax, qword ptr [rax]
01080559 4885c0 test rax, rax
0108055c 75f5 jne 0x141080553
0108055e 4c8936 mov qword ptr [rsi], r14
01080561 4885c9 test rcx, rcx
01080564 750e jne 0x141080574
01080566 4989742408 mov qword ptr [r12 + 8], rsi
0108056b 41ff871c040000 inc dword ptr [r15 + 0x41c]
01080572 eb60 jmp 0x1410805d4
01080574 488931 mov qword ptr [rcx], rsi
01080577 41ff871c040000 inc dword ptr [r15 + 0x41c]
0108057e eb54 jmp 0x1410805d4
01080580 488d481e lea rcx, [rax + 0x1e]
01080584 488d561e lea rdx, [rsi + 0x1e]
01080588 41b8f40a0000 mov r8d, 0xaf4
0108058e e807c77100 call 0x14179cc9a
01080593 8b4618 mov eax, dword ptr [rsi + 0x18]
01080596 41894618 mov dword ptr [r14 + 0x18], eax
0108059a 0fb6461c movzx eax, byte ptr [rsi + 0x1c]
0108059e 4188461c mov byte ptr [r14 + 0x1c], al
010805a2 8b4618 mov eax, dword ptr [rsi + 0x18]
010805a5 41894618 mov dword ptr [r14 + 0x18], eax
010805a9 0fb6461d movzx eax, byte ptr [rsi + 0x1d]
010805ad 4188461d mov byte ptr [r14 + 0x1d], al
010805b1 41836e0c01 sub dword ptr [r14 + 0xc], 1
010805b6 7519 jne 0x1410805d1
010805b8 41817e0874657363 cmp dword ptr [r14 + 8], 0x63736574
010805c0 750f jne 0x1410805d1
010805c2 33c0 xor eax, eax
010805c4 41894608 mov dword ptr [r14 + 8], eax
010805c8 498bce mov rcx, r14
010805cb ff1597bd8600 call qword ptr [rip + 0x86bd97]
010805d1 4533f6 xor r14d, r14d
010805d4 836e0c01 sub dword ptr [rsi + 0xc], 1
010805d8 0f859bf9ffff jne 0x14107ff79
010805de 817e0874657363 cmp dword ptr [rsi + 8], 0x63736574
010805e5 0f858ef9ffff jne 0x14107ff79
010805eb 44897608 mov dword ptr [rsi + 8], r14d
010805ef 488bce mov rcx, rsi
010805f2 ff1570bd8600 call qword ptr [rip + 0x86bd70]
010805f8 e97cf9ffff jmp 0x14107ff79
010805fd 412bf0 sub esi, r8d
01080600 448bc6 mov r8d, esi
01080603 4981f80000a000 cmp r8, 0xa00000
0108060a 0f87d2100000 ja 0x1410816e2
01080610 488db72801a000 lea rsi, [rdi + 0xa00128]
01080617 488bd6 mov rdx, rsi
0108061a 488bcf mov rcx, rdi
0108061d e87e6affff call 0x1410770a0
01080622 8bd8 mov ebx, eax
01080624 85c0 test eax, eax
01080626 0f85bb100000 jne 0x1410816e7
0108062c 8b85d80e0000 mov eax, dword ptr [rbp + 0xed8]
01080632 2b85d40e0000 sub eax, dword ptr [rbp + 0xed4]
01080638 3dc4000000 cmp eax, 0xc4
0108063d 0f8536f9ffff jne 0x14107ff79
01080643 4885f6 test rsi, rsi
01080646 0f8480000000 je 0x1410806cc
0108064c 488d8d700f0000 lea rcx, [rbp + 0xf70]
01080653 0f1006 movups xmm0, xmmword ptr [rsi]
01080656 0f1101 movups xmmword ptr [rcx], xmm0
01080659 0f104e10 movups xmm1, xmmword ptr [rsi + 0x10]
0108065d 0f114910 movups xmmword ptr [rcx + 0x10], xmm1
01080661 0f104620 movups xmm0, xmmword ptr [rsi + 0x20]
01080665 0f114120 movups xmmword ptr [rcx + 0x20], xmm0
01080669 0f104e30 movups xmm1, xmmword ptr [rsi + 0x30]
0108066d 0f114930 movups xmmword ptr [rcx + 0x30], xmm1
01080671 0f104640 movups xmm0, xmmword ptr [rsi + 0x40]
01080675 0f114140 movups xmmword ptr [rcx + 0x40], xmm0
01080679 0f104e50 movups xmm1, xmmword ptr [rsi + 0x50]
0108067d 0f114950 movups xmmword ptr [rcx + 0x50], xmm1
01080681 0f104660 movups xmm0, xmmword ptr [rsi + 0x60]
01080685 0f114160 movups xmmword ptr [rcx + 0x60], xmm0
01080689 488d8980000000 lea rcx, [rcx + 0x80]
01080690 0f104e70 movups xmm1, xmmword ptr [rsi + 0x70]
01080694 0f1149f0 movups xmmword ptr [rcx - 0x10], xmm1
01080698 0f108680000000 movups xmm0, xmmword ptr [rsi + 0x80]
0108069f 0f1101 movups xmmword ptr [rcx], xmm0
010806a2 0f108e90000000 movups xmm1, xmmword ptr [rsi + 0x90]
010806a9 0f114910 movups xmmword ptr [rcx + 0x10], xmm1
010806ad 0f1086a0000000 movups xmm0, xmmword ptr [rsi + 0xa0]
010806b4 0f114120 movups xmmword ptr [rcx + 0x20], xmm0
010806b8 0f108eb0000000 movups xmm1, xmmword ptr [rsi + 0xb0]
010806bf 0f114930 movups xmmword ptr [rcx + 0x30], xmm1
010806c3 8b86c0000000 mov eax, dword ptr [rsi + 0xc0]
010806c9 894140 mov dword ptr [rcx + 0x40], eax
010806cc 488d95700f0000 lea rdx, [rbp + 0xf70]
010806d3 488bcf mov rcx, rdi
010806d6 e8b598feff call 0x141069f90
010806db 488b85700f0000 mov rax, qword ptr [rbp + 0xf70]
010806e2 41898730040000 mov dword ptr [r15 + 0x430], eax
010806e9 418bd6 mov edx, r14d
010806ec 83f806 cmp eax, 6
010806ef 760d jbe 0x1410806fe
010806f1 41c7873004000006000000 mov dword ptr [r15 + 0x430], 6
010806fc eb08 jmp 0x141080706
010806fe 85c0 test eax, eax
01080700 0f8473f8ffff je 0x14107ff79
01080706 8bca mov ecx, edx
01080708 8b848d740f0000 mov eax, dword ptr [rbp + rcx*4 + 0xf74]
0108070f 4189848f34040000 mov dword ptr [r15 + rcx*4 + 0x434], eax
01080717 ffc2 inc edx
01080719 413b9730040000 cmp edx, dword ptr [r15 + 0x430]
01080720 72e4 jb 0x141080706
01080722 e952f8ffff jmp 0x14107ff79
01080727 412bf0 sub esi, r8d
0108072a 8bde mov ebx, esi
0108072c 81fe0000a000 cmp esi, 0xa00000
01080732 761e jbe 0x141080752
01080734 ba10000000 mov edx, 0x10
01080739 8bce mov ecx, esi
0108073b ff152fbc8600 call qword ptr [rip + 0x86bc2f]
01080741 4c8bf0 mov r14, rax
01080744 4885c0 test rax, rax
01080747 0f84820f0000 je 0x1410816cf
0108074d 4c8be0 mov r12, rax
01080750 eb07 jmp 0x141080759
01080752 4c8da72801a000 lea r12, [rdi + 0xa00128]
01080759 4c8bc3 mov r8, rbx
0108075c 498bd4 mov rdx, r12
0108075f 488bcf mov rcx, rdi
01080762 e83969ffff call 0x1410770a0
01080767 8bd8 mov ebx, eax
01080769 85c0 test eax, eax
0108076b 0f85760f0000 jne 0x1410816e7
01080771 41813f74736c70 cmp dword ptr [r15], 0x706c7374
01080778 7541 jne 0x1410807bb
0108077a 498b4708 mov rax, qword ptr [r15 + 8]
0108077e f6801001000001 test byte ptr [rax + 0x110], 1
01080785 750c jne 0x141080793
01080787 81b88400000074657374 cmp dword ptr [rax + 0x84], 0x74736574
01080791 7528 jne 0x1410807bb
01080793 410fb74710 movzx eax, word ptr [r15 + 0x10]
01080798 6683f80a cmp ax, 0xa
0108079c 7406 je 0x1410807a4
0108079e 6683f81f cmp ax, 0x1f
010807a2 7517 jne 0x1410807bb
010807a4 498b8fe8010000 mov rcx, qword ptr [r15 + 0x1e8]
010807ab 4885c9 test rcx, rcx
010807ae 740b je 0x1410807bb
010807b0 448bce mov r9d, esi
010807b3 4d8bc4 mov r8, r12
010807b6 e8151ff6ff call 0x140fe26d0
010807bb 4d85f6 test r14, r14
010807be 0f84b2f7ffff je 0x14107ff76
010807c4 498bce mov rcx, r14
010807c7 ff159bbb8600 call qword ptr [rip + 0x86bb9b]
010807cd e9a4f7ffff jmp 0x14107ff76
010807d2 498d877c010000 lea rax, [r15 + 0x17c]
010807d9 4d8d8730010000 lea r8, [r15 + 0x130]
010807e0 4489742428 mov dword ptr [rsp + 0x28], r14d
010807e5 4889442420 mov qword ptr [rsp + 0x20], rax
010807ea 4533c9 xor r9d, r9d
010807ed ba01000000 mov edx, 1
010807f2 488bcf mov rcx, rdi
010807f5 e8d66bffff call 0x1410773d0
010807fa 8bd8 mov ebx, eax
010807fc 85c0 test eax, eax
010807fe 0f85e30e0000 jne 0x1410816e7
01080804 e970f7ffff jmp 0x14107ff79
01080809 412bf0 sub esi, r8d
0108080c b201 mov dl, 1
0108080e 498bcf mov rcx, r15
01080811 e80affe7ff call 0x140f00720
01080816 488bcf mov rcx, rdi
01080819 4885c0 test rax, rax
0108081c 740d je 0x14108082b
0108081e 448bc6 mov r8d, esi
01080821 488bd0 mov rdx, rax
01080824 e8c777ffff call 0x141077ff0
01080829 eb07 jmp 0x141080832
0108082b 8bd6 mov edx, esi
0108082d e8ee9cfeff call 0x14106a520
01080832 8bd8 mov ebx, eax
01080834 0fb6442434 movzx eax, byte ptr [rsp + 0x34]
01080839 88442434 mov byte ptr [rsp + 0x34], al
0108083d 85db test ebx, ebx
0108083f 0f85a20e0000 jne 0x1410816e7
01080845 e92ff7ffff jmp 0x14107ff79
0108084a 4c8b8504010000 mov r8, qword ptr [rbp + 0x104]
01080851 448b95d4000000 mov r10d, dword ptr [rbp + 0xd4]
01080858 448b9dc0000000 mov r11d, dword ptr [rbp + 0xc0]
0108085f 4c89442438 mov qword ptr [rsp + 0x38], r8
01080864 4181fb6d747068 cmp r11d, 0x6870746d
0108086b 0f85710e0000 jne 0x1410816e2
01080871 4533db xor r11d, r11d
01080874 418bdb mov ebx, r11d
01080877 453bd6 cmp r10d, r14d
0108087a 7429 je 0x1410808a5
0108087c 498b7770 mov rsi, qword ptr [r15 + 0x70]
01080880 4585d2 test r10d, r10d
01080883 740e je 0x141080893
01080885 418bd2 mov edx, r10d
01080888 488bce mov rcx, rsi
0108088b e870e1ffff call 0x14107ea00
01080890 488bf0 mov rsi, rax
01080893 4885f6 test rsi, rsi
01080896 740d je 0x1410808a5
01080898 458bf2 mov r14d, r10d
0108089b 4889742448 mov qword ptr [rsp + 0x48], rsi
010808a0 4532e4 xor r12b, r12b
010808a3 eb0c jmp 0x1410808b1
010808a5 4532e4 xor r12b, r12b
010808a8 4885f6 test rsi, rsi
010808ab 0f8467050000 je 0x141080e18
010808b1 488975f0 mov qword ptr [rbp - 0x10], rsi
010808b5 488b4e58 mov rcx, qword ptr [rsi + 0x58]
010808b9 48894df8 mov qword ptr [rbp - 8], rcx
010808bd 389ddc000000 cmp byte ptr [rbp + 0xdc], bl
010808c3 0f84fd000000 je 0x1410809c6
010808c9 c744246801007800 mov dword ptr [rsp + 0x68], 0x780001
010808d1 4c393e cmp qword ptr [rsi], r15
010808d4 0f85010e0000 jne 0x1410816db
010808da 488d41ff lea rax, [rcx - 1]
010808de 4883f8fd cmp rax, -3
010808e2 770a ja 0x1410808ee
010808e4 48397108 cmp qword ptr [rcx + 8], rsi
010808e8 0f85ed0d0000 jne 0x1410816db
010808ee 498b4770 mov rax, qword ptr [r15 + 0x70]
010808f2 4885c0 test rax, rax
010808f5 740d je 0x141080904
010808f7 817864ffffff7f cmp dword ptr [rax + 0x64], 0x7fffffff
010808fe 0f83d70d0000 jae 0x1410816db
01080904 b201 mov dl, 1
01080906 498bcf mov rcx, r15
01080909 e8f2bcf3ff call 0x140fbc600
0108090e 488bf0 mov rsi, rax
01080911 4885c0 test rax, rax
01080914 0f84c10d0000 je 0x1410816db
0108091a 80484bc0 or byte ptr [rax + 0x4b], 0xc0
0108091e 4c8d4068 lea r8, [rax + 0x68]
01080922 488b08 mov rcx, qword ptr [rax]
01080925 4881c130010000 add rcx, 0x130
0108092c 488d542468 lea rdx, [rsp + 0x68]
01080931 e80ae4b7ff call 0x140bfed40
01080936 488bce mov rcx, rsi
01080939 85c0 test eax, eax
0108093b 0f85950d0000 jne 0x1410816d6
01080941 e8bafde6ff call 0x140ef0700
01080946 41b001 mov r8b, 1
01080949 488d55f0 lea rdx, [rbp - 0x10]
0108094d 488bce mov rcx, rsi
01080950 e8abc1f3ff call 0x140fbcb00
01080955 488bce mov rcx, rsi
01080958 e893eee6ff call 0x140eef7f0
0108095d 0fb68ddd000000 movzx ecx, byte ptr [rbp + 0xdd]
01080964 c0e107 shl cl, 7
01080967 0fb6464b movzx eax, byte ptr [rsi + 0x4b]
0108096b 247f and al, 0x7f
0108096d 0ac8 or cl, al
0108096f 884e4b mov byte ptr [rsi + 0x4b], cl
01080972 0fb685ea000000 movzx eax, byte ptr [rbp + 0xea]
01080979 884670 mov byte ptr [rsi + 0x70], al
0108097c 41808fd801000002 or byte ptr [r15 + 0x1d8], 2
01080984 399dd8000000 cmp dword ptr [rbp + 0xd8], ebx
0108098a 0f84d5000000 je 0x141080a65
01080990 488d8f7802e001 lea rcx, [rdi + 0x1e00278]
01080997 488d95d8000000 lea rdx, [rbp + 0xd8]
0108099e e8dd2d61ff call 0x140693780
010809a3 4885c0 test rax, rax
010809a6 0f84b9000000 je 0x141080a65
010809ac 488b4008 mov rax, qword ptr [rax + 8]
010809b0 4885c0 test rax, rax
010809b3 0f84ac000000 je 0x141080a65
010809b9 48894630 mov qword ptr [rsi + 0x30], rax
010809bd 48897060 mov qword ptr [rax + 0x60], rsi
010809c1 e99f000000 jmp 0x141080a65
010809c6 488d8f7802e001 lea rcx, [rdi + 0x1e00278]
010809cd 488d95d8000000 lea rdx, [rbp + 0xd8]
010809d4 e8a72d61ff call 0x140693780
010809d9 4885c0 test rax, rax
010809dc 0f8426040000 je 0x141080e08
010809e2 488b4008 mov rax, qword ptr [rax + 8]
010809e6 4889442458 mov qword ptr [rsp + 0x58], rax
010809eb 4885c0 test rax, rax
010809ee 0f8414040000 je 0x141080e08
010809f4 48395810 cmp qword ptr [rax + 0x10], rbx
010809f8 0f840a040000 je 0x141080e08
010809fe 0f57c0 xorps xmm0, xmm0
01080a01 f30f7f4520 movdqu xmmword ptr [rbp + 0x20], xmm0
01080a06 488d4d20 lea rcx, [rbp + 0x20]
01080a0a 48894c2420 mov qword ptr [rsp + 0x20], rcx
01080a0f 4c8b4c2438 mov r9, qword ptr [rsp + 0x38]
01080a14 4c8d45f0 lea r8, [rbp - 0x10]
01080a18 488bd0 mov rdx, rax
01080a1b 498bcf mov rcx, r15
01080a1e e85d37e7ff call 0x140ef4180
01080a23 488bf0 mov rsi, rax
01080a26 4885c0 test rax, rax
01080a29 0f84ac0c0000 je 0x1410816db
01080a2f 8b8de0000000 mov ecx, dword ptr [rbp + 0xe0]
01080a35 894858 mov dword ptr [rax + 0x58], ecx
01080a38 0fb695e8000000 movzx edx, byte ptr [rbp + 0xe8]
01080a3f 80e201 and dl, 1
01080a42 c0e205 shl dl, 5
01080a45 0fb6484b movzx ecx, byte ptr [rax + 0x4b]
01080a49 80e1df and cl, 0xdf
01080a4c 0ad1 or dl, cl
01080a4e 88504b mov byte ptr [rax + 0x4b], dl
01080a51 389dde000000 cmp byte ptr [rbp + 0xde], bl
01080a57 740c je 0x141080a65
01080a59 488b442458 mov rax, qword ptr [rsp + 0x58]
01080a5e 80889a00000004 or byte ptr [rax + 0x9a], 4
01080a65 395c2440 cmp dword ptr [rsp + 0x40], ebx
01080a69 7d09 jge 0x141080a74
01080a6b 8b85d0000000 mov eax, dword ptr [rbp + 0xd0]
01080a71 894628 mov dword ptr [rsi + 0x28], eax
01080a74 8b85d0000000 mov eax, dword ptr [rbp + 0xd0]
01080a7a 89462c mov dword ptr [rsi + 0x2c], eax
01080a7d 33c0 xor eax, eax
01080a7f 89442458 mov dword ptr [rsp + 0x58], eax
01080a83 3985cc000000 cmp dword ptr [rbp + 0xcc], eax
01080a89 0f8662030000 jbe 0x141080df1
01080a8f 488b442448 mov rax, qword ptr [rsp + 0x48]
01080a94 0f1f4000 nop dword ptr [rax]
01080a98 0f1f840000000000 nop dword ptr [rax + rax]
01080aa0 4c896d90 mov qword ptr [rbp - 0x70], r13
01080aa4 4889442448 mov qword ptr [rsp + 0x48], rax
01080aa9 4489742430 mov dword ptr [rsp + 0x30], r14d
01080aae 41b808000000 mov r8d, 8
01080ab4 488d95d00e0000 lea rdx, [rbp + 0xed0]
01080abb 488bcf mov rcx, rdi
01080abe e8dd65ffff call 0x1410770a0
01080ac3 8bd8 mov ebx, eax
01080ac5 85c0 test eax, eax
01080ac7 0f851a0c0000 jne 0x1410816e7
01080acd 448b95d40e0000 mov r10d, dword ptr [rbp + 0xed4]
01080ad4 458bf2 mov r14d, r10d
01080ad7 41384500 cmp byte ptr [r13], al
01080adb 7503 jne 0x141080ae0
01080add 410fce bswap r14d
01080ae0 488d8dd80e0000 lea rcx, [rbp + 0xed8]
01080ae7 41bd18000000 mov r13d, 0x18
01080aed 453bf5 cmp r14d, r13d
01080af0 450f42ee cmovb r13d, r14d
01080af4 4183fd08 cmp r13d, 8
01080af8 7644 jbe 0x141080b3e
01080afa 418d45f8 lea eax, [r13 - 8]
01080afe 4889442438 mov qword ptr [rsp + 0x38], rax
01080b03 483d0000a000 cmp rax, 0xa00000
01080b09 0f87d30b0000 ja 0x1410816e2
01080b0f 448bc0 mov r8d, eax
01080b12 488d95d80e0000 lea rdx, [rbp + 0xed8]
01080b19 488bcf mov rcx, rdi
01080b1c e87f65ffff call 0x1410770a0
01080b21 8bd8 mov ebx, eax
01080b23 85c0 test eax, eax
01080b25 0f85bc0b0000 jne 0x1410816e7
01080b2b 488d8dd80e0000 lea rcx, [rbp + 0xed8]
01080b32 48034c2438 add rcx, qword ptr [rsp + 0x38]
01080b37 448b95d40e0000 mov r10d, dword ptr [rbp + 0xed4]
01080b3e 4183fd18 cmp r13d, 0x18
01080b42 731c jae 0x141080b60
01080b44 4885c9 test rcx, rcx
01080b47 7417 je 0x141080b60
01080b49 41b818000000 mov r8d, 0x18
01080b4f 452bc5 sub r8d, r13d
01080b52 33d2 xor edx, edx
01080b54 e847c17100 call 0x14179cca0
01080b59 448b95d40e0000 mov r10d, dword ptr [rbp + 0xed4]
01080b60 453bf5 cmp r14d, r13d
01080b63 7618 jbe 0x141080b7d
01080b65 452bf5 sub r14d, r13d
01080b68 418bd6 mov edx, r14d
01080b6b 488bcf mov rcx, rdi
01080b6e e8ad99feff call 0x14106a520
01080b73 8bd8 mov ebx, eax
01080b75 85c0 test eax, eax
01080b77 0f856a0b0000 jne 0x1410816e7
01080b7d 488b4590 mov rax, qword ptr [rbp - 0x70]
01080b81 4c8be8 mov r13, rax
01080b84 803800 cmp byte ptr [rax], 0
01080b87 0f8508010000 jne 0x141080c95
01080b8d 8b8dd00e0000 mov ecx, dword ptr [rbp + 0xed0]
01080b93 448bd9 mov r11d, ecx
01080b96 4181e30000ff00 and r11d, 0xff0000
01080b9d 8bc1 mov eax, ecx
01080b9f c1e810 shr eax, 0x10
01080ba2 440bd8 or r11d, eax
01080ba5 41c1eb08 shr r11d, 8
01080ba9 8bc1 mov eax, ecx
01080bab c1e010 shl eax, 0x10
01080bae 81e100ff0000 and ecx, 0xff00
01080bb4 0bc1 or eax, ecx
01080bb6 c1e008 shl eax, 8
01080bb9 440bd8 or r11d, eax
01080bbc 44899dd00e0000 mov dword ptr [rbp + 0xed0], r11d
01080bc3 418bca mov ecx, r10d
01080bc6 81e10000ff00 and ecx, 0xff0000
01080bcc 418bc2 mov eax, r10d
01080bcf c1e810 shr eax, 0x10
01080bd2 0bc8 or ecx, eax
01080bd4 c1e908 shr ecx, 8
01080bd7 418bc2 mov eax, r10d
01080bda c1e010 shl eax, 0x10
01080bdd 4181e200ff0000 and r10d, 0xff00
01080be4 410bc2 or eax, r10d
01080be7 c1e008 shl eax, 8
01080bea 448bd1 mov r10d, ecx
01080bed 440bd0 or r10d, eax
01080bf0 448995d40e0000 mov dword ptr [rbp + 0xed4], r10d
01080bf7 8b8dd80e0000 mov ecx, dword ptr [rbp + 0xed8]
01080bfd 448bc9 mov r9d, ecx
01080c00 4181e10000ff00 and r9d, 0xff0000
01080c07 8bc1 mov eax, ecx
01080c09 c1e810 shr eax, 0x10
01080c0c 440bc8 or r9d, eax
01080c0f 41c1e908 shr r9d, 8
01080c13 8bc1 mov eax, ecx
01080c15 c1e010 shl eax, 0x10
01080c18 81e100ff0000 and ecx, 0xff00
01080c1e 0bc1 or eax, ecx
01080c20 c1e008 shl eax, 8
01080c23 440bc8 or r9d, eax
01080c26 44898dd80e0000 mov dword ptr [rbp + 0xed8], r9d
01080c2d 8b8ddc0e0000 mov ecx, dword ptr [rbp + 0xedc]
01080c33 448bc1 mov r8d, ecx
01080c36 4181e00000ff00 and r8d, 0xff0000
01080c3d 8bc1 mov eax, ecx
01080c3f c1e810 shr eax, 0x10
01080c42 440bc0 or r8d, eax
01080c45 41c1e808 shr r8d, 8
01080c49 8bc1 mov eax, ecx
01080c4b c1e010 shl eax, 0x10
01080c4e 81e100ff0000 and ecx, 0xff00
01080c54 0bc1 or eax, ecx
01080c56 c1e008 shl eax, 8
01080c59 440bc0 or r8d, eax
01080c5c 448985dc0e0000 mov dword ptr [rbp + 0xedc], r8d
01080c63 8b8de00e0000 mov ecx, dword ptr [rbp + 0xee0]
01080c69 8bd1 mov edx, ecx
01080c6b 81e20000ff00 and edx, 0xff0000
01080c71 8bc1 mov eax, ecx
01080c73 c1e810 shr eax, 0x10
01080c76 0bd0 or edx, eax
01080c78 c1ea08 shr edx, 8
01080c7b 8bc1 mov eax, ecx
01080c7d c1e010 shl eax, 0x10
01080c80 81e100ff0000 and ecx, 0xff00
01080c86 0bc1 or eax, ecx
01080c88 c1e008 shl eax, 8
01080c8b 0bd0 or edx, eax
01080c8d 8995e00e0000 mov dword ptr [rbp + 0xee0], edx
01080c93 eb15 jmp 0x141080caa
01080c95 448b85dc0e0000 mov r8d, dword ptr [rbp + 0xedc]
01080c9c 448b8dd80e0000 mov r9d, dword ptr [rbp + 0xed8]
01080ca3 448b9dd00e0000 mov r11d, dword ptr [rbp + 0xed0]
01080caa 4181fb6d686f68 cmp r11d, 0x686f686d
01080cb1 0f852b0a0000 jne 0x1410816e2
01080cb7 4181e8c8000000 sub r8d, 0xc8
01080cbe 0f84d7000000 je 0x141080d9b
01080cc4 4183e801 sub r8d, 1
01080cc8 0f84c2000000 je 0x141080d90
01080cce 4183e801 sub r8d, 1
01080cd2 745f je 0x141080d33
01080cd4 4183f801 cmp r8d, 1
01080cd8 7459 je 0x141080d33
01080cda 452bca sub r9d, r10d
01080cdd 4963d1 movsxd rdx, r9d
01080ce0 4803977001e001 add rdx, qword ptr [rdi + 0x1e00170]
01080ce7 4889977001e001 mov qword ptr [rdi + 0x1e00170], rdx
01080cee 488b8f7801e001 mov rcx, qword ptr [rdi + 0x1e00178]
01080cf5 483bd1 cmp rdx, rcx
01080cf8 720c jb 0x141080d06
01080cfa 48038f8001e001 add rcx, qword ptr [rdi + 0x1e00180]
01080d01 483bd1 cmp rdx, rcx
01080d04 721a jb 0x141080d20
01080d06 33c0 xor eax, eax
01080d08 4889878001e001 mov qword ptr [rdi + 0x1e00180], rax
01080d0f 8bd8 mov ebx, eax
01080d11 448b742430 mov r14d, dword ptr [rsp + 0x30]
01080d16 488b442448 mov rax, qword ptr [rsp + 0x48]
01080d1b e9bb000000 jmp 0x141080ddb
01080d20 33c0 xor eax, eax
01080d22 8bd8 mov ebx, eax
01080d24 448b742430 mov r14d, dword ptr [rsp + 0x30]
01080d29 488b442448 mov rax, qword ptr [rsp + 0x48]
01080d2e e9a8000000 jmp 0x141080ddb
01080d33 452bca sub r9d, r10d
01080d36 4963d1 movsxd rdx, r9d
01080d39 4803977001e001 add rdx, qword ptr [rdi + 0x1e00170]
01080d40 4889977001e001 mov qword ptr [rdi + 0x1e00170], rdx
01080d47 488b8f7801e001 mov rcx, qword ptr [rdi + 0x1e00178]
01080d4e 483bd1 cmp rdx, rcx
01080d51 720c jb 0x141080d5f
01080d53 48038f8001e001 add rcx, qword ptr [rdi + 0x1e00180]
01080d5a 483bd1 cmp rdx, rcx
01080d5d 721c jb 0x141080d7b
01080d5f 33c0 xor eax, eax
01080d61 4889878001e001 mov qword ptr [rdi + 0x1e00180], rax
01080d68 8bd8 mov ebx, eax
01080d6a 448b742430 mov r14d, dword ptr [rsp + 0x30]
01080d6f 488b442448 mov rax, qword ptr [rsp + 0x48]
01080d74 4889442448 mov qword ptr [rsp + 0x48], rax
01080d79 eb60 jmp 0x141080ddb
01080d7b 33c0 xor eax, eax
01080d7d 8bd8 mov ebx, eax
01080d7f 448b742430 mov r14d, dword ptr [rsp + 0x30]
01080d84 488b442448 mov rax, qword ptr [rsp + 0x48]
01080d89 4889442448 mov qword ptr [rsp + 0x48], rax
01080d8e eb4b jmp 0x141080ddb
01080d90 33c0 xor eax, eax
01080d92 448bc8 mov r9d, eax
01080d95 488d466c lea rax, [rsi + 0x6c]
01080d99 eb09 jmp 0x141080da4
01080d9b 33c0 xor eax, eax
01080d9d 448bc8 mov r9d, eax
01080da0 488d4668 lea rax, [rsi + 0x68]
01080da4 4d8d8730010000 lea r8, [r15 + 0x130]
01080dab ba01000000 mov edx, 1
01080db0 488bcf mov rcx, rdi
01080db3 44894c2428 mov dword ptr [rsp + 0x28], r9d
01080db8 4889442420 mov qword ptr [rsp + 0x20], rax
01080dbd e80e66ffff call 0x1410773d0
01080dc2 8bd8 mov ebx, eax
01080dc4 448b742430 mov r14d, dword ptr [rsp + 0x30]
01080dc9 488b442448 mov rax, qword ptr [rsp + 0x48]
01080dce 4889442448 mov qword ptr [rsp + 0x48], rax
01080dd3 85db test ebx, ebx
01080dd5 0f850c090000 jne 0x1410816e7
01080ddb 8b4c2458 mov ecx, dword ptr [rsp + 0x58]
01080ddf ffc1 inc ecx
01080de1 894c2458 mov dword ptr [rsp + 0x58], ecx
01080de5 3b8dcc000000 cmp ecx, dword ptr [rbp + 0xcc]
01080deb 0f82affcffff jb 0x141080aa0
01080df1 f6464b01 test byte ptr [rsi + 0x4b], 1
01080df5 7408 je 0x141080dff
01080df7 488bce mov rcx, rsi
01080dfa e801f9e6ff call 0x140ef0700
01080dff 448b8dc4000000 mov r9d, dword ptr [rbp + 0xc4]
01080e06 eb08 jmp 0x141080e10
01080e08 41b401 mov r12b, 1
01080e0b 448b4c2430 mov r9d, dword ptr [rsp + 0x30]
01080e10 4533db xor r11d, r11d
01080e13 4584e4 test r12b, r12b
01080e16 743c je 0x141080e54
01080e18 8b85c8000000 mov eax, dword ptr [rbp + 0xc8]
01080e1e 412bc1 sub eax, r9d
01080e21 4863d0 movsxd rdx, eax
01080e24 4803977001e001 add rdx, qword ptr [rdi + 0x1e00170]
01080e2b 4889977001e001 mov qword ptr [rdi + 0x1e00170], rdx
01080e32 488b8f7801e001 mov rcx, qword ptr [rdi + 0x1e00178]
01080e39 483bd1 cmp rdx, rcx
01080e3c 720c jb 0x141080e4a
01080e3e 48038f8001e001 add rcx, qword ptr [rdi + 0x1e00180]
01080e45 483bd1 cmp rdx, rcx
01080e48 7207 jb 0x141080e51
01080e4a 4c899f8001e001 mov qword ptr [rdi + 0x1e00180], r11
01080e51 418bdb mov ebx, r11d
01080e54 448b64246c mov r12d, dword ptr [rsp + 0x6c]
01080e59 41ffc4 inc r12d
01080e5c 448964246c mov dword ptr [rsp + 0x6c], r12d
01080e61 443ba530010000 cmp r12d, dword ptr [rbp + 0x130]
01080e68 488b742448 mov rsi, qword ptr [rsp + 0x48]
01080e6d 0f825df1ffff jb 0x14107ffd0
01080e73 4d8db730010000 lea r14, [r15 + 0x130]
01080e7a 4d85f6 test r14, r14
01080e7d 744f je 0x141080ece
01080e7f 41813e63727473 cmp dword ptr [r14], 0x73747263
01080e86 7546 jne 0x141080ece
01080e88 498b7608 mov rsi, qword ptr [r14 + 8]
01080e8c 4885f6 test rsi, rsi
01080e8f 7439 je 0x141080eca
01080e91 817e08486d654d cmp dword ptr [rsi + 8], 0x4d656d48
01080e98 752c jne 0x141080ec6
01080e9a 488b0e mov rcx, qword ptr [rsi]
01080e9d 4885c9 test rcx, rcx
01080ea0 740c je 0x141080eae
01080ea2 ff15c0b48600 call qword ptr [rip + 0x86b4c0]
01080ea8 4533db xor r11d, r11d
01080eab 4c891e mov qword ptr [rsi], r11
01080eae 44895e08 mov dword ptr [rsi + 8], r11d
01080eb2 4c895e10 mov qword ptr [rsi + 0x10], r11
01080eb6 4c895e18 mov qword ptr [rsi + 0x18], r11
01080eba 488bce mov rcx, rsi
01080ebd ff15a5b48600 call qword ptr [rip + 0x86b4a5]
01080ec3 4533db xor r11d, r11d
01080ec6 4d895e08 mov qword ptr [r14 + 8], r11
01080eca 45895e28 mov dword ptr [r14 + 0x28], r11d
01080ece 807c243500 cmp byte ptr [rsp + 0x35], 0
01080ed3 0f8443010000 je 0x14108101c
01080ed9 498d8f30010000 lea rcx, [r15 + 0x130]
01080ee0 4c8d8540140000 lea r8, [rbp + 0x1440]
01080ee7 418b9778010000 mov edx, dword ptr [r15 + 0x178]
01080eee e87de5b7ff call 0x140bff470
01080ef3 440fb78540140000 movzx r8d, word ptr [rbp + 0x1440]
01080efb 4c8b0d5e808600 mov r9, qword ptr [rip + 0x86805e]
01080f02 4d8b09 mov r9, qword ptr [r9]
01080f05 488d9542140000 lea rdx, [rbp + 0x1442]
01080f0c 488b0d7d510201 mov rcx, qword ptr [rip + 0x102517d]
01080f13 ff1587818600 call qword ptr [rip + 0x868187]
01080f19 4c8bf0 mov r14, rax
01080f1c 488b0d85f00201 mov rcx, qword ptr [rip + 0x102f085]
01080f23 4885c9 test rcx, rcx
01080f26 741a je 0x141080f42
01080f28 4885c0 test rax, rax
01080f2b 7415 je 0x141080f42
01080f2d 4533c0 xor r8d, r8d
01080f30 488bd0 mov rdx, rax
01080f33 ff15e7808600 call qword ptr [rip + 0x8680e7]
01080f39 4885c0 test rax, rax
01080f3c 0f85d1000000 jne 0x141081013
01080f42 488b0d97ed0401 mov rcx, qword ptr [rip + 0x104ed97]
01080f49 4885c9 test rcx, rcx
01080f4c 742f je 0x141080f7d
01080f4e ba01007f00 mov edx, 0x7f0001
01080f53 ff15977e8600 call qword ptr [rip + 0x867e97]
01080f59 488bf0 mov rsi, rax
01080f5c 4885c0 test rax, rax
01080f5f 7417 je 0x141080f78
01080f61 488bc8 mov rcx, rax
01080f64 ff15567f8600 call qword ptr [rip + 0x867f56]
01080f6a 488bd8 mov rbx, rax
01080f6d ff150d808600 call qword ptr [rip + 0x86800d]
01080f73 483bd8 cmp rbx, rax
01080f76 7505 jne 0x141080f7d
01080f78 4885f6 test rsi, rsi
01080f7b 7507 jne 0x141080f84
01080f7d 488b3574cc0201 mov rsi, qword ptr [rip + 0x102cc74]
01080f84 4533e4 xor r12d, r12d
01080f87 410fb7c4 movzx eax, r12w
01080f8b 66898540140000 mov word ptr [rbp + 0x1440], ax
01080f92 4885f6 test rsi, rsi
01080f95 7453 je 0x141080fea
01080f97 4c896500 mov qword ptr [rbp], r12
01080f9b 488bce mov rcx, rsi
01080f9e ff15ec7f8600 call qword ptr [rip + 0x867fec]
01080fa4 488bd8 mov rbx, rax
01080fa7 48894508 mov qword ptr [rbp + 8], rax
01080fab 418bc4 mov eax, r12d
01080fae 4885db test rbx, rbx
01080fb1 7430 je 0x141080fe3
01080fb3 b8ff000000 mov eax, 0xff
01080fb8 483bd8 cmp rbx, rax
01080fbb 7e07 jle 0x141080fc4
01080fbd 48894508 mov qword ptr [rbp + 8], rax
01080fc1 0fb7d8 movzx ebx, ax
01080fc4 0f284500 movaps xmm0, xmmword ptr [rbp]
01080fc8 660f7f4590 movdqa xmmword ptr [rbp - 0x70], xmm0
01080fcd 4c8d8542140000 lea r8, [rbp + 0x1442]
01080fd4 488d5590 lea rdx, [rbp - 0x70]
01080fd8 488bce mov rcx, rsi
01080fdb e88011b1ff call 0x140b92160
01080fe0 0fb7c3 movzx eax, bx
01080fe3 66898540140000 mov word ptr [rbp + 0x1440], ax
01080fea 4d8d8f78010000 lea r9, [r15 + 0x178]
01080ff1 4d8d9f30010000 lea r11, [r15 + 0x130]
01080ff8 b9ff000000 mov ecx, 0xff
01080ffd 663bc1 cmp ax, cx
01081000 0f86b3000000 jbe 0x1410810b9
01081006 458921 mov dword ptr [r9], r12d
01081009 bbceffffff mov ebx, 0xffffffce
0108100e 4d85f6 test r14, r14
01081011 7409 je 0x14108101c
01081013 498bce mov rcx, r14
01081016 ff15047e8600 call qword ptr [rip + 0x867e04]
0108101c 807c243400 cmp byte ptr [rsp + 0x34], 0
01081021 0f84ed010000 je 0x141081214
01081027 4533c0 xor r8d, r8d
0108102a 488d5590 lea rdx, [rbp - 0x70]
0108102e 488d4d30 lea rcx, [rbp + 0x30]
01081032 e889b50400 call 0x1410cc5c0
01081037 4c8b65e8 mov r12, qword ptr [rbp - 0x18]
0108103b 4c8965a0 mov qword ptr [rbp - 0x60], r12
0108103f 488b442478 mov rax, qword ptr [rsp + 0x78]
01081044 488945a8 mov qword ptr [rbp - 0x58], rax
01081048 0fb64592 movzx eax, byte ptr [rbp - 0x6e]
0108104c 80bd2a03000000 cmp byte ptr [rbp + 0x32a], 0
01081053 b901000000 mov ecx, 1
01081058 0f45c1 cmovne eax, ecx
0108105b 884592 mov byte ptr [rbp - 0x6e], al
0108105e 488d5590 lea rdx, [rbp - 0x70]
01081062 498bcf mov rcx, r15
01081065 e8063de6ff call 0x140ee4d70
0108106a 488b442460 mov rax, qword ptr [rsp + 0x60]
0108106f f6801301000001 test byte ptr [rax + 0x113], 1
01081076 0f85d2000000 jne 0x14108114e
0108107c 41813f74736c70 cmp dword ptr [r15], 0x706c7374
01081083 752d jne 0x1410810b2
01081085 41f6872802000001 test byte ptr [r15 + 0x228], 1
0108108d 7423 je 0x1410810b2
0108108f 4180bf3202000000 cmp byte ptr [r15 + 0x232], 0
01081097 7419 je 0x1410810b2
01081099 498b8f40020000 mov rcx, qword ptr [r15 + 0x240]
010810a0 4885c9 test rcx, rcx
010810a3 740d je 0x1410810b2
010810a5 e8b651e6ff call 0x140ee6260
010810aa 84c0 test al, al
010810ac 0f859c000000 jne 0x14108114e
010810b2 32d2 xor dl, dl
010810b4 e997000000 jmp 0x141081150
010810b9 440fb7c0 movzx r8d, ax
010810bd 4503c0 add r8d, r8d
010810c0 4d85db test r11, r11
010810c3 0f8440ffffff je 0x141081009
010810c9 41813b63727473 cmp dword ptr [r11], 0x73747263
010810d0 0f8533ffffff jne 0x141081009
010810d6 45396328 cmp dword ptr [r11 + 0x28], r12d
010810da 0f8529ffffff jne 0x141081009
010810e0 496311 movsxd rdx, dword ptr [r9]
010810e3 4539633c cmp dword ptr [r11 + 0x3c], r12d
010810e7 0f851cffffff jne 0x141081009
010810ed 85d2 test edx, edx
010810ef 7447 je 0x141081138
010810f1 418b4304 mov eax, dword ptr [r11 + 4]
010810f5 83e001 and eax, 1
010810f8 85d2 test edx, edx
010810fa 0f8e09ffffff jle 0x141081009
01081100 413b532c cmp edx, dword ptr [r11 + 0x2c]
01081104 0f8ffffeffff jg 0x141081009
0108110a 84c0 test al, al
0108110c 740e je 0x14108111c
0108110e 498b4318 mov rax, qword ptr [r11 + 0x18]
01081112 488b00 mov rax, qword ptr [rax]
01081115 836c90fc01 sub dword ptr [rax + rdx*4 - 4], 1
0108111a 751c jne 0x141081138
0108111c 4c8bd2 mov r10, rdx
0108111f 498b4310 mov rax, qword ptr [r11 + 0x10]
01081123 488b10 mov rdx, qword ptr [rax]
01081126 428b44d2fc mov eax, dword ptr [rdx + r10*8 - 4]
0108112b 41014340 add dword ptr [r11 + 0x40], eax
0108112f 42c744d2f801000080 mov dword ptr [rdx + r10*8 - 8], 0x80000001
01081138 488d9542140000 lea rdx, [rbp + 0x1442]
0108113f 498bcb mov rcx, r11
01081142 e8a9d0b7ff call 0x140bfe1f0
01081147 8bd8 mov ebx, eax
01081149 e9c0feffff jmp 0x14108100e
0108114e b201 mov dl, 1
01081150 41813f74736c70 cmp dword ptr [r15], 0x706c7374
01081157 756b jne 0x1410811c4
01081159 410fb68f28020000 movzx ecx, byte ptr [r15 + 0x228]
01081161 f6c101 test cl, 1
01081164 745e je 0x1410811c4
01081166 0fb6c1 movzx eax, cl
01081169 c0e802 shr al, 2
0108116c 2401 and al, 1
0108116e 3ac2 cmp al, dl
01081170 7452 je 0x1410811c4
01081172 80e1fb and cl, 0xfb
01081175 0fb6c2 movzx eax, dl
01081178 c0e002 shl al, 2
0108117b 0ac8 or cl, al
0108117d 41888f28020000 mov byte ptr [r15 + 0x228], cl
01081184 80fa01 cmp dl, 1
01081187 753b jne 0x1410811c4
01081189 498b4708 mov rax, qword ptr [r15 + 8]
0108118d 4885c0 test rax, rax
01081190 7432 je 0x1410811c4
01081192 81b88000000074616474 cmp dword ptr [rax + 0x80], 0x74646174
0108119c 7526 jne 0x1410811c4
0108119e 0fb68812010000 movzx ecx, byte ptr [rax + 0x112]
010811a5 f6c110 test cl, 0x10
010811a8 751a jne 0x1410811c4
010811aa 80c910 or cl, 0x10
010811ad 888812010000 mov byte ptr [rax + 0x112], cl
010811b3 803d968bf60000 cmp byte ptr [rip + 0xf68b96], 0
010811ba 7408 je 0x1410811c4
010811bc 0f28c6 movaps xmm0, xmm6
010811bf e85c0ac3ff call 0x140cb1c20
010811c4 80bd2a03000000 cmp byte ptr [rbp + 0x32a], 0
010811cb 744b je 0x141081218
010811cd 41808f2802000002 or byte ptr [r15 + 0x228], 2
010811d5 41813f74736c70 cmp dword ptr [r15], 0x706c7374
010811dc 753a jne 0x141081218
010811de 498bb720040000 mov rsi, qword ptr [r15 + 0x420]
010811e5 4885f6 test rsi, rsi
010811e8 742e je 0x141081218
010811ea 660f1f440000 nop word ptr [rax + rax]
010811f0 4533c0 xor r8d, r8d
010811f3 488bd6 mov rdx, rsi
010811f6 498bcf mov rcx, r15
010811f9 e83222f3ff call 0x140fb3430
010811fe 817e0874657363 cmp dword ptr [rsi + 8], 0x63736574
01081205 7511 jne 0x141081218
01081207 488b06 mov rax, qword ptr [rsi]
0108120a 488bf0 mov rsi, rax
0108120d 4885c0 test rax, rax
01081210 75de jne 0x1410811f0
01081212 eb04 jmp 0x141081218
01081214 4c8b65e8 mov r12, qword ptr [rbp - 0x18]
01081218 4d85e4 test r12, r12
0108121b 0f84af000000 je 0x1410812d0
01081221 41813c2474734c53 cmp dword ptr [r12], 0x534c7374
01081229 0f85a1000000 jne 0x1410812d0
0108122f 418b442404 mov eax, dword ptr [r12 + 4]
01081234 85c0 test eax, eax
01081236 0f8494000000 je 0x1410812d0
0108123c 83e801 sub eax, 1
0108123f 4189442404 mov dword ptr [r12 + 4], eax
01081244 0f8586000000 jne 0x1410812d0
0108124a 498b742460 mov rsi, qword ptr [r12 + 0x60]
0108124f 4885f6 test rsi, rsi
01081252 743c je 0x141081290
01081254 33c0 xor eax, eax
01081256 448bf0 mov r14d, eax
01081259 4139442410 cmp dword ptr [r12 + 0x10], eax
0108125e 7620 jbe 0x141081280
01081260 4883c610 add rsi, 0x10
01081264 807ef800 cmp byte ptr [rsi - 8], 0
01081268 7408 je 0x141081272
0108126a 488b0e mov rcx, qword ptr [rsi]
0108126d e87ee5b6ff call 0x140bef7f0
01081272 4883c620 add rsi, 0x20
01081276 41ffc6 inc r14d
01081279 453b742410 cmp r14d, dword ptr [r12 + 0x10]
0108127e 72e4 jb 0x141081264
01081280 498b4c2460 mov rcx, qword ptr [r12 + 0x60]
01081285 4885c9 test rcx, rcx
01081288 7406 je 0x141081290
0108128a ff15d8b08600 call qword ptr [rip + 0x86b0d8]
01081290 498d4c2418 lea rcx, [r12 + 0x18]
01081295 e836cdb7ff call 0x140bfdfd0
0108129a 0f57c0 xorps xmm0, xmm0
0108129d 33c0 xor eax, eax
0108129f 410f110424 movups xmmword ptr [r12], xmm0
010812a4 410f11442410 movups xmmword ptr [r12 + 0x10], xmm0
010812aa 410f11442420 movups xmmword ptr [r12 + 0x20], xmm0
010812b0 410f11442430 movups xmmword ptr [r12 + 0x30], xmm0
010812b6 410f11442440 movups xmmword ptr [r12 + 0x40], xmm0
010812bc 410f11442450 movups xmmword ptr [r12 + 0x50], xmm0
010812c2 4989442460 mov qword ptr [r12 + 0x60], rax
010812c7 498bcc mov rcx, r12
010812ca ff1598b08600 call qword ptr [rip + 0x86b098]
010812d0 488b742478 mov rsi, qword ptr [rsp + 0x78]
010812d5 4885f6 test rsi, rsi
010812d8 742d je 0x141081307
010812da 813e54534c4f cmp dword ptr [rsi], 0x4f4c5354
010812e0 7525 jne 0x141081307
010812e2 8b4604 mov eax, dword ptr [rsi + 4]
010812e5 85c0 test eax, eax
010812e7 741e je 0x141081307
010812e9 83e801 sub eax, 1
010812ec 894604 mov dword ptr [rsi + 4], eax
010812ef 7516 jne 0x141081307
010812f1 488d4e08 lea rcx, [rsi + 8]
010812f5 e806d425ff call 0x1402de700
010812fa ba20000000 mov edx, 0x20
010812ff 488bce mov rcx, rsi
01081302 e81957b4ff call 0x140bc6a20
01081307 80bff202e00100 cmp byte ptr [rdi + 0x1e002f2], 0
0108130e 0f84a9010000 je 0x1410814bd
01081314 41813f74736c70 cmp dword ptr [r15], 0x706c7374
0108131b 0f8592010000 jne 0x1410814b3
01081321 498b4708 mov rax, qword ptr [r15 + 8]
01081325 4885c0 test rax, rax
01081328 0f841c010000 je 0x14108144a
0108132e 81b88000000074616474 cmp dword ptr [rax + 0x80], 0x74646174
01081338 0f850c010000 jne 0x14108144a
0108133e f6801001000001 test byte ptr [rax + 0x110], 1
01081345 0f84ff000000 je 0x14108144a
0108134b 41f687da01000010 test byte ptr [r15 + 0x1da], 0x10
01081353 0f84f1000000 je 0x14108144a
01081359 41f6878101000004 test byte ptr [r15 + 0x181], 4
01081361 0f85e3000000 jne 0x14108144a
01081367 498bd7 mov rdx, r15
0108136a 488d4d80 lea rcx, [rbp - 0x80]
0108136e e87d0ae7ff call 0x140ef1df0
01081373 488b4d88 mov rcx, qword ptr [rbp - 0x78]
01081377 488b5580 mov rdx, qword ptr [rbp - 0x80]
0108137b 4885d2 test rdx, rdx
0108137e 7406 je 0x141081386
01081380 48833a00 cmp qword ptr [rdx], 0
01081384 750b jne 0x141081391
01081386 4885c9 test rcx, rcx
01081389 7467 je 0x1410813f2
0108138b 48833900 cmp qword ptr [rcx], 0
0108138f 7461 je 0x1410813f2
01081391 49c7c6ffffffff mov r14, 0xffffffffffffffff
01081398 4885d2 test rdx, rdx
0108139b 7428 je 0x1410813c5
0108139d 418bc6 mov eax, r14d
010813a0 f00fc14208 lock xadd dword ptr [rdx + 8], eax
010813a5 83f801 cmp eax, 1
010813a8 750f jne 0x1410813b9
010813aa c74208003665c4 mov dword ptr [rdx + 8], 0xc4653600
010813b1 488bca mov rcx, rdx
010813b4 e81faa7100 call 0x14179bdd8
010813b9 33f6 xor esi, esi
010813bb 48897580 mov qword ptr [rbp - 0x80], rsi
010813bf 488b4d88 mov rcx, qword ptr [rbp - 0x78]
010813c3 eb02 jmp 0x1410813c7
010813c5 33f6 xor esi, esi
010813c7 4885c9 test rcx, rcx
010813ca 0f84fa000000 je 0x1410814ca
010813d0 418bc6 mov eax, r14d
010813d3 f00fc14108 lock xadd dword ptr [rcx + 8], eax
010813d8 83f801 cmp eax, 1
010813db 750c jne 0x1410813e9
010813dd c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
010813e4 e8efa97100 call 0x14179bdd8
010813e9 48897588 mov qword ptr [rbp - 0x78], rsi
010813ed e9d8000000 jmp 0x1410814ca
010813f2 49c7c6ffffffff mov r14, 0xffffffffffffffff
010813f9 4885d2 test rdx, rdx
010813fc 7428 je 0x141081426
010813fe 418bc6 mov eax, r14d
01081401 f00fc14208 lock xadd dword ptr [rdx + 8], eax
01081406 83f801 cmp eax, 1
01081409 750f jne 0x14108141a
0108140b c74208003665c4 mov dword ptr [rdx + 8], 0xc4653600
01081412 488bca mov rcx, rdx
01081415 e8bea97100 call 0x14179bdd8
0108141a 33f6 xor esi, esi
0108141c 48897580 mov qword ptr [rbp - 0x80], rsi
01081420 488b4d88 mov rcx, qword ptr [rbp - 0x78]
01081424 eb02 jmp 0x141081428
01081426 33f6 xor esi, esi
01081428 4885c9 test rcx, rcx
0108142b 741d je 0x14108144a
0108142d 418bc6 mov eax, r14d
01081430 f00fc14108 lock xadd dword ptr [rcx + 8], eax
01081435 83f801 cmp eax, 1
01081438 750c jne 0x141081446
0108143a c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
01081441 e892a97100 call 0x14179bdd8
01081446 48897588 mov qword ptr [rbp - 0x78], rsi
0108144a 41813f74736c70 cmp dword ptr [r15], 0x706c7374
01081451 7560 jne 0x1410814b3
01081453 498b4708 mov rax, qword ptr [r15 + 8]
01081457 4885c0 test rax, rax
0108145a 7428 je 0x141081484
0108145c 488b8828190000 mov rcx, qword ptr [rax + 0x1928]
01081463 4885c9 test rcx, rcx
01081466 741c je 0x141081484
01081468 498d9788010000 lea rdx, [r15 + 0x188]
0108146f 488b02 mov rax, qword ptr [rdx]
01081472 4883f8fd cmp rax, -3
01081476 740c je 0x141081484
01081478 770a ja 0x141081484
0108147a 4885c0 test rax, rax
0108147d 7405 je 0x141081484
0108147f e8fcfbe7ff call 0x140f01080
01081484 41c6878001000000 mov byte ptr [r15 + 0x180], 0
0108148c 41c6879801000000 mov byte ptr [r15 + 0x198], 0
01081494 33c0 xor eax, eax
01081496 4189879c010000 mov dword ptr [r15 + 0x19c], eax
0108149d 6641898782010000 mov word ptr [r15 + 0x182], ax
010814a5 49898788010000 mov qword ptr [r15 + 0x188], rax
010814ac 49898790010000 mov qword ptr [r15 + 0x190], rax
010814b3 33d2 xor edx, edx
010814b5 498bcf mov rcx, r15
010814b8 e8e304e7ff call 0x140ef19a0
010814bd 0fb6442444 movzx eax, byte ptr [rsp + 0x44]
010814c2 84c0 test al, al
010814c4 0f8458010000 je 0x141081622
010814ca 41813f74736c70 cmp dword ptr [r15], 0x706c7374
010814d1 0f8553010000 jne 0x14108162a
010814d7 498b4738 mov rax, qword ptr [r15 + 0x38]
010814db 4885c0 test rax, rax
010814de 7416 je 0x1410814f6
010814e0 4533c0 xor r8d, r8d
010814e3 33d2 xor edx, edx
010814e5 488bc8 mov rcx, rax
010814e8 e8e326e7ff call 0x140ef3bd0
010814ed 498b4738 mov rax, qword ptr [r15 + 0x38]
010814f1 4885c0 test rax, rax
010814f4 75ea jne 0x1410814e0
010814f6 498b7718 mov rsi, qword ptr [r15 + 0x18]
010814fa 4885f6 test rsi, rsi
010814fd 0f840d010000 je 0x141081610
01081503 f6862802000002 test byte ptr [rsi + 0x228], 2
0108150a 0f8400010000 je 0x141081610
01081510 41813f74736c70 cmp dword ptr [r15], 0x706c7374
01081517 0f85f3000000 jne 0x141081610
0108151d 813e74736c70 cmp dword ptr [rsi], 0x706c7374
01081523 0f85e7000000 jne 0x141081610
01081529 498b4750 mov rax, qword ptr [r15 + 0x50]
0108152d 33c9 xor ecx, ecx
0108152f 48894d98 mov qword ptr [rbp - 0x68], rcx
01081533 48894db0 mov qword ptr [rbp - 0x50], rcx
01081537 0f57c0 xorps xmm0, xmm0
0108153a 660f7f45c0 movdqa xmmword ptr [rbp - 0x40], xmm0
0108153f 894dd0 mov dword ptr [rbp - 0x30], ecx
01081542 48894590 mov qword ptr [rbp - 0x70], rax
01081546 488945a8 mov qword ptr [rbp - 0x58], rax
0108154a b801000000 mov eax, 1
0108154f 488945a0 mov qword ptr [rbp - 0x60], rax
01081553 488945b8 mov qword ptr [rbp - 0x48], rax
01081557 488d45e0 lea rax, [rbp - 0x20]
0108155b 4889442428 mov qword ptr [rsp + 0x28], rax
01081560 4c8d4d90 lea r9, [rbp - 0x70]
01081564 41b828000000 mov r8d, 0x28
0108156a 488b8e40020000 mov rcx, qword ptr [rsi + 0x240]
01081571 e89af3b6ff call 0x140bf0910
01081576 85c0 test eax, eax
01081578 0f8592000000 jne 0x141081610
0108157e 8b55e0 mov edx, dword ptr [rbp - 0x20]
01081581 488b8e40020000 mov rcx, qword ptr [rsi + 0x240]
01081588 e8c3e8b6ff call 0x140befe50
0108158d 488d9660020000 lea rdx, [rsi + 0x260]
01081594 488b8e40020000 mov rcx, qword ptr [rsi + 0x240]
0108159b e8109bf5ff call 0x140fdb0b0
010815a0 813e74736c70 cmp dword ptr [rsi], 0x706c7374
010815a6 7554 jne 0x1410815fc
010815a8 0fb68e28020000 movzx ecx, byte ptr [rsi + 0x228]
010815af 0fb6c1 movzx eax, cl
010815b2 2405 and al, 5
010815b4 3c01 cmp al, 1
010815b6 7544 jne 0x1410815fc
010815b8 80c904 or cl, 4
010815bb 888e28020000 mov byte ptr [rsi + 0x228], cl
010815c1 488b4608 mov rax, qword ptr [rsi + 8]
010815c5 4885c0 test rax, rax
010815c8 7432 je 0x1410815fc
010815ca 81b88000000074616474 cmp dword ptr [rax + 0x80], 0x74646174
010815d4 7526 jne 0x1410815fc
010815d6 0fb68812010000 movzx ecx, byte ptr [rax + 0x112]
010815dd f6c110 test cl, 0x10
010815e0 751a jne 0x1410815fc
010815e2 80c910 or cl, 0x10
010815e5 888812010000 mov byte ptr [rax + 0x112], cl
010815eb 803d5e87f60000 cmp byte ptr [rip + 0xf6875e], 0
010815f2 7408 je 0x1410815fc
010815f4 0f28c6 movaps xmm0, xmm6
010815f7 e82406c3ff call 0x140cb1c20
010815fc 488b7618 mov rsi, qword ptr [rsi + 0x18]
01081600 4885f6 test rsi, rsi
01081603 759b jne 0x1410815a0
01081605 b201 mov dl, 1
01081607 498b4f08 mov rcx, qword ptr [r15 + 8]
0108160b e81045e6ff call 0x140ee5b20
01081610 4533c0 xor r8d, r8d
01081613 ba65646c70 mov edx, 0x706c6465
01081618 498bcf mov rcx, r15
0108161b e8602fe7ff call 0x140ef4580
01081620 eb08 jmp 0x14108162a
01081622 498bcf mov rcx, r15
01081625 e85691e7ff call 0x140efa780
0108162a 41f687d801000008 test byte ptr [r15 + 0x1d8], 8
01081632 0f8480000000 je 0x1410816b8
01081638 66837f0c29 cmp word ptr [rdi + 0xc], 0x29
0108163d 0f8375000000 jae 0x1410816b8
01081643 488b0de6580201 mov rcx, qword ptr [rip + 0x10258e6]
0108164a 4885c9 test rcx, rcx
0108164d 7409 je 0x141081658
0108164f 4881c136020000 add rcx, 0x236
01081656 eb07 jmp 0x14108165f
01081658 488d0de1130301 lea rcx, [rip + 0x10313e1]
0108165f 0fbf81acf70000 movsx eax, word ptr [rcx + 0xf7ac]
01081666 660f6ec0 movd xmm0, eax
0108166a 0f5bc0 cvtdq2ps xmm0, xmm0
0108166d 0f2ec7 ucomiss xmm0, xmm7
01081670 7a46 jp 0x1410816b8
01081672 7544 jne 0x1410816b8
01081674 0fbf81aef70000 movsx eax, word ptr [rcx + 0xf7ae]
0108167b 660f6ec0 movd xmm0, eax
0108167f 0f5bc0 cvtdq2ps xmm0, xmm0
01081682 0f2ec7 ucomiss xmm0, xmm7
01081685 7a31 jp 0x1410816b8
01081687 752f jne 0x1410816b8
01081689 6683bdd202000000 cmp word ptr [rbp + 0x2d2], 0
01081691 7425 je 0x1410816b8
01081693 0fb785d0020000 movzx eax, word ptr [rbp + 0x2d0]
0108169a 668981acf70000 mov word ptr [rcx + 0xf7ac], ax
010816a1 0fb785d2020000 movzx eax, word ptr [rbp + 0x2d2]
010816a8 668981aef70000 mov word ptr [rcx + 0xf7ae], ax
010816af 66c781b0f70000ffff mov word ptr [rcx + 0xf7b0], 0xffff
010816b8 48ff879001e001 inc qword ptr [rdi + 0x1e00190]
010816bf 488bcf mov rcx, rdi
010816c2 e8795cffff call 0x141077340
010816c7 4533ff xor r15d, r15d
010816ca e991dbffff jmp 0x14107f260
010816cf b894ffffff mov eax, 0xffffff94
010816d4 eb13 jmp 0x1410816e9
010816d6 e8a5b8f3ff call 0x140fbcf80
010816db bb94ffffff mov ebx, 0xffffff94
010816e0 eb05 jmp 0x1410816e7
010816e2 bb30ffffff mov ebx, 0xffffff30
010816e7 8bc3 mov eax, ebx
010816e9 488b8d40160000 mov rcx, qword ptr [rbp + 0x1640]
010816f0 4833cc xor rcx, rsp
010816f3 e8e8a17100 call 0x14179b8e0
010816f8 4c8d9c2470170000 lea r11, [rsp + 0x1770]
01081700 498b5b38 mov rbx, qword ptr [r11 + 0x38]
01081704 498b7340 mov rsi, qword ptr [r11 + 0x40]
01081708 498b7b48 mov rdi, qword ptr [r11 + 0x48]
0108170c 410f2873f0 movaps xmm6, xmmword ptr [r11 - 0x10]
01081711 410f287be0 movaps xmm7, xmmword ptr [r11 - 0x20]
01081716 498be3 mov rsp, r11
01081719 415f pop r15
0108171b 415e pop r14
0108171d 415d pop r13
0108171f 415c pop r12
01081721 5d pop rbp
01081722 c3 ret 
01081723 90 nop 
01081724 2afb sub bh, bl