/**
 * @file    TKIndex.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

@interface TKIndex : NSObject

@property (nonatomic, copy) NSString* key;
@property (nonatomic, assign) int creationTime;
@property (nonatomic, assign) int expirationTime;
@property (nonatomic, assign) char priority;
@property (nonatomic, assign) int size;
@property (nonatomic, assign) unsigned int hits;
@property (nonatomic, assign) unsigned int value; // = (lifetime / hits) / relative size for the available space for the cache

@end
