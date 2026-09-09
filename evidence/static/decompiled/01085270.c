/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1085270; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

ulonglong FUN_141085270(longlong *param_1,undefined8 param_2,undefined1 *param_3,uint *param_4,
                       uint *param_5,uint *param_6,longlong param_7,undefined8 *param_8,uint param_9
                       )

{
  byte bVar1;
  ushort uVar2;
  longlong *plVar3;
  undefined8 uVar4;
  int iVar5;
  uint uVar6;
  uint uVar7;
  uint uVar8;
  uint *puVar9;
  uint *puVar10;
  uint *puVar11;
  undefined8 uVar12;
  longlong lVar13;
  longlong lVar14;
  undefined1 *puVar15;
  ulonglong uVar16;
  longlong lVar17;
  uint *puVar18;
  ulonglong uVar19;
  bool bVar20;
  undefined4 extraout_XMM0_Da;
  undefined4 extraout_XMM0_Da_00;
  undefined4 uVar21;
  undefined4 extraout_XMM0_Da_01;
  undefined4 extraout_XMM0_Da_02;
  undefined4 extraout_XMM0_Da_03;
  undefined1 auStack_818 [32];
  undefined8 uStack_7f8;
  uint *puStack_7e8;
  ulonglong *puStack_7e0;
  uint *puStack_7d8;
  uint *puStack_7d0;
  uint uStack_7c8;
  uint *puStack_7c0;
  undefined8 uStack_7b8;
  uint *puStack_7b0;
  longlong lStack_7a8;
  ulonglong uStack_7a0;
  longlong lStack_798;
  undefined8 uStack_790;
  longlong lStack_788;
  longlong lStack_780;
  undefined8 uStack_778;
  uint *puStack_768;
  undefined8 uStack_758;
  uint *puStack_750;
  longlong lStack_748;
  ulonglong uStack_740;
  longlong lStack_738;
  undefined8 uStack_730;
  longlong lStack_728;
  longlong lStack_720;
  undefined8 uStack_718;
  undefined1 *puStack_708;
  undefined8 *apuStack_700 [2];
  uint *puStack_6f0;
  longlong *plStack_6e8;
  uint *puStack_6e0;
  uint *puStack_6d8;
  longlong lStack_6d0;
  uint uStack_6c8;
  uint uStack_6c4;
  uint auStack_6c0 [22];
  undefined1 auStack_668 [20];
  undefined1 auStack_654 [16];
  undefined1 auStack_644 [30];
  undefined1 auStack_626 [56];
  undefined1 auStack_5ee [16];
  undefined1 auStack_5de [26];
  undefined1 auStack_5c4 [18];
  undefined1 auStack_5b2 [16];
  undefined1 auStack_5a2 [18];
  undefined1 auStack_590 [1210];
  longlong lStack_d6;
  ulonglong uStack_58;
  
  uStack_58 = _DAT_141fd5040 ^ (ulonglong)auStack_818;
  apuStack_700[0] = param_8;
  puStack_6e0 = param_5;
  puStack_6d8 = param_6;
  lStack_6d0 = param_7;
  uStack_7b8 = 0;
  puStack_7b0 = (uint *)0x0;
  lStack_7a8 = 0;
  uStack_7a0 = 0;
  lStack_798 = 0;
  uStack_790 = 0;
  lStack_788 = 0;
  lStack_780 = 0;
  uStack_778 = 0;
  uStack_758 = 0;
  puStack_750 = (uint *)0x0;
  lStack_748 = 0;
  uStack_740 = 0;
  lStack_738 = 0;
  uStack_730 = 0;
  lStack_728 = 0;
  lStack_720 = 0;
  uStack_718 = 0;
  if (((param_1 == (longlong *)0x0) || (*(int *)((longlong)param_1 + 0xa4) != 0)) ||
     (((int)param_1[0x10] == 0x74646174 && (param_1[0x17] != 0)))) {
    return 0xffffffce;
  }
  puStack_708 = param_3;
  puStack_6f0 = param_4;
  plStack_6e8 = param_1;
  puVar9 = (uint *)FUN_140bc69e0(0x1e00308);
  if (puVar9 == (uint *)0x0) {
    return 0xffffff94;
  }
  puVar9[0x78009e] = 0;
  puVar9[0x78009f] = 0;
  puVar9[0x7800a0] = 0;
  puVar9[0x7800a1] = 0;
  puVar9[0x7800a2] = 0;
  puVar9[0x7800a3] = 0;
  puVar9[0x7800a4] = 0;
  puVar9[0x7800a5] = 0;
  puVar9[0x7800a6] = 0;
  puVar9[0x7800a7] = 0;
  puVar9[0x7800a8] = 0;
  puVar9[0x7800a9] = 0;
  puVar9[0x7800aa] = 0;
  puVar9[0x7800ab] = 0;
  puVar9[0x7800ac] = 0;
  puVar9[0x7800ad] = 0;
  puVar9[0x7800ae] = 0;
  puVar9[0x7800af] = 0;
  puVar9[0x7800b0] = 0;
  puVar9[0x7800b1] = 0;
  puVar9[0x7800b2] = 0;
  puVar9[0x7800b3] = 0;
  puVar9[0x7800b4] = 0;
  puVar9[0x7800b5] = 0;
  puVar9[0x7800b6] = 0;
  puVar9[0x7800b7] = 0;
  puVar9[0x7800b8] = 0;
  puVar9[0x7800b9] = 0;
  puVar9[0x7800ba] = 0;
  puVar9[0x7800bb] = 0;
  if (puVar9 == (uint *)0x0) {
    return 0xffffff94;
  }
  *(longlong **)(puVar9 + 0x78009c) = param_1;
  puStack_7e8 = puVar9;
  puStack_768 = puVar9;
  iVar5 = FUN_141085040(param_2,puVar9);
  if (iVar5 != 0) {
    FUN_141086700(puVar9);
    return 0xffffff30;
  }
  if ((param_9 >> 0x1d & 1) != 0) {
    *(undefined1 *)((longlong)puVar9 + 0x1e002f2) = 1;
  }
  *(undefined8 **)(puVar9 + 0x780062) = param_8;
  puVar9[0x780066] = 0xffffffff;
  puVar9[0x780067] = 0xffffffff;
  uVar2 = (ushort)puVar9[3];
  puVar11 = puVar9;
  if (uVar2 < 0x44) {
    if (puVar9[0xc] == 0) {
      uVar16 = 0xffffff30;
      goto LAB_14108622a;
    }
    if (((((param_9 >> 9 & 1) == 0) && ((*(byte *)(param_1 + 0x22) & 1) == 0)) &&
        (*(int *)((longlong)param_1 + 0x84) != 0x706d6574)) && (uVar2 != 0x43)) {
      uVar16 = 0xffffff30;
      goto LAB_14108622a;
    }
    if ((*(char *)((longlong)puVar9 + 0x41) == '\0') ||
       ((byte)(*(char *)((longlong)puVar9 + 0x41) - 1U) < 2)) {
      if ((uVar2 != 0x43) || (*(short *)((longlong)puVar9 + 0xe) != 1)) {
        *(byte *)((longlong)param_1 + 0x113) = *(byte *)((longlong)param_1 + 0x113) | 1;
        *(undefined1 *)((longlong)puVar9 + 0x1e002f1) = 1;
      }
      if ((param_8 != (undefined8 *)0x0) && ((code *)*param_8 != (code *)0x0)) {
        uStack_7f8 = 0;
        (*(code *)*param_8)(param_8,0x6370726d,0,0xffffffffffffffff);
      }
      puVar9[0x780058] = 0xffffffff;
      puVar9[0x780059] = 0xffffffff;
      puVar9[0x78005a] = 0xffffffff;
      puVar9[0x78005b] = 0xffffffff;
      if (*(char *)((longlong)puVar9 + 0x43) != '\0') {
        uVar6 = FUN_140bd4f30(&puStack_7d8,param_2,1);
        uVar12 = uStack_758;
        if (uVar6 != 0) {
          return (ulonglong)uVar6;
        }
        uVar16 = 0x500000;
        uVar19 = 0;
        uStack_758 = CONCAT44(uStack_758._4_4_,0x62756666);
        uVar4 = uStack_758;
        uStack_758._7_1_ = SUB81(uVar12,7);
        uStack_758._0_7_ = CONCAT25(0x101,(int5)uVar4);
        puStack_750 = puStack_7d8;
        while (uVar12 = uStack_758, (int)uVar19 == 0) {
          lVar17 = _aligned_malloc(uVar16,0x10);
          if (lVar17 != 0) {
            if (uStack_758._5_1_ == '\0') {
              lStack_720 = (uVar16 - 1) + lVar17;
              lStack_738 = lVar17;
            }
            else {
              lStack_738 = lVar17 + 1;
              lStack_720 = lVar17;
            }
            *(undefined8 **)(puVar9 + 0x48) = &uStack_758;
            uStack_740 = uVar16;
            lStack_728 = lVar17;
            FUN_140ba09a0(&uStack_758,puVar9[1]);
            *(ulonglong *)(puVar9 + 0x78005c) = (ulonglong)puVar9[1];
            uVar16 = FUN_140b9fe10(&uStack_7b8,0xa00000);
            if ((int)uVar16 != 0) {
              return uVar16;
            }
            if (*(char *)((longlong)puVar9 + 0x41) != '\0') {
              *(ulonglong *)(puVar9 + 0x780058) = (ulonglong)puVar9[1];
              if (*(char *)((longlong)puVar9 + 0x41) == '\x02') {
                *(ulonglong *)(puVar9 + 0x78005a) = (ulonglong)puVar9[0x17] + (ulonglong)puVar9[1];
              }
              uVar6 = FUN_14106a3a0(puVar9 + 0x78004a,0);
              uVar16 = (ulonglong)uVar6;
              if (uVar6 != 0) goto LAB_14108622a;
              puVar9[0x780060] = 0;
              puVar9[0x780061] = 0;
            }
            uVar6 = FUN_141084190(puVar9,&uStack_7b8);
            uVar16 = (ulonglong)uVar6;
            if (uVar6 != 0) goto LAB_14108622a;
            FUN_140ba09a0(&uStack_7b8,0);
            *(undefined8 **)(puVar9 + 0x48) = &uStack_7b8;
            *(undefined1 *)((longlong)puVar9 + 0x41) = 0;
            *(undefined1 *)((longlong)puVar9 + 0x43) = 0;
            puVar9[0x780058] = 0xffffffff;
            puVar9[0x780059] = 0xffffffff;
            puVar9[0x78005a] = 0xffffffff;
            puVar9[0x78005b] = 0xffffffff;
            puVar9[0x780060] = 0;
            puVar9[0x780061] = 0;
            puVar9[0x78005c] = 0;
            puVar9[0x78005d] = 0;
            goto LAB_1410857de;
          }
          if (uVar16 < 0x1000) {
            uVar19 = 0xffffff94;
          }
          else {
            uVar16 = uVar16 >> 1;
          }
        }
        if ((int)uStack_758 != 0x62756666) {
          return uVar19;
        }
        uStack_758 = CONCAT35(uStack_758._5_3_,0x162756666);
        uVar4 = uStack_758;
        uStack_758._5_1_ = SUB81(uVar12,5);
        bVar20 = uStack_758._5_1_ == '\0';
        uStack_758 = uVar4;
        if (bVar20) {
          if ((uint *)(lStack_738 - lStack_728) != (uint *)0x0) {
            puStack_7d8 = (uint *)(lStack_738 - lStack_728);
            FUN_140bd62d0(puStack_750,&puStack_7d8,lStack_728,0);
            if (uStack_758._5_1_ != '\0') {
              lStack_738 = lStack_728 + 1;
              lStack_720 = lStack_728;
              goto LAB_1410856be;
            }
          }
          lStack_738 = lStack_728;
          lStack_720 = lStack_728 + (uStack_740 - 1);
        }
LAB_1410856be:
        FUN_140bd5150(puStack_750);
        if (lStack_748 != 0) {
          FUN_140bd7440();
        }
        if (lStack_728 != 0) {
          _aligned_free();
          return uVar19;
        }
        return uVar19;
      }
      uVar6 = FUN_140bd4f30(&puStack_7d8,param_2,1,0);
      uVar12 = uStack_7b8;
      if (uVar6 != 0) {
        return (ulonglong)uVar6;
      }
      uVar19 = 0xa00000;
      uVar16 = 0;
      uStack_7b8 = CONCAT44(uStack_7b8._4_4_,0x62756666);
      uVar4 = uStack_7b8;
      uStack_7b8._7_1_ = SUB81(uVar12,7);
      uStack_7b8._0_7_ = CONCAT25(0x101,(int5)uVar4);
      puStack_7b0 = puStack_7d8;
LAB_141085721:
      uVar12 = uStack_7b8;
      if ((int)uVar16 != 0) goto LAB_1410865d3;
      lVar17 = _aligned_malloc(uVar19,0x10);
      if (lVar17 == 0) {
        if (uVar19 < 0x1000) {
          uVar16 = 0xffffff94;
        }
        else {
          uVar19 = uVar19 >> 1;
        }
        goto LAB_141085721;
      }
      if (uStack_7b8._5_1_ == '\0') {
        lStack_780 = (uVar19 - 1) + lVar17;
        lStack_798 = lVar17;
      }
      else {
        lStack_798 = lVar17 + 1;
        lStack_780 = lVar17;
      }
      *(undefined8 **)(puVar9 + 0x48) = &uStack_7b8;
      uStack_7a0 = uVar19;
      lStack_788 = lVar17;
      FUN_140ba09a0(&uStack_7b8,puVar9[1]);
      uVar19 = (ulonglong)puVar9[1];
      *(ulonglong *)(puVar9 + 0x78005c) = uVar19;
      if (*(char *)((longlong)puVar9 + 0x41) == '\0') goto LAB_1410857de;
      *(ulonglong *)(puVar9 + 0x780058) = uVar19;
      if (*(char *)((longlong)puVar9 + 0x41) == '\x02') {
        *(ulonglong *)(puVar9 + 0x78005a) = puVar9[0x17] + uVar19;
      }
      uVar6 = FUN_14106a3a0(puVar9 + 0x78004a,0);
      uVar16 = (ulonglong)uVar6;
      if (uVar6 != 0) goto LAB_14108622a;
LAB_1410857de:
      puVar11 = (uint *)0x0;
      if (((int)param_1[0x10] == 0x74646174) && ((char)param_1[0x23] != '\x04')) {
        *(undefined1 *)(param_1 + 0x23) = 4;
        uStack_7f8 = 0;
        (**(code **)(*param_1 + 8))(param_1,0x74646c6f,param_1,0);
      }
      if ((((*(longlong *)(puVar9 + 0x780062) != 0) &&
           (uVar6 = puVar9[0x15] + puVar9[0x13] + puVar9[0x12] + puVar9[0x11], uVar6 != 0)) &&
          (*(ulonglong *)(puVar9 + 0x780066) = (ulonglong)uVar6, param_8 != (undefined8 *)0x0)) &&
         ((code *)*param_8 != (code *)0x0)) {
        uStack_7f8 = 0;
        (*(code *)*param_8)(param_8,0x7570726d,0);
      }
      lVar17 = *(longlong *)(puVar9 + 0xd);
      param_1[0x11] = lVar17;
      if (lVar17 == 0) {
        lVar17 = FUN_140ba5880(0);
        param_1[0x11] = lVar17;
      }
      if ((*(char *)((longlong)puVar9 + 0x42) != '\0') &&
         (*(char *)(_DAT_1420a6f30 + 0x14157) != '\0')) {
        *(undefined2 *)(_DAT_1420a6f30 + 0x14090) = 0;
      }
      if (puVar9[0x16] != 0) {
        *(uint *)((longlong)param_1 + 0x94) = puVar9[0x16];
      }
      puStack_768 = (uint *)FUN_14179beec(0x18,&UNK_141912c00);
      puVar10 = puVar11;
      if (puStack_768 != (uint *)0x0) {
        puStack_768[0] = 0;
        puStack_768[1] = 0;
        puStack_768[2] = 0;
        puStack_768[3] = 0;
        puStack_768[4] = 0;
        puStack_768[5] = 0;
        puVar10 = puStack_768;
      }
      param_1[0x323] = (longlong)puVar10;
      puStack_768 = (uint *)FUN_14179beec(0x18,&UNK_141912c00);
      if (puStack_768 != (uint *)0x0) {
        puStack_768[0] = 0;
        puStack_768[1] = 0;
        puStack_768[2] = 0;
        puStack_768[3] = 0;
        puStack_768[4] = 0;
        puStack_768[5] = 0;
        puVar11 = puStack_768;
      }
      param_1[0x324] = (longlong)puVar11;
      uStack_7c8 = 0;
      if (puVar9[0xc] != 0) {
        puStack_7d0 = puVar9 + 0x78009c;
        puStack_7e0 = (ulonglong *)(puVar9 + 0x78005c);
        puStack_768 = puVar9 + 0xc;
        puVar10 = puVar9;
        puVar18 = puVar9;
        do {
          puStack_7c0 = puVar10;
          uVar6 = FUN_1410770a0(puVar9,&uStack_6c8,8);
          uVar16 = (ulonglong)uVar6;
          puVar11 = puStack_7e8;
          if (uVar6 != 0) goto LAB_14108622a;
          uVar6 = uStack_6c4;
          if (*(char *)((longlong)puVar18 + 0x52) == '\0') {
            uVar6 = uStack_6c4 >> 0x18 | (uStack_6c4 & 0xff0000) >> 8 | (uStack_6c4 & 0xff00) << 8 |
                    uStack_6c4 << 0x18;
          }
          puVar10 = auStack_6c0;
          uVar8 = 0x60;
          if (uVar6 < 0x60) {
            uVar8 = uVar6;
          }
          uVar21 = extraout_XMM0_Da;
          if (8 < uVar8) {
            uVar19 = (ulonglong)(uVar8 - 8);
            if (0xa00000 < uVar19) {
              uVar16 = 0xffffff30;
              goto LAB_14108622a;
            }
            uVar7 = FUN_1410770a0(puVar9,auStack_6c0,uVar19);
            uVar16 = (ulonglong)uVar7;
            puVar11 = puStack_7e8;
            if (uVar7 != 0) goto LAB_14108622a;
            puVar10 = (uint *)((longlong)auStack_6c0 + uVar19);
            uVar21 = extraout_XMM0_Da_00;
          }
          uVar19 = (ulonglong)uStack_6c4;
          if ((uVar8 < 0x60) && (puVar10 != (uint *)0x0)) {
            uVar21 = func_0x00014179cca0(puVar10,0,0x60 - uVar8);
            uVar19 = (ulonglong)uStack_6c4;
          }
          puStack_7d8 = puStack_7e8;
          puVar11 = puStack_7e8;
          if (uVar8 < uVar6) {
            uVar6 = itl_106a520(puVar9,uVar6 - uVar8);
            uVar16 = (ulonglong)uVar6;
            uVar21 = extraout_XMM0_Da_01;
            if (uVar6 != 0) goto LAB_14108622a;
          }
          puVar10 = puStack_7c0;
          uVar6 = (uint)uVar19;
          if (*(char *)((longlong)puVar18 + 0x52) == '\0') {
            uStack_6c8 = (uStack_6c8 & 0xff0000 | uStack_6c8 >> 0x10) >> 8 |
                         (uStack_6c8 << 0x10 | uStack_6c8 & 0xff00) << 8;
            uVar6 = (uVar6 & 0xff0000 | (uint)(uVar19 >> 0x10) & 0xffff) >> 8 |
                    (uVar6 << 0x10 | uVar6 & 0xff00) << 8;
            auStack_6c0[0] =
                 (auStack_6c0[0] & 0xff0000 | auStack_6c0[0] >> 0x10) >> 8 |
                 (auStack_6c0[0] << 0x10 | auStack_6c0[0] & 0xff00) << 8;
            auStack_6c0[1] =
                 (auStack_6c0[1] & 0xff0000 | auStack_6c0[1] >> 0x10) >> 8 |
                 (auStack_6c0[1] << 0x10 | auStack_6c0[1] & 0xff00) << 8;
            uStack_6c4 = uVar6;
          }
          if (uStack_6c8 != 0x6864736d) {
            uVar16 = 0xffffff30;
            puStack_7c0 = puVar18;
            goto LAB_14108622a;
          }
          uVar6 = auStack_6c0[0] - uVar6;
          switch(auStack_6c0[1]) {
          case 1:
          case 0xd:
            bVar1 = *(byte *)(param_1 + 0x22);
            *(byte *)(param_1 + 0x22) = bVar1 | 2;
            puStack_7c0 = puVar18;
            uVar6 = FUN_14107b460(puVar9,auStack_6c0[1]);
            uVar16 = (ulonglong)uVar6;
            *(byte *)(param_1 + 0x22) =
                 (bVar1 ^ *(byte *)(param_1 + 0x22)) & 2 ^ *(byte *)(param_1 + 0x22);
            break;
          case 2:
          case 0xe:
            if ((param_9 >> 10 & 1) == 0) {
              puStack_7c0 = puVar18;
              uVar16 = FUN_14107ee90(puVar9,param_9);
            }
            else {
code_r0x000141085b4e:
              uVar16 = (longlong)(int)uVar6 + *puStack_7e0;
              *puStack_7e0 = uVar16;
code_r0x000141085b5c:
              if ((uVar16 < *(ulonglong *)(puVar9 + 0x78005e)) ||
                 (*(ulonglong *)(puVar9 + 0x78005e) + *(longlong *)(puVar9 + 0x780060) <= uVar16)) {
                uVar16 = 0;
                puVar9[0x780060] = 0;
                puVar9[0x780061] = 0;
                puStack_7c0 = puVar18;
              }
              else {
                uVar16 = 0;
                puStack_7c0 = puVar18;
              }
            }
            goto code_r0x00014108614c;
          case 3:
            if ((*(byte *)(*(longlong *)puStack_7d0 + 0x110) & 1) == 0) {
code_r0x000141085c97:
              uVar16 = (longlong)(int)uVar6 + *puStack_7e0;
              *puStack_7e0 = uVar16;
              goto code_r0x000141085b5c;
            }
            lVar17 = 0;
            puStack_7c0 = puVar18;
            if (uVar6 == 0) {
code_r0x000141085c73:
              uVar6 = FUN_141082110(uVar21,lVar17,uVar6);
              uVar16 = (ulonglong)uVar6;
              if (lVar17 != 0) {
code_r0x000141085c89:
                _aligned_free(lVar17);
              }
            }
            else {
              lVar17 = _aligned_malloc(uVar6,0x10);
              if (lVar17 == 0) {
                uVar16 = 0xffffff94;
              }
              else {
                if (uVar6 < 0xa00001) {
                  uVar8 = FUN_1410770a0(puVar9,lVar17,uVar6);
                  uVar16 = (ulonglong)uVar8;
                  uVar21 = extraout_XMM0_Da_02;
                  if (uVar8 == 0) goto code_r0x000141085c73;
                  goto code_r0x000141085c89;
                }
                uVar16 = 0xffffff30;
                _aligned_free(lVar17);
              }
            }
            break;
          case 4:
            if ((char)puVar9[0x7800bc] != '\0') {
code_r0x000141085e4b:
              uVar16 = (longlong)(int)uVar6 + *puStack_7e0;
              *puStack_7e0 = uVar16;
              puVar11 = puVar9;
              if ((uVar16 < *(ulonglong *)(puVar9 + 0x78005e)) ||
                 (*(ulonglong *)(puVar9 + 0x78005e) + *(longlong *)(puVar9 + 0x780060) <= uVar16)) {
                puVar9[0x780060] = 0;
                puVar9[0x780061] = 0;
              }
              goto code_r0x00014108619f;
            }
            uVar16 = 0;
            puStack_7c0 = puVar18;
            if (uVar6 != 0) {
              lVar17 = _aligned_malloc(uVar6,0x10);
              if (lVar17 == 0) {
                uVar16 = 0xffffff94;
              }
              else if (uVar6 < 0xa00001) {
                uVar8 = FUN_1410770a0(puVar9,lVar17,uVar6);
                if (uVar8 == 0) {
                  uVar8 = FUN_1410824c0(*(undefined8 *)puStack_7d0,lVar17,uVar6);
                }
                uVar16 = (ulonglong)uVar8;
                _aligned_free(lVar17);
              }
              else {
                uVar16 = 0xffffff30;
                _aligned_free(lVar17);
              }
            }
            break;
          default:
            uVar16 = (longlong)(int)uVar6 + *puStack_7e0;
            *puStack_7e0 = uVar16;
            puVar11 = puStack_7c0;
            if ((uVar16 < *(ulonglong *)(puVar9 + 0x78005e)) ||
               (*(ulonglong *)(puVar9 + 0x78005e) + *(longlong *)(puVar9 + 0x780060) <= uVar16)) {
              puVar9[0x780060] = 0;
              puVar9[0x780061] = 0;
            }
code_r0x00014108619f:
            uVar16 = 0;
            puStack_7c0 = puVar18;
            FUN_141077340(puVar11);
            goto code_r0x0001410861a6;
          case 9:
            if ((param_9 & 0x4000) != 0) goto code_r0x000141085b4e;
            puStack_7c0 = puVar18;
            uVar16 = FUN_141078140(puVar9);
            goto code_r0x00014108614c;
          case 10:
            if ((*(byte *)(*(longlong *)puStack_7d0 + 0x110) & 1) == 0) goto code_r0x000141085c97;
            lVar17 = 0;
            puStack_7c0 = puVar18;
            if (uVar6 == 0) {
code_r0x000141085d42:
              uVar6 = FUN_1410823f0(uVar21,lVar17,uVar6);
              uVar16 = (ulonglong)uVar6;
              if (lVar17 != 0) {
code_r0x000141085d58:
                _aligned_free(lVar17);
              }
            }
            else {
              lVar17 = _aligned_malloc(uVar6,0x10);
              if (lVar17 == 0) {
                uVar16 = 0xffffff94;
              }
              else {
                if (uVar6 < 0xa00001) {
                  uVar8 = FUN_1410770a0(puVar9,lVar17,uVar6);
                  uVar16 = (ulonglong)uVar8;
                  uVar21 = extraout_XMM0_Da_03;
                  if (uVar8 == 0) goto code_r0x000141085d42;
                  goto code_r0x000141085d58;
                }
                uVar16 = 0xffffff30;
                _aligned_free(lVar17);
              }
            }
            break;
          case 0xb:
            if ((param_9 & 0x2000) != 0) goto code_r0x000141085b4e;
            puStack_7c0 = puVar18;
            uVar16 = FUN_141078bb0(puVar9);
            goto code_r0x00014108614c;
          case 0xc:
            if (((*(byte *)(*(longlong *)puStack_7d0 + 0x110) & 1) == 0) &&
               (puStack_708 == (undefined1 *)0x0)) goto code_r0x000141085e4b;
            puStack_7c0 = puVar18;
            FUN_1405ab560(auStack_668);
            puVar15 = auStack_668;
            if (puStack_708 != (undefined1 *)0x0) {
              puVar15 = puStack_708;
            }
            uVar6 = FUN_14107abe0(puVar9,puVar15);
            uVar16 = (ulonglong)uVar6;
            FUN_1405b4f30(auStack_590);
            if (lStack_d6 != 0) {
              CFRelease();
            }
            FUN_140ad69e0(auStack_5a2);
            FUN_140ad69e0(auStack_5b2);
            FUN_140ad69e0(auStack_5c4);
            FUN_140ad69e0(auStack_5de);
            FUN_140ad69e0(auStack_5ee);
            FUN_140ad69e0(auStack_626);
            FUN_140ad69e0(auStack_644);
            FUN_140ad69e0(auStack_654);
            break;
          case 0xf:
            puStack_7c0 = puVar18;
            uVar16 = FUN_141082570(puVar9);
            goto code_r0x00014108614c;
          case 0x10:
            puStack_7c0 = puVar18;
            uVar6 = FUN_141077270(puVar9,puVar9 + 0x24,0x90);
            uVar16 = (ulonglong)uVar6;
            if (uVar6 == 0) {
              if (*(char *)((longlong)puVar18 + 0x52) == '\0') {
                itl_1068f90(puVar9 + 0x24);
              }
              if (puVar9[0x24] != 0x6864666d) {
                uVar16 = 0xffffff30;
              }
              if (*(longlong *)(puVar18 + 0x31) != 0) {
                *(longlong *)(*(longlong *)puStack_7d0 + 0x88) = *(longlong *)(puVar18 + 0x31);
              }
            }
            break;
          case 0x12:
            puStack_7c0 = puVar18;
            uVar16 = FUN_141082ac0(puVar9);
            goto code_r0x00014108614c;
          case 0x13:
            if (((_DAT_1420a6f30 == 0) || (*(longlong *)(_DAT_1420a6f30 + 0xf4fc) == 0)) ||
               (*(longlong *)(puVar18 + 0x1a) != *(longlong *)(_DAT_1420a6f30 + 0xf4fc)))
            goto code_r0x000141085c97;
            lVar17 = *(longlong *)puStack_7d0;
            puStack_7c0 = puVar18;
            lVar13 = _aligned_malloc(uVar6,0x10);
            if (lVar13 == 0) {
              uVar16 = 0xffffff94;
            }
            else if (uVar6 < 0xa00001) {
              uVar8 = FUN_1410770a0(puVar9,lVar13,uVar6);
              uVar16 = (ulonglong)uVar8;
              if (uVar8 == 0) {
                if (*(longlong *)(lVar17 + 0x20d8) != 0) {
                  CFRelease();
                }
                *(undefined8 *)(lVar17 + 0x20d8) = 0;
                lVar14 = CFDataCreate(_DAT_1420a6090,lVar13,uVar6);
                *(longlong *)(lVar17 + 0x20d8) = lVar14;
                if (lVar14 == 0) {
                  uVar16 = 0xffffffce;
                  _aligned_free(lVar13);
                  break;
                }
                *(undefined8 *)(lVar17 + 0x20e0) = *(undefined8 *)(puStack_7c0 + 0x1a);
              }
              _aligned_free(lVar13);
            }
            else {
              uVar16 = 0xffffff30;
              _aligned_free(lVar13);
            }
            break;
          case 0x14:
            if ((param_9 & 0x1000) != 0) goto code_r0x000141085b4e;
            puStack_7c0 = puVar18;
            uVar16 = FUN_141082f60(puVar9);
            goto code_r0x00014108614c;
          case 0x15:
            puStack_7c0 = puVar18;
            uVar16 = FUN_141081a70(puVar9);
            goto code_r0x00014108614c;
          case 0x16:
            uVar19 = 0;
            uVar16 = 0;
            if ((*(byte *)(*(longlong *)puStack_7d0 + 0x110) & 1) == 0) {
              uVar19 = (longlong)(int)uVar6 + *puStack_7e0;
              *puStack_7e0 = uVar19;
              if ((uVar19 < *(ulonglong *)(puVar9 + 0x78005e)) ||
                 (puStack_7c0 = puVar18,
                 *(ulonglong *)(puVar9 + 0x78005e) + *(longlong *)(puVar9 + 0x780060) <= uVar19)) {
                puVar9[0x780060] = 0;
                puVar9[0x780061] = 0;
                puStack_7c0 = puVar18;
              }
            }
            else {
              uVar16 = uVar19;
              puStack_7c0 = puVar18;
              if (uVar6 == 0) {
code_r0x000141085dec:
                FUN_1407f6ec0(uVar19);
                if (uVar19 != 0) {
code_r0x000141085dfd:
                  CFRelease(uVar19);
                }
              }
              else {
                uVar19 = CFDataCreateMutable(_DAT_1420a6090,0);
                if (uVar19 != 0) {
                  CFDataSetLength(uVar19,uVar6);
                  uVar12 = CFDataGetMutableBytePtr(uVar19);
                  if (uVar6 < 0xa00001) {
                    uVar6 = FUN_1410770a0(puVar9,uVar12,uVar6);
                    uVar16 = (ulonglong)uVar6;
                    if (uVar6 == 0) goto code_r0x000141085dec;
                    goto code_r0x000141085dfd;
                  }
                  uVar16 = 0xffffff30;
                  CFRelease(uVar19);
                }
              }
            }
            break;
          case 0x17:
            puStack_7c0 = puVar18;
            uVar16 = FUN_141083c60(puVar9);
code_r0x00014108614c:
            uVar16 = uVar16 & 0xffffffff;
          }
          FUN_141077340(puVar9);
          puVar11 = puStack_7d8;
          if ((int)uVar16 != 0) goto LAB_14108622a;
code_r0x0001410861a6:
          uStack_7c8 = uStack_7c8 + 1;
          puStack_7e8 = puStack_7d8;
          puVar18 = puStack_7c0;
        } while (uStack_7c8 < *puStack_768);
      }
      FUN_140bfc0d0(puVar9 + 0x78004a,0,0);
      FUN_140ed3a30(param_1);
      FUN_140ecf8f0(param_1,*(undefined1 *)((longlong)puVar9 + 0x1e002f1));
      puVar11 = puStack_7e8;
      goto LAB_14108622a;
    }
  }
  uVar16 = 0xfffffc94;
LAB_14108622a:
  if ((int)uStack_7b8 == 0x62756666) {
    FUN_140ba02c0(&uStack_7b8);
  }
  if ((int)uStack_758 == 0x62756666) {
    FUN_140ba02c0(&uStack_758);
  }
  FUN_140bfe110(param_1 + 0x2f);
  FUN_140bfe110(param_1 + 0x41);
  FUN_140bfe110(param_1 + 0x38);
  FUN_140bfe110(param_1 + 0x4a);
  FUN_140bfe110(param_1 + 0x65);
  FUN_140bfe110(param_1 + 0x6e);
  FUN_140bfe110(param_1 + 0x77);
  FUN_140bfe110(param_1 + 0x80);
  FUN_140bfe110(param_1 + 0x110);
  FUN_140bfe110(param_1 + 0x89);
  FUN_140bfe110(param_1 + 0x92);
  FUN_140bfe110(param_1 + 0x9b);
  FUN_140bfe110(param_1 + 0xa4);
  FUN_140bfe110(param_1 + 0xad);
  FUN_140bfe110(param_1 + 0xb6);
  FUN_140bfe110(param_1 + 0xbf);
  FUN_140bfe110(param_1 + 200);
  FUN_140bfe110(param_1 + 0xd1);
  FUN_140bfe110(param_1 + 0xda);
  FUN_140bfe110(param_1 + 0xe3);
  FUN_140bfe110(param_1 + 0xec);
  FUN_140bfe110(param_1 + 0x2ed);
  FUN_140bfe110(param_1 + 0x2f6);
  FUN_140bfe110(param_1 + 0x2ff);
  FUN_140bfe110(param_1 + 0x308);
  FUN_140bfe110(param_1 + 0xf5);
  FUN_140bfe110(param_1 + 0xfe);
  FUN_140bfe110(param_1 + 0x107);
  FUN_140bfe110(param_1 + 0x119);
  FUN_140bfe110(param_1 + 0x122);
  FUN_140bfe110(param_1 + 0x311);
  FUN_140bfe110(param_1 + 0x53);
  FUN_140bfe110(param_1 + 0x5c);
  param_1 = param_1 + 300;
  lVar17 = 0x32;
  do {
    if ((param_1 + -1 != (longlong *)0x0) && ((int)param_1[-1] == 0x73747263)) {
      plVar3 = (longlong *)*param_1;
      if (plVar3 != (longlong *)0x0) {
        if ((int)plVar3[1] == 0x4d656d48) {
          if (*plVar3 != 0) {
            _aligned_free();
            *plVar3 = 0;
          }
          *(undefined4 *)(plVar3 + 1) = 0;
          plVar3[2] = 0;
          plVar3[3] = 0;
          _aligned_free(plVar3);
        }
        *param_1 = 0;
      }
      *(undefined4 *)(param_1 + 4) = 0;
    }
    plVar3 = plStack_6e8;
    param_1 = param_1 + 9;
    lVar17 = lVar17 + -1;
  } while (lVar17 != 0);
  if (puStack_6f0 != (uint *)0x0) {
    *puStack_6f0 = (uint)(ushort)puVar11[3];
  }
  if (puStack_6e0 != (uint *)0x0) {
    *puStack_6e0 = (uint)*(ushort *)((longlong)puVar11 + 0xe);
  }
  if (puStack_6d8 != (uint *)0x0) {
    *puStack_6d8 = puVar11[0xf];
  }
  if (lStack_6d0 != 0) {
    *(bool *)lStack_6d0 = (char)puVar11[0x10] != '\x02';
  }
  if ((int)uVar16 == 0) {
    if (((int)plStack_6e8[0x10] == 0x74646174) && ((char)plStack_6e8[0x23] != '\x06')) {
      *(undefined1 *)(plStack_6e8 + 0x23) = 6;
      uStack_7f8 = 0;
      (**(code **)(*plStack_6e8 + 8))(plStack_6e8,0x74646c64,plStack_6e8,0);
    }
    if (puStack_708 != (undefined1 *)0x0) {
      FUN_14107a150(puVar9,puStack_708,0);
    }
    if (*(int *)((longlong)plVar3 + 0x84) == 0x2062696c) {
      FUN_141084d50(puVar9);
    }
  }
  else if ((int)plStack_6e8[0x10] == 0x74646174) {
    *(undefined1 *)(plStack_6e8 + 0x23) = 0;
    uStack_7f8 = 0;
    (**(code **)(*plStack_6e8 + 8))(plStack_6e8,0x74646c66,plStack_6e8,(longlong)(int)uVar16);
  }
  lVar17 = *(longlong *)(puVar9 + 0x7800be);
  if (lVar17 != 0) {
    FUN_141068f00(lVar17);
    func_0x000140bc6a20(lVar17,0x30);
    puVar9[0x7800be] = 0;
    puVar9[0x7800bf] = 0;
  }
  plVar3 = *(longlong **)(puVar9 + 0x7800c0);
  if (plVar3 != (longlong *)0x0) {
    if (plVar3[1] != 0) {
      CFRelease();
    }
    if (*plVar3 != 0) {
      CFRelease();
    }
    func_0x000140bc6a20(plVar3,0x10);
    puVar9[0x7800c0] = 0;
    puVar9[0x7800c1] = 0;
  }
  FUN_141086700(puVar9);
  if (apuStack_700[0] != (undefined8 *)0x0) {
    if ((code *)*apuStack_700[0] != (code *)0x0) {
      uStack_7f8 = 0;
      (*(code *)*apuStack_700[0])(apuStack_700[0],0x6470726d,0,0);
      return uVar16;
    }
    return uVar16;
  }
  return uVar16;
LAB_1410865d3:
  if ((int)uStack_7b8 != 0x62756666) {
    return uVar16;
  }
  uStack_7b8 = CONCAT35(uStack_7b8._5_3_,0x162756666);
  uVar4 = uStack_7b8;
  uStack_7b8._5_1_ = SUB81(uVar12,5);
  bVar20 = uStack_7b8._5_1_ == '\0';
  uStack_7b8 = uVar4;
  if (bVar20) {
    if ((undefined8 *)(lStack_798 - lStack_788) != (undefined8 *)0x0) {
      apuStack_700[0] = (undefined8 *)(lStack_798 - lStack_788);
      FUN_140bd62d0(puStack_7b0,apuStack_700,lStack_788,0);
      if (uStack_7b8._5_1_ != '\0') {
        lStack_798 = lStack_788 + 1;
        lStack_780 = lStack_788;
        goto LAB_14108663a;
      }
    }
    lStack_798 = lStack_788;
    lStack_780 = lStack_788 + (uStack_7a0 - 1);
  }
LAB_14108663a:
  FUN_140bd5150(puStack_7b0);
  if (lStack_7a8 != 0) {
    FUN_140bd7440();
  }
  if (lStack_788 != 0) {
    _aligned_free();
  }
  return uVar16;
}

