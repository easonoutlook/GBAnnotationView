//
//  GBCustomCallout.h
//  MapCallouts
//
//  Created by Adam Barrett on 2013-09-12.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol GBCustomCalloutViewDelegate;

// options for which directions the callout is allowed to "point" in.
typedef enum {
    GBCustomCalloutArrowDirectionAny,
    GBCustomCalloutArrowDirectionDown = 1UL << 0,
    GBCustomCalloutArrowDirectionUp = 1UL << 1,
} GBCustomCalloutArrowDirection;


typedef enum {
    GBCustomCalloutAlignmentCenterBottom,
    GBCustomCalloutAlignmentCenterMiddle,
    GBCustomCalloutAlignmentCenterTop,
    GBCustomCalloutAlignmentLeftBottom,
    GBCustomCalloutAlignmentLeftMiddle,
    GBCustomCalloutAlignmentLeftTop,
    GBCustomCalloutAlignmentRightBottom,
    GBCustomCalloutAlignmentRightMiddle,
    GBCustomCalloutAlignmentRightTop,
} GBCustomCalloutAlignment;

// options for the callout present/dismiss animation
typedef enum {
    GBCustomCalloutAnimationBounce,
    GBCustomCalloutAnimationFade,
} GBCustomCalloutAnimation;

@interface GBCustomCallout : UIView <UIGestureRecognizerDelegate>
{}
#pragma mark - Annotations
@property (nonatomic, weak) MKAnnotationView *annotationView;

#pragma mark - Delegates and Decision makers
@property (nonatomic, weak) id<GBCustomCalloutViewDelegate> delegate;
@property (nonatomic, assign) GBCustomCalloutArrowDirection allowedArrowDirections;

#pragma mark - Subviews
// Custom title/subtitle views. if these are set, the respective title/subtitle properties will be ignored.
@property (nonatomic, retain) UIView *titleView, *subtitleView;
// Custom "content" view that can be any width/height. If this is set, title/subtitle/titleView/subtitleView are all ignored.
@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, retain) UIView *leftAccessoryView;
@property (nonatomic, retain) UIView *rightAccessoryView;
@property (nonatomic, retain) UIView *headerView;
@property (nonatomic, retain) UIView *footerView;
@property (nonatomic, retain) UIView *topView;
@property (nonatomic, retain) UIView *bottomView;
@property (nonatomic, retain) UIView *backgroundView; //???: may change this - BigAB

#pragma mark - Callout Modifications
@property (nonatomic, assign) CGPoint offset;

@property (nonatomic, assign) GBCustomCalloutAnimation presentAnimation, dismissAnimation; // default GBCalloutAnimationBounce, GBCalloutAnimationFade respectively

#pragma mark - Class methods
+ (GBCustomCallout *)customCalloutWithDelegate:(id<GBCustomCalloutViewDelegate>)delegate;

#pragma mark - Instance Methods
- (void)presentCalloutForAnnotationView:(MKAnnotationView *)annotationView
                                 inMapView:(MKMapView *)mapView;

- (void)dismiss;

@end

#pragma mark - GBCustomCalloutProtocol
#pragma mark -
@protocol GBCustomCalloutViewDelegate <NSObject>

// Title and subtitle for use by selection UI.
- (NSString *)title;
- (NSString *)subtitle;

@optional

- (UIView *)titleView;
- (UIView *)subtitleView;
- (UIView *)contentView;

- (UIView *)leftAccessoryView;
- (UIView *)rightAccessoryView;

- (UIView *)topView;
- (UIView *)bottomView;

- (UIView *)headerView;
- (UIView *)footerView;

- (UIView *)backgroundView;

- (CGPoint)calloutOffset;

- (BOOL)shouldExpandToAccessoryHeight;
- (BOOL)shouldExpandToAccessoryWidth;
- (BOOL)shouldVerticallyCenterLeftAccessoryToContent;
- (BOOL)shouldVerticallyCenterRightAccessoryToContent;
- (BOOL)shouldConstrainLeftAccessoryToContent;
- (BOOL)shouldConstrainRightAccessoryToContent;

@end

#pragma mark - ***** Helper CLASSES ***** -
#pragma mark - *** GBCustomTitleLabel *** -
@interface GBCustomTitleLabel : UILabel
{}
@end;
#pragma mark - *** GBCustomSubtitleLabel *** -
@interface GBCustomSubtitleLabel : GBCustomTitleLabel
{}
@end;
#pragma mark - *** GBCustomContentView *** -
@interface GBCustomContentView : UIView
{}
@end;
#pragma mark - *** GBCustomBackgroundView *** -
@interface GBCustomBackgroundView : UIView
{}
@property (nonatomic, assign) BOOL active;
@end;

#pragma mark - *** GBCustomCalloutArrow *** -
@interface GBCustomCalloutArrow : UIView
{}
@property (nonatomic, assign) GBCustomCalloutArrowDirection direction;
@property (nonatomic, assign) BOOL active;
@end;