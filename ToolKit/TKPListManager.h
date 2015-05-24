/**
 * @file    TKPListManager.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 * @brief Unified read/write of user defaults + bundle plists
 */

#import <Foundation/Foundation.h>

@interface TKPListManager : NSObject

- (id)valueForKeyPath:(NSString *)keyPath;
- (void)setValue:(id)value forKeyPath:(NSString *)keyPath;

@end
