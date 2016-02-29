//
//  CircleShapeLayer.m
//  testAnimation
//
//  Created by xp_mac on 16/2/26.
//  Copyright © 2016年 xp_mac. All rights reserved.
//

#import "CustomShapeLayer.h"
#import <UIKit/UIKit.h>

@implementation CustomShapeLayer

- (instancetype) initTheFrame:(CGRect)frame withIndex:(NSInteger)index
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(99.5, 99.5, 1, 1);
        self.path = [self rectanglePath].CGPath;
        self.fillColor = [UIColor colorWithRed:0.875 green: 0.227 blue:0.118 alpha:1].CGColor;
        self.lineWidth = 0;
    }
    return self;
}

- (UIBezierPath *) rectanglePath
{
    UIBezierPath *rectangle1Path = [UIBezierPath bezierPath];
    [rectangle1Path moveToPoint:CGPointMake(0.189, 0.995)];
    [rectangle1Path addCurveToPoint:CGPointMake(0.459, 0.993) controlPoint1:CGPointMake(0.26, 0.996) controlPoint2:CGPointMake(0.388, 0.992)];
    [rectangle1Path addCurveToPoint:CGPointMake(0.758, 1) controlPoint1:CGPointMake(0.53, 0.994) controlPoint2:CGPointMake(0.687, 0.999)];
    [rectangle1Path addLineToPoint:CGPointMake(1, 0.059)];
    [rectangle1Path addCurveToPoint:CGPointMake(0.502, 0) controlPoint1:CGPointMake(0.877, 0.022) controlPoint2:CGPointMake(0.635, 0.002)];
    [rectangle1Path addCurveToPoint:CGPointMake(0, 0.046) controlPoint1:CGPointMake(0.381, -0.002) controlPoint2:CGPointMake(0.128, 0.028)];
    [rectangle1Path closePath];
    [rectangle1Path moveToPoint:CGPointMake(0.189, 0.995)];
    return rectangle1Path;
}

@end
