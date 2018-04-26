NB. html

NB. =========================================================
tab2html=: 3 : 0
'cls typ dat'=. y
nmx=. cls i. 0 pick Table

rows=. joins (nmx {~ ,0 pick Order) { dat
cols=. joins (nmx {~ ,1 pick Order) { dat

crws=. #nrws=. ~.rows
ccls=. #ncls=. ~.cols
ndx=. (rows,.cols) i. (ccls#nrws),.(crws*ccls)$ncls

data=. 'c13.0' (8!:0) _1 pick dat
ndat=. ndx { data,<''

tab2html1 nrws;ncls;<ndat
)

NB. =========================================================
tab2html1=: 3 : 0
'rows cols data'=. y

rws=. #rows
cls=. #cols

'wid lab'=. lab2html rows
hdr=. wid hdr2html cols
dat=. (rws,cls)$data

ndx=. I. rws$1 0
dat=. (td each ndx{dat) ndx} dat
ndx=. I. rws$0 1
dat=. (tda each ndx{dat) ndx} dat

bdy=. ;<@tr@;"1 lab,.dat
'<table id="cube1" class="cube"><thead>',hdr,'</thead><tbody>',bdy,'</tbody></table>'
)