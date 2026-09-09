; Original iTunes.exe machine code; base=0x140000000; RVA=0x107ee90; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x107ee90..0x1081790 (exclusive)
0107ee90 mov        qword ptr [rsp + 0x10], rbx
0107ee95 mov        qword ptr [rsp + 0x18], rsi
0107ee9a mov        qword ptr [rsp + 0x20], rdi
0107ee9f push       rbp
0107eea0 push       r12
0107eea2 push       r13
0107eea4 push       r14
0107eea6 push       r15
0107eea8 lea        rbp, [rsp - 0x1670]
0107eeb0 mov        eax, 0x1770
0107eeb5 call       0x1418677a0
0107eeba sub        rsp, rax
0107eebd movaps     xmmword ptr [rsp + 0x1760], xmm6
0107eec5 movaps     xmmword ptr [rsp + 0x1750], xmm7
0107eecd mov        rax, qword ptr [rip + 0xf5616c]
0107eed4 xor        rax, rsp
0107eed7 mov        qword ptr [rbp + 0x1640], rax
0107eede mov        dword ptr [rsp + 0x40], edx
0107eee2 mov        rdi, rcx
0107eee5 mov        rax, qword ptr [rcx + 0x1e00270]
0107eeec mov        qword ptr [rsp + 0x60], rax
0107eef1 mov        r8d, 8
0107eef7 lea        rdx, [rbp + 0xf10]
0107eefe call       0x1410770a0
0107ef03 mov        ebx, eax
0107ef05 test       eax, eax
0107ef07 jne        0x1410816e7
0107ef0d mov        r10d, dword ptr [rbp + 0xf14]
0107ef14 mov        esi, r10d
0107ef17 lea        r13, [rdi + 0x52]
0107ef1b cmp        byte ptr [r13], al
0107ef1f jne        0x14107ef23
0107ef21 bswap      esi
0107ef23 lea        rcx, [rbp + 0xf18]
0107ef2a mov        r15d, 0x5c
0107ef30 mov        r14d, r15d
0107ef33 cmp        esi, r15d
0107ef36 cmovb      r14d, esi
0107ef3a cmp        r14d, 8
0107ef3e jbe        0x14107ef7e
0107ef40 lea        r12d, [r14 - 8]
0107ef44 cmp        r12, 0xa00000
0107ef4b ja         0x1410816e2
0107ef51 mov        r8d, r12d
0107ef54 lea        rdx, [rbp + 0xf18]
0107ef5b mov        rcx, rdi
0107ef5e call       0x1410770a0
0107ef63 mov        ebx, eax
0107ef65 test       eax, eax
0107ef67 jne        0x1410816e7
0107ef6d lea        rcx, [rbp + 0xf18]
0107ef74 add        rcx, r12
0107ef77 mov        r10d, dword ptr [rbp + 0xf14]
0107ef7e cmp        r14d, r15d
0107ef81 jae        0x14107ef9c
0107ef83 test       rcx, rcx
0107ef86 je         0x14107ef9c
0107ef88 sub        r15d, r14d
0107ef8b mov        r8d, r15d
0107ef8e xor        edx, edx
0107ef90 call       0x14179cca0
0107ef95 mov        r10d, dword ptr [rbp + 0xf14]
0107ef9c cmp        esi, r14d
0107ef9f jbe        0x14107efb8
0107efa1 sub        esi, r14d
0107efa4 mov        edx, esi
0107efa6 mov        rcx, rdi
0107efa9 call       0x14106a520
0107efae mov        ebx, eax
0107efb0 test       eax, eax
0107efb2 jne        0x1410816e7
0107efb8 xor        r15d, r15d
0107efbb mov        ebx, r15d
0107efbe cmp        byte ptr [r13], r15b
0107efc2 jne        0x14107f05d
0107efc8 mov        ecx, dword ptr [rbp + 0xf10]
0107efce mov        edx, ecx
0107efd0 and        edx, 0xff0000
0107efd6 mov        eax, ecx
0107efd8 shr        eax, 0x10
0107efdb or         edx, eax
0107efdd shr        edx, 8
0107efe0 mov        eax, ecx
0107efe2 and        eax, 0xff00
0107efe7 shl        ecx, 0x10
0107efea or         eax, ecx
0107efec shl        eax, 8
0107efef or         edx, eax
0107eff1 mov        dword ptr [rbp + 0xf10], edx
0107eff7 mov        ecx, r10d
0107effa and        ecx, 0xff0000
0107f000 mov        eax, r10d
0107f003 shr        eax, 0x10
0107f006 or         ecx, eax
0107f008 shr        ecx, 8
0107f00b mov        eax, r10d
0107f00e shl        eax, 0x10
0107f011 and        r10d, 0xff00
0107f018 or         eax, r10d
0107f01b shl        eax, 8
0107f01e or         ecx, eax
0107f020 mov        dword ptr [rbp + 0xf14], ecx
0107f026 mov        ecx, dword ptr [rbp + 0xf18]
0107f02c mov        r8d, ecx
0107f02f and        r8d, 0xff0000
0107f036 mov        eax, ecx
0107f038 shr        eax, 0x10
0107f03b or         r8d, eax
0107f03e shr        r8d, 8
0107f042 mov        eax, ecx
0107f044 and        eax, 0xff00
0107f049 shl        ecx, 0x10
0107f04c or         eax, ecx
0107f04e shl        eax, 8
0107f051 or         r8d, eax
0107f054 mov        dword ptr [rbp + 0xf18], r8d
0107f05b jmp        0x14107f06a
0107f05d mov        r8d, dword ptr [rbp + 0xf18]
0107f064 mov        edx, dword ptr [rbp + 0xf10]
0107f06a cmp        edx, 0x68706c6d
0107f070 jne        0x1410816e2
0107f076 mov        dword ptr [rsp + 0x70], r15d
0107f07b test       r8d, r8d
0107f07e je         0x1410816e7
0107f084 movsd      xmm6, qword ptr [rip + 0xbf41bc]
0107f08c movss      xmm7, dword ptr [rip + 0xbf5408]
0107f094 nop        dword ptr [rax]
0107f098 nop        dword ptr [rax + rax]
0107f0a0 mov        qword ptr [rbp - 0x18], r15
0107f0a4 mov        qword ptr [rsp + 0x78], r15
0107f0a9 mov        byte ptr [rsp + 0x34], 0
0107f0ae mov        byte ptr [rsp + 0x35], 0
0107f0b3 mov        qword ptr [rsp + 0x48], r15
0107f0b8 mov        r8d, 8
0107f0be lea        rdx, [rbp + 0x120]
0107f0c5 mov        rcx, rdi
0107f0c8 call       0x1410770a0
0107f0cd mov        ebx, eax
0107f0cf test       eax, eax
0107f0d1 jne        0x1410816e7
0107f0d7 mov        esi, dword ptr [rbp + 0x124]
0107f0dd mov        ecx, esi
0107f0df cmp        byte ptr [r13], al
0107f0e3 jne        0x14107f107
0107f0e5 and        esi, 0xff0000
0107f0eb mov        eax, ecx
0107f0ed shr        eax, 0x10
0107f0f0 or         esi, eax
0107f0f2 shr        esi, 8
0107f0f5 mov        eax, ecx
0107f0f7 shl        eax, 0x10
0107f0fa and        ecx, 0xff00
0107f100 or         eax, ecx
0107f102 shl        eax, 8
0107f105 or         esi, eax
0107f107 lea        rcx, [rbp + 0x128]
0107f10e mov        r15d, 0xdac
0107f114 cmp        esi, r15d
0107f117 cmovb      r15d, esi
0107f11b cmp        r15d, 8
0107f11f jbe        0x14107f158
0107f121 lea        r12d, [r15 - 8]
0107f125 cmp        r12, 0xa00000
0107f12c ja         0x1410816e2
0107f132 mov        r8d, r12d
0107f135 lea        rdx, [rbp + 0x128]
0107f13c mov        rcx, rdi
0107f13f call       0x1410770a0
0107f144 mov        ebx, eax
0107f146 test       eax, eax
0107f148 jne        0x1410816e7
0107f14e lea        rcx, [rbp + 0x128]
0107f155 add        rcx, r12
0107f158 cmp        r15d, 0xdac
0107f15f jae        0x14107f176
0107f161 test       rcx, rcx
0107f164 je         0x14107f176
0107f166 mov        r8d, 0xdac
0107f16c sub        r8d, r15d
0107f16f xor        edx, edx
0107f171 call       0x14179cca0
0107f176 cmp        esi, r15d
0107f179 jbe        0x14107f192
0107f17b sub        esi, r15d
0107f17e mov        edx, esi
0107f180 mov        rcx, rdi
0107f183 call       0x14106a520
0107f188 mov        ebx, eax
0107f18a test       eax, eax
0107f18c jne        0x1410816e7
0107f192 xor        r15d, r15d
0107f195 mov        ebx, r15d
0107f198 lea        rdx, [rbp + 0x120]
0107f19f mov        rcx, rdi
0107f1a2 call       0x141069860
0107f1a7 cmp        dword ptr [rbp + 0x120], 0x6870696d
0107f1b1 jne        0x1410816e2
0107f1b7 movzx      eax, byte ptr [rbp + 0x35a]
0107f1be test       al, al
0107f1c0 jne        0x14107f20a
0107f1c2 movzx      esi, byte ptr [rbp + 0x359]
0107f1c9 test       si, si
0107f1cc jne        0x14107f20d
0107f1ce movzx      eax, byte ptr [rbp + 0x338]
0107f1d5 test       al, al
0107f1d7 jne        0x14107f20a
0107f1d9 cmp        byte ptr [rbp + 0x2ec], bl
0107f1df je         0x14107f1e8
0107f1e1 mov        esi, 0x11
0107f1e6 jmp        0x14107f22f
0107f1e8 cmp        byte ptr [rbp + 0x2e1], bl
0107f1ee je         0x14107f1f7
0107f1f0 mov        esi, 0x13
0107f1f5 jmp        0x14107f22f
0107f1f7 cmp        byte ptr [rbp + 0x329], bl
0107f1fd je         0x14107f2ad
0107f203 mov        esi, 0xa
0107f208 jmp        0x14107f22f
0107f20a movzx      esi, ax
0107f20d cmp        si, 0x16
0107f211 je         0x14107f24a
0107f213 movzx      eax, si
0107f216 cmp        si, 0x34
0107f21a je         0x14107f24a
0107f21c test       ax, ax
0107f21f je         0x14107f23b
0107f221 mov        ecx, 0xc8
0107f226 sub        ax, cx
0107f229 cmp        ax, 6
0107f22d jbe        0x14107f23b
0107f22f mov        ecx, dword ptr [rsp + 0x40]
0107f233 bt         ecx, 0xb
0107f237 jb         0x14107f24a
0107f239 jmp        0x14107f23f
0107f23b mov        ecx, dword ptr [rsp + 0x40]
0107f23f cmp        si, 0xa
0107f243 jne        0x14107f27b
0107f245 test       cl, 2
0107f248 je         0x14107f2b1
0107f24a lea        rdx, [rbp + 0x120]
0107f251 mov        rcx, rdi
0107f254 call       0x14107ea60
0107f259 inc        qword ptr [rdi + 0x1e00190]
0107f260 mov        esi, dword ptr [rsp + 0x70]
0107f264 inc        esi
0107f266 mov        dword ptr [rsp + 0x70], esi
0107f26a cmp        esi, dword ptr [rbp + 0xf18]
0107f270 jae        0x1410816e7
0107f276 jmp        0x14107f0a0
0107f27b cmp        si, 0x1f
0107f27f jne        0x14107f286
0107f281 test       cl, 1
0107f284 jmp        0x14107f248
0107f286 cmp        si, 0x13
0107f28a jne        0x14107f291
0107f28c test       cl, 4
0107f28f jmp        0x14107f248
0107f291 cmp        si, 6
0107f295 je         0x14107f24a
0107f297 cmp        si, 7
0107f29b jne        0x14107f2a7
0107f29d mov        ecx, dword ptr [rsp + 0x40]
0107f2a1 test       cl, cl
0107f2a3 jns        0x14107f2b1
0107f2a5 jmp        0x14107f24a
0107f2a7 cmp        si, 0x12
0107f2ab je         0x14107f24a
0107f2ad mov        ecx, dword ptr [rsp + 0x40]
0107f2b1 cmp        qword ptr [rbp + 0x2fc], rbx
0107f2b8 je         0x14107f2bf
0107f2ba test       cl, 8
0107f2bd jne        0x14107f24a
0107f2bf movzx      ecx, si
0107f2c2 call       0x140ee8290
0107f2c7 mov        r14d, dword ptr [rsp + 0x40]
0107f2cc test       al, al
0107f2ce je         0x14107f2da
0107f2d0 test       r14b, 0x10
0107f2d4 jne        0x14107f24a
0107f2da cmp        byte ptr [rbp + 0x136], bl
0107f2e0 je         0x14107f2ec
0107f2e2 test       r14b, 0x20
0107f2e6 jne        0x14107f24a
0107f2ec mov        dword ptr [rbp + 0x1440], 0x200001
0107f2f6 mov        rdx, qword ptr [rbp + 0x330]
0107f2fd mov        r12, qword ptr [rsp + 0x60]
0107f302 test       rdx, rdx
0107f305 je         0x14107f327
0107f307 mov        rcx, r12
0107f30a call       0x140ef68d0
0107f30f mov        qword ptr [rbp + 0x10], rax
0107f313 test       rax, rax
0107f316 je         0x14107f327
0107f318 mov        rax, 0xffffffffffffffff
0107f31f mov        qword ptr [rbp + 0x18], rax
0107f323 lea        rbx, [rbp + 0x10]
0107f327 mov        qword ptr [rbp - 0x68], r15
0107f32b mov        qword ptr [rbp - 0x43], r15
0107f32f mov        word ptr [rbp - 0x3b], r15w
0107f334 mov        byte ptr [rbp - 0x39], r15b
0107f338 mov        qword ptr [rbp - 0x70], r12
0107f33c lea        rax, [rbp + 0x1440]
0107f343 mov        qword ptr [rbp - 0x60], rax
0107f347 mov        qword ptr [rbp - 0x58], rbx
0107f34b movzx      eax, byte ptr [rbp + 0x136]
0107f352 mov        byte ptr [rbp - 0x44], al
0107f355 mov        rax, qword ptr [rbp + 0x2d8]
0107f35c mov        qword ptr [rbp - 0x50], rax
0107f360 mov        eax, r15d
0107f363 test       r14d, r14d
0107f366 cmovs      eax, dword ptr [rbp + 0xe60]
0107f36d mov        dword ptr [rbp - 0x48], eax
0107f370 lea        rdx, [rsp + 0x48]
0107f375 lea        rcx, [rbp - 0x70]
0107f379 call       0x1410405b0
0107f37e mov        ebx, eax
0107f380 test       eax, eax
0107f382 jne        0x1410816e7
0107f388 mov        r15, qword ptr [rsp + 0x48]
0107f38d mov        ecx, dword ptr [rbp + 0x13c]
0107f393 mov        dword ptr [r15 + 0x1f4], ecx
0107f39a mov        ecx, dword ptr [rbp + 0x394]
0107f3a0 mov        dword ptr [r15 + 0x1f8], ecx
0107f3a7 movzx      edx, byte ptr [rbp + 0x2ed]
0107f3ae and        dl, 1
0107f3b1 shl        dl, 4
0107f3b4 movzx      ecx, byte ptr [r15 + 0x2ca]
0107f3bc and        cl, 0xef
0107f3bf or         dl, cl
0107f3c1 mov        byte ptr [r15 + 0x2ca], dl
0107f3c8 movzx      eax, byte ptr [rbp + 0x2ee]
0107f3cf and        al, 1
0107f3d1 shl        al, 5
0107f3d4 and        dl, 0xdf
0107f3d7 or         al, dl
0107f3d9 mov        byte ptr [r15 + 0x2ca], al
0107f3e0 movzx      eax, byte ptr [rbp + 0x850]
0107f3e7 mov        byte ptr [r15 + 0x2cd], al
0107f3ee movzx      eax, byte ptr [rbp + 0x33a]
0107f3f5 mov        byte ptr [r15 + 0x2cc], al
0107f3fc movzx      ecx, byte ptr [r15 + 0x2ca]
0107f404 and        cl, 0x7f
0107f407 movzx      eax, byte ptr [rbp + 0x2e0]
0107f40e shl        al, 7
0107f411 or         cl, al
0107f413 mov        byte ptr [r15 + 0x2ca], cl
0107f41a movzx      ecx, byte ptr [r15 + 0x2cb]
0107f422 and        cl, 0xfe
0107f425 movzx      eax, byte ptr [rbp + 0x855]
0107f42c and        al, 1
0107f42e or         cl, al
0107f430 mov        byte ptr [r15 + 0x2cb], cl
0107f437 movzx      eax, byte ptr [rbp + 0x857]
0107f43e and        al, 1
0107f440 add        al, al
0107f442 and        cl, 0xfd
0107f445 or         al, cl
0107f447 mov        byte ptr [r15 + 0x2cb], al
0107f44e movzx      eax, word ptr [rbp + 0x140]
0107f455 mov        word ptr [r15 + 0x2dc], ax
0107f45d movzx      eax, word ptr [rbp + 0x142]
0107f464 mov        word ptr [r15 + 0x2de], ax
0107f46c movzx      eax, word ptr [rbp + 0x144]
0107f473 mov        word ptr [r15 + 0x2e0], ax
0107f47b movzx      eax, word ptr [rbp + 0x146]
0107f482 mov        word ptr [r15 + 0x2e2], ax
0107f48a movzx      eax, word ptr [rbp + 0x2d6]
0107f491 mov        word ptr [r15 + 0x2e4], ax
0107f499 movzx      eax, word ptr [rbp + 0xdb8]
0107f4a0 mov        word ptr [r15 + 0x2e6], ax
0107f4a8 movzx      eax, word ptr [rbp + 0xdba]
0107f4af mov        word ptr [r15 + 0x2e8], ax
0107f4b7 movzx      eax, word ptr [rbp + 0xdbc]
0107f4be mov        word ptr [r15 + 0x2ea], ax
0107f4c6 movzx      eax, word ptr [rbp + 0xdbe]
0107f4cd mov        word ptr [r15 + 0x2ec], ax
0107f4d5 mov        eax, dword ptr [rbp + 0x344]
0107f4db sub        eax, 0x2d
0107f4de je         0x14107f4fa
0107f4e0 sub        eax, 1
0107f4e3 je         0x14107f4f3
0107f4e5 sub        eax, 5
0107f4e8 je         0x14107f4fa
0107f4ea cmp        eax, 1
0107f4ed je         0x14107f4f3
0107f4ef xor        eax, eax
0107f4f1 jmp        0x14107f4ff
0107f4f3 mov        eax, 0x35
0107f4f8 jmp        0x14107f4ff
0107f4fa mov        eax, 0x34
0107f4ff mov        dword ptr [r15 + 0x470], eax
0107f506 mov        ecx, dword ptr [rbp + 0xd98]
0107f50c test       ecx, ecx
0107f50e je         0x14107f51c
0107f510 call       0x1410c6a00
0107f515 mov        dword ptr [r15 + 0x474], eax
0107f51c movzx      eax, byte ptr [rbp + 0xd96]
0107f523 mov        byte ptr [r15 + 0x47a], al
0107f52a mov        rax, qword ptr [rbp + 0xd9c]
0107f531 mov        qword ptr [r15 + 0x188], rax
0107f538 mov        rax, qword ptr [rbp + 0xda4]
0107f53f mov        qword ptr [r15 + 0x190], rax
0107f546 movzx      eax, byte ptr [rbp + 0xdad]
0107f54d mov        byte ptr [r15 + 0x183], al
0107f554 movzx      ecx, byte ptr [rbp + 0xdac]
0107f55b and        cl, 1
0107f55e shl        cl, 2
0107f561 movzx      eax, byte ptr [r15 + 0x180]
0107f569 and        al, 0xfb
0107f56b or         cl, al
0107f56d mov        byte ptr [r15 + 0x180], cl
0107f574 movzx      eax, byte ptr [rbp + 0xdb3]
0107f57b and        al, 1
0107f57d shl        al, 6
0107f580 and        cl, 0xbf
0107f583 or         al, cl
0107f585 mov        byte ptr [r15 + 0x180], al
0107f58c movzx      ecx, byte ptr [rbp + 0xd97]
0107f593 and        cl, 1
0107f596 add        cl, cl
0107f598 and        al, 0xfd
0107f59a or         cl, al
0107f59c mov        byte ptr [r15 + 0x180], cl
0107f5a3 movzx      eax, byte ptr [rbp + 0xdb0]
0107f5aa and        al, 1
0107f5ac and        cl, 0xfe
0107f5af or         al, cl
0107f5b1 mov        byte ptr [r15 + 0x180], al
0107f5b8 movzx      ecx, byte ptr [rbp + 0xe74]
0107f5bf and        cl, 1
0107f5c2 add        cl, cl
0107f5c4 movzx      eax, byte ptr [r15 + 0x181]
0107f5cc and        al, 0xfd
0107f5ce or         cl, al
0107f5d0 mov        byte ptr [r15 + 0x181], cl
0107f5d7 movzx      edx, byte ptr [rbp + 0xe75]
0107f5de and        dl, 1
0107f5e1 shl        dl, 2
0107f5e4 and        cl, 0xfb
0107f5e7 or         dl, cl
0107f5e9 mov        byte ptr [r15 + 0x181], dl
0107f5f0 movzx      eax, byte ptr [rbp + 0xe76]
0107f5f7 and        al, 1
0107f5f9 shl        al, 3
0107f5fc and        dl, 0xf7
0107f5ff or         al, dl
0107f601 mov        byte ptr [r15 + 0x181], al
0107f608 movzx      eax, byte ptr [rbp + 0xe77]
0107f60f mov        byte ptr [r15 + 0x478], al
0107f616 mov        rax, qword ptr [rbp + 0xe78]
0107f61d mov        qword ptr [r15 + 0x1c8], rax
0107f624 mov        rax, qword ptr [rbp + 0xe80]
0107f62b mov        qword ptr [r15 + 0x1b0], rax
0107f632 mov        rax, qword ptr [rbp + 0xe88]
0107f639 mov        qword ptr [r15 + 0x1b8], rax
0107f640 mov        rax, qword ptr [rbp + 0xe90]
0107f647 mov        qword ptr [r15 + 0x1c0], rax
0107f64e mov        eax, dword ptr [rbp + 0xe98]
0107f654 mov        dword ptr [r15 + 0x1a0], eax
0107f65b movzx      ecx, byte ptr [rbp + 0xea8]
0107f662 and        cl, 1
0107f665 shl        cl, 4
0107f668 movzx      eax, byte ptr [r15 + 0x1da]
0107f670 and        al, 0xef
0107f672 or         cl, al
0107f674 mov        byte ptr [r15 + 0x1da], cl
0107f67b and        cl, 0x7f
0107f67e movzx      eax, byte ptr [rbp + 0xea9]
0107f685 shl        al, 7
0107f688 or         cl, al
0107f68a mov        byte ptr [r15 + 0x1da], cl
0107f691 movzx      ecx, byte ptr [rbp + 0xeaa]
0107f698 and        cl, 1
0107f69b movzx      eax, byte ptr [r15 + 0x1db]
0107f6a3 and        al, 0xfe
0107f6a5 or         cl, al
0107f6a7 mov        byte ptr [r15 + 0x1db], cl
0107f6ae cmp        byte ptr [rbp + 0xdb2], 0
0107f6b5 je         0x14107f723
0107f6b7 mov        r8b, 1
0107f6ba mov        rdx, r15
0107f6bd lea        rcx, [rbp + 0xb0]
0107f6c4 call       0x140f00150
0107f6c9 mov        r14, qword ptr [rax]
0107f6cc mov        qword ptr [rbp + 0xa0], r14
0107f6d3 mov        r12, qword ptr [rax + 8]
0107f6d7 mov        qword ptr [rbp + 0xa8], r12
0107f6de xor        ecx, ecx
0107f6e0 mov        qword ptr [rax], rcx
0107f6e3 mov        qword ptr [rax + 8], rcx
0107f6e7 mov        rcx, qword ptr [rbp + 0xb8]
0107f6ee test       rcx, rcx
0107f6f1 je         0x14107f6f8
0107f6f3 call       0x140251ff0
0107f6f8 test       r14, r14
0107f6fb je         0x14107f711
0107f6fd mov        rax, qword ptr [r14]
0107f700 movzx      edx, byte ptr [rbp + 0xdb2]
0107f707 mov        rcx, r14
0107f70a call       qword ptr [rax + 0x98]
0107f710 nop        
0107f711 test       r12, r12
0107f714 je         0x14107f71e
0107f716 mov        rcx, r12
0107f719 call       0x140251ff0
0107f71e mov        r12, qword ptr [rsp + 0x60]
0107f723 movzx      eax, byte ptr [rbp + 0xdae]
0107f72a mov        byte ptr [r15 + 0x47b], al
0107f731 movzx      eax, byte ptr [rbp + 0xdb1]
0107f738 mov        byte ptr [r15 + 0x47c], al
0107f73f movzx      ecx, byte ptr [rbp + 0x2f1]
0107f746 and        cl, 1
0107f749 movzx      eax, byte ptr [r15 + 0x2c8]
0107f751 and        al, 0xfe
0107f753 or         cl, al
0107f755 mov        byte ptr [r15 + 0x2c8], cl
0107f75c mov        eax, dword ptr [rbp + 0xdb4]
0107f762 mov        dword ptr [r15 + 0x400], eax
0107f769 movzx      ecx, byte ptr [rbp + 0x2e2]
0107f770 and        cl, 1
0107f773 movzx      eax, byte ptr [r15 + 0x3f0]
0107f77b and        al, 0xfe
0107f77d or         cl, al
0107f77f mov        byte ptr [r15 + 0x3f0], cl
0107f786 movzx      eax, byte ptr [rbp + 0x2e3]
0107f78d mov        byte ptr [r15 + 0x360], al
0107f794 mov        rax, qword ptr [rbp + 0x2e4]
0107f79b mov        qword ptr [r15 + 0x358], rax
0107f7a2 mov        rax, qword ptr [rbp + 0x2f4]
0107f7a9 mov        qword ptr [r15 + 0x368], rax
0107f7b0 mov        word ptr [r15 + 0x10], si
0107f7b5 movzx      ecx, byte ptr [rbp + 0x328]
0107f7bc and        cl, 1
0107f7bf shl        cl, 3
0107f7c2 movzx      eax, byte ptr [r15 + 0x1d9]
0107f7ca and        al, 0xf7
0107f7cc or         cl, al
0107f7ce mov        byte ptr [r15 + 0x1d9], cl
0107f7d5 movzx      ecx, byte ptr [rbp + 0xd94]
0107f7dc and        cl, 1
0107f7df shl        cl, 5
0107f7e2 movzx      eax, byte ptr [r15 + 0x2c9]
0107f7ea and        al, 0xdf
0107f7ec or         cl, al
0107f7ee mov        byte ptr [r15 + 0x2c9], cl
0107f7f5 movzx      eax, byte ptr [rbp + 0xd95]
0107f7fc shl        al, 7
0107f7ff and        cl, 0x7f
0107f802 or         al, cl
0107f804 mov        byte ptr [r15 + 0x2c9], al
0107f80b cmp        si, 1
0107f80f sete       byte ptr [rsp + 0x44]
0107f814 cmp        qword ptr [r15 + 0x50], 0
0107f819 jne        0x14107f826
0107f81b xor        ecx, ecx
0107f81d call       0x140ba5880
0107f822 mov        qword ptr [r15 + 0x50], rax
0107f826 mov        rax, qword ptr [rbp + 0x348]
0107f82d mov        qword ptr [r15 + 0x218], rax
0107f834 mov        rax, qword ptr [rbp + 0x350]
0107f83b mov        qword ptr [r15 + 0x220], rax
0107f842 mov        eax, dword ptr [rbp + 0xd88]
0107f848 mov        dword ptr [r15 + 0x378], eax
0107f84f mov        eax, dword ptr [rbp + 0xd8c]
0107f855 mov        dword ptr [r15 + 0x37c], eax
0107f85c mov        eax, dword ptr [rbp + 0xd90]
0107f862 mov        dword ptr [r15 + 0x380], eax
0107f869 mov        rax, qword ptr [rbp + 0x364]
0107f870 mov        qword ptr [r15 + 0x398], rax
0107f877 mov        rax, qword ptr [rbp + 0x36c]
0107f87e mov        qword ptr [r15 + 0x3a0], rax
0107f885 mov        rax, qword ptr [rbp + 0x374]
0107f88c mov        qword ptr [r15 + 0x3a8], rax
0107f893 mov        rax, qword ptr [rbp + 0x37c]
0107f89a mov        qword ptr [r15 + 0x3b0], rax
0107f8a1 mov        rax, qword ptr [rbp + 0x384]
0107f8a8 mov        qword ptr [r15 + 0x3b8], rax
0107f8af mov        rax, qword ptr [rbp + 0x38c]
0107f8b6 mov        qword ptr [r15 + 0x3c0], rax
0107f8bd mov        rax, qword ptr [rbp + 0xd68]
0107f8c4 mov        qword ptr [r15 + 0x3c8], rax
0107f8cb mov        rax, qword ptr [rbp + 0xd70]
0107f8d2 mov        qword ptr [r15 + 0x3d0], rax
0107f8d9 mov        rax, qword ptr [rbp + 0xd78]
0107f8e0 mov        qword ptr [r15 + 0x3d8], rax
0107f8e7 mov        rax, qword ptr [rbp + 0xd80]
0107f8ee mov        qword ptr [r15 + 0x3e0], rax
0107f8f5 cmp        word ptr [r15 + 0x10], 0xf
0107f8fb jne        0x14107f90d
0107f8fd lea        rax, [r15 + 0x110]
0107f904 test       rax, rax
0107f907 je         0x14107f90d
0107f909 or         byte ptr [rax + 3], 0x20
0107f90d cmp        word ptr [rdi + 0xc], 0x3c
0107f912 jae        0x14107f99e
0107f918 mov        rcx, r15
0107f91b call       0x140fb4370
0107f920 mov        rsi, rax
0107f923 test       rax, rax
0107f926 je         0x14107f99e
0107f928 add        rax, 0x1e
0107f92c je         0x14107f96f
0107f92e mov        edx, dword ptr [rbp + 0x398]
0107f934 lea        ecx, [rdx - 1]
0107f937 cmp        ecx, 0x63
0107f93a ja         0x14107f94c
0107f93c mov        r9d, dword ptr [rbp + 0x39c]
0107f943 lea        r8, [rbp + 0x3a0]
0107f94a jmp        0x14107f965
0107f94c mov        edx, dword ptr [rbp + 0x148]
0107f952 cmp        edx, 0x20
0107f955 ja         0x14107f96f
0107f957 mov        r9d, dword ptr [rbp + 0x14c]
0107f95e lea        r8, [rbp + 0x150]
0107f965 mov        qword ptr [rsp + 0x20], rax
0107f96a call       0x14107e8c0
0107f96f xor        r8d, r8d
0107f972 mov        rdx, rsi
0107f975 mov        rcx, r15
0107f978 call       0x140fb3430
0107f97d sub        dword ptr [rsi + 0xc], 1
0107f981 jne        0x14107f99e
0107f983 xor        r14d, r14d
0107f986 cmp        dword ptr [rsi + 8], 0x63736574
0107f98d jne        0x14107f9a1
0107f98f mov        dword ptr [rsi + 8], r14d
0107f993 mov        rcx, rsi
0107f996 call       qword ptr [rip + 0x86c9cc]
0107f99c jmp        0x14107f9a1
0107f99e xor        r14d, r14d
0107f9a1 xorps      xmm0, xmm0
0107f9a4 xor        eax, eax
0107f9a6 movups     xmmword ptr [rbp + 0xee8], xmm0
0107f9ad movups     xmmword ptr [rbp + 0xef8], xmm0
0107f9b4 mov        word ptr [rbp + 0xf08], ax
0107f9bb cmp        dword ptr [r15], 0x706c7374
0107f9c2 jne        0x14107f9e9
0107f9c4 movdqu     xmmword ptr [rbp - 0x68], xmm0
0107f9c9 mov        qword ptr [rbp - 0x58], r14
0107f9cd lea        rax, [rbp + 0xee8]
0107f9d4 mov        qword ptr [rbp - 0x70], rax
0107f9d8 lea        r8, [rbp - 0x70]
0107f9dc mov        edx, 0x6770706d
0107f9e1 mov        rcx, r15
0107f9e4 call       0x140ef4580
0107f9e9 movzx      eax, word ptr [r15 + 0x10]
0107f9ee add        eax, -0xa
0107f9f1 cmp        eax, 0x1d
0107f9f4 ja         0x14107fa1a
0107f9f6 cdqe       
0107f9f8 lea        rdx, [rip - 0x107f9ff]
0107f9ff movzx      eax, byte ptr [rdx + rax + 0x1081748]
0107fa07 mov        ecx, dword ptr [rdx + rax*4 + 0x1081724]
0107fa0e add        rcx, rdx
0107fa11 jmp        rcx
0107fa13 and        byte ptr [rbp + 0xf08], 0xfe
0107fa1a cmp        dword ptr [r15], 0x706c7374
0107fa21 jne        0x14107fa5b
0107fa23 cmp        word ptr [r15 + 0x1fc], 0
0107fa2c jne        0x14107fa5b
0107fa2e movups     xmm0, xmmword ptr [rbp + 0xee8]
0107fa35 movups     xmmword ptr [r15 + 0x44c], xmm0
0107fa3d movups     xmm1, xmmword ptr [rbp + 0xef8]
0107fa44 movups     xmmword ptr [r15 + 0x45c], xmm1
0107fa4c movzx      eax, word ptr [rbp + 0xf08]
0107fa53 mov        word ptr [r15 + 0x46c], ax
0107fa5b mov        esi, r14d
0107fa5e mov        dword ptr [rsp + 0x30], r14d
0107fa63 cmp        dword ptr [rbp + 0x12c], 0
0107fa6a jbe        0x14107ff94
0107fa70 mov        r8d, 0x18
0107fa76 lea        rdx, [rbp + 0xed0]
0107fa7d mov        rcx, rdi
0107fa80 call       0x141077270
0107fa85 mov        ebx, eax
0107fa87 test       eax, eax
0107fa89 je         0x14107fb4e
0107fa8f cmp        eax, 0xffffff30
0107fa94 jne        0x1410816e7
0107fa9a mov        r8d, dword ptr [rbp + 0xed4]
0107faa1 mov        r9d, dword ptr [rbp + 0xed0]
0107faa8 jmp        0x14107fc8a
0107faad or         byte ptr [r15 + 0x2ca], 8
0107fab5 and        byte ptr [rbp + 0xf08], 0xe6
0107fabc or         byte ptr [rbp + 0xf09], 4
0107fac3 jmp        0x14107fa1a
0107fac8 cmp        qword ptr [rip + 0x104f8e0], 0
0107fad0 je         0x14107fae7
0107fad2 call       0x140f01020
0107fad7 test       rax, rax
0107fada je         0x14107fae7
0107fadc mov        eax, dword ptr [rax + 0x58]
0107fadf test       eax, eax
0107fae1 je         0x14107fae7
0107fae3 mov        dword ptr [r15 + 0x58], eax
0107fae7 or         byte ptr [rbp + 0xf08], 0x18
0107faee jmp        0x14107fa1a
0107faf3 mov        rax, qword ptr [rbp + 0x35c]
0107fafa mov        qword ptr [r15 + 0x4e0], rax
0107fb01 and        byte ptr [rbp + 0xf08], 0xe7
0107fb08 jmp        0x14107fa1a
0107fb0d mov        rax, qword ptr [rbp + 0x35c]
0107fb14 mov        qword ptr [r15 + 0x4e0], rax
0107fb1b jmp        0x14107fa1a
0107fb20 mov        word ptr [r15 + 0x10], r14w
0107fb25 jmp        0x14107fa1a
0107fb2a mov        rcx, r15
0107fb2d call       0x140ff7c00
0107fb32 mov        ebx, eax
0107fb34 test       eax, eax
0107fb36 jne        0x1410816e7
0107fb3c jmp        0x14107fa1a
0107fb41 mov        rcx, r15
0107fb44 call       0x141008fa0
0107fb49 jmp        0x14107fa5b
0107fb4e cmp        byte ptr [r13], 0
0107fb53 jne        0x14107fc5d
0107fb59 mov        ecx, dword ptr [rbp + 0xed0]
0107fb5f mov        r9d, ecx
0107fb62 and        r9d, 0xff0000
0107fb69 mov        eax, ecx
0107fb6b shr        eax, 0x10
0107fb6e or         r9d, eax
0107fb71 shr        r9d, 8
0107fb75 mov        eax, ecx
0107fb77 shl        eax, 0x10
0107fb7a and        ecx, 0xff00
0107fb80 or         eax, ecx
0107fb82 shl        eax, 8
0107fb85 or         r9d, eax
0107fb88 mov        dword ptr [rbp + 0xed0], r9d
0107fb8f mov        ecx, dword ptr [rbp + 0xed4]
0107fb95 mov        r8d, ecx
0107fb98 and        r8d, 0xff0000
0107fb9f mov        eax, ecx
0107fba1 shr        eax, 0x10
0107fba4 or         r8d, eax
0107fba7 shr        r8d, 8
0107fbab mov        eax, ecx
0107fbad shl        eax, 0x10
0107fbb0 and        ecx, 0xff00
0107fbb6 or         eax, ecx
0107fbb8 shl        eax, 8
0107fbbb or         r8d, eax
0107fbbe mov        dword ptr [rbp + 0xed4], r8d
0107fbc5 mov        ecx, dword ptr [rbp + 0xed8]
0107fbcb mov        esi, ecx
0107fbcd and        esi, 0xff0000
0107fbd3 mov        eax, ecx
0107fbd5 shr        eax, 0x10
0107fbd8 or         esi, eax
0107fbda shr        esi, 8
0107fbdd mov        eax, ecx
0107fbdf shl        eax, 0x10
0107fbe2 and        ecx, 0xff00
0107fbe8 or         eax, ecx
0107fbea shl        eax, 8
0107fbed or         esi, eax
0107fbef mov        dword ptr [rbp + 0xed8], esi
0107fbf5 mov        ecx, dword ptr [rbp + 0xedc]
0107fbfb mov        r10d, ecx
0107fbfe and        r10d, 0xff0000
0107fc05 mov        eax, ecx
0107fc07 shr        eax, 0x10
0107fc0a or         r10d, eax
0107fc0d shr        r10d, 8
0107fc11 mov        eax, ecx
0107fc13 shl        eax, 0x10
0107fc16 and        ecx, 0xff00
0107fc1c or         eax, ecx
0107fc1e shl        eax, 8
0107fc21 or         r10d, eax
0107fc24 mov        dword ptr [rbp + 0xedc], r10d
0107fc2b mov        ecx, dword ptr [rbp + 0xee0]
0107fc31 mov        edx, ecx
0107fc33 and        edx, 0xff0000
0107fc39 mov        eax, ecx
0107fc3b shr        eax, 0x10
0107fc3e or         edx, eax
0107fc40 shr        edx, 8
0107fc43 mov        eax, ecx
0107fc45 shl        eax, 0x10
0107fc48 and        ecx, 0xff00
0107fc4e or         eax, ecx
0107fc50 shl        eax, 8
0107fc53 or         edx, eax
0107fc55 mov        dword ptr [rbp + 0xee0], edx
0107fc5b jmp        0x14107fc78
0107fc5d mov        r10d, dword ptr [rbp + 0xedc]
0107fc64 mov        esi, dword ptr [rbp + 0xed8]
0107fc6a mov        r8d, dword ptr [rbp + 0xed4]
0107fc71 mov        r9d, dword ptr [rbp + 0xed0]
0107fc78 cmp        r9d, 0x686f686d
0107fc7f je         0x14107fcd2
0107fc81 mov        ebx, 0xffffff30
0107fc86 mov        esi, dword ptr [rsp + 0x30]
0107fc8a cmp        r9d, 0x6870746d
0107fc91 jne        0x1410816e7
0107fc97 neg        r8d
0107fc9a movsxd     rdx, r8d
0107fc9d add        rdx, qword ptr [rdi + 0x1e00170]
0107fca4 mov        qword ptr [rdi + 0x1e00170], rdx
0107fcab mov        rcx, qword ptr [rdi + 0x1e00178]
0107fcb2 cmp        rdx, rcx
0107fcb5 jb         0x14107fcc3
0107fcb7 add        rcx, qword ptr [rdi + 0x1e00180]
0107fcbe cmp        rdx, rcx
0107fcc1 jb         0x14107fcca
0107fcc3 mov        qword ptr [rdi + 0x1e00180], r14
0107fcca mov        ebx, r14d
0107fccd jmp        0x14107ff7d
0107fcd2 add        r10d, -0x64
0107fcd6 cmp        r10d, 9
0107fcda ja         0x14107fd4c
0107fcdc lea        rdx, [rip - 0x107fce3]
0107fce3 mov        ecx, dword ptr [rdx + r10*4 + 0x1081768]
0107fceb add        rcx, rdx
0107fcee jmp        rcx
0107fcf0 cmp        word ptr [r15 + 0x10], 0x23
0107fcf6 je         0x14107fd4c
0107fcf8 lea        rax, [r15 + 0x178]
0107fcff lea        r8, [r15 + 0x130]
0107fd06 mov        dword ptr [rsp + 0x28], r14d
0107fd0b mov        qword ptr [rsp + 0x20], rax
0107fd10 xor        r9d, r9d
0107fd13 mov        edx, 1
0107fd18 mov        rcx, rdi
0107fd1b call       0x1410773d0
0107fd20 mov        ebx, eax
0107fd22 test       eax, eax
0107fd24 jne        0x14107fd3a
0107fd26 test       byte ptr [r15 + 0x1d8], 8
0107fd2e je         0x14107fd3a
0107fd30 mov        byte ptr [rsp + 0x35], 1
0107fd35 jmp        0x14107ff79
0107fd3a mov        byte ptr [rsp + 0x35], 0
0107fd3f test       eax, eax
0107fd41 jne        0x1410816e7
0107fd47 jmp        0x14107ff79
0107fd4c sub        esi, r8d
0107fd4f movsxd     rdx, esi
0107fd52 add        rdx, qword ptr [rdi + 0x1e00170]
0107fd59 mov        qword ptr [rdi + 0x1e00170], rdx
0107fd60 mov        rcx, qword ptr [rdi + 0x1e00178]
0107fd67 cmp        rdx, rcx
0107fd6a jb         0x14107fd78
0107fd6c add        rcx, qword ptr [rdi + 0x1e00180]
0107fd73 cmp        rdx, rcx
0107fd76 jb         0x14107fd7f
0107fd78 mov        qword ptr [rdi + 0x1e00180], r14
0107fd7f mov        ebx, r14d
0107fd82 jmp        0x14107ff79
0107fd87 sub        esi, r8d
0107fd8a mov        r8d, esi
0107fd8d cmp        r8, 0xa00000
0107fd94 ja         0x1410816e2
0107fd9a lea        rdx, [rdi + 0xa00128]
0107fda1 mov        rcx, rdi
0107fda4 call       0x1410770a0
0107fda9 mov        ebx, eax
0107fdab test       eax, eax
0107fdad jne        0x1410816e7
0107fdb3 mov        edx, dword ptr [rbp + 0xed8]
0107fdb9 sub        edx, dword ptr [rbp + 0xed4]
0107fdbf lea        rax, [rbp - 0x18]
0107fdc3 mov        qword ptr [rsp + 0x20], rax
0107fdc8 lea        rcx, [rdi + 0xa00128]
0107fdcf call       0x140bf0dd0
0107fdd4 jmp        0x14107ff79
0107fdd9 sub        esi, r8d
0107fddc mov        r8d, esi
0107fddf cmp        r8, 0xa00000
0107fde6 ja         0x1410816e2
0107fdec lea        rsi, [rdi + 0xa00128]
0107fdf3 mov        rdx, rsi
0107fdf6 mov        rcx, rdi
0107fdf9 call       0x1410770a0
0107fdfe mov        ebx, eax
0107fe00 test       eax, eax
0107fe02 jne        0x1410816e7
0107fe08 xorps      xmm0, xmm0
0107fe0b movups     xmmword ptr [rbp + 0x30], xmm0
0107fe0f movups     xmmword ptr [rbp + 0x40], xmm0
0107fe13 movups     xmmword ptr [rbp + 0x50], xmm0
0107fe17 movups     xmmword ptr [rbp + 0x60], xmm0
0107fe1b movups     xmmword ptr [rbp + 0x70], xmm0
0107fe1f movups     xmmword ptr [rbp + 0x80], xmm0
0107fe26 movups     xmmword ptr [rbp + 0x90], xmm0
0107fe2d test       rsi, rsi
0107fe30 je         0x14107fe6f
0107fe32 movups     xmm0, xmmword ptr [rsi]
0107fe35 movaps     xmmword ptr [rbp + 0x30], xmm0
0107fe39 movups     xmm1, xmmword ptr [rsi + 0x10]
0107fe3d movaps     xmmword ptr [rbp + 0x40], xmm1
0107fe41 movups     xmm0, xmmword ptr [rsi + 0x20]
0107fe45 movaps     xmmword ptr [rbp + 0x50], xmm0
0107fe49 movups     xmm1, xmmword ptr [rsi + 0x30]
0107fe4d movaps     xmmword ptr [rbp + 0x60], xmm1
0107fe51 movups     xmm0, xmmword ptr [rsi + 0x40]
0107fe55 movaps     xmmword ptr [rbp + 0x70], xmm0
0107fe59 movups     xmm1, xmmword ptr [rsi + 0x50]
0107fe5d movaps     xmmword ptr [rbp + 0x80], xmm1
0107fe64 movups     xmm0, xmmword ptr [rsi + 0x60]
0107fe68 movaps     xmmword ptr [rbp + 0x90], xmm0
0107fe6f mov        byte ptr [rsp + 0x34], 1
0107fe74 jmp        0x14107ff79
0107fe79 sub        esi, r8d
0107fe7c mov        r8d, esi
0107fe7f cmp        r8, 0xa00000
0107fe86 ja         0x1410816e2
0107fe8c lea        rsi, [rdi + 0xa00128]
0107fe93 mov        rdx, rsi
0107fe96 mov        rcx, rdi
0107fe99 call       0x1410770a0
0107fe9e mov        ebx, eax
0107fea0 test       eax, eax
0107fea2 jne        0x1410816e7
0107fea8 mov        r14d, dword ptr [rbp + 0xed8]
0107feaf sub        r14d, dword ptr [rbp + 0xed4]
0107feb6 shr        r14d, 3
0107feba test       r14d, r14d
0107febd je         0x14107ff76
0107fec3 mov        edx, r14d
0107fec6 lea        rcx, [rsp + 0x78]
0107fecb call       0x1402dc5a0
0107fed0 mov        ebx, eax
0107fed2 test       eax, eax
0107fed4 jne        0x1410816e7
0107feda cmp        byte ptr [r13], al
0107fede jne        0x14107ff05
0107fee0 test       r14d, r14d
0107fee3 je         0x14107ff76
0107fee9 mov        rcx, rsi
0107feec mov        edx, r14d
0107feef nop        
0107fef0 mov        rax, qword ptr [rcx]
0107fef3 bswap      rax
0107fef6 mov        qword ptr [rcx], rax
0107fef9 lea        rcx, [rcx + 8]
0107fefd sub        rdx, 1
0107ff01 jne        0x14107fef0
0107ff03 jmp        0x14107ff0a
0107ff05 test       r14d, r14d
0107ff08 je         0x14107ff76
0107ff0a mov        r15, qword ptr [rsp + 0x78]
0107ff0f nop        
0107ff10 mov        rax, qword ptr [rsi]
0107ff13 mov        qword ptr [rsp + 0x38], rax
0107ff18 test       r12, r12
0107ff1b je         0x14107ff67
0107ff1d cmp        dword ptr [r12 + 0x80], 0x74646174
0107ff29 jne        0x14107ff67
0107ff2b test       rax, rax
0107ff2e je         0x14107ff67
0107ff30 mov        rcx, r12
0107ff33 call       0x140ec1e30
0107ff38 test       eax, eax
0107ff3a jne        0x14107ff67
0107ff3c lea        rdx, [rsp + 0x38]
0107ff41 mov        rcx, qword ptr [r12 + 0x18e0]
0107ff49 call       0x14042de70
0107ff4e test       rax, rax
0107ff51 je         0x14107ff67
0107ff53 mov        rdx, qword ptr [rax + 8]
0107ff57 test       rdx, rdx
0107ff5a je         0x14107ff67
0107ff5c xor        r8d, r8d
0107ff5f mov        rcx, r15
0107ff62 call       0x1402dd4c0
0107ff67 add        rsi, 8
0107ff6b sub        r14, 1
0107ff6f jne        0x14107ff10
0107ff71 mov        r15, qword ptr [rsp + 0x48]
0107ff76 xor        r14d, r14d
0107ff79 mov        esi, dword ptr [rsp + 0x30]
0107ff7d inc        esi
0107ff7f mov        dword ptr [rsp + 0x30], esi
0107ff83 cmp        esi, dword ptr [rbp + 0x12c]
0107ff89 mov        r12, qword ptr [rsp + 0x60]
0107ff8e jb         0x14107fa70
0107ff94 mov        rcx, r15
0107ff97 call       0x140816cd0
0107ff9c test       al, al
0107ff9e je         0x14107ffa8
0107ffa0 mov        rcx, r15
0107ffa3 call       0x140816de0
0107ffa8 mov        rsi, qword ptr [r15 + 0x70]
0107ffac mov        qword ptr [rsp + 0x48], rsi
0107ffb1 xor        r11d, r11d
0107ffb4 mov        dword ptr [rsp + 0x6c], r11d
0107ffb9 cmp        dword ptr [rbp + 0x130], r11d
0107ffc0 jbe        0x141080e73
0107ffc6 nop        word ptr [rax + rax]
0107ffd0 mov        qword ptr [rsp + 0x58], r13
0107ffd5 mov        r8d, 8
0107ffdb lea        rdx, [rbp + 0xc0]
0107ffe2 mov        rcx, rdi
0107ffe5 call       0x1410770a0
0107ffea mov        ebx, eax
0107ffec test       eax, eax
0107ffee jne        0x1410816e7
0107fff4 mov        r9d, dword ptr [rbp + 0xc4]
0107fffb mov        dword ptr [rsp + 0x30], r9d
01080000 mov        r12d, r9d
01080003 cmp        byte ptr [r13], al
01080007 jne        0x14108000c
01080009 bswap      r12d
0108000c lea        rcx, [rbp + 0xc8]
01080013 mov        r13d, 0x54
01080019 cmp        r12d, r13d
0108001c cmovb      r13d, r12d
01080020 cmp        r13d, 8
01080024 jbe        0x14108006f
01080026 lea        eax, [r13 - 8]
0108002a mov        qword ptr [rsp + 0x38], rax
0108002f cmp        rax, 0xa00000
01080035 ja         0x1410816e2
0108003b mov        r8d, eax
0108003e lea        rdx, [rbp + 0xc8]
01080045 mov        rcx, rdi
01080048 call       0x1410770a0
0108004d mov        ebx, eax
0108004f test       eax, eax
01080051 jne        0x1410816e7
01080057 lea        rcx, [rbp + 0xc8]
0108005e add        rcx, qword ptr [rsp + 0x38]
01080063 mov        r9d, dword ptr [rbp + 0xc4]
0108006a mov        dword ptr [rsp + 0x30], r9d
0108006f cmp        r13d, 0x54
01080073 jae        0x141080096
01080075 test       rcx, rcx
01080078 je         0x141080096
0108007a mov        r8d, 0x54
01080080 sub        r8d, r13d
01080083 xor        edx, edx
01080085 call       0x14179cca0
0108008a mov        r9d, dword ptr [rbp + 0xc4]
01080091 mov        dword ptr [rsp + 0x30], r9d
01080096 cmp        r12d, r13d
01080099 jbe        0x1410800b8
0108009b sub        r12d, r13d
0108009e mov        edx, r12d
010800a1 mov        rcx, rdi
010800a4 call       0x14106a520
010800a9 mov        ebx, eax
010800ab test       eax, eax
010800ad jne        0x1410816e7
010800b3 mov        r9d, dword ptr [rsp + 0x30]
010800b8 mov        rax, qword ptr [rsp + 0x58]
010800bd mov        r13, rax
010800c0 cmp        byte ptr [rax], 0
010800c3 jne        0x14108084a
010800c9 mov        ecx, dword ptr [rbp + 0xc0]
010800cf mov        r11d, ecx
010800d2 and        r11d, 0xff0000
010800d9 mov        eax, ecx
010800db shr        eax, 0x10
010800de or         r11d, eax
010800e1 shr        r11d, 8
010800e5 mov        eax, ecx
010800e7 shl        eax, 0x10
010800ea and        ecx, 0xff00
010800f0 or         eax, ecx
010800f2 shl        eax, 8
010800f5 or         r11d, eax
010800f8 mov        dword ptr [rbp + 0xc0], r11d
010800ff mov        ecx, r9d
01080102 and        ecx, 0xff0000
01080108 mov        eax, r9d
0108010b shr        eax, 0x10
0108010e or         ecx, eax
01080110 shr        ecx, 8
01080113 mov        eax, r9d
01080116 shl        eax, 0x10
01080119 and        r9d, 0xff00
01080120 or         eax, r9d
01080123 shl        eax, 8
01080126 mov        r9d, ecx
01080129 or         r9d, eax
0108012c mov        dword ptr [rsp + 0x30], r9d
01080131 mov        dword ptr [rbp + 0xc4], r9d
01080138 mov        ecx, dword ptr [rbp + 0xc8]
0108013e mov        edx, ecx
01080140 and        edx, 0xff0000
01080146 mov        eax, ecx
01080148 shr        eax, 0x10
0108014b or         edx, eax
0108014d shr        edx, 8
01080150 mov        eax, ecx
01080152 shl        eax, 0x10
01080155 and        ecx, 0xff00
0108015b or         eax, ecx
0108015d shl        eax, 8
01080160 or         edx, eax
01080162 mov        dword ptr [rbp + 0xc8], edx
01080168 mov        ecx, dword ptr [rbp + 0xcc]
0108016e mov        edx, ecx
01080170 and        edx, 0xff0000
01080176 mov        eax, ecx
01080178 shr        eax, 0x10
0108017b or         edx, eax
0108017d shr        edx, 8
01080180 mov        eax, ecx
01080182 shl        eax, 0x10
01080185 and        ecx, 0xff00
0108018b or         eax, ecx
0108018d shl        eax, 8
01080190 or         edx, eax
01080192 mov        dword ptr [rbp + 0xcc], edx
01080198 mov        ecx, dword ptr [rbp + 0xd0]
0108019e mov        edx, ecx
010801a0 and        edx, 0xff0000
010801a6 mov        eax, ecx
010801a8 shr        eax, 0x10
010801ab or         edx, eax
010801ad shr        edx, 8
010801b0 mov        eax, ecx
010801b2 shl        eax, 0x10
010801b5 and        ecx, 0xff00
010801bb or         eax, ecx
010801bd shl        eax, 8
010801c0 or         edx, eax
010801c2 mov        dword ptr [rbp + 0xd0], edx
010801c8 mov        ecx, dword ptr [rbp + 0xd4]
010801ce mov        r10d, ecx
010801d1 and        r10d, 0xff0000
010801d8 mov        eax, ecx
010801da shr        eax, 0x10
010801dd or         r10d, eax
010801e0 shr        r10d, 8
010801e4 mov        eax, ecx
010801e6 shl        eax, 0x10
010801e9 and        ecx, 0xff00
010801ef or         eax, ecx
010801f1 shl        eax, 8
010801f4 or         r10d, eax
010801f7 mov        dword ptr [rbp + 0xd4], r10d
010801fe mov        ecx, dword ptr [rbp + 0xd8]
01080204 mov        edx, ecx
01080206 and        edx, 0xff0000
0108020c mov        eax, ecx
0108020e shr        eax, 0x10
01080211 or         edx, eax
01080213 shr        edx, 8
01080216 mov        eax, ecx
01080218 shl        eax, 0x10
0108021b and        ecx, 0xff00
01080221 or         eax, ecx
01080223 shl        eax, 8
01080226 or         edx, eax
01080228 mov        dword ptr [rbp + 0xd8], edx
0108022e mov        ecx, dword ptr [rbp + 0xe0]
01080234 mov        edx, ecx
01080236 and        edx, 0xff0000
0108023c mov        eax, ecx
0108023e shr        eax, 0x10
01080241 or         edx, eax
01080243 shr        edx, 8
01080246 mov        eax, ecx
01080248 shl        eax, 0x10
0108024b and        ecx, 0xff00
01080251 or         eax, ecx
01080253 shl        eax, 8
01080256 or         edx, eax
01080258 mov        dword ptr [rbp + 0xe0], edx
0108025e mov        rdx, qword ptr [rbp + 0xfc]
01080265 mov        r8, rdx
01080268 movabs     rbx, 0xff000000000000
01080272 and        r8, rbx
01080275 mov        rax, rdx
01080278 shr        rax, 0x10
0108027c or         r8, rax
0108027f shr        r8, 0x10
01080283 mov        rax, rdx
01080286 movabs     r12, 0xff0000000000
01080290 and        rax, r12
01080293 or         r8, rax
01080296 shr        r8, 0x10
0108029a mov        rax, rdx
0108029d movabs     rcx, 0xff00000000
010802a7 and        rax, rcx
010802aa or         r8, rax
010802ad shr        r8, 8
010802b1 mov        rcx, rdx
010802b4 shl        rcx, 0x10
010802b8 mov        eax, edx
010802ba and        eax, 0xff00
010802bf or         rcx, rax
010802c2 shl        rcx, 0x10
010802c6 mov        eax, edx
010802c8 and        eax, 0xff0000
010802cd or         rcx, rax
010802d0 shl        rcx, 0x10
010802d4 mov        eax, edx
010802d6 mov        edx, 0xff000000
010802db and        rax, rdx
010802de or         rcx, rax
010802e1 shl        rcx, 8
010802e5 or         r8, rcx
010802e8 mov        qword ptr [rbp + 0xfc], r8
010802ef mov        rdx, qword ptr [rbp + 0x104]
010802f6 mov        r8, rdx
010802f9 and        r8, rbx
010802fc mov        rax, rdx
010802ff shr        rax, 0x10
01080303 or         r8, rax
01080306 shr        r8, 0x10
0108030a mov        rax, rdx
0108030d and        rax, r12
01080310 or         r8, rax
01080313 shr        r8, 0x10
01080317 mov        rax, rdx
0108031a movabs     rcx, 0xff00000000
01080324 and        rax, rcx
01080327 or         r8, rax
0108032a shr        r8, 8
0108032e mov        rcx, rdx
01080331 shl        rcx, 0x10
01080335 mov        eax, edx
01080337 and        eax, 0xff00
0108033c or         rcx, rax
0108033f shl        rcx, 0x10
01080343 mov        eax, edx
01080345 and        eax, 0xff0000
0108034a or         rcx, rax
0108034d shl        rcx, 0x10
01080351 mov        eax, edx
01080353 mov        edx, 0xff000000
01080358 and        rax, rdx
0108035b or         rcx, rax
0108035e shl        rcx, 8
01080362 or         r8, rcx
01080365 mov        qword ptr [rbp + 0x104], r8
0108036c jmp        0x14108085f
01080371 sub        esi, r8d
01080374 mov        r8d, esi
01080377 cmp        r8, 0xa00000
0108037e ja         0x1410816e2
01080384 lea        rsi, [rdi + 0xa00128]
0108038b mov        rdx, rsi
0108038e mov        rcx, rdi
01080391 call       0x1410770a0
01080396 mov        ebx, eax
01080398 test       eax, eax
0108039a jne        0x1410816e7
010803a0 mov        eax, dword ptr [rbp + 0xed8]
010803a6 sub        eax, dword ptr [rbp + 0xed4]
010803ac cmp        eax, 0x4c4
010803b1 jne        0x14107ff79
010803b7 test       rsi, rsi
010803ba je         0x141080446
010803c0 lea        rcx, [rbp + 0xf70]
010803c7 mov        eax, 9
010803cc nop        dword ptr [rax]
010803d0 movups     xmm0, xmmword ptr [rsi]
010803d3 movups     xmmword ptr [rcx], xmm0
010803d6 movups     xmm1, xmmword ptr [rsi + 0x10]
010803da movups     xmmword ptr [rcx + 0x10], xmm1
010803de movups     xmm0, xmmword ptr [rsi + 0x20]
010803e2 movups     xmmword ptr [rcx + 0x20], xmm0
010803e6 movups     xmm1, xmmword ptr [rsi + 0x30]
010803ea movups     xmmword ptr [rcx + 0x30], xmm1
010803ee movups     xmm0, xmmword ptr [rsi + 0x40]
010803f2 movups     xmmword ptr [rcx + 0x40], xmm0
010803f6 movups     xmm1, xmmword ptr [rsi + 0x50]
010803fa movups     xmmword ptr [rcx + 0x50], xmm1
010803fe movups     xmm0, xmmword ptr [rsi + 0x60]
01080402 movups     xmmword ptr [rcx + 0x60], xmm0
01080406 lea        rcx, [rcx + 0x80]
0108040d movups     xmm1, xmmword ptr [rsi + 0x70]
01080411 movups     xmmword ptr [rcx - 0x10], xmm1
01080415 lea        rsi, [rsi + 0x80]
0108041c sub        rax, 1
01080420 jne        0x1410803d0
01080422 movups     xmm0, xmmword ptr [rsi]
01080425 movups     xmmword ptr [rcx], xmm0
01080428 movups     xmm1, xmmword ptr [rsi + 0x10]
0108042c movups     xmmword ptr [rcx + 0x10], xmm1
01080430 movups     xmm0, xmmword ptr [rsi + 0x20]
01080434 movups     xmmword ptr [rcx + 0x20], xmm0
01080438 movups     xmm1, xmmword ptr [rsi + 0x30]
0108043c movups     xmmword ptr [rcx + 0x30], xmm1
01080440 mov        eax, dword ptr [rsi + 0x40]
01080443 mov        dword ptr [rcx + 0x40], eax
01080446 lea        rdx, [rbp + 0xf70]
0108044d mov        rcx, rdi
01080450 call       0x141069e20
01080455 movzx      r9d, byte ptr [rbp + 0xf74]
0108045d mov        ecx, r9d
01080460 test       r9b, r9b
01080463 je         0x141080483
01080465 sub        ecx, 3
01080468 je         0x141080483
0108046a sub        ecx, 1
0108046d je         0x141080483
0108046f cmp        ecx, 1
01080472 jne        0x14107ff79
01080478 cmp        word ptr [rdi + 0xc], 0x2a
0108047d jb         0x14107ff79
01080483 mov        qword ptr [rsp + 0x38], r14
01080488 mov        byte ptr [rsp + 0x50], r9b
0108048d movzx      eax, byte ptr [rbp + 0xf75]
01080494 mov        byte ptr [rsp + 0x51], al
01080498 lea        r8, [rsp + 0x38]
0108049d mov        edx, dword ptr [rbp + 0xf70]
010804a3 lea        rcx, [rsp + 0x50]
010804a8 call       0x140fb36f0
010804ad test       eax, eax
010804af jne        0x14107ff79
010804b5 mov        rsi, qword ptr [rsp + 0x38]
010804ba movzx      eax, byte ptr [rbp + 0xf76]
010804c1 mov        byte ptr [rsi + 0x1c], al
010804c4 mov        eax, dword ptr [rbp + 0xf78]
010804ca mov        dword ptr [rsi + 0x18], eax
010804cd movzx      eax, byte ptr [rbp + 0xf77]
010804d4 mov        byte ptr [rsi + 0x1d], al
010804d7 lea        rax, [rsi + 0x1e]
010804db mov        qword ptr [rsp + 0x20], rax
010804e0 mov        r9d, dword ptr [rbp + 0xf80]
010804e7 lea        r8, [rbp + 0xf84]
010804ee mov        edx, dword ptr [rbp + 0xf7c]
010804f4 call       0x14107e8c0
010804f9 xor        r8d, r8d
010804fc mov        rdx, rsi
010804ff mov        rcx, r15
01080502 call       0x140fb3430
01080507 movzx      eax, byte ptr [rbp + 0xf76]
0108050e mov        byte ptr [rsi + 0x1c], al
01080511 lea        r12, [r15 + 0x418]
01080518 lea        rdx, [rsi + 0x14]
0108051c mov        rcx, r12
0108051f call       0x140fb3790
01080524 mov        r14, rax
01080527 test       rax, rax
0108052a jne        0x141080580
0108052c test       r12, r12
0108052f je         0x1410805d1
01080535 cmp        dword ptr [r12], 0x63737468
0108053d jne        0x1410805d4
01080543 inc        dword ptr [rsi + 0xc]
01080546 mov        rcx, rax
01080549 mov        rax, qword ptr [r12 + 8]
0108054e test       rax, rax
01080551 je         0x14108055e
01080553 mov        rcx, rax
01080556 mov        rax, qword ptr [rax]
01080559 test       rax, rax
0108055c jne        0x141080553
0108055e mov        qword ptr [rsi], r14
01080561 test       rcx, rcx
01080564 jne        0x141080574
01080566 mov        qword ptr [r12 + 8], rsi
0108056b inc        dword ptr [r15 + 0x41c]
01080572 jmp        0x1410805d4
01080574 mov        qword ptr [rcx], rsi
01080577 inc        dword ptr [r15 + 0x41c]
0108057e jmp        0x1410805d4
01080580 lea        rcx, [rax + 0x1e]
01080584 lea        rdx, [rsi + 0x1e]
01080588 mov        r8d, 0xaf4
0108058e call       0x14179cc9a
01080593 mov        eax, dword ptr [rsi + 0x18]
01080596 mov        dword ptr [r14 + 0x18], eax
0108059a movzx      eax, byte ptr [rsi + 0x1c]
0108059e mov        byte ptr [r14 + 0x1c], al
010805a2 mov        eax, dword ptr [rsi + 0x18]
010805a5 mov        dword ptr [r14 + 0x18], eax
010805a9 movzx      eax, byte ptr [rsi + 0x1d]
010805ad mov        byte ptr [r14 + 0x1d], al
010805b1 sub        dword ptr [r14 + 0xc], 1
010805b6 jne        0x1410805d1
010805b8 cmp        dword ptr [r14 + 8], 0x63736574
010805c0 jne        0x1410805d1
010805c2 xor        eax, eax
010805c4 mov        dword ptr [r14 + 8], eax
010805c8 mov        rcx, r14
010805cb call       qword ptr [rip + 0x86bd97]
010805d1 xor        r14d, r14d
010805d4 sub        dword ptr [rsi + 0xc], 1
010805d8 jne        0x14107ff79
010805de cmp        dword ptr [rsi + 8], 0x63736574
010805e5 jne        0x14107ff79
010805eb mov        dword ptr [rsi + 8], r14d
010805ef mov        rcx, rsi
010805f2 call       qword ptr [rip + 0x86bd70]
010805f8 jmp        0x14107ff79
010805fd sub        esi, r8d
01080600 mov        r8d, esi
01080603 cmp        r8, 0xa00000
0108060a ja         0x1410816e2
01080610 lea        rsi, [rdi + 0xa00128]
01080617 mov        rdx, rsi
0108061a mov        rcx, rdi
0108061d call       0x1410770a0
01080622 mov        ebx, eax
01080624 test       eax, eax
01080626 jne        0x1410816e7
0108062c mov        eax, dword ptr [rbp + 0xed8]
01080632 sub        eax, dword ptr [rbp + 0xed4]
01080638 cmp        eax, 0xc4
0108063d jne        0x14107ff79
01080643 test       rsi, rsi
01080646 je         0x1410806cc
0108064c lea        rcx, [rbp + 0xf70]
01080653 movups     xmm0, xmmword ptr [rsi]
01080656 movups     xmmword ptr [rcx], xmm0
01080659 movups     xmm1, xmmword ptr [rsi + 0x10]
0108065d movups     xmmword ptr [rcx + 0x10], xmm1
01080661 movups     xmm0, xmmword ptr [rsi + 0x20]
01080665 movups     xmmword ptr [rcx + 0x20], xmm0
01080669 movups     xmm1, xmmword ptr [rsi + 0x30]
0108066d movups     xmmword ptr [rcx + 0x30], xmm1
01080671 movups     xmm0, xmmword ptr [rsi + 0x40]
01080675 movups     xmmword ptr [rcx + 0x40], xmm0
01080679 movups     xmm1, xmmword ptr [rsi + 0x50]
0108067d movups     xmmword ptr [rcx + 0x50], xmm1
01080681 movups     xmm0, xmmword ptr [rsi + 0x60]
01080685 movups     xmmword ptr [rcx + 0x60], xmm0
01080689 lea        rcx, [rcx + 0x80]
01080690 movups     xmm1, xmmword ptr [rsi + 0x70]
01080694 movups     xmmword ptr [rcx - 0x10], xmm1
01080698 movups     xmm0, xmmword ptr [rsi + 0x80]
0108069f movups     xmmword ptr [rcx], xmm0
010806a2 movups     xmm1, xmmword ptr [rsi + 0x90]
010806a9 movups     xmmword ptr [rcx + 0x10], xmm1
010806ad movups     xmm0, xmmword ptr [rsi + 0xa0]
010806b4 movups     xmmword ptr [rcx + 0x20], xmm0
010806b8 movups     xmm1, xmmword ptr [rsi + 0xb0]
010806bf movups     xmmword ptr [rcx + 0x30], xmm1
010806c3 mov        eax, dword ptr [rsi + 0xc0]
010806c9 mov        dword ptr [rcx + 0x40], eax
010806cc lea        rdx, [rbp + 0xf70]
010806d3 mov        rcx, rdi
010806d6 call       0x141069f90
010806db mov        rax, qword ptr [rbp + 0xf70]
010806e2 mov        dword ptr [r15 + 0x430], eax
010806e9 mov        edx, r14d
010806ec cmp        eax, 6
010806ef jbe        0x1410806fe
010806f1 mov        dword ptr [r15 + 0x430], 6
010806fc jmp        0x141080706
010806fe test       eax, eax
01080700 je         0x14107ff79
01080706 mov        ecx, edx
01080708 mov        eax, dword ptr [rbp + rcx*4 + 0xf74]
0108070f mov        dword ptr [r15 + rcx*4 + 0x434], eax
01080717 inc        edx
01080719 cmp        edx, dword ptr [r15 + 0x430]
01080720 jb         0x141080706
01080722 jmp        0x14107ff79
01080727 sub        esi, r8d
0108072a mov        ebx, esi
0108072c cmp        esi, 0xa00000
01080732 jbe        0x141080752
01080734 mov        edx, 0x10
01080739 mov        ecx, esi
0108073b call       qword ptr [rip + 0x86bc2f]
01080741 mov        r14, rax
01080744 test       rax, rax
01080747 je         0x1410816cf
0108074d mov        r12, rax
01080750 jmp        0x141080759
01080752 lea        r12, [rdi + 0xa00128]
01080759 mov        r8, rbx
0108075c mov        rdx, r12
0108075f mov        rcx, rdi
01080762 call       0x1410770a0
01080767 mov        ebx, eax
01080769 test       eax, eax
0108076b jne        0x1410816e7
01080771 cmp        dword ptr [r15], 0x706c7374
01080778 jne        0x1410807bb
0108077a mov        rax, qword ptr [r15 + 8]
0108077e test       byte ptr [rax + 0x110], 1
01080785 jne        0x141080793
01080787 cmp        dword ptr [rax + 0x84], 0x74736574
01080791 jne        0x1410807bb
01080793 movzx      eax, word ptr [r15 + 0x10]
01080798 cmp        ax, 0xa
0108079c je         0x1410807a4
0108079e cmp        ax, 0x1f
010807a2 jne        0x1410807bb
010807a4 mov        rcx, qword ptr [r15 + 0x1e8]
010807ab test       rcx, rcx
010807ae je         0x1410807bb
010807b0 mov        r9d, esi
010807b3 mov        r8, r12
010807b6 call       0x140fe26d0
010807bb test       r14, r14
010807be je         0x14107ff76
010807c4 mov        rcx, r14
010807c7 call       qword ptr [rip + 0x86bb9b]
010807cd jmp        0x14107ff76
010807d2 lea        rax, [r15 + 0x17c]
010807d9 lea        r8, [r15 + 0x130]
010807e0 mov        dword ptr [rsp + 0x28], r14d
010807e5 mov        qword ptr [rsp + 0x20], rax
010807ea xor        r9d, r9d
010807ed mov        edx, 1
010807f2 mov        rcx, rdi
010807f5 call       0x1410773d0
010807fa mov        ebx, eax
010807fc test       eax, eax
010807fe jne        0x1410816e7
01080804 jmp        0x14107ff79
01080809 sub        esi, r8d
0108080c mov        dl, 1
0108080e mov        rcx, r15
01080811 call       0x140f00720
01080816 mov        rcx, rdi
01080819 test       rax, rax
0108081c je         0x14108082b
0108081e mov        r8d, esi
01080821 mov        rdx, rax
01080824 call       0x141077ff0
01080829 jmp        0x141080832
0108082b mov        edx, esi
0108082d call       0x14106a520
01080832 mov        ebx, eax
01080834 movzx      eax, byte ptr [rsp + 0x34]
01080839 mov        byte ptr [rsp + 0x34], al
0108083d test       ebx, ebx
0108083f jne        0x1410816e7
01080845 jmp        0x14107ff79
0108084a mov        r8, qword ptr [rbp + 0x104]
01080851 mov        r10d, dword ptr [rbp + 0xd4]
01080858 mov        r11d, dword ptr [rbp + 0xc0]
0108085f mov        qword ptr [rsp + 0x38], r8
01080864 cmp        r11d, 0x6870746d
0108086b jne        0x1410816e2
01080871 xor        r11d, r11d
01080874 mov        ebx, r11d
01080877 cmp        r10d, r14d
0108087a je         0x1410808a5
0108087c mov        rsi, qword ptr [r15 + 0x70]
01080880 test       r10d, r10d
01080883 je         0x141080893
01080885 mov        edx, r10d
01080888 mov        rcx, rsi
0108088b call       0x14107ea00
01080890 mov        rsi, rax
01080893 test       rsi, rsi
01080896 je         0x1410808a5
01080898 mov        r14d, r10d
0108089b mov        qword ptr [rsp + 0x48], rsi
010808a0 xor        r12b, r12b
010808a3 jmp        0x1410808b1
010808a5 xor        r12b, r12b
010808a8 test       rsi, rsi
010808ab je         0x141080e18
010808b1 mov        qword ptr [rbp - 0x10], rsi
010808b5 mov        rcx, qword ptr [rsi + 0x58]
010808b9 mov        qword ptr [rbp - 8], rcx
010808bd cmp        byte ptr [rbp + 0xdc], bl
010808c3 je         0x1410809c6
010808c9 mov        dword ptr [rsp + 0x68], 0x780001
010808d1 cmp        qword ptr [rsi], r15
010808d4 jne        0x1410816db
010808da lea        rax, [rcx - 1]
010808de cmp        rax, -3
010808e2 ja         0x1410808ee
010808e4 cmp        qword ptr [rcx + 8], rsi
010808e8 jne        0x1410816db
010808ee mov        rax, qword ptr [r15 + 0x70]
010808f2 test       rax, rax
010808f5 je         0x141080904
010808f7 cmp        dword ptr [rax + 0x64], 0x7fffffff
010808fe jae        0x1410816db
01080904 mov        dl, 1
01080906 mov        rcx, r15
01080909 call       0x140fbc600
0108090e mov        rsi, rax
01080911 test       rax, rax
01080914 je         0x1410816db
0108091a or         byte ptr [rax + 0x4b], 0xc0
0108091e lea        r8, [rax + 0x68]
01080922 mov        rcx, qword ptr [rax]
01080925 add        rcx, 0x130
0108092c lea        rdx, [rsp + 0x68]
01080931 call       0x140bfed40
01080936 mov        rcx, rsi
01080939 test       eax, eax
0108093b jne        0x1410816d6
01080941 call       0x140ef0700
01080946 mov        r8b, 1
01080949 lea        rdx, [rbp - 0x10]
0108094d mov        rcx, rsi
01080950 call       0x140fbcb00
01080955 mov        rcx, rsi
01080958 call       0x140eef7f0
0108095d movzx      ecx, byte ptr [rbp + 0xdd]
01080964 shl        cl, 7
01080967 movzx      eax, byte ptr [rsi + 0x4b]
0108096b and        al, 0x7f
0108096d or         cl, al
0108096f mov        byte ptr [rsi + 0x4b], cl
01080972 movzx      eax, byte ptr [rbp + 0xea]
01080979 mov        byte ptr [rsi + 0x70], al
0108097c or         byte ptr [r15 + 0x1d8], 2
01080984 cmp        dword ptr [rbp + 0xd8], ebx
0108098a je         0x141080a65
01080990 lea        rcx, [rdi + 0x1e00278]
01080997 lea        rdx, [rbp + 0xd8]
0108099e call       0x140693780
010809a3 test       rax, rax
010809a6 je         0x141080a65
010809ac mov        rax, qword ptr [rax + 8]
010809b0 test       rax, rax
010809b3 je         0x141080a65
010809b9 mov        qword ptr [rsi + 0x30], rax
010809bd mov        qword ptr [rax + 0x60], rsi
010809c1 jmp        0x141080a65
010809c6 lea        rcx, [rdi + 0x1e00278]
010809cd lea        rdx, [rbp + 0xd8]
010809d4 call       0x140693780
010809d9 test       rax, rax
010809dc je         0x141080e08
010809e2 mov        rax, qword ptr [rax + 8]
010809e6 mov        qword ptr [rsp + 0x58], rax
010809eb test       rax, rax
010809ee je         0x141080e08
010809f4 cmp        qword ptr [rax + 0x10], rbx
010809f8 je         0x141080e08
010809fe xorps      xmm0, xmm0
01080a01 movdqu     xmmword ptr [rbp + 0x20], xmm0
01080a06 lea        rcx, [rbp + 0x20]
01080a0a mov        qword ptr [rsp + 0x20], rcx
01080a0f mov        r9, qword ptr [rsp + 0x38]
01080a14 lea        r8, [rbp - 0x10]
01080a18 mov        rdx, rax
01080a1b mov        rcx, r15
01080a1e call       0x140ef4180
01080a23 mov        rsi, rax
01080a26 test       rax, rax
01080a29 je         0x1410816db
01080a2f mov        ecx, dword ptr [rbp + 0xe0]
01080a35 mov        dword ptr [rax + 0x58], ecx
01080a38 movzx      edx, byte ptr [rbp + 0xe8]
01080a3f and        dl, 1
01080a42 shl        dl, 5
01080a45 movzx      ecx, byte ptr [rax + 0x4b]
01080a49 and        cl, 0xdf
01080a4c or         dl, cl
01080a4e mov        byte ptr [rax + 0x4b], dl
01080a51 cmp        byte ptr [rbp + 0xde], bl
01080a57 je         0x141080a65
01080a59 mov        rax, qword ptr [rsp + 0x58]
01080a5e or         byte ptr [rax + 0x9a], 4
01080a65 cmp        dword ptr [rsp + 0x40], ebx
01080a69 jge        0x141080a74
01080a6b mov        eax, dword ptr [rbp + 0xd0]
01080a71 mov        dword ptr [rsi + 0x28], eax
01080a74 mov        eax, dword ptr [rbp + 0xd0]
01080a7a mov        dword ptr [rsi + 0x2c], eax
01080a7d xor        eax, eax
01080a7f mov        dword ptr [rsp + 0x58], eax
01080a83 cmp        dword ptr [rbp + 0xcc], eax
01080a89 jbe        0x141080df1
01080a8f mov        rax, qword ptr [rsp + 0x48]
01080a94 nop        dword ptr [rax]
01080a98 nop        dword ptr [rax + rax]
01080aa0 mov        qword ptr [rbp - 0x70], r13
01080aa4 mov        qword ptr [rsp + 0x48], rax
01080aa9 mov        dword ptr [rsp + 0x30], r14d
01080aae mov        r8d, 8
01080ab4 lea        rdx, [rbp + 0xed0]
01080abb mov        rcx, rdi
01080abe call       0x1410770a0
01080ac3 mov        ebx, eax
01080ac5 test       eax, eax
01080ac7 jne        0x1410816e7
01080acd mov        r10d, dword ptr [rbp + 0xed4]
01080ad4 mov        r14d, r10d
01080ad7 cmp        byte ptr [r13], al
01080adb jne        0x141080ae0
01080add bswap      r14d
01080ae0 lea        rcx, [rbp + 0xed8]
01080ae7 mov        r13d, 0x18
01080aed cmp        r14d, r13d
01080af0 cmovb      r13d, r14d
01080af4 cmp        r13d, 8
01080af8 jbe        0x141080b3e
01080afa lea        eax, [r13 - 8]
01080afe mov        qword ptr [rsp + 0x38], rax
01080b03 cmp        rax, 0xa00000
01080b09 ja         0x1410816e2
01080b0f mov        r8d, eax
01080b12 lea        rdx, [rbp + 0xed8]
01080b19 mov        rcx, rdi
01080b1c call       0x1410770a0
01080b21 mov        ebx, eax
01080b23 test       eax, eax
01080b25 jne        0x1410816e7
01080b2b lea        rcx, [rbp + 0xed8]
01080b32 add        rcx, qword ptr [rsp + 0x38]
01080b37 mov        r10d, dword ptr [rbp + 0xed4]
01080b3e cmp        r13d, 0x18
01080b42 jae        0x141080b60
01080b44 test       rcx, rcx
01080b47 je         0x141080b60
01080b49 mov        r8d, 0x18
01080b4f sub        r8d, r13d
01080b52 xor        edx, edx
01080b54 call       0x14179cca0
01080b59 mov        r10d, dword ptr [rbp + 0xed4]
01080b60 cmp        r14d, r13d
01080b63 jbe        0x141080b7d
01080b65 sub        r14d, r13d
01080b68 mov        edx, r14d
01080b6b mov        rcx, rdi
01080b6e call       0x14106a520
01080b73 mov        ebx, eax
01080b75 test       eax, eax
01080b77 jne        0x1410816e7
01080b7d mov        rax, qword ptr [rbp - 0x70]
01080b81 mov        r13, rax
01080b84 cmp        byte ptr [rax], 0
01080b87 jne        0x141080c95
01080b8d mov        ecx, dword ptr [rbp + 0xed0]
01080b93 mov        r11d, ecx
01080b96 and        r11d, 0xff0000
01080b9d mov        eax, ecx
01080b9f shr        eax, 0x10
01080ba2 or         r11d, eax
01080ba5 shr        r11d, 8
01080ba9 mov        eax, ecx
01080bab shl        eax, 0x10
01080bae and        ecx, 0xff00
01080bb4 or         eax, ecx
01080bb6 shl        eax, 8
01080bb9 or         r11d, eax
01080bbc mov        dword ptr [rbp + 0xed0], r11d
01080bc3 mov        ecx, r10d
01080bc6 and        ecx, 0xff0000
01080bcc mov        eax, r10d
01080bcf shr        eax, 0x10
01080bd2 or         ecx, eax
01080bd4 shr        ecx, 8
01080bd7 mov        eax, r10d
01080bda shl        eax, 0x10
01080bdd and        r10d, 0xff00
01080be4 or         eax, r10d
01080be7 shl        eax, 8
01080bea mov        r10d, ecx
01080bed or         r10d, eax
01080bf0 mov        dword ptr [rbp + 0xed4], r10d
01080bf7 mov        ecx, dword ptr [rbp + 0xed8]
01080bfd mov        r9d, ecx
01080c00 and        r9d, 0xff0000
01080c07 mov        eax, ecx
01080c09 shr        eax, 0x10
01080c0c or         r9d, eax
01080c0f shr        r9d, 8
01080c13 mov        eax, ecx
01080c15 shl        eax, 0x10
01080c18 and        ecx, 0xff00
01080c1e or         eax, ecx
01080c20 shl        eax, 8
01080c23 or         r9d, eax
01080c26 mov        dword ptr [rbp + 0xed8], r9d
01080c2d mov        ecx, dword ptr [rbp + 0xedc]
01080c33 mov        r8d, ecx
01080c36 and        r8d, 0xff0000
01080c3d mov        eax, ecx
01080c3f shr        eax, 0x10
01080c42 or         r8d, eax
01080c45 shr        r8d, 8
01080c49 mov        eax, ecx
01080c4b shl        eax, 0x10
01080c4e and        ecx, 0xff00
01080c54 or         eax, ecx
01080c56 shl        eax, 8
01080c59 or         r8d, eax
01080c5c mov        dword ptr [rbp + 0xedc], r8d
01080c63 mov        ecx, dword ptr [rbp + 0xee0]
01080c69 mov        edx, ecx
01080c6b and        edx, 0xff0000
01080c71 mov        eax, ecx
01080c73 shr        eax, 0x10
01080c76 or         edx, eax
01080c78 shr        edx, 8
01080c7b mov        eax, ecx
01080c7d shl        eax, 0x10
01080c80 and        ecx, 0xff00
01080c86 or         eax, ecx
01080c88 shl        eax, 8
01080c8b or         edx, eax
01080c8d mov        dword ptr [rbp + 0xee0], edx
01080c93 jmp        0x141080caa
01080c95 mov        r8d, dword ptr [rbp + 0xedc]
01080c9c mov        r9d, dword ptr [rbp + 0xed8]
01080ca3 mov        r11d, dword ptr [rbp + 0xed0]
01080caa cmp        r11d, 0x686f686d
01080cb1 jne        0x1410816e2
01080cb7 sub        r8d, 0xc8
01080cbe je         0x141080d9b
01080cc4 sub        r8d, 1
01080cc8 je         0x141080d90
01080cce sub        r8d, 1
01080cd2 je         0x141080d33
01080cd4 cmp        r8d, 1
01080cd8 je         0x141080d33
01080cda sub        r9d, r10d
01080cdd movsxd     rdx, r9d
01080ce0 add        rdx, qword ptr [rdi + 0x1e00170]
01080ce7 mov        qword ptr [rdi + 0x1e00170], rdx
01080cee mov        rcx, qword ptr [rdi + 0x1e00178]
01080cf5 cmp        rdx, rcx
01080cf8 jb         0x141080d06
01080cfa add        rcx, qword ptr [rdi + 0x1e00180]
01080d01 cmp        rdx, rcx
01080d04 jb         0x141080d20
01080d06 xor        eax, eax
01080d08 mov        qword ptr [rdi + 0x1e00180], rax
01080d0f mov        ebx, eax
01080d11 mov        r14d, dword ptr [rsp + 0x30]
01080d16 mov        rax, qword ptr [rsp + 0x48]
01080d1b jmp        0x141080ddb
01080d20 xor        eax, eax
01080d22 mov        ebx, eax
01080d24 mov        r14d, dword ptr [rsp + 0x30]
01080d29 mov        rax, qword ptr [rsp + 0x48]
01080d2e jmp        0x141080ddb
01080d33 sub        r9d, r10d
01080d36 movsxd     rdx, r9d
01080d39 add        rdx, qword ptr [rdi + 0x1e00170]
01080d40 mov        qword ptr [rdi + 0x1e00170], rdx
01080d47 mov        rcx, qword ptr [rdi + 0x1e00178]
01080d4e cmp        rdx, rcx
01080d51 jb         0x141080d5f
01080d53 add        rcx, qword ptr [rdi + 0x1e00180]
01080d5a cmp        rdx, rcx
01080d5d jb         0x141080d7b
01080d5f xor        eax, eax
01080d61 mov        qword ptr [rdi + 0x1e00180], rax
01080d68 mov        ebx, eax
01080d6a mov        r14d, dword ptr [rsp + 0x30]
01080d6f mov        rax, qword ptr [rsp + 0x48]
01080d74 mov        qword ptr [rsp + 0x48], rax
01080d79 jmp        0x141080ddb
01080d7b xor        eax, eax
01080d7d mov        ebx, eax
01080d7f mov        r14d, dword ptr [rsp + 0x30]
01080d84 mov        rax, qword ptr [rsp + 0x48]
01080d89 mov        qword ptr [rsp + 0x48], rax
01080d8e jmp        0x141080ddb
01080d90 xor        eax, eax
01080d92 mov        r9d, eax
01080d95 lea        rax, [rsi + 0x6c]
01080d99 jmp        0x141080da4
01080d9b xor        eax, eax
01080d9d mov        r9d, eax
01080da0 lea        rax, [rsi + 0x68]
01080da4 lea        r8, [r15 + 0x130]
01080dab mov        edx, 1
01080db0 mov        rcx, rdi
01080db3 mov        dword ptr [rsp + 0x28], r9d
01080db8 mov        qword ptr [rsp + 0x20], rax
01080dbd call       0x1410773d0
01080dc2 mov        ebx, eax
01080dc4 mov        r14d, dword ptr [rsp + 0x30]
01080dc9 mov        rax, qword ptr [rsp + 0x48]
01080dce mov        qword ptr [rsp + 0x48], rax
01080dd3 test       ebx, ebx
01080dd5 jne        0x1410816e7
01080ddb mov        ecx, dword ptr [rsp + 0x58]
01080ddf inc        ecx
01080de1 mov        dword ptr [rsp + 0x58], ecx
01080de5 cmp        ecx, dword ptr [rbp + 0xcc]
01080deb jb         0x141080aa0
01080df1 test       byte ptr [rsi + 0x4b], 1
01080df5 je         0x141080dff
01080df7 mov        rcx, rsi
01080dfa call       0x140ef0700
01080dff mov        r9d, dword ptr [rbp + 0xc4]
01080e06 jmp        0x141080e10
01080e08 mov        r12b, 1
01080e0b mov        r9d, dword ptr [rsp + 0x30]
01080e10 xor        r11d, r11d
01080e13 test       r12b, r12b
01080e16 je         0x141080e54
01080e18 mov        eax, dword ptr [rbp + 0xc8]
01080e1e sub        eax, r9d
01080e21 movsxd     rdx, eax
01080e24 add        rdx, qword ptr [rdi + 0x1e00170]
01080e2b mov        qword ptr [rdi + 0x1e00170], rdx
01080e32 mov        rcx, qword ptr [rdi + 0x1e00178]
01080e39 cmp        rdx, rcx
01080e3c jb         0x141080e4a
01080e3e add        rcx, qword ptr [rdi + 0x1e00180]
01080e45 cmp        rdx, rcx
01080e48 jb         0x141080e51
01080e4a mov        qword ptr [rdi + 0x1e00180], r11
01080e51 mov        ebx, r11d
01080e54 mov        r12d, dword ptr [rsp + 0x6c]
01080e59 inc        r12d
01080e5c mov        dword ptr [rsp + 0x6c], r12d
01080e61 cmp        r12d, dword ptr [rbp + 0x130]
01080e68 mov        rsi, qword ptr [rsp + 0x48]
01080e6d jb         0x14107ffd0
01080e73 lea        r14, [r15 + 0x130]
01080e7a test       r14, r14
01080e7d je         0x141080ece
01080e7f cmp        dword ptr [r14], 0x73747263
01080e86 jne        0x141080ece
01080e88 mov        rsi, qword ptr [r14 + 8]
01080e8c test       rsi, rsi
01080e8f je         0x141080eca
01080e91 cmp        dword ptr [rsi + 8], 0x4d656d48
01080e98 jne        0x141080ec6
01080e9a mov        rcx, qword ptr [rsi]
01080e9d test       rcx, rcx
01080ea0 je         0x141080eae
01080ea2 call       qword ptr [rip + 0x86b4c0]
01080ea8 xor        r11d, r11d
01080eab mov        qword ptr [rsi], r11
01080eae mov        dword ptr [rsi + 8], r11d
01080eb2 mov        qword ptr [rsi + 0x10], r11
01080eb6 mov        qword ptr [rsi + 0x18], r11
01080eba mov        rcx, rsi
01080ebd call       qword ptr [rip + 0x86b4a5]
01080ec3 xor        r11d, r11d
01080ec6 mov        qword ptr [r14 + 8], r11
01080eca mov        dword ptr [r14 + 0x28], r11d
01080ece cmp        byte ptr [rsp + 0x35], 0
01080ed3 je         0x14108101c
01080ed9 lea        rcx, [r15 + 0x130]
01080ee0 lea        r8, [rbp + 0x1440]
01080ee7 mov        edx, dword ptr [r15 + 0x178]
01080eee call       0x140bff470
01080ef3 movzx      r8d, word ptr [rbp + 0x1440]
01080efb mov        r9, qword ptr [rip + 0x86805e]
01080f02 mov        r9, qword ptr [r9]
01080f05 lea        rdx, [rbp + 0x1442]
01080f0c mov        rcx, qword ptr [rip + 0x102517d]
01080f13 call       qword ptr [rip + 0x868187]
01080f19 mov        r14, rax
01080f1c mov        rcx, qword ptr [rip + 0x102f085]
01080f23 test       rcx, rcx
01080f26 je         0x141080f42
01080f28 test       rax, rax
01080f2b je         0x141080f42
01080f2d xor        r8d, r8d
01080f30 mov        rdx, rax
01080f33 call       qword ptr [rip + 0x8680e7]
01080f39 test       rax, rax
01080f3c jne        0x141081013
01080f42 mov        rcx, qword ptr [rip + 0x104ed97]
01080f49 test       rcx, rcx
01080f4c je         0x141080f7d
01080f4e mov        edx, 0x7f0001
01080f53 call       qword ptr [rip + 0x867e97]
01080f59 mov        rsi, rax
01080f5c test       rax, rax
01080f5f je         0x141080f78
01080f61 mov        rcx, rax
01080f64 call       qword ptr [rip + 0x867f56]
01080f6a mov        rbx, rax
01080f6d call       qword ptr [rip + 0x86800d]
01080f73 cmp        rbx, rax
01080f76 jne        0x141080f7d
01080f78 test       rsi, rsi
01080f7b jne        0x141080f84
01080f7d mov        rsi, qword ptr [rip + 0x102cc74]
01080f84 xor        r12d, r12d
01080f87 movzx      eax, r12w
01080f8b mov        word ptr [rbp + 0x1440], ax
01080f92 test       rsi, rsi
01080f95 je         0x141080fea
01080f97 mov        qword ptr [rbp], r12
01080f9b mov        rcx, rsi
01080f9e call       qword ptr [rip + 0x867fec]
01080fa4 mov        rbx, rax
01080fa7 mov        qword ptr [rbp + 8], rax
01080fab mov        eax, r12d
01080fae test       rbx, rbx
01080fb1 je         0x141080fe3
01080fb3 mov        eax, 0xff
01080fb8 cmp        rbx, rax
01080fbb jle        0x141080fc4
01080fbd mov        qword ptr [rbp + 8], rax
01080fc1 movzx      ebx, ax
01080fc4 movaps     xmm0, xmmword ptr [rbp]
01080fc8 movdqa     xmmword ptr [rbp - 0x70], xmm0
01080fcd lea        r8, [rbp + 0x1442]
01080fd4 lea        rdx, [rbp - 0x70]
01080fd8 mov        rcx, rsi
01080fdb call       0x140b92160
01080fe0 movzx      eax, bx
01080fe3 mov        word ptr [rbp + 0x1440], ax
01080fea lea        r9, [r15 + 0x178]
01080ff1 lea        r11, [r15 + 0x130]
01080ff8 mov        ecx, 0xff
01080ffd cmp        ax, cx
01081000 jbe        0x1410810b9
01081006 mov        dword ptr [r9], r12d
01081009 mov        ebx, 0xffffffce
0108100e test       r14, r14
01081011 je         0x14108101c
01081013 mov        rcx, r14
01081016 call       qword ptr [rip + 0x867e04]
0108101c cmp        byte ptr [rsp + 0x34], 0
01081021 je         0x141081214
01081027 xor        r8d, r8d
0108102a lea        rdx, [rbp - 0x70]
0108102e lea        rcx, [rbp + 0x30]
01081032 call       0x1410cc5c0
01081037 mov        r12, qword ptr [rbp - 0x18]
0108103b mov        qword ptr [rbp - 0x60], r12
0108103f mov        rax, qword ptr [rsp + 0x78]
01081044 mov        qword ptr [rbp - 0x58], rax
01081048 movzx      eax, byte ptr [rbp - 0x6e]
0108104c cmp        byte ptr [rbp + 0x32a], 0
01081053 mov        ecx, 1
01081058 cmovne     eax, ecx
0108105b mov        byte ptr [rbp - 0x6e], al
0108105e lea        rdx, [rbp - 0x70]
01081062 mov        rcx, r15
01081065 call       0x140ee4d70
0108106a mov        rax, qword ptr [rsp + 0x60]
0108106f test       byte ptr [rax + 0x113], 1
01081076 jne        0x14108114e
0108107c cmp        dword ptr [r15], 0x706c7374
01081083 jne        0x1410810b2
01081085 test       byte ptr [r15 + 0x228], 1
0108108d je         0x1410810b2
0108108f cmp        byte ptr [r15 + 0x232], 0
01081097 je         0x1410810b2
01081099 mov        rcx, qword ptr [r15 + 0x240]
010810a0 test       rcx, rcx
010810a3 je         0x1410810b2
010810a5 call       0x140ee6260
010810aa test       al, al
010810ac jne        0x14108114e
010810b2 xor        dl, dl
010810b4 jmp        0x141081150
010810b9 movzx      r8d, ax
010810bd add        r8d, r8d
010810c0 test       r11, r11
010810c3 je         0x141081009
010810c9 cmp        dword ptr [r11], 0x73747263
010810d0 jne        0x141081009
010810d6 cmp        dword ptr [r11 + 0x28], r12d
010810da jne        0x141081009
010810e0 movsxd     rdx, dword ptr [r9]
010810e3 cmp        dword ptr [r11 + 0x3c], r12d
010810e7 jne        0x141081009
010810ed test       edx, edx
010810ef je         0x141081138
010810f1 mov        eax, dword ptr [r11 + 4]
010810f5 and        eax, 1
010810f8 test       edx, edx
010810fa jle        0x141081009
01081100 cmp        edx, dword ptr [r11 + 0x2c]
01081104 jg         0x141081009
0108110a test       al, al
0108110c je         0x14108111c
0108110e mov        rax, qword ptr [r11 + 0x18]
01081112 mov        rax, qword ptr [rax]
01081115 sub        dword ptr [rax + rdx*4 - 4], 1
0108111a jne        0x141081138
0108111c mov        r10, rdx
0108111f mov        rax, qword ptr [r11 + 0x10]
01081123 mov        rdx, qword ptr [rax]
01081126 mov        eax, dword ptr [rdx + r10*8 - 4]
0108112b add        dword ptr [r11 + 0x40], eax
0108112f mov        dword ptr [rdx + r10*8 - 8], 0x80000001
01081138 lea        rdx, [rbp + 0x1442]
0108113f mov        rcx, r11
01081142 call       0x140bfe1f0
01081147 mov        ebx, eax
01081149 jmp        0x14108100e
0108114e mov        dl, 1
01081150 cmp        dword ptr [r15], 0x706c7374
01081157 jne        0x1410811c4
01081159 movzx      ecx, byte ptr [r15 + 0x228]
01081161 test       cl, 1
01081164 je         0x1410811c4
01081166 movzx      eax, cl
01081169 shr        al, 2
0108116c and        al, 1
0108116e cmp        al, dl
01081170 je         0x1410811c4
01081172 and        cl, 0xfb
01081175 movzx      eax, dl
01081178 shl        al, 2
0108117b or         cl, al
0108117d mov        byte ptr [r15 + 0x228], cl
01081184 cmp        dl, 1
01081187 jne        0x1410811c4
01081189 mov        rax, qword ptr [r15 + 8]
0108118d test       rax, rax
01081190 je         0x1410811c4
01081192 cmp        dword ptr [rax + 0x80], 0x74646174
0108119c jne        0x1410811c4
0108119e movzx      ecx, byte ptr [rax + 0x112]
010811a5 test       cl, 0x10
010811a8 jne        0x1410811c4
010811aa or         cl, 0x10
010811ad mov        byte ptr [rax + 0x112], cl
010811b3 cmp        byte ptr [rip + 0xf68b96], 0
010811ba je         0x1410811c4
010811bc movaps     xmm0, xmm6
010811bf call       0x140cb1c20
010811c4 cmp        byte ptr [rbp + 0x32a], 0
010811cb je         0x141081218
010811cd or         byte ptr [r15 + 0x228], 2
010811d5 cmp        dword ptr [r15], 0x706c7374
010811dc jne        0x141081218
010811de mov        rsi, qword ptr [r15 + 0x420]
010811e5 test       rsi, rsi
010811e8 je         0x141081218
010811ea nop        word ptr [rax + rax]
010811f0 xor        r8d, r8d
010811f3 mov        rdx, rsi
010811f6 mov        rcx, r15
010811f9 call       0x140fb3430
010811fe cmp        dword ptr [rsi + 8], 0x63736574
01081205 jne        0x141081218
01081207 mov        rax, qword ptr [rsi]
0108120a mov        rsi, rax
0108120d test       rax, rax
01081210 jne        0x1410811f0
01081212 jmp        0x141081218
01081214 mov        r12, qword ptr [rbp - 0x18]
01081218 test       r12, r12
0108121b je         0x1410812d0
01081221 cmp        dword ptr [r12], 0x534c7374
01081229 jne        0x1410812d0
0108122f mov        eax, dword ptr [r12 + 4]
01081234 test       eax, eax
01081236 je         0x1410812d0
0108123c sub        eax, 1
0108123f mov        dword ptr [r12 + 4], eax
01081244 jne        0x1410812d0
0108124a mov        rsi, qword ptr [r12 + 0x60]
0108124f test       rsi, rsi
01081252 je         0x141081290
01081254 xor        eax, eax
01081256 mov        r14d, eax
01081259 cmp        dword ptr [r12 + 0x10], eax
0108125e jbe        0x141081280
01081260 add        rsi, 0x10
01081264 cmp        byte ptr [rsi - 8], 0
01081268 je         0x141081272
0108126a mov        rcx, qword ptr [rsi]
0108126d call       0x140bef7f0
01081272 add        rsi, 0x20
01081276 inc        r14d
01081279 cmp        r14d, dword ptr [r12 + 0x10]
0108127e jb         0x141081264
01081280 mov        rcx, qword ptr [r12 + 0x60]
01081285 test       rcx, rcx
01081288 je         0x141081290
0108128a call       qword ptr [rip + 0x86b0d8]
01081290 lea        rcx, [r12 + 0x18]
01081295 call       0x140bfdfd0
0108129a xorps      xmm0, xmm0
0108129d xor        eax, eax
0108129f movups     xmmword ptr [r12], xmm0
010812a4 movups     xmmword ptr [r12 + 0x10], xmm0
010812aa movups     xmmword ptr [r12 + 0x20], xmm0
010812b0 movups     xmmword ptr [r12 + 0x30], xmm0
010812b6 movups     xmmword ptr [r12 + 0x40], xmm0
010812bc movups     xmmword ptr [r12 + 0x50], xmm0
010812c2 mov        qword ptr [r12 + 0x60], rax
010812c7 mov        rcx, r12
010812ca call       qword ptr [rip + 0x86b098]
010812d0 mov        rsi, qword ptr [rsp + 0x78]
010812d5 test       rsi, rsi
010812d8 je         0x141081307
010812da cmp        dword ptr [rsi], 0x4f4c5354
010812e0 jne        0x141081307
010812e2 mov        eax, dword ptr [rsi + 4]
010812e5 test       eax, eax
010812e7 je         0x141081307
010812e9 sub        eax, 1
010812ec mov        dword ptr [rsi + 4], eax
010812ef jne        0x141081307
010812f1 lea        rcx, [rsi + 8]
010812f5 call       0x1402de700
010812fa mov        edx, 0x20
010812ff mov        rcx, rsi
01081302 call       0x140bc6a20
01081307 cmp        byte ptr [rdi + 0x1e002f2], 0
0108130e je         0x1410814bd
01081314 cmp        dword ptr [r15], 0x706c7374
0108131b jne        0x1410814b3
01081321 mov        rax, qword ptr [r15 + 8]
01081325 test       rax, rax
01081328 je         0x14108144a
0108132e cmp        dword ptr [rax + 0x80], 0x74646174
01081338 jne        0x14108144a
0108133e test       byte ptr [rax + 0x110], 1
01081345 je         0x14108144a
0108134b test       byte ptr [r15 + 0x1da], 0x10
01081353 je         0x14108144a
01081359 test       byte ptr [r15 + 0x181], 4
01081361 jne        0x14108144a
01081367 mov        rdx, r15
0108136a lea        rcx, [rbp - 0x80]
0108136e call       0x140ef1df0
01081373 mov        rcx, qword ptr [rbp - 0x78]
01081377 mov        rdx, qword ptr [rbp - 0x80]
0108137b test       rdx, rdx
0108137e je         0x141081386
01081380 cmp        qword ptr [rdx], 0
01081384 jne        0x141081391
01081386 test       rcx, rcx
01081389 je         0x1410813f2
0108138b cmp        qword ptr [rcx], 0
0108138f je         0x1410813f2
01081391 mov        r14, 0xffffffffffffffff
01081398 test       rdx, rdx
0108139b je         0x1410813c5
0108139d mov        eax, r14d
010813a0 lock xadd  dword ptr [rdx + 8], eax
010813a5 cmp        eax, 1
010813a8 jne        0x1410813b9
010813aa mov        dword ptr [rdx + 8], 0xc4653600
010813b1 mov        rcx, rdx
010813b4 call       0x14179bdd8
010813b9 xor        esi, esi
010813bb mov        qword ptr [rbp - 0x80], rsi
010813bf mov        rcx, qword ptr [rbp - 0x78]
010813c3 jmp        0x1410813c7
010813c5 xor        esi, esi
010813c7 test       rcx, rcx
010813ca je         0x1410814ca
010813d0 mov        eax, r14d
010813d3 lock xadd  dword ptr [rcx + 8], eax
010813d8 cmp        eax, 1
010813db jne        0x1410813e9
010813dd mov        dword ptr [rcx + 8], 0xc4653600
010813e4 call       0x14179bdd8
010813e9 mov        qword ptr [rbp - 0x78], rsi
010813ed jmp        0x1410814ca
010813f2 mov        r14, 0xffffffffffffffff
010813f9 test       rdx, rdx
010813fc je         0x141081426
010813fe mov        eax, r14d
01081401 lock xadd  dword ptr [rdx + 8], eax
01081406 cmp        eax, 1
01081409 jne        0x14108141a
0108140b mov        dword ptr [rdx + 8], 0xc4653600
01081412 mov        rcx, rdx
01081415 call       0x14179bdd8
0108141a xor        esi, esi
0108141c mov        qword ptr [rbp - 0x80], rsi
01081420 mov        rcx, qword ptr [rbp - 0x78]
01081424 jmp        0x141081428
01081426 xor        esi, esi
01081428 test       rcx, rcx
0108142b je         0x14108144a
0108142d mov        eax, r14d
01081430 lock xadd  dword ptr [rcx + 8], eax
01081435 cmp        eax, 1
01081438 jne        0x141081446
0108143a mov        dword ptr [rcx + 8], 0xc4653600
01081441 call       0x14179bdd8
01081446 mov        qword ptr [rbp - 0x78], rsi
0108144a cmp        dword ptr [r15], 0x706c7374
01081451 jne        0x1410814b3
01081453 mov        rax, qword ptr [r15 + 8]
01081457 test       rax, rax
0108145a je         0x141081484
0108145c mov        rcx, qword ptr [rax + 0x1928]
01081463 test       rcx, rcx
01081466 je         0x141081484
01081468 lea        rdx, [r15 + 0x188]
0108146f mov        rax, qword ptr [rdx]
01081472 cmp        rax, -3
01081476 je         0x141081484
01081478 ja         0x141081484
0108147a test       rax, rax
0108147d je         0x141081484
0108147f call       0x140f01080
01081484 mov        byte ptr [r15 + 0x180], 0
0108148c mov        byte ptr [r15 + 0x198], 0
01081494 xor        eax, eax
01081496 mov        dword ptr [r15 + 0x19c], eax
0108149d mov        word ptr [r15 + 0x182], ax
010814a5 mov        qword ptr [r15 + 0x188], rax
010814ac mov        qword ptr [r15 + 0x190], rax
010814b3 xor        edx, edx
010814b5 mov        rcx, r15
010814b8 call       0x140ef19a0
010814bd movzx      eax, byte ptr [rsp + 0x44]
010814c2 test       al, al
010814c4 je         0x141081622
010814ca cmp        dword ptr [r15], 0x706c7374
010814d1 jne        0x14108162a
010814d7 mov        rax, qword ptr [r15 + 0x38]
010814db test       rax, rax
010814de je         0x1410814f6
010814e0 xor        r8d, r8d
010814e3 xor        edx, edx
010814e5 mov        rcx, rax
010814e8 call       0x140ef3bd0
010814ed mov        rax, qword ptr [r15 + 0x38]
010814f1 test       rax, rax
010814f4 jne        0x1410814e0
010814f6 mov        rsi, qword ptr [r15 + 0x18]
010814fa test       rsi, rsi
010814fd je         0x141081610
01081503 test       byte ptr [rsi + 0x228], 2
0108150a je         0x141081610
01081510 cmp        dword ptr [r15], 0x706c7374
01081517 jne        0x141081610
0108151d cmp        dword ptr [rsi], 0x706c7374
01081523 jne        0x141081610
01081529 mov        rax, qword ptr [r15 + 0x50]
0108152d xor        ecx, ecx
0108152f mov        qword ptr [rbp - 0x68], rcx
01081533 mov        qword ptr [rbp - 0x50], rcx
01081537 xorps      xmm0, xmm0
0108153a movdqa     xmmword ptr [rbp - 0x40], xmm0
0108153f mov        dword ptr [rbp - 0x30], ecx
01081542 mov        qword ptr [rbp - 0x70], rax
01081546 mov        qword ptr [rbp - 0x58], rax
0108154a mov        eax, 1
0108154f mov        qword ptr [rbp - 0x60], rax
01081553 mov        qword ptr [rbp - 0x48], rax
01081557 lea        rax, [rbp - 0x20]
0108155b mov        qword ptr [rsp + 0x28], rax
01081560 lea        r9, [rbp - 0x70]
01081564 mov        r8d, 0x28
0108156a mov        rcx, qword ptr [rsi + 0x240]
01081571 call       0x140bf0910
01081576 test       eax, eax
01081578 jne        0x141081610
0108157e mov        edx, dword ptr [rbp - 0x20]
01081581 mov        rcx, qword ptr [rsi + 0x240]
01081588 call       0x140befe50
0108158d lea        rdx, [rsi + 0x260]
01081594 mov        rcx, qword ptr [rsi + 0x240]
0108159b call       0x140fdb0b0
010815a0 cmp        dword ptr [rsi], 0x706c7374
010815a6 jne        0x1410815fc
010815a8 movzx      ecx, byte ptr [rsi + 0x228]
010815af movzx      eax, cl
010815b2 and        al, 5
010815b4 cmp        al, 1
010815b6 jne        0x1410815fc
010815b8 or         cl, 4
010815bb mov        byte ptr [rsi + 0x228], cl
010815c1 mov        rax, qword ptr [rsi + 8]
010815c5 test       rax, rax
010815c8 je         0x1410815fc
010815ca cmp        dword ptr [rax + 0x80], 0x74646174
010815d4 jne        0x1410815fc
010815d6 movzx      ecx, byte ptr [rax + 0x112]
010815dd test       cl, 0x10
010815e0 jne        0x1410815fc
010815e2 or         cl, 0x10
010815e5 mov        byte ptr [rax + 0x112], cl
010815eb cmp        byte ptr [rip + 0xf6875e], 0
010815f2 je         0x1410815fc
010815f4 movaps     xmm0, xmm6
010815f7 call       0x140cb1c20
010815fc mov        rsi, qword ptr [rsi + 0x18]
01081600 test       rsi, rsi
01081603 jne        0x1410815a0
01081605 mov        dl, 1
01081607 mov        rcx, qword ptr [r15 + 8]
0108160b call       0x140ee5b20
01081610 xor        r8d, r8d
01081613 mov        edx, 0x706c6465
01081618 mov        rcx, r15
0108161b call       0x140ef4580
01081620 jmp        0x14108162a
01081622 mov        rcx, r15
01081625 call       0x140efa780
0108162a test       byte ptr [r15 + 0x1d8], 8
01081632 je         0x1410816b8
01081638 cmp        word ptr [rdi + 0xc], 0x29
0108163d jae        0x1410816b8
01081643 mov        rcx, qword ptr [rip + 0x10258e6]
0108164a test       rcx, rcx
0108164d je         0x141081658
0108164f add        rcx, 0x236
01081656 jmp        0x14108165f
01081658 lea        rcx, [rip + 0x10313e1]
0108165f movsx      eax, word ptr [rcx + 0xf7ac]
01081666 movd       xmm0, eax
0108166a cvtdq2ps   xmm0, xmm0
0108166d ucomiss    xmm0, xmm7
01081670 jp         0x1410816b8
01081672 jne        0x1410816b8
01081674 movsx      eax, word ptr [rcx + 0xf7ae]
0108167b movd       xmm0, eax
0108167f cvtdq2ps   xmm0, xmm0
01081682 ucomiss    xmm0, xmm7
01081685 jp         0x1410816b8
01081687 jne        0x1410816b8
01081689 cmp        word ptr [rbp + 0x2d2], 0
01081691 je         0x1410816b8
01081693 movzx      eax, word ptr [rbp + 0x2d0]
0108169a mov        word ptr [rcx + 0xf7ac], ax
010816a1 movzx      eax, word ptr [rbp + 0x2d2]
010816a8 mov        word ptr [rcx + 0xf7ae], ax
010816af mov        word ptr [rcx + 0xf7b0], 0xffff
010816b8 inc        qword ptr [rdi + 0x1e00190]
010816bf mov        rcx, rdi
010816c2 call       0x141077340
010816c7 xor        r15d, r15d
010816ca jmp        0x14107f260
010816cf mov        eax, 0xffffff94
010816d4 jmp        0x1410816e9
010816d6 call       0x140fbcf80
010816db mov        ebx, 0xffffff94
010816e0 jmp        0x1410816e7
010816e2 mov        ebx, 0xffffff30
010816e7 mov        eax, ebx
010816e9 mov        rcx, qword ptr [rbp + 0x1640]
010816f0 xor        rcx, rsp
010816f3 call       0x14179b8e0
010816f8 lea        r11, [rsp + 0x1770]
01081700 mov        rbx, qword ptr [r11 + 0x38]
01081704 mov        rsi, qword ptr [r11 + 0x40]
01081708 mov        rdi, qword ptr [r11 + 0x48]
0108170c movaps     xmm6, xmmword ptr [r11 - 0x10]
01081711 movaps     xmm7, xmmword ptr [r11 - 0x20]
01081716 mov        rsp, r11
01081719 pop        r15
0108171b pop        r14
0108171d pop        r13
0108171f pop        r12
01081721 pop        rbp
01081722 ret        
01081723 nop        
01081724 sub        bh, bl
