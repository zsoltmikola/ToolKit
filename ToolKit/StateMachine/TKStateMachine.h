#import <Foundation/Foundation.h>

@interface TKStateMachine : NSObject

@property (nonatomic, weak) Class state;

- (void)addTransitionsFromState:(Class)state toStates:(NSArray *)destinations;
- (id)stateForKey:(Class)state;

@end
