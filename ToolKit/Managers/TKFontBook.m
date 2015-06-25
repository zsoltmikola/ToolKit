/**
 * @file    TKFontBook.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import "TKFontBook.h"

@interface TKFontBook ()

@property (nonatomic, strong) NSMutableDictionary* fonts;
@property (nonatomic, copy) NSString* font;

@end

@implementation TKFontBook

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _fonts = @{}.mutableCopy;
    _shouldHIGRespected = YES;
    
    return self;
}

-(id)objectForKeyedSubscript:(NSString *)idx{
    
    if (idx.integerValue) {
        return self[idx.integerValue];
    }
    
    _font = idx;    
    return self;
}

- (UIFont *)objectAtIndex:(NSUInteger)idx{
    return self[idx];
}

- (UIFont*)objectAtIndexedSubscript:(NSUInteger)idx{
    
    if (_shouldHIGRespected && idx < 12) {
        @throw [NSException exceptionWithName:@"Invalid font size"
                                       reason:@"The Human Interface Guidline from Apple recommends to use a minimum 12pt font. To turn off this exception set the shouldHIGRespected property to NO."
                                     userInfo:nil];
    }
    
    NSString* fontIndex = [NSString stringWithFormat:@"%@%lu", _font, (unsigned long)idx];
    
    UIFont* font = _fonts[fontIndex];
    
    if (nil == font) {
        font = [UIFont fontWithName:_font size:idx];
        if (font) {
            _fonts[fontIndex] = font;
        }        
    }
    
    return font;
}

- (UIColor *)objectForKey:(NSString *)idx{
    return self[idx];
}

@end
