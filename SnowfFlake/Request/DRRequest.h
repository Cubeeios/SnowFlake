//
//  DRRequest.h
//  DeepCubeRobotControls
//
//  Created by zoff on 2017/6/9.
//  Copyright © 2017年 zoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DRHYModel.h"
#import "RequestTool.h"
#import "WKWebViewJavascriptBridge.h"
@interface DRRequest : NSObject
+(void)setHeaders:(NSDictionary*)headers;

+ (void)requestPost:(DRHYModel*)m
        whenSuccess:(void (^)(DRHYModel* m,id res))success
        whenFailure:(void (^)(NSError* err,id res))failure;




+ (void)requestHybridPost:(NSString*)url
             withPrams:(NSDictionary*)dic
        whenSuccess:(void (^)(id res))success
        whenFailure:(void (^)(NSError* err))failure;


+ (void)requestHybridGet:(NSString*)url
              whenSuccess:(void (^)(id res))success
              whenFailure:(void (^)(NSError* err))failure;
@end
