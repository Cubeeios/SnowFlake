//
//  NSObject+DRExtension.m
//  DeepCubeRobotControls
//
//  Created by zoff on 2017/6/6.
//  Copyright © 2017年 zoff. All rights reserved.
//

#import "NSObject+DRExtension.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "getUUID.h"
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
@implementation NSObject (DRextension)

- (void)onInit
{
}

- (void)updateData
{
}

- (void)pass
{
}


-(id)EmptyCheckobjnil
{
    if (self==nil)
    {
        return @"";
    }
    else if ([self isKindOfClass:[NSString class]])
    {
        if ([self isEqual:[NSNull null]]) {
            return @"";
        }
        else if (self==nil)
        {
            return @"";
        }
        else {
            return self;
        }
        
    }
    else
    {
        if ([self isEqual:[NSNull null]]) {
            return @"";
        }
        else if (self==nil)
        {
            return @"";
        }
        else {
            return self;
        }
    }
    return self;
}
+(NSDictionary*)infoDictionary
{
   NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return infoDictionary;
}
+ (NSString*)platform
{
   NSDictionary *infoDictionary= [self infoDictionary];
    NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSLog(@"appCurName:%@",appCurName);
    return @"theoneplus";
}
+ (NSString*)appVersion
{
    NSDictionary *infoDictionary= [self infoDictionary];
    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",appCurVersion);
    return appCurVersion;
}
+ (NSString*)system
{
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    NSLog(@"设备名称: %@",deviceName );
    return deviceName;
}
+ (NSString*)systemVersion
{
      NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    NSLog(@"phoneVersion: %@",phoneVersion );
    return phoneVersion;
}
+ (NSString*)language
{
    NSArray *languageArray = [NSLocale preferredLanguages];
    NSString *language = [languageArray objectAtIndex:0];
    NSLog(@"语言：%@", language);//en
    return language;
}
+ (NSString*)deviceID
{
    NSString *uuid = [getUUID getUUID];
    NSLog(@" uuid  is  ---> %@",[getUUID getUUID]);
    return uuid;
}
+ (NSString*)country
{
    NSLocale *locale = [NSLocale currentLocale];
    NSString *country = [locale localeIdentifier];
    NSLog(@"国家：%@", country); //en_US
    return country;
}
+ (NSString*)iphoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"]) return@"2G";
    
    if([platform isEqualToString:@"iPhone1,2"]) return@"3G";
    
    if([platform isEqualToString:@"iPhone2,1"]) return@"3GS";
    
    if([platform isEqualToString:@"iPhone3,1"]) return@"4";
    
    if([platform isEqualToString:@"iPhone3,2"]) return@"4";
    
    if([platform isEqualToString:@"iPhone3,3"]) return@"4";
    
    if([platform isEqualToString:@"iPhone4,1"]) return@"4S";
    
    if([platform isEqualToString:@"iPhone5,1"]) return@"5";
    
    if([platform isEqualToString:@"iPhone5,2"]) return@"5";
    
    if([platform isEqualToString:@"iPhone5,3"]) return@"5c";
    
    if([platform isEqualToString:@"iPhone5,4"]) return@"5c";
    
    if([platform isEqualToString:@"iPhone6,1"]) return@"5s";
    
    if([platform isEqualToString:@"iPhone6,2"]) return@"5s";
    
    if([platform isEqualToString:@"iPhone7,1"]) return@"6p";
    
    if([platform isEqualToString:@"iPhone7,2"]) return@"6";
    
    if([platform isEqualToString:@"iPhone8,1"]) return@"6s";
    
    if([platform isEqualToString:@"iPhone8,2"]) return@"6sp";
    
    if([platform isEqualToString:@"iPhone8,4"]) return@"se";
    
    if([platform isEqualToString:@"iPhone9,1"]) return@"7";
    
    if([platform isEqualToString:@"iPhone9,2"]) return@"7p";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"8p";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"8p";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"x";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"x";
    
    if([platform isEqualToString:@"iPad1,1"]) return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"]) return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"]) return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"]) return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"]) return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"]) return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"]) return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"]) return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"]) return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"]) return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"]) return@"iPhone Simulator";
    
    return platform;
    
}
+(void)removeUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"account"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isRemember"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSDictionary*)getUserInfo
{
    NSUserDefaults *defule =[NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithCapacity:10];
    if ([defule objectForKey:@"account"]) {
        [dic setObject:[defule objectForKey:@"account"] forKey:@"account"];
    }
    if ([defule objectForKey:@"password"]) {
        [dic setObject:[defule objectForKey:@"password"] forKey:@"password"];
    }
    if ([defule objectForKey:@"isRemember"]) {
        [dic setObject:[defule objectForKey:@"isRemember"] forKey:@"isRemember"];
    }
    
    return dic;
}
+(NSString*)getUserToken
{
    NSUserDefaults *defule =[NSUserDefaults standardUserDefaults];
  
    NSString *token =@"";
    if ([defule objectForKey:@"accessToken"]) {
       token =[defule objectForKey:@"accessToken"];
         NSLog(@"get token---%@",token);
    }
    
    return token;
}
+(void)removeToken
{
    NSUserDefaults *defule =[NSUserDefaults standardUserDefaults];
    
    if ([defule objectForKey:@"accessToken"]) {
        [defule removeObjectForKey:@"accessToken"];
     
    }
    
}

+(NSString*)getUserID
{
    NSUserDefaults *defule =[NSUserDefaults standardUserDefaults];
    
    NSString *userid =@"";
    if ([defule objectForKey:@"userId"]) {
      
        userid = [defule objectForKey:@"userId"];
    
        NSLog(@"get userId---%@",userid);
    }
    
    return userid;
}

+(void)saveUserInfo:(NSDictionary*)dic
{
    if (dic) {
        if ([dic objectForKey:@"accessToken"]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"accessToken"]  forKey:@"accessToken"];
        }
        if ([dic objectForKey:@"account"]) {
             [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"account"]  forKey:@"account"];
        }
        if ([dic objectForKey:@"isRemember"]) {
             [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"isRemember"]  forKey:@"isRemember"];
        }
        if ([dic objectForKey:@"password"]) {
             [[NSUserDefaults standardUserDefaults] setObject:[dic objectForKey:@"password"]  forKey:@"password"];
        }
        if ([dic objectForKey:@"userId"]) {
             NSString *userid = [[dic objectForKey:@"userId"] stringValue];
            [[NSUserDefaults standardUserDefaults] setObject:userid  forKey:@"userId"];
        }
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(void)saveCurrentHost:(NSString*)host
{
    if (host!=nil&&![host isEqualToString:@""]) {
      
            
   [[NSUserDefaults standardUserDefaults] setObject:host  forKey:@"currentHost"];
       
    [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
+(NSString*)getCurrentHost
{
    NSUserDefaults *defule =[NSUserDefaults standardUserDefaults];
    
    NSString *host =@"";
    if ([defule objectForKey:@"currentHost"]) {
        
        host = [defule objectForKey:@"currentHost"];
        
        NSLog(@"get userId---%@",host);
    }
    return host;
}
// ------获取当前设备的IP地址
+ (NSString *)deviceIPAdress {
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            int len = sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            ifrcopy = *ifr;
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    NSString *deviceIP = @"";
    
    for (int i=0; i < ips.count; i++) {
        if (ips.count > 0) {
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    return deviceIP;
    
    
}

@end

@implementation NSString (DRextension)


//判断字符串长度
- (NSUInteger)unicodeLengthOfString
{
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < self.length; i++) {
        
        unichar uc = [self characterAtIndex:i];
        
        asciiLength += isascii(uc) ? 1 : 2;
    }
    
    NSUInteger unicodeLength = asciiLength / 2;
    
    if (asciiLength % 2) {
        unicodeLength++;
    }
    
    return unicodeLength;
}

- (NSString*)stringValue
{
    return self;
}

- (time_t)timestampValue
{
    return (time_t)[self longLongValue];
}

- (BOOL)notEmpty
{
    if ([self isEqualToString:@""])
        return NO;
    if (self.length != 0) {
        return [self stringByReplacingOccurrencesOfString:@" " withString:@""].length != 0;
    }
    return self.length != 0;
}

+ (BOOL)IsEqual:(NSString*)l ToString:(NSString*)r
{
    if (l == nil && r == nil)
        return YES;
    
    return [l isEqualToString:r];
}

- (NSString*)md5
{
    const char* str = [self UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString* filename = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return filename;
}

- (NSUInteger)convertToInt
{
    if (!self.notEmpty) {
        return 0;
    }
    //    //********部分特殊汉字判断出错，例如 蜀 的长度就判断为1
    //    NSUInteger strlength = 0;
    //    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    //    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
    //        if (*p) {
    //            p++;
    //            strlength++;
    //        }
    //        else {
    //            p++;
    //        }
    //    }
    //    return strlength;
    //    //********end
    
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < self.length; i++) {
        
        unichar uc = [self characterAtIndex:i];
        
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

- (CGFloat)heightForSize:(float)fontSize andWidth:(float)width
{
    CGSize sizeToFit = [self sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping]; //此处的换行类型（lineBreakMode）可根据自己的实际情况进行设置
    return sizeToFit.height;
}
@end


@implementation NSArray (DRExtension)

- (id)objectAtIndexSafe:(NSUInteger)index
{
    if (self.count <= index)
        return nil;
    id ret = [self objectAtIndex:index];
    if ([ret isKindOfClass:[NSNull class]])
        return nil;
    return ret;
}

- (id)objectAtIndex:(NSUInteger)index def:(id)def
{
    if (index >= self.count)
        return def;
    id ret = [self objectAtIndexSafe:index];
    if (ret == nil)
        return def;
    return ret;
}

- (id)objectAfter:(id)obj
{
    NSInteger idx = [self indexOfObject:obj];
    if (idx == NSNotFound)
        return nil;
    return [self objectAtIndex:(idx + 1)def:nil];
}

- (id)objectBefore:(id)obj
{
    NSInteger idx = [self indexOfObject:obj];
    if (idx == NSNotFound)
        return nil;
    return [self objectAtIndex:(idx - 1)def:nil];
}

- (id)firstObject
{
    return [self objectAtIndex:0 def:nil];
}

- (NSArray*)reversedArray
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator* enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}

@end


@implementation NSDictionary (DRextension)

- (instancetype)clone
{
    return [self.class dictionaryWithDictionary:self];
}

+ (instancetype)dictionaryFromArray:(NSArray*)arr keyConverter:(id (^)(id))keyConverter valueConverter:(id (^)(id))valueConverter
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionaryWithCapacity:arr.count];
    for (id each in arr) {
        id key = keyConverter(each);
        id val = valueConverter(each);
        if (key && val)
            [dict setObject:val forKey:key];
    }
    return dict;
}

- (BOOL)exists:(id<NSCopying>)key
{
    return [self objectForKeySafe:key] != nil;
}

- (id)objectForKey:(id)aKey def:(id)def
{
    id ret = [self objectForKeySafe:aKey];
    if (ret == nil)
        return def;
    return ret;
}

- (id)valueForKey:(NSString*)key def:(id)def
{
    id ret = [self objectForKeySafe:key];
    if (ret == nil)
        return def;
    return ret;
}

- (int)getInt:(id<NSCopying>)key
{
    return [self getInt:key def:0];
}

- (int)getInt:(id<NSCopying>)key def:(int)def
{
    id obj = [self objectForKeySafe:key];
    if (obj == nil)
        return def;
    return [obj intValue];
}

- (int)getBool:(id<NSCopying>)key
{
    return [self getBool:key def:false];
}

- (int)getBool:(id<NSCopying>)key def:(bool)def
{
    id obj = [self objectForKeySafe:key];
    if (obj == nil)
        return def;
    return [obj boolValue];
}

- (time_t)getTimestamp:(id<NSCopying>)key def:(time_t)def
{
    id obj = [self objectForKeySafe:key];
    if (obj == nil)
        return def;
    return [obj timestampValue];
}

- (NSString*)getString:(id<NSCopying>)key
{
    return [self getString:key def:@""];
}

- (NSString*)getString:(id<NSCopying>)key def:(NSString*)def
{
    id obj = [self objectForKeySafe:key];
    if (obj == nil || obj == [NSNull null])
        return def;
    return [obj stringValue];
}

- (NSArray*)getArray:(id<NSCopying>)key
{
    return [self getArray:key def:nil];
}

- (NSArray*)getArray:(id<NSCopying>)key def:(NSArray*)def
{
    id ret = [self objectForKeySafe:key];
    if (ret == nil || ret == [NSNull null])
        return def;
    if (![ret isKindOfClass:[NSArray class]]) {
        return def;
    }
    return ret;
}

- (NSDictionary*)getDictionary:(id<NSCopying>)key
{
    return [self getDictionary:key def:nil];
}

- (NSDictionary*)getDictionary:(id<NSCopying>)key def:(NSDictionary*)def
{
    id ret = [self objectForKeySafe:key];
    if (ret == nil || ret == [NSNull null])
        return def;
    if (![ret isKindOfClass:[NSDictionary class]]) {
        return def;
    }
    return ret;
}

- (id)objectForKeySafe:(id<NSCopying>)key
{
    id ret = [self objectForKey:key];
    if ([ret isKindOfClass:[NSNull class]])
        return nil;
    return ret;
}

- (id)objectForInt:(NSInteger)idx
{
    return [self objectForKeySafe:[NSNumber numberWithInteger:idx]];
}

+ (instancetype)restrict:(id)obj
{
    if ([obj isKindOfClass:[NSDictionary class]])
        return obj;
    if ([obj isKindOfClass:[NSMutableDictionary class]])
        return obj;
    return nil;
}
@end

NSString* kNSDateStyleMySQLDR = @"yyyy-MM-dd HH:mm:ss";

@implementation NSDate (DRextension)

- (id)initWithTimestamp:(time_t)t {
    self = [self initWithTimeIntervalSince1970:(NSTimeInterval)t];
    return self;
}

- (time_t)timestamp {
    return [self timeIntervalSince1970];
}

- (NSTimeInterval)timeDifference:(NSDate *)other {
    NSTimeInterval ret = [self timeIntervalSinceDate:other];
    return fabs(ret);
}

+ (id)dateWithString:(NSString*)str style:(NSString*)style {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    df.dateFormat = style;
    id ret = [df dateFromString:str];
    return ret;
}

- (NSString*)styleString:(NSString*)style {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    df.dateFormat = style;
    id ret = [df stringFromDate:self];
    return ret;
}

- (BOOL)isSameDay:(NSDate*)r {
    NSDateComponents *lc = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    NSDateComponents *rc = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:r];
    return lc.year == rc.year &&
    lc.month == rc.month &&
    lc.day == rc.day;
}

- (NSUInteger)year {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self];
    return [components year];
}

- (NSUInteger)month {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self];
    return [components month];
}

- (NSUInteger)day {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self];
    return [components day];
}

- (NSUInteger)hour {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self];
    return [components hour];
}

- (NSUInteger)minute {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self];
    return [components minute];
}

- (NSUInteger)second {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self];
    return [components second];
}

@end



@implementation NSTimeDR


@synthesize timestamp = _timestamp;

- (id)init {
    self = [super init];
    
    _tm = (struct tm*)calloc(sizeof(struct tm), 1);
    self.timestamp = time(NULL);
    
    return self;
}

- (id)initWithTimestamp:(time_t)t {
    self = [super init];
    
    _tm = (struct tm*)calloc(sizeof(struct tm), 1);
    self.timestamp = t;
    
    return self;
}

- (id)initWithUTCTimestamp:(time_t)t {
    self = [super init];
    
    _tm = (struct tm*)calloc(sizeof(struct tm), 1);
    [self setUTCTimestamp:t];
    
    return self;
}

- (id)initWithDate:(NSDate *)date {
    self = [super init];
    
    _tm = (struct tm*)calloc(sizeof(struct tm), 1);
    self.timestamp = date.timeIntervalSince1970;
    
    return self;
}

+ (id)timeWithDate:(NSDate*)date {
    return [[[self class] alloc] initWithDate:date];
}

+ (NSTimeDR*)timeWithString:(NSString*)str style:(NSString*)style {
    return [NSTimeDR timeWithDate:[NSDate dateWithString:str style:style]];
}

+ (NSTimeDR*)timeWithTimestamp:(time_t)t {
    return [[[self class] alloc] initWithTimestamp:t];
}

- (void)setTimestamp:(time_t)timestamp {
    _timestamp = timestamp;
    
    struct tm* tmp = localtime(&_timestamp);
    memcpy(_tm, tmp, sizeof(struct tm));
}

- (void)setUTCTimestamp:(time_t)timestamp {
    _timestamp = timestamp;
    
    struct tm* tmp = gmtime(&_timestamp);
    memcpy(_tm, tmp, sizeof(struct tm));
}

- (void)dealloc {
    free(_tm);
}

+ (time_t)Now {
    return time(NULL) - 1;
}

+ (id)time {
    return [[[self class] alloc] init];
}

+ (id)TodayBegin {
    time_t now = time(NULL);
    struct tm* tmp = localtime(&now);
    tmp->tm_hour = 0;
    tmp->tm_min = 0;
    tmp->tm_sec = 0;
    now = timelocal(tmp);
    return [[[self class] alloc] initWithTimestamp:now];
}

+ (id)TodayEnd {
    time_t now = time(NULL);
    struct tm* tmp = localtime(&now);
    tmp->tm_hour = 23;
    tmp->tm_min = 59;
    tmp->tm_sec = 59;
    now = timelocal(tmp);
    return [[[self class] alloc] initWithTimestamp:now];
}

- (id)dayBegin {
    struct tm tmp;
    memcpy(&tmp, _tm, sizeof(tmp));
    tmp.tm_hour = 0;
    tmp.tm_min = 0;
    tmp.tm_sec = 0;
    time_t now = timelocal(&tmp);
    return [[[self class] alloc] initWithTimestamp:now];
}

- (id)dayEnd {
    struct tm tmp;
    memcpy(&tmp, _tm, sizeof(tmp));
    tmp.tm_hour = 23;
    tmp.tm_min = 59;
    tmp.tm_sec = 59;
    time_t now = timelocal(&tmp);
    return [[[self class] alloc] initWithTimestamp:now];
}

- (NSTimeDR*)difference:(NSTimeDR *)other {
    time_t d = _timestamp - other->_timestamp;
    BOOL neg = NO;
    if (d < 0) {
        d = -d;
        neg = YES;
    }
    NSTimeDR* ret = [[NSTimeDR alloc] initWithUTCTimestamp:d];
    ret.neg = neg;
    return ret ;
}

- (int)yeard {
    if (_tm)
        return _tm->tm_year - 70;
    return 0;
}

- (int)year {
    if (_tm)
        return _tm->tm_year + 1900;
    return 0;
}

- (int)month {
    if (_tm)
        return _tm->tm_mon;
    return 0;
}

- (int)day {
    if (_tm)
        return _tm->tm_mday - 1;
    return 0;
}

- (int)weekday {
    if (_tm) {
        if (_tm->tm_wday == 0)
            return 6;
        return _tm->tm_wday - 1;
    }
    return 0;
}

- (int)hour {
    if (_tm)
        return _tm->tm_hour;
    return 0;
}

- (int)minute {
    if (_tm)
        return _tm->tm_min;
    return 0;
}

- (int)second {
    if (_tm)
        return _tm->tm_sec;
    return 0;
}

+ (void)SleepSecond:(NSTimeInterval)ti {
    [NSTimeDR SleepMilliSecond:ti * 1e3];
}

+ (void)SleepMilliSecond:(NSTimeInterval)ti {
    usleep(ti * 1e3);
}

- (BOOL)isFuture {
    return _timestamp > time(NULL);
}

- (BOOL)isForetime {
    time_t now = time(NULL);
    return _timestamp < now;
}

- (NSString*)prettyYear {
    if (self.yeard == 1)
        return @"去年";
    else if (self.yeard == 2)
        return @"前年";
    return [NSString stringWithFormat:@"%d年", self.year];
}

- (NSString*)prettyDay {
    if (self.day == 0)
        return @"今天";
    else if (self.day == 1) {
        if (self.neg)
            return @"昨天";
        else
            return @"明天";
    } else if (self.day == 2) {
        if (self.neg)
            return @"前天";
        else
            return @"后天";
    }
    return @(self.day).stringValue;
}

- (NSString*)prettyWeekDay {
    NSString* ret = @"";
    switch (_tm->tm_wday) {
        case 1: ret = @"星期一"; break;
        case 2: ret = @"星期二"; break;
        case 3: ret = @"星期三"; break;
        case 4: ret = @"星期四"; break;
        case 5: ret = @"星期五"; break;
        case 6: ret = @"星期六"; break;
        case 0: ret = @"星期日"; break;
    }
    return ret;
}

- (int)weekfree {
    return 6 - self.weekday;
}

- (NSDate*)dateValue {
    return [NSDate dateWithTimeIntervalSince1970:self.timestamp];
}

- (NSString*)stringValue {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.timeZone = [NSTimeZone timeZoneWithName:@"Aisa/Shanghai"];
    df.dateFormat = kNSDateStyleMySQLDR;
    NSString* ret = [df stringFromDate:[self dateValue]];
    return ret;
}

@end

@implementation NSTimeDR (DRpretty)
- (NSString *)prettyFYJ
{
    NSMutableString* ret = [NSMutableString string];
    NSTimeDR* today = [NSTimeDR TodayBegin];
    NSTimeDR* dt = [[self dayBegin] difference:today];
    if(dt.yeard == 0)
    {
        if(dt.day < 7)
        {
            if(dt.day <= 0)
            {
                [ret appendFormat:@" %02d:%02d", self.hour, self.minute];
            }
            else
            {
                [ret appendFormat:@"%d天以前",dt.day];
            }
        }
        else
        {
            [ret appendFormat:@"%02d月%02d日",self.month + 1, self.day + 1];
        }
    }
    else
    {
        [ret appendFormat:@"%d年%02d月%02d日",self.year, self.month + 1, self.day + 1];
    }
    return ret;
}
- (NSString*)prettyString {
    NSMutableString* ret = [NSMutableString string];
    NSTimeDR* today = [NSTimeDR TodayBegin];
    NSTimeDR* dt = [[self dayBegin] difference:today];
    if (dt.yeard == 0) {
        if (dt.month == 0) {
            if (dt.day < 3) {
                [ret appendString:dt.prettyDay];
                [ret appendFormat:@" %02d:%02d", self.hour, self.minute];
                return ret;
            }
            
            if (dt.day <= today.weekday ||
                dt.day < today.weekfree) {
                [ret appendString:@"本"];
                [ret appendString:self.prettyWeekDay];
                [ret appendFormat:@" %02d:%02d", self.hour, self.minute];
                return ret;
            }
            
            if (dt.neg) {
                if (dt.day <= today.weekday + 7) {
                    [ret appendString:@"上"];
                    [ret appendString:self.prettyWeekDay];
                    [ret appendFormat:@" %02d:%02d", self.hour, self.minute];
                    return ret;
                }
            } else {
                if (dt.day <= today.weekfree + 7) {
                    [ret appendString:@"下"];
                    [ret appendString:self.prettyWeekDay];
                    [ret appendFormat:@" %02d:%02d", self.hour, self.minute];
                    return ret;
                }
            }
            
            [ret appendFormat:@"%02d-%02d", self.month + 1, self.day + 1];
            [ret appendFormat:@" %02d:%02d", self.hour, self.minute];
            return ret;
            
        } else {
            return [self stringValue];
        }
    }
    else {
        return [self stringValue];
    }
    return @"";
}

- (NSString*)prettyDistanceString {
    NSTimeDR* ct = [[NSTimeDR alloc] init];
    NSTimeDR* dt = [self difference:ct];
    NSMutableString* strtime = [NSMutableString string];
    
    if (dt.yeard)
        [strtime appendFormat:@"%d年", dt.yeard];
    if (dt.month)
        [strtime appendFormat:@"%d月", dt.month];
    if (dt.day)
        [strtime appendFormat:@"%d天", dt.day];
    if (dt.hour)
        [strtime appendFormat:@"%d小时", dt.hour];
    if (dt.minute)
        [strtime appendFormat:@"%d分", dt.minute];
    if (strtime.notEmpty) {
        if (dt.neg)
            [strtime appendString:@"前"];
        else
            [strtime appendString:@"后"];
    } else {
        if (dt.neg)
            [strtime appendString:@"刚刚"];
        else
            [strtime appendString:@"稍后"];
    }
    return strtime;
}
- (NSString *)prettyStringWeixin
{
    NSMutableString* strtime = [NSMutableString string];
    NSTimeDR* ct = [[NSTimeDR alloc] init];
    NSTimeDR* dt = [self difference:ct];
    if (dt.month == 0 &&
        dt.yeard == 0 &&
        dt.day == 0 &&
        dt.hour == 0) {
        if (dt.minute < 1) {
            [strtime appendFormat:@"刚刚"];
        }
        else if(dt.hour < 1)
        {
            [strtime appendFormat:@"%d分钟前",dt.minute];
        }
        else
        {
            [strtime appendFormat:@" %d:%02d", self.hour, self.minute];
        }
    }
    else
    {
        NSTimeDR* today = [NSTimeDR TodayBegin];
        NSTimeDR* dt = [[self dayBegin] difference:today];
        if (dt.day == 0) {
            [strtime appendFormat:@" %d:%02d", self.hour, self.minute];
        } else if (dt.day == 1 && dt.neg) {
            [strtime appendString:@"昨天"];
            [strtime appendFormat:@" %d:%02d", self.hour, self.minute];
        }
        else if(dt.day >= 2 && dt.day < 7)
        {
            [strtime appendFormat:@"%@",self.prettyWeekDay];
        }
        else  {
            [strtime appendFormat:@"%d:%d:%02d",self.year, self.month + 1, self.day + 1];
        }
    }
    return strtime;
}

- (NSString *)messageFormat
{
    NSMutableString* strtime = [NSMutableString string];
    
    [strtime appendFormat:@"%02d-%02d %02d:%02d", self.month + 1, self.day + 1,self.hour,self.minute];
    
    return strtime;
}

@end
