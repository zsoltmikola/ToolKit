/**
 * @file    TKAbstractStorage.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKAbstractStorage.h"

@interface TKAbstractStorage ()

@property (nonatomic, strong) NSMutableDictionary* index;

@end

@implementation TKAbstractStorage

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _index = [NSMutableDictionary dictionary];
    
    self.hits = 0;
    self.misses = 0;
    self.size = 0;
    
    return self;
}

- (void)reduceSizeTo:(int)size{
    
    if (self.size < size) {
        return;
    }
    
    NSMutableArray* sortedIndex = [self sortedIndex];
    
    // Delete the entries while current size is bigger than the new size
    // -------------------------------------------------------------------------
    TKIndex* entry;
    while (self.size > size) {
        entry = sortedIndex[0];
        [self removeObjectAtIndex:entry];
        [sortedIndex removeObjectAtIndex:0];
    }
}

- (void)reduceCountTo:(short)count{
    if (self.count < count) {
        return;
    }
    
    NSMutableArray* sortedIndex = [self sortedIndex];
    
    // Delete the entries while count is bigger than the new count
    // -------------------------------------------------------------------------
    TKIndex* entry;
    while (self.count > count) {
        entry = sortedIndex[0];
        [self removeObjectAtIndex:entry];
        [sortedIndex removeObjectAtIndex:0];
    }
}

- (NSMutableArray*)sortedIndex{
    // Calculate the value for each element
    
    unsigned int now = [[NSDate date] timeIntervalSince1970];
    
    NSMutableArray* values = [NSMutableArray arrayWithArray:[_index allValues]];
    
    // Calculate the value of each entry
    // -------------------------------------------------------------------------
    for (TKIndex* entry in values) {
        
        if (entry.expirationTime > now) {
            entry.value = 0;
            entry.priority = 0;
        }else{
            //entry.value = ((now - entry.creationTime) / entry.hits) / (entry.size / self.maxSize);
            entry.value = (now - entry.creationTime)*_sizeLimit / entry.hits*entry.size; // only 1 division instead of 3
        }
    }
    
    // Sort the entries
    // -------------------------------------------------------------------------
    [values sortUsingDescriptors:_sortDescriptors];
    
    return values;
}

#pragma - Abstract methods

- (int)count{return 0;}

- (BOOL)insertObject:(id)object atIndex:(TKIndex *)index{
    [_index setObject:index forKey:index.key];
    _size += index.size;
    ++_count;
    return YES;
}

- (TKIndex*)objectAtIndex:(TKIndex *)index{
    
    // It's a linear search but the more frequently accessed objects are in the beginning
    index = [_index objectForKey:index.key];
    if (index) {
        ++index.hits;
    }
    
    return index;
}

- (BOOL)removeObjectAtIndex:(TKIndex *)index{
    
    // This method uses indexOfObject: to locate matches and then removes them by using removeObjectAtIndex:. Thus, matches are determined on the basis of an object’s response to the isEqual: message.
    
    [_index removeObjectForKey:index.key];
    _size -= index.size;
    --_count;
    return YES;
}

- (void)rebuildIndex{
    _index = [NSMutableDictionary dictionary];
}

@end
