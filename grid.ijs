
coclass 'jgriddemo'

Formp=: ''

intersect=: e. # [
SOH=: 1{a.
toSOH=: [:;(SOH,~":)each
setnewwin=: 3 : 0
Formp=: ,>(<Formp) intersect 1{"1 wdforms''
if. 0 e. $Formp do.
  wd 'pmove 0 0 800 500;pcenter'
else.
  pos=. wd 'psel ',Formp,';qform'
  wd 'pclose'
  wd 'psel ',y
  wd 'pmove ',pos
end.
Formp=: y
)
cubedemo=: 3 : 0
Grid=: 'cube'
a0=. ;: 'Ford GM Honda Toyota Total'
a1=. '2013';'2014'
a2=. ;: 'Hire Lease Sale'
a3=. ;: 'CA KS MN NY TX'
a4=. <;._1 '/Compact/Standard/Full Size/Luxury/MiniVan/SUV/Total'
AxisLabels=. a0;a1;a2;a3;<a4
AxisNames=. ;: 'Model Year Finance State Group'
AxisOrder=. 1 3;4;2 0;0 2
d=. 3 + ?. 17 $~ _1 0 0 0 _1 + # &> AxisLabels
CellData=. d,"1 0 +/"1 d=. d,"5 4 +/"5 d
Data=. (' ',~":,CellData) rplc ' ',SOH
wd FormHeader
wd 'cc g isigrid cube'
wd 'set g shape ',toSOH $CellData
wd 'set g names ',toSOH AxisNames
wd 'set g labels ',toSOH ;AxisLabels
wd 'set g order ',toSOH AxisOrder
wd 'set g data ',Data
setnewwin wd 'qhwndp'
wd 'pshow'
)
cubehelp=: 0 : 0
Displays multi-dimensional data.

Any slices through the data are at top left.

The rows and columns are at bottom left and top right.

Drag and drop to rearrange. Dropped dimensions are moved to the end of the axis or slice list.
)
hierHelp=: 0 : 0
Displays hierarchical data in a grid.

Data is numeric, and subtotalled in groups.

Arrows at left and/or right expand and contract the hierarchy.

Combo boxes in the axis names set the top level to be displayed.

Click on a row or column header to walk down the hierarchy. Click on a walk tile to move to that level.

The demo initially shows only columns in a hierarchy. Select View Definition, set HierRows=:1 and Redisplay to view both axes in hierarchies.
)
largedemo=: 3 : 0
Grid=: 'large'
wd FormHeader
wd 'cc g isigrid'
wd 'set g shape ',":Rws,Cls
wd 'set g hdr ',toSOH Hdr
wd 'set g lab ',toSOH Lab
wd 'set g data ', Tax
setnewwin wd 'qhwndp'
wd 'pshow'
)
largehelp=: 0 : 0
Shows a grid with 1 million elements (1000x1000).
)
Rws=: 1000
Cls=: 1000
Tab=. 10000+?(Rws,Cls)$90000
Tax=: ;(,-.&' ' each 'c0.0'8!:0 Tab) ,each 1{a.
Hdr=: (<'Hdr')(,":) each i.Cls
Lab=: (<'Lab')(,":) each i.Rws
reportdemo=: 3 : 0
Grid=: 'report'
Tab=. (,.+/"1) (,+/) ?. 10 12$1500
Data=. deb toSOH 'c9.0' 8!:0 Tab
'Rws Cls'=. $Tab
j=. 'Lyon';'Nice';'Paris';'Berlin';'Bonn';'Dresden'
city=. j,'Hamburg';'Munich';'Milan';'Rome';'Total'
qtr=. ('1st';'2nd';'3rd';'4th') ,each <' Quarter'
mth=. 'JanFebMarAprMayJunJulAugSepOctNovDec'
hdr=. 'Actual';'Forecast'
hdr=. hdr,qtr,<'Year'
Hdr=. ,hdr,(_3 <\ mth),<'Total'
HdrMerge=. 9 4 3 3 3 3,14#1
lab=. 'France';'Germany';'Italy';''
Lab=. lab , city
LabMerge=. 3 5 2 1,(#city)#1
wd FormHeader
wd 'cc g isigrid'
wd 'set g shape ',":Rws,Cls
wd 'set g hdr ',toSOH Hdr
wd 'set g hdrmerge ',":HdrMerge
wd 'set g lab ',toSOH Lab
wd 'set g labmerge ',":LabMerge
wd 'set g data *',Data
setnewwin wd 'qhwndp'
wd 'pshow'
)
reporthelp=: 0 : 0
Shows merged row and column headers.

Column widths are autofit.
)
FormHeader=: 0 : 0
pc griddemo escclose closeok;
pn Grid;
menupop "&Options";
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
griddemo_cube_button=: 3 : 0
cubedemo''
)
griddemo_help_button=: 3 : 0
wdinfo 'Grid Notes';(Grid,'help')~
)
griddemo_doc_button=: 3 : 0
browse_j_ 'http://www.jsoftware.com/jwiki/Grid'
)
griddemo_large_button=: 3 : 0
largedemo''
)
griddemo_report_button=: 3 : 0
reportdemo''
)
reportdemo''
