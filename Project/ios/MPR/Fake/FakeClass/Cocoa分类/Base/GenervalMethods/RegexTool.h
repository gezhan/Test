//
//  TextCheckTool.h
//  sibu
//
//  Created by GZH on 2017/5/3.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegexTool : NSObject


/**  判断是否为空或者null */
+ (BOOL) isEmptyOrNull:(NSString*) string;


/**
 *校验用户手机号码是否合法
 *@param	str	手机号码
 *@return		手机号是否合法
 */
+ (BOOL) validateUserPhone : (NSString *) str;

// 验证邮箱格式
+ (BOOL) validateEmail : (NSString *) str;

//是否为中文
+(BOOL)isChinese;

//检查网址
+(BOOL)checkUrl:(NSString*)str;

//判断是否含有非法字符代码
+ (BOOL)isHaveIllegalChar:(NSString *)str;

// 判断密码6-16位且同时包含数字和字母
+(BOOL)judgePassWordLegal:(NSString *)pass;

//身份证号的验证
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

@end
