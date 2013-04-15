//
//  RVTrack.h
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import <Foundation/Foundation.h>

// Model
#import "RVArtist.h"

// JSON KEYS
#define TITLE_KEY @"title"
#define WAVEFORM_URL_KEY @"waveform_url"
#define PICTURE_URL_KEY @"artwork_url"
#define ARTIST_KEY @"user"
#define DATE_KEY @"created_at"
#define PERMALINK_URL_KEY @"permalink_url"
#define TRACK_ID_KEY @"id"

//KVO
#define WAVEFORM_KVO @"waveform"

@interface RVTrack : NSObject

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *waveFormURL;
@property (nonatomic, strong) NSString *pictureURL;
@property (nonatomic, strong) NSString *trackId;
@property (nonatomic, strong) NSString *permalinkURL;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) UIImage *waveform;
@property (nonatomic, strong) RVArtist *artist;

/**************************************************************************************************/
#pragma mark - Birth & Death

+(RVTrack *)trackWithJSONDict:(NSDictionary *)dict;


@end
