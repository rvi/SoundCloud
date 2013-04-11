//
//  RVArtist.h
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import <Foundation/Foundation.h>

// JSON Key
#define USER_PICTURE_KEY @"avatar_url"
#define USERNAME_KEY @"username"

@interface RVArtist : NSObject

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *pictureURL;

/**************************************************************************************************/
#pragma mark - Birth & Death

+(RVArtist *)artistWithJSONDict:(NSDictionary *)dict;

@end
