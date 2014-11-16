
#import "TKLogCollectorTerminal.h"
#import "TKMultithreading.h"
#import <sys/uio.h>
#import <unistd.h>


@implementation TKLogCollectorTerminal

/**
 * @brief Singleton contructor of the class
 * @return id: The singleton object
 */

+ (dispatch_queue_t)sharedQueue {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken; // <- Makes sure that the instance is initiated once and only once (threads!)
    dispatch_once(&onceToken, ^{
        // Setup a queue for threadsafe working
        queue = dispatch_queue_create("com.toolkit.log.terminal", DISPATCH_QUEUE_SERIAL);
        dispatch_queue_t priority = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        dispatch_set_target_queue(priority, queue);
    });
    
    return queue;
}

- (void)logMessage:(TKLogMessage *)message{
    
    if (nil == _converter) return;
    
    NSString* msg = [_converter convert:message];
    
    [self dispatchBlock:^{

        puts([msg cStringUsingEncoding:NSUTF8StringEncoding]);
        
    } onQueue:[TKLogCollectorTerminal sharedQueue]];
    
}

@end
