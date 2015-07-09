//
//  TKNetworkDownloadTask.m
//  toolkit
//
//  Created by Zsolt Mikola on 30/06/15.
//  Copyright (c) 2015 Westwing. All rights reserved.
//

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
