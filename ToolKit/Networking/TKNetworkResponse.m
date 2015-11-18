/**
 * @file    TKNetworkResponse.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKNetworkResponse.h"
#import "TKSerializer.h"

@interface TKNetworkResponse ()

@property (nonatomic, strong) id unserializedBody;

@end

@implementation TKNetworkResponse

- (instancetype)initWithResponse:(NSURLResponse *)response{
    if (!(self = [super init])) return self;
    
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
    
    self.headers = httpResponse.allHeaderFields;
    self.statusCode = httpResponse.statusCode;
    self.URL = httpResponse.URL;
    
    if (self.headers[@"Content-Type"]) {
        
        NSArray* contentType = [[self.headers[@"Content-Type"] lowercaseString] componentsSeparatedByString:@"charset="];
        
        if (contentType.count > 1) {
            NSString* charset = contentType[1];
            self.charset = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding((CFStringRef)charset));
        }
    }

    self.serializers = @{@"text/" : [TKStringSerializer new], @"application/json" : [TKJSONSerializer new], @"application/x-plist" : [TKPropertyListSerializer new]};
    
    return self;
}

- (id)unserializedBody{
    
    if (nil != _unserializedBody) return _unserializedBody;
    
    NSString* serializerType;
    
    if (self.headers[@"Content-Type"]) {
        NSMutableString* contentType = [NSMutableString stringWithString: self.headers[@"Content-Type"]];
        [contentType replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, contentType.length)];
        NSArray* values = [contentType.lowercaseString componentsSeparatedByString:@"charset="];
        serializerType = values[0];
        if (values.count > 1) {
            _charset = CFStringConvertEncodingToNSStringEncoding(CFStringConvertIANACharSetNameToEncoding((CFStringRef)values[1]));
        }
    }
    
    if (!serializerType || !_charset) {
       return nil;
    }
    
    [self.serializers enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull type, id<TKSerializer>  _Nonnull serializer, BOOL * _Nonnull stop) {
        if ([serializerType rangeOfString:type].location != NSNotFound) {
            serializer.encoding = self.charset;
            _unserializedBody =  [serializer unserialize:_body];
            *stop = YES;
        }
    }];
    
    if (nil != _unserializedBody) return _unserializedBody;
    
    return nil;
    
}

- (void)setBody:(NSData *)body{
    _body = body;
    _unserializedBody = nil;
}

- (void)setCharset:(NSStringEncoding)charset{
    _charset = charset;
    _unserializedBody = nil;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"<%@: %p; URL: %@; statusCode: %lu; error: %@; charset: %lu; headers: %@;>",
            NSStringFromClass([self class]), self, self.URL, (unsigned long)self.statusCode, self.error, (unsigned long)self.charset, self.headers];
}

@end
