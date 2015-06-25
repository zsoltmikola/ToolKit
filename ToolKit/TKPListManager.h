/**
 * @file    TKPListManager.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 * @brief Unified read/write of user defaults + bundle plists
 */

#import <Foundation/Foundation.h>

@interface TKPListManager : NSObject

- (void)setObject:(id)object forKeyedSubscript:(NSString*)key;
- (id)objectForKeyedSubscript:(NSString*)key;

@end
