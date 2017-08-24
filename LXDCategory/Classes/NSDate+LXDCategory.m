//
//  NSDate+LXDCategory.m
//  Pods
//
//  Created by linxinda on 2017/8/16.
//
//

#import "NSDate+LXDCategory.h"
#import "NSString+LXDCategory.h"



static NSString *const kLXDDateFormatExp = @"^\\d[4]-\\d[2]-\\d[2]$";
static NSString *const kLXDTimeFormatExp = @"^\\d[2]:\\d[2]:\\d[2]$";
static NSString *const kLXDDateTimeFormatExp = @"^\\d[4]-\\d[2]-\\d[2] \\d[2]:\\d[2]:\\d[2]$";


@implementation NSDate (LXDConvert)


#pragma mark Private
+ (NSDateFormatter *)_lxdGlobalDateFormatterWithDateFormat: (NSString *)dateFormat {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"zh_CN"];
    });
    dateFormatter.dateFormat = dateFormat;
    return dateFormatter;
}


#pragma mark Public
+ (instancetype)dateWithDateString: (NSString *)dateString {
    if (![dateString vertifyStringWithExp: kLXDDateFormatExp]) { return nil; }
    return [[self _lxdGlobalDateFormatterWithDateFormat: @"yyyy-MM-dd"] dateFromString: dateString];
}

+ (instancetype)dateWithTimeString: (NSString *)timeString {
    if (![timeString vertifyStringWithExp: kLXDTimeFormatExp]) { return nil; }
    return [[self _lxdGlobalDateFormatterWithDateFormat: @"HH:mm:ss"] dateFromString: timeString];
}

+ (instancetype)dateWithDateTimeString: (NSString *)dateTimeString {
    if (![dateTimeString vertifyStringWithExp: kLXDDateTimeFormatExp]) { return nil; }
    return [[self _lxdGlobalDateFormatterWithDateFormat: @"yyyy-MM-dd HH:mm:ss"] dateFromString: dateTimeString];
}

+ (instancetype)dateWithFormatString: (NSString *)formatString dateFormat: (NSString *)dateFormat {
    if (![formatString isKindOfClass: [NSString class]] || ![dateFormat isKindOfClass: [NSString class]]) {
        return nil;
    }
    return [[self _lxdGlobalDateFormatterWithDateFormat: dateFormat] dateFromString: formatString];
}

- (NSString *)dateString {
    return [[NSDate _lxdGlobalDateFormatterWithDateFormat: @"yyyy-MM-dd"] stringFromDate: self];
}

- (NSString *)timeString {
    return [[NSDate _lxdGlobalDateFormatterWithDateFormat: @"HH:mm:ss"] stringFromDate: self];
}

- (NSString *)dateTimeString {
    return [[NSDate _lxdGlobalDateFormatterWithDateFormat: @"yyyy-MM-dd HH:mm:ss"] stringFromDate: self];
}

- (NSString *)formatStringWithDateFormat: (NSString *)dateFormat {
    if (![dateFormat isKindOfClass: [NSString class]]) { return nil; }
    return [[NSDate _lxdGlobalDateFormatterWithDateFormat: dateFormat] stringFromDate: self];
}


@end




#define LXD_COMPONENTS_SET(exp) \
    NSDateComponents *components = [self _dateComponents];  \
    exp;    \
    return [[NSDate _lxdGlobalCalendar] dateFromComponents: components]


#pragma mark - 日期属性获取
@implementation NSDate (LXDGenerate)


#pragma mark Private
+ (NSCalendar *)_lxdGlobalCalendar {
    static NSCalendar * calendar;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        calendar = [NSCalendar calendarWithIdentifier: NSCalendarIdentifierGregorian];
        calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier: @"zh_CN"];
        calendar.timeZone = [NSTimeZone timeZoneWithAbbreviation: @"PRC"];
    });
    return calendar;
}

- (NSDateComponents *)_dateComponents {
    return [[NSDate _lxdGlobalCalendar] components: NSUIntegerMax fromDate: self];
}


#pragma mark Public
- (instancetype)dayBegin {
    LXD_COMPONENTS_SET(components.hour = 0; components.minute = 0; components.second = 0);
}

- (instancetype)dayEnd {
    LXD_COMPONENTS_SET(components.hour = 23; components.minute = 59; components.second = 59);
}

- (instancetype)monthBegin {
    LXD_COMPONENTS_SET(components.day = 0; components.hour = 0; components.minute = 0; components.second = 0);
}

- (NSUInteger)year {
    return [self _dateComponents].year;
}

- (NSUInteger)month {
    return [self _dateComponents].month;
}

- (NSUInteger)day {
    return [self _dateComponents].day;
}

- (NSUInteger)hour {
    return [self _dateComponents].hour;
}

- (NSUInteger)minute {
    return [self _dateComponents].minute;
}

- (NSUInteger)second {
    return [self _dateComponents].second;
}

- (NSString *)weekday {
    NSArray * weekdays = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    return weekdays[[self _dateComponents].weekday - 1];
}


@end




#pragma mark - 日期判断
@implementation NSDate (LXDEstimate)


- (BOOL)isLater {
    return [self isLaterThanDate: [NSDate date]];
}

- (BOOL)isEarly {
    return [self isEarlyThanDate: [NSDate date]];
}

- (BOOL)isLaterThanDate: (NSDate *)date {
    return ([self timeIntervalSinceDate: date] > 0);
}

- (BOOL)isEarlyThanDate: (NSDate *)date {
    return ([self timeIntervalSinceDate: date] < 0);
}

- (BOOL)betweenStart: (NSDate *)start andEnd: (NSDate *)end {
    return (![self isLaterThanDate: end] && ![self isEarlyThanDate: start]);
}


@end


