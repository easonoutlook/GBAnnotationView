//
//  GBMapView.h
//  MapCallouts
//
//  Created by Adam Barrett on 2013-09-05.
//
//

#import <MapKit/MapKit.h>
#import "GBAnnotationView.h"

@class GBMapView;

typedef void (^AnnotationViewCallback)(GBMapView *mapView, MKAnnotationView *annotationView);
typedef void (^AnnotationViewControlCallback)(GBMapView *mapView, MKAnnotationView *annotationView, UIControl *control);

@interface GBMapView : MKMapView <MKMapViewDelegate>

@property (nonatomic, strong) MKAnnotationView *selectedAnnotationView;

@property (nonatomic, copy) AnnotationViewCallback didSelectAnnotationsView;
@property (nonatomic, copy) AnnotationViewCallback didDeselectAnnotationsView;
@property (nonatomic, copy) AnnotationViewControlCallback calloutAccessoryControlTapped;

@property (nonatomic, assign) Class annotationViewClass;

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated;

@end