
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
    
    _processingQueue = [[TKQueue alloc] initWithDomain:"toolkit.statemachine"];
    _states = @{}.mutableCopy;
   
    return self;
}

- (void)addStates:(NSArray *)states{
    [_processingQueue run:^{
        for (Class state in states) {
            _states[[state description]] = [state new];
        }
    }];
}

- (void)addTransitionsFromState:(Class)source toStates:(NSArray *)destinations{
    
    [_processingQueue run:^{
        
        TKState* sourceState = _states[[source description]];
        
        for (Class state in destinations) {
            [sourceState.destinationStates addObject:[state description]];
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
                currentState = _states[[_state description]];
                [currentState didMakeTransitionFrom:temp];
            }else{
                _state = state;
            }
        }
    }];

}

- (BOOL)isValidDestinationState:(Class)state{
    TKState* currentState = _states[[_state description]];
    return currentState ? ([currentState.destinationStates containsObject:[state description]] && _states[[state description]]) : YES;
}

@end
