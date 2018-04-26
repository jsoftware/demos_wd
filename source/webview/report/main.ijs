NB. main

NB. =========================================================
NB. this defines the data, and if necessary the initial order
makereport=: 3 : 0
makecube''
reportorder''
)

NB. =========================================================
axis_report=: 3 : 0
a=. 'names';<0 pick Axis
b=. 'labels';<1 pick Axis
c=. 'order';<Order
'Axis=',enc_dict a,b,:c
)

NB. =========================================================
order_report=: 3 : 0
'Axis.order=',enc Order
)

NB. =========================================================
NB. run report to initialize system
run_report=: 3 : 0
makecube''
(axis_report''),LF,reportformat reportorder''
)

NB. =========================================================
run_newdata=: 3 : 0
order=. Order
Piv=: ''
makecube''
run_setorder enc order
)

NB. =========================================================
NB. argument in json
run_setformat=: 3 : 0
old=. Format
Format=: y
if. (old-:'table') = Format-:'table' do.
  'Cube.format="',Format,'"'
else.
  reportformat reportorder''
end.
)

NB. =========================================================
NB. argument in json
run_setorder=: 3 : 0
Order=: dec y
r=. 'Axis.order=',enc Order
r,LF,reportformat reportorder''
)

NB. =========================================================
reportformat=: 3 : 0
a=. 'type';'dummy'
b=. 'format';Format
if. Format -: 'table' do.
  c=. 'html';tab2html y
else.
  c=. 'chart';<tab2chart y
end.
'Cube=',enc_dict a,b,:c
)
