NB.cities demo -  windows program

CITIES=: 0 : 0
pc cities closeok;pn "City Distances";
bin hvh;
cc s0 static;cn "From:";
cc clist combolist;
bin zhv;
groupbox dist;
cc Kilometers radiobutton;
cc Miles radiobutton group;
groupboxend;
bin szv;
groupbox sort;
cc Alphabetic radiobutton;
cc Distance radiobutton group;cn "By Distance";
groupboxend;
bin szzzv;
cc ok button;cn "OK";
cc cancel button;cn "Cancel";
bin szsz;
pas 6 6;pcenter;
rem form end;
)

cities_run=: 3 : 0
cityread''
wd CITIES
if. IFQT do.  NB. TODO jqt LF bug
  wd 'set clist items ',; ('"'&,)&.> BNAMES,&.>'"'
else.
  wd 'set clist items *',;BNAMES,&.>LF
end.
wd 'set clist select ',":(#BNAMES)|.BNAMES i. <'Antwerp'
wd 'set Kilometers value 1'
wd 'set Alphabetic value 1'
wd 'pshow'
)

cities_cancel_button=: wd bind 'pclose'

cities_ok_button=: 3 : 0
ndx=. ".clist_select
if. 0=#ndx do.
  sminfo 'City not found'
  return.
end.
clistmsk=. ndx ~: i.#BNAMES
miles=. ".Miles
bydist=. ".Distance
txt=. cityfmt miles,bydist,ndx
hdr=. ' from ',(>ndx{BNAMES),':'
hdr=. (>miles{'Kilometers';'Miles'),hdr
textview 'City Distances';hdr;txt
)

cities_clist_button=: cities_ok_button
cities_enter=: cities_ok_button

cities=: cities_run
