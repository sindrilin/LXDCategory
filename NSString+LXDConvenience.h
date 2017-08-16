//
//  NSString+LXDConvenience.h
//  KaMoClient
//
//  Created by tengxue on 2016/11/3.
//  Copyright © 2016年 Kamo. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 *  @brief  字符串便利方法扩展
 */
@interface NSString (LXDConvenience)


#pragma mark - Initializer
/// 长串空格字符串
+ (instancetype)whitespaceStringWithLength: (NSUInteger)length;
/// 创建重复字符串
+ (instancetype)stringWithRepeatString: (NSString *)repeat count: (NSUInteger)count;
/// json->String. UTF8
+ (instancetype)stringFromJSON: (id)json;
/// json->String.
+ (instancetype)stringFromJSON: (id)json encoding: (NSStringEncoding)encoding;
/// 金额转换显示
+ (NSString *)amountString: (double)amount;


#pragma mark - Separate
/// 获取字符串中所有数字
- (NSArray<NSString *> *)obtainNumbersInString: (NSString *)string;
/// 获取字符串中所有数字对应位置，用NSRangeFromString()获取
- (NSArray<NSString *> *)obtainNumberRangesInString: (NSString *)string;
/// 获取字符串中所有超链接
- (NSArray<NSString *> *)obtainHyperLinksInString: (NSString *)string;
/// 获取字符串中所有超链接对应位置
- (NSArray<NSString *> *)obtainHyperLinkRangesInString: (NSString *)string;
/// 根据正则表达式获取字符串中的匹配字符串集
- (NSArray<NSString *> *)obtainMatchesWithRegexExp: (NSString *)regexExp;
/// 根据正则表达式获取字符串中的匹配字符串集位置
- (NSArray<NSString *> *)obtainMatchRangesWithRegexExp: (NSString *)regexExp;


#pragma mark - Convert
/// 网址
- (NSString *)absoluteUrl;
/// MD5转码
- (NSString *)md5String;
/// 中文转拼音
- (NSString *)spellString;
/// 转首字母大写
- (NSString *)upperPrefixString;
/// 转成json. UTF8
- (id)stringToJSON;
/// 转成json
- (id)stringToJSONUsingEncoding: (NSStringEncoding)encoding;
/// 转成二进制.  UTF8
- (NSData *)stringToData;
/// 转成二进制
- (NSData *)stringToDataUsingEncoding: (NSStringEncoding)encoding;


#pragma mark - Valid
/// 验证邮箱
- (BOOL)validEmail;
/// 验证字符串是否中文
- (BOOL)validChinese;
/// 验证6-18位大小写字母混合数字密码
- (BOOL)validPassword;
/// 验证网络链接
- (BOOL)validHyperLink;
/// 验证是否座机
- (BOOL)validTelephone;
/// 验证是否IP地址
- (BOOL)validIpAddress;
/// 验证手机号
- (BOOL)validMobilePhone;
/// 验证车牌号码
- (BOOL)validCardNumber;
/// 验证身份证
- (BOOL)validCertifyNumber;
/// 自定义正则表达式验证
- (BOOL)validWithRegexExp: (NSString *)regexExp;


@end
