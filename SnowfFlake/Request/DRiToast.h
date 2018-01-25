//
//  DRiToast.h
//  DeepCubeRobotControls
//
//  Created by zoff on 2017/6/28.
//  Copyright © 2017年 zoff. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    DRkToastPositionTop,
    DRkToastPositionCenter,
    DRkToastPositionBottom,
} DRToastPosition;

typedef enum
{
    DRkToastDurationShort = 2000,
    DRkToastDurationNormal= 4000,
    DRkToastDurationLong  =10000,
} DRToastDuration;

@interface DRiToast : NSObject
{
    DRToastPosition   toastPosition;
    DRToastDuration   toastDuration;
    NSString        *toastText;
    UIView          *view;
}

@property (assign,nonatomic)    DRToastPosition toastPosition;
@property (assign,nonatomic)    DRToastDuration toastDuration;
@property (copy,nonatomic)    NSString      *toastText;


- (id)initWithText: (NSString *)text;
- (void)show;

+ (DRiToast *)makeToast: (NSString *)text;


- (void)hideToast: (id)sender;
- (void)onHideToast: (NSTimer *)timer;
- (void)onRemoveToast: (NSTimer *)timer;
- (void)doHideToast;

@end
