
@import Foundation;

#import "TKLogMessage.h"
#import "TKLogProtocols.h"

@interface TKLog : NSObject

+(instancetype)sharedInstance;

- (void)addCollector:(id<TKLogCollector>)collector toDomains:(NSArray*)domains;
- (NSUInteger)countOfCollectorsInDomain:(NSString*)domain;
- (void)log:(TKLogMessage*)message;

@end

#define TKLogMessage(domain, format, ...)\
if([[TKLog sharedInstance] countOfCollectorsInDomain:domain]){\
TKLogMessage* message = [[TKLogMessage alloc] initWithDomain:domain withFile:__FILE__ withLine:__LINE__ withFunction:__FUNCTION__ withFormat:(format), ## __VA_ARGS__ ];\
[[TKLog sharedInstance] log:message];\
}

#define TKLogWarn(format, ...) TKLogMessage(@"warning", format, ##__VA_ARGS__)
#define TKLogInfo(format, ...) TKLogMessage(@"info" , format, ##__VA_ARGS__)
#define TKLogDebug(format, ...) TKLogMessage(@"debug" , format, ##__VA_ARGS__)
#define TKLogVerbose(format, ...) TKLogMessage(@"verbose" , format, ##__VA_ARGS__)

#import "TKLogCollectorTerminal.h"
#import "TKLogConverterString.h"
