/**
 * @file    UIColor+ToolKit.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "UIColor+ToolKit.h"

@implementation UIColor (ToolKit)

/** Color from RGB hexa integer (0xFFFFFFFF) with variable opacity */

+ (UIColor *) colorWithRGBA: (NSUInteger)rgbaColorValue{
    
	unsigned int red, green, blue, alpha;
	
	alpha = (rgbaColorValue & 0xFF);
	blue = (rgbaColorValue & 0xFFFF) >> 8;
	green = (rgbaColorValue & 0xFFFFFF) >> 16;
	red = (rgbaColorValue & 0xFFFFFFFF) >> 24;
    
	return [UIColor colorWithRed:((float) red / 255.0f)
						   green:((float) green / 255.0f)
							blue:((float) blue / 255.0f)
						   alpha:alpha/255.0f];
    
}

/** Color from RGB hexa integer (0xFFFFFF) with full opacity */

+ (UIColor *) colorWithRGB: (NSUInteger)rgbColorValue
{
    // color is shifted and added full opacity
    return [UIColor colorWithRGBA:((rgbColorValue << 8) + 0x000000FF)];
}

/** Random color for debug */
+(UIColor*) randomColor
{
    // - Specifically, to generate a random number between 0 and N - 1, use arc4random_uniform(), which avoids modulo bias.
    // modulo bias: http://eternallyconfuzzled.com/arts/jsw_art_rand.aspx
    // - arc4random does not require an initial seed
    // - random color then shifted and added 50% transparency for overlap recognition
    return [UIColor colorWithRGBA:((arc4random_uniform(0xFFFFFF) << 8) + 0x00000088)] ;
    
}

@end