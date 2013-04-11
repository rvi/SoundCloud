//
//  RVTrack.h
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import <Foundation/Foundation.h>

// JSON KEYS

#define TITLE_KEY @"title"
#define WAVEFORM_URL_KEY @"waveform_url"
#define PICTURE_URL_KEY @"artwork_url"

@interface RVTrack : NSObject

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *waveFormURL;
@property (nonatomic, strong) NSString *pictureURL;

/**************************************************************************************************/
#pragma mark - Birth & Death

+(RVTrack *)trackWithJSONDict:(NSDictionary *)dict;


@end
