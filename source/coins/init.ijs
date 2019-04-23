NB. init

coclass 'jcoins'
coinsert 'jgl2'

onStart=: coins_run

BOARD=: 0

NB. =========================================================
init=: 3 : 0
getboard ''
ACTIVECTR=: -1000
DONE=: 0
HIGH=: ''
LASTAVAIL=: ''
BUFFER=: ,<POS
BUFNDX=: COUNT=: 0
MBRDOWN=: 0
RAD=: 0
getmoves''
ENDPOS=: AVAIL
EMPTY
)
