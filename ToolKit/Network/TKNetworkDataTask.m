//
//  TKNetworkSessionDataTask.m
//  toolkit
//
//  Created by Zsolt Mikola on 28/06/15.
//  Copyright (c) 2015 Westwing. All rights reserved.
//

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
