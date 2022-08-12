%{
#include<stdio.h>
int c=0, fc=0, bc=0;
%}

%s IF OPENF OPENP CLOSEP ELSE

%%
\n {c++;}

"if" {BEGIN IF; bc=0; ECHO;}
<IF>"(" {BEGIN OPENP; bc++; ECHO;}
<IF>")" {BEGIN CLOSEP; bc--; ECHO;}

<OPENP>")" {BEGIN CLOSEP; bc--;ECHO;}
<OPENP>"(" {bc++; ECHO;}
<OPENP>. {ECHO; }

<CLOSEP>"{" {if(bc==0){printf("\n matched paranthesis at line no %d",c+1);} else{ printf("\n Paranthesis mismatch at line no %d ", c+1);} ECHO; BEGIN OPENF; fc++;}
<CLOSEP>"(" {BEGIN OPENP; bc++; ECHO;}
<CLOSEP>")" {bc--;ECHO;}
<CLOSEP>. {ECHO;}

<OPENF>"} else" {BEGIN ELSE; fc--;} 
<OPENF>"}" {fc--; if(fc == 0) BEGIN 0;}
<OPENF>. {ECHO;}

<ELSE>"{" {BEGIN OPENF; fc++; ECHO;}
<ELSE>" if" {BEGIN IF; ECHO;}

. ;

%%

void main(){
yyin = fopen("text3.txt","r");
yylex();
fclose(yyin);
}


