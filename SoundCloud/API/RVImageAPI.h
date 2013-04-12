//
//  RVImageAPI.h
//  SoundCloud
//
//  Created by Rémy on 12/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RVImageAPI : NSObject

+ (void)getImageAtURL:(NSString *)imageURL
            succeeded:( void (^) (UIImage *image))success
               failed:(void (^) (NSError *error))failure;

@end
