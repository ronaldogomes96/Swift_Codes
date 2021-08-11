//
//  MatrixCalculator+GetColumn.h
//  Matrix
//
//  Created by Jéssica Araujo on 26/07/21.
//

#import "MatrixCalculator.h"

NS_ASSUME_NONNULL_BEGIN

@interface MatrixCalculator (GetColumn)

-(NSMutableArray*) getColumn: (NSMutableArray*) matrix
                  atPosition: (int) index;

@end

NS_ASSUME_NONNULL_END
