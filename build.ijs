NB. build

load '~Public/demos/wd/coins/build.ijs'

T=. jpath '~addons/demos/wd/'
S=. jpath '~Addons/demos/wd/'
f=. {."1 dirtree S

f=. f -. S&, each <;._2 (0 : 0)
build.ijs
run.ijs
)

t=. T&, each (#S) }.each f
empty t fcopynew each f

