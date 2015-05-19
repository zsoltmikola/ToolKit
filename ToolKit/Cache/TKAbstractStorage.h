/**
 * @file    TKAbstractStorage.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKIndex.h"

@interface TKAbstractStorage : NSObject

@property (nonatomic, strong) NSArray* sortDescriptors;
@property (nonatomic, assign) int sizeLimit;
@property (nonatomic, assign) short countLimit;
@property (nonatomic, assign) int hits;
@property (nonatomic, assign) int misses;
@property (nonatomic, assign) int size;
@property (nonatomic, assign) int count;

- (BOOL)insertObject:(id)object atIndex:(TKIndex*)index;
- (id) objectAtIndex:(TKIndex*)index;
- (BOOL)removeObjectAtIndex:(TKIndex*)index;

- (void)reduceSizeTo:(int)size;
- (void)reduceCountTo:(short)count;
- (void)rebuildIndex;

@end
