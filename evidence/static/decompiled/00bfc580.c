/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xbfc580; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

ulonglong FUN_140bfc580(char *param_1,longlong param_2,uint param_3,longlong param_4,uint *param_5)

{
  char *pcVar1;
  uint *puVar2;
  uint *puVar3;
  longlong lVar4;
  int iVar5;
  ulonglong uVar6;
  ulonglong uVar7;
  char *pcVar8;
  byte *pbVar9;
  ulonglong uVar10;
  uint uVar11;
  undefined1 auStack_98 [32];
  uint *puStack_78;
  uint uStack_64;
  uint uStack_60;
  uint uStack_5c;
  uint uStack_58;
  uint uStack_54;
  ulonglong uStack_50;
  
  uStack_50 = _DAT_141fd5040 ^ (ulonglong)auStack_98;
  if ((param_1 == (char *)0x0) || (*param_1 == '\0')) {
    uVar6 = 0x206f;
  }
  else if ((param_2 == 0) || (param_3 == 0)) {
    uVar6 = 0x2070;
  }
  else if ((param_4 == 0) || (uStack_64 = *param_5, uStack_64 < param_3)) {
    uVar6 = 0x2071;
  }
  else {
    uVar6 = 0;
    if (*(int *)(param_1 + 4) == 1) {
      iVar5 = *(int *)(param_1 + 8);
      if (iVar5 == 1) {
        uVar7 = uVar6;
        if (0xf < param_3) {
          do {
            iVar5 = (int)uVar7;
            if (*(int *)(param_1 + 0xc) == 1) {
              FUN_140bfa2a0();
            }
            else {
              FUN_140bfb050(uVar7 + param_2,uVar7 + param_4,*(undefined8 *)(param_1 + 0x20));
            }
            uVar7 = (ulonglong)(iVar5 + 0x10);
          } while (iVar5 + 0x20U <= param_3);
        }
        if ((param_3 & 0xf) != 0) {
          if ((uVar7 + param_2 != 0) && (uVar7 + param_4 != 0)) {
            func_0x000141867875(uVar7 + param_4,uVar7 + param_2,param_3 & 0xf);
          }
        }
      }
      else if (iVar5 == 2) {
        uVar7 = uVar6;
        if (param_3 != 0) {
          do {
            FUN_140bfa2a0(*(undefined8 *)(param_1 + 0x30),&uStack_60,*(undefined8 *)(param_1 + 0x20)
                         );
            lVar4 = *(longlong *)(param_1 + 0x30);
            pcVar8 = (char *)(lVar4 + 0xd);
            while( true ) {
              pcVar1 = pcVar8 + 2;
              *pcVar1 = *pcVar1 + '\x01';
              if (*pcVar1 != '\0') break;
              pcVar1 = pcVar8 + 1;
              *pcVar1 = *pcVar1 + '\x01';
              if ((*pcVar1 != '\0') || (*pcVar8 = *pcVar8 + '\x01', *pcVar8 != '\0')) break;
              pcVar1 = pcVar8 + -1;
              *pcVar1 = *pcVar1 + '\x01';
              if ((*pcVar1 != '\0') || (pcVar8 = pcVar8 + -4, (longlong)(pcVar8 + (2 - lVar4)) < 0))
              break;
            }
            uVar11 = (int)uVar7 + 0x10;
            if (param_3 < uVar11) {
              uVar11 = param_3 - (int)uVar7;
              uVar10 = (ulonglong)uVar11;
              if (uVar11 != 0) {
                pbVar9 = (byte *)(uVar7 + param_4);
                do {
                  *pbVar9 = pbVar9[(longlong)&uStack_60 + (-param_4 - uVar7)] ^
                            pbVar9[param_2 - param_4];
                  pbVar9 = pbVar9 + 1;
                  uVar10 = uVar10 - 1;
                } while (uVar10 != 0);
              }
              break;
            }
            puVar2 = (uint *)(uVar7 + param_4);
            puVar3 = (uint *)(uVar7 + param_2);
            *puVar2 = uStack_60 ^ *puVar3;
            puVar2[1] = uStack_5c ^ puVar3[1];
            puVar2[2] = uStack_58 ^ puVar3[2];
            puVar2[3] = uStack_54 ^ puVar3[3];
            uVar7 = (ulonglong)uVar11;
          } while (uVar11 < param_3);
        }
      }
      else {
        if (iVar5 != 3) {
          if (iVar5 != 4) {
            return 0;
          }
          puStack_78 = param_5;
          uVar6 = FUN_140bfc320(param_1,param_2);
          return uVar6;
        }
        puStack_78 = param_5;
        uVar7 = FUN_140bfc1e0(param_1,param_2);
        if ((int)uVar7 != 0) {
          return uVar7;
        }
        if ((param_3 & 0xf) == 0) {
          return 0;
        }
        param_2 = (ulonglong)*param_5 + param_2;
        param_4 = (ulonglong)*param_5 + param_4;
        if ((param_2 != 0) && (param_4 != 0)) {
          func_0x000141867875(param_4,param_2,param_3 & 0xf);
        }
      }
      *param_5 = param_3;
    }
    else if (*(int *)(param_1 + 4) == 2) {
      iVar5 = 0;
      if (*(int *)(param_1 + 0xc) == 1) {
        puStack_78 = (uint *)CONCAT44(puStack_78._4_4_,param_3);
        iVar5 = FUN_1417e9660(**(undefined8 **)(param_1 + 0x20),param_4,&uStack_64,param_2);
      }
      else if (*(int *)(param_1 + 0xc) == 2) {
        puStack_78 = (uint *)CONCAT44(puStack_78._4_4_,param_3);
        iVar5 = FUN_1417e9380(**(undefined8 **)(param_1 + 0x20),param_4,&uStack_64,param_2);
      }
      *param_5 = uStack_64;
      if (iVar5 != 1) {
        uVar6 = 0x20a5;
      }
    }
  }
  return uVar6;
}

