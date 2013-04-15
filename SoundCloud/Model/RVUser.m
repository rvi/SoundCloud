//
//  RVUser.m
//  SoundCloud
//
//  Created by Rémy on 14/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVUser.h"

// Parsing
#import "NSDictionary+SKParsing.h"

@implementation RVUser

+ (RVUser *)userWithJSONDict:(NSDictionary *)dict
{
    RVUser *user = nil;
    
    if ([dict isKindOfClass:[NSDictionary class]])
    {
        user = [[RVUser alloc] init];
        
        user.username = [dict getStringValue:USERNAME_KEY];
        user.pictureURL = [dict getStringValue:AVATAR_URL_KEY];
        user.picture = nil;
    }
    return user;
}

@end
