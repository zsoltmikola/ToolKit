/**
 * @file    TKColorPalette.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 * @brief Unified read/write of user defaults + bundle plists
 */

#import <UIKit/UIKit.h>

@interface TKColorPalette : NSObject

- (UIColor*)objectAtIndexedSubscript:(NSUInteger)idx;
- (UIColor*)objectAtIndex:(NSUInteger)idx;
- (UIColor*)objectForKeyedSubscript:(NSString*)idx;
- (UIColor*)objectForKey:(NSString*)idx;

@end
