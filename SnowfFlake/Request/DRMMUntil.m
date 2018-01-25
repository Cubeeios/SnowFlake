//
//  DRMMUntil.m
//  DeepCubeRobotControls
//
//  Created by zoff on 2017/6/6.
//  Copyright © 2017年 zoff. All rights reserved.
//

#import "DRMMUntil.h"
#import "DRiToast.h"
@implementation DRMMUntil


+ (id)EmptyCheckobjnil:(id)obj
{
    if ([obj isEqual:[NSNull null]]) {
        return @"";
    }
    else if (obj==nil)
    {
        return @"";
    }
    else {
        return obj;
    }
}

+ (void)showMessage:(NSString *)msg Type:(int)type
{
    if (msg.length > 0) {
        if (type == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            
        } else if (type == 1)
        {
            DRiToast *toast = [DRiToast makeToast:msg];
            [toast setToastPosition:DRkToastPositionBottom];
            [toast setToastDuration:DRkToastDurationNormal];
            [toast show];
            
        }
        else if (type == 2) {
            
            DRiToast *toast = [DRiToast makeToast:msg];
            [toast setToastPosition:DRkToastPositionCenter];
            [toast setToastDuration:DRkToastDurationShort];
            [toast show];
            
        }
    }
}


+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font
{
    UILabel* lbl = [[UILabel alloc] initWithFrame:frame];
    lbl.font = font;
    lbl.backgroundColor = [UIColor clearColor];
    
    return lbl;
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font withtext:(NSString*)str
{
    UILabel* lbl = [self createLabelWithFrame:frame font:font];
    lbl.text = str;
    
    return lbl;
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color
{
    UILabel* lbl = [self createLabelWithFrame:frame font:font];
    lbl.textColor = color;
    
    return lbl;
}

+ (UILabel*)createLabelWithFrame:(CGRect)frame font:(UIFont*)font textColor:(UIColor*)color withtext:(NSString*)str

{
    UILabel* lbl = [self createLabelWithFrame:frame font:font];
    lbl.textColor = color;
    lbl.text = str;
    
    return lbl;
}

+ (UIImageView*)createImageViewWithFrame:(CGRect)frame image:(NSString*)str
{
    UIImageView* imgv = [[UIImageView alloc] initWithFrame:frame];
    imgv.userInteractionEnabled = YES;
    imgv.image = DRImageNamed(str);
    return imgv;
}

+ (UITextView*)createTextViewWithFrame:(CGRect)frame
{
    UITextView* imgv = [[UITextView alloc] initWithFrame:frame];
    imgv.userInteractionEnabled = YES;
    imgv.layer.borderWidth = 1;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){ 1, 1, 1, 1 });
    imgv.layer.borderColor = colorref;
    
    CGColorRelease(colorref);
    CGColorSpaceRelease(colorSpace);
    return imgv;
}

+ (UITextView*)createTextViewWithFrame:(CGRect)frame withFont:(UIFont*)font
{
    UITextView* tx = [self createTextViewWithFrame:frame];
    tx.font = font;
    return tx;
}

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame
{
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 5)];
    UITextField* imgv = [[UITextField alloc] initWithFrame:frame];
    imgv.userInteractionEnabled = YES;
    //    imgv.layer.borderWidth=1;
    //    imgv.layer.borderColor=RGBACOLOR(216, 216, 216, 1.0).CGColor;
    imgv.leftView = view;
    imgv.leftViewMode = UITextFieldViewModeAlways;
    imgv.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    imgv.backgroundColor = [UIColor whiteColor];
    return imgv;
}

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame withTag:(NSInteger)tag
{
    
    UITextField* tx = [self createTextFieldWithFrame:frame];
    tx.tag = tag;
    return tx;
}

+ (UITextField*)createTextFieldWithFrame:(CGRect)frame withFont:(UIFont*)font
{
    UITextField* tx = [self createTextFieldWithFrame:frame];
    tx.font = font;
    return tx;
}

+ (UIButton*)createButtonWithFrame:(CGRect)frame whitbackimg:(NSString*)str withbackimgh:(NSString*)strh wihtTitle:(NSString*)title
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    UIImage *img =DRImageNamed(str) ;
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    if (strh != nil) {
        [btn setBackgroundImage:DRImageNamed(strh) forState:UIControlStateHighlighted];
    }
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}

+ (UIButton*)createImgButtonWithFrame:(CGRect)frame whitbackimg:(NSString*)str withbackimgh:(NSString*)strh wihtTitle:(NSString*)title
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
    if (strh != nil) {
        [btn setImage:[UIImage imageNamed:strh] forState:UIControlStateHighlighted];
    }
    [btn setTitle:title forState:UIControlStateNormal];
    
    return btn;
}

+ (UILabel*)theAdaptiveLable:(NSString*)str3 spacingCounts:(NSInteger)m spacingCounts:(NSInteger)lenh
{
    UILabel* lable = [[UILabel alloc] init];
    lable.numberOfLines = 0;
    lable.textAlignment = NSTextAlignmentLeft;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:str3];
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:m]; //调整行间距
    //设置字的颜色
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:40.0 / 255.0 green:153.0 / 255.0 blue:1.0 / 255.0 alpha:1.0] range:NSMakeRange(0, lenh)];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    lable.attributedText = str;
    [lable sizeToFit];
    lable.backgroundColor = [UIColor clearColor];
    return lable;
}
/**
 *   对UILable 显示不同颜色和行高的封装
 *
 *  @param counts     uilable的内容
 *  @param m          行高
 *  @param lineHeight 要显示颜色字体的个数
 *  @param color      要显示的颜色
 *
 *  @return 返回UILable
 */
+ (UILabel*)theAdaptiveLable:(NSString*)counts spacingCounts:(NSInteger)m spacingCounts:(NSInteger)lineHeight colorWords:(UIColor*)color
{
    UILabel* lable = [[UILabel alloc] init];
    lable.numberOfLines = 0;
    lable.textAlignment = NSTextAlignmentLeft;
    lable.lineBreakMode = NSLineBreakByWordWrapping;
    NSMutableAttributedString* str = [[NSMutableAttributedString alloc] initWithString:counts];
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:m];
    //设置字的颜色
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, lineHeight)];
    [str addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    lable.attributedText = str;
    [lable sizeToFit];
    lable.backgroundColor = [UIColor clearColor];
    return lable;
}
/**
 * 自适应lable的高度
 *
 *  @param text    传过来的内容
 *  @param labFont 这个font 要和lable的font 是一致的；
 *  @param wide    这个宽度最好和你定义的lable的宽度一致
 *
 *  @return 高度
 */
+ (CGFloat)contentCellHeightWithText:(NSString*)text lableFont:(UIFont*)labFont
                             labWide:(NSInteger)wide
{
    NSInteger ch;
    UIFont* font = labFont; //11 一定要跟label的显示字体大小一致
    //设置字体
    CGSize size = CGSizeMake(wide, MAXFLOAT); //注：这个宽：300 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0) //IOS 7.0 以上
    {
        NSDictionary* tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
        size = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    }
    else {
        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping]; //ios7以上已经摒弃的这个方法
    }
    ch = size.height + 20;
    return ch;
}


+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
/**
 *  画一个button
 *
 *  @param butFrame   button 的大小
 *  @param colorbg    背景颜色
 *  @param colorTouch 按下去的颜色
 *
 *  @return   button
 */


+ (UIButton*)createbuttonWithFrame:(CGRect)frameBtn buttonColorbg:(UIColor*)colorbg buttonColorTouch:(UIColor*)colorTouch WihtSlected:(BOOL)Senected
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frameBtn;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){ 1, 1, 1, 1 });
    [button.layer setBorderColor:colorref]; //边框颜色
    [button.layer setBorderColor:colorref]; //边框颜色
    CGSize imageSize = CGSizeMake(button.frame.size.width, button.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorTouch set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage* pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorbg set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage* pressedColorImg1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [button setBackgroundImage:pressedColorImg1 forState:UIControlStateNormal];
    if (Senected) {
        [button setBackgroundImage:pressedColorImg forState:UIControlStateSelected];
        //[button setBackgroundImage:pressedColorImg forState:UIControlStateHighlighted];
    }
    else {
        [button setBackgroundImage:pressedColorImg forState:UIControlStateHighlighted];
    }
    
    CGColorRelease(colorref);
    CGColorSpaceRelease(colorSpace);
    
    return button;
}
/**
 *
 *
 *  @param frameBtn
 *  @param colorbg
 *  @param colorTouch
 *  @param Senected
 *
 *  @return
 */
+ (UIButton*)createbuttonWithFrame:(CGRect)frameBtn buttonColorbg:(UIColor*)colorbg buttonColorTouch:(UIColor*)colorTouch
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frameBtn;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){ 1, 1, 1, 1 });
    [button.layer setBorderColor:colorref]; //边框颜色
    [button.layer setBorderColor:colorref]; //边框颜色
    CGSize imageSize = CGSizeMake(button.frame.size.width, button.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorTouch set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    //    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    //    [colorbg set];
    //    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage* pressedColorImg1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [button setBackgroundImage:pressedColorImg1 forState:UIControlStateNormal];
    
    //[button setBackgroundImage:pressedColorImg forState:UIControlStateHighlighted];
    
    CGColorRelease(colorref);
    CGColorSpaceRelease(colorSpace);
    return button;
}

+(UIImage *)CreateImageByColorbg:(UIColor*)colorbg withSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [colorbg set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage* pressedColorImg1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg1;
    
}

/**
 *  画一个button
 *
 *  @param butFrame   button 的大小
 *  @param colorbg    背景颜色
 *  @param colorTouch 按下去的颜色
 *  @param m          画圆，圆的半径
 *
 *  @return   button
 */
+ (UIButton*)createbuttonWithFrame:(CGRect)butFrame
                        btnColorbg:(UIColor*)colorbg
                     btnColorTouch:(UIColor*)colorTouch
                          btnRound:(NSInteger)m
{
    UIButton* button = [self createbuttonWithFrame:butFrame buttonColorbg:colorbg buttonColorTouch:colorTouch];
    button.layer.cornerRadius = m;
    button.layer.masksToBounds = YES;
    
    return button;
}

+ (UIButton*)createbuttonWithFrame:(CGRect)butFrame
                        btnColorbg:(UIColor*)colorbg
                     btnColorTouch:(UIColor*)colorTouch
                          btnRound:(NSInteger)m withSelect:(BOOL)y
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = butFrame;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){ 1, 1, 1, 1 });
    [button.layer setBorderColor:colorref]; //边框颜色
    [button.layer setBorderColor:colorref]; //边框颜色
    CGSize imageSize = CGSizeMake(button.frame.size.width, button.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorTouch set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorbg set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage* pressedColorImg1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [button setBackgroundImage:pressedColorImg1 forState:UIControlStateNormal];
    
    [button setBackgroundImage:pressedColorImg forState:UIControlStateSelected];
    
    button.layer.cornerRadius = m;
    button.layer.masksToBounds = YES;
    
    CGColorRelease(colorref);
    CGColorSpaceRelease(colorSpace);
    
    return button;
}



/**
 *  倒计时
 *
 *  @param matchTimeStr 时间戳
 *
 *  @return %@天%@小时%@分钟
 */
+ (NSString*)timerCountDown:(NSObject*)matchTimeObj
{
    NSString* matchTimeStr = (NSString*)matchTimeObj;
    NSString* cdHoure;
    NSString* cdMin;
    NSCalendar* cal = [NSCalendar currentCalendar]; //定义一个NSCalendar对象
    NSDate* today = [NSDate date]; //得到当前时间
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate* todate = [NSDate dateWithTimeIntervalSince1970:[matchTimeStr doubleValue]];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* comps;
    comps = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit
                                  | NSMonthCalendarUnit | NSYearCalendarUnit)
                        fromDate:todate];
    
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit;
    NSDateComponents* d = [cal components:unitFlags fromDate:today toDate:todate options:0];
    
    int day = [d day];
    long hour = [d hour];
    long minute = [d minute];
    
    
    NSLog(@"-----%d---%lu----%lu",day,hour,minute);

    
    return [NSString stringWithFormat:@"%@/%@", cdHoure, cdMin];
}

// emoji 添加
+ (NSString*)URLEncodedString:(NSString*)str
{
    NSString* result = (__bridge_transfer NSString*)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                            (CFStringRef)str,
                                                                                            NULL,
                                                                                            CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                            kCFStringEncodingUTF8);
    //    [result autorelease];
    return result;
}

//emoji 解压
+ (NSString*)URLDecodedString:(NSString*)str
{
    NSString* result = (__bridge_transfer NSString*)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                            (CFStringRef)str,
                                                                                                            CFSTR(""),
                                                                                                            kCFStringEncodingUTF8);
    //    [result autorelease];
    return result;
}

+(NSString*)disable_emoji:(NSString*)text
{
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u2026\\u2103\\u278a-\\u2793\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString* modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

// 从view 页面进入 UIViewController页面
+ (void)pushNextUIViewController:(UIViewController*)viewController myView:(UIView*)views
{
    
    id object = [views nextResponder];
    
    while (![object isKindOfClass:[UIViewController class]] &&
           
           object != nil) {
        
        object = [object nextResponder];
    }
    
    UIViewController* uc = (UIViewController*)object;
    viewController.hidesBottomBarWhenPushed =  YES;
    [uc.navigationController pushViewController:viewController animated:YES];
    //return nil;
}

// 从view 页面进入 UIViewController页面
+ (void)presentModalViewController:(UIViewController*)viewController myView:(UIView*)views
{
    
    id object = [views nextResponder];
    
    while (![object isKindOfClass:[UIViewController class]] &&
           
           object != nil) {
        
        object = [object nextResponder];
    }
    
    UIViewController* uc = (UIViewController*)object;
    [uc.navigationController presentViewController:viewController animated:YES completion:nil];
    //return nil;
}


+ (NSString*)datetostringMMdd:(NSString*)datetime //获取当前时间
{
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* created_date = [formatter dateFromString:datetime];

    [formatter setDateFormat:@"MM-dd HH:mm"];
    [formatter setTimeZone:timeZone];
    NSString* str = [formatter stringFromDate:created_date];
    
    return str;
}


+(NSArray*)groupArry:(NSArray*)modelarray condition:(NSString*)conditionstr{
    // 获取array中所有index值
    NSArray *indexArray = [modelarray valueForKey:conditionstr];
    // 将array装换成NSSet类型
    NSSet *indexSet = [NSSet setWithArray:indexArray];
    // 新建array，用来存放分组后的array
    NSMutableArray *resultArray = [NSMutableArray array];
    // NSSet去重并遍历
    [[indexSet allObjects] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 根据NSPredicate获取array
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ == %@",conditionstr,obj];
        NSArray *indexArray = [modelarray filteredArrayUsingPredicate:predicate];
        
        // 将查询结果加入到resultArray中
        [resultArray addObject:indexArray];
    }];
    
    return resultArray;
}

@end
