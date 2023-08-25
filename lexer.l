%option header-file="lex.yy.h"
%option noyywrap

%{
    #include "parser.tab.hpp"
    #include <iostream>
    #include <string>
    #include <vector>
    #include <map>
    #include <fstream>
   extern int yylineno;
    using namespace std;

%}

%x COMMENT1

%x COMMENT2

STRING_CHAR                  [^\"]
STRING_CHAR_SEQUENCE         {STRING_CHAR}+
LITERAL_STR          \"({STRING_CHAR_SEQUENCE}?)\"

Letter [a-zA-Z]
Digit [0-9]
digit [0-9_]
nzdigit [1-9_]
dq ["]
string [^}\n]
letter [a-zA-Z_]
d_digit_u [0-9_]
d_int "0"[lLdDfF]?|{nzdigit}{digit}*[lLdDfF]?|{nzdigit}+{d_digit_u}*{digit}[lLdDfF]?
h_digit [0-9a-fA-F]
h_digit_u [0-9a-fA-F_]
h_int "0"[xX]{h_digit}+|"0"[xX]{h_digit}+{h_digit_u}*{h_digit}
o_digit [0-7]
o_digit_u [0-7_]
o_int "0"{o_digit}+|"0"{o_digit}+{o_digit_u}*{o_digit}

b_digit [0-1]
b_digit_u [0-1_]
b_int "0"[bB]{b_digit}+|"0"[bB]{b_digit}+{b_digit_u}*{b_digit}

exp [eE][+-]?{nzdigit}
ftsuffix [fFdD]?
d_f {nzdigit}"."{nzdigit}*{exp}*{ftsuffix}|"."{nzdigit}*{exp}*{ftsuffix}|{nzdigit}{exp}{ftsuffix}|{nzdigit}{exp}[fFdD]

HEXDIGIT [0-9A-Fa-f]
EXPONENT [pP][+-]?{digit}+
HEXFLOAT 0[xX]({HEXDIGIT}+"."{HEXDIGIT}*)({EXPONENT})


EXPONENT_F [eE][+-]?{digit}+
FLOAT ({digit}+"."{digit}*|"."{digit}+)({EXPONENT_F})?

IDENTIFIER [a-zA-Z_][0-9a-zA-Z_]*


%%
[ \t]+

[\n]    {
    yylineno++;
}

"/*"                  BEGIN(COMMENT1);
<COMMENT1>[^*/\n]+
<COMMENT1>\n            yylineno++;
<COMMENT1><<EOF>>    cout<<"EOF in comment"<<endl; return 0;
<COMMENT1>"*/"        BEGIN(INITIAL);

"//"                  BEGIN(COMMENT2);
<COMMENT2>[^*/\n]+
<COMMENT2>\n            {yylineno++;BEGIN(INITIAL);};
<COMMENT2><<EOF>>    cout<<"EOF in comment"<<endl; return 0;


"{" {
    yylval.lexeme = strdup(yytext);
    return Left_curly;
}

"}" {
    yylval.lexeme = strdup(yytext);
    return Right_curly;
}

{LITERAL_STR} {
    yylval.lexeme = strdup(yytext);
    return StringLiteral;
}


"abstract" {
    yylval.lexeme = strdup(yytext);
    return Abstract;
}

"continue" {
    yylval.lexeme = strdup(yytext);
    return Continue;
}

"for" {
    yylval.lexeme = strdup(yytext);
    return For;
}

"new" {
    yylval.lexeme = strdup(yytext);
    return New;
}




"if" {
    yylval.lexeme = strdup(yytext);
    return If;
}

"package" {
    yylval.lexeme = strdup(yytext);
    return package;
}


"synchronized" {
    yylval.lexeme = strdup(yytext);
    return synchronized;
}

"boolean" {
    yylval.lexeme = strdup(yytext);
    return boolean;
}

"do" {
    yylval.lexeme = strdup(yytext);
    return Do;
}


"private" {
    yylval.lexeme = strdup(yytext);
    return Private;
}

"this" {
    yylval.lexeme = strdup(yytext);
    return This;
}

"break" {
    yylval.lexeme = strdup(yytext);
    return Break;
}

"double" {
    yylval.lexeme = strdup(yytext);
    return Double;
}
"implements" {
    yylval.lexeme = strdup(yytext);
    return implements;
}

"protected" {
    yylval.lexeme = strdup(yytext);
    return Protected;
}

"throw" {
    yylval.lexeme = strdup(yytext);
    return Throw;
}


"else" {
    yylval.lexeme = strdup(yytext);
    return Else;
}

"import" {
    yylval.lexeme = strdup(yytext);
    return import;
}

"public" {
    yylval.lexeme = strdup(yytext);
    return Public;
}

"throws" {
    yylval.lexeme = strdup(yytext);
    return throws;
}





"instanceof" {
    yylval.lexeme = strdup(yytext);
    return instanceof;
}

"return" {
    yylval.lexeme = strdup(yytext);
    return Return;
}

"transient" {
    yylval.lexeme = strdup(yytext);
    return transient;
}

"catch" {
    yylval.lexeme = strdup(yytext);
    return Catch;
}

"extends" {
    yylval.lexeme = strdup(yytext);
    return extends;
}

"int" {
    yylval.lexeme = strdup(yytext);
    return Int;
}


"try" {
    yylval.lexeme = strdup(yytext);
    return Try;
}

"char" {
    yylval.lexeme = strdup(yytext);
    return Char;
}

"final" {
    yylval.lexeme = strdup(yytext);
    return final;
}

"interface" {
    yylval.lexeme = strdup(yytext);
    return interface;
}

"static" {
    yylval.lexeme = strdup(yytext);
    return Static;
}

"void" {
    yylval.lexeme = strdup(yytext);
    return Void;
}

"class" {
    yylval.lexeme = strdup(yytext);
    return Class;
}

"finally" {
    yylval.lexeme = strdup(yytext);
    return finally;
}


"long" {
    yylval.lexeme = strdup(yytext);
    return Long;
}


"volatile" {
    yylval.lexeme = strdup(yytext);
    return Volatile;
}



"float" {
    yylval.lexeme = strdup(yytext);
    return Float;
}

"native" {
    yylval.lexeme = strdup(yytext);
    return native;
}

"super" {
    yylval.lexeme = strdup(yytext);
    return super;
}

"while" {
    yylval.lexeme = strdup(yytext);
    return While;
}



"null" {
    yylval.lexeme = strdup(yytext);
    return Null;
}

"."   {yylval.lexeme = strdup(yytext); return Dot;}



({nzdigit}|{digit})+"."{digit}+  {
    yylval.lexeme = strdup(yytext);
    return FloatingPointLiteral;
}


{d_int}|{h_int}|{o_int}|{b_int}|{d_f}    {
    yylval.lexeme = strdup(yytext);
    return IntegerLiteral;
}

true|false      {
    yylval.lexeme = strdup(yytext);
    return BooleanLiteral;
}


{HEXFLOAT}   {
    yylval.lexeme = strdup(yytext);
    return FloatingPointLiteral;
}

{FLOAT}   {
    yylval.lexeme = strdup(yytext);
    return FloatingPointLiteral;
}

['][^'][']     {
    yylval.lexeme = strdup(yytext);
    return CharacterLiteral;
}



">>>="  {yylval.lexeme = strdup(yytext); return triplegeq;}
">>>"  {yylval.lexeme = strdup(yytext); return tripleshft;}
"<<="  {yylval.lexeme = strdup(yytext); return lseq;}
">>="  {yylval.lexeme = strdup(yytext); return rseq;}
"*="  {yylval.lexeme = strdup(yytext); return Stareq;}
"/="  {yylval.lexeme = strdup(yytext); return slasheq;}
"%="  {yylval.lexeme = strdup(yytext); return modeq;}
"+="  {yylval.lexeme = strdup(yytext); return pluseq;}
"-="  {yylval.lexeme = strdup(yytext); return minuseq;}
"++"  {yylval.lexeme = strdup(yytext); return plusplus;}

"--"  {yylval.lexeme = strdup(yytext); return minusminus;}

"&="  {yylval.lexeme = strdup(yytext); return andeq;}
"^="  {yylval.lexeme = strdup(yytext); return poweq;}
"|="  {yylval.lexeme = strdup(yytext); return oreq;}
"||"  {yylval.lexeme = strdup(yytext); return Ortwice;}
"&&"  {yylval.lexeme = strdup(yytext); return andand;}
"=="  {yylval.lexeme = strdup(yytext); return deq;}
"!="  {yylval.lexeme = strdup(yytext); return neq;}
"<<"  {yylval.lexeme = strdup(yytext); return ls;}
">>"  {yylval.lexeme = strdup(yytext); return rs;}
"<="  {yylval.lexeme = strdup(yytext); return leq;}
">="  {yylval.lexeme = strdup(yytext); return geq;}

"^"  {yylval.lexeme = strdup(yytext); return Power;}
"~"  {yylval.lexeme = strdup(yytext); return tilde;}
"!"  {yylval.lexeme = strdup(yytext); return Not;}


"["  {yylval.lexeme = strdup(yytext); return Left_sq;}
"]"  {yylval.lexeme = strdup(yytext); return Right_sq;}
"&"  {yylval.lexeme = strdup(yytext); return Bit_and;}
"<"  {yylval.lexeme = strdup(yytext); return Lessthan;}
">"  {yylval.lexeme = strdup(yytext); return Greaterthan;}
","  {yylval.lexeme = strdup(yytext); return Comma;}
"?"  {yylval.lexeme = strdup(yytext); return Qmark;}


"="  {yylval.lexeme = strdup(yytext); return Eq;}
"("  {yylval.lexeme = strdup(yytext); return Lb;}
")"  {yylval.lexeme = strdup(yytext); return Rb;}
"|"  {yylval.lexeme = strdup(yytext); return Or;}

"+"  {yylval.lexeme = strdup(yytext); return addn;}
"-"  {yylval.lexeme = strdup(yytext); return subn;}
"/"  {yylval.lexeme = strdup(yytext); return Div;}
"%"  {yylval.lexeme = strdup(yytext); return mod;}
"*"  {yylval.lexeme = strdup(yytext); return multi;}

":"  {yylval.lexeme = strdup(yytext); return Colon;}
";"  {yylval.lexeme = strdup(yytext); return Semicolon;}


{IDENTIFIER}  {
    yylval.lexeme = strdup(yytext);
    return IDENTIFIER;
}


. {cout<<"hii" << yytext ;}

%%


