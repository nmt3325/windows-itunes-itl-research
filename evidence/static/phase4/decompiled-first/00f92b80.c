/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xf92b80; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

longlong *
FUN_140f92b80(longlong param_1,undefined4 param_2,longlong *param_3,longlong *param_4,
             undefined4 param_5,longlong param_6)

{
  int *piVar1;
  longlong *plVar2;
  char cVar3;
  int iVar4;
  undefined4 uVar5;
  longlong *plVar6;
  longlong lVar7;
  uint uVar8;
  longlong *plStackX_18;
  longlong *plStackX_20;
  
  if (0x7ffffffe < *(uint *)(param_1 + 0xa4)) {
    return (longlong *)0x0;
  }
  uVar8 = *(uint *)(param_1 + 0xa4) / 10;
  if (uVar8 < 100) {
    uVar8 = 100;
  }
  else if (2000 < uVar8) {
    uVar8 = 2000;
  }
  piVar1 = *(int **)(param_1 + 0x120);
  if (((piVar1 != (int *)0x0) && (*piVar1 == 0x46697841)) && (uVar8 != 0)) {
    piVar1[2] = uVar8;
  }
  piVar1 = *(int **)(param_1 + 0x128);
  if (((piVar1 != (int *)0x0) && (*piVar1 == 0x46697841)) && (uVar8 != 0)) {
    piVar1[2] = uVar8;
  }
  piVar1 = *(int **)(param_1 + 0x130);
  uVar8 = uVar8 >> 1;
  if (((piVar1 != (int *)0x0) && (*piVar1 == 0x46697841)) && (uVar8 != 0)) {
    piVar1[2] = uVar8;
  }
  piVar1 = *(int **)(param_1 + 0x138);
  if (((piVar1 != (int *)0x0) && (*piVar1 == 0x46697841)) && (uVar8 != 0)) {
    piVar1[2] = uVar8;
  }
  plStackX_18 = param_3;
  plStackX_20 = param_4;
  plVar6 = (longlong *)FUN_140bc62b0(*(undefined8 *)(param_1 + 0x120));
  if (plVar6 == (longlong *)0x0) {
    return (longlong *)0x0;
  }
  plVar6[2] = param_1;
  LOCK();
  UNLOCK();
  iVar4 = _DAT_141fe9130 + 1;
  *(int *)(plVar6 + 1) = _DAT_141fe9130;
  _DAT_141fe9130 = iVar4;
  plVar6[0xd] = 0x1420af610;
  plVar6[0xe] = 0x1420a7020;
  plVar6[0xf] = 0x1420a70a0;
  plVar6[0x10] = 0x1420a7060;
  if (param_6 == 0) {
    param_6 = func_0x000140eb8020(param_1);
  }
  *plVar6 = param_6;
  *(undefined4 *)(plVar6 + 0x15) = *(undefined4 *)(_DAT_1420a6f30 + 0x15558);
  lVar7 = FUN_140fa5b70(plVar6,param_2,param_5);
  plVar2 = plStackX_18;
  if (lVar7 == 0) {
LAB_140f92e46:
    FUN_140f910a0(plVar6);
    plVar6 = (longlong *)0x0;
  }
  else {
    if (*(char *)(param_1 + 0x2041) == '\x01') {
      *(undefined1 *)(param_1 + 0x2041) = 0;
    }
    if (plStackX_18 == (longlong *)0x0) {
      cVar3 = FUN_140ecfc10(param_1);
      if (cVar3 == '\0') {
        FUN_14108a360(param_1,plVar6,1,&plStackX_18);
      }
      else {
        plStackX_18 = (longlong *)FUN_14108b070();
      }
    }
    else {
      uVar5 = GetCurrentThreadId();
      FUN_140bd00e0(uVar5);
      *(int *)((longlong)plVar2 + 0xc) = *(int *)((longlong)plVar2 + 0xc) + 1;
    }
    if (plStackX_18 != (longlong *)0x0) {
      if (((int)plStackX_18[1] == 0x616c6269) && (plStackX_18[6] != 0)) {
        iVar4 = FUN_140f6c3e0(plStackX_18,plVar6);
      }
      else {
        iVar4 = -0x32;
      }
      plVar2 = plStackX_18;
      if (plStackX_18 != (longlong *)0x0) {
        uVar5 = GetCurrentThreadId();
        FUN_140bd00e0(uVar5);
        piVar1 = (int *)((longlong)plVar2 + 0xc);
        *piVar1 = *piVar1 + -1;
        if (*piVar1 == 0) {
          FUN_140f69310(plVar2);
          (**(code **)(*plVar2 + 8))(plVar2,1);
        }
      }
      if (iVar4 != 0) goto LAB_140f92e46;
    }
    if (param_4 == (longlong *)0x0) {
      cVar3 = FUN_140ecfc10(param_1);
      if ((cVar3 == '\0') && ((*(byte *)(param_1 + 0x114) & 0x10) == 0)) {
        FUN_140f6f110(param_1,plVar6,0,&plStackX_20);
        param_4 = plStackX_20;
      }
      else {
        param_4 = (longlong *)FUN_140f721d0(param_1);
      }
    }
    else {
      uVar5 = GetCurrentThreadId();
      FUN_140bd00e0(uVar5);
      (**(code **)(*param_4 + 0xc0))(param_4);
    }
    if (param_4 != (longlong *)0x0) {
      iVar4 = FUN_140f6fa00(param_4,plVar6);
      uVar5 = GetCurrentThreadId();
      FUN_140bd00e0(uVar5);
      (**(code **)(*param_4 + 200))(param_4);
      if (iVar4 != 0) goto LAB_140f92e46;
    }
    FUN_140f930a0(plVar6);
    *(byte *)((longlong)plVar6 + 0x9a) = *(byte *)((longlong)plVar6 + 0x9a) | 1;
  }
  return plVar6;
}

