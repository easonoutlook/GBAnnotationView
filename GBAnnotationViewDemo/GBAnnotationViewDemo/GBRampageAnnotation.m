//
//  GBRampageAnnotation.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-10-10.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "GBRampageAnnotation.h"

@implementation GBRampageAnnotation
#pragma mark - Property Accessors
- (NSString *)title
{
    return self.monster.name;
}

- (NSString *)subtitle
{
    return self.monster.description;
}

- (CLLocationCoordinate2D)coordinate
{
    return [self.monster.location coordinate];
}

#pragma mark - Class Methods
+ (GBRampageAnnotation *)annotationWithMonster:(GBMonster *)monster
{
    GBRampageAnnotation *annotation = [GBRampageAnnotation new];
    annotation.monster = monster;
    return annotation;
}

@end
