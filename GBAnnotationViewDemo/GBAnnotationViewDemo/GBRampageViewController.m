//
//  GBRampageViewController.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-10-10.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "GBRampageViewController.h"
#import "GBMapView.h"
#import "GBMonster.h"
#import "GBRampageAnnotationView.h"

@interface GBRampageViewController ()
@property (weak, nonatomic) IBOutlet GBMapView *mapView;
@property (nonatomic, strong) NSArray *mapAnnotations;
@end

@implementation GBRampageViewController

- (NSArray *)mapAnnotations
{
    if (!_mapAnnotations) {
        GBMonster *george = [GBMonster new];
        george.name = @"George";
        george.description = @"George the Ape doesn't monkey around. He uses his climbing abilities to scale buildings quickly, and hes always on the lookout for bananas to increase his health. If you see this monkey, you know what to do - run!";
        george.location = [[CLLocation alloc] initWithLatitude:40.764623 longitude:-73.981605];
        george.type = GBMonsterTypeMonkey;
        
        GBRampageAnnotation *annotation1 = [GBRampageAnnotation annotationWithMonster:george];
        
        GBMonster *lizzie = [GBMonster new];
        lizzie.name = @"Lizzie";
        lizzie.description = @"They say not to swim for 3 minutes, but do you want to tell Lizzie the Dinosaur that? Nothing slows her down as she uses her speed to quickly scale building after building. After she visits your town, you'll wish she was extinct!";
        lizzie.location = [[CLLocation alloc] initWithLatitude:40.693623 longitude:-73.972605];
        lizzie.type = GBMonsterTypeLizard;
        
        GBRampageAnnotation *annotation2 = [GBRampageAnnotation annotationWithMonster:lizzie];
        
        GBMonster *ralph = [GBMonster new];
        ralph.name = @"Ralph";
        ralph.description = @"My what sharp teeth Ralph has! The well-balanced wolf likes to howl through the city, tossing taxicabs (or whatever else gets in his way), into buildings or into the distance. we've heard hungry like the wolf, but this is ridiculous!";
        ralph.location = [[CLLocation alloc] initWithLatitude:40.744623 longitude:-74.028605];
        ralph.type = GBMonsterTypeWolf;
        
        GBRampageAnnotation *annotation3 = [GBRampageAnnotation annotationWithMonster:ralph];
        
        _mapAnnotations = [[NSArray alloc] initWithObjects: annotation1, annotation2, annotation3, nil];
    }
    return _mapAnnotations;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.annotationViewClass = [GBRampageAnnotationView class];
	[self.mapView addAnnotations:self.mapAnnotations];
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = 40.730623;
    newRegion.center.longitude = -74.000605;
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    
    [self.mapView setRegion:newRegion animated:YES];
}

@end
