01017ff0 48896c2418 mov qword ptr [rsp + 0x18], rbp
01017ff5 57 push rdi
01017ff6 4883ec30 sub rsp, 0x30
01017ffa 488bea mov rbp, rdx
01017ffd 488bf9 mov rdi, rcx
01018000 4885d2 test rdx, rdx
01018003 7510 jne 0x141018015
01018005 b8ceffffff mov eax, 0xffffffce
0101800a 488b6c2450 mov rbp, qword ptr [rsp + 0x50]
0101800f 4883c430 add rsp, 0x30
01018013 5f pop rdi
01018014 c3 ret 
01018015 48895c2440 mov qword ptr [rsp + 0x40], rbx
0101801a 488b5a08 mov rbx, qword ptr [rdx + 8]
0101801e 4889742448 mov qword ptr [rsp + 0x48], rsi
01018023 33f6 xor esi, esi
01018025 4885db test rbx, rbx
01018028 7449 je 0x141018073
0101802a 48397310 cmp qword ptr [rbx + 0x10], rsi
0101802e 7443 je 0x141018073
01018030 f6839a00000001 test byte ptr [rbx + 0x9a], 1
01018037 743a je 0x141018073
01018039 488b4368 mov rax, qword ptr [rbx + 0x68]
0101803d 8b4810 mov ecx, dword ptr [rax + 0x10]
01018040 85c9 test ecx, ecx
01018042 7531 jne 0x141018075
01018044 39b3ac000000 cmp dword ptr [rbx + 0xac], esi
0101804a 751f jne 0x14101806b
0101804c 488bcb mov rcx, rbx
0101804f e8ec91f7ff call 0x140f91240
01018054 8983ac000000 mov dword ptr [rbx + 0xac], eax
0101805a 85c0 test eax, eax
0101805c 740d je 0x14101806b
0101805e ba3c000000 mov edx, 0x3c
01018063 488bcb mov rcx, rbx
01018066 e895c0f7ff call 0x140f94100
0101806b 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
01018071 eb02 jmp 0x141018075
01018073 8bce mov ecx, esi
01018075 898f040a0000 mov dword ptr [rdi + 0xa04], ecx
0101807b 81e1620c0000 and ecx, 0xc62
01018081 0f95c0 setne al
01018084 8887000a0000 mov byte ptr [rdi + 0xa00], al
0101808a 488b4508 mov rax, qword ptr [rbp + 8]
0101808e 4885c0 test rax, rax
01018091 740e je 0x1410180a1
01018093 48397010 cmp qword ptr [rax + 0x10], rsi
01018097 7408 je 0x1410180a1
01018099 488b4510 mov rax, qword ptr [rbp + 0x10]
0101809d 488b7038 mov rsi, qword ptr [rax + 0x38]
010180a1 4889b740040000 mov qword ptr [rdi + 0x440], rsi
010180a8 85c9 test ecx, ecx
010180aa 7407 je 0x1410180b3
010180ac c6875004000001 mov byte ptr [rdi + 0x450], 1
010180b3 488d9f9c540000 lea rbx, [rdi + 0x549c]
010180ba 488db768200000 lea rsi, [rdi + 0x2068]
010180c1 4881c7080a0000 add rdi, 0xa08
010180c8 7417 je 0x1410180e1
010180ca 33d2 xor edx, edx
010180cc 41b860160000 mov r8d, 0x1660
010180d2 488bcf mov rcx, rdi
010180d5 e8c64b7800 call 0x14179cca0
010180da c7470460160000 mov dword ptr [rdi + 4], 0x1660
010180e1 4885f6 test rsi, rsi
010180e4 7410 je 0x1410180f6
010180e6 33d2 xor edx, edx
010180e8 41b834340000 mov r8d, 0x3434
010180ee 488bce mov rcx, rsi
010180f1 e8aa4b7800 call 0x14179cca0
010180f6 4885db test rbx, rbx
010180f9 741f je 0x14101811a
010180fb 0f57c0 xorps xmm0, xmm0
010180fe 33c0 xor eax, eax
01018100 0f1103 movups xmmword ptr [rbx], xmm0
01018103 0f114310 movups xmmword ptr [rbx + 0x10], xmm0
01018107 0f114320 movups xmmword ptr [rbx + 0x20], xmm0
0101810b 0f114330 movups xmmword ptr [rbx + 0x30], xmm0
0101810f 0f114340 movups xmmword ptr [rbx + 0x40], xmm0
01018113 48894350 mov qword ptr [rbx + 0x50], rax
01018117 894358 mov dword ptr [rbx + 0x58], eax
0101811a 4c8bce mov r9, rsi
0101811d 48895c2420 mov qword ptr [rsp + 0x20], rbx
01018122 4c8bc7 mov r8, rdi
01018125 33d2 xor edx, edx
01018127 488bcd mov rcx, rbp
0101812a e891d1eaff call 0x140ec52c0
0101812f 488b742448 mov rsi, qword ptr [rsp + 0x48]
01018134 33c0 xor eax, eax
01018136 488b5c2440 mov rbx, qword ptr [rsp + 0x40]
0101813b 488b6c2450 mov rbp, qword ptr [rsp + 0x50]
01018140 4883c430 add rsp, 0x30
01018144 5f pop rdi
01018145 c3 ret 