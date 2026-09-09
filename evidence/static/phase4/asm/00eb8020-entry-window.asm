; Bounded original window 0xeb8020..0xeb80a0, not unwind-derived. Instructions after a terminal transfer need boundary review.
00eb8020 488bd1                   mov rdx, rcx
00eb8023 4885c9                   test rcx, rcx
00eb8026 7471                     je 0x140eb8099
00eb8028 81b98000000074616474     cmp dword ptr [rcx + 0x80], 0x74646174
00eb8032 7565                     jne 0x140eb8099
00eb8034 8b8184000000             mov eax, dword ptr [rcx + 0x84]
00eb803a 3d6d757369               cmp eax, 0x6973756d
00eb803f 7714                     ja 0x140eb8055
00eb8041 7443                     je 0x140eb8086
00eb8043 85c0                     test eax, eax
00eb8045 743f                     je 0x140eb8086
00eb8047 3d74756e65               cmp eax, 0x656e7574
00eb804c 7438                     je 0x140eb8086
00eb804e 3d72616469               cmp eax, 0x69646172
00eb8053 eb28                     jmp 0x140eb807d
00eb8055 3d6d656472               cmp eax, 0x7264656d
00eb805a 742a                     je 0x140eb8086
00eb805c 3d7472656d               cmp eax, 0x6d657274
00eb8061 7423                     je 0x140eb8086
00eb8063 3d74656d70               cmp eax, 0x706d6574
00eb8068 741c                     je 0x140eb8086
00eb806a 3d636e7470               cmp eax, 0x70746e63
00eb806f 7415                     je 0x140eb8086
00eb8071 3d73727672               cmp eax, 0x72767273
00eb8076 740e                     je 0x140eb8086
00eb8078 3d69526177               cmp eax, 0x77615269
00eb807d 7407                     je 0x140eb8086
00eb807f 33c9                     xor ecx, ecx
00eb8081 e9fad7ceff               jmp 0x140ba5880
00eb8086 488b81901b0000           mov rax, qword ptr [rcx + 0x1b90]
00eb808d 488d4801                 lea rcx, [rax + 1]
00eb8091 48898a901b0000           mov qword ptr [rdx + 0x1b90], rcx
00eb8098 c3                       ret 
00eb8099 33c0                     xor eax, eax
00eb809b c3                       ret 
00eb809c cc                       int3 
00eb809d cc                       int3 
00eb809e cc                       int3 
00eb809f cc                       int3 