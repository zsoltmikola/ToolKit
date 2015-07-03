
#import <stdio.h>
#import "TKQueue.h"

#import "TKLogCollectorTerminal.h"
#import "TKLogMessage.h"

@interface TKLogCollectorTerminal ()

@property (nonatomic, strong) TKQueue* queue;
@property (nonatomic, strong)  NSMutableDictionary* previousMediaTimes;

@end

@implementation TKLogCollectorTerminal

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _queue = [[TKQueue alloc] initWithDomain:"com.toolkit.log.terminal"];
    _previousMediaTimes = @{}.mutableCopy;
    _useRelativeTimes = NO;
    
    return self;
}

- (void)logMessage:(TKLogMessage *)message{

    if (self.format) {
        message.format = self.format;
    }
    
    if (_useRelativeTimes) {
        CFTimeInterval mediaTimeDelta = 0;
        NSNumber* previousMediaTime = _previousMediaTimes[message.domain];
        
        if (previousMediaTime) {
            mediaTimeDelta =  message.mediaTime - previousMediaTime.doubleValue;
        }
        _previousMediaTimes[message.domain] = @(message.mediaTime);
        
        message.format = [message.format stringByReplacingOccurrencesOfString:@"<time>" withString:[NSString stringWithFormat:@"%f s", mediaTimeDelta] options:NSLiteralSearch range:NSMakeRange(0, message.format.length)];
    }
    
    [self.queue dispatch:^{
        puts([message.description cStringUsingEncoding:NSUTF8StringEncoding]);
        
    }];
    
}

@end
