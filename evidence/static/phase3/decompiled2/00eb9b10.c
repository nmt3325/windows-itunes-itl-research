/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xeb9b10; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

ulonglong FUN_140eb9b10(longlong param_1,int *param_2,undefined4 param_3)

{
  longlong *plVar1;
  int *piVar2;
  int iVar3;
  longlong lVar4;
  longlong lVar5;
  longlong lVar6;
  longlong *plVar7;
  uint uVar8;
  ulonglong uVar9;
  longlong lVar10;
  int *piVar11;
  undefined1 auStack_4a8 [32];
  longlong **pplStack_488;
  undefined8 uStack_480;
  undefined4 uStack_478;
  longlong *plStack_468;
  longlong *plStack_460;
  longlong *plStack_458;
  longlong *plStack_450;
  ushort uStack_448;
  undefined1 auStack_446 [510];
  ushort uStack_248;
  undefined1 auStack_246 [510];
  ulonglong uStack_48;
  
  uStack_48 = _DAT_141fd5040 ^ (ulonglong)auStack_4a8;
  uStack_478 = 0;
  uStack_480 = 0;
  pplStack_488 = (longlong **)0x0;
  uVar9 = FUN_1404941f0(param_1,param_3,0,0);
  if ((int)uVar9 != 0) {
    return uVar9;
  }
  if (((param_1 == 0) || (lVar4 = *(longlong *)(param_1 + 8), lVar4 == 0)) ||
     (lVar5 = *(longlong *)(lVar4 + 0x10), lVar5 == 0)) {
    return 0xffffffce;
  }
  if (*(int *)(lVar4 + 0xb0) != 0) {
    return uVar9 & 0xffffffff;
  }
  if ((*(int *)(lVar5 + 0x80) == 0x74646174) && (*(int *)(lVar5 + 0x84) != 0x646f5069)) {
    *(byte *)(lVar4 + 0x9a) = *(byte *)(lVar4 + 0x9a) | 0x10;
  }
  uStack_248 = 0;
  if (((param_2 != (int *)0x0) && (*(longlong *)(param_2 + 4) != 0)) &&
     ((*param_2 == 0x41464350 || (*param_2 == 0x57696e50)))) {
    (**(code **)(*(longlong *)(param_2 + 4) + 0x10))(param_2,&uStack_248);
  }
  plStack_458 = (longlong *)0x0;
  plStack_450 = (longlong *)0x0;
  plStack_468 = (longlong *)0x0;
  plStack_460 = (longlong *)0x0;
  uStack_478 = 8;
  uStack_480 = 0;
  pplStack_488 = &plStack_468;
  FUN_14039c9e0(param_1,0x82,0,0);
  plVar7 = plStack_460;
  plStack_458 = plStack_468;
  plStack_450 = plStack_460;
  if (plStack_468 == (longlong *)0x0) {
    uVar8 = (uint)uStack_248;
    if (uStack_248 < 0x100) {
      uStack_448 = uStack_248;
      if (uVar8 == 0) goto LAB_140eb9c96;
    }
    else {
      uStack_448 = 0xff;
      uVar8 = 0xff;
    }
    func_0x00014179cc9a(auStack_446,auStack_246,uVar8 * 2);
  }
  else {
    (**(code **)(*plStack_468 + 0xe8))(plStack_468,&uStack_248,&uStack_448);
  }
LAB_140eb9c96:
  if (plVar7 != (longlong *)0x0) {
    LOCK();
    plVar1 = plVar7 + 1;
    lVar4 = *plVar1;
    *(int *)plVar1 = (int)*plVar1 + -1;
    UNLOCK();
    if ((int)lVar4 == 1) {
      (**(code **)*plVar7)(plVar7);
      LOCK();
      piVar11 = (int *)((longlong)plVar7 + 0xc);
      iVar3 = *piVar11;
      *piVar11 = *piVar11 + -1;
      UNLOCK();
      if (iVar3 == 1) {
        (**(code **)(*plVar7 + 8))(plVar7);
      }
    }
  }
  lVar4 = *(longlong *)(param_1 + 8);
  if ((lVar4 != 0) && (lVar5 = *(longlong *)(lVar4 + 0x10), lVar5 != 0)) {
    piVar11 = (int *)(lVar5 + 0x178);
    if (uStack_448 < 0x100) {
      if (((piVar11 != (int *)0x0) && (*piVar11 == 0x73747263)) && (*(int *)(lVar5 + 0x1a0) == 0)) {
        iVar3 = *(int *)(lVar4 + 0xb0);
        lVar10 = (longlong)iVar3;
        if (*(int *)(lVar5 + 0x1b4) == 0) {
          if (iVar3 != 0) {
            if ((iVar3 < 1) || (*(int *)(lVar5 + 0x1a4) < iVar3)) goto LAB_140eb9d97;
            if ((*(byte *)(lVar5 + 0x17c) & 1) != 0) {
              piVar2 = (int *)(**(longlong **)(lVar5 + 400) + -4 + lVar10 * 4);
              *piVar2 = *piVar2 + -1;
              if (*piVar2 != 0) goto LAB_140eb9d77;
            }
            lVar6 = **(longlong **)(lVar5 + 0x188);
            *(int *)(lVar5 + 0x1b8) = *(int *)(lVar5 + 0x1b8) + *(int *)(lVar6 + -4 + lVar10 * 8);
            *(undefined4 *)(lVar6 + -8 + lVar10 * 8) = 0x80000001;
          }
LAB_140eb9d77:
          uVar8 = FUN_140bfe1f0(piVar11,auStack_446,(uint)uStack_448 * 2);
          FUN_140ec7b80(lVar4,0);
          return (ulonglong)uVar8;
        }
      }
LAB_140eb9d97:
      FUN_140ec7b80(lVar4,0);
      return 0xffffffce;
    }
    *(int *)(lVar4 + 0xb0) = 0;
    FUN_140ec7b80(lVar4,0);
  }
  return 0xffffffce;
}

