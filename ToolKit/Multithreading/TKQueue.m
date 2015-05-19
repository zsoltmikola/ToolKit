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

+ (void)runBlock:(void (^)(void))block{
    dispatch_sync(dispatch_get_main_queue(), block);
}

- (instancetype)initWithDomain:(const char*)domain{
    
    if (!(self = [super init])) return self;
    
    _queue = dispatch_queue_create(domain, DISPATCH_QUEUE_SERIAL);
    
    return self;
}

- (void)dispatchBlock:(void (^)(void))block{
    dispatch_async(_queue, block);
}

- (void)runBlock:(void (^)(void))block{
    dispatch_sync(_queue, block);
}

@end

