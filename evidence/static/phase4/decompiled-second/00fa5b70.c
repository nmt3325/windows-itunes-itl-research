/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xfa5b70; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

longlong FUN_140fa5b70(longlong param_1,undefined4 param_2,int param_3)

{
  int *piVar1;
  longlong lVar2;
  int iVar3;
  longlong lVar4;
  double dVar5;
  
  if (((param_1 == 0) || (*(longlong *)(param_1 + 0x10) == 0)) ||
     (lVar4 = FUN_140bc62b0(*(undefined8 *)(*(longlong *)(param_1 + 0x10) + 0x128)), lVar4 == 0)) {
    lVar4 = 0;
  }
  else {
    LOCK();
    UNLOCK();
    iVar3 = _DAT_141fe9130 + 1;
    *(int *)(lVar4 + 0x28) = _DAT_141fe9130;
    _DAT_141fe9130 = iVar3;
    *(undefined4 *)(lVar4 + 0x34) = param_2;
    *(undefined8 *)(lVar4 + 0x10) = 0x1420a7310;
    *(undefined8 *)(lVar4 + 0x18) = 0x1420a70c0;
    *(undefined8 *)(lVar4 + 0x20) = 0x1420a73c8;
    FUN_140fa5530(lVar4,param_1,0);
    piVar1 = (int *)(lVar4 + 0x58);
    if (param_3 == 0) {
      dVar5 = (double)CFAbsoluteTimeGetCurrent();
      iVar3 = FUN_140bc85c0((longlong)(dVar5 + *(double *)kCFAbsoluteTimeIntervalSince1904_exref));
      if (piVar1 != (int *)0x0) {
        *piVar1 = iVar3;
      }
    }
    else {
      *piVar1 = param_3;
    }
    if ((*(longlong *)(lVar4 + 8) != 0) &&
       (lVar2 = *(longlong *)(*(longlong *)(lVar4 + 8) + 0x10), lVar2 != 0)) {
      _DAT_1420fe7e0 = _DAT_1420fe7e0 + 1;
      *(ulonglong *)(lVar4 + 0x2c8) = lVar2 + (ulonglong)(_DAT_1420fe7e0 % 0x32) * 0x48 + 0x958;
    }
  }
  return lVar4;
}

