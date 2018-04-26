NB. header

NB. =========================================================
NB. format headers
hdr2html=: 4 : 0
if. 0 e. $y do. '' return. end.

dat=. |: y
cnt=. #dat

pfx=. x thcolspan ''

r=. ''
for_i. i.cnt-1 do.
  p=. cutparts i{dat
  n=. # &> p
  s=. fromsym {.each p
  r=. r,<;n thcolspan each s
end.

r=. r,<;th each fromsym {:dat
r=. (<pfx) ,each r
;tr each r
)
