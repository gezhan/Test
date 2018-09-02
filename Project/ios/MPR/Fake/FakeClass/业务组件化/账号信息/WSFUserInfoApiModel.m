//
//  WSFUserInfoApiModel.m
//  WinShare
//
//  Created by GZH on 2018/1/24.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFUserInfoApiModel.h"

@implementation WSFUserInfoProfileApiModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.Id forKey:@"Id"];
    [aCoder encodeObject:self.fullname forKey:@"fullname"];
    [aCoder encodeObject:self.nick forKey:@"nick"];
    [aCoder encodeObject:self.idCard forKey:@"idCard"];
    [aCoder encodeObject:self.businessTel forKey:@"businessTel"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.gender forKey:@"gender"];
    [aCoder encodeObject:self.mobile forKey:@"mobile"];
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
    [aCoder encodeObject:self.faceUrl forKey:@"faceUrl"];
    [aCoder encodeObject:self.status forKey:@"status"];
    [aCoder encodeObject:self.identityType forKey:@"identityType"];
    [aCoder encodeObject:self.addTime forKey:@"addTime"];
    [aCoder encodeObject:self.signature forKey:@"signature"];
    [aCoder encodeObject:@(self.regionId) forKey:@"regionId"];
    [aCoder encodeObject:self.regionName forKey:@"regionName"];
    [aCoder encodeObject:self.address forKey:@"address"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.Id = [aDecoder decodeObjectForKey:@"Id"];
        self.fullname = [aDecoder decodeObjectForKey:@"fullname"];
        self.nick = [aDecoder decodeObjectForKey:@"nick"];
        self.idCard = [aDecoder decodeObjectForKey:@"idCard"];
        self.businessTel = [aDecoder decodeObjectForKey:@"businessTel"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
        self.gender = [aDecoder decodeObjectForKey:@"gender"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
        self.faceUrl = [aDecoder decodeObjectForKey:@"faceUrl"];
        self.status = [aDecoder decodeObjectForKey:@"status"];
        self.identityType = [aDecoder decodeObjectForKey:@"identityType"];
        self.addTime = [aDecoder decodeObjectForKey:@"addTime"];
        self.signature = [aDecoder decodeObjectForKey:@"signature"];
        self.regionId = [[aDecoder decodeObjectForKey:@"regionId"] integerValue];
        self.regionName = [aDecoder decodeObjectForKey:@"regionName"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (instancetype)initWithData:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end

@implementation WSFUserInfoApiModel

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.accountName forKey:@"accountName"];
    [aCoder encodeObject:@(self.isFirstTime) forKey:@"isFirstTime"];
    [aCoder encodeObject:@(self.identity) forKey:@"identity"];
    [aCoder encodeObject:self.isSetPwd forKey:@"isSetPwd"];
    [aCoder encodeObject:self.profile forKey:@"profile"];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.accountName = [aDecoder decodeObjectForKey:@"accountName"];
        self.isFirstTime = [aDecoder decodeObjectForKey:@"isFirstTime"];
        self.identity = [[aDecoder decodeObjectForKey:@"identity"] integerValue];
        self.isSetPwd = [aDecoder decodeObjectForKey:@"isSetPwd"];
        self.profile = [aDecoder decodeObjectForKey:@"profile"];
    }
    return self;
}

- (void)setValue:(id)value forKey:(NSString *)key {
    if ([key isEqualToString:@"Profile"]) {
         self.profile = [[WSFUserInfoProfileApiModel alloc]initWithData:value];
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

-(instancetype)initWithData:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
