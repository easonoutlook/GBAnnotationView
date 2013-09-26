//
//  GBMapViewTests.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-09-26.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Kiwi.h"

SPEC_BEGIN(GBMapViewSpec)

describe(@"GBMapView", ^{
    
    it(@"should be awesome", ^{
        NSString *awesome = @"awesome";
        [[awesome should] equal:@"awesome"];
    });
    
    
    it(@"should be cool", ^{
        BOOL cool = YES;
        [[theValue(cool) should] beTrue];
    });
    
});

SPEC_END
