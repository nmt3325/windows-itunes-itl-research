00fb6800 48895c2408 mov qword ptr [rsp + 8], rbx
00fb6805 48896c2418 mov qword ptr [rsp + 0x18], rbp
00fb680a 56 push rsi
00fb680b 57 push rdi
00fb680c 4154 push r12
00fb680e 4156 push r14
00fb6810 4157 push r15
00fb6812 4883ec60 sub rsp, 0x60
00fb6816 0f29742450 movaps xmmword ptr [rsp + 0x50], xmm6
00fb681b 4c8bf2 mov r14, rdx
00fb681e 4032ed xor bpl, bpl
00fb6821 4885d2 test rdx, rdx
00fb6824 0f84e2010000 je 0x140fb6a0c
00fb682a 813a54534c4f cmp dword ptr [rdx], 0x4f4c5354
00fb6830 0f85d6010000 jne 0x140fb6a0c
00fb6836 837a0400 cmp dword ptr [rdx + 4], 0
00fb683a 0f84cc010000 je 0x140fb6a0c
00fb6840 488b4210 mov rax, qword ptr [rdx + 0x10]
00fb6844 482b4208 sub rax, qword ptr [rdx + 8]
00fb6848 48c1f804 sar rax, 4
00fb684c 48bfabaaaaaaaaaaaaaa movabs rdi, 0xaaaaaaaaaaaaaaab
00fb6856 480fafc7 imul rax, rdi
00fb685a 83f801 cmp eax, 1
00fb685d 0f82a9010000 jb 0x140fb6a0c
00fb6863 4885c9 test rcx, rcx
00fb6866 744c je 0x140fb68b4
00fb6868 488b0591151201 mov rax, qword ptr [rip + 0x1121591]
00fb686f 4885c0 test rax, rax
00fb6872 7422 je 0x140fb6896
00fb6874 48394818 cmp qword ptr [rax + 0x18], rcx
00fb6878 7509 jne 0x140fb6883
00fb687a 4038a8d6080000 cmp byte ptr [rax + 0x8d6], bpl
00fb6881 740a je 0x140fb688d
00fb6883 488b00 mov rax, qword ptr [rax]
00fb6886 4885c0 test rax, rax
00fb6889 75e9 jne 0x140fb6874
00fb688b eb09 jmp 0x140fb6896
00fb688d 4885c0 test rax, rax
00fb6890 0f8576010000 jne 0x140fb6a0c
00fb6896 488b05e3141201 mov rax, qword ptr [rip + 0x11214e3]
00fb689d 4885c0 test rax, rax
00fb68a0 7412 je 0x140fb68b4
00fb68a2 48394828 cmp qword ptr [rax + 0x28], rcx
00fb68a6 0f8460010000 je 0x140fb6a0c
00fb68ac 488b00 mov rax, qword ptr [rax]
00fb68af 4885c0 test rax, rax
00fb68b2 75ee jne 0x140fb68a2
00fb68b4 8b99f0010000 mov ebx, dword ptr [rcx + 0x1f0]
00fb68ba 81fb656e7574 cmp ebx, 0x74756e65
00fb68c0 7429 je 0x140fb68eb
00fb68c2 488d542430 lea rdx, [rsp + 0x30]
00fb68c7 e8147bf4ff call 0x140efe3e0
00fb68cc 85c0 test eax, eax
00fb68ce 0f8538010000 jne 0x140fb6a0c
00fb68d4 40386c2431 cmp byte ptr [rsp + 0x31], bpl
00fb68d9 0f852d010000 jne 0x140fb6a0c
00fb68df 81fb656c6966 cmp ebx, 0x66696c65
00fb68e5 0f8521010000 jne 0x140fb6a0c
00fb68eb 41813e54534c4f cmp dword ptr [r14], 0x4f4c5354
00fb68f2 0f8514010000 jne 0x140fb6a0c
00fb68f8 41837e0400 cmp dword ptr [r14 + 4], 0
00fb68fd 0f8409010000 je 0x140fb6a0c
00fb6903 4d8b7e10 mov r15, qword ptr [r14 + 0x10]
00fb6907 4d2b7e08 sub r15, qword ptr [r14 + 8]
00fb690b 49c1ff04 sar r15, 4
00fb690f 4c0fafff imul r15, rdi
00fb6913 33ff xor edi, edi
00fb6915 4585ff test r15d, r15d
00fb6918 0f84ee000000 je 0x140fb6a0c
00fb691e 41bc01000000 mov r12d, 1
00fb6924 4084ed test bpl, bpl
00fb6927 0f85df000000 jne 0x140fb6a0c
00fb692d 4533c0 xor r8d, r8d
00fb6930 8bd7 mov edx, edi
00fb6932 498bce mov rcx, r14
00fb6935 e8d67332ff call 0x1402ddd10
00fb693a 4885c0 test rax, rax
00fb693d 741e je 0x140fb695d
00fb693f f6809b00000008 test byte ptr [rax + 0x9b], 8
00fb6946 740d je 0x140fb6955
00fb6948 f6809a00000008 test byte ptr [rax + 0x9a], 8
00fb694f 0f85ac000000 jne 0x140fb6a01
00fb6955 40b501 mov bpl, 1
00fb6958 e9a4000000 jmp 0x140fb6a01
00fb695d 448bc7 mov r8d, edi
00fb6960 498bd6 mov rdx, r14
00fb6963 488d4c2420 lea rcx, [rsp + 0x20]
00fb6968 e8e37532ff call 0x1402ddf50
00fb696d 90 nop 
00fb696e 488b5c2428 mov rbx, qword ptr [rsp + 0x28]
00fb6973 4885db test rbx, rbx
00fb6976 7404 je 0x140fb697c
00fb6978 f0ff4308 lock inc dword ptr [rbx + 8]
00fb697c 0f28742420 movaps xmm6, xmmword ptr [rsp + 0x20]
00fb6981 660f7f742430 movdqa xmmword ptr [rsp + 0x30], xmm6
00fb6987 488d4c2430 lea rcx, [rsp + 0x30]
00fb698c e85fc9fbff call 0x140f732f0
00fb6991 84c0 test al, al
00fb6993 7438 je 0x140fb69cd
00fb6995 66480f7ef6 movq rsi, xmm6
00fb699a 488b06 mov rax, qword ptr [rsi]
00fb699d 488bce mov rcx, rsi
00fb69a0 ff5020 call qword ptr [rax + 0x20]
00fb69a3 84c0 test al, al
00fb69a5 7526 jne 0x140fb69cd
00fb69a7 488b06 mov rax, qword ptr [rsi]
00fb69aa 488bce mov rcx, rsi
00fb69ad ff5030 call qword ptr [rax + 0x30]
00fb69b0 3d73646172 cmp eax, 0x72616473
00fb69b5 7416 je 0x140fb69cd
00fb69b7 488b06 mov rax, qword ptr [rsi]
00fb69ba 488bce mov rcx, rsi
00fb69bd ff5030 call qword ptr [rax + 0x30]
00fb69c0 400fb6ed movzx ebp, bpl
00fb69c4 3d6c796c70 cmp eax, 0x706c796c
00fb69c9 410f45ec cmovne ebp, r12d
00fb69cd 4885db test rbx, rbx
00fb69d0 742f je 0x140fb6a01
00fb69d2 b8ffffffff mov eax, 0xffffffff
00fb69d7 f00fc14308 lock xadd dword ptr [rbx + 8], eax
00fb69dc 83f801 cmp eax, 1
00fb69df 7520 jne 0x140fb6a01
00fb69e1 488b03 mov rax, qword ptr [rbx]
00fb69e4 488bcb mov rcx, rbx
00fb69e7 ff10 call qword ptr [rax]
00fb69e9 b8ffffffff mov eax, 0xffffffff
00fb69ee f00fc1430c lock xadd dword ptr [rbx + 0xc], eax
00fb69f3 83f801 cmp eax, 1
00fb69f6 7509 jne 0x140fb6a01
00fb69f8 488b03 mov rax, qword ptr [rbx]
00fb69fb 488bcb mov rcx, rbx
00fb69fe ff5008 call qword ptr [rax + 8]
00fb6a01 ffc7 inc edi
00fb6a03 413bff cmp edi, r15d
00fb6a06 0f8218ffffff jb 0x140fb6924
00fb6a0c 400fb6c5 movzx eax, bpl
00fb6a10 4c8d5c2460 lea r11, [rsp + 0x60]
00fb6a15 498b5b30 mov rbx, qword ptr [r11 + 0x30]
00fb6a19 498b6b40 mov rbp, qword ptr [r11 + 0x40]
00fb6a1d 0f28742450 movaps xmm6, xmmword ptr [rsp + 0x50]
00fb6a22 498be3 mov rsp, r11
00fb6a25 415f pop r15
00fb6a27 415e pop r14
00fb6a29 415c pop r12
00fb6a2b 5f pop rdi
00fb6a2c 5e pop rsi
00fb6a2d c3 ret 