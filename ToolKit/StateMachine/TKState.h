

#import <Foundation/Foundation.h>

@interface TKState : NSObject

@property (nonatomic, strong) NSMutableSet* destinationStates;

- (void)willMakeTransitionTo:(Class)state;
- (void)didMakeTransitionFrom:(Class)state;

@end
