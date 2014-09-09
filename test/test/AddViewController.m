//
//  AddViewController.m
//  test
//
//  Created by lzw on 14-9-7.
//  Copyright (c) 2014年 lzw. All rights reserved.
//

#import "AddViewController.h"
#import "MainViewController.h"

@interface AddViewController ()

@end

@implementation AddViewController

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
    self.statusTextField.delegate=self;
    // Do any additional setup after loading the view.
}

- (IBAction)addStatus:(id)sender {
    NSString *text=self.statusTextField.text;
    AVStatus *status=[[AVStatus alloc] init];
    status.data=@{@"text":text};
    [AVStatus sendStatusToFollowers:status andCallback:
       ^(BOOL succeeded, NSError *error) {
           NSLog(@"===Send %@",[status debugDescription]);
           NSLog(@"succeed=%@",succeeded? @"YES":@"NO");
           if(succeeded){
               NSLog(@"dismiss");
               dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                              ^{
                                  MainViewController *controller=[self mainViewController];
                                  dispatch_async(dispatch_get_main_queue(), ^(void){
                                      [self.navigationController popViewControllerAnimated:YES];
                                      [controller setStatus];
                                  });
                              });

           }else{
               
           }
       }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
