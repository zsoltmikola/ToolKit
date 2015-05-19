/**
 * @file    TKCache.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "../NSString+Hashes.h"
#import "../TKConcurrentQueue.h"
#import "TKCache.h"
#import "TKIndex.h"
#import "TKMemoryStorage.h"
#import "TKDiskStorage.h"

////////////////////////////////////////////////////////////////////////////////

@interface TKCache ()

@property (nonatomic, assign, readwrite) unsigned int hits;
@property (nonatomic, assign, readwrite) unsigned int misses;
@property (nonatomic, strong) TKMemoryStorage* memory;
@property (nonatomic, strong) TKDiskStorage* disk;

// Queues for thread safety
@property (nonatomic, strong) TKConcurrentQueue* smartcacheQueue;

@end

@implementation TKCache

static int const kSmartCacheInitialAgeLimit = 60*60*24*7;

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    // Setup a queue for threadsafe working
    _smartcacheQueue = [[TKConcurrentQueue alloc] initWithDomain:"com.smartcache"];
    
    NSArray* sortDescriptors =  @[
                                  [NSSortDescriptor sortDescriptorWithKey:@"priority" ascending:YES],
                                  [NSSortDescriptor sortDescriptorWithKey:@"value" ascending:YES]
                                  ];
    
    _ageLimit = kSmartCacheInitialAgeLimit;
    
    _memory = [TKMemoryStorage new];
    _memory.sortDescriptors = sortDescriptors;
    [_memory rebuildIndex];
    
    _disk = [TKDiskStorage new];
    _disk.storagePath = @"TKCache";
    _disk.sortDescriptors = sortDescriptors;
    [_disk rebuildIndex];
    
    _hits = 0;
    _misses = 0;
    
    // Subscribe to UIApplicationDidReceiveMemoryWarningNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clean) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    
    return self;
}

- (void)clean{
    
    [_smartcacheQueue dispatchBarrierBlock:^{
        [_memory reduceSizeTo:0];
    }];

}


- (void)setObject:(id<NSCoding>)object forKey :(NSString*)key{
    [self setObject:object forKey:key withAgeLimit:_ageLimit withPriority:0];
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withPriority:(char)priority{
    [self setObject:object forKey:key withAgeLimit:_ageLimit withPriority:priority];
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withAgeLimit:(int)seconds{
    [self setObject:object forKey:key withAgeLimit:seconds withPriority:0];
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withAgeLimit:(int)seconds withPriority:(char)priority{
    
    TKIndex* cacheIndex = [TKIndex new];
    cacheIndex.key = key.md5;
    cacheIndex.expirationTime = [[NSDate date] timeIntervalSince1970] + seconds;
    cacheIndex.priority = priority;
    
    // Save to the memory
    [_smartcacheQueue dispatchBarrierBlock:^{
        [_memory insertObject:object atIndex:cacheIndex];
    }];
    
    // Save to disk then delete from memory
    [_smartcacheQueue dispatchBarrierBlock:^{
        if ([_disk insertObject:object atIndex:cacheIndex]) {
            [_memory removeObjectAtIndex:cacheIndex];
        }
    }];
    
}

- (id<NSCoding>)objectForKey:(NSString *)key{
    
    __block id result = nil;

    TKIndex* cacheIndex = [TKIndex new];
    cacheIndex.key = key.md5;
    
    // Get it from the memory
    [_smartcacheQueue runBlock:^{
        result = [_memory objectAtIndex:cacheIndex];
    }];
    
    if (nil == result) {
        // Get it from the disk (check if it exists!)
        [_smartcacheQueue runBlock:^{
            result = [_disk objectAtIndex:cacheIndex];
        }];
    }
    
    // Update cache statistics
    if (nil != result) {
        ++_hits;
    }else{
        ++_misses;
    }
    
    return result;
}

- (void)removeAllObjects{}

- (void)removeObjectForKey:(NSString *)key{}

- (NSInteger)size{
    return _memory.size + _disk.size;
}

- (short)count{
    return _memory.count + _disk.size;
}

- (int)sizeLimit{
    return _disk.sizeLimit;
}

- (short)countLimit{
    return _disk.countLimit;
}

- (void)setSizeLimit:(int)sizeLimit{
    _disk.sizeLimit = sizeLimit;
}

- (void)setCountLimit:(short)countLimit{
    _disk.countLimit = countLimit;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"<%@: %p; memory: %d; disk: %d; count: %d; hits: %d; misses: %d; sizeLimit: %d; countLimit: %d; ageLimit: %d>",
            NSStringFromClass([self class]), self, _memory.size, _disk.size, self.count, self.hits, self.misses, self.sizeLimit, self.countLimit, self.ageLimit];
}


@end
