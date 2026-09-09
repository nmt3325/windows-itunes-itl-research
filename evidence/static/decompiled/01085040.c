/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1085040; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

int FUN_141085040(int *param_1,int *param_2)

{
  uint uVar1;
  longlong lVar2;
  int iVar3;
  undefined1 auStack_b8 [32];
  undefined8 uStack_98;
  longlong lStack_88;
  ulonglong uStack_80;
  char acStack_78 [80];
  ulonglong uStack_28;
  
  uStack_28 = _DAT_141fd5040 ^ (ulonglong)auStack_b8;
  lStack_88 = 0;
  if ((((param_1 == (int *)0x0) || (*(longlong *)(param_1 + 4) == 0)) ||
      ((*param_1 != 0x41464350 && (*param_1 != 0x57696e50)))) || (param_2 == (int *)0x0)) {
    return -0x32;
  }
  param_2[0] = 0;
  param_2[1] = 0;
  param_2[2] = 0;
  param_2[3] = 0;
  param_2[4] = 0;
  param_2[5] = 0;
  param_2[6] = 0;
  param_2[7] = 0;
  param_2[8] = 0;
  param_2[9] = 0;
  param_2[10] = 0;
  param_2[0xb] = 0;
  param_2[0xc] = 0;
  param_2[0xd] = 0;
  param_2[0xe] = 0;
  param_2[0xf] = 0;
  param_2[0x10] = 0;
  param_2[0x11] = 0;
  param_2[0x12] = 0;
  param_2[0x13] = 0;
  param_2[0x14] = 0;
  param_2[0x15] = 0;
  param_2[0x16] = 0;
  param_2[0x17] = 0;
  param_2[0x18] = 0;
  param_2[0x19] = 0;
  param_2[0x1a] = 0;
  param_2[0x1b] = 0;
  param_2[0x1c] = 0;
  param_2[0x1d] = 0;
  param_2[0x1e] = 0;
  param_2[0x1f] = 0;
  param_2[0x20] = 0;
  param_2[0x21] = 0;
  param_2[0x22] = 0;
  param_2[0x23] = 0;
  if ((*(longlong *)(param_1 + 4) == 0) || ((*param_1 != 0x41464350 && (*param_1 != 0x57696e50)))) {
    return -0x32;
  }
  iVar3 = (**(code **)(*(longlong *)(param_1 + 4) + 8))(param_1,acStack_78,0);
  if (iVar3 != 0) {
    return iVar3;
  }
  if (acStack_78[0] != '\0') {
    return -0x516;
  }
  iVar3 = FUN_140b19490(param_1,0x64617461,1,&lStack_88);
  lVar2 = lStack_88;
  if (iVar3 != 0) {
    return 0;
  }
  if (((lStack_88 != 0) && (*(int *)(lStack_88 + 0x20) == 0x66726566)) &&
     (*(code **)(lStack_88 + 0x268) != (code *)0x0)) {
    iVar3 = (**(code **)(lStack_88 + 0x268))(lStack_88,&uStack_80);
    if (iVar3 != 0) goto LAB_14108520b;
    if ((*(int *)(lVar2 + 0x20) == 0x66726566) && (*(code **)(lVar2 + 0x298) != (code *)0x0)) {
      uStack_98 = 0;
      iVar3 = (**(code **)(lVar2 + 0x298))(lVar2,param_2,0x90,0);
      if (iVar3 == 0) {
        itl_1068f90(param_2);
        if ((*param_2 == 0x6864666d) || (*param_2 == 0x6864676d)) {
          if (uStack_80 == (uint)param_2[2]) {
            uVar1 = param_2[1];
            if ((uVar1 < 0x90) && ((ulonglong)uVar1 + (longlong)param_2 != 0)) {
              func_0x00014179cca0((ulonglong)uVar1 + (longlong)param_2,0,0x90 - uVar1);
            }
          }
          else {
            iVar3 = -0xd0;
          }
        }
        else {
          iVar3 = -0xd0;
        }
      }
      goto LAB_14108520b;
    }
  }
  iVar3 = -0x32;
LAB_14108520b:
  if (((lVar2 != 0) && (*(int *)(lVar2 + 0x20) == 0x66726566)) &&
     (*(code **)(lVar2 + 0x260) != (code *)0x0)) {
    (**(code **)(lVar2 + 0x260))(lVar2);
    *(undefined4 *)(lVar2 + 0x20) = 0;
    _aligned_free(lVar2);
  }
  return iVar3;
}

