NB. file
NB.
NB. view and run lif file

NB. =========================================================
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
lif_quit_button=: lif_close

NB. =========================================================
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

NB. =========================================================
lif_close=: 3 : 0
wd 'pclose'
)

NB. =========================================================
lif_cancel_button=: lif_close

NB. =========================================================
lif_run_button=: 3 : 0
lif_close''
settimer 1
)

NB. =========================================================
readlif=: 3 : 0
dat=. 'b' fread y
if. 0 e. ('#Life 1.05';'#N') e. dat do.
  info 'Not a Life 1.05 file' return.
end.
buildlif dat
)
