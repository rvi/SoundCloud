//
//  RVArtist.m
//  SoundCloud
//
//  Created by Rémy on 11/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVArtist.h"

#import "NSDictionary+SKParsing.h"

@implementation RVArtist

/**************************************************************************************************/
#pragma mark - Birth & Death

+(RVArtist *)artistWithJSONDict:(NSDictionary *)dict
{
    RVArtist *result = nil;
    
    if ([dict isKindOfClass:[NSDictionary class]])
    {
        result = [[RVArtist alloc] init];
        result.userName = [dict getStringValue:USERNAME_KEY];
        result.pictureURL = [dict getStringValue:USER_PICTURE_KEY];
    }
    return result;
}

@end