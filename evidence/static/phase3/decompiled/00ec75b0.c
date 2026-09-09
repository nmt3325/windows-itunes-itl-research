/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xec75b0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_140ec75b0(longlong param_1,char *param_2,ulonglong param_3,undefined8 *param_4)

{
  uint *puVar1;
  int *piVar2;
  longlong lVar3;
  double dVar4;
  char cVar5;
  uint uVar6;
  int iVar7;
  longlong lVar8;
  longlong lVar9;
  longlong lVar10;
  ulonglong uVar11;
  longlong lVar12;
  undefined *puVar13;
  int *piVar14;
  double dVar15;
  undefined1 auStack_4b8 [32];
  undefined4 uStack_498;
  longlong lStack_488;
  byte abStack_480 [2];
  undefined6 uStack_47e;
  undefined8 uStack_478;
  undefined8 uStack_470;
  undefined8 uStack_468;
  ushort uStack_458;
  undefined1 auStack_456 [510];
  short sStack_258;
  undefined1 auStack_256 [510];
  ulonglong uStack_58;
  
  if (param_1 == 0) {
    return;
  }
  uStack_58 = _DAT_141fd5040 ^ (ulonglong)auStack_4b8;
  lVar10 = *(longlong *)(param_1 + 8);
  if (lVar10 == 0) {
    return;
  }
  if (*(longlong *)(lVar10 + 0x10) == 0) {
    return;
  }
  lVar12 = 0;
  abStack_480[0] = 0;
  abStack_480[1] = 0;
  uStack_47e = 0;
  uStack_478 = 0;
  uStack_470 = 0;
  uStack_468 = 0;
  if (((*(byte *)(lVar10 + 0x9a) & 0x10) != 0) && (param_1 == *(longlong *)(lVar10 + 0x58))) {
    sStack_258 = 0;
    if ((*(longlong *)(lVar10 + 0x10) != 0) &&
       ((FUN_140bff470(*(longlong *)(lVar10 + 0x10) + 0x178,*(undefined4 *)(lVar10 + 0xb0),
                       &sStack_258), sStack_258 != 0 && (*(char *)(param_1 + 0x298) != '\0')))) {
      piVar14 = (int *)(param_1 + 0x78);
      uStack_458 = 0;
      if ((piVar14 != (int *)0x0) &&
         ((*(longlong *)(param_1 + 0x88) != 0 &&
          ((*piVar14 == 0x41464350 || (*piVar14 == 0x57696e50)))))) {
        (**(code **)(*(longlong *)(param_1 + 0x88) + 0x10))(piVar14,&uStack_458);
      }
      uStack_498 = 0;
      cVar5 = FUN_140ae4f40(auStack_456,uStack_458,auStack_256,sStack_258);
      if (cVar5 == '\0') {
        FUN_140ae48a0(&uStack_458,0);
        uStack_498 = 0;
        cVar5 = FUN_140ae4f40(auStack_456,uStack_458,auStack_256,sStack_258);
        if (cVar5 == '\0') {
          lVar9 = *(longlong *)(lVar10 + 0x10);
          if (lVar9 != 0) {
            piVar14 = (int *)(lVar9 + 0x178);
            if (uStack_458 < 0x100) {
              if (((piVar14 != (int *)0x0) && (*piVar14 == 0x73747263)) &&
                 (*(int *)(lVar9 + 0x1a0) == 0)) {
                iVar7 = *(int *)(lVar10 + 0xb0);
                lVar8 = (longlong)iVar7;
                if (*(int *)(lVar9 + 0x1b4) == 0) {
                  if (iVar7 != 0) {
                    if ((iVar7 < 1) || (*(int *)(lVar9 + 0x1a4) < iVar7)) goto LAB_140ec77c1;
                    if ((*(byte *)(lVar9 + 0x17c) & 1) != 0) {
                      piVar2 = (int *)(**(longlong **)(lVar9 + 400) + -4 + lVar8 * 4);
                      *piVar2 = *piVar2 + -1;
                      if (*piVar2 != 0) goto LAB_140ec77ad;
                    }
                    lVar3 = **(longlong **)(lVar9 + 0x188);
                    *(int *)(lVar9 + 0x1b8) =
                         *(int *)(lVar9 + 0x1b8) + *(int *)(lVar3 + -4 + lVar8 * 8);
                    *(undefined4 *)(lVar3 + -8 + lVar8 * 8) = 0x80000001;
                  }
LAB_140ec77ad:
                  FUN_140bfe1f0(piVar14,auStack_456,(uint)uStack_458 * 2,lVar10 + 0xb0);
                }
              }
            }
            else {
              *(undefined4 *)(lVar10 + 0xb0) = 0;
            }
LAB_140ec77c1:
            FUN_140ec7b80(lVar10,0);
          }
          abStack_480[0] = abStack_480[0] | 0x20;
        }
      }
    }
  }
  if (*(char *)(param_1 + 0x3c) == '\x01') {
    lStack_488 = 0;
    if ((*(int *)(*(longlong *)(lVar10 + 0x10) + 0x84) == 0x646f5069) &&
       ((*(byte *)(*(longlong *)(lVar10 + 0x10) + 0x20fa) & 0x20) != 0)) {
    }
    else {
      dVar4 = (double)*(uint *)(param_2 + 8);
      lVar9 = CFTimeZoneCopyDefault();
      if (lVar9 != 0) {
        dVar15 = (double)CFTimeZoneGetSecondsFromGMT
                                   (lVar9,SUB84(dVar4 - *(double *)
                                                         kCFAbsoluteTimeIntervalSince1904_exref,0));
        dVar4 = dVar4 + dVar15;
        CFRelease(lVar9);
      }
      if (*(int *)(param_1 + 0x54) != (int)(longlong)dVar4) {
        abStack_480[1] = abStack_480[1] | 0x20;
        *(int *)(param_1 + 0x54) = (int)(longlong)dVar4;
      }
    }
    if (*param_2 == '\0') {
      lVar9 = *(longlong *)(param_2 + 0x20) + *(longlong *)(param_2 + 0x18);
    }
    else {
      lVar9 = *(longlong *)(param_1 + 0x60);
      if (((lVar9 == 0) && (-1 < *(char *)(param_1 + 0x41))) &&
         ((cVar5 = FUN_140bd0210(), cVar5 == '\0' ||
          ((uVar6 = FUN_140fa0b70(lVar10,0), (uVar6 >> 0x16 & 1) == 0 ||
           (iVar7 = FUN_140ec7390(param_1), lVar9 = lStack_488, iVar7 != 0)))))) {
        FUN_140b1e980(param_1 + 0x78,0,0,&lStack_488);
        lVar9 = lStack_488;
      }
    }
    if (*(longlong *)(param_1 + 0x60) != lVar9) {
      abStack_480[1] = abStack_480[1] | 8;
      *(longlong *)(param_1 + 0x60) = lVar9;
    }
  }
  lVar10 = 0x18;
  if (*param_2 == '\0') {
    lVar10 = 0x48;
  }
  iVar7 = *(int *)(param_2 + lVar10);
  if (*(int *)(param_1 + 0x2a0) != iVar7) {
    if (*(int *)(param_1 + 0x2a0) != 0) {
      *(undefined1 *)(param_1 + 0x3c) = 0;
    }
    *(int *)(param_1 + 0x2a0) = iVar7;
  }
  do {
    if (abStack_480[lVar12] != 0) {
      if ((param_3 & 2) != 0) goto LAB_140ec797a;
      puVar13 = &UNK_141b57358;
      uVar11 = 10;
      goto LAB_140ec7934;
    }
    lVar12 = lVar12 + 1;
  } while (lVar12 < 0x20);
LAB_140ec799d:
  if (param_4 != (undefined8 *)0x0) {
    *param_4 = CONCAT62(uStack_47e,CONCAT11(abStack_480[1],abStack_480[0]));
    param_4[1] = uStack_478;
    param_4[2] = uStack_470;
    param_4[3] = uStack_468;
  }
  return;
  while( true ) {
    puVar1 = (uint *)(puVar13 + 4);
    uVar11 = (ulonglong)*puVar1;
    puVar13 = puVar13 + 4;
    if (*puVar1 == 0) break;
LAB_140ec7934:
    if (((int)uVar11 < 0x100) &&
       ((abStack_480[uVar11 >> 3] & (byte)(0x80 >> ((byte)uVar11 & 7))) != 0)) {
      if (*(char *)(param_1 + 0x298) != '\0') {
        FUN_140eb9b10(param_1,param_1 + 0x78,0x803);
      }
      break;
    }
  }
LAB_140ec797a:
  if ((((param_3 & 1) == 0) && (lVar10 = *(longlong *)(param_1 + 8), lVar10 != 0)) &&
     (*(longlong *)(lVar10 + 0x10) != 0)) {
    FUN_140f94180(lVar10,param_1,abStack_480);
  }
  goto LAB_140ec799d;
}

