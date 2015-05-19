/**
 * @file    TKPListManager.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKPListManager.h"

@interface TKPListManager ()

@property (nonatomic, strong) NSUserDefaults* standardUserDefaults;

@end

@implementation TKPListManager

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    // Synchronize defaults when app resigns from active state
    [[NSNotificationCenter defaultCenter] addObserver:_standardUserDefaults selector:@selector(synchronize) name:UIApplicationWillResignActiveNotification object:nil];
    
    return self;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)valueForKeyPath:(NSString *)keyPath{
    
    // Check in user defaults
    if (nil != [_standardUserDefaults valueForKeyPath:keyPath]){
     return [_standardUserDefaults valueForKeyPath:keyPath];
    }
    
    // No success with user defaults, load the plist file from the bundle, register it to defaults and return the value
    NSArray *parts = [keyPath componentsSeparatedByString:@"."];
    NSString* filename = parts.firstObject;
    NSString *settingsFile = [[NSBundle mainBundle] pathForResource:filename ofType:@"plist" inDirectory:@""];
    
    // If there is not settings file, return nil
    if(![[NSFileManager defaultManager] fileExistsAtPath:settingsFile]) return nil;
    
    NSDictionary* newDefaults = @{filename : [[NSDictionary alloc] initWithContentsOfFile:settingsFile]};
    
    // If there is no values in the file, return nil
    if (!newDefaults[filename]) return nil;
    
    // Register the plist file the user defaults
    [_standardUserDefaults registerDefaults:newDefaults];
    
    return [_standardUserDefaults valueForKeyPath:keyPath];

}

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath{
    NSMutableArray *parts;
    if ([keyPath rangeOfString:@"."].length > 0) {
        parts = [keyPath componentsSeparatedByString:@"."].mutableCopy;
    }else{
        parts = @[keyPath].mutableCopy;
    }
    
    NSString* root = parts.firstObject;
    NSMutableDictionary* settings = [[NSMutableDictionary alloc] initWithDictionary:[self valueForKeyPath:root]];
    
    if (parts.count > 1) {
        [parts removeObjectAtIndex:0];
        [settings setValue:value forKeyPath:[parts componentsJoinedByString:@"."]];
    }else{
        settings = value;
    }
    
    [_standardUserDefaults setObject:settings forKey:root];
}


@end
