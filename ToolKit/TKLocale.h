/**
 * @file    TKLocale.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 * @brief A localization helper
 */

#import <Foundation/Foundation.h>

@interface TKLocale : NSObject

@property (nonatomic, strong, readonly) NSLocale* locale;
@property (nonatomic, strong) NSString* localeIdentifier;
@property (nonatomic, strong, readonly) NSNumberFormatter* numberFormatter;
@property (nonatomic, strong, readonly) NSDateFormatter* dateFormatter;
@property (nonatomic, copy) NSString* decorationFormatString;

- (NSString*)localizeString:(NSString *)string fromTable:(NSString*)table fromBundle:(NSBundle*)bundle;
- (NSString*)localizeString:(NSString*)string;
- (NSString*)localizeNumber:(NSNumber*)number;
- (NSString*)localizeCurrency:(NSNumber*)currency;
- (NSString*)localizeDate:(NSDate*)date;

@end
