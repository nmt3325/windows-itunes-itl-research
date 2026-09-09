/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xbfc0d0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

int FUN_140bfc0d0(char *param_1,longlong param_2,undefined4 *param_3)

{
  int iVar1;
  undefined8 *puVar2;
  undefined8 uVar3;
  int iVar4;
  int iVar5;
  undefined4 auStackX_8 [2];
  
  if ((param_1 == (char *)0x0) || (*param_1 == '\0')) {
    return 0x206f;
  }
  iVar4 = 0;
  if (*(int *)(param_1 + 4) == 1) {
    if (param_3 != (undefined4 *)0x0) {
      *param_3 = 0;
    }
    puVar2 = *(undefined8 **)(param_1 + 0x20);
    uVar3 = 0x204;
  }
  else {
    if (*(int *)(param_1 + 4) != 2) goto LAB_140bfc1ab;
    iVar5 = iVar4;
    if (param_3 != (undefined4 *)0x0) {
      if (param_2 == 0) {
        *param_3 = 0;
        iVar5 = 0;
      }
      else {
        auStackX_8[0] = *param_3;
        if (*(int *)(param_1 + 0xc) == 1) {
          iVar1 = FUN_1417e9510(**(undefined8 **)(param_1 + 0x20),param_2,auStackX_8);
        }
        else {
          iVar1 = iVar4;
          if (*(int *)(param_1 + 0xc) == 2) {
            iVar1 = FUN_1417e91b0(**(undefined8 **)(param_1 + 0x20),param_2,auStackX_8);
          }
        }
        *param_3 = auStackX_8[0];
        iVar5 = 0x20a7;
        if (iVar1 == 1) {
          iVar5 = iVar4;
        }
      }
    }
    puVar2 = *(undefined8 **)(param_1 + 0x20);
    iVar4 = iVar5;
    if (puVar2 == (undefined8 *)0x0) goto LAB_140bfc1ab;
    FUN_1417e8b80(*puVar2);
    uVar3 = 8;
  }
  func_0x000140bc6a20(puVar2,uVar3);
LAB_140bfc1ab:
  param_1[0x20] = '\0';
  param_1[0x21] = '\0';
  param_1[0x22] = '\0';
  param_1[0x23] = '\0';
  param_1[0x24] = '\0';
  param_1[0x25] = '\0';
  param_1[0x26] = '\0';
  param_1[0x27] = '\0';
  *param_1 = '\0';
  return iVar4;
}

