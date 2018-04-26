cocurrent 'jpsave'

mkdir_j_ jpath '~Addons/demos/wd'

NB. =========================================================
f=. 3 : 0
load '~Addons/demos/wd/source/',y,'/build.ijs'
)

Source=: <;._2 (0 : 0)
coins
isigrid
life
)

f each Source
