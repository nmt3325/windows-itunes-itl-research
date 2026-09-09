00f78430 48895c2418 mov qword ptr [rsp + 0x18], rbx
00f78435 56 push rsi
00f78436 57 push rdi
00f78437 4156 push r14
00f78439 4883ec20 sub rsp, 0x20
00f7843d ff4168 inc dword ptr [rcx + 0x68]
00f78440 33f6 xor esi, esi
00f78442 488b5a30 mov rbx, qword ptr [rdx + 0x30]
00f78446 4c8bf2 mov r14, rdx
00f78449 488bf9 mov rdi, rcx
00f7844c 8bc6 mov eax, esi
00f7844e 4885db test rbx, rbx
00f78451 7454 je 0x140f784a7
00f78453 48394310 cmp qword ptr [rbx + 0x10], rax
00f78457 7504 jne 0x140f7845d
00f78459 8bce mov ecx, esi
00f7845b eb45 jmp 0x140f784a2
00f7845d f6839a00000001 test byte ptr [rbx + 0x9a], 1
00f78464 7504 jne 0x140f7846a
00f78466 8bce mov ecx, esi
00f78468 eb38 jmp 0x140f784a2
00f7846a 488b4368 mov rax, qword ptr [rbx + 0x68]
00f7846e 8b4810 mov ecx, dword ptr [rax + 0x10]
00f78471 85c9 test ecx, ecx
00f78473 752d jne 0x140f784a2
00f78475 39b3ac000000 cmp dword ptr [rbx + 0xac], esi
00f7847b 751f jne 0x140f7849c
00f7847d 488bcb mov rcx, rbx
00f78480 e8bb8d0100 call 0x140f91240
00f78485 8983ac000000 mov dword ptr [rbx + 0xac], eax
00f7848b 85c0 test eax, eax
00f7848d 740d je 0x140f7849c
00f7848f ba3c000000 mov edx, 0x3c
00f78494 488bcb mov rcx, rbx
00f78497 e864bc0100 call 0x140f94100
00f7849c 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
00f784a2 e809f00300 call 0x140fb74b0
00f784a7 09477c or dword ptr [rdi + 0x7c], eax
00f784aa 498b06 mov rax, qword ptr [r14]
00f784ad 4885c0 test rax, rax
00f784b0 0f844a010000 je 0x140f78600
00f784b6 813874736c70 cmp dword ptr [rax], 0x706c7374
00f784bc 0f853e010000 jne 0x140f78600
00f784c2 41397628 cmp dword ptr [r14 + 0x28], esi
00f784c6 0f8434010000 je 0x140f78600
00f784cc 498b4e30 mov rcx, qword ptr [r14 + 0x30]
00f784d0 4885c9 test rcx, rcx
00f784d3 0f8427010000 je 0x140f78600
00f784d9 48896c2448 mov qword ptr [rsp + 0x48], rbp
00f784de e85dd640ff call 0x140385b40
00f784e3 488be8 mov rbp, rax
00f784e6 4885c0 test rax, rax
00f784e9 0f840c010000 je 0x140f785fb
00f784ef 488b5808 mov rbx, qword ptr [rax + 8]
00f784f3 4885db test rbx, rbx
00f784f6 7453 je 0x140f7854b
00f784f8 48397310 cmp qword ptr [rbx + 0x10], rsi
00f784fc 744d je 0x140f7854b
00f784fe f6839a00000001 test byte ptr [rbx + 0x9a], 1
00f78505 7444 je 0x140f7854b
00f78507 488b4368 mov rax, qword ptr [rbx + 0x68]
00f7850b 8b4810 mov ecx, dword ptr [rax + 0x10]
00f7850e 85c9 test ecx, ecx
00f78510 752d jne 0x140f7853f
00f78512 39b3ac000000 cmp dword ptr [rbx + 0xac], esi
00f78518 751f jne 0x140f78539
00f7851a 488bcb mov rcx, rbx
00f7851d e81e8d0100 call 0x140f91240
00f78522 8983ac000000 mov dword ptr [rbx + 0xac], eax
00f78528 85c0 test eax, eax
00f7852a 740d je 0x140f78539
00f7852c ba3c000000 mov edx, 0x3c
00f78531 488bcb mov rcx, rbx
00f78534 e8c7bb0100 call 0x140f94100
00f78539 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
00f7853f 098f80000000 or dword ptr [rdi + 0x80], ecx
00f78545 0fbae110 bt ecx, 0x10
00f78549 7207 jb 0x140f78552
00f7854b 808fb800000001 or byte ptr [rdi + 0xb8], 1
00f78552 41f6464b01 test byte ptr [r14 + 0x4b], 1
00f78557 0f859e000000 jne 0x140f785fb
00f7855d 4885db test rbx, rbx
00f78560 745e je 0x140f785c0
00f78562 48397310 cmp qword ptr [rbx + 0x10], rsi
00f78566 7458 je 0x140f785c0
00f78568 f6839a00000001 test byte ptr [rbx + 0x9a], 1
00f7856f 7438 je 0x140f785a9
00f78571 488b4368 mov rax, qword ptr [rbx + 0x68]
00f78575 8b7010 mov esi, dword ptr [rax + 0x10]
00f78578 85f6 test esi, esi
00f7857a 752d jne 0x140f785a9
00f7857c 39b3ac000000 cmp dword ptr [rbx + 0xac], esi
00f78582 751f jne 0x140f785a3
00f78584 488bcb mov rcx, rbx
00f78587 e8b48c0100 call 0x140f91240
00f7858c 8983ac000000 mov dword ptr [rbx + 0xac], eax
00f78592 85c0 test eax, eax
00f78594 740d je 0x140f785a3
00f78596 ba3c000000 mov edx, 0x3c
00f7859b 488bcb mov rcx, rbx
00f7859e e85dbb0100 call 0x140f94100
00f785a3 8bb3ac000000 mov esi, dword ptr [rbx + 0xac]
00f785a9 8bce mov ecx, esi
00f785ab e810da0100 call 0x140f95fc0
00f785b0 84c0 test al, al
00f785b2 750c jne 0x140f785c0
00f785b4 f6839f00000004 test byte ptr [rbx + 0x9f], 4
00f785bb 7503 jne 0x140f785c0
00f785bd ff476c inc dword ptr [rdi + 0x6c]
00f785c0 488b07 mov rax, qword ptr [rdi]
00f785c3 488bd3 mov rdx, rbx
00f785c6 488bcf mov rcx, rdi
00f785c9 ff9038030000 call qword ptr [rax + 0x338]
00f785cf 8b4d68 mov ecx, dword ptr [rbp + 0x68]
00f785d2 85c9 test ecx, ecx
00f785d4 7405 je 0x140f785db
00f785d6 014f78 add dword ptr [rdi + 0x78], ecx
00f785d9 eb0e jmp 0x140f785e9
00f785db b8d34d6210 mov eax, 0x10624dd3
00f785e0 f7655c mul dword ptr [rbp + 0x5c]
00f785e3 c1ea06 shr edx, 6
00f785e6 015778 add dword ptr [rdi + 0x78], edx
00f785e9 488bcd mov rcx, rbp
00f785ec e80f150300 call 0x140fa9b00
00f785f1 84c0 test al, al
00f785f3 7406 je 0x140f785fb
00f785f5 ff8784000000 inc dword ptr [rdi + 0x84]
00f785fb 488b6c2448 mov rbp, qword ptr [rsp + 0x48]
00f78600 488b5c2450 mov rbx, qword ptr [rsp + 0x50]
00f78605 4883c420 add rsp, 0x20
00f78609 415e pop r14
00f7860b 5f pop rdi
00f7860c 5e pop rsi
00f7860d c3 ret 