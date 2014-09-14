/**
 * @file    NSObjectBuilder.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */


@implementation NSObjectBuilder

- (instancetype)init
{
    if (!(self = [super init])) return self;

    _error = [NSError new];
    
    _indeterminateProgress = ^(int progress){
        if (!progress) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
    };
    
    _determinateProgress = ^(int progress){
        if (!progress) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
        
        if (100 == progress) {
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        }
    };

    
    return self;
}

- (void)buildWithCompletionBlock:(void (^)(id))block{
    _indeterminateProgress(INT_MAX);
    _determinateProgress(100);
}



@end
