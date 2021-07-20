//
//  main.m
//  ObjcDocumentation
//
//  Created by Ronaldo Gomes on 20/07/21.
//

#import <Foundation/Foundation.h>

@interface ClasseMatematica: NSObject
-(int) numeroMaximo: (int) num1 andNum2: (int) num2;
@end

@implementation ClasseMatematica

-(int) numeroMaximo: (int) num1 andNum2: (int) num2 {
    int result;
    
    if (num1 > num2) {
        result = num1;
    } else {
        result = num2;
    }
    
    return result;
}

@end

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
    
    return 0;
}
