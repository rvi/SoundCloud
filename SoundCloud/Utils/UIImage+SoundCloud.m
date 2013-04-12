//
//  UIImage+SoundCloud.m
//  SoundCloud
//
//  Created by Rémy on 12/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "UIImage+SoundCloud.h"

@implementation UIImage (SoundCloud)

- (UIImage *)cropToRect:(CGRect)cropRect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return image;
}

@end
