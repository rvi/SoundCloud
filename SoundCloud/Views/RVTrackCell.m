//
//  RVTrackCell.m
//  SoundCloud
//
//  Created by Rémy on 12/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVTrackCell.h"

#define REUSABLE_IDENTIFIER @"trackCell"

@implementation RVTrackCell

/**************************************************************************************************/
#pragma mark - Reusable Identifier

+(NSString *)reusableIdentifier
{
    return REUSABLE_IDENTIFIER;
}

/**************************************************************************************************/
#pragma mark - Birth & Death

+ (RVTrackCell *)cell
{	
	RVTrackCell *cell = nil;
	
	NSArray *topLevelsObjects = [[NSBundle mainBundle] loadNibNamed:@"RVTrackCell" owner:nil options:nil];
    
	for(id currentObject in topLevelsObjects)
    {
		if([currentObject isKindOfClass:[RVTrackCell class]])
        {
			cell = (RVTrackCell *)currentObject;
			break;
		}
	}
	
    return cell;
}

/**************************************************************************************************/
#pragma mark - update UI

- (void)updateUIWithTrack:(RVTrack *)track
{
    
}

@end
