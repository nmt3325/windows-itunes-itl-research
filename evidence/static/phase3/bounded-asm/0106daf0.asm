0106daf0 4c8bdc mov r11, rsp
0106daf3 55 push rbp
0106daf4 56 push rsi
0106daf5 4156 push r14
0106daf7 4157 push r15
0106daf9 498dabc8fdffff lea rbp, [r11 - 0x238]
0106db00 4881ec18030000 sub rsp, 0x318
0106db07 488b053275f600 mov rax, qword ptr [rip + 0xf67532]
0106db0e 4833c4 xor rax, rsp
0106db11 488985f0010000 mov qword ptr [rbp + 0x1f0], rax
0106db18 488bf2 mov rsi, rdx
0106db1b 4c8bf9 mov r15, rcx
0106db1e 4885d2 test rdx, rdx
0106db21 0f8455270000 je 0x14107027c
0106db27 4c8b7208 mov r14, qword ptr [rdx + 8]
0106db2b 4d85f6 test r14, r14
0106db2e 0f8448270000 je 0x14107027c
0106db34 49837e1000 cmp qword ptr [r14 + 0x10], 0
0106db39 0f843d270000 je 0x14107027c
0106db3f 49895b18 mov qword ptr [r11 + 0x18], rbx
0106db43 488d811c04a000 lea rax, [rcx + 0xa0041c]
0106db4a 49897bd8 mov qword ptr [r11 - 0x28], rdi
0106db4e 488db92801a000 lea rdi, [rcx + 0xa00128]
0106db55 4d8963d0 mov qword ptr [r11 - 0x30], r12
0106db59 4d896bc8 mov qword ptr [r11 - 0x38], r13
0106db5d 4c8ba97002e001 mov r13, qword ptr [rcx + 0x1e00270]
0106db64 4889442448 mov qword ptr [rsp + 0x48], rax
0106db69 4885ff test rdi, rdi
0106db6c 7414 je 0x14106db82
0106db6e 4881c13001a000 add rcx, 0xa00130
0106db75 33d2 xor edx, edx
0106db77 41b8ec020000 mov r8d, 0x2ec
0106db7d e81ef17200 call 0x14179cca0
0106db82 c7076d697468 mov dword ptr [rdi], 0x6874696d
0106db88 4533e4 xor r12d, r12d
0106db8b c74704f4020000 mov dword ptr [rdi + 4], 0x2f4
0106db92 418b4608 mov eax, dword ptr [r14 + 8]
0106db96 894710 mov dword ptr [rdi + 0x10], eax
0106db99 8b4628 mov eax, dword ptr [rsi + 0x28]
0106db9c 8987f4010000 mov dword ptr [rdi + 0x1f4], eax
0106dba2 8b4654 mov eax, dword ptr [rsi + 0x54]
0106dba5 894720 mov dword ptr [rdi + 0x20], eax
0106dba8 8b4658 mov eax, dword ptr [rsi + 0x58]
0106dbab 894778 mov dword ptr [rdi + 0x78], eax
0106dbae 488b4660 mov rax, qword ptr [rsi + 0x60]
0106dbb2 48898744010000 mov qword ptr [rdi + 0x144], rax
0106dbb9 8b465c mov eax, dword ptr [rsi + 0x5c]
0106dbbc 894728 mov dword ptr [rdi + 0x28], eax
0106dbbf 410fb7860a010000 movzx eax, word ptr [r14 + 0x10a]
0106dbc7 89472c mov dword ptr [rdi + 0x2c], eax
0106dbca 410fb7860c010000 movzx eax, word ptr [r14 + 0x10c]
0106dbd2 894730 mov dword ptr [rdi + 0x30], eax
0106dbd5 410fb7860e010000 movzx eax, word ptr [r14 + 0x10e]
0106dbdd 66894768 mov word ptr [rdi + 0x68], ax
0106dbe1 410fb78610010000 movzx eax, word ptr [r14 + 0x110]
0106dbe9 6689476a mov word ptr [rdi + 0x6a], ax
0106dbed 410fb6869a000000 movzx eax, byte ptr [r14 + 0x9a]
0106dbf5 c0e804 shr al, 4
0106dbf8 2401 and al, 1
0106dbfa 88476d mov byte ptr [rdi + 0x6d], al
0106dbfd 410fbf86a6000000 movsx eax, word ptr [r14 + 0xa6]
0106dc05 894734 mov dword ptr [rdi + 0x34], eax
0106dc08 410fb6869b000000 movzx eax, byte ptr [r14 + 0x9b]
0106dc10 c0e802 shr al, 2
0106dc13 2401 and al, 1
0106dc15 884753 mov byte ptr [rdi + 0x53], al
0106dc18 0fb7464c movzx eax, word ptr [rsi + 0x4c]
0106dc1c 894738 mov dword ptr [rdi + 0x38], eax
0106dc1f 8b4648 mov eax, dword ptr [rsi + 0x48]
0106dc22 898798000000 mov dword ptr [rdi + 0x98], eax
0106dc28 0fb7464e movzx eax, word ptr [rsi + 0x4e]
0106dc2c 6689870a020000 mov word ptr [rdi + 0x20a], ax
0106dc33 410fbf8602010000 movsx eax, word ptr [r14 + 0x102]
0106dc3b 894740 mov dword ptr [rdi + 0x40], eax
0106dc3e 498b4678 mov rax, qword ptr [r14 + 0x78]
0106dc42 8b4804 mov ecx, dword ptr [rax + 4]
0106dc45 894f44 mov dword ptr [rdi + 0x44], ecx
0106dc48 498b4678 mov rax, qword ptr [r14 + 0x78]
0106dc4c 8b4808 mov ecx, dword ptr [rax + 8]
0106dc4f 894f48 mov dword ptr [rdi + 0x48], ecx
0106dc52 418b8614010000 mov eax, dword ptr [r14 + 0x114]
0106dc59 89474c mov dword ptr [rdi + 0x4c], eax
0106dc5c 418b8618010000 mov eax, dword ptr [r14 + 0x118]
0106dc63 894760 mov dword ptr [rdi + 0x60], eax
0106dc66 418b861c010000 mov eax, dword ptr [r14 + 0x11c]
0106dc6d 894764 mov dword ptr [rdi + 0x64], eax
0106dc70 418b8620010000 mov eax, dword ptr [r14 + 0x120]
0106dc77 8987d8000000 mov dword ptr [rdi + 0xd8], eax
0106dc7d 418b8624010000 mov eax, dword ptr [r14 + 0x124]
0106dc84 898718010000 mov dword ptr [rdi + 0x118], eax
0106dc8a 418b8628010000 mov eax, dword ptr [r14 + 0x128]
0106dc91 89871c010000 mov dword ptr [rdi + 0x11c], eax
0106dc97 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dc9b 488b4820 mov rcx, qword ptr [rax + 0x20]
0106dc9f 48898f9c010000 mov qword ptr [rdi + 0x19c], rcx
0106dca6 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dcaa 488b4808 mov rcx, qword ptr [rax + 8]
0106dcae 48898f94010000 mov qword ptr [rdi + 0x194], rcx
0106dcb5 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dcb9 488b4810 mov rcx, qword ptr [rax + 0x10]
0106dcbd 48898fa4010000 mov qword ptr [rdi + 0x1a4], rcx
0106dcc4 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dcc8 488b4818 mov rcx, qword ptr [rax + 0x18]
0106dccc 48898f0c020000 mov qword ptr [rdi + 0x20c], rcx
0106dcd3 488b4608 mov rax, qword ptr [rsi + 8]
0106dcd7 4885c0 test rax, rax
0106dcda 7410 je 0x14106dcec
0106dcdc 4c396010 cmp qword ptr [rax + 0x10], r12
0106dce0 740a je 0x14106dcec
0106dce2 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dce6 488b4838 mov rcx, qword ptr [rax + 0x38]
0106dcea eb03 jmp 0x14106dcef
0106dcec 498bcc mov rcx, r12
0106dcef 48898fac010000 mov qword ptr [rdi + 0x1ac], rcx
0106dcf6 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dcfa 488b4848 mov rcx, qword ptr [rax + 0x48]
0106dcfe 48898fbc010000 mov qword ptr [rdi + 0x1bc], rcx
0106dd05 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dd09 488b4858 mov rcx, qword ptr [rax + 0x58]
0106dd0d 48898fcc010000 mov qword ptr [rdi + 0x1cc], rcx
0106dd14 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dd18 488b4840 mov rcx, qword ptr [rax + 0x40]
0106dd1c 48898fb4010000 mov qword ptr [rdi + 0x1b4], rcx
0106dd23 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dd27 488b4850 mov rcx, qword ptr [rax + 0x50]
0106dd2b 48898fc4010000 mov qword ptr [rdi + 0x1c4], rcx
0106dd32 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dd36 488b4860 mov rcx, qword ptr [rax + 0x60]
0106dd3a 48898fd4010000 mov qword ptr [rdi + 0x1d4], rcx
0106dd41 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dd45 8b4820 mov ecx, dword ptr [rax + 0x20]
0106dd48 898f60010000 mov dword ptr [rdi + 0x160], ecx
0106dd4e 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dd52 8b4808 mov ecx, dword ptr [rax + 8]
0106dd55 894f70 mov dword ptr [rdi + 0x70], ecx
0106dd58 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dd5c 8b4810 mov ecx, dword ptr [rax + 0x10]
0106dd5f 898f88000000 mov dword ptr [rdi + 0x88], ecx
0106dd65 488b4608 mov rax, qword ptr [rsi + 8]
0106dd69 4885c0 test rax, rax
0106dd6c 7410 je 0x14106dd7e
0106dd6e 4c396010 cmp qword ptr [rax + 0x10], r12
0106dd72 740a je 0x14106dd7e
0106dd74 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dd78 488b4838 mov rcx, qword ptr [rax + 0x38]
0106dd7c eb03 jmp 0x14106dd81
0106dd7e 498bcc mov rcx, r12
0106dd81 898fa8000000 mov dword ptr [rdi + 0xa8], ecx
0106dd87 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dd8b 8b4848 mov ecx, dword ptr [rax + 0x48]
0106dd8e 898fb0000000 mov dword ptr [rdi + 0xb0], ecx
0106dd94 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dd98 8b4858 mov ecx, dword ptr [rax + 0x58]
0106dd9b 898fb8000000 mov dword ptr [rdi + 0xb8], ecx
0106dda1 488b4610 mov rax, qword ptr [rsi + 0x10]
0106dda5 8b4840 mov ecx, dword ptr [rax + 0x40]
0106dda8 898fac000000 mov dword ptr [rdi + 0xac], ecx
0106ddae 488b4610 mov rax, qword ptr [rsi + 0x10]
0106ddb2 8b4850 mov ecx, dword ptr [rax + 0x50]
0106ddb5 898fb4000000 mov dword ptr [rdi + 0xb4], ecx
0106ddbb 488b4610 mov rax, qword ptr [rsi + 0x10]
0106ddbf 8b4860 mov ecx, dword ptr [rax + 0x60]
0106ddc2 898fe4000000 mov dword ptr [rdi + 0xe4], ecx
0106ddc8 488b4610 mov rax, qword ptr [rsi + 0x10]
0106ddcc 8b8888000000 mov ecx, dword ptr [rax + 0x88]
0106ddd2 898f9c000000 mov dword ptr [rdi + 0x9c], ecx
0106ddd8 498b4668 mov rax, qword ptr [r14 + 0x68]
0106dddc 0fb64801 movzx ecx, byte ptr [rax + 1]
0106dde0 884f52 mov byte ptr [rdi + 0x52], cl
0106dde3 498b4668 mov rax, qword ptr [r14 + 0x68]
0106dde7 8b4804 mov ecx, dword ptr [rax + 4]
0106ddea 898fbc000000 mov dword ptr [rdi + 0xbc], ecx
0106ddf0 418b86fc000000 mov eax, dword ptr [r14 + 0xfc]
0106ddf7 894774 mov dword ptr [rdi + 0x74], eax
0106ddfa 0fb74652 movzx eax, word ptr [rsi + 0x52]
0106ddfe 894758 mov dword ptr [rdi + 0x58], eax
0106de01 8b86f4020000 mov eax, dword ptr [rsi + 0x2f4]
0106de07 8987f0000000 mov dword ptr [rdi + 0xf0], eax
0106de0d 8b86f8020000 mov eax, dword ptr [rsi + 0x2f8]
0106de13 898700010000 mov dword ptr [rdi + 0x100], eax
0106de19 488b86e0020000 mov rax, qword ptr [rsi + 0x2e0]
0106de20 488987f4000000 mov qword ptr [rdi + 0xf4], rax
0106de27 488b86e8020000 mov rax, qword ptr [rsi + 0x2e8]
0106de2e 48898720010000 mov qword ptr [rdi + 0x120], rax
0106de35 8b86f0020000 mov eax, dword ptr [rsi + 0x2f0]
0106de3b 898704010000 mov dword ptr [rdi + 0x104], eax
0106de41 498b4e10 mov rcx, qword ptr [r14 + 0x10]
0106de45 410fb68605010000 movzx eax, byte ptr [r14 + 0x105]
0106de4d 4885c9 test rcx, rcx
0106de50 0f84d6030000 je 0x14106e22c
0106de56 f6811401000008 test byte ptr [rcx + 0x114], 8
0106de5d 0f84c9030000 je 0x14106e22c
0106de63 3c20 cmp al, 0x20
0106de65 0f83d6030000 jae 0x14106e241
0106de6b 410fb68604010000 movzx eax, byte ptr [r14 + 0x104]
0106de73 88476c mov byte ptr [rdi + 0x6c], al
0106de76 498b4678 mov rax, qword ptr [r14 + 0x78]
0106de7a 8b480c mov ecx, dword ptr [rax + 0xc]
0106de7d 894f7c mov dword ptr [rdi + 0x7c], ecx
0106de80 498b4678 mov rax, qword ptr [r14 + 0x78]
0106de84 8b4814 mov ecx, dword ptr [rax + 0x14]
0106de87 898f70020000 mov dword ptr [rdi + 0x270], ecx
0106de8d 498b06 mov rax, qword ptr [r14]
0106de90 48898780000000 mov qword ptr [rdi + 0x80], rax
0106de97 8b4638 mov eax, dword ptr [rsi + 0x38]
0106de9a 89878c000000 mov dword ptr [rdi + 0x8c], eax
0106dea0 410fb6869a000000 movzx eax, byte ptr [r14 + 0x9a]
0106dea8 c0e802 shr al, 2
0106deab 2401 and al, 1
0106dead 88476e mov byte ptr [rdi + 0x6e], al
0106deb0 0fb7466c movzx eax, word ptr [rsi + 0x6c]
0106deb4 66898790000000 mov word ptr [rdi + 0x90], ax
0106debb 0fb7466e movzx eax, word ptr [rsi + 0x6e]
0106debf 66898792000000 mov word ptr [rdi + 0x92], ax
0106dec6 8b4670 mov eax, dword ptr [rsi + 0x70]
0106dec9 898794000000 mov dword ptr [rdi + 0x94], eax
0106decf 410fb6869b000000 movzx eax, byte ptr [r14 + 0x9b]
0106ded7 c0e803 shr al, 3
0106deda 2401 and al, 1
0106dedc 8887a7000000 mov byte ptr [rdi + 0xa7], al
0106dee2 410fb6869b000000 movzx eax, byte ptr [r14 + 0x9b]
0106deea c0e804 shr al, 4
0106deed 2401 and al, 1
0106deef 888731020000 mov byte ptr [rdi + 0x231], al
0106def5 0fb64644 movzx eax, byte ptr [rsi + 0x44]
0106def9 88476f mov byte ptr [rdi + 0x6f], al
0106defc 0fb6463f movzx eax, byte ptr [rsi + 0x3f]
0106df00 888728010000 mov byte ptr [rdi + 0x128], al
0106df06 488b4610 mov rax, qword ptr [rsi + 0x10]
0106df0a 8b888c000000 mov ecx, dword ptr [rax + 0x8c]
0106df10 898fa0000000 mov dword ptr [rdi + 0xa0], ecx
0106df16 410fb7862c010000 movzx eax, word ptr [r14 + 0x12c]
0106df1e 668987a4000000 mov word ptr [rdi + 0xa4], ax
0106df25 410fb68690000000 movzx eax, byte ptr [r14 + 0x90]
0106df2d 8887a6000000 mov byte ptr [rdi + 0xa6], al
0106df33 410fb6869c000000 movzx eax, byte ptr [r14 + 0x9c]
0106df3b c0e804 shr al, 4
0106df3e 2401 and al, 1
0106df40 8887c8000000 mov byte ptr [rdi + 0xc8], al
0106df46 488b86d8020000 mov rax, qword ptr [rsi + 0x2d8]
0106df4d 488987cc000000 mov qword ptr [rdi + 0xcc], rax
0106df54 488b4610 mov rax, qword ptr [rsi + 0x10]
0106df58 8b8884000000 mov ecx, dword ptr [rax + 0x84]
0106df5e 898fd4000000 mov dword ptr [rdi + 0xd4], ecx
0106df64 0fb64641 movzx eax, byte ptr [rsi + 0x41]
0106df68 2401 and al, 1
0106df6a 8887c9000000 mov byte ptr [rdi + 0xc9], al
0106df70 488b4610 mov rax, qword ptr [rsi + 0x10]
0106df74 8b4804 mov ecx, dword ptr [rax + 4]
0106df77 898fec010000 mov dword ptr [rdi + 0x1ec], ecx
0106df7d 0fb64641 movzx eax, byte ptr [rsi + 0x41]
0106df81 c0e803 shr al, 3
0106df84 2401 and al, 1
0106df86 8887dd010000 mov byte ptr [rdi + 0x1dd], al
0106df8c 410fb6869d000000 movzx eax, byte ptr [r14 + 0x9d]
0106df94 c0e803 shr al, 3
0106df97 2401 and al, 1
0106df99 8887ca000000 mov byte ptr [rdi + 0xca], al
0106df9f 410fb6869b000000 movzx eax, byte ptr [r14 + 0x9b]
0106dfa7 c0e806 shr al, 6
0106dfaa 2401 and al, 1
0106dfac 8887cb000000 mov byte ptr [rdi + 0xcb], al
0106dfb2 410fb6869b000000 movzx eax, byte ptr [r14 + 0x9b]
0106dfba c0e807 shr al, 7
0106dfbd 8887e8000000 mov byte ptr [rdi + 0xe8], al
0106dfc3 410fb6869d000000 movzx eax, byte ptr [r14 + 0x9d]
0106dfcb 2401 and al, 1
0106dfcd 8887ea000000 mov byte ptr [rdi + 0xea], al
0106dfd3 410fb6869d000000 movzx eax, byte ptr [r14 + 0x9d]
0106dfdb d0e8 shr al, 1
0106dfdd 2401 and al, 1
0106dfdf 8887ed000000 mov byte ptr [rdi + 0xed], al
0106dfe5 8b4674 mov eax, dword ptr [rsi + 0x74]
0106dfe8 8987fc000000 mov dword ptr [rdi + 0xfc], eax
0106dfee 418b86e0000000 mov eax, dword ptr [r14 + 0xe0]
0106dff5 898790020000 mov dword ptr [rdi + 0x290], eax
0106dffb 418b86e4000000 mov eax, dword ptr [r14 + 0xe4]
0106e002 898794020000 mov dword ptr [rdi + 0x294], eax
0106e008 418b86e8000000 mov eax, dword ptr [r14 + 0xe8]
0106e00f 898798020000 mov dword ptr [rdi + 0x298], eax
0106e015 418b86ec000000 mov eax, dword ptr [r14 + 0xec]
0106e01c 89879c020000 mov dword ptr [rdi + 0x29c], eax
0106e022 418b86f0000000 mov eax, dword ptr [r14 + 0xf0]
0106e029 8987a0020000 mov dword ptr [rdi + 0x2a0], eax
0106e02f 418b86f4000000 mov eax, dword ptr [r14 + 0xf4]
0106e036 8987a4020000 mov dword ptr [rdi + 0x2a4], eax
0106e03c 418b86f8000000 mov eax, dword ptr [r14 + 0xf8]
0106e043 8987a8020000 mov dword ptr [rdi + 0x2a8], eax
0106e049 8b4668 mov eax, dword ptr [rsi + 0x68]
0106e04c 8987c0000000 mov dword ptr [rdi + 0xc0], eax
0106e052 410fb78600010000 movzx eax, word ptr [r14 + 0x100]
0106e05a 8987c4000000 mov dword ptr [rdi + 0xc4], eax
0106e060 410fb6869d000000 movzx eax, byte ptr [r14 + 0x9d]
0106e068 c0e806 shr al, 6
0106e06b 2401 and al, 1
0106e06d 8887eb000000 mov byte ptr [rdi + 0xeb], al
0106e073 410fb6869d000000 movzx eax, byte ptr [r14 + 0x9d]
0106e07b c0e805 shr al, 5
0106e07e 2401 and al, 1
0106e080 888714020000 mov byte ptr [rdi + 0x214], al
0106e086 410fb6869a000000 movzx eax, byte ptr [r14 + 0x9a]
0106e08e c0e807 shr al, 7
0106e091 888715020000 mov byte ptr [rdi + 0x215], al
0106e097 410fb6869d000000 movzx eax, byte ptr [r14 + 0x9d]
0106e09f c0e807 shr al, 7
0106e0a2 8887ec000000 mov byte ptr [rdi + 0xec], al
0106e0a8 410fb6869e000000 movzx eax, byte ptr [r14 + 0x9e]
0106e0b0 2401 and al, 1
0106e0b2 88877d020000 mov byte ptr [rdi + 0x27d], al
0106e0b8 410fb6869f000000 movzx eax, byte ptr [r14 + 0x9f]
0106e0c0 c0e804 shr al, 4
0106e0c3 2401 and al, 1
0106e0c5 88877e020000 mov byte ptr [rdi + 0x27e], al
0106e0cb 410fb6869f000000 movzx eax, byte ptr [r14 + 0x9f]
0106e0d3 c0e805 shr al, 5
0106e0d6 2401 and al, 1
0106e0d8 88877f020000 mov byte ptr [rdi + 0x27f], al
0106e0de 410fb6869e000000 movzx eax, byte ptr [r14 + 0x9e]
0106e0e6 d0e8 shr al, 1
0106e0e8 2401 and al, 1
0106e0ea 8887ef000000 mov byte ptr [rdi + 0xef], al
0106e0f0 410fb6869e000000 movzx eax, byte ptr [r14 + 0x9e]
0106e0f8 c0e802 shr al, 2
0106e0fb 2401 and al, 1
0106e0fd 8887ee000000 mov byte ptr [rdi + 0xee], al
0106e103 498b4670 mov rax, qword ptr [r14 + 0x70]
0106e107 8b4808 mov ecx, dword ptr [rax + 8]
0106e10a 898f10010000 mov dword ptr [rdi + 0x110], ecx
0106e110 498b4670 mov rax, qword ptr [r14 + 0x70]
0106e114 8b4804 mov ecx, dword ptr [rax + 4]
0106e117 898f0c010000 mov dword ptr [rdi + 0x10c], ecx
0106e11d 418b86ac000000 mov eax, dword ptr [r14 + 0xac]
0106e124 898774020000 mov dword ptr [rdi + 0x274], eax
0106e12a 498b4668 mov rax, qword ptr [r14 + 0x68]
0106e12e 8b4810 mov ecx, dword ptr [rax + 0x10]
0106e131 898ff8010000 mov dword ptr [rdi + 0x1f8], ecx
0106e137 498bce mov rcx, r14
0106e13a 410fb6869e000000 movzx eax, byte ptr [r14 + 0x9e]
0106e142 c0e803 shr al, 3
0106e145 2401 and al, 1
0106e147 888714010000 mov byte ptr [rdi + 0x114], al
0106e14d 410fb6869c000000 movzx eax, byte ptr [r14 + 0x9c]
0106e155 2401 and al, 1
0106e157 888716010000 mov byte ptr [rdi + 0x116], al
0106e15d 0fb64640 movzx eax, byte ptr [rsi + 0x40]
0106e161 c0e803 shr al, 3
0106e164 2401 and al, 1
0106e166 888717010000 mov byte ptr [rdi + 0x117], al
0106e16c e8cf4af3ff call 0x140fa2c40
0106e171 498bce mov rcx, r14
0106e174 4889872c010000 mov qword ptr [rdi + 0x12c], rax
0106e17b e8504bf3ff call 0x140fa2cd0
0106e180 498bce mov rcx, r14
0106e183 48898764020000 mov qword ptr [rdi + 0x264], rax
0106e18a e81149f3ff call 0x140fa2aa0
0106e18f 888729010000 mov byte ptr [rdi + 0x129], al
0106e195 3c0c cmp al, 0xc
0106e197 7207 jb 0x14106e1a0
0106e199 4488a729010000 mov byte ptr [rdi + 0x129], r12b
0106e1a0 0fb6463e movzx eax, byte ptr [rsi + 0x3e]
0106e1a4 888730020000 mov byte ptr [rdi + 0x230], al
0106e1aa 0fb64641 movzx eax, byte ptr [rsi + 0x41]
0106e1ae c0e804 shr al, 4
0106e1b1 2401 and al, 1
0106e1b3 884719 mov byte ptr [rdi + 0x19], al
0106e1b6 0fb64641 movzx eax, byte ptr [rsi + 0x41]
0106e1ba c0e805 shr al, 5
0106e1bd 2401 and al, 1
0106e1bf 888716020000 mov byte ptr [rdi + 0x216], al
0106e1c5 0fb64641 movzx eax, byte ptr [rsi + 0x41]
0106e1c9 c0e806 shr al, 6
0106e1cc 2401 and al, 1
0106e1ce 884718 mov byte ptr [rdi + 0x18], al
0106e1d1 410fb6869c000000 movzx eax, byte ptr [r14 + 0x9c]
0106e1d9 d0e8 shr al, 1
0106e1db 2401 and al, 1
0106e1dd 8887e9000000 mov byte ptr [rdi + 0xe9], al
0106e1e3 498b8640010000 mov rax, qword ptr [r14 + 0x140]
0106e1ea 48898734010000 mov qword ptr [rdi + 0x134], rax
0106e1f1 498b8648010000 mov rax, qword ptr [r14 + 0x148]
0106e1f8 4889873c010000 mov qword ptr [rdi + 0x13c], rax
0106e1ff 0fb64642 movzx eax, byte ptr [rsi + 0x42]
0106e203 c0e805 shr al, 5
0106e206 2401 and al, 1
0106e208 88876e020000 mov byte ptr [rdi + 0x26e], al
0106e20e 410fb6869f000000 movzx eax, byte ptr [r14 + 0x9f]
0106e216 c0e802 shr al, 2
0106e219 2401 and al, 1
0106e21b 88876f020000 mov byte ptr [rdi + 0x26f], al
0106e221 4d396610 cmp qword ptr [r14 + 0x10], r12
0106e225 7521 jne 0x14106e248
0106e227 418bd4 mov edx, r12d
0106e22a eb3f jmp 0x14106e26b
0106e22c 84c0 test al, al
0106e22e 0f8537fcffff jne 0x14106de6b
0106e234 4538a604010000 cmp byte ptr [r14 + 0x104], r12b
0106e23b 0f852afcffff jne 0x14106de6b
0106e241 32c0 xor al, al
0106e243 e92bfcffff jmp 0x14106de73
0106e248 498b4670 mov rax, qword ptr [r14 + 0x70]
0106e24c 4885c0 test rax, rax
0106e24f 7505 jne 0x14106e256
0106e251 418bd4 mov edx, r12d
0106e254 eb15 jmp 0x14106e26b
0106e256 8b5010 mov edx, dword ptr [rax + 0x10]
0106e259 03500c add edx, dword ptr [rax + 0xc]
0106e25c 8b4814 mov ecx, dword ptr [rax + 0x14]
0106e25f 85c9 test ecx, ecx
0106e261 7408 je 0x14106e26b
0106e263 034818 add ecx, dword ptr [rax + 0x18]
0106e266 3bd1 cmp edx, ecx
0106e268 0f47d1 cmova edx, ecx
0106e26b 89976c010000 mov dword ptr [rdi + 0x16c], edx
0106e271 498b4670 mov rax, qword ptr [r14 + 0x70]
0106e275 8b480c mov ecx, dword ptr [rax + 0xc]
0106e278 898f8c010000 mov dword ptr [rdi + 0x18c], ecx
0106e27e 498b4670 mov rax, qword ptr [r14 + 0x70]
0106e282 8b4810 mov ecx, dword ptr [rax + 0x10]
0106e285 898f90010000 mov dword ptr [rdi + 0x190], ecx
0106e28b 498b4670 mov rax, qword ptr [r14 + 0x70]
0106e28f 8b4814 mov ecx, dword ptr [rax + 0x14]
0106e292 898f84010000 mov dword ptr [rdi + 0x184], ecx
0106e298 498b4670 mov rax, qword ptr [r14 + 0x70]
0106e29c 8b4818 mov ecx, dword ptr [rax + 0x18]
0106e29f 898f88010000 mov dword ptr [rdi + 0x188], ecx
0106e2a5 488b4618 mov rax, qword ptr [rsi + 0x18]
0106e2a9 0fb608 movzx ecx, byte ptr [rax]
0106e2ac d0e9 shr cl, 1
0106e2ae 80e101 and cl, 1
0106e2b1 41888f9902a000 mov byte ptr [r15 + 0xa00299], cl
0106e2b8 488b4618 mov rax, qword ptr [rsi + 0x18]
0106e2bc 0fb608 movzx ecx, byte ptr [rax]
0106e2bf c0e902 shr cl, 2
0106e2c2 80e101 and cl, 1
0106e2c5 888f72010000 mov byte ptr [rdi + 0x172], cl
0106e2cb 488b4618 mov rax, qword ptr [rsi + 0x18]
0106e2cf 0fb608 movzx ecx, byte ptr [rax]
0106e2d2 c0e904 shr cl, 4
0106e2d5 80e101 and cl, 1
0106e2d8 888f2b010000 mov byte ptr [rdi + 0x12b], cl
0106e2de 488b4618 mov rax, qword ptr [rsi + 0x18]
0106e2e2 0fb74802 movzx ecx, word ptr [rax + 2]
0106e2e6 66898f74010000 mov word ptr [rdi + 0x174], cx
0106e2ed 488b4618 mov rax, qword ptr [rsi + 0x18]
0106e2f1 0fb7480c movzx ecx, word ptr [rax + 0xc]
0106e2f5 66898f76010000 mov word ptr [rdi + 0x176], cx
0106e2fc 488b4618 mov rax, qword ptr [rsi + 0x18]
0106e300 8b4804 mov ecx, dword ptr [rax + 4]
0106e303 898f78010000 mov dword ptr [rdi + 0x178], ecx
0106e309 488b4618 mov rax, qword ptr [rsi + 0x18]
0106e30d 0fb7480e movzx ecx, word ptr [rax + 0xe]
0106e311 66898f7c010000 mov word ptr [rdi + 0x17c], cx
0106e318 488b4618 mov rax, qword ptr [rsi + 0x18]
0106e31c 0fb74810 movzx ecx, word ptr [rax + 0x10]
0106e320 66898f7e010000 mov word ptr [rdi + 0x17e], cx
0106e327 488b4618 mov rax, qword ptr [rsi + 0x18]
0106e32b 8b4808 mov ecx, dword ptr [rax + 8]
0106e32e 898f80010000 mov dword ptr [rdi + 0x180], ecx
0106e334 8b462c mov eax, dword ptr [rsi + 0x2c]
0106e337 89872c020000 mov dword ptr [rdi + 0x22c], eax
0106e33d 0fb74e50 movzx ecx, word ptr [rsi + 0x50]
0106e341 e81ac2ffff call 0x14106a560
0106e346 66894750 mov word ptr [rdi + 0x50], ax
0106e34a 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e34e 488b4808 mov rcx, qword ptr [rax + 8]
0106e352 48898f34020000 mov qword ptr [rdi + 0x234], rcx
0106e359 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e35d 488b4810 mov rcx, qword ptr [rax + 0x10]
0106e361 48898f88020000 mov qword ptr [rdi + 0x288], rcx
0106e368 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e36c 488b4818 mov rcx, qword ptr [rax + 0x18]
0106e370 48898f3c020000 mov qword ptr [rdi + 0x23c], rcx
0106e377 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e37b 0fb64804 movzx ecx, byte ptr [rax + 4]
0106e37f 888f7c020000 mov byte ptr [rdi + 0x27c], cl
0106e385 410fb6868a000000 movzx eax, byte ptr [r14 + 0x8a]
0106e38d 88875b020000 mov byte ptr [rdi + 0x25b], al
0106e393 410fb68688000000 movzx eax, byte ptr [r14 + 0x88]
0106e39b c0e803 shr al, 3
0106e39e 2401 and al, 1
0106e3a0 888758020000 mov byte ptr [rdi + 0x258], al
0106e3a6 418b868c000000 mov eax, dword ptr [r14 + 0x8c]
0106e3ad 898778020000 mov dword ptr [rdi + 0x278], eax
0106e3b3 410fb68689000000 movzx eax, byte ptr [r14 + 0x89]
0106e3bb 8887e2020000 mov byte ptr [rdi + 0x2e2], al
0106e3c1 3c01 cmp al, 1
0106e3c3 7513 jne 0x14106e3d8
0106e3c5 498bce mov rcx, r14
0106e3c8 e84352f2ff call 0x140f93610
0106e3cd 84c0 test al, al
0106e3cf 7507 jne 0x14106e3d8
0106e3d1 4488a7e2020000 mov byte ptr [rdi + 0x2e2], r12b
0106e3d8 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e3dc 488b4808 mov rcx, qword ptr [rax + 8]
0106e3e0 4883f9fd cmp rcx, -3
0106e3e4 7438 je 0x14106e41e
0106e3e6 7736 ja 0x14106e41e
0106e3e8 4885c9 test rcx, rcx
0106e3eb 7431 je 0x14106e41e
0106e3ed 410fb68688000000 movzx eax, byte ptr [r14 + 0x88]
0106e3f5 2401 and al, 1
0106e3f7 88875c020000 mov byte ptr [rdi + 0x25c], al
0106e3fd 410fb68688000000 movzx eax, byte ptr [r14 + 0x88]
0106e405 d0e8 shr al, 1
0106e407 2401 and al, 1
0106e409 88875d020000 mov byte ptr [rdi + 0x25d], al
0106e40f 410fb68688000000 movzx eax, byte ptr [r14 + 0x88]
0106e417 c0e802 shr al, 2
0106e41a 2401 and al, 1
0106e41c eb0a jmp 0x14106e428
0106e41e 664489a75c020000 mov word ptr [rdi + 0x25c], r12w
0106e426 32c0 xor al, al
0106e428 88875e020000 mov byte ptr [rdi + 0x25e], al
0106e42e 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e432 0fb608 movzx ecx, byte ptr [rax]
0106e435 d0e9 shr cl, 1
0106e437 80e101 and cl, 1
0106e43a 888f60020000 mov byte ptr [rdi + 0x260], cl
0106e440 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e444 0fb608 movzx ecx, byte ptr [rax]
0106e447 c0e902 shr cl, 2
0106e44a 80e101 and cl, 1
0106e44d 888f61020000 mov byte ptr [rdi + 0x261], cl
0106e453 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e457 0fb608 movzx ecx, byte ptr [rax]
0106e45a c0e903 shr cl, 3
0106e45d 80e101 and cl, 1
0106e460 888f62020000 mov byte ptr [rdi + 0x262], cl
0106e466 488b4610 mov rax, qword ptr [rsi + 0x10]
0106e46a 0fb608 movzx ecx, byte ptr [rax]
0106e46d d0e9 shr cl, 1
0106e46f 80e101 and cl, 1
0106e472 41888f8103a000 mov byte ptr [r15 + 0xa00381], cl
0106e479 488b4610 mov rax, qword ptr [rsi + 0x10]
0106e47d 0fb608 movzx ecx, byte ptr [rax]
0106e480 c0e902 shr cl, 2
0106e483 80e101 and cl, 1
0106e486 888f5a020000 mov byte ptr [rdi + 0x25a], cl
0106e48c 488b4610 mov rax, qword ptr [rsi + 0x10]
0106e490 0fb608 movzx ecx, byte ptr [rax]
0106e493 c0e905 shr cl, 5
0106e496 80e101 and cl, 1
0106e499 888f6c020000 mov byte ptr [rdi + 0x26c], cl
0106e49f 498b8650010000 mov rax, qword ptr [r14 + 0x150]
0106e4a6 488987e4010000 mov qword ptr [rdi + 0x1e4], rax
0106e4ad 418b8658010000 mov eax, dword ptr [r14 + 0x158]
0106e4b4 8987f0010000 mov dword ptr [rdi + 0x1f0], eax
0106e4ba 418b865c010000 mov eax, dword ptr [r14 + 0x15c]
0106e4c1 898720020000 mov dword ptr [rdi + 0x220], eax
0106e4c7 498b8638010000 mov rax, qword ptr [r14 + 0x138]
0106e4ce 488987fc010000 mov qword ptr [rdi + 0x1fc], rax
0106e4d5 488b4610 mov rax, qword ptr [rsi + 0x10]
0106e4d9 488b4828 mov rcx, qword ptr [rax + 0x28]
0106e4dd 48898fac020000 mov qword ptr [rdi + 0x2ac], rcx
0106e4e4 488b4610 mov rax, qword ptr [rsi + 0x10]
0106e4e8 488b4830 mov rcx, qword ptr [rax + 0x30]
0106e4ec 48898fb4020000 mov qword ptr [rdi + 0x2b4], rcx
0106e4f3 498b4668 mov rax, qword ptr [r14 + 0x68]
0106e4f7 0fb74814 movzx ecx, word ptr [rax + 0x14]
0106e4fb 66898fd0020000 mov word ptr [rdi + 0x2d0], cx
0106e502 498b4668 mov rax, qword ptr [r14 + 0x68]
0106e506 0fb74816 movzx ecx, word ptr [rax + 0x16]
0106e50a 66898fd2020000 mov word ptr [rdi + 0x2d2], cx
0106e511 498b4668 mov rax, qword ptr [r14 + 0x68]
0106e515 0fb608 movzx ecx, byte ptr [rax]
0106e518 c0e903 shr cl, 3
0106e51b 80e101 and cl, 1
0106e51e 888fd4020000 mov byte ptr [rdi + 0x2d4], cl
0106e524 0fb64642 movzx eax, byte ptr [rsi + 0x42]
0106e528 c0e806 shr al, 6
0106e52b 2401 and al, 1
0106e52d 8887bc020000 mov byte ptr [rdi + 0x2bc], al
0106e533 0fb64642 movzx eax, byte ptr [rsi + 0x42]
0106e537 c0e807 shr al, 7
0106e53a 8887d5020000 mov byte ptr [rdi + 0x2d5], al
0106e540 410fb6869f000000 movzx eax, byte ptr [r14 + 0x9f]
0106e548 c0e806 shr al, 6
0106e54b 2401 and al, 1
0106e54d 8887be020000 mov byte ptr [rdi + 0x2be], al
0106e553 410fb686a0000000 movzx eax, byte ptr [r14 + 0xa0]
0106e55b 2401 and al, 1
0106e55d 8887cc020000 mov byte ptr [rdi + 0x2cc], al
0106e563 410fb686a0000000 movzx eax, byte ptr [r14 + 0xa0]
0106e56b d0e8 shr al, 1
0106e56d 2401 and al, 1
0106e56f 8887cd020000 mov byte ptr [rdi + 0x2cd], al
0106e575 410fb68607010000 movzx eax, byte ptr [r14 + 0x107]
0106e57d 8887bf020000 mov byte ptr [rdi + 0x2bf], al
0106e583 410fb686a0000000 movzx eax, byte ptr [r14 + 0xa0]
0106e58b c0e802 shr al, 2
0106e58e 2401 and al, 1
0106e590 8887ce020000 mov byte ptr [rdi + 0x2ce], al
0106e596 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e59a 488b4820 mov rcx, qword ptr [rax + 0x20]
0106e59e 48898fc4020000 mov qword ptr [rdi + 0x2c4], rcx
0106e5a5 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e5a9 0fb608 movzx ecx, byte ptr [rax]
0106e5ac c0e904 shr cl, 4
0106e5af 80e101 and cl, 1
0106e5b2 888fbd020000 mov byte ptr [rdi + 0x2bd], cl
0106e5b8 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e5bc 0fb64828 movzx ecx, byte ptr [rax + 0x28]
0106e5c0 41888fe803a000 mov byte ptr [r15 + 0xa003e8], cl
0106e5c7 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e5cb 0fb64829 movzx ecx, byte ptr [rax + 0x29]
0106e5cf 888fc1020000 mov byte ptr [rdi + 0x2c1], cl
0106e5d5 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e5d9 0fb6482a movzx ecx, byte ptr [rax + 0x2a]
0106e5dd 888fc2020000 mov byte ptr [rdi + 0x2c2], cl
0106e5e3 488b4620 mov rax, qword ptr [rsi + 0x20]
0106e5e7 0fb6482b movzx ecx, byte ptr [rax + 0x2b]
0106e5eb 888fc3020000 mov byte ptr [rdi + 0x2c3], cl
0106e5f1 41f6869b00000008 test byte ptr [r14 + 0x9b], 8
0106e5f9 7404 je 0x14106e5ff
0106e5fb b001 mov al, 1
0106e5fd eb30 jmp 0x14106e62f
0106e5ff 33d2 xor edx, edx
0106e601 498bce mov rcx, r14
0106e604 e86725f3ff call 0x140fa0b70
0106e609 a990000100 test eax, 0x10090
0106e60e 7404 je 0x14106e614
0106e610 b001 mov al, 1
0106e612 eb1b jmp 0x14106e62f
0106e614 41f6869d00000008 test byte ptr [r14 + 0x9d], 8
0106e61c 7404 je 0x14106e622
0106e61e b001 mov al, 1
0106e620 eb0d jmp 0x14106e62f
0106e622 498bce mov rcx, r14
0106e625 e87652f2ff call 0x140f938a0
0106e62a 84c0 test al, al
0106e62c 0f95c0 setne al
0106e62f 8887cf020000 mov byte ptr [rdi + 0x2cf], al
0106e635 498b4670 mov rax, qword ptr [r14 + 0x70]
0106e639 0fb64820 movzx ecx, byte ptr [rax + 0x20]
0106e63d 888fd6020000 mov byte ptr [rdi + 0x2d6], cl
0106e643 498b4670 mov rax, qword ptr [r14 + 0x70]
0106e647 0fb64821 movzx ecx, byte ptr [rax + 0x21]
0106e64b 888fd7020000 mov byte ptr [rdi + 0x2d7], cl
0106e651 498b4670 mov rax, qword ptr [r14 + 0x70]
0106e655 0fb64822 movzx ecx, byte ptr [rax + 0x22]
0106e659 888fd8020000 mov byte ptr [rdi + 0x2d8], cl
0106e65f 410fb686a0000000 movzx eax, byte ptr [r14 + 0xa0]
0106e667 c0e803 shr al, 3
0106e66a 2401 and al, 1
0106e66c 8887d9020000 mov byte ptr [rdi + 0x2d9], al
0106e672 0fb64640 movzx eax, byte ptr [rsi + 0x40]
0106e676 d0e8 shr al, 1
0106e678 2401 and al, 1
0106e67a 8887da020000 mov byte ptr [rdi + 0x2da], al
0106e680 488b4610 mov rax, qword ptr [rsi + 0x10]
0106e684 0fb608 movzx ecx, byte ptr [rax]
0106e687 c0e907 shr cl, 7
0106e68a 888fdb020000 mov byte ptr [rdi + 0x2db], cl
0106e690 488b4610 mov rax, qword ptr [rsi + 0x10]
0106e694 8b8890000000 mov ecx, dword ptr [rax + 0x90]
0106e69a 898fdc020000 mov dword ptr [rdi + 0x2dc], ecx
0106e6a0 0fb64645 movzx eax, byte ptr [rsi + 0x45]
0106e6a4 8887e1020000 mov byte ptr [rdi + 0x2e1], al
0106e6aa 0fb64643 movzx eax, byte ptr [rsi + 0x43]
0106e6ae 2401 and al, 1
0106e6b0 8887e3020000 mov byte ptr [rdi + 0x2e3], al
0106e6b6 41f6869c00000004 test byte ptr [r14 + 0x9c], 4
0106e6be 741f je 0x14106e6df
0106e6c0 81a774020000ff7fffff and dword ptr [rdi + 0x274], 0xffff7fff
0106e6ca 4489a76c010000 mov dword ptr [rdi + 0x16c], r12d
0106e6d1 4c89a78c010000 mov qword ptr [rdi + 0x18c], r12
0106e6d8 4c89a784010000 mov qword ptr [rdi + 0x184], r12
0106e6df 488b4660 mov rax, qword ptr [rsi + 0x60]
0106e6e3 b9ffffffff mov ecx, 0xffffffff
0106e6e8 483bc1 cmp rax, rcx
0106e6eb 0f46c8 cmovbe ecx, eax
0106e6ee 894f24 mov dword ptr [rdi + 0x24], ecx
0106e6f1 498b4628 mov rax, qword ptr [r14 + 0x28]
0106e6f5 4885c0 test rax, rax
0106e6f8 7409 je 0x14106e703
0106e6fa 8b4018 mov eax, dword ptr [rax + 0x18]
0106e6fd 8987dc000000 mov dword ptr [rdi + 0xdc], eax
0106e703 498b4640 mov rax, qword ptr [r14 + 0x40]
0106e707 4885c0 test rax, rax
0106e70a 7409 je 0x14106e715
0106e70c 8b403c mov eax, dword ptr [rax + 0x3c]
0106e70f 8987e0010000 mov dword ptr [rdi + 0x1e0], eax
0106e715 8b4634 mov eax, dword ptr [rsi + 0x34]
0106e718 3d454c4946 cmp eax, 0x46494c45
0106e71d 0f848a000000 je 0x14106e7ad
0106e723 3d50545448 cmp eax, 0x48545450
0106e728 747a je 0x14106e7a4
0106e72a 3d44524853 cmp eax, 0x53485244
0106e72f 0f859e000000 jne 0x14106e7d3
0106e735 c7471403000000 mov dword ptr [rdi + 0x14], 3
0106e73c 488bce mov rcx, rsi
0106e73f 488b8680000000 mov rax, qword ptr [rsi + 0x80]
0106e746 48898780020000 mov qword ptr [rdi + 0x280], rax
0106e74d 0fb68690000000 movzx eax, byte ptr [rsi + 0x90]
0106e754 88876d020000 mov byte ptr [rdi + 0x26d], al
0106e75a 8b8698000000 mov eax, dword ptr [rsi + 0x98]
0106e760 898750020000 mov dword ptr [rdi + 0x250], eax
0106e766 8b869c000000 mov eax, dword ptr [rsi + 0x9c]
0106e76c 898754020000 mov dword ptr [rdi + 0x254], eax
0106e772 0fb68694000000 movzx eax, byte ptr [rsi + 0x94]
0106e779 888732020000 mov byte ptr [rdi + 0x232], al
0106e77f 0fb68695000000 movzx eax, byte ptr [rsi + 0x95]
0106e786 888733020000 mov byte ptr [rdi + 0x233], al
0106e78c e86fb3f3ff call 0x140fa9b00
0106e791 84c0 test al, al
0106e793 743e je 0x14106e7d3
0106e795 807e3d01 cmp byte ptr [rsi + 0x3d], 1
0106e799 7538 jne 0x14106e7d3
0106e79b c6875f02000001 mov byte ptr [rdi + 0x25f], 1
0106e7a2 eb2f jmp 0x14106e7d3
0106e7a4 c7471402000000 mov dword ptr [rdi + 0x14], 2
0106e7ab eb26 jmp 0x14106e7d3
0106e7ad c7471401000000 mov dword ptr [rdi + 0x14], 1
0106e7b4 8b86bc020000 mov eax, dword ptr [rsi + 0x2bc]
0106e7ba 89471c mov dword ptr [rdi + 0x1c], eax
0106e7bd 0fb786c4020000 movzx eax, word ptr [rsi + 0x2c4]
0106e7c4 6689475c mov word ptr [rdi + 0x5c], ax
0106e7c8 0fb786c6020000 movzx eax, word ptr [rsi + 0x2c6]
0106e7cf 6689475e mov word ptr [rdi + 0x5e], ax
0106e7d3 4d638eb0000000 movsxd r9, dword ptr [r14 + 0xb0]
0106e7da 498d9578010000 lea rdx, [r13 + 0x178]
0106e7e1 418bdc mov ebx, r12d
0106e7e4 4585c9 test r9d, r9d
0106e7e7 0f84af000000 je 0x14106e89c
0106e7ed 458bdc mov r11d, r12d
0106e7f0 4d8bd4 mov r10, r12
0106e7f3 4885d2 test rdx, rdx
0106e7f6 0f84dc0c0000 je 0x14106f4d8
0106e7fc 813a63727473 cmp dword ptr [rdx], 0x73747263
0106e802 0f85d00c0000 jne 0x14106f4d8
0106e808 395a3c cmp dword ptr [rdx + 0x3c], ebx
0106e80b 0f84c70c0000 je 0x14106f4d8
0106e811 4585c9 test r9d, r9d
0106e814 0f8ebe0c0000 jle 0x14106f4d8
0106e81a 443b4a2c cmp r9d, dword ptr [rdx + 0x2c]
0106e81e 0f8fb40c0000 jg 0x14106f4d8
0106e824 488b4210 mov rax, qword ptr [rdx + 0x10]
0106e828 4d8d41ff lea r8, [r9 - 1]
0106e82c 488b00 mov rax, qword ptr [rax]
0106e82f 4e8d04c0 lea r8, [rax + r8*8]
0106e833 4d85c0 test r8, r8
0106e836 741f je 0x14106e857
0106e838 4d6320 movsxd r12, dword ptr [r8]
0106e83b 4585e4 test r12d, r12d
0106e83e 7817 js 0x14106e857
0106e840 418b4804 mov ecx, dword ptr [r8 + 4]
0106e844 85c9 test ecx, ecx
0106e846 7e0f jle 0x14106e857
0106e848 488b4220 mov rax, qword ptr [rdx + 0x20]
0106e84c 4d8bd4 mov r10, r12
0106e84f 448bd9 mov r11d, ecx
0106e852 4c0310 add r10, qword ptr [rax]
0106e855 eb05 jmp 0x14106e85c
0106e857 bbceffffff mov ebx, 0xffffffce
0106e85c 85db test ebx, ebx
0106e85e 0f85f4190000 jne 0x141070258
0106e864 4585db test r11d, r11d
0106e867 7433 je 0x14106e89c
0106e869 488d442448 lea rax, [rsp + 0x48]
0106e86e 458bc3 mov r8d, r11d
0106e871 4889442430 mov qword ptr [rsp + 0x30], rax
0106e876 498bd2 mov rdx, r10
0106e879 c744242801000000 mov dword ptr [rsp + 0x28], 1
0106e881 498bcf mov rcx, r15
0106e884 c744242002000000 mov dword ptr [rsp + 0x20], 2
0106e88c e8efc3ffff call 0x14106ac80
0106e891 8bd8 mov ebx, eax
0106e893 85c0 test eax, eax
0106e895 7505 jne 0x14106e89c
0106e897 ff470c inc dword ptr [rdi + 0xc]
0106e89a eb08 jmp 0x14106e8a4
0106e89c 85db test ebx, ebx
0106e89e 0f85b4190000 jne 0x141070258
0106e8a4 4d638eb4000000 movsxd r9, dword ptr [r14 + 0xb4]
0106e8ab 4d8da508020000 lea r12, [r13 + 0x208]
0106e8b2 33db xor ebx, ebx
0106e8b4 4585c9 test r9d, r9d
0106e8b7 0f84b2000000 je 0x14106e96f
0106e8bd 4533d2 xor r10d, r10d
0106e8c0 33d2 xor edx, edx
0106e8c2 4d85e4 test r12, r12
0106e8c5 0f840d0c0000 je 0x14106f4d8
0106e8cb 41813c2463727473 cmp dword ptr [r12], 0x73747263
0106e8d3 0f85ff0b0000 jne 0x14106f4d8
0106e8d9 413954243c cmp dword ptr [r12 + 0x3c], edx
0106e8de 0f84f40b0000 je 0x14106f4d8
0106e8e4 4585c9 test r9d, r9d
0106e8e7 0f8eeb0b0000 jle 0x14106f4d8
0106e8ed 453b4c242c cmp r9d, dword ptr [r12 + 0x2c]
0106e8f2 0f8fe00b0000 jg 0x14106f4d8
0106e8f8 498b442410 mov rax, qword ptr [r12 + 0x10]
0106e8fd 4d8d41ff lea r8, [r9 - 1]
0106e901 488b00 mov rax, qword ptr [rax]
0106e904 4e8d04c0 lea r8, [rax + r8*8]
0106e908 4d85c0 test r8, r8
0106e90b 7420 je 0x14106e92d
0106e90d 4d6318 movsxd r11, dword ptr [r8]
0106e910 4585db test r11d, r11d
0106e913 7818 js 0x14106e92d
0106e915 418b4804 mov ecx, dword ptr [r8 + 4]
0106e919 85c9 test ecx, ecx
0106e91b 7e10 jle 0x14106e92d
0106e91d 498b442420 mov rax, qword ptr [r12 + 0x20]
0106e922 498bd3 mov rdx, r11
0106e925 448bd1 mov r10d, ecx
0106e928 480310 add rdx, qword ptr [rax]
0106e92b eb05 jmp 0x14106e932
0106e92d bbceffffff mov ebx, 0xffffffce
0106e932 85db test ebx, ebx
0106e934 0f851e190000 jne 0x141070258
0106e93a 4585d2 test r10d, r10d
0106e93d 7430 je 0x14106e96f
0106e93f 488d442448 lea rax, [rsp + 0x48]
0106e944 458bc2 mov r8d, r10d
0106e947 4889442430 mov qword ptr [rsp + 0x30], rax
0106e94c 498bcf mov rcx, r15
0106e94f c744242801000000 mov dword ptr [rsp + 0x28], 1
0106e957 c744242004000000 mov dword ptr [rsp + 0x20], 4
0106e95f e81cc3ffff call 0x14106ac80
0106e964 8bd8 mov ebx, eax
0106e966 85c0 test eax, eax
0106e968 7505 jne 0x14106e96f
0106e96a ff470c inc dword ptr [rdi + 0xc]
0106e96d eb08 jmp 0x14106e977
0106e96f 85db test ebx, ebx
0106e971 0f85e1180000 jne 0x141070258
0106e977 4d638eb8000000 movsxd r9, dword ptr [r14 + 0xb8]
0106e97e 33db xor ebx, ebx
0106e980 4585c9 test r9d, r9d
0106e983 0f84b2000000 je 0x14106ea3b
0106e989 4533d2 xor r10d, r10d
0106e98c 33d2 xor edx, edx
0106e98e 4d85e4 test r12, r12
0106e991 0f84410b0000 je 0x14106f4d8
0106e997 41813c2463727473 cmp dword ptr [r12], 0x73747263
0106e99f 0f85330b0000 jne 0x14106f4d8
0106e9a5 413954243c cmp dword ptr [r12 + 0x3c], edx
0106e9aa 0f84280b0000 je 0x14106f4d8
0106e9b0 4585c9 test r9d, r9d
0106e9b3 0f8e1f0b0000 jle 0x14106f4d8
0106e9b9 453b4c242c cmp r9d, dword ptr [r12 + 0x2c]
0106e9be 0f8f140b0000 jg 0x14106f4d8
0106e9c4 498b442410 mov rax, qword ptr [r12 + 0x10]
0106e9c9 4d8d41ff lea r8, [r9 - 1]
0106e9cd 488b00 mov rax, qword ptr [rax]
0106e9d0 4e8d04c0 lea r8, [rax + r8*8]
0106e9d4 4d85c0 test r8, r8
0106e9d7 7420 je 0x14106e9f9
0106e9d9 4d6318 movsxd r11, dword ptr [r8]
0106e9dc 4585db test r11d, r11d
0106e9df 7818 js 0x14106e9f9
0106e9e1 418b4804 mov ecx, dword ptr [r8 + 4]
0106e9e5 85c9 test ecx, ecx
0106e9e7 7e10 jle 0x14106e9f9
0106e9e9 498b442420 mov rax, qword ptr [r12 + 0x20]
0106e9ee 498bd3 mov rdx, r11
0106e9f1 448bd1 mov r10d, ecx
0106e9f4 480310 add rdx, qword ptr [rax]
0106e9f7 eb05 jmp 0x14106e9fe
0106e9f9 bbceffffff mov ebx, 0xffffffce
0106e9fe 85db test ebx, ebx
0106ea00 0f8552180000 jne 0x141070258
0106ea06 4585d2 test r10d, r10d
0106ea09 7430 je 0x14106ea3b
0106ea0b 488d442448 lea rax, [rsp + 0x48]
0106ea10 458bc2 mov r8d, r10d
0106ea13 4889442430 mov qword ptr [rsp + 0x30], rax
0106ea18 498bcf mov rcx, r15
0106ea1b c744242801000000 mov dword ptr [rsp + 0x28], 1
0106ea23 c74424201b000000 mov dword ptr [rsp + 0x20], 0x1b
0106ea2b e850c2ffff call 0x14106ac80
0106ea30 8bd8 mov ebx, eax
0106ea32 85c0 test eax, eax
0106ea34 7505 jne 0x14106ea3b
0106ea36 ff470c inc dword ptr [rdi + 0xc]
0106ea39 eb08 jmp 0x14106ea43
0106ea3b 85db test ebx, ebx
0106ea3d 0f8515180000 jne 0x141070258
0106ea43 4d638ec4000000 movsxd r9, dword ptr [r14 + 0xc4]
0106ea4a 4d8d8508020000 lea r8, [r13 + 0x208]
0106ea51 33db xor ebx, ebx
0106ea53 4585c9 test r9d, r9d
0106ea56 0f84af000000 je 0x14106eb0b
0106ea5c 4533db xor r11d, r11d
0106ea5f 4533d2 xor r10d, r10d
0106ea62 4d85c0 test r8, r8
0106ea65 0f846d0a0000 je 0x14106f4d8
0106ea6b 41813863727473 cmp dword ptr [r8], 0x73747263
0106ea72 0f85600a0000 jne 0x14106f4d8
0106ea78 4139583c cmp dword ptr [r8 + 0x3c], ebx
0106ea7c 0f84560a0000 je 0x14106f4d8
0106ea82 4585c9 test r9d, r9d
0106ea85 0f8e4d0a0000 jle 0x14106f4d8
0106ea8b 453b482c cmp r9d, dword ptr [r8 + 0x2c]
0106ea8f 0f8f430a0000 jg 0x14106f4d8
0106ea95 498b4010 mov rax, qword ptr [r8 + 0x10]
0106ea99 488b08 mov rcx, qword ptr [rax]
0106ea9c 498d41ff lea rax, [r9 - 1]
0106eaa0 488d04c1 lea rax, [rcx + rax*8]
0106eaa4 4885c0 test rax, rax
0106eaa7 741d je 0x14106eac6
0106eaa9 486310 movsxd rdx, dword ptr [rax]
0106eaac 85d2 test edx, edx
0106eaae 7816 js 0x14106eac6
0106eab0 8b4804 mov ecx, dword ptr [rax + 4]
0106eab3 85c9 test ecx, ecx
0106eab5 7e0f jle 0x14106eac6
0106eab7 498b4020 mov rax, qword ptr [r8 + 0x20]
0106eabb 4c8bd2 mov r10, rdx
0106eabe 448bd9 mov r11d, ecx
0106eac1 4c0310 add r10, qword ptr [rax]
0106eac4 eb05 jmp 0x14106eacb
0106eac6 bbceffffff mov ebx, 0xffffffce
0106eacb 85db test ebx, ebx
0106eacd 0f8585170000 jne 0x141070258
0106ead3 4585db test r11d, r11d
0106ead6 7433 je 0x14106eb0b
0106ead8 488d442448 lea rax, [rsp + 0x48]
0106eadd 458bc3 mov r8d, r11d
0106eae0 4889442430 mov qword ptr [rsp + 0x30], rax
0106eae5 498bd2 mov rdx, r10
0106eae8 c744242801000000 mov dword ptr [rsp + 0x28], 1
0106eaf0 498bcf mov rcx, r15
0106eaf3 c74424200c000000 mov dword ptr [rsp + 0x20], 0xc
0106eafb e880c1ffff call 0x14106ac80
0106eb00 8bd8 mov ebx, eax
0106eb02 85c0 test eax, eax
0106eb04 7505 jne 0x14106eb0b
0106eb06 ff470c inc dword ptr [rdi + 0xc]
0106eb09 eb08 jmp 0x14106eb13
0106eb0b 85db test ebx, ebx
0106eb0d 0f8545170000 jne 0x141070258
0106eb13 4d638ebc000000 movsxd r9, dword ptr [r14 + 0xbc]
0106eb1a 4d8d85c0010000 lea r8, [r13 + 0x1c0]
0106eb21 33db xor ebx, ebx
0106eb23 4585c9 test r9d, r9d
0106eb26 0f84af000000 je 0x14106ebdb
0106eb2c 4533db xor r11d, r11d
0106eb2f 4533d2 xor r10d, r10d
0106eb32 4d85c0 test r8, r8
0106eb35 0f849d090000 je 0x14106f4d8
0106eb3b 41813863727473 cmp dword ptr [r8], 0x73747263
0106eb42 0f8590090000 jne 0x14106f4d8
0106eb48 4139583c cmp dword ptr [r8 + 0x3c], ebx
0106eb4c 0f8486090000 je 0x14106f4d8
0106eb52 4585c9 test r9d, r9d
0106eb55 0f8e7d090000 jle 0x14106f4d8
0106eb5b 453b482c cmp r9d, dword ptr [r8 + 0x2c]
0106eb5f 0f8f73090000 jg 0x14106f4d8
0106eb65 498b4010 mov rax, qword ptr [r8 + 0x10]
0106eb69 488b08 mov rcx, qword ptr [rax]
0106eb6c 498d41ff lea rax, [r9 - 1]
0106eb70 488d04c1 lea rax, [rcx + rax*8]
0106eb74 4885c0 test rax, rax
0106eb77 741d je 0x14106eb96
0106eb79 486310 movsxd rdx, dword ptr [rax]
0106eb7c 85d2 test edx, edx
0106eb7e 7816 js 0x14106eb96
0106eb80 8b4804 mov ecx, dword ptr [rax + 4]
0106eb83 85c9 test ecx, ecx
0106eb85 7e0f jle 0x14106eb96
0106eb87 498b4020 mov rax, qword ptr [r8 + 0x20]
0106eb8b 4c8bd2 mov r10, rdx
0106eb8e 448bd9 mov r11d, ecx
0106eb91 4c0310 add r10, qword ptr [rax]
0106eb94 eb05 jmp 0x14106eb9b
0106eb96 bbceffffff mov ebx, 0xffffffce
0106eb9b 85db test ebx, ebx
0106eb9d 0f85b5160000 jne 0x141070258
0106eba3 4585db test r11d, r11d
0106eba6 7433 je 0x14106ebdb
0106eba8 488d442448 lea rax, [rsp + 0x48]
0106ebad 458bc3 mov r8d, r11d
0106ebb0 4889442430 mov qword ptr [rsp + 0x30], rax
0106ebb5 498bd2 mov rdx, r10
0106ebb8 c744242801000000 mov dword ptr [rsp + 0x28], 1
0106ebc0 498bcf mov rcx, r15
0106ebc3 c744242003000000 mov dword ptr [rsp + 0x20], 3
0106ebcb e8b0c0ffff call 0x14106ac80
0106ebd0 8bd8 mov ebx, eax
0106ebd2 85c0 test eax, eax
0106ebd4 7505 jne 0x14106ebdb
0106ebd6 ff470c inc dword ptr [rdi + 0xc]
0106ebd9 eb08 jmp 0x14106ebe3
0106ebdb 85db test ebx, ebx
0106ebdd 0f8575160000 jne 0x141070258
0106ebe3 4d638ec0000000 movsxd r9, dword ptr [r14 + 0xc0]
0106ebea 4d8d8550020000 lea r8, [r13 + 0x250]
0106ebf1 33db xor ebx, ebx
0106ebf3 4585c9 test r9d, r9d
0106ebf6 0f84af000000 je 0x14106ecab
0106ebfc 4533db xor r11d, r11d
0106ebff 4533d2 xor r10d, r10d
0106ec02 4d85c0 test r8, r8
0106ec05 0f84cd080000 je 0x14106f4d8
0106ec0b 41813863727473 cmp dword ptr [r8], 0x73747263
0106ec12 0f85c0080000 jne 0x14106f4d8
0106ec18 4139583c cmp dword ptr [r8 + 0x3c], ebx
0106ec1c 0f84b6080000 je 0x14106f4d8
0106ec22 4585c9 test r9d, r9d
0106ec25 0f8ead080000 jle 0x14106f4d8
0106ec2b 453b482c cmp r9d, dword ptr [r8 + 0x2c]
0106ec2f 0f8fa3080000 jg 0x14106f4d8
0106ec35 498b4010 mov rax, qword ptr [r8 + 0x10]
0106ec39 488b08 mov rcx, qword ptr [rax]
0106ec3c 498d41ff lea rax, [r9 - 1]
0106ec40 488d04c1 lea rax, [rcx + rax*8]
0106ec44 4885c0 test rax, rax
0106ec47 741d je 0x14106ec66
0106ec49 486310 movsxd rdx, dword ptr [rax]
0106ec4c 85d2 test edx, edx
0106ec4e 7816 js 0x14106ec66
0106ec50 8b4804 mov ecx, dword ptr [rax + 4]
0106ec53 85c9 test ecx, ecx
0106ec55 7e0f jle 0x14106ec66
0106ec57 498b4020 mov rax, qword ptr [r8 + 0x20]
0106ec5b 4c8bd2 mov r10, rdx
0106ec5e 448bd9 mov r11d, ecx
0106ec61 4c0310 add r10, qword ptr [rax]
0106ec64 eb05 jmp 0x14106ec6b
0106ec66 bbceffffff mov ebx, 0xffffffce
0106ec6b 85db test ebx, ebx
0106ec6d 0f85e5150000 jne 0x141070258
0106ec73 4585db test r11d, r11d
0106ec76 7433 je 0x14106ecab
0106ec78 488d442448 lea rax, [rsp + 0x48]
0106ec7d 458bc3 mov r8d, r11d
0106ec80 4889442430 mov qword ptr [rsp + 0x30], rax
0106ec85 498bd2 mov rdx, r10
0106ec88 c744242801000000 mov dword ptr [rsp + 0x28], 1
0106ec90 498bcf mov rcx, r15
0106ec93 c74424200e000000 mov dword ptr [rsp + 0x20], 0xe
0106ec9b e8e0bfffff call 0x14106ac80
0106eca0 8bd8 mov ebx, eax
0106eca2 85c0 test eax, eax
0106eca4 7505 jne 0x14106ecab
0106eca6 ff470c inc dword ptr [rdi + 0xc]
0106eca9 eb08 jmp 0x14106ecb3
0106ecab 85db test ebx, ebx
0106ecad 0f85a5150000 jne 0x141070258
0106ecb3 4d638ec8000000 movsxd r9, dword ptr [r14 + 0xc8]
0106ecba 4d8d8528030000 lea r8, [r13 + 0x328]
0106ecc1 33db xor ebx, ebx
0106ecc3 4585c9 test r9d, r9d
0106ecc6 0f84af000000 je 0x14106ed7b
0106eccc 4533db xor r11d, r11d
0106eccf 4533d2 xor r10d, r10d
0106ecd2 4d85c0 test r8, r8
0106ecd5 0f84fd070000 je 0x14106f4d8
0106ecdb 41813863727473 cmp dword ptr [r8], 0x73747263
0106ece2 0f85f0070000 jne 0x14106f4d8
0106ece8 4139583c cmp dword ptr [r8 + 0x3c], ebx
0106ecec 0f84e6070000 je 0x14106f4d8
0106ecf2 4585c9 test r9d, r9d
0106ecf5 0f8edd070000 jle 0x14106f4d8
0106ecfb 453b482c cmp r9d, dword ptr [r8 + 0x2c]
0106ecff 0f8fd3070000 jg 0x14106f4d8
0106ed05 498b4010 mov rax, qword ptr [r8 + 0x10]
0106ed09 488b08 mov rcx, qword ptr [rax]
0106ed0c 498d41ff lea rax, [r9 - 1]
0106ed10 488d04c1 lea rax, [rcx + rax*8]
0106ed14 4885c0 test rax, rax
0106ed17 741d je 0x14106ed36
0106ed19 486310 movsxd rdx, dword ptr [rax]
0106ed1c 85d2 test edx, edx
0106ed1e 7816 js 0x14106ed36
0106ed20 8b4804 mov ecx, dword ptr [rax + 4]
0106ed23 85c9 test ecx, ecx
0106ed25 7e0f jle 0x14106ed36
0106ed27 498b4020 mov rax, qword ptr [r8 + 0x20]
0106ed2b 4c8bd2 mov r10, rdx
0106ed2e 448bd9 mov r11d, ecx
0106ed31 4c0310 add r10, qword ptr [rax]
0106ed34 eb05 jmp 0x14106ed3b
0106ed36 bbceffffff mov ebx, 0xffffffce
0106ed3b 85db test ebx, ebx
0106ed3d 0f8515150000 jne 0x141070258
0106ed43 4585db test r11d, r11d
0106ed46 7433 je 0x14106ed7b
0106ed48 488d442448 lea rax, [rsp + 0x48]
0106ed4d 458bc3 mov r8d, r11d
0106ed50 4889442430 mov qword ptr [rsp + 0x30], rax
0106ed55 498bd2 mov rdx, r10
0106ed58 c744242801000000 mov dword ptr [rsp + 0x28], 1
0106ed60 498bcf mov rcx, r15
0106ed63 c744242005000000 mov dword ptr [rsp + 0x20], 5
0106ed6b e810bfffff call 0x14106ac80
0106ed70 8bd8 mov ebx, eax
0106ed72 85c0 test eax, eax
0106ed74 7505 jne 0x14106ed7b
0106ed76 ff470c inc dword ptr [rdi + 0xc]
0106ed79 eb08 jmp 0x14106ed83
0106ed7b 85db test ebx, ebx
0106ed7d 0f85d5140000 jne 0x141070258
0106ed83 4d638ecc000000 movsxd r9, dword ptr [r14 + 0xcc]
0106ed8a 4d8d8570030000 lea r8, [r13 + 0x370]
0106ed91 33db xor ebx, ebx
0106ed93 4585c9 test r9d, r9d
0106ed96 0f84af000000 je 0x14106ee4b
0106ed9c 4533db xor r11d, r11d
0106ed9f 4533d2 xor r10d, r10d
0106eda2 4d85c0 test r8, r8
0106eda5 0f842d070000 je 0x14106f4d8
0106edab 41813863727473 cmp dword ptr [r8], 0x73747263
0106edb2 0f8520070000 jne 0x14106f4d8
0106edb8 4139583c cmp dword ptr [r8 + 0x3c], ebx
0106edbc 0f8416070000 je 0x14106f4d8
0106edc2 4585c9 test r9d, r9d
0106edc5 0f8e0d070000 jle 0x14106f4d8
0106edcb 453b482c cmp r9d, dword ptr [r8 + 0x2c]
0106edcf 0f8f03070000 jg 0x14106f4d8
0106edd5 498b4010 mov rax, qword ptr [r8 + 0x10]
0106edd9 488b08 mov rcx, qword ptr [rax]
0106eddc 498d41ff lea rax, [r9 - 1]
0106ede0 488d04c1 lea rax, [rcx + rax*8]
0106ede4 4885c0 test rax, rax
0106ede7 741d je 0x14106ee06
0106ede9 486310 movsxd rdx, dword ptr [rax]
0106edec 85d2 test edx, edx
0106edee 7816 js 0x14106ee06
0106edf0 8b4804 mov ecx, dword ptr [rax + 4]
0106edf3 85c9 test ecx, ecx
0106edf5 7e0f jle 0x14106ee06
0106edf7 498b4020 mov rax, qword ptr [r8 + 0x20]
0106edfb 4c8bd2 mov r10, rdx
0106edfe 448bd9 mov r11d, ecx
0106ee01 4c0310 add r10, qword ptr [rax]
0106ee04 eb05 jmp 0x14106ee0b
0106ee06 bbceffffff mov ebx, 0xffffffce
0106ee0b 85db test ebx, ebx
0106ee0d 0f8545140000 jne 0x141070258
0106ee13 4585db test r11d, r11d
0106ee16 7433 je 0x14106ee4b
0106ee18 488d442448 lea rax, [rsp + 0x48]
0106ee1d 458bc3 mov r8d, r11d
0106ee20 4889442430 mov qword ptr [rsp + 0x30], rax
0106ee25 498bd2 mov rdx, r10
0106ee28 c744242801000000 mov dword ptr [rsp + 0x28], 1
0106ee30 498bcf mov rcx, r15
0106ee33 c744242006000000 mov dword ptr [rsp + 0x20], 6
0106ee3b e840beffff call 0x14106ac80
0106ee40 8bd8 mov ebx, eax
0106ee42 85c0 test eax, eax
0106ee44 7505 jne 0x14106ee4b
0106ee46 ff470c inc dword ptr [rdi + 0xc]
0106ee49 eb08 jmp 0x14106ee53
0106ee4b 85db test ebx, ebx
0106ee4d 0f8505140000 jne 0x141070258
0106ee53 418b96d0000000 mov edx, dword ptr [r14 + 0xd0]
0106ee5a 33db xor ebx, ebx
0106ee5c 85d2 test edx, edx
0106ee5e 7470 je 0x14106eed0
0106ee60 498b8f7002e001 mov rcx, qword ptr [r15 + 0x1e00270]
0106ee67 4c8d45f0 lea r8, [rbp - 0x10]
0106ee6b 4881c1b8030000 add rcx, 0x3b8
0106ee72 e8f905b9ff call 0x140bff470
0106ee77 8bd8 mov ebx, eax
0106ee79 85c0 test eax, eax
0106ee7b 7553 jne 0x14106eed0
0106ee7d 663945f0 cmp word ptr [rbp - 0x10], ax
0106ee81 744d je 0x14106eed0
0106ee83 488d55f0 lea rdx, [rbp - 0x10]
0106ee87 488d4df0 lea rcx, [rbp - 0x10]
0106ee8b e8c0b0e3ff call 0x140ea9f50
0106ee90 440fb745f0 movzx r8d, word ptr [rbp - 0x10]
0106ee95 488d442448 lea rax, [rsp + 0x48]
0106ee9a 458b8ed0000000 mov r9d, dword ptr [r14 + 0xd0]
0106eea1 488d55f2 lea rdx, [rbp - 0xe]
0106eea5 4889442430 mov qword ptr [rsp + 0x30], rax
0106eeaa 4503c0 add r8d, r8d
0106eead c744242801000000 mov dword ptr [rsp + 0x28], 1
0106eeb5 498bcf mov rcx, r15
0106eeb8 c744242007000000 mov dword ptr [rsp + 0x20], 7
0106eec0 e8bbbdffff call 0x14106ac80
0106eec5 8bd8 mov ebx, eax
0106eec7 85c0 test eax, eax
0106eec9 7505 jne 0x14106eed0
0106eecb ff470c inc dword ptr [rdi + 0xc]
0106eece eb08 jmp 0x14106eed8
0106eed0 85db test ebx, ebx
0106eed2 0f8580130000 jne 0x141070258
0106eed8 4d638ed0000000 movsxd r9, dword ptr [r14 + 0xd0]
0106eedf 498d95b8030000 lea rdx, [r13 + 0x3b8]
0106eee6 33db xor ebx, ebx
0106eee8 4585c9 test r9d, r9d
0106eeeb 0f84af000000 je 0x14106efa0
0106eef1 4533db xor r11d, r11d
0106eef4 4533d2 xor r10d, r10d
0106eef7 4885d2 test rdx, rdx
0106eefa 0f84d8050000 je 0x14106f4d8
0106ef00 813a63727473 cmp dword ptr [rdx], 0x73747263
0106ef06 0f85cc050000 jne 0x14106f4d8
0106ef0c 395a3c cmp dword ptr [rdx + 0x3c], ebx
0106ef0f 0f84c3050000 je 0x14106f4d8
0106ef15 4585c9 test r9d, r9d
0106ef18 0f8eba050000 jle 0x14106f4d8
0106ef1e 443b4a2c cmp r9d, dword ptr [rdx + 0x2c]
0106ef22 0f8fb0050000 jg 0x14106f4d8
0106ef28 488b4210 mov rax, qword ptr [rdx + 0x10]
0106ef2c 4d8d41ff lea r8, [r9 - 1]
0106ef30 488b00 mov rax, qword ptr [rax]
0106ef33 4e8d04c0 lea r8, [rax + r8*8]
0106ef37 4d85c0 test r8, r8
0106ef3a 741f je 0x14106ef5b
0106ef3c 4d6320 movsxd r12, dword ptr [r8]
0106ef3f 4585e4 test r12d, r12d
0106ef42 7817 js 0x14106ef5b
0106ef44 418b4804 mov ecx, dword ptr [r8 + 4]
0106ef48 85c9 test ecx, ecx
0106ef4a 7e0f jle 0x14106ef5b
0106ef4c 488b4220 mov rax, qword ptr [rdx + 0x20]
0106ef50 4d8bd4 mov r10, r12
0106ef53 448bd9 mov r11d, ecx
0106ef56 4c0310 add r10, qword ptr [rax]
0106ef59 eb05 jmp 0x14106ef60
0106ef5b bbceffffff mov ebx, 0xffffffce
0106ef60 85db test ebx, ebx
0106ef62 0f85f0120000 jne 0x141070258
0106ef68 4585db test r11d, r11d
0106ef6b 7433 je 0x14106efa0
0106ef6d 488d442448 lea rax, [rsp + 0x48]
0106ef72 458bc3 mov r8d, r11d
0106ef75 4889442430 mov qword ptr [rsp + 0x30], rax
0106ef7a 498bd2 mov rdx, r10
0106ef7d c744242801000000 mov dword ptr [rsp + 0x28], 1
0106ef85 498bcf mov rcx, r15
0106ef88 c744242007000000 mov dword ptr [rsp + 0x20], 7
0106ef90 e8ebbcffff call 0x14106ac80
0106ef95 8bd8 mov ebx, eax
0106ef97 85c0 test eax, eax
0106ef99 7505 jne 0x14106efa0
0106ef9b ff470c inc dword ptr [rdi + 0xc]
0106ef9e eb08 jmp 0x14106efa8
0106efa0 85db test ebx, ebx
0106efa2 0f85b0120000 jne 0x141070258
0106efa8 4d638ed4000000 movsxd r9, dword ptr [r14 + 0xd4]
0106efaf 498d9500040000 lea rdx, [r13 + 0x400]
0106efb6 33db xor ebx, ebx
0106efb8 4585c9 test r9d, r9d
0106efbb 0f84af000000 je 0x14106f070
0106efc1 4533db xor r11d, r11d
0106efc4 4533d2 xor r10d, r10d
0106efc7 4885d2 test rdx, rdx
0106efca 0f8408050000 je 0x14106f4d8
0106efd0 813a63727473 cmp dword ptr [rdx], 0x73747263
0106efd6 0f85fc040000 jne 0x14106f4d8
0106efdc 395a3c cmp dword ptr [rdx + 0x3c], ebx
0106efdf 0f84f3040000 je 0x14106f4d8
0106efe5 4585c9 test r9d, r9d
0106efe8 0f8eea040000 jle 0x14106f4d8
0106efee 443b4a2c cmp r9d, dword ptr [rdx + 0x2c]
0106eff2 0f8fe0040000 jg 0x14106f4d8
0106eff8 488b4210 mov rax, qword ptr [rdx + 0x10]
0106effc 4d8d41ff lea r8, [r9 - 1]
0106f000 488b00 mov rax, qword ptr [rax]
0106f003 4e8d04c0 lea r8, [rax + r8*8]
0106f007 4d85c0 test r8, r8
0106f00a 741f je 0x14106f02b
0106f00c 4d6320 movsxd r12, dword ptr [r8]
0106f00f 4585e4 test r12d, r12d
0106f012 7817 js 0x14106f02b
0106f014 418b4804 mov ecx, dword ptr [r8 + 4]
0106f018 85c9 test ecx, ecx
0106f01a 7e0f jle 0x14106f02b
0106f01c 488b4220 mov rax, qword ptr [rdx + 0x20]
0106f020 4d8bd4 mov r10, r12
0106f023 448bd9 mov r11d, ecx
0106f026 4c0310 add r10, qword ptr [rax]
0106f029 eb05 jmp 0x14106f030
0106f02b bbceffffff mov ebx, 0xffffffce
0106f030 85db test ebx, ebx
0106f032 0f8520120000 jne 0x141070258
0106f038 4585db test r11d, r11d
0106f03b 7433 je 0x14106f070
0106f03d 488d442448 lea rax, [rsp + 0x48]
0106f042 458bc3 mov r8d, r11d
0106f045 4889442430 mov qword ptr [rsp + 0x30], rax
0106f04a 498bd2 mov rdx, r10
0106f04d c744242801000000 mov dword ptr [rsp + 0x28], 1
0106f055 498bcf mov rcx, r15
0106f058 c744242008000000 mov dword ptr [rsp + 0x20], 8
0106f060 e81bbcffff call 0x14106ac80
0106f065 8bd8 mov ebx, eax
0106f067 85c0 test eax, eax
0106f069 7505 jne 0x14106f070
0106f06b ff470c inc dword ptr [rdi + 0xc]
0106f06e eb08 jmp 0x14106f078
0106f070 85db test ebx, ebx
0106f072 0f85e0110000 jne 0x141070258
0106f078 4d638ed8000000 movsxd r9, dword ptr [r14 + 0xd8]
0106f07f 498d9548040000 lea rdx, [r13 + 0x448]
0106f086 33db xor ebx, ebx
0106f088 4585c9 test r9d, r9d
0106f08b 0f84af000000 je 0x14106f140
0106f091 4533db xor r11d, r11d
0106f094 4533d2 xor r10d, r10d
0106f097 4885d2 test rdx, rdx
0106f09a 0f8438040000 je 0x14106f4d8
0106f0a0 813a63727473 cmp dword ptr [rdx], 0x73747263
0106f0a6 0f852c040000 jne 0x14106f4d8
0106f0ac 395a3c cmp dword ptr [rdx + 0x3c], ebx
0106f0af 0f8423040000 je 0x14106f4d8
0106f0b5 4585c9 test r9d, r9d
0106f0b8 0f8e1a040000 jle 0x14106f4d8
0106f0be 443b4a2c cmp r9d, dword ptr [rdx + 0x2c]
0106f0c2 0f8f10040000 jg 0x14106f4d8
0106f0c8 488b4210 mov rax, qword ptr [rdx + 0x10]
0106f0cc 4d8d41ff lea r8, [r9 - 1]
0106f0d0 488b00 mov rax, qword ptr [rax]
0106f0d3 4e8d04c0 lea r8, [rax + r8*8]
0106f0d7 4d85c0 test r8, r8
0106f0da 741f je 0x14106f0fb
0106f0dc 4d6320 movsxd r12, dword ptr [r8]
0106f0df 4585e4 test r12d, r12d
0106f0e2 7817 js 0x14106f0fb
0106f0e4 418b4804 mov ecx, dword ptr [r8 + 4]
0106f0e8 85c9 test ecx, ecx
0106f0ea 7e0f jle 0x14106f0fb
0106f0ec 488b4220 mov rax, qword ptr [rdx + 0x20]
0106f0f0 4d8bd4 mov r10, r12
0106f0f3 448bd9 mov r11d, ecx
0106f0f6 4c0310 add r10, qword ptr [rax]
0106f0f9 eb05 jmp 0x14106f100
0106f0fb bbceffffff mov ebx, 0xffffffce
0106f100 85db test ebx, ebx
0106f102 0f8550110000 jne 0x141070258
0106f108 4585db test r11d, r11d
0106f10b 7433 je 0x14106f140
0106f10d 488d442448 lea rax, [rsp + 0x48]
0106f112 458bc3 mov r8d, r11d
0106f115 4889442430 mov qword ptr [rsp + 0x30], rax
0106f11a 498bd2 mov rdx, r10
0106f11d c744242801000000 mov dword ptr [rsp + 0x28], 1
0106f125 498bcf mov rcx, r15
0106f128 c744242009000000 mov dword ptr [rsp + 0x20], 9
0106f130 e84bbbffff call 0x14106ac80
0106f135 8bd8 mov ebx, eax
0106f137 85c0 test eax, eax
0106f139 7505 jne 0x14106f140
0106f13b ff470c inc dword ptr [rdi + 0xc]
0106f13e eb08 jmp 0x14106f148
0106f140 85db test ebx, ebx
0106f142 0f8510110000 jne 0x141070258
0106f148 4d638edc000000 movsxd r9, dword ptr [r14 + 0xdc]
0106f14f 498d9590040000 lea rdx, [r13 + 0x490]
0106f156 33db xor ebx, ebx
0106f158 4585c9 test r9d, r9d
0106f15b 0f84af000000 je 0x14106f210
0106f161 4533db xor r11d, r11d
0106f164 4533d2 xor r10d, r10d
0106f167 4885d2 test rdx, rdx
0106f16a 0f8468030000 je 0x14106f4d8
0106f170 813a63727473 cmp dword ptr [rdx], 0x73747263
0106f176 0f855c030000 jne 0x14106f4d8
0106f17c 395a3c cmp dword ptr [rdx + 0x3c], ebx
0106f17f 0f8453030000 je 0x14106f4d8
0106f185 4585c9 test r9d, r9d
0106f188 0f8e4a030000 jle 0x14106f4d8
0106f18e 443b4a2c cmp r9d, dword ptr [rdx + 0x2c]
0106f192 0f8f40030000 jg 0x14106f4d8
0106f198 488b4210 mov rax, qword ptr [rdx + 0x10]
0106f19c 4d8d41ff lea r8, [r9 - 1]
0106f1a0 488b00 mov rax, qword ptr [rax]
0106f1a3 4e8d04c0 lea r8, [rax + r8*8]
0106f1a7 4d85c0 test r8, r8
0106f1aa 741f je 0x14106f1cb
0106f1ac 4d6320 movsxd r12, dword ptr [r8]
0106f1af 4585e4 test r12d, r12d
0106f1b2 7817 js 0x14106f1cb
0106f1b4 418b4804 mov ecx, dword ptr [r8 + 4]
0106f1b8 85c9 test ecx, ecx
0106f1ba 7e0f jle 0x14106f1cb
0106f1bc 488b4220 mov rax, qword ptr [rdx + 0x20]
0106f1c0 4d8bd4 mov r10, r12
0106f1c3 448bd9 mov r11d, ecx
0106f1c6 4c0310 add r10, qword ptr [rax]
0106f1c9 eb05 jmp 0x14106f1d0
0106f1cb bbceffffff mov ebx, 0xffffffce
0106f1d0 85db test ebx, ebx
0106f1d2 0f8580100000 jne 0x141070258
0106f1d8 4585db test r11d, r11d
0106f1db 7433 je 0x14106f210
0106f1dd 488d442448 lea rax, [rsp + 0x48]
0106f1e2 458bc3 mov r8d, r11d
0106f1e5 4889442430 mov qword ptr [rsp + 0x30], rax
0106f1ea 498bd2 mov rdx, r10
0106f1ed c744242801000000 mov dword ptr [rsp + 0x28], 1
0106f1f5 498bcf mov rcx, r15
0106f1f8 c74424200a000000 mov dword ptr [rsp + 0x20], 0xa
0106f200 e87bbaffff call 0x14106ac80
0106f205 8bd8 mov ebx, eax
0106f207 85c0 test eax, eax
0106f209 7505 jne 0x14106f210
0106f20b ff470c inc dword ptr [rdi + 0xc]
0106f20e eb08 jmp 0x14106f218
0106f210 85db test ebx, ebx
0106f212 0f8540100000 jne 0x141070258
0106f218 4533e4 xor r12d, r12d
0106f21b 0f1f440000 nop dword ptr [rax + rax]
0106f220 0f57c0 xorps xmm0, xmm0
0106f223 4c8d442460 lea r8, [rsp + 0x60]
0106f228 0f57c9 xorps xmm1, xmm1
0106f22b 660f7f45b0 movdqa xmmword ptr [rbp - 0x50], xmm0
0106f230 418bd4 mov edx, r12d
0106f233 660f7f4dc0 movdqa xmmword ptr [rbp - 0x40], xmm1
0106f238 498bce mov rcx, r14
0106f23b 660f7f45d0 movdqa xmmword ptr [rbp - 0x30], xmm0
0106f240 e8eb8ee4ff call 0x140eb8130
0106f245 837c246c00 cmp dword ptr [rsp + 0x6c], 0
0106f24a 0f84df000000 je 0x14106f32f
0106f250 4f638ca660010000 movsxd r9, dword ptr [r14 + r12*4 + 0x160]
0106f258 33db xor ebx, ebx
0106f25a 4585c9 test r9d, r9d
0106f25d 0f84b3000000 je 0x14106f316
0106f263 4c8b45a0 mov r8, qword ptr [rbp - 0x60]
0106f267 4533db xor r11d, r11d
0106f26a 4533d2 xor r10d, r10d
0106f26d 4d85c0 test r8, r8
0106f270 0f8462020000 je 0x14106f4d8
0106f276 41813863727473 cmp dword ptr [r8], 0x73747263
0106f27d 0f8555020000 jne 0x14106f4d8
0106f283 4139583c cmp dword ptr [r8 + 0x3c], ebx
0106f287 0f844b020000 je 0x14106f4d8
0106f28d 4585c9 test r9d, r9d
0106f290 0f8e42020000 jle 0x14106f4d8
0106f296 453b482c cmp r9d, dword ptr [r8 + 0x2c]
0106f29a 0f8f38020000 jg 0x14106f4d8
0106f2a0 498b4010 mov rax, qword ptr [r8 + 0x10]
0106f2a4 488b00 mov rax, qword ptr [rax]
0106f2a7 4883c0f8 add rax, -8
0106f2ab 4a8d04c8 lea rax, [rax + r9*8]
0106f2af 4885c0 test rax, rax
0106f2b2 741d je 0x14106f2d1
0106f2b4 486310 movsxd rdx, dword ptr [rax]
0106f2b7 85d2 test edx, edx
0106f2b9 7816 js 0x14106f2d1
0106f2bb 8b4804 mov ecx, dword ptr [rax + 4]
0106f2be 85c9 test ecx, ecx
0106f2c0 7e0f jle 0x14106f2d1
0106f2c2 498b4020 mov rax, qword ptr [r8 + 0x20]
0106f2c6 4c8bd2 mov r10, rdx
0106f2c9 448bd9 mov r11d, ecx
0106f2cc 4c0310 add r10, qword ptr [rax]
0106f2cf eb05 jmp 0x14106f2d6
0106f2d1 bbceffffff mov ebx, 0xffffffce
0106f2d6 85db test ebx, ebx
0106f2d8 0f857a0f0000 jne 0x141070258
0106f2de 4585db test r11d, r11d
0106f2e1 7433 je 0x14106f316
0106f2e3 488d442448 lea rax, [rsp + 0x48]
0106f2e8 458bc3 mov r8d, r11d
0106f2eb 4889442430 mov qword ptr [rsp + 0x30], rax
0106f2f0 498bd2 mov rdx, r10
0106f2f3 8b44246c mov eax, dword ptr [rsp + 0x6c]
0106f2f7 498bcf mov rcx, r15
0106f2fa c744242801000000 mov dword ptr [rsp + 0x28], 1
0106f302 89442420 mov dword ptr [rsp + 0x20], eax
0106f306 e875b9ffff call 0x14106ac80
0106f30b 8bd8 mov ebx, eax
0106f30d 85c0 test eax, eax
0106f30f 7505 jne 0x14106f316
0106f311 ff470c inc dword ptr [rdi + 0xc]
0106f314 eb08 jmp 0x14106f31e
0106f316 85db test ebx, ebx
0106f318 0f853a0f0000 jne 0x141070258
0106f31e 430fb6843492000000 movzx eax, byte ptr [r12 + r14 + 0x92]
0106f327 4188843c4c010000 mov byte ptr [r12 + rdi + 0x14c], al
0106f32f 41ffc4 inc r12d
0106f332 4183fc06 cmp r12d, 6
0106f336 0f82e4feffff jb 0x14106f220
0106f33c 4d8b4e68 mov r9, qword ptr [r14 + 0x68]
0106f340 41f60101 test byte ptr [r9], 1
0106f344 0f84fc040000 je 0x14106f846
0106f34a 4d634918 movsxd r9, dword ptr [r9 + 0x18]
0106f34e 498d9598020000 lea rdx, [r13 + 0x298]
0106f355 33db xor ebx, ebx
0106f357 4585c9 test r9d, r9d
0106f35a 0f84af000000 je 0x14106f40f
0106f360 4533db xor r11d, r11d
0106f363 4533d2 xor r10d, r10d
0106f366 4885d2 test rdx, rdx
0106f369 0f8469010000 je 0x14106f4d8
0106f36f 813a63727473 cmp dword ptr [rdx], 0x73747263
0106f375 0f855d010000 jne 0x14106f4d8
0106f37b 395a3c cmp dword ptr [rdx + 0x3c], ebx
0106f37e 0f8454010000 je 0x14106f4d8
0106f384 4585c9 test r9d, r9d
0106f387 0f8e4b010000 jle 0x14106f4d8
0106f38d 443b4a2c cmp r9d, dword ptr [rdx + 0x2c]
0106f391 0f8f41010000 jg 0x14106f4d8
0106f397 488b4210 mov rax, qword ptr [rdx + 0x10]
0106f39b 4d8d41ff lea r8, [r9 - 1]
0106f39f 488b00 mov rax, qword ptr [rax]
0106f3a2 4e8d04c0 lea r8, [rax + r8*8]
0106f3a6 4d85c0 test r8, r8
0106f3a9 741f je 0x14106f3ca
0106f3ab 4d6320 movsxd r12, dword ptr [r8]
0106f3ae 4585e4 test r12d, r12d
0106f3b1 7817 js 0x14106f3ca
0106f3b3 418b4804 mov ecx, dword ptr [r8 + 4]
0106f3b7 85c9 test ecx, ecx
0106f3b9 7e0f jle 0x14106f3ca
0106f3bb 488b4220 mov rax, qword ptr [rdx + 0x20]
0106f3bf 4d8bd4 mov r10, r12
0106f3c2 448bd9 mov r11d, ecx
0106f3c5 4c0310 add r10, qword ptr [rax]
0106f3c8 eb05 jmp 0x14106f3cf
0106f3ca bbceffffff mov ebx, 0xffffffce
0106f3cf 85db test ebx, ebx
0106f3d1 0f85810e0000 jne 0x141070258
0106f3d7 4585db test r11d, r11d
0106f3da 7433 je 0x14106f40f
0106f3dc 488d442448 lea rax, [rsp + 0x48]
0106f3e1 458bc3 mov r8d, r11d
0106f3e4 4889442430 mov qword ptr [rsp + 0x30], rax
0106f3e9 498bd2 mov rdx, r10
0106f3ec c744242801000000 mov dword ptr [rsp + 0x28], 1
0106f3f4 498bcf mov rcx, r15
0106f3f7 c74424203f000000 mov dword ptr [rsp + 0x20], 0x3f
0106f3ff e87cb8ffff call 0x14106ac80
0106f404 8bd8 mov ebx, eax
0106f406 85c0 test eax, eax
0106f408 7505 jne 0x14106f40f
0106f40a ff470c inc dword ptr [rdi + 0xc]
0106f40d eb08 jmp 0x14106f417
0106f40f 85db test ebx, ebx
0106f411 0f85410e0000 jne 0x141070258
0106f417 498b4668 mov rax, qword ptr [r14 + 0x68]
0106f41b 498d95e0020000 lea rdx, [r13 + 0x2e0]
0106f422 33db xor ebx, ebx
0106f424 4c63481c movsxd r9, dword ptr [rax + 0x1c]
0106f428 4585c9 test r9d, r9d
0106f42b 0f84b1000000 je 0x14106f4e2
0106f431 4533db xor r11d, r11d
0106f434 4533d2 xor r10d, r10d
0106f437 4885d2 test rdx, rdx
0106f43a 0f8498000000 je 0x14106f4d8
0106f440 813a63727473 cmp dword ptr [rdx], 0x73747263
0106f446 0f858c000000 jne 0x14106f4d8
0106f44c 395a3c cmp dword ptr [rdx + 0x3c], ebx
0106f44f 0f8483000000 je 0x14106f4d8
0106f455 4585c9 test r9d, r9d
0106f458 7e7e jle 0x14106f4d8
0106f45a 443b4a2c cmp r9d, dword ptr [rdx + 0x2c]
0106f45e 7f78 jg 0x14106f4d8
0106f460 488b4210 mov rax, qword ptr [rdx + 0x10]
0106f464 4d8d41ff lea r8, [r9 - 1]
0106f468 488b00 mov rax, qword ptr [rax]
0106f46b 4e8d04c0 lea r8, [rax + r8*8]
0106f46f 4d85c0 test r8, r8
0106f472 741f je 0x14106f493
0106f474 4d6320 movsxd r12, dword ptr [r8]
0106f477 4585e4 test r12d, r12d
0106f47a 7817 js 0x14106f493
0106f47c 418b4804 mov ecx, dword ptr [r8 + 4]
0106f480 85c9 test ecx, ecx
0106f482 7e0f jle 0x14106f493
0106f484 488b4220 mov rax, qword ptr [rdx + 0x20]
0106f488 4d8bd4 mov r10, r12
0106f48b 448bd9 mov r11d, ecx
0106f48e 4c0310 add r10, qword ptr [rax]
0106f491 eb05 jmp 0x14106f498
0106f493 bbceffffff mov ebx, 0xffffffce
0106f498 85db test ebx, ebx
0106f49a 0f85b80d0000 jne 0x141070258
0106f4a0 4585db test r11d, r11d
0106f4a3 743d je 0x14106f4e2
0106f4a5 488d442448 lea rax, [rsp + 0x48]
0106f4aa 458bc3 mov r8d, r11d
0106f4ad 4889442430 mov qword ptr [rsp + 0x30], rax
0106f4b2 498bd2 mov rdx, r10
0106f4b5 c744242801000000 mov dword ptr [rsp + 0x28], 1
0106f4bd 498bcf mov rcx, r15
0106f4c0 c744242040000000 mov dword ptr [rsp + 0x20], 0x40
0106f4c8 e8b3b7ffff call 0x14106ac80
0106f4cd 8bd8 mov ebx, eax
0106f4cf 85c0 test eax, eax
0106f4d1 750f jne 0x14106f4e2
0106f4d3 ff470c inc dword ptr [rdi + 0xc]
0106f4d6 eb12 jmp 0x14106f4ea
0106f4d8 bbceffffff mov ebx, 0xffffffce
0106f4dd e9760d0000 jmp 0x141070258
0106f4e2 85db test ebx, ebx
0106f4e4 0f856e0d0000 jne 0x141070258
0106f4ea 4d8b4668 mov r8, qword ptr [r14 + 0x68]
0106f4ee 488d442440 lea rax, [rsp + 0x40]
0106f4f3 4889442430 mov qword ptr [rsp + 0x30], rax
0106f4f8 498d9520050000 lea rdx, [r13 + 0x520]
0106f4ff 488d442448 lea rax, [rsp + 0x48]
0106f504 41b912000000 mov r9d, 0x12
0106f50a 4889442428 mov qword ptr [rsp + 0x28], rax
0106f50f 498bcf mov rcx, r15
0106f512 458b4034 mov r8d, dword ptr [r8 + 0x34]
0106f516 c744242001000000 mov dword ptr [rsp + 0x20], 1
0106f51e e80dbbffff call 0x14106b030
0106f523 8bd8 mov ebx, eax
0106f525 85c0 test eax, eax
0106f527 0f852b0d0000 jne 0x141070258
0106f52d 38442440 cmp byte ptr [rsp + 0x40], al
0106f531 7405 je 0x14106f538
0106f533 ff470c inc dword ptr [rdi + 0xc]
0106f536 eb08 jmp 0x14106f540
0106f538 85c0 test eax, eax
0106f53a 0f85180d0000 jne 0x141070258
0106f540 4d8b4668 mov r8, qword ptr [r14 + 0x68]
0106f544 488d442440 lea rax, [rsp + 0x40]
0106f549 4889442430 mov qword ptr [rsp + 0x30], rax
0106f54e 498d9520050000 lea rdx, [r13 + 0x520]
0106f555 488d442448 lea rax, [rsp + 0x48]
0106f55a 41b916000000 mov r9d, 0x16
0106f560 4889442428 mov qword ptr [rsp + 0x28], rax
0106f565 498bcf mov rcx, r15
0106f568 458b4038 mov r8d, dword ptr [r8 + 0x38]
0106f56c c744242001000000 mov dword ptr [rsp + 0x20], 1
0106f574 e8b7baffff call 0x14106b030
0106f579 8bd8 mov ebx, eax
0106f57b 85c0 test eax, eax
0106f57d 0f85d50c0000 jne 0x141070258
0106f583 38442440 cmp byte ptr [rsp + 0x40], al
0106f587 7405 je 0x14106f58e
0106f589 ff470c inc dword ptr [rdi + 0xc]
0106f58c eb08 jmp 0x14106f596
0106f58e 85c0 test eax, eax
0106f590 0f85c20c0000 jne 0x141070258
0106f596 4d8b4668 mov r8, qword ptr [r14 + 0x68]
0106f59a 488d442440 lea rax, [rsp + 0x40]
0106f59f 4889442430 mov qword ptr [rsp + 0x30], rax
0106f5a4 498d9520050000 lea rdx, [r13 + 0x520]
0106f5ab 488d442448 lea rax, [rsp + 0x48]
0106f5b0 41b933000000 mov r9d, 0x33
0106f5b6 4889442428 mov qword ptr [rsp + 0x28], rax
0106f5bb 498bcf mov rcx, r15
0106f5be 458b403c mov r8d, dword ptr [r8 + 0x3c]
0106f5c2 c744242001000000 mov dword ptr [rsp + 0x20], 1
0106f5ca e861baffff call 0x14106b030
0106f5cf 8bd8 mov ebx, eax
0106f5d1 85c0 test eax, eax
0106f5d3 0f857f0c0000 jne 0x141070258
0106f5d9 38442440 cmp byte ptr [rsp + 0x40], al
0106f5dd 7405 je 0x14106f5e4
0106f5df ff470c inc dword ptr [rdi + 0xc]
0106f5e2 eb08 jmp 0x14106f5ec
0106f5e4 85c0 test eax, eax
0106f5e6 0f856c0c0000 jne 0x141070258
0106f5ec 4d8b4668 mov r8, qword ptr [r14 + 0x68]
0106f5f0 488d442440 lea rax, [rsp + 0x40]
0106f5f5 4889442430 mov qword ptr [rsp + 0x30], rax
0106f5fa 498d9580080000 lea rdx, [r13 + 0x880]
0106f601 488d442448 lea rax, [rsp + 0x48]
0106f606 41b92e000000 mov r9d, 0x2e
0106f60c 4889442428 mov qword ptr [rsp + 0x28], rax
0106f611 498bcf mov rcx, r15
0106f614 458b4040 mov r8d, dword ptr [r8 + 0x40]
0106f618 c744242001000000 mov dword ptr [rsp + 0x20], 1
0106f620 e80bbaffff call 0x14106b030
0106f625 8bd8 mov ebx, eax
0106f627 85c0 test eax, eax
0106f629 0f85290c0000 jne 0x141070258
0106f62f 38442440 cmp byte ptr [rsp + 0x40], al
0106f633 7405 je 0x14106f63a
0106f635 ff470c inc dword ptr [rdi + 0xc]
0106f638 eb08 jmp 0x14106f642
0106f63a 85c0 test eax, eax
0106f63c 0f85160c0000 jne 0x141070258
0106f642 4d8b4668 mov r8, qword ptr [r14 + 0x68]
0106f646 488d442440 lea rax, [rsp + 0x40]
0106f64b 4889442430 mov qword ptr [rsp + 0x30], rax
0106f650 498d9568050000 lea rdx, [r13 + 0x568]
0106f657 488d442448 lea rax, [rsp + 0x48]
0106f65c 41b913000000 mov r9d, 0x13
0106f662 4889442428 mov qword ptr [rsp + 0x28], rax
0106f667 498bcf mov rcx, r15
0106f66a 458b4020 mov r8d, dword ptr [r8 + 0x20]
0106f66e c744242000000000 mov dword ptr [rsp + 0x20], 0
0106f676 e8b5b9ffff call 0x14106b030
0106f67b 8bd8 mov ebx, eax
0106f67d 85c0 test eax, eax
0106f67f 0f85d30b0000 jne 0x141070258
0106f685 38442440 cmp byte ptr [rsp + 0x40], al
0106f689 7405 je 0x14106f690
0106f68b ff470c inc dword ptr [rdi + 0xc]
0106f68e eb08 jmp 0x14106f698
0106f690 85c0 test eax, eax
0106f692 0f85c00b0000 jne 0x141070258
0106f698 4d8b4668 mov r8, qword ptr [r14 + 0x68]
0106f69c 488d442440 lea rax, [rsp + 0x40]
0106f6a1 4889442430 mov qword ptr [rsp + 0x30], rax
0106f6a6 498d95b0050000 lea rdx, [r13 + 0x5b0]
0106f6ad 488d442448 lea rax, [rsp + 0x48]
0106f6b2 41b925000000 mov r9d, 0x25
0106f6b8 4889442428 mov qword ptr [rsp + 0x28], rax
0106f6bd 498bcf mov rcx, r15
0106f6c0 458b4024 mov r8d, dword ptr [r8 + 0x24]
0106f6c4 c744242000000000 mov dword ptr [rsp + 0x20], 0
0106f6cc e85fb9ffff call 0x14106b030
0106f6d1 8bd8 mov ebx, eax
0106f6d3 85c0 test eax, eax
0106f6d5 0f857d0b0000 jne 0x141070258
0106f6db 38442440 cmp byte ptr [rsp + 0x40], al
0106f6df 7405 je 0x14106f6e6
0106f6e1 ff470c inc dword ptr [rdi + 0xc]
0106f6e4 eb08 jmp 0x14106f6ee
0106f6e6 85c0 test eax, eax
0106f6e8 0f856a0b0000 jne 0x141070258
0106f6ee 4d8b4668 mov r8, qword ptr [r14 + 0x68]
0106f6f2 488d442440 lea rax, [rsp + 0x40]
0106f6f7 4889442430 mov qword ptr [rsp + 0x30], rax
0106f6fc 498d95b0050000 lea rdx, [r13 + 0x5b0]
0106f703 488d442448 lea rax, [rsp + 0x48]
0106f708 41b93a000000 mov r9d, 0x3a
0106f70e 4889442428 mov qword ptr [rsp + 0x28], rax
0106f713 498bcf mov rcx, r15
0106f716 458b4028 mov r8d, dword ptr [r8 + 0x28]
0106f71a c744242000000000 mov dword ptr [rsp + 0x20], 0
0106f722 e809b9ffff call 0x14106b030
0106f727 8bd8 mov ebx, eax
0106f729 85c0 test eax, eax
0106f72b 0f85270b0000 jne 0x141070258
0106f731 38442440 cmp byte ptr [rsp + 0x40], al
0106f735 7405 je 0x14106f73c
0106f737 ff470c inc dword ptr [rdi + 0xc]
0106f73a eb08 jmp 0x14106f744
0106f73c 85c0 test eax, eax
0106f73e 0f85140b0000 jne 0x141070258
0106f744 4d8b4668 mov r8, qword ptr [r14 + 0x68]
0106f748 488d442440 lea rax, [rsp + 0x40]
0106f74d 4889442430 mov qword ptr [rsp + 0x30], rax
0106f752 498d95f8050000 lea rdx, [r13 + 0x5f8]
0106f759 488d442448 lea rax, [rsp + 0x48]
0106f75e 4533e4 xor r12d, r12d
0106f761 4889442428 mov qword ptr [rsp + 0x28], rax
0106f766 41b939000000 mov r9d, 0x39
0106f76c 458b402c mov r8d, dword ptr [r8 + 0x2c]
0106f770 498bcf mov rcx, r15
0106f773 4489642420 mov dword ptr [rsp + 0x20], r12d
0106f778 e8b3b8ffff call 0x14106b030
0106f77d 8bd8 mov ebx, eax
0106f77f 85c0 test eax, eax
0106f781 0f85d10a0000 jne 0x141070258
0106f787 4438642440 cmp byte ptr [rsp + 0x40], r12b
0106f78c 7405 je 0x14106f793
0106f78e ff470c inc dword ptr [rdi + 0xc]
0106f791 eb08 jmp 0x14106f79b
0106f793 85c0 test eax, eax
0106f795 0f85bd0a0000 jne 0x141070258
0106f79b 4d8b4668 mov r8, qword ptr [r14 + 0x68]
0106f79f 488d442440 lea rax, [rsp + 0x40]
0106f7a4 4889442430 mov qword ptr [rsp + 0x30], rax
0106f7a9 498d9518070000 lea rdx, [r13 + 0x718]
0106f7b0 488d442448 lea rax, [rsp + 0x48]
0106f7b5 41b91c000000 mov r9d, 0x1c
0106f7bb 4889442428 mov qword ptr [rsp + 0x28], rax
0106f7c0 498bcf mov rcx, r15
0106f7c3 458b4030 mov r8d, dword ptr [r8 + 0x30]
0106f7c7 c744242001000000 mov dword ptr [rsp + 0x20], 1
0106f7cf e85cb8ffff call 0x14106b030
0106f7d4 8bd8 mov ebx, eax
0106f7d6 85c0 test eax, eax
0106f7d8 0f857a0a0000 jne 0x141070258
0106f7de 4438642440 cmp byte ptr [rsp + 0x40], r12b
0106f7e3 7405 je 0x14106f7ea
0106f7e5 ff470c inc dword ptr [rdi + 0xc]
0106f7e8 eb08 jmp 0x14106f7f2
0106f7ea 85c0 test eax, eax
0106f7ec 0f85660a0000 jne 0x141070258
0106f7f2 4d8b4668 mov r8, qword ptr [r14 + 0x68]
0106f7f6 488d442440 lea rax, [rsp + 0x40]
0106f7fb 4889442430 mov qword ptr [rsp + 0x30], rax
0106f800 498d9588180000 lea rdx, [r13 + 0x1888]
0106f807 488d442448 lea rax, [rsp + 0x48]
0106f80c 41b92a000000 mov r9d, 0x2a
0106f812 4889442428 mov qword ptr [rsp + 0x28], rax
0106f817 498bcf mov rcx, r15
0106f81a 458b404c mov r8d, dword ptr [r8 + 0x4c]
0106f81e 4489642420 mov dword ptr [rsp + 0x20], r12d
0106f823 e808b8ffff call 0x14106b030
0106f828 8bd8 mov ebx, eax
0106f82a 85c0 test eax, eax
0106f82c 0f85260a0000 jne 0x141070258
0106f832 4438642440 cmp byte ptr [rsp + 0x40], r12b
0106f837 7405 je 0x14106f83e
0106f839 ff470c inc dword ptr [rdi + 0xc]
0106f83c eb08 jmp 0x14106f846
0106f83e 85c0 test eax, eax
0106f840 0f85120a0000 jne 0x141070258
0106f846 4c8b4610 mov r8, qword ptr [rsi + 0x10]
0106f84a 41f60001 test byte ptr [r8], 1
0106f84e 0f845e030000 je 0x14106fbb2
0106f854 458b4068 mov r8d, dword ptr [r8 + 0x68]
0106f858 488d442440 lea rax, [rsp + 0x40]
0106f85d 4889442430 mov qword ptr [rsp + 0x30], rax
0106f862 498d95a8070000 lea rdx, [r13 + 0x7a8]
0106f869 488d442448 lea rax, [rsp + 0x48]
0106f86e 41b92b000000 mov r9d, 0x2b
0106f874 4889442428 mov qword ptr [rsp + 0x28], rax
0106f879 498bcf mov rcx, r15
0106f87c c744242001000000 mov dword ptr [rsp + 0x20], 1
0106f884 e8a7b7ffff call 0x14106b030
0106f889 8bd8 mov ebx, eax
0106f88b 85c0 test eax, eax
0106f88d 0f85c5090000 jne 0x141070258
0106f893 38442440 cmp byte ptr [rsp + 0x40], al
0106f897 7405 je 0x14106f89e
0106f899 ff470c inc dword ptr [rdi + 0xc]
0106f89c eb08 jmp 0x14106f8a6
0106f89e 85c0 test eax, eax
0106f8a0 0f85b2090000 jne 0x141070258
0106f8a6 4c8b4610 mov r8, qword ptr [rsi + 0x10]
0106f8aa 488d442440 lea rax, [rsp + 0x40]
0106f8af 4889442430 mov qword ptr [rsp + 0x30], rax
0106f8b4 498d95f0070000 lea rdx, [r13 + 0x7f0]
0106f8bb 488d442448 lea rax, [rsp + 0x48]
0106f8c0 41b92d000000 mov r9d, 0x2d
0106f8c6 4889442428 mov qword ptr [rsp + 0x28], rax
0106f8cb 498bcf mov rcx, r15
0106f8ce 458b406c mov r8d, dword ptr [r8 + 0x6c]
0106f8d2 c744242002000000 mov dword ptr [rsp + 0x20], 2
0106f8da e851b7ffff call 0x14106b030
0106f8df 8bd8 mov ebx, eax
0106f8e1 85c0 test eax, eax
0106f8e3 0f856f090000 jne 0x141070258
0106f8e9 38442440 cmp byte ptr [rsp + 0x40], al
0106f8ed 7405 je 0x14106f8f4
0106f8ef ff470c inc dword ptr [rdi + 0xc]
0106f8f2 eb08 jmp 0x14106f8fc
0106f8f4 85c0 test eax, eax
0106f8f6 0f855c090000 jne 0x141070258
0106f8fc 4c8b4610 mov r8, qword ptr [rsi + 0x10]
0106f900 488d442440 lea rax, [rsp + 0x40]
0106f905 4889442430 mov qword ptr [rsp + 0x30], rax
0106f90a 498d9538080000 lea rdx, [r13 + 0x838]
0106f911 488d442448 lea rax, [rsp + 0x48]
0106f916 41b934000000 mov r9d, 0x34
0106f91c 4889442428 mov qword ptr [rsp + 0x28], rax
0106f921 498bcf mov rcx, r15
0106f924 458b4070 mov r8d, dword ptr [r8 + 0x70]
0106f928 c744242001000000 mov dword ptr [rsp + 0x20], 1
0106f930 e8fbb6ffff call 0x14106b030
0106f935 8bd8 mov ebx, eax
0106f937 85c0 test eax, eax
0106f939 0f8519090000 jne 0x141070258
0106f93f 38442440 cmp byte ptr [rsp + 0x40], al
0106f943 7405 je 0x14106f94a
0106f945 ff470c inc dword ptr [rdi + 0xc]
0106f948 eb08 jmp 0x14106f952
0106f94a 85c0 test eax, eax
0106f94c 0f8506090000 jne 0x141070258
0106f952 4c8b4610 mov r8, qword ptr [rsi + 0x10]
0106f956 488d442440 lea rax, [rsp + 0x40]
0106f95b 4889442430 mov qword ptr [rsp + 0x30], rax
0106f960 498d95c8080000 lea rdx, [r13 + 0x8c8]
0106f967 488d442448 lea rax, [rsp + 0x48]
0106f96c 41b93b000000 mov r9d, 0x3b
0106f972 4889442428 mov qword ptr [rsp + 0x28], rax
0106f977 498bcf mov rcx, r15
0106f97a 458b4074 mov r8d, dword ptr [r8 + 0x74]
0106f97e c744242001000000 mov dword ptr [rsp + 0x20], 1
0106f986 e8a5b6ffff call 0x14106b030
0106f98b 8bd8 mov ebx, eax
0106f98d 85c0 test eax, eax
0106f98f 0f85c3080000 jne 0x141070258
0106f995 38442440 cmp byte ptr [rsp + 0x40], al
0106f999 7405 je 0x14106f9a0
0106f99b ff470c inc dword ptr [rdi + 0xc]
0106f99e eb08 jmp 0x14106f9a8
0106f9a0 85c0 test eax, eax
0106f9a2 0f85b0080000 jne 0x141070258
0106f9a8 4c8b4610 mov r8, qword ptr [rsi + 0x10]
0106f9ac 488d442440 lea rax, [rsp + 0x40]
0106f9b1 4889442430 mov qword ptr [rsp + 0x30], rax
0106f9b6 498d9510090000 lea rdx, [r13 + 0x910]
0106f9bd 488d442448 lea rax, [rsp + 0x48]
0106f9c2 41b93c000000 mov r9d, 0x3c
0106f9c8 4889442428 mov qword ptr [rsp + 0x28], rax
0106f9cd 498bcf mov rcx, r15
0106f9d0 458b4078 mov r8d, dword ptr [r8 + 0x78]
0106f9d4 c744242001000000 mov dword ptr [rsp + 0x20], 1
0106f9dc e84fb6ffff call 0x14106b030
0106f9e1 8bd8 mov ebx, eax
0106f9e3 85c0 test eax, eax
0106f9e5 0f856d080000 jne 0x141070258
0106f9eb 38442440 cmp byte ptr [rsp + 0x40], al
0106f9ef 7405 je 0x14106f9f6
0106f9f1 ff470c inc dword ptr [rdi + 0xc]
0106f9f4 eb08 jmp 0x14106f9fe
0106f9f6 85c0 test eax, eax
0106f9f8 0f855a080000 jne 0x141070258
0106f9fe 4c8b4610 mov r8, qword ptr [rsi + 0x10]
0106fa02 488d442440 lea rax, [rsp + 0x40]
0106fa07 4889442430 mov qword ptr [rsp + 0x30], rax
0106fa0c 498d95c8080000 lea rdx, [r13 + 0x8c8]
0106fa13 488d442448 lea rax, [rsp + 0x48]
0106fa18 41b93d000000 mov r9d, 0x3d
0106fa1e 4889442428 mov qword ptr [rsp + 0x28], rax
0106fa23 498bcf mov rcx, r15
0106fa26 458b407c mov r8d, dword ptr [r8 + 0x7c]
0106fa2a c744242001000000 mov dword ptr [rsp + 0x20], 1
0106fa32 e8f9b5ffff call 0x14106b030
0106fa37 8bd8 mov ebx, eax
0106fa39 85c0 test eax, eax
0106fa3b 0f8517080000 jne 0x141070258
0106fa41 38442440 cmp byte ptr [rsp + 0x40], al
0106fa45 7405 je 0x14106fa4c
0106fa47 ff470c inc dword ptr [rdi + 0xc]
0106fa4a eb08 jmp 0x14106fa54
0106fa4c 85c0 test eax, eax
0106fa4e 0f8504080000 jne 0x141070258
0106fa54 4c8b4610 mov r8, qword ptr [rsi + 0x10]
0106fa58 488d442440 lea rax, [rsp + 0x40]
0106fa5d 4889442430 mov qword ptr [rsp + 0x30], rax
0106fa62 498d9510090000 lea rdx, [r13 + 0x910]
0106fa69 488d442448 lea rax, [rsp + 0x48]
0106fa6e 41b93e000000 mov r9d, 0x3e
0106fa74 4889442428 mov qword ptr [rsp + 0x28], rax
0106fa79 498bcf mov rcx, r15
0106fa7c 458b8080000000 mov r8d, dword ptr [r8 + 0x80]
0106fa83 c744242001000000 mov dword ptr [rsp + 0x20], 1
0106fa8b e8a0b5ffff call 0x14106b030
0106fa90 8bd8 mov ebx, eax
0106fa92 85c0 test eax, eax
0106fa94 0f85be070000 jne 0x141070258
0106fa9a 38442440 cmp byte ptr [rsp + 0x40], al
0106fa9e 7405 je 0x14106faa5
0106faa0 ff470c inc dword ptr [rdi + 0xc]
0106faa3 eb08 jmp 0x14106faad
0106faa5 85c0 test eax, eax
0106faa7 0f85ab070000 jne 0x141070258
0106faad f6464020 test byte ptr [rsi + 0x40], 0x20
0106fab1 0f84cb000000 je 0x14106fb82
0106fab7 488bce mov rcx, rsi
0106faba e86197f3ff call 0x140fa9220
0106fabf 4c8be0 mov r12, rax
0106fac2 4885c0 test rax, rax
0106fac5 0f84b7000000 je 0x14106fb82
0106facb 488d542450 lea rdx, [rsp + 0x50]
0106fad0 48c744245000000000 mov qword ptr [rsp + 0x50], 0
0106fad9 488bc8 mov rcx, rax
0106fadc e84fe6b6ff call 0x140bde130
0106fae1 8bd8 mov ebx, eax
0106fae3 488b442450 mov rax, qword ptr [rsp + 0x50]
0106fae8 85db test ebx, ebx
0106faea 0f851a010000 jne 0x14106fc0a
0106faf0 4885c0 test rax, rax
0106faf3 7436 je 0x14106fb2b
0106faf5 488bc8 mov rcx, rax
0106faf8 ff1572948700 call qword ptr [rip + 0x879472]
0106fafe 483d00005000 cmp rax, 0x500000
0106fb04 7747 ja 0x14106fb4d
0106fb06 488b4c2450 mov rcx, qword ptr [rsp + 0x50]
0106fb0b ff155f948700 call qword ptr [rip + 0x87945f]
0106fb11 488b4c2450 mov rcx, qword ptr [rsp + 0x50]
0106fb16 4889442458 mov qword ptr [rsp + 0x58], rax
0106fb1b ff1557948700 call qword ptr [rip + 0x879457]
0106fb21 488bd0 mov rdx, rax
0106fb24 488b442458 mov rax, qword ptr [rsp + 0x58]
0106fb29 eb02 jmp 0x14106fb2d
0106fb2b 33d2 xor edx, edx
0106fb2d 488d4c2448 lea rcx, [rsp + 0x48]
0106fb32 41b915000000 mov r9d, 0x15
0106fb38 48894c2420 mov qword ptr [rsp + 0x20], rcx
0106fb3d 448bc0 mov r8d, eax
0106fb40 498bcf mov rcx, r15
0106fb43 e848b4ffff call 0x14106af90
0106fb48 ff470c inc dword ptr [rdi + 0xc]
0106fb4b 8bd8 mov ebx, eax
0106fb4d 488b442450 mov rax, qword ptr [rsp + 0x50]
0106fb52 4885c0 test rax, rax
0106fb55 7409 je 0x14106fb60
0106fb57 488bc8 mov rcx, rax
0106fb5a ff15c0928700 call qword ptr [rip + 0x8792c0]
0106fb60 41813c2464706863 cmp dword ptr [r12], 0x63687064
0106fb68 7510 jne 0x14106fb7a
0106fb6a 41836c240401 sub dword ptr [r12 + 4], 1
0106fb70 7508 jne 0x14106fb7a
0106fb72 498bcc mov rcx, r12
0106fb75 e8c6e7b6ff call 0x140bde340
0106fb7a 85db test ebx, ebx
0106fb7c 0f85d6060000 jne 0x141070258
0106fb82 488b4610 mov rax, qword ptr [rsi + 0x10]
0106fb86 488b9098000000 mov rdx, qword ptr [rax + 0x98]
0106fb8d 4885d2 test rdx, rdx
0106fb90 7420 je 0x14106fbb2
0106fb92 4c8d4c2448 lea r9, [rsp + 0x48]
0106fb97 41b830000000 mov r8d, 0x30
0106fb9d 498bcf mov rcx, r15
0106fba0 e89bb5ffff call 0x14106b140
0106fba5 8bd8 mov ebx, eax
0106fba7 85c0 test eax, eax
0106fba9 0f85a9060000 jne 0x141070258
0106fbaf ff470c inc dword ptr [rdi + 0xc]
0106fbb2 4d8b4670 mov r8, qword ptr [r14 + 0x70]
0106fbb6 41f60001 test byte ptr [r8], 1
0106fbba 0f845b010000 je 0x14106fd1b
0106fbc0 458b4028 mov r8d, dword ptr [r8 + 0x28]
0106fbc4 488d442440 lea rax, [rsp + 0x40]
0106fbc9 4889442430 mov qword ptr [rsp + 0x30], rax
0106fbce 498d9540060000 lea rdx, [r13 + 0x640]
0106fbd5 488d442448 lea rax, [rsp + 0x48]
0106fbda 41b918000000 mov r9d, 0x18
0106fbe0 4889442428 mov qword ptr [rsp + 0x28], rax
0106fbe5 498bcf mov rcx, r15
0106fbe8 c744242001000000 mov dword ptr [rsp + 0x20], 1
0106fbf0 e83bb4ffff call 0x14106b030
0106fbf5 8bd8 mov ebx, eax
0106fbf7 85c0 test eax, eax
0106fbf9 0f8559060000 jne 0x141070258
0106fbff 38442440 cmp byte ptr [rsp + 0x40], al
0106fc03 740c je 0x14106fc11
0106fc05 ff470c inc dword ptr [rdi + 0xc]
0106fc08 eb0f jmp 0x14106fc19
0106fc0a 33db xor ebx, ebx
0106fc0c e941ffffff jmp 0x14106fb52
0106fc11 85c0 test eax, eax
0106fc13 0f853f060000 jne 0x141070258
0106fc19 4d8b4670 mov r8, qword ptr [r14 + 0x70]
0106fc1d 488d442440 lea rax, [rsp + 0x40]
0106fc22 4889442430 mov qword ptr [rsp + 0x30], rax
0106fc27 498d95d0060000 lea rdx, [r13 + 0x6d0]
0106fc2e 488d442448 lea rax, [rsp + 0x48]
0106fc33 41b919000000 mov r9d, 0x19
0106fc39 4889442428 mov qword ptr [rsp + 0x28], rax
0106fc3e 498bcf mov rcx, r15
0106fc41 458b402c mov r8d, dword ptr [r8 + 0x2c]
0106fc45 c744242001000000 mov dword ptr [rsp + 0x20], 1
0106fc4d e8deb3ffff call 0x14106b030
0106fc52 8bd8 mov ebx, eax
0106fc54 85c0 test eax, eax
0106fc56 0f85fc050000 jne 0x141070258
0106fc5c 38442440 cmp byte ptr [rsp + 0x40], al
0106fc60 7405 je 0x14106fc67
0106fc62 ff470c inc dword ptr [rdi + 0xc]
0106fc65 eb08 jmp 0x14106fc6f
0106fc67 85c0 test eax, eax
0106fc69 0f85e9050000 jne 0x141070258
0106fc6f 4d8b4670 mov r8, qword ptr [r14 + 0x70]
0106fc73 488d442440 lea rax, [rsp + 0x40]
0106fc78 4889442430 mov qword ptr [rsp + 0x30], rax
0106fc7d 498d9560070000 lea rdx, [r13 + 0x760]
0106fc84 488d442448 lea rax, [rsp + 0x48]
0106fc89 41b91d000000 mov r9d, 0x1d
0106fc8f 4889442428 mov qword ptr [rsp + 0x28], rax
0106fc94 498bcf mov rcx, r15
0106fc97 458b4024 mov r8d, dword ptr [r8 + 0x24]
0106fc9b c744242002000000 mov dword ptr [rsp + 0x20], 2
0106fca3 e888b3ffff call 0x14106b030
0106fca8 8bd8 mov ebx, eax
0106fcaa 85c0 test eax, eax
0106fcac 0f85a6050000 jne 0x141070258
0106fcb2 38442440 cmp byte ptr [rsp + 0x40], al
0106fcb6 7405 je 0x14106fcbd
0106fcb8 ff470c inc dword ptr [rdi + 0xc]
0106fcbb eb08 jmp 0x14106fcc5
0106fcbd 85c0 test eax, eax
0106fcbf 0f8593050000 jne 0x141070258
0106fcc5 4d8b4670 mov r8, qword ptr [r14 + 0x70]
0106fcc9 488d442440 lea rax, [rsp + 0x40]
0106fcce 4889442430 mov qword ptr [rsp + 0x30], rax
0106fcd3 498d95d0060000 lea rdx, [r13 + 0x6d0]
0106fcda 488d442448 lea rax, [rsp + 0x48]
0106fcdf 41b941000000 mov r9d, 0x41
0106fce5 4889442428 mov qword ptr [rsp + 0x28], rax
0106fcea 498bcf mov rcx, r15
0106fced 458b4030 mov r8d, dword ptr [r8 + 0x30]
0106fcf1 c744242001000000 mov dword ptr [rsp + 0x20], 1
0106fcf9 e832b3ffff call 0x14106b030
0106fcfe 8bd8 mov ebx, eax
0106fd00 85c0 test eax, eax
0106fd02 0f8550050000 jne 0x141070258
0106fd08 38442440 cmp byte ptr [rsp + 0x40], al
0106fd0c 7405 je 0x14106fd13
0106fd0e ff470c inc dword ptr [rdi + 0xc]
0106fd11 eb08 jmp 0x14106fd1b
0106fd13 85c0 test eax, eax
0106fd15 0f853d050000 jne 0x141070258
0106fd1b 488b5618 mov rdx, qword ptr [rsi + 0x18]
0106fd1f f60201 test byte ptr [rdx], 1
0106fd22 0f84c7000000 je 0x14106fdef
0106fd28 4533e4 xor r12d, r12d
0106fd2b 4439621c cmp dword ptr [rdx + 0x1c], r12d
0106fd2f 7644 jbe 0x14106fd75
0106fd31 0f1f4000 nop dword ptr [rax]
0106fd35 6666660f1f840000000000 nop word ptr [rax + rax]
0106fd40 4c8d4220 lea r8, [rdx + 0x20]
0106fd44 418bc4 mov eax, r12d
0106fd47 486bc838 imul rcx, rax, 0x38
0106fd4b 4c8d4c2448 lea r9, [rsp + 0x48]
0106fd50 488bd7 mov rdx, rdi
0106fd53 4c03c1 add r8, rcx
0106fd56 498bcf mov rcx, r15
0106fd59 e822ccffff call 0x14106c980
0106fd5e 8bd8 mov ebx, eax
0106fd60 85c0 test eax, eax
0106fd62 0f85f0040000 jne 0x141070258
0106fd68 488b5618 mov rdx, qword ptr [rsi + 0x18]
0106fd6c 41ffc4 inc r12d
0106fd6f 443b621c cmp r12d, dword ptr [rdx + 0x1c]
0106fd73 72cb jb 0x14106fd40
0106fd75 0fb64218 movzx eax, byte ptr [rdx + 0x18]
0106fd79 4188878402a000 mov byte ptr [r15 + 0xa00284], al
0106fd80 488b4618 mov rax, qword ptr [rsi + 0x18]
0106fd84 0fb64819 movzx ecx, byte ptr [rax + 0x19]
0106fd88 888f5d010000 mov byte ptr [rdi + 0x15d], cl
0106fd8e 488b4618 mov rax, qword ptr [rsi + 0x18]
0106fd92 0fb6481a movzx ecx, byte ptr [rax + 0x1a]
0106fd96 888f70010000 mov byte ptr [rdi + 0x170], cl
0106fd9c 488b4618 mov rax, qword ptr [rsi + 0x18]
0106fda0 0fb608 movzx ecx, byte ptr [rax]
0106fda3 c0e903 shr cl, 3
0106fda6 80e101 and cl, 1
0106fda9 888f73010000 mov byte ptr [rdi + 0x173], cl
0106fdaf 488b4618 mov rax, qword ptr [rsi + 0x18]
0106fdb3 0fb64812 movzx ecx, byte ptr [rax + 0x12]
0106fdb7 888f63020000 mov byte ptr [rdi + 0x263], cl
0106fdbd 488b4618 mov rax, qword ptr [rsi + 0x18]
0106fdc1 0fb64814 movzx ecx, byte ptr [rax + 0x14]
0106fdc5 888fe0020000 mov byte ptr [rdi + 0x2e0], cl
0106fdcb 488b4618 mov rax, qword ptr [rsi + 0x18]
0106fdcf 0fb74812 movzx ecx, word ptr [rax + 0x12]
0106fdd3 6683f901 cmp cx, 1
0106fdd7 740e je 0x14106fde7
0106fdd9 6683e902 sub cx, 2
0106fddd 6683f901 cmp cx, 1
0106fde1 7604 jbe 0x14106fde7
0106fde3 32c0 xor al, al
0106fde5 eb02 jmp 0x14106fde9
0106fde7 b001 mov al, 1
0106fde9 8887de010000 mov byte ptr [rdi + 0x1de], al
0106fdef 41f6869b00000008 test byte ptr [r14 + 0x9b], 8
0106fdf7 7523 jne 0x14106fe1c
0106fdf9 4180be9d00000000 cmp byte ptr [r14 + 0x9d], 0
0106fe01 0f8dce000000 jge 0x14106fed5
0106fe07 33d2 xor edx, edx
0106fe09 498bce mov rcx, r14
0106fe0c e85f0df3ff call 0x140fa0b70
0106fe11 a904002000 test eax, 0x200004
0106fe16 0f84b9000000 je 0x14106fed5
0106fe1c 817e3450545448 cmp dword ptr [rsi + 0x34], 0x48545450
0106fe23 0f85ac000000 jne 0x14106fed5
0106fe29 4d8b4668 mov r8, qword ptr [r14 + 0x68]
0106fe2d 488d442440 lea rax, [rsp + 0x40]
0106fe32 4889442430 mov qword ptr [rsp + 0x30], rax
0106fe37 498d95d8040000 lea rdx, [r13 + 0x4d8]
0106fe3e 488d442448 lea rax, [rsp + 0x48]
0106fe43 41b90f000000 mov r9d, 0xf
0106fe49 4889442428 mov qword ptr [rsp + 0x28], rax
0106fe4e 498bcf mov rcx, r15
0106fe51 458b4048 mov r8d, dword ptr [r8 + 0x48]
0106fe55 c744242001000000 mov dword ptr [rsp + 0x20], 1
0106fe5d e8ceb1ffff call 0x14106b030
0106fe62 8bd8 mov ebx, eax
0106fe64 85c0 test eax, eax
0106fe66 0f85ec030000 jne 0x141070258
0106fe6c 38442440 cmp byte ptr [rsp + 0x40], al
0106fe70 7405 je 0x14106fe77
0106fe72 ff470c inc dword ptr [rdi + 0xc]
0106fe75 eb08 jmp 0x14106fe7f
0106fe77 85c0 test eax, eax
0106fe79 0f85d9030000 jne 0x141070258
0106fe7f 4d8b4668 mov r8, qword ptr [r14 + 0x68]
0106fe83 488d442440 lea rax, [rsp + 0x40]
0106fe88 4889442430 mov qword ptr [rsp + 0x30], rax
0106fe8d 498d95d8040000 lea rdx, [r13 + 0x4d8]
0106fe94 488d442448 lea rax, [rsp + 0x48]
0106fe99 41b910000000 mov r9d, 0x10
0106fe9f 4889442428 mov qword ptr [rsp + 0x28], rax
0106fea4 498bcf mov rcx, r15
0106fea7 458b4044 mov r8d, dword ptr [r8 + 0x44]
0106feab c744242001000000 mov dword ptr [rsp + 0x20], 1
0106feb3 e878b1ffff call 0x14106b030
0106feb8 8bd8 mov ebx, eax
0106feba 85c0 test eax, eax
0106febc 0f8596030000 jne 0x141070258
0106fec2 38442440 cmp byte ptr [rsp + 0x40], al
0106fec6 7405 je 0x14106fecd
0106fec8 ff470c inc dword ptr [rdi + 0xc]
0106fecb eb08 jmp 0x14106fed5
0106fecd 85c0 test eax, eax
0106fecf 0f8583030000 jne 0x141070258
0106fed5 4883bed002000000 cmp qword ptr [rsi + 0x2d0], 0
0106fedd 41bd08000000 mov r13d, 8
0106fee3 0f84e5000000 je 0x14106ffce
0106fee9 65488b042558000000 mov rax, qword ptr gs:[0x58]
0106fef2 33db xor ebx, ebx
0106fef4 4533e4 xor r12d, r12d
0106fef7 488b08 mov rcx, qword ptr [rax]
0106fefa 418b440d00 mov eax, dword ptr [r13 + rcx]
0106feff 39054fdd0901 cmp dword ptr [rip + 0x109dd4f], eax
0106ff05 0f8f11040000 jg 0x14107031c
0106ff0b 4533ed xor r13d, r13d
0106ff0e 488d0d03e90801 lea rcx, [rip + 0x108e903]
0106ff15 4a8b04e9 mov rax, qword ptr [rcx + r13*8]
0106ff19 488b8ed0020000 mov rcx, qword ptr [rsi + 0x2d0]
0106ff20 4889442450 mov qword ptr [rsp + 0x50], rax
0106ff25 4885c9 test rcx, rcx
0106ff28 745c je 0x14106ff86
0106ff2a 4885c0 test rax, rax
0106ff2d 7457 je 0x14106ff86
0106ff2f 488bd0 mov rdx, rax
0106ff32 ff15b88e8700 call qword ptr [rip + 0x878eb8]
0106ff38 4889442458 mov qword ptr [rsp + 0x58], rax
0106ff3d 4885c0 test rax, rax
0106ff40 7444 je 0x14106ff86
0106ff42 4d85e4 test r12, r12
0106ff45 752e jne 0x14106ff75
0106ff47 4c8b0df28e8700 mov r9, qword ptr [rip + 0x878ef2]
0106ff4e 33d2 xor edx, edx
0106ff50 4c8b05918e8700 mov r8, qword ptr [rip + 0x878e91]
0106ff57 488b0d32610301 mov rcx, qword ptr [rip + 0x1036132]
0106ff5e ff1554938700 call qword ptr [rip + 0x879354]
0106ff64 4c8be0 mov r12, rax
0106ff67 4885c0 test rax, rax
0106ff6a 0f84d1010000 je 0x141070141
0106ff70 488b442458 mov rax, qword ptr [rsp + 0x58]
0106ff75 488b542450 mov rdx, qword ptr [rsp + 0x50]
0106ff7a 4c8bc0 mov r8, rax
0106ff7d 498bcc mov rcx, r12
0106ff80 ff150a918700 call qword ptr [rip + 0x87910a]
0106ff86 41ffc5 inc r13d
0106ff89 4183fd03 cmp r13d, 3
0106ff8d 0f827bffffff jb 0x14106ff0e
0106ff93 4d85e4 test r12, r12
0106ff96 7428 je 0x14106ffc0
0106ff98 4c8d4c2448 lea r9, [rsp + 0x48]
0106ff9d 41b838000000 mov r8d, 0x38
0106ffa3 498bd4 mov rdx, r12
0106ffa6 498bcf mov rcx, r15
0106ffa9 e892b1ffff call 0x14106b140
0106ffae 8bd8 mov ebx, eax
0106ffb0 85c0 test eax, eax
0106ffb2 7503 jne 0x14106ffb7
0106ffb4 ff470c inc dword ptr [rdi + 0xc]
0106ffb7 498bcc mov rcx, r12
0106ffba ff15608e8700 call qword ptr [rip + 0x878e60]
0106ffc0 85db test ebx, ebx
0106ffc2 0f8590020000 jne 0x141070258
0106ffc8 41bd08000000 mov r13d, 8
0106ffce 498b4668 mov rax, qword ptr [r14 + 0x68]
0106ffd2 4883785800 cmp qword ptr [rax + 0x58], 0
0106ffd7 0f840b010000 je 0x1410700e8
0106ffdd 33d2 xor edx, edx
0106ffdf 498bce mov rcx, r14
0106ffe2 33db xor ebx, ebx
0106ffe4 e8671af3ff call 0x140fa1a50
0106ffe9 4c8be0 mov r12, rax
0106ffec 4885c0 test rax, rax
0106ffef 0f84eb000000 je 0x1410700e0
0106fff5 488bc8 mov rcx, rax
0106fff8 ff15c2928700 call qword ptr [rip + 0x8792c2]
0106fffe 4885c0 test rax, rax
01070001 0f8eac000000 jle 0x1410700b3
01070007 498bce mov rcx, r14
0107000a e851baf4ff call 0x140fbba60
0107000f 84c0 test al, al
01070011 0f859c000000 jne 0x1410700b3
01070017 65488b042558000000 mov rax, qword ptr gs:[0x58]
01070020 418bd5 mov edx, r13d
01070023 488b08 mov rcx, qword ptr [rax]
01070026 8b040a mov eax, dword ptr [rdx + rcx]
01070029 390529dc0901 cmp dword ptr [rip + 0x109dc29], eax
0107002f 0f8f69020000 jg 0x14107029e
01070035 488b15ace70801 mov rdx, qword ptr [rip + 0x108e7ac]
0107003c 4885d2 test rdx, rdx
0107003f 7409 je 0x14107004a
01070041 498bcc mov rcx, r12
01070044 ff15b6928700 call qword ptr [rip + 0x8792b6]
0107004a 488b159fe70801 mov rdx, qword ptr [rip + 0x108e79f]
01070051 4885d2 test rdx, rdx
01070054 7409 je 0x14107005f
01070056 498bcc mov rcx, r12
01070059 ff15a1928700 call qword ptr [rip + 0x8792a1]
0107005f 488b1592e70801 mov rdx, qword ptr [rip + 0x108e792]
01070066 4885d2 test rdx, rdx
01070069 7409 je 0x141070074
0107006b 498bcc mov rcx, r12
0107006e ff158c928700 call qword ptr [rip + 0x87928c]
01070074 488b1585e70801 mov rdx, qword ptr [rip + 0x108e785]
0107007b 4885d2 test rdx, rdx
0107007e 7409 je 0x141070089
01070080 498bcc mov rcx, r12
01070083 ff1577928700 call qword ptr [rip + 0x879277]
01070089 488b1578e70801 mov rdx, qword ptr [rip + 0x108e778]
01070090 4885d2 test rdx, rdx
01070093 7409 je 0x14107009e
01070095 498bcc mov rcx, r12
01070098 ff1562928700 call qword ptr [rip + 0x879262]
0107009e 488b156be70801 mov rdx, qword ptr [rip + 0x108e76b]
010700a5 4885d2 test rdx, rdx
010700a8 7409 je 0x1410700b3
010700aa 498bcc mov rcx, r12
010700ad ff154d928700 call qword ptr [rip + 0x87924d]
010700b3 498bcc mov rcx, r12
010700b6 ff1504928700 call qword ptr [rip + 0x879204]
010700bc 4885c0 test rax, rax
010700bf 7e1f jle 0x1410700e0
010700c1 4c8d4c2448 lea r9, [rsp + 0x48]
010700c6 41b836000000 mov r8d, 0x36
010700cc 498bd4 mov rdx, r12
010700cf 498bcf mov rcx, r15
010700d2 e869b0ffff call 0x14106b140
010700d7 8bd8 mov ebx, eax
010700d9 85c0 test eax, eax
010700db 7503 jne 0x1410700e0
010700dd ff470c inc dword ptr [rdi + 0xc]
010700e0 85db test ebx, ebx
010700e2 0f8570010000 jne 0x141070258
010700e8 8b4714 mov eax, dword ptr [rdi + 0x14]
010700eb 83f801 cmp eax, 1
010700ee 0f858d000000 jne 0x141070181
010700f4 448b86b8020000 mov r8d, dword ptr [rsi + 0x2b8]
010700fb 488d442440 lea rax, [rsp + 0x40]
01070100 488b96c8020000 mov rdx, qword ptr [rsi + 0x2c8]
01070107 41b90d000000 mov r9d, 0xd
0107010d 4889442430 mov qword ptr [rsp + 0x30], rax
01070112 498bcf mov rcx, r15
01070115 488d442448 lea rax, [rsp + 0x48]
0107011a 4889442428 mov qword ptr [rsp + 0x28], rax
0107011f c744242001000000 mov dword ptr [rsp + 0x20], 1
01070127 e804afffff call 0x14106b030
0107012c 8bd8 mov ebx, eax
0107012e 85c0 test eax, eax
01070130 0f8522010000 jne 0x141070258
01070136 38442440 cmp byte ptr [rsp + 0x40], al
0107013a 740f je 0x14107014b
0107013c ff470c inc dword ptr [rdi + 0xc]
0107013f eb12 jmp 0x141070153
01070141 bb94ffffff mov ebx, 0xffffff94
01070146 e90d010000 jmp 0x141070258
0107014b 85c0 test eax, eax
0107014d 0f8505010000 jne 0x141070258
01070153 448b86c0020000 mov r8d, dword ptr [rsi + 0x2c0]
0107015a 488d442440 lea rax, [rsp + 0x40]
0107015f 4889442430 mov qword ptr [rsp + 0x30], rax
01070164 41b90b000000 mov r9d, 0xb
0107016a 488d442448 lea rax, [rsp + 0x48]
0107016f 4889442428 mov qword ptr [rsp + 0x28], rax
01070174 c744242002000000 mov dword ptr [rsp + 0x20], 2
0107017c e983000000 jmp 0x141070204
01070181 83f802 cmp eax, 2
01070184 0f859f000000 jne 0x141070229
0107018a 448b86b8020000 mov r8d, dword ptr [rsi + 0x2b8]
01070191 488d442440 lea rax, [rsp + 0x40]
01070196 488b96c8020000 mov rdx, qword ptr [rsi + 0x2c8]
0107019d 41b90b000000 mov r9d, 0xb
010701a3 4889442430 mov qword ptr [rsp + 0x30], rax
010701a8 498bcf mov rcx, r15
010701ab 488d442448 lea rax, [rsp + 0x48]
010701b0 4889442428 mov qword ptr [rsp + 0x28], rax
010701b5 c744242000000000 mov dword ptr [rsp + 0x20], 0
010701bd e86eaeffff call 0x14106b030
010701c2 8bd8 mov ebx, eax
010701c4 85c0 test eax, eax
010701c6 0f858c000000 jne 0x141070258
010701cc 38442440 cmp byte ptr [rsp + 0x40], al
010701d0 7405 je 0x1410701d7
010701d2 ff470c inc dword ptr [rdi + 0xc]
010701d5 eb04 jmp 0x1410701db
010701d7 85c0 test eax, eax
010701d9 757d jne 0x141070258
010701db 448b86bc020000 mov r8d, dword ptr [rsi + 0x2bc]
010701e2 488d442440 lea rax, [rsp + 0x40]
010701e7 4889442430 mov qword ptr [rsp + 0x30], rax
010701ec 41b911000000 mov r9d, 0x11
010701f2 488d442448 lea rax, [rsp + 0x48]
010701f7 4889442428 mov qword ptr [rsp + 0x28], rax
010701fc c744242000000000 mov dword ptr [rsp + 0x20], 0
01070204 488b96c8020000 mov rdx, qword ptr [rsi + 0x2c8]
0107020b 498bcf mov rcx, r15
0107020e e81daeffff call 0x14106b030
01070213 8bd8 mov ebx, eax
01070215 85c0 test eax, eax
01070217 753f jne 0x141070258
01070219 807c244000 cmp byte ptr [rsp + 0x40], 0
0107021e 7405 je 0x141070225
01070220 ff470c inc dword ptr [rdi + 0xc]
01070223 eb04 jmp 0x141070229
01070225 85c0 test eax, eax
01070227 752f jne 0x141070258
01070229 8b5c2448 mov ebx, dword ptr [rsp + 0x48]
0107022d 488bd7 mov rdx, rdi
01070230 412bdf sub ebx, r15d
01070233 498bcf mov rcx, r15
01070236 81c3d8fe5fff add ebx, 0xff5ffed8
0107023c 895f08 mov dword ptr [rdi + 8], ebx
0107023f e80c8fffff call 0x141069150
01070244 448bc3 mov r8d, ebx
01070247 498d972801a000 lea rdx, [r15 + 0xa00128]
0107024e 498bcf mov rcx, r15
01070251 e81aa9ffff call 0x14106ab70
01070256 8bd8 mov ebx, eax
01070258 4c8bac2400030000 mov r13, qword ptr [rsp + 0x300]
01070260 8bc3 mov eax, ebx
01070262 488b9c2450030000 mov rbx, qword ptr [rsp + 0x350]
0107026a 4c8ba42408030000 mov r12, qword ptr [rsp + 0x308]
01070272 488bbc2410030000 mov rdi, qword ptr [rsp + 0x310]
0107027a eb05 jmp 0x141070281
0107027c b8ceffffff mov eax, 0xffffffce
01070281 488b8df0010000 mov rcx, qword ptr [rbp + 0x1f0]
01070288 4833cc xor rcx, rsp
0107028b e850b67200 call 0x14179b8e0
01070290 4881c418030000 add rsp, 0x318
01070297 415f pop r15
01070299 415e pop r14
0107029b 5e pop rsi
0107029c 5d pop rbp
0107029d c3 ret 
0107029e 488d0db3d90901 lea rcx, [rip + 0x109d9b3]
010702a5 e8aebf7200 call 0x14179c258
010702aa 833da7d90901ff cmp dword ptr [rip + 0x109d9a7], -1
010702b1 0f857efdffff jne 0x141070035
010702b7 488b0542f40301 mov rax, qword ptr [rip + 0x103f442]
010702be 488d0d93d90901 lea rcx, [rip + 0x109d993]
010702c5 4889051ce50801 mov qword ptr [rip + 0x108e51c], rax
010702cc 488b0535f40301 mov rax, qword ptr [rip + 0x103f435]
010702d3 48890516e50801 mov qword ptr [rip + 0x108e516], rax
010702da 488b052ff40301 mov rax, qword ptr [rip + 0x103f42f]
010702e1 48890510e50801 mov qword ptr [rip + 0x108e510], rax
010702e8 488b0529f40301 mov rax, qword ptr [rip + 0x103f429]
010702ef 4889050ae50801 mov qword ptr [rip + 0x108e50a], rax
010702f6 488b0523f40301 mov rax, qword ptr [rip + 0x103f423]
010702fd 48890504e50801 mov qword ptr [rip + 0x108e504], rax
01070304 488b051df40301 mov rax, qword ptr [rip + 0x103f41d]
0107030b 488905fee40801 mov qword ptr [rip + 0x108e4fe], rax
01070312 e8d5be7200 call 0x14179c1ec
01070317 e919fdffff jmp 0x141070035
0107031c 488d0d31d90901 lea rcx, [rip + 0x109d931]
01070323 e830bf7200 call 0x14179c258
01070328 833d25d90901ff cmp dword ptr [rip + 0x109d925], -1
0107032f 0f85d6fbffff jne 0x14106ff0b
01070335 488b0504f40301 mov rax, qword ptr [rip + 0x103f404]
0107033c 488d0d11d90901 lea rcx, [rip + 0x109d911]
01070343 488905cee40801 mov qword ptr [rip + 0x108e4ce], rax
0107034a 488b05f7f30301 mov rax, qword ptr [rip + 0x103f3f7]
01070351 488905c8e40801 mov qword ptr [rip + 0x108e4c8], rax
01070358 488b05f1f30301 mov rax, qword ptr [rip + 0x103f3f1]
0107035f 488905c2e40801 mov qword ptr [rip + 0x108e4c2], rax
01070366 e881be7200 call 0x14179c1ec
0107036b e99bfbffff jmp 0x14106ff0b