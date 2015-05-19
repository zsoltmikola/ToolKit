/**
 * @file    TKIndex.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKIndex.h"

@implementation TKIndex

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    self.creationTime = [[NSDate date] timeIntervalSince1970];
    self.expirationTime = INT_MAX;
    self.priority = 0;
    self.size = 0;
    self.hits = 0;
    self.value = 0;
    
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    return [self isEqualToIndexItem:other];
}

- (BOOL)isEqualToIndexItem:(TKIndex *)indexItem {
    return [self.key isEqualToString:indexItem.key];
}

- (NSUInteger)hash{
    return [self.key hash];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"<%@: %p; key: %@; creationTime: %d; expirationTime: %d; priority: %d; size: %d; hits: %d>",
            NSStringFromClass([self class]), self, self.key, self.creationTime, self.expirationTime, self.priority, self.size, self.hits];
}

@end
