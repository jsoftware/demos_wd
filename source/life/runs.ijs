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
draw''
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
RUN=: MINRUN
loc=. >coname''
sys_timer_z_=: ('life_',loc,'_')~
life_run''
)

NB. =========================================================
runlife_z_=: 3 : 0
a=. conew 'jlife'
if. IFJA do.
  wd 'activity ', >a
else.
  run__a''
end.
)

NB. =========================================================
runlife''
