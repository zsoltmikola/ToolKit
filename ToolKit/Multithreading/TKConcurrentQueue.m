/**
 * @file    TKConcurrentQueue.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKConcurrentQueue.h"

@interface TKQueue ()

@property (nonatomic, strong) dispatch_queue_t queue;

@end


@implementation TKConcurrentQueue

+ (void)runBlock:(void (^)(void))block{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

+ (void)dispatchBlock:(void (^)(void))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

+ (void)dispatchBarrierBlock:(void (^)(void))block{
    dispatch_barrier_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

- (instancetype)initWithDomain:(const char*)domain{
    
    if (!(self = [super init])) return self;
    
    self.queue = dispatch_queue_create(domain, DISPATCH_QUEUE_CONCURRENT);
    
    return self;
}

- (void)dispatchBarrierBlock:(void (^)(void))block{
    
    dispatch_barrier_async(self.queue, block);
    
}

@end