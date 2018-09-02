//
//  WSFMapEnum.h
//  WinShare
//
//  Created by GZH on 2017/11/28.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#ifndef WSFMapEnum_h
#define WSFMapEnum_h

typedef NS_ENUM(NSInteger, WSFLocationType) {
    WSFLocationType_defaultLocation = 0,
    WSFLocationType_scrLocation        ,        //当有筛选的位置存在的时候，显示筛选的位置
    WSFLocationType_selfLocation       ,        //回到自己的位置
    WSFLocationType_locationAndData    ,        //回到自己的位置并且保存数据
};

#endif /* WSFMapEnum_h */
