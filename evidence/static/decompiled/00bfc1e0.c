/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xbfc1e0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

undefined8
FUN_140bfc1e0(longlong param_1,longlong param_2,uint param_3,longlong param_4,uint *param_5)

{
  uint uVar1;
  ulonglong uVar3;
  uint *puVar4;
  uint *puVar5;
  undefined1 auStack_78 [32];
  uint *puStack_58;
  uint uStack_50;
  uint uStack_4c;
  uint uStack_48;
  uint uStack_44;
  ulonglong uStack_40;
  int iVar2;
  
  uStack_40 = _DAT_141fd5040 ^ (ulonglong)auStack_78;
  uVar3 = 0;
  uVar1 = 0;
  puVar4 = *(uint **)(param_1 + 0x28);
  puStack_58 = param_5;
  if (0xf < param_3) {
    do {
      puVar5 = (uint *)(uVar3 + param_2);
      if (*(int *)(param_1 + 0xc) == 1) {
        uStack_50 = *puVar4 ^ *puVar5;
        uStack_4c = puVar5[1] ^ puVar4[1];
        uStack_48 = puVar5[2] ^ puVar4[2];
        uStack_44 = puVar5[3] ^ puVar4[3];
        puVar5 = (uint *)(uVar3 + param_4);
        FUN_140bfa2a0(&uStack_50,puVar5);
      }
      else {
        FUN_140bfb050(puVar5,&uStack_50,*(undefined8 *)(param_1 + 0x20));
        *(uint *)(uVar3 + param_4) = uStack_50 ^ *puVar4;
        *(uint *)(uVar3 + 4 + param_4) = uStack_4c ^ puVar4[1];
        *(uint *)(uVar3 + 8 + param_4) = uStack_48 ^ puVar4[2];
        *(uint *)(uVar3 + 0xc + param_4) = uStack_44 ^ puVar4[3];
      }
      iVar2 = (int)uVar3;
      uVar1 = iVar2 + 0x10;
      uVar3 = (ulonglong)uVar1;
      param_5 = puStack_58;
      puVar4 = puVar5;
    } while (iVar2 + 0x20U <= param_3);
  }
  if (param_5 != (uint *)0x0) {
    *param_5 = uVar1;
  }
  return 0;
}

