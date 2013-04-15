//
//  RVUserAPI.m
//  SoundCloud
//
//  Created by Rémy on 14/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVUserAPI.h"

#import "SCAPI.h"

#define USER_INFO_URL @"https://api.soundcloud.com/me.json"

@implementation RVUserAPI


+ (void)getInfoForUserSucceeded:( void (^) (RVUser *user))success
                         failed:(void (^) (NSError *error))failure
{
    SCAccount *account = [SCSoundCloud account];
    
    SCRequestResponseHandler handler;
    handler = ^(NSURLResponse *response, NSData *data, NSError *error) {
        NSError *jsonError = nil;
        
        if (error && failure)
        {
            failure(error);
        }
        else
        {
            NSJSONSerialization *jsonResponse = [NSJSONSerialization
                                                 JSONObjectWithData:data
                                                 options:0
                                                 error:&jsonError];
            
            
            RVUser *user = nil;
            if (!jsonError && [jsonResponse isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *info = (NSDictionary *)jsonResponse;
                user = [RVUser userWithJSONDict:info];
                
            }
            
            if (user && success)
            {
                success(user);
            }
            else if (failure)
            {
                error = error != nil ? error : jsonError;
                failure(error);
            }
        }
    };
    
    NSString *resourceURL = USER_INFO_URL;
    [SCRequest performMethod:SCRequestMethodGET
                  onResource:[NSURL URLWithString:resourceURL]
             usingParameters:nil
                 withAccount:account
      sendingProgressHandler:nil
             responseHandler:handler];

}

@end
