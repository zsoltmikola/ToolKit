/**
 * @file    TKIndex.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface TKIndex : NSObject

@property (nonatomic, copy) NSString* key;
@property (nonatomic, assign) int creationTime;
@property (nonatomic, assign) int expirationTime;
@property (nonatomic, assign) char priority;
@property (nonatomic, assign) NSUInteger size;
@property (nonatomic, assign) NSUInteger hits;
@property (nonatomic, assign) NSUInteger value; // = (lifetime / hits) / relative size for the available space for the cache

@end
