//
//  WSFCityModel.h
//  WinShare
//
//  Created by GZH on 2017/12/19.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "Mantle.h"

@interface WSFCityDetailModel : MTLModel<MTLJSONSerializing>
/**  Region 唯一编号 */
@property (nonatomic, strong) NSString *Id;
/**  父级 Id */
@property (nonatomic, strong) NSString *parentId;
/**  名称 */
@property (nonatomic, strong) NSString *regionName;
/**  类型 ： 1顶级 2 省、直辖市 3 市 4 区县级 */
@property (nonatomic, assign) NSInteger regionType;
/**  是否是省会 */
@property (nonatomic, assign) NSInteger isCapital;
/**  首字母 */
@property (nonatomic, strong) NSString *firstSpell;
@end

@interface WSFCityArrayModel : MTLModel<MTLJSONSerializing>
/**  首字母 */
@property (nonatomic, strong) NSString *spell;
/**  地区数据数组 */
@property (nonatomic, strong) NSArray<WSFCityDetailModel *> *regions;
@end

@interface WSFCityModel : MTLModel<MTLJSONSerializing>
/**  地区数据数组 */
@property (nonatomic, strong) NSArray<WSFCityArrayModel *> *regions;
@end

