/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1081790; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

int FUN_141081790(undefined8 param_1,undefined8 param_2,undefined8 param_3)

{
  uint uVar1;
  int iVar2;
  longlong lVar3;
  uint *puVar4;
  uint uVar5;
  ulonglong uVar6;
  undefined1 auStack_a8 [32];
  uint uStack_88;
  uint uStack_84;
  uint auStack_80 [22];
  ulonglong uStack_28;
  
  uStack_28 = _DAT_141fd5040 ^ (ulonglong)auStack_a8;
  lVar3 = _aligned_malloc(0x1e00308,0x10);
  if (lVar3 == 0) {
    return -0x6c;
  }
  func_0x00014179cca0(lVar3,0,0x120);
  func_0x00014179cca0(lVar3 + 0x128,0,0x1e00038);
  func_0x00014179cca0(lVar3 + 0x1e00170,0,0x100);
  *(undefined8 *)(lVar3 + 0x1e00278) = 0;
  *(undefined8 *)(lVar3 + 0x1e00280) = 0;
  *(undefined8 *)(lVar3 + 0x1e00288) = 0;
  *(undefined8 *)(lVar3 + 0x1e00290) = 0;
  *(undefined8 *)(lVar3 + 0x1e00298) = 0;
  *(undefined8 *)(lVar3 + 0x1e002a0) = 0;
  *(undefined8 *)(lVar3 + 0x1e002a8) = 0;
  *(undefined8 *)(lVar3 + 0x1e002b0) = 0;
  *(undefined8 *)(lVar3 + 0x1e002b8) = 0;
  *(undefined8 *)(lVar3 + 0x1e002c0) = 0;
  *(undefined8 *)(lVar3 + 0x1e002c8) = 0;
  *(undefined8 *)(lVar3 + 0x1e002d0) = 0;
  *(undefined8 *)(lVar3 + 0x1e002d8) = 0;
  *(undefined8 *)(lVar3 + 0x1e002e0) = 0;
  *(undefined8 *)(lVar3 + 0x1e002e8) = 0;
  *(undefined8 *)(lVar3 + 0x1e002f0) = 0;
  *(undefined8 *)(lVar3 + 0x1e002f8) = 0;
  *(undefined8 *)(lVar3 + 0x1e00300) = 0;
  *(undefined8 *)(lVar3 + 0x1e00270) = param_1;
  *(undefined8 *)(lVar3 + 0x120) = param_3;
  *(undefined8 *)(lVar3 + 0x1e00160) = 0xffffffffffffffff;
  *(undefined8 *)(lVar3 + 0x1e00168) = 0xffffffffffffffff;
  FUN_14106a430(lVar3);
  *(undefined1 *)(lVar3 + 0x41) = 0;
  iVar2 = FUN_1410770a0(lVar3,&uStack_88,8);
  if (iVar2 != 0) goto LAB_141081a42;
  uVar5 = uStack_84;
  if (*(char *)(lVar3 + 0x52) == '\0') {
    uVar5 = uStack_84 >> 0x18 | (uStack_84 & 0xff0000) >> 8 | (uStack_84 & 0xff00) << 8 |
            uStack_84 << 0x18;
  }
  puVar4 = auStack_80;
  uVar1 = 0x60;
  if (uVar5 < 0x60) {
    uVar1 = uVar5;
  }
  if (uVar1 < 9) {
LAB_14108190e:
    uVar6 = (ulonglong)uStack_84;
    if ((uVar1 < 0x60) && (puVar4 != (uint *)0x0)) {
      func_0x00014179cca0(puVar4,0,0x60 - uVar1);
      uVar6 = (ulonglong)uStack_84;
    }
    if ((uVar1 < uVar5) && (iVar2 = itl_106a520(lVar3,uVar5 - uVar1), iVar2 != 0))
    goto LAB_141081a42;
    if (*(char *)(lVar3 + 0x52) == '\0') {
      uVar5 = (uint)uVar6;
      uStack_88 = (uStack_88 & 0xff0000 | uStack_88 >> 0x10) >> 8 |
                  (uStack_88 & 0xff00 | uStack_88 << 0x10) << 8;
      uStack_84 = (uVar5 & 0xff0000 | (uint)(uVar6 >> 0x10) & 0xffff) >> 8 |
                  (uVar5 << 0x10 | uVar5 & 0xff00) << 8;
      auStack_80[0] =
           (auStack_80[0] & 0xff0000 | auStack_80[0] >> 0x10) >> 8 |
           (auStack_80[0] << 0x10 | auStack_80[0] & 0xff00) << 8;
      auStack_80[1] =
           (auStack_80[1] & 0xff0000 | auStack_80[1] >> 0x10) >> 8 |
           (auStack_80[1] << 0x10 | auStack_80[1] & 0xff00) << 8;
    }
    if (uStack_88 == 0x6864736d) {
      iVar2 = FUN_14107ee90(lVar3,0x80000000);
      goto LAB_141081a42;
    }
  }
  else {
    uVar6 = (ulonglong)(uVar1 - 8);
    if (uVar6 < 0xa00001) {
      iVar2 = FUN_1410770a0(lVar3,auStack_80,uVar6);
      if (iVar2 != 0) goto LAB_141081a42;
      puVar4 = (uint *)((longlong)auStack_80 + uVar6);
      goto LAB_14108190e;
    }
  }
  iVar2 = -0xd0;
LAB_141081a42:
  _aligned_free(lVar3);
  return iVar2;
}

