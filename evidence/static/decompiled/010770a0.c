/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x10770a0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

ulonglong FUN_1410770a0(longlong param_1,longlong param_2,ulonglong param_3)

{
  ulonglong *puVar1;
  longlong lVar2;
  ulonglong uVar3;
  bool bVar4;
  bool bVar5;
  ulonglong uVar6;
  longlong lVar7;
  ulonglong uVar8;
  ulonglong uVar9;
  ulonglong uVar10;
  uint auStackX_18 [4];
  
  uVar9 = 0;
  if (param_3 == 0) {
    return 0;
  }
  puVar1 = (ulonglong *)(param_1 + 0x1e00180);
  do {
    uVar6 = *puVar1;
    if (uVar6 == 0) {
LAB_141077146:
      uVar9 = *(ulonglong *)(param_1 + 0x1e00170);
      bVar4 = false;
      uVar6 = *(ulonglong *)(param_1 + 0x1e00160);
      uVar10 = 0xa00000;
      if (uVar9 < uVar6) {
        bVar5 = false;
        if (uVar6 < uVar9 + 0xa00000) {
LAB_14107719a:
          bVar4 = bVar5;
          uVar10 = uVar6 - uVar9;
        }
      }
      else {
        uVar3 = *(ulonglong *)(param_1 + 0x1e00168);
        if (uVar9 < uVar3) {
          bVar4 = true;
          uVar9 = (uVar9 - uVar6 & 0xfffffffffffffff0) + uVar6;
          uVar6 = uVar3;
          bVar5 = true;
          if (uVar3 < uVar9 + 0xa00000) goto LAB_14107719a;
        }
      }
      uVar6 = FUN_140ba09a0(*(undefined8 *)(param_1 + 0x120),uVar9);
      if ((int)uVar6 != 0) {
        return uVar6;
      }
      *(ulonglong *)(param_1 + 0x1e00178) = uVar9;
      lVar7 = param_1 + 0x1400128;
      *puVar1 = uVar10 & 0xffffffff;
      uVar6 = FUN_140ba0350(*(undefined8 *)(param_1 + 0x120),puVar1,lVar7);
      uVar9 = uVar6 & 0xffffffff;
      if ((int)uVar6 == -0x27) {
        if (*puVar1 < param_3) {
          return uVar6;
        }
        uVar9 = 0;
      }
      else if ((int)uVar6 != 0) {
        return uVar6;
      }
      lVar2 = param_1 + 0x128;
      if (bVar4) {
        auStackX_18[0] = *(uint *)puVar1;
        FUN_140bfc580(param_1 + 0x1e00128,lVar7,auStackX_18[0],lVar2,auStackX_18);
        *puVar1 = (ulonglong)auStackX_18[0];
      }
      else if ((lVar7 != 0) && (lVar2 != 0)) {
        func_0x000141867875(lVar2,lVar7,*puVar1);
      }
    }
    else {
      uVar10 = *(ulonglong *)(param_1 + 0x1e00178);
      uVar3 = *(ulonglong *)(param_1 + 0x1e00170);
      if ((uVar3 < uVar10) || (uVar6 + uVar10 <= uVar3)) goto LAB_141077146;
      uVar6 = (uVar6 - uVar3) + uVar10;
      uVar8 = param_3;
      if (uVar6 < param_3) {
        uVar8 = uVar6 & 0xffffffff;
      }
      lVar7 = param_1 + 0x128 + (uVar3 - uVar10);
      if ((lVar7 != 0) && (param_2 != 0)) {
        func_0x000141867875(param_2,lVar7,uVar8);
      }
      param_3 = param_3 - uVar8;
      param_2 = param_2 + uVar8;
      *(longlong *)(param_1 + 0x1e00170) = *(longlong *)(param_1 + 0x1e00170) + uVar8;
    }
    if (param_3 == 0) {
      return uVar9;
    }
  } while( true );
}

