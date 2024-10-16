import java.io.StringReader;
import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        String code = "int x = 1 + 2;";
        Lexer lexer = new Lexer(new StringReader(code));

        Lexer.Tokens token;
        while ((token = lexer.yylex()) != null) {
            System.out.println("Token: " + token + ", Lexeme: " + lexer.lexeme);
        }
    }
}
