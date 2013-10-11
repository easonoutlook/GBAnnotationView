//
//  GBRampageAnnotationView.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-10-10.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "GBRampageAnnotationView.h"
#import "GBMonsterStatsView.h"
#import "AttackOptions.h"

@interface GBRampageAnnotationView()
@property (nonatomic, readonly) UIImage *standardPinImage;
@end

@implementation GBRampageAnnotationView
@dynamic standardPinImage;
@synthesize calloutView = _calloutView;
@synthesize leftCalloutAccessoryView = _leftCalloutAccessoryView;

#pragma mark - Proerty Accessors
- (GBCustomCallout *)calloutView
{
    if (!_calloutView) {
        _calloutView = [GBCustomCallout new];
        _calloutView.backgroundColor = [self calloutBackgroundColor];
        _calloutView.activeBackgroundColor = [self calloutBackgroundColor];
        _calloutView.delegate = self;
    }
    
    return _calloutView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        GBRampageAnnotation *rampageAnnotation = self.annotation;
        _contentView = [GBMonsterStatsView monsterStatViewWithMonster:rampageAnnotation.monster];
    }
    return _contentView;
}

- (UIView *)leftCalloutAccessoryView
{
    if (!_leftCalloutAccessoryView) {
        GBRampageAnnotation *annotation = self.annotation;
        UIImage *image = [UIImage imageNamed:annotation.monster.name];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        _leftCalloutAccessoryView = imageView;
    }
    return _leftCalloutAccessoryView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[NSBundle mainBundle] loadNibNamed:@"AttackOptions" owner:self options:nil][0];
    }
    return _bottomView;
}


#pragma mark - LifeCycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - Annotation Map Pin
- (UIImage *)imageForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[GBRampageAnnotation class]]) {
        GBRampageAnnotation *anno = annotation;
        
        if (anno.monster.type == GBMonsterTypeMonkey) {
            [self addMonsterImageNamed:@"Monkey"];
            return nil;
        }
        
        if (anno.monster.type == GBMonsterTypeLizard) {
            [self addMonsterImageNamed:@"Lizard"];
            return nil;
        }
        
        if (anno.monster.type == GBMonsterTypeWolf) {
            [self addMonsterImageNamed:@"Wolf" reverseFacing:YES];
            return nil;
        }
        
    }
    
    return self.standardPinImage;
}


- (void)addMonsterImageNamed:(NSString *)name
{
    [self addMonsterImageNamed:name reverseFacing:NO];
}

- (void)addMonsterImageNamed:(NSString *)name reverseFacing:(BOOL)reverseFacing
{
    UIImageView *monsterImageView = [self animatedMonsterWalkingImageWithName:name reverseFacing:reverseFacing];
    self.bounds = monsterImageView.frame;
    [self addSubview:monsterImageView];
}

- (UIImageView *)animatedMonsterWalkingImageWithName:(NSString *)name reverseFacing:(BOOL)reverseFacing
{
    static float offset = 0;
    offset += 0.1;
    NSString *walk = [name stringByAppendingString:@"-Walk-"];
    
    NSMutableArray *monsterWalk = [NSMutableArray new];
    
    [@[@"1", @"2", @"3"] enumerateObjectsUsingBlock:^(NSString *step, NSUInteger idx, BOOL *stop) {
        UIImage *monsterFrame = [UIImage imageNamed:[walk stringByAppendingString:step]];
        if (reverseFacing) {
            monsterFrame = [UIImage imageWithCGImage:monsterFrame.CGImage scale:1.0 orientation: UIImageOrientationUpMirrored];
        }
        [monsterWalk addObject:monsterFrame];
    }];

    UIImage *monsterImage = [UIImage animatedImageWithImages:monsterWalk duration:1.0+offset];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:monsterImage];
    
    [imageView startAnimating];
    return imageView;
}


- (UIColor *)calloutBackgroundColor
{
//    CGFloat red = 239.0/255.0;
//    CGFloat green = 237.0/255.0;
//    CGFloat blue = 250.0/255.0;
//    CGFloat alpha = 1.0;
//    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    UIColor *color = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"rampage-bg"]];
    return color;
}

#pragma mark Callout Delegate Modifications
- (UIView *)rightAccessoryView
{
    return nil;
}

- (CGPoint)calloutOffset
{
    return CGPointMake(0, -3);
}

- (BOOL)shouldConstrainLeftAccessoryToContent
{
    return YES;
}

- (BOOL)shouldExpandToAccessoryHeight
{
    return YES;
}

- (BOOL)shouldExpandToAccessoryWidth
{
    return YES;
}

@end
