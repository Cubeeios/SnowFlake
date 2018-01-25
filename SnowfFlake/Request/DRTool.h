//
//  DRTool.h
//  DeepCubeRobotControls
//
//  Created by zoff on 2017/6/6.
//  Copyright © 2017年 zoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DRTool : NSObject

+ (UIColor*)rgbToUIcolor:(NSString*)rgb;

/**
 *
 *  @param stringToConvert    十进制色值  例如 ＃eeeeee
 *  @param colorAlpha      透明度
 *
 *  @return    颜色值
 */
+ (UIColor*)hexStringToColor:(NSString*)stringToConvert thisAlpha:(float)colorAlpha;

+ (UIColor*)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;
+ (NSString*)hexFromUIColor:(UIColor*)color;

@end
