NB. main

NB. =========================================================
life=: 3 : 0
if. COUNT >: MAXITER do. setsystimer 0 return. end.
buffer''
step''
draw''
)

NB. =========================================================
draw=: 3 : 0
if. _1=4!:0<'STATE' do. return. end.
wd 'psel ',HWNDP
wd 'set cnt text ',":COUNT
wd 'setenable stepback ',":HASBUF
drawit''
)

NB. =========================================================
drawit=: 3 : 0
glsel 'g'
glfill BOARDCOLOR,255
if. _1=4!:0<'STATE' do. empty glpaintx'' return. end.
glbrush glrgb CELLCOLOR
glpen 1 1
if. SCALE > 1 do.
  glrect"1 STATE#RECTS
else.
  glpixel"1[ 2 {."1 STATE#RECTS
end.
empty glpaintx''
)

NB. =========================================================
step=: 3 : 0
STATE=: TRANS {~ #. INDEX { STATE
COUNT=: >: COUNT
)
