/* Actual Ghidra 12.1.3 decompilation; module=iTunes.exe; image_base=0x140000000; RVA=0x106a520; SHA256=30d91209b5d81c47bbad2da9d89764fcab08bf5cd9af1a9571668001376c5d7d */

undefined8 itl_106a520(longlong param_1,int param_2)

{
  ulonglong uVar1;
  
  uVar1 = (longlong)param_2 + *(longlong *)(param_1 + 0x1e00170);
  *(ulonglong *)(param_1 + 0x1e00170) = uVar1;
  if ((uVar1 < *(ulonglong *)(param_1 + 0x1e00178)) ||
     (*(longlong *)(param_1 + 0x1e00180) + *(ulonglong *)(param_1 + 0x1e00178) <= uVar1)) {
    *(longlong *)(param_1 + 0x1e00180) = 0;
  }
  return 0;
}

