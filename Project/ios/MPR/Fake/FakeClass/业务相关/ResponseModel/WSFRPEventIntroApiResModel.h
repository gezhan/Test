//
//  WSFRPEventIntroApiResModel.h
//  WinShare
//
//  Created by GZH on 2018/3/8.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"

@interface WSFRPEventIntroApiResModel : MTLModel <MTLJSONSerializing>
/**  活动简介ID */
@property (nonatomic, strong) NSString *Id;
/**  简介标题 */
@property (nonatomic, strong) NSString *title;
/**  简介内容 */
@property (nonatomic, strong) NSString *introContent;
@end
