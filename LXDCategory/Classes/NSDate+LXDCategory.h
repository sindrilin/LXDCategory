//
//  NSDate+LXDCategory.h
//  Pods
//
//  Created by linxinda on 2017/8/16.
//
//

#import <Foundation/Foundation.h>
#import <LXDMacros/LXDMacros.h>

nonull_begin

#pragma mark - 日期字符串转换
/*!
 *  @category NSDate+LXDConvert
 *  日期字符串转换
 */
@interface NSDate (LXDConvert)

/*!
 *  @method lxd_dateWithDateString:
 *  将yyyy-MM-dd格式字符串转换成日期
 */
+ (__nullable instancetype)lxd_dateWithDateString: (NSString *)dateString unuse_ret_val;

/*!
 *  @method lxd_dateWithTimeString:
 *  将HH:mm:ss格式字符串转换成日期
 */
+ (__nullable instancetype)lxd_dateWithTimeString: (NSString *)timeString unuse_ret_val;

/*!
 *  @method lxd_dateWithDateTimeString:
 *  将yyyy-MM-dd HH:mm:ss格式字符串转换成日期
 */
+ (__nullable instancetype)lxd_dateWithDateTimeString: (NSString *)dateTimeString unuse_ret_val;

/*!
 *  @method lxd_dateWithFormatString:dateFormat:
 *  将自定义dateFormat格式字符串转换成日期
 */
+ (__nullable instancetype)lxd_dateWithFormatString: (NSString *)formatString dateFormat: (NSString *)dateFormat unuse_ret_val;

/*!
 *  @method lxd_dateString
 *  返回yyyy-MM-dd格式字符串
 */
- (NSString *)lxd_dateString unuse_ret_val;

/*!
 *  @method lxd_timeString
 *  返回HH:mm:ss格式字符串
 */
- (NSString *)lxd_timeString unuse_ret_val;

/*!
 *  @method lxd_dateTimeString
 *  返回yyyy-MM-dd HH:mm:ss格式字符串
 */
- (NSString *)lxd_dateTimeString unuse_ret_val;

/*!
 *  @method lxd_formatStringWithDateFormat:
 *  返回自定义dateFormat格式的日期字符串
 */
- (NSString * __nullable)lxd_formatStringWithDateFormat: (NSString *)dateFormat unuse_ret_val;

@end



#pragma mark - 日期属性获取
/*!
 *  @category   NSDate+LXDGenerate
 *  日期属性获取
 */
@interface NSDate (LXDGenerate)

/*!
 *  @method lxd_dayBegin
 *  获取当天0时0分0秒
 */
- (instancetype)lxd_dayBegin;

/*!
 *  @method lxd_dayEnd
 *  获取当天23时59分59秒
 */
- (instancetype)lxd_dayEnd;

/*!
 *  @method lxd_monthBegin
 *  获取当月第一天0时0分0秒
 */
- (instancetype)lxd_monthBegin;

/*!
 *  @method lxd_year
 *  获取年份
 */
- (NSUInteger)lxd_year;

/*!
 *  @method lxd_month
 *  获取月份
 */
- (NSUInteger)lxd_month;

/*!
 *  @method lxd_day
 *  获取天
 */
- (NSUInteger)lxd_day;

/*!
 *  @method lxd_hour
 *  获取时
 */
- (NSUInteger)lxd_hour;

/*!
 *  @method lxd_minute
 *  获取分
 */
- (NSUInteger)lxd_minute;

/*!
 *  @method lxd_second
 *  获取秒
 */
- (NSUInteger)lxd_second;

/*!
 *  @method lxd_weekday
 *  获取周几
 */
- (NSString *)lxd_weekday;

@end



#pragma mark - 日期判断
/*!
 *  @category   NSDate+LXDEstimate
 *  日期判断
 */
@interface NSDate (LXDEstimate)

/*!
 *  @method lxd_isLater
 *  是否晚于当前时间
 */
- (BOOL)lxd_isLater;

/*!
 *  @method lxd_isEarly
 *  是否早于当前时间
 */
- (BOOL)lxd_isEarly;

/*!
 *  @method lxd_isLaterThanDate:
 *  是否晚于传入时间
 */
- (BOOL)lxd_isLaterThanDate: (NSDate *)date;

/*!
 *  @method lxd_isEarlyThanDate:
 *  是否晚于传入时间
 */
- (BOOL)lxd_isEarlyThanDate: (NSDate *)date;

/*!
 *  @method lxd_betweenStart:andEnd:
 *  是否处在两个日期之中
 */
- (BOOL)lxd_betweenStart: (NSDate *)start andEnd: (NSDate *)end;

@end


nonnull_end
