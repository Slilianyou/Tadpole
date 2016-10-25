//
//  ScanViewController.h
//  EZhuiSu
//
//  Created by ss-iOS-LLY on 16/9/20.
//  Copyright © 2016年 Paiwogou@syscanit.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger,scanBtnType) {
      shanguandengBtn = 11,
     xiangcexuanquBtn = 22,
    zhuisumachaxunBtn = 33,
};


@interface ScanViewController : UIViewController
{
    NSString *rst;
    NSString *documentsDirectory;
    SystemSoundID soundID;
    AVCaptureVideoPreviewLayer *previewLayer;
    AVCaptureDevice *avCaptureDevice;
    int width;
    int height;
    
    
}


@property (nonatomic, retain) AVCaptureSession *avCaptureSession;








@end
