/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x10773d0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Type propagation algorithm not settling */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

int FUN_1410773d0(longlong param_1,uint param_2,int *param_3,int param_4,uint *param_5,byte param_6)

{
  longlong *plVar1;
  short sVar2;
  int iVar3;
  uint uVar4;
  undefined4 uVar5;
  int iVar6;
  int iVar7;
  uint uVar8;
  uint uVar9;
  longlong lVar10;
  ushort *puVar11;
  byte *pbVar12;
  ushort *puVar13;
  byte bVar14;
  uint uVar15;
  ulonglong uVar16;
  ulonglong uVar17;
  uint uVar18;
  int iVar19;
  uint *puVar20;
  int *piVar21;
  undefined1 auStack_3a8 [32];
  uint *puStack_388;
  undefined4 uStack_380;
  undefined8 uStack_378;
  undefined8 uStack_370;
  byte bStack_368;
  uint uStack_364;
  ulonglong uStack_360;
  undefined8 uStack_358;
  byte bStack_348;
  char acStack_347 [255];
  short sStack_248;
  ushort auStack_246 [255];
  ulonglong uStack_48;
  
  uStack_48 = _DAT_141fd5040 ^ (ulonglong)auStack_3a8;
  uStack_364 = param_2;
  iVar3 = FUN_1410770a0(param_1,&uStack_358,0x10);
  if (iVar3 != 0) {
    return iVar3;
  }
  uVar4 = (uint)uStack_358;
  uVar15 = uStack_358._4_4_;
  if (*(char *)(param_1 + 0x52) == '\0') {
    uVar4 = ((uint)uStack_358 & 0xff0000 | (uint)uStack_358 >> 0x10) >> 8 |
            ((uint)uStack_358 & 0xff00 | (uint)uStack_358 << 0x10) << 8;
    uVar15 = (uStack_358._4_4_ & 0xff0000 | uStack_358._4_4_ >> 0x10) >> 8 |
             (uStack_358._4_4_ & 0xff00 | uStack_358._4_4_ << 0x10) << 8;
  }
  uStack_358 = (ulonglong)uVar15;
  puVar13 = (ushort *)(param_1 + 0xa00128);
  if (0xa00000 < uStack_358) {
    return -0xd0;
  }
  iVar3 = FUN_1410770a0(param_1,puVar13,uStack_358);
  uVar17 = uStack_358;
  if (iVar3 != 0) {
    return iVar3;
  }
  if ((param_6 & 1) == 0) {
    if (uVar4 != 1) {
      if (uVar4 == 0) goto LAB_1410775b6;
      if (uVar4 == 1) goto LAB_14107764e;
      if ((uVar4 != 3) || (uStack_364 != 1)) goto LAB_141077cc1;
      if (0xff < uVar15) {
        uVar15 = 0xff;
      }
      sStack_248 = (short)uVar15;
      uVar4 = 0;
      if (uVar15 != 0) {
        pbVar12 = (byte *)(param_1 + 0xa00128);
        uVar17 = (ulonglong)uVar15;
        puVar13 = auStack_246;
        do {
          bVar14 = *pbVar12;
          pbVar12 = pbVar12 + 1;
          *puVar13 = (ushort)bVar14;
          puVar13 = puVar13 + 1;
          uVar17 = uVar17 - 1;
        } while (uVar17 != 0);
        uVar4 = uVar15 & 0xffff;
      }
      goto LAB_14107761f;
    }
    uVar4 = uVar15 >> 1;
    uStack_360 = (ulonglong)uVar4;
    if ((*(char *)(param_1 + 0x52) == '\0') && (uVar4 != 0)) {
      uVar16 = (ulonglong)uVar4;
      puVar11 = puVar13;
      do {
        *puVar11 = *puVar11 >> 8 | *puVar11 << 8;
        uVar16 = uVar16 - 1;
        puVar11 = puVar11 + 1;
      } while (uVar16 != 0);
    }
    if (*(char *)(param_1 + 0x40) != '\x02') {
      lVar10 = _aligned_malloc(uStack_358,0x10);
      if (lVar10 == 0) {
        return -0x6c;
      }
      if (puVar13 == (ushort *)0x0) {
        iVar3 = FUN_140b9f570(lVar10,uStack_360 & 0xffffffff);
        uVar15 = iVar3 * 2;
      }
      else {
        func_0x000141867875(lVar10,puVar13,uVar17);
        iVar3 = FUN_140b9f570(lVar10,uStack_360 & 0xffffffff);
        uVar15 = iVar3 * 2;
        func_0x000141867875(puVar13,lVar10,uVar15);
      }
    }
LAB_14107764e:
    if (uStack_364 == 0) {
      if (0x1fe < uVar15) {
        uVar15 = 0x1fe;
      }
      sStack_248 = (short)(uVar15 >> 1);
      if (puVar13 != (ushort *)0x0) {
        func_0x00014179cc9a(auStack_246,puVar13,uVar15);
      }
      sVar2 = sStack_248;
      uVar15 = 0;
      bStack_348 = 0;
      iVar3 = 0;
      bVar14 = 0;
      if (sStack_248 != 0) {
        uVar5 = GetACP();
        uStack_370 = 0;
        uStack_378 = 0;
        puStack_388 = (uint *)acStack_347;
        uStack_380 = 0xff;
        iVar6 = WideCharToMultiByte(uVar5,0,auStack_246,sVar2);
        bVar14 = (byte)iVar6;
        if (iVar6 == 0) {
          iVar6 = GetLastError();
          if (iVar6 == 0x7a) {
            bVar14 = 0xff;
          }
          else {
            FUN_140ad2900(iVar6);
          }
        }
      }
      uVar4 = (uint)bVar14;
      iVar6 = 0;
      bStack_348 = bVar14;
      if (param_4 == 0) {
        if (param_5 != (uint *)0x0) {
          *param_5 = 0;
        }
        if (param_3 == (int *)0x0) {
          return -0x32;
        }
        if (*param_3 != 0x73747263) {
          return -0x32;
        }
        if (param_3[0xf] != 0) {
          return -0x32;
        }
        if (uVar4 == 0) {
          return 0;
        }
        if (param_3[10] != 0) {
          return -0x32;
        }
        bStack_368 = *(byte *)(param_3 + 1) & 1;
        if (((bStack_368 != 0) && (*(longlong **)(param_3 + 4) != (longlong *)0x0)) &&
           (*(ulonglong **)(param_3 + 8) != (ulonglong *)0x0)) {
          param_3[0xf] = 1;
          uVar17 = **(ulonglong **)(param_3 + 8);
          uStack_360 = **(ulonglong **)(param_3 + 6);
          piVar21 = (int *)(**(longlong **)(param_3 + 4) + ((longlong)param_3[0xb] + -1) * 8);
          uStack_358 = uVar17;
          uVar8 = param_3[0xb];
          while (uVar9 = uVar8 - 1, -1 < (int)uVar9) {
            if (((piVar21[1] == uVar4) && (iVar19 = *piVar21, -1 < iVar19)) &&
               ((0 < piVar21[1] &&
                ((acStack_347[0] == *(char *)(uVar17 + (longlong)iVar19) &&
                 (iVar19 = func_0x00014179cc94(acStack_347,uVar17 + (longlong)iVar19,uVar4),
                 uVar17 = uStack_358, iVar19 == 0)))))) {
              piVar21 = (int *)(uStack_360 + (longlong)(int)uVar9 * 4);
              *piVar21 = *piVar21 + 1;
              if (param_5 != (uint *)0x0) {
                *param_5 = uVar8;
              }
              if ((*param_3 == 0x73747263) && (0 < param_3[0xf])) {
                param_3[0xf] = param_3[0xf] + -1;
              }
              return 0;
            }
            piVar21 = piVar21 + -2;
            uVar8 = uVar9;
          }
          if ((*param_3 == 0x73747263) && (0 < param_3[0xf])) {
            param_3[0xf] = param_3[0xf] + -1;
          }
        }
        while( true ) {
          FUN_140bfde40(param_3);
          if (param_3[0xc] != 0) break;
          iVar19 = FUN_140bfdc50(param_3);
          if (iVar19 != 0) {
            return iVar19;
          }
        }
        lVar10 = *(longlong *)(param_3 + 8);
        piVar21 = (int *)(**(longlong **)(param_3 + 4) + ((longlong)param_3[0xc] + -1) * 8);
        param_3[0xc] = piVar21[1];
        uStack_364 = (int)((longlong)piVar21 - **(longlong **)(param_3 + 4) >> 3) + 1;
        uStack_358 = (ulonglong)(int)uStack_364;
        iVar19 = iVar3;
        if (lVar10 != 0) {
          if (*(int *)(lVar10 + 8) == 0x4d656d48) {
            iVar6 = *(int *)(lVar10 + 0x10);
          }
          iVar19 = iVar6 - param_3[0xd];
        }
        if ((int)uVar4 <= param_3[0xd]) goto LAB_141077c18;
        uVar8 = param_3[0xe];
        uVar9 = uVar8;
        if (uVar8 < uVar4) {
          uVar9 = (uint)bVar14;
        }
        uVar18 = (uint)(longlong)((float)iVar19 * 1.1);
        if (uVar18 <= uVar9) {
          uVar18 = uVar9;
        }
        if (uVar8 < 0x2000) {
          param_3[0xe] = uVar8 * 2;
        }
        plVar1 = (longlong *)(param_3 + 8);
        if (plVar1 == (longlong *)0x0) {
LAB_141077b64:
          uVar8 = 0xffffffce;
          piVar21 = (int *)(**(longlong **)(param_3 + 4) + -8 + uStack_358 * 8);
        }
        else {
          lVar10 = *plVar1;
          if (lVar10 == 0) {
            if ((int)uVar18 < 0) {
              uVar8 = 0xffffff94;
            }
            else {
              lVar10 = FUN_140bc6490((longlong)(int)uVar18);
              *plVar1 = lVar10;
              uVar8 = 0xffffff94;
              if (lVar10 != 0) {
                uVar8 = uVar15;
              }
            }
          }
          else {
            if (*(int *)(lVar10 + 8) == 0x4d656d48) {
              iVar3 = *(int *)(lVar10 + 0x10);
            }
            if (((int)uVar18 < 0) && ((int)(uVar18 + iVar3) < 0)) goto LAB_141077b64;
            uVar8 = FUN_140bc65c0(lVar10,(longlong)(int)(uVar18 + iVar3));
          }
          piVar21 = (int *)(**(longlong **)(param_3 + 4) + -8 + (longlong)(int)uStack_358 * 8);
          if (uVar8 == 0) {
            param_3[0xd] = param_3[0xd] + uVar18;
LAB_141077c18:
            uVar15 = uStack_364;
            if ((longlong)iVar19 + **(longlong **)(param_3 + 8) != 0) {
              func_0x000141867875((longlong)iVar19 + **(longlong **)(param_3 + 8),acStack_347,bVar14
                                 );
            }
            param_3[0xd] = param_3[0xd] - uVar4;
            *piVar21 = iVar19;
            piVar21[1] = uVar4;
            if (param_5 != (uint *)0x0) {
              *param_5 = uVar15;
            }
            if (bStack_368 != 0) {
              piVar21 = (int *)(**(longlong **)(param_3 + 6) + -4 + (longlong)(int)uVar15 * 4);
              *piVar21 = *piVar21 + 1;
            }
            return 0;
          }
        }
        *piVar21 = -0x80000000;
        piVar21[1] = param_3[0xc];
        param_3[0xc] = uStack_364;
        return uVar8;
      }
      if (param_5 != (uint *)0x0) {
        *param_5 = 0;
      }
      if ((((param_3 == (int *)0x0) || (*param_3 != 0x73747263)) || (param_3[0xf] != 0)) ||
         (param_4 < 1)) {
        return -0x32;
      }
      if (uVar4 == 0) {
        return 0;
      }
      bStack_368 = *(byte *)(param_3 + 1) & 1;
      if (bStack_368 != 0) {
        if (param_3[10] < param_4) {
          iVar19 = param_4 - param_3[10];
          if (iVar19 < 0x32) {
            iVar19 = 0x32;
          }
          iVar7 = FUN_140bc66f0(param_3 + 2,iVar19 * 4);
          if (iVar7 != 0) {
            return iVar7;
          }
          param_3[10] = param_3[10] + iVar19;
        }
        uVar4 = *(uint *)(**(longlong **)(param_3 + 2) + -4 + (longlong)param_4 * 4);
        if (uVar4 != 0) {
          if (*param_3 == 0x73747263) {
            param_3[0xf] = param_3[0xf] + 1;
          }
          piVar21 = (int *)(**(longlong **)(param_3 + 6) + -4 + (longlong)(int)uVar4 * 4);
          *piVar21 = *piVar21 + 1;
          if (param_5 != (uint *)0x0) {
            *param_5 = uVar4;
          }
          if (*param_3 != 0x73747263) {
            return 0;
          }
          if (param_3[0xf] < 1) {
            return 0;
          }
          param_3[0xf] = param_3[0xf] + -1;
          return 0;
        }
      }
      while (param_3[0xc] == 0) {
        iVar19 = FUN_140bfdc50(param_3);
        if (iVar19 != 0) {
          return iVar19;
        }
      }
      puVar20 = (uint *)(**(longlong **)(param_3 + 4) + ((longlong)param_3[0xc] + -1) * 8);
      param_3[0xc] = puVar20[1];
      lVar10 = *(longlong *)(param_3 + 8);
      uStack_360 = (longlong)puVar20 - **(longlong **)(param_3 + 4) >> 3;
      uStack_358 = uStack_360 + 1;
      uStack_364 = uVar15;
      if (lVar10 != 0) {
        if (*(int *)(lVar10 + 8) == 0x4d656d48) {
          iVar3 = *(int *)(lVar10 + 0x10);
        }
        uStack_364 = iVar3 - param_3[0xd];
      }
      uVar4 = (uint)bVar14;
      if ((int)uVar4 <= param_3[0xd]) goto LAB_141077935;
      uVar8 = param_3[0xe];
      uVar9 = uVar8;
      if (uVar8 < uVar4) {
        uVar9 = uVar4;
      }
      uVar18 = (uint)(longlong)((float)(int)uStack_364 * 1.1);
      if (uVar18 <= uVar9) {
        uVar18 = uVar9;
      }
      if (uVar8 < 0x2000) {
        param_3[0xe] = uVar8 * 2;
      }
      plVar1 = (longlong *)(param_3 + 8);
      if (plVar1 == (longlong *)0x0) {
LAB_141077883:
        uVar8 = 0xffffffce;
        puVar20 = (uint *)(**(longlong **)(param_3 + 4) + uStack_360 * 8);
      }
      else {
        lVar10 = *plVar1;
        if (lVar10 == 0) {
          if ((int)uVar18 < 0) {
            uVar8 = 0xffffff94;
          }
          else {
            lVar10 = FUN_140bc6490((longlong)(int)uVar18);
            uVar8 = 0xffffff94;
            if (lVar10 != 0) {
              uVar8 = uVar15;
            }
            *plVar1 = lVar10;
          }
        }
        else {
          if (*(int *)(lVar10 + 8) == 0x4d656d48) {
            iVar6 = *(int *)(lVar10 + 0x10);
          }
          if (((int)uVar18 < 0) && ((int)(iVar6 + uVar18) < 0)) goto LAB_141077883;
          uVar8 = FUN_140bc65c0(lVar10,(longlong)(int)(iVar6 + uVar18));
        }
        puVar20 = (uint *)(**(longlong **)(param_3 + 4) + uStack_360 * 8);
        if (uVar8 == 0) {
          param_3[0xd] = param_3[0xd] + uVar18;
LAB_141077935:
          lVar10 = uStack_358;
          if ((longlong)(int)uStack_364 + **(longlong **)(param_3 + 8) != 0) {
            func_0x000141867875((longlong)(int)uStack_364 + **(longlong **)(param_3 + 8),acStack_347
                                ,uVar4);
          }
          param_3[0xd] = param_3[0xd] - uVar4;
          *puVar20 = uStack_364;
          puVar20[1] = uVar4;
          uVar15 = (uint)lVar10;
          if (param_5 != (uint *)0x0) {
            *param_5 = uVar15;
          }
          if (bStack_368 != 0) {
            *(uint *)(**(longlong **)(param_3 + 2) + -4 + (longlong)param_4 * 4) = uVar15;
            piVar21 = (int *)(**(longlong **)(param_3 + 6) + -4 + lVar10 * 4);
            *piVar21 = *piVar21 + 1;
          }
          return 0;
        }
      }
      *puVar20 = 0x80000000;
      puVar20[1] = param_3[0xc];
      param_3[0xc] = (int)uStack_358;
      return uVar8;
    }
  }
  else {
    func_0x000140ff7670(puVar13,uVar15);
LAB_1410775b6:
    if (uStack_364 == 1) {
      if (0xff < uVar15) {
        uVar15 = 0xff;
      }
      bStack_348 = (byte)uVar15;
      if (puVar13 != (ushort *)0x0) {
        func_0x00014179cc9a(acStack_347,puVar13,uVar15 & 0xff);
        uVar15 = (uint)bStack_348;
      }
      puStack_388 = &uStack_364;
      sStack_248 = 0;
      FUN_140b9eac0(acStack_347,uVar15 & 0xff,auStack_246,0xff);
      sStack_248 = (short)uStack_364;
      uVar4 = uStack_364;
LAB_14107761f:
      uVar15 = (uVar4 & 0xffff) * 2;
      puVar13 = auStack_246;
      goto LAB_141077626;
    }
  }
LAB_141077cc1:
  puVar13 = (ushort *)(param_1 + 0xa00128);
LAB_141077626:
  if (param_4 == 0) {
    iVar3 = FUN_140bfe1f0(param_3,puVar13,uVar15,param_5);
  }
  else {
    puStack_388 = param_5;
    iVar3 = FUN_140bfe500();
  }
  return iVar3;
}

