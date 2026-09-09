/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x107ea60; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

ulonglong FUN_14107ea60(longlong param_1,longlong param_2)

{
  ulonglong uVar1;
  ulonglong uVar2;
  uint *puVar3;
  uint uVar4;
  uint uVar5;
  uint uVar6;
  ulonglong uVar7;
  ulonglong uVar8;
  undefined1 auStack_d8 [32];
  uint uStack_b8;
  uint uStack_b4;
  uint auStack_b0 [6];
  uint uStack_98;
  uint uStack_94;
  uint auStack_90 [22];
  ulonglong uStack_38;
  
  uStack_38 = _DAT_141fd5040 ^ (ulonglong)auStack_d8;
  uVar7 = 0;
  uVar8 = uVar7;
  if (*(int *)(param_2 + 0xc) != 0) {
    do {
      uVar1 = FUN_1410770a0(param_1,&uStack_b8,8);
      if ((int)uVar1 != 0) {
        return uVar1;
      }
      uVar5 = uStack_b4;
      if (*(char *)(param_1 + 0x52) == '\0') {
        uVar5 = uStack_b4 >> 0x18 | (uStack_b4 & 0xff0000) >> 8 | (uStack_b4 & 0xff00) << 8 |
                uStack_b4 << 0x18;
      }
      puVar3 = auStack_b0;
      uVar4 = 0x18;
      if (uVar5 < 0x18) {
        uVar4 = uVar5;
      }
      if (8 < uVar4) {
        uVar1 = (ulonglong)(uVar4 - 8);
        if (0xa00000 < uVar1) {
          return 0xffffff30;
        }
        uVar2 = FUN_1410770a0(param_1,auStack_b0,uVar1);
        if ((int)uVar2 != 0) {
          return uVar2;
        }
        puVar3 = (uint *)((longlong)auStack_b0 + uVar1);
      }
      uVar1 = (ulonglong)uStack_b4;
      if ((uVar4 < 0x18) && (puVar3 != (uint *)0x0)) {
        func_0x00014179cca0(puVar3,0,0x18 - uVar4);
        uVar1 = (ulonglong)uStack_b4;
      }
      if ((uVar4 < uVar5) && (uVar2 = itl_106a520(param_1,uVar5 - uVar4), (int)uVar2 != 0)) {
        return uVar2;
      }
      uVar5 = (uint)uVar1;
      if (*(char *)(param_1 + 0x52) == '\0') {
        uStack_b8 = (uStack_b8 & 0xff0000 | uStack_b8 >> 0x10) >> 8 |
                    (uStack_b8 << 0x10 | uStack_b8 & 0xff00) << 8;
        uVar5 = (uVar5 & 0xff0000 | (uint)(uVar1 >> 0x10) & 0xffff) >> 8 |
                (uVar5 & 0xff00 | uVar5 << 0x10) << 8;
        auStack_b0[0] =
             (auStack_b0[0] & 0xff0000 | auStack_b0[0] >> 0x10) >> 8 |
             (auStack_b0[0] & 0xff00 | auStack_b0[0] << 0x10) << 8;
        auStack_b0[1] =
             (auStack_b0[1] & 0xff0000 | auStack_b0[1] >> 0x10) >> 8 |
             (auStack_b0[1] << 0x10 | auStack_b0[1] & 0xff00) << 8;
        auStack_b0[2] =
             (auStack_b0[2] & 0xff0000 | auStack_b0[2] >> 0x10) >> 8 |
             (auStack_b0[2] << 0x10 | auStack_b0[2] & 0xff00) << 8;
        uStack_b4 = uVar5;
      }
      if (uStack_b8 != 0x686f686d) {
        return 0xffffff30;
      }
      uVar1 = (longlong)(int)(auStack_b0[0] - uVar5) + *(longlong *)(param_1 + 0x1e00170);
      *(ulonglong *)(param_1 + 0x1e00170) = uVar1;
      if ((uVar1 < *(ulonglong *)(param_1 + 0x1e00178)) ||
         (*(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180) <= uVar1)) {
        *(undefined8 *)(param_1 + 0x1e00180) = 0;
      }
      uVar5 = (int)uVar8 + 1;
      uVar8 = (ulonglong)uVar5;
    } while (uVar5 < *(uint *)(param_2 + 0xc));
  }
  uVar8 = uVar7;
  if (*(int *)(param_2 + 0x10) != 0) {
    do {
      uVar1 = FUN_1410770a0(param_1,&uStack_98,8);
      if ((int)uVar1 != 0) {
        return uVar1;
      }
      uVar5 = uStack_94;
      if (*(char *)(param_1 + 0x52) == '\0') {
        uVar5 = (uStack_94 & 0xff0000 | uStack_94 >> 0x10) >> 8 |
                (uStack_94 << 0x10 | uStack_94 & 0xff00) << 8;
      }
      puVar3 = auStack_90;
      uVar4 = 0x54;
      if (uVar5 < 0x54) {
        uVar4 = uVar5;
      }
      if (8 < uVar4) {
        uVar1 = (ulonglong)(uVar4 - 8);
        if (0xa00000 < uVar1) {
          return 0xffffff30;
        }
        uVar2 = FUN_1410770a0(param_1,auStack_90,uVar1);
        if ((int)uVar2 != 0) {
          return uVar2;
        }
        puVar3 = (uint *)((longlong)auStack_90 + uVar1);
      }
      uVar1 = (ulonglong)uStack_94;
      if ((uVar4 < 0x54) && (puVar3 != (uint *)0x0)) {
        func_0x00014179cca0(puVar3,0,0x54 - uVar4);
        uVar1 = (ulonglong)uStack_94;
      }
      if ((uVar4 < uVar5) && (uVar2 = itl_106a520(param_1,uVar5 - uVar4), (int)uVar2 != 0)) {
        return uVar2;
      }
      uVar6 = (uint)uVar1;
      uVar5 = uStack_98;
      uVar4 = auStack_90[0];
      if (*(char *)(param_1 + 0x52) == '\0') {
        uVar6 = (uVar6 & 0xff0000 | (uint)(uVar1 >> 0x10) & 0xffff) >> 8 |
                (uVar6 << 0x10 | uVar6 & 0xff00) << 8;
        uVar5 = (uStack_98 & 0xff0000 | uStack_98 >> 0x10) >> 8 |
                (uStack_98 << 0x10 | uStack_98 & 0xff00) << 8;
        uVar4 = (auStack_90[0] & 0xff0000 | auStack_90[0] >> 0x10) >> 8 |
                (auStack_90[0] << 0x10 | auStack_90[0] & 0xff00) << 8;
      }
      if (uVar5 != 0x6870746d) {
        return 0xffffff30;
      }
      uVar1 = (longlong)(int)(uVar4 - uVar6) + *(longlong *)(param_1 + 0x1e00170);
      *(ulonglong *)(param_1 + 0x1e00170) = uVar1;
      if ((uVar1 < *(ulonglong *)(param_1 + 0x1e00178)) ||
         (*(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180) <= uVar1)) {
        *(undefined8 *)(param_1 + 0x1e00180) = 0;
      }
      uVar5 = (int)uVar8 + 1;
      uVar8 = (ulonglong)uVar5;
    } while (uVar5 < *(uint *)(param_2 + 0x10));
  }
  return uVar7;
}

