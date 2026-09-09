00f1b7e0 4885c9 test rcx, rcx
00f1b7e3 0f84c8010000 je 0x140f1b9b1
00f1b7e9 48895c2418 mov qword ptr [rsp + 0x18], rbx
00f1b7ee 56 push rsi
00f1b7ef 4883ec30 sub rsp, 0x30
00f1b7f3 33f6 xor esi, esi
00f1b7f5 488d8180070000 lea rax, [rcx + 0x780]
00f1b7fc 4885c9 test rcx, rcx
00f1b7ff 488bd9 mov rbx, rcx
00f1b802 480f45f0 cmovne rsi, rax
00f1b806 81791074696e64 cmp dword ptr [rcx + 0x10], 0x646e6974
00f1b80d 0f8594010000 jne 0x140f1b9a7
00f1b813 4883792000 cmp qword ptr [rcx + 0x20], 0
00f1b818 0f8489010000 je 0x140f1b9a7
00f1b81e 80b94007000000 cmp byte ptr [rcx + 0x740], 0
00f1b825 0f857c010000 jne 0x140f1b9a7
00f1b82b 80bec80b000000 cmp byte ptr [rsi + 0xbc8], 0
00f1b832 7508 jne 0x140f1b83c
00f1b834 488bce mov rcx, rsi
00f1b837 e824faffff call 0x140f1b260
00f1b83c 80bec90b000000 cmp byte ptr [rsi + 0xbc9], 0
00f1b843 0f845e010000 je 0x140f1b9a7
00f1b849 48896c2440 mov qword ptr [rsp + 0x40], rbp
00f1b84e 488dabb0000000 lea rbp, [rbx + 0xb0]
00f1b855 488bcd mov rcx, rbp
00f1b858 e8b305feff call 0x140efbe10
00f1b85d 4885c0 test rax, rax
00f1b860 0f843c010000 je 0x140f1b9a2
00f1b866 4883783000 cmp qword ptr [rax + 0x30], 0
00f1b86b 0f8431010000 je 0x140f1b9a2
00f1b871 4885ed test rbp, rbp
00f1b874 0f8428010000 je 0x140f1b9a2
00f1b87a 488bcd mov rcx, rbp
00f1b87d 48897c2448 mov qword ptr [rsp + 0x48], rdi
00f1b882 e8597efbff call 0x140ed36e0
00f1b887 488bf8 mov rdi, rax
00f1b88a 4885c0 test rax, rax
00f1b88d 7522 jne 0x140f1b8b1
00f1b88f 488bcd mov rcx, rbp
00f1b892 e87905feff call 0x140efbe10
00f1b897 4885c0 test rax, rax
00f1b89a 0f84fd000000 je 0x140f1b99d
00f1b8a0 488b7830 mov rdi, qword ptr [rax + 0x30]
00f1b8a4 4885ff test rdi, rdi
00f1b8a7 0f84f0000000 je 0x140f1b99d
00f1b8ad 488b7f58 mov rdi, qword ptr [rdi + 0x58]
00f1b8b1 4885ff test rdi, rdi
00f1b8b4 0f84e3000000 je 0x140f1b99d
00f1b8ba 80beca0b000000 cmp byte ptr [rsi + 0xbca], 0
00f1b8c1 743e je 0x140f1b901
00f1b8c3 488b4708 mov rax, qword ptr [rdi + 8]
00f1b8c7 80a09d000000f7 and byte ptr [rax + 0x9d], 0xf7
00f1b8ce 488b4708 mov rax, qword ptr [rdi + 8]
00f1b8d2 80a09a000000fd and byte ptr [rax + 0x9a], 0xfd
00f1b8d9 817f344c4e5744 cmp dword ptr [rdi + 0x34], 0x44574e4c
00f1b8e0 7563 jne 0x140f1b945
00f1b8e2 81bb10030000656c6966 cmp dword ptr [rbx + 0x310], 0x66696c65
00f1b8ec 7557 jne 0x140f1b945
00f1b8ee 4c8d4778 lea r8, [rdi + 0x78]
00f1b8f2 ba4c4e5744 mov edx, 0x44574e4c
00f1b8f7 488bcb mov rcx, rbx
00f1b8fa e8d1f3ffff call 0x140f1acd0
00f1b8ff eb44 jmp 0x140f1b945
00f1b901 488bcf mov rcx, rdi
00f1b904 e8f7e10800 call 0x140fa9b00
00f1b909 84c0 test al, al
00f1b90b 7538 jne 0x140f1b945
00f1b90d 488b4f08 mov rcx, qword ptr [rdi + 8]
00f1b911 4885c9 test rcx, rcx
00f1b914 741d je 0x140f1b933
00f1b916 4883791000 cmp qword ptr [rcx + 0x10], 0
00f1b91b 7416 je 0x140f1b933
00f1b91d f6819b00000020 test byte ptr [rcx + 0x9b], 0x20
00f1b924 751f jne 0x140f1b945
00f1b926 488b8180000000 mov rax, qword ptr [rcx + 0x80]
00f1b92d f6400104 test byte ptr [rax + 1], 4
00f1b931 7512 jne 0x140f1b945
00f1b933 80899d00000008 or byte ptr [rcx + 0x9d], 8
00f1b93a 488b4708 mov rax, qword ptr [rdi + 8]
00f1b93e 80889a00000002 or byte ptr [rax + 0x9a], 2
00f1b945 488b4b28 mov rcx, qword ptr [rbx + 0x28]
00f1b949 4885c9 test rcx, rcx
00f1b94c 744f je 0x140f1b99d
00f1b94e 80791700 cmp byte ptr [rcx + 0x17], 0
00f1b952 741d je 0x140f1b971
00f1b954 4883c170 add rcx, 0x70
00f1b958 48c744242000000000 mov qword ptr [rsp + 0x20], 0
00f1b961 4533c9 xor r9d, r9d
00f1b964 4c8bc3 mov r8, rbx
00f1b967 ba63696d64 mov edx, 0x646d6963
00f1b96c e8afa3bdff call 0x140af5d20
00f1b971 488b4b28 mov rcx, qword ptr [rbx + 0x28]
00f1b975 4885c9 test rcx, rcx
00f1b978 7423 je 0x140f1b99d
00f1b97a 80791700 cmp byte ptr [rcx + 0x17], 0
00f1b97e 741d je 0x140f1b99d
00f1b980 4883c170 add rcx, 0x70
00f1b984 48c744242000000000 mov qword ptr [rsp + 0x20], 0
00f1b98d 4533c9 xor r9d, r9d
00f1b990 4c8bc3 mov r8, rbx
00f1b993 ba70696d64 mov edx, 0x646d6970
00f1b998 e883a3bdff call 0x140af5d20
00f1b99d 488b7c2448 mov rdi, qword ptr [rsp + 0x48]
00f1b9a2 488b6c2440 mov rbp, qword ptr [rsp + 0x40]
00f1b9a7 488b5c2450 mov rbx, qword ptr [rsp + 0x50]
00f1b9ac 4883c430 add rsp, 0x30
00f1b9b0 5e pop rsi
00f1b9b1 c3 ret 