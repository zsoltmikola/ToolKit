//
//  TKNetworkResponse.h
//  toolkit
//
//  Created by Zsolt Mikola on 30/06/15.
//  Copyright (c) 2015 Westwing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKNetworkResponse : NSObject

@property (nonatomic, strong) NSData* body;
@property (nonatomic, strong, readonly) id unserializedBody;
@property (nonatomic, strong) NSError* error;
@property (nonatomic, strong) NSDictionary* headers;
@property (nonatomic, strong) NSURL* URL;
@property (nonatomic, assign) NSInteger statusCode;
@property (nonatomic, assign) NSStringEncoding charset;

- (instancetype)initWithResponse:(NSURLResponse*)response;

@end
