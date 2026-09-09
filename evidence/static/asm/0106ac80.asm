; Original iTunes.exe machine code; base=0x140000000; RVA=0x106ac80; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d
; range 0x106ac80..0x106aec4 (exclusive)
0106ac80 mov        qword ptr [rsp + 8], rbx
0106ac85 mov        qword ptr [rsp + 0x10], rbp
0106ac8a mov        qword ptr [rsp + 0x18], rsi
0106ac8f mov        qword ptr [rsp + 0x20], rdi
0106ac94 push       r12
0106ac96 push       r14
0106ac98 push       r15
0106ac9a sub        rsp, 0x20
0106ac9e mov        r15, qword ptr [rsp + 0x70]
0106aca3 xor        eax, eax
0106aca5 mov        ebp, r8d
0106aca8 mov        r14, rdx
0106acab mov        r12, rcx
0106acae mov        r11b, 1
0106acb1 mov        rbx, qword ptr [r15]
0106acb4 lea        r10, [rbx + 0x18]
0106acb8 mov        rsi, r10
0106acbb test       rbx, rbx
0106acbe je         0x14106acc6
0106acc0 mov        dword ptr [rbx + 8], eax
0106acc3 mov        dword ptr [rbx + 0x14], eax
0106acc6 mov        ecx, dword ptr [rsp + 0x60]
0106acca mov        dword ptr [rbx], 0x686f686d
0106acd0 mov        dword ptr [rbx + 4], 0x18
0106acd7 mov        dword ptr [rbx + 0xc], ecx
0106acda mov        dword ptr [rbx + 0x10], r9d
0106acde cmp        ecx, 1
0106ace1 je         0x14106adf2
0106ace7 cmp        ecx, 0x42
0106acea je         0x14106adf2
0106acf0 cmp        ecx, 0x13
0106acf3 je         0x14106adf2
0106acf9 lea        rsi, [r10 + 0x10]
0106acfd test       r10, r10
0106ad00 je         0x14106ad09
0106ad02 xorps      xmm0, xmm0
0106ad05 movups     xmmword ptr [r10], xmm0
0106ad09 mov        edi, dword ptr [rsp + 0x68]
0106ad0d cmp        edi, 1
0106ad10 jne        0x14106ad7f
0106ad12 cmp        ebp, 0x1fe
0106ad18 ja         0x14106ad8a
0106ad1a mov        r9d, ebp
0106ad1d mov        edi, 3
0106ad22 shr        r9d, 1
0106ad25 mov        r8, r14
0106ad28 mov        rcx, rsi
0106ad2b je         0x14106ad6f
0106ad2d mov        r11d, 0x100
0106ad33 nop        dword ptr [rax]
0106ad37 nop        word ptr [rax + rax]
0106ad40 movzx      edx, word ptr [r8]
0106ad44 lea        r8, [r8 + 2]
0106ad48 cmp        dx, r11w
0106ad4c jae        0x14106ad6a
0106ad4e mov        byte ptr [rcx], dl
0106ad50 inc        eax
0106ad52 inc        rcx
0106ad55 cmp        eax, r9d
0106ad58 jb         0x14106ad40
0106ad5a cmp        edi, 3
0106ad5d cmovne     r9d, ebp
0106ad61 setne      r11b
0106ad65 mov        ebp, r9d
0106ad68 jmp        0x14106ad8a
0106ad6a mov        edi, 1
0106ad6f cmp        edi, 3
0106ad72 cmovne     r9d, ebp
0106ad76 setne      r11b
0106ad7a mov        ebp, r9d
0106ad7d jmp        0x14106ad8a
0106ad7f cmp        edi, 4
0106ad82 mov        eax, 1
0106ad87 cmove      edi, eax
0106ad8a mov        edx, edi
0106ad8c mov        dword ptr [r10], edi
0106ad8f mov        r8d, ebp
0106ad92 shr        edx, 0x18
0106ad95 shr        r8d, 0x18
0106ad99 mov        dword ptr [rbx + 0x1c], ebp
0106ad9c cmp        byte ptr [r12 + 0x52], 0
0106ada2 jne        0x14106adeb
0106ada4 mov        ecx, edi
0106ada6 mov        eax, edi
0106ada8 and        ecx, 0xff00
0106adae shl        eax, 0x10
0106adb1 or         ecx, eax
0106adb3 mov        eax, edi
0106adb5 shl        ecx, 8
0106adb8 shr        eax, 8
0106adbb and        eax, 0xff00
0106adc0 or         ecx, eax
0106adc2 mov        eax, ebp
0106adc4 or         ecx, edx
0106adc6 shl        eax, 0x10
0106adc9 mov        dword ptr [r10], ecx
0106adcc mov        ecx, ebp
0106adce and        ecx, 0xff00
0106add4 or         ecx, eax
0106add6 mov        eax, ebp
0106add8 shr        eax, 8
0106addb and        eax, 0xff00
0106ade0 shl        ecx, 8
0106ade3 or         ecx, eax
0106ade5 or         ecx, r8d
0106ade8 mov        dword ptr [rbx + 0x1c], ecx
0106adeb test       r11b, r11b
0106adee je         0x14106ae0e
0106adf0 jmp        0x14106adf6
0106adf2 mov        edi, dword ptr [rsp + 0x68]
0106adf6 test       r14, r14
0106adf9 je         0x14106ae0e
0106adfb test       rsi, rsi
0106adfe je         0x14106ae0e
0106ae00 mov        r8d, ebp
0106ae03 mov        rdx, r14
0106ae06 mov        rcx, rsi
0106ae09 call       0x141867875
0106ae0e cmp        edi, 1
0106ae11 jne        0x14106ae45
0106ae13 cmp        byte ptr [r12 + 0x52], 0
0106ae19 jne        0x14106ae45
0106ae1b mov        eax, ebp
0106ae1d shr        eax, 1
0106ae1f je         0x14106ae45
0106ae21 mov        rcx, rsi
0106ae24 mov        edx, eax
0106ae26 nop        word ptr [rax + rax]
0106ae30 movzx      eax, word ptr [rcx]
0106ae33 lea        rcx, [rcx + 2]
0106ae37 ror        ax, 8
0106ae3b mov        word ptr [rcx - 2], ax
0106ae3f sub        rdx, 1
0106ae43 jne        0x14106ae30
0106ae45 mov        eax, ebp
0106ae47 add        rsi, rax
0106ae4a mov        edx, esi
0106ae4c sub        edx, ebx
0106ae4e mov        r8d, edx
0106ae51 mov        dword ptr [rbx + 8], edx
0106ae54 shr        r8d, 0x18
0106ae58 cmp        byte ptr [r12 + 0x52], 0
0106ae5e jne        0x14106aea0
0106ae60 mov        eax, dword ptr [rbx]
0106ae62 mov        ecx, edx
0106ae64 bswap      eax
0106ae66 mov        dword ptr [rbx], eax
0106ae68 mov        eax, dword ptr [rbx + 4]
0106ae6b bswap      eax
0106ae6d mov        dword ptr [rbx + 4], eax
0106ae70 mov        eax, edx
0106ae72 and        eax, 0xff00
0106ae77 shl        ecx, 0x10
0106ae7a or         ecx, eax
0106ae7c shr        edx, 8
0106ae7f mov        eax, dword ptr [rbx + 0xc]
0106ae82 and        edx, 0xff00
0106ae88 bswap      eax
0106ae8a shl        ecx, 8
0106ae8d mov        dword ptr [rbx + 0xc], eax
0106ae90 or         ecx, edx
0106ae92 mov        eax, dword ptr [rbx + 0x10]
0106ae95 or         ecx, r8d
0106ae98 bswap      eax
0106ae9a mov        dword ptr [rbx + 0x10], eax
0106ae9d mov        dword ptr [rbx + 8], ecx
0106aea0 mov        rbx, qword ptr [rsp + 0x40]
0106aea5 xor        eax, eax
0106aea7 mov        rbp, qword ptr [rsp + 0x48]
0106aeac mov        rdi, qword ptr [rsp + 0x58]
0106aeb1 mov        qword ptr [r15], rsi
0106aeb4 mov        rsi, qword ptr [rsp + 0x50]
0106aeb9 add        rsp, 0x20
0106aebd pop        r15
0106aebf pop        r14
0106aec1 pop        r12
0106aec3 ret        
