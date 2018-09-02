//
//  WSFUserInfoApiModel.h
//  WinShare
//
//  Created by GZH on 2018/1/24.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSFUserInfoProfileApiModel : NSObject <NSCoding>
/** 账户编号 */
@property(nonatomic, strong)NSString *Id;
/**  姓名（实名  */
@property(nonatomic, strong)NSString *fullname;
/**   昵称   */
@property(nonatomic, strong)NSString *nick;
/**  身份证 */
@property(nonatomic, strong)NSString *idCard;
/**   商户手机   */
@property(nonatomic, strong)NSString *businessTel;
/**  登录密码  */
@property(nonatomic, strong)NSString *password;
/**   性别   */
@property(nonatomic, strong)NSString *gender;
/**  （用户）手机 */
@property(nonatomic, strong)NSString *mobile;
/**   邮箱  */
@property(nonatomic, strong)NSString *email;
/**  出生日期  */
@property(nonatomic, strong)NSString *birthday;
/**   头像，默认自动生成，可上传   */
@property(nonatomic, strong)NSString *faceUrl;
/**   账户状态 */
@property(nonatomic, strong)NSString *status;
/**   身份类型  */
@property(nonatomic, strong)NSString *identityType;
/**  创建时间 */
@property(nonatomic, strong)NSString *addTime;
/**   签名   */
@property(nonatomic, strong)NSString *signature;
/**   地区编号 */
@property(nonatomic, assign)NSInteger regionId;
/**   地区名称   */
@property(nonatomic, strong)NSString *regionName;
/**   地址 */
@property(nonatomic, strong)NSString *address;

- (instancetype)initWithData:(NSDictionary *)dict;

@end


@interface WSFUserInfoApiModel : NSObject <NSCoding>
/** 凭具 */
@property(nonatomic, strong)NSString *token;
/** 账号 */
@property(nonatomic, strong)NSString *accountName;
/** 第一次登陆 */
@property(nonatomic, assign)BOOL isFirstTime;
/** 身份标识(1-用户；2-商户；3-产业园商户) */
@property(nonatomic, assign)NSInteger identity;
/** 是否设置了登录密码 */
@property(nonatomic, strong)NSString *isSetPwd;
/** 用户信息 */
@property(nonatomic, strong)WSFUserInfoProfileApiModel *profile;

- (instancetype)initWithData:(NSDictionary *)dict;

@end
