NB. isigrid report

NB. =========================================================
reportdemo=: 3 : 0
Grid=: 'report'
Tab=. (,.+/"1) (,+/) ?. 10 12$1500
Data=. deb toLF 'c9.0' 8!:0 Tab
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
wd 'set g hdr ',toLF Hdr
wd 'set g hdrmerge ',":HdrMerge
wd 'set g lab ',toLF Lab
wd 'set g labmerge ',":LabMerge
wd 'set g data *',Data
setnewwin wd 'qhwndp'
wd 'pshow'
)

NB. =========================================================
reporthelp=: 0 : 0
Shows multi-level and merged row and column headers.

Column widths are autofit.
)

NB. =========================================================
reportrun=: 3 : 0
wd 'pc isigriddemo escclose closeok;'
reportdemo''
wd 'pmove 100 10 600 300'
)