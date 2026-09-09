/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xbfbf10; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

undefined8 FUN_140bfbf10(undefined1 *param_1)

{
  int iVar1;
  undefined8 *puVar2;
  undefined8 uVar3;
  undefined8 *puVar4;
  longlong lVar5;
  char cVar6;
  undefined8 *puVar7;
  
  if (param_1 == (undefined1 *)0x0) {
    return 0x206d;
  }
  *param_1 = 0;
  if (((*(int *)(param_1 + 8) == 3) || (*(int *)(param_1 + 8) == 4)) &&
     (*(longlong *)(param_1 + 0x28) == 0)) {
    return 0x20a0;
  }
  iVar1 = *(int *)(param_1 + 4);
  if (iVar1 == 1) {
    cVar6 = '\x10';
  }
  else {
    if (iVar1 != 2) {
      return 0x20a2;
    }
    cVar6 = ' ';
  }
  if ((*(longlong *)(param_1 + 0x10) != 0) && (param_1[0x18] == cVar6)) {
    if (iVar1 == 1) {
      lVar5 = FUN_14179beec(0x204,&UNK_141912c00);
      if (lVar5 == 0) {
        lVar5 = 0;
      }
      else {
        func_0x00014179cca0(lVar5,0,0x204);
      }
      *(longlong *)(param_1 + 0x20) = lVar5;
      FUN_140bf9a90(*(undefined4 *)(param_1 + 0xc),*(undefined8 *)(param_1 + 0x10),0x80,lVar5);
    }
    else if (iVar1 == 2) {
      puVar2 = (undefined8 *)FUN_14179beec(8,&UNK_141912c00);
      puVar4 = (undefined8 *)0x0;
      puVar7 = puVar4;
      if (puVar2 != (undefined8 *)0x0) {
        uVar3 = func_0x0001417e8bc0();
        *puVar2 = uVar3;
        puVar7 = puVar2;
      }
      iVar1 = *(int *)(param_1 + 8);
      *(undefined8 **)(param_1 + 0x20) = puVar7;
      if (iVar1 == 1) {
        puVar4 = (undefined8 *)func_0x0001417eb1f0();
      }
      else {
        if ((iVar1 == 2) || (iVar1 == 3)) {
          return 0x2072;
        }
        if (iVar1 == 4) {
          puVar4 = (undefined8 *)func_0x0001417eb1a0();
        }
      }
      if (*(int *)(param_1 + 0xc) == 1) {
        iVar1 = FUN_1417e9640(**(undefined8 **)(param_1 + 0x20),puVar4,0,
                              *(undefined8 *)(param_1 + 0x10),*(undefined8 *)(param_1 + 0x28));
      }
      else {
        if (*(int *)(param_1 + 0xc) != 2) {
          return 0x20a4;
        }
        iVar1 = FUN_1417e9360(**(undefined8 **)(param_1 + 0x20),puVar4,0,
                              *(undefined8 *)(param_1 + 0x10),*(undefined8 *)(param_1 + 0x28));
      }
      if (iVar1 != 1) {
        return 0x20a4;
      }
    }
    *param_1 = 1;
    return 0;
  }
  return 0x20a3;
}

