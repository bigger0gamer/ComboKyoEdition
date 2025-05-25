.psx

ExpandedOptionsMenuCheckIfChanged:
  ;lhu v0,0x308C(a0)
  lui at,hi(RandomStageSetting)
  lh v1,lo(RandomStageSetting)(at)
  nop
  bne v1,v0,@@SettingChanged
  addiu v0,r0,1
  
  lhu v0,0x3092(a0)
  lh v1,lo(FPSSetting)(at)
  nop
  bne v1,v0,@@SettingChanged
  addiu v0,r0,1
  
  lhu v0,0x3098(a0)
  lh v1,lo(RandomMusicSetting)(at)
  nop
  bne v1,v0,@@SettingChanged
  addiu v0,r0,1
  
  lh v1,0x0008(a1)  ; original instruction
  j ExpandedOptionsMenuNotChangedReturn
  lh v0,0x3074(a0)  ; original instruction
  
  @@SettingChanged:
  j ExpandedOptionsMenuIsChangedReturn
  nop
  

ExpandedOptionsMenuCopyToLowerRAM:
  ;lhu v0,0x308C(a0)
  lui at,hi(RandomStageSetting)
  sh v0,lo(RandomStageSetting)(at)
  
  lhu v0,0x3092(a0)
  nop
  sh v0,lo(FPSSetting)(at)
  
  lhu v0,0x3098(a0)
  nop
  sh v0,lo(RandomMusicSetting)(at)
  
  lhu v0,0x307A(a0)  ; original instruction
  j ExpandedOptionsMenuCopyToLowerRAMReturn
  nop


ExpandedOptionsMenuLoadCustomVariables:
  ; a3, v0
  lh a3,lo(RandomStageSetting)(v0)
  lui at,hi(OptionsMenuFiveSelection)
  sh a3,lo(OptionsMenuFiveSelection)(at)
  
  lh a3,lo(FPSSetting)(v0)
  nop
  sh a3,lo(OptionsMenuSixSelection)(at)
  
  lh a3,lo(RandomMusicSetting)(v0)
  j 0x80031708 ; original instruction
  sh a3,lo(OptionsMenuSevenSelection)(at)
