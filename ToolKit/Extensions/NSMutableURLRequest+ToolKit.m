//
//  NSMutableURLRequest.m
//  network
//
//  Created by Zsolt Mikola on 26/09/14.
//  Copyright (c) 2014 Zsolt Mikola. All rights reserved.
//

#import "NSMutableURLRequest+ToolKit.h"

@implementation NSMutableURLRequest (ToolKit)

+ (instancetype)requestJSON{
    
    NSMutableURLRequest* request = [[self class] new];
    request.HTTPShouldUsePipelining = YES;
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    return request;
}


@end
