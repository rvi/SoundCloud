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
    
    NSCachedURLResponse *response = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    
    if (response && success)
    {
        UIImage *image = [UIImage imageWithData:response.data];
        
        success (image);
    }
    
    else
    {
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            UIImage *result = [UIImage imageWithData:responseObject];
            
            // set response in cache
            NSCachedURLResponse *response = [[NSCachedURLResponse alloc] initWithResponse:operation.response data:responseObject];
            [[NSURLCache sharedURLCache] storeCachedResponse:response forRequest:request];
            
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
}

+ (void)removeCachedImages
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
