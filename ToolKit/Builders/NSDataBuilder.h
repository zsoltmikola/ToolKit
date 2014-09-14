/**
 * @file    NSDataBuilder.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

@interface NSDataBuilder : NSObjectBuilder <NSURLSessionTaskDelegate, NSURLSessionDataDelegate>

- (void)buildFromURLRequest:(NSMutableURLRequest*)request withCompletionBlock:(void(^)(NSData*))block;

- (NSMutableURLRequest*)JSONMutableURLRequest;

@end
