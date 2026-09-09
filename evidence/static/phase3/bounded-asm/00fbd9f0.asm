00fbd9f0 4885c9 test rcx, rcx
00fbd9f3 0f84b8010000 je 0x140fbdbb1
00fbd9f9 53 push rbx
00fbd9fa 57 push rdi
00fbd9fb 4881ec98000000 sub rsp, 0x98
00fbda02 488b0537760101 mov rax, qword ptr [rip + 0x1017637]
00fbda09 4833c4 xor rax, rsp
00fbda0c 4889842488000000 mov qword ptr [rsp + 0x88], rax
00fbda14 488bd9 mov rbx, rcx
00fbda17 0fb6fa movzx edi, dl
00fbda1a 488b09 mov rcx, qword ptr [rcx]
00fbda1d 4885c9 test rcx, rcx
00fbda20 0f8472010000 je 0x140fbdb98
00fbda26 813974736c70 cmp dword ptr [rcx], 0x706c7374
00fbda2c 0f8566010000 jne 0x140fbdb98
00fbda32 837b2800 cmp dword ptr [rbx + 0x28], 0
00fbda36 0f845c010000 je 0x140fbdb98
00fbda3c 488b05ed940e01 mov rax, qword ptr [rip + 0x10e94ed]
00fbda43 4889ac24c0000000 mov qword ptr [rsp + 0xc0], rbp
00fbda4b 33ed xor ebp, ebp
00fbda4d 4885c0 test rax, rax
00fbda50 7409 je 0x140fbda5b
00fbda52 488b9090410100 mov rdx, qword ptr [rax + 0x14190]
00fbda59 eb03 jmp 0x140fbda5e
00fbda5b 488bd5 mov rdx, rbp
00fbda5e 4038aa8b050000 cmp byte ptr [rdx + 0x58b], bpl
00fbda65 0f8525010000 jne 0x140fbdb90
00fbda6b 488d81f0000000 lea rax, [rcx + 0xf0]
00fbda72 4885c0 test rax, rax
00fbda75 7409 je 0x140fbda80
00fbda77 0fb6400f movzx eax, byte ptr [rax + 0xf]
00fbda7b c0e802 shr al, 2
00fbda7e 2401 and al, 1
00fbda80 84c0 test al, al
00fbda82 0f8408010000 je 0x140fbdb90
00fbda88 0f57c0 xorps xmm0, xmm0
00fbda8b 33c0 xor eax, eax
00fbda8d 0f11442460 movups xmmword ptr [rsp + 0x60], xmm0
00fbda92 6689842480000000 mov word ptr [rsp + 0x80], ax
00fbda9a 0f11442470 movups xmmword ptr [rsp + 0x70], xmm0
00fbda9f 813974736c70 cmp dword ptr [rcx], 0x706c7374
00fbdaa5 7524 jne 0x140fbdacb
00fbdaa7 488d442460 lea rax, [rsp + 0x60]
00fbdaac 48896c2458 mov qword ptr [rsp + 0x58], rbp
00fbdab1 4c8d442440 lea r8, [rsp + 0x40]
00fbdab6 4889442440 mov qword ptr [rsp + 0x40], rax
00fbdabb ba6d707067 mov edx, 0x6770706d
00fbdac0 f30f7f442448 movdqu xmmword ptr [rsp + 0x48], xmm0
00fbdac6 e8b56af3ff call 0x140ef4580
00fbdacb f644246f04 test byte ptr [rsp + 0x6f], 4
00fbdad0 0f84ba000000 je 0x140fbdb90
00fbdad6 f6434b01 test byte ptr [rbx + 0x4b], 1
00fbdada 742e je 0x140fbdb0a
00fbdadc 488b5b50 mov rbx, qword ptr [rbx + 0x50]
00fbdae0 4885db test rbx, rbx
00fbdae3 0f84a7000000 je 0x140fbdb90
00fbdae9 0f1f8000000000 nop dword ptr [rax]
00fbdaf0 400fb6d7 movzx edx, dil
00fbdaf4 488bcb mov rcx, rbx
00fbdaf7 e8f4feffff call 0x140fbd9f0
00fbdafc 488b5b10 mov rbx, qword ptr [rbx + 0x10]
00fbdb00 4885db test rbx, rbx
00fbdb03 75eb jne 0x140fbdaf0
00fbdb05 e986000000 jmp 0x140fbdb90
00fbdb0a 488b4330 mov rax, qword ptr [rbx + 0x30]
00fbdb0e 0fb6889a000000 movzx ecx, byte ptr [rax + 0x9a]
00fbdb15 c0e902 shr cl, 2
00fbdb18 80e101 and cl, 1
00fbdb1b 403acf cmp cl, dil
00fbdb1e 7470 je 0x140fbdb90
00fbdb20 4889b42490000000 mov qword ptr [rsp + 0x90], rsi
00fbdb28 e8835ef8ff call 0x140f439b0
00fbdb2d 488bf0 mov rsi, rax
00fbdb30 4885c0 test rax, rax
00fbdb33 7453 je 0x140fbdb88
00fbdb35 488b4b30 mov rcx, qword ptr [rbx + 0x30]
00fbdb39 4c8d8060160000 lea r8, [rax + 0x1660]
00fbdb40 48896c2438 mov qword ptr [rsp + 0x38], rbp
00fbdb45 4533c9 xor r9d, r9d
00fbdb48 48896c2430 mov qword ptr [rsp + 0x30], rbp
00fbdb4d 33d2 xor edx, edx
00fbdb4f 48896c2428 mov qword ptr [rsp + 0x28], rbp
00fbdb54 c744242004000000 mov dword ptr [rsp + 0x20], 4
00fbdb5c 49c70000020000 mov qword ptr [r8], 0x200
00fbdb63 49896808 mov qword ptr [r8 + 8], rbp
00fbdb67 4088b870160000 mov byte ptr [rax + 0x1670], dil
00fbdb6e e82df4f0ff call 0x140eccfa0
00fbdb73 488d8e944a0000 lea rcx, [rsi + 0x4a94]
00fbdb7a e8b15ef8ff call 0x140f43a30
00fbdb7f 488bce mov rcx, rsi
00fbdb82 ff15e0e79200 call qword ptr [rip + 0x92e7e0]
00fbdb88 488bb42490000000 mov rsi, qword ptr [rsp + 0x90]
00fbdb90 488bac24c0000000 mov rbp, qword ptr [rsp + 0xc0]
00fbdb98 488b8c2488000000 mov rcx, qword ptr [rsp + 0x88]
00fbdba0 4833cc xor rcx, rsp
00fbdba3 e838dd7d00 call 0x14179b8e0
00fbdba8 4881c498000000 add rsp, 0x98
00fbdbaf 5f pop rdi
00fbdbb0 5b pop rbx
00fbdbb1 c3 ret 