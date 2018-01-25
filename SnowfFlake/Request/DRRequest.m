//
//  DRRequest.m
//  DeepCubeRobotControls
//
//  Created by zoff on 2017/6/9.
//  Copyright © 2017年 zoff. All rights reserved.
//

#import "DRRequest.h"
//#import "DRSvUDIDTools.h"
#import "DRMMUntil.h"
//#import "DRProgressHUD.h"
#import "MBProgressHUD.h"
@implementation DRRequest
+(void)setHeaders:(NSDictionary*)headers
{
    [RequestTool setHeaders:headers];
}
+ (void)requestPost:(DRHYModel*)m
        whenSuccess:(void (^)(DRHYModel* m,id res))success
        whenFailure:(void (^)(NSError* err,id res))failure
{
    
    DRHYModel * mm= m;
//    mm.requesturl=drbaseurl2([mm getUrl]); //请求URL
      mm.requesturl=[mm getUrl]; //请求URL
    NSMutableDictionary * parms=[NSMutableDictionary dictionaryWithDictionary:[mm properties_aps]];
   
   // [parms setObject:@"20171001" forKey:@"version"];
    mm.args   = parms;
    mm.codeNumber=100; //错误号
    mm.status=@"msg";//获取错误信息
    
    if (m.showWaiting) {
//        [MBProgressHUD showAnimated:YES];
    }
    mm.DRshowWaiting=m.showWaiting;
    mm.showWaiting=NO;
    [RequestTool requestPost:mm whenSuccess:^(NSURLSessionDataTask *task, RequestHYModel *m, id res) {
        DRHYModel * mms=(DRHYModel *)m;
        
        success(mms,res);
        if (mm.DRshowWaiting) {
//            [MBProgressHUD dismissHUD];
        }

        
    }
    whenFailure:^(NSError* err,RequestHYModel* m,id res)
    {
        
        failure(err,res);
        if (mm.DRshowWaiting) {
//            [DRProgressHUD dismissHUD];
        }
        //多端登录 被挤下线 提示
        if (m.msgCode==10001)
        {
            [DRMMUntil showMessage:m.msg Type:2];
        }
    }];
}

+ (void)requestHybridPost:(NSString*)url
                withPrams:(NSDictionary*)dic
              whenSuccess:(void (^)(id res))success
              whenFailure:(void (^)(NSError* err))failure
{
    [RequestTool requestHybridPost:url withParam:dic whenSuccess:^(NSURLSessionDataTask *task, id res) {
        if(success)
        {
            success(res);
            
        }
    } whenFailure:^(NSURLSessionDataTask *task, NSError *err) {
        if(failure)
        {
            failure(err);
            
        }
        
    }];
}


+ (void)requestHybridGet:(NSString*)url
             whenSuccess:(void (^)(id res))success
             whenFailure:(void (^)(NSError* err))failure
{
    [RequestTool requestHybridGet:url  whenSuccess:^(NSURLSessionDataTask *task, id res) {
        if(success)
        {
            success(res);
            
        }
    } whenFailure:^(NSURLSessionDataTask *task, NSError *err) {
        if(failure)
        {
            success(err);
            
        }
        
    }];
}

@end
