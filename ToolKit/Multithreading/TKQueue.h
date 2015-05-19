/**
 * @file    TKQueue.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 * Serial queue
 *
 * <#multiline detailed description#>
 */

@interface TKQueue : NSObject

+ (void)runBlock:(void (^)(void))block;

- (instancetype)initWithDomain:(const char*)domain;
- (void)dispatchBlock:(void (^)(void))block;
- (void)runBlock:(void (^)(void))block;

@end

