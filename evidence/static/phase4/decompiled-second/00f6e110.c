/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xf6e110; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

longlong * FUN_140f6e110(longlong param_1,longlong param_2,undefined4 param_3)

{
  int iVar1;
  longlong lVar2;
  longlong *plVar3;
  
  lVar2 = FUN_14179beec(0x150,&UNK_141912c00);
  if ((lVar2 == 0) || (plVar3 = (longlong *)FUN_140f6e1f0(lVar2), plVar3 == (longlong *)0x0)) {
    return (longlong *)0x0;
  }
  if ((param_1 != 0) && (*(int *)(param_1 + 0x80) == 0x74646174)) {
    plVar3[6] = param_1;
    *(undefined4 *)(plVar3 + 7) = 1;
    LOCK();
    UNLOCK();
    iVar1 = _DAT_141fe9130 + 1;
    *(int *)((longlong)plVar3 + 0x3c) = _DAT_141fe9130;
    _DAT_141fe9130 = iVar1;
    plVar3[8] = param_2;
    if (param_2 == 0) {
      lVar2 = func_0x000140eb8020(param_1);
      plVar3[8] = lVar2;
    }
    (**(code **)(*plVar3 + 0xb8))(plVar3);
    *(byte *)(plVar3 + 0xe) = *(byte *)(plVar3 + 0xe) & 0xfe;
    *(undefined4 *)(plVar3 + 0x12) = param_3;
    *(byte *)(plVar3 + 0xe) = *(byte *)(plVar3 + 0xe) | 0x1e;
    return plVar3;
  }
  (**(code **)*plVar3)(plVar3,1);
  return (longlong *)0x0;
}

