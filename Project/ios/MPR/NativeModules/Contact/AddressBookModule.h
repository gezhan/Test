//
//  AddressBookModule.h
//  MPR
//
//  Created by HWC on 2018/5/16.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AddressBookModule : NSObject<RCTBridgeModule,ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate>{
  NSInteger _status;
}

@property (nonatomic,strong) RCTResponseSenderBlock block;
@property (nonatomic , strong) CNContactPickerViewController *contactPicker;

@end
