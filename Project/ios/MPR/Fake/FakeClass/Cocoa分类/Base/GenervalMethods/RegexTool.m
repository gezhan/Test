//
//  TextCheckTool.m
//  sibu
//
//  Created by GZH on 2017/5/3.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "RegexTool.h"

@implementation RegexTool

+ (BOOL) isEmptyOrNull:(NSString*) string
{
    return ![self notEmptyOrNull:string];
    
}

+ (BOOL) notEmptyOrNull:(NSString*) string
{
    if([string isKindOfClass:[NSNull class]])
        return NO;
    if ([string isKindOfClass:[NSNumber class]]) {
        if (string != nil) {
            return  YES;
        }
        return NO;
    } else {
        string=[self trimString:string];
        if (string != nil && string.length > 0 && ![string isEqualToString:@"null"]&&![string isEqualToString:@"(null)"]&&![string isEqualToString:@" "]) {
            return  YES;
        }
        return NO;
    }
}


+ (NSString *)trimString:(NSString *) str {
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}



//校验用户手机号码
+ (BOOL) validateUserPhone : (NSString *) str
{
    //参考来源：http://hotfm.iteye.com/blog/1208366
    NSString *patternStr = [NSString stringWithFormat:@"^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(16[6])|(17[0,1,3,5-8])|(18[0-9])|(19[8,9]))\\d{8}$"];
    NSRegularExpression *regularexpression = [[NSRegularExpression alloc]
                                              initWithPattern:patternStr
                                              options:NSRegularExpressionCaseInsensitive
                                              error:nil];
    NSUInteger numberofMatch = [regularexpression numberOfMatchesInString:str
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, str.length)];
    
    if(numberofMatch > 0)
    {
        NSLog(@"%@ isNumbericString: YES", str);
        return YES;
    }
    //    [Dialog  toast:@"你输入的手机号不正确"];
    NSLog(@"%@ isNumbericString: NO", str);
    return NO;
}


//校验Email  带有域名验证
+(BOOL)validateEmail:(NSString *)_text
{
    NSString *Regex=@"[0-9a-z._%+-]+@[0-9a-z._]+\\.[a-z]{2,4}";
    
    NSPredicate *emailTest=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",Regex];
    
    return [emailTest evaluateWithObject:_text];
    
}


//是否为中文
+(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}



+(BOOL)checkUrl:(id)_strInput
{
    NSString  *_strRegex = @"^(http|https|ftp)://[a-zA-Z0-9]+[.][a-zA-Z0-9]+([.][a-zA-Z0-9]+){0,1}(/[a-zA-Z0-9-_.+=?&%]*)*$";
    NSPredicate*   _predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",_strRegex];
    if ([_predicate evaluateWithObject:_strInput]) {
        return YES;
    }else{
       return NO;
    }
}

// 是否有非法字符
+ (BOOL)isHaveIllegalChar:(NSString *)str
{
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
    NSRange range = [str rangeOfCharacterFromSet:doNotWant];
    return range.location<str.length;
}


// 判断密码6-16位且同时包含数字和字母
+(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字母
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}







@end
