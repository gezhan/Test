//
//  RecommendRoleVC.m
//  WinShare
//
//  Created by QIjikj on 2017/8/22.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "RecommendRoleVC.h"
#import "RecommendVM.h"
#import "RecommendActivityModel.h"

@interface RecommendRoleVC ()<UITextViewDelegate>
@property (nonatomic, copy) NSString *regulationString;// 规则的内容
@end

@implementation RecommendRoleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationContent];
    
    [self getRecommendRoleDataFromWeb];
}

#pragma mark - 获取网络数据-推荐有礼的规则数据
- (void)getRecommendRoleDataFromWeb
{
    
    [RecommendVM getRecommendDataSuccess:^(NSDictionary *recommendData) {
        
        RecommendActivityModel *recommendActivityModel = [RecommendActivityModel modelFromDict:recommendData];
        self.regulationString = recommendActivityModel.activityRegulation;
        [self setupViewContent];
        
    } failed:^(NSError *error) {
        NSLog(@"%@", error);
        
        
        BOOL showBool = (kNetworkNotReachability || [error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"请求超时。"]);
        [self.view viewDisplayNotFoundViewWithNetworkLoss:showBool withImageName:@"wangluoyichang" clickString:@"重新加载" clickBlock:^{
            
            [self getRecommendRoleDataFromWeb];
        }];
        
    }];
}

#pragma mark - 基础界面的搭建
- (void)setupNavigationContent
{
    self.navigationItem.title = @"规则";
}

- (void)setupViewContent
{
    NSString *roleString = [self.regulationString stringByReplacingOccurrencesOfString:@"赢享" withString:@"有个"];
    
    UITextView *roleTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    roleTextView.delegate = self;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    roleTextView.attributedText =[[NSAttributedString alloc] initWithString: roleString attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.f], NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#1a1a1a"], NSParagraphStyleAttributeName: paragraphStyle}];
    
    
    [self.view addSubview:roleTextView];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
