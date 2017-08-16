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


- (BOOL)vertifyEmail {
    return [self vertifyStringWithExp: @"^(\\S+@\\S+\\.[a-zA-Z]{2,4})$"];
}

- (BOOL)vertifyChinese {
    return [self vertifyStringWithExp: @"^([\u4e00-\u9fa5]+)$"];
}

- (BOOL)vertifyPassword {
    NSString * lengthMatch = @"^(.{6,18})$";
    NSString * numberMatch = @"^(.*\\d+.*)$";
    NSString * lowerMatch = @"^(.*[a-z]+.*)$";
    NSString * upperMatch = @"^(.*[A-Z]+.*)$";
    return [self vertifyStringWithExp: lengthMatch] &&
        [self vertifyStringWithExp: numberMatch] &&
        [self vertifyStringWithExp: lowerMatch] &&
        [self vertifyStringWithExp: upperMatch];
}

- (BOOL)vertifyCarNumber {
    return [self vertifyStringWithExp: @"^([\u4e00-\u9fa5]{1}[a-zA-Z]{1}\\w{4}[a-zA-Z0-9[\u4e00-\u9fa5]]{1})$"];
}

- (BOOL)vertifyHyperLink {
    return [self vertifyStringWithExp: @"^((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)$"];
}

- (BOOL)vertifyIpAddress {
    return [self vertifyStringWithExp: @"^(([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(0\\.0\\.0\\.0)$"];
}

- (BOOL)vertifyTelephone {
    return [self vertifyStringWithExp: @"^(0\\d{2}-?\\d{8})|(\\d{8})|(0\\d{3}-?\\d{8})|(400-\\d{3}-\\d{4})$"];
}

- (BOOL)vertifyMobilePhone {
    return [self vertifyStringWithExp: @"^1\\d{10}$"];
}

- (BOOL)vertifyIdentifierNumber {
    /// http://blog.csdn.net/wei549434510/article/details/50596207
    return [self vertifyStringWithExp: @"(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$)"];
}

- (BOOL)vertifyStringWithExp: (NSString *)exp {
    if (![exp isKindOfClass: [NSString class]]) { return NO; }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", exp];
    return [predicate evaluateWithObject:self];
}


@end





#pragma mark - 字符匹配截取
@implementation NSString (LXDMatch)


- (NSArray<NSString *> *)matchNumbersInString: (NSString *)string {
    return [self matchMatchesWithRegexExp: @"^(\\d+(\\.\\d+)?)$"];
}

- (NSArray<NSString *> *)matchNumberRangesInString: (NSString *)string {
    return [self matchMatchRangesWithRegexExp: @"^(\\d+(\\.\\d+)?)$"];
}

- (NSArray<NSString *> *)matchHyperLinksInString: (NSString *)string {
    return [self matchMatchesWithRegexExp: @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];
}

- (NSArray<NSString *> *)matchHyperLinkRangesInString: (NSString *)string {
    return [self matchMatchRangesWithRegexExp: @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"];
}

- (NSArray<NSString *> *)matchMatchesWithRegexExp: (NSString *)regexExp {
    if (![regexExp isKindOfClass: [NSString class]]) { return @[]; }
    
    NSArray<NSString *> *ranges = [self matchMatchRangesWithRegexExp: regexExp];
    NSMutableArray * matches = @[].mutableCopy;
    for (NSString * range in ranges) {
        [matches addObject: [self substringWithRange: NSRangeFromString(range)]];
    }
    return [NSArray arrayWithArray: matches];
}

- (NSArray<NSString *> *)matchMatchRangesWithRegexExp: (NSString *)regexExp {
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


- (NSString *)MD5String {
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

- (NSString *)spellString {
    if ([self vertifyStringWithExp: @"^.*[\u4e00-\u9fa5]+.*$"]) {
        NSMutableString * spell = [self mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)spell, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)spell, NULL, kCFStringTransformStripCombiningMarks, NO);
        return [spell copy];
    }
    return self;
}

- (NSString *)absoluteUrl {
    if ([self vertifyHyperLink]) {
        if ([self hasPrefix: @"http://"] || [self hasPrefix: @"https://"]) {
            return self;
        }
        return [NSString stringWithFormat: @"http://%@", self];
    }
    return nil;
}


@end




