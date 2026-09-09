/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x106b030; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

ulonglong FUN_14106b030(undefined8 param_1,int *param_2,int param_3,undefined4 param_4,
                       undefined4 param_5,undefined8 param_6,undefined1 *param_7)

{
  int *piVar1;
  ulonglong uVar2;
  int iVar3;
  uint uVar4;
  longlong lVar5;
  
  uVar4 = 0;
  *param_7 = 0;
  if (param_3 != 0) {
    iVar3 = 0;
    lVar5 = 0;
    if ((((param_2 == (int *)0x0) || (*param_2 != 0x73747263)) || (param_2[0xf] == 0)) ||
       ((param_3 < 1 || (param_2[0xb] < param_3)))) {
      uVar2 = 0xffffffce;
    }
    else {
      piVar1 = (int *)(**(longlong **)(param_2 + 4) + ((longlong)param_3 + -1) * 8);
      if (((piVar1 == (int *)0x0) || (*piVar1 < 0)) || (piVar1[1] < 1)) {
        uVar4 = 0xffffffce;
      }
      else {
        lVar5 = (longlong)*piVar1 + **(longlong **)(param_2 + 8);
        iVar3 = piVar1[1];
      }
      if ((uVar4 == 0) && (iVar3 != 0)) {
        uVar2 = FUN_14106ac80(param_1,lVar5,iVar3,param_3,param_4,param_5,param_6);
        *param_7 = 1;
      }
      else {
        uVar2 = (ulonglong)uVar4;
      }
    }
    return uVar2;
  }
  return 0;
}

