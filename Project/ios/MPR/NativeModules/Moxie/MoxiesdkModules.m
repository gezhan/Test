//
//  MoxiesdkModules.m
//  zcmpro1
//
//  Created by huang on 2017/8/24.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "MoxiesdkModules.h"

#define ColorRgbAValue(rgbValue,A) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >>16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:A]
//以下需要修改为您平台的信息
//启动SDK必须的参数
//Apikey,您的APP使用SDK的API的权限，即pub_key值
#define theApiKey @"HT1oh4pDajElf1cOazGi"
//用户ID,您APP中用以识别的用户ID
#define theUserID @"moxietest_iosdemo"

@interface MoxiesdkModules ()<MoxieSDKDelegate>
@property (nonatomic,strong) RCTResponseSenderBlock Block;
@property (nonatomic,strong) NSString * Moxietype;

@end
@implementation MoxiesdkModules
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE(MoxiesdkModules);
RCT_EXPORT_METHOD(moxie:(NSDictionary *)dic callback:(RCTResponseSenderBlock)callback){
  /*
   zhengxin:征信报告
   fund：公积金 
   security：社保
   alipay：ZFB
   jingdong：京东 
   taobao：淘宝 
   carrier 运营商
   chsi:学信网
   */

  dispatch_async(dispatch_get_main_queue(), ^{
    NSString *type = [NSString stringWithFormat:@"%@",dic[@"type"]];
    MXLoginCustom *loginCustom = [MXLoginCustom new];
    _Moxietype = type;
    NSLog(@"dic =========== %@,%@",[MoxieSDK shared].version,dic);
    //初始化
    [self configMoxieSDK:dic];
    [self nav];
    //初始化
    [MoxieSDK shared].taskType = _Moxietype;
    
    //不同的认证对应不同的初始化
  
    //公积金自定义登录
    if ([_Moxietype isEqualToString:@"alipay"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];
    }
    if ([_Moxietype isEqualToString:@"jingdong"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];

    }
    if ([_Moxietype isEqualToString:@"taobao"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];

    }
    if ([_Moxietype isEqualToString:@"lifeinsr"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];

    }
    if ([_Moxietype isEqualToString:@"insurance"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];

    }
    if ([_Moxietype isEqualToString:@"security"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];

    }
    if ([_Moxietype isEqualToString:@"qq"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];

    }
    if ([_Moxietype isEqualToString:@"tax"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];

    }
    if ([_Moxietype isEqualToString:@"wechat"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];

    }
    if ([_Moxietype isEqualToString:@"chsi"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];

    }
    if ([_Moxietype isEqualToString:@"linkedin"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];

    }
    if ([_Moxietype isEqualToString:@"maimai"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];

    }
    //自定义运营商
    if ([_Moxietype isEqualToString:@"carrier"]) {
      [MoxieSDK shared].phone = dic[@"phone"];
      [MoxieSDK shared].name = dic[@"name"];
      [MoxieSDK shared].idcard = dic[@"idcard"];
    }
    //公积金自定义登录
    if ([_Moxietype isEqualToString:@"fund"] && dic[@"loginCode"]) {
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];

    }
    // 网银自定义登录
    // 打开网银列表（只显示信用卡或储蓄卡）loginCode 如网银为bankId，公积金为areaCode等，为nil时打开列表页/首页   CMB
    // loginType 如网银为CREDITCARD/DEBITCARD
    if ([_Moxietype isEqualToString:@"bank"]) {
      // 打开网银招行信用卡，并限制为只身份证登录（loginOthersHide为YES），且默认传入身份证.
        if (![dic[@"loginCode"] isEqualToString:@""]) {
          if (dic[@"username"]) {
            if (dic[@"password"]) {
              loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];
              loginCustom.loginType = [NSString stringWithFormat:@"%@",dic[@"loginType"]];
              loginCustom.loginParams = @{
                                          @"IDCARD":@{
                                              @"username":[NSString stringWithFormat:@"%@",dic[@"username"]],
                                              @"password":[NSString stringWithFormat:@"%@",dic[@"password"]]
                                              }
                                          };
            loginCustom.loginOthersHide = YES;
              [MoxieSDK shared].loginCustom = loginCustom;

            } else{
              loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];
              loginCustom.loginType = [NSString stringWithFormat:@"%@",dic[@"loginType"]];
              loginCustom.loginParams = @{
                                          @"IDCARD":@{
                                              @"username":[NSString stringWithFormat:@"%@",dic[@"username"]],
                                              }
                                          };
              loginCustom.loginOthersHide = YES;
              [MoxieSDK shared].loginCustom = loginCustom;


            }
          } else{
            if (![dic[@"loginType"] isEqualToString:@""]) {
              loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];
              loginCustom.loginType = [NSString stringWithFormat:@"%@",dic[@"loginType"]];
              [MoxieSDK shared].loginCustom = loginCustom;
            } else {

            }
          }
      } else {
//        loginCustom.loginType = [NSString stringWithFormat:@"%@",dic[@"loginType"]];
//        [MoxieSDK shared].loginCustom = loginCustom;
      }
    }
    //邮箱自定义登录
    if ([_Moxietype isEqualToString:@"email"]) {
      if (![dic[@"loginCode"] isEqualToString:@""]) {
        if (dic[@"username"]) {
          if (dic[@"password"]) {
            loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];
            loginCustom.loginParams = @{
                                        @"IDCARD":@{
                                            @"username":[NSString stringWithFormat:@"%@",dic[@"username"]],
                                            @"password":[NSString stringWithFormat:@"%@",dic[@"password"]]
                                            }
                                        };
            [MoxieSDK shared].loginCustom = loginCustom;

          } else {
            //打开指定邮箱，并自动填写账号
            loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];
            loginCustom.loginParams = @{
                                        @"IDCARD":@{
                                            @"username":[NSString stringWithFormat:@"%@",dic[@"username"]],
                                            }
                                        };
            [MoxieSDK shared].loginCustom = loginCustom;

          }
        } else {
          loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];
          [MoxieSDK shared].loginCustom = loginCustom;
        }
      }
    }
    if ([_Moxietype isEqualToString:@"zhengxin"]){
      //打开征信v2版本
      loginCustom.loginCode = [NSString stringWithFormat:@"%@",dic[@"loginCode"]];
    }
    
    //启动
    [[MoxieSDK shared] start];
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [MoxieSDK shared].fromController = rootViewController;

    self.Block = callback;
    
  });
}

/**********************SDK 使用***********************/
-(void)configMoxieSDK:(NSDictionary *)dic{
  /***必须配置的基本参数*/
  [MoxieSDK shared].delegate = self;
  [MoxieSDK shared].userId = [NSString stringWithFormat:@"%@",dic[@"uid"]];
  [MoxieSDK shared].apiKey = [NSString stringWithFormat:@"%@",dic[@"key"]];
  [MoxieSDK shared].agreementUrl = [NSString stringWithFormat:@"%@",dic[@"agreementUrl"]];//URL链接
  UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
  [MoxieSDK shared].fromController = rootViewController;
  [MoxieSDK shared].hideRightButton = NO;
  [MoxieSDK shared].quitOnLoginDone = YES;
  [MoxieSDK shared].quitOnFail = YES;
  [MoxieSDK shared].phone = dic[@"phone"];
  [MoxieSDK shared].name = dic[@"name"];
  [MoxieSDK shared].idcard = dic[@"idcard"];

  
  //-------------更多自定义参数，请参考文档----------------//
  [MoxieSDK shared].themeColor = ColorRgbAValue(0x4e89eb, 1);//主题颜色
  [MoxieSDK shared].loadingViewText = [NSString stringWithFormat:@"数据加载中,请耐心加载"];

};


#pragma MoxieSDK Result Delegate
-(void)receiveMoxieSDKResult:(NSDictionary*)resultDictionary{
  //任务结果code，详细参考文档
  int code = [resultDictionary[@"code"] intValue];
  //是否登录成功
  BOOL loginDone = [resultDictionary[@"loginDone"] boolValue];
  //任务类型
  NSString *taskType = resultDictionary[@"taskType"];
  //任务Id
  NSString *taskId = resultDictionary[@"taskId"];
  //描述
  NSString *message = resultDictionary[@"message"];
  //当前账号
  NSString *account = resultDictionary[@"account"];
  //用户在该业务平台上的userId，例如ZFB上的userId（目前ZFB，淘宝，京东支持）
  NSString *businessUserId = resultDictionary[@"businessUserId"]?resultDictionary[@"businessUserId"]:@"";
  NSLog(@"get import result---code:%d,taskType:%@,taskId:%@,message:%@,account:%@,loginDone:%d，businessUserId:%@",code,taskType,taskId,message,account,loginDone,businessUserId);
  //【登录中】假如code是2且loginDone为false，表示正在登录中
  if(code == 2 && loginDone == false){
    NSLog(@"任务正在登录中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
  }
  //【采集中】假如code是2且loginDone为true，已经登录成功，正在采集中
  else if(code == 2 && loginDone == true){
    NSLog(@"任务已经登录成功，正在采集中，SDK退出后不会再回调任务状态，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
  }
  //【采集成功】假如code是1则采集成功（不代表回调成功）
  else if(code == 1){
    NSLog(@"任务采集成功，任务最终状态会从服务端回调，建议轮询APP服务端接口查询任务/业务最新状态");
  }
  //【未登录】假如code是-1则用户未登录
  else if(code == -1){
    NSLog(@"用户未登录");
  }
  //【任务失败】该任务按失败处理，可能的code为0，-2，-3，-4
  else{
    NSLog(@"任务失败");
  }
  self.Block(@[resultDictionary]);
  NSLog(@"任务结束，可以根据taskid，在租户管理系统查询该次任何的最终数据，在魔蝎云监控平台查询该任务的整体流程信息。SDK只会回调状态码及部分基本信息，完整数据会最终通过服务端回调。（记得将本demo的apikey修改成公司对应的正确的apikey）");
}
//自定义导航栏
-(void)nav{
  /**NavBar使用方式二：使用present自定义**/
  [MoxieSDK shared].useNavigationPush = NO;
  //Navbar是否透明
  [MoxieSDK shared].navigationController.navigationBar.translucent = NO;
  //NavBar背景色
  [MoxieSDK shared].navigationController.navigationBar.barTintColor = ColorRgbAValue(0x4e89eb, 1);
  //按钮文字和图片颜色
  [MoxieSDK shared].navigationController.navigationBar.tintColor = [UIColor whiteColor];
  //Title文字颜色
  [[MoxieSDK shared].navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil]];
  
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
  //自定义返回按钮图片
  [MoxieSDK shared].backImageName = @"back_white";

}
/*
 zhengxin:征信报告
 fund：公积金 security：
 社保 alipay：ZFB
 jingdong：京东
 taobao：淘宝
 carrier 运营商
 chsi:学信网
 
 let dic = {
 type:'carrier',
 name:'简大治',
 idcard:'411527199309042512',
 phone:'15715782079'
 }
 Moxie.moxie(dic,(callBack)=>{
 console.log(callBack.code);
 toastShort(callBack.msg);
 }) */


@end
