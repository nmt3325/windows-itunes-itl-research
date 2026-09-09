/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x106cba0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_14106cba0(undefined8 *param_1)

{
  int iVar1;
  undefined1 auStack_138 [32];
  undefined8 auStack_118 [2];
  undefined4 uStack_108;
  undefined4 uStack_104;
  undefined4 uStack_100;
  undefined4 uStack_fc;
  undefined8 uStack_f8;
  undefined8 uStack_f0;
  undefined8 uStack_e8;
  undefined8 uStack_e0;
  undefined8 uStack_d8;
  undefined8 uStack_d0;
  undefined8 uStack_c8;
  undefined8 uStack_c0;
  undefined8 uStack_b8;
  undefined8 uStack_b0;
  undefined8 uStack_a8;
  undefined8 uStack_a0;
  undefined8 uStack_98;
  undefined8 uStack_90;
  undefined8 uStack_88;
  undefined8 uStack_80;
  undefined8 uStack_78;
  undefined8 uStack_70;
  undefined8 uStack_68;
  undefined8 uStack_60;
  undefined8 uStack_58;
  undefined8 uStack_50;
  undefined8 uStack_48;
  undefined8 uStack_40;
  undefined4 uStack_38;
  undefined4 uStack_34;
  undefined4 uStack_30;
  undefined4 uStack_2c;
  undefined4 uStack_28;
  undefined4 uStack_24;
  undefined4 uStack_20;
  undefined4 uStack_1c;
  ulonglong uStack_18;
  
  uStack_18 = _DAT_141fd5040 ^ (ulonglong)auStack_138;
  uStack_f8 = 0;
  uStack_f0 = 0;
  uStack_e8 = 0;
  uStack_e0 = 0;
  uStack_d8 = 0;
  uStack_d0 = 0;
  uStack_c8 = 0;
  uStack_c0 = 0;
  uStack_b8 = 0;
  uStack_b0 = 0;
  uStack_108 = 0x6864736d;
  uStack_104 = 0x60;
  uStack_fc = 0x10;
  uStack_100 = 0xf0;
  if (*(char *)((longlong)param_1 + 0x52) == '\0') {
    uStack_108 = 0x6d736468;
    uStack_104 = 0x60000000;
    uStack_100 = 0xf0000000;
    uStack_fc = 0x10000000;
  }
  auStack_118[0] = 0x60;
  iVar1 = FUN_140ba04c0(param_1[0x24],auStack_118,&uStack_108);
  if (iVar1 == 0) {
    uStack_a8 = *param_1;
    uStack_a0 = param_1[1];
    uStack_98 = param_1[2];
    uStack_90 = param_1[3];
    uStack_88 = param_1[4];
    uStack_80 = param_1[5];
    uStack_78 = param_1[6];
    uStack_70 = param_1[7];
    uStack_68 = param_1[8];
    uStack_60 = param_1[9];
    uStack_58 = param_1[10];
    uStack_50 = param_1[0xb];
    uStack_48 = param_1[0xc];
    uStack_40 = param_1[0xd];
    uStack_38 = *(undefined4 *)(param_1 + 0xe);
    uStack_34 = *(undefined4 *)((longlong)param_1 + 0x74);
    uStack_30 = *(undefined4 *)(param_1 + 0xf);
    uStack_2c = *(undefined4 *)((longlong)param_1 + 0x7c);
    uStack_28 = *(undefined4 *)(param_1 + 0x10);
    uStack_24 = *(undefined4 *)((longlong)param_1 + 0x84);
    uStack_20 = *(undefined4 *)(param_1 + 0x11);
    uStack_1c = *(undefined4 *)((longlong)param_1 + 0x8c);
    if (*(char *)((longlong)param_1 + 0x52) == '\0') {
      itl_1068f90(&uStack_a8);
    }
    auStack_118[0] = 0x90;
    FUN_140ba04c0(param_1[0x24],auStack_118,&uStack_a8);
  }
  return;
}

