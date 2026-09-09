/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xbf9710; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_140bf9710(void)

{
  longlong lVar1;
  byte bVar2;
  ulonglong uVar3;
  longlong lVar4;
  longlong lVar5;
  uint uVar6;
  byte *pbVar7;
  uint uVar8;
  uint uVar9;
  
  uVar3 = 1;
  pbVar7 = (byte *)0x1420d2d20;
  uVar6 = 0;
  lVar4 = 0x100;
  do {
    bVar2 = (byte)uVar3;
    *pbVar7 = bVar2;
    pbVar7 = pbVar7 + 1;
    *(char *)(uVar3 + 0x1420d2e20) = (char)uVar6;
    uVar6 = uVar6 + 1;
    uVar3 = (ulonglong)(byte)(bVar2 ^ (char)bVar2 >> 7 & 0x1bU ^ bVar2 * '\x02');
  } while (uVar6 < 0x100);
  DAT_1420d2e21 = 0;
  _DAT_1420d3120 = 1;
  uVar3 = 0;
  _DAT_1420d3124 = 2;
  _DAT_1420d3128 = 4;
  _DAT_1420d312c = 8;
  _DAT_1420d3130 = 0x10;
  _DAT_1420d3134 = 0x20;
  _DAT_1420d3138 = 0x40;
  _DAT_1420d313c = 0x80;
  _DAT_1420d3140 = 0x1b;
  _DAT_1420d3144 = 0x36;
  do {
    if ((int)uVar3 == 0) {
      bVar2 = 0;
    }
    else {
      bVar2 = *(byte *)(0x1420d2e1f - (ulonglong)*(byte *)(uVar3 + 0x1420d2e20));
    }
    bVar2 = (bVar2 >> 6 | bVar2 << 2) ^ (bVar2 >> 5 | bVar2 << 3) ^ (bVar2 >> 4 | bVar2 << 4) ^
            bVar2 ^ (bVar2 >> 7 | bVar2 << 1) ^ 99;
    *(byte *)(uVar3 + 0x1420d2f20) = bVar2;
    *(char *)((ulonglong)bVar2 + 0x1420d3020) = (char)uVar3;
    uVar6 = (int)uVar3 + 1;
    uVar3 = (ulonglong)uVar6;
  } while (uVar6 < 0x100);
  lVar1 = 0;
  lVar5 = 0;
  do {
    bVar2 = *(byte *)(lVar5 + 0x1420d2f20);
    *(uint *)(lVar1 + 0x1420d5150) = (uint)bVar2;
    *(uint *)(lVar1 + 0x1420d5550) = (uint)bVar2 << 8;
    *(uint *)(lVar1 + 0x1420d5950) = (uint)bVar2 << 0x10;
    uVar6 = (uint)CONCAT11(bVar2,bVar2) << 8;
    *(uint *)(lVar1 + 0x1420d5d50) = (uint)bVar2 << 0x18;
    if (bVar2 == 0) {
      uVar9 = 0;
    }
    else {
      uVar9 = (uint)*(byte *)((longlong)
                              (int)(((uint)*(byte *)((ulonglong)bVar2 + 0x1420d2e20) +
                                    (uint)DAT_1420d2e23) % 0xff) + 0x1420d2d20);
      uVar6 = (uint)CONCAT21(CONCAT11(bVar2,bVar2),
                             *(undefined1 *)
                              ((longlong)
                               (int)(((uint)*(byte *)((ulonglong)bVar2 + 0x1420d2e20) +
                                     (uint)DAT_1420d2e22) % 0xff) + 0x1420d2d20));
    }
    uVar8 = uVar9 << 0x18 | uVar6;
    *(uint *)(lVar1 + 0x1420d3150) = uVar8;
    *(uint *)(lVar1 + 0x1420d3550) = uVar6 << 8 | uVar9;
    *(uint *)(lVar1 + 0x1420d3950) = uVar6 << 0x10 | uVar8 >> 0x10;
    *(uint *)(lVar1 + 0x1420d3d50) = uVar6 << 0x18 | uVar8 >> 8;
    bVar2 = *(byte *)(lVar5 + 0x1420d3020);
    uVar3 = (ulonglong)bVar2;
    *(uint *)(lVar1 + 0x1420d6150) = (uint)bVar2;
    *(uint *)(lVar1 + 0x1420d6550) = (uint)bVar2 << 8;
    *(uint *)(lVar1 + 0x1420d6950) = (uint)bVar2 << 0x10;
    *(uint *)(lVar1 + 0x1420d6d50) = (uint)bVar2 << 0x18;
    if (bVar2 == 0) {
      uVar9 = 0;
      uVar6 = 0;
    }
    else {
      uVar9 = (uint)*(byte *)((longlong)
                              (int)(((uint)*(byte *)(uVar3 + 0x1420d2e20) + (uint)DAT_1420d2e2b) %
                                   0xff) + 0x1420d2d20);
      uVar6 = (uint)CONCAT21(CONCAT11(*(undefined1 *)
                                       ((longlong)
                                        (int)(((uint)*(byte *)(uVar3 + 0x1420d2e20) +
                                              (uint)DAT_1420d2e2d) % 0xff) + 0x1420d2d20),
                                      *(undefined1 *)
                                       ((longlong)
                                        (int)(((uint)DAT_1420d2e29 +
                                              (uint)*(byte *)(uVar3 + 0x1420d2e20)) % 0xff) +
                                       0x1420d2d20)),
                             *(undefined1 *)
                              ((longlong)
                               (int)(((uint)DAT_1420d2e2e + (uint)*(byte *)(uVar3 + 0x1420d2e20)) %
                                    0xff) + 0x1420d2d20));
    }
    lVar5 = lVar5 + 1;
    uVar8 = uVar9 << 0x18 | uVar6;
    *(uint *)(lVar1 + 0x1420d4150) = uVar8;
    *(uint *)(lVar1 + 0x1420d4550) = uVar6 << 8 | uVar9;
    *(uint *)(lVar1 + 0x1420d4950) = uVar6 << 0x10 | uVar8 >> 0x10;
    *(uint *)(lVar1 + 0x1420d4d50) = uVar6 << 0x18 | uVar8 >> 8;
    lVar1 = lVar1 + 4;
    lVar4 = lVar4 + -1;
  } while (lVar4 != 0);
  return;
}

