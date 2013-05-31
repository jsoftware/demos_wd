NB. Windows Controls
NB.
NB. examples of windows controls

require 'droidwd'
coclass 'wincontroldemo'
coinsert 'wdbase'
droidwd_run=: wincontrol_run

p=. jpath '~addons/demos/wd/control'
0!:0 p&, each '1.ijs';'2.ijs';'3.ijs'

WINCONTROL=: 0 : 0
pc wincontrol;
menupop "File";
menu new "&New" "Ctrl+N" "help for new" "new tip";
menu open "&Open" "Ctrl+O" "help for open" "open tip";
menusep;
menu exit "&Exit" "" "exit" "exit tip";
menupopz;
cc tools toolbar;
set tools add new "new" "TOOLBAR/new.png";
set tools add open "open" "TOOLBAR/open.png";
set tools addsep;
set tools add print "print" "TOOLBAR/print.png";
set tools add query "what would you like to know" "TOOLBAR/about.png";
bin v;
bin hs;
cc ok button;cn "OK";
cc cancel button;cn "Cancel";
bin z;
minwh 440 282;cc tabs tab;
bin z;
cc sbar statusbar;
set sbar addlabel status;
set sbar addlabel sinfo;
set sbar addlabel scrud;
pas 6 6;pcenter;
rem form end;
)

NB. =========================================================
wincontrol_run=: 3 : 0

wd WINCONTROL rplc 'TOOLBAR'; jpath '~addons/ide/qt/images'
wd 'set sbar setlabel status "basic help message"'

wd 'tabnew buttons'
buttons_run''
wd 'tabnew edits'
edits_run''
wd 'tabnew selects'
selects_run''
wd 'set tabs active 0'
wd 'pshow'
)

wincontrol_close=: wd bind 'pclose'
wincontrol_cancel_button=: wincontrol_close
wincontrol_ok_button=: wincontrol_cancel_button

wincontrol_new_button=: 3 : 0
wd 'set sbar setlabel sinfo *',syschild
)

wincontrol_open_button=: 3 : 0
wd 'set sbar setlabel sinfo *',syschild
)

wincontrol_exit_button=: 3 : 0
wd 'set sbar setlabel sinfo *',syschild
)

wincontrol_print_button=: 3 : 0
wd 'set sbar setlabel sinfo *',syschild
)

wincontrol_query_button=: 3 : 0
wd 'set sbar setlabel sinfo *',syschild
)

wincontrol_run`start_droidwd@.IFJCDROID coname''
