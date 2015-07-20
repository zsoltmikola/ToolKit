/**
 * @file    TKNetworkDownloadTask.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKNetworkDownloadTask.h"

@interface TKNetworkDownloadTask ()

@property (nonatomic, strong) NSURLSessionDownloadTask* task;

@end

@implementation TKNetworkDownloadTask

- (void)execute{
    
    TKNetworkDownloadTask* __weak weakSelf = self;
    _task = [self.session downloadTaskWithRequest:self.request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        [self executeBodyWithSelf:weakSelf withData:nil withResponse:response withError:error];
        
    }];
    [_task resume];
}

@end
