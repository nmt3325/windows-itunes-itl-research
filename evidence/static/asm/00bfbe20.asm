; Original iTunes.exe machine code; base=0x140000000; RVA=0xbfbe20; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0xbfbe20..0xbfbf0f (exclusive)
00bfbe20 mov        qword ptr [rsp + 8], rbx
00bfbe25 push       rdi
00bfbe26 sub        rsp, 0x20
00bfbe2a mov        edi, edx
00bfbe2c mov        rbx, rcx
00bfbe2f test       rcx, rcx
00bfbe32 jne        0x140bfbe44
00bfbe34 mov        eax, 0x206c
00bfbe39 mov        rbx, qword ptr [rsp + 0x30]
00bfbe3e add        rsp, 0x20
00bfbe42 pop        rdi
00bfbe43 ret        
00bfbe44 cmp        byte ptr [rip + 0x14b3421], 0
00bfbe4b jne        0x140bfbedb
00bfbe51 lea        rax, [rip + 0x14d6ec8]
00bfbe58 mov        qword ptr [rip + 0x14d6e71], rax
00bfbe5f lea        rax, [rip + 0x14d6fba]
00bfbe66 mov        qword ptr [rip + 0x14d6e6b], rax
00bfbe6d lea        rax, [rip + 0x14d70ac]
00bfbe74 mov        qword ptr [rip + 0x14d6e65], rax
00bfbe7b lea        rax, [rip + 0x14d719e]
00bfbe82 mov        qword ptr [rip + 0x14d6e5f], rax
00bfbe89 lea        rax, [rip + 0x14d7290]
00bfbe90 mov        qword ptr [rip + 0x14d6e59], rax
00bfbe97 lea        rax, [rip + 0x14d72b2]
00bfbe9e mov        qword ptr [rip + 0x14d6e53], rax
00bfbea5 lea        rax, [rip + 0x14d82a4]
00bfbeac mov        qword ptr [rip + 0x14d6e4d], rax
00bfbeb3 lea        rax, [rip + 0x14d9296]
00bfbeba mov        qword ptr [rip + 0x14d6e47], rax
00bfbec1 lea        rax, [rip + 0x14da288]
00bfbec8 mov        qword ptr [rip + 0x14d6e41], rax
00bfbecf call       0x140bf9710
00bfbed4 mov        byte ptr [rip + 0x14b3391], 1
00bfbedb xor        eax, eax
00bfbedd mov        dword ptr [rbx], eax
00bfbedf mov        qword ptr [rbx + 0x10], rax
00bfbee3 mov        qword ptr [rbx + 0x18], rax
00bfbee7 mov        qword ptr [rbx + 0x20], rax
00bfbeeb mov        qword ptr [rbx + 0x28], rax
00bfbeef mov        qword ptr [rbx + 0x30], rax
00bfbef3 mov        dword ptr [rbx + 4], 1
00bfbefa mov        dword ptr [rbx + 8], 1
00bfbf01 mov        dword ptr [rbx + 0xc], edi
00bfbf04 mov        rbx, qword ptr [rsp + 0x30]
00bfbf09 add        rsp, 0x20
00bfbf0d pop        rdi
00bfbf0e ret        
