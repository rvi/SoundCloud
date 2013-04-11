//
//  RVTrack.m
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVTrack.h"

#import "NSDictionary+SKParsing.h"

@implementation RVTrack

/**************************************************************************************************/
#pragma mark - Birth & Death

+(RVTrack *)trackWithJSONDict:(NSDictionary *)dict
{
    RVTrack *result = nil;
    if ([dict isKindOfClass:[NSDictionary class]])
    {
        result = [[RVTrack alloc] init];
        
        result.title = [dict getStringValue:TITLE_KEY];
        result.waveFormURL = [dict getStringValue:WAVEFORM_URL_KEY];
        result.pictureURL = [dict getStringValue:PICTURE_URL_KEY];
    }
    return result;
}


@end
