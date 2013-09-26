//
//  ViewController.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-09-26.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "GBMapView.h"
#import "GBAnnotation.h"
#import "DemoAnnotationView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet GBMapView *mapView;

@property (nonatomic, strong) NSArray *mapAnnotations;
@property (nonatomic, strong) NSString *nameHolder;

@end

@implementation ViewController
#pragma mark - Property Accesors
- (NSArray *)mapAnnotations
{
    if (!_mapAnnotations) {
        GBAnnotation *annotation1 = [GBAnnotation new];
        annotation1.title = @"San Francisco";
        annotation1.subtitle = @"Founded: June 29, 1776";
        annotation1.coordinate = CLLocationCoordinate2DMake(37.786996, -122.419281);
        annotation1.type = GBAnnotationTypeCity;
        
        GBAnnotation *annotation2 = [GBAnnotation new];
        annotation2.title = @"Golden Gate Bridge";
        annotation2.subtitle = @"Opened: May 27, 1937";
        annotation2.coordinate = CLLocationCoordinate2DMake(37.810000, -122.477450);
        annotation2.type = GBAnnotationTypeBridge;
        
        GBAnnotation *annotation3 = [GBAnnotation new];
        annotation3.title = @"Tea Garden";
        annotation3.subtitle = @"Yeah yeah yeah, aight!";
        annotation3.coordinate = CLLocationCoordinate2DMake(37.7700, -122.4701);
        annotation3.type = GBAnnotationTypeMuseum;

        _mapAnnotations = [[NSArray alloc] initWithObjects: annotation1, annotation2, annotation3, nil];
    }
    return _mapAnnotations;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.annotationViewClass = [DemoAnnotationView class];
    self.mapView.calloutAccessoryControlTapped = ^(GBMapView *mapView, MKAnnotationView *annotationView, UIControl *control){
        [self performSegueWithIdentifier:@"showDetails" sender:annotationView];
    };
    
	[self.mapView addAnnotations:self.mapAnnotations];
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 37.786996;
    newRegion.center.longitude = -122.440100;
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    
    [self.mapView setRegion:newRegion animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[DetailViewController class]]) {
        DetailViewController *detailVC = segue.destinationViewController;
        
        if ([sender isKindOfClass:[MKAnnotationView class]]) {
            id <MKAnnotation> annotation = ((MKAnnotationView *)sender).annotation;
            detailVC.imageName = annotation.title;
        }
        
    }
    
}

@end
