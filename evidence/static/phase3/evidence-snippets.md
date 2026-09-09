# Exact C/ASM evidence

## phase3/decompiled/00ec75b0.c L56-107
SHA256 `5e0687f899a21fe2fb68d156e364b9ea6f461ae46d0bdac8b347a5363be999fa`
```c
56:   if (((*(byte *)(lVar10 + 0x9a) & 0x10) != 0) && (param_1 == *(longlong *)(lVar10 + 0x58))) {
57:     sStack_258 = 0;
58:     if ((*(longlong *)(lVar10 + 0x10) != 0) &&
59:        ((FUN_140bff470(*(longlong *)(lVar10 + 0x10) + 0x178,*(undefined4 *)(lVar10 + 0xb0),
60:                        &sStack_258), sStack_258 != 0 && (*(char *)(param_1 + 0x298) != '\0')))) {
61:       piVar14 = (int *)(param_1 + 0x78);
62:       uStack_458 = 0;
63:       if ((piVar14 != (int *)0x0) &&
64:          ((*(longlong *)(param_1 + 0x88) != 0 &&
65:           ((*piVar14 == 0x41464350 || (*piVar14 == 0x57696e50)))))) {
66:         (**(code **)(*(longlong *)(param_1 + 0x88) + 0x10))(piVar14,&uStack_458);
67:       }
68:       uStack_498 = 0;
69:       cVar5 = FUN_140ae4f40(auStack_456,uStack_458,auStack_256,sStack_258);
70:       if (cVar5 == '\0') {
71:         FUN_140ae48a0(&uStack_458,0);
72:         uStack_498 = 0;
73:         cVar5 = FUN_140ae4f40(auStack_456,uStack_458,auStack_256,sStack_258);
74:         if (cVar5 == '\0') {
75:           lVar9 = *(longlong *)(lVar10 + 0x10);
76:           if (lVar9 != 0) {
77:             piVar14 = (int *)(lVar9 + 0x178);
78:             if (uStack_458 < 0x100) {
79:               if (((piVar14 != (int *)0x0) && (*piVar14 == 0x73747263)) &&
80:                  (*(int *)(lVar9 + 0x1a0) == 0)) {
81:                 iVar7 = *(int *)(lVar10 + 0xb0);
82:                 lVar8 = (longlong)iVar7;
83:                 if (*(int *)(lVar9 + 0x1b4) == 0) {
84:                   if (iVar7 != 0) {
85:                     if ((iVar7 < 1) || (*(int *)(lVar9 + 0x1a4) < iVar7)) goto LAB_140ec77c1;
86:                     if ((*(byte *)(lVar9 + 0x17c) & 1) != 0) {
87:                       piVar2 = (int *)(**(longlong **)(lVar9 + 400) + -4 + lVar8 * 4);
88:                       *piVar2 = *piVar2 + -1;
89:                       if (*piVar2 != 0) goto LAB_140ec77ad;
90:                     }
91:                     lVar3 = **(longlong **)(lVar9 + 0x188);
92:                     *(int *)(lVar9 + 0x1b8) =
93:                          *(int *)(lVar9 + 0x1b8) + *(int *)(lVar3 + -4 + lVar8 * 8);
94:                     *(undefined4 *)(lVar3 + -8 + lVar8 * 8) = 0x80000001;
95:                   }
96: LAB_140ec77ad:
97:                   FUN_140bfe1f0(piVar14,auStack_456,(uint)uStack_458 * 2,lVar10 + 0xb0);
98:                 }
99:               }
100:             }
101:             else {
102:               *(undefined4 *)(lVar10 + 0xb0) = 0;
103:             }
104: LAB_140ec77c1:
105:             FUN_140ec7b80(lVar10,0);
106:           }
107:           abStack_480[0] = abStack_480[0] | 0x20;
```

## phase3/decompiled/00ec8180.c L98-120
SHA256 `3832fdd716c554f9dfefb88ef45ed0fc2e9b0a0761fa41a3f7df8c97cbcb4e92`
```c
98:   if (*param_1 == 0) goto LAB_140ec8fa8;
99:   if ((((*param_1 & 1) == 0) || ((short)param_1[2] == 0)) || ((*(byte *)(lVar3 + 0x9a) & 0x20) != 0)
100:      ) {
101: LAB_140ec82e4:
102:     uVar14 = CONCAT13(bStack_2a5,CONCAT12(bStack_2a6,CONCAT11(bStack_2a7,bStack_2a8)));
103:   }
104:   else {
105:     if ((param_3 & 1) == 0) {
106:       uStack_258 = 0;
107:       if (*(longlong *)(lVar3 + 0x10) != 0) {
108:         FUN_140bff470(*(longlong *)(lVar3 + 0x10) + 0x178,*(undefined4 *)(lVar3 + 0xb0),&uStack_258)
109:         ;
110:       }
111:       uStack_2c8 = 0x20;
112:       cVar4 = FUN_140ae4f40((byte *)((longlong)param_1 + 10),(short)param_1[2],auStack_256,
113:                             uStack_258);
114:       if (cVar4 != '\0') goto LAB_140ec82e4;
115:     }
116:     FUN_140f91680(lVar3,param_1 + 2,0);
117:     uVar13 = 1;
118:     bStack_2a8 = bStack_2a8 | 0x20;
119:     uVar14 = (uint)bStack_2a8;
120:     *(byte *)(lVar3 + 0x9a) = *(byte *)(lVar3 + 0x9a) & 0xef;
```

## phase3/decompiled2/00eb9b10.c L42-55
SHA256 `67f44448e55ef0c84fb1918ec3b6be3629312db555e61324bd1daf4103740494`
```c
42:   if (((param_1 == 0) || (lVar4 = *(longlong *)(param_1 + 8), lVar4 == 0)) ||
43:      (lVar5 = *(longlong *)(lVar4 + 0x10), lVar5 == 0)) {
44:     return 0xffffffce;
45:   }
46:   if (*(int *)(lVar4 + 0xb0) != 0) {
47:     return uVar9 & 0xffffffff;
48:   }
49:   if ((*(int *)(lVar5 + 0x80) == 0x74646174) && (*(int *)(lVar5 + 0x84) != 0x646f5069)) {
50:     *(byte *)(lVar4 + 0x9a) = *(byte *)(lVar4 + 0x9a) | 0x10;
51:   }
52:   uStack_248 = 0;
53:   if (((param_2 != (int *)0x0) && (*(longlong *)(param_2 + 4) != 0)) &&
54:      ((*param_2 == 0x41464350 || (*param_2 == 0x57696e50)))) {
55:     (**(code **)(*(longlong *)(param_2 + 4) + 0x10))(param_2,&uStack_248);
```

## phase3/decompiled2/00ec7b80.c L35-57
SHA256 `2333a232c23e6a6ee20ba53a6ea29c2dc66b46ad94f9f04d681bc3662ac31bc2`
```c
35:   pcStack_88 = FUN_140eb80a0;
36:   lStack_70 = param_1 + 0x92;
37:   uStack_98 = 0;
38:   uStack_48 = 0x200000000000;
39:   uStack_40 = 0;
40:   uStack_94 = 2;
41:   uStack_90 = 0x4e;
42:   uStack_8c = 0x1e;
43:   *(undefined1 *)(param_1 + 0xa1) = 0;
44:   *(undefined4 *)(param_1 + 0xe0) = 0;
45:   uStack_50 = *(undefined4 *)(param_1 + 0x160);
46:   uStack_28 = 1;
47:   uStack_20 = 0;
48:   uStack_38 = 0x8000000000000;
49:   uStack_30 = 0;
50:   if (lVar1 != 0) {
51:     lStack_58 = lVar1 + 0x1768;
52:     lStack_68 = lVar1 + 0x178;
53:     lStack_60 = param_1 + 0xb0;
54:     puStack_78 = (undefined1 *)(param_1 + 0xa1);
55:   }
56:   lStack_80 = param_1;
57:   FUN_140eb8630(&uStack_98);
```

## decompiled/0107b460.c L471-483
SHA256 `0473d0cdbc555a40354e3dfaf4a8f54a4f2aceb11622f96ed8468bfe83660a13`
```c
471:         *(undefined1 *)(uVar13 + 0x104) = uStack_60c;
472:         *(byte *)(uVar13 + 0x9b) = (bStack_625 & 1) << 2 | *(byte *)(uVar13 + 0x9b) & 0xfb;
473:         *(byte *)(uVar13 + 0x9a) = (bStack_60b & 1) << 4 | *(byte *)(uVar13 + 0x9a) & 0xef;
474:         *(undefined2 *)(pcVar4 + 0x4c) = uStack_640;
475:         *(undefined4 *)(pcVar4 + 0x48) = uStack_5e0;
476:         *(undefined2 *)(pcVar4 + 0x4e) = uStack_46e;
477:         *(undefined2 *)(uVar13 + 0x102) = uStack_638;
478:         *(undefined4 *)(uVar13 + 0xfc) = uStack_604;
479:         uStack_768 = uVar13;
480:         pcStack_6c0 = pcVar4;
481:         uVar7 = func_0x00014106a990(uStack_628);
482:         *(undefined2 *)(pcVar4 + 0x50) = uVar7;
483:         *(byte *)(uVar13 + 0x9a) = (bStack_60a & 1) << 2 | *(byte *)(uVar13 + 0x9a) & 0xfb;
```

## decompiled/0106daf0.c L172-178
SHA256 `19aaec8cdadd024da5e10f2fc91642a657999982ef4725be5df1f3aac6ffb547`
```c
172:   *(undefined4 *)(param_1 + 0xa003b8) = *(undefined4 *)(puVar4 + 0x1c);
173:   *(undefined4 *)(param_1 + 0xa003bc) = *(undefined4 *)((longlong)puVar4 + 0xe4);
174:   *(undefined4 *)(param_1 + 0xa003c0) = *(undefined4 *)(puVar4 + 0x1d);
175:   *(undefined4 *)(param_1 + 0xa003c4) = *(undefined4 *)((longlong)puVar4 + 0xec);
176:   *(undefined4 *)(param_1 + 0xa003c8) = *(undefined4 *)(puVar4 + 0x1e);
177:   *(undefined4 *)(param_1 + 0xa003cc) = *(undefined4 *)((longlong)puVar4 + 0xf4);
178:   *(undefined4 *)(param_1 + 0xa003d0) = *(undefined4 *)(puVar4 + 0x1f);
```

## Original ASM
Use asm/00ec75b0.asm, asm/00ec8180.asm, asm/00ec7b80.asm, asm/00eb9b10.asm and change-mask-dispatcher-00ed6940.asm. Sort descriptor: sort-descriptor-verified-code.asm ends at eb855a; table at eb855c is data. Initial helper-00eb8130-entry.asm linear listing includes accidental table decoding at its tail; do not use that tail as instructions. helper-00f91680-entry.asm shows Name assignment/refcount and optional invalidation callback.
