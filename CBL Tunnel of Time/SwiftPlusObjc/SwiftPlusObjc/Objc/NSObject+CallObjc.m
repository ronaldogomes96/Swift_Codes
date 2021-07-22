//
//  NSObject+CallObjc.m
//  SwiftPlusObjc
//
//  Created by Ronaldo Gomes on 22/07/21.
//

#import "NSObject+CallObjc.h"

@implementation CallObjc: NSObject

- (void) PrintMessage {
    NSLog(@"This is a objc function call");
}

- (void) ShowMyName:(NSString *) name {
    NSLog(@"My name is %@", name);
}

-(NSArray *) ReturnMyArray: (NSArray *) array {
    return array;
}

@end
