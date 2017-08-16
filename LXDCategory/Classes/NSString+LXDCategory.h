//
//  NSString+LXDCategory.h
//  Pods
//
//  Created by linxinda on 2017/8/16.
//
//

#import <Foundation/Foundation.h>
#import <LXDMacros/LXDMacros.h>


nonull_begin

#pragma mark - 字符验证
/*!
 *  @category   NSString+LXDVertify
 */
@interface NSString (LXDVertify)

/*!
 *  @method vertifyEmail
 *  验证字符串是否邮箱格式
 */
- (BOOL)vertifyEmail;

/*!
 *  @method vertifyChinese
 *  验证字符串是否中文
 */
- (BOOL)vertifyChinese;

/*!
 *  @method vertifyPassword
 *  验证字符串是否6-18位大小字母混合数字密码
 */
- (BOOL)vertifyPassword;

/*!
 *  @method vertifyHyperLink
 *  验证字符串是否超链接
 */
- (BOOL)vertifyHyperLink;

/*!
 *  @method vertifyTelephone
 *  验证字符串是否固机号码
 */
- (BOOL)vertifyTelephone;

/*!
 *  @method vertifyIpAddress
 *  验证字符串是否IP地址
 */
- (BOOL)vertifyIpAddress;

/*!
 *  @method vertifyMobilePhone
 *  验证字符串是否手机号码
 */
- (BOOL)vertifyMobilePhone;

/*!
 *  @method vertifyCarNumber
 *  验证字符串是否车牌号码
 */
- (BOOL)vertifyCarNumber;

/*!
 *  @method vertifyIdentifierNumber
 *  验证字符串是否身份证号码
 */
- (BOOL)vertifyIdentifierNumber;

/*!
 *  @method vertifyStringWithExp:
 *  验证字符串是否符合正则表达式规则
 */
- (BOOL)vertifyStringWithExp: (NSString *)exp;

@end



#pragma mark - 字符匹配截取
/*!
 *  @category   NSString+LXDMatch
 */
@interface NSString (LXDMatch)

/*!
 *  @method matchNumbersInString:
 *  获取所有数字子串
 */
- (NSArray<NSString *> *)matchNumbersInString: (NSString *)string;

/*!
 *  @method matchNumberRangesInString:
 *  获取所有数字子串的range
 */
- (NSArray<NSString *> *)matchNumberRangesInString: (NSString *)string;

/*!
 *  @method matchHyperLinksInString:
 *  获取所有超链接子串
 */
- (NSArray<NSString *> *)matchHyperLinksInString: (NSString *)string;

/*!
 *  @method matchHyperLinkRangesInString:
 *  获取所有超链接的range
 */
- (NSArray<NSString *> *)matchHyperLinkRangesInString: (NSString *)string;

/*!
 *  @method matchMatchesWithRegexExp:
 *  获取所有匹配正则的子串
 */
- (NSArray<NSString *> *)matchMatchesWithRegexExp: (NSString *)regexExp;

/*!
 *  @method matchMatchRangesWithRegexExp:
 *  获取匹配正则的子串range
 */
- (NSArray<NSString *> *)matchMatchRangesWithRegexExp: (NSString *)regexExp;

@end


#pragma mark - 字符转换
/*!
 *  @category   NSString+LXDConvert
 *  字符转换
 */
@interface NSString (LXDConvert)

/*!
 *  @method MD5String
 *  返回字符摘要
 */
- (NSString *)MD5String;

/*!
 *  @method spellString
 *  返回拼音
 */
- (NSString *)spellString;

/*!
 *  @method absoluteUrl
 *  返回绝对网址
 */
- (NSString * __nullable)absoluteUrl;

@end



nonnull_end


