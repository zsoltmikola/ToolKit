/**
 * @file    TKLayout.m
 * @author  Zsolt Mikola
 * @copyright Zsolt Mikola. All rights reserved.
 * @brief A layout helper
 */

#import "TKLayout.h"

@interface TKLayout ()

@property (nonatomic, strong) NSArray* currentConstraints;

@end

@implementation TKLayout

- (instancetype)init
{
    if (!(self = [super init])) return self;
    
    _datasource = self;
    _isGridHidden = YES;
    _gridSize = 1;
    
    return self;
}

- (void)addSubview:(UIView *)view{
    [super addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)setLayoutRelatedNotifications:(NSArray *)layoutRelatedNotifications{
    _layoutRelatedNotifications = layoutRelatedNotifications;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    for (NSString* notificationName in layoutRelatedNotifications) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnvironmentHasChanged) name:notificationName object:nil];
    }
    
    for (id aView in self.subviews) {
        if ([aView isKindOfClass:[TKLayout class]]) {
            [aView setLayoutRelatedNotifications:_layoutRelatedNotifications];
        }
    }
}

- (void)setCurrentConstraints:(NSArray *)currentConstraints{
    
    // Remove old layout (constraints)
    for (UIView* subView in self.subviews) {
        for (NSLayoutConstraint* aConstraint in subView.constraints) {
            if ([self.currentConstraints containsObject:aConstraint]) {
                [subView removeConstraint:aConstraint];
            }
        }
    }
    
    for (NSLayoutConstraint* aConstraint in self.constraints) {
        if ([self.currentConstraints containsObject:aConstraint]) {
            [self removeConstraint:aConstraint];
        }
    }
    
    _currentConstraints = currentConstraints;
    
    // Install new layout (constraints)
    UIView* commonSuperview;
    
    for (NSLayoutConstraint* constraint in _currentConstraints) {
        commonSuperview = [self superviewWithView:constraint.firstItem withView:constraint.secondItem];
        if (commonSuperview != self) {
            commonSuperview.translatesAutoresizingMaskIntoConstraints = NO;
        }
        [commonSuperview addConstraint:constraint];
    }
    
    // Force update
    [self setNeedsUpdateConstraints];
}

- (void)applicationEnvironmentHasChanged{
    
    NSMutableArray* constraints = @[].mutableCopy;
    
    if ([self respondsToSelector:@selector(traitCollection)]) {
         [constraints addObjectsFromArray: [self.datasource constraintsForLayout:self forDevice:[UIDevice currentDevice] forScreenCollection:[UIScreen screens] forTraitCollection:self.traitCollection]];
    }
    
    [constraints addObjectsFromArray: [self.datasource constraintsForLayout:self forDevice:[UIDevice currentDevice] forScreenCollection:[UIScreen screens]]];
    
    [constraints addObjectsFromArray: [self.datasource constraintsForLayout:self forDevice:[UIDevice currentDevice]]];
    
    [constraints addObjectsFromArray: [self.datasource constraintsForLayout:self]];
    
    self.currentConstraints = constraints;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    
    NSMutableArray* constraints = @[].mutableCopy;
    
    [constraints addObjectsFromArray: [self.datasource constraintsForLayout:self forDevice:[UIDevice currentDevice] forScreenCollection:[UIScreen screens]]];
    
    [constraints addObjectsFromArray: [self.datasource constraintsForLayout:self forDevice:[UIDevice currentDevice]]];
    
    [constraints addObjectsFromArray: [self.datasource constraintsForLayout:self]];
    
    self.currentConstraints = constraints;
}

- (NSArray*)constraintsForLayout:(TKLayout*)layout forDevice:(UIDevice*)device forScreenCollection:(NSArray*)screenCollection forTraitCollection:(UITraitCollection*)traitcollection{
    return nil;
}

- (NSArray*)constraintsForLayout:(TKLayout*)layout forDevice:(UIDevice*)device forScreenCollection:(NSArray*)screenCollection{
    return nil;
}

- (NSArray*)constraintsForLayout:(TKLayout*)layout forDevice:(UIDevice*)device{
    return nil;
}

- (NSArray*)constraintsForLayout:(TKLayout*)layout{
    return nil;
}

- (UIView*)superviewWithView:(UIView*)firstView withView:(UIView*)secondView{

    if (!secondView) {
        return firstView;
    }
    
    NSMutableSet* commonAncestors = [NSMutableSet set];
    NSMutableSet* ancestors = [NSMutableSet set];
    
    // Gather all ancestor of the two views into the common ancestors set.
    for (UIView* aView in @[firstView, secondView]) {
        UIView* ancestor = aView.superview;
        while (nil != ancestor) {
            [ancestors addObject:ancestor];
            ancestor = ancestor.superview;
        }
        
        // if the common ancestor set already contains element, then intersect, else union, since it's the first iteration
        if (commonAncestors.count) {
            [commonAncestors intersectSet:ancestors];
        }else{
            [commonAncestors unionSet:ancestors];
        }
    }
    
    if (!commonAncestors.count) {
        NSAssert(!commonAncestors.count, @"No common superview");
    }
    
    // Bubble up from any view until the first ancestor in the common ancestor set
    UIView* aView = firstView;
    while (![commonAncestors containsObject:aView]) {
        aView = aView.superview;
    }
    
    return aView;
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)drawRect:(CGRect)rect
{
    
    if (_isGridHidden) return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context,kCGLineCapRound);
    CGContextSetLineWidth(context, 1);
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGFloat dashes[] = { 0, self.gridSize };
    CGContextSetLineDash( context, 0.0, dashes, 2 );
    
    
    CGFloat yPos = 0.0;
    
    while (yPos < rect.size.height) {
        CGContextMoveToPoint(context, CGRectGetMinX(rect), yPos);
        CGContextAddLineToPoint(context, CGRectGetMaxX(rect), yPos);
        CGContextStrokePath(context);
        yPos += self.gridSize;
    }
    
}

@end

@implementation TKLayout (ConstraintConstructors)

- (NSLayoutConstraint *)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView *)alignedView toAttribute:(NSLayoutAttribute)baseViewAttribute ofView:(UIView *)baseView withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset withPriority:(NSUInteger)priority{
    
    /// Noramlizing priority
    if (priority) {
        priority -= 1;
        priority %= 1000;
        priority += 1;
    }
    
    NSInteger constant = 0;
    CGFloat multiplier = 1.0f;
    
    if (0.0f < inset && inset < 1.0f) {
        multiplier = inset;
    }else{
        constant = (round(inset / _gridSize))*_gridSize;
    }
    
    return [NSLayoutConstraint constraintWithItem:alignedView attribute:alignedViewAttribute relatedBy:relation toItem:baseView attribute:baseViewAttribute multiplier:multiplier constant:constant];
}

- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView toAttribute:(NSLayoutAttribute)baseViewAttribute ofView:(UIView*)baseView withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset{
    return [self alignAttribute:alignedViewAttribute ofView:alignedView toAttribute:baseViewAttribute ofView:baseView withRelation:relation withInset:inset withPriority:1000];
}

- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView toAttribute:(NSLayoutAttribute)baseViewAttribute ofView:(UIView*)baseView withRelation:(NSLayoutRelation)relation{
    return [self alignAttribute:alignedViewAttribute ofView:alignedView toAttribute:baseViewAttribute ofView:baseView withRelation:relation withInset:0.0f withPriority:1000];
}

- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView toAttribute:(NSLayoutAttribute)baseViewAttribute ofView:(UIView*)baseView{
    return [self alignAttribute:alignedViewAttribute ofView:alignedView toAttribute:baseViewAttribute ofView:baseView withRelation:NSLayoutRelationEqual withInset:0.0f withPriority:1000];
}

- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset withPriority:(NSUInteger)priority{
    return [self alignAttribute:alignedViewAttribute ofView:alignedView toAttribute:NSLayoutAttributeNotAnAttribute ofView:nil withRelation:relation withInset:inset withPriority:priority];
}

- (NSLayoutConstraint*)alignAttribute:(NSLayoutAttribute)alignedViewAttribute ofView:(UIView*)alignedView withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset{
    return [self alignAttribute:alignedViewAttribute ofView:alignedView toAttribute:NSLayoutAttributeNotAnAttribute ofView:nil withRelation:relation withInset:inset withPriority:1000];
}

- (NSArray *)alignAttribute:(NSLayoutAttribute)attribute forViews:(NSArray *)views withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset withPriority:(NSUInteger)priority{

    NSMutableArray* constraints = @[].mutableCopy;
    NSLayoutConstraint* aConstraint;
    
    NSEnumerator* enumerator = views.objectEnumerator;
    UIView* baseView = enumerator.nextObject;
    UIView* alignedView = enumerator.nextObject;
    
    while (alignedView) {
        aConstraint = [self alignAttribute:attribute ofView:alignedView toAttribute:attribute ofView:baseView withRelation:relation withInset:inset withPriority:priority];
        [constraints addObject:aConstraint];
        alignedView = enumerator.nextObject;
    }
    
    return constraints;
}

- (NSArray *)alignAttribute:(NSLayoutAttribute)attribute forViews:(NSArray *)views withRelation:(NSLayoutRelation)relation withInset:(CGFloat)inset{
    return [self alignAttribute:attribute forViews:views withRelation:relation withInset:inset withPriority:1000];
}

- (NSArray*)alignAttribute:(NSLayoutAttribute)attribute forViews:(NSArray*)views withRelation:(NSLayoutRelation)relation{
    return [self alignAttribute:attribute forViews:views withRelation:relation withInset:0.0f withPriority:1000];
}

- (NSArray *)alignAttribute:(NSLayoutAttribute)attribute forViews:(NSArray *)views{
    return [self alignAttribute:attribute forViews:views withRelation:NSLayoutRelationEqual withInset:0.0f withPriority:1000];
}

@end