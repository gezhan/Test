//
//  ScanQrCodeVC.m
//  WinShare
//
//  Created by GZH on 2017/5/9.
//  Copyright © 2017年 QiJikj. All rights reserved.
//

#import "ScanQrCodeVC.h"
#import "BaseTapSound.h"
#import <AVFoundation/AVFoundation.h>
#import "WSFDrinkTicketReclaimDetailVC.h"

@interface ScanQrCodeVC ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate>{
    SystemSoundID soundID;
    float move;
}
@property (strong , nonatomic) AVCaptureDevice *device;
@property (strong , nonatomic) AVCaptureDeviceInput *input;
@property (strong , nonatomic) AVCaptureMetadataOutput *output;
@property (strong , nonatomic) AVCaptureSession *session;
@property (strong , nonatomic) AVCaptureVideoPreviewLayer *preview;
@property (strong , nonatomic) UIImageView  *qrView;
@property (strong , nonatomic) UIImageView *lineLabel;
@property (strong , nonatomic) NSTimer *lineTimer;
@property (strong , nonatomic) UIView *otherPlatformLoginView;

@end

@implementation ScanQrCodeVC

- (void)dealloc{
    if ([_lineTimer isValid]) {
        [_lineTimer invalidate];
        _lineTimer = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    if (_session) {
        [_session startRunning ];
        if (_lineTimer) {
            [_lineTimer invalidate];
            _lineTimer = nil;
        }
        _lineTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveLine) userInfo:nil repeats:YES];
        _lineLabel.hidden = NO;
        
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"扫一扫";
    
    move = 1.0;
    //扫描区域宽、高大小
    float QRWIDTH = 200;
    
    //创建扫描区域框
    _qrView=[[UIImageView alloc]init];
    _qrView.frame = CGRectMake((SCREEN_WIDTH - QRWIDTH)/2, (SCREEN_HEIGHT - QRWIDTH)/2-50, QRWIDTH, QRWIDTH);
    _qrView.backgroundColor = [UIColor clearColor];
    _qrView.image = [UIImage imageNamed:@"kuang_blue"];
    [self.view addSubview:_qrView];
    
    _lineLabel = [[UIImageView alloc]initWithFrame:CGRectMake(_qrView.frame.origin.x+2.0, _qrView.frame.origin.y + 2.0, _qrView.frame.size.width - 4.0, 3.0)];
    _lineLabel.image = [UIImage imageNamed:@"xian_blue"];
    [self.view addSubview:_lineLabel];
    
    //半透明背景
    UIView *qrBacView = [[UIView alloc]init];//上
    qrBacView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _qrView.frame.origin.y);
    qrBacView.backgroundColor = [UIColor blackColor];
    qrBacView.alpha = 0.6;
    [self.view addSubview:qrBacView];
    
    qrBacView = [[UIView alloc]init];//左
    qrBacView.frame = CGRectMake(0, _qrView.frame.origin.y, _qrView.frame.origin.x, QRWIDTH);
    qrBacView.backgroundColor = [UIColor blackColor];
    qrBacView.alpha = 0.6;
    [self.view addSubview:qrBacView];
    
    qrBacView = [[UIView alloc]init];//下
    qrBacView.frame = CGRectMake(0, _qrView.frame.origin.y + QRWIDTH, SCREEN_WIDTH, SCREEN_HEIGHT - _qrView.frame.origin.y - QRWIDTH);
    qrBacView.backgroundColor = [UIColor blackColor];
    qrBacView.alpha = 0.6;
    [self.view addSubview:qrBacView];
    
    qrBacView = [[UIView alloc]init];//右
    qrBacView.frame = CGRectMake(_qrView.frame.origin.x + QRWIDTH, _qrView.frame.origin.y, SCREEN_WIDTH - _qrView.frame.origin.x - QRWIDTH, QRWIDTH);
    qrBacView.backgroundColor = [UIColor blackColor];
    qrBacView.alpha = 0.6;
    [self.view addSubview:qrBacView];
    
    UILabel *signLabel = [UILabel Z_createLabelWithFrame:CGRectMake(20, _qrView.bottom + 20, SCREEN_WIDTH - 40, 17) title:@"请对准解锁二维码扫码" textFont:14 colorStr:@"#2b84c6" aligment:NSTextAlignmentCenter];
    signLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:signLabel];
    
    
    [self canUseSystemCamera];
    
}

//创建扫描
- (void)createQRView{
    
    //扫描区域宽、高大小
    float QRWIDTH = 200;
    
    //手电筒开关
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(_qrView.frame.origin.x + QRWIDTH/2.0 - 20, _qrView.frame.origin.y + _qrView.frame.size.height + 20, 40, 40);
//    btn.selected = NO;
//    [btn setTitle:@"开启闪光灯" forState:UIControlStateNormal];
//    [btn setTitle:@"关闭闪光灯" forState:UIControlStateSelected];
//    [btn setImage:[UIImage imageNamed:@"ocr_flash-off.png"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"ocr_flash-on.png"] forState:UIControlStateSelected];
//    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//    [btn addTarget:self action:@selector(openOrClose:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
    
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    // Output
    _output = [[AVCaptureMetadataOutput alloc] init];
    [ _output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue ()];
    // Session
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input]){
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output]){
        [_session addOutput:self.output];
    }
    
     //扫描类型
    _output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    //设置扫描有效区域(上、左、下、右)
    [_output setRectOfInterest : CGRectMake (( _qrView.frame.origin.y )/ SCREEN_HEIGHT ,(_qrView.frame.origin.x)/ SCREEN_WIDTH , QRWIDTH / SCREEN_HEIGHT , QRWIDTH / SCREEN_WIDTH )];
    // Preview
    _preview =[ AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill ;
    _preview.frame = self.view.layer.bounds ;
    [self.view.layer insertSublayer:_preview atIndex:0];
    // Start
    [_session startRunning];
    
    _lineTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveLine) userInfo:nil repeats:YES];
}

- (void)leftButtonHaveClick:(UIButton *)sender{
    if ([_lineTimer isValid]) {
        [_lineTimer invalidate];
        _lineTimer = nil;
    }
    [_device lockForConfiguration:nil];
    [_device setTorchMode:AVCaptureTorchModeOff];
    [_device unlockForConfiguration];
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)moveLine{
    float upY = _qrView.frame.origin.y + _qrView.frame.size.height - 2.0 - 3.0;
    float y = _lineLabel.frame.origin.y;
    y = y+move;
    CGRect lineFrame=CGRectMake(_lineLabel.frame.origin.x, y, _qrView.frame.size.width - 4.0, 3.0);
    _lineLabel.frame = lineFrame;
    if (y < _qrView.frame.origin.y + 2.0 || y > upY) {
        move = -move;
    }
}


//扫描成功后的代理方法
- ( void )captureOutput:( AVCaptureOutput *)captureOutput didOutputMetadataObjects:( NSArray *)metadataObjects fromConnection:( AVCaptureConnection *)connection {
    
    NSString *stringValue;//扫描结果
    if ([metadataObjects count ] > 0 ){
        // 停止扫描
        [_session stopRunning];
        if ([_lineTimer isValid]) {
            [_lineTimer invalidate];
            _lineTimer = nil;
            _lineLabel.hidden = YES;
        }
        [[BaseTapSound shareTapSound]playSystemSound];
        
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue ;
        
        if ([[stringValue substringToIndex:13] isEqualToString:@"QJDrinkTicket"]) {
            WSFDrinkTicketReclaimDetailVC *vc = [[WSFDrinkTicketReclaimDetailVC alloc] init];
            vc.couponCode = [stringValue substringFromIndex:13];
            NSLog(@"QJDrinkTicket = %@",[stringValue substringFromIndex:13]);
            [self.navigationController pushViewController:vc animated:NO];
        } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请扫描饮品券二维码" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self startingQRCode];
}

- (void)openOrClose:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([sender isSelected]) {
        [_device lockForConfiguration:nil];
        [_device setTorchMode:AVCaptureTorchModeOn];
        [_device unlockForConfiguration];
    }else{
        [_device lockForConfiguration:nil];
        [_device setTorchMode:AVCaptureTorchModeOff];
        [_device unlockForConfiguration];
    }
}

- (void)canUseSystemCamera{
    if (![BaseTapSound ifCanUseSystemCamera]) {
        _lineLabel.hidden = YES;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"此应用已被禁用系统相机" message:@"请在iPhone的 \"设置->隐私->相机\" 选项中,设置访问你的相机" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        alert.tag = 100;
        [alert show];
    }else{
        _lineLabel.hidden = NO;
        [self createQRView];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)startingQRCode{
    if (self.session) {
        [self.session startRunning ];
        if (self.lineTimer) {
            [self.lineTimer invalidate];
            self.lineTimer = nil;
        }
        self.lineTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveLine) userInfo:nil repeats:YES];
        self.lineLabel.hidden = NO;
    }
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
