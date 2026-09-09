/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x106a430; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

/* WARNING: Globals starting with '_' overlap smaller symbols at the same address */

void FUN_14106a430(undefined4 *param_1)

{
  double dVar1;
  double dVar2;
  char cVar3;
  undefined8 uVar4;
  char *pcVar5;
  char *pcVar6;
  char *pcVar7;
  
  if (param_1 != (undefined4 *)0x0) {
    *(undefined8 *)(param_1 + 2) = 0;
    *(undefined8 *)(param_1 + 4) = 0;
    *(undefined8 *)(param_1 + 6) = 0;
    *(undefined8 *)(param_1 + 8) = 0;
    *(undefined8 *)(param_1 + 10) = 0;
    *(undefined8 *)(param_1 + 0xc) = 0;
    *(undefined8 *)(param_1 + 0xe) = 0;
    *(undefined8 *)(param_1 + 0x10) = 0;
    *(undefined8 *)(param_1 + 0x12) = 0;
    *(undefined8 *)(param_1 + 0x14) = 0;
    *(undefined8 *)(param_1 + 0x16) = 0;
    *(undefined8 *)(param_1 + 0x18) = 0;
    *(undefined8 *)(param_1 + 0x1a) = 0;
    *(undefined8 *)(param_1 + 0x1c) = 0;
    *(undefined8 *)(param_1 + 0x1e) = 0;
    *(undefined8 *)(param_1 + 0x20) = 0;
    *(undefined8 *)(param_1 + 0x22) = 0;
  }
  *param_1 = 0x6864666d;
  param_1[1] = 0x90;
  *(undefined8 *)(param_1 + 0xd) = *(undefined8 *)(*(longlong *)(param_1 + 0x78009c) + 0x88);
  *(undefined2 *)(param_1 + 0x10) = 0x202;
  *(undefined1 *)((longlong)param_1 + 0x43) = 0;
  *(undefined2 *)(param_1 + 0x14) = 0x38;
  *(undefined1 *)((longlong)param_1 + 0x52) = 1;
  param_1[0x16] = *(undefined4 *)(*(longlong *)(param_1 + 0x78009c) + 0x94);
  param_1[0x17] = 0x19000;
  uVar4 = 0;
  if (_DAT_1420a6f30 != 0) {
    uVar4 = *(undefined8 *)(_DAT_1420a6f30 + 0xf4fc);
  }
  *(undefined8 *)(param_1 + 0x1a) = uVar4;
  dVar2 = (double)CFAbsoluteTimeGetCurrent();
  dVar1 = *(double *)kCFAbsoluteTimeIntervalSince1904_exref;
  param_1[3] = 0x10043;
  param_1[0xf] = 0x6f;
  param_1[0x1c] = (int)(longlong)(dVar2 + dVar1);
  pcVar7 = (char *)(param_1 + 4);
  if (pcVar7 != (char *)0x0) {
    *pcVar7 = '\0';
    pcVar5 = "12.13.10.3";
    pcVar6 = (char *)((longlong)param_1 + 0x11);
    cVar3 = '\0';
    do {
      if (cVar3 == '\x1f') {
        return;
      }
      cVar3 = *pcVar5;
      pcVar5 = pcVar5 + 1;
      *pcVar6 = cVar3;
      pcVar6 = pcVar6 + 1;
      *pcVar7 = *pcVar7 + '\x01';
      cVar3 = *pcVar7;
    } while (*pcVar5 != '\0');
  }
  return;
}

