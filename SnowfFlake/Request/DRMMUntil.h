//
//  DRMMUntil.h
//  DeepCubeRobotControls
//
//  Created by zoff on 2017/6/6.
//  Copyright © 2017年 zoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRTool.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
static void dryy_dispatch_after_time(int64_t second,dispatch_block_t block) {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

@interface DRMMUntil : NSObject
+ (id)EmptyCheckobjnil:(id)obj;
+ (void)showMessage:(NSString *)msg Type:(int)type;
+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font;
+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color;
+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font withtext:(NSString*)str;
+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color withtext:(NSString*)str;
+ (UIImageView*)createImageViewWithFrame:(CGRect)frame image:(NSString*)str;
+ (UITextView*)createTextViewWithFrame:(CGRect)frame;
+ (UITextView*)createTextViewWithFrame:(CGRect)frame withFont:(UIFont*)font;
+ (UIButton*)createButtonWithFrame:(CGRect)frame whitbackimg:(NSString*)str withbackimgh:(NSString*)strh wihtTitle:(NSString*)title;
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame withFont:(UIFont*)font;
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame;
+ (UITextField*)createTextFieldWithFrame:(CGRect)frame withTag:(NSInteger)tag;

//+(UITextField *)CreateTxtFieldEx:(CGRect)rect withTag:(NSInteger)tag;
+ (UIButton*)createImgButtonWithFrame:(CGRect)frame whitbackimg:(NSString*)str withbackimgh:(NSString*)strh wihtTitle:(NSString*)title;
+ (UILabel*)theAdaptiveLable:(NSString*)counts spacingCounts:(NSInteger)m spacingCounts:(NSInteger)lineHeight colorWords:(UIColor*)color;
+ (CGFloat)contentCellHeightWithText:(NSString*)text lableFont:(UIFont*)labFont
                             labWide:(NSInteger)wide;
+ (UIButton*)createbuttonWithFrame:(CGRect)frameBtn buttonColorbg:(UIColor*)colorbg buttonColorTouch:(UIColor*)colorTouch;
+ (UIButton*)createbuttonWithFrame:(CGRect)butFrame
                        btnColorbg:(UIColor*)colorbg
                     btnColorTouch:(UIColor*)colorTouch
                          btnRound:(NSInteger)m;
+ (UIButton*)createbuttonWithFrame:(CGRect)frameBtn buttonColorbg:(UIColor*)colorbg buttonColorTouch:(UIColor*)colorTouch WihtSlected:(BOOL)Senected;

+ (NSString*)timerCountDown:(NSObject*)matchTimeObj;
+ (UIButton*)createbuttonWithFrame:(CGRect)butFrame
                        btnColorbg:(UIColor*)colorbg
                     btnColorTouch:(UIColor*)colorTouch
                          btnRound:(NSInteger)m withSelect:(BOOL)y;
+ (NSString*)URLEncodedString:(NSString*)str;
+ (NSString*)URLDecodedString:(NSString*)str;
//+ (void)showMessage:(NSString *)msg Type:(int)type;
+(UIImage *)CreateImageByColorbg:(UIColor*)colorbg withSize:(CGSize)size;
+(NSString*)disable_emoji:(NSString*)text;
// 从view 页面进入 UIViewController页面
+ (void)presentModalViewController:(UIViewController*)viewController myView:(UIView*)views;
+ (void)pushNextUIViewController:(UIViewController*)viewController myView:(UIView*)views;
+(UIImage*) createImageWithColor:(UIColor*) color;
+(NSString*)datetostringMMdd:(NSString*)datetime;
+(NSArray*)groupArry:(NSArray*)modelarray condition:(NSString*)conditionstr;
@end
