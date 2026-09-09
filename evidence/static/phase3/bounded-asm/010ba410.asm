010ba410 4055 push rbp
010ba412 53 push rbx
010ba413 56 push rsi
010ba414 57 push rdi
010ba415 4154 push r12
010ba417 4155 push r13
010ba419 4156 push r14
010ba41b 4157 push r15
010ba41d 488dac2478f6ffff lea rbp, [rsp - 0x988]
010ba425 4881ec880a0000 sub rsp, 0xa88
010ba42c 488b050dacf100 mov rax, qword ptr [rip + 0xf1ac0d]
010ba433 4833c4 xor rax, rsp
010ba436 48898570090000 mov qword ptr [rbp + 0x970], rax
010ba43d 33db xor ebx, ebx
010ba43f 418d40fe lea eax, [r8 - 2]
010ba443 48895c2440 mov qword ptr [rsp + 0x40], rbx
010ba448 458be9 mov r13d, r9d
010ba44b 48895c2448 mov qword ptr [rsp + 0x48], rbx
010ba450 4c8bf2 mov r14, rdx
010ba453 488bf1 mov rsi, rcx
010ba456 448be3 mov r12d, ebx
010ba459 448bfb mov r15d, ebx
010ba45c 3db5000000 cmp eax, 0xb5
010ba461 0f8702230000 ja 0x1410bc769
010ba467 488d15925bf4fe lea rdx, [rip - 0x10ba46e]
010ba46e 0fb6840288c80b01 movzx eax, byte ptr [rdx + rax + 0x10bc888]
010ba476 8b8c8294c70b01 mov ecx, dword ptr [rdx + rax*4 + 0x10bc794]
010ba47d 4803ca add rcx, rdx
010ba480 ffe1 jmp rcx
010ba482 8b8ee0000000 mov ecx, dword ptr [rsi + 0xe0]
010ba488 85c9 test ecx, ecx
010ba48a 7422 je 0x1410ba4ae
010ba48c 418b96e0000000 mov edx, dword ptr [r14 + 0xe0]
010ba493 85d2 test edx, edx
010ba495 7417 je 0x1410ba4ae
010ba497 498b4610 mov rax, qword ptr [r14 + 0x10]
010ba49b 48394610 cmp qword ptr [rsi + 0x10], rax
010ba49f 750d jne 0x1410ba4ae
010ba4a1 41f6c524 test r13b, 0x24
010ba4a5 7507 jne 0x1410ba4ae
010ba4a7 3bca cmp ecx, edx
010ba4a9 e920200000 jmp 0x1410bc4ce
010ba4ae 488b4610 mov rax, qword ptr [rsi + 0x10]
010ba4b2 41f6c504 test r13b, 4
010ba4b6 0f84eb000000 je 0x1410ba5a7
010ba4bc 4885c0 test rax, rax
010ba4bf 7467 je 0x1410ba528
010ba4c1 48638eb0000000 movsxd rcx, dword ptr [rsi + 0xb0]
010ba4c8 4c8d8078010000 lea r8, [rax + 0x178]
010ba4cf 448beb mov r13d, ebx
010ba4d2 4d85c0 test r8, r8
010ba4d5 744c je 0x1410ba523
010ba4d7 41813863727473 cmp dword ptr [r8], 0x73747263
010ba4de 7543 jne 0x1410ba523
010ba4e0 4139583c cmp dword ptr [r8 + 0x3c], ebx
010ba4e4 743d je 0x1410ba523
010ba4e6 83f901 cmp ecx, 1
010ba4e9 7c38 jl 0x1410ba523
010ba4eb 413b482c cmp ecx, dword ptr [r8 + 0x2c]
010ba4ef 7f32 jg 0x1410ba523
010ba4f1 498b4010 mov rax, qword ptr [r8 + 0x10]
010ba4f5 488bd1 mov rdx, rcx
010ba4f8 488b08 mov rcx, qword ptr [rax]
010ba4fb 488d42ff lea rax, [rdx - 1]
010ba4ff 488d04c1 lea rax, [rcx + rax*8]
010ba503 4885c0 test rax, rax
010ba506 741b je 0x1410ba523
010ba508 486308 movsxd rcx, dword ptr [rax]
010ba50b 85c9 test ecx, ecx
010ba50d 7814 js 0x1410ba523
010ba50f 8b5004 mov edx, dword ptr [rax + 4]
010ba512 85d2 test edx, edx
010ba514 7e0d jle 0x1410ba523
010ba516 498b4020 mov rax, qword ptr [r8 + 0x20]
010ba51a 4c8be1 mov r12, rcx
010ba51d 448bea mov r13d, edx
010ba520 4c0320 add r12, qword ptr [rax]
010ba523 41d1ed shr r13d, 1
010ba526 eb05 jmp 0x1410ba52d
010ba528 448b6c2430 mov r13d, dword ptr [rsp + 0x30]
010ba52d 4d85f6 test r14, r14
010ba530 0f844e020000 je 0x1410ba784
010ba536 4d8b4610 mov r8, qword ptr [r14 + 0x10]
010ba53a 4d85c0 test r8, r8
010ba53d 0f8441020000 je 0x1410ba784
010ba543 496386b0000000 movsxd rax, dword ptr [r14 + 0xb0]
010ba54a 8bfb mov edi, ebx
010ba54c 4981c078010000 add r8, 0x178
010ba553 744b je 0x1410ba5a0
010ba555 41813863727473 cmp dword ptr [r8], 0x73747263
010ba55c 7542 jne 0x1410ba5a0
010ba55e 4139583c cmp dword ptr [r8 + 0x3c], ebx
010ba562 743c je 0x1410ba5a0
010ba564 83f801 cmp eax, 1
010ba567 7c37 jl 0x1410ba5a0
010ba569 413b402c cmp eax, dword ptr [r8 + 0x2c]
010ba56d 7f31 jg 0x1410ba5a0
010ba56f 488bd0 mov rdx, rax
010ba572 498b4010 mov rax, qword ptr [r8 + 0x10]
010ba576 488b08 mov rcx, qword ptr [rax]
010ba579 488d42ff lea rax, [rdx - 1]
010ba57d 488d04c1 lea rax, [rcx + rax*8]
010ba581 4885c0 test rax, rax
010ba584 741a je 0x1410ba5a0
010ba586 486308 movsxd rcx, dword ptr [rax]
010ba589 85c9 test ecx, ecx
010ba58b 7813 js 0x1410ba5a0
010ba58d 8b5004 mov edx, dword ptr [rax + 4]
010ba590 85d2 test edx, edx
010ba592 7e0c jle 0x1410ba5a0
010ba594 498b4020 mov rax, qword ptr [r8 + 0x20]
010ba598 4c8bf9 mov r15, rcx
010ba59b 8bfa mov edi, edx
010ba59d 4c0338 add r15, qword ptr [rax]
010ba5a0 d1ef shr edi, 1
010ba5a2 e9e1010000 jmp 0x1410ba788
010ba5a7 4885c0 test rax, rax
010ba5aa 0f84e6000000 je 0x1410ba696
010ba5b0 4c639eb0000000 movsxd r11, dword ptr [rsi + 0xb0]
010ba5b7 4c8d9078010000 lea r10, [rax + 0x178]
010ba5be 4c8d8868170000 lea r9, [rax + 0x1768]
010ba5c5 448bc3 mov r8d, ebx
010ba5c8 48638660010000 movsxd rax, dword ptr [rsi + 0x160]
010ba5cf 448beb mov r13d, ebx
010ba5d2 85c0 test eax, eax
010ba5d4 7458 je 0x1410ba62e
010ba5d6 4d85c9 test r9, r9
010ba5d9 744d je 0x1410ba628
010ba5db 41813963727473 cmp dword ptr [r9], 0x73747263
010ba5e2 7544 jne 0x1410ba628
010ba5e4 4139593c cmp dword ptr [r9 + 0x3c], ebx
010ba5e8 743e je 0x1410ba628
010ba5ea 85c0 test eax, eax
010ba5ec 7e3a jle 0x1410ba628
010ba5ee 413b412c cmp eax, dword ptr [r9 + 0x2c]
010ba5f2 7f34 jg 0x1410ba628
010ba5f4 488bd0 mov rdx, rax
010ba5f7 498b4110 mov rax, qword ptr [r9 + 0x10]
010ba5fb 488b08 mov rcx, qword ptr [rax]
010ba5fe 488d42ff lea rax, [rdx - 1]
010ba602 488d04c1 lea rax, [rcx + rax*8]
010ba606 4885c0 test rax, rax
010ba609 741d je 0x1410ba628
010ba60b 486308 movsxd rcx, dword ptr [rax]
010ba60e 85c9 test ecx, ecx
010ba610 7816 js 0x1410ba628
010ba612 8b5004 mov edx, dword ptr [rax + 4]
010ba615 85d2 test edx, edx
010ba617 7e0f jle 0x1410ba628
010ba619 498b4120 mov rax, qword ptr [r9 + 0x20]
010ba61d 4c8be1 mov r12, rcx
010ba620 448bea mov r13d, edx
010ba623 4c0320 add r12, qword ptr [rax]
010ba626 eb06 jmp 0x1410ba62e
010ba628 41b8ceffffff mov r8d, 0xffffffce
010ba62e 4585ed test r13d, r13d
010ba631 7405 je 0x1410ba638
010ba633 4585c0 test r8d, r8d
010ba636 7459 je 0x1410ba691
010ba638 4585db test r11d, r11d
010ba63b 7454 je 0x1410ba691
010ba63d 448beb mov r13d, ebx
010ba640 4c8be3 mov r12, rbx
010ba643 4d85d2 test r10, r10
010ba646 7449 je 0x1410ba691
010ba648 41813a63727473 cmp dword ptr [r10], 0x73747263
010ba64f 7540 jne 0x1410ba691
010ba651 41395a3c cmp dword ptr [r10 + 0x3c], ebx
010ba655 743a je 0x1410ba691
010ba657 4585db test r11d, r11d
010ba65a 7e35 jle 0x1410ba691
010ba65c 453b5a2c cmp r11d, dword ptr [r10 + 0x2c]
010ba660 7f2f jg 0x1410ba691
010ba662 498b4210 mov rax, qword ptr [r10 + 0x10]
010ba666 488b08 mov rcx, qword ptr [rax]
010ba669 498d43ff lea rax, [r11 - 1]
010ba66d 488d04c1 lea rax, [rcx + rax*8]
010ba671 4885c0 test rax, rax
010ba674 741b je 0x1410ba691
010ba676 486308 movsxd rcx, dword ptr [rax]
010ba679 85c9 test ecx, ecx
010ba67b 7814 js 0x1410ba691
010ba67d 8b5004 mov edx, dword ptr [rax + 4]
010ba680 85d2 test edx, edx
010ba682 7e0d jle 0x1410ba691
010ba684 498b4220 mov rax, qword ptr [r10 + 0x20]
010ba688 4c8be1 mov r12, rcx
010ba68b 448bea mov r13d, edx
010ba68e 4c0320 add r12, qword ptr [rax]
010ba691 41d1ed shr r13d, 1
010ba694 eb05 jmp 0x1410ba69b
010ba696 448b6c2430 mov r13d, dword ptr [rsp + 0x30]
010ba69b 4d85f6 test r14, r14
010ba69e 0f84e0000000 je 0x1410ba784
010ba6a4 4d8b4e10 mov r9, qword ptr [r14 + 0x10]
010ba6a8 4d85c9 test r9, r9
010ba6ab 0f84d3000000 je 0x1410ba784
010ba6b1 49638e60010000 movsxd rcx, dword ptr [r14 + 0x160]
010ba6b8 4d8d8178010000 lea r8, [r9 + 0x178]
010ba6bf 4d6396b0000000 movsxd r10, dword ptr [r14 + 0xb0]
010ba6c6 4981c168170000 add r9, 0x1768
010ba6cd 8bd3 mov edx, ebx
010ba6cf 8bfb mov edi, ebx
010ba6d1 85c9 test ecx, ecx
010ba6d3 7452 je 0x1410ba727
010ba6d5 4d85c9 test r9, r9
010ba6d8 7448 je 0x1410ba722
010ba6da 41813963727473 cmp dword ptr [r9], 0x73747263
010ba6e1 753f jne 0x1410ba722
010ba6e3 4139593c cmp dword ptr [r9 + 0x3c], ebx
010ba6e7 7439 je 0x1410ba722
010ba6e9 85c9 test ecx, ecx
010ba6eb 7e35 jle 0x1410ba722
010ba6ed 413b492c cmp ecx, dword ptr [r9 + 0x2c]
010ba6f1 7f2f jg 0x1410ba722
010ba6f3 498b4110 mov rax, qword ptr [r9 + 0x10]
010ba6f7 4c8d59ff lea r11, [rcx - 1]
010ba6fb 488b00 mov rax, qword ptr [rax]
010ba6fe 4e8d1cd8 lea r11, [rax + r11*8]
010ba702 4d85db test r11, r11
010ba705 741b je 0x1410ba722
010ba707 41391b cmp dword ptr [r11], ebx
010ba70a 7c16 jl 0x1410ba722
010ba70c 418b4b04 mov ecx, dword ptr [r11 + 4]
010ba710 85c9 test ecx, ecx
010ba712 7e0e jle 0x1410ba722
010ba714 498b4120 mov rax, qword ptr [r9 + 0x20]
010ba718 8bf9 mov edi, ecx
010ba71a 4d633b movsxd r15, dword ptr [r11]
010ba71d 4c0338 add r15, qword ptr [rax]
010ba720 eb05 jmp 0x1410ba727
010ba722 baceffffff mov edx, 0xffffffce
010ba727 85ff test edi, edi
010ba729 7408 je 0x1410ba733
010ba72b 85d2 test edx, edx
010ba72d 0f846dfeffff je 0x1410ba5a0
010ba733 4585d2 test r10d, r10d
010ba736 0f8464feffff je 0x1410ba5a0
010ba73c 8bfb mov edi, ebx
010ba73e 4c8bfb mov r15, rbx
010ba741 4d85c0 test r8, r8
010ba744 0f8456feffff je 0x1410ba5a0
010ba74a 41813863727473 cmp dword ptr [r8], 0x73747263
010ba751 0f8549feffff jne 0x1410ba5a0
010ba757 4139583c cmp dword ptr [r8 + 0x3c], ebx
010ba75b 0f843ffeffff je 0x1410ba5a0
010ba761 4585d2 test r10d, r10d
010ba764 0f8e36feffff jle 0x1410ba5a0
010ba76a 453b502c cmp r10d, dword ptr [r8 + 0x2c]
010ba76e 0f8f2cfeffff jg 0x1410ba5a0
010ba774 498b4010 mov rax, qword ptr [r8 + 0x10]
010ba778 488b08 mov rcx, qword ptr [rax]
010ba77b 498d42ff lea rax, [r10 - 1]
010ba77f e9f9fdffff jmp 0x1410ba57d
010ba784 8b7c2434 mov edi, dword ptr [rsp + 0x34]
010ba788 488bce mov rcx, rsi
010ba78b e890efffff call 0x1410b9720
010ba790 84c0 test al, al
010ba792 7424 je 0x1410ba7b8
010ba794 498bce mov rcx, r14
010ba797 e884efffff call 0x1410b9720
010ba79c 84c0 test al, al
010ba79e 7418 je 0x1410ba7b8
010ba7a0 448bcf mov r9d, edi
010ba7a3 4d8bc7 mov r8, r15
010ba7a6 418bd5 mov edx, r13d
010ba7a9 498bcc mov rcx, r12
010ba7ac e82fe2ffff call 0x1410b89e0
010ba7b1 8bd8 mov ebx, eax
010ba7b3 e9b61f0000 jmp 0x1410bc76e
010ba7b8 448bcf mov r9d, edi
010ba7bb 4d8bc7 mov r8, r15
010ba7be 418bd5 mov edx, r13d
010ba7c1 498bcc mov rcx, r12
010ba7c4 e8b7dbffff call 0x1410b8380
010ba7c9 8bd8 mov ebx, eax
010ba7cb e99e1f0000 jmp 0x1410bc76e
010ba7d0 450fb78e0a010000 movzx r9d, word ptr [r14 + 0x10a]
010ba7d8 498bd6 mov rdx, r14
010ba7db 440fb7860a010000 movzx r8d, word ptr [rsi + 0x10a]
010ba7e3 488bce mov rcx, rsi
010ba7e6 885c2420 mov byte ptr [rsp + 0x20], bl
010ba7ea e811fbffff call 0x1410ba300
010ba7ef 8bd8 mov ebx, eax
010ba7f1 e9781f0000 jmp 0x1410bc76e
010ba7f6 8b8ee4000000 mov ecx, dword ptr [rsi + 0xe4]
010ba7fc bfffffffff mov edi, 0xffffffff
010ba801 85c9 test ecx, ecx
010ba803 742e je 0x1410ba833
010ba805 418b96e4000000 mov edx, dword ptr [r14 + 0xe4]
010ba80c 85d2 test edx, edx
010ba80e 7423 je 0x1410ba833
010ba810 498b4610 mov rax, qword ptr [r14 + 0x10]
010ba814 48394610 cmp qword ptr [rsi + 0x10], rax
010ba818 7519 jne 0x1410ba833
010ba81a 41f6c524 test r13b, 0x24
010ba81e 7513 jne 0x1410ba833
010ba820 3bca cmp ecx, edx
010ba822 7307 jae 0x1410ba82b
010ba824 8bdf mov ebx, edi
010ba826 e974010000 jmp 0x1410ba99f
010ba82b 0f97c3 seta bl
010ba82e e96c010000 jmp 0x1410ba99f
010ba833 41f6c504 test r13b, 4
010ba837 0f84e8000000 je 0x1410ba925
010ba83d 488b5610 mov rdx, qword ptr [rsi + 0x10]
010ba841 4885d2 test rdx, rdx
010ba844 7465 je 0x1410ba8ab
010ba846 48638ebc000000 movsxd rcx, dword ptr [rsi + 0xbc]
010ba84d 448bc3 mov r8d, ebx
010ba850 4881c2c0010000 add rdx, 0x1c0
010ba857 7448 je 0x1410ba8a1
010ba859 813a63727473 cmp dword ptr [rdx], 0x73747263
010ba85f 7540 jne 0x1410ba8a1
010ba861 395a3c cmp dword ptr [rdx + 0x3c], ebx
010ba864 743b je 0x1410ba8a1
010ba866 83f901 cmp ecx, 1
010ba869 7c36 jl 0x1410ba8a1
010ba86b 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010ba86e 7f31 jg 0x1410ba8a1
010ba870 488b4210 mov rax, qword ptr [rdx + 0x10]
010ba874 4c8d49ff lea r9, [rcx - 1]
010ba878 488b00 mov rax, qword ptr [rax]
010ba87b 4e8d0cc8 lea r9, [rax + r9*8]
010ba87f 4d85c9 test r9, r9
010ba882 741d je 0x1410ba8a1
010ba884 496309 movsxd rcx, dword ptr [r9]
010ba887 85c9 test ecx, ecx
010ba889 7816 js 0x1410ba8a1
010ba88b 458b5104 mov r10d, dword ptr [r9 + 4]
010ba88f 4585d2 test r10d, r10d
010ba892 7e0d jle 0x1410ba8a1
010ba894 488b4220 mov rax, qword ptr [rdx + 0x20]
010ba898 4c8be1 mov r12, rcx
010ba89b 458bc2 mov r8d, r10d
010ba89e 4c0320 add r12, qword ptr [rax]
010ba8a1 41d1e8 shr r8d, 1
010ba8a4 4489442430 mov dword ptr [rsp + 0x30], r8d
010ba8a9 eb08 jmp 0x1410ba8b3
010ba8ab 8b442430 mov eax, dword ptr [rsp + 0x30]
010ba8af 89442430 mov dword ptr [rsp + 0x30], eax
010ba8b3 4d85f6 test r14, r14
010ba8b6 0f849f000000 je 0x1410ba95b
010ba8bc 498b5610 mov rdx, qword ptr [r14 + 0x10]
010ba8c0 4885d2 test rdx, rdx
010ba8c3 0f8492000000 je 0x1410ba95b
010ba8c9 49638ebc000000 movsxd rcx, dword ptr [r14 + 0xbc]
010ba8d0 4881c2c0010000 add rdx, 0x1c0
010ba8d7 7448 je 0x1410ba921
010ba8d9 813a63727473 cmp dword ptr [rdx], 0x73747263
010ba8df 7540 jne 0x1410ba921
010ba8e1 395a3c cmp dword ptr [rdx + 0x3c], ebx
010ba8e4 743b je 0x1410ba921
010ba8e6 83f901 cmp ecx, 1
010ba8e9 7c36 jl 0x1410ba921
010ba8eb 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010ba8ee 7f31 jg 0x1410ba921
010ba8f0 488b4210 mov rax, qword ptr [rdx + 0x10]
010ba8f4 4c8d41ff lea r8, [rcx - 1]
010ba8f8 488b00 mov rax, qword ptr [rax]
010ba8fb 4e8d04c0 lea r8, [rax + r8*8]
010ba8ff 4d85c0 test r8, r8
010ba902 741d je 0x1410ba921
010ba904 496308 movsxd rcx, dword ptr [r8]
010ba907 85c9 test ecx, ecx
010ba909 7816 js 0x1410ba921
010ba90b 458b4804 mov r9d, dword ptr [r8 + 4]
010ba90f 4585c9 test r9d, r9d
010ba912 7e0d jle 0x1410ba921
010ba914 488b4220 mov rax, qword ptr [rdx + 0x20]
010ba918 4c8bf9 mov r15, rcx
010ba91b 418bd9 mov ebx, r9d
010ba91e 4c0338 add r15, qword ptr [rax]
010ba921 d1eb shr ebx, 1
010ba923 eb3a jmp 0x1410ba95f
010ba925 4c8d442430 lea r8, [rsp + 0x30]
010ba92a 488bce mov rcx, rsi
010ba92d 488d542440 lea rdx, [rsp + 0x40]
010ba932 e8e9cbedff call 0x140f97520
010ba937 4c8d442434 lea r8, [rsp + 0x34]
010ba93c 498bce mov rcx, r14
010ba93f 488d542448 lea rdx, [rsp + 0x48]
010ba944 e8d7cbedff call 0x140f97520
010ba949 8b442430 mov eax, dword ptr [rsp + 0x30]
010ba94d 4c8b642440 mov r12, qword ptr [rsp + 0x40]
010ba952 4c8b7c2448 mov r15, qword ptr [rsp + 0x48]
010ba957 89442430 mov dword ptr [rsp + 0x30], eax
010ba95b 8b5c2434 mov ebx, dword ptr [rsp + 0x34]
010ba95f 488bce mov rcx, rsi
010ba962 e819f0ffff call 0x1410b9980
010ba967 84c0 test al, al
010ba969 7420 je 0x1410ba98b
010ba96b 498bce mov rcx, r14
010ba96e e80df0ffff call 0x1410b9980
010ba973 84c0 test al, al
010ba975 7414 je 0x1410ba98b
010ba977 8b542430 mov edx, dword ptr [rsp + 0x30]
010ba97b 448bcb mov r9d, ebx
010ba97e 4d8bc7 mov r8, r15
010ba981 498bcc mov rcx, r12
010ba984 e857e0ffff call 0x1410b89e0
010ba989 eb12 jmp 0x1410ba99d
010ba98b 8b542430 mov edx, dword ptr [rsp + 0x30]
010ba98f 448bcb mov r9d, ebx
010ba992 4d8bc7 mov r8, r15
010ba995 498bcc mov rcx, r12
010ba998 e8e3d9ffff call 0x1410b8380
010ba99d 8bd8 mov ebx, eax
010ba99f 85db test ebx, ebx
010ba9a1 0f85c71d0000 jne 0x1410bc76e
010ba9a7 410fbae508 bt r13d, 8
010ba9ac 0f82bc1d0000 jb 0x1410bc76e
010ba9b2 0fb605833e0401 movzx eax, byte ptr [rip + 0x1043e83]
010ba9b9 84c0 test al, al
010ba9bb 7527 jne 0x1410ba9e4
010ba9bd 33d2 xor edx, edx
010ba9bf 488d0daaa0aa00 lea rcx, [rip + 0xaaa0aa]
010ba9c6 e88595a4ff call 0x140b03f50
010ba9cb 85c0 test eax, eax
010ba9cd 7409 je 0x1410ba9d8
010ba9cf c605663e040101 mov byte ptr [rip + 0x1043e66], 1
010ba9d6 eb14 jmp 0x1410ba9ec
010ba9d8 c6055d3e040102 mov byte ptr [rip + 0x1043e5d], 2
010ba9df e98a1d0000 jmp 0x1410bc76e
010ba9e4 3c01 cmp al, 1
010ba9e6 0f85821d0000 jne 0x1410bc76e
010ba9ec 410fb6869b000000 movzx eax, byte ptr [r14 + 0x9b]
010ba9f4 2404 and al, 4
010ba9f6 f6869b00000004 test byte ptr [rsi + 0x9b], 4
010ba9fd 7412 je 0x1410baa11
010ba9ff 84c0 test al, al
010baa01 0f85671d0000 jne 0x1410bc76e
010baa07 bb01000000 mov ebx, 1
010baa0c e95d1d0000 jmp 0x1410bc76e
010baa11 84c0 test al, al
010baa13 0f852d090000 jne 0x1410bb346
010baa19 458bcd mov r9d, r13d
010baa1c 41b804000000 mov r8d, 4
010baa22 498bd6 mov rdx, r14
010baa25 488bce mov rcx, rsi
010baa28 e8e3f9ffff call 0x1410ba410
010baa2d 8bd8 mov ebx, eax
010baa2f e93a1d0000 jmp 0x1410bc76e
010baa34 8b8ee8000000 mov ecx, dword ptr [rsi + 0xe8]
010baa3a 85c9 test ecx, ecx
010baa3c 7422 je 0x1410baa60
010baa3e 418b96e8000000 mov edx, dword ptr [r14 + 0xe8]
010baa45 85d2 test edx, edx
010baa47 7417 je 0x1410baa60
010baa49 498b4610 mov rax, qword ptr [r14 + 0x10]
010baa4d 48394610 cmp qword ptr [rsi + 0x10], rax
010baa51 750d jne 0x1410baa60
010baa53 41f6c524 test r13b, 0x24
010baa57 7507 jne 0x1410baa60
010baa59 3bca cmp ecx, edx
010baa5b e96e1a0000 jmp 0x1410bc4ce
010baa60 41f6c504 test r13b, 4
010baa64 0f84dd000000 je 0x1410bab47
010baa6a 488b5610 mov rdx, qword ptr [rsi + 0x10]
010baa6e 4885d2 test rdx, rdx
010baa71 745e je 0x1410baad1
010baa73 48638eb4000000 movsxd rcx, dword ptr [rsi + 0xb4]
010baa7a 8bfb mov edi, ebx
010baa7c 4881c208020000 add rdx, 0x208
010baa83 7448 je 0x1410baacd
010baa85 813a63727473 cmp dword ptr [rdx], 0x73747263
010baa8b 7540 jne 0x1410baacd
010baa8d 395a3c cmp dword ptr [rdx + 0x3c], ebx
010baa90 743b je 0x1410baacd
010baa92 83f901 cmp ecx, 1
010baa95 7c36 jl 0x1410baacd
010baa97 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010baa9a 7f31 jg 0x1410baacd
010baa9c 488b4210 mov rax, qword ptr [rdx + 0x10]
010baaa0 4c8d41ff lea r8, [rcx - 1]
010baaa4 488b00 mov rax, qword ptr [rax]
010baaa7 4e8d04c0 lea r8, [rax + r8*8]
010baaab 4d85c0 test r8, r8
010baaae 741d je 0x1410baacd
010baab0 496308 movsxd rcx, dword ptr [r8]
010baab3 85c9 test ecx, ecx
010baab5 7816 js 0x1410baacd
010baab7 458b4804 mov r9d, dword ptr [r8 + 4]
010baabb 4585c9 test r9d, r9d
010baabe 7e0d jle 0x1410baacd
010baac0 488b4220 mov rax, qword ptr [rdx + 0x20]
010baac4 4c8be1 mov r12, rcx
010baac7 418bf9 mov edi, r9d
010baaca 4c0320 add r12, qword ptr [rax]
010baacd d1ef shr edi, 1
010baacf eb04 jmp 0x1410baad5
010baad1 8b7c2430 mov edi, dword ptr [rsp + 0x30]
010baad5 4d85f6 test r14, r14
010baad8 0f849b000000 je 0x1410bab79
010baade 498b5610 mov rdx, qword ptr [r14 + 0x10]
010baae2 4885d2 test rdx, rdx
010baae5 0f848e000000 je 0x1410bab79
010baaeb 49638eb4000000 movsxd rcx, dword ptr [r14 + 0xb4]
010baaf2 4881c208020000 add rdx, 0x208
010baaf9 7448 je 0x1410bab43
010baafb 813a63727473 cmp dword ptr [rdx], 0x73747263
010bab01 7540 jne 0x1410bab43
010bab03 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bab06 743b je 0x1410bab43
010bab08 83f901 cmp ecx, 1
010bab0b 7c36 jl 0x1410bab43
010bab0d 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010bab10 7f31 jg 0x1410bab43
010bab12 488b4210 mov rax, qword ptr [rdx + 0x10]
010bab16 4c8d41ff lea r8, [rcx - 1]
010bab1a 488b00 mov rax, qword ptr [rax]
010bab1d 4e8d04c0 lea r8, [rax + r8*8]
010bab21 4d85c0 test r8, r8
010bab24 741d je 0x1410bab43
010bab26 496308 movsxd rcx, dword ptr [r8]
010bab29 85c9 test ecx, ecx
010bab2b 7816 js 0x1410bab43
010bab2d 458b4804 mov r9d, dword ptr [r8 + 4]
010bab31 4585c9 test r9d, r9d
010bab34 7e0d jle 0x1410bab43
010bab36 488b4220 mov rax, qword ptr [rdx + 0x20]
010bab3a 4c8bf9 mov r15, rcx
010bab3d 418bd9 mov ebx, r9d
010bab40 4c0338 add r15, qword ptr [rax]
010bab43 d1eb shr ebx, 1
010bab45 eb36 jmp 0x1410bab7d
010bab47 4c8d442430 lea r8, [rsp + 0x30]
010bab4c 488bce mov rcx, rsi
010bab4f 488d542440 lea rdx, [rsp + 0x40]
010bab54 e8a7d2edff call 0x140f97e00
010bab59 4c8d442434 lea r8, [rsp + 0x34]
010bab5e 498bce mov rcx, r14
010bab61 488d542448 lea rdx, [rsp + 0x48]
010bab66 e895d2edff call 0x140f97e00
010bab6b 4c8b642440 mov r12, qword ptr [rsp + 0x40]
010bab70 4c8b7c2448 mov r15, qword ptr [rsp + 0x48]
010bab75 8b7c2430 mov edi, dword ptr [rsp + 0x30]
010bab79 8b5c2434 mov ebx, dword ptr [rsp + 0x34]
010bab7d 488bce mov rcx, rsi
010bab80 e85bd5ffff call 0x1410b80e0
010bab85 84c0 test al, al
010bab87 7423 je 0x1410babac
010bab89 498bce mov rcx, r14
010bab8c e84fd5ffff call 0x1410b80e0
010bab91 84c0 test al, al
010bab93 7417 je 0x1410babac
010bab95 448bcb mov r9d, ebx
010bab98 4d8bc7 mov r8, r15
010bab9b 8bd7 mov edx, edi
010bab9d 498bcc mov rcx, r12
010baba0 e83bdeffff call 0x1410b89e0
010baba5 8bd8 mov ebx, eax
010baba7 e9c21b0000 jmp 0x1410bc76e
010babac 448bcb mov r9d, ebx
010babaf 4d8bc7 mov r8, r15
010babb2 8bd7 mov edx, edi
010babb4 498bcc mov rcx, r12
010babb7 e8c4d7ffff call 0x1410b8380
010babbc 8bd8 mov ebx, eax
010babbe e9ab1b0000 jmp 0x1410bc76e
010babc3 8b8ef4000000 mov ecx, dword ptr [rsi + 0xf4]
010babc9 85c9 test ecx, ecx
010babcb 7422 je 0x1410babef
010babcd 418b96f4000000 mov edx, dword ptr [r14 + 0xf4]
010babd4 85d2 test edx, edx
010babd6 7417 je 0x1410babef
010babd8 498b4610 mov rax, qword ptr [r14 + 0x10]
010babdc 48394610 cmp qword ptr [rsi + 0x10], rax
010babe0 750d jne 0x1410babef
010babe2 41f6c524 test r13b, 0x24
010babe6 7507 jne 0x1410babef
010babe8 3bca cmp ecx, edx
010babea e9df180000 jmp 0x1410bc4ce
010babef 41f6c504 test r13b, 4
010babf3 0f84e0000000 je 0x1410bacd9
010babf9 488b5610 mov rdx, qword ptr [rsi + 0x10]
010babfd 4885d2 test rdx, rdx
010bac00 7460 je 0x1410bac62
010bac02 48638eb8000000 movsxd rcx, dword ptr [rsi + 0xb8]
010bac09 448bd3 mov r10d, ebx
010bac0c 4881c208020000 add rdx, 0x208
010bac13 7448 je 0x1410bac5d
010bac15 813a63727473 cmp dword ptr [rdx], 0x73747263
010bac1b 7540 jne 0x1410bac5d
010bac1d 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bac20 743b je 0x1410bac5d
010bac22 83f901 cmp ecx, 1
010bac25 7c36 jl 0x1410bac5d
010bac27 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010bac2a 7f31 jg 0x1410bac5d
010bac2c 488b4210 mov rax, qword ptr [rdx + 0x10]
010bac30 4c8d41ff lea r8, [rcx - 1]
010bac34 488b00 mov rax, qword ptr [rax]
010bac37 4e8d04c0 lea r8, [rax + r8*8]
010bac3b 4d85c0 test r8, r8
010bac3e 741d je 0x1410bac5d
010bac40 496308 movsxd rcx, dword ptr [r8]
010bac43 85c9 test ecx, ecx
010bac45 7816 js 0x1410bac5d
010bac47 458b4804 mov r9d, dword ptr [r8 + 4]
010bac4b 4585c9 test r9d, r9d
010bac4e 7e0d jle 0x1410bac5d
010bac50 488b4220 mov rax, qword ptr [rdx + 0x20]
010bac54 4c8be1 mov r12, rcx
010bac57 458bd1 mov r10d, r9d
010bac5a 4c0320 add r12, qword ptr [rax]
010bac5d 41d1ea shr r10d, 1
010bac60 eb05 jmp 0x1410bac67
010bac62 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bac67 4d85f6 test r14, r14
010bac6a 0f849c000000 je 0x1410bad0c
010bac70 498b5610 mov rdx, qword ptr [r14 + 0x10]
010bac74 4885d2 test rdx, rdx
010bac77 0f848f000000 je 0x1410bad0c
010bac7d 49638eb8000000 movsxd rcx, dword ptr [r14 + 0xb8]
010bac84 4881c208020000 add rdx, 0x208
010bac8b 7448 je 0x1410bacd5
010bac8d 813a63727473 cmp dword ptr [rdx], 0x73747263
010bac93 7540 jne 0x1410bacd5
010bac95 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bac98 743b je 0x1410bacd5
010bac9a 83f901 cmp ecx, 1
010bac9d 7c36 jl 0x1410bacd5
010bac9f 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010baca2 7f31 jg 0x1410bacd5
010baca4 488b4210 mov rax, qword ptr [rdx + 0x10]
010baca8 4c8d41ff lea r8, [rcx - 1]
010bacac 488b00 mov rax, qword ptr [rax]
010bacaf 4e8d04c0 lea r8, [rax + r8*8]
010bacb3 4d85c0 test r8, r8
010bacb6 741d je 0x1410bacd5
010bacb8 496308 movsxd rcx, dword ptr [r8]
010bacbb 85c9 test ecx, ecx
010bacbd 7816 js 0x1410bacd5
010bacbf 458b4804 mov r9d, dword ptr [r8 + 4]
010bacc3 4585c9 test r9d, r9d
010bacc6 7e0d jle 0x1410bacd5
010bacc8 488b4220 mov rax, qword ptr [rdx + 0x20]
010baccc 4c8bf9 mov r15, rcx
010baccf 418bd9 mov ebx, r9d
010bacd2 4c0338 add r15, qword ptr [rax]
010bacd5 d1eb shr ebx, 1
010bacd7 eb37 jmp 0x1410bad10
010bacd9 4c8d442430 lea r8, [rsp + 0x30]
010bacde 488bce mov rcx, rsi
010bace1 488d542440 lea rdx, [rsp + 0x40]
010bace6 e825d9edff call 0x140f98610
010baceb 4c8d442434 lea r8, [rsp + 0x34]
010bacf0 498bce mov rcx, r14
010bacf3 488d542448 lea rdx, [rsp + 0x48]
010bacf8 e813d9edff call 0x140f98610
010bacfd 4c8b642440 mov r12, qword ptr [rsp + 0x40]
010bad02 4c8b7c2448 mov r15, qword ptr [rsp + 0x48]
010bad07 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bad0c 8b5c2434 mov ebx, dword ptr [rsp + 0x34]
010bad10 448bcb mov r9d, ebx
010bad13 418bd2 mov edx, r10d
010bad16 4d8bc7 mov r8, r15
010bad19 498bcc mov rcx, r12
010bad1c e85fd6ffff call 0x1410b8380
010bad21 8bd8 mov ebx, eax
010bad23 e9461a0000 jmp 0x1410bc76e
010bad28 8b8ef8000000 mov ecx, dword ptr [rsi + 0xf8]
010bad2e 85c9 test ecx, ecx
010bad30 7422 je 0x1410bad54
010bad32 418b96f8000000 mov edx, dword ptr [r14 + 0xf8]
010bad39 85d2 test edx, edx
010bad3b 7417 je 0x1410bad54
010bad3d 498b4610 mov rax, qword ptr [r14 + 0x10]
010bad41 48394610 cmp qword ptr [rsi + 0x10], rax
010bad45 750d jne 0x1410bad54
010bad47 41f6c524 test r13b, 0x24
010bad4b 7507 jne 0x1410bad54
010bad4d 3bca cmp ecx, edx
010bad4f e97a170000 jmp 0x1410bc4ce
010bad54 41f6c504 test r13b, 4
010bad58 0f84d7010000 je 0x1410baf35
010bad5e 4c8b4610 mov r8, qword ptr [rsi + 0x10]
010bad62 4d85c0 test r8, r8
010bad65 0f84d6000000 je 0x1410bae41
010bad6b 48638eb8000000 movsxd rcx, dword ptr [rsi + 0xb8]
010bad72 85c9 test ecx, ecx
010bad74 745c je 0x1410badd2
010bad76 498d9008020000 lea rdx, [r8 + 0x208]
010bad7d 8bfb mov edi, ebx
010bad7f 4885d2 test rdx, rdx
010bad82 7447 je 0x1410badcb
010bad84 813a63727473 cmp dword ptr [rdx], 0x73747263
010bad8a 753f jne 0x1410badcb
010bad8c 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bad8f 743a je 0x1410badcb
010bad91 85c9 test ecx, ecx
010bad93 7e36 jle 0x1410badcb
010bad95 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010bad98 7f31 jg 0x1410badcb
010bad9a 488b4210 mov rax, qword ptr [rdx + 0x10]
010bad9e 4c8d41ff lea r8, [rcx - 1]
010bada2 488b00 mov rax, qword ptr [rax]
010bada5 4e8d04c0 lea r8, [rax + r8*8]
010bada9 4d85c0 test r8, r8
010badac 741d je 0x1410badcb
010badae 496308 movsxd rcx, dword ptr [r8]
010badb1 85c9 test ecx, ecx
010badb3 7816 js 0x1410badcb
010badb5 458b4804 mov r9d, dword ptr [r8 + 4]
010badb9 4585c9 test r9d, r9d
010badbc 7e0d jle 0x1410badcb
010badbe 488b4220 mov rax, qword ptr [rdx + 0x20]
010badc2 4c8be1 mov r12, rcx
010badc5 418bf9 mov edi, r9d
010badc8 4c0320 add r12, qword ptr [rax]
010badcb d1ef shr edi, 1
010badcd 4032f6 xor sil, sil
010badd0 eb78 jmp 0x1410bae4a
010badd2 486386b4000000 movsxd rax, dword ptr [rsi + 0xb4]
010badd9 85c0 test eax, eax
010baddb 7464 je 0x1410bae41
010baddd 8bfb mov edi, ebx
010baddf 4981c008020000 add r8, 0x208
010bade6 744a je 0x1410bae32
010bade8 41813863727473 cmp dword ptr [r8], 0x73747263
010badef 7541 jne 0x1410bae32
010badf1 4139583c cmp dword ptr [r8 + 0x3c], ebx
010badf5 743b je 0x1410bae32
010badf7 85c0 test eax, eax
010badf9 7e37 jle 0x1410bae32
010badfb 413b402c cmp eax, dword ptr [r8 + 0x2c]
010badff 7f31 jg 0x1410bae32
010bae01 488bd0 mov rdx, rax
010bae04 498b4010 mov rax, qword ptr [r8 + 0x10]
010bae08 488b08 mov rcx, qword ptr [rax]
010bae0b 488d42ff lea rax, [rdx - 1]
010bae0f 488d04c1 lea rax, [rcx + rax*8]
010bae13 4885c0 test rax, rax
010bae16 741a je 0x1410bae32
010bae18 486308 movsxd rcx, dword ptr [rax]
010bae1b 85c9 test ecx, ecx
010bae1d 7813 js 0x1410bae32
010bae1f 8b5004 mov edx, dword ptr [rax + 4]
010bae22 85d2 test edx, edx
010bae24 7e0c jle 0x1410bae32
010bae26 498b4020 mov rax, qword ptr [r8 + 0x20]
010bae2a 4c8be1 mov r12, rcx
010bae2d 8bfa mov edi, edx
010bae2f 4c0320 add r12, qword ptr [rax]
010bae32 d1ef shr edi, 1
010bae34 488bce mov rcx, rsi
010bae37 e8a4d2ffff call 0x1410b80e0
010bae3c 0fb6f0 movzx esi, al
010bae3f eb09 jmp 0x1410bae4a
010bae41 8b7c2430 mov edi, dword ptr [rsp + 0x30]
010bae45 0fb6742438 movzx esi, byte ptr [rsp + 0x38]
010bae4a 4d85f6 test r14, r14
010bae4d 0f8423010000 je 0x1410baf76
010bae53 4d8b4610 mov r8, qword ptr [r14 + 0x10]
010bae57 4d85c0 test r8, r8
010bae5a 0f8416010000 je 0x1410baf76
010bae60 496386b8000000 movsxd rax, dword ptr [r14 + 0xb8]
010bae67 85c0 test eax, eax
010bae69 745c je 0x1410baec7
010bae6b 4981c008020000 add r8, 0x208
010bae72 744a je 0x1410baebe
010bae74 41813863727473 cmp dword ptr [r8], 0x73747263
010bae7b 7541 jne 0x1410baebe
010bae7d 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bae81 743b je 0x1410baebe
010bae83 85c0 test eax, eax
010bae85 7e37 jle 0x1410baebe
010bae87 413b402c cmp eax, dword ptr [r8 + 0x2c]
010bae8b 7f31 jg 0x1410baebe
010bae8d 488bd0 mov rdx, rax
010bae90 498b4010 mov rax, qword ptr [r8 + 0x10]
010bae94 488b08 mov rcx, qword ptr [rax]
010bae97 488d42ff lea rax, [rdx - 1]
010bae9b 488d04c1 lea rax, [rcx + rax*8]
010bae9f 4885c0 test rax, rax
010baea2 741a je 0x1410baebe
010baea4 486308 movsxd rcx, dword ptr [rax]
010baea7 85c9 test ecx, ecx
010baea9 7813 js 0x1410baebe
010baeab 8b5004 mov edx, dword ptr [rax + 4]
010baeae 85d2 test edx, edx
010baeb0 7e0c jle 0x1410baebe
010baeb2 498b4020 mov rax, qword ptr [r8 + 0x20]
010baeb6 4c8bf9 mov r15, rcx
010baeb9 8bda mov ebx, edx
010baebb 4c0338 add r15, qword ptr [rax]
010baebe d1eb shr ebx, 1
010baec0 32c0 xor al, al
010baec2 e9b8000000 jmp 0x1410baf7f
010baec7 496386b4000000 movsxd rax, dword ptr [r14 + 0xb4]
010baece 85c0 test eax, eax
010baed0 0f84a0000000 je 0x1410baf76
010baed6 4981c008020000 add r8, 0x208
010baedd 744a je 0x1410baf29
010baedf 41813863727473 cmp dword ptr [r8], 0x73747263
010baee6 7541 jne 0x1410baf29
010baee8 4139583c cmp dword ptr [r8 + 0x3c], ebx
010baeec 743b je 0x1410baf29
010baeee 85c0 test eax, eax
010baef0 7e37 jle 0x1410baf29
010baef2 413b402c cmp eax, dword ptr [r8 + 0x2c]
010baef6 7f31 jg 0x1410baf29
010baef8 488bd0 mov rdx, rax
010baefb 498b4010 mov rax, qword ptr [r8 + 0x10]
010baeff 488b08 mov rcx, qword ptr [rax]
010baf02 488d42ff lea rax, [rdx - 1]
010baf06 488d04c1 lea rax, [rcx + rax*8]
010baf0a 4885c0 test rax, rax
010baf0d 741a je 0x1410baf29
010baf0f 486308 movsxd rcx, dword ptr [rax]
010baf12 85c9 test ecx, ecx
010baf14 7813 js 0x1410baf29
010baf16 8b5004 mov edx, dword ptr [rax + 4]
010baf19 85d2 test edx, edx
010baf1b 7e0c jle 0x1410baf29
010baf1d 498b4020 mov rax, qword ptr [r8 + 0x20]
010baf21 4c8bf9 mov r15, rcx
010baf24 8bda mov ebx, edx
010baf26 4c0338 add r15, qword ptr [rax]
010baf29 d1eb shr ebx, 1
010baf2b 498bce mov rcx, r14
010baf2e e8add1ffff call 0x1410b80e0
010baf33 eb4a jmp 0x1410baf7f
010baf35 4c8d4c2438 lea r9, [rsp + 0x38]
010baf3a 488bce mov rcx, rsi
010baf3d 4c8d442430 lea r8, [rsp + 0x30]
010baf42 488d542440 lea rdx, [rsp + 0x40]
010baf47 e854d9edff call 0x140f988a0
010baf4c 4c8d4c2439 lea r9, [rsp + 0x39]
010baf51 498bce mov rcx, r14
010baf54 4c8d442434 lea r8, [rsp + 0x34]
010baf59 488d542448 lea rdx, [rsp + 0x48]
010baf5e e83dd9edff call 0x140f988a0
010baf63 4c8b642440 mov r12, qword ptr [rsp + 0x40]
010baf68 4c8b7c2448 mov r15, qword ptr [rsp + 0x48]
010baf6d 8b7c2430 mov edi, dword ptr [rsp + 0x30]
010baf71 0fb6742438 movzx esi, byte ptr [rsp + 0x38]
010baf76 0fb6442439 movzx eax, byte ptr [rsp + 0x39]
010baf7b 8b5c2434 mov ebx, dword ptr [rsp + 0x34]
010baf7f 4084f6 test sil, sil
010baf82 0f8424fcffff je 0x1410babac
010baf88 e904fcffff jmp 0x1410bab91
010baf8d f6869b00000004 test byte ptr [rsi + 0x9b], 4
010baf94 66899d70070000 mov word ptr [rbp + 0x770], bx
010baf9b 742b je 0x1410bafc8
010baf9d b901008000 mov ecx, 0x800001
010bafa2 e8293aa4ff call 0x140afe9d0
010bafa7 488d9570070000 lea rdx, [rbp + 0x770]
010bafae 488bc8 mov rcx, rax
010bafb1 e87ab4a2ff call 0x140ae6430
010bafb6 0fb79d70070000 movzx ebx, word ptr [rbp + 0x770]
010bafbd 488dbd72070000 lea rdi, [rbp + 0x772]
010bafc4 8bf3 mov esi, ebx
010bafc6 eb1b jmp 0x1410bafe3
010bafc8 4c8d442430 lea r8, [rsp + 0x30]
010bafcd 488bce mov rcx, rsi
010bafd0 488d542440 lea rdx, [rsp + 0x40]
010bafd5 e826ceedff call 0x140f97e00
010bafda 488b7c2440 mov rdi, qword ptr [rsp + 0x40]
010bafdf 8b742430 mov esi, dword ptr [rsp + 0x30]
010bafe3 41f6869b00000004 test byte ptr [r14 + 0x9b], 4
010bafeb 7441 je 0x1410bb02e
010bafed 6685db test bx, bx
010baff0 7520 jne 0x1410bb012
010baff2 b901008000 mov ecx, 0x800001
010baff7 e8d439a4ff call 0x140afe9d0
010baffc 488d9570070000 lea rdx, [rbp + 0x770]
010bb003 488bc8 mov rcx, rax
010bb006 e825b4a2ff call 0x140ae6430
010bb00b 0fb79d70070000 movzx ebx, word ptr [rbp + 0x770]
010bb012 4c8d8572070000 lea r8, [rbp + 0x772]
010bb019 440fb7cb movzx r9d, bx
010bb01d 8bd6 mov edx, esi
010bb01f 488bcf mov rcx, rdi
010bb022 e859d3ffff call 0x1410b8380
010bb027 8bd8 mov ebx, eax
010bb029 e940170000 jmp 0x1410bc76e
010bb02e 4c8d442434 lea r8, [rsp + 0x34]
010bb033 498bce mov rcx, r14
010bb036 488d542448 lea rdx, [rsp + 0x48]
010bb03b e8c0cdedff call 0x140f97e00
010bb040 4c8b442448 mov r8, qword ptr [rsp + 0x48]
010bb045 8bd6 mov edx, esi
010bb047 448b4c2434 mov r9d, dword ptr [rsp + 0x34]
010bb04c 488bcf mov rcx, rdi
010bb04f e82cd3ffff call 0x1410b8380
010bb054 8bd8 mov ebx, eax
010bb056 e913170000 jmp 0x1410bc76e
010bb05b 8b8ef0000000 mov ecx, dword ptr [rsi + 0xf0]
010bb061 85c9 test ecx, ecx
010bb063 7422 je 0x1410bb087
010bb065 418b96f0000000 mov edx, dword ptr [r14 + 0xf0]
010bb06c 85d2 test edx, edx
010bb06e 7417 je 0x1410bb087
010bb070 498b4610 mov rax, qword ptr [r14 + 0x10]
010bb074 48394610 cmp qword ptr [rsi + 0x10], rax
010bb078 750d jne 0x1410bb087
010bb07a 41f6c524 test r13b, 0x24
010bb07e 7507 jne 0x1410bb087
010bb080 3bca cmp ecx, edx
010bb082 e947140000 jmp 0x1410bc4ce
010bb087 41f6c504 test r13b, 4
010bb08b 0f8490000000 je 0x1410bb121
010bb091 488b5610 mov rdx, qword ptr [rsi + 0x10]
010bb095 4885d2 test rdx, rdx
010bb098 7460 je 0x1410bb0fa
010bb09a 48638ec4000000 movsxd rcx, dword ptr [rsi + 0xc4]
010bb0a1 448bd3 mov r10d, ebx
010bb0a4 4881c208020000 add rdx, 0x208
010bb0ab 7448 je 0x1410bb0f5
010bb0ad 813a63727473 cmp dword ptr [rdx], 0x73747263
010bb0b3 7540 jne 0x1410bb0f5
010bb0b5 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bb0b8 743b je 0x1410bb0f5
010bb0ba 83f901 cmp ecx, 1
010bb0bd 7c36 jl 0x1410bb0f5
010bb0bf 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010bb0c2 7f31 jg 0x1410bb0f5
010bb0c4 488b4210 mov rax, qword ptr [rdx + 0x10]
010bb0c8 4c8d41ff lea r8, [rcx - 1]
010bb0cc 488b00 mov rax, qword ptr [rax]
010bb0cf 4e8d04c0 lea r8, [rax + r8*8]
010bb0d3 4d85c0 test r8, r8
010bb0d6 741d je 0x1410bb0f5
010bb0d8 496308 movsxd rcx, dword ptr [r8]
010bb0db 85c9 test ecx, ecx
010bb0dd 7816 js 0x1410bb0f5
010bb0df 458b4804 mov r9d, dword ptr [r8 + 4]
010bb0e3 4585c9 test r9d, r9d
010bb0e6 7e0d jle 0x1410bb0f5
010bb0e8 488b4220 mov rax, qword ptr [rdx + 0x20]
010bb0ec 4c8be1 mov r12, rcx
010bb0ef 458bd1 mov r10d, r9d
010bb0f2 4c0320 add r12, qword ptr [rax]
010bb0f5 41d1ea shr r10d, 1
010bb0f8 eb05 jmp 0x1410bb0ff
010bb0fa 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bb0ff 4d85f6 test r14, r14
010bb102 0f8404fcffff je 0x1410bad0c
010bb108 498b5610 mov rdx, qword ptr [r14 + 0x10]
010bb10c 4885d2 test rdx, rdx
010bb10f 0f84f7fbffff je 0x1410bad0c
010bb115 49638ec4000000 movsxd rcx, dword ptr [r14 + 0xc4]
010bb11c e963fbffff jmp 0x1410bac84
010bb121 4c8d442430 lea r8, [rsp + 0x30]
010bb126 488bce mov rcx, rsi
010bb129 488d542440 lea rdx, [rsp + 0x40]
010bb12e e8cd1aeeff call 0x140f9cc00
010bb133 4c8d442434 lea r8, [rsp + 0x34]
010bb138 498bce mov rcx, r14
010bb13b 488d542448 lea rdx, [rsp + 0x48]
010bb140 e8bb1aeeff call 0x140f9cc00
010bb145 e9b3fbffff jmp 0x1410bacfd
010bb14a 8b8eec000000 mov ecx, dword ptr [rsi + 0xec]
010bb150 85c9 test ecx, ecx
010bb152 7422 je 0x1410bb176
010bb154 418b96ec000000 mov edx, dword ptr [r14 + 0xec]
010bb15b 85d2 test edx, edx
010bb15d 7417 je 0x1410bb176
010bb15f 498b4610 mov rax, qword ptr [r14 + 0x10]
010bb163 48394610 cmp qword ptr [rsi + 0x10], rax
010bb167 750d jne 0x1410bb176
010bb169 41f6c524 test r13b, 0x24
010bb16d 7507 jne 0x1410bb176
010bb16f 3bca cmp ecx, edx
010bb171 e958130000 jmp 0x1410bc4ce
010bb176 4c8b4610 mov r8, qword ptr [rsi + 0x10]
010bb17a 4d85c0 test r8, r8
010bb17d 7461 je 0x1410bb1e0
010bb17f 486386c8000000 movsxd rax, dword ptr [rsi + 0xc8]
010bb186 8bfb mov edi, ebx
010bb188 4981c028030000 add r8, 0x328
010bb18f 744b je 0x1410bb1dc
010bb191 41813863727473 cmp dword ptr [r8], 0x73747263
010bb198 7542 jne 0x1410bb1dc
010bb19a 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bb19e 743c je 0x1410bb1dc
010bb1a0 83f801 cmp eax, 1
010bb1a3 7c37 jl 0x1410bb1dc
010bb1a5 413b402c cmp eax, dword ptr [r8 + 0x2c]
010bb1a9 7f31 jg 0x1410bb1dc
010bb1ab 488bd0 mov rdx, rax
010bb1ae 498b4010 mov rax, qword ptr [r8 + 0x10]
010bb1b2 488b08 mov rcx, qword ptr [rax]
010bb1b5 488d42ff lea rax, [rdx - 1]
010bb1b9 488d04c1 lea rax, [rcx + rax*8]
010bb1bd 4885c0 test rax, rax
010bb1c0 741a je 0x1410bb1dc
010bb1c2 486308 movsxd rcx, dword ptr [rax]
010bb1c5 85c9 test ecx, ecx
010bb1c7 7813 js 0x1410bb1dc
010bb1c9 8b5004 mov edx, dword ptr [rax + 4]
010bb1cc 85d2 test edx, edx
010bb1ce 7e0c jle 0x1410bb1dc
010bb1d0 498b4020 mov rax, qword ptr [r8 + 0x20]
010bb1d4 4c8be1 mov r12, rcx
010bb1d7 8bfa mov edi, edx
010bb1d9 4c0320 add r12, qword ptr [rax]
010bb1dc d1ef shr edi, 1
010bb1de eb04 jmp 0x1410bb1e4
010bb1e0 8b7c2430 mov edi, dword ptr [rsp + 0x30]
010bb1e4 4d85f6 test r14, r14
010bb1e7 7468 je 0x1410bb251
010bb1e9 4d8b4610 mov r8, qword ptr [r14 + 0x10]
010bb1ed 4d85c0 test r8, r8
010bb1f0 745f je 0x1410bb251
010bb1f2 496386c8000000 movsxd rax, dword ptr [r14 + 0xc8]
010bb1f9 4981c028030000 add r8, 0x328
010bb200 744b je 0x1410bb24d
010bb202 41813863727473 cmp dword ptr [r8], 0x73747263
010bb209 7542 jne 0x1410bb24d
010bb20b 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bb20f 743c je 0x1410bb24d
010bb211 83f801 cmp eax, 1
010bb214 7c37 jl 0x1410bb24d
010bb216 413b402c cmp eax, dword ptr [r8 + 0x2c]
010bb21a 7f31 jg 0x1410bb24d
010bb21c 488bd0 mov rdx, rax
010bb21f 498b4010 mov rax, qword ptr [r8 + 0x10]
010bb223 488b08 mov rcx, qword ptr [rax]
010bb226 488d42ff lea rax, [rdx - 1]
010bb22a 488d04c1 lea rax, [rcx + rax*8]
010bb22e 4885c0 test rax, rax
010bb231 741a je 0x1410bb24d
010bb233 486308 movsxd rcx, dword ptr [rax]
010bb236 85c9 test ecx, ecx
010bb238 7813 js 0x1410bb24d
010bb23a 8b5004 mov edx, dword ptr [rax + 4]
010bb23d 85d2 test edx, edx
010bb23f 7e0c jle 0x1410bb24d
010bb241 498b4020 mov rax, qword ptr [r8 + 0x20]
010bb245 4c8bf9 mov r15, rcx
010bb248 8bda mov ebx, edx
010bb24a 4c0338 add r15, qword ptr [rax]
010bb24d d1eb shr ebx, 1
010bb24f eb04 jmp 0x1410bb255
010bb251 8b5c2434 mov ebx, dword ptr [rsp + 0x34]
010bb255 488bce mov rcx, rsi
010bb258 e883e9ffff call 0x1410b9be0
010bb25d 84c0 test al, al
010bb25f 0f8447f9ffff je 0x1410babac
010bb265 498bce mov rcx, r14
010bb268 e873e9ffff call 0x1410b9be0
010bb26d e91ff9ffff jmp 0x1410bab91
010bb272 4885f6 test rsi, rsi
010bb275 7469 je 0x1410bb2e0
010bb277 488b5610 mov rdx, qword ptr [rsi + 0x10]
010bb27b 4885d2 test rdx, rdx
010bb27e 7460 je 0x1410bb2e0
010bb280 48638ecc000000 movsxd rcx, dword ptr [rsi + 0xcc]
010bb287 448bd3 mov r10d, ebx
010bb28a 4881c270030000 add rdx, 0x370
010bb291 7448 je 0x1410bb2db
010bb293 813a63727473 cmp dword ptr [rdx], 0x73747263
010bb299 7540 jne 0x1410bb2db
010bb29b 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bb29e 743b je 0x1410bb2db
010bb2a0 83f901 cmp ecx, 1
010bb2a3 7c36 jl 0x1410bb2db
010bb2a5 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010bb2a8 7f31 jg 0x1410bb2db
010bb2aa 488b4210 mov rax, qword ptr [rdx + 0x10]
010bb2ae 4c8d41ff lea r8, [rcx - 1]
010bb2b2 488b00 mov rax, qword ptr [rax]
010bb2b5 4e8d04c0 lea r8, [rax + r8*8]
010bb2b9 4d85c0 test r8, r8
010bb2bc 741d je 0x1410bb2db
010bb2be 496308 movsxd rcx, dword ptr [r8]
010bb2c1 85c9 test ecx, ecx
010bb2c3 7816 js 0x1410bb2db
010bb2c5 458b4804 mov r9d, dword ptr [r8 + 4]
010bb2c9 4585c9 test r9d, r9d
010bb2cc 7e0d jle 0x1410bb2db
010bb2ce 488b4220 mov rax, qword ptr [rdx + 0x20]
010bb2d2 4c8be1 mov r12, rcx
010bb2d5 458bd1 mov r10d, r9d
010bb2d8 4c0320 add r12, qword ptr [rax]
010bb2db 41d1ea shr r10d, 1
010bb2de eb05 jmp 0x1410bb2e5
010bb2e0 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bb2e5 4d85f6 test r14, r14
010bb2e8 0f841efaffff je 0x1410bad0c
010bb2ee 498b5610 mov rdx, qword ptr [r14 + 0x10]
010bb2f2 4885d2 test rdx, rdx
010bb2f5 0f8411faffff je 0x1410bad0c
010bb2fb 49638ecc000000 movsxd rcx, dword ptr [r14 + 0xcc]
010bb302 4881c270030000 add rdx, 0x370
010bb309 e97df9ffff jmp 0x1410bac8b
010bb30e 410fb796a6000000 movzx edx, word ptr [r14 + 0xa6]
010bb316 0fb78ea6000000 movzx ecx, word ptr [rsi + 0xa6]
010bb31d 41f6c508 test r13b, 8
010bb321 740c je 0x1410bb32f
010bb323 e848260000 call 0x1410bd970
010bb328 8bd8 mov ebx, eax
010bb32a e93f140000 jmp 0x1410bc76e
010bb32f 663bca cmp cx, dx
010bb332 730c jae 0x1410bb340
010bb334 bfffffffff mov edi, 0xffffffff
010bb339 8bdf mov ebx, edi
010bb33b e92e140000 jmp 0x1410bc76e
010bb340 8bfb mov edi, ebx
010bb342 400f97c7 seta dil
010bb346 8bdf mov ebx, edi
010bb348 e921140000 jmp 0x1410bc76e
010bb34d 418b4608 mov eax, dword ptr [r14 + 8]
010bb351 394608 cmp dword ptr [rsi + 8], eax
010bb354 73ea jae 0x1410bb340
010bb356 bfffffffff mov edi, 0xffffffff
010bb35b 8bdf mov ebx, edi
010bb35d e90c140000 jmp 0x1410bc76e
010bb362 4885f6 test rsi, rsi
010bb365 7469 je 0x1410bb3d0
010bb367 488b5610 mov rdx, qword ptr [rsi + 0x10]
010bb36b 4885d2 test rdx, rdx
010bb36e 7460 je 0x1410bb3d0
010bb370 48638ed8000000 movsxd rcx, dword ptr [rsi + 0xd8]
010bb377 448bd3 mov r10d, ebx
010bb37a 4881c248040000 add rdx, 0x448
010bb381 7448 je 0x1410bb3cb
010bb383 813a63727473 cmp dword ptr [rdx], 0x73747263
010bb389 7540 jne 0x1410bb3cb
010bb38b 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bb38e 743b je 0x1410bb3cb
010bb390 83f901 cmp ecx, 1
010bb393 7c36 jl 0x1410bb3cb
010bb395 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010bb398 7f31 jg 0x1410bb3cb
010bb39a 488b4210 mov rax, qword ptr [rdx + 0x10]
010bb39e 4c8d41ff lea r8, [rcx - 1]
010bb3a2 488b00 mov rax, qword ptr [rax]
010bb3a5 4e8d04c0 lea r8, [rax + r8*8]
010bb3a9 4d85c0 test r8, r8
010bb3ac 741d je 0x1410bb3cb
010bb3ae 496308 movsxd rcx, dword ptr [r8]
010bb3b1 85c9 test ecx, ecx
010bb3b3 7816 js 0x1410bb3cb
010bb3b5 458b4804 mov r9d, dword ptr [r8 + 4]
010bb3b9 4585c9 test r9d, r9d
010bb3bc 7e0d jle 0x1410bb3cb
010bb3be 488b4220 mov rax, qword ptr [rdx + 0x20]
010bb3c2 4c8be1 mov r12, rcx
010bb3c5 458bd1 mov r10d, r9d
010bb3c8 4c0320 add r12, qword ptr [rax]
010bb3cb 41d1ea shr r10d, 1
010bb3ce eb05 jmp 0x1410bb3d5
010bb3d0 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bb3d5 4d85f6 test r14, r14
010bb3d8 0f842ef9ffff je 0x1410bad0c
010bb3de 498b5610 mov rdx, qword ptr [r14 + 0x10]
010bb3e2 4885d2 test rdx, rdx
010bb3e5 0f8421f9ffff je 0x1410bad0c
010bb3eb 49638ed8000000 movsxd rcx, dword ptr [r14 + 0xd8]
010bb3f2 4881c248040000 add rdx, 0x448
010bb3f9 e98df8ffff jmp 0x1410bac8b
010bb3fe 4885f6 test rsi, rsi
010bb401 7469 je 0x1410bb46c
010bb403 488b5610 mov rdx, qword ptr [rsi + 0x10]
010bb407 4885d2 test rdx, rdx
010bb40a 7460 je 0x1410bb46c
010bb40c 48638ed4000000 movsxd rcx, dword ptr [rsi + 0xd4]
010bb413 448bd3 mov r10d, ebx
010bb416 4881c200040000 add rdx, 0x400
010bb41d 7448 je 0x1410bb467
010bb41f 813a63727473 cmp dword ptr [rdx], 0x73747263
010bb425 7540 jne 0x1410bb467
010bb427 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bb42a 743b je 0x1410bb467
010bb42c 83f901 cmp ecx, 1
010bb42f 7c36 jl 0x1410bb467
010bb431 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010bb434 7f31 jg 0x1410bb467
010bb436 488b4210 mov rax, qword ptr [rdx + 0x10]
010bb43a 4c8d41ff lea r8, [rcx - 1]
010bb43e 488b00 mov rax, qword ptr [rax]
010bb441 4e8d04c0 lea r8, [rax + r8*8]
010bb445 4d85c0 test r8, r8
010bb448 741d je 0x1410bb467
010bb44a 496308 movsxd rcx, dword ptr [r8]
010bb44d 85c9 test ecx, ecx
010bb44f 7816 js 0x1410bb467
010bb451 458b4804 mov r9d, dword ptr [r8 + 4]
010bb455 4585c9 test r9d, r9d
010bb458 7e0d jle 0x1410bb467
010bb45a 488b4220 mov rax, qword ptr [rdx + 0x20]
010bb45e 4c8be1 mov r12, rcx
010bb461 458bd1 mov r10d, r9d
010bb464 4c0320 add r12, qword ptr [rax]
010bb467 41d1ea shr r10d, 1
010bb46a eb05 jmp 0x1410bb471
010bb46c 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bb471 4d85f6 test r14, r14
010bb474 0f8492f8ffff je 0x1410bad0c
010bb47a 4d8b4610 mov r8, qword ptr [r14 + 0x10]
010bb47e 4d85c0 test r8, r8
010bb481 0f8485f8ffff je 0x1410bad0c
010bb487 496386d4000000 movsxd rax, dword ptr [r14 + 0xd4]
010bb48e 4981c000040000 add r8, 0x400
010bb495 0f843af8ffff je 0x1410bacd5
010bb49b 41813863727473 cmp dword ptr [r8], 0x73747263
010bb4a2 0f852df8ffff jne 0x1410bacd5
010bb4a8 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bb4ac 0f8423f8ffff je 0x1410bacd5
010bb4b2 83f801 cmp eax, 1
010bb4b5 0f8c1af8ffff jl 0x1410bacd5
010bb4bb 413b402c cmp eax, dword ptr [r8 + 0x2c]
010bb4bf 0f8f10f8ffff jg 0x1410bacd5
010bb4c5 488bd0 mov rdx, rax
010bb4c8 498b4010 mov rax, qword ptr [r8 + 0x10]
010bb4cc 488b08 mov rcx, qword ptr [rax]
010bb4cf 488d42ff lea rax, [rdx - 1]
010bb4d3 488d04c1 lea rax, [rcx + rax*8]
010bb4d7 4885c0 test rax, rax
010bb4da 0f84f5f7ffff je 0x1410bacd5
010bb4e0 486308 movsxd rcx, dword ptr [rax]
010bb4e3 85c9 test ecx, ecx
010bb4e5 0f88eaf7ffff js 0x1410bacd5
010bb4eb 8b5004 mov edx, dword ptr [rax + 4]
010bb4ee 85d2 test edx, edx
010bb4f0 0f8edff7ffff jle 0x1410bacd5
010bb4f6 498b4020 mov rax, qword ptr [r8 + 0x20]
010bb4fa 4c8bf9 mov r15, rcx
010bb4fd 8bda mov ebx, edx
010bb4ff 4c0338 add r15, qword ptr [rax]
010bb502 d1eb shr ebx, 1
010bb504 e907f8ffff jmp 0x1410bad10
010bb509 4885f6 test rsi, rsi
010bb50c 746e je 0x1410bb57c
010bb50e 4c8b4610 mov r8, qword ptr [rsi + 0x10]
010bb512 4d85c0 test r8, r8
010bb515 7465 je 0x1410bb57c
010bb517 488b4668 mov rax, qword ptr [rsi + 0x68]
010bb51b 448bd3 mov r10d, ebx
010bb51e 48634834 movsxd rcx, dword ptr [rax + 0x34]
010bb522 4981c020050000 add r8, 0x520
010bb529 744c je 0x1410bb577
010bb52b 41813863727473 cmp dword ptr [r8], 0x73747263
010bb532 7543 jne 0x1410bb577
010bb534 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bb538 743d je 0x1410bb577
010bb53a 83f901 cmp ecx, 1
010bb53d 7c38 jl 0x1410bb577
010bb53f 413b482c cmp ecx, dword ptr [r8 + 0x2c]
010bb543 7f32 jg 0x1410bb577
010bb545 498b4010 mov rax, qword ptr [r8 + 0x10]
010bb549 488bd1 mov rdx, rcx
010bb54c 488b08 mov rcx, qword ptr [rax]
010bb54f 488d42ff lea rax, [rdx - 1]
010bb553 488d04c1 lea rax, [rcx + rax*8]
010bb557 4885c0 test rax, rax
010bb55a 741b je 0x1410bb577
010bb55c 486308 movsxd rcx, dword ptr [rax]
010bb55f 85c9 test ecx, ecx
010bb561 7814 js 0x1410bb577
010bb563 8b5004 mov edx, dword ptr [rax + 4]
010bb566 85d2 test edx, edx
010bb568 7e0d jle 0x1410bb577
010bb56a 498b4020 mov rax, qword ptr [r8 + 0x20]
010bb56e 4c8be1 mov r12, rcx
010bb571 448bd2 mov r10d, edx
010bb574 4c0320 add r12, qword ptr [rax]
010bb577 41d1ea shr r10d, 1
010bb57a eb05 jmp 0x1410bb581
010bb57c 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bb581 4d85f6 test r14, r14
010bb584 0f8482f7ffff je 0x1410bad0c
010bb58a 4d8b4610 mov r8, qword ptr [r14 + 0x10]
010bb58e 4d85c0 test r8, r8
010bb591 0f8475f7ffff je 0x1410bad0c
010bb597 498b4668 mov rax, qword ptr [r14 + 0x68]
010bb59b 4981c020050000 add r8, 0x520
010bb5a2 48634834 movsxd rcx, dword ptr [rax + 0x34]
010bb5a6 0f8429f7ffff je 0x1410bacd5
010bb5ac 41813863727473 cmp dword ptr [r8], 0x73747263
010bb5b3 0f851cf7ffff jne 0x1410bacd5
010bb5b9 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bb5bd 0f8412f7ffff je 0x1410bacd5
010bb5c3 83f901 cmp ecx, 1
010bb5c6 0f8c09f7ffff jl 0x1410bacd5
010bb5cc 413b482c cmp ecx, dword ptr [r8 + 0x2c]
010bb5d0 0f8ffff6ffff jg 0x1410bacd5
010bb5d6 488bd1 mov rdx, rcx
010bb5d9 e9eafeffff jmp 0x1410bb4c8
010bb5de 4885f6 test rsi, rsi
010bb5e1 746d je 0x1410bb650
010bb5e3 4c8b4610 mov r8, qword ptr [rsi + 0x10]
010bb5e7 4d85c0 test r8, r8
010bb5ea 7464 je 0x1410bb650
010bb5ec 486386dc000000 movsxd rax, dword ptr [rsi + 0xdc]
010bb5f3 448bd3 mov r10d, ebx
010bb5f6 4981c090040000 add r8, 0x490
010bb5fd 744c je 0x1410bb64b
010bb5ff 41813863727473 cmp dword ptr [r8], 0x73747263
010bb606 7543 jne 0x1410bb64b
010bb608 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bb60c 743d je 0x1410bb64b
010bb60e 83f801 cmp eax, 1
010bb611 7c38 jl 0x1410bb64b
010bb613 413b402c cmp eax, dword ptr [r8 + 0x2c]
010bb617 7f32 jg 0x1410bb64b
010bb619 488bd0 mov rdx, rax
010bb61c 498b4010 mov rax, qword ptr [r8 + 0x10]
010bb620 488b08 mov rcx, qword ptr [rax]
010bb623 488d42ff lea rax, [rdx - 1]
010bb627 488d04c1 lea rax, [rcx + rax*8]
010bb62b 4885c0 test rax, rax
010bb62e 741b je 0x1410bb64b
010bb630 486308 movsxd rcx, dword ptr [rax]
010bb633 85c9 test ecx, ecx
010bb635 7814 js 0x1410bb64b
010bb637 8b5004 mov edx, dword ptr [rax + 4]
010bb63a 85d2 test edx, edx
010bb63c 7e0d jle 0x1410bb64b
010bb63e 498b4020 mov rax, qword ptr [r8 + 0x20]
010bb642 4c8be1 mov r12, rcx
010bb645 448bd2 mov r10d, edx
010bb648 4c0320 add r12, qword ptr [rax]
010bb64b 41d1ea shr r10d, 1
010bb64e eb05 jmp 0x1410bb655
010bb650 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bb655 4d85f6 test r14, r14
010bb658 0f84aef6ffff je 0x1410bad0c
010bb65e 4d8b4610 mov r8, qword ptr [r14 + 0x10]
010bb662 4d85c0 test r8, r8
010bb665 0f84a1f6ffff je 0x1410bad0c
010bb66b 496386dc000000 movsxd rax, dword ptr [r14 + 0xdc]
010bb672 4981c090040000 add r8, 0x490
010bb679 e917feffff jmp 0x1410bb495
010bb67e 4885f6 test rsi, rsi
010bb681 746d je 0x1410bb6f0
010bb683 4c8b4610 mov r8, qword ptr [rsi + 0x10]
010bb687 4d85c0 test r8, r8
010bb68a 7464 je 0x1410bb6f0
010bb68c 486386d0000000 movsxd rax, dword ptr [rsi + 0xd0]
010bb693 448bd3 mov r10d, ebx
010bb696 4981c0b8030000 add r8, 0x3b8
010bb69d 744c je 0x1410bb6eb
010bb69f 41813863727473 cmp dword ptr [r8], 0x73747263
010bb6a6 7543 jne 0x1410bb6eb
010bb6a8 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bb6ac 743d je 0x1410bb6eb
010bb6ae 83f801 cmp eax, 1
010bb6b1 7c38 jl 0x1410bb6eb
010bb6b3 413b402c cmp eax, dword ptr [r8 + 0x2c]
010bb6b7 7f32 jg 0x1410bb6eb
010bb6b9 488bd0 mov rdx, rax
010bb6bc 498b4010 mov rax, qword ptr [r8 + 0x10]
010bb6c0 488b08 mov rcx, qword ptr [rax]
010bb6c3 488d42ff lea rax, [rdx - 1]
010bb6c7 488d04c1 lea rax, [rcx + rax*8]
010bb6cb 4885c0 test rax, rax
010bb6ce 741b je 0x1410bb6eb
010bb6d0 486308 movsxd rcx, dword ptr [rax]
010bb6d3 85c9 test ecx, ecx
010bb6d5 7814 js 0x1410bb6eb
010bb6d7 8b5004 mov edx, dword ptr [rax + 4]
010bb6da 85d2 test edx, edx
010bb6dc 7e0d jle 0x1410bb6eb
010bb6de 498b4020 mov rax, qword ptr [r8 + 0x20]
010bb6e2 4c8be1 mov r12, rcx
010bb6e5 448bd2 mov r10d, edx
010bb6e8 4c0320 add r12, qword ptr [rax]
010bb6eb 41d1ea shr r10d, 1
010bb6ee eb05 jmp 0x1410bb6f5
010bb6f0 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bb6f5 4d85f6 test r14, r14
010bb6f8 0f840ef6ffff je 0x1410bad0c
010bb6fe 4d8b4610 mov r8, qword ptr [r14 + 0x10]
010bb702 4d85c0 test r8, r8
010bb705 0f8401f6ffff je 0x1410bad0c
010bb70b 496386d0000000 movsxd rax, dword ptr [r14 + 0xd0]
010bb712 4981c0b8030000 add r8, 0x3b8
010bb719 e977fdffff jmp 0x1410bb495
010bb71e 418b8614010000 mov eax, dword ptr [r14 + 0x114]
010bb725 398614010000 cmp dword ptr [rsi + 0x114], eax
010bb72b 0f830ffcffff jae 0x1410bb340
010bb731 bfffffffff mov edi, 0xffffffff
010bb736 8bdf mov ebx, edi
010bb738 e931100000 jmp 0x1410bc76e
010bb73d 418b861c010000 mov eax, dword ptr [r14 + 0x11c]
010bb744 39861c010000 cmp dword ptr [rsi + 0x11c], eax
010bb74a 0f83f0fbffff jae 0x1410bb340
010bb750 bfffffffff mov edi, 0xffffffff
010bb755 8bdf mov ebx, edi
010bb757 e912100000 jmp 0x1410bc76e
010bb75c 450fb78e0e010000 movzx r9d, word ptr [r14 + 0x10e]
010bb764 498bd6 mov rdx, r14
010bb767 440fb7860e010000 movzx r8d, word ptr [rsi + 0x10e]
010bb76f 488bce mov rcx, rsi
010bb772 c644242001 mov byte ptr [rsp + 0x20], 1
010bb777 e884ebffff call 0x1410ba300
010bb77c 8bd8 mov ebx, eax
010bb77e e9eb0f0000 jmp 0x1410bc76e
010bb783 488bce mov rcx, rsi
010bb786 e825e7e1ff call 0x140ed9eb0
010bb78b 498bce mov rcx, r14
010bb78e 440fb6d0 movzx r10d, al
010bb792 e819e7e1ff call 0x140ed9eb0
010bb797 0fb6d0 movzx edx, al
010bb79a 41f6c508 test r13b, 8
010bb79e 7410 je 0x1410bb7b0
010bb7a0 410fb6ca movzx ecx, r10b
010bb7a4 e8f7210000 call 0x1410bd9a0
010bb7a9 8bd8 mov ebx, eax
010bb7ab e9be0f0000 jmp 0x1410bc76e
010bb7b0 443ad2 cmp r10b, dl
010bb7b3 7d0c jge 0x1410bb7c1
010bb7b5 bfffffffff mov edi, 0xffffffff
010bb7ba 8bdf mov ebx, edi
010bb7bc e9ad0f0000 jmp 0x1410bc76e
010bb7c1 8bfb mov edi, ebx
010bb7c3 400f9fc7 setg dil
010bb7c7 8bdf mov ebx, edi
010bb7c9 e9a00f0000 jmp 0x1410bc76e
010bb7ce 488bce mov rcx, rsi
010bb7d1 e8cae5e1ff call 0x140ed9da0
010bb7d6 498bce mov rcx, r14
010bb7d9 0fb6f0 movzx esi, al
010bb7dc e8bfe5e1ff call 0x140ed9da0
010bb7e1 0fb6d0 movzx edx, al
010bb7e4 41f6c508 test r13b, 8
010bb7e8 7410 je 0x1410bb7fa
010bb7ea 400fb6ce movzx ecx, sil
010bb7ee e8ad210000 call 0x1410bd9a0
010bb7f3 8bd8 mov ebx, eax
010bb7f5 e9740f0000 jmp 0x1410bc76e
010bb7fa 403af2 cmp sil, dl
010bb7fd 7dc2 jge 0x1410bb7c1
010bb7ff bfffffffff mov edi, 0xffffffff
010bb804 8bdf mov ebx, edi
010bb806 e9630f0000 jmp 0x1410bc76e
010bb80b 410fb6869a000000 movzx eax, byte ptr [r14 + 0x9a]
010bb813 2404 and al, 4
010bb815 f6869a00000004 test byte ptr [rsi + 0x9a], 4
010bb81c 740a je 0x1410bb828
010bb81e 84c0 test al, al
010bb820 0f94c3 sete bl
010bb823 e9460f0000 jmp 0x1410bc76e
010bb828 f6d8 neg al
010bb82a 1bdb sbb ebx, ebx
010bb82c e93d0f0000 jmp 0x1410bc76e
010bb831 4885f6 test rsi, rsi
010bb834 746d je 0x1410bb8a3
010bb836 4c8b4610 mov r8, qword ptr [rsi + 0x10]
010bb83a 4d85c0 test r8, r8
010bb83d 7464 je 0x1410bb8a3
010bb83f 486386c0000000 movsxd rax, dword ptr [rsi + 0xc0]
010bb846 448bd3 mov r10d, ebx
010bb849 4981c050020000 add r8, 0x250
010bb850 744c je 0x1410bb89e
010bb852 41813863727473 cmp dword ptr [r8], 0x73747263
010bb859 7543 jne 0x1410bb89e
010bb85b 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bb85f 743d je 0x1410bb89e
010bb861 83f801 cmp eax, 1
010bb864 7c38 jl 0x1410bb89e
010bb866 413b402c cmp eax, dword ptr [r8 + 0x2c]
010bb86a 7f32 jg 0x1410bb89e
010bb86c 488bd0 mov rdx, rax
010bb86f 498b4010 mov rax, qword ptr [r8 + 0x10]
010bb873 488b08 mov rcx, qword ptr [rax]
010bb876 488d42ff lea rax, [rdx - 1]
010bb87a 488d04c1 lea rax, [rcx + rax*8]
010bb87e 4885c0 test rax, rax
010bb881 741b je 0x1410bb89e
010bb883 486308 movsxd rcx, dword ptr [rax]
010bb886 85c9 test ecx, ecx
010bb888 7814 js 0x1410bb89e
010bb88a 8b5004 mov edx, dword ptr [rax + 4]
010bb88d 85d2 test edx, edx
010bb88f 7e0d jle 0x1410bb89e
010bb891 498b4020 mov rax, qword ptr [r8 + 0x20]
010bb895 4c8be1 mov r12, rcx
010bb898 448bd2 mov r10d, edx
010bb89b 4c0320 add r12, qword ptr [rax]
010bb89e 41d1ea shr r10d, 1
010bb8a1 eb05 jmp 0x1410bb8a8
010bb8a3 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bb8a8 4d85f6 test r14, r14
010bb8ab 0f845bf4ffff je 0x1410bad0c
010bb8b1 4d8b4610 mov r8, qword ptr [r14 + 0x10]
010bb8b5 4d85c0 test r8, r8
010bb8b8 0f844ef4ffff je 0x1410bad0c
010bb8be 496386c0000000 movsxd rax, dword ptr [r14 + 0xc0]
010bb8c5 4981c050020000 add r8, 0x250
010bb8cc e9c4fbffff jmp 0x1410bb495
010bb8d1 410fb7862c010000 movzx eax, word ptr [r14 + 0x12c]
010bb8d9 6639862c010000 cmp word ptr [rsi + 0x12c], ax
010bb8e0 0f835afaffff jae 0x1410bb340
010bb8e6 bfffffffff mov edi, 0xffffffff
010bb8eb 8bdf mov ebx, edi
010bb8ed e97c0e0000 jmp 0x1410bc76e
010bb8f2 498b8650010000 mov rax, qword ptr [r14 + 0x150]
010bb8f9 48398650010000 cmp qword ptr [rsi + 0x150], rax
010bb900 0f833afaffff jae 0x1410bb340
010bb906 bfffffffff mov edi, 0xffffffff
010bb90b 8bdf mov ebx, edi
010bb90d e95c0e0000 jmp 0x1410bc76e
010bb912 498b8638010000 mov rax, qword ptr [r14 + 0x138]
010bb919 48398638010000 cmp qword ptr [rsi + 0x138], rax
010bb920 0f831afaffff jae 0x1410bb340
010bb926 bfffffffff mov edi, 0xffffffff
010bb92b 8bdf mov ebx, edi
010bb92d e93c0e0000 jmp 0x1410bc76e
010bb932 41f6c504 test r13b, 4
010bb936 0f84f6000000 je 0x1410bba32
010bb93c 4885f6 test rsi, rsi
010bb93f 746e je 0x1410bb9af
010bb941 4c8b4610 mov r8, qword ptr [rsi + 0x10]
010bb945 4d85c0 test r8, r8
010bb948 7465 je 0x1410bb9af
010bb94a 488b4670 mov rax, qword ptr [rsi + 0x70]
010bb94e 448bd3 mov r10d, ebx
010bb951 48634828 movsxd rcx, dword ptr [rax + 0x28]
010bb955 4981c040060000 add r8, 0x640
010bb95c 744c je 0x1410bb9aa
010bb95e 41813863727473 cmp dword ptr [r8], 0x73747263
010bb965 7543 jne 0x1410bb9aa
010bb967 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bb96b 743d je 0x1410bb9aa
010bb96d 83f901 cmp ecx, 1
010bb970 7c38 jl 0x1410bb9aa
010bb972 413b482c cmp ecx, dword ptr [r8 + 0x2c]
010bb976 7f32 jg 0x1410bb9aa
010bb978 498b4010 mov rax, qword ptr [r8 + 0x10]
010bb97c 488bd1 mov rdx, rcx
010bb97f 488b08 mov rcx, qword ptr [rax]
010bb982 488d42ff lea rax, [rdx - 1]
010bb986 488d04c1 lea rax, [rcx + rax*8]
010bb98a 4885c0 test rax, rax
010bb98d 741b je 0x1410bb9aa
010bb98f 486308 movsxd rcx, dword ptr [rax]
010bb992 85c9 test ecx, ecx
010bb994 7814 js 0x1410bb9aa
010bb996 8b5004 mov edx, dword ptr [rax + 4]
010bb999 85d2 test edx, edx
010bb99b 7e0d jle 0x1410bb9aa
010bb99d 498b4020 mov rax, qword ptr [r8 + 0x20]
010bb9a1 4c8be1 mov r12, rcx
010bb9a4 448bd2 mov r10d, edx
010bb9a7 4c0320 add r12, qword ptr [rax]
010bb9aa 41d1ea shr r10d, 1
010bb9ad eb05 jmp 0x1410bb9b4
010bb9af 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bb9b4 4d85f6 test r14, r14
010bb9b7 0f8485020000 je 0x1410bbc42
010bb9bd 4d8b4610 mov r8, qword ptr [r14 + 0x10]
010bb9c1 4d85c0 test r8, r8
010bb9c4 0f8478020000 je 0x1410bbc42
010bb9ca 498b4670 mov rax, qword ptr [r14 + 0x70]
010bb9ce 448bcb mov r9d, ebx
010bb9d1 48634828 movsxd rcx, dword ptr [rax + 0x28]
010bb9d5 4981c040060000 add r8, 0x640
010bb9dc 744c je 0x1410bba2a
010bb9de 41813863727473 cmp dword ptr [r8], 0x73747263
010bb9e5 7543 jne 0x1410bba2a
010bb9e7 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bb9eb 743d je 0x1410bba2a
010bb9ed 83f901 cmp ecx, 1
010bb9f0 7c38 jl 0x1410bba2a
010bb9f2 413b482c cmp ecx, dword ptr [r8 + 0x2c]
010bb9f6 7f32 jg 0x1410bba2a
010bb9f8 498b4010 mov rax, qword ptr [r8 + 0x10]
010bb9fc 488bd1 mov rdx, rcx
010bb9ff 488b08 mov rcx, qword ptr [rax]
010bba02 488d42ff lea rax, [rdx - 1]
010bba06 488d04c1 lea rax, [rcx + rax*8]
010bba0a 4885c0 test rax, rax
010bba0d 741b je 0x1410bba2a
010bba0f 486308 movsxd rcx, dword ptr [rax]
010bba12 85c9 test ecx, ecx
010bba14 7814 js 0x1410bba2a
010bba16 8b5004 mov edx, dword ptr [rax + 4]
010bba19 85d2 test edx, edx
010bba1b 7e0d jle 0x1410bba2a
010bba1d 498b4020 mov rax, qword ptr [r8 + 0x20]
010bba21 4c8bf9 mov r15, rcx
010bba24 448bca mov r9d, edx
010bba27 4c0338 add r15, qword ptr [rax]
010bba2a 41d1e9 shr r9d, 1
010bba2d e9e1f2ffff jmp 0x1410bad13
010bba32 4885f6 test rsi, rsi
010bba35 0f8402010000 je 0x1410bbb3d
010bba3b 488b4e10 mov rcx, qword ptr [rsi + 0x10]
010bba3f 4885c9 test rcx, rcx
010bba42 0f84f5000000 je 0x1410bbb3d
010bba48 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
010bba52 0f85e5000000 jne 0x1410bbb3d
010bba58 488b4670 mov rax, qword ptr [rsi + 0x70]
010bba5c 4c8d9940060000 lea r11, [rcx + 0x640]
010bba63 4c8d8940180000 lea r9, [rcx + 0x1840]
010bba6a 448bc3 mov r8d, ebx
010bba6d 448bd3 mov r10d, ebx
010bba70 48637828 movsxd rdi, dword ptr [rax + 0x28]
010bba74 48638674010000 movsxd rax, dword ptr [rsi + 0x174]
010bba7b 85c0 test eax, eax
010bba7d 7458 je 0x1410bbad7
010bba7f 4d85c9 test r9, r9
010bba82 744d je 0x1410bbad1
010bba84 41813963727473 cmp dword ptr [r9], 0x73747263
010bba8b 7544 jne 0x1410bbad1
010bba8d 4139593c cmp dword ptr [r9 + 0x3c], ebx
010bba91 743e je 0x1410bbad1
010bba93 85c0 test eax, eax
010bba95 7e3a jle 0x1410bbad1
010bba97 413b412c cmp eax, dword ptr [r9 + 0x2c]
010bba9b 7f34 jg 0x1410bbad1
010bba9d 488bd0 mov rdx, rax
010bbaa0 498b4110 mov rax, qword ptr [r9 + 0x10]
010bbaa4 488b08 mov rcx, qword ptr [rax]
010bbaa7 488d42ff lea rax, [rdx - 1]
010bbaab 488d04c1 lea rax, [rcx + rax*8]
010bbaaf 4885c0 test rax, rax
010bbab2 741d je 0x1410bbad1
010bbab4 486308 movsxd rcx, dword ptr [rax]
010bbab7 85c9 test ecx, ecx
010bbab9 7816 js 0x1410bbad1
010bbabb 8b5004 mov edx, dword ptr [rax + 4]
010bbabe 85d2 test edx, edx
010bbac0 7e0f jle 0x1410bbad1
010bbac2 498b4120 mov rax, qword ptr [r9 + 0x20]
010bbac6 4c8be1 mov r12, rcx
010bbac9 448bd2 mov r10d, edx
010bbacc 4c0320 add r12, qword ptr [rax]
010bbacf eb06 jmp 0x1410bbad7
010bbad1 41b8ceffffff mov r8d, 0xffffffce
010bbad7 4585d2 test r10d, r10d
010bbada 7405 je 0x1410bbae1
010bbadc 4585c0 test r8d, r8d
010bbadf 7457 je 0x1410bbb38
010bbae1 85ff test edi, edi
010bbae3 7453 je 0x1410bbb38
010bbae5 448bd3 mov r10d, ebx
010bbae8 4c8be3 mov r12, rbx
010bbaeb 4d85db test r11, r11
010bbaee 7448 je 0x1410bbb38
010bbaf0 41813b63727473 cmp dword ptr [r11], 0x73747263
010bbaf7 753f jne 0x1410bbb38
010bbaf9 41395b3c cmp dword ptr [r11 + 0x3c], ebx
010bbafd 7439 je 0x1410bbb38
010bbaff 85ff test edi, edi
010bbb01 7e35 jle 0x1410bbb38
010bbb03 413b7b2c cmp edi, dword ptr [r11 + 0x2c]
010bbb07 7f2f jg 0x1410bbb38
010bbb09 498b4310 mov rax, qword ptr [r11 + 0x10]
010bbb0d 488b08 mov rcx, qword ptr [rax]
010bbb10 488d47ff lea rax, [rdi - 1]
010bbb14 488d04c1 lea rax, [rcx + rax*8]
010bbb18 4885c0 test rax, rax
010bbb1b 741b je 0x1410bbb38
010bbb1d 486308 movsxd rcx, dword ptr [rax]
010bbb20 85c9 test ecx, ecx
010bbb22 7814 js 0x1410bbb38
010bbb24 8b5004 mov edx, dword ptr [rax + 4]
010bbb27 85d2 test edx, edx
010bbb29 7e0d jle 0x1410bbb38
010bbb2b 498b4320 mov rax, qword ptr [r11 + 0x20]
010bbb2f 4c8be1 mov r12, rcx
010bbb32 448bd2 mov r10d, edx
010bbb35 4c0320 add r12, qword ptr [rax]
010bbb38 41d1ea shr r10d, 1
010bbb3b eb05 jmp 0x1410bbb42
010bbb3d 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bbb42 4d85f6 test r14, r14
010bbb45 0f84f7000000 je 0x1410bbc42
010bbb4b 498b7e10 mov rdi, qword ptr [r14 + 0x10]
010bbb4f 4885ff test rdi, rdi
010bbb52 0f84ea000000 je 0x1410bbc42
010bbb58 81bf8000000074616474 cmp dword ptr [rdi + 0x80], 0x74646174
010bbb62 0f85da000000 jne 0x1410bbc42
010bbb68 498b4670 mov rax, qword ptr [r14 + 0x70]
010bbb6c 4c8d8740060000 lea r8, [rdi + 0x640]
010bbb73 4881c740180000 add rdi, 0x1840
010bbb7a 448bdb mov r11d, ebx
010bbb7d 448bcb mov r9d, ebx
010bbb80 48637028 movsxd rsi, dword ptr [rax + 0x28]
010bbb84 49638674010000 movsxd rax, dword ptr [r14 + 0x174]
010bbb8b 85c0 test eax, eax
010bbb8d 7455 je 0x1410bbbe4
010bbb8f 4885ff test rdi, rdi
010bbb92 744a je 0x1410bbbde
010bbb94 813f63727473 cmp dword ptr [rdi], 0x73747263
010bbb9a 7542 jne 0x1410bbbde
010bbb9c 395f3c cmp dword ptr [rdi + 0x3c], ebx
010bbb9f 743d je 0x1410bbbde
010bbba1 85c0 test eax, eax
010bbba3 7e39 jle 0x1410bbbde
010bbba5 3b472c cmp eax, dword ptr [rdi + 0x2c]
010bbba8 7f34 jg 0x1410bbbde
010bbbaa 488bd0 mov rdx, rax
010bbbad 488b4710 mov rax, qword ptr [rdi + 0x10]
010bbbb1 488b08 mov rcx, qword ptr [rax]
010bbbb4 488d42ff lea rax, [rdx - 1]
010bbbb8 488d04c1 lea rax, [rcx + rax*8]
010bbbbc 4885c0 test rax, rax
010bbbbf 741d je 0x1410bbbde
010bbbc1 486308 movsxd rcx, dword ptr [rax]
010bbbc4 85c9 test ecx, ecx
010bbbc6 7816 js 0x1410bbbde
010bbbc8 8b5004 mov edx, dword ptr [rax + 4]
010bbbcb 85d2 test edx, edx
010bbbcd 7e0f jle 0x1410bbbde
010bbbcf 488b4720 mov rax, qword ptr [rdi + 0x20]
010bbbd3 4c8bf9 mov r15, rcx
010bbbd6 448bca mov r9d, edx
010bbbd9 4c0338 add r15, qword ptr [rax]
010bbbdc eb06 jmp 0x1410bbbe4
010bbbde 41bbceffffff mov r11d, 0xffffffce
010bbbe4 4585c9 test r9d, r9d
010bbbe7 7409 je 0x1410bbbf2
010bbbe9 4585db test r11d, r11d
010bbbec 0f8438feffff je 0x1410bba2a
010bbbf2 85f6 test esi, esi
010bbbf4 0f8430feffff je 0x1410bba2a
010bbbfa 448bcb mov r9d, ebx
010bbbfd 4c8bfb mov r15, rbx
010bbc00 4d85c0 test r8, r8
010bbc03 0f8421feffff je 0x1410bba2a
010bbc09 41813863727473 cmp dword ptr [r8], 0x73747263
010bbc10 0f8514feffff jne 0x1410bba2a
010bbc16 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bbc1a 0f840afeffff je 0x1410bba2a
010bbc20 85f6 test esi, esi
010bbc22 0f8e02feffff jle 0x1410bba2a
010bbc28 413b702c cmp esi, dword ptr [r8 + 0x2c]
010bbc2c 0f8ff8fdffff jg 0x1410bba2a
010bbc32 498b4010 mov rax, qword ptr [r8 + 0x10]
010bbc36 488b08 mov rcx, qword ptr [rax]
010bbc39 488d46ff lea rax, [rsi - 1]
010bbc3d e9c4fdffff jmp 0x1410bba06
010bbc42 448b4c2434 mov r9d, dword ptr [rsp + 0x34]
010bbc47 e9c7f0ffff jmp 0x1410bad13
010bbc4c 4885f6 test rsi, rsi
010bbc4f 746e je 0x1410bbcbf
010bbc51 4c8b4610 mov r8, qword ptr [rsi + 0x10]
010bbc55 4d85c0 test r8, r8
010bbc58 7465 je 0x1410bbcbf
010bbc5a 488b4670 mov rax, qword ptr [rsi + 0x70]
010bbc5e 448bd3 mov r10d, ebx
010bbc61 4863482c movsxd rcx, dword ptr [rax + 0x2c]
010bbc65 4981c0d0060000 add r8, 0x6d0
010bbc6c 744c je 0x1410bbcba
010bbc6e 41813863727473 cmp dword ptr [r8], 0x73747263
010bbc75 7543 jne 0x1410bbcba
010bbc77 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bbc7b 743d je 0x1410bbcba
010bbc7d 83f901 cmp ecx, 1
010bbc80 7c38 jl 0x1410bbcba
010bbc82 413b482c cmp ecx, dword ptr [r8 + 0x2c]
010bbc86 7f32 jg 0x1410bbcba
010bbc88 498b4010 mov rax, qword ptr [r8 + 0x10]
010bbc8c 488bd1 mov rdx, rcx
010bbc8f 488b08 mov rcx, qword ptr [rax]
010bbc92 488d42ff lea rax, [rdx - 1]
010bbc96 488d04c1 lea rax, [rcx + rax*8]
010bbc9a 4885c0 test rax, rax
010bbc9d 741b je 0x1410bbcba
010bbc9f 486308 movsxd rcx, dword ptr [rax]
010bbca2 85c9 test ecx, ecx
010bbca4 7814 js 0x1410bbcba
010bbca6 8b5004 mov edx, dword ptr [rax + 4]
010bbca9 85d2 test edx, edx
010bbcab 7e0d jle 0x1410bbcba
010bbcad 498b4020 mov rax, qword ptr [r8 + 0x20]
010bbcb1 4c8be1 mov r12, rcx
010bbcb4 448bd2 mov r10d, edx
010bbcb7 4c0320 add r12, qword ptr [rax]
010bbcba 41d1ea shr r10d, 1
010bbcbd eb05 jmp 0x1410bbcc4
010bbcbf 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bbcc4 4d85f6 test r14, r14
010bbcc7 0f843ff0ffff je 0x1410bad0c
010bbccd 4d8b4610 mov r8, qword ptr [r14 + 0x10]
010bbcd1 4d85c0 test r8, r8
010bbcd4 0f8432f0ffff je 0x1410bad0c
010bbcda 498b4670 mov rax, qword ptr [r14 + 0x70]
010bbcde 4981c0d0060000 add r8, 0x6d0
010bbce5 4863482c movsxd rcx, dword ptr [rax + 0x2c]
010bbce9 e9b8f8ffff jmp 0x1410bb5a6
010bbcee 498b4670 mov rax, qword ptr [r14 + 0x70]
010bbcf2 8b4808 mov ecx, dword ptr [rax + 8]
010bbcf5 488b4670 mov rax, qword ptr [rsi + 0x70]
010bbcf9 394808 cmp dword ptr [rax + 8], ecx
010bbcfc 0f833ef6ffff jae 0x1410bb340
010bbd02 bfffffffff mov edi, 0xffffffff
010bbd07 8bdf mov ebx, edi
010bbd09 e9600a0000 jmp 0x1410bc76e
010bbd0e 498b4670 mov rax, qword ptr [r14 + 0x70]
010bbd12 8b4804 mov ecx, dword ptr [rax + 4]
010bbd15 488b4670 mov rax, qword ptr [rsi + 0x70]
010bbd19 394804 cmp dword ptr [rax + 4], ecx
010bbd1c 0f831ef6ffff jae 0x1410bb340
010bbd22 bfffffffff mov edi, 0xffffffff
010bbd27 8bdf mov ebx, edi
010bbd29 e9400a0000 jmp 0x1410bc76e
010bbd2e 488d0def29aa00 lea rcx, [rip + 0xaa29ef]
010bbd35 ff157dd18200 call qword ptr [rip + 0x82d17d]
010bbd3b 488d542450 lea rdx, [rsp + 0x50]
010bbd40 488bce mov rcx, rsi
010bbd43 4c8bc0 mov r8, rax
010bbd46 e80557edff call 0x140f91450
010bbd4b 488d0dd229aa00 lea rcx, [rip + 0xaa29d2]
010bbd52 ff1560d18200 call qword ptr [rip + 0x82d160]
010bbd58 488d9570070000 lea rdx, [rbp + 0x770]
010bbd5f 498bce mov rcx, r14
010bbd62 4c8bc0 mov r8, rax
010bbd65 e8e656edff call 0x140f91450
010bbd6a 440fb78d70070000 movzx r9d, word ptr [rbp + 0x770]
010bbd72 4c8d8572070000 lea r8, [rbp + 0x772]
010bbd79 0fb7542450 movzx edx, word ptr [rsp + 0x50]
010bbd7e 488d4c2452 lea rcx, [rsp + 0x52]
010bbd83 e8f8c5ffff call 0x1410b8380
010bbd88 8bd8 mov ebx, eax
010bbd8a e9df090000 jmp 0x1410bc76e
010bbd8f 498b4668 mov rax, qword ptr [r14 + 0x68]
010bbd93 8b4804 mov ecx, dword ptr [rax + 4]
010bbd96 488b4668 mov rax, qword ptr [rsi + 0x68]
010bbd9a 394804 cmp dword ptr [rax + 4], ecx
010bbd9d 0f839df5ffff jae 0x1410bb340
010bbda3 bfffffffff mov edi, 0xffffffff
010bbda8 8bdf mov ebx, edi
010bbdaa e9bf090000 jmp 0x1410bc76e
010bbdaf 498b4668 mov rax, qword ptr [r14 + 0x68]
010bbdb3 f30f104008 movss xmm0, dword ptr [rax + 8]
010bbdb8 488b4668 mov rax, qword ptr [rsi + 0x68]
010bbdbc f30f104808 movss xmm1, dword ptr [rax + 8]
010bbdc1 0f2fc1 comiss xmm0, xmm1
010bbdc4 760c jbe 0x1410bbdd2
010bbdc6 bfffffffff mov edi, 0xffffffff
010bbdcb 8bdf mov ebx, edi
010bbdcd e99c090000 jmp 0x1410bc76e
010bbdd2 8bfb mov edi, ebx
010bbdd4 0f2fc8 comiss xmm1, xmm0
010bbdd7 400f97c7 seta dil
010bbddb 8bdf mov ebx, edi
010bbddd e98c090000 jmp 0x1410bc76e
010bbde2 498b4668 mov rax, qword ptr [r14 + 0x68]
010bbde6 f30f10400c movss xmm0, dword ptr [rax + 0xc]
010bbdeb 488b4668 mov rax, qword ptr [rsi + 0x68]
010bbdef f30f10480c movss xmm1, dword ptr [rax + 0xc]
010bbdf4 0f2fc1 comiss xmm0, xmm1
010bbdf7 76d9 jbe 0x1410bbdd2
010bbdf9 bfffffffff mov edi, 0xffffffff
010bbdfe 8bdf mov ebx, edi
010bbe00 e969090000 jmp 0x1410bc76e
010bbe05 4d85f6 test r14, r14
010bbe08 742a je 0x1410bbe34
010bbe0a 49395e10 cmp qword ptr [r14 + 0x10], rbx
010bbe0e 7424 je 0x1410bbe34
010bbe10 498b4670 mov rax, qword ptr [r14 + 0x70]
010bbe14 4885c0 test rax, rax
010bbe17 741b je 0x1410bbe34
010bbe19 448b4010 mov r8d, dword ptr [rax + 0x10]
010bbe1d 4403400c add r8d, dword ptr [rax + 0xc]
010bbe21 8b4814 mov ecx, dword ptr [rax + 0x14]
010bbe24 85c9 test ecx, ecx
010bbe26 740f je 0x1410bbe37
010bbe28 034818 add ecx, dword ptr [rax + 0x18]
010bbe2b 443bc1 cmp r8d, ecx
010bbe2e 440f47c1 cmova r8d, ecx
010bbe32 eb03 jmp 0x1410bbe37
010bbe34 448bc3 mov r8d, ebx
010bbe37 4885f6 test rsi, rsi
010bbe3a 7426 je 0x1410bbe62
010bbe3c 48395e10 cmp qword ptr [rsi + 0x10], rbx
010bbe40 7420 je 0x1410bbe62
010bbe42 488b4670 mov rax, qword ptr [rsi + 0x70]
010bbe46 4885c0 test rax, rax
010bbe49 7417 je 0x1410bbe62
010bbe4b 8b5010 mov edx, dword ptr [rax + 0x10]
010bbe4e 03500c add edx, dword ptr [rax + 0xc]
010bbe51 8b4814 mov ecx, dword ptr [rax + 0x14]
010bbe54 85c9 test ecx, ecx
010bbe56 740c je 0x1410bbe64
010bbe58 034818 add ecx, dword ptr [rax + 0x18]
010bbe5b 3bd1 cmp edx, ecx
010bbe5d 0f47d1 cmova edx, ecx
010bbe60 eb02 jmp 0x1410bbe64
010bbe62 8bd3 mov edx, ebx
010bbe64 413bd0 cmp edx, r8d
010bbe67 0f83d3f4ffff jae 0x1410bb340
010bbe6d bfffffffff mov edi, 0xffffffff
010bbe72 8bdf mov ebx, edi
010bbe74 e9f5080000 jmp 0x1410bc76e
010bbe79 418b8620010000 mov eax, dword ptr [r14 + 0x120]
010bbe80 398620010000 cmp dword ptr [rsi + 0x120], eax
010bbe86 0f83b4f4ffff jae 0x1410bb340
010bbe8c bfffffffff mov edi, 0xffffffff
010bbe91 8bdf mov ebx, edi
010bbe93 e9d6080000 jmp 0x1410bc76e
010bbe98 418b8628010000 mov eax, dword ptr [r14 + 0x128]
010bbe9f 398628010000 cmp dword ptr [rsi + 0x128], eax
010bbea5 0f8395f4ffff jae 0x1410bb340
010bbeab bfffffffff mov edi, 0xffffffff
010bbeb0 8bdf mov ebx, edi
010bbeb2 e9b7080000 jmp 0x1410bc76e
010bbeb7 4c8bd3 mov r10, rbx
010bbeba 4c8bc3 mov r8, rbx
010bbebd 4885f6 test rsi, rsi
010bbec0 7468 je 0x1410bbf2a
010bbec2 4c8b4e10 mov r9, qword ptr [rsi + 0x10]
010bbec6 4d85c9 test r9, r9
010bbec9 745f je 0x1410bbf2a
010bbecb 488b4668 mov rax, qword ptr [rsi + 0x68]
010bbecf 8bfb mov edi, ebx
010bbed1 48634824 movsxd rcx, dword ptr [rax + 0x24]
010bbed5 4981c1b0050000 add r9, 0x5b0
010bbedc 7450 je 0x1410bbf2e
010bbede 41813963727473 cmp dword ptr [r9], 0x73747263
010bbee5 7547 jne 0x1410bbf2e
010bbee7 4139593c cmp dword ptr [r9 + 0x3c], ebx
010bbeeb 7441 je 0x1410bbf2e
010bbeed 85c9 test ecx, ecx
010bbeef 7e3d jle 0x1410bbf2e
010bbef1 413b492c cmp ecx, dword ptr [r9 + 0x2c]
010bbef5 7f37 jg 0x1410bbf2e
010bbef7 498b4110 mov rax, qword ptr [r9 + 0x10]
010bbefb 488bd1 mov rdx, rcx
010bbefe 488b08 mov rcx, qword ptr [rax]
010bbf01 488d42ff lea rax, [rdx - 1]
010bbf05 488d04c1 lea rax, [rcx + rax*8]
010bbf09 4885c0 test rax, rax
010bbf0c 7420 je 0x1410bbf2e
010bbf0e 486308 movsxd rcx, dword ptr [rax]
010bbf11 85c9 test ecx, ecx
010bbf13 7819 js 0x1410bbf2e
010bbf15 8b5004 mov edx, dword ptr [rax + 4]
010bbf18 85d2 test edx, edx
010bbf1a 7e12 jle 0x1410bbf2e
010bbf1c 498b4120 mov rax, qword ptr [r9 + 0x20]
010bbf20 4c8bd1 mov r10, rcx
010bbf23 8bfa mov edi, edx
010bbf25 4c0310 add r10, qword ptr [rax]
010bbf28 eb04 jmp 0x1410bbf2e
010bbf2a 8b7c2430 mov edi, dword ptr [rsp + 0x30]
010bbf2e 4d85f6 test r14, r14
010bbf31 746a je 0x1410bbf9d
010bbf33 4d8b4e10 mov r9, qword ptr [r14 + 0x10]
010bbf37 4d85c9 test r9, r9
010bbf3a 7461 je 0x1410bbf9d
010bbf3c 498b4668 mov rax, qword ptr [r14 + 0x68]
010bbf40 448bdb mov r11d, ebx
010bbf43 48634824 movsxd rcx, dword ptr [rax + 0x24]
010bbf47 4981c1b0050000 add r9, 0x5b0
010bbf4e 7452 je 0x1410bbfa2
010bbf50 41813963727473 cmp dword ptr [r9], 0x73747263
010bbf57 7549 jne 0x1410bbfa2
010bbf59 4139593c cmp dword ptr [r9 + 0x3c], ebx
010bbf5d 7443 je 0x1410bbfa2
010bbf5f 85c9 test ecx, ecx
010bbf61 7e3f jle 0x1410bbfa2
010bbf63 413b492c cmp ecx, dword ptr [r9 + 0x2c]
010bbf67 7f39 jg 0x1410bbfa2
010bbf69 498b4110 mov rax, qword ptr [r9 + 0x10]
010bbf6d 488bd1 mov rdx, rcx
010bbf70 488b08 mov rcx, qword ptr [rax]
010bbf73 488d42ff lea rax, [rdx - 1]
010bbf77 488d04c1 lea rax, [rcx + rax*8]
010bbf7b 4885c0 test rax, rax
010bbf7e 7422 je 0x1410bbfa2
010bbf80 486308 movsxd rcx, dword ptr [rax]
010bbf83 85c9 test ecx, ecx
010bbf85 781b js 0x1410bbfa2
010bbf87 8b5004 mov edx, dword ptr [rax + 4]
010bbf8a 85d2 test edx, edx
010bbf8c 7e14 jle 0x1410bbfa2
010bbf8e 498b4120 mov rax, qword ptr [r9 + 0x20]
010bbf92 4c8bc1 mov r8, rcx
010bbf95 448bda mov r11d, edx
010bbf98 4c0300 add r8, qword ptr [rax]
010bbf9b eb05 jmp 0x1410bbfa2
010bbf9d 448b5c2434 mov r11d, dword ptr [rsp + 0x34]
010bbfa2 458bcb mov r9d, r11d
010bbfa5 498bca mov rcx, r10
010bbfa8 8bd7 mov edx, edi
010bbfaa 895c2420 mov dword ptr [rsp + 0x20], ebx
010bbfae e85d26a2ff call 0x140ade610
010bbfb3 8bd8 mov ebx, eax
010bbfb5 e9b4070000 jmp 0x1410bc76e
010bbfba 4885f6 test rsi, rsi
010bbfbd 0f8441010000 je 0x1410bc104
010bbfc3 48395e10 cmp qword ptr [rsi + 0x10], rbx
010bbfc7 0f8437010000 je 0x1410bc104
010bbfcd 33d2 xor edx, edx
010bbfcf 488bce mov rcx, rsi
010bbfd2 e8994beeff call 0x140fa0b70
010bbfd7 a904002000 test eax, 0x200004
010bbfdc 0f84b1000000 je 0x1410bc093
010bbfe2 488bce mov rcx, rsi
010bbfe5 e816fdf3ff call 0x140ffbd00
010bbfea 4885c0 test rax, rax
010bbfed 0f84a0000000 je 0x1410bc093
010bbff3 488b4028 mov rax, qword ptr [rax + 0x28]
010bbff7 4885c0 test rax, rax
010bbffa 0f8493000000 je 0x1410bc093
010bc000 488b4030 mov rax, qword ptr [rax + 0x30]
010bc004 4885c0 test rax, rax
010bc007 0f8486000000 je 0x1410bc093
010bc00d 4c8b4010 mov r8, qword ptr [rax + 0x10]
010bc011 4d85c0 test r8, r8
010bc014 747d je 0x1410bc093
010bc016 486388d8000000 movsxd rcx, dword ptr [rax + 0xd8]
010bc01d 448bcb mov r9d, ebx
010bc020 8bfb mov edi, ebx
010bc022 4981c048040000 add r8, 0x448
010bc029 740f je 0x1410bc03a
010bc02b 41813863727473 cmp dword ptr [r8], 0x73747263
010bc032 7506 jne 0x1410bc03a
010bc034 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bc038 7504 jne 0x1410bc03e
010bc03a d1ef shr edi, 1
010bc03c eb59 jmp 0x1410bc097
010bc03e 85c9 test ecx, ecx
010bc040 7507 jne 0x1410bc049
010bc042 d1ef shr edi, 1
010bc044 e9bf000000 jmp 0x1410bc108
010bc049 7eef jle 0x1410bc03a
010bc04b 413b482c cmp ecx, dword ptr [r8 + 0x2c]
010bc04f 7fe9 jg 0x1410bc03a
010bc051 498b4010 mov rax, qword ptr [r8 + 0x10]
010bc055 488bd1 mov rdx, rcx
010bc058 488b08 mov rcx, qword ptr [rax]
010bc05b 488d42ff lea rax, [rdx - 1]
010bc05f 488d04c1 lea rax, [rcx + rax*8]
010bc063 4885c0 test rax, rax
010bc066 741c je 0x1410bc084
010bc068 486308 movsxd rcx, dword ptr [rax]
010bc06b 85c9 test ecx, ecx
010bc06d 7815 js 0x1410bc084
010bc06f 8b5004 mov edx, dword ptr [rax + 4]
010bc072 85d2 test edx, edx
010bc074 7e0e jle 0x1410bc084
010bc076 498b4020 mov rax, qword ptr [r8 + 0x20]
010bc07a 4c8be1 mov r12, rcx
010bc07d 8bfa mov edi, edx
010bc07f 4c0320 add r12, qword ptr [rax]
010bc082 eb06 jmp 0x1410bc08a
010bc084 41b9ceffffff mov r9d, 0xffffffce
010bc08a d1ef shr edi, 1
010bc08c 4585c9 test r9d, r9d
010bc08f 7477 je 0x1410bc108
010bc091 eb04 jmp 0x1410bc097
010bc093 8b7c2430 mov edi, dword ptr [rsp + 0x30]
010bc097 4c8b4610 mov r8, qword ptr [rsi + 0x10]
010bc09b 4d85c0 test r8, r8
010bc09e 7468 je 0x1410bc108
010bc0a0 486386d8000000 movsxd rax, dword ptr [rsi + 0xd8]
010bc0a7 8bfb mov edi, ebx
010bc0a9 4c8be3 mov r12, rbx
010bc0ac 4981c048040000 add r8, 0x448
010bc0b3 744b je 0x1410bc100
010bc0b5 41813863727473 cmp dword ptr [r8], 0x73747263
010bc0bc 7542 jne 0x1410bc100
010bc0be 4139583c cmp dword ptr [r8 + 0x3c], ebx
010bc0c2 743c je 0x1410bc100
010bc0c4 83f801 cmp eax, 1
010bc0c7 7c37 jl 0x1410bc100
010bc0c9 413b402c cmp eax, dword ptr [r8 + 0x2c]
010bc0cd 7f31 jg 0x1410bc100
010bc0cf 488bd0 mov rdx, rax
010bc0d2 498b4010 mov rax, qword ptr [r8 + 0x10]
010bc0d6 488b08 mov rcx, qword ptr [rax]
010bc0d9 488d42ff lea rax, [rdx - 1]
010bc0dd 488d04c1 lea rax, [rcx + rax*8]
010bc0e1 4885c0 test rax, rax
010bc0e4 741a je 0x1410bc100
010bc0e6 486308 movsxd rcx, dword ptr [rax]
010bc0e9 85c9 test ecx, ecx
010bc0eb 7813 js 0x1410bc100
010bc0ed 8b5004 mov edx, dword ptr [rax + 4]
010bc0f0 85d2 test edx, edx
010bc0f2 7e0c jle 0x1410bc100
010bc0f4 498b4020 mov rax, qword ptr [r8 + 0x20]
010bc0f8 4c8be1 mov r12, rcx
010bc0fb 8bfa mov edi, edx
010bc0fd 4c0320 add r12, qword ptr [rax]
010bc100 d1ef shr edi, 1
010bc102 eb04 jmp 0x1410bc108
010bc104 8b7c2430 mov edi, dword ptr [rsp + 0x30]
010bc108 4d85f6 test r14, r14
010bc10b 0f8454010000 je 0x1410bc265
010bc111 49395e10 cmp qword ptr [r14 + 0x10], rbx
010bc115 0f844a010000 je 0x1410bc265
010bc11b 33d2 xor edx, edx
010bc11d 498bce mov rcx, r14
010bc120 e84b4aeeff call 0x140fa0b70
010bc125 a904002000 test eax, 0x200004
010bc12a 0f84b2000000 je 0x1410bc1e2
010bc130 498bce mov rcx, r14
010bc133 e8c8fbf3ff call 0x140ffbd00
010bc138 4885c0 test rax, rax
010bc13b 0f84a1000000 je 0x1410bc1e2
010bc141 488b4028 mov rax, qword ptr [rax + 0x28]
010bc145 4885c0 test rax, rax
010bc148 0f8494000000 je 0x1410bc1e2
010bc14e 488b4030 mov rax, qword ptr [rax + 0x30]
010bc152 4885c0 test rax, rax
010bc155 0f8487000000 je 0x1410bc1e2
010bc15b 488b5010 mov rdx, qword ptr [rax + 0x10]
010bc15f 4885d2 test rdx, rdx
010bc162 747e je 0x1410bc1e2
010bc164 486388d8000000 movsxd rcx, dword ptr [rax + 0xd8]
010bc16b 448bdb mov r11d, ebx
010bc16e 448bcb mov r9d, ebx
010bc171 4881c248040000 add rdx, 0x448
010bc178 740d je 0x1410bc187
010bc17a 813a63727473 cmp dword ptr [rdx], 0x73747263
010bc180 7505 jne 0x1410bc187
010bc182 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bc185 7505 jne 0x1410bc18c
010bc187 41d1e9 shr r9d, 1
010bc18a eb5b jmp 0x1410bc1e7
010bc18c 85c9 test ecx, ecx
010bc18e 0f84ba000000 je 0x1410bc24e
010bc194 7ef1 jle 0x1410bc187
010bc196 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010bc199 7fec jg 0x1410bc187
010bc19b 488b4210 mov rax, qword ptr [rdx + 0x10]
010bc19f 4c8d41ff lea r8, [rcx - 1]
010bc1a3 488b00 mov rax, qword ptr [rax]
010bc1a6 4e8d04c0 lea r8, [rax + r8*8]
010bc1aa 4d85c0 test r8, r8
010bc1ad 741f je 0x1410bc1ce
010bc1af 496308 movsxd rcx, dword ptr [r8]
010bc1b2 85c9 test ecx, ecx
010bc1b4 7818 js 0x1410bc1ce
010bc1b6 458b5004 mov r10d, dword ptr [r8 + 4]
010bc1ba 4585d2 test r10d, r10d
010bc1bd 7e0f jle 0x1410bc1ce
010bc1bf 488b4220 mov rax, qword ptr [rdx + 0x20]
010bc1c3 4c8bf9 mov r15, rcx
010bc1c6 458bca mov r9d, r10d
010bc1c9 4c0338 add r15, qword ptr [rax]
010bc1cc eb06 jmp 0x1410bc1d4
010bc1ce 41bbceffffff mov r11d, 0xffffffce
010bc1d4 41d1e9 shr r9d, 1
010bc1d7 4585db test r11d, r11d
010bc1da 0f848a000000 je 0x1410bc26a
010bc1e0 eb05 jmp 0x1410bc1e7
010bc1e2 448b4c2434 mov r9d, dword ptr [rsp + 0x34]
010bc1e7 498b5610 mov rdx, qword ptr [r14 + 0x10]
010bc1eb 4885d2 test rdx, rdx
010bc1ee 747a je 0x1410bc26a
010bc1f0 49638ed8000000 movsxd rcx, dword ptr [r14 + 0xd8]
010bc1f7 448bcb mov r9d, ebx
010bc1fa 4c8bfb mov r15, rbx
010bc1fd 4881c248040000 add rdx, 0x448
010bc204 7448 je 0x1410bc24e
010bc206 813a63727473 cmp dword ptr [rdx], 0x73747263
010bc20c 7540 jne 0x1410bc24e
010bc20e 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bc211 743b je 0x1410bc24e
010bc213 83f901 cmp ecx, 1
010bc216 7c36 jl 0x1410bc24e
010bc218 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010bc21b 7f31 jg 0x1410bc24e
010bc21d 488b4210 mov rax, qword ptr [rdx + 0x10]
010bc221 4c8d41ff lea r8, [rcx - 1]
010bc225 488b00 mov rax, qword ptr [rax]
010bc228 4e8d04c0 lea r8, [rax + r8*8]
010bc22c 4d85c0 test r8, r8
010bc22f 741d je 0x1410bc24e
010bc231 496308 movsxd rcx, dword ptr [r8]
010bc234 85c9 test ecx, ecx
010bc236 7816 js 0x1410bc24e
010bc238 458b5004 mov r10d, dword ptr [r8 + 4]
010bc23c 4585d2 test r10d, r10d
010bc23f 7e0d jle 0x1410bc24e
010bc241 488b4220 mov rax, qword ptr [rdx + 0x20]
010bc245 4c8bf9 mov r15, rcx
010bc248 458bca mov r9d, r10d
010bc24b 4c0338 add r15, qword ptr [rax]
010bc24e 41d1e9 shr r9d, 1
010bc251 8bd7 mov edx, edi
010bc253 4d8bc7 mov r8, r15
010bc256 498bcc mov rcx, r12
010bc259 e822c1ffff call 0x1410b8380
010bc25e 8bd8 mov ebx, eax
010bc260 e909050000 jmp 0x1410bc76e
010bc265 448b4c2434 mov r9d, dword ptr [rsp + 0x34]
010bc26a 8bd7 mov edx, edi
010bc26c 4d8bc7 mov r8, r15
010bc26f 498bcc mov rcx, r12
010bc272 e809c1ffff call 0x1410b8380
010bc277 8bd8 mov ebx, eax
010bc279 e9f0040000 jmp 0x1410bc76e
010bc27e 66899d70070000 mov word ptr [rbp + 0x770], bx
010bc285 4885f6 test rsi, rsi
010bc288 7423 je 0x1410bc2ad
010bc28a 488b4e10 mov rcx, qword ptr [rsi + 0x10]
010bc28e 4885c9 test rcx, rcx
010bc291 741a je 0x1410bc2ad
010bc293 488b5668 mov rdx, qword ptr [rsi + 0x68]
010bc297 4c8d8570070000 lea r8, [rbp + 0x770]
010bc29e 4881c118070000 add rcx, 0x718
010bc2a5 8b5230 mov edx, dword ptr [rdx + 0x30]
010bc2a8 e8c331b4ff call 0x140bff470
010bc2ad 66895c2450 mov word ptr [rsp + 0x50], bx
010bc2b2 4d85f6 test r14, r14
010bc2b5 7421 je 0x1410bc2d8
010bc2b7 498b4e10 mov rcx, qword ptr [r14 + 0x10]
010bc2bb 4885c9 test rcx, rcx
010bc2be 7418 je 0x1410bc2d8
010bc2c0 498b5668 mov rdx, qword ptr [r14 + 0x68]
010bc2c4 4c8d442450 lea r8, [rsp + 0x50]
010bc2c9 4881c118070000 add rcx, 0x718
010bc2d0 8b5230 mov edx, dword ptr [rdx + 0x30]
010bc2d3 e89831b4ff call 0x140bff470
010bc2d8 488d9560030000 lea rdx, [rbp + 0x360]
010bc2df 488d4c2450 lea rcx, [rsp + 0x50]
010bc2e4 e8578ffeff call 0x1410a5240
010bc2e9 488d542450 lea rdx, [rsp + 0x50]
010bc2ee 488d8d70070000 lea rcx, [rbp + 0x770]
010bc2f5 e8468ffeff call 0x1410a5240
010bc2fa 8b8550030000 mov eax, dword ptr [rbp + 0x350]
010bc300 3b8560070000 cmp eax, dword ptr [rbp + 0x760]
010bc306 0f8334f0ffff jae 0x1410bb340
010bc30c bfffffffff mov edi, 0xffffffff
010bc311 8bdf mov ebx, edi
010bc313 e956040000 jmp 0x1410bc76e
010bc318 498bce mov rcx, r14
010bc31b e8c095edff call 0x140f958e0
010bc320 488bce mov rcx, rsi
010bc323 448bf0 mov r14d, eax
010bc326 e8b595edff call 0x140f958e0
010bc32b 413bc6 cmp eax, r14d
010bc32e 0f8d8df4ffff jge 0x1410bb7c1
010bc334 bfffffffff mov edi, 0xffffffff
010bc339 8bdf mov ebx, edi
010bc33b e92e040000 jmp 0x1410bc76e
010bc340 498bce mov rcx, r14
010bc343 e84897edff call 0x140f95a90
010bc348 488bce mov rcx, rsi
010bc34b 448bf0 mov r14d, eax
010bc34e e83d97edff call 0x140f95a90
010bc353 413bc6 cmp eax, r14d
010bc356 0f8d65f4ffff jge 0x1410bb7c1
010bc35c bfffffffff mov edi, 0xffffffff
010bc361 8bdf mov ebx, edi
010bc363 e906040000 jmp 0x1410bc76e
010bc368 498b5658 mov rdx, qword ptr [r14 + 0x58]
010bc36c 488b4e58 mov rcx, qword ptr [rsi + 0x58]
010bc370 e8cbd9ffff call 0x1410b9d40
010bc375 8bd8 mov ebx, eax
010bc377 e9f2030000 jmp 0x1410bc76e
010bc37c 4885f6 test rsi, rsi
010bc37f 746a je 0x1410bc3eb
010bc381 488b5610 mov rdx, qword ptr [rsi + 0x10]
010bc385 4885d2 test rdx, rdx
010bc388 7461 je 0x1410bc3eb
010bc38a 488b4668 mov rax, qword ptr [rsi + 0x68]
010bc38e 448bd3 mov r10d, ebx
010bc391 48634840 movsxd rcx, dword ptr [rax + 0x40]
010bc395 4881c280080000 add rdx, 0x880
010bc39c 7448 je 0x1410bc3e6
010bc39e 813a63727473 cmp dword ptr [rdx], 0x73747263
010bc3a4 7540 jne 0x1410bc3e6
010bc3a6 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bc3a9 743b je 0x1410bc3e6
010bc3ab 83f901 cmp ecx, 1
010bc3ae 7c36 jl 0x1410bc3e6
010bc3b0 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010bc3b3 7f31 jg 0x1410bc3e6
010bc3b5 488b4210 mov rax, qword ptr [rdx + 0x10]
010bc3b9 4c8d41ff lea r8, [rcx - 1]
010bc3bd 488b00 mov rax, qword ptr [rax]
010bc3c0 4e8d04c0 lea r8, [rax + r8*8]
010bc3c4 4d85c0 test r8, r8
010bc3c7 741d je 0x1410bc3e6
010bc3c9 496308 movsxd rcx, dword ptr [r8]
010bc3cc 85c9 test ecx, ecx
010bc3ce 7816 js 0x1410bc3e6
010bc3d0 458b4804 mov r9d, dword ptr [r8 + 4]
010bc3d4 4585c9 test r9d, r9d
010bc3d7 7e0d jle 0x1410bc3e6
010bc3d9 488b4220 mov rax, qword ptr [rdx + 0x20]
010bc3dd 4c8be1 mov r12, rcx
010bc3e0 458bd1 mov r10d, r9d
010bc3e3 4c0320 add r12, qword ptr [rax]
010bc3e6 41d1ea shr r10d, 1
010bc3e9 eb05 jmp 0x1410bc3f0
010bc3eb 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bc3f0 4d85f6 test r14, r14
010bc3f3 0f8413e9ffff je 0x1410bad0c
010bc3f9 498b5610 mov rdx, qword ptr [r14 + 0x10]
010bc3fd 4885d2 test rdx, rdx
010bc400 0f8406e9ffff je 0x1410bad0c
010bc406 498b4668 mov rax, qword ptr [r14 + 0x68]
010bc40a 4881c280080000 add rdx, 0x880
010bc411 48634840 movsxd rcx, dword ptr [rax + 0x40]
010bc415 e971e8ffff jmp 0x1410bac8b
010bc41a 498b4668 mov rax, qword ptr [r14 + 0x68]
010bc41e 8b484c mov ecx, dword ptr [rax + 0x4c]
010bc421 488b4668 mov rax, qword ptr [rsi + 0x68]
010bc425 8b504c mov edx, dword ptr [rax + 0x4c]
010bc428 3bd1 cmp edx, ecx
010bc42a 0f843e030000 je 0x1410bc76e
010bc430 85d2 test edx, edx
010bc432 0f8431030000 je 0x1410bc769
010bc438 85c9 test ecx, ecx
010bc43a 0f84c7e5ffff je 0x1410baa07
010bc440 488d9570070000 lea rdx, [rbp + 0x770]
010bc447 488bce mov rcx, rsi
010bc44a e8119fe1ff call 0x140ed6360
010bc44f 488d542450 lea rdx, [rsp + 0x50]
010bc454 498bce mov rcx, r14
010bc457 e8049fe1ff call 0x140ed6360
010bc45c 440fb74c2450 movzx r9d, word ptr [rsp + 0x50]
010bc462 4c8d442452 lea r8, [rsp + 0x52]
010bc467 0fb79570070000 movzx edx, word ptr [rbp + 0x770]
010bc46e 488d8d72070000 lea rcx, [rbp + 0x772]
010bc475 c744242001000000 mov dword ptr [rsp + 0x20], 1
010bc47d e81e88a2ff call 0x140ae4ca0
010bc482 8bd8 mov ebx, eax
010bc484 e9e5020000 jmp 0x1410bc76e
010bc489 33d2 xor edx, edx
010bc48b 498bce mov rcx, r14
010bc48e e8dd46eeff call 0x140fa0b70
010bc493 33d2 xor edx, edx
010bc495 488bce mov rcx, rsi
010bc498 8bd8 mov ebx, eax
010bc49a e8d146eeff call 0x140fa0b70
010bc49f 8bc8 mov ecx, eax
010bc4a1 458bc5 mov r8d, r13d
010bc4a4 8bd3 mov edx, ebx
010bc4a6 e845050000 call 0x1410bc9f0
010bc4ab 8bd8 mov ebx, eax
010bc4ad e9bc020000 jmp 0x1410bc76e
010bc4b2 410fb6869f000000 movzx eax, byte ptr [r14 + 0x9f]
010bc4ba 0fb68e9f000000 movzx ecx, byte ptr [rsi + 0x9f]
010bc4c1 c0e806 shr al, 6
010bc4c4 2401 and al, 1
010bc4c6 c0e906 shr cl, 6
010bc4c9 80e101 and cl, 1
010bc4cc 3ac8 cmp cl, al
010bc4ce 0f836ceeffff jae 0x1410bb340
010bc4d4 bfffffffff mov edi, 0xffffffff
010bc4d9 8bdf mov ebx, edi
010bc4db e98e020000 jmp 0x1410bc76e
010bc4e0 410fb686a0000000 movzx eax, byte ptr [r14 + 0xa0]
010bc4e8 0fb68ea0000000 movzx ecx, byte ptr [rsi + 0xa0]
010bc4ef 2401 and al, 1
010bc4f1 ebd6 jmp 0x1410bc4c9
010bc4f3 498bce mov rcx, r14
010bc4f6 e83580eeff call 0x140fa4530
010bc4fb 488bce mov rcx, rsi
010bc4fe 440fb6f0 movzx r14d, al
010bc502 e82980eeff call 0x140fa4530
010bc507 413ac6 cmp al, r14b
010bc50a ebc2 jmp 0x1410bc4ce
010bc50c 4d85f6 test r14, r14
010bc50f 741e je 0x1410bc52f
010bc511 498b4628 mov rax, qword ptr [r14 + 0x28]
010bc515 4885c0 test rax, rax
010bc518 7415 je 0x1410bc52f
010bc51a 81780869626c61 cmp dword ptr [rax + 8], 0x616c6269
010bc521 750c jne 0x1410bc52f
010bc523 48395830 cmp qword ptr [rax + 0x30], rbx
010bc527 7406 je 0x1410bc52f
010bc529 0fb65073 movzx edx, byte ptr [rax + 0x73]
010bc52d eb02 jmp 0x1410bc531
010bc52f 32d2 xor dl, dl
010bc531 4885f6 test rsi, rsi
010bc534 7423 je 0x1410bc559
010bc536 488b4628 mov rax, qword ptr [rsi + 0x28]
010bc53a 4885c0 test rax, rax
010bc53d 741a je 0x1410bc559
010bc53f 81780869626c61 cmp dword ptr [rax + 8], 0x616c6269
010bc546 7511 jne 0x1410bc559
010bc548 48395830 cmp qword ptr [rax + 0x30], rbx
010bc54c 740b je 0x1410bc559
010bc54e 0fb64873 movzx ecx, byte ptr [rax + 0x73]
010bc552 3aca cmp cl, dl
010bc554 e975ffffff jmp 0x1410bc4ce
010bc559 32c9 xor cl, cl
010bc55b 3aca cmp cl, dl
010bc55d e96cffffff jmp 0x1410bc4ce
010bc562 4d85f6 test r14, r14
010bc565 7416 je 0x1410bc57d
010bc567 49395e10 cmp qword ptr [r14 + 0x10], rbx
010bc56b 7410 je 0x1410bc57d
010bc56d 410fb68ea0000000 movzx ecx, byte ptr [r14 + 0xa0]
010bc575 c0e902 shr cl, 2
010bc578 80e101 and cl, 1
010bc57b eb02 jmp 0x1410bc57f
010bc57d 32c9 xor cl, cl
010bc57f 4885f6 test rsi, rsi
010bc582 7419 je 0x1410bc59d
010bc584 48395e10 cmp qword ptr [rsi + 0x10], rbx
010bc588 7413 je 0x1410bc59d
010bc58a 0fb686a0000000 movzx eax, byte ptr [rsi + 0xa0]
010bc591 c0e802 shr al, 2
010bc594 2401 and al, 1
010bc596 3ac1 cmp al, cl
010bc598 e931ffffff jmp 0x1410bc4ce
010bc59d 32c0 xor al, al
010bc59f 3ac1 cmp al, cl
010bc5a1 e928ffffff jmp 0x1410bc4ce
010bc5a6 4885f6 test rsi, rsi
010bc5a9 746a je 0x1410bc615
010bc5ab 488b5610 mov rdx, qword ptr [rsi + 0x10]
010bc5af 4885d2 test rdx, rdx
010bc5b2 7461 je 0x1410bc615
010bc5b4 488b4668 mov rax, qword ptr [rsi + 0x68]
010bc5b8 448bd3 mov r10d, ebx
010bc5bb 48634818 movsxd rcx, dword ptr [rax + 0x18]
010bc5bf 4881c298020000 add rdx, 0x298
010bc5c6 7448 je 0x1410bc610
010bc5c8 813a63727473 cmp dword ptr [rdx], 0x73747263
010bc5ce 7540 jne 0x1410bc610
010bc5d0 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bc5d3 743b je 0x1410bc610
010bc5d5 83f901 cmp ecx, 1
010bc5d8 7c36 jl 0x1410bc610
010bc5da 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010bc5dd 7f31 jg 0x1410bc610
010bc5df 488b4210 mov rax, qword ptr [rdx + 0x10]
010bc5e3 4c8d41ff lea r8, [rcx - 1]
010bc5e7 488b00 mov rax, qword ptr [rax]
010bc5ea 4e8d04c0 lea r8, [rax + r8*8]
010bc5ee 4d85c0 test r8, r8
010bc5f1 741d je 0x1410bc610
010bc5f3 496308 movsxd rcx, dword ptr [r8]
010bc5f6 85c9 test ecx, ecx
010bc5f8 7816 js 0x1410bc610
010bc5fa 458b4804 mov r9d, dword ptr [r8 + 4]
010bc5fe 4585c9 test r9d, r9d
010bc601 7e0d jle 0x1410bc610
010bc603 488b4220 mov rax, qword ptr [rdx + 0x20]
010bc607 4c8be1 mov r12, rcx
010bc60a 458bd1 mov r10d, r9d
010bc60d 4c0320 add r12, qword ptr [rax]
010bc610 41d1ea shr r10d, 1
010bc613 eb05 jmp 0x1410bc61a
010bc615 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bc61a 4d85f6 test r14, r14
010bc61d 0f84e9e6ffff je 0x1410bad0c
010bc623 498b5610 mov rdx, qword ptr [r14 + 0x10]
010bc627 4885d2 test rdx, rdx
010bc62a 0f84dce6ffff je 0x1410bad0c
010bc630 498b4668 mov rax, qword ptr [r14 + 0x68]
010bc634 4881c298020000 add rdx, 0x298
010bc63b 48634818 movsxd rcx, dword ptr [rax + 0x18]
010bc63f e947e6ffff jmp 0x1410bac8b
010bc644 4885f6 test rsi, rsi
010bc647 746a je 0x1410bc6b3
010bc649 488b5610 mov rdx, qword ptr [rsi + 0x10]
010bc64d 4885d2 test rdx, rdx
010bc650 7461 je 0x1410bc6b3
010bc652 488b4668 mov rax, qword ptr [rsi + 0x68]
010bc656 448bd3 mov r10d, ebx
010bc659 4863481c movsxd rcx, dword ptr [rax + 0x1c]
010bc65d 4881c2e0020000 add rdx, 0x2e0
010bc664 7448 je 0x1410bc6ae
010bc666 813a63727473 cmp dword ptr [rdx], 0x73747263
010bc66c 7540 jne 0x1410bc6ae
010bc66e 395a3c cmp dword ptr [rdx + 0x3c], ebx
010bc671 743b je 0x1410bc6ae
010bc673 83f901 cmp ecx, 1
010bc676 7c36 jl 0x1410bc6ae
010bc678 3b4a2c cmp ecx, dword ptr [rdx + 0x2c]
010bc67b 7f31 jg 0x1410bc6ae
010bc67d 488b4210 mov rax, qword ptr [rdx + 0x10]
010bc681 4c8d41ff lea r8, [rcx - 1]
010bc685 488b00 mov rax, qword ptr [rax]
010bc688 4e8d04c0 lea r8, [rax + r8*8]
010bc68c 4d85c0 test r8, r8
010bc68f 741d je 0x1410bc6ae
010bc691 496308 movsxd rcx, dword ptr [r8]
010bc694 85c9 test ecx, ecx
010bc696 7816 js 0x1410bc6ae
010bc698 458b4804 mov r9d, dword ptr [r8 + 4]
010bc69c 4585c9 test r9d, r9d
010bc69f 7e0d jle 0x1410bc6ae
010bc6a1 488b4220 mov rax, qword ptr [rdx + 0x20]
010bc6a5 4c8be1 mov r12, rcx
010bc6a8 458bd1 mov r10d, r9d
010bc6ab 4c0320 add r12, qword ptr [rax]
010bc6ae 41d1ea shr r10d, 1
010bc6b1 eb05 jmp 0x1410bc6b8
010bc6b3 448b542430 mov r10d, dword ptr [rsp + 0x30]
010bc6b8 4d85f6 test r14, r14
010bc6bb 0f844be6ffff je 0x1410bad0c
010bc6c1 498b5610 mov rdx, qword ptr [r14 + 0x10]
010bc6c5 4885d2 test rdx, rdx
010bc6c8 0f843ee6ffff je 0x1410bad0c
010bc6ce 498b4668 mov rax, qword ptr [r14 + 0x68]
010bc6d2 4881c2e0020000 add rdx, 0x2e0
010bc6d9 4863481c movsxd rcx, dword ptr [rax + 0x1c]
010bc6dd e9a9e5ffff jmp 0x1410bac8b
010bc6e2 498b4668 mov rax, qword ptr [r14 + 0x68]
010bc6e6 0fb74814 movzx ecx, word ptr [rax + 0x14]
010bc6ea 488b4668 mov rax, qword ptr [rsi + 0x68]
010bc6ee 66394814 cmp word ptr [rax + 0x14], cx
010bc6f2 e9d7fdffff jmp 0x1410bc4ce
010bc6f7 498b4668 mov rax, qword ptr [r14 + 0x68]
010bc6fb 0fb74816 movzx ecx, word ptr [rax + 0x16]
010bc6ff 488b4668 mov rax, qword ptr [rsi + 0x68]
010bc703 66394816 cmp word ptr [rax + 0x16], cx
010bc707 e9c2fdffff jmp 0x1410bc4ce
010bc70c 498b4668 mov rax, qword ptr [r14 + 0x68]
010bc710 0fb608 movzx ecx, byte ptr [rax]
010bc713 488b4668 mov rax, qword ptr [rsi + 0x68]
010bc717 c0e903 shr cl, 3
010bc71a 80e101 and cl, 1
010bc71d 0fb610 movzx edx, byte ptr [rax]
010bc720 c0ea03 shr dl, 3
010bc723 80e201 and dl, 1
010bc726 3ad1 cmp dl, cl
010bc728 e9a1fdffff jmp 0x1410bc4ce
010bc72d 498b4670 mov rax, qword ptr [r14 + 0x70]
010bc731 0fb64820 movzx ecx, byte ptr [rax + 0x20]
010bc735 488b4670 mov rax, qword ptr [rsi + 0x70]
010bc739 384820 cmp byte ptr [rax + 0x20], cl
010bc73c e98dfdffff jmp 0x1410bc4ce
010bc741 498b4670 mov rax, qword ptr [r14 + 0x70]
010bc745 0fb64821 movzx ecx, byte ptr [rax + 0x21]
010bc749 488b4670 mov rax, qword ptr [rsi + 0x70]
010bc74d 384821 cmp byte ptr [rax + 0x21], cl
010bc750 e979fdffff jmp 0x1410bc4ce
010bc755 498b4670 mov rax, qword ptr [r14 + 0x70]
010bc759 0fb64822 movzx ecx, byte ptr [rax + 0x22]
010bc75d 488b4670 mov rax, qword ptr [rsi + 0x70]
010bc761 384822 cmp byte ptr [rax + 0x22], cl
010bc764 e965fdffff jmp 0x1410bc4ce
010bc769 bbffffffff mov ebx, 0xffffffff
010bc76e 8bc3 mov eax, ebx
010bc770 488b8d70090000 mov rcx, qword ptr [rbp + 0x970]
010bc777 4833cc xor rcx, rsp
010bc77a e861f16d00 call 0x14179b8e0
010bc77f 4881c4880a0000 add rsp, 0xa88
010bc786 415f pop r15
010bc788 415e pop r14
010bc78a 415d pop r13
010bc78c 415c pop r12
010bc78e 5f pop rdi
010bc78f 5e pop rsi
010bc790 5b pop rbx
010bc791 5d pop rbp
010bc792 c3 ret 
010bc793 90 nop 