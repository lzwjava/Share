//
//  DetailViewController.h
//  test
//
//  Created by lzw on 14-8-22.
//  Copyright (c) 2014年 lzw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
