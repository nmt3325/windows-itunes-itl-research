/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x10cbb30; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

ulonglong FUN_1410cbb30(undefined8 param_1,longlong *param_2,undefined8 param_3,uint param_4)

{
  uint uVar1;
  undefined8 *puVar2;
  uint uVar3;
  uint uVar4;
  uint uVar5;
  int *piVar6;
  uint *puVar7;
  ulonglong uVar8;
  ulonglong uVar9;
  int *piVar10;
  bool bVar11;
  undefined1 auStack_158 [32];
  undefined8 uStack_138;
  uint uStack_128;
  int *piStack_120;
  longlong lStack_118;
  uint uStack_110;
  undefined4 uStack_10c;
  undefined8 uStack_108;
  undefined8 uStack_100;
  longlong lStack_f8;
  undefined8 uStack_f0;
  undefined8 uStack_e8;
  undefined8 uStack_e0;
  longlong lStack_d8;
  undefined8 uStack_d0;
  undefined8 uStack_c8;
  longlong alStack_b8 [2];
  uint uStack_a8;
  uint uStack_a4;
  uint auStack_a0 [22];
  ulonglong uStack_48;
  
  uStack_48 = _DAT_141fd5040 ^ (ulonglong)auStack_158;
  uStack_c8 = 0;
  uStack_108 = 0;
  uStack_100 = 0;
  lStack_f8 = 0;
  uStack_f0 = 0;
  uStack_e8 = 0;
  uStack_e0 = 0;
  lStack_d8 = 0;
  uStack_d0 = 0;
  uStack_128 = param_4;
  piVar6 = (int *)FUN_14179beec(0x1e00308,&UNK_141912c00);
  if (piVar6 == (int *)0x0) {
    return 0xffffff94;
  }
  func_0x00014179cca0(piVar6,0,0x1e00278);
  piVar6[0x7800bc] = 0;
  piVar6[0x7800bd] = 0;
  piVar6[0x7800be] = 0;
  piVar6[0x7800bf] = 0;
  piVar6[0x7800c0] = 0;
  piVar6[0x7800c1] = 0;
  piVar6[0x78009e] = 0;
  piVar6[0x78009f] = 0;
  piVar6[0x7800a0] = 0;
  piVar6[0x7800a1] = 0;
  piVar6[0x7800a2] = 0;
  piVar6[0x7800a3] = 0;
  piVar6[0x7800a4] = 0;
  piVar6[0x7800a5] = 0;
  piVar6[0x7800a6] = 0;
  piVar6[0x7800a7] = 0;
  piVar6[0x7800a8] = 0;
  piVar6[0x7800a9] = 0;
  piVar6[0x7800aa] = 0;
  piVar6[0x7800ab] = 0;
  piVar6[0x7800ac] = 0;
  piVar6[0x7800ad] = 0;
  piVar6[0x7800ae] = 0;
  piVar6[0x7800af] = 0;
  piVar6[0x7800b0] = 0;
  piVar6[0x7800b1] = 0;
  piVar6[0x7800b2] = 0;
  piVar6[0x7800b3] = 0;
  piVar6[0x7800b4] = 0;
  piVar6[0x7800b5] = 0;
  piVar6[0x7800b6] = 0;
  piVar6[0x7800b7] = 0;
  piVar6[0x7800b8] = 0;
  piVar6[0x7800b9] = 0;
  piVar6[0x7800ba] = 0;
  piVar6[0x7800bb] = 0;
  QueryPerformanceCounter(&uStack_110);
  piVar10 = piVar6 + 0x78006c;
  *(ulonglong *)piVar10 = CONCAT44(uStack_10c,uStack_110);
  *(undefined8 *)(piVar6 + 0x48) = param_1;
  piVar6[0x780062] = 0;
  piVar6[0x780063] = 0;
  piVar6[0x780058] = -1;
  piVar6[0x780059] = -1;
  piVar6[0x78005a] = -1;
  piVar6[0x78005b] = -1;
  piStack_120 = piVar10;
  uVar4 = FUN_1410770a0(piVar6,piVar6,0x90);
  uVar8 = (ulonglong)uVar4;
  if (uVar4 != 0) goto LAB_1410cc2e5;
  func_0x0001410c6130(piVar6);
  if ((*piVar6 == 0x6864666d) || (*piVar6 == 0x6864676d)) {
    if ((param_4 >> 0x1e & 1) == 0) {
      if (*(ushort *)(piVar6 + 3) < 0x44) goto LAB_1410cbcef;
      uVar8 = 0xfffffc94;
    }
    else if (*(ushort *)(piVar6 + 0x14) < 0x39) {
LAB_1410cbcef:
      if (piVar6[0xc] == 0) {
        uVar8 = 0xffffff30;
      }
      else if ((*(char *)((longlong)piVar6 + 0x41) == '\0') ||
              ((byte)(*(char *)((longlong)piVar6 + 0x41) - 1U) < 2)) {
        uVar4 = piVar6[1];
        if ((uVar4 < 0x90) && ((ulonglong)uVar4 + (longlong)piVar6 != 0)) {
          func_0x00014179cca0((ulonglong)uVar4 + (longlong)piVar6,0,0x90 - uVar4);
        }
        uVar4 = (**(code **)*param_2)(param_2,piVar6,*(char *)((longlong)piVar6 + 0x52) == '\0');
        uVar8 = (ulonglong)uVar4;
        if (uVar4 == 0) {
          uVar4 = piVar6[0x15] + piVar6[0x13] + piVar6[0x12] + piVar6[0x11];
          uVar8 = (ulonglong)uVar4;
          *(ulonglong *)(piVar6 + 0x780066) = uVar8;
          if (uVar4 == 0) {
            piVar6[0x780066] = -1;
            piVar6[0x780067] = -1;
            uVar8 = 0xffffffffffffffff;
          }
          puVar2 = *(undefined8 **)(piVar6 + 0x780062);
          if ((puVar2 != (undefined8 *)0x0) && ((code *)*puVar2 != (code *)0x0)) {
            uStack_138 = 0;
            (*(code *)*puVar2)(puVar2,0x6370726d,0,uVar8);
          }
          piVar6[0x780058] = -1;
          piVar6[0x780059] = -1;
          piVar6[0x78005a] = -1;
          piVar6[0x78005b] = -1;
          if (*(char *)((longlong)piVar6 + 0x43) == '\0') {
            if (*(char *)((longlong)piVar6 + 0x41) != '\0') {
              *(ulonglong *)(piVar6 + 0x780058) = (ulonglong)(uint)piVar6[1];
              if (*(char *)((longlong)piVar6 + 0x41) == '\x02') {
                *(ulonglong *)(piVar6 + 0x78005a) =
                     (ulonglong)(uint)piVar6[0x17] + (ulonglong)(uint)piVar6[1];
              }
              uVar4 = FUN_1410c6970(piVar6 + 0x78004a);
              uVar8 = (ulonglong)uVar4;
              if (uVar4 != 0) goto LAB_1410cc28e;
              goto LAB_1410cbec4;
            }
          }
          else {
            uVar8 = FUN_140b9fe10(&uStack_108,0xa00000);
            if ((int)uVar8 != 0) {
              return uVar8;
            }
            FUN_140ba09a0(*(undefined8 *)(piVar6 + 0x48),piVar6[1]);
            uVar8 = (ulonglong)(uint)piVar6[1];
            *(ulonglong *)(piVar6 + 0x78005c) = uVar8;
            if (*(char *)((longlong)piVar6 + 0x41) != '\0') {
              *(ulonglong *)(piVar6 + 0x780058) = uVar8;
              if (*(char *)((longlong)piVar6 + 0x41) == '\x02') {
                *(ulonglong *)(piVar6 + 0x78005a) = (uint)piVar6[0x17] + uVar8;
              }
              uVar4 = FUN_1410c6970(piVar6 + 0x78004a);
              uVar8 = (ulonglong)uVar4;
              if (uVar4 != 0) goto LAB_1410cc28e;
              piVar6[0x780060] = 0;
              piVar6[0x780061] = 0;
            }
            uVar4 = FUN_141084190(piVar6,&uStack_108);
            uVar8 = (ulonglong)uVar4;
            if (uVar4 != 0) goto LAB_1410cc28e;
            FUN_140ba09a0(&uStack_108,0);
            *(undefined1 *)((longlong)piVar6 + 0x41) = 0;
            *(undefined8 **)(piVar6 + 0x48) = &uStack_108;
            *(undefined1 *)((longlong)piVar6 + 0x43) = 0;
            piVar6[0x780058] = -1;
            piVar6[0x780059] = -1;
            piVar6[0x78005a] = -1;
            piVar6[0x78005b] = -1;
            piVar6[0x78005c] = 0;
            piVar6[0x78005d] = 0;
LAB_1410cbec4:
            piVar6[0x780060] = 0;
            piVar6[0x780061] = 0;
          }
          uVar4 = piVar6[1];
          if ((uVar4 < 0x90) && ((ulonglong)uVar4 + (longlong)piVar6 != 0)) {
            func_0x00014179cca0((ulonglong)uVar4 + (longlong)piVar6,0,0x90 - uVar4);
          }
          uVar4 = itl_106a520(piVar6,piVar6[1] + -0x90);
          uVar8 = (ulonglong)uVar4;
          if ((uVar4 == 0) && (uStack_110 = 0, piVar6[0xc] != 0)) {
            while( true ) {
              QueryPerformanceCounter(&lStack_118);
              uVar4 = FUN_1410770a0(piVar6,&uStack_a8,8);
              uVar8 = (ulonglong)uVar4;
              piVar10 = piStack_120;
              if (uVar4 != 0) break;
              uVar4 = uStack_a4;
              if (*(char *)((longlong)piVar6 + 0x52) == '\0') {
                uVar4 = uStack_a4 >> 0x18 | (uStack_a4 & 0xff0000) >> 8 | (uStack_a4 & 0xff00) << 8
                        | uStack_a4 << 0x18;
              }
              puVar7 = auStack_a0;
              uVar3 = 0x60;
              if (uVar4 < 0x60) {
                uVar3 = uVar4;
              }
              if (8 < uVar3) {
                uVar1 = uVar3 - 8;
                if ((ulonglong)uVar1 < 0xa00001) {
                  uVar5 = FUN_1410770a0(piVar6,auStack_a0,uVar1);
                  uVar8 = (ulonglong)uVar5;
                  piVar10 = piStack_120;
                  if (uVar5 == 0) {
                    puVar7 = (uint *)((longlong)auStack_a0 + (ulonglong)uVar1);
                    goto LAB_1410cbfa2;
                  }
                }
                else {
LAB_1410cc281:
                  uVar8 = 0xffffff30;
                  piVar10 = piStack_120;
                }
                break;
              }
LAB_1410cbfa2:
              uVar9 = (ulonglong)uStack_a4;
              if ((uVar3 < 0x60) && (puVar7 != (uint *)0x0)) {
                func_0x00014179cca0(puVar7,0,0x60 - uVar3);
                uVar9 = (ulonglong)uStack_a4;
              }
              if (uVar3 < uVar4) {
                uVar4 = itl_106a520(piVar6,uVar4 - uVar3);
                uVar8 = (ulonglong)uVar4;
                piVar10 = piStack_120;
                if (uVar4 != 0) break;
              }
              uVar4 = (uint)uVar9;
              if (*(char *)((longlong)piVar6 + 0x52) == '\0') {
                uStack_a8 = (uStack_a8 & 0xff0000 | uStack_a8 >> 0x10) >> 8 |
                            (uStack_a8 << 0x10 | uStack_a8 & 0xff00) << 8;
                uVar4 = (uVar4 & 0xff0000 | (uint)(uVar9 >> 0x10) & 0xffff) >> 8 |
                        (uVar4 << 0x10 | uVar4 & 0xff00) << 8;
                auStack_a0[0] =
                     (auStack_a0[0] & 0xff0000 | auStack_a0[0] >> 0x10) >> 8 |
                     (auStack_a0[0] << 0x10 | auStack_a0[0] & 0xff00) << 8;
                auStack_a0[1] =
                     (auStack_a0[1] & 0xff0000 | auStack_a0[1] >> 0x10) >> 8 |
                     (auStack_a0[1] << 0x10 | auStack_a0[1] & 0xff00) << 8;
                uStack_a4 = uVar4;
              }
              if (uStack_a8 != 0x6864736d) goto LAB_1410cc281;
              switch(auStack_a0[1]) {
              case 1:
              case 0xd:
                uVar4 = FUN_1410c8290(piVar6,param_2,auStack_a0[1] == 1,uStack_128);
                break;
              case 2:
              case 0xe:
                if ((uStack_128 >> 10 & 1) != 0) goto LAB_1410cc209;
                uVar4 = FUN_1410c8a00(piVar6,param_2,uStack_128,
                                      CONCAT71(0x1400000,auStack_a0[1] != 0xe));
                break;
              case 3:
              case 4:
              case 10:
              case 0x10:
              case 0x13:
              case 0x16:
                uVar4 = FUN_1410c6eb0(piVar6,param_2,auStack_a0[1],auStack_a0[0] - uVar4);
                break;
              default:
LAB_1410cc209:
                uVar8 = (longlong)(int)(auStack_a0[0] - uVar4) + *(longlong *)(piVar6 + 0x78005c);
                *(ulonglong *)(piVar6 + 0x78005c) = uVar8;
                if ((uVar8 < *(ulonglong *)(piVar6 + 0x78005e)) ||
                   (*(ulonglong *)(piVar6 + 0x78005e) + *(longlong *)(piVar6 + 0x780060) <= uVar8))
                {
                  piVar6[0x780060] = 0;
                  piVar6[0x780061] = 0;
                }
                uVar8 = 0;
                goto code_r0x0001410cc244;
              case 9:
                if ((uStack_128 & 0x4000) != 0) goto LAB_1410cc209;
                uVar4 = FUN_1410c6f70(piVar6,param_2);
                break;
              case 0xb:
                if ((uStack_128 & 0x2000) != 0) goto LAB_1410cc209;
                uVar4 = FUN_1410c7850(piVar6,param_2);
                break;
              case 0xc:
                uVar4 = FUN_1410c9da0(piVar6,param_2);
                break;
              case 0xf:
                uVar4 = FUN_1410c9900(piVar6,param_2);
                break;
              case 0x12:
                if ((uStack_128 & 0x8000) != 0) goto LAB_1410cc209;
                uVar4 = FUN_1410cab80(piVar6,param_2);
                break;
              case 0x14:
                if ((uStack_128 & 0x1000) != 0) goto LAB_1410cc209;
                uVar4 = FUN_1410ca1f0(piVar6,param_2);
                break;
              case 0x15:
                if ((uStack_128 & 0x10000) != 0) goto LAB_1410cc209;
                uVar4 = FUN_1410cb420(piVar6,param_2);
                break;
              case 0x17:
                if ((uStack_128 & 0x20000) != 0) goto LAB_1410cc209;
                uVar4 = FUN_1410cafe0(piVar6,param_2);
              }
              uVar8 = (ulonglong)uVar4;
              piVar10 = piStack_120;
              if ((uVar4 == 0x2349) || (uVar4 != 0)) break;
code_r0x0001410cc244:
              if (auStack_a0[1] < 0x18) {
                QueryPerformanceCounter(alStack_b8);
                *(longlong *)(piVar6 + (ulonglong)auStack_a0[1] * 2 + 0x78006c) =
                     alStack_b8[0] - lStack_118;
              }
              uStack_110 = uStack_110 + 1;
              piVar10 = piStack_120;
              if ((uint)piVar6[0xc] <= uStack_110) break;
            }
          }
        }
      }
      else {
        uVar8 = 0xfffffc94;
      }
    }
    else {
      uVar8 = 0xfffffc94;
    }
  }
  else {
    uVar8 = 0xffffff30;
  }
LAB_1410cc28e:
  puVar2 = *(undefined8 **)(piVar6 + 0x780062);
  if ((puVar2 != (undefined8 *)0x0) && ((code *)*puVar2 != (code *)0x0)) {
    uStack_138 = 0;
    (*(code *)*puVar2)(puVar2,0x6470726d,*(undefined8 *)(piVar6 + 0x780066),
                       *(undefined8 *)(piVar6 + 0x780066));
  }
  QueryPerformanceCounter(&lStack_118);
  *(longlong *)(piVar6 + 0x78006c) = lStack_118 - *(longlong *)(piVar6 + 0x78006c);
  (**(code **)(*param_2 + 8))(param_2,uVar8,piVar10);
LAB_1410cc2e5:
  if (*(char *)((longlong)piVar6 + 0x41) != '\0') {
    FUN_140bfc0d0(piVar6 + 0x78004a,0,0);
  }
  if ((int)uStack_108 == 0x62756666) {
    bVar11 = uStack_108._5_1_ == '\0';
    uStack_108 = CONCAT35(uStack_108._5_3_,0x162756666);
    if (bVar11) {
      FUN_140ba0000(&uStack_108);
    }
    FUN_140bd5150(uStack_100);
    if (lStack_f8 != 0) {
      FUN_140bd7440();
    }
    if (lStack_d8 != 0) {
      _aligned_free();
    }
    uStack_108 = 0;
    uStack_100 = 0;
    uStack_c8 = 0;
    lStack_f8 = 0;
    uStack_f0 = 0;
    uStack_e8 = 0;
    uStack_e0 = 0;
    lStack_d8 = 0;
    uStack_d0 = 0;
  }
  FUN_141086700(piVar6);
  return uVar8;
}

