coclass 'jlife'
coinsert 'jgl2'

SCALE=: 3 : 0''
if. 'Android'-:UNAME do.
  if. IFJA do.
    DM_density_ja_=: {. ". wd 'dm'
    2*DM_density_ja_
  else.
    2
  end.
else.
  4
end.
)

BOARD=: 128 160
PATH=: ''
TIMER=: 1
MAXITER=: _
MAXBUF=: 100
COUNT=: 0
BOARDCOLOR=: 0 128 128
CELLCOLOR=: 255 255 0
COLORMB=: 48$255
HASBUF=: 0
HWNDP=: 0
FILE=: ''

create=: ]
destroy=: life_close
fix=: 0: ". ];._2
info=: (sminfo @ ('Life'&;))`(wd @ ('textview *|Life||'&,))@.IFJA
ischar=: 2: = 3!:0
isempty=: 0: e. $
pathname=: 3 : '(b#y);(-.b=.+./\.''/''=jpathsep y)#y'
wdx=: wd :: ]
bufinit=: 3 : 0
BUF=: MAXBUF # a:
HASBUF=: 0
)
buffer=: 3 : 0
BUF=: }. BUF, <STATE
HASBUF=: 1
)
fmtsize=: 3 : 0
'r c'=. y
(":r),' x ',":c
)
iscolor=: 3 : 0
*./ (3=#y), y e. i. 256
)
mbcolor=: 3 : 0
new=. ,0 ". wd 'mb color ',":y,COLORMB
if. isempty new do. '' return. end.
COLORMB=: 3 }. new
3 {. new
)
put=: 3 : 0
'board pos new'=. y
ndx=. ($board) | each pos +each i.each $new
new (<ndx) } board
)
setformsize=: 3 : 0
wd 'psel ',HWNDP
wd 'set siz text *',fmtsize BOARD
del=. ( SCALE * |. BOARD) - _2 {. GXYWHX
if. 0 0 -: del do. return. end.
wd^:(-.IFJA) 'setwh g ',": _2{. GXYWHX + 0 0,del
wd^:(-.IFJA) 'pmove ',": MINFORMX >. FORMX + 0 0,del
)
settimer=: 3 : 0
wd 'timer ',":TIMER * y
)
setsystimer=: 3 : 0
if. y do.
  sys_timer_z_=: life__LIFELOC
else.
  settimer 0
  sys_timer_z_=: ]
end.
EMPTY
)
boardinit=: 3 : 0
INDEX=: buildneighbor BOARD
RECTS=: buildrect BOARD
)
buildlif=: 3 : 0
if. L. y do.
  dat=. y
else.
  dat=. a: -.~ <;._2 (toJ y),LF
end.
dat=. ((<'#P') = 2 {.each dat) <;.1 dat
pos=. (<.-:BOARD) (+|.) ("1) 0 ". 2 }. &> {.&> dat
blk=. ('*'"_ = >) @ }. each dat
m=. BOARD $ 0
for_i. i. # pos do.
  m=. put m;(i{pos);i{blk
end.
)
buildneighbor=: 3 : 0
m=. i. y
m=. ({:m),m,{.m
m=. ({:"1 m),.m,.{."1 m
m=. ,/ 3 [\"1 m
c2=. +: c=. {:y
((-c2) }. m) ,. (c }. (-c) }. m) ,. c2 }. m
)
buildrect=: 3 : 0
'r c'=. y
ndx=. ((r*c) $ i. c),.c # i. r
SCALE * ndx ,"1 [ 1 1
)
buildtrans=: 3 : 0
tab=. #: i. 2 ^ 9
cnt=. +/"1 tab
ctr=. 4 {"1 tab
new=. (ctr=0) *. cnt = 3
old=. (ctr=1) *. cnt e. 3 4
new +. old
)
LIFS=: ;: 'acorn bigun coerake1 glider glidergun puftrain rabbits relay spacegun spiral'
ACORN=: 0 : 0
#Life 1.05
#D Acorn
#D The most vigorously growing 7-cell
#D "methuselah" pattern.  See also RABBITS.
#N
#P -3 -1
.*
...*
**..***
)
BIGUN=: 0 : 0
#Life 1.05
#D Two-barrelled p46 glider gun
#D found by Bill Gosper.
#N
#P -9 -7
***
..*
..*
.*
.
.*
..*
..*
***
#P 6 -3
***
*
*
.*
.
.*
*
*
***
#P 23 -3
**
.*
#P -25 0
*
**
)
COERAKE1=: 0 : 0
#Life 1.05
#D p16 backward rake
#D A very simple construction: just
#D four *WSS and an extra cell.  By
#D Tim Coe, 1996.
#N
#P 4 -4
....**
****.**
.*****
..***
#P 5 2
.****
*...*
....*
...*
#P -6 -10
.******
*.....*
......*
.....*
#P -4 5
....**
****.**
******
.****
)
GLIDER=: 0 : 0
#Life 1.05
#D Glider
#N
#P -3 -1
.*
..*
***
)
GLIDERGUN=: 0 : 0
#Life 1.05
#D p30 glider gun (the Original)
#D
#D This is made of two of a pattern
#D know as the "queen bee", which
#D sometimes occurs naturally,
#D whose debris can be deleted on
#D the sides by blocks or eaters.
#D But a collision in the center
#D can, as seen here, miraculously
#D form a glider. Just one of these
#D moving back and forth is called
#D piston (see the p30 in OSCSPN2).
#N
#P 4 -5
....*
.****
****
*..*
****
.****
....*
#P 13 -4
*
*
#P -6 -3
..*
.*.*
*...**
*...**
*...**
.*.*
..*
#P 17 -2
**
**
#P -17 0
**
**
)

PUFTRAIN=: 0 : 0
#Life 1.05
#D Puffer train
#D
#D This was created simply by perturbing
#D the sides of a B-heptomino with two
#D LWSS's.  A B-heptomino is a naturally
#D occurring object that lurches forward at
#D the speed c/2 before its own debris
#D usually destroys it.  Not here!  The
#D LWSS keep it alive.  See BHEPTO, RAKE,
#D RAKE2.  For a super dirty puffer, see
#D LINEPUF.
#N
#P -2 -8
...*
....*
*...*
.****
#P -2 -1
*
.**
..*
..*
.*
#P -2 6
...*
....*
*...*
.****
)
RABBITS=: 0 : 0
#Life 1.05
#D Rabbits
#D Another small but vigorously growing population.
#D (If you look closely you can see a male and female rabbit!)
#D Andrew Trevorrow discovered Rabbits in 1986 using a
#D Methuselah search program.
#N
#P -3 -1
*...***
***..*
.*
)
RELAY=: 0 : 0
#Life 1.05
#D Relay with pit stops
#D Authors: David Bell, Dean Hickerson.
#N
#P -56 -60
***
*
.*
#P -61 -59
**
...*
*
....*
....*
.
..**
.*
#P -70 -61
....**
...***
*.**
*..*
*.**
...***
....**
#P -77 -58
**
**
#P -63 -49
**...**
**...**
.*****
..*.*
.
..***
#P -65 -40
..**
...*
***
*
#P -61 -38
..**
.*.*
.*
**
#P -52 -43
...*
..**
.**
***
.**
..**
...*
#P -45 -41
**
**
**
.
.
***
***
#P -47 -31
**...**
.*****
..***
...*
#P -49 -22
..**
...*
***
*
#P -45 -20
..**
.*.*
.*
**
#P -33 -25
*
*.*
.*.*
.*..*
.*.*
*.*
*
#P -31 -17
...*
..*.*
.*...*
..***
**...**
#P -33 -4
..**
...*
***
*
#P -29 -2
..**
.*.*
.*
**
#P -20 -7
**
***
..**.*
..*..*
..**.*
***
**
#P -15 3
..***
.
..*.*
.*****
**...**
**...**
#P -15 11
...*
.**
.
*
.
.*..*
...**
#P 54 57
.*
..*
***
#P 57 51
...*
.**
.
*
*
....*
.*
...**
#P 65 54
**
***
..**.*
..*..*
..**.*
***
**
#P 76 56
**
**
#P 57 43
..***
.
..*.*
.*****
**...**
**...**
#P 62 36
...*
.***
*
**
#P 58 34
..**
..*
*.*
**
#P 49 36
*
**
.**
.***
.**
**
*
#P 43 34
***
***
.
.
.**
.**
.**
#P 41 27
...*
..***
.*****
**...**
#P 46 18
...*
.***
*
**
#P 42 16
..**
..*
*.*
**
#P 29 18
....*
..*.*
.*.*
*..*
.*.*
..*.*
....*
#P 25 12
**...**
..***
.*...*
..*.*
...*
#P 30 0
...*
.***
*
**
#P 26 -2
..**
..*
*.*
**
#P 15 0
....**
...***
*.**
*..*
*.**
...***
....**
#P 9 -9
**...**
**...**
.*****
..*.*
.
..***
#P 11 -18
**
*..*
.
....*
.
..**
.*
)
SPACEGUN=: 0 : 0
#Life 1.05
#D Lightweight Spaceship gun
#D by Dieter Leithner, Oct 1993
#N
#P -22 -13
**
**
.
.
.
.
.
.
**
**
#P -5 -21
*
**
.**
**
.
.
.
**
.**
**
*
#P 8 -17
***
*
*
.*
.
.*
*
*
***
#P 25 -17
**
**
#P -23 12
**.*...*.**
*..*...*..*
.***...***
#P -26 19
**.............**
**..**.....**..**
....**.....**
)
SPIRAL=: 0 : 0
#Life 1.05
#D Spiral decay
#D A glider's work is never done.
#D Dean Hickerson, dean@ucdmath.ucdavis.edu  4/10/91
#N
#P -15 -27
.*
***
*.**
.***
.**
#P -10 -25
...*
..***
.**..*
.**.**
.*..***
..*.**
....*
*...*
.*.*
..*
#P -1 -27
.*
***
*.**
.***
.**
#P -16 -18
.***
*..*
...*
...*
..*
#P 23 -14
.****
*...*
....*
*..*
#P 20 -9
.**
*****
*....*
***..*
.*..**
..**
#P 23 0
.****
*...*
....*
...*
#P 15 -14
..**
**.**
****
.**
#P 3 22
.**
.***
*.**
***
.*
#P 9 17
...*
.**.**
.
*.*...*
*...*
**..*
.***
..*
#P 17 22
.**
.***
*.**
***
.*
#P 16 13
..*
...*
...*
*..*
.***
#P -28 16
.*..*
*
*...*
****
#P -28 2
.*
*
*...*
****
#P -26 9
..**
**..*
*..***
*....*
.*****
...**
#P -20 16
..**
.****
**.**
.**
#P -10 1
****
*...*
*
.*
#P 0 -9
..*
.***
**.*
***
.**
#P 5 1
...*
....*
*...*
.****
#P 0 4
.**
***
**.*
.***
..*
#P -7 6
.*
*.*
.**
#P -4 -4
.*
*.*
**
#P 4 -3
**
*.*
.*
#P 0 -1
.*
.**
*.*
)
LIF=: 0 : 0
pc lif owner;
menupop "&File";
menu quit "&Quit" "Ctrl+Q" "" "";
menupopz;
cc run button;cn "&Run";
cc cancel button;cn "&Cancel";
minwh 500 300;cc e editm readonly;
pas 0 0;
rem form end;
)
lif_run=: 3 : 0
wd LIF
wd 'pn "',NAME,'"'
dat=. 'b' fread FILE
dat=. dat #~ (<'#D') = 2 {.each dat
dat=. }: ; 3 }. each dat ,each LF
wd 'set e text *',dat
wd 'setfont e ',FIXFONT
wd 'setscroll e 0'
wd 'setfocus e'
wd 'pshow;'
)
lif_close=: 3 : 0
wd 'pclose'
)
lif_cancel_button=: lif_close
lif_quit_button=: lif_close
lif_run_button=: 3 : 0
lif_close''
settimer 1
)
readlif=: 3 : 0
dat=. 'b' fread y
if. 0 e. ('#Life 1.05';'#N') e. dat do.
  info 'Not a Life 1.05 file' return.
end.
buildlif dat
)
ABOUT=: 0 : 0
This is Conway's Game of Life. The rules are:

For a space that is occupied:
    Each cell with one or no neighbors dies
    Each cell with four or more neighbors dies
    Each cell with two or three neighbors survives.
For a space that is empty:
    Each cell with three neighbors becomes populated.

The pattern examples are taken from Al Hensel's collection, lifep.zip. If this is installed, each file can be loaded from the File menu. See:

   http://www.ibiblio.org/lifepatterns

There are many versions of Life in J. For example, see Cliff Reiter's Vector article (V21.3) on colored life, with scripts at:

   http://ww2.lafayette.edu/~reiterc/j/vector

)
HELP=: 0 : 0
Menus:

File|Load Pattern File... reads Life 1.05 pattern files.

File|Configure... sets various options.

Patterns has several built-in patterns.

Buttons:
Back and Step move one step at a time. Back uses a buffer, default size 100 steps.

Code:
See help file: User Manual|Project Manager|Example: Life Project.

)
life=: 3 : 0
if. COUNT >: MAXITER do. setsystimer 0 return. end.
buffer''
step''
draw''
)
draw=: 3 : 0
if. _1=4!:0<'STATE' do. return. end.
wd 'psel ',HWNDP
wd 'set cnt text ',":COUNT
wd 'setenable stepback ',":HASBUF
drawit''
)
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
step=: 3 : 0
STATE=: TRANS {~ #. INDEX { STATE
COUNT=: >: COUNT
)
COUNTS=: }:0 : 0
The undo buffer takes one byte per cell per iteration, e.g. 1 MB for 1024x1024 cells. Reduce the buffer size for large boards and limited memory.
)

STEPTIME=: }:0 : 0
The step time is the time in milliseconds for each step, default 1.
)

STDSIZES=: 64 128 256 512 1024
STDRATIOS=: 1 1.25 1.5 2

WCFG=: 0 : 0
pc wcfg owner;pn "Life Config";
menupop "&File";
menu quit "&Quit" "Ctrl+Q" "" "";
menupopz;
bin vhv;
groupbox "Current Size";
bin hv;
cc s0 static;cn "Cells:";
cc s2 static;cn "Scale:";
cc s3 static;cn "Pixels:";
bin szv;
cc scells static;cn "256 x 256";
cc sscale static;cn "3";
cc spixels static;cn "712 x 712";
bin szz;
groupboxend;
groupbox "New Size";
bin vg;
grid shape 3 2;
cc s4 static;cn "Cells:";
cc ecells edit;
cc s5 static;cn "Scale:";
cc escale combolist;
cc s6 static;cn "Pixels:";
cc snewpixels static;cn "712 x 712";
bin zvszz;
groupboxend;
bin z;
groupbox "Standard cell sizes";
bin hv;
cc s25 static;cn "Rows:";
cc b64 radiobutton;cn "64";
cc b128 radiobutton group;cn "128";
cc b256 radiobutton group;cn "256";
cc b512 radiobutton group;cn "512";
cc b1024 radiobutton group;cn "1024";
bin szv;
cc s26 static;cn "Cols:Rows";
cc bc1 radiobutton;cn "1";
cc bc125 radiobutton group;cn "1.25";
cc bc15 radiobutton group;cn "1.5";
cc bc2 radiobutton group;cn "2";
bin szz;
cc bfd button;cn "Best fit to desktop";
groupboxend;
bin vv;
cc ok button;cn "OK";
cc cancel button;cn "Cancel";
bin sz;
groupbox "Colors";
cc s22 static;cn "RGB triples:";
cc bcolor edit;
cc bbcolor button;cn ">>";
cc c21 static;cn "Cell:";
cc ccolor edit;
cc bccolor button;cn ">>";
groupboxend;
bin szz;
groupbox "Counts";
cc scount static;
bin hg;
grid shape 3 2;
cc s8 static;cn "Max Buffer:";
cc s7 static;cn "Max Iterations:";
maxwh 150 100;
cc emaxbuf edit;
maxwh 150 100;
cc emaxiter edit;
cc s10 static;cn "default = 100";
cc s9 static;cn "empty if none";
bin zsz;
groupboxend;
groupbox "Step Time";
bin v;
cc srun static;
bin h;
cc s11 static;cn "Time:";
maxwh 150 100;
cc etimer edit;
bin szz;
groupboxend;
bin z;
pas 4 4;pcenter;
rem form end;
)

wcfg_run=: 3 : 0
Nboard=: BOARD
Nscale=: SCALE
Nmaxiter=: MAXITER
Nmaxbuf=: MAXBUF
Ntimer=: TIMER
Nbcolor=: BOARDCOLOR
Nccolor=: CELLCOLOR
wd WCFG
wd 'set scells text *',fmtsize BOARD
wd 'set sscale text *',": SCALE
wd 'set spixels text *',fmtsize BOARD * SCALE
wd 'set escale items ',": 1 + i.8
wd 'set scount text *',COUNTS
wd 'set srun text *',STEPTIME
wcfg_noratio''
wcfg_nosize''
wcfg_show''
wd 'pshow;'
)

wcfg_bbcolor_button=: 3 : 0
c=. mbcolor Nbcolor
if. #c do.
  Nbcolor=: c
  wcfg_show''
end.
)

wcfg_bccolor_button=: 3 : 0
c=. mbcolor Nccolor
if. #c do.
  Nccolor=: c
  wcfg_show''
end.
)

wcfg_bfd_button=: 3 : 0
Nboard=: |. <. MAXXYWHX % Nscale
wcfg_show''
)

wcfg_close=: 3 : 0
wdx 'psel wcfg;pclose'
)

wcfg_quit_button=: wcfg_close

wcfg_newratio=: 3 : 0
Nboard=: ({.Nboard) * 1,y
wcfg_show''
)

wcfg_newrows=: 3 : 0
ratio=. 1 1.25 1.5 2 1 {~ (bc1,bc125,bc15,bc2) i. '1'
Nboard=: y * 1,ratio

wcfg_show''
)

wcfg_noratio=: 3 : 0
wd 'set bc1 value 0;set bc125 value 0;set bc15 value 0;set bc2 value 0'
)

wcfg_nosize=: 3 : 0
wd 'set b64 value 0;set b128 value 0;set b256 value 0;set b512 value 0;set b1024 value 0;'
)

wcfg_ok_button=: 3 : 0
if. -. wcfg_read'' do. return. end.
MAXITER=: Nmaxiter
MAXBUF=: Nmaxbuf
TIMER=: Ntimer
BOARDCOLOR=: Nbcolor
CELLCOLOR=: Nccolor
wcfg_close''
if. (-.Nboard -: BOARD) +. Nscale ~: SCALE do.
  STATE=: ,Nboard {. BOARD $ STATE
  BOARD=: Nboard
  SCALE=: Nscale
  boardinit ''
  setformsize ''
  wdfit''
end.
draw''
)

wcfg_read=: 3 : 0
board=. 0 ". ' ' (I. ecells e. ',xX') } ecells
if. (2 ~: #board) > board -: <. board do.
  info 'Board size should be two integers'
  0 return.
end.

bclr=. 0 ". bcolor
if. -.iscolor bclr do.
  info 'Board color should be three integers (RGB)'
  0 return.
end.
cclr=. 0 ". ccolor
if. -.iscolor cclr do.
  info 'Cell color should be three integers (RGB)'
  0 return.
end.
Nboard=: board
Nbcolor=: bclr
Nccolor=: cclr
Nscale=: 1 + 0 ". escale_select
Nmaxbuf=. {. 0 ". emaxbuf
Nmaxiter=: {. (0 ". emaxiter),_
Ntimer=: 1 >. {. 0 ". etimer
1
)

wcfg_reshow=: 3 : 0
wcfg_read''
wcfg_show''
)

wcfg_show=: 3 : 0
wd 'set ecells text *',fmtsize Nboard
wd 'set escale select ',": Nscale-1
wd 'set snewpixels text *',fmtsize Nboard * Nscale
ndx=. STDSIZES i. {. Nboard
if. ndx < #STDSIZES do.
  wd 'set b',(":2^6+ndx),' value 1'
else.
  wcfg_nosize''
end.
ndx=. STDRATIOS i. ({:%{.) Nboard
if. ndx < #STDRATIOS do.
  wd 'set bc',(ndx pick '1';'125';'15';'2'),' value 1'
else.
  wcfg_noratio''
end.
wd 'set emaxiter text ',(Nmaxiter ~: _) # ":Nmaxiter
wd 'set emaxbuf text ',":Nmaxbuf
wd 'set etimer text ',":Ntimer
wd 'set bcolor text *',":Nbcolor
wd 'set ccolor text *',":Nccolor
)

wcfg_b64_button=: wcfg_newrows bind 64
wcfg_b128_button=: wcfg_newrows bind 128
wcfg_b256_button=: wcfg_newrows bind 256
wcfg_b512_button=: wcfg_newrows bind 512
wcfg_b1024_button=: wcfg_newrows bind 1024

wcfg_bc1_button=: wcfg_newratio bind 1
wcfg_bc125_button=: wcfg_newratio bind 1.25
wcfg_bc15_button=: wcfg_newratio bind 1.5
wcfg_bc2_button=: wcfg_newratio bind 2

wcfg_cancel_button=: wcfg_close
wcfg_cancel=: wcfg_close
onStart=: life_run

LIFE=: 0 : 0
pc life nosize;pn "Life";
menupop "File";
menu load "&Load Pattern File..." "" "" "";
menusep;
menu cfg "&Configure..." "" "" "";
menusep;
menu exit "&Exit" "" "" "";
menupopz;
menupop "Patterns";
menu acorn "&Acorn" "" "" "";
menu bigun "&Bi-Gun" "" "" "";
menu glider "Glider" "" "" "";
menu glidergun "&Glider Gun" "" "" "";
menu puftrain "&Puffer Train" "" "" "";
menu rabbits "&Rabbits" "" "" "";
menu coerake1 "Rake" "" "" "";
menu relay "Relay" "" "" "";
menu spacegun "Space Gun" "" "" "";
menu spiral "Spiral Decay" "" "" "";
menusep;
menu random "&Random" "" "" "";
menupopz;
menupop "Help";
menu help "&Help" "" "" "";
menusep;
menu about "&About" "" "" "";
menupopz;
bin vh;
cc run button;cn "Run";
cc pause button;cn "Pause";
cc stepback button;cn "Back";
cc step button;cn "Step";
cc siz static center;cn "";
cc cnt static center;cn "";
bin z;
minwh 640 512;cc g isidraw flush;
bin z;
pas 0 0;pcenter;
rem form end;
)

LIFEJA=: 0 : 0
pc life nosize;pn "Life";
menupop "File";
menu load "&Load Pattern File..." "" "" "";
menusep;
menu exit "&Exit" "" "" "";
menupopz;
menupop "Patterns";
menu acorn "&Acorn" "" "" "";
menu bigun "&Bi-Gun" "" "" "";
menu glider "Glider" "" "" "";
menu glidergun "&Glider Gun" "" "" "";
menu puftrain "&Puffer Train" "" "" "";
menu rabbits "&Rabbits" "" "" "";
menu coerake1 "Rake" "" "" "";
menu relay "Relay" "" "" "";
menu spacegun "Space Gun" "" "" "";
menu spiral "Spiral Decay" "" "" "";
menusep;
menu random "&Random" "" "" "";
menupopz;
menupop "Help";
menu help "&Help" "" "" "";
menusep;
menu about "&About" "" "" "";
menupopz;
bin vh;
cc run button;cn "Run";
cc pause button;cn "Pause";
cc stepback button;cn "Back";
cc step button;cn "Step";
cc siz static center;cn "";
cc cnt static center;cn "";
bin z;
wh _1 _1;cc g isidraw flush;
bin z;
pas 0 0;pcenter;
rem form end;
)
life_run=: 3 : 0
wd IFJA{::LIFE;LIFEJA
if. HWNDP e. 1 {"1 wdforms'' do. return. end.
HWNDP=: wd 'qhwndp'
FORMX=: 0 ". wd 'qform'
GXYWHX=: 0 ". wd 'qchildxywh g'
MAXXYWHX=: _10 _100 + 2 3 { 0 ". wd 'qscreen'
MINFORMX=: 0 0,470 192 + _2 {. FORMX - GXYWHX
setformsize''
enableback 0
wdx 'picon intro\life.ico 0'
wdfit ''
wd 'pshow;'
)
life_close=: 3 : 0
sys_timer_z_=: ]
wd 'timer 0'
wdx 'pclose'
codestroy''
)
life_default=: 3 : 0
if. (<syschild) e. LIFS do.
  settimer 0
  rundoit buildlif ". toupper syschild
end.
)
life_load_button=: 3 : 0
fl=. mbopen '"Load *.lif File" "',PATH,'"  "Life (*.lif)|All Files (*.*)"'
if. 0=#fl do. return. end.
a=. readlif fl
if. 0=#a do. return. end.
rundoit a
FILE=: fl
'PATH NAME'=: pathname fl
lif_run ''
)
life_random_button=: 3 : 0
settimer 0
STATE=: 0 = ? (#STATE)#10
step ''
rundoit STATE
)
life_step_button=: 3 : 0
settimer 0
life''
)
life_g_paint=: drawit
life_stepback_button=: 3 : 0
settimer 0
if. HASBUF do.
  STATE=: _1 pick BUF
  BUF=: a:,}:BUF
  HASBUF=: * # _1 pick BUF
  COUNT=: COUNT - 1
  draw''
else.
  enableback 0
end.
)
enableback=: 3 : 0
wd 'setenable stepback ',":HASBUF
)
life_about_button=: 3 : 'info ABOUT'
life_cfg_button=: wcfg_run
life_help_button=: 3 : 'info HELP'
life_exit_button=: life_close
life_pause_button=: 3 : 0
settimer 0
)
life_run_button=: 3 : 0
settimer 1
setsystimer 1
life''
)
onStart=: run bind ''
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
rundoit=: 3 : 0
STATE=: ,y
COUNT=: 0
bufinit ''
settimer 0
draw''
)
runinit=: 3 : 0
BOARD=: $ y
boardinit ''
TRANS=: buildtrans ''
setsystimer 0
life_run''
)
runlife_z_=: 3 : 0
LIFELOC_z_=: conew 'jlife'
if. IFJA do.
  wd 'activity ', >LIFELOC
else.
  run__LIFELOC''
end.
)
runlife''
