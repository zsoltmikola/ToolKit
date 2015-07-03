/**
 * @file    TKTask.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface TKTask : NSObject

@property (nonatomic, strong) TKTask* nextTask;
@property (nonatomic, copy) TKTask*(^blockToExecute)(id);
@property (nonatomic, strong) id param;
@property (nonatomic, assign) BOOL isMain;
@property (nonatomic, copy) void(^errorBlock)();

- (TKTask*(^)())run;
- (TKTask*(^)())dispatch;
- (void(^)(id))catch;
- (void)execute;
- (void)abortWithError:(NSError*)error;

@end
