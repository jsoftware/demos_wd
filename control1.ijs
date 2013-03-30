NB. control1.ijs  - buttons
NB.
NB. standard controls, called by control.ijs

BUTTONS=: 0 : 0
bin h;
bin v;
groupbox "Radio Buttons";
bin hv;
cc active radiobutton;cn "Active";
cc inactive radiobutton group;cn "Inactive";
cc done radiobutton group;cn "Done";
bin z;
cc bradios button;cn "";
bin sz;
groupboxend;
groupbox "Check Buttons";
bin hv;
cc checkin checkbox;cn "Checked In";
cc checkout checkbox;cn "Checked Out";
bin z;
cc bcheck button;cn "";
bin sz;
groupboxend;
bin z;
bin s;
bin v;
bin s;
bin h;
cc ordpushbutton button;cn "Pushbutton";
cc bpush button;cn "";
bin sz;
bin s;
bin h;
cc odpushbutton image;
cc bod button;cn "";
bin sz;
bin z;
bin z;
)

NB. =========================================================
wdbuttons=: sminfo @ ('button definition'&;)

buttons_run=: 3 : 0
wd BUTTONS
PATH=. jpath '~addons/demos/wd/'
wd 'set odpushbutton image *',PATH,'j.bmp'
)

wincontrol_bradios_button=: wdbuttons bind (0 : 0)
wd 'groupbox "Radio Buttons"'
wd 'cc active radiobutton;cn "Active"'
wd 'cc inactive radiobutton group;cn "Inactive"'
wd 'cc done radiobutton group;cn "Done"'
wd 'groupboxend'
)

wincontrol_bcheck_button=: wdbuttons bind (0 : 0)
wd 'groupbox "Check Buttons"'
wd 'cc checkin checkbox;cn "Checked In"'
wd 'cc checkout checkbox;cn "Checked Out"'
wd 'groupboxend'
)

wincontrol_bpush_button=: wdbuttons bind (0 : 0)
wd 'cc ordpushbutton button;cn "Pushbutton"'
)

wincontrol_bod_button=:  wdbuttons bind (0 : 0)
wd 'cc odpushbutton image'
)
