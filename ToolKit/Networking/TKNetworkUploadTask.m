/**
 * @file    TKNetworkUploadTask.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKNetworkUploadTask.h"

@interface TKNetworkUploadTask ()

@property (nonatomic, strong) NSURLSessionUploadTask* task;

@end

@implementation TKNetworkUploadTask

- (void)execute{
    
    _task = [self.session uploadTaskWithRequest:self.request fromData:self.data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self executeWithData:data withResponse:response withError:error];
        
    }];
    [_task resume];
}

@end
