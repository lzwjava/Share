//
//  UserCenterViewController.h
//  test
//
//  Created by lzw on 14-9-9.
//  Copyright (c) 2014年 lzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
#import "StatusService.h"

@interface UserCenterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *followStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property(strong,nonatomic) AVUser *user;
@end
