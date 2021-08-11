//
//  ViewController.swift
//  MatrixSwiftExample
//
//  Created by Ronaldo Gomes on 26/07/21.
//

import UIKit
import Matrix

class ViewController: UIViewController {
    let matrix = MatrixCalculator()
    
    // Matrizes de exemplo
    let mat1 = [[1, 3]]
    
    let mat2 = [[4, 5]]
    
    let mat3 = [[10.2, 18.5],
                [11.3, -3.2]]
    
    let mat4 = [[1, 0],
                [3, -9]]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Sum
        print("\(mat3) + \(mat4)")
        print(matrix.sumMatrix(mat3, toMatrix: mat4))
        
        
        // Subtraction
        print("\(mat2) - \(mat1)")
        print(matrix.subtractionMatrix(mat2, toMatrix: mat1))
        
        // Multiplication for scalar
        print("\(mat1) x \(3)")
        print(matrix.multiplyMatrix(mat1, toScalar: 3))
        
        // Mean Calculator
        print("\(mat4) mean")
        print(matrix.meanMatrix(mat4, axis: total))
        print("\(mat4) mean of lines")
        print(matrix.meanMatrix(mat4, axis: x))
        print("\(mat4) mean of columns")
        print(matrix.meanMatrix(mat4, axis: y))
        
        // Print
        print(matrix.printMatrix(mat3))
    }
}

