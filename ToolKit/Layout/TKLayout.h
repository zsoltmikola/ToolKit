/**
 * @file    TKLayout.h
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 * @brief A layout helper
 */

#import <UIKit/UIKit.h>

@class TKLayout;

@protocol TKLayoutDatasource <NSObject>

- (NSArray*)constraintsForLayout:(TKLayout*)layout forDevice:(UIDevice*)device forScreenCollection:(NSArray*)screenCollection forTraitCollection:(UITraitCollection*)traitcollection;
- (NSArray*)constraintsForLayout:(TKLayout*)layout forDevice:(UIDevice*)device forScreenCollection:(NSArray*)screenCollection;
- (NSArray*)constraintsForLayout:(TKLayout*)layout forDevice:(UIDevice*)device;
- (NSArray*)constraintsForLayout:(TKLayout*)layout;

@end

@protocol TKLayoutDelegate <NSObject>

@end

@interface TKLayout : UIView <TKLayoutDatasource>

@property (nonatomic, strong) NSArray* layoutRelatedNotifications;
@property (nonatomic, strong) id<TKLayoutDatasource> datasource;
@property (nonatomic, strong) id<TKLayoutDelegate> delegate;

@property (nonatomic, assign) NSUInteger gridSize;
@property (nonatomic, assign) BOOL isGridHidden;

@end

@interface TKLayout (ConstraintConstructors)

// Single views
- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView toAttribute:(NSLayoutAttribute)baseViewAttribute ofView:(UIView*)baseView withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset withPriority:(NSUInteger)priority;

- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView toAttribute:(NSLayoutAttribute)baseViewAttribute ofView:(UIView*)baseView withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset;

- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView toAttribute:(NSLayoutAttribute)baseViewAttribute ofView:(UIView*)baseView withRelation:(NSLayoutRelation)relation;

- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView toAttribute:(NSLayoutAttribute)baseViewAttribute ofView:(UIView*)baseView;

// Dimensions
- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset withPriority:(NSUInteger)priority;

- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset;

// Multiple views
- (NSArray*)alignAttribute:(NSLayoutAttribute)attribute forViews:(NSArray*)views withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset withPriority:(NSUInteger)priority;

- (NSArray*)alignAttribute:(NSLayoutAttribute)attribute forViews:(NSArray*)views withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset;

- (NSArray*)alignAttribute:(NSLayoutAttribute)attribute forViews:(NSArray*)views withRelation:(NSLayoutRelation)relation;

- (NSArray*)alignAttribute:(NSLayoutAttribute)attribute forViews:(NSArray*)views;

@end
