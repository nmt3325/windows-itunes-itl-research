/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xbf9a90; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_140bf9a90(undefined8 param_1,int *param_2,undefined8 param_3,int *param_4)

{
  int iVar1;
  longlong lVar2;
  uint *puVar3;
  uint uVar4;
  uint uVar5;
  uint uVar6;
  uint uVar7;
  uint uVar8;
  uint uVar9;
  uint uVar10;
  ulonglong uVar11;
  uint uVar12;
  
  *param_4 = 4;
  uVar4 = 0;
  param_4[7] = 0;
  param_4[8] = 0;
  param_4[5] = 0;
  param_4[6] = 0;
  param_4[1] = *param_2;
  param_4[2] = param_2[1];
  param_4[3] = param_2[2];
  uVar12 = param_2[3];
  param_4[4] = uVar12;
  lVar2 = _DAT_1420d2d08;
  iVar1 = *param_4;
  if (iVar1 == 4) {
    puVar3 = _DAT_1420d2cf0 + 2;
    do {
      uVar10 = uVar4 * 4;
      uVar6 = *(uint *)(lVar2 + 0xc00 + (ulonglong)(uVar12 & 0xff) * 4) ^
              *(uint *)(lVar2 + 0x800 + (ulonglong)(uVar12 >> 0x18) * 4) ^
              *(uint *)(lVar2 + 0x400 + (ulonglong)((uVar12 >> 8 & 0xff00) >> 8) * 4) ^
              param_4[(ulonglong)uVar10 + 1] ^
              *(uint *)(lVar2 + (ulonglong)(uVar12 >> 8 & 0xff) * 4) ^ puVar3[-2];
      param_4[(ulonglong)(uVar10 + 4) + 1] = uVar6;
      uVar12 = uVar6 ^ param_4[(ulonglong)(uVar10 + 1) + 1];
      param_4[(ulonglong)(uVar10 + 5) + 1] = uVar12;
      uVar9 = uVar12 ^ param_4[(ulonglong)(uVar10 + 2) + 1];
      param_4[(ulonglong)(uVar10 + 6) + 1] = uVar9;
      uVar8 = uVar9 ^ param_4[(ulonglong)(uVar10 + 3) + 1];
      param_4[(ulonglong)(uVar10 + 7) + 1] = uVar8;
      uVar6 = *(uint *)(lVar2 + 0xc00 + (ulonglong)(uVar8 & 0xff) * 4) ^
              *(uint *)(lVar2 + 0x800 + (ulonglong)(uVar8 >> 0x18) * 4) ^
              *(uint *)(lVar2 + 0x400 + (ulonglong)((uVar8 >> 8 & 0xff00) >> 8) * 4) ^
              *(uint *)(lVar2 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^ puVar3[-1] ^ uVar6;
      param_4[(ulonglong)(uVar4 * 4 + 8) + 1] = uVar6;
      uVar12 = uVar6 ^ uVar12;
      param_4[(ulonglong)(uVar10 + 9) + 1] = uVar12;
      uVar9 = uVar12 ^ uVar9;
      param_4[(ulonglong)(uVar10 + 10) + 1] = uVar9;
      uVar8 = uVar9 ^ uVar8;
      param_4[(ulonglong)(uVar10 + 0xb) + 1] = uVar8;
      uVar6 = *(uint *)(lVar2 + 0xc00 + (ulonglong)(uVar8 & 0xff) * 4) ^
              *(uint *)(lVar2 + 0x800 + (ulonglong)(uVar8 >> 0x18) * 4) ^
              *(uint *)(lVar2 + 0x400 + (ulonglong)((uVar8 >> 8 & 0xff00) >> 8) * 4) ^
              *(uint *)(lVar2 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^ uVar6 ^ *puVar3;
      param_4[(ulonglong)(uVar4 * 4 + 0xc) + 1] = uVar6;
      uVar12 = uVar6 ^ uVar12;
      param_4[(ulonglong)(uVar10 + 0xd) + 1] = uVar12;
      uVar9 = uVar12 ^ uVar9;
      param_4[(ulonglong)(uVar10 + 0xe) + 1] = uVar9;
      uVar8 = uVar9 ^ uVar8;
      param_4[(ulonglong)(uVar10 + 0xf) + 1] = uVar8;
      uVar6 = *(uint *)(lVar2 + 0xc00 + (ulonglong)(uVar8 & 0xff) * 4) ^
              *(uint *)(lVar2 + 0x800 + (ulonglong)(uVar8 >> 0x18) * 4) ^
              *(uint *)(lVar2 + 0x400 + (ulonglong)((uVar8 >> 8 & 0xff00) >> 8) * 4) ^
              *(uint *)(lVar2 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^ puVar3[1] ^ uVar6;
      param_4[(ulonglong)(uVar4 * 4 + 0x10) + 1] = uVar6;
      uVar12 = uVar12 ^ uVar6;
      param_4[(ulonglong)(uVar10 + 0x11) + 1] = uVar12;
      uVar9 = uVar12 ^ uVar9;
      uVar8 = uVar8 ^ uVar9;
      param_4[(ulonglong)(uVar10 + 0x12) + 1] = uVar9;
      param_4[(ulonglong)(uVar10 + 0x13) + 1] = uVar8;
      iVar1 = uVar4 * 4;
      uVar4 = uVar4 + 5;
      uVar6 = *(uint *)(lVar2 + 0xc00 + (ulonglong)(uVar8 & 0xff) * 4) ^
              *(uint *)(lVar2 + 0x800 + (ulonglong)(uVar8 >> 0x18) * 4) ^
              *(uint *)(lVar2 + 0x400 + (ulonglong)((uVar8 >> 8 & 0xff00) >> 8) * 4) ^
              *(uint *)(lVar2 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^ puVar3[2] ^ uVar6;
      uVar12 = uVar12 ^ uVar6;
      param_4[(ulonglong)(iVar1 + 0x14) + 1] = uVar6;
      param_4[(ulonglong)(uVar10 + 0x15) + 1] = uVar12;
      uVar12 = uVar12 ^ uVar9;
      param_4[(ulonglong)(uVar10 + 0x16) + 1] = uVar12;
      uVar12 = uVar12 ^ uVar8;
      param_4[(ulonglong)(uVar10 + 0x17) + 1] = uVar12;
      puVar3 = puVar3 + 5;
    } while (uVar4 < 10);
  }
  else if (iVar1 == 6) {
    puVar3 = _DAT_1420d2cf0 + 2;
    uVar12 = uVar4;
    do {
      uVar6 = uVar4 * 6;
      uVar8 = *(uint *)(lVar2 + 0xc00 + (ulonglong)(uVar12 & 0xff) * 4) ^
              *(uint *)(lVar2 + 0x800 + (ulonglong)(uVar12 >> 0x18) * 4) ^
              *(uint *)(lVar2 + 0x400 + (ulonglong)((uVar12 >> 8 & 0xff00) >> 8) * 4) ^
              *(uint *)(lVar2 + (ulonglong)(uVar12 >> 8 & 0xff) * 4) ^ param_4[(ulonglong)uVar6 + 1]
              ^ puVar3[-2];
      param_4[(ulonglong)(uVar6 + 6) + 1] = uVar8;
      uVar10 = uVar8 ^ param_4[(ulonglong)(uVar6 + 1) + 1];
      param_4[(ulonglong)(uVar6 + 7) + 1] = uVar10;
      uVar9 = uVar10 ^ param_4[(ulonglong)(uVar6 + 2) + 1];
      param_4[(ulonglong)(uVar6 + 8) + 1] = uVar9;
      uVar12 = uVar9 ^ param_4[(ulonglong)(uVar6 + 3) + 1];
      param_4[(ulonglong)(uVar6 + 9) + 1] = uVar12;
      uVar7 = uVar12 ^ param_4[(ulonglong)(uVar6 + 4) + 1];
      param_4[(ulonglong)(uVar6 + 10) + 1] = uVar7;
      uVar5 = uVar7 ^ param_4[(ulonglong)(uVar6 + 5) + 1];
      param_4[(ulonglong)(uVar6 + 0xb) + 1] = uVar5;
      uVar8 = *(uint *)(lVar2 + 0xc00 + (ulonglong)(uVar5 & 0xff) * 4) ^
              *(uint *)(lVar2 + 0x800 + (ulonglong)(uVar5 >> 0x18) * 4) ^
              *(uint *)(lVar2 + 0x400 + (ulonglong)((uVar5 >> 8 & 0xff00) >> 8) * 4) ^
              *(uint *)(lVar2 + (ulonglong)(uVar5 >> 8 & 0xff) * 4) ^ puVar3[-1] ^ uVar8;
      uVar10 = uVar10 ^ uVar8;
      uVar9 = uVar10 ^ uVar9;
      param_4[(ulonglong)(uVar6 + 0xd) + 1] = uVar10;
      uVar12 = uVar9 ^ uVar12;
      param_4[(ulonglong)(uVar6 + 0xe) + 1] = uVar9;
      param_4[(ulonglong)(uVar6 + 0xf) + 1] = uVar12;
      uVar7 = uVar12 ^ uVar7;
      param_4[(ulonglong)((uVar4 + 2) * 6) + 1] = uVar8;
      param_4[(ulonglong)(uVar6 + 0x10) + 1] = uVar7;
      uVar5 = uVar7 ^ uVar5;
      param_4[(ulonglong)(uVar6 + 0x11) + 1] = uVar5;
      uVar8 = *(uint *)(lVar2 + 0xc00 + (ulonglong)(uVar5 & 0xff) * 4) ^
              *(uint *)(lVar2 + 0x800 + (ulonglong)(uVar5 >> 0x18) * 4) ^
              *(uint *)(lVar2 + 0x400 + (ulonglong)((uVar5 >> 8 & 0xff00) >> 8) * 4) ^
              *(uint *)(lVar2 + (ulonglong)(uVar5 >> 8 & 0xff) * 4) ^ *puVar3 ^ uVar8;
      uVar10 = uVar10 ^ uVar8;
      uVar9 = uVar9 ^ uVar10;
      uVar12 = uVar12 ^ uVar9;
      param_4[(ulonglong)((uVar4 + 3) * 6) + 1] = uVar8;
      uVar7 = uVar7 ^ uVar12;
      uVar5 = uVar5 ^ uVar7;
      param_4[(ulonglong)(uVar6 + 0x13) + 1] = uVar10;
      param_4[(ulonglong)(uVar6 + 0x14) + 1] = uVar9;
      param_4[(ulonglong)(uVar6 + 0x15) + 1] = uVar12;
      param_4[(ulonglong)(uVar6 + 0x16) + 1] = uVar7;
      param_4[(ulonglong)(uVar6 + 0x17) + 1] = uVar5;
      uVar8 = *(uint *)(lVar2 + 0xc00 + (ulonglong)(uVar5 & 0xff) * 4) ^
              *(uint *)(lVar2 + 0x800 + (ulonglong)(uVar5 >> 0x18) * 4) ^
              *(uint *)(lVar2 + 0x400 + (ulonglong)((uVar5 >> 8 & 0xff00) >> 8) * 4) ^
              *(uint *)(lVar2 + (ulonglong)(uVar5 >> 8 & 0xff) * 4) ^ puVar3[1] ^ uVar8;
      uVar10 = uVar10 ^ uVar8;
      param_4[(ulonglong)(uVar6 + 0x19) + 1] = uVar10;
      uVar9 = uVar9 ^ uVar10;
      uVar12 = uVar12 ^ uVar9;
      param_4[(ulonglong)(uVar6 + 0x1a) + 1] = uVar9;
      param_4[(ulonglong)(uVar6 + 0x1b) + 1] = uVar12;
      uVar12 = uVar12 ^ uVar7;
      param_4[(ulonglong)(uVar6 + 0x1c) + 1] = uVar12;
      uVar12 = uVar12 ^ uVar5;
      param_4[(ulonglong)((uVar4 + 4) * 6) + 1] = uVar8;
      param_4[(ulonglong)(uVar6 + 0x1d) + 1] = uVar12;
      uVar4 = uVar4 + 4;
      puVar3 = puVar3 + 4;
    } while (uVar4 < 8);
  }
  else {
    puVar3 = _DAT_1420d2cf0;
    uVar12 = uVar4;
    if (iVar1 == 8) {
      do {
        uVar6 = uVar12 * 8;
        uVar12 = uVar12 + 1;
        uVar4 = *(uint *)(lVar2 + 0xc00 + (ulonglong)(uVar4 & 0xff) * 4) ^
                *(uint *)(lVar2 + 0x800 + (ulonglong)(uVar4 >> 0x18) * 4) ^
                *(uint *)(lVar2 + 0x400 + (ulonglong)((uVar4 >> 8 & 0xff00) >> 8) * 4) ^
                *(uint *)(lVar2 + (ulonglong)(uVar4 >> 8 & 0xff) * 4) ^
                param_4[(ulonglong)uVar6 + 1] ^ *puVar3;
        param_4[(ulonglong)(uVar6 + 8) + 1] = uVar4;
        uVar4 = uVar4 ^ param_4[(ulonglong)(uVar6 + 1) + 1];
        param_4[(ulonglong)(uVar6 + 9) + 1] = uVar4;
        uVar4 = uVar4 ^ param_4[(ulonglong)(uVar6 + 2) + 1];
        param_4[(ulonglong)(uVar6 + 10) + 1] = uVar4;
        uVar4 = uVar4 ^ param_4[(ulonglong)(uVar6 + 3) + 1];
        param_4[(ulonglong)(uVar6 + 0xb) + 1] = uVar4;
        uVar4 = *(uint *)(lVar2 + 0xc00 + (ulonglong)(uVar4 >> 0x18) * 4) ^
                *(uint *)(lVar2 + 0x800 + (ulonglong)(uVar4 >> 0x10 & 0xff) * 4) ^
                *(uint *)(lVar2 + 0x400 + (ulonglong)(uVar4 >> 8 & 0xff) * 4) ^
                param_4[(ulonglong)(uVar6 + 4) + 1] ^
                *(uint *)(lVar2 + (ulonglong)(uVar4 & 0xff) * 4);
        param_4[(ulonglong)(uVar6 + 0xc) + 1] = uVar4;
        uVar4 = uVar4 ^ param_4[(ulonglong)(uVar6 + 5) + 1];
        param_4[(ulonglong)(uVar6 + 0xd) + 1] = uVar4;
        uVar4 = uVar4 ^ param_4[(ulonglong)(uVar6 + 6) + 1];
        param_4[(ulonglong)(uVar6 + 0xe) + 1] = uVar4;
        uVar4 = uVar4 ^ param_4[(ulonglong)(uVar6 + 7) + 1];
        param_4[(ulonglong)(uVar6 + 0xf) + 1] = uVar4;
        puVar3 = puVar3 + 1;
      } while (uVar12 < 7);
    }
  }
  uVar11 = 4;
  param_4[0x41] = param_4[1];
  param_4[0x42] = param_4[2];
  param_4[0x43] = param_4[3];
  param_4[0x44] = param_4[4];
  if (4 < *param_4 * 4 + 0x18U) {
    do {
      uVar10 = (int)uVar11 + 1;
      uVar12 = param_4[uVar11 + 1];
      uVar8 = (uVar12 >> 7 & 0x1010101) * 0x1b ^ (uVar12 & 0xff7f7f7f) * 2;
      uVar6 = (uVar8 >> 7 & 0x1010101) * 0x1b ^ (uVar8 & 0xff7f7f7f) * 2;
      uVar4 = (uVar6 >> 7 & 0x1010101) * 0x1b ^ (uVar6 & 0xff7f7f7f) * 2;
      uVar12 = uVar12 ^ uVar4;
      param_4[uVar11 + 0x41] =
           ((uVar12 ^ uVar6) >> 0x10 | (uVar12 ^ uVar6) << 0x10) ^
           ((uVar12 ^ uVar8) >> 8 | (uVar12 ^ uVar8) << 0x18) ^ (uVar12 >> 0x18 | uVar12 << 8) ^
           uVar4 ^ uVar6 ^ uVar8;
      uVar11 = (ulonglong)uVar10;
    } while (uVar10 < *param_4 * 4 + 0x18U);
  }
  return;
}

