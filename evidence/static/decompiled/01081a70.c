/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1081a70; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

int FUN_141081a70(longlong param_1)

{
  char *pcVar1;
  longlong *plVar2;
  int *piVar3;
  longlong *plVar4;
  longlong *plVar5;
  longlong lVar6;
  longlong lVar7;
  int iVar8;
  undefined8 *puVar9;
  uint *puVar10;
  ulonglong uVar11;
  uint uVar12;
  uint uVar13;
  undefined1 auStack_f8 [32];
  uint uStack_d8;
  uint uStack_d4;
  longlong lStack_d0;
  undefined8 uStack_c8;
  undefined8 uStack_c0;
  undefined1 auStack_b8 [8];
  longlong *plStack_b0;
  uint uStack_a8;
  uint uStack_a4;
  uint auStack_a0 [4];
  uint uStack_90;
  uint uStack_8c;
  uint auStack_88 [10];
  uint uStack_60;
  uint uStack_5c;
  uint auStack_58 [10];
  ulonglong uStack_30;
  
  uStack_30 = _DAT_141fd5040 ^ (ulonglong)auStack_f8;
  iVar8 = FUN_1410770a0(param_1,&uStack_60,8);
  if (iVar8 != 0) {
    return iVar8;
  }
  pcVar1 = (char *)(param_1 + 0x52);
  uVar12 = uStack_5c;
  if (*pcVar1 == '\0') {
    uVar12 = uStack_5c >> 0x18 | (uStack_5c & 0xff0000) >> 8 | (uStack_5c & 0xff00) << 8 |
             uStack_5c << 0x18;
  }
  puVar10 = auStack_58;
  uVar13 = 0x2c;
  if (uVar12 < 0x2c) {
    uVar13 = uVar12;
  }
  if (8 < uVar13) {
    uVar11 = (ulonglong)(uVar13 - 8);
    if (0xa00000 < uVar11) {
      return -0xd0;
    }
    iVar8 = FUN_1410770a0(param_1,auStack_58,uVar11);
    if (iVar8 != 0) {
      return iVar8;
    }
    puVar10 = (uint *)((longlong)auStack_58 + uVar11);
  }
  uVar11 = (ulonglong)uStack_5c;
  if ((uVar13 < 0x2c) && (puVar10 != (uint *)0x0)) {
    func_0x00014179cca0(puVar10,0,0x2c - uVar13);
    uVar11 = (ulonglong)uStack_5c;
  }
  if ((uVar13 < uVar12) && (iVar8 = itl_106a520(param_1,uVar12 - uVar13), iVar8 != 0)) {
    return iVar8;
  }
  if (*pcVar1 == '\0') {
    uStack_60 = (uStack_60 & 0xff0000 | uStack_60 >> 0x10) >> 8 |
                (uStack_60 & 0xff00 | uStack_60 << 0x10) << 8;
    uVar12 = (uint)uVar11;
    uStack_5c = (uVar12 & 0xff0000 | (uint)(uVar11 >> 0x10) & 0xffff) >> 8 |
                (uVar12 << 0x10 | uVar12 & 0xff00) << 8;
    auStack_58[0] =
         (auStack_58[0] & 0xff0000 | auStack_58[0] >> 0x10) >> 8 |
         (auStack_58[0] & 0xff00 | auStack_58[0] << 0x10) << 8;
  }
  if (uStack_60 != 0x68736c6d) {
    return -0xd0;
  }
  uStack_d4 = 0;
  if (auStack_58[0] == 0) {
    return 0;
  }
  do {
    iVar8 = FUN_1410770a0(param_1,&uStack_90,8);
    if (iVar8 != 0) {
      return iVar8;
    }
    uVar12 = uStack_8c;
    if (*pcVar1 == '\0') {
      uVar12 = (uStack_8c & 0xff0000 | uStack_8c >> 0x10) >> 8 |
               (uStack_8c << 0x10 | uStack_8c & 0xff00) << 8;
    }
    puVar10 = auStack_88;
    uVar13 = 0x30;
    if (uVar12 < 0x30) {
      uVar13 = uVar12;
    }
    if (8 < uVar13) {
      uVar11 = (ulonglong)(uVar13 - 8);
      if (0xa00000 < uVar11) {
        return -0xd0;
      }
      iVar8 = FUN_1410770a0(param_1,auStack_88,uVar11);
      if (iVar8 != 0) {
        return iVar8;
      }
      puVar10 = (uint *)((longlong)auStack_88 + uVar11);
    }
    uVar11 = (ulonglong)uStack_8c;
    if ((uVar13 < 0x30) && (puVar10 != (uint *)0x0)) {
      func_0x00014179cca0(puVar10,0,0x30 - uVar13);
      uVar11 = (ulonglong)uStack_8c;
    }
    if ((uVar13 < uVar12) && (iVar8 = itl_106a520(param_1,uVar12 - uVar13), iVar8 != 0)) {
      return iVar8;
    }
    if (*pcVar1 == '\0') {
      uStack_90 = (uStack_90 & 0xff0000 | uStack_90 >> 0x10) >> 8 |
                  (uStack_90 & 0xff00 | uStack_90 << 0x10) << 8;
      uVar12 = (uint)uVar11;
      uStack_8c = (uVar12 & 0xff0000 | (uint)(uVar11 >> 0x10) & 0xffff) >> 8 |
                  (uVar12 << 0x10 | uVar12 & 0xff00) << 8;
      auStack_88[0] =
           (auStack_88[0] & 0xff0000 | auStack_88[0] >> 0x10) >> 8 |
           (auStack_88[0] << 0x10 | auStack_88[0] & 0xff00) << 8;
      auStack_88[1] =
           (auStack_88[1] & 0xff0000 | auStack_88[1] >> 0x10) >> 8 |
           (auStack_88[1] << 0x10 | auStack_88[1] & 0xff00) << 8;
    }
    if (uStack_90 != 0x6870736d) {
      return -0xd0;
    }
    uStack_d8 = 0;
    if (auStack_88[1] != 0) {
      do {
        iVar8 = FUN_1410770a0(param_1,&uStack_a8,8);
        if (iVar8 != 0) {
          return iVar8;
        }
        uVar12 = uStack_a4;
        if (*pcVar1 == '\0') {
          uVar12 = (uStack_a4 & 0xff0000 | uStack_a4 >> 0x10) >> 8 |
                   (uStack_a4 << 0x10 | uStack_a4 & 0xff00) << 8;
        }
        puVar10 = auStack_a0;
        uVar13 = 0x18;
        if (uVar12 < 0x18) {
          uVar13 = uVar12;
        }
        if (8 < uVar13) {
          uVar11 = (ulonglong)(uVar13 - 8);
          if (0xa00000 < uVar11) {
            return -0xd0;
          }
          iVar8 = FUN_1410770a0(param_1,auStack_a0,uVar11);
          if (iVar8 != 0) {
            return iVar8;
          }
          puVar10 = (uint *)((longlong)auStack_a0 + uVar11);
        }
        uVar11 = (ulonglong)uStack_a4;
        if ((uVar13 < 0x18) && (puVar10 != (uint *)0x0)) {
          func_0x00014179cca0(puVar10,0,0x18 - uVar13);
          uVar11 = (ulonglong)uStack_a4;
        }
        if ((uVar13 < uVar12) && (iVar8 = itl_106a520(param_1,uVar12 - uVar13), iVar8 != 0)) {
          return iVar8;
        }
        uVar12 = (uint)uVar11;
        if (*pcVar1 == '\0') {
          uStack_a8 = (uStack_a8 & 0xff0000 | uStack_a8 >> 0x10) >> 8 |
                      (uStack_a8 << 0x10 | uStack_a8 & 0xff00) << 8;
          uVar12 = (uVar12 & 0xff0000 | (uint)(uVar11 >> 0x10) & 0xffff) >> 8 |
                   (uVar12 << 0x10 | uVar12 & 0xff00) << 8;
          auStack_a0[0] =
               (auStack_a0[0] & 0xff0000 | auStack_a0[0] >> 0x10) >> 8 |
               (auStack_a0[0] << 0x10 | auStack_a0[0] & 0xff00) << 8;
          auStack_a0[1] =
               (auStack_a0[1] & 0xff0000 | auStack_a0[1] >> 0x10) >> 8 |
               (auStack_a0[1] << 0x10 | auStack_a0[1] & 0xff00) << 8;
          auStack_a0[2] =
               (auStack_a0[2] & 0xff0000 | auStack_a0[2] >> 0x10) >> 8 |
               (auStack_a0[2] << 0x10 | auStack_a0[2] & 0xff00) << 8;
          uStack_a4 = uVar12;
        }
        if (uStack_a8 != 0x686f686d) {
          return -0xd0;
        }
        if (auStack_a0[1] == 800) {
          uStack_c8 = 0;
          uStack_c0 = 0;
          iVar8 = FUN_141077ee0(param_1,auStack_a0[0] - uVar12,&lStack_d0);
          lVar7 = lStack_d0;
          if (iVar8 != 0) {
            return iVar8;
          }
          puVar9 = (undefined8 *)
                   FUN_1410128e0(auStack_b8,*(undefined8 *)(param_1 + 0x1e00270),lStack_d0,0);
          plVar4 = plStack_b0;
          uStack_c8 = *puVar9;
          plVar5 = (longlong *)puVar9[1];
          *puVar9 = 0;
          puVar9[1] = 0;
          if (plStack_b0 != (longlong *)0x0) {
            LOCK();
            plVar2 = plStack_b0 + 1;
            lVar6 = *plVar2;
            *(int *)plVar2 = (int)*plVar2 + -1;
            UNLOCK();
            if ((int)lVar6 == 1) {
              (**(code **)*plStack_b0)(plStack_b0);
              LOCK();
              piVar3 = (int *)((longlong)plVar4 + 0xc);
              iVar8 = *piVar3;
              *piVar3 = *piVar3 + -1;
              UNLOCK();
              if (iVar8 == 1) {
                (**(code **)(*plVar4 + 8))(plVar4);
              }
            }
          }
          if (lVar7 != 0) {
            CFRelease(lVar7);
          }
          if (plVar5 != (longlong *)0x0) {
            LOCK();
            plVar4 = plVar5 + 1;
            lVar7 = *plVar4;
            *(int *)plVar4 = (int)*plVar4 + -1;
            UNLOCK();
            if ((int)lVar7 == 1) {
              (**(code **)*plVar5)(plVar5);
              LOCK();
              piVar3 = (int *)((longlong)plVar5 + 0xc);
              iVar8 = *piVar3;
              *piVar3 = *piVar3 + -1;
              UNLOCK();
              if (iVar8 == 1) {
                (**(code **)(*plVar5 + 8))(plVar5);
              }
            }
          }
        }
        else {
          uVar11 = (longlong)(int)(auStack_a0[0] - uVar12) + *(longlong *)(param_1 + 0x1e00170);
          *(ulonglong *)(param_1 + 0x1e00170) = uVar11;
          if ((uVar11 < *(ulonglong *)(param_1 + 0x1e00178)) ||
             (*(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180) <= uVar11)) {
            *(undefined8 *)(param_1 + 0x1e00180) = 0;
          }
        }
        uStack_d8 = uStack_d8 + 1;
      } while (uStack_d8 < auStack_88[1]);
    }
    uStack_d4 = uStack_d4 + 1;
    if (auStack_58[0] <= uStack_d4) {
      return 0;
    }
  } while( true );
}

