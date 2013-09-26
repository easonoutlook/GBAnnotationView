//
//  DemoAnnotationView.h
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-09-26.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "GBAnnotationView.h"

@interface DemoAnnotationView : GBAnnotationView <GBCustomCalloutViewDelegate>

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
