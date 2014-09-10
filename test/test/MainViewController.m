//
//  MainViewController.m
//  test
//
//  Created by lzw on 14-9-7.
//  Copyright (c) 2014年 lzw. All rights reserved.
//

#import "MainViewController.h"
#import "StatusService.h"
#import "AddViewController.h"

@interface MainViewController (){
    NSArray *statuses;
}
@end

@implementation MainViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    UIBarButtonItem *addButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goAddView:)];
    self.navigationItem.rightBarButtonItem=addButton;

    [self setStatus];
}

- (void) setStatus{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
          statuses=[StatusService findRecentStatuses:50];
        NSLog(@"len=%d",[statuses count]);
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self tableView] reloadData];
        });
    });

}

- (void)goAddView:(id)sender{
    NSLog(@"add btn clicked");
    [self performSegueWithIdentifier:@"add_segue" sender:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSLog(@"number of sections in table view");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"count=%d",statuses.count);
    return statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SimpleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if(cell==nil){
        cell=[[SimpleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    AVStatus *status=statuses[indexPath.row];
    NSString *text;
    AVUser *user=(AVUser *)[status source];
    text=[status.data objectForKey:@"text"];
    cell.statusTextLabel.text=text;
    NSLog(@"text=%@",text);
    cell.statusNameLabel.text=user.username;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"add_segue"]){
        NSLog(@"prepareForAddSegue");
        AddViewController *addViewCotroller=(AddViewController *)segue.destinationViewController;
        addViewCotroller.mainViewController=self;
    }
}

@end
