//
//  GBMonsterStatsView.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-10-10.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import "GBMonsterStatsView.h"

@implementation GBMonsterStatsView
#pragma mark - Property Accessors
- (void)setMonster:(GBMonster *)monster
{
    if (_monster != monster) {
        _monster = monster;
        [self updateStats];
    }
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

#pragma mark - Instance Methods
- (void)updateStats
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSString *humanImageName = [self.monster.name stringByAppendingString:@"-Human"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:humanImageName]];
    self.bounds = imageView.frame;
    [self addSubview:imageView];
}

@end
