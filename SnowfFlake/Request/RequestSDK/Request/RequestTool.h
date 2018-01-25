//
//  RequestTool.h
//  DRRequestSDK
//
//  Created by jilei on 2017/6/6.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "RequestHYModel.h"
@interface RequestTool : NSObject

+(void)setHeaders:(NSDictionary*)headers;
    /**
     不带缓存model请求post
     
     @param m       model 对象
     @param success 成功返回
     @param failure 失败返回
     */
+ (void)requestPost:(RequestHYModel*)m
        whenSuccess:(void (^)(NSURLSessionDataTask *task,RequestHYModel* m,id res))success
        whenFailure:(void (^)(NSError* err,RequestHYModel* m,id res))failure;
    
    
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
             whenFailure:(void (^)(NSError* err))failure;
    
    
    /**
     不带缓存model请求Get
     
     @param m       model 对象
     @param success 成功返回
     @param failure 失败返回
     */
+ (void)requestGet:(RequestHYModel*)m
        whenSuccess:(void (^)(NSURLSessionDataTask *task,RequestHYModel* m,id res))success
        whenFailure:(void (^)(NSError* err))failure;
    
    
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
             whenFailure:(void (^)(NSError* err))failure;




/**
 不带缓存Hybrid请求post
 
 @param url       URL
 @param dic       参数
 @param success 成功返回
 @param failure 失败返回
 */
+ (void)requestHybridPost:(NSString*)url
                withParam:(NSDictionary*)dic
              whenSuccess:(void (^)(NSURLSessionDataTask *task,id res))success
              whenFailure:(void (^)(NSURLSessionDataTask *  task,NSError* err))failure;


/**
 不带缓存Hybrid请求get
 
 @param url       URL
 @param success 成功返回
 @param failure 失败返回
 */
+ (void)requestHybridGet:(NSString*)url
              whenSuccess:(void (^)(NSURLSessionDataTask *task,id res))success
              whenFailure:(void (^)(NSURLSessionDataTask *  task,NSError* err))failure;

@end
