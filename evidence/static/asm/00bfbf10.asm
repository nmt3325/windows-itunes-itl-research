; Original iTunes.exe machine code; base=0x140000000; RVA=0xbfbf10; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0xbfbf10..0xbfbf88 (exclusive)
00bfbf10 push       rbx
00bfbf12 sub        rsp, 0x30
00bfbf16 mov        rbx, rcx
00bfbf19 test       rcx, rcx
00bfbf1c jne        0x140bfbf29
00bfbf1e mov        eax, 0x206d
00bfbf23 add        rsp, 0x30
00bfbf27 pop        rbx
00bfbf28 ret        
00bfbf29 mov        eax, dword ptr [rcx + 8]
00bfbf2c mov        byte ptr [rcx], 0
00bfbf2f cmp        eax, 3
00bfbf32 je         0x140bfbf39
00bfbf34 cmp        eax, 4
00bfbf37 jne        0x140bfbf4b
00bfbf39 cmp        qword ptr [rcx + 0x28], 0
00bfbf3e jne        0x140bfbf4b
00bfbf40 mov        eax, 0x20a0
00bfbf45 add        rsp, 0x30
00bfbf49 pop        rbx
00bfbf4a ret        
00bfbf4b mov        ecx, dword ptr [rcx + 4]
00bfbf4e mov        edx, ecx
00bfbf50 sub        edx, 1
00bfbf53 je         0x140bfbf6c
00bfbf55 cmp        edx, 1
00bfbf58 je         0x140bfbf65
00bfbf5a mov        eax, 0x20a2
00bfbf5f add        rsp, 0x30
00bfbf63 pop        rbx
00bfbf64 ret        
00bfbf65 mov        edx, 0x20
00bfbf6a jmp        0x140bfbf71
00bfbf6c mov        edx, 0x10
00bfbf71 cmp        qword ptr [rbx + 0x10], 0
00bfbf76 je         0x140bfc0c3
00bfbf7c movzx      eax, byte ptr [rbx + 0x18]
00bfbf80 cmp        eax, edx
00bfbf82 jne        0x140bfc0c3
; range 0xbfbf88..0xbfbfa6 (exclusive)
00bfbf88 mov        qword ptr [rsp + 0x48], rdi
00bfbf8d sub        ecx, 1
00bfbf90 je         0x140bfc06d
00bfbf96 cmp        ecx, 1
00bfbf99 jne        0x140bfc0b3
00bfbf9f lea        rdx, [rip + 0xd16c5a]
; range 0xbfbfa6..0xbfbfdd (exclusive)
00bfbfa6 mov        qword ptr [rsp + 0x40], rsi
00bfbfab mov        ecx, 8
00bfbfb0 call       0x14179beec
00bfbfb5 xor        edi, edi
00bfbfb7 mov        rsi, rax
00bfbfba test       rax, rax
00bfbfbd je         0x140bfbfc9
00bfbfbf call       0x1417e8bc0
00bfbfc4 mov        qword ptr [rsi], rax
00bfbfc7 jmp        0x140bfbfcc
00bfbfc9 mov        rsi, rdi
00bfbfcc mov        ecx, dword ptr [rbx + 8]
00bfbfcf mov        qword ptr [rbx + 0x20], rsi
00bfbfd3 mov        rsi, qword ptr [rsp + 0x40]
00bfbfd8 sub        ecx, 1
00bfbfdb je         0x140bfc003
; range 0xbfbfdd..0xbfc003 (exclusive)
00bfbfdd sub        ecx, 1
00bfbfe0 je         0x140bfbff3
00bfbfe2 sub        ecx, 1
00bfbfe5 je         0x140bfbff3
00bfbfe7 cmp        ecx, 1
00bfbfea jne        0x140bfc00b
00bfbfec call       0x1417eb1a0
00bfbff1 jmp        0x140bfc008
00bfbff3 mov        rdi, qword ptr [rsp + 0x48]
00bfbff8 mov        eax, 0x2072
00bfbffd add        rsp, 0x30
00bfc001 pop        rbx
00bfc002 ret        
; range 0xbfc003..0xbfc06d (exclusive)
00bfc003 call       0x1417eb1f0
00bfc008 mov        rdi, rax
00bfc00b mov        ecx, dword ptr [rbx + 0xc]
00bfc00e sub        ecx, 1
00bfc011 je         0x140bfc039
00bfc013 cmp        ecx, 1
00bfc016 jne        0x140bfc05d
00bfc018 mov        rcx, qword ptr [rbx + 0x20]
00bfc01c xor        r8d, r8d
00bfc01f mov        rax, qword ptr [rbx + 0x28]
00bfc023 mov        rdx, rdi
00bfc026 mov        r9, qword ptr [rbx + 0x10]
00bfc02a mov        qword ptr [rsp + 0x20], rax
00bfc02f mov        rcx, qword ptr [rcx]
00bfc032 call       0x1417e9360
00bfc037 jmp        0x140bfc058
00bfc039 mov        rcx, qword ptr [rbx + 0x20]
00bfc03d xor        r8d, r8d
00bfc040 mov        rax, qword ptr [rbx + 0x28]
00bfc044 mov        rdx, rdi
00bfc047 mov        r9, qword ptr [rbx + 0x10]
00bfc04b mov        qword ptr [rsp + 0x20], rax
00bfc050 mov        rcx, qword ptr [rcx]
00bfc053 call       0x1417e9640
00bfc058 cmp        eax, 1
00bfc05b je         0x140bfc0b3
00bfc05d mov        rdi, qword ptr [rsp + 0x48]
00bfc062 mov        eax, 0x20a4
00bfc067 add        rsp, 0x30
00bfc06b pop        rbx
00bfc06c ret        
; range 0xbfc06d..0xbfc0c3 (exclusive)
00bfc06d lea        rdx, [rip + 0xd16b8c]
00bfc074 mov        ecx, 0x204
00bfc079 call       0x14179beec
00bfc07e mov        rdi, rax
00bfc081 test       rax, rax
00bfc084 je         0x140bfc098
00bfc086 xor        edx, edx
00bfc088 mov        r8d, 0x204
00bfc08e mov        rcx, rax
00bfc091 call       0x14179cca0
00bfc096 jmp        0x140bfc09a
00bfc098 xor        edi, edi
00bfc09a mov        rdx, qword ptr [rbx + 0x10]
00bfc09e mov        r9, rdi
00bfc0a1 mov        ecx, dword ptr [rbx + 0xc]
00bfc0a4 mov        r8d, 0x80
00bfc0aa mov        qword ptr [rbx + 0x20], rdi
00bfc0ae call       0x140bf9a90
00bfc0b3 mov        rdi, qword ptr [rsp + 0x48]
00bfc0b8 xor        eax, eax
00bfc0ba mov        byte ptr [rbx], 1
00bfc0bd add        rsp, 0x30
00bfc0c1 pop        rbx
00bfc0c2 ret        
; range 0xbfc0c3..0xbfc0ce (exclusive)
00bfc0c3 mov        eax, 0x20a3
00bfc0c8 add        rsp, 0x30
00bfc0cc pop        rbx
00bfc0cd ret        
