//
//  TKNetworkRequestBuilder.h
//  toolkit
//
//  Created by Zsolt Mikola on 30/06/15.
//  Copyright (c) 2015 Westwing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HTTPMethod)
{
    HTTPMethodHEAD = 0,
    HTTPMethodGET = 1,
    HTTPMethodDELETE = 2,
    HTTPMethodPOST = 3,
    HTTPMethodPUT = 4,
    HTTPMethodOPTIONS = 5,
    HTTPMethodTRACE = 6,
    HTTPMethodCONNECT = 7
};

typedef NS_OPTIONS(NSUInteger, TKNetwrokrequestAcceptEncoding)
{
    TKNetwrokrequestAcceptEncodingIdentity = 0,
    TKNetwrokrequestAcceptEncodingGzip     = 1 << 0,
    TKNetwrokrequestAcceptEncodingDeflate  = 1 << 1
};

@interface TKNetworkRequest : NSObject

@property (nonatomic, strong) NSData* body;
@property (nonatomic, strong) NSDictionary* parameters;
@property (nonatomic, strong) NSMutableDictionary* headers;
@property (nonatomic, copy) NSString* URL;
@property (nonatomic, copy) NSString* fragmentID;
@property (nonatomic, assign) HTTPMethod HTTPMethod;
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, assign) BOOL HTTPShouldUsePipelining;
@property (nonatomic, assign) BOOL allowsCellularAccess;
@property (nonatomic, assign) NSStringEncoding charset;
@property (nonatomic, assign) TKNetwrokrequestAcceptEncoding encoding;
@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;

- (NSMutableURLRequest*)build;

@end
