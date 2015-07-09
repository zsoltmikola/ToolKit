/**
 * @file    TKNetworkSession.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import <Foundation/Foundation.h>

#import "TKNetworkDataTask.h"
#import "TKNetworkDownloadTask.h"
#import "TKNetworkUploadTask.h"
#import "TKNetworkRequest.h"
#import "TKNetworkResponse.h"

@interface TKNetworkSession : NSObject

@property (nonatomic, strong) NSURLSessionConfiguration* configuration;

- (TKNetworkDataTask*)dataTaskWithRequest:(NSURLRequest*)request;
- (TKNetworkDownloadTask*)downloadTaskWithRequest:(NSURLRequest*)request;
- (TKNetworkUploadTask*)uploadTaskWithRequest:(NSURLRequest*)request withData:(NSData*)data;

@end
