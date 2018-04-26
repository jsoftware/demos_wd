NB. scatterplot data

SPinit=: 0

NB. =========================================================
SPdefs=: 0 : 0
Beijing,China,12.5,2
Berlin,Germany,3.6,3
Chicago,USA,9.5,0
Hamburg,Germany,1.8,3
Hong Kong,China,7.2,2
Houston,USA,2.1,0
Kyoto,Japan,1.5,2
London,England,8.7,3
Milan,Italy,1.3,3
Munich,Germany,1.4,3
New York,USA,8.2,0
Osaka,Japan,2.7,2
Paris,France,2.2,3
Rome,Italy,2.9,3
Salvador,Brazil,2.9,1
Sao Paolo,Brazil,11.9,1
Tokyo,Japan,9,2
Shanghai,China,16.6,2
Toronto,Canada,5.6,0
)

NB. =========================================================
make_scatter=: 3 : 0
dat=. _4[\','cutopen SPdefs rplc LF,','
if. SPinit do.
 dat=. dat #~ 0<?(#dat)#8
end.
SPinit=: 1
dat=. <"1 |: dat
SPlen=: # 0 pick dat
dat=. (0 ". &> each 2 3{dat) 2 3} dat
dat=. dat,<'Show All';sort ~.1 pick dat
dat=. dat,<'North America';'South America';'Asia';'Europe'
nms=. ;: 'city country population continent nubcountry continents'
SPdata=: tolist nms ,each ('=' , enc) each dat
EMPTY
)

NB. =========================================================
run_scatter=: 3 : 0
make_scatter ''
xmax=. 50 + 10 * ?4
ymax=. 100
xval=. 1 + ?SPlen#xmax-1
yval=. 1 + ?SPlen#ymax-1
nms=. ;:'xmax ymax xval yval'
dat=. tolist nms ,each ('=' , enc) each xmax;ymax;xval;yval
SPdata,LF,dat
)
