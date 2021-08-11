//
//  MatrixMultiplicationByScalarTests.m
//  MatrixTests
//
//  Created by Jéssica Araujo on 23/07/21.
//

#import <XCTest/XCTest.h>
#import "MatrixCalculator.h"

@interface MatrixMultiplicationByScalarTests : XCTestCase

@property MatrixCalculator *matrixCalculator;
@property NSMutableArray *matrix;

@property NSMutableArray *rowsOne;
@property NSMutableArray *rowsTwo;

@end

@implementation MatrixMultiplicationByScalarTests

- (void)setUp {
    
    self.matrixCalculator = [MatrixCalculator alloc];
    
    self.matrix = [[NSMutableArray alloc] init];
    
    self.rowsOne = [[NSMutableArray alloc] init];
    self.rowsTwo = [[NSMutableArray alloc] init];
    
    [self.rowsOne addObject:[NSNumber numberWithDouble:0.0]];
    [self.rowsOne addObject:[NSNumber numberWithDouble:1.0]];
    [self.rowsOne addObject:[NSNumber numberWithDouble:2.0]];
    
    [self.rowsTwo addObject:[NSNumber numberWithDouble:1.0]];
    [self.rowsTwo addObject:[NSNumber numberWithDouble:2.0]];
    [self.rowsTwo addObject:[NSNumber numberWithDouble:3.0]];
    
    [self.matrix insertObject:self.rowsOne atIndex:0];
    [self.matrix insertObject:self.rowsTwo atIndex:1];
}

- (void)testMultiplicationByScalarGreaterThanZero {
   
    //given
    NSNumber *scalar = [NSNumber numberWithDouble:4.0];
    
    NSMutableArray *expectedResult = [[NSMutableArray alloc] init];
    
    NSMutableArray *rowsThree = [[NSMutableArray alloc] init];
    NSMutableArray *rowsFour = [[NSMutableArray alloc] init];
    
    [rowsThree addObject:[NSNumber numberWithDouble:0.0]];
    [rowsThree addObject:[NSNumber numberWithDouble:4.0]];
    [rowsThree addObject:[NSNumber numberWithDouble:8.0]];
    
    [rowsFour addObject:[NSNumber numberWithDouble:4.0]];
    [rowsFour addObject:[NSNumber numberWithDouble:8.0]];
    [rowsFour addObject:[NSNumber numberWithDouble:12.0]];
    
    [expectedResult insertObject:rowsThree atIndex:0];
    [expectedResult insertObject:rowsFour atIndex:1];
    
    //when
    NSArray *result = [self.matrixCalculator multiplyMatrix:self.matrix toScalar:scalar];
    
    //then
    XCTAssertEqualObjects(result, expectedResult);
}

- (void)testMultiplicationByScalarEqualToZero {
   
    //given
    NSNumber *scalar = [NSNumber numberWithDouble:0.0];
    
    NSMutableArray *expectedResult = [[NSMutableArray alloc] init];
    
    NSMutableArray *rowsThree = [[NSMutableArray alloc] init];
    NSMutableArray *rowsFour = [[NSMutableArray alloc] init];
    
    [rowsThree addObject:[NSNumber numberWithDouble:0.0]];
    [rowsThree addObject:[NSNumber numberWithDouble:0.0]];
    [rowsThree addObject:[NSNumber numberWithDouble:0.0]];
    
    [rowsFour addObject:[NSNumber numberWithDouble:0.0]];
    [rowsFour addObject:[NSNumber numberWithDouble:0.0]];
    [rowsFour addObject:[NSNumber numberWithDouble:0.0]];
    
    [expectedResult insertObject:rowsThree atIndex:0];
    [expectedResult insertObject:rowsFour atIndex:1];
    
    //when
    NSArray *result = [self.matrixCalculator multiplyMatrix:self.matrix toScalar:scalar];
    
    //then
    XCTAssertEqualObjects(result, expectedResult);
}


- (void)testMultiplicationByScalarEqualToNull {
   
    NSNumber *scalar = NULL;
    
    XCTAssertThrows([self.matrixCalculator multiplyMatrix:self.matrix toScalar:scalar]);
}

- (void)testMultiplicationByScalarWithMatrixEqualToNull {
    
    NSNumber *scalar = [NSNumber numberWithDouble:0.0];
    self.matrix = NULL;
    
    XCTAssertThrows([self.matrixCalculator multiplyMatrix:self.matrix toScalar:scalar]);
}



- (void)testMultiplicationByScalarLessThanZero {
   
    //given
    NSNumber *scalar = [NSNumber numberWithDouble:-1.0];
    
    NSMutableArray *expectedResult = [[NSMutableArray alloc] init];
    
    NSMutableArray *rowsThree = [[NSMutableArray alloc] init];
    NSMutableArray *rowsFour = [[NSMutableArray alloc] init];
    
    [rowsThree addObject:[NSNumber numberWithDouble:0.0]];
    [rowsThree addObject:[NSNumber numberWithDouble:-1.0]];
    [rowsThree addObject:[NSNumber numberWithDouble:-2.0]];
    
    [rowsFour addObject:[NSNumber numberWithDouble:-1.0]];
    [rowsFour addObject:[NSNumber numberWithDouble:-2.0]];
    [rowsFour addObject:[NSNumber numberWithDouble:-3.0]];
    
    [expectedResult insertObject:rowsThree atIndex:0];
    [expectedResult insertObject:rowsFour atIndex:1];
    
    //when
    NSArray *result = [self.matrixCalculator multiplyMatrix:self.matrix toScalar:scalar];
    
    //then
    XCTAssertEqualObjects(result, expectedResult);
}

@end
