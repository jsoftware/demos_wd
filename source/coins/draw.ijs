NB. draw

FATPEN=: 6,PS_SOLID

NB. =========================================================
NB. triggers paint event
paint=: 3 : 0
glpaint''
)

NB. =========================================================
draw=: 3 : 0
drawcenters''
drawnet''
drawhighs''
wd 'set cnt text ',":BUFNDX
wd 'setenable restart ',":COUNT > 0
wd 'setenable undo ',":BUFNDX > 0
wd 'setenable redo ',":BUFNDX < COUNT
NB. android optionmenu not yet created
wd^:(-.IFJA) ; ';set '&, each BOARDIDS ,each (<' checked ') ,each ": each BOARD=i.#BOARDS
wd 'setfocus g'
getmoves''
ACTIVECTR=: ACTIVE { CTR
glpaintx^:IFJA ''  NB. asyncj
)

NB. =========================================================
NB. drawcenters v calculate vertex centers in display
drawcenters=: 3 : 0
max=. >./ LAYOUT
wh=. _2 {. wdqchildxywh 'g'
wh=. glqwh''
div=. wh % 2 + max
rad=. -: <./div <. wh % 12
RAD=: roundint rad
RAD2=: 0 >. RAD - 5 >. 2 round 0.2 * rad
x=. ({.div) * 1 + {."1 LAYOUT
y=. ({:div) * 1 + ({:max) - {:"1 LAYOUT
CTR=: roundint x,.y
)

NB. =========================================================
drawhigh=: 3 : 0
HIGH=: POS where ({:"1 POS) e. y
paint''
)

NB. =========================================================
drawhighs=: 3 : 0
for_p. HIGH do.
  'c x'=. p
  glbrush glrgb c { CLRHIGH
  glrect"1 x { CRC2
end.
)

NB. =========================================================
NB. drawnet v draw the network
drawnet=: 3 : 0
glclear''
glfill 255 255 255 255
mxy=. MOVECLR </. MOVEPOS

NB. lines
for_i. i.#mxy do.
  glpen FATPEN [ glrgb i { CLRSTD
  gllines"1 ,"2 CTR {~ i pick mxy
end.

NB. vertices
CRC=: (CTR-RAD) ,"1 +:RAD,RAD
glpen 1,PS_SOLID [ glrgb 0 0 0
glbrush glrgb 255 255 255
glrect"1 CRC

NB. end vertex
glpen FATPEN [ glrgb {.CLRSTD
glrect 0 0 1 1 + ENDPOS { CRC

NB. tokens
glpen 1,PS_SOLID [ glrgb 0 0 0
CRC2=: (CTR-RAD2) ,"1 +:RAD2,RAD2
for_i. i.#mxy do.
  glbrush glrgb i { CLRSTD
  glrect"1 (i lookup POS) { CRC2
end.
)
