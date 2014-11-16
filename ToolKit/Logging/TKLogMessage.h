
@import Foundation;

@interface TKLogMessage : NSObject

@property (nonatomic, readonly, copy) NSString* domain;
@property (nonatomic, readonly, copy) NSString* format;
@property (nonatomic, readonly, assign) va_list arguments;

@property (nonatomic, readonly, assign) const char * date;
@property (nonatomic, readonly, assign) const char * time;
@property (nonatomic, readonly, assign) const char * file;
@property (nonatomic, readonly, assign) NSUInteger line;
@property (nonatomic, readonly, assign) const char* function;

- (instancetype)initWithDomain:(NSString*)domain withFile:(const char *)file withLine:(NSUInteger)line withFunction:(const char *)function withFormat:(NSString*)format, ...;

@end

