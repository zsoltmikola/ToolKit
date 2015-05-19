/**
 * @file    TKDiskStorage.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKAbstractStorage.h"

@interface TKDiskStorage : TKAbstractStorage

@property (nonatomic, copy) NSString* storagePath;

@end
