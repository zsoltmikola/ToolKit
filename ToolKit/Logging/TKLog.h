/**
 * @file    TKLog.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

@import Foundation;

#import "TKLogMessage.h"
#import "TKLogCollectorDelegate.h"

/**
 * Logging library
 *
 * The core of the logging framework.
 * It logs a message with a help of loggers and domains. Loggers and domains are
 * in a n:m relationship, meaning that one logger can be active in more domains
 * and one domain can hold more active loggers.
 * The core logger creates a message which is then routed to its appropriate domain.
 */

@interface TKLog : NSObject

+ (void)log:(TKLogMessage*)message;
+ (void)addCollector:(id<TKLogCollectorDelegate>)collector toDomains:(NSArray*)domains;

@end

#define TKLogMessage(domain, format, ...)\
if(format){\
TKLogMessage* message = [[TKLogMessage alloc] initWithDomain:domain withFile:__FILE__ withLine:__LINE__ withFunction:__FUNCTION__ withFormat:(format), ## __VA_ARGS__ ];\
[TKLog log:message];\
}\

#define TKLogFlow(format, ...) TKLogMessage(@"appflow", format, ##__VA_ARGS__)
#define TKLogPerformance(format, ...) TKLogMessage(@"performance" , format, ##__VA_ARGS__)

#define TKLogDebug(format, ...) TKLogMessage(@"debug" , format, ##__VA_ARGS__)
#define TKLogError(error) TKLogMessage(@"error", error.description)
#define TKLogException(exception) TKLogMessage(@"exception", exception.description)

#import "TKLogCollectorTerminal.h"

