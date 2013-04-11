/**
 @author RVI
 
 @section Licence
 Copyright 2012 Rémy Virin. All rights reserved.
 
 @section Description
 This category helps us to parse data
 */
#import <Foundation/Foundation.h>

@interface NSDictionary (SKParsing)

- (NSString *)getStringValue:(NSString *)inKey;

- (NSDate *)getDateValue:(NSString *)inKey;

- (NSDecimalNumber *)getDecimalNumberValue:(NSString *)inKey;

- (BOOL)getBoolValue:(NSString *)inKey withDefaultValue:(BOOL)inDefaultValue;

@end