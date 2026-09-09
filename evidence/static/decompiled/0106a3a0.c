/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x106a3a0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

ulonglong FUN_14106a3a0(longlong param_1,char param_2)

{
  uint uVar1;
  ulonglong uVar2;
  undefined1 auStack_48 [32];
  undefined4 uStack_28;
  undefined4 uStack_24;
  undefined4 uStack_20;
  undefined4 uStack_1c;
  ulonglong uStack_18;
  
  uStack_18 = _DAT_141fd5040 ^ (ulonglong)auStack_48;
  uStack_28 = 0x49554842;
  uStack_24 = 0x6c69754c;
  uStack_20 = 0x75686766;
  uStack_1c = 0x33616c69;
  uVar2 = FUN_140bfbe20(0x49554842,2 - (uint)(param_2 != '\0'));
  if ((int)uVar2 == 0) {
    *(undefined4 **)(param_1 + 0x10) = &uStack_28;
    *(undefined1 *)(param_1 + 0x18) = 0x10;
    *(undefined4 *)(param_1 + 8) = 1;
    *(undefined8 *)(param_1 + 0x28) = 0;
    uVar1 = FUN_140bfbf10(param_1);
    uVar2 = (ulonglong)uVar1;
    if (uVar1 == 0) {
      uVar2 = 0;
    }
    else {
      FUN_140bfc0d0(param_1,0,0);
    }
  }
  return uVar2;
}

