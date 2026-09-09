; Original iTunes.exe machine code; base=0x140000000; RVA=0x106aba0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x106aba0..0x106ac76 (exclusive)
0106aba0 mov        qword ptr [rsp + 0x10], rbx
0106aba5 mov        qword ptr [rsp + 0x18], rbp
0106abaa mov        qword ptr [rsp + 0x20], rsi
0106abaf push       rdi
0106abb0 push       r14
0106abb2 push       r15
0106abb4 sub        rsp, 0x30
0106abb8 lea        rsi, [rcx + 0x120]
0106abbf mov        qword ptr [rsp + 0x50], 0
0106abc8 mov        rbx, qword ptr [rsi]
0106abcb mov        rbp, r9
0106abce mov        r14, r8
0106abd1 mov        r15, rdx
0106abd4 mov        rdi, rcx
0106abd7 cmp        byte ptr [rbx + 5], 0
0106abdb je         0x14106abeb
0106abdd mov        rcx, qword ptr [rbx + 0x40]
0106abe1 mov        rdi, rsi
0106abe4 mov        qword ptr [rsp + 0x50], rcx
0106abe9 jmp        0x14106ac09
0106abeb mov        rcx, qword ptr [rbx + 8]
0106abef lea        rdx, [rsp + 0x50]
0106abf4 call       0x140bd6640
0106abf9 test       eax, eax
0106abfb jne        0x14106ac5d
0106abfd mov        rcx, qword ptr [rsp + 0x50]
0106ac02 add        rdi, 0x120
0106ac09 cmp        byte ptr [rbx + 5], 0
0106ac0d mov        rax, qword ptr [rbx + 0x20]
0106ac11 je         0x14106ac1c
0106ac13 sub        rax, qword ptr [rbx + 0x38]
0106ac17 dec        rax
0106ac1a jmp        0x14106ac20
0106ac1c sub        rax, qword ptr [rbx + 0x30]
0106ac20 add        rax, rcx
0106ac23 mov        rdx, r15
0106ac26 mov        rcx, qword ptr [rsi]
0106ac29 mov        qword ptr [rsp + 0x50], rax
0106ac2e call       0x140ba09a0
0106ac33 test       eax, eax
0106ac35 jne        0x14106ac5d
0106ac37 mov        rcx, qword ptr [rdi]
0106ac3a lea        rdx, [rsp + 0x20]
0106ac3f mov        r8, r14
0106ac42 mov        qword ptr [rsp + 0x20], rbp
0106ac47 call       0x140ba04c0
0106ac4c test       eax, eax
0106ac4e jne        0x14106ac5d
0106ac50 mov        rdx, qword ptr [rsp + 0x50]
0106ac55 mov        rcx, qword ptr [rdi]
0106ac58 call       0x140ba09a0
0106ac5d mov        rbx, qword ptr [rsp + 0x58]
0106ac62 mov        rbp, qword ptr [rsp + 0x60]
0106ac67 mov        rsi, qword ptr [rsp + 0x68]
0106ac6c add        rsp, 0x30
0106ac70 pop        r15
0106ac72 pop        r14
0106ac74 pop        rdi
0106ac75 ret        
