import Foundation

class Queue {
    
    var storage: [Int]
    
    init(head: Int) {
        storage = [head]
    }
    
    // add the element to the queue
    func enqueue(_ element: Int) {
        //Adiciona um elemento no fim da lista
        storage.append(element)
    }
    
    // return the next element to be dequeued from the queue
    // if the queue is empty, return nil
    func peek() -> Int? {
        
        //Pega o primeiro elemento da lista,que no caso é o mais antigo
        let element = storage.first
        return element ?? nil
    }
    
    // remove and return the next element to be dequeued
    func dequeue() -> Int? {
        let element = peek()
        //Remove o da primeira posicao
        storage.remove(at: 0)
        return element ?? nil
    }
}

// Test cases

// Setup
let q = Queue(head: 1)
q.enqueue(2)
q.enqueue(3)

// Test peek
print(q.peek()!) // Should be 1

// Test dequeue
print(q.dequeue()!) // Should be 1
 
// Test enqueue
q.enqueue(4)
print(q.dequeue()!) // Should be 2
print(q.dequeue()!) // Should be 3
print(q.dequeue()!) // Should be 4
q.enqueue(5)
print(q.peek()!) // Should be 5
