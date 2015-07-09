/**
 * @file    TKNetworkAbstractTask.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKNetworkAbstractTask.h"
#import "TKNetworkResponse.h"

@implementation TKNetworkAbstractTask

-(void)executeBodyWithSelf:(TKNetworkAbstractTask*)weakSelf withData:(NSData *)data withResponse:(NSURLResponse *)response withError:(NSError *)error{
   
    TKNetworkResponse* networkResponse = [[TKNetworkResponse alloc] initWithResponse:response];
    networkResponse.body = data;
    networkResponse.error = error;
       
    if (error) {
        [weakSelf abortWithError:error];
        return;
    }
    
    if (weakSelf.nextTask) {
        weakSelf.nextTask.param = networkResponse;
        [weakSelf.nextTask execute];
    }
    
}

@end
