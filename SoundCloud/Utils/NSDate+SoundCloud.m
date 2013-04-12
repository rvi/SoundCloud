//
//  NSDate+SoundCloud.m
//  SoundCloud
//
//  Created by Rémy on 12/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "NSDate+SoundCloud.h"

@implementation NSDate (SoundCloud)

+ (NSDate *)dateFromString:(NSString *)string
{
// Format type:   "2013/04/12 15:37:38 +0000"
    
    NSDate *date = nil;
    
    if ([string isKindOfClass:[NSString class]])
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss Z"];
        
        date = [formatter dateFromString:string];
        
    }
    return date;

}

@end
