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
 *  @method lxd_vertifyEmail
 *  验证字符串是否邮箱格式
 */
- (BOOL)lxd_vertifyEmail;

/*!
 *  @method lxd_vertifyChinese
 *  验证字符串是否中文
 */
- (BOOL)lxd_vertifyChinese;

/*!
 *  @method lxd_vertifyPassword
 *  验证字符串是否6-18位大小字母混合数字密码
 */
- (BOOL)lxd_vertifyPassword;

/*!
 *  @method lxd_vertifyHyperLink
 *  验证字符串是否超链接
 */
- (BOOL)lxd_vertifyHyperLink;

/*!
 *  @method lxd_vertifyTelephone
 *  验证字符串是否固机号码
 */
- (BOOL)lxd_vertifyTelephone;

/*!
 *  @method lxd_vertifyIpAddress
 *  验证字符串是否IP地址
 */
- (BOOL)lxd_vertifyIpAddress;

/*!
 *  @method lxd_vertifyMobilePhone
 *  验证字符串是否手机号码
 */
- (BOOL)lxd_vertifyMobilePhone;

/*!
 *  @method lxd_vertifyCarNumber
 *  验证字符串是否车牌号码
 */
- (BOOL)lxd_vertifyCarNumber;

/*!
 *  @method lxd_vertifyIdentifierNumber
 *  验证字符串是否身份证号码
 */
- (BOOL)lxd_vertifyIdentifierNumber;

/*!
 *  @method lxd_vertifyStringWithExp:
 *  验证字符串是否符合正则表达式规则
 */
- (BOOL)lxd_vertifyStringWithExp: (NSString *)exp;

@end



#pragma mark - 字符匹配截取
/*!
 *  @category   NSString+LXDMatch
 */
@interface NSString (LXDMatch)

/*!
 *  @method lxd_matchNumbersInString:
 *  获取所有数字子串
 */
- (NSArray<NSString *> *)lxd_matchNumbersInString: (NSString *)string;

/*!
 *  @method lxd_matchNumberRangesInString:
 *  获取所有数字子串的range
 */
- (NSArray<NSString *> *)lxd_matchNumberRangesInString: (NSString *)string;

/*!
 *  @method lxd_matchHyperLinksInString:
 *  获取所有超链接子串
 */
- (NSArray<NSString *> *)lxd_matchHyperLinksInString: (NSString *)string;

/*!
 *  @method lxd_matchHyperLinkRangesInString:
 *  获取所有超链接的range
 */
- (NSArray<NSString *> *)lxd_matchHyperLinkRangesInString: (NSString *)string;

/*!
 *  @method lxd_matchMatchesWithRegexExp:
 *  获取所有匹配正则的子串
 */
- (NSArray<NSString *> *)lxd_matchMatchesWithRegexExp: (NSString *)regexExp;

/*!
 *  @method lxd_matchMatchRangesWithRegexExp:
 *  获取匹配正则的子串range
 */
- (NSArray<NSString *> *)lxd_matchMatchRangesWithRegexExp: (NSString *)regexExp;

@end


#pragma mark - 字符转换
/*!
 *  @category   NSString+LXDConvert
 *  字符转换
 */
@interface NSString (LXDConvert)

/*!
 *  @method lxd_MD5String
 *  返回字符摘要
 */
- (NSString *)lxd_MD5String;

/*!
 *  @method lxd_spellString
 *  返回拼音
 */
- (NSString *)lxd_spellString;

/*!
 *  @method lxd_absoluteUrl
 *  返回绝对网址
 */
- (NSString * __nullable)lxd_absoluteUrl;

@end



nonnull_end


