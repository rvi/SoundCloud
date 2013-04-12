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

- (NSString *)stringForDisplay
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                               fromDate:self];
    NSInteger year = [components year];
    NSInteger month = [components month];
    NSInteger day = [components day];
    
    return [NSString stringWithFormat:@"%.2d/%.2d/%d",day, month, year];
}

@end
