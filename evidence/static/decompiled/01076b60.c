/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1076b60; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Removing unreachable block (ram,0x000141076d02) */
/* WARNING: Removing unreachable block (ram,0x000141076f43) */
/* WARNING: Removing unreachable block (ram,0x000141076de8) */
/* WARNING: Removing unreachable block (ram,0x000141076fe8) */
/* WARNING: Removing unreachable block (ram,0x00014107704d) */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

int FUN_141076b60(longlong param_1,longlong param_2,char param_3,undefined8 param_4,
                 undefined8 param_5,undefined8 param_6,undefined1 param_7,char param_8)

{
  undefined4 uVar1;
  undefined4 uVar2;
  undefined4 uVar3;
  undefined8 uVar4;
  undefined8 *puVar5;
  undefined8 *puVar6;
  int iVar7;
  undefined8 *puVar8;
  int iVar9;
  undefined8 *puVar10;
  longlong lVar11;
  ulonglong uVar12;
  longlong lVar13;
  int iVar14;
  bool bVar15;
  undefined1 auStack_578 [40];
  undefined8 uStack_550;
  undefined1 auStack_538 [56];
  undefined8 uStack_500;
  int iStack_4f8;
  undefined8 uStack_4f4;
  undefined8 uStack_4ec;
  undefined8 uStack_4e0;
  undefined8 uStack_4d8;
  undefined8 uStack_4d0;
  longlong lStack_4c8;
  undefined1 uStack_4c0;
  undefined1 uStack_4bf;
  undefined8 auStack_4b8 [68];
  undefined1 uStack_298;
  undefined1 auStack_290 [8];
  undefined4 uStack_288;
  undefined8 *puStack_280;
  undefined1 uStack_278;
  undefined8 uStack_268;
  undefined8 uStack_258;
  undefined4 uStack_250;
  undefined4 uStack_24c;
  undefined1 auStack_248 [65];
  undefined1 uStack_207;
  ulonglong uStack_48;
  
  uStack_48 = _DAT_141fd5040 ^ (ulonglong)auStack_578;
  if ((param_2 == 0) || (param_1 == 0)) {
    return -0x32;
  }
  func_0x00014179cca0(&iStack_4f8,0,0x2a0);
  lVar13 = 4;
  lVar11 = 4;
  uStack_4d8 = param_5;
  uStack_4d0 = param_6;
  uStack_4c0 = 0;
  uStack_4bf = param_7;
  puVar5 = (undefined8 *)(_DAT_1420a6f30 + 0x150e0);
  puVar6 = auStack_4b8;
  do {
    puVar10 = puVar6;
    puVar8 = puVar5;
    uVar4 = puVar8[1];
    *puVar10 = *puVar8;
    puVar10[1] = uVar4;
    uVar4 = puVar8[3];
    puVar10[2] = puVar8[2];
    puVar10[3] = uVar4;
    uVar4 = puVar8[5];
    puVar10[4] = puVar8[4];
    puVar10[5] = uVar4;
    uVar4 = puVar8[7];
    puVar10[6] = puVar8[6];
    puVar10[7] = uVar4;
    uVar4 = puVar8[9];
    puVar10[8] = puVar8[8];
    puVar10[9] = uVar4;
    uVar4 = puVar8[0xb];
    puVar10[10] = puVar8[10];
    puVar10[0xb] = uVar4;
    uVar4 = puVar8[0xd];
    puVar10[0xc] = puVar8[0xc];
    puVar10[0xd] = uVar4;
    uVar4 = puVar8[0xf];
    puVar10[0xe] = puVar8[0xe];
    puVar10[0xf] = uVar4;
    lVar11 = lVar11 + -1;
    puVar5 = puVar8 + 0x10;
    puVar6 = puVar10 + 0x10;
  } while (lVar11 != 0);
  uVar4 = puVar8[0x11];
  puVar10[0x10] = puVar8[0x10];
  puVar10[0x11] = uVar4;
  uVar1 = *(undefined4 *)((longlong)puVar8 + 0x94);
  uVar2 = *(undefined4 *)(puVar8 + 0x13);
  uVar3 = *(undefined4 *)((longlong)puVar8 + 0x9c);
  *(undefined4 *)(puVar10 + 0x12) = *(undefined4 *)(puVar8 + 0x12);
  *(undefined4 *)((longlong)puVar10 + 0x94) = uVar1;
  *(undefined4 *)(puVar10 + 0x13) = uVar2;
  *(undefined4 *)((longlong)puVar10 + 0x9c) = uVar3;
  uStack_298 = *(char *)(_DAT_1420a6f30 + 0x15300) != '\0';
  uStack_258 = 0x6c69754c49554842;
  uStack_250 = 0x75686766;
  uStack_24c = 0x33616c69;
  uStack_4e0 = param_4;
  lStack_4c8 = param_2;
  iVar7 = FUN_140bfbe20(auStack_290,1);
  if (iVar7 != 0) {
    return iVar7;
  }
  puStack_280 = &uStack_258;
  uStack_278 = 0x10;
  uStack_288 = 1;
  uStack_268 = 0;
  iVar7 = FUN_140bfbf10();
  if (iVar7 != 0) {
    FUN_140bfc0d0(auStack_290,0,0);
    return iVar7;
  }
  if ((_DAT_1420adc58 == 0) ||
     (uStack_4ec = (ulonglong)*(uint *)(_DAT_1420adc58 + 0x18) << 0x20,
     *(uint *)(_DAT_1420adc58 + 0x18) == 0)) {
    return -0x26a;
  }
  uStack_4f4 = 0x63636d70;
  if (param_8 == '\0') {
    uStack_500 = 0;
    uStack_550 = 0;
    iVar7 = FUN_140bcff50(auStack_538,FUN_141076780,&iStack_4f8,0);
    if (iVar7 != 0) goto LAB_141077026;
  }
  else {
    FUN_141076780(&iStack_4f8);
  }
  if ((int)uStack_4f4 == 0x63636d70) {
    while (uVar12 = uStack_4ec & 0xffffffff, (uStack_4ec & 1) == 0) {
      do {
        iVar7 = (int)uVar12;
        LOCK();
        bVar15 = iVar7 == (int)uStack_4ec;
        if (bVar15) {
          uStack_4ec = CONCAT44(uStack_4ec._4_4_,iVar7) | 2;
        }
        UNLOCK();
      } while ((!bVar15) && (uVar12 = uStack_4ec & 0xffffffff, (uStack_4ec & 1) == 0));
      if ((uVar12 & 1) != 0) break;
      *(undefined8 *)(_DAT_1420adc58 + 0x48) = 0xbff0000000000000;
      FUN_140b076d0(0);
      if ((uStack_4ec & 1) != 0) break;
      LOCK();
      uStack_4ec = uStack_4ec & 0xfffffffffffffffd;
      UNLOCK();
      FUN_140b07800(0);
    }
    puVar5 = (undefined8 *)(_DAT_1420a6f30 + 0x150e0);
    puVar6 = auStack_4b8;
    do {
      puVar10 = puVar6;
      puVar8 = puVar5;
      uVar4 = puVar10[1];
      *puVar8 = *puVar10;
      puVar8[1] = uVar4;
      uVar4 = puVar10[3];
      puVar8[2] = puVar10[2];
      puVar8[3] = uVar4;
      uVar4 = puVar10[5];
      puVar8[4] = puVar10[4];
      puVar8[5] = uVar4;
      uVar4 = puVar10[7];
      puVar8[6] = puVar10[6];
      puVar8[7] = uVar4;
      uVar4 = puVar10[9];
      puVar8[8] = puVar10[8];
      puVar8[9] = uVar4;
      uVar4 = puVar10[0xb];
      puVar8[10] = puVar10[10];
      puVar8[0xb] = uVar4;
      uVar4 = puVar10[0xd];
      puVar8[0xc] = puVar10[0xc];
      puVar8[0xd] = uVar4;
      uVar4 = puVar10[0xf];
      puVar8[0xe] = puVar10[0xe];
      puVar8[0xf] = uVar4;
      lVar13 = lVar13 + -1;
      puVar5 = puVar8 + 0x10;
      puVar6 = puVar10 + 0x10;
    } while (lVar13 != 0);
    uVar1 = *(undefined4 *)((longlong)puVar10 + 0x84);
    uVar2 = *(undefined4 *)(puVar10 + 0x11);
    uVar3 = *(undefined4 *)((longlong)puVar10 + 0x8c);
    *(undefined4 *)(puVar8 + 0x10) = *(undefined4 *)(puVar10 + 0x10);
    *(undefined4 *)((longlong)puVar8 + 0x84) = uVar1;
    *(undefined4 *)(puVar8 + 0x11) = uVar2;
    *(undefined4 *)((longlong)puVar8 + 0x8c) = uVar3;
    uVar1 = *(undefined4 *)((longlong)puVar10 + 0x94);
    uVar2 = *(undefined4 *)(puVar10 + 0x13);
    uVar3 = *(undefined4 *)((longlong)puVar10 + 0x9c);
    *(undefined4 *)(puVar8 + 0x12) = *(undefined4 *)(puVar10 + 0x12);
    *(undefined4 *)((longlong)puVar8 + 0x94) = uVar1;
    *(undefined4 *)(puVar8 + 0x13) = uVar2;
    *(undefined4 *)((longlong)puVar8 + 0x9c) = uVar3;
    *(undefined1 *)(_DAT_1420a6f30 + 0x15300) = uStack_298;
    FUN_140bfc0d0(auStack_290,0,0);
    if (param_3 == '\0') {
      FUN_141075f60(param_5,param_7,auStack_248);
      FUN_140b23650(param_4,auStack_248);
      iVar7 = iStack_4f8;
      goto LAB_141077026;
    }
    uStack_4c0 = 1;
    uStack_258 = 0x90;
    lStack_4c8 = param_2;
    iVar7 = FUN_140ba0350(param_2,&uStack_258,auStack_248);
    if (iVar7 == 0) {
      itl_1068f90(auStack_248);
      uStack_207 = 0;
      iVar7 = FUN_140ba09a0(param_2,0);
      if (iVar7 == 0) {
        itl_1068f90(auStack_248);
        iVar7 = FUN_140ba04c0(param_2,&uStack_258,auStack_248);
        if ((iVar7 == 0) && (iVar7 = FUN_140ba0000(param_2), iVar7 == 0)) {
          FUN_140ba09a0(param_2,0);
        }
      }
    }
    if ((int)uStack_4f4 == 0x63636d70) {
      iVar14 = 0;
      do {
        iVar7 = (int)uStack_4ec;
        LOCK();
        uStack_4ec = uStack_4ec & 0xffffffff00000000;
        UNLOCK();
      } while (iVar7 != 0);
      uStack_500 = 0;
      uStack_550 = 0;
      iVar7 = FUN_140bcff50(auStack_538,FUN_141076780,&iStack_4f8,0);
      if (iVar7 != 0) goto LAB_141077026;
      if ((int)uStack_4f4 == 0x63636d70) {
        while (uVar12 = uStack_4ec & 0xffffffff, iVar7 = iVar14, (uStack_4ec & 1) == 0) {
          do {
            iVar9 = (int)uVar12;
            LOCK();
            bVar15 = iVar9 == (int)uStack_4ec;
            if (bVar15) {
              uStack_4ec = CONCAT44(uStack_4ec._4_4_,iVar9) | 2;
            }
            UNLOCK();
          } while ((!bVar15) && (uVar12 = uStack_4ec & 0xffffffff, (uStack_4ec & 1) == 0));
          if ((uVar12 & 1) != 0) break;
          *(undefined8 *)(_DAT_1420adc58 + 0x48) = 0xbff0000000000000;
          FUN_140b076d0(0);
          if ((uStack_4ec & 1) != 0) break;
          LOCK();
          uStack_4ec = uStack_4ec & 0xfffffffffffffffd;
          UNLOCK();
          FUN_140b07800(0);
        }
        goto LAB_141077026;
      }
    }
  }
  iVar7 = -0x32;
LAB_141077026:
  uVar12 = uStack_4ec;
  if (((int)uStack_4f4 == 0x63636d70) && ((uStack_4ec & 1) == 0)) {
    uVar1 = uStack_4ec._4_4_;
    LOCK();
    uStack_4ec = uStack_4ec | 1;
    UNLOCK();
    if ((uVar12 & 2) != 0) {
      FUN_140b07d90(uVar1);
    }
  }
  return iVar7;
}

