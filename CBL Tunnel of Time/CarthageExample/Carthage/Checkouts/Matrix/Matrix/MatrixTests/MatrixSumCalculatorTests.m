//
//  MatrixSumCalculatorTests.m
//  MatrixTests
//
//  Created by Jéssica Araujo on 23/07/21.
//

#import <XCTest/XCTest.h>
#import "MatrixCalculator.h"

@interface MatrixSumCalculatorTests : XCTestCase

@property MatrixCalculator *matrixCalculator;

@property NSMutableArray *matrixOne;
@property NSMutableArray *matrixTwo;

@property NSMutableArray *rowsOne;
@property NSMutableArray *rowsTwo;

@end

@implementation MatrixSumCalculatorTests

- (void)setUp {
    
    self.matrixCalculator = [MatrixCalculator alloc];
    
    self.matrixOne = [[NSMutableArray alloc] init];
    self.matrixTwo = [[NSMutableArray alloc] init];
    
    self.rowsOne = [[NSMutableArray alloc] init];
    self.rowsTwo = [[NSMutableArray alloc] init];
    
    [self.rowsOne addObject:[NSNumber numberWithDouble:0.0]];
    [self.rowsOne addObject:[NSNumber numberWithDouble:1.0]];
    [self.rowsOne addObject:[NSNumber numberWithDouble:2.0]];
    
    [self.rowsTwo addObject:[NSNumber numberWithDouble:1.0]];
    [self.rowsTwo addObject:[NSNumber numberWithDouble:2.0]];
    [self.rowsTwo addObject:[NSNumber numberWithDouble:3.0]];
}

- (void)testSumWithEmptyMatrix {
    
    XCTAssertThrows([self.matrixCalculator sumMatrix:self.matrixOne toMatrix:self.matrixTwo]);
}

- (void)testSumWithMatricesDifferentDimensions {
    
    //given
    [self.matrixOne insertObject:self.rowsOne atIndex:0];
    [self.matrixOne insertObject:self.rowsTwo atIndex:1];
    
    [self.matrixTwo insertObject:self.rowsOne atIndex:0];
    
    //then
    XCTAssertThrows([self.matrixCalculator sumMatrix:self.matrixOne toMatrix:self.matrixTwo]);
}

-(void)testSumMatrix {
    
    //given
    NSMutableArray *expectedResult = [[NSMutableArray alloc] init];
    
    NSMutableArray *rowsThree = [[NSMutableArray alloc] init];
    NSMutableArray *rowsFour = [[NSMutableArray alloc] init];

    [rowsThree addObject:[NSNumber numberWithDouble:0.0]];
    [rowsThree addObject:[NSNumber numberWithDouble:2.0]];
    [rowsThree addObject:[NSNumber numberWithDouble:4.0]];
    
    [rowsFour addObject:[NSNumber numberWithDouble:2.0]];
    [rowsFour addObject:[NSNumber numberWithDouble:4.0]];
    [rowsFour addObject:[NSNumber numberWithDouble:6.0]];
    
    [expectedResult insertObject:rowsThree atIndex:0];
    [expectedResult insertObject:rowsFour atIndex:1];
    
    
    [self.matrixOne insertObject:self.rowsOne atIndex:0];
    [self.matrixTwo insertObject:self.rowsOne atIndex:0];
    
    [self.matrixOne insertObject:self.rowsTwo atIndex:1];
    [self.matrixTwo  insertObject:self.rowsTwo atIndex:1];
    
    
    //when
    NSArray *result = [self.matrixCalculator sumMatrix:self.matrixOne toMatrix:self.matrixTwo];
    
    //then
    XCTAssertEqualObjects(result, expectedResult);
}


@end
