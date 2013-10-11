//
//  GBMonsterStatsView.h
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-10-10.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBMonster.h"

@interface GBMonsterStatsView : UIView

@property (nonatomic, strong) GBMonster *monster;

+ (GBMonsterStatsView *)monsterStatViewWithMonster:(GBMonster *)monster;

@end
