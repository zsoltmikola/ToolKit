/**
 * @file    TKNetworkAbstractTask.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "TKTask.h"

@interface TKNetworkAbstractTask : TKTask

@property (nonatomic, strong) NSURLSession* session;
@property (nonatomic, strong) NSURLRequest* request;

- (void)executeWithData:(NSData *)data withResponse:(NSURLResponse *)response withError:(NSError *)error;

@end
