//
//  UdeskModule.m
//  WeiRong
//
//  Created by 周春仕 on 2017/7/29.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "UdeskModule.h"
#import "UdeskManager.h"
#import "UdeskSDKManager.h"
#define ColorRgbAValue(rgbValue,A) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >>16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:A]
@implementation UdeskModule
@synthesize bridge = _bridge;

RCT_EXPORT_MODULE(UdeskModule);
//初始化SDK
RCT_EXPORT_METHOD(Initialize:(NSString *)configJson customer:(NSString *)customerJson){
  dispatch_async(dispatch_get_main_queue(), ^{
    NSData *data = [configJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *config = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSData *data1 = [customerJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *customerDic = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"%@,%@",configJson,customerJson);
    NSLog(@"%@,%@,%@",config[@"AppKey"],config[@"AppId"],config[@"Domain"]);

    UdeskOrganization *organization = [[UdeskOrganization alloc]
                                       initWithDomain:config[@"Domain"]
                                       appKey:config[@"AppKey"]
                                       appId:config[@"AppId"]];
    UdeskCustomer *customer = [UdeskCustomer new];
    customer.sdkToken = customerDic[@"sdkToken"];
    customer.nickName = customerDic[@"nickName"];
    customer.cellphone = customerDic[@"cellphone"];
    customer.customerDescription = customerDic[@"customerDescription"];
    
//    UdeskCustomerCustomField *textField = [UdeskCustomerCustomField new];
//    textField.fieldKey = @"TextField_17828";
//    textField.fieldValue = IsVIP == 1 ?@"是":@"不是";
//    customer.customField = @[textField];
    [UdeskManager updateCustomer:customer];
    //初始化sdk
    [UdeskManager initWithOrganization:organization customer:customer];
  });

}
//退出
RCT_EXPORT_METHOD(Logout){
  dispatch_async(dispatch_get_main_queue(), ^{
    [UdeskManager logoutUdesk];
  });
}

//打开客服聊天
RCT_EXPORT_METHOD(OpenChatView:(NSDictionary *)dic){
  [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",dic[@"phone"]] forKey:@"callPhone"];
  [[NSUserDefaults standardUserDefaults] synchronize];
  dispatch_async(dispatch_get_main_queue(), ^{
    //后台配置
//        UdeskSDKManager *chatViewManager = [[UdeskSDKManager alloc] initWithSDKStyle:[UdeskSDKStyle defaultStyle]];
    UdeskSDKStyle *sdkStyle = [UdeskSDKStyle customStyle];
    sdkStyle.titleColor = [UIColor whiteColor];
    UdeskSDKManager *chatViewManager = [[UdeskSDKManager alloc] initWithSDKStyle:sdkStyle];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [chatViewManager pushUdeskInViewController:rootViewController completion:nil];
  });
}

//指定聊天客服Id
RCT_EXPORT_METHOD(OpenChatViewWithAgentId:(NSString *)agendId){
  dispatch_async(dispatch_get_main_queue(), ^{
    //后台配置
//    UdeskSDKManager *chatViewManager = [[UdeskSDKManager alloc] initWithSDKStyle:[UdeskSDKStyle defaultStyle]];
    UdeskSDKStyle *sdkStyle = [UdeskSDKStyle customStyle];
    sdkStyle.titleColor = [UIColor whiteColor];
    UdeskSDKManager *chatViewManager = [[UdeskSDKManager alloc] initWithSDKStyle:sdkStyle];
    
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [chatViewManager setScheduledAgentId:agendId];
    [chatViewManager pushUdeskInViewController:rootViewController completion:nil];
  });
}



//打开客服聊天并指定质询对象
RCT_EXPORT_METHOD(OpenChatViewWithMessage:(NSString *)messageJson){
  dispatch_async(dispatch_get_main_queue(), ^{
    
    //后台配置
//    UdeskSDKManager *chatViewManager = [[UdeskSDKManager alloc] initWithSDKStyle:[UdeskSDKStyle defaultStyle]];
    UdeskSDKStyle *sdkStyle = [UdeskSDKStyle customStyle];
    sdkStyle.titleColor = [UIColor whiteColor];
    UdeskSDKManager *chatViewManager = [[UdeskSDKManager alloc] initWithSDKStyle:sdkStyle];
    
    NSMutableDictionary *realMessage = [NSMutableDictionary dictionary];
    if(messageJson){
      NSData *data = [messageJson dataUsingEncoding:NSUTF8StringEncoding];
      NSDictionary *message = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
      
      realMessage[@"productImageUrl"] = message[@"thumbHttpUrl"];
      realMessage[@"productTitle"] = message[@"title"];
      realMessage[@"productDetail"] = message[@"subTitle"];
      realMessage[@"productURL"] = message[@"commodityUrl"];
    }

    [chatViewManager setProductMessage:realMessage];
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [chatViewManager pushUdeskInViewController:rootViewController completion:nil];
  });
}



//获取未读的消息数
RCT_EXPORT_METHOD(GetUnreadeMessagesCount:(RCTResponseSenderBlock)block){
  long count = [UdeskManager getLocalUnreadeMessagesCount];
  block(@[@(count)]);
}
//更新客户信息
RCT_EXPORT_METHOD(UpdateCustomerInfo:(NSString *)customerJson){
  dispatch_async(dispatch_get_main_queue(), ^{
    NSData *data = [customerJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    UdeskCustomer *customer = [UdeskCustomer new];
    customer.sdkToken = dic[@"sdkToken"];
    customer.nickName = dic[@"nickName"];
    customer.cellphone = dic[@"cellphone"];
    customer.customerDescription = dic[@"customerDescription"];
    
//    UdeskCustomerCustomField *textField = [UdeskCustomerCustomField new];
//    textField.fieldKey = @"TextField_17828";
//    textField.fieldValue = IsVIP == 1 ?@"是":@"不是";
//    customer.customField = @[textField];
    [UdeskManager updateCustomer:customer];
  });
}




@end
