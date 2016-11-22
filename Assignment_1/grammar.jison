/* description: Parses and executes mathematical expressions. */

/* lexical grammar */

%lex
%%

\s+                   /* skip whitespace */
[0-9]+("."[0-9]+)?\b  return 'NUMBER'
"*"                   return '*'
"/"                   return '/'
"-"                   return '-'
"+"                   return '+'
"("                   return '('
")"                   return ')'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

%{
    var parse = require("./parserTree.js").module;
%}

/* operator associations and precedence */

%right '+' '-'
%left '*' '/'


%start expressions

%% /* language grammar */

expressions
    : e EOF
        {
        console.log('$$:- ', parse.parse($$));
        }
    ;
e
    : e '+' e
        {$$ = { leftChild: $1, parent: $2, rightChild: $3}}
    | e '-' e
        {$$ = { leftChild: $1, parent: $2, rightChild: $3}}
    | e '*' e
        {$$ = { leftChild: $1, parent: $2, rightChild: $3}}
    | e '/' e
        {$$ = { leftChild: $1, parent: $2, rightChild: $3}}

    | '(' e ')'
        {$$ = $2;}
    | NUMBER
        {$$ = Number(yytext);}
    ;