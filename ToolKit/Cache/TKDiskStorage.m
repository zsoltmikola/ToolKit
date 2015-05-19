/**
 * @file    TKDiskStorage.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKDiskStorage.h"

@implementation TKDiskStorage

static const int kSmartCacheDiskSizeLimit = INT_MAX/16;
static const short kSmartCacheDiskCountLimit = SHRT_MAX;

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    self.sizeLimit = kSmartCacheDiskSizeLimit;
    self.countLimit = kSmartCacheDiskCountLimit;
    
    return self;
}

- (void)setStoragePath:(NSString *)storagePath{
    _storagePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:_storagePath];    
}

- (void) SetSizeLimit:(int)newSizeLimit{
    
    // Check if the value is valid (0 - INT_MAX/16)!
    if (newSizeLimit < 0) {
        newSizeLimit = 0;
    }
    
    if (newSizeLimit > kSmartCacheDiskSizeLimit) {
        newSizeLimit = kSmartCacheDiskSizeLimit;
    }
    
    [super setSizeLimit:newSizeLimit];
    [self reduceSizeTo:newSizeLimit]; // This won't do anything if the new size limit is bigger the the current size
}

- (void) setCountLimit:(short)newCountLimit{
    
    // Check if the value is valid (0 - SHRT_MAX)!
    if (newCountLimit < 0) {
        newCountLimit = 0;
    }
    
    if (newCountLimit > kSmartCacheDiskCountLimit) {
        newCountLimit = kSmartCacheDiskCountLimit;
    }
    
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
    
    // Save data entry & create index entry on success
    if ([data writeToFile:[self filepathWithIndex:index] atomically:YES]) {
        index.size = data.length;
        [super insertObject:object atIndex:index];
        return YES;
    }else{
        return NO;
    }
}

- (id)objectAtIndex:(TKIndex *)index{
    
    TKIndex* originalIndex = [super objectAtIndex:index];
    
    id anObject = nil;
    
    // Load file
    NSString* filename = [self filepathWithIndex:originalIndex];
    NSData* data = [NSData dataWithContentsOfFile:filename];
    if (data) {
        anObject = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    if (nil != anObject) {
        ++self.hits;
    }else{
        ++self.misses;
    }
    
    return anObject;
}

- (BOOL)removeObjectAtIndex:(TKIndex *)index{
    
    NSError* error;
    
    if ([[NSFileManager defaultManager] removeItemAtPath:[self filepathWithIndex:index] error:&error]) {
        [super removeObjectAtIndex:index];
        return YES;
    }else{
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
}

- (void)rebuildIndex{
    
    [super rebuildIndex];
    
    NSEnumerator* folderIterator = [[NSFileManager defaultManager] enumeratorAtPath:_storagePath];
    
    for (NSString* filename in folderIterator) {
        @autoreleasepool {
            //NSLog(@"filename: %@",filename);
            [super insertObject:nil atIndex:[self indexWithFilepath:filename]];
        }
    }
    
}

// Private methods
// -----------------------------------------------------------------------------

- (NSString*)filepathWithIndex:(TKIndex*)index{

    NSString* filename = [NSString stringWithFormat:@"%@-%d-%d-%d-%d", index.key, index.creationTime, index.expirationTime, index.priority, index.size];
    return [_storagePath stringByAppendingPathComponent:filename];
}

- (TKIndex*)indexWithFilepath:(NSString*)filepath{
    TKIndex* index = [TKIndex new];
    
    NSArray* properties = [filepath componentsSeparatedByString:@"-"];
    index.key = properties[0];
    index.creationTime = [properties[1] intValue];
    index.expirationTime = [properties[2] intValue];
    index.priority = [properties[3] intValue];
    index.size = [properties[4] intValue];
    index.hits = 0;
    
    return index;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@: %p; size: %d; count: %d; hits: %d; misses: %d; sizeLimit: %d; countLimit: %d;>",
            NSStringFromClass([self class]), self, self.size, self.count, self.hits, self.misses, self.sizeLimit, self.countLimit];
}

@end