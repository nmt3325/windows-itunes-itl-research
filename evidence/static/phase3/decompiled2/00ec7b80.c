/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xec7b80; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

void FUN_140ec7b80(longlong param_1)

{
  longlong lVar1;
  undefined4 uStack_98;
  undefined4 uStack_94;
  undefined4 uStack_90;
  undefined4 uStack_8c;
  code *pcStack_88;
  longlong lStack_80;
  undefined1 *puStack_78;
  longlong lStack_70;
  longlong lStack_68;
  longlong lStack_60;
  longlong lStack_58;
  undefined4 uStack_50;
  undefined4 uStack_4c;
  undefined8 uStack_48;
  undefined8 uStack_40;
  undefined8 uStack_38;
  undefined8 uStack_30;
  undefined8 uStack_28;
  undefined8 uStack_20;
  undefined8 uStack_18;
  
  lVar1 = *(longlong *)(param_1 + 0x10);
  puStack_78 = (undefined1 *)0x0;
  lStack_68 = 0;
  lStack_60 = 0;
  lStack_58 = 0;
  uStack_4c = 0;
  uStack_18 = 0;
  pcStack_88 = FUN_140eb80a0;
  lStack_70 = param_1 + 0x92;
  uStack_98 = 0;
  uStack_48 = 0x200000000000;
  uStack_40 = 0;
  uStack_94 = 2;
  uStack_90 = 0x4e;
  uStack_8c = 0x1e;
  *(undefined1 *)(param_1 + 0xa1) = 0;
  *(undefined4 *)(param_1 + 0xe0) = 0;
  uStack_50 = *(undefined4 *)(param_1 + 0x160);
  uStack_28 = 1;
  uStack_20 = 0;
  uStack_38 = 0x8000000000000;
  uStack_30 = 0;
  if (lVar1 != 0) {
    lStack_58 = lVar1 + 0x1768;
    lStack_68 = lVar1 + 0x178;
    lStack_60 = param_1 + 0xb0;
    puStack_78 = (undefined1 *)(param_1 + 0xa1);
  }
  lStack_80 = param_1;
  FUN_140eb8630(&uStack_98);
  return;
}

