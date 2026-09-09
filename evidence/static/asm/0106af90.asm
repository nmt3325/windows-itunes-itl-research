; Original iTunes.exe machine code; base=0x140000000; RVA=0x106af90; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x106af90..0x106b030 (exclusive)
0106af90 mov        qword ptr [rsp + 8], rbx
0106af95 mov        qword ptr [rsp + 0x10], rsi
0106af9a push       rdi
0106af9b sub        rsp, 0x20
0106af9f mov        rsi, qword ptr [rsp + 0x50]
0106afa4 mov        r10, qword ptr [rsi]
0106afa7 lea        rbx, [r10 + 0x18]
0106afab test       r10, r10
0106afae je         0x14106afb8
0106afb0 mov        qword ptr [r10 + 0x10], 0
0106afb8 lea        eax, [r8 + 0x18]
0106afbc mov        dword ptr [r10], 0x686f686d
0106afc3 mov        dword ptr [r10 + 8], eax
0106afc7 mov        dword ptr [r10 + 4], 0x18
0106afcf mov        dword ptr [r10 + 0xc], r9d
0106afd3 cmp        byte ptr [rcx + 0x52], 0
0106afd7 jne        0x14106afff
0106afd9 mov        dword ptr [r10], 0x6d686f68
0106afe0 mov        dword ptr [r10 + 4], 0x18000000
0106afe8 bswap      eax
0106afea mov        dword ptr [r10 + 8], eax
0106afee bswap      r9d
0106aff1 mov        dword ptr [r10 + 0xc], r9d
0106aff5 mov        eax, dword ptr [r10 + 0x10]
0106aff9 bswap      eax
0106affb mov        dword ptr [r10 + 0x10], eax
0106afff mov        edi, r8d
0106b002 test       rdx, rdx
0106b005 je         0x14106b017
0106b007 test       rbx, rbx
0106b00a je         0x14106b017
0106b00c mov        r8d, edi
0106b00f mov        rcx, rbx
0106b012 call       0x141867875
0106b017 lea        rax, [rdi + rbx]
0106b01b mov        rbx, qword ptr [rsp + 0x30]
0106b020 mov        qword ptr [rsi], rax
0106b023 xor        eax, eax
0106b025 mov        rsi, qword ptr [rsp + 0x38]
0106b02a add        rsp, 0x20
0106b02e pop        rdi
0106b02f ret        
