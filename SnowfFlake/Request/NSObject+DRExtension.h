//
//  NSObject+DRExtension.h
//  DeepCubeRobotControls
//
//  Created by zoff on 2017/6/6.
//  Copyright © 2017年 zoff. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DRextension)

// 空函数
- (void)pass;

- (void)updateData;

- (void)onInit;
-(id)EmptyCheckobjnil;
+(NSDictionary*)infoDictionary;
+ (NSString*)platform;
+ (NSString*)appVersion;
+ (NSString*)system;
+ (NSString*)systemVersion;
+ (NSString*)language;
+ (NSString*)country;
+ (NSString*)iphoneType;
+(void)removeUserInfo;
+(NSDictionary*)getUserInfo;
+(void)saveUserInfo:(NSDictionary*)dic;
+ (NSString *)deviceIPAdress;
+ (NSString*)deviceID;
+(NSString*)getUserToken;
+(NSString*)getUserID;
+(void)removeToken;
+(void)saveCurrentHost:(NSString*)host;
+(NSString*)getCurrentHost;
@end

@interface NSString (DRextension)

//判断字符串长度
- (NSUInteger)unicodeLengthOfString;

// 返回 string 数据
- (NSString*)stringValue;
- (time_t)timestampValue;

// 安全判断是不是为空
- (BOOL)notEmpty;

// 安全比较两个字符创
+ (BOOL)IsEqual:(NSString*)l ToString:(NSString*)r;

- (NSString*)md5;

//字.length=2   a.length=1
- (NSUInteger)convertToInt;

//计算字符串高度
- (CGFloat)heightForSize:(float)fontSize andWidth:(float)width;

@end


@interface NSArray (DRExtension)

- (id)firstObject;
- (id)objectAfter:(id)obj;
- (id)objectBefore:(id)obj;

//安全读取数据
- (id)objectAtIndexSafe:(NSUInteger)index;
- (id)objectAtIndex:(NSUInteger)index def:(id)def;

// 反转
- (NSArray*)reversedArray;
@end


@interface NSDictionary (DRextension)

// 使用转换器转换
+ (instancetype)dictionaryFromArray:(NSArray*)arr keyConverter:(id (^)(id))keyConverter valueConverter:(id (^)(id))valueConverter;

- (BOOL)exists:(id<NSCopying>)key;
- (id)objectForKey:(id)aKey def:(id)def;
- (id)valueForKey:(NSString*)key def:(id)def;

- (int)getInt:(id<NSCopying>)key;
- (int)getInt:(id<NSCopying>)key def:(int)def;

- (int)getBool:(id<NSCopying>)key;
- (int)getBool:(id<NSCopying>)key def:(bool)def;

- (time_t)getTimestamp:(id<NSCopying>)key def:(time_t)def;

- (NSString*)getString:(id<NSCopying>)key;
- (NSString*)getString:(id<NSCopying>)key def:(NSString*)def;

- (NSArray*)getArray:(id<NSCopying>)key;
- (NSArray*)getArray:(id<NSCopying>)key def:(NSArray*)def;

- (NSDictionary*)getDictionary:(id<NSCopying>)key;
- (NSDictionary*)getDictionary:(id<NSCopying>)key def:(NSDictionary*)def;

- (id)objectForInt:(NSInteger)idx;

// 返回安全的对象，如果 obj 为 NSNull，返回的将是 nil
- (id)objectForKeySafe:(id<NSCopying>)key;

@end

extern NSString* kNSDateStyleMySQLDR;

@interface NSDate (DRextension)

// 初始化
- (id)initWithTimestamp:(time_t)t;
- (time_t)timestamp;

// 间隔
- (NSTimeInterval)timeDifference:(NSDate*)other;

// 从 string 转换
+ (id)dateWithString:(NSString*)str style:(NSString*)style;

// 按照 style 转换
- (NSString*)styleString:(NSString*)style;

// 取得当前时区的ymd
- (NSUInteger)year;
- (NSUInteger)month;
- (NSUInteger)day;
- (NSUInteger)hour;
- (NSUInteger)minute;
- (NSUInteger)second;

// 是否是同一天
- (BOOL)isSameDay:(NSDate*)r;

@end


@interface NSTimeDR: NSObject {
    struct tm* _tm;
    
}

@property (nonatomic, assign) time_t timestamp;
@property (nonatomic, assign) BOOL neg;

- (id)init;
- (id)initWithTimestamp:(time_t)t;
- (id)initWithDate:(NSDate*)date;

+ (id)timeWithDate:(NSDate*)date;
+ (NSTimeDR*)timeWithString:(NSString*)str style:(NSString*)style;
+ (NSTimeDR*)timeWithTimestamp:(time_t)t;

- (NSTimeDR*)difference:(NSTimeDR*)other;

+ (time_t)Now;
+ (id)time;
+ (id)TodayBegin;
+ (id)TodayEnd;
- (id)dayBegin;
- (id)dayEnd;
- (NSString*)prettyWeekDay;

// 自1970
@property (nonatomic, readonly) int yeard;

// 实际
@property (nonatomic, readonly) int year;

@property (nonatomic, readonly) int month;
@property (nonatomic, readonly) int day;
@property (nonatomic, readonly) int weekday;
@property (nonatomic, readonly) int hour;
@property (nonatomic, readonly) int minute;
@property (nonatomic, readonly) int second;

+ (void)SleepSecond:(NSTimeInterval)ti;
+ (void)SleepMilliSecond:(NSTimeInterval)ti;

// 本周剩余天数
- (int)weekfree;

// 是否未来、过去
- (BOOL)isFuture;
- (BOOL)isForetime;

@end

@interface NSTimeDR (DRpretty)

// 可读性强的文字
- (NSString*)prettyString;

// 可读性强的距离当前多少的文字
- (NSString*)prettyDistanceString;

// 跟微信显示一致
- (NSString *)prettyStringWeixin;

// 疯游精显示规则
- (NSString *)prettyFYJ;

//聊天消息格式 05-21 05 ： 23
- (NSString *)messageFormat;
@end

@interface NSMutableTime : NSTimeDR

@property (nonatomic, assign) int yeard;

// 实际
@property (nonatomic, assign) int year;

@property (nonatomic, assign) int month;
@property (nonatomic, assign) int day;
@property (nonatomic, assign) int hour;
@property (nonatomic, assign) int minute;
@property (nonatomic, assign) int second;

@end


