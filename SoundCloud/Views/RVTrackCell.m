//
//  RVTrackCell.m
//  SoundCloud
//
//  Created by Rémy on 12/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVTrackCell.h"

// Utils
#import "NSDate+SoundCloud.h"
#import "UIImage+SoundCloud.h"

#define REUSABLE_IDENTIFIER @"trackCell"

/**************************************************************************************************/
#pragma mark - Private

@interface RVTrackCell ()

@property (nonatomic, strong) RVTrack *track;

- (void)setWaveFormImage;

@end

@implementation RVTrackCell

/**************************************************************************************************/
#pragma mark - Reusable Identifier

+(NSString *)reusableIdentifier
{
    return REUSABLE_IDENTIFIER;
}

/**************************************************************************************************/
#pragma mark - Height

+ (CGFloat)heightOfRow
{
    return 80.;
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

-(void)dealloc
{
    [self.track removeObserver:self forKeyPath:WAVEFORM_KVO];
}
/**************************************************************************************************/
#pragma mark - update UI

- (void)updateUIWithTrack:(RVTrack *)track
{
    self.track = track;
    self.titleLabel.text = track.title;
    self.dateLabel.text = [track.date stringForDisplay];
    
    if (self.track.waveform)
    {
        [self setWaveFormImage];
    }
    
    [self.track addObserver:self
                 forKeyPath:WAVEFORM_KVO
                    options:NSKeyValueObservingOptionNew
                    context:NULL];
}

- (void)setWaveFormImage
{
    CGSize imageSize = self.track.waveform.size;    
    CGRect newFrame = CGRectMake(0, 0, imageSize.width, imageSize.height / 2);
    
    UIImage *image = [self.track.waveform cropToRect:newFrame];
    [self.waveformImageView setImage:image];
    self.waveformImageView.hidden = NO;
}

/**************************************************************************************************/
#pragma mark - KVO

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setWaveFormImage];
    
}

@end
