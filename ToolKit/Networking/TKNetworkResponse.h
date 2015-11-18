/**
 * @file    TKNetworkResponse.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface TKNetworkResponse : NSObject

@property (nonatomic, strong) NSData* body;
@property (nonatomic, strong, readonly) id unserializedBody;
@property (nonatomic, strong) NSDictionary* serializers;
@property (nonatomic, strong) NSError* error;
@property (nonatomic, strong) NSDictionary* headers;
@property (nonatomic, strong) NSURL* URL;
@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, assign) NSStringEncoding charset;

- (instancetype)initWithResponse:(NSURLResponse*)response;

@end
