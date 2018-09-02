//
//  WSFOpinionBackVC.m
//  WinShare
//
//  Created by GZH on 2017/12/1.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "WSFOpinionBackVC.h"
#import "WSFOpinionCompleteVC.h"
#import "HX_AddPhotoView.h"
#import "HX_AssetManager.h"
#import "WSFUploadImageApi.h"
#import "WSFUploadImageModel.h"
#import "WSFFeedbackApi.h"

@interface WSFOpinionBackVC ()<UITextViewDelegate, HX_AddPhotoViewDelegate>

/**  意见反馈的输入框 */
@property (nonatomic, strong) UITextView *textView;
/**  占位符 */
@property (nonatomic, strong) UILabel *placehodelLabel;
/** 照片数组 */
@property (nonatomic, strong) NSMutableArray* photoArray;
/** 上传后照片数据模型 */
@property (nonatomic, copy) NSArray<WSFUploadImageModel *> *imageModelArray;

@end

@implementation WSFOpinionBackVC

- (UILabel *)placehodelLabel {
    if (_placehodelLabel == nil) {
        _placehodelLabel = [[UILabel alloc]init];
        _placehodelLabel.font = [UIFont systemFontOfSize:14];
        _placehodelLabel.textColor = [UIColor colorWithHexString:@"#cccccc"];
        _placehodelLabel.text = @"请输入详细问题，以便我们提供更好的帮助";
        [_placehodelLabel sizeToFit];
        [_textView addSubview:_placehodelLabel];
        [_placehodelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(_textView).offset(8);
        }];
    }
    return _placehodelLabel;
}

-(UITextView *)textView {
    if (_textView == nil) {
        _textView = [UITextView new];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.delegate = self;
        _textView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _textView.returnKeyType = UIReturnKeyDone;
    }
    return _textView;
}

- (NSMutableArray *)photoArray {
    if (_photoArray == nil) {
        _photoArray = [[NSMutableArray alloc] init];
    }
    return _photoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"意见反馈";
    self.photoArray = @[].mutableCopy;
    [self setContentView];
}

- (void)setContentView {
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.height.mas_equalTo(160);
    }];
    self.placehodelLabel.hidden = NO;

    UIButton *sureBtn = [[UIButton alloc]init];
    [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    sureBtn.backgroundColor = [UIColor colorWithHexString:@"#2b84c6"];
    [sureBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [sureBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [self.view addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@44);
    }];
    
    HX_AddPhotoView *addPhotoView = [[HX_AddPhotoView alloc] initWithMaxPhotoNum:4 WithSelectType:SelectPhoto];
    // 每行最大个数  不设置默认为4
    addPhotoView.lineNum = 3;
    addPhotoView.margin_Top = 0;
    addPhotoView.margin_Left = 0;
    addPhotoView.lineSpacing = 5;
    addPhotoView.delegate = self;
    addPhotoView.backgroundColor = [UIColor whiteColor];
    addPhotoView.frame = CGRectMake(10, 170 + 64, SCREEN_WIDTH - 20, 0);
    [self.view addSubview:addPhotoView];
    addPhotoView.backgroundColor = [UIColor colorWithHexString:@"#e5e5e5"];
    __weak typeof(self) weakSelf = self;
    [addPhotoView setSelectPhotos:^(NSArray *photos, NSArray *videoFileNames, BOOL iforiginal) {
        NSLog(@"photos.count1 = %lu",(unsigned long)photos.count);
        [weakSelf.photoArray removeAllObjects];
        [photos enumerateObjectsUsingBlock:^(id asset, NSUInteger idx, BOOL * _Nonnull stop) {
            // ios8.0 以下返回的是ALAsset对象 以上是PHAsset对象
            if ([HSSystem iOSSystemVersion].floatValue < 8.0) {
                UIImage *image = [UIImage imageWithCGImage:[asset aspectRatioThumbnail]];
                [weakSelf.photoArray addObject:image];
            }else {
                PHAsset *twoAsset = (PHAsset *)asset;
                CGSize size = CGSizeMake(twoAsset.pixelWidth, twoAsset.pixelHeight);
                [[HX_AssetManager sharedManager] accessToImageAccordingToTheAsset:twoAsset size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
                    [weakSelf.photoArray addObject:image];
                }];
            }
        }];
    }];
}

- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length > 0) {
        _placehodelLabel.hidden = YES;
    }else {
        _placehodelLabel.hidden = NO;
    }
    if ([textView.text containsString:@"\n"]) {
        NSMutableString *mStr = [NSMutableString stringWithString:textView.text];
        [mStr deleteCharactersInRange:NSMakeRange(mStr.length-1, 1)];
        textView.text = mStr;
        return;
    }
    [HSWordLimit computeWordCountWithTextView:self.textView warningLabel:nil maxNumber:1000];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

/**  提交按钮 */
- (void)submitAction {
    
    if ([self.textView.text isEqualToString:@""]) {
        [MBProgressHUD showMessage:@"请输入详细问题！"];
        return;
    }
    
    if (kNetworkNotReachability) {
        [MBProgressHUD showMessage:@"请连接网络！"];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:NO];
    if (_photoArray.count == 0) {   // 没有图片
        WSFFeedbackApi *feedbackApi = [[WSFFeedbackApi alloc] initWithTheContent:self.textView.text picIds:@""];
        [feedbackApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"request = %@",request);
            [MBProgressHUD hideHUDForView:self.view animated:NO];
            WSFOpinionCompleteVC *vc = [[WSFOpinionCompleteVC alloc]init];
            [self.navigationController pushViewController:vc animated:NO];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [MBProgressHUD hideHUDForView:self.view animated:NO];
            NSLog(@"request = %@",request);
        }];
    } else {    // 有图片
        WSFUploadImageApi *imageApi = [[WSFUploadImageApi alloc] init];
        [imageApi uploadWithImageArray:_photoArray overallProgress:^(CGFloat progress) {
            
        } success:^(NSArray<WSFUploadImageModel *> * _Nonnull model) {
            if (model.count == _photoArray.count) {
                NSMutableArray *picIdsArray = [[NSMutableArray alloc] init];
                for (WSFUploadImageModel *imageModel in model) {
                    [picIdsArray addObject:imageModel.imageID];
                }
                NSString *picIds = [picIdsArray componentsJoinedByString:@","];
                WSFFeedbackApi *feedbackApi = [[WSFFeedbackApi alloc] initWithTheContent:self.textView.text picIds:picIds];
                [feedbackApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
                    NSLog(@"request = %@",request);
                    [MBProgressHUD hideHUDForView:self.view animated:NO];
                    WSFOpinionCompleteVC *vc = [[WSFOpinionCompleteVC alloc]init];
                    [self.navigationController pushViewController:vc animated:NO];
                } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
                    [MBProgressHUD hideHUDForView:self.view animated:NO];
                    [MBProgressHUD showMessage:@"提交失败！"];
                }];
            }
        } failure:^(NSString * _Nonnull msg) {
            [MBProgressHUD hideHUDForView:self.view animated:NO];
            [MBProgressHUD showMessage:@"图片上传失败！"];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
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
