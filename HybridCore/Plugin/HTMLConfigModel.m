//
//  HTMLConfigModel.m
//  TheOnePlus
//
//  Created by jilei on 2017/12/7.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import "HTMLConfigModel.h"
@implementation HTMLConfigModel
- (NSString *)getUrl{
    return @"http://47.91.235.141:8081/app/get-version";
}

- (void)parse:(id)obj{
    [super parse:obj];
    NSDictionary *dict = obj[@"data"];
    [self parData:dict];
    
    
}

- (void)parData:(NSDictionary*)dict{
    if(dict!=nil&&[dict isKindOfClass:[NSDictionary class]])
    {
        
        self.current_host = [dict[@"current_host"] description] ;
        self.zip_url = [dict[@"zip_url"] description] ;
        self.platform = [dict[@"platform"] description];
        self.app_type = [dict[@"app_type"] description];
        self.is_update = [dict[@"is_update"] description] ;
        self.version = [dict[@"version"] description] ;
        self.force_update = [dict[@"force_update"] description] ;
    }
    
}
@end
