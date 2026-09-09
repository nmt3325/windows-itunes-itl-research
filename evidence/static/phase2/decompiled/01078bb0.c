/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1078bb0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Type propagation algorithm not settling */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

int FUN_141078bb0(longlong param_1)

{
  longlong *plVar1;
  int *piVar2;
  uint uVar3;
  longlong lVar4;
  longlong *plVar5;
  int iVar6;
  undefined4 uVar7;
  ulonglong uVar8;
  longlong lVar9;
  longlong *plVar10;
  uint *puVar11;
  ulonglong uVar12;
  uint uVar13;
  uint uVar14;
  longlong lVar15;
  char *pcVar16;
  bool bVar17;
  undefined1 auStack_1e8 [32];
  char **ppcStack_1c8;
  ulonglong uStack_1c0;
  ulonglong uStack_1b8;
  longlong **pplStack_1b0;
  ulonglong uStack_1a8;
  undefined4 uStack_1a0;
  uint uStack_19c;
  char *pcStack_198;
  longlong lStack_190;
  longlong *plStack_188;
  ulonglong uStack_180;
  longlong lStack_178;
  longlong *plStack_170;
  longlong *plStack_168;
  longlong *plStack_160;
  undefined1 auStack_150 [24];
  uint uStack_138;
  uint uStack_134;
  uint auStack_130 [6];
  uint uStack_118;
  uint uStack_114;
  uint auStack_110 [3];
  ulonglong uStack_104;
  char cStack_fc;
  undefined1 uStack_fb;
  char cStack_fa;
  char cStack_f9;
  ulonglong uStack_f8;
  ulonglong uStack_e8;
  uint uStack_e0;
  ulonglong uStack_dc;
  uint uStack_a8;
  uint uStack_a4;
  uint uStack_a0;
  ulonglong uStack_9c;
  ulonglong uStack_38;
  
  uStack_38 = _DAT_141fd5040 ^ (ulonglong)auStack_1e8;
  lVar15 = *(longlong *)(param_1 + 0x1e00270);
  lStack_190 = lVar15;
  iVar6 = FUN_1410770a0(param_1,&uStack_a8,8);
  if (iVar6 != 0) {
    return iVar6;
  }
  pcVar16 = (char *)(param_1 + 0x52);
  uVar13 = uStack_a4;
  if (*pcVar16 == '\0') {
    uVar13 = uStack_a4 >> 0x18 | (uStack_a4 & 0xff0000) >> 8 | (uStack_a4 & 0xff00) << 8 |
             uStack_a4 << 0x18;
  }
  puVar11 = &uStack_a0;
  uVar14 = 100;
  if (uVar13 < 100) {
    uVar14 = uVar13;
  }
  if (8 < uVar14) {
    uVar8 = (ulonglong)(uVar14 - 8);
    if (0xa00000 < uVar8) {
      return -0xd0;
    }
    iVar6 = FUN_1410770a0(param_1,&uStack_a0,uVar8);
    if (iVar6 != 0) {
      return iVar6;
    }
    puVar11 = (uint *)((longlong)&uStack_a0 + uVar8);
  }
  uVar8 = (ulonglong)uStack_a4;
  if ((uVar14 < 100) && (puVar11 != (uint *)0x0)) {
    func_0x00014179cca0(puVar11,0,100 - uVar14);
    uVar8 = (ulonglong)uStack_a4;
  }
  if ((uVar14 < uVar13) && (iVar6 = itl_106a520(param_1,uVar13 - uVar14), iVar6 != 0)) {
    return iVar6;
  }
  if (*pcVar16 == '\0') {
    uStack_a8 = (uStack_a8 & 0xff0000 | uStack_a8 >> 0x10) >> 8 |
                (uStack_a8 & 0xff00 | uStack_a8 << 0x10) << 8;
    uVar13 = (uint)uVar8;
    uStack_a4 = (uVar13 & 0xff0000 | (uint)(uVar8 >> 0x10) & 0xffff) >> 8 |
                (uVar13 << 0x10 | uVar13 & 0xff00) << 8;
    uStack_a0 = (uStack_a0 & 0xff0000 | uStack_a0 >> 0x10) >> 8 |
                (uStack_a0 & 0xff00 | uStack_a0 << 0x10) << 8;
    uStack_9c = (((uStack_9c & 0xff000000000000 | uStack_9c >> 0x10) >> 0x10 |
                 uStack_9c & 0xff0000000000) >> 0x10 | uStack_9c & 0xff00000000) >> 8 |
                (((uStack_9c << 0x10 | (ulonglong)((uint)uStack_9c & 0xff00)) << 0x10 |
                 (ulonglong)((uint)uStack_9c & 0xff0000)) << 0x10 | uStack_9c & 0xff000000) << 8;
  }
  if (uStack_a8 != 0x68696c6d) {
    return -0xd0;
  }
  uStack_19c = 0;
  if (uStack_a0 != 0) {
    do {
      uVar8 = 0;
      plStack_188 = (longlong *)0x0;
      uStack_1a0 = 0;
      uStack_180 = 0;
      pcStack_198 = pcVar16;
      iVar6 = FUN_1410770a0(param_1,&uStack_118,8);
      if (iVar6 != 0) {
        return iVar6;
      }
      uVar13 = uStack_114;
      if (*pcVar16 == '\0') {
        uVar13 = (uStack_114 & 0xff0000 | uStack_114 >> 0x10) >> 8 |
                 (uStack_114 << 0x10 | uStack_114 & 0xff00) << 8;
      }
      puVar11 = auStack_110;
      uVar14 = 100;
      if (uVar13 < 100) {
        uVar14 = uVar13;
      }
      if (8 < uVar14) {
        uVar12 = (ulonglong)(uVar14 - 8);
        if (0xa00000 < uVar12) {
          return -0xd0;
        }
        iVar6 = FUN_1410770a0(param_1,auStack_110,uVar12);
        if (iVar6 != 0) {
          return iVar6;
        }
        puVar11 = (uint *)((longlong)auStack_110 + uVar12);
        pcVar16 = pcStack_198;
      }
      uVar12 = (ulonglong)uStack_114;
      if ((uVar14 < 100) && (puVar11 != (uint *)0x0)) {
        func_0x00014179cca0(puVar11,0,100 - uVar14);
        uVar12 = (ulonglong)uStack_114;
      }
      if ((uVar14 < uVar13) && (iVar6 = itl_106a520(param_1), iVar6 != 0)) {
        return iVar6;
      }
      if (*pcVar16 == '\0') {
        uStack_118 = (uStack_118 & 0xff0000 | uStack_118 >> 0x10) >> 8 |
                     (uStack_118 << 0x10 | uStack_118 & 0xff00) << 8;
        uVar13 = (uint)uVar12;
        uStack_114 = (uVar13 & 0xff0000 | (uint)(uVar12 >> 0x10) & 0xffff) >> 8 |
                     (uVar13 << 0x10 | uVar13 & 0xff00) << 8;
        auStack_110[0] =
             (auStack_110[0] & 0xff0000 | auStack_110[0] >> 0x10) >> 8 |
             (auStack_110[0] << 0x10 | auStack_110[0] & 0xff00) << 8;
        auStack_110[1] =
             (auStack_110[1] & 0xff0000 | auStack_110[1] >> 0x10) >> 8 |
             (auStack_110[1] << 0x10 | auStack_110[1] & 0xff00) << 8;
        auStack_110[2] =
             (auStack_110[2] & 0xff0000 | auStack_110[2] >> 0x10) >> 8 |
             (auStack_110[2] << 0x10 | auStack_110[2] & 0xff00) << 8;
        uStack_104 = (((uStack_104 & 0xff000000000000 | uStack_104 >> 0x10) >> 0x10 |
                      uStack_104 & 0xff0000000000) >> 0x10 | uStack_104 & 0xff00000000) >> 8 |
                     (((uStack_104 << 0x10 | (ulonglong)((uint)uStack_104 & 0xff00)) << 0x10 |
                      (ulonglong)((uint)uStack_104 & 0xff0000)) << 0x10 | uStack_104 & 0xff000000)
                     << 8;
        uStack_f8 = (((uStack_f8 & 0xff000000000000 | uStack_f8 >> 0x10) >> 0x10 |
                     uStack_f8 & 0xff0000000000) >> 0x10 | uStack_f8 & 0xff00000000) >> 8 |
                    (((uStack_f8 << 0x10 | (ulonglong)((uint)uStack_f8 & 0xff00)) << 0x10 |
                     (ulonglong)((uint)uStack_f8 & 0xff0000)) << 0x10 | uStack_f8 & 0xff000000) << 8
        ;
        uStack_e8 = (((uStack_e8 & 0xff000000000000 | uStack_e8 >> 0x10) >> 0x10 |
                     uStack_e8 & 0xff0000000000) >> 0x10 | uStack_e8 & 0xff00000000) >> 8 |
                    (((uStack_e8 << 0x10 | (ulonglong)((uint)uStack_e8 & 0xff00)) << 0x10 |
                     (ulonglong)((uint)uStack_e8 & 0xff0000)) << 0x10 | uStack_e8 & 0xff000000) << 8
        ;
        uStack_e0 = (uStack_e0 & 0xff0000 | uStack_e0 >> 0x10) >> 8 |
                    (uStack_e0 << 0x10 | uStack_e0 & 0xff00) << 8;
        uStack_dc = (((uStack_dc & 0xff000000000000 | uStack_dc >> 0x10) >> 0x10 |
                     uStack_dc & 0xff0000000000) >> 0x10 | uStack_dc & 0xff00000000) >> 8 |
                    (((uStack_dc << 0x10 | (ulonglong)((uint)uStack_dc & 0xff00)) << 0x10 |
                     (ulonglong)((uint)uStack_dc & 0xff0000)) << 0x10 | uStack_dc & 0xff000000) << 8
        ;
      }
      if (uStack_118 != 0x6869696d) {
        return -0xd0;
      }
      uVar12 = 0;
      pcStack_198 = (char *)((ulonglong)pcStack_198 & 0xffffffff00000000);
      uVar13 = 0;
      uStack_1a8 = uStack_1a8 & 0xffffffff00000000;
      if (auStack_110[1] != 0) {
        do {
          iVar6 = FUN_1410770a0(param_1,&uStack_138,8);
          if (iVar6 != 0) goto LAB_141079712;
          uVar14 = uStack_134;
          if (*pcVar16 == '\0') {
            uVar14 = (uStack_134 & 0xff0000 | uStack_134 >> 0x10) >> 8 |
                     (uStack_134 << 0x10 | uStack_134 & 0xff00) << 8;
          }
          puVar11 = auStack_130;
          uVar3 = 0x18;
          if (uVar14 < 0x18) {
            uVar3 = uVar14;
          }
          if (8 < uVar3) {
            uVar12 = (ulonglong)(uVar3 - 8);
            if (uVar12 < 0xa00001) {
              iVar6 = FUN_1410770a0(param_1,auStack_130,uVar12);
              if (iVar6 == 0) {
                puVar11 = (uint *)((longlong)auStack_130 + uVar12);
                uVar13 = (uint)uStack_1a8;
                goto LAB_1410792a1;
              }
            }
            else {
LAB_14107970d:
              iVar6 = -0xd0;
            }
            goto LAB_141079712;
          }
LAB_1410792a1:
          uVar12 = (ulonglong)uStack_134;
          if ((uVar3 < 0x18) && (puVar11 != (uint *)0x0)) {
            func_0x00014179cca0(puVar11,0,0x18 - uVar3);
            uVar12 = (ulonglong)uStack_134;
          }
          if ((uVar3 < uVar14) && (iVar6 = itl_106a520(param_1,uVar14 - uVar3), iVar6 != 0))
          goto LAB_141079712;
          uVar14 = (uint)uVar12;
          if (*pcVar16 == '\0') {
            uStack_138 = (uStack_138 & 0xff0000 | uStack_138 >> 0x10) >> 8 |
                         (uStack_138 << 0x10 | uStack_138 & 0xff00) << 8;
            uVar14 = (uVar14 & 0xff0000 | (uint)(uVar12 >> 0x10) & 0xffff) >> 8 |
                     (uVar14 << 0x10 | uVar14 & 0xff00) << 8;
            auStack_130[0] =
                 (auStack_130[0] & 0xff0000 | auStack_130[0] >> 0x10) >> 8 |
                 (auStack_130[0] << 0x10 | auStack_130[0] & 0xff00) << 8;
            auStack_130[1] =
                 (auStack_130[1] & 0xff0000 | auStack_130[1] >> 0x10) >> 8 |
                 (auStack_130[1] << 0x10 | auStack_130[1] & 0xff00) << 8;
            auStack_130[2] =
                 (auStack_130[2] & 0xff0000 | auStack_130[2] >> 0x10) >> 8 |
                 (auStack_130[2] << 0x10 | auStack_130[2] & 0xff00) << 8;
            uStack_134 = uVar14;
          }
          if (uStack_138 != 0x686f686d) goto LAB_14107970d;
          if (auStack_130[1] == 400) {
            lVar15 = lStack_190 + 0x208;
            ppcStack_1c8 = &pcStack_198;
LAB_1410794ac:
            uStack_1c0 = uStack_1c0 & 0xffffffff00000000;
            iVar6 = FUN_1410773d0(param_1,1,lVar15,auStack_130[2]);
LAB_1410794cb:
            if (iVar6 != 0) goto LAB_141079712;
          }
          else {
            if (auStack_130[1] == 0x191) {
              lVar15 = lStack_190 + 0x17f8;
              ppcStack_1c8 = (char **)&uStack_1a0;
              goto LAB_1410794ac;
            }
            if (auStack_130[1] == 0x192) {
              uStack_1a8 = 0;
              iVar6 = FUN_141077ee0(param_1,auStack_130[0] - uVar14,&uStack_1a8);
              if ((uStack_1a8 != 0) &&
                 (uStack_180 = uStack_1a8, bVar17 = uVar8 != 0, uVar8 = uStack_1a8, bVar17)) {
                CFRelease();
              }
              goto LAB_1410794cb;
            }
            uVar12 = (longlong)(int)(auStack_130[0] - uVar14) + *(longlong *)(param_1 + 0x1e00170);
            *(ulonglong *)(param_1 + 0x1e00170) = uVar12;
            if ((uVar12 < *(ulonglong *)(param_1 + 0x1e00178)) ||
               (*(ulonglong *)(param_1 + 0x1e00178) + *(longlong *)(param_1 + 0x1e00180) <= uVar12))
            {
              *(undefined8 *)(param_1 + 0x1e00180) = 0;
            }
          }
          uVar13 = uVar13 + 1;
          uStack_1a8 = CONCAT44(uStack_1a8._4_4_,uVar13);
        } while (uVar13 < auStack_110[1]);
        uVar12 = (ulonglong)pcStack_198 & 0xffffffff;
        lVar15 = lStack_190;
      }
      if (cStack_fc == '\x02') {
        pplStack_1b0 = &plStack_188;
        uStack_1b8 = uStack_dc;
        uStack_1c0 = uStack_f8;
        ppcStack_1c8 = (char **)CONCAT71(ppcStack_1c8._1_7_,uStack_fb);
        iVar6 = FUN_140f6e820(lVar15,uVar12,uStack_1a0,uStack_104);
        plVar10 = plStack_188;
        if (iVar6 != 0) {
LAB_141079712:
          if (uVar8 == 0) {
            return iVar6;
          }
          CFRelease(uVar8);
          return iVar6;
        }
        if (uVar8 != 0) {
          (**(code **)(*plStack_188 + 0x90))(plStack_188,&lStack_178,1);
          lVar4 = lStack_178;
          if (lStack_178 != 0) {
            lVar9 = *(longlong *)(lStack_178 + 0x18);
            if (lVar9 == 0) {
              lVar9 = CFDictionaryCreateMutable
                                (_DAT_1420a6090,0,kCFTypeDictionaryKeyCallBacks_exref,
                                 kCFTypeDictionaryValueCallBacks_exref);
              *(longlong *)(lVar4 + 0x18) = lVar9;
              if (lVar9 == 0) goto LAB_1410795a7;
            }
            CFDictionaryApplyFunction(uVar8,&UNK_140bbc0a0,lVar9);
          }
LAB_1410795a7:
          plVar5 = plStack_170;
          if (plStack_170 != (longlong *)0x0) {
            LOCK();
            plVar1 = plStack_170 + 1;
            lVar4 = *plVar1;
            *(int *)plVar1 = (int)*plVar1 + -1;
            UNLOCK();
            if ((int)lVar4 == 1) {
              (**(code **)*plStack_170)(plStack_170);
              LOCK();
              piVar2 = (int *)((longlong)plVar5 + 0xc);
              iVar6 = *piVar2;
              *piVar2 = *piVar2 + -1;
              UNLOCK();
              if (iVar6 == 1) {
                (**(code **)(*plVar5 + 8))(plVar5);
              }
            }
          }
        }
        if (uStack_e8 != 0) {
          (**(code **)(*plVar10 + 0x98))(plVar10,&plStack_168,1);
          if (plStack_168 != (longlong *)0x0) {
            (**(code **)(*plStack_168 + 0x60))(plStack_168,5,uStack_e8);
          }
          plVar5 = plStack_160;
          if (plStack_160 != (longlong *)0x0) {
            LOCK();
            plVar1 = plStack_160 + 1;
            lVar4 = *plVar1;
            *(int *)plVar1 = (int)*plVar1 + -1;
            UNLOCK();
            if ((int)lVar4 == 1) {
              (**(code **)*plStack_160)(plStack_160);
              LOCK();
              piVar2 = (int *)((longlong)plVar5 + 0xc);
              iVar6 = *piVar2;
              *piVar2 = *piVar2 + -1;
              UNLOCK();
              if (iVar6 == 1) {
                (**(code **)(*plVar5 + 8))(plVar5);
              }
            }
          }
        }
        if (uStack_f8 != 0) {
          FUN_140f70c50(plVar10);
        }
        if ((bool)(*(byte *)((longlong)plVar10 + 0x8c) >> 4 & 1) != (cStack_fa != '\0')) {
          *(byte *)((longlong)plVar10 + 0x8c) =
               (cStack_fa != '\0') << 4 | *(byte *)((longlong)plVar10 + 0x8c) & 0xef;
          *(uint *)(plVar10 + 0x18) = *(uint *)(plVar10 + 0x18) | 8;
        }
        if (*(char *)((longlong)plVar10 + 0xc4) != cStack_f9) {
          *(char *)((longlong)plVar10 + 0xc4) = cStack_f9;
          *(uint *)(plVar10 + 0x18) = *(uint *)(plVar10 + 0x18) | 0x10;
        }
        *(uint *)(plVar10 + 0x19) = uStack_e0;
        if (auStack_110[2] != 0) {
          FUN_140693570(param_1 + 0x1e002d8,auStack_150,auStack_110 + 2,&plStack_188);
        }
        *(longlong *)(param_1 + 0x1e00190) = *(longlong *)(param_1 + 0x1e00190) + 1;
        FUN_141077340(param_1);
      }
      if (uVar8 != 0) {
        CFRelease(uVar8);
      }
      uStack_19c = uStack_19c + 1;
    } while (uStack_19c < uStack_a0);
  }
  if (((uStack_9c != 0) && (lVar15 != 0)) && (*(int *)(lVar15 + 0x80) == 0x74646174)) {
    plVar10 = *(longlong **)(lVar15 + 0xf8);
    if (plVar10 == (longlong *)0x0) {
      plVar10 = (longlong *)FUN_140f6e110(lVar15,0,1000);
      if (plVar10 == (longlong *)0x0) goto LAB_1410797cb;
      *(longlong **)(lVar15 + 0xf8) = plVar10;
    }
    uVar7 = GetCurrentThreadId();
    FUN_140bd00e0(uVar7);
    (**(code **)(*plVar10 + 0xc0))(plVar10);
    FUN_140f70c50(plVar10,uStack_9c);
    (**(code **)(*plVar10 + 0xa8))(plVar10,5);
    uVar7 = GetCurrentThreadId();
    FUN_140bd00e0(uVar7);
    (**(code **)(*plVar10 + 200))(plVar10);
  }
LAB_1410797cb:
  *(undefined1 *)(param_1 + 0x1e001a9) = 1;
  return 0;
}

