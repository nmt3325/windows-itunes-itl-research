/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xbfa2a0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_140bfa2a0(uint *param_1,undefined8 *param_2,uint *param_3)

{
  uint uVar1;
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
  uint *puVar14;
  uint uVar15;
  
  puVar14 = param_3 + 5;
  uVar15 = param_1[2] ^ param_3[3];
  uVar5 = *param_1 ^ param_3[1];
  uVar3 = param_1[1] ^ param_3[2];
  uVar13 = param_1[3] ^ param_3[4];
  if (*param_3 < 7) {
    if (*param_3 < 5) goto LAB_140bfa6d4;
  }
  else {
    uVar10 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar13 >> 0x18) * 4) ^
             *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar15 >> 0x10 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar5 & 0xff) * 4) ^ *puVar14;
    uVar8 = *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar13 >> 0x10 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar5 >> 0x18) * 4) ^
            *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar15 >> 8 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar3 & 0xff) * 4) ^ param_3[6];
    uVar7 = *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar13 >> 8 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
            *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar5 >> 0x10 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar15 & 0xff) * 4) ^ param_3[7];
    uVar13 = *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar5 >> 8 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar15 >> 0x18) * 4) ^
             *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar13 & 0xff) * 4) ^ param_3[8];
    uVar5 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar13 >> 0x18) * 4) ^
            *(uint *)(_DAT_1420d2cf8 + 0x800 + ((ulonglong)(uVar7 >> 0x10) & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar10 & 0xff) * 4) ^ param_3[9];
    uVar3 = *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar13 >> 0x10 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar7 >> 8 & 0xff) * 4) ^
            *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar10 >> 0x18) * 4) ^
            *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar8 & 0xff) * 4) ^ param_3[10];
    uVar15 = *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar13 >> 8 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar8 >> 0x18) * 4) ^
             *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar10 >> 0x10 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2cf8 + ((ulonglong)uVar7 & 0xff) * 4) ^ param_3[0xb];
    uVar13 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar7 >> 0x18) * 4) ^
             *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar10 >> 8 & 0xff) * 4) ^
             *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar13 & 0xff) * 4) ^ param_3[0xc];
    puVar14 = param_3 + 0xd;
  }
  uVar10 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar13 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar15 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar5 & 0xff) * 4) ^ *puVar14;
  uVar8 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar5 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar13 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar15 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar14[1];
  uVar7 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar5 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar13 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar15 & 0xff) * 4) ^ puVar14[2];
  uVar13 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar15 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar5 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar13 & 0xff) * 4) ^ puVar14[3];
  uVar5 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar13 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + ((ulonglong)(uVar7 >> 0x10) & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar10 & 0xff) * 4) ^ puVar14[4];
  uVar3 = *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar13 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar7 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar10 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar8 & 0xff) * 4) ^ puVar14[5];
  uVar15 = *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar13 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar8 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar10 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + ((ulonglong)uVar7 & 0xff) * 4) ^ puVar14[6];
  uVar13 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar7 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar10 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar13 & 0xff) * 4) ^ puVar14[7];
  puVar14 = puVar14 + 8;
LAB_140bfa6d4:
  uVar8 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar13 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar15 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar5 & 0xff) * 4) ^ *puVar14;
  uVar7 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar5 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar13 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar15 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar14[1];
  uVar9 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar5 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar13 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar15 & 0xff) * 4) ^ puVar14[2];
  uVar3 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar15 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar5 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar13 & 0xff) * 4) ^ puVar14[3];
  uVar10 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x800 + ((ulonglong)(uVar9 >> 0x10) & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar7 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar8 & 0xff) * 4) ^ puVar14[4];
  uVar11 = *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar9 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar8 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar7 & 0xff) * 4) ^ puVar14[5];
  uVar5 = *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar7 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + ((ulonglong)uVar9 & 0xff) * 4) ^ puVar14[6];
  uVar3 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar9 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar7 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar14[7];
  uVar8 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar5 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar11 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar10 & 0xff) * 4) ^ puVar14[8];
  uVar15 = *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar5 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar10 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar11 & 0xff) * 4) ^ puVar14[9];
  uVar13 = *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar11 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar10 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + ((ulonglong)uVar5 & 0xff) * 4) ^ puVar14[10];
  uVar3 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar5 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar11 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar10 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar14[0xb];
  uVar7 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar13 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar15 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar8 & 0xff) * 4) ^ puVar14[0xc];
  uVar10 = *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar13 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar8 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar15 & 0xff) * 4) ^ puVar14[0xd];
  uVar5 = *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar15 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + ((ulonglong)uVar13 & 0xff) * 4) ^ puVar14[0xe];
  uVar3 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar13 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar15 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar14[0xf];
  uVar8 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar5 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar10 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar7 & 0xff) * 4) ^ puVar14[0x10];
  uVar9 = *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar5 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar7 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar10 & 0xff) * 4) ^ puVar14[0x11];
  uVar13 = *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar10 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar7 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + ((ulonglong)uVar5 & 0xff) * 4) ^ puVar14[0x12];
  uVar3 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar5 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar10 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar7 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar14[0x13];
  uVar7 = *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar9 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar13 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar8 & 0xff) * 4) ^ puVar14[0x14];
  uVar15 = *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar13 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar8 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar9 & 0xff) * 4) ^ puVar14[0x15];
  uVar10 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar9 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar13 & 0xff) * 4) ^ puVar14[0x16];
  uVar3 = *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar9 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar13 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar14[0x17];
  uVar8 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + ((ulonglong)(uVar10 >> 0x10) & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar15 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar7 & 0xff) * 4) ^ puVar14[0x18];
  uVar9 = *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar10 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar7 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar15 & 0xff) * 4) ^ puVar14[0x19];
  uVar5 = *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar15 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar7 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + ((ulonglong)uVar10 & 0xff) * 4) ^ puVar14[0x1a];
  uVar3 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar10 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar15 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar7 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar14[0x1b];
  uVar7 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar5 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar9 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar8 & 0xff) * 4) ^ puVar14[0x1c];
  uVar15 = *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar5 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar8 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar9 & 0xff) * 4) ^ puVar14[0x1d];
  uVar13 = *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar9 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar8 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + ((ulonglong)uVar5 & 0xff) * 4) ^ puVar14[0x1e];
  uVar3 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar5 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar9 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar8 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar14[0x1f];
  uVar4 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar3 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar13 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar15 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar7 & 0xff) * 4) ^ puVar14[0x20];
  uVar6 = *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar3 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar13 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar7 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar15 & 0xff) * 4) ^ puVar14[0x21];
  uVar12 = *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar3 >> 8 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar15 >> 0x18) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar7 >> 0x10 & 0xff) * 4) ^
           *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar13 & 0xff) * 4) ^ puVar14[0x22];
  uVar2 = *(uint *)(_DAT_1420d2cf8 + 0xc00 + (ulonglong)(uVar13 >> 0x18) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x800 + (ulonglong)(uVar15 >> 0x10 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + 0x400 + (ulonglong)(uVar7 >> 8 & 0xff) * 4) ^
          *(uint *)(_DAT_1420d2cf8 + (ulonglong)(uVar3 & 0xff) * 4) ^ puVar14[0x23];
  uVar3 = *(uint *)(_DAT_1420d2d08 + 0x400 + (ulonglong)(uVar2 >> 8 & 0xff) * 4);
  uVar5 = *(uint *)(_DAT_1420d2d08 + 0xc00 + (ulonglong)(uVar6 >> 0x18) * 4);
  uVar13 = *(uint *)(_DAT_1420d2d08 + 0x800 + (ulonglong)(uVar4 >> 0x10 & 0xff) * 4);
  uVar15 = *(uint *)(_DAT_1420d2d08 + ((ulonglong)uVar12 & 0xff) * 4);
  uVar7 = puVar14[0x26];
  uVar8 = *(uint *)(_DAT_1420d2d08 + 0xc00 + (ulonglong)(uVar12 >> 0x18) * 4);
  uVar10 = *(uint *)(_DAT_1420d2d08 + 0x800 + (ulonglong)(uVar6 >> 0x10 & 0xff) * 4);
  uVar9 = *(uint *)(_DAT_1420d2d08 + 0x400 + (ulonglong)(uVar4 >> 8 & 0xff) * 4);
  uVar11 = *(uint *)(_DAT_1420d2d08 + (ulonglong)(uVar2 & 0xff) * 4);
  uVar1 = puVar14[0x27];
  *param_2 = CONCAT44(*(uint *)(_DAT_1420d2d08 + 0x800 + (ulonglong)(uVar2 >> 0x10 & 0xff) * 4) ^
                      *(uint *)(_DAT_1420d2d08 + 0x400 + (ulonglong)(uVar12 >> 8 & 0xff) * 4) ^
                      *(uint *)(_DAT_1420d2d08 + 0xc00 + (ulonglong)(uVar4 >> 0x18) * 4) ^
                      *(uint *)(_DAT_1420d2d08 + (ulonglong)(uVar6 & 0xff) * 4) ^ puVar14[0x25],
                      *(uint *)(_DAT_1420d2d08 + 0xc00 + (ulonglong)(uVar2 >> 0x18) * 4) ^
                      *(uint *)(_DAT_1420d2d08 + 0x800 + ((ulonglong)(uVar12 >> 0x10) & 0xff) * 4) ^
                      *(uint *)(_DAT_1420d2d08 + 0x400 + (ulonglong)(uVar6 >> 8 & 0xff) * 4) ^
                      *(uint *)(_DAT_1420d2d08 + (ulonglong)(uVar4 & 0xff) * 4) ^ puVar14[0x24]);
  param_2[1] = CONCAT44(uVar8 ^ uVar10 ^ uVar9 ^ uVar11 ^ uVar1,
                        uVar3 ^ uVar5 ^ uVar13 ^ uVar15 ^ uVar7);
  return;
}

