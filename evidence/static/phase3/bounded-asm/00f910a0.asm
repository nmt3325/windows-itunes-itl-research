00f910a0 4889742410 mov qword ptr [rsp + 0x10], rsi
00f910a5 57 push rdi
00f910a6 4883ec30 sub rsp, 0x30
00f910aa 488bf9 mov rdi, rcx
00f910ad 4885c9 test rcx, rcx
00f910b0 7406 je 0x140f910b8
00f910b2 488b7110 mov rsi, qword ptr [rcx + 0x10]
00f910b6 eb02 jmp 0x140f910ba
00f910b8 33f6 xor esi, esi
00f910ba f6819a00000001 test byte ptr [rcx + 0x9a], 1
00f910c1 488d4110 lea rax, [rcx + 0x10]
00f910c5 48895c2440 mov qword ptr [rsp + 0x40], rbx
00f910ca 0f84a0000000 je 0x140f91170
00f910d0 488b4960 mov rcx, qword ptr [rcx + 0x60]
00f910d4 4885c9 test rcx, rcx
00f910d7 742a je 0x140f91103
00f910d9 f6861201000004 test byte ptr [rsi + 0x112], 4
00f910e0 7521 jne 0x140f91103
00f910e2 488b5938 mov rbx, qword ptr [rcx + 0x38]
00f910e6 e895be0200 call 0x140fbcf80
00f910eb 488bcb mov rcx, rbx
00f910ee 4885db test rbx, rbx
00f910f1 75ef jne 0x140f910e2
00f910f3 488b5c2440 mov rbx, qword ptr [rsp + 0x40]
00f910f8 488b742448 mov rsi, qword ptr [rsp + 0x48]
00f910fd 4883c430 add rsp, 0x30
00f91101 5f pop rdi
00f91102 c3 ret 
00f91103 0fb6879b000000 movzx eax, byte ptr [rdi + 0x9b]
00f9110a a802 test al, 2
00f9110c 0f8513010000 jne 0x140f91225
00f91112 0c02 or al, 2
00f91114 488bcf mov rcx, rdi
00f91117 88879b000000 mov byte ptr [rdi + 0x9b], al
00f9111d e85e2f0000 call 0x140f94080
00f91122 4c8b0e mov r9, qword ptr [rsi]
00f91125 4c8bc7 mov r8, rdi
00f91128 ba69727464 mov edx, 0x64747269
00f9112d 48c744242000000000 mov qword ptr [rsp + 0x20], 0
00f91136 488bce mov rcx, rsi
00f91139 498b4108 mov rax, qword ptr [r9 + 8]
00f9113d 4533c9 xor r9d, r9d
00f91140 ffd0 call rax
00f91142 488b4f58 mov rcx, qword ptr [rdi + 0x58]
00f91146 4885c9 test rcx, rcx
00f91149 7419 je 0x140f91164
00f9114b f6861201000004 test byte ptr [rsi + 0x112], 4
00f91152 7510 jne 0x140f91164
00f91154 488b19 mov rbx, qword ptr [rcx]
00f91157 e8144f0100 call 0x140fa6070
00f9115c 488bcb mov rcx, rbx
00f9115f 4885db test rbx, rbx
00f91162 75f0 jne 0x140f91154
00f91164 488bcf mov rcx, rdi
00f91167 e844210000 call 0x140f932b0
00f9116c 488d4710 lea rax, [rdi + 0x10]
00f91170 48833800 cmp qword ptr [rax], 0
00f91174 7438 je 0x140f911ae
00f91176 488b4f40 mov rcx, qword ptr [rdi + 0x40]
00f9117a 4885c9 test rcx, rcx
00f9117d 741f je 0x140f9119e
00f9117f 81b98800000069737461 cmp dword ptr [rcx + 0x88], 0x61747369
00f91189 7513 jne 0x140f9119e
00f9118b 4883793000 cmp qword ptr [rcx + 0x30], 0
00f91190 740c je 0x140f9119e
00f91192 488bd7 mov rdx, rdi
00f91195 e826d4fdff call 0x140f6e5c0
00f9119a 488d4710 lea rax, [rdi + 0x10]
00f9119e 48833800 cmp qword ptr [rax], 0
00f911a2 740a je 0x140f911ae
00f911a4 33d2 xor edx, edx
00f911a6 488bcf mov rcx, rdi
00f911a9 e8a2b3fdff call 0x140f6c550
00f911ae 488bcf mov rcx, rdi
00f911b1 e87af1ffff call 0x140f90330
00f911b6 488b4f68 mov rcx, qword ptr [rdi + 0x68]
00f911ba f60101 test byte ptr [rcx], 1
00f911bd 7415 je 0x140f911d4
00f911bf e8dcf0ffff call 0x140f902a0
00f911c4 488b5768 mov rdx, qword ptr [rdi + 0x68]
00f911c8 488b8e30010000 mov rcx, qword ptr [rsi + 0x130]
00f911cf e8fc51c3ff call 0x140bc63d0
00f911d4 488b5770 mov rdx, qword ptr [rdi + 0x70]
00f911d8 f60201 test byte ptr [rdx], 1
00f911db 740c je 0x140f911e9
00f911dd 488b8e40010000 mov rcx, qword ptr [rsi + 0x140]
00f911e4 e8e751c3ff call 0x140bc63d0
00f911e9 488b5778 mov rdx, qword ptr [rdi + 0x78]
00f911ed f60201 test byte ptr [rdx], 1
00f911f0 740c je 0x140f911fe
00f911f2 488b8e58010000 mov rcx, qword ptr [rsi + 0x158]
00f911f9 e8d251c3ff call 0x140bc63d0
00f911fe 488b9780000000 mov rdx, qword ptr [rdi + 0x80]
00f91205 f60201 test byte ptr [rdx], 1
00f91208 740c je 0x140f91216
00f9120a 488b8e60010000 mov rcx, qword ptr [rsi + 0x160]
00f91211 e8ba51c3ff call 0x140bc63d0
00f91216 488b8e20010000 mov rcx, qword ptr [rsi + 0x120]
00f9121d 488bd7 mov rdx, rdi
00f91220 e8ab51c3ff call 0x140bc63d0
00f91225 488b5c2440 mov rbx, qword ptr [rsp + 0x40]
00f9122a 488b742448 mov rsi, qword ptr [rsp + 0x48]
00f9122f 4883c430 add rsp, 0x30
00f91233 5f pop rdi
00f91234 c3 ret 