//
//  DRHYModel.m
//  DeepCubeRobotControls
//
//  Created by zoff on 2017/6/9.
//  Copyright © 2017年 zoff. All rights reserved.
//

#import "DRHYModel.h"
#import <objc/runtime.h>
@implementation DRHYModel


-(void)parse:(id)obj
{
    [super parse:obj];
}
//Model 到字典
- (NSDictionary *)properties_aps
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}
@end
