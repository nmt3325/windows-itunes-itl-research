/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1071260; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

longlong * FUN_141071260(longlong param_1,int *param_2,undefined8 param_3,undefined8 param_4)

{
  int *piVar1;
  char *pcVar2;
  byte bVar3;
  short sVar4;
  code *pcVar5;
  undefined8 *puVar6;
  uint uVar7;
  undefined1 uVar8;
  undefined2 uVar9;
  bool bVar10;
  char cVar11;
  uint uVar12;
  int iVar13;
  longlong lVar14;
  longlong lVar15;
  longlong lVar16;
  ulonglong *puVar17;
  ulonglong *puVar18;
  undefined8 uVar19;
  undefined8 uVar20;
  undefined1 uVar21;
  longlong lVar22;
  longlong *plVar23;
  ulonglong uVar24;
  undefined1 uVar25;
  uint uVar26;
  longlong *plVar27;
  uint *puVar28;
  int *piVar30;
  ulonglong uVar31;
  longlong *plVar32;
  uint *puVar33;
  undefined1 *puVar34;
  undefined4 uVar35;
  uint uVar36;
  ulonglong uVar37;
  double dVar39;
  undefined8 unaff_XMM6_Qa;
  undefined8 unaff_XMM6_Qb;
  undefined4 unaff_XMM7_Da;
  undefined4 unaff_XMM7_Db;
  undefined4 unaff_XMM7_Dc;
  undefined4 unaff_XMM7_Dd;
  undefined8 unaff_XMM8_Qa;
  undefined8 unaff_XMM8_Qb;
  uint auStackX_8 [2];
  longlong lStackX_10;
  undefined8 uStackX_18;
  char acStackX_20 [6];
  char acStackX_26 [2];
  int aiStack_1518 [4];
  undefined4 uStack_1508;
  undefined4 uStack_1504;
  int iStack_1500;
  int iStack_14fc;
  undefined2 uStack_14f4;
  byte bStack_14f2;
  undefined2 uStack_14f0;
  undefined2 uStack_14ee;
  int iStack_14ec;
  undefined2 uStack_14e8;
  undefined2 uStack_14e6;
  undefined2 uStack_14e4;
  undefined2 uStack_14e2;
  undefined2 uStack_1352;
  undefined8 uStack_1350;
  byte bStack_1348;
  byte bStack_1346;
  undefined1 uStack_1345;
  undefined8 uStack_1344;
  byte bStack_133b;
  byte bStack_133a;
  byte bStack_1337;
  undefined8 uStack_1334;
  byte bStack_1300;
  byte bStack_12fe;
  undefined8 uStack_12f8;
  undefined1 uStack_12ee;
  undefined4 uStack_12e4;
  undefined8 uStack_12e0;
  undefined8 uStack_12d8;
  undefined1 uStack_12d0;
  undefined1 uStack_12cf;
  undefined1 uStack_12ce;
  undefined8 uStack_12cc;
  undefined8 uStack_12c4;
  undefined8 uStack_12bc;
  undefined8 uStack_12b4;
  undefined8 uStack_12ac;
  undefined8 uStack_12a4;
  undefined8 uStack_129c;
  int iStack_1294;
  undefined1 uStack_dd8;
  byte bStack_dd3;
  byte bStack_dd1;
  undefined8 uStack_8c0;
  undefined8 uStack_8b8;
  undefined8 uStack_8b0;
  undefined8 uStack_8a8;
  int iStack_8a0;
  int iStack_89c;
  int iStack_898;
  byte bStack_894;
  byte bStack_893;
  undefined1 uStack_892;
  byte bStack_891;
  undefined4 uStack_890;
  undefined8 uStack_88c;
  undefined8 uStack_884;
  byte bStack_87c;
  undefined1 uStack_87b;
  undefined1 uStack_87a;
  byte bStack_878;
  undefined1 uStack_877;
  byte bStack_876;
  byte bStack_875;
  int iStack_874;
  undefined2 uStack_870;
  undefined2 uStack_86e;
  undefined2 uStack_86c;
  undefined2 uStack_86a;
  int iStack_7c8;
  byte bStack_7b4;
  byte bStack_7b3;
  byte bStack_7b2;
  undefined1 uStack_7b1;
  undefined8 uStack_7b0;
  undefined8 uStack_7a8;
  undefined8 uStack_7a0;
  undefined8 uStack_798;
  int iStack_790;
  byte bStack_780;
  byte bStack_77f;
  byte bStack_77e;
  undefined1 uStack_77d;
  ushort uStack_758;
  undefined1 auStack_756 [10];
  uint uStack_74c;
  uint uStack_748;
  undefined4 uStack_744;
  undefined8 uStack_740;
  undefined8 uStack_738;
  undefined8 uStack_730;
  undefined8 uStack_728;
  undefined8 uStack_720;
  undefined8 uStack_718;
  undefined8 uStack_710;
  undefined8 uStack_708;
  undefined8 uStack_700;
  undefined8 uStack_6f8;
  undefined8 uStack_6f0;
  undefined2 uStack_288;
  undefined1 auStack_286 [510];
  ulonglong uStack_88;
  undefined8 uStack_48;
  longlong *plVar29;
  ulonglong uVar38;
  
  uStack_48 = 0x14107127f;
  lVar14 = FUN_1418677a0();
  lVar14 = -lVar14;
  *(undefined8 *)(&stack0x00001510 + lVar14) = unaff_XMM6_Qa;
  *(undefined8 *)(&stack0x00001518 + lVar14) = unaff_XMM6_Qb;
  *(undefined4 *)(&stack0x00001500 + lVar14) = unaff_XMM7_Da;
  *(undefined4 *)(&stack0x00001504 + lVar14) = unaff_XMM7_Db;
  *(undefined4 *)(&stack0x00001508 + lVar14) = unaff_XMM7_Dc;
  *(undefined4 *)(&stack0x0000150c + lVar14) = unaff_XMM7_Dd;
  *(undefined8 *)(&stack0x000014f0 + lVar14) = unaff_XMM8_Qa;
  *(undefined8 *)(&stack0x000014f8 + lVar14) = unaff_XMM8_Qb;
  uStack_88 = _DAT_141fd5040 ^ (ulonglong)(&stack0xffffffffffffffc0 + lVar14);
  *(int **)((longlong)&uStackX_18 + lVar14) = param_2;
  plVar29 = (longlong *)0x0;
  piVar30 = param_2 + 0x4c;
  if ((piVar30 != (int *)0x0) && (*piVar30 == 0x73747263)) {
    param_2[0x5b] = param_2[0x5b] + 1;
  }
  lVar22 = *(longlong *)(param_1 + 0x120);
  *(undefined8 *)((longlong)&lStackX_10 + lVar14) = 0;
  if (*(char *)(lVar22 + 5) == '\0') {
    uVar19 = *(undefined8 *)(lVar22 + 8);
    *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071306;
    uVar12 = FUN_140bd6640(uVar19,(longlong)&lStackX_10 + lVar14);
    plVar27 = (longlong *)(ulonglong)uVar12;
    if (uVar12 == 0) {
      lVar15 = *(longlong *)((longlong)&lStackX_10 + lVar14);
      goto LAB_141071315;
    }
LAB_141072543:
    param_2 = param_2 + 0x4c;
    if (param_2 == (int *)0x0) goto LAB_141072560;
  }
  else {
    lVar15 = *(longlong *)(lVar22 + 0x40);
    *(longlong *)((longlong)&lStackX_10 + lVar14) = lVar15;
LAB_141071315:
    if (*(char *)(lVar22 + 5) == '\0') {
      lVar22 = *(longlong *)(lVar22 + 0x20) - *(longlong *)(lVar22 + 0x30);
    }
    else {
      lVar22 = (*(longlong *)(lVar22 + 0x20) - *(longlong *)(lVar22 + 0x38)) + -1;
    }
    *(longlong *)((longlong)&lStackX_10 + lVar14) = lVar15 + lVar22;
    *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071345;
    func_0x00014179cca0(&uStack_1508,0,0xdac);
    uStack_1508 = 0x6870696d;
    uStack_1504 = 0xdac;
    uStack_14f4 = 0;
    bStack_14f2 = *(byte *)(param_2 + 0x76) >> 3 & 1;
    iStack_14ec = param_2[0x7d];
    iStack_1294 = param_2[0x7e];
    bStack_1348 = *(byte *)((longlong)param_2 + 0x2ca);
    bStack_133b = bStack_1348 >> 4 & 1;
    bStack_133a = bStack_1348 >> 5 & 1;
    uStack_dd8 = *(undefined1 *)((longlong)param_2 + 0x2cd);
    uStack_12ee = (undefined1)param_2[0xb3];
    bStack_1348 = bStack_1348 >> 7;
    bStack_dd3 = *(byte *)((longlong)param_2 + 0x2cb) & 1;
    bStack_dd1 = *(byte *)((longlong)param_2 + 0x2cb) >> 1 & 1;
    uStack_14e8 = (undefined2)param_2[0xb7];
    uStack_14e6 = *(undefined2 *)((longlong)param_2 + 0x2de);
    uStack_14e4 = (undefined2)param_2[0xb8];
    uStack_14e2 = *(undefined2 *)((longlong)param_2 + 0x2e2);
    uStack_1352 = (undefined2)param_2[0xb9];
    uStack_870 = *(undefined2 *)((longlong)param_2 + 0x2e6);
    uStack_86e = (undefined2)param_2[0xba];
    uStack_86c = *(undefined2 *)((longlong)param_2 + 0x2ea);
    uStack_86a = (undefined2)param_2[0xbb];
    uStack_12e4 = 0;
    if (param_2[0x11c] == 0x34) {
      uStack_12e4 = 0x33;
    }
    else if (param_2[0x11c] == 0x35) {
      uStack_12e4 = 0x34;
    }
    if (param_2[0x11d] != 0) {
      *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071487;
      uStack_890 = func_0x000141070b60();
    }
    uStack_892 = *(undefined1 *)((longlong)param_2 + 0x47a);
    *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410714a2;
    lVar22 = FUN_140fb4370(param_2);
    if (lVar22 == 0) {
      *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410714db;
      lVar22 = FUN_140fb4290(param_2);
      if (lVar22 != 0) goto LAB_1410714b0;
      uVar35 = 1;
      uVar25 = 0;
    }
    else {
LAB_1410714b0:
      uVar25 = *(undefined1 *)(lVar22 + 0x1c);
      uVar35 = *(undefined4 *)(lVar22 + 0x18);
      piVar1 = (int *)(lVar22 + 0xc);
      *piVar1 = *piVar1 + -1;
      if ((*piVar1 == 0) && (*(int *)(lVar22 + 8) == 0x63736574)) {
        *(undefined4 *)(lVar22 + 8) = 0;
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410714d1;
        _aligned_free();
      }
    }
    *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410714f0;
    uStack_14f0 = func_0x000141070b60(uVar35);
    uStack_88c = *(undefined8 *)(param_2 + 0x62);
    uStack_884 = *(undefined8 *)(param_2 + 100);
    uStack_87b = *(undefined1 *)((longlong)param_2 + 0x183);
    bStack_878 = *(byte *)(param_2 + 0x60);
    bStack_87c = bStack_878 >> 2 & 1;
    bStack_875 = bStack_878 >> 6 & 1;
    bStack_891 = bStack_878 >> 1 & 1;
    bStack_878 = bStack_878 & 1;
    uStack_1350 = *(undefined8 *)(param_2 + 0x14);
    iStack_7c8 = param_2[0x12];
    uStack_87a = *(undefined1 *)((longlong)param_2 + 0x47b);
    uStack_877 = (undefined1)param_2[0x11f];
    bStack_1337 = *(byte *)(param_2 + 0xb2) & 1;
    uVar21 = (undefined1)(short)param_2[4];
    uVar8 = uVar21;
    if ((ushort)((short)param_2[4] - 200U) < 7) {
      uVar8 = uStack_12cf;
      uStack_12ce = uVar21;
    }
    uStack_12cf = uVar8;
    bStack_894 = *(byte *)((longlong)param_2 + 0x2c9) >> 5 & 1;
    bStack_893 = *(byte *)((longlong)param_2 + 0x2c9) >> 7;
    iStack_874 = param_2[0x100];
    bStack_1346 = *(byte *)(param_2 + 0xfc) & 1;
    uStack_1345 = (undefined1)param_2[0xd8];
    uStack_1344 = *(undefined8 *)(param_2 + 0xd6);
    uStack_1334 = *(undefined8 *)(param_2 + 0xda);
    bStack_1300 = *(byte *)((longlong)param_2 + 0x1d9) >> 3 & 1;
    if (*(longlong *)(param_2 + 6) != 0) {
      uStack_12f8 = *(undefined8 *)(*(longlong *)(param_2 + 6) + 0x50);
    }
    uStack_12e0 = *(undefined8 *)(param_2 + 0x86);
    uStack_12d8 = *(undefined8 *)(param_2 + 0x88);
    iStack_8a0 = param_2[0xde];
    iStack_89c = param_2[0xdf];
    iStack_898 = param_2[0xe0];
    bVar3 = *(byte *)((longlong)param_2 + 0x181);
    bStack_7b4 = bVar3 >> 1 & 1;
    bStack_7b3 = bVar3 >> 2 & 1;
    bStack_7b2 = bVar3 >> 3 & 1;
    uStack_7b1 = (undefined1)param_2[0x11e];
    uStack_7b0 = *(undefined8 *)(param_2 + 0x72);
    uStack_7a8 = *(undefined8 *)(param_2 + 0x6c);
    uStack_7a0 = *(undefined8 *)(param_2 + 0x6e);
    uStack_798 = *(undefined8 *)(param_2 + 0x70);
    iStack_790 = param_2[0x68];
    bStack_780 = *(byte *)((longlong)param_2 + 0x1da) >> 4 & 1;
    bStack_77f = *(byte *)((longlong)param_2 + 0x1da) >> 7;
    bVar10 = true;
    bStack_77e = *(byte *)((longlong)param_2 + 0x1db) & 1;
    uStack_12d0 = uVar25;
    if ((*(byte *)(param_2 + 0x76) & 8) == 0) {
      *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071755;
      iVar13 = FUN_140efe3e0(param_2,acStackX_20 + lVar14);
      if (iVar13 == 0) {
        if (acStackX_20[lVar14] == '\0') {
          if (acStackX_26[lVar14] == '\0') {
            bVar10 = acStackX_20[lVar14 + 1] != '\0';
          }
          else {
            bVar10 = true;
          }
        }
        else {
          bVar10 = true;
        }
      }
    }
    else {
      bVar10 = false;
    }
    plVar27 = plVar29;
    plVar23 = plVar29;
    if (*param_2 == 0x706c7374) {
      if (*(longlong *)(param_2 + 0x132) != 0) {
        LOCK();
        piVar1 = (int *)(*(longlong *)(param_2 + 0x132) + 8);
        *piVar1 = *piVar1 + 1;
        UNLOCK();
      }
      plVar27 = *(longlong **)(param_2 + 0x130);
      plVar23 = *(longlong **)(param_2 + 0x132);
    }
    *(longlong **)(acStackX_20 + lVar14) = plVar27;
    *(longlong **)(&stack0x00000028 + lVar14) = plVar23;
    uStack_77d = bVar10;
    if (plVar27 != (longlong *)0x0) {
      pcVar5 = *(code **)(*plVar27 + 0x90);
      *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410717cd;
      bStack_876 = (*pcVar5)();
      if (0xb < bStack_876) {
        bStack_876 = 0;
      }
    }
    if (plVar23 != (longlong *)0x0) {
      LOCK();
      plVar27 = plVar23 + 1;
      lVar22 = *plVar27;
      *(int *)plVar27 = (int)*plVar27 + -1;
      UNLOCK();
      if ((int)lVar22 == 1) {
        pcVar5 = *(code **)*plVar23;
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410717fc;
        (*pcVar5)(plVar23);
        LOCK();
        piVar1 = (int *)((longlong)plVar23 + 0xc);
        iVar13 = *piVar1;
        *piVar1 = *piVar1 + -1;
        UNLOCK();
        if (iVar13 == 1) {
          pcVar5 = *(code **)(*plVar23 + 8);
          *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071811;
          (*pcVar5)(plVar23);
        }
      }
    }
    if (((short)param_2[4] == 0x14) || ((short)param_2[4] == 0x27)) {
      uStack_12cc = *(undefined8 *)(param_2 + 0x138);
    }
    uStack_12c4 = *(undefined8 *)(param_2 + 0xe6);
    uStack_12bc = *(undefined8 *)(param_2 + 0xe8);
    uStack_12b4 = *(undefined8 *)(param_2 + 0xea);
    uStack_12ac = *(undefined8 *)(param_2 + 0xec);
    uStack_12a4 = *(undefined8 *)(param_2 + 0xee);
    uStack_129c = *(undefined8 *)(param_2 + 0xf0);
    uStack_8c0 = *(undefined8 *)(param_2 + 0xf2);
    uStack_8b8 = *(undefined8 *)(param_2 + 0xf4);
    uStack_8b0 = *(undefined8 *)(param_2 + 0xf6);
    uStack_8a8 = *(undefined8 *)(param_2 + 0xf8);
    uStack_14ee = 1;
    pcVar2 = acStackX_20 + lVar14 + -0x20;
    pcVar2[0] = -0x54;
    pcVar2[1] = '\r';
    pcVar2[2] = '\0';
    pcVar2[3] = '\0';
    pcVar2[4] = '\0';
    pcVar2[5] = '\0';
    pcVar2[6] = '\0';
    pcVar2[7] = '\0';
    uVar19 = *(undefined8 *)(param_1 + 0x120);
    *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410718de;
    uVar12 = FUN_140ba04c0(uVar19,acStackX_20 + lVar14 + -0x20,&uStack_1508);
    plVar27 = (longlong *)(ulonglong)uVar12;
    if (uVar12 != 0) goto LAB_141072543;
    *(longlong *)(acStackX_20 + lVar14 + -0x20) = param_1 + 0xa00128;
    if ((*(byte *)(param_2 + 0x76) & 8) == 0) {
      iVar13 = param_2[0x5e];
      lVar22 = (longlong)iVar13;
      plVar27 = (longlong *)0x0;
      if (iVar13 != 0) {
        if ((((piVar30 != (int *)0x0) && (*piVar30 == 0x73747263)) && (param_2[0x5b] != 0)) &&
           ((0 < iVar13 && (iVar13 <= param_2[0x57])))) {
          piVar1 = (int *)(**(longlong **)(param_2 + 0x50) + (lVar22 + -1) * 8);
          if ((piVar1 == (int *)0x0) || ((*piVar1 < 0 || (piVar1[1] < 1)))) {
            plVar27 = (longlong *)0xffffffce;
            plVar32 = plVar29;
            plVar23 = plVar29;
          }
          else {
            plVar27 = plVar29;
            plVar32 = (longlong *)(ulonglong)(uint)piVar1[1];
            plVar23 = (longlong *)((longlong)*piVar1 + **(longlong **)(param_2 + 0x54));
          }
          if ((int)plVar27 != 0) goto LAB_141072543;
          if ((int)plVar32 == 0) goto LAB_141071adf;
          goto LAB_141071a22;
        }
        plVar27 = (longlong *)0xffffffce;
      }
    }
    else {
      uStack_758 = 0;
      if (*param_2 == 0x706c7374) {
        iVar13 = param_2[0x5e];
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071926;
        FUN_140bff470(piVar30,iVar13,&uStack_758);
      }
      if (_DAT_1420cfce0 == 0) {
LAB_141071961:
        lVar22 = _DAT_1420adbf8;
      }
      else {
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x14107193d;
        lVar22 = CFDictionaryGetValue(_DAT_1420cfce0,0x7f0001);
        if (lVar22 != 0) {
          *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x14107194e;
          lVar15 = CFGetTypeID(lVar22);
          *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071957;
          lVar16 = CFStringGetTypeID();
          if (lVar15 != lVar16) goto LAB_141071961;
        }
        if (lVar22 == 0) goto LAB_141071961;
      }
      uStack_288 = 0;
      uVar9 = uStack_288;
      if (lVar22 != 0) {
        pcVar2 = acStackX_20 + lVar14;
        pcVar2[0] = '\0';
        pcVar2[1] = '\0';
        pcVar2[2] = '\0';
        pcVar2[3] = '\0';
        pcVar2[4] = '\0';
        pcVar2[5] = '\0';
        pcVar2[6] = '\0';
        pcVar2[7] = '\0';
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071986;
        lVar15 = CFStringGetLength(lVar22);
        *(longlong *)(&stack0x00000028 + lVar14) = lVar15;
        uVar9 = 0;
        if (lVar15 != 0) {
          if (0xff < lVar15) {
            *(undefined8 *)(&stack0x00000028 + lVar14) = 0xff;
            lVar15 = 0xff;
          }
          *(undefined8 *)(acStackX_20 + lVar14) = *(undefined8 *)(acStackX_20 + lVar14);
          *(undefined8 *)(&stack0x00000028 + lVar14) = *(undefined8 *)(&stack0x00000028 + lVar14);
          *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410719c7;
          FUN_140b92160(lVar22,acStackX_20 + lVar14,auStack_286);
          uVar9 = (short)lVar15;
        }
      }
      uStack_288 = uVar9;
      *(undefined4 *)(&stack0xffffffffffffffe0 + lVar14) = 0;
      *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410719f4;
      cVar11 = FUN_140ae4f40(auStack_756,uStack_758,auStack_286,uStack_288);
      if (cVar11 != '\0') {
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071a0b;
        FUN_140ae6430(_DAT_1420affa8,&uStack_758);
      }
      plVar32 = (longlong *)(ulonglong)((uint)uStack_758 * 2);
      if (uStack_758 == 0) {
        plVar27 = (longlong *)0x0;
      }
      else {
        lVar22 = 0;
        plVar23 = (longlong *)auStack_756;
LAB_141071a22:
        *(char **)(&stack0xfffffffffffffff0 + lVar14) = acStackX_20 + lVar14 + -0x20;
        *(undefined4 *)(&stack0xffffffffffffffe8 + lVar14) = 1;
        *(undefined4 *)(&stack0xffffffffffffffe0 + lVar14) = 100;
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071a41;
        uVar12 = FUN_14106ac80(param_1,plVar23,plVar32,lVar22);
        plVar27 = (longlong *)(ulonglong)uVar12;
        if (uVar12 == 0) {
          iStack_14fc = iStack_14fc + 1;
        }
      }
    }
LAB_141071adf:
    if ((int)plVar27 != 0) goto LAB_141072543;
    iVar13 = param_2[0x5f];
    plVar27 = plVar29;
    if (iVar13 == 0) goto LAB_141071bb2;
    if ((piVar30 == (int *)0x0) || (*piVar30 != 0x73747263)) {
      plVar27 = (longlong *)0xffffffce;
      goto LAB_141072543;
    }
    if (((param_2[0x5b] != 0) && (0 < iVar13)) && (iVar13 <= param_2[0x57])) {
      piVar30 = (int *)(**(longlong **)(param_2 + 0x50) + ((longlong)iVar13 + -1) * 8);
      if (((piVar30 == (int *)0x0) || (*piVar30 < 0)) || (piVar30[1] < 1)) {
        plVar27 = (longlong *)0xffffffce;
        plVar23 = plVar29;
        plVar32 = plVar29;
      }
      else {
        plVar23 = (longlong *)(ulonglong)(uint)piVar30[1];
        plVar32 = (longlong *)((longlong)*piVar30 + **(longlong **)(param_2 + 0x54));
      }
      if ((int)plVar27 != 0) goto LAB_141072543;
      if ((int)plVar23 == 0) {
LAB_141071bb2:
        if ((int)plVar27 != 0) goto LAB_141072543;
      }
      else {
        *(char **)(&stack0xfffffffffffffff0 + lVar14) = acStackX_20 + lVar14 + -0x20;
        *(undefined4 *)(&stack0xffffffffffffffe8 + lVar14) = 1;
        *(undefined4 *)(&stack0xffffffffffffffe0 + lVar14) = 0x6a;
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071b9d;
        uVar12 = FUN_14106ac80(param_1,plVar32);
        plVar27 = (longlong *)(ulonglong)uVar12;
        if (uVar12 != 0) goto LAB_141071bb2;
        iStack_14fc = iStack_14fc + 1;
      }
      if (*(longlong *)(acStackX_20 + lVar14 + -0x20) != param_1 + 0xa00128) {
        *(longlong *)(acStackX_20 + lVar14 + -0x20) =
             (*(longlong *)(acStackX_20 + lVar14 + -0x20) - param_1) + -0xa00128;
        uVar19 = *(undefined8 *)(param_1 + 0x120);
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071bf2;
        uVar12 = FUN_140ba04c0(uVar19,acStackX_20 + lVar14 + -0x20,param_1 + 0xa00128);
        plVar27 = (longlong *)(ulonglong)uVar12;
        if (uVar12 != 0) goto LAB_141072543;
      }
      if ((*(byte *)(param_2 + 0x8a) & 1) != 0) {
        bStack_12fe = *(byte *)(param_2 + 0x8a) >> 1 & 1;
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071c33;
        uVar12 = FUN_1410710d0(param_2 + 0x8c,1,&uStack_758);
        plVar27 = (longlong *)(ulonglong)uVar12;
        if (uVar12 == 0) {
          puVar33 = (uint *)(param_1 + 0xa00128);
          if (puVar33 != (uint *)0x0) {
            *(undefined8 *)(param_1 + 0xa00138) = 0;
          }
          *puVar33 = 0x686f686d;
          *(undefined4 *)(param_1 + 0xa0012c) = 0x18;
          *(undefined4 *)(param_1 + 0xa00134) = 0x66;
          *(undefined4 *)(param_1 + 0xa00130) = 0x88;
          if (*(char *)(param_1 + 0x52) == '\0') {
            uVar12 = *puVar33;
            uVar26 = *(uint *)(param_1 + 0xa0012c);
            uVar36 = *(uint *)(param_1 + 0xa00130);
            uVar7 = *(uint *)(param_1 + 0xa00134);
            *puVar33 = (uVar12 & 0xff00 | uVar12 << 0x10) << 8 | uVar12 >> 0x18 |
                       uVar12 >> 8 & 0xff00;
            *(uint *)(param_1 + 0xa0012c) =
                 (uVar26 & 0xff00 | uVar26 << 0x10) << 8 | uVar26 >> 0x18 | uVar26 >> 8 & 0xff00;
            *(uint *)(param_1 + 0xa00130) =
                 (uVar36 & 0xff00 | uVar36 << 0x10) << 8 | uVar36 >> 0x18 | uVar36 >> 8 & 0xff00;
            *(uint *)(param_1 + 0xa00134) =
                 (uVar7 & 0xff00 | uVar7 << 0x10) << 8 | uVar7 >> 0x18 | uVar7 >> 8 & 0xff00;
            uVar12 = *(uint *)(param_1 + 0xa00138);
            *(uint *)(param_1 + 0xa00138) =
                 uVar12 >> 0x18 | (uVar12 & 0xff0000) >> 8 | (uVar12 & 0xff00) << 8 | uVar12 << 0x18
            ;
          }
          if ((undefined8 *)(param_1 + 0xa00140) != (undefined8 *)0x0) {
            *(undefined8 *)(param_1 + 0xa00140) =
                 CONCAT17(auStack_756[5],
                          CONCAT16(auStack_756[4],
                                   CONCAT15(auStack_756[3],
                                            CONCAT14(auStack_756[2],
                                                     CONCAT22(auStack_756._0_2_,uStack_758)))));
            *(ulonglong *)(param_1 + 0xa00148) = CONCAT44(uStack_74c,auStack_756._6_4_);
            *(ulonglong *)(param_1 + 0xa00150) = CONCAT44(uStack_744,uStack_748);
            *(undefined8 *)(param_1 + 0xa00158) = uStack_740;
            *(undefined8 *)(param_1 + 0xa00160) = uStack_738;
            *(undefined8 *)(param_1 + 0xa00168) = uStack_730;
            *(undefined8 *)(param_1 + 0xa00170) = uStack_728;
            *(undefined8 *)(param_1 + 0xa00178) = uStack_720;
            *(undefined8 *)(param_1 + 0xa00180) = uStack_718;
            *(undefined8 *)(param_1 + 0xa00188) = uStack_710;
            *(undefined8 *)(param_1 + 0xa00190) = uStack_708;
            *(undefined8 *)(param_1 + 0xa00198) = uStack_700;
            *(undefined8 *)(param_1 + 0xa001a0) = uStack_6f8;
            *(undefined8 *)(param_1 + 0xa001a8) = uStack_6f0;
          }
          puVar28 = (uint *)(param_1 + 0xa001b0);
          iStack_14fc = iStack_14fc + 1;
          puVar33 = puVar28;
          if (*(longlong *)(param_2 + 0x90) != 0) {
            if (puVar28 != (uint *)0x0) {
              *(undefined4 *)(param_1 + 0xa001b8) = 0;
              *(undefined8 *)(param_1 + 0xa001c0) = 0;
            }
            *puVar28 = 0x686f686d;
            *(undefined4 *)(param_1 + 0xa001b4) = 0x18;
            *(undefined4 *)(param_1 + 0xa001bc) = 0x65;
            *(char **)(&stack0xffffffffffffffe8 + lVar14) = acStackX_20 + lVar14 + -0x20;
            uVar19 = *(undefined8 *)(param_2 + 0x90);
            *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071d69;
            iVar13 = FUN_140bf0a80(uVar19,param_1 + 0xa001c8,0x9fffe8);
            if (iVar13 == 0) {
              puVar33 = (uint *)((ulonglong)*(uint *)(acStackX_20 + lVar14 + -0x20) +
                                param_1 + 0xa001c8);
              *(int *)(param_1 + 0xa001b8) = (int)puVar33 - (int)puVar28;
              if (*(char *)(param_1 + 0x52) == '\0') {
                uVar12 = *puVar28;
                uVar26 = *(uint *)(param_1 + 0xa001b4);
                uVar36 = *(uint *)(param_1 + 0xa001b8);
                uVar7 = *(uint *)(param_1 + 0xa001bc);
                *puVar28 = (uVar12 & 0xff00 | uVar12 << 0x10) << 8 | uVar12 >> 0x18 |
                           uVar12 >> 8 & 0xff00;
                *(uint *)(param_1 + 0xa001b4) =
                     (uVar26 & 0xff00 | uVar26 << 0x10) << 8 | uVar26 >> 0x18 | uVar26 >> 8 & 0xff00
                ;
                *(uint *)(param_1 + 0xa001b8) =
                     (uVar36 & 0xff00 | uVar36 << 0x10) << 8 | uVar36 >> 0x18 | uVar36 >> 8 & 0xff00
                ;
                *(uint *)(param_1 + 0xa001bc) =
                     (uVar7 & 0xff00 | uVar7 << 0x10) << 8 | uVar7 >> 0x18 | uVar7 >> 8 & 0xff00;
                uVar12 = *(uint *)(param_1 + 0xa001c0);
                *(uint *)(param_1 + 0xa001c0) =
                     uVar12 >> 0x18 | (uVar12 & 0xff0000) >> 8 | (uVar12 & 0xff00) << 8 |
                     uVar12 << 0x18;
              }
              iStack_14fc = iStack_14fc + 1;
            }
          }
          piVar30 = *(int **)(param_2 + 0x92);
          if (((piVar30 != (int *)0x0) && (*piVar30 == 0x4f4c5354)) && (piVar30[1] != 0)) {
            uVar37 = (*(longlong *)(piVar30 + 4) - *(longlong *)(piVar30 + 2) >> 4) *
                     -0x5555555555555555;
            uVar12 = (uint)uVar37;
            if (uVar12 != 0) {
              *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071e1c;
              puVar17 = (ulonglong *)FUN_140b930a0((uVar37 & 0xffffffff) << 3);
              *(ulonglong **)(acStackX_20 + lVar14 + -0x20) = puVar17;
              if (puVar17 == (ulonglong *)0x0) {
                plVar27 = (longlong *)0xffffff94;
                goto LAB_141072543;
              }
              plVar27 = plVar29;
              if (uVar12 != 0) {
                do {
                  uVar19 = *(undefined8 *)(param_2 + 0x92);
                  *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071e53;
                  puVar18 = (ulonglong *)FUN_1402ddd10(uVar19,plVar29,0);
                  if (puVar18 != (ulonglong *)0x0) {
                    puVar17[(longlong)plVar27] = *puVar18;
                    plVar27 = (longlong *)(ulonglong)((int)plVar27 + 1);
                  }
                  uVar26 = (int)plVar29 + 1;
                  plVar29 = (longlong *)(ulonglong)uVar26;
                } while (uVar26 < uVar12);
                iVar13 = (int)plVar27;
                puVar17 = *(ulonglong **)(acStackX_20 + lVar14 + -0x20);
                if (iVar13 != 0) {
                  if ((*(char *)(param_1 + 0x52) == '\0') && (puVar18 = puVar17, iVar13 != 0)) {
                    do {
                      uVar37 = *puVar18;
                      *puVar18 = uVar37 >> 0x38 | (uVar37 & 0xff000000000000) >> 0x28 |
                                 (uVar37 & 0xff0000000000) >> 0x18 | (uVar37 & 0xff00000000) >> 8 |
                                 (uVar37 & 0xff000000) << 8 | (uVar37 & 0xff0000) << 0x18 |
                                 (uVar37 & 0xff00) << 0x28 | uVar37 << 0x38;
                      plVar27 = (longlong *)((longlong)plVar27 + -1);
                      puVar18 = puVar18 + 1;
                    } while (plVar27 != (longlong *)0x0);
                  }
                  if (puVar33 != (uint *)0x0) {
                    puVar33[0] = 0;
                    puVar33[1] = 0;
                    puVar33[2] = 0;
                    puVar33[3] = 0;
                    puVar33[4] = 0;
                    puVar33[5] = 0;
                  }
                  *puVar33 = 0x686f686d;
                  puVar33[1] = 0x18;
                  puVar33[3] = 0x68;
                  if (puVar33 + 6 != (uint *)0x0) {
                    *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071ef3;
                    func_0x00014179cc9a(puVar33 + 6,puVar17,(ulonglong)(uint)(iVar13 * 8));
                  }
                  puVar28 = (uint *)((longlong)puVar33 + (ulonglong)(uint)(iVar13 * 8) + 0x18);
                  puVar33[2] = (int)puVar28 - (int)puVar33;
                  if (*(char *)(param_1 + 0x52) == '\0') {
                    uVar12 = *puVar33;
                    uVar26 = puVar33[1];
                    uVar36 = puVar33[2];
                    uVar7 = puVar33[3];
                    *puVar33 = (uVar12 & 0xff00 | uVar12 << 0x10) << 8 | uVar12 >> 0x18 |
                               uVar12 >> 8 & 0xff00;
                    puVar33[1] = (uVar26 & 0xff00 | uVar26 << 0x10) << 8 | uVar26 >> 0x18 |
                                 uVar26 >> 8 & 0xff00;
                    puVar33[2] = (uVar36 & 0xff00 | uVar36 << 0x10) << 8 | uVar36 >> 0x18 |
                                 uVar36 >> 8 & 0xff00;
                    puVar33[3] = (uVar7 & 0xff00 | uVar7 << 0x10) << 8 | uVar7 >> 0x18 |
                                 uVar7 >> 8 & 0xff00;
                    uVar12 = puVar33[4];
                    puVar33[4] = uVar12 >> 0x18 | (uVar12 & 0xff0000) >> 8 | (uVar12 & 0xff00) << 8
                                 | uVar12 << 0x18;
                  }
                  iStack_14fc = iStack_14fc + 1;
                  puVar33 = puVar28;
                }
              }
              *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071f5c;
              _aligned_free(puVar17);
            }
          }
          *(longlong *)(acStackX_20 + lVar14 + -0x20) = (longlong)puVar33 + (-0xa00128 - param_1);
          uVar19 = *(undefined8 *)(param_1 + 0x120);
          *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141071f83;
          uVar12 = FUN_140ba04c0(uVar19,acStackX_20 + lVar14 + -0x20,param_1 + 0xa00128);
          plVar27 = (longlong *)(ulonglong)uVar12;
          if (uVar12 == 0) goto LAB_141071f8d;
        }
        goto LAB_141072543;
      }
LAB_141071f8d:
      uVar37 = 0;
      if (*param_2 == 0x706c7374) {
        lVar22 = *(longlong *)(param_2 + 2);
        bVar3 = *(byte *)(lVar22 + 0x110);
        if (((((((bVar3 & 1) != 0) || (*(int *)(lVar22 + 0x84) == 0x74736574)) &&
              ((sVar4 = (short)param_2[4], sVar4 == 10 || (sVar4 == 0x1f)))) &&
             ((pcVar2 = acStackX_20 + lVar14 + -0x20, pcVar2[0] = '\0', pcVar2[1] = '\0',
              pcVar2[2] = '\0', pcVar2[3] = '\0', pcVar2[4] = '\0', pcVar2[5] = '\0',
              pcVar2[6] = '\0', pcVar2[7] = '\0', (bVar3 & 1) != 0 ||
              (*(int *)(lVar22 + 0x84) == 0x74736574)))) && ((sVar4 == 10 || (sVar4 == 0x1f)))) &&
           (lVar22 = *(longlong *)(param_2 + 0x7a), lVar22 != 0)) {
          *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141072011;
          iVar13 = FUN_140fe20c0(lVar22,bVar3,acStackX_20 + lVar14 + -0x20);
          if ((iVar13 == 0) && (lVar22 = *(longlong *)(acStackX_20 + lVar14 + -0x20), lVar22 != 0))
          {
            *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141072030;
            lVar15 = CFDataGetLength(lVar22);
            if (0 < lVar15) {
              *(undefined4 *)(param_1 + 0xa00128) = 0x686f686d;
              *(undefined4 *)(param_1 + 0xa0012c) = 0x18;
              *(undefined4 *)(param_1 + 0xa00134) = 0x67;
              *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141072060;
              iVar13 = CFDataGetLength(lVar22);
              *(int *)(param_1 + 0xa00130) = iVar13 + *(int *)(param_1 + 0xa0012c);
              if (*(char *)(param_1 + 0x52) == '\0') {
                uVar12 = *(uint *)(param_1 + 0xa00128);
                uVar26 = *(uint *)(param_1 + 0xa0012c);
                uVar36 = *(uint *)(param_1 + 0xa00130);
                uVar7 = *(uint *)(param_1 + 0xa00134);
                *(uint *)(param_1 + 0xa00128) =
                     (uVar12 & 0xff00 | uVar12 << 0x10) << 8 | uVar12 >> 0x18 | uVar12 >> 8 & 0xff00
                ;
                *(uint *)(param_1 + 0xa0012c) =
                     (uVar26 & 0xff00 | uVar26 << 0x10) << 8 | uVar26 >> 0x18 | uVar26 >> 8 & 0xff00
                ;
                *(uint *)(param_1 + 0xa00130) =
                     (uVar36 & 0xff00 | uVar36 << 0x10) << 8 | uVar36 >> 0x18 | uVar36 >> 8 & 0xff00
                ;
                *(uint *)(param_1 + 0xa00134) =
                     (uVar7 & 0xff00 | uVar7 << 0x10) << 8 | uVar7 >> 0x18 | uVar7 >> 8 & 0xff00;
                uVar12 = *(uint *)(param_1 + 0xa00138);
                *(uint *)(param_1 + 0xa00138) =
                     uVar12 >> 0x18 | (uVar12 & 0xff0000) >> 8 | (uVar12 & 0xff00) << 8 |
                     uVar12 << 0x18;
              }
              pcVar2 = acStackX_20 + lVar14 + -0x20;
              pcVar2[0] = '\x18';
              pcVar2[1] = '\0';
              pcVar2[2] = '\0';
              pcVar2[3] = '\0';
              pcVar2[4] = '\0';
              pcVar2[5] = '\0';
              pcVar2[6] = '\0';
              pcVar2[7] = '\0';
              uVar19 = *(undefined8 *)(param_1 + 0x120);
              *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410720e2;
              uVar12 = FUN_140ba04c0(uVar19,acStackX_20 + lVar14 + -0x20,param_1 + 0xa00128);
              plVar27 = (longlong *)(ulonglong)uVar12;
              if (uVar12 == 0) {
                *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410720fc;
                uVar19 = CFDataGetLength(lVar22);
                *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141072108;
                uVar20 = CFDataGetBytePtr(lVar22);
                *(undefined8 *)(acStackX_20 + lVar14 + -0x20) = uVar19;
                uVar19 = *(undefined8 *)(param_1 + 0x120);
                *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141072121;
                uVar12 = FUN_140ba04c0(uVar19,acStackX_20 + lVar14 + -0x20,uVar20);
                plVar27 = (longlong *)(ulonglong)uVar12;
                *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x14107212c;
                CFRelease(lVar22);
                if (uVar12 == 0) {
                  iStack_14fc = iStack_14fc + 1;
                  goto LAB_141072137;
                }
              }
              else {
                *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410720f1;
                CFRelease();
              }
              goto LAB_141072543;
            }
          }
        }
      }
LAB_141072137:
      for (puVar6 = *(undefined8 **)(param_2 + 0x108); puVar6 != (undefined8 *)0x0;
          puVar6 = (undefined8 *)*puVar6) {
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141072174;
        func_0x00014179cca0(&uStack_758,0,0x4c4);
        uStack_758 = (ushort)*(undefined4 *)(puVar6 + 2);
        auStack_756._0_2_ = (undefined2)((uint)*(undefined4 *)(puVar6 + 2) >> 0x10);
        auStack_756[2] = *(undefined1 *)((longlong)puVar6 + 0x14);
        auStack_756[3] = *(undefined1 *)((longlong)puVar6 + 0x15);
        auStack_756[4] = *(undefined1 *)((longlong)puVar6 + 0x1c);
        auStack_756._6_4_ = *(undefined4 *)(puVar6 + 3);
        auStack_756[5] = *(undefined1 *)((longlong)puVar6 + 0x1d);
        uVar12 = 0;
        pcVar2 = acStackX_20 + lVar14 + -0x20;
        pcVar2[0] = '\0';
        pcVar2[1] = '\0';
        pcVar2[2] = '\0';
        pcVar2[3] = '\0';
        piVar30 = (int *)((longlong)puVar6 + 0x22);
        uVar26 = uVar12;
        if (*(short *)((longlong)puVar6 + 0x1e) != 0) {
          puVar34 = (undefined1 *)((longlong)&uStack_744 + 1);
          uVar24 = uVar37;
          uVar31 = uVar37;
          uVar38 = uVar37;
          do {
            iVar13 = *piVar30;
            *(int *)((longlong)auStackX_8 + lVar14) = iVar13;
            if (iVar13 != 0) {
              iVar13 = piVar30[2];
              pcVar2 = acStackX_20 + lVar14;
              pcVar2[0] = '\0';
              pcVar2[1] = '\0';
              pcVar2[2] = '\0';
              pcVar2[3] = '\0';
              pcVar2[4] = '\0';
              pcVar2[5] = '\0';
              pcVar2[6] = '\0';
              pcVar2[7] = '\0';
              *(undefined8 *)(&stack0x00000028 + lVar14) = 0;
              *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141072209;
              dVar39 = (double)FUN_140ba5e10(acStackX_20 + lVar14);
              *(short *)(puVar34 + 1) = (short)(int)((double)(int)(short)iVar13 / dVar39 + 0.5);
              *puVar34 = *(undefined1 *)((longlong)piVar30 + 7);
              uVar35 = *(undefined4 *)((longlong)auStackX_8 + lVar14);
              *(undefined4 *)(puVar34 + 3) = uVar35;
              puVar34[-1] = (char)uVar35;
              uVar12 = *(uint *)(acStackX_20 + lVar14 + -0x20);
              if ((int)uVar38 != (int)*(short *)(puVar6 + 4)) {
                uVar12 = (uint)uVar31;
              }
              uVar31 = (ulonglong)uVar12;
              uVar26 = *(uint *)(acStackX_20 + lVar14 + -0x20) + 1;
              uVar24 = (ulonglong)uVar26;
              *(uint *)(acStackX_20 + lVar14 + -0x20) = uVar26;
              if (uVar26 == 100) break;
              puVar34 = puVar34 + 0xc;
            }
            uVar26 = (uint)uVar24;
            uVar12 = (uint)uVar31;
            piVar30 = piVar30 + 7;
            uVar36 = (int)uVar38 + 1;
            uVar38 = (ulonglong)uVar36;
          } while (uVar36 < (uint)(int)*(short *)((longlong)puVar6 + 0x1e));
          *(uint *)((longlong)auStackX_8 + lVar14) = uVar12;
          param_2 = *(int **)((longlong)&uStackX_18 + lVar14);
          uVar12 = *(uint *)((longlong)auStackX_8 + lVar14);
        }
        puVar33 = (uint *)(param_1 + 0xa00128);
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141072297;
        uStack_74c = uVar26;
        uStack_748 = uVar12;
        func_0x000141069e20(param_1,&uStack_758);
        *puVar33 = 0x686f686d;
        *(undefined4 *)(param_1 + 0xa0012c) = 0x18;
        *(undefined4 *)(param_1 + 0xa00134) = 0x69;
        *(undefined4 *)(param_1 + 0xa00130) = 0x4dc;
        if (*(char *)(param_1 + 0x52) == '\0') {
          uVar12 = *puVar33;
          uVar26 = *(uint *)(param_1 + 0xa0012c);
          uVar36 = *(uint *)(param_1 + 0xa00130);
          uVar7 = *(uint *)(param_1 + 0xa00134);
          *puVar33 = (uVar12 & 0xff00 | uVar12 << 0x10) << 8 | uVar12 >> 0x18 | uVar12 >> 8 & 0xff00
          ;
          *(uint *)(param_1 + 0xa0012c) =
               (uVar26 & 0xff00 | uVar26 << 0x10) << 8 | uVar26 >> 0x18 | uVar26 >> 8 & 0xff00;
          *(uint *)(param_1 + 0xa00130) =
               (uVar36 & 0xff00 | uVar36 << 0x10) << 8 | uVar36 >> 0x18 | uVar36 >> 8 & 0xff00;
          *(uint *)(param_1 + 0xa00134) =
               (uVar7 & 0xff00 | uVar7 << 0x10) << 8 | uVar7 >> 0x18 | uVar7 >> 8 & 0xff00;
          uVar12 = *(uint *)(param_1 + 0xa00138);
          *(uint *)(param_1 + 0xa00138) =
               uVar12 >> 0x18 | (uVar12 & 0xff0000) >> 8 | (uVar12 & 0xff00) << 8 | uVar12 << 0x18;
        }
        pcVar2 = acStackX_20 + lVar14 + -0x20;
        pcVar2[0] = '\x18';
        pcVar2[1] = '\0';
        pcVar2[2] = '\0';
        pcVar2[3] = '\0';
        pcVar2[4] = '\0';
        pcVar2[5] = '\0';
        pcVar2[6] = '\0';
        pcVar2[7] = '\0';
        uVar19 = *(undefined8 *)(param_1 + 0x120);
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141072326;
        uVar12 = FUN_140ba04c0(uVar19,acStackX_20 + lVar14 + -0x20,puVar33);
        plVar27 = (longlong *)(ulonglong)uVar12;
        if (uVar12 != 0) goto LAB_141072543;
        pcVar2 = acStackX_20 + lVar14 + -0x20;
        pcVar2[0] = -0x3c;
        pcVar2[1] = '\x04';
        pcVar2[2] = '\0';
        pcVar2[3] = '\0';
        pcVar2[4] = '\0';
        pcVar2[5] = '\0';
        pcVar2[6] = '\0';
        pcVar2[7] = '\0';
        uVar19 = *(undefined8 *)(param_1 + 0x120);
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141072351;
        uVar12 = FUN_140ba04c0(uVar19,acStackX_20 + lVar14 + -0x20,&uStack_758);
        plVar27 = (longlong *)(ulonglong)uVar12;
        if (uVar12 != 0) goto LAB_141072543;
        iStack_14fc = iStack_14fc + 1;
        if (*(int *)(puVar6 + 1) != 0x63736574) break;
      }
      *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x14107238b;
      func_0x00014179cca0(&uStack_758,0,0xc4);
      uVar12 = param_2[0x10c];
      if (0x10 < uVar12) {
        uVar12 = 0x10;
      }
      uStack_758 = (ushort)uVar12;
      auStack_756._0_2_ = (undefined2)(uVar12 >> 0x10);
      if (uVar12 != 0) {
        do {
          *(int *)(auStack_756 + uVar37 * 4 + 2) = param_2[uVar37 + 0x10d];
          uVar26 = (int)uVar37 + 1;
          uVar37 = (ulonglong)uVar26;
        } while (uVar26 < uVar12);
      }
      *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410723d1;
      func_0x000141069f90(param_1,&uStack_758);
      *(undefined4 *)(param_1 + 0xa00128) = 0x686f686d;
      *(undefined4 *)(param_1 + 0xa0012c) = 0x18;
      *(undefined4 *)(param_1 + 0xa00134) = 0x6c;
      *(undefined4 *)(param_1 + 0xa00130) = 0xdc;
      if (*(char *)(param_1 + 0x52) == '\0') {
        uVar12 = *(uint *)(param_1 + 0xa00128);
        uVar26 = *(uint *)(param_1 + 0xa0012c);
        uVar36 = *(uint *)(param_1 + 0xa00130);
        uVar7 = *(uint *)(param_1 + 0xa00134);
        *(uint *)(param_1 + 0xa00128) =
             (uVar12 & 0xff00 | uVar12 << 0x10) << 8 | uVar12 >> 0x18 | uVar12 >> 8 & 0xff00;
        *(uint *)(param_1 + 0xa0012c) =
             (uVar26 & 0xff00 | uVar26 << 0x10) << 8 | uVar26 >> 0x18 | uVar26 >> 8 & 0xff00;
        *(uint *)(param_1 + 0xa00130) =
             (uVar36 & 0xff00 | uVar36 << 0x10) << 8 | uVar36 >> 0x18 | uVar36 >> 8 & 0xff00;
        *(uint *)(param_1 + 0xa00134) =
             (uVar7 & 0xff00 | uVar7 << 0x10) << 8 | uVar7 >> 0x18 | uVar7 >> 8 & 0xff00;
        uVar12 = *(uint *)(param_1 + 0xa00138);
        *(uint *)(param_1 + 0xa00138) =
             uVar12 >> 0x18 | (uVar12 & 0xff0000) >> 8 | (uVar12 & 0xff00) << 8 | uVar12 << 0x18;
      }
      *(undefined8 *)((longlong)&uStackX_18 + lVar14) = 0x18;
      uVar19 = *(undefined8 *)(param_1 + 0x120);
      *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x14107246f;
      uVar12 = FUN_140ba04c0(uVar19,(longlong)&uStackX_18 + lVar14,param_1 + 0xa00128);
      plVar27 = (longlong *)(ulonglong)uVar12;
      if (uVar12 == 0) {
        *(undefined8 *)((longlong)&uStackX_18 + lVar14) = 0xc4;
        uVar19 = *(undefined8 *)(param_1 + 0x120);
        *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x14107249a;
        uVar12 = FUN_140ba04c0(uVar19,(longlong)&uStackX_18 + lVar14,&uStack_758);
        plVar27 = (longlong *)(ulonglong)uVar12;
        if (uVar12 == 0) {
          iStack_14fc = iStack_14fc + 1;
          *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410724b1;
          lVar22 = FUN_140f00720(param_2,0);
          if (lVar22 != 0) {
            *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410724c2;
            lVar15 = CFDictionaryGetCount(lVar22);
            if (0 < lVar15) {
              *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410724d2;
              uVar12 = FUN_14106b290(param_1,lVar22);
              plVar27 = (longlong *)(ulonglong)uVar12;
              if (uVar12 != 0) goto LAB_141072543;
              iStack_14fc = iStack_14fc + 1;
            }
          }
          *(undefined8 *)(&stack0xffffffffffffffe0 + lVar14) = param_4;
          uVar19 = *(undefined8 *)(param_2 + 0x1c);
          *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x1410724f8;
          uVar12 = FUN_141070770(param_1,&uStack_1508,uVar19,param_3);
          plVar27 = (longlong *)(ulonglong)uVar12;
          if (uVar12 == 0) {
            uVar19 = *(undefined8 *)(param_1 + 0x120);
            *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x14107250e;
            uVar12 = FUN_140b9ff80(uVar19,aiStack_1518);
            plVar27 = (longlong *)(ulonglong)uVar12;
            if (uVar12 == 0) {
              iStack_1500 = aiStack_1518[0] - *(int *)((longlong)&lStackX_10 + lVar14);
              *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x14107252a;
              func_0x000141069860(param_1,&uStack_1508);
              *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141072541;
              uVar12 = FUN_14106aba0(param_1,*(undefined8 *)((longlong)&lStackX_10 + lVar14),
                                     &uStack_1508,0xdac);
              plVar27 = (longlong *)(ulonglong)uVar12;
            }
          }
        }
      }
      goto LAB_141072543;
    }
    plVar27 = (longlong *)0xffffffce;
    param_2 = param_2 + 0x4c;
  }
  if ((*param_2 == 0x73747263) && (0 < param_2[0xf])) {
    param_2[0xf] = param_2[0xf] + -1;
  }
LAB_141072560:
  *(undefined8 *)((longlong)&uStack_48 + lVar14) = 0x141072571;
  return plVar27;
}

