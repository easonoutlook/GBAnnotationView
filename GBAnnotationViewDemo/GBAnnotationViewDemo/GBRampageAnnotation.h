//
//  GBRampageAnnotation.h
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-10-10.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "GBMonster.h"

@interface GBRampageAnnotation : NSObject <MKAnnotation>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@property (nonatomic, strong) GBMonster *monster;

+ (GBRampageAnnotation *)annotationWithMonster:(GBMonster *)monster;

@end
