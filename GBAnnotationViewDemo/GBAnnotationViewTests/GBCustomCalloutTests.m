//
//  GBCustomCalloutTests.m
//  GBAnnotationViewDemo
//
//  Created by Adam Barrett on 2013-10-09.
//  Copyright (c) 2013 GB Internet Solutions. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GBCustomCallout.h"

@interface GBCustomCalloutTests : XCTestCase
@property (nonatomic, strong) GBCustomCallout *callout;
@end

@interface GBCustomCallout(Specs)
- (CGFloat)offsetXToPositionRect:(CGRect)rect
                       overPoint:(CGPoint)point
                      withMargin:(CGFloat)margin;
@end

@implementation GBCustomCalloutTests

- (void)setUp
{
    [super setUp];
    self.callout = [GBCustomCallout new];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);

- (void)testOffsetXToPositionRectReturnsAValueIncludingLeftMargin
{
    CGFloat expected = -25.0;
    CGPoint anchorPoint = CGPointMake(100, 100);
    CGRect floatingRect = CGRectMake(anchorPoint.x, anchorPoint.y, 200, 200);
    
    CGFloat offsetX = [self.callout offsetXToPositionRect:floatingRect
                                                overPoint:anchorPoint
                                               withMargin:25.0];
    
    XCTAssertTrue((offsetX == expected), @"It has to move %f pts to the left to be within the margin", expected);
}

- (void)testOffsetXToPositionRectReturnsAValueIncludingLeftMarginAndExtraRoom
{
    CGFloat expected = -50.0;
    CGPoint anchorPoint = CGPointMake(100, 100);
    CGRect floatingRect = CGRectMake(anchorPoint.x + 25.0, anchorPoint.y, 200, 200);
    
    CGFloat offsetX = [self.callout offsetXToPositionRect:floatingRect
                                                overPoint:anchorPoint
                                               withMargin:25.0];
    
    XCTAssertTrue((offsetX == expected), @"It has to move %f pts to the left to be within the margin", expected);
}

- (void)testOffsetXToPositionRectReturnsAValueIncludingRightMargin
{
    CGFloat expected = 25.0;
    CGPoint anchorPoint = CGPointMake(100, 100);
    CGRect floatingRect = CGRectMake(-100, anchorPoint.y, 200, 200);
    
    CGFloat offsetX = [self.callout offsetXToPositionRect:floatingRect
                                                overPoint:anchorPoint
                                               withMargin:25.0];
    
    XCTAssertTrue((offsetX == expected), @"It has to move %0.00f pts to the left to be within the margin", expected);
}

- (void)testOffsetXToPositionRectReturnsAValueIncludingRightMarginAndExtraRoom
{
    CGFloat expected = 50.0;
    CGPoint anchorPoint = CGPointMake(100, 100);
    CGRect floatingRect = CGRectMake(-125, anchorPoint.y, 200, 200);
    
    CGFloat offsetX = [self.callout offsetXToPositionRect:floatingRect
                                                overPoint:anchorPoint
                                               withMargin:25.0];
    
    XCTAssertTrue((offsetX == expected), @"It has to move %0.00f pts to the left to be within the margin", expected);
}

@end
