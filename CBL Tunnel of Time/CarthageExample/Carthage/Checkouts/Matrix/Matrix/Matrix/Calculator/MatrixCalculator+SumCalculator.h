//
//  MatrixCalculator+SumCalculator.h
//  Matrix
//
//  Created by Jéssica Araujo on 22/07/21.
//

#import "MatrixCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatrixCalculator (SumCalculator)

-(NSMutableArray* _Nullable) sum: (NSMutableArray*) matrixOne
              toMatrix: (NSMutableArray*) matrixTwo;


@end

NS_ASSUME_NONNULL_END
