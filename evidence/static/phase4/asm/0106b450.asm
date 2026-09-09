; Original iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0x106b450
; Unwind range 0x106b450..0x106b526, end exclusive
0106b450 48895c2408               mov qword ptr [rsp + 8], rbx
0106b455 4889742410               mov qword ptr [rsp + 0x10], rsi
0106b45a 48897c2418               mov qword ptr [rsp + 0x18], rdi
0106b45f 4156                     push r14
0106b461 4883ec20                 sub rsp, 0x20
0106b465 488bd9                   mov rbx, rcx
0106b468 4885c9                   test rcx, rcx
0106b46b 0f849d000000             je 0x14106b50e
0106b471 488b7908                 mov rdi, qword ptr [rcx + 8]
0106b475 4885ff                   test rdi, rdi
0106b478 0f8490000000             je 0x14106b50e
0106b47e 48837f1000               cmp qword ptr [rdi + 0x10], 0
0106b483 0f8485000000             je 0x14106b50e
0106b489 f6879a00000008           test byte ptr [rdi + 0x9a], 8
0106b490 757c                     jne 0x14106b50e
0106b492 83ea01                   sub edx, 1
0106b495 740e                     je 0x14106b4a5
0106b497 83fa0c                   cmp edx, 0xc
0106b49a 7572                     jne 0x14106b50e
0106b49c 483b4f58                 cmp rcx, qword ptr [rdi + 0x58]
0106b4a0 0f95c0                   setne al
0106b4a3 eb07                     jmp 0x14106b4ac
0106b4a5 483b5f58                 cmp rbx, qword ptr [rdi + 0x58]
0106b4a9 0f94c0                   sete al
0106b4ac 84c0                     test al, al
0106b4ae 745e                     je 0x14106b50e
0106b4b0 48837f6000               cmp qword ptr [rdi + 0x60], 0
0106b4b5 7457                     je 0x14106b50e
0106b4b7 81793444524853           cmp dword ptr [rcx + 0x34], 0x53485244
0106b4be 4c8d7134                 lea r14, [rcx + 0x34]
0106b4c2 751d                     jne 0x14106b4e1
0106b4c4 4c8d7134                 lea r14, [rcx + 0x34]
0106b4c8 e833e6f3ff               call 0x140fa9b00
0106b4cd 84c0                     test al, al
0106b4cf 7510                     jne 0x14106b4e1
0106b4d1 488bcb                   mov rcx, rbx
0106b4d4 4c8d7334                 lea r14, [rbx + 0x34]
0106b4d8 e873e7f3ff               call 0x140fa9c50
0106b4dd 84c0                     test al, al
0106b4df 752d                     jne 0x14106b50e
0106b4e1 33d2                     xor edx, edx
0106b4e3 488bcf                   mov rcx, rdi
0106b4e6 e88556f3ff               call 0x140fa0b70
0106b4eb a904002000               test eax, 0x200004
0106b4f0 7508                     jne 0x14106b4fa
0106b4f2 488bcb                   mov rcx, rbx
0106b4f5 e806e6f3ff               call 0x140fa9b00
0106b4fa 418b06                   mov eax, dword ptr [r14]
0106b4fd 3d4c4e5744               cmp eax, 0x44574e4c
0106b502 740a                     je 0x14106b50e
0106b504 3d4655424d               cmp eax, 0x4d425546
0106b509 0f95c0                   setne al
0106b50c eb02                     jmp 0x14106b510
0106b50e 32c0                     xor al, al
0106b510 488b5c2430               mov rbx, qword ptr [rsp + 0x30]
0106b515 488b742438               mov rsi, qword ptr [rsp + 0x38]
0106b51a 488b7c2440               mov rdi, qword ptr [rsp + 0x40]
0106b51f 4883c420                 add rsp, 0x20
0106b523 415e                     pop r14
0106b525 c3                       ret 