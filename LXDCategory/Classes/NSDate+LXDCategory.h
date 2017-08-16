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
 *  @method dateWithDateString:
 *  将yyyy-MM-dd格式字符串转换成日期
 */
+ (__nullable instancetype)dateWithDateString: (NSString *)dateString unuse_ret_val;

/*!
 *  @method dateWithTimeString:
 *  将HH:mm:ss格式字符串转换成日期
 */
+ (__nullable instancetype)dateWithTimeString: (NSString *)timeString unuse_ret_val;

/*!
 *  @method dateWithDateTimeString:
 *  将yyyy-MM-dd HH:mm:ss格式字符串转换成日期
 */
+ (__nullable instancetype)dateWithDateTimeString: (NSString *)dateTimeString unuse_ret_val;

/*!
 *  @method dateWithFormatString:dateFormat:
 *  将自定义dateFormat格式字符串转换成日期
 */
+ (__nullable instancetype)dateWithFormatString: (NSString *)formatString dateFormat: (NSString *)dateFormat unuse_ret_val;

/*!
 *  @method dateString
 *  返回yyyy-MM-dd格式字符串
 */
- (NSString *)dateString unuse_ret_val;

/*!
 *  @method timeString
 *  返回HH:mm:ss格式字符串
 */
- (NSString *)timeString unuse_ret_val;

/*!
 *  @method dateTimeString
 *  返回yyyy-MM-dd HH:mm:ss格式字符串
 */
- (NSString *)dateTimeString unuse_ret_val;

/*!
 *  @method formatStringWithDateFormat:
 *  返回自定义dateFormat格式的日期字符串
 */
- (NSString * __nullable)formatStringWithDateFormat: (NSString *)dateFormat unuse_ret_val;

@end



#pragma mark - 日期属性获取
/*!
 *  @category   NSDate+LXDGenerate
 *  日期属性获取
 */
@interface NSDate (LXDGenerate)

/*!
 *  @method dayBegin
 *  获取当天0时0分0秒
 */
- (instancetype)dayBegin;

/*!
 *  @method dayEnd
 *  获取当天23时59分59秒
 */
- (instancetype)dayEnd;

/*!
 *  @method monthBegin
 *  获取当月第一天0时0分0秒
 */
- (instancetype)monthBegin;

/*!
 *  @method year
 *  获取年份
 */
- (NSUInteger)year;

/*!
 *  @method month
 *  获取月份
 */
- (NSUInteger)month;

/*!
 *  @method day
 *  获取天
 */
- (NSUInteger)day;

/*!
 *  @method hour
 *  获取时
 */
- (NSUInteger)hour;

/*!
 *  @method minute
 *  获取分
 */
- (NSUInteger)minute;

/*!
 *  @method second
 *  获取秒
 */
- (NSUInteger)second;

/*!
 *  @method weekday
 *  获取周几
 */
- (NSString *)weekday;

@end



#pragma mark - 日期判断
/*!
 *  @category   NSDate+LXDEstimate
 *  日期判断
 */
@interface NSDate (LXDEstimate)

/*!
 *  @method isLater
 *  是否晚于当前时间
 */
- (BOOL)isLater;

/*!
 *  @method isEarly
 *  是否早于当前时间
 */
- (BOOL)isEarly;

/*!
 *  @method isLaterThanDate:
 *  是否晚于传入时间
 */
- (BOOL)isLaterThanDate: (NSDate *)date;

/*!
 *  @method isEarlyThanDate:
 *  是否晚于传入时间
 */
- (BOOL)isEarlyThanDate: (NSDate *)date;

/*!
 *  @method betweenStart:andEnd:
 *  是否处在两个日期之中
 */
- (BOOL)betweenStart: (NSDate *)start andEnd: (NSDate *)end;

@end


nonnull_end
