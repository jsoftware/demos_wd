NB. win

COIN=: 0 : 0
pc coin;pn "Coins";
menupop "File";
menu b0 "&Load 8-2-48" "" "" "";
menu b1 "&Load 8-3-44" "" "" "";
menu b2 "&Load 9-2-66" "" "" "";
menu b3 "&Load 11-2-118" "" "" "";
menusep;
menu viewcode "&View Code" "" "" "";
menusep;
menu exit "&Exit" "" "" "";
menupopz;
menupop "Help";
menu help "&Help" "" "" "";
menusep;
menu about "&About" "" "" "";
menupopz;
bin vh;
cc restart button;cn "Restart";
cc undo button;cn "Undo";
cc redo button;cn "Redo";
cc cnt static center;cn "";
bin sz;
groupbox;
minwh 500 500;cc g isigraph flush;
groupboxend;
bin z;
pas 0 0;pcenter;
rem form end;
)

COINJA=: 0 : 0
pc coin;pn "Coins";
menupop "File";
menu b0 "&Load 8-2-48" "" "" "";
menu b1 "&Load 8-3-44" "" "" "";
menu b2 "&Load 9-2-66" "" "" "";
menu b3 "&Load 11-2-118" "" "" "";
menusep;
menu viewcode "&View Code" "" "" "";
menusep;
menu exit "&Exit" "" "" "";
menupopz;
menupop "Help";
menu help "&Help" "" "" "";
menusep;
menu about "&About" "" "" "";
menupopz;
bin vh;
cc restart button;cn "Restart";
cc undo button;cn "Undo";
cc redo button;cn "Redo";
cc cnt static center;cn "";
bin sz;
wh _1 _1;cc g isigraph flush;
bin z;
pas 0 0;pcenter;
rem form end;
)

NB. =========================================================
coin_run=: 3 : 0
DONE=: 0
wd IFJA{::COIN;COINJA
setparentname''
wd 'pshow;'
)

NB. =========================================================
coin_f10_fkey=: 3 : 0
glsel 'g'
'w h'=. glqwh ''
rgb=. (h,w) $ glqpixels 0,0,w,h
rgb writeimg_jqtide_ jpath '~temp/coin.png'
)

NB. =========================================================
coin_helper=: 3 : 0
act=. ACTIVE -. LASTAVAIL
select. #act
case. 0 do.
  coin_undo_button''
case. 1 do.
  movemark act
case. do.
  drawhigh act
end.
)

NB. =========================================================
coin_newbutton=: 3 : 0
BOARD=: y
init''
setparentname''
paint''
)

coin_b0_button=: coin_newbutton bind 0
coin_b1_button=: coin_newbutton bind 1
coin_b2_button=: coin_newbutton bind 2
coin_b3_button=: coin_newbutton bind 3

NB. =========================================================
coin_redo_button=: 3 : 0
BUFNDX=: (<:#BUFFER) <. >: BUFNDX
POS=: BUFNDX pick BUFFER
paint''
)

NB. =========================================================
coin_restart_button=: 3 : 0
if. 'Android'-:UNAME do. paint@init '' return. end.
if. 0 = query`0:@.('Android'-:UNAME) 'OK to restart?' do.
  init''
  paint''
end.
)

NB. =========================================================
coin_viewcode_button=: 3 : 0
fview jpath '~addons/demos/wd/coins.ijs'
)

NB. =========================================================
coin_undo_button=: 3 : 0
BUFNDX=: 0 >. <: BUFNDX
POS=: BUFNDX pick BUFFER
paint''
)

NB. =========================================================
coin_g_paint=: draw
coin_g_mmove=: mmove
coin_g_mbldown=: mbldown
coin_g_mbrdown=: mbrdown
coin_g_mbrup=: mbrup
coin_close=: wd bind 'pclose'
coin_exit_button=: coin_close
coin_about_button=: 3 : 'info ABOUT'
coin_help_button=: 3 : 'info HELP'
-
