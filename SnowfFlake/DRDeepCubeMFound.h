//
//  DRDeepCubeMFound.h
//  DeepCubeRobotControls
//
//  Created by zoff on 2017/6/7.
//  Copyright © 2017年 zoff. All rights reserved.
//

#ifndef DRDeepCubeMFound_h
#define DRDeepCubeMFound_h







#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define SafeMargin         (KIsiPhoneX ? 24.f : 0.f)
#define DRImageNamed(_pointer) [UIImage imageNamed:_pointer]


//硬件相关参数
#define  DEVICE_iPhoneX (([[UIScreen mainScreen] bounds].size.width == 375.f && [[UIScreen mainScreen] bounds].size.height == 812 ? YES : NO))
#define  DRLETKStatusbarH  (DEVICE_iPhoneX ? 24.0 : 0.0)
#define DR_TabbarSafeBottomMargin         (DEVICE_iPhoneX ? 34.f : 0.f)
#define DRDEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width
#define DRDEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define DRTopDistin(r) ((SYSTEMVERSION) ? (20 + (r)) : (r))
#define DRhzbeishu (DRDEVICE_WIDTH / 320)
#define DRhzbeishu_iphone6 (DRDEVICE_WIDTH / 375)  //667
#define DRhzbeishu_iphone6p (DRDEVICE_WIDTH / 414)
#define DRhzbeishu_iphone6_H (DRDEVICE_HEIGHT / 667)  //667

#define DRCONTENT_FONT(size) [UIFont systemFontOfSize:size]
#define DRRGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define DRWEAKSELF __weak typeof(self)  weakSelf = self;
#define STRONGSELF __strong typeof(weakSelf)  strongSelf = weakSelf;


#define DR_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define DRSCREEN_MAX_LENGTH (MAX(DRDEVICE_WIDTH, DRDEVICE_HEIGHT))
#define DRSCREEN_MIN_LENGTH (MIN(DRDEVICE_WIDTH, DRDEVICE_HEIGHT))
#define DR_IS_IPHONE_4_OR_LESS (DR_IS_IPHONE && DRSCREEN_MAX_LENGTH < 568.0)
#define DR_IS_IPHONE_5 (DR_IS_IPHONE && DRSCREEN_MAX_LENGTH == 568.0)
#define DR_IS_IPHONE_6 (DR_IS_IPHONE && DRSCREEN_MAX_LENGTH == 667.0)
#define DR_IS_IPHONE_6P (DR_IS_IPHONE && DRSCREEN_MAX_LENGTH == 736.0)
#endif /* DRDeepCubeMFound_h */
