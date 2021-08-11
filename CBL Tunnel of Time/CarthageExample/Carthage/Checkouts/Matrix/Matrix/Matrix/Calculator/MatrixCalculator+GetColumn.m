//
//  MatrixCalculator+GetColumn.m
//  Matrix
//
//  Created by Jéssica Araujo on 26/07/21.
//

#import "MatrixCalculator+GetColumn.h"

@implementation MatrixCalculator (GetColumn)

-(NSMutableArray*) getColumn: (NSMutableArray*) matrix
                  atPosition: (int) index {
    
    int j;
    NSMutableArray *column = [[NSMutableArray alloc] init];
    
    
    for (int i=0; i < [matrix count]; i++) {
        j =0;
        for(NSNumber *element in [matrix objectAtIndex:i]) {
            
            if (j == index) {
                [column addObject:element];
            }
            ++j;
        }
    }
    return column;
}

@end
