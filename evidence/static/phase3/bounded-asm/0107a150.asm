0107a150 4053 push rbx
0107a152 4155 push r13
0107a154 4881eca8020000 sub rsp, 0x2a8
0107a15b 488b05deaef500 mov rax, qword ptr [rip + 0xf5aede]
0107a162 4833c4 xor rax, rsp
0107a165 4889842470020000 mov qword ptr [rsp + 0x270], rax
0107a16d 0fb602 movzx eax, byte ptr [rdx]
0107a170 488bda mov rbx, rdx
0107a173 4c89bc2480020000 mov qword ptr [rsp + 0x280], r15
0107a17b 4c8be9 mov r13, rcx
0107a17e 4c8bb97002e001 mov r15, qword ptr [rcx + 0x1e00270]
0107a185 84c0 test al, al
0107a187 7510 jne 0x14107a199
0107a189 488b05a0cd0201 mov rax, qword ptr [rip + 0x102cda0]
0107a190 c6809841010001 mov byte ptr [rax + 0x14198], 1
0107a197 eb12 jmp 0x14107a1ab
0107a199 3c2c cmp al, 0x2c
0107a19b 730e jae 0x14107a1ab
0107a19d 488b058ccd0201 mov rax, qword ptr [rip + 0x102cd8c]
0107a1a4 c6809941010001 mov byte ptr [rax + 0x14199], 1
0107a1ab 488b057ecd0201 mov rax, qword ptr [rip + 0x102cd7e]
0107a1b2 0fb60a movzx ecx, byte ptr [rdx]
0107a1b5 4889b424a0020000 mov qword ptr [rsp + 0x2a0], rsi
0107a1bd 33f6 xor esi, esi
0107a1bf 4889bc2498020000 mov qword ptr [rsp + 0x298], rdi
0107a1c7 88889a410100 mov byte ptr [rax + 0x1419a], cl
0107a1cd 0fb602 movzx eax, byte ptr [rdx]
0107a1d0 4c89b42488020000 mov qword ptr [rsp + 0x288], r14
0107a1d8 4584c0 test r8b, r8b
0107a1db 0f845d010000 je 0x14107a33e
0107a1e1 3c18 cmp al, 0x18
0107a1e3 0f83d7000000 jae 0x14107a2c0
0107a1e9 0fbf82ba050000 movsx eax, word ptr [rdx + 0x5ba]
0107a1f0 ffc0 inc eax
0107a1f2 83f80b cmp eax, 0xb
0107a1f5 0f87ac000000 ja 0x14107a2a7
0107a1fb 488d15fe5df8fe lea rdx, [rip - 0x107a202]
0107a202 4898 cdqe 
0107a204 8b8c82a4ab0701 mov ecx, dword ptr [rdx + rax*4 + 0x107aba4]
0107a20b 4803ca add rcx, rdx
0107a20e ffe1 jmp rcx
0107a210 c783cc05000001000000 mov dword ptr [rbx + 0x5cc], 1
0107a21a c783aa05000006000000 mov dword ptr [rbx + 0x5aa], 6
0107a224 c683d005000001 mov byte ptr [rbx + 0x5d0], 1
0107a22b e9a1000000 jmp 0x14107a2d1
0107a230 c783cc05000002000000 mov dword ptr [rbx + 0x5cc], 2
0107a23a c783aa05000006000000 mov dword ptr [rbx + 0x5aa], 6
0107a244 c683d005000001 mov byte ptr [rbx + 0x5d0], 1
0107a24b e981000000 jmp 0x14107a2d1
0107a250 c783cc05000003000000 mov dword ptr [rbx + 0x5cc], 3
0107a25a c783aa05000006000000 mov dword ptr [rbx + 0x5aa], 6
0107a264 c683d005000001 mov byte ptr [rbx + 0x5d0], 1
0107a26b eb64 jmp 0x14107a2d1
0107a26d c783cc05000005000000 mov dword ptr [rbx + 0x5cc], 5
0107a277 c783aa05000006000000 mov dword ptr [rbx + 0x5aa], 6
0107a281 c683d005000001 mov byte ptr [rbx + 0x5d0], 1
0107a288 eb47 jmp 0x14107a2d1
0107a28a c783cc0500000a000000 mov dword ptr [rbx + 0x5cc], 0xa
0107a294 c783aa05000006000000 mov dword ptr [rbx + 0x5aa], 6
0107a29e c683d005000001 mov byte ptr [rbx + 0x5d0], 1
0107a2a5 eb2a jmp 0x14107a2d1
0107a2a7 89b3cc050000 mov dword ptr [rbx + 0x5cc], esi
0107a2ad c783aa05000006000000 mov dword ptr [rbx + 0x5aa], 6
0107a2b7 c683d005000001 mov byte ptr [rbx + 0x5d0], 1
0107a2be eb11 jmp 0x14107a2d1
0107a2c0 3c19 cmp al, 0x19
0107a2c2 7309 jae 0x14107a2cd
0107a2c4 c683d005000001 mov byte ptr [rbx + 0x5d0], 1
0107a2cb eb04 jmp 0x14107a2d1
0107a2cd 3c1c cmp al, 0x1c
0107a2cf 7324 jae 0x14107a2f5
0107a2d1 488b4342 mov rax, qword ptr [rbx + 0x42]
0107a2d5 4885c0 test rax, rax
0107a2d8 7405 je 0x14107a2df
0107a2da 483930 cmp qword ptr [rax], rsi
0107a2dd 7516 jne 0x14107a2f5
0107a2df 488b434a mov rax, qword ptr [rbx + 0x4a]
0107a2e3 4885c0 test rax, rax
0107a2e6 7405 je 0x14107a2ed
0107a2e8 483930 cmp qword ptr [rax], rsi
0107a2eb 7508 jne 0x14107a2f5
0107a2ed 41c685f202e00101 mov byte ptr [r13 + 0x1e002f2], 1
0107a2f5 803b2c cmp byte ptr [rbx], 0x2c
0107a2f8 7312 jae 0x14107a30c
0107a2fa 39b3cc050000 cmp dword ptr [rbx + 0x5cc], esi
0107a300 750a jne 0x14107a30c
0107a302 c783cc05000003000000 mov dword ptr [rbx + 0x5cc], 3
0107a30c 4138b5f202e001 cmp byte ptr [r13 + 0x1e002f2], sil
0107a313 0f84a2070000 je 0x14107aabb
0107a319 488d4b42 lea rcx, [rbx + 0x42]
0107a31d c6433802 mov byte ptr [rbx + 0x38], 2
0107a321 4889733a mov qword ptr [rbx + 0x3a], rsi
0107a325 e8b6c6a5ff call 0x140ad69e0
0107a32a 48897352 mov qword ptr [rbx + 0x52], rsi
0107a32e 4889735a mov qword ptr [rbx + 0x5a], rsi
0107a332 66897362 mov word ptr [rbx + 0x62], si
0107a336 897366 mov dword ptr [rbx + 0x66], esi
0107a339 e97d070000 jmp 0x14107aabb
0107a33e 4c89a42490020000 mov qword ptr [rsp + 0x290], r12
0107a346 4c8d25f3860301 lea r12, [rip + 0x10386f3]
0107a34d 41be01000000 mov r14d, 1
0107a353 3c0c cmp al, 0xc
0107a355 0f83e1020000 jae 0x14107a63c
0107a35b 488b05cecb0201 mov rax, qword ptr [rip + 0x102cbce]
0107a362 4889ac24d0020000 mov qword ptr [rsp + 0x2d0], rbp
0107a36a 4885c0 test rax, rax
0107a36d 7410 je 0x14107a37f
0107a36f 488d8836020000 lea rcx, [rax + 0x236]
0107a376 488db8ba1e0100 lea rdi, [rax + 0x11eba]
0107a37d eb0a jmp 0x14107a389
0107a37f 498bcc mov rcx, r12
0107a382 488d3d37a30401 lea rdi, [rip + 0x104a337]
0107a389 0fb681dbf20000 movzx eax, byte ptr [rcx + 0xf2db]
0107a390 0f57c0 xorps xmm0, xmm0
0107a393 888282050000 mov byte ptr [rdx + 0x582], al
0107a399 bdff010000 mov ebp, 0x1ff
0107a39e 0fb6810bf70000 movzx eax, byte ptr [rcx + 0xf70b]
0107a3a5 88828b050000 mov byte ptr [rdx + 0x58b], al
0107a3ab 0fb64172 movzx eax, byte ptr [rcx + 0x72]
0107a3af 88828e050000 mov byte ptr [rdx + 0x58e], al
0107a3b5 0fb681d9530000 movzx eax, byte ptr [rcx + 0x53d9]
0107a3bc 88828d050000 mov byte ptr [rdx + 0x58d], al
0107a3c2 0fb681b9090000 movzx eax, byte ptr [rcx + 0x9b9]
0107a3c9 88829a000000 mov byte ptr [rdx + 0x9a], al
0107a3cf 0fb681bd090000 movzx eax, byte ptr [rcx + 0x9bd]
0107a3d6 88829b000000 mov byte ptr [rdx + 0x9b], al
0107a3dc 0fb681ec560000 movzx eax, byte ptr [rcx + 0x56ec]
0107a3e3 888288050000 mov byte ptr [rdx + 0x588], al
0107a3e9 0fb681ed560000 movzx eax, byte ptr [rcx + 0x56ed]
0107a3f0 888289050000 mov byte ptr [rdx + 0x589], al
0107a3f6 0fb681ee560000 movzx eax, byte ptr [rcx + 0x56ee]
0107a3fd 88828a050000 mov byte ptr [rdx + 0x58a], al
0107a403 0fb687f0140000 movzx eax, byte ptr [rdi + 0x14f0]
0107a40a 884277 mov byte ptr [rdx + 0x77], al
0107a40d 0fb687f2140000 movzx eax, byte ptr [rdi + 0x14f2]
0107a414 884278 mov byte ptr [rdx + 0x78], al
0107a417 0fb687f3140000 movzx eax, byte ptr [rdi + 0x14f3]
0107a41e 884279 mov byte ptr [rdx + 0x79], al
0107a421 488d97f4160000 lea rdx, [rdi + 0x16f4]
0107a428 f30f7f442438 movdqu xmmword ptr [rsp + 0x38], xmm0
0107a42e 4885d2 test rdx, rdx
0107a431 7420 je 0x14107a453
0107a433 440fb702 movzx r8d, word ptr [rdx]
0107a437 4c3bc5 cmp r8, rbp
0107a43a 440f47c5 cmova r8d, ebp
0107a43e 4883c202 add rdx, 2
0107a442 740f je 0x14107a453
0107a444 4d85c0 test r8, r8
0107a447 740a je 0x14107a453
0107a449 488d4c2438 lea rcx, [rsp + 0x38]
0107a44e e82dd0a5ff call 0x140ad7480
0107a453 488d4b7a lea rcx, [rbx + 0x7a]
0107a457 488d542438 lea rdx, [rsp + 0x38]
0107a45c e8cfc1a5ff call 0x140ad6630
0107a461 488b4c2438 mov rcx, qword ptr [rsp + 0x38]
0107a466 4885c9 test rcx, rcx
0107a469 741b je 0x14107a486
0107a46b b8ffffffff mov eax, 0xffffffff
0107a470 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0107a475 413bc6 cmp eax, r14d
0107a478 750c jne 0x14107a486
0107a47a c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0107a481 e852197200 call 0x14179bdd8
0107a486 488b4c2440 mov rcx, qword ptr [rsp + 0x40]
0107a48b 4885c9 test rcx, rcx
0107a48e 741b je 0x14107a4ab
0107a490 b8ffffffff mov eax, 0xffffffff
0107a495 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0107a49a 413bc6 cmp eax, r14d
0107a49d 750c jne 0x14107a4ab
0107a49f c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0107a4a6 e82d197200 call 0x14179bdd8
0107a4ab 0f57c0 xorps xmm0, xmm0
0107a4ae f30f7f442438 movdqu xmmword ptr [rsp + 0x38], xmm0
0107a4b4 4881c7f4140000 add rdi, 0x14f4
0107a4bb 7423 je 0x14107a4e0
0107a4bd 440fb707 movzx r8d, word ptr [rdi]
0107a4c1 488d5702 lea rdx, [rdi + 2]
0107a4c5 4c3bc5 cmp r8, rbp
0107a4c8 4c0f47c5 cmova r8, rbp
0107a4cc 4885d2 test rdx, rdx
0107a4cf 740f je 0x14107a4e0
0107a4d1 4d85c0 test r8, r8
0107a4d4 740a je 0x14107a4e0
0107a4d6 488d4c2438 lea rcx, [rsp + 0x38]
0107a4db e8a0cfa5ff call 0x140ad7480
0107a4e0 488d8b8a000000 lea rcx, [rbx + 0x8a]
0107a4e7 488d542438 lea rdx, [rsp + 0x38]
0107a4ec e83fc1a5ff call 0x140ad6630
0107a4f1 488b4c2438 mov rcx, qword ptr [rsp + 0x38]
0107a4f6 4885c9 test rcx, rcx
0107a4f9 741b je 0x14107a516
0107a4fb b8ffffffff mov eax, 0xffffffff
0107a500 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0107a505 413bc6 cmp eax, r14d
0107a508 750c jne 0x14107a516
0107a50a c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0107a511 e8c2187200 call 0x14179bdd8
0107a516 488b4c2440 mov rcx, qword ptr [rsp + 0x40]
0107a51b 4885c9 test rcx, rcx
0107a51e 741b je 0x14107a53b
0107a520 b8ffffffff mov eax, 0xffffffff
0107a525 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0107a52a 413bc6 cmp eax, r14d
0107a52d 750c jne 0x14107a53b
0107a52f c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0107a536 e89d187200 call 0x14179bdd8
0107a53b 488b05eec90201 mov rax, qword ptr [rip + 0x102c9ee]
0107a542 4885c0 test rax, rax
0107a545 7408 je 0x14107a54f
0107a547 480536020000 add rax, 0x236
0107a54d eb03 jmp 0x14107a552
0107a54f 498bc4 mov rax, r12
0107a552 480fbf480e movsx rcx, word ptr [rax + 0xe]
0107a557 6685c9 test cx, cx
0107a55a 0f849f000000 je 0x14107a5ff
0107a560 4c8bc1 mov r8, rcx
0107a563 4889742438 mov qword ptr [rsp + 0x38], rsi
0107a568 488d442438 lea rax, [rsp + 0x38]
0107a56d ba41544144 mov edx, 0x44415441
0107a572 488d0db7a60201 lea rcx, [rip + 0x102a6b7]
0107a579 4889442420 mov qword ptr [rsp + 0x20], rax
0107a57e 4c8d0df3cdad00 lea r9, [rip + 0xadcdf3]
0107a585 e876aca8ff call 0x140b05200
0107a58a 488b7c2438 mov rdi, qword ptr [rsp + 0x38]
0107a58f 4885ff test rdi, rdi
0107a592 746b je 0x14107a5ff
0107a594 817f08486d654d cmp dword ptr [rdi + 8], 0x4d656d48
0107a59b 7407 je 0x14107a5a4
0107a59d 8bd6 mov edx, esi
0107a59f 488bce mov rcx, rsi
0107a5a2 eb06 jmp 0x14107a5aa
0107a5a4 488b0f mov rcx, qword ptr [rdi]
0107a5a7 8b5710 mov edx, dword ptr [rdi + 0x10]
0107a5aa 4c8d442450 lea r8, [rsp + 0x50]
0107a5af e83cf2e5ff call 0x140ed97f0
0107a5b4 817f08486d654d cmp dword ptr [rdi + 8], 0x4d656d48
0107a5bb 8be8 mov ebp, eax
0107a5bd 7525 jne 0x14107a5e4
0107a5bf 488b0f mov rcx, qword ptr [rdi]
0107a5c2 4885c9 test rcx, rcx
0107a5c5 7409 je 0x14107a5d0
0107a5c7 ff159b1d8700 call qword ptr [rip + 0x871d9b]
0107a5cd 488937 mov qword ptr [rdi], rsi
0107a5d0 488bcf mov rcx, rdi
0107a5d3 897708 mov dword ptr [rdi + 8], esi
0107a5d6 48897710 mov qword ptr [rdi + 0x10], rsi
0107a5da 48897718 mov qword ptr [rdi + 0x18], rsi
0107a5de ff15841d8700 call qword ptr [rip + 0x871d84]
0107a5e4 85ed test ebp, ebp
0107a5e6 7517 jne 0x14107a5ff
0107a5e8 4c8bc3 mov r8, rbx
0107a5eb 488d542450 lea rdx, [rsp + 0x50]
0107a5f0 498bcf mov rcx, r15
0107a5f3 e808f4e5ff call 0x140ed9a00
0107a5f8 4588b5f002e001 mov byte ptr [r13 + 0x1e002f0], r14b
0107a5ff ba05000000 mov edx, 5
0107a604 4533c0 xor r8d, r8d
0107a607 498bcf mov rcx, r15
0107a60a e8b1c6e7ff call 0x140ef6cc0
0107a60f 488bac24d0020000 mov rbp, qword ptr [rsp + 0x2d0]
0107a617 4885c0 test rax, rax
0107a61a 7410 je 0x14107a62c
0107a61c 488b4070 mov rax, qword ptr [rax + 0x70]
0107a620 4885c0 test rax, rax
0107a623 7407 je 0x14107a62c
0107a625 397064 cmp dword ptr [rax + 0x64], esi
0107a628 8bc6 mov eax, esi
0107a62a 7503 jne 0x14107a62f
0107a62c 418bc6 mov eax, r14d
0107a62f 85c0 test eax, eax
0107a631 0f95c0 setne al
0107a634 fec0 inc al
0107a636 888385050000 mov byte ptr [rbx + 0x585], al
0107a63c 0fb603 movzx eax, byte ptr [rbx]
0107a63f 3c0f cmp al, 0xf
0107a641 7310 jae 0x14107a653
0107a643 40387338 cmp byte ptr [rbx + 0x38], sil
0107a647 740e je 0x14107a657
0107a649 c643380f mov byte ptr [rbx + 0x38], 0xf
0107a64d 44887376 mov byte ptr [rbx + 0x76], r14b
0107a651 eb12 jmp 0x14107a665
0107a653 3c14 cmp al, 0x14
0107a655 7306 jae 0x14107a65d
0107a657 44887376 mov byte ptr [rbx + 0x76], r14b
0107a65b eb08 jmp 0x14107a665
0107a65d 3c16 cmp al, 0x16
0107a65f 0f8393000000 jae 0x14107a6f8
0107a665 488b0dc4c80201 mov rcx, qword ptr [rip + 0x102c8c4]
0107a66c 488d815a410100 lea rax, [rcx + 0x1415a]
0107a673 4885c9 test rcx, rcx
0107a676 7507 jne 0x14107a67f
0107a678 488d05e1c20401 lea rax, [rip + 0x104c2e1]
0107a67f 40387004 cmp byte ptr [rax + 4], sil
0107a683 7517 jne 0x14107a69c
0107a685 83bbb40500000a cmp dword ptr [rbx + 0x5b4], 0xa
0107a68c 7d0e jge 0x14107a69c
0107a68e c6838705000002 mov byte ptr [rbx + 0x587], 2
0107a695 488b0d94c80201 mov rcx, qword ptr [rip + 0x102c894]
0107a69c 4885c9 test rcx, rcx
0107a69f 7409 je 0x14107a6aa
0107a6a1 4881c136020000 add rcx, 0x236
0107a6a8 eb03 jmp 0x14107a6ad
0107a6aa 498bcc mov rcx, r12
0107a6ad 0fb681e0300000 movzx eax, byte ptr [rcx + 0x30e0]
0107a6b4 8883b8050000 mov byte ptr [rbx + 0x5b8], al
0107a6ba 0fb781e2300000 movzx eax, word ptr [rcx + 0x30e2]
0107a6c1 668983ba050000 mov word ptr [rbx + 0x5ba], ax
0107a6c8 8b81dc300000 mov eax, dword ptr [rcx + 0x30dc]
0107a6ce 8983bc050000 mov dword ptr [rbx + 0x5bc], eax
0107a6d4 8b81e4300000 mov eax, dword ptr [rcx + 0x30e4]
0107a6da 8983c0050000 mov dword ptr [rbx + 0x5c0], eax
0107a6e0 8b81e8300000 mov eax, dword ptr [rcx + 0x30e8]
0107a6e6 8983c4050000 mov dword ptr [rbx + 0x5c4], eax
0107a6ec 8b81ec300000 mov eax, dword ptr [rcx + 0x30ec]
0107a6f2 8983c8050000 mov dword ptr [rbx + 0x5c8], eax
0107a6f8 0fb60b movzx ecx, byte ptr [rbx]
0107a6fb 80f917 cmp cl, 0x17
0107a6fe 7324 jae 0x14107a724
0107a700 48c783dc050000ffffffff mov qword ptr [rbx + 0x5dc], 0xffffffffffffffff
0107a70b 41387552 cmp byte ptr [r13 + 0x52], sil
0107a70f 7518 jne 0x14107a729
0107a711 488b83d2050000 mov rax, qword ptr [rbx + 0x5d2]
0107a718 480fc8 bswap rax
0107a71b 488983d2050000 mov qword ptr [rbx + 0x5d2], rax
0107a722 eb05 jmp 0x14107a729
0107a724 80f919 cmp cl, 0x19
0107a727 7312 jae 0x14107a73b
0107a729 4438b3b0050000 cmp byte ptr [rbx + 0x5b0], r14b
0107a730 7609 jbe 0x14107a73b
0107a732 4488b3b0050000 mov byte ptr [rbx + 0x5b0], r14b
0107a739 eb05 jmp 0x14107a740
0107a73b 80f91a cmp cl, 0x1a
0107a73e 7319 jae 0x14107a759
0107a740 4438b38e050000 cmp byte ptr [rbx + 0x58e], r14b
0107a747 7507 jne 0x14107a750
0107a749 c6838e05000003 mov byte ptr [rbx + 0x58e], 3
0107a750 c6838f05000002 mov byte ptr [rbx + 0x58f], 2
0107a757 eb09 jmp 0x14107a762
0107a759 80f91c cmp cl, 0x1c
0107a75c 0f83b4010000 jae 0x14107a916
0107a762 4038b390050000 cmp byte ptr [rbx + 0x590], sil
0107a769 0f854a010000 jne 0x14107a8b9
0107a76f c6839005000002 mov byte ptr [rbx + 0x590], 2
0107a776 4d85ff test r15, r15
0107a779 0f8433010000 je 0x14107a8b2
0107a77f 4181bf8000000074616474 cmp dword ptr [r15 + 0x80], 0x74646174
0107a78a 0f8522010000 jne 0x14107a8b2
0107a790 498b8fc8000000 mov rcx, qword ptr [r15 + 0xc8]
0107a797 4885c9 test rcx, rcx
0107a79a 0f8412010000 je 0x14107a8b2
0107a7a0 488b5110 mov rdx, qword ptr [rcx + 0x10]
0107a7a4 4885d2 test rdx, rdx
0107a7a7 7440 je 0x14107a7e9
0107a7a9 f6821401000008 test byte ptr [rdx + 0x114], 8
0107a7b0 7437 je 0x14107a7e9
0107a7b2 80b90501000020 cmp byte ptr [rcx + 0x105], 0x20
0107a7b9 0f82ab000000 jb 0x14107a86a
0107a7bf 0fb68104010000 movzx eax, byte ptr [rcx + 0x104]
0107a7c6 84c0 test al, al
0107a7c8 0f85dd000000 jne 0x14107a8ab
0107a7ce 48397110 cmp qword ptr [rcx + 0x10], rsi
0107a7d2 0f84da000000 je 0x14107a8b2
0107a7d8 488b4118 mov rax, qword ptr [rcx + 0x18]
0107a7dc 488bc8 mov rcx, rax
0107a7df 4885c0 test rax, rax
0107a7e2 75bc jne 0x14107a7a0
0107a7e4 e9c9000000 jmp 0x14107a8b2
0107a7e9 0fb69105010000 movzx edx, byte ptr [rcx + 0x105]
0107a7f0 84d2 test dl, dl
0107a7f2 7571 jne 0x14107a865
0107a7f4 4038b104010000 cmp byte ptr [rcx + 0x104], sil
0107a7fb 7568 jne 0x14107a865
0107a7fd 488b4110 mov rax, qword ptr [rcx + 0x10]
0107a801 4885c0 test rax, rax
0107a804 74c8 je 0x14107a7ce
0107a806 f6801401000008 test byte ptr [rax + 0x114], 8
0107a80d 7405 je 0x14107a814
0107a80f 80fa20 cmp dl, 0x20
0107a812 73ab jae 0x14107a7bf
0107a814 4885c0 test rax, rax
0107a817 74b5 je 0x14107a7ce
0107a819 0fb68014010000 movzx eax, byte ptr [rax + 0x114]
0107a820 f6d0 not al
0107a822 4184c6 test r14b, al
0107a825 74b1 je 0x14107a7d8
0107a827 488b5128 mov rdx, qword ptr [rcx + 0x28]
0107a82b 4885d2 test rdx, rdx
0107a82e 7435 je 0x14107a865
0107a830 817a0869626c61 cmp dword ptr [rdx + 8], 0x616c6269
0107a837 752c jne 0x14107a865
0107a839 488b4230 mov rax, qword ptr [rdx + 0x30]
0107a83d 4885c0 test rax, rax
0107a840 7423 je 0x14107a865
0107a842 0fb68014010000 movzx eax, byte ptr [rax + 0x114]
0107a849 f6d0 not al
0107a84b 4184c6 test r14b, al
0107a84e 7454 je 0x14107a8a4
0107a850 0fb64272 movzx eax, byte ptr [rdx + 0x72]
0107a854 84c0 test al, al
0107a856 744c je 0x14107a8a4
0107a858 3c20 cmp al, 0x20
0107a85a 7348 jae 0x14107a8a4
0107a85c 0fb64271 movzx eax, byte ptr [rdx + 0x71]
0107a860 e961ffffff jmp 0x14107a7c6
0107a865 4885c9 test rcx, rcx
0107a868 7420 je 0x14107a88a
0107a86a 488b4110 mov rax, qword ptr [rcx + 0x10]
0107a86e 4885c0 test rax, rax
0107a871 7417 je 0x14107a88a
0107a873 f6801401000008 test byte ptr [rax + 0x114], 8
0107a87a 740e je 0x14107a88a
0107a87c 80b90501000020 cmp byte ptr [rcx + 0x105], 0x20
0107a883 731f jae 0x14107a8a4
0107a885 e935ffffff jmp 0x14107a7bf
0107a88a 4038b105010000 cmp byte ptr [rcx + 0x105], sil
0107a891 0f8528ffffff jne 0x14107a7bf
0107a897 4038b104010000 cmp byte ptr [rcx + 0x104], sil
0107a89e 0f851bffffff jne 0x14107a7bf
0107a8a4 32c0 xor al, al
0107a8a6 e91bffffff jmp 0x14107a7c6
0107a8ab c6839005000003 mov byte ptr [rbx + 0x590], 3
0107a8b2 4488b3eb050000 mov byte ptr [rbx + 0x5eb], r14b
0107a8b9 488b4342 mov rax, qword ptr [rbx + 0x42]
0107a8bd 4885c0 test rax, rax
0107a8c0 7405 je 0x14107a8c7
0107a8c2 483930 cmp qword ptr [rax], rsi
0107a8c5 750e jne 0x14107a8d5
0107a8c7 488b434a mov rax, qword ptr [rbx + 0x4a]
0107a8cb 4885c0 test rax, rax
0107a8ce 740c je 0x14107a8dc
0107a8d0 483930 cmp qword ptr [rax], rsi
0107a8d3 7407 je 0x14107a8dc
0107a8d5 b90e000000 mov ecx, 0xe
0107a8da eb05 jmp 0x14107a8e1
0107a8dc b90f000000 mov ecx, 0xf
0107a8e1 40387376 cmp byte ptr [rbx + 0x76], sil
0107a8e5 740f je 0x14107a8f6
0107a8e7 8b4334 mov eax, dword ptr [rbx + 0x34]
0107a8ea 23c1 and eax, ecx
0107a8ec 3bc1 cmp eax, ecx
0107a8ee 7526 jne 0x14107a916
0107a8f0 40887376 mov byte ptr [rbx + 0x76], sil
0107a8f4 eb20 jmp 0x14107a916
0107a8f6 488b0533c60201 mov rax, qword ptr [rip + 0x102c633]
0107a8fd 4885c0 test rax, rax
0107a900 7407 je 0x14107a909
0107a902 4c8da036020000 lea r12, [rax + 0x236]
0107a909 4538b424a0f70000 cmp byte ptr [r12 + 0xf7a0], r14b
0107a911 750a jne 0x14107a91d
0107a913 894b34 mov dword ptr [rbx + 0x34], ecx
0107a916 488b0513c60201 mov rax, qword ptr [rip + 0x102c613]
0107a91d 803b1e cmp byte ptr [rbx], 0x1e
0107a920 4c8ba42490020000 mov r12, qword ptr [rsp + 0x290]
0107a928 7330 jae 0x14107a95a
0107a92a 4885c0 test rax, rax
0107a92d 742b je 0x14107a95a
0107a92f 488b9090410100 mov rdx, qword ptr [rax + 0x14190]
0107a936 4885d2 test rdx, rdx
0107a939 741f je 0x14107a95a
0107a93b 8b4a34 mov ecx, dword ptr [rdx + 0x34]
0107a93e f6c10f test cl, 0xf
0107a941 7417 je 0x14107a95a
0107a943 83e1f0 and ecx, 0xfffffff0
0107a946 894a34 mov dword ptr [rdx + 0x34], ecx
0107a949 e8823053ff call 0x1405ad9d0
0107a94e e89dc458ff call 0x140606df0
0107a953 488b05d6c50201 mov rax, qword ptr [rip + 0x102c5d6]
0107a95a 803b1f cmp byte ptr [rbx], 0x1f
0107a95d 7339 jae 0x14107a998
0107a95f 4885c0 test rax, rax
0107a962 7434 je 0x14107a998
0107a964 488bb890410100 mov rdi, qword ptr [rax + 0x14190]
0107a96b 4885ff test rdi, rdi
0107a96e 7428 je 0x14107a998
0107a970 410fb6ce movzx ecx, r14b
0107a974 e847d658ff call 0x140607fc0
0107a979 0fb6c8 movzx ecx, al
0107a97c 8b4734 mov eax, dword ptr [rdi + 0x34]
0107a97f 4133ce xor ecx, r14d
0107a982 83c10e add ecx, 0xe
0107a985 23c1 and eax, ecx
0107a987 3bc1 cmp eax, ecx
0107a989 740d je 0x14107a998
0107a98b e860c358ff call 0x140606cf0
0107a990 84c0 test al, al
0107a992 7404 je 0x14107a998
0107a994 44887376 mov byte ptr [rbx + 0x76], r14b
0107a998 803b21 cmp byte ptr [rbx], 0x21
0107a99b 7372 jae 0x14107aa0f
0107a99d ba05000000 mov edx, 5
0107a9a2 66c783830500000101 mov word ptr [rbx + 0x583], 0x101
0107a9ab 4533c0 xor r8d, r8d
0107a9ae 498bcf mov rcx, r15
0107a9b1 e80ac3e7ff call 0x140ef6cc0
0107a9b6 4885c0 test rax, rax
0107a9b9 7410 je 0x14107a9cb
0107a9bb 488b4070 mov rax, qword ptr [rax + 0x70]
0107a9bf 4885c0 test rax, rax
0107a9c2 7407 je 0x14107a9cb
0107a9c4 397064 cmp dword ptr [rax + 0x64], esi
0107a9c7 8bc6 mov eax, esi
0107a9c9 7503 jne 0x14107a9ce
0107a9cb 418bc6 mov eax, r14d
0107a9ce 85c0 test eax, eax
0107a9d0 ba0a000000 mov edx, 0xa
0107a9d5 498bcf mov rcx, r15
0107a9d8 0f95c0 setne al
0107a9db 4533c0 xor r8d, r8d
0107a9de fec0 inc al
0107a9e0 888385050000 mov byte ptr [rbx + 0x585], al
0107a9e6 e8d5c2e7ff call 0x140ef6cc0
0107a9eb 4885c0 test rax, rax
0107a9ee 7411 je 0x14107aa01
0107a9f0 488b4070 mov rax, qword ptr [rax + 0x70]
0107a9f4 4885c0 test rax, rax
0107a9f7 7408 je 0x14107aa01
0107a9f9 397064 cmp dword ptr [rax + 0x64], esi
0107a9fc 7403 je 0x14107aa01
0107a9fe 448bf6 mov r14d, esi
0107aa01 4585f6 test r14d, r14d
0107aa04 0f95c0 setne al
0107aa07 fec0 inc al
0107aa09 888386050000 mov byte ptr [rbx + 0x586], al
0107aa0f 0fb603 movzx eax, byte ptr [rbx]
0107aa12 3c23 cmp al, 0x23
0107aa14 731f jae 0x14107aa35
0107aa16 80bb9005000001 cmp byte ptr [rbx + 0x590], 1
0107aa1d c6838c05000001 mov byte ptr [rbx + 0x58c], 1
0107aa24 7513 jne 0x14107aa39
0107aa26 c6839005000003 mov byte ptr [rbx + 0x590], 3
0107aa2d 89b3f2050000 mov dword ptr [rbx + 0x5f2], esi
0107aa33 eb10 jmp 0x14107aa45
0107aa35 3c25 cmp al, 0x25
0107aa37 7308 jae 0x14107aa41
0107aa39 89b3f2050000 mov dword ptr [rbx + 0x5f2], esi
0107aa3f eb04 jmp 0x14107aa45
0107aa41 3c29 cmp al, 0x29
0107aa43 730a jae 0x14107aa4f
0107aa45 c7838305000001010101 mov dword ptr [rbx + 0x583], 0x1010101
0107aa4f 0fb6838e050000 movzx eax, byte ptr [rbx + 0x58e]
0107aa56 3c01 cmp al, 1
0107aa58 7204 jb 0x14107aa5e
0107aa5a 3c03 cmp al, 3
0107aa5c 7607 jbe 0x14107aa65
0107aa5e c6838e05000003 mov byte ptr [rbx + 0x58e], 3
0107aa65 0fb6838f050000 movzx eax, byte ptr [rbx + 0x58f]
0107aa6c 3c01 cmp al, 1
0107aa6e 7204 jb 0x14107aa74
0107aa70 3c03 cmp al, 3
0107aa72 7607 jbe 0x14107aa7b
0107aa74 c6838f05000002 mov byte ptr [rbx + 0x58f], 2
0107aa7b 0fb68390050000 movzx eax, byte ptr [rbx + 0x590]
0107aa82 3c01 cmp al, 1
0107aa84 7204 jb 0x14107aa8a
0107aa86 3c03 cmp al, 3
0107aa88 7607 jbe 0x14107aa91
0107aa8a c6839005000003 mov byte ptr [rbx + 0x590], 3
0107aa91 f783a6050000feffffff test dword ptr [rbx + 0x5a6], 0xfffffffe
0107aa9b 7506 jne 0x14107aaa3
0107aa9d 89b3a6050000 mov dword ptr [rbx + 0x5a6], esi
0107aaa3 c6032c mov byte ptr [rbx], 0x2c
0107aaa6 488b0583c40201 mov rax, qword ptr [rip + 0x102c483]
0107aaad 4038b099410100 cmp byte ptr [rax + 0x14199], sil
0107aab4 7405 je 0x14107aabb
0107aab6 e8152f53ff call 0x1405ad9d0
0107aabb 4c8b8bd2050000 mov r9, qword ptr [rbx + 0x5d2]
0107aac2 4c8bbc2480020000 mov r15, qword ptr [rsp + 0x280]
0107aaca 4c8bb42488020000 mov r14, qword ptr [rsp + 0x288]
0107aad2 488bb424a0020000 mov rsi, qword ptr [rsp + 0x2a0]
0107aada 4d85c9 test r9, r9
0107aadd 0f849e000000 je 0x14107ab81
0107aae3 4d8b4568 mov r8, qword ptr [r13 + 0x68]
0107aae7 4d8bd0 mov r10, r8
0107aaea 49c1ea38 shr r10, 0x38
0107aaee 4d85c0 test r8, r8
0107aaf1 0f848a000000 je 0x14107ab81
0107aaf7 4d3bc8 cmp r9, r8
0107aafa 0f8481000000 je 0x14107ab81
0107ab00 498bc0 mov rax, r8
0107ab03 b9000000ff mov ecx, 0xff000000
0107ab08 2500ff0000 and eax, 0xff00
0107ab0d 48bf00000000ff000000 movabs rdi, 0xff00000000
0107ab17 498bd0 mov rdx, r8
0107ab1a 49bb0000000000ff0000 movabs r11, 0xff0000000000
0107ab24 48c1e210 shl rdx, 0x10
0107ab28 480bd0 or rdx, rax
0107ab2b 498bc0 mov rax, r8
0107ab2e 250000ff00 and eax, 0xff0000
0107ab33 48c1e210 shl rdx, 0x10
0107ab37 480bd0 or rdx, rax
0107ab3a 498bc0 mov rax, r8
0107ab3d 4823c1 and rax, rcx
0107ab40 48c1e210 shl rdx, 0x10
0107ab44 480bd0 or rdx, rax
0107ab47 498bc8 mov rcx, r8
0107ab4a 48c1e910 shr rcx, 0x10
0107ab4e 498bc0 mov rax, r8
0107ab51 4823cf and rcx, rdi
0107ab54 48c1e208 shl rdx, 8
0107ab58 4923c3 and rax, r11
0107ab5b 480bc8 or rcx, rax
0107ab5e 498bc0 mov rax, r8
0107ab61 48c1e910 shr rcx, 0x10
0107ab65 4823c7 and rax, rdi
0107ab68 480bc8 or rcx, rax
0107ab6b 48c1e908 shr rcx, 8
0107ab6f 480bd1 or rdx, rcx
0107ab72 490bd2 or rdx, r10
0107ab75 4c3bca cmp r9, rdx
0107ab78 7507 jne 0x14107ab81
0107ab7a 4c8983d2050000 mov qword ptr [rbx + 0x5d2], r8
0107ab81 488bbc2498020000 mov rdi, qword ptr [rsp + 0x298]
0107ab89 488b8c2470020000 mov rcx, qword ptr [rsp + 0x270]
0107ab91 4833cc xor rcx, rsp
0107ab94 e8470d7200 call 0x14179b8e0
0107ab99 4881c4a8020000 add rsp, 0x2a8
0107aba0 415d pop r13
0107aba2 5b pop rbx
0107aba3 c3 ret 
0107aba4 a7 cmpsd dword ptr [rsi], dword ptr [rdi]
0107aba5 a20701a7a2070110a2 movabs byte ptr [0xa2100107a2a70107], al