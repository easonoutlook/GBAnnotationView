//
//  GBCustomCallout.m
//  MapCallouts
//
//  Created by Adam Barrett on 2013-09-12.
//
//

#import "GBCustomCallout.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define MIN_WIDTH_FOR_LEFT_CALLOUT  40
#define MIN_WIDTH_FOR_RIGHT_CALLOUT 30
#define MAX_WIDTH_FOR_LEFT_CALLOUT  40
#define MAX_WIDTH_FOR_RIGHT_CALLOUT 40

#define CALLOUT_HORZ_PADDING        5
#define CALLOUT_VERT_PADDING        5

#define CALLOUT_MARGIN_HORZ         10
#define CALLOUT_MARGIN_VERT         10

#define SUBVIEW_PADDING             5
#define SUBVIEW_HORZ_MARGIN         5
#define SUBVIEW_VERT_MARGIN         5

#define ANCHOR_MARGIN               37

@interface GBCustomCallout ()
{}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;

@property (nonatomic, retain) GBCustomCalloutArrow *arrow;

@property (nonatomic, assign) CGRect constrainingRect;
@property (nonatomic, assign) GBCustomCalloutArrowDirection arrowDirection;
@property (nonatomic, assign) CGPoint anchorPoint;

// A rect holder for Layout
@property (nonatomic, assign) CGRect middleRowRect;

@property (nonatomic, assign, readonly) BOOL shouldExpandToAccessoryHeight;
@property (nonatomic, assign, readonly) BOOL shouldExpandToAccessoryWidth;
@property (nonatomic, assign, readonly) BOOL shouldVerticallyCenterLeftToContent;
@property (nonatomic, assign, readonly) BOOL shouldVerticallyCenterRightToContent;

@end

@implementation GBCustomCallout
{}
#pragma mark - Property Accessors
- (UIView *)titleView
{
    // if the delegate doesn't implement or returns nil, use custom title instead
    UIView *titleViewFromDelegate;
    
    if ([self.delegate respondsToSelector:@selector(titleView)]) {
        titleViewFromDelegate = [self.delegate titleView];
    }
    
    if (titleViewFromDelegate) {
        _titleView = titleViewFromDelegate;
    } else {
        if ([self.title length]) {
            if (!_titleView) {
                _titleView = [GBCustomTitleLabel new];
            }
            
            if ([_titleView isKindOfClass:[GBCustomTitleLabel class]]) {
                ((GBCustomTitleLabel *)_titleView).text = self.title;
            } else {
                _titleView = nil;
            }
        } else {
            _titleView = nil;
        }
    }
    
    return _titleView;
}


- (UIView *)subtitleView
{
    // if the delegate doesn't implement or returns nil, use custom subtitle instead
    UIView *subtitleViewFromDelegate;
    
    if ([self.delegate respondsToSelector:@selector(subtitleView)]) {
        subtitleViewFromDelegate = [self.delegate subtitleView];
    }
    
    if (subtitleViewFromDelegate) {
        _subtitleView = subtitleViewFromDelegate;
    } else {
        if ([self.subtitle length]) {
            if (!_subtitleView) {
                _subtitleView = [GBCustomSubtitleLabel new];
            }
            
            if ([_subtitleView isKindOfClass:[GBCustomSubtitleLabel class]]) {
                ((GBCustomSubtitleLabel *)_subtitleView).text = self.subtitle;
            } else {
                _subtitleView = nil;
            }
        } else {
            _subtitleView = nil;
        }
    }
    
    return _subtitleView;
}


- (UIView *)contentView
{
    if ([self.delegate respondsToSelector:@selector(contentView)]) {
        return self.delegate.contentView;
    }
    
    if (!_contentView) {
        _contentView = [GBCustomContentView new];
        [_contentView addSubview:self.titleView];
        [_contentView addSubview:self.subtitleView];
    }
    
    return _contentView;
}


- (UIView *)leftAccessoryView
{
    if ([self.delegate respondsToSelector:@selector(leftAccessoryView)]) {
        return self.delegate.leftAccessoryView;
    }
    
    return _leftAccessoryView;
}


- (UIView *)rightAccessoryView
{
    if ([self.delegate respondsToSelector:@selector(rightAccessoryView)]) {
        return self.delegate.rightAccessoryView;
    }
    
    return _rightAccessoryView;
}


- (UIView *)headerView
{
    if ([self.delegate respondsToSelector:@selector(headerView)]) {
        return self.delegate.headerView;
    }
    
    return _headerView;
}


- (UIView *)footerView
{
    if ([self.delegate respondsToSelector:@selector(footerView)]) {
        return self.delegate.footerView;
    }
    
    return _footerView;
}


- (UIView *)topView
{
    if ([self.delegate respondsToSelector:@selector(topView)]) {
        return self.delegate.topView;
    }
    
    return _topView;
}


- (UIView *)bottomView
{
    if ([self.delegate respondsToSelector:@selector(bottomView)]) {
        return self.delegate.bottomView;
    }
    
    return _bottomView;
}


- (UIView *)backgroundView
{
    if ([self.delegate respondsToSelector:@selector(backgroundView)]) {
        return self.delegate.backgroundView;
    }
    
    if (!_backgroundView) {
        _backgroundView = [GBCustomBackgroundView new];
    }
    
    return _backgroundView;
}


- (UIView *)arrow
{
    if (!_arrow) {
        _arrow = [[GBCustomCalloutArrow alloc] initWithFrame:CGRectMake(0, 0, 25, 15)];
    }
    
    return _arrow;
}


- (void)setArrowDirection:(GBCustomCalloutArrowDirection)arrowDirection
{
    _arrowDirection = arrowDirection;
    self.arrow.direction = arrowDirection;
}


- (CGPoint)offset
{
    if ([self.delegate respondsToSelector:@selector(calloutOffset)]) {
        return [self.delegate calloutOffset];
    }
    
    return _offset;
}


- (BOOL)shouldExpandToAccessoryHeight
{
    BOOL should = ([self.delegate respondsToSelector:@selector(shouldExpandToAccessoryHeight)] && [self.delegate shouldExpandToAccessoryHeight]);
    
    return should;
}


- (BOOL)shouldExpandToAccessoryWidth
{
    return ([self.delegate respondsToSelector:@selector(shouldExpandToAccessoryWidth)] && [self.delegate shouldExpandToAccessoryWidth]);
}


- (BOOL)shouldVerticallyCenterLeftAccessory
{
    BOOL should = ([self.delegate respondsToSelector:@selector(shouldVerticallyCenterLeftAccessory)] && [self.delegate shouldVerticallyCenterLeftAccessory]);
    
    return should;
}


- (BOOL)shouldVerticallyCenterRightAccessory
{
    if ([self.delegate respondsToSelector:@selector(shouldVerticallyCenterRightAccessory)]) {
        return [self.delegate shouldVerticallyCenterRightAccessory];
    }
    
    return YES;
}


- (BOOL)shouldConstrainLeftAccessoryToContent
{
    return ([self.delegate respondsToSelector:@selector(shouldConstrainLeftAccessoryToContent)] && [self.delegate shouldConstrainLeftAccessoryToContent]);
}


- (BOOL)shouldConstrainRightAccessoryToContent
{
    return ([self.delegate respondsToSelector:@selector(shouldConstrainRightAccessoryToContent)] && [self.delegate shouldConstrainRightAccessoryToContent]);
}


#pragma mark - Class methods
+ (GBCustomCallout *)customCalloutWithDelegate:(id <GBCustomCalloutViewDelegate> )delegate
{
    GBCustomCallout *callout = [GBCustomCallout new];
    
    callout.delegate = delegate;
    return callout;
}


#pragma mark - Initialization
- (void)_init
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.autoresizesSubviews = NO;
    self.autoresizingMask = UIViewAutoresizingNone;
    self.presentAnimation = GBCustomCalloutAnimationBounce;
    self.dismissAnimation = GBCustomCalloutAnimationFade;
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
}


- (id)init
{
    self = [super init];
    
    if (self) {
        [self _init];
    }
    
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self _init];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self _init];
    }
    
    return self;
}


#pragma mark - Instance Methods
- (void)presentCalloutForAnnotationView:(MKAnnotationView *)annotationView
                              inMapView:(MKMapView *)mapView
{
    self.annotationView = annotationView;
    self.mapView = mapView;
    
    self.title = annotationView.annotation.title;
    self.subtitle = annotationView.annotation.subtitle;
    
    if (![self.delegate isEqual:annotationView]) {
        self.rightAccessoryView = annotationView.rightCalloutAccessoryView;
        self.leftAccessoryView = annotationView.leftCalloutAccessoryView;
    }
    
    [self configureCalloutWithAnnotationView:annotationView mapView:mapView];
    
    // need layout before positioning
    [self setNeedsLayout];
    [self layoutIfNeeded];
    [self positionCalloutRelativeTo:annotationView];
    
    [self addCalloutToAnnotationView:annotationView];
    [self animateIn];
}


- (void)configureCalloutWithAnnotationView:(MKAnnotationView *)annotationView
                                   mapView:(MKMapView *)mapView
{
    [self configureSubviews];
    
    [self sizeToFit];
    self.constrainingRect = [self determineContraintRectWith:mapView inAnnotationView:annotationView];
    self.arrowDirection = [self determineArrowDirectionWithMapView:mapView annotationView:annotationView];
    self.anchorPoint = [self determineAnchorPointWith:annotationView];
}


- (CGRect)determineContraintRectWith:(MKMapView *)mapView
                    inAnnotationView:(MKAnnotationView *)annotationView
{
    return [mapView.layer convertRect:mapView.layer.bounds toLayer:annotationView.layer];
}


- (GBCustomCalloutArrowDirection)determineArrowDirectionWithMapView:(MKMapView *)mapView
                                                     annotationView:(MKAnnotationView *)annotationView
{
    GBCustomCalloutArrowDirection bestDirection = GBCustomCalloutArrowDirectionDown;
    
    BOOL any = self.allowedArrowDirections == GBCustomCalloutArrowDirectionAny;
    BOOL up  = self.allowedArrowDirections & GBCustomCalloutArrowDirectionUp;
    
    // do we allow it to point up?
    if (any || up) {
        CGRect rect = [annotationView convertRect:annotationView.bounds toView:mapView];
        // how much room do we have in the map, both above and below our target rect?
        CGFloat topSpace = CGRectGetMinY(rect);
        CGFloat bottomSpace = CGRectGetMaxY(mapView.frame) - CGRectGetMaxY(rect);
        
        CGFloat calloutHeight = self.frame.size.height + self.arrow.frame.size.height;
        
        if (topSpace < calloutHeight && bottomSpace > topSpace) {
            bestDirection = GBCustomCalloutArrowDirectionUp;
        }
    }
    
    return bestDirection;
}


- (CGPoint)determineAnchorPointWith:(MKAnnotationView *)annotationView
{
    CGPoint anchorPoint;
    BOOL pointingDown = (self.arrowDirection == GBCustomCalloutArrowDirectionDown);
    CGFloat x = CGRectGetMidX(annotationView.bounds);
    CGFloat y = pointingDown ? CGRectGetMinY(annotationView.bounds) : CGRectGetMaxY(annotationView.bounds);
    CGFloat offsetY = pointingDown ? self.offset.y : - (self.offset.y);
    
    anchorPoint = CGPointMake(x + self.offset.x, y + offsetY);
    return anchorPoint;
}


- (void)positionCalloutRelativeTo:(MKAnnotationView *)annotationView
{
    BOOL pointingDown = self.arrowDirection == GBCustomCalloutArrowDirectionDown;
    
    CGFloat centerY = self.anchorPoint.y + self.frame.size.height / 2 * (pointingDown ? -1 : 1);
    
    // try for center of constraining rect
    self.center = CGPointMake(CGRectGetMidX(self.constrainingRect), centerY);
    
    // move up or down for arrow
    CGFloat yOffsetForArrow = self.arrow.frame.size.height * (pointingDown ? -1 : 1);
    self.frame = CGRectOffset(self.frame, 0, yOffsetForArrow + (pointingDown ? 1 : -1));
    
    // scoot to the left or right if not wide enough for arrow to point
    CGFloat minPointX = CGRectGetMinX(self.frame) + ANCHOR_MARGIN;
    CGFloat maxPointX = CGRectGetMaxX(self.frame) - ANCHOR_MARGIN;
    
    CGFloat adjustX = 0;
    
    if (self.anchorPoint.x < minPointX) adjustX = self.anchorPoint.x - minPointX;
    
    if (self.anchorPoint.x > maxPointX) adjustX = self.anchorPoint.x - maxPointX;
    
    // make sure frame is not on half pixels CGRectIntegral(self.frame)
    self.frame = CGRectOffset(self.frame, adjustX, 0);
    
    CGSize arrowSize = self.arrow.frame.size;
    self.arrow.center = self.anchorPoint;
    CGFloat arrowOffset = pointingDown ? -(arrowSize.height / 2) : (arrowSize.height / 2);
    self.arrow.frame = CGRectOffset(self.arrow.frame, 0, arrowOffset);
}


- (void)addCalloutToAnnotationView:(MKAnnotationView *)annotationView
{
    self.hidden = YES;
    self.arrow.hidden = YES;
    [annotationView addSubview:self.arrow];
    [annotationView addSubview:self];
}


- (void)dismiss
{
    self.annotationView = nil;
    [self animateOut];
}


#pragma mark - Building Subviews
- (void)configureSubviews
{
    [self addSubview:self.contentView];
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    [self addSubview:self.leftAccessoryView];
    [self addSubview:self.rightAccessoryView];
    [self addSubview:self.headerView];
    [self addSubview:self.footerView];
    [self addSubview:self.backgroundView];
}


- (void)addSubview:(UIView *)view toGroup:(NSMutableArray *)group
{
    if (view) {
        [self addSubview:view];
        
        if (![group containsObject:view]) {
            [group addObject:view];
        }
    }
}


#pragma mark - Layout
- (void)layoutSubviews
{
    /*
     ------------------------------------------
     |             Header View                |
     |________________________________________|
     |        |      Top View      |          |
     |        |--------------------|          |
     |  Left  |    Content View    |  Right   |
     |Access..|      - titleView   |Accessor..|
     |  view  |      - subtitleVi..|   View   |
     |        |--------------------|          |
     |        |    Bottom View     |          |
     ------------------------------------------
     |             Footer View                |
     |________________________________________|
     */
    
    if (!self.annotationView) return;
    
    CGRect layout = [self positionSubviewsRelativeToEachOther];
    layout = CGRectInset(layout, -CALLOUT_HORZ_PADDING, -CALLOUT_VERT_PADDING);
    self.bounds = layout;
    
    [self positionSubviewsRelativeToCallout];
    
    [self bringSubviewToFront:self.contentView];
    [self sendSubviewToBack:self.backgroundView];
}


- (CGRect)positionSubviewsRelativeToEachOther
{
    CGSize contentSize = self.contentView.frame.size;
    __block CGRect wrappingRect = CGRectMake(0, 0, contentSize.width, contentSize.height);
    
    self.contentView.frame = wrappingRect;
    
    // add left/right now if constrained
    if (self.shouldConstrainLeftAccessoryToContent) {
        wrappingRect = [self rectFromAddingView:self.leftAccessoryView toRect:wrappingRect onEdge:CGRectMinXEdge];
    }
    if (self.shouldConstrainRightAccessoryToContent) {
        wrappingRect = [self rectFromAddingView:self.rightAccessoryView toRect:wrappingRect onEdge:CGRectMaxXEdge];
    }
    
    // save the middle row rect for use in positioning later
    self.middleRowRect = wrappingRect;
    
    wrappingRect = [self rectFromAddingView:self.topView toRect:wrappingRect onEdge:CGRectMinYEdge];
    wrappingRect = [self rectFromAddingView:self.bottomView toRect:wrappingRect onEdge:CGRectMaxYEdge];
    
    // add left/right after top and bottom if not constrained
    if ( !self.shouldConstrainLeftAccessoryToContent ) {
        wrappingRect = [self rectFromAddingView:self.leftAccessoryView toRect:wrappingRect onEdge:CGRectMinXEdge];
    }
    if ( !self.shouldConstrainRightAccessoryToContent ) {
        wrappingRect = [self rectFromAddingView:self.rightAccessoryView toRect:wrappingRect onEdge:CGRectMaxXEdge];
    }
    
    wrappingRect = [self rectFromAddingView:self.headerView toRect:wrappingRect onEdge:CGRectMinYEdge];
    wrappingRect = [self rectFromAddingView:self.footerView toRect:wrappingRect onEdge:CGRectMaxYEdge];
    
    return wrappingRect;
}

- (CGRect)rectFromAddingView:(UIView *)view toRect:(CGRect)rect onEdge:(CGRectEdge)edge
{
    if (!view) return rect;
    
    CGPoint origin = [self originForView:view inRect:rect forEdge:edge];
    return [self wrappingRect:rect forPositioningSubview:view atPoint:origin];
}

- (CGPoint)originForView:(UIView *)view inRect:(CGRect)rect forEdge:(CGRectEdge)edge
{
    CGPoint origin;
    switch (edge) {
        case CGRectMinXEdge:
            origin = CGPointMake(-(CGRectGetWidth(view.frame) + SUBVIEW_HORZ_MARGIN), 0);
            break;
        case CGRectMaxXEdge:
            origin = CGPointMake(CGRectGetMaxX(rect) + SUBVIEW_HORZ_MARGIN, 0);
            break;
        case CGRectMinYEdge:
            origin = CGPointMake(CGRectGetMinX(rect), -(CGRectGetHeight(view.frame) + SUBVIEW_VERT_MARGIN));
            break;
        case CGRectMaxYEdge:
            origin = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) + SUBVIEW_HORZ_MARGIN);
            break;
            
        default:
            break;
    }
    return origin;
}


- (CGRect)wrappingRect:(CGRect)rect forPositioningSubview:(UIView *)subview atPoint:(CGPoint)point
{
    if (!subview) return rect;
    
    CGRect f = subview.frame;
    f.origin = point;
    subview.frame = f;
    
    if (CGRectEqualToRect(rect, CGRectZero)) {
        return f;
    }
    
    return CGRectUnion(rect, f);
}


- (void)positionSubviewsRelativeToCallout
{
    CGRect b = self.bounds;
    if (self.leftAccessoryView && self.shouldVerticallyCenterRightAccessory) {
        CGRect boundingBox = self.shouldConstrainLeftAccessoryToContent ? self.middleRowRect : b;
        [self verticallyCenterView:self.leftAccessoryView inRect:boundingBox];
    }
    if (self.rightAccessoryView && self.shouldVerticallyCenterRightAccessory) {
        CGRect boundingBox = self.shouldConstrainRightAccessoryToContent ? self.middleRowRect : b;
        [self verticallyCenterView:self.rightAccessoryView inRect:boundingBox];
    }
    if (self.backgroundView) {
        self.backgroundView.frame = b;
    }
}

- (void)verticallyCenterView:(UIView *)view inRect:(CGRect)rect
{
    CGPoint c = view.center;
    view.center = CGPointMake(c.x, CGRectGetMidY(rect));
}

- (CGSize)sizeThatFits:(CGSize)size
{
    [self sizeToFitView:self.titleView ifClass:[GBCustomTitleLabel class]];
    [self sizeToFitView:self.subtitleView ifClass:[GBCustomSubtitleLabel class]];
    [self sizeToFitView:self.contentView ifClass:[GBCustomContentView class]];
    
    return self.bounds.size;
}


- (void)sizeToFitView:(UIView *)view ifClass:(Class)class
{
    if ([view isKindOfClass:class]) {
        [view sizeToFit];
    }
}


#pragma mark - Animate callout in/out
- (void)animateIn
{
    // if animation type is Bounce
    // - determine layer.anchorPoint (based on self.anchorpoint?)
    // if that moves the view a bit move it back
    if ([self isContainedByConstrainingRect]) {
        [self animateInWithType:self.presentAnimation];
    } else {
        [self moveMapToContainCalloutThen:^{
            [self animateInWithType:self.presentAnimation];
        }];
    }
}


- (void)animateOut
{
    [self animateOutWithType:self.dismissAnimation];
}


- (void)animateInWithType:(GBCustomCalloutAnimation)type
{
    __block GBCustomCallout *_self = self;
    
    switch (type) {
        case GBCustomCalloutAnimationFade: {
            self.alpha = 0;
            self.arrow.alpha = 0;
            self.hidden = NO;
            self.arrow.hidden = NO;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 _self.alpha = 1;
                                 _self.arrow.alpha = 1;
                             }
             
             
                             completion:nil];
        }
            break;
            
        case GBCustomCalloutAnimationBounce:
        default: {
            [self setLayerAnchorFromAnnotationAnchorPoint];
            self.transform = CGAffineTransformMakeScale(0.5, 0.5);
            self.arrow.transform = CGAffineTransformMakeScale(0.5, 0.5);
            self.hidden = NO;
            self.arrow.hidden = NO;
            [UIView animateWithDuration:0.15
                             animations:^{
                                 _self.transform = CGAffineTransformMakeScale(1.05, 1.05);
                                 _self.arrow.transform = CGAffineTransformMakeScale(1.05, 1.05);
                             }
             
             
                             completion:^(BOOL finished) {
                                 [UIView  animateWithDuration:0.05
                                                   animations:^{
                                                       _self.transform = CGAffineTransformIdentity;
                                                       _self.arrow.transform = CGAffineTransformIdentity;
                                                   }
                                  
                                  
                                                   completion:^(BOOL finished) {
                                                       [_self setLayerAnchor:CGPointMake(0.5, 0.5)];
                                                   }];
                             }];
        }
            break;
    }
}


- (void)animateOutWithType:(GBCustomCalloutAnimation)type
{
    __block GBCustomCallout *_self = self;
    
    switch (type) {
        case GBCustomCalloutAnimationBounce: {
            [self setLayerAnchorFromAnnotationAnchorPoint];
            [UIView animateWithDuration:0.05
                             animations:^{
                                 _self.transform = CGAffineTransformMakeScale(1.05, 1.05);
                                 _self.arrow.transform = CGAffineTransformMakeScale(1.05, 1.05);
                             }
             
             
                             completion:^(BOOL finished) {
                                 [UIView  animateWithDuration:0.15
                                                   animations:^{
                                                       _self.transform = CGAffineTransformMakeScale(0.5, 0.5);
                                                       _self.arrow.transform = CGAffineTransformMakeScale(0.5, 0.5);
                                                   }
                                  
                                  
                                                   completion:^(BOOL finished) {
                                                       [_self setLayerAnchor:CGPointMake(0.5, 0.5)];
                                                       [_self removeFromSuperview];
                                                       [_self.arrow removeFromSuperview];
                                                   }];
                             }];
        }
            break;
            
        case GBCustomCalloutAnimationFade:
        default: {
            [UIView animateWithDuration:0.3
                             animations:^{
                                 _self.alpha = 0;
                                 _self.arrow.alpha = 0;
                             }
             
             
                             completion:^(BOOL finished) {
                                 [_self removeFromSuperview];
                                 [_self.arrow removeFromSuperview];
                                 _self.alpha = 1;
                                 _self.arrow.alpha = 1;
                             }];
        }
            break;
    }
}


- (void)setLayerAnchorFromAnnotationAnchorPoint
{
    CGRect b = self.layer.bounds;
    CGPoint anchorPoint = [self convertPoint:self.anchorPoint fromView:self.annotationView];
    
    CGFloat width = CGRectGetWidth(b);
    CGFloat height = CGRectGetHeight(b);
    
    anchorPoint.x /= width;
    anchorPoint.y /= height;
    
    if (isnan(anchorPoint.x) || isnan(anchorPoint.y)) {
        NSLog(@"Huh?");
    }
    
    [self setLayerAnchor:anchorPoint];
}


- (void)setLayerAnchor:(CGPoint)point
{
    CGRect b = self.layer.bounds;
    
    CGFloat width = CGRectGetWidth(b);
    CGFloat height = CGRectGetHeight(b);
    
    if (height <= 0 || width <= 0) {
        NSLog(@"Bubble has no content");
        return;
    }
    
    CGPoint newPoint = CGPointMake(width * point.x, height * point.y);
    CGPoint oldPoint = CGPointMake(width * self.layer.anchorPoint.x, height * self.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, self.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, self.transform);
    
    CGPoint position = self.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    self.layer.position = position;
    self.layer.anchorPoint = point;
}


- (BOOL)isContainedByConstrainingRect
{
    return CGRectContainsRect(CGRectInset(self.constrainingRect, CALLOUT_MARGIN_HORZ, CALLOUT_MARGIN_VERT), self.frame);
}


- (void)moveMapToContainCalloutThen:(void (^)(void))callback
{
    if ([self.delegate respondsToSelector:@selector(moveMapByOffset:then:)]) {
        CGPoint offset = [self offsetToContainRect:self.frame inRect:CGRectInset(self.constrainingRect, CALLOUT_MARGIN_HORZ, CALLOUT_MARGIN_VERT)];
        [self.delegate moveMapByOffset:offset then:callback];
    } else {
        callback();
    }
}


- (CGPoint)offsetToContainRect:(CGRect)innerRect inRect:(CGRect)outerRect
{
    CGFloat nudgeRight  = MAX(0, CGRectGetMinX(outerRect) - CGRectGetMinX(innerRect));
    CGFloat nudgeLeft   = MIN(0, CGRectGetMaxX(outerRect) - CGRectGetMaxX(innerRect));
    CGFloat nudgeTop    = MAX(0, CGRectGetMinY(outerRect) - CGRectGetMinY(innerRect));
    CGFloat nudgeBottom = MIN(0, CGRectGetMaxY(outerRect) - CGRectGetMaxY(innerRect));
    
    return CGPointMake(nudgeLeft ? : nudgeRight, nudgeTop ? : nudgeBottom);
}


#pragma mark - Actions
- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer
{
    [self activate];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}


- (void)activate
{
    if ([self.backgroundView isKindOfClass:[GBCustomBackgroundView class]]) {
        ((GBCustomBackgroundView *)self.backgroundView).active = YES;
    }
    
    self.arrow.active = YES;
    
    SEL calloutAccessoryTappedSelector = sel_registerName("calloutAccessoryTapped:");
    
    if (self.rightAccessoryView) {
        if ([self.annotationView respondsToSelector:calloutAccessoryTappedSelector]) {
            [self.annotationView performSelector:calloutAccessoryTappedSelector withObject:self.rightAccessoryView afterDelay:0.3];
        }
    }
    
    [self performSelector:@selector(deactivate) withObject:nil afterDelay:0.3];
}


- (void)deactivate
{
    if ([self.backgroundView isKindOfClass:[GBCustomBackgroundView class]]) {
        ((GBCustomBackgroundView *)self.backgroundView).active = NO;
    }
    
    self.arrow.active = NO;
}


@end

#pragma mark - *** GBCustomTitleLabel *** -
@implementation GBCustomTitleLabel

- (id)init
{
    self = [super init];
    
    if (self) {
        self.font = [UIFont systemFontOfSize:16];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


@end


#pragma mark - *** GBCustomSubtitleLabel *** -
@implementation GBCustomSubtitleLabel

- (id)init
{
    self = [super init];
    
    if (self) {
        self.font = [UIFont systemFontOfSize:12];
    }
    
    return self;
}


@end


#pragma mark - *** GBCustomContentView *** -
@implementation GBCustomContentView

- (id)init
{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}


- (CGSize)sizeThatFits:(CGSize)size
{
    __block CGFloat y = 0;
    __block CGFloat x = 0;
    
    [self.subviews
     enumerateObjectsUsingBlock: ^(UIView *subview, NSUInteger idx, BOOL *stop) {
         CGSize size = subview.frame.size;
         y += size.height;
         x = MAX(x, size.width);
     }];
    return CGSizeMake(x, y);
}


- (void)layoutSubviews
{
    /*
     ------------------------------------------
     | Title                                  |
     |________________________________________|
     | Subtitle                               |
     |________________________________________|
     */
    __block CGFloat y = 0;
    
    [self.subviews
     enumerateObjectsUsingBlock: ^(UIView *subview, NSUInteger idx, BOOL *stop) {
         CGRect f = subview.frame;
         subview.frame = CGRectMake(f.origin.x, y, f.size.width, f.size.height);
         y = CGRectGetMaxY(subview.frame);
     }];
}


@end


#pragma mark - *** GBCustomBackgroundView *** -
static UIColor *_gbCustomCalloutBackgroundActiveColor;
static UIColor *_gbCustomCalloutBackgroundInactiveColor;

@implementation GBCustomBackgroundView
+ (void)initialize
{
    _gbCustomCalloutBackgroundActiveColor = [UIColor colorWithWhite:0.85 alpha:1];
    _gbCustomCalloutBackgroundInactiveColor = [UIColor whiteColor];
}


- (id)init
{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


- (void)setActive:(BOOL)active
{
    _active = active;
    self.backgroundColor = active ? _gbCustomCalloutBackgroundActiveColor : _gbCustomCalloutBackgroundInactiveColor;
}


@end


#pragma mark - *** GBCustomCalloutArrow *** -
@interface GBCustomCalloutArrow ()
{}
@property (nonatomic, strong) CAShapeLayer *downMask;
@property (nonatomic, strong) CAShapeLayer *upMask;
@property (nonatomic, strong) UIColor *triangleColor;
@end;

@implementation GBCustomCalloutArrow
{}
+ (void)initialize
{
    _gbCustomCalloutBackgroundActiveColor = [UIColor colorWithWhite:0.85 alpha:1];
    _gbCustomCalloutBackgroundInactiveColor = [UIColor whiteColor];
}


- (void)setActive:(BOOL)active
{
    _active = active;
    self.backgroundColor = active ? _gbCustomCalloutBackgroundActiveColor : _gbCustomCalloutBackgroundInactiveColor;
}


- (UIColor *)triangleColor
{
    if (!_triangleColor) {
        _triangleColor = [UIColor whiteColor];
    }
    
    return _triangleColor;
}


- (void)setDirection:(GBCustomCalloutArrowDirection)direction
{
    _direction = direction;
    CAShapeLayer *mask = (direction != GBCustomCalloutArrowDirectionUp) ? self.downMask : self.upMask;
    self.layer.mask = mask;
}


- (CAShapeLayer *)downMask
{
    if (!_downMask) {
        _downMask = [self maskingTriangleForDirection:GBCustomCalloutArrowDirectionDown];
    }
    
    return _downMask;
}


- (CAShapeLayer *)upMask
{
    if (!_upMask) {
        _upMask = [self maskingTriangleForDirection:GBCustomCalloutArrowDirectionUp];
    }
    
    return _upMask;
}


- (CAShapeLayer *)maskingTriangleForDirection:(GBCustomCalloutArrowDirection)direction
{
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = [self trianglePath:direction];
    
    [maskLayer setPath:path];
    [maskLayer setFillColor:[[UIColor greenColor] CGColor]];
    return maskLayer;
}


- (CGMutablePathRef)trianglePath:(GBCustomCalloutArrowDirection)direction
{
    CGRect b = self.bounds;
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat leftY, midY, rightY;
    
    if (direction == GBCustomCalloutArrowDirectionUp) {
        leftY  = CGRectGetMaxY(b);
        midY   = CGRectGetMinY(b);
        rightY = CGRectGetMaxY(b);
    } else {
        leftY  = CGRectGetMinY(b);
        midY   = CGRectGetMaxY(b);
        rightY = CGRectGetMinY(b);
    }
    
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(b), leftY);    // bottom left
    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(b), midY); // top center
    CGPathAddLineToPoint(path, NULL, CGRectGetMaxX(b), rightY); // bottom right
    
    return path;
}


- (void)_init
{
    self.direction = GBCustomCalloutArrowDirectionDown;
    self.backgroundColor = _gbCustomCalloutBackgroundInactiveColor;
}


- (id)init
{
    self = [super init];
    
    if (self) {
        [self _init];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self _init];
    }
    
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self _init];
    }
    
    return self;
}


@end
