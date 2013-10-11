//
//  GBMonster.h
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-10-10.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef enum {
    GBMonsterTypeDefault,
    GBMonsterTypeMonkey,
    GBMonsterTypeLizard,
    GBMonsterTypeWolf,
} GBMonsterType;

@interface GBMonster : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, assign) GBMonsterType type;

@end
