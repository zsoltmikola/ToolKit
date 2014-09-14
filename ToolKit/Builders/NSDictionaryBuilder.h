/**
 * @file    NSDictionaryBuilder.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */


// Builder: produces entities by production specifications
@interface NSDictionaryBuilder : NSObjectBuilder

- (void)buildFromJSONData:(NSData*)jsonData withCompletionBlock:(void(^)(NSDictionary*))block;

@end
