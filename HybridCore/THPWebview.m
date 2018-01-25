//
//  THPWebview.m
//  TheOnePlus
//
//  Created by jilei on 2017/12/13.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import "THPWebview.h"
#import "SnowfFlake-Swift.h"
@interface THPWebview()
@property(nonatomic,strong)GCDWebServer *server;
@end
@implementation THPWebview

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)loadFileURL:(NSURL*)URL allowingReadAccessTo:(NSURL*)readAccessURL
{
    if (![Util isFolderWithUrl:readAccessURL]) {
        [Logger LogError:[NSString stringWithFormat:@"不是文件夹:%@",readAccessURL.path]];
    
    }
    NSError *error;
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSURLRelationship outRelationship;
    [fileManager getRelationship:&outRelationship ofDirectoryAtURL:readAccessURL toItemAtURL:URL error:&error];
    if (error) {
        [Logger LogError:[NSString stringWithFormat:@"获取文件关系失败: :%@",error]];
    }
    if (outRelationship==NSURLRelationshipOther) {
         [Logger LogError:[NSString stringWithFormat:@"%@目录中必须包含: :%@文件",readAccessURL.path,URL.path]];
 
    }
    
    NSInteger port = 8008;
    if (!self.server.isRunning) {
        [self.server addGETHandlerForBasePath:@"/" directoryPath:readAccessURL.path indexFilename:nil cacheAge:3600 allowRangeRequests:YES];
        [self.server startWithPort:port bonjourName:nil];
        
    }
    NSURLComponents *urlConponment =[NSURLComponents componentsWithString:@"http://127.0.0.1"];
    urlConponment.port = [NSNumber numberWithInteger:port] ;
    urlConponment.path = RootHtml ;

    NSURL *url =urlConponment.URL;
    if (url) {
        NSURLRequest *requets =[NSURLRequest requestWithURL:url];
        [self.webview loadRequest:requets];
        
    }else
    {
        
    }
    
}
-(void)load:(NSString*)routeUrl
{
    NSURL *downloadUrl = [[Router shared] downloadUrlWith:routeUrl];
    NSString *loaclPathStr =[[ResourceManager shared] appLocalPathWithRoute:routeUrl];
    NSString *version =[[ResourceManager shared] appVersionWithRoute:routeUrl];
    if (version) {
        [self loadUrl:[NSURL fileURLWithPath:loaclPathStr]];
        if (self.tpdelegate) {
            [self.tpdelegate requestVersionWithCurrentVersion:version downloadUrl:downloadUrl];
        }
    }else
    {
        [[ResourceManager shared] downloadPackageWithUrl:downloadUrl success:^(NSURL * _Nonnull url) {
            [self loadUrl:url];
        } failure:^(NSError * _Nonnull error) {
        
            
        }];
    }
    
    
    
}
-(void)loadUrl:(NSURL*)routeUrl{
    if (routeUrl.isFileURL) {
      
        if ( [Util isFolderWithUrl:routeUrl]) {
            NSURL *  infoUrl =[routeUrl URLByAppendingPathComponent:@"webapp_info.json"];
            
             NSFileManager * fileManager = [NSFileManager defaultManager];
            if (![fileManager  fileExistsAtPath:infoUrl.path]) {
                [Logger LogError:[NSString stringWithFormat:@"%@中未找到配置文件:webapp_info.jso",routeUrl.path]];
                return ;
            }
              NSDictionary * profile=  [Util loadJsonObjectFromUrl:infoUrl];
            if (profile==nil) {
                return ;
            }
            if ([profile objectForKey:@"entrance"]) {
                [Logger LogVerbose:[NSString stringWithFormat:@"加载本地资源包:%@ 入口：%@",routeUrl.path,profile[@"entrance"]]];
                NSURL *entranceUrl=[routeUrl URLByAppendingPathComponent:profile[@"entrance"]];
                [self loadFileURL:entranceUrl allowingReadAccessTo:routeUrl];
            }else
            {
                [Logger LogError:[NSString stringWithFormat:@"未指定入口文件:%@",infoUrl.path]];
            }
            
        }    else{
            
            NSURLRequest *requets =[NSURLRequest requestWithURL:routeUrl];
            [self.webview loadRequest:requets];
            
        }
        
    }
    
}
-(void)initWithUrl:(NSURL*)url
{
    [self loadUrl:url];
}
-(UIWebView*)webview
{
    if (!_webview) {
        _webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height)];
    
        
    }
    return _webview;
}
-(GCDWebServer*)server
{
    if (!_server) {
        _server=[[GCDWebServer alloc] init];
        
        
    }
    return _server;
}
    
    @end
    
