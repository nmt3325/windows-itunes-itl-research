/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x107ee90; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

longlong * FUN_14107ee90(longlong param_1,undefined4 param_2)

{
  int *piVar1;
  undefined4 uVar2;
  code *pcVar3;
  ulonglong uVar4;
  undefined8 *puVar5;
  char cVar6;
  byte bVar7;
  undefined1 uVar8;
  uint uVar9;
  uint uVar10;
  int iVar11;
  uint uVar12;
  uint uVar13;
  longlong lVar14;
  longlong *plVar15;
  undefined8 uVar16;
  longlong lVar17;
  undefined8 *puVar18;
  longlong *plVar19;
  longlong lVar20;
  longlong lVar21;
  longlong lVar22;
  byte bVar23;
  undefined1 *puVar24;
  ulonglong *puVar25;
  undefined8 *puVar26;
  uint *puVar27;
  byte bVar28;
  byte bVar29;
  ulonglong uVar30;
  ulonglong uVar31;
  longlong *plVar32;
  ushort uVar33;
  ulonglong *puVar34;
  undefined8 *puVar35;
  int *piVar36;
  longlong *plVar37;
  int *piVar38;
  bool bVar39;
  undefined8 extraout_XMM0_Qa;
  undefined8 extraout_XMM0_Qa_00;
  undefined4 unaff_XMM6_Da;
  undefined4 unaff_XMM6_Db;
  undefined4 unaff_XMM6_Dc;
  undefined4 unaff_XMM6_Dd;
  undefined4 unaff_XMM7_Da;
  undefined4 unaff_XMM7_Db;
  undefined4 unaff_XMM7_Dc;
  undefined4 unaff_XMM7_Dd;
  uint uStackX_8;
  char acStackX_c [4];
  longlong *plStack_1718;
  longlong *plStack_1710;
  undefined8 uStack_1708;
  longlong lStack_1700;
  int *piStack_16f8;
  longlong *plStack_16f0;
  undefined8 uStack_16e8;
  undefined4 uStack_16e0;
  uint uStack_16dc;
  undefined5 uStack_16d8;
  undefined2 uStack_16d3;
  undefined1 uStack_16d1;
  undefined8 uStack_16d0;
  undefined4 uStack_16c8;
  undefined4 auStack_16b8 [2];
  int *piStack_16b0;
  undefined8 *puStack_16a8;
  longlong lStack_16a0;
  longlong *plStack_1698;
  longlong lStack_1690;
  longlong lStack_1688;
  undefined8 uStack_1680;
  undefined8 uStack_1678;
  undefined8 uStack_1670;
  undefined8 uStack_1668;
  undefined8 uStack_1660;
  undefined8 uStack_1658;
  undefined8 uStack_1650;
  undefined8 uStack_1648;
  undefined8 uStack_1640;
  undefined8 uStack_1638;
  undefined8 uStack_1630;
  undefined8 uStack_1628;
  undefined8 uStack_1620;
  undefined8 uStack_1618;
  undefined8 uStack_1610;
  undefined8 uStack_1608;
  undefined8 uStack_1600;
  longlong *plStack_15f8;
  longlong lStack_15f0;
  undefined1 auStack_15e8 [8];
  longlong lStack_15e0;
  uint uStack_15d8;
  uint uStack_15d4;
  uint auStack_15d0 [4];
  uint uStack_15c0;
  char cStack_15bc;
  char cStack_15bb;
  char cStack_15ba;
  uint uStack_15b8;
  byte bStack_15b0;
  undefined1 uStack_15ae;
  ulonglong uStack_159c;
  ulonglong uStack_1594;
  int iStack_1578;
  uint uStack_1574;
  undefined1 auStack_1570 [4];
  uint uStack_156c;
  uint uStack_1568;
  byte bStack_1562;
  int iStack_155c;
  undefined2 uStack_1558;
  undefined2 uStack_1556;
  undefined2 uStack_1554;
  undefined2 uStack_1552;
  uint uStack_1550;
  undefined4 uStack_154c;
  undefined1 auStack_1548 [384];
  undefined2 uStack_13c8;
  short sStack_13c6;
  undefined2 uStack_13c2;
  undefined8 uStack_13c0;
  char cStack_13b8;
  char cStack_13b7;
  byte bStack_13b6;
  undefined1 uStack_13b5;
  undefined8 uStack_13b4;
  char cStack_13ac;
  byte bStack_13ab;
  byte bStack_13aa;
  byte bStack_13a7;
  undefined8 uStack_13a4;
  longlong lStack_139c;
  byte bStack_1370;
  char cStack_136f;
  char cStack_136e;
  longlong lStack_1368;
  byte bStack_1360;
  undefined1 uStack_135e;
  int iStack_1354;
  undefined8 uStack_1350;
  undefined8 uStack_1348;
  byte bStack_133f;
  byte bStack_133e;
  undefined8 uStack_133c;
  undefined8 uStack_1334;
  undefined8 uStack_132c;
  undefined8 uStack_1324;
  undefined8 uStack_131c;
  undefined8 uStack_1314;
  undefined8 uStack_130c;
  int iStack_1304;
  uint uStack_1300;
  undefined4 uStack_12fc;
  undefined1 auStack_12f8 [1200];
  undefined1 uStack_e48;
  byte bStack_e43;
  byte bStack_e41;
  undefined8 uStack_930;
  undefined8 uStack_928;
  undefined8 uStack_920;
  undefined8 uStack_918;
  int iStack_910;
  int iStack_90c;
  int iStack_908;
  byte bStack_904;
  char cStack_903;
  undefined1 uStack_902;
  byte bStack_901;
  int iStack_900;
  undefined8 uStack_8fc;
  undefined8 uStack_8f4;
  byte bStack_8ec;
  undefined1 uStack_8eb;
  undefined1 uStack_8ea;
  byte bStack_8e8;
  undefined1 uStack_8e7;
  char cStack_8e6;
  byte bStack_8e5;
  int iStack_8e4;
  undefined2 uStack_8e0;
  undefined2 uStack_8de;
  undefined2 uStack_8dc;
  undefined2 uStack_8da;
  undefined4 uStack_838;
  byte bStack_824;
  byte bStack_823;
  byte bStack_822;
  undefined1 uStack_821;
  undefined8 uStack_820;
  undefined8 uStack_818;
  undefined8 uStack_810;
  undefined8 uStack_808;
  int iStack_800;
  byte bStack_7f0;
  char cStack_7ef;
  byte bStack_7ee;
  uint uStack_7c8;
  uint uStack_7c4;
  uint auStack_7c0 [4];
  longlong lStack_7b0;
  undefined8 uStack_7a8;
  undefined8 uStack_7a0;
  undefined8 uStack_798;
  ushort uStack_790;
  uint uStack_788;
  uint uStack_784;
  uint auStack_780 [22];
  undefined8 uStack_728;
  undefined8 uStack_720;
  undefined8 uStack_718;
  undefined8 uStack_710;
  undefined8 uStack_708;
  undefined8 uStack_700;
  undefined8 uStack_6f8;
  undefined8 uStack_6f0;
  undefined8 uStack_6e8;
  undefined8 uStack_6e0;
  undefined8 uStack_6d8;
  undefined8 uStack_6d0;
  undefined8 uStack_6c8;
  undefined8 uStack_6c0;
  undefined8 uStack_6b8;
  undefined8 uStack_6b0;
  undefined8 uStack_6a8;
  undefined8 uStack_6a0;
  undefined8 uStack_698;
  undefined8 uStack_690;
  undefined8 uStack_688;
  undefined8 uStack_680;
  undefined8 uStack_678;
  undefined8 uStack_670;
  undefined4 uStack_668;
  undefined4 uStack_258;
  ulonglong uStack_58;
  undefined8 uStack_30;
  
  uStack_30 = 0x14107eeba;
  lVar14 = FUN_1418677a0();
  lVar14 = -lVar14;
  *(undefined4 *)(&stack0x00001738 + lVar14) = unaff_XMM6_Da;
  *(undefined4 *)(&stack0x0000173c + lVar14) = unaff_XMM6_Db;
  *(undefined4 *)(&stack0x00001740 + lVar14) = unaff_XMM6_Dc;
  *(undefined4 *)(&stack0x00001744 + lVar14) = unaff_XMM6_Dd;
  *(undefined4 *)(&stack0x00001728 + lVar14) = unaff_XMM7_Da;
  *(undefined4 *)(&stack0x0000172c + lVar14) = unaff_XMM7_Db;
  *(undefined4 *)(&stack0x00001730 + lVar14) = unaff_XMM7_Dc;
  *(undefined4 *)(&stack0x00001734 + lVar14) = unaff_XMM7_Dd;
  uStack_58 = _DAT_141fd5040 ^ (ulonglong)(&stack0xffffffffffffffd8 + lVar14);
  *(undefined4 *)(&stack0x00000018 + lVar14) = param_2;
  *(undefined8 *)(&stack0x00000038 + lVar14) = *(undefined8 *)(param_1 + 0x1e00270);
  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107ef03;
  uVar9 = FUN_1410770a0(extraout_XMM0_Qa,&uStack_788,8);
  plVar32 = (longlong *)(ulonglong)uVar9;
  if (uVar9 != 0) goto code_r0x0001410816e9;
  plVar37 = (longlong *)(param_1 + 0x52);
  uVar9 = uStack_784;
  if (*(char *)plVar37 == '\0') {
    uVar9 = uStack_784 >> 0x18 | (uStack_784 & 0xff0000) >> 8 | (uStack_784 & 0xff00) << 8 |
            uStack_784 << 0x18;
  }
  puVar27 = auStack_780;
  uVar12 = 0x5c;
  if (uVar9 < 0x5c) {
    uVar12 = uVar9;
  }
  if (uVar12 < 9) {
LAB_14107ef7e:
    uVar30 = (ulonglong)uStack_784;
    if ((uVar12 < 0x5c) && (puVar27 != (uint *)0x0)) {
      *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107ef95;
      func_0x00014179cca0(puVar27,0,0x5c - uVar12);
      uVar30 = (ulonglong)uStack_784;
    }
    if (uVar12 < uVar9) {
      *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107efae;
      uVar9 = itl_106a520(param_1,uVar9 - uVar12);
      plVar32 = (longlong *)(ulonglong)uVar9;
      if (uVar9 != 0) goto code_r0x0001410816e9;
    }
    plVar32 = (longlong *)0x0;
    if (*(char *)plVar37 == '\0') {
      uStack_788 = (uStack_788 & 0xff0000 | uStack_788 >> 0x10) >> 8 |
                   (uStack_788 & 0xff00 | uStack_788 << 0x10) << 8;
      uVar9 = (uint)uVar30;
      uStack_784 = (uVar9 & 0xff0000 | (uint)(uVar30 >> 0x10) & 0xffff) >> 8 |
                   (uVar9 << 0x10 | uVar9 & 0xff00) << 8;
      auStack_780[0] =
           (auStack_780[0] & 0xff0000 | auStack_780[0] >> 0x10) >> 8 |
           (auStack_780[0] & 0xff00 | auStack_780[0] << 0x10) << 8;
    }
    if (uStack_788 == 0x68706c6d) {
      *(undefined4 *)(&stack0x00000048 + lVar14) = 0;
      if (auStack_780[0] != 0) {
        do {
          piStack_16b0 = (int *)0x0;
          *(undefined8 *)(&stack0x00000050 + lVar14) = 0;
          acStackX_c[lVar14] = '\0';
          acStackX_c[lVar14 + 1] = '\0';
          *(undefined8 *)(&stack0x00000020 + lVar14) = 0;
          *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f0cd;
          uVar9 = FUN_1410770a0(param_1,&iStack_1578,8);
          plVar32 = (longlong *)(ulonglong)uVar9;
          if (uVar9 != 0) break;
          uVar9 = uStack_1574;
          if ((char)*plVar37 == '\0') {
            uVar9 = (uStack_1574 & 0xff0000 | uStack_1574 >> 0x10) >> 8 |
                    (uStack_1574 << 0x10 | uStack_1574 & 0xff00) << 8;
          }
          puVar24 = auStack_1570;
          uVar12 = 0xdac;
          if (uVar9 < 0xdac) {
            uVar12 = uVar9;
          }
          if (8 < uVar12) {
            uVar30 = (ulonglong)(uVar12 - 8);
            if (0xa00000 < uVar30) goto LAB_1410816e2;
            *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f144;
            uVar10 = FUN_1410770a0(param_1,auStack_1570,uVar30);
            plVar32 = (longlong *)(ulonglong)uVar10;
            if (uVar10 != 0) break;
            puVar24 = auStack_1570 + uVar30;
          }
          if ((uVar12 < 0xdac) && (puVar24 != (undefined1 *)0x0)) {
            *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f176;
            func_0x00014179cca0(puVar24,0,0xdac - uVar12);
          }
          if (uVar12 < uVar9) {
            *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f188;
            uVar9 = itl_106a520(param_1,uVar9 - uVar12);
            plVar32 = (longlong *)(ulonglong)uVar9;
            if (uVar9 != 0) break;
          }
          plVar32 = (longlong *)0x0;
          *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f1a7;
          func_0x000141069860(param_1,&iStack_1578);
          if (iStack_1578 != 0x6870696d) goto LAB_1410816e2;
          bVar29 = bStack_133e;
          if (bStack_133e == 0) {
            uVar33 = (ushort)bStack_133f;
            if (bStack_133f != 0) goto LAB_14107f20d;
            bVar29 = bStack_1360;
            if (bStack_1360 != 0) goto LAB_14107f20a;
            if (cStack_13ac != '\0') {
              uVar33 = 0x11;
              goto LAB_14107f22f;
            }
            if (cStack_13b7 != '\0') {
              uVar33 = 0x13;
              goto LAB_14107f22f;
            }
            if (cStack_136f != '\0') {
              uVar33 = 10;
              goto LAB_14107f22f;
            }
LAB_14107f2ad:
            uVar9 = *(uint *)(&stack0x00000018 + lVar14);
LAB_14107f2b1:
            if ((lStack_139c != 0) && ((uVar9 & 8) != 0)) goto LAB_14107f24a;
            *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f2c7;
            cVar6 = func_0x000140ee8290(uVar33);
            uVar9 = *(uint *)(&stack0x00000018 + lVar14);
            if (((cVar6 != '\0') && ((uVar9 & 0x10) != 0)) ||
               ((bStack_1562 != 0 && ((uVar9 & 0x20) != 0)))) goto LAB_14107f24a;
            uStack_258 = 0x200001;
            plVar19 = *(longlong **)(&stack0x00000038 + lVar14);
            if (lStack_1368 != 0) {
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f30f;
              lStack_1688 = FUN_140ef68d0(plVar19);
              if (lStack_1688 != 0) {
                uStack_1680 = 0xffffffffffffffff;
                plVar32 = &lStack_1688;
              }
            }
            lStack_1700 = 0;
            uStack_16d8 = 0;
            uStack_16d3 = 0;
            uStack_16d1 = 0;
            piStack_16f8 = &uStack_258;
            uStack_16dc = (uint)bStack_1562;
            uStack_16e8 = uStack_13c0;
            uStack_16e0 = 0;
            if ((int)uVar9 < 0) {
              uStack_16e0 = uStack_838;
            }
            *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f37e;
            uStack_1708 = plVar19;
            plStack_16f0 = plVar32;
            uVar9 = FUN_1410405b0(&uStack_1708,&stack0x00000020 + lVar14);
            plVar32 = (longlong *)(ulonglong)uVar9;
            if (uVar9 != 0) break;
            piVar38 = *(int **)(&stack0x00000020 + lVar14);
            piVar38[0x7d] = iStack_155c;
            piVar38[0x7e] = iStack_1304;
            bVar28 = (bStack_13ab & 1) << 4;
            bVar29 = *(byte *)((longlong)piVar38 + 0x2ca);
            *(byte *)((longlong)piVar38 + 0x2ca) = bVar28 | bVar29 & 0xef;
            *(byte *)((longlong)piVar38 + 0x2ca) = (bStack_13aa & 1) << 5 | bVar28 | bVar29 & 0xcf;
            *(undefined1 *)((longlong)piVar38 + 0x2cd) = uStack_e48;
            *(undefined1 *)(piVar38 + 0xb3) = uStack_135e;
            *(byte *)((longlong)piVar38 + 0x2ca) =
                 *(byte *)((longlong)piVar38 + 0x2ca) & 0x7f | cStack_13b8 << 7;
            bVar29 = *(byte *)((longlong)piVar38 + 0x2cb);
            *(byte *)((longlong)piVar38 + 0x2cb) = bVar29 & 0xfe | bStack_e43 & 1;
            *(byte *)((longlong)piVar38 + 0x2cb) =
                 (bStack_e41 & 1) * '\x02' | bVar29 & 0xfc | bStack_e43 & 1;
            *(undefined2 *)(piVar38 + 0xb7) = uStack_1558;
            *(undefined2 *)((longlong)piVar38 + 0x2de) = uStack_1556;
            *(undefined2 *)(piVar38 + 0xb8) = uStack_1554;
            *(undefined2 *)((longlong)piVar38 + 0x2e2) = uStack_1552;
            *(undefined2 *)(piVar38 + 0xb9) = uStack_13c2;
            *(undefined2 *)((longlong)piVar38 + 0x2e6) = uStack_8e0;
            *(undefined2 *)(piVar38 + 0xba) = uStack_8de;
            *(undefined2 *)((longlong)piVar38 + 0x2ea) = uStack_8dc;
            *(undefined2 *)(piVar38 + 0xbb) = uStack_8da;
            if (iStack_1354 == 0x2d) {
LAB_14107f4fa:
              iVar11 = 0x34;
            }
            else if (iStack_1354 == 0x2e) {
LAB_14107f4f3:
              iVar11 = 0x35;
            }
            else {
              if (iStack_1354 == 0x33) goto LAB_14107f4fa;
              if (iStack_1354 == 0x34) goto LAB_14107f4f3;
              iVar11 = 0;
            }
            piVar38[0x11c] = iVar11;
            if (iStack_900 != 0) {
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f515;
              iVar11 = func_0x0001410c6a00();
              piVar38[0x11d] = iVar11;
            }
            *(undefined1 *)((longlong)piVar38 + 0x47a) = uStack_902;
            *(undefined8 *)(piVar38 + 0x62) = uStack_8fc;
            *(undefined8 *)(piVar38 + 100) = uStack_8f4;
            *(undefined1 *)((longlong)piVar38 + 0x183) = uStack_8eb;
            bVar23 = (bStack_8ec & 1) << 2;
            bVar29 = *(byte *)(piVar38 + 0x60);
            *(byte *)(piVar38 + 0x60) = bVar23 | bVar29 & 0xfb;
            bVar7 = (bStack_8e5 & 1) << 6;
            *(byte *)(piVar38 + 0x60) = bVar7 | bVar23 | bVar29 & 0xbb;
            bVar28 = (bStack_901 & 1) * '\x02';
            *(byte *)(piVar38 + 0x60) = bVar28 | bVar7 | bVar23 | bVar29 & 0xb9;
            *(byte *)(piVar38 + 0x60) = bStack_8e8 & 1 | bVar28 | bVar7 | bVar23 | bVar29 & 0xb8;
            bVar28 = (bStack_824 & 1) * '\x02';
            bVar29 = *(byte *)((longlong)piVar38 + 0x181);
            *(byte *)((longlong)piVar38 + 0x181) = bVar28 | bVar29 & 0xfd;
            bVar7 = (bStack_823 & 1) << 2;
            *(byte *)((longlong)piVar38 + 0x181) = bVar7 | bVar28 | bVar29 & 0xf9;
            *(byte *)((longlong)piVar38 + 0x181) =
                 (bStack_822 & 1) << 3 | bVar7 | bVar28 | bVar29 & 0xf1;
            *(undefined1 *)(piVar38 + 0x11e) = uStack_821;
            *(undefined8 *)(piVar38 + 0x72) = uStack_820;
            *(undefined8 *)(piVar38 + 0x6c) = uStack_818;
            *(undefined8 *)(piVar38 + 0x6e) = uStack_810;
            *(undefined8 *)(piVar38 + 0x70) = uStack_808;
            piVar38[0x68] = iStack_800;
            bVar28 = (bStack_7f0 & 1) << 4;
            bVar29 = *(byte *)((longlong)piVar38 + 0x1da);
            *(byte *)((longlong)piVar38 + 0x1da) = bVar28 | bVar29 & 0xef;
            *(byte *)((longlong)piVar38 + 0x1da) = bVar28 | bVar29 & 0x6f | cStack_7ef << 7;
            *(byte *)((longlong)piVar38 + 0x1db) =
                 bStack_7ee & 1 | *(byte *)((longlong)piVar38 + 0x1db) & 0xfe;
            if (cStack_8e6 != '\0') {
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f6c9;
              plVar15 = (longlong *)FUN_140f00150(auStack_15e8,piVar38,1);
              plVar19 = (longlong *)*plVar15;
              lVar17 = plVar15[1];
              *plVar15 = 0;
              plVar15[1] = 0;
              plStack_15f8 = plVar19;
              lStack_15f0 = lVar17;
              if (lStack_15e0 != 0) {
                *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f6f8;
                FUN_140251ff0();
              }
              if (plVar19 != (longlong *)0x0) {
                pcVar3 = *(code **)(*plVar19 + 0x98);
                *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f710;
                (*pcVar3)(plVar19,cStack_8e6);
              }
              if (lVar17 != 0) {
                *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f71e;
                FUN_140251ff0(lVar17);
              }
              plVar19 = *(longlong **)(&stack0x00000038 + lVar14);
            }
            *(undefined1 *)((longlong)piVar38 + 0x47b) = uStack_8ea;
            *(undefined1 *)(piVar38 + 0x11f) = uStack_8e7;
            *(byte *)(piVar38 + 0xb2) = bStack_13a7 & 1 | *(byte *)(piVar38 + 0xb2) & 0xfe;
            piVar38[0x100] = iStack_8e4;
            *(byte *)(piVar38 + 0xfc) = bStack_13b6 & 1 | *(byte *)(piVar38 + 0xfc) & 0xfe;
            *(undefined1 *)(piVar38 + 0xd8) = uStack_13b5;
            *(undefined8 *)(piVar38 + 0xd6) = uStack_13b4;
            *(undefined8 *)(piVar38 + 0xda) = uStack_13a4;
            *(ushort *)(piVar38 + 4) = uVar33;
            *(byte *)((longlong)piVar38 + 0x1d9) =
                 (bStack_1370 & 1) << 3 | *(byte *)((longlong)piVar38 + 0x1d9) & 0xf7;
            bVar28 = (bStack_904 & 1) << 5;
            bVar29 = *(byte *)((longlong)piVar38 + 0x2c9);
            *(byte *)((longlong)piVar38 + 0x2c9) = bVar28 | bVar29 & 0xdf;
            *(byte *)((longlong)piVar38 + 0x2c9) = cStack_903 << 7 | bVar28 | bVar29 & 0x5f;
            (&stack0x0000001c)[lVar14] = uVar33 == 1;
            if (*(longlong *)(piVar38 + 0x14) == 0) {
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f822;
              uVar16 = FUN_140ba5880(0);
              *(undefined8 *)(piVar38 + 0x14) = uVar16;
            }
            *(undefined8 *)(piVar38 + 0x86) = uStack_1350;
            *(undefined8 *)(piVar38 + 0x88) = uStack_1348;
            piVar38[0xde] = iStack_910;
            piVar38[0xdf] = iStack_90c;
            piVar38[0xe0] = iStack_908;
            *(undefined8 *)(piVar38 + 0xe6) = uStack_1334;
            *(undefined8 *)(piVar38 + 0xe8) = uStack_132c;
            *(undefined8 *)(piVar38 + 0xea) = uStack_1324;
            *(undefined8 *)(piVar38 + 0xec) = uStack_131c;
            *(undefined8 *)(piVar38 + 0xee) = uStack_1314;
            *(undefined8 *)(piVar38 + 0xf0) = uStack_130c;
            *(undefined8 *)(piVar38 + 0xf2) = uStack_930;
            *(undefined8 *)(piVar38 + 0xf4) = uStack_928;
            *(undefined8 *)(piVar38 + 0xf6) = uStack_920;
            *(undefined8 *)(piVar38 + 0xf8) = uStack_918;
            if (((short)piVar38[4] == 0xf) && (piVar38 != (int *)0xfffffffffffffef0)) {
              *(byte *)((longlong)piVar38 + 0x113) = *(byte *)((longlong)piVar38 + 0x113) | 0x20;
            }
            if (*(ushort *)(param_1 + 0xc) < 0x3c) {
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f920;
              lVar17 = FUN_140fb4370(piVar38);
              if (lVar17 != 0) {
                if (lVar17 + 0x1e != 0) {
                  if (uStack_1300 - 1 < 100) {
                    puVar24 = auStack_12f8;
                    uVar9 = uStack_1300;
                    uVar2 = uStack_12fc;
                  }
                  else {
                    if (0x20 < uStack_1550) goto LAB_14107f96f;
                    puVar24 = auStack_1548;
                    uVar9 = uStack_1550;
                    uVar2 = uStack_154c;
                  }
                  *(longlong *)(&stack0xfffffffffffffff8 + lVar14) = lVar17 + 0x1e;
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f96f;
                  FUN_14107e8c0(uStack_1300 - 1,uVar9,puVar24,uVar2);
                }
LAB_14107f96f:
                *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f97d;
                FUN_140fb3430(piVar38,lVar17,0);
                piVar36 = (int *)(lVar17 + 0xc);
                *piVar36 = *piVar36 + -1;
                if ((*piVar36 == 0) && (*(int *)(lVar17 + 8) == 0x63736574)) {
                  *(undefined4 *)(lVar17 + 8) = 0;
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f99c;
                  _aligned_free(lVar17);
                }
              }
            }
            uVar9 = 0;
            lStack_7b0 = 0;
            uStack_7a8 = 0;
            uStack_7a0 = 0;
            uStack_798 = 0;
            uStack_790 = 0;
            if (*piVar38 == 0x706c7374) {
              lStack_1700 = 0;
              piStack_16f8 = (int *)0x0;
              plStack_16f0 = (longlong *)0x0;
              uStack_1708 = &lStack_7b0;
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f9e9;
              FUN_140ef4580(piVar38,0x6770706d,&uStack_1708);
            }
            switch((short)piVar38[4]) {
            case 10:
            case 0x1f:
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107fb32;
              uVar12 = FUN_140ff7c00(piVar38);
              plVar32 = (longlong *)(ulonglong)uVar12;
              if (uVar12 != 0) goto code_r0x0001410816e9;
              break;
            case 0xf:
              *(byte *)((longlong)piVar38 + 0x2ca) = *(byte *)((longlong)piVar38 + 0x2ca) | 8;
              uStack_790 = uStack_790 & 0xffe6;
              uStack_790 = uStack_790 | 0x400;
              break;
            case 0x11:
              uStack_790 = uStack_790 & 0xfffe;
              break;
            case 0x13:
              if (lRam00000001420cf3b0 != 0) {
                *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107fad7;
                lVar17 = FUN_140f01020();
                if ((lVar17 != 0) && (*(int *)(lVar17 + 0x58) != 0)) {
                  piVar38[0x16] = *(int *)(lVar17 + 0x58);
                }
              }
              uStack_790 = uStack_790 | 0x18;
              break;
            case 0x14:
              *(undefined8 *)(piVar38 + 0x138) = uStack_133c;
              uStack_790 = uStack_790 & 0xffe7;
              break;
            case 0x19:
              *(undefined2 *)(piVar38 + 4) = 0;
              break;
            case 0x23:
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107fb49;
              FUN_141008fa0(piVar38);
              goto LAB_14107fa5b;
            case 0x27:
              *(undefined8 *)(piVar38 + 0x138) = uStack_133c;
            }
            if ((*piVar38 == 0x706c7374) && ((short)piVar38[0x7f] == 0)) {
              *(longlong *)(piVar38 + 0x113) = lStack_7b0;
              *(undefined8 *)(piVar38 + 0x115) = uStack_7a8;
              *(undefined8 *)(piVar38 + 0x117) = uStack_7a0;
              *(undefined8 *)(piVar38 + 0x119) = uStack_798;
              *(ushort *)(piVar38 + 0x11b) = uStack_790;
            }
LAB_14107fa5b:
            *(undefined4 *)((longlong)&uStackX_8 + lVar14) = 0;
            if (uStack_156c != 0) {
              do {
                *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107fa85;
                uVar12 = FUN_141077270(param_1,&uStack_7c8,0x18);
                plVar32 = (longlong *)(ulonglong)uVar12;
                if (uVar12 != 0) {
                  if (uVar12 == 0xffffff30) {
LAB_14107fc8a:
                    if (uStack_7c8 == 0x6870746d) {
                      uVar30 = (longlong)(int)-uStack_7c4 + *(longlong *)(param_1 + 0x1e00170);
                      *(ulonglong *)(param_1 + 0x1e00170) = uVar30;
                      if ((uVar30 < *(ulonglong *)(param_1 + 0x1e00178)) ||
                         (*(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180)
                          <= uVar30)) {
                        *(undefined8 *)(param_1 + 0x1e00180) = 0;
                      }
                      plVar32 = (longlong *)0x0;
                      goto LAB_14107ff7d;
                    }
                  }
                  goto code_r0x0001410816e9;
                }
                if ((char)*plVar37 == '\0') {
                  uStack_7c8 = (uStack_7c8 & 0xff0000 | uStack_7c8 >> 0x10) >> 8 |
                               (uStack_7c8 << 0x10 | uStack_7c8 & 0xff00) << 8;
                  uStack_7c4 = (uStack_7c4 & 0xff0000 | uStack_7c4 >> 0x10) >> 8 |
                               (uStack_7c4 << 0x10 | uStack_7c4 & 0xff00) << 8;
                  auStack_7c0[0] =
                       (auStack_7c0[0] & 0xff0000 | auStack_7c0[0] >> 0x10) >> 8 |
                       (auStack_7c0[0] << 0x10 | auStack_7c0[0] & 0xff00) << 8;
                  auStack_7c0[1] =
                       (auStack_7c0[1] & 0xff0000 | auStack_7c0[1] >> 0x10) >> 8 |
                       (auStack_7c0[1] << 0x10 | auStack_7c0[1] & 0xff00) << 8;
                  auStack_7c0[2] =
                       (auStack_7c0[2] & 0xff0000 | auStack_7c0[2] >> 0x10) >> 8 |
                       (auStack_7c0[2] << 0x10 | auStack_7c0[2] & 0xff00) << 8;
                }
                if (uStack_7c8 != 0x686f686d) {
                  plVar32 = (longlong *)0xffffff30;
                  uVar9 = *(uint *)((longlong)&uStackX_8 + lVar14);
                  goto LAB_14107fc8a;
                }
                switch(auStack_7c0[1]) {
                case 100:
                  if ((short)piVar38[4] == 0x23) goto LAB_14107fd4c;
                  *(undefined4 *)(&stack0x00000000 + lVar14) = 0;
                  *(int **)(&stack0xfffffffffffffff8 + lVar14) = piVar38 + 0x5e;
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107fd20;
                  uVar9 = FUN_1410773d0(param_1,1,piVar38 + 0x4c,0);
                  plVar32 = (longlong *)(ulonglong)uVar9;
                  if ((uVar9 == 0) && ((*(byte *)(piVar38 + 0x76) & 8) != 0)) {
                    acStackX_c[lVar14 + 1] = '\x01';
                    break;
                  }
                  acStackX_c[lVar14 + 1] = '\0';
                  goto joined_r0x00014108083f;
                case 0x65:
                  if (0xa00000 < auStack_7c0[0] - uStack_7c4) goto LAB_1410816e2;
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107fda9;
                  uVar9 = FUN_1410770a0(param_1,param_1 + 0xa00128);
                  plVar32 = (longlong *)(ulonglong)uVar9;
                  if (uVar9 != 0) goto code_r0x0001410816e9;
                  *(int ***)(&stack0xfffffffffffffff8 + lVar14) = &piStack_16b0;
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107fdd4;
                  FUN_140bf0dd0(param_1 + 0xa00128,auStack_7c0[0] - uStack_7c4);
                  break;
                case 0x66:
                  if (0xa00000 < auStack_7c0[0] - uStack_7c4) goto LAB_1410816e2;
                  puVar18 = (undefined8 *)(param_1 + 0xa00128);
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107fdfe;
                  uVar9 = FUN_1410770a0(param_1,puVar18);
                  plVar32 = (longlong *)(ulonglong)uVar9;
                  if (uVar9 != 0) goto code_r0x0001410816e9;
                  uStack_1668 = 0;
                  uStack_1660 = 0;
                  uStack_1658 = 0;
                  uStack_1650 = 0;
                  uStack_1648 = 0;
                  uStack_1640 = 0;
                  uStack_1638 = 0;
                  uStack_1630 = 0;
                  uStack_1628 = 0;
                  uStack_1620 = 0;
                  uStack_1618 = 0;
                  uStack_1610 = 0;
                  uStack_1608 = 0;
                  uStack_1600 = 0;
                  if (puVar18 != (undefined8 *)0x0) {
                    uStack_1668 = *puVar18;
                    uStack_1660 = *(undefined8 *)(param_1 + 0xa00130);
                    uStack_1658 = *(undefined8 *)(param_1 + 0xa00138);
                    uStack_1650 = *(undefined8 *)(param_1 + 0xa00140);
                    uStack_1648 = *(undefined8 *)(param_1 + 0xa00148);
                    uStack_1640 = *(undefined8 *)(param_1 + 0xa00150);
                    uStack_1638 = *(undefined8 *)(param_1 + 0xa00158);
                    uStack_1630 = *(undefined8 *)(param_1 + 0xa00160);
                    uStack_1628 = *(undefined8 *)(param_1 + 0xa00168);
                    uStack_1620 = *(undefined8 *)(param_1 + 0xa00170);
                    uStack_1618 = *(undefined8 *)(param_1 + 0xa00178);
                    uStack_1610 = *(undefined8 *)(param_1 + 0xa00180);
                    uStack_1608 = *(undefined8 *)(param_1 + 0xa00188);
                    uStack_1600 = *(undefined8 *)(param_1 + 0xa00190);
                  }
                  acStackX_c[lVar14] = '\x01';
                  break;
                case 0x67:
                  uVar9 = auStack_7c0[0] - uStack_7c4;
                  if (uVar9 < 0xa00001) {
                    lVar17 = param_1 + 0xa00128;
                    lVar20 = 0;
                  }
                  else {
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080741;
                    lVar17 = _aligned_malloc(uVar9,0x10);
                    lVar20 = lVar17;
                    if (lVar17 == 0) {
                      plVar32 = (longlong *)0xffffff94;
                      goto code_r0x0001410816e9;
                    }
                  }
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080767;
                  uVar9 = FUN_1410770a0(param_1,lVar17,uVar9);
                  plVar32 = (longlong *)(ulonglong)uVar9;
                  if (uVar9 != 0) goto code_r0x0001410816e9;
                  if (((*piVar38 == 0x706c7374) &&
                      (((*(byte *)(*(longlong *)(piVar38 + 2) + 0x110) & 1) != 0 ||
                       (*(int *)(*(longlong *)(piVar38 + 2) + 0x84) == 0x74736574)))) &&
                     ((((short)piVar38[4] == 10 || ((short)piVar38[4] == 0x1f)) &&
                      (*(longlong *)(piVar38 + 0x7a) != 0)))) {
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410807bb;
                    FUN_140fe26d0();
                  }
                  if (lVar20 != 0) {
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410807cd;
                    _aligned_free(lVar20);
                  }
                  break;
                case 0x68:
                  if (0xa00000 < auStack_7c0[0] - uStack_7c4) goto LAB_1410816e2;
                  puVar34 = (ulonglong *)(param_1 + 0xa00128);
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107fe9e;
                  uVar9 = FUN_1410770a0(param_1,puVar34);
                  plVar32 = (longlong *)(ulonglong)uVar9;
                  if (uVar9 != 0) goto code_r0x0001410816e9;
                  uVar9 = auStack_7c0[0] - uStack_7c4;
                  uVar12 = uVar9 >> 3;
                  uVar30 = (ulonglong)uVar12;
                  if (uVar12 != 0) {
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107fed0;
                    uVar10 = FUN_1402dc5a0(&stack0x00000050 + lVar14,uVar30);
                    plVar32 = (longlong *)(ulonglong)uVar10;
                    if (uVar10 != 0) goto code_r0x0001410816e9;
                    if ((char)*plVar37 == '\0') {
                      if (uVar9 >> 3 != 0) {
                        uVar31 = (ulonglong)uVar12;
                        puVar25 = puVar34;
                        do {
                          uVar4 = *puVar25;
                          *puVar25 = uVar4 >> 0x38 | (uVar4 & 0xff000000000000) >> 0x28 |
                                     (uVar4 & 0xff0000000000) >> 0x18 | (uVar4 & 0xff00000000) >> 8
                                     | (uVar4 & 0xff000000) << 8 | (uVar4 & 0xff0000) << 0x18 |
                                     (uVar4 & 0xff00) << 0x28 | uVar4 << 0x38;
                          puVar25 = puVar25 + 1;
                          uVar31 = uVar31 - 1;
                        } while (uVar31 != 0);
code_r0x00014107ff0a:
                        uVar16 = *(undefined8 *)(&stack0x00000050 + lVar14);
                        do {
                          uVar31 = *puVar34;
                          *(ulonglong *)(&stack0x00000010 + lVar14) = uVar31;
                          if (((plVar19 != (longlong *)0x0) && ((int)plVar19[0x10] == 0x74646174))
                             && (uVar31 != 0)) {
                            *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107ff38;
                            iVar11 = FUN_140ec1e30(plVar19);
                            if (iVar11 == 0) {
                              lVar17 = plVar19[0x31c];
                              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107ff4e;
                              lVar17 = FUN_14042de70(lVar17,&stack0x00000010 + lVar14);
                              if ((lVar17 != 0) && (lVar17 = *(longlong *)(lVar17 + 8), lVar17 != 0)
                                 ) {
                                *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107ff67;
                                FUN_1402dd4c0(uVar16,lVar17,0);
                              }
                            }
                          }
                          puVar34 = puVar34 + 1;
                          uVar30 = uVar30 - 1;
                        } while (uVar30 != 0);
                        piVar38 = *(int **)(&stack0x00000020 + lVar14);
                      }
                    }
                    else if (uVar9 >> 3 != 0) goto code_r0x00014107ff0a;
                  }
                  break;
                case 0x69:
                  if (0xa00000 < auStack_7c0[0] - uStack_7c4) goto LAB_1410816e2;
                  puVar18 = (undefined8 *)(param_1 + 0xa00128);
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080396;
                  uVar9 = FUN_1410770a0(param_1,puVar18);
                  plVar32 = (longlong *)(ulonglong)uVar9;
                  if (uVar9 != 0) goto code_r0x0001410816e9;
                  if (auStack_7c0[0] - uStack_7c4 == 0x4c4) {
                    if (puVar18 != (undefined8 *)0x0) {
                      lVar17 = 9;
                      puVar5 = &uStack_728;
                      do {
                        puVar35 = puVar18;
                        puVar26 = puVar5;
                        uVar16 = puVar35[1];
                        *puVar26 = *puVar35;
                        puVar26[1] = uVar16;
                        uVar16 = puVar35[3];
                        puVar26[2] = puVar35[2];
                        puVar26[3] = uVar16;
                        uVar16 = puVar35[5];
                        puVar26[4] = puVar35[4];
                        puVar26[5] = uVar16;
                        uVar16 = puVar35[7];
                        puVar26[6] = puVar35[6];
                        puVar26[7] = uVar16;
                        uVar16 = puVar35[9];
                        puVar26[8] = puVar35[8];
                        puVar26[9] = uVar16;
                        uVar16 = puVar35[0xb];
                        puVar26[10] = puVar35[10];
                        puVar26[0xb] = uVar16;
                        uVar16 = puVar35[0xd];
                        puVar26[0xc] = puVar35[0xc];
                        puVar26[0xd] = uVar16;
                        uVar16 = puVar35[0xf];
                        puVar26[0xe] = puVar35[0xe];
                        puVar26[0xf] = uVar16;
                        lVar17 = lVar17 + -1;
                        puVar5 = puVar26 + 0x10;
                        puVar18 = puVar35 + 0x10;
                      } while (lVar17 != 0);
                      uVar16 = puVar35[0x11];
                      puVar26[0x10] = puVar35[0x10];
                      puVar26[0x11] = uVar16;
                      uVar16 = puVar35[0x13];
                      puVar26[0x12] = puVar35[0x12];
                      puVar26[0x13] = uVar16;
                      uVar16 = puVar35[0x15];
                      puVar26[0x14] = puVar35[0x14];
                      puVar26[0x15] = uVar16;
                      uVar16 = puVar35[0x17];
                      puVar26[0x16] = puVar35[0x16];
                      puVar26[0x17] = uVar16;
                      *(undefined4 *)(puVar26 + 0x18) = *(undefined4 *)(puVar35 + 0x18);
                    }
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080455;
                    func_0x000141069e20(param_1,&uStack_728);
                    if ((((uStack_728._4_1_ == '\0') || (uStack_728._4_1_ == '\x03')) ||
                        (uStack_728._4_1_ == '\x04')) ||
                       ((uStack_728._4_1_ == '\x05' && (0x29 < *(ushort *)(param_1 + 0xc))))) {
                      *(undefined8 *)(&stack0x00000010 + lVar14) = 0;
                      (&stack0x00000028)[lVar14] = uStack_728._4_1_;
                      (&stack0x00000029)[lVar14] = uStack_728._5_1_;
                      *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410804ad;
                      iVar11 = FUN_140fb36f0(&stack0x00000028 + lVar14,uStack_728 & 0xffffffff,
                                             &stack0x00000010 + lVar14);
                      if (iVar11 == 0) {
                        puVar18 = *(undefined8 **)(&stack0x00000010 + lVar14);
                        *(undefined1 *)((longlong)puVar18 + 0x1c) = uStack_728._6_1_;
                        *(undefined4 *)(puVar18 + 3) = (undefined4)uStack_720;
                        *(undefined1 *)((longlong)puVar18 + 0x1d) = uStack_728._7_1_;
                        *(longlong *)(&stack0xfffffffffffffff8 + lVar14) = (longlong)puVar18 + 0x1e;
                        *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410804f9;
                        FUN_14107e8c0(extraout_XMM0_Qa_00,uStack_720._4_4_,(longlong)&uStack_718 + 4
                                      ,uStack_718 & 0xffffffff);
                        *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080507;
                        FUN_140fb3430(piVar38,puVar18,0);
                        *(undefined1 *)((longlong)puVar18 + 0x1c) = uStack_728._6_1_;
                        piVar36 = piVar38 + 0x106;
                        *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080524;
                        lVar17 = func_0x000140fb3790(piVar36,(longlong)puVar18 + 0x14);
                        if (lVar17 == 0) {
                          if ((piVar36 != (int *)0x0) && (*piVar36 == 0x63737468)) {
                            *(int *)((longlong)puVar18 + 0xc) =
                                 *(int *)((longlong)puVar18 + 0xc) + 1;
                            puVar26 = *(undefined8 **)(piVar38 + 0x108);
                            puVar5 = (undefined8 *)0x0;
                            while (puVar35 = puVar26, puVar35 != (undefined8 *)0x0) {
                              puVar5 = puVar35;
                              puVar26 = (undefined8 *)*puVar35;
                            }
                            *puVar18 = 0;
                            if (puVar5 == (undefined8 *)0x0) {
                              *(undefined8 **)(piVar38 + 0x108) = puVar18;
                              piVar38[0x107] = piVar38[0x107] + 1;
                            }
                            else {
                              *puVar5 = puVar18;
                              piVar38[0x107] = piVar38[0x107] + 1;
                            }
                          }
                        }
                        else {
                          *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080593;
                          func_0x00014179cc9a(lVar17 + 0x1e,(longlong)puVar18 + 0x1e,0xaf4);
                          *(undefined4 *)(lVar17 + 0x18) = *(undefined4 *)(puVar18 + 3);
                          *(undefined1 *)(lVar17 + 0x1c) = *(undefined1 *)((longlong)puVar18 + 0x1c)
                          ;
                          *(undefined4 *)(lVar17 + 0x18) = *(undefined4 *)(puVar18 + 3);
                          *(undefined1 *)(lVar17 + 0x1d) = *(undefined1 *)((longlong)puVar18 + 0x1d)
                          ;
                          piVar36 = (int *)(lVar17 + 0xc);
                          *piVar36 = *piVar36 + -1;
                          if ((*piVar36 == 0) && (*(int *)(lVar17 + 8) == 0x63736574)) {
                            *(undefined4 *)(lVar17 + 8) = 0;
                            *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410805d1;
                            _aligned_free(lVar17);
                          }
                        }
                        piVar36 = (int *)((longlong)puVar18 + 0xc);
                        *piVar36 = *piVar36 + -1;
                        if ((*piVar36 == 0) && (*(int *)(puVar18 + 1) == 0x63736574)) {
                          *(undefined4 *)(puVar18 + 1) = 0;
                          *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410805f8;
                          _aligned_free(puVar18);
                        }
                      }
                    }
                  }
                  break;
                case 0x6a:
                  *(undefined4 *)(&stack0x00000000 + lVar14) = 0;
                  *(int **)(&stack0xfffffffffffffff8 + lVar14) = piVar38 + 0x5f;
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410807fa;
                  uVar9 = FUN_1410773d0(param_1,1,piVar38 + 0x4c,0);
                  goto joined_r0x00014108083f;
                default:
LAB_14107fd4c:
                  uVar30 = (longlong)(int)(auStack_7c0[0] - uStack_7c4) +
                           *(longlong *)(param_1 + 0x1e00170);
                  *(ulonglong *)(param_1 + 0x1e00170) = uVar30;
                  if ((uVar30 < *(ulonglong *)(param_1 + 0x1e00178)) ||
                     (*(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180) <=
                      uVar30)) {
                    *(undefined8 *)(param_1 + 0x1e00180) = 0;
                  }
                  plVar32 = (longlong *)0x0;
                  break;
                case 0x6c:
                  if (0xa00000 < auStack_7c0[0] - uStack_7c4) goto LAB_1410816e2;
                  puVar34 = (ulonglong *)(param_1 + 0xa00128);
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080622;
                  uVar9 = FUN_1410770a0(param_1,puVar34);
                  plVar32 = (longlong *)(ulonglong)uVar9;
                  if (uVar9 != 0) goto code_r0x0001410816e9;
                  if (auStack_7c0[0] - uStack_7c4 == 0xc4) {
                    if (puVar34 != (ulonglong *)0x0) {
                      uStack_728 = *puVar34;
                      uStack_720 = *(undefined8 *)(param_1 + 0xa00130);
                      uStack_718 = *(ulonglong *)(param_1 + 0xa00138);
                      uStack_710 = *(undefined8 *)(param_1 + 0xa00140);
                      uStack_708 = *(undefined8 *)(param_1 + 0xa00148);
                      uStack_700 = *(undefined8 *)(param_1 + 0xa00150);
                      uStack_6f8 = *(undefined8 *)(param_1 + 0xa00158);
                      uStack_6f0 = *(undefined8 *)(param_1 + 0xa00160);
                      uStack_6e8 = *(undefined8 *)(param_1 + 0xa00168);
                      uStack_6e0 = *(undefined8 *)(param_1 + 0xa00170);
                      uStack_6d8 = *(undefined8 *)(param_1 + 0xa00178);
                      uStack_6d0 = *(undefined8 *)(param_1 + 0xa00180);
                      uStack_6c8 = *(undefined8 *)(param_1 + 0xa00188);
                      uStack_6c0 = *(undefined8 *)(param_1 + 0xa00190);
                      uStack_6b8 = *(undefined8 *)(param_1 + 0xa00198);
                      uStack_6b0 = *(undefined8 *)(param_1 + 0xa001a0);
                      uStack_6a8 = *(undefined8 *)(param_1 + 0xa001a8);
                      uStack_6a0 = *(undefined8 *)(param_1 + 0xa001b0);
                      uStack_698 = *(undefined8 *)(param_1 + 0xa001b8);
                      uStack_690 = *(undefined8 *)(param_1 + 0xa001c0);
                      uStack_688 = *(undefined8 *)(param_1 + 0xa001c8);
                      uStack_680 = *(undefined8 *)(param_1 + 0xa001d0);
                      uStack_678 = *(undefined8 *)(param_1 + 0xa001d8);
                      uStack_670 = *(undefined8 *)(param_1 + 0xa001e0);
                      uStack_668 = *(undefined4 *)(param_1 + 0xa001e8);
                    }
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410806db;
                    func_0x000141069f90(param_1,&uStack_728);
                    uVar9 = (uint)uStack_728;
                    piVar38[0x10c] = uVar9;
                    uVar30 = 0;
                    if (uVar9 < 7) {
                      if (uVar9 == 0) break;
                    }
                    else {
                      piVar38[0x10c] = 6;
                    }
                    do {
                      piVar38[uVar30 + 0x10d] = *(int *)((longlong)&uStack_728 + uVar30 * 4 + 4);
                      uVar9 = (int)uVar30 + 1;
                      uVar30 = (ulonglong)uVar9;
                    } while (uVar9 < (uint)piVar38[0x10c]);
                  }
                  break;
                case 0x6d:
                  iVar11 = auStack_7c0[0] - uStack_7c4;
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080816;
                  lVar17 = FUN_140f00720(piVar38,0x140000001);
                  if (lVar17 == 0) {
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080832;
                    uVar9 = itl_106a520(param_1,iVar11);
                  }
                  else {
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080829;
                    uVar9 = FUN_141077ff0(param_1,lVar17,iVar11);
                  }
                  acStackX_c[lVar14] = acStackX_c[lVar14];
joined_r0x00014108083f:
                  plVar32 = (longlong *)(ulonglong)uVar9;
joined_r0x00014108083f:
                  if (uVar9 != 0) goto code_r0x0001410816e9;
                }
                uVar9 = *(uint *)((longlong)&uStackX_8 + lVar14);
LAB_14107ff7d:
                uVar9 = uVar9 + 1;
                *(uint *)((longlong)&uStackX_8 + lVar14) = uVar9;
                plVar19 = *(longlong **)(&stack0x00000038 + lVar14);
              } while (uVar9 < uStack_156c);
            }
            uVar9 = 0;
            *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107ff9c;
            cVar6 = FUN_140816cd0();
            if (cVar6 != '\0') {
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107ffa8;
              FUN_140816de0();
            }
            puVar18 = *(undefined8 **)(piVar38 + 0x1c);
            *(undefined8 **)(&stack0x00000020 + lVar14) = puVar18;
            plVar19 = (longlong *)0x0;
            *(undefined4 *)(&stack0x00000044 + lVar14) = 0;
            if (uStack_1568 != 0) {
              do {
                *(longlong **)(&stack0x00000030 + lVar14) = plVar37;
                *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107ffea;
                uVar12 = FUN_1410770a0(param_1,&uStack_15d8,8);
                plVar32 = (longlong *)(ulonglong)uVar12;
                if (uVar12 != 0) goto code_r0x0001410816e9;
                *(uint *)((longlong)&uStackX_8 + lVar14) = uStack_15d4;
                uVar12 = uStack_15d4;
                if ((char)*plVar37 == '\0') {
                  uVar12 = uStack_15d4 >> 0x18 | (uStack_15d4 & 0xff0000) >> 8 |
                           (uStack_15d4 & 0xff00) << 8 | uStack_15d4 << 0x18;
                }
                puVar27 = auStack_15d0;
                uVar10 = 0x54;
                if (uVar12 < 0x54) {
                  uVar10 = uVar12;
                }
                if (8 < uVar10) {
                  uVar13 = uVar10 - 8;
                  *(ulonglong *)(&stack0x00000010 + lVar14) = (ulonglong)uVar13;
                  if (0xa00000 < (ulonglong)uVar13) goto LAB_1410816e2;
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14108004d;
                  uVar13 = FUN_1410770a0(param_1,auStack_15d0,uVar13);
                  plVar32 = (longlong *)(ulonglong)uVar13;
                  if (uVar13 != 0) goto code_r0x0001410816e9;
                  puVar27 = (uint *)((longlong)auStack_15d0 +
                                    *(longlong *)(&stack0x00000010 + lVar14));
                  *(uint *)((longlong)&uStackX_8 + lVar14) = uStack_15d4;
                }
                uVar30 = (ulonglong)uStack_15d4;
                if ((uVar10 < 0x54) && (puVar27 != (uint *)0x0)) {
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14108008a;
                  func_0x00014179cca0(puVar27,0,0x54 - uVar10);
                  uVar30 = (ulonglong)uStack_15d4;
                  *(uint *)((longlong)&uStackX_8 + lVar14) = uStack_15d4;
                }
                if (uVar10 < uVar12) {
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410800a9;
                  uVar12 = itl_106a520(param_1,uVar12 - uVar10);
                  plVar32 = (longlong *)(ulonglong)uVar12;
                  if (uVar12 != 0) goto code_r0x0001410816e9;
                  uVar30 = (ulonglong)*(uint *)((longlong)&uStackX_8 + lVar14);
                }
                uVar12 = (uint)uVar30;
                plVar37 = *(longlong **)(&stack0x00000030 + lVar14);
                if ((char)*plVar37 == '\0') {
                  uStack_15d8 = (uStack_15d8 & 0xff0000 | uStack_15d8 >> 0x10) >> 8 |
                                (uStack_15d8 << 0x10 | uStack_15d8 & 0xff00) << 8;
                  uStack_15d4 = (uVar12 & 0xff0000 | (uint)(uVar30 >> 0x10)) >> 8 |
                                (uVar12 << 0x10 | uVar12 & 0xff00) << 8;
                  *(uint *)((longlong)&uStackX_8 + lVar14) = uStack_15d4;
                  auStack_15d0[0] =
                       (auStack_15d0[0] & 0xff0000 | auStack_15d0[0] >> 0x10) >> 8 |
                       (auStack_15d0[0] << 0x10 | auStack_15d0[0] & 0xff00) << 8;
                  auStack_15d0[1] =
                       (auStack_15d0[1] & 0xff0000 | auStack_15d0[1] >> 0x10) >> 8 |
                       (auStack_15d0[1] << 0x10 | auStack_15d0[1] & 0xff00) << 8;
                  auStack_15d0[2] =
                       (auStack_15d0[2] & 0xff0000 | auStack_15d0[2] >> 0x10) >> 8 |
                       (auStack_15d0[2] << 0x10 | auStack_15d0[2] & 0xff00) << 8;
                  auStack_15d0[3] =
                       (auStack_15d0[3] & 0xff0000 | auStack_15d0[3] >> 0x10) >> 8 |
                       (auStack_15d0[3] << 0x10 | auStack_15d0[3] & 0xff00) << 8;
                  uStack_15c0 = (uStack_15c0 & 0xff0000 | uStack_15c0 >> 0x10) >> 8 |
                                (uStack_15c0 << 0x10 | uStack_15c0 & 0xff00) << 8;
                  uStack_15b8 = (uStack_15b8 & 0xff0000 | uStack_15b8 >> 0x10) >> 8 |
                                (uStack_15b8 << 0x10 | uStack_15b8 & 0xff00) << 8;
                  uStack_159c = (((uStack_159c & 0xff000000000000 | uStack_159c >> 0x10) >> 0x10 |
                                 uStack_159c & 0xff0000000000) >> 0x10 | uStack_159c & 0xff00000000)
                                >> 8 | (((uStack_159c << 0x10 |
                                         (ulonglong)((uint)uStack_159c & 0xff00)) << 0x10 |
                                        (ulonglong)((uint)uStack_159c & 0xff0000)) << 0x10 |
                                       uStack_159c & 0xff000000) << 8;
                  uStack_1594 = (((uStack_1594 & 0xff000000000000 | uStack_1594 >> 0x10) >> 0x10 |
                                 uStack_1594 & 0xff0000000000) >> 0x10 | uStack_1594 & 0xff00000000)
                                >> 8 | (((uStack_1594 << 0x10 |
                                         (ulonglong)((uint)uStack_1594 & 0xff00)) << 0x10 |
                                        (ulonglong)((uint)uStack_1594 & 0xff0000)) << 0x10 |
                                       uStack_1594 & 0xff000000) << 8;
                  uVar12 = uStack_15d4;
                }
                *(ulonglong *)(&stack0x00000010 + lVar14) = uStack_1594;
                if (uStack_15d8 != 0x6870746d) goto LAB_1410816e2;
                plVar32 = (longlong *)0x0;
                plVar19 = plVar32;
                if (auStack_15d0[3] == uVar9) {
LAB_1410808a5:
                  if (puVar18 != (undefined8 *)0x0) goto LAB_1410808b1;
LAB_141080e18:
                  uVar30 = (longlong)(int)(auStack_15d0[0] - uVar12) +
                           *(longlong *)(param_1 + 0x1e00170);
                  *(ulonglong *)(param_1 + 0x1e00170) = uVar30;
                  if ((uVar30 < *(ulonglong *)(param_1 + 0x1e00178)) ||
                     (*(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180) <=
                      uVar30)) {
                    *(longlong **)(param_1 + 0x1e00180) = plVar19;
                  }
                  plVar32 = (longlong *)((ulonglong)plVar19 & 0xffffffff);
                }
                else {
                  puVar18 = *(undefined8 **)(piVar38 + 0x1c);
                  uVar10 = auStack_15d0[3];
                  if (auStack_15d0[3] != 0) {
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080890;
                    puVar18 = (undefined8 *)FUN_14107ea00(puVar18,auStack_15d0[3]);
                  }
                  if (puVar18 == (undefined8 *)0x0) goto LAB_1410808a5;
                  *(undefined8 **)(&stack0x00000020 + lVar14) = puVar18;
                  uVar9 = uVar10;
LAB_1410808b1:
                  bVar39 = false;
                  lStack_16a0 = puVar18[0xb];
                  puStack_16a8 = puVar18;
                  if (cStack_15bc != '\0') {
                    *(undefined4 *)(&stack0x00000040 + lVar14) = 0x780001;
                    if ((((int *)*puVar18 == piVar38) &&
                        ((0xfffffffffffffffd < lStack_16a0 - 1U ||
                         (*(undefined8 **)(lStack_16a0 + 8) == puVar18)))) &&
                       ((*(longlong *)(piVar38 + 0x1c) == 0 ||
                        (*(uint *)(*(longlong *)(piVar38 + 0x1c) + 100) < 0x7fffffff)))) {
                      *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14108090e;
                      plVar19 = (longlong *)FUN_140fbc600(piVar38,1);
                      if (plVar19 != (longlong *)0x0) {
                        *(byte *)((longlong)plVar19 + 0x4b) =
                             *(byte *)((longlong)plVar19 + 0x4b) | 0xc0;
                        lVar17 = *plVar19;
                        *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080936;
                        iVar11 = func_0x000140bfed40(lVar17 + 0x130,&stack0x00000040 + lVar14,
                                                     plVar19 + 0xd);
                        if (iVar11 == 0) {
                          *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080946;
                          FUN_140ef0700();
                          *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080955;
                          FUN_140fbcb00(plVar19,&puStack_16a8,1);
                          *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14108095d;
                          FUN_140eef7f0(plVar19);
                          *(byte *)((longlong)plVar19 + 0x4b) =
                               cStack_15bb << 7 | *(byte *)((longlong)plVar19 + 0x4b) & 0x7f;
                          *(undefined1 *)(plVar19 + 0xe) = uStack_15ae;
                          *(byte *)(piVar38 + 0x76) = *(byte *)(piVar38 + 0x76) | 2;
                          if (uStack_15c0 != 0) {
                            *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410809a3;
                            lVar17 = FUN_140693780(param_1 + 0x1e00278,&uStack_15c0);
                            if ((lVar17 != 0) && (lVar17 = *(longlong *)(lVar17 + 8), lVar17 != 0))
                            {
                              plVar19[6] = lVar17;
                              *(longlong **)(lVar17 + 0x60) = plVar19;
                            }
                          }
                          goto LAB_141080a65;
                        }
                        *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410816db;
                        FUN_140fbcf80(plVar19);
                      }
                    }
LAB_1410816db:
                    plVar32 = (longlong *)0xffffff94;
                    goto code_r0x0001410816e9;
                  }
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410809d9;
                  lVar17 = FUN_140693780(param_1 + 0x1e00278,&uStack_15c0);
                  if (lVar17 == 0) {
LAB_141080e08:
                    bVar39 = true;
                    uVar12 = *(uint *)((longlong)&uStackX_8 + lVar14);
                  }
                  else {
                    lVar17 = *(longlong *)(lVar17 + 8);
                    *(longlong *)(&stack0x00000030 + lVar14) = lVar17;
                    if ((lVar17 == 0) || (*(longlong *)(lVar17 + 0x10) == 0)) goto LAB_141080e08;
                    uStack_1678 = 0;
                    uStack_1670 = 0;
                    *(undefined8 **)(&stack0xfffffffffffffff8 + lVar14) = &uStack_1678;
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080a23;
                    plVar19 = (longlong *)
                              FUN_140ef4180(piVar38,lVar17,&puStack_16a8,
                                            *(undefined8 *)(&stack0x00000010 + lVar14));
                    if (plVar19 == (longlong *)0x0) goto LAB_1410816db;
                    *(uint *)(plVar19 + 0xb) = uStack_15b8;
                    *(byte *)((longlong)plVar19 + 0x4b) =
                         (bStack_15b0 & 1) << 5 | *(byte *)((longlong)plVar19 + 0x4b) & 0xdf;
                    if (cStack_15ba != '\0') {
                      *(byte *)(*(longlong *)(&stack0x00000030 + lVar14) + 0x9a) =
                           *(byte *)(*(longlong *)(&stack0x00000030 + lVar14) + 0x9a) | 4;
                    }
LAB_141080a65:
                    if (*(int *)(&stack0x00000018 + lVar14) < 0) {
                      *(uint *)(plVar19 + 5) = auStack_15d0[2];
                    }
                    *(uint *)((longlong)plVar19 + 0x2c) = auStack_15d0[2];
                    *(undefined4 *)(&stack0x00000030 + lVar14) = 0;
                    if (auStack_15d0[1] != 0) {
                      uVar16 = *(undefined8 *)(&stack0x00000020 + lVar14);
                      do {
                        *(undefined8 *)(&stack0x00000020 + lVar14) = uVar16;
                        *(uint *)((longlong)&uStackX_8 + lVar14) = uVar9;
                        *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080ac3;
                        uStack_1708 = plVar37;
                        uVar9 = FUN_1410770a0(param_1,&uStack_7c8,8);
                        plVar32 = (longlong *)(ulonglong)uVar9;
                        if (uVar9 != 0) goto code_r0x0001410816e9;
                        uVar9 = uStack_7c4;
                        if ((char)*plVar37 == '\0') {
                          uVar9 = uStack_7c4 >> 0x18 | (uStack_7c4 & 0xff0000) >> 8 |
                                  (uStack_7c4 & 0xff00) << 8 | uStack_7c4 << 0x18;
                        }
                        puVar27 = auStack_7c0;
                        uVar12 = 0x18;
                        if (uVar9 < 0x18) {
                          uVar12 = uVar9;
                        }
                        if (8 < uVar12) {
                          uVar10 = uVar12 - 8;
                          *(ulonglong *)(&stack0x00000010 + lVar14) = (ulonglong)uVar10;
                          if (0xa00000 < (ulonglong)uVar10) goto LAB_1410816e2;
                          *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080b21;
                          uVar10 = FUN_1410770a0(param_1,auStack_7c0,uVar10);
                          plVar32 = (longlong *)(ulonglong)uVar10;
                          if (uVar10 != 0) goto code_r0x0001410816e9;
                          puVar27 = (uint *)((longlong)auStack_7c0 +
                                            *(longlong *)(&stack0x00000010 + lVar14));
                        }
                        uVar30 = (ulonglong)uStack_7c4;
                        if ((uVar12 < 0x18) && (puVar27 != (uint *)0x0)) {
                          *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080b59;
                          func_0x00014179cca0(puVar27,0,0x18 - uVar12);
                          uVar30 = (ulonglong)uStack_7c4;
                        }
                        if (uVar12 < uVar9) {
                          *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080b73;
                          uVar9 = itl_106a520(param_1,uVar9 - uVar12);
                          plVar32 = (longlong *)(ulonglong)uVar9;
                          if (uVar9 != 0) goto code_r0x0001410816e9;
                        }
                        plVar37 = uStack_1708;
                        uVar9 = (uint)uVar30;
                        if ((char)*uStack_1708 == '\0') {
                          uStack_7c8 = (uStack_7c8 & 0xff0000 | uStack_7c8 >> 0x10) >> 8 |
                                       (uStack_7c8 << 0x10 | uStack_7c8 & 0xff00) << 8;
                          uVar9 = (uVar9 & 0xff0000 | (uint)(uVar30 >> 0x10) & 0xffff) >> 8 |
                                  (uVar9 << 0x10 | uVar9 & 0xff00) << 8;
                          auStack_7c0[0] =
                               (auStack_7c0[0] & 0xff0000 | auStack_7c0[0] >> 0x10) >> 8 |
                               (auStack_7c0[0] << 0x10 | auStack_7c0[0] & 0xff00) << 8;
                          auStack_7c0[1] =
                               (auStack_7c0[1] & 0xff0000 | auStack_7c0[1] >> 0x10) >> 8 |
                               (auStack_7c0[1] << 0x10 | auStack_7c0[1] & 0xff00) << 8;
                          auStack_7c0[2] =
                               (auStack_7c0[2] & 0xff0000 | auStack_7c0[2] >> 0x10) >> 8 |
                               (auStack_7c0[2] << 0x10 | auStack_7c0[2] & 0xff00) << 8;
                          uStack_7c4 = uVar9;
                        }
                        if (uStack_7c8 != 0x686f686d) goto LAB_1410816e2;
                        if (auStack_7c0[1] == 200) {
                          plVar32 = plVar19 + 0xd;
LAB_141080da4:
                          *(undefined4 *)(&stack0x00000000 + lVar14) = 0;
                          *(longlong **)(&stack0xfffffffffffffff8 + lVar14) = plVar32;
                          *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080dc2;
                          uVar12 = FUN_1410773d0(param_1,1,piVar38 + 0x4c);
                          plVar32 = (longlong *)(ulonglong)uVar12;
                          uVar9 = *(uint *)((longlong)&uStackX_8 + lVar14);
                          uVar16 = *(undefined8 *)(&stack0x00000020 + lVar14);
                          *(undefined8 *)(&stack0x00000020 + lVar14) = uVar16;
                          if (uVar12 != 0) goto code_r0x0001410816e9;
                        }
                        else {
                          if (auStack_7c0[1] == 0xc9) {
                            plVar32 = (longlong *)((longlong)plVar19 + 0x6c);
                            goto LAB_141080da4;
                          }
                          if ((auStack_7c0[1] == 0xca) || (auStack_7c0[1] == 0xcb)) {
                            uVar30 = (longlong)(int)(auStack_7c0[0] - uVar9) +
                                     *(longlong *)(param_1 + 0x1e00170);
                            *(ulonglong *)(param_1 + 0x1e00170) = uVar30;
                            if ((uVar30 < *(ulonglong *)(param_1 + 0x1e00178)) ||
                               (*(ulonglong *)(param_1 + 0x1e00178) +
                                *(longlong *)(param_1 + 0x1e00180) <= uVar30)) {
                              *(undefined8 *)(param_1 + 0x1e00180) = 0;
                              plVar32 = (longlong *)0x0;
                              uVar9 = *(uint *)((longlong)&uStackX_8 + lVar14);
                              uVar16 = *(undefined8 *)(&stack0x00000020 + lVar14);
                              *(undefined8 *)(&stack0x00000020 + lVar14) = uVar16;
                            }
                            else {
                              plVar32 = (longlong *)0x0;
                              uVar9 = *(uint *)((longlong)&uStackX_8 + lVar14);
                              uVar16 = *(undefined8 *)(&stack0x00000020 + lVar14);
                              *(undefined8 *)(&stack0x00000020 + lVar14) = uVar16;
                            }
                          }
                          else {
                            uVar30 = (longlong)(int)(auStack_7c0[0] - uVar9) +
                                     *(longlong *)(param_1 + 0x1e00170);
                            *(ulonglong *)(param_1 + 0x1e00170) = uVar30;
                            if ((uVar30 < *(ulonglong *)(param_1 + 0x1e00178)) ||
                               (*(ulonglong *)(param_1 + 0x1e00178) +
                                *(longlong *)(param_1 + 0x1e00180) <= uVar30)) {
                              plVar32 = (longlong *)0x0;
                              *(undefined8 *)(param_1 + 0x1e00180) = 0;
                              uVar9 = *(uint *)((longlong)&uStackX_8 + lVar14);
                              uVar16 = *(undefined8 *)(&stack0x00000020 + lVar14);
                            }
                            else {
                              plVar32 = (longlong *)0x0;
                              uVar9 = *(uint *)((longlong)&uStackX_8 + lVar14);
                              uVar16 = *(undefined8 *)(&stack0x00000020 + lVar14);
                            }
                          }
                        }
                        iVar11 = *(int *)(&stack0x00000030 + lVar14);
                        *(uint *)(&stack0x00000030 + lVar14) = iVar11 + 1U;
                      } while (iVar11 + 1U < auStack_15d0[1]);
                    }
                    uVar12 = uStack_15d4;
                    if ((*(byte *)((longlong)plVar19 + 0x4b) & 1) != 0) {
                      *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080dff;
                      FUN_140ef0700();
                      uVar12 = uStack_15d4;
                    }
                  }
                  plVar19 = (longlong *)0x0;
                  if (bVar39) goto LAB_141080e18;
                }
                iVar11 = *(int *)(&stack0x00000044 + lVar14);
                *(uint *)(&stack0x00000044 + lVar14) = iVar11 + 1U;
                puVar18 = *(undefined8 **)(&stack0x00000020 + lVar14);
              } while (iVar11 + 1U < uStack_1568);
            }
            if ((piVar38 + 0x4c != (int *)0x0) && (piVar38[0x4c] == 0x73747263)) {
              plVar15 = *(longlong **)(piVar38 + 0x4e);
              if (plVar15 != (longlong *)0x0) {
                if ((int)plVar15[1] == 0x4d656d48) {
                  if (*plVar15 != 0) {
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080ea8;
                    _aligned_free();
                    plVar19 = (longlong *)0x0;
                    *plVar15 = 0;
                  }
                  *(int *)(plVar15 + 1) = (int)plVar19;
                  plVar15[2] = (longlong)plVar19;
                  plVar15[3] = (longlong)plVar19;
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080ec3;
                  _aligned_free();
                  plVar19 = (longlong *)0x0;
                }
                *(longlong **)(piVar38 + 0x4e) = plVar19;
              }
              piVar38[0x56] = (int)plVar19;
            }
            if (acStackX_c[lVar14 + 1] != '\0') {
              iVar11 = piVar38[0x5e];
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080ef3;
              FUN_140bff470(piVar38 + 0x4c,iVar11,&uStack_258);
              uVar16 = *(undefined8 *)kCFAllocatorNull_exref;
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080f19;
              lVar17 = CFStringCreateWithCharactersNoCopy
                                 (_DAT_1420a6090,(longlong)&uStack_258 + 2,(undefined2)uStack_258,
                                  uVar16);
              if ((_DAT_1420affa8 == 0) || (lVar17 == 0)) {
LAB_141080f42:
                if (_DAT_1420cfce0 == 0) {
LAB_141080f7d:
                  lVar20 = _DAT_1420adbf8;
                }
                else {
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080f59;
                  lVar20 = CFDictionaryGetValue(_DAT_1420cfce0,0x7f0001);
                  if (lVar20 != 0) {
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080f6a;
                    lVar21 = CFGetTypeID(lVar20);
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080f73;
                    lVar22 = CFStringGetTypeID();
                    if (lVar21 != lVar22) goto LAB_141080f7d;
                  }
                  if (lVar20 == 0) goto LAB_141080f7d;
                }
                uVar33 = 0;
                uStack_258 = (uint)uStack_258._2_2_ << 0x10;
                if (lVar20 != 0) {
                  plStack_1698 = (longlong *)0x0;
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080fa4;
                  lStack_1690 = CFStringGetLength(lVar20);
                  uVar33 = 0;
                  if (lStack_1690 != 0) {
                    if (0xff < lStack_1690) {
                      lStack_1690 = 0xff;
                    }
                    lVar21 = lStack_1690;
                    uStack_1708 = plStack_1698;
                    lStack_1700 = lStack_1690;
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080fe0;
                    FUN_140b92160(lVar20,&uStack_1708,(longlong)&uStack_258 + 2);
                    uVar33 = (ushort)lVar21;
                  }
                  uStack_258 = CONCAT22(uStack_258._2_2_,uVar33);
                }
                piVar36 = piVar38 + 0x4c;
                if (uVar33 < 0x100) {
                  if (((piVar36 == (int *)0x0) || (*piVar36 != 0x73747263)) || (piVar38[0x56] != 0))
                  goto LAB_141081009;
                  iVar11 = piVar38[0x5e];
                  lVar20 = (longlong)iVar11;
                  if (piVar38[0x5b] != 0) goto LAB_141081009;
                  if (iVar11 != 0) {
                    if ((iVar11 < 1) || (piVar38[0x57] < iVar11)) goto LAB_141081009;
                    if ((piVar38[0x4d] & 1U) != 0) {
                      piVar1 = (int *)(**(longlong **)(piVar38 + 0x52) + -4 + lVar20 * 4);
                      *piVar1 = *piVar1 + -1;
                      if (*piVar1 != 0) goto LAB_141081138;
                    }
                    lVar21 = **(longlong **)(piVar38 + 0x50);
                    piVar38[0x5c] = piVar38[0x5c] + *(int *)(lVar21 + -4 + lVar20 * 8);
                    *(undefined4 *)(lVar21 + -8 + lVar20 * 8) = 0x80000001;
                  }
LAB_141081138:
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141081147;
                  uVar9 = FUN_140bfe1f0(piVar36,(longlong)&uStack_258 + 2);
                  plVar32 = (longlong *)(ulonglong)uVar9;
                }
                else {
                  piVar38[0x5e] = 0;
LAB_141081009:
                  plVar32 = (longlong *)0xffffffce;
                }
                if (lVar17 == 0) goto LAB_14108101c;
              }
              else {
                *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141080f39;
                lVar20 = CFStringCompare(_DAT_1420affa8,lVar17,0);
                if (lVar20 == 0) goto LAB_141080f42;
              }
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14108101c;
              CFRelease();
            }
LAB_14108101c:
            piVar36 = piStack_16b0;
            if (acStackX_c[lVar14] != '\0') {
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141081037;
              FUN_1410cc5c0(&uStack_1668,&uStack_1708,0);
              piVar36 = piStack_16b0;
              piStack_16f8 = piStack_16b0;
              plStack_16f0 = *(longlong **)(&stack0x00000050 + lVar14);
              uVar8 = uStack_1708._2_1_;
              if (cStack_136e != '\0') {
                uVar8 = 1;
              }
              uStack_1708._0_3_ = CONCAT12(uVar8,(undefined2)uStack_1708);
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14108106a;
              FUN_140ee4d70();
              if ((*(byte *)(*(longlong *)(&stack0x00000038 + lVar14) + 0x113) & 1) == 0) {
                if (((*piVar38 == 0x706c7374) && ((*(byte *)(piVar38 + 0x8a) & 1) != 0)) &&
                   ((*(char *)((longlong)piVar38 + 0x232) != '\0' &&
                    (*(longlong *)(piVar38 + 0x90) != 0)))) {
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410810aa;
                  cVar6 = FUN_140ee6260();
                  if (cVar6 != '\0') goto LAB_14108114e;
                }
                bVar29 = 0;
              }
              else {
LAB_14108114e:
                bVar29 = 1;
              }
              if ((((((*piVar38 == 0x706c7374) &&
                     (bVar28 = *(byte *)(piVar38 + 0x8a), (bVar28 & 1) != 0)) &&
                    ((bVar28 >> 2 & 1) != bVar29)) &&
                   ((*(byte *)(piVar38 + 0x8a) = bVar28 & 0xfb | bVar29 << 2, bVar29 == 1 &&
                    (lVar17 = *(longlong *)(piVar38 + 2), lVar17 != 0)))) &&
                  (*(int *)(lVar17 + 0x80) == 0x74646174)) &&
                 (((*(byte *)(lVar17 + 0x112) & 0x10) == 0 &&
                  (*(byte *)(lVar17 + 0x112) = *(byte *)(lVar17 + 0x112) | 0x10,
                  DAT_141fe9d50 != '\0')))) {
                *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410811c4;
                FUN_140cb1c20();
              }
              if ((cStack_136e != '\0') &&
                 (*(byte *)(piVar38 + 0x8a) = *(byte *)(piVar38 + 0x8a) | 2, *piVar38 == 0x706c7374)
                 ) {
                for (puVar18 = *(undefined8 **)(piVar38 + 0x108); puVar18 != (undefined8 *)0x0;
                    puVar18 = (undefined8 *)*puVar18) {
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410811fe;
                  FUN_140fb3430(piVar38,puVar18,0);
                  if (*(int *)(puVar18 + 1) != 0x63736574) break;
                }
              }
            }
            if ((((piVar36 != (int *)0x0) && (*piVar36 == 0x534c7374)) && (piVar36[1] != 0)) &&
               (iVar11 = piVar36[1] + -1, piVar36[1] = iVar11, iVar11 == 0)) {
              if (*(longlong *)(piVar36 + 0x18) != 0) {
                uVar9 = 0;
                if (piVar36[4] != 0) {
                  puVar18 = (undefined8 *)(*(longlong *)(piVar36 + 0x18) + 0x10);
                  do {
                    if (*(char *)(puVar18 + -1) != '\0') {
                      uVar16 = *puVar18;
                      *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141081272;
                      FUN_140bef7f0(uVar16);
                    }
                    puVar18 = puVar18 + 4;
                    uVar9 = uVar9 + 1;
                  } while (uVar9 < (uint)piVar36[4]);
                }
                if (*(longlong *)(piVar36 + 0x18) != 0) {
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141081290;
                  _aligned_free();
                }
              }
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14108129a;
              FUN_140bfdfd0(piVar36 + 6);
              piVar36[0] = 0;
              piVar36[1] = 0;
              piVar36[2] = 0;
              piVar36[3] = 0;
              piVar36[4] = 0;
              piVar36[5] = 0;
              piVar36[6] = 0;
              piVar36[7] = 0;
              piVar36[8] = 0;
              piVar36[9] = 0;
              piVar36[10] = 0;
              piVar36[0xb] = 0;
              piVar36[0xc] = 0;
              piVar36[0xd] = 0;
              piVar36[0xe] = 0;
              piVar36[0xf] = 0;
              piVar36[0x10] = 0;
              piVar36[0x11] = 0;
              piVar36[0x12] = 0;
              piVar36[0x13] = 0;
              piVar36[0x14] = 0;
              piVar36[0x15] = 0;
              piVar36[0x16] = 0;
              piVar36[0x17] = 0;
              piVar36[0x18] = 0;
              piVar36[0x19] = 0;
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410812d0;
              _aligned_free();
            }
            piVar36 = *(int **)(&stack0x00000050 + lVar14);
            if (((piVar36 != (int *)0x0) && (*piVar36 == 0x4f4c5354)) &&
               ((piVar36[1] != 0 && (iVar11 = piVar36[1] + -1, piVar36[1] = iVar11, iVar11 == 0))))
            {
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410812fa;
              FUN_1402de700(piVar36 + 2);
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141081307;
              func_0x000140bc6a20(piVar36,0x20);
            }
            if (*(char *)(param_1 + 0x1e002f2) == '\0') {
LAB_1410814bd:
              if ((&stack0x0000001c)[lVar14] != '\0') goto LAB_1410814ca;
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14108162a;
              FUN_140efa780(piVar38);
            }
            else {
              if (*piVar38 != 0x706c7374) {
LAB_1410814b3:
                *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410814bd;
                FUN_140ef19a0(piVar38,0);
                goto LAB_1410814bd;
              }
              lVar17 = *(longlong *)(piVar38 + 2);
              if (((lVar17 == 0) || (*(int *)(lVar17 + 0x80) != 0x74646174)) ||
                 (((*(byte *)(lVar17 + 0x110) & 1) == 0 ||
                  (((*(byte *)((longlong)piVar38 + 0x1da) & 0x10) == 0 ||
                   ((*(byte *)((longlong)piVar38 + 0x181) & 4) != 0)))))) {
LAB_14108144a:
                if (*piVar38 == 0x706c7374) {
                  if ((((*(longlong *)(piVar38 + 2) != 0) &&
                       (*(longlong *)(*(longlong *)(piVar38 + 2) + 0x1928) != 0)) &&
                      (uVar30 = *(ulonglong *)(piVar38 + 0x62), uVar30 != 0xfffffffffffffffd)) &&
                     ((uVar30 < 0xfffffffffffffffe && (uVar30 != 0)))) {
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141081484;
                    FUN_140f01080();
                  }
                  *(undefined1 *)(piVar38 + 0x60) = 0;
                  *(undefined1 *)(piVar38 + 0x66) = 0;
                  piVar38[0x67] = 0;
                  *(undefined2 *)((longlong)piVar38 + 0x182) = 0;
                  piVar38[0x62] = 0;
                  piVar38[99] = 0;
                  piVar38[100] = 0;
                  piVar38[0x65] = 0;
                }
                goto LAB_1410814b3;
              }
              *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141081373;
              FUN_140ef1df0(&plStack_1718,piVar38);
              if (((plStack_1718 == (longlong *)0x0) || (*plStack_1718 == 0)) &&
                 ((plStack_1710 == (longlong *)0x0 || (*plStack_1710 == 0)))) {
                if (plStack_1718 != (longlong *)0x0) {
                  LOCK();
                  plVar19 = plStack_1718 + 1;
                  lVar17 = *plVar19;
                  *(int *)plVar19 = (int)*plVar19 + -1;
                  UNLOCK();
                  if ((int)lVar17 == 1) {
                    *(undefined4 *)(plStack_1718 + 1) = 0xc4653600;
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14108141a;
                    func_0x00014179bdd8(plStack_1718);
                  }
                  plStack_1718 = (longlong *)0x0;
                }
                if (plStack_1710 != (longlong *)0x0) {
                  LOCK();
                  plVar19 = plStack_1710 + 1;
                  lVar17 = *plVar19;
                  *(int *)plVar19 = (int)*plVar19 + -1;
                  UNLOCK();
                  if ((int)lVar17 == 1) {
                    *(undefined4 *)(plStack_1710 + 1) = 0xc4653600;
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141081446;
                    func_0x00014179bdd8();
                  }
                  plStack_1710 = (longlong *)0x0;
                }
                goto LAB_14108144a;
              }
              if (plStack_1718 != (longlong *)0x0) {
                LOCK();
                plVar19 = plStack_1718 + 1;
                lVar17 = *plVar19;
                *(int *)plVar19 = (int)*plVar19 + -1;
                UNLOCK();
                if ((int)lVar17 == 1) {
                  *(undefined4 *)(plStack_1718 + 1) = 0xc4653600;
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410813b9;
                  func_0x00014179bdd8(plStack_1718);
                }
                plStack_1718 = (longlong *)0x0;
              }
              if (plStack_1710 != (longlong *)0x0) {
                LOCK();
                plVar19 = plStack_1710 + 1;
                lVar17 = *plVar19;
                *(int *)plVar19 = (int)*plVar19 + -1;
                UNLOCK();
                if ((int)lVar17 == 1) {
                  *(undefined4 *)(plStack_1710 + 1) = 0xc4653600;
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410813e9;
                  func_0x00014179bdd8();
                }
                plStack_1710 = (longlong *)0x0;
              }
LAB_1410814ca:
              if (*piVar38 == 0x706c7374) {
                lVar17 = *(longlong *)(piVar38 + 0xe);
                while (lVar17 != 0) {
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410814ed;
                  FUN_140ef3bd0(lVar17,0,0);
                  lVar17 = *(longlong *)(piVar38 + 0xe);
                }
                piVar36 = *(int **)(piVar38 + 6);
                if (((piVar36 != (int *)0x0) && ((*(byte *)(piVar36 + 0x8a) & 2) != 0)) &&
                   ((*piVar38 == 0x706c7374 && (*piVar36 == 0x706c7374)))) {
                  uStack_1708 = *(longlong **)(piVar38 + 0x14);
                  lStack_1700 = 0;
                  uStack_16e8 = 0;
                  uStack_16d8 = 0;
                  uStack_16d3 = 0;
                  uStack_16d1 = 0;
                  uStack_16d0 = 0;
                  uStack_16c8 = 0;
                  piStack_16f8 = (int *)0x1;
                  uStack_16e0 = 1;
                  uStack_16dc = 0;
                  plStack_16f0 = uStack_1708;
                  *(undefined4 **)(&stack0x00000000 + lVar14) = auStack_16b8;
                  uVar16 = *(undefined8 *)(piVar36 + 0x90);
                  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141081576;
                  iVar11 = FUN_140bf0910(uVar16);
                  if (iVar11 == 0) {
                    uVar16 = *(undefined8 *)(piVar36 + 0x90);
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14108158d;
                    FUN_140befe50(uVar16,auStack_16b8[0]);
                    uVar16 = *(undefined8 *)(piVar36 + 0x90);
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410815a0;
                    FUN_140fdb0b0(uVar16,piVar36 + 0x98);
                    do {
                      if ((*piVar36 == 0x706c7374) && ((*(byte *)(piVar36 + 0x8a) & 5) == 1)) {
                        *(byte *)(piVar36 + 0x8a) = *(byte *)(piVar36 + 0x8a) | 4;
                        lVar17 = *(longlong *)(piVar36 + 2);
                        if ((lVar17 != 0) &&
                           (((*(int *)(lVar17 + 0x80) == 0x74646174 &&
                             ((*(byte *)(lVar17 + 0x112) & 0x10) == 0)) &&
                            (*(byte *)(lVar17 + 0x112) = *(byte *)(lVar17 + 0x112) | 0x10,
                            DAT_141fe9d50 != '\0')))) {
                          *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410815fc;
                          FUN_140cb1c20();
                        }
                      }
                      piVar36 = *(int **)(piVar36 + 6);
                    } while (piVar36 != (int *)0x0);
                    uVar16 = *(undefined8 *)(piVar38 + 2);
                    *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141081610;
                    FUN_140ee5b20(uVar16,1);
                  }
                }
                *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x141081620;
                FUN_140ef4580(piVar38,0x706c6465,0);
              }
            }
            if (((*(byte *)(piVar38 + 0x76) & 8) != 0) && (*(ushort *)(param_1 + 0xc) < 0x29)) {
              if (_DAT_1420a6f30 == 0) {
                lVar17 = 0x1420b2a40;
              }
              else {
                lVar17 = _DAT_1420a6f30 + 0x236;
              }
              if ((((float)(int)*(short *)(lVar17 + 0xf7ac) == -1.0) &&
                  ((float)(int)*(short *)(lVar17 + 0xf7ae) == -1.0)) && (sStack_13c6 != 0)) {
                *(undefined2 *)(lVar17 + 0xf7ac) = uStack_13c8;
                *(short *)(lVar17 + 0xf7ae) = sStack_13c6;
                *(undefined2 *)(lVar17 + 0xf7b0) = 0xffff;
              }
            }
            *(longlong *)(param_1 + 0x1e00190) = *(longlong *)(param_1 + 0x1e00190) + 1;
            *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410816c7;
            FUN_141077340(param_1);
          }
          else {
LAB_14107f20a:
            uVar33 = (ushort)bVar29;
LAB_14107f20d:
            if ((uVar33 != 0x16) && (uVar33 != 0x34)) {
              if ((uVar33 == 0) || ((ushort)(uVar33 - 200) < 7)) {
                uVar9 = *(uint *)(&stack0x00000018 + lVar14);
              }
              else {
LAB_14107f22f:
                uVar9 = *(uint *)(&stack0x00000018 + lVar14);
                if ((uVar9 >> 0xb & 1) != 0) goto LAB_14107f24a;
              }
              if (uVar33 == 10) {
                bVar39 = (uVar9 & 2) == 0;
              }
              else if (uVar33 == 0x1f) {
                bVar39 = (uVar9 & 1) == 0;
              }
              else {
                if (uVar33 != 0x13) {
                  if (uVar33 != 6) {
                    if (uVar33 == 7) {
                      uVar9 = *(uint *)(&stack0x00000018 + lVar14);
                      if (-1 < (char)uVar9) goto LAB_14107f2b1;
                    }
                    else if (uVar33 != 0x12) goto LAB_14107f2ad;
                  }
                  goto LAB_14107f24a;
                }
                bVar39 = (uVar9 & 4) == 0;
              }
              if (bVar39) goto LAB_14107f2b1;
            }
LAB_14107f24a:
            *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107f259;
            FUN_14107ea60(param_1,&iStack_1578);
            *(longlong *)(param_1 + 0x1e00190) = *(longlong *)(param_1 + 0x1e00190) + 1;
          }
          iVar11 = *(int *)(&stack0x00000048 + lVar14);
          *(uint *)(&stack0x00000048 + lVar14) = iVar11 + 1U;
        } while (iVar11 + 1U < auStack_780[0]);
      }
      goto code_r0x0001410816e9;
    }
  }
  else {
    uVar30 = (ulonglong)(uVar12 - 8);
    if (uVar30 < 0xa00001) {
      *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x14107ef63;
      uVar10 = FUN_1410770a0(param_1,auStack_780,uVar30);
      plVar32 = (longlong *)(ulonglong)uVar10;
      if (uVar10 != 0) goto code_r0x0001410816e9;
      puVar27 = (uint *)((longlong)auStack_780 + uVar30);
      goto LAB_14107ef7e;
    }
  }
LAB_1410816e2:
  plVar32 = (longlong *)0xffffff30;
code_r0x0001410816e9:
  *(undefined8 *)((longlong)&uStack_30 + lVar14) = 0x1410816f8;
  return plVar32;
}

