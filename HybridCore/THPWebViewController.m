//
//  THPWebViewController.m
//  TheOnePlus
//
//  Created by jilei on 2017/12/14.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import "THPWebViewController.h"
#import "SnowfFlake-Swift.h"
#import "NSURLProtocol+WKWebVIew.h"
#import "WebViewJavascriptBridge.h"
#import "RequestTool.h"
#import "HTMLConfigModel.h"
#import "MBProgressHUD+NHAdd.h"

#import "AppDelegate.h"
#import "WHC_HttpManager.h"
#import "DRAFNetworkReachabilityManager.h"
@interface THPWebViewController ()<THPWebviewDelegate>
@property WebViewJavascriptBridge* bridge;
@property(nonatomic,strong) HTMLConfigModel* h5ConfigModel;

@end

@implementation THPWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:@"noti" object:nil];
[self afnReachabilityTest];
    if (_bridge) { return; }

    //注册拦截协议
//    [NSURLProtocol wk_registerScheme:@"https"];
//    [NSURLProtocol wk_registerScheme:@"http"];
    //设置密钥
    // [HybridConfig setEncryptionKey:@"divngefkdpqlcmferfxef3fr"];
    //定格至电池栏
    self.automaticallyAdjustsScrollViewInsets = false;
    //HybridResource路径映射
    NSURL *path=  [[NSBundle mainBundle].resourceURL URLByAppendingPathComponent:@"HybridResource"];
    [HybridConfig setResourcePreloadPath:path.path];
    //route路径映射
    NSURL *URL=  [[[NSBundle mainBundle].resourceURL URLByAppendingPathComponent:@"HybridResource"] URLByAppendingPathComponent:@"route.json"];
    [HybridConfig setRouteFilePath:URL.path];
    
    //加载WebView
    self.web =  [Router.shared thpWebViewIn:RootSource delegate:self];
    self.web.tpdelegate=self;

    self.web.webview.scrollView.bounces = false;
    self.web.webview.frame = CGRectMake( 0,  20, self.view.frame.size.width, self.view.frame.size.height-20 );
    [self.view addSubview:self.web.webview];
    
    [WebViewJavascriptBridge enableLogging];
    _bridge = [WebViewJavascriptBridge bridgeForWebView:self.web.webview];
    [_bridge setWebViewDelegate:self];
    NSString *userAgent1 = [self.web.webview stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSLog(@"userAgent :%@", userAgent1);
    
    [_bridge registerHandler:@"checkUserLogin" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        if ([NSObject getCurrentHost]!=nil||[[NSObject getCurrentHost] isEqualToString:@""]) {
            NSString *url =[NSString stringWithFormat:@"%@/token/validate",[NSObject getCurrentHost]];
            [DRRequest requestHybridPost:url withPrams:nil  whenSuccess:^(id res) {
                NSMutableDictionary *dic1= [NSMutableDictionary dictionaryWithCapacity:10];
                NSString* p2 = [[[res objectForKey:@"status"] objectForKey:@"err_code"] stringValue];
                if ([p2 isEqualToString:@"0"]) {
                    
                    [dic1 setObject:[NSNumber numberWithBool:true] forKey:@"isLogin"];
                    
                }else
                {
                    [dic1 setObject:[NSNumber numberWithBool:false] forKey:@"isLogin"];
                }
                
                NSString*json =  [self converseToJson:dic1];
                responseCallback(json);
                
            } whenFailure:^(NSError *err) {
                NSDictionary *dic = @{@"isLogin":[NSNumber numberWithBool:false]};
                NSString*json =  [self converseToJson:dic];
                responseCallback(json);
            }];
        }else
        {
            NSDictionary *dic = @{@"isLogin":[NSNumber numberWithBool:false]};
            NSString*json =  [self converseToJson:dic];
            responseCallback(json);
        }
        
        
    }];
    
    
    [_bridge registerHandler:@"getBaseInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSString *loginInfo = [self converseToJson:@{@"platform": [NSObject platform],
                                                     @"appVersion": [NSObject appVersion],
                                                     @"system": [NSObject system],
                                                     @"systemVersion":[NSObject systemVersion],
                                                     @"Device":[NSObject iphoneType],
                                                     @"language":[NSObject language],
                                                     @"country":[NSObject country],
                                                     @"deviceID":[NSObject deviceID],
                                                     @"iOS_type":@"23",
                                                     }];
        responseCallback(loginInfo);
        
    }];
    
    [_bridge registerHandler:@"saveUserInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dic =(NSDictionary*)data;
        [NSObject saveUserInfo:dic];
        responseCallback(@"success");
    }];
    [_bridge registerHandler:@"removeUserInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [NSObject removeToken];
        responseCallback(@"success");
    }];
    
    
    [_bridge registerHandler:@"getUserInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSDictionary *dic =  [NSObject getUserInfo];
        NSString *userInfo =   [self converseToJson:dic];
        responseCallback(userInfo);
    }];
    
    [_bridge registerHandler:@"httpServer" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *dic=(NSDictionary*)data;
        NSString *url = dic[@"url"];
        NSDictionary *headers=[dic objectForKey:@"headers"];
        
        if ([NSObject getCurrentHost]!=nil||[[NSObject getCurrentHost] isEqualToString:@""]) {
            url= [NSString stringWithFormat:@"%@%@",[NSObject getCurrentHost],url];
            NSString *method = dic[@"method"];
            NSDictionary *param = dic[@"body"];
            [DRRequest setHeaders:headers];
            if ([method isEqualToString:@"get"]) {
                
                [[WHC_HttpManager shared] get:url
                                      headers:headers
                                  didFinished:^(WHC_BaseOperation * _Nullable operation,
                                                NSData * _Nullable data,
                                                NSError * _Nullable error,
                                                BOOL isSuccess)
                {
                    if (isSuccess) {
                        NSString *result =[[ NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        responseCallback(result);
                    }else
                    {
                        if (error.code==-1009) {
                            NSLog(@"断网");
                            [_bridge callHandler:@"ReachabilityStatusChange" data:@"Bad"];
                        }
                        
                        else
                        {
                            NSDictionary *errorDic =@{@"status":@{@"err_code":@"-1001",@"err_msg":error.description},@"data":@""};
                            NSString *userInfo =   [self converseToJson:errorDic];
                            responseCallback(userInfo);
                        }
                    }
                    
                }];

            }else
            {
                       NSString *paramsttr =  [[WHC_HttpManager shared] createHttpParam:param];
                [[WHC_HttpManager shared] post:url
                                       headers:headers
                                         param:paramsttr
                                   didFinished:^(WHC_BaseOperation *operation,
                                                 NSData *data,
                                                 NSError *error,
                                                 BOOL isSuccess) {
                                       if (isSuccess) {
                                           NSString *result =[[ NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                           responseCallback(result);
                                       }else
                                       {
                                           if (error.code==-1009) {
                                               NSLog(@"断网");
                                               [_bridge callHandler:@"ReachabilityStatusChange" data:@"Bad"];
                                           }
                                           
                                           else
                                           {
                                               //                                              NSLog(@"error.description---%@",error.description);
                                               NSDictionary *errorDic =@{@"status":@{@"err_code":@"-1001",@"err_msg":error.description},@"data":@""};
                                               NSString *userInfo =   [self converseToJson:errorDic];
                                               responseCallback(userInfo);
                                           }
                                       }
                                     
                                       //处理data数据
                                   }];

                
                
            }
        }else
        {
            NSDictionary *errorDic =@{@"status":@{@"err_code":@"1002",@"err_msg":@"host为空"},@"data":@""};
            NSString *userInfo =   [self converseToJson:errorDic];
            responseCallback(userInfo);
        }
        
        
        
    }];
    
    
   
    

    // Do any additional setup after loading the view.
}
#pragma mark - AFN提供的方法
- (void)afnReachabilityTest {
    [[DRAFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(DRAFNetworkReachabilityStatus status) {
        NSLog(@"%@",[NSThread currentThread]);
        // 一共有四种状态
        switch (status) {
            case DRAFNetworkReachabilityStatusNotReachable:
                NSLog(@"AFNetworkReachability Not Reachable");
                [_bridge callHandler:@"ReachabilityStatusChange" data:@"Bad"];
                break;
            case DRAFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"AFNetworkReachability Reachable via WWAN");
                [_bridge callHandler:@"ReachabilityStatusChange" data:@"WLAN"];
                break;
            case DRAFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"AFNetworkReachability Reachable via WiFi");
                [_bridge callHandler:@"ReachabilityStatusChange" data:@"WiFi"];
                break;
            case DRAFNetworkReachabilityStatusUnknown:
                [_bridge callHandler:@"ReachabilityStatusChange" data:@"Unknown"];
            default:
                NSLog(@"AFNetworkReachability Unknown");
                [_bridge callHandler:@"ReachabilityStatusChange" data:@"Unknown"];
                break;
        }
    }];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[DRAFNetworkReachabilityManager sharedManager] startMonitoring];
        [[NSRunLoop currentRunLoop] run];
    });
}
-(void)noti:(NSNotification *)noti

{
    //使用userInfo处理消息
    
    NSDictionary*dic = [noti userInfo];
    
    NSString *info = [dic objectForKey:@"param"];
    if ([info isEqualToString:@"error"]) {
        AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        if (myDelegate.isDismiss==YES) {
            self.web.webview.frame = CGRectMake( 0,  20, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height-20 );
        }else
        {
             self.web.webview.frame = CGRectMake( 0,  20+34, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height-20-34 );
        }
        
        
    }
    else if ([info isEqualToString:@"good"]||[info isEqualToString:@"Notbad"]||[info isEqualToString:@"great"]) {
         self.web.webview.frame = CGRectMake( 0,  20, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height-20 );
        
    }else if ([info isEqualToString:@"bad"])
    {
        AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication]delegate];
        if (myDelegate.isDismiss==YES) {
             self.web.webview.frame = CGRectMake( 0,  20, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height-20 );
        }else
        {
             self.web.webview.frame = CGRectMake( 0,  20+34, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height-20-34 );
        }
        
    }else if ([info isEqualToString:@"dismiss"])
        
    {
         self.web.webview.frame = CGRectMake( 0,  20, [UIScreen mainScreen].bounds.size.width, self.view.frame.size.height-20 );
        
    }
    
    NSLog(@"接收 userInfo传递的消息：%@",info);
    
}
-(void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString*)converseToJson:(NSDictionary*)dictionary
{
    
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization
                        dataWithJSONObject:dictionary
                        options:0
                        error:&error];
    if ([jsonData length] > 0 && error == nil)
    {
        NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    else if ([jsonData length] == 0 && error == nil)
    {
        return nil;
    }
    else if (error != nil)
    {
        return nil;
    }
    else
    {
        return nil;
    }
   // return jsonString;
}
-(HTMLConfigModel *)h5ConfigModel{
    if (!_h5ConfigModel) {
        _h5ConfigModel = [[HTMLConfigModel alloc] init];
        
    }
    return _h5ConfigModel;
}
- (UIView * _Nullable)failViewIn:(WebView * _Nonnull)webView error:(NSError * _Nonnull)error {
    
    UIView *vi=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    vi.backgroundColor=[UIColor redColor];
    return vi;
}


- (NSString * _Nullable)requestVersionWithCurrentVersion:(NSString * _Nonnull)version downloadUrl:(NSURL * _Nonnull )downloadUrl{
    
    __block NSString *string =@"不更新";
    self.h5ConfigModel.version=version;
    self.h5ConfigModel.platform=@"1";
    self.h5ConfigModel.app_type=@"1";
    [DRRequest requestPost:self.h5ConfigModel whenSuccess:^(DRHYModel *m, id res) {

        
        HTMLConfigModel *model =(HTMLConfigModel*)m;
        if (model!=nil&&model.current_host!=nil&&![model.current_host isEqualToString:@""]) {
            [NSObject saveCurrentHost:model.current_host];
        }
        if(model.is_update&&model.is_update!=nil&&![model.is_update isEqualToString:@""])
        {
            if ([model.is_update boolValue]==true) {
                
                string = @"更新";
                if (model.force_update&&model.force_update!=nil&&![model.force_update isEqualToString:@""]) {
                    
                    if([model.force_update boolValue]==true)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            
                            [MBProgressHUD showLoadToView:self.view title:LocalizedString(@"updateConfig", nil)];
                            
                        });
                    }
                    
                }
                NSURL * currentUrl;
                if (m==nil||model.current_host!=nil||![model.current_host isEqualToString:@""]) {
                    currentUrl = downloadUrl;
                    
                }else
                {
                    currentUrl = [NSURL URLWithString:model.zip_url];
                    
                }
                
                [[ResourceManager shared] downloadPackageWithUrl:currentUrl success:^(NSURL * _Nonnull url) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [MBProgressHUD hideHUDForView:self.view];
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:LocalizedString(@"Notice", nil)
                                                                        message:LocalizedString(@"restartApp", nil)
                                                                       delegate:self
                                                              cancelButtonTitle:LocalizedString(@"ok", nil)
                                                              otherButtonTitles:nil];
                        
                        [alert show];
                        
                        
                        
                    });
                    
                    
                    
                    
                    
                } failure:^(NSError * _Nonnull error) {
                    
                }];
            }else
            {
                string = @"不更新";
            }
                
                
            }
            
           
        
        
    } whenFailure:^(NSError *err,id res) {
        string=@"不更新";
        
        
    }];
    
    
    return string;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [self exitApplication ];
    }
}
- (void)exitApplication {
    
    AppDelegate *app = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    UIWindow *window = app.window;
    
    [UIView animateWithDuration:1.0f animations:^{
        
        window.alpha = 0;
        
        window.frame = CGRectMake(0, window.bounds.size.width, 0, 0);
        
    } completion:^(BOOL finished) {
        
     
        exit(0);
        
    }];
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
