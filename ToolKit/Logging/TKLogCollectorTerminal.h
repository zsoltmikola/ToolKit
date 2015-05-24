
@import Foundation;
#import "TKLogCollectorDelegate.h"

@interface TKLogCollectorTerminal : NSObject <TKLogCollectorDelegate>

@property (nonatomic, copy) NSString* format;
    
@end
