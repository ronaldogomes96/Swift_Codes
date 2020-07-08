import Foundation

// Get the fibonacci number at the position in the sequence
// be sure to check the base case, and recursively call getFib
func getFib(_ position: Int) -> Int {
    if position == 0 || position == 1 {
        return position
    }
    
    return getFib(position - 1) + getFib(position - 2)
}

//Test cases
print(getFib(9)) // Should be 34
print(getFib(11)) // Should be 89
print(getFib(0)) // Should be 0


