
#import "TKLogConverterString.h"
#import "TKLogMessage.h"

@implementation TKLogConverterString

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _format = @"[<basefile>(<line>)]<function>:<message>";
    
    return self;
}

- (NSString *)convert:(TKLogMessage *)message{
    
    NSMutableDictionary* params = @{}.mutableCopy;
    params[@"<date>"] = [NSString stringWithUTF8String:message.date];
    params[@"<time>"] = [NSString stringWithUTF8String:message.time];
    params[@"<domain>"] = message.domain;
    params[@"<basefile>"] = [[NSString stringWithUTF8String:message.file] componentsSeparatedByString:@"/"].lastObject;
    params[@"<file>"] = [NSString stringWithUTF8String:message.file];
    params[@"<line>"] = [NSString stringWithFormat:@"%d", message.line];
    params[@"<function>"] = [[NSString stringWithUTF8String:message.function] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    params[@"<message>"] = [[NSString alloc] initWithFormat:message.format arguments:message.arguments];
 
    NSMutableString* returnValue = _format.mutableCopy;
    
    [params enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* value, BOOL *stop) {
        [returnValue replaceOccurrencesOfString:key withString:value options:NSLiteralSearch range:NSMakeRange(0, returnValue.length)];
    }];
    
    return returnValue;
}


@end
