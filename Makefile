all: simpl

simplY.tab.c simplY.tab.h:
	bison -d simplY.y
lex.yy.c: simplL.l
	flex simplL.l
simpl:
	gcc lex.yy.c simplY.tab.c
