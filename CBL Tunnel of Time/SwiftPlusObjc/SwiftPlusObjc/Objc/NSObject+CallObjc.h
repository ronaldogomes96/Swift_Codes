//
//  NSObject+CallObjc.h
//  SwiftPlusObjc
//
//  Created by Ronaldo Gomes on 22/07/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CallObjc: NSObject

- (void) PrintMessage;
- (void) ShowMyName: (NSString*) name;

- (NSArray*) ReturnMyArray: (NSArray*) array;

@end

NS_ASSUME_NONNULL_END
