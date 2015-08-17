/**
 * @file    TKColorPalette.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKColorPalette.h"

@interface TKColorPalette ()

@property (nonatomic, strong) NSMutableDictionary* colors;

@end

@implementation TKColorPalette

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _colors = @{}.mutableCopy;
    
    return self;
}

- (UIColor*)objectAtIndexedSubscript:(NSUInteger)idx{
    
    unsigned int red, green, blue, alpha;
    
    UIColor* color = _colors[@(idx).stringValue];
    
    if (!color) {
        
        alpha = (idx & 0xFF);
        blue  = (idx & 0xFFFF) >> 8;
        green = (idx & 0xFFFFFF) >> 16;
        red   = (idx & 0xFFFFFFFF) >> 24;
        
        color = [UIColor colorWithRed:((float) red / 255.0f)
                               green:((float) green / 255.0f)
                                blue:((float) blue / 255.0f)
                               alpha:alpha/255.0f];
        
        if (color) {
            _colors[@(idx).stringValue] = color;
        }        
    }
    
    return color;
}

- (UIColor *)objectAtIndex:(NSUInteger)idx{
    return self[idx];
}

- (UIColor*)objectForKeyedSubscript:(NSString*)idx{

    unsigned int color;
    NSScanner *scanner = [[NSScanner alloc] initWithString:[idx stringByReplacingOccurrencesOfString:@"#" withString:@"0x"]];
    [scanner scanHexInt:&color];
    scanner = nil;
    
    return self[color];
}

- (UIColor *)objectForKey:(NSString *)idx{
    return self[idx];
}

-(UIColor*) randomColor{
    // - Specifically, to generate a random number between 0 and N - 1, use arc4random_uniform(), which avoids modulo bias.
    // modulo bias: http://eternallyconfuzzled.com/arts/jsw_art_rand.aspx
    // - arc4random does not require an initial seed
    // - random color then shifted and added 50% transparency for overlap recognition
    return self[((arc4random_uniform(0xFFFFFF) << 8) + 0x00000088)];    
}

- (UIColor*)blackColor{
    return self[0x000000ff];
}

- (UIColor*)darkGrayColor{
    return self[0x555555ff];
}

- (UIColor*)lightGrayColor{
    return self[0xaaaaaaff];
}

- (UIColor*)whiteColor{
    return self[0xffffffff];
}

- (UIColor*)grayColor{
    return self[0x7f7f7fff];
}

- (UIColor*)redColor{
    return self[0xff0000ff];
}

- (UIColor*)greenColor{
    return self[0x00ff00ff];
}

- (UIColor*)blueColor{
    return self[0x0000ffff];
}

- (UIColor*)cyanColor{
    return self[0x00ffffff];
}

- (UIColor*)yellowColor{
    return self[0xffff00ff];
}

- (UIColor*)magentaColor{
    return self[0xff00ffff];
}

- (UIColor*)orangeColor{
    return self[0xff7f00ff];
}

- (UIColor*)purpleColor{
    return self[0x7f007fff];
}

- (UIColor*)brownColor{
    return self[0x996633ff];
}

- (UIColor*)clearColor{
    return self[0x00000000];
}

@end
