/**
 * @file    TKNetworkSession.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKNetworkSession.h"

@interface TKNetworkSession ()

@property (nonatomic, strong) NSURLSession* session;

@end

@implementation TKNetworkSession

- (TKNetworkDataTask *)dataTaskWithRequest:(NSURLRequest *)request{
    if (!self.configuration) {
        self.configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:self.configuration];
    }
    
    TKNetworkDataTask* task = [TKNetworkDataTask new];
    task.session = self.session;
    task.request = request;
    
    return task;
}

- (TKNetworkDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request{
    if (!self.configuration) {
        self.configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:self.configuration];
    }
    
    TKNetworkDownloadTask* task = [TKNetworkDownloadTask new];
    task.session = self.session;
    task.request = request;
    
    return task;
}

- (TKNetworkUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request withData:(NSData *)data{
    if (!self.configuration) {
        self.configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:self.configuration];
    }
    
    TKNetworkUploadTask* task = [TKNetworkUploadTask new];
    task.session = self.session;
    task.request = request;
    task.data = data;
    
    return task;
}

@end
