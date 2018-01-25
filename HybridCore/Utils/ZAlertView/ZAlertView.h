//
//  ZAlertView.h
//  顶部提示
//
//  Created by YYKit on 2017/5/27.
//  Copyright © 2017年 YZ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS (NSInteger ,AlertViewType){
    AlertViewTypeSuccess = 0,
    AlertViewTypeError   = 1
};

@interface ZAlertView : UIView

@property (nonatomic,assign) AlertViewType alertViewType;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,strong) UILabel     *tipsLabel;
- (instancetype)init;
- (void)topAlertViewTypewWithType:(AlertViewType)type;
- (void)show;
- (void)dismiss;
@end
