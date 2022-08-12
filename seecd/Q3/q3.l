%{
#include<stdio.h>
int c=0;
FILE *fp;
%}
id [a-zA-Z][a-zA-Z0-9]*
ar [/*+-]
rel [<>=!]=?
num [0-9]+
inc "++"
dec "--"

%%
\n {c++;}
{id}"="({id}|{num})({ar}({id}|{num}))+ {printf("\n valid at line no %d",c+1); ECHO;}
{id}"="({id}|{num}){ar} {printf("\n invalid; RIGHT operand missing\n"); ECHO;}
{id}"="{ar}({id}|{num}) {printf("\n invalid; LEFT operand required\n"); ECHO;}
{id}"="({id}|{num})({rel}({id}|{num})) {printf("valid REL expr at line no %d \n", c+1); ECHO;}
{id}"="{id}({inc}|{dec}) {printf("valid unary op at line no %d \n ", c+1); ECHO;} 
.|\n ;
%%

int main(){
yyin=fopen("text1.txt","r");
yylex();
fclose(yyin);
}


