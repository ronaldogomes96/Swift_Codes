//
//  MatrixCalculator.h
//  Matrix
//
//  Created by Ronaldo Gomes on 22/07/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

enum Axis {
    x = 0,
    y = 1,
    total = 2
};


@interface MatrixCalculator : NSObject

-(NSArray*) sumMatrix: (NSArray*) matrixOne
                    toMatrix: (NSArray*) matrixTwo;

-(NSArray*) subtractionMatrix: (NSArray*) matrixOne
              toMatrix: (NSArray*) matrixTwo;

-(NSArray*) multiplyMatrix: (NSArray*) matrix
                    toScalar: (NSNumber*) scalar;

-(NSArray*) meanMatrix: (NSArray*) matrix axis: (enum Axis) coordinate;

-(void) printMatrix: (NSArray*) matrix; 

@end

NS_ASSUME_NONNULL_END
