NB. price

PriceInit=: 0

NB. =========================================================
PriceDef=: 0 : 0
type='price'
label='close'
datefmt='%d %b'
key=['AAPL','GOOG','MSFT']
)

NB. =========================================================
run_price=: 3 : 0
if. -. PriceInit do.
  9!:1[235741
  PriceInit=: 1
end.
sym=. ;: 'APPL GOOG MSFT'
bgn=. (todayno 2015 1 1) + ?180
end=. bgn + 31
ccf=. 0.5            NB. correlation coefficient
prc=. 30 + 3?70
cnt=. #sym
dates=. getweekdates bgn,end
prices=. makeprices ccf;cnt;dates;prc
r=. PriceDef
r=. r,'daty=',jsbracket jsbracket each ;/prices
r=. r,LF,'datv=',jsbracket makevolumes 150000,#dates
r=. r,LF,'dates=',jsbracket daynoj2js dates
r,LF
)

NB. =========================================================
makeprices=: 3 : 0
'ccf cnt dates prc'=. y
p=. 1,.cgen @ (0.0375 3&,) &> cnt##dates
p=. choleskicor ccf;p
(prc % {."1 p) * p *"1 [ 1.1 ^ int01 #dates
)
