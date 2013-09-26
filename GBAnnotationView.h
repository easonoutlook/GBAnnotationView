//
//  GBAnnotationView.h
//  MapCallouts
//
//  Created by Adam Barrett on 2013-09-06.
//
//

#import <MapKit/MapKit.h>
#import "GBCustomCallout.h"

@interface GBAnnotationView : MKAnnotationView <GBCustomCalloutViewDelegate>

@property (nonatomic, weak) MKMapView *mapView;
@property (strong, nonatomic) id <MKAnnotation> annotation;
@property (strong, nonatomic) GBCustomCallout *calloutView;

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *subtitle;

@property (nonatomic, strong) UIView *rightCalloutAccessoryView;
@property (nonatomic, strong) UIView *leftCalloutAccessoryView;


@property (nonatomic, strong) UIView *bottomView;

//- (BOOL)shouldExpandToAccessoryHeight;
//- (BOOL)shouldExpandToAccessoryWidth;

//- (BOOL)shouldVerticallyCenterLeftAccessoryToContent;
//- (BOOL)shouldVerticallyCenterRightAccessoryToContent;

- (BOOL)shouldConstrainLeftAccessoryToContent;
//- (BOOL)shouldConstrainRightAccessoryToContent;

- (CGPoint)calloutOffset;

@end
