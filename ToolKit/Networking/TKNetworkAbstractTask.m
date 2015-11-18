/**
 * @file    TKNetworkAbstractTask.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKNetworkAbstractTask.h"
#import "TKNetworkResponse.h"

@implementation TKNetworkAbstractTask

-(void)executeWithData:(NSData *)data withResponse:(NSURLResponse *)response withError:(NSError *)error{
   
    TKNetworkResponse* networkResponse = [[TKNetworkResponse alloc] initWithResponse:response];
    networkResponse.body = data;
    networkResponse.error = error;
    
    TKNetworkAbstractTask* __weak wSelf = self;
    
    if (error) {
        [wSelf abortWithError:error];
        return;
    }
    
    if (wSelf.nextTask) {
        wSelf.nextTask.param = networkResponse;
        [wSelf.nextTask execute];
    }
    
}

@end
