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

+ (void)run:(void (^)(void))block{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

+ (void)dispatch:(void (^)(void))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

+ (void)dispatchBarrier:(void (^)(void))block{
    dispatch_barrier_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    self.queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    return self;
}

- (instancetype)initWithDomain:(const char*)domain{
    
    if (!(self = [super init])) return self;
    
    self.queue = dispatch_queue_create(domain, DISPATCH_QUEUE_CONCURRENT);
    
    return self;
}

- (instancetype)dispatchBarrier:(void (^)(void))block{
    
    dispatch_barrier_async(self.queue, block);
    return self;
}

@end