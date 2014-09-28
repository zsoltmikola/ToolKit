/**
 * @file    NSDataBuilder.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "NSObjectBuilder.h"

@interface NSDataBuilder : NSObjectBuilder <NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

- (instancetype)buildFromURLRequest:(NSMutableURLRequest*)request withCompletionBlock:(void(^)(NSData*))block;

@end
