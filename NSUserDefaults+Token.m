//
//  NSUserDefault+Token.m
//  RedScarf
//
//  Created by lishipeng on 15/12/16.
//  Copyright © 2015年 zhangb. All rights reserved.
//

#import "NSUserDefaults+Token.h"

@implementation NSUserDefaults(Token)

+(NSString *) getValue:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:key]) {
        return [defaults objectForKey:key];
    }
    return nil;
}


+(void) setValue:(NSString *)value forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}

+(void) clearValueForKey:(NSString *) key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

+(void) setCommuntityId:(NSString *)communtityId
{
    [NSUserDefaults setValue:communtityId forKey:@"communtityId"];
}

+(void) setCommuntityName:(NSString *)communtityName
{
    [NSUserDefaults setValue:communtityName forKey:@"communtityName"];
}

+(NSString *)getCommuntityId
{
    return [NSUserDefaults getValue:@"communtityId"];
}

+(NSString *)getCommuntityName
{
    return [NSUserDefaults getValue:@"communtityName"];
}

+(void)setPrintedOrders:(NSArray *)array
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:currentDate];
    [defaults setObject:array forKey:na];
    
    [defaults synchronize];
}

+(void)clearLastDayPrint{
    NSDate * date = [NSDate date];//当前时间
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:lastDay];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:na];
    [defaults synchronize];
}

+(NSArray *)getPrintedOrders
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:currentDate];
    NSArray *dic = [defaults valueForKey:na];
    return dic;
}

+(void)setDeviceUid:(NSString *)deviceUid
{
    [NSUserDefaults setValue:deviceUid forKey:@"deviceUid"];
}

+(NSString *)getDeviceUid
{
    return [NSUserDefaults getValue:@"deviceUid"];
}

+(NSMutableDictionary*)getPrintedType
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [defaults valueForKey:@"printedtype"];
    if (!dic) {
        dic = [[NSMutableDictionary alloc] init];
    }
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:currentDate];
    
    NSMutableDictionary *resultDic = [dic valueForKey:na];
    if (!resultDic) {
        resultDic = [[NSMutableDictionary alloc] init];
    }
    
    return resultDic;
}

/*
 printedtype : @{
    today : @{
    }
 }
 */
+(void)setPrintedType:(NSDictionary *)dic
{
    
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:currentDate];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *finalDic = @{
                          na : dic
                          };
    
    [defaults setObject:finalDic forKey:@"printedtype"];
    [defaults synchronize];
}

+(void)clearLastDayPrintedtype
{
    NSDate * date = [NSDate date];//当前时间
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:lastDay];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *dic = [[defaults valueForKey:@"printedtype"] mutableCopy];
    [dic removeObjectForKey:na];

    [defaults setObject:dic forKey:@"printedtype"];
    [defaults synchronize];
}

@end
