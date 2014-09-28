/**
 * @file    NSString+ToolKit.h
 * @author  Klaus-Peter Dudas
 */

@import Foundation;

@interface NSString (ToolKit)

@property (nonatomic, readonly) NSString *md5;
@property (nonatomic, readonly) NSString *sha1;
@property (nonatomic, readonly) NSString *sha224;
@property (nonatomic, readonly) NSString *sha256;
@property (nonatomic, readonly) NSString *sha384;
@property (nonatomic, readonly) NSString *sha512;

@end
