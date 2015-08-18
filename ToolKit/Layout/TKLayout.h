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

@interface TKLayout : UIView <TKLayoutDatasource, TKLayoutDelegate>

@property (nonatomic, strong) NSArray* layoutRelatedNotifications;
@property (nonatomic, strong) id<TKLayoutDatasource> datasource;
@property (nonatomic, strong) id<TKLayoutDelegate> delegate;

@property (nonatomic, assign) NSUInteger gridSize;
@property (nonatomic, assign) BOOL isGridHidden;

- (void)layoutDidLoad;

@end

@interface TKLayout (ConstraintConstructors)

// Single views
- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView toAttribute:(NSLayoutAttribute)baseViewAttribute ofView:(UIView*)baseView withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset withPriority:(NSUInteger)priority;

- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView toAttribute:(NSLayoutAttribute)baseViewAttribute ofView:(UIView*)baseView withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset;

- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView toAttribute:(NSLayoutAttribute)baseViewAttribute ofView:(UIView*)baseView withRelation:(NSLayoutRelation)relation;

- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView toAttribute:(NSLayoutAttribute)baseViewAttribute ofView:(UIView*)baseView;

// Dimensions
- (NSArray*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofViews:(NSArray*)alignedViews withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset withPriority:(NSUInteger)priority;

- (NSArray*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofViews:(NSArray*)alignedViews withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset;

// Multiple views
- (NSArray*)alignAttribute:(NSLayoutAttribute)attribute ofViews:(NSArray*)views toView:(UIView*)baseView withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset withPriority:(NSUInteger)priority;

- (NSArray*)alignAttribute:(NSLayoutAttribute)attribute ofViews:(NSArray*)views toView:(UIView*)baseView withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset;

- (NSArray*)alignAttribute:(NSLayoutAttribute)attribute ofViews:(NSArray*)views toView:(UIView*)baseView withRelation:(NSLayoutRelation)relation;

- (NSArray*)alignAttribute:(NSLayoutAttribute)attribute ofViews:(NSArray*)views toView:(UIView*)baseView;

// Formations

- (NSArray*)formColumnWithViews:(NSArray*)views withRelation:(NSLayoutRelation)relation withSpacing:(NSInteger)spacing;

- (NSArray*)formRowWithViews:(NSArray*)views withRelation:(NSLayoutRelation)relation withSpacing:(NSInteger)spacing;


@end
