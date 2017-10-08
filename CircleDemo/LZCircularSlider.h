//
//  TestView.h
//  CircleDemo
//
//  Created by apple on 2017/2/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZCircularSlider : UIControl

/*
 * @param lineWidth : 圆弧宽度
 */
@property(nonatomic,assign)int lineWidth;

/*
 * @param minimumValue 最小值
 */
@property(nonatomic,assign)NSInteger upMinimumValue;

/*
 * @param maximumValue  最大值
 */
@property(nonatomic,assign)NSInteger upMaximumValue;

/*
 * @param currentValue 当前值
 */
@property(nonatomic,assign)int upCurrentValue;

/*
 * @param filledColor 圆弧内部填充颜色
 */
@property (nonatomic, strong) UIColor *upfilledColor;

/*
 * @param unfilledColor 下半圆内部填充颜色
 */
@property (nonatomic, strong) UIColor *downFilledColor;
/*
 * @param downMinimumValue  下半圆最小值
 */
@property(nonatomic)NSInteger downMinimumValue;

/*
 * @param downMaximumValue  下半圆最大值
 */
@property(nonatomic)NSInteger downMaximumValue;

/*
 * @param downCurrentValue  下半圆当前值
 */
@property(nonatomic)int downCurrentValue;

/*
 * @param upBottomColor 上半圆底层颜色
 */
@property(nonatomic,strong)UIColor *upBgStrokeColor;

/*
 *  @param downBottomColor 下半圆底层颜色
 */
@property(nonatomic,strong)UIColor *downBgStrokeColor;

/*
 * @param contentView 可以根据需求自定义
 */
@property(nonatomic,strong)UIView * contentView;

@end
