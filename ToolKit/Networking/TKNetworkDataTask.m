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
    
    _task = [self.session dataTaskWithRequest:self.request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self executeWithData:data withResponse:response withError:error];
        
    }];
    [_task resume];
}

@end
