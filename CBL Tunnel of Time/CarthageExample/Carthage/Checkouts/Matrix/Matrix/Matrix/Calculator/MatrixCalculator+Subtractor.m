//
//  MatrixCalculator+Subtractor.m
//  Matrix
//
//  Created by Ronaldo Gomes on 23/07/21.
//

#import "MatrixCalculator+Subtractor.h"

@implementation MatrixCalculator (Subtractor)

- (NSMutableArray * _Nullable)subtraction: (NSMutableArray *)matrixOne toMatrix:(NSMutableArray *)matrixTwo {
    //check if the matrices are null
    NSException *nullException = [NSException exceptionWithName:@"NullException" reason:@"The matrix is null" userInfo:nil];
    
    if (matrixOne.count == 0 || matrixTwo.count == 0) {
        @throw nullException;
    }
    
    //check if the dimensions are equal
    NSException *dimensionException = [NSException exceptionWithName:@"DimensionException" reason:@"The dimensions are not equal" userInfo:nil];
    
    if (matrixOne.count != matrixTwo.count || [matrixOne.firstObject count] != [matrixTwo.firstObject count]) {
        @throw dimensionException;
    }
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i=0; i < [matrixOne count]; i++) {
        
        NSMutableArray *row = [[NSMutableArray alloc] init];
        
        for (int j=0; j < [matrixOne.firstObject count]; j++) {
            
            double num1 = [[[matrixOne objectAtIndex:i] objectAtIndex:j] doubleValue];
            double num2 = [[[matrixTwo objectAtIndex:i] objectAtIndex:j] doubleValue];
            
            [row addObject: [NSNumber numberWithDouble: num1 - num2]];
        }
        
        [result insertObject:row atIndex:i];
    }
    
    return result;
}

@end
