//
//  MainViewController.h
//  test
//
//  Created by lzw on 14-9-7.
//  Copyright (c) 2014年 lzw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleTableViewCell.h"
@class StatusService;
@class AddViewController;

@interface MainViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void) setStatus;
@end
