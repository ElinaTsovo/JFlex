%%
%class Lexer
%unicode
%public
%{
    public enum Tokens {
        Reservada,
        Atribuicao,
        Soma,
        Subtracao,
        Multiplicacao,
        Divisao,
        Identificador,
        Numero,
        ERROR,
        Modulo,
        AtribuicaoSimples,
        AtribuicaoAdicao,
        AtribSubtracao,
        AtribuicaoMultiplicacao,
        AtribuicaoDivisao,
        AtribuicaoModulo,
        IgualA,
        DiferenteDe,
        MenorQue,
        MaiorQue,
        MenorOuIgualA,
        MaiorOuIgualA,
        E_logico,
        OU_logico,
        NAO_logico,
        OperadorTernario,
        AbreParenteses,
        FechaParenteses,
        AbreChavetas,
        FechaChavetas,
        PontoVirgula,
        DoisPontos,
        OperadorIncremento,
        Virgula,
        Ponto,
        AbreParentesesRectos,
        FechaParentesesRectos,
        String
    }
    public String lexeme;
    private int linha = 1;
%}

%type Tokens

// Definições de caracteres
L=[a-zA-Z_]+
D=[0-9]+
espaco=[ \t\r]+
novaLinha=\n+

%%

// Palavras reservadas
booleano |
break |
byte |
int |
caso |
char |
classe |
continue |
padrao |
do |
double |
else |
enum |
falso |
final |
real |
for |
if |
inteiro |
new |
nulo |
privado |
protegido |
publico |
retorna |
estatico |
switch |
este |
verdade |
var |
vazio |
while {lexeme = yytext(); return Tokens.Reservada;}

// Ignorar espaços em branco e comentários
{novaLinha} { linha++; /* Ignore */ }
{espaco} { /* Ignore */ }
"//".* { /* Ignore */ }

// Operadores e delimitadores
"=" { return Tokens.Atribuicao; }
"+" { return Tokens.Soma; }
"-" { return Tokens.Subtracao; }
"*" { return Tokens.Multiplicacao; }
"/" { return Tokens.Divisao; }
"%" { return Tokens.Modulo; }
"+=" { return Tokens.AtribuicaoAdicao; }
"++" { return Tokens.OperadorIncremento; }
"-=" { return Tokens.AtribSubtracao; }
"*=" { return Tokens.AtribuicaoMultiplicacao; }
"/=" { return Tokens.AtribuicaoDivisao; }
"%=" { return Tokens.AtribuicaoModulo; }
"==" { return Tokens.IgualA; }
"!=" { return Tokens.DiferenteDe; }
"<" { return Tokens.MenorQue; }
">" { return Tokens.MaiorQue; }
"<=" { return Tokens.MenorOuIgualA; }
">=" { return Tokens.MaiorOuIgualA; }
"&&" { return Tokens.E_logico; }
"||" { return Tokens.OU_logico; }
"!" { return Tokens.NAO_logico; }
"?" { return Tokens.OperadorTernario; }



// Delimitadores
"(" { return Tokens.AbreParenteses; }
")" { return Tokens.FechaParenteses; }
"[" { return Tokens.AbreParentesesRectos; }
"]" { return Tokens.FechaParentesesRectos; }
"{" { return Tokens.AbreChavetas; }
"}" { return Tokens.FechaChavetas; }
";" { return Tokens.PontoVirgula; }
":" { return Tokens.DoisPontos; }
"." { return Tokens.Ponto; }
"," { return Tokens.Virgula; }

// Strings
\"([^\"\\\\]|\\\\.)*\"  { lexeme = yytext(); return Tokens.String; }

// Identificadores
{L}({L}|{D})* { lexeme = yytext(); return Tokens.Identificador; }

// Números
("(-"{D}+")")|{D}+ { lexeme = yytext(); return Tokens.Numero; }

// Tratamento de caracteres não reconhecidos como erro
. { return Tokens.ERROR; }
