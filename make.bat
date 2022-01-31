bison -d simplY.y
flex simplL.l
gcc simplY.tab.c lex.yy.c
