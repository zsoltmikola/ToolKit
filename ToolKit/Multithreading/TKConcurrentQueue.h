/**
 * @file    TKConcurrentQueue.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKQueue.h"

/**
 * Concurrent queue
 *
 * A concurrent queue implementation with the help of GCD. Inherits some behaviour
 * from the serial queue, and overwrites others to conform to the concurrent behaviour.
 */

@interface TKConcurrentQueue : TKQueue

/**
 * Dispatches a block on the default global queue
 *
 * @param block The block what needs to be dispatched
 * @return void
 */
+ (void)dispatchBlock:(void (^)(void))block;

/**
 * Dispatches a barrier block on the default global queue
 *
 * Dispatches a block which will be executed when all, previously started other
 * block is finished running. Until it doesn't finish, all other dispatched block
 * is just waiting in the global queue to be started.
 *
 * @param block The block what needs to be dispatched
 * @return void
 */
+ (void)dispatchBarrierBlock:(void (^)(void))block;

/**
 * Dispatches a barrier block on a custom queu
 *
 * Dispatches a block which will be executed when all, previously started other
 * block is finished running. Until it doesn't finish, all other dispatched block
 * is just waiting in the custom queue to be started.
 *
 * @param block The block what needs to be dispatched
 * @return void
 */
- (void)dispatchBarrierBlock:(void (^)(void))block;

@end

