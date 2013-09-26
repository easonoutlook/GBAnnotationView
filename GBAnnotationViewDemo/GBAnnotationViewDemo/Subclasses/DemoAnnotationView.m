//
//  DemoAnnotationView.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-09-26.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "DemoAnnotationView.h"
#import "GBAnnotation.h"

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
- (UIView *)leftCalloutAccessoryView
{
    GBAnnotation *annotation = self.annotation;
    UIImage *image = [self imageWithImage:[UIImage imageNamed:annotation.title] scaledToSize:CGSizeMake(40.0, 60.0)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.clipsToBounds = YES;
    imageView.frame = CGRectMake(0, 0, 40, 40);
    return imageView;
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
