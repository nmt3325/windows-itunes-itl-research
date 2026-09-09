; iTunes.exe SHA256 30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d; ImageBase 0x140000000; function RVA 0x1078140
; unwind group range 0x1078140..0x1078192 (exclusive)
01078140 4055                             push       rbp
01078142 56                               push       rsi
01078143 57                               push       rdi
01078144 4154                             push       r12
01078146 488dac2418ffffff                 lea        rbp, [rsp - 0xe8]
0107814e 4881ece8010000                   sub        rsp, 0x1e8
01078155 488b05e4cef500                   mov        rax, qword ptr [rip + 0xf5cee4]
0107815c 4833c4                           xor        rax, rsp
0107815f 488985d0000000                   mov        qword ptr [rbp + 0xd0], rax
01078166 4c8ba17002e001                   mov        r12, qword ptr [rcx + 0x1e00270]
0107816d 488d5570                         lea        rdx, [rbp + 0x70]
01078171 41b808000000                     mov        r8d, 8
01078177 4c89642458                       mov        qword ptr [rsp + 0x58], r12
0107817c 488bf1                           mov        rsi, rcx
0107817f e81cefffff                       call       0x1410770a0
01078184 8bf8                             mov        edi, eax
01078186 85c0                             test       eax, eax
01078188 0f85d5090000                     jne        0x141078b63
0107818e 448b5574                         mov        r10d, dword ptr [rbp + 0x74]
; unwind group range 0x1078192..0x1078b63 (exclusive)
01078192 48899c2418020000                 mov        qword ptr [rsp + 0x218], rbx
0107819a 418bda                           mov        ebx, r10d
0107819d 4c89ac2420020000                 mov        qword ptr [rsp + 0x220], r13
010781a5 4c89b42428020000                 mov        qword ptr [rsp + 0x228], r14
010781ad 4c8d7652                         lea        r14, [rsi + 0x52]
010781b1 4c89bc24e0010000                 mov        qword ptr [rsp + 0x1e0], r15
010781b9 413806                           cmp        byte ptr [r14], al
010781bc 7502                             jne        0x1410781c0
010781be 0fcb                             bswap      ebx
010781c0 41bd5c000000                     mov        r13d, 0x5c
010781c6 488d4d78                         lea        rcx, [rbp + 0x78]
010781ca 413bdd                           cmp        ebx, r13d
010781cd 458bfd                           mov        r15d, r13d
010781d0 440f42fb                         cmovb      r15d, ebx
010781d4 4183ff08                         cmp        r15d, 8
010781d8 763b                             jbe        0x141078215
010781da 418d47f8                         lea        eax, [r15 - 8]
010781de 4889442460                       mov        qword ptr [rsp + 0x60], rax
010781e3 483d0000a000                     cmp        rax, 0xa00000
010781e9 0f8746090000                     ja         0x141078b35
010781ef 448bc0                           mov        r8d, eax
010781f2 488d5578                         lea        rdx, [rbp + 0x78]
010781f6 488bce                           mov        rcx, rsi
010781f9 e8a2eeffff                       call       0x1410770a0
010781fe 8bf8                             mov        edi, eax
01078200 85c0                             test       eax, eax
01078202 0f853b090000                     jne        0x141078b43
01078208 448b5574                         mov        r10d, dword ptr [rbp + 0x74]
0107820c 488d4d78                         lea        rcx, [rbp + 0x78]
01078210 48034c2460                       add        rcx, qword ptr [rsp + 0x60]
01078215 453bfd                           cmp        r15d, r13d
01078218 7316                             jae        0x141078230
0107821a 4885c9                           test       rcx, rcx
0107821d 7411                             je         0x141078230
0107821f 452bef                           sub        r13d, r15d
01078222 33d2                             xor        edx, edx
01078224 458bc5                           mov        r8d, r13d
01078227 e8744a7200                       call       0x14179cca0
0107822c 448b5574                         mov        r10d, dword ptr [rbp + 0x74]
01078230 413bdf                           cmp        ebx, r15d
01078233 7617                             jbe        0x14107824c
01078235 412bdf                           sub        ebx, r15d
01078238 488bce                           mov        rcx, rsi
0107823b 8bd3                             mov        edx, ebx
0107823d e8de22ffff                       call       0x14106a520
01078242 8bf8                             mov        edi, eax
01078244 85c0                             test       eax, eax
01078246 0f85f7080000                     jne        0x141078b43
0107824c 33d2                             xor        edx, edx
0107824e 8bfa                             mov        edi, edx
01078250 413816                           cmp        byte ptr [r14], dl
01078253 0f8588000000                     jne        0x1410782e1
01078259 8b4d70                           mov        ecx, dword ptr [rbp + 0x70]
0107825c 448bc1                           mov        r8d, ecx
0107825f 8bc1                             mov        eax, ecx
01078261 4181e00000ff00                   and        r8d, 0xff0000
01078268 c1e810                           shr        eax, 0x10
0107826b 440bc0                           or         r8d, eax
0107826e 8bc1                             mov        eax, ecx
01078270 2500ff0000                       and        eax, 0xff00
01078275 c1e110                           shl        ecx, 0x10
01078278 0bc1                             or         eax, ecx
0107827a 41c1e808                         shr        r8d, 8
0107827e c1e008                           shl        eax, 8
01078281 418bca                           mov        ecx, r10d
01078284 440bc0                           or         r8d, eax
01078287 81e10000ff00                     and        ecx, 0xff0000
0107828d 418bc2                           mov        eax, r10d
01078290 44894570                         mov        dword ptr [rbp + 0x70], r8d
01078294 c1e810                           shr        eax, 0x10
01078297 0bc8                             or         ecx, eax
01078299 418bc2                           mov        eax, r10d
0107829c c1e010                           shl        eax, 0x10
0107829f 4181e200ff0000                   and        r10d, 0xff00
010782a6 410bc2                           or         eax, r10d
010782a9 c1e908                           shr        ecx, 8
010782ac c1e008                           shl        eax, 8
010782af 0bc8                             or         ecx, eax
010782b1 894d74                           mov        dword ptr [rbp + 0x74], ecx
010782b4 8b4d78                           mov        ecx, dword ptr [rbp + 0x78]
010782b7 8bd1                             mov        edx, ecx
010782b9 81e20000ff00                     and        edx, 0xff0000
010782bf 8bc1                             mov        eax, ecx
010782c1 c1e810                           shr        eax, 0x10
010782c4 0bd0                             or         edx, eax
010782c6 8bc1                             mov        eax, ecx
010782c8 2500ff0000                       and        eax, 0xff00
010782cd c1e110                           shl        ecx, 0x10
010782d0 0bc1                             or         eax, ecx
010782d2 c1ea08                           shr        edx, 8
010782d5 c1e008                           shl        eax, 8
010782d8 0bd0                             or         edx, eax
010782da 895578                           mov        dword ptr [rbp + 0x78], edx
010782dd 33d2                             xor        edx, edx
010782df eb04                             jmp        0x1410782e5
010782e1 448b4570                         mov        r8d, dword ptr [rbp + 0x70]
010782e5 4181f86d6c6168                   cmp        r8d, 0x68616c6d
010782ec 0f8543080000                     jne        0x141078b35
010782f2 0fb64d7c                         movzx      ecx, byte ptr [rbp + 0x7c]
010782f6 410fb6842413010000               movzx      eax, byte ptr [r12 + 0x113]
010782ff 80e101                           and        cl, 1
01078302 c0e103                           shl        cl, 3
01078305 24f7                             and        al, 0xf7
01078307 0ac8                             or         cl, al
01078309 89542470                         mov        dword ptr [rsp + 0x70], edx
0107830d 41888c2413010000                 mov        byte ptr [r12 + 0x113], cl
01078315 397d78                           cmp        dword ptr [rbp + 0x78], edi
01078318 0f861e080000                     jbe        0x141078b3c
0107831e 6690                             nop        
01078320 895580                           mov        dword ptr [rbp - 0x80], edx
01078323 448bfa                           mov        r15d, edx
01078326 48895588                         mov        qword ptr [rbp - 0x78], rdx
0107832a 41b808000000                     mov        r8d, 8
01078330 895598                           mov        dword ptr [rbp - 0x68], edx
01078333 488bce                           mov        rcx, rsi
01078336 488955a0                         mov        qword ptr [rbp - 0x60], rdx
0107833a 4d8bee                           mov        r13, r14
0107833d 488955b0                         mov        qword ptr [rbp - 0x50], rdx
01078341 8955c0                           mov        dword ptr [rbp - 0x40], edx
01078344 488d5510                         lea        rdx, [rbp + 0x10]
01078348 4c89742468                       mov        qword ptr [rsp + 0x68], r14
0107834d 48c7459000000000                 mov        qword ptr [rbp - 0x70], 0
01078355 c6459c00                         mov        byte ptr [rbp - 0x64], 0
01078359 c645a800                         mov        byte ptr [rbp - 0x58], 0
0107835d 48c745b800000000                 mov        qword ptr [rbp - 0x48], 0
01078365 e836edffff                       call       0x1410770a0
0107836a 8bf8                             mov        edi, eax
0107836c 85c0                             test       eax, eax
0107836e 0f85cf070000                     jne        0x141078b43
01078374 448b5514                         mov        r10d, dword ptr [rbp + 0x14]
01078378 418bda                           mov        ebx, r10d
0107837b 413806                           cmp        byte ptr [r14], al
0107837e 7502                             jne        0x141078382
01078380 0fcb                             bswap      ebx
01078382 41be58000000                     mov        r14d, 0x58
01078388 488d4d18                         lea        rcx, [rbp + 0x18]
0107838c 413bde                           cmp        ebx, r14d
0107838f 440f42f3                         cmovb      r14d, ebx
01078393 4183fe08                         cmp        r14d, 8
01078397 763a                             jbe        0x1410783d3
01078399 458d6ef8                         lea        r13d, [r14 - 8]
0107839d 4981fd0000a000                   cmp        r13, 0xa00000
010783a4 0f878b070000                     ja         0x141078b35
010783aa 458bc5                           mov        r8d, r13d
010783ad 488d5518                         lea        rdx, [rbp + 0x18]
010783b1 488bce                           mov        rcx, rsi
010783b4 e8e7ecffff                       call       0x1410770a0
010783b9 8bf8                             mov        edi, eax
010783bb 85c0                             test       eax, eax
010783bd 0f8580070000                     jne        0x141078b43
010783c3 448b5514                         mov        r10d, dword ptr [rbp + 0x14]
010783c7 488d4d18                         lea        rcx, [rbp + 0x18]
010783cb 4903cd                           add        rcx, r13
010783ce 4c8b6c2468                       mov        r13, qword ptr [rsp + 0x68]
010783d3 4183fe58                         cmp        r14d, 0x58
010783d7 7319                             jae        0x1410783f2
010783d9 4885c9                           test       rcx, rcx
010783dc 7414                             je         0x1410783f2
010783de 41b858000000                     mov        r8d, 0x58
010783e4 33d2                             xor        edx, edx
010783e6 452bc6                           sub        r8d, r14d
010783e9 e8b2487200                       call       0x14179cca0
010783ee 448b5514                         mov        r10d, dword ptr [rbp + 0x14]
010783f2 413bde                           cmp        ebx, r14d
010783f5 7617                             jbe        0x14107840e
010783f7 412bde                           sub        ebx, r14d
010783fa 488bce                           mov        rcx, rsi
010783fd 8bd3                             mov        edx, ebx
010783ff e81c21ffff                       call       0x14106a520
01078404 8bf8                             mov        edi, eax
01078406 85c0                             test       eax, eax
01078408 0f8535070000                     jne        0x141078b43
0107840e 41807d0000                       cmp        byte ptr [r13], 0
01078413 4d8bf5                           mov        r14, r13
01078416 0f8503020000                     jne        0x14107861f
0107841c 8b4d10                           mov        ecx, dword ptr [rbp + 0x10]
0107841f 49bb000000000000ff00             movabs     r11, 0xff000000000000
01078429 8bc1                             mov        eax, ecx
0107842b 448bc9                           mov        r9d, ecx
0107842e c1e810                           shr        eax, 0x10
01078431 4181e10000ff00                   and        r9d, 0xff0000
01078438 440bc8                           or         r9d, eax
0107843b 48bb0000000000ff0000             movabs     rbx, 0xff0000000000
01078445 8bc1                             mov        eax, ecx
01078447 41c1e908                         shr        r9d, 8
0107844b c1e010                           shl        eax, 0x10
0107844e 81e100ff0000                     and        ecx, 0xff00
01078454 0bc1                             or         eax, ecx
01078456 418bca                           mov        ecx, r10d
01078459 c1e008                           shl        eax, 8
0107845c 81e10000ff00                     and        ecx, 0xff0000
01078462 440bc8                           or         r9d, eax
01078465 418bc2                           mov        eax, r10d
01078468 c1e810                           shr        eax, 0x10
0107846b 0bc8                             or         ecx, eax
0107846d 44894d10                         mov        dword ptr [rbp + 0x10], r9d
01078471 418bc2                           mov        eax, r10d
01078474 c1e908                           shr        ecx, 8
01078477 c1e010                           shl        eax, 0x10
0107847a 4181e200ff0000                   and        r10d, 0xff00
01078481 410bc2                           or         eax, r10d
01078484 c1e008                           shl        eax, 8
01078487 0bc8                             or         ecx, eax
01078489 894d14                           mov        dword ptr [rbp + 0x14], ecx
0107848c 8b4d18                           mov        ecx, dword ptr [rbp + 0x18]
0107848f 8bd1                             mov        edx, ecx
01078491 81e20000ff00                     and        edx, 0xff0000
01078497 8bc1                             mov        eax, ecx
01078499 c1e810                           shr        eax, 0x10
0107849c 0bd0                             or         edx, eax
0107849e 8bc1                             mov        eax, ecx
010784a0 c1e010                           shl        eax, 0x10
010784a3 81e100ff0000                     and        ecx, 0xff00
010784a9 0bc1                             or         eax, ecx
010784ab c1ea08                           shr        edx, 8
010784ae 8b4d1c                           mov        ecx, dword ptr [rbp + 0x1c]
010784b1 448bd1                           mov        r10d, ecx
010784b4 c1e008                           shl        eax, 8
010784b7 4181e20000ff00                   and        r10d, 0xff0000
010784be 0bd0                             or         edx, eax
010784c0 8bc1                             mov        eax, ecx
010784c2 c1e810                           shr        eax, 0x10
010784c5 440bd0                           or         r10d, eax
010784c8 895518                           mov        dword ptr [rbp + 0x18], edx
010784cb 8bc1                             mov        eax, ecx
010784cd 41c1ea08                         shr        r10d, 8
010784d1 c1e010                           shl        eax, 0x10
010784d4 81e100ff0000                     and        ecx, 0xff00
010784da 0bc1                             or         eax, ecx
010784dc 8b4d20                           mov        ecx, dword ptr [rbp + 0x20]
010784df c1e008                           shl        eax, 8
010784e2 8bd1                             mov        edx, ecx
010784e4 440bd0                           or         r10d, eax
010784e7 81e20000ff00                     and        edx, 0xff0000
010784ed 8bc1                             mov        eax, ecx
010784ef 4489551c                         mov        dword ptr [rbp + 0x1c], r10d
010784f3 c1e810                           shr        eax, 0x10
010784f6 0bd0                             or         edx, eax
010784f8 8bc1                             mov        eax, ecx
010784fa c1e010                           shl        eax, 0x10
010784fd 81e100ff0000                     and        ecx, 0xff00
01078503 0bc1                             or         eax, ecx
01078505 c1ea08                           shr        edx, 8
01078508 c1e008                           shl        eax, 8
0107850b 0bd0                             or         edx, eax
0107850d 895520                           mov        dword ptr [rbp + 0x20], edx
01078510 488b5524                         mov        rdx, qword ptr [rbp + 0x24]
01078514 4c8bc2                           mov        r8, rdx
01078517 488bc2                           mov        rax, rdx
0107851a 48c1e810                         shr        rax, 0x10
0107851e 4d23c3                           and        r8, r11
01078521 4c0bc0                           or         r8, rax
01078524 488bc2                           mov        rax, rdx
01078527 4823c3                           and        rax, rbx
0107852a 49c1e810                         shr        r8, 0x10
0107852e 4c0bc0                           or         r8, rax
01078531 49c1e810                         shr        r8, 0x10
01078535 488bc2                           mov        rax, rdx
01078538 488bca                           mov        rcx, rdx
0107853b 41be000000ff                     mov        r14d, 0xff000000
01078541 48c1e110                         shl        rcx, 0x10
01078545 48bf00000000ff000000             movabs     rdi, 0xff00000000
0107854f 4823c7                           and        rax, rdi
01078552 4c0bc0                           or         r8, rax
01078555 8bc2                             mov        eax, edx
01078557 2500ff0000                       and        eax, 0xff00
0107855c 49c1e808                         shr        r8, 8
01078560 480bc8                           or         rcx, rax
01078563 8bc2                             mov        eax, edx
01078565 250000ff00                       and        eax, 0xff0000
0107856a 48c1e110                         shl        rcx, 0x10
0107856e 480bc8                           or         rcx, rax
01078571 8bc2                             mov        eax, edx
01078573 488b5530                         mov        rdx, qword ptr [rbp + 0x30]
01078577 4923c6                           and        rax, r14
0107857a 48c1e110                         shl        rcx, 0x10
0107857e 480bc8                           or         rcx, rax
01078581 488bc2                           mov        rax, rdx
01078584 48c1e810                         shr        rax, 0x10
01078588 48c1e108                         shl        rcx, 8
0107858c 4c0bc1                           or         r8, rcx
0107858f 488bca                           mov        rcx, rdx
01078592 4c894524                         mov        qword ptr [rbp + 0x24], r8
01078596 4c8bc2                           mov        r8, rdx
01078599 48c1e110                         shl        rcx, 0x10
0107859d 4d23c3                           and        r8, r11
010785a0 4c0bc0                           or         r8, rax
010785a3 488bc2                           mov        rax, rdx
010785a6 4823c3                           and        rax, rbx
010785a9 49c1e810                         shr        r8, 0x10
010785ad 4c0bc0                           or         r8, rax
010785b0 488bc2                           mov        rax, rdx
010785b3 4823c7                           and        rax, rdi
010785b6 49c1e810                         shr        r8, 0x10
010785ba 4c0bc0                           or         r8, rax
010785bd 488bc2                           mov        rax, rdx
010785c0 2500ff0000                       and        eax, 0xff00
010785c5 49c1e808                         shr        r8, 8
010785c9 480bc8                           or         rcx, rax
010785cc 488bc2                           mov        rax, rdx
010785cf 250000ff00                       and        eax, 0xff0000
010785d4 48c1e110                         shl        rcx, 0x10
010785d8 480bc8                           or         rcx, rax
010785db 4923d6                           and        rdx, r14
010785de 48c1e110                         shl        rcx, 0x10
010785e2 4d8bf5                           mov        r14, r13
010785e5 480bca                           or         rcx, rdx
010785e8 48c1e108                         shl        rcx, 8
010785ec 4c0bc1                           or         r8, rcx
010785ef 8b4d3c                           mov        ecx, dword ptr [rbp + 0x3c]
010785f2 8bd1                             mov        edx, ecx
010785f4 4c894530                         mov        qword ptr [rbp + 0x30], r8
010785f8 81e20000ff00                     and        edx, 0xff0000
010785fe 8bc1                             mov        eax, ecx
01078600 c1e810                           shr        eax, 0x10
01078603 0bd0                             or         edx, eax
01078605 8bc1                             mov        eax, ecx
01078607 c1e010                           shl        eax, 0x10
0107860a 81e100ff0000                     and        ecx, 0xff00
01078610 0bc1                             or         eax, ecx
01078612 c1ea08                           shr        edx, 8
01078615 c1e008                           shl        eax, 8
01078618 0bd0                             or         edx, eax
0107861a 89553c                           mov        dword ptr [rbp + 0x3c], edx
0107861d eb08                             jmp        0x141078627
0107861f 448b551c                         mov        r10d, dword ptr [rbp + 0x1c]
01078623 448b4d10                         mov        r9d, dword ptr [rbp + 0x10]
01078627 4181f96d696168                   cmp        r9d, 0x6861696d
0107862e 0f8501050000                     jne        0x141078b35
01078634 33c0                             xor        eax, eax
01078636 4533ed                           xor        r13d, r13d
01078639 89442468                         mov        dword ptr [rsp + 0x68], eax
0107863d 4585d2                           test       r10d, r10d
01078640 0f8423030000                     je         0x141078969
01078646 66660f1f840000000000             nop        word ptr [rax + rax]
01078650 41b808000000                     mov        r8d, 8
01078656 488d55f0                         lea        rdx, [rbp - 0x10]
0107865a 488bce                           mov        rcx, rsi
0107865d 4d8be6                           mov        r12, r14
01078660 e83beaffff                       call       0x1410770a0
01078665 8bf8                             mov        edi, eax
01078667 85c0                             test       eax, eax
01078669 0f85d4040000                     jne        0x141078b43
0107866f 448b55f4                         mov        r10d, dword ptr [rbp - 0xc]
01078673 418bda                           mov        ebx, r10d
01078676 418bca                           mov        ecx, r10d
01078679 413806                           cmp        byte ptr [r14], al
0107867c 7522                             jne        0x1410786a0
0107867e 81e30000ff00                     and        ebx, 0xff0000
01078684 8bc1                             mov        eax, ecx
01078686 c1e810                           shr        eax, 0x10
01078689 0bd8                             or         ebx, eax
0107868b 8bc1                             mov        eax, ecx
0107868d c1e010                           shl        eax, 0x10
01078690 81e100ff0000                     and        ecx, 0xff00
01078696 0bc1                             or         eax, ecx
01078698 c1eb08                           shr        ebx, 8
0107869b c1e008                           shl        eax, 8
0107869e 0bd8                             or         ebx, eax
010786a0 41be18000000                     mov        r14d, 0x18
010786a6 488d4df8                         lea        rcx, [rbp - 8]
010786aa 413bde                           cmp        ebx, r14d
010786ad 440f42f3                         cmovb      r14d, ebx
010786b1 4183fe08                         cmp        r14d, 8
010786b5 7635                             jbe        0x1410786ec
010786b7 458d7ef8                         lea        r15d, [r14 - 8]
010786bb 4981ff0000a000                   cmp        r15, 0xa00000
010786c2 0f876d040000                     ja         0x141078b35
010786c8 458bc7                           mov        r8d, r15d
010786cb 488d55f8                         lea        rdx, [rbp - 8]
010786cf 488bce                           mov        rcx, rsi
010786d2 e8c9e9ffff                       call       0x1410770a0
010786d7 8bf8                             mov        edi, eax
010786d9 85c0                             test       eax, eax
010786db 0f8562040000                     jne        0x141078b43
010786e1 448b55f4                         mov        r10d, dword ptr [rbp - 0xc]
010786e5 488d4df8                         lea        rcx, [rbp - 8]
010786e9 4903cf                           add        rcx, r15
010786ec 4183fe18                         cmp        r14d, 0x18
010786f0 7319                             jae        0x14107870b
010786f2 4885c9                           test       rcx, rcx
010786f5 7414                             je         0x14107870b
010786f7 41b818000000                     mov        r8d, 0x18
010786fd 33d2                             xor        edx, edx
010786ff 452bc6                           sub        r8d, r14d
01078702 e899457200                       call       0x14179cca0
01078707 448b55f4                         mov        r10d, dword ptr [rbp - 0xc]
0107870b 413bde                           cmp        ebx, r14d
0107870e 7617                             jbe        0x141078727
01078710 412bde                           sub        ebx, r14d
01078713 488bce                           mov        rcx, rsi
01078716 8bd3                             mov        edx, ebx
01078718 e8031effff                       call       0x14106a520
0107871d 8bf8                             mov        edi, eax
0107871f 85c0                             test       eax, eax
01078721 0f851c040000                     jne        0x141078b43
01078727 41803c2400                       cmp        byte ptr [r12], 0
0107872c 4d8bf4                           mov        r14, r12
0107872f 0f85ed000000                     jne        0x141078822
01078735 8b4df0                           mov        ecx, dword ptr [rbp - 0x10]
01078738 448bc1                           mov        r8d, ecx
0107873b 8bc1                             mov        eax, ecx
0107873d 4181e00000ff00                   and        r8d, 0xff0000
01078744 c1e810                           shr        eax, 0x10
01078747 440bc0                           or         r8d, eax
0107874a 8bc1                             mov        eax, ecx
0107874c c1e010                           shl        eax, 0x10
0107874f 81e100ff0000                     and        ecx, 0xff00
01078755 0bc1                             or         eax, ecx
01078757 41c1e808                         shr        r8d, 8
0107875b c1e008                           shl        eax, 8
0107875e 418bca                           mov        ecx, r10d
01078761 440bc0                           or         r8d, eax
01078764 81e10000ff00                     and        ecx, 0xff0000
0107876a 418bc2                           mov        eax, r10d
0107876d 448945f0                         mov        dword ptr [rbp - 0x10], r8d
01078771 c1e810                           shr        eax, 0x10
01078774 0bc8                             or         ecx, eax
01078776 418bc2                           mov        eax, r10d
01078779 c1e010                           shl        eax, 0x10
0107877c 4181e200ff0000                   and        r10d, 0xff00
01078783 410bc2                           or         eax, r10d
01078786 c1e908                           shr        ecx, 8
01078789 c1e008                           shl        eax, 8
0107878c 448bd1                           mov        r10d, ecx
0107878f 8b4df8                           mov        ecx, dword ptr [rbp - 8]
01078792 440bd0                           or         r10d, eax
01078795 8bc1                             mov        eax, ecx
01078797 448955f4                         mov        dword ptr [rbp - 0xc], r10d
0107879b c1e810                           shr        eax, 0x10
0107879e 8bd1                             mov        edx, ecx
010787a0 81e20000ff00                     and        edx, 0xff0000
010787a6 0bd0                             or         edx, eax
010787a8 8bc1                             mov        eax, ecx
010787aa c1e010                           shl        eax, 0x10
010787ad 81e100ff0000                     and        ecx, 0xff00
010787b3 0bc1                             or         eax, ecx
010787b5 c1ea08                           shr        edx, 8
010787b8 8b4dfc                           mov        ecx, dword ptr [rbp - 4]
010787bb 448bd9                           mov        r11d, ecx
010787be c1e008                           shl        eax, 8
010787c1 4181e30000ff00                   and        r11d, 0xff0000
010787c8 0bd0                             or         edx, eax
010787ca 8bc1                             mov        eax, ecx
010787cc c1e810                           shr        eax, 0x10
010787cf 440bd8                           or         r11d, eax
010787d2 8955f8                           mov        dword ptr [rbp - 8], edx
010787d5 8bc1                             mov        eax, ecx
010787d7 41c1eb08                         shr        r11d, 8
010787db c1e010                           shl        eax, 0x10
010787de 81e100ff0000                     and        ecx, 0xff00
010787e4 0bc1                             or         eax, ecx
010787e6 8b4d00                           mov        ecx, dword ptr [rbp]
010787e9 c1e008                           shl        eax, 8
010787ec 448bc9                           mov        r9d, ecx
010787ef 440bd8                           or         r11d, eax
010787f2 4181e10000ff00                   and        r9d, 0xff0000
010787f9 8bc1                             mov        eax, ecx
010787fb 44895dfc                         mov        dword ptr [rbp - 4], r11d
010787ff c1e810                           shr        eax, 0x10
01078802 440bc8                           or         r9d, eax
01078805 8bc1                             mov        eax, ecx
01078807 c1e010                           shl        eax, 0x10
0107880a 81e100ff0000                     and        ecx, 0xff00
01078810 0bc1                             or         eax, ecx
01078812 41c1e908                         shr        r9d, 8
01078816 c1e008                           shl        eax, 8
01078819 440bc8                           or         r9d, eax
0107881c 44894d00                         mov        dword ptr [rbp], r9d
01078820 eb0f                             jmp        0x141078831
01078822 448b4d00                         mov        r9d, dword ptr [rbp]
01078826 448b5dfc                         mov        r11d, dword ptr [rbp - 4]
0107882a 8b55f8                           mov        edx, dword ptr [rbp - 8]
0107882d 448b45f0                         mov        r8d, dword ptr [rbp - 0x10]
01078831 4181f86d686f68                   cmp        r8d, 0x686f686d
01078838 0f85f7020000                     jne        0x141078b35
0107883e 4181c3d4feffff                   add        r11d, 0xfffffed4
01078845 4183fb07                         cmp        r11d, 7
01078849 0f87c9000000                     ja         0x141078918
0107884f 4c8d05aa77f8fe                   lea        r8, [rip - 0x1078856]
01078856 438b8c98848b0701                 mov        ecx, dword ptr [r8 + r11*4 + 0x1078b84]
0107885e 4903c8                           add        rcx, r8
01078861 ffe1                             jmp        rcx
01078863 4c8b442458                       mov        r8, qword ptr [rsp + 0x58]
01078868 4981c0c0010000                   add        r8, 0x1c0
0107886f eb7d                             jmp        0x1410788ee
01078871 4c8b442458                       mov        r8, qword ptr [rsp + 0x58]
01078876 488d4594                         lea        rax, [rbp - 0x6c]
0107887a 4981c008020000                   add        r8, 0x208
01078881 eb6f                             jmp        0x1410788f2
01078883 4c8b442458                       mov        r8, qword ptr [rsp + 0x58]
01078888 488d4598                         lea        rax, [rbp - 0x68]
0107888c 4981c008020000                   add        r8, 0x208
01078893 eb5d                             jmp        0x1410788f2
01078895 4c8b442458                       mov        r8, qword ptr [rsp + 0x58]
0107889a 488d45bc                         lea        rax, [rbp - 0x44]
0107889e 4981c0b0050000                   add        r8, 0x5b0
010788a5 c744242801000000                 mov        dword ptr [rsp + 0x28], 1
010788ad 33d2                             xor        edx, edx
010788af eb4e                             jmp        0x1410788ff
010788b1 4c8b442458                       mov        r8, qword ptr [rsp + 0x58]
010788b6 488d45c0                         lea        rax, [rbp - 0x40]
010788ba 4981c0b0050000                   add        r8, 0x5b0
010788c1 33d2                             xor        edx, edx
010788c3 eb32                             jmp        0x1410788f7
010788c5 4c8b442458                       mov        r8, qword ptr [rsp + 0x58]
010788ca 488d442468                       lea        rax, [rsp + 0x68]
010788cf 4981c0b0050000                   add        r8, 0x5b0
010788d6 c744242801000000                 mov        dword ptr [rsp + 0x28], 1
010788de 33d2                             xor        edx, edx
010788e0 eb1d                             jmp        0x1410788ff
010788e2 4c8b442458                       mov        r8, qword ptr [rsp + 0x58]
010788e7 4981c040060000                   add        r8, 0x640
010788ee 488d4590                         lea        rax, [rbp - 0x70]
010788f2 ba01000000                       mov        edx, 1
010788f7 c744242800000000                 mov        dword ptr [rsp + 0x28], 0
010788ff 488bce                           mov        rcx, rsi
01078902 4889442420                       mov        qword ptr [rsp + 0x20], rax
01078907 e8c4eaffff                       call       0x1410773d0
0107890c 8bf8                             mov        edi, eax
0107890e 85c0                             test       eax, eax
01078910 0f852d020000                     jne        0x141078b43
01078916 eb37                             jmp        0x14107894f
01078918 488b8e7801e001                   mov        rcx, qword ptr [rsi + 0x1e00178]
0107891f 412bd2                           sub        edx, r10d
01078922 4863d2                           movsxd     rdx, edx
01078925 4803967001e001                   add        rdx, qword ptr [rsi + 0x1e00170]
0107892c 4889967001e001                   mov        qword ptr [rsi + 0x1e00170], rdx
01078933 483bd1                           cmp        rdx, rcx
01078936 720c                             jb         0x141078944
01078938 48038e8001e001                   add        rcx, qword ptr [rsi + 0x1e00180]
0107893f 483bd1                           cmp        rdx, rcx
01078942 720b                             jb         0x14107894f
01078944 48c7868001e00100000000           mov        qword ptr [rsi + 0x1e00180], 0
0107894f 41ffc5                           inc        r13d
01078952 443b6d1c                         cmp        r13d, dword ptr [rbp + 0x1c]
01078956 0f82f4fcffff                     jb         0x141078650
0107895c 448b7dbc                         mov        r15d, dword ptr [rbp - 0x44]
01078960 8b442468                         mov        eax, dword ptr [rsp + 0x68]
01078964 4c8b642458                       mov        r12, qword ptr [rsp + 0x58]
01078969 807d2c03                         cmp        byte ptr [rbp + 0x2c], 3
0107896d 7562                             jne        0x1410789d1
0107896f 4585ff                           test       r15d, r15d
01078972 7457                             je         0x1410789cb
01078974 498d9424b0050000                 lea        rdx, [r12 + 0x5b0]
0107897c 4885d2                           test       rdx, rdx
0107897f 7450                             je         0x1410789d1
01078981 813a63727473                     cmp        dword ptr [rdx], 0x73747263
01078987 7548                             jne        0x1410789d1
01078989 837a3c00                         cmp        dword ptr [rdx + 0x3c], 0
0107898d 7542                             jne        0x1410789d1
0107898f 83f801                           cmp        eax, 1
01078992 7c3d                             jl         0x1410789d1
01078994 3b422c                           cmp        eax, dword ptr [rdx + 0x2c]
01078997 7f38                             jg         0x1410789d1
01078999 f6420401                         test       byte ptr [rdx + 4], 1
0107899d 4c63c0                           movsxd     r8, eax
010789a0 740f                             je         0x1410789b1
010789a2 488b4218                         mov        rax, qword ptr [rdx + 0x18]
010789a6 488b08                           mov        rcx, qword ptr [rax]
010789a9 42836c81fc01                     sub        dword ptr [rcx + r8*4 - 4], 1
010789af 7520                             jne        0x1410789d1
010789b1 488b4210                         mov        rax, qword ptr [rdx + 0x10]
010789b5 488b08                           mov        rcx, qword ptr [rax]
010789b8 428b44c1fc                       mov        eax, dword ptr [rcx + r8*8 - 4]
010789bd 014240                           add        dword ptr [rdx + 0x40], eax
010789c0 42c744c1f801000080               mov        dword ptr [rcx + r8*8 - 8], 0x80000001
010789c9 eb06                             jmp        0x1410789d1
010789cb 85c0                             test       eax, eax
010789cd 440f45f8                         cmovne     r15d, eax
010789d1 807d2d00                         cmp        byte ptr [rbp + 0x2d], 0
010789d5 0fb6452c                         movzx      eax, byte ptr [rbp + 0x2c]
010789d9 440fb6452e                       movzx      r8d, byte ptr [rbp + 0x2e]
010789de 0f95c2                           setne      dl
010789e1 4c8b4d30                         mov        r9, qword ptr [rbp + 0x30]
010789e5 488b4d24                         mov        rcx, qword ptr [rbp + 0x24]
010789e9 83e802                           sub        eax, 2
010789ec 7466                             je         0x141078a54
010789ee 83e801                           sub        eax, 1
010789f1 7417                             je         0x141078a0a
010789f3 83e801                           sub        eax, 1
010789f6 743e                             je         0x141078a36
010789f8 83e801                           sub        eax, 1
010789fb 0f848c000000                     je         0x141078a8d
01078a01 83f801                           cmp        eax, 1
01078a04 0f8583000000                     jne        0x141078a8d
01078a0a 448b4590                         mov        r8d, dword ptr [rbp - 0x70]
01078a0e 488d442460                       lea        rax, [rsp + 0x60]
01078a13 4889442430                       mov        qword ptr [rsp + 0x30], rax
01078a18 458bcf                           mov        r9d, r15d
01078a1b 8b45c0                           mov        eax, dword ptr [rbp - 0x40]
01078a1e ba03000000                       mov        edx, 3
01078a23 48894c2428                       mov        qword ptr [rsp + 0x28], rcx
01078a28 498bcc                           mov        rcx, r12
01078a2b 89442420                         mov        dword ptr [rsp + 0x20], eax
01078a2f e8fcee0000                       call       0x141087930
01078a34 eb4e                             jmp        0x141078a84
01078a36 448b453c                         mov        r8d, dword ptr [rbp + 0x3c]
01078a3a 488d442460                       lea        rax, [rsp + 0x60]
01078a3f 8b5590                           mov        edx, dword ptr [rbp - 0x70]
01078a42 4c8bc9                           mov        r9, rcx
01078a45 498bcc                           mov        rcx, r12
01078a48 4889442420                       mov        qword ptr [rsp + 0x20], rax
01078a4d e8deef0000                       call       0x141087a30
01078a52 eb30                             jmp        0x141078a84
01078a54 488d442460                       lea        rax, [rsp + 0x60]
01078a59 4889442440                       mov        qword ptr [rsp + 0x40], rax
01078a5e 4c894c2438                       mov        qword ptr [rsp + 0x38], r9
01078a63 448b4d98                         mov        r9d, dword ptr [rbp - 0x68]
01078a67 4488442430                       mov        byte ptr [rsp + 0x30], r8b
01078a6c 448b4594                         mov        r8d, dword ptr [rbp - 0x6c]
01078a70 48894c2428                       mov        qword ptr [rsp + 0x28], rcx
01078a75 498bcc                           mov        rcx, r12
01078a78 88542420                         mov        byte ptr [rsp + 0x20], dl
01078a7c 8b5590                           mov        edx, dword ptr [rbp - 0x70]
01078a7f e87ced0000                       call       0x141087800
01078a84 8bf8                             mov        edi, eax
01078a86 3d4e230000                       cmp        eax, 0x234e
01078a8b 7504                             jne        0x141078a91
01078a8d 33ff                             xor        edi, edi
01078a8f eb7f                             jmp        0x141078b10
01078a91 85ff                             test       edi, edi
01078a93 757b                             jne        0x141078b10
01078a95 397d20                           cmp        dword ptr [rbp + 0x20], edi
01078a98 7419                             je         0x141078ab3
01078a9a 488d8ec002e001                   lea        rcx, [rsi + 0x1e002c0]
01078aa1 4c8d4c2460                       lea        r9, [rsp + 0x60]
01078aa6 4c8d4520                         lea        r8, [rbp + 0x20]
01078aaa 488d55d8                         lea        rdx, [rbp - 0x28]
01078aae e8bdaa61ff                       call       0x140693570
01078ab3 0fb65539                         movzx      edx, byte ptr [rbp + 0x39]
01078ab7 488b4c2460                       mov        rcx, qword ptr [rsp + 0x60]
01078abc 84d2                             test       dl, dl
01078abe 7422                             je         0x141078ae2
01078ac0 488b4130                         mov        rax, qword ptr [rcx + 0x30]
01078ac4 4885c0                           test       rax, rax
01078ac7 743e                             je         0x141078b07
01078ac9 0fb68014010000                   movzx      eax, byte ptr [rax + 0x114]
01078ad0 f6d0                             not        al
01078ad2 a801                             test       al, 1
01078ad4 7431                             je         0x141078b07
01078ad6 0fb64538                         movzx      eax, byte ptr [rbp + 0x38]
01078ada 884171                           mov        byte ptr [rcx + 0x71], al
01078add 885172                           mov        byte ptr [rcx + 0x72], dl
01078ae0 eb25                             jmp        0x141078b07
01078ae2 0fb65538                         movzx      edx, byte ptr [rbp + 0x38]
01078ae6 84d2                             test       dl, dl
01078ae8 7e1d                             jle        0x141078b07
01078aea 488b4130                         mov        rax, qword ptr [rcx + 0x30]
01078aee 4885c0                           test       rax, rax
01078af1 7414                             je         0x141078b07
01078af3 0fb68014010000                   movzx      eax, byte ptr [rax + 0x114]
01078afa f6d0                             not        al
01078afc a801                             test       al, 1
01078afe 7407                             je         0x141078b07
01078b00 885171                           mov        byte ptr [rcx + 0x71], dl
01078b03 c6417201                         mov        byte ptr [rcx + 0x72], 1
01078b07 0fb6553a                         movzx      edx, byte ptr [rbp + 0x3a]
01078b0b e88033efff                       call       0x140f6be90
01078b10 48ff869001e001                   inc        qword ptr [rsi + 0x1e00190]
01078b17 488bce                           mov        rcx, rsi
01078b1a e821e8ffff                       call       0x141077340
01078b1f 8b5c2470                         mov        ebx, dword ptr [rsp + 0x70]
01078b23 ffc3                             inc        ebx
01078b25 895c2470                         mov        dword ptr [rsp + 0x70], ebx
01078b29 3b5d78                           cmp        ebx, dword ptr [rbp + 0x78]
01078b2c 730e                             jae        0x141078b3c
01078b2e 33d2                             xor        edx, edx
01078b30 e9ebf7ffff                       jmp        0x141078320
01078b35 bf30ffffff                       mov        edi, 0xffffff30
01078b3a eb07                             jmp        0x141078b43
01078b3c c686a801e00101                   mov        byte ptr [rsi + 0x1e001a8], 1
01078b43 4c8bb42428020000                 mov        r14, qword ptr [rsp + 0x228]
01078b4b 4c8bac2420020000                 mov        r13, qword ptr [rsp + 0x220]
01078b53 488b9c2418020000                 mov        rbx, qword ptr [rsp + 0x218]
01078b5b 4c8bbc24e0010000                 mov        r15, qword ptr [rsp + 0x1e0]
; unwind group range 0x1078b63..0x1078ba4 (exclusive)
01078b63 8bc7                             mov        eax, edi
01078b65 488b8dd0000000                   mov        rcx, qword ptr [rbp + 0xd0]
01078b6c 4833cc                           xor        rcx, rsp
01078b6f e86c2d7200                       call       0x14179b8e0
01078b74 4881c4e8010000                   add        rsp, 0x1e8
01078b7b 415c                             pop        r12
01078b7d 5f                               pop        rdi
01078b7e 5e                               pop        rsi
01078b7f 5d                               pop        rbp
01078b80 c3                               ret        
01078b81 0f1f00                           nop        dword ptr [rax]
01078b84 638807017188                     movsxd     ecx, dword ptr [rax - 0x778efef9]
