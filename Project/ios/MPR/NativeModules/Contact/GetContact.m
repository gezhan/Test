//
//  GetContact.m
//  MPR
//
//  Created by HWC on 2018/5/16.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "GetContact.h"
#import "YContactsManager.h"
#import "YContactObject.h"
//获取通讯录
@interface GetContact ()

@property (nonatomic, copy)NSArray <YContactObject *> *  contactObjects;
@property (nonatomic , strong) CNContactPickerViewController *contactPicker;
@property (nonatomic, strong) YContactsManager * contactManager;
@end
@implementation GetContact
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(GetContacts:(RCTResponseSenderBlock)callback){
	NSString *version = [UIDevice currentDevice].systemVersion;
  if(version.doubleValue < 9.0){
	self.contactManager = [YContactsManager shareInstance];
	//开始请求
	[self.contactManager requestContactsComplete:^(NSArray<YContactObject *> * _Nonnull contacts) {
		NSMutableArray *contact = [[NSMutableArray alloc] init];
		//开始赋值
		for (int i = 0;i<contacts.count;i++){
			NSMutableDictionary * dicContacts = [[NSMutableDictionary alloc] init];
			YContactObject * contactObject = contacts[i];
			[dicContacts setValue:contactObject.nameObject.name forKey:@"contactName"];
			NSMutableArray *phoneNumber = [[NSMutableArray alloc] init];
			for (int j = 0;j<contactObject.phoneObject.count;j++){
				NSString *str = [contactObject.phoneObject[j].phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
				NSString *str1 = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
				NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"+86" withString:@""];
				[phoneNumber addObject:str2];
			}
			[dicContacts setValue:phoneNumber forKey:@"contactPhoneNumber"];
			[contact addObject:dicContacts];
		}
    callback(@[contact]);
    }];
  }else{
    NSError *error = nil;
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    //创建数组,必须遵守CNKeyDescriptor协议,放入相应的字符串常量来获取对应的联系人信息
    NSArray <id<CNKeyDescriptor>> *keysToFetch = @[CNContactFamilyNameKey, CNContactPhoneNumbersKey,CNContactGivenNameKey];
    //创建获取联系人的请求
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    //遍历查询
    NSMutableArray *contacts = [[NSMutableArray alloc] init];
     NSLog(@"1%@",[NSThread currentThread]);
   BOOL aa = [contactStore enumerateContactsWithFetchRequest:fetchRequest error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
     NSLog(@"2%@",[NSThread currentThread]);
      if (!error) {
        NSMutableDictionary * dicContacts = [[NSMutableDictionary alloc] init];
        NSString *failygivenname = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        [dicContacts setValue:failygivenname forKey:@"contactName"];
        NSMutableArray *phoneNumber = [[NSMutableArray alloc] init];
        for (int j = 0;j<contact.phoneNumbers.count;j++){
          NSString *strs = [NSString stringWithFormat:@"%@",((CNPhoneNumber *)(contact.phoneNumbers.lastObject.value)).stringValue];
          NSString *str = [strs stringByReplacingOccurrencesOfString:@"-" withString:@""];
          NSString *str1 = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
          NSString *str2 = [str1 stringByReplacingOccurrencesOfString:@"+86" withString:@""];
          [phoneNumber addObject:str2];
        }
        [dicContacts setValue:phoneNumber forKey:@"contactPhoneNumber"];
        [contacts addObject:dicContacts];
        if (!stop) {
          
        }
        
      }
      else{
        NSLog(@"error:%@", error.localizedDescription);
      }
    }];
     NSLog(@"3%@",[NSThread currentThread]);
    if (aa) {
      callback(@[contacts]);
    }
    
  }
//		NSLog(@"%@",contact);

}

@end
