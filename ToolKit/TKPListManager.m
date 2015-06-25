/**
 * @file    TKPListManager.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import <UIKit/UIKit.h>
#import "TKPListManager.h"

@interface TKPListManager ()

@property (nonatomic, strong) NSUserDefaults* standardUserDefaults;

@end

@implementation TKPListManager

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    return self;
}

- (void)setObject:(id)object forKeyedSubscript:(NSString*)key{
    
    if (!key) {
        return;
    }
    
    // if object is nil, remove the entry
    if (!object) {
        [_standardUserDefaults removeObjectForKey:key];
        
        [_standardUserDefaults synchronize];
        
        return;
    }
    
    NSMutableArray *parts;
    
    if ([key rangeOfString:@"."].length == 0) {
        parts = @[key].mutableCopy;
    }else{
        parts = [key componentsSeparatedByString:@"."].mutableCopy;
    }
    
    NSString* root = parts.firstObject;
    
    [parts removeObjectAtIndex:0];
    
    // if key was a simple name, store the value
    if (!parts.count) {
        [_standardUserDefaults setValue:object forKey:key];
        
        [_standardUserDefaults synchronize];
        
        return;
    }
    
    // parts > 1, so we're storing a dictionary
    id storedObject = [_standardUserDefaults objectForKey:root];
    
    // If there is no value for the key yet, try to load a supplied bundle plist
    if (!storedObject) {
        [self loadBundlePlist:root];
        storedObject = [_standardUserDefaults objectForKey:root];
    }
    
    NSMutableDictionary* value;
    
    // If the original stored object is a dictionary, then use keypath,
    // else replace the original value with a dictionary
    
    if ([storedObject isKindOfClass:[NSDictionary class]]) {
        value = ((NSDictionary*)storedObject).mutableCopy;
        // TODO: Check if the path exists in this dictionary. If not, create it
    }else{
        if (storedObject) {
            [_standardUserDefaults removeObjectForKey:root];
        }
        
        value = [NSMutableDictionary dictionaryWithCapacity:0];
        NSMutableDictionary* temp = value;
        for (NSString* keyPart in parts) {
            temp[keyPart] = @{}.mutableCopy;
            temp = temp[keyPart];
        }
    }
    
    [value setValue:object forKeyPath:[parts componentsJoinedByString:@"."]];
    
    [_standardUserDefaults setObject:value forKey:root];
    
    [_standardUserDefaults synchronize];
    
    return;
}

- (id)objectForKeyedSubscript:(NSString*)key{
    
    // Check user defaults for the value. If there is, return the object.
    if ([_standardUserDefaults valueForKeyPath:key]){
        return [_standardUserDefaults valueForKeyPath:key];
    }
    
    // Load the supplied plist file
    NSArray *parts = [key componentsSeparatedByString:@"."];
    [self loadBundlePlist:parts.firstObject];

    return [_standardUserDefaults valueForKeyPath:key];
}

- (void)loadBundlePlist:(NSString*)plist{
    
    NSString *plistFile = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist" inDirectory:@""];
    
    // If there is no plist file like that, return
    if(![[NSFileManager defaultManager] fileExistsAtPath:plistFile]){
        return;
    }
    
    NSDictionary* newDefaults = @{plist : [[NSDictionary alloc] initWithContentsOfFile:plistFile]};
    
    // If there is no values in the file, return nil
    if (!newDefaults[plist]){
        return;
    }
    
    // Register the plist file the user defaults
    [_standardUserDefaults registerDefaults:newDefaults];
 
    [_standardUserDefaults synchronize];
    
}

@end
