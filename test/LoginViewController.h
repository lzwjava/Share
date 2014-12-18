//
//  LoginViewController.h
//  test
//
//  Created by lzw on 14-9-6.
//  Copyright (c) 2014年 lzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>

@class LoginViewController;

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end
