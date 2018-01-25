//
//  OnlineWebViewController.m
//  TheOnePlus
//
//  Created by jilei on 2017/12/20.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import "OnlineWebViewController.h"
static void *THPWebBrowserContext = &THPWebBrowserContext;
@interface OnlineWebViewController ()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,UIAlertViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)WKWebViewConfiguration *config;
@property(nonatomic, strong) UIProgressView *progressView;
@property(strong,nonatomic) WKWebView *wkWebView;
@end

@implementation OnlineWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addWKWebView];
    [self reloadRequestWebView];
//    WKWebView* webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.view.bounds];
//    webView.navigationDelegate = self;
//
//    // 与webview UI交互代理
//    webView.UIDelegate = self;
//    [self.view addSubview:webView];
//    [self loadExamplePage:webView];
    
    // Do any additional setup after loading the view.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
     scrollView.contentOffset = CGPointMake(0, -20);
    // scrollView.contentOffset = CGPointMake((180, scrollView.contentOffset.y);
// NSLog(@"scrollView.contentOffset---%@",NSStringFromCGPoint(scrollView.contentOffset));
    
}


//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    // 让webview的内容一直居中显示
//    scrollView.contentOffset = CGPointMake((scrollView.contentSize.width - self.view.bounds.size.width) / 2, scrollView.contentOffset.y);http://192.168.1.186:5200/home#index.html   http://47.91.235.141:91/
//}
-(void)reloadRequestWebView
{
   
        //刷新H5
        NSMutableURLRequest *pageLoadRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.186:5200"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.f];
        [_wkWebView loadRequest:pageLoadRequest];
        
  
    
}
#pragma mark - Estimated Progress KVO (WKWebView)

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        NSLog(@"start---estimatedProgress");
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            NSLog(@"end---estimatedProgress");
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)addWKWebView
{
    
    _config = [[WKWebViewConfiguration alloc] init];
    
    // 设置偏好设置
    _config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    _config.preferences.minimumFontSize = 10;
    // 默认认为YES
    _config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    _config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
//    _config
    
    // web内容处理池
    _config.processPool = [[WKProcessPool alloc] init];
    
    WKUserContentController* userContentController = WKUserContentController.new;
    
//    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//
//    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//
//    // 添加自适应屏幕宽度js调用的方法
//
//    [userContentController addUserScript:wkUserScript];
    // 通过JS与webview内容交互
    _config.userContentController = userContentController;
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    
    _wkWebView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:_config];
    
    //    NSString *str_url = self.jumpurl;
    [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:THPWebBrowserContext];
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
    [self.progressView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.progressView.frame.size.height)];
    // 导航代理
    _wkWebView.navigationDelegate = self;
    // 与webview UI交互代理
    _wkWebView.UIDelegate = self;
    [self.view addSubview:_wkWebView];

    
}
- (void)renderButtons:(WKWebView*)webView {
    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
    
    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [callbackButton setTitle:@"Call handler" forState:UIControlStateNormal];
    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:callbackButton aboveSubview:webView];
    callbackButton.frame = CGRectMake(10, 400, 100, 35);
    callbackButton.titleLabel.font = font;
    
    UIButton* reloadButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [reloadButton setTitle:@"Reload webview" forState:UIControlStateNormal];
    [reloadButton addTarget:webView action:@selector(reload) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:reloadButton aboveSubview:webView];
    reloadButton.frame = CGRectMake(110, 400, 100, 35);
    reloadButton.titleLabel.font = font;
}
- (void)loadExamplePage:(WKWebView*)webView {
    //    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    //    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    //    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://47.91.235.141:91/"]]];
}
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic]) {
        
        if ([challenge previousFailureCount] == 0) {
            
           // NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
             NSURLCredential *credential = [[NSURLCredential alloc] initWithUser:@"theonedev" password:@"ZAskrG" persistence:NSURLCredentialPersistenceForSession];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
            
        } else {
            
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
            
        }
        
    } else {
        
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        
    }
}
#pragma mark WKNavigationDelegate
// 在JS端调用alert函数时，会触发此代理方法。
// JS端调用alert时所传的数据可以通过message拿到
// 在原生得到结果后，需要回调JS，是通过completionHandler回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          completionHandler();
                      }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}
// JS端调用confirm函数时，会触发此方法
// 通过message可以拿到JS端所传的数据
// 在iOS端显示原生alert得到YES/NO后
// 通过completionHandler回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"confirm" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
