; Original iTunes.exe machine code; base=0x140000000; RVA=0x106a430; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x106a430..0x106a520 (exclusive)
0106a430 push       rbx
0106a432 sub        rsp, 0x20
0106a436 mov        rbx, rcx
0106a439 test       rcx, rcx
0106a43c je         0x14106a46a
0106a43e xorps      xmm0, xmm0
0106a441 xor        eax, eax
0106a443 movups     xmmword ptr [rcx + 8], xmm0
0106a447 movups     xmmword ptr [rcx + 0x18], xmm0
0106a44b movups     xmmword ptr [rcx + 0x28], xmm0
0106a44f movups     xmmword ptr [rcx + 0x38], xmm0
0106a453 movups     xmmword ptr [rcx + 0x48], xmm0
0106a457 movups     xmmword ptr [rcx + 0x58], xmm0
0106a45b movups     xmmword ptr [rcx + 0x68], xmm0
0106a45f movups     xmmword ptr [rcx + 0x78], xmm0
0106a463 mov        qword ptr [rcx + 0x88], rax
0106a46a mov        dword ptr [rcx], 0x6864666d
0106a470 mov        dword ptr [rcx + 4], 0x90
0106a477 mov        rcx, qword ptr [rcx + 0x1e00270]
0106a47e mov        rax, qword ptr [rcx + 0x88]
0106a485 mov        qword ptr [rbx + 0x34], rax
0106a489 mov        word ptr [rbx + 0x40], 0x202
0106a48f mov        byte ptr [rbx + 0x43], 0
0106a493 mov        word ptr [rbx + 0x50], 0x38
0106a499 mov        byte ptr [rbx + 0x52], 1
0106a49d mov        eax, dword ptr [rcx + 0x94]
0106a4a3 mov        dword ptr [rbx + 0x58], eax
0106a4a6 mov        dword ptr [rbx + 0x5c], 0x19000
0106a4ad mov        rax, qword ptr [rip + 0x103ca7c]
0106a4b4 test       rax, rax
0106a4b7 je         0x14106a4c0
0106a4b9 mov        rax, qword ptr [rax + 0xf4fc]
0106a4c0 mov        qword ptr [rbx + 0x68], rax
0106a4c4 call       qword ptr [rip + 0x87e90e]
0106a4ca mov        rax, qword ptr [rip + 0x87e97f]
0106a4d1 addsd      xmm0, qword ptr [rax]
0106a4d5 mov        dword ptr [rbx + 0xc], 0x10043
0106a4dc mov        dword ptr [rbx + 0x3c], 0x6f
0106a4e3 cvttsd2si  rax, xmm0
0106a4e8 mov        dword ptr [rbx + 0x70], eax
0106a4eb add        rbx, 0x10
0106a4ef je         0x14106a51a
0106a4f1 mov        byte ptr [rbx], 0
0106a4f4 lea        rcx, [rip + 0xa0117d]
0106a4fb lea        rdx, [rbx + 1]
0106a4ff xor        al, al
0106a501 cmp        al, 0x1f
0106a503 je         0x14106a51a
0106a505 movzx      eax, byte ptr [rcx]
0106a508 inc        rcx
0106a50b mov        byte ptr [rdx], al
0106a50d inc        rdx
0106a510 inc        byte ptr [rbx]
0106a512 movzx      eax, byte ptr [rbx]
0106a515 cmp        byte ptr [rcx], 0
0106a518 jne        0x14106a501
0106a51a add        rsp, 0x20
0106a51e pop        rbx
0106a51f ret        
