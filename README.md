# Projeto de um Compilador

## Trabalho 1 (T1): Análise Léxica

Nesta parte do projeto, você irá implementar um analisador léxico para a [linguagem C-](https://github.com/MATA61-IC-2022-2/MATA61-2022-2/blob/456c1422f5a35c60302b7f84bb46bc262fa21d72/CMinus/cminus-01.md). 

O analisador léxico do trabalho T1 deve ler um programa fonte e produzir uma lista de _tokens_, 
sequencialmente, um _token_ de cada vez, anotado com as seguintes informações: 
- localização (número da linha) no código fonte
- classe (identificador, constante inteira, símbolo, etc)
- lexema (cadeia de caracteres correspondente).

Se uma entrada incorreta for encontrada, o analisador léxico deve reportá-lo e prosseguir com a análise.

Antes de iniciar a sua implementação, recomendamos que leia com atenção: 
+ O [capítulo 3](https://www.dropbox.com/s/401p5ewckm5op61/ch03-2ed-Scanning-Thain-Compiler-Book.pdf?dl=0) 
do livro "Introduction to Compilers and Language Design" de Douglas Thain. 
Apesar da sintaxe de C- ser um pouco diferente da usada no livro do Thain, os exemplos de código e o material podem ser extremamente úteis.
+ O [capítulo 2](https://www.dropbox.com/s/py7f6smhwcqd4ob/en-1ed-Levine-Flex_Bison%20%282009%29.pdf?dl=0) do livro "Flex & Bison" de John Levine.

## Classes de _tokens_ 

Em sua implementação do analisador léxico, considere as seguintes classes de _tokens_ da linguagem:

__ID__      Identificador  

__NUM__     Literal decimal (inteiro)  

__KEY__     Keyword (palavra-chave) 

__SYM__     Símbolo especial  

__ERROR__   Erro léxico

Comentários e caracteres de espacejamento (_white space_) devem ser descartados durante a fase de análise léxica do compilador. 

O formato da saída do analisador léxico, um _token_ por linha, é: 

``` (line_num,token_class,"lexeme") ``` (_lexeme_ entre aspas)

Você deve imprimir o número da linha na qual o _token_ foi encontrado, inclusive no caso de erro.
No caso de erro léxico, retornar o _token_ __ERROR__. 
O analisador léxico deve reportar todos os erros léxicos existentes no programa fonte analisado, prosseguindo até o final do arquivo de entrada.
  
## Exemplo de arquivo de entrada em C- (main.cm)
```
void main(void)
{
  int a;
  a = 4 + 5;
}
```

+ [Outros exemplos de programas em C-](./exemplos/README.md)

## Modelo de arquivo de saída gerado pelo analisador léxico

O analisador léxico para C- deverá ler um arquivo de entrada contendo um programa fonte em C- (com extensão _.cm_) 
e gerar um arquivo de saída (com extensão _.out_).

Por exemplo, para o programa fonte em _main.cm_ (acima), a saída gerada no arquivo _main.out_ deverá ser:
```
(1,KEY,"void")
(1,ID,"main")
(1,SYM,"(")
(1,KEY,"void")
(1,SYM,")")
(2,SYM,"{")
(3,KEY,"int")
(3,ID,"a")
(3,SYM,";")
(4,ID,"a")
(4,SYM,"=")
(4,NUM,"4")
(4,SYM,"+")
(4,NUM,"5")
(4,SYM,";")
(5,SYM,"}")
```

## Como executar (dois argumentos: entrada e saída)

O nome do analisador léxico (executável) deve ser _lexer_.
O programa _lexer_ deve ler a entrada a partir de um arquivo com extensão _.cm_ e escrever a saída em um arquivo com extensão _.out_.
O nome do arquivo de saída _.out_ deve ser igual ao nome do arquivo de entrada _.cm_.

O exemplo abaixo mostra o comando para executar o analisador léxico com dois argumentos (nomes dos arquivos de entrada e de saída):
```
$ ./lexer main.cm main.out
```

## Scripts

Disponibilizamos scripts para compilação do analisador léxico para C- (compile.sh) e para execução do analisador léxico (run.sh) para a linguagem C-.

+ __compile.sh__ (sem argumentos)
```
#!/bin/bash
# compile.sh (no parameters)
# edit the template file scr/lexer.l and add your Flex code to get rid of the warning message:
# "src/lexer.l:18: warning, -s option given but default rule can be matched"

flex src/lexer.l
cc -o lexer lex.yy.c -ll    #  "lexer" is the lexical analyzer for C-
rm lex.yy.c
```

+ __run.sh__ (recebe dois argumentos que deverão ser os nomes dos arquivos de entrada e de saída)
```
#!/bin/bash
# run.sh
# parameters: $1 is the input file name that contains C- code (.cm)
#             $2 is the output file name

./lexer $1 $2
```

Após escrever o seu analisador léxico em src/lexer.l, rodar _./compile_ para gerar o executável "lexer". 
Em seguida, rodar _./run inputfile outputfile_.
No diretório _examples_ há vários programas fonte (extensão .cm) e a saída esperada para cada um deles (extensão .out).

_Observação importante_: Arquivos de texto devem ser criados com Unix (apenas "\n" no final de linha).

-----
## Créditos 

Adaptação do material cedido pelo Prof. Vinicius Petrucci.
