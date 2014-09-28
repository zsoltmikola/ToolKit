/**
 * @file    NSObjectBuilder.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */


@interface NSObjectBuilder : NSObject

@property (nonatomic, strong) NSError* error;
@property (nonatomic, copy) void(^indeterminateProgress)(NSUInteger);
@property (nonatomic, copy) void(^determinateProgress)(NSUInteger);
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

- (instancetype)buildWithCompletionBlock:(void(^)(id))block;

@end
