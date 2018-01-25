//
//  DCCJ_LAContextManager.h
//  LAContext
//
//  Created by 龚欢 on 2017/11/29.
//  Copyright © 2017年 龚欢. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    kCancelDidClcik,              // 取消事件点击
    kAuthorFingerOpenFailure,     // 授权失败
    kDidNotAccessFingerAuth       // 生物识别不支持或其他（FaceID使用次数超出，设置未开启等）/*error.code == -8 超出使用次数，已被锁。error.code == -7 支持TouchID但是TouchID被关掉了 error.code == -6 设置里面禁用了App的FaceID,如果手机不支持touchID也会报这个错*/
} DCCJ_FeedBackTypes;

typedef void(^DCCJ_Success)(void);
typedef void(^DCCJ_Failure)(NSError *e, DCCJ_FeedBackTypes feedType);

@interface DCCJ_LAContextManager : NSObject

+ (void)dccjOpenFingerLockOn:(UIViewController *)controller
                     success:(DCCJ_Success)success
                     failure:(DCCJ_Failure)failure;

@end


