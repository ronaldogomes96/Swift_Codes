//LOOPS
//For
//Funciona basicamente como em qualquer outra linguagem
let contar = 1...10
for numero in contar{
    print("O numero é \(numero)")
    //Tambem funciona com arrays
}
// Caso nao use a constante do for, use um underline _
for _ in 1...5 {
    print("play")
}

// While tambem funciona da mesma forma que qualquer outro
//Repeat while funciona como um do while
var number = 1
repeat {
    print(number)
    number += 1
} while number <= 20
print("Ready or not, here I come!")

//Para forçar a saida de um loop, podemos usar o break
var countDown = 10
while countDown >= 0 {
    print(countDown)
    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }
    countDown -= 1
}

//Saindo de multiplos Loops
//Podemos sair de uma sequencia de loops, adicionando um rotulo(label)ao loop externo
saidaLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("Saindo calculadora")
            break saidaLoop //Ele ira sair de ambos os loops
        }
    }
}

//Continue
//Funciona como um inverso do break
//Ele passa para a proxima interação se a condição for true
for i in 1...10 {
    if i % 2 == 1 {
        continue
    }

    print(i)
}