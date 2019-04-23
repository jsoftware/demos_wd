NB. illustrates events in J

require 'numeric trig'
coclass 'jevents'
coinsert 'jgl2'

TEXT=: 0 : 0
This form illustrates various events in J. Click the controls or press Enter to see the event messages generated.

A listbox or combobox generates select events when you scroll through the entries, and button events when an entry is double-clicked, or when you press Enter in the control. Turn off the select checkbox to see the listbox button events.

The isigraph window shows mouse events. Turn off the checkboxes to see more mouse events.
)

SHOWSEL=: 1
SHOWMMOVE=: 1
SHOWMBLDOWN=: 1
SHOWMBRDOWN=: 1
SHOWMBLUP=: 1
SHOWMBRUP=: 1
syseventlast=: ''

showme=: wdqshow

EVENTS=: 0 : 0
pc events nosize;pn "Events";
menupop "File";
menu new "&New" "" "" "";
menu open "&Open" "" "" "";
menusep;
menu exit "&Exit" "" "" "";
menupopz;
bin v;
groupbox "";
cc s0 static;
groupboxend;
bin h;
groupbox "Edit";
cc text edit;
groupboxend;
bin h;
groupbox "Options";
cc red radiobutton;cn "Red";
cc blue radiobutton group;cn "Blue";
groupboxend;
bin zzhv;
groupbox "Listbox";
minwh 121 118;cc list listbox;
cc showselect checkbox;cn "select";
groupboxend;
bin z;
groupbox "Isigraph";
bin h;
bin v;
cc showmmove checkbox;cn "mmove";
cc showmbldown checkbox;cn "mbldown";
cc showmblup checkbox;cn "mblup";
cc showmbrdown checkbox;cn "mbrdown";
cc showmbrup checkbox;cn "mbrup;
bin sz;
minwh 148 134;cc g isigraph flush;
bin z;
groupboxend;
bin zhs;
cc cancel button;cn "Cancel";
cc ok button;cn "OK";
bin zz;
pas 4 2;pcenter;
rem form end;
)

events_run=: 3 : 0
if. wdisparent 'events' do.
  wd^:('Android'-.@-:UNAME) 'psel events;pactive;pshow' return.
end.
wd EVENTS
wd 'set s0 text *',TEXT

wd 'set list items January February March April May June July August September October November December'
wd 'set list select 5'
wd 'set showselect value 1'
wd 'set showmmove value 1'
wd 'set showmbldown value 1'
wd 'set showmbrdown value 1'
wd 'set showmblup value 1'
wd 'set showmbrup value 1'
wd 'set red value 0'
wd 'set blue value 1'
wd 'pshow;'
events_isigraph''
)

NB. =========================================================
events_g_paint=: 3 : 0
wh=. 2}.wdqchildxywh 'g'
wh=. glqwh''
glrgb 0 255 255
glbrush''
glrect 0 0,wh
glpaint^:IFJA ''
)

NB. =========================================================
events_isigraph=: 3 : 0
glpaintx ''
)

NB. =========================================================
events_default=: 3 : 0

if. (sysevent -: 'events_g_focus') +. sysevent -: 'events_g_focuslost' do.
  if. sysevent -: syseventlast do. return. end.
end.

if. sysevent-:'events_showselect_button' do. SHOWSEL=: -. SHOWSEL end.
if. SHOWSEL < sysevent-:'events_list_select' do. return. end.

if. sysevent-:'events_showmmove_button' do. SHOWMMOVE=: -. SHOWMMOVE end.
if. SHOWMMOVE < sysevent-:'events_g_mmove' do. return. end.

if. sysevent-:'events_showmbldown_button' do. SHOWMBLDOWN=: -. SHOWMBLDOWN end.
if. SHOWMBLDOWN < sysevent-:'events_g_mbldown' do. return. end.

if. sysevent-:'events_showmbrdown_button' do. SHOWMBRDOWN=: -. SHOWMBRDOWN end.
if. SHOWMBRDOWN < sysevent-:'events_g_mbrdown' do. return. end.

if. sysevent-:'events_showmblup_button' do. SHOWMBLUP=: -. SHOWMBLUP end.
if. SHOWMBLUP < sysevent-:'events_g_mblup' do. return. end.

if. sysevent-:'events_showmbrup_button' do. SHOWMBRUP=: -. SHOWMBRUP end.
if. SHOWMBRUP < sysevent-:'events_g_mbrup' do. return. end.

if. -. sysevent -: 'events_cancel_button' do.
end.

if. (<sysevent) e. 'events_close';'events_cancel_button';'events_exit_button' do.
  if. 0= wdquery`0:@.('Android'-:UNAME) 'Events';'OK to close form?' do.
    try. wd 'psel events;pclose' catch. end.
  end.
end.

syseventlast=: sysevent
smoutput ": wdq
)

events_run ''
