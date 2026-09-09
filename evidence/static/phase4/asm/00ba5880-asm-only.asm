; iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; RVA 0xba5880
00ba5880 4c8bdc                   mov r11, rsp
00ba5883 49896b18                 mov qword ptr [r11 + 0x18], rbp
00ba5887 49897320                 mov qword ptr [r11 + 0x20], rsi
00ba588b 57                       push rdi
00ba588c 4156                     push r14
00ba588e 4157                     push r15
00ba5890 4881ec20010000           sub rsp, 0x120
00ba5897 488b05a2f74201           mov rax, qword ptr [rip + 0x142f7a2]
00ba589e 4833c4                   xor rax, rsp
00ba58a1 4889842418010000         mov qword ptr [rsp + 0x118], rax
00ba58a9 4885c9                   test rcx, rcx
00ba58ac 49895b10                 mov qword ptr [r11 + 0x10], rbx
00ba58b0 498d7bd0                 lea rdi, [r11 - 0x30]
00ba58b4 41bf10000000             mov r15d, 0x10
00ba58ba 480f45f9                 cmovne rdi, rcx
00ba58be 488d2d9b195601           lea rbp, [rip + 0x156199b]
00ba58c5 4533f6                   xor r14d, r14d
00ba58c8 488d35f1d74601           lea rsi, [rip + 0x146d7f1]
00ba58cf 4c897708                 mov qword ptr [rdi + 8], r14
00ba58d3 4c8937                   mov qword ptr [rdi], r14
00ba58d6 4c397708                 cmp qword ptr [rdi + 8], r14
00ba58da 7409                     je 0x140ba58e5
00ba58dc 4c3937                   cmp qword ptr [rdi], r14
00ba58df 0f8588010000             jne 0x140ba5a6d
00ba58e5 443935bc195601           cmp dword ptr [rip + 0x15619bc], r14d
00ba58ec 4488b424e0000000         mov byte ptr [rsp + 0xe0], r14b
00ba58f4 4489b424e4000000         mov dword ptr [rsp + 0xe4], r14d
00ba58fc 0f8504010000             jne 0x140ba5a06
00ba5902 443835b7d74601           cmp byte ptr [rip + 0x146d7b7], r14b
00ba5909 488bd5                   mov rdx, rbp
00ba590c 741f                     je 0x140ba592d
00ba590e 488bce                   mov rcx, rsi
00ba5911 488bc1                   mov rax, rcx
00ba5914 482bc6                   sub rax, rsi
00ba5917 4883f82b                 cmp rax, 0x2b
00ba591b 7410                     je 0x140ba592d
00ba591d 0fb601                   movzx eax, byte ptr [rcx]
00ba5920 48ffc1                   inc rcx
00ba5923 8802                     mov byte ptr [rdx], al
00ba5925 48ffc2                   inc rdx
00ba5928 443831                   cmp byte ptr [rcx], r14b
00ba592b 75e4                     jne 0x140ba5911
00ba592d 448832                   mov byte ptr [rdx], r14b
00ba5930 488d4c2420               lea rcx, [rsp + 0x20]
00ba5935 ba04000000               mov edx, 4
00ba593a e8f1d0c300               call 0x1417e2a30
00ba593f 85c0                     test eax, eax
00ba5941 7806                     js 0x140ba5949
00ba5943 8b442420                 mov eax, dword ptr [rsp + 0x20]
00ba5947 eb06                     jmp 0x140ba594f
00ba5949 ff15216fd400             call qword ptr [rip + 0xd46f21]
00ba594f 488d4c2428               lea rcx, [rsp + 0x28]
00ba5954 890536195601             mov dword ptr [rip + 0x1561936], eax
00ba595a ff152852d400             call qword ptr [rip + 0xd45228]
00ba5960 0f57c0                   xorps xmm0, xmm0
00ba5963 c7053b19560101000000     mov dword ptr [rip + 0x156193b], 1
00ba596d f2480f2a442428           cvtsi2sd xmm0, qword ptr [rsp + 0x28]
00ba5974 f20f59054ca05201         mulsd xmm0, qword ptr [rip + 0x152a04c]
00ba597c f20f110514195601         movsd qword ptr [rip + 0x1561914], xmm0
00ba5984 ff154e34d400             call qword ptr [rip + 0xd4344e]
00ba598a 488b05bf34d400           mov rax, qword ptr [rip + 0xd434bf]
00ba5991 f20f5800                 addsd xmm0, qword ptr [rax]
00ba5995 f2480f2cc8               cvttsd2si rcx, xmm0
00ba599a e8212c0200               call 0x140bc85c0
00ba599f 33d2                     xor edx, edx
00ba59a1 8905ed185601             mov dword ptr [rip + 0x15618ed], eax
00ba59a7 488d0df2185601           lea rcx, [rip + 0x15618f2]
00ba59ae e8ddf5fdff               call 0x140b84f90
00ba59b3 488d4c2430               lea rcx, [rsp + 0x30]
00ba59b8 e8e3f9fdff               call 0x140b853a0
00ba59bd 83f8ff                   cmp eax, -1
00ba59c0 7444                     je 0x140ba5a06
00ba59c2 488b5c2430               mov rbx, qword ptr [rsp + 0x30]
00ba59c7 488bc3                   mov rax, rbx
00ba59ca 4885db                   test rbx, rbx
00ba59cd 742f                     je 0x140ba59fe
00ba59cf 90                       nop 
00ba59d0 488b4818                 mov rcx, qword ptr [rax + 0x18]
00ba59d4 4885c9                   test rcx, rcx
00ba59d7 740c                     je 0x140ba59e5
00ba59d9 66833902                 cmp word ptr [rcx], 2
00ba59dd 7506                     jne 0x140ba59e5
00ba59df f6401004                 test byte ptr [rax + 0x10], 4
00ba59e3 740a                     je 0x140ba59ef
00ba59e5 488b00                   mov rax, qword ptr [rax]
00ba59e8 4885c0                   test rax, rax
00ba59eb 75e3                     jne 0x140ba59d0
00ba59ed eb0f                     jmp 0x140ba59fe
00ba59ef 8b4904                   mov ecx, dword ptr [rcx + 4]
00ba59f2 ff152868d400             call qword ptr [rip + 0xd46828]
00ba59f8 89058e185601             mov dword ptr [rip + 0x156188e], eax
00ba59fe 488bcb                   mov rcx, rbx
00ba5a01 e8fafcfdff               call 0x140b85700
00ba5a06 f0ff059b185601           lock inc dword ptr [rip + 0x156189b]
00ba5a0d b201                     mov dl, 1
00ba5a0f 488d4c2440               lea rcx, [rsp + 0x40]
00ba5a14 e837d40200               call 0x140bd2e50
00ba5a19 85c0                     test eax, eax
00ba5a1b 7550                     jne 0x140ba5a6d
00ba5a1d 41b850000000             mov r8d, 0x50
00ba5a23 488d4c2440               lea rcx, [rsp + 0x40]
00ba5a28 488bd5                   mov rdx, rbp
00ba5a2b ff542458                 call qword ptr [rsp + 0x58]
00ba5a2f 488d9424e0000000         lea rdx, [rsp + 0xe0]
00ba5a37 488d4c2440               lea rcx, [rsp + 0x40]
00ba5a3c ff542450                 call qword ptr [rsp + 0x50]
00ba5a40 8b8424e4000000           mov eax, dword ptr [rsp + 0xe4]
00ba5a47 488d9424e8000000         lea rdx, [rsp + 0xe8]
00ba5a4f 413bc7                   cmp eax, r15d
00ba5a52 488bcf                   mov rcx, rdi
00ba5a55 410f47c7                 cmova eax, r15d
00ba5a59 448bc0                   mov r8d, eax
00ba5a5c 898424e4000000           mov dword ptr [rsp + 0xe4], eax
00ba5a63 e83272bf00               call 0x14179cc9a
00ba5a68 e969feffff               jmp 0x140ba58d6
00ba5a6d 488b4708                 mov rax, qword ptr [rdi + 8]
00ba5a71 488b9c2448010000         mov rbx, qword ptr [rsp + 0x148]
00ba5a79 488b8c2418010000         mov rcx, qword ptr [rsp + 0x118]
00ba5a81 4833cc                   xor rcx, rsp
00ba5a84 e8575ebf00               call 0x14179b8e0
00ba5a89 4c8d9c2420010000         lea r11, [rsp + 0x120]
00ba5a91 498b6b30                 mov rbp, qword ptr [r11 + 0x30]
00ba5a95 498b7338                 mov rsi, qword ptr [r11 + 0x38]
00ba5a99 498be3                   mov rsp, r11
00ba5a9c 415f                     pop r15
00ba5a9e 415e                     pop r14
00ba5aa0 5f                       pop rdi
00ba5aa1 c3                       ret 