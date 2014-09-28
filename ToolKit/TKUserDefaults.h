/**
 * @file    TKUserDefaults.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 * @brief Unified read/write of user defaults + bundle plists
 */

@interface TKUserDefaults : NSObject

+ (id)valueForKeyPath:(NSString *)keyPath;
+ (void)setValue:(id)value forKeyPath:(NSString *)keyPath;

@end
