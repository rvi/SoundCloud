//
//  RVTracksAPI.h
//  SoundCloud
//
//  Created by Rémy on 12/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RVTracksAPI : NSObject

+(void)getTracks:(NSUInteger)numberOfTracks
          offset:(NSUInteger)numberAlreadyDownloaded
       Succeeded:(void (^)(NSArray *tracks))success
          Failed:(void (^)(NSError *error))failure;

@end
