NB. save Qt demos

HDR=: 'NB. script built in ~Addons/demos/wd/source/isigrid'

make1=: 3 : 0
dat=. 'b' fread '~Addons/demos/wd/source/isigrid/',y,'.ijs'
dat=. dat -.<'wd FormHeader'
dat=. dat #~ (<'setnewwin')~:9{.each dat
dat=. ;dat ,each LF
dat=. HDR,LF2,dat
dat=. dat,LF,'toLF=: [:;(LF,~":)each',LF2
dat=. dat,y,'run$0',LF
)

(make1 'report') fwritenew '~Qt/demo/isigrid.ijs'
(make1 'cube') fwritenew '~Qt/demo/isigrid2.ijs'
