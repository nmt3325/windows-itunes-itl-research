/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x526f40; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

int FUN_140526f40(longlong param_1,longlong param_2)

{
  longlong *plVar1;
  int *piVar2;
  int iVar3;
  int iVar4;
  int iVar5;
  undefined8 uVar6;
  longlong *plVar7;
  undefined8 *puVar8;
  int iVar9;
  uint uVar10;
  int *piVar11;
  undefined8 *puVar12;
  int *piVar13;
  int *piVar14;
  longlong lVar15;
  longlong lVar16;
  undefined1 uVar17;
  bool bVar18;
  undefined1 auStack_e28 [32];
  ushort *puStack_e08;
  int *piStack_e00;
  undefined1 uStack_df8;
  undefined1 uStack_df0;
  undefined8 auStack_de8 [2];
  int iStack_dd8;
  undefined1 uStack_dd4;
  char cStack_dd3;
  undefined8 uStack_dd0;
  longlong lStack_dc8;
  longlong lStack_da8;
  undefined *puStack_d88;
  code *pcStack_d80;
  uint uStack_d78;
  int iStack_d74;
  undefined **ppuStack_d50;
  undefined8 uStack_d48;
  undefined8 uStack_d40;
  undefined2 uStack_d38;
  undefined1 uStack_d36;
  ulonglong uStack_d30;
  undefined8 uStack_d28;
  longlong *plStack_d20;
  undefined8 uStack_d18;
  undefined8 uStack_d10;
  undefined8 uStack_d08;
  undefined8 uStack_d00;
  undefined8 uStack_cf8;
  undefined8 uStack_cf0;
  ulonglong uStack_ce8;
  undefined8 uStack_ce0;
  undefined8 uStack_cd8;
  undefined8 uStack_cd0;
  int aiStack_cc8 [4];
  longlong lStack_cb8;
  int aiStack_aa8 [4];
  longlong lStack_a98;
  int aiStack_888 [4];
  longlong lStack_878;
  int aiStack_668 [136];
  ushort uStack_448;
  undefined1 auStack_446 [510];
  ushort uStack_248;
  undefined1 auStack_246 [510];
  ulonglong uStack_48;
  
  uStack_48 = _DAT_141fd5040 ^ (ulonglong)auStack_e28;
  uVar17 = 0;
  bVar18 = false;
  iVar9 = FUN_140b9fe10(&iStack_dd8,0x20000);
  if (iVar9 != 0) goto LAB_1405272d6;
  bVar18 = true;
  lVar16 = 4;
  lVar15 = 4;
  puVar8 = (undefined8 *)(param_1 + 0x38);
  piVar2 = aiStack_cc8;
  do {
    piVar14 = piVar2;
    puVar12 = puVar8;
    uVar6 = puVar12[1];
    *(undefined8 *)piVar14 = *puVar12;
    *(undefined8 *)(piVar14 + 2) = uVar6;
    uVar6 = puVar12[3];
    *(undefined8 *)(piVar14 + 4) = puVar12[2];
    *(undefined8 *)(piVar14 + 6) = uVar6;
    uVar6 = puVar12[5];
    *(undefined8 *)(piVar14 + 8) = puVar12[4];
    *(undefined8 *)(piVar14 + 10) = uVar6;
    uVar6 = puVar12[7];
    *(undefined8 *)(piVar14 + 0xc) = puVar12[6];
    *(undefined8 *)(piVar14 + 0xe) = uVar6;
    uVar6 = puVar12[9];
    *(undefined8 *)(piVar14 + 0x10) = puVar12[8];
    *(undefined8 *)(piVar14 + 0x12) = uVar6;
    uVar6 = puVar12[0xb];
    *(undefined8 *)(piVar14 + 0x14) = puVar12[10];
    *(undefined8 *)(piVar14 + 0x16) = uVar6;
    uVar6 = puVar12[0xd];
    *(undefined8 *)(piVar14 + 0x18) = puVar12[0xc];
    *(undefined8 *)(piVar14 + 0x1a) = uVar6;
    uVar6 = puVar12[0xf];
    *(undefined8 *)(piVar14 + 0x1c) = puVar12[0xe];
    *(undefined8 *)(piVar14 + 0x1e) = uVar6;
    lVar15 = lVar15 + -1;
    puVar8 = puVar12 + 0x10;
    piVar2 = piVar14 + 0x20;
  } while (lVar15 != 0);
  uVar6 = puVar12[0x11];
  *(undefined8 *)(piVar14 + 0x20) = puVar12[0x10];
  *(undefined8 *)(piVar14 + 0x22) = uVar6;
  uVar6 = puVar12[0x13];
  *(undefined8 *)(piVar14 + 0x24) = puVar12[0x12];
  *(undefined8 *)(piVar14 + 0x26) = uVar6;
  lVar15 = 4;
  piVar2 = (int *)(param_1 + 600);
  piVar14 = aiStack_aa8;
  do {
    piVar13 = piVar14;
    piVar11 = piVar2;
    uVar6 = *(undefined8 *)(piVar11 + 2);
    *(undefined8 *)piVar13 = *(undefined8 *)piVar11;
    *(undefined8 *)(piVar13 + 2) = uVar6;
    uVar6 = *(undefined8 *)(piVar11 + 6);
    *(undefined8 *)(piVar13 + 4) = *(undefined8 *)(piVar11 + 4);
    *(undefined8 *)(piVar13 + 6) = uVar6;
    uVar6 = *(undefined8 *)(piVar11 + 10);
    *(undefined8 *)(piVar13 + 8) = *(undefined8 *)(piVar11 + 8);
    *(undefined8 *)(piVar13 + 10) = uVar6;
    uVar6 = *(undefined8 *)(piVar11 + 0xe);
    *(undefined8 *)(piVar13 + 0xc) = *(undefined8 *)(piVar11 + 0xc);
    *(undefined8 *)(piVar13 + 0xe) = uVar6;
    uVar6 = *(undefined8 *)(piVar11 + 0x12);
    *(undefined8 *)(piVar13 + 0x10) = *(undefined8 *)(piVar11 + 0x10);
    *(undefined8 *)(piVar13 + 0x12) = uVar6;
    uVar6 = *(undefined8 *)(piVar11 + 0x16);
    *(undefined8 *)(piVar13 + 0x14) = *(undefined8 *)(piVar11 + 0x14);
    *(undefined8 *)(piVar13 + 0x16) = uVar6;
    uVar6 = *(undefined8 *)(piVar11 + 0x1a);
    *(undefined8 *)(piVar13 + 0x18) = *(undefined8 *)(piVar11 + 0x18);
    *(undefined8 *)(piVar13 + 0x1a) = uVar6;
    uVar6 = *(undefined8 *)(piVar11 + 0x1e);
    *(undefined8 *)(piVar13 + 0x1c) = *(undefined8 *)(piVar11 + 0x1c);
    *(undefined8 *)(piVar13 + 0x1e) = uVar6;
    lVar15 = lVar15 + -1;
    piVar2 = piVar11 + 0x20;
    piVar14 = piVar13 + 0x20;
  } while (lVar15 != 0);
  iVar9 = piVar11[0x21];
  iVar3 = piVar11[0x22];
  iVar4 = piVar11[0x23];
  piVar13[0x20] = piVar11[0x20];
  piVar13[0x21] = iVar9;
  piVar13[0x22] = iVar3;
  piVar13[0x23] = iVar4;
  iVar9 = piVar11[0x25];
  iVar3 = piVar11[0x26];
  iVar4 = piVar11[0x27];
  piVar13[0x24] = piVar11[0x24];
  piVar13[0x25] = iVar9;
  piVar13[0x26] = iVar3;
  piVar13[0x27] = iVar4;
  uStack_448 = 0;
  FUN_140ae5fa0(&UNK_141b55e20,0xe,&uStack_448);
  FUN_140ae54a0(&UNK_141ab517c,&uStack_448);
  lVar15 = *(longlong *)(param_1 + 0x28);
  if (lVar15 != 0) {
    if ((*(int *)(lVar15 + 0x20) == 0x66726566) && (*(code **)(lVar15 + 0x2f0) != (code *)0x0)) {
      (**(code **)(lVar15 + 0x2f0))(lVar15,aiStack_cc8);
    }
    if ((lStack_cb8 != 0) && ((aiStack_cc8[0] == 0x41464350 || (aiStack_cc8[0] == 0x57696e50)))) {
      (**(code **)(lStack_cb8 + 0xc0))(aiStack_cc8,aiStack_aa8);
    }
    uStack_448 = 0;
    if ((lStack_cb8 != 0) && ((aiStack_cc8[0] == 0x41464350 || (aiStack_cc8[0] == 0x57696e50)))) {
      (**(code **)(lStack_cb8 + 0x10))(aiStack_cc8,&uStack_448);
    }
    lVar15 = *(longlong *)(param_1 + 0x28);
    if (((lVar15 != 0) && (*(int *)(lVar15 + 0x20) == 0x66726566)) &&
       (*(code **)(lVar15 + 0x260) != (code *)0x0)) {
      (**(code **)(lVar15 + 0x260))(lVar15);
      *(undefined4 *)(lVar15 + 0x20) = 0;
      _aligned_free(lVar15);
    }
    *(undefined8 *)(param_1 + 0x28) = 0;
  }
  FUN_140526420(param_2);
  iVar9 = FUN_141075810(param_2,&iStack_dd8);
  if (iVar9 != 0) goto LAB_1405272d6;
  uStack_d18 = 0;
  uStack_d10 = 0;
  uStack_d08 = 0;
  uStack_d00 = 0;
  uStack_cf8 = 0;
  uStack_cf0 = 0;
  uStack_ce8 = 0;
  uStack_ce0 = 0;
  uStack_cd8 = 0;
  uStack_cd0 = 0;
  iVar9 = FUN_140e8ca40(aiStack_888,&uStack_248);
  if (iVar9 == 0) {
    uVar17 = 1;
    uVar10 = 0xff;
    if (uStack_248 < 0x100) {
      uVar10 = (uint)uStack_248;
      uStack_448 = uStack_248;
      if (uVar10 != 0) goto LAB_1405271ea;
    }
    else {
      uStack_448 = 0xff;
LAB_1405271ea:
      func_0x00014179cc9a(auStack_446,auStack_246,uVar10 * 2);
    }
    lVar15 = 4;
    piVar2 = aiStack_aa8;
    piVar14 = aiStack_888;
    do {
      piVar13 = piVar14;
      piVar11 = piVar2;
      uVar6 = *(undefined8 *)(piVar13 + 2);
      *(undefined8 *)piVar11 = *(undefined8 *)piVar13;
      *(undefined8 *)(piVar11 + 2) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 6);
      *(undefined8 *)(piVar11 + 4) = *(undefined8 *)(piVar13 + 4);
      *(undefined8 *)(piVar11 + 6) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 10);
      *(undefined8 *)(piVar11 + 8) = *(undefined8 *)(piVar13 + 8);
      *(undefined8 *)(piVar11 + 10) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0xe);
      *(undefined8 *)(piVar11 + 0xc) = *(undefined8 *)(piVar13 + 0xc);
      *(undefined8 *)(piVar11 + 0xe) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0x12);
      *(undefined8 *)(piVar11 + 0x10) = *(undefined8 *)(piVar13 + 0x10);
      *(undefined8 *)(piVar11 + 0x12) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0x16);
      *(undefined8 *)(piVar11 + 0x14) = *(undefined8 *)(piVar13 + 0x14);
      *(undefined8 *)(piVar11 + 0x16) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0x1a);
      *(undefined8 *)(piVar11 + 0x18) = *(undefined8 *)(piVar13 + 0x18);
      *(undefined8 *)(piVar11 + 0x1a) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0x1e);
      *(undefined8 *)(piVar11 + 0x1c) = *(undefined8 *)(piVar13 + 0x1c);
      *(undefined8 *)(piVar11 + 0x1e) = uVar6;
      lVar15 = lVar15 + -1;
      piVar2 = piVar11 + 0x20;
      piVar14 = piVar13 + 0x20;
    } while (lVar15 != 0);
    iVar9 = piVar13[0x21];
    iVar3 = piVar13[0x22];
    iVar4 = piVar13[0x23];
    piVar11[0x20] = piVar13[0x20];
    piVar11[0x21] = iVar9;
    piVar11[0x22] = iVar3;
    piVar11[0x23] = iVar4;
    iVar9 = piVar13[0x25];
    iVar3 = piVar13[0x26];
    iVar4 = piVar13[0x27];
    piVar11[0x24] = piVar13[0x24];
    piVar11[0x25] = iVar9;
    piVar11[0x26] = iVar3;
    piVar11[0x27] = iVar4;
    if (((lStack_878 == 0) || ((aiStack_888[0] != 0x41464350 && (aiStack_888[0] != 0x57696e50)))) ||
       (*(code **)(lStack_878 + 0x38) == (code *)0x0)) {
      iVar9 = -0x32;
    }
    else {
      iVar9 = (**(code **)(lStack_878 + 0x38))(aiStack_aa8,&uStack_448,aiStack_cc8,&uStack_d18);
      if (iVar9 == 0) goto LAB_1405272ba;
      aiStack_cc8[0] = 0;
    }
    uVar17 = 1;
    if (iVar9 != 0) goto LAB_14052780b;
LAB_1405272ba:
    if ((char)uStack_d18 != '\0') {
      iVar9 = -0x516;
      FUN_140ba02c0(&iStack_dd8);
      bVar18 = false;
      goto LAB_1405272d6;
    }
    lVar15 = 4;
    piVar2 = aiStack_668;
    piVar14 = aiStack_cc8;
    do {
      piVar13 = piVar14;
      piVar11 = piVar2;
      uVar6 = *(undefined8 *)(piVar13 + 2);
      *(undefined8 *)piVar11 = *(undefined8 *)piVar13;
      *(undefined8 *)(piVar11 + 2) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 6);
      *(undefined8 *)(piVar11 + 4) = *(undefined8 *)(piVar13 + 4);
      *(undefined8 *)(piVar11 + 6) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 10);
      *(undefined8 *)(piVar11 + 8) = *(undefined8 *)(piVar13 + 8);
      *(undefined8 *)(piVar11 + 10) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0xe);
      *(undefined8 *)(piVar11 + 0xc) = *(undefined8 *)(piVar13 + 0xc);
      *(undefined8 *)(piVar11 + 0xe) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0x12);
      *(undefined8 *)(piVar11 + 0x10) = *(undefined8 *)(piVar13 + 0x10);
      *(undefined8 *)(piVar11 + 0x12) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0x16);
      *(undefined8 *)(piVar11 + 0x14) = *(undefined8 *)(piVar13 + 0x14);
      *(undefined8 *)(piVar11 + 0x16) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0x1a);
      *(undefined8 *)(piVar11 + 0x18) = *(undefined8 *)(piVar13 + 0x18);
      *(undefined8 *)(piVar11 + 0x1a) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0x1e);
      *(undefined8 *)(piVar11 + 0x1c) = *(undefined8 *)(piVar13 + 0x1c);
      *(undefined8 *)(piVar11 + 0x1e) = uVar6;
      lVar15 = lVar15 + -1;
      piVar2 = piVar11 + 0x20;
      piVar14 = piVar13 + 0x20;
    } while (lVar15 != 0);
    iVar9 = piVar13[0x21];
    iVar3 = piVar13[0x22];
    iVar4 = piVar13[0x23];
    piVar11[0x20] = piVar13[0x20];
    piVar11[0x21] = iVar9;
    piVar11[0x22] = iVar3;
    piVar11[0x23] = iVar4;
    iVar9 = piVar13[0x25];
    iVar3 = piVar13[0x26];
    iVar4 = piVar13[0x27];
    piVar11[0x24] = piVar13[0x24];
    piVar11[0x25] = iVar9;
    piVar11[0x26] = iVar3;
    piVar11[0x27] = iVar4;
    if ((uStack_ce8 & 0x8000) == 0) goto LAB_14052780b;
    if (((lStack_cb8 == 0) || ((aiStack_cc8[0] != 0x41464350 && (aiStack_cc8[0] != 0x57696e50)))) ||
       ((*(code **)(lStack_cb8 + 0xf0) == (code *)0x0 ||
        (iVar9 = (**(code **)(lStack_cb8 + 0xf0))(aiStack_668,aiStack_cc8,1,0), iVar9 != 0)))) {
      piVar2 = (int *)(param_1 + 600);
      if (((piVar2 == (int *)0x0) || (*(longlong *)(param_1 + 0x268) == 0)) ||
         ((*piVar2 != 0x41464350 && (*piVar2 != 0x57696e50)))) {
        iVar9 = -0x32;
        goto LAB_140527807;
      }
      iVar9 = (**(code **)(*(longlong *)(param_1 + 0x268) + 8))(piVar2,0,0);
      if (iVar9 == 0) {
        lVar15 = 4;
        piVar2 = (int *)(param_1 + 600);
        piVar14 = aiStack_aa8;
        do {
          piVar13 = piVar14;
          piVar11 = piVar2;
          uVar6 = *(undefined8 *)(piVar11 + 2);
          *(undefined8 *)piVar13 = *(undefined8 *)piVar11;
          *(undefined8 *)(piVar13 + 2) = uVar6;
          uVar6 = *(undefined8 *)(piVar11 + 6);
          *(undefined8 *)(piVar13 + 4) = *(undefined8 *)(piVar11 + 4);
          *(undefined8 *)(piVar13 + 6) = uVar6;
          uVar6 = *(undefined8 *)(piVar11 + 10);
          *(undefined8 *)(piVar13 + 8) = *(undefined8 *)(piVar11 + 8);
          *(undefined8 *)(piVar13 + 10) = uVar6;
          uVar6 = *(undefined8 *)(piVar11 + 0xe);
          *(undefined8 *)(piVar13 + 0xc) = *(undefined8 *)(piVar11 + 0xc);
          *(undefined8 *)(piVar13 + 0xe) = uVar6;
          uVar6 = *(undefined8 *)(piVar11 + 0x12);
          *(undefined8 *)(piVar13 + 0x10) = *(undefined8 *)(piVar11 + 0x10);
          *(undefined8 *)(piVar13 + 0x12) = uVar6;
          uVar6 = *(undefined8 *)(piVar11 + 0x16);
          *(undefined8 *)(piVar13 + 0x14) = *(undefined8 *)(piVar11 + 0x14);
          *(undefined8 *)(piVar13 + 0x16) = uVar6;
          uVar6 = *(undefined8 *)(piVar11 + 0x1a);
          *(undefined8 *)(piVar13 + 0x18) = *(undefined8 *)(piVar11 + 0x18);
          *(undefined8 *)(piVar13 + 0x1a) = uVar6;
          uVar6 = *(undefined8 *)(piVar11 + 0x1e);
          *(undefined8 *)(piVar13 + 0x1c) = *(undefined8 *)(piVar11 + 0x1c);
          *(undefined8 *)(piVar13 + 0x1e) = uVar6;
          lVar15 = lVar15 + -1;
          piVar2 = piVar11 + 0x20;
          piVar14 = piVar13 + 0x20;
        } while (lVar15 != 0);
        iVar3 = piVar11[0x21];
        iVar4 = piVar11[0x22];
        iVar5 = piVar11[0x23];
        piVar13[0x20] = piVar11[0x20];
        piVar13[0x21] = iVar3;
        piVar13[0x22] = iVar4;
        piVar13[0x23] = iVar5;
        uVar6 = *(undefined8 *)(piVar11 + 0x26);
        *(undefined8 *)(piVar13 + 0x24) = *(undefined8 *)(piVar11 + 0x24);
        *(undefined8 *)(piVar13 + 0x26) = uVar6;
        goto LAB_140527807;
      }
    }
    else {
      if ((lStack_cb8 != 0) && ((aiStack_cc8[0] == 0x41464350 || (aiStack_cc8[0] == 0x57696e50)))) {
        (**(code **)(lStack_cb8 + 0xc0))(aiStack_cc8,aiStack_aa8);
      }
      uStack_448 = 0;
      iVar9 = 0;
      if ((lStack_cb8 != 0) && ((aiStack_cc8[0] == 0x41464350 || (aiStack_cc8[0] == 0x57696e50)))) {
        (**(code **)(lStack_cb8 + 0x10))(aiStack_cc8,&uStack_448);
      }
LAB_140527807:
      if (iVar9 == 0) goto LAB_14052780b;
    }
  }
  else {
    iVar9 = FUN_141136a50(4,3,aiStack_aa8);
    if (iVar9 == 0) {
      if (((lStack_a98 == 0) || ((aiStack_aa8[0] != 0x41464350 && (aiStack_aa8[0] != 0x57696e50))))
         || (*(code **)(lStack_a98 + 0x38) == (code *)0x0)) {
LAB_1405274e2:
        uStack_448 = 0;
        FUN_140ae5fa0(&UNK_141b55e20,0xe,&uStack_448);
        FUN_140ae54a0(&UNK_141ab517c,&uStack_448);
        if (((lStack_a98 == 0) || ((aiStack_aa8[0] != 0x41464350 && (aiStack_aa8[0] != 0x57696e50)))
            ) || (*(code **)(lStack_a98 + 0x38) == (code *)0x0)) {
          iVar9 = -0x32;
        }
        else {
          iVar9 = (**(code **)(lStack_a98 + 0x38))(aiStack_aa8,&uStack_448,aiStack_cc8,&uStack_d18);
          if (iVar9 == 0) goto LAB_1405272ba;
          aiStack_cc8[0] = 0;
        }
        if (iVar9 != 0) {
          uStack_448 = 0;
          FUN_140ae5fa0(&UNK_141b55e20,0xe,&uStack_448);
          if ((lStack_a98 != 0) &&
             (((aiStack_aa8[0] == 0x41464350 || (aiStack_aa8[0] == 0x57696e50)) &&
              (*(code **)(lStack_a98 + 0x38) != (code *)0x0)))) {
            iVar9 = (**(code **)(lStack_a98 + 0x38))
                              (aiStack_aa8,&uStack_448,aiStack_cc8,&uStack_d18);
            if (iVar9 == 0) goto LAB_1405272ba;
            aiStack_cc8[0] = 0;
          }
          uStack_448 = 0;
          FUN_140ae5fa0(&UNK_141b55e20,0xe,&uStack_448);
          FUN_140ae54a0(&UNK_141ab517c,&uStack_448);
          goto LAB_14052780b;
        }
      }
      else {
        iVar9 = (**(code **)(lStack_a98 + 0x38))(aiStack_aa8,&uStack_448,aiStack_cc8,&uStack_d18);
        if (iVar9 != 0) {
          aiStack_cc8[0] = 0;
          goto LAB_1405274e2;
        }
      }
      goto LAB_1405272ba;
    }
LAB_14052780b:
    bVar18 = true;
    if ((_DAT_1420a6f30 != 0) && (bVar18 = true, *(longlong *)(_DAT_1420a6f30 + 0x14190) != 0)) {
      bVar18 = *(char *)(*(longlong *)(_DAT_1420a6f30 + 0x14190) + 0x5eb) != '\0';
    }
    uStack_df0 = *(char *)(param_1 + 0x47c) != '\0';
    piStack_e00 = aiStack_cc8;
    puStack_e08 = &uStack_448;
    uStack_df8 = uVar17;
    iVar9 = FUN_141076b60(param_2,&iStack_dd8,bVar18,aiStack_aa8);
    if (iVar9 == 0) {
      iVar9 = FUN_140526ce0(param_2);
    }
  }
  FUN_140ba02c0(&iStack_dd8);
  bVar18 = false;
  if (iVar9 == 0) {
    FUN_140ecf880(param_2);
    lVar15 = 4;
    puVar8 = (undefined8 *)(param_1 + 0x38);
    piVar2 = aiStack_cc8;
    do {
      piVar14 = piVar2;
      puVar12 = puVar8;
      uVar6 = *(undefined8 *)(piVar14 + 2);
      *puVar12 = *(undefined8 *)piVar14;
      puVar12[1] = uVar6;
      uVar6 = *(undefined8 *)(piVar14 + 6);
      puVar12[2] = *(undefined8 *)(piVar14 + 4);
      puVar12[3] = uVar6;
      uVar6 = *(undefined8 *)(piVar14 + 10);
      puVar12[4] = *(undefined8 *)(piVar14 + 8);
      puVar12[5] = uVar6;
      uVar6 = *(undefined8 *)(piVar14 + 0xe);
      puVar12[6] = *(undefined8 *)(piVar14 + 0xc);
      puVar12[7] = uVar6;
      uVar6 = *(undefined8 *)(piVar14 + 0x12);
      puVar12[8] = *(undefined8 *)(piVar14 + 0x10);
      puVar12[9] = uVar6;
      uVar6 = *(undefined8 *)(piVar14 + 0x16);
      puVar12[10] = *(undefined8 *)(piVar14 + 0x14);
      puVar12[0xb] = uVar6;
      uVar6 = *(undefined8 *)(piVar14 + 0x1a);
      puVar12[0xc] = *(undefined8 *)(piVar14 + 0x18);
      puVar12[0xd] = uVar6;
      uVar6 = *(undefined8 *)(piVar14 + 0x1e);
      puVar12[0xe] = *(undefined8 *)(piVar14 + 0x1c);
      puVar12[0xf] = uVar6;
      lVar15 = lVar15 + -1;
      puVar8 = puVar12 + 0x10;
      piVar2 = piVar14 + 0x20;
    } while (lVar15 != 0);
    uVar6 = *(undefined8 *)(piVar14 + 0x22);
    puVar12[0x10] = *(undefined8 *)(piVar14 + 0x20);
    puVar12[0x11] = uVar6;
    uVar6 = *(undefined8 *)(piVar14 + 0x26);
    puVar12[0x12] = *(undefined8 *)(piVar14 + 0x24);
    puVar12[0x13] = uVar6;
    piVar2 = (int *)(param_1 + 600);
    piVar14 = aiStack_aa8;
    do {
      piVar13 = piVar14;
      piVar11 = piVar2;
      uVar6 = *(undefined8 *)(piVar13 + 2);
      *(undefined8 *)piVar11 = *(undefined8 *)piVar13;
      *(undefined8 *)(piVar11 + 2) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 6);
      *(undefined8 *)(piVar11 + 4) = *(undefined8 *)(piVar13 + 4);
      *(undefined8 *)(piVar11 + 6) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 10);
      *(undefined8 *)(piVar11 + 8) = *(undefined8 *)(piVar13 + 8);
      *(undefined8 *)(piVar11 + 10) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0xe);
      *(undefined8 *)(piVar11 + 0xc) = *(undefined8 *)(piVar13 + 0xc);
      *(undefined8 *)(piVar11 + 0xe) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0x12);
      *(undefined8 *)(piVar11 + 0x10) = *(undefined8 *)(piVar13 + 0x10);
      *(undefined8 *)(piVar11 + 0x12) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0x16);
      *(undefined8 *)(piVar11 + 0x14) = *(undefined8 *)(piVar13 + 0x14);
      *(undefined8 *)(piVar11 + 0x16) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0x1a);
      *(undefined8 *)(piVar11 + 0x18) = *(undefined8 *)(piVar13 + 0x18);
      *(undefined8 *)(piVar11 + 0x1a) = uVar6;
      uVar6 = *(undefined8 *)(piVar13 + 0x1e);
      *(undefined8 *)(piVar11 + 0x1c) = *(undefined8 *)(piVar13 + 0x1c);
      *(undefined8 *)(piVar11 + 0x1e) = uVar6;
      lVar16 = lVar16 + -1;
      piVar2 = piVar11 + 0x20;
      piVar14 = piVar13 + 0x20;
    } while (lVar16 != 0);
    iVar9 = piVar13[0x21];
    iVar3 = piVar13[0x22];
    iVar4 = piVar13[0x23];
    piVar11[0x20] = piVar13[0x20];
    piVar11[0x21] = iVar9;
    piVar11[0x22] = iVar3;
    piVar11[0x23] = iVar4;
    iVar9 = piVar13[0x25];
    iVar3 = piVar13[0x26];
    iVar4 = piVar13[0x27];
    piVar11[0x24] = piVar13[0x24];
    piVar11[0x25] = iVar9;
    piVar11[0x26] = iVar3;
    piVar11[0x27] = iVar4;
    *(undefined1 *)(param_1 + 0x30) = 1;
    iVar9 = FUN_140b19490(aiStack_cc8,0x64617461,3,param_1 + 0x28);
    if (iVar9 != 0) {
      return 0;
    }
    auStack_de8[0] = 0;
    lVar15 = *(longlong *)(param_1 + 0x28);
    if (((lVar15 != 0) && (*(int *)(lVar15 + 0x20) == 0x66726566)) &&
       (*(code **)(lVar15 + 0x268) != (code *)0x0)) {
      (**(code **)(lVar15 + 0x268))(lVar15,auStack_de8);
    }
    lVar15 = *(longlong *)(param_1 + 0x28);
    if (lVar15 == 0) {
      return 0;
    }
    if (*(int *)(lVar15 + 0x20) != 0x66726566) {
      return 0;
    }
    if (*(code **)(lVar15 + 0x280) == (code *)0x0) {
      return 0;
    }
    (**(code **)(lVar15 + 0x280))(lVar15,auStack_de8[0]);
    return 0;
  }
LAB_1405272d6:
  uStack_d78 = *(uint *)(param_2 + 0x90);
  puStack_d88 = &UNK_141ab1ba0;
  pcStack_d80 = FUN_1405269d0;
  ppuStack_d50 = &puStack_d88;
  uStack_d48 = 0;
  uStack_d40 = 0;
  uStack_d38 = 0;
  uStack_d36 = 0;
  uStack_d28 = 0;
  plStack_d20 = (longlong *)0x0;
  uStack_d30 = _DAT_1420a6f30 + 0x53a3c6d8166b2eceU ^ 0x9e3779babf9ce5e5;
  uStack_d30 = uStack_d30 * 0x40 + (uStack_d30 >> 2) + -0x61c8864680b583eb + (longlong)iVar9 ^
               uStack_d30;
  uStack_d30 = uStack_d30 * 0x40 + (uStack_d30 >> 2) + -0x61c8864680b583eb + (ulonglong)uStack_d78 ^
               uStack_d30;
  iStack_d74 = iVar9;
  FUN_140ae89a0(&puStack_d88);
  plVar7 = plStack_d20;
  if (plStack_d20 != (longlong *)0x0) {
    LOCK();
    plVar1 = plStack_d20 + 1;
    lVar15 = *plVar1;
    *(int *)plVar1 = (int)*plVar1 + -1;
    UNLOCK();
    if ((int)lVar15 == 1) {
      (**(code **)*plStack_d20)(plStack_d20);
      LOCK();
      piVar2 = (int *)((longlong)plVar7 + 0xc);
      iVar3 = *piVar2;
      *piVar2 = *piVar2 + -1;
      UNLOCK();
      if (iVar3 == 1) {
        (**(code **)(*plVar7 + 8))(plVar7);
      }
    }
  }
  if (ppuStack_d50 != (undefined **)0x0) {
    (**(code **)(*ppuStack_d50 + 0x20))(ppuStack_d50,ppuStack_d50 != &puStack_d88);
  }
  if ((bVar18) && (iStack_dd8 == 0x62756666)) {
    uStack_dd4 = 1;
    if (cStack_dd3 == '\0') {
      FUN_140ba0000(&iStack_dd8);
    }
    FUN_140bd5150(uStack_dd0);
    if (lStack_dc8 != 0) {
      FUN_140bd7440();
    }
    if (lStack_da8 != 0) {
      _aligned_free();
    }
  }
  return iVar9;
}

