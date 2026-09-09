; Original iTunes.exe machine code; base=0x140000000; RVA=0x106cba0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x106cba0..0x106ccda (exclusive)
0106cba0 mov        qword ptr [rsp + 0x10], rbx
0106cba5 push       rbp
0106cba6 lea        rbp, [rsp - 0x30]
0106cbab sub        rsp, 0x130
0106cbb2 mov        rax, qword ptr [rip + 0xf68487]
0106cbb9 xor        rax, rsp
0106cbbc mov        qword ptr [rbp + 0x20], rax
0106cbc0 cmp        byte ptr [rcx + 0x52], 0
0106cbc4 xorps      xmm0, xmm0
0106cbc7 movaps     xmmword ptr [rsp + 0x40], xmm0
0106cbcc mov        rbx, rcx
0106cbcf movaps     xmmword ptr [rsp + 0x50], xmm0
0106cbd4 movaps     xmmword ptr [rsp + 0x60], xmm0
0106cbd9 movaps     xmmword ptr [rsp + 0x70], xmm0
0106cbde movaps     xmmword ptr [rbp - 0x80], xmm0
0106cbe2 mov        dword ptr [rsp + 0x30], 0x6864736d
0106cbea mov        dword ptr [rsp + 0x34], 0x60
0106cbf2 mov        dword ptr [rsp + 0x3c], 0x10
0106cbfa mov        dword ptr [rsp + 0x38], 0xf0
0106cc02 jne        0x14106cc24
0106cc04 mov        dword ptr [rsp + 0x30], 0x6d736468
0106cc0c mov        dword ptr [rsp + 0x34], 0x60000000
0106cc14 mov        dword ptr [rsp + 0x38], 0xf0000000
0106cc1c mov        dword ptr [rsp + 0x3c], 0x10000000
0106cc24 mov        rcx, qword ptr [rcx + 0x120]
0106cc2b lea        r8, [rsp + 0x30]
0106cc30 lea        rdx, [rsp + 0x20]
0106cc35 mov        qword ptr [rsp + 0x20], 0x60
0106cc3e call       0x140ba04c0
0106cc43 test       eax, eax
0106cc45 jne        0x14106ccbd
0106cc47 movups     xmm0, xmmword ptr [rbx]
0106cc4a movups     xmm1, xmmword ptr [rbx + 0x10]
0106cc4e movaps     xmmword ptr [rbp - 0x70], xmm0
0106cc52 movups     xmm0, xmmword ptr [rbx + 0x20]
0106cc56 movaps     xmmword ptr [rbp - 0x60], xmm1
0106cc5a movups     xmm1, xmmword ptr [rbx + 0x30]
0106cc5e movaps     xmmword ptr [rbp - 0x50], xmm0
0106cc62 movups     xmm0, xmmword ptr [rbx + 0x40]
0106cc66 movaps     xmmword ptr [rbp - 0x40], xmm1
0106cc6a movups     xmm1, xmmword ptr [rbx + 0x50]
0106cc6e movaps     xmmword ptr [rbp - 0x30], xmm0
0106cc72 movups     xmm0, xmmword ptr [rbx + 0x60]
0106cc76 movaps     xmmword ptr [rbp - 0x20], xmm1
0106cc7a movups     xmm1, xmmword ptr [rbx + 0x70]
0106cc7e movaps     xmmword ptr [rbp - 0x10], xmm0
0106cc82 movups     xmm0, xmmword ptr [rbx + 0x80]
0106cc89 movaps     xmmword ptr [rbp], xmm1
0106cc8d movaps     xmmword ptr [rbp + 0x10], xmm0
0106cc91 cmp        byte ptr [rbx + 0x52], al
0106cc94 jne        0x14106cc9f
0106cc96 lea        rcx, [rbp - 0x70]
0106cc9a call       0x141068f90
0106cc9f mov        rcx, qword ptr [rbx + 0x120]
0106cca6 lea        r8, [rbp - 0x70]
0106ccaa lea        rdx, [rsp + 0x20]
0106ccaf mov        qword ptr [rsp + 0x20], 0x90
0106ccb8 call       0x140ba04c0
0106ccbd mov        rcx, qword ptr [rbp + 0x20]
0106ccc1 xor        rcx, rsp
0106ccc4 call       0x14179b8e0
0106ccc9 mov        rbx, qword ptr [rsp + 0x148]
0106ccd1 add        rsp, 0x130
0106ccd8 pop        rbp
0106ccd9 ret        
