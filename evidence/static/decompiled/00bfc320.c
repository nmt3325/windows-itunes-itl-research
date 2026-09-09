/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xbfc320; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined8
FUN_140bfc320(longlong param_1,longlong param_2,uint param_3,longlong param_4,uint *param_5)

{
  ushort uVar1;
  ushort uVar2;
  ushort uVar3;
  ushort uVar4;
  ushort uVar5;
  ushort uVar6;
  ushort uVar7;
  byte bVar8;
  uint uVar16;
  uint uVar17;
  uint uVar18;
  undefined8 uVar19;
  ulonglong uVar20;
  longlong lVar21;
  char cVar22;
  uint uVar23;
  uint *puVar24;
  uint *puVar25;
  uint uVar26;
  ushort uVar27;
  undefined1 auStack_b8 [32];
  uint *puStack_98;
  undefined4 uStack_88;
  undefined4 uStack_84;
  undefined4 uStack_80;
  undefined4 uStack_7c;
  uint auStack_78 [4];
  ulonglong uStack_68;
  byte bVar9;
  byte bVar10;
  byte bVar11;
  byte bVar12;
  byte bVar13;
  byte bVar14;
  byte bVar15;
  
  uStack_68 = _DAT_141fd5040 ^ (ulonglong)auStack_b8;
  uVar23 = param_3 & 0xf;
  if ((*(int *)(param_1 + 0xc) == 2) && ((param_3 & 0xf) != 0)) {
    return 0x206e;
  }
  puStack_98 = param_5;
  uVar19 = FUN_140bfc1e0();
  if ((int)uVar19 != 0) {
    return uVar19;
  }
  if (*(int *)(param_1 + 0xc) == 1) {
    if (*param_5 == 0) goto LAB_140bfc3c0;
    lVar21 = (ulonglong)(*param_5 - 0x10) + param_4;
  }
  else {
    lVar21 = (ulonglong)(param_3 - 0x10) + param_2;
  }
  if ((lVar21 != 0) && (*(longlong *)(param_1 + 0x28) != 0)) {
    func_0x000141867875(*(longlong *)(param_1 + 0x28),lVar21,0x10);
  }
LAB_140bfc3c0:
  if ((param_3 & 0xf) != 0) {
    uVar18 = *param_5;
    param_2 = (ulonglong)uVar18 + param_2;
    if (param_2 != 0) {
      func_0x000141867875(auStack_78,param_2,uVar23);
    }
    uVar16 = 0x10 - uVar23;
    cVar22 = (char)uVar23;
    if (0xf < uVar16) {
      uVar1 = (ushort)uVar23;
      uVar26 = uVar23 + 8;
      bVar8 = ((param_3 & 0xf) != 0) * (uVar1 < 0x100) * cVar22 - (0xff < uVar1);
      uVar27 = (ushort)bVar8;
      bVar9 = ((param_3 & 0xf) != 0) * (uVar1 < 0x100) * cVar22 - (0xff < uVar1);
      bVar10 = ((param_3 & 0xf) != 0) * (uVar1 < 0x100) * cVar22 - (0xff < uVar1);
      bVar11 = ((param_3 & 0xf) != 0) * (uVar1 < 0x100) * cVar22 - (0xff < uVar1);
      bVar12 = ((param_3 & 0xf) != 0) * (uVar1 < 0x100) * cVar22 - (0xff < uVar1);
      bVar13 = ((param_3 & 0xf) != 0) * (uVar1 < 0x100) * cVar22 - (0xff < uVar1);
      bVar14 = ((param_3 & 0xf) != 0) * (uVar1 < 0x100) * cVar22 - (0xff < uVar1);
      bVar15 = ((param_3 & 0xf) != 0) * (uVar1 < 0x100) * cVar22 - (0xff < uVar1);
      uVar1 = (ushort)bVar9;
      uVar2 = (ushort)bVar10;
      uVar3 = (ushort)bVar11;
      uVar4 = (ushort)bVar12;
      uVar5 = (ushort)bVar13;
      uVar6 = (ushort)bVar14;
      uVar7 = (ushort)bVar15;
      uStack_88 = CONCAT13('\x10' - ((bVar11 != 0) * (uVar3 < 0x100) * bVar11 - (0xff < uVar3)),
                           CONCAT12('\x10' - ((bVar10 != 0) * (uVar2 < 0x100) * bVar10 -
                                             (0xff < uVar2)),
                                    CONCAT11('\x10' - ((bVar9 != 0) * (uVar1 < 0x100) * bVar9 -
                                                      (0xff < uVar1)),
                                             '\x10' - ((bVar8 != 0) * (uVar27 < 0x100) * bVar8 -
                                                      (0xff < uVar27)))));
      uStack_84 = CONCAT13('\x10' - ((bVar15 != 0) * (uVar7 < 0x100) * bVar15 - (0xff < uVar7)),
                           CONCAT12('\x10' - ((bVar14 != 0) * (uVar6 < 0x100) * bVar14 -
                                             (0xff < uVar6)),
                                    CONCAT11('\x10' - ((bVar13 != 0) * (uVar5 < 0x100) * bVar13 -
                                                      (0xff < uVar5)),
                                             '\x10' - ((bVar12 != 0) * (uVar4 < 0x100) * bVar12 -
                                                      (0xff < uVar4)))));
      uStack_80 = CONCAT13('\x10' - ((bVar11 != 0) * (uVar3 < 0x100) * bVar11 - (0xff < uVar3)),
                           CONCAT12('\x10' - ((bVar10 != 0) * (uVar2 < 0x100) * bVar10 -
                                             (0xff < uVar2)),
                                    CONCAT11('\x10' - ((bVar9 != 0) * (uVar1 < 0x100) * bVar9 -
                                                      (0xff < uVar1)),
                                             '\x10' - ((bVar8 != 0) * (uVar27 < 0x100) * bVar8 -
                                                      (0xff < uVar27)))));
      uStack_7c = CONCAT13('\x10' - ((bVar15 != 0) * (uVar7 < 0x100) * bVar15 - (0xff < uVar7)),
                           CONCAT12('\x10' - ((bVar14 != 0) * (uVar6 < 0x100) * bVar14 -
                                             (0xff < uVar6)),
                                    CONCAT11('\x10' - ((bVar13 != 0) * (uVar5 < 0x100) * bVar13 -
                                                      (0xff < uVar5)),
                                             '\x10' - ((bVar12 != 0) * (uVar4 < 0x100) * bVar12 -
                                                      (0xff < uVar4)))));
      do {
        uVar20 = (ulonglong)uVar23;
        uVar23 = uVar23 + 0x10;
        *(uint *)((longlong)auStack_78 + uVar20) = uStack_88;
        *(uint *)((longlong)auStack_78 + (ulonglong)(uVar26 - 4)) = uStack_88;
        uVar17 = uVar26 + 4;
        *(uint *)((longlong)auStack_78 + (ulonglong)uVar26) = uStack_88;
        uVar26 = uVar26 + 0x10;
        *(uint *)((longlong)auStack_78 + (ulonglong)uVar17) = uStack_88;
      } while (uVar23 < 0x10 - (uVar16 & 0xf));
    }
    if (uVar23 < 0x10) {
      func_0x00014179cca0((longlong)auStack_78 + (ulonglong)uVar23,'\x10' - cVar22,0x10 - uVar23);
    }
    lVar21 = (ulonglong)uVar18 + param_4;
    puVar24 = *(uint **)(param_1 + 0x28);
    uVar23 = 0;
    do {
      uVar20 = (ulonglong)uVar23;
      puVar25 = (uint *)((longlong)auStack_78 + uVar20);
      if (*(int *)(param_1 + 0xc) == 1) {
        uStack_88 = *puVar25 ^ *puVar24;
        uStack_84 = *(uint *)((longlong)auStack_78 + uVar20 + 4) ^ puVar24[1];
        uStack_80 = *(uint *)((longlong)auStack_78 + uVar20 + 8) ^ puVar24[2];
        uStack_7c = *(uint *)((longlong)auStack_78 + uVar20 + 0xc) ^ puVar24[3];
        puVar25 = (uint *)(uVar20 + lVar21);
        FUN_140bfa2a0(&uStack_88,puVar25);
      }
      else {
        FUN_140bfb050(puVar25,&uStack_88,*(undefined8 *)(param_1 + 0x20));
        *(uint *)(uVar20 + lVar21) = uStack_88 ^ *puVar24;
        *(uint *)(uVar20 + 4 + lVar21) = uStack_84 ^ puVar24[1];
        *(uint *)(uVar20 + 8 + lVar21) = uStack_80 ^ puVar24[2];
        *(uint *)(uVar20 + 0xc + lVar21) = uStack_7c ^ puVar24[3];
      }
      uVar18 = uVar23 + 0x20;
      puVar24 = puVar25;
      uVar23 = uVar23 + 0x10;
    } while (uVar18 < 0x11);
    if (((ulonglong)*param_5 + param_4 != 0) && (*(longlong *)(param_1 + 0x28) != 0)) {
      func_0x000141867875(*(longlong *)(param_1 + 0x28),(ulonglong)*param_5 + param_4,0x10);
    }
    *param_5 = *param_5 + 0x10;
  }
  return 0;
}

