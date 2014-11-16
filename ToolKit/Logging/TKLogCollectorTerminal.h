
@import Foundation;
#import "TKLogProtocols.h"

@interface TKLogCollectorTerminal : NSObject <TKLogCollector>

@property (nonatomic, strong) id<TKLogConverter> converter;
    
@end
