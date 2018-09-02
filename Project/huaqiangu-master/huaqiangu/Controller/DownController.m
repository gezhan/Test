//
//  DownController.m
//  huaqiangu
//
//  Created by JiangWeiGuo on 16/2/23.
//  Copyright © 2016年 Jiangwei. All rights reserved.
//

#import "DownController.h"
#import "DownCell.h"
#import "HSDownloadManager.h"
#import "MainList.h"

@interface DownController ()

@end

@implementation DownController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self naviAction];
    [self initDownAction];
}


+ (DownController *)sharedManager
{
    static DownController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

#pragma mark - 获取页面数据

-(void)getDownData
{
     _downMuArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.downingMuArray removeAllObjects];
    NSArray *mainArr = [[MainList sharedManager] getMainArray];
    
    TrackModel *newModel = [[TrackModel alloc]init];
    newModel.title = @"全选";
    [self.downMuArray addObject:newModel];
    [self.downMuArray addObjectsFromArray:mainArr];
    [self.downTbView reloadData];
}

#pragma mark - 
#pragma mark - 导航栏处理
-(void)naviAction
{
    self.navigationItem.leftBarButtonItem = [LMButton setNavleftButtonWithImg:@"back" andSelector:@selector(backAction) andTarget:self];
    self.navigationItem.titleView = [CommUtils navTittle:@"选择节目"];
}

-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

#pragma mark - 
#pragma mark - 初始化相关参数
-(void)initDownAction
{    
    self.downTbView.frame = CGRectMake(0, 0, mainscreenwidth, mainscreenhight - 50);
    self.downFootView.frame = CGRectMake(0, mainscreenhight - 50, mainscreenwidth, 50);
    
    self.downTbView.backgroundColor = RGB(230, 227, 219);
    self.downFootView.backgroundColor = [UIColor darkGrayColor];
    
    [self.downBtn setTitle:@"下载" forState:UIControlStateNormal];
    [self.downBtn addTarget:self action:@selector(downMessage) forControlEvents:UIControlEventTouchUpInside];
    
    [self setFrame];
}

-(void)setFrame{
    self.downBtn.frame = CGRectMake(137 * VIEWWITH, 12 * VIEWWITH, 46 * VIEWWITH, 30 * VIEWWITH);
}

#pragma mark - 
#pragma mark - 下载方法

-(void)downMessage
{
    if ([CommUtils checkNetworkStatus] != ReachableViaWiFi) {
        [UIAlertView showWithTitle:@"温馨提示" message:@"为了节省您的流量，目前只支持WIFI下载" cancelButtonTitle:@"我知道了" otherButtonTitles:nil tapBlock:nil];
    }
    [self downAction];
}

-(void)downAction{
    NSLog(@"下载");
   
    _downingMuArray = [NSMutableArray arrayWithCapacity:0];
    
    [self.downMuArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock: ^(TrackModel *track,NSUInteger idx, BOOL *stop){
        if ((track.isSelected && [track.downStatus isEqualToString:@"on"]) || [track.downStatus isEqualToString:@"doing"]) {
            track.downStatus = @"doing";
            [[MainList sharedManager] mergeWithContent:track];
            [self.downingMuArray addObject:track];
        }
    }];
    
    if (self.downingMuArray.count != 0) {
        TrackModel *track = self.downingMuArray[0];
        if ([CommUtils checkNetworkStatus] == ReachableViaWiFi) {
            [self download:track.playUrl64 progressLabel:nil progressView:nil button:nil];
        }
    }
    
    [self backAction];
}

#pragma mark - tableview代理方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.downMuArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MainCellIdentifier = @"DownCell";
    DownCell *cell = [tableView dequeueReusableCellWithIdentifier:MainCellIdentifier];
    if (!cell) {
        cell = (DownCell *)CREAT_XIB(@"DownCell");
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.nameLabel.textColor = [UIColor blackColor];
    }
    TrackModel *track = self.downMuArray[indexPath.row];
    [cell setDownCell:track];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DownCell *newCell = (DownCell *)[tableView cellForRowAtIndexPath:indexPath];
    newCell.chooseBtn.selected = !newCell.chooseBtn.selected;
    
    //更换子类选中状态
    TrackModel *track = self.downMuArray[indexPath.row];
    track.isSelected = newCell.chooseBtn.selected;
    
    if (indexPath.row == 0) {
        if (newCell.chooseBtn.selected == YES) {
            [self.downMuArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock: ^(TrackModel *track,NSUInteger idx, BOOL *stop){
                track.isSelected = YES;
            }];
        }else{
            [self.downMuArray enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock: ^(TrackModel *track,NSUInteger idx, BOOL *stop){
                track.isSelected = NO;
            }];
        }
        [self.downTbView reloadData];
    }
}

#pragma mark 开启任务下载资源
- (void)download:(NSString *)url progressLabel:(UILabel *)progressLabel progressView:(UIProgressView *)progressView button:(UIButton *)button
{
    [[HSDownloadManager sharedInstance] download:url progress:^(NSInteger receivedSize, NSInteger expectedSize, CGFloat progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ;
        });
    } state:^(DownloadState state) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (state == DownloadStateCompleted) {
                TrackModel *track = self.downingMuArray[0];
                track.downStatus = @"done";
                [[MainList sharedManager] mergeWithContent:track];
                
                [self.downingMuArray removeObjectAtIndex:0];
                if (self.downingMuArray.count != 0) {
                    TrackModel *track = self.downingMuArray[0];
                    [self download:track.playUrl64 progressLabel:nil progressView:nil button:nil];
                }
            }
        });
    }];
}

#pragma mark 按钮状态
- (NSString *)getTitleWithDownloadState:(DownloadState)state
{
    switch (state) {
        case DownloadStateStart:
            return @"暂停";
        case DownloadStateSuspended:
        case DownloadStateFailed:
            return @"开始";
        case DownloadStateCompleted:
            return @"完成";
        default:
            break;
    }
}
@end
