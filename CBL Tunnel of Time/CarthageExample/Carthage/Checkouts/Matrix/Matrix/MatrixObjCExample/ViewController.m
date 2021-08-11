//
//  ViewController.m
//  MatrixObjCExample
//
//  Created by Ronaldo Gomes on 26/07/21.
//

#import "ViewController.h"
#import "MatrixCalculator.h"

@interface ViewController ()

//@property NSArray *matrixOne;
//@property NSArray *matrixTwo;
//@property NSArray *matrixThree;
//@property NSArray *matrixFour;
//@property NSNumber *number;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MatrixCalculator *matrix = [MatrixCalculator alloc];
    
    NSArray *matrixOne = @[@[@1, @3]];
    NSArray *matrixTwo = @[@[@4, @5]];
    NSArray *matrixThree = @[@[@10.2, @18.5], @[@11.3, @-3.2]];
    NSArray *matrixFour = @[@[@1, @0], @[@3, @-9]];
    NSNumber *number = @2.3;

    // Sum
    NSArray *resultSum = [matrix sumMatrix: matrixThree toMatrix: matrixFour];
    for (int i=0; i < [resultSum count]; i++) {
        for (int j=0; j < [resultSum.firstObject count]; j++) {
            NSLog(@"%@", resultSum[i][j]);
        }
        NSLog(@"\n");
    }
    
    // Subtraction
    NSArray *resultSubtraction = [matrix subtractionMatrix: matrixTwo toMatrix: matrixOne];
    for (int i=0; i < [resultSubtraction count]; i++) {
        for (int j=0; j < [resultSubtraction.firstObject count]; j++) {
            NSLog(@"%@", resultSubtraction[i][j]);
        }
        NSLog(@"\n");
    }
    
    // Multiply by scalar
    NSArray *resultMultiplyByScalar = [matrix multiplyMatrix: matrixOne toScalar: number];
    for (int i=0; i < [resultMultiplyByScalar count]; i++) {
        for (int j=0; j < [resultMultiplyByScalar.firstObject count]; j++) {
            NSLog(@"%@", resultMultiplyByScalar[i][j]);
        }
        NSLog(@"\n");
    }
    
    // Mean
    NSArray *resultMean = [matrix meanMatrix:matrixFour axis:total];
    NSLog(@"%@", resultMean);
    
    // Print
    [matrix printMatrix:matrixThree];
}

@end
