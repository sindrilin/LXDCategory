//
//  NSString+LXDCategory.m
//  Pods
//
//  Created by linxinda on 2017/8/16.
//
//

#import "NSString+LXDCategory.h"
#import <CommonCrypto/CommonCrypto.h>



#pragma mark - 字符验证
@implementation NSString (LXDVertify)


- (BOOL)lxd_vertifyEmail {
    return [self lxd_vertifyStringWithExp: @"^(\\S+@\\S+\\.[a-zA-Z]{2,4})$"];
}

- (BOOL)lxd_vertifyChinese {
    return [self lxd_vertifyStringWithExp: @"^([\u4e00-\u9fa5]+)$"];
}

- (BOOL)lxd_vertifyPassword {
    NSString * lengthMatch = @"^(.{6,18})$";
    NSString * numberMatch = @"^(.*\\d+.*)$";
    NSString * lowerMatch = @"^(.*[a-z]+.*)$";
    NSString * upperMatch = @"^(.*[A-Z]+.*)$";
    return [self lxd_vertifyStringWithExp: lengthMatch] &&
        [self lxd_vertifyStringWithExp: numberMatch] &&
        [self lxd_vertifyStringWithExp: lowerMatch] &&
        [self lxd_vertifyStringWithExp: upperMatch];
}

- (BOOL)lxd_vertifyCarNumber {
    return [self lxd_vertifyStringWithExp: @"^([\u4e00-\u9fa5]{1}[a-zA-Z]{1}\\w{4}[a-zA-Z0-9[\u4e00-\u9fa5]]{1})$"];
}

- (BOOL)lxd_vertifyHyperLink {
    return [self lxd_vertifyStringWithExp: @"^((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)$"];
}

- (BOOL)lxd_vertifyIpAddress {
    return [self lxd_vertifyStringWithExp: @"^(([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(0\\.0\\.0\\.0)$"];
}

- (BOOL)lxd_vertifyTelephone {
    return [self lxd_vertifyStringWithExp: @"^(0\\d{2}-?\\d{8})|(\\d{8})|(0\\d{3}-?\\d{8})|(400-\\d{3}-\\d{4})$"];
}

- (BOOL)lxd_vertifyMobilePhone {
    return [self lxd_vertifyStringWithExp: @"^1\\d{10}$"];
}

- (BOOL)lxd_vertifyIdentifierNumber {
    /// http://blog.csdn.net/wei549434510/article/details/50596207
    return [self lxd_vertifyStringWithExp: @"(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$)"];
}

- (BOOL)lxd_vertifyStringWithExp: (NSString *)exp {
    if (![exp isKindOfClass: [NSString class]]) { return NO; }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", exp];
    return [predicate evaluateWithObject:self];
}


@end





#pragma mark - 字符匹配截取
@implementation NSString (LXDMatch)


- (NSArray<NSString *> *)lxd_matchNumbersInString: (NSString *)string {
    return [self lxd_matchMatchesWithRegexExp: @"^(\\d+(\\.\\d+)?)$"];
}

- (NSArray<NSString *> *)lxd_matchNumberRangesInString: (NSString *)string {
    return [self lxd_matchMatchRangesWithRegexExp: @"^(\\d+(\\.\\d+)?)$"];
}

- (NSArray<NSString *> *)lxd_matchHyperLinksInString: (NSString *)string {
    return [self lxd_matchMatchesWithRegexExp: @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];
}

- (NSArray<NSString *> *)lxd_matchHyperLinkRangesInString: (NSString *)string {
    return [self lxd_matchMatchRangesWithRegexExp: @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];
}

- (NSArray<NSString *> *)lxd_matchMatchesWithRegexExp: (NSString *)regexExp {
    if (![regexExp isKindOfClass: [NSString class]]) { return @[]; }
    
    NSArray<NSString *> *ranges = [self lxd_matchMatchRangesWithRegexExp: regexExp];
    NSMutableArray * matches = @[].mutableCopy;
    for (NSString * range in ranges) {
        [matches addObject: [self substringWithRange: NSRangeFromString(range)]];
    }
    return [NSArray arrayWithArray: matches];
}

- (NSArray<NSString *> *)lxd_matchMatchRangesWithRegexExp: (NSString *)regexExp {
    if (![regexExp isKindOfClass: [NSString class]]) { return @[]; }
    
    NSRegularExpression * matcher = [NSRegularExpression regularExpressionWithPattern: regexExp options: NSRegularExpressionAnchorsMatchLines error: nil];
    NSArray<NSTextCheckingResult *> * result = [matcher matchesInString: self options: NSMatchingReportProgress range: NSMakeRange(0, self.length)];
    NSMutableArray * ranges = @[].mutableCopy;
    [result enumerateObjectsUsingBlock: ^(NSTextCheckingResult * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [ranges addObject: NSStringFromRange(obj.range)];
    }];
    return [NSArray arrayWithArray: ranges];
}


@end




@implementation NSString (LXDConvert)


- (NSString *)lxd_MD5String {
    if (self.length == 0) { return self; }
    const char * cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString * result = @"".mutableCopy;
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat: @"%02x", digest[i]];
    }
    return [result copy];
}

- (NSString *)lxd_spellString {
    if ([self lxd_vertifyStringWithExp: @"^.*[\u4e00-\u9fa5]+.*$"]) {
        NSMutableString * spell = [self mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)spell, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)spell, NULL, kCFStringTransformStripCombiningMarks, NO);
        return [spell copy];
    }
    return self;
}

- (NSString *)lxd_absoluteUrl {
    if ([self lxd_vertifyHyperLink]) {
        if ([self hasPrefix: @"http://"] || [self hasPrefix: @"https://"]) {
            return self;
        }
        return [NSString stringWithFormat: @"http://%@", self];
    }
    return nil;
}

- (NSString *)lxd_chineseNumber {
    if (![self lxd_vertifyStringWithExp: @"^\\d+$"]) { return @""; }
    if (self.integerValue == 0) { return @"零"; }
    NSArray *unit = @[@"", @"十", @"百", @"千", @"万", @"十", @"百", @"千", @"亿", @"十", @"百", @"千", @"万", @"十", @"百", @"千", @"兆", @"十", @"百", @"千", @"万"];
    NSArray *number = @[@"", @"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九"];
    NSInteger num = self.integerValue;
    NSInteger reverserNum = 0;
    
    int unitIndex = -1;
    while (num > 0) {
        reverserNum *= 10;
        reverserNum += num % 10;
        num /= 10;
        unitIndex++;
    }
    if (unitIndex > unit.count) { return @""; }
    
    NSMutableString *result = @"".mutableCopy;
    while (reverserNum > 0) {
        [result appendFormat: @"%@%@", number[reverserNum % 10], unit[unitIndex--]];
        reverserNum /= 10;
    }
    return result;
}


@end




