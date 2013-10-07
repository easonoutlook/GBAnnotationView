//
//  GBAnnotationView.m
//  MapCallouts
//
//  Created by Adam Barrett on 2013-09-06.
//
//

#import "GBAnnotationView.h"

static UIImage *_standardPinImage;
static UIView *_rightCalloutAccessoryView;

@interface GBAnnotationView ()
{}
- (UIImage *)standardPinImage;
@end

@implementation GBAnnotationView
{}

@synthesize leftCalloutAccessoryView = _leftCalloutAccessoryView;

#pragma mark - Property Accessors
- (GBCustomCallout *)calloutView
{
    if (!_calloutView) {
        _calloutView = [GBCustomCallout new];
        _calloutView.delegate = self;
    }
    
    return _calloutView;
}


- (NSString *)title
{
    return self.annotation.title;
}


- (NSString *)subtitle
{
    return self.annotation.subtitle;
}


- (UIView *)rightCalloutAccessoryView
{
    if (!_rightCalloutAccessoryView) {
        _rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:[self class] action:@selector(rightCalloutAccessoryViewTapped:)];
        [_rightCalloutAccessoryView addGestureRecognizer:tap];
    }
    
    return _rightCalloutAccessoryView;
}


#pragma mark - Class Methods
+ (void)rightCalloutAccessoryViewTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    UIView *rightAccessoryView = gestureRecognizer.view;
    GBCustomCallout *callout = (GBCustomCallout *)rightAccessoryView.superview;
    GBAnnotationView *annotationView = (GBAnnotationView *)callout.annotationView;
    
    [annotationView calloutAccessoryTapped:rightAccessoryView];
}


#pragma mark - LifeCycle
- (void)_init
{
    self.image = [self imageForAnnotation:self.annotation];
    self.canShowCallout = NO;
    self.rightCalloutAccessoryView = _rightCalloutAccessoryView;
}


- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self _init];
    }
    
    return self;
}


// See this for more information: https://github.com/nfarina/calloutview/pull/9
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *calloutMaybe = [self.calloutView hitTest:[self.calloutView convertPoint:point fromView:self] withEvent:event];
    return calloutMaybe ? : [super hitTest:point withEvent:event];
}


#pragma mark - Actions and Gestures
- (void)calloutAccessoryTapped:(UIView *)calloutAccessory
{
    if ([calloutAccessory isKindOfClass:[UIControl class]]) {
        [self.mapView.delegate mapView:self.mapView annotationView:self calloutAccessoryControlTapped:(UIControl *)calloutAccessory];
    }
}


#pragma mark - Configuration
- (UIImage *)imageForAnnotation:(id<MKAnnotation>)annotation
{
    return self.standardPinImage;
}


- (UIImage *)standardPinImage
{
    if (!_standardPinImage) {
        _standardPinImage = [[MKPinAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:@"default-pin-annotationView"].image;
    }
    
    return _standardPinImage;
}


#pragma mark - Selected State
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [self.calloutView presentCalloutForAnnotationView:self inMapView:self.mapView];
    } else {
        [self.calloutView dismiss];
    }
}


#pragma mark - Callback Delegate
- (UIView *)leftAccessoryView
{
    return self.leftCalloutAccessoryView;
}


- (UIView *)rightAccessoryView
{
    return self.rightCalloutAccessoryView;
}

- (void)moveMapByOffset:(CGPoint)offset then:(void(^)(void))callback
{
    MKMapView *mapView = self.mapView;
    CGFloat pixelsPerDegreeLat = mapView.frame.size.height / mapView.region.span.latitudeDelta;
    CGFloat pixelsPerDegreeLon = mapView.frame.size.width / mapView.region.span.longitudeDelta;
    
    CLLocationDegrees latitudinalShift = offset.y / pixelsPerDegreeLat;
    CLLocationDegrees longitudinalShift = -(offset.x / pixelsPerDegreeLon);
    
    CGFloat lat = mapView.region.center.latitude + latitudinalShift;
    CGFloat lon = mapView.region.center.longitude + longitudinalShift;
    CLLocationCoordinate2D newCenterCoordinate = (CLLocationCoordinate2D){lat, lon};
    if (fabsf(newCenterCoordinate.latitude) <= 90 && fabsf(newCenterCoordinate.longitude <= 180)) {
        [mapView setCenterCoordinate:newCenterCoordinate animated:YES];
    }
    
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), callback);
    
}

@end
