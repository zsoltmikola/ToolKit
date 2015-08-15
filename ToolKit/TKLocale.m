/**
 * @file    TKLocale.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 * @brief A localization helper
 */

#import "TKLocale.h"

@interface TKLocale ()

@property (nonatomic, strong, readwrite) NSNumberFormatter* numberFormatter;
@property (nonatomic, strong, readwrite) NSDateFormatter* dateFormatter;

@end

@implementation TKLocale

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _locale = [NSLocale currentLocale];
    _numberFormatter = [NSNumberFormatter new];
    _numberFormatter.locale = _locale;
    _dateFormatter = [NSDateFormatter new];
    _dateFormatter.locale = _locale;
    _dateFormatter.dateStyle = NSDateFormatterShortStyle;
    _dateFormatter.timeStyle = NSDateFormatterShortStyle;
    _decorationFormatString = @"!%@!";
    
    return self;
}

- (NSString *)localeIdentifier{
    return _locale.localeIdentifier;
}

- (void)setLocaleIdentifier:(NSString *)localeIdentifier{
    _locale = [NSLocale localeWithLocaleIdentifier:localeIdentifier];
    _dateFormatter.locale = _locale;
    _dateFormatter.dateStyle = NSDateFormatterShortStyle;
    _dateFormatter.timeStyle = NSDateFormatterShortStyle;
    _numberFormatter.locale = _locale;
}

- (NSString *)localizeString:(NSString *)string fromTable:(NSString*)table fromBundle:(NSBundle*)bundle{
    if (!bundle) {
        bundle = [NSBundle mainBundle];
    }
    return [bundle localizedStringForKey:(string) value:[NSString stringWithFormat:_decorationFormatString, string] table:table];
}

- (NSString *)localizeString:(NSString *)string{
    return [[NSBundle mainBundle] localizedStringForKey:(string) value:[NSString stringWithFormat:_decorationFormatString, string] table:nil];
}

-(NSString *)localizeNumber:(NSNumber *)number{
    _numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [_numberFormatter stringFromNumber:number];
}

- (NSString *)localizeDate:(NSDate *)date{
    return [_dateFormatter stringFromDate:date];
}

- (NSString *)localizeCurrency:(NSNumber *)currency{
    _numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    return [_numberFormatter stringFromNumber:currency];
}

@end
