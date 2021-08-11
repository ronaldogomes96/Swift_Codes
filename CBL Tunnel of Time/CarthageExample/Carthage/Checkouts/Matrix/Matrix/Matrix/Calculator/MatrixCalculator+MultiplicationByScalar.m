//
//  MatrixCalculator+MultiplicationByScalar.m
//  Matrix
//
//  Created by Jéssica Araujo on 23/07/21.
//

#import "MatrixCalculator+MultiplicationByScalar.h"

@implementation MatrixCalculator (MultiplicationByScalar)


-(NSMutableArray*) multiply:(nonnull NSMutableArray*) matrix toScalar:(NSNumber*) scalar {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int j = 0;
    
    for (int i=0; i < [matrix count]; i++) {
        
        NSMutableArray *row = [[NSMutableArray alloc] init];
        j =0;
        for(NSNumber *element in [matrix objectAtIndex:i]) {
            
            double number = [element doubleValue];
            
            [row addObject:[NSNumber numberWithDouble: number*[scalar doubleValue]]];
            ++j;
        }
        [result addObject:row];
    }
    return result;
}

@end
