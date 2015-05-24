
#import "TKLogMessage.h"

@implementation TKLogMessage

- (instancetype)initWithDomain:(NSString*)domain withFile:(const char *)file withLine:(NSUInteger)line withFunction:(const char *)function withFormat:(NSString*)format, ...
{
    
    if (!(self = [super init])) return self;
    
    va_list args;
    va_start(args, format);
    _text = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    _domain = domain;
    _time = __TIME__;
    _date = __DATE__;
    _file = file;
    _line = line;
    _function = function;
    
    _format = @"[<basefile>(<line>)]<function>:<message>";
    
    return self;
}

- (NSString *)description{
    NSMutableDictionary* params = @{}.mutableCopy;
    params[@"<date>"] = [NSString stringWithUTF8String:self.date];
    params[@"<time>"] = [NSString stringWithUTF8String:self.time];
    params[@"<domain>"] = self.domain;
    params[@"<basefile>"] = [[NSString stringWithUTF8String:self.file] componentsSeparatedByString:@"/"].lastObject;
    params[@"<file>"] = [NSString stringWithUTF8String:self.file];
    params[@"<line>"] = [NSString stringWithFormat:@"%d", self.line];
    params[@"<function>"] = [[NSString stringWithUTF8String:self.function] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    params[@"<message>"] = self.text;
    
    NSMutableString* returnValue = _format.mutableCopy;
    
    [params enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSString* value, BOOL *stop) {
        [returnValue replaceOccurrencesOfString:key withString:value options:NSLiteralSearch range:NSMakeRange(0, returnValue.length)];
    }];
    
    return returnValue;
}

@end
