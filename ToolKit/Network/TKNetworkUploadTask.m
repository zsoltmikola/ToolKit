//
//  TKNetworkUploadTask.m
//  toolkit
//
//  Created by Zsolt Mikola on 30/06/15.
//  Copyright (c) 2015 Westwing. All rights reserved.
//

#import "TKNetworkUploadTask.h"

@interface TKNetworkUploadTask ()

@property (nonatomic, strong) NSURLSessionUploadTask* task;

@end

@implementation TKNetworkUploadTask

- (void)execute{
    
    TKNetworkUploadTask* __weak weakSelf = self;
    _task = [self.session uploadTaskWithRequest:self.request fromData:self.data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self executeBodyWithSelf:weakSelf withData:data withResponse:response withError:error];
        
    }];
    [_task resume];
}

@end
