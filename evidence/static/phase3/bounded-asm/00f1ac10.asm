00f1ac10 48895c2408 mov qword ptr [rsp + 8], rbx
00f1ac15 57 push rdi
00f1ac16 4883ec20 sub rsp, 0x20
00f1ac1a 488bfa mov rdi, rdx
00f1ac1d 488bd9 mov rbx, rcx
00f1ac20 e81baf46ff call 0x140385b40
00f1ac25 488bcf mov rcx, rdi
00f1ac28 488bd0 mov rdx, rax
00f1ac2b e8c092ffff call 0x140f13ef0
00f1ac30 88423d mov byte ptr [rdx + 0x3d], al
00f1ac33 448b4718 mov r8d, dword ptr [rdi + 0x18]
00f1ac37 4489829c020000 mov dword ptr [rdx + 0x29c], r8d
00f1ac3e 4885db test rbx, rbx
00f1ac41 741d je 0x140f1ac60
00f1ac43 48837b1000 cmp qword ptr [rbx + 0x10], 0
00f1ac48 7416 je 0x140f1ac60
00f1ac4a f6839b00000020 test byte ptr [rbx + 0x9b], 0x20
00f1ac51 751b jne 0x140f1ac6e
00f1ac53 488b8380000000 mov rax, qword ptr [rbx + 0x80]
00f1ac5a f6400104 test byte ptr [rax + 1], 4
00f1ac5e 750e jne 0x140f1ac6e
00f1ac60 808b9d00000008 or byte ptr [rbx + 0x9d], 8
00f1ac67 808b9a00000002 or byte ptr [rbx + 0x9a], 2
00f1ac6e c742344c4e5744 mov dword ptr [rdx + 0x34], 0x44574e4c
00f1ac75 817f1074696e64 cmp dword ptr [rdi + 0x10], 0x646e6974
00f1ac7c 7404 je 0x140f1ac82
00f1ac7e 33c0 xor eax, eax
00f1ac80 eb03 jmp 0x140f1ac85
00f1ac82 8b4718 mov eax, dword ptr [rdi + 0x18]
00f1ac85 89829c020000 mov dword ptr [rdx + 0x29c], eax
00f1ac8b 8b8704010000 mov eax, dword ptr [rdi + 0x104]
00f1ac91 8983ac000000 mov dword ptr [rbx + 0xac], eax
00f1ac97 a904002000 test eax, 0x200004
00f1ac9c 7418 je 0x140f1acb6
00f1ac9e 808b9d00000040 or byte ptr [rbx + 0x9d], 0x40
00f1aca5 85c0 test eax, eax
00f1aca7 740d je 0x140f1acb6
00f1aca9 0fbaf015 btr eax, 0x15
00f1acad 83c804 or eax, 4
00f1acb0 8983ac000000 mov dword ptr [rbx + 0xac], eax
00f1acb6 488b5c2430 mov rbx, qword ptr [rsp + 0x30]
00f1acbb 4883c420 add rsp, 0x20
00f1acbf 5f pop rdi
00f1acc0 c3 ret 