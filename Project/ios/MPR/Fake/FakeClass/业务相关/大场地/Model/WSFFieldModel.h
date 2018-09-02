//
//  WSFFieldModel.h
//  WinShare
//
//  Created by GZH on 2018/1/15.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "Mantle.h"
#import "WSFRPPhotoApiModel.h"

//@interface WSFFieldPictureModel : MTLModel<MTLJSONSerializing>
/////**  编号 */
////@property (nonatomic, strong) NSString *Id;
///**  缩略图地址 */
//@property (nonatomic, strong) NSString *uRL;
///**  实际路径 */
//@property (nonatomic, strong) NSString *path;
/////**  文件名称 */
////@property (nonatomic, strong) NSString *fileName;
//
//@end

@interface WSFFieldListModel : MTLModel<MTLJSONSerializing>
/**  空间ID */
@property (nonatomic, strong) NSString *roomId;
/**  空间名称 */
@property (nonatomic, strong) NSString *roomName;
/**  地址 */
@property (nonatomic, strong) NSString *address;
/**  价格 */
@property (nonatomic, strong) NSNumber *price;
/**  距离(单位/米) */
@property (nonatomic, assign) NSInteger theMeter;
/**  空间类别 */
@property (nonatomic, strong) NSString *roomType;
/**  可容纳人数 */
@property (nonatomic, assign) NSInteger capacity;
/**  图片 */
@property (nonatomic, strong) WSFRPPhotoApiModel *picture;

@end

@interface WSFFieldModel : MTLModel<MTLJSONSerializing>
/**  符合条件的记录总数量 */
@property (nonatomic, assign) NSInteger totalCount;
/**  当前第几页 */
@property (nonatomic, assign) NSInteger pageIndex;
/**  每页数量 */
@property (nonatomic, assign) NSInteger pageSize;
/**  当前页的所有记录 */
@property (nonatomic, strong) NSArray<WSFFieldListModel*> *records;
@end

