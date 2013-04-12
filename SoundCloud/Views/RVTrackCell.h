//
//  RVTrackCell.h
//  SoundCloud
//
//  Created by Rémy on 12/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import <UIKit/UIKit.h>

// Model
#import "RVTrack.h"

@interface RVTrackCell : UITableViewCell

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *waveformImageView;



/**************************************************************************************************/
#pragma mark - Reusable Identifier

+(NSString *)reusableIdentifier;

/**************************************************************************************************/
#pragma mark - Height

+ (CGFloat)heightOfRow;

/**************************************************************************************************/
#pragma mark - Birth & Death

+ (RVTrackCell *)cell;

/**************************************************************************************************/
#pragma mark - update UI

- (void)updateUIWithTrack:(RVTrack *)track;

@end
