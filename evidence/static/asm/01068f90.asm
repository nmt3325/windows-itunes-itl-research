; Original iTunes.exe machine code; base=0x140000000; RVA=0x1068f90; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x1068f90..0x10690cf (exclusive)
01068f90 mov        eax, dword ptr [rcx]
01068f92 mov        r8, rcx
01068f95 bswap      eax
01068f97 mov        dword ptr [rcx], eax
01068f99 mov        eax, dword ptr [rcx + 4]
01068f9c bswap      eax
01068f9e mov        dword ptr [rcx + 4], eax
01068fa1 mov        eax, dword ptr [rcx + 8]
01068fa4 bswap      eax
01068fa6 mov        dword ptr [rcx + 8], eax
01068fa9 movzx      eax, word ptr [rcx + 0xc]
01068fad ror        ax, 8
01068fb1 mov        word ptr [rcx + 0xc], ax
01068fb5 movzx      eax, word ptr [rcx + 0xe]
01068fb9 ror        ax, 8
01068fbd mov        word ptr [rcx + 0xe], ax
01068fc1 mov        eax, dword ptr [rcx + 0x30]
01068fc4 bswap      eax
01068fc6 mov        dword ptr [rcx + 0x30], eax
01068fc9 mov        rax, qword ptr [rcx + 0x34]
01068fcd bswap      rax
01068fd0 mov        qword ptr [rcx + 0x34], rax
01068fd4 mov        eax, dword ptr [rcx + 0x3c]
01068fd7 bswap      eax
01068fd9 mov        dword ptr [rcx + 0x3c], eax
01068fdc mov        eax, dword ptr [rcx + 0x44]
01068fdf bswap      eax
01068fe1 mov        dword ptr [rcx + 0x44], eax
01068fe4 mov        eax, dword ptr [rcx + 0x48]
01068fe7 bswap      eax
01068fe9 mov        dword ptr [rcx + 0x48], eax
01068fec mov        eax, dword ptr [rcx + 0x4c]
01068fef bswap      eax
01068ff1 mov        dword ptr [rcx + 0x4c], eax
01068ff4 movzx      eax, word ptr [rcx + 0x50]
01068ff8 ror        ax, 8
01068ffc mov        word ptr [rcx + 0x50], ax
01069000 mov        ecx, dword ptr [rcx + 0x54]
01069003 mov        edx, ecx
01069005 and        edx, 0xff0000
0106900b mov        eax, ecx
0106900d shr        eax, 0x10
01069010 or         edx, eax
01069012 mov        eax, ecx
01069014 shl        eax, 0x10
01069017 and        ecx, 0xff00
0106901d or         eax, ecx
0106901f shr        edx, 8
01069022 shl        eax, 8
01069025 or         edx, eax
01069027 mov        dword ptr [r8 + 0x54], edx
0106902b mov        ecx, dword ptr [r8 + 0x58]
0106902f mov        edx, ecx
01069031 and        edx, 0xff0000
01069037 mov        eax, ecx
01069039 shr        eax, 0x10
0106903c or         edx, eax
0106903e mov        eax, ecx
01069040 shl        eax, 0x10
01069043 and        ecx, 0xff00
01069049 or         eax, ecx
0106904b shr        edx, 8
0106904e shl        eax, 8
01069051 or         edx, eax
01069053 mov        dword ptr [r8 + 0x58], edx
01069057 mov        ecx, dword ptr [r8 + 0x5c]
0106905b mov        edx, ecx
0106905d and        edx, 0xff0000
01069063 mov        eax, ecx
01069065 shr        eax, 0x10
01069068 or         edx, eax
0106906a mov        eax, ecx
0106906c shl        eax, 0x10
0106906f and        ecx, 0xff00
01069075 or         eax, ecx
01069077 shr        edx, 8
0106907a shl        eax, 8
0106907d or         edx, eax
0106907f mov        dword ptr [r8 + 0x5c], edx
01069083 mov        ecx, dword ptr [r8 + 0x60]
01069087 mov        edx, ecx
01069089 mov        eax, ecx
0106908b and        edx, 0xff0000
01069091 shr        eax, 0x10
01069094 or         edx, eax
01069096 mov        eax, ecx
01069098 shl        eax, 0x10
0106909b and        ecx, 0xff00
010690a1 or         eax, ecx
010690a3 shr        edx, 8
010690a6 shl        eax, 8
010690a9 or         edx, eax
010690ab mov        dword ptr [r8 + 0x60], edx
010690af mov        eax, dword ptr [r8 + 0x64]
010690b3 bswap      eax
010690b5 mov        dword ptr [r8 + 0x64], eax
010690b9 mov        rax, qword ptr [r8 + 0x68]
010690bd bswap      rax
010690c0 mov        qword ptr [r8 + 0x68], rax
010690c4 mov        eax, dword ptr [r8 + 0x70]
010690c8 bswap      eax
010690ca mov        dword ptr [r8 + 0x70], eax
010690ce ret        
