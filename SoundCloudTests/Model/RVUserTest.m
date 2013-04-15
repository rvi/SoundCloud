//
//  RVUserTest.m
//  SoundCloud
//
//  Created by Rémy on 14/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVUserTest.h"

#import "RVUser.h"

@implementation RVUserTest

/*
 
 "avatar_url" = "https://i1.sndcdn.com/avatars-000037280302-l37s6t-large.jpg?e48997d";
 city = "<null>";
 country = "<null>";
 description = "<null>";
 "discogs_name" = "<null>";
 "followers_count" = 4;
 "followings_count" = 4;
 "full_name" = "R\U00e9my Virin";
 id = 32816048;
 kind = user;
 "myspace_name" = "<null>";
 online = 1;
 permalink = "r-my-virin";
 "permalink_url" = "http://soundcloud.com/r-my-virin";
 plan = Free;
 "playlist_count" = 0;
 "primary_email_confirmed" = 1;
 "private_playlists_count" = 0;
 "private_tracks_count" = 0;
 "public_favorites_count" = 1;
 quota =     {
 "unlimited_upload_quota" = 0;
 "upload_seconds_left" = 7200;
 "upload_seconds_used" = 0;
 };
 subscriptions =     (
 );
 "track_count" = 0;
 "upload_seconds_left" = 7200;
 uri = "https://api.soundcloud.com/users/32816048";
 username = "R\U00e9my Virin";
 website = "<null>";
 "website_title" = "<null>";

 
 */

/**************************************************************************************************/
#pragma mark - Birth & Death

-(void)setUp
{
    [super setUp];
    
    self.userDict = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"Brenn & Cesar", USERNAME_KEY,
                     @"https://i1.sndcdn.com/avatars-000037280302-l37s6t-large.jpg?e48997d", AVATAR_URL_KEY, nil];
}


-(void)tearDown
{
    [super tearDown];
}

/**************************************************************************************************/
#pragma mark - userWithJSONDict

- (void)testUserWithJSONDictNil_returnNil
{
    // GIVEN
    NSDictionary *dict = nil;
 
    // WHEN
    RVUser *result = [RVUser userWithJSONDict:dict];
 
    // THEN
    STAssertNil(result, nil);
}

- (void)testUserWithJSONDictWithWrongObject_returnNil
{
    // GIVEN
    NSDictionary *dict = [NSArray array];
    
    // WHEN
    RVUser *result = [RVUser userWithJSONDict:dict];
    
    // THEN
    STAssertNil(result, nil);
}

- (void)testUserWithJSONDictWithGoodDict_returnNil
{
    // GIVEN
    NSDictionary *dict = self.userDict;
    
    // WHEN
    RVUser *result = [RVUser userWithJSONDict:dict];
    
    // THEN
    STAssertNotNil(result, nil);
    STAssertEqualObjects(result.pictureURL, @"https://i1.sndcdn.com/avatars-000037280302-l37s6t-large.jpg?e48997d", nil);
    STAssertNil(result.picture, nil);
}

@end
