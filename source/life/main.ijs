NB. main

NB. =========================================================
life=: 3 : 0
whilst. RUN | COUNT do.
  buffer''
  step''
  draw''
end.
)

NB. =========================================================
draw=: 3 : 0
if. _1=4!:0<'STATE' do. return. end.
wd 'psel ',HWNDP
glsel 'g'
wd 'set cnt text ',":COUNT
wd 'setenable stepback ',":HASBUF
if. COUNT >: MAXITER do.
  settimer 0 return.
end.
glpaint''
)

NB. =========================================================
drawit=: 3 : 0
glclear''
glrgb BOARDCOLOR
glbrush''
glrect 0 0,SCALE*|.BOARD
glrgb CELLCOLOR
glbrush''
glpen 1 1
if. _1=4!:0<'STATE' do. glpaintx^:IFJA '' return. end.
if. SCALE > 1 do.
  glrect"1 STATE#RECTS
else.
  glpixel"1[ 2 {."1 STATE#RECTS
end.
glpaintx^:IFJA ''
)

NB. =========================================================
3 : 0''
life_g_paint=: 3 : 'if. 0=RUN|COUNT do. draw'''' end.'
EMPTY
)

NB. =========================================================
step=: 3 : 0
STATE=: TRANS {~ #. INDEX { STATE
COUNT=: >: COUNT
)
