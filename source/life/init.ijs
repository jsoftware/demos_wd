NB. init
NB.
NB. life rules
NB. For a space that is occupied:
NB.     Each cell with one or no neighbors dies
NB.     Each cell with four or more neighbors dies
NB.     Each cell with two or three neighbors survives.
NB. For a space that is empty:
NB.     Each cell with three neighbors becomes populated.
NB.
NB. Each step is computed as follows:
NB.
NB. STATE=: TRANS {~ #. INDEX { STATE
NB.
NB. Suppose n is the number of cells in the board.
NB. STATE is the ravelled board, a boolean of length n with 1=alive.
NB. INDEX is a n x 9 table of indices that gives the 9 surrounding cells for each cell.
NB. TRANS is a list of length 512=2^9, that gives the new life state for each old value.

require 'gl2'
coclass 'jlife'
coinsert 'jgl2'

SCALE=: 3 : 0''
if. 'Android'-:UNAME do.
  DM_density_ja_=: {. ". wd 'dm'
  2*DM_density_ja_
else.
  4
end.
)
BOARD=: 128 160
PATH=: ''
TIMER=: 1
MAXITER=: _
MAXBUF=: 100
MINRUN=: 10
RUN=: MINRUN
COUNT=: 0
BOARDCOLOR=: 0 128 128
CELLCOLOR=: 255 255 0
COLORMB=: 48$255
HASBUF=: 0
HWNDP=: 0
FILE=: ''

create=: ]
destroy=: life_close
