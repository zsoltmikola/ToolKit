
@class TKLogMessage;

@protocol TKLogCollectorDelegate <NSObject>

@property (nonatomic, assign) BOOL useRelativeTimes;

- (void)logMessage:(TKLogMessage*)message;

@end
