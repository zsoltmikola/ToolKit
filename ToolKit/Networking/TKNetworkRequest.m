/**
 * @file    TKNetworkRequest.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKNetworkRequest.h"

@interface TKNetworkRequest ()

@property (nonatomic, strong) NSArray* HTTPMethods;

@end

@implementation TKNetworkRequest

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _HTTPMethods = @[@"HEAD", @"GET", @"DELETE", @"POST", @"PUT", @"OPTIONS", @"TRACE", @"CONNECT"];
    _headers = @{}.mutableCopy;
    
    _HTTPMethod = HTTPMethodGET;
    _charset = NSUTF8StringEncoding;
    _HTTPShouldUsePipelining = YES;
    _allowsCellularAccess = YES;
    _encoding = TKNetwrokrequestAcceptEncodingIdentity;
    _cachePolicy = NSURLRequestUseProtocolCachePolicy;
    
    return self;
}

-(NSMutableURLRequest *)build{
    
    NSMutableURLRequest* request = [NSMutableURLRequest new];
    
    request.HTTPMethod = _HTTPMethods[_HTTPMethod];
    if (_HTTPMethod < 3) {
        _body = nil;
    }
    
    if (_timeoutInterval) {
        request.timeoutInterval = _timeoutInterval;
    }
    
    request.HTTPShouldUsePipelining = _HTTPShouldUsePipelining;
    
    request.allowsCellularAccess = _allowsCellularAccess;
    
    NSMutableString* finalURL = _URL.mutableCopy;
    
    if (_parameters) {
        [finalURL appendFormat:@"?%@", queryStringWithDictionary(_parameters)];
    }
    
    if (_fragmentID) {
        [finalURL appendFormat:@"#%@", _fragmentID];
    }
    
    request.URL = [NSURL URLWithString:finalURL];
    request.cachePolicy = self.cachePolicy;
    
    /// Setting up headers
    
    self.headers[@"Accept-Charset"] = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(_charset));
    
    self.headers[@"Content-Type"] = self.headers[@"Accept"];
    
    if (2 < _HTTPMethod) {
        self.headers[@"Content-Type"] = [NSString stringWithFormat:@"application/x-www-form-urlencoded"];
    }
    
    if (self.headers[@"Content-Type"] && [self.headers[@"Content-Type"] rangeOfString:@"charset="].location == NSNotFound) {
        self.headers[@"Content-Type"] = [NSString stringWithFormat:@"%@; charset=%@", self.headers[@"Content-Type"], self.headers[@"Accept-Charset"]];
    }
    
    if (!self.headers[@"Content-Type"]) {
        self.headers[@"Content-Type"] = [NSString stringWithFormat:@"text/plain; charset=%@", self.headers[@"Accept-Charset"]];
    }
    
    
    if (TKNetwrokrequestAcceptEncodingIdentity == _encoding) {
        [self.headers removeObjectForKey:@"Accept-Encoding"];
    }
    
    if (TKNetwrokrequestAcceptEncodingGzip == _encoding) {
        self.headers[@"Accept-Encoding"] = @"gzip";
    }
    
    if (TKNetwrokrequestAcceptEncodingDeflate == _encoding) {
        self.headers[@"Accept-Encoding"] = @"deflate";
    }
    
    if ((TKNetwrokrequestAcceptEncodingGzip & TKNetwrokrequestAcceptEncodingDeflate) == _encoding) {
        self.headers[@"Accept-Encoding"] = @"gzip, deflate";
    }
    
    [self.headers enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        [request setValue:value forHTTPHeaderField:field];
    }];
    
    if (_body) {
        [request setHTTPBody:_body];
    }
    
    return request;
}

- (NSString *)description{
    
    NSMutableURLRequest* request = [self build];
    
    return [NSString stringWithFormat:@"<%@: %p; method: %@; URL: %@; timeoutInterval: %f; HTTPShouldUsePipelining: %@; allowsCellularAccess: %@; charset: %d; encoding: %d; headers: %@>",
            NSStringFromClass([self class]), self, _HTTPMethods[_HTTPMethod], request.URL, request.timeoutInterval ? request.timeoutInterval : 60, request.HTTPShouldUsePipelining ? @"YES" : @"NO", request.allowsCellularAccess ? @"YES" : @"NO", self.charset, self.encoding, request.allHTTPHeaderFields];
    
}

static inline NSString* queryStringWithDictionary(NSDictionary* parameters){
    NSMutableArray* body = [NSMutableArray new];
    NSEnumerator* keys = [parameters keyEnumerator];
    NSString* key;
    while ((key = [keys nextObject])) {
        [body addObject:[NSString stringWithFormat:@"%@=%@", key, parameters[key]]];
    }
    
    return [body componentsJoinedByString:@"&"];
}

@end
