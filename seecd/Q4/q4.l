%{
#include<stdio.h>
int c=0, flag = 0;
%}
%s STRUCTURE DECLARE VAR

types "int"|"float"
id [a-zA-Z][a-zA-Z0-9]*
num [0-9]+
string ("\"")[a-zA-Z0-9]*("\"")

%%

\n {c++;}

"struct "({id}"{") {BEGIN STRUCTURE; flag = 1; printf("\n valid structure declaration at line no %d",c+1);ECHO;}
"struct {" {printf("/n Invalid declaration; requires a name at line no %d",c+1);BEGIN STRUCTURE ;ECHO;flag = 1;}
<STRUCTURE>{types} {ECHO;BEGIN DECLARE;printf("\n");}
<DECLARE>";" {BEGIN STRUCTURE;ECHO;printf("\n invalid declaration at line no %d",c+1);}
<STRUCTURE>{id} {ECHO; BEGIN STRUCTURE; printf("\n identifier should have a datatype at line no %d ", c+1);}
<DECLARE>{id}"="{num} {BEGIN VAR; printf("\n valid declaration at line no %d",c+1);ECHO;}
<DECLARE>{id}"="{string} {BEGIN STRUCTURE; ECHO;printf("\n invalid dec, int type variable cant be assigned a string value");}
<VAR>"," {ECHO ; BEGIN DECLARE;}
<VAR>",""," {ECHO;BEGIN DECLARE; printf("\n invalid dec; extra commas encountered ");}
<VAR>";" {BEGIN STRUCTURE ;ECHO; }
<STRUCTURE>"};" {BEGIN 0; ECHO; flag=0; printf("\n structure ends in line no %d",c+1);}

"int main()"|"void main()" {if(flag==1){printf("\n structure dec not closed");}}
. ;
%%

int main(){
yyin = fopen("text2.txt","r");
yylex();
fclose(yyin);
}
