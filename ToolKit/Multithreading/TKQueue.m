/**
 * @file    TKQueue.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKQueue.h"

@interface TKQueue ()

@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation TKQueue

+ (void)run:(void (^)(void))block{
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (instancetype)queueWithDomain:(const char*)domain{
    
    return [[TKQueue alloc] initWithDomain:domain];
}


- (instancetype)initWithDomain:(const char*)domain{
    
    if (!(self = [super init])) return self;
    
    self.queue = dispatch_queue_create(domain, DISPATCH_QUEUE_SERIAL);
    
    return self;
}

- (instancetype)dispatch:(void (^)(void))block{
    dispatch_async(self.queue, block);
    return self;
}

- (instancetype)run:(void (^)(void))block{
    dispatch_sync(self.queue, block);
    return self;
}

@end

