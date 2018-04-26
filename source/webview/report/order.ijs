NB. order

NB. =========================================================
NB. return report data in order
reportorder=: 3 : 0

'nms lab'=. Axis
'rows cols pages select'=. Order
tab=. Table
'cls typ dat'=. tab

NB. subset selections:
ndx=. I. -. _1 e.&> select
if. #ndx do.
  tab=. tabwhere tab;<,(ndx{cls),.(ndx{select) {each ndx{lab
end.

NB. subtotal pages:
if. #pages do.

NB. for perspective, gross=total
  if. (<'perspective') e. pages{cls do.
    psp=. tabget1 tab;<'perspective'
    if. (tosym 'gross') e. psp do.
      tab=. tabindex tab;I. psp=tosym 'gross'
    end.
  end.
  tab=. tabremove tab;<pages{cls
  tab=. tabkeysum tab;<(rows,cols){cls
end.

NB. sort pages:
tabindex tab;/: joins }:2 pick tab
)
