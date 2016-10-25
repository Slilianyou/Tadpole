//
//  ScanViewController.m
//  EZhuiSu
//
//  Created by ss-iOS-LLY on 16/9/20.
//  Copyright © 2016年 Paiwogou@syscanit.com. All rights reserved.
//

#import "ScanViewController.h"
#import "gm_decoder_iphone.h"
#import "syscan_bmp_read_write.h"
#import "ScanResultViewController.h"
#import "JSONKit.h"
#import "UIView+Frame.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "UITextField+ExtentRange.h"



#define kMargin  30
#define kTopHeight 70 + 64

@interface ScanViewController ()<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVCaptureMetadataOutputObjectsDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>
{
    UIButton *_albumBtn;
    UIButton *_searchBtn;
    UISlider *_mySlider;
    UIButton *_chaXunBtn;
    UITextField * _chaXunTextField;
}

@property (nonatomic, strong) UIImageView *backImgv;
@property (nonatomic, assign) BOOL shouldStopAnimation;
@property (nonatomic, strong) UIImageView *aniImgv;

@property (nonatomic, strong) UILabel *topMessageLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *messageLabel2;

@property (nonatomic, strong) UIButton *flashButton;
@property (nonatomic, assign) BOOL isFlashOn;
@property (nonatomic, strong) UIButton *backButton;
@end

@implementation ScanViewController
unsigned char g_gray_img[640*480];
@synthesize avCaptureSession;

//
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews] ;
    self.aniImgv.frame = self.backImgv.bounds ;
    previewLayer.frame = self.view.bounds;
    
    self.topMessageLabel.frame = CGRectMake(CGRectGetMinX(self.backImgv.frame) + 30, 10 + 64, self.backImgv.width - 60, 50);
    _mySlider.frame =CGRectMake(CGRectGetMinX(self.backImgv.frame) + 15, CGRectGetMaxY(self.backImgv.frame) + 8  , CGRectGetWidth(self.backImgv.frame)- 30, 20);
    self.messageLabel2.frame = CGRectMake(CGRectGetMinX(_mySlider.frame), CGRectGetMaxY(_mySlider.frame) +10 , CGRectGetWidth(_mySlider.frame), 20);
    CGFloat w = (CGRectGetWidth(_backImgv.frame) -30) / 2.f;
    
    _albumBtn.frame = CGRectMake( CGRectGetMinX(self.backImgv.frame) , CGRectGetMaxY(self.messageLabel2.frame) + 20, w,  35);
    
    _searchBtn.frame = CGRectMake( CGRectGetMaxX(_albumBtn.frame) + 20 , CGRectGetMaxY(self.messageLabel2.frame) + 20, w,  35);
    
    _chaXunTextField.frame = CGRectMake(0, 0, 200, 40);
    _chaXunTextField.center = CGPointMake(kScreenWidth /2.0, 100);
    _chaXunBtn.frame = CGRectMake(0,0, 60, 30);
    _chaXunBtn.center = CGPointMake(kScreenWidth /2.0, 200);
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        rst = [[NSString alloc] init];
        [self creatSoundAndInitGM];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self addNotifacation] ;
    
    
    
}
- (void)setUpUI
{
    self.title = @"追溯查询";
    self.view.backgroundColor = [UIColor clearColor];
    
    CGFloat h = kScreenWidth - kMargin *2;
    UIView *topView = [self setupViewWithRect:CGRectMake(0, 0, kScreenWidth, kTopHeight)];
    UIView *leftView = [self setupViewWithRect:CGRectMake(0, topView.bottom, kMargin,h )];
    UIView *bottomView = [self setupViewWithRect:CGRectMake(0, leftView.bottom, kScreenWidth,kScreenHeight - h )];
    UIView *rightView = [self setupViewWithRect:CGRectMake(kScreenWidth - kMargin , topView.bottom, kMargin,h )];
    
    [self.view addSubview:topView];
    [self.view addSubview:leftView];
    [self.view addSubview:bottomView];
    [self.view addSubview:rightView];
    
    self.backImgv = [[UIImageView alloc]init];
    self.backImgv.backgroundColor = [UIColor clearColor];
    self.backImgv.frame = CGRectMake(kMargin, topView.bottom, kScreenWidth - 2*kMargin, h);
    self.backImgv.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.backImgv];
    
    _mySlider = [[UISlider alloc]init];
    _mySlider.tag = 2000;
    UIImage * sliderImage = [self OriginImage:[UIImage imageNamed:@"point"] scaleToSize:CGSizeMake(40, 40)];
    [_mySlider setThumbImage:sliderImage forState:UIControlStateNormal];
    _mySlider.backgroundColor = [UIColor clearColor];
    _mySlider.minimumValue = 1;
    _mySlider.maximumValue = 3;
    [_mySlider addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_mySlider];
    
    self.topMessageLabel = [[UILabel alloc]init];
    self.topMessageLabel.backgroundColor = [UIColor clearColor];
    self.topMessageLabel.numberOfLines = 2;
    self.topMessageLabel.textColor = [UIColor whiteColor];
    self.topMessageLabel.text = @"请对准二维码\n您可在扫描后评价商品";
    self.topMessageLabel.font = [UIFont systemFontOfSize:15.f];
    self.topMessageLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.topMessageLabel];
    
    
    self.messageLabel = [[UILabel alloc]init];
    self.messageLabel.frame = CGRectMake(0, 0, self.backImgv.width - 10, 50);
    self.messageLabel.center = self.backImgv.center;
    [self.view addSubview:self.messageLabel];
    
    self.messageLabel2 = [[UILabel alloc]init];
    self.messageLabel2.text = @"查询商品追溯信息，保障您的切身权益";
    self.messageLabel2.font = [UIFont systemFontOfSize:14.f];
    self.messageLabel2.textAlignment = NSTextAlignmentCenter;
    self.messageLabel2.textColor = [UIColor whiteColor];
    [self.view addSubview:self.messageLabel2];
    
    // 按钮
    _albumBtn = [self getBtnWithTitle:@"相册选取" Tag:1000];
    _searchBtn = [self getBtnWithTitle:@"追溯码查询" Tag:1001];
    
    //闪光灯
    self.flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.flashButton.backgroundColor = [UIColor clearColor];
    self.flashButton.tag = 1004;
    [self.flashButton setBackgroundImage:[UIImage imageNamed:@"shanguangguan.png"] forState:UIControlStateNormal];
    [self.flashButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.flashButton.frame = CGRectMake(kScreenWidth - 75, 40, 45, 45);
    [self.view addSubview:self.flashButton];
    
    // backButton
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.backgroundColor = [UIColor clearColor];
    self.backButton.tag = 1003;
    self.backButton.layer.cornerRadius = 45 /2.f;
    self.backButton.layer.masksToBounds = YES;
    self.backButton.layer.borderWidth = 2.f;
    self.backButton.layer.borderColor = [[UIColor whiteColor]CGColor];
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"ocr_back.png"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.backButton.frame = CGRectMake(30, 40, 45, 45);
    [self.view addSubview:self.backButton];
    
    
}
- (UIView *)setupViewWithRect:(CGRect)rect
{
    UIView *view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.7;
    return view;
}
- (UIImage*) OriginImage:(UIImage*)image scaleToSize:(CGSize)size

{
    
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}


- (UIButton *)getBtnWithTitle:(NSString *)title Tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = tag;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    btn.layer.cornerRadius =  8.f;
    btn.layer.masksToBounds = YES;
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self startVideoCapture];
    
    
}
- (void)startVideoCapture
{
    if(self.avCaptureSession) {
        
        [self.avCaptureSession startRunning] ;
        [self setCamaraAutoFocus:CGPointMake(0.5, 0.5)] ;
        [self setExposure:CGPointMake(0.5, 0.5)] ;
        [self setDefaultZoom] ;
        
        if([self getReadyForAnimation]){
            [self startAnimation] ;
        }
        // self.flashBtn.enabled = YES ;
        return;
    }
    
    NSString *mediaType = AVMediaTypeVideo;
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus ==AVAuthorizationStatusRestricted){
        
        [self camaraIsNotAvailable] ;
        
    }else if(authStatus == AVAuthorizationStatusDenied){
        
        [self camaraIsNotAvailable] ;
        
        
    }
    else if(authStatus == AVAuthorizationStatusAuthorized){
        
        [self camaraIsAvailable] ;
    }else if(authStatus == AVAuthorizationStatusNotDetermined){
        
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            if(granted){
                
                [self performSelectorOnMainThread:@selector(camaraIsAvailable) withObject:nil waitUntilDone:YES] ;
            }
            else {
                
                [self performSelectorOnMainThread:@selector(camaraIsNotAvailable) withObject:nil waitUntilDone:YES] ;
            }
            
        }];
    }else {
        
        [self camaraIsNotAvailable] ;
        
    }
    
    
}
- (void)startAnimation{
    
    [self.aniImgv.layer removeAllAnimations] ;
    CGRect oriFrame = CGRectMake(0, 0, self.backImgv.frame.size.width, 0) ;
    CGRect destFrame = self.backImgv.bounds  ;
    self.aniImgv.frame = oriFrame ;
    
    [UIView beginAnimations:@"scan" context:nil];
    [UIView setAnimationDuration:2];
    [UIView setAnimationRepeatCount:1000000];
    self.aniImgv.frame = destFrame ;
    [UIView commitAnimations];
    
    
}
- (void)stopAnimation{
    [self.aniImgv.layer removeAllAnimations] ;
}
- (void)setDefaultZoom{
    if([self camaraSupportsZoom]){
        if(!avCaptureDevice.isRampingVideoZoom){
            NSError *err = nil ;
            if([avCaptureDevice lockForConfiguration:&err]){
                
                avCaptureDevice.videoZoomFactor = 1;
                
                [avCaptureDevice unlockForConfiguration] ;
            }
        }
    }
}
- (BOOL)getReadyForAnimation{
    if(self.messageLabel.hidden== NO) {
        [self.aniImgv removeFromSuperview] ;
        return NO;
    }
    
    if(!self.aniImgv){
        self.aniImgv = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"kakalib_scan_ray.png"]] ;
        
    }
    if(!self.aniImgv.superview){
        [self.backImgv addSubview:self.aniImgv] ;
    }
    return YES ;
}

//调节zoom
- (BOOL)camaraSupportsZoom{
    if(avCaptureDevice){
        CGFloat videoMaxZoomFactor =   avCaptureDevice.activeFormat.videoMaxZoomFactor ;
        if(videoMaxZoomFactor>1.0){
            //设备支持zoom
            return YES ;
        }
    }
    return NO ;
}
- (BOOL)camaraSupportsTapToExposure{
    return [avCaptureDevice isExposurePointOfInterestSupported] ;
}

- (void)setExposure:(CGPoint)pont{
    AVCaptureExposureMode mode = AVCaptureExposureModeAutoExpose ;
    if([self camaraSupportsTapToExposure]&&[avCaptureDevice isExposureModeSupported:mode]){
        NSError *err = nil ;
        if([avCaptureDevice lockForConfiguration:&err]){
            avCaptureDevice.exposurePointOfInterest = pont ;
            avCaptureDevice.exposureMode = mode ;
            [avCaptureDevice unlockForConfiguration] ;
            
        }
    }
}
- (AVCaptureDevice *)getFrontCamera
{
    //获取摄像头设备
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in cameras)
    {
        if (device.position == AVCaptureDevicePositionBack){
            return device;
        }
    }
    AVCaptureDevice *device =[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    return device;
}


- (void)camaraIsAvailable{
    self.messageLabel.hidden = YES ;
    self.messageLabel.backgroundColor = [UIColor clearColor];
    self.messageLabel2.backgroundColor = [UIColor clearColor];
    
    
    self.messageLabel2.hidden = NO ;
    //self.flashBtn.enabled = YES ;
    self.backImgv.alpha = 0.7 ;
    avCaptureDevice =[self getFrontCamera];
    [self setCamaraAutoFocus:CGPointMake(0.5, 0.5)] ;
    [self setExposure:CGPointMake(0.5, 0.5)] ;
    [self setDefaultZoom] ;
    [avCaptureDevice addObserver:self forKeyPath:@"adjustingFocus" options:NSKeyValueObservingOptionNew context:nil] ;
    [avCaptureDevice addObserver:self forKeyPath:@"adjustingExposure" options:NSKeyValueObservingOptionNew context:nil] ;
    if(avCaptureDevice.isSmoothAutoFocusSupported ){
        [avCaptureDevice lockForConfiguration:nil];
        avCaptureDevice.smoothAutoFocusEnabled = YES ;
        [avCaptureDevice unlockForConfiguration];
    }
    
    NSError *error = nil;
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:self->avCaptureDevice error:&error];
    if (!videoInput)
    {
        self->avCaptureDevice = nil;
        NSLog(@"Failed to get video input");
        return;
    }
    
    self->avCaptureSession = [[AVCaptureSession alloc] init];
    self->avCaptureSession.sessionPreset = AVCaptureSessionPreset640x480;
    [self->avCaptureSession addInput:videoInput];
    
    AVCaptureVideoDataOutput *avCaptureVideoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    
    NSDictionary *settings = [[NSDictionary alloc] initWithObjectsAndKeys:
                              [NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA], kCVPixelBufferPixelFormatTypeKey,
                              [NSNumber numberWithInt:640], (id)kCVPixelBufferWidthKey,
                              [NSNumber numberWithInt:480], (id)kCVPixelBufferHeightKey,
                              nil];
    
    avCaptureVideoDataOutput.videoSettings = settings;
    dispatch_queue_t queue = dispatch_queue_create("org.doubango.idoubs", NULL);
    [avCaptureVideoDataOutput setSampleBufferDelegate:self queue:queue];
    [self->avCaptureSession addOutput:avCaptureVideoDataOutput];
    
    //QR扫码
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc]init];
    //dispatch_queue_t queueQr = dispatch_queue_create("E_ZhuiSu_QR", NULL);
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [self.avCaptureSession addOutput:metadataOutput];
    metadataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    previewLayer= [AVCaptureVideoPreviewLayer layerWithSession: self->avCaptureSession];
    previewLayer.frame = self.view.bounds;
    previewLayer.videoGravity= AVLayerVideoGravityResizeAspectFill;
    [self.view.layer insertSublayer:previewLayer atIndex:0];
    [self->avCaptureSession startRunning];
    // [self addGestureToSelfView] ;
    if([self getReadyForAnimation]){
        [self startAnimation] ;
    }
    
}
- (void)creatSoundAndInitGM
{
    //UI展示
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    documentsDirectory = [[NSString alloc] initWithString:[paths objectAtIndex:0]];
    NSURL *filePath   = [[NSBundle mainBundle] URLForResource: @"beep" withExtension: @"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    gm_decoder_init();
    
}
- (void)addNotifacation{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appDidEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil] ;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(appDidEnterForground) name:UIApplicationWillEnterForegroundNotification object:nil] ;
}

- (void)appDidEnterBackground{
    [self stopVideoCapture:nil] ;
}

- (void)appDidEnterForground{
    [self startVideoCapture] ;
}

- (void)stopVideoCapture:(id)sender
{
    //停止摄像头捕抓
    if(self->avCaptureSession){
        [self -> avCaptureSession stopRunning];
    }
    
    [self stopAnimation];
}

- (void)dealloc{
    if(soundID){
        AudioServicesDisposeSystemSoundID(soundID) ;
    }
    [avCaptureDevice removeObserver:self forKeyPath:@"adjustingFocus"];
    [avCaptureDevice removeObserver:self forKeyPath:@"adjustingExposure"];
    avCaptureDevice = nil ;
    [[NSNotificationCenter defaultCenter]removeObserver:self] ;
}
- (void)camaraIsNotAvailable{
    NSLog(@"相机权限受限");
    self.messageLabel.hidden = NO ;
    self.backImgv.alpha = 0.2 ;
    self.messageLabel2.hidden = YES;
}
- (void)setCamaraAutoFocus:(CGPoint)point{
    
    if([self camaraSupportsAutoFocus]){
        NSError *err = nil ;
        if([avCaptureDevice lockForConfiguration:&err]){
            avCaptureDevice.focusPointOfInterest = point ;
            avCaptureDevice.focusMode = AVCaptureFocusModeAutoFocus ;
            [avCaptureDevice unlockForConfiguration] ;
        }
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated] ;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.view layoutIfNeeded] ;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (BOOL)camaraSupportsAutoFocus{
    if(avCaptureDevice){
        if([avCaptureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]&&[avCaptureDevice isFocusPointOfInterestSupported]){
            return YES ;
        }
    }
    return NO ;
}

#pragma mark AVCaptureVideoDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
    //捕捉数据输出
    
    
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    width = (int)(CVPixelBufferGetWidth(imageBuffer));
    height = (int)(CVPixelBufferGetHeight(imageBuffer));
    
    int i;
    //  必须转化为物理地址
    CGRect  rect = [previewLayer metadataOutputRectOfInterestForRect:self.backImgv.frame] ;
    float bX = rect.origin.x*width ;
    float bY = rect.origin.y*height ;
    float bW = (rect.origin.x+rect.size.width)*width ;
    float bH = (rect.origin.y+rect.size.height)*height ;
    for (int j = 0; j< width; j ++) {
        for (int n = 0; n < height; n ++) {
            if(j>bX&&j<bW&&n>bY&&n<bH){
                i = n*width+j ;
                g_gray_img[i] = baseAddress[i*4+1];
            }
        }
    }
    
    
    if (rst!=NULL)
    {
        
        rst=NULL;
    }
    rst = gm_decoder_decode(g_gray_img, width, height);
    
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    baseAddress = nil ;
    
    if (rst!=NULL)
    {
        [self performSelectorOnMainThread:@selector(stopVideoCapture:) withObject:nil waitUntilDone:YES] ;
        AudioServicesPlaySystemSound(soundID);
        
        NSData *data = [rst dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [data objectFromJSONData];
        rst = NULL ;
        
        [self performSelectorOnMainThread:@selector(addfResultViewWithDict:) withObject:dict waitUntilDone:YES] ;
        data = nil ;
        dict = nil ;
    }
    else
    {
        rst = [[NSString alloc] initWithString:[NSString stringWithFormat:@"Decode failed return: %@",rst]];
    }
    
}
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects.firstObject;
    if ([metadataObject.type isEqualToString:AVMetadataObjectTypeQRCode]) { // 成功后系统不会停止扫描，可以用一个变量来控制。
        //        self.isQRCodeCaptured = YES;
        if (metadataObject.stringValue.length) {
            NSLog(@"%@",metadataObject.stringValue);
            [self loadHtmlWithType:10 content:metadataObject.stringValue] ;
            
            [self stopVideoCapture:nil];
        }
        
    }
}
#pragma mark KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    
    
    if([keyPath isEqualToString:@"adjustingFocus"]){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self handleAdjustingFocus:change] ;
        }) ;
    }else if ([keyPath isEqualToString:@"adjustingExposure"]){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self handleAdjustingExposure:change] ;
        }) ;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context] ;
    }
    
    
}
- (void)handleAdjustingFocus:(NSDictionary*)change{
    
    
    
    NSDictionary *changeNew = change ;
    bool new = [changeNew[@"new"] boolValue] ;
    
    
    if(new){
        
        
    }else{
        
        [self setCamaraAutoFocus:CGPointMake(.5,.5)] ;
        
    }
    
    
}
- (void)handleAdjustingExposure:(NSDictionary*)change{
    
    
    
    NSDictionary *changeNew = change ;
    bool new = [changeNew[@"new"] boolValue] ;
    
    
    if(new){
        
        
    }else{
        
        [self setExposure:CGPointMake(.5,.5)] ;
    }
    
    
}

- (BOOL)isPhotoLibraryAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)buttonClicked:(UIButton *)sender
{
    switch (sender.tag) {
        case 1000:{
            //
            //            UIImagePickerController *picker = [[UIImagePickerController alloc]init];
            //            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [self.navigationController presentViewController:picker animated:YES completion:nil];
            
            if ([self isPhotoLibraryAvailable]) {
                [self stopVideoCapture:nil];
                UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //默认
                NSMutableArray *mediaTypes = [NSMutableArray arrayWithCapacity:0];
                [mediaTypes addObject:(__bridge NSString *) kUTTypeImage];
                picker.mediaTypes = mediaTypes;
                
                picker.delegate = self;
                [self presentViewController:picker animated:YES completion:nil];
            }
        }
            break;
        case 1001:
            //查询追溯码
        {
            [self stopVideoCapture:nil];
            UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
            visualEffect.frame = self.view.bounds;
            visualEffect.alpha = 0.9;
            [self.view addSubview:visualEffect];
            
            UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [visualEffect addGestureRecognizer:tapGes];
            
            _chaXunTextField = [[UITextField alloc]init];
            _chaXunTextField.backgroundColor = [UIColor whiteColor];
            _chaXunTextField.layer.borderWidth = 1.f;
            _chaXunTextField.delegate = self;
            [_chaXunTextField resignFirstResponder];
            //设置光标位置
            [_chaXunTextField setSelectedRange:NSMakeRange(0, 2)];
            _chaXunTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
            _chaXunTextField.placeholder = @"    输入追溯码";
            _chaXunTextField.keyboardType = UIKeyboardTypeNumberPad;
            [_chaXunTextField setValue:[UIColor lightGrayColor]forKeyPath:@"_placeholderLabel.textColor"];
            [_chaXunTextField setValue:[UIFont boldSystemFontOfSize:18.f] forKeyPath:@"_placeholderLabel.font"];
            [self.view addSubview:_chaXunTextField];
            
            _chaXunBtn = [self getBtnWithTitle:@"查询" Tag:1002];
            _chaXunBtn.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:_chaXunBtn];
            [self.view bringSubviewToFront:_chaXunTextField];
        }
            break;
        case 1002:
            //
        {
            ScanResultViewController *resultVc = [[ScanResultViewController alloc]init];
            resultVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:resultVc animated:YES];
        }
            break;
        case 1003:{
            [self.navigationController popViewControllerAnimated:YES];
        }
            break;
        case 1004:{
            NSError *error = nil;
            if (self.isFlashOn) {
                [sender setBackgroundImage:[UIImage imageNamed:@"shanguangguan.png"] forState:UIControlStateNormal];
                //闪光灯
                BOOL lockAcquired = [avCaptureDevice lockForConfiguration:&error];
                if (!lockAcquired) {
                    
                } else {
                    if ([avCaptureDevice hasFlash] && [avCaptureDevice isFlashModeSupported:AVCaptureFlashModeOff]) {
                        [avCaptureDevice setFlashMode:AVCaptureFlashModeOff];
                        [avCaptureDevice setTorchMode:AVCaptureTorchModeOff];
                    }
                    [avCaptureDevice unlockForConfiguration];
                }
                self.isFlashOn = NO;
                
            } else if (self.isFlashOn == NO){
                [sender setBackgroundImage:[UIImage imageNamed:@"shanguangkai.png"] forState:UIControlStateNormal];
                //闪光灯
                BOOL lockAcquired = [avCaptureDevice lockForConfiguration:&error];
                if (!lockAcquired) {
                    
                } else {
                    if ([avCaptureDevice hasFlash] && [avCaptureDevice isFlashModeSupported:AVCaptureFlashModeOn]) {
                        [avCaptureDevice setFlashMode:AVCaptureFlashModeOn]; //闪光
                        [avCaptureDevice setTorchMode:AVCaptureTorchModeOn]; //手电筒
                    }
                    [avCaptureDevice unlockForConfiguration];
                }
                self.isFlashOn = YES;
            }
        }
            break;
        case 2000:
            //调节屏幕大小
        {
            if([self camaraSupportsZoom]){
                if(!avCaptureDevice.isRampingVideoZoom){
                    NSError *err = nil ;
                    if([avCaptureDevice lockForConfiguration:&err]){
                        
                        avCaptureDevice.videoZoomFactor = _mySlider.value;
                        
                        [avCaptureDevice unlockForConfiguration] ;
                    }
                }
            }
            
        }
            
            
            break;
        default:
            break;
    }
}

#pragma mark --UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        //
        UIImage *portaitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSLog(@"%@",portaitImg);
        
        //QR iOS 8.0之后
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy:CIDetectorAccuracyHigh }];
        CIImage *image = [[CIImage alloc] initWithImage:portaitImg];
        NSArray *features = [detector featuresInImage:image];
        for (CIQRCodeFeature *feature in features) {
            [self loadHtmlWithType:10 content:feature.messageString];
        }
        
        
        // GM
        
    }];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"系统相册取消掉用");
    }];
}
- (void)addfResultViewWithDict:(NSDictionary *)dict
{
    NSString*pwg = [dict objectForKey:@"content"] ;
    NSArray*arr = [pwg componentsSeparatedByString:@"_"] ;
    
    if(arr.count>1){//码是正确的
        //取项目编号第二个
        
        NSString *xiangmuBianhao = arr[1] ;
        
        if([xiangmuBianhao isEqualToString:@"1"]){//溯源
            if(arr.count == 4){//app图片上的码
                //跳到网址http://www.paiwogou.com/gm.php?cid=
                [self loadHtmlWithType:2 content:arr[2]] ;
                
            }else if (arr.count == 5){//商品溯源码
                //请求一个页面http://www.paiwogou.com/index.php/app=trace&act=index&str=
                [self loadHtmlWithType:1 content:pwg] ;
                
                
            }
        }else if ([xiangmuBianhao isEqualToString:@"2"]){//名片
            
            //请求一个页面http://www.paiwogou.com/index.php/app=trace&act=index&str=
            [self loadHtmlWithType:1 content:pwg] ;
        } else{
            //            if(pwg.length){
            //                [ShowAlertView showAlertViewWithMessage:@"此版本不支持此码，请检查是否是最新版本！" andDelegate:self andTag:100] ;
            //            }
            
        }
        
    }else{
        if(pwg.length){
            [self loadHtmlWithType:1 content:pwg] ;
            
        }else{
            [self startVideoCapture] ;
        }
    }
    
    
}
- (void)loadHtmlWithType:(int)type content:(NSString*)content{
    ScanResultViewController *sc = [[ScanResultViewController alloc]init] ;
    sc.type = type ;
    sc.content = content ;
    sc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sc animated:NO];
}
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [_chaXunTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_chaXunTextField resignFirstResponder];
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}















































- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
