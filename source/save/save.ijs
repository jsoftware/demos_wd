cocurrent 'jpsave'

mkdir_j_ jpath '~Addons/demos/wd'

NB. =========================================================
f=. 3 : 0
load '~Addons/demos/wd/source/',y,'/build.ijs'
(fread '~Addons/demos/wd/',y,'.ijs') fwritenew '~addons/demos/wd/',y,'.ijs'
)

Source=: <;._2 (0 : 0)
coins
isigrid
life
)

f each Source
