/**
 * @file    TKUserDefaults.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKUserDefaults.h"

@implementation TKUserDefaults

/**
 * @brief Singleton contructor of the class
 * @return id: The singleton object
 */

+ (instancetype)sharedInstance {
    static TKUserDefaults *_sharedInstance = nil;
    static dispatch_once_t onceToken; // <- Makes sure that the instance is initiated once and only once (threads!)
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[[self class] alloc] init];
        
        // Synchronize defaults when app resigns from active state
        [[NSNotificationCenter defaultCenter] addObserver:[NSUserDefaults standardUserDefaults] selector:@selector(synchronize) name:UIApplicationWillResignActiveNotification object:nil];
    });
    
    return _sharedInstance;
}

+ (id)valueForKeyPath:(NSString *)keyPath{
    return [[[self class] sharedInstance] valueForKeyPath:keyPath];
}

+ (void)setValue:(id)value forKeyPath:(NSString *)keyPath{
    [[[self class] sharedInstance] setValue:value forKeyPath:keyPath];
}

- (id)valueForKeyPath:(NSString *)keyPath{
    
    // Check in user defaults
    if (nil != [[NSUserDefaults standardUserDefaults] valueForKeyPath:keyPath]){
     return [[NSUserDefaults standardUserDefaults] valueForKeyPath:keyPath];
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
    [[NSUserDefaults standardUserDefaults] registerDefaults:newDefaults];
    
    return [[NSUserDefaults standardUserDefaults] valueForKeyPath:keyPath];

}

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath{
    NSMutableArray *parts = [keyPath componentsSeparatedByString:@"."].mutableCopy;
    NSString* root = parts.firstObject;
    NSMutableDictionary* settings = [[NSMutableDictionary alloc] initWithDictionary:[self valueForKeyPath:root]];
    [parts removeObjectAtIndex:0];
    [settings setValue:value forKeyPath:[parts componentsJoinedByString:@"."]];
    
    [[NSUserDefaults standardUserDefaults] setObject:settings forKey:root];
}


@end
