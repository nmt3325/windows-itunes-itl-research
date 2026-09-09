/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x106daf0; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Function: __security_check_cookie replaced with injection: security_check_cookie */
/* WARNING: Type propagation algorithm not settling */
/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

ulonglong FUN_14106daf0(longlong param_1,longlong param_2)

{
  undefined4 *puVar1;
  int *piVar2;
  short sVar3;
  undefined8 *puVar4;
  byte bVar5;
  undefined1 uVar6;
  char cVar7;
  undefined2 uVar8;
  uint uVar9;
  int iVar10;
  undefined8 uVar11;
  int *piVar12;
  ulonglong uVar13;
  longlong lVar14;
  undefined4 uVar15;
  uint uVar16;
  longlong lVar17;
  byte *pbVar18;
  ulonglong uVar19;
  ulonglong uVar20;
  int iVar21;
  ulonglong uVar22;
  longlong unaff_GS_OFFSET;
  bool bVar23;
  undefined1 auStack_338 [32];
  undefined8 uStack_318;
  longlong *plStack_310;
  longlong *plStack_308;
  char acStack_2f8 [8];
  longlong lStack_2f0;
  longlong lStack_2e8;
  ulonglong uStack_2e0;
  undefined1 auStack_2d8 [12];
  int iStack_2cc;
  int *piStack_298;
  undefined8 uStack_288;
  undefined8 uStack_280;
  undefined8 uStack_278;
  undefined8 uStack_270;
  undefined8 uStack_268;
  undefined8 uStack_260;
  ushort uStack_248;
  undefined1 auStack_246 [510];
  ulonglong uStack_48;
  
  uStack_48 = _DAT_141fd5040 ^ (ulonglong)auStack_338;
  if (((param_2 == 0) || (puVar4 = *(undefined8 **)(param_2 + 8), puVar4 == (undefined8 *)0x0)) ||
     (puVar4[2] == 0)) {
    return 0xffffffce;
  }
  lStack_2f0 = param_1 + 0xa0041c;
  puVar1 = (undefined4 *)(param_1 + 0xa00128);
  lVar14 = *(longlong *)(param_1 + 0x1e00270);
  if (puVar1 != (undefined4 *)0x0) {
    func_0x00014179cca0(param_1 + 0xa00130,0,0x2ec);
  }
  *puVar1 = 0x6874696d;
  uVar19 = 0;
  *(undefined4 *)(param_1 + 0xa0012c) = 0x2f4;
  *(undefined4 *)(param_1 + 0xa00138) = *(undefined4 *)(puVar4 + 1);
  *(undefined4 *)(param_1 + 0xa0031c) = *(undefined4 *)(param_2 + 0x28);
  *(undefined4 *)(param_1 + 0xa00148) = *(undefined4 *)(param_2 + 0x54);
  *(undefined4 *)(param_1 + 0xa001a0) = *(undefined4 *)(param_2 + 0x58);
  *(undefined8 *)(param_1 + 0xa0026c) = *(undefined8 *)(param_2 + 0x60);
  *(undefined4 *)(param_1 + 0xa00150) = *(undefined4 *)(param_2 + 0x5c);
  *(uint *)(param_1 + 0xa00154) = (uint)*(ushort *)((longlong)puVar4 + 0x10a);
  *(uint *)(param_1 + 0xa00158) = (uint)*(ushort *)((longlong)puVar4 + 0x10c);
  *(undefined2 *)(param_1 + 0xa00190) = *(undefined2 *)((longlong)puVar4 + 0x10e);
  *(undefined2 *)(param_1 + 0xa00192) = *(undefined2 *)(puVar4 + 0x22);
  *(byte *)(param_1 + 0xa00195) = *(byte *)((longlong)puVar4 + 0x9a) >> 4 & 1;
  *(int *)(param_1 + 0xa0015c) = (int)*(short *)((longlong)puVar4 + 0xa6);
  *(byte *)(param_1 + 0xa0017b) = *(byte *)((longlong)puVar4 + 0x9b) >> 2 & 1;
  *(uint *)(param_1 + 0xa00160) = (uint)*(ushort *)(param_2 + 0x4c);
  *(undefined4 *)(param_1 + 0xa001c0) = *(undefined4 *)(param_2 + 0x48);
  *(undefined2 *)(param_1 + 0xa00332) = *(undefined2 *)(param_2 + 0x4e);
  *(int *)(param_1 + 0xa00168) = (int)*(short *)((longlong)puVar4 + 0x102);
  *(undefined4 *)(param_1 + 0xa0016c) = *(undefined4 *)(puVar4[0xf] + 4);
  *(undefined4 *)(param_1 + 0xa00170) = *(undefined4 *)(puVar4[0xf] + 8);
  *(undefined4 *)(param_1 + 0xa00174) = *(undefined4 *)((longlong)puVar4 + 0x114);
  *(undefined4 *)(param_1 + 0xa00188) = *(undefined4 *)(puVar4 + 0x23);
  *(undefined4 *)(param_1 + 0xa0018c) = *(undefined4 *)((longlong)puVar4 + 0x11c);
  *(undefined4 *)(param_1 + 0xa00200) = *(undefined4 *)(puVar4 + 0x24);
  *(undefined4 *)(param_1 + 0xa00240) = *(undefined4 *)((longlong)puVar4 + 0x124);
  *(undefined4 *)(param_1 + 0xa00244) = *(undefined4 *)(puVar4 + 0x25);
  *(undefined8 *)(param_1 + 0xa002c4) = *(undefined8 *)(*(longlong *)(param_2 + 0x10) + 0x20);
  *(undefined8 *)(param_1 + 0xa002bc) = *(undefined8 *)(*(longlong *)(param_2 + 0x10) + 8);
  *(undefined8 *)(param_1 + 0xa002cc) = *(undefined8 *)(*(longlong *)(param_2 + 0x10) + 0x10);
  *(undefined8 *)(param_1 + 0xa00334) = *(undefined8 *)(*(longlong *)(param_2 + 0x10) + 0x18);
  uVar13 = uVar19;
  if ((*(longlong *)(param_2 + 8) != 0) && (*(longlong *)(*(longlong *)(param_2 + 8) + 0x10) != 0))
  {
    uVar13 = *(ulonglong *)(*(longlong *)(param_2 + 0x10) + 0x38);
  }
  *(ulonglong *)(param_1 + 0xa002d4) = uVar13;
  *(undefined8 *)(param_1 + 0xa002e4) = *(undefined8 *)(*(longlong *)(param_2 + 0x10) + 0x48);
  *(undefined8 *)(param_1 + 0xa002f4) = *(undefined8 *)(*(longlong *)(param_2 + 0x10) + 0x58);
  *(undefined8 *)(param_1 + 0xa002dc) = *(undefined8 *)(*(longlong *)(param_2 + 0x10) + 0x40);
  *(undefined8 *)(param_1 + 0xa002ec) = *(undefined8 *)(*(longlong *)(param_2 + 0x10) + 0x50);
  *(undefined8 *)(param_1 + 0xa002fc) = *(undefined8 *)(*(longlong *)(param_2 + 0x10) + 0x60);
  *(undefined4 *)(param_1 + 0xa00288) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x20);
  *(undefined4 *)(param_1 + 0xa00198) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 8);
  *(undefined4 *)(param_1 + 0xa001b0) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x10);
  uVar15 = 0;
  if ((*(longlong *)(param_2 + 8) != 0) && (*(longlong *)(*(longlong *)(param_2 + 8) + 0x10) != 0))
  {
    uVar15 = (undefined4)*(undefined8 *)(*(longlong *)(param_2 + 0x10) + 0x38);
  }
  *(undefined4 *)(param_1 + 0xa001d0) = uVar15;
  *(undefined4 *)(param_1 + 0xa001d8) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x48);
  *(undefined4 *)(param_1 + 0xa001e0) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x58);
  *(undefined4 *)(param_1 + 0xa001d4) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x40);
  *(undefined4 *)(param_1 + 0xa001dc) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x50);
  *(undefined4 *)(param_1 + 0xa0020c) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x60);
  *(undefined4 *)(param_1 + 0xa001c4) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x88);
  *(undefined1 *)(param_1 + 0xa0017a) = *(undefined1 *)(puVar4[0xd] + 1);
  *(undefined4 *)(param_1 + 0xa001e4) = *(undefined4 *)(puVar4[0xd] + 4);
  *(undefined4 *)(param_1 + 0xa0019c) = *(undefined4 *)((longlong)puVar4 + 0xfc);
  *(uint *)(param_1 + 0xa00180) = (uint)*(ushort *)(param_2 + 0x52);
  *(undefined4 *)(param_1 + 0xa00218) = *(undefined4 *)(param_2 + 0x2f4);
  *(undefined4 *)(param_1 + 0xa00228) = *(undefined4 *)(param_2 + 0x2f8);
  *(undefined8 *)(param_1 + 0xa0021c) = *(undefined8 *)(param_2 + 0x2e0);
  *(undefined8 *)(param_1 + 0xa00248) = *(undefined8 *)(param_2 + 0x2e8);
  *(undefined4 *)(param_1 + 0xa0022c) = *(undefined4 *)(param_2 + 0x2f0);
  if ((puVar4[2] == 0) || ((*(byte *)(puVar4[2] + 0x114) & 8) == 0)) {
    if ((*(byte *)((longlong)puVar4 + 0x105) == 0) && (*(char *)((longlong)puVar4 + 0x104) == '\0'))
    goto LAB_14106e241;
LAB_14106de6b:
    uVar6 = *(undefined1 *)((longlong)puVar4 + 0x104);
  }
  else {
    if (*(byte *)((longlong)puVar4 + 0x105) < 0x20) goto LAB_14106de6b;
LAB_14106e241:
    uVar6 = 0;
  }
  *(undefined1 *)(param_1 + 0xa00194) = uVar6;
  *(undefined4 *)(param_1 + 0xa001a4) = *(undefined4 *)(puVar4[0xf] + 0xc);
  *(undefined4 *)(param_1 + 0xa00398) = *(undefined4 *)(puVar4[0xf] + 0x14);
  *(undefined8 *)(param_1 + 0xa001a8) = *puVar4;
  *(undefined4 *)(param_1 + 0xa001b4) = *(undefined4 *)(param_2 + 0x38);
  *(byte *)(param_1 + 0xa00196) = *(byte *)((longlong)puVar4 + 0x9a) >> 2 & 1;
  *(undefined2 *)(param_1 + 0xa001b8) = *(undefined2 *)(param_2 + 0x6c);
  *(undefined2 *)(param_1 + 0xa001ba) = *(undefined2 *)(param_2 + 0x6e);
  *(undefined4 *)(param_1 + 0xa001bc) = *(undefined4 *)(param_2 + 0x70);
  *(byte *)(param_1 + 0xa001cf) = *(byte *)((longlong)puVar4 + 0x9b) >> 3 & 1;
  *(byte *)(param_1 + 0xa00359) = *(byte *)((longlong)puVar4 + 0x9b) >> 4 & 1;
  *(undefined1 *)(param_1 + 0xa00197) = *(undefined1 *)(param_2 + 0x44);
  *(undefined1 *)(param_1 + 0xa00250) = *(undefined1 *)(param_2 + 0x3f);
  *(undefined4 *)(param_1 + 0xa001c8) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x8c);
  *(undefined2 *)(param_1 + 0xa001cc) = *(undefined2 *)((longlong)puVar4 + 300);
  *(undefined1 *)(param_1 + 0xa001ce) = *(undefined1 *)(puVar4 + 0x12);
  *(byte *)(param_1 + 0xa001f0) = *(byte *)((longlong)puVar4 + 0x9c) >> 4 & 1;
  *(undefined8 *)(param_1 + 0xa001f4) = *(undefined8 *)(param_2 + 0x2d8);
  *(undefined4 *)(param_1 + 0xa001fc) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x84);
  *(byte *)(param_1 + 0xa001f1) = *(byte *)(param_2 + 0x41) & 1;
  *(undefined4 *)(param_1 + 0xa00314) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 4);
  *(byte *)(param_1 + 0xa00305) = *(byte *)(param_2 + 0x41) >> 3 & 1;
  *(byte *)(param_1 + 0xa001f2) = *(byte *)((longlong)puVar4 + 0x9d) >> 3 & 1;
  *(byte *)(param_1 + 0xa001f3) = *(byte *)((longlong)puVar4 + 0x9b) >> 6 & 1;
  *(byte *)(param_1 + 0xa00210) = *(byte *)((longlong)puVar4 + 0x9b) >> 7;
  *(byte *)(param_1 + 0xa00212) = *(byte *)((longlong)puVar4 + 0x9d) & 1;
  *(byte *)(param_1 + 0xa00215) = *(byte *)((longlong)puVar4 + 0x9d) >> 1 & 1;
  *(undefined4 *)(param_1 + 0xa00224) = *(undefined4 *)(param_2 + 0x74);
  *(undefined4 *)(param_1 + 0xa003b8) = *(undefined4 *)(puVar4 + 0x1c);
  *(undefined4 *)(param_1 + 0xa003bc) = *(undefined4 *)((longlong)puVar4 + 0xe4);
  *(undefined4 *)(param_1 + 0xa003c0) = *(undefined4 *)(puVar4 + 0x1d);
  *(undefined4 *)(param_1 + 0xa003c4) = *(undefined4 *)((longlong)puVar4 + 0xec);
  *(undefined4 *)(param_1 + 0xa003c8) = *(undefined4 *)(puVar4 + 0x1e);
  *(undefined4 *)(param_1 + 0xa003cc) = *(undefined4 *)((longlong)puVar4 + 0xf4);
  *(undefined4 *)(param_1 + 0xa003d0) = *(undefined4 *)(puVar4 + 0x1f);
  *(undefined4 *)(param_1 + 0xa001e8) = *(undefined4 *)(param_2 + 0x68);
  *(uint *)(param_1 + 0xa001ec) = (uint)*(ushort *)(puVar4 + 0x20);
  *(byte *)(param_1 + 0xa00213) = *(byte *)((longlong)puVar4 + 0x9d) >> 6 & 1;
  *(byte *)(param_1 + 0xa0033c) = *(byte *)((longlong)puVar4 + 0x9d) >> 5 & 1;
  *(byte *)(param_1 + 0xa0033d) = *(byte *)((longlong)puVar4 + 0x9a) >> 7;
  *(byte *)(param_1 + 0xa00214) = *(byte *)((longlong)puVar4 + 0x9d) >> 7;
  *(byte *)(param_1 + 0xa003a5) = *(byte *)((longlong)puVar4 + 0x9e) & 1;
  *(byte *)(param_1 + 0xa003a6) = *(byte *)((longlong)puVar4 + 0x9f) >> 4 & 1;
  *(byte *)(param_1 + 0xa003a7) = *(byte *)((longlong)puVar4 + 0x9f) >> 5 & 1;
  *(byte *)(param_1 + 0xa00217) = *(byte *)((longlong)puVar4 + 0x9e) >> 1 & 1;
  *(byte *)(param_1 + 0xa00216) = *(byte *)((longlong)puVar4 + 0x9e) >> 2 & 1;
  *(undefined4 *)(param_1 + 0xa00238) = *(undefined4 *)(puVar4[0xe] + 8);
  *(undefined4 *)(param_1 + 0xa00234) = *(undefined4 *)(puVar4[0xe] + 4);
  *(undefined4 *)(param_1 + 0xa0039c) = *(undefined4 *)((longlong)puVar4 + 0xac);
  *(undefined4 *)(param_1 + 0xa00320) = *(undefined4 *)(puVar4[0xd] + 0x10);
  *(byte *)(param_1 + 0xa0023c) = *(byte *)((longlong)puVar4 + 0x9e) >> 3 & 1;
  *(byte *)(param_1 + 0xa0023e) = *(byte *)((longlong)puVar4 + 0x9c) & 1;
  *(byte *)(param_1 + 0xa0023f) = *(byte *)(param_2 + 0x40) >> 3 & 1;
  uVar11 = FUN_140fa2c40(puVar4);
  *(undefined8 *)(param_1 + 0xa00254) = uVar11;
  uVar11 = FUN_140fa2cd0(puVar4);
  *(undefined8 *)(param_1 + 0xa0038c) = uVar11;
  bVar5 = FUN_140fa2aa0(puVar4);
  *(byte *)(param_1 + 0xa00251) = bVar5;
  if (0xb < bVar5) {
    *(undefined1 *)(param_1 + 0xa00251) = 0;
  }
  *(undefined1 *)(param_1 + 0xa00358) = *(undefined1 *)(param_2 + 0x3e);
  *(byte *)(param_1 + 0xa00141) = *(byte *)(param_2 + 0x41) >> 4 & 1;
  *(byte *)(param_1 + 0xa0033e) = *(byte *)(param_2 + 0x41) >> 5 & 1;
  *(byte *)(param_1 + 0xa00140) = *(byte *)(param_2 + 0x41) >> 6 & 1;
  *(byte *)(param_1 + 0xa00211) = *(byte *)((longlong)puVar4 + 0x9c) >> 1 & 1;
  *(undefined8 *)(param_1 + 0xa0025c) = puVar4[0x28];
  *(undefined8 *)(param_1 + 0xa00264) = puVar4[0x29];
  *(byte *)(param_1 + 0xa00396) = *(byte *)(param_2 + 0x42) >> 5 & 1;
  *(byte *)(param_1 + 0xa00397) = *(byte *)((longlong)puVar4 + 0x9f) >> 2 & 1;
  uVar13 = uVar19;
  if (puVar4[2] != 0) {
    lVar17 = puVar4[0xe];
    if (lVar17 == 0) {
      uVar13 = 0;
    }
    else {
      uVar9 = *(int *)(lVar17 + 0x10) + *(int *)(lVar17 + 0xc);
      uVar13 = (ulonglong)uVar9;
      if ((*(int *)(lVar17 + 0x14) != 0) &&
         (uVar16 = *(int *)(lVar17 + 0x14) + *(int *)(lVar17 + 0x18), uVar16 < uVar9)) {
        uVar13 = (ulonglong)uVar16;
      }
    }
  }
  *(int *)(param_1 + 0xa00294) = (int)uVar13;
  *(undefined4 *)(param_1 + 0xa002b4) = *(undefined4 *)(puVar4[0xe] + 0xc);
  *(undefined4 *)(param_1 + 0xa002b8) = *(undefined4 *)(puVar4[0xe] + 0x10);
  *(undefined4 *)(param_1 + 0xa002ac) = *(undefined4 *)(puVar4[0xe] + 0x14);
  *(undefined4 *)(param_1 + 0xa002b0) = *(undefined4 *)(puVar4[0xe] + 0x18);
  *(byte *)(param_1 + 0xa00299) = **(byte **)(param_2 + 0x18) >> 1 & 1;
  *(byte *)(param_1 + 0xa0029a) = **(byte **)(param_2 + 0x18) >> 2 & 1;
  *(byte *)(param_1 + 0xa00253) = **(byte **)(param_2 + 0x18) >> 4 & 1;
  *(undefined2 *)(param_1 + 0xa0029c) = *(undefined2 *)(*(longlong *)(param_2 + 0x18) + 2);
  *(undefined2 *)(param_1 + 0xa0029e) = *(undefined2 *)(*(longlong *)(param_2 + 0x18) + 0xc);
  *(undefined4 *)(param_1 + 0xa002a0) = *(undefined4 *)(*(longlong *)(param_2 + 0x18) + 4);
  *(undefined2 *)(param_1 + 0xa002a4) = *(undefined2 *)(*(longlong *)(param_2 + 0x18) + 0xe);
  *(undefined2 *)(param_1 + 0xa002a6) = *(undefined2 *)(*(longlong *)(param_2 + 0x18) + 0x10);
  *(undefined4 *)(param_1 + 0xa002a8) = *(undefined4 *)(*(longlong *)(param_2 + 0x18) + 8);
  *(undefined4 *)(param_1 + 0xa00354) = *(undefined4 *)(param_2 + 0x2c);
  uVar8 = func_0x00014106a560(*(undefined2 *)(param_2 + 0x50));
  *(undefined2 *)(param_1 + 0xa00178) = uVar8;
  *(undefined8 *)(param_1 + 0xa0035c) = *(undefined8 *)(*(longlong *)(param_2 + 0x20) + 8);
  *(undefined8 *)(param_1 + 0xa003b0) = *(undefined8 *)(*(longlong *)(param_2 + 0x20) + 0x10);
  *(undefined8 *)(param_1 + 0xa00364) = *(undefined8 *)(*(longlong *)(param_2 + 0x20) + 0x18);
  *(undefined1 *)(param_1 + 0xa003a4) = *(undefined1 *)(*(longlong *)(param_2 + 0x20) + 4);
  *(undefined1 *)(param_1 + 0xa00383) = *(undefined1 *)((longlong)puVar4 + 0x8a);
  *(byte *)(param_1 + 0xa00380) = *(byte *)(puVar4 + 0x11) >> 3 & 1;
  *(undefined4 *)(param_1 + 0xa003a0) = *(undefined4 *)((longlong)puVar4 + 0x8c);
  cVar7 = *(char *)((longlong)puVar4 + 0x89);
  *(char *)(param_1 + 0xa0040a) = cVar7;
  if ((cVar7 == '\x01') && (cVar7 = FUN_140f93610(puVar4), cVar7 == '\0')) {
    *(undefined1 *)(param_1 + 0xa0040a) = 0;
  }
  uVar13 = *(ulonglong *)(*(longlong *)(param_2 + 0x20) + 8);
  if (((uVar13 == 0xfffffffffffffffd) || (0xfffffffffffffffd < uVar13)) || (uVar13 == 0)) {
    *(undefined2 *)(param_1 + 0xa00384) = 0;
    bVar5 = 0;
  }
  else {
    *(byte *)(param_1 + 0xa00384) = *(byte *)(puVar4 + 0x11) & 1;
    *(byte *)(param_1 + 0xa00385) = *(byte *)(puVar4 + 0x11) >> 1 & 1;
    bVar5 = *(byte *)(puVar4 + 0x11) >> 2 & 1;
  }
  *(byte *)(param_1 + 0xa00386) = bVar5;
  *(byte *)(param_1 + 0xa00388) = **(byte **)(param_2 + 0x20) >> 1 & 1;
  *(byte *)(param_1 + 0xa00389) = **(byte **)(param_2 + 0x20) >> 2 & 1;
  *(byte *)(param_1 + 0xa0038a) = **(byte **)(param_2 + 0x20) >> 3 & 1;
  *(byte *)(param_1 + 0xa00381) = **(byte **)(param_2 + 0x10) >> 1 & 1;
  *(byte *)(param_1 + 0xa00382) = **(byte **)(param_2 + 0x10) >> 2 & 1;
  *(byte *)(param_1 + 0xa00394) = **(byte **)(param_2 + 0x10) >> 5 & 1;
  *(undefined8 *)(param_1 + 0xa0030c) = puVar4[0x2a];
  *(undefined4 *)(param_1 + 0xa00318) = *(undefined4 *)(puVar4 + 0x2b);
  *(undefined4 *)(param_1 + 0xa00348) = *(undefined4 *)((longlong)puVar4 + 0x15c);
  *(undefined8 *)(param_1 + 0xa00324) = puVar4[0x27];
  *(undefined8 *)(param_1 + 0xa003d4) = *(undefined8 *)(*(longlong *)(param_2 + 0x10) + 0x28);
  *(undefined8 *)(param_1 + 0xa003dc) = *(undefined8 *)(*(longlong *)(param_2 + 0x10) + 0x30);
  *(undefined2 *)(param_1 + 0xa003f8) = *(undefined2 *)(puVar4[0xd] + 0x14);
  *(undefined2 *)(param_1 + 0xa003fa) = *(undefined2 *)(puVar4[0xd] + 0x16);
  *(byte *)(param_1 + 0xa003fc) = *(byte *)puVar4[0xd] >> 3 & 1;
  *(byte *)(param_1 + 0xa003e4) = *(byte *)(param_2 + 0x42) >> 6 & 1;
  *(byte *)(param_1 + 0xa003fd) = *(byte *)(param_2 + 0x42) >> 7;
  *(byte *)(param_1 + 0xa003e6) = *(byte *)((longlong)puVar4 + 0x9f) >> 6 & 1;
  *(byte *)(param_1 + 0xa003f4) = *(byte *)(puVar4 + 0x14) & 1;
  *(byte *)(param_1 + 0xa003f5) = *(byte *)(puVar4 + 0x14) >> 1 & 1;
  *(undefined1 *)(param_1 + 0xa003e7) = *(undefined1 *)((longlong)puVar4 + 0x107);
  *(byte *)(param_1 + 0xa003f6) = *(byte *)(puVar4 + 0x14) >> 2 & 1;
  *(undefined8 *)(param_1 + 0xa003ec) = *(undefined8 *)(*(longlong *)(param_2 + 0x20) + 0x20);
  *(byte *)(param_1 + 0xa003e5) = **(byte **)(param_2 + 0x20) >> 4 & 1;
  *(undefined1 *)(param_1 + 0xa003e8) = *(undefined1 *)(*(longlong *)(param_2 + 0x20) + 0x28);
  *(undefined1 *)(param_1 + 0xa003e9) = *(undefined1 *)(*(longlong *)(param_2 + 0x20) + 0x29);
  *(undefined1 *)(param_1 + 0xa003ea) = *(undefined1 *)(*(longlong *)(param_2 + 0x20) + 0x2a);
  *(undefined1 *)(param_1 + 0xa003eb) = *(undefined1 *)(*(longlong *)(param_2 + 0x20) + 0x2b);
  if ((*(byte *)((longlong)puVar4 + 0x9b) & 8) == 0) {
    uVar13 = FUN_140fa0b70(puVar4,0);
    if ((uVar13 & 0x10090) == 0) {
      if ((*(byte *)((longlong)puVar4 + 0x9d) & 8) == 0) {
        cVar7 = FUN_140f938a0(puVar4);
        bVar23 = cVar7 != '\0';
      }
      else {
        bVar23 = true;
      }
    }
    else {
      bVar23 = true;
    }
  }
  else {
    bVar23 = true;
  }
  *(bool *)(param_1 + 0xa003f7) = bVar23;
  *(undefined1 *)(param_1 + 0xa003fe) = *(undefined1 *)(puVar4[0xe] + 0x20);
  *(undefined1 *)(param_1 + 0xa003ff) = *(undefined1 *)(puVar4[0xe] + 0x21);
  *(undefined1 *)(param_1 + 0xa00400) = *(undefined1 *)(puVar4[0xe] + 0x22);
  *(byte *)(param_1 + 0xa00401) = *(byte *)(puVar4 + 0x14) >> 3 & 1;
  *(byte *)(param_1 + 0xa00402) = *(byte *)(param_2 + 0x40) >> 1 & 1;
  *(byte *)(param_1 + 0xa00403) = **(byte **)(param_2 + 0x10) >> 7;
  *(undefined4 *)(param_1 + 0xa00404) = *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x90);
  *(undefined1 *)(param_1 + 0xa00409) = *(undefined1 *)(param_2 + 0x45);
  *(byte *)(param_1 + 0xa0040b) = *(byte *)(param_2 + 0x43) & 1;
  if ((*(byte *)((longlong)puVar4 + 0x9c) & 4) != 0) {
    *(uint *)(param_1 + 0xa0039c) = *(uint *)(param_1 + 0xa0039c) & 0xffff7fff;
    *(undefined4 *)(param_1 + 0xa00294) = 0;
    *(undefined8 *)(param_1 + 0xa002b4) = 0;
    *(undefined8 *)(param_1 + 0xa002ac) = 0;
  }
  uVar15 = 0xffffffff;
  if (*(ulonglong *)(param_2 + 0x60) < 0x100000000) {
    uVar15 = (undefined4)*(ulonglong *)(param_2 + 0x60);
  }
  *(undefined4 *)(param_1 + 0xa0014c) = uVar15;
  if (puVar4[5] != 0) {
    *(undefined4 *)(param_1 + 0xa00204) = *(undefined4 *)(puVar4[5] + 0x18);
  }
  if (puVar4[8] != 0) {
    *(undefined4 *)(param_1 + 0xa00308) = *(undefined4 *)(puVar4[8] + 0x3c);
  }
  iVar10 = *(int *)(param_2 + 0x34);
  if (iVar10 == 0x46494c45) {
    *(undefined4 *)(param_1 + 0xa0013c) = 1;
    *(undefined4 *)(param_1 + 0xa00144) = *(undefined4 *)(param_2 + 700);
    *(undefined2 *)(param_1 + 0xa00184) = *(undefined2 *)(param_2 + 0x2c4);
    *(undefined2 *)(param_1 + 0xa00186) = *(undefined2 *)(param_2 + 0x2c6);
  }
  else if (iVar10 == 0x48545450) {
    *(undefined4 *)(param_1 + 0xa0013c) = 2;
  }
  else if (iVar10 == 0x53485244) {
    *(undefined4 *)(param_1 + 0xa0013c) = 3;
    *(undefined8 *)(param_1 + 0xa003a8) = *(undefined8 *)(param_2 + 0x80);
    *(undefined1 *)(param_1 + 0xa00395) = *(undefined1 *)(param_2 + 0x90);
    *(undefined4 *)(param_1 + 0xa00378) = *(undefined4 *)(param_2 + 0x98);
    *(undefined4 *)(param_1 + 0xa0037c) = *(undefined4 *)(param_2 + 0x9c);
    *(undefined1 *)(param_1 + 0xa0035a) = *(undefined1 *)(param_2 + 0x94);
    *(undefined1 *)(param_1 + 0xa0035b) = *(undefined1 *)(param_2 + 0x95);
    cVar7 = FUN_140fa9b00(param_2);
    if ((cVar7 != '\0') && (*(char *)(param_2 + 0x3d) == '\x01')) {
      *(undefined1 *)(param_1 + 0xa00387) = 1;
    }
  }
  iVar10 = *(int *)(puVar4 + 0x16);
  if (iVar10 == 0) {
LAB_14106e89c:
    if ((int)uVar19 != 0) {
      return uVar19;
    }
  }
  else {
    if ((int *)(lVar14 + 0x178) == (int *)0x0) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x178) != 0x73747263) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x1b4) == 0) {
      return 0xffffffce;
    }
    if (iVar10 < 1) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x1a4) < iVar10) {
      return 0xffffffce;
    }
    piVar12 = (int *)(**(longlong **)(lVar14 + 0x188) + ((longlong)iVar10 + -1) * 8);
    if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
      uVar13 = 0xffffffce;
      uVar20 = uVar19;
      uVar22 = uVar19;
    }
    else {
      uVar13 = uVar19;
      uVar20 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x198);
      uVar22 = (ulonglong)(uint)piVar12[1];
    }
    uVar19 = uVar13;
    if ((int)uVar19 != 0) {
      return uVar19;
    }
    if ((int)uVar22 == 0) goto LAB_14106e89c;
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,2);
    uVar9 = FUN_14106ac80(param_1,uVar20,uVar22);
    uVar19 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106e89c;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  iVar10 = *(int *)((longlong)puVar4 + 0xb4);
  piVar12 = (int *)(lVar14 + 0x208);
  uVar13 = 0;
  if (iVar10 == 0) {
LAB_14106e96f:
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  else {
    iVar21 = 0;
    lVar17 = 0;
    if (piVar12 == (int *)0x0) {
      return 0xffffffce;
    }
    if (*piVar12 != 0x73747263) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x244) == 0) {
      return 0xffffffce;
    }
    if (iVar10 < 1) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x234) < iVar10) {
      return 0xffffffce;
    }
    piVar2 = (int *)(**(longlong **)(lVar14 + 0x218) + ((longlong)iVar10 + -1) * 8);
    if (((piVar2 == (int *)0x0) || (*piVar2 < 0)) || (piVar2[1] < 1)) {
      uVar13 = 0xffffffce;
    }
    else {
      lVar17 = (longlong)*piVar2 + **(longlong **)(lVar14 + 0x228);
      iVar21 = piVar2[1];
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
    if (iVar21 == 0) goto LAB_14106e96f;
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,4);
    uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
    uVar13 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106e96f;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  iVar10 = *(int *)(puVar4 + 0x17);
  uVar13 = 0;
  if (iVar10 == 0) {
LAB_14106ea3b:
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  else {
    iVar21 = 0;
    lVar17 = 0;
    if (piVar12 == (int *)0x0) {
      return 0xffffffce;
    }
    if (*piVar12 != 0x73747263) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x244) == 0) {
      return 0xffffffce;
    }
    if (iVar10 < 1) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x234) < iVar10) {
      return 0xffffffce;
    }
    piVar12 = (int *)(**(longlong **)(lVar14 + 0x218) + ((longlong)iVar10 + -1) * 8);
    if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
      uVar13 = 0xffffffce;
    }
    else {
      lVar17 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x228);
      iVar21 = piVar12[1];
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
    if (iVar21 == 0) goto LAB_14106ea3b;
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,0x1b);
    uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
    uVar13 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106ea3b;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  iVar10 = *(int *)((longlong)puVar4 + 0xc4);
  uVar13 = 0;
  if (iVar10 == 0) {
LAB_14106eb0b:
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  else {
    iVar21 = 0;
    lVar17 = 0;
    if ((int *)(lVar14 + 0x208) == (int *)0x0) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x208) != 0x73747263) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x244) == 0) {
      return 0xffffffce;
    }
    if (iVar10 < 1) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x234) < iVar10) {
      return 0xffffffce;
    }
    piVar12 = (int *)(**(longlong **)(lVar14 + 0x218) + ((longlong)iVar10 + -1) * 8);
    if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
      uVar13 = 0xffffffce;
    }
    else {
      lVar17 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x228);
      iVar21 = piVar12[1];
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
    if (iVar21 == 0) goto LAB_14106eb0b;
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,0xc);
    uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
    uVar13 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106eb0b;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  iVar10 = *(int *)((longlong)puVar4 + 0xbc);
  uVar13 = 0;
  if (iVar10 == 0) {
LAB_14106ebdb:
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  else {
    iVar21 = 0;
    lVar17 = 0;
    if ((int *)(lVar14 + 0x1c0) == (int *)0x0) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x1c0) != 0x73747263) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x1fc) == 0) {
      return 0xffffffce;
    }
    if (iVar10 < 1) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x1ec) < iVar10) {
      return 0xffffffce;
    }
    piVar12 = (int *)(**(longlong **)(lVar14 + 0x1d0) + ((longlong)iVar10 + -1) * 8);
    if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
      uVar13 = 0xffffffce;
    }
    else {
      lVar17 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x1e0);
      iVar21 = piVar12[1];
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
    if (iVar21 == 0) goto LAB_14106ebdb;
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,3);
    uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
    uVar13 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106ebdb;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  iVar10 = *(int *)(puVar4 + 0x18);
  uVar13 = 0;
  if (iVar10 == 0) {
LAB_14106ecab:
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  else {
    iVar21 = 0;
    lVar17 = 0;
    if ((int *)(lVar14 + 0x250) == (int *)0x0) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x250) != 0x73747263) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x28c) == 0) {
      return 0xffffffce;
    }
    if (iVar10 < 1) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x27c) < iVar10) {
      return 0xffffffce;
    }
    piVar12 = (int *)(**(longlong **)(lVar14 + 0x260) + ((longlong)iVar10 + -1) * 8);
    if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
      uVar13 = 0xffffffce;
    }
    else {
      lVar17 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x270);
      iVar21 = piVar12[1];
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
    if (iVar21 == 0) goto LAB_14106ecab;
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,0xe);
    uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
    uVar13 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106ecab;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  iVar10 = *(int *)(puVar4 + 0x19);
  uVar13 = 0;
  if (iVar10 == 0) {
LAB_14106ed7b:
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  else {
    iVar21 = 0;
    lVar17 = 0;
    if ((int *)(lVar14 + 0x328) == (int *)0x0) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x328) != 0x73747263) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x364) == 0) {
      return 0xffffffce;
    }
    if (iVar10 < 1) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x354) < iVar10) {
      return 0xffffffce;
    }
    piVar12 = (int *)(**(longlong **)(lVar14 + 0x338) + ((longlong)iVar10 + -1) * 8);
    if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
      uVar13 = 0xffffffce;
    }
    else {
      lVar17 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x348);
      iVar21 = piVar12[1];
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
    if (iVar21 == 0) goto LAB_14106ed7b;
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,5);
    uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
    uVar13 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106ed7b;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  iVar10 = *(int *)((longlong)puVar4 + 0xcc);
  uVar13 = 0;
  if (iVar10 == 0) {
LAB_14106ee4b:
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  else {
    iVar21 = 0;
    lVar17 = 0;
    if ((int *)(lVar14 + 0x370) == (int *)0x0) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x370) != 0x73747263) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x3ac) == 0) {
      return 0xffffffce;
    }
    if (iVar10 < 1) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x39c) < iVar10) {
      return 0xffffffce;
    }
    piVar12 = (int *)(**(longlong **)(lVar14 + 0x380) + ((longlong)iVar10 + -1) * 8);
    if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
      uVar13 = 0xffffffce;
    }
    else {
      lVar17 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x390);
      iVar21 = piVar12[1];
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
    if (iVar21 == 0) goto LAB_14106ee4b;
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,6);
    uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
    uVar13 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106ee4b;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  uVar13 = 0;
  if (*(int *)(puVar4 + 0x1a) == 0) {
LAB_14106eed0:
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  else {
    uVar9 = FUN_140bff470(*(longlong *)(param_1 + 0x1e00270) + 0x3b8,*(int *)(puVar4 + 0x1a),
                          &uStack_248);
    uVar13 = (ulonglong)uVar9;
    if ((uVar9 != 0) || (uStack_248 == 0)) goto LAB_14106eed0;
    FUN_140ea9f50(&uStack_248,&uStack_248);
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,7);
    uVar9 = FUN_14106ac80(param_1,auStack_246,(uint)uStack_248 * 2,*(undefined4 *)(puVar4 + 0x1a));
    uVar13 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106eed0;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  iVar10 = *(int *)(puVar4 + 0x1a);
  uVar13 = 0;
  if (iVar10 == 0) {
LAB_14106efa0:
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  else {
    iVar21 = 0;
    lVar17 = 0;
    if ((int *)(lVar14 + 0x3b8) == (int *)0x0) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x3b8) != 0x73747263) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x3f4) == 0) {
      return 0xffffffce;
    }
    if (iVar10 < 1) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x3e4) < iVar10) {
      return 0xffffffce;
    }
    piVar12 = (int *)(**(longlong **)(lVar14 + 0x3c8) + ((longlong)iVar10 + -1) * 8);
    if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
      uVar13 = 0xffffffce;
    }
    else {
      lVar17 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x3d8);
      iVar21 = piVar12[1];
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
    if (iVar21 == 0) goto LAB_14106efa0;
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,7);
    uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
    uVar13 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106efa0;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  iVar10 = *(int *)((longlong)puVar4 + 0xd4);
  uVar13 = 0;
  if (iVar10 == 0) {
LAB_14106f070:
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  else {
    iVar21 = 0;
    lVar17 = 0;
    if ((int *)(lVar14 + 0x400) == (int *)0x0) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x400) != 0x73747263) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x43c) == 0) {
      return 0xffffffce;
    }
    if (iVar10 < 1) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x42c) < iVar10) {
      return 0xffffffce;
    }
    piVar12 = (int *)(**(longlong **)(lVar14 + 0x410) + ((longlong)iVar10 + -1) * 8);
    if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
      uVar13 = 0xffffffce;
    }
    else {
      lVar17 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x420);
      iVar21 = piVar12[1];
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
    if (iVar21 == 0) goto LAB_14106f070;
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,8);
    uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
    uVar13 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106f070;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  iVar10 = *(int *)(puVar4 + 0x1b);
  uVar13 = 0;
  if (iVar10 == 0) {
LAB_14106f140:
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  else {
    iVar21 = 0;
    lVar17 = 0;
    if ((int *)(lVar14 + 0x448) == (int *)0x0) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x448) != 0x73747263) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x484) == 0) {
      return 0xffffffce;
    }
    if (iVar10 < 1) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x474) < iVar10) {
      return 0xffffffce;
    }
    piVar12 = (int *)(**(longlong **)(lVar14 + 0x458) + ((longlong)iVar10 + -1) * 8);
    if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
      uVar13 = 0xffffffce;
    }
    else {
      lVar17 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x468);
      iVar21 = piVar12[1];
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
    if (iVar21 == 0) goto LAB_14106f140;
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,9);
    uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
    uVar13 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106f140;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  iVar10 = *(int *)((longlong)puVar4 + 0xdc);
  uVar13 = 0;
  if (iVar10 == 0) {
LAB_14106f210:
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  else {
    iVar21 = 0;
    lVar17 = 0;
    if ((int *)(lVar14 + 0x490) == (int *)0x0) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x490) != 0x73747263) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x4cc) == 0) {
      return 0xffffffce;
    }
    if (iVar10 < 1) {
      return 0xffffffce;
    }
    if (*(int *)(lVar14 + 0x4bc) < iVar10) {
      return 0xffffffce;
    }
    piVar12 = (int *)(**(longlong **)(lVar14 + 0x4a0) + ((longlong)iVar10 + -1) * 8);
    if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
      uVar13 = 0xffffffce;
    }
    else {
      lVar17 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x4b0);
      iVar21 = piVar12[1];
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
    if (iVar21 == 0) goto LAB_14106f210;
    plStack_308 = &lStack_2f0;
    plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,10);
    uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
    uVar13 = (ulonglong)uVar9;
    if (uVar9 != 0) goto LAB_14106f210;
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
  uVar13 = 0;
  do {
    uStack_288 = 0;
    uStack_280 = 0;
    uStack_278 = 0;
    uStack_270 = 0;
    uStack_268 = 0;
    uStack_260 = 0;
    func_0x000140eb8130(puVar4,uVar13,auStack_2d8);
    if (iStack_2cc != 0) {
      iVar10 = *(int *)((longlong)puVar4 + uVar13 * 4 + 0x160);
      uVar19 = 0;
      if (iVar10 == 0) {
LAB_14106f316:
        if ((int)uVar19 != 0) {
          return uVar19;
        }
      }
      else {
        iVar21 = 0;
        lVar17 = 0;
        if (piStack_298 == (int *)0x0) {
          return 0xffffffce;
        }
        if (*piStack_298 != 0x73747263) {
          return 0xffffffce;
        }
        if (piStack_298[0xf] == 0) {
          return 0xffffffce;
        }
        if (iVar10 < 1) {
          return 0xffffffce;
        }
        if (piStack_298[0xb] < iVar10) {
          return 0xffffffce;
        }
        piVar12 = (int *)(**(longlong **)(piStack_298 + 4) + -8 + (longlong)iVar10 * 8);
        if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
          uVar19 = 0xffffffce;
        }
        else {
          lVar17 = (longlong)*piVar12 + **(longlong **)(piStack_298 + 8);
          iVar21 = piVar12[1];
        }
        if ((int)uVar19 != 0) {
          return uVar19;
        }
        if (iVar21 == 0) goto LAB_14106f316;
        plStack_308 = &lStack_2f0;
        plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
        uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,iStack_2cc);
        uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
        uVar19 = (ulonglong)uVar9;
        if (uVar9 != 0) goto LAB_14106f316;
        *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
      }
      *(undefined1 *)(uVar13 + 0x14c + (longlong)puVar1) =
           *(undefined1 *)(uVar13 + 0x92 + (longlong)puVar4);
    }
    uVar9 = (int)uVar13 + 1;
    uVar13 = (ulonglong)uVar9;
  } while (uVar9 < 6);
  if ((*(byte *)puVar4[0xd] & 1) != 0) {
    iVar10 = *(int *)((byte *)puVar4[0xd] + 0x18);
    uVar13 = 0;
    if (iVar10 == 0) {
LAB_14106f40f:
      if ((int)uVar13 != 0) {
        return uVar13;
      }
    }
    else {
      iVar21 = 0;
      lVar17 = 0;
      if ((int *)(lVar14 + 0x298) == (int *)0x0) {
        return 0xffffffce;
      }
      if (*(int *)(lVar14 + 0x298) != 0x73747263) {
        return 0xffffffce;
      }
      if (*(int *)(lVar14 + 0x2d4) == 0) {
        return 0xffffffce;
      }
      if (iVar10 < 1) {
        return 0xffffffce;
      }
      if (*(int *)(lVar14 + 0x2c4) < iVar10) {
        return 0xffffffce;
      }
      piVar12 = (int *)(**(longlong **)(lVar14 + 0x2a8) + ((longlong)iVar10 + -1) * 8);
      if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
        uVar13 = 0xffffffce;
      }
      else {
        lVar17 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x2b8);
        iVar21 = piVar12[1];
      }
      if ((int)uVar13 != 0) {
        return uVar13;
      }
      if (iVar21 == 0) goto LAB_14106f40f;
      plStack_308 = &lStack_2f0;
      plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
      uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,0x3f);
      uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
      uVar13 = (ulonglong)uVar9;
      if (uVar9 != 0) goto LAB_14106f40f;
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    uVar13 = 0;
    iVar10 = *(int *)(puVar4[0xd] + 0x1c);
    if (iVar10 == 0) {
LAB_14106f4e2:
      if ((int)uVar13 != 0) {
        return uVar13;
      }
    }
    else {
      iVar21 = 0;
      lVar17 = 0;
      if ((((int *)(lVar14 + 0x2e0) == (int *)0x0) || (*(int *)(lVar14 + 0x2e0) != 0x73747263)) ||
         ((*(int *)(lVar14 + 0x31c) == 0 || ((iVar10 < 1 || (*(int *)(lVar14 + 0x30c) < iVar10))))))
      {
        return 0xffffffce;
      }
      piVar12 = (int *)(**(longlong **)(lVar14 + 0x2f0) + ((longlong)iVar10 + -1) * 8);
      if (((piVar12 == (int *)0x0) || (*piVar12 < 0)) || (piVar12[1] < 1)) {
        uVar13 = 0xffffffce;
      }
      else {
        lVar17 = (longlong)*piVar12 + **(longlong **)(lVar14 + 0x300);
        iVar21 = piVar12[1];
      }
      if ((int)uVar13 != 0) {
        return uVar13;
      }
      if (iVar21 == 0) goto LAB_14106f4e2;
      plStack_308 = &lStack_2f0;
      plStack_310 = (longlong *)CONCAT44(plStack_310._4_4_,1);
      uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,0x40);
      uVar9 = FUN_14106ac80(param_1,lVar17,iVar21);
      uVar13 = (ulonglong)uVar9;
      if (uVar9 != 0) goto LAB_14106f4e2;
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x520,*(undefined4 *)(puVar4[0xd] + 0x34),0x12);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x520,*(undefined4 *)(puVar4[0xd] + 0x38),0x16);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x520,*(undefined4 *)(puVar4[0xd] + 0x3c),0x33);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x880,*(undefined4 *)(puVar4[0xd] + 0x40),0x2e);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 0;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x568,*(undefined4 *)(puVar4[0xd] + 0x20),0x13);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 0;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x5b0,*(undefined4 *)(puVar4[0xd] + 0x24),0x25);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 0;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x5b0,*(undefined4 *)(puVar4[0xd] + 0x28),0x3a);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 0;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x5f8,*(undefined4 *)(puVar4[0xd] + 0x2c),0x39);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x718,*(undefined4 *)(puVar4[0xd] + 0x30),0x1c);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318 = (longlong *)((ulonglong)uStack_318._4_4_ << 0x20);
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x1888,*(undefined4 *)(puVar4[0xd] + 0x4c),0x2a);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
  }
  if ((**(byte **)(param_2 + 0x10) & 1) != 0) {
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x7a8,*(undefined4 *)(*(byte **)(param_2 + 0x10) + 0x68),
                          0x2b);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 2;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x7f0,
                          *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x6c),0x2d);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x838,
                          *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x70),0x34);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x8c8,
                          *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x74),0x3b);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x910,
                          *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x78),0x3c);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x8c8,
                          *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x7c),0x3d);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,1);
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x910,
                          *(undefined4 *)(*(longlong *)(param_2 + 0x10) + 0x80),0x3e);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    if (((*(byte *)(param_2 + 0x40) & 0x20) != 0) &&
       (piVar12 = (int *)func_0x000140fa9220(param_2), piVar12 != (int *)0x0)) {
      lStack_2e8 = 0;
      iVar10 = FUN_140bde130(piVar12,&lStack_2e8);
      if (iVar10 == 0) {
        if (lStack_2e8 == 0) {
          uVar11 = 0;
          uVar13 = 0;
LAB_14106fb2d:
          uStack_318 = &lStack_2f0;
          uVar9 = FUN_14106af90(param_1,uVar11,uVar13 & 0xffffffff,0x15);
          *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
        }
        else {
          uVar13 = CFDataGetLength(lStack_2e8);
          uVar9 = 0;
          if (uVar13 < 0x500001) {
            uStack_2e0 = CFDataGetLength(lStack_2e8);
            uVar11 = CFDataGetBytePtr(lStack_2e8);
            uVar13 = uStack_2e0;
            goto LAB_14106fb2d;
          }
        }
        uVar13 = (ulonglong)uVar9;
      }
      else {
        uVar13 = 0;
      }
      if (lStack_2e8 != 0) {
        CFRelease(lStack_2e8);
      }
      if (*piVar12 == 0x63687064) {
        piVar2 = piVar12 + 1;
        *piVar2 = *piVar2 + -1;
        if (*piVar2 == 0) {
          FUN_140bde340(piVar12);
        }
      }
      if ((int)uVar13 != 0) {
        return uVar13;
      }
    }
    lVar17 = *(longlong *)(*(longlong *)(param_2 + 0x10) + 0x98);
    if (lVar17 != 0) {
      uVar9 = FUN_14106b140(param_1,lVar17,0x30,&lStack_2f0);
      if (uVar9 != 0) {
        return (ulonglong)uVar9;
      }
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
  }
  if ((*(byte *)puVar4[0xe] & 1) != 0) {
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x640,*(undefined4 *)((byte *)puVar4[0xe] + 0x28),0x18);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x6d0,*(undefined4 *)(puVar4[0xe] + 0x2c),0x19);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 2;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x760,*(undefined4 *)(puVar4[0xe] + 0x24),0x1d);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,1);
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x6d0,*(undefined4 *)(puVar4[0xe] + 0x30),0x41);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
  }
  pbVar18 = *(byte **)(param_2 + 0x18);
  if ((*pbVar18 & 1) != 0) {
    uVar13 = 0;
    if (*(int *)(pbVar18 + 0x1c) != 0) {
      do {
        uVar9 = FUN_14106c980(param_1,puVar1,pbVar18 + uVar13 * 0x38 + 0x20,&lStack_2f0);
        if (uVar9 != 0) {
          return (ulonglong)uVar9;
        }
        pbVar18 = *(byte **)(param_2 + 0x18);
        uVar9 = (int)uVar13 + 1;
        uVar13 = (ulonglong)uVar9;
      } while (uVar9 < *(uint *)(pbVar18 + 0x1c));
    }
    *(byte *)(param_1 + 0xa00284) = pbVar18[0x18];
    *(undefined1 *)(param_1 + 0xa00285) = *(undefined1 *)(*(longlong *)(param_2 + 0x18) + 0x19);
    *(undefined1 *)(param_1 + 0xa00298) = *(undefined1 *)(*(longlong *)(param_2 + 0x18) + 0x1a);
    *(byte *)(param_1 + 0xa0029b) = **(byte **)(param_2 + 0x18) >> 3 & 1;
    *(undefined1 *)(param_1 + 0xa0038b) = *(undefined1 *)(*(longlong *)(param_2 + 0x18) + 0x12);
    *(undefined1 *)(param_1 + 0xa00408) = *(undefined1 *)(*(longlong *)(param_2 + 0x18) + 0x14);
    sVar3 = *(short *)(*(longlong *)(param_2 + 0x18) + 0x12);
    if ((sVar3 == 1) || ((ushort)(sVar3 - 2U) < 2)) {
      uVar6 = 1;
    }
    else {
      uVar6 = 0;
    }
    *(undefined1 *)(param_1 + 0xa00306) = uVar6;
  }
  if ((((*(byte *)((longlong)puVar4 + 0x9b) & 8) != 0) ||
      ((*(char *)((longlong)puVar4 + 0x9d) < '\0' &&
       (uVar13 = FUN_140fa0b70(puVar4,0), (uVar13 & 0x200004) != 0)))) &&
     (*(int *)(param_2 + 0x34) == 0x48545450)) {
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x4d8,*(undefined4 *)(puVar4[0xd] + 0x48),0xf);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,1);
    uVar9 = FUN_14106b030(param_1,lVar14 + 0x4d8,*(undefined4 *)(puVar4[0xd] + 0x44),0x10);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
  }
  if (*(longlong *)(param_2 + 0x2d0) != 0) {
    uVar13 = 0;
    lVar14 = 0;
    if ((*(int *)(**(longlong **)(unaff_GS_OFFSET + 0x58) + 8) < _DAT_14210dc54) &&
       (FUN_14179c258(&DAT_14210dc54), _DAT_14210dc54 == -1)) {
      _DAT_1420fe818 = _DAT_1420af740;
      _DAT_1420fe820 = _DAT_1420af748;
      _DAT_1420fe828 = _DAT_1420af750;
      FUN_14179c1ec(&DAT_14210dc54);
    }
    uVar19 = 0;
    do {
      lStack_2e8 = *(longlong *)(&DAT_1420fe818 + uVar19 * 8);
      if (((*(longlong *)(param_2 + 0x2d0) != 0) && (lStack_2e8 != 0)) &&
         (uStack_2e0 = CFDictionaryGetValue(*(longlong *)(param_2 + 0x2d0),lStack_2e8),
         uStack_2e0 != 0)) {
        if ((lVar14 == 0) &&
           (lVar14 = CFDictionaryCreateMutable
                               (_DAT_1420a6090,0,kCFTypeDictionaryKeyCallBacks_exref,
                                kCFTypeDictionaryValueCallBacks_exref), lVar14 == 0)) {
          return 0xffffff94;
        }
        CFDictionarySetValue(lVar14,lStack_2e8,uStack_2e0);
      }
      uVar9 = (int)uVar19 + 1;
      uVar19 = (ulonglong)uVar9;
    } while (uVar9 < 3);
    if (lVar14 != 0) {
      uVar9 = FUN_14106b140(param_1,lVar14,0x38,&lStack_2f0);
      uVar13 = (ulonglong)uVar9;
      if (uVar9 == 0) {
        *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
      }
      CFRelease(lVar14);
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  if (*(longlong *)(puVar4[0xd] + 0x58) != 0) {
    uVar13 = 0;
    lVar14 = FUN_140fa1a50(puVar4,0);
    if (lVar14 != 0) {
      lVar17 = CFDictionaryGetCount(lVar14);
      if ((0 < lVar17) && (cVar7 = FUN_140fbba60(puVar4), cVar7 == '\0')) {
        if ((*(int *)(**(longlong **)(unaff_GS_OFFSET + 0x58) + 8) < _DAT_14210dc58) &&
           (FUN_14179c258(&DAT_14210dc58), _DAT_14210dc58 == -1)) {
          _DAT_1420fe7e8 = _DAT_1420af700;
          _DAT_1420fe7f0 = _DAT_1420af708;
          _DAT_1420fe7f8 = _DAT_1420af710;
          _DAT_1420fe800 = _DAT_1420af718;
          _DAT_1420fe808 = _DAT_1420af720;
          _DAT_1420fe810 = _DAT_1420af728;
          FUN_14179c1ec(&DAT_14210dc58);
        }
        if (_DAT_1420fe7e8 != 0) {
          CFDictionaryRemoveValue(lVar14);
        }
        if (_DAT_1420fe7f0 != 0) {
          CFDictionaryRemoveValue(lVar14);
        }
        if (_DAT_1420fe7f8 != 0) {
          CFDictionaryRemoveValue(lVar14);
        }
        if (_DAT_1420fe800 != 0) {
          CFDictionaryRemoveValue(lVar14);
        }
        if (_DAT_1420fe808 != 0) {
          CFDictionaryRemoveValue(lVar14);
        }
        if (_DAT_1420fe810 != 0) {
          CFDictionaryRemoveValue(lVar14);
        }
      }
      lVar17 = CFDictionaryGetCount(lVar14);
      if (0 < lVar17) {
        uVar9 = FUN_14106b140(param_1,lVar14,0x36,&lStack_2f0);
        uVar13 = (ulonglong)uVar9;
        if (uVar9 == 0) {
          *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
        }
      }
    }
    if ((int)uVar13 != 0) {
      return uVar13;
    }
  }
  if (*(int *)(param_1 + 0xa0013c) == 1) {
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318._0_4_ = 1;
    uVar9 = FUN_14106b030(param_1,*(undefined8 *)(param_2 + 0x2c8),*(undefined4 *)(param_2 + 0x2b8),
                          0xd);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    uVar15 = *(undefined4 *)(param_2 + 0x2c0);
    uVar11 = 0xb;
    uStack_318 = (longlong *)CONCAT44(uStack_318._4_4_,2);
  }
  else {
    if (*(int *)(param_1 + 0xa0013c) != 2) goto LAB_141070229;
    plStack_308 = (longlong *)acStack_2f8;
    plStack_310 = &lStack_2f0;
    uStack_318 = (longlong *)((ulonglong)uStack_318._4_4_ << 0x20);
    uVar9 = FUN_14106b030(param_1,*(undefined8 *)(param_2 + 0x2c8),*(undefined4 *)(param_2 + 0x2b8),
                          0xb);
    if (uVar9 != 0) {
      return (ulonglong)uVar9;
    }
    if (acStack_2f8[0] != '\0') {
      *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
    }
    uVar15 = *(undefined4 *)(param_2 + 700);
    uVar11 = 0x11;
    uStack_318 = (longlong *)((ulonglong)uStack_318 & 0xffffffff00000000);
  }
  plStack_308 = (longlong *)acStack_2f8;
  plStack_310 = &lStack_2f0;
  uVar9 = FUN_14106b030(param_1,*(undefined8 *)(param_2 + 0x2c8),uVar15,uVar11);
  if (uVar9 != 0) {
    return (ulonglong)uVar9;
  }
  if (acStack_2f8[0] != '\0') {
    *(int *)(param_1 + 0xa00134) = *(int *)(param_1 + 0xa00134) + 1;
  }
LAB_141070229:
  iVar10 = ((int)lStack_2f0 - (int)param_1) + -0xa00128;
  *(int *)(param_1 + 0xa00130) = iVar10;
  func_0x000141069150(param_1,puVar1);
  uVar9 = FUN_14106ab70(param_1,param_1 + 0xa00128,iVar10);
  return (ulonglong)uVar9;
}

