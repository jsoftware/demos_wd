NB. cube data

NB. =========================================================
FPlaces=: ':' ,each cutopen 0 : 0
southeast:AL
midwest:AK
southwest:AZ
southeast:AR
west:CA
west:CO
northeast:CT
northeast:DE
southeast:FL
southeast:GA
west:HI
west:ID
midwest:IL
midwest:IN
midwest:IA
midwest:KS
midwest:KY
southwest:LA
northeast:ME
northeast:MD
northeast:MA
midwest:MI
midwest:MN
southwest:MS
midwest:MO
northeast:MT
northeast:NE
west:NV
northeast:NH
northeast:NJ
southwest:NM
northeast:NY
southeast:NC
midwest:ND
midwest:OH
southwest:OK
west:OR
northeast:PA
northeast:RI
southeast:SC
midwest:SD
southeast:TN
southwest:TX
west:UT
northeast:VT
southeast:VA
west:WA
southeast:WV
midwest:WI
west:WY
)

NB. =========================================================
makecubedefs=: 3 : 0
Sym=: ''
Cls=: ;:'perspective company division region state line year quarter'
a1=. ;: 'net ceded'
n1=. 4 1
a2=. ;: 'alpha beta gamma delta epsilon'
n2=. 2 1 4 3 3
a3=. ('div_' , ":) each 1 + i. 6
n3=. 1+?~#a3
a4=. FPlaces
n4=. 1+5|?~#a4
a5=. sort <;._1 '|home owners|flood|health|pers auto|comm auto|comm prop|malpractice|travel|umbrella'
n5=. 1+4|?~#a5
a6=. '2015';'2016';'2017'
n6=. 1 1.05 1.11
a7=. ;: 'q1 q2 q3 q4'
n7=. 1 1.01 1.02 1.03
ndx=. 3
piv=. >,{a1;a2;a3;a4;a5;a6;<a7
piv=. (ndx {."1 piv),.(<;._1 &> ndx {"1 piv),.(ndx+1) }."1 piv
Sym=: ~. (;:'gross net ceded'),a2,sort ~.,piv
typ=. (#Cls)#iSym
Piv=: Cls;typ;<<"1 |: tosym piv
Num=: */"1 >,{n1;n2;n3;n4;n5;n6;n7
pns=. ~. each <"1 |: piv
Lab=: ('gross';0 pick pns);}.pns
EMPTY
)

NB. =========================================================
makecube=: 3 : 0
if. 0=#Piv do.
  makecubedefs''
end.
'cls typ dat'=. Piv
val=. <. 20 * Num * gen #Num

NB. add gross:
len=. <.-:#Num
g=. +/ (-len) [\ val
val=. (g),val
grs=. (len#tosym 'gross');len {. each }.dat
dat=. grs ,each dat
tab=. (cls,<'value');(typ,iInt);<dat,<val

len=. tabsize tab
msk=. 82 > ?len$99
tab=. tabindex tab;I.msk
Table=: tabmove tab;<;:'company division region state line'

ndx=. Cls i. cls=. }: 0 pick Table
Axis=: cls;<ndx{Lab
Order=: ,each 0 5;2 6;1 3 4 7;<,each _1;_1;_1;_1;_1;_1;1 2;_1

EMPTY
)
