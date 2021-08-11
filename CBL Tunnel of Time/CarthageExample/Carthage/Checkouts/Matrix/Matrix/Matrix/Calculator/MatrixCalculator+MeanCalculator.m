//
//  MatrixCalculator+MeanCalculator.m
//  Matrix
//
//  Created by Jéssica Araujo on 26/07/21.
//

#import "MatrixCalculator+MeanCalculator.h"

@implementation MatrixCalculator (MeanCalculator)

-(NSArray*) mean: (NSMutableArray*) matrix {
    
    NSMutableArray *means = [[NSMutableArray alloc] init];
    
    int j = 0;
    
    for (int i=0; i < [matrix count]; i++) {
        
        double sumPerArray = 0.0;
        j =0;
        for(NSNumber *element in [matrix objectAtIndex:i]) {
            
            sumPerArray += [element doubleValue];
            ++j;
        }
        
        double meanPerArray = sumPerArray / [[matrix objectAtIndex:i] count];
        [means addObject: [NSNumber numberWithDouble: meanPerArray]];
    }
    
    return [NSArray arrayWithObject:means];
}

-(NSArray*) totalMean: (NSMutableArray *) matrix {
    
    int count = 0, j = 0;
    double totalSum = 0.0;
    
    for (int i=0; i < [matrix count]; i++) {

        for(NSNumber *element in [matrix objectAtIndex:i]) {
            
            totalSum += [element doubleValue];
            ++count;
            ++j;
        }
    }
    
    NSNumber *total = [NSNumber numberWithDouble: totalSum/count];
    
    return [NSArray arrayWithObject:total]; 
}

@end
