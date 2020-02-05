cocurrent 'ptab'
col=: ,.@:>each :($:@([ {.each ]))
commasep=: }.@;@:((',' , ":)each)
isboxed=: 0 < L.
ischar=: 2=3!:0
isnum=: 3!:0 e. 1 4 8"_
joins=: >@(,.&.>/)
remsep=: }.~ '/' -@= {:

sfe=: 6!:16
efs=: 6!:17
fmtdp=: 4 : 0
if. 8 ~: 3!:0 y do. y return. end.
d=. 10 ^ x
'a b'=. |: 0 1 #: ,y
":,.a + (<.0.5+b*d) % d
)
date2num=: 3 : 0
efs y
)
num2date=: 3 : 0
'  d' sfe y
)
num2datetime=: 3 : 0
'  0' sfe y
)
num2datetimem=: 3 : 0
'.  3' sfe y
)
num2datetimen=: 3 : 0
'.  9' sfe y
)
boxgrade=: /:@|:@:((i.~ { /:@/:)&>)
boxindexof=: i.&>~@[ i.&|: i.&>
boxmember=: i.&>~ e.&|: i.&>~@]
boxnubsieve=: ~:@|:@:(i.&>~)
boxnubsiever=: ~:&.|.@|:@(i.&>~)
boxexcept=: <@:-.@boxmember #each [
boxsort=: <@boxgrade {each ]
boxunique=: <@boxnubsieve #each ]
boxdupsieve=: boxmember <@:-.@boxnubsieve #each ]
boxdups=: <@boxdupsieve #each ]
boxnubcount=: 3 : 0
a=. |: i.&>~ y
c=. #/.~ a
r=. (<"1 |:~.a) {each y
(\:c)&{ each r,<c
)
tabextend=: 3 : 0
'tab new'=. y
'c1 t1 v1'=. tab
'c2 t2 v2'=. new
if. -. isnum t2 do. t2=. typenum t2 end.
(c1,boxxopen c2);(t1,t2);<v1,t2 fixcols boxxopen v2
)
tabmove=: 3 : 0
'tab col'=. y
'cls typ dat'=. tab
n=. cls i. boxxopen col
(n, (i.#cls) -. n)&{ each tab
)
tabremove=: 3 : 0
'tab col'=. y
'cls typ dat'=. tab
tab #~ each <-. cls e. boxxopen col
)
tabrename=: 3 : 0
'tab col'=. y
cls=. 0 pick tab
cls=. (#cls) {. col,(#col) }. cls
(<cls) 0} tab
)
tabselect=: 3 : 0
'tab col'=. y
'cls typ dat'=. tab
(cls i. boxxopen col)&{ each tab
)
fixcols=: 4 : 0
r=. y
m=. isnum &> r
n=. I.m < x = iSym
r=. (tosym each n{r) n} r
n=. I.m < x >: iTime
r=. (time2num each n{r) n} r
n=. I.m < x >: iDate
r=. (date2num each n{r) n} r
n=. I. -.isnum &> r
r=. ((0 ". >) each n{r) n} r
)
fixval=: 4 : 0
if. isnum y do. y return. end.
v=. boxxopen y
if. x = iSym do. tosym v return. end.
if. x >: iTime do. time2num v return. end.
if. x >: iDate do. date2num v return. end.
0 ". &> v
)
fmtbase=: 4 : 0
m=. isnum &> y
if. 0 e. m do.
  ((m#x) fmtbase1 m#y) (I.m)} y
else.
  x fmtbase1 y
end.
)
fmtbase1=: 4 : 0
r=. y
n=. I.x = iSym
r=. (fromsym each n{r) n} r
if. -. 1 e. x >: iDate do. return. end.
n=. I.x = iDate
r=. (num2date each n{r) n} r
n=. I.x = iDatetime
r=. (num2datetime each n{r) n} r
n=. I.x = iDatetimem
r=. (num2datetimem each n{r) n} r
n=. I.x = iDatetimen
r=. (num2datetimen each n{r) n} r
n=. I.x = iTime
r=. (num2time each n{r) n} r
n=. I.x = iTimem
r=. (num2timem each n{r) n} r
n=. I.x = iTimen
r=. (num2timen each n{r) n} r
)
fmthead=: 4 : 0
r=. x fmtbase y
n=. I.x e. iInt,iFloat
r=. (,. each n{r) n} r
n=. I. x = iSym
r=. (> each n{r) n} r
)
fmtlist=: 4 : 0
r=. x fmtbase y
n=. I.x >: iDate
r=. (<"1 each n{r) n}r
)
fmtsym=: 4 : 0
ndx=. I. x=iSym
(fromsym each ndx{y) ndx} y
)
doget=: 4 : 0
if. 3=#y do.
  'tab col whr'=. y
  'cls typ dat'=. tab
  if. isnum whr do.
    dat=. whr&{ each dat
  else.
    while. #whr do.
      ndx=. cls i. {. whr
      ind=. I.(ndx pick dat) e. (ndx{typ) fixval 1 pick whr
      dat=. ind&{ each dat
      whr=. 2 }. whr
    end.
  end.
else.
  'tab col'=. y
  'cls typ dat'=. tab
end.
ndx=. cls i. boxxopen col
dat=. ndx{dat
if. x do. (ndx{typ) fmtlist dat end.
)
tabcols=: 3 : '0 pick y'
tabrange=: 3 : 0
'cls typ dat'=. y
dat=. ~. each dat
ndx=. I.typ = iSym
dat=. ((/:fromsym) each ndx{dat) ndx} dat
ndx=. I.typ ~: iSym
dat=. (/:~ each ndx{dat) ndx} dat
cls;typ;<dat
)
tabsize=: 3 : 0
# (2;0) {:: y
)
tabkey=: 1 : 0
'tab key'=. y
'cls typ dat'=. tab
kdx=. cls i. boxxopen key
vdx=. (i.#cls) -. kdx
cls=. (kdx,vdx) { cls
typ=. (kdx,vdx) { typ
kes=. joins kdx { dat
dat=. kes & (u /.) each vdx{dat
res=. (<"1 |: ~.kes), dat
cls;typ;<res
)

tabkeysum=: +/ tabkey
tablj=: 3 : 0
'tab1 tab2 cls'=. y
key1=. tabget tab1;cls
key2=. tabget tab2;cls
ndx=. key2 boxindexof key1
add=. tabremove tab2;cls
tab1 tabstitch tabindex add;ndx
)
tabappend=: 3 : 0
'tab dat'=. y
(<(2 pick tab) ,each dat) 2} tab
)
tabcat=: 4 : 0
'c1 t1 d1'=. x
'c2 t2 d2'=. y
if. -. c1 -: c2 do.
  'c2 t2 d2'=. tabmove y;<c1
  assert. t1 -: t2
end.
c1;t1;<d1 ,each d2
)
tabget=: 3 : '0 doget y'
tabgets=: 3 : '1 doget y'
tabget1=: 3 : '0 pick 0 doget y'
tabgets1=: 3 : '0 pick 1 doget y'
tabindex=: 3 : 0
'tab ndx'=. y
(< ndx&{ each 2 pick tab) 2} tab
)
tabput=: 4 : 0
'tab col'=. y
'cls typ dat'=. tab
ndx=. cls i. boxxopen col
new=. boxxopen x
if. (1=#ndx) *. 1<#new do. new=. <new end.
cls;typ;<new ndx} dat
)
tabsort=: 3 : 0
'tab col'=. y
'cls typ dat'=. tab
ndx=. cls i. boxxopen col
typ=. ndx { typ
dat=. ndx { dat
ind=. I.typ = iSym
dat=. (fromsym each ind{dat) ind} dat
tabindex tab;boxgrade dat
)
tabstitch=: 4 : 'x ,each y'
tabunique=: 3 : 0
(2{.y),<boxunique>{:y
)
tabwhere=: 3 : 0
'tab whr'=. y
'cls typ dat'=. tab
if. isnum whr do.
  dat=. whr&{ each dat
else.
  while. #whr do.
    ndx=. cls i. {. whr
    ind=. I.(ndx pick dat) e. (ndx{typ) fixval 1 pick whr
    dat=. ind&{ each dat
    whr=. 2 }. whr
  end.
end.
cls;typ;<dat
)
tabhead=: 3 : 0
10 tabhead y
:
'cls typ dat'=. y
if. 0=#cls do. EMPTY return. end.
if. x~:0 do.
  n=. (*x) * (|x) <. # &> dat
  dat=. n {.each dat
end.
cls,:typ fmthead dat
)
tabrand=: 3 : 0
10 tabrand y
:
'cls typ dat'=. y
if. 0=#cls do. EMPTY return. end.
if. x~:0 do.
  p=. <./ # &> dat
  n=. sort (x <. p) ? p
  dat=. n&{ each dat
end.
cls,:typ fmthead dat
)
tabread=: 3 : 0
'cls typ dat'=. y
cls;<typ fmtlist dat
)
tabreads=: 3 : 0
'cls typ dat'=. y
if. 0=#cls do. EMPTY return. end.
cls,:typ fmthead dat
)
tabreadcsv=: 3 : 0
'cls typ dat'=. y
hdr=. }.;',' ,each cls
dat=. typ fmtlist dat
ndx=. I. typ e. iInt,iFloat
dat=. (8!:0 each ndx{dat) ndx} dat
ndx=. I. -. typ e. iInt,iFloat
qot=. '"' &, @ (,&'"')
dat=. (qot each each ndx{dat) ndx} dat
dat=. <@}.@; "1 ',' ,each |: >dat
hdr,LF,;dat ,each LF
)
tabreadtext=: 3 : 0
_1 tabreadtext y
:
dat=. 0 tabhead y
hdr=. {.dat
dat=. {:dat
ndx=. I. (x>:0) *. 8=3!:0 each dat
if. #ndx do.
  dat=. (x fmtdp each ndx{dat) ndx} dat
end.
dat=. hdr ,each ":each dat
sep=. LF,~(<:#dat)#' '
LF dtbs ,joins dat ,. each sep
)
tabtail=: 3 : 0
10 tabtail y
:
(-x) tabhead y
)
j=. cutopen 0 : 0
1 bool 1          # 0 1 0
2 int 8           # 2 3 5
3 float 8         # 3.123
4 sym 8           # 'hello'
11 date 8         # 2019-08-14
12 datetime 8     # 2019-08-14T15:07:34
13 datetimem 8    # 2019-08-14T15:07:34.925
14 datetimen 8    # 2019-08-14T15:07:34.925902831
15 time 8         # 15:07:34
16 timem 8        # 15:07:34.925
17 timen 8        # 15:07:34.925902831
)

j=. cutopen@deb@({.~i.&'#') &> j
Typenum=: 0 ". &> 0 {"1 j
Types=: 1 {"1 j
Typesizes=: 0 ". &> 2 {"1 j
typenum=: 3 : 'Typenum {~ Types i. boxxopen y'
definetypes=: 3 : 0
('i' ,each (toupper@{.,}.) each Types_ptab_)=: Typenum_ptab_
)

definetypes''

coclass 'psym'
3 : 0 ''
if. 0 ~: 4!:0 <'Sym' do.
  Sym=: fileSym=: ''
  locSym=: <'psym'
end.
EMPTY
)
create=: initsym
destroy=: codestroy
isnum=: 3!:0 e. 1 4 8"_
fromsym=: 3 : 'y { Sym'
initsym=: 3 : 0
fileSym=: y
d=. fread fileSym
if. -. _1 -: d do.
  Sym=: <;._2 d
else.
  Sym=: ''
end.
locSym=: coname''
)
setfile=: 3 : 0
fileSym=: y
writesym''
)
tosym=: 3 : 0
if. isnum y do. y return. end.
nms=. , each boxopen y
ndx=. Sym i. nms
if. 1 e. b=. ,ndx=#Sym do.
  Sym__locSym=: Sym, ~.b#,nms
  writesym''
  Sym i. nms
end.
)
tosymx=: 3 : 0
if. isnum y do. y return. end.
Sym i. , each boxopen y
)
writesym=: 3 : 0
if. #fileSym do.
  (; Sym ,each {.a.) fwrite fileSym
end.
EMPTY
)
fromsym_z_=: fromsym_psym_
tosym_z_=: tosym_psym_
tosymx_z_=: tosymx_psym_

