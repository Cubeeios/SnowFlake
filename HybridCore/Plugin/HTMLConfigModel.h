//
//  HTMLConfigModel.h
//  TheOnePlus
//
//  Created by jilei on 2017/12/7.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestHYModel.h"
#import "DRHYModel.h"
@interface HTMLConfigModel : DRHYModel

@property (nonatomic,copy)NSString *is_update;
@property (nonatomic,copy)NSString *force_update;//是否强制更新
@property (nonatomic,copy)NSString *version; //zip版本号

@property (nonatomic,copy)NSString *current_host;//当前使用的域
@property (nonatomic,copy)NSString *zip_url;//zip包的下载链接
@property (nonatomic,copy)NSString *platform; //iOS =1 。Android=2；
@property (nonatomic,copy)NSString *app_type;//平台类型，比如说theoneplus lat1  lat2 等等
@end
