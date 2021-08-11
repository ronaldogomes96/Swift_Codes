//
//  MatrixSubtractorCalculatorTests.m
//  MatrixTests
//
//  Created by Ronaldo Gomes on 23/07/21.
//

#import <XCTest/XCTest.h>
#import "MatrixCalculator.h"

@interface MatrixSubtractorCalculatorTests : XCTestCase

@property MatrixCalculator *matrixCalculator;

@property NSMutableArray *matrixOne;
@property NSMutableArray *matrixTwo;

@property NSMutableArray *rowsOne;
@property NSMutableArray *rowsTwo;

@property NSMutableArray *rowsThree;
@property NSMutableArray *rowsFour;

@end

@implementation MatrixSubtractorCalculatorTests

- (void)setUp {
    self.matrixCalculator = [MatrixCalculator alloc];
    
    self.matrixOne = [[NSMutableArray alloc] init];
    self.matrixTwo = [[NSMutableArray alloc] init];
    
    self.rowsOne = [[NSMutableArray alloc] init];
    self.rowsTwo = [[NSMutableArray alloc] init];
    self.rowsThree = [[NSMutableArray alloc] init];
    self.rowsFour = [[NSMutableArray alloc] init];
    
    [self.rowsOne addObject:[NSNumber numberWithDouble:2.0]];
    [self.rowsOne addObject:[NSNumber numberWithDouble:4.0]];
    [self.rowsOne addObject:[NSNumber numberWithDouble:8.0]];
    
    [self.rowsTwo addObject:[NSNumber numberWithDouble:0.0]];
    [self.rowsTwo addObject:[NSNumber numberWithDouble:2.0]];
    [self.rowsTwo addObject:[NSNumber numberWithDouble:4.0]];
    
    [self.rowsThree addObject:[NSNumber numberWithDouble:0.0]];
    [self.rowsThree addObject:[NSNumber numberWithDouble:-4.0]];
    [self.rowsThree addObject:[NSNumber numberWithDouble:16.0]];
    
    [self.rowsFour addObject:[NSNumber numberWithDouble:-2.0]];
    [self.rowsFour addObject:[NSNumber numberWithDouble:1.0]];
    [self.rowsFour addObject:[NSNumber numberWithDouble:3.0]];
}

- (void) test_subtraction_emptyMatrix_returnsNil {
    XCTAssertThrows([self.matrixCalculator subtractionMatrix: self.matrixOne toMatrix:self.matrixTwo]);
}

- (void) test_subtraction_differentSizes_returnsNil {
    //given
    [self.matrixOne insertObject:self.rowsOne atIndex:0];
    [self.matrixOne insertObject:self.rowsTwo atIndex:1];
    
    [self.matrixTwo insertObject:self.rowsOne atIndex:0];
    
    //Then
    XCTAssertThrows([self.matrixCalculator subtractionMatrix: self.matrixOne toMatrix:self.matrixTwo]);

}

-(void) test_subtraction_twoArrays_returnsValue {
    //given
    NSMutableArray *expectedResult = [[NSMutableArray alloc] init];
    
    NSMutableArray *rowsResultOne = [[NSMutableArray alloc] init];
    NSMutableArray *rowsResultTwo = [[NSMutableArray alloc] init];
    
    [rowsResultOne addObject:[NSNumber numberWithDouble:2.0]];
    [rowsResultOne addObject:[NSNumber numberWithDouble:8.0]];
    [rowsResultOne addObject:[NSNumber numberWithDouble:-8.0]];
    
    [rowsResultTwo addObject:[NSNumber numberWithDouble:2.0]];
    [rowsResultTwo addObject:[NSNumber numberWithDouble:1.0]];
    [rowsResultTwo addObject:[NSNumber numberWithDouble:1.0]];
    
    [expectedResult insertObject:rowsResultOne atIndex:0];
    [expectedResult insertObject:rowsResultTwo atIndex:1];
    
    
    [self.matrixOne insertObject:self.rowsOne atIndex:0];
    [self.matrixTwo insertObject:self.rowsThree atIndex:0];
    
    [self.matrixOne insertObject:self.rowsTwo atIndex:1];
    [self.matrixTwo  insertObject:self.rowsFour atIndex:1];
    
    //when
    NSArray *result = [self.matrixCalculator subtractionMatrix: self.matrixOne toMatrix:self.matrixTwo];
    
    //then
    XCTAssertEqualObjects(result, expectedResult);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
