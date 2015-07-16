/**
 * @file    TKLog.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKLog.h"

@interface TKLog ()

@property (nonatomic, strong) NSMutableDictionary* loggers;

@end

@implementation TKLog

+ (instancetype)sharedInstance {
    static TKLog *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];        
        _sharedInstance.loggers = @{}.mutableCopy;
    });

    return _sharedInstance;
}

+ (void)log:(TKLogMessage *)message{

    NSArray* domainLoggers = [TKLog sharedInstance].loggers[message.domain];
    
    if(!domainLoggers.count) return;
    
    for (id<TKLogCollectorDelegate> logger in [TKLog sharedInstance].loggers[message.domain]) {
        [logger compileMessage:message];
        [logger commit];
    }
}

+ (void)addCollector:(id<TKLogCollectorDelegate>)collector toDomains:(NSArray *)domains{
    for (NSString* domain in domains) {
        if (nil == [TKLog sharedInstance].loggers[domain]) {
            [TKLog sharedInstance].loggers[domain] = @[].mutableCopy;
        }
        [[TKLog sharedInstance].loggers[domain] addObject:collector];
    }
}

@end
