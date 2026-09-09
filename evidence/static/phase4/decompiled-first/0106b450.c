/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x106b450; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

ulonglong FUN_14106b450(longlong param_1,int param_2)

{
  uint uVar1;
  longlong lVar2;
  char cVar3;
  ulonglong in_RAX;
  ulonglong uVar4;
  bool bVar5;
  
  if ((((param_1 != 0) && (lVar2 = *(longlong *)(param_1 + 8), lVar2 != 0)) &&
      (*(longlong *)(lVar2 + 0x10) != 0)) && ((*(byte *)(lVar2 + 0x9a) & 8) == 0)) {
    if (param_2 == 1) {
      bVar5 = param_1 == *(longlong *)(lVar2 + 0x58);
    }
    else {
      if (param_2 != 0xd) goto LAB_14106b50e;
      bVar5 = param_1 != *(longlong *)(lVar2 + 0x58);
    }
    in_RAX = CONCAT71((int7)(in_RAX >> 8),bVar5);
    if (((bVar5 != false) && (*(longlong *)(lVar2 + 0x60) != 0)) &&
       ((*(int *)(param_1 + 0x34) != 0x53485244 ||
        ((cVar3 = FUN_140fa9b00(), cVar3 != '\0' ||
         (in_RAX = FUN_140fa9c50(param_1), (char)in_RAX == '\0')))))) {
      uVar4 = FUN_140fa0b70(lVar2,0);
      if ((uVar4 & 0x200004) == 0) {
        FUN_140fa9b00(param_1);
      }
      uVar1 = *(uint *)(param_1 + 0x34);
      in_RAX = (ulonglong)uVar1;
      if (uVar1 != 0x44574e4c) {
        return (ulonglong)CONCAT31((int3)(uVar1 >> 8),uVar1 != 0x4d425546);
      }
    }
  }
LAB_14106b50e:
  return in_RAX & 0xffffffffffffff00;
}

