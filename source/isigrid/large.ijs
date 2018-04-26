NB. large

NB. =========================================================
largedemo=: 3 : 0
Grid=: 'large'
wd FormHeader
wd 'cc g isigrid'
wd 'set g shape ',":Rws,Cls
wd 'set g hdr ',Hdr
wd 'set g lab ',Lab
wd 'set g data ',Tax
setnewwin wd 'qhwndp'
wd 'pshow'
)

NB. =========================================================
largehelp=: 0 : 0
Shows an isigrid with 1 million elements (1000x1000).
)

NB. build large data:
Rws=: 1000
Cls=: 1000
Tab=. 10000+?(Rws,Cls)$90000
Tax=: toSOH ,-.&' ' each 'c0.0'8!:0 Tab
Hdr=: toSOH (<'Hdr')(,":) each i.Cls
Lab=: toSOH (<'Lab')(,":) each i.Rws
