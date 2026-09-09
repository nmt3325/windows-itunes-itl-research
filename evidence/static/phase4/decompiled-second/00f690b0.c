/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xf690b0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

longlong * FUN_140f690b0(int param_1,longlong param_2,longlong param_3)

{
  undefined4 uVar1;
  int iVar2;
  longlong *plVar3;
  
  plVar3 = (longlong *)FUN_14179beec(0x110,&UNK_141912c00);
  if (plVar3 != (longlong *)0x0) {
    *(byte *)((longlong)plVar3 + 0x75) = *(byte *)((longlong)plVar3 + 0x75) & 0xe0;
    *plVar3 = (longlong)&UNK_141b59a40;
    plVar3[1] = 0;
    plVar3[2] = 0;
    plVar3[3] = 0;
    plVar3[4] = 0;
    plVar3[5] = 0;
    plVar3[6] = 0;
    plVar3[7] = 0;
    plVar3[8] = 0;
    plVar3[9] = 0;
    plVar3[10] = 0;
    *(undefined2 *)(plVar3 + 0xb) = 0;
    *(undefined4 *)((longlong)plVar3 + 0x5c) = 0;
    *(undefined2 *)(plVar3 + 0xc) = 0;
    *(undefined1 *)((longlong)plVar3 + 0x62) = 0;
    plVar3[0xd] = 0;
    *(undefined4 *)(plVar3 + 0xe) = 1;
    *(undefined1 *)((longlong)plVar3 + 0x74) = 0;
    *(undefined4 *)(plVar3 + 0xf) = 0;
    *(undefined2 *)((longlong)plVar3 + 0x7c) = 0;
    *(undefined4 *)(plVar3 + 0x10) = 0;
    *(undefined1 *)((longlong)plVar3 + 0x84) = 0;
    plVar3[0x11] = 0;
    *(undefined1 *)(plVar3 + 0x12) = 0;
    *(undefined1 *)(plVar3 + 0x17) = 0;
    plVar3[0x18] = (longlong)&UNK_141b2a0e8;
    plVar3[0x19] = 0;
    *(undefined4 *)(plVar3 + 0x1a) = 0;
    plVar3[0x1b] = 0;
    plVar3[0x1c] = 0;
    plVar3[0x1d] = (longlong)&UNK_141b2a0e8;
    plVar3[0x1e] = 0;
    *(undefined4 *)(plVar3 + 0x1f) = 0;
    if (plVar3 + 0x20 != (longlong *)0x0) {
      plVar3[0x20] = 0;
      *(undefined4 *)(plVar3 + 0x21) = 0;
    }
    if ((undefined8 *)((longlong)plVar3 + 0x94) != (undefined8 *)0x0) {
      *(undefined8 *)((longlong)plVar3 + 0x94) = 0;
      *(undefined8 *)((longlong)plVar3 + 0x9c) = 0;
      *(undefined8 *)((longlong)plVar3 + 0xa4) = 0;
      *(undefined8 *)((longlong)plVar3 + 0xac) = 0;
      *(undefined4 *)((longlong)plVar3 + 0xb4) = 0;
    }
    if (plVar3 != (longlong *)0x0) {
      if ((((param_1 != 0) && (param_2 != 0)) && (*(int *)(param_2 + 0x80) == 0x74646174)) &&
         (*(uint *)(param_2 + 0xac) < 0x7fffffff)) {
        *(undefined4 *)(plVar3 + 1) = 0x616c6269;
        *(undefined4 *)((longlong)plVar3 + 0xc) = 1;
        plVar3[6] = param_2;
        *(int *)(plVar3 + 2) = param_1;
        LOCK();
        UNLOCK();
        iVar2 = _DAT_141fe9130 + 1;
        *(int *)(plVar3 + 3) = _DAT_141fe9130;
        _DAT_141fe9130 = iVar2;
        if (param_3 == 0) {
          param_3 = func_0x000140eb8020(param_2);
        }
        plVar3[4] = param_3;
        uVar1 = *(undefined4 *)(_DAT_1420a6f30 + 0x15558);
        *(undefined4 *)((longlong)plVar3 + 0x1c) = uVar1;
        *(undefined4 *)(plVar3[6] + 0x2048) = uVar1;
        return plVar3;
      }
      (**(code **)(*plVar3 + 8))(plVar3,1);
      return (longlong *)0x0;
    }
  }
  return (longlong *)0x0;
}

