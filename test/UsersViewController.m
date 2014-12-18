//
//  UsersViewController.m
//  test
//
//  Created by lzw on 14-9-9.
//  Copyright (c) 2014年 lzw. All rights reserved.
//

#import "UsersViewController.h"

@interface UsersViewController (){
    NSArray* users;
    NSString *subName;
    NSString *tableCellIdentifier;
}
@end

@implementation UsersViewController

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
    tableCellIdentifier=@"tableCell";
    [self.usersTableView setDelegate:self];
    [self.usersTableView setDataSource:self];
    [self searchUsers];
}

-(void) searchUsers{
    users=[StatusService findAllUsersExceptMe:subName];
    [[self usersTableView] reloadData];
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

#pragma mark - TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [users count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableCellIdentifier];
    if(!cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableCellIdentifier];
    }
    AVUser *user=users[indexPath.row];
    cell.textLabel.text=user.username;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:tableCellIdentifier forIndexPath:indexPath];
    [self performSegueWithIdentifier:@"user_space_segue" sender:indexPath];
};

#pragma mark -TableView End

- (IBAction)searchBtnPressed:(id)sender {
    subName=self.searchTextField.text;
    [self searchUsers];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"user_space_segue"]){
        UserCenterViewController *userCenterViewController=[segue destinationViewController];
        NSIndexPath *path=sender;
        AVUser* user=users[path.row];
        userCenterViewController.user=user;
    }
}

@end



