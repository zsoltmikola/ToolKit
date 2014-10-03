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
    [NSObject dispatchBlock:block onQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

- (void)dispatchBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue{
    [NSObject dispatchBlock:block onQueue:queue asBarrier:NO];
}

- (void)dispatchBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue asBarrier:(BOOL)isBarrier{
    if (isBarrier) {
        dispatch_barrier_async(queue, block);
    }else{
        dispatch_async(queue, block);
    }
}

- (void)runBlock:(void (^)(void))block{
    [NSObject runBlock:block onQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

-(void)runBlock:(void (^)(void))block onQueue:(dispatch_queue_t)queue{
    dispatch_sync(queue, block);
}

// -----------------------------------------------------------------------------

-  (void)objectForBlock:(void(^)(id))block{
	   
	[NSObject dispatchBlock:^{
		block([[self class] new]);
	}];

}


@end

////////////////////////////////////////////////////////////////////////////////
// UIView methods to handle multithreading (NSObject methods overwritings)
// -----------------------------------------------------------------------------
@implementation UIView (TKMultithreading)

- (void)dispatchBlock:(void(^)(void))block{
    [NSObject dispatchBlock:block onQueue:dispatch_get_main_queue()];
}

- (void)runBlock:(void (^)(void))block{
    dispatch_sync(dispatch_get_main_queue(), block);
}

// -----------------------------------------------------------------------------

-  (void)objectForBlock:(void(^)(id))block{
	   
	[UIView dispatchBlock:^{
		block([[self class] new]);
	}];
}

@end