/**
 * @file    TKMultithreading.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

////////////////////////////////////////////////////////////////////////////////
// NSObject methods to handle multithreading
// -----------------------------------------------------------------------------
@implementation NSObject (TKMultithreading)

- (void)dispatchBlock:(void (^)(void))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

- (void)dispatchBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue{
    dispatch_async(queue, block);
}

- (void)dispatchBarrierBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue{
    dispatch_barrier_async(queue, block);
}

- (void)runBlock:(void (^)(void))block{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

-(void)runBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue{
    dispatch_sync(queue, block);
}

// -----------------------------------------------------------------------------

+  (void)initBlock:(void(^)(id))block{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        block([[self class] new]);
    });
    
}


@end

////////////////////////////////////////////////////////////////////////////////
// UIView methods to handle multithreading (NSObject methods overwritings)
// -----------------------------------------------------------------------------
@implementation UIView (TKMultithreading)

- (void)dispatchBlock:(void(^)(void))block{
    dispatch_async(dispatch_get_main_queue(), block);
}

- (void)runBlock:(void (^)(void))block{
    dispatch_async(dispatch_get_main_queue(), block);
}

// -----------------------------------------------------------------------------

+  (void)initBlock:(void(^)(id))block{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        block([[self class] new]);
    });
    
}

@end