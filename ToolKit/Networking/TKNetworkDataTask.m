/**
 * @file    TKNetworkDataTask.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKNetworkDataTask.h"

@interface TKNetworkDataTask ()

@property (nonatomic, strong) NSURLSessionDataTask* task;

@end

@implementation TKNetworkDataTask

- (void)execute{
    
    TKNetworkDataTask* __weak weakSelf = self;
    _task = [self.session dataTaskWithRequest:self.request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self executeBodyWithSelf:weakSelf withData:data withResponse:response withError:error];
        
    }];
    [_task resume];
}

@end
