//
//  MatrixCalculator+Print.m
//  Matrix
//
//  Created by Jéssica Araujo on 27/07/21.
//

#import "MatrixCalculator+Print.h"

@implementation MatrixCalculator (Print)

-(void) print: (NSArray*) matrix {
    
    int i = 0, j=0;
    
    for(NSArray *row in matrix) {
        j =0;
        for(NSNumber *element in [matrix objectAtIndex:i]) {

            printf("    [%d:%d] %s", i,j,[[element stringValue] UTF8String]);
            ++j;
        }
        printf("\n");
        ++i;
    }
}


@end
