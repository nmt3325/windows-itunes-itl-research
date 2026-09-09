; Original iTunes.exe machine code; base=0x140000000; RVA=0xbf9710; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0xbf9710..0xbf9a87 (exclusive)
00bf9710 mov        qword ptr [rsp + 8], rbx
00bf9715 mov        qword ptr [rsp + 0x10], rbp
00bf971a mov        qword ptr [rsp + 0x18], rsi
00bf971f mov        qword ptr [rsp + 0x20], rdi
00bf9724 lea        rbp, [rip + 0x14d95f5]
00bf972b mov        dl, 1
00bf972d mov        r9, rbp
00bf9730 lea        rsi, [rip - 0xbf9737]
00bf9737 xor        r8d, r8d
00bf973a mov        ebx, 0x100
00bf973f nop        
00bf9740 movzx      eax, dl
00bf9743 movzx      ecx, dl
00bf9746 mov        byte ptr [r9], dl
00bf9749 lea        r9, [r9 + 1]
00bf974d sar        cl, 7
00bf9750 and        cl, 0x1b
00bf9753 mov        byte ptr [rax + rsi + 0x20d2e20], r8b
00bf975b movzx      eax, dl
00bf975e add        al, al
00bf9760 inc        r8d
00bf9763 xor        cl, al
00bf9765 xor        dl, cl
00bf9767 cmp        r8d, ebx
00bf976a jb         0x140bf9740
00bf976c mov        byte ptr [rip + 0x14d96ae], 0
00bf9773 lea        r11, [rip + 0x14d96a5]
00bf977a mov        dword ptr [rip + 0x14d999c], 1
00bf9784 xor        r9d, r9d
00bf9787 mov        dword ptr [rip + 0x14d9993], 2
00bf9791 mov        dword ptr [rip + 0x14d998d], 4
00bf979b mov        dword ptr [rip + 0x14d9987], 8
00bf97a5 mov        dword ptr [rip + 0x14d9981], 0x10
00bf97af mov        dword ptr [rip + 0x14d997b], 0x20
00bf97b9 mov        dword ptr [rip + 0x14d9975], 0x40
00bf97c3 mov        dword ptr [rip + 0x14d996f], 0x80
00bf97cd mov        dword ptr [rip + 0x14d9969], 0x1b
00bf97d7 mov        dword ptr [rip + 0x14d9963], 0x36
00bf97e1 test       r9d, r9d
00bf97e4 je         0x140bf97fb
00bf97e6 movzx      eax, byte ptr [r9 + rsi + 0x20d2e20]
00bf97ef mov        rcx, r11
00bf97f2 sub        rcx, rax
00bf97f5 movzx      r8d, byte ptr [rcx]
00bf97f9 jmp        0x140bf97fe
00bf97fb xor        r8b, r8b
00bf97fe movzx      ecx, r8b
00bf9802 movzx      eax, r8b
00bf9806 ror        al, 7
00bf9809 movzx      edx, cl
00bf980c xor        r8b, al
00bf980f ror        dl, 6
00bf9812 movzx      eax, cl
00bf9815 ror        cl, 4
00bf9818 ror        al, 5
00bf981b xor        dl, al
00bf981d xor        dl, cl
00bf981f xor        dl, r8b
00bf9822 xor        dl, 0x63
00bf9825 movzx      eax, dl
00bf9828 mov        byte ptr [r9 + rsi + 0x20d2f20], al
00bf9830 mov        byte ptr [rax + rsi + 0x20d3020], r9b
00bf9838 inc        r9d
00bf983b cmp        r9d, ebx
00bf983e jb         0x140bf97e1
00bf9840 xor        ecx, ecx
00bf9842 xor        edi, edi
00bf9844 movzx      edx, byte ptr [rdi + rsi + 0x20d2f20]
00bf984c mov        eax, edx
00bf984e mov        dword ptr [rcx + rsi + 0x20d5150], edx
00bf9855 rol        eax, 8
00bf9858 mov        r10d, edx
00bf985b mov        dword ptr [rcx + rsi + 0x20d5550], eax
00bf9862 mov        eax, edx
00bf9864 rol        eax, 0x10
00bf9867 shl        r10d, 8
00bf986b mov        dword ptr [rcx + rsi + 0x20d5950], eax
00bf9872 or         r10d, edx
00bf9875 mov        eax, edx
00bf9877 shl        r10d, 8
00bf987b rol        eax, 0x18
00bf987e mov        dword ptr [rcx + rsi + 0x20d5d50], eax
00bf9885 test       dl, dl
00bf9887 je         0x140bf98ee
00bf9889 movzx      r8d, byte ptr [rdx + rsi + 0x20d2e20]
00bf9892 mov        r9d, edx
00bf9895 movzx      eax, byte ptr [rip + 0x14d9587]
00bf989c add        r8d, eax
00bf989f mov        eax, 0x80808081
00bf98a4 mul        r8d
00bf98a7 shr        edx, 7
00bf98aa imul       eax, edx, 0xff
00bf98b0 sub        r8d, eax
00bf98b3 movsxd     rax, r8d
00bf98b6 movzx      r8d, byte ptr [r9 + rsi + 0x20d2e20]
00bf98bf movzx      r11d, byte ptr [rax + rbp]
00bf98c4 movzx      eax, byte ptr [rip + 0x14d9557]
00bf98cb add        r8d, eax
00bf98ce mov        eax, 0x80808081
00bf98d3 mul        r8d
00bf98d6 shr        edx, 7
00bf98d9 imul       eax, edx, 0xff
00bf98df sub        r8d, eax
00bf98e2 movsxd     rax, r8d
00bf98e5 movzx      edx, byte ptr [rax + rbp]
00bf98e9 or         edx, r10d
00bf98ec jmp        0x140bf98f4
00bf98ee xor        r11d, r11d
00bf98f1 mov        edx, r10d
00bf98f4 shl        r11d, 0x18
00bf98f8 or         r11d, edx
00bf98fb mov        dword ptr [rcx + rsi + 0x20d3150], r11d
00bf9903 mov        eax, r11d
00bf9906 rol        eax, 8
00bf9909 mov        dword ptr [rcx + rsi + 0x20d3550], eax
00bf9910 mov        eax, r11d
00bf9913 rol        eax, 0x10
00bf9916 mov        dword ptr [rcx + rsi + 0x20d3950], eax
00bf991d rol        r11d, 0x18
00bf9921 mov        dword ptr [rcx + rsi + 0x20d3d50], r11d
00bf9929 movzx      edx, byte ptr [rdi + rsi + 0x20d3020]
00bf9931 mov        eax, edx
00bf9933 mov        dword ptr [rcx + rsi + 0x20d6150], edx
00bf993a rol        eax, 8
00bf993d mov        dword ptr [rcx + rsi + 0x20d6550], eax
00bf9944 mov        eax, edx
00bf9946 rol        eax, 0x10
00bf9949 mov        dword ptr [rcx + rsi + 0x20d6950], eax
00bf9950 mov        eax, edx
00bf9952 rol        eax, 0x18
00bf9955 mov        dword ptr [rcx + rsi + 0x20d6d50], eax
00bf995c test       dl, dl
00bf995e je         0x140bf9a26
00bf9964 movzx      r10d, byte ptr [rdx + rsi + 0x20d2e20]
00bf996d lea        r9, [rdx + 0x20d2e20]
00bf9974 movzx      r8d, byte ptr [r9 + rsi]
00bf9979 movzx      eax, byte ptr [rip + 0x14d94ab]
00bf9980 add        r8d, eax
00bf9983 mov        eax, 0x80808081
00bf9988 mul        r8d
00bf998b shr        edx, 7
00bf998e imul       eax, edx, 0xff
00bf9994 sub        r8d, eax
00bf9997 movsxd     rax, r8d
00bf999a movzx      r8d, byte ptr [r9 + rsi]
00bf999f movzx      r11d, byte ptr [rax + rbp]
00bf99a4 movzx      eax, byte ptr [rip + 0x14d9482]
00bf99ab add        r8d, eax
00bf99ae mov        eax, 0x80808081
00bf99b3 mul        r8d
00bf99b6 shr        edx, 7
00bf99b9 imul       eax, edx, 0xff
00bf99bf sub        r8d, eax
00bf99c2 movsxd     rax, r8d
00bf99c5 movzx      r8d, byte ptr [rip + 0x14d945c]
00bf99cd add        r8d, r10d
00bf99d0 movzx      r9d, byte ptr [rax + rbp]
00bf99d5 mov        eax, 0x80808081
00bf99da mul        r8d
00bf99dd shl        r9d, 8
00bf99e1 shr        edx, 7
00bf99e4 imul       eax, edx, 0xff
00bf99ea sub        r8d, eax
00bf99ed movsxd     rax, r8d
00bf99f0 movzx      r8d, byte ptr [rip + 0x14d9436]
00bf99f8 add        r8d, r10d
00bf99fb movzx      edx, byte ptr [rax + rbp]
00bf99ff mov        eax, 0x80808081
00bf9a04 or         r9d, edx
00bf9a07 mul        r8d
00bf9a0a shl        r9d, 8
00bf9a0e shr        edx, 7
00bf9a11 imul       eax, edx, 0xff
00bf9a17 sub        r8d, eax
00bf9a1a movsxd     rax, r8d
00bf9a1d movzx      edx, byte ptr [rax + rbp]
00bf9a21 or         r9d, edx
00bf9a24 jmp        0x140bf9a2c
00bf9a26 xor        r11d, r11d
00bf9a29 xor        r9d, r9d
00bf9a2c shl        r11d, 0x18
00bf9a30 inc        rdi
00bf9a33 or         r11d, r9d
00bf9a36 mov        eax, r11d
00bf9a39 mov        dword ptr [rcx + rsi + 0x20d4150], r11d
00bf9a41 rol        eax, 8
00bf9a44 mov        dword ptr [rcx + rsi + 0x20d4550], eax
00bf9a4b mov        eax, r11d
00bf9a4e rol        eax, 0x10
00bf9a51 rol        r11d, 0x18
00bf9a55 mov        dword ptr [rcx + rsi + 0x20d4950], eax
00bf9a5c mov        dword ptr [rcx + rsi + 0x20d4d50], r11d
00bf9a64 add        rcx, 4
00bf9a68 sub        rbx, 1
00bf9a6c jne        0x140bf9844
00bf9a72 mov        rbx, qword ptr [rsp + 8]
00bf9a77 mov        rbp, qword ptr [rsp + 0x10]
00bf9a7c mov        rsi, qword ptr [rsp + 0x18]
00bf9a81 mov        rdi, qword ptr [rsp + 0x20]
00bf9a86 ret        
