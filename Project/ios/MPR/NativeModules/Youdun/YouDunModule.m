//
//  YouDunModule1.m
//  MPR
//
//  Created by HWC on 2018/5/11.
//  Copyright © 2018年 Facebook. All rights reserved.
//



#import "YouDunModule.h"

#define UDPUBKEY        @"HT1oh4pDajElf1cOazGi"       // 格式为：@"12121212-1212-1212-1212-121212121212"
#define UDSECURITYKEY   @"HT1oh4pDajElf1cOazGi"  // 格式为：@"12121212-1212-1212-1212-121212121212"

@interface YouDunModule ()<UDIDEngineDelegate>{
  UDIDEngine *_ocrEngine;         // 身份证 OCR 扫描 初始化
//  UDIDEngine *_livenessEngine;    // 活体检测
  
  
  NSString *_name;
  NSString *_card;
  NSString *_zjUDID;
  
  
}
@property(nonatomic, strong)NSString *udpubkey;
@property(nonatomic, strong)NSString *udsecuritykey;

@property (nonatomic, strong) NSString * partnerOrderId;   // 商户订单号
@property (nonatomic, strong) NSString * signTime;         // 签名时间

@property(nonatomic, strong)NSDictionary *ocr;//OCR扫描回调结果信息
@property(nonatomic, strong)NSDictionary *ht;//活体回调信息


@property (nonatomic,strong) RCTResponseSenderBlock Block;

@property (nonatomic, assign) BOOL didBlcok;

@end


@implementation YouDunModule
RCT_EXPORT_MODULE(YouDunModule)
//ocr
RCT_EXPORT_METHOD(OpenOCRSM:(NSDictionary *)postData callback:(RCTResponseSenderBlock)callback){
	dispatch_async(dispatch_get_main_queue(), ^{
		self.didBlcok = NO;
    [self orc:postData];
		self.Block = callback;
		
	});
}


//实名认证
RCT_EXPORT_METHOD(OpenSm:(NSDictionary *)postData callback:(RCTResponseSenderBlock)callback){
  dispatch_async(dispatch_get_main_queue(), ^{
    self.didBlcok = NO;
    [self sm:postData];
    self.Block = callback;
    
    
  });
}

//活体+比对------需要传身份证的sesion_ID
RCT_EXPORT_METHOD(OpenHTFace:(NSDictionary *)postData callback:(RCTResponseSenderBlock)callback){
  dispatch_async(dispatch_get_main_queue(), ^{
    self.didBlcok = NO;
    [self ht_face:postData];
    self.Block = callback;
    
  });
}

//身份证OCR识别
-(void)orc:(NSDictionary *)dics{
  _ocrEngine = [[UDIDEngine alloc] init];
  /* 添加(实名验证+活体检测+人脸比对)功能模块 */
  //    _customEngine.actions = @[@3, @1, @2];
  // 或者下面的 actions 传入方式
  //身份证OCR识别+实名验证
  _ocrEngine.actions = @[[NSNumber numberWithUnsignedInteger:UDIDAuthFlowOCR]];
  
  /* 身份证 OCR 扫描相关参数 */
  _ocrEngine.showConfirmIdNumber = YES;
  _ocrEngine.showInfo = YES;
  
  /* 通用参数 */
//  [self tycs:_ocrEngine dic:dics];
  _ocrEngine.pubKey = [NSString stringWithFormat:@"%@",dics[@"pubKey"]];
  _ocrEngine.signTime = [NSString stringWithFormat:@"%@",dics[@"signTime"]];
  _ocrEngine.partnerOrderId = [NSString stringWithFormat:@"%@",dics[@"InfOrder"]];
  _ocrEngine.notifyUrl = [NSString stringWithFormat:@"%@",dics[@"notifyUrl"]];
  _ocrEngine.sign = [NSString stringWithFormat:@"%@",dics[@"sign"]];
  _ocrEngine.delegate = self;
  UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
  [_ocrEngine startIdSafeAuthInViewController:rootViewController];
}

//+实名验证
-(void)sm:(NSDictionary *)dics{
  _ocrEngine = [[UDIDEngine alloc] init];
  /* 添加(实名验证+活体检测+人脸比对)功能模块 */
  //    _customEngine.actions = @[@3, @1, @2];
  // 或者下面的 actions 传入方式
  //身份证OCR识别+实名验证
  _ocrEngine.actions = @[[NSNumber numberWithUnsignedInteger:UDIDAuthFlowRealName]];
  
  /* 添加实名验证功能模块 */
  _ocrEngine.verifyType = UDIDVerifyHumanType;
  _ocrEngine.idName = [NSString stringWithFormat:@"%@",dics[@"userName"]];
  _ocrEngine.idNumber = [NSString stringWithFormat:@"%@",dics[@"card"]];
  
  /* 通用参数 */
  _ocrEngine.pubKey = [NSString stringWithFormat:@"%@",dics[@"pubKey"]];
  _ocrEngine.signTime = [NSString stringWithFormat:@"%@",dics[@"signTime"]];
  _ocrEngine.partnerOrderId = [NSString stringWithFormat:@"%@",dics[@"InfOrder"]];
  _ocrEngine.notifyUrl = [NSString stringWithFormat:@"%@",dics[@"notifyUrl"]];
	_ocrEngine.sign = [NSString stringWithFormat:@"%@",dics[@"sign"]];
  _ocrEngine.delegate = self;
  UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
  [_ocrEngine startIdSafeAuthInViewController:rootViewController];
}


//活体检测+人脸比对
-(void)ht_face:(NSDictionary *)dics{
  _ocrEngine = [[UDIDEngine alloc] init];
  _ocrEngine.actions = @[[NSNumber numberWithUnsignedInteger:UDIDAuthFlowLiving],
                              [NSNumber numberWithUnsignedInteger:UDIDAuthFlowCompare]];
  
  /* 活体检测相关参数 */
  _ocrEngine.randomCount = 3;  // 随机个数
  _ocrEngine.livingMode = UDIDLivingCommandMode;  // 枚举活体类型
  _ocrEngine.closeRemindVoice = YES;
  
  _ocrEngine.isGridPhoto = YES;
  NSString *session_id = [NSString stringWithFormat:@"%@",dics[@"session_id"]];
  _ocrEngine.compareItemB = [UDIDFaceCompareFactory getBySessionID:session_id type:UDIDSafePhotoTypeNormal];
  _ocrEngine.compareItemA = [UDIDFaceCompareFactory getBytype:UDIDSafePhotoTypeLiving] ;
  /* 通用参数 */


  /* 通用参数 */
	_ocrEngine.pubKey = [NSString stringWithFormat:@"%@",dics[@"pubKey"]];
	_ocrEngine.signTime = [NSString stringWithFormat:@"%@",dics[@"signTime"]];
	_ocrEngine.partnerOrderId = [NSString stringWithFormat:@"%@",dics[@"InfOrder"]];
	_ocrEngine.notifyUrl = [NSString stringWithFormat:@"%@",dics[@"notifyUrl"]];
	_ocrEngine.sign = [NSString stringWithFormat:@"%@",dics[@"sign"]];
  _ocrEngine.delegate = self;
  UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
  [_ocrEngine startIdSafeAuthInViewController:rootViewController];
  
}


#pragma mark - Delegate

- (void)idSafeEngineFinishedResult:(UDIDEngineResult)result UserInfo:(id)userInfo {

  NSLog(@" userinfo == %@",userInfo);
  if ([userInfo[@"ret_code"] isEqualToString:@"900001"] || [userInfo[@"ret_msg"] isEqualToString:@"用户取消操作"]) {
    
    self.Block(@[[NSNull null]]);
    
  }else{
    switch (result) {
        // TODO: 身份证OCR识别 回调
      case UDIDEngineResult_OCR: {
        
        NSLog(@"demo:OCR回调: %@", userInfo);
        self.Block(@[(NSDictionary *)userInfo]);
        break;
      }
        // TODO: 实名验证 回调
      case UDIDEngineResult_IDAuth: {
        
        NSLog(@"demo:实名验证回调: %@", userInfo);
        self.Block(@[(NSDictionary *)userInfo]);
        
        break;
      }
        // TODO: 活体检测 回调
      case UDIDEngineResult_Liveness: {
        
        self.ht = (NSDictionary *)userInfo;
        NSLog(@"demo:活体检测回调: %@", userInfo);
        break;
      }
        
        // TODO: 人脸比对 回调
      case UDIDEngineResult_FaceCompare: {
        
        if (self.ht) {
          NSDictionary *dic = @{@"Living":self.ht,@"Face":(NSDictionary *)userInfo};
          self.Block(@[dic]);
        }else{
          NSDictionary *dic = @{@"errormsg":@"活体检测失败!"};
          self.Block(@[dic]);
        }
        NSLog(@"demo:人脸比对回调: %@", userInfo);
        break;
      }
      default:
        break;
    }

  }
}


@end

