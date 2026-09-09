## phase4/decompiled-first/00f92b80.c L50-69
SHA256 `226c19f6b4dfec72d63cfb933ef303f3088dc453d570f924dffb0b80c080391b`
```c
50:   plVar6 = (longlong *)FUN_140bc62b0(*(undefined8 *)(param_1 + 0x120));
51:   if (plVar6 == (longlong *)0x0) {
52:     return (longlong *)0x0;
53:   }
54:   plVar6[2] = param_1;
55:   LOCK();
56:   UNLOCK();
57:   iVar4 = _DAT_141fe9130 + 1;
58:   *(int *)(plVar6 + 1) = _DAT_141fe9130;
59:   _DAT_141fe9130 = iVar4;
60:   plVar6[0xd] = 0x1420af610;
61:   plVar6[0xe] = 0x1420a7020;
62:   plVar6[0xf] = 0x1420a70a0;
63:   plVar6[0x10] = 0x1420a7060;
64:   if (param_6 == 0) {
65:     param_6 = func_0x000140eb8020(param_1);
66:   }
67:   *plVar6 = param_6;
68:   *(undefined4 *)(plVar6 + 0x15) = *(undefined4 *)(_DAT_1420a6f30 + 0x15558);
69:   lVar7 = FUN_140fa5b70(plVar6,param_2,param_5);
```

## phase4/decompiled-second/00fa5b70.c L19-43
SHA256 `91b2950a9c864040ec20894a17f51c053112bbac6af09197cad41ab52d2282ee`
```c
19:     LOCK();
20:     UNLOCK();
21:     iVar3 = _DAT_141fe9130 + 1;
22:     *(int *)(lVar4 + 0x28) = _DAT_141fe9130;
23:     _DAT_141fe9130 = iVar3;
24:     *(undefined4 *)(lVar4 + 0x34) = param_2;
25:     *(undefined8 *)(lVar4 + 0x10) = 0x1420a7310;
26:     *(undefined8 *)(lVar4 + 0x18) = 0x1420a70c0;
27:     *(undefined8 *)(lVar4 + 0x20) = 0x1420a73c8;
28:     FUN_140fa5530(lVar4,param_1,0);
29:     piVar1 = (int *)(lVar4 + 0x58);
30:     if (param_3 == 0) {
31:       dVar5 = (double)CFAbsoluteTimeGetCurrent();
32:       iVar3 = FUN_140bc85c0((longlong)(dVar5 + *(double *)kCFAbsoluteTimeIntervalSince1904_exref));
33:       if (piVar1 != (int *)0x0) {
34:         *piVar1 = iVar3;
35:       }
36:     }
37:     else {
38:       *piVar1 = param_3;
39:     }
40:     if ((*(longlong *)(lVar4 + 8) != 0) &&
41:        (lVar2 = *(longlong *)(*(longlong *)(lVar4 + 8) + 0x10), lVar2 != 0)) {
42:       _DAT_1420fe7e0 = _DAT_1420fe7e0 + 1;
43:       *(ulonglong *)(lVar4 + 0x2c8) = lVar2 + (ulonglong)(_DAT_1420fe7e0 % 0x32) * 0x48 + 0x958;
```

## phase4/decompiled-second/00f690b0.c L60-78
SHA256 `ee3ee43d6ddb51e7185db72ac9ab7fa4fbc657612976e2faf11c04a73c188aab`
```c
60:       if ((((param_1 != 0) && (param_2 != 0)) && (*(int *)(param_2 + 0x80) == 0x74646174)) &&
61:          (*(uint *)(param_2 + 0xac) < 0x7fffffff)) {
62:         *(undefined4 *)(plVar3 + 1) = 0x616c6269;
63:         *(undefined4 *)((longlong)plVar3 + 0xc) = 1;
64:         plVar3[6] = param_2;
65:         *(int *)(plVar3 + 2) = param_1;
66:         LOCK();
67:         UNLOCK();
68:         iVar2 = _DAT_141fe9130 + 1;
69:         *(int *)(plVar3 + 3) = _DAT_141fe9130;
70:         _DAT_141fe9130 = iVar2;
71:         if (param_3 == 0) {
72:           param_3 = func_0x000140eb8020(param_2);
73:         }
74:         plVar3[4] = param_3;
75:         uVar1 = *(undefined4 *)(_DAT_1420a6f30 + 0x15558);
76:         *(undefined4 *)((longlong)plVar3 + 0x1c) = uVar1;
77:         *(undefined4 *)(plVar3[6] + 0x2048) = uVar1;
78:         return plVar3;
```

## phase4/decompiled-second/00f6e110.c L16-33
SHA256 `b0ffef420d80115adb474245d888eda2c7a648c09f2849ed6b870ad411a95000`
```c
16:   if ((param_1 != 0) && (*(int *)(param_1 + 0x80) == 0x74646174)) {
17:     plVar3[6] = param_1;
18:     *(undefined4 *)(plVar3 + 7) = 1;
19:     LOCK();
20:     UNLOCK();
21:     iVar1 = _DAT_141fe9130 + 1;
22:     *(int *)((longlong)plVar3 + 0x3c) = _DAT_141fe9130;
23:     _DAT_141fe9130 = iVar1;
24:     plVar3[8] = param_2;
25:     if (param_2 == 0) {
26:       lVar2 = func_0x000140eb8020(param_1);
27:       plVar3[8] = lVar2;
28:     }
29:     (**(code **)(*plVar3 + 0xb8))(plVar3);
30:     *(byte *)(plVar3 + 0xe) = *(byte *)(plVar3 + 0xe) & 0xfe;
31:     *(undefined4 *)(plVar3 + 0x12) = param_3;
32:     *(byte *)(plVar3 + 0xe) = *(byte *)(plVar3 + 0xe) | 0x1e;
33:     return plVar3;
```

## phase4/decompiled-first/0106b450.c L13-35
SHA256 `5cf338a38a67e7358e1714454c6ed90995985adaa2e93bb0920cadd0fd2427e3`
```c
13:   if ((((param_1 != 0) && (lVar2 = *(longlong *)(param_1 + 8), lVar2 != 0)) &&
14:       (*(longlong *)(lVar2 + 0x10) != 0)) && ((*(byte *)(lVar2 + 0x9a) & 8) == 0)) {
15:     if (param_2 == 1) {
16:       bVar5 = param_1 == *(longlong *)(lVar2 + 0x58);
17:     }
18:     else {
19:       if (param_2 != 0xd) goto LAB_14106b50e;
20:       bVar5 = param_1 != *(longlong *)(lVar2 + 0x58);
21:     }
22:     in_RAX = CONCAT71((int7)(in_RAX >> 8),bVar5);
23:     if (((bVar5 != false) && (*(longlong *)(lVar2 + 0x60) != 0)) &&
24:        ((*(int *)(param_1 + 0x34) != 0x53485244 ||
25:         ((cVar3 = FUN_140fa9b00(), cVar3 != '\0' ||
26:          (in_RAX = FUN_140fa9c50(param_1), (char)in_RAX == '\0')))))) {
27:       uVar4 = FUN_140fa0b70(lVar2,0);
28:       if ((uVar4 & 0x200004) == 0) {
29:         FUN_140fa9b00(param_1);
30:       }
31:       uVar1 = *(uint *)(param_1 + 0x34);
32:       in_RAX = (ulonglong)uVar1;
33:       if (uVar1 != 0x44574e4c) {
34:         return (ulonglong)CONCAT31((int3)(uVar1 >> 8),uVar1 != 0x4d425546);
35:       }
```

## decompiled/0106daf0.c L1499-1539
SHA256 `19aaec8cdadd024da5e10f2fc91642a657999982ef4725be5df1f3aac6ffb547`
```c
1499:   if (*(int *)(param_1 + 0xa0013c) == 1) {
1500:     plStack_308 = (longlong *)acStack_2f8;
1501:     plStack_310 = &lStack_2f0;
1502:     uStack_318._0_4_ = 1;
1503:     uVar9 = FUN_14106b030(param_1,*(undefined8 *)(param_2 + 0x2c8),*(undefined4 *)(param_2 + 0x2b8),
1504:                           0xd);
1505:     if (uVar9 != 0) {
1506:       return (ulonglong)uVar9;
1507:     }
1508:     if (acStack_2f8[0] != '\0') {
1509:       *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
1510:     }
1511:     uVar15 = *(undefined4 *)(param_2 + 0x2c0);
1512:     uVar11 = 0xb;
1513:     uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,2);
1514:   }
1515:   else {
1516:     if (*(int *)(param_1 + 0xa0013c) != 2) goto LAB_141070229;
1517:     plStack_308 = (longlong *)acStack_2f8;
1518:     plStack_310 = &lStack_2f0;
1519:     uStack_318 = (longlong *)((ulonglong)uStack_318._4_4_ << 0x20);
1520:     uVar9 = FUN_14106b030(param_1,*(undefined8 *)(param_2 + 0x2c8),*(undefined4 *)(param_2 + 0x2b8),
1521:                           0xb);
1522:     if (uVar9 != 0) {
1523:       return (ulonglong)uVar9;
1524:     }
1525:     if (acStack_2f8[0] != '\0') {
1526:       *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
1527:     }
1528:     uVar15 = *(undefined4 *)(param_2 + 700);
1529:     uVar11 = 0x11;
1530:     uStack_318 = (longlong *)((ulonglong)uStack_318 & 0xffffffff00000000);
1531:   }
1532:   plStack_308 = (longlong *)acStack_2f8;
1533:   plStack_310 = &lStack_2f0;
1534:   uVar9 = FUN_14106b030(param_1,*(undefined8 *)(param_2 + 0x2c8),uVar15,uVar11);
1535:   if (uVar9 != 0) {
1536:     return (ulonglong)uVar9;
1537:   }
1538:   if (acStack_2f8[0] != '\0') {
1539:     *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
```

## decompiled/0107b460.c L1324-1334
SHA256 `0473d0cdbc555a40354e3dfaf4a8f54a4f2aceb11622f96ed8468bfe83660a13`
```c
1324:             case 0x13:
1325:               FUN_140f92f00(uVar13);
1326:               if (0xa00000 < uVar8) {
1327:                 return 0xffffff30;
1328:               }
1329:               uVar10 = FUN_1410770a0(param_1,param_1 + 0xa00128,uVar8);
1330:               if (uVar10 != 0) {
1331:                 return (ulonglong)uVar10;
1332:               }
1333:               uVar8 = FUN_140bfe1f0(lStack_780 + 0x568,param_1 + 0xa00128,uVar8,
1334:                                     *(longlong *)(uVar13 + 0x68) + 0x20);
```
