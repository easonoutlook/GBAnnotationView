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
- (UIView *)leftCalloutAccessoryView
{
    GBAnnotation *annotation = self.annotation;
    UIImage *image = [self imageWithImage:[UIImage imageNamed:annotation.title] scaledToSize:CGSizeMake(40.0, 60.0)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.clipsToBounds = YES;
    imageView.frame = CGRectMake(0, 0, 40, 40);
    return imageView;
}


#pragma mark bottomView
- (UIView *)bottomView
{
    if (!_bottomView) {
//        if (!_bomAd) {
//            UIWebView *bottom = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 180, 15)];
//            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://bigab.net/gb"]];
//            [bottom loadRequest:request];
//            bottom.backgroundColor = [UIColor clearColor];
//            bottom.opaque = NO;
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTapped:)];
//            [bottom addGestureRecognizer:tap];
//            _bomAd = bottom;
//        }
//        _bottomView = _bomAd;
        GBRelatedInformationView *bottomView = [[GBRelatedInformationView alloc] initWithFrame:CGRectMake(0, 0, 180, 115)];
        bottomView.subject = self.annotation.title;
        _bottomView = bottomView;
    }
    return _bottomView;
}

- (void)bottomViewTapped:(UIGestureRecognizer *)gestureRecognizer
{
    NSLog(@"TAPPP!!!!");
}

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
