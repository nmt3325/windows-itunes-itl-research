/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x106b290; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

int FUN_14106b290(longlong param_1,longlong param_2)

{
  int iVar1;
  longlong lVar2;
  undefined8 uVar3;
  undefined8 uVar4;
  undefined1 auStack_58 [32];
  undefined8 uStack_38;
  uint uStack_30;
  uint uStack_2c;
  uint uStack_28;
  uint uStack_24;
  undefined8 uStack_20;
  ulonglong uStack_18;
  
  uStack_18 = _DAT_141fd5040 ^ (ulonglong)auStack_58;
  uStack_20 = 0;
  uStack_30 = 0x686f686d;
  uStack_2c = 0x18;
  uStack_24 = 0x6d;
  if ((param_2 != 0) && (lVar2 = CFPropertyListCreateXMLData(_DAT_1420a6090), lVar2 != 0)) {
    iVar1 = CFDataGetLength(lVar2);
    uStack_28 = iVar1 + uStack_2c;
    if (*(char *)(param_1 + 0x52) == '\0') {
      uStack_30 = (uStack_30 & 0xff0000 | uStack_30 >> 0x10) >> 8 |
                  (uStack_30 & 0xff00 | uStack_30 << 0x10) << 8;
      uStack_2c = (uStack_2c & 0xff0000 | uStack_2c >> 0x10) >> 8 |
                  (uStack_2c & 0xff00 | uStack_2c << 0x10) << 8;
      uStack_24 = (uStack_24 & 0xff0000 | uStack_24 >> 0x10) >> 8 |
                  (uStack_24 & 0xff00 | uStack_24 << 0x10) << 8;
      uStack_28 = uStack_28 >> 0x18 | (uStack_28 & 0xff0000) >> 8 | (uStack_28 & 0xff00) << 8 |
                  uStack_28 * 0x1000000;
      uStack_20 = CONCAT44(uStack_20._4_4_,
                           ((uint)uStack_20 & 0xff0000 | (uint)uStack_20 >> 0x10) >> 8 |
                           ((uint)uStack_20 << 0x10 | (uint)uStack_20 & 0xff00) << 8);
    }
    uStack_38 = 0x18;
    iVar1 = FUN_140ba04c0(*(undefined8 *)(param_1 + 0x120),&uStack_38,&uStack_30);
    if (iVar1 == 0) {
      uVar3 = CFDataGetLength(lVar2);
      uVar4 = CFDataGetBytePtr(lVar2);
      uStack_38 = uVar3;
      iVar1 = FUN_140ba04c0(*(undefined8 *)(param_1 + 0x120),&uStack_38,uVar4);
    }
    CFRelease(lVar2);
    return iVar1;
  }
  return -0x32;
}

