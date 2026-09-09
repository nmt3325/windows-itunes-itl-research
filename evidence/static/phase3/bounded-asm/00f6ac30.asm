00f6ac30 48895c2410 mov qword ptr [rsp + 0x10], rbx
00f6ac35 48896c2418 mov qword ptr [rsp + 0x18], rbp
00f6ac3a 57 push rdi
00f6ac3b 4883ec30 sub rsp, 0x30
00f6ac3f 4032ed xor bpl, bpl
00f6ac42 488bf9 mov rdi, rcx
00f6ac45 83791002 cmp dword ptr [rcx + 0x10], 2
00f6ac49 0f85ce000000 jne 0x140f6ad1d
00f6ac4f 4883b9f000000000 cmp qword ptr [rcx + 0xf0], 0
00f6ac57 740d je 0x140f6ac66
00f6ac59 83b9f800000000 cmp dword ptr [rcx + 0xf8], 0
00f6ac60 0f85b7000000 jne 0x140f6ad1d
00f6ac66 4883b9c800000000 cmp qword ptr [rcx + 0xc8], 0
00f6ac6e 740d je 0x140f6ac7d
00f6ac70 83b9d000000000 cmp dword ptr [rcx + 0xd0], 0
00f6ac77 0f85a0000000 jne 0x140f6ad1d
00f6ac7d e89e0b0000 call 0x140f6b820
00f6ac82 a9fdfbfeff test eax, 0xfffefbfd
00f6ac87 0f95c1 setne cl
00f6ac8a a902040100 test eax, 0x10402
00f6ac8f 0f95c0 setne al
00f6ac92 84c8 test al, cl
00f6ac94 0f8583000000 jne 0x140f6ad1d
00f6ac9a 40386f58 cmp byte ptr [rdi + 0x58], bpl
00f6ac9e 7508 jne 0x140f6aca8
00f6aca0 488bcf mov rcx, rdi
00f6aca3 e8089a1500 call 0x1410c46b0
00f6aca8 488b5f48 mov rbx, qword ptr [rdi + 0x48]
00f6acac 4885db test rbx, rbx
00f6acaf 746c je 0x140f6ad1d
00f6acb1 48837b1000 cmp qword ptr [rbx + 0x10], 0
00f6acb6 744d je 0x140f6ad05
00f6acb8 f6839a00000001 test byte ptr [rbx + 0x9a], 1
00f6acbf 7449 je 0x140f6ad0a
00f6acc1 488b4368 mov rax, qword ptr [rbx + 0x68]
00f6acc5 8b4810 mov ecx, dword ptr [rax + 0x10]
00f6acc8 85c9 test ecx, ecx
00f6acca 752d jne 0x140f6acf9
00f6accc 398bac000000 cmp dword ptr [rbx + 0xac], ecx
00f6acd2 751f jne 0x140f6acf3
00f6acd4 488bcb mov rcx, rbx
00f6acd7 e864650200 call 0x140f91240
00f6acdc 8983ac000000 mov dword ptr [rbx + 0xac], eax
00f6ace2 85c0 test eax, eax
00f6ace4 740d je 0x140f6acf3
00f6ace6 ba3c000000 mov edx, 0x3c
00f6aceb 488bcb mov rcx, rbx
00f6acee e80d940200 call 0x140f94100
00f6acf3 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
00f6acf9 f7c102040000 test ecx, 0x402
00f6acff 0f85c7000000 jne 0x140f6adcc
00f6ad05 4885db test rbx, rbx
00f6ad08 7413 je 0x140f6ad1d
00f6ad0a 48837b1000 cmp qword ptr [rbx + 0x10], 0
00f6ad0f 740c je 0x140f6ad1d
00f6ad11 488b4330 mov rax, qword ptr [rbx + 0x30]
00f6ad15 488bd8 mov rbx, rax
00f6ad18 4885c0 test rax, rax
00f6ad1b 7594 jne 0x140f6acb1
00f6ad1d 488d87c8000000 lea rax, [rdi + 0xc8]
00f6ad24 4889742440 mov qword ptr [rsp + 0x40], rsi
00f6ad29 48833800 cmp qword ptr [rax], 0
00f6ad2d 7410 je 0x140f6ad3f
00f6ad2f 488d8fd0000000 lea rcx, [rdi + 0xd0]
00f6ad36 833900 cmp dword ptr [rcx], 0
00f6ad39 0f8584010000 jne 0x140f6aec3
00f6ad3f 837f1002 cmp dword ptr [rdi + 0x10], 2
00f6ad43 0f856c010000 jne 0x140f6aeb5
00f6ad49 4883bff000000000 cmp qword ptr [rdi + 0xf0], 0
00f6ad51 740d je 0x140f6ad60
00f6ad53 83bff800000000 cmp dword ptr [rdi + 0xf8], 0
00f6ad5a 0f8555010000 jne 0x140f6aeb5
00f6ad60 488bcf mov rcx, rdi
00f6ad63 e8b80a0000 call 0x140f6b820
00f6ad68 a820 test al, 0x20
00f6ad6a 0f8445010000 je 0x140f6aeb5
00f6ad70 a9dfffffff test eax, 0xffffffdf
00f6ad75 0f853a010000 jne 0x140f6aeb5
00f6ad7b 837f1401 cmp dword ptr [rdi + 0x14], 1
00f6ad7f 0f857e000000 jne 0x140f6ae03
00f6ad85 40386f58 cmp byte ptr [rdi + 0x58], bpl
00f6ad89 7508 jne 0x140f6ad93
00f6ad8b 488bcf mov rcx, rdi
00f6ad8e e81d991500 call 0x1410c46b0
00f6ad93 4c8b4748 mov r8, qword ptr [rdi + 0x48]
00f6ad97 4d85c0 test r8, r8
00f6ad9a 0f840e010000 je 0x140f6aeae
00f6ada0 498b5010 mov rdx, qword ptr [r8 + 0x10]
00f6ada4 488d8fc0000000 lea rcx, [rdi + 0xc0]
00f6adab c6475901 mov byte ptr [rdi + 0x59], 1
00f6adaf 4881c278010000 add rdx, 0x178
00f6adb6 458b80b0000000 mov r8d, dword ptr [r8 + 0xb0]
00f6adbd 41b101 mov r9b, 1
00f6adc0 e82b52c9ff call 0x140bffff0
00f6adc5 b001 mov al, 1
00f6adc7 e9cc010000 jmp 0x140f6af98
00f6adcc 488b5310 mov rdx, qword ptr [rbx + 0x10]
00f6add0 488d8fc0000000 lea rcx, [rdi + 0xc0]
00f6add7 40886f59 mov byte ptr [rdi + 0x59], bpl
00f6addb 4881c278010000 add rdx, 0x178
00f6ade2 448b83b0000000 mov r8d, dword ptr [rbx + 0xb0]
00f6ade9 41b101 mov r9b, 1
00f6adec e8ff51c9ff call 0x140bffff0
00f6adf1 b001 mov al, 1
00f6adf3 488b5c2448 mov rbx, qword ptr [rsp + 0x48]
00f6adf8 488b6c2450 mov rbp, qword ptr [rsp + 0x50]
00f6adfd 4883c430 add rsp, 0x30
00f6ae01 5f pop rdi
00f6ae02 c3 ret 
00f6ae03 488b0dd64e1601 mov rcx, qword ptr [rip + 0x1164ed6]
00f6ae0a 4885c9 test rcx, rcx
00f6ae0d 742f je 0x140f6ae3e
00f6ae0f ba4f00fa00 mov edx, 0xfa004f
00f6ae14 ff15d6df9700 call qword ptr [rip + 0x97dfd6]
00f6ae1a 488bf0 mov rsi, rax
00f6ae1d 4885c0 test rax, rax
00f6ae20 7417 je 0x140f6ae39
00f6ae22 488bc8 mov rcx, rax
00f6ae25 ff1595e09700 call qword ptr [rip + 0x97e095]
00f6ae2b 488bd8 mov rbx, rax
00f6ae2e ff154ce19700 call qword ptr [rip + 0x97e14c]
00f6ae34 483bd8 cmp rbx, rax
00f6ae37 7505 jne 0x140f6ae3e
00f6ae39 4885f6 test rsi, rsi
00f6ae3c 7507 jne 0x140f6ae45
00f6ae3e 488b35b32d1401 mov rsi, qword ptr [rip + 0x1142db3]
00f6ae45 488bd6 mov rdx, rsi
00f6ae48 488d4c2420 lea rcx, [rsp + 0x20]
00f6ae4d e88eb4b6ff call 0x140ad62e0
00f6ae52 488d8fd8000000 lea rcx, [rdi + 0xd8]
00f6ae59 488d542420 lea rdx, [rsp + 0x20]
00f6ae5e e8cdb7b6ff call 0x140ad6630
00f6ae63 488b4c2420 mov rcx, qword ptr [rsp + 0x20]
00f6ae68 bbffffffff mov ebx, 0xffffffff
00f6ae6d 4885c9 test rcx, rcx
00f6ae70 7418 je 0x140f6ae8a
00f6ae72 8bc3 mov eax, ebx
00f6ae74 f00fc14108 lock xadd dword ptr [rcx + 8], eax
00f6ae79 83f801 cmp eax, 1
00f6ae7c 750c jne 0x140f6ae8a
00f6ae7e c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00f6ae85 e84e0f8300 call 0x14179bdd8
00f6ae8a 488b4c2428 mov rcx, qword ptr [rsp + 0x28]
00f6ae8f 4885c9 test rcx, rcx
00f6ae92 7416 je 0x140f6aeaa
00f6ae94 f00fc15908 lock xadd dword ptr [rcx + 8], ebx
00f6ae99 83fb01 cmp ebx, 1
00f6ae9c 750c jne 0x140f6aeaa
00f6ae9e c74108003665c4 mov dword ptr [rcx + 8], 0xc4653600
00f6aea5 e82e0f8300 call 0x14179bdd8
00f6aeaa c6475901 mov byte ptr [rdi + 0x59], 1
00f6aeae b001 mov al, 1
00f6aeb0 e9e3000000 jmp 0x140f6af98
00f6aeb5 488d87c8000000 lea rax, [rdi + 0xc8]
00f6aebc 488d8fd0000000 lea rcx, [rdi + 0xd0]
00f6aec3 837f1401 cmp dword ptr [rdi + 0x14], 1
00f6aec7 0f85c7000000 jne 0x140f6af94
00f6aecd 48833800 cmp qword ptr [rax], 0
00f6aed1 7409 je 0x140f6aedc
00f6aed3 833900 cmp dword ptr [rcx], 0
00f6aed6 0f85b8000000 jne 0x140f6af94
00f6aedc 488b7730 mov rsi, qword ptr [rdi + 0x30]
00f6aee0 40386f58 cmp byte ptr [rdi + 0x58], bpl
00f6aee4 7508 jne 0x140f6aeee
00f6aee6 488bcf mov rcx, rdi
00f6aee9 e8c2971500 call 0x1410c46b0
00f6aeee 488b5f48 mov rbx, qword ptr [rdi + 0x48]
00f6aef2 4885db test rbx, rbx
00f6aef5 745d je 0x140f6af54
00f6aef7 48837b1000 cmp qword ptr [rbx + 0x10], 0
00f6aefc 7456 je 0x140f6af54
00f6aefe f6839a00000001 test byte ptr [rbx + 0x9a], 1
00f6af05 744d je 0x140f6af54
00f6af07 488b4368 mov rax, qword ptr [rbx + 0x68]
00f6af0b 8b4810 mov ecx, dword ptr [rax + 0x10]
00f6af0e 85c9 test ecx, ecx
00f6af10 752d jne 0x140f6af3f
00f6af12 398bac000000 cmp dword ptr [rbx + 0xac], ecx
00f6af18 751f jne 0x140f6af39
00f6af1a 488bcb mov rcx, rbx
00f6af1d e81e630200 call 0x140f91240
00f6af22 8983ac000000 mov dword ptr [rbx + 0xac], eax
00f6af28 85c0 test eax, eax
00f6af2a 740d je 0x140f6af39
00f6af2c ba3c000000 mov edx, 0x3c
00f6af31 488bcb mov rcx, rbx
00f6af34 e8c7910200 call 0x140f94100
00f6af39 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
00f6af3f f7c10800c000 test ecx, 0xc00008
00f6af45 740d je 0x140f6af54
00f6af47 83bbbc00000000 cmp dword ptr [rbx + 0xbc], 0
00f6af4e 7544 jne 0x140f6af94
00f6af50 b001 mov al, 1
00f6af52 eb1d jmp 0x140f6af71
00f6af54 83bbb400000000 cmp dword ptr [rbx + 0xb4], 0
00f6af5b 7537 jne 0x140f6af94
00f6af5d 83bbbc00000000 cmp dword ptr [rbx + 0xbc], 0
00f6af64 752e jne 0x140f6af94
00f6af66 83bbb800000000 cmp dword ptr [rbx + 0xb8], 0
00f6af6d 7525 jne 0x140f6af94
00f6af6f 32c0 xor al, al
00f6af71 884759 mov byte ptr [rdi + 0x59], al
00f6af74 488d9678010000 lea rdx, [rsi + 0x178]
00f6af7b 448b83b0000000 mov r8d, dword ptr [rbx + 0xb0]
00f6af82 488d8fc0000000 lea rcx, [rdi + 0xc0]
00f6af89 41b101 mov r9b, 1
00f6af8c e85f50c9ff call 0x140bffff0
00f6af91 40b501 mov bpl, 1
00f6af94 400fb6c5 movzx eax, bpl
00f6af98 488b742440 mov rsi, qword ptr [rsp + 0x40]
00f6af9d 488b5c2448 mov rbx, qword ptr [rsp + 0x48]
00f6afa2 488b6c2450 mov rbp, qword ptr [rsp + 0x50]
00f6afa7 4883c430 add rsp, 0x30
00f6afab 5f pop rdi
00f6afac c3 ret 