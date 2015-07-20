/**
 * @file    TKAbstractStorage.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKIndex.h"

@interface TKAbstractStorage : NSObject

@property (nonatomic, strong) NSArray* sortDescriptors;
@property (nonatomic, assign) NSUInteger sizeLimit;
@property (nonatomic, assign) short countLimit;
@property (nonatomic, assign) NSUInteger hits;
@property (nonatomic, assign) NSUInteger misses;
@property (nonatomic, assign) NSUInteger size;
@property (nonatomic, assign) NSUInteger count;

- (BOOL)insertObject:(id)object atIndex:(TKIndex*)index;
- (id) objectAtIndex:(TKIndex*)index;
- (BOOL)removeObjectAtIndex:(TKIndex*)index;

- (void)reduceSizeTo:(NSUInteger)size;
- (void)reduceCountTo:(short)count;
- (void)rebuildIndex;

@end
