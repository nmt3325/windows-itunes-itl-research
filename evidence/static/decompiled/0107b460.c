/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x107b460; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Type propagation algorithm not settling */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

ulonglong FUN_14107b460(longlong param_1,int param_2)

{
  int *piVar1;
  undefined8 *puVar2;
  byte bVar3;
  char *pcVar4;
  longlong lVar5;
  char cVar6;
  undefined2 uVar7;
  uint uVar8;
  uint uVar9;
  uint uVar10;
  int iVar11;
  longlong lVar12;
  ulonglong uVar13;
  byte *pbVar14;
  longlong lVar15;
  byte bVar16;
  byte bVar17;
  uint *puVar18;
  int *piVar19;
  byte bVar20;
  ulonglong uVar21;
  ulonglong uVar22;
  ulonglong uVar23;
  char *pcVar24;
  undefined1 auStack_7b8 [32];
  int *piStack_798;
  undefined8 uStack_790;
  char cStack_788;
  longlong lStack_780;
  uint uStack_778;
  char cStack_774;
  int iStack_770;
  ulonglong uStack_768;
  int *piStack_760;
  uint uStack_758;
  undefined4 uStack_754;
  uint uStack_750;
  undefined4 uStack_74c;
  code *pcStack_748;
  ulonglong uStack_740;
  longlong lStack_738;
  longlong lStack_730;
  longlong lStack_728;
  longlong lStack_720;
  longlong lStack_718;
  int iStack_710;
  undefined4 uStack_70c;
  undefined8 uStack_708;
  undefined8 uStack_700;
  undefined8 uStack_6f8;
  undefined8 uStack_6f0;
  undefined8 uStack_6e8;
  undefined8 uStack_6e0;
  undefined8 uStack_6d8;
  int iStack_6c8;
  uint uStack_6c4;
  char *pcStack_6c0;
  ulonglong uStack_6b8;
  undefined1 auStack_6b0 [24];
  undefined1 auStack_698 [32];
  int iStack_678;
  uint uStack_674;
  int aiStack_670 [4];
  byte bStack_660;
  byte bStack_65f;
  undefined4 uStack_65c;
  undefined4 uStack_658;
  uint uStack_654;
  undefined4 uStack_650;
  undefined2 uStack_64c;
  undefined2 uStack_648;
  undefined2 uStack_644;
  undefined2 uStack_640;
  uint uStack_63c;
  undefined2 uStack_638;
  int iStack_634;
  int iStack_630;
  undefined4 uStack_62c;
  undefined2 uStack_628;
  char cStack_626;
  byte bStack_625;
  undefined2 uStack_620;
  undefined2 uStack_61c;
  undefined2 uStack_61a;
  undefined4 uStack_618;
  undefined4 uStack_614;
  undefined2 uStack_610;
  undefined2 uStack_60e;
  undefined1 uStack_60c;
  byte bStack_60b;
  byte bStack_60a;
  char cStack_609;
  uint uStack_608;
  undefined4 uStack_604;
  undefined4 uStack_600;
  int iStack_5fc;
  ulonglong uStack_5f8;
  uint uStack_5f0;
  undefined4 uStack_5ec;
  undefined2 uStack_5e8;
  undefined2 uStack_5e6;
  undefined4 uStack_5e4;
  undefined4 uStack_5e0;
  int iStack_5dc;
  int iStack_5d8;
  undefined2 uStack_5d4;
  undefined1 uStack_5d2;
  byte bStack_5d1;
  uint uStack_5d0;
  uint uStack_5cc;
  uint uStack_5c8;
  uint uStack_5c4;
  uint uStack_5c0;
  int iStack_5bc;
  undefined4 uStack_5b8;
  undefined2 uStack_5b4;
  byte bStack_5b0;
  byte bStack_5af;
  byte bStack_5ae;
  byte bStack_5ad;
  undefined8 uStack_5ac;
  int iStack_5a4;
  undefined4 uStack_5a0;
  undefined1 auStack_59c [8];
  uint uStack_594;
  char cStack_590;
  byte bStack_58f;
  byte bStack_58e;
  byte bStack_58d;
  char cStack_58c;
  byte bStack_58b;
  byte bStack_58a;
  byte bStack_589;
  undefined4 uStack_588;
  undefined8 uStack_584;
  undefined4 uStack_57c;
  undefined4 uStack_578;
  undefined4 uStack_574;
  int iStack_56c;
  int iStack_568;
  byte bStack_564;
  byte bStack_562;
  byte bStack_561;
  undefined4 uStack_560;
  undefined4 uStack_55c;
  undefined8 uStack_558;
  char cStack_550;
  undefined1 uStack_54f;
  char cStack_54d;
  longlong lStack_54c;
  undefined8 uStack_544;
  undefined8 uStack_53c;
  longlong lStack_534;
  char cStack_52c;
  char cStack_52b;
  char cStack_52a;
  char cStack_529;
  char cStack_528;
  char cStack_527;
  char cStack_51c;
  char cStack_51b;
  uint uStack_518;
  uint uStack_50c;
  char cStack_508;
  byte bStack_507;
  byte bStack_506;
  char cStack_505;
  short sStack_504;
  short sStack_502;
  int iStack_500;
  short sStack_4fc;
  short sStack_4fa;
  int iStack_4f8;
  int iStack_4f4;
  int iStack_4f0;
  int iStack_4ec;
  int iStack_4e8;
  ulonglong uStack_4e4;
  ulonglong uStack_4dc;
  ulonglong uStack_4d4;
  ulonglong uStack_4cc;
  ulonglong uStack_4c4;
  ulonglong uStack_4bc;
  ulonglong uStack_4b4;
  ulonglong uStack_4ac;
  ulonglong uStack_4a4;
  byte bStack_49b;
  char cStack_49a;
  byte bStack_499;
  undefined1 auStack_498 [4];
  undefined8 uStack_494;
  int iStack_48c;
  undefined4 uStack_488;
  int iStack_484;
  int iStack_480;
  undefined8 uStack_47c;
  undefined2 uStack_46e;
  longlong lStack_46c;
  byte bStack_464;
  char cStack_463;
  byte bStack_462;
  undefined4 uStack_458;
  undefined4 uStack_44c;
  char cStack_448;
  byte bStack_447;
  char cStack_446;
  char cStack_445;
  longlong lStack_444;
  longlong lStack_43c;
  uint uStack_42c;
  undefined4 uStack_428;
  undefined4 uStack_424;
  byte bStack_420;
  byte bStack_41f;
  byte bStack_41e;
  char cStack_41d;
  byte bStack_41c;
  byte bStack_41b;
  byte bStack_41a;
  char cStack_419;
  byte bStack_418;
  byte bStack_417;
  byte bStack_416;
  byte bStack_415;
  longlong lStack_414;
  byte bStack_40c;
  byte bStack_40b;
  byte bStack_40a;
  byte bStack_409;
  int iStack_408;
  undefined4 uStack_404;
  undefined4 uStack_400;
  byte bStack_3fc;
  byte bStack_3fb;
  byte bStack_3fa;
  byte bStack_3f9;
  ulonglong uStack_3f8;
  longlong lStack_3f0;
  undefined4 uStack_3e8;
  undefined4 uStack_3e4;
  undefined4 uStack_3e0;
  undefined4 uStack_3dc;
  undefined4 uStack_3d8;
  undefined4 uStack_3d4;
  undefined4 uStack_3d0;
  undefined8 uStack_3cc;
  undefined8 uStack_3c4;
  byte bStack_3bc;
  byte bStack_3bb;
  byte bStack_3ba;
  undefined1 uStack_3b9;
  char cStack_3b8;
  char cStack_3b7;
  char cStack_3b6;
  char cStack_3b5;
  longlong lStack_3b4;
  byte bStack_3ac;
  byte bStack_3ab;
  byte bStack_3aa;
  short sStack_3a8;
  short sStack_3a6;
  byte bStack_3a4;
  char cStack_3a3;
  char cStack_3a2;
  char cStack_3a1;
  char cStack_3a0;
  byte bStack_39f;
  byte bStack_39e;
  char cStack_39d;
  int iStack_39c;
  byte bStack_398;
  char cStack_397;
  undefined1 uStack_396;
  byte bStack_395;
  ulonglong uStack_378;
  ulonglong uStack_370;
  ulonglong uStack_368;
  undefined8 uStack_360;
  uint uStack_358;
  uint uStack_354;
  uint auStack_350 [6];
  uint uStack_338;
  uint uStack_334;
  uint auStack_330 [22];
  undefined1 auStack_2d8 [512];
  ulonglong uStack_d8;
  
  uStack_d8 = _DAT_141fd5040 ^ (ulonglong)auStack_7b8;
  lVar15 = *(longlong *)(param_1 + 0x1e00270);
  uStack_6b8 = 0;
  cStack_788 = '\0';
  lStack_780 = lVar15;
  iStack_770 = param_2;
  uVar8 = FUN_1410770a0(param_1,&uStack_338,8);
  if (uVar8 != 0) {
    return (ulonglong)uVar8;
  }
  pcVar24 = (char *)(param_1 + 0x52);
  uVar8 = uStack_334;
  if (*pcVar24 == '\0') {
    uVar8 = uStack_334 >> 0x18 | (uStack_334 & 0xff0000) >> 8 | (uStack_334 & 0xff00) << 8 |
            uStack_334 << 0x18;
  }
  puVar18 = auStack_330;
  uVar10 = 0x5c;
  if (uVar8 < 0x5c) {
    uVar10 = uVar8;
  }
  if (8 < uVar10) {
    piStack_760 = (int *)(ulonglong)(uVar10 - 8);
    if ((int *)0xa00000 < piStack_760) {
      return 0xffffff30;
    }
    uVar9 = FUN_1410770a0(param_1,auStack_330,uVar10 - 8);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    puVar18 = (uint *)((longlong)auStack_330 + (longlong)piStack_760);
  }
  uVar23 = (ulonglong)uStack_334;
  if ((uVar10 < 0x5c) && (puVar18 != (uint *)0x0)) {
    func_0x00014179cca0(puVar18,0,0x5c - uVar10);
    uVar23 = (ulonglong)uStack_334;
  }
  if (uVar10 < uVar8) {
    uVar8 = itl_106a520(param_1,uVar8 - uVar10);
    if (uVar8 != 0) {
      return (ulonglong)uVar8;
    }
  }
  uVar13 = 0;
  if (*pcVar24 == '\0') {
    uVar8 = (uint)uVar23;
    uStack_338 = (uStack_338 & 0xff0000 | uStack_338 >> 0x10) >> 8 |
                 (uStack_338 & 0xff00 | uStack_338 << 0x10) << 8;
    uStack_334 = (uVar8 & 0xff0000 | (uint)(uVar23 >> 0x10) & 0xffff) >> 8 |
                 (uVar8 << 0x10 | uVar8 & 0xff00) << 8;
    auStack_330[0] =
         (auStack_330[0] & 0xff0000 | auStack_330[0] >> 0x10) >> 8 |
         (auStack_330[0] & 0xff00 | auStack_330[0] << 0x10) << 8;
  }
  if (uStack_338 != 0x68746c6d) {
    return 0xffffff30;
  }
  uStack_6c4 = 0;
  if (auStack_330[0] != 0) {
    do {
      cStack_774 = '\x01';
      uStack_378 = 0;
      uStack_370 = 0;
      uStack_368 = 0;
      uStack_360 = 0;
      uVar8 = FUN_1410770a0(param_1,&iStack_678);
      if (uVar8 != 0) {
        return (ulonglong)uVar8;
      }
      uVar8 = uStack_674;
      if (*pcVar24 == '\0') {
        uVar8 = (uStack_674 & 0xff0000 | uStack_674 >> 0x10) >> 8 |
                (uStack_674 << 0x10 | uStack_674 & 0xff00) << 8;
      }
      piVar19 = aiStack_670;
      uVar10 = 0x2f4;
      if (uVar8 < 0x2f4) {
        uVar10 = uVar8;
      }
      cVar6 = '\x01';
      if (8 < uVar10) {
        if (0xa00000 < (ulonglong)(uVar10 - 8)) {
          return 0xffffff30;
        }
        uVar9 = FUN_1410770a0(param_1,aiStack_670);
        if (uVar9 != 0) {
          return (ulonglong)uVar9;
        }
        piVar19 = (int *)((longlong)aiStack_670 + (ulonglong)(uVar10 - 8));
        cVar6 = cStack_774;
      }
      if ((uVar10 < 0x2f4) && (piVar19 != (int *)0x0)) {
        func_0x00014179cca0(piVar19,0);
      }
      if (uVar10 < uVar8) {
        uVar8 = itl_106a520(param_1,uVar8 - uVar10);
        if (uVar8 != 0) {
          return (ulonglong)uVar8;
        }
      }
      uVar23 = 0;
      func_0x000141069150(param_1,&iStack_678);
      if (iStack_678 != 0x6874696d) {
        return 0xffffff30;
      }
      if (aiStack_670[3] == 1) {
        iVar11 = 0x46494c45;
      }
      else if (aiStack_670[3] == 2) {
        iVar11 = 0x48545450;
      }
      else {
        iVar11 = 0;
        if (aiStack_670[3] == 3) {
          iVar11 = 0x53485244;
        }
        else {
          cVar6 = '\0';
        }
      }
      uVar13 = 0;
      if (((*(char *)(param_1 + 0x1e002f2) == '\0') || (iVar11 != 0x53485244)) && (cVar6 != '\0')) {
        uStack_708 = 0;
        uStack_700 = 0;
        uStack_6f8 = 0;
        uStack_6f0 = 0;
        uStack_6e8 = 0;
        uStack_6e0 = 0;
        iStack_6c8 = 0;
        uVar21 = uVar13;
        if (*(char *)(param_1 + 0x1e001a8) != '\0') {
          lVar12 = FUN_140693780(param_1 + 0x1e002c0,auStack_59c);
          if (lVar12 == 0) {
            uVar21 = 0;
          }
          else {
            uVar21 = *(ulonglong *)(lVar12 + 8);
          }
        }
        if (*(char *)(param_1 + 0x1e001a9) != '\0') {
          lVar12 = FUN_140693780(param_1 + 0x1e002d8,auStack_498);
          if (lVar12 == 0) {
            uVar13 = 0;
          }
          else {
            uVar13 = *(ulonglong *)(lVar12 + 8);
          }
        }
        if (((iStack_770 == 1) &&
            (lVar12 = FUN_14042de70(param_1 + 0x1e00290,&uStack_5f8), lVar12 != 0)) &&
           (*(longlong *)(lVar12 + 8) != 0)) {
          uStack_5f8 = FUN_140ba5880(0);
          *(undefined1 *)(param_1 + 0x1e002f1) = 1;
        }
        piStack_798 = (int *)CONCAT44(piStack_798._4_4_,uStack_600);
        uStack_790 = uStack_5f8;
        uVar13 = FUN_140f92b80(lVar15,iVar11,uVar21,uVar13);
        if (uVar13 == 0) {
          return 0xffffff94;
        }
        pcVar4 = *(char **)(uVar13 + 0x58);
        if (uStack_6b8 == 0) {
          uStack_6b8 = uVar13;
        }
        if (iStack_484 == 0) {
          iStack_484 = aiStack_670[2];
        }
        *(undefined4 *)(pcVar4 + 0x54) = uStack_658;
        *(undefined4 *)(pcVar4 + 0x5c) = uStack_650;
        *(undefined2 *)(uVar13 + 0x10a) = uStack_64c;
        *(undefined2 *)(uVar13 + 0x10c) = uStack_648;
        *(undefined2 *)(uVar13 + 0x10e) = uStack_610;
        *(undefined2 *)(uVar13 + 0x110) = uStack_60e;
        *(undefined2 *)(uVar13 + 0xa6) = uStack_644;
        *(undefined1 *)(uVar13 + 0x104) = uStack_60c;
        *(byte *)(uVar13 + 0x9b) = (bStack_625 & 1) << 2 | *(byte *)(uVar13 + 0x9b) & 0xfb;
        *(byte *)(uVar13 + 0x9a) = (bStack_60b & 1) << 4 | *(byte *)(uVar13 + 0x9a) & 0xef;
        *(undefined2 *)(pcVar4 + 0x4c) = uStack_640;
        *(undefined4 *)(pcVar4 + 0x48) = uStack_5e0;
        *(undefined2 *)(pcVar4 + 0x4e) = uStack_46e;
        *(undefined2 *)(uVar13 + 0x102) = uStack_638;
        *(undefined4 *)(uVar13 + 0xfc) = uStack_604;
        uStack_768 = uVar13;
        pcStack_6c0 = pcVar4;
        uVar7 = func_0x00014106a990(uStack_628);
        *(undefined2 *)(pcVar4 + 0x50) = uVar7;
        *(byte *)(uVar13 + 0x9a) = (bStack_60a & 1) << 2 | *(byte *)(uVar13 + 0x9a) & 0xfb;
        *(undefined2 *)(pcVar4 + 0x6c) = uStack_5e8;
        *(undefined2 *)(pcVar4 + 0x6e) = uStack_5e6;
        *(undefined4 *)(pcVar4 + 0x70) = uStack_5e4;
        bVar3 = *(byte *)(uVar13 + 0x9b);
        bVar16 = (bStack_5d1 & 1) << 3;
        *(byte *)(uVar13 + 0x9b) = bVar16 | bVar3 & 0xf7;
        *(byte *)(uVar13 + 0x9b) = (bStack_447 & 1) << 4 | bVar16 | bVar3 & 0xe7;
        bVar3 = pcVar4[0x41];
        pcVar4[0x41] = bStack_5af & 1 | bVar3 & 0xfe;
        pcVar4[0x41] = (bStack_49b & 1) << 3 | bStack_5af & 1 | bVar3 & 0xf6;
        pcVar4[0x44] = cStack_609;
        pcVar4[0x3f] = cStack_550;
        *(undefined2 *)(uVar13 + 300) = uStack_5d4;
        *(undefined1 *)(uVar13 + 0x90) = uStack_5d2;
        *(byte *)(uVar13 + 0x9c) = (bStack_5b0 & 1) << 4 | *(byte *)(uVar13 + 0x9c) & 0xef;
        *(undefined8 *)(pcVar4 + 0x2d8) = uStack_5ac;
        *(byte *)(uVar13 + 0x9d) = (bStack_5ae & 1) << 3 | *(byte *)(uVar13 + 0x9d) & 0xf7;
        bVar3 = *(byte *)(uVar13 + 0x9b);
        bVar16 = (bStack_5ad & 1) << 6;
        *(byte *)(uVar13 + 0x9b) = bVar16 | bVar3 & 0xbf;
        *(byte *)(uVar13 + 0x9b) = bVar16 | bVar3 & 0x3f | cStack_590 << 7;
        bVar3 = *(byte *)(uVar13 + 0x9d);
        *(byte *)(uVar13 + 0x9d) = bStack_58e & 1 | bVar3 & 0xfe;
        *(byte *)(uVar13 + 0x9d) = (bStack_58b & 1) * '\x02' | bStack_58e & 1 | bVar3 & 0xfc;
        *(byte *)(uVar13 + 0x9c) = (bStack_58f & 1) * '\x02' | *(byte *)(uVar13 + 0x9c) & 0xfd;
        *(undefined4 *)(pcVar4 + 0x2f4) = uStack_588;
        *(undefined4 *)(pcVar4 + 0x2f8) = uStack_578;
        *(undefined8 *)(pcVar4 + 0x2e0) = uStack_584;
        *(undefined8 *)(pcVar4 + 0x2e8) = uStack_558;
        *(undefined4 *)(pcVar4 + 0x2f0) = uStack_574;
        *(undefined2 *)(pcVar4 + 0x52) = uStack_620;
        *(undefined4 *)(pcVar4 + 0x68) = uStack_5b8;
        *(undefined2 *)(uVar13 + 0x100) = uStack_5b4;
        bVar3 = *(byte *)(uVar13 + 0x9d);
        bVar16 = (bStack_58d & 1) << 6;
        *(byte *)(uVar13 + 0x9d) = bVar16 | bVar3 & 0xbf;
        *(byte *)(uVar13 + 0x9d) = (bStack_464 & 1) << 5 | bVar16 | bVar3 & 0x9f;
        *(byte *)(uVar13 + 0x9a) = *(byte *)(uVar13 + 0x9a) & 0x7f | cStack_463 << 7;
        *(byte *)(uVar13 + 0x9d) = cStack_58c << 7 | *(byte *)(uVar13 + 0x9d) & 0x7f;
        *(byte *)(uVar13 + 0x9e) = bStack_3fb & 1 | *(byte *)(uVar13 + 0x9e) & 0xfe;
        bVar3 = *(byte *)(uVar13 + 0x9f);
        bVar16 = (bStack_3fa & 1) << 4;
        *(byte *)(uVar13 + 0x9f) = bVar16 | bVar3 & 0xef;
        *(byte *)(uVar13 + 0x9f) = (bStack_3f9 & 1) << 5 | bVar16 | bVar3 & 0xcf;
        bVar3 = *(byte *)(uVar13 + 0x9e);
        bVar16 = (bStack_589 & 1) * '\x02';
        *(byte *)(uVar13 + 0x9e) = bVar16 | bVar3 & 0xfd;
        *(byte *)(uVar13 + 0x9e) = (bStack_58a & 1) << 2 | bVar16 | bVar3 & 0xf9;
        *(undefined4 *)(pcVar4 + 0x74) = uStack_57c;
        *(undefined4 *)(uVar13 + 0xe0) = uStack_3e8;
        *(undefined4 *)(uVar13 + 0xe4) = uStack_3e4;
        *(undefined4 *)(uVar13 + 0xe8) = uStack_3e0;
        *(undefined4 *)(uVar13 + 0xec) = uStack_3dc;
        *(undefined4 *)(uVar13 + 0xf0) = uStack_3d8;
        *(undefined4 *)(uVar13 + 0xf4) = uStack_3d4;
        *(undefined4 *)(uVar13 + 0xf8) = uStack_3d0;
        *(byte *)(uVar13 + 0x9e) = (bStack_564 & 1) << 3 | *(byte *)(uVar13 + 0x9e) & 0xf7;
        *(byte *)(uVar13 + 0x9c) = *(byte *)(uVar13 + 0x9c) & 0xfe | bStack_562 & 1;
        *(undefined4 *)(uVar13 + 0x120) = uStack_5a0;
        *(undefined4 *)(uVar13 + 0x124) = uStack_560;
        *(undefined4 *)(uVar13 + 0x128) = uStack_55c;
        FUN_140fa2b30(uVar13,uStack_54f);
        *(undefined8 *)(uVar13 + 0x140) = uStack_544;
        *(undefined8 *)(uVar13 + 0x148) = uStack_53c;
        *(byte *)(uVar13 + 0x9c) = (bStack_499 & 1) << 3 | *(byte *)(uVar13 + 0x9c) & 0xf7;
        pcVar4[0x42] = (bStack_40a & 1) << 5 | pcVar4[0x42] & 0xdfU;
        *(byte *)(uVar13 + 0x9f) = (bStack_409 & 1) << 2 | *(byte *)(uVar13 + 0x9f) & 0xfb;
        *(undefined8 *)(uVar13 + 0x150) = uStack_494;
        *(undefined4 *)(uVar13 + 0x158) = uStack_488;
        *(undefined4 *)(uVar13 + 0x15c) = uStack_458;
        *(undefined8 *)(uVar13 + 0x138) = uStack_47c;
        *(longlong *)(pcVar4 + 0x60) = lStack_534;
        if (lStack_534 == 0) {
          *(ulonglong *)(pcVar4 + 0x60) = (ulonglong)uStack_654;
        }
        pcVar4[0x40] = (bStack_561 & 1) << 3 | pcVar4[0x40] & 0xf7U;
        pcVar4[0x3e] = cStack_448;
        *(undefined4 *)(pcVar4 + 0x38) = uStack_5ec;
        bVar3 = pcVar4[0x41];
        bVar16 = (bStack_65f & 1) << 4;
        pcVar4[0x41] = bVar16 | bVar3 & 0xef;
        bVar20 = (bStack_462 & 1) << 5;
        pcVar4[0x41] = bVar20 | bVar16 | bVar3 & 0xcf;
        pcVar4[0x41] = (bStack_660 & 1) << 6 | bVar20 | bVar16 | bVar3 & 0x8f;
        *(undefined4 *)(pcVar4 + 0x2c) = uStack_44c;
        *(undefined4 *)(uVar13 + 0xac) = uStack_404;
        bVar3 = *(byte *)(uVar13 + 0x88);
        bVar17 = (bStack_420 & 1) << 3;
        *(byte *)(uVar13 + 0x88) = bVar17 | bVar3 & 0xf7;
        bVar20 = bStack_41c & 1;
        *(byte *)(uVar13 + 0x88) = bVar20 | bVar17 | bVar3 & 0xf6;
        bVar16 = (bStack_41b & 1) * '\x02';
        *(byte *)(uVar13 + 0x88) = bVar16 | bVar20 | bVar17 | bVar3 & 0xf4;
        *(byte *)(uVar13 + 0x88) = (bStack_41a & 1) << 2 | bVar16 | bVar20 | bVar17 | bVar3 & 0xf0;
        *(undefined4 *)(uVar13 + 0x8c) = uStack_400;
        *(undefined1 *)(uVar13 + 0x89) = uStack_396;
        if (bStack_418 != 0) {
          if ((((pcVar4 != (char *)0x0) && (*(longlong *)(pcVar4 + 8) != 0)) &&
              (lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0)) &&
             (((**(byte **)(pcVar4 + 0x20) & 1) == 0 && (*(int *)(lVar12 + 0x80) == 0x74646174)))) {
            pbVar14 = (byte *)FUN_140bc62b0(*(undefined8 *)(lVar12 + 0x150));
            *(byte **)(pcVar4 + 0x20) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          **(byte **)(pcVar4 + 0x20) = (bStack_418 & 1) * '\x02' | **(byte **)(pcVar4 + 0x20) & 0xfd
          ;
        }
        if (bStack_416 != 0) {
          if (((*(longlong *)(pcVar4 + 8) != 0) &&
              (lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0)) &&
             (((**(byte **)(pcVar4 + 0x20) & 1) == 0 && (*(int *)(lVar12 + 0x80) == 0x74646174)))) {
            pbVar14 = (byte *)FUN_140bc62b0(*(undefined8 *)(lVar12 + 0x150));
            *(byte **)(pcVar4 + 0x20) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          **(byte **)(pcVar4 + 0x20) = (bStack_416 & 1) << 3 | **(byte **)(pcVar4 + 0x20) & 0xf7;
        }
        if (bStack_417 != 0) {
          if ((((*(longlong *)(pcVar4 + 8) != 0) &&
               (lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0)) &&
              ((**(byte **)(pcVar4 + 0x20) & 1) == 0)) && (*(int *)(lVar12 + 0x80) == 0x74646174)) {
            pbVar14 = (byte *)FUN_140bc62b0(*(undefined8 *)(lVar12 + 0x150));
            *(byte **)(pcVar4 + 0x20) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          **(byte **)(pcVar4 + 0x20) = (bStack_417 & 1) << 2 | **(byte **)(pcVar4 + 0x20) & 0xfb;
        }
        if (iStack_634 != 0) {
          FUN_140f92fd0(uVar13);
          *(int *)(*(longlong *)(uVar13 + 0x78) + 4) = iStack_634;
        }
        if (iStack_630 != 0) {
          FUN_140f92fd0(uVar13);
          *(int *)(*(longlong *)(uVar13 + 0x78) + 8) = iStack_630;
        }
        if (iStack_5fc != 0) {
          FUN_140f92fd0(uVar13);
          *(int *)(*(longlong *)(uVar13 + 0x78) + 0xc) = iStack_5fc;
        }
        if (iStack_408 != 0) {
          FUN_140f92fd0(uVar13);
          *(int *)(*(longlong *)(uVar13 + 0x78) + 0x14) = iStack_408;
        }
        if (bStack_3fc == 0) {
          bStack_3fc = 2;
        }
        uVar8 = (uint)bStack_3fc;
        if (bStack_3fc == 0) {
          if (((lStack_444 != 0) || (lStack_43c != 0)) || (lStack_3f0 != 0)) goto LAB_14107c1ff;
          if (*(int *)(*(longlong *)(pcVar4 + 0x20) + 4) != 2) {
            if (*(int *)(*(longlong *)(pcVar4 + 0x20) + 4) != 3) goto LAB_14107c1ff;
            uVar8 = 3;
LAB_14107c1dd:
            if (uVar8 != 2) {
              if (uVar8 == 3) {
                FUN_140fa9ed0(pcVar4,lStack_444);
              }
              goto LAB_14107c1ff;
            }
          }
          FUN_140faa080(pcVar4,lStack_444);
        }
        else if (lStack_444 == 0) {
          if ((lStack_43c == 0) && (lStack_3f0 == 0)) goto LAB_14107c1d5;
        }
        else if (lStack_43c != 0) {
LAB_14107c1d5:
          if (uVar8 - 2 < 2) goto LAB_14107c1dd;
        }
LAB_14107c1ff:
        if (cStack_41d != '\0') {
          *(char *)(uVar13 + 0x8a) = cStack_41d;
        }
        if (iStack_480 != 0) {
          FUN_140f92f00(uVar13);
          *(int *)(*(longlong *)(uVar13 + 0x68) + 0x10) = iStack_480;
        }
        *(byte *)(uVar13 + 0xa0) = (bStack_39f & 1) << 3 | *(byte *)(uVar13 + 0xa0) & 0xf7;
        pcVar4[0x40] = (bStack_39e & 1) * '\x02' | pcVar4[0x40] & 0xfdU;
        if (((iStack_5d8 != 0) || (cStack_39d != '\0')) || (iStack_39c != 0)) {
          if ((((**(byte **)(pcVar4 + 0x10) & 1) == 0) && (*(longlong *)(pcVar4 + 8) != 0)) &&
             ((lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0 &&
              (*(int *)(lVar12 + 0x80) == 0x74646174)))) {
            pbVar14 = (byte *)FUN_140bc62b0(*(undefined8 *)(lVar12 + 0x138));
            *(byte **)(pcVar4 + 0x10) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          **(byte **)(pcVar4 + 0x10) = cStack_39d << 7 | **(byte **)(pcVar4 + 0x10) & 0x7f;
          *(int *)(*(longlong *)(pcVar4 + 0x10) + 0x8c) = iStack_5d8;
          *(int *)(*(longlong *)(pcVar4 + 0x10) + 0x90) = iStack_39c;
        }
        if (iStack_56c != 0) {
          FUN_140f92f70(uVar13);
          *(int *)(*(longlong *)(uVar13 + 0x70) + 4) = iStack_56c;
        }
        if (iStack_568 != 0) {
          FUN_140f92f70(uVar13);
          *(int *)(*(longlong *)(uVar13 + 0x70) + 8) = iStack_568;
        }
        if (uStack_4cc == 0) {
          uStack_4cc = (ulonglong)uStack_5d0;
        }
        FUN_140fab080();
        if ((uStack_4bc != 0) || (uStack_4bc = (ulonglong)uStack_5c8, uStack_4bc != 0)) {
          if (((**(byte **)(pcVar4 + 0x10) & 1) == 0) &&
             (((*(longlong *)(pcVar4 + 8) != 0 &&
               (lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0)) &&
              (*(int *)(lVar12 + 0x80) == 0x74646174)))) {
            pbVar14 = (byte *)FUN_140bc62b0(*(undefined8 *)(lVar12 + 0x138));
            *(byte **)(pcVar4 + 0x10) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          *(ulonglong *)(*(longlong *)(pcVar4 + 0x10) + 0x48) = uStack_4bc;
        }
        if ((uStack_4ac != 0) || (uStack_4ac = (ulonglong)uStack_5c0, uStack_4ac != 0)) {
          FUN_140fa6150(pcVar4);
          *(ulonglong *)(*(longlong *)(pcVar4 + 0x10) + 0x58) = uStack_4ac;
        }
        if ((uStack_4c4 != 0) || (uStack_4c4 = (ulonglong)uStack_5cc, uStack_4c4 != 0)) {
          FUN_140fa6150(pcVar4);
          *(ulonglong *)(*(longlong *)(pcVar4 + 0x10) + 0x40) = uStack_4c4;
        }
        if ((uStack_4b4 != 0) || (uStack_4b4 = (ulonglong)uStack_5c4, uStack_4b4 != 0)) {
          FUN_140fa6150(pcVar4);
          *(ulonglong *)(*(longlong *)(pcVar4 + 0x10) + 0x50) = uStack_4b4;
        }
        if ((uStack_4a4 != 0) || (uStack_4a4 = (ulonglong)uStack_594, uStack_4a4 != 0)) {
          FUN_140fa6150(pcVar4);
          *(ulonglong *)(*(longlong *)(pcVar4 + 0x10) + 0x60) = uStack_4a4;
        }
        if (iStack_5dc != 0) {
          FUN_140fa6150(pcVar4);
          *(int *)(*(longlong *)(pcVar4 + 0x10) + 0x88) = iStack_5dc;
        }
        if (cStack_626 != '\0') {
          FUN_140f92f00(uVar13);
          *(char *)(*(longlong *)(uVar13 + 0x68) + 1) = cStack_626;
        }
        if (iStack_5bc != 0) {
          FUN_140f92f00(uVar13);
          *(int *)(*(longlong *)(uVar13 + 0x68) + 4) = iStack_5bc;
        }
        if ((lStack_54c != 0) || (lStack_414 != 0)) {
          FUN_140fa2d60();
        }
        if (((sStack_3a8 != 0) || (sStack_3a6 != 0)) || (bStack_3a4 != 0)) {
          if ((((**(byte **)(uVar13 + 0x68) & 1) == 0) && (*(longlong *)(uVar13 + 0x10) != 0)) &&
             ((*(int *)(*(longlong *)(uVar13 + 0x10) + 0x80) == 0x74646174 &&
              (pbVar14 = (byte *)FUN_140bc62b0(), pbVar14 != (byte *)0x0)))) {
            pbVar14[0x58] = 0;
            pbVar14[0x59] = 0;
            pbVar14[0x5a] = 0;
            pbVar14[0x5b] = 0;
            pbVar14[0x5c] = 0;
            pbVar14[0x5d] = 0;
            pbVar14[0x5e] = 0;
            pbVar14[0x5f] = 0;
            pbVar14[0x60] = 0;
            pbVar14[0x61] = 0;
            pbVar14[0x62] = 0;
            pbVar14[99] = 0;
            pbVar14[100] = 0;
            pbVar14[0x65] = 0;
            pbVar14[0x66] = 0;
            pbVar14[0x67] = 0;
            pbVar14[0x68] = 0;
            pbVar14[0x69] = 0;
            pbVar14[0x6a] = 0;
            pbVar14[0x6b] = 0;
            pbVar14[0x6c] = 0;
            pbVar14[0x6d] = 0;
            pbVar14[0x6e] = 0;
            pbVar14[0x6f] = 0;
            pbVar14[0x70] = 0;
            pbVar14[0x71] = 0;
            pbVar14[0x72] = 0;
            pbVar14[0x73] = 0;
            pbVar14[0x74] = 0;
            pbVar14[0x75] = 0;
            pbVar14[0x76] = 0;
            pbVar14[0x77] = 0;
            *(byte **)(uVar13 + 0x68) = pbVar14;
            *pbVar14 = *pbVar14 | 1;
          }
          *(short *)(*(longlong *)(uVar13 + 0x68) + 0x14) = sStack_3a8;
          *(short *)(*(longlong *)(uVar13 + 0x68) + 0x16) = sStack_3a6;
          **(byte **)(uVar13 + 0x68) = (bStack_3a4 & 1) << 3 | **(byte **)(uVar13 + 0x68) & 0xf7;
        }
        if (cStack_51c != '\0') {
          if ((((**(byte **)(pcVar4 + 0x18) & 1) == 0) && (*(longlong *)(pcVar4 + 8) != 0)) &&
             ((lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0 &&
              (*(int *)(lVar12 + 0x80) == 0x74646174)))) {
            pbVar14 = (byte *)FUN_140bc62b0();
            *(byte **)(pcVar4 + 0x18) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          *(undefined1 *)(*(longlong *)(pcVar4 + 0x18) + 0x18) = 1;
        }
        if (cStack_508 != '\0') {
          if (((((**(byte **)(pcVar4 + 0x18) & 1) == 0) && (*(longlong *)(pcVar4 + 8) != 0)) &&
              (lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0)) &&
             (*(int *)(lVar12 + 0x80) == 0x74646174)) {
            pbVar14 = (byte *)FUN_140bc62b0();
            *(byte **)(pcVar4 + 0x18) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          *(undefined1 *)(*(longlong *)(pcVar4 + 0x18) + 0x1a) = 1;
        }
        if (cStack_505 != '\0') {
          if ((((**(byte **)(pcVar4 + 0x18) & 1) == 0) && (*(longlong *)(pcVar4 + 8) != 0)) &&
             ((lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0 &&
              (*(int *)(lVar12 + 0x80) == 0x74646174)))) {
            pbVar14 = (byte *)FUN_140bc62b0();
            *(byte **)(pcVar4 + 0x18) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          **(byte **)(pcVar4 + 0x18) = **(byte **)(pcVar4 + 0x18) | 8;
        }
        if (cStack_51b != '\0') {
          if ((((**(byte **)(pcVar4 + 0x18) & 1) == 0) && (*(longlong *)(pcVar4 + 8) != 0)) &&
             ((lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0 &&
              (*(int *)(lVar12 + 0x80) == 0x74646174)))) {
            pbVar14 = (byte *)FUN_140bc62b0();
            *(byte **)(pcVar4 + 0x18) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          *(undefined1 *)(*(longlong *)(pcVar4 + 0x18) + 0x19) = 1;
        }
        if (bStack_415 == 0) {
          if (*(longlong *)(uVar13 + 0x10) != 0) {
            if ((*(byte *)(uVar13 + 0x9c) & 2) == 0) {
              if ((*(byte *)(uVar13 + 0x9a) & 1) != 0) {
                uVar8 = *(uint *)(*(longlong *)(uVar13 + 0x68) + 0x10);
                if (uVar8 == 0) {
                  if (*(int *)(uVar13 + 0xac) == 0) {
                    iVar11 = FUN_140f91240(uVar13);
                    *(int *)(uVar13 + 0xac) = iVar11;
                    if (iVar11 != 0) {
                      FUN_140f94100(uVar13,0x3c);
                    }
                  }
                  uVar8 = *(uint *)(uVar13 + 0xac);
                }
                if ((uVar8 & 0xc62) != 0) goto LAB_14107c7b1;
              }
            }
            else {
LAB_14107c7b1:
              if (((((**(byte **)(pcVar4 + 0x18) & 1) == 0) && (*(longlong *)(pcVar4 + 8) != 0)) &&
                  (lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0)) &&
                 (*(int *)(lVar12 + 0x80) == 0x74646174)) {
                pbVar14 = (byte *)FUN_140bc62b0();
                *(byte **)(pcVar4 + 0x18) = pbVar14;
                if (pbVar14 != (byte *)0x0) {
                  *pbVar14 = *pbVar14 | 1;
                }
              }
              *(undefined2 *)(*(longlong *)(pcVar4 + 0x18) + 0x12) = 0;
            }
          }
          if (cStack_49a != '\0') {
            if ((((**(byte **)(pcVar4 + 0x18) & 1) == 0) && (*(longlong *)(pcVar4 + 8) != 0)) &&
               ((lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0 &&
                (*(int *)(lVar12 + 0x80) == 0x74646174)))) {
              pbVar14 = (byte *)FUN_140bc62b0(*(undefined8 *)(lVar12 + 0x148));
              *(byte **)(pcVar4 + 0x18) = pbVar14;
              if (pbVar14 != (byte *)0x0) {
                *pbVar14 = *pbVar14 | 1;
              }
            }
            *(undefined2 *)(*(longlong *)(pcVar4 + 0x18) + 0x12) = 1;
          }
        }
        else {
          if ((((**(byte **)(pcVar4 + 0x18) & 1) == 0) && (*(longlong *)(pcVar4 + 8) != 0)) &&
             ((lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0 &&
              (*(int *)(lVar12 + 0x80) == 0x74646174)))) {
            pbVar14 = (byte *)FUN_140bc62b0(*(undefined8 *)(lVar12 + 0x148));
            *(byte **)(pcVar4 + 0x18) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          *(ushort *)(*(longlong *)(pcVar4 + 0x18) + 0x12) = (ushort)bStack_415;
          *(ushort *)(*(longlong *)(pcVar4 + 0x18) + 0x14) = (ushort)bStack_398;
        }
        if (uStack_4dc == 0) {
          uStack_4dc = (ulonglong)uStack_518;
        }
        if (uStack_4e4 == 0) {
          uStack_4e4 = (ulonglong)uStack_608;
        }
        if (uStack_4d4 == 0) {
          uStack_4d4 = (ulonglong)uStack_5f0;
        }
        if ((((uStack_4dc != 0) || (uStack_4e4 != 0)) || (uStack_4d4 != 0)) ||
           (((lStack_46c != 0 || (iStack_5a4 != 0)) || (iStack_48c != 0)))) {
          FUN_140fa6150(pcVar4);
          *(ulonglong *)(*(longlong *)(pcVar4 + 0x10) + 0x20) = uStack_4dc;
          *(ulonglong *)(*(longlong *)(pcVar4 + 0x10) + 8) = uStack_4e4;
          *(ulonglong *)(*(longlong *)(pcVar4 + 0x10) + 0x10) = uStack_4d4;
          *(longlong *)(*(longlong *)(pcVar4 + 0x10) + 0x18) = lStack_46c;
          *(int *)(*(longlong *)(pcVar4 + 0x10) + 0x84) = iStack_5a4;
          *(int *)(*(longlong *)(pcVar4 + 0x10) + 4) = iStack_48c;
          *(undefined8 *)(*(longlong *)(pcVar4 + 0x10) + 0x28) = uStack_3cc;
          *(undefined8 *)(*(longlong *)(pcVar4 + 0x10) + 0x30) = uStack_3c4;
          **(byte **)(pcVar4 + 0x10) = (bStack_41f & 1) * '\x02' | **(byte **)(pcVar4 + 0x10) & 0xfd
          ;
          **(byte **)(pcVar4 + 0x10) = (bStack_41e & 1) << 2 | **(byte **)(pcVar4 + 0x10) & 0xfb;
          **(byte **)(pcVar4 + 0x10) = (bStack_40c & 1) << 5 | **(byte **)(pcVar4 + 0x10) & 0xdf;
        }
        bVar3 = pcVar4[0x42];
        bVar16 = (bStack_3bc & 1) << 6;
        pcVar4[0x42] = bVar16 | bVar3 & 0xbf;
        pcVar4[0x42] = bVar16 | bVar3 & 0x3f | cStack_3a3 << 7;
        *(byte *)(uVar13 + 0x9f) = (bStack_3ba & 1) << 6 | *(byte *)(uVar13 + 0x9f) & 0xbf;
        bVar3 = *(byte *)(uVar13 + 0xa0);
        *(byte *)(uVar13 + 0xa0) = bVar3 & 0xfe | bStack_3ac & 1;
        *(byte *)(uVar13 + 0xa0) = (bStack_3ab & 1) * '\x02' | bVar3 & 0xfc | bStack_3ac & 1;
        *(undefined1 *)(uVar13 + 0x107) = uStack_3b9;
        *(byte *)(uVar13 + 0xa0) = (bStack_3aa & 1) << 2 | *(byte *)(uVar13 + 0xa0) & 0xfb;
        pcVar4[0x45] = cStack_397;
        pcVar4[0x43] = bStack_395 & 1 | pcVar4[0x43] & 0xfeU;
        if (((lStack_3b4 != 0) || (bStack_3bb != 0)) ||
           ((cStack_3b8 != '\0' ||
            (((cStack_3b7 != '\0' || (cStack_3b6 != '\0')) || (cStack_3b5 != '\0')))))) {
          if (((*(longlong *)(pcVar4 + 8) != 0) &&
              (lVar12 = *(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10), lVar12 != 0)) &&
             (((**(byte **)(pcVar4 + 0x20) & 1) == 0 && (*(int *)(lVar12 + 0x80) == 0x74646174)))) {
            pbVar14 = (byte *)FUN_140bc62b0(*(undefined8 *)(lVar12 + 0x150));
            *(byte **)(pcVar4 + 0x20) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          *(longlong *)(*(longlong *)(pcVar4 + 0x20) + 0x20) = lStack_3b4;
          **(byte **)(pcVar4 + 0x20) = (bStack_3bb & 1) << 4 | **(byte **)(pcVar4 + 0x20) & 0xef;
          *(char *)(*(longlong *)(pcVar4 + 0x20) + 0x28) = cStack_3b8;
          *(char *)(*(longlong *)(pcVar4 + 0x20) + 0x29) = cStack_3b7;
          *(char *)(*(longlong *)(pcVar4 + 0x20) + 0x2a) = cStack_3b6;
          *(char *)(*(longlong *)(pcVar4 + 0x20) + 0x2b) = cStack_3b5;
        }
        if (*(float *)(pcVar4 + 0x48) == 0.0) {
          *(float *)(pcVar4 + 0x48) = (float)uStack_63c * 1.5258789e-05;
        }
        if (*(int *)(param_1 + 0x3c) != 0) {
          *(undefined4 *)(uVar13 + 0x11c) = uStack_614;
          *(undefined4 *)(uVar13 + 0x114) = uStack_62c;
          *(undefined4 *)(uVar13 + 0x118) = uStack_618;
        }
        if (*(int *)(pcVar4 + 0x34) == 0x46494c45) {
          *(undefined4 *)(pcVar4 + 700) = uStack_65c;
          *(undefined2 *)(pcVar4 + 0x2c4) = uStack_61c;
          *(undefined2 *)(pcVar4 + 0x2c6) = uStack_61a;
        }
        else if (*(int *)(pcVar4 + 0x34) == 0x53485244) {
          if (uStack_3f8 == 0) {
            uStack_3f8 = (ulonglong)uStack_42c;
          }
          if (bStack_40b == 0) {
            bStack_40b = 2;
          }
          *(longlong *)(pcVar4 + 0x88) = lStack_3f0;
          *(ulonglong *)(pcVar4 + 0x80) = uStack_3f8;
          *(uint *)(pcVar4 + 0x90) = (uint)bStack_40b;
          *(undefined4 *)(pcVar4 + 0x98) = uStack_428;
          *(undefined4 *)(pcVar4 + 0x9c) = uStack_424;
          pcVar4[0x94] = cStack_446;
          pcVar4[0x95] = cStack_445;
          pcVar4[0x3c] = '\x01';
          if (cStack_419 != '\0') {
            pcVar4[0x3d] = '\x01';
          }
        }
        if (cStack_54d != '\0') {
          FUN_140fa61c0(pcVar4);
          **(byte **)(pcVar4 + 0x18) = **(byte **)(pcVar4 + 0x18) | 0x10;
        }
        if (((iStack_4ec != 0) || (uStack_50c != 0)) ||
           ((iStack_4e8 != 0 || ((iStack_4f4 != 0 || (iStack_4f0 != 0)))))) {
          if (((**(byte **)(uVar13 + 0x70) & 1) == 0) &&
             ((lVar12 = *(longlong *)(uVar13 + 0x10), lVar12 != 0 &&
              (*(int *)(lVar12 + 0x80) == 0x74646174)))) {
            pbVar14 = (byte *)FUN_140bc62b0(*(undefined8 *)(lVar12 + 0x140));
            *(byte **)(uVar13 + 0x70) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          if ((iStack_4ec == 0) && (0x278d00 < uStack_50c)) {
            iStack_4ec = uStack_50c - 0x278d00;
            iStack_4e8 = 0x278d00;
          }
          *(int *)(*(longlong *)(uVar13 + 0x70) + 0xc) = iStack_4ec;
          *(int *)(*(longlong *)(uVar13 + 0x70) + 0x10) = iStack_4e8;
          *(int *)(*(longlong *)(uVar13 + 0x70) + 0x14) = iStack_4f4;
          *(int *)(*(longlong *)(uVar13 + 0x70) + 0x18) = iStack_4f0;
        }
        if (((cStack_3a2 != '\0') || (cStack_3a1 != '\0')) || (cStack_3a0 != '\0')) {
          if ((((**(byte **)(uVar13 + 0x70) & 1) == 0) &&
              (lVar12 = *(longlong *)(uVar13 + 0x10), lVar12 != 0)) &&
             (*(int *)(lVar12 + 0x80) == 0x74646174)) {
            pbVar14 = (byte *)FUN_140bc62b0(*(undefined8 *)(lVar12 + 0x140));
            *(byte **)(uVar13 + 0x70) = pbVar14;
            if (pbVar14 != (byte *)0x0) {
              *pbVar14 = *pbVar14 | 1;
            }
          }
          *(char *)(*(longlong *)(uVar13 + 0x70) + 0x20) = cStack_3a2;
          *(char *)(*(longlong *)(uVar13 + 0x70) + 0x21) = cStack_3a1;
          *(char *)(*(longlong *)(uVar13 + 0x70) + 0x22) = cStack_3a0;
        }
        if (((bStack_507 != 0) || (bStack_506 != 0)) ||
           ((sStack_504 != 0 ||
            ((((sStack_502 != 0 || (iStack_500 != 0)) || (sStack_4fc != 0)) ||
             ((sStack_4fa != 0 || (iStack_4f8 != 0)))))))) {
          FUN_140fa61c0(pcVar4);
          **(byte **)(pcVar4 + 0x18) = (bStack_507 & 1) * '\x02' | **(byte **)(pcVar4 + 0x18) & 0xfd
          ;
          **(byte **)(pcVar4 + 0x18) = (bStack_506 & 1) << 2 | **(byte **)(pcVar4 + 0x18) & 0xfb;
          *(short *)(*(longlong *)(pcVar4 + 0x18) + 2) = sStack_504;
          *(short *)(*(longlong *)(pcVar4 + 0x18) + 0xc) = sStack_502;
          *(int *)(*(longlong *)(pcVar4 + 0x18) + 4) = iStack_500;
          *(short *)(*(longlong *)(pcVar4 + 0x18) + 0xe) = sStack_4fc;
          *(short *)(*(longlong *)(pcVar4 + 0x18) + 0x10) = sStack_4fa;
          *(int *)(*(longlong *)(pcVar4 + 0x18) + 8) = iStack_4f8;
        }
        if ((char)*(byte *)(uVar13 + 0x9d) < '\0') {
          *(byte *)(uVar13 + 0x9d) = *(byte *)(uVar13 + 0x9d) & 0xf7;
          *(byte *)(uVar13 + 0x9a) = *(byte *)(uVar13 + 0x9a) & 0xfd;
        }
        if (cStack_52c == '\0') {
          cStack_788 = '\x01';
        }
        else {
          *(char *)(uVar13 + 0x92) = cStack_52c;
        }
        if (cStack_52b == '\0') {
          cStack_788 = '\x01';
        }
        else {
          *(char *)(uVar13 + 0x93) = cStack_52b;
        }
        if (cStack_52a == '\0') {
          cStack_788 = '\x01';
        }
        else {
          *(char *)(uVar13 + 0x94) = cStack_52a;
        }
        if (cStack_529 == '\0') {
          cStack_788 = '\x01';
        }
        else {
          *(char *)(uVar13 + 0x95) = cStack_529;
        }
        if (cStack_528 == '\0') {
          cStack_788 = '\x01';
        }
        else {
          *(char *)(uVar13 + 0x96) = cStack_528;
        }
        if (cStack_527 == '\0') {
          cStack_788 = '\x01';
        }
        else {
          *(char *)(uVar13 + 0x97) = cStack_527;
        }
        FUN_140693570(param_1 + 0x1e002a8,auStack_6b0,&iStack_484,&pcStack_6c0);
        if (iStack_770 == 1) {
          FUN_140693570(param_1 + 0x1e00278,&uStack_358,aiStack_670 + 2,&uStack_768);
          FUN_140af68f0(param_1 + 0x1e00290,auStack_698,&uStack_5f8,&uStack_768);
        }
        uStack_778 = 0;
        if (aiStack_670[1] != 0) {
          do {
            pcStack_6c0 = pcVar24;
            uVar8 = FUN_1410770a0(param_1,&uStack_358,8);
            if (uVar8 != 0) {
              return (ulonglong)uVar8;
            }
            uVar8 = uStack_354;
            if (*pcVar24 == '\0') {
              uVar8 = uStack_354 >> 0x18 | (uStack_354 & 0xff0000) >> 8 | (uStack_354 & 0xff00) << 8
                      | uStack_354 << 0x18;
            }
            puVar18 = auStack_350;
            uVar10 = 0x18;
            if (uVar8 < 0x18) {
              uVar10 = uVar8;
            }
            if (8 < uVar10) {
              uVar23 = (ulonglong)(uVar10 - 8);
              if (0xa00000 < uVar23) {
                return 0xffffff30;
              }
              uVar9 = FUN_1410770a0(param_1,auStack_350,uVar23);
              if (uVar9 != 0) {
                return (ulonglong)uVar9;
              }
              puVar18 = (uint *)((longlong)auStack_350 + uVar23);
            }
            uVar23 = (ulonglong)uStack_354;
            if ((uVar10 < 0x18) && (puVar18 != (uint *)0x0)) {
              func_0x00014179cca0(puVar18,0,0x18 - uVar10);
              uVar23 = (ulonglong)uStack_354;
            }
            if (uVar10 < uVar8) {
              uVar8 = itl_106a520(param_1,uVar8 - uVar10);
              if (uVar8 != 0) {
                return (ulonglong)uVar8;
              }
            }
            pcVar24 = pcStack_6c0;
            uVar8 = (uint)uVar23;
            if (*pcStack_6c0 == '\0') {
              uStack_358 = (uStack_358 & 0xff0000 | uStack_358 >> 0x10) >> 8 |
                           (uStack_358 << 0x10 | uStack_358 & 0xff00) << 8;
              uVar8 = (uVar8 & 0xff0000 | (uint)(uVar23 >> 0x10) & 0xffff) >> 8 |
                      (uVar8 << 0x10 | uVar8 & 0xff00) << 8;
              auStack_350[0] =
                   (auStack_350[0] & 0xff0000 | auStack_350[0] >> 0x10) >> 8 |
                   (auStack_350[0] << 0x10 | auStack_350[0] & 0xff00) << 8;
              auStack_350[1] =
                   (auStack_350[1] & 0xff0000 | auStack_350[1] >> 0x10) >> 8 |
                   (auStack_350[1] << 0x10 | auStack_350[1] & 0xff00) << 8;
              auStack_350[2] =
                   (auStack_350[2] & 0xff0000 | auStack_350[2] >> 0x10) >> 8 |
                   (auStack_350[2] << 0x10 | auStack_350[2] & 0xff00) << 8;
              uStack_354 = uVar8;
            }
            if (uStack_358 != 0x686f686d) {
              return 0xffffff30;
            }
            uVar21 = 0;
            uVar8 = auStack_350[0] - uVar8;
            uVar23 = 0;
            switch(auStack_350[1]) {
            default:
              goto LAB_14107e4c7;
            case 2:
              piStack_798 = (int *)(uVar13 + 0xb0);
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x178);
              uStack_378 = uStack_378 | 0x20;
              break;
            case 3:
              piStack_798 = (int *)(uVar13 + 0xbc);
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x1c0);
              uStack_378 = uStack_378 | 0x10;
              break;
            case 4:
              piStack_798 = (int *)(uVar13 + 0xb4);
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x208);
              uStack_378 = uStack_378 | 8;
              break;
            case 5:
              piStack_798 = (int *)(uVar13 + 200);
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x328);
              uStack_378 = uStack_378 | 0x8000;
              break;
            case 6:
              piStack_798 = (int *)(uVar13 + 0xcc);
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x370);
              uStack_378 = uStack_378 | 0x4000;
              break;
            case 7:
              piVar19 = (int *)(uVar13 + 0xd0);
              lVar15 = lStack_780 + 0x3b8;
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              piStack_798 = piVar19;
              uVar8 = FUN_1410773d0(param_1,1,lVar15,0);
              if (uVar8 != 0) {
                return (ulonglong)uVar8;
              }
              FUN_140bff470(lVar15,*piVar19,auStack_2d8);
              cVar6 = FUN_140eaa0b0(auStack_2d8,auStack_2d8);
              uVar23 = 0;
              if (cVar6 != '\0') {
                uVar8 = func_0x000140bfed40(lVar15,auStack_2d8,piVar19);
                uStack_378 = uStack_378 | 0x400000;
                break;
              }
              goto LAB_14107e4f7;
            case 8:
              piStack_798 = (int *)(uVar13 + 0xd4);
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x400);
              uStack_378 = uStack_378 | 0x200;
              break;
            case 9:
              piStack_798 = (int *)(uVar13 + 0xd8);
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x448);
              uStack_378 = uStack_378 | 0x1000000000000;
              break;
            case 10:
              piStack_798 = (int *)(uVar13 + 0xdc);
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x490);
              uStack_378 = uStack_378 | 0x40000;
              break;
            case 0xb:
              if (*(int *)(pcVar4 + 0x34) == 0x46494c45) {
                piStack_798 = (int *)(pcVar4 + 0x2c0);
                uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
                uVar8 = FUN_1410773d0(param_1,5,*(undefined8 *)(pcVar4 + 0x2c8),0);
                uStack_378 = uStack_378 | 0x100;
                uVar23 = (ulonglong)uVar8;
              }
              else if (*(int *)(pcVar4 + 0x34) == 0x48545450) {
                piStack_798 = (int *)(pcVar4 + 0x2b8);
                uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
                uVar8 = FUN_1410773d0(param_1,0,*(undefined8 *)(pcVar4 + 0x2c8),0);
                uStack_378 = uStack_378 | 0x100;
                uVar23 = (ulonglong)uVar8;
              }
              else {
                uVar21 = (longlong)(int)uVar8 + *(longlong *)(param_1 + 0x1e00170);
                *(ulonglong *)(param_1 + 0x1e00170) = uVar21;
                if ((uVar21 < *(ulonglong *)(param_1 + 0x1e00178)) ||
                   (*(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180) <=
                    uVar21)) {
                  *(undefined8 *)(param_1 + 0x1e00180) = 0;
                }
                uStack_378 = uStack_378 | 0x100;
              }
              goto code_r0x00014107e3e3;
            case 0xc:
              piStack_798 = (int *)(uVar13 + 0xc4);
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x208);
              uStack_378 = uStack_378 | 0x200000;
              break;
            case 0xd:
              piStack_798 = (int *)(pcVar4 + 0x2b8);
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uVar8 = FUN_1410773d0(param_1,1,*(undefined8 *)(pcVar4 + 0x2c8),0);
              break;
            case 0xe:
              piStack_798 = (int *)(uVar13 + 0xc0);
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x250);
              uStack_378 = uStack_378 | 0x100000000;
              break;
            case 0xf:
              if ((*(byte *)(uVar13 + 0x9b) & 8) == 0) {
                if (((*(char *)(uVar13 + 0x9d) < '\0') && (*(longlong *)(uVar13 + 0x10) != 0)) &&
                   ((*(byte *)(uVar13 + 0x9a) & 1) != 0)) {
                  uVar10 = *(uint *)(*(longlong *)(uVar13 + 0x68) + 0x10);
                  if (uVar10 == 0) {
                    if (*(int *)(uVar13 + 0xac) == 0) {
                      iVar11 = FUN_140f91240(uVar13);
                      *(int *)(uVar13 + 0xac) = iVar11;
                      if (iVar11 != 0) {
                        FUN_140f94100(uVar13,0x3c);
                      }
                    }
                    uVar10 = *(uint *)(uVar13 + 0xac);
                  }
                  if ((uVar10 & 0x200004) != 0) goto code_r0x00014107de4b;
                }
              }
              else {
code_r0x00014107de4b:
                if (*(int *)(pcVar4 + 0x34) == 0x48545450) {
                  FUN_140f92f00(uVar13);
                  piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x48);
                  uStack_790 = uStack_790 & 0xffffffff00000000;
                  uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x4d8,0);
                  uStack_378 = uStack_378 | 0x20000000;
                  uVar23 = (ulonglong)uVar8;
                  goto code_r0x00014107e3e3;
                }
              }
              uVar21 = (longlong)(int)uVar8 + *(longlong *)(param_1 + 0x1e00170);
              *(ulonglong *)(param_1 + 0x1e00170) = uVar21;
              if ((uVar21 < *(ulonglong *)(param_1 + 0x1e00178)) ||
                 (*(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180) <= uVar21
                 )) {
                *(undefined8 *)(param_1 + 0x1e00180) = 0;
              }
              uStack_378 = uStack_378 | 0x20000000;
              goto code_r0x00014107e3e3;
            case 0x10:
              if ((*(byte *)(uVar13 + 0x9b) & 8) != 0) {
                FUN_140f92f00(uVar13);
                piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x44);
                uStack_790 = uStack_790 & 0xffffffff00000000;
                uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x4d8,0);
                break;
              }
              goto LAB_14107e4c7;
            case 0x11:
              if (*(int *)(pcVar4 + 0x34) == 0x48545450) {
                piStack_798 = (int *)(pcVar4 + 700);
                uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
                uVar8 = FUN_1410773d0(param_1,0,*(undefined8 *)(pcVar4 + 0x2c8),0);
                uStack_378 = uStack_378 | 0x100;
                break;
              }
LAB_14107e4c7:
              uVar22 = (longlong)(int)uVar8 + *(longlong *)(param_1 + 0x1e00170);
              *(ulonglong *)(param_1 + 0x1e00170) = uVar22;
              if ((uVar22 < *(ulonglong *)(param_1 + 0x1e00178)) ||
                 (uVar23 = uVar21,
                 *(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180) <= uVar22)
                 ) {
                *(undefined8 *)(param_1 + 0x1e00180) = 0;
                uVar23 = uVar21;
              }
              goto LAB_14107e4f7;
            case 0x12:
              FUN_140f92f00(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x34);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x520,auStack_350[2]);
              uStack_378 = uStack_378 | 0x2000000000000;
              break;
            case 0x13:
              FUN_140f92f00(uVar13);
              if (0xa00000 < uVar8) {
                return 0xffffff30;
              }
              uVar10 = FUN_1410770a0(param_1,param_1 + 0xa00128,uVar8);
              if (uVar10 != 0) {
                return (ulonglong)uVar10;
              }
              uVar8 = FUN_140bfe1f0(lStack_780 + 0x568,param_1 + 0xa00128,uVar8,
                                    *(longlong *)(uVar13 + 0x68) + 0x20);
              if (uVar8 != 0) {
                return (ulonglong)uVar8;
              }
              uStack_370 = uStack_370 | 0x10000;
              uVar23 = 0;
              goto LAB_14107e4f7;
            case 0x14:
              FUN_140f92f00(uVar13);
              piStack_798 = &iStack_6c8;
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,0,lStack_780 + 0x5b0,auStack_350[2]);
              break;
            case 0x15:
              piStack_760 = (int *)0x0;
              FUN_140f92f00(uVar13);
              if (uVar8 < 0xa00001) {
                uVar22 = param_1 + 0xa00128;
              }
              else {
                uVar22 = _aligned_malloc(uVar8,0x10);
                uVar21 = uVar22;
                if (uVar22 == 0) goto LAB_14107e4f7;
              }
              uStack_768 = uVar22;
              uVar10 = FUN_1410770a0(param_1,uVar22,uVar8);
              if (uVar10 != 0) {
                return (ulonglong)uVar10;
              }
              iVar11 = FUN_140bdde70(uVar8,uStack_768,&piStack_760);
              if (uVar21 != 0) {
                _aligned_free(uVar21);
              }
              piVar19 = piStack_760;
              if (iVar11 == 0) {
                FUN_140fa9260(pcVar4,piStack_760);
                if ((piVar19 != (int *)0x0) && (*piVar19 == 0x63687064)) {
                  piVar1 = piVar19 + 1;
                  *piVar1 = *piVar1 + -1;
                  if (*piVar1 == 0) {
                    FUN_140bde1f0(*(undefined8 *)(piVar19 + 8));
                    FUN_140bf78c0(*(undefined8 *)(piVar19 + 6));
                    FUN_140bf78c0(*(undefined8 *)(piVar19 + 8));
                    if (*(longlong *)(piVar19 + 10) != 0) {
                      _aligned_free();
                    }
                    if (*(longlong *)(piVar19 + 0xc) != 0) {
                      _aligned_free();
                    }
                    if (*(longlong *)(piVar19 + 0xe) != 0) {
                      _aligned_free();
                    }
                    if (*(longlong *)(piVar19 + 0x16) != 0) {
                      CFRelease();
                    }
                    *piVar19 = 0;
                    _aligned_free(piVar19);
                  }
                }
                uStack_370 = uStack_370 | 0x80000000;
              }
              uVar23 = 0;
              goto LAB_14107e4f7;
            case 0x16:
              FUN_140f92f00(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x38);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x520,auStack_350[2]);
              uStack_370 = uStack_370 | 0x20000;
              break;
            case 0x18:
              FUN_140f92f70(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x70) + 0x28);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x640,auStack_350[2]);
              uStack_378 = uStack_378 | 0x200000000000000;
              break;
            case 0x19:
              FUN_140f92f70(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x70) + 0x2c);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x6d0,auStack_350[2]);
              uStack_370 = uStack_370 | 0x80;
              break;
            case 0x1b:
              piStack_798 = (int *)(uVar13 + 0xb8);
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x208);
              uStack_370 = uStack_370 | 1;
              break;
            case 0x1c:
              FUN_140f92f00(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x30);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x718,auStack_350[2]);
              uStack_370 = uStack_370 | 0x40000000;
              break;
            case 0x1d:
              FUN_140f92f70(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x70) + 0x24);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,2,lStack_780 + 0x760,auStack_350[2]);
              uStack_370 = uStack_370 | 0x80000;
              break;
            case 0x1e:
              lVar15 = *(longlong *)(uVar13 + 0x10);
              piStack_798 = (int *)(uVar13 + 0x160);
              uStack_758 = 0;
              lStack_738 = 0;
              uStack_70c = 0;
              uStack_6d8 = 0;
              lStack_728 = 0;
              lStack_720 = 0;
              pcStack_748 = FUN_140eb80a0;
              lStack_730 = uVar13 + 0x92;
              uStack_708 = 0x200000000000;
              uStack_700 = 0;
              iStack_710 = *piStack_798;
              uStack_6f8 = 0x8000000000000;
              uStack_6f0 = 0;
              uStack_754 = 2;
              lStack_718 = 0;
              uStack_750 = 0x4e;
              uStack_74c = 0x1e;
              uStack_6e8 = 1;
              uStack_6e0 = 0;
              if (lVar15 != 0) {
                lStack_738 = uVar13 + 0xa1;
                lStack_718 = lVar15 + 0x1768;
                lStack_728 = lVar15 + 0x178;
                lStack_720 = uVar13 + 0xb0;
              }
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uStack_740 = uVar13;
              uVar8 = FUN_1410773d0(param_1,1);
              uStack_370 = uStack_370 | 0x200;
              break;
            case 0x1f:
              lVar15 = *(longlong *)(uVar13 + 0x10);
              piStack_798 = (int *)(uVar13 + 0x164);
              lStack_738 = 0;
              lStack_728 = 0;
              lStack_720 = 0;
              uStack_70c = 0;
              uStack_6d8 = 0;
              uStack_708 = 0x400000000000;
              uStack_700 = 0;
              pcStack_748 = FUN_140eb80a0;
              lStack_730 = uVar13 + 0x93;
              uStack_6f8 = 0x10000000000000;
              uStack_6f0 = 0;
              iStack_710 = *piStack_798;
              uStack_6e8 = 8;
              uStack_6e0 = 0;
              lStack_718 = 0;
              uStack_758 = 1;
              uStack_754 = 3;
              uStack_750 = 0x4f;
              uStack_74c = 0x1f;
              if (lVar15 != 0) {
                lStack_738 = uVar13 + 0xa3;
                lStack_718 = lVar15 + 0x17b0;
                lStack_728 = lVar15 + 0x1c0;
                lStack_720 = uVar13 + 0xbc;
              }
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uStack_740 = uVar13;
              uVar8 = FUN_1410773d0(param_1,1);
              uStack_370 = uStack_370 | 0x100;
              break;
            case 0x20:
              lVar15 = *(longlong *)(uVar13 + 0x10);
              piStack_798 = (int *)(uVar13 + 0x168);
              lStack_738 = 0;
              uStack_70c = 0;
              uStack_6d8 = 0;
              uStack_758 = 2;
              pcStack_748 = FUN_140eb80a0;
              lStack_730 = uVar13 + 0x94;
              lStack_728 = 0;
              lStack_720 = 0;
              iStack_710 = *piStack_798;
              lStack_718 = 0;
              uStack_754 = 4;
              uStack_750 = 0x50;
              uStack_74c = 0x20;
              uStack_708 = 0x800000000000;
              uStack_700 = 0;
              uStack_6f8 = 0x20000000000000;
              uStack_6f0 = 0;
              uStack_6e8 = 4;
              uStack_6e0 = 0;
              if (lVar15 != 0) {
                lStack_738 = uVar13 + 0xa2;
                lStack_718 = lVar15 + 0x17f8;
                lStack_728 = lVar15 + 0x208;
                lStack_720 = uVar13 + 0xb4;
              }
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uStack_740 = uVar13;
              uVar8 = FUN_1410773d0(param_1,1);
              uStack_370 = uStack_370 | 0x800000;
              break;
            case 0x21:
              lVar15 = *(longlong *)(uVar13 + 0x10);
              piStack_798 = (int *)(uVar13 + 0x16c);
              uStack_758 = 3;
              lStack_738 = 0;
              uStack_70c = 0;
              uStack_6d8 = 0;
              pcStack_748 = FUN_140eb80a0;
              lStack_730 = uVar13 + 0x95;
              iStack_710 = *piStack_798;
              lStack_728 = 0;
              lStack_720 = 0;
              lStack_718 = 0;
              uStack_754 = 0x47;
              uStack_750 = 0x51;
              uStack_74c = 0x21;
              uStack_708 = 0x1000000000000;
              uStack_700 = 0;
              uStack_6f8 = 0x40000000000000;
              uStack_6f0 = 0;
              uStack_6e8 = 0x40000000;
              uStack_6e0 = 0;
              if (lVar15 != 0) {
                lStack_728 = lVar15 + 0x208;
                lStack_718 = lVar15 + 0x17f8;
                lStack_720 = uVar13 + 0xb8;
              }
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uStack_740 = uVar13;
              uVar8 = FUN_1410773d0(param_1,1);
              uStack_370 = uStack_370 | 0x400000;
              break;
            case 0x22:
              lVar15 = *(longlong *)(uVar13 + 0x10);
              piStack_798 = (int *)(uVar13 + 0x170);
              uStack_758 = 4;
              lStack_738 = 0;
              uStack_70c = 0;
              uStack_6d8 = 0;
              pcStack_748 = FUN_140eb80a0;
              lStack_730 = uVar13 + 0x96;
              iStack_710 = *piStack_798;
              lStack_728 = 0;
              lStack_720 = 0;
              lStack_718 = 0;
              uStack_754 = 0x12;
              uStack_750 = 0x52;
              uStack_74c = 0x22;
              uStack_708 = 0x2000000000000;
              uStack_700 = 0;
              uStack_6f8 = 0x80000000000000;
              uStack_6f0 = 0;
              uStack_6e8 = 0x200000;
              uStack_6e0 = 0;
              if (lVar15 != 0) {
                lStack_728 = lVar15 + 0x208;
                lStack_718 = lVar15 + 0x17f8;
                lStack_720 = uVar13 + 0xc4;
              }
              uStack_790 = (ulonglong)uStack_790._4_4_ << 0x20;
              uStack_740 = uVar13;
              uVar8 = FUN_1410773d0(param_1,1);
              uStack_370 = uStack_370 | 0x200000;
              break;
            case 0x23:
              func_0x000140eb8130(uVar13,5,&uStack_758);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              piStack_798 = (int *)(uVar13 + ((ulonglong)uStack_758 + 0x58) * 4);
              uVar8 = FUN_1410773d0(param_1,1,lStack_718,auStack_350[2]);
              uVar23 = (ulonglong)uVar8;
              if (((int)uStack_750 < 0x100) && (uStack_750 != 0)) {
                pbVar14 = (byte *)((longlong)&uStack_378 + (ulonglong)(uStack_750 >> 3));
                *pbVar14 = *pbVar14 | (byte)(0x80 >> ((byte)uStack_750 & 7));
              }
              goto code_r0x00014107e3e3;
            case 0x24:
              puVar2 = (undefined8 *)(param_1 + 0xa00128);
              if (puVar2 != (undefined8 *)0x0) {
                *puVar2 = 0;
                *(undefined8 *)(param_1 + 0xa00130) = 0;
                *(undefined8 *)(param_1 + 0xa00138) = 0;
                *(undefined8 *)(param_1 + 0xa00140) = 0;
                *(undefined8 *)(param_1 + 0xa00148) = 0;
                *(undefined8 *)(param_1 + 0xa00150) = 0;
                *(undefined8 *)(param_1 + 0xa00158) = 0;
                *(undefined8 *)(param_1 + 0xa00160) = 0;
                *(undefined8 *)(param_1 + 0xa00168) = 0;
                *(undefined8 *)(param_1 + 0xa00170) = 0;
                *(undefined4 *)(param_1 + 0xa00178) = 0;
              }
              if (uVar8 < 0xa00001) {
                uVar8 = FUN_1410770a0(param_1,puVar2,uVar8);
                uVar23 = (ulonglong)uVar8;
                if (uVar8 == 0) {
                  func_0x0001410690d0(param_1,puVar2);
                  uVar8 = FUN_141079810(puVar2,pcVar4);
                  break;
                }
              }
              else {
                uVar23 = 0xffffff30;
              }
              goto code_r0x00014107e3e3;
            case 0x25:
              FUN_140f92f00(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x24);
              uStack_790 = CONCAT44(uStack_790._4_4_,1);
              uVar8 = FUN_1410773d0(param_1,0,lStack_780 + 0x5b0,auStack_350[2]);
              uStack_370 = uStack_370 | 0x40000;
              break;
            case 0x2a:
              FUN_140f92f00(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x4c);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,0,lStack_780 + 0x1888,auStack_350[2]);
              uStack_370 = uStack_370 | 0x8000000000000;
              break;
            case 0x2b:
              FUN_140fa6150(pcVar4);
              piStack_798 = (int *)(*(longlong *)(pcVar4 + 0x10) + 0x68);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x7a8,auStack_350[2]);
              uStack_370 = uStack_370 | 0x1000000000000;
              break;
            case 0x2d:
              FUN_140fa6150(pcVar4);
              piStack_798 = (int *)(*(longlong *)(pcVar4 + 0x10) + 0x6c);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,2,lStack_780 + 0x7f0,auStack_350[2]);
              uStack_370 = uStack_370 | 0x1000000000000000;
              break;
            case 0x2e:
              FUN_140f92f00(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x40);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x880,auStack_350[2]);
              uStack_370 = uStack_370 | 0x800000000000000;
              break;
            case 0x30:
              FUN_140fa6150(pcVar4);
              uVar8 = FUN_141077ee0(param_1,uVar8,*(longlong *)(pcVar4 + 0x10) + 0x98);
              break;
            case 0x33:
              FUN_140f92f00(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x3c);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x520,auStack_350[2]);
              uStack_370 = uStack_370 | 0x100000000000000;
              break;
            case 0x34:
              FUN_140fa6150(pcVar4);
              piStack_798 = (int *)(*(longlong *)(pcVar4 + 0x10) + 0x70);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x838,auStack_350[2]);
              uStack_368 = uStack_368 | 0x80;
              break;
            case 0x36:
              lVar15 = FUN_140fa1a50(uVar13,0x140000001);
              if (lVar15 == 0) {
                uVar21 = (longlong)(int)uVar8 + *(longlong *)(param_1 + 0x1e00170);
                *(ulonglong *)(param_1 + 0x1e00170) = uVar21;
                if ((uVar21 < *(ulonglong *)(param_1 + 0x1e00178)) ||
                   (*(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180) <=
                    uVar21)) {
                  *(undefined8 *)(param_1 + 0x1e00180) = 0;
                }
                FUN_141079920(uVar13);
              }
              else {
                uVar8 = FUN_141077ff0(param_1,lVar15,uVar8);
                if (uVar8 != 0) {
                  return (ulonglong)uVar8;
                }
                FUN_141079920(uVar13);
                uVar23 = 0;
              }
              goto LAB_14107e4f7;
            case 0x38:
              if ((*(longlong *)(pcVar4 + 8) != 0) &&
                 (*(longlong *)(*(longlong *)(pcVar4 + 8) + 0x10) != 0)) {
                lVar15 = *(longlong *)(pcVar4 + 0x2d0);
                if (lVar15 == 0) {
                  lVar15 = CFDictionaryCreateMutable
                                     (_DAT_1420a6090,0,kCFTypeDictionaryKeyCallBacks_exref,
                                      kCFTypeDictionaryValueCallBacks_exref);
                  *(longlong *)(pcVar4 + 0x2d0) = lVar15;
                  uVar23 = uVar21;
                  if (lVar15 != 0) goto code_r0x00014107e4ad;
                }
                else {
code_r0x00014107e4ad:
                  uVar8 = FUN_141077ff0(param_1,lVar15,uVar8);
                  uVar23 = (ulonglong)uVar8;
                }
                if ((int)uVar23 != 0) {
                  return uVar23;
                }
              }
              goto LAB_14107e4f7;
            case 0x39:
              FUN_140f92f00(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x2c);
              uStack_790 = CONCAT44(uStack_790._4_4_,1);
              uVar8 = FUN_1410773d0(param_1,0,lStack_780 + 0x5f8,auStack_350[2]);
              break;
            case 0x3a:
              FUN_140f92f00(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x28);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,0,lStack_780 + 0x5b0,auStack_350[2]);
              uStack_370 = uStack_370 | 0x40000;
              break;
            case 0x3b:
              FUN_140fa6150(pcVar4);
              piStack_798 = (int *)(*(longlong *)(pcVar4 + 0x10) + 0x74);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x8c8,auStack_350[2]);
              uStack_368 = uStack_368 | 0x800000;
              break;
            case 0x3c:
              FUN_140fa6150(pcVar4);
              piStack_798 = (int *)(*(longlong *)(pcVar4 + 0x10) + 0x78);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x910,auStack_350[2]);
              uStack_368 = uStack_368 | 0x400000;
              break;
            case 0x3d:
              FUN_140fa6150(pcVar4);
              piStack_798 = (int *)(*(longlong *)(pcVar4 + 0x10) + 0x7c);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x8c8,auStack_350[2]);
              uStack_368 = uStack_368 | 0x80000;
              break;
            case 0x3e:
              FUN_140fa6150(pcVar4);
              piStack_798 = (int *)(*(longlong *)(pcVar4 + 0x10) + 0x80);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x910,auStack_350[2]);
              uStack_368 = uStack_368 | 0x40000;
              break;
            case 0x3f:
              FUN_140f92f00(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x18);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x298,auStack_350[2]);
              uStack_368 = uStack_368 | 0x1000000;
              break;
            case 0x40:
              FUN_140f92f00(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x68) + 0x1c);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x2e0,auStack_350[2]);
              uStack_368 = uStack_368 | 0x8000000000;
              break;
            case 0x41:
              FUN_140f92f70(uVar13);
              piStack_798 = (int *)(*(longlong *)(uVar13 + 0x70) + 0x30);
              uStack_790 = uStack_790 & 0xffffffff00000000;
              uVar8 = FUN_1410773d0(param_1,1,lStack_780 + 0x6d0,auStack_350[2]);
              uStack_368 = uStack_368 | 0x800000000000;
            }
            uVar23 = (ulonglong)uVar8;
code_r0x00014107e3e3:
            if ((int)uVar23 != 0) {
              return uVar23;
            }
LAB_14107e4f7:
            uStack_778 = uStack_778 + 1;
            lVar15 = lStack_780;
          } while (uStack_778 < (uint)aiStack_670[1]);
        }
        if (((*(char *)(param_1 + 0x1e002f2) != '\0') &&
            (((*(longlong *)(*(longlong *)(pcVar4 + 0x20) + 8) != 0 ||
              (*(char *)(uVar13 + 0x8a) != '\0')) && (*(longlong *)(uVar13 + 0x10) != 0)))) &&
           ((*(byte *)(uVar13 + 0x9a) & 1) != 0)) {
          iVar11 = *(int *)(*(longlong *)(uVar13 + 0x68) + 0x10);
          if (iVar11 == 0) {
            if (*(int *)(uVar13 + 0xac) == 0) {
              iVar11 = FUN_140f91240(uVar13);
              *(int *)(uVar13 + 0xac) = iVar11;
              if (iVar11 != 0) {
                FUN_140f94100(uVar13,0x3c);
              }
            }
            iVar11 = *(int *)(uVar13 + 0xac);
          }
          if (((iVar11 == 1) || (iVar11 == 0x10)) || ((iVar11 == 0x20 || (iVar11 == 0x10001)))) {
            FUN_140faa080(pcVar4,0,0,0);
            *(undefined1 *)(uVar13 + 0x8a) = 0;
          }
        }
        iVar11 = iStack_6c8;
        lVar12 = (longlong)iStack_6c8;
        if (iStack_6c8 != 0) {
          FUN_140f92f00(uVar13);
          if (*(int *)(*(longlong *)(uVar13 + 0x68) + 0x24) == 0) {
            uStack_370 = uStack_370 | 0x40000;
            *(int *)(*(longlong *)(uVar13 + 0x68) + 0x24) = iVar11;
          }
          else if ((((int *)(lVar15 + 0x5b0) != (int *)0x0) &&
                   (*(int *)(lVar15 + 0x5b0) == 0x73747263)) &&
                  ((*(int *)(lVar15 + 0x5ec) == 0 &&
                   ((0 < iVar11 && (iVar11 <= *(int *)(lVar15 + 0x5dc))))))) {
            if ((*(byte *)(lVar15 + 0x5b4) & 1) != 0) {
              piVar19 = (int *)(**(longlong **)(lVar15 + 0x5c8) + -4 + lVar12 * 4);
              *piVar19 = *piVar19 + -1;
              if (*piVar19 != 0) goto LAB_14107e623;
            }
            lVar5 = **(longlong **)(lVar15 + 0x5c0);
            *(int *)(lVar15 + 0x5f0) = *(int *)(lVar15 + 0x5f0) + *(int *)(lVar5 + -4 + lVar12 * 8);
            *(undefined4 *)(lVar5 + -8 + lVar12 * 8) = 0x80000001;
          }
        }
LAB_14107e623:
        FUN_140ed6940(uVar13,&uStack_378,6);
        uVar13 = uVar23;
      }
      else {
        uVar23 = (longlong)(int)(aiStack_670[0] - uStack_674) + *(longlong *)(param_1 + 0x1e00170);
        *(ulonglong *)(param_1 + 0x1e00170) = uVar23;
        if ((uVar23 < *(ulonglong *)(param_1 + 0x1e00178)) ||
           (*(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180) <= uVar23)) {
          *(undefined8 *)(param_1 + 0x1e00180) = 0;
        }
      }
      *(longlong *)(param_1 + 0x1e00190) = *(longlong *)(param_1 + 0x1e00190) + 1;
      FUN_141077340(param_1);
      uStack_6c4 = uStack_6c4 + 1;
    } while (uStack_6c4 < auStack_330[0]);
  }
  if (cStack_788 != '\0') {
    FUN_140eb8cd0(lVar15);
  }
  if ((int)uVar13 == 0) {
    if (iStack_770 == 0xd) {
      iStack_770 = 0xd;
      uVar23 = uStack_6b8;
      while (uVar21 = uVar23, uVar21 != 0) {
        uVar23 = 0;
        if (*(longlong *)(uVar21 + 0x10) != 0) {
          uVar23 = *(ulonglong *)(uVar21 + 0x18);
        }
        lVar15 = FUN_14042de70(param_1 + 0x1e00290,uVar21);
        if (((lVar15 != 0) && (*(ulonglong *)(lVar15 + 8) != 0)) &&
           (*(ulonglong *)(lVar15 + 8) != uVar21)) {
          FUN_140fa10a0(*(undefined8 *)(uVar21 + 0x58));
        }
      }
      return uVar13;
    }
    return uVar13;
  }
  return uVar13;
}

