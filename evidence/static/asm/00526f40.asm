; Original iTunes.exe machine code; base=0x140000000; RVA=0x526f40; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x526f40..0x527a08 (exclusive)
00526f40 mov        qword ptr [rsp + 0x18], rbx
00526f45 push       rbp
00526f46 push       rsi
00526f47 push       rdi
00526f48 push       r12
00526f4a push       r13
00526f4c push       r14
00526f4e push       r15
00526f50 lea        rbp, [rsp - 0xcf0]
00526f58 sub        rsp, 0xdf0
00526f5f mov        rax, qword ptr [rip + 0x1aae0da]
00526f66 xor        rax, rsp
00526f69 mov        qword ptr [rbp + 0xce0], rax
00526f70 mov        r12, rdx
00526f73 mov        r14, rcx
00526f76 xor        r13b, r13b
00526f79 xor        r15b, r15b
00526f7c mov        edx, 0x20000
00526f81 lea        rcx, [rsp + 0x50]
00526f86 call       0x140b9fe10
00526f8b mov        ebx, eax
00526f8d xor        edi, edi
00526f8f test       eax, eax
00526f91 jne        0x1405272d6
00526f97 mov        r15b, 1
00526f9a lea        rax, [r14 + 0x38]
00526f9e lea        rcx, [rbp + 0x60]
00526fa2 mov        esi, 4
00526fa7 mov        edx, esi
00526fa9 nop        dword ptr [rax]
00526fb0 movups     xmm0, xmmword ptr [rax]
00526fb3 movups     xmmword ptr [rcx], xmm0
00526fb6 movups     xmm1, xmmword ptr [rax + 0x10]
00526fba movups     xmmword ptr [rcx + 0x10], xmm1
00526fbe movups     xmm0, xmmword ptr [rax + 0x20]
00526fc2 movups     xmmword ptr [rcx + 0x20], xmm0
00526fc6 movups     xmm1, xmmword ptr [rax + 0x30]
00526fca movups     xmmword ptr [rcx + 0x30], xmm1
00526fce movups     xmm0, xmmword ptr [rax + 0x40]
00526fd2 movups     xmmword ptr [rcx + 0x40], xmm0
00526fd6 movups     xmm1, xmmword ptr [rax + 0x50]
00526fda movups     xmmword ptr [rcx + 0x50], xmm1
00526fde movups     xmm0, xmmword ptr [rax + 0x60]
00526fe2 movups     xmmword ptr [rcx + 0x60], xmm0
00526fe6 lea        rcx, [rcx + 0x80]
00526fed movups     xmm1, xmmword ptr [rax + 0x70]
00526ff1 movups     xmmword ptr [rcx - 0x10], xmm1
00526ff5 lea        rax, [rax + 0x80]
00526ffc sub        rdx, 1
00527000 jne        0x140526fb0
00527002 movups     xmm0, xmmword ptr [rax]
00527005 movups     xmmword ptr [rcx], xmm0
00527008 movups     xmm1, xmmword ptr [rax + 0x10]
0052700c movups     xmmword ptr [rcx + 0x10], xmm1
00527010 lea        rax, [r14 + 0x258]
00527017 lea        rcx, [rbp + 0x280]
0052701e mov        rdx, rsi
00527021 movups     xmm0, xmmword ptr [rax]
00527024 movups     xmmword ptr [rcx], xmm0
00527027 movups     xmm1, xmmword ptr [rax + 0x10]
0052702b movups     xmmword ptr [rcx + 0x10], xmm1
0052702f movups     xmm0, xmmword ptr [rax + 0x20]
00527033 movups     xmmword ptr [rcx + 0x20], xmm0
00527037 movups     xmm1, xmmword ptr [rax + 0x30]
0052703b movups     xmmword ptr [rcx + 0x30], xmm1
0052703f movups     xmm0, xmmword ptr [rax + 0x40]
00527043 movups     xmmword ptr [rcx + 0x40], xmm0
00527047 movups     xmm1, xmmword ptr [rax + 0x50]
0052704b movups     xmmword ptr [rcx + 0x50], xmm1
0052704f movups     xmm0, xmmword ptr [rax + 0x60]
00527053 movups     xmmword ptr [rcx + 0x60], xmm0
00527057 lea        rcx, [rcx + 0x80]
0052705e movups     xmm1, xmmword ptr [rax + 0x70]
00527062 movups     xmmword ptr [rcx - 0x10], xmm1
00527066 lea        rax, [rax + 0x80]
0052706d sub        rdx, 1
00527071 jne        0x140527021
00527073 movups     xmm0, xmmword ptr [rax]
00527076 movups     xmmword ptr [rcx], xmm0
00527079 movups     xmm1, xmmword ptr [rax + 0x10]
0052707d movups     xmmword ptr [rcx + 0x10], xmm1
00527081 mov        word ptr [rbp + 0x8e0], di
00527088 lea        r8, [rbp + 0x8e0]
0052708f mov        edx, 0xe
00527094 lea        rcx, [rip + 0x162ed85]
0052709b call       0x140ae5fa0
005270a0 lea        rdx, [rbp + 0x8e0]
005270a7 lea        rcx, [rip + 0x158e0ce]
005270ae call       0x140ae54a0
005270b3 mov        rcx, qword ptr [r14 + 0x28]
005270b7 test       rcx, rcx
005270ba je         0x14052716e
005270c0 cmp        dword ptr [rcx + 0x20], 0x66726566
005270c7 jne        0x1405270db
005270c9 mov        rax, qword ptr [rcx + 0x2f0]
005270d0 test       rax, rax
005270d3 je         0x1405270db
005270d5 lea        rdx, [rbp + 0x60]
005270d9 call       rax
005270db mov        rcx, qword ptr [rbp + 0x70]
005270df mov        eax, dword ptr [rbp + 0x60]
005270e2 test       rcx, rcx
005270e5 je         0x140527110
005270e7 cmp        eax, 0x41464350
005270ec je         0x1405270f5
005270ee cmp        eax, 0x57696e50
005270f3 jne        0x140527110
005270f5 mov        rax, qword ptr [rcx + 0xc0]
005270fc lea        rdx, [rbp + 0x280]
00527103 lea        rcx, [rbp + 0x60]
00527107 call       rax
00527109 mov        rcx, qword ptr [rbp + 0x70]
0052710d mov        eax, dword ptr [rbp + 0x60]
00527110 mov        word ptr [rbp + 0x8e0], di
00527117 test       rcx, rcx
0052711a je         0x14052713b
0052711c cmp        eax, 0x41464350
00527121 je         0x14052712a
00527123 cmp        eax, 0x57696e50
00527128 jne        0x14052713b
0052712a mov        rax, qword ptr [rcx + 0x10]
0052712e lea        rdx, [rbp + 0x8e0]
00527135 lea        rcx, [rbp + 0x60]
00527139 call       rax
0052713b mov        rbx, qword ptr [r14 + 0x28]
0052713f test       rbx, rbx
00527142 je         0x14052716a
00527144 cmp        dword ptr [rbx + 0x20], 0x66726566
0052714b jne        0x14052716a
0052714d mov        rax, qword ptr [rbx + 0x260]
00527154 test       rax, rax
00527157 je         0x14052716a
00527159 mov        rcx, rbx
0052715c call       rax
0052715e mov        dword ptr [rbx + 0x20], edi
00527161 mov        rcx, rbx
00527164 call       qword ptr [rip + 0x13c51fe]
0052716a mov        qword ptr [r14 + 0x28], rdi
0052716e mov        rcx, r12
00527171 call       0x140526420
00527176 lea        rdx, [rsp + 0x50]
0052717b mov        rcx, r12
0052717e call       0x141075810
00527183 mov        ebx, eax
00527185 test       eax, eax
00527187 jne        0x1405272d6
0052718d xorps      xmm0, xmm0
00527190 movups     xmmword ptr [rbp + 0x10], xmm0
00527194 movups     xmmword ptr [rbp + 0x20], xmm0
00527198 movups     xmmword ptr [rbp + 0x30], xmm0
0052719c movups     xmmword ptr [rbp + 0x40], xmm0
005271a0 movups     xmmword ptr [rbp + 0x50], xmm0
005271a4 lea        rdx, [rbp + 0xae0]
005271ab lea        rcx, [rbp + 0x4a0]
005271b2 call       0x140e8ca40
005271b7 test       eax, eax
005271b9 jne        0x14052747b
005271bf movzx      r13d, r15b
005271c3 movzx      eax, word ptr [rbp + 0xae0]
005271ca mov        ecx, 0xff
005271cf cmp        eax, ecx
005271d1 jbe        0x1405271dc
005271d3 mov        word ptr [rbp + 0x8e0], cx
005271da jmp        0x1405271ea
005271dc mov        ecx, eax
005271de mov        word ptr [rbp + 0x8e0], ax
005271e5 cmp        eax, 1
005271e8 jb         0x140527203
005271ea mov        r8d, ecx
005271ed add        r8, r8
005271f0 lea        rdx, [rbp + 0xae2]
005271f7 lea        rcx, [rbp + 0x8e2]
005271fe call       0x14179cc9a
00527203 lea        rax, [rbp + 0x280]
0052720a lea        rcx, [rbp + 0x4a0]
00527211 mov        rdx, rsi
00527214 nop        dword ptr [rax]
00527218 nop        dword ptr [rax + rax]
00527220 movups     xmm0, xmmword ptr [rcx]
00527223 movups     xmmword ptr [rax], xmm0
00527226 movups     xmm1, xmmword ptr [rcx + 0x10]
0052722a movups     xmmword ptr [rax + 0x10], xmm1
0052722e movups     xmm0, xmmword ptr [rcx + 0x20]
00527232 movups     xmmword ptr [rax + 0x20], xmm0
00527236 movups     xmm1, xmmword ptr [rcx + 0x30]
0052723a movups     xmmword ptr [rax + 0x30], xmm1
0052723e movups     xmm0, xmmword ptr [rcx + 0x40]
00527242 movups     xmmword ptr [rax + 0x40], xmm0
00527246 movups     xmm1, xmmword ptr [rcx + 0x50]
0052724a movups     xmmword ptr [rax + 0x50], xmm1
0052724e movups     xmm0, xmmword ptr [rcx + 0x60]
00527252 movups     xmmword ptr [rax + 0x60], xmm0
00527256 lea        rax, [rax + 0x80]
0052725d movups     xmm1, xmmword ptr [rcx + 0x70]
00527261 movups     xmmword ptr [rax - 0x10], xmm1
00527265 lea        rcx, [rcx + 0x80]
0052726c sub        rdx, 1
00527270 jne        0x140527220
00527272 movups     xmm0, xmmword ptr [rcx]
00527275 movups     xmmword ptr [rax], xmm0
00527278 movups     xmm1, xmmword ptr [rcx + 0x10]
0052727c movups     xmmword ptr [rax + 0x10], xmm1
00527280 mov        rcx, qword ptr [rbp + 0x4b0]
00527287 test       rcx, rcx
0052728a je         0x1405272ad
0052728c mov        eax, dword ptr [rbp + 0x4a0]
00527292 cmp        eax, 0x41464350
00527297 je         0x1405272a0
00527299 cmp        eax, 0x57696e50
0052729e jne        0x1405272ad
005272a0 mov        rax, qword ptr [rcx + 0x38]
005272a4 test       rax, rax
005272a7 jne        0x140527453
005272ad mov        eax, 0xffffffce
005272b2 test       eax, eax
005272b4 jne        0x14052780b
005272ba cmp        byte ptr [rbp + 0x10], dil
005272be je         0x140527611
005272c4 mov        ebx, 0xfffffaea
005272c9 lea        rcx, [rsp + 0x50]
005272ce call       0x140ba02c0
005272d3 xor        r15b, r15b
005272d6 mov        r10d, dword ptr [r12 + 0x90]
005272de lea        rax, [rip + 0x158a8bb]
005272e5 mov        qword ptr [rbp - 0x60], rax
005272e9 lea        r9, [rip - 0x920]
005272f0 mov        qword ptr [rbp - 0x58], r9
005272f4 mov        dword ptr [rbp - 0x50], r10d
005272f8 mov        dword ptr [rbp - 0x4c], ebx
005272fb lea        rax, [rbp - 0x60]
005272ff mov        qword ptr [rbp - 0x28], rax
00527303 mov        qword ptr [rbp - 0x20], rdi
00527307 xorps      xmm0, xmm0
0052730a movsd      qword ptr [rbp - 0x18], xmm0
0052730f mov        word ptr [rbp - 0x10], di
00527313 mov        byte ptr [rbp - 0xe], dil
00527317 movdqa     xmmword ptr [rbp], xmm0
0052731c movabs     r11, 0x9e3779b97f4a7c15
00527326 add        r9, r11
00527329 mov        rcx, r9
0052732c shl        rcx, 6
00527330 mov        r8, r9
00527333 shr        r8, 2
00527337 add        rcx, qword ptr [rip + 0x1b7fbf2]
0052733e add        r8, r11
00527341 add        r8, rcx
00527344 xor        r8, r9
00527347 mov        rdx, r8
0052734a shl        rdx, 6
0052734e mov        rax, r8
00527351 shr        rax, 2
00527355 add        rdx, rax
00527358 movsxd     rcx, ebx
0052735b add        rdx, r11
0052735e add        rdx, rcx
00527361 xor        rdx, r8
00527364 mov        rcx, rdx
00527367 shl        rcx, 6
0052736b mov        rax, rdx
0052736e shr        rax, 2
00527372 add        rcx, rax
00527375 add        rcx, r11
00527378 add        rcx, r10
0052737b xor        rcx, rdx
0052737e mov        qword ptr [rbp - 8], rcx
00527382 lea        rcx, [rbp - 0x60]
00527386 call       0x140ae89a0
0052738b nop        
0052738c mov        rdi, qword ptr [rbp + 8]
00527390 test       rdi, rdi
00527393 je         0x1405273c1
00527395 mov        esi, 0xffffffff
0052739a mov        eax, esi
0052739c lock xadd  dword ptr [rdi + 8], eax
005273a1 cmp        eax, 1
005273a4 jne        0x1405273c1
005273a6 mov        rax, qword ptr [rdi]
005273a9 mov        rcx, rdi
005273ac call       qword ptr [rax]
005273ae lock xadd  dword ptr [rdi + 0xc], esi
005273b3 cmp        esi, 1
005273b6 jne        0x1405273c1
005273b8 mov        rax, qword ptr [rdi]
005273bb mov        rcx, rdi
005273be call       qword ptr [rax + 8]
005273c1 mov        rcx, qword ptr [rbp - 0x28]
005273c5 test       rcx, rcx
005273c8 je         0x1405273da
005273ca lea        rax, [rbp - 0x60]
005273ce cmp        rcx, rax
005273d1 setne      dl
005273d4 mov        rax, qword ptr [rcx]
005273d7 call       qword ptr [rax + 0x20]
005273da test       r15b, r15b
005273dd je         0x140527427
005273df cmp        dword ptr [rsp + 0x50], 0x62756666
005273e7 jne        0x140527427
005273e9 mov        byte ptr [rsp + 0x54], 1
005273ee cmp        byte ptr [rsp + 0x55], 0
005273f3 jne        0x1405273ff
005273f5 lea        rcx, [rsp + 0x50]
005273fa call       0x140ba0000
005273ff mov        rcx, qword ptr [rsp + 0x58]
00527404 call       0x140bd5150
00527409 mov        rcx, qword ptr [rsp + 0x60]
0052740e test       rcx, rcx
00527411 je         0x140527418
00527413 call       0x140bd7440
00527418 mov        rcx, qword ptr [rbp - 0x80]
0052741c test       rcx, rcx
0052741f je         0x140527427
00527421 call       qword ptr [rip + 0x13c4f41]
00527427 mov        eax, ebx
00527429 mov        rcx, qword ptr [rbp + 0xce0]
00527430 xor        rcx, rsp
00527433 call       0x14179b8e0
00527438 mov        rbx, qword ptr [rsp + 0xe40]
00527440 add        rsp, 0xdf0
00527447 pop        r15
00527449 pop        r14
0052744b pop        r13
0052744d pop        r12
0052744f pop        rdi
00527450 pop        rsi
00527451 pop        rbp
00527452 ret        
00527453 lea        r9, [rbp + 0x10]
00527457 lea        r8, [rbp + 0x60]
0052745b lea        rdx, [rbp + 0x8e0]
00527462 lea        rcx, [rbp + 0x280]
00527469 call       rax
0052746b test       eax, eax
0052746d je         0x1405272ba
00527473 mov        dword ptr [rbp + 0x60], edi
00527476 jmp        0x1405272b2
0052747b lea        r8, [rbp + 0x280]
00527482 mov        edx, 3
00527487 mov        ecx, esi
00527489 call       0x141136a50
0052748e test       eax, eax
00527490 jne        0x14052780b
00527496 mov        rcx, qword ptr [rbp + 0x290]
0052749d test       rcx, rcx
005274a0 je         0x1405274e2
005274a2 mov        eax, dword ptr [rbp + 0x280]
005274a8 cmp        eax, 0x41464350
005274ad je         0x1405274b6
005274af cmp        eax, 0x57696e50
005274b4 jne        0x1405274e2
005274b6 mov        rax, qword ptr [rcx + 0x38]
005274ba test       rax, rax
005274bd je         0x1405274e2
005274bf lea        r9, [rbp + 0x10]
005274c3 lea        r8, [rbp + 0x60]
005274c7 lea        rdx, [rbp + 0x8e0]
005274ce lea        rcx, [rbp + 0x280]
005274d5 call       rax
005274d7 test       eax, eax
005274d9 je         0x1405272ba
005274df mov        dword ptr [rbp + 0x60], edi
005274e2 mov        word ptr [rbp + 0x8e0], di
005274e9 lea        r8, [rbp + 0x8e0]
005274f0 mov        edx, 0xe
005274f5 lea        rcx, [rip + 0x162e924]
005274fc call       0x140ae5fa0
00527501 lea        rdx, [rbp + 0x8e0]
00527508 lea        rcx, [rip + 0x158dc6d]
0052750f call       0x140ae54a0
00527514 mov        rcx, qword ptr [rbp + 0x290]
0052751b test       rcx, rcx
0052751e je         0x140527562
00527520 mov        eax, dword ptr [rbp + 0x280]
00527526 cmp        eax, 0x41464350
0052752b je         0x140527534
0052752d cmp        eax, 0x57696e50
00527532 jne        0x140527562
00527534 mov        rax, qword ptr [rcx + 0x38]
00527538 test       rax, rax
0052753b je         0x140527562
0052753d lea        r9, [rbp + 0x10]
00527541 lea        r8, [rbp + 0x60]
00527545 lea        rdx, [rbp + 0x8e0]
0052754c lea        rcx, [rbp + 0x280]
00527553 call       rax
00527555 test       eax, eax
00527557 je         0x1405272ba
0052755d mov        dword ptr [rbp + 0x60], edi
00527560 jmp        0x140527567
00527562 mov        eax, 0xffffffce
00527567 test       eax, eax
00527569 je         0x1405272ba
0052756f mov        word ptr [rbp + 0x8e0], di
00527576 lea        r8, [rbp + 0x8e0]
0052757d mov        edx, 0xe
00527582 lea        rcx, [rip + 0x162e897]
00527589 call       0x140ae5fa0
0052758e mov        rcx, qword ptr [rbp + 0x290]
00527595 test       rcx, rcx
00527598 je         0x1405275da
0052759a mov        eax, dword ptr [rbp + 0x280]
005275a0 cmp        eax, 0x41464350
005275a5 je         0x1405275ae
005275a7 cmp        eax, 0x57696e50
005275ac jne        0x1405275da
005275ae mov        rax, qword ptr [rcx + 0x38]
005275b2 test       rax, rax
005275b5 je         0x1405275da
005275b7 lea        r9, [rbp + 0x10]
005275bb lea        r8, [rbp + 0x60]
005275bf lea        rdx, [rbp + 0x8e0]
005275c6 lea        rcx, [rbp + 0x280]
005275cd call       rax
005275cf test       eax, eax
005275d1 je         0x1405272ba
005275d7 mov        dword ptr [rbp + 0x60], edi
005275da mov        word ptr [rbp + 0x8e0], di
005275e1 lea        r8, [rbp + 0x8e0]
005275e8 mov        edx, 0xe
005275ed lea        rcx, [rip + 0x162e82c]
005275f4 call       0x140ae5fa0
005275f9 lea        rdx, [rbp + 0x8e0]
00527600 lea        rcx, [rip + 0x158db75]
00527607 call       0x140ae54a0
0052760c jmp        0x14052780b
00527611 lea        rax, [rbp + 0x6c0]
00527618 lea        rcx, [rbp + 0x60]
0052761c mov        rdx, rsi
0052761f nop        
00527620 movups     xmm0, xmmword ptr [rcx]
00527623 movups     xmmword ptr [rax], xmm0
00527626 movups     xmm1, xmmword ptr [rcx + 0x10]
0052762a movups     xmmword ptr [rax + 0x10], xmm1
0052762e movups     xmm0, xmmword ptr [rcx + 0x20]
00527632 movups     xmmword ptr [rax + 0x20], xmm0
00527636 movups     xmm1, xmmword ptr [rcx + 0x30]
0052763a movups     xmmword ptr [rax + 0x30], xmm1
0052763e movups     xmm0, xmmword ptr [rcx + 0x40]
00527642 movups     xmmword ptr [rax + 0x40], xmm0
00527646 movups     xmm1, xmmword ptr [rcx + 0x50]
0052764a movups     xmmword ptr [rax + 0x50], xmm1
0052764e movups     xmm0, xmmword ptr [rcx + 0x60]
00527652 movups     xmmword ptr [rax + 0x60], xmm0
00527656 lea        rax, [rax + 0x80]
0052765d movups     xmm1, xmmword ptr [rcx + 0x70]
00527661 movups     xmmword ptr [rax - 0x10], xmm1
00527665 lea        rcx, [rcx + 0x80]
0052766c sub        rdx, 1
00527670 jne        0x140527620
00527672 movups     xmm0, xmmword ptr [rcx]
00527675 movups     xmmword ptr [rax], xmm0
00527678 movups     xmm1, xmmword ptr [rcx + 0x10]
0052767c movups     xmmword ptr [rax + 0x10], xmm1
00527680 mov        eax, 0x8000
00527685 test       word ptr [rbp + 0x40], ax
00527689 je         0x14052780b
0052768f mov        rcx, qword ptr [rbp + 0x70]
00527693 test       rcx, rcx
00527696 je         0x140527748
0052769c mov        eax, dword ptr [rbp + 0x60]
0052769f cmp        eax, 0x41464350
005276a4 je         0x1405276b1
005276a6 cmp        eax, 0x57696e50
005276ab jne        0x140527748
005276b1 mov        rax, qword ptr [rcx + 0xf0]
005276b8 test       rax, rax
005276bb je         0x140527748
005276c1 xor        r9d, r9d
005276c4 movzx      r8d, r15b
005276c8 lea        rdx, [rbp + 0x60]
005276cc lea        rcx, [rbp + 0x6c0]
005276d3 call       rax
005276d5 mov        ebx, eax
005276d7 test       eax, eax
005276d9 jne        0x140527748
005276db mov        rcx, qword ptr [rbp + 0x70]
005276df mov        eax, dword ptr [rbp + 0x60]
005276e2 test       rcx, rcx
005276e5 je         0x140527710
005276e7 cmp        eax, 0x41464350
005276ec je         0x1405276f5
005276ee cmp        eax, 0x57696e50
005276f3 jne        0x140527710
005276f5 mov        rax, qword ptr [rcx + 0xc0]
005276fc lea        rdx, [rbp + 0x280]
00527703 lea        rcx, [rbp + 0x60]
00527707 call       rax
00527709 mov        rcx, qword ptr [rbp + 0x70]
0052770d mov        eax, dword ptr [rbp + 0x60]
00527710 mov        word ptr [rbp + 0x8e0], di
00527717 test       rcx, rcx
0052771a je         0x140527807
00527720 cmp        eax, 0x41464350
00527725 je         0x140527732
00527727 cmp        eax, 0x57696e50
0052772c jne        0x140527807
00527732 mov        rax, qword ptr [rcx + 0x10]
00527736 lea        rdx, [rbp + 0x8e0]
0052773d lea        rcx, [rbp + 0x60]
00527741 call       rax
00527743 jmp        0x140527807
00527748 lea        rcx, [r14 + 0x258]
0052774f test       rcx, rcx
00527752 je         0x140527802
00527758 mov        rdx, qword ptr [rcx + 0x10]
0052775c test       rdx, rdx
0052775f je         0x140527802
00527765 mov        eax, dword ptr [rcx]
00527767 cmp        eax, 0x41464350
0052776c je         0x140527779
0052776e cmp        eax, 0x57696e50
00527773 jne        0x140527802
00527779 mov        rax, qword ptr [rdx + 8]
0052777d xor        r8d, r8d
00527780 xor        edx, edx
00527782 call       rax
00527784 mov        ebx, eax
00527786 test       eax, eax
00527788 jne        0x14052787e
0052778e lea        rax, [r14 + 0x258]
00527795 lea        rcx, [rbp + 0x280]
0052779c mov        rdx, rsi
0052779f nop        
005277a0 movups     xmm0, xmmword ptr [rax]
005277a3 movups     xmmword ptr [rcx], xmm0
005277a6 movups     xmm1, xmmword ptr [rax + 0x10]
005277aa movups     xmmword ptr [rcx + 0x10], xmm1
005277ae movups     xmm0, xmmword ptr [rax + 0x20]
005277b2 movups     xmmword ptr [rcx + 0x20], xmm0
005277b6 movups     xmm1, xmmword ptr [rax + 0x30]
005277ba movups     xmmword ptr [rcx + 0x30], xmm1
005277be movups     xmm0, xmmword ptr [rax + 0x40]
005277c2 movups     xmmword ptr [rcx + 0x40], xmm0
005277c6 movups     xmm1, xmmword ptr [rax + 0x50]
005277ca movups     xmmword ptr [rcx + 0x50], xmm1
005277ce movups     xmm0, xmmword ptr [rax + 0x60]
005277d2 movups     xmmword ptr [rcx + 0x60], xmm0
005277d6 lea        rcx, [rcx + 0x80]
005277dd movups     xmm1, xmmword ptr [rax + 0x70]
005277e1 movups     xmmword ptr [rcx - 0x10], xmm1
005277e5 lea        rax, [rax + 0x80]
005277ec sub        rdx, 1
005277f0 jne        0x1405277a0
005277f2 movups     xmm0, xmmword ptr [rax]
005277f5 movups     xmmword ptr [rcx], xmm0
005277f8 movups     xmm1, xmmword ptr [rax + 0x10]
005277fc movups     xmmword ptr [rcx + 0x10], xmm1
00527800 jmp        0x140527807
00527802 mov        ebx, 0xffffffce
00527807 test       ebx, ebx
00527809 jne        0x14052787e
0052780b movzx      r8d, r15b
0052780f mov        rax, qword ptr [rip + 0x1b7f71a]
00527816 test       rax, rax
00527819 je         0x140527832
0052781b mov        rcx, qword ptr [rax + 0x14190]
00527822 test       rcx, rcx
00527825 je         0x140527832
00527827 cmp        byte ptr [rcx + 0x5eb], dil
0052782e setne      r8b
00527832 cmp        byte ptr [r14 + 0x47c], dil
00527839 setne      al
0052783c mov        byte ptr [rsp + 0x38], al
00527840 mov        byte ptr [rsp + 0x30], r13b
00527845 lea        rax, [rbp + 0x60]
00527849 mov        qword ptr [rsp + 0x28], rax
0052784e lea        rax, [rbp + 0x8e0]
00527855 mov        qword ptr [rsp + 0x20], rax
0052785a lea        r9, [rbp + 0x280]
00527861 lea        rdx, [rsp + 0x50]
00527866 mov        rcx, r12
00527869 call       0x141076b60
0052786e mov        ebx, eax
00527870 test       eax, eax
00527872 jne        0x14052787e
00527874 mov        rcx, r12
00527877 call       0x140526ce0
0052787c mov        ebx, eax
0052787e lea        rcx, [rsp + 0x50]
00527883 call       0x140ba02c0
00527888 xor        r15b, r15b
0052788b test       ebx, ebx
0052788d jne        0x1405272d6
00527893 mov        rcx, r12
00527896 call       0x140ecf880
0052789b lea        rax, [r14 + 0x38]
0052789f lea        rcx, [rbp + 0x60]
005278a3 mov        rdx, rsi
005278a6 nop        word ptr [rax + rax]
005278b0 movups     xmm0, xmmword ptr [rcx]
005278b3 movups     xmmword ptr [rax], xmm0
005278b6 movups     xmm1, xmmword ptr [rcx + 0x10]
005278ba movups     xmmword ptr [rax + 0x10], xmm1
005278be movups     xmm0, xmmword ptr [rcx + 0x20]
005278c2 movups     xmmword ptr [rax + 0x20], xmm0
005278c6 movups     xmm1, xmmword ptr [rcx + 0x30]
005278ca movups     xmmword ptr [rax + 0x30], xmm1
005278ce movups     xmm0, xmmword ptr [rcx + 0x40]
005278d2 movups     xmmword ptr [rax + 0x40], xmm0
005278d6 movups     xmm1, xmmword ptr [rcx + 0x50]
005278da movups     xmmword ptr [rax + 0x50], xmm1
005278de movups     xmm0, xmmword ptr [rcx + 0x60]
005278e2 movups     xmmword ptr [rax + 0x60], xmm0
005278e6 lea        rax, [rax + 0x80]
005278ed movups     xmm1, xmmword ptr [rcx + 0x70]
005278f1 movups     xmmword ptr [rax - 0x10], xmm1
005278f5 lea        rcx, [rcx + 0x80]
005278fc sub        rdx, 1
00527900 jne        0x1405278b0
00527902 movups     xmm0, xmmword ptr [rcx]
00527905 movups     xmmword ptr [rax], xmm0
00527908 movups     xmm1, xmmword ptr [rcx + 0x10]
0052790c movups     xmmword ptr [rax + 0x10], xmm1
00527910 lea        rax, [r14 + 0x258]
00527917 lea        rcx, [rbp + 0x280]
0052791e nop        
00527920 movups     xmm0, xmmword ptr [rcx]
00527923 movups     xmmword ptr [rax], xmm0
00527926 movups     xmm1, xmmword ptr [rcx + 0x10]
0052792a movups     xmmword ptr [rax + 0x10], xmm1
0052792e movups     xmm0, xmmword ptr [rcx + 0x20]
00527932 movups     xmmword ptr [rax + 0x20], xmm0
00527936 movups     xmm1, xmmword ptr [rcx + 0x30]
0052793a movups     xmmword ptr [rax + 0x30], xmm1
0052793e movups     xmm0, xmmword ptr [rcx + 0x40]
00527942 movups     xmmword ptr [rax + 0x40], xmm0
00527946 movups     xmm1, xmmword ptr [rcx + 0x50]
0052794a movups     xmmword ptr [rax + 0x50], xmm1
0052794e movups     xmm0, xmmword ptr [rcx + 0x60]
00527952 movups     xmmword ptr [rax + 0x60], xmm0
00527956 lea        rax, [rax + 0x80]
0052795d movups     xmm1, xmmword ptr [rcx + 0x70]
00527961 movups     xmmword ptr [rax - 0x10], xmm1
00527965 lea        rcx, [rcx + 0x80]
0052796c sub        rsi, 1
00527970 jne        0x140527920
00527972 movups     xmm0, xmmword ptr [rcx]
00527975 movups     xmmword ptr [rax], xmm0
00527978 movups     xmm1, xmmword ptr [rcx + 0x10]
0052797c movups     xmmword ptr [rax + 0x10], xmm1
00527980 mov        byte ptr [r14 + 0x30], 1
00527985 lea        r9, [r14 + 0x28]
00527989 mov        edx, 0x64617461
0052798e mov        r8d, 3
00527994 lea        rcx, [rbp + 0x60]
00527998 call       0x140b19490
0052799d test       eax, eax
0052799f jne        0x140527427
005279a5 mov        qword ptr [rsp + 0x40], rdi
005279aa mov        rcx, qword ptr [r14 + 0x28]
005279ae test       rcx, rcx
005279b1 je         0x1405279d4
005279b3 cmp        dword ptr [rcx + 0x20], 0x66726566
005279ba jne        0x1405279d4
005279bc mov        rax, qword ptr [rcx + 0x268]
005279c3 test       rax, rax
005279c6 je         0x1405279d4
005279c8 lea        rdx, [rsp + 0x40]
005279cd call       rax
005279cf mov        rdi, qword ptr [rsp + 0x40]
005279d4 mov        rcx, qword ptr [r14 + 0x28]
005279d8 test       rcx, rcx
005279db je         0x140527427
005279e1 cmp        dword ptr [rcx + 0x20], 0x66726566
005279e8 jne        0x140527427
005279ee mov        rax, qword ptr [rcx + 0x280]
005279f5 test       rax, rax
005279f8 je         0x140527427
005279fe mov        rdx, rdi
00527a01 call       rax
00527a03 jmp        0x140527427
