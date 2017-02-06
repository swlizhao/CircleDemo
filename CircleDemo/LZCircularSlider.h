//
//  TestView.h
//  CircleDemo
//
//  Created by apple on 2017/2/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZCircularSlider : UIControl


@property(nonatomic,assign)int lineWidth;
@property(nonatomic,assign)NSInteger minimumValue;
@property(nonatomic,assign)NSInteger maximumValue;
@property(nonatomic,assign)int currentValue;

@property (nonatomic, strong) UIColor *filledColor;
@property (nonatomic, strong) UIColor *unfilledColor;
@property (nonatomic, strong) UIColor *downFilledColor;
@property(nonatomic)NSInteger downMinimumValue;
@property(nonatomic)NSInteger downMaximumValue;
@property(nonatomic)int downCurrentValue;

@property(nonatomic,strong)UIFont *labelFont;

@end
