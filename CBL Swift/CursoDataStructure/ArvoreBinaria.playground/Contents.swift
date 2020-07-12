import Foundation

class Node {
    
    var value: Int
    var left: Node?
    var right: Node?
    
    init(value: Int) {
        self.value = value
    }
}

class BinaryTree {
    
    var root: Node
    
    init(rootValue: Int) {
        self.root = Node(value: rootValue)
    }
    
    // Return true if the value is in the tree, otherwise return false
    func search(_ value: Int) -> Bool {
        
        let exists = preorderSearch(tree.root, value: value)
        return exists
    }
    
    // Return a string containing all tree nodes as they are visited in a pre-order traversal.
    func printTree() -> String {
        let result = preorderPrint(root, traverse: "")!
        return String(result[..<result.index(before: result.endIndex)])
    }
    
    // Helper method - use to create a recursive search solution.
    func preorderSearch(_ start: Node?, value: Int) -> Bool {
        
        if start?.value == value{
            return true
        }
        
        else if start?.left == nil && start?.right == nil {
            return false
        }
        
        let left = preorderSearch(start?.left, value: value)
        let right = preorderSearch(start?.right, value: value)
        if left == true || right == true{
            return true
        }
        return false
    }
    
    // Helper method - use to construct a string representing the preordered nodes
    func preorderPrint(_ start: Node?, traverse: String) -> String? {
    
        var result = traverse
        if let start = start {
            result += "\(start.value)-"
            if let newValue = preorderPrint(start.left, traverse: result) {
                result = newValue
            }
            if let newValue = preorderPrint(start.right, traverse: result) {
                result = newValue
            }
        }
        return result
    }
}

// Test cases
// Set up tree
let tree = BinaryTree(rootValue: 1)
tree.root.left = Node(value: 2)
tree.root.right = Node(value: 3)
tree.root.left?.left = Node(value: 4)
tree.root.left?.right = Node(value: 5)

// Test search
print(tree.search(4)) // Should be true
print(tree.search(6)) // Should be false

// Test printTree
print(tree.printTree()) // Should be 1-2-4-5-3


