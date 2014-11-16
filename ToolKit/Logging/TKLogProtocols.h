
#import "TKLogMessage.h"

@protocol TKLogConverter <NSObject>

- (NSString*)convert:(TKLogMessage*)message;

@end

@protocol TKLogCollector <NSObject>

@property (nonatomic, strong) id<TKLogConverter> converter;

- (void)logMessage:(TKLogMessage*)message;

@end
