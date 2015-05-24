
@import Foundation;

@interface TKLogMessage : NSObject

@property (nonatomic, readonly, copy) NSString* domain;
@property (nonatomic, readonly, copy) NSString* text;

@property (nonatomic, readonly, assign) const char * date;
@property (nonatomic, readonly, assign) const char * time;
@property (nonatomic, readonly, assign) const char * file;
@property (nonatomic, readonly, assign) NSUInteger line;
@property (nonatomic, readonly, assign) const char* function;

@property (nonatomic, copy) NSString* format;

- (instancetype)initWithDomain:(NSString*)domain withFile:(const char *)file withLine:(NSUInteger)line withFunction:(const char *)function withFormat:(NSString*)format, ...;

@end

