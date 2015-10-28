

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

- (BOOL)isEqual:(id)object {
    if (!object) {
        return NO;
    }
    
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToState:object];
}

- (BOOL)isEqualToState:(TKState*)object {
    return  self.class.hash == object.class.hash;
}

- (NSUInteger)hash {
    return self.class.hash;
}

@end
