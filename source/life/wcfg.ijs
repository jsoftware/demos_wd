NB. life configuration

COUNTS=: 0 : 0
The undo buffer takes one byte per cell per iteration, e.g. 1 MB for 1024x1024 cells. Reduce the buffer size for large boards and limited memory.
)

RUNS=: 0 : 0
The minimum run is the number of steps taken without interruption. The delay is the time in milliseconds for the interrupt.
For example, set run to 1 and delay to 1000 to step every second.
)

STDSIZES=: 64 128 256 512 1024
STDRATIOS=: 1 1.25 1.5 2

WCFG=: 0 : 0
pc wcfg owner;pn "Life Config";
menupop "&File";
menu quit "&Quit" "Ctrl+Q" "" "";
menupopz;
bin v;
bin h;
bin v;
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
bin hv;
cc s4 static;cn "Cells:";
cc s5 static;cn "Scale:";
cc s6 static;cn "Pixels:";
bin szv;
cc ecells edit;
cc escale combolist;
cc snewpixels static;cn "712 x 712";
bin szz;
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
bin v;
bin v;
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
cc s8 static;cn "Max Buffer:";
cc emaxbuf edit;
cc s10 static;cn "default = 100";
cc s7 static;cn "Max Iterations:";
cc emaxiter edit;
cc s9 static;cn "empty if none";
groupboxend;
groupbox "Run";
cc srun static;
cc s11 static;cn "Min Run:";
cc eminrun edit;
cc s11 static;cn "default = 10";
cc s11 static;cn "Delay:";
cc etimer edit;
cc s12 static;cn "default = 1";
cc s20 static;cn "Board:";
groupboxend;
bin z;
pas 4 4;pcenter;
rem form end;
)
wcfg_quit_button=: wcfg_close

wcfg_run=: 3 : 0
Nboard=: BOARD
Nscale=: SCALE
Nmaxiter=: MAXITER
Nmaxbuf=: MAXBUF
Nminrun=: MINRUN
Ntimer=: TIMER
Nbcolor=: BOARDCOLOR
Nccolor=: CELLCOLOR
wd WCFG
wd 'set scells text *',fmtsize BOARD
wd 'set sscale text *',": SCALE
wd 'set spixels text *',fmtsize BOARD * SCALE
wd 'set escale items ',": 1 + i.8
wd 'set scount text *',COUNTS
wd 'set srun text *',RUNS
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
MINRUN=: Nminrun
RUN=: MINRUN
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
Nmaxbuf=. 0 ". emaxbuf
Nminrun=: 1 >. 0 ". eminrun
Nmaxiter=: {. (0 ". emaxiter),_
Ntimer=: 1 >. 0 ". etimer
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
wd 'set eminrun text ',":Nminrun
wd 'set etimer text ',":Ntimer
wd 'set bcolor text *',":Nbcolor
wd 'set ccolor text *',":Nccolor
)

wcfg_default=: wcfg_reshow

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
