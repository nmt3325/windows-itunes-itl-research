/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xec8180; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_140ec8180(uint *param_1,longlong param_2,ulonglong param_3,undefined8 *param_4,
                  uint *param_5)

{
  ushort uVar1;
  int iVar2;
  longlong lVar3;
  char cVar4;
  char cVar5;
  ushort uVar6;
  uint uVar7;
  ulonglong uVar8;
  longlong lVar9;
  uint *puVar10;
  byte bVar11;
  uint uVar12;
  uint uVar13;
  uint uVar14;
  uint uVar15;
  byte bVar16;
  byte bVar17;
  byte bVar18;
  float fVar19;
  undefined1 auStack_2e8 [32];
  undefined4 uStack_2c8;
  uint uStack_2b8;
  undefined4 uStack_2b4;
  uint uStack_2b0;
  uint uStack_2ac;
  byte bStack_2a8;
  byte bStack_2a7;
  byte bStack_2a6;
  byte bStack_2a5;
  byte bStack_2a4;
  undefined1 uStack_2a3;
  byte bStack_2a2;
  undefined1 uStack_2a1;
  byte bStack_2a0;
  byte bStack_29f;
  undefined6 uStack_29e;
  undefined8 uStack_298;
  undefined8 uStack_290;
  longlong lStack_288;
  longlong lStack_280;
  uint uStack_278;
  uint *puStack_270;
  undefined8 *puStack_268;
  undefined2 uStack_258;
  undefined1 auStack_256 [510];
  ulonglong uStack_58;
  
  uStack_58 = _DAT_141fd5040 ^ (ulonglong)auStack_2e8;
  uVar8 = param_3 >> 1 & 0x7fffffff;
  uVar8 = CONCAT71((int7)(uVar8 >> 8),~(byte)uVar8) & 0xffffffffffffff01;
  bVar17 = (byte)param_3 & 1;
  puStack_270 = param_5;
  uStack_2b4 = (undefined4)uVar8;
  if (param_2 == 0) {
    return;
  }
  if (param_1 == (uint *)0x0) {
    return;
  }
  lVar3 = *(longlong *)(param_2 + 8);
  if (lVar3 == 0) {
    return;
  }
  lVar9 = *(longlong *)(lVar3 + 0x10);
  if (lVar9 == 0) {
    return;
  }
  if (*(int *)(lVar9 + 0x80) != 0x74646174) {
    return;
  }
  uVar13 = 0;
  uVar14 = 0;
  bStack_2a8 = 0;
  bStack_2a7 = 0;
  bStack_2a6 = 0;
  bStack_2a5 = 0;
  bStack_2a4 = 0;
  uStack_2a3 = 0;
  bStack_2a2 = 0;
  uStack_2a1 = 0;
  bStack_2a0 = 0;
  bStack_29f = 0;
  uStack_29e = 0;
  uStack_298 = 0;
  uStack_290 = 0;
  lStack_288 = lVar9;
  lStack_280 = param_2;
  puStack_268 = param_4;
  if (*param_1 == 0) goto LAB_140ec8fa8;
  if ((((*param_1 & 1) == 0) || ((short)param_1[2] == 0)) || ((*(byte *)(lVar3 + 0x9a) & 0x20) != 0)
     ) {
LAB_140ec82e4:
    uVar14 = CONCAT13(bStack_2a5,CONCAT12(bStack_2a6,CONCAT11(bStack_2a7,bStack_2a8)));
  }
  else {
    if ((param_3 & 1) == 0) {
      uStack_258 = 0;
      if (*(longlong *)(lVar3 + 0x10) != 0) {
        FUN_140bff470(*(longlong *)(lVar3 + 0x10) + 0x178,*(undefined4 *)(lVar3 + 0xb0),&uStack_258)
        ;
      }
      uStack_2c8 = 0x20;
      cVar4 = FUN_140ae4f40((byte *)((longlong)param_1 + 10),(short)param_1[2],auStack_256,
                            uStack_258);
      if (cVar4 != '\0') goto LAB_140ec82e4;
    }
    FUN_140f91680(lVar3,param_1 + 2,0);
    uVar13 = 1;
    bStack_2a8 = bStack_2a8 | 0x20;
    uVar14 = (uint)bStack_2a8;
    *(byte *)(lVar3 + 0x9a) = *(byte *)(lVar3 + 0x9a) & 0xef;
  }
  cVar4 = (char)uVar8;
  uStack_2b0 = uVar14;
  if ((*param_1 & 4) != 0) {
    if ((param_3 & 1) == 0) {
      if (((short)param_1[0x102] != 0) || (cVar4 != '\0')) {
        uStack_258 = 0;
        if (*(longlong *)(lVar3 + 0x10) != 0) {
          FUN_140bff470(*(longlong *)(lVar3 + 0x10) + 0x208,*(undefined4 *)(lVar3 + 0xb4),
                        &uStack_258);
        }
        uStack_2c8 = 0x20;
        cVar5 = FUN_140ae4f40((byte *)((longlong)param_1 + 0x40a),(short)param_1[0x102],auStack_256,
                              uStack_258);
        if (cVar5 == '\0') goto LAB_140ec835e;
      }
    }
    else {
LAB_140ec835e:
      FUN_140f91830(lVar3,param_1 + 0x102,0);
      uVar13 = uVar13 | 4;
      uStack_2b0 = uVar14 | 8;
      bStack_2a8 = (byte)uStack_2b0;
    }
  }
  if ((*param_1 & 0x40000000) == 0) {
LAB_140ec8429:
    uStack_278 = (uint)CONCAT62(uStack_29e,CONCAT11(bStack_29f,bStack_2a0));
  }
  else {
    if ((param_3 & 1) == 0) {
      if (((short)param_1[0x516] != 0) || (cVar4 != '\0')) {
        uStack_258 = 0;
        if (*(longlong *)(lVar3 + 0x10) != 0) {
          FUN_140bff470(*(longlong *)(lVar3 + 0x10) + 0x208,*(undefined4 *)(lVar3 + 0xb8),
                        &uStack_258);
        }
        uStack_2c8 = 0x20;
        cVar5 = FUN_140ae4f40((byte *)((longlong)param_1 + 0x145a),(short)param_1[0x516],auStack_256
                              ,uStack_258);
        if (cVar5 == '\0') goto LAB_140ec83ff;
      }
      goto LAB_140ec8429;
    }
LAB_140ec83ff:
    FUN_140f919f0(lVar3,param_1 + 0x516,0);
    uVar13 = uVar13 | 0x40000000;
    bStack_2a0 = bStack_2a0 | 1;
    uStack_278 = (uint)bStack_2a0;
  }
  if ((*param_1 & 0x200000) == 0) {
LAB_140ec84d3:
    uStack_2ac = CONCAT13(uStack_2a3,CONCAT12(bStack_2a4,CONCAT11(bStack_2a5,bStack_2a6)));
  }
  else {
    if ((param_3 & 1) == 0) {
      if (((short)param_1[0x410] != 0) || (cVar4 != '\0')) {
        uStack_258 = 0;
        if (*(longlong *)(lVar3 + 0x10) != 0) {
          FUN_140bff470(*(longlong *)(lVar3 + 0x10) + 0x208,*(undefined4 *)(lVar3 + 0xc4),
                        &uStack_258);
        }
        uStack_2c8 = 0x20;
        cVar5 = FUN_140ae4f40((byte *)((longlong)param_1 + 0x1042),(short)param_1[0x410],auStack_256
                              ,uStack_258);
        if (cVar5 == '\0') goto LAB_140ec84ac;
      }
      goto LAB_140ec84d3;
    }
LAB_140ec84ac:
    FUN_140f921e0(lVar3,param_1 + 0x410,0);
    uVar13 = uVar13 | 0x200000;
    bStack_2a6 = bStack_2a6 | 0x20;
    uStack_2ac = (uint)bStack_2a6;
  }
  if ((*param_1 & 8) != 0) {
    if ((param_3 & 1) == 0) {
      if (((short)param_1[0x182] != 0) || (cVar4 != '\0')) {
        uStack_258 = 0;
        if (*(longlong *)(lVar3 + 0x10) != 0) {
          FUN_140bff470(*(longlong *)(lVar3 + 0x10) + 0x1c0,*(undefined4 *)(lVar3 + 0xbc),
                        &uStack_258);
        }
        uStack_2c8 = 0x20;
        cVar5 = FUN_140ae4f40((byte *)((longlong)param_1 + 0x60a),(short)param_1[0x182],auStack_256,
                              uStack_258);
        if (cVar5 == '\0') goto LAB_140ec8553;
      }
    }
    else {
LAB_140ec8553:
      FUN_140f91bb0(lVar3,param_1 + 0x182,0);
      uVar13 = uVar13 | 8;
      uStack_2b0 = uStack_2b0 | 0x10;
      bStack_2a8 = (byte)uStack_2b0;
    }
  }
  if ((*param_1 & 0x10000000) != 0) {
    if ((param_3 & 1) == 0) {
      if (((short)param_1[0x495] != 0) || (cVar4 != '\0')) {
        uStack_258 = 0;
        if (*(longlong *)(lVar3 + 0x10) != 0) {
          FUN_140bff470(*(longlong *)(lVar3 + 0x10) + 0x250,*(undefined4 *)(lVar3 + 0xc0),
                        &uStack_258);
        }
        uStack_2c8 = 0x20;
        cVar5 = FUN_140ae4f40((byte *)((longlong)param_1 + 0x1256),(short)param_1[0x495],auStack_256
                              ,uStack_258);
        if (cVar5 == '\0') goto LAB_140ec85ec;
      }
    }
    else {
LAB_140ec85ec:
      func_0x000140bfed40(lVar9 + 0x250,param_1 + 0x495,lVar3 + 0xc0);
      uVar13 = uVar13 | 0x10000000;
      bStack_2a4 = bStack_2a4 | 1;
    }
  }
  bVar11 = bStack_2a4;
  if ((*param_1 & 0x10) == 0) {
LAB_140ec86c1:
    uVar14 = (uint)(CONCAT14(bStack_2a4,
                             CONCAT13(bStack_2a5,
                                      CONCAT12(bStack_2a6,CONCAT11(bStack_2a7,bStack_2a8)))) >> 8);
  }
  else {
    if ((param_3 & 1) == 0) {
      if (((short)param_1[0x202] != 0) || (cVar4 != '\0')) {
        uStack_258 = 0;
        if (*(longlong *)(lVar3 + 0x10) != 0) {
          FUN_140bff470(*(longlong *)(lVar3 + 0x10) + 0x328,*(undefined4 *)(lVar3 + 200),&uStack_258
                       );
        }
        uStack_2c8 = 0x20;
        cVar5 = FUN_140ae4f40((byte *)((longlong)param_1 + 0x80a),(short)param_1[0x202],auStack_256,
                              uStack_258);
        if (cVar5 == '\0') goto LAB_140ec869b;
      }
      goto LAB_140ec86c1;
    }
LAB_140ec869b:
    FUN_140f9cf50(lVar3,param_1 + 0x202,0);
    uVar13 = uVar13 | 0x10;
    bStack_2a7 = bStack_2a7 | 0x80;
    uVar14 = (uint)bStack_2a7;
  }
  uStack_2b8 = uVar14;
  if (((*param_1 & 0x20) != 0) && (-1 < *(char *)(lVar3 + 0x9a))) {
    if ((param_3 & 1) == 0) {
      if (((short)param_1[0x282] != 0) || (cVar4 != '\0')) {
        uStack_258 = 0;
        if (*(longlong *)(lVar3 + 0x10) != 0) {
          FUN_140bff470(*(longlong *)(lVar3 + 0x10) + 0x370,*(undefined4 *)(lVar3 + 0xcc),
                        &uStack_258);
        }
        uStack_2c8 = 0x20;
        cVar5 = FUN_140ae4f40((byte *)((longlong)param_1 + 0xa0a),(short)param_1[0x282],auStack_256,
                              uStack_258);
        if (cVar5 == '\0') goto LAB_140ec8754;
      }
    }
    else {
LAB_140ec8754:
      func_0x000140bfed40(lStack_288 + 0x370,param_1 + 0x282,lVar3 + 0xcc);
      uVar13 = uVar13 | 0x20;
      uVar14 = uVar14 | 0x40;
      bStack_2a7 = (byte)uVar14;
      uStack_2b8 = uVar14;
    }
  }
  if ((*param_1 & 0x200) != 0) {
    if ((param_3 & 1) == 0) {
      if (((short)param_1[0x302] != 0) || (cVar4 != '\0')) {
        uStack_258 = 0;
        if (*(longlong *)(lVar3 + 0x10) != 0) {
          FUN_140bff470(*(longlong *)(lVar3 + 0x10) + 0x3b8,*(undefined4 *)(lVar3 + 0xd0),
                        &uStack_258);
        }
        uStack_2c8 = 0x20;
        cVar5 = FUN_140ae4f40((byte *)((longlong)param_1 + 0xc0a),(short)param_1[0x302],auStack_256,
                              uStack_258);
        if (cVar5 == '\0') goto LAB_140ec87f8;
      }
    }
    else {
LAB_140ec87f8:
      func_0x000140bfed40(lStack_288 + 0x3b8,param_1 + 0x302,lVar3 + 0xd0);
      uVar13 = uVar13 | 0x200;
      uStack_2ac = uStack_2ac | 0x40;
      bStack_2a6 = (byte)uStack_2ac;
    }
  }
  if ((*param_1 & 0x400) != 0) {
    if ((param_3 & 1) == 0) {
      if (((short)param_1[0x382] != 0) || (cVar4 != '\0')) {
        uStack_258 = 0;
        if (*(longlong *)(lVar3 + 0x10) != 0) {
          FUN_140bff470(*(longlong *)(lVar3 + 0x10) + 0x400,*(undefined4 *)(lVar3 + 0xd4),
                        &uStack_258);
        }
        uStack_2c8 = 0x20;
        cVar5 = FUN_140ae4f40((byte *)((longlong)param_1 + 0xe0a),(short)param_1[0x382],auStack_256,
                              uStack_258);
        if (cVar5 == '\0') goto LAB_140ec889d;
      }
    }
    else {
LAB_140ec889d:
      func_0x000140bfed40(lStack_288 + 0x400,param_1 + 0x382,lVar3 + 0xd4);
      uVar13 = uVar13 | 0x400;
      uVar14 = uVar14 | 2;
      bStack_2a7 = (byte)uVar14;
      uStack_2b8 = uVar14;
    }
  }
  if ((((*param_1 & 0x40) != 0) &&
      (((((param_3 & 1) != 0 || (cVar4 != '\0')) || (param_1[0x402] != 0)) || (param_1[0x403] != 0))
      )) && (((uVar15 = param_1[0x402], *(ushort *)(lVar3 + 0x10a) != uVar15 ||
              ((uint)*(ushort *)(lVar3 + 0x10c) != param_1[0x403])) || ((param_3 & 1) != 0)))) {
    *(short *)(lVar3 + 0x10a) = (short)uVar15;
    uVar7 = param_1[0x403];
    if (uVar7 < (uVar15 & 0xffff)) {
      uVar7 = 0;
    }
    uStack_2b8 = uVar14 | 0x10;
    *(short *)(lVar3 + 0x10c) = (short)uVar7;
    uVar13 = uVar13 | 0x40;
    bStack_2a7 = (byte)uStack_2b8;
    bStack_2a2 = bStack_2a2 | 8;
  }
  if ((((*param_1 & 0x800000) == 0) ||
      ((((param_3 & 1) == 0 && (cVar4 == '\0')) &&
       (((short)param_1[0x491] == 0 && (*(short *)((longlong)param_1 + 0x1246) == 0)))))) ||
     (((uVar1 = (ushort)param_1[0x491], *(ushort *)(lVar3 + 0x10e) == uVar1 &&
       (*(short *)(lVar3 + 0x110) == *(short *)((longlong)param_1 + 0x1246))) &&
      ((param_3 & 1) == 0)))) {
    uVar14 = CONCAT13(bStack_2a2,CONCAT12(uStack_2a3,CONCAT11(bStack_2a4,bStack_2a5)));
  }
  else {
    *(ushort *)(lVar3 + 0x10e) = uVar1;
    uVar6 = *(ushort *)((longlong)param_1 + 0x1246);
    if (uVar6 < uVar1) {
      uVar6 = 0;
    }
    uVar13 = uVar13 | 0x800000;
    *(ushort *)(lVar3 + 0x110) = uVar6;
    bStack_2a5 = bStack_2a5 | 0x80;
    bStack_2a2 = bStack_2a2 | 0x40;
    uVar14 = (uint)bStack_2a5;
  }
  bVar16 = bStack_2a2;
  lStack_288 = CONCAT44(lStack_288._4_4_,uVar14);
  if (((*param_1 & 0x80) != 0) &&
     (((((param_3 & 1) != 0 || (cVar4 != '\0')) || ((short)param_1[0x404] != 0)) &&
      ((*(short *)(lVar3 + 0xa6) != (short)param_1[0x404] || ((param_3 & 1) != 0)))))) {
    *(short *)(lVar3 + 0xa6) = (short)param_1[0x404];
    uVar13 = uVar13 | 0x80;
    uStack_2b0 = uStack_2b0 | 1;
    bStack_2a8 = (byte)uStack_2b0;
  }
  if ((((*param_1 & 0x8000000) != 0) &&
      ((((param_3 & 1) != 0 || (cVar4 != '\0')) || ((short)param_1[0x494] != 0)))) &&
     ((*(short *)(lVar3 + 300) != (short)param_1[0x494] || ((param_3 & 1) != 0)))) {
    uVar13 = uVar13 | 0x8000000;
    *(short *)(lVar3 + 300) = (short)param_1[0x494];
    bStack_2a4 = bVar11 | 0x10;
  }
  bVar11 = (byte)uStack_2ac;
  if ((((*param_1 & 0x2000000) != 0) &&
      ((((param_3 & 1) != 0 || (cVar4 != '\0')) || (param_1[0x492] != 0)))) &&
     ((*(uint *)(lVar3 + 0x114) != param_1[0x492] || ((param_3 & 1) != 0)))) {
    uVar13 = uVar13 | 0x2000000;
    bVar11 = bVar11 | 2;
    *(uint *)(lVar3 + 0x114) = param_1[0x492];
    bStack_2a6 = bVar11;
  }
  if (((*param_1 & 0x4000000) != 0) &&
     (((((param_3 & 1) != 0 || (cVar4 != '\0')) || (param_1[0x493] != 0)) &&
      ((*(uint *)(lVar3 + 0x11c) != param_1[0x493] || ((param_3 & 1) != 0)))))) {
    uVar13 = uVar13 | 0x4000000;
    *(uint *)(lVar3 + 0x11c) = param_1[0x493];
    bStack_2a6 = bVar11 | 1;
  }
  if (((*param_1 & 0x80000) != 0) &&
     (((((param_3 & 1) != 0 || (cVar4 != '\0')) || (param_1[0x408] != 0)) &&
      ((*(uint *)(lStack_280 + 0x54) != param_1[0x408] || ((param_3 & 1) != 0)))))) {
    uVar13 = uVar13 | 0x80000;
    uStack_2b8 = uStack_2b8 | 0x20;
    *(uint *)(lStack_280 + 0x54) = param_1[0x408];
    bStack_2a7 = (byte)uStack_2b8;
  }
  if ((((*param_1 & 0x100) != 0) &&
      ((((param_3 & 1) != 0 || (cVar4 != '\0')) || (*(short *)((longlong)param_1 + 0x1012) != 0))))
     && ((*(short *)(lVar3 + 0x102) != *(short *)((longlong)param_1 + 0x1012) ||
         ((param_3 & 1) != 0)))) {
    uVar13 = uVar13 | 0x100;
    bStack_29f = bStack_29f | 0x20;
    *(short *)(lVar3 + 0x102) = *(short *)((longlong)param_1 + 0x1012);
  }
  bVar11 = bStack_29f;
  if (((*param_1 & 0x800) != 0) &&
     (((((param_3 & 1) != 0 || ((byte)uStack_2b4 != bVar17)) || (param_1[0x405] != 0)) &&
      ((*(uint *)(lStack_280 + 0x5c) != param_1[0x405] || ((param_3 & 1) != 0)))))) {
    uVar13 = uVar13 | 0x800;
    *(uint *)(lStack_280 + 0x5c) = param_1[0x405];
    uStack_2b8 = uStack_2b8 | 4;
    bStack_2a7 = (byte)uStack_2b8;
  }
  if ((*param_1 & 0x1000) != 0) {
    uVar14 = 0;
    if (param_1[0x406] <= *(uint *)(lStack_280 + 0x5c)) {
      uVar14 = param_1[0x406];
    }
    if (((((param_3 & 1) != 0) || ((byte)uStack_2b4 != 0)) || (uVar14 != 0)) &&
       ((*(uint *)(*(longlong *)(lVar3 + 0x78) + 4) != uVar14 || ((param_3 & 1) != 0)))) {
      FUN_140f92fd0();
      bStack_2a2 = bVar16 | 0x20;
      uVar13 = uVar13 | 0x1000;
      *(uint *)(*(longlong *)(lVar3 + 0x78) + 4) = uVar14;
    }
  }
  bVar16 = bStack_2a2;
  if ((*param_1 & 0x2000) != 0) {
    uStack_2ac = 0;
    if (param_1[0x407] <= *(uint *)(lStack_280 + 0x5c)) {
      uStack_2ac = param_1[0x407];
    }
    if (((((param_3 & 1) != 0) || ((byte)uStack_2b4 != bVar17)) || (uStack_2ac != 0)) &&
       ((*(uint *)(*(longlong *)(lVar3 + 0x78) + 8) != uStack_2ac || ((param_3 & 1) != 0)))) {
      FUN_140f92fd0(lVar3);
      uVar13 = uVar13 | 0x2000;
      bStack_2a2 = bVar16 | 0x10;
      *(uint *)(*(longlong *)(lVar3 + 0x78) + 8) = uStack_2ac;
    }
  }
  bVar16 = (byte)uStack_2b8;
  if ((*param_1 & 0x4000) != 0) {
    uVar8 = *(ulonglong *)(param_1 + 0x596);
    if (uVar8 == 0) {
      uVar8 = (ulonglong)param_1[0x409];
    }
    if (((((param_3 & 1) != 0) || ((byte)uStack_2b4 != bVar17)) || (uVar8 != 0)) &&
       ((*(ulonglong *)(lStack_280 + 0x60) != uVar8 || ((param_3 & 1) != 0)))) {
      uVar13 = uVar13 | 0x4000;
      bVar16 = bVar16 | 8;
      *(ulonglong *)(lStack_280 + 0x60) = uVar8;
      bStack_2a7 = bVar16;
    }
  }
  uVar14 = uStack_2b0;
  if ((((*param_1 & 0x8000) != 0) &&
      ((((param_3 & 1) != 0 || ((byte)uStack_2b4 != 0)) || (param_1[0x40a] != 0)))) &&
     (((uint)*(ushort *)(lStack_280 + 0x4c) != param_1[0x40a] || ((param_3 & 1) != 0)))) {
    uVar13 = uVar13 | 0x8000;
    *(short *)(lStack_280 + 0x4c) = (short)param_1[0x40a];
    bStack_2a8 = (byte)(uStack_2b0 | 4);
    uVar14 = uStack_2b0 | 4;
  }
  if ((*param_1 & 0x10000) != 0) {
    fVar19 = (float)param_1[0x515];
    if (fVar19 == 0.0) {
      fVar19 = (float)param_1[0x40b] * 1.5258789e-05;
    }
    if (((((param_3 & 1) != 0) || ((byte)uStack_2b4 != 0)) || (fVar19 != 0.0)) &&
       ((*(float *)(lStack_280 + 0x48) != fVar19 || ((param_3 & 1) != 0)))) {
      uVar13 = uVar13 | 0x10000;
      *(float *)(lStack_280 + 0x48) = fVar19;
      bStack_2a8 = (byte)uVar14 | 2;
    }
  }
  bVar18 = (byte)uStack_2b4;
  uVar14 = uVar13;
  if ((*param_1 & 0x20000) != 0) {
    uVar15 = param_1[0x40f];
    uVar7 = func_0x000140fa9000(lStack_280);
    bVar18 = (byte)uStack_2b4;
    uVar12 = param_1[0x40e] & uVar15;
    if (((((param_3 & 1) != 0) || (bVar18 != 0)) || (uVar12 != 0)) &&
       (((uVar7 & uVar15) != uVar12 || ((param_3 & 1) != 0)))) {
      FUN_140fa90c0(lStack_280,param_1[0x40e],uVar15);
      bStack_29f = bVar11 | 0x10;
      uVar14 = uVar13 | 0x20000;
    }
  }
  if ((*param_1 & 0x40000) != 0) {
    iVar2 = *(int *)(lStack_280 + 0x34);
    if (iVar2 == 0x44574e4c) {
      lVar9 = FUN_140f07d10(lStack_280 + 0x78);
      if (lVar9 != 0) {
        puVar10 = (uint *)(lVar9 + 0x220);
        goto LAB_140ec8e6f;
      }
    }
    else if ((iVar2 == 0x46494c45) || (iVar2 == 0x4d46494c)) {
      puVar10 = (uint *)(lStack_280 + 0x29c);
LAB_140ec8e6f:
      if (((puVar10 != (uint *)0x0) && ((((param_3 & 1) != 0 || (bVar18 != 0)) || (*puVar10 != 0))))
         && ((*puVar10 != param_1[0x40c] || ((param_3 & 1) != 0)))) {
        uVar14 = uVar14 | 0x40000;
        *puVar10 = param_1[0x40c];
        bStack_2a7 = bVar16 | 1;
      }
    }
  }
  bVar11 = (byte)lStack_288;
  if ((*param_1 & 0x400000) != 0) {
    bVar16 = *(byte *)(lVar3 + 0x9b);
    if (((bVar16 >> 2 & 1) != (byte)param_1[0x490]) || ((param_3 & 1) != 0)) {
      uVar14 = uVar14 | 0x400000;
      bVar11 = bVar11 | 1;
      *(byte *)(lVar3 + 0x9b) = ((byte)param_1[0x490] << 2 ^ bVar16) & 4 ^ bVar16;
      bStack_2a5 = bVar11;
    }
  }
  if ((*param_1 & 0x20000000) != 0) {
    bVar16 = *(byte *)(lVar3 + 0x9c);
    if (((bVar16 & 1) != *(byte *)((longlong)param_1 + 0x1241)) || ((param_3 & 1) != 0)) {
      uVar14 = uVar14 | 0x20000000;
      *(byte *)(lVar3 + 0x9c) = (bVar16 ^ *(byte *)((longlong)param_1 + 0x1241)) & 1 ^ bVar16;
      bStack_2a0 = (byte)uStack_278 | 2;
    }
  }
  if ((*param_1 & 0x1000000) == 0) goto LAB_140ec8fa8;
  uVar13 = (uint)*(ushort *)((longlong)param_1 + 0x1242);
  if (100 < *(ushort *)((longlong)param_1 + 0x1242)) {
    uVar13 = 100;
  }
  if ((((param_3 & 1) == 0) && ((byte)uStack_2b4 == bVar17)) && (uVar13 == 0)) goto LAB_140ec8fa8;
  if ((*(longlong *)(lVar3 + 0x10) == 0) ||
     ((*(byte *)(*(longlong *)(lVar3 + 0x10) + 0x114) & 8) == 0)) {
    if ((*(byte *)(lVar3 + 0x105) != 0) || (*(char *)(lVar3 + 0x104) != '\0')) goto LAB_140ec8f78;
LAB_140ec8fcb:
    cVar4 = '\0';
  }
  else {
    if (0x1f < *(byte *)(lVar3 + 0x105)) goto LAB_140ec8fcb;
LAB_140ec8f78:
    cVar4 = *(char *)(lVar3 + 0x104);
  }
  if (((int)cVar4 != uVar13) || ((param_3 & 1) != 0)) {
    FUN_140eda070(lVar3,uVar13,0);
    uVar14 = uVar14 | 0x1000000;
    bStack_2a5 = bVar11 | 0x40;
  }
LAB_140ec8fa8:
  puVar10 = puStack_270;
  if (puStack_268 == (undefined8 *)0x0) {
    FUN_140ed6940(lVar3,&bStack_2a8,0);
  }
  else {
    *puStack_268 = CONCAT17(uStack_2a1,
                            CONCAT16(bStack_2a2,
                                     CONCAT15(uStack_2a3,
                                              CONCAT14(bStack_2a4,
                                                       CONCAT13(bStack_2a5,
                                                                CONCAT12(bStack_2a6,
                                                                         CONCAT11(bStack_2a7,
                                                                                  bStack_2a8)))))));
    puStack_268[1] = CONCAT62(uStack_29e,CONCAT11(bStack_29f,bStack_2a0));
    puStack_268[2] = 0;
    puStack_268[3] = 0;
  }
  if (puVar10 != (uint *)0x0) {
    *puVar10 = uVar14;
  }
  return;
}

