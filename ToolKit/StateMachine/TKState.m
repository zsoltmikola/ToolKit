

#import "TKState.h"

@implementation TKState

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _destinationStates = [NSMutableSet set];
    
    return self;
}

- (void)willMakeTransitionTo:(Class)state{

}

- (void)didMakeTransitionFrom:(Class)state{
    
}

@end
