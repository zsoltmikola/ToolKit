
#import "TKLogMessage.h"

@implementation TKLogMessage

- (instancetype)initWithDomain:(NSString*)domain withFile:(const char *)file withLine:(NSUInteger)line withFunction:(const char *)function withFormat:(NSString*)format, ...
{
    
    if (!(self = [super init])) return self;
    
    _format = format;
    va_list args;
    va_start(args, format);
    _arguments = args;
    va_end(args);
    
    _domain = domain;
    _time = __TIME__;
    _date = __DATE__;
    _file = file;
    _line = line;
    _function = function;
    
    return self;
}

@end
