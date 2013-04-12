//
//  RVImageAPI.m
//  SoundCloud
//
//  Created by Rémy on 12/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVImageAPI.h"

// AFNetworking
#import "AFNetworking.h"

@implementation RVImageAPI

+ (void)getImageAtURL:(NSString *)imageURL
            succeeded:( void (^) (UIImage *image))success
               failed:(void (^) (NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:imageURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        UIImage *result = [UIImage imageWithData:responseObject];
        
        if (success)
        {
            success(result);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
        if (failure)
        {
            failure(error);
        }
        
    }];
    
    [operation start];
}

@end
