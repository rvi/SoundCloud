//
//  RVTracksAPI.m
//  SoundCloud
//
//  Created by Rémy on 12/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVTracksAPI.h"

// API
#import "SCAPI.h"

// Model
#import "RVTrack.h"

#define TRACKS_URL @"https://api.soundcloud.com/me/favorites.json"

// Params
#define LIMIT_KEY @"limit"
#define OFFSET_KEY @"offset"

@interface RVTracksAPI ()

+ (NSArray *)parseTracks:(NSArray *)jsonTracks;

@end

@implementation RVTracksAPI



+(void)getTracks:(NSUInteger)numberOfTracks
          offset:(NSUInteger)numberAlreadyDownloaded
       Succeeded:(void (^)(NSArray *tracks))success
          Failed:(void (^)(NSError *error))failure
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
            
            NSArray *tracks = nil;
            if (!jsonError && [jsonResponse isKindOfClass:[NSArray class]])
            {
                NSArray *jsonTracks = (NSArray *)jsonResponse;
                
                
                tracks = [self parseTracks:jsonTracks];
            }
            
            if ([tracks count] > 0 && success)
            {
                success(tracks);
            }
            else if (failure)
            {
                error = error != nil ? error : jsonError;
                failure(error);
            }
        }
    };
    
    
    NSString *resourceURL = TRACKS_URL;
    
    NSDictionary *params = @{LIMIT_KEY : [[NSNumber numberWithInteger:numberOfTracks] stringValue],
                             OFFSET_KEY : [[NSNumber numberWithInteger:numberAlreadyDownloaded] stringValue]};
    
    [SCRequest performMethod:SCRequestMethodGET
                  onResource:[NSURL URLWithString:resourceURL]
             usingParameters:params
                 withAccount:account
      sendingProgressHandler:nil
             responseHandler:handler];
}

+ (NSArray *)parseTracks:(NSArray *)jsonTracks
{
    NSMutableArray *tmpTracks = [NSMutableArray array];
    for (NSDictionary *dict in jsonTracks)
    {
        if ([dict isKindOfClass:[NSDictionary class]])
        {
            RVTrack *track = [RVTrack trackWithJSONDict:dict];
            [tmpTracks addObject:track];
        }
    }
    return [NSArray arrayWithArray:tmpTracks];
}

@end