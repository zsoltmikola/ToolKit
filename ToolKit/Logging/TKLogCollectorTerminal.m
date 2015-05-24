
#import <stdio.h>
#import "TKQueue.h"

#import "TKLogCollectorTerminal.h"
#import "TKLogMessage.h"

@interface TKLogCollectorTerminal ()

@property (nonatomic, strong) TKQueue* queue;

@end

@implementation TKLogCollectorTerminal

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _queue = [[TKQueue alloc] initWithDomain:"com.toolkit.log.terminal"];
   
    return self;
}

- (void)logMessage:(TKLogMessage *)message{
    
    if (self.format) {
        message.format = self.format;
    }   
   
    [self.queue dispatchBlock:^{

        puts([message.description cStringUsingEncoding:NSUTF8StringEncoding]);
        
    }];
    
}

@end
