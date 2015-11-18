/**
 * @file    TKSerializer.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */

#import <Foundation/Foundation.h>

@protocol TKSerializer <NSObject>

@optional
@property (nonatomic, assign) NSStringEncoding encoding;

@required
- (NSData*)serialize:(id)object;
- (id)unserialize:(NSData*)data;

@end

@interface TKStringSerializer : NSObject <TKSerializer>

@property (nonatomic, assign) NSStringEncoding encoding;

@end

@interface TKJSONSerializer : NSObject <TKSerializer>

@property (nonatomic, assign) NSStringEncoding encoding;

@end

@interface TKPropertyListSerializer : NSObject <TKSerializer>

@property (nonatomic, assign) NSStringEncoding encoding;

@end
