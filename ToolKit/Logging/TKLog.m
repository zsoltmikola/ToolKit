
#import "TKLog.h"

@interface TKLog ()

@property (nonatomic, strong) NSMutableDictionary* loggers;

@end

@implementation TKLog

/**
 * @brief Singleton contructor of the class
 * @return id: The singleton object
 */

+ (instancetype)sharedInstance {
    static TKLog *_sharedInstance = nil;
    static dispatch_once_t onceToken; // <- Makes sure that the instance is initiated once and only once (threads!)
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];        
        _sharedInstance.loggers = @{}.mutableCopy;
    });

    return _sharedInstance;
}


- (void)addCollector:(id<TKLogCollector>)collector toDomains:(NSArray *)domains{
    for (NSString* domain in domains) {
        if (nil == _loggers[domain]) {
            _loggers[domain] = @[].mutableCopy;
        }
        [_loggers[domain] addObject:collector];
    }
}

- (NSUInteger)countOfCollectorsInDomain:(NSString *)domain{
    NSArray* loggers = _loggers[domain];
    return loggers.count;
}

- (void)log:(TKLogMessage *)message{

    for (id<TKLogCollector> logger in _loggers[message.domain]) {
        [logger logMessage:message];
    }
}


@end
