//
//  CommUtils.m
//  jianzhi
//
//  Created by Jiangwei on 15/5/27.
//  Copyright (c) 2015年 li. All rights reserved.
//

#import "CommUtils.h"
#import "PlayController.h"
#import "AutoRunLabel.h"

@implementation CommUtils


#pragma mark - 
#pragma mark - 倒计时转化

+ (NSString *)formatIntoDateWithSecond:(NSNumber *)sec
{
    NSUInteger h = [sec unsignedIntegerValue] / 3600;
    NSUInteger m = ([sec unsignedIntegerValue] / 60) % 60;
    NSUInteger s = [sec unsignedIntegerValue] % 60;
    
    NSString *formatteTime = nil;
    if (h == 0) {
        formatteTime = [NSString stringWithFormat:@"%02lu:%02lu",(unsigned long)m,(unsigned long)s];
    } else {
        formatteTime = [NSString stringWithFormat:@"%lu:%02lu:%02lu",(unsigned long)h,(unsigned long)m,(unsigned long)s];
    }
    return formatteTime;
}

#pragma mark - 
#pragma mark - 分割线

+ (UIImageView *)cuttingLineWithOriginx:(CGFloat)x andOriginY:(CGFloat)y;
{
    UIImageView * lineImg = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, mainscreenwidth - 2 * x, 0.5)];
    lineImg.image = [UIImage imageNamed:@"setting_list_line"];
    lineImg.backgroundColor = [UIColor darkGrayColor];
    return lineImg;
}

#pragma mark - 
#pragma mark - 滚动label

+(UIView *)labelView:(NSString *)title andLabel:(UILabel *)newLabel
{
    AutoRunLabel * navLabel = [[AutoRunLabel alloc]init];

    CGRect newFrame = newLabel.frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = 0;
    navLabel.frame = newFrame;
    
    navLabel.textColor = newLabel.textColor;
    navLabel.font = newLabel.font;
    navLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    navLabel.moveSpeech = -50.0f;
    navLabel.text = title;
    
//    CGSize _textSize = [title sizeWithFont:navLabel.font forWidth:NSIntegerMax lineBreakMode:NSLineBreakByClipping];
    
    return (UIView *)navLabel;
}

+(AutoRunLabel *)navTittle:(NSString *)title
{
    AutoRunLabel *titleText = [[AutoRunLabel alloc] initWithFrame: CGRectMake(0, 0, 200, 44)];
    titleText.textAlignment=NSTextAlignmentCenter;
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textColor=[UIColor whiteColor];
    titleText.text= title;
    titleText.font=[UIFont fontWithName:@"Helvetica-Bold" size:20.0];
    NSMutableString *muStr = [NSMutableString stringWithString:title];
    if (muStr.length > 5) {
        titleText.moveSpeech = -50.0f;
    }else{
        titleText.moveSpeech = 0;
    }
    [titleText sizeToFit];
    
    return titleText;
}

/**
 * @函数名称：progressValue
 * @函数描述：转化进度条
 * @输入参数：double
 * @输出参数：N/A
 * @返回值：NSString 返回字符串
 */
+(NSString *)progressValue:(double)value
{
    NSString *resultStr=[NSString stringWithFormat:@"%02d:%02d",(int)value/60,(int)value%60];
    return resultStr;
}

+(void)saveIndex:(NSInteger)index{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"playIndex"];
}
+(NSInteger)getPlayIndex{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"playIndex"];
}

+ (void)navigationPlayButtonItem:(UIButton *)btn
{
    NSMutableArray *anMuArr = [NSMutableArray arrayWithCapacity:19];
    for (int i=1; i<=19; i++) {
        NSString *str = [NSString stringWithFormat:@"play_%d",i];
        [anMuArr addObject:str];
    }
    
    NSMutableArray *anImgArr= [NSMutableArray arrayWithCapacity:0];
    for (int i= 0; i < [anMuArr count]; i++) {
        UIImage *img = [UIImage imageNamed:anMuArr[i]];
        [anImgArr addObject:img];
    }
    [btn.imageView setAnimationImages:anImgArr];
    [btn.imageView setAnimationDuration:0.9];
    if ([PlayController sharedPlayController].audioPlayer.state == STKAudioPlayerStatePlaying) {
        [btn.imageView startAnimating];
    }else{
        [btn.imageView stopAnimating];
    }
}

/**
 * @函数名称：checkNetworkStatus
 * @函数描述：检测网络状态
 * @输入参数：N/A
 * @输出参数：N/A
 */
#pragma mark
#pragma mark 检查当前网络是属于哪一种
+(NSInteger)checkNetworkStatus
{
    Reachability *currentReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([currentReach currentReachabilityStatus])
    {
        case NotReachable:
        {
                //            NSLog(@"2.网络中断");
            return NotReachable;
            break;
        }  
        case ReachableViaWWAN:
        {
                //            NSLog(@"正在使用3G网络");
            return ReachableViaWWAN;
            break;
        }
        case ReachableViaWiFi:
        {
                //            NSLog(@"正在使用wifi网络");
            return ReachableViaWiFi;
            break;
        }
    }
    
    return -1;
}

@end
