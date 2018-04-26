NB. html

NB. =========================================================
chartnms=: 3 : '}. ; ''.'' ,each y'

NB. =========================================================
tab2chart=: 3 : 0
'cls typ dat'=. y

nmx=. cls i. 0 pick Table
rwx=. nmx {~ ,0 pick Order
clx=. nmx {~ ,1 pick Order

nms=. 0 pick Axis
rnms=. rwx{cls
cnms=. clx{cls

rows=. joins rwx{dat
cols=. joins clx{dat

crws=. #nrws=. ~.rows
ccls=. #ncls=. ~.cols
ndx=. (rows,.cols) i. (ccls#nrws),.(crws*ccls)$ncls

ndat=. ndx { (_1 pick dat),0

lab=. }.each <@;"1 '.',each fromsym nrws
hdr=. }.each <@;"1 '.',each fromsym ncls
tit=. 'sum(values) of ',(chartnms cnms),' by ',chartnms rnms

tit;lab;hdr;ndat
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
