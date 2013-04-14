//
//  RVViewController.h
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 Rémy Virin. All rights reserved.
//

#import <UIKit/UIKit.h>

// Gestures
#import "RVDragGestureRecognizer.h"

@interface RVViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, DragGestureDelegate>

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (strong, nonatomic) IBOutlet UIView *tracksView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**************************************************************************************************/
#pragma mark - Actions

- (IBAction)login:(id)sender;

@end
