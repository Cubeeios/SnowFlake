//
//  YJCustomURLProtocol.m
//  NSURLProtocal
//
//  Created by yj on 17/3/22.
//  Copyright © 2017年 yj. All rights reserved.
//

#import "YJCustomURLProtocol.h"
#import "NSHTTPURLResponse+Plus.h"
#import "NSObject+DRExtension.h"
static NSString *const KYJURLProtocolHandlerKey = @"URLProtocolHandlerKey";
@interface YJCustomURLProtocol ()<NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate>
@property (nonnull,strong) NSURLSessionDataTask *task;
@property (strong,nonatomic) NSURLConnection *connection;

@end

@implementation YJCustomURLProtocol
+ (BOOL)    ·:(NSURLRequest *)request {
    
    NSLog(@"request.URL.absoluteString = %@",request.URL.absoluteString);
    NSString *scheme = [[request URL] scheme];
    if ( ([scheme caseInsensitiveCompare:@"http"]  == NSOrderedSame ||
          [scheme caseInsensitiveCompare:@"https"] == NSOrderedSame ))
    {
        //看看是否已经处理过了，防止无限循环
        if ([NSURLProtocol propertyForKey:KYJURLProtocolHandlerKey inRequest:request])
        {
            return NO;
        }
        NSString *MIMETypeString = [self containMIMETypeWithURL:request.URL.absoluteString];
        if (MIMETypeString)  {
            return NO;
        }else
        {
            
            
        }
        NSLog(@"request-11--%@--/n--%@",request,request.HTTPBody);
        return YES;
        
        
    }
    return NO;
  
}
+(NSString *) containMIMETypeWithURL:(NSString *) URL {
    NSString *MIMETypeString = nil;
    
    if ([URL containsString:@".html"]) {
        MIMETypeString = @"text/html";
    } else if ([URL containsString:@".css"]) {
        MIMETypeString = @"text/css";
    } else if ([URL containsString:@".js"]) {
        MIMETypeString = @"text/javascript";
    } else if ([URL containsString:@".jpg"]) {
        MIMETypeString = @"image/jpeg";
    }else if ([URL containsString:@".png"]) {
        MIMETypeString = @"image/png";
    } else if ([URL containsString:@".pdf"]){
        MIMETypeString = @"application/pdf";
    } else if ([URL containsString:@".pdf"]){
        MIMETypeString = @"audio/wav";
    } else if ([URL containsString:@".gif"]){
        MIMETypeString = @"image/gif";
    }
    else {
        ;
    }
    
    return MIMETypeString;
}
+ (NSURLRequest*)canonicalRequestForRequest:(NSURLRequest *)request {

    NSLog(@"request22---%@--/n--%@",request,request.HTTPBody);
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    
    //request截取重定向 这个可以根据需求重新定向URL
    if ([request.URL.absoluteString containsString:@"http://127.0.0.1:8008"])
    {
        NSString *MIMETypeString = [self containMIMETypeWithURL:request.URL.absoluteString];
        if (!MIMETypeString)  {
            
            NSArray *array =[request.URL.absoluteString componentsSeparatedByString:@"8008"];
            if (array.count==2) {
                NSString *str=[NSString stringWithFormat:@"%@%@",CurrentHost,[array objectAtIndex:1]];
//
                NSURL* url1 = [NSURL URLWithString:str];
//                mutableReqeust = [NSMutableURLRequest requestWithURL:url1];
                mutableReqeust.URL=url1;
//                NSData *body = request.HTTPBody;
//                mutableReqeust.HTTPBody=body;
//                NSLog(@" HTTPBody---%@",mutableReqeust.HTTPBody);
//                mutableReqeust.HTTPBodyStream=request.HTTPBodyStream;
//                mutableReqeust.allHTTPHeaderFields=request.allHTTPHeaderFields;
//                mutableReqeust.HTTPMethod=request.HTTPMethod;
//                    NSLog(@"mutableReqeust---%@--/n--%@",mutableReqeust,mutableReqeust.HTTPBody);
            }
            
            
        }
        
    }
    
    return mutableReqeust;
}

-(void)makeMutubleRequets:(NSURLRequest *)request{
    
    
}
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {

    return [super requestIsCacheEquivalent:a toRequest:b];
}


- (void)startLoading {

  
    /* 如果想直接返回缓存的结果，构建一个NSURLResponse对象
     if (cachedResponse) {
     
     NSData *data = cachedResponse.data; //缓存的数据
     NSString *mimeType = cachedResponse.mimeType;
     NSString *encoding = cachedResponse.encoding;
     
     NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.request.URL
     MIMEType:mimeType
     expectedContentLength:data.length
     textEncodingName:encoding];
     
     [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
     [self.client URLProtocol:self didLoadData:data];
     [self.client URLProtocolDidFinishLoading:self];
     */
    
  
    
    NSMutableURLRequest *mutableReqeust = [[self request] mutableCopy];
    //给我们处理过的请求设置一个标识符, 防止无限循环,
    [NSURLProtocol setProperty:@YES forKey:KYJURLProtocolHandlerKey inRequest:mutableReqeust];
    
    //   if ([self.request.URL.absoluteString containsString:@"http://127.0.0.1:8008"])
    //   {
    //这里处理页面里面发出的AJAX请求拦截处理。
    
    NSString *MIMETypeString = [self containMIMETypeWithURL:self.request.URL.absoluteString];
    if (!MIMETypeString)  {
 
        [mutableReqeust setValue:[NSObject getUserToken] forHTTPHeaderField:@"accessToken"];
        [mutableReqeust setValue:[NSObject deviceIPAdress] forHTTPHeaderField:@"ip"];
        NSString *userid = [[NSObject getUserID] stringValue];
        [mutableReqeust setValue:userid forHTTPHeaderField:@"userId"];
        NSLog(@"HTTPMethod----%@--HTTPMethod--%@--HTTPBody--%@",self.request.HTTPMethod,self.request.allHTTPHeaderFields,self.request.HTTPBody);
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
        self.task = [session dataTaskWithRequest:mutableReqeust];
        [self.task resume];
    }
    // NSLog(@"没有网络，而且没有找到对应的资源,那就直接调用父类的该方法吧");
    
    // }
    
    
//    self.connection = [NSURLConnection connectionWithRequest:mubleRequest delegate:self];
    
//    [self.connection start];
}
-(NSString *) containMIMETypeWithURL:(NSString *) URL {
    NSString *MIMETypeString = nil;
    
    if ([URL containsString:@".html"]) {
        MIMETypeString = @"text/html";
    } else if ([URL containsString:@".css"]) {
        MIMETypeString = @"text/css";
    } else if ([URL containsString:@".js"]) {
        MIMETypeString = @"text/javascript";
    } else if ([URL containsString:@".jpg"]) {
        MIMETypeString = @"image/jpeg";
    }else if ([URL containsString:@".png"]) {
        MIMETypeString = @"image/png";
    } else if ([URL containsString:@".pdf"]){
        MIMETypeString = @"application/pdf";
    } else if ([URL containsString:@".pdf"]){
        MIMETypeString = @"audio/wav";
    }else if ([URL containsString:@".gif"]){
        MIMETypeString = @"image/gif";
    }
    else {
        ;
    }
    
    return MIMETypeString;
}

+ (void)unmarkRequestAsIgnored:(NSMutableURLRequest *)request
{
    NSString *key = NSStringFromClass([self class]);
    [NSURLProtocol removePropertyForKey:key inRequest:request];
}
- (void)stopLoading
{
    if (self.task != nil)
    {
        [self.task  cancel];
    }
}
#pragma mark - NSURLSessionTaskDelegate

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest *_Nullable))completionHandler
{
    if ([self client] != nil && [self task] == task) {
        NSMutableURLRequest *mutableRequest = [request mutableCopy];
        [[self class] unmarkRequestAsIgnored:mutableRequest];
        [[self client] URLProtocol:self wasRedirectedToRequest:mutableRequest redirectResponse:response];
        
        NSError *error = [[NSError alloc] initWithDomain:NSURLErrorDomain code:NSURLErrorCancelled userInfo:nil];
        [self.task cancel];
        [self.client URLProtocol:self didFailWithError:error];
    }
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error
{
    if ([self client] != nil && (_task == nil || _task == task)) {
        if (error == nil) {
            [[self client] URLProtocolDidFinishLoading:self];
        } else if ([error.domain isEqual:NSURLErrorDomain] && error.code == NSURLErrorCancelled) {
            // Do nothing.
        } else {
            [[self client] URLProtocol:self didFailWithError:error];
        }
    }
}
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error
{
    NSLog(@"error---%@",error);
}



- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    if ([self client] != nil && [self task] != nil && [self task] == dataTask) {
        NSHTTPURLResponse *URLResponse = nil;
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            URLResponse = (NSHTTPURLResponse *)response;
            URLResponse = [NSHTTPURLResponse rxr_responseWithURL:URLResponse.URL
                                                      statusCode:URLResponse.statusCode
                                                    headerFields:URLResponse.allHeaderFields
                                                 noAccessControl:YES];
        }
        NSLog(@"response---%@",response);
        //NSLog(@"response---%@",response.);
        [[self client] URLProtocol:self
                didReceiveResponse:URLResponse ?: response
                cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        completionHandler(NSURLSessionResponseAllow);
    }
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    if ([self client] != nil && [self task] == dataTask) {
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:kNilOptions
                              error:nil];
        NSLog(@"json---%@",json);
        [[self client] URLProtocol:self didLoadData:data];
    }
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse *_Nullable cachedResponse))completionHandler
{
    if ([self client] != nil && [self task] == dataTask) {
        
        completionHandler(proposedResponse);
    }
}
@end
