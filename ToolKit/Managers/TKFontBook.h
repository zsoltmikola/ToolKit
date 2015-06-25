/**
 * @file    TKFontBook.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 * @brief A font manager
 */

#import <UIKit/UIKit.h>

@interface TKFontBook : NSObject

@property (nonatomic, assign) BOOL shouldHIGRespected;

- (UIFont*)objectAtIndexedSubscript:(NSUInteger)idx;
- (UIFont*)objectAtIndex:(NSUInteger)idx;
- (id)objectForKeyedSubscript:(NSString*)idx;
- (UIColor*)objectForKey:(NSString*)idx;

@end
