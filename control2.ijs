NB. control2.ijs  - edits

EDITS=: 0 : 0
bin v;
bin h;
cc edit edit;
cc bedit button;cn "";
bin sz;
bin s;
bin h;
cc editm editm;
cc beditm button;cn "";
bin sz;
bin z;
)

wdedits=: sminfo bind ('edit definition'&;)

edits_run=: 3 : 0
wd EDITS
wd 'set edit text *single line edit box'
wd 'set editm text *J Release 8',LF,'JQT IDE'
)

wincontrol_bedit_button=: wdedits bind (0 : 0)
wd 'cc edit edit'
)

wincontrol_beditm_button=: wdedits bind (0 : 0)
wd 'cc editm editm'
)
