//
//  main.m
//  ObjcDocumentation
//
//  Created by Ronaldo Gomes on 20/07/21.
//

#import <Foundation/Foundation.h>

@interface ClasseMatematica: NSObject
-(int) numeroMaximo: (int) num1 andNum2: (int) num2;
-(void) performCompletion: (void (^)(void)) completionBlock;
@end

@implementation ClasseMatematica

/*
 Funcoes em Objc tem o seguinte esquema
 - (return_type) function_name:( argumentType1 )argumentName1
 joiningArgument2:( argumentType2 )argumentName2 ...
 joiningArgumentn:( argumentTypen )argumentNamen;
 */

-(int) numeroMaximo: (int) num1 andNum2: (int) num2 {
    int result;
    
    if (num1 > num2) {
        result = num1;
    } else {
        result = num2;
    }
    
    return result;
}

// Bloco com completion
-(void) performCompletion: (void (^)(void)) completionBlock {
    NSLog(@"Action Performed");
    completionBlock();
}

@end

/*
 Podemos criar blocos usando a seguinte notacao
 returntype (^blockName)(argumentType)= ^{
 };
 */

void (^simplesBloco)(void) = ^{
   NSLog(@"Isto é um bloco");
};

// Bloco com argumentos
double (^multiplicaDoisValores)(double, double) =
    ^(double num1, double num2) {
        return num1 * num2;
    };

/*
 Struct tem a seguinte definicao
 struct [structure tag] {
    member definition;
    member definition;
    ...
    member definition;
 } [one or more structure variables];
 */
struct Livro {
    NSString *titulo;
    int livroId;
};

int main(int argc, const char * argv[]) {
    /* Primeiro comentario com objc */
    NSLog(@"Hello, World\n");
    
    NSLog(@"O tamanho de armazenamento do int é %lu \n", sizeof(int));
   
    
    // Definicao de variaveis
    int a, b;
    float c;
    double d;
    
    // Implementacao da variavel
    a = 10;
    NSLog(@"O valor de a = %d\n", a);
    
    b = a - 5;
    NSLog(@"O valor de b = %d\n", b);
    
    c = a + 16;
    NSLog(@"O valor de c = %f\n", c);
    
    d = c / 3;
    NSLog(@"O valor de d = %f\n", d);
    
    // Constante
    const int constante = 1;
    NSLog(@"Constante %d\n", constante);
    
    // Chamando uma funcao de uma classe
    ClasseMatematica *matematica = [[ClasseMatematica alloc] init];
    
    int maxResult = [matematica numeroMaximo:a andNum2:b];
    NSLog(@"Resultado maximo %d\n", maxResult);
    
    // A chama de blocos é bem simples
    simplesBloco();
    
    // Chamada de um bloco com argumentos
    double resultado = multiplicaDoisValores(d, 2.0);
    NSLog(@"%f x 2 = %f", d, resultado);
    
    // Chamada de um bloco com completion
    [matematica performCompletion: ^{
        NSLog(@"Completion é chamada apos a funcao");
    }];
    
    // Arrays
    double matrizLinha[] = {1000.0, 2.0, 3.4, 17.0, 50.0};
    NSLog(@"Elemento 3 da matriz é %f", matrizLinha[3]);
    
    int matriz[2][2] = {{1, 2},
                        {3, 4}};
    NSLog(@"Elemento 2x1 da matriz é %d", matriz[1][0]);
    
    // Ponteiros
    int *ip = &a; // Ponteiro

    NSLog(@"Endereco da variavel ip: %x\n", ip );
    NSLog(@"Valor da variavel ip: %d\n", *ip );
    
    // Strings
    NSString *saudacoes = @"Ola";
    NSLog(@"A saudacao é %@\n", saudacoes);
    
    // Declaracao de structs
    struct Livro Livro1;
    struct Livro Livro2;
    
    // Associacao de valores de structs
    Livro1.titulo = @"Harry Potter";
    Livro1.livroId = 643;
    
    Livro2.titulo = @"Herois do Olimpio";
    Livro2.livroId = 134;
    
    NSLog(@"Livro %@ - id %d", Livro1.titulo, Livro1.livroId);
    NSLog(@"Livro %@ - id %d", Livro2.titulo, Livro2.livroId);
    return 0;
}
