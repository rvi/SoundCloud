//
//  RVDragGestureRecognizer.m
//  SoundCloud
//
//  Created by Rémy on 14/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVDragGestureRecognizer.h"

#import <UIKit/UIGestureRecognizerSubclass.h>

#define HEADER_HEIGHT 44.

@interface RVDragGestureRecognizer ()

@property (nonatomic, assign) CGFloat lastY;
@property (nonatomic, assign) BOOL isGoingToTop;

@end

@implementation RVDragGestureRecognizer

/**************************************************************************************************/
#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    // touch is in header
    if (point.y < HEADER_HEIGHT)
    {
        self.state = UIGestureRecognizerStateBegan;
    }
    else
    {
        self.state = UIGestureRecognizerStateFailed;
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.state != UIGestureRecognizerStateFailed)
    {
        self.state = UIGestureRecognizerStatePossible;
        
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view.superview];
        
        if (self.lastY > point.y)
        {
            self.isGoingToTop = YES;
        }
        else if (self.lastY < point.y)
        {
            self.isGoingToTop = NO;
        }
        
        self.lastY = point.y;

        [self.dragDelegate moveTo:touch];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.dragDelegate dragEndedGoingTop:self.isGoingToTop];    
}

@end
