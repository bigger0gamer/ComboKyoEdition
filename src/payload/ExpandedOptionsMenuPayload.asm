.psx

ExpandedOptionsMenuCheckIfChanged:
  ;lhu v0,0x308C(a0)
  lui at,hi(RandomStageSetting)
  lhu v1,lo(RandomStageSetting)(at)
  nop
  bne v1,v0,@@SettingChanged
  
  lhu v1,lo(FPSSetting)(at)
  lhu v0,0x3092(a0)
  nop
  bne v1,v0,@@SettingChanged
  
  lhu v1,lo(RandomMusicSetting)(at)
  lhu v0,0x3098(a0)
  nop
  bne v1,v0,@@SettingChanged
  
  lh v1,0x0008(a1)  ; original instruction
  j ExpandedOptionsMenuNotChangedReturn
  lh v0,0x3074(a0)  ; original instruction
  
  @@SettingChanged:
  j ExpandedOptionsMenuIsChangedReturn
  addiu v0,r0,1
  

ExpandedOptionsMenuCopyToLowerRAM:
  lhu v0,0x308C(a0)
  lui at,hi(RandomStageSetting)
  sh v0,lo(RandomStageSetting)(at)
  
  lhu v0,0x3092(a0)
  lhu s0,0x3098(a0)
  sh v0,lo(FPSSetting)(at)
  
  ;lhu v0,0x307A(a0)  ; original instruction
  j ExpandedOptionsMenuCopyToLowerRAMReturn
  sh s0,lo(RandomMusicSetting)(at)


ExpandedOptionsMenuLoadCustomVariables:
  ; a3, v0, t0-2
  lh a3,lo(RandomStageSetting)(v0)
  lui at,hi(OptionsMenuFiveSelection)
  sh a3,lo(OptionsMenuFiveSelection)(at)
  
  lh a3,lo(FPSSetting)(v0)
  lh t0,lo(RandomMusicSetting)(v0)
  sh a3,lo(OptionsMenuSixSelection)(at)
  
  j 0x80031708 ; original instruction
  sh t0,lo(OptionsMenuSevenSelection)(at)
