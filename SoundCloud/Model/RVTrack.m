//
//  RVTrack.m
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVTrack.h"

// Parsing
#import "NSDictionary+SKParsing.h"
#import "NSDate+SoundCloud.h"

@implementation RVTrack

/**************************************************************************************************/
#pragma mark - Birth & Death

+(RVTrack *)trackWithJSONDict:(NSDictionary *)dict
{
    RVTrack *result = nil;
    if ([dict isKindOfClass:[NSDictionary class]])
    {
        result = [[RVTrack alloc] init];
        
        result.waveform = nil;
        result.title = [dict getStringValue:TITLE_KEY];
        result.waveFormURL = [dict getStringValue:WAVEFORM_URL_KEY];
        result.pictureURL = [dict getStringValue:PICTURE_URL_KEY];
        result.trackId = [[dict getDecimalNumberValue:TRACK_ID_KEY] stringValue];
        result.permalinkURL = [dict getStringValue:PERMALINK_URL_KEY];
        
        NSString *dateString = [dict getStringValue:DATE_KEY];
        result.date = [NSDate dateFromString:dateString];
        
        NSDictionary *artistDict = [dict objectForKey:ARTIST_KEY];
        result.artist = [RVArtist artistWithJSONDict:artistDict];
    }
    return result;
}

/**************************************************************************************************/
#pragma mark - Description

-(NSString *)description
{
    return [NSString stringWithFormat:@"Track [\r\
            title : %@\r\
            artist : %@]", self.title, self.artist.userName];
}

@end
