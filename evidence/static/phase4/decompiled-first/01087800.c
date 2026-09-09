/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1087800; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

undefined8
FUN_141087800(longlong *param_1,undefined4 param_2,undefined4 param_3,undefined4 param_4,
             undefined1 param_5,undefined8 param_6,undefined1 param_7,undefined8 param_8,
             longlong *param_9)

{
  longlong lVar1;
  longlong lVar2;
  undefined8 uVar3;
  
  lVar2 = FUN_140f690b0(2,param_1,param_6);
  if (lVar2 == 0) {
    uVar3 = 0xffffffce;
  }
  else {
    *param_9 = lVar2;
    *(undefined1 *)(lVar2 + 0x90) = param_7;
    *(undefined8 *)(lVar2 + 0x88) = param_8;
    FUN_140bffff0(lVar2 + 0xe8,param_1 + 0x38,param_2,0);
    *(undefined4 *)(lVar2 + 0x100) = param_3;
    *(undefined4 *)(lVar2 + 0x104) = param_4;
    *(undefined1 *)(lVar2 + 0x108) = param_5;
    if (((*(int *)(lVar2 + 8) == 0x616c6269) && (lVar1 = *(longlong *)(lVar2 + 0x30), lVar1 != 0))
       && (*(int *)(lVar1 + 0x80) == 0x74646174)) {
      *(undefined8 *)(lVar2 + 0x38) = 0;
      *(undefined8 *)(lVar2 + 0x40) = *(undefined8 *)(lVar1 + 0xe8);
      if (*(longlong *)(lVar1 + 0xe8) == 0) {
        *(longlong *)(lVar1 + 0xe0) = lVar2;
      }
      else {
        *(longlong *)(*(longlong *)(lVar1 + 0xe8) + 0x38) = lVar2;
      }
      *(int *)(lVar1 + 0xac) = *(int *)(lVar1 + 0xac) + 1;
      *(longlong *)(lVar1 + 0xe8) = lVar2;
    }
    (**(code **)(*param_1 + 8))(param_1,0x74646161,param_1,lVar2,0);
    uVar3 = 0;
  }
  return uVar3;
}

