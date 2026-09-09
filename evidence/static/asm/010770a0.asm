; Original iTunes.exe machine code; base=0x140000000; RVA=0x10770a0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x10770a0..0x10770be (exclusive)
010770a0 push       rbp
010770a2 push       rsi
010770a3 push       rdi
010770a4 push       r12
010770a6 sub        rsp, 0x38
010770aa xor        edi, edi
010770ac mov        rbp, r8
010770af mov        r12, rdx
010770b2 mov        rsi, rcx
010770b5 test       r8, r8
010770b8 je         0x141077262
; range 0x10770be..0x1077258 (exclusive)
010770be mov        qword ptr [rsp + 0x68], r14
010770c3 lea        r14, [rcx + 0x1e00180]
010770ca mov        qword ptr [rsp + 0x60], rbx
010770cf mov        qword ptr [rsp + 0x30], r15
010770d4 mov        rdx, qword ptr [r14]
010770d7 test       rdx, rdx
010770da je         0x141077146
010770dc mov        r9, qword ptr [rsi + 0x1e00178]
010770e3 lea        rcx, [rsi + 0x1e00170]
010770ea mov        r8, qword ptr [rcx]
010770ed cmp        r8, r9
010770f0 jb         0x141077146
010770f2 lea        rax, [rdx + r9]
010770f6 cmp        r8, rax
010770f9 jae        0x141077146
010770fb sub        rdx, r8
010770fe mov        rbx, rbp
01077101 mov        r15, rcx
01077104 lea        rax, [rdx + r9]
01077108 cmp        rbp, rax
0107710b jbe        0x141077116
0107710d mov        ebx, eax
0107710f lea        r15, [rsi + 0x1e00170]
01077116 sub        r8, r9
01077119 lea        rdx, [rsi + 0x128]
01077120 add        rdx, r8
01077123 je         0x141077138
01077125 test       r12, r12
01077128 je         0x141077138
0107712a mov        r8, rbx
0107712d mov        rcx, r12
01077130 call       0x141867875
01077135 mov        rcx, r15
01077138 sub        rbp, rbx
0107713b add        r12, rbx
0107713e add        qword ptr [rcx], rbx
01077141 jmp        0x14107723e
01077146 mov        rbx, qword ptr [rsi + 0x1e00170]
0107714d xor        r15b, r15b
01077150 mov        rcx, qword ptr [rsi + 0x1e00160]
01077157 mov        edi, 0xa00000
0107715c cmp        rbx, rcx
0107715f jae        0x141077172
01077161 lea        rax, [rbx + 0xa00000]
01077168 cmp        rax, rcx
0107716b jbe        0x14107719d
0107716d mov        rdi, rcx
01077170 jmp        0x14107719a
01077172 mov        rdx, qword ptr [rsi + 0x1e00168]
01077179 cmp        rbx, rdx
0107717c jae        0x14107719d
0107717e sub        rbx, rcx
01077181 mov        r15b, 1
01077184 and        rbx, 0xfffffffffffffff0
01077188 add        rbx, rcx
0107718b lea        rax, [rbx + 0xa00000]
01077192 cmp        rax, rdx
01077195 jbe        0x14107719d
01077197 mov        rdi, rdx
0107719a sub        rdi, rbx
0107719d mov        rcx, qword ptr [rsi + 0x120]
010771a4 mov        rdx, rbx
010771a7 call       0x140ba09a0
010771ac test       eax, eax
010771ae jne        0x141077249
010771b4 mov        rcx, qword ptr [rsi + 0x120]
010771bb mov        rdx, r14
010771be mov        qword ptr [rsi + 0x1e00178], rbx
010771c5 lea        rbx, [rsi + 0x1400128]
010771cc mov        eax, edi
010771ce mov        r8, rbx
010771d1 mov        qword ptr [r14], rax
010771d4 call       0x140ba0350
010771d9 mov        edi, eax
010771db cmp        eax, -0x27
010771de jne        0x1410771e9
010771e0 cmp        qword ptr [r14], rbp
010771e3 jb         0x141077249
010771e5 xor        edi, edi
010771e7 jmp        0x1410771ed
010771e9 test       eax, eax
010771eb jne        0x141077249
010771ed lea        rax, [rsi + 0x128]
010771f4 test       r15b, r15b
010771f7 je         0x141077226
010771f9 mov        r8d, dword ptr [r14]
010771fc lea        rdx, [rsp + 0x70]
01077201 mov        qword ptr [rsp + 0x20], rdx
01077206 lea        rcx, [rsi + 0x1e00128]
0107720d mov        rdx, rbx
01077210 mov        dword ptr [rsp + 0x70], r8d
01077215 mov        r9, rax
01077218 call       0x140bfc580
0107721d mov        eax, dword ptr [rsp + 0x70]
01077221 mov        qword ptr [r14], rax
01077224 jmp        0x14107723e
01077226 test       rbx, rbx
01077229 je         0x14107723e
0107722b test       rax, rax
0107722e je         0x14107723e
01077230 mov        r8, qword ptr [r14]
01077233 mov        rdx, rbx
01077236 mov        rcx, rax
01077239 call       0x141867875
0107723e test       rbp, rbp
01077241 jne        0x1410770d4
01077247 mov        eax, edi
01077249 mov        rbx, qword ptr [rsp + 0x60]
0107724e mov        r15, qword ptr [rsp + 0x30]
01077253 mov        r14, qword ptr [rsp + 0x68]
; range 0x1077258..0x107726e (exclusive)
01077258 add        rsp, 0x38
0107725c pop        r12
0107725e pop        rdi
0107725f pop        rsi
01077260 pop        rbp
01077261 ret        
01077262 mov        eax, edi
01077264 add        rsp, 0x38
01077268 pop        r12
0107726a pop        rdi
0107726b pop        rsi
0107726c pop        rbp
0107726d ret        
