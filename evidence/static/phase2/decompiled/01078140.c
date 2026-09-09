/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1078140; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

int FUN_141078140(longlong param_1)

{
  int *piVar1;
  longlong lVar2;
  uint uVar3;
  int iVar4;
  uint *puVar5;
  undefined8 uVar6;
  ulonglong uVar7;
  uint uVar8;
  uint uVar9;
  longlong lVar10;
  longlong lVar11;
  char *pcVar12;
  int iVar13;
  undefined1 auStack_208 [32];
  char **ppcStack_1e8;
  undefined8 uStack_1e0;
  char **ppcStack_1d8;
  ulonglong uStack_1d0;
  char **ppcStack_1c8;
  longlong lStack_1b0;
  char *pcStack_1a8;
  char *pcStack_1a0;
  uint uStack_198;
  undefined4 uStack_188;
  undefined8 uStack_180;
  undefined1 auStack_178 [8];
  undefined4 uStack_170;
  undefined1 uStack_16c;
  undefined8 uStack_168;
  undefined1 uStack_160;
  undefined8 uStack_158;
  undefined1 auStack_150 [8];
  undefined4 auStack_148 [6];
  undefined1 auStack_130 [24];
  uint uStack_118;
  uint uStack_114;
  uint auStack_110 [6];
  uint uStack_f8;
  uint uStack_f4;
  uint auStack_f0 [3];
  ulonglong uStack_e4;
  char cStack_dc;
  char cStack_db;
  undefined1 uStack_da;
  ulonglong uStack_d8;
  char cStack_d0;
  char cStack_cf;
  uint uStack_cc;
  uint uStack_98;
  uint uStack_94;
  uint uStack_90;
  byte bStack_8c;
  ulonglong uStack_38;
  
  uStack_38 = _DAT_141fd5040 ^ (ulonglong)auStack_208;
  lVar10 = *(longlong *)(param_1 + 0x1e00270);
  lStack_1b0 = lVar10;
  iVar4 = FUN_1410770a0(param_1,&uStack_98,8);
  if (iVar4 != 0) {
    return iVar4;
  }
  pcVar12 = (char *)(param_1 + 0x52);
  uVar8 = uStack_94;
  if (*pcVar12 == '\0') {
    uVar8 = uStack_94 >> 0x18 | (uStack_94 & 0xff0000) >> 8 | (uStack_94 & 0xff00) << 8 |
            uStack_94 << 0x18;
  }
  puVar5 = &uStack_90;
  uVar9 = 0x5c;
  if (uVar8 < 0x5c) {
    uVar9 = uVar8;
  }
  if (8 < uVar9) {
    pcStack_1a8 = (char *)(ulonglong)(uVar9 - 8);
    if ((char *)0xa00000 < pcStack_1a8) {
      return -0xd0;
    }
    iVar4 = FUN_1410770a0(param_1,&uStack_90,uVar9 - 8);
    if (iVar4 != 0) {
      return iVar4;
    }
    puVar5 = (uint *)((longlong)&uStack_90 + (longlong)pcStack_1a8);
  }
  uVar7 = (ulonglong)uStack_94;
  if ((uVar9 < 0x5c) && (puVar5 != (uint *)0x0)) {
    func_0x00014179cca0(puVar5,0,0x5c - uVar9);
    uVar7 = (ulonglong)uStack_94;
  }
  if ((uVar9 < uVar8) && (iVar4 = itl_106a520(param_1), iVar4 != 0)) {
    return iVar4;
  }
  iVar4 = 0;
  if (*pcVar12 == '\0') {
    uVar8 = (uint)uVar7;
    uStack_98 = (uStack_98 & 0xff0000 | uStack_98 >> 0x10) >> 8 |
                (uStack_98 & 0xff00 | uStack_98 << 0x10) << 8;
    uStack_94 = (uVar8 & 0xff0000 | (uint)(uVar7 >> 0x10) & 0xffff) >> 8 |
                (uVar8 << 0x10 | uVar8 & 0xff00) << 8;
    uStack_90 = (uStack_90 & 0xff0000 | uStack_90 >> 0x10) >> 8 |
                (uStack_90 & 0xff00 | uStack_90 << 0x10) << 8;
  }
  if (uStack_98 != 0x68616c6d) {
    return -0xd0;
  }
  uStack_198 = 0;
  *(byte *)(lVar10 + 0x113) = (bStack_8c & 1) << 3 | *(byte *)(lVar10 + 0x113) & 0xf7;
  if (uStack_90 != 0) {
    do {
      uStack_188 = 0;
      uStack_180 = 0;
      uStack_170 = 0;
      uStack_168 = 0;
      uStack_158 = 0;
      auStack_148[0] = 0;
      auStack_178 = (undefined1  [8])0x0;
      uStack_16c = 0;
      uStack_160 = 0;
      auStack_150 = (undefined1  [8])0x0;
      pcStack_1a0 = pcVar12;
      iVar4 = FUN_1410770a0(param_1,&uStack_f8,8);
      if (iVar4 != 0) {
        return iVar4;
      }
      uVar8 = uStack_f4;
      if (*pcVar12 == '\0') {
        uVar8 = uStack_f4 >> 0x18 | (uStack_f4 & 0xff0000) >> 8 | (uStack_f4 & 0xff00) << 8 |
                uStack_f4 << 0x18;
      }
      puVar5 = auStack_f0;
      uVar9 = 0x58;
      if (uVar8 < 0x58) {
        uVar9 = uVar8;
      }
      if (8 < uVar9) {
        uVar7 = (ulonglong)(uVar9 - 8);
        if (0xa00000 < uVar7) {
          return -0xd0;
        }
        iVar4 = FUN_1410770a0(param_1,auStack_f0,uVar7);
        if (iVar4 != 0) {
          return iVar4;
        }
        puVar5 = (uint *)((longlong)auStack_f0 + uVar7);
        pcVar12 = pcStack_1a0;
      }
      uVar7 = (ulonglong)uStack_f4;
      if ((uVar9 < 0x58) && (puVar5 != (uint *)0x0)) {
        func_0x00014179cca0(puVar5,0,0x58 - uVar9);
        uVar7 = (ulonglong)uStack_f4;
      }
      if ((uVar9 < uVar8) && (iVar4 = itl_106a520(param_1,uVar8 - uVar9), iVar4 != 0)) {
        return iVar4;
      }
      if (*pcVar12 == '\0') {
        uVar8 = (uint)uVar7;
        uStack_f8 = (uStack_f8 & 0xff0000 | uStack_f8 >> 0x10) >> 8 |
                    (uStack_f8 << 0x10 | uStack_f8 & 0xff00) << 8;
        uStack_f4 = (uVar8 & 0xff0000 | (uint)(uVar7 >> 0x10) & 0xffff) >> 8 |
                    (uVar8 << 0x10 | uVar8 & 0xff00) << 8;
        auStack_f0[0] =
             (auStack_f0[0] & 0xff0000 | auStack_f0[0] >> 0x10) >> 8 |
             (auStack_f0[0] << 0x10 | auStack_f0[0] & 0xff00) << 8;
        auStack_f0[1] =
             (auStack_f0[1] & 0xff0000 | auStack_f0[1] >> 0x10) >> 8 |
             (auStack_f0[1] << 0x10 | auStack_f0[1] & 0xff00) << 8;
        auStack_f0[2] =
             (auStack_f0[2] & 0xff0000 | auStack_f0[2] >> 0x10) >> 8 |
             (auStack_f0[2] << 0x10 | auStack_f0[2] & 0xff00) << 8;
        uStack_e4 = (((uStack_e4 & 0xff000000000000 | uStack_e4 >> 0x10) >> 0x10 |
                     uStack_e4 & 0xff0000000000) >> 0x10 | uStack_e4 & 0xff00000000) >> 8 |
                    (((uStack_e4 << 0x10 | (ulonglong)((uint)uStack_e4 & 0xff00)) << 0x10 |
                     (ulonglong)((uint)uStack_e4 & 0xff0000)) << 0x10 | uStack_e4 & 0xff000000) << 8
        ;
        uStack_d8 = (((uStack_d8 & 0xff000000000000 | uStack_d8 >> 0x10) >> 0x10 |
                     uStack_d8 & 0xff0000000000) >> 0x10 | uStack_d8 & 0xff00000000) >> 8 |
                    (((uStack_d8 << 0x10 | (ulonglong)((uint)uStack_d8 & 0xff00)) << 0x10 |
                     (ulonglong)((uint)uStack_d8 & 0xff0000)) << 0x10 | uStack_d8 & 0xff000000) << 8
        ;
        uStack_cc = (uStack_cc & 0xff0000 | uStack_cc >> 0x10) >> 8 |
                    (uStack_cc << 0x10 | uStack_cc & 0xff00) << 8;
      }
      if (uStack_f8 != 0x6861696d) {
        return -0xd0;
      }
      uVar8 = 0;
      pcStack_1a0 = (char *)((ulonglong)pcStack_1a0 & 0xffffffff00000000);
      iVar4 = 0;
      iVar13 = 0;
      if (auStack_f0[1] != 0) {
        do {
          iVar4 = FUN_1410770a0(param_1,&uStack_118,8);
          if (iVar4 != 0) {
            return iVar4;
          }
          uVar9 = uStack_114;
          if (*pcVar12 == '\0') {
            uVar9 = (uStack_114 & 0xff0000 | uStack_114 >> 0x10) >> 8 |
                    (uStack_114 << 0x10 | uStack_114 & 0xff00) << 8;
          }
          puVar5 = auStack_110;
          uVar3 = 0x18;
          if (uVar9 < 0x18) {
            uVar3 = uVar9;
          }
          if (8 < uVar3) {
            uVar7 = (ulonglong)(uVar3 - 8);
            if (0xa00000 < uVar7) {
              return -0xd0;
            }
            iVar4 = FUN_1410770a0(param_1,auStack_110,uVar7);
            if (iVar4 != 0) {
              return iVar4;
            }
            puVar5 = (uint *)((longlong)auStack_110 + uVar7);
          }
          uVar7 = (ulonglong)uStack_114;
          if ((uVar3 < 0x18) && (puVar5 != (uint *)0x0)) {
            func_0x00014179cca0(puVar5,0,0x18 - uVar3);
            uVar7 = (ulonglong)uStack_114;
          }
          if ((uVar3 < uVar9) && (iVar4 = itl_106a520(param_1,uVar9 - uVar3), iVar4 != 0)) {
            return iVar4;
          }
          uVar9 = (uint)uVar7;
          if (*pcVar12 == '\0') {
            uStack_118 = (uStack_118 & 0xff0000 | uStack_118 >> 0x10) >> 8 |
                         (uStack_118 << 0x10 | uStack_118 & 0xff00) << 8;
            uVar9 = (uVar9 & 0xff0000 | (uint)(uVar7 >> 0x10) & 0xffff) >> 8 |
                    (uVar9 << 0x10 | uVar9 & 0xff00) << 8;
            auStack_110[0] =
                 (auStack_110[0] & 0xff0000 | auStack_110[0] >> 0x10) >> 8 |
                 (auStack_110[0] << 0x10 | auStack_110[0] & 0xff00) << 8;
            auStack_110[1] =
                 (auStack_110[1] & 0xff0000 | auStack_110[1] >> 0x10) >> 8 |
                 (auStack_110[1] << 0x10 | auStack_110[1] & 0xff00) << 8;
            auStack_110[2] =
                 (auStack_110[2] & 0xff0000 | auStack_110[2] >> 0x10) >> 8 |
                 (auStack_110[2] << 0x10 | auStack_110[2] & 0xff00) << 8;
            uStack_114 = uVar9;
          }
          if (uStack_118 != 0x686f686d) {
            return -0xd0;
          }
          switch(auStack_110[1]) {
          case 300:
            lVar10 = lStack_1b0 + 0x1c0;
            goto code_r0x0001410788ee;
          case 0x12d:
            ppcStack_1e8 = (char **)(auStack_178 + 4);
            lVar10 = lStack_1b0 + 0x208;
            break;
          case 0x12e:
            ppcStack_1e8 = (char **)&uStack_170;
            lVar10 = lStack_1b0 + 0x208;
            break;
          case 0x12f:
            ppcStack_1e8 = &pcStack_1a0;
            lVar10 = lStack_1b0 + 0x5b0;
            uStack_1e0 = CONCAT44(uStack_1e0._4_4_,1);
            uVar6 = 0;
            goto code_r0x0001410788ff;
          case 0x130:
            lVar10 = lStack_1b0 + 0x640;
code_r0x0001410788ee:
            ppcStack_1e8 = (char **)auStack_178;
            break;
          case 0x131:
            ppcStack_1e8 = (char **)(auStack_150 + 4);
            lVar10 = lStack_1b0 + 0x5b0;
            uStack_1e0 = CONCAT44(uStack_1e0._4_4_,1);
            uVar6 = 0;
            goto code_r0x0001410788ff;
          default:
            uVar7 = (longlong)(int)(auStack_110[0] - uVar9) + *(longlong *)(param_1 + 0x1e00170);
            *(ulonglong *)(param_1 + 0x1e00170) = uVar7;
            if ((uVar7 < *(ulonglong *)(param_1 + 0x1e00178)) ||
               (*(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180) <= uVar7))
            {
              *(undefined8 *)(param_1 + 0x1e00180) = 0;
            }
            goto LAB_14107894f;
          case 0x133:
            ppcStack_1e8 = (char **)auStack_148;
            lVar10 = lStack_1b0 + 0x5b0;
            uVar6 = 0;
            goto code_r0x0001410788f7;
          }
          uVar6 = 1;
code_r0x0001410788f7:
          uStack_1e0 = (ulonglong)uStack_1e0._4_4_ << 0x20;
code_r0x0001410788ff:
          iVar4 = FUN_1410773d0(param_1,uVar6,lVar10,auStack_110[2]);
          if (iVar4 != 0) {
            return iVar4;
          }
LAB_14107894f:
          uVar8 = uVar8 + 1;
        } while (uVar8 < auStack_f0[1]);
        lVar10 = lStack_1b0;
        iVar4 = (int)pcStack_1a0;
        iVar13 = auStack_150._4_4_;
      }
      if (cStack_dc == '\x03') {
        if (iVar13 == 0) {
          if (iVar4 != 0) {
            iVar13 = iVar4;
          }
        }
        else if (((((int *)(lVar10 + 0x5b0) != (int *)0x0) &&
                  (*(int *)(lVar10 + 0x5b0) == 0x73747263)) && (*(int *)(lVar10 + 0x5ec) == 0)) &&
                ((0 < iVar4 && (iVar4 <= *(int *)(lVar10 + 0x5dc))))) {
          lVar11 = (longlong)iVar4;
          if ((*(byte *)(lVar10 + 0x5b4) & 1) != 0) {
            piVar1 = (int *)(**(longlong **)(lVar10 + 0x5c8) + -4 + lVar11 * 4);
            *piVar1 = *piVar1 + -1;
            if (*piVar1 != 0) goto LAB_1410789d1;
          }
          lVar2 = **(longlong **)(lVar10 + 0x5c0);
          *(int *)(lVar10 + 0x5f0) = *(int *)(lVar10 + 0x5f0) + *(int *)(lVar2 + -4 + lVar11 * 8);
          *(undefined4 *)(lVar2 + -8 + lVar11 * 8) = 0x80000001;
        }
      }
LAB_1410789d1:
      if (cStack_dc == '\x02') {
        ppcStack_1c8 = &pcStack_1a8;
        uStack_1d0 = uStack_d8;
        ppcStack_1d8 = (char **)CONCAT71(ppcStack_1d8._1_7_,uStack_da);
        uStack_1e0 = uStack_e4;
        ppcStack_1e8 = (char **)CONCAT71(ppcStack_1e8._1_7_,cStack_db != '\0');
        iVar4 = FUN_141087800(lVar10,(ulonglong)auStack_178 & 0xffffffff,auStack_178._4_4_,
                              uStack_170);
LAB_141078a84:
        if (iVar4 == 0x234e) goto LAB_141078a8d;
        if (iVar4 == 0) {
          if (auStack_f0[2] != 0) {
            FUN_140693570(param_1 + 0x1e002c0,auStack_130,auStack_f0 + 2,&pcStack_1a8);
          }
          if (cStack_cf == '\0') {
            if ((('\0' < cStack_d0) && (*(longlong *)(pcStack_1a8 + 0x30) != 0)) &&
               ((~*(byte *)(*(longlong *)(pcStack_1a8 + 0x30) + 0x114) & 1) != 0)) {
              pcStack_1a8[0x71] = cStack_d0;
              pcStack_1a8[0x72] = '\x01';
            }
          }
          else if ((*(longlong *)(pcStack_1a8 + 0x30) != 0) &&
                  ((~*(byte *)(*(longlong *)(pcStack_1a8 + 0x30) + 0x114) & 1) != 0)) {
            pcStack_1a8[0x71] = cStack_d0;
            pcStack_1a8[0x72] = cStack_cf;
          }
          FUN_140f6be90();
        }
      }
      else {
        if (cStack_dc == '\x03') {
LAB_141078a0a:
          ppcStack_1d8 = &pcStack_1a8;
          uStack_1e0 = uStack_e4;
          ppcStack_1e8 = (char **)CONCAT44(ppcStack_1e8._4_4_,auStack_148[0]);
          iVar4 = FUN_141087930(lVar10,3,(ulonglong)auStack_178 & 0xffffffff,iVar13);
          goto LAB_141078a84;
        }
        if (cStack_dc == '\x04') {
          ppcStack_1e8 = &pcStack_1a8;
          iVar4 = FUN_141087a30(lVar10,(ulonglong)auStack_178 & 0xffffffff,uStack_cc,uStack_e4);
          goto LAB_141078a84;
        }
        if ((cStack_dc != '\x05') && (cStack_dc == '\x06')) goto LAB_141078a0a;
LAB_141078a8d:
        iVar4 = 0;
      }
      *(longlong *)(param_1 + 0x1e00190) = *(longlong *)(param_1 + 0x1e00190) + 1;
      FUN_141077340(param_1);
      uStack_198 = uStack_198 + 1;
    } while (uStack_198 < uStack_90);
  }
  *(undefined1 *)(param_1 + 0x1e001a8) = 1;
  return iVar4;
}

