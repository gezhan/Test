//
//  AddressBookModule.m
//  MPR
//
//  Created by HWC on 2018/5/16.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "AddressBookModule.h"
#define ColorRgbValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >>16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:1.0]
@implementation AddressBookModule
@synthesize bridge = _bridge;
RCT_EXPORT_MODULE(AddressBookModule);


RCT_EXPORT_METHOD(OpenAddressBook:(RCTResponseSenderBlock)callback){
  self.block = callback;
  dispatch_async(dispatch_get_main_queue(), ^{
    _status = 0;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    NSString *version = [UIDevice currentDevice].systemVersion;
    if(version.doubleValue >= 9.0){
      _contactPicker = [[CNContactPickerViewController alloc] init];
      _contactPicker.tabBarController.tabBar.backgroundColor = ColorRgbValue(0x1d9ff9);
      _contactPicker.navigationController.navigationBar.barTintColor =ColorRgbValue(0x1d9ff9);
      _contactPicker.delegate = self;
      CNContactStore *contactStore = [[CNContactStore alloc] init];
      
      if ([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusNotDetermined) {
        //首次访问通讯录会调用
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
          if (error) return;
          if (granted) {//允许
            NSLog(@"授权访问通讯录");
            [self fetchContactWithContactStore:contactStore];//访问通讯录
          }else{//拒绝
            NSLog(@"拒绝访问通讯录");//访问通讯录
          }
        }];
      }
      else if([CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts] == CNAuthorizationStatusAuthorized){

        //调用通讯录
        UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        rootViewController.navigationController.navigationBar.barTintColor =ColorRgbValue(0x1d9ff9);
        rootViewController.tabBarController.tabBar.backgroundColor = ColorRgbValue(0x1d9ff9);
        [rootViewController presentViewController:self.contactPicker animated:YES completion:nil];
      }
      
      else{
        //无权限访问
        NSLog(@"拒绝访问通讯录");
      }

    }else{
      
          ABPeoplePickerNavigationController *addressboockVC = [[ABPeoplePickerNavigationController alloc] init];
          addressboockVC.peoplePickerDelegate = self;
          NSString *version = [UIDevice currentDevice].systemVersion;
          if(version.doubleValue >= 8.0){
            addressboockVC.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
          }
      
          UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
          rootViewController.navigationController.navigationBar.barTintColor =ColorRgbValue(0x1d9ff9);
          rootViewController.tabBarController.tabBar.backgroundColor = ColorRgbValue(0x1d9ff9);
          [rootViewController presentViewController:addressboockVC animated:YES completion:nil];

    }
    
  });
}
#pragma  mark 访问通讯录
- (void)fetchContactWithContactStore:(CNContactStore *)contactStore{
  
  //调用通讯录
  self.contactPicker.displayedPropertyKeys =@[CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey];
  UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
  rootViewController.navigationController.navigationBar.barTintColor =ColorRgbValue(0x1d9ff9);
  rootViewController.tabBarController.tabBar.backgroundColor = ColorRgbValue(0x1d9ff9);
  [rootViewController presentViewController:self.contactPicker animated:YES completion:nil];
  [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
  
}

#pragma mark 选择联系人进入详情
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
  
  
  NSLog(@"familyName = %@  givenName = %@  phoneNumber = %@", contact.familyName,contact.givenName,((CNPhoneNumber *)(contact.phoneNumbers.firstObject.value)).stringValue);
  
  
  NSString *name = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
  NSString *phoneValue =((CNPhoneNumber *)(contact.phoneNumbers.firstObject.value)).stringValue;
  if (_status != 1) {
    if (phoneValue) {
      if ([name isEqualToString:@""]) {
        name = phoneValue;
      }
//      [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
      self.block(@[name,phoneValue]);
      _status = 1;
    }else{
//      [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
      self.block(@[[NSNull null]]);
      _status = 1;
    }
  }
// [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
  
}
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
  if (_status != 1) {
    _status = 1;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.block(@[[NSNull null]]);
  }
  
}

//取消
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker{
  if (_status != 1) {
    _status = 1;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.block(@[[NSNull null]]);
  }
}
//选择联系人
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier{
    if (_status != 1) {
      // 1.获取选中联系人的姓名
      NSMutableString *name = [NSMutableString string];
      CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
      CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
      NSString *lastname = (__bridge_transfer NSString *)(lastName);
      NSString *firstname = (__bridge_transfer NSString *)(firstName);

    if(lastname){
      [name appendString:lastname];
    }
    if(firstname){
      [name appendString:firstname];
    }
    
    
    // 2.获取选中联系人的电话号码
    ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSString *phoneValue = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phones, identifier);
    // 注意:管理内存
    CFRelease(phones);
    NSLog(@"%@-%@",name,phoneValue);
    _status = 1;
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.block(@[name,phoneValue]);
  }
  
}


@end
