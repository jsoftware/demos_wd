NB. win

NB. =========================================================
webview=: 3 : 0
wd 'pc webview escclose;pn Intro'
wd 'menupop "&File";'
wd 'menu quit "&Quit" "Ctrl+Q" "" "";'
wd 'menupopz;'
wd 'bin hvp8'
wd 'cc intro button;cn Intro'
wd 'cc comms button;cn Comms'
wd 'cc plot button;cn Plot'
wd 'cc report button;cn Report'
wd 'cc web button;cn Web'
wd 'bin s'
wd 'cc reload button;cn Reload'
wd 'bin p8zv1'
wd 'cc w webview'
wd 'bin zz'
wd 'pmove _1 _1 1000 700'
wd 'pshow hide'
webview_load''
)
webview_quit_button=: webview_close

NB. =========================================================
webview_w_post=: 3 : 0
select. w_name
case. 'init' do.
  webview_show ''
  wd 'pshow'
case. 'd3plot' do.
  wd 'cmd w call d3plot *',('run_',w_value)~0
case. 'error' do.
  echo w_name,' ',w_value
case. 'name';'return' do.
case. do.
  fn=. 'run_',w_name
  wd 'cmd w call report *',fn~w_value
end.
)

NB. =========================================================
webview_close=: 3 : 0
wd 'pclose'
)

NB. =========================================================
webview_load=: 3 : 0
wd 'set w url *file://',('/' #~ '/'~:{.Page),Page
)

NB. =========================================================
webview_intro_button=: webview_show bind 0
webview_comms_button=: webview_show bind 1
webview_plot_button=: webview_show bind 2
webview_report_button=: webview_show bind 3
webview_web_button=: webview_show bind 4
webview_reload_button=: webview_load

NB. =========================================================
webview_show=: 3 : 0
wd 'cmd w call initpage ',":Pindex=: {.y,Pindex
wd 'pn ',Pindex pick ;:'Intro Comms Plot Report Web'
)
