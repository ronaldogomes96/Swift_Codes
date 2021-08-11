//
//  MatrixCalculator+MeanCalculator.h
//  Matrix
//
//  Created by Jéssica Araujo on 26/07/21.
//

#import "MatrixCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatrixCalculator (MeanCalculator)

-(NSArray*) mean: (NSMutableArray*) matrix;
-(NSArray*) totalMean: (NSMutableArray*) matrix;

@end

NS_ASSUME_NONNULL_END
