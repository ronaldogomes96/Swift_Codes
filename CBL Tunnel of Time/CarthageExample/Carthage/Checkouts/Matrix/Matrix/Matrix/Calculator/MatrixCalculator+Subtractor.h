//
//  MatrixCalculator+Subtractor.h
//  Matrix
//
//  Created by Ronaldo Gomes on 23/07/21.
//

#import "MatrixCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatrixCalculator (Subtractor)

-(NSMutableArray*  _Nullable) subtraction: (NSMutableArray*) matrixOne toMatrix: (NSMutableArray*) matrixTwo;

@end

NS_ASSUME_NONNULL_END
