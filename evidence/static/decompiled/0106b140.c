/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x106b140; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined8 FUN_14106b140(longlong param_1,longlong param_2,uint param_3,longlong *param_4)

{
  uint uVar1;
  uint *puVar2;
  longlong lVar3;
  longlong lVar4;
  longlong lVar5;
  longlong lVar6;
  longlong lVar7;
  undefined8 uVar8;
  uint uVar9;
  longlong lVar10;
  longlong lStack_28;
  longlong lStack_20;
  
  puVar2 = (uint *)*param_4;
  lVar10 = 0;
  if (puVar2 != (uint *)0x0) {
    puVar2[2] = 0;
    puVar2[4] = 0;
    puVar2[5] = 0;
  }
  *puVar2 = 0x686f686d;
  puVar2[1] = 0x18;
  puVar2[3] = param_3;
  if ((param_2 == 0) || (lVar3 = CFPropertyListCreateXMLData(_DAT_1420a6090), lVar3 == 0)) {
    uVar8 = 0xffffffce;
  }
  else {
    lVar4 = CFDataGetLength(lVar3);
    lVar5 = CFDataGetLength(lVar3);
    lStack_20 = lVar4;
    if (lVar4 != 0) {
      lVar6 = lVar10;
      if (-1 < lVar4) {
        lVar6 = lVar4;
      }
      lVar7 = lVar5 + -1;
      lStack_20 = lVar10;
      if (0 < lVar5) {
        lVar7 = lVar10;
        lStack_20 = lVar6;
      }
      lVar10 = lVar7;
      if ((lVar5 < lVar7 + lStack_20) && (lStack_20 = 1, 0 < lVar5)) {
        lStack_20 = lVar5;
      }
    }
    lStack_28 = lVar10;
    CFDataGetBytes(lVar3,&lStack_28,puVar2 + 6);
    lVar4 = lVar4 + (longlong)(puVar2 + 6);
    *param_4 = lVar4;
    uVar9 = (int)lVar4 - (int)puVar2;
    puVar2[2] = uVar9;
    if (*(char *)(param_1 + 0x52) == '\0') {
      uVar1 = *puVar2;
      *puVar2 = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
      uVar1 = puVar2[1];
      puVar2[1] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
      puVar2[2] = uVar9 >> 0x18 | (uVar9 & 0xff0000) >> 8 | (uVar9 & 0xff00) << 8 |
                  uVar9 * 0x1000000;
      uVar9 = puVar2[3];
      puVar2[3] = uVar9 >> 0x18 | (uVar9 & 0xff0000) >> 8 | (uVar9 & 0xff00) << 8 | uVar9 << 0x18;
      uVar9 = puVar2[4];
      puVar2[4] = uVar9 >> 0x18 | (uVar9 & 0xff0000) >> 8 | (uVar9 & 0xff00) << 8 | uVar9 << 0x18;
    }
    CFRelease(lVar3);
    uVar8 = 0;
  }
  return uVar8;
}

