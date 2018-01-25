//
//  ZAlertView.m
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import "ZAlertView.h"
#import "UIColor+Hexadecimal.h"
#import "AppDelegate.h"
#define Start_Height -34
#define Height 54
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Left_Offset 45
#define Font_Size 14.0f
#define Image_Center_X 25
#define Image_Center_Y 36
#define Image_Width 20
@implementation ZAlertView

#pragma mark 左侧的icon
- (UIButton *)button
{
    if (_button == nil)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, Image_Width, Image_Width);
        _button.center = CGPointMake(Image_Center_X, Image_Center_Y);
        [_button addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
        

        [self addSubview:_button];
    }
    return _button;
}
-(void)butClick
{
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    myDelegate.isDismiss=YES;
    [self dismiss];
}
#pragma mark 右侧的文字提示
- (UILabel *)tipsLabel
{
    if (_tipsLabel == nil)
    {
        _tipsLabel = [[UILabel alloc]init];
        _tipsLabel.numberOfLines = 0;
        _tipsLabel.frame = CGRectMake(Left_Offset, 17+5, Screen_Width - Left_Offset, 30);
        _tipsLabel.textAlignment = NSTextAlignmentLeft;
        _tipsLabel.font = [UIFont systemFontOfSize:Font_Size];
        _tipsLabel.textColor=[UIColor colorWithHexString:@"#817779"];
        [self addSubview:_tipsLabel];
    }
    return _tipsLabel;
}

#pragma mark 初始化
- (instancetype)init
{
    self = [super init];
    if (self)
    {
//        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    return self;
}

#pragma mark 设置type
- (void)topAlertViewTypewWithType:(AlertViewType)type
{
    self.backgroundColor = [UIColor colorWithHexString:@"#ffdfdf"];
    switch (type)
    {
        case AlertViewTypeSuccess:
        {
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
            self.backgroundColor = [UIColor colorWithHexString:@"#ffdfdf"];
//            self.imageView.image = [UIImage imageNamed:@"success"];
             [self.button setImage:[UIImage imageNamed:@"success"] forState:UIControlStateNormal];
            self.tipsLabel.text = @"Success!";
            self.tipsLabel.textColor = [UIColor darkTextColor];
        }
            break;
        case AlertViewTypeError:
        {
            self.backgroundColor = [UIColor colorWithHexString:@"#ffdfdf"];
            //            self.imageView.image = [UIImage imageNamed:@"error"];
            UIImage *imf=[UIImage imageNamed:@"error"];
            [self.button setImage:imf forState:UIControlStateNormal];
            
            
            self.tipsLabel.text = @"当前网络不稳定，请检查您的网络是否连接正常!";
            self.tipsLabel.textColor =[UIColor colorWithHexString:@"#817779"];
            if (self.center.y==27+SafeMargin) {
                break ;
            }
            self.frame = CGRectMake(0, Start_Height, Screen_Width, Height);
          
        }
            break;
        default:
            break;
    }

}

#pragma mark 显示
- (void)show
{
//    52。
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    if (myDelegate.isDismiss==NO) {
        [UIView animateWithDuration:0.3f
                              delay:0
             usingSpringWithDamping:1.0f
              initialSpringVelocity:10.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
                             self.center = CGPointMake(self.center.x, 27+SafeMargin);
                         }
                         completion:^(BOOL finished) {
                         }];

    }
   
}

#pragma mark 移除
- (void)dismiss
{
   

    if (self.center.y==27+SafeMargin) {
        NSDictionary *dic = [NSDictionary dictionaryWithObject:@"dismiss" forKey:@"param"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"noti" object:nil userInfo:dic];
        [UIView animateWithDuration:1.0f
                              delay:0
             usingSpringWithDamping:0.99f
              initialSpringVelocity:6.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.center = CGPointMake(self.center.x, -27-SafeMargin);
                         }
                         completion:^(BOOL finished) {
                         }];

        
    }
   
}


@end
