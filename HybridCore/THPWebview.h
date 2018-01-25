//
//  THPWebview.h
//  TheOnePlus
//
//  Created by jilei on 2017/12/13.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GCDWebServer/GCDWebServer.h>
@class THPWebview;
@protocol THPWebviewDelegate <NSObject>

@optional
- (UIView * _Nullable)failViewIn:(THPWebview * _Nonnull)webView error:(NSError * _Nonnull)error;
- (NSString * _Nullable)requestVersionWithCurrentVersion:(NSString * _Nonnull)version downloadUrl:(NSURL * _Nonnull )downloadUrl;

@end

@interface THPWebview : NSObject
@property(nonatomic ,weak)id <THPWebviewDelegate > _Nullable tpdelegate;
@property(nonatomic,strong,)UIWebView *_Nullable webview;

-(void)initWithUrl:( NSURL*_Nullable)url;
-(void)load:(NSString*_Nullable)routeUrl;
@end
