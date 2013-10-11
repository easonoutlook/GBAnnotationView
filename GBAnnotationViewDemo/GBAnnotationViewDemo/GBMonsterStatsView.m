//
//  GBMonsterStatsView.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-10-10.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "GBMonsterStatsView.h"

@interface GBMonsterStatsView()

@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *description;
@property (nonatomic, strong) UIImageView *humanAvatar;

@end

@implementation GBMonsterStatsView
#pragma mark - Property Accessors
- (void)setMonster:(GBMonster *)monster
{
    if (_monster != monster) {
        _monster = monster;
        [self updateStats];
    }
}

- (UILabel *)name
{
    if (!_name) {
        _name = [UILabel new];
        _name.backgroundColor = [UIColor clearColor];
        _name.text = self.monster.name;
        [_name sizeToFit];
    }
    return _name;
}

- (UILabel *)description
{
    if (!_description) {
        _description = [UILabel new];
        _description.font = [UIFont fontWithName:@"Courier" size:9];
        _description.backgroundColor = [UIColor clearColor];
        _description.numberOfLines = 0;
        _description.text = self.monster.description;
    }
    return _description;
}

- (UIImageView *)humanAvatar
{
    if (!_humanAvatar) {
        NSString *humanImageName = [self.monster.name stringByAppendingString:@"-Human"];
        _humanAvatar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:humanImageName]];
    }
    return _humanAvatar;
}

#pragma mark - Class Methods
+ (GBMonsterStatsView *)monsterStatViewWithMonster:(GBMonster *)monster
{
    GBMonsterStatsView *statView = [GBMonsterStatsView new];
    statView.monster = monster;
    return statView;
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


- (void)layoutSubviews
{
    CGRect nf = self.name.frame;
    CGRect af = self.humanAvatar.frame;
    
    self.name.frame = CGRectMake(0, 0, nf.size.width, nf.size.height);
    self.humanAvatar.frame = CGRectMake(CGRectGetMaxX(nf)+10, nf.origin.x, af.size.width, af.size.height);
    
    CGRect topRect = CGRectUnion(self.name.frame, self.humanAvatar.frame);
    
    CGSize maxSize = CGSizeMake(MAX(120.0f, topRect.size.width), CGFLOAT_MAX);
    CGSize requiredSize = [self.description sizeThatFits:maxSize];
    self.description.frame = CGRectMake(CGRectGetMinX(topRect), CGRectGetMaxY(topRect)+10, requiredSize.width, requiredSize.height);
    
    CGRect fullRect = CGRectUnion(topRect, self.description.frame);
    
    CGFloat ax = CGRectGetMaxX(fullRect) - af.size.width;
    CGFloat ay = CGRectGetMinY(fullRect);
    self.humanAvatar.frame = CGRectMake(ax, ay, af.size.width, af.size.height);
    
    self.frame = fullRect;
}


#pragma mark - Instance Methods
- (void)updateStats
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.name = nil;
    self.description = nil;
    self.humanAvatar = nil;
    [self addSubview:self.name];
    [self addSubview:self.description];
    [self addSubview:self.humanAvatar];
}

@end
