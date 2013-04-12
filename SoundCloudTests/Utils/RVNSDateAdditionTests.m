//
//  RVNSDateAdditionsTests.m
//  SoundCloud
//
//  Created by Rémy on 12/04/13.
//  Copyright (c) 2013 R√©my Virin. All rights reserved.
//

#import "RVNSDateAdditionTests.h"

#import "NSDate+SoundCloud.h"

@implementation RVNSDateAdditionTests



- (void)testDateFromStringWithNil_returnNil
{
    // GIVEN
    NSString *toParse = nil;
    
    // WHEN
    NSDate *result = [NSDate dateFromString:toParse];
    
    // THEN
    STAssertNil(result, nil);
}

- (void)testDateFromStringWithArray_returnNil
{
    // GIVEN
    NSString *toParse = [NSArray array];
    
    // WHEN
    NSDate *result = [NSDate dateFromString:toParse];
    
    // THEN
    STAssertNil(result, nil);
}

- (void)testDateFromStringWithWrongString_returnNil
{
    // GIVEN
    NSString *toParse = @"foo";
    
    // WHEN
    NSDate *result = [NSDate dateFromString:toParse];
    
    // THEN
    STAssertNil(result, nil);
}

- (void)testDateFromStringWithGoodString_returnGoodDate
{
    // GIVEN
    NSString *toParse = @"2013/04/12 15:37:38 +0000";
    
    // WHEN
    NSDate *result = [NSDate dateFromString:toParse];
    
    // THEN
    STAssertNotNil(result, nil);
}

@end
