/**
 * @file    TKTask.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface TKTask : NSObject

+ (TKTask*)task;
- (TKTask*(^)())run;
- (TKTask*(^)())dispatch;
- (void(^)(id))catch;
- (void)execute;

@end
