/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1076780; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Type propagation algorithm not settling */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_141076780(int *param_1)

{
  uint uVar1;
  int iVar2;
  longlong lVar3;
  longlong lVar4;
  longlong lVar5;
  undefined8 uVar6;
  longlong lVar7;
  bool bVar8;
  undefined1 auStack_158 [32];
  int *piStack_138;
  int *piStack_130;
  ulonglong auStack_128 [2];
  char cStack_113;
  undefined8 uStack_118;
  undefined8 uStack_110;
  undefined8 uStack_108;
  undefined8 uStack_100;
  ulonglong uStack_f8;
  undefined8 uStack_f0;
  undefined8 uStack_e8;
  ulonglong uStack_e0;
  undefined8 uStack_d8;
  longlong alStack_c8 [2];
  undefined8 uStack_b8;
  undefined8 uStack_b0;
  undefined8 uStack_a8;
  undefined8 uStack_a0;
  undefined4 uStack_98;
  undefined4 uStack_94;
  undefined8 uStack_90;
  undefined8 uStack_88;
  undefined8 uStack_80;
  undefined8 uStack_78;
  undefined8 uStack_70;
  ulonglong uStack_28;
  
  if (param_1 == (int *)0x0) {
    return;
  }
  uStack_28 = _DAT_141fd5040 ^ (ulonglong)auStack_158;
  if (*(longlong *)(param_1 + 6) == 0) {
    return;
  }
  uStack_d8 = 0;
  uStack_118 = 0;
  uStack_110 = 0;
  uStack_108 = 0;
  uStack_100 = 0;
  uStack_f8 = 0;
  uStack_f0 = 0;
  uStack_e8 = 0;
  uStack_e0 = 0;
  if ((char)param_1[0xe] == '\0') {
    iVar2 = FUN_140b9fe10(&stack0xfffffffffffffee8,0x80000);
    if (iVar2 != 0) goto LAB_141076ae8;
    uVar6 = *(undefined8 *)(param_1 + 0xc);
    iVar2 = FUN_140ba09a0(uVar6,0);
    if (iVar2 != 0) goto LAB_141076ae8;
    auStack_128[1] = 0x90;
    iVar2 = FUN_140ba0350(uVar6,auStack_128 + 1,&uStack_b8);
    if (iVar2 != 0) goto LAB_141076ae8;
    itl_1068f90(&uStack_b8);
    iVar2 = FUN_140ba04c0(&stack0xfffffffffffffee8,auStack_128 + 1,&uStack_b8);
    if ((iVar2 != 0) || (iVar2 = FUN_141075580(uVar6,&stack0xfffffffffffffee8), iVar2 != 0))
    goto LAB_141076ae8;
    auStack_128[0] = 0;
    iVar2 = FUN_140bd67d0(uStack_110,auStack_128);
    if (iVar2 != 0) goto LAB_141076ae8;
    if (cStack_113 == '\0') {
      iVar2 = FUN_140bd6640(uStack_110,alStack_c8);
      if (iVar2 != 0) goto LAB_141076ae8;
      if (cStack_113 == '\0') {
        iVar2 = (int)uStack_f8 - (int)uStack_e8;
      }
      else if (uStack_e0 < uStack_f8) {
        iVar2 = 0;
      }
      else {
        iVar2 = ((int)uStack_e0 - (int)uStack_f8) + 1;
      }
      if (auStack_128[0] < (ulonglong)(iVar2 + alStack_c8[0])) {
        auStack_128[0] = iVar2 + alStack_c8[0];
      }
    }
    uStack_b0 = CONCAT44(uStack_b0._4_4_,(int)auStack_128[0]);
    uStack_78._0_4_ = CONCAT13(1,(undefined3)uStack_78);
    iVar2 = FUN_140ba09a0(&stack0xfffffffffffffee8,0);
    if (iVar2 != 0) goto LAB_141076ae8;
    itl_1068f90(&uStack_b8);
    iVar2 = FUN_140ba04c0(&stack0xfffffffffffffee8,auStack_128 + 1,&uStack_b8);
    if ((((iVar2 != 0) || (iVar2 = FUN_140ba0000(&stack0xfffffffffffffee8), iVar2 != 0)) ||
        (iVar2 = FUN_140ba09a0(uVar6,0), iVar2 != 0)) ||
       (iVar2 = FUN_140ba09a0(&stack0xfffffffffffffee8,0), iVar2 != 0)) goto LAB_141076ae8;
    *(undefined8 **)(param_1 + 0xc) = &stack0xfffffffffffffee8;
  }
  uStack_90 = *(undefined8 *)(param_1 + 8);
  uStack_a0 = *(undefined8 *)(param_1 + 6);
  uStack_b0 = *(undefined8 *)(param_1 + 0xc);
  uStack_70 = *(undefined8 *)(param_1 + 10);
  uStack_b8 = 0x62776266;
  uStack_a8 = 1;
  if ((char)param_1[0xe] == '\0') {
    uStack_78 = param_1 + 0x9a;
    uStack_98 = 0x686f6f6b;
    uStack_94 = 0x686b6462;
    uStack_88 = 0x90;
    uStack_80 = 0x19000;
    iVar2 = FUN_140ba0ac0(&uStack_b8);
  }
  else {
    piStack_138 = param_1 + 0x10;
    piStack_130 = param_1 + 0x98;
    iVar2 = FUN_1410760a0();
  }
  *param_1 = iVar2;
  if ((iVar2 != 0) || (lVar3 = FUN_140b9b860(0,*(undefined8 *)(param_1 + 10)), lVar3 == 0))
  goto LAB_141076ae8;
  lVar4 = CFURLCopyAbsoluteURL(lVar3);
  if (lVar4 != 0) {
    lVar5 = CFURLGetString(lVar4);
    if (lVar5 != 0) {
      lVar5 = CFRetain(lVar5);
      CFRelease(lVar4);
      if (lVar5 == 0) goto LAB_141076a98;
      uVar6 = __CFStringMakeConstantString(&UNK_141ab1fb8);
      lVar7 = __CFStringMakeConstantString(&UNK_141b591d0);
      lVar4 = lVar5;
      if (lVar7 != 0) {
        CFPreferencesSetAppValue(lVar7,lVar5,uVar6);
      }
    }
    CFRelease(lVar4);
  }
LAB_141076a98:
  lVar4 = *(longlong *)kCFPreferencesCurrentHost_exref;
  lVar5 = *(longlong *)kCFPreferencesCurrentUser_exref;
  lVar7 = __CFStringMakeConstantString(&UNK_141ab1fb8);
  if (((lVar7 != 0) && (lVar5 != 0)) && (lVar4 != 0)) {
    CFPreferencesSynchronize(lVar7,lVar5,lVar4);
  }
  CFRelease(lVar3);
LAB_141076ae8:
  if ((char)param_1[0xe] == '\0') {
    FUN_140ba02c0(&stack0xfffffffffffffee8);
  }
  if ((param_1 + 1 != (int *)0x0) && (param_1[1] == 0x63636d70)) {
    do {
      uVar1 = param_1[3];
      LOCK();
      bVar8 = uVar1 == param_1[3];
      if (bVar8) {
        param_1[3] = uVar1 | 1;
      }
      UNLOCK();
    } while (!bVar8);
    if ((uVar1 & 2) != 0) {
      FUN_140b07d90(param_1[4]);
    }
  }
  return;
}

