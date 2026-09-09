; iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; RVA 0xf6e1f0
00f6e1f0 4053                     push rbx
00f6e1f2 4883ec20                 sub rsp, 0x20
00f6e1f6 488bd9                   mov rbx, rcx
00f6e1f9 e8327fb8ff               call 0x140af6130
00f6e1fe 806370e0                 and byte ptr [rbx + 0x70], 0xe0
00f6e202 488d05c7babe00           lea rax, [rip + 0xbebac7]
00f6e209 80a38c000000e0           and byte ptr [rbx + 0x8c], 0xe0
00f6e210 33c9                     xor ecx, ecx
00f6e212 488903                   mov qword ptr [rbx], rax
00f6e215 488d05ccbebb00           lea rax, [rip + 0xbbbecc]
00f6e21c 488983a0000000           mov qword ptr [rbx + 0xa0], rax
00f6e223 488983f8000000           mov qword ptr [rbx + 0xf8], rax
00f6e22a 48898310010000           mov qword ptr [rbx + 0x110], rax
00f6e231 488d8328010000           lea rax, [rbx + 0x128]
00f6e238 48894b30                 mov qword ptr [rbx + 0x30], rcx
00f6e23c 48894b38                 mov qword ptr [rbx + 0x38], rcx
00f6e240 48894b40                 mov qword ptr [rbx + 0x40], rcx
00f6e244 48894b48                 mov qword ptr [rbx + 0x48], rcx
00f6e248 48894b50                 mov qword ptr [rbx + 0x50], rcx
00f6e24c 48894b58                 mov qword ptr [rbx + 0x58], rcx
00f6e250 48894b60                 mov qword ptr [rbx + 0x60], rcx
00f6e254 48894b68                 mov qword ptr [rbx + 0x68], rcx
00f6e258 884b71                   mov byte ptr [rbx + 0x71], cl
00f6e25b 48894b74                 mov qword ptr [rbx + 0x74], rcx
00f6e25f 48898b80000000           mov qword ptr [rbx + 0x80], rcx
00f6e266 c7838800000069737461     mov dword ptr [rbx + 0x88], 0x61747369
00f6e270 48898b90000000           mov qword ptr [rbx + 0x90], rcx
00f6e277 898b98000000             mov dword ptr [rbx + 0x98], ecx
00f6e27d 66898b9c000000           mov word ptr [rbx + 0x9c], cx
00f6e284 48898ba8000000           mov qword ptr [rbx + 0xa8], rcx
00f6e28b 898bb0000000             mov dword ptr [rbx + 0xb0], ecx
00f6e291 48898bb8000000           mov qword ptr [rbx + 0xb8], rcx
00f6e298 898bc0000000             mov dword ptr [rbx + 0xc0], ecx
00f6e29e 888bc4000000             mov byte ptr [rbx + 0xc4], cl
00f6e2a4 898bc8000000             mov dword ptr [rbx + 0xc8], ecx
00f6e2aa 48898bd0000000           mov qword ptr [rbx + 0xd0], rcx
00f6e2b1 48898bd8000000           mov qword ptr [rbx + 0xd8], rcx
00f6e2b8 898be0000000             mov dword ptr [rbx + 0xe0], ecx
00f6e2be 48898be8000000           mov qword ptr [rbx + 0xe8], rcx
00f6e2c5 48898bf0000000           mov qword ptr [rbx + 0xf0], rcx
00f6e2cc 48898b00010000           mov qword ptr [rbx + 0x100], rcx
00f6e2d3 898b08010000             mov dword ptr [rbx + 0x108], ecx
00f6e2d9 48898b18010000           mov qword ptr [rbx + 0x118], rcx
00f6e2e0 898b20010000             mov dword ptr [rbx + 0x120], ecx
00f6e2e6 4885c0                   test rax, rax
00f6e2e9 740d                     je 0x140f6e2f8
00f6e2eb 0f57c0                   xorps xmm0, xmm0
00f6e2ee 0f1100                   movups xmmword ptr [rax], xmm0
00f6e2f1 0f114010                 movups xmmword ptr [rax + 0x10], xmm0
00f6e2f5 894820                   mov dword ptr [rax + 0x20], ecx
00f6e2f8 488bc3                   mov rax, rbx
00f6e2fb 4883c420                 add rsp, 0x20
00f6e2ff 5b                       pop rbx
00f6e300 c3                       ret 