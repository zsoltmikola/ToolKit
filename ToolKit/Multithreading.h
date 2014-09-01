/**
 * @file    Multithreading.h
 * @author  Zsolt Mikola (mail@zsoltmikola.com)
 * @copyright Zsolt Mikola. All rights reserved.
 */

@interface NSObject (multithreading)

+ (void)dispatchBlock:(void(^)(void))block;
+ (void)dispatchBlock:(void(^)(void))block onQueue:(dispatch_queue_t)queue;
+ (void)dispatchBlock:(void(^)(void))block onQueue:(dispatch_queue_t)queue asBarrier:(BOOL)isBarrier;

+ (void)runBlock:(void(^)(void))block;
+ (void)runBlock:(void(^)(void))block onQueue:(dispatch_queue_t)queue;

+ (void)objectForBlock:(void(^)(id))block;

@end
