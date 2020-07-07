
import Foundation

//Podemos criar uma lista vinculada em swift usando Classes

//Unidade unica em uma lista vinculada
class Node {
    
    var value: Int
    //Aponta para o proximo nó da lista vinculada
    var next: Node?
    
    //Usamos o init para um novo elemento Node
    init(value: Int){
        self.value = value
    }
}

/*
//Podemos criar um nó, fornecendo valores
let node1 = Node(value: 10)
let node2 = Node(value: 15)
node1.next = node2
*/

//Unidade da pilha
class Stack {
    
    var ll: LinkedList
    
    init(top: Node?) {
        self.ll = LinkedList(head: top)
    }
    
    // add a node to the top of the stack
    func push(_ node: Node) {
        ll.append(node)
    }
    
    // remove and return the topmost node from the stack
    func pop() -> Node? {
        
        var current = ll.head
        
        while let _ = current {
            if current?.next == nil {
                ll.deleteNode(withValue: current!.value)
                return current
            }
            current = current?.next
        }
        return nil
    }
}
 
//Agpra podemos criar uma classe que simule a lista encadiada

class LinkedList{
    
    //Criamos um no
    var head: Node?
    
    init(head: Node?){
        self.head = head
    }
    
    //Metodo que acrescenta um no
    func append(_ node: Node){
        
        guard head != nil else {
            //Caso a lista esteja vazia, head é nil, adionamos o primeiro elemento na lista
            head = node
            return
        }
        
        //Caso a lista nao esteja vazia, fazemos a interacao de cada elemento next do node, ate o ultimo, substituindo no final
        
        var current = head
        while let _ = current?.next {
            //Quando for o ultimo elemento, next sera nil e saira do loop
            current = current?.next
        }
        
        //Entao adicionamos o novo elemento no final
        current?.next = node
    }
    

    // Get a node from a particular position.
    // Assume the first position is "1".
    // Return "nil" if position is not in the list.
    func getNode(atPosition position: Int) -> Node? {
        
        var current = head
        
        //Caso a posicao seja menor que 0, retorna nil, pois nao existe index < 0
        if position <= 0 {
            return nil
        }
        
        //Para cada no, pegamos o proximo, ate que chegamos na posicao escolhida
        for _ in 0..<position - 1 {
            current = current?.next
            //Caso o proximo seja nil, entao nao tem elementos nessa posicao escolhida
            if current == nil {
                return nil
            }
        }
        return current
    }
    
    // Insert a new node at the given position.
    // Assume the first position is "1".
    // Inserting at position 3 means between
    // the 2nd and 3rd nodes.
    func insertNode(_ node: Node, at position: Int) {
        
        //Caso a posicao seja menor que 0, retorna nil, pois nao existe index < 0
        if position <= 0 {
            print("Outside of range, no possible insert at position")
            return
        }
        
        var current =  head
        
        //Nó anterior
        var nodeBefore: Node?
        
        //Caso seja inserido no comeco, usamos ele como o head
        if position == 1{
            node.next = current
            head = node
            return
        }
        
        //Fazemos a interacao ate chegar na posicao escolhida
        for _ in 0..<position - 1{
            
            //Salvamos o valor atual do nó
            nodeBefore = current
            current = current?.next
            if current == nil {
                print("Outside of range, no possible insert at position")
                return
            }
        }
        
        //Fazemos a troca de referencia do anterio e proximo
        node.next = current
        nodeBefore?.next = node

    }
    
    // Delete the first node with a given value.
    func deleteNode(withValue value: Int) {
        
            var current = head
            var nodeAfter: Node?
            var nodeBefore: Node?
            
            //Fazemos a interacao ate que seja o ultimo, no caso nil
            while let _ = current {
                
                //Guardamos o valor do proximo nó
                nodeAfter = current?.next
                
                //Verificamos se é o valor escolhido
                if current?.value == value {
                    
                    //Caso seja o primeiro da lista, atualizamos o head
                    if nodeBefore == nil {
                        head = nodeAfter
                        return
                    }
                    
                    //Atualizamos as posicoes
                    nodeBefore?.next = nodeAfter
                    return
                }
                
                //Retornamos os valores depois da exclusao da referencia
                nodeBefore = current
                current = current?.next
            }
        }
}

/*
// Test cases for vinculedad list

// Set up some Nodes
let n1 = Node(value: 1)
let n2 = Node(value: 2)
let n3 = Node(value: 3)
let n4 = Node(value: 4)

// Start setting up a LinkedList
let ll = LinkedList(head: n1)
ll.append(n2)
ll.append(n3)

// Test getNode(atPosition:)
print(ll.head!.next!.next!.value) // Should print 3
print(ll.getNode(atPosition: 3)!.value) // Should also print 3

  
// Test insert
ll.insertNode(n4, at: 3)
print(ll.getNode(atPosition: 3)!.value) // Should print 4 now

// Test delete(withValue:)

ll.deleteNode(withValue: 1)
print(ll.getNode(atPosition: 1)!.value) // Should print 2 now
print(ll.getNode(atPosition: 2)!.value) // Should print 4 now
print(ll.getNode(atPosition: 3)!.value) // Should print 3
*/

// Test cases for stacks
// Set up some nodes
let n1 = Node(value: 1)
let n2 = Node(value: 2)
let n3 = Node(value: 3)
let n4 = Node(value: 4)

// Start setting up a Stack
let stack = Stack(top: n1)

// Test stack functionality

stack.push(n2)
stack.push(n3)
print(stack.pop()!.value) // Should be 3
print(stack.pop()!.value) // Should be 2
print(stack.pop()!.value) // Should be 1
print(stack.pop()?.value) // Should be nil
stack.push(n4)
print(stack.pop()!.value) // Should be 4

