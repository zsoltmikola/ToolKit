
#import "TKStateMachine.h"
#import "TKState.h"
#import "TKQueue.h"

@interface TKStateMachine ()

// Queue for thread safety
@property (nonatomic, strong) TKQueue* processingQueue;

@property (nonatomic, strong) NSMutableDictionary* states;

@end

@implementation TKStateMachine

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    NSString* domain = [NSString stringWithFormat:@"%@.%@", @"toolkit.statemachine", [self.class description]];
    
    _processingQueue = [[TKQueue alloc] initWithDomain:[domain cStringUsingEncoding:NSASCIIStringEncoding]];
    _states = @{}.mutableCopy;
   
    return self;
}

- (id)stateForKey:(Class)state{
    return _states[[state description]];
}

- (void)addState:(Class)state{
    if (!_states[[state description]]) {
        _states[[state description]] = [state new];
    }
}

- (void)addTransitionsFromState:(Class)state toStates:(NSArray *)destinations{
    
    [self.processingQueue run:^{
        
        [self addState:state];
        
        for (Class destinationState in destinations) {
            [self addState:destinationState];
        }

        TKState* sourceState = _states[[state description]];
        
        for (Class state in destinations) {
            [sourceState.destinationStates addObject:state];
        }
    }];
}

- (void)setState:(Class)state{
    
    [_processingQueue run:^{
        if ([self isValidDestinationState:state]) {
            TKState* currentState = _states[[_state description]];
            if (currentState) {
                [currentState willMakeTransitionTo:state];
                Class temp = _state;
                _state = state;
                [_states[[_state description]] didMakeTransitionFrom:temp];
            }else{
                _state = state;
                [_states[[_state description]] didMakeTransitionFrom:nil];
            }
        }
    }];
}

- (BOOL)isValidDestinationState:(Class)state{
    TKState* currentState = _states[[_state description]];
    return currentState ? ([currentState.destinationStates containsObject:state] && _states[[state description]]) : YES;
}

@end
