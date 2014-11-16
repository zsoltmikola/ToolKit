
@import Foundation;
#import "TKLogProtocols.h"

@interface TKLogConverterString : NSObject <TKLogConverter>

@property (nonatomic, copy) NSString* format;

@end
