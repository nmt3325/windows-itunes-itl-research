0108da70 488bc4 mov rax, rsp
0108da73 48895810 mov qword ptr [rax + 0x10], rbx
0108da77 48897018 mov qword ptr [rax + 0x18], rsi
0108da7b 48897820 mov qword ptr [rax + 0x20], rdi
0108da7f 55 push rbp
0108da80 4154 push r12
0108da82 4155 push r13
0108da84 4156 push r14
0108da86 4157 push r15
0108da88 488da828fdffff lea rbp, [rax - 0x2d8]
0108da8f 4881ecb0030000 sub rsp, 0x3b0
0108da96 0f2970c8 movaps xmmword ptr [rax - 0x38], xmm6
0108da9a 0f2978b8 movaps xmmword ptr [rax - 0x48], xmm7
0108da9e 440f2940a8 movaps xmmword ptr [rax - 0x58], xmm8
0108daa3 488b059675f400 mov rax, qword ptr [rip + 0xf47596]
0108daaa 4833c4 xor rax, rsp
0108daad 48898570020000 mov qword ptr [rbp + 0x270], rax
0108dab4 4c8bf1 mov r14, rcx
0108dab7 48894c2460 mov qword ptr [rsp + 0x60], rcx
0108dabc 32c0 xor al, al
0108dabe 8844243c mov byte ptr [rsp + 0x3c], al
0108dac2 4885c9 test rcx, rcx
0108dac5 750a jne 0x14108dad1
0108dac7 b8ceffffff mov eax, 0xffffffce
0108dacc e9d51b0000 jmp 0x14108f6a6
0108dad1 488d542470 lea rdx, [rsp + 0x70]
0108dad6 b101 mov cl, 1
0108dad8 e853b00c00 call 0x141158b30
0108dadd 83f8d5 cmp eax, -0x2b
0108dae0 0f84c01b0000 je 0x14108f6a6
0108dae6 85c0 test eax, eax
0108dae8 0f85b81b0000 jne 0x14108f6a6
0108daee 4533e4 xor r12d, r12d
0108daf1 418bf4 mov esi, r12d
0108daf4 498b4e08 mov rcx, qword ptr [r14 + 8]
0108daf8 48894c2458 mov qword ptr [rsp + 0x58], rcx
0108dafd 4c8b6c2470 mov r13, qword ptr [rsp + 0x70]
0108db02 4c896c2470 mov qword ptr [rsp + 0x70], r13
0108db07 4885c9 test rcx, rcx
0108db0a 0f84561b0000 je 0x14108f666
0108db10 4c8bb9e8200000 mov r15, qword ptr [rcx + 0x20e8]
0108db17 4d85ff test r15, r15
0108db1a 0f84461b0000 je 0x14108f666
0108db20 4d85ed test r13, r13
0108db23 7460 je 0x14108db85
0108db25 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108db2d 7556 jne 0x14108db85
0108db2f 4d8bb5b8080000 mov r14, qword ptr [r13 + 0x8b8]
0108db36 418bdc mov ebx, r12d
0108db39 418b7e08 mov edi, dword ptr [r14 + 8]
0108db3d 85ff test edi, edi
0108db3f 742c je 0x14108db6d
0108db41 8bc3 mov eax, ebx
0108db43 488d0c40 lea rcx, [rax + rax*2]
0108db47 498d560c lea rdx, [r14 + 0xc]
0108db4b 488d14ca lea rdx, [rdx + rcx*8]
0108db4f 41b810000000 mov r8d, 0x10
0108db55 498d8f60100000 lea rcx, [r15 + 0x1060]
0108db5c e833f17000 call 0x14179cc94
0108db61 85c0 test eax, eax
0108db63 7414 je 0x14108db79
0108db65 7806 js 0x14108db6d
0108db67 ffc3 inc ebx
0108db69 3bdf cmp ebx, edi
0108db6b 72d4 jb 0x14108db41
0108db6d bfd5ffffff mov edi, 0xffffffd5
0108db72 4c8b742460 mov r14, qword ptr [rsp + 0x60]
0108db77 eb11 jmp 0x14108db8a
0108db79 8bf3 mov esi, ebx
0108db7b 418bfc mov edi, r12d
0108db7e 4c8b742460 mov r14, qword ptr [rsp + 0x60]
0108db83 eb05 jmp 0x14108db8a
0108db85 bfceffffff mov edi, 0xffffffce
0108db8a 8bc7 mov eax, edi
0108db8c 83ffd5 cmp edi, -0x2b
0108db8f 0f84d61a0000 je 0x14108f66b
0108db95 85c0 test eax, eax
0108db97 0f85ce1a0000 jne 0x14108f66b
0108db9d 4c8b7c2458 mov r15, qword ptr [rsp + 0x58]
0108dba2 4181bf8000000074616474 cmp dword ptr [r15 + 0x80], 0x74646174
0108dbad 752a jne 0x14108dbd9
0108dbaf 41ff879c000000 inc dword ptr [r15 + 0x9c]
0108dbb6 4183bf9c00000001 cmp dword ptr [r15 + 0x9c], 1
0108dbbe 7519 jne 0x14108dbd9
0108dbc0 498b07 mov rax, qword ptr [r15]
0108dbc3 4c89642420 mov qword ptr [rsp + 0x20], r12
0108dbc8 4533c9 xor r9d, r9d
0108dbcb 4d8bc7 mov r8, r15
0108dbce ba43426474 mov edx, 0x74644243
0108dbd3 498bcf mov rcx, r15
0108dbd6 ff5008 call qword ptr [rax + 8]
0108dbd9 498b9fe8200000 mov rbx, qword ptr [r15 + 0x20e8]
0108dbe0 4883c350 add rbx, 0x50
0108dbe4 0f84481a0000 je 0x14108f632
0108dbea 66448923 mov word ptr [rbx], r12w
0108dbee 4d85ed test r13, r13
0108dbf1 0f843b1a0000 je 0x14108f632
0108dbf7 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108dbff 0f852d1a0000 jne 0x14108f632
0108dc05 c744243800020000 mov dword ptr [rsp + 0x38], 0x200
0108dc0d 488d442438 lea rax, [rsp + 0x38]
0108dc12 4889442420 mov qword ptr [rsp + 0x20], rax
0108dc17 4c8bcb mov r9, rbx
0108dc1a 41b86d616e61 mov r8d, 0x616e616d
0108dc20 8bd6 mov edx, esi
0108dc22 498bcd mov rcx, r13
0108dc25 e856bd0c00 call 0x141159980
0108dc2a 8bf8 mov edi, eax
0108dc2c 85c0 test eax, eax
0108dc2e 752a jne 0x14108dc5a
0108dc30 4439642438 cmp dword ptr [rsp + 0x38], r12d
0108dc35 7504 jne 0x14108dc3b
0108dc37 66448923 mov word ptr [rbx], r12w
0108dc3b 0fb703 movzx eax, word ptr [rbx]
0108dc3e 6685c0 test ax, ax
0108dc41 740f je 0x14108dc52
0108dc43 66c1c808 ror ax, 8
0108dc47 668903 mov word ptr [rbx], ax
0108dc4a 488bcb mov rcx, rbx
0108dc4d e80e7fa5ff call 0x140ae5b60
0108dc52 488bcb mov rcx, rbx
0108dc55 e83698a5ff call 0x140ae7490
0108dc5a 85ff test edi, edi
0108dc5c 0f85d5190000 jne 0x14108f637
0108dc62 498b9fe8200000 mov rbx, qword ptr [r15 + 0x20e8]
0108dc69 4881c350020000 add rbx, 0x250
0108dc70 0f84bc190000 je 0x14108f632
0108dc76 66448923 mov word ptr [rbx], r12w
0108dc7a 4d85ed test r13, r13
0108dc7d 0f84af190000 je 0x14108f632
0108dc83 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108dc8b 0f85a1190000 jne 0x14108f632
0108dc91 c744243800020000 mov dword ptr [rsp + 0x38], 0x200
0108dc99 488d442438 lea rax, [rsp + 0x38]
0108dc9e 4889442420 mov qword ptr [rsp + 0x20], rax
0108dca3 4c8bcb mov r9, rbx
0108dca6 41b868747561 mov r8d, 0x61757468
0108dcac 8bd6 mov edx, esi
0108dcae 498bcd mov rcx, r13
0108dcb1 e8cabc0c00 call 0x141159980
0108dcb6 8bf8 mov edi, eax
0108dcb8 85c0 test eax, eax
0108dcba 752a jne 0x14108dce6
0108dcbc 4439642438 cmp dword ptr [rsp + 0x38], r12d
0108dcc1 7504 jne 0x14108dcc7
0108dcc3 66448923 mov word ptr [rbx], r12w
0108dcc7 0fb703 movzx eax, word ptr [rbx]
0108dcca 6685c0 test ax, ax
0108dccd 740f je 0x14108dcde
0108dccf 66c1c808 ror ax, 8
0108dcd3 668903 mov word ptr [rbx], ax
0108dcd6 488bcb mov rcx, rbx
0108dcd9 e8827ea5ff call 0x140ae5b60
0108dcde 488bcb mov rcx, rbx
0108dce1 e8aa97a5ff call 0x140ae7490
0108dce6 85ff test edi, edi
0108dce8 0f8549190000 jne 0x14108f637
0108dcee 498b9fe8200000 mov rbx, qword ptr [r15 + 0x20e8]
0108dcf5 4881c350060000 add rbx, 0x650
0108dcfc 0f8430190000 je 0x14108f632
0108dd02 66448923 mov word ptr [rbx], r12w
0108dd06 4d85ed test r13, r13
0108dd09 0f8423190000 je 0x14108f632
0108dd0f 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108dd17 0f8515190000 jne 0x14108f632
0108dd1d c744243800020000 mov dword ptr [rsp + 0x38], 0x200
0108dd25 488d442438 lea rax, [rsp + 0x38]
0108dd2a 4889442420 mov qword ptr [rsp + 0x20], rax
0108dd2f 4c8bcb mov r9, rbx
0108dd32 41b8706d6f63 mov r8d, 0x636f6d70
0108dd38 8bd6 mov edx, esi
0108dd3a 498bcd mov rcx, r13
0108dd3d e83ebc0c00 call 0x141159980
0108dd42 8bf8 mov edi, eax
0108dd44 85c0 test eax, eax
0108dd46 752a jne 0x14108dd72
0108dd48 4439642438 cmp dword ptr [rsp + 0x38], r12d
0108dd4d 7504 jne 0x14108dd53
0108dd4f 66448923 mov word ptr [rbx], r12w
0108dd53 0fb703 movzx eax, word ptr [rbx]
0108dd56 6685c0 test ax, ax
0108dd59 740f je 0x14108dd6a
0108dd5b 66c1c808 ror ax, 8
0108dd5f 668903 mov word ptr [rbx], ax
0108dd62 488bcb mov rcx, rbx
0108dd65 e8f67da5ff call 0x140ae5b60
0108dd6a 488bcb mov rcx, rbx
0108dd6d e81e97a5ff call 0x140ae7490
0108dd72 85ff test edi, edi
0108dd74 0f85bd180000 jne 0x14108f637
0108dd7a 498b8fe8200000 mov rcx, qword ptr [r15 + 0x20e8]
0108dd81 488d9150020000 lea rdx, [rcx + 0x250]
0108dd88 0fb702 movzx eax, word ptr [rdx]
0108dd8b 41b9ff000000 mov r9d, 0xff
0108dd91 6685c0 test ax, ax
0108dd94 750d jne 0x14108dda3
0108dd96 448be6 mov r12d, esi
0108dd99 66394150 cmp word ptr [rcx + 0x50], ax
0108dd9d 0f84f5000000 je 0x14108de98
0108dda3 4881c180100000 add rcx, 0x1080
0108ddaa 448be6 mov r12d, esi
0108ddad 4885d2 test rdx, rdx
0108ddb0 7452 je 0x14108de04
0108ddb2 4885c9 test rcx, rcx
0108ddb5 744d je 0x14108de04
0108ddb7 448bc0 mov r8d, eax
0108ddba 4883c202 add rdx, 2
0108ddbe 413bc1 cmp eax, r9d
0108ddc1 7610 jbe 0x14108ddd3
0108ddc3 66448909 mov word ptr [rcx], r9w
0108ddc7 4883c102 add rcx, 2
0108ddcb 41b8fe000000 mov r8d, 0xfe
0108ddd1 eb0d jmp 0x14108dde0
0108ddd3 668901 mov word ptr [rcx], ax
0108ddd6 4883c102 add rcx, 2
0108ddda 4183e801 sub r8d, 1
0108ddde 7824 js 0x14108de04
0108dde0 448be6 mov r12d, esi
0108dde3 0f1f4000 nop dword ptr [rax]
0108dde7 660f1f840000000000 nop word ptr [rax + rax]
0108ddf0 0fb702 movzx eax, word ptr [rdx]
0108ddf3 488d5202 lea rdx, [rdx + 2]
0108ddf7 668901 mov word ptr [rcx], ax
0108ddfa 488d4902 lea rcx, [rcx + 2]
0108ddfe 4183e801 sub r8d, 1
0108de02 79ec jns 0x14108ddf0
0108de04 498b97e8200000 mov rdx, qword ptr [r15 + 0x20e8]
0108de0b 4881c280100000 add rdx, 0x1080
0108de12 66833a00 cmp word ptr [rdx], 0
0108de16 7412 je 0x14108de2a
0108de18 488d0d190ba900 lea rcx, [rip + 0xa90b19]
0108de1f e87c76a5ff call 0x140ae54a0
0108de24 41b9ff000000 mov r9d, 0xff
0108de2a 498b87e8200000 mov rax, qword ptr [r15 + 0x20e8]
0108de31 4c8d9080100000 lea r10, [rax + 0x1080]
0108de38 4c8d4050 lea r8, [rax + 0x50]
0108de3c 4d85c0 test r8, r8
0108de3f 7457 je 0x14108de98
0108de41 4d85d2 test r10, r10
0108de44 7452 je 0x14108de98
0108de46 410fb70a movzx ecx, word ptr [r10]
0108de4a 450fb718 movzx r11d, word ptr [r8]
0108de4e 4403d9 add r11d, ecx
0108de51 453bd9 cmp r11d, r9d
0108de54 450f47d9 cmova r11d, r9d
0108de58 4983c002 add r8, 2
0108de5c 458bcb mov r9d, r11d
0108de5f 49ffc1 inc r9
0108de62 4f8d0c4a lea r9, [r10 + r9*2]
0108de66 498d5202 lea rdx, [r10 + 2]
0108de6a 488d144a lea rdx, [rdx + rcx*2]
0108de6e 493bd1 cmp rdx, r9
0108de71 7321 jae 0x14108de94
0108de73 0f1f4000 nop dword ptr [rax]
0108de77 660f1f840000000000 nop word ptr [rax + rax]
0108de80 410fb700 movzx eax, word ptr [r8]
0108de84 4d8d4002 lea r8, [r8 + 2]
0108de88 668902 mov word ptr [rdx], ax
0108de8b 4883c202 add rdx, 2
0108de8f 493bd1 cmp rdx, r9
0108de92 72ec jb 0x14108de80
0108de94 6645891a mov word ptr [r10], r11w
0108de98 498b97e8200000 mov rdx, qword ptr [r15 + 0x20e8]
0108de9f 4883c250 add rdx, 0x50
0108dea3 66833a00 cmp word ptr [rdx], 0
0108dea7 7408 je 0x14108deb1
0108dea9 498bce mov rcx, r14
0108deac e86f2de6ff call 0x140ef0c20
0108deb1 498b9fe8200000 mov rbx, qword ptr [r15 + 0x20e8]
0108deb8 4881c350080000 add rbx, 0x850
0108debf 0f846d170000 je 0x14108f632
0108dec5 33f6 xor esi, esi
0108dec7 668933 mov word ptr [rbx], si
0108deca 4d85ed test r13, r13
0108decd 0f84fd030000 je 0x14108e2d0
0108ded3 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108dedb 0f85ef030000 jne 0x14108e2d0
0108dee1 c744243800020000 mov dword ptr [rsp + 0x38], 0x200
0108dee9 488d442438 lea rax, [rsp + 0x38]
0108deee 4889442420 mov qword ptr [rsp + 0x20], rax
0108def3 4c8bcb mov r9, rbx
0108def6 41b865726e67 mov r8d, 0x676e7265
0108defc 418bd4 mov edx, r12d
0108deff 498bcd mov rcx, r13
0108df02 e879ba0c00 call 0x141159980
0108df07 8bf8 mov edi, eax
0108df09 85c0 test eax, eax
0108df0b 7528 jne 0x14108df35
0108df0d 39742438 cmp dword ptr [rsp + 0x38], esi
0108df11 7503 jne 0x14108df16
0108df13 668933 mov word ptr [rbx], si
0108df16 0fb703 movzx eax, word ptr [rbx]
0108df19 6685c0 test ax, ax
0108df1c 740f je 0x14108df2d
0108df1e 66c1c808 ror ax, 8
0108df22 668903 mov word ptr [rbx], ax
0108df25 488bcb mov rcx, rbx
0108df28 e8337ca5ff call 0x140ae5b60
0108df2d 488bcb mov rcx, rbx
0108df30 e85b95a5ff call 0x140ae7490
0108df35 85ff test edi, edi
0108df37 0f85fc160000 jne 0x14108f639
0108df3d 4d85ed test r13, r13
0108df40 0f84ec160000 je 0x14108f632
0108df46 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108df4e 0f85de160000 jne 0x14108f632
0108df54 33db xor ebx, ebx
0108df56 c744243804000000 mov dword ptr [rsp + 0x38], 4
0108df5e 488d442438 lea rax, [rsp + 0x38]
0108df63 4889442420 mov qword ptr [rsp + 0x20], rax
0108df68 4c8d4c2440 lea r9, [rsp + 0x40]
0108df6d 41b872616579 mov r8d, 0x79656172
0108df73 418bd4 mov edx, r12d
0108df76 498bcd mov rcx, r13
0108df79 e802ba0c00 call 0x141159980
0108df7e 8bf8 mov edi, eax
0108df80 85c0 test eax, eax
0108df82 7531 jne 0x14108dfb5
0108df84 395c2438 cmp dword ptr [rsp + 0x38], ebx
0108df88 742b je 0x14108dfb5
0108df8a 40b601 mov sil, 1
0108df8d 8b4c2440 mov ecx, dword ptr [rsp + 0x40]
0108df91 8bd9 mov ebx, ecx
0108df93 81e30000ff00 and ebx, 0xff0000
0108df99 8bc1 mov eax, ecx
0108df9b c1e810 shr eax, 0x10
0108df9e 0bd8 or ebx, eax
0108dfa0 c1eb08 shr ebx, 8
0108dfa3 8bc1 mov eax, ecx
0108dfa5 c1e010 shl eax, 0x10
0108dfa8 81e100ff0000 and ecx, 0xff00
0108dfae 0bc1 or eax, ecx
0108dfb0 c1e008 shl eax, 8
0108dfb3 0bd8 or ebx, eax
0108dfb5 85ff test edi, edi
0108dfb7 0f857a160000 jne 0x14108f637
0108dfbd 4080fe01 cmp sil, 1
0108dfc1 750d jne 0x14108dfd0
0108dfc3 498b87e8200000 mov rax, qword ptr [r15 + 0x20e8]
0108dfca 8998500a0000 mov dword ptr [rax + 0xa50], ebx
0108dfd0 4032f6 xor sil, sil
0108dfd3 4d85ed test r13, r13
0108dfd6 0f8456160000 je 0x14108f632
0108dfdc 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108dfe4 0f8548160000 jne 0x14108f632
0108dfea 33db xor ebx, ebx
0108dfec c744243804000000 mov dword ptr [rsp + 0x38], 4
0108dff4 488d442438 lea rax, [rsp + 0x38]
0108dff9 4889442420 mov qword ptr [rsp + 0x20], rax
0108dffe 4c8d4c2440 lea r9, [rsp + 0x40]
0108e003 41b86d756e64 mov r8d, 0x646e756d
0108e009 418bd4 mov edx, r12d
0108e00c 498bcd mov rcx, r13
0108e00f e86cb90c00 call 0x141159980
0108e014 8bf8 mov edi, eax
0108e016 85c0 test eax, eax
0108e018 7531 jne 0x14108e04b
0108e01a 395c2438 cmp dword ptr [rsp + 0x38], ebx
0108e01e 742b je 0x14108e04b
0108e020 40b601 mov sil, 1
0108e023 8b4c2440 mov ecx, dword ptr [rsp + 0x40]
0108e027 8bd9 mov ebx, ecx
0108e029 81e30000ff00 and ebx, 0xff0000
0108e02f 8bc1 mov eax, ecx
0108e031 c1e810 shr eax, 0x10
0108e034 0bd8 or ebx, eax
0108e036 c1eb08 shr ebx, 8
0108e039 8bc1 mov eax, ecx
0108e03b c1e010 shl eax, 0x10
0108e03e 81e100ff0000 and ecx, 0xff00
0108e044 0bc1 or eax, ecx
0108e046 c1e008 shl eax, 8
0108e049 0bd8 or ebx, eax
0108e04b 85ff test edi, edi
0108e04d 0f85e4150000 jne 0x14108f637
0108e053 4080fe01 cmp sil, 1
0108e057 750e jne 0x14108e067
0108e059 498b87e8200000 mov rax, qword ptr [r15 + 0x20e8]
0108e060 66899874100000 mov word ptr [rax + 0x1074], bx
0108e067 4032f6 xor sil, sil
0108e06a 4d85ed test r13, r13
0108e06d 0f84bf150000 je 0x14108f632
0108e073 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108e07b 0f85b1150000 jne 0x14108f632
0108e081 33db xor ebx, ebx
0108e083 c744243804000000 mov dword ptr [rsp + 0x38], 4
0108e08b 488d442438 lea rax, [rsp + 0x38]
0108e090 4889442420 mov qword ptr [rsp + 0x20], rax
0108e095 4c8d4c2440 lea r9, [rsp + 0x40]
0108e09a 41b8746e6364 mov r8d, 0x64636e74
0108e0a0 418bd4 mov edx, r12d
0108e0a3 498bcd mov rcx, r13
0108e0a6 e8d5b80c00 call 0x141159980
0108e0ab 8bf8 mov edi, eax
0108e0ad 85c0 test eax, eax
0108e0af 7531 jne 0x14108e0e2
0108e0b1 395c2438 cmp dword ptr [rsp + 0x38], ebx
0108e0b5 742b je 0x14108e0e2
0108e0b7 40b601 mov sil, 1
0108e0ba 8b4c2440 mov ecx, dword ptr [rsp + 0x40]
0108e0be 8bd9 mov ebx, ecx
0108e0c0 81e30000ff00 and ebx, 0xff0000
0108e0c6 8bc1 mov eax, ecx
0108e0c8 c1e810 shr eax, 0x10
0108e0cb 0bd8 or ebx, eax
0108e0cd c1eb08 shr ebx, 8
0108e0d0 8bc1 mov eax, ecx
0108e0d2 c1e010 shl eax, 0x10
0108e0d5 81e100ff0000 and ecx, 0xff00
0108e0db 0bc1 or eax, ecx
0108e0dd c1e008 shl eax, 8
0108e0e0 0bd8 or ebx, eax
0108e0e2 85ff test edi, edi
0108e0e4 0f854d150000 jne 0x14108f637
0108e0ea 4080fe01 cmp sil, 1
0108e0ee 750e jne 0x14108e0fe
0108e0f0 498b87e8200000 mov rax, qword ptr [r15 + 0x20e8]
0108e0f7 66899876100000 mov word ptr [rax + 0x1076], bx
0108e0fe 4032f6 xor sil, sil
0108e101 4d85ed test r13, r13
0108e104 0f8428150000 je 0x14108f632
0108e10a 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108e112 0f851a150000 jne 0x14108f632
0108e118 33db xor ebx, ebx
0108e11a c744243804000000 mov dword ptr [rsp + 0x38], 4
0108e122 488d442438 lea rax, [rsp + 0x38]
0108e127 4889442420 mov qword ptr [rsp + 0x20], rax
0108e12c 4c8d4c2440 lea r9, [rsp + 0x40]
0108e131 41b86c706d63 mov r8d, 0x636d706c
0108e137 418bd4 mov edx, r12d
0108e13a 498bcd mov rcx, r13
0108e13d e83eb80c00 call 0x141159980
0108e142 8bf8 mov edi, eax
0108e144 85c0 test eax, eax
0108e146 7531 jne 0x14108e179
0108e148 395c2438 cmp dword ptr [rsp + 0x38], ebx
0108e14c 742b je 0x14108e179
0108e14e 40b601 mov sil, 1
0108e151 8b4c2440 mov ecx, dword ptr [rsp + 0x40]
0108e155 8bd9 mov ebx, ecx
0108e157 81e30000ff00 and ebx, 0xff0000
0108e15d 8bc1 mov eax, ecx
0108e15f c1e810 shr eax, 0x10
0108e162 0bd8 or ebx, eax
0108e164 c1eb08 shr ebx, 8
0108e167 8bc1 mov eax, ecx
0108e169 c1e010 shl eax, 0x10
0108e16c 81e100ff0000 and ecx, 0xff00
0108e172 0bc1 or eax, ecx
0108e174 c1e008 shl eax, 8
0108e177 0bd8 or ebx, eax
0108e179 85ff test edi, edi
0108e17b 0f85b6140000 jne 0x14108f637
0108e181 4080fe01 cmp sil, 1
0108e185 7512 jne 0x14108e199
0108e187 85db test ebx, ebx
0108e189 0f95c1 setne cl
0108e18c 498b87e8200000 mov rax, qword ptr [r15 + 0x20e8]
0108e193 888871100000 mov byte ptr [rax + 0x1071], cl
0108e199 4032f6 xor sil, sil
0108e19c 4d85ed test r13, r13
0108e19f 0f848d140000 je 0x14108f632
0108e1a5 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108e1ad 0f857f140000 jne 0x14108f632
0108e1b3 33db xor ebx, ebx
0108e1b5 895c2444 mov dword ptr [rsp + 0x44], ebx
0108e1b9 c744243804000000 mov dword ptr [rsp + 0x38], 4
0108e1c1 488d442438 lea rax, [rsp + 0x38]
0108e1c6 4889442420 mov qword ptr [rsp + 0x20], rax
0108e1cb 4c8d4c2440 lea r9, [rsp + 0x40]
0108e1d0 41b861706167 mov r8d, 0x67617061
0108e1d6 418bd4 mov edx, r12d
0108e1d9 498bcd mov rcx, r13
0108e1dc e89fb70c00 call 0x141159980
0108e1e1 8bf8 mov edi, eax
0108e1e3 85c0 test eax, eax
0108e1e5 7535 jne 0x14108e21c
0108e1e7 395c2438 cmp dword ptr [rsp + 0x38], ebx
0108e1eb 742f je 0x14108e21c
0108e1ed 40b601 mov sil, 1
0108e1f0 8b4c2440 mov ecx, dword ptr [rsp + 0x40]
0108e1f4 8bd9 mov ebx, ecx
0108e1f6 81e30000ff00 and ebx, 0xff0000
0108e1fc 8bc1 mov eax, ecx
0108e1fe c1e810 shr eax, 0x10
0108e201 0bd8 or ebx, eax
0108e203 c1eb08 shr ebx, 8
0108e206 8bc1 mov eax, ecx
0108e208 c1e010 shl eax, 0x10
0108e20b 81e100ff0000 and ecx, 0xff00
0108e211 0bc1 or eax, ecx
0108e213 c1e008 shl eax, 8
0108e216 0bd8 or ebx, eax
0108e218 895c2444 mov dword ptr [rsp + 0x44], ebx
0108e21c 85ff test edi, edi
0108e21e 0f8513140000 jne 0x14108f637
0108e224 4080fe01 cmp sil, 1
0108e228 7512 jne 0x14108e23c
0108e22a 85db test ebx, ebx
0108e22c 0f95c1 setne cl
0108e22f 498b87e8200000 mov rax, qword ptr [r15 + 0x20e8]
0108e236 888872100000 mov byte ptr [rax + 0x1072], cl
0108e23c 498b9fe8200000 mov rbx, qword ptr [r15 + 0x20e8]
0108e243 4881c35c0a0000 add rbx, 0xa5c
0108e24a 0f84e2130000 je 0x14108f632
0108e250 33f6 xor esi, esi
0108e252 668933 mov word ptr [rbx], si
0108e255 4d85ed test r13, r13
0108e258 7476 je 0x14108e2d0
0108e25a 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108e262 756c jne 0x14108e2d0
0108e264 c744243800020000 mov dword ptr [rsp + 0x38], 0x200
0108e26c 488d442438 lea rax, [rsp + 0x38]
0108e271 4889442420 mov qword ptr [rsp + 0x20], rax
0108e276 4c8bcb mov r9, rbx
0108e279 41b86469656d mov r8d, 0x6d656964
0108e27f 418bd4 mov edx, r12d
0108e282 498bcd mov rcx, r13
0108e285 e8f6b60c00 call 0x141159980
0108e28a 8bf8 mov edi, eax
0108e28c 85c0 test eax, eax
0108e28e 7528 jne 0x14108e2b8
0108e290 39742438 cmp dword ptr [rsp + 0x38], esi
0108e294 7503 jne 0x14108e299
0108e296 668933 mov word ptr [rbx], si
0108e299 0fb703 movzx eax, word ptr [rbx]
0108e29c 6685c0 test ax, ax
0108e29f 740f je 0x14108e2b0
0108e2a1 66c1c808 ror ax, 8
0108e2a5 668903 mov word ptr [rbx], ax
0108e2a8 488bcb mov rcx, rbx
0108e2ab e8b078a5ff call 0x140ae5b60
0108e2b0 488bcb mov rcx, rbx
0108e2b3 e8d891a5ff call 0x140ae7490
0108e2b8 85ff test edi, edi
0108e2ba 0f8579130000 jne 0x14108f639
0108e2c0 498b9fe8200000 mov rbx, qword ptr [r15 + 0x20e8]
0108e2c7 4881c35c0c0000 add rbx, 0xc5c
0108e2ce 750a jne 0x14108e2da
0108e2d0 bfceffffff mov edi, 0xffffffce
0108e2d5 e95f130000 jmp 0x14108f639
0108e2da 668933 mov word ptr [rbx], si
0108e2dd 4d85ed test r13, r13
0108e2e0 74ee je 0x14108e2d0
0108e2e2 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108e2ea 75e4 jne 0x14108e2d0
0108e2ec c744243800020000 mov dword ptr [rsp + 0x38], 0x200
0108e2f4 488d442438 lea rax, [rsp + 0x38]
0108e2f9 4889442420 mov qword ptr [rsp + 0x20], rax
0108e2fe 4c8bcb mov r9, rbx
0108e301 41b86469756d mov r8d, 0x6d756964
0108e307 418bd4 mov edx, r12d
0108e30a 498bcd mov rcx, r13
0108e30d e86eb60c00 call 0x141159980
0108e312 8bf8 mov edi, eax
0108e314 85c0 test eax, eax
0108e316 7528 jne 0x14108e340
0108e318 39742438 cmp dword ptr [rsp + 0x38], esi
0108e31c 7503 jne 0x14108e321
0108e31e 668933 mov word ptr [rbx], si
0108e321 0fb703 movzx eax, word ptr [rbx]
0108e324 6685c0 test ax, ax
0108e327 740f je 0x14108e338
0108e329 66c1c808 ror ax, 8
0108e32d 668903 mov word ptr [rbx], ax
0108e330 488bcb mov rcx, rbx
0108e333 e82878a5ff call 0x140ae5b60
0108e338 488bcb mov rcx, rbx
0108e33b e85091a5ff call 0x140ae7490
0108e340 85ff test edi, edi
0108e342 0f85f1120000 jne 0x14108f639
0108e348 498b87e8200000 mov rax, qword ptr [r15 + 0x20e8]
0108e34f 6639b05c0a0000 cmp word ptr [rax + 0xa5c], si
0108e356 740e je 0x14108e366
0108e358 6639b05c0c0000 cmp word ptr [rax + 0xc5c], si
0108e35f c644244c40 mov byte ptr [rsp + 0x4c], 0x40
0108e364 7505 jne 0x14108e36b
0108e366 408874244c mov byte ptr [rsp + 0x4c], sil
0108e36b 498b4670 mov rax, qword ptr [r14 + 0x70]
0108e36f 4885c0 test rax, rax
0108e372 0f84cf100000 je 0x14108f447
0108e378 8b7064 mov esi, dword ptr [rax + 0x64]
0108e37b 89742450 mov dword ptr [rsp + 0x50], esi
0108e37f 33db xor ebx, ebx
0108e381 8bc3 mov eax, ebx
0108e383 895c2448 mov dword ptr [rsp + 0x48], ebx
0108e387 85f6 test esi, esi
0108e389 0f84bc100000 je 0x14108f44b
0108e38f 89742450 mov dword ptr [rsp + 0x50], esi
0108e393 f30f1035394cbe00 movss xmm6, dword ptr [rip + 0xbe4c39]
0108e39b f30f103d854ebe00 movss xmm7, dword ptr [rip + 0xbe4e85]
0108e3a3 f3440f1005ac5fbe00 movss xmm8, dword ptr [rip + 0xbe5fac]
0108e3ac 0f1f4000 nop dword ptr [rax]
0108e3b0 448bc8 mov r9d, eax
0108e3b3 4533c0 xor r8d, r8d
0108e3b6 ba73000000 mov edx, 0x73
0108e3bb 498b8e08040000 mov rcx, qword ptr [r14 + 0x408]
0108e3c2 e8f98aedff call 0x140f66ec0
0108e3c7 4c8bf0 mov r14, rax
0108e3ca 4885c0 test rax, rax
0108e3cd 0f84fb0f0000 je 0x14108f3ce
0108e3d3 488bc8 mov rcx, rax
0108e3d6 e8e5f2f2ff call 0x140fbd6c0
0108e3db 84c0 test al, al
0108e3dd 0f85eb0f0000 jne 0x14108f3ce
0108e3e3 498b06 mov rax, qword ptr [r14]
0108e3e6 4885c0 test rax, rax
0108e3e9 744c je 0x14108e437
0108e3eb 813874736c70 cmp dword ptr [rax], 0x706c7374
0108e3f1 7544 jne 0x14108e437
0108e3f3 41837e2800 cmp dword ptr [r14 + 0x28], 0
0108e3f8 743d je 0x14108e437
0108e3fa 498b4630 mov rax, qword ptr [r14 + 0x30]
0108e3fe 4885c0 test rax, rax
0108e401 7434 je 0x14108e437
0108e403 4883781000 cmp qword ptr [rax + 0x10], 0
0108e408 742d je 0x14108e437
0108e40a 4c8b7858 mov r15, qword ptr [rax + 0x58]
0108e40e 4d85ff test r15, r15
0108e411 7427 je 0x14108e43a
0108e413 498b4708 mov rax, qword ptr [r15 + 8]
0108e417 4885c0 test rax, rax
0108e41a 7411 je 0x14108e42d
0108e41c 4883781000 cmp qword ptr [rax + 0x10], 0
0108e421 740a je 0x14108e42d
0108e423 41817f3444524853 cmp dword ptr [r15 + 0x34], 0x53485244
0108e42b 750d jne 0x14108e43a
0108e42d 4d8b3f mov r15, qword ptr [r15]
0108e430 4d85ff test r15, r15
0108e433 75de jne 0x14108e413
0108e435 eb03 jmp 0x14108e43a
0108e437 4c8bfb mov r15, rbx
0108e43a 8b742448 mov esi, dword ptr [rsp + 0x48]
0108e43e 448d4601 lea r8d, [rsi + 1]
0108e442 66895da0 mov word ptr [rbp - 0x60], bx
0108e446 32db xor bl, bl
0108e448 4d85ed test r13, r13
0108e44b 0f84e1110000 je 0x14108f632
0108e451 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108e459 0f85d3110000 jne 0x14108f632
0108e45f c744243400020000 mov dword ptr [rsp + 0x34], 0x200
0108e467 488d442434 lea rax, [rsp + 0x34]
0108e46c 418bd4 mov edx, r12d
0108e46f 498bcd mov rcx, r13
0108e472 4585c0 test r8d, r8d
0108e475 0f84a5000000 je 0x14108e520
0108e47b 4889442428 mov qword ptr [rsp + 0x28], rax
0108e480 488d45a0 lea rax, [rbp - 0x60]
0108e484 4889442420 mov qword ptr [rsp + 0x20], rax
0108e489 41b96d616e74 mov r9d, 0x746e616d
0108e48f e8fcbd0c00 call 0x14115a290
0108e494 8bf8 mov edi, eax
0108e496 85c0 test eax, eax
0108e498 7535 jne 0x14108e4cf
0108e49a 39442434 cmp dword ptr [rsp + 0x34], eax
0108e49e 7402 je 0x14108e4a2
0108e4a0 b301 mov bl, 1
0108e4a2 0fb74da0 movzx ecx, word ptr [rbp - 0x60]
0108e4a6 6685c9 test cx, cx
0108e4a9 741b je 0x14108e4c6
0108e4ab 0fb7c1 movzx eax, cx
0108e4ae 66c1e808 shr ax, 8
0108e4b2 66c1e108 shl cx, 8
0108e4b6 660bc1 or ax, cx
0108e4b9 668945a0 mov word ptr [rbp - 0x60], ax
0108e4bd 488d4da0 lea rcx, [rbp - 0x60]
0108e4c1 e89a76a5ff call 0x140ae5b60
0108e4c6 488d4da0 lea rcx, [rbp - 0x60]
0108e4ca e8c18fa5ff call 0x140ae7490
0108e4cf 85ff test edi, edi
0108e4d1 0f8560110000 jne 0x14108f637
0108e4d7 80fb01 cmp bl, 1
0108e4da 0f850c010000 jne 0x14108e5ec
0108e4e0 498b5e30 mov rbx, qword ptr [r14 + 0x30]
0108e4e4 4885db test rbx, rbx
0108e4e7 0f84db000000 je 0x14108e5c8
0108e4ed 4c8b5310 mov r10, qword ptr [rbx + 0x10]
0108e4f1 4d85d2 test r10, r10
0108e4f4 0f84ce000000 je 0x14108e5c8
0108e4fa 4c8d8bb0000000 lea r9, [rbx + 0xb0]
0108e501 4981c278010000 add r10, 0x178
0108e508 0fb745a0 movzx eax, word ptr [rbp - 0x60]
0108e50c b9ff000000 mov ecx, 0xff
0108e511 663bc1 cmp ax, cx
0108e514 7639 jbe 0x14108e54f
0108e516 33c0 xor eax, eax
0108e518 418901 mov dword ptr [r9], eax
0108e51b e99e000000 jmp 0x14108e5be
0108e520 4889442420 mov qword ptr [rsp + 0x20], rax
0108e525 4c8d4da0 lea r9, [rbp - 0x60]
0108e529 41b86d616e74 mov r8d, 0x746e616d
0108e52f e84cb40c00 call 0x141159980
0108e534 8bf8 mov edi, eax
0108e536 85c0 test eax, eax
0108e538 7595 jne 0x14108e4cf
0108e53a 39442434 cmp dword ptr [rsp + 0x34], eax
0108e53e 0f855cffffff jne 0x14108e4a0
0108e544 33c0 xor eax, eax
0108e546 668945a0 mov word ptr [rbp - 0x60], ax
0108e54a e977ffffff jmp 0x14108e4c6
0108e54f 448bc0 mov r8d, eax
0108e552 4503c0 add r8d, r8d
0108e555 4d85d2 test r10, r10
0108e558 7464 je 0x14108e5be
0108e55a 41813a63727473 cmp dword ptr [r10], 0x73747263
0108e561 755b jne 0x14108e5be
0108e563 41837a2800 cmp dword ptr [r10 + 0x28], 0
0108e568 7554 jne 0x14108e5be
0108e56a 496311 movsxd rdx, dword ptr [r9]
0108e56d 41837a3c00 cmp dword ptr [r10 + 0x3c], 0
0108e572 754a jne 0x14108e5be
0108e574 85d2 test edx, edx
0108e576 743a je 0x14108e5b2
0108e578 418b4204 mov eax, dword ptr [r10 + 4]
0108e57c 83e001 and eax, 1
0108e57f 85d2 test edx, edx
0108e581 7e3b jle 0x14108e5be
0108e583 413b522c cmp edx, dword ptr [r10 + 0x2c]
0108e587 7f35 jg 0x14108e5be
0108e589 84c0 test al, al
0108e58b 740e je 0x14108e59b
0108e58d 498b4218 mov rax, qword ptr [r10 + 0x18]
0108e591 488b00 mov rax, qword ptr [rax]
0108e594 836c90fc01 sub dword ptr [rax + rdx*4 - 4], 1
0108e599 7517 jne 0x14108e5b2
0108e59b 498b4210 mov rax, qword ptr [r10 + 0x10]
0108e59f 488b08 mov rcx, qword ptr [rax]
0108e5a2 8b44d1fc mov eax, dword ptr [rcx + rdx*8 - 4]
0108e5a6 41014240 add dword ptr [r10 + 0x40], eax
0108e5aa c744d1f801000080 mov dword ptr [rcx + rdx*8 - 8], 0x80000001
0108e5b2 488d55a2 lea rdx, [rbp - 0x5e]
0108e5b6 498bca mov rcx, r10
0108e5b9 e832fcb6ff call 0x140bfe1f0
0108e5be 33d2 xor edx, edx
0108e5c0 488bcb mov rcx, rbx
0108e5c3 e8b895e3ff call 0x140ec7b80
0108e5c8 0f57c0 xorps xmm0, xmm0
0108e5cb 0f11442478 movups xmmword ptr [rsp + 0x78], xmm0
0108e5d0 0f114588 movups xmmword ptr [rbp - 0x78], xmm0
0108e5d4 c644247820 mov byte ptr [rsp + 0x78], 0x20
0108e5d9 804d8102 or byte ptr [rbp - 0x7f], 2
0108e5dd 4c8d442478 lea r8, [rsp + 0x78]
0108e5e2 33d2 xor edx, edx
0108e5e4 488bcb mov rcx, rbx
0108e5e7 e8945bf0ff call 0x140f94180
0108e5ec 448d4601 lea r8d, [rsi + 1]
0108e5f0 33f6 xor esi, esi
0108e5f2 668975a0 mov word ptr [rbp - 0x60], si
0108e5f6 32db xor bl, bl
0108e5f8 4d85ed test r13, r13
0108e5fb 0f84cffcffff je 0x14108e2d0
0108e601 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108e609 0f85c1fcffff jne 0x14108e2d0
0108e60f c744243400020000 mov dword ptr [rsp + 0x34], 0x200
0108e617 488d442434 lea rax, [rsp + 0x34]
0108e61c 418bd4 mov edx, r12d
0108e61f 498bcd mov rcx, r13
0108e622 4585c0 test r8d, r8d
0108e625 0f84b1000000 je 0x14108e6dc
0108e62b 4889442428 mov qword ptr [rsp + 0x28], rax
0108e630 488d45a0 lea rax, [rbp - 0x60]
0108e634 4889442420 mov qword ptr [rsp + 0x20], rax
0108e639 41b96d616e61 mov r9d, 0x616e616d
0108e63f e84cbc0c00 call 0x14115a290
0108e644 8bf8 mov edi, eax
0108e646 85c0 test eax, eax
0108e648 7535 jne 0x14108e67f
0108e64a 39742434 cmp dword ptr [rsp + 0x34], esi
0108e64e 7402 je 0x14108e652
0108e650 b301 mov bl, 1
0108e652 0fb74da0 movzx ecx, word ptr [rbp - 0x60]
0108e656 6685c9 test cx, cx
0108e659 741b je 0x14108e676
0108e65b 0fb7c1 movzx eax, cx
0108e65e 66c1e808 shr ax, 8
0108e662 66c1e108 shl cx, 8
0108e666 660bc1 or ax, cx
0108e669 668945a0 mov word ptr [rbp - 0x60], ax
0108e66d 488d4da0 lea rcx, [rbp - 0x60]
0108e671 e8ea74a5ff call 0x140ae5b60
0108e676 488d4da0 lea rcx, [rbp - 0x60]
0108e67a e8118ea5ff call 0x140ae7490
0108e67f 85ff test edi, edi
0108e681 0f85b20f0000 jne 0x14108f639
0108e687 80fb01 cmp bl, 1
0108e68a 0f8521010000 jne 0x14108e7b1
0108e690 498b5e30 mov rbx, qword ptr [r14 + 0x30]
0108e694 4885db test rbx, rbx
0108e697 0f84e3000000 je 0x14108e780
0108e69d 48397310 cmp qword ptr [rbx + 0x10], rsi
0108e6a1 0f84d9000000 je 0x14108e780
0108e6a7 488b4328 mov rax, qword ptr [rbx + 0x28]
0108e6ab 4885c0 test rax, rax
0108e6ae 7404 je 0x14108e6b4
0108e6b0 806075fe and byte ptr [rax + 0x75], 0xfe
0108e6b4 4c8d8bbc000000 lea r9, [rbx + 0xbc]
0108e6bb 4c8b5310 mov r10, qword ptr [rbx + 0x10]
0108e6bf 4981c2c0010000 add r10, 0x1c0
0108e6c6 0fb745a0 movzx eax, word ptr [rbp - 0x60]
0108e6ca b9ff000000 mov ecx, 0xff
0108e6cf 663bc1 cmp ax, cx
0108e6d2 7635 jbe 0x14108e709
0108e6d4 418931 mov dword ptr [r9], esi
0108e6d7 e99a000000 jmp 0x14108e776
0108e6dc 4889442420 mov qword ptr [rsp + 0x20], rax
0108e6e1 4c8d4da0 lea r9, [rbp - 0x60]
0108e6e5 41b86d616e61 mov r8d, 0x616e616d
0108e6eb e890b20c00 call 0x141159980
0108e6f0 8bf8 mov edi, eax
0108e6f2 85c0 test eax, eax
0108e6f4 7589 jne 0x14108e67f
0108e6f6 39742434 cmp dword ptr [rsp + 0x34], esi
0108e6fa 0f8550ffffff jne 0x14108e650
0108e700 668975a0 mov word ptr [rbp - 0x60], si
0108e704 e96dffffff jmp 0x14108e676
0108e709 448bc0 mov r8d, eax
0108e70c 4503c0 add r8d, r8d
0108e70f 4d85d2 test r10, r10
0108e712 7462 je 0x14108e776
0108e714 41813a63727473 cmp dword ptr [r10], 0x73747263
0108e71b 7559 jne 0x14108e776
0108e71d 41397228 cmp dword ptr [r10 + 0x28], esi
0108e721 7553 jne 0x14108e776
0108e723 496311 movsxd rdx, dword ptr [r9]
0108e726 4139723c cmp dword ptr [r10 + 0x3c], esi
0108e72a 754a jne 0x14108e776
0108e72c 85d2 test edx, edx
0108e72e 743a je 0x14108e76a
0108e730 418b4204 mov eax, dword ptr [r10 + 4]
0108e734 83e001 and eax, 1
0108e737 85d2 test edx, edx
0108e739 7e3b jle 0x14108e776
0108e73b 413b522c cmp edx, dword ptr [r10 + 0x2c]
0108e73f 7f35 jg 0x14108e776
0108e741 84c0 test al, al
0108e743 740e je 0x14108e753
0108e745 498b4218 mov rax, qword ptr [r10 + 0x18]
0108e749 488b00 mov rax, qword ptr [rax]
0108e74c 836c90fc01 sub dword ptr [rax + rdx*4 - 4], 1
0108e751 7517 jne 0x14108e76a
0108e753 498b4210 mov rax, qword ptr [r10 + 0x10]
0108e757 488b08 mov rcx, qword ptr [rax]
0108e75a 8b44d1fc mov eax, dword ptr [rcx + rdx*8 - 4]
0108e75e 41014240 add dword ptr [r10 + 0x40], eax
0108e762 c744d1f801000080 mov dword ptr [rcx + rdx*8 - 8], 0x80000001
0108e76a 488d55a2 lea rdx, [rbp - 0x5e]
0108e76e 498bca mov rcx, r10
0108e771 e87afab6ff call 0x140bfe1f0
0108e776 33d2 xor edx, edx
0108e778 488bcb mov rcx, rbx
0108e77b e82096e3ff call 0x140ec7da0
0108e780 0f57c0 xorps xmm0, xmm0
0108e783 0f11442478 movups xmmword ptr [rsp + 0x78], xmm0
0108e788 0f114588 movups xmmword ptr [rbp - 0x78], xmm0
0108e78c c644247810 mov byte ptr [rsp + 0x78], 0x10
0108e791 804d8101 or byte ptr [rbp - 0x7f], 1
0108e795 4c8d442478 lea r8, [rsp + 0x78]
0108e79a 33d2 xor edx, edx
0108e79c 488bcb mov rcx, rbx
0108e79f e8dc59f0ff call 0x140f94180
0108e7a4 663975a0 cmp word ptr [rbp - 0x60], si
0108e7a8 488b742458 mov rsi, qword ptr [rsp + 0x58]
0108e7ad 7420 je 0x14108e7cf
0108e7af eb19 jmp 0x14108e7ca
0108e7b1 488b742458 mov rsi, qword ptr [rsp + 0x58]
0108e7b6 488b96e8200000 mov rdx, qword ptr [rsi + 0x20e8]
0108e7bd 4883c250 add rdx, 0x50
0108e7c1 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0108e7c5 e8d68af0ff call 0x140f972a0
0108e7ca c644243c01 mov byte ptr [rsp + 0x3c], 1
0108e7cf 448b442448 mov r8d, dword ptr [rsp + 0x48]
0108e7d4 41ffc0 inc r8d
0108e7d7 33c0 xor eax, eax
0108e7d9 668945a0 mov word ptr [rbp - 0x60], ax
0108e7dd 32db xor bl, bl
0108e7df 4d85ed test r13, r13
0108e7e2 0f844a0e0000 je 0x14108f632
0108e7e8 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108e7f0 0f853c0e0000 jne 0x14108f632
0108e7f6 c744243400020000 mov dword ptr [rsp + 0x34], 0x200
0108e7fe 488d442434 lea rax, [rsp + 0x34]
0108e803 418bd4 mov edx, r12d
0108e806 498bcd mov rcx, r13
0108e809 4585c0 test r8d, r8d
0108e80c 0f841b010000 je 0x14108e92d
0108e812 4889442428 mov qword ptr [rsp + 0x28], rax
0108e817 488d45a0 lea rax, [rbp - 0x60]
0108e81b 4889442420 mov qword ptr [rsp + 0x20], rax
0108e820 41b970757267 mov r9d, 0x67727570
0108e826 e865ba0c00 call 0x14115a290
0108e82b 8bf8 mov edi, eax
0108e82d 85c0 test eax, eax
0108e82f 7535 jne 0x14108e866
0108e831 39442434 cmp dword ptr [rsp + 0x34], eax
0108e835 7402 je 0x14108e839
0108e837 b301 mov bl, 1
0108e839 0fb74da0 movzx ecx, word ptr [rbp - 0x60]
0108e83d 6685c9 test cx, cx
0108e840 741b je 0x14108e85d
0108e842 0fb7c1 movzx eax, cx
0108e845 66c1e808 shr ax, 8
0108e849 66c1e108 shl cx, 8
0108e84d 660bc1 or ax, cx
0108e850 668945a0 mov word ptr [rbp - 0x60], ax
0108e854 488d4da0 lea rcx, [rbp - 0x60]
0108e858 e80373a5ff call 0x140ae5b60
0108e85d 488d4da0 lea rcx, [rbp - 0x60]
0108e861 e82a8ca5ff call 0x140ae7490
0108e866 85ff test edi, edi
0108e868 0f85c90d0000 jne 0x14108f637
0108e86e 80fb01 cmp bl, 1
0108e871 750d jne 0x14108e880
0108e873 488d55a0 lea rdx, [rbp - 0x60]
0108e877 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0108e87b e800a5f0ff call 0x140f98d80
0108e880 448b442448 mov r8d, dword ptr [rsp + 0x48]
0108e885 41ffc0 inc r8d
0108e888 33c0 xor eax, eax
0108e88a 668945a0 mov word ptr [rbp - 0x60], ax
0108e88e 32db xor bl, bl
0108e890 4d85ed test r13, r13
0108e893 0f84990d0000 je 0x14108f632
0108e899 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108e8a1 0f858b0d0000 jne 0x14108f632
0108e8a7 c744243400020000 mov dword ptr [rsp + 0x34], 0x200
0108e8af 488d442434 lea rax, [rsp + 0x34]
0108e8b4 418bd4 mov edx, r12d
0108e8b7 498bcd mov rcx, r13
0108e8ba 4585c0 test r8d, r8d
0108e8bd 0f849d000000 je 0x14108e960
0108e8c3 4889442428 mov qword ptr [rsp + 0x28], rax
0108e8c8 488d45a0 lea rax, [rbp - 0x60]
0108e8cc 4889442420 mov qword ptr [rsp + 0x20], rax
0108e8d1 41b965726e67 mov r9d, 0x676e7265
0108e8d7 e8b4b90c00 call 0x14115a290
0108e8dc 8bf8 mov edi, eax
0108e8de 85c0 test eax, eax
0108e8e0 7535 jne 0x14108e917
0108e8e2 39442434 cmp dword ptr [rsp + 0x34], eax
0108e8e6 7402 je 0x14108e8ea
0108e8e8 b301 mov bl, 1
0108e8ea 0fb74da0 movzx ecx, word ptr [rbp - 0x60]
0108e8ee 6685c9 test cx, cx
0108e8f1 741b je 0x14108e90e
0108e8f3 0fb7c1 movzx eax, cx
0108e8f6 66c1e808 shr ax, 8
0108e8fa 66c1e108 shl cx, 8
0108e8fe 660bc1 or ax, cx
0108e901 668945a0 mov word ptr [rbp - 0x60], ax
0108e905 488d4da0 lea rcx, [rbp - 0x60]
0108e909 e85272a5ff call 0x140ae5b60
0108e90e 488d4da0 lea rcx, [rbp - 0x60]
0108e912 e8798ba5ff call 0x140ae7490
0108e917 85ff test edi, edi
0108e919 0f85180d0000 jne 0x14108f637
0108e91f 498bce mov rcx, r14
0108e922 80fb01 cmp bl, 1
0108e925 7565 jne 0x14108e98c
0108e927 488d55a0 lea rdx, [rbp - 0x60]
0108e92b eb6d jmp 0x14108e99a
0108e92d 4889442420 mov qword ptr [rsp + 0x20], rax
0108e932 4c8d4da0 lea r9, [rbp - 0x60]
0108e936 41b870757267 mov r8d, 0x67727570
0108e93c e83fb00c00 call 0x141159980
0108e941 8bf8 mov edi, eax
0108e943 85c0 test eax, eax
0108e945 0f851bffffff jne 0x14108e866
0108e94b 39442434 cmp dword ptr [rsp + 0x34], eax
0108e94f 0f85e2feffff jne 0x14108e837
0108e955 33c0 xor eax, eax
0108e957 668945a0 mov word ptr [rbp - 0x60], ax
0108e95b e9fdfeffff jmp 0x14108e85d
0108e960 4889442420 mov qword ptr [rsp + 0x20], rax
0108e965 4c8d4da0 lea r9, [rbp - 0x60]
0108e969 41b865726e67 mov r8d, 0x676e7265
0108e96f e80cb00c00 call 0x141159980
0108e974 8bf8 mov edi, eax
0108e976 85c0 test eax, eax
0108e978 759d jne 0x14108e917
0108e97a 39442434 cmp dword ptr [rsp + 0x34], eax
0108e97e 0f8564ffffff jne 0x14108e8e8
0108e984 33c0 xor eax, eax
0108e986 668945a0 mov word ptr [rbp - 0x60], ax
0108e98a eb82 jmp 0x14108e90e
0108e98c 488b96e8200000 mov rdx, qword ptr [rsi + 0x20e8]
0108e993 4881c250080000 add rdx, 0x850
0108e99a 41b001 mov r8b, 1
0108e99d 488b4930 mov rcx, qword ptr [rcx + 0x30]
0108e9a1 e8aae5f0ff call 0x140f9cf50
0108e9a6 448b442448 mov r8d, dword ptr [rsp + 0x48]
0108e9ab 41ffc0 inc r8d
0108e9ae 33c0 xor eax, eax
0108e9b0 668945a0 mov word ptr [rbp - 0x60], ax
0108e9b4 32db xor bl, bl
0108e9b6 4d85ed test r13, r13
0108e9b9 0f84730c0000 je 0x14108f632
0108e9bf 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108e9c7 0f85650c0000 jne 0x14108f632
0108e9cd c744243400020000 mov dword ptr [rsp + 0x34], 0x200
0108e9d5 488d442434 lea rax, [rsp + 0x34]
0108e9da 418bd4 mov edx, r12d
0108e9dd 498bcd mov rcx, r13
0108e9e0 4585c0 test r8d, r8d
0108e9e3 746a je 0x14108ea4f
0108e9e5 4889442428 mov qword ptr [rsp + 0x28], rax
0108e9ea 488d45a0 lea rax, [rbp - 0x60]
0108e9ee 4889442420 mov qword ptr [rsp + 0x20], rax
0108e9f3 41b968747561 mov r9d, 0x61757468
0108e9f9 e892b80c00 call 0x14115a290
0108e9fe 8bf8 mov edi, eax
0108ea00 85c0 test eax, eax
0108ea02 7535 jne 0x14108ea39
0108ea04 39442434 cmp dword ptr [rsp + 0x34], eax
0108ea08 7402 je 0x14108ea0c
0108ea0a b301 mov bl, 1
0108ea0c 0fb74da0 movzx ecx, word ptr [rbp - 0x60]
0108ea10 6685c9 test cx, cx
0108ea13 741b je 0x14108ea30
0108ea15 0fb7c1 movzx eax, cx
0108ea18 66c1e808 shr ax, 8
0108ea1c 66c1e108 shl cx, 8
0108ea20 660bc1 or ax, cx
0108ea23 668945a0 mov word ptr [rbp - 0x60], ax
0108ea27 488d4da0 lea rcx, [rbp - 0x60]
0108ea2b e83071a5ff call 0x140ae5b60
0108ea30 488d4da0 lea rcx, [rbp - 0x60]
0108ea34 e8578aa5ff call 0x140ae7490
0108ea39 85ff test edi, edi
0108ea3b 0f85f60b0000 jne 0x14108f637
0108ea41 498bce mov rcx, r14
0108ea44 80fb01 cmp bl, 1
0108ea47 752e jne 0x14108ea77
0108ea49 488d55a0 lea rdx, [rbp - 0x60]
0108ea4d eb36 jmp 0x14108ea85
0108ea4f 4889442420 mov qword ptr [rsp + 0x20], rax
0108ea54 4c8d4da0 lea r9, [rbp - 0x60]
0108ea58 41b868747561 mov r8d, 0x61757468
0108ea5e e81daf0c00 call 0x141159980
0108ea63 8bf8 mov edi, eax
0108ea65 85c0 test eax, eax
0108ea67 75d0 jne 0x14108ea39
0108ea69 39442434 cmp dword ptr [rsp + 0x34], eax
0108ea6d 759b jne 0x14108ea0a
0108ea6f 33c0 xor eax, eax
0108ea71 668945a0 mov word ptr [rbp - 0x60], ax
0108ea75 ebb9 jmp 0x14108ea30
0108ea77 488b96e8200000 mov rdx, qword ptr [rsi + 0x20e8]
0108ea7e 4881c250020000 add rdx, 0x250
0108ea85 488b4930 mov rcx, qword ptr [rcx + 0x30]
0108ea89 e8b28ef0ff call 0x140f97940
0108ea8e 448b442448 mov r8d, dword ptr [rsp + 0x48]
0108ea93 41ffc0 inc r8d
0108ea96 33c0 xor eax, eax
0108ea98 668945a0 mov word ptr [rbp - 0x60], ax
0108ea9c 32db xor bl, bl
0108ea9e 4d85ed test r13, r13
0108eaa1 0f848b0b0000 je 0x14108f632
0108eaa7 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108eaaf 0f857d0b0000 jne 0x14108f632
0108eab5 c744243400020000 mov dword ptr [rsp + 0x34], 0x200
0108eabd 488d442434 lea rax, [rsp + 0x34]
0108eac2 418bd4 mov edx, r12d
0108eac5 498bcd mov rcx, r13
0108eac8 4585c0 test r8d, r8d
0108eacb 746a je 0x14108eb37
0108eacd 4889442428 mov qword ptr [rsp + 0x28], rax
0108ead2 488d45a0 lea rax, [rbp - 0x60]
0108ead6 4889442420 mov qword ptr [rsp + 0x20], rax
0108eadb 41b9706d6f63 mov r9d, 0x636f6d70
0108eae1 e8aab70c00 call 0x14115a290
0108eae6 8bf8 mov edi, eax
0108eae8 85c0 test eax, eax
0108eaea 7535 jne 0x14108eb21
0108eaec 39442434 cmp dword ptr [rsp + 0x34], eax
0108eaf0 7402 je 0x14108eaf4
0108eaf2 b301 mov bl, 1
0108eaf4 0fb74da0 movzx ecx, word ptr [rbp - 0x60]
0108eaf8 6685c9 test cx, cx
0108eafb 741b je 0x14108eb18
0108eafd 0fb7c1 movzx eax, cx
0108eb00 66c1e808 shr ax, 8
0108eb04 66c1e108 shl cx, 8
0108eb08 660bc1 or ax, cx
0108eb0b 668945a0 mov word ptr [rbp - 0x60], ax
0108eb0f 488d4da0 lea rcx, [rbp - 0x60]
0108eb13 e84870a5ff call 0x140ae5b60
0108eb18 488d4da0 lea rcx, [rbp - 0x60]
0108eb1c e86f89a5ff call 0x140ae7490
0108eb21 85ff test edi, edi
0108eb23 0f850e0b0000 jne 0x14108f637
0108eb29 498bce mov rcx, r14
0108eb2c 80fb01 cmp bl, 1
0108eb2f 752e jne 0x14108eb5f
0108eb31 488d55a0 lea rdx, [rbp - 0x60]
0108eb35 eb36 jmp 0x14108eb6d
0108eb37 4889442420 mov qword ptr [rsp + 0x20], rax
0108eb3c 4c8d4da0 lea r9, [rbp - 0x60]
0108eb40 41b8706d6f63 mov r8d, 0x636f6d70
0108eb46 e835ae0c00 call 0x141159980
0108eb4b 8bf8 mov edi, eax
0108eb4d 85c0 test eax, eax
0108eb4f 75d0 jne 0x14108eb21
0108eb51 39442434 cmp dword ptr [rsp + 0x34], eax
0108eb55 759b jne 0x14108eaf2
0108eb57 33c0 xor eax, eax
0108eb59 668945a0 mov word ptr [rbp - 0x60], ax
0108eb5d ebb9 jmp 0x14108eb18
0108eb5f 488b96e8200000 mov rdx, qword ptr [rsi + 0x20e8]
0108eb66 4881c250060000 add rdx, 0x650
0108eb6d 488b4930 mov rcx, qword ptr [rcx + 0x30]
0108eb71 e8cadbf0ff call 0x140f9c740
0108eb76 8b742448 mov esi, dword ptr [rsp + 0x48]
0108eb7a 448d4601 lea r8d, [rsi + 1]
0108eb7e 33c0 xor eax, eax
0108eb80 668945a0 mov word ptr [rbp - 0x60], ax
0108eb84 32db xor bl, bl
0108eb86 4d85ed test r13, r13
0108eb89 0f84a30a0000 je 0x14108f632
0108eb8f 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108eb97 0f85950a0000 jne 0x14108f632
0108eb9d c744243400020000 mov dword ptr [rsp + 0x34], 0x200
0108eba5 488d442434 lea rax, [rsp + 0x34]
0108ebaa 418bd4 mov edx, r12d
0108ebad 498bcd mov rcx, r13
0108ebb0 4585c0 test r8d, r8d
0108ebb3 0f8485010000 je 0x14108ed3e
0108ebb9 4889442428 mov qword ptr [rsp + 0x28], rax
0108ebbe 488d45a0 lea rax, [rbp - 0x60]
0108ebc2 4889442420 mov qword ptr [rsp + 0x20], rax
0108ebc7 41b974756161 mov r9d, 0x61617574
0108ebcd e8beb60c00 call 0x14115a290
0108ebd2 8bf8 mov edi, eax
0108ebd4 85c0 test eax, eax
0108ebd6 7535 jne 0x14108ec0d
0108ebd8 39442434 cmp dword ptr [rsp + 0x34], eax
0108ebdc 7402 je 0x14108ebe0
0108ebde b301 mov bl, 1
0108ebe0 0fb74da0 movzx ecx, word ptr [rbp - 0x60]
0108ebe4 6685c9 test cx, cx
0108ebe7 741b je 0x14108ec04
0108ebe9 0fb7c1 movzx eax, cx
0108ebec 66c1e808 shr ax, 8
0108ebf0 66c1e108 shl cx, 8
0108ebf4 660bc1 or ax, cx
0108ebf7 668945a0 mov word ptr [rbp - 0x60], ax
0108ebfb 488d4da0 lea rcx, [rbp - 0x60]
0108ebff e85c6fa5ff call 0x140ae5b60
0108ec04 488d4da0 lea rcx, [rbp - 0x60]
0108ec08 e88388a5ff call 0x140ae7490
0108ec0d 85ff test edi, edi
0108ec0f 0f85220a0000 jne 0x14108f637
0108ec15 80fb01 cmp bl, 1
0108ec18 750d jne 0x14108ec27
0108ec1a 488d55a0 lea rdx, [rbp - 0x60]
0108ec1e 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0108ec22 e81995f0ff call 0x140f98140
0108ec27 448d4601 lea r8d, [rsi + 1]
0108ec2b 33c0 xor eax, eax
0108ec2d 668945a0 mov word ptr [rbp - 0x60], ax
0108ec31 32db xor bl, bl
0108ec33 4d85ed test r13, r13
0108ec36 0f84f6090000 je 0x14108f632
0108ec3c 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108ec44 0f85e8090000 jne 0x14108f632
0108ec4a c744243400020000 mov dword ptr [rsp + 0x34], 0x200
0108ec52 488d442434 lea rax, [rsp + 0x34]
0108ec57 418bd4 mov edx, r12d
0108ec5a 498bcd mov rcx, r13
0108ec5d 4585c0 test r8d, r8d
0108ec60 0f840b010000 je 0x14108ed71
0108ec66 4889442428 mov qword ptr [rsp + 0x28], rax
0108ec6b 488d45a0 lea rax, [rbp - 0x60]
0108ec6f 4889442420 mov qword ptr [rsp + 0x20], rax
0108ec74 41b9746e6d63 mov r9d, 0x636d6e74
0108ec7a e811b60c00 call 0x14115a290
0108ec7f 8bf8 mov edi, eax
0108ec81 85c0 test eax, eax
0108ec83 7535 jne 0x14108ecba
0108ec85 39442434 cmp dword ptr [rsp + 0x34], eax
0108ec89 7402 je 0x14108ec8d
0108ec8b b301 mov bl, 1
0108ec8d 0fb74da0 movzx ecx, word ptr [rbp - 0x60]
0108ec91 6685c9 test cx, cx
0108ec94 741b je 0x14108ecb1
0108ec96 0fb7c1 movzx eax, cx
0108ec99 66c1e808 shr ax, 8
0108ec9d 66c1e108 shl cx, 8
0108eca1 660bc1 or ax, cx
0108eca4 668945a0 mov word ptr [rbp - 0x60], ax
0108eca8 488d4da0 lea rcx, [rbp - 0x60]
0108ecac e8af6ea5ff call 0x140ae5b60
0108ecb1 488d4da0 lea rcx, [rbp - 0x60]
0108ecb5 e8d687a5ff call 0x140ae7490
0108ecba 85ff test edi, edi
0108ecbc 0f8575090000 jne 0x14108f637
0108ecc2 80fb01 cmp bl, 1
0108ecc5 751d jne 0x14108ece4
0108ecc7 498b5e30 mov rbx, qword ptr [r14 + 0x30]
0108eccb 488d55a0 lea rdx, [rbp - 0x60]
0108eccf 488bcb mov rcx, rbx
0108ecd2 e80932f0ff call 0x140f91ee0
0108ecd7 ba0e000000 mov edx, 0xe
0108ecdc 488bcb mov rcx, rbx
0108ecdf e81c54f0ff call 0x140f94100
0108ece4 448d4601 lea r8d, [rsi + 1]
0108ece8 4032f6 xor sil, sil
0108eceb 4d85ed test r13, r13
0108ecee 0f843e090000 je 0x14108f632
0108ecf4 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108ecfc 0f8530090000 jne 0x14108f632
0108ed02 33c0 xor eax, eax
0108ed04 8bd8 mov ebx, eax
0108ed06 c744243404000000 mov dword ptr [rsp + 0x34], 4
0108ed0e 488d442434 lea rax, [rsp + 0x34]
0108ed13 418bd4 mov edx, r12d
0108ed16 498bcd mov rcx, r13
0108ed19 4585c0 test r8d, r8d
0108ed1c 0f8482000000 je 0x14108eda4
0108ed22 4889442428 mov qword ptr [rsp + 0x28], rax
0108ed27 488d442454 lea rax, [rsp + 0x54]
0108ed2c 4889442420 mov qword ptr [rsp + 0x20], rax
0108ed31 41b96d6c6f76 mov r9d, 0x766f6c6d
0108ed37 e854b50c00 call 0x14115a290
0108ed3c eb7b jmp 0x14108edb9
0108ed3e 4889442420 mov qword ptr [rsp + 0x20], rax
0108ed43 4c8d4da0 lea r9, [rbp - 0x60]
0108ed47 41b874756161 mov r8d, 0x61617574
0108ed4d e82eac0c00 call 0x141159980
0108ed52 8bf8 mov edi, eax
0108ed54 85c0 test eax, eax
0108ed56 0f85b1feffff jne 0x14108ec0d
0108ed5c 39442434 cmp dword ptr [rsp + 0x34], eax
0108ed60 0f8578feffff jne 0x14108ebde
0108ed66 33c0 xor eax, eax
0108ed68 668945a0 mov word ptr [rbp - 0x60], ax
0108ed6c e993feffff jmp 0x14108ec04
0108ed71 4889442420 mov qword ptr [rsp + 0x20], rax
0108ed76 4c8d4da0 lea r9, [rbp - 0x60]
0108ed7a 41b8746e6d63 mov r8d, 0x636d6e74
0108ed80 e8fbab0c00 call 0x141159980
0108ed85 8bf8 mov edi, eax
0108ed87 85c0 test eax, eax
0108ed89 0f852bffffff jne 0x14108ecba
0108ed8f 39442434 cmp dword ptr [rsp + 0x34], eax
0108ed93 0f85f2feffff jne 0x14108ec8b
0108ed99 33c0 xor eax, eax
0108ed9b 668945a0 mov word ptr [rbp - 0x60], ax
0108ed9f e90dffffff jmp 0x14108ecb1
0108eda4 4889442420 mov qword ptr [rsp + 0x20], rax
0108eda9 4c8d4c2454 lea r9, [rsp + 0x54]
0108edae 41b86d6c6f76 mov r8d, 0x766f6c6d
0108edb4 e8c7ab0c00 call 0x141159980
0108edb9 85c0 test eax, eax
0108edbb 8bf8 mov edi, eax
0108edbd 752f jne 0x14108edee
0108edbf 395c2434 cmp dword ptr [rsp + 0x34], ebx
0108edc3 7429 je 0x14108edee
0108edc5 40b601 mov sil, 1
0108edc8 8b4c2454 mov ecx, dword ptr [rsp + 0x54]
0108edcc 8bd9 mov ebx, ecx
0108edce c1e310 shl ebx, 0x10
0108edd1 8bc1 mov eax, ecx
0108edd3 2500ff0000 and eax, 0xff00
0108edd8 0bd8 or ebx, eax
0108edda c1e308 shl ebx, 8
0108eddd 8bc1 mov eax, ecx
0108eddf 250000ff00 and eax, 0xff0000
0108ede4 c1e910 shr ecx, 0x10
0108ede7 0bc1 or eax, ecx
0108ede9 c1e808 shr eax, 8
0108edec 0bd8 or ebx, eax
0108edee 85ff test edi, edi
0108edf0 0f8541080000 jne 0x14108f637
0108edf6 4080fe01 cmp sil, 1
0108edfa 7548 jne 0x14108ee44
0108edfc 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0108ee00 4885c9 test rcx, rcx
0108ee03 743f je 0x14108ee44
0108ee05 4883791000 cmp qword ptr [rcx + 0x10], 0
0108ee0a 7438 je 0x14108ee44
0108ee0c 81fb00000200 cmp ebx, 0x20000
0108ee12 7e07 jle 0x14108ee1b
0108ee14 bb00000200 mov ebx, 0x20000
0108ee19 eb0a jmp 0x14108ee25
0108ee1b 85db test ebx, ebx
0108ee1d b800000000 mov eax, 0
0108ee22 0f48d8 cmovs ebx, eax
0108ee25 660f6ec3 movd xmm0, ebx
0108ee29 0f5bc0 cvtdq2ps xmm0, xmm0
0108ee2c f30f59c6 mulss xmm0, xmm6
0108ee30 f30f5cc7 subss xmm0, xmm7
0108ee34 f3410f59c0 mulss xmm0, xmm8
0108ee39 f30f2cc0 cvttss2si eax, xmm0
0108ee3d 66898102010000 mov word ptr [rcx + 0x102], ax
0108ee44 448b442448 mov r8d, dword ptr [rsp + 0x48]
0108ee49 41ffc0 inc r8d
0108ee4c 4032f6 xor sil, sil
0108ee4f 4088742430 mov byte ptr [rsp + 0x30], sil
0108ee54 4d85ed test r13, r13
0108ee57 0f84d5070000 je 0x14108f632
0108ee5d 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108ee65 0f85c7070000 jne 0x14108f632
0108ee6b 33c0 xor eax, eax
0108ee6d 8bd8 mov ebx, eax
0108ee6f c744243404000000 mov dword ptr [rsp + 0x34], 4
0108ee77 488d442434 lea rax, [rsp + 0x34]
0108ee7c 418bd4 mov edx, r12d
0108ee7f 498bcd mov rcx, r13
0108ee82 4585c0 test r8d, r8d
0108ee85 741c je 0x14108eea3
0108ee87 4889442428 mov qword ptr [rsp + 0x28], rax
0108ee8c 488d442440 lea rax, [rsp + 0x40]
0108ee91 4889442420 mov qword ptr [rsp + 0x20], rax
0108ee96 41b972616579 mov r9d, 0x79656172
0108ee9c e8efb30c00 call 0x14115a290
0108eea1 eb15 jmp 0x14108eeb8
0108eea3 4889442420 mov qword ptr [rsp + 0x20], rax
0108eea8 4c8d4c2440 lea r9, [rsp + 0x40]
0108eead 41b872616579 mov r8d, 0x79656172
0108eeb3 e8c8aa0c00 call 0x141159980
0108eeb8 85c0 test eax, eax
0108eeba 8bf8 mov edi, eax
0108eebc 7536 jne 0x14108eef4
0108eebe 395c2434 cmp dword ptr [rsp + 0x34], ebx
0108eec2 7430 je 0x14108eef4
0108eec4 40b601 mov sil, 1
0108eec7 4088742430 mov byte ptr [rsp + 0x30], sil
0108eecc 8b4c2440 mov ecx, dword ptr [rsp + 0x40]
0108eed0 8bd9 mov ebx, ecx
0108eed2 81e30000ff00 and ebx, 0xff0000
0108eed8 8bc1 mov eax, ecx
0108eeda c1e810 shr eax, 0x10
0108eedd 0bd8 or ebx, eax
0108eedf c1eb08 shr ebx, 8
0108eee2 8bc1 mov eax, ecx
0108eee4 c1e010 shl eax, 0x10
0108eee7 81e100ff0000 and ecx, 0xff00
0108eeed 0bc1 or eax, ecx
0108eeef c1e008 shl eax, 8
0108eef2 0bd8 or ebx, eax
0108eef4 85ff test edi, edi
0108eef6 0f853b070000 jne 0x14108f637
0108eefc baa6000000 mov edx, 0xa6
0108ef01 41b830000000 mov r8d, 0x30
0108ef07 4080fe01 cmp sil, 1
0108ef0b 488b742458 mov rsi, qword ptr [rsp + 0x58]
0108ef10 740e je 0x14108ef20
0108ef12 488b86e8200000 mov rax, qword ptr [rsi + 0x20e8]
0108ef19 0fb798500a0000 movzx ebx, word ptr [rax + 0xa50]
0108ef20 498bc6 mov rax, r14
0108ef23 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0108ef27 498b0400 mov rax, qword ptr [r8 + rax]
0108ef2b 66891c02 mov word ptr [rdx + rax], bx
0108ef2f ba07000000 mov edx, 7
0108ef34 e8c751f0ff call 0x140f94100
0108ef39 8b5c2448 mov ebx, dword ptr [rsp + 0x48]
0108ef3d 448d4301 lea r8d, [rbx + 1]
0108ef41 488d442430 lea rax, [rsp + 0x30]
0108ef46 4889442428 mov qword ptr [rsp + 0x28], rax
0108ef4b 488d442468 lea rax, [rsp + 0x68]
0108ef50 4889442420 mov qword ptr [rsp + 0x20], rax
0108ef55 41b974616562 mov r9d, 0x62656174
0108ef5b 418bd4 mov edx, r12d
0108ef5e 498bcd mov rcx, r13
0108ef61 e80a9f0c00 call 0x141158e70
0108ef66 8bf8 mov edi, eax
0108ef68 85c0 test eax, eax
0108ef6a 0f85c7060000 jne 0x14108f637
0108ef70 807c243001 cmp byte ptr [rsp + 0x30], 1
0108ef75 7510 jne 0x14108ef87
0108ef77 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0108ef7b 0fb7442468 movzx eax, word ptr [rsp + 0x68]
0108ef80 6689812c010000 mov word ptr [rcx + 0x12c], ax
0108ef87 448d4301 lea r8d, [rbx + 1]
0108ef8b 488d442430 lea rax, [rsp + 0x30]
0108ef90 4889442428 mov qword ptr [rsp + 0x28], rax
0108ef95 488d442438 lea rax, [rsp + 0x38]
0108ef9a 4889442420 mov qword ptr [rsp + 0x20], rax
0108ef9f 41b974727473 mov r9d, 0x73747274
0108efa5 418bd4 mov edx, r12d
0108efa8 498bcd mov rcx, r13
0108efab e8c09e0c00 call 0x141158e70
0108efb0 8bf8 mov edi, eax
0108efb2 85c0 test eax, eax
0108efb4 0f857d060000 jne 0x14108f637
0108efba 807c243001 cmp byte ptr [rsp + 0x30], 1
0108efbf 7520 jne 0x14108efe1
0108efc1 8b5c2438 mov ebx, dword ptr [rsp + 0x38]
0108efc5 85db test ebx, ebx
0108efc7 7409 je 0x14108efd2
0108efc9 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0108efcd e8fe3ff0ff call 0x140f92fd0
0108efd2 498b4630 mov rax, qword ptr [r14 + 0x30]
0108efd6 488b4878 mov rcx, qword ptr [rax + 0x78]
0108efda 895904 mov dword ptr [rcx + 4], ebx
0108efdd 8b5c2448 mov ebx, dword ptr [rsp + 0x48]
0108efe1 448d4301 lea r8d, [rbx + 1]
0108efe5 488d442430 lea rax, [rsp + 0x30]
0108efea 4889442428 mov qword ptr [rsp + 0x28], rax
0108efef 488d442438 lea rax, [rsp + 0x38]
0108eff4 4889442420 mov qword ptr [rsp + 0x20], rax
0108eff9 41b9706f7473 mov r9d, 0x73746f70
0108efff 418bd4 mov edx, r12d
0108f002 498bcd mov rcx, r13
0108f005 e8669e0c00 call 0x141158e70
0108f00a 8bf8 mov edi, eax
0108f00c 85c0 test eax, eax
0108f00e 0f8523060000 jne 0x14108f637
0108f014 807c243001 cmp byte ptr [rsp + 0x30], 1
0108f019 7520 jne 0x14108f03b
0108f01b 8b5c2438 mov ebx, dword ptr [rsp + 0x38]
0108f01f 85db test ebx, ebx
0108f021 7409 je 0x14108f02c
0108f023 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0108f027 e8a43ff0ff call 0x140f92fd0
0108f02c 498b4630 mov rax, qword ptr [r14 + 0x30]
0108f030 488b4878 mov rcx, qword ptr [rax + 0x78]
0108f034 895908 mov dword ptr [rcx + 8], ebx
0108f037 8b5c2448 mov ebx, dword ptr [rsp + 0x48]
0108f03b 448d4301 lea r8d, [rbx + 1]
0108f03f 488d442430 lea rax, [rsp + 0x30]
0108f044 4889442428 mov qword ptr [rsp + 0x28], rax
0108f049 488d442444 lea rax, [rsp + 0x44]
0108f04e 4889442420 mov qword ptr [rsp + 0x20], rax
0108f053 41b96d756e64 mov r9d, 0x646e756d
0108f059 418bd4 mov edx, r12d
0108f05c 498bcd mov rcx, r13
0108f05f e80c9e0c00 call 0x141158e70
0108f064 8bf8 mov edi, eax
0108f066 85c0 test eax, eax
0108f068 0f85c9050000 jne 0x14108f637
0108f06e 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0108f072 807c243001 cmp byte ptr [rsp + 0x30], 1
0108f077 7507 jne 0x14108f080
0108f079 0fb7442444 movzx eax, word ptr [rsp + 0x44]
0108f07e eb0e jmp 0x14108f08e
0108f080 488b86e8200000 mov rax, qword ptr [rsi + 0x20e8]
0108f087 0fb78074100000 movzx eax, word ptr [rax + 0x1074]
0108f08e 6689810e010000 mov word ptr [rcx + 0x10e], ax
0108f095 448d4301 lea r8d, [rbx + 1]
0108f099 488d442430 lea rax, [rsp + 0x30]
0108f09e 4889442428 mov qword ptr [rsp + 0x28], rax
0108f0a3 488d442444 lea rax, [rsp + 0x44]
0108f0a8 4889442420 mov qword ptr [rsp + 0x20], rax
0108f0ad 41b9746e6364 mov r9d, 0x64636e74
0108f0b3 418bd4 mov edx, r12d
0108f0b6 498bcd mov rcx, r13
0108f0b9 e8b29d0c00 call 0x141158e70
0108f0be 8bf8 mov edi, eax
0108f0c0 85c0 test eax, eax
0108f0c2 0f856f050000 jne 0x14108f637
0108f0c8 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0108f0cc 807c243001 cmp byte ptr [rsp + 0x30], 1
0108f0d1 7507 jne 0x14108f0da
0108f0d3 0fb7442444 movzx eax, word ptr [rsp + 0x44]
0108f0d8 eb0e jmp 0x14108f0e8
0108f0da 488b86e8200000 mov rax, qword ptr [rsi + 0x20e8]
0108f0e1 0fb78076100000 movzx eax, word ptr [rax + 0x1076]
0108f0e8 66898110010000 mov word ptr [rcx + 0x110], ax
0108f0ef 448d4301 lea r8d, [rbx + 1]
0108f0f3 488d442430 lea rax, [rsp + 0x30]
0108f0f8 4889442428 mov qword ptr [rsp + 0x28], rax
0108f0fd 488d442444 lea rax, [rsp + 0x44]
0108f102 4889442420 mov qword ptr [rsp + 0x20], rax
0108f107 41b96c706d63 mov r9d, 0x636d706c
0108f10d 418bd4 mov edx, r12d
0108f110 498bcd mov rcx, r13
0108f113 e8589d0c00 call 0x141158e70
0108f118 8bf8 mov edi, eax
0108f11a 85c0 test eax, eax
0108f11c 0f8515050000 jne 0x14108f637
0108f122 4d8b4630 mov r8, qword ptr [r14 + 0x30]
0108f126 410fb6909b000000 movzx edx, byte ptr [r8 + 0x9b]
0108f12e 807c243001 cmp byte ptr [rsp + 0x30], 1
0108f133 7512 jne 0x14108f147
0108f135 8b442444 mov eax, dword ptr [rsp + 0x44]
0108f139 f7d8 neg eax
0108f13b 1ac9 sbb cl, cl
0108f13d 80e104 and cl, 4
0108f140 80e2fb and dl, 0xfb
0108f143 0aca or cl, dl
0108f145 eb18 jmp 0x14108f15f
0108f147 488b86e8200000 mov rax, qword ptr [rsi + 0x20e8]
0108f14e 0fb68871100000 movzx ecx, byte ptr [rax + 0x1071]
0108f155 c0e102 shl cl, 2
0108f158 32ca xor cl, dl
0108f15a 80e104 and cl, 4
0108f15d 32ca xor cl, dl
0108f15f 4188889b000000 mov byte ptr [r8 + 0x9b], cl
0108f166 448d4301 lea r8d, [rbx + 1]
0108f16a 488d442430 lea rax, [rsp + 0x30]
0108f16f 4889442428 mov qword ptr [rsp + 0x28], rax
0108f174 488d442444 lea rax, [rsp + 0x44]
0108f179 4889442420 mov qword ptr [rsp + 0x20], rax
0108f17e 41b96e696f6a mov r9d, 0x6a6f696e
0108f184 418bd4 mov edx, r12d
0108f187 498bcd mov rcx, r13
0108f18a e8e19c0c00 call 0x141158e70
0108f18f 8bf8 mov edi, eax
0108f191 85c0 test eax, eax
0108f193 0f859e040000 jne 0x14108f637
0108f199 807c243001 cmp byte ptr [rsp + 0x30], 1
0108f19e 7510 jne 0x14108f1b0
0108f1a0 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0108f1a4 0fb7442444 movzx eax, word ptr [rsp + 0x44]
0108f1a9 6689812e010000 mov word ptr [rcx + 0x12e], ax
0108f1b0 448d4301 lea r8d, [rbx + 1]
0108f1b4 488d442430 lea rax, [rsp + 0x30]
0108f1b9 4889442428 mov qword ptr [rsp + 0x28], rax
0108f1be 488d442444 lea rax, [rsp + 0x44]
0108f1c3 4889442420 mov qword ptr [rsp + 0x20], rax
0108f1c8 41b974617275 mov r9d, 0x75726174
0108f1ce 418bd4 mov edx, r12d
0108f1d1 498bcd mov rcx, r13
0108f1d4 e8979c0c00 call 0x141158e70
0108f1d9 8bf8 mov edi, eax
0108f1db 85c0 test eax, eax
0108f1dd 0f8554040000 jne 0x14108f637
0108f1e3 807c243001 cmp byte ptr [rsp + 0x30], 1
0108f1e8 7511 jne 0x14108f1fb
0108f1ea 4533c0 xor r8d, r8d
0108f1ed 0fb6542444 movzx edx, byte ptr [rsp + 0x44]
0108f1f2 498b4e30 mov rcx, qword ptr [r14 + 0x30]
0108f1f6 e875aee4ff call 0x140eda070
0108f1fb 448d4301 lea r8d, [rbx + 1]
0108f1ff 488d442430 lea rax, [rsp + 0x30]
0108f204 4889442428 mov qword ptr [rsp + 0x28], rax
0108f209 488d442444 lea rax, [rsp + 0x44]
0108f20e 4889442420 mov qword ptr [rsp + 0x20], rax
0108f213 41b961706167 mov r9d, 0x67617061
0108f219 418bd4 mov edx, r12d
0108f21c 498bcd mov rcx, r13
0108f21f e84c9c0c00 call 0x141158e70
0108f224 8bf8 mov edi, eax
0108f226 85c0 test eax, eax
0108f228 0f8509040000 jne 0x14108f637
0108f22e 4d8b4630 mov r8, qword ptr [r14 + 0x30]
0108f232 410fb6909c000000 movzx edx, byte ptr [r8 + 0x9c]
0108f23a 807c243001 cmp byte ptr [rsp + 0x30], 1
0108f23f 750e jne 0x14108f24f
0108f241 39442444 cmp dword ptr [rsp + 0x44], eax
0108f245 0f95c1 setne cl
0108f248 80e2fe and dl, 0xfe
0108f24b 0aca or cl, dl
0108f24d eb15 jmp 0x14108f264
0108f24f 488b86e8200000 mov rax, qword ptr [rsi + 0x20e8]
0108f256 0fb6ca movzx ecx, dl
0108f259 328872100000 xor cl, byte ptr [rax + 0x1072]
0108f25f 80e101 and cl, 1
0108f262 32ca xor cl, dl
0108f264 4188889c000000 mov byte ptr [r8 + 0x9c], cl
0108f26b 448d4301 lea r8d, [rbx + 1]
0108f26f 33f6 xor esi, esi
0108f271 668975a0 mov word ptr [rbp - 0x60], si
0108f275 32db xor bl, bl
0108f277 4d85ed test r13, r13
0108f27a 0f8450f0ffff je 0x14108e2d0
0108f280 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108f288 0f8542f0ffff jne 0x14108e2d0
0108f28e c744243400020000 mov dword ptr [rsp + 0x34], 0x200
0108f296 488d442434 lea rax, [rsp + 0x34]
0108f29b 418bd4 mov edx, r12d
0108f29e 498bcd mov rcx, r13
0108f2a1 4585c0 test r8d, r8d
0108f2a4 0f8484000000 je 0x14108f32e
0108f2aa 4889442428 mov qword ptr [rsp + 0x28], rax
0108f2af 488d45a0 lea rax, [rbp - 0x60]
0108f2b3 4889442420 mov qword ptr [rsp + 0x20], rax
0108f2b8 41b964697574 mov r9d, 0x74756964
0108f2be e8cdaf0c00 call 0x14115a290
0108f2c3 8bf8 mov edi, eax
0108f2c5 85c0 test eax, eax
0108f2c7 7535 jne 0x14108f2fe
0108f2c9 39742434 cmp dword ptr [rsp + 0x34], esi
0108f2cd 7402 je 0x14108f2d1
0108f2cf b301 mov bl, 1
0108f2d1 0fb74da0 movzx ecx, word ptr [rbp - 0x60]
0108f2d5 6685c9 test cx, cx
0108f2d8 741b je 0x14108f2f5
0108f2da 0fb7c1 movzx eax, cx
0108f2dd 66c1e808 shr ax, 8
0108f2e1 66c1e108 shl cx, 8
0108f2e5 660bc1 or ax, cx
0108f2e8 668945a0 mov word ptr [rbp - 0x60], ax
0108f2ec 488d4da0 lea rcx, [rbp - 0x60]
0108f2f0 e86b68a5ff call 0x140ae5b60
0108f2f5 488d4da0 lea rcx, [rbp - 0x60]
0108f2f9 e89281a5ff call 0x140ae7490
0108f2fe 85ff test edi, edi
0108f300 0f8533030000 jne 0x14108f639
0108f306 80fb01 cmp bl, 1
0108f309 0f85b9000000 jne 0x14108f3c8
0108f30f 440fb745a0 movzx r8d, word ptr [rbp - 0x60]
0108f314 0f57c0 xorps xmm0, xmm0
0108f317 f30f7f442478 movdqu xmmword ptr [rsp + 0x78], xmm0
0108f31d 4981f8ff010000 cmp r8, 0x1ff
0108f324 762e jbe 0x14108f354
0108f326 41b8ff010000 mov r8d, 0x1ff
0108f32c eb2b jmp 0x14108f359
0108f32e 4889442420 mov qword ptr [rsp + 0x20], rax
0108f333 4c8d4da0 lea r9, [rbp - 0x60]
0108f337 41b864697574 mov r8d, 0x74756964
0108f33d e83ea60c00 call 0x141159980
0108f342 8bf8 mov edi, eax
0108f344 85c0 test eax, eax
0108f346 75b6 jne 0x14108f2fe
0108f348 39742434 cmp dword ptr [rsp + 0x34], esi
0108f34c 7581 jne 0x14108f2cf
0108f34e 668975a0 mov word ptr [rbp - 0x60], si
0108f352 eba1 jmp 0x14108f2f5
0108f354 4d85c0 test r8, r8
0108f357 740f je 0x14108f368
0108f359 488d55a2 lea rdx, [rbp - 0x5e]
0108f35d 488d4c2478 lea rcx, [rsp + 0x78]
0108f362 e81981a4ff call 0x140ad7480
0108f367 90 nop 
0108f368 488d542478 lea rdx, [rsp + 0x78]
0108f36d 498bcf mov rcx, r15
0108f370 e81bbaf1ff call 0x140faad90
0108f375 90 nop 
0108f376 488b4c2478 mov rcx, qword ptr [rsp + 0x78]
0108f37b 4885c9 test rcx, rcx
0108f37e 7420 je 0x14108f3a0
0108f380 b8ffffffff mov eax, 0xffffffff
0108f385 f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108f38a 83f801 cmp eax, 1
0108f38d 750c jne 0x14108f39b
0108f38f c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108f396 e83dca7000 call 0x14179bdd8
0108f39b 4889742478 mov qword ptr [rsp + 0x78], rsi
0108f3a0 488b4d80 mov rcx, qword ptr [rbp - 0x80]
0108f3a4 4885c9 test rcx, rcx
0108f3a7 741f je 0x14108f3c8
0108f3a9 b8ffffffff mov eax, 0xffffffff
0108f3ae f00fc14108 lock xadd dword ptr [rcx + 8], eax
0108f3b3 83f801 cmp eax, 1
0108f3b6 750c jne 0x14108f3c4
0108f3b8 c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
0108f3bf e814ca7000 call 0x14179bdd8
0108f3c4 48897580 mov qword ptr [rbp - 0x80], rsi
0108f3c8 8b742450 mov esi, dword ptr [rsp + 0x50]
0108f3cc 33db xor ebx, ebx
0108f3ce 8b442448 mov eax, dword ptr [rsp + 0x48]
0108f3d2 ffc0 inc eax
0108f3d4 89442448 mov dword ptr [rsp + 0x48], eax
0108f3d8 3bc6 cmp eax, esi
0108f3da 730a jae 0x14108f3e6
0108f3dc 4c8b742460 mov r14, qword ptr [rsp + 0x60]
0108f3e1 e9caefffff jmp 0x14108e3b0
0108f3e6 807c243c00 cmp byte ptr [rsp + 0x3c], 0
0108f3eb 755e jne 0x14108f44b
0108f3ed 4c8b7c2458 mov r15, qword ptr [rsp + 0x58]
0108f3f2 4c8b742460 mov r14, qword ptr [rsp + 0x60]
0108f3f7 85f6 test esi, esi
0108f3f9 7450 je 0x14108f44b
0108f3fb 0f1f440000 nop dword ptr [rax + rax]
0108f400 448bcb mov r9d, ebx
0108f403 4533c0 xor r8d, r8d
0108f406 ba73000000 mov edx, 0x73
0108f40b 498b8e08040000 mov rcx, qword ptr [r14 + 0x408]
0108f412 e8a97aedff call 0x140f66ec0
0108f417 488bf8 mov rdi, rax
0108f41a 4885c0 test rax, rax
0108f41d 7420 je 0x14108f43f
0108f41f 488bc8 mov rcx, rax
0108f422 e899e2f2ff call 0x140fbd6c0
0108f427 84c0 test al, al
0108f429 7514 jne 0x14108f43f
0108f42b 498b97e8200000 mov rdx, qword ptr [r15 + 0x20e8]
0108f432 4883c250 add rdx, 0x50
0108f436 488b4f30 mov rcx, qword ptr [rdi + 0x30]
0108f43a e8617ef0ff call 0x140f972a0
0108f43f ffc3 inc ebx
0108f441 3bde cmp ebx, esi
0108f443 72bb jb 0x14108f400
0108f445 eb04 jmp 0x14108f44b
0108f447 89742450 mov dword ptr [rsp + 0x50], esi
0108f44b c7442440c6000000 mov dword ptr [rsp + 0x40], 0xc6
0108f453 488d442440 lea rax, [rsp + 0x40]
0108f458 4889442420 mov qword ptr [rsp + 0x20], rax
0108f45d 4c8d8da0010000 lea r9, [rbp + 0x1a0]
0108f464 41b8676f7270 mov r8d, 0x70726f67
0108f46a 418bd4 mov edx, r12d
0108f46d 498bcd mov rcx, r13
0108f470 e80ba50c00 call 0x141159980
0108f475 8bf8 mov edi, eax
0108f477 89442454 mov dword ptr [rsp + 0x54], eax
0108f47b 85c0 test eax, eax
0108f47d 0f85b4010000 jne 0x14108f637
0108f483 448b7c2440 mov r15d, dword ptr [rsp + 0x40]
0108f488 4585ff test r15d, r15d
0108f48b 0f84a6010000 je 0x14108f637
0108f491 41d1ef shr r15d, 1
0108f494 4533f6 xor r14d, r14d
0108f497 418bde mov ebx, r14d
0108f49a 4c8b642460 mov r12, qword ptr [rsp + 0x60]
0108f49f 85f6 test esi, esi
0108f4a1 7427 je 0x14108f4ca
0108f4a3 448bcb mov r9d, ebx
0108f4a6 4533c0 xor r8d, r8d
0108f4a9 ba01000000 mov edx, 1
0108f4ae 498b8c2408040000 mov rcx, qword ptr [r12 + 0x408]
0108f4b6 e8057aedff call 0x140f66ec0
0108f4bb 4885c0 test rax, rax
0108f4be 7404 je 0x14108f4c4
0108f4c0 44897058 mov dword ptr [rax + 0x58], r14d
0108f4c4 ffc3 inc ebx
0108f4c6 3bde cmp ebx, esi
0108f4c8 72d9 jb 0x14108f4a3
0108f4ca 4585ff test r15d, r15d
0108f4cd 0f84a5000000 je 0x14108f578
0108f4d3 488db5a0010000 lea rsi, [rbp + 0x1a0]
0108f4da 448b6c2450 mov r13d, dword ptr [rsp + 0x50]
0108f4df 0fb67c244c movzx edi, byte ptr [rsp + 0x4c]
0108f4e4 440fb64e01 movzx r9d, byte ptr [rsi + 1]
0108f4e9 4585c9 test r9d, r9d
0108f4ec 746c je 0x14108f55a
0108f4ee 453bcd cmp r9d, r13d
0108f4f1 7767 ja 0x14108f55a
0108f4f3 41ffc9 dec r9d
0108f4f6 4533c0 xor r8d, r8d
0108f4f9 ba01000000 mov edx, 1
0108f4fe 498b8c2408040000 mov rcx, qword ptr [r12 + 0x408]
0108f506 e8b579edff call 0x140f66ec0
0108f50b 488bd8 mov rbx, rax
0108f50e 4885c0 test rax, rax
0108f511 7447 je 0x14108f55a
0108f513 803e00 cmp byte ptr [rsi], 0
0108f516 751d jne 0x14108f535
0108f518 498d8424f0000000 lea rax, [r12 + 0xf0]
0108f520 4885c0 test rax, rax
0108f523 7410 je 0x14108f535
0108f525 f6400f04 test byte ptr [rax + 0xf], 4
0108f529 740a je 0x14108f535
0108f52b b201 mov dl, 1
0108f52d 488bcb mov rcx, rbx
0108f530 e8bbe4f2ff call 0x140fbd9f0
0108f535 418d4601 lea eax, [r14 + 1]
0108f539 894358 mov dword ptr [rbx + 0x58], eax
0108f53c 4c8b4330 mov r8, qword ptr [rbx + 0x30]
0108f540 410fb6809a000000 movzx eax, byte ptr [r8 + 0x9a]
0108f548 400fb6cf movzx ecx, dil
0108f54c 32c8 xor cl, al
0108f54e 80e140 and cl, 0x40
0108f551 32c8 xor cl, al
0108f553 4188889a000000 mov byte ptr [r8 + 0x9a], cl
0108f55a 41ffc6 inc r14d
0108f55d 4883c602 add rsi, 2
0108f561 453bf7 cmp r14d, r15d
0108f564 0f827affffff jb 0x14108f4e4
0108f56a 44896c2450 mov dword ptr [rsp + 0x50], r13d
0108f56f 8b7c2454 mov edi, dword ptr [rsp + 0x54]
0108f573 4c8b6c2470 mov r13, qword ptr [rsp + 0x70]
0108f578 ba01000000 mov edx, 1
0108f57d 498bcc mov rcx, r12
0108f580 e85be4ffff call 0x14108d9e0
0108f585 8bf0 mov esi, eax
0108f587 33c0 xor eax, eax
0108f589 448bf8 mov r15d, eax
0108f58c 39442450 cmp dword ptr [rsp + 0x50], eax
0108f590 0f868a000000 jbe 0x14108f620
0108f596 448b6c2450 mov r13d, dword ptr [rsp + 0x50]
0108f59b 33ff xor edi, edi
0108f59d 0f1f00 nop dword ptr [rax]
0108f5a0 458bcf mov r9d, r15d
0108f5a3 4533c0 xor r8d, r8d
0108f5a6 ba73000000 mov edx, 0x73
0108f5ab 498b8c2408040000 mov rcx, qword ptr [r12 + 0x408]
0108f5b3 e80879edff call 0x140f66ec0
0108f5b8 4885c0 test rax, rax
0108f5bb 7452 je 0x14108f60f
0108f5bd 397858 cmp dword ptr [rax + 0x58], edi
0108f5c0 754d jne 0x14108f60f
0108f5c2 897058 mov dword ptr [rax + 0x58], esi
0108f5c5 4d8b742470 mov r14, qword ptr [r12 + 0x70]
0108f5ca 4d85f6 test r14, r14
0108f5cd 7406 je 0x14108f5d5
0108f5cf 458b7664 mov r14d, dword ptr [r14 + 0x64]
0108f5d3 eb03 jmp 0x14108f5d8
0108f5d5 448bf7 mov r14d, edi
0108f5d8 8bdf mov ebx, edi
0108f5da 4585f6 test r14d, r14d
0108f5dd 7430 je 0x14108f60f
0108f5df 90 nop 
0108f5e0 448bcb mov r9d, ebx
0108f5e3 4533c0 xor r8d, r8d
0108f5e6 ba73000000 mov edx, 0x73
0108f5eb 498b8c2408040000 mov rcx, qword ptr [r12 + 0x408]
0108f5f3 e8c878edff call 0x140f66ec0
0108f5f8 4885c0 test rax, rax
0108f5fb 740b je 0x14108f608
0108f5fd 397058 cmp dword ptr [rax + 0x58], esi
0108f600 7506 jne 0x14108f608
0108f602 ffc6 inc esi
0108f604 8bdf mov ebx, edi
0108f606 ebd8 jmp 0x14108f5e0
0108f608 ffc3 inc ebx
0108f60a 413bde cmp ebx, r14d
0108f60d 72d1 jb 0x14108f5e0
0108f60f 41ffc7 inc r15d
0108f612 453bfd cmp r15d, r13d
0108f615 7289 jb 0x14108f5a0
0108f617 8b7c2454 mov edi, dword ptr [rsp + 0x54]
0108f61b 4c8b6c2470 mov r13, qword ptr [rsp + 0x70]
0108f620 4533c0 xor r8d, r8d
0108f623 ba02000000 mov edx, 2
0108f628 498bcc mov rcx, r12
0108f62b e8907eedff call 0x140f674c0
0108f630 eb05 jmp 0x14108f637
0108f632 bfceffffff mov edi, 0xffffffce
0108f637 33f6 xor esi, esi
0108f639 488b4c2458 mov rcx, qword ptr [rsp + 0x58]
0108f63e 81b98000000074616474 cmp dword ptr [rcx + 0x80], 0x74646174
0108f648 7521 jne 0x14108f66b
0108f64a ff899c000000 dec dword ptr [rcx + 0x9c]
0108f650 83b99c00000000 cmp dword ptr [rcx + 0x9c], 0
0108f657 7f12 jg 0x14108f66b
0108f659 89b19c000000 mov dword ptr [rcx + 0x9c], esi
0108f65f e8ece9e3ff call 0x140ece050
0108f664 eb05 jmp 0x14108f66b
0108f666 bfceffffff mov edi, 0xffffffce
0108f66b 4d85ed test r13, r13
0108f66e 7434 je 0x14108f6a4
0108f670 41817d0062646963 cmp dword ptr [r13], 0x63696462
0108f678 752a jne 0x14108f6a4
0108f67a 418b95d4080000 mov edx, dword ptr [r13 + 0x8d4]
0108f681 498bcd mov rcx, r13
0108f684 e8d7c00c00 call 0x14115b760
0108f689 498b8db8080000 mov rcx, qword ptr [r13 + 0x8b8]
0108f690 4885c9 test rcx, rcx
0108f693 7406 je 0x14108f69b
0108f695 ff15cdcc8500 call qword ptr [rip + 0x85cccd]
0108f69b 498bcd mov rcx, r13
0108f69e ff15c4cc8500 call qword ptr [rip + 0x85ccc4]
0108f6a4 8bc7 mov eax, edi
0108f6a6 488b8d70020000 mov rcx, qword ptr [rbp + 0x270]
0108f6ad 4833cc xor rcx, rsp
0108f6b0 e82bc27000 call 0x14179b8e0
0108f6b5 4c8d9c24b0030000 lea r11, [rsp + 0x3b0]
0108f6bd 498b5b38 mov rbx, qword ptr [r11 + 0x38]
0108f6c1 498b7340 mov rsi, qword ptr [r11 + 0x40]
0108f6c5 498b7b48 mov rdi, qword ptr [r11 + 0x48]
0108f6c9 410f2873f0 movaps xmm6, xmmword ptr [r11 - 0x10]
0108f6ce 410f287be0 movaps xmm7, xmmword ptr [r11 - 0x20]
0108f6d3 450f2843d0 movaps xmm8, xmmword ptr [r11 - 0x30]
0108f6d8 498be3 mov rsp, r11
0108f6db 415f pop r15
0108f6dd 415e pop r14
0108f6df 415d pop r13
0108f6e1 415c pop r12
0108f6e3 5d pop rbp
0108f6e4 c3 ret 