/**
 * @file    TKMemoryStorage.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKMemoryStorage.h"

@interface TKMemoryStorage ()

@property (nonatomic, strong) NSMutableDictionary* data;

@end

@implementation TKMemoryStorage

static int const kSmartCacheMemorySizeLimit = INT_MAX/256;
static short const kSmartCacheMemoryCountLimit = SHRT_MAX;

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _data = [NSMutableDictionary dictionary];
    self.sizeLimit = kSmartCacheMemorySizeLimit;
    self.countLimit = kSmartCacheMemoryCountLimit;
    
    return self;
}

- (void) SetSizeLimit:(int)newSizeLimit{
    
    // Check if the value is valid (0 - kSmartCacheMemorySizeLimit)!
    if (newSizeLimit < 0) {
        newSizeLimit = 0;
    }
    
    if (newSizeLimit > kSmartCacheMemorySizeLimit) {
        newSizeLimit = kSmartCacheMemorySizeLimit;
    }
    
    [super setSizeLimit:newSizeLimit];
    [self reduceSizeTo:newSizeLimit];   // This won't do anything if the new size limit is bigger the the current size
}

- (void) setCountLimit:(short)newCountLimit{
    
    // Check if the value is valid (0 - kSmartCacheMemoryCountLimit)!
    if (newCountLimit < 0) {
        newCountLimit = 0;
    }
    
    if (newCountLimit > kSmartCacheMemoryCountLimit) {
        newCountLimit = kSmartCacheMemoryCountLimit;
    }
    
    // Set max number of entries then purge!
    [super setCountLimit:newCountLimit];
    [self reduceCountTo:newCountLimit]; // This won't do anything if the new count limit is bigger the the current count
}

- (BOOL)insertObject:(id)object atIndex:(TKIndex *)index{
    
    // Check if entry size is smaller than the sizeLimit! (return if not & log it)
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:object];
    
    if (data.length > self.sizeLimit) {
        NSLog(@"%@", @"Tried to cache an item which is bigger than the cache size limit!");
        return NO;
    }
    
    // Check if the countLimit or the sizeLimit is reached or not. If needed, reduce size or count.
    [self reduceSizeTo:(self.sizeLimit - data.length)];
    [self reduceCountTo:(self.countLimit-1)];
    
    // Save data entry
    [_data setObject:data forKey:index.key];
    
    // Create index entry
    index.size = data.length;
    [super insertObject:object atIndex:index];
    
    return YES;
}

- (id)objectAtIndex:(TKIndex *)index{
    
    id anObject = nil;
    
    NSData* data = [_data objectForKey:index.key];
    
    if (data) {
        anObject = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    if (nil != anObject) {
        ++self.hits;
        [super objectAtIndex:index];
    }else{
        ++self.misses;
    }
    
    return anObject;
}

- (BOOL)removeObjectAtIndex:(TKIndex *)index{
    [super removeObjectAtIndex:index];
    [_data removeObjectForKey:index.key];
    return YES;
}

- (void)rebuildIndex{
        
    [super rebuildIndex];
    
    for (NSString* key in [_data keyEnumerator]) {
        @autoreleasepool {
            TKIndex* index = [TKIndex new];
            index.key = key;
            NSData* data = [_data objectForKey:key];
            index.size = data.length;
            [super insertObject:nil atIndex:index];
        }
    }

}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@: %p; size: %lu; count: %lu; hits: %lu; misses: %lu; sizeLimit: %lu; countLimit: %d;>",
            NSStringFromClass([self class]), self, (unsigned long)self.size, (unsigned long)self.count, (unsigned long)self.hits, (unsigned long)self.misses, (unsigned long)self.sizeLimit, self.countLimit];
}

@end
