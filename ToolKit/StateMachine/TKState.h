

#import <Foundation/Foundation.h>

@interface TKState : NSObject

@property (nonatomic, weak) NSMutableSet* destinationStates;

- (void)willMakeTransitionTo:(Class)state;
- (void)didMakeTransitionFrom:(Class)state;

@end
