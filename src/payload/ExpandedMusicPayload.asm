.psx

ExpandedMusic:
  li s0,ExpandedMusicTable
  sll at,a1,4
  sll a1,a1,2
  add a1,a1,at
  j ExpandedMusicReturn
  add s0,s0,a1
