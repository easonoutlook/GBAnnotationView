//
//  DemoAnnotationView.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-09-26.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "DemoAnnotationView.h"
#import "GBAnnotation.h"
#import "GBRelatedInformationView.h"

static UIWebView *_bomAd;

@interface DemoAnnotationView ()
@property (nonatomic, readonly) UIImage *standardPinImage;
@end

@implementation DemoAnnotationView
@dynamic standardPinImage;

@synthesize leftCalloutAccessoryView = _leftCalloutAccessoryView;

#pragma mark - Annotation on Map
- (UIImage *)imageForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[GBAnnotation class]]) {
        GBAnnotation *anno = annotation;
        
        if (anno.type == GBAnnotationTypeBridge) {
            return [self iconImageNamed:@"Bridge"];
        }
        
        if (anno.type == GBAnnotationTypeCity) {
            return [self iconImageNamed:@"City"];
        }
        
        if (anno.type == GBAnnotationTypeMuseum) {
            return [self iconImageNamed:@"Museum"];
        }
    }
    
    return [self standardPinImage];
}


- (UIImage *)iconImageNamed:(NSString *)name
{
    return [self imageWithImage:[UIImage imageNamed:name] scaledToSize:CGSizeMake(80.0, 80.0)];
}


#pragma mark - Annotation Callout Bubble
#pragma mark leftCalloutAccessory
//- (UIView *)leftCalloutAccessoryView
//{
//    if (!_leftCalloutAccessoryView) {
//        GBAnnotation *annotation = self.annotation;
//        UIImage *image = [self imageWithImage:[UIImage imageNamed:annotation.title] scaledToSize:CGSizeMake(40.0, 60.0)];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        imageView.clipsToBounds = YES;
//        imageView.frame = CGRectMake(0, 0, 40, 40);
//        _leftCalloutAccessoryView = imageView;
//    }
//    return _leftCalloutAccessoryView;
//}


#pragma mark bottomView
//- (UIView *)bottomView
//{
//    if (!_bottomView) {
//        GBRelatedInformationView *bottomView = [[GBRelatedInformationView alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
//        bottomView.subject = self.annotation.title;
//        bottomView.clipsToBounds = YES;
//        bottomView.backgroundColor = [UIColor yellowColor];
//        _bottomView = bottomView;
//    }
//    return _bottomView;
//}
//
//- (void)bottomViewTapped:(UIGestureRecognizer *)gestureRecognizer
//{
//    NSLog(@"TAPPP!!!!");
//}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 180, 100)];
        _contentView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    }
    return _contentView;
}

//- (UIView *)rightAccessoryView
//{
//    if (!_rightAccessoryView) {
//        _rightAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 10)];
//        _rightAccessoryView.backgroundColor = [UIColor orangeColor];
//    }
//    return _rightAccessoryView;
//}

- (UIView *)leftCalloutAccessoryView
{
    if (!_leftCalloutAccessoryView) {
        _leftCalloutAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 10)];
        _leftCalloutAccessoryView.backgroundColor = [UIColor orangeColor];
    }
    return _leftCalloutAccessoryView;
}

//- (UIView *)topView
//{
//    if (!_topView) {
//        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 10)];
//        _topView.backgroundColor = [UIColor redColor];
//    }
//    return _topView;
//}


- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 10)];
        _bottomView.backgroundColor = [UIColor blueColor];
    }
    return _bottomView;
}


//- (UIView *)headerView
//{
//    if (!_headerView) {
//        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 190, 10)];
//        _headerView.backgroundColor = [UIColor colorWithRed:0.0 green:0.7 blue:0.0 alpha:1.0];
//    }
//    return _headerView;
//}
//
//
//- (UIView *)footerView
//{
//    if (!_footerView) {
//        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 190, 10)];
//        _footerView.backgroundColor = [UIColor yellowColor];
//    }
//    return _footerView;
//}


#pragma mark Callout Modifications
- (CGPoint)calloutOffset
{
    return CGPointMake(-8, 0);
}


- (BOOL)shouldConstrainLeftAccessoryToContent
{
    return self.bottomView ? YES : NO;
}

#pragma mark - Utility
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
