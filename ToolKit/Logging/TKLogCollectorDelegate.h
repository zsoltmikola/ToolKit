
@class TKLogMessage;

@protocol TKLogCollectorDelegate <NSObject>

- (void)logMessage:(TKLogMessage*)message;

@end
