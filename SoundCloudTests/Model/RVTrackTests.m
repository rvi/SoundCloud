//
//  RVTrackTests.m
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVTrackTests.h"

#import "RVTrack.h"

@implementation RVTrackTests


/**************************************************************************************************/
#pragma mark - Birth & Death

-(void)setUp
{
    [super setUp];
    
    self.track = [NSDictionary dictionaryWithObjectsAndKeys:@"Stendhal Syndrom",TITLE_KEY,
                  @"https://i1.sndcdn.com/avatars-000029501578-hj5nyn-large.jpg",WAVEFORM_URL_KEY,
                   @"https://i1.sndcdn.com/avatars-000029501578-hj5nyn-large.jpg?e48997d", PICTURE_URL_KEY,
                  @"123456", TRACK_ID_KEY,
                  @"http://soundclound.com/track/123", PERMALINK_URL_KEY, nil];
}

-(void)tearDown
{
    self.track = nil;
    [super tearDown];
}

/**************************************************************************************************/
#pragma mark - Tests

- (void)testTrackWithJSONDictWithNil_returnNil
{
    // GIVEN
    NSDictionary *dict = nil;
    
    // WHEN
    RVTrack *result = [RVTrack trackWithJSONDict:dict];
    
    // THEN
    STAssertNil(result, nil);
}

- (void)testTrackWithJSONDictWithArray_returnNil
{
    // GIVEN
    NSDictionary *dict = [NSArray array];
    
    // WHEN
    RVTrack *result = [RVTrack trackWithJSONDict:dict];
    
    // THEN
    STAssertNil(result, nil);
}


- (void)testTrackWithJSONDictWithGoodDict_returnOk
{
    // GIVEN
    NSDictionary *dict = self.track;
    
    // WHEN
    RVTrack *result = [RVTrack trackWithJSONDict:dict];
    
    // THEN
    STAssertNotNil(result, nil);
    STAssertEqualObjects(result.title, @"Stendhal Syndrom", nil);
    STAssertEqualObjects(result.waveFormURL, @"https://i1.sndcdn.com/avatars-000029501578-hj5nyn-large.jpg", nil);
    STAssertEqualObjects(result.pictureURL, @"https://i1.sndcdn.com/avatars-000029501578-hj5nyn-large.jpg?e48997d", nil);
    STAssertEqualObjects(result.trackId, @"123456", nil);
    STAssertEqualObjects(result.permalinkURL, @"http://soundclound.com/track/123", nil);
}


@end
