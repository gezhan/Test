//
//  HKLPickerView.m
//  safeepay-ios-new
//
//  Created by san_xu on 2016/11/28.
//  Copyright © 2016年 com.app.huakala. All rights reserved.
//

#import "HKLPickerView.h"
#import "SpaceModel.h"
#import "WSFTimeManager.h"
/** 屏幕宽度*/
#define HKL_ScreenHeight  [UIScreen mainScreen].bounds.size.height
/** 屏幕高度*/
#define HKL_ScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface HKLPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak,nonatomic)UIView * bottomContainerView;
@property (weak,nonatomic)UIPickerView * pickerView;
@property (assign,nonatomic)BOOL isLimit;
@property (nonatomic, strong) SpaceModel *model;
@property (nonatomic, strong) NSMutableArray *pointTimeTodayArray;
/**  现在的时间 */
@property (nonatomic, strong) NSString *timeNow;
@property (nonatomic, strong) NSString *today;

@end

@implementation HKLPickerView


#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _pointTimeTodayArray = [NSMutableArray array];
        _timeNow = [NSString getNextTimeAction:0 andYear:YES];
        _model = [[SpaceModel alloc]initWithData];

        //今天时间的从新匹配
        for (int i = 0; i < _model.pointTimeArray.count ; i++) {
            NSString *titleStr = _model.pointTimeArray[i];
            if (titleStr.length == 4) {
                titleStr = [@"0" stringByAppendingString:titleStr];
            }
            
            if ([titleStr compare: _timeNow] == NSOrderedDescending) {
            
                NSString *tempStr = [titleStr substringWithRange:NSMakeRange(0, 1)];
                if ([tempStr isEqualToString:@"0"]) {
                    titleStr = [titleStr substringFromIndex:1];
                }
             
                [_pointTimeTodayArray addObject:titleStr];
            }
        }

        UIPickerView * pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, HKL_ScreenWidth, 179)];
        self.pickerView = pickerView;
        pickerView.backgroundColor = [UIColor whiteColor];
        pickerView.dataSource = self;
        pickerView.delegate = self;
        [self addSubview:pickerView];
        
    }
    return self;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:14]];
        pickerLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    pickerLabel.textAlignment = NSTextAlignmentCenter;
    return pickerLabel;
}

- (void)translucentBackgroundBtn {
    
    if (self.dataSource.count == 3) {
        //把数据处理成他需要的格式   --@"yyyy-MM-dd HH:mm:ss"
        if (self.confirmBtnClickBlock) {
            
            //展示需要的数据
            NSMutableArray * tempArr = [NSMutableArray array];
            
            //后台需要的数据
            NSString *dateStr = nil;
            NSString *pointTime= nil;
            NSString *timeStr = nil;
            for (int i = 0; i < self.dataSource.count; i++) {
                NSInteger index = [self.pickerView selectedRowInComponent:i];
                if (i == 0) {
                    if (index == 0) {
                        dateStr = @"";
                        [tempArr addObject:@"不限"];
                    }else
                        dateStr = [NSString getNextTimeAction:index-1 andYear:NO];
                    if (index == 1) {
                        [tempArr addObject:@"今天"];
                    }else if (index == 2) {
                        [tempArr addObject:@"明天"];
                    }
                }
                if (i == 1) {
                    if ([_today isEqualToString:@"today"]) {
                         if(index < _pointTimeTodayArray.count)pointTime = _pointTimeTodayArray[index];
                    }else {
                        pointTime = self.dataSource[i][index];
                    }
                    if (pointTime.length == 0) {
                        pointTime = @"00:00";
                    }
                    if (pointTime.length == 4) {
                        pointTime = [@"0" stringByAppendingString:pointTime];
                    }
                }
                
                if (i == 2) {
                    timeStr = self.dataSource[i][index];
                    timeStr = [timeStr stringByReplacingOccurrencesOfString:@"小时" withString:@""];
                }
            }
            
            if (![dateStr isEqualToString:@""]) {
                dateStr = [dateStr stringByReplacingCharactersInRange:NSMakeRange(11, 5) withString:pointTime];
            }
            NSNumber *num = @([timeStr integerValue]);
            NSArray *array = @[dateStr, num];
            
            if (tempArr.count == 0) {
                [tempArr addObjectsFromArray:array];
            }
            
            self.confirmBtnClickBlock(tempArr.copy, array.copy);
        }
    }else {
        
        //展示需要的数据
        NSMutableArray * tempArr = [NSMutableArray array];
        NSInteger index1 = [self.pickerView selectedRowInComponent:0];
        [tempArr addObject:self.dataSource[index1]];
        
        //后台需要的数据
        NSMutableArray *array = [NSMutableArray array];
        NSInteger index = [self.pickerView selectedRowInComponent:0];
        NSString *countPeo = self.dataSource[index];
        if ([countPeo containsString:@"以上"]) {
            countPeo = [countPeo stringByReplacingOccurrencesOfString:@"人以上" withString:@""];
            [array addObject:@([countPeo integerValue])];
            [array addObject:[NSNumber numberWithInt:1000]];
            if (self.confirmBtnClickBlock) self.confirmBtnClickBlock(tempArr.copy, array.copy);
        }else {
            
            countPeo = [countPeo stringByReplacingOccurrencesOfString:@"人" withString:@""];
            NSRange range = [countPeo rangeOfString:@"-"];
            NSString *result1 = [countPeo substringToIndex:range.location];
            NSString *result2 = [countPeo substringFromIndex:range.location + 1];
            [array addObject:@([result1 integerValue])];
            [array addObject:@([result2 integerValue])];
            
            if (self.confirmBtnClickBlock) self.confirmBtnClickBlock(tempArr.copy, array.copy);
        }
    }
}

#pragma mark - 数据源赋值
- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    _isLimit = NO;
}

- (void)setReSetStr:(NSString *)reSetStr {
    _reSetStr = reSetStr;
     _isLimit = NO;
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    [self.pickerView reloadAllComponents];
}

- (void)setSelectedArray:(NSArray *)selectedArray {
    _selectedArray = selectedArray;

    
    NSInteger tempRow = 0;
    if (![selectedArray[0] isEqualToString:@""]) {
        _isLimit = YES;
        
        //获取日期
        NSString *dataNow = [self getFixDataWithNewFormatter:@"MM/dd" oldStr:selectedArray[0]];
        for (int i = 0; i < _model.tureDataArray.count; i++) {
            NSString *str = _model.tureDataArray[i];
            if ([dataNow isEqualToString:str]) {
                [self.pickerView selectRow:i inComponent:0 animated:NO];
                tempRow = i;
            }
        }
        
        //获取时间点
        NSString *timeNow = [self getFixTimeWithNewFormatter:@"HH:mm" oldStr:selectedArray[0]];
        if (tempRow == 1) {
            
            _today = @"today";
            
            if ([timeNow compare: _timeNow] == NSOrderedDescending) {
                for (int i = 0; i < _pointTimeTodayArray.count; i++) {
                    NSString *str = _pointTimeTodayArray[i];
                    if ([timeNow isEqualToString:str]) {
                        [self.pickerView selectRow:i inComponent:1 animated:NO];
                    }
                }
            }else {
                
                [self.pickerView selectRow:0 inComponent:1 animated:NO];
            }
        
        }else {
            
            _today = @"";
            for (int i = 0; i < _model.pointTimeArray.count; i++) {
                NSString *str = _model.pointTimeArray[i];
                if ([timeNow isEqualToString:str]) {
                    
                    [self.pickerView selectRow:i inComponent:1 animated:NO];
                }
            }
        }
        
        //获取预定时间
        NSString *durationTime = [NSString stringWithFormat:@"%@小时",selectedArray[1]];
        for (int i = 0; i < _model.timeArray.count; i++) {
            NSString *str = _model.timeArray[i];
            if ([durationTime isEqualToString:str]) {
                
                [self.pickerView selectRow:i inComponent:2 animated:NO];
            }
        }
    }
}

#pragma mark - UIPickerView DataSource


- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 36;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.dataSource.count == 3) {
        return self.dataSource.count;
    }
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (self.dataSource.count == 3) {
        for (int i = 0; i < self.dataSource.count; i++) {
            //不限按钮被选中的时候
            if (!_isLimit) {
                if(i == component && component == 0) {
                    NSArray * tempArr = self.dataSource[i];
                    
                    return tempArr.count;
                }else {
                    
                    return 0;
                }
            }else {
                
                //选择除了不限之外的按钮
                if (i == component) {
                    
                    if (i == 1 && [_today isEqualToString:@"today"]) {
                        return _pointTimeTodayArray.count;
                    }else {
                        
                        NSArray * tempArr = self.dataSource[i];
                        return tempArr.count;
                    }
                }
            }
            
        }
    }
    
    return self.dataSource.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        
        if (row == 1) {
            _today = @"today";
        }else {
             _today = @"";
        }
        
        if (row != 0) {
            _isLimit = YES;
        }else {
            _isLimit = NO;
        }
        [self.pickerView reloadAllComponents];
    }
    
    [self translucentBackgroundBtn];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (self.dataSource.count == 3) {
        if (0 == component) {
            return self.dataSource[0][row];
        }
        if (1 == component) {

            if ([_today isEqualToString:@"today"]) {
                return self.pointTimeTodayArray[row];
            }else {
                
                return self.dataSource[1][row];
            }
            
        }
        if (2 == component) {
            return self.dataSource[2][row];
        }
    }
    
    return nil;
}


//将时间点处理的格式
- (NSString *)getFixTimeWithNewFormatter:(NSString *)newForm oldStr:(NSString *)oldStr {
    NSString *dataStr = [NSString dateStrWithNewFormatter:newForm oldStr:oldStr oldFormatter:@"yyyy-MM-dd HH:mm:ss"];
    NSString *tempStr = [dataStr substringWithRange:NSMakeRange(0, 1)];
    if ([tempStr isEqualToString:@"0"]) {
        dataStr = [dataStr substringFromIndex:1];
    }
    return dataStr;
}

//将日期处理的格式
- (NSString *)getFixDataWithNewFormatter:(NSString *)newForm oldStr:(NSString *)oldStr {
    NSString *dataStr = [NSString dateStrWithNewFormatter:newForm oldStr:oldStr oldFormatter:@"yyyy-MM-dd HH:mm:ss"];
//    dataStr = [TimeModel getNavDateTodayWithdateStr:dataStr];
    dataStr = [WSFTimeManager getNavDateTodayWithdateStr:dataStr];
    dataStr = [dataStr stringByReplacingOccurrencesOfString:@"/" withString:@"月"];
    dataStr = [NSString stringWithFormat:@"%@日", dataStr];
    
    return dataStr;
}

- (void)dealloc {
    NSLog(@"HKLPickerView dealloc");
}
@end
