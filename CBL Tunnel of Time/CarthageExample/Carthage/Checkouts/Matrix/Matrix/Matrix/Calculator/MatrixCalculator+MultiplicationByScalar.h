//
//  MatrixCalculator+MultiplicationByScalar.h
//  Matrix
//
//  Created by Jéssica Araujo on 23/07/21.
//

#import "MatrixCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatrixCalculator (MultiplicationByScalar)

-(NSMutableArray*) multiply: (nonnull NSMutableArray*) matrix
              toScalar: (NSNumber*) scalar;

@end

NS_ASSUME_NONNULL_END
