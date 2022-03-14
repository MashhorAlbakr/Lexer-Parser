import java.io.*;

%%

%class Lexer
%line
%byaccj

%{
  private Parser yyparser;

  public Lexer(java.io.Reader r, Parser yyparser) {
    this(r);
    this.yyparser = yyparser;
}
    public int GetLine() {
        return yyline + 1;
        }
  public String GetWord() {
        return yytext();
        }
%}

DEF = "def"
IF = "if"
THEN = "then"
ELSE = "else"
DO = "do"
UNTIL = "until"
Punctuation_element = [():,;]
Operator = ["+"|"-"|"*"|"^"|"/"|">"|"<"|"<="|"=>"|"<>"]
Identifier = [a-zA-Z]([0-9]|[a-zA-Z]|_)*
Literal = \d+
%%

{DEF}           { return Parser.DEF; }
{IF}            { return Parser.IF; }
{THEN}            { return Parser.THEN; }
{ELSE}            { return Parser.ELSE; }
{DO}            { return Parser.DO; }
{UNTIL}           { return Parser.UNTIL; }

"="           { return Parser.EQL; }
">="      { return Parser.GREATER_THAN_OR_EQUALS; }
"<="          { return Parser.LESS_THAN_OR_EQUALS; }
"<>"            { return Parser.NOT_EQUALS; }

{Punctuation_element} { return (int) yycharat(0); }

{Operator}   { return (int) yycharat(0); }

{Identifier}       { return Parser.Identifier; }

{Literal}          { return Parser.Literal; }

[\s]+              { /* do nothing */ }

.     {
        System.err.println( "Lexical Error at line: " + yyline+1);
        return -1;
        }
