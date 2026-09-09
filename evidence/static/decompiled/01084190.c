/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1084190; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

int FUN_141084190(longlong param_1,undefined8 param_2)

{
  longlong lVar1;
  bool bVar2;
  int iVar3;
  int iVar4;
  uint uVar5;
  longlong lVar6;
  longlong lVar7;
  ulonglong uVar8;
  ulonglong uVar9;
  ulonglong uStackX_20;
  ulonglong uStack_a8;
  longlong lStack_a0;
  longlong lStack_98;
  undefined8 uStack_90;
  longlong lStack_88;
  undefined8 uStack_80;
  undefined8 uStack_78;
  undefined8 uStack_70;
  undefined8 uStack_68;
  undefined8 uStack_60;
  undefined8 uStack_58;
  undefined8 uStack_50;
  undefined8 uStack_48;
  
  uStack_48 = 0;
  bVar2 = false;
  lStack_98 = 0;
  uStack_90 = 0;
  lStack_88 = 0;
  uStack_80 = 0;
  uStack_78 = 0;
  uStack_70 = 0;
  uStack_68 = 0;
  uStack_60 = 0;
  uStack_58 = 0;
  uStack_50 = 0;
  lVar6 = _aligned_malloc(0x100000,0x10);
  if (lVar6 == 0) {
    return -0x6c;
  }
  lVar7 = _aligned_malloc(0x200000,0x10);
  if (lVar7 == 0) {
    _aligned_free(lVar6);
    return -0x6c;
  }
  iVar3 = inflateInit_(&lStack_98,&UNK_141ac7f4c,0x58);
  if (iVar3 != 0) {
    iVar3 = -0x32;
    _aligned_free(lVar6);
    goto LAB_1410843b7;
  }
  lVar1 = *(longlong *)(param_1 + 0x120);
  iVar3 = FUN_140bd67d0(*(undefined8 *)(lVar1 + 8),&uStackX_20);
  if (((iVar3 == 0) && (*(char *)(lVar1 + 5) == '\0')) &&
     (iVar3 = FUN_140bd6640(*(undefined8 *)(lVar1 + 8),&uStack_a8), iVar3 == 0)) {
    if (*(char *)(lVar1 + 5) == '\0') {
      iVar4 = *(int *)(lVar1 + 0x20) - *(int *)(lVar1 + 0x30);
    }
    else if (*(ulonglong *)(lVar1 + 0x38) < *(ulonglong *)(lVar1 + 0x20)) {
      iVar4 = 0;
    }
    else {
      iVar4 = ((int)*(ulonglong *)(lVar1 + 0x38) - (int)*(ulonglong *)(lVar1 + 0x20)) + 1;
    }
    uVar9 = (longlong)iVar4 + uStack_a8;
    if ((longlong)iVar4 + uStack_a8 <= uStackX_20) goto LAB_1410842d8;
LAB_1410842e0:
    uStackX_20 = uVar9;
    iVar3 = FUN_140b9ff80(*(undefined8 *)(param_1 + 0x120),&lStack_a0);
    if ((iVar3 == 0) && (uVar9 = uStackX_20 - lStack_a0, uVar9 != 0)) {
      while( true ) {
        uVar5 = 0x100000;
        if (uVar9 < 0x100000) {
          uVar5 = (uint)uVar9;
        }
        uVar8 = (ulonglong)uVar5;
        if (0xa00000 < uVar8) break;
        iVar3 = FUN_1410770a0(param_1,lVar6,uVar8);
        if (iVar3 != 0) goto LAB_1410843a2;
        uVar9 = uVar9 - uVar8;
        uStack_90 = CONCAT44(uStack_90._4_4_,uVar5);
        lStack_98 = lVar6;
        do {
          uStack_80 = CONCAT44(uStack_80._4_4_,0x200000);
          lStack_88 = lVar7;
          uVar5 = inflate(&lStack_98,0);
          if (1 < uVar5) goto LAB_14108439d;
          uStack_a8 = (ulonglong)(0x200000 - (int)uStack_80);
          iVar3 = FUN_140ba04c0(param_2,&uStack_a8,lVar7);
          if (iVar3 != 0) goto LAB_1410843a2;
        } while ((int)uStack_80 == 0);
        if (uVar9 == 0) goto LAB_1410843a2;
      }
LAB_14108439d:
      iVar3 = -0xd0;
    }
  }
  else {
LAB_1410842d8:
    uVar9 = uStackX_20;
    if (iVar3 == 0) goto LAB_1410842e0;
  }
LAB_1410843a2:
  _aligned_free(lVar6);
  bVar2 = true;
LAB_1410843b7:
  _aligned_free(lVar7);
  if (bVar2) {
    inflateEnd(&lStack_98);
  }
  return iVar3;
}

