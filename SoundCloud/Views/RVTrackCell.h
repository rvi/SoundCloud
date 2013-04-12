//
//  RVTrackCell.h
//  SoundCloud
//
//  Created by Rémy on 12/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RVTrackCell : UITableViewCell

/**************************************************************************************************/
#pragma mark - Reusable Identifier

+(NSString *)reusableIdentifier;


/**************************************************************************************************/
#pragma mark - Birth & Death

+ (RVTrackCell *)cell;

@end
