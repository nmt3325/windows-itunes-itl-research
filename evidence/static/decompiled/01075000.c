/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1075000; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

int FUN_141075000(longlong param_1,undefined1 *param_2)

{
  longlong *plVar1;
  int *piVar2;
  longlong *plVar3;
  int iVar4;
  longlong lVar5;
  longlong lVar6;
  longlong lVar7;
  uint uVar8;
  undefined1 auStack_148 [32];
  longlong *plStack_128;
  longlong *plStack_120;
  longlong lStack_118;
  longlong lStack_110;
  int aiStack_108 [4];
  uint uStack_f8;
  uint uStack_f4;
  undefined8 uStack_f0;
  undefined8 uStack_e8;
  undefined8 uStack_e0;
  undefined8 uStack_d8;
  undefined8 uStack_d0;
  undefined8 uStack_c8;
  undefined8 uStack_c0;
  undefined8 uStack_b8;
  undefined8 uStack_b0;
  undefined8 uStack_a8;
  undefined8 uStack_a0;
  undefined8 uStack_98;
  undefined8 uStack_90;
  undefined8 uStack_88;
  undefined8 uStack_80;
  undefined8 uStack_78;
  undefined8 uStack_70;
  undefined8 uStack_68;
  undefined8 uStack_60;
  undefined8 uStack_58;
  undefined8 uStack_50;
  undefined8 uStack_48;
  undefined8 uStack_40;
  ulonglong uStack_38;
  
  uStack_38 = _DAT_141fd5040 ^ (ulonglong)auStack_148;
  lVar6 = 0;
  *param_2 = 0;
  if (_DAT_1420cf400 != (longlong *)0x0) {
    LOCK();
    *(int *)(_DAT_1420cf400 + 1) = (int)_DAT_1420cf400[1] + 1;
    UNLOCK();
  }
  plVar3 = _DAT_1420cf400;
  plStack_128 = _DAT_1420cf3f8;
  plStack_120 = _DAT_1420cf400;
  if (_DAT_1420cf3f8 == (longlong *)0x0) {
    if (_DAT_1420cf400 != (longlong *)0x0) {
      LOCK();
      plVar1 = _DAT_1420cf400 + 1;
      lVar5 = *plVar1;
      *(int *)plVar1 = (int)*plVar1 + -1;
      UNLOCK();
      if ((int)lVar5 == 1) {
        (**(code **)*plVar3)(plVar3);
        LOCK();
        piVar2 = (int *)((longlong)plVar3 + 0xc);
        iVar4 = *piVar2;
        *piVar2 = *piVar2 + -1;
        UNLOCK();
        if (iVar4 == 1) {
          (**(code **)(*plVar3 + 8))(plVar3);
        }
      }
    }
    lVar5 = 0;
  }
  else {
    lVar5 = (**(code **)(*_DAT_1420cf3f8 + 0xe0))();
    if (plVar3 != (longlong *)0x0) {
      LOCK();
      plVar1 = plVar3 + 1;
      lVar7 = *plVar1;
      *(int *)plVar1 = (int)*plVar1 + -1;
      UNLOCK();
      if ((int)lVar7 == 1) {
        (**(code **)*plVar3)(plVar3);
        LOCK();
        piVar2 = (int *)((longlong)plVar3 + 0xc);
        iVar4 = *piVar2;
        *piVar2 = *piVar2 + -1;
        UNLOCK();
        if (iVar4 == 1) {
          (**(code **)(*plVar3 + 8))(plVar3);
        }
      }
    }
  }
  if (_DAT_1420cf410 != (longlong *)0x0) {
    LOCK();
    *(int *)(_DAT_1420cf410 + 1) = (int)_DAT_1420cf410[1] + 1;
    UNLOCK();
  }
  plVar3 = _DAT_1420cf410;
  plStack_128 = _DAT_1420cf408;
  plStack_120 = _DAT_1420cf410;
  if (_DAT_1420cf408 != (longlong *)0x0) {
    lVar6 = (**(code **)(*_DAT_1420cf408 + 200))();
  }
  if (plVar3 != (longlong *)0x0) {
    LOCK();
    plVar1 = plVar3 + 1;
    lVar7 = *plVar1;
    *(int *)plVar1 = (int)*plVar1 + -1;
    UNLOCK();
    if ((int)lVar7 == 1) {
      (**(code **)*plVar3)(plVar3);
      LOCK();
      piVar2 = (int *)((longlong)plVar3 + 0xc);
      iVar4 = *piVar2;
      *piVar2 = *piVar2 + -1;
      UNLOCK();
      if (iVar4 == 1) {
        (**(code **)(*plVar3 + 8))(plVar3);
      }
    }
  }
  func_0x000140ed2bb0(*(undefined8 *)(param_1 + 0x1e00270));
  uStack_88 = 0;
  uStack_80 = 0;
  uStack_78 = 0;
  uStack_70 = 0;
  uStack_68 = 0;
  uStack_60 = 0;
  uStack_58 = 0;
  uStack_50 = 0;
  uStack_48 = 0;
  uStack_40 = 0;
  uStack_98 = 0x606864736d;
  uStack_90 = 0x1700000000;
  lVar7 = *(longlong *)(param_1 + 0x120);
  lStack_118 = 0;
  if (*(char *)(lVar7 + 5) == '\0') {
    iVar4 = FUN_140bd6640(*(undefined8 *)(lVar7 + 8),&lStack_118);
    if (iVar4 != 0) goto LAB_141075528;
  }
  else {
    lStack_118 = *(longlong *)(lVar7 + 0x40);
  }
  if (*(char *)(lVar7 + 5) == '\0') {
    lVar7 = *(longlong *)(lVar7 + 0x20) - *(longlong *)(lVar7 + 0x30);
  }
  else {
    lVar7 = (*(longlong *)(lVar7 + 0x20) - *(longlong *)(lVar7 + 0x38)) + -1;
  }
  lStack_118 = lVar7 + lStack_118;
  plStack_128 = (longlong *)0x60;
  iVar4 = FUN_140ba04c0(*(undefined8 *)(param_1 + 0x120),&plStack_128,&uStack_98);
  if (iVar4 == 0) {
    uStack_f0 = 0;
    uStack_e8 = 0;
    uStack_e0 = 0;
    uStack_d8 = 0;
    uStack_d0 = 0;
    uStack_c8 = 0;
    uStack_c0 = 0;
    uStack_b8 = 0;
    uStack_b0 = 0;
    uStack_a8 = 0;
    uStack_a0 = 0;
    uStack_f8 = 0x68737473;
    uStack_f4 = 0x60;
    lVar7 = *(longlong *)(param_1 + 0x120);
    lStack_110 = 0;
    if (*(char *)(lVar7 + 5) == '\0') {
      iVar4 = FUN_140bd6640(*(undefined8 *)(lVar7 + 8),&lStack_110);
      if (iVar4 != 0) goto LAB_141075528;
    }
    else {
      lStack_110 = *(longlong *)(lVar7 + 0x40);
    }
    if (*(char *)(lVar7 + 5) == '\0') {
      lVar7 = *(longlong *)(lVar7 + 0x20) - *(longlong *)(lVar7 + 0x30);
    }
    else {
      lVar7 = (*(longlong *)(lVar7 + 0x20) - *(longlong *)(lVar7 + 0x38)) + -1;
    }
    lStack_110 = lVar7 + lStack_110;
    plStack_128 = (longlong *)0x60;
    iVar4 = FUN_140ba04c0(*(undefined8 *)(param_1 + 0x120),&plStack_128,&uStack_f8);
    if (iVar4 == 0) {
      if (lVar5 != 0) {
        plStack_128 = (longlong *)(param_1 + 0xa00128);
        FUN_14106b140(param_1,lVar5,0x385,&plStack_128);
        plStack_128 = (longlong *)(ulonglong)(((int)plStack_128 - (int)param_1) - 0xa00128);
        iVar4 = FUN_140ba04c0(*(undefined8 *)(param_1 + 0x120),&plStack_128,
                              (longlong *)(param_1 + 0xa00128));
        if (iVar4 != 0) goto LAB_141075528;
        uStack_f0 = CONCAT44(uStack_f0._4_4_ + 1,(uint)uStack_f0);
      }
      if (lVar6 != 0) {
        plStack_128 = (longlong *)(param_1 + 0xa00128);
        FUN_14106b140(param_1,lVar6,900,&plStack_128);
        plStack_128 = (longlong *)(ulonglong)(((int)plStack_128 - (int)param_1) - 0xa00128);
        iVar4 = FUN_140ba04c0(*(undefined8 *)(param_1 + 0x120),&plStack_128,
                              (longlong *)(param_1 + 0xa00128));
        if (iVar4 != 0) goto LAB_141075528;
        uStack_f0 = CONCAT44(uStack_f0._4_4_ + 1,(uint)uStack_f0);
      }
      iVar4 = FUN_140b9ff80(*(undefined8 *)(param_1 + 0x120),aiStack_108);
      if (iVar4 == 0) {
        uVar8 = aiStack_108[0] - (int)lStack_118;
        uStack_90 = CONCAT44(uStack_90._4_4_,uVar8);
        if (*(char *)(param_1 + 0x52) == '\0') {
          uStack_98 = CONCAT44((uStack_98._4_4_ & 0xff0000 | uStack_98._4_4_ >> 0x10) >> 8 |
                               (uStack_98._4_4_ & 0xff00 | uStack_98._4_4_ << 0x10) << 8,
                               ((uint)uStack_98 & 0xff0000 | (uint)uStack_98 >> 0x10) >> 8 |
                               ((uint)uStack_98 & 0xff00 | (uint)uStack_98 << 0x10) << 8);
          uStack_90 = CONCAT44((uStack_90._4_4_ & 0xff0000 | uStack_90._4_4_ >> 0x10) >> 8 |
                               (uStack_90._4_4_ & 0xff00 | uStack_90._4_4_ << 0x10) << 8,
                               uVar8 >> 0x18 | (uVar8 & 0xff0000) >> 8 | (uVar8 & 0xff00) << 8 |
                               uVar8 * 0x1000000);
        }
        iVar4 = FUN_14106aba0(param_1,lStack_118,&uStack_98,0x60);
        if (iVar4 == 0) {
          if (*(char *)(param_1 + 0x52) == '\0') {
            uStack_f8 = (uStack_f8 & 0xff0000 | uStack_f8 >> 0x10) >> 8 |
                        (uStack_f8 << 0x10 | uStack_f8 & 0xff00) << 8;
            uStack_f4 = (uStack_f4 & 0xff0000 | uStack_f4 >> 0x10) >> 8 |
                        (uStack_f4 << 0x10 | uStack_f4 & 0xff00) << 8;
            uStack_f0 = CONCAT44((uStack_f0._4_4_ & 0xff0000 | uStack_f0._4_4_ >> 0x10) >> 8 |
                                 (uStack_f0._4_4_ << 0x10 | uStack_f0._4_4_ & 0xff00) << 8,
                                 ((uint)uStack_f0 & 0xff0000 | (uint)uStack_f0 >> 0x10) >> 8 |
                                 ((uint)uStack_f0 << 0x10 | (uint)uStack_f0 & 0xff00) << 8);
          }
          iVar4 = FUN_14106aba0(param_1,lStack_110,&uStack_f8,0x60);
          if (iVar4 == 0) {
            *param_2 = 1;
          }
        }
      }
    }
  }
LAB_141075528:
  func_0x000140ed2fe0(*(undefined8 *)(param_1 + 0x1e00270));
  if (lVar5 != 0) {
    CFRelease(lVar5);
  }
  if (lVar6 != 0) {
    CFRelease(lVar6);
  }
  return iVar4;
}

