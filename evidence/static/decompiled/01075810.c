/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1075810; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

int FUN_141075810(undefined8 param_1,longlong param_2)

{
  undefined8 *puVar1;
  int iVar2;
  undefined4 uVar3;
  longlong lVar4;
  longlong lVar5;
  ulonglong uVar6;
  undefined8 uVar7;
  uint uVar8;
  uint uVar9;
  undefined1 auStack_128 [32];
  char acStack_108 [8];
  ulonglong uStack_100;
  longlong lStack_f8;
  undefined4 auStack_f0 [2];
  undefined8 uStack_e8;
  undefined8 uStack_e0;
  undefined8 uStack_d8;
  undefined8 uStack_d0;
  undefined8 uStack_c8;
  undefined8 uStack_c0;
  undefined8 uStack_b8;
  undefined8 uStack_b0;
  undefined8 uStack_a8;
  uint uStack_98;
  uint uStack_94;
  uint uStack_90;
  uint uStack_8c;
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
  
  uStack_38 = _DAT_141fd5040 ^ (ulonglong)auStack_128;
  uStack_a8 = 0;
  uStack_e8 = 0;
  uStack_e0 = 0;
  uStack_d8 = 0;
  uStack_d0 = 0;
  uStack_c8 = 0;
  uStack_c0 = 0;
  uStack_b8 = 0;
  uStack_b0 = 0;
  lVar4 = _aligned_malloc(0x1e00308,0x10);
  if (lVar4 == 0) {
    return -0x6c;
  }
  func_0x00014179cca0(lVar4,0,0x1e00308);
  *(undefined8 *)(lVar4 + 0x1e00270) = param_1;
  iVar2 = FUN_140ba0910(param_2,0);
  if (iVar2 != 0) goto LAB_141075f29;
  *(longlong *)(lVar4 + 0x120) = param_2;
  FUN_14106a430(lVar4);
  uVar3 = FUN_140bc83c0();
  *(undefined4 *)(lVar4 + 100) = uVar3;
  uStack_100 = 0x90;
  iVar2 = FUN_140ba04c0(param_2,&uStack_100,lVar4);
  if (iVar2 != 0) goto LAB_141075f29;
  uVar6 = 0;
  lStack_f8 = 0;
  if (*(char *)(param_2 + 5) == '\0') {
    iVar2 = FUN_140bd6640(*(undefined8 *)(param_2 + 8),&lStack_f8);
    if (iVar2 != 0) goto LAB_141075f29;
  }
  else {
    lStack_f8 = *(longlong *)(param_2 + 0x40);
  }
  if (*(char *)(param_2 + 5) == '\0') {
    lVar5 = *(longlong *)(param_2 + 0x20) - *(longlong *)(param_2 + 0x30);
  }
  else {
    lVar5 = (*(longlong *)(param_2 + 0x20) - *(longlong *)(param_2 + 0x38)) + -1;
  }
  lStack_f8 = lVar5 + lStack_f8;
  iVar2 = FUN_14106cba0(lVar4);
  lVar5 = _DAT_1420a6f30;
  if (iVar2 != 0) goto LAB_141075f29;
  *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
  iVar2 = FUN_14106cce0(lVar4,*(undefined8 *)(lVar5 + 0x14190));
  if (iVar2 != 0) goto LAB_141075f29;
  *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
  iVar2 = FUN_14106bcf0(lVar4,param_1,lVar4 + 0x4c);
  if (iVar2 != 0) goto LAB_141075f29;
  *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
  iVar2 = FUN_14106c500(lVar4,param_1,lVar4 + 0x54);
  if (iVar2 != 0) goto LAB_141075f29;
  *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
  iVar2 = FUN_141070370(lVar4,param_1,1,lVar4 + 0x44);
  if (iVar2 != 0) goto LAB_141075f29;
  *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
  iVar2 = FUN_141070370(lVar4,param_1,0xd,&uStack_100);
  if (iVar2 != 0) goto LAB_141075f29;
  *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
  iVar2 = FUN_141074060(lVar4,acStack_108);
  if (iVar2 != 0) goto LAB_141075f29;
  if (acStack_108[0] != '\0') {
    *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
  }
  iVar2 = FUN_141075000(lVar4,acStack_108);
  if (iVar2 != 0) goto LAB_141075f29;
  if (acStack_108[0] != '\0') {
    *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
  }
  iVar2 = FUN_1410725a0(lVar4,2,0,0);
  if (iVar2 != 0) goto LAB_141075f29;
  *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
  iVar2 = FUN_1410725a0(lVar4,0xe,0,0);
  if (iVar2 != 0) goto LAB_141075f29;
  *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
  acStack_108[0] = '\0';
  lVar5 = *(longlong *)(_DAT_1420a6f30 + 0x166e8);
  uVar9 = 0;
  if ((lVar5 != 0) && ((*(byte *)(*(longlong *)(lVar4 + 0x1e00270) + 0x110) & 1) != 0)) {
    uStack_98 = 0x6864736d;
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
    uStack_94 = 0x60;
    uStack_8c = 3;
    uStack_90 = uVar9;
    if (*(int *)(lVar5 + 8) == 0x4d656d48) {
      uStack_90 = *(uint *)(lVar5 + 0x10);
    }
    uStack_90 = uStack_90 + 0x60;
    if (*(char *)(lVar4 + 0x52) == '\0') {
      uStack_90 = uStack_90 >> 0x18 | (uStack_90 & 0xff0000) >> 8 | (uStack_90 & 0xff00) << 8 |
                  uStack_90 * 0x1000000;
      uStack_98 = 0x6d736468;
      uStack_94 = 0x60000000;
      uStack_8c = 0x3000000;
    }
    uStack_100 = 0x60;
    iVar2 = FUN_140ba04c0(*(undefined8 *)(lVar4 + 0x120),&uStack_100,&uStack_98);
    if (iVar2 != 0) goto LAB_141075f29;
    puVar1 = *(undefined8 **)(_DAT_1420a6f30 + 0x166e8);
    if ((puVar1 == (undefined8 *)0x0) || (*(int *)(puVar1 + 1) != 0x4d656d48)) {
      uVar8 = uVar9;
      if ((puVar1 == (undefined8 *)0x0) || (*(int *)(puVar1 + 1) != 0x4d656d48)) {
        uVar7 = 0;
      }
      else {
        uVar7 = *puVar1;
      }
    }
    else {
      uVar7 = *puVar1;
      uVar8 = *(uint *)(puVar1 + 2);
    }
    uStack_100 = (ulonglong)uVar8;
    iVar2 = FUN_140ba04c0(*(undefined8 *)(lVar4 + 0x120),&uStack_100,uVar7);
    if (iVar2 != 0) goto LAB_141075f29;
    *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
  }
  acStack_108[0] = '\0';
  lVar5 = *(longlong *)(_DAT_1420a6f30 + 0x166f0);
  if ((lVar5 != 0) && ((*(byte *)(*(longlong *)(lVar4 + 0x1e00270) + 0x110) & 1) != 0)) {
    uStack_98 = 0x6864736d;
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
    uStack_94 = 0x60;
    uStack_8c = 10;
    if (*(int *)(lVar5 + 8) == 0x4d656d48) {
      uVar9 = *(uint *)(lVar5 + 0x10);
    }
    uStack_90 = uVar9 + 0x60;
    if (*(char *)(lVar4 + 0x52) == '\0') {
      uStack_90 = uStack_90 >> 0x18 | (uStack_90 & 0xff0000) >> 8 | (uStack_90 & 0xff00) << 8 |
                  uStack_90 * 0x1000000;
      uStack_98 = 0x6d736468;
      uStack_94 = 0x60000000;
      uStack_8c = 0xa000000;
    }
    uStack_100 = 0x60;
    iVar2 = FUN_140ba04c0(*(undefined8 *)(lVar4 + 0x120),&uStack_100,&uStack_98);
    if (iVar2 != 0) goto LAB_141075f29;
    puVar1 = *(undefined8 **)(_DAT_1420a6f30 + 0x166f0);
    if (puVar1 == (undefined8 *)0x0) {
LAB_141075c77:
      uVar7 = 0;
    }
    else if (*(int *)(puVar1 + 1) == 0x4d656d48) {
      uVar6 = (ulonglong)*(uint *)(puVar1 + 2);
      uVar7 = *puVar1;
    }
    else {
      if ((puVar1 == (undefined8 *)0x0) || (*(int *)(puVar1 + 1) != 0x4d656d48)) goto LAB_141075c77;
      uVar7 = *puVar1;
    }
    uStack_100 = uVar6;
    iVar2 = FUN_140ba04c0(*(undefined8 *)(lVar4 + 0x120),&uStack_100,uVar7);
    if (iVar2 != 0) goto LAB_141075f29;
    *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
  }
  lVar5 = _DAT_1420a4f60;
  acStack_108[0] = '\0';
  if (((*(byte *)(*(longlong *)(lVar4 + 0x1e00270) + 0x110) & 1) != 0) && (_DAT_1420a4f60 != 0)) {
    uStack_98 = 0x6864736d;
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
    uStack_94 = 0x60;
    uStack_8c = 0x16;
    iVar2 = CFDataGetLength(_DAT_1420a4f60);
    uStack_90 = iVar2 + 0x60;
    if (*(char *)(lVar4 + 0x52) == '\0') {
      uStack_98 = (uStack_98 & 0xff0000 | uStack_98 >> 0x10) >> 8 |
                  (uStack_98 << 0x10 | uStack_98 & 0xff00) << 8;
      uStack_94 = (uStack_94 & 0xff0000 | uStack_94 >> 0x10) >> 8 |
                  (uStack_94 << 0x10 | uStack_94 & 0xff00) << 8;
      uStack_8c = (uStack_8c & 0xff0000 | uStack_8c >> 0x10) >> 8 |
                  (uStack_8c << 0x10 | uStack_8c & 0xff00) << 8;
      uStack_90 = uStack_90 >> 0x18 | (uStack_90 & 0xff0000) >> 8 | (uStack_90 & 0xff00) << 8 |
                  uStack_90 * 0x1000000;
    }
    uStack_100 = 0x60;
    iVar2 = FUN_140ba04c0(*(undefined8 *)(lVar4 + 0x120),&uStack_100,&uStack_98);
    if (iVar2 != 0) goto LAB_141075f29;
    uVar6 = CFDataGetLength(lVar5);
    uVar7 = CFDataGetBytePtr(lVar5);
    uStack_100 = uVar6;
    iVar2 = FUN_140ba04c0(*(undefined8 *)(lVar4 + 0x120),&uStack_100,uVar7);
    if (iVar2 != 0) goto LAB_141075f29;
    *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
    acStack_108[0] = '\x01';
  }
  iVar2 = FUN_141072aa0(lVar4,acStack_108);
  if (iVar2 == 0) {
    if (acStack_108[0] != '\0') {
      *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
    }
    iVar2 = FUN_141073040(lVar4,acStack_108);
    if (iVar2 == 0) {
      if (acStack_108[0] != '\0') {
        *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
      }
      iVar2 = FUN_141073490(lVar4);
      if (iVar2 == 0) {
        *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
        iVar2 = FUN_141073680(lVar4,acStack_108);
        if (iVar2 == 0) {
          if (acStack_108[0] != '\0') {
            *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
          }
          iVar2 = FUN_141073bb0(lVar4,acStack_108);
          if (iVar2 == 0) {
            if (acStack_108[0] != '\0') {
              *(int *)(lVar4 + 0x30) = *(int *)(lVar4 + 0x30) + 1;
            }
            iVar2 = FUN_140ba0000(*(undefined8 *)(lVar4 + 0x120));
            if ((iVar2 == 0) && (iVar2 = FUN_140ba0890(param_2,auStack_f0), iVar2 == 0)) {
              *(undefined4 *)(lVar4 + 8) = auStack_f0[0];
              iVar2 = FUN_140ba09a0(param_2,lStack_f8);
              if ((iVar2 == 0) &&
                 ((iVar2 = FUN_14106cba0(lVar4), iVar2 == 0 &&
                  (iVar2 = FUN_140ba09a0(param_2,0), iVar2 == 0)))) {
                itl_1068f90(lVar4);
                uStack_100 = 0x90;
                iVar2 = FUN_140ba04c0(param_2,&uStack_100,lVar4);
                if (iVar2 == 0) {
                  iVar2 = FUN_140ba0000(param_2);
                }
              }
            }
          }
        }
      }
    }
  }
LAB_141075f29:
  _aligned_free(lVar4);
  return iVar2;
}

