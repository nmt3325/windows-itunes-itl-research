00fb77f0 48895c2410 mov qword ptr [rsp + 0x10], rbx
00fb77f5 48894c2408 mov qword ptr [rsp + 8], rcx
00fb77fa 57 push rdi
00fb77fb 4883ec20 sub rsp, 0x20
00fb77ff 488bf9 mov rdi, rcx
00fb7802 488b09 mov rcx, qword ptr [rcx]
00fb7805 4885c9 test rcx, rcx
00fb7808 7542 jne 0x140fb784c
00fb780a 488b5f08 mov rbx, qword ptr [rdi + 8]
00fb780e 4885db test rbx, rbx
00fb7811 742c je 0x140fb783f
00fb7813 bfffffffff mov edi, 0xffffffff
00fb7818 8bc7 mov eax, edi
00fb781a f00fc14308 lock xadd dword ptr [rbx + 8], eax
00fb781f 83f801 cmp eax, 1
00fb7822 751b jne 0x140fb783f
00fb7824 488b03 mov rax, qword ptr [rbx]
00fb7827 488bcb mov rcx, rbx
00fb782a ff10 call qword ptr [rax]
00fb782c f00fc17b0c lock xadd dword ptr [rbx + 0xc], edi
00fb7831 83ff01 cmp edi, 1
00fb7834 7509 jne 0x140fb783f
00fb7836 488b03 mov rax, qword ptr [rbx]
00fb7839 488bcb mov rcx, rbx
00fb783c ff5008 call qword ptr [rax + 8]
00fb783f 33c0 xor eax, eax
00fb7841 488b5c2438 mov rbx, qword ptr [rsp + 0x38]
00fb7846 4883c420 add rsp, 0x20
00fb784a 5f pop rdi
00fb784b c3 ret 
00fb784c 488b01 mov rax, qword ptr [rcx]
00fb784f ff5030 call qword ptr [rax + 0x30]
00fb7852 3d6d626c61 cmp eax, 0x616c626d
00fb7857 0f84dc000000 je 0x140fb7939
00fb785d 3d73747261 cmp eax, 0x61727473
00fb7862 0f84c7000000 je 0x140fb792f
00fb7868 3d6c796c70 cmp eax, 0x706c796c
00fb786d 0f849c000000 je 0x140fb790f
00fb7873 3d73646172 cmp eax, 0x72616473
00fb7878 0f8487000000 je 0x140fb7905
00fb787e 488b0f mov rcx, qword ptr [rdi]
00fb7881 3d6b617274 cmp eax, 0x7472616b
00fb7886 488b01 mov rax, qword ptr [rcx]
00fb7889 740d je 0x140fb7898
00fb788b ff90f0020000 call qword ptr [rax + 0x2f0]
00fb7891 8bd8 mov ebx, eax
00fb7893 e95c010000 jmp 0x140fb79f4
00fb7898 ff5048 call qword ptr [rax + 0x48]
00fb789b 488bd8 mov rbx, rax
00fb789e 4885c0 test rax, rax
00fb78a1 7454 je 0x140fb78f7
00fb78a3 4883781000 cmp qword ptr [rax + 0x10], 0
00fb78a8 744d je 0x140fb78f7
00fb78aa f6809a00000001 test byte ptr [rax + 0x9a], 1
00fb78b1 7444 je 0x140fb78f7
00fb78b3 488b4068 mov rax, qword ptr [rax + 0x68]
00fb78b7 8b4810 mov ecx, dword ptr [rax + 0x10]
00fb78ba 85c9 test ecx, ecx
00fb78bc 753b jne 0x140fb78f9
00fb78be 398bac000000 cmp dword ptr [rbx + 0xac], ecx
00fb78c4 751f jne 0x140fb78e5
00fb78c6 488bcb mov rcx, rbx
00fb78c9 e87299fdff call 0x140f91240
00fb78ce 8983ac000000 mov dword ptr [rbx + 0xac], eax
00fb78d4 85c0 test eax, eax
00fb78d6 740d je 0x140fb78e5
00fb78d8 ba3c000000 mov edx, 0x3c
00fb78dd 488bcb mov rcx, rbx
00fb78e0 e81bc8fdff call 0x140f94100
00fb78e5 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
00fb78eb e8c0fbffff call 0x140fb74b0
00fb78f0 8bd8 mov ebx, eax
00fb78f2 e9fd000000 jmp 0x140fb79f4
00fb78f7 33c9 xor ecx, ecx
00fb78f9 e8b2fbffff call 0x140fb74b0
00fb78fe 8bd8 mov ebx, eax
00fb7900 e9ef000000 jmp 0x140fb79f4
00fb7905 bb00000002 mov ebx, 0x2000000
00fb790a e9e5000000 jmp 0x140fb79f4
00fb790f 488b0f mov rcx, qword ptr [rdi]
00fb7912 488b01 mov rax, qword ptr [rcx]
00fb7915 ff9060010000 call qword ptr [rax + 0x160]
00fb791b bb00000004 mov ebx, 0x4000000
00fb7920 b900200000 mov ecx, 0x2000
00fb7925 84c0 test al, al
00fb7927 0f45d9 cmovne ebx, ecx
00fb792a e9c5000000 jmp 0x140fb79f4
00fb792f bb00400000 mov ebx, 0x4000
00fb7934 e9bb000000 jmp 0x140fb79f4
00fb7939 488b0f mov rcx, qword ptr [rdi]
00fb793c 488b01 mov rax, qword ptr [rcx]
00fb793f ff5078 call qword ptr [rax + 0x78]
00fb7942 4885c0 test rax, rax
00fb7945 7518 jne 0x140fb795f
00fb7947 488bcf mov rcx, rdi
00fb794a e8c1a329ff call 0x140251d10
00fb794f b800200000 mov eax, 0x2000
00fb7954 488b5c2438 mov rbx, qword ptr [rsp + 0x38]
00fb7959 4883c420 add rsp, 0x20
00fb795d 5f pop rdi
00fb795e c3 ret 
00fb795f 8b4810 mov ecx, dword ptr [rax + 0x10]
00fb7962 83e903 sub ecx, 3
00fb7965 0f8484000000 je 0x140fb79ef
00fb796b 83f901 cmp ecx, 1
00fb796e 7478 je 0x140fb79e8
00fb7970 488b0f mov rcx, qword ptr [rdi]
00fb7973 488b01 mov rax, qword ptr [rcx]
00fb7976 ff5048 call qword ptr [rax + 0x48]
00fb7979 488bd8 mov rbx, rax
00fb797c 4885c0 test rax, rax
00fb797f 7460 je 0x140fb79e1
00fb7981 4883781000 cmp qword ptr [rax + 0x10], 0
00fb7986 7459 je 0x140fb79e1
00fb7988 f6809a00000001 test byte ptr [rax + 0x9a], 1
00fb798f 7450 je 0x140fb79e1
00fb7991 488b4868 mov rcx, qword ptr [rax + 0x68]
00fb7995 8b4110 mov eax, dword ptr [rcx + 0x10]
00fb7998 85c0 test eax, eax
00fb799a 752d jne 0x140fb79c9
00fb799c 3983ac000000 cmp dword ptr [rbx + 0xac], eax
00fb79a2 751f jne 0x140fb79c3
00fb79a4 488bcb mov rcx, rbx
00fb79a7 e89498fdff call 0x140f91240
00fb79ac 8983ac000000 mov dword ptr [rbx + 0xac], eax
00fb79b2 85c0 test eax, eax
00fb79b4 740d je 0x140fb79c3
00fb79b6 ba3c000000 mov edx, 0x3c
00fb79bb 488bcb mov rcx, rbx
00fb79be e83dc7fdff call 0x140f94100
00fb79c3 8b83ac000000 mov eax, dword ptr [rbx + 0xac]
00fb79c9 a808 test al, 8
00fb79cb 7407 je 0x140fb79d4
00fb79cd bb04000000 mov ebx, 4
00fb79d2 eb20 jmp 0x140fb79f4
00fb79d4 0fbae016 bt eax, 0x16
00fb79d8 7307 jae 0x140fb79e1
00fb79da bb00008000 mov ebx, 0x800000
00fb79df eb13 jmp 0x140fb79f4
00fb79e1 bb00200000 mov ebx, 0x2000
00fb79e6 eb0c jmp 0x140fb79f4
00fb79e8 bb40000000 mov ebx, 0x40
00fb79ed eb05 jmp 0x140fb79f4
00fb79ef bb08000000 mov ebx, 8
00fb79f4 488bcf mov rcx, rdi
00fb79f7 e814a329ff call 0x140251d10
00fb79fc 8bc3 mov eax, ebx
00fb79fe 488b5c2438 mov rbx, qword ptr [rsp + 0x38]
00fb7a03 4883c420 add rsp, 0x20
00fb7a07 5f pop rdi
00fb7a08 c3 ret 