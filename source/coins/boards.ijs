NB. boards
NB.
NB. stored as 4 items:
NB.   color      indices (first color has to move to empty space)
NB.   layout     xy pairs
NB.   positions  token positions as: color, layout index
NB.   moves      color, end 1, end 2

BOARDS=: '8-2-48';'8-3-44';'9-2-66';'11-2-118'
BOARDIDS=: 'b' (,":) each i.#BOARDS

NB. =========================================================
NB. board0 = 8-2-48

COLORS=: 0 1

LAYOUT=: getnum''
0 0
2 9
8 9
7 6
3 6
5 4
5 2
10 0
)

POS=: getnum''
0 0
0 6
1 1
1 3
1 4
1 5
1 7
)

MOVES=: getnum''
0 0 1
0 0 6
0 1 2
0 3 4
0 3 7
0 4 5
0 6 7
1 0 4
1 0 5
1 0 7
1 1 3
1 1 4
1 2 3
1 5 6
1 5 7
)

BOARD0=: COLORS;LAYOUT;POS;MOVES

NB. =========================================================
NB. board1 =  8-3-44

COLORS=: 3 2 0

LAYOUT=: getnum''
0 0
2 0
0 2
2 2
4 2
0 4
2 4
4 4
)

POS=: getnum''
0 7
1 5
1 6
2 1
2 2
2 3
2 4
)

MOVES=: getnum''
0 0 2
0 2 6
0 6 7
1 0 3
1 2 3
1 3 4
1 4 6
1 5 6
2 0 1
2 1 3
2 1 4
2 2 5
2 3 6
2 4 7
)

BOARD1=: COLORS;LAYOUT;POS;MOVES

NB. =========================================================
NB. board2 =  9-2-66

COLORS=: 1 0

LAYOUT=: getnum''
1 0
7 0
4 2
2 3
6 3
0 4
4 4
8 4
4 6
)

POS=: getnum''
0 0
0 2
1 1
1 4
1 5
1 6
1 7
1 8
)

MOVES=: getnum''
0 0 2
0 0 5
0 1 4
0 1 7
0 2 6
0 3 6
0 4 8
0 5 8
1 0 1
1 0 3
1 1 2
1 2 4
1 3 5
1 3 8
1 4 6
1 7 8
)

BOARD2=: COLORS;LAYOUT;POS;MOVES

NB. =========================================================
NB. board3 = 11-2-118

COLORS=: 1 0

LAYOUT=: getnum''
1 0
9 0
5 2
2 4
8 4
5 5
0 7
10 7
3 8
7 8
5 11
)

POS=: getnum''
0 2
0 5
1 0
1 1
1 3
1 4
1 6
1 7
1 8
1 9
)

MOVES=: getnum''
0 0 1
0 0 3
0 1 7
0 2 3
0 2 4
0 3 8
0 4 5
0 5 6
0 6 10
0 7 9
0 8 9
1 0 6
1 1 2
1 1 4
1 3 5
1 3 6
1 4 7
1 5 8
1 7 10
1 8 10
1 9 10
)

BOARD3=: COLORS;LAYOUT;POS;MOVES
