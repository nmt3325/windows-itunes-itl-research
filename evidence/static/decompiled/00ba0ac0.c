/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xba0ac0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Type propagation algorithm not settling */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

ulonglong FUN_140ba0ac0(int *param_1)

{
  int *piVar1;
  short *psVar2;
  code *pcVar3;
  undefined8 uVar4;
  ulonglong uVar5;
  undefined4 uVar6;
  undefined4 uVar7;
  undefined4 uVar8;
  undefined4 uVar9;
  ulonglong uVar10;
  bool bVar11;
  ulonglong *puVar12;
  int iVar13;
  uint uVar14;
  ulonglong uVar15;
  ulonglong *puVar16;
  longlong lVar17;
  longlong lVar18;
  longlong *plVar19;
  ulonglong uVar20;
  ulonglong *puVar21;
  ulonglong *puVar22;
  longlong lVar23;
  char cVar24;
  uint uVar25;
  longlong lVar26;
  undefined1 auStack_978 [32];
  ulonglong *puStack_958;
  char cStack_948;
  byte bStack_947;
  uint uStack_944;
  longlong lStack_940;
  ulonglong uStack_938;
  longlong lStack_930;
  ulonglong uStack_928;
  ulonglong uStack_920;
  undefined8 uStack_918;
  undefined2 *puStack_910;
  undefined8 uStack_908;
  undefined8 uStack_900;
  undefined8 uStack_8f8;
  undefined8 uStack_8f0;
  short *psStack_8e8;
  int aiStack_8c8 [4];
  longlong *plStack_8b8;
  int aiStack_6a8 [4];
  longlong *plStack_698;
  char acStack_488 [3];
  char cStack_485;
  short asStack_438 [256];
  undefined2 auStack_238 [256];
  ulonglong uStack_38;
  
  uStack_38 = _DAT_141fd5040 ^ (ulonglong)auStack_978;
  lVar18 = 0;
  lStack_940 = 0;
  if ((((param_1 == (int *)0x0) || (*param_1 != 0x62776266)) ||
      (piVar1 = *(int **)(param_1 + 6), piVar1 == (int *)0x0)) ||
     ((psVar2 = *(short **)(param_1 + 10), psVar2 == (short *)0x0 || (*psVar2 == 0)))) {
    return 0xffffffce;
  }
  uVar14 = param_1[4];
  bStack_947 = (byte)uVar14 & 1;
  uVar25 = CONCAT31((uint3)(uVar14 >> 9),(char)(uVar14 >> 1)) & 0xffffff01;
  lVar26 = 4;
  uStack_944 = uVar25;
  if (((*(longlong *)(piVar1 + 4) == 0) || ((*piVar1 != 0x41464350 && (*piVar1 != 0x57696e50)))) ||
     (pcVar3 = *(code **)(*(longlong *)(piVar1 + 4) + 0x38), pcVar3 == (code *)0x0)) {
LAB_140ba0b9b:
    cVar24 = '\0';
    cStack_948 = '\0';
    if ((uVar14 & 1) != 0) goto LAB_140ba0bab;
LAB_140ba0e4e:
    cStack_948 = '\0';
    piVar1 = *(int **)(param_1 + 6);
    psVar2 = *(short **)(param_1 + 10);
    if (piVar1 == (int *)0x0) {
      return 0xffffffce;
    }
    if (*(longlong *)(piVar1 + 4) == 0) {
      return 0xffffffce;
    }
    if ((*piVar1 != 0x41464350) && (*piVar1 != 0x57696e50)) {
      return 0xffffffce;
    }
    if (psVar2 == (short *)0x0) {
      return 0xffffffce;
    }
    if (*psVar2 == 0) {
      return 0xffffffce;
    }
    pcVar3 = *(code **)(*(longlong *)(piVar1 + 4) + 0x70);
    if (pcVar3 == (code *)0x0) {
      return 0xfffffffc;
    }
    puStack_958 = (ulonglong *)aiStack_6a8;
    uVar14 = (*pcVar3)(piVar1,psVar2,param_1[8],param_1[9]);
    if (uVar14 != 0) {
      return (ulonglong)uVar14;
    }
    if ((char)uVar25 != '\0') {
      puVar22 = (ulonglong *)aiStack_6a8;
      goto LAB_140ba0fb5;
    }
  }
  else {
    iVar13 = (*pcVar3)(piVar1,psVar2,aiStack_6a8,acStack_488);
    if (iVar13 != 0) {
      aiStack_6a8[0] = 0;
      goto LAB_140ba0b9b;
    }
    if (acStack_488[0] != '\0') {
      return 0xfffffaea;
    }
    if (cStack_485 != '\0') {
      return 0xffffffd3;
    }
    if ((uVar14 & 1) == 0) {
      if (plStack_698 == (longlong *)0x0) {
        return 0xffffffce;
      }
      if ((aiStack_6a8[0] != 0x41464350) && (aiStack_6a8[0] != 0x57696e50)) {
        return 0xffffffce;
      }
      if ((code *)plStack_698[0xf] == (code *)0x0) {
        return 0xfffffffc;
      }
      uVar14 = (*(code *)plStack_698[0xf])(aiStack_6a8);
      if (uVar14 != 0) {
        return (ulonglong)uVar14;
      }
      goto LAB_140ba0e4e;
    }
    if (plStack_698 == (longlong *)0x0) {
      return 0xffffffce;
    }
    if ((aiStack_6a8[0] != 0x41464350) && (aiStack_6a8[0] != 0x57696e50)) {
      return 0xffffffce;
    }
    if (*plStack_698 == 0) {
      return 0xffffffce;
    }
    lVar17 = FUN_140b930a0(0x340);
    if (lVar17 == 0) {
      return 0xffffff94;
    }
    *(undefined4 *)(lVar17 + 0x20) = 0x66726566;
    *(undefined4 *)(lVar17 + 0x24) = 3;
    lVar23 = 4;
    *(undefined4 *)(lVar17 + 0x28) = 0x64617461;
    puVar22 = (ulonglong *)(lVar17 + 0x38);
    puVar12 = (ulonglong *)aiStack_6a8;
    do {
      puVar21 = puVar12;
      puVar16 = puVar22;
      uVar15 = puVar21[1];
      uVar5 = puVar21[2];
      uVar20 = puVar21[3];
      *puVar16 = *puVar21;
      puVar16[1] = uVar15;
      uVar15 = puVar21[4];
      uVar10 = puVar21[5];
      puVar16[2] = uVar5;
      puVar16[3] = uVar20;
      uVar5 = puVar21[6];
      uVar20 = puVar21[7];
      puVar16[4] = uVar15;
      puVar16[5] = uVar10;
      uVar15 = puVar21[8];
      uVar10 = puVar21[9];
      puVar16[6] = uVar5;
      puVar16[7] = uVar20;
      uVar5 = puVar21[10];
      uVar20 = puVar21[0xb];
      puVar16[8] = uVar15;
      puVar16[9] = uVar10;
      uVar15 = puVar21[0xc];
      uVar10 = puVar21[0xd];
      puVar16[10] = uVar5;
      puVar16[0xb] = uVar20;
      uVar5 = puVar21[0xe];
      uVar20 = puVar21[0xf];
      puVar16[0xc] = uVar15;
      puVar16[0xd] = uVar10;
      puVar16[0xe] = uVar5;
      puVar16[0xf] = uVar20;
      lVar23 = lVar23 + -1;
      puVar22 = puVar16 + 0x10;
      puVar12 = puVar21 + 0x10;
    } while (lVar23 != 0);
    uVar6 = *(undefined4 *)((longlong)puVar21 + 0x84);
    uVar15 = puVar21[0x11];
    uVar7 = *(undefined4 *)((longlong)puVar21 + 0x8c);
    uVar5 = puVar21[0x12];
    uVar8 = *(undefined4 *)((longlong)puVar21 + 0x94);
    uVar20 = puVar21[0x13];
    uVar9 = *(undefined4 *)((longlong)puVar21 + 0x9c);
    *(int *)(puVar16 + 0x10) = (int)puVar21[0x10];
    *(undefined4 *)((longlong)puVar16 + 0x84) = uVar6;
    *(int *)(puVar16 + 0x11) = (int)uVar15;
    *(undefined4 *)((longlong)puVar16 + 0x8c) = uVar7;
    *(int *)(puVar16 + 0x12) = (int)uVar5;
    *(undefined4 *)((longlong)puVar16 + 0x94) = uVar8;
    *(int *)(puVar16 + 0x13) = (int)uVar20;
    *(undefined4 *)((longlong)puVar16 + 0x9c) = uVar9;
    LOCK();
    UNLOCK();
    iVar13 = _DAT_1420130b8 + 1;
    *(int *)(lVar17 + 600) = _DAT_1420130b8;
    _DAT_1420130b8 = iVar13;
    uVar14 = (*(code *)*plStack_698)(lVar17);
    if (uVar14 != 0) {
      _aligned_free(lVar17);
      return (ulonglong)uVar14;
    }
    if ((*(int *)(lVar17 + 0x20) == 0x66726566) && (*(code **)(lVar17 + 0x260) != (code *)0x0)) {
      (**(code **)(lVar17 + 0x260))(lVar17);
      *(undefined4 *)(lVar17 + 0x20) = 0;
      _aligned_free(lVar17);
    }
    cVar24 = '\x01';
    cStack_948 = '\x01';
LAB_140ba0bab:
    if ((*(byte *)(param_1 + 4) & 4) == 0) {
      uVar15 = FUN_140b202c0(*(undefined8 *)(param_1 + 6),&UNK_141b24400,&UNK_141ab36c8,asStack_438)
      ;
      iVar13 = (int)uVar15;
joined_r0x000140ba0f0c:
      if (iVar13 != 0) {
        return uVar15;
      }
    }
    else {
      uVar4 = *(undefined8 *)(param_1 + 10);
      auStack_238[0] = 0;
      FUN_140ae5fa0(&UNK_141ab36c8,3,auStack_238);
      puStack_910 = auStack_238;
      psStack_8e8 = asStack_438;
      uStack_908 = 0;
      uStack_900 = 0;
      uStack_8f8 = 0;
      uStack_8f0 = 0;
      uStack_918 = uVar4;
      uVar15 = FUN_140b1a610(&uStack_918);
      if ((int)uVar15 != 0) {
        return uVar15;
      }
      piVar1 = *(int **)(param_1 + 6);
      if ((((piVar1 != (int *)0x0) && (*(longlong *)(piVar1 + 4) != 0)) &&
          ((*piVar1 == 0x41464350 || (*piVar1 == 0x57696e50)))) &&
         (pcVar3 = *(code **)(*(longlong *)(piVar1 + 4) + 0x38), pcVar3 != (code *)0x0)) {
        iVar13 = (*pcVar3)(piVar1,asStack_438,aiStack_8c8,0);
        if (iVar13 == 0) {
          if (plStack_8b8 == (longlong *)0x0) {
            return 0xffffffce;
          }
          if ((aiStack_8c8[0] != 0x41464350) && (aiStack_8c8[0] != 0x57696e50)) {
            return 0xffffffce;
          }
          if ((code *)plStack_8b8[0xf] == (code *)0x0) {
            return 0xfffffffc;
          }
          uVar15 = (*(code *)plStack_8b8[0xf])(aiStack_8c8);
          iVar13 = (int)uVar15;
          cStack_948 = cVar24;
          goto joined_r0x000140ba0f0c;
        }
        aiStack_8c8[0] = 0;
      }
    }
    piVar1 = *(int **)(param_1 + 6);
    if ((((piVar1 == (int *)0x0) || (*(longlong *)(piVar1 + 4) == 0)) ||
        ((*piVar1 != 0x41464350 && (*piVar1 != 0x57696e50)))) || (asStack_438[0] == 0)) {
      return 0xffffffce;
    }
    pcVar3 = *(code **)(*(longlong *)(piVar1 + 4) + 0x70);
    if (pcVar3 == (code *)0x0) {
      return 0xfffffffc;
    }
    puStack_958 = (ulonglong *)aiStack_8c8;
    uVar14 = (*pcVar3)(piVar1,asStack_438,param_1[8],param_1[9]);
    if (uVar14 != 0) {
      return (ulonglong)uVar14;
    }
    if ((char)uVar25 != '\0') {
      puVar22 = (ulonglong *)aiStack_8c8;
LAB_140ba0fb5:
      FUN_140aee0b0(puVar22);
    }
  }
  lVar17 = _aligned_malloc(0x100000,0x10);
  lStack_930 = lVar17;
  if (lVar17 == 0) {
    uVar14 = 0xffffff94;
  }
  else {
    if ((*(longlong *)(param_1 + 0x10) == 0) ||
       (lVar18 = _aligned_malloc(0x100000,0x10), lStack_940 = lVar18, lVar18 != 0)) {
      if (bStack_947 == 0) {
        if ((plStack_698 == (longlong *)0x0) ||
           ((aiStack_6a8[0] != 0x41464350 && (aiStack_6a8[0] != 0x57696e50)))) goto LAB_140ba1039;
        if (*plStack_698 == 0) {
          lVar17 = 0;
          uVar14 = 0xffffffce;
        }
        else {
          lVar17 = FUN_140b930a0(0x340);
          if (lVar17 != 0) {
            *(undefined4 *)(lVar17 + 0x20) = 0x66726566;
            *(undefined4 *)(lVar17 + 0x24) = 0x103;
            lVar23 = 4;
            *(undefined4 *)(lVar17 + 0x28) = 0x64617461;
            puVar22 = (ulonglong *)(lVar17 + 0x38);
            puVar12 = (ulonglong *)aiStack_6a8;
            do {
              puVar21 = puVar12;
              puVar16 = puVar22;
              uVar15 = puVar21[1];
              uVar5 = puVar21[2];
              uVar20 = puVar21[3];
              *puVar16 = *puVar21;
              puVar16[1] = uVar15;
              uVar15 = puVar21[4];
              uVar10 = puVar21[5];
              puVar16[2] = uVar5;
              puVar16[3] = uVar20;
              uVar5 = puVar21[6];
              uVar20 = puVar21[7];
              puVar16[4] = uVar15;
              puVar16[5] = uVar10;
              uVar15 = puVar21[8];
              uVar10 = puVar21[9];
              puVar16[6] = uVar5;
              puVar16[7] = uVar20;
              uVar5 = puVar21[10];
              uVar20 = puVar21[0xb];
              puVar16[8] = uVar15;
              puVar16[9] = uVar10;
              uVar15 = puVar21[0xc];
              uVar10 = puVar21[0xd];
              puVar16[10] = uVar5;
              puVar16[0xb] = uVar20;
              uVar5 = puVar21[0xe];
              uVar20 = puVar21[0xf];
              puVar16[0xc] = uVar15;
              puVar16[0xd] = uVar10;
              puVar16[0xe] = uVar5;
              puVar16[0xf] = uVar20;
              lVar23 = lVar23 + -1;
              puVar22 = puVar16 + 0x10;
              puVar12 = puVar21 + 0x10;
            } while (lVar23 != 0);
            uVar6 = *(undefined4 *)((longlong)puVar21 + 0x84);
            uVar15 = puVar21[0x11];
            uVar7 = *(undefined4 *)((longlong)puVar21 + 0x8c);
            uVar5 = puVar21[0x12];
            uVar8 = *(undefined4 *)((longlong)puVar21 + 0x94);
            uVar20 = puVar21[0x13];
            uVar9 = *(undefined4 *)((longlong)puVar21 + 0x9c);
            *(int *)(puVar16 + 0x10) = (int)puVar21[0x10];
            *(undefined4 *)((longlong)puVar16 + 0x84) = uVar6;
            *(int *)(puVar16 + 0x11) = (int)uVar15;
            *(undefined4 *)((longlong)puVar16 + 0x8c) = uVar7;
            *(int *)(puVar16 + 0x12) = (int)uVar5;
            *(undefined4 *)((longlong)puVar16 + 0x94) = uVar8;
            *(int *)(puVar16 + 0x13) = (int)uVar20;
            *(undefined4 *)((longlong)puVar16 + 0x9c) = uVar9;
            LOCK();
            UNLOCK();
            iVar13 = _DAT_1420130b8 + 1;
            *(int *)(lVar17 + 600) = _DAT_1420130b8;
            _DAT_1420130b8 = iVar13;
            plVar19 = plStack_698;
            goto LAB_140ba11fb;
          }
          uVar14 = 0xffffff94;
        }
      }
      else if ((plStack_8b8 == (longlong *)0x0) ||
              (((aiStack_8c8[0] != 0x41464350 && (aiStack_8c8[0] != 0x57696e50)) ||
               (*plStack_8b8 == 0)))) {
LAB_140ba1039:
        lVar17 = 0;
        uVar14 = 0xffffffce;
      }
      else {
        lVar17 = FUN_140b930a0(0x340);
        if (lVar17 == 0) {
          uVar14 = 0xffffff94;
        }
        else {
          *(undefined4 *)(lVar17 + 0x20) = 0x66726566;
          *(undefined4 *)(lVar17 + 0x24) = 0x103;
          lVar23 = 4;
          *(undefined4 *)(lVar17 + 0x28) = 0x64617461;
          puVar22 = (ulonglong *)(lVar17 + 0x38);
          puVar12 = (ulonglong *)aiStack_8c8;
          do {
            puVar21 = puVar12;
            puVar16 = puVar22;
            uVar15 = puVar21[1];
            uVar5 = puVar21[2];
            uVar20 = puVar21[3];
            *puVar16 = *puVar21;
            puVar16[1] = uVar15;
            uVar15 = puVar21[4];
            uVar10 = puVar21[5];
            puVar16[2] = uVar5;
            puVar16[3] = uVar20;
            uVar5 = puVar21[6];
            uVar20 = puVar21[7];
            puVar16[4] = uVar15;
            puVar16[5] = uVar10;
            uVar15 = puVar21[8];
            uVar10 = puVar21[9];
            puVar16[6] = uVar5;
            puVar16[7] = uVar20;
            uVar5 = puVar21[10];
            uVar20 = puVar21[0xb];
            puVar16[8] = uVar15;
            puVar16[9] = uVar10;
            uVar15 = puVar21[0xc];
            uVar10 = puVar21[0xd];
            puVar16[10] = uVar5;
            puVar16[0xb] = uVar20;
            uVar5 = puVar21[0xe];
            uVar20 = puVar21[0xf];
            puVar16[0xc] = uVar15;
            puVar16[0xd] = uVar10;
            puVar16[0xe] = uVar5;
            puVar16[0xf] = uVar20;
            lVar23 = lVar23 + -1;
            puVar22 = puVar16 + 0x10;
            puVar12 = puVar21 + 0x10;
          } while (lVar23 != 0);
          uVar6 = *(undefined4 *)((longlong)puVar21 + 0x84);
          uVar15 = puVar21[0x11];
          uVar7 = *(undefined4 *)((longlong)puVar21 + 0x8c);
          uVar5 = puVar21[0x12];
          uVar8 = *(undefined4 *)((longlong)puVar21 + 0x94);
          uVar20 = puVar21[0x13];
          uVar9 = *(undefined4 *)((longlong)puVar21 + 0x9c);
          *(int *)(puVar16 + 0x10) = (int)puVar21[0x10];
          *(undefined4 *)((longlong)puVar16 + 0x84) = uVar6;
          *(int *)(puVar16 + 0x11) = (int)uVar15;
          *(undefined4 *)((longlong)puVar16 + 0x8c) = uVar7;
          *(int *)(puVar16 + 0x12) = (int)uVar5;
          *(undefined4 *)((longlong)puVar16 + 0x94) = uVar8;
          *(int *)(puVar16 + 0x13) = (int)uVar20;
          *(undefined4 *)((longlong)puVar16 + 0x9c) = uVar9;
          LOCK();
          UNLOCK();
          iVar13 = _DAT_1420130b8 + 1;
          *(int *)(lVar17 + 600) = _DAT_1420130b8;
          _DAT_1420130b8 = iVar13;
          plVar19 = plStack_8b8;
LAB_140ba11fb:
          uVar14 = (*(code *)*plVar19)(lVar17);
          if (uVar14 == 0) {
            uVar14 = FUN_140ba0000(*(undefined8 *)(param_1 + 2));
            if ((uVar14 == 0) &&
               (uVar14 = FUN_140ba09a0(*(undefined8 *)(param_1 + 2),0), uVar14 == 0)) {
              uVar15 = 0;
              uVar14 = FUN_140ba0890(*(undefined8 *)(param_1 + 2),&uStack_920);
              uVar25 = uStack_944;
              if (uVar14 == 0) {
                for (; uStack_920 != 0; uStack_920 = uStack_920 - uVar5) {
                  uVar5 = *(ulonglong *)(param_1 + 0xc);
                  uVar20 = uStack_920;
                  if (uVar15 < uVar5) {
                    if (uVar5 - uVar15 < uStack_920) {
                      uVar20 = uVar5 - uVar15;
                    }
LAB_140ba1287:
                    bVar11 = false;
                  }
                  else {
                    lVar18 = *(longlong *)(param_1 + 0xe);
                    if (lVar18 == 0) {
                      bVar11 = true;
                    }
                    else {
                      if (uVar5 + lVar18 <= uVar15) goto LAB_140ba1287;
                      bVar11 = true;
                      uVar5 = (uVar5 - uVar15) + lVar18;
                      if (uVar5 < uStack_920) {
                        uVar20 = uVar5;
                      }
                    }
                  }
                  uStack_938 = 0x100000;
                  if (uVar20 < 0x100000) {
                    uStack_938 = uVar20;
                  }
                  uVar14 = FUN_140ba0350(*(undefined8 *)(param_1 + 2),&uStack_938,lStack_930);
                  uVar5 = uStack_938;
                  lVar18 = lStack_940;
                  uVar25 = uStack_944;
                  if (uVar14 != 0) goto LAB_140ba1425;
                  if ((bVar11) && (*(longlong *)(param_1 + 0x10) != 0)) {
                    puStack_958 = &uStack_938;
                    FUN_140bfc580(*(longlong *)(param_1 + 0x10),lStack_930,uStack_938 & 0xffffffff,
                                  lStack_940);
                    uVar20 = uStack_938 & 0xffffffff;
                    if (uVar20 == uVar5) {
                      uStack_928 = uVar20;
                      if (((lVar17 != 0) && (*(int *)(lVar17 + 0x20) == 0x66726566)) &&
                         (lVar18 != 0)) {
                        pcVar3 = *(code **)(lVar17 + 0x2b8);
                        goto joined_r0x000140ba1332;
                      }
                      goto LAB_140ba13ad;
                    }
LAB_140ba1416:
                    uVar14 = 0xffffffdc;
                    lVar18 = lStack_940;
                    uVar25 = uStack_944;
                    goto LAB_140ba1425;
                  }
                  if ((lVar17 == 0) || (*(int *)(lVar17 + 0x20) != 0x66726566)) {
LAB_140ba13ad:
                    uVar14 = 0xffffffce;
                  }
                  else {
                    pcVar3 = *(code **)(lVar17 + 0x2b8);
                    lVar18 = lStack_930;
joined_r0x000140ba1332:
                    if (pcVar3 == (code *)0x0) goto LAB_140ba13ad;
                    puStack_958 = &uStack_928;
                    uVar14 = (*pcVar3)(lVar17,lVar18,uVar5,1);
                  }
                  lVar18 = lStack_940;
                  uVar25 = uStack_944;
                  if (uVar14 != 0) goto LAB_140ba1425;
                  if (uStack_928 != uVar5) goto LAB_140ba1416;
                  uVar15 = uVar15 + uVar5;
                }
                uVar25 = uStack_944;
                if (aiStack_6a8[0] == 0x41464350) {
                  if (((lVar17 == 0) || (*(int *)(lVar17 + 0x20) != 0x66726566)) ||
                     (*(code **)(lVar17 + 0x270) == (code *)0x0)) {
                    uVar14 = 0xffffffce;
                  }
                  else {
                    uVar14 = (**(code **)(lVar17 + 0x270))(lVar17,uVar15);
                    uVar25 = uStack_944;
                  }
                }
              }
            }
          }
          else {
            _aligned_free(lVar17);
            lVar17 = 0;
          }
        }
      }
LAB_140ba1425:
      _aligned_free(lStack_930);
      if (lVar18 != 0) {
        _aligned_free(lVar18);
      }
      if (((lVar17 == 0) || (*(int *)(lVar17 + 0x20) != 0x66726566)) ||
         (*(code **)(lVar17 + 0x260) == (code *)0x0)) goto LAB_140ba146d;
      (**(code **)(lVar17 + 0x260))(lVar17);
      *(undefined4 *)(lVar17 + 0x20) = 0;
    }
    else {
      uVar14 = 0xffffff94;
    }
    _aligned_free(lVar17);
  }
LAB_140ba146d:
  if (bStack_947 == 0) {
    if (uVar14 == 0) {
      if (*(ulonglong **)(param_1 + 0x12) != (ulonglong *)0x0) {
        puVar22 = *(ulonglong **)(param_1 + 0x12);
        puVar12 = (ulonglong *)aiStack_6a8;
        do {
          puVar21 = puVar12;
          puVar16 = puVar22;
          uVar15 = puVar21[1];
          *puVar16 = *puVar21;
          puVar16[1] = uVar15;
          uVar15 = puVar21[3];
          puVar16[2] = puVar21[2];
          puVar16[3] = uVar15;
          uVar15 = puVar21[5];
          puVar16[4] = puVar21[4];
          puVar16[5] = uVar15;
          uVar15 = puVar21[7];
          puVar16[6] = puVar21[6];
          puVar16[7] = uVar15;
          uVar15 = puVar21[9];
          puVar16[8] = puVar21[8];
          puVar16[9] = uVar15;
          uVar15 = puVar21[0xb];
          puVar16[10] = puVar21[10];
          puVar16[0xb] = uVar15;
          uVar15 = puVar21[0xd];
          puVar16[0xc] = puVar21[0xc];
          puVar16[0xd] = uVar15;
          uVar15 = puVar21[0xf];
          puVar16[0xe] = puVar21[0xe];
          puVar16[0xf] = uVar15;
          lVar26 = lVar26 + -1;
          puVar22 = puVar16 + 0x10;
          puVar12 = puVar21 + 0x10;
        } while (lVar26 != 0);
        uVar15 = puVar21[0x11];
        puVar16[0x10] = puVar21[0x10];
        puVar16[0x11] = uVar15;
        uVar15 = puVar21[0x13];
        puVar16[0x12] = puVar21[0x12];
        puVar16[0x13] = uVar15;
        return 0;
      }
    }
    else if (((plStack_698 != (longlong *)0x0) &&
             ((aiStack_6a8[0] == 0x41464350 || (aiStack_6a8[0] == 0x57696e50)))) &&
            ((code *)plStack_698[0xf] != (code *)0x0)) {
      (*(code *)plStack_698[0xf])(aiStack_6a8);
    }
    goto LAB_140ba172f;
  }
  if (uVar14 != 0) {
    if (((plStack_8b8 != (longlong *)0x0) &&
        ((aiStack_8c8[0] == 0x41464350 || (aiStack_8c8[0] == 0x57696e50)))) &&
       ((code *)plStack_8b8[0xf] != (code *)0x0)) {
      (*(code *)plStack_8b8[0xf])(aiStack_8c8);
      return (ulonglong)uVar14;
    }
    goto LAB_140ba172f;
  }
  if (cStack_948 == '\0') {
LAB_140ba1581:
    if (((plStack_8b8 != (longlong *)0x0) &&
        (((aiStack_8c8[0] == 0x41464350 || (aiStack_8c8[0] == 0x57696e50)) &&
         (*(longlong *)(param_1 + 10) != 0)))) && ((code *)plStack_8b8[0x12] != (code *)0x0)) {
      (*(code *)plStack_8b8[0x12])(aiStack_8c8,*(longlong *)(param_1 + 10),aiStack_6a8);
    }
  }
  else if ((plStack_698 == (longlong *)0x0) ||
          ((aiStack_6a8[0] != 0x41464350 && (aiStack_6a8[0] != 0x57696e50)))) {
LAB_140ba1530:
    if ((((plStack_8b8 != (longlong *)0x0) &&
         ((aiStack_8c8[0] == 0x41464350 || (aiStack_8c8[0] == 0x57696e50)))) &&
        (iVar13 = (*(code *)plStack_8b8[1])(aiStack_8c8,&uStack_918,0), iVar13 == 0)) &&
       ((char)uStack_918 == '\0')) {
      puStack_958 = (ulonglong *)0x0;
      FUN_140b23e10(aiStack_6a8,0,0,0);
      goto LAB_140ba1581;
    }
  }
  else if (plStack_8b8 != (longlong *)0x0) {
    if ((((aiStack_8c8[0] != 0x41464350) && (aiStack_8c8[0] != 0x57696e50)) ||
        ((code *)plStack_698[0x17] == (code *)0x0)) ||
       ((aiStack_6a8[0] != aiStack_8c8[0] ||
        (iVar13 = (*(code *)plStack_698[0x17])(aiStack_6a8,aiStack_8c8), iVar13 != 0))))
    goto LAB_140ba1530;
    if ((char)uVar25 != '\0') {
      FUN_140aee0b0(aiStack_6a8);
    }
    puStack_958 = (ulonglong *)0x0;
    FUN_140b23e10(aiStack_8c8,0,0,0);
  }
  if (*(ulonglong **)(param_1 + 0x12) != (ulonglong *)0x0) {
    puVar22 = *(ulonglong **)(param_1 + 0x12);
    puVar12 = (ulonglong *)aiStack_6a8;
    do {
      puVar21 = puVar12;
      puVar16 = puVar22;
      uVar15 = puVar21[1];
      *puVar16 = *puVar21;
      puVar16[1] = uVar15;
      uVar15 = puVar21[3];
      puVar16[2] = puVar21[2];
      puVar16[3] = uVar15;
      uVar15 = puVar21[5];
      puVar16[4] = puVar21[4];
      puVar16[5] = uVar15;
      uVar15 = puVar21[7];
      puVar16[6] = puVar21[6];
      puVar16[7] = uVar15;
      uVar15 = puVar21[9];
      puVar16[8] = puVar21[8];
      puVar16[9] = uVar15;
      uVar15 = puVar21[0xb];
      puVar16[10] = puVar21[10];
      puVar16[0xb] = uVar15;
      uVar15 = puVar21[0xd];
      puVar16[0xc] = puVar21[0xc];
      puVar16[0xd] = uVar15;
      uVar15 = puVar21[0xf];
      puVar16[0xe] = puVar21[0xe];
      puVar16[0xf] = uVar15;
      lVar26 = lVar26 + -1;
      puVar22 = puVar16 + 0x10;
      puVar12 = puVar21 + 0x10;
    } while (lVar26 != 0);
    uVar15 = puVar21[0x11];
    puVar16[0x10] = puVar21[0x10];
    puVar16[0x11] = uVar15;
    uVar15 = puVar21[0x13];
    puVar16[0x12] = puVar21[0x12];
    puVar16[0x13] = uVar15;
    return 0;
  }
LAB_140ba172f:
  return (ulonglong)uVar14;
}

