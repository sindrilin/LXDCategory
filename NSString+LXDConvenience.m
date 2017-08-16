//
//  NSString+LXDConvenience.m
//  KaMoClient
//
//  Created by linxinda on 2016/11/3.
//  Copyright © 2016年 Kamo. All rights reserved.
//

#import "NSString+LXDConvenience.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (LXDConvenience)


#pragma mark - Initializer
/// 长串空格字符串
+ (instancetype)whitespaceStringWithLength: (NSUInteger)length
{
    return [self stringWithRepeatString: @" " count: length];
}

/// 创建重复字符串
+ (instancetype)stringWithRepeatString: (NSString *)repeat count: (NSUInteger)count
{
    NSMutableString * result = @"".mutableCopy;
    for (NSUInteger idx = 0; idx < count; idx++) {
        [result appendString: repeat];
    }
    if ([self isKindOfClass: [NSMutableString class]]) { return result; }
    return result.copy;
}


#pragma mark - Separate
/// 获取字符串中所有数字
- (NSArray<NSString *> *)obtainNumbersInString: (NSString *)string {
    return [self obtainMatchesWithRegexExp: @"^(\\d+\\.?\\d*)$"];
}

/// 获取字符串中所有数字对应位置，用NSRangeFromString()获取
- (NSArray<NSString *> *)obtainNumberRangesInString: (NSString *)string {
    return [self obtainMatchRangesWithRegexExp: @"^(\\d+\\.?\\d*)$"];
}

/// 获取字符串中所有超链接
- (NSArray<NSString *> *)obtainHyperLinksInString: (NSString *)string {
    return [self obtainMatchesWithRegexExp: @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];
}

/// 获取字符串中所有超链接对应位置
- (NSArray<NSString *> *)obtainHyperLinkRangesInString: (NSString *)string {
    return [self obtainMatchRangesWithRegexExp: @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|([a-zA-Z0-9]+\\.([a-zA-Z]{2,10})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];
}

/// 根据正则表达式获取字符串中的匹配字符串集
- (NSArray<NSString *> *)obtainMatchesWithRegexExp: (NSString *)regexExp {
    NSArray<NSString *> * ranges = [self obtainMatchRangesWithRegexExp: regexExp];
    NSMutableArray * matches = @[].mutableCopy;
    for (NSString * range in ranges) {
        [matches addObject: [self substringWithRange: NSRangeFromString(range)]];
    }
    return matches;
}

/// 根据正则表达式获取字符串中的匹配字符串集位置
- (NSArray<NSString *> *)obtainMatchRangesWithRegexExp: (NSString *)regexExp {
    NSParameterAssert(regexExp);
    
    NSRegularExpression * matcher = [NSRegularExpression regularExpressionWithPattern: regexExp options: NSRegularExpressionAnchorsMatchLines error: nil];
    NSArray<NSTextCheckingResult *> * result = [matcher matchesInString: self options: NSMatchingReportProgress range: NSMakeRange(0, self.length)];
    NSMutableArray * ranges = @[].mutableCopy;
    [result enumerateObjectsUsingBlock: ^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [ranges addObject: NSStringFromRange(obj.range)];
    }];
    return ranges;
}


#pragma mark - Convert
/// 网址
- (NSString *)absoluteUrl
{
    if ([self validHyperLink]) {
        if ([self hasPrefix: @"http://"] || [self hasPrefix: @"https://"]) {
            return self;
        }
        return [NSString stringWithFormat: @"http://%@", self];
    }
    return nil;
}

/// MD5转码
- (NSString *)md5String {
    if (self.length == 0) { return self; }
    const char * cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString * result = @"".mutableCopy;
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat: @"%02x", digest[i]];
    }
    return result;
}

- (NSString *)spellString {
    NSMutableString * spell = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)spell, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)spell, NULL, kCFStringTransformStripCombiningMarks, NO);
    return spell;
}

- (NSString *)upperPrefixString {
    NSMutableString * result = @"".mutableCopy;
    for (NSInteger idx = 0; idx < self.length; idx++) {
        NSString * single = [self substringWithRange: NSMakeRange(idx, 1)];
        if ([single validChinese]) {
            [result appendString: [single.spellString.uppercaseString substringWithRange: NSMakeRange(0, 1)]];
        } else {
            [result appendString: single.uppercaseString];
        }
    }
    return result;
}

/// 转成json. UTF8
- (id)stringToJSON {
    return [self stringToJSONUsingEncoding: NSUTF8StringEncoding];
}

/// 转成json
- (id)stringToJSONUsingEncoding: (NSStringEncoding)encoding {
    NSData * data = [self dataUsingEncoding: encoding];
    return [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingAllowFragments error: nil];
}

/// 转成二进制.  UTF8
- (NSData *)stringToData
{
    return [self stringToDataUsingEncoding: NSUTF8StringEncoding];
}

/// 转成二进制
- (NSData *)stringToDataUsingEncoding: (NSStringEncoding)encoding
{
    return [self dataUsingEncoding: encoding];
}

/// json->String. UTF8
+ (instancetype)stringFromJSON: (id)json {
    return [self stringFromJSON: json encoding: NSUTF8StringEncoding];
}

/// json->String.
+ (instancetype)stringFromJSON: (id)json encoding: (NSStringEncoding)encoding {
    NSParameterAssert(json);
    NSData * data = [NSJSONSerialization dataWithJSONObject: json options: NSJSONWritingPrettyPrinted error: nil];
    return [[self alloc] initWithData: data encoding: NSUTF8StringEncoding];
}

/// 金额显示
+ (NSString *)amountString: (double)amount {
    NSString * amountString = [NSString stringWithFormat: @"￥%g", amount];
    if ([amountString containsString: @"."]) {
        NSString * decimal = [amountString substringFromIndex: NSMaxRange([amountString rangeOfString: @"."])];
        if (decimal.length > 2) {
            amountString = [amountString substringToIndex: amountString.length - (decimal.length - 2)];
        }
    }
    return amountString;
}


#pragma mark - Valid
/// 验证邮箱
- (BOOL)validEmail {
    return [self validWithRegexExp: @"^(\\S+@\\S+\\.[a-zA-Z]{2,4})$"];
}

/// 验证字符串是否中文
- (BOOL)validChinese {
    return [self validWithRegexExp: @"([\u4e00-\u9fa5]+)"];
}

/// 验证6-18位大小写字母混合数字密码
- (BOOL)validPassword {
    NSString * lengthMatch = @"^(.{6,18})$";
    NSString * numberMatch = @"^(.*\\d+.*)$";
    NSString * lowerMatch = @"^(.*[a-z]+.*)$";
    NSString * upperMatch = @"^(.*[A-Z]+.*)$";
    return [self validWithRegexExp: lengthMatch] && [self validWithRegexExp: numberMatch] && [self validWithRegexExp: lowerMatch] && [self validWithRegexExp: upperMatch];
}

/// 验证网络链接
- (BOOL)validHyperLink
{
    return [self validWithRegexExp: @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];
}

/// 验证是否座机
- (BOOL)validTelephone
{
    return [self validWithRegexExp: @"(0\\d{2}-?\\d{8})|(\\d{8})|(0\\d{3}-?\\d{8})|(400-\\d{3}-\\d{4})"];
}

/// 验证手机号
- (BOOL)validMobilePhone
{
    return [self validWithRegexExp: @"^1\\d{10}$"];
}

/// 验证是否IP地址
- (BOOL)validIpAddress
{
    return [self validWithRegexExp: @"^(([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(0\\.0\\.0\\.0)$"];
}

/// 验证车牌号码
- (BOOL)validCardNumber {
    return [self validWithRegexExp: @"^([\u4e00-\u9fa5]{1}[a-zA-Z]{1}\\w{4}[a-zA-Z0-9[\u4e00-\u9fa5]]{1})$"];
}

/// 验证身份证
- (BOOL)validCertifyNumber {
    return [self validWithRegexExp: @"^(\\d{14}|\\d{17})(\\d|[xX])$"];
}

/// 自定义正则表达式验证
- (BOOL)validWithRegexExp: (NSString *)regexExp {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", regexExp];
    return [predicate evaluateWithObject:self];
}


@end
