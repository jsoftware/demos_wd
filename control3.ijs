NB. Windows Controls
NB. examples of  windows controls
NB. control3.ijs

SELECTS=: 0 : 0
bin h;
bin v;
bin h;
wh 114 70;cc bxlist listbox multiplesel;
cc blist button;cn "";
bin sz;
bin s;
bin h;
wh 114 78;cc combobox combobox;
cc bcombo button;cn "";
bin sz;
bin sz;
bin v;
bin h;
bin v;
bin h;
wh 128 28;cc track slider 2 0 1 5 100 7;
cc btrack button;cn "";
bin sz;
bin s;
bin h;
cc setprogress1 button;cn "<";
cc setprogress2 button;cn ">";
bin sz;
bin z;
bin h;
wh 28 128;cc trackv slider v 2 0 1 5 100 7;
cc btrackv button;cn "";
bin sz;
bin z;
bin h;
wh 128 28;cc progress progressbar 0 100 0;
cc bprog button;cn "";
bin z;
bin z;
bin z;
)

wdselects=: sminfo @ ('select definition'&;)

selects_run=: 3 : 0
wd SELECTS
setlistbox''
setcombobox''
setprogress''
)

setlistbox=: 3 : 0
NB. multiple select listbox with 4 items, initial selection=1
list=. ;:'apples bananas cherries dates'
wd 'set bxlist items ',;list ,each LF
)

setcombobox=: 3 : 0
NB. combobox with edit field, initial selectsion=0
words=. ;:'Goose Geese Moose Meese Tooth Teeth Booth Beeth'
wd 'set combobox items ',;words ,each LF
wd 'set combobox select 0;'
)

setprogress=: 3 : 0
NB. initial progress button
PROGRESS=: 0
)

wincontrol_setprogress1_button=: 3 : 0
PROGRESS=: 0 >. PROGRESS-8
wd 'set track pos ',":PROGRESS
wd 'set trackv pos ',":PROGRESS
wd 'set progress pos ',":PROGRESS
)

wincontrol_setprogress2_button=: 3 : 0
PROGRESS=: 100 <. PROGRESS+8
wd 'set track pos ',":PROGRESS
wd 'set trackv pos ',":PROGRESS
wd 'set progress pos ',":PROGRESS
)

wincontrol_blist_button=: wdselects bind (0 : 0)
wd 'cc bxlist listbox multiplesel'
list=. ;:'apples bananas cherries dates'
wd 'set bxlist items items ',;list ,each LF
)

wincontrol_bcombo_button=: wdselects bind (0 : 0)
wd 'cc combobox combobox'
words=. ;:'Goose Geese Moose Meese Tooth Teeth Booth Beeth'
wd  'set combobox items ',;words ,each LF
wd  'set combobox select 0;'
)

wincontrol_btrack_button=: wdselects bind (0 : 0)
wd 'cc track slider'
)

wincontrol_btrackv_button=: wdselects bind (0 : 0)
wd 'cc track slider v'
)

wincontrol_bprog_button=: wdselects bind (0 : 0)
wd 'cc progress progress'

NB. selects_setprogress2_button is defined as:
  PROGRESS=: 100 <. PROGRESS+8
  wd  'set track pos ',":PROGRESS
  wd  'set trackv pos ',":PROGRESS
  wd  'set progress pos ',":PROGRESS
)
