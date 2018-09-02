//
//  PlayController.h
//  huaqiangu
//
//  Created by Jiangwei on 15/7/18.
//  Copyright (c) 2015年 Jiangwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayController : UIViewController<STKAudioPlayerDelegate,GADBannerViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *PlayHeadView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *albTitle;

@property (weak, nonatomic) IBOutlet UISlider *playSlider;
@property (nonatomic, strong) TrackModel *playTrack;
@property (weak, nonatomic) IBOutlet UIButton *lastBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *playRightLabel;
@property (weak, nonatomic) IBOutlet UILabel *playLeftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property NSTimer *timer;
@property (nonatomic, strong) STKAudioPlayer* audioPlayer;
@property (nonatomic, copy) NSString *albumTitle;

@property (nonatomic, strong) NSArray *playArr;
@property NSInteger playIndex;

@property (weak, nonatomic) IBOutlet UIView *bannerView;


+(instancetype)sharedPlayController;
-(void)pushArr:(NSArray *)arr andIndex:(NSInteger)index;
-(void)playAction;
-(void)laseAction;
-(void)nextAction;
-(void)playMusic;
-(void) setupTimer:(BOOL)isBackGround;

@end
