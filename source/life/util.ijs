NB. util

fix=: 0: ". ];._2
info=: (sminfo @ ('Life'&;))`(wd @ ('textview *|Life||'&,))@.IFJA
ischar=: 2: = 3!:0
isempty=: 0: e. $
pathname=: 3 : '(b#y);(-.b=.+./\.''/''=jpathsep y)#y'
wdx=: wd :: ]
bufinit=: 3 : 0
BUF=: MAXBUF # a:
HASBUF=: 0
)

NB. =========================================================
buffer=: 3 : 0
BUF=: }. BUF, <STATE
HASBUF=: 1
)

NB. =========================================================
fmtsize=: 3 : 0
'r c'=. y
(":r),' x ',":c
)

NB. =========================================================
iscolor=: 3 : 0
*./ (3=#y), y e. i. 256
)

NB. =========================================================
mbcolor=: 3 : 0
new=. ,0 ". wd 'mb color ',":y,COLORMB
if. isempty new do. '' return. end.
COLORMB=: 3 }. new
3 {. new
)

NB. =========================================================
put=: 3 : 0
'board pos new'=. y
ndx=. ($board) | each pos +each i.each $new
new (<ndx) } board
)

NB. =========================================================
setformsize=: 3 : 0
wd 'psel ',HWNDP
wd 'set siz text *',fmtsize BOARD
del=. ( SCALE * |. BOARD) - _2 {. GXYWHX
if. 0 0 -: del do. return. end.
wd^:(-.'Android'-:UNAME) 'setwh g ',": _2{. GXYWHX + 0 0,del
wd^:(-.'Android'-:UNAME) 'pmove ',": MINFORMX >. FORMX + 0 0,del
)

NB. =========================================================
settimer=: 3 : 0
wd 'timer ',":TIMER * y
)

NB. =========================================================
setsystimer=: 3 : 0
if. y do.
  sys_timer_z_=: life__LIFELOC
else.
  settimer 0
  sys_timer_z_=: ]
end.
EMPTY
)
