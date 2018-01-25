//
//  RequestTool.m
//  DRRequestSDK
//
//  Created by jilei on 2017/6/6.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import "RequestTool.h"
//#import "SVProgressHUD.h"
#import "RequestHPNetWorkCache.h"
#import "NetWorkManager.h"
#import "RequestUntil.h"
//#import "JPUSHService.h"
@implementation RequestTool

//-(void)addjpush
//{
//    [JPUSHService setupWithOption:nil appKey:@"fba88677df3c0118bad1133f"
//                          channel:nil
//                 apsForProduction:YES
//            advertisingIdentifier:nil];
//    
//}

/**
 不带缓存model请求post
 
 @param m       model 对象
 @param success 成功返回
 @param failure 失败返回
 */
+ (void)requestPost:(RequestHYModel*)m
        whenSuccess:(void (^)(NSURLSessionDataTask *task,RequestHYModel* m,id res))success
        whenFailure:(void (^)(NSError* err,RequestHYModel* m,id res))failure
{
    NSAssert(m, @"空对象你请求个啥");
    NSAssert([m notEmpty:[m getUrl]], @"没有请求的接口名称");
    if (m.showWaiting) {
       // [SVProgressHUD show];
    }
    NSMutableDictionary* dicT = [NSMutableDictionary dictionaryWithDictionary:[m getArgs]];
    NSString* strUrl = m.requesturl;
    //请求接口@"http://114.215.192.153:9009/login"
    
    [NetWorkManager postNoCache:strUrl WithParaments:dicT withSuccessBlock:^(NSURLSessionDataTask *task, NSDictionary *object) {
           NSLog(@"responseObject111--%@",object);
        //老的数据解析逻辑，搬过来处理
        if (m.isReturnModel)
        {
            RequestHYModel * model=m;
            if(model && [model respondsToSelector:@selector(parse:)])
            {
                [model parse:object];
            }
//            if(model.msgCode == model.codeNumber)
//            {
                if (m.showWaiting)
                {
                   // [SVProgressHUD dismiss];
                }
                
                if(success)
                {
                    success(task,model,object);
                    
                }
                
//            }
            else
            {
                if (!m.showNoErrormess)
                {
                    [RequestUntil showMessage:m.msg Type:2];
                   // [SVProgressHUD showErrorWithStatus:m.msg];
                }
                else
                {
                   // [SVProgressHUD dismiss];
                }
                failure(nil,model,object);
            }
            
        }
        else
        {
            success(task,nil,object);
        }
        
        
   
    } withFailureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error--%@",error);
        RequestHYModel *model = m;
        if(model.showWaiting)
        {
            //[SVProgressHUD dismiss];
        }
        if(failure)
        {
            failure(error,nil,nil);
        }

    }];
};

+(void)setHeaders:(NSDictionary*)headers
{
    [NetWorkManager setHeaders:headers];
}
+(void)requestHybridPost:(NSString *)url withParam:(NSDictionary *)dic  whenSuccess:(void (^)(NSURLSessionDataTask *task,id res))success whenFailure:(void (^)(NSURLSessionDataTask *  task,NSError * error))failure
{
    NSAssert(url, @"空对象你请求个啥");
   
    NSMutableDictionary* dicT = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSString* strUrl =url;
    //请求接口@"http://114.215.192.153:9009/login"
    
    [NetWorkManager postNoCache:strUrl WithParaments:dicT withSuccessBlock:^(NSURLSessionDataTask *task, NSDictionary *object) {
        NSLog(@"responseObject111--%@",object);
        //老的数据解析逻辑，搬过来处理
        
            if(success)
            {
                success(task,object);
                
            }
            
  
        
        
        
    } withFailureBlock:^(NSURLSessionDataTask *  task,NSError *error) {
      
        if(failure)
        {
            failure(task,error);
        }
        
    }];
}
    
/**
 带缓存的model请求post
 
 @param m             model 对象
 @param responseCache 返回的缓存数据
 @param success       成功返回
 @param failure       失败返回
 */
+ (void)requestCachePost:(RequestHYModel*)m
            CacheSuccess:(void (^)(RequestHYModel* m,id res))responseCache
             whenSuccess:(void (^)(NSURLSessionDataTask *task,RequestHYModel* m,id res))success
             whenFailure:(void (^)(NSError* err))failure
{
    if (m.showWaiting)
    {
       // [SVProgressHUD show];
    }
    NSMutableDictionary* dicT = [NSMutableDictionary dictionaryWithDictionary:[m getArgs]];
    NSString* strUrl = m.requesturl;

    [NetWorkManager postWithCache:strUrl WithParaments:dicT WithResponseCache:^(id responseObject) {
        NSLog(@"responseObject--%@",responseObject);
        RequestHYModel * model=m;
        if(model && [model respondsToSelector:@selector(parse:)])
        {
            [model parse:responseObject];
        }
        responseCache(model,responseObject);
       // [SVProgressHUD dismiss];
    } withSuccessBlock:^(NSURLSessionDataTask *task, NSDictionary *object) {
        NSLog(@"responseObject111--%@",object);
        if (m.isReturnModel)
        {
            RequestHYModel * model=m;
            if(model && [model respondsToSelector:@selector(parse:)])
            {
                [model parse:object];
            }
            if(model.msgCode == model.codeNumber)
            {
                if (m.showWaiting)
                {
                   // [SVProgressHUD dismiss];
                }
                
                if(success)
                {
                    success(task,model,object);
                    
                }
                
            }
            else
            {
                if (!m.showNoErrormess)
                {
                      [RequestUntil showMessage:m.msg Type:2];
                    //[SVProgressHUD showErrorWithStatus:m.msg];
                }
                else
                {
                    //[SVProgressHUD dismiss];
                }
                failure(nil);
            }
        }
        else
        {
            success(task,nil,object);
        }

    } withFailureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        RequestHYModel *model = m;
        if(model.showWaiting)
        {
            //[SVProgressHUD dismiss];
        }
        if(failure)
        {
            failure(error);
        }
    }];
}
    
/**
 不带缓存model请求Get
 
 @param m       model 对象
 @param success 成功返回
 @param failure 失败返回
 */
    
+ (void)requestGet:(RequestHYModel*)m
       whenSuccess:(void (^)(NSURLSessionDataTask *task,RequestHYModel* m,id res))success
       whenFailure:(void (^)(NSError* err))failure
{
    NSAssert(m, @"空对象你请求个啥");
    NSAssert([m notEmpty:[m getUrl]], @"没有请求的接口名称");
    if (m.showWaiting) {
       // [SVProgressHUD show];
    }
    NSMutableDictionary* dicT = [NSMutableDictionary dictionaryWithDictionary:[m getArgs]];
    NSString* strUrl = m.requesturl;
    //请求接口
    
    [NetWorkManager getNoCache:strUrl WithParaments:dicT withSuccessBlock:^(NSURLSessionDataTask *task, NSDictionary *object) {
        NSLog(@"responseObject111--%@",object);
        //老的数据解析逻辑，搬过来处理
        if (m.isReturnModel)
        {
            RequestHYModel * model=m;
            if(model && [model respondsToSelector:@selector(parse:)])
            {
                [model parse:object];
            }
            if(model.msgCode == model.codeNumber)
            {
                if (m.showWaiting)
                {
                   // [SVProgressHUD dismiss];
                }
                
                if(success)
                {
                    success(task,model,object);
                    
                }
                
            }
            else
            {
                if (!m.showNoErrormess)
                {
                      [RequestUntil showMessage:m.msg Type:2];
                  //  [SVProgressHUD showErrorWithStatus:m.msg];
                }
                else
                {
                   // [SVProgressHUD dismiss];
                }
                failure(nil);
            }
            
        }
        else
        {
            success(task,nil,object);
        }
        
        
        
    } withFailureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error--%@",error);
        RequestHYModel *model = m;
        if(model.showWaiting)
        {
           // [SVProgressHUD dismiss];
        }
        if(failure)
        {
            failure(error);
        }
        
    }];

    
}
+ (void)requestHybridGet:(NSString*)url
             whenSuccess:(void (^)(NSURLSessionDataTask *task,id res))success
             whenFailure:(void (^)(NSURLSessionDataTask *  task,NSError* err))failure
{
    NSAssert(url, @"空对象你请求个啥");

    NSString* strUrl = url;
    //请求接口
    
    [NetWorkManager getNoCache:strUrl WithParaments:nil withSuccessBlock:^(NSURLSessionDataTask *task, NSDictionary *object) {
        NSLog(@"responseObject111--%@",object);
        //老的数据解析逻辑，搬过来处理
       
                
                if(success)
                {
                    success(task,object);
                    
                }
                
        
    
     
        
        
        
    } withFailureBlock:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"error--%@",error);
     
        if(failure)
        {
            failure(task,error);
        }
        
    }];
}
    
/**
 带缓存的model请求Get
 
 @param m             model 对象
 @param responseCache 返回的缓存数据
 @param success       成功返回
 @param failure       失败返回
 */
+ (void)requestCacheGet:(RequestHYModel*)m
           CacheSuccess:(void (^)(RequestHYModel* m,id res))responseCache
            whenSuccess:(void (^)(NSURLSessionDataTask *task,RequestHYModel* m,id res))success
            whenFailure:(void (^)(NSError* err))failure
    {
        if (m.showWaiting)
        {
           // [SVProgressHUD show];
        }
        NSMutableDictionary* dicT = [NSMutableDictionary dictionaryWithDictionary:[m getArgs]];
        NSString* strUrl = m.requesturl;
        
        [NetWorkManager getWithCache:strUrl WithParaments:dicT WithResponseCache:^(id responseObject) {
            NSLog(@"responseObject--%@",responseObject);
            RequestHYModel * model=m;
            if(model && [model respondsToSelector:@selector(parse:)])
            {
                [model parse:responseObject];
            }
            responseCache(model,responseObject);
           // [SVProgressHUD dismiss];
        } withSuccessBlock:^(NSURLSessionDataTask *task, NSDictionary *object) {
            NSLog(@"responseObject111--%@",object);
            if (m.isReturnModel)
            {
                RequestHYModel * model=m;
                if(model && [model respondsToSelector:@selector(parse:)])
                {
                    [model parse:object];
                }
                if(model.msgCode == model.codeNumber)
                {
                    if (m.showWaiting)
                    {
                       // [SVProgressHUD dismiss];
                    }
                    
                    if(success)
                    {
                        success(task,model,object);
                        
                    }
                    
                }
                else
                {
                    if (!m.showNoErrormess)
                    {
                          [RequestUntil showMessage:m.msg Type:2];
                       // [SVProgressHUD showErrorWithStatus:m.msg];
                    }
                    else
                    {
                       // [SVProgressHUD dismiss];
                    }
                    failure(nil);
                }
            }
            else
            {
                success(task,nil,object);
            }
            
        } withFailureBlock:^(NSURLSessionDataTask *task, NSError *error) {
            RequestHYModel *model = m;
            if(model.showWaiting)
            {
               // [SVProgressHUD dismiss];
            }
            if(failure)
            {
                failure(error);
            }
        }];
    }
    
    
@end
