NB. mouse handling

NB. =========================================================
mmove=: 3 : 0
if. DONE do. return. end.
ndx=. gethit''
if. MBRDOWN < ndx < 0 do.
  clearmark''
else.
  drawhigh ndx { ACTIVE
end.
)

NB. =========================================================
mbldown=: 3 : 0
MBRDOWN=: 0
if. DONE do. return. end.
ndx=. gethit''
if. ndx < 0 do. return. end.
movemark ndx { ACTIVE
)

NB. =========================================================
mbrdown=: 3 : 0
MBRDOWN=: 1
coin_helper''
)

NB. =========================================================
mbrup=: 3 : 0
MBRDOWN=: 0
clearmark''
)
