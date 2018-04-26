NB. cube

NB. =========================================================
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
Data=. (' ',~":,CellData) rplc ' ',LF
wd FormHeader
wd 'cc g isigrid cube'
wd 'set g shape ',toLF $CellData
wd 'set g data ',Data
wd 'set g names ',toLF AxisNames
wd 'set g labels ',toLF ;AxisLabels
wd 'set g order ',toLF AxisOrder
setnewwin wd 'qhwndp'
wd 'pshow'
)

NB. =========================================================
cubehelp=: 0 : 0
Displays multi-dimensional data.

Any slices through the data are at top left.

The rows and columns are at bottom left and top right.

Drag and drop to rearrange. Dropped dimensions are moved to the end of the axis or slice list.
)

NB. =========================================================
cuberun=: 3 : 0
wd 'pc isigriddemo escclose closeok;'
cubedemo''
wd 'pmove 100 10 600 300'
)