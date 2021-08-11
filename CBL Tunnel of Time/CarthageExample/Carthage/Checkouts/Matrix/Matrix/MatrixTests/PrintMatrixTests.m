//
//  PrintMatrixTests.m
//  MatrixTests
//
//  Created by Jéssica Araujo on 27/07/21.
//

#import <XCTest/XCTest.h>
#import "MatrixCalculator.h"


@interface PrintMatrixTests : XCTestCase

@property MatrixCalculator *matrixCalculator;

@end

@implementation PrintMatrixTests

- (void)setUp {
    self.matrixCalculator = [MatrixCalculator alloc];
}

- (void)testPrintMatrix {
    //given
    NSArray *array = @[@[@3.0, @1.0, @2.0], @[@1.0, @2.0, @3.0]];
    
    //then
    XCTAssertNoThrow([self.matrixCalculator printMatrix:array]);
}


- (void)testPrintVectorMatrix {
    //given
    NSArray *array = @[@[@3.0, @1.0, @2.0]];
    
    //then
    XCTAssertNoThrow([self.matrixCalculator printMatrix:array]);
}


- (void)testNullMatrixException {
    //given
    NSArray *array = @[];
    
    //then
    XCTAssertThrows([self.matrixCalculator printMatrix:array]);
}

- (void)testNoMatrixException {
    //given
    NSArray *arrayOne = @[@[]];
    NSArray *arrayTwo = @[];
    
    //then
    XCTAssertThrows([self.matrixCalculator printMatrix:arrayOne]);
    XCTAssertThrows([self.matrixCalculator printMatrix:arrayTwo]);
}


@end
