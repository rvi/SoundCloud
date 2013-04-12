//
//  RVViewController.h
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RVViewController : UIViewController<UITableViewDataSource, UITabBarDelegate>

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**************************************************************************************************/
#pragma mark - Actions

- (IBAction)login:(id)sender;

@end
