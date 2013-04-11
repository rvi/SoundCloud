//
//  RVArtistTest.m
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVArtistTest.h"

#import "RVArtist.h"

@implementation RVArtistTest

/**************************************************************************************************/
#pragma mark - Birth & Death

-(void)setUp
{
    [super setUp];
    
    self.artist = [NSDictionary dictionaryWithObjectsAndKeys:@"remy",USERNAME_KEY,
                   @"https://i1.sndcdn.com/avatars-000029501578-hj5nyn-large.jpg?e48997d", USER_PICTURE_KEY, nil];
}

-(void)tearDown
{
    [super tearDown];
}

/**************************************************************************************************/
#pragma mark - test

- (void)testArtistWithJSONDictWithNil_returnNil
{
    // GIVEN
    NSDictionary *dict = nil;
    
    // WHEN
    RVArtist *result = [RVArtist artistWithJSONDict:dict];
    
    // THEN
    STAssertNil(result, nil);
}


- (void)testArtistWithJSONDictWithArray_returnNil
{
    // GIVEN
    NSDictionary *dict = [NSArray array];
    
    // WHEN
    RVArtist *result = [RVArtist artistWithJSONDict:dict];
    
    // THEN
    STAssertNil(result, nil);
}

- (void)testArtistWithJSONDictWithGoodDict_return
{
    // GIVEN
    NSDictionary *dict = self.artist;
    
    // WHEN
    RVArtist *result = [RVArtist artistWithJSONDict:dict];
    
    // THEN
    STAssertNotNil(result, nil);
    STAssertEqualObjects(@"remy", result.userName, nil);
    STAssertEqualObjects(@"https://i1.sndcdn.com/avatars-000029501578-hj5nyn-large.jpg?e48997d", result.pictureURL, nil);
}


@end
