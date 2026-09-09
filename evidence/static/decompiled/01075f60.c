/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1075f60; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_141075f60(ushort *param_1,char param_2,ushort *param_3)

{
  ushort uVar1;
  ushort *puVar2;
  int iVar3;
  undefined1 auStack_b8 [32];
  ushort *puStack_98;
  undefined2 *puStack_90;
  undefined8 uStack_88;
  undefined8 uStack_80;
  undefined8 uStack_78;
  undefined8 uStack_70;
  ushort *puStack_68;
  undefined2 auStack_58 [32];
  ulonglong uStack_18;
  
  uStack_18 = _DAT_141fd5040 ^ (ulonglong)auStack_b8;
  if (param_2 == '\0') {
    if (param_3 != (ushort *)0x0) {
      *param_3 = 0;
      FUN_140ae5fa0(&UNK_141ab1b08,0x14);
    }
    goto LAB_141076026;
  }
  if ((param_1 != (ushort *)0x0) && (param_3 != (ushort *)0x0)) {
    uVar1 = *param_1;
    if (uVar1 < 0x100) {
      *param_3 = uVar1;
      iVar3 = uVar1 - 1;
      if (iVar3 < 0) goto LAB_141075fe2;
    }
    else {
      *param_3 = 0xff;
      iVar3 = 0xfe;
    }
    puVar2 = param_3;
    do {
      puVar2 = puVar2 + 1;
      iVar3 = iVar3 + -1;
      *puVar2 = *(ushort *)((longlong)param_1 + (2 - (longlong)(param_3 + 1)) + (longlong)puVar2);
    } while (-1 < iVar3);
  }
LAB_141075fe2:
  auStack_58[0] = 0;
  FUN_140ae5fa0(&UNK_141ab18d0,3,auStack_58);
  FUN_140ae48a0(param_3,auStack_58);
LAB_141076026:
  auStack_58[0] = 0;
  FUN_140ae5fa0(&UNK_141ab1b5c,3,auStack_58);
  puStack_90 = auStack_58;
  uStack_88 = 0;
  uStack_80 = 0;
  uStack_78 = 0;
  uStack_70 = 0;
  puStack_98 = param_3;
  puStack_68 = param_3;
  FUN_140b1a610(&puStack_98);
  return;
}

