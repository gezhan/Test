//
//  WSFActivityPostersVC.m
//  WinShare
//
//  Created by GZH on 2018/2/7.
//  Copyright © 2018年 QiJikj. All rights reserved.
//

#import "WSFActivityPostersVC.h"
#import "WSFActivityPostersTV.h"

@interface WSFActivityPostersVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) WSFActivityPostersTV *postersTV;  //tableView
@property (nonatomic, strong) UIButton *beSureBtn;  //确定按钮
@property (nonatomic, strong) NSMutableArray<UIImage *> *photoArray;  //选择的图片数组
@end

@implementation WSFActivityPostersVC

- (UIButton *)beSureBtn {
    if (_beSureBtn == nil) {
        _beSureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_beSureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_beSureBtn addTarget:self action:@selector(beSureAction) forControlEvents:UIControlEventTouchUpInside];
        [_beSureBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#2b84c6"]] forState:UIControlStateNormal];
        [_beSureBtn setBackgroundImage:[UIImage imageFromColor:[UIColor colorWithHexString:@"#cccccc"]] forState:UIControlStateSelected];
        [self.view addSubview:_beSureBtn];
        [_beSureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(self.view);
            make.height.equalTo(@50);
        }];
    }
    return _beSureBtn;
}

- (WSFActivityPostersTV *)postersTV {
    if (_postersTV == nil) {
        _postersTV = [[WSFActivityPostersTV alloc]init];
        __weak typeof(self) weakSelf = self;
        _postersTV.photoBlock = ^(NSInteger indexRow) {
            [weakSelf.photoArray removeObjectAtIndex:indexRow];
            weakSelf.postersTV.photoArray = weakSelf.photoArray;
            [weakSelf.postersTV reloadData];
        };
        [self.view addSubview:_postersTV];
        _postersTV.tableFooterView = [self tableFooterView];
        [_postersTV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view);
            make.bottom.equalTo(_beSureBtn.mas_top);
        }];
    }
    return _postersTV;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupContentView];
}

- (void)setupContentView {
    self.navigationItem.title = @"宣传图片";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    
    _photoArray = [NSMutableArray array];
    
    self.beSureBtn.hidden = NO;
    self.postersTV.hidden = NO;
    
}

/**  确定 */
- (void)beSureAction {
    NSLog(@"--------确定" );
}

/**  tableView的区尾 */
- (UIView *)tableFooterView {
    UIView *footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 166);
    footerView.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    UIButton *addBtn = [UIButton Z_createButtonWithTitle:@"" buttonFrame:CGRectZero layerMask:NO textFont:12 colorStr:@"" cornerRadius:0];
    addBtn.backgroundColor = [UIColor cyanColor];
    [addBtn addTarget:self action:@selector(addPhotoAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(footerView).offset(15);
        make.right.mas_equalTo(footerView).offset(-15);
        make.bottom.mas_equalTo(footerView.mas_bottom);
    }];
    return footerView;
}

#pragma mark - 添加图片
/**  添加图片 */
- (void)addPhotoAction {
    NSLog(@"------添加图片" );
    CustormAlertBottomView *alertVC = [[CustormAlertBottomView alloc]init];
    alertVC.titleArr = @[@"相册", @"拍照"];
    alertVC.clickBlock = ^(NSInteger indexRow) {
        if (indexRow == 0) {
            [self openLocalPhoto];
        }else {
            [self takePhoto];
        }
    };
    alertVC.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    alertVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    alertVC.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.4];
    [self presentViewController:alertVC animated:NO completion:nil];
}

// 打开本地相册 UIImagePickerControllerSourceTypeSavedPhotosAlbum
- (void)openLocalPhoto {
    UIImagePickerController *pick = [[UIImagePickerController alloc] init];
    pick.delegate = self;
    pick.allowsEditing = YES;
    pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pick animated:NO completion:nil];
}

// 拍照
- (void)takePhoto {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pick = [[UIImagePickerController alloc] init];
        pick.delegate = self;
        pick.allowsEditing = YES;
        pick.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pick animated:NO completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"没有摄像头" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}
#pragma mark - UINavigationControllerDelegate
// 照片获取完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:NO completion:nil];
    UIImage *img = info[@"UIImagePickerControllerEditedImage"];
    [_photoArray addObject:img];
    _postersTV.photoArray = _photoArray.mutableCopy;
}

//取消获取照片
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
