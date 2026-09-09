; Original iTunes.exe machine code; base=0x140000000; RVA=0x106ab70; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x106ab70..0x106ab92 (exclusive)
0106ab70 sub        rsp, 0x28
0106ab74 mov        rcx, qword ptr [rcx + 0x120]
0106ab7b mov        qword ptr [rsp + 0x30], r8
0106ab80 mov        r8, rdx
0106ab83 lea        rdx, [rsp + 0x30]
0106ab88 call       0x140ba04c0
0106ab8d add        rsp, 0x28
0106ab91 ret        
