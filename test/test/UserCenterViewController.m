//
//  UserCenterViewController.m
//  test
//
//  Created by lzw on 14-9-9.
//  Copyright (c) 2014年 lzw. All rights reserved.
//

#import "UserCenterViewController.h"

@interface UserCenterViewController (){
    NSString* followOperationTitle;
    NSString* followStatus;
    BOOL followed;
}

@end

@implementation UserCenterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.nameLabel setText:[self.user username]];
    [self setFollowView];
}

-(void)setFollowView{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"try to get follow status");
        followStatus=[StatusService followStatus:self.user];
        NSLog(@"followStatus");
        followed=[StatusService isMyFollowee:self.user];
        NSLog(@"get followed%@",followed?@"YES":@"NO");
        followOperationTitle=[StatusService followOperationTitle:followed];
        NSLog(@"follow operation title=%@",followOperationTitle);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.followStatusLabel setText:followStatus];
            [self.followButton setTitle:followOperationTitle forState:UIControlStateNormal];
        });
    });
}

- (IBAction)followBtnPressed:(id)sender {
    [StatusService followOperation:followed user:self.user];
    [self setFollowView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
