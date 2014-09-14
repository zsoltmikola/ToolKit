/**
 * @file    NSObjectBuilder.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 */


@interface NSObjectBuilder : NSObject

@property (nonatomic, strong) NSError* error;
@property (nonatomic, copy) void(^indeterminateProgress)(int);
@property (nonatomic, copy) void(^determinateProgress)(int);

- (void)buildWithCompletionBlock:(void(^)(id))block;

@end
