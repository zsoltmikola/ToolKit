/**
 * @file    TKNetworkUploadTask.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKNetworkAbstractTask.h"

@interface TKNetworkUploadTask : TKNetworkAbstractTask

@property (nonatomic, strong) NSData* data;

@end
