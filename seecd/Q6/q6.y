%{
#include<stdio.h>

#include<math.h>
%}

%token id num

%nonassoc UMINUS 
%% 
stmt: expression { printf("\n valid exprn\n");}; 
expression : '(' expression ')' {printf("\n brackets \n"); $$=$2;printf("\n %d",$$);}
| expression '+' expression {printf("\nplus recog!");$$=$1+$3;printf("\n %d",$$);}
| expression '+' { printf ("\n Syntax error: Right operand is missing ");}
| expression '-' expression {printf("\nminus recog!");$$=$1-$3;printf("\n %d",$$);}
| expression '-' { printf ("\n Syntax error: Right operand is missing ");}
| expression '*' expression {printf("\nMul recog!");$$=$1*$3;printf("\n %d",$$);}
| expression '*' { printf ("\n Syntax error: Right operand is missing ");}
| expression '/' expression {printf("\ndivision recog!");if($3==0) printf("\ndivision cant be done, as divisor is zero.");
else {$$=$1/$3;printf("\n %d",$$);}}
| expression '/' { printf ("\n Syntax error: Right operand is missing ");} 
|UMINUS expression
| id
| num
|'+' '+' expression {printf("\n increment recognised");$$=$3+1;printf("\n %d",$$);}
|'-' '-' expression {printf("\n decrement recognised");$$=$3-1;printf("\n %d",$$);}
;

%%

main()
 { printf(" Enter an arithmetic expression\n");
yyparse(); } 
yyerror() { printf(" Invalid arithmetic Expression\n");
 exit(1);
}

