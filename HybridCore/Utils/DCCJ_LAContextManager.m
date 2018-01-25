//
//  DCCJ_LAContextManager.m
//  LAContext
//
//  Created by 龚欢 on 2017/11/29.
//  Copyright © 2017年 龚欢. All rights reserved.
//

#import "DCCJ_LAContextManager.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface DCCJ_LAContextManager()

@property (nonatomic, copy) DCCJ_Success success;
@property (nonatomic, copy) DCCJ_Failure failure;

@end

@implementation DCCJ_LAContextManager

+ (void)dccjOpenFingerLockOn:(UIViewController *)controller
                     success:(DCCJ_Success)success
                     failure:(DCCJ_Failure)failure {
    
    if ([controller isKindOfClass:[UIViewController class]]) {
        [DCCJ_LAContextManager realOpenFinger:success failure:failure];
    }
}

#pragma mark - Private methods

+ (void)realOpenFinger:(DCCJ_Success)success
               failure:(DCCJ_Failure)failure {
    
    NSString *message = [DCCJ_LAContextManager is_IphoneX] ? @"面容 ID 短时间内失败多次，需要验证手机密码" : @"请把你的手指放到Home键上";
    NSInteger deviceType = LAPolicyDeviceOwnerAuthenticationWithBiometrics;
    LAContext *laContext = [[LAContext alloc] init];
    laContext.localizedFallbackTitle = @"";
    NSError *error = nil;
    BOOL isSupport = [laContext canEvaluatePolicy:(deviceType) error:&error];
    
    if (isSupport) {
        [laContext evaluatePolicy:(deviceType) localizedReason:message reply:^(BOOL s, NSError * _Nullable error) {
            if (s) {
                success();
            }else {
                failure(error, kAuthorFingerOpenFailure);
            }
        }];
    }else {
        failure(error, kDidNotAccessFingerAuth);
    }
}

+ (BOOL)is_IphoneX {
    return [UIScreen mainScreen].bounds.size.height == 812 ? YES : NO;
}

@end


