//
//  AddViewController.h
//  test
//
//  Created by lzw on 14-9-7.
//  Copyright (c) 2014年 lzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>

@class MainViewController;

@interface AddViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *statusTextField;
@property (strong,nonatomic) MainViewController *mainViewController;

@end
