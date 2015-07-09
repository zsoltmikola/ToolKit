//
//  TKNetworkUploadTask.h
//  toolkit
//
//  Created by Zsolt Mikola on 30/06/15.
//  Copyright (c) 2015 Westwing. All rights reserved.
//

#import "TKNetworkAbstractTask.h"

@interface TKNetworkUploadTask : TKNetworkAbstractTask

@property (nonatomic, strong) NSData* data;

@end
