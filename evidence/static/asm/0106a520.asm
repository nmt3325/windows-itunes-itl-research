; Original iTunes.exe machine code; base=0x140000000; RVA=0x106a520; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x106a520..0x106a559 (exclusive)
0106a520 mov        r9, qword ptr [rcx + 0x1e00178]
0106a527 movsxd     r8, edx
0106a52a lea        rdx, [rcx + 0x1e00180]
0106a531 add        r8, qword ptr [rcx + 0x1e00170]
0106a538 mov        qword ptr [rcx + 0x1e00170], r8
0106a53f cmp        r8, r9
0106a542 jb         0x14106a54f
0106a544 mov        rcx, qword ptr [rdx]
0106a547 add        rcx, r9
0106a54a cmp        r8, rcx
0106a54d jb         0x14106a556
0106a54f mov        qword ptr [rdx], 0
0106a556 xor        eax, eax
0106a558 ret        
