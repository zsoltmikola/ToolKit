/**
 * @file    TKColorPalette.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 * @brief A color manager
 */

#import <UIKit/UIKit.h>

@interface TKColorPalette : NSObject

- (UIColor*)objectAtIndexedSubscript:(NSUInteger)idx;
- (UIColor*)objectAtIndex:(NSUInteger)idx;
- (UIColor*)objectForKeyedSubscript:(NSString*)idx;
- (UIColor*)objectForKey:(NSString*)idx;

- (UIColor*)randomColor;

- (UIColor*)blackColor;
- (UIColor*)darkGrayColor;
- (UIColor*)lightGrayColor;
- (UIColor*)whiteColor;
- (UIColor*)grayColor;
- (UIColor*)redColor;
- (UIColor*)greenColor;
- (UIColor*)blueColor;
- (UIColor*)cyanColor;
- (UIColor*)yellowColor;
- (UIColor*)magentaColor;
- (UIColor*)orangeColor;
- (UIColor*)purpleColor;
- (UIColor*)brownColor;
- (UIColor*)clearColor;

@end
