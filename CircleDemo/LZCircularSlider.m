//
//  TestView.m
//  CircleDemo
//
//  Created by apple on 2017/2/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "LZCircularSlider.h"
#define  ToRad(ang)  ((M_PI *(ang)) / 180)//度数转化为弧度
#define  ToAng(rad)  ( (180.0 * (rad)) / M_PI )//弧度转化为度数
#define SQR(x)			( (x) * (x) )g

@interface LZCircularSlider () {
    int  angle;
    int  downAngle;
    NSInteger radius;
    NSInteger upStatus; //滑块滑动状态(0 未滑动，1滑动)
    NSInteger downStatus;
}

@end

@implementation LZCircularSlider

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        angle = 180;
        downAngle = 150;
        radius = self.frame.size.width/2 - 20;
        [self insertSubview:self.contentView atIndex:0];
     }

    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawCircle];
}

- (void)drawCircle {
    [self drawUpCircleAtX:self.frame.size.width/2 Y:self.frame.size.height/2];
    [self drawDownCircleAtX:self.frame.size.width/2 Y:self.frame.size.height/2];
}

//画上半部分圆弧
- (void)drawUpCircleAtX:(float)x Y:(float)y {
    //先画圆弧下面压着的背景圆弧
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, x, y, radius,ToRad(180), ToRad(360), 0);
    CGContextSetStrokeColorWithColor(ctx, _upBgStrokeColor.CGColor);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextDrawPath(ctx, kCGPathStroke);
   
    //画随着滑块滑动圆弧
    CGContextAddArc(ctx, x, y, radius,ToRad(180), ToRad(angle), 0);
    CGContextSetStrokeColorWithColor(ctx, _upfilledColor.CGColor);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextStrokePath(ctx);
    [self drawUpHandle:ctx];
}

//绘制滑块
- (void)drawUpHandle:(CGContextRef)ctx {
    CGContextSaveGState(ctx);
    CGPoint handleCenter =  [self pointFromAngle:angle];
    [[UIColor clearColor]set];
    CGContextFillEllipseInRect(ctx, CGRectMake(handleCenter.x-_lineWidth/2, handleCenter.y-_lineWidth/2,10,10));//填充指定的矩形
    UIImage *image = [UIImage imageNamed:@"橙色.png"];
    [image drawAtPoint:CGPointMake((handleCenter.x-_lineWidth/2-5),handleCenter.y-_lineWidth/2-5)];
    CGContextRestoreGState(ctx);
}

//画下半部分圆弧
- (void)drawDownCircleAtX:(float)x Y:(float)y {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctx, x, y, radius,ToRad(150), ToRad(30), 1);
    CGContextSetStrokeColorWithColor(ctx, _downBgStrokeColor.CGColor);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    CGContextAddArc(ctx, x, y, radius,ToRad(150), ToRad(downAngle), 1);
    CGContextSetStrokeColorWithColor(ctx, _downFilledColor.CGColor);
    CGContextSetLineWidth(ctx, _lineWidth);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextDrawPath(ctx, kCGPathStroke);
    [self drawDownHandle:ctx];
}

- (void)drawDownHandle:(CGContextRef)ctx {
    CGContextSaveGState(ctx);
    CGPoint handleCenter =  [self pointFromAngle:downAngle];
    [[UIColor clearColor]set];
    CGContextFillEllipseInRect(ctx, CGRectMake(handleCenter.x-_lineWidth/2, handleCenter.y-_lineWidth/2,10,10));
    UIImage *image = [UIImage imageNamed:@"蓝色.png"];
    [image drawAtPoint:CGPointMake((handleCenter.x-_lineWidth/2-5),handleCenter.y-_lineWidth/2-5)];
    CGContextRestoreGState(ctx);
}

- (CGPoint)pointFromAngle:(int)angleInt {
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    //Define The point position on the circumference
    CGPoint result;
    CGFloat y = centerPoint.y + (radius)*sin(ToRad(angleInt));
    CGFloat x = centerPoint.x + (radius)*cos(ToRad(angleInt));
    result =CGPointMake(x, y);
    return result;
}

#pragma mark---UIControl Method
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    return  YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    CGPoint lastPoint =[touch locationInView:self];
//    NSLog(@"point ==%@",NSStringFromCGPoint(lastPoint));
    if (upStatus == 0) {
        [self moveDownHandle:lastPoint];
    }
    
    if (downStatus ==0) {
       [self moveUpHandle:lastPoint];
    }
     [self sendActionsForControlEvents:UIControlEventValueChanged];
//   NSLog(@"upStatus==滑动中=%ld==下半圆弧滑动=%ld",(long)upStatus,downStatus);
    return YES;
}

- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
    if (upStatus == 1) {
        upStatus = 0;
    }
    if (downStatus ==1) {
        downStatus =0;
    }
//    NSLog(@"upStatus==滑动中=%ld==下半圆弧滑动=%ld",(long)upStatus,downStatus);
}

- (void)moveUpHandle:(CGPoint)point {
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
     int currentAngle = floor(AngleFromNorth(centerPoint, point, NO));
//    NSLog(@"currentAngle===%d",currentAngle);
    if (currentAngle < 180 || currentAngle > 360) {
        return;
    }
    upStatus = 1;
    angle = currentAngle;
    _upCurrentValue = [self valueFromAngle];
    if (_upCurrentValue == 0) {
        _upCurrentValue = 1;
    }
    [self setNeedsDisplay];
//    NSLog(@"up---angle==%d====currentValue =%ld==",angle,(long)_currentValue);

  
}

- (void)moveDownHandle:(CGPoint)point {
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    int currentAngle = floor(AngleFromNorth(centerPoint, point, NO));
//    NSLog(@"下面圆弧====currentAngle===%d",currentAngle);
    if (currentAngle > 150 || currentAngle < 30) {
        return;
    }
    downStatus = 1;
    downAngle = currentAngle;
    _downCurrentValue = [self downValueFromAngle];
    if (_downCurrentValue == 0) {
        _downCurrentValue = 1;
    }
    [self setNeedsDisplay];
//  NSLog(@"downAngle=========%d===%d",downAngle,_downCurrentValue);
  
}

static inline float AngleFromNorth(CGPoint p1, CGPoint p2, BOOL flipped) {
    CGPoint v = CGPointMake(p2.x-p1.x,p2.y-p1.y);
    //    float vmag = sqrt(SQR(v.x) + SQR(v.y)), result = 0;
    //    v.x /= vmag;
    //    v.y /= vmag;
    float result = 0 ;
    double radians = atan2(v.y,v.x);
    result = ToAng(radians);
    return (result >=0  ? result : result + 360.0);
}

- (CGFloat)valueFromAngle {
    return (angle-180) * (_upMaximumValue-_upMinimumValue)/180;
}

//此处处理相关计算
- (CGFloat)downValueFromAngle {
    return (180 - downAngle - 30) * (_downMaximumValue  - _downMinimumValue) / (150 - 30);
}

@end
