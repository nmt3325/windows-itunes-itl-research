/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xbfb050; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_140bfb050(uint *param_1,undefined8 *param_2,uint *param_3)

{
  int iVar1;
  uint uVar2;
  uint uVar3;
  uint uVar4;
  uint uVar5;
  uint uVar6;
  uint uVar7;
  uint uVar8;
  uint uVar9;
  uint uVar10;
  uint uVar11;
  uint uVar12;
  uint uVar13;
  uint uVar14;
  uint *puVar15;
  uint uVar16;
  
  uVar3 = *param_3;
  uVar16 = *param_1 ^ param_3[(ulonglong)(uVar3 * 4 + 0x18) + 1];
  iVar1 = uVar3 * 4;
  uVar8 = param_1[1] ^ param_3[(ulonglong)(iVar1 + 0x19) + 1];
  puVar15 = param_3 + (ulonglong)(iVar1 + 0x14) + 0x41;
  uVar6 = param_1[2] ^ param_3[(ulonglong)(iVar1 + 0x1a) + 1];
  uVar14 = param_1[3] ^ param_3[(ulonglong)(iVar1 + 0x1b) + 1];
  if (uVar3 < 7) {
    if (uVar3 < 5) goto LAB_140bfb4b5;
  }
  else {
    uVar11 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar8 >> 0x18) * 4) ^
             *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar14 >> 8 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar6 >> 0x10 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar16 & 0xff) * 4) ^ *puVar15;
    uVar10 = *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar14 >> 0x10 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar16 >> 8 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar6 >> 0x18) * 4) ^
             *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar8 & 0xff) * 4) ^ puVar15[1];
    uVar9 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar14 >> 0x18) * 4) ^
            *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar16 >> 0x10 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar6 & 0xff) * 4) ^ puVar15[2];
    uVar3 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar16 >> 0x18) * 4) ^
            *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar6 >> 8 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar14 & 0xff) * 4) ^ puVar15[3];
    uVar16 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar9 >> 0x10 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar10 >> 0x18) * 4) ^
             *(uint *)(_DAT_1420d2d00 + ((ulonglong)uVar11 & 0xff) * 4) ^ puVar15[-4];
    uVar8 = *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar9 >> 0x18) * 4) ^
            *(uint *)(_DAT_1420d2d00 + 0x400 + ((ulonglong)(uVar11 >> 8) & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar10 & 0xff) * 4) ^ puVar15[-3];
    uVar6 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
            *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar10 >> 8 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar11 >> 0x10 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar9 & 0xff) * 4) ^ puVar15[-2];
    uVar14 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar9 >> 8 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar10 >> 0x10 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar11 >> 0x18) * 4) ^
             *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar15[-1];
    puVar15 = puVar15 + -8;
  }
  uVar11 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar8 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar6 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar14 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar16 & 0xff) * 4) ^ *puVar15;
  uVar10 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar6 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar14 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar16 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar8 & 0xff) * 4) ^ puVar15[1];
  uVar9 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar14 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar16 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar6 & 0xff) * 4) ^ puVar15[2];
  uVar3 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar16 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar6 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar14 & 0xff) * 4) ^ puVar15[3];
  uVar16 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar9 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar10 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + ((ulonglong)uVar11 & 0xff) * 4) ^ puVar15[-4];
  uVar8 = *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar9 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + ((ulonglong)(uVar11 >> 8) & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar10 & 0xff) * 4) ^ puVar15[-3];
  uVar6 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar10 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar11 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar9 & 0xff) * 4) ^ puVar15[-2];
  uVar14 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar9 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar10 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar11 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar15[-1];
  puVar15 = puVar15 + -8;
LAB_140bfb4b5:
  uVar10 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar8 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar6 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar14 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar16 & 0xff) * 4) ^ *puVar15;
  uVar9 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar6 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar14 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar16 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar8 & 0xff) * 4) ^ puVar15[1];
  uVar11 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar14 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar16 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar6 & 0xff) * 4) ^ puVar15[2];
  uVar3 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar16 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar6 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar14 & 0xff) * 4) ^ puVar15[3];
  uVar14 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar11 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar9 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + ((ulonglong)uVar10 & 0xff) * 4) ^ puVar15[-4];
  uVar12 = *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar11 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + ((ulonglong)(uVar10 >> 8) & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar9 & 0xff) * 4) ^ puVar15[-3];
  uVar16 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar9 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar10 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar11 & 0xff) * 4) ^ puVar15[-2];
  uVar3 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar11 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar9 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar10 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar15[-1];
  uVar8 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar16 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar12 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + ((ulonglong)uVar14 & 0xff) * 4) ^ puVar15[-8];
  uVar6 = *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar16 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + ((ulonglong)(uVar14 >> 8) & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar12 & 0xff) * 4) ^ puVar15[-7];
  uVar9 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar12 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar14 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar16 & 0xff) * 4) ^ puVar15[-6];
  uVar3 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar16 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar12 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar14 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar15[-5];
  uVar14 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar9 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar6 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + ((ulonglong)uVar8 & 0xff) * 4) ^ puVar15[-0xc];
  uVar11 = *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar9 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + ((ulonglong)(uVar8 >> 8) & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar6 & 0xff) * 4) ^ puVar15[-0xb];
  uVar16 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar6 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar9 & 0xff) * 4) ^ puVar15[-10];
  uVar3 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar9 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar6 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar8 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar15[-9];
  uVar8 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar16 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar11 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + ((ulonglong)uVar14 & 0xff) * 4) ^ puVar15[-0x10];
  uVar6 = *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar16 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + ((ulonglong)(uVar14 >> 8) & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar11 & 0xff) * 4) ^ puVar15[-0xf];
  uVar10 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar11 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar14 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar16 & 0xff) * 4) ^ puVar15[-0xe];
  uVar3 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar16 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar11 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar14 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar15[-0xd];
  uVar16 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar10 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar6 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + ((ulonglong)uVar8 & 0xff) * 4) ^ puVar15[-0x14];
  uVar11 = *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar10 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + ((ulonglong)(uVar8 >> 8) & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar6 & 0xff) * 4) ^ puVar15[-0x13];
  uVar9 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar6 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar10 & 0xff) * 4) ^ puVar15[-0x12];
  uVar3 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar10 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar6 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar8 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar15[-0x11];
  uVar14 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar9 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar11 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + ((ulonglong)uVar16 & 0xff) * 4) ^ puVar15[-0x18];
  uVar6 = *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar9 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + ((ulonglong)(uVar16 >> 8) & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar11 & 0xff) * 4) ^ puVar15[-0x17];
  uVar10 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar11 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar16 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar9 & 0xff) * 4) ^ puVar15[-0x16];
  uVar3 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar9 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar11 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar16 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar15[-0x15];
  uVar8 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar10 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar6 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + ((ulonglong)uVar14 & 0xff) * 4) ^ puVar15[-0x1c];
  uVar16 = *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar10 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + ((ulonglong)(uVar14 >> 8) & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar6 & 0xff) * 4) ^ puVar15[-0x1b];
  uVar9 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar6 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar14 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar10 & 0xff) * 4) ^ puVar15[-0x1a];
  uVar3 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar10 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar6 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar14 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar15[-0x19];
  uVar7 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar9 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar16 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + ((ulonglong)uVar8 & 0xff) * 4) ^ puVar15[-0x20];
  uVar5 = *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar9 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x400 + ((ulonglong)(uVar8 >> 8) & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar16 & 0xff) * 4) ^ puVar15[-0x1f];
  uVar13 = *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar16 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar9 & 0xff) * 4) ^ puVar15[-0x1e];
  uVar4 = *(uint *)(_DAT_1420d2d00 + 0x400 + (ulonglong)(uVar9 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0x800 + (ulonglong)(uVar16 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2d00 + 0xc00 + (ulonglong)(uVar8 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2d00 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar15[-0x1d];
  uVar3 = *(uint *)(_DAT_1420d2d10 + 0xc00 + (ulonglong)(uVar4 >> 0x18) * 4);
  uVar6 = *(uint *)(_DAT_1420d2d10 + 0x400 + (ulonglong)(uVar5 >> 8 & 0xff) * 4);
  uVar8 = *(uint *)(_DAT_1420d2d10 + 0x800 + (ulonglong)(uVar7 >> 0x10 & 0xff) * 4);
  uVar14 = *(uint *)(_DAT_1420d2d10 + (ulonglong)(uVar13 & 0xff) * 4);
  uVar16 = puVar15[-0x22];
  uVar9 = *(uint *)(_DAT_1420d2d10 + 0x400 + (ulonglong)(uVar13 >> 8 & 0xff) * 4);
  uVar10 = *(uint *)(_DAT_1420d2d10 + 0x800 + (ulonglong)(uVar5 >> 0x10 & 0xff) * 4);
  uVar11 = *(uint *)(_DAT_1420d2d10 + 0xc00 + (ulonglong)(uVar7 >> 0x18) * 4);
  uVar12 = *(uint *)(_DAT_1420d2d10 + (ulonglong)(uVar4 & 0xff) * 4);
  uVar2 = puVar15[-0x21];
  *param_2 = CONCAT44(*(uint *)(_DAT_1420d2d10 + 0x800 + (ulonglong)(uVar4 >> 0x10 & 0xff) * 4) ^
                      *(uint *)(_DAT_1420d2d10 + 0xc00 + (ulonglong)(uVar13 >> 0x18) * 4) ^
                      *(uint *)(_DAT_1420d2d10 + 0x400 + ((ulonglong)(uVar7 >> 8) & 0xff) * 4) ^
                      *(uint *)(_DAT_1420d2d10 + (ulonglong)(uVar5 & 0xff) * 4) ^ puVar15[-0x23],
                      *(uint *)(_DAT_1420d2d10 + 0x400 + (ulonglong)(uVar4 >> 8 & 0xff) * 4) ^
                      *(uint *)(_DAT_1420d2d10 + 0x800 + (ulonglong)(uVar13 >> 0x10 & 0xff) * 4) ^
                      *(uint *)(_DAT_1420d2d10 + 0xc00 + (ulonglong)(uVar5 >> 0x18) * 4) ^
                      *(uint *)(_DAT_1420d2d10 + ((ulonglong)uVar7 & 0xff) * 4) ^ puVar15[-0x24]);
  param_2[1] = CONCAT44(uVar9 ^ uVar10 ^ uVar11 ^ uVar12 ^ uVar2,
                        uVar3 ^ uVar6 ^ uVar8 ^ uVar14 ^ uVar16);
  return;
}

