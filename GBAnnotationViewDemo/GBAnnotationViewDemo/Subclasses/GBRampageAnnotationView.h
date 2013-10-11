//
//  GBRampageAnnotationView.h
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-10-10.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "GBAnnotationView.h"
#import "GBRampageAnnotation.h"

@interface GBRampageAnnotationView : GBAnnotationView <GBCustomCalloutViewDelegate, UIGestureRecognizerDelegate>

@property (strong, nonatomic) GBCustomCallout *calloutView;
@property (nonatomic, strong) UIView *leftCalloutAccessoryView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *bottomView;

@end
