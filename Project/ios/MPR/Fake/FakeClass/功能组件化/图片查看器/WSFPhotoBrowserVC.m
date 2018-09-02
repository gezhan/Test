//
//  WSFPhotoBrowserVC.m
//  WinShare
//
//  Created by QIjikj on 2018/2/4.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFPhotoBrowserVC.h"
#import "WSFPhotoBrowserView.h"

@interface WSFPhotoBrowserVC () <UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) BOOL isLoaded;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) WSFPhotoBrowserView *enlargePhotoView;

@end

@implementation WSFPhotoBrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.scrollView];
    
    // 单击
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction)];
    [self.scrollView addGestureRecognizer:singleTap];
    
    // 双击
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] init];
    doubleTap.numberOfTapsRequired = 2;
    [self.scrollView addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    // 防止双击进来又退出
    [self performSelector:@selector(viewLoaded) withObject:nil afterDelay:0.8];
    
    //
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 15 - 20, SCREEN_WIDTH, 20)];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    self.titleLabel.userInteractionEnabled = YES;
    [self.view addSubview:self.titleLabel];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:NO];
}

- (void)viewLoaded
{
    self.isLoaded = YES;
}

// 单击事件
- (void)singleTapAction
{
    if (self.isLoaded) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:NO];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

#pragma mark - Scrollew Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageIndex = (scrollView.contentOffset.x/ SCREEN_WIDTH)+0.5;
    self.titleLabel.text = [NSString stringWithFormat:@"%d/%d", (int)self.pageIndex+1, (int)self.photos.count];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.enlargePhotoView) {
        [self.enlargePhotoView recoveryNormalMode];
    }
}

/** 传入图片URL数组*/
- (void)setupPhotoURLList:(NSArray *)photoArray selectedIndex:(NSInteger)index {
    _photos = photoArray;
    
    self.scrollView.contentSize = CGSizeMake(photoArray.count * SCREEN_WIDTH, SCREEN_HEIGHT);
    for (int i = 0; i < photoArray.count; i++) {
        
        WSFPhotoBrowserView *photoView = [[WSFPhotoBrowserView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
        if ([photoArray[i] isKindOfClass:[NSURL class]]) {
            [photoView setupPhotoUrl:photoArray[i]];
        }else {
            NSURL *tempURL = [NSURL URLWithString:(NSString *)photoArray[i]];
            [photoView setupPhotoUrl:tempURL];
        }
        photoView.enlargeBlock = ^void(WSFPhotoBrowserView *view) {
            self.enlargePhotoView = view;
        };
        
        [self.scrollView addSubview:photoView];
    }
    self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
    
    self.titleLabel.text = [NSString stringWithFormat:@"%d/%d", (int)index+1, (int)photoArray.count];
}

/** 传入图片Image数组*/
- (void)setupPhotoImageList:(NSArray<UIImage *> *)photoArray selectedIndex:(NSInteger)index {
    _photos = photoArray;
    
    self.scrollView.contentSize = CGSizeMake(photoArray.count * SCREEN_WIDTH, SCREEN_HEIGHT);
    for (int i = 0; i < photoArray.count; i++) {
     
        WSFPhotoBrowserView *photoView = [[WSFPhotoBrowserView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [photoView setupPhoto:photoArray[i]];
        photoView.enlargeBlock = ^void(WSFPhotoBrowserView *view) {
            self.enlargePhotoView = view;
        };
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
        view.backgroundColor = [UIColor redColor];
        
        [self.scrollView addSubview:view];
    }
    
    self.scrollView.contentOffset = CGPointMake(SCREEN_WIDTH * index, 0);
    
    self.titleLabel.text = [NSString stringWithFormat:@"%d/%d", (int)index+1, (int)photoArray.count];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
