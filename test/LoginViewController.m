//
//  LoginViewController.m
//  test
//
//  Created by lzw on 14-9-6.
//  Copyright (c) 2014年 lzw. All rights reserved.
//

#import "LoginViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (IBAction)loginBtnPressed:(id)sender {
    NSString *username=self.usernameText.text;
    NSString *password=self.passwordText.text;
    [AVUser logInWithUsernameInBackground:username password:password block:^(AVUser *user, NSError *error) {
        if(!error){
            [self loginOrRegisterSucceed:sender];
        }else{
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"password error or no such user" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (void)loginOrRegisterSucceed:(id)sender{
    [self performSegueWithIdentifier:@"login_segue" sender:sender];
}

- (IBAction)registerBtnPressed:(id)sender {
    NSString *username=self.usernameText.text;
    NSString *password=self.passwordText.text;
    AVUser *user=[AVUser user];
    user.username=username;
    user.password=password;
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            [self loginOrRegisterSucceed:sender];
        }else{
        }
    }];
}


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
    self.usernameText.delegate=self;
    self.passwordText.delegate=self;
    // Do any additional setup after loading the view.
    self.usernameText.text=@"kiki";
    self.passwordText.text=@"kiki";
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
