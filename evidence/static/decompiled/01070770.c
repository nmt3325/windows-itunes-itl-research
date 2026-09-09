/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1070770; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

int FUN_141070770(longlong param_1,longlong param_2,longlong param_3,code *param_4,
                 undefined8 param_5)

{
  uint *puVar1;
  int *piVar2;
  uint uVar3;
  longlong *plVar4;
  undefined8 *puVar5;
  longlong lVar6;
  ulonglong uVar7;
  char cVar8;
  int iVar9;
  int iVar10;
  uint uVar11;
  undefined8 uVar12;
  longlong lVar13;
  int iVar14;
  ulonglong uStackX_18;
  
  plVar4 = *(longlong **)(param_3 + 0x50);
  do {
    if (plVar4 == (longlong *)0x0) {
      return 0;
    }
    if ((*(byte *)((longlong)plVar4 + 0x4b) & 1) == 0) {
      uVar12 = 1;
      for (puVar5 = *(undefined8 **)(plVar4[6] + 0x58); puVar5 != (undefined8 *)0x0;
          puVar5 = (undefined8 *)*puVar5) {
        cVar8 = FUN_14106b450(puVar5,uVar12);
        if (cVar8 != '\0') goto LAB_1410707e0;
        uVar12 = 0xd;
      }
    }
    else {
LAB_1410707e0:
      if ((param_4 == (code *)0x0) || (cVar8 = (*param_4)(3,plVar4,param_5), cVar8 != '\0')) {
        puVar1 = (uint *)(param_1 + 0xa00128);
        uStackX_18 = param_1 + 0xa0017c;
        if (puVar1 != (uint *)0x0) {
          *(undefined8 *)(param_1 + 0xa00130) = 0;
          *(undefined8 *)(param_1 + 0xa00138) = 0;
          *(undefined8 *)(param_1 + 0xa00140) = 0;
          *(undefined8 *)(param_1 + 0xa00148) = 0;
          *(undefined8 *)(param_1 + 0xa00150) = 0;
          *(undefined8 *)(param_1 + 0xa00158) = 0;
          *(undefined8 *)(param_1 + 0xa00160) = 0;
          *(undefined8 *)(param_1 + 0xa00168) = 0;
          *(undefined8 *)(param_1 + 0xa00170) = 0;
          *(undefined4 *)(param_1 + 0xa00178) = 0;
        }
        *puVar1 = 0x6870746d;
        *(undefined4 *)(param_1 + 0xa0012c) = 0x54;
        *(int *)(param_1 + 0xa00138) = (int)plVar4[5];
        *(longlong *)(param_1 + 0xa0016c) = plVar4[4];
        *(byte *)(param_1 + 0xa00144) = *(byte *)((longlong)plVar4 + 0x4b) & 1;
        *(byte *)(param_1 + 0xa00150) = *(byte *)((longlong)plVar4 + 0x4b) >> 5 & 1;
        if (*(longlong *)(param_3 + 8) != 0) {
          *(undefined4 *)(param_1 + 0xa0013c) = *(undefined4 *)(param_3 + 0x28);
        }
        if ((*(byte *)((longlong)plVar4 + 0x4b) & 1) == 0) {
          *(int *)(param_1 + 0xa00148) = (int)plVar4[0xb];
          *(undefined4 *)(param_1 + 0xa00140) = *(undefined4 *)(plVar4[6] + 8);
        }
        else {
          iVar9 = 0;
          *(byte *)(param_1 + 0xa00145) = *(byte *)((longlong)plVar4 + 0x4b) >> 7;
          *(char *)(param_1 + 0xa00152) = (char)plVar4[0xe];
          lVar6 = *plVar4;
          iVar10 = (int)plVar4[0xd];
          if (iVar10 == 0) {
LAB_14107096b:
            if (iVar9 != 0) {
              return iVar9;
            }
          }
          else {
            iVar14 = 0;
            lVar13 = 0;
            if ((int *)(lVar6 + 0x130) == (int *)0x0) {
              return -0x32;
            }
            if (*(int *)(lVar6 + 0x130) != 0x73747263) {
              return -0x32;
            }
            if (*(int *)(lVar6 + 0x16c) == 0) {
              return -0x32;
            }
            if (iVar10 < 1) {
              return -0x32;
            }
            if (*(int *)(lVar6 + 0x15c) < iVar10) {
              return -0x32;
            }
            piVar2 = (int *)(**(longlong **)(lVar6 + 0x140) + ((longlong)iVar10 + -1) * 8);
            if (((piVar2 == (int *)0x0) || (*piVar2 < 0)) || (piVar2[1] < 1)) {
              iVar9 = -0x32;
            }
            else {
              lVar13 = (longlong)*piVar2 + **(longlong **)(lVar6 + 0x150);
              iVar14 = piVar2[1];
            }
            if (iVar9 != 0) {
              return iVar9;
            }
            iVar9 = 0;
            if ((iVar14 == 0) ||
               (iVar9 = FUN_14106ac80(param_1,lVar13,iVar14,(longlong)iVar10,200,1,&uStackX_18),
               iVar9 != 0)) goto LAB_14107096b;
            *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
          }
          lVar6 = *plVar4;
          iVar9 = 0;
          iVar10 = *(int *)((longlong)plVar4 + 0x6c);
          if (iVar10 == 0) {
LAB_141070a3e:
            if (iVar9 != 0) {
              return iVar9;
            }
          }
          else {
            iVar14 = 0;
            lVar13 = 0;
            if ((((int *)(lVar6 + 0x130) == (int *)0x0) || (*(int *)(lVar6 + 0x130) != 0x73747263))
               || ((*(int *)(lVar6 + 0x16c) == 0 ||
                   ((iVar10 < 1 || (*(int *)(lVar6 + 0x15c) < iVar10)))))) {
              return -0x32;
            }
            piVar2 = (int *)(**(longlong **)(lVar6 + 0x140) + ((longlong)iVar10 + -1) * 8);
            if (((piVar2 == (int *)0x0) || (*piVar2 < 0)) || (piVar2[1] < 1)) {
              iVar9 = -0x32;
            }
            else {
              lVar13 = (longlong)*piVar2 + **(longlong **)(lVar6 + 0x150);
              iVar14 = piVar2[1];
            }
            if (iVar9 != 0) {
              return iVar9;
            }
            iVar9 = 0;
            if ((iVar14 == 0) ||
               (iVar9 = FUN_14106ac80(param_1,lVar13,iVar14,(longlong)iVar10,0xc9,1,&uStackX_18),
               iVar9 != 0)) goto LAB_141070a3e;
            *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
          }
          if (plVar4[6] != 0) {
            *(undefined4 *)(param_1 + 0xa00140) = *(undefined4 *)(plVar4[6] + 8);
          }
        }
        uVar11 = ((int)uStackX_18 - (int)param_1) - 0xa00128;
        *(uint *)(param_1 + 0xa00130) = uVar11;
        if (*(char *)(param_1 + 0x52) == '\0') {
          uVar3 = *puVar1;
          *puVar1 = uVar3 >> 0x18 | (uVar3 & 0xff0000) >> 8 | (uVar3 & 0xff00) << 8 | uVar3 << 0x18;
          uVar3 = *(uint *)(param_1 + 0xa0012c);
          *(uint *)(param_1 + 0xa0012c) =
               uVar3 >> 0x18 | (uVar3 & 0xff0000) >> 8 | (uVar3 & 0xff00) << 8 | uVar3 << 0x18;
          *(uint *)(param_1 + 0xa00130) =
               uVar11 >> 0x18 | (uVar11 & 0xff0000) >> 8 | (uVar11 & 0xff00) << 8 |
               uVar11 * 0x1000000;
          uVar3 = *(uint *)(param_1 + 0xa00134);
          *(uint *)(param_1 + 0xa00134) =
               uVar3 >> 0x18 | (uVar3 & 0xff0000) >> 8 | (uVar3 & 0xff00) << 8 | uVar3 << 0x18;
          uVar3 = *(uint *)(param_1 + 0xa00138);
          *(uint *)(param_1 + 0xa00138) =
               uVar3 >> 0x18 | (uVar3 & 0xff0000) >> 8 | (uVar3 & 0xff00) << 8 | uVar3 << 0x18;
          uVar3 = *(uint *)(param_1 + 0xa0013c);
          *(uint *)(param_1 + 0xa0013c) =
               uVar3 >> 0x18 | (uVar3 & 0xff0000) >> 8 | (uVar3 & 0xff00) << 8 | uVar3 << 0x18;
          uVar3 = *(uint *)(param_1 + 0xa00140);
          *(uint *)(param_1 + 0xa00140) =
               uVar3 >> 0x18 | (uVar3 & 0xff0000) >> 8 | (uVar3 & 0xff00) << 8 | uVar3 << 0x18;
          uVar3 = *(uint *)(param_1 + 0xa00148);
          *(uint *)(param_1 + 0xa00148) =
               uVar3 >> 0x18 | (uVar3 & 0xff0000) >> 8 | (uVar3 & 0xff00) << 8 | uVar3 << 0x18;
          uVar7 = *(ulonglong *)(param_1 + 0xa00164);
          *(ulonglong *)(param_1 + 0xa00164) =
               uVar7 >> 0x38 | (uVar7 & 0xff000000000000) >> 0x28 | (uVar7 & 0xff0000000000) >> 0x18
               | (uVar7 & 0xff00000000) >> 8 | (uVar7 & 0xff000000) << 8 |
               (uVar7 & 0xff0000) << 0x18 | (uVar7 & 0xff00) << 0x28 | uVar7 << 0x38;
          uVar7 = *(ulonglong *)(param_1 + 0xa0016c);
          *(ulonglong *)(param_1 + 0xa0016c) =
               uVar7 >> 0x38 | (uVar7 & 0xff000000000000) >> 0x28 | (uVar7 & 0xff0000000000) >> 0x18
               | (uVar7 & 0xff00000000) >> 8 | (uVar7 & 0xff000000) << 8 |
               (uVar7 & 0xff0000) << 0x18 | (uVar7 & 0xff00) << 0x28 | uVar7 << 0x38;
        }
        uStackX_18 = (ulonglong)uVar11;
        iVar10 = FUN_140ba04c0(*(undefined8 *)(param_1 + 0x120),&uStackX_18,param_1 + 0xa00128);
        if (iVar10 != 0) {
          return iVar10;
        }
        if (((*(byte *)((longlong)plVar4 + 0x4b) & 1) != 0) &&
           (iVar10 = FUN_141070770(param_1,param_2,plVar4,param_4,param_5), iVar10 != 0)) {
          return iVar10;
        }
        *(int *)(param_2 + 0x10) = *(int *)(param_2 + 0x10) + 1;
      }
    }
    plVar4 = (longlong *)plVar4[2];
  } while( true );
}

