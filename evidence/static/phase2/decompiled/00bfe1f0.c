/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xbfe1f0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

ulonglong FUN_140bfe1f0(int *param_1,char *param_2,uint param_3,int *param_4)

{
  longlong *plVar1;
  byte bVar2;
  longlong lVar3;
  longlong *plVar4;
  uint uVar5;
  int iVar6;
  uint uVar7;
  ulonglong uVar8;
  longlong lVar9;
  uint uVar10;
  int *piVar11;
  int iVar12;
  int iVar13;
  
  if (param_4 != (int *)0x0) {
    *param_4 = 0;
  }
  if (((param_1 == (int *)0x0) || (*param_1 != 0x73747263)) || (param_1[0xf] != 0)) {
    return 0xffffffce;
  }
  if (param_3 != 0) {
    if (param_1[10] != 0) {
      return 0xffffffce;
    }
    bVar2 = *(byte *)(param_1 + 1);
    if ((((bVar2 & 1) != 0) && (*(longlong **)(param_1 + 4) != (longlong *)0x0)) &&
       (*(longlong **)(param_1 + 8) != (longlong *)0x0)) {
      param_1[0xf] = 1;
      lVar9 = **(longlong **)(param_1 + 8);
      lVar3 = **(longlong **)(param_1 + 6);
      piVar11 = (int *)(**(longlong **)(param_1 + 4) + ((longlong)param_1[0xb] + -1) * 8);
      iVar13 = param_1[0xb];
      while (iVar12 = iVar13 + -1, -1 < iVar12) {
        if (((piVar11[1] == param_3) && (iVar6 = *piVar11, -1 < iVar6)) &&
           ((0 < piVar11[1] &&
            ((*param_2 == *(char *)(lVar9 + iVar6) &&
             (iVar6 = func_0x00014179cc94(param_2,lVar9 + iVar6,(longlong)(int)param_3), iVar6 == 0)
             ))))) {
          piVar11 = (int *)(lVar3 + (longlong)iVar12 * 4);
          *piVar11 = *piVar11 + 1;
          if (param_4 != (int *)0x0) {
            *param_4 = iVar13;
          }
          if (*param_1 != 0x73747263) {
            return 0;
          }
          if (param_1[0xf] < 1) {
            return 0;
          }
          param_1[0xf] = param_1[0xf] + -1;
          return 0;
        }
        piVar11 = piVar11 + -2;
        iVar13 = iVar12;
      }
      if (0 < param_1[0xf]) {
        param_1[0xf] = param_1[0xf] + -1;
      }
    }
    while( true ) {
      iVar13 = 0;
      FUN_140bfde40(param_1);
      if (param_1[0xc] != 0) break;
      uVar8 = FUN_140bfdc50(param_1);
      if ((int)uVar8 != 0) {
        return uVar8;
      }
    }
    plVar4 = *(longlong **)(param_1 + 4);
    lVar9 = *(longlong *)(param_1 + 8);
    plVar1 = (longlong *)(param_1 + 8);
    piVar11 = (int *)(*plVar4 + ((longlong)param_1[0xc] + -1) * 8);
    param_1[0xc] = piVar11[1];
    iVar12 = (int)((longlong)piVar11 - *plVar4 >> 3) + 1;
    if (lVar9 == 0) {
      iVar13 = 0;
    }
    else {
      if (*(int *)(lVar9 + 8) == 0x4d656d48) {
        iVar13 = *(int *)(lVar9 + 0x10);
      }
      iVar13 = iVar13 - param_1[0xd];
    }
    if (param_1[0xd] < (int)param_3) {
      uVar7 = param_1[0xe];
      uVar5 = uVar7;
      if (uVar7 < param_3) {
        uVar5 = param_3;
      }
      uVar10 = (uint)(longlong)((float)iVar13 * 1.1);
      if (uVar10 <= uVar5) {
        uVar10 = uVar5;
      }
      if (uVar7 < 0x2000) {
        param_1[0xe] = uVar7 * 2;
      }
      if (plVar1 == (longlong *)0x0) {
        uVar8 = 0xffffffce;
        piVar11 = (int *)(*plVar4 + -8 + (longlong)iVar12 * 8);
LAB_140bfe472:
        *piVar11 = -0x80000000;
        piVar11[1] = param_1[0xc];
        param_1[0xc] = iVar12;
        return uVar8;
      }
      lVar9 = *plVar1;
      if (lVar9 == 0) {
        if ((int)uVar10 < 0) {
          uVar8 = 0xffffff94;
        }
        else {
          lVar9 = FUN_140bc6490((longlong)(int)uVar10);
          *plVar1 = lVar9;
          uVar8 = 0xffffff94;
          if (lVar9 != 0) {
            uVar8 = 0;
          }
        }
      }
      else {
        if (*(int *)(lVar9 + 8) == 0x4d656d48) {
          iVar6 = *(int *)(lVar9 + 0x10);
        }
        else {
          iVar6 = 0;
        }
        if (((int)uVar10 < 0) && ((int)(uVar10 + iVar6) < 0)) {
          uVar8 = 0xffffffce;
          piVar11 = (int *)(**(longlong **)(param_1 + 4) + -8 + (longlong)iVar12 * 8);
          goto LAB_140bfe472;
        }
        uVar7 = FUN_140bc65c0(lVar9,(longlong)(int)(uVar10 + iVar6));
        uVar8 = (ulonglong)uVar7;
      }
      piVar11 = (int *)(**(longlong **)(param_1 + 4) + -8 + (longlong)iVar12 * 8);
      if ((int)uVar8 != 0) goto LAB_140bfe472;
      param_1[0xd] = param_1[0xd] + uVar10;
    }
    if ((param_2 != (char *)0x0) && ((longlong)iVar13 + **(longlong **)(param_1 + 8) != 0)) {
      func_0x000141867875((longlong)iVar13 + **(longlong **)(param_1 + 8),param_2,
                          (longlong)(int)param_3);
    }
    param_1[0xd] = param_1[0xd] - param_3;
    *piVar11 = iVar13;
    piVar11[1] = param_3;
    if (param_4 != (int *)0x0) {
      *param_4 = iVar12;
    }
    if ((bVar2 & 1) != 0) {
      piVar11 = (int *)(**(longlong **)(param_1 + 6) + -4 + (longlong)iVar12 * 4);
      *piVar11 = *piVar11 + 1;
    }
  }
  return 0;
}

