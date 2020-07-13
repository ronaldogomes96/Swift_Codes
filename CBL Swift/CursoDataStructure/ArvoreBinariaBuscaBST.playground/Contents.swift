import Foundation

class Node {
    
    var value: Int
    var left: Node?
    var right: Node?
    
    init(value: Int) {
        self.value = value
    }
}

class BST {
    
    var root: Node
    
    init(value: Int) {
        self.root = Node(value: value)
    }
    
    func search(_ value: Int) -> Bool {
        
        return searchHelper(root, value: value)
    }
    
    // create a node with the given value and insert it into the binary tree
    func insert(_ value: Int) {
        
        insertHelper(root, value: value)
    }
    
    // helper method - use to implement a recursive search function
    func searchHelper(_ current: Node?, value: Int) -> Bool {
        
        if let current = current {
            let result: Bool
            if current.value == value {
                return true
            }
            else if current.value > value {
                result = searchHelper(current.right, value: value)
            }
            else {
                result = searchHelper(current.left, value: value)
            }
            
            return result
        }
        
        return false
    }
    
    // helper method - use to implement a recursive insert function
    func insertHelper(_ current: Node, value: Int) {
        
        if current.value > value {
            if current.left == nil{
                current.left?.value = value
                return
            }
            else{
                insertHelper(current.left!, value: value)
            }
        }
        else {
            if current.right == nil{
                current.right?.value = value
                return
            }
            else{
                insertHelper(current.right!, value: value)
            }
        }
    }
}

// Test cases
// Set up tree
let tree = BST(value: 4)

// Insert elements
tree.insert(2)
tree.insert(1)
tree.insert(3)
tree.insert(5)

// Check search
print(tree.search(4)) // Should be true
print(tree.search(6)) // Should be false


