#import <Foundation/Foundation.h>

@interface TKStateMachine : NSObject

@property (nonatomic, weak) Class state;

- (void)addStates:(NSArray *)states;
- (void)addTransitionsFromState:(Class)source toStates:(NSArray *)destinations;

@end
