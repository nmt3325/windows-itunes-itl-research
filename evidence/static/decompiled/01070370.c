/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x1070370; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

ulonglong FUN_141070370(longlong param_1,longlong param_2,uint param_3,undefined4 *param_4)

{
  char cVar1;
  uint uVar2;
  longlong lVar3;
  longlong *plVar4;
  ulonglong uVar5;
  undefined1 auStack_148 [32];
  longlong lStack_128;
  longlong lStack_120;
  undefined8 uStack_118;
  int aiStack_110 [2];
  uint uStack_108;
  uint uStack_104;
  undefined8 uStack_100;
  undefined8 uStack_f8;
  undefined8 uStack_f0;
  undefined8 uStack_e8;
  undefined8 uStack_e0;
  undefined8 uStack_d8;
  undefined8 uStack_d0;
  undefined8 uStack_c8;
  undefined8 uStack_c0;
  undefined8 uStack_b8;
  undefined4 uStack_b0;
  undefined8 uStack_a8;
  undefined8 uStack_a0;
  undefined8 uStack_98;
  undefined8 uStack_90;
  undefined8 uStack_88;
  undefined8 uStack_80;
  undefined8 uStack_78;
  undefined8 uStack_70;
  undefined8 uStack_68;
  undefined8 uStack_60;
  undefined8 uStack_58;
  undefined8 uStack_50;
  ulonglong uStack_48;
  
  uStack_48 = _DAT_141fd5040 ^ (ulonglong)auStack_148;
  uVar2 = param_3;
  func_0x000140ed2bb0(param_2);
  lVar3 = *(longlong *)(param_1 + 0x120);
  uStack_98 = 0;
  uStack_90 = 0;
  uStack_a8 = 0x606864736d;
  uStack_88 = 0;
  uStack_80 = 0;
  uStack_a0 = (ulonglong)uVar2 << 0x20;
  uStack_78 = 0;
  uStack_70 = 0;
  lStack_128 = 0;
  uStack_68 = 0;
  uStack_60 = 0;
  uStack_58 = 0;
  uStack_50 = 0;
  if (*(char *)(lVar3 + 5) == '\0') {
    uVar2 = FUN_140bd6640(*(undefined8 *)(lVar3 + 8),&lStack_128);
    uVar5 = (ulonglong)uVar2;
    if (uVar2 != 0) goto LAB_141070743;
  }
  else {
    lStack_128 = *(longlong *)(lVar3 + 0x40);
  }
  if (*(char *)(lVar3 + 5) == '\0') {
    lVar3 = *(longlong *)(lVar3 + 0x20) - *(longlong *)(lVar3 + 0x30);
  }
  else {
    lVar3 = (*(longlong *)(lVar3 + 0x20) - *(longlong *)(lVar3 + 0x38)) + -1;
  }
  lStack_128 = lStack_128 + lVar3;
  uStack_118 = 0x60;
  uVar2 = FUN_140ba04c0(*(undefined8 *)(param_1 + 0x120),&uStack_118,&uStack_a8);
  uVar5 = (ulonglong)uVar2;
  if (uVar2 == 0) {
    lVar3 = *(longlong *)(param_1 + 0x120);
    uStack_108 = 0x68746c6d;
    uStack_100 = 0;
    uStack_f8 = 0;
    uStack_b0 = 0;
    uStack_f0 = 0;
    uStack_e8 = 0;
    uStack_104 = 0x5c;
    uStack_e0 = 0;
    uStack_d8 = 0;
    lStack_120 = 0;
    uStack_d0 = 0;
    uStack_c8 = 0;
    uStack_c0 = 0;
    uStack_b8 = 0;
    if (*(char *)(lVar3 + 5) == '\0') {
      uVar2 = FUN_140bd6640(*(undefined8 *)(lVar3 + 8),&lStack_120,0);
      uVar5 = (ulonglong)uVar2;
      if (uVar2 != 0) goto LAB_141070743;
    }
    else {
      lStack_120 = *(longlong *)(lVar3 + 0x40);
    }
    if (*(char *)(lVar3 + 5) == '\0') {
      lVar3 = *(longlong *)(lVar3 + 0x20) - *(longlong *)(lVar3 + 0x30);
    }
    else {
      lVar3 = (*(longlong *)(lVar3 + 0x20) - *(longlong *)(lVar3 + 0x38)) + -1;
    }
    lStack_120 = lVar3 + lStack_120;
    uStack_118 = 0x5c;
    uVar2 = FUN_140ba04c0(*(undefined8 *)(param_1 + 0x120),&uStack_118,&uStack_108);
    uVar5 = (ulonglong)uVar2;
    if (uVar2 == 0) {
      if (((param_2 != 0) && (*(int *)(param_2 + 0x80) == 0x74646174)) &&
         (*(longlong *)(param_2 + 200) != 0)) {
        plVar4 = *(longlong **)(*(longlong *)(param_2 + 200) + 0x58);
joined_r0x00014107053a:
        if (plVar4 != (longlong *)0x0) {
          while( true ) {
            cVar1 = FUN_14106b450(plVar4,param_3);
            if (cVar1 != '\0') {
              uVar2 = FUN_14106daf0(param_1,plVar4);
              uVar5 = (ulonglong)uVar2;
              if (uVar2 != 0) goto LAB_141070743;
              uStack_100 = CONCAT44(uStack_100._4_4_,(uint)uStack_100 + 1);
            }
            lVar3 = plVar4[1];
            if ((lVar3 == 0) || (*(longlong *)(lVar3 + 0x10) == 0)) goto LAB_1410705b0;
            plVar4 = (longlong *)*plVar4;
            if (plVar4 != (longlong *)0x0) break;
            lVar3 = *(longlong *)(lVar3 + 0x18);
            while( true ) {
              if (lVar3 == 0) goto joined_r0x00014107053a;
              plVar4 = *(longlong **)(lVar3 + 0x58);
              if (plVar4 != (longlong *)0x0) break;
              if (*(longlong *)(lVar3 + 0x10) == 0) goto joined_r0x00014107053a;
              lVar3 = *(longlong *)(lVar3 + 0x18);
            }
          }
          goto joined_r0x00014107053a;
        }
      }
LAB_1410705b0:
      *param_4 = (uint)uStack_100;
      uVar2 = FUN_140b9ff80(*(undefined8 *)(param_1 + 0x120),aiStack_110);
      uVar5 = (ulonglong)uVar2;
      if (uVar2 == 0) {
        uVar2 = aiStack_110[0] - (int)lStack_128;
        uStack_a0 = CONCAT44(uStack_a0._4_4_,uVar2);
        if (*(char *)(param_1 + 0x52) == '\0') {
          uStack_a8 = CONCAT44((uStack_a8._4_4_ & 0xff0000 | uStack_a8._4_4_ >> 0x10) >> 8 |
                               (uStack_a8._4_4_ & 0xff00 | uStack_a8._4_4_ << 0x10) << 8,
                               ((uint)uStack_a8 & 0xff0000 | (uint)uStack_a8 >> 0x10) >> 8 |
                               ((uint)uStack_a8 & 0xff00 | (uint)uStack_a8 << 0x10) << 8);
          uStack_a0 = CONCAT44((uStack_a0._4_4_ & 0xff0000 | uStack_a0._4_4_ >> 0x10) >> 8 |
                               (uStack_a0._4_4_ & 0xff00 | uStack_a0._4_4_ << 0x10) << 8,
                               uVar2 >> 0x18 | (uVar2 & 0xff0000) >> 8 | (uVar2 & 0xff00) << 8 |
                               uVar2 * 0x1000000);
        }
        uVar2 = FUN_14106aba0(param_1,lStack_128,&uStack_a8,0x60);
        uVar5 = (ulonglong)uVar2;
        if (uVar2 == 0) {
          if (*(char *)(param_1 + 0x52) == '\0') {
            uStack_108 = (uStack_108 & 0xff0000 | uStack_108 >> 0x10) >> 8 |
                         (uStack_108 << 0x10 | uStack_108 & 0xff00) << 8;
            uStack_104 = (uStack_104 & 0xff0000 | uStack_104 >> 0x10) >> 8 |
                         (uStack_104 << 0x10 | uStack_104 & 0xff00) << 8;
            uStack_100 = CONCAT44(uStack_100._4_4_,
                                  ((uint)uStack_100 & 0xff0000 | (uint)uStack_100 >> 0x10) >> 8 |
                                  ((uint)uStack_100 << 0x10 | (uint)uStack_100 & 0xff00) << 8);
          }
          uVar2 = FUN_14106aba0(param_1,lStack_120,&uStack_108,0x5c);
          uVar5 = (ulonglong)uVar2;
        }
      }
    }
  }
LAB_141070743:
  func_0x000140ed2fe0(param_2);
  return uVar5 & 0xffffffff;
}

