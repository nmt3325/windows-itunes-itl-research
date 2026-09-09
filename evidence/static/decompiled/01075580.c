/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1075580; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

int FUN_141075580(longlong param_1,undefined8 param_2)

{
  int iVar1;
  int iVar2;
  longlong lVar3;
  longlong lVar4;
  ulonglong uStackX_8;
  longlong lStackX_18;
  ulonglong uStackX_20;
  longlong lStack_88;
  undefined8 uStack_80;
  longlong lStack_78;
  undefined8 uStack_70;
  undefined8 uStack_68;
  undefined8 uStack_60;
  undefined8 uStack_58;
  undefined8 uStack_50;
  undefined8 uStack_48;
  undefined8 uStack_40;
  undefined8 uStack_38;
  
  lStack_88 = 0;
  uStack_80 = 0;
  uStack_38 = 0;
  lStack_78 = 0;
  uStack_70 = 0;
  uStack_68 = 0;
  uStack_60 = 0;
  uStack_58 = 0;
  uStack_50 = 0;
  uStack_48 = 0;
  uStack_40 = 0;
  iVar1 = FUN_140bd67d0(*(undefined8 *)(param_1 + 8),&uStackX_8);
  if (((iVar1 == 0) && (*(char *)(param_1 + 5) == '\0')) &&
     (iVar1 = FUN_140bd6640(*(undefined8 *)(param_1 + 8),&uStackX_20), iVar1 == 0)) {
    if (*(char *)(param_1 + 5) == '\0') {
      iVar2 = *(int *)(param_1 + 0x20) - *(int *)(param_1 + 0x30);
    }
    else if (*(ulonglong *)(param_1 + 0x38) < *(ulonglong *)(param_1 + 0x20)) {
      iVar2 = 0;
    }
    else {
      iVar2 = ((int)*(ulonglong *)(param_1 + 0x38) - (int)*(ulonglong *)(param_1 + 0x20)) + 1;
    }
    if (uStackX_8 < (longlong)iVar2 + uStackX_20) {
      uStackX_8 = (longlong)iVar2 + uStackX_20;
    }
  }
  lStackX_18 = 0;
  if (*(char *)(param_1 + 5) == '\0') {
    iVar2 = FUN_140bd6640(*(undefined8 *)(param_1 + 8),&lStackX_18);
    if (iVar2 != 0) goto LAB_14107565a;
  }
  else {
    lStackX_18 = *(longlong *)(param_1 + 0x40);
  }
  if (*(char *)(param_1 + 5) == '\0') {
    lVar3 = *(longlong *)(param_1 + 0x20) - *(longlong *)(param_1 + 0x30);
  }
  else {
    lVar3 = (*(longlong *)(param_1 + 0x20) - *(longlong *)(param_1 + 0x38)) + -1;
  }
  lStackX_18 = lStackX_18 + lVar3;
LAB_14107565a:
  if (iVar1 == 0) {
    uStackX_8 = uStackX_8 - lStackX_18;
    lVar3 = _aligned_malloc(0x100000,0x10);
    if (lVar3 == 0) {
      iVar1 = -0x6c;
    }
    else {
      lVar4 = _aligned_malloc(0x200000,0x10);
      if (lVar4 == 0) {
        iVar1 = -0x6c;
        lVar4 = lVar3;
      }
      else {
        iVar1 = deflateInit_(&lStack_88,1,&UNK_141ac7f4c,0x58);
        if (iVar1 == 0) {
          while (uStackX_8 != 0) {
            uStackX_20 = 0x100000;
            if (uStackX_8 < 0x100000) {
              uStackX_20 = uStackX_8;
            }
            iVar1 = FUN_140ba0350(param_1,&uStackX_20,lVar3);
            if (iVar1 != 0) goto LAB_1410757d1;
            uStackX_8 = uStackX_8 - uStackX_20;
            uStack_80 = CONCAT44(uStack_80._4_4_,(int)uStackX_20);
            lStack_88 = lVar3;
            do {
              uStack_70 = CONCAT44(uStack_70._4_4_,0x200000);
              lStack_78 = lVar4;
              deflate(&lStack_88,0);
              uStackX_20 = (ulonglong)(0x200000 - (int)uStack_70);
              iVar1 = FUN_140ba04c0(param_2,&uStackX_20,lVar4);
              if (iVar1 != 0) goto LAB_1410757d1;
            } while ((int)uStack_80 != 0);
          }
          do {
            uStack_70 = CONCAT44(uStack_70._4_4_,0x200000);
            lStack_78 = lVar4;
            iVar2 = deflate(&lStack_88,4);
            uStackX_20 = (ulonglong)(0x200000 - (int)uStack_70);
            iVar1 = FUN_140ba04c0(param_2,&uStackX_20,lVar4);
            if (iVar1 != 0) break;
          } while (iVar2 == 0);
        }
        else {
          iVar1 = -0x32;
        }
LAB_1410757d1:
        _aligned_free(lVar3);
      }
      _aligned_free(lVar4);
    }
  }
  deflateEnd(&lStack_88);
  return iVar1;
}

