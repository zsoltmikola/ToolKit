
@class TKLogMessage;

@protocol TKLogCollectorDelegate <NSObject>

@property (nonatomic, assign) BOOL useRelativeTimes;

- (void)compileMessage:(TKLogMessage*)message;

- (void)commit;

@end
