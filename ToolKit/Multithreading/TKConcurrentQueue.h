//
//  TKConcurrentQueue.h
//  toolkit
//
//  Created by Zsolt Mikola on 19/05/15.
//  Copyright (c) 2015 Zsolt Mikola. All rights reserved.
//

#import "TKQueue.h"

/**
 * Concurrent queue
 *
 * <#multiline detailed description#>
 */

@interface TKConcurrentQueue : TKQueue

+ (void)dispatchBlock:(void (^)(void))block;
+ (void)dispatchBarrierBlock:(void (^)(void))block;

- (void)dispatchBarrierBlock:(void (^)(void))block;

@end

