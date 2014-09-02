/**
 * @file    UIColor+ToolKit.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

@import UIKit;

@interface UIColor (ToolKit)

+ (UIColor *) colorWithRGBA: (NSUInteger)rgbaColorValue;
+ (UIColor *) colorWithRGB: (NSUInteger)rgbColorValue;
+ (UIColor*) randomColor;

@end
