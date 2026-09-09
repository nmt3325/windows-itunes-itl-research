00fd8930 48895c2418 mov qword ptr [rsp + 0x18], rbx
00fd8935 55 push rbp
00fd8936 56 push rsi
00fd8937 57 push rdi
00fd8938 4154 push r12
00fd893a 4155 push r13
00fd893c 4156 push r14
00fd893e 4157 push r15
00fd8940 488dac2470feffff lea rbp, [rsp - 0x190]
00fd8948 4881ec90020000 sub rsp, 0x290
00fd894f 488b05eac6ff00 mov rax, qword ptr [rip + 0xffc6ea]
00fd8956 4833c4 xor rax, rsp
00fd8959 48898580010000 mov qword ptr [rbp + 0x180], rax
00fd8960 488b5a08 mov rbx, qword ptr [rdx + 8]
00fd8964 4533e4 xor r12d, r12d
00fd8967 4c8b95f0010000 mov r10, qword ptr [rbp + 0x1f0]
00fd896e 488bf2 mov rsi, rdx
00fd8971 4c894c2440 mov qword ptr [rsp + 0x40], r9
00fd8976 4c8bf9 mov r15, rcx
00fd8979 48894c2460 mov qword ptr [rsp + 0x60], rcx
00fd897e 458bec mov r13d, r12d
00fd8981 4c89542450 mov qword ptr [rsp + 0x50], r10
00fd8986 4885db test rbx, rbx
00fd8989 7406 je 0x140fd8991
00fd898b 4c8b7310 mov r14, qword ptr [rbx + 0x10]
00fd898f eb03 jmp 0x140fd8994
00fd8991 4d8bf4 mov r14, r12
00fd8994 458822 mov byte ptr [r10], r12b
00fd8997 498bfc mov rdi, r12
00fd899a 8b11 mov edx, dword ptr [rcx]
00fd899c 41b001 mov r8b, 1
00fd899f 4489642458 mov dword ptr [rsp + 0x58], r12d
00fd89a4 8d42fe lea eax, [rdx - 2]
00fd89a7 3dea000000 cmp eax, 0xea
00fd89ac 0f87d10d0000 ja 0x140fd9783
00fd89b2 4c8d1d477602ff lea r11, [rip - 0xfd89b9]
00fd89b9 410fb684036c99fd00 movzx eax, byte ptr [r11 + rax + 0xfd996c]
00fd89c2 418b8c83b897fd00 mov ecx, dword ptr [r11 + rax*4 + 0xfd97b8]
00fd89ca 4903cb add rcx, r11
00fd89cd ffe1 jmp rcx
00fd89cf 8bb3b0000000 mov esi, dword ptr [rbx + 0xb0]
00fd89d5 4d8dbe78010000 lea r15, [r14 + 0x178]
00fd89dc e9310b0000 jmp 0x140fd9512
00fd89e1 8bb360010000 mov esi, dword ptr [rbx + 0x160]
00fd89e7 4d8dbe68170000 lea r15, [r14 + 0x1768]
00fd89ee 89742448 mov dword ptr [rsp + 0x48], esi
00fd89f2 85f6 test esi, esi
00fd89f4 0f851c0b0000 jne 0x140fd9516
00fd89fa 41387908 cmp byte ptr [r9 + 8], dil
00fd89fe 0f85120b0000 jne 0x140fd9516
00fd8a04 8bb3b0000000 mov esi, dword ptr [rbx + 0xb0]
00fd8a0a 4d8dbe78010000 lea r15, [r14 + 0x178]
00fd8a11 4532c0 xor r8b, r8b
00fd8a14 e9f90a0000 jmp 0x140fd9512
00fd8a19 8bb3bc000000 mov esi, dword ptr [rbx + 0xbc]
00fd8a1f 4d8dbec0010000 lea r15, [r14 + 0x1c0]
00fd8a26 e9e70a0000 jmp 0x140fd9512
00fd8a2b 8bb364010000 mov esi, dword ptr [rbx + 0x164]
00fd8a31 4d8dbeb0170000 lea r15, [r14 + 0x17b0]
00fd8a38 89742448 mov dword ptr [rsp + 0x48], esi
00fd8a3c 85f6 test esi, esi
00fd8a3e 0f85d20a0000 jne 0x140fd9516
00fd8a44 41387908 cmp byte ptr [r9 + 8], dil
00fd8a48 0f85c80a0000 jne 0x140fd9516
00fd8a4e 8bb3bc000000 mov esi, dword ptr [rbx + 0xbc]
00fd8a54 4d8dbec0010000 lea r15, [r14 + 0x1c0]
00fd8a5b 4532c0 xor r8b, r8b
00fd8a5e e9af0a0000 jmp 0x140fd9512
00fd8a63 8bb3c0000000 mov esi, dword ptr [rbx + 0xc0]
00fd8a69 4d8dbe50020000 lea r15, [r14 + 0x250]
00fd8a70 e99d0a0000 jmp 0x140fd9512
00fd8a75 8bb3d8000000 mov esi, dword ptr [rbx + 0xd8]
00fd8a7b 4d8dbe48040000 lea r15, [r14 + 0x448]
00fd8a82 e98b0a0000 jmp 0x140fd9512
00fd8a87 488bcb mov rcx, rbx
00fd8a8a 4d8dbe48040000 lea r15, [r14 + 0x448]
00fd8a91 e84a60fcff call 0x140f9eae0
00fd8a96 8bf0 mov esi, eax
00fd8a98 89442448 mov dword ptr [rsp + 0x48], eax
00fd8a9c 41b001 mov r8b, 1
00fd8a9f e9720a0000 jmp 0x140fd9516
00fd8aa4 488b4368 mov rax, qword ptr [rbx + 0x68]
00fd8aa8 4981c620050000 add r14, 0x520
00fd8aaf 4d8bfe mov r15, r14
00fd8ab2 8b7034 mov esi, dword ptr [rax + 0x34]
00fd8ab5 8b4838 mov ecx, dword ptr [rax + 0x38]
00fd8ab8 89742448 mov dword ptr [rsp + 0x48], esi
00fd8abc 894c2458 mov dword ptr [rsp + 0x58], ecx
00fd8ac0 e9540a0000 jmp 0x140fd9519
00fd8ac5 488b4368 mov rax, qword ptr [rbx + 0x68]
00fd8ac9 4d8dbe20050000 lea r15, [r14 + 0x520]
00fd8ad0 8b7038 mov esi, dword ptr [rax + 0x38]
00fd8ad3 e93a0a0000 jmp 0x140fd9512
00fd8ad8 488b4368 mov rax, qword ptr [rbx + 0x68]
00fd8adc 4d8dbe20050000 lea r15, [r14 + 0x520]
00fd8ae3 8b703c mov esi, dword ptr [rax + 0x3c]
00fd8ae6 e9270a0000 jmp 0x140fd9512
00fd8aeb 8bb3b4000000 mov esi, dword ptr [rbx + 0xb4]
00fd8af1 4d8dbe08020000 lea r15, [r14 + 0x208]
00fd8af8 e9150a0000 jmp 0x140fd9512
00fd8afd 8bb368010000 mov esi, dword ptr [rbx + 0x168]
00fd8b03 4d8dbef8170000 lea r15, [r14 + 0x17f8]
00fd8b0a 89742448 mov dword ptr [rsp + 0x48], esi
00fd8b0e 85f6 test esi, esi
00fd8b10 0f85000a0000 jne 0x140fd9516
00fd8b16 41387908 cmp byte ptr [r9 + 8], dil
00fd8b1a 0f85f6090000 jne 0x140fd9516
00fd8b20 8bb3b4000000 mov esi, dword ptr [rbx + 0xb4]
00fd8b26 4d8dbe08020000 lea r15, [r14 + 0x208]
00fd8b2d 4532c0 xor r8b, r8b
00fd8b30 e9dd090000 jmp 0x140fd9512
00fd8b35 8bb3b8000000 mov esi, dword ptr [rbx + 0xb8]
00fd8b3b 4d8dbe08020000 lea r15, [r14 + 0x208]
00fd8b42 e9cb090000 jmp 0x140fd9512
00fd8b47 8bb36c010000 mov esi, dword ptr [rbx + 0x16c]
00fd8b4d 4d8dbef8170000 lea r15, [r14 + 0x17f8]
00fd8b54 89742448 mov dword ptr [rsp + 0x48], esi
00fd8b58 85f6 test esi, esi
00fd8b5a 0f85b6090000 jne 0x140fd9516
00fd8b60 41387908 cmp byte ptr [r9 + 8], dil
00fd8b64 0f85ac090000 jne 0x140fd9516
00fd8b6a 8bb3b8000000 mov esi, dword ptr [rbx + 0xb8]
00fd8b70 4d8dbe08020000 lea r15, [r14 + 0x208]
00fd8b77 4532c0 xor r8b, r8b
00fd8b7a e993090000 jmp 0x140fd9512
00fd8b7f 8bb3c4000000 mov esi, dword ptr [rbx + 0xc4]
00fd8b85 4d8dbe08020000 lea r15, [r14 + 0x208]
00fd8b8c e981090000 jmp 0x140fd9512
00fd8b91 8bb370010000 mov esi, dword ptr [rbx + 0x170]
00fd8b97 4d8dbef8170000 lea r15, [r14 + 0x17f8]
00fd8b9e 89742448 mov dword ptr [rsp + 0x48], esi
00fd8ba2 85f6 test esi, esi
00fd8ba4 0f856c090000 jne 0x140fd9516
00fd8baa 41387908 cmp byte ptr [r9 + 8], dil
00fd8bae 0f8562090000 jne 0x140fd9516
00fd8bb4 8bb3c4000000 mov esi, dword ptr [rbx + 0xc4]
00fd8bba 4d8dbe08020000 lea r15, [r14 + 0x208]
00fd8bc1 4532c0 xor r8b, r8b
00fd8bc4 e949090000 jmp 0x140fd9512
00fd8bc9 8bb3c8000000 mov esi, dword ptr [rbx + 0xc8]
00fd8bcf 4d8dbe28030000 lea r15, [r14 + 0x328]
00fd8bd6 e937090000 jmp 0x140fd9512
00fd8bdb 8bb3cc000000 mov esi, dword ptr [rbx + 0xcc]
00fd8be1 4d8dbe70030000 lea r15, [r14 + 0x370]
00fd8be8 e925090000 jmp 0x140fd9512
00fd8bed 8bb3d4000000 mov esi, dword ptr [rbx + 0xd4]
00fd8bf3 4d8dbe00040000 lea r15, [r14 + 0x400]
00fd8bfa e913090000 jmp 0x140fd9512
00fd8bff 488b7e60 mov rdi, qword ptr [rsi + 0x60]
00fd8c03 b8ffffffff mov eax, 0xffffffff
00fd8c08 483bf8 cmp rdi, rax
00fd8c0b 0f853c040000 jne 0x140fd904d
00fd8c11 8b4634 mov eax, dword ptr [rsi + 0x34]
00fd8c14 3d50545448 cmp eax, 0x48545450
00fd8c19 740b je 0x140fd8c26
00fd8c1b 3d44524853 cmp eax, 0x53485244
00fd8c20 0f8527040000 jne 0x140fd904d
00fd8c26 498bfc mov rdi, r12
00fd8c29 e91f040000 jmp 0x140fd904d
00fd8c2e 8b4e5c mov ecx, dword ptr [rsi + 0x5c]
00fd8c31 85c9 test ecx, ecx
00fd8c33 751b jne 0x140fd8c50
00fd8c35 8b4634 mov eax, dword ptr [rsi + 0x34]
00fd8c38 3d50545448 cmp eax, 0x48545450
00fd8c3d 7407 je 0x140fd8c46
00fd8c3f 3d44524853 cmp eax, 0x53485244
00fd8c44 750a jne 0x140fd8c50
00fd8c46 bfffffffff mov edi, 0xffffffff
00fd8c4b e9fd030000 jmp 0x140fd904d
00fd8c50 81c1f4010000 add ecx, 0x1f4
00fd8c56 b8d34d6210 mov eax, 0x10624dd3
00fd8c5b f7e1 mul ecx
00fd8c5d c1ea06 shr edx, 6
00fd8c60 69fae8030000 imul edi, edx, 0x3e8
00fd8c66 e9e2030000 jmp 0x140fd904d
00fd8c6b 8b7b08 mov edi, dword ptr [rbx + 8]
00fd8c6e e9da030000 jmp 0x140fd904d
00fd8c73 8b7e28 mov edi, dword ptr [rsi + 0x28]
00fd8c76 e9d2030000 jmp 0x140fd904d
00fd8c7b 488b3b mov rdi, qword ptr [rbx]
00fd8c7e e9ca030000 jmp 0x140fd904d
00fd8c83 0fb7bb0a010000 movzx edi, word ptr [rbx + 0x10a]
00fd8c8a e9be030000 jmp 0x140fd904d
00fd8c8f 0fb7bb0e010000 movzx edi, word ptr [rbx + 0x10e]
00fd8c96 e9b2030000 jmp 0x140fd904d
00fd8c9b 0fb7bba6000000 movzx edi, word ptr [rbx + 0xa6]
00fd8ca2 e9a6030000 jmp 0x140fd904d
00fd8ca7 0fb77e4c movzx edi, word ptr [rsi + 0x4c]
00fd8cab e99d030000 jmp 0x140fd904d
00fd8cb0 f30f104648 movss xmm0, dword ptr [rsi + 0x48]
00fd8cb5 33c0 xor eax, eax
00fd8cb7 f30f100d45b7c900 movss xmm1, dword ptr [rip + 0xc9b745]
00fd8cbf 0f2fc1 comiss xmm0, xmm1
00fd8cc2 7216 jb 0x140fd8cda
00fd8cc4 f30f5cc1 subss xmm0, xmm1
00fd8cc8 0f2fc1 comiss xmm0, xmm1
00fd8ccb 730d jae 0x140fd8cda
00fd8ccd 48b90000000000000080 movabs rcx, 0x8000000000000000
00fd8cd7 488bc1 mov rax, rcx
00fd8cda f3480f2cf8 cvttss2si rdi, xmm0
00fd8cdf 4803f8 add rdi, rax
00fd8ce2 e966030000 jmp 0x140fd904d
00fd8ce7 8b7e54 mov edi, dword ptr [rsi + 0x54]
00fd8cea 450fb6c8 movzx r9d, r8b
00fd8cee 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd8cf3 e95b030000 jmp 0x140fd9053
00fd8cf8 8bb3d0000000 mov esi, dword ptr [rbx + 0xd0]
00fd8cfe 4d8dbeb8030000 lea r15, [r14 + 0x3b8]
00fd8d05 e908080000 jmp 0x140fd9512
00fd8d0a 8bbb14010000 mov edi, dword ptr [rbx + 0x114]
00fd8d10 e938030000 jmp 0x140fd904d
00fd8d15 8bbb1c010000 mov edi, dword ptr [rbx + 0x11c]
00fd8d1b 450fb6c8 movzx r9d, r8b
00fd8d1f 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd8d24 e92a030000 jmp 0x140fd9053
00fd8d29 8bbb20010000 mov edi, dword ptr [rbx + 0x120]
00fd8d2f e919030000 jmp 0x140fd904d
00fd8d34 8bbb28010000 mov edi, dword ptr [rbx + 0x128]
00fd8d3a 450fb6c8 movzx r9d, r8b
00fd8d3e 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd8d43 e90b030000 jmp 0x140fd9053
00fd8d48 488bcb mov rcx, rbx
00fd8d4b e86011f0ff call 0x140ed9eb0
00fd8d50 480fbef8 movsx rdi, al
00fd8d54 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd8d59 e9f2020000 jmp 0x140fd9050
00fd8d5e 488bcb mov rcx, rbx
00fd8d61 e83a10f0ff call 0x140ed9da0
00fd8d66 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd8d6b 480fbef8 movsx rdi, al
00fd8d6f e9dc020000 jmp 0x140fd9050
00fd8d74 4885db test rbx, rbx
00fd8d77 7430 je 0x140fd8da9
00fd8d79 48397b10 cmp qword ptr [rbx + 0x10], rdi
00fd8d7d 742a je 0x140fd8da9
00fd8d7f f6839a00000004 test byte ptr [rbx + 0x9a], 4
00fd8d86 7421 je 0x140fd8da9
00fd8d88 488b05a1e10c01 mov rax, qword ptr [rip + 0x10ce1a1]
00fd8d8f 4885c0 test rax, rax
00fd8d92 7407 je 0x140fd8d9b
00fd8d94 4c8ba090410100 mov r12, qword ptr [rax + 0x14190]
00fd8d9b 4138bc248b050000 cmp byte ptr [r12 + 0x58b], dil
00fd8da3 0f8428060000 je 0x140fd93d1
00fd8da9 32c0 xor al, al
00fd8dab e953090000 jmp 0x140fd9703
00fd8db0 0fb6839b000000 movzx eax, byte ptr [rbx + 0x9b]
00fd8db7 c0e802 shr al, 2
00fd8dba 4122c0 and al, r8b
00fd8dbd e941090000 jmp 0x140fd9703
00fd8dc2 0fb7bb2c010000 movzx edi, word ptr [rbx + 0x12c]
00fd8dc9 e97f020000 jmp 0x140fd904d
00fd8dce 488b4608 mov rax, qword ptr [rsi + 8]
00fd8dd2 4885c0 test rax, rax
00fd8dd5 0f8472020000 je 0x140fd904d
00fd8ddb 48397810 cmp qword ptr [rax + 0x10], rdi
00fd8ddf 0f8468020000 je 0x140fd904d
00fd8de5 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd8de9 488b7838 mov rdi, qword ptr [rax + 0x38]
00fd8ded 4885ff test rdi, rdi
00fd8df0 0f8457020000 je 0x140fd904d
00fd8df6 45386708 cmp byte ptr [r15 + 8], r12b
00fd8dfa 7519 jne 0x140fd8e15
00fd8dfc 498b4f18 mov rcx, qword ptr [r15 + 0x18]
00fd8e00 4885c9 test rcx, rcx
00fd8e03 7410 je 0x140fd8e15
00fd8e05 41837f2044 cmp dword ptr [r15 + 0x20], 0x44
00fd8e0a 7509 jne 0x140fd8e15
00fd8e0c 4c3921 cmp qword ptr [rcx], r12
00fd8e0f 0f8538020000 jne 0x140fd904d
00fd8e15 817e3444524853 cmp dword ptr [rsi + 0x34], 0x53485244
00fd8e1c 750d jne 0x140fd8e2b
00fd8e1e 4438838a000000 cmp byte ptr [rbx + 0x8a], r8b
00fd8e25 0f8422020000 je 0x140fd904d
00fd8e2b f6464240 test byte ptr [rsi + 0x42], 0x40
00fd8e2f 752e jne 0x140fd8e5f
00fd8e31 f60002 test byte ptr [rax], 2
00fd8e34 7529 jne 0x140fd8e5f
00fd8e36 4c396008 cmp qword ptr [rax + 8], r12
00fd8e3a 0f850d020000 jne 0x140fd904d
00fd8e40 4c396020 cmp qword ptr [rax + 0x20], r12
00fd8e44 0f8503020000 jne 0x140fd904d
00fd8e4a 33d2 xor edx, edx
00fd8e4c 488bcb mov rcx, rbx
00fd8e4f e81c7dfcff call 0x140fa0b70
00fd8e54 a990000100 test eax, 0x10090
00fd8e59 0f85f5feffff jne 0x140fd8d54
00fd8e5f 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd8e64 498bfc mov rdi, r12
00fd8e67 e9e4010000 jmp 0x140fd9050
00fd8e6c 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd8e70 488b7848 mov rdi, qword ptr [rax + 0x48]
00fd8e74 e9d4010000 jmp 0x140fd904d
00fd8e79 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd8e7d 488b7858 mov rdi, qword ptr [rax + 0x58]
00fd8e81 e9c7010000 jmp 0x140fd904d
00fd8e86 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd8e8a 488b7850 mov rdi, qword ptr [rax + 0x50]
00fd8e8e e9ba010000 jmp 0x140fd904d
00fd8e93 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd8e97 488b7840 mov rdi, qword ptr [rax + 0x40]
00fd8e9b e9ad010000 jmp 0x140fd904d
00fd8ea0 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd8ea4 488b7860 mov rdi, qword ptr [rax + 0x60]
00fd8ea8 e9a0010000 jmp 0x140fd904d
00fd8ead 8b9698000000 mov edx, dword ptr [rsi + 0x98]
00fd8eb3 8b8e9c000000 mov ecx, dword ptr [rsi + 0x9c]
00fd8eb9 81fa6d63706c cmp edx, 0x6c70636d
00fd8ebf 776a ja 0x140fd8f2b
00fd8ec1 745b je 0x140fd8f1e
00fd8ec3 81fa63616c61 cmp edx, 0x616c6163
00fd8ec9 7446 je 0x140fd8f11
00fd8ecb 81fa62647561 cmp edx, 0x61756462
00fd8ed1 741e je 0x140fd8ef1
00fd8ed3 b801000000 mov eax, 1
00fd8ed8 81fa63616c66 cmp edx, 0x666c6163
00fd8ede 0f859d000000 jne 0x140fd8f81
00fd8ee4 b85a020000 mov eax, 0x25a
00fd8ee9 0fb7f8 movzx edi, ax
00fd8eec e95c010000 jmp 0x140fd904d
00fd8ef1 85c9 test ecx, ecx
00fd8ef3 740f je 0x140fd8f04
00fd8ef5 488d8190010000 lea rax, [rcx + 0x190]
00fd8efc 0fb7f8 movzx edi, ax
00fd8eff e949010000 jmp 0x140fd904d
00fd8f04 b891010000 mov eax, 0x191
00fd8f09 0fb7f8 movzx edi, ax
00fd8f0c e93c010000 jmp 0x140fd904d
00fd8f11 b859020000 mov eax, 0x259
00fd8f16 0fb7f8 movzx edi, ax
00fd8f19 e92f010000 jmp 0x140fd904d
00fd8f1e b8bd020000 mov eax, 0x2bd
00fd8f23 0fb7f8 movzx edi, ax
00fd8f26 e922010000 jmp 0x140fd904d
00fd8f2b 81fa6134706d cmp edx, 0x6d703461
00fd8f31 743e je 0x140fd8f71
00fd8f33 b801000000 mov eax, 1
00fd8f38 81fa6765706d cmp edx, 0x6d706567
00fd8f3e 7541 jne 0x140fd8f81
00fd8f40 2bc8 sub ecx, eax
00fd8f42 7420 je 0x140fd8f64
00fd8f44 2bc8 sub ecx, eax
00fd8f46 740f je 0x140fd8f57
00fd8f48 3bc8 cmp ecx, eax
00fd8f4a b82d010000 mov eax, 0x12d
00fd8f4f 0fb7f8 movzx edi, ax
00fd8f52 e9f6000000 jmp 0x140fd904d
00fd8f57 b8c9000000 mov eax, 0xc9
00fd8f5c 0fb7f8 movzx edi, ax
00fd8f5f e9e9000000 jmp 0x140fd904d
00fd8f64 b865000000 mov eax, 0x65
00fd8f69 0fb7f8 movzx edi, ax
00fd8f6c e9dc000000 jmp 0x140fd904d
00fd8f71 488d81f4010000 lea rax, [rcx + 0x1f4]
00fd8f78 85c9 test ecx, ecx
00fd8f7a 7505 jne 0x140fd8f81
00fd8f7c b8f6010000 mov eax, 0x1f6
00fd8f81 0fb7f8 movzx edi, ax
00fd8f84 e9c4000000 jmp 0x140fd904d
00fd8f89 458b4f04 mov r9d, dword ptr [r15 + 4]
00fd8f8d 4584c8 test r8b, r9b
00fd8f90 0f84ed070000 je 0x140fd9783
00fd8f96 41387f08 cmp byte ptr [r15 + 8], dil
00fd8f9a 7515 jne 0x140fd8fb1
00fd8f9c 498b5718 mov rdx, qword ptr [r15 + 0x18]
00fd8fa0 4885d2 test rdx, rdx
00fd8fa3 740c je 0x140fd8fb1
00fd8fa5 41837f2044 cmp dword ptr [r15 + 0x20], 0x44
00fd8faa 7505 jne 0x140fd8fb1
00fd8fac 488b12 mov rdx, qword ptr [rdx]
00fd8faf eb05 jmp 0x140fd8fb6
00fd8fb1 488b542460 mov rdx, qword ptr [rsp + 0x60]
00fd8fb6 4885d2 test rdx, rdx
00fd8fb9 0f84ca070000 je 0x140fd9789
00fd8fbf 488b4b60 mov rcx, qword ptr [rbx + 0x60]
00fd8fc3 4532c0 xor r8b, r8b
00fd8fc6 4883fa45 cmp rdx, 0x45
00fd8fca 7319 jae 0x140fd8fe5
00fd8fcc 4885c9 test rcx, rcx
00fd8fcf 7436 je 0x140fd9007
00fd8fd1 488b01 mov rax, qword ptr [rcx]
00fd8fd4 66395010 cmp word ptr [rax + 0x10], dx
00fd8fd8 742a je 0x140fd9004
00fd8fda 488b4938 mov rcx, qword ptr [rcx + 0x38]
00fd8fde 4885c9 test rcx, rcx
00fd8fe1 75ee jne 0x140fd8fd1
00fd8fe3 eb22 jmp 0x140fd9007
00fd8fe5 4885c9 test rcx, rcx
00fd8fe8 741d je 0x140fd9007
00fd8fea 660f1f440000 nop word ptr [rax + rax]
00fd8ff0 488b01 mov rax, qword ptr [rcx]
00fd8ff3 48395050 cmp qword ptr [rax + 0x50], rdx
00fd8ff7 740b je 0x140fd9004
00fd8ff9 488b4938 mov rcx, qword ptr [rcx + 0x38]
00fd8ffd 4885c9 test rcx, rcx
00fd9000 75ee jne 0x140fd8ff0
00fd9002 eb03 jmp 0x140fd9007
00fd9004 41b001 mov r8b, 1
00fd9007 410fb6c0 movzx eax, r8b
00fd900b 3401 xor al, 1
00fd900d 41f7470400000002 test dword ptr [r15 + 4], 0x2000000
00fd9015 0fb6c8 movzx ecx, al
00fd9018 410fb6c0 movzx eax, r8b
00fd901c 0f44c8 cmove ecx, eax
00fd901f 84c9 test cl, cl
00fd9021 0f8462070000 je 0x140fd9789
00fd9027 41c60201 mov byte ptr [r10], 1
00fd902b e959070000 jmp 0x140fd9789
00fd9030 817e3450545448 cmp dword ptr [rsi + 0x34], 0x48545450
00fd9037 400f94c7 sete dil
00fd903b eb10 jmp 0x140fd904d
00fd903d 0fb7bb10010000 movzx edi, word ptr [rbx + 0x110]
00fd9044 eb07 jmp 0x140fd904d
00fd9046 488b4378 mov rax, qword ptr [rbx + 0x78]
00fd904a 8b7804 mov edi, dword ptr [rax + 4]
00fd904d 4d8bc1 mov r8, r9
00fd9050 4532c9 xor r9b, r9b
00fd9053 488b442450 mov rax, qword ptr [rsp + 0x50]
00fd9058 488bd7 mov rdx, rdi
00fd905b 498bcf mov rcx, r15
00fd905e 4889442420 mov qword ptr [rsp + 0x20], rax
00fd9063 e8e8f5ffff call 0x140fd8650
00fd9068 448be8 mov r13d, eax
00fd906b e919070000 jmp 0x140fd9789
00fd9070 488b4378 mov rax, qword ptr [rbx + 0x78]
00fd9074 8b7808 mov edi, dword ptr [rax + 8]
00fd9077 ebd4 jmp 0x140fd904d
00fd9079 0fb7bb0c010000 movzx edi, word ptr [rbx + 0x10c]
00fd9080 ebcb jmp 0x140fd904d
00fd9082 0fb6839d000000 movzx eax, byte ptr [rbx + 0x9d]
00fd9089 c0e806 shr al, 6
00fd908c 4122c0 and al, r8b
00fd908f e96f060000 jmp 0x140fd9703
00fd9094 397e74 cmp dword ptr [rsi + 0x74], edi
00fd9097 0f95c0 setne al
00fd909a e964060000 jmp 0x140fd9703
00fd909f 8b4308 mov eax, dword ptr [rbx + 8]
00fd90a2 413981d4010000 cmp dword ptr [r9 + 0x1d4], eax
00fd90a9 7435 je 0x140fd90e0
00fd90ab 33d2 xor edx, edx
00fd90ad 418981d4010000 mov dword ptr [r9 + 0x1d4], eax
00fd90b4 488bcb mov rcx, rbx
00fd90b7 e8b47afcff call 0x140fa0b70
00fd90bc 4c8b4c2440 mov r9, qword ptr [rsp + 0x40]
00fd90c1 418981d0010000 mov dword ptr [r9 + 0x1d0], eax
00fd90c8 3d00040000 cmp eax, 0x400
00fd90cd 7511 jne 0x140fd90e0
00fd90cf 41387909 cmp byte ptr [r9 + 9], dil
00fd90d3 740b je 0x140fd90e0
00fd90d5 41c781d001000002000000 mov dword ptr [r9 + 0x1d0], 2
00fd90e0 418bb9d0010000 mov edi, dword ptr [r9 + 0x1d0]
00fd90e7 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd90ec e95fffffff jmp 0x140fd9050
00fd90f1 488bcb mov rcx, rbx
00fd90f4 e867aafbff call 0x140f93b60
00fd90f9 8bf8 mov edi, eax
00fd90fb e94dffffff jmp 0x140fd904d
00fd9100 488bce mov rcx, rsi
00fd9103 e898eb0500 call 0x141037ca0
00fd9108 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd910d 4863f8 movsxd rdi, eax
00fd9110 e93bffffff jmp 0x140fd9050
00fd9115 488b4370 mov rax, qword ptr [rbx + 0x70]
00fd9119 4d8dbe40060000 lea r15, [r14 + 0x640]
00fd9120 8b7028 mov esi, dword ptr [rax + 0x28]
00fd9123 e9ea030000 jmp 0x140fd9512
00fd9128 8bb374010000 mov esi, dword ptr [rbx + 0x174]
00fd912e 4d8dbe40180000 lea r15, [r14 + 0x1840]
00fd9135 89742448 mov dword ptr [rsp + 0x48], esi
00fd9139 85f6 test esi, esi
00fd913b 0f85d5030000 jne 0x140fd9516
00fd9141 41387908 cmp byte ptr [r9 + 8], dil
00fd9145 0f85cb030000 jne 0x140fd9516
00fd914b 488b4370 mov rax, qword ptr [rbx + 0x70]
00fd914f 4d8dbe40060000 lea r15, [r14 + 0x640]
00fd9156 4532c0 xor r8b, r8b
00fd9159 8b7028 mov esi, dword ptr [rax + 0x28]
00fd915c e9b1030000 jmp 0x140fd9512
00fd9161 488b4370 mov rax, qword ptr [rbx + 0x70]
00fd9165 8b7808 mov edi, dword ptr [rax + 8]
00fd9168 e9e0feffff jmp 0x140fd904d
00fd916d 0fb6839c000000 movzx eax, byte ptr [rbx + 0x9c]
00fd9174 4122c0 and al, r8b
00fd9177 e987050000 jmp 0x140fd9703
00fd917c 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd9180 8bb888000000 mov edi, dword ptr [rax + 0x88]
00fd9186 e9c2feffff jmp 0x140fd904d
00fd918b 4885db test rbx, rbx
00fd918e 7428 je 0x140fd91b8
00fd9190 48397b10 cmp qword ptr [rbx + 0x10], rdi
00fd9194 7422 je 0x140fd91b8
00fd9196 488b4370 mov rax, qword ptr [rbx + 0x70]
00fd919a 4885c0 test rax, rax
00fd919d 7419 je 0x140fd91b8
00fd919f 448b6010 mov r12d, dword ptr [rax + 0x10]
00fd91a3 4403600c add r12d, dword ptr [rax + 0xc]
00fd91a7 8b4814 mov ecx, dword ptr [rax + 0x14]
00fd91aa 85c9 test ecx, ecx
00fd91ac 740a je 0x140fd91b8
00fd91ae 034818 add ecx, dword ptr [rax + 0x18]
00fd91b1 443be1 cmp r12d, ecx
00fd91b4 440f47e1 cmova r12d, ecx
00fd91b8 418bfc mov edi, r12d
00fd91bb e98dfeffff jmp 0x140fd904d
00fd91c0 488b4618 mov rax, qword ptr [rsi + 0x18]
00fd91c4 0fb600 movzx eax, byte ptr [rax]
00fd91c7 d0e8 shr al, 1
00fd91c9 4122c0 and al, r8b
00fd91cc e932050000 jmp 0x140fd9703
00fd91d1 488b4618 mov rax, qword ptr [rsi + 0x18]
00fd91d5 0fb600 movzx eax, byte ptr [rax]
00fd91d8 c0e802 shr al, 2
00fd91db 4122c0 and al, r8b
00fd91de e920050000 jmp 0x140fd9703
00fd91e3 488b4618 mov rax, qword ptr [rsi + 0x18]
00fd91e7 480fbf7802 movsx rdi, word ptr [rax + 2]
00fd91ec e95cfeffff jmp 0x140fd904d
00fd91f1 488b4618 mov rax, qword ptr [rsi + 0x18]
00fd91f5 0fb7780c movzx edi, word ptr [rax + 0xc]
00fd91f9 e94ffeffff jmp 0x140fd904d
00fd91fe 488b4618 mov rax, qword ptr [rsi + 0x18]
00fd9202 e943feffff jmp 0x140fd904a
00fd9207 488b4618 mov rax, qword ptr [rsi + 0x18]
00fd920b 480fbf780e movsx rdi, word ptr [rax + 0xe]
00fd9210 e938feffff jmp 0x140fd904d
00fd9215 488b4618 mov rax, qword ptr [rsi + 0x18]
00fd9219 0fb77810 movzx edi, word ptr [rax + 0x10]
00fd921d e92bfeffff jmp 0x140fd904d
00fd9222 488b4618 mov rax, qword ptr [rsi + 0x18]
00fd9226 8b7808 mov edi, dword ptr [rax + 8]
00fd9229 e91ffeffff jmp 0x140fd904d
00fd922e 4885db test rbx, rbx
00fd9231 0f8416feffff je 0x140fd904d
00fd9237 488b4328 mov rax, qword ptr [rbx + 0x28]
00fd923b 4885c0 test rax, rax
00fd923e 0f8409feffff je 0x140fd904d
00fd9244 4d8bc1 mov r8, r9
00fd9247 4532c9 xor r9b, r9b
00fd924a 83fa4d cmp edx, 0x4d
00fd924d 7509 jne 0x140fd9258
00fd924f 488b7820 mov rdi, qword ptr [rax + 0x20]
00fd9253 e9fbfdffff jmp 0x140fd9053
00fd9258 488b7828 mov rdi, qword ptr [rax + 0x28]
00fd925c e9f2fdffff jmp 0x140fd9053
00fd9261 4885db test rbx, rbx
00fd9264 0f84e3fdffff je 0x140fd904d
00fd926a 488b4340 mov rax, qword ptr [rbx + 0x40]
00fd926e 4885c0 test rax, rax
00fd9271 0f84d6fdffff je 0x140fd904d
00fd9277 4d8bc1 mov r8, r9
00fd927a 4532c9 xor r9b, r9b
00fd927d 81fa8e000000 cmp edx, 0x8e
00fd9283 7509 jne 0x140fd928e
00fd9285 488b7840 mov rdi, qword ptr [rax + 0x40]
00fd9289 e9c5fdffff jmp 0x140fd9053
00fd928e 488bb8b8000000 mov rdi, qword ptr [rax + 0xb8]
00fd9295 e9b9fdffff jmp 0x140fd9053
00fd929a 4885db test rbx, rbx
00fd929d 0f8406fbffff je 0x140fd8da9
00fd92a3 488b4b28 mov rcx, qword ptr [rbx + 0x28]
00fd92a7 4885c9 test rcx, rcx
00fd92aa 0f84f9faffff je 0x140fd8da9
00fd92b0 e8fb30f9ff call 0x140f6c3b0
00fd92b5 4c8b542450 mov r10, qword ptr [rsp + 0x50]
00fd92ba e944040000 jmp 0x140fd9703
00fd92bf 0fb6839e000000 movzx eax, byte ptr [rbx + 0x9e]
00fd92c6 c0e802 shr al, 2
00fd92c9 4122c0 and al, r8b
00fd92cc e932040000 jmp 0x140fd9703
00fd92d1 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd92d5 8bb88c000000 mov edi, dword ptr [rax + 0x8c]
00fd92db e96dfdffff jmp 0x140fd904d
00fd92e0 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd92e4 488bb8a0000000 mov rdi, qword ptr [rax + 0xa0]
00fd92eb e95dfdffff jmp 0x140fd904d
00fd92f0 488bce mov rcx, rsi
00fd92f3 e89896efff call 0x140ed2990
00fd92f8 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd92fd 8bf8 mov edi, eax
00fd92ff e94cfdffff jmp 0x140fd9050
00fd9304 0fb6bb8a000000 movzx edi, byte ptr [rbx + 0x8a]
00fd930b e93dfdffff jmp 0x140fd904d
00fd9310 0fb77e4e movzx edi, word ptr [rsi + 0x4e]
00fd9314 e934fdffff jmp 0x140fd904d
00fd9319 4d8bc1 mov r8, r9
00fd931c 4532c9 xor r9b, r9b
00fd931f 4181be8400000073727672 cmp dword ptr [r14 + 0x84], 0x72767273
00fd932a 0f8523fdffff jne 0x140fd9053
00fd9330 488bbb48010000 mov rdi, qword ptr [rbx + 0x148]
00fd9337 e917fdffff jmp 0x140fd9053
00fd933c 498bce mov rcx, r14
00fd933f e8ec13feff call 0x140fba730
00fd9344 4181be8400000073727672 cmp dword ptr [r14 + 0x84], 0x72767273
00fd934f 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd9354 0f85f6fcffff jne 0x140fd9050
00fd935a 4d85c0 test r8, r8
00fd935d 0f84edfcffff je 0x140fd9050
00fd9363 84c0 test al, al
00fd9365 0f94c0 sete al
00fd9368 4532c9 xor r9b, r9b
00fd936b 4138400a cmp byte ptr [r8 + 0xa], al
00fd936f 0f85defcffff jne 0x140fd9053
00fd9375 8b7e28 mov edi, dword ptr [rsi + 0x28]
00fd9378 e9d6fcffff jmp 0x140fd9053
00fd937d 4885db test rbx, rbx
00fd9380 0f8423faffff je 0x140fd8da9
00fd9386 48397b10 cmp qword ptr [rbx + 0x10], rdi
00fd938a 0f8419faffff je 0x140fd8da9
00fd9390 0fb6839f000000 movzx eax, byte ptr [rbx + 0x9f]
00fd9397 c0e805 shr al, 5
00fd939a 4122c0 and al, r8b
00fd939d e961030000 jmp 0x140fd9703
00fd93a2 0fb6839e000000 movzx eax, byte ptr [rbx + 0x9e]
00fd93a9 c0e803 shr al, 3
00fd93ac 4122c0 and al, r8b
00fd93af e94f030000 jmp 0x140fd9703
00fd93b4 4885db test rbx, rbx
00fd93b7 7418 je 0x140fd93d1
00fd93b9 48397b10 cmp qword ptr [rbx + 0x10], rdi
00fd93bd 7412 je 0x140fd93d1
00fd93bf 0fb6839f000000 movzx eax, byte ptr [rbx + 0x9f]
00fd93c6 c0e804 shr al, 4
00fd93c9 4122c0 and al, r8b
00fd93cc e932030000 jmp 0x140fd9703
00fd93d1 410fb6c0 movzx eax, r8b
00fd93d5 e929030000 jmp 0x140fd9703
00fd93da 0fb6839d000000 movzx eax, byte ptr [rbx + 0x9d]
00fd93e1 f6d0 not al
00fd93e3 e918030000 jmp 0x140fd9700
00fd93e8 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd93ec 4d8dbec8080000 lea r15, [r14 + 0x8c8]
00fd93f3 8b7074 mov esi, dword ptr [rax + 0x74]
00fd93f6 e917010000 jmp 0x140fd9512
00fd93fb 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd93ff 4d8dbe10090000 lea r15, [r14 + 0x910]
00fd9406 8b7078 mov esi, dword ptr [rax + 0x78]
00fd9409 e904010000 jmp 0x140fd9512
00fd940e 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd9412 4d8dbec8080000 lea r15, [r14 + 0x8c8]
00fd9419 8b707c mov esi, dword ptr [rax + 0x7c]
00fd941c e9f1000000 jmp 0x140fd9512
00fd9421 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd9425 4d8dbe10090000 lea r15, [r14 + 0x910]
00fd942c 8bb080000000 mov esi, dword ptr [rax + 0x80]
00fd9432 e9db000000 jmp 0x140fd9512
00fd9437 4885db test rbx, rbx
00fd943a 7451 je 0x140fd948d
00fd943c 48397b10 cmp qword ptr [rbx + 0x10], rdi
00fd9440 744b je 0x140fd948d
00fd9442 488b4358 mov rax, qword ptr [rbx + 0x58]
00fd9446 4885c0 test rax, rax
00fd9449 741c je 0x140fd9467
00fd944b 488b4808 mov rcx, qword ptr [rax + 8]
00fd944f 4885c9 test rcx, rcx
00fd9452 7413 je 0x140fd9467
00fd9454 48397910 cmp qword ptr [rcx + 0x10], rdi
00fd9458 740d je 0x140fd9467
00fd945a 488b4810 mov rcx, qword ptr [rax + 0x10]
00fd945e 448401 test byte ptr [rcx], r8b
00fd9461 7404 je 0x140fd9467
00fd9463 4c8b6138 mov r12, qword ptr [rcx + 0x38]
00fd9467 498bcc mov rcx, r12
00fd946a e8913284ff call 0x14081c700
00fd946f 0fb6c8 movzx ecx, al
00fd9472 8d41fe lea eax, [rcx - 2]
00fd9475 3c01 cmp al, 1
00fd9477 7616 jbe 0x140fd948f
00fd9479 0fb68b07010000 movzx ecx, byte ptr [rbx + 0x107]
00fd9480 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd9485 0fb6f9 movzx edi, cl
00fd9488 e9c3fbffff jmp 0x140fd9050
00fd948d 32c9 xor cl, cl
00fd948f 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd9494 0fb6f9 movzx edi, cl
00fd9497 e9b4fbffff jmp 0x140fd9050
00fd949c 4885db test rbx, rbx
00fd949f 7424 je 0x140fd94c5
00fd94a1 488b4328 mov rax, qword ptr [rbx + 0x28]
00fd94a5 4885c0 test rax, rax
00fd94a8 741b je 0x140fd94c5
00fd94aa 81780869626c61 cmp dword ptr [rax + 8], 0x616c6269
00fd94b1 7512 jne 0x140fd94c5
00fd94b3 48397830 cmp qword ptr [rax + 0x30], rdi
00fd94b7 740c je 0x140fd94c5
00fd94b9 0fb64873 movzx ecx, byte ptr [rax + 0x73]
00fd94bd 0fb6f9 movzx edi, cl
00fd94c0 e988fbffff jmp 0x140fd904d
00fd94c5 32c9 xor cl, cl
00fd94c7 0fb6f9 movzx edi, cl
00fd94ca e97efbffff jmp 0x140fd904d
00fd94cf 4885db test rbx, rbx
00fd94d2 0f84d1f8ffff je 0x140fd8da9
00fd94d8 48397b10 cmp qword ptr [rbx + 0x10], rdi
00fd94dc 0f84c7f8ffff je 0x140fd8da9
00fd94e2 0fb683a0000000 movzx eax, byte ptr [rbx + 0xa0]
00fd94e9 c0e802 shr al, 2
00fd94ec 4122c0 and al, r8b
00fd94ef e90f020000 jmp 0x140fd9703
00fd94f4 488b4368 mov rax, qword ptr [rbx + 0x68]
00fd94f8 4d8dbe98020000 lea r15, [r14 + 0x298]
00fd94ff 8b7018 mov esi, dword ptr [rax + 0x18]
00fd9502 eb0e jmp 0x140fd9512
00fd9504 488b4368 mov rax, qword ptr [rbx + 0x68]
00fd9508 4d8dbee0020000 lea r15, [r14 + 0x2e0]
00fd950f 8b701c mov esi, dword ptr [rax + 0x1c]
00fd9512 89742448 mov dword ptr [rsp + 0x48], esi
00fd9516 4d8bf4 mov r14, r12
00fd9519 4d85ff test r15, r15
00fd951c 0f8452020000 je 0x140fd9774
00fd9522 488b7c2460 mov rdi, qword ptr [rsp + 0x60]
00fd9527 4584c0 test r8b, r8b
00fd952a 7449 je 0x140fd9575
00fd952c 488b5f10 mov rbx, qword ptr [rdi + 0x10]
00fd9530 4885db test rbx, rbx
00fd9533 7443 je 0x140fd9578
00fd9535 488b0b mov rcx, qword ptr [rbx]
00fd9538 4885c9 test rcx, rcx
00fd953b 743b je 0x140fd9578
00fd953d 85f6 test esi, esi
00fd953f 7437 je 0x140fd9578
00fd9541 488d542448 lea rdx, [rsp + 0x48]
00fd9546 e8754e0000 call 0x140fde3c0
00fd954b 4885c0 test rax, rax
00fd954e 7428 je 0x140fd9578
00fd9550 0fb64004 movzx eax, byte ptr [rax + 4]
00fd9554 3c01 cmp al, 1
00fd9556 750c jne 0x140fd9564
00fd9558 488b4c2450 mov rcx, qword ptr [rsp + 0x50]
00fd955d 8801 mov byte ptr [rcx], al
00fd955f e925020000 jmp 0x140fd9789
00fd9564 3c02 cmp al, 2
00fd9566 7510 jne 0x140fd9578
00fd9568 488b4c2450 mov rcx, qword ptr [rsp + 0x50]
00fd956d 448821 mov byte ptr [rcx], r12b
00fd9570 e914020000 jmp 0x140fd9789
00fd9575 498bdc mov rbx, r12
00fd9578 4c8b4c2450 mov r9, qword ptr [rsp + 0x50]
00fd957d 448bc6 mov r8d, esi
00fd9580 498bd7 mov rdx, r15
00fd9583 488bcf mov rcx, rdi
00fd9586 e895efffff call 0x140fd8520
00fd958b 448be8 mov r13d, eax
00fd958e 85c0 test eax, eax
00fd9590 0f85f3010000 jne 0x140fd9789
00fd9596 4885db test rbx, rbx
00fd9599 7464 je 0x140fd95ff
00fd959b 85f6 test esi, esi
00fd959d 7460 je 0x140fd95ff
00fd959f 488b0b mov rcx, qword ptr [rbx]
00fd95a2 4885c9 test rcx, rcx
00fd95a5 7533 jne 0x140fd95da
00fd95a7 41f6470401 test byte ptr [r15 + 4], 1
00fd95ac 7451 je 0x140fd95ff
00fd95ae 488d154b969300 lea rdx, [rip + 0x93964b]
00fd95b5 b918000000 mov ecx, 0x18
00fd95ba e82d297c00 call 0x14179beec
00fd95bf 4889442460 mov qword ptr [rsp + 0x60], rax
00fd95c4 488bc8 mov rcx, rax
00fd95c7 4885c0 test rax, rax
00fd95ca 746f je 0x140fd963b
00fd95cc 4c8920 mov qword ptr [rax], r12
00fd95cf 4c896008 mov qword ptr [rax + 8], r12
00fd95d3 4c896010 mov qword ptr [rax + 0x10], r12
00fd95d7 488903 mov qword ptr [rbx], rax
00fd95da 488b442450 mov rax, qword ptr [rsp + 0x50]
00fd95df 4c8d4c244c lea r9, [rsp + 0x4c]
00fd95e4 4c8d442448 lea r8, [rsp + 0x48]
00fd95e9 488d542468 lea rdx, [rsp + 0x68]
00fd95ee 443820 cmp byte ptr [rax], r12b
00fd95f1 0f94c0 sete al
00fd95f4 fec0 inc al
00fd95f6 8844244c mov byte ptr [rsp + 0x4c], al
00fd95fa e8c14b0000 call 0x140fde1c0
00fd95ff 488b4c2450 mov rcx, qword ptr [rsp + 0x50]
00fd9604 443821 cmp byte ptr [rcx], r12b
00fd9607 0f857c010000 jne 0x140fd9789
00fd960d 4d85f6 test r14, r14
00fd9610 0f8473010000 je 0x140fd9789
00fd9616 8b442458 mov eax, dword ptr [rsp + 0x58]
00fd961a 85c0 test eax, eax
00fd961c 0f8467010000 je 0x140fd9789
00fd9622 4c8bc9 mov r9, rcx
00fd9625 448bc0 mov r8d, eax
00fd9628 488bcf mov rcx, rdi
00fd962b 498bd6 mov rdx, r14
00fd962e e8edeeffff call 0x140fd8520
00fd9633 448be8 mov r13d, eax
00fd9636 e94e010000 jmp 0x140fd9789
00fd963b 4c8923 mov qword ptr [rbx], r12
00fd963e ebbf jmp 0x140fd95ff
00fd9640 488b4368 mov rax, qword ptr [rbx + 0x68]
00fd9644 0fb77814 movzx edi, word ptr [rax + 0x14]
00fd9648 e900faffff jmp 0x140fd904d
00fd964d 488b4368 mov rax, qword ptr [rbx + 0x68]
00fd9651 0fb77816 movzx edi, word ptr [rax + 0x16]
00fd9655 e9f3f9ffff jmp 0x140fd904d
00fd965a 488b4368 mov rax, qword ptr [rbx + 0x68]
00fd965e 0fb600 movzx eax, byte ptr [rax]
00fd9661 c0e803 shr al, 3
00fd9664 4122c0 and al, r8b
00fd9667 e997000000 jmp 0x140fd9703
00fd966c 4c8d4d80 lea r9, [rbp - 0x80]
00fd9670 4533c0 xor r8d, r8d
00fd9673 488bcb mov rcx, rbx
00fd9676 e895770e00 call 0x1410c0e10
00fd967b 440fb74580 movzx r8d, word ptr [rbp - 0x80]
00fd9680 488d5582 lea rdx, [rbp - 0x7e]
00fd9684 4585c0 test r8d, r8d
00fd9687 7417 je 0x140fd96a0
00fd9689 0f1f8000000000 nop dword ptr [rax]
00fd9690 66833a20 cmp word ptr [rdx], 0x20
00fd9694 730a jae 0x140fd96a0
00fd9696 4883c202 add rdx, 2
00fd969a 4183e801 sub r8d, 1
00fd969e 75f0 jne 0x140fd9690
00fd96a0 418b4720 mov eax, dword ptr [r15 + 0x20]
00fd96a4 d1e8 shr eax, 1
00fd96a6 4d8b4f18 mov r9, qword ptr [r15 + 0x18]
00fd96aa 7414 je 0x140fd96c0
00fd96ac 0f1f4000 nop dword ptr [rax]
00fd96b0 6641833920 cmp word ptr [r9], 0x20
00fd96b5 7309 jae 0x140fd96c0
00fd96b7 4983c102 add r9, 2
00fd96bb 83e801 sub eax, 1
00fd96be 75f0 jne 0x140fd96b0
00fd96c0 488b4c2450 mov rcx, qword ptr [rsp + 0x50]
00fd96c5 48894c2438 mov qword ptr [rsp + 0x38], rcx
00fd96ca 418b4f04 mov ecx, dword ptr [r15 + 4]
00fd96ce 89442420 mov dword ptr [rsp + 0x20], eax
00fd96d2 e8b96bc1ff call 0x140bf0290
00fd96d7 e9ad000000 jmp 0x140fd9789
00fd96dc 488b4610 mov rax, qword ptr [rsi + 0x10]
00fd96e0 8bb88c000000 mov edi, dword ptr [rax + 0x8c]
00fd96e6 4885ff test rdi, rdi
00fd96e9 7503 jne 0x140fd96ee
00fd96eb 8b7e58 mov edi, dword ptr [rsi + 0x58]
00fd96ee 450fb6c8 movzx r9d, r8b
00fd96f2 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd96f7 e957f9ffff jmp 0x140fd9053
00fd96fc 0fb64642 movzx eax, byte ptr [rsi + 0x42]
00fd9700 c0e807 shr al, 7
00fd9703 4d8bc2 mov r8, r10
00fd9706 0fb6d0 movzx edx, al
00fd9709 498bcf mov rcx, r15
00fd970c e87ff1ffff call 0x140fd8890
00fd9711 448be8 mov r13d, eax
00fd9714 eb73 jmp 0x140fd9789
00fd9716 488b4370 mov rax, qword ptr [rbx + 0x70]
00fd971a 0fb67820 movzx edi, byte ptr [rax + 0x20]
00fd971e e92af9ffff jmp 0x140fd904d
00fd9723 488b4370 mov rax, qword ptr [rbx + 0x70]
00fd9727 0fb67821 movzx edi, byte ptr [rax + 0x21]
00fd972b e91df9ffff jmp 0x140fd904d
00fd9730 488b4e08 mov rcx, qword ptr [rsi + 8]
00fd9734 4885c9 test rcx, rcx
00fd9737 740b je 0x140fd9744
00fd9739 488b4928 mov rcx, qword ptr [rcx + 0x28]
00fd973d e8ce38f9ff call 0x140f6d010
00fd9742 8bf8 mov edi, eax
00fd9744 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd9749 41b101 mov r9b, 1
00fd974c e902f9ffff jmp 0x140fd9053
00fd9751 488b4e08 mov rcx, qword ptr [rsi + 8]
00fd9755 4885c9 test rcx, rcx
00fd9758 7410 je 0x140fd976a
00fd975a 488b4928 mov rcx, qword ptr [rcx + 0x28]
00fd975e 4885c9 test rcx, rcx
00fd9761 7407 je 0x140fd976a
00fd9763 e8b820f9ff call 0x140f6b820
00fd9768 8bf8 mov edi, eax
00fd976a 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd976f e9dcf8ffff jmp 0x140fd9050
00fd9774 4c8b442440 mov r8, qword ptr [rsp + 0x40]
00fd9779 4c8b7c2460 mov r15, qword ptr [rsp + 0x60]
00fd977e e9cdf8ffff jmp 0x140fd9050
00fd9783 41bdceffffff mov r13d, 0xffffffce
00fd9789 418bc5 mov eax, r13d
00fd978c 488b8d80010000 mov rcx, qword ptr [rbp + 0x180]
00fd9793 4833cc xor rcx, rsp
00fd9796 e845217c00 call 0x14179b8e0
00fd979b 488b9c24e0020000 mov rbx, qword ptr [rsp + 0x2e0]
00fd97a3 4881c490020000 add rsp, 0x290
00fd97aa 415f pop r15
00fd97ac 415e pop r14
00fd97ae 415d pop r13
00fd97b0 415c pop r12
00fd97b2 5f pop rdi
00fd97b3 5e pop rsi
00fd97b4 5d pop rbp
00fd97b5 c3 ret 
00fd97b6 6690 nop 
00fd97b8 cf iretd 
00fd97b9 89fd mov ebp, edi
00fd97bb 0019 add byte ptr [rcx], bl
00fd97bd 8afd mov bh, ch
00fd97bf 00eb add bl, ch
00fd97c1 8afd mov bh, ch
00fd97c3 00a78cfd00b0 add byte ptr [rdi - 0x4fff0274], ah