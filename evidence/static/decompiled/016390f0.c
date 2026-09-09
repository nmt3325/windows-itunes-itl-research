/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x16390f0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

int FUN_1416390f0(longlong param_1,longlong param_2)

{
  undefined8 *puVar1;
  undefined8 uVar2;
  undefined8 uVar3;
  undefined8 uVar4;
  undefined8 uVar5;
  undefined8 uVar6;
  undefined8 uVar7;
  undefined8 uVar8;
  undefined8 uVar9;
  undefined8 uVar10;
  undefined8 uVar11;
  undefined8 uVar12;
  int iVar13;
  int iVar14;
  longlong *plVar15;
  longlong lVar16;
  longlong lVar17;
  longlong lVar18;
  int *piVar19;
  int *piVar20;
  undefined *puVar21;
  undefined *puVar22;
  undefined4 uVar23;
  int *piStackX_8;
  longlong lStack_118;
  longlong lStack_110;
  longlong lStack_108;
  longlong lStack_100;
  longlong lStack_f8;
  longlong lStack_f0;
  longlong lStack_e8;
  longlong lStack_e0;
  undefined1 auStack_d8 [176];
  
  lStack_118 = 0;
  lStack_110 = 0;
  *(undefined1 *)(param_1 + 0xf0) = 0;
  iVar13 = FUN_1416374e0(0,param_2,8);
  if ((iVar13 != 0) || (iVar13 = FUN_140b9fe10(auStack_d8,0), iVar13 != 0)) goto LAB_14163980e;
  plVar15 = (longlong *)FUN_140ef0a40(&lStack_108,param_2);
  if (plVar15 != &lStack_118) {
    if (lStack_118 != 0) {
      LOCK();
      piVar19 = (int *)(lStack_118 + 8);
      iVar13 = *piVar19;
      *piVar19 = *piVar19 + -1;
      UNLOCK();
      if (iVar13 == 1) {
        *(undefined4 *)(lStack_118 + 8) = 0xc4653600;
        func_0x00014179bdd8();
      }
    }
    if (lStack_110 != 0) {
      LOCK();
      piVar19 = (int *)(lStack_110 + 8);
      iVar13 = *piVar19;
      *piVar19 = *piVar19 + -1;
      UNLOCK();
      if (iVar13 == 1) {
        *(undefined4 *)(lStack_110 + 8) = 0xc4653600;
        func_0x00014179bdd8();
      }
    }
    lStack_118 = *plVar15;
    lStack_110 = plVar15[1];
    *plVar15 = 0;
    plVar15[1] = 0;
  }
  if (lStack_108 != 0) {
    LOCK();
    piVar19 = (int *)(lStack_108 + 8);
    iVar13 = *piVar19;
    *piVar19 = *piVar19 + -1;
    UNLOCK();
    if (iVar13 == 1) {
      *(undefined4 *)(lStack_108 + 8) = 0xc4653600;
      func_0x00014179bdd8();
    }
    lStack_108 = 0;
  }
  if (lStack_100 != 0) {
    LOCK();
    piVar19 = (int *)(lStack_100 + 8);
    iVar13 = *piVar19;
    *piVar19 = *piVar19 + -1;
    UNLOCK();
    if (iVar13 == 1) {
      *(undefined4 *)(lStack_100 + 8) = 0xc4653600;
      func_0x00014179bdd8();
    }
    lStack_100 = 0;
  }
  uVar3 = *(undefined8 *)(param_2 + 0x180);
  uVar4 = *(undefined8 *)(param_2 + 0x188);
  uVar5 = *(undefined8 *)(param_2 + 400);
  uVar6 = *(undefined8 *)(param_2 + 0x198);
  uVar7 = *(undefined8 *)(param_2 + 0x1a0);
  uVar8 = *(undefined8 *)(param_2 + 0x1a8);
  uVar9 = *(undefined8 *)(param_2 + 0x1b0);
  uVar10 = *(undefined8 *)(param_2 + 0x1b8);
  uVar11 = *(undefined8 *)(param_2 + 0x1c0);
  uVar12 = *(undefined8 *)(param_2 + 0x1c8);
  *(undefined8 *)(param_2 + 0x188) = 0;
  *(undefined8 *)(param_2 + 400) = 0;
  *(undefined1 *)(param_2 + 0x180) = 0;
  *(undefined1 *)(param_2 + 0x198) = 0;
  *(undefined4 *)(param_2 + 0x19c) = 0;
  *(undefined2 *)(param_2 + 0x182) = 0;
  if (_DAT_1420cfce0 == 0) {
LAB_1416392d2:
    lVar16 = _DAT_1420adbf8;
  }
  else {
    lVar16 = CFDictionaryGetValue(_DAT_1420cfce0,0xbf0003);
    if (lVar16 != 0) {
      lVar17 = CFGetTypeID(lVar16);
      lVar18 = CFStringGetTypeID();
      if (lVar17 != lVar18) goto LAB_1416392d2;
    }
    if (lVar16 == 0) goto LAB_1416392d2;
  }
  FUN_140ad62e0(&lStack_e8,lVar16);
  puVar22 = &UNK_1419b1348;
  if ((lStack_118 == 0) && ((lStack_110 == 0 || (FUN_140add540(&lStack_118), lStack_118 == 0)))) {
    puVar21 = &UNK_1419b1348;
  }
  else {
    puVar21 = (undefined *)(lStack_118 + 0xc);
  }
  lVar17 = lStack_e0;
  lVar16 = lStack_e8;
  lStack_108 = lStack_e8;
  lStack_100 = lStack_e0;
  if (lStack_e8 != 0) {
    LOCK();
    *(int *)(lStack_e8 + 8) = *(int *)(lStack_e8 + 8) + 1;
    UNLOCK();
  }
  if (lStack_e0 != 0) {
    LOCK();
    *(int *)(lStack_e0 + 8) = *(int *)(lStack_e0 + 8) + 1;
    UNLOCK();
  }
  FUN_140ada420(&lStack_f8,&lStack_108,puVar21);
  FUN_140ad6630(param_1 + 0x70,&lStack_f8);
  if (lStack_f8 != 0) {
    LOCK();
    piVar19 = (int *)(lStack_f8 + 8);
    iVar13 = *piVar19;
    *piVar19 = *piVar19 + -1;
    UNLOCK();
    if (iVar13 == 1) {
      *(undefined4 *)(lStack_f8 + 8) = 0xc4653600;
      func_0x00014179bdd8();
    }
    lStack_f8 = 0;
  }
  if (lStack_f0 != 0) {
    LOCK();
    piVar19 = (int *)(lStack_f0 + 8);
    iVar13 = *piVar19;
    *piVar19 = *piVar19 + -1;
    UNLOCK();
    if (iVar13 == 1) {
      *(undefined4 *)(lStack_f0 + 8) = 0xc4653600;
      func_0x00014179bdd8();
    }
    lStack_f0 = 0;
  }
  if (lVar16 != 0) {
    LOCK();
    piVar19 = (int *)(lVar16 + 8);
    iVar13 = *piVar19;
    *piVar19 = *piVar19 + -1;
    UNLOCK();
    if (iVar13 == 1) {
      *(undefined4 *)(lVar16 + 8) = 0xc4653600;
      func_0x00014179bdd8(lVar16);
    }
  }
  if (lVar17 != 0) {
    LOCK();
    piVar19 = (int *)(lVar17 + 8);
    iVar13 = *piVar19;
    *piVar19 = *piVar19 + -1;
    UNLOCK();
    if (iVar13 == 1) {
      *(undefined4 *)(lVar17 + 8) = 0xc4653600;
      func_0x00014179bdd8();
    }
  }
  if (_DAT_1420cfce0 == 0) {
LAB_141639434:
    lVar16 = _DAT_1420adbf8;
  }
  else {
    lVar16 = CFDictionaryGetValue(_DAT_1420cfce0,0xbf0004);
    if (lVar16 != 0) {
      lVar17 = CFGetTypeID(lVar16);
      lVar18 = CFStringGetTypeID();
      if (lVar17 != lVar18) goto LAB_141639434;
    }
    if (lVar16 == 0) goto LAB_141639434;
  }
  FUN_140ad62e0(&lStack_e8,lVar16);
  if ((lStack_118 != 0) || ((lStack_110 != 0 && (FUN_140add540(&lStack_118), lStack_118 != 0)))) {
    puVar22 = (undefined *)(lStack_118 + 0xc);
  }
  lVar17 = lStack_e0;
  lVar16 = lStack_e8;
  lStack_f8 = lStack_e8;
  lStack_f0 = lStack_e0;
  if (lStack_e8 != 0) {
    LOCK();
    *(int *)(lStack_e8 + 8) = *(int *)(lStack_e8 + 8) + 1;
    UNLOCK();
  }
  if (lStack_e0 != 0) {
    LOCK();
    *(int *)(lStack_e0 + 8) = *(int *)(lStack_e0 + 8) + 1;
    UNLOCK();
  }
  FUN_140ada420(&lStack_108,&lStack_f8,puVar22);
  FUN_140ad6630(param_1 + 0x98,&lStack_108);
  if (lStack_108 != 0) {
    LOCK();
    piVar19 = (int *)(lStack_108 + 8);
    iVar13 = *piVar19;
    *piVar19 = *piVar19 + -1;
    UNLOCK();
    if (iVar13 == 1) {
      *(undefined4 *)(lStack_108 + 8) = 0xc4653600;
      func_0x00014179bdd8();
    }
    lStack_108 = 0;
  }
  if (lStack_100 != 0) {
    LOCK();
    piVar19 = (int *)(lStack_100 + 8);
    iVar13 = *piVar19;
    *piVar19 = *piVar19 + -1;
    UNLOCK();
    if (iVar13 == 1) {
      *(undefined4 *)(lStack_100 + 8) = 0xc4653600;
      func_0x00014179bdd8();
    }
    lStack_100 = 0;
  }
  if (lVar16 != 0) {
    LOCK();
    piVar19 = (int *)(lVar16 + 8);
    iVar13 = *piVar19;
    *piVar19 = *piVar19 + -1;
    UNLOCK();
    if (iVar13 == 1) {
      *(undefined4 *)(lVar16 + 8) = 0xc4653600;
      func_0x00014179bdd8(lVar16);
    }
  }
  if (lVar17 != 0) {
    LOCK();
    piVar19 = (int *)(lVar17 + 8);
    iVar13 = *piVar19;
    *piVar19 = *piVar19 + -1;
    UNLOCK();
    if (iVar13 == 1) {
      *(undefined4 *)(lVar17 + 8) = 0xc4653600;
      func_0x00014179bdd8();
    }
  }
  uVar2 = *(undefined8 *)(param_2 + 8);
  lVar16 = _aligned_malloc(0x1e00308,0x10);
  if (lVar16 == 0) {
    *(undefined8 *)(param_2 + 0x180) = uVar3;
    *(undefined8 *)(param_2 + 0x188) = uVar4;
    *(undefined8 *)(param_2 + 400) = uVar5;
    *(undefined8 *)(param_2 + 0x198) = uVar6;
    *(undefined8 *)(param_2 + 0x1a0) = uVar7;
    *(undefined8 *)(param_2 + 0x1a8) = uVar8;
    *(undefined8 *)(param_2 + 0x1b0) = uVar9;
    *(undefined8 *)(param_2 + 0x1b8) = uVar10;
    *(undefined8 *)(param_2 + 0x1c0) = uVar11;
    *(undefined8 *)(param_2 + 0x1c8) = uVar12;
LAB_1416397fe:
    iVar13 = -0x6c;
  }
  else {
    func_0x00014179cca0(lVar16,0,0x120);
    func_0x00014179cca0(lVar16 + 0x128,0,0x1e00148);
    *(undefined8 *)(lVar16 + 0x1e00278) = 0;
    *(undefined8 *)(lVar16 + 0x1e00280) = 0;
    *(undefined8 *)(lVar16 + 0x1e00288) = 0;
    *(undefined8 *)(lVar16 + 0x1e00290) = 0;
    *(undefined8 *)(lVar16 + 0x1e00298) = 0;
    *(undefined8 *)(lVar16 + 0x1e002a0) = 0;
    *(undefined8 *)(lVar16 + 0x1e002a8) = 0;
    *(undefined8 *)(lVar16 + 0x1e002b0) = 0;
    *(undefined8 *)(lVar16 + 0x1e002b8) = 0;
    *(undefined8 *)(lVar16 + 0x1e002c0) = 0;
    *(undefined8 *)(lVar16 + 0x1e002c8) = 0;
    *(undefined8 *)(lVar16 + 0x1e002d0) = 0;
    *(undefined8 *)(lVar16 + 0x1e002d8) = 0;
    *(undefined8 *)(lVar16 + 0x1e002e0) = 0;
    *(undefined8 *)(lVar16 + 0x1e002e8) = 0;
    *(undefined8 *)(lVar16 + 0x1e002f0) = 0;
    *(undefined8 *)(lVar16 + 0x1e002f8) = 0;
    *(undefined8 *)(lVar16 + 0x1e00300) = 0;
    *(undefined8 *)(lVar16 + 0x1e00270) = uVar2;
    *(undefined1 **)(lVar16 + 0x120) = auStack_d8;
    FUN_14106a430(lVar16);
    iVar13 = FUN_1410725a0(lVar16,2,&UNK_1416390d0,param_2);
    uVar23 = _aligned_free(lVar16);
    *(undefined8 *)(param_2 + 0x180) = uVar3;
    *(undefined8 *)(param_2 + 0x188) = uVar4;
    *(undefined8 *)(param_2 + 400) = uVar5;
    *(undefined8 *)(param_2 + 0x198) = uVar6;
    *(undefined8 *)(param_2 + 0x1a0) = uVar7;
    *(undefined8 *)(param_2 + 0x1a8) = uVar8;
    *(undefined8 *)(param_2 + 0x1b0) = uVar9;
    *(undefined8 *)(param_2 + 0x1b8) = uVar10;
    *(undefined8 *)(param_2 + 0x1c0) = uVar11;
    *(undefined8 *)(param_2 + 0x1c8) = uVar12;
    if (iVar13 != 0) goto LAB_141639803;
    lVar16 = FUN_140ba1750(uVar23,auStack_d8);
    *(longlong *)(param_1 + 0xf8) = lVar16;
    if (lVar16 == 0) goto LAB_1416397fe;
    if ((*(byte *)(param_2 + 0x228) & 2) == 0) {
      iVar13 = FUN_1402dc9a0(param_2,&piStackX_8);
      piVar19 = piStackX_8;
      if (iVar13 == 0) {
        lStack_e8 = 0;
        lStack_e0 = 0;
        lVar16 = FUN_141639d60(param_2,4,piStackX_8,piStackX_8);
        if ((((piVar19 != (int *)0x0) && (*piVar19 == 0x4f4c5354)) && (piVar19[1] != 0)) &&
           (iVar14 = piVar19[1] + -1, piVar19[1] = iVar14, iVar14 == 0)) {
          FUN_1402de700(piVar19 + 2);
          func_0x000140bc6a20(piVar19,0x20);
        }
        if (lVar16 != 0) {
          puVar1 = (undefined8 *)(lVar16 + 8);
          if (((undefined8 *)(param_1 + 0x80) != (undefined8 *)0x0) && (puVar1 != (undefined8 *)0x0)
             ) {
            *puVar1 = 0;
            *(undefined8 *)(lVar16 + 0x10) = *(undefined8 *)(param_1 + 0x88);
            if (*(undefined8 **)(param_1 + 0x88) == (undefined8 *)0x0) {
              *(undefined8 *)(param_1 + 0x80) = puVar1;
            }
            else {
              **(undefined8 **)(param_1 + 0x88) = puVar1;
            }
            *(undefined8 **)(param_1 + 0x88) = puVar1;
          }
          goto LAB_141639721;
        }
        iVar13 = -0x32;
      }
    }
    else {
LAB_141639721:
      for (lVar16 = *(longlong *)(param_2 + 0x38); lVar16 != 0;
          lVar16 = *(longlong *)(lVar16 + 0x20)) {
        piVar19 = (int *)FUN_14179beec(0x100,&UNK_141912c00);
        piStackX_8 = piVar19;
        if (piVar19 == (int *)0x0) goto LAB_1416397fe;
        FUN_141637350(piVar19);
        *(undefined **)piVar19 = &UNK_141c423b8;
        piVar19[0x3e] = 0;
        piVar19[0x3f] = 0;
        iVar13 = FUN_1416390f0(piVar19,lVar16);
        if (iVar13 != 0) {
          (*(code *)**(undefined8 **)piVar19)(piVar19,1);
          break;
        }
        piVar20 = piVar19 + 2;
        if (((undefined8 *)(param_1 + 0x80) != (undefined8 *)0x0) && (piVar20 != (int *)0x0)) {
          piVar20[0] = 0;
          piVar20[1] = 0;
          *(undefined8 *)(piVar19 + 4) = *(undefined8 *)(param_1 + 0x88);
          if (*(undefined8 **)(param_1 + 0x88) == (undefined8 *)0x0) {
            *(undefined8 *)(param_1 + 0x80) = piVar20;
          }
          else {
            **(undefined8 **)(param_1 + 0x88) = piVar20;
          }
          *(int **)(param_1 + 0x88) = piVar20;
        }
      }
    }
  }
LAB_141639803:
  FUN_140ba02c0(auStack_d8);
LAB_14163980e:
  if (lStack_118 != 0) {
    LOCK();
    piVar19 = (int *)(lStack_118 + 8);
    iVar14 = *piVar19;
    *piVar19 = *piVar19 + -1;
    UNLOCK();
    if (iVar14 == 1) {
      *(undefined4 *)(lStack_118 + 8) = 0xc4653600;
      func_0x00014179bdd8();
    }
    lStack_118 = 0;
  }
  if (lStack_110 != 0) {
    LOCK();
    piVar19 = (int *)(lStack_110 + 8);
    iVar14 = *piVar19;
    *piVar19 = *piVar19 + -1;
    UNLOCK();
    if (iVar14 == 1) {
      *(undefined4 *)(lStack_110 + 8) = 0xc4653600;
      func_0x00014179bdd8();
    }
  }
  return iVar13;
}

