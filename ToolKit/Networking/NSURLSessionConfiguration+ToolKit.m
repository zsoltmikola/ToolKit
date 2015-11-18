//
//  NSURLSessionConfiguration+ToolKit.m
//  toolkit
//
//  Created by Zsolt Mikola on 18/11/15.
//  Copyright © 2015 Westwing. All rights reserved.
//

#import "NSURLSessionConfiguration+ToolKit.h"

@implementation NSURLSessionConfiguration (ToolKit)

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@: %p; allowsCellularAccess: %@; timeoutIntervalForRequest: %f; HTTPCookieAcceptPolicy: %lu; TLSMinimumSupportedProtocol: %d; TLSMaximumSupportedProtocol: %d; HTTPMaximumConnectionsPerHost: %ld; HTTPShouldUsePipelining: %@;>",
            NSStringFromClass([self class]), self, self.allowsCellularAccess ? @"YES" : @"NO", self.timeoutIntervalForRequest, self.HTTPCookieAcceptPolicy, self.TLSMinimumSupportedProtocol, self.TLSMaximumSupportedProtocol, (long)self.HTTPMaximumConnectionsPerHost, self.HTTPShouldUsePipelining ? @"YES" : @"NO"];
}

@end
