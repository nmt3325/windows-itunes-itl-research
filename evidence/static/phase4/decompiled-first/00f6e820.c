/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0xf6e820; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

undefined8
FUN_140f6e820(longlong *param_1,undefined4 param_2,undefined4 param_3,undefined8 param_4,
             undefined1 param_5,longlong param_6,longlong param_7,undefined8 *param_8)

{
  longlong *plVar1;
  int *piVar2;
  int iVar3;
  longlong lVar4;
  longlong *plVar5;
  longlong *plStack_28;
  longlong *plStack_20;
  
  plVar5 = (longlong *)FUN_140f6e110(param_1,param_4,2);
  if (plVar5 != (longlong *)0x0) {
    if (param_7 != 0) {
      plVar5[0x10] = param_7;
      *(byte *)((longlong)plVar5 + 0x8c) = *(byte *)((longlong)plVar5 + 0x8c) & 0xfe;
    }
    (**(code **)(*plVar5 + 0xa8))(plVar5,param_5);
    if (param_6 != 0) {
      FUN_140f70b00(plVar5,&plStack_28);
      if (plStack_28 != (longlong *)0x0) {
        (**(code **)(*plStack_28 + 0x220))(plStack_28,param_6);
      }
      if (plStack_20 != (longlong *)0x0) {
        LOCK();
        plVar1 = plStack_20 + 1;
        lVar4 = *plVar1;
        *(int *)plVar1 = (int)*plVar1 + -1;
        UNLOCK();
        if ((int)lVar4 == 1) {
          (**(code **)*plStack_20)(plStack_20);
          LOCK();
          piVar2 = (int *)((longlong)plStack_20 + 0xc);
          iVar3 = *piVar2;
          *piVar2 = *piVar2 + -1;
          UNLOCK();
          if (iVar3 == 1) {
            (**(code **)(*plStack_20 + 8))(plStack_20);
          }
        }
      }
    }
    FUN_140bffff0(plVar5 + 0x1f,param_1 + 0x41,param_2,0);
    FUN_140bffff0(plVar5 + 0x22,param_1 + 0x2ff,param_3,0);
    func_0x000140f6e7b0(plVar5);
    (**(code **)(*param_1 + 8))(param_1,0x74326161,param_1,plVar5,0);
    *param_8 = plVar5;
  }
  return 0;
}

