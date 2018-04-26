NB. life

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
minwh 640 512;cc g isigraph flush;
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
wh _1 _1;cc g isigraph flush;
bin z;
pas 0 0;pcenter;
rem form end;
)

NB. =========================================================
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

NB. =========================================================
life_close=: 3 : 0
sys_timer_z_=: ]
wd 'timer 0'
wdx 'pclose'
codestroy''
)

NB. =========================================================
life_default=: 3 : 0
if. (<syschild) e. LIFS do.
  settimer 0
  rundoit buildlif ". toupper syschild
end.
)

NB. =========================================================
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

NB. =========================================================
life_random_button=: 3 : 0
settimer 0
STATE=: 0 = ? (#STATE)#10
step ''
rundoit STATE
)

NB. =========================================================
life_step_button=: 3 : 0
settimer 0
RUN=: 1
life''
RUN=: MINRUN
)

NB. =========================================================
life_g_paint=: drawit

NB. =========================================================
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

NB. =========================================================
enableback=: 3 : 0
wd 'setenable stepback ',":HASBUF
)

life_about_button=: 3 : 'info ABOUT'
life_cfg_button=: wcfg_run
life_help_button=: 3 : 'info HELP'
life_exit_button=: life_close
life_pause_button=: settimer bind 0
life_run_button=: settimer bind 1
