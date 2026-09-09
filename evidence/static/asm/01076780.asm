; Original iTunes.exe machine code; base=0x140000000; RVA=0x1076780; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1076780..0x10767b8 (exclusive)
01076780 test       rcx, rcx
01076783 je         0x141076b54
01076789 mov        r11, rsp
0107678c push       rbp
0107678d push       rbx
0107678e lea        rbp, [r11 - 0x58]
01076792 sub        rsp, 0x148
01076799 mov        rax, qword ptr [rip + 0xf5e8a0]
010767a0 xor        rax, rsp
010767a3 mov        qword ptr [rbp + 0x30], rax
010767a7 cmp        qword ptr [rcx + 0x18], 0
010767ac mov        rbx, rcx
010767af je         0x141076b3f
010767b5 xorps      xmm0, xmm0
; range 0x10767b8..0x1076a1b (exclusive)
010767b8 mov        qword ptr [r11 + 0x10], rsi
010767bc xor        eax, eax
010767be mov        qword ptr [r11 + 0x18], rdi
010767c2 xor        esi, esi
010767c4 mov        qword ptr [rbp - 0x80], rax
010767c8 movups     xmmword ptr [rsp + 0x40], xmm0
010767cd movups     xmmword ptr [rsp + 0x50], xmm0
010767d2 movups     xmmword ptr [rsp + 0x60], xmm0
010767d7 movups     xmmword ptr [rsp + 0x70], xmm0
010767dc cmp        byte ptr [rcx + 0x38], al
010767df jne        0x14107696e
010767e5 mov        edx, 0x80000
010767ea lea        rcx, [rsp + 0x40]
010767ef call       0x140b9fe10
010767f4 test       eax, eax
010767f6 jne        0x141076ae8
010767fc mov        rdi, qword ptr [rbx + 0x30]
01076800 xor        edx, edx
01076802 mov        rcx, rdi
01076805 call       0x140ba09a0
0107680a test       eax, eax
0107680c jne        0x141076ae8
01076812 lea        r8, [rbp - 0x60]
01076816 mov        qword ptr [rsp + 0x38], 0x90
0107681f lea        rdx, [rsp + 0x38]
01076824 mov        rcx, rdi
01076827 call       0x140ba0350
0107682c test       eax, eax
0107682e jne        0x141076ae8
01076834 lea        rcx, [rbp - 0x60]
01076838 call       0x141068f90
0107683d lea        r8, [rbp - 0x60]
01076841 lea        rdx, [rsp + 0x38]
01076846 lea        rcx, [rsp + 0x40]
0107684b call       0x140ba04c0
01076850 test       eax, eax
01076852 jne        0x141076ae8
01076858 lea        rdx, [rsp + 0x40]
0107685d mov        rcx, rdi
01076860 call       0x141075580
01076865 test       eax, eax
01076867 jne        0x141076ae8
0107686d mov        rcx, qword ptr [rsp + 0x48]
01076872 lea        rdx, [rsp + 0x30]
01076877 mov        qword ptr [rsp + 0x30], rsi
0107687c call       0x140bd67d0
01076881 test       eax, eax
01076883 jne        0x141076ae8
01076889 cmp        byte ptr [rsp + 0x45], sil
0107688e jne        0x1410768e9
01076890 mov        rcx, qword ptr [rsp + 0x48]
01076895 lea        rdx, [rbp - 0x70]
01076899 call       0x140bd6640
0107689e test       eax, eax
010768a0 jne        0x141076ae8
010768a6 cmp        byte ptr [rsp + 0x45], sil
010768ab je         0x1410768c6
010768ad mov        rcx, qword ptr [rsp + 0x60]
010768b2 mov        rax, qword ptr [rsp + 0x78]
010768b7 cmp        rcx, rax
010768ba jbe        0x1410768c0
010768bc mov        eax, esi
010768be jmp        0x1410768ce
010768c0 sub        eax, ecx
010768c2 inc        eax
010768c4 jmp        0x1410768ce
010768c6 mov        eax, dword ptr [rsp + 0x60]
010768ca sub        eax, dword ptr [rsp + 0x70]
010768ce movsxd     rdx, eax
010768d1 add        rdx, qword ptr [rbp - 0x70]
010768d5 mov        rax, qword ptr [rsp + 0x30]
010768da cmp        rdx, rax
010768dd jbe        0x1410768ee
010768df mov        rax, rdx
010768e2 mov        qword ptr [rsp + 0x30], rdx
010768e7 jmp        0x1410768ee
010768e9 mov        rax, qword ptr [rsp + 0x30]
010768ee xor        edx, edx
010768f0 mov        dword ptr [rbp - 0x58], eax
010768f3 lea        rcx, [rsp + 0x40]
010768f8 mov        byte ptr [rbp - 0x1d], 1
010768fc call       0x140ba09a0
01076901 test       eax, eax
01076903 jne        0x141076ae8
01076909 lea        rcx, [rbp - 0x60]
0107690d call       0x141068f90
01076912 lea        r8, [rbp - 0x60]
01076916 lea        rdx, [rsp + 0x38]
0107691b lea        rcx, [rsp + 0x40]
01076920 call       0x140ba04c0
01076925 test       eax, eax
01076927 jne        0x141076ae8
0107692d lea        rcx, [rsp + 0x40]
01076932 call       0x140ba0000
01076937 test       eax, eax
01076939 jne        0x141076ae8
0107693f xor        edx, edx
01076941 mov        rcx, rdi
01076944 call       0x140ba09a0
01076949 test       eax, eax
0107694b jne        0x141076ae8
01076951 xor        edx, edx
01076953 lea        rcx, [rsp + 0x40]
01076958 call       0x140ba09a0
0107695d test       eax, eax
0107695f jne        0x141076ae8
01076965 lea        rax, [rsp + 0x40]
0107696a mov        qword ptr [rbx + 0x30], rax
0107696e mov        r8, qword ptr [rbx + 0x20]
01076972 mov        rdx, qword ptr [rbx + 0x18]
01076976 mov        rcx, qword ptr [rbx + 0x30]
0107697a mov        rax, qword ptr [rbx + 0x28]
0107697e mov        qword ptr [rbp - 0x58], rcx
01076982 mov        qword ptr [rbp - 0x48], rdx
01076986 mov        qword ptr [rbp - 0x38], r8
0107698a mov        qword ptr [rbp - 0x18], rax
0107698e mov        qword ptr [rbp - 0x60], 0x62776266
01076996 mov        qword ptr [rbp - 0x50], 1
0107699e cmp        byte ptr [rbx + 0x38], sil
010769a2 je         0x1410769c5
010769a4 lea        r9, [rbx + 0x40]
010769a8 lea        rax, [rbx + 0x260]
010769af mov        qword ptr [rsp + 0x28], rax
010769b4 mov        qword ptr [rsp + 0x20], r9
010769b9 movzx      r9d, byte ptr [rbx + 0x39]
010769be call       0x1410760a0
010769c3 jmp        0x1410769f7
010769c5 lea        rax, [rbx + 0x268]
010769cc mov        dword ptr [rbp - 0x40], 0x686f6f6b
010769d3 lea        rcx, [rbp - 0x60]
010769d7 mov        qword ptr [rbp - 0x20], rax
010769db mov        dword ptr [rbp - 0x3c], 0x686b6462
010769e2 mov        qword ptr [rbp - 0x30], 0x90
010769ea mov        qword ptr [rbp - 0x28], 0x19000
010769f2 call       0x140ba0ac0
010769f7 mov        dword ptr [rbx], eax
010769f9 test       eax, eax
010769fb jne        0x141076ae8
01076a01 mov        rdx, qword ptr [rbx + 0x28]
01076a05 xor        ecx, ecx
01076a07 call       0x140b9b860
01076a0c mov        rsi, rax
01076a0f test       rax, rax
01076a12 je         0x141076ae8
01076a18 mov        rcx, rax
; range 0x1076a1b..0x1076ae8 (exclusive)
01076a1b mov        qword ptr [rsp + 0x140], r14
01076a23 call       qword ptr [rip + 0x87261f]
01076a29 mov        rdi, rax
01076a2c test       rax, rax
01076a2f je         0x141076a98
01076a31 mov        rcx, rax
01076a34 call       qword ptr [rip + 0x872616]
01076a3a test       rax, rax
01076a3d jne        0x141076a44
01076a3f mov        rcx, rdi
01076a42 jmp        0x141076a92
01076a44 mov        rcx, rax
01076a47 call       qword ptr [rip + 0x8723cb]
01076a4d mov        rcx, rdi
01076a50 mov        r14, rax
01076a53 call       qword ptr [rip + 0x8723c7]
01076a59 test       r14, r14
01076a5c je         0x141076a98
01076a5e lea        rcx, [rip + 0xa3b553]
01076a65 call       qword ptr [rip + 0x87244d]
01076a6b lea        rcx, [rip + 0xae275e]
01076a72 mov        rdi, rax
01076a75 call       qword ptr [rip + 0x87243d]
01076a7b test       rax, rax
01076a7e je         0x141076a8f
01076a80 mov        r8, rdi
01076a83 mov        rdx, r14
01076a86 mov        rcx, rax
01076a89 call       qword ptr [rip + 0x872701]
01076a8f mov        rcx, r14
01076a92 call       qword ptr [rip + 0x872388]
01076a98 mov        rax, qword ptr [rip + 0x8723c1]
01076a9f lea        rcx, [rip + 0xa3b512]
01076aa6 mov        rdi, qword ptr [rax]
01076aa9 mov        rax, qword ptr [rip + 0x8723b8]
01076ab0 mov        r14, qword ptr [rax]
01076ab3 call       qword ptr [rip + 0x8723ff]
01076ab9 test       rax, rax
01076abc je         0x141076ad7
01076abe test       r14, r14
01076ac1 je         0x141076ad7
01076ac3 test       rdi, rdi
01076ac6 je         0x141076ad7
01076ac8 mov        r8, rdi
01076acb mov        rdx, r14
01076ace mov        rcx, rax
01076ad1 call       qword ptr [rip + 0x8728d1]
01076ad7 mov        rcx, rsi
01076ada call       qword ptr [rip + 0x872340]
01076ae0 mov        r14, qword ptr [rsp + 0x140]
; range 0x1076ae8..0x1076afe (exclusive)
01076ae8 cmp        byte ptr [rbx + 0x38], 0
01076aec mov        rdi, qword ptr [rsp + 0x170]
01076af4 mov        rsi, qword ptr [rsp + 0x168]
01076afc jne        0x141076b08
; range 0x1076afe..0x1076b55 (exclusive)
01076afe lea        rcx, [rsp + 0x40]
01076b03 call       0x140ba02c0
01076b08 lea        rax, [rbx + 4]
01076b0c test       rax, rax
01076b0f je         0x141076b3f
01076b11 cmp        dword ptr [rax], 0x63636d70
01076b17 jne        0x141076b3f
01076b19 mov        ecx, dword ptr [rbx + 0x10]
01076b1c prefetchw  byte ptr [rbx + 0xc]
01076b20 mov        r8d, dword ptr [rbx + 0xc]
01076b24 mov        edx, r8d
01076b27 or         edx, 1
01076b2a mov        eax, r8d
01076b2d lock cmpxchg dword ptr [rbx + 0xc], edx
01076b32 jne        0x141076b20
01076b34 test       r8b, 2
01076b38 je         0x141076b3f
01076b3a call       0x140b07d90
01076b3f mov        rcx, qword ptr [rbp + 0x30]
01076b43 xor        rcx, rsp
01076b46 call       0x14179b8e0
01076b4b add        rsp, 0x148
01076b52 pop        rbx
01076b53 pop        rbp
01076b54 ret        
