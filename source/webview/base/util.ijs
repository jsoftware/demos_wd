NB. util

vex=: 1.0005         NB. average volume growth per day

int01=: i.@>: % ]
limit=: <. >. [: - [
linesert=: 2&$: :([: +/\ {.@] , [ # (}. - }:)@] % [)
normalrand=: 3 : '(2 o. +: o. rand01 y) * %: - +: ^. rand01 y'
rand01=: ?@$ 0:
round=: [ * [: <. 0.5 + %~
roundint=: <.@:+&0.5
tolist=: }. @ ; @: (LF&, @ , @ ": each)
xrnd=: 4 : '^ x * 2 limit normalrand y'

NB. =========================================================
NB. constrained random walk
NB. a max movement per step
NB. b max movement at any time (above/below)
NB. c number of steps
cgen=: 3 : 0
'a b c'=. y
m=. %b
while. 1 do.
  p=. */\ 1 + a * normalrand c
  if. -. 1 e. (m>p) +. b<p do. return. end.
end.
)

NB. =========================================================
choleski=: 3 : 0
mp=. +/ .*
n=. #a=. y
if. 1>:n do.
  13!:8(,(a=|a)>0=a)}.12
  %:a
else.
  p=. >.n%2 [ q=. <.n%2
  x=. (p,p){.a [ y=. (p,-q){.a [ z=. (-q,q){.a
  l0=. choleski x
  l1=. choleski z-(t=. (+|: y) mp %.x) mp y
  l0,(t mp l0),.l1
end.
)

NB. =========================================================
NB. paired correlation, matrix of variates, min 0.1 coeff
choleskicor=: 3 : 0
'ccf dat'=. y
n=. #dat
c=. 0.1 >. (n,n)$1,ccf,((n-2)#0),ccf
(choleski c) +/ .* dat
)

NB. =========================================================
NB. J day number to javascript date
daynoj2js=: 86400000 * -&62091

NB. =========================================================
NB. get week dates
getweekdates=: 3 : 0
'b e'=. y
d=. b + i. 1 + e-b
d #~ -. (7 | 3 + d) e. 0 6
)

NB. =========================================================
jsbracket=: 3 : 0
if. L.y do.
  '[',']',~}.;',' ,each y
else.
  if. 8=3!:0 y do.
    y=. 0.001 round y
  end.
  d=. ": y
  d=. '-' (I. d='_')} d
  d=. ',' (I. d=' ')} d
  '[',d,']'
end.
)

NB. =========================================================
makevolumes=: 3 : 0
'size count'=. y
v=. cgen 0.03 3,count
a=. vex ^ -count
roundint (size + ? count#<.size*0.7) * 0.5 >. 2 <. v*a+((%{:v)-a) * int01 count-1
)

NB. =========================================================
show_webview_events=: 3 : 0
n=. {."1 wdq
v=. {:"1 wdq
if. -. (,'w') -: (n i. <'syschild') pick v do. return. end.
m=. (n e. ;:'sysevent') +. (<'w_') = 2 {.each n
smoutput m#wdq
)

NB. =========================================================
NB. volume profile - random times, weighted toward ends
NB. y=# of buckets, total count
volprof=: 3 : 0
'buckets count'=. y
p=. 1.75
c=. <. count%3
b=. (?c$0) ^ p
e=. 2-(?c$0) ^ p
m=. ?(count-2*c)$0
sort m,0.5*b,e
+/"1 (i.buckets) =/<.buckets * m,0.5*b,e
)

NB. =========================================================
volprof1=: 3 : 0
count=. y
p=. 1.75
c=. <. count%3
b=. (?c$0) ^ p
e=. 2-(?c$0) ^ p
m=. ?(count-2*c)$0
m,0.5*b,e
)

NB. =========================================================
wdhandler_debug_z_=: show_webview_events_qtwebview_
