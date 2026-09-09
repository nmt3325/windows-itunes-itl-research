/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x106ac80; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Removing unreachable block (ram,0x00014106ad5d) */

undefined8
FUN_14106ac80(longlong param_1,ushort *param_2,uint param_3,uint param_4,uint param_5,uint param_6,
             longlong *param_7)

{
  uint uVar1;
  uint *puVar2;
  uint uVar3;
  uint *puVar4;
  uint *puVar5;
  ulonglong uVar6;
  uint *puVar7;
  ushort *puVar8;
  uint uVar9;
  bool bVar10;
  
  uVar3 = 0;
  bVar10 = true;
  puVar2 = (uint *)*param_7;
  puVar5 = puVar2 + 6;
  if (puVar2 != (uint *)0x0) {
    puVar2[2] = 0;
    puVar2[5] = 0;
  }
  *puVar2 = 0x686f686d;
  puVar2[1] = 0x18;
  puVar2[3] = param_5;
  puVar2[4] = param_4;
  puVar7 = puVar5;
  uVar9 = param_3;
  if (((param_5 != 1) && (param_5 != 0x42)) && (param_5 != 0x13)) {
    puVar7 = puVar2 + 10;
    if (puVar5 != (uint *)0x0) {
      puVar5[0] = 0;
      puVar5[1] = 0;
      puVar2[8] = 0;
      puVar2[9] = 0;
    }
    if (param_6 == 1) {
      if (param_3 < 0x1ff) {
        param_6 = 3;
        uVar9 = param_3 >> 1;
        puVar4 = puVar7;
        puVar8 = param_2;
        if (uVar9 == 0) {
LAB_14106ad6f:
          bVar10 = param_6 != 3;
          if (bVar10) {
            uVar9 = param_3;
          }
        }
        else {
          do {
            if (0xff < *puVar8) {
              param_6 = 1;
              goto LAB_14106ad6f;
            }
            *(char *)puVar4 = (char)*puVar8;
            uVar3 = uVar3 + 1;
            puVar4 = (uint *)((longlong)puVar4 + 1);
            puVar8 = puVar8 + 1;
          } while (uVar3 < uVar9);
          bVar10 = false;
        }
      }
    }
    else if (param_6 == 4) {
      param_6 = 1;
    }
    *puVar5 = param_6;
    puVar2[7] = uVar9;
    if (*(char *)(param_1 + 0x52) == '\0') {
      *puVar5 = (param_6 & 0xff00 | param_6 << 0x10) << 8 | param_6 >> 8 & 0xff00 | param_6 >> 0x18;
      puVar2[7] = (uVar9 & 0xff00 | uVar9 << 0x10) << 8 | uVar9 >> 8 & 0xff00 | uVar9 >> 0x18;
    }
    if (!bVar10) goto LAB_14106ae0e;
  }
  if ((param_2 != (ushort *)0x0) && (puVar7 != (uint *)0x0)) {
    func_0x000141867875(puVar7,param_2,uVar9);
  }
LAB_14106ae0e:
  if (((param_6 == 1) && (*(char *)(param_1 + 0x52) == '\0')) && (uVar9 >> 1 != 0)) {
    uVar6 = (ulonglong)(uVar9 >> 1);
    puVar5 = puVar7;
    do {
      *(ushort *)puVar5 = (ushort)*puVar5 >> 8 | (ushort)*puVar5 << 8;
      uVar6 = uVar6 - 1;
      puVar5 = (uint *)((longlong)puVar5 + 2);
    } while (uVar6 != 0);
  }
  uVar3 = (int)((longlong)puVar7 + (ulonglong)uVar9) - (int)puVar2;
  puVar2[2] = uVar3;
  if (*(char *)(param_1 + 0x52) == '\0') {
    uVar1 = *puVar2;
    *puVar2 = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
    uVar1 = puVar2[1];
    puVar2[1] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
    uVar1 = puVar2[3];
    puVar2[3] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
    uVar1 = puVar2[4];
    puVar2[4] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
    puVar2[2] = (uVar3 * 0x10000 | uVar3 & 0xff00) << 8 | uVar3 >> 8 & 0xff00 | uVar3 >> 0x18;
  }
  *param_7 = (longlong)puVar7 + (ulonglong)uVar9;
  return 0;
}

