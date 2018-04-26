NB. win


NB. =========================================================
FormHeader=: 0 : 0
pc isigriddemo escclose closeok;
pn Grid;
menupop "&File";
menu quit "&Quit";
menupopz;
menupop "&Gallery";
menu report "&Report";
menu cube "&Multi-Dimensional";
menu large "&Large";
menupopz;
menupop "&Help";
menu help "&Help on displayed Grid" "Ctrl+H";
menusep;
menu doc "&Grid Documentation";
menupopz;
)

NB. =========================================================
isigriddemo_cube_button=: 3 : 0
cubedemo''
)

NB. =========================================================
isigriddemo_help_button=: 3 : 0
wdinfo 'Grid Notes';(Grid,'help')~
)

NB. =========================================================
isigriddemo_doc_button=: 3 : 0
browse_j_ 'http://code.jsoftware.com/wiki/Guides/Window_Driver/ChildClasses/Isigrid'
)

NB. =========================================================
isigriddemo_large_button=: 3 : 0
largedemo''
)

NB. =========================================================
isigriddemo_report_button=: 3 : 0
reportdemo''
)

NB. =========================================================
isigriddemo_quit_button=: 3 : 0
wd 'pclose'
)
