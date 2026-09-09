/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xbfbe20; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined8 FUN_140bfbe20(undefined4 *param_1,undefined4 param_2)

{
  if (param_1 == (undefined4 *)0x0) {
    return 0x206c;
  }
  if (DAT_1420af26c == '\0') {
    _DAT_1420d2cd0 = 0x1420d2d20;
    _DAT_1420d2cd8 = 0x1420d2e20;
    _DAT_1420d2ce0 = 0x1420d2f20;
    _DAT_1420d2ce8 = 0x1420d3020;
    _DAT_1420d2cf0 = &DAT_1420d3120;
    _DAT_1420d2cf8 = 0x1420d3150;
    _DAT_1420d2d00 = 0x1420d4150;
    _DAT_1420d2d08 = 0x1420d5150;
    _DAT_1420d2d10 = 0x1420d6150;
    FUN_140bf9710();
    DAT_1420af26c = '\x01';
  }
  *param_1 = 0;
  *(undefined8 *)(param_1 + 4) = 0;
  *(undefined8 *)(param_1 + 6) = 0;
  *(undefined8 *)(param_1 + 8) = 0;
  *(undefined8 *)(param_1 + 10) = 0;
  *(undefined8 *)(param_1 + 0xc) = 0;
  param_1[1] = 1;
  param_1[2] = 1;
  param_1[3] = param_2;
  return 0;
}

