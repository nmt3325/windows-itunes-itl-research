/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xbfe500; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

ulonglong FUN_140bfe500(int *param_1,longlong param_2,uint param_3,int param_4,int *param_5)

{
  byte bVar1;
  longlong *plVar2;
  uint uVar3;
  ulonglong uVar4;
  longlong lVar5;
  uint uVar6;
  uint uVar7;
  int iVar8;
  int *piVar9;
  longlong lVar10;
  int iVar11;
  int iVar12;
  longlong *plVar13;
  
  iVar11 = 0;
  if (param_5 != (int *)0x0) {
    *param_5 = 0;
  }
  if ((((param_1 == (int *)0x0) || (*param_1 != 0x73747263)) || (param_1[0xf] != 0)) ||
     (param_4 < 1)) {
    return 0xffffffce;
  }
  if (param_3 == 0) {
LAB_140bfe7c7:
    uVar4 = 0;
  }
  else {
    bVar1 = *(byte *)(param_1 + 1);
    if ((bVar1 & 1) != 0) {
      if (param_1[10] < param_4) {
        iVar8 = param_4 - param_1[10];
        if (iVar8 < 0x32) {
          iVar8 = 0x32;
        }
        uVar4 = FUN_140bc66f0(param_1 + 2,iVar8 * 4);
        if ((int)uVar4 != 0) {
          return uVar4;
        }
        param_1[10] = param_1[10] + iVar8;
      }
      iVar8 = *(int *)(**(longlong **)(param_1 + 2) + -4 + (longlong)param_4 * 4);
      if (iVar8 != 0) {
        if (*param_1 == 0x73747263) {
          param_1[0xf] = param_1[0xf] + 1;
        }
        piVar9 = (int *)(**(longlong **)(param_1 + 6) + -4 + (longlong)iVar8 * 4);
        *piVar9 = *piVar9 + 1;
        if (param_5 != (int *)0x0) {
          *param_5 = iVar8;
        }
        if ((*param_1 == 0x73747263) && (0 < param_1[0xf])) {
          param_1[0xf] = param_1[0xf] + -1;
          return 0;
        }
        goto LAB_140bfe7c7;
      }
    }
    do {
      if (param_1[0xc] != 0) {
        plVar2 = *(longlong **)(param_1 + 4);
        lVar5 = *(longlong *)(param_1 + 8);
        piVar9 = (int *)(*plVar2 + ((longlong)param_1[0xc] + -1) * 8);
        param_1[0xc] = piVar9[1];
        lVar10 = (longlong)piVar9 - *plVar2 >> 3;
        if (lVar5 == 0) {
          iVar8 = 0;
        }
        else {
          if (*(int *)(lVar5 + 8) == 0x4d656d48) {
            iVar8 = *(int *)(lVar5 + 0x10);
          }
          else {
            iVar8 = 0;
          }
          iVar8 = iVar8 - param_1[0xd];
        }
        iVar12 = (int)(lVar10 + 1);
        if (param_1[0xd] < (int)param_3) {
          uVar3 = param_1[0xe];
          uVar6 = uVar3;
          if (uVar3 < param_3) {
            uVar6 = param_3;
          }
          plVar13 = (longlong *)(param_1 + 8);
          uVar7 = (uint)(longlong)((float)iVar8 * 1.1);
          if (uVar7 <= uVar6) {
            uVar7 = uVar6;
          }
          if (uVar3 < 0x2000) {
            param_1[0xe] = uVar3 * 2;
          }
          if (plVar13 == (longlong *)0x0) {
LAB_140bfe6c5:
            uVar4 = 0xffffffce;
            piVar9 = (int *)(*plVar2 + lVar10 * 8);
LAB_140bfe744:
            *piVar9 = -0x80000000;
            piVar9[1] = param_1[0xc];
            param_1[0xc] = iVar12;
            return uVar4;
          }
          lVar5 = *plVar13;
          if (lVar5 == 0) {
            if ((int)uVar7 < 0) {
              uVar4 = 0xffffff94;
            }
            else {
              lVar5 = FUN_140bc6490((longlong)(int)uVar7);
              *plVar13 = lVar5;
              uVar4 = 0xffffff94;
              if (lVar5 != 0) {
                uVar4 = 0;
              }
            }
          }
          else {
            if (*(int *)(lVar5 + 8) == 0x4d656d48) {
              iVar11 = *(int *)(lVar5 + 0x10);
            }
            if (((int)uVar7 < 0) && ((int)(uVar7 + iVar11) < 0)) goto LAB_140bfe6c5;
            uVar3 = FUN_140bc65c0(lVar5,(longlong)(int)(uVar7 + iVar11));
            uVar4 = (ulonglong)uVar3;
          }
          piVar9 = (int *)(**(longlong **)(param_1 + 4) + lVar10 * 8);
          if ((int)uVar4 != 0) goto LAB_140bfe744;
          param_1[0xd] = param_1[0xd] + uVar7;
        }
        if ((param_2 != 0) && ((longlong)iVar8 + **(longlong **)(param_1 + 8) != 0)) {
          func_0x000141867875((longlong)iVar8 + **(longlong **)(param_1 + 8),param_2,
                              (longlong)(int)param_3);
        }
        param_1[0xd] = param_1[0xd] - param_3;
        *piVar9 = iVar8;
        piVar9[1] = param_3;
        if (param_5 != (int *)0x0) {
          *param_5 = iVar12;
        }
        if ((bVar1 & 1) != 0) {
          *(int *)(**(longlong **)(param_1 + 2) + -4 + (longlong)param_4 * 4) = iVar12;
          piVar9 = (int *)(**(longlong **)(param_1 + 6) + -4 + (lVar10 + 1) * 4);
          *piVar9 = *piVar9 + 1;
        }
        goto LAB_140bfe7c7;
      }
      uVar4 = FUN_140bfdc50(param_1);
    } while ((int)uVar4 == 0);
  }
  return uVar4;
}

