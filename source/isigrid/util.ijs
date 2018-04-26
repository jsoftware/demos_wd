
Formp=: ''

intersect=: e. # [
toLF=: [:;(LF,~":)each
SOH=: 1{a.
toSOH=: [:;(SOH,~":)each

NB. =========================================================
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
