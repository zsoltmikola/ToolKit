/**
 * @file    TKCache.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

////////////////////////////////////////////////////////////////////////////////

@interface TKCache : NSObject

@property (nonatomic, assign) int sizeLimit;
@property (nonatomic, assign) short countLimit;
@property (nonatomic, assign) int ageLimit;
@property (nonatomic, assign, readonly) unsigned int hits;
@property (nonatomic, assign, readonly) unsigned int misses;

/**
 * -----------------------------------------------------------------------------
 * @brief The number of entries in the dictionary.
 * @return NSUInteger, the number of entries in the dictionary.
 */
@property (nonatomic, assign, readonly) short count;

/**
 * -----------------------------------------------------------------------------
 * @brief The current size of the cache
 * @return NSUInteger, the size of the cache in bytes
 */

@property (nonatomic, assign, readonly) NSInteger size;


/**
 * -----------------------------------------------------------------------------
 * @brief Adds a given key-value pair to the cache
 *
 * @param The object for aKey.
 * @param The key for value. The key is copied (using copyWithZone:; keys must conform to the NSCopying protocol). Raises an NSInvalidArgumentException if aKey is nil. If aKey already exists in the dictionary anObject takes its place.
 */

- (void)setObject:(id<NSCoding>)object forKey:(NSString*)key;

/**
 * -----------------------------------------------------------------------------
 * @brief Adds a given key-value pair to the cache with a specific lifetime
 *
 * @param The object for aKey.
 * @param The key for value. The key is copied (using copyWithZone:; keys must conform to the NSCopying protocol). Raises an NSInvalidArgumentException if aKey is nil. If aKey already exists in the dictionary anObject takes its place.
 */

- (void)setObject:(id<NSCoding>)object forKey:(NSString*)key withPriority:(char)priority;

- (void)setObject:(id<NSCoding>)object forKey:(NSString*)key withAgeLimit:(int)seconds;

- (void)setObject:(id<NSCoding>)object forKey:(NSString*)key withAgeLimit:(int)seconds withPriority:(char)priority;

/**
 * -----------------------------------------------------------------------------
 * @brief Removes a given key and its associated value from the cache.
 */

- (void)removeObjectForKey:(NSString*)key;

/**
 * -----------------------------------------------------------------------------
 * @brief Empties the cache of its entries.
 */

- (void)removeAllObjects;

/**
 * -----------------------------------------------------------------------------
 * @brief Returns the object associated with a given key.
 * @details The object associated with aKey, or nil if no value is associated with aKey.
 * @return id, the object
 */

- (id<NSCoding>)objectForKey:(NSString*)key;

/**
 * -----------------------------------------------------------------------------
 * @brief Returns a string that represents the statistics of the cache, formatted as a property list.
 * @return NSString, the description
 */

- (NSString*)description;


@end
