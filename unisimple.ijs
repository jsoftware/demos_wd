NB. unisimple

coclass 'judmeo'

onStart=: abc_run

ABC=: 0 : 0
pc abc;pn "Unicode";
cc b button;
minwh 312 104;cc em editm;
cc viewsource button;cn "View Source";
pas 6 6;pcenter;
rem form end;
)

ABCJA=: 0 : 0
pc abc;pn "Unicode";
bin v;
bin h;
cc b button;
cc viewsource button;cn "View Source";
bin z;
wh _1 _2;cc em editm;
bin z;
pas 6 6;pcenter;
rem form end;
)

font=: IFUNIX pick '"Fixedsys" 14' ; ('Android'-:UNAME) pick '"Kochi Mincho" 14' ; 'sans 14'

c_name=: '漢語'
c_problem=: '沒有問題'
c_weather=: '今日は良い天気です'
c_nice=: '這首歌很好聽'
c_all=: c_problem,LF,c_weather,LF,c_nice

e_name=: 'English'
e_problem=: 'No problem.'
e_weather=: 'Good weather today.'
e_nice=: 'Nice song!'
e_all=: e_problem,LF,e_weather,LF,e_nice

i_name=: 'Íslenzka'
i_problem=: 'Það er ekkert vandamál'
i_weather=: 'Frábært veður í dag'
i_nice=: 'Þetta er fallegur söngur!'
i_all=: i_problem,LF,i_weather,LF,i_nice


s_name=: 'Svenska'
s_problem=: 'Det är inte något problem'
s_weather=: 'Godt väder i dag'
s_nice=: 'Sången är bra!'
s_all=: s_problem,LF,s_weather,LF,s_nice

t_name=: 'Deutch'
t_problem=: 'Daß ist kein problem'
t_weather=: 'Gutes wätter heute'
t_nice=: 'Die gesang ist gut!'
t_all=: t_problem,LF,t_weather,LF,t_nice

NB. =========================================================
abc_run=: 3 : 0
wd IFJA{::ABC;ABCJA
wd'setfont b ',font
wd'setfont em ',font
btext=: c_name
wd'set b text *',btext
wd'set em text *',c_all
wd 'pshow;'
)

NB. =========================================================
abc_b_button=: 3 : 0
select. btext
case. e_name do.
  btext=: i_name
  t=. i_all
case. i_name do.
  btext=: s_name
  t=. s_all
case. s_name do.
  btext=: t_name
  t=. t_all
case. t_name do.
  btext=: c_name
  t=. c_all
case. c_name do.
  btext=: e_name
  t=. e_all
end.
wd'set em text *',t
wd'set b text *',btext
)

NB. =========================================================
abc_viewsource_button=: 3 : 0
fview jpath '~addons/demos/wd/unisimple.ijs'
)

abc_close=: 3 : 0
wd'pclose'
)

abc_run`wd@.IFJA 'activity ', >coname''
