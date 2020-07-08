import Foundation


// Return the index in the array, of the desired value
// If the value can't be found, return nil
func binarySearch(_ array: [Int], value: Int) -> Int? {
    // Your code goes here
    
    var lowIndex = 0
    var highIndex = array.count - 1

    while lowIndex <= highIndex {
        //Tiramos a metade do index
        let midIndex = (lowIndex + highIndex) / 2
        
        //Caso seja o valor
        if array[midIndex] == value {
            return midIndex
        }
        
        else if array[midIndex] < value {
            lowIndex = midIndex + 1
        }
        else {
            highIndex = midIndex - 1
        }
    }
    return nil
}

// Test cases
let testArray = [1, 3, 9, 11, 15, 19, 29]
let testVal1 = 25
let testVal2 = 15
print(binarySearch(testArray, value: testVal1)) // Should be nil
print(binarySearch(testArray, value: testVal2)!) // Should be 4
