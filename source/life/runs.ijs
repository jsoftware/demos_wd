NB. runs

onStart=: run bind ''

NB. =========================================================
run=: 3 : 0
dat=. y
if. 0=#dat do.
  dat=. 'coerake1'
end.
if. ischar dat do.
  dat=. buildlif ". toupper dat
end.
runinit dat
rundoit dat
)

NB. =========================================================
rundoit=: 3 : 0
STATE=: ,y
COUNT=: 0
bufinit ''
settimer 0
draw''
)

NB. =========================================================
runinit=: 3 : 0
BOARD=: $ y
boardinit ''
TRANS=: buildtrans ''
setsystimer 0
life_run''
)

NB. =========================================================
runlife_z_=: 3 : 0
LIFELOC_z_=: conew 'jlife'
if. IFJA do.
  wd 'activity ', >LIFELOC
else.
  run__LIFELOC''
end.
)

NB. =========================================================
runlife''
