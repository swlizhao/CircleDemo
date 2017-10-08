//
//  ViewController.m
//  CircleDemo
//
//  Created by apple on 2017/2/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LZCircularSlider.h"

@interface ViewController () {

    CGRect frame;
}
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UILabel *topLabel;
@property(nonatomic,strong)UILabel *topMoneyLabel;
@property(nonatomic,strong)UILabel *downLabel;
@property(nonatomic,strong)UILabel *downMoneyLabel;
@property(nonatomic,strong)UILabel *centerLabel;
@property(nonatomic,strong)UILabel *centerMoneyLabel;
@property(nonatomic,strong)LZCircularSlider *slider;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  /** 在圆弧开始跟结束的值随着滑动有误差，请到封装的代码里面做判断，进行调整 */
   frame = CGRectMake(self.view.frame.size.width/2-100,self.view.frame.size.height/2-100, 200, 200);
   [self initBgView];
   [self initSlider];
    self.view.backgroundColor = [UIColor colorWithRed:242./255. green:242./255. blue:242./255. alpha:1.];
}

- (void)initBgView {
    _bgView =[[UIView alloc]init];
    _bgView.frame = frame;
    _bgView.backgroundColor =[UIColor whiteColor];
    [self.view addSubview:_bgView];
    _bgImageView = [[UIImageView alloc]init];
    _bgImageView.frame =CGRectMake(35, self.bgView.frame.size.height/2-25, self.bgView.frame.size.width-70, 50);
    _bgImageView.backgroundColor =[UIColor clearColor];
    _bgImageView.image = [UIImage imageNamed:@"椭圆阴影"];
    [self.bgView addSubview:_bgImageView];
    _centerLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.bgImageView.frame.size.width-20, 15)];
    _centerLabel.textAlignment =1;
    _centerLabel.backgroundColor =[UIColor clearColor];
    _centerLabel.textColor =[UIColor grayColor];
    _centerLabel.font =[UIFont systemFontOfSize:12];
    _centerLabel.text =@"每月最低归还金额";
    [self.bgImageView addSubview:self.centerLabel];
    _centerMoneyLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.centerLabel.frame), CGRectGetMaxY(self.centerLabel.frame), CGRectGetWidth(self.centerLabel.frame),CGRectGetHeight(self.centerLabel.frame))];
    _centerMoneyLabel.backgroundColor =[UIColor clearColor];
    _centerMoneyLabel.textAlignment =1;
    _centerMoneyLabel.font =[UIFont systemFontOfSize:12];
    _centerMoneyLabel.textColor =[UIColor blueColor];
    _centerMoneyLabel.text =@"¥0.29";
    [self.bgImageView addSubview:_centerMoneyLabel];
    _topMoneyLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.bgImageView.frame)+10, self.bgImageView.frame.origin.y-20,CGRectGetWidth(self.bgImageView.frame)-20, 20)];
    _topMoneyLabel.backgroundColor =[UIColor clearColor];
    _topMoneyLabel.textColor =[UIColor redColor];
    _topMoneyLabel.text =@"¥1.00";
    _topMoneyLabel.textAlignment =1;
    _topMoneyLabel.font =[UIFont systemFontOfSize:12];
    [self.bgView addSubview:_topMoneyLabel];
    _topLabel = [[UILabel alloc]init];
    _topLabel.frame =CGRectMake(CGRectGetMinX(self.topMoneyLabel.frame)+5, self.topMoneyLabel.frame.origin.y-20,CGRectGetWidth(self.topMoneyLabel.frame)-10, 20);
    _topLabel.textAlignment =1;
    _topLabel.font =[UIFont systemFontOfSize:12];
    _topLabel.textColor =[UIColor blackColor];
    _topLabel.text =@"消费金金额";
    _topLabel.backgroundColor = [UIColor clearColor];
    [self.bgView addSubview:_topLabel];
   
    _downLabel = [[UILabel alloc]init];
    _downLabel.frame =CGRectMake(CGRectGetMinX(self.bgImageView.frame)+10,CGRectGetMaxY(self.bgImageView.frame), self.bgImageView.frame.size.width-20, 20);
    _downLabel.backgroundColor = [UIColor clearColor];
    _downLabel.textAlignment =1;
    _downLabel.font =[UIFont systemFontOfSize:12];
    _downLabel.textColor =[UIColor blackColor];
    _downLabel.text =@"消费金期限";
    [self.bgView addSubview:_downLabel];
    _downMoneyLabel =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.downLabel.frame)+5, CGRectGetMaxY(self.downLabel.frame), self.downLabel.frame.size.width-10, 20)];
    _downMoneyLabel.backgroundColor =[UIColor clearColor];
    _downMoneyLabel.font =[UIFont systemFontOfSize:12];
    _downMoneyLabel.textAlignment =1;
    _downMoneyLabel.textColor =[UIColor greenColor];
    _downMoneyLabel.text =@"1个月";
    [self.bgView addSubview:_downMoneyLabel];

}
-(void)initSlider{
    _slider = [[LZCircularSlider alloc]initWithFrame:frame];
    /*
       following number must setting,or have issue
     */
    _slider.lineWidth =8;
    _slider.upMaximumValue =100;
    _slider.upMinimumValue =1;
    _slider.upCurrentValue =1.0;
    _slider.downCurrentValue =1.0;
    _slider.downMaximumValue =100;
    _slider.downMinimumValue =1;
    _slider.upBgStrokeColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1];
    _slider.downBgStrokeColor = [UIColor colorWithRed:192/255.0 green:192/255.0 blue:192/255.0 alpha:1];
    _slider.upfilledColor =[UIColor colorWithRed:255/255.0 green:127/255.0 blue:80/255.0 alpha:1];
    _slider.downFilledColor =[UIColor colorWithRed:65/255.0 green:105/255.0 blue:225/255.0 alpha:1];
    _slider.backgroundColor =[UIColor clearColor];
    [_slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_slider];

}

- (void)valueChanged:(LZCircularSlider*)slider {
    NSString * topString;
    NSString * downString;
    NSString * centerString;
    topString = [NSString stringWithFormat:@"%d",slider.upCurrentValue];
    downString = [NSString stringWithFormat:@"%d",slider.downCurrentValue];
    centerString = [NSString stringWithFormat:@"%f",(slider.upCurrentValue+(slider.upCurrentValue)*0.05)/slider.downCurrentValue];
    _topMoneyLabel.text = [NSString stringWithFormat:@"¥%@",topString];
    _downMoneyLabel.text =[NSString stringWithFormat:@"%@个月",downString];
    _centerMoneyLabel.text =[NSString stringWithFormat:@"¥%@",centerString];
    NSLog(@"upCurrentValue==%d=====",slider.upCurrentValue);
    NSLog(@"downCurrentValue====%d",slider.downCurrentValue);
    NSLog(@"centerString====%@",centerString);
  
}



@end
