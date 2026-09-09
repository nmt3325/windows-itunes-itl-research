/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x106aba0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

void FUN_14106aba0(longlong param_1,undefined8 param_2,undefined8 param_3,undefined8 param_4)

{
  int iVar1;
  longlong lVar2;
  longlong lStackX_8;
  undefined8 auStack_28 [2];
  
  lStackX_8 = 0;
  lVar2 = *(longlong *)(param_1 + 0x120);
  if (*(char *)(lVar2 + 5) == '\0') {
    iVar1 = FUN_140bd6640(*(undefined8 *)(lVar2 + 8),&lStackX_8);
    if (iVar1 != 0) {
      return;
    }
  }
  else {
    lStackX_8 = *(longlong *)(lVar2 + 0x40);
  }
  if (*(char *)(lVar2 + 5) == '\0') {
    lVar2 = *(longlong *)(lVar2 + 0x20) - *(longlong *)(lVar2 + 0x30);
  }
  else {
    lVar2 = (*(longlong *)(lVar2 + 0x20) - *(longlong *)(lVar2 + 0x38)) + -1;
  }
  lStackX_8 = lVar2 + lStackX_8;
  iVar1 = FUN_140ba09a0(*(longlong *)(param_1 + 0x120),param_2);
  if ((iVar1 == 0) &&
     (auStack_28[0] = param_4,
     iVar1 = FUN_140ba04c0(*(undefined8 *)(param_1 + 0x120),auStack_28,param_3), iVar1 == 0)) {
    FUN_140ba09a0(*(undefined8 *)(param_1 + 0x120),lStackX_8);
  }
  return;
}

