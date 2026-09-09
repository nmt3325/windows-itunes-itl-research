; Original iTunes.exe machine code; base=0x140000000; RVA=0x1084190; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1084190..0x1084235 (exclusive)
01084190 mov        qword ptr [rsp + 8], rcx
01084195 push       rbp
01084196 push       rsi
01084197 push       r12
01084199 push       r13
0108419b push       r14
0108419d lea        rbp, [rsp - 0x37]
010841a2 sub        rsp, 0xa0
010841a9 xorps      xmm0, xmm0
010841ac mov        r13, rdx
010841af mov        r14, rcx
010841b2 xor        eax, eax
010841b4 mov        edx, 0x10
010841b9 mov        qword ptr [rbp + 0x17], rax
010841bd mov        ecx, 0x100000
010841c2 xor        sil, sil
010841c5 movups     xmmword ptr [rbp - 0x39], xmm0
010841c9 movups     xmmword ptr [rbp - 0x29], xmm0
010841cd movups     xmmword ptr [rbp - 0x19], xmm0
010841d1 movups     xmmword ptr [rbp - 9], xmm0
010841d5 movups     xmmword ptr [rbp + 7], xmm0
010841d9 call       qword ptr [rip + 0x868191]
010841df mov        r12, rax
010841e2 test       rax, rax
010841e5 jne        0x1410841fc
010841e7 mov        eax, 0xffffff94
010841ec add        rsp, 0xa0
010841f3 pop        r14
010841f5 pop        r13
010841f7 pop        r12
010841f9 pop        rsi
010841fa pop        rbp
010841fb ret        
010841fc mov        edx, 0x10
01084201 mov        qword ptr [rsp + 0x98], rdi
01084209 mov        ecx, 0x200000
0108420e call       qword ptr [rip + 0x86815c]
01084214 mov        rdi, rax
01084217 test       rax, rax
0108421a jne        0x14108422f
0108421c mov        rcx, r12
0108421f call       qword ptr [rip + 0x868143]
01084225 mov        eax, 0xffffff94
0108422a jmp        0x1410843d9
0108422f mov        r8d, 0x58
; range 0x1084235..0x1084270 (exclusive)
01084235 mov        qword ptr [rsp + 0xd8], rbx
0108423d lea        rdx, [rip + 0xa43d08]
01084244 lea        rcx, [rbp - 0x39]
01084248 call       qword ptr [rip + 0x868cfa]
0108424e test       eax, eax
01084250 je         0x141084265
01084252 mov        rcx, r12
01084255 mov        ebx, 0xffffffce
0108425a call       qword ptr [rip + 0x868108]
01084260 jmp        0x1410843b7
01084265 mov        rsi, qword ptr [r14 + 0x120]
0108426c lea        rdx, [rbp + 0x7f]
; range 0x1084270..0x10843b7 (exclusive)
01084270 mov        qword ptr [rsp + 0x90], r15
01084278 mov        byte ptr [rbp + 0x77], 1
0108427c mov        rcx, qword ptr [rsi + 8]
01084280 call       0x140bd67d0
01084285 mov        ebx, eax
01084287 test       eax, eax
01084289 jne        0x1410842d8
0108428b cmp        byte ptr [rsi + 5], al
0108428e jne        0x1410842d8
01084290 mov        rcx, qword ptr [rsi + 8]
01084294 lea        rdx, [rbp - 0x49]
01084298 call       0x140bd6640
0108429d mov        ebx, eax
0108429f test       eax, eax
010842a1 jne        0x1410842d8
010842a3 cmp        byte ptr [rsi + 5], al
010842a6 je         0x1410842bf
010842a8 mov        rax, qword ptr [rsi + 0x38]
010842ac mov        rcx, qword ptr [rsi + 0x20]
010842b0 cmp        rcx, rax
010842b3 jbe        0x1410842b9
010842b5 xor        eax, eax
010842b7 jmp        0x1410842c5
010842b9 sub        eax, ecx
010842bb inc        eax
010842bd jmp        0x1410842c5
010842bf mov        eax, dword ptr [rsi + 0x20]
010842c2 sub        eax, dword ptr [rsi + 0x30]
010842c5 movsxd     rdx, eax
010842c8 add        rdx, qword ptr [rbp - 0x49]
010842cc cmp        rdx, qword ptr [rbp + 0x7f]
010842d0 jbe        0x1410842d8
010842d2 mov        qword ptr [rbp + 0x7f], rdx
010842d6 jmp        0x1410842e0
010842d8 test       ebx, ebx
010842da jne        0x1410843a2
010842e0 mov        rcx, qword ptr [r14 + 0x120]
010842e7 lea        rdx, [rbp - 0x41]
010842eb call       0x140b9ff80
010842f0 mov        ebx, eax
010842f2 test       eax, eax
010842f4 jne        0x1410843a2
010842fa mov        r15, qword ptr [rbp + 0x7f]
010842fe sub        r15, qword ptr [rbp - 0x41]
01084302 je         0x1410843a2
01084308 nop        dword ptr [rax + rax]
01084310 mov        esi, 0x100000
01084315 cmp        r15, rsi
01084318 cmovb      esi, r15d
0108431c mov        r14d, esi
0108431f cmp        r14, 0xa00000
01084326 ja         0x14108439d
01084328 mov        rcx, qword ptr [rbp + 0x67]
0108432c mov        r8d, r14d
0108432f mov        rdx, r12
01084332 call       0x1410770a0
01084337 mov        ebx, eax
01084339 test       eax, eax
0108433b jne        0x1410843a2
0108433d sub        r15, r14
01084340 mov        qword ptr [rbp - 0x39], r12
01084344 mov        dword ptr [rbp - 0x31], esi
01084347 nop        word ptr [rax + rax]
01084350 xor        edx, edx
01084352 mov        qword ptr [rbp - 0x29], rdi
01084356 lea        rcx, [rbp - 0x39]
0108435a mov        dword ptr [rbp - 0x21], 0x200000
01084361 call       qword ptr [rip + 0x868bd9]
01084367 cmp        eax, 1
0108436a ja         0x14108439d
0108436c mov        eax, 0x200000
01084371 lea        rdx, [rbp - 0x49]
01084375 sub        eax, dword ptr [rbp - 0x21]
01084378 mov        r8, rdi
0108437b mov        rcx, r13
0108437e mov        qword ptr [rbp - 0x49], rax
01084382 call       0x140ba04c0
01084387 mov        ebx, eax
01084389 test       eax, eax
0108438b jne        0x1410843a2
0108438d cmp        dword ptr [rbp - 0x21], eax
01084390 je         0x141084350
01084392 test       r15, r15
01084395 jne        0x141084310
0108439b jmp        0x1410843a2
0108439d mov        ebx, 0xffffff30
010843a2 mov        rcx, r12
010843a5 call       qword ptr [rip + 0x867fbd]
010843ab movzx      esi, byte ptr [rbp + 0x77]
010843af mov        r15, qword ptr [rsp + 0x90]
; range 0x10843b7..0x10843d9 (exclusive)
010843b7 mov        rcx, rdi
010843ba call       qword ptr [rip + 0x867fa8]
010843c0 test       sil, sil
010843c3 je         0x1410843cf
010843c5 lea        rcx, [rbp - 0x39]
010843c9 call       qword ptr [rip + 0x868b69]
010843cf mov        eax, ebx
010843d1 mov        rbx, qword ptr [rsp + 0xd8]
; range 0x10843d9..0x10843f1 (exclusive)
010843d9 mov        rdi, qword ptr [rsp + 0x98]
010843e1 add        rsp, 0xa0
010843e8 pop        r14
010843ea pop        r13
010843ec pop        r12
010843ee pop        rsi
010843ef pop        rbp
010843f0 ret        
