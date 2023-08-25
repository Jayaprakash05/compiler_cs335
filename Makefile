target:
	bison -d -v parser.ypp
	flex lexer.l
	g++ lex.yy.c parser.tab.cpp -o myASTGenerator