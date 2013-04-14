//
//  RVDragGestureRecognizer.h
//  SoundCloud
//
//  Created by Rémy on 14/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DragGestureDelegate <NSObject>

- (void)moveTo:(UITouch *)touch;
- (void)dragEndedGoingTop:(BOOL)isGoingTop;

@end

@interface RVDragGestureRecognizer : UIGestureRecognizer

@property (nonatomic, weak) id<DragGestureDelegate> dragDelegate;

@end
