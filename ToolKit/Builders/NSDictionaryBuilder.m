/**
 * @file    NSDictionaryBuilder.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "NSDictionaryBuilder.h"

@implementation NSDictionaryBuilder

- (void)buildFromJSONData:(NSData*)jsonData withCompletionBlock:(void (^)(NSDictionary*))block{
    
    NSError* error = self.error;
    
    NSDictionary* aDictionary;
        
    if ([NSJSONSerialization isValidJSONObject:jsonData]) {
        aDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    }else{
        aDictionary = @{};
        NSDictionary *userInfo = @{
                                   NSLocalizedDescriptionKey: NSLocalizedString(@"Invalid JSON data", nil),
                                   NSLocalizedFailureReasonErrorKey: NSLocalizedString(@"Invalid JSON data", nil),
                                   NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"Validate the JSON data with a validator", nil)
                                   };
        self.error = [NSError errorWithDomain:@"ToolKit" code:1 userInfo:userInfo];
    }
    
    block(aDictionary);
    
}

@end
