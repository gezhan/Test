//
//  RoomCell.m
//  WinShare
//
//  Created by GZH on 2017/5/24.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "RoomCell.h"
#import "PasswordModel.h"

@interface RoomCell ()

@property (nonatomic, strong) UILabel *upLabel;  //地点
@property (nonatomic, strong) UILabel *downLabel;  //时间
@property (nonatomic, strong) UILabel *lastLabel;  //最下边的提示 -->>请在门锁上输入密码，进入空间

@property (nonatomic, strong) UILabel *upLineLabel;  //显示密码的框上边的线
@property (nonatomic, strong) UILabel *downLineLabel;  //显示密码的框下边的线

@end


@implementation RoomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self setContentView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}



- (void)setModel:(PasswordModel *)model {
    _model = model;
    _upLabel.text = model.RoomName;
    _downLabel.text = model.OrderTime;
   
    //已经获取到密码的情况
    if (model.Password.count > 0) {

        _lastLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
        _lastLabel.text = @"请在门锁上输入密码，进入空间";
        
        //填补密码
        for (int i = 0; i < 4; i++) {
            UILabel *label = [self.contentView viewWithTag:1000+i];
            NSString *tempStr = model.Password[i];
            label.text = [NSString stringWithFormat:@"%@",tempStr];
        }
        
        
    }else {
        

        //UI布局颜色的修改
        _upLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
        _downLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
        _upLineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        _downLineLabel.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        _lastLabel.textColor = [UIColor colorWithHexString:@"#2b84c6"];
        _lastLabel.text = @"开始前30分钟公布开锁密码";
        for (int i = 0; i < 5; i++) {
            UILabel *label = [self.contentView viewWithTag:800 + i];
            label.backgroundColor = [UIColor colorWithHexString:@"#cccccc"];
        }

        //将显示密码的label置空
        for (int i = 0; i < 4; i++) {
            UILabel *label = [self.contentView viewWithTag:1000+i];
            label.text = [NSString stringWithFormat:@""];
        }
        
    }
}


- (void)setContentView {
    _upLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.upLabel];
    _upLabel.font = [UIFont systemFontOfSize:14];
    _upLabel.textAlignment = NSTextAlignmentCenter;
    _upLabel.textColor = [UIColor colorWithHexString:@"#1a1a1a"];
    _upLabel.text = @"迪凯银座会议室";
    
    _downLabel = [[UILabel alloc]init];
    _downLabel.font = [UIFont systemFontOfSize:12];
    _downLabel.textAlignment = NSTextAlignmentCenter;
    _downLabel.textColor = [UIColor colorWithHexString:@"#808080"];
    _downLabel.text = @"2017.5.26 10:00-14:00";
    [self.contentView addSubview:self.downLabel];
    
    _upLineLabel = [UILabel new];
    _upLineLabel.backgroundColor = [UIColor colorWithHexString:@"#2b84c6"];
    [self.contentView addSubview:_upLineLabel];
    
    _downLineLabel = [UILabel new];
    _downLineLabel.backgroundColor = [UIColor colorWithHexString:@"#2b84c6"];
    [self.contentView addSubview:_downLineLabel];
    
    
    _lastLabel = [[UILabel alloc]init];
    _lastLabel.font = [UIFont systemFontOfSize:12];
    _lastLabel.textAlignment = NSTextAlignmentCenter;
    _lastLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
    _lastLabel.text = @"请在门锁上输入密码，进入空间";
    [self.contentView addSubview:self.lastLabel];
    
    [_upLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self).offset(15);
    }];
    [_downLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.upLabel.mas_bottom).offset(10);
    }];
    [_upLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.downLabel.mas_bottom).offset(15);
        make.height.equalTo(@0.5);
    }];
    [_downLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_upLineLabel.mas_left);
        make.right.equalTo(_upLineLabel.mas_right);
        make.top.equalTo(_upLineLabel.mas_top).offset(40);
        make.height.equalTo(@0.5);
    }];
    [_lastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(_downLineLabel.mas_bottom).offset(10);
    }];
    
    for (int i = 0; i < 5; i++) {
        
        UILabel *verLine = [UILabel new];
        verLine.tag = 800 + i;
        verLine.backgroundColor = [UIColor colorWithHexString:@"#2b84c6"];
        [self.contentView addSubview:verLine];
        
        if (i == 0) {
            
            [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_upLineLabel.mas_left);
                make.top.equalTo(_upLineLabel);
                make.bottom.equalTo(_downLineLabel);
                make.width.equalTo(@0.5);
            }];
        }else {
            
            if (i == 4) {
                [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(_upLineLabel.mas_right);
                    make.top.equalTo(_upLineLabel);
                    make.bottom.equalTo(_downLineLabel);
                    make.width.equalTo(@0.5);
                }];
            }else {
                
                CGFloat tempFloat = (SCREEN_WIDTH - 80 - 20 - 2.5)/4;
                [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(_upLineLabel.mas_left).offset(tempFloat * i);
                    make.top.equalTo(_upLineLabel).offset(5);
                    make.bottom.equalTo(_downLineLabel).offset(-5);
                    make.width.equalTo(@0.5);
                }];
                
            }
        }
        
        if (i != 4) {
            
            CGFloat tempFloat = (SCREEN_WIDTH - 80 - 20 - 15)/4;
            UILabel *numLabel = [UILabel new];
            numLabel.tag = 1000 + i;
            //numLabel.text = [NSString stringWithFormat:@"%d",i * 11];
            numLabel.textAlignment = NSTextAlignmentCenter;
            numLabel.textColor =  [UIColor colorWithHexString:@"#2b84c6"];
            [self.contentView addSubview:numLabel];
            
            [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(verLine.mas_right);
                make.centerY.equalTo(verLine.mas_centerY);
                make.width.equalTo(@(tempFloat));
            }];
            
        }
        
    }
}








- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
