import Foundation

// retorna o conteúdo da array de entrada classificada da menor para a maior
// cria as funções auxiliares que você precisa :)
// quer ficar chique? tente fazer da entrada um parâmetro "inout", em vez de copiá-lo para "result"
// more information here: https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Functions.html#//apple_ref/doc/uid/TP40014097-CH10-ID166
func quicksort(_ input: [Int], low: Int, high: Int) -> [Int] {
    // esta é uma cópia da entrada para que seu conteúdo possa ser modificado
    var result = input
    
    if low < high {
        let pivot = result[high]
        var i = low

        for j in low..<high {
            if result[j] <= pivot {
                (result[i], result[j]) = (result[j], result[i])
                i += 1
            }
        }
        (result[i], result[high]) = (result[high], result[i])
        result = quicksort(result, low: low, high: i - 1)
        result = quicksort(result, low: i + 1, high: high)
    }

    return result
}

// Test case
var testArray = [21, 4, 1, 3, 9, 20, 25, 6, 21, 14]
print(quicksort(testArray, low: 0, high: testArray.count - 1))


