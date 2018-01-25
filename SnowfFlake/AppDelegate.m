//
//  AppDelegate.m
//  TheOnePlus
//
//  Created by jilei on 2017/12/5.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import "AppDelegate.h"
#import "WKWebviewHybridVC.h"
//#import "HybridNSURLProtocol.h"
//#import "YJCustomURLProtocol.h"
#import "SnowfFlake-Swift.h"
#import "THPWebViewController.h"
#import "OnlineWebViewController.h"
#import "NSObject+DRExtension.h"
#import "ZAlertView.h"
#import "ZAlertViewManager.h"
#import "STDPingServices.h"
#import "UIColor+Hexadecimal.h"
@interface AppDelegate ()



@property(nonatomic,strong)WKWebView *wkWebView;

@property(nonatomic, strong) STDPingServices    *pingServices;
@property (nonatomic, assign) double now_time;
@property (nonatomic, strong) NSMutableArray *dataArray;//存储数据
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if ([NSObject getCurrentHost]==nil||[[NSObject getCurrentHost] isEqualToString:@""]) {
          [NSObject saveCurrentHost:CurrentHost];
    }
    self.isDismiss=NO;
    self.window=[[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    self.window.backgroundColor=[UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //ping
    _dataArray = [NSMutableArray array];
    [self getTimeMilliSeconds];

    
    

    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.backgroundColor = [UIColor colorWithHexString:@"#ff553f"];
    
    
     NSString *version = [UIDevice currentDevice].systemVersion;

    
//    OnlineWebViewController *vc =[[OnlineWebViewController  alloc] init];
//    self.window.rootViewController=vc;
    if ([version floatValue]>=9.0) {
        WKWebviewHybridVC *vc =[self LoadWKWebview];
        UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:vc];
        nav.navigationBarHidden=YES;
         self.window.rootViewController=nav;
    }else
    {
        THPWebViewController *vc =[self LoadUIWebview];
        UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:vc];
        nav.navigationBarHidden=YES;
        self.window.rootViewController=nav;
    }

    return YES;
}

#pragma mark - 计算进度，更新动画
- (void)updateProgressAndStartAnimations {
    
    //计算前五次的平均
    double sum = 0;
    for (int i=0; i<_dataArray.count; i++) {
        NSString *str = _dataArray[i];
        double number = str.doubleValue;
        sum += number;
    }
    double aver = sum/20;
     NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:0];
    if (aver>0&&aver<=100) {
    
        [dic setObject:@"great" forKey:@"param"];
        [[ZAlertViewManager shareManager] dismissWithTime:0];
       
        
    }else if (aver>100&&aver<300){
       
         [dic setObject:@"good" forKey:@"param"];
       [[ZAlertViewManager shareManager] dismissWithTime:0];
        
    }else if (aver>300&&aver<500){
    
          [dic setObject:@"Notbad" forKey:@"param"];
       [[ZAlertViewManager shareManager] showWithType:AlertViewTypeError];
        
    }else{
         [dic setObject:@"bad" forKey:@"param"];
         [[ZAlertViewManager shareManager] showWithType:AlertViewTypeError];
       
        
    }

    [_dataArray removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noti" object:nil userInfo:dic];
   
    
}
#pragma Mark - 存储前五次数据
- (void)addDataArray{
    
    if (_dataArray.count <21) {
        [_dataArray addObject:[NSString stringWithFormat:@"%.3f",_now_time]];
    }else if(_dataArray.count == 21){
            [self updateProgressAndStartAnimations];

    }
    
    
}
- (void)Ping_Error {


     [_dataArray removeAllObjects];
    [[ZAlertViewManager shareManager] showWithType:AlertViewTypeError];
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"error" forKey:@"param"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"noti" object:nil userInfo:dic];
    int64_t delayInSeconds = 5.0;      // 延迟的时间
    /*
     *@parameter 1,时间参照，从此刻开始计时
     *@parameter 2,延时多久，此处为秒级，还有纳秒等。10ull * NSEC_PER_MSEC
     */
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // do something
        [self getTimeMilliSeconds];
    });
   
    
}
#pragma mark - 开始监控
- (void)getTimeMilliSeconds {

    __weak typeof(self) weakSelf = self;
    self.pingServices = [STDPingServices startPingAddress:@"www.baidu.com" callbackHandler:^(STDPingItem *pingItem, NSArray *pingItems) {
        BOOL error_bool = NO;
        if (pingItem.status != STDPingStatusFinished) {
            switch (pingItem.status) {
                case STDPingStatusDidStart:
                    //开始
                    break;
                case STDPingStatusDidReceivePacket:
                    _now_time = pingItem.timeMilliseconds;
                    break;
                case STDPingStatusDidTimeout:
                    _now_time = 301;//400的时候都是不可用
                    NSLog(@"timeout");
                    break;
                case STDPingStatusDidFailToSendPacket:
                    _now_time = 301;NSLog(@"faild");
                    break;
                case STDPingStatusDidReceiveUnexpectedPacket:
                    _now_time = 301;NSLog(@"unexpected");
                    break;
                case STDPingStatusError:
                    _now_time = 301;NSLog(@"error");
                    error_bool = YES;
                    break;
                default:
                    break;
            }
        }
        if (!error_bool) {
            [weakSelf addDataArray];
        }else{
            [weakSelf Ping_Error];
        }
    }];
    
}

-(WKWebviewHybridVC*)LoadWKWebview
{
      WKWebviewHybridVC *vc=[[WKWebviewHybridVC alloc] init];
      return vc;
}
-(THPWebViewController*)LoadUIWebview
{
    UIWebView * tempWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString * oldAgent = [tempWebView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString * newAgent = oldAgent;
    if (![oldAgent hasSuffix:@"native_app"])
    {
        newAgent = [oldAgent stringByAppendingString:@"/native_app"];
    }
    NSLog(@"new agent :%@", newAgent);

    NSDictionary * dictionnary = [[NSDictionary alloc] initWithObjectsAndKeys:newAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionnary];
    [[NSUserDefaults standardUserDefaults] synchronize];


    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    [NSURLProtocol registerClass:[YJCustomURLProtocol class]];
    THPWebViewController *vc=[[THPWebViewController alloc] init];
    int cacheSizeMemory = 8*1024*1024; // 4MB
    int cacheSizeDisk = 32*1024*1024; // 32MB
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
    
    
    return vc;
}



- (void)applicationDidReceiveMemoryWarning:(UIApplication*)application
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    self.isDismiss=NO;
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
//    NSLog(@"退出APP");
//     NSLog(@"程序将要退出");
  //  [[NSURLCache sharedURLCache] removeAllCachedResponses];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
