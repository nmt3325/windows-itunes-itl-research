/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xf930a0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_140f930a0(longlong *param_1)

{
  longlong *plVar1;
  int *piVar2;
  int iVar3;
  undefined4 uVar4;
  longlong lVar5;
  longlong *plVar6;
  undefined8 *puVar7;
  longlong lVar8;
  longlong *plStackX_8;
  undefined1 auStack_28 [32];
  
  lVar8 = 0;
  if (param_1 != (longlong *)0x0) {
    lVar8 = param_1[2];
  }
  param_1[3] = 0;
  param_1[4] = *(longlong *)(lVar8 + 0xd0);
  if (*(longlong *)(lVar8 + 0xd0) == 0) {
    *(longlong **)(lVar8 + 200) = param_1;
  }
  else {
    *(longlong **)(*(longlong *)(lVar8 + 0xd0) + 0x18) = param_1;
  }
  *(int *)(lVar8 + 0xa4) = *(int *)(lVar8 + 0xa4) + 1;
  *(byte *)(lVar8 + 0x110) = *(byte *)(lVar8 + 0x110) | 0x10;
  *(longlong **)(lVar8 + 0xd0) = param_1;
  lVar5 = param_1[2];
  if ((lVar5 != 0) && (*(int *)(lVar5 + 0x80) == 0x74646174)) {
    uVar4 = *(undefined4 *)(_DAT_1420a6f30 + 0x15558);
    *(undefined4 *)(param_1 + 0x15) = uVar4;
    *(undefined4 *)(lVar5 + 0x2048) = uVar4;
    for (plVar6 = (longlong *)param_1[0xc]; plVar6 != (longlong *)0x0;
        plVar6 = (longlong *)plVar6[7]) {
      *(undefined4 *)((longlong)plVar6 + 0x44) = uVar4;
      *(undefined4 *)(*plVar6 + 0x404) = uVar4;
    }
    lVar5 = param_1[5];
    if (lVar5 != 0) {
      uVar4 = *(undefined4 *)(_DAT_1420a6f30 + 0x15558);
      *(undefined4 *)(lVar5 + 0x1c) = uVar4;
      *(undefined4 *)(*(longlong *)(lVar5 + 0x30) + 0x2048) = uVar4;
    }
  }
  plStackX_8 = param_1;
  if ((*(longlong *)(lVar8 + 0x18d8) != 0) && ((int)param_1[1] != 0)) {
    FUN_140693570(*(longlong *)(lVar8 + 0x18d8),auStack_28,param_1 + 1,&plStackX_8);
  }
  if ((*(longlong *)(lVar8 + 0x18e0) != 0) && (*param_1 != 0)) {
    FUN_140af68f0(*(longlong *)(lVar8 + 0x18e0),auStack_28,param_1,&plStackX_8);
  }
  puVar7 = *(undefined8 **)(lVar8 + 0x18e8);
  if (puVar7 != (undefined8 *)0x0) {
    if (param_1[0x29] == 0) {
      free(*puVar7);
      func_0x000140bc6a20(puVar7,0x18);
      *(undefined8 *)(lVar8 + 0x18e8) = 0;
    }
    else {
      FUN_140af68f0(puVar7,auStack_28,param_1 + 0x29,&plStackX_8);
    }
  }
  if (*(longlong *)(lVar8 + 0x1950) != 0) {
    _aligned_free();
  }
  plVar6 = *(longlong **)(lVar8 + 0x1960);
  *(undefined8 *)(lVar8 + 0x1950) = 0;
  *(undefined8 *)(lVar8 + 0x1958) = 0;
  *(undefined8 *)(lVar8 + 0x1960) = 0;
  if (plVar6 != (longlong *)0x0) {
    LOCK();
    plVar1 = plVar6 + 1;
    lVar5 = *plVar1;
    *(int *)plVar1 = (int)*plVar1 + -1;
    UNLOCK();
    if ((int)lVar5 == 1) {
      (**(code **)*plVar6)(plVar6);
      LOCK();
      piVar2 = (int *)((longlong)plVar6 + 0xc);
      iVar3 = *piVar2;
      *piVar2 = *piVar2 + -1;
      UNLOCK();
      if (iVar3 == 1) {
        (**(code **)(*plVar6 + 8))(plVar6);
      }
    }
  }
  lVar5 = *(longlong *)(lVar8 + 0x1938);
  if (lVar5 != 0) {
    FUN_1402f9980(lVar5);
    func_0x000140bc6a20(lVar5,0x10);
  }
  *(undefined8 *)(lVar8 + 0x1938) = 0;
  return;
}

