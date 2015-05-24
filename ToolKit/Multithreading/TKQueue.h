/**
 * @file    TKQueue.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import <Foundation/Foundation.h>

/**
 * Serial queue
 *
 * A serial queue implementation with the help of GCD
 */

@interface TKQueue : NSObject

/**
 * Runs a block on the main thread
 *
 * Exclusively executes a block on the default main thread. Blocks the UI during
 * execution. Use with extreme caution!
 *
 * @param block The block, which needs to be run on the main queue/thread.
 * @return void
 */
+ (void)runBlock:(void (^)(void))block;

/**
 * Initializes a custom (serial) queue with a domain.
 *
 * @param domain The domain of the queue
 * @return TKQueue
 */
- (instancetype)initWithDomain:(const char*)domain;

/**
 * Dispatches / enqueues a block on the previously setup custom queue. It doesn't
 * wait for either the execution of the block or its finish.
 *
 * @param block The block, which needs to be dispatched on the custom queue.
 * @return void
 */
- (void)dispatchBlock:(void (^)(void))block;

/**
 * Waits until the previously setup custom queue becomes empty, then executes the
 * block and waits until it finishes.
 *
 * @param block The block, which needs to be run on the custom queue.
 * @return void
 */
- (void)runBlock:(void (^)(void))block;

@end

