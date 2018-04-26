NB. util

getnum=: 3 : '".;._2 [ 0 : 0'
index1=: # (| - =) i.&1
intersect=: e. # [
intable=: +./"1 @: =
isempty=: 0: e. $
lookup=: (= {."1) # {:"1@]
round=: [ * [: <. 0.5"_ + %~
roundint=: <. @: +&0.5
where=: #~

info=: sminfo @ ('Coins'&;)
query=: wdquery @ ('Coins'&;)

NB. =========================================================
NB. colors:
COLORSTD=: getnum''
192 0 0
192 192 192
0 192 0
0 0 192
)

COLORHIGH=: getnum''
248 0 0
240 240 240
0 248 0
0 160 248
)

NB. =========================================================
clearmark=: 3 : 0
if. #HIGH do.
  HIGH=: ''
  paint''
end.
)

NB. =========================================================
NB. get board
getboard=: 3 : 0
'COLORS LAYOUT POS MOVES'=: ". 'BOARD',": BOARD
CLRSTD=: COLORS { COLORSTD
CLRHIGH=: COLORS { COLORHIGH
ALLPOS=: i. #LAYOUT
NB. split MOVES into color and positions:
MOVECLR=: {."1 MOVES
MOVEPOS=: }."1 MOVES
)

NB. =========================================================
gethit=: 3 : 0
ACTIVECTR inrect 2 {. 0 ". sysdata
)

NB. =========================================================
NB. get active positions (that can move to empty)
getmoves=: 3 : 0
AVAIL=: {. ALLPOS -. {:"1 POS
msk=. +/"1 AVAIL = MOVEPOS
pot=. (msk # MOVECLR) ,. (msk # MOVEPOS) -."1 AVAIL
ACTIVE=: AVAIL -.~ , }."1 pot intersect POS
)

NB. =========================================================
NB. test rects for hit
NB. form: centers inrects pos
NB. returns hit index, or _1 if none
inrect=: 4 : 0
index1 *./"1 RAD >: | x -"1 y
)

NB. =========================================================
setparentname=: 3 : 0
wd 'pn *Coins ',BOARD pick BOARDS
)
