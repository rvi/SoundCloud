//
//  RVUserAPI.h
//  SoundCloud
//
//  Created by Rémy on 14/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RVUser.h"

@interface RVUserAPI : NSObject


+ (void)getInfoForUserSucceeded:( void (^) (RVUser *user))success
                         failed:(void (^) (NSError *error))failure;

@end
