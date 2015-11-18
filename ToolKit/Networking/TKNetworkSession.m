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

- (id)task:(TKNetworkAbstractTask*)task WithRequest:(NSURLRequest *)request{
    task.session = self.session;
    task.request = request;
    return task;
}

- (TKNetworkDataTask *)dataTaskWithRequest:(NSURLRequest *)request{
    return [self task:[TKNetworkDataTask new] WithRequest:request];
}

- (TKNetworkDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request{
    return [self task:[TKNetworkDownloadTask new] WithRequest:request];
}

- (TKNetworkUploadTask *)uploadTaskWithRequest:(NSURLRequest *)request withData:(NSData *)data{

    TKNetworkUploadTask* task = [TKNetworkUploadTask new];
    task.data = data;
    
    return [self task:task WithRequest:request];

}

-(NSURLSession *)session{
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:self.configuration];
    }
    
    return _session;
}

- (NSURLSessionConfiguration *)configuration{
    if(!_configuration){
        _configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    
    return _configuration;
}

@end
