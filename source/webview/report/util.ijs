NB. util

cutparts=: <;.1~ 1 , }. ~: }:
joins=: ,.@>@(,.&.>/)
rand=: ?@$
rand01=: rand 0:
normalrand=: 3 : '(2 o. +: o. rand01 y) * %: - +: ^. rand01 y'
gen=: [: ^ 0.3 * normalrand

td=: '<td>' , ,&'</td>'
tda=: '<td class="tdalt">' , ,&'</td>'
th=: '<th>' , ,&'</th>'
tr=: '<tr>' , ,&'</tr>'

NB. =========================================================
NB. <th> with colspan
thcolspan=: 4 : 0
if. x=1 do.
  '<th>', y, '</th>'
else.
  '<th colspan=',(":x),'>',y,'</th>'
end.
)

NB. =========================================================
NB. <th> with rowspan
throwspan=: 4 : 0
if. x=1 do.
  <'<th>', y, '</th>'
else.
  ('<th rowspan=',(":x),'>',y,'</th>');(x-1)$<''
end.
)
