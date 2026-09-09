00fd4880 4883ec28 sub rsp, 0x28
00fd4884 4885c9 test rcx, rcx
00fd4887 0f8446010000 je 0x140fd49d3
00fd488d 488b01 mov rax, qword ptr [rcx]
00fd4890 4885c0 test rax, rax
00fd4893 0f843a010000 je 0x140fd49d3
00fd4899 813874736c70 cmp dword ptr [rax], 0x706c7374
00fd489f 0f852e010000 jne 0x140fd49d3
00fd48a5 83792800 cmp dword ptr [rcx + 0x28], 0
00fd48a9 0f8424010000 je 0x140fd49d3
00fd48af f6414b01 test byte ptr [rcx + 0x4b], 1
00fd48b3 0f851a010000 jne 0x140fd49d3
00fd48b9 48895c2420 mov qword ptr [rsp + 0x20], rbx
00fd48be 488b5930 mov rbx, qword ptr [rcx + 0x30]
00fd48c2 4885db test rbx, rbx
00fd48c5 0f8481000000 je 0x140fd494c
00fd48cb 488b4310 mov rax, qword ptr [rbx + 0x10]
00fd48cf 4885c0 test rax, rax
00fd48d2 7478 je 0x140fd494c
00fd48d4 8b8084000000 mov eax, dword ptr [rax + 0x84]
00fd48da 3d6d757369 cmp eax, 0x6973756d
00fd48df 7717 ja 0x140fd48f8
00fd48e1 7427 je 0x140fd490a
00fd48e3 3d6c696220 cmp eax, 0x2062696c
00fd48e8 7420 je 0x140fd490a
00fd48ea 3d69506f64 cmp eax, 0x646f5069
00fd48ef 7419 je 0x140fd490a
00fd48f1 3d72616469 cmp eax, 0x69646172
00fd48f6 eb10 jmp 0x140fd4908
00fd48f8 3d6d656472 cmp eax, 0x7264656d
00fd48fd 0f84c4000000 je 0x140fd49c7
00fd4903 3d73727672 cmp eax, 0x72767273
00fd4908 7542 jne 0x140fd494c
00fd490a f6839b00000020 test byte ptr [rbx + 0x9b], 0x20
00fd4911 0f85b0000000 jne 0x140fd49c7
00fd4917 f683a000000001 test byte ptr [rbx + 0xa0], 1
00fd491e 0f85a3000000 jne 0x140fd49c7
00fd4924 488bcb mov rcx, rbx
00fd4927 e814123bff call 0x140385b40
00fd492c 4885c0 test rax, rax
00fd492f 741b je 0x140fd494c
00fd4931 8b4834 mov ecx, dword ptr [rax + 0x34]
00fd4934 81f9454c4946 cmp ecx, 0x46494c45
00fd493a 743b je 0x140fd4977
00fd493c 81f950545448 cmp ecx, 0x48545450
00fd4942 7414 je 0x140fd4958
00fd4944 81f944524853 cmp ecx, 0x53485244
00fd494a 742b je 0x140fd4977
00fd494c 488b5c2420 mov rbx, qword ptr [rsp + 0x20]
00fd4951 32c0 xor al, al
00fd4953 4883c428 add rsp, 0x28
00fd4957 c3 ret 
00fd4958 488b4808 mov rcx, qword ptr [rax + 8]
00fd495c 4885c9 test rcx, rcx
00fd495f 74eb je 0x140fd494c
00fd4961 f6819d00000040 test byte ptr [rcx + 0x9d], 0x40
00fd4968 750d jne 0x140fd4977
00fd496a 4883791000 cmp qword ptr [rcx + 0x10], 0
00fd496f 74db je 0x140fd494c
00fd4971 f6404240 test byte ptr [rax + 0x42], 0x40
00fd4975 74d5 je 0x140fd494c
00fd4977 48837b1000 cmp qword ptr [rbx + 0x10], 0
00fd497c 7449 je 0x140fd49c7
00fd497e f6839a00000001 test byte ptr [rbx + 0x9a], 1
00fd4985 7440 je 0x140fd49c7
00fd4987 488b4368 mov rax, qword ptr [rbx + 0x68]
00fd498b 8b4810 mov ecx, dword ptr [rax + 0x10]
00fd498e 85c9 test ecx, ecx
00fd4990 752d jne 0x140fd49bf
00fd4992 398bac000000 cmp dword ptr [rbx + 0xac], ecx
00fd4998 751f jne 0x140fd49b9
00fd499a 488bcb mov rcx, rbx
00fd499d e89ec8fbff call 0x140f91240
00fd49a2 8983ac000000 mov dword ptr [rbx + 0xac], eax
00fd49a8 85c0 test eax, eax
00fd49aa 740d je 0x140fd49b9
00fd49ac ba3c000000 mov edx, 0x3c
00fd49b1 488bcb mov rcx, rbx
00fd49b4 e847f7fbff call 0x140f94100
00fd49b9 8b8bac000000 mov ecx, dword ptr [rbx + 0xac]
00fd49bf f7c10000c000 test ecx, 0xc00000
00fd49c5 7585 jne 0x140fd494c
00fd49c7 488b5c2420 mov rbx, qword ptr [rsp + 0x20]
00fd49cc b001 mov al, 1
00fd49ce 4883c428 add rsp, 0x28
00fd49d2 c3 ret 
00fd49d3 32c0 xor al, al
00fd49d5 4883c428 add rsp, 0x28
00fd49d9 c3 ret 