NB. move

NB. =========================================================
NB. movemark v move the marked coin
movemark=: 3 : 0
pos=. {.y
mov=. sort pos,.AVAIL
clr=. MOVECLR {~ MOVEPOS i. mov
DONE=: (clr=0) *. AVAIL = ENDPOS
POS=: (clr,AVAIL), POS -. clr,pos
LASTAVAIL=: AVAIL
COUNT=: BUFNDX=: >: BUFNDX
BUFFER=: (BUFNDX {. BUFFER), <POS
paint''
if. DONE do.
  info 'Finished.'
end.
)
