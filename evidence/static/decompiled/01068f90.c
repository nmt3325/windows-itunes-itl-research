/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1068f90; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

void itl_1068f90(uint *param_1)

{
  uint uVar1;
  ulonglong uVar2;
  
  uVar1 = *param_1;
  *param_1 = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
  uVar1 = param_1[1];
  param_1[1] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
  uVar1 = param_1[2];
  param_1[2] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
  *(ushort *)(param_1 + 3) = (ushort)param_1[3] >> 8 | (ushort)param_1[3] << 8;
  *(ushort *)((longlong)param_1 + 0xe) =
       *(ushort *)((longlong)param_1 + 0xe) >> 8 | *(ushort *)((longlong)param_1 + 0xe) << 8;
  uVar1 = param_1[0xc];
  param_1[0xc] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
  uVar2 = *(ulonglong *)(param_1 + 0xd);
  *(ulonglong *)(param_1 + 0xd) =
       uVar2 >> 0x38 | (uVar2 & 0xff000000000000) >> 0x28 | (uVar2 & 0xff0000000000) >> 0x18 |
       (uVar2 & 0xff00000000) >> 8 | (uVar2 & 0xff000000) << 8 | (uVar2 & 0xff0000) << 0x18 |
       (uVar2 & 0xff00) << 0x28 | uVar2 << 0x38;
  uVar1 = param_1[0xf];
  param_1[0xf] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
  uVar1 = param_1[0x11];
  param_1[0x11] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
  uVar1 = param_1[0x12];
  param_1[0x12] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
  uVar1 = param_1[0x13];
  param_1[0x13] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
  *(ushort *)(param_1 + 0x14) = (ushort)param_1[0x14] >> 8 | (ushort)param_1[0x14] << 8;
  uVar1 = param_1[0x15];
  param_1[0x15] = (uVar1 & 0xff0000 | uVar1 >> 0x10) >> 8 | (uVar1 << 0x10 | uVar1 & 0xff00) << 8;
  uVar1 = param_1[0x16];
  param_1[0x16] = (uVar1 & 0xff0000 | uVar1 >> 0x10) >> 8 | (uVar1 << 0x10 | uVar1 & 0xff00) << 8;
  uVar1 = param_1[0x17];
  param_1[0x17] = (uVar1 & 0xff0000 | uVar1 >> 0x10) >> 8 | (uVar1 << 0x10 | uVar1 & 0xff00) << 8;
  uVar1 = param_1[0x18];
  param_1[0x18] = (uVar1 & 0xff0000 | uVar1 >> 0x10) >> 8 | (uVar1 << 0x10 | uVar1 & 0xff00) << 8;
  uVar1 = param_1[0x19];
  param_1[0x19] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
  uVar2 = *(ulonglong *)(param_1 + 0x1a);
  *(ulonglong *)(param_1 + 0x1a) =
       uVar2 >> 0x38 | (uVar2 & 0xff000000000000) >> 0x28 | (uVar2 & 0xff0000000000) >> 0x18 |
       (uVar2 & 0xff00000000) >> 8 | (uVar2 & 0xff000000) << 8 | (uVar2 & 0xff0000) << 0x18 |
       (uVar2 & 0xff00) << 0x28 | uVar2 << 0x38;
  uVar1 = param_1[0x1c];
  param_1[0x1c] = uVar1 >> 0x18 | (uVar1 & 0xff0000) >> 8 | (uVar1 & 0xff00) << 8 | uVar1 << 0x18;
  return;
}

