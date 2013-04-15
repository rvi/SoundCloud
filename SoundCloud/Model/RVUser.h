//
//  RVUser.h
//  SoundCloud
//
//  Created by Rémy on 14/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import <Foundation/Foundation.h>

// JSON Keys
#define USERNAME_KEY @"username"
#define AVATAR_URL_KEY @"avatar_url"

@interface RVUser : NSObject

/**************************************************************************************************/
#pragma mark - Getters & Setters

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *pictureURL;
@property (nonatomic, strong) UIImage *picture;


/**************************************************************************************************/
#pragma mark - Birth & Death

+ (RVUser *)userWithJSONDict:(NSDictionary *)dict;

@end
