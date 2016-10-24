//
//  LoginViewController.h
//  Tadpole
//
//  Created by ss-iOS-LLY on 16/1/7.
//  Copyright © 2016年 Shanghai Sysyscanit Information Technology Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"


typedef NS_ENUM(NSInteger, btnType){
    loginBtnTag = 200,
    forgetBtnTag = 300,
    createBtnTag = 400,
    touchIdBtnTag = 500,
    outBtnTag = 600,
};


@interface LoginViewController : UIViewController<UITextFieldDelegate>

@end
