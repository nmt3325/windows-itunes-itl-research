010a8270 48895c2408 mov qword ptr [rsp + 8], rbx
010a8275 55 push rbp
010a8276 56 push rsi
010a8277 57 push rdi
010a8278 4154 push r12
010a827a 4155 push r13
010a827c 4156 push r14
010a827e 4157 push r15
010a8280 488dac2450faffff lea rbp, [rsp - 0x5b0]
010a8288 4881ecb0060000 sub rsp, 0x6b0
010a828f 488b05aacdf200 mov rax, qword ptr [rip + 0xf2cdaa]
010a8296 4833c4 xor rax, rsp
010a8299 488985a0050000 mov qword ptr [rbp + 0x5a0], rax
010a82a0 498bf0 mov rsi, r8
010a82a3 4c8bfa mov r15, rdx
010a82a6 33db xor ebx, ebx
010a82a8 4138581d cmp byte ptr [r8 + 0x1d], bl
010a82ac 740a je 0x1410a82b8
010a82ae b880ffffff mov eax, 0xffffff80
010a82b3 e9b3080000 jmp 0x1410a8b6b
010a82b8 83e904 sub ecx, 4
010a82bb 0f845c070000 je 0x1410a8a1d
010a82c1 83f901 cmp ecx, 1
010a82c4 0f8587080000 jne 0x1410a8b51
010a82ca 8b8204080000 mov eax, dword ptr [rdx + 0x804]
010a82d0 4869c80c020000 imul rcx, rax, 0x20c
010a82d7 48894c2450 mov qword ptr [rsp + 0x50], rcx
010a82dc 498b4008 mov rax, qword ptr [r8 + 8]
010a82e0 488b4078 mov rax, qword ptr [rax + 0x78]
010a82e4 48894580 mov qword ptr [rbp - 0x80], rax
010a82e8 488b4058 mov rax, qword ptr [rax + 0x58]
010a82ec 48894588 mov qword ptr [rbp - 0x78], rax
010a82f0 440fb78c1108080000 movzx r9d, word ptr [rcx + rdx + 0x808]
010a82f9 4c8d820a080000 lea r8, [rdx + 0x80a]
010a8300 4c03c1 add r8, rcx
010a8303 488bd3 mov rdx, rbx
010a8306 4585c9 test r9d, r9d
010a8309 7455 je 0x1410a8360
010a830b 4d85c0 test r8, r8
010a830e 7450 je 0x1410a8360
010a8310 48895c2438 mov qword ptr [rsp + 0x38], rbx
010a8315 48895c2430 mov qword ptr [rsp + 0x30], rbx
010a831a c744242800020000 mov dword ptr [rsp + 0x28], 0x200
010a8322 488d85a0030000 lea rax, [rbp + 0x3a0]
010a8329 4889442420 mov qword ptr [rsp + 0x20], rax
010a832e b9e9fd0000 mov ecx, 0xfde9
010a8333 ff1527288400 call qword ptr [rip + 0x842827]
010a8339 8bf8 mov edi, eax
010a833b 85c0 test eax, eax
010a833d 751f jne 0x1410a835e
010a833f ff15a3248400 call qword ptr [rip + 0x8424a3]
010a8345 83f87a cmp eax, 0x7a
010a8348 7507 jne 0x1410a8351
010a834a bf00020000 mov edi, 0x200
010a834f eb0d jmp 0x1410a835e
010a8351 ff1591248400 call qword ptr [rip + 0x842491]
010a8357 8bc8 mov ecx, eax
010a8359 e8a2a5a2ff call 0x140ad2900
010a835e 8bd7 mov edx, edi
010a8360 488b7e08 mov rdi, qword ptr [rsi + 8]
010a8364 0f57c0 xorps xmm0, xmm0
010a8367 f30f7f442460 movdqu xmmword ptr [rsp + 0x60], xmm0
010a836d 4c8bf3 mov r14, rbx
010a8370 48895c2448 mov qword ptr [rsp + 0x48], rbx
010a8375 c744242850545448 mov dword ptr [rsp + 0x28], 0x48545450
010a837d 895c2420 mov dword ptr [rsp + 0x20], ebx
010a8381 4c8d4c2460 lea r9, [rsp + 0x60]
010a8386 4c8d85a0030000 lea r8, [rbp + 0x3a0]
010a838d 488b4f08 mov rcx, qword ptr [rdi + 8]
010a8391 e8bacae1ff call 0x140ec4e50
010a8396 4885c0 test rax, rax
010a8399 7443 je 0x1410a83de
010a839b 488b5008 mov rdx, qword ptr [rax + 8]
010a839f 4885d2 test rdx, rdx
010a83a2 7432 je 0x1410a83d6
010a83a4 48395a10 cmp qword ptr [rdx + 0x10], rbx
010a83a8 742c je 0x1410a83d6
010a83aa 0f57c0 xorps xmm0, xmm0
010a83ad f30f7f442470 movdqu xmmword ptr [rsp + 0x70], xmm0
010a83b3 488d442470 lea rax, [rsp + 0x70]
010a83b8 4889442420 mov qword ptr [rsp + 0x20], rax
010a83bd 4533c9 xor r9d, r9d
010a83c0 4c8d4580 lea r8, [rbp - 0x80]
010a83c4 488bcf mov rcx, rdi
010a83c7 e8b4bde4ff call 0x140ef4180
010a83cc 4c8bf0 mov r14, rax
010a83cf 4889442448 mov qword ptr [rsp + 0x48], rax
010a83d4 eb08 jmp 0x1410a83de
010a83d6 4c8bf3 mov r14, rbx
010a83d9 48895c2448 mov qword ptr [rsp + 0x48], rbx
010a83de 48c7c7ffffffff mov rdi, 0xffffffffffffffff
010a83e5 488b4c2460 mov rcx, qword ptr [rsp + 0x60]
010a83ea 4885c9 test rcx, rcx
010a83ed 741d je 0x1410a840c
010a83ef 8bc7 mov eax, edi
010a83f1 f00fc14108 lock xadd dword ptr [rcx + 8], eax
010a83f6 83f801 cmp eax, 1
010a83f9 750c jne 0x1410a8407
010a83fb c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
010a8402 e8d1396f00 call 0x14179bdd8
010a8407 48895c2460 mov qword ptr [rsp + 0x60], rbx
010a840c 488b4c2468 mov rcx, qword ptr [rsp + 0x68]
010a8411 4885c9 test rcx, rcx
010a8414 741d je 0x1410a8433
010a8416 8bc7 mov eax, edi
010a8418 f00fc14108 lock xadd dword ptr [rcx + 8], eax
010a841d 83f801 cmp eax, 1
010a8420 750c jne 0x1410a842e
010a8422 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
010a8429 e8aa396f00 call 0x14179bdd8
010a842e 48895c2468 mov qword ptr [rsp + 0x68], rbx
010a8433 4d85f6 test r14, r14
010a8436 0f8428070000 je 0x1410a8b64
010a843c 498b4630 mov rax, qword ptr [r14 + 0x30]
010a8440 488b4858 mov rcx, qword ptr [rax + 0x58]
010a8444 80494202 or byte ptr [rcx + 0x42], 2
010a8448 4c8db678040000 lea r14, [rsi + 0x478]
010a844f 4d85f6 test r14, r14
010a8452 7418 je 0x1410a846c
010a8454 33d2 xor edx, edx
010a8456 41b860160000 mov r8d, 0x1660
010a845c 498bce mov rcx, r14
010a845f e83c486f00 call 0x14179cca0
010a8464 41c7460460160000 mov dword ptr [r14 + 4], 0x1660
010a846c 4c8daed81a0000 lea r13, [rsi + 0x1ad8]
010a8473 4d85ed test r13, r13
010a8476 7410 je 0x1410a8488
010a8478 33d2 xor edx, edx
010a847a 41b834340000 mov r8d, 0x3434
010a8480 498bcd mov rcx, r13
010a8483 e818486f00 call 0x14179cca0
010a8488 4c8da680040000 lea r12, [rsi + 0x480]
010a848f 4c8d4d80 lea r9, [rbp - 0x80]
010a8493 4c8d442440 lea r8, [rsp + 0x40]
010a8498 498bd4 mov rdx, r12
010a849b 498bcf mov rcx, r15
010a849e e8edf9ffff call 0x1410a7e90
010a84a3 6641833c2400 cmp word ptr [r12], 0
010a84a9 7404 je 0x1410a84af
010a84ab 41830e01 or dword ptr [r14], 1
010a84af 41bbff000000 mov r11d, 0xff
010a84b5 448b4580 mov r8d, dword ptr [rbp - 0x80]
010a84b9 4585c0 test r8d, r8d
010a84bc 0f84ab000000 je 0x1410a856d
010a84c2 488d1547bcab00 lea rdx, [rip + 0xabbc47]
010a84c9 488d4d80 lea rcx, [rbp - 0x80]
010a84cd e83e4234ff call 0x1403ec710
010a84d2 4c8db6b83c0000 lea r14, [rsi + 0x3cb8]
010a84d9 4d85f6 test r14, r14
010a84dc 7420 je 0x1410a84fe
010a84de 6641891e mov word ptr [r14], bx
010a84e2 488d4580 lea rax, [rbp - 0x80]
010a84e6 48ffc7 inc rdi
010a84e9 803c3800 cmp byte ptr [rax + rdi], 0
010a84ed 75f7 jne 0x1410a84e6
010a84ef 4d8bc6 mov r8, r14
010a84f2 488bd7 mov rdx, rdi
010a84f5 488d4d80 lea rcx, [rbp - 0x80]
010a84f9 e8a2daa3ff call 0x140ae5fa0
010a84fe 41bbff000000 mov r11d, 0xff
010a8504 4d85e4 test r12, r12
010a8507 744f je 0x1410a8558
010a8509 4d85f6 test r14, r14
010a850c 744a je 0x1410a8558
010a850e 410fb70e movzx ecx, word ptr [r14]
010a8512 450fb71424 movzx r10d, word ptr [r12]
010a8517 4403d1 add r10d, ecx
010a851a 453bd3 cmp r10d, r11d
010a851d 450f47d3 cmova r10d, r11d
010a8521 4d8d442402 lea r8, [r12 + 2]
010a8526 458bca mov r9d, r10d
010a8529 49ffc1 inc r9
010a852c 4f8d0c4e lea r9, [r14 + r9*2]
010a8530 498d5602 lea rdx, [r14 + 2]
010a8534 488d144a lea rdx, [rdx + rcx*2]
010a8538 493bd1 cmp rdx, r9
010a853b 7317 jae 0x1410a8554
010a853d 0f1f00 nop dword ptr [rax]
010a8540 410fb700 movzx eax, word ptr [r8]
010a8544 4d8d4002 lea r8, [r8 + 2]
010a8548 668902 mov word ptr [rdx], ax
010a854b 4883c202 add rdx, 2
010a854f 493bd1 cmp rdx, r9
010a8552 72ec jb 0x1410a8540
010a8554 66458916 mov word ptr [r14], r10w
010a8558 c686b848000001 mov byte ptr [rsi + 0x48b8], 1
010a855f 48b80000000000200800 movabs rax, 0x8200000000000
010a8569 49094500 or qword ptr [r13], rax
010a856d 498d8f00040000 lea rcx, [r15 + 0x400]
010a8574 0fb701 movzx eax, word ptr [rcx]
010a8577 41b8fe000000 mov r8d, 0xfe
010a857d 6685c0 test ax, ax
010a8580 7455 je 0x1410a85d7
010a8582 488d9680120000 lea rdx, [rsi + 0x1280]
010a8589 4885c9 test rcx, rcx
010a858c 0f84a2000000 je 0x1410a8634
010a8592 4885d2 test rdx, rdx
010a8595 0f8499000000 je 0x1410a8634
010a859b 448bc8 mov r9d, eax
010a859e 4883c102 add rcx, 2
010a85a2 413bc3 cmp eax, r11d
010a85a5 760d jbe 0x1410a85b4
010a85a7 6644891a mov word ptr [rdx], r11w
010a85ab 4883c202 add rdx, 2
010a85af 458bc8 mov r9d, r8d
010a85b2 eb0d jmp 0x1410a85c1
010a85b4 668902 mov word ptr [rdx], ax
010a85b7 4883c202 add rdx, 2
010a85bb 4183e901 sub r9d, 1
010a85bf 7873 js 0x1410a8634
010a85c1 0fb701 movzx eax, word ptr [rcx]
010a85c4 488d4902 lea rcx, [rcx + 2]
010a85c8 668902 mov word ptr [rdx], ax
010a85cb 488d5202 lea rdx, [rdx + 2]
010a85cf 4183e901 sub r9d, 1
010a85d3 79ec jns 0x1410a85c1
010a85d5 eb5d jmp 0x1410a8634
010a85d7 498d8f00020000 lea rcx, [r15 + 0x200]
010a85de 0fb701 movzx eax, word ptr [rcx]
010a85e1 6685c0 test ax, ax
010a85e4 7458 je 0x1410a863e
010a85e6 488d9680120000 lea rdx, [rsi + 0x1280]
010a85ed 4885c9 test rcx, rcx
010a85f0 7442 je 0x1410a8634
010a85f2 4885d2 test rdx, rdx
010a85f5 743d je 0x1410a8634
010a85f7 448bc8 mov r9d, eax
010a85fa 4883c102 add rcx, 2
010a85fe 413bc3 cmp eax, r11d
010a8601 760d jbe 0x1410a8610
010a8603 6644891a mov word ptr [rdx], r11w
010a8607 4883c202 add rdx, 2
010a860b 458bc8 mov r9d, r8d
010a860e eb10 jmp 0x1410a8620
010a8610 668902 mov word ptr [rdx], ax
010a8613 4883c202 add rdx, 2
010a8617 4183e901 sub r9d, 1
010a861b 7817 js 0x1410a8634
010a861d 0f1f00 nop dword ptr [rax]
010a8620 0fb701 movzx eax, word ptr [rcx]
010a8623 488d4902 lea rcx, [rcx + 2]
010a8627 668902 mov word ptr [rdx], ax
010a862a 488d5202 lea rdx, [rdx + 2]
010a862e 4183e901 sub r9d, 1
010a8632 79ec jns 0x1410a8620
010a8634 818e7804000000040000 or dword ptr [rsi + 0x478], 0x400
010a863e 498d8f00060000 lea rcx, [r15 + 0x600]
010a8645 0fb701 movzx eax, word ptr [rcx]
010a8648 6685c0 test ax, ax
010a864b 7459 je 0x1410a86a6
010a864d 488d96f4270000 lea rdx, [rsi + 0x27f4]
010a8654 4885c9 test rcx, rcx
010a8657 743c je 0x1410a8695
010a8659 4885d2 test rdx, rdx
010a865c 7437 je 0x1410a8695
010a865e 4883c102 add rcx, 2
010a8662 413bc3 cmp eax, r11d
010a8665 760a jbe 0x1410a8671
010a8667 6644891a mov word ptr [rdx], r11w
010a866b 4883c202 add rdx, 2
010a866f eb10 jmp 0x1410a8681
010a8671 668902 mov word ptr [rdx], ax
010a8674 4883c202 add rdx, 2
010a8678 448d40ff lea r8d, [rax - 1]
010a867c 4585c0 test r8d, r8d
010a867f 7814 js 0x1410a8695
010a8681 0fb701 movzx eax, word ptr [rcx]
010a8684 488d4902 lea rcx, [rcx + 2]
010a8688 668902 mov word ptr [rdx], ax
010a868b 488d5202 lea rdx, [rdx + 2]
010a868f 4183e801 sub r8d, 1
010a8693 79ec jns 0x1410a8681
010a8695 48b80000000000000020 movabs rax, 0x2000000000000000
010a869f 480986d81a0000 or qword ptr [rsi + 0x1ad8], rax
010a86a6 4c8b642450 mov r12, qword ptr [rsp + 0x50]
010a86ab 438b843c0c0a0000 mov eax, dword ptr [r12 + r15 + 0xa0c]
010a86b3 85c0 test eax, eax
010a86b5 7410 je 0x1410a86c7
010a86b7 8986a0140000 mov dword ptr [rsi + 0x14a0], eax
010a86bd 818e7804000000800000 or dword ptr [rsi + 0x478], 0x8000
010a86c7 66899da0010000 mov word ptr [rbp + 0x1a0], bx
010a86ce 0fb74c2440 movzx ecx, word ptr [rsp + 0x40]
010a86d3 83e964 sub ecx, 0x64
010a86d6 741b je 0x1410a86f3
010a86d8 81e992010000 sub ecx, 0x192
010a86de 740c je 0x1410a86ec
010a86e0 83f906 cmp ecx, 6
010a86e3 7536 jne 0x1410a871b
010a86e5 b92600ee0c mov ecx, 0xcee0026
010a86ea eb0c jmp 0x1410a86f8
010a86ec b92500ee0c mov ecx, 0xcee0025
010a86f1 eb05 jmp 0x1410a86f8
010a86f3 b92300ee0c mov ecx, 0xcee0023
010a86f8 488dbda0010000 lea rdi, [rbp + 0x1a0]
010a86ff e8cc62a5ff call 0x140afe9d0
010a8704 488bc8 mov rcx, rax
010a8707 488bd7 mov rdx, rdi
010a870a e821dda3ff call 0x140ae6430
010a870f 0fb785a0010000 movzx eax, word ptr [rbp + 0x1a0]
010a8716 6685c0 test ax, ax
010a8719 7520 jne 0x1410a873b
010a871b b92100ee0c mov ecx, 0xcee0021
010a8720 e8ab62a5ff call 0x140afe9d0
010a8725 488d95a0010000 lea rdx, [rbp + 0x1a0]
010a872c 488bc8 mov rcx, rax
010a872f e8fcdca3ff call 0x140ae6430
010a8734 0fb785a0010000 movzx eax, word ptr [rbp + 0x1a0]
010a873b 4c8b6c2448 mov r13, qword ptr [rsp + 0x48]
010a8740 4d8b7530 mov r14, qword ptr [r13 + 0x30]
010a8744 4d85f6 test r14, r14
010a8747 0f84ad000000 je 0x1410a87fa
010a874d 4d8b5e10 mov r11, qword ptr [r14 + 0x10]
010a8751 4d85db test r11, r11
010a8754 0f84a0000000 je 0x1410a87fa
010a875a 4d8d8ecc000000 lea r9, [r14 + 0xcc]
010a8761 496339 movsxd rdi, dword ptr [r9]
010a8764 4981c370030000 add r11, 0x370
010a876b b9ff000000 mov ecx, 0xff
010a8770 663bc1 cmp ax, cx
010a8773 7605 jbe 0x1410a877a
010a8775 418919 mov dword ptr [r9], ebx
010a8778 eb6a jmp 0x1410a87e4
010a877a 440fb7c0 movzx r8d, ax
010a877e 4503c0 add r8d, r8d
010a8781 4d85db test r11, r11
010a8784 745e je 0x1410a87e4
010a8786 41813b63727473 cmp dword ptr [r11], 0x73747263
010a878d 7555 jne 0x1410a87e4
010a878f 41837b2800 cmp dword ptr [r11 + 0x28], 0
010a8794 754e jne 0x1410a87e4
010a8796 41837b3c00 cmp dword ptr [r11 + 0x3c], 0
010a879b 7547 jne 0x1410a87e4
010a879d 85ff test edi, edi
010a879f 7434 je 0x1410a87d5
010a87a1 7e41 jle 0x1410a87e4
010a87a3 413b7b2c cmp edi, dword ptr [r11 + 0x2c]
010a87a7 7f3b jg 0x1410a87e4
010a87a9 41f6430401 test byte ptr [r11 + 4], 1
010a87ae 740e je 0x1410a87be
010a87b0 498b4318 mov rax, qword ptr [r11 + 0x18]
010a87b4 488b00 mov rax, qword ptr [rax]
010a87b7 836cb8fc01 sub dword ptr [rax + rdi*4 - 4], 1
010a87bc 7517 jne 0x1410a87d5
010a87be 498b4310 mov rax, qword ptr [r11 + 0x10]
010a87c2 488b10 mov rdx, qword ptr [rax]
010a87c5 8b44fafc mov eax, dword ptr [rdx + rdi*8 - 4]
010a87c9 41014340 add dword ptr [r11 + 0x40], eax
010a87cd c744faf801000080 mov dword ptr [rdx + rdi*8 - 8], 0x80000001
010a87d5 488d95a2010000 lea rdx, [rbp + 0x1a2]
010a87dc 498bcb mov rcx, r11
010a87df e80c5ab5ff call 0x140bfe1f0
010a87e4 413bbecc000000 cmp edi, dword ptr [r14 + 0xcc]
010a87eb 740d je 0x1410a87fa
010a87ed ba09000000 mov edx, 9
010a87f2 498bce mov rcx, r14
010a87f5 e806b9eeff call 0x140f94100
010a87fa 498b4530 mov rax, qword ptr [r13 + 0x30]
010a87fe 80889a00000080 or byte ptr [rax + 0x9a], 0x80
010a8805 4c8d86d81a0000 lea r8, [rsi + 0x1ad8]
010a880c 488d9678040000 lea rdx, [rsi + 0x478]
010a8813 48895c2438 mov qword ptr [rsp + 0x38], rbx
010a8818 48895c2430 mov qword ptr [rsp + 0x30], rbx
010a881d 48895c2428 mov qword ptr [rsp + 0x28], rbx
010a8822 895c2420 mov dword ptr [rsp + 0x20], ebx
010a8826 4533c9 xor r9d, r9d
010a8829 498b4d30 mov rcx, qword ptr [r13 + 0x30]
010a882d e86e47e2ff call 0x140eccfa0
010a8832 498b4530 mov rax, qword ptr [r13 + 0x30]
010a8836 80889a00000020 or byte ptr [rax + 0x9a], 0x20
010a883d 438b8c3c100a0000 mov ecx, dword ptr [r12 + r15 + 0xa10]
010a8845 83e901 sub ecx, 1
010a8848 741f je 0x1410a8869
010a884a 83e901 sub ecx, 1
010a884d 7413 je 0x1410a8862
010a884f 83f901 cmp ecx, 1
010a8852 7407 je 0x1410a885b
010a8854 b904009a00 mov ecx, 0x9a0004
010a8859 eb13 jmp 0x1410a886e
010a885b b907009a00 mov ecx, 0x9a0007
010a8860 eb0c jmp 0x1410a886e
010a8862 b906009a00 mov ecx, 0x9a0006
010a8867 eb05 jmp 0x1410a886e
010a8869 b905009a00 mov ecx, 0x9a0005
010a886e e85d61a5ff call 0x140afe9d0
010a8873 4c8bf0 mov r14, rax
010a8876 66895da0 mov word ptr [rbp - 0x60], bx
010a887a 4885c0 test rax, rax
010a887d 744f je 0x1410a88ce
010a887f 48895c2450 mov qword ptr [rsp + 0x50], rbx
010a8884 488bc8 mov rcx, rax
010a8887 ff1503078400 call qword ptr [rip + 0x840703]
010a888d 4889442458 mov qword ptr [rsp + 0x58], rax
010a8892 0fb7fb movzx edi, bx
010a8895 4885c0 test rax, rax
010a8898 7430 je 0x1410a88ca
010a889a 0fb7f8 movzx edi, ax
010a889d b9ff000000 mov ecx, 0xff
010a88a2 483bc1 cmp rax, rcx
010a88a5 7e07 jle 0x1410a88ae
010a88a7 48894c2458 mov qword ptr [rsp + 0x58], rcx
010a88ac 8bf9 mov edi, ecx
010a88ae 0f28442450 movaps xmm0, xmmword ptr [rsp + 0x50]
010a88b3 660f7f442450 movdqa xmmword ptr [rsp + 0x50], xmm0
010a88b9 4c8d45a2 lea r8, [rbp - 0x5e]
010a88bd 488d542450 lea rdx, [rsp + 0x50]
010a88c2 498bce mov rcx, r14
010a88c5 e89698aeff call 0x140b92160
010a88ca 66897da0 mov word ptr [rbp - 0x60], di
010a88ce 488d55a0 lea rdx, [rbp - 0x60]
010a88d2 498b4d30 mov rcx, qword ptr [r13 + 0x30]
010a88d6 e8e56cefff call 0x140f9f5c0
010a88db 488b8630040000 mov rax, qword ptr [rsi + 0x430]
010a88e2 4885c0 test rax, rax
010a88e5 7469 je 0x1410a8950
010a88e7 488b08 mov rcx, qword ptr [rax]
010a88ea 4885c9 test rcx, rcx
010a88ed 7461 je 0x1410a8950
010a88ef 813974736c70 cmp dword ptr [rcx], 0x706c7374
010a88f5 7559 jne 0x1410a8950
010a88f7 83782800 cmp dword ptr [rax + 0x28], 0
010a88fb 7453 je 0x1410a8950
010a88fd f6404b01 test byte ptr [rax + 0x4b], 1
010a8901 7419 je 0x1410a891c
010a8903 4881c130010000 add rcx, 0x130
010a890a 4c8d45a0 lea r8, [rbp - 0x60]
010a890e 8b5068 mov edx, dword ptr [rax + 0x68]
010a8911 e85a6bb5ff call 0x140bff470
010a8916 0fb745a0 movzx eax, word ptr [rbp - 0x60]
010a891a eb3b jmp 0x1410a8957
010a891c 488b5030 mov rdx, qword ptr [rax + 0x30]
010a8920 8bc3 mov eax, ebx
010a8922 66895da0 mov word ptr [rbp - 0x60], bx
010a8926 4885d2 test rdx, rdx
010a8929 742c je 0x1410a8957
010a892b 488b4a10 mov rcx, qword ptr [rdx + 0x10]
010a892f 4885c9 test rcx, rcx
010a8932 7423 je 0x1410a8957
010a8934 4881c178010000 add rcx, 0x178
010a893b 4c8d45a0 lea r8, [rbp - 0x60]
010a893f 8b92b0000000 mov edx, dword ptr [rdx + 0xb0]
010a8945 e8266bb5ff call 0x140bff470
010a894a 0fb745a0 movzx eax, word ptr [rbp - 0x60]
010a894e eb07 jmp 0x1410a8957
010a8950 0fb7c3 movzx eax, bx
010a8953 66895da0 mov word ptr [rbp - 0x60], bx
010a8957 498b7d30 mov rdi, qword ptr [r13 + 0x30]
010a895b 4885ff test rdi, rdi
010a895e 0f8499000000 je 0x1410a89fd
010a8964 4c8b5f10 mov r11, qword ptr [rdi + 0x10]
010a8968 4d85db test r11, r11
010a896b 0f848c000000 je 0x1410a89fd
010a8971 4c8d8fd8000000 lea r9, [rdi + 0xd8]
010a8978 4981c348040000 add r11, 0x448
010a897f b9ff000000 mov ecx, 0xff
010a8984 663bc1 cmp ax, cx
010a8987 7605 jbe 0x1410a898e
010a8989 418919 mov dword ptr [r9], ebx
010a898c eb6f jmp 0x1410a89fd
010a898e 440fb7c0 movzx r8d, ax
010a8992 4503c0 add r8d, r8d
010a8995 4d85db test r11, r11
010a8998 7463 je 0x1410a89fd
010a899a 41813b63727473 cmp dword ptr [r11], 0x73747263
010a89a1 755a jne 0x1410a89fd
010a89a3 41837b2800 cmp dword ptr [r11 + 0x28], 0
010a89a8 7553 jne 0x1410a89fd
010a89aa 496311 movsxd rdx, dword ptr [r9]
010a89ad 41837b3c00 cmp dword ptr [r11 + 0x3c], 0
010a89b2 7549 jne 0x1410a89fd
010a89b4 85d2 test edx, edx
010a89b6 7439 je 0x1410a89f1
010a89b8 7e43 jle 0x1410a89fd
010a89ba 413b532c cmp edx, dword ptr [r11 + 0x2c]
010a89be 7f3d jg 0x1410a89fd
010a89c0 41f6430401 test byte ptr [r11 + 4], 1
010a89c5 740e je 0x1410a89d5
010a89c7 498b4318 mov rax, qword ptr [r11 + 0x18]
010a89cb 488b00 mov rax, qword ptr [rax]
010a89ce 836c90fc01 sub dword ptr [rax + rdx*4 - 4], 1
010a89d3 751c jne 0x1410a89f1
010a89d5 4c8bd2 mov r10, rdx
010a89d8 498b4310 mov rax, qword ptr [r11 + 0x10]
010a89dc 488b10 mov rdx, qword ptr [rax]
010a89df 428b44d2fc mov eax, dword ptr [rdx + r10*8 - 4]
010a89e4 41014340 add dword ptr [r11 + 0x40], eax
010a89e8 42c744d2f801000080 mov dword ptr [rdx + r10*8 - 8], 0x80000001
010a89f1 488d55a2 lea rdx, [rbp - 0x5e]
010a89f5 498bcb mov rcx, r11
010a89f8 e8f357b5ff call 0x140bfe1f0
010a89fd ba37000000 mov edx, 0x37
010a8a02 488bcf mov rcx, rdi
010a8a05 e8f6b6eeff call 0x140f94100
010a8a0a 488b8630040000 mov rax, qword ptr [rsi + 0x430]
010a8a11 8b4828 mov ecx, dword ptr [rax + 0x28]
010a8a14 41894d2c mov dword ptr [r13 + 0x2c], ecx
010a8a18 e934010000 jmp 0x1410a8b51
010a8a1d 4d8b7008 mov r14, qword ptr [r8 + 8]
010a8a21 498b4e78 mov rcx, qword ptr [r14 + 0x78]
010a8a25 48894c2470 mov qword ptr [rsp + 0x70], rcx
010a8a2a 488b5158 mov rdx, qword ptr [rcx + 0x58]
010a8a2e 4889542478 mov qword ptr [rsp + 0x78], rdx
010a8a33 4d85ff test r15, r15
010a8a36 0f8428010000 je 0x1410a8b64
010a8a3c 6641391f cmp word ptr [r15], bx
010a8a40 0f841e010000 je 0x1410a8b64
010a8a46 4885c9 test rcx, rcx
010a8a49 0f8415010000 je 0x1410a8b64
010a8a4f 4c3931 cmp qword ptr [rcx], r14
010a8a52 0f850c010000 jne 0x1410a8b64
010a8a58 488d42ff lea rax, [rdx - 1]
010a8a5c 4883f8fd cmp rax, -3
010a8a60 770a ja 0x1410a8a6c
010a8a62 48394a08 cmp qword ptr [rdx + 8], rcx
010a8a66 0f85f8000000 jne 0x1410a8b64
010a8a6c 4d85f6 test r14, r14
010a8a6f 0f84b8000000 je 0x1410a8b2d
010a8a75 498b4670 mov rax, qword ptr [r14 + 0x70]
010a8a79 4885c0 test rax, rax
010a8a7c 740d je 0x1410a8a8b
010a8a7e 817864ffffff7f cmp dword ptr [rax + 0x64], 0x7fffffff
010a8a85 0f83d9000000 jae 0x1410a8b64
010a8a8b 41813e74736c70 cmp dword ptr [r14], 0x706c7374
010a8a92 0f8595000000 jne 0x1410a8b2d
010a8a98 498b4e68 mov rcx, qword ptr [r14 + 0x68]
010a8a9c e80fd8b1ff call 0x140bc62b0
010a8aa1 488bf8 mov rdi, rax
010a8aa4 4885c0 test rax, rax
010a8aa7 0f8483000000 je 0x1410a8b30
010a8aad 4c8930 mov qword ptr [rax], r14
010a8ab0 80484b01 or byte ptr [rax + 0x4b], 1
010a8ab4 b801000000 mov eax, 1
010a8ab9 f00fc1056f06f400 lock xadd dword ptr [rip + 0xf4066f], eax
010a8ac1 894728 mov dword ptr [rdi + 0x28], eax
010a8ac4 885f48 mov byte ptr [rdi + 0x48], bl
010a8ac7 488b0562e4ff00 mov rax, qword ptr [rip + 0xffe462]
010a8ace 8b9058550100 mov edx, dword ptr [rax + 0x15558]
010a8ad4 895744 mov dword ptr [rdi + 0x44], edx
010a8ad7 498b4e08 mov rcx, qword ptr [r14 + 8]
010a8adb e840f5e0ff call 0x140eb8020
010a8ae0 48894720 mov qword ptr [rdi + 0x20], rax
010a8ae4 804f4b40 or byte ptr [rdi + 0x4b], 0x40
010a8ae8 804f4b80 or byte ptr [rdi + 0x4b], 0x80
010a8aec 4c8d4768 lea r8, [rdi + 0x68]
010a8af0 488b0f mov rcx, qword ptr [rdi]
010a8af3 4881c130010000 add rcx, 0x130
010a8afa 498bd7 mov rdx, r15
010a8afd e83e62b5ff call 0x140bfed40
010a8b02 488bcf mov rcx, rdi
010a8b05 85c0 test eax, eax
010a8b07 751f jne 0x1410a8b28
010a8b09 e8f27be4ff call 0x140ef0700
010a8b0e 41b001 mov r8b, 1
010a8b11 488d542470 lea rdx, [rsp + 0x70]
010a8b16 488bcf mov rcx, rdi
010a8b19 e8e23ff1ff call 0x140fbcb00
010a8b1e 488bcf mov rcx, rdi
010a8b21 e8ca6ce4ff call 0x140eef7f0
010a8b26 eb08 jmp 0x1410a8b30
010a8b28 e85344f1ff call 0x140fbcf80
010a8b2d 488bfb mov rdi, rbx
010a8b30 4885ff test rdi, rdi
010a8b33 742f je 0x1410a8b64
010a8b35 410fb78700020000 movzx eax, word ptr [r15 + 0x200]
010a8b3d 66894778 mov word ptr [rdi + 0x78], ax
010a8b41 410fb78704020000 movzx eax, word ptr [r15 + 0x204]
010a8b49 6689477a mov word ptr [rdi + 0x7a], ax
010a8b4d 804f7c01 or byte ptr [rdi + 0x7c], 1
010a8b51 e81aeea5ff call 0x140b07970
010a8b56 b880ffffff mov eax, 0xffffff80
010a8b5b 807e1d00 cmp byte ptr [rsi + 0x1d], 0
010a8b5f 0f45d8 cmovne ebx, eax
010a8b62 eb05 jmp 0x1410a8b69
010a8b64 bb94ffffff mov ebx, 0xffffff94
010a8b69 8bc3 mov eax, ebx
010a8b6b 488b8da0050000 mov rcx, qword ptr [rbp + 0x5a0]
010a8b72 4833cc xor rcx, rsp
010a8b75 e8662d6f00 call 0x14179b8e0
010a8b7a 488b9c24f0060000 mov rbx, qword ptr [rsp + 0x6f0]
010a8b82 4881c4b0060000 add rsp, 0x6b0
010a8b89 415f pop r15
010a8b8b 415e pop r14
010a8b8d 415d pop r13
010a8b8f 415c pop r12
010a8b91 5f pop rdi
010a8b92 5e pop rsi
010a8b93 5d pop rbp
010a8b94 c3 ret 