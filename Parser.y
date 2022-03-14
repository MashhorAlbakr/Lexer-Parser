%{
  import java.io.*;
%}

%start P
%token DEF IF THEN ELSE DO UNTIL
%token Punctuation_element
%token Operator
%token EQL GREATER_THAN_OR_EQUALS LESS_THAN_OR_EQUALS NOT_EQUALS 
%token Identifier
%token Literal

%left '-' '+'
%left '*' '/' 
%left DEF IF THEN DO UNTIL 
%right '^'
%right ELSE 


%%

P : D ';' P 
|   D
;

D : DEF Identifier '(' ARGS ')' EQL E ';'
;

ARGS : Identifier ',' ARGS
|      Identifier
;

E:     Literal
|      Identifier
|      IF E OP E THEN E ELSE E
|      DO E UNTIL E 
|      E '+' E
|      E '-' E
|      E '*' E
|      E '/' E
|      E '^' E
|      Identifier '(' C ')'
;

C:   E ',' C 
|    E
;

OP: EQL
|   '>'
|   '<'
|   GREATER_THAN_OR_EQUALS
|   LESS_THAN_OR_EQUALS
|   NOT_EQUALS
;

%%

private static boolean IS_ERROR = false;

private Lexer lexer;

private int yylex() {

    int yyl_return = -1;
    
try {
      
      yyl_return = lexer.yylex();
    }
 
   catch (IOException e) {
      System.err.println("IO error :"+e);

    }
    return yyl_return;
  }


  public void yyerror (String error) {
    IS_ERROR = true;
    System.err.println("ERROR at line: " + lexer.GetLine());
    System.err.println("ERROR at line: " + lexer.GetWord());
  }


  public Parser(Reader r) {
    lexer = new Lexer(r , this);
  }



  public static void main(String args[]) throws IOException {

    Parser yyparser;

    if ( args.length > 0 ) {
  
      yyparser = new Parser(new FileReader(args[0]));
      System.out.println("Start Parsing : ");
      yyparser.yyparse();

      if(IS_ERROR){
        System.out.println("Done with errors");
        }
      else{
        System.out.println("Done without errors");
        }
  
    }

    else {
      System.out.println("Syntax Error");
    }
  }
