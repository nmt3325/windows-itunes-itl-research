/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x106af90; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

undefined8
FUN_14106af90(longlong param_1,longlong param_2,uint param_3,uint param_4,longlong *param_5)

{
  undefined4 *puVar1;
  undefined4 *puVar2;
  uint uVar3;
  
  puVar2 = (undefined4 *)*param_5;
  puVar1 = puVar2 + 6;
  if (puVar2 != (undefined4 *)0x0) {
    *(undefined8 *)(puVar2 + 4) = 0;
  }
  uVar3 = param_3 + 0x18;
  *puVar2 = 0x686f686d;
  puVar2[2] = uVar3;
  puVar2[1] = 0x18;
  puVar2[3] = param_4;
  if (*(char *)(param_1 + 0x52) == '\0') {
    *puVar2 = 0x6d686f68;
    puVar2[1] = 0x18000000;
    puVar2[2] = uVar3 >> 0x18 | (uVar3 & 0xff0000) >> 8 | (uVar3 & 0xff00) << 8 | uVar3 * 0x1000000;
    puVar2[3] = param_4 >> 0x18 | (param_4 & 0xff0000) >> 8 | (param_4 & 0xff00) << 8 |
                param_4 << 0x18;
    uVar3 = puVar2[4];
    puVar2[4] = uVar3 >> 0x18 | (uVar3 & 0xff0000) >> 8 | (uVar3 & 0xff00) << 8 | uVar3 << 0x18;
  }
  if ((param_2 != 0) && (puVar1 != (undefined4 *)0x0)) {
    func_0x000141867875(puVar1,param_2,param_3);
  }
  *param_5 = (ulonglong)param_3 + (longlong)puVar1;
  return 0;
}

