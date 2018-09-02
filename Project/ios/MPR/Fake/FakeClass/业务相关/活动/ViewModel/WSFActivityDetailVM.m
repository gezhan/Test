//
//  WSFActivityDetailVM.m
//  WinShare
//
//  Created by GZH on 2018/3/6.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityDetailVM.h"
#import "NSMutableAttributedString+WSFExtend.h"
#import "WSFRPAppEventApiResModel.h"


@implementation WSFActivityIntroductionVM


@end


@interface WSFActivityDetailVM ()

@property (nonatomic, strong) WSFRPAppEventApiResModel *resModel;

@end

@implementation WSFActivityDetailVM

- (instancetype)initWithAppEventResMode:(WSFRPAppEventApiResModel *)resModel {
    self = [super init];
    if (self) {
        
        _resModel = resModel;

        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
        [self mainContent:attributedText addTitle:@"报名时间 : " content:[NSString stringWithFormat:@"%@-%@", [self dateStringFromString:resModel.applyBeginDate], [self dateStringFromString:resModel.applyEndDate]] newLine:YES];
        [self mainContent:attributedText addTitle:@"活动时间 : " content:[NSString stringWithFormat:@"%@-%@", [self dateStringFromString:resModel.eventBeginTime], [self dateStringFromString:resModel.eventEndTime]] newLine:YES];
        [self mainContent:attributedText addTitle:@"举办空间 : " content:resModel.roomName newLine:YES];
        [self mainContent:attributedText addTitle:@"报名情况 : " content:[NSString stringWithFormat:@"已经报名%ld", (long)resModel.man] newLine:NO];
        [self mainContent:attributedText addTitle:[NSString stringWithFormat:@"/限%ld人报名   注意事项", (long)resModel.manTop] content:@"" newLine:YES];
        NSString *tempPrice = resModel.enrolmentFee == 0 ?  @"免费" : [resModel.enrolmentFee stringValue];
        [self mainContent:attributedText addTitle:@"报名费用 : " content:tempPrice newLine:NO];
        [attributedText wsf_setLineSpace:8 range:NSMakeRange(0, attributedText.length)];
        
        //活动简介
        for (int i = 0; i < resModel.intros.count; i++) {
            WSFRPEventIntroApiResModel *model = resModel.intros[i];
            WSFActivityIntroductionVM *introductionVM = [[WSFActivityIntroductionVM alloc]init];
            introductionVM.title = model.title;
            introductionVM.content = model.introContent;
            introductionVM.Id = model.Id;
            [self.introductionArray addObject:introductionVM];
        }
        //轮播图
        for (int i = 0; i < resModel.picture.count; i++) {
            WSFRPPhotoApiModel *model = resModel.picture[i];
            [self.photoArray addObject:[NSString replaceString:model.path]];
        }
        
        self.price = [resModel.enrolmentFee floatValue];
        self.name = resModel.name;
        self.detailString = attributedText;
        self.manDown = resModel.manDown;
        self.lng = [resModel.lng doubleValue];
        self.lat = [resModel.lat doubleValue];
        self.address = resModel.address;
        self.tel = resModel.tel;
        self.roomShareUrl = resModel.shareUrl;
        
        int beginInt = [self compareOneDay:[NSDate date] withAnotherDay:[self getDateFromString:resModel.applyBeginDate sign:0]];
        int endInt = [self compareOneDay:[NSDate date] withAnotherDay:[self getDateFromString:resModel.applyEndDate sign:1]];
        if (beginInt == -1) {
            self.btnTitle = @"活动还未开始";
            self.stateSign = 1;
        }else if ((beginInt == 1 || beginInt == 0) && endInt == -1) {
            self.btnTitle = @"我要报名";
            self.stateSign = 2;
        }else if (endInt == 1) {
            self.btnTitle = @"报名已截止";
            self.stateSign = 2;
        }
        

        
    }
    return self;
}

- (NSMutableArray *)introductionArray {
    if (!_introductionArray) {
        _introductionArray = [NSMutableArray array];
    }
    return _introductionArray;
}

- (NSMutableArray *)photoArray {
    if (_photoArray == nil) {
        _photoArray = [NSMutableArray array];
    }
    return _photoArray;
}

/**  将富文本加工成需要展示的样子 */
-(void)mainContent:(NSMutableAttributedString *)mainContent addTitle:(id)title content:(id)content newLine:(BOOL)newLine {
    if (title == nil)  title = @"" ;
    if (content == nil) content = @"" ;
    if (newLine == YES) content = [NSString stringWithFormat:@"%@\n",content];
    [mainContent wsf_addString:title font:SYSTEMFONT_13 color:HEX_COLOR_0x808080];
    [mainContent wsf_addString:content font:SYSTEMFONT_13 color:HEX_COLOR_0x1A1A1A];
}

/**  将时间转换成需要展示的的格式 */
- (NSString *)dateStringFromString:(NSString *)dateString{
    NSString *tempString = [dateString substringToIndex:10];
    tempString = [tempString stringByReplacingOccurrencesOfString:@"-"withString:@"/"];
    return tempString;
}

#pragma mark --日期--
/**  将现在的时间与指定时间比较，如果没达到指定日期，返回-1，刚好是这一时间，返回0，否则返回1 */
- (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        return 1;
    } else if (result == NSOrderedAscending){
        return -1;
    }
    return 0;
}

/**  将字符串转换为NSDate格式
  *  sign 0为开始时间 1为结束时间
 */
-(NSDate *)getDateFromString:(NSString *)dateString sign:(NSInteger)sign{
    if (sign == 0) {
        dateString = [dateString stringByReplacingCharactersInRange:NSMakeRange(11, 2) withString:@"00"];
    }else {
        dateString = [dateString stringByReplacingCharactersInRange:NSMakeRange(11, 8) withString:@"23:59:59"];
    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date =[dateFormat dateFromString:dateString];
    return date;
}

@end
