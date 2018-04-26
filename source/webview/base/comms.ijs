NB. examples for webview demo Comms page

wd 'cmd w set first Andy'       NB. set first name
wd 'cmd w set last Burton'      NB. set last name

NB. try clicking the form "send" button to send the name back to J

wd 'cmd w get Random'           NB. get a random number generated on page load
wd 'cmd w call makeRandom'      NB. generate a new random number
wd 'cmd w get Random'           NB. get the new random number

wd 'cmd w eval 2+3'             NB. evaluate a Javascript expression
wd 'cmd w callr randomint 100'  NB. generates a random integer less than 100
wd 'cmd w eval randomint(100)'  NB. evaluate the corresponding Javascript expression
wd 'cmd w callr vplus "[2,3,5,7]" 10'  NB. call function to add array and single number
wd 'cmd w eval *[2,3,5,7].reduce((a,b) => a+b,0)'  NB. expression to sum array
