NB. label

NB. =========================================================
NB. format labels
lab2html=: 3 : 0
if. 0 e. $y do. 0;'' return. end.

dat=. |: y
cnt=. #dat

rws=. th each fromsym {: dat

for_i. i. 1-cnt do.
  p=. cutparts i{dat
  n=. # &> p
  s=. fromsym {.each p
  rws=. (;n throwspan each s),.rws
end.

cnt;<rws
)