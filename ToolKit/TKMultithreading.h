/**
 * @file    TKMultithreading.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

@interface NSObject (TKMultithreading)

- (void)dispatchBlock:(void(^)(void))block;
- (void)dispatchBlock:(void(^)(void))block onQueue:(dispatch_queue_t)queue;
- (void)dispatchBarrierBlock:(void(^)(void))block onQueue:(dispatch_queue_t)queue;

- (void)runBlock:(void(^)(void))block;
- (void)runBlock:(void(^)(void))block onQueue:(dispatch_queue_t)queue;

+ (void)initBlock:(void(^)(id))block;

@end
