//
//  DRHYModel.h
//  DeepCubeRobotControls
//
//  Created by zoff on 2017/6/9.
//  Copyright © 2017年 zoff. All rights reserved.
//

#import "DRRequestApi.h"
#import "RequestHYModel.h"
@interface DRHYModel : RequestHYModel
@property (nonatomic, assign) BOOL      DRshowWaiting;
//Model 到字典
- (NSDictionary *)properties_aps;
@end
