//
//  TKNetworkTask.h
//  toolkit
//
//  Created by Zsolt Mikola on 30/06/15.
//  Copyright (c) 2015 Westwing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TKTask.h"

@interface TKNetworkAbstractTask : TKTask

@property (nonatomic, strong) NSURLSession* session;
@property (nonatomic, strong) NSURLRequest* request;

- (void)executeBodyWithSelf:(TKNetworkAbstractTask*)weakSelf withData:(NSData *)data withResponse:(NSURLResponse *)response withError:(NSError *)error;

@end
